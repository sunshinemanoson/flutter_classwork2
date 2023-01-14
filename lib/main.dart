import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        key: UniqueKey(),
        title: 'Flutter demo app',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Data {
  late int id;
  late String name;
  late DateTime time;
  Data(this.id, this.name, this.time);
}

class _MyHomePageState extends State<MyHomePage> {
  String txt = "N/A";
  String txt2 = "N/A";
  int Select = 0;
  late int catId = 0;
  List<String> mylist = <String>[];
  final myController = TextEditingController();
  final Name = TextEditingController();
  final dateInputController = TextEditingController();

  void _RadioValues(int? value) {
    setState(() {
      Select = value!;
    });
  }

  void _addPet() {
    setState(() {
      txt = "Add Cat Total: ($Select)";
      mylist.add(Select.toString());
    });
  }

  void _removeItem() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove a lovely Cat ID: '),
          content: Text(
            myController.text,
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child:
                  const Text('Remove', style: TextStyle(color: Colors.white)),
              onPressed: () {
                setState(() {
                  setState(() {
                    mylist.remove(myController.text);
                  });
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("list exmple"),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Radio(
                  value: 1,
                  groupValue: Select,
                  onChanged: _RadioValues,
                ),
                const CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage('assets/images/pet1.jpg'),
                ),
                Radio(
                  value: 2,
                  groupValue: Select,
                  onChanged: _RadioValues,
                ),
                const CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage('assets/images/pet2.jpg'),
                ),
                Radio(
                  value: 3,
                  groupValue: Select,
                  onChanged: _RadioValues,
                ),
                const CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage('assets/images/pet3.jpg'),
                ),
                Radio(
                  value: 4,
                  groupValue: Select,
                  onChanged: _RadioValues,
                ),
                const CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage('assets/images/pet4.jpg'),
                ),
                Radio(
                  value: 5,
                  groupValue: Select,
                  onChanged: _RadioValues,
                ),
                const CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage('assets/images/pet5.jpg'),
                ),
              ],
            ),
            TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your Pet Id: '),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: myController,
            ),

            const Padding(
              padding: EdgeInsets.all(7.0),
            ),
            TextFormField(
              controller: Name,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Enter your Name: '),
            ),
            const Padding(
              padding: EdgeInsets.all(7.0),
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Date',
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 33, 233, 243), width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1)),
              ),
              controller: dateInputController,
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2050));

                if (pickedDate != null) {
                  dateInputController.text = pickedDate.toString();
                }
              },
            ),
            const Padding(
              padding: EdgeInsets.all(7.0),
            ),
            // perform some action with the input value her
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: _addPet,
              child: const Text('Add Item'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: _removeItem,
              child: const Text('Remove'),
            ),
            Text(
              txt,
              textScaleFactor: 1,
            ),
            SizedBox(
              width: double.infinity,
              height: 600,
              child: ListView.builder(
                  itemCount: mylist.length,
                  itemBuilder: ((context, index) {
                    return SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color:
                            Colors.primaries[index % Colors.primaries.length],
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(
                              'assets/images/pet${mylist[index]}.jpg',
                            ),
                          ),
                          title:
                              Text("Name: ${Name.text} (ID:${mylist[index]}) "),
                          subtitle:
                              Text("Date Detail: ${dateInputController.text}"),
                          trailing: const Icon(Icons.delete_rounded),
                          onTap: () {
                            setState(() {
                              txt = "Title ($Select)";
                              mylist.remove(
                                  "Removed item ${mylist.removeAt(index)}");
                            });
                          },
                        ),
                      ),
                    );
                  })),
            ),
          ],
        ));
  }
}
