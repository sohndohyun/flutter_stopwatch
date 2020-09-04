import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer _timer;
  int _time = 0;
  bool _isRunning = false;
  List<String> _lapTimes = <String>[];

  @override
  void dispose(){
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stop Watch'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        (_time ~/ 100).toString(),
                        style: const TextStyle(fontSize: 50),
                      ),
                      Text('${_time % 100}'.padLeft(2, '0')),
                    ],
                  ),
                  Container(
                    width: 100,
                    height: 200,
                    child: ListView(
                      children: _lapTimes.map((String time) => Text(time)).toList(),
                    ),
                  )
                ],
              ),
              Positioned(
                left: 10,
                bottom: 20,
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      _isRunning = false;
                      _timer?.cancel();
                      _lapTimes.clear();
                      _time = 0;
                    });
                  },
                  child: const Text('초기화'),
                ),
              ),
              Positioned(
                right: 10,
                bottom: 20,
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      if(_isRunning)
                        _lapTimes.insert(0, '${_lapTimes.length + 1}등 : ${_time ~/ 100}.${_time % 100}');
                    });
                  },
                  child: const Text('랩타임'),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
        onPressed: () {
          setState(() {
            _isRunning = !_isRunning;
            if(_isRunning){
              _timer = Timer.periodic(const Duration(milliseconds: 10), (Timer timer) {
                setState(() {
                  _time++;
                });
              });
            }
            else{
              _timer?.cancel();
            }
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _clickButton() {

  }
}
