Return-Path: <netdev+bounces-28516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 861EC77FAAB
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 17:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B7E28204A
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 15:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB9915494;
	Thu, 17 Aug 2023 15:24:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0F01548B
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 15:24:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE2DE56;
	Thu, 17 Aug 2023 08:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692285863; x=1723821863;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=6aX94Q99bZs4q9hs4IK0tTmzrNr2pLUa/TdLhwl6NPA=;
  b=GeChW6W8GUy4mDOi8NLAaFoKnoWk2wyhFHFtm5n29ujBEAEVg33b/FuC
   VKeY7gTVY5l5hKDaDQtjOokbLxPhleI99XvWW8tUeocINy0/8kE3s435I
   KYdZDM+kQZVa+sfSPIsP0w0t1QcgrRlsbeSAwl7lpmuSK8oYsZXaoJC50
   pgknDS5oObySx6oL4Oha0AZEH6KKtLX7crO3+33BUsCwWNGhzXmfZePFJ
   wzqg9wZOAnno8KXkQ1VF0XsuDaSXfHWge47c6kfdg2cHtV782FU20Yeaz
   6zSynT3wv2uIyqGY+spw7Wx2LAW/9L8H17CaFtcV6dWBBtLq/k0IiMxgy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="436758822"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="436758822"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 08:24:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="734694207"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="734694207"
Received: from mmichali-devpc.igk.intel.com ([10.211.235.239])
  by orsmga002.jf.intel.com with ESMTP; 17 Aug 2023 08:24:19 -0700
From: Michal Michalik <michal.michalik@intel.com>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	kuba@kernel.org,
	jiri@resnulli.us,
	arkadiusz.kubalewski@intel.com,
	jonathan.lemon@gmail.com,
	pabeni@redhat.com,
	poros@redhat.com,
	milena.olech@intel.com,
	mschmidt@redhat.com,
	linux-clk@vger.kernel.org,
	bvanassche@acm.org,
	Michal Michalik <michal.michalik@intel.com>
Subject: [PATCH RFC net-next v1 2/2] selftests/dpll: add DPLL system integration selftests
Date: Thu, 17 Aug 2023 17:22:09 +0200
Message-Id: <20230817152209.23868-3-michal.michalik@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20230817152209.23868-1-michal.michalik@intel.com>
References: <20230817152209.23868-1-michal.michalik@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The tests are written in Python3 (3.7+) and pytest testing framework.
Framework is basing on the ynl library available in the kernel tree
at: tools/net/ynl

High level flow of DPLL subsystem integration selftests:
(after running run_dpll_tests.sh or 'make -C tools/testing/selftests')
1) check if Python in correct version is installed,
2) create temporary Python virtual environment,
3) install all the required libraries,
4) run the tests,
5) do cleanup.

The DPLL system integration tests are meant to be part of selftests, so
they can be build and run using command:
  make -C tools/testing/selftests
  make -C tools/testing/selftests run_tests

Alternatively, they can be run using single command [1]:
  make kselftest

If we want to run only DPLL tests, we should set the TARGETS variable:
  make -C tools/testing/selftests TARGETS=dpll
  make -C tools/testing/selftests TARGETS=dpll run_tests

They can also be run standalone using starter script:
  ./run_dpll_tests.sh

There is a possibliy to set optional PYTEST_PARAMS environment variable
to set the pytest options, like tests filtering ("-k <filter>") or
verbose output ("-v").

[1] https://www.kernel.org/doc/html/v5.0/dev-tools/kselftest.html

