Return-Path: <netdev+bounces-34987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9404B7A65C6
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 15:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CCF21C20F1B
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 13:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD74B374E7;
	Tue, 19 Sep 2023 13:54:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBBE37C8A
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 13:54:37 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2482F2
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 06:54:32 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1d71102a35bso1270063fac.0
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 06:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1695131671; x=1695736471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZ3naDo55PR8iItBKNBpWyknpWxs7bzHI76c2Q18PL0=;
        b=II2nC2bAPWFsU7MTLdLqkZrLDobHKh6nHyaL8NFHkWDTa+Gnfbh/DZiswR5S4ZFZNT
         c+J8wFRp08HICl2oyN5p1plHzdLMXd1qy0XGtFhB4kT4LybXQH4uRPDDaImOHaX6N9N7
         RMfjHJrPNyfZ+TQbejlk3i62Bog7f2koAMfuFfTkidqU8w8oUynuzcWvZ4siVjBs3IUk
         OkNT4t8sYdswfcClbZimQ+PJgGuAaE0w9mizw/Xcn7ofFUYEAVZG7cWQl7wKG3QbIi5+
         xTmQinBN7F9D0yZ4aAZtYhTUpjPfDOy7sdCYz5gP4Y0iMIofmjaQbT/TBhLbtgjo0ByK
         APeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695131671; x=1695736471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZ3naDo55PR8iItBKNBpWyknpWxs7bzHI76c2Q18PL0=;
        b=E1UsRyUrOr0MusXMEyi9fSV4G5x7WjS172cycsi9n9NTwy7dYVtWUEGr+xF83rsv7Y
         9ibRuEmzA9S2riofNbDk/nXwQI7OfID9OiUMPb6GkwqXOO/lqm+b++up8xQt1mXwjpJK
         yoghtJ8d029PFm1Gv+CBIVMRvPN3/S8hjbPn7UD70E6iahraum05pNueXO+AjBSUKiy2
         MiColAewRgQwI8vbNAkOVGmqmiJ/bI19V7zMHDWtPNX5yyC0H+IMwzdGoOBH5t5sec98
         L0GXHcX2sADVFqEajzgpX4C4/Rs6aQ84V3R8Vn0xeiPpCeK45KmPU5vPkCPp6qzr9CYl
         y1Uw==
X-Gm-Message-State: AOJu0Yynn2eYfDqeMMskVMFxxZ5KDWYc+0PKw0u7qSBtKRiFqzqiA/fg
	KGHWAww2cFlspsOZaJMJxcUeWHapfjh3uVRTWtQ=
X-Google-Smtp-Source: AGHT+IHrsZAjckys9dFS1ryWKKC7ORHn5FZs29tsd3A2AHaza5khmqKE9adhnrpIpWYpkm6yrfwQww==
X-Received: by 2002:a05:6870:d695:b0:1d4:cb38:f19e with SMTP id z21-20020a056870d69500b001d4cb38f19emr15157079oap.9.1695131671491;
        Tue, 19 Sep 2023 06:54:31 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:cd1e:1428:689a:5af3])
        by smtp.gmail.com with ESMTPSA id h22-20020a056870a3d600b001ccab369c09sm6004270oak.42.2023.09.19.06.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 06:54:31 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	victor@mojatatu.com,
	Pedro Tammela <pctammela@mojatatu.com>,
	Davide Caratti <dcaratti@redhat.com>
Subject: [PATCH net-next 1/4] selftests/tc-testing: localize test resources
Date: Tue, 19 Sep 2023 10:54:01 -0300
Message-Id: <20230919135404.1778595-2-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230919135404.1778595-1-pctammela@mojatatu.com>
References: <20230919135404.1778595-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As of today, the current tdc architecture creates one netns and uses it
to run all tests. This assumption was embedded into the nsPlugin which
carried over as how the tests were written.

The tdc tests are by definition self contained and can,
theoretically, run in parallel. Even though in the kernel they will
serialize over the rtnl lock, we should expect a significant speedup of the
total wall time for the entire test suite, which is hitting close to
1100 tests at this point.

A first step to achieve this goal is to remove sharing of global resources like
veth/dummy interfaces and the netns. In this patch we 'localize' these
resources on a per test basis. Each test gets it's own netns, VETH/dummy interfaces.
The resources are spawned in the pre_suite phase, where tdc will prepare
all netns and interfaces for all tests. This is done in order to avoid
concurrency issues with netns / interfaces spawning and commands using
them. As tdc progresses, the resources are deleted after each test finishes
executing.