Signed-off-by: Michal Michalik <michal.michalik@intel.com>
---
 tools/testing/selftests/Makefile                 |   1 +
 tools/testing/selftests/dpll/Makefile            |  11 +
 tools/testing/selftests/dpll/__init__.py         |   0
 tools/testing/selftests/dpll/config              |   1 +
 tools/testing/selftests/dpll/consts.py           |  34 ++
 tools/testing/selftests/dpll/dpll_utils.py       | 104 ++++++
 tools/testing/selftests/dpll/requirements.txt    |   3 +
 tools/testing/selftests/dpll/run_dpll_tests.sh   |  75 +++++
 tools/testing/selftests/dpll/test_dpll.py        | 385 +++++++++++++++++++++++
 tools/testing/selftests/dpll/ynlfamilyhandler.py |  49 +++
 10 files changed, 663 insertions(+)
 create mode 100644 tools/testing/selftests/dpll/Makefile
 create mode 100644 tools/testing/selftests/dpll/__init__.py
 create mode 100644 tools/testing/selftests/dpll/config
 create mode 100644 tools/testing/selftests/dpll/consts.py
 create mode 100644 tools/testing/selftests/dpll/dpll_utils.py
 create mode 100644 tools/testing/selftests/dpll/requirements.txt
 create mode 100755 tools/testing/selftests/dpll/run_dpll_tests.sh
 create mode 100644 tools/testing/selftests/dpll/test_dpll.py
 create mode 100644 tools/testing/selftests/dpll/ynlfamilyhandler.py

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 5c60a7c..0f75009 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -13,6 +13,7 @@ TARGETS += core
 TARGETS += cpufreq
 TARGETS += cpu-hotplug
 TARGETS += damon
+TARGETS += dpll
 TARGETS += drivers/dma-buf
 TARGETS += drivers/s390x/uvdevice
 TARGETS += drivers/net/bonding