Tests that don't use the nsPlugin still run under the root namespace,
but are now required to manage any external resources like interfaces.
These cannot be parallelized as their definition doesn't allow it.
On the other hand, when using the nsPlugin, tests don't need to create
dummy/veth interfaces as these are handled already.

Tested-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 .../testing/selftests/tc-testing/TdcPlugin.py |   4 +-
 .../tc-testing/plugin-lib/nsPlugin.py         | 185 +++++++++++++-----
 .../tc-testing/plugin-lib/rootPlugin.py       |   4 +-
 .../tc-testing/plugin-lib/valgrindPlugin.py   |   5 +-
 tools/testing/selftests/tc-testing/tdc.py     | 129 ++++++++----
 5 files changed, 229 insertions(+), 98 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/TdcPlugin.py b/tools/testing/selftests/tc-testing/TdcPlugin.py
index 79f3ca8617c9..aae85ce4f776 100644
--- a/tools/testing/selftests/tc-testing/TdcPlugin.py
+++ b/tools/testing/selftests/tc-testing/TdcPlugin.py
@@ -5,10 +5,10 @@ class TdcPlugin:
         super().__init__()
         print(' -- {}.__init__'.format(self.sub_class))
 
-    def pre_suite(self, testcount, testidlist):
+    def pre_suite(self, testcount, testlist):
         '''run commands before test_runner goes into a test loop'''
         self.testcount = testcount
-        self.testidlist = testidlist
+        self.testlist = testlist
         if self.args.verbose > 1:
             print(' -- {}.pre_suite'.format(self.sub_class))
 
diff --git a/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py b/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
index 9539cffa9e5e..78acbfa5af9d 100644
--- a/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
+++ b/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
@@ -3,6 +3,7 @@ import signal
 from string import Template
 import subprocess
 import time
+from functools import cached_property
 from TdcPlugin import TdcPlugin
 
 from tdc_config import *
@@ -12,26 +13,77 @@ class SubPlugin(TdcPlugin):
         self.sub_class = 'ns/SubPlugin'
         super().__init__()
 
-    def pre_suite(self, testcount, testidlist):
-        '''run commands before test_runner goes into a test loop'''
-        super().pre_suite(testcount, testidlist)
+    def pre_suite(self, testcount, testlist):
+        super().pre_suite(testcount, testlist)
 
-        if self.args.namespace:
-            self._ns_create()
-        else:
-            self._ports_create()
+        print("Setting up namespaces and devices...")
 
-    def post_suite(self, index):
-        '''run commands after test_runner goes into a test loop'''
-        super().post_suite(index)
+        original = self.args.NAMES
+
+        for t in testlist:
+            if 'skip' in t and t['skip'] == 'yes':
+                continue
+
+            if 'nsPlugin' not in t['plugins']:
+                continue
+
+            shadow = {}
+            shadow['IP'] = original['IP']
+            shadow['TC'] = original['TC']
+            shadow['NS'] = '{}-{}'.format(original['NS'], t['random'])
+            shadow['DEV0'] = '{}id{}'.format(original['DEV0'], t['id'])
+            shadow['DEV1'] = '{}id{}'.format(original['DEV1'], t['id'])
+            shadow['DUMMY'] = '{}id{}'.format(original['DUMMY'], t['id'])
+            shadow['DEV2'] = original['DEV2']
+            self.args.NAMES = shadow
+
+            if self.args.namespace:
+                self._ns_create()
+            else:
+                self._ports_create()
+
+        self.args.NAMES = original
+
+    def pre_case(self, caseinfo, test_skip):
         if self.args.verbose:
-            print('{}.post_suite'.format(self.sub_class))
+            print('{}.pre_case'.format(self.sub_class))
+
+        if test_skip:
+            return
+
+        # Make sure the netns is visible in the fs
+        while True:
+            self._proc_check()
+            try:
+                ns = self.args.NAMES['NS']
+                f = open('/run/netns/{}'.format(ns))
+                f.close()
+                break
+            except:
+                continue
+
+    def post_case(self):
+        if self.args.verbose:
+            print('{}.post_case'.format(self.sub_class))
 
         if self.args.namespace:
             self._ns_destroy()
         else:
             self._ports_destroy()
 