diff --git a/tools/testing/selftests/dpll/Makefile b/tools/testing/selftests/dpll/Makefile
new file mode 100644
index 0000000..8a7b544
--- /dev/null
+++ b/tools/testing/selftests/dpll/Makefile
@@ -0,0 +1,11 @@
+ifndef KSRC
+	KSRC:=${shell git rev-parse --show-toplevel}
+endif
+
+build:
+	./modules_handler.sh build
+
+run_tests:
+	./run_dpll_tests.sh
+
+.PHONY: build run_tests
\ No newline at end of file
diff --git a/tools/testing/selftests/dpll/__init__.py b/tools/testing/selftests/dpll/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/tools/testing/selftests/dpll/config b/tools/testing/selftests/dpll/config
new file mode 100644
index 0000000..44df39b4
--- /dev/null
+++ b/tools/testing/selftests/dpll/config
@@ -0,0 +1 @@
+CONFIG_DPLL=y
\ No newline at end of file
diff --git a/tools/testing/selftests/dpll/consts.py b/tools/testing/selftests/dpll/consts.py
new file mode 100644
index 0000000..838ce58
--- /dev/null
+++ b/tools/testing/selftests/dpll/consts.py
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Constants useful in DPLL system integration testing.
+#
+# Copyright (c) 2023, Intel Corporation.
+# Author: Michal Michalik <michal.michalik@intel.com>
+
+import os
+from enum import Enum
+
+
+KSRC = os.environ.get('KSRC', '')
+YNLPATH = 'tools/net/ynl/'
+YNLSPEC = 'Documentation/netlink/specs/dpll.yaml'
+
+
+class DPLL_TYPE(Enum):
+    PPS = 1
+    EEC = 2
+
+
+class DPLL_LOCK_STATUS(Enum):
+    UNLOCKED = 1
+    LOCKED = 2
+    LOCKED_HO_ACK = 3
+    HOLDOVER = 4
+
+
+class DPLL_PIN_TYPE(Enum):
+    MUX = 1,
+    EXT = 2
+    SYNCE_ETH_PORT = 3
+    INT_OSCILLATOR = 4
+    GNSS = 5
diff --git a/tools/testing/selftests/dpll/dpll_utils.py b/tools/testing/selftests/dpll/dpll_utils.py
new file mode 100644
index 0000000..4f56fa83
--- /dev/null
+++ b/tools/testing/selftests/dpll/dpll_utils.py
@@ -0,0 +1,104 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Utilities useful in DPLL system integration testing.
+#
+# Copyright (c) 2023, Intel Corporation.
+# Author: Michal Michalik <michal.michalik@intel.com>
+
+import re
+import pytest
+import subprocess
+
+from .ynlfamilyhandler import YnlFamilyHandler
+
+
+def parse_header(filepath):
+    FILTER = ('(u32)', '(u64)', '(', ')')
+
+    with open(filepath) as f:
+        header = f.read()
+
+    items = {}
+    matches = re.findall(r'''\#define
+                             \s+?
+                             ([\w\d]*)  # key
+                             \s+?
+                             ([\w\d)()"]+)  # value
+                          ''', header, re.MULTILINE | re.VERBOSE)
+    for key, value in matches:
+        for f in FILTER:
+            value = value.replace(f, '')
+        if value.isnumeric():
+            items[key] = int(value)
+        elif not value:
+            items[key] = True  # let's just treat it as a flag
+        else:
+            items[key] = value
+
+    return items
+
+
+def load_driver(script, driver):
+    try:
+        subprocess.run([script, 'load', driver], check=True)
+    except subprocess.CalledProcessError as e:
+        pytest.exit(f'Failed to load the test module: "{e}"')
+
+
+def unload_driver(script, driver):
+    try:
+        subprocess.run([script, 'unload', driver], check=True)
+    except subprocess.CalledProcessError as e:
+        pytest.exit(f'Failed to unload the test module: "{e}"')
+
+
+def get_dpll_id(clock_id, test_module, type):
+    yfh = YnlFamilyHandler()
+    yfh.do = 'device-id-get'
+    yfh.attrs = {
+        'module-name': test_module,
+        'clock-id': clock_id,
+        'type': type
+        }
+    return yfh.execute()['id']
+
+
+def get_dpll(clock_id, test_module, type):
+    _id = get_dpll_id(clock_id, test_module, type)
+    yfh = YnlFamilyHandler()
+    yfh.do = 'device-get'
+    yfh.attrs = {'id': _id}
+    return yfh.execute()
+
+
+def get_all_pins():
+    yfh = YnlFamilyHandler()
+    yfh.dump = 'pin-get'
+    return yfh.execute()
+
+
+def get_pin_id(test_module, clock_id, board_l, panel_l, package, type):
+    yfh = YnlFamilyHandler()
+    yfh.do = 'pin-id-get'
+    yfh.attrs = {'module-name': test_module,
+                 'clock-id': clock_id,
+                 'pin-board-label': board_l,
+                 'pin-panel-label': panel_l,
+                 'pin-package-label': package,
+                 'pin-type': type}
+    return yfh.execute()['pin-id']
+
+
+def get_pin(_id):
+    yfh = YnlFamilyHandler()
+    yfh.do = 'pin-get'
+    yfh.attrs = {'pin-id': _id}
+    return yfh.execute()
+
+
+def set_pin(_id, params):
+    yfh = YnlFamilyHandler()
+    yfh.do = 'pin-set'
+    yfh.attrs = params
+    yfh.attrs['pin-id'] = _id
+    return yfh.execute()
diff --git a/tools/testing/selftests/dpll/requirements.txt b/tools/testing/selftests/dpll/requirements.txt
new file mode 100644
index 0000000..73180b8
--- /dev/null
+++ b/tools/testing/selftests/dpll/requirements.txt
@@ -0,0 +1,3 @@
+jsonschema==4.*
+PyYAML==6.*
+pytest==7.*
diff --git a/tools/testing/selftests/dpll/run_dpll_tests.sh b/tools/testing/selftests/dpll/run_dpll_tests.sh
new file mode 100755
index 0000000..c701d40
--- /dev/null
+++ b/tools/testing/selftests/dpll/run_dpll_tests.sh
@@ -0,0 +1,75 @@
+#!/usr/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Wraper script for running the DPLL system integration tests.
+#
+# The script check if all the requirements are fulfilled before running pytest.
+#
+# Copyright (c) 2023, Intel Corporation.
+# Author: Michal Michalik <michal.michalik@intel.com>
+
+ENOPKG=65  # Package not installed
+TEMP_VENV=$(mktemp -u)
+KSRC=${KSRC:-$(git rev-parse --show-toplevel)}
+PYTHON=${PYTHON:-python3}
+
+cleanup() {
+    [ -n "$VIRTUAL_ENV" ] && deactivate
+
+    if [[ -d "$TEMP_VENV" ]]; then
+        echo "Removing temporary virtual environment ($TEMP_VENV)"
+        rm -r "$TEMP_VENV"
+    else
+        echo "Temporary virtual environment does not exist"
+    fi
+}
+
+skip () {
+    cleanup
+    echo "SKIP: $1"
+    exit $2
+}
+
+# 1) To run tests, we need Python 3 installed
+which $PYTHON 2>&1 1> /dev/null
+if [[ $? -ne 0 ]]; then
+    skip "Python 3 is not installed" $ENOPKG
+fi
+
+# 2) ...at least Python 3.7 (2018)
+$PYTHON -c "import sys;vi=sys.version_info;
+sys.exit(0) if vi[0] == 3 and vi[1] >= 7 else sys.exit(1)"
+if [[ $? -ne 0 ]]; then
+    skip "At least Python 3.7 is required (set PYTHON for custom path)" $ENOPKG
+fi
+
+# 3) Let's make sure we have controlled environment (virtual environment)
+#   a) Create venv
+$PYTHON -m venv $TEMP_VENV
+if [[ $? -ne 0 ]]; then
+    skip "Could not create virtual environment" $ENOPKG
+fi
+
+#   b) Activate venv
+source $TEMP_VENV/bin/activate
+if [[ $? -ne 0 ]]; then
+    skip "Could not activate the virtual environment" $ENOPKG
+fi
+
+#   c) Install the exact packages versions we need
+pip install -r requirements.txt
+if [[ $? -ne 0 ]]; then
+    skip "Could not install the required packages" $ENOPKG
+fi
+
+# 4) Finally, run the tests!
+KSRC=$KSRC pytest $PYTEST_PARAMS
+result=$?
+if [[ $result -ne 0 ]]; then
+    echo "ERROR: Some of the DPLL tests failed"
+fi
+
+# 5) Clean up after execution
+cleanup
+
+exit $result
diff --git a/tools/testing/selftests/dpll/test_dpll.py b/tools/testing/selftests/dpll/test_dpll.py
new file mode 100644
index 0000000..4f70c07
--- /dev/null
+++ b/tools/testing/selftests/dpll/test_dpll.py
@@ -0,0 +1,385 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# System integration tests for DPLL interface.
+#
+# Can be used directly, but strongly suggest using wrapper: run_dpll_tests.sh
+# The wrapper takes care about fulfilling all the requirements needed to
+# run all the tests.
+#
+# Copyright (c) 2023, Intel Corporation.
+# Author: Michal Michalik <michal.michalik@intel.com>
+
+import pytest
+import subprocess
+from pathlib import Path
+
+from .consts import DPLL_TYPE, DPLL_LOCK_STATUS, DPLL_PIN_TYPE
+from .dpll_utils import parse_header, load_driver, unload_driver, \
+    get_dpll, get_dpll_id, get_pin_id, get_all_pins, get_pin, set_pin
+from .ynlfamilyhandler import YnlFamilyHandler
+from lib.ynl import NlError
+
+
+SCRIPT_PATH = './modules_handler.sh'
+TEST_MODULE_DIR = 'dpll_modules'
+TEST_MODULE = 'dpll_test'
+
+
+class TestDPLL:
+    @classmethod
+    def setup_class(cls):
+        cls.module_consts = parse_header(Path(TEST_MODULE_DIR) / f'{TEST_MODULE}.h')
+        load_driver(SCRIPT_PATH, TEST_MODULE)
+
+    @classmethod
+    def teardown_class(cls):
+        unload_driver(SCRIPT_PATH, TEST_MODULE)
+
+    def test_if_module_is_loaded(self):
+        '''
+        Checks if the module is successfully loaded at all. It should be already
+        covered in the class setup (raise exception) - but just to make sure.
+        '''
+        s = subprocess.run(['lsmod'], check=True, capture_output=True)
+        assert TEST_MODULE in str(s.stdout)
+
+    def test_get_two_dplls(self):
+        '''
+        Checks if the netlink is returning the expected DPLLs. We need to make
+        sure that even if "other" DPLLs exist in the system we check only ours.
+        '''
+        yfh = YnlFamilyHandler()
+        yfh.dump = 'device-get'
+        reply = yfh.execute()
+
+        dplls = filter(lambda i: TEST_MODULE == i['module-name'], reply)
+        assert len(list(dplls)) == 2
+
+    def test_get_two_distinct_dplls(self):
+        '''
+        Checks if the netlink is returning the expected, distinct DPLLs created
+        by the tested module. We expect EEC and PPS ones.
+        '''
+        yfh = YnlFamilyHandler()
+        yfh.dump = 'device-get'
+        reply = yfh.execute()
+
+        dplls = filter(lambda i: TEST_MODULE in i['module-name'], reply)
+        types = set(i['type'] for i in dplls)
+
+        assert types == {'eec', 'pps'}
+
+    @pytest.mark.parametrize("dtype", [DPLL_TYPE.EEC, DPLL_TYPE.PPS])
+    def test_finding_dpll_id(self, dtype):
+        '''
+        Checks if we are able to find the DPLL id using 'device-id-get' do cmd.
+        '''
+        _id = get_dpll_id(self.module_consts['DPLLS_CLOCK_ID'], TEST_MODULE,
+                          dtype.value)
+        assert isinstance(_id, int)
+
+    @pytest.mark.parametrize("clk,dtype,exc", [(123, DPLL_TYPE.EEC.value, KeyError),
+                                               (234, 4, NlError),
+                                               (123, 4, NlError)])
+    def test_finding_fails_correctly(self, clk, dtype, exc):
+        '''
+        Make sure the DPLL interface does not return any garbage on incorrect
+        input like wrong DPLL type or clock id.
+        '''
+        with pytest.raises(exc):
+            get_dpll_id(clk, TEST_MODULE, dtype)
+
+    @pytest.mark.parametrize("dtype", [DPLL_TYPE.EEC, DPLL_TYPE.PPS])
+    def test_get_only_one_dpll(self, dtype):
+        '''
+        Checks if the netlink is returning the expected DPLLs created
+        by the tested module, filtered on input. We expect EEC and PPS here.
+        '''
+        _id = get_dpll_id(self.module_consts['DPLLS_CLOCK_ID'], TEST_MODULE,
+                          dtype.value)
+
+        yfh = YnlFamilyHandler()
+        yfh.do = 'device-get'
+        yfh.attrs = {'id': _id}
+        reply = yfh.execute()
+
+        assert reply['type'] == dtype.name.lower()
+
+    @pytest.mark.parametrize("dtype", [DPLL_TYPE.EEC, DPLL_TYPE.PPS])
+    def test_get_temperature(self, dtype):
+        '''
+        Checks if we are able to get correct DPLL temperature for both DPLLs.
+        '''
+        if dtype == DPLL_TYPE.EEC:
+            desired_temp = self.module_consts['EEC_DPLL_TEMPERATURE']
+        else:
+            desired_temp = self.module_consts['PPS_DPLL_TEMPERATURE']
+
+        dpll = get_dpll(self.module_consts['DPLLS_CLOCK_ID'], TEST_MODULE,
+                        dtype.value)
+
+        assert dpll['temp'] == desired_temp
+
+    @pytest.mark.parametrize("dtype, lock", [(DPLL_TYPE.EEC, DPLL_LOCK_STATUS.UNLOCKED),
+                                             (DPLL_TYPE.PPS, DPLL_LOCK_STATUS.LOCKED)])
+    def test_get_lock(self, dtype, lock):
+        '''
+        Checks if we are able to get correct DPLL lock status for both DPLLs.
+        '''
+        dpll = get_dpll(self.module_consts['DPLLS_CLOCK_ID'], TEST_MODULE,
+                        dtype.value)
+        assert dpll['lock-status'] == lock.name.lower()
+
+    @pytest.mark.parametrize("dtype", [DPLL_TYPE.EEC, DPLL_TYPE.PPS])
+    def test_dump_pins_in_each_dpll(self, dtype):
+        '''
+        Checks if we are able to dump all pins for each DPLL separetely,
+        filtered on output.
+        '''
+        if dtype == DPLL_TYPE.EEC:
+            desired_pins = self.module_consts['EEC_PINS_NUMBER']
+        else:
+            desired_pins = self.module_consts['PPS_PINS_NUMBER']
+
+        dpll = get_dpll(self.module_consts['DPLLS_CLOCK_ID'], TEST_MODULE,
+                        dtype.value)
+
+        yfh = YnlFamilyHandler()
+        yfh.dump = 'pin-get'
+        reply = yfh.execute()
+
+        pins = filter(lambda p: any(i['id'] == dpll['id']
+                      for i in p.get('pin-parent-device', [])), reply)
+
+        assert len(list(pins)) == desired_pins
+
+    def test_dump_all_pins_in_both_dplls(self):
+        '''
+        Checks if we are able to dump all pins for both DPLLs, filtered by
+        clock id on output.
+        '''
+        desired_pins = self.module_consts['EEC_PINS_NUMBER']  # all are in EEC
+        clock_id = self.module_consts['DPLLS_CLOCK_ID']
+
+        reply = get_all_pins()
+
+        pins = filter(lambda p: p['clock-id'] == clock_id, reply)
+
+        assert len(list(pins)) == desired_pins
+
+    @pytest.mark.parametrize("pin, pin_name", [(DPLL_PIN_TYPE.EXT, 'PPS'),
+                                               (DPLL_PIN_TYPE.GNSS, 'GNSS'),
+                                               (DPLL_PIN_TYPE.SYNCE_ETH_PORT, 'RCLK')])
+    def test_get_a_single_pin_from_dump(self, pin, pin_name):
+        '''
+        Checks if we are able to get all distinct pins for both DPLLs, filtered
+        by clock id and type on output. Additionally, verify if the priority is
+        assigned correctly and not mixed up.
+        '''
+        clock_id = self.module_consts['DPLLS_CLOCK_ID']
+        priority = self.module_consts[f'PIN_{pin_name}_PRIORITY']
+        caps = self.module_consts[f'PIN_{pin_name}_CAPABILITIES']
+
+        reply = get_all_pins()
+
+        pin_name = pin.name.lower().replace('_', '-')
+        pins = filter(lambda p:
+                      p['clock-id'] == clock_id and p['pin-type'] == pin_name, reply)
+        pins = list(pins)
+
+        assert len(pins) == 1
+        assert pins[0]['pin-dpll-caps'] == caps
+        for p in pins[0]['pin-parent-device']:
+            assert p['pin-prio'] == priority
+
+    @pytest.mark.parametrize("pin, pin_name",
+                             [(DPLL_PIN_TYPE.EXT, 'PPS'),
+                              (DPLL_PIN_TYPE.GNSS, 'GNSS'),
+                              (DPLL_PIN_TYPE.SYNCE_ETH_PORT, 'RCLK')])
+    def test_get_a_single_pin_id(self, pin, pin_name):
+        '''
+        Checks if we are able to get single pins using 'get-pin-id' do command.
+        '''
+        clock_id = self.module_consts['DPLLS_CLOCK_ID']
+        board_l = f'{pin_name}_brd'
+        panel_l = f'{pin_name}_pnl'
+        package = f'{pin_name}_pcg'
+
+        _id = get_pin_id(TEST_MODULE, clock_id, board_l, panel_l, package, pin.value)
+        assert isinstance(_id, int)
+
+    @pytest.mark.parametrize("pin, pin_name, param, value",
+                             [(DPLL_PIN_TYPE.EXT, 'PPS', 'pin-prio', 1),
+                              (DPLL_PIN_TYPE.GNSS, 'GNSS', 'pin-prio', 2),
+                              (DPLL_PIN_TYPE.SYNCE_ETH_PORT, 'RCLK', 'pin-prio', 3)])
+    def test_set_a_single_pin_prio(self, pin, pin_name, param, value):
+        '''
+        Checks if we are able to set pins priority using 'set-pin' do command.
+        '''
+        clock_id = self.module_consts['DPLLS_CLOCK_ID']
+        board_l = f'{pin_name}_brd'
+        panel_l = f'{pin_name}_pnl'
+        package = f'{pin_name}_pcg'
+
+        _id = get_pin_id(TEST_MODULE, clock_id, board_l, panel_l, package, pin.value)
+
+        pins_before = get_all_pins()
+        pin_before = get_pin(_id)
+
+        # both DPLL's are handled the same in the test module
+        first_dpll_id = pin_before['pin-parent-device'][0]['id']
+        set_pin(_id, {"pin-parent-device": {"id": first_dpll_id, param: value}})
+
+        pins_after = get_all_pins()
+
+        # assume same order, if that might change - test need to be updated
+        for i in range(len(pins_before)):
+            if pins_after[i]['pin-id'] != _id:
+                assert pins_after[i] == pins_before[i]
+            else:
+                assert pins_after[i]["pin-parent-device"][0][param] == value
+
+        # set the original value back to leave the same state after test
+        original_value = pin_before["pin-parent-device"][0][param]
+        set_pin(_id, {"pin-parent-device": {"id": first_dpll_id, param: original_value}})
+
+    @pytest.mark.parametrize("pin, pin_name, param, value",
+                             [(DPLL_PIN_TYPE.SYNCE_ETH_PORT, 'RCLK', 'pin-frequency', int(1e6)),
+                              (DPLL_PIN_TYPE.SYNCE_ETH_PORT, 'RCLK', 'pin-frequency', int(12e6))])
+    def test_set_a_single_pin_freq(self, pin, pin_name, param, value):
+        '''
+        Checks if we are able to set pins frequency using 'set-pin' do command.
+        '''
+        clock_id = self.module_consts['DPLLS_CLOCK_ID']
+        board_l = f'{pin_name}_brd'
+        panel_l = f'{pin_name}_pnl'
+        package = f'{pin_name}_pcg'
+
+        _id = get_pin_id(TEST_MODULE, clock_id, board_l, panel_l, package, pin.value)
+
+        pins_before = get_all_pins()
+        pin_before = get_pin(_id)
+
+        set_pin(_id, {param: value})
+
+        pins_after = get_all_pins()
+
+        # assume same order, if that might change - test need to be updated
+        for i in range(len(pins_before)):
+            if pins_after[i]['pin-id'] != _id:
+                assert pins_after[i] == pins_before[i]
+            else:
+                assert pins_after[i][param] == value
+
+        # set the original value back to leave the same state after test
+        set_pin(_id, {param: pin_before[param]})
+
+    @pytest.mark.parametrize("pin, pin_name, param, value",
+                             [(DPLL_PIN_TYPE.SYNCE_ETH_PORT, 'RCLK', 'pin-frequency', int(1e5)),
+                              (DPLL_PIN_TYPE.SYNCE_ETH_PORT, 'RCLK', 'pin-frequency', int(130e6))])
+    def test_set_a_single_pin_fail(self, pin, pin_name, param, value):
+        '''
+        Checks if we fail correctly trying to set incorrect pin frequency.
+        '''
+        clock_id = self.module_consts['DPLLS_CLOCK_ID']
+        board_l = f'{pin_name}_brd'
+        panel_l = f'{pin_name}_pnl'
+        package = f'{pin_name}_pcg'
+
+        _id = get_pin_id(TEST_MODULE, clock_id, board_l, panel_l, package, pin.value)
+
+        with pytest.raises(NlError):
+            set_pin(_id, {param: value})
+
+
+class TestTwoDPLLsOtherFirst(TestDPLL):
+    '''
+    Add a second module to the environment, which registers other DPLLs to make
+    sure the references are not mixed together. Other driver first.
+    '''
+    OTHER_MODULE = 'dpll_test_other'
+
+    @classmethod
+    def setup_class(cls):
+        # Load another module first
+        load_driver(SCRIPT_PATH, cls.OTHER_MODULE)
+        super().setup_class()
+
+    @classmethod
+    def teardown_class(cls):
+        unload_driver(SCRIPT_PATH, cls.OTHER_MODULE)
+        super().teardown_class()
+
+
+class TestTwoDPLLsTestedFirst(TestDPLL):
+    '''
+    Add a second module to the environment, which registers other DPLLs to make
+    sure the references are not mixed together. Tested driver first.
+    '''
+    OTHER_MODULE = 'dpll_test_other'
+
+    @classmethod
+    def setup_class(cls):
+        # Load the tested module first
+        super().setup_class()
+        load_driver(SCRIPT_PATH, cls.OTHER_MODULE)
+
+    @classmethod
+    def teardown_class(cls):
+        super().teardown_class()
+        unload_driver(SCRIPT_PATH, cls.OTHER_MODULE)
+
+
+class TestDPLLsNTF:
+    MULTICAST_GROUP = 'monitor'
+
+    @classmethod
+    def setup_class(cls):
+        '''
+        This test suite prepares the environment by arming the event tracking,
+        loading the driver, changing pin, unloading the driver and gathering
+        logs for further processing.
+        '''
+        cls.module_consts = parse_header(Path(TEST_MODULE_DIR) / f'{TEST_MODULE}.h')
+
+        yfh = YnlFamilyHandler(ntf=cls.MULTICAST_GROUP)
+
+        load_driver(SCRIPT_PATH, TEST_MODULE)
+
+        pin = DPLL_PIN_TYPE.GNSS
+        clock_id = cls.module_consts['DPLLS_CLOCK_ID']
+        board_l = f'{pin.name}_brd'
+        panel_l = f'{pin.name}_pnl'
+        package = f'{pin.name}_pcg'
+
+        _id = get_pin_id(TEST_MODULE, clock_id, board_l, panel_l, package, pin.value)
+
+        g_pin = get_pin(_id)
+
+        # both DPLL's are handled the same in the test module
+        first_dpll_id = g_pin['pin-parent-device'][0]['id']
+        set_pin(_id, {"pin-parent-device": {"id": first_dpll_id, 'pin-prio': 2}})
+
+        unload_driver(SCRIPT_PATH, TEST_MODULE)
+        yfh.ynl.check_ntf()
+        cls.events = yfh.ynl.async_msg_queue
+
+    @classmethod
+    def teardown_class(cls):
+        # Cleanup, in case something in the setup_class failed
+        lsmod = subprocess.run(['lsmod'], capture_output=True)
+        if TEST_MODULE in str(lsmod.stdout):
+            unload_driver(SCRIPT_PATH, TEST_MODULE)
+
+    @pytest.mark.parametrize(('event', 'count'), [('device-create-ntf', 2),
+                                                  ('device-delete-ntf', 2),
+                                                  ('pin-change-ntf', 1),
+                                                  ('pin-create-ntf', 5),
+                                                  ('pin-delete-ntf', 5)])
+    def test_number_of_events(self, event, count):
+        '''
+        Checks if we are getting exact number of events that we expect to be
+        gathered while monitoring the DPLL subsystem.
+        '''
+        f_events = filter(lambda i: i['name'] == event, self.events)
+        assert len(list(f_events)) == count
diff --git a/tools/testing/selftests/dpll/ynlfamilyhandler.py b/tools/testing/selftests/dpll/ynlfamilyhandler.py
new file mode 100644
index 0000000..f7d6dca
--- /dev/null
+++ b/tools/testing/selftests/dpll/ynlfamilyhandler.py
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Wraper for the YNL library used to interact with the netlink interface.
+#
+# Copyright (c) 2023, Intel Corporation.
+# Author: Michal Michalik <michal.michalik@intel.com>
+
+import sys
+from pathlib import Path
+from dataclasses import dataclass
+
+from .consts import KSRC, YNLSPEC, YNLPATH
+
+
+try:
+    ynl_full_path = Path(KSRC) / YNLPATH
+    sys.path.append(ynl_full_path.as_posix())
+    from lib import YnlFamily
+except ModuleNotFoundError:
+    print("Failed importing `ynl` library from kernel sources, please set KSRC")
+    sys.exit(1)
+
+
+@dataclass
+class YnlFamilyHandler:
+    spec: str = Path(KSRC) / YNLSPEC
+    schema: str = ''
+    dump: str = ''
+    ntf: str = ''
+    do: str = ''
+    attrs = {}
+
+    def __post_init__(self):
+        self.ynl = YnlFamily(self.spec, self.schema)
+
+        if self.ntf:
+            self.ynl.ntf_subscribe(self.ntf)
+
+    def execute(self):
+        if self.do and self.dump:
+            raise ValueError('Both "do" or "dump" set simultaneously - clear either of them')
+        elif self.do:
+            reply = self.ynl.do(self.do, self.attrs)
+        elif self.dump:
+            reply = self.ynl.dump(self.dump, self.attrs)
+        else:
+            raise ValueError('Wrong command - Set either "do" or "dump" before executing')
+
+        return reply
-- 
2.9.5