+    def post_suite(self, index):
+        if self.args.verbose:
+            print('{}.post_suite'.format(self.sub_class))
+
+        # Make sure we don't leak resources
+        for f in os.listdir('/run/netns/'):
+            cmd = self._replace_keywords("$IP netns del {}".format(f))
+
+            if self.args.verbose > 3:
+                print('_exec_cmd:  command "{}"'.format(cmd))
+
+            subprocess.run(cmd, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
+
     def add_args(self, parser):
         super().add_args(parser)
         self.argparser_group = self.argparser.add_argument_group(
@@ -77,18 +129,43 @@ class SubPlugin(TdcPlugin):
             print('adjust_command:  return command [{}]'.format(command))
         return command
 
-    def _ports_create(self):
-        cmd = '$IP link add $DEV0 type veth peer name $DEV1'
-        self._exec_cmd('pre', cmd)
-        cmd = '$IP link set $DEV0 up'
-        self._exec_cmd('pre', cmd)
+    def _ports_create_cmds(self):
+        cmds = []
+
+        cmds.append(self._replace_keywords('link add $DEV0 type veth peer name $DEV1'))
+        cmds.append(self._replace_keywords('link set $DEV0 up'))
+        cmds.append(self._replace_keywords('link add $DUMMY type dummy'))
         if not self.args.namespace:
-            cmd = '$IP link set $DEV1 up'
-            self._exec_cmd('pre', cmd)
+            cmds.append(self._replace_keywords('link set $DEV1 up'))
+
+        return cmds
+
+    def _ports_create(self):
+        self._exec_cmd_batched('pre', self._ports_create_cmds())
+
+    def _ports_destroy_cmd(self):
+        return self._replace_keywords('link del $DEV0')
 
     def _ports_destroy(self):
-        cmd = '$IP link del $DEV0'
-        self._exec_cmd('post', cmd)
+        self._exec_cmd('post', self._ports_destroy_cmd())
+
+    def _ns_create_cmds(self):
+        cmds = []
+
+        if self.args.namespace:
+            ns = self.args.NAMES['NS']
+
+            cmds.append(self._replace_keywords('netns add {}'.format(ns)))
+            cmds.append(self._replace_keywords('link set $DEV1 netns {}'.format(ns)))
+            cmds.append(self._replace_keywords('link set $DUMMY netns {}'.format(ns)))
+            cmds.append(self._replace_keywords('netns exec {} $IP link set $DEV1 up'.format(ns)))
+            cmds.append(self._replace_keywords('netns exec {} $IP link set $DUMMY up'.format(ns)))
+
+            if self.args.device:
+                cmds.append(self._replace_keywords('link set $DEV2 netns {}'.format(ns)))
+                cmds.append(self._replace_keywords('netns exec {} $IP link set $DEV2 up'.format(ns)))
+
+        return cmds
 
     def _ns_create(self):
         '''
@@ -96,18 +173,10 @@ class SubPlugin(TdcPlugin):
         the required network devices for it.
         '''
         self._ports_create()
-        if self.args.namespace:
-            cmd = '$IP netns add {}'.format(self.args.NAMES['NS'])
-            self._exec_cmd('pre', cmd)
-            cmd = '$IP link set $DEV1 netns {}'.format(self.args.NAMES['NS'])
-            self._exec_cmd('pre', cmd)
-            cmd = '$IP -n {} link set $DEV1 up'.format(self.args.NAMES['NS'])
-            self._exec_cmd('pre', cmd)
-            if self.args.device:
-                cmd = '$IP link set $DEV2 netns {}'.format(self.args.NAMES['NS'])
-                self._exec_cmd('pre', cmd)
-                cmd = '$IP -n {} link set $DEV2 up'.format(self.args.NAMES['NS'])
-                self._exec_cmd('pre', cmd)
+        self._exec_cmd_batched('pre', self._ns_create_cmds())
+
+    def _ns_destroy_cmd(self):
+        return self._replace_keywords('netns delete {}'.format(self.args.NAMES['NS']))
 
     def _ns_destroy(self):
         '''
@@ -115,35 +184,49 @@ class SubPlugin(TdcPlugin):
         devices as well)
         '''
         if self.args.namespace:
-            cmd = '$IP netns delete {}'.format(self.args.NAMES['NS'])
-            self._exec_cmd('post', cmd)
+            self._exec_cmd('post', self._ns_destroy_cmd())
+            self._ports_destroy()
+
+    @cached_property
+    def _proc(self):
+        ip = self._replace_keywords("$IP -b -")
+        proc = subprocess.Popen(ip,
+            shell=True,
+            stdin=subprocess.PIPE,
+            env=ENVIR)
+
+        return proc
+
+    def _proc_check(self):
+        proc = self._proc
+
+        proc.poll()
+
+        if proc.returncode is not None and proc.returncode != 0:
+            raise RuntimeError("iproute2 exited with an error code")
 
     def _exec_cmd(self, stage, command):
         '''
         Perform any required modifications on an executable command, then run
         it in a subprocess and return the results.
         '''
-        if '$' in command:
-            command = self._replace_keywords(command)
 
-        self.adjust_command(stage, command)
-        if self.args.verbose:
+        if self.args.verbose > 3:
             print('_exec_cmd:  command "{}"'.format(command))
-        proc = subprocess.Popen(command,
-            shell=True,
-            stdout=subprocess.PIPE,
-            stderr=subprocess.PIPE,
-            env=ENVIR)
-        (rawout, serr) = proc.communicate()
 
-        if proc.returncode != 0 and len(serr) > 0:
-            foutput = serr.decode("utf-8")
-        else:
-            foutput = rawout.decode("utf-8")
+        proc = self._proc
+
+        proc.stdin.write((command + '\n').encode())
+        proc.stdin.flush()
+
+        if self.args.verbose > 3:
+            print('_exec_cmd proc: {}'.format(proc))
+
+        self._proc_check()
 
-        proc.stdout.close()
-        proc.stderr.close()
-        return proc, foutput
+    def _exec_cmd_batched(self, stage, commands):
+        for cmd in commands:
+            self._exec_cmd(stage, cmd)
 
     def _replace_keywords(self, cmd):
         """
diff --git a/tools/testing/selftests/tc-testing/plugin-lib/rootPlugin.py b/tools/testing/selftests/tc-testing/plugin-lib/rootPlugin.py
index e36775bd4d12..8762c0f4a095 100644
--- a/tools/testing/selftests/tc-testing/plugin-lib/rootPlugin.py
+++ b/tools/testing/selftests/tc-testing/plugin-lib/rootPlugin.py
@@ -10,9 +10,9 @@ class SubPlugin(TdcPlugin):
         self.sub_class = 'root/SubPlugin'
         super().__init__()
 
-    def pre_suite(self, testcount, testidlist):
+    def pre_suite(self, testcount, testlist):
         # run commands before test_runner goes into a test loop
-        super().pre_suite(testcount, testidlist)
+        super().pre_suite(testcount, testlist)
 
         if os.geteuid():
             print('This script must be run with root privileges', file=sys.stderr)
diff --git a/tools/testing/selftests/tc-testing/plugin-lib/valgrindPlugin.py b/tools/testing/selftests/tc-testing/plugin-lib/valgrindPlugin.py
index 4bb866575ea1..c6f61649c430 100644
--- a/tools/testing/selftests/tc-testing/plugin-lib/valgrindPlugin.py
+++ b/tools/testing/selftests/tc-testing/plugin-lib/valgrindPlugin.py
@@ -25,9 +25,10 @@ class SubPlugin(TdcPlugin):
         self._tsr = TestSuiteReport()
         super().__init__()
 
-    def pre_suite(self, testcount, testidlist):
+    def pre_suite(self, testcount, testist):
         '''run commands before test_runner goes into a test loop'''
-        super().pre_suite(testcount, testidlist)
+        self.testidlist = [tidx['id'] for tidx in testlist]
+        super().pre_suite(testcount, testlist)
         if self.args.verbose > 1:
             print('{}.pre_suite'.format(self.sub_class))
         if self.args.valgrind:
diff --git a/tools/testing/selftests/tc-testing/tdc.py b/tools/testing/selftests/tc-testing/tdc.py
index b98256f38447..3914caa14de1 100755
--- a/tools/testing/selftests/tc-testing/tdc.py
+++ b/tools/testing/selftests/tc-testing/tdc.py
@@ -16,6 +16,7 @@ import json
 import subprocess
 import time
 import traceback
+import random
 from collections import OrderedDict
 from string import Template
 
@@ -38,12 +39,11 @@ class PluginMgrTestFail(Exception):
 class PluginMgr:
     def __init__(self, argparser):
         super().__init__()
-        self.plugins = {}
+        self.plugins = set()
         self.plugin_instances = []
         self.failed_plugins = {}
         self.argparser = argparser
 
-        # TODO, put plugins in order
         plugindir = os.getenv('TDC_PLUGIN_DIR', './plugins')
         for dirpath, dirnames, filenames in os.walk(plugindir):
             for fn in filenames:
@@ -53,32 +53,43 @@ class PluginMgr:
                     not fn.startswith('.#')):
                     mn = fn[0:-3]
                     foo = importlib.import_module('plugins.' + mn)
-                    self.plugins[mn] = foo
-                    self.plugin_instances.append(foo.SubPlugin())
+                    self.plugins.add(mn)
+                    self.plugin_instances[mn] = foo.SubPlugin()
 
     def load_plugin(self, pgdir, pgname):
         pgname = pgname[0:-3]
+        self.plugins.add(pgname)
+
         foo = importlib.import_module('{}.{}'.format(pgdir, pgname))
-        self.plugins[pgname] = foo
-        self.plugin_instances.append(foo.SubPlugin())
-        self.plugin_instances[-1].check_args(self.args, None)
+
+        # nsPlugin must always be the first one
+        if pgname == "nsPlugin":
+            self.plugin_instances.insert(0, (pgname, foo.SubPlugin()))
+            self.plugin_instances[0][1].check_args(self.args, None)
+        else:
+            self.plugin_instances.append((pgname, foo.SubPlugin()))
+            self.plugin_instances[-1][1].check_args(self.args, None)
 
     def get_required_plugins(self, testlist):
         '''
         Get all required plugins from the list of test cases and return
         all unique items.
         '''
-        reqs = []
+        reqs = set()
         for t in testlist:
             try:
                 if 'requires' in t['plugins']:
                     if isinstance(t['plugins']['requires'], list):
-                        reqs.extend(t['plugins']['requires'])
+                        reqs.update(set(t['plugins']['requires']))
                     else:
-                        reqs.append(t['plugins']['requires'])
+                        reqs.add(t['plugins']['requires'])
+                    t['plugins'] = t['plugins']['requires']
+                else:
+                    t['plugins'] = []
             except KeyError:
+                t['plugins'] = []
                 continue
-        reqs = get_unique_item(reqs)
+
         return reqs
 
     def load_required_plugins(self, reqs, parser, args, remaining):
@@ -115,15 +126,17 @@ class PluginMgr:
         return args
 
     def call_pre_suite(self, testcount, testidlist):
-        for pgn_inst in self.plugin_instances:
+        for (_, pgn_inst) in self.plugin_instances:
             pgn_inst.pre_suite(testcount, testidlist)
 
     def call_post_suite(self, index):
-        for pgn_inst in reversed(self.plugin_instances):
+        for (_, pgn_inst) in reversed(self.plugin_instances):
             pgn_inst.post_suite(index)
 
     def call_pre_case(self, caseinfo, *, test_skip=False):
-        for pgn_inst in self.plugin_instances:
+        for (pgn, pgn_inst) in self.plugin_instances:
+            if pgn not in caseinfo['plugins']:
+                continue
             try:
                 pgn_inst.pre_case(caseinfo, test_skip)
             except Exception as ee:
@@ -133,29 +146,37 @@ class PluginMgr:
                 print('testid is {}'.format(caseinfo['id']))
                 raise
 
-    def call_post_case(self):
-        for pgn_inst in reversed(self.plugin_instances):
+    def call_post_case(self, caseinfo):
+        for (pgn, pgn_inst) in reversed(self.plugin_instances):
+            if pgn not in caseinfo['plugins']:
+                continue
             pgn_inst.post_case()
 
-    def call_pre_execute(self):
-        for pgn_inst in self.plugin_instances:
+    def call_pre_execute(self, caseinfo):
+        for (pgn, pgn_inst) in self.plugin_instances:
+            if pgn not in caseinfo['plugins']:
+                continue
             pgn_inst.pre_execute()
 
-    def call_post_execute(self):
-        for pgn_inst in reversed(self.plugin_instances):
+    def call_post_execute(self, caseinfo):
+        for (pgn, pgn_inst) in reversed(self.plugin_instances):
+            if pgn not in caseinfo['plugins']:
+                continue
             pgn_inst.post_execute()
 
     def call_add_args(self, parser):
-        for pgn_inst in self.plugin_instances:
+        for (pgn, pgn_inst) in self.plugin_instances:
             parser = pgn_inst.add_args(parser)
         return parser
 
     def call_check_args(self, args, remaining):
-        for pgn_inst in self.plugin_instances:
+        for (pgn, pgn_inst) in self.plugin_instances:
             pgn_inst.check_args(args, remaining)
 
-    def call_adjust_command(self, stage, command):
-        for pgn_inst in self.plugin_instances:
+    def call_adjust_command(self, caseinfo, stage, command):
+        for (pgn, pgn_inst) in self.plugin_instances:
+            if pgn not in caseinfo['plugins']:
+                continue
             command = pgn_inst.adjust_command(stage, command)
         return command
 
@@ -177,7 +198,7 @@ def replace_keywords(cmd):
     return subcmd
 
 
-def exec_cmd(args, pm, stage, command):
+def exec_cmd(caseinfo, args, pm, stage, command):
     """
     Perform any required modifications on an executable command, then run
     it in a subprocess and return the results.
@@ -187,9 +208,10 @@ def exec_cmd(args, pm, stage, command):
     if '$' in command:
         command = replace_keywords(command)
 
-    command = pm.call_adjust_command(stage, command)
+    command = pm.call_adjust_command(caseinfo, stage, command)
     if args.verbose > 0:
         print('command "{}"'.format(command))
+
     proc = subprocess.Popen(command,
         shell=True,
         stdout=subprocess.PIPE,
@@ -211,7 +233,7 @@ def exec_cmd(args, pm, stage, command):
     return proc, foutput
 
 
-def prepare_env(args, pm, stage, prefix, cmdlist, output = None):
+def prepare_env(caseinfo, args, pm, stage, prefix, cmdlist, output = None):
     """
     Execute the setup/teardown commands for a test case.
     Optionally terminate test execution if the command fails.
@@ -229,7 +251,7 @@ def prepare_env(args, pm, stage, prefix, cmdlist, output = None):
         if not cmd:
             continue
 
-        (proc, foutput) = exec_cmd(args, pm, stage, cmd)
+        (proc, foutput) = exec_cmd(caseinfo, args, pm, stage, cmd)
 
         if proc and (proc.returncode not in exit_codes):
             print('', file=sys.stderr)
@@ -352,6 +374,10 @@ def find_in_json_other(res, outputJSONVal, matchJSONVal, matchJSONKey=None):
 
 def run_one_test(pm, args, index, tidx):
     global NAMES
+    ns = NAMES['NS']
+    dev0 = NAMES['DEV0']
+    dev1 = NAMES['DEV1']
+    dummy = NAMES['DUMMY']
     result = True
     tresult = ""
     tap = ""
@@ -366,38 +392,42 @@ def run_one_test(pm, args, index, tidx):
             res.set_result(ResultState.skip)
             res.set_errormsg('Test case designated as skipped.')
             pm.call_pre_case(tidx, test_skip=True)
-            pm.call_post_execute()
+            pm.call_post_execute(tidx)
             return res
 
     if 'dependsOn' in tidx:
         if (args.verbose > 0):
             print('probe command for test skip')
-        (p, procout) = exec_cmd(args, pm, 'execute', tidx['dependsOn'])
+        (p, procout) = exec_cmd(tidx, args, pm, 'execute', tidx['dependsOn'])
         if p:
             if (p.returncode != 0):
                 res = TestResult(tidx['id'], tidx['name'])
                 res.set_result(ResultState.skip)
                 res.set_errormsg('probe command: test skipped.')
                 pm.call_pre_case(tidx, test_skip=True)
-                pm.call_post_execute()
+                pm.call_post_execute(tidx)
                 return res
 
     # populate NAMES with TESTID for this test
     NAMES['TESTID'] = tidx['id']
+    NAMES['NS'] = '{}-{}'.format(NAMES['NS'], tidx['random'])
+    NAMES['DEV0'] = '{}id{}'.format(NAMES['DEV0'], tidx['id'])
+    NAMES['DEV1'] = '{}id{}'.format(NAMES['DEV1'], tidx['id'])
+    NAMES['DUMMY'] = '{}id{}'.format(NAMES['DUMMY'], tidx['id'])
 
     pm.call_pre_case(tidx)
-    prepare_env(args, pm, 'setup', "-----> prepare stage", tidx["setup"])
+    prepare_env(tidx, args, pm, 'setup', "-----> prepare stage", tidx["setup"])
 
     if (args.verbose > 0):
         print('-----> execute stage')
-    pm.call_pre_execute()
-    (p, procout) = exec_cmd(args, pm, 'execute', tidx["cmdUnderTest"])
+    pm.call_pre_execute(tidx)
+    (p, procout) = exec_cmd(tidx, args, pm, 'execute', tidx["cmdUnderTest"])
     if p:
         exit_code = p.returncode
     else:
         exit_code = None
 
-    pm.call_post_execute()
+    pm.call_post_execute(tidx)
 
     if (exit_code is None or exit_code != int(tidx["expExitCode"])):
         print("exit: {!r}".format(exit_code))
@@ -409,7 +439,7 @@ def run_one_test(pm, args, index, tidx):
     else:
         if args.verbose > 0:
             print('-----> verify stage')
-        (p, procout) = exec_cmd(args, pm, 'verify', tidx["verifyCmd"])
+        (p, procout) = exec_cmd(tidx, args, pm, 'verify', tidx["verifyCmd"])
         if procout:
             if 'matchJSON' in tidx:
                 verify_by_json(procout, res, tidx, args, pm)
@@ -431,13 +461,20 @@ def run_one_test(pm, args, index, tidx):
         else:
             res.set_result(ResultState.success)
 
-    prepare_env(args, pm, 'teardown', '-----> teardown stage', tidx['teardown'], procout)
-    pm.call_post_case()
+    prepare_env(tidx, args, pm, 'teardown', '-----> teardown stage', tidx['teardown'], procout)
+    pm.call_post_case(tidx)
 
     index += 1
 
     # remove TESTID from NAMES
     del(NAMES['TESTID'])
+
+    # Restore names
+    NAMES['NS'] = ns
+    NAMES['DEV0'] = dev0
+    NAMES['DEV1'] = dev1
+    NAMES['DUMMY'] = dummy
+
     return res
 
 def test_runner(pm, args, filtered_tests):
@@ -461,7 +498,7 @@ def test_runner(pm, args, filtered_tests):
     tsr = TestSuiteReport()
 
     try:
-        pm.call_pre_suite(tcount, [tidx['id'] for tidx in testlist])
+        pm.call_pre_suite(tcount, testlist)
     except Exception as ee:
         ex_type, ex, ex_tb = sys.exc_info()
         print('Exception {} {} (caught in pre_suite).'.
@@ -661,7 +698,6 @@ def get_id_list(alltests):
     """
     return [x["id"] for x in alltests]
 
-
 def check_case_id(alltests):
     """
     Check for duplicate test case IDs.
@@ -683,7 +719,6 @@ def generate_case_ids(alltests):
     If a test case has a blank ID field, generate a random hex ID for it
     and then write the test cases back to disk.
     """
-    import random
     for c in alltests:
         if (c["id"] == ""):
             while True:
@@ -742,6 +777,9 @@ def filter_tests_by_category(args, testlist):
 
     return answer
 
+def set_random(alltests):
+    for tidx in alltests:
+        tidx['random'] = random.getrandbits(32)
 
 def get_test_cases(args):
     """
@@ -840,6 +878,8 @@ def set_operation_mode(pm, parser, args, remaining):
         list_test_cases(alltests)
         exit(0)
 
+    set_random(alltests)
+
     exit_code = 0 # KSFT_PASS
     if len(alltests):
         req_plugins = pm.get_required_plugins(alltests)
@@ -883,6 +923,13 @@ def main():
     Start of execution; set up argument parser and get the arguments,
     and start operations.
     """
+    import resource
+
+    if sys.version_info.major < 3 or sys.version_info.minor < 8:
+        sys.exit("tdc requires at least python 3.8")
+
+    resource.setrlimit(resource.RLIMIT_NOFILE, (1048576, 1048576))
+
     parser = args_parse()
     parser = set_args(parser)
     pm = PluginMgr(parser)
-- 
2.39.2


