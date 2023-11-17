Return-Path: <netdev+bounces-48779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 536707EF7AB
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 20:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C45280ECF
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 19:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BB6381BA;
	Fri, 17 Nov 2023 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WeUVJV7W"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7382B19BC;
	Fri, 17 Nov 2023 11:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700247927; x=1731783927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=m6IiK+Ioc7hMWy+7Esj4GT0XYMT8ZsCo0++p3M64Ya8=;
  b=WeUVJV7WW8He3IRNpzM9/zHXRI99bVg9Ay/xWcS2JgZ07VG3YA7C0OPx
   9qbuhW5T8YV+vSkNVLUc9KyyNOyJvOYNs087Xl5Gv0p1T2aeh7R52knYe
   EMM9I8SziXu9RdUsqSh6JQOm31Tod1eYsA4UdohHBTujisnbqjKPCDkMP
   dGkG2cOfeToAaAI9oidRgHBpQjgM+NXPNX9IroHy6qwXJCVP0ebNqklpu
   f0/e1kJwXrUNZlDb8MSKU/hzezZHgrCocVzP57y7wWVWJdDWsI/gKxVl1
   bZ8gYug1nb/HiMRdr9UHKYKh6iD3poFK6k3XH45SFPyMNsQoUPGU/XXrY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="381742144"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="381742144"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 11:05:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="800577808"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="800577808"
Received: from mmichali-devpc.igk.intel.com ([10.211.235.239])
  by orsmga001.jf.intel.com with ESMTP; 17 Nov 2023 11:05:22 -0800
From: Michal Michalik <michal.michalik@intel.com>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	jonathan.lemon@gmail.com,
	pabeni@redhat.com,
	poros@redhat.com,
	milena.olech@intel.com,
	mschmidt@redhat.com,
	linux-clk@vger.kernel.org,
	bvanassche@acm.org,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	Michal Michalik <michal.michalik@intel.com>
Subject: [PATCH RFC net-next v3 2/2] selftests/dpll: add DPLL system integration selftests
Date: Fri, 17 Nov 2023 20:05:05 +0100
Message-Id: <20231117190505.7819-3-michal.michalik@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20231117190505.7819-1-michal.michalik@intel.com>
References: <20231117190505.7819-1-michal.michalik@intel.com>
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

Alternatively, they can be run using single command [1]:
  make kselftest

If we want to run only DPLL tests, we should set the TARGETS variable:
  make -C tools/testing/selftests TARGETS=drivers/net/netdevsim/dpll

They can also be run standalone using starter script:
  ./run_dpll_tests.sh

There is a possibliy to set optional PYTEST_PARAMS environment variable
to set the pytest options, like tests filtering ("-k <filter>") or
verbose output ("-v").

[1] https://www.kernel.org/doc/html/v5.0/dev-tools/kselftest.html

Signed-off-by: Michal Michalik <michal.michalik@intel.com>
---
 tools/testing/selftests/Makefile                   |   1 +
 .../selftests/drivers/net/netdevsim/dpll/Makefile  |   8 +
 .../drivers/net/netdevsim/dpll/__init__.py         |   0
 .../selftests/drivers/net/netdevsim/dpll/config    |   2 +
 .../selftests/drivers/net/netdevsim/dpll/consts.py |  40 +++
 .../drivers/net/netdevsim/dpll/dpll_utils.py       |  94 ++++++
 .../drivers/net/netdevsim/dpll/requirements.txt    |   3 +
 .../drivers/net/netdevsim/dpll/run_dpll_tests.sh   |  75 ++++
 .../drivers/net/netdevsim/dpll/test_dpll.py        | 376 +++++++++++++++++++++
 .../drivers/net/netdevsim/dpll/ynlfamilyhandler.py |  49 +++
 10 files changed, 648 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/dpll/Makefile
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/dpll/__init__.py
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/dpll/config
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/dpll/consts.py
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/dpll/dpll_utils.py
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/dpll/requirements.txt
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/dpll/run_dpll_tests.sh
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/dpll/test_dpll.py
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/dpll/ynlfamilyhandler.py

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 3b2061d..191ce7d 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -14,6 +14,7 @@ TARGETS += cpufreq
 TARGETS += cpu-hotplug
 TARGETS += damon
 TARGETS += dmabuf-heaps
+TARGETS += drivers/net/netdevsim/dpll
 TARGETS += drivers/dma-buf
 TARGETS += drivers/s390x/uvdevice
 TARGETS += drivers/net/bonding
diff --git a/tools/testing/selftests/drivers/net/netdevsim/dpll/Makefile b/tools/testing/selftests/drivers/net/netdevsim/dpll/Makefile
new file mode 100644
index 0000000..65de011
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netdevsim/dpll/Makefile
@@ -0,0 +1,8 @@
+ifndef KSRC
+	KSRC:=${shell git rev-parse --show-toplevel}
+endif
+
+run_tests:
+	./run_dpll_tests.sh
+
+.PHONY: run_tests
\ No newline at end of file
diff --git a/tools/testing/selftests/drivers/net/netdevsim/dpll/__init__.py b/tools/testing/selftests/drivers/net/netdevsim/dpll/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/tools/testing/selftests/drivers/net/netdevsim/dpll/config b/tools/testing/selftests/drivers/net/netdevsim/dpll/config
new file mode 100644
index 0000000..e38b164
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netdevsim/dpll/config
@@ -0,0 +1,2 @@
+CONFIG_DPLL=y
+CONFIG_NETDEVSIM=m
\ No newline at end of file
diff --git a/tools/testing/selftests/drivers/net/netdevsim/dpll/consts.py b/tools/testing/selftests/drivers/net/netdevsim/dpll/consts.py
new file mode 100644
index 0000000..2f41b17
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netdevsim/dpll/consts.py
@@ -0,0 +1,40 @@
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
+    MUX = 1
+    EXT = 2
+    SYNCE_ETH_PORT = 3
+    INT_OSCILLATOR = 4
+    GNSS = 5
+
+
+class DPLL_PIN_CAPS(Enum):
+    DIR_CAN_CHG = 1
+    PRIO_CAN_CHG = 2
+    STATE_CAN_CHG = 4
diff --git a/tools/testing/selftests/drivers/net/netdevsim/dpll/dpll_utils.py b/tools/testing/selftests/drivers/net/netdevsim/dpll/dpll_utils.py
new file mode 100644
index 0000000..6f3a14c
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netdevsim/dpll/dpll_utils.py
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Utilities useful in DPLL system integration testing.
+#
+# Copyright (c) 2023, Intel Corporation.
+# Author: Michal Michalik <michal.michalik@intel.com>
+
+from .ynlfamilyhandler import YnlFamilyHandler
+
+
+def read_nsim_debugfs(entry):
+    if not entry.exists():
+        raise FileNotFoundError
+
+    with open(entry) as f:
+        return f.read()
+
+
+def write_nsim_debugfs(entry, data):
+    if not entry.exists():
+        raise FileNotFoundError
+
+    with open(entry, 'w') as f:
+        return f.write(data)
+
+
+def get_dpll_id(clock_id, test_module, _type):
+    '''
+    YNL helper for getting the DPLL clock ID
+    '''
+    yfh = YnlFamilyHandler()
+    yfh.do = 'device-id-get'
+    yfh.attrs = {
+        'module-name': test_module,
+        'clock-id': clock_id,
+        'type': _type
+        }
+    return yfh.execute()['id']
+
+
+def get_dpll(clock_id, test_module, _type):
+    '''
+    YNL helper for getting the DPLL clock object
+    '''
+    _id = get_dpll_id(clock_id, test_module, _type)
+    yfh = YnlFamilyHandler()
+    yfh.do = 'device-get'
+    yfh.attrs = {'id': _id}
+    return yfh.execute()
+
+
+def get_all_pins():
+    '''
+    YNL helper for getting the all DPLL pins
+    '''
+    yfh = YnlFamilyHandler()
+    yfh.dump = 'pin-get'
+    return yfh.execute()
+
+
+def get_pin_id(test_module, clock_id, board_l, panel_l, package_l, type):
+    '''
+    YNL helper for getting DPLL pin ID
+    '''
+    yfh = YnlFamilyHandler()
+    yfh.do = 'pin-id-get'
+    yfh.attrs = {'module-name': test_module,
+                 'clock-id': clock_id,
+                 'board-label': board_l,
+                 'panel-label': panel_l,
+                 'package-label': package_l,
+                 'type': type}
+    return yfh.execute()['id']
+
+
+def get_pin(_id):
+    '''
+    YNL helper for getting the DPLL pin object
+    '''
+    yfh = YnlFamilyHandler()
+    yfh.do = 'pin-get'
+    yfh.attrs = {'id': _id}
+    return yfh.execute()
+
+
+def set_pin(_id, params):
+    '''
+    YNL helper for setting the DPLL pin parameters
+    '''
+    yfh = YnlFamilyHandler()
+    yfh.do = 'pin-set'
+    yfh.attrs = params
+    yfh.attrs['id'] = _id
+    return yfh.execute()
diff --git a/tools/testing/selftests/drivers/net/netdevsim/dpll/requirements.txt b/tools/testing/selftests/drivers/net/netdevsim/dpll/requirements.txt
new file mode 100644
index 0000000..73180b8
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netdevsim/dpll/requirements.txt
@@ -0,0 +1,3 @@
+jsonschema==4.*
+PyYAML==6.*
+pytest==7.*
diff --git a/tools/testing/selftests/drivers/net/netdevsim/dpll/run_dpll_tests.sh b/tools/testing/selftests/drivers/net/netdevsim/dpll/run_dpll_tests.sh
new file mode 100755
index 0000000..3bed221
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netdevsim/dpll/run_dpll_tests.sh
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
+# 3) Let's make sure we have predictable environment (virtual environment)
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
diff --git a/tools/testing/selftests/drivers/net/netdevsim/dpll/test_dpll.py b/tools/testing/selftests/drivers/net/netdevsim/dpll/test_dpll.py
new file mode 100644
index 0000000..bc91602
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netdevsim/dpll/test_dpll.py
@@ -0,0 +1,376 @@
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
+import subprocess
+from pathlib import Path
+
+import pytest
+
+from .consts import DPLL_TYPE, DPLL_LOCK_STATUS, DPLL_PIN_TYPE, DPLL_PIN_CAPS
+from .dpll_utils import get_dpll, get_dpll_id, get_pin_id, \
+    get_all_pins, get_pin, set_pin, read_nsim_debugfs, write_nsim_debugfs
+from .ynlfamilyhandler import YnlFamilyHandler
+from lib.ynl import NlError
+
+
+DPLL_CONSTS = 'drivers/net/netdevsim/dpll.c'
+TEST_MODULE = 'netdevsim'
+NETDEVSIM_PATH = '/sys/bus/netdevsim/'
+NETDEVSIM_NEW_DEVICE = Path(NETDEVSIM_PATH) / 'new_device'
+NETDEVSIM_DEL_DEVICE = Path(NETDEVSIM_PATH) / 'del_device'
+NETDEVSIM_DEVICES = Path(NETDEVSIM_PATH) / 'devices'
+NETDEVSIM_DEBUGFS = '/sys/kernel/debug/netdevsim/netdevsim{}/'
+
+
+@pytest.fixture(scope="class", params=((0,), (1, 0), (0, 1)))
+def env(request):
+    environment = {}
+    environment['dev_id'] = 0
+    environment['dbgfs'] = Path(
+        NETDEVSIM_DEBUGFS.format(environment['dev_id']))
+
+    for i in request.param:
+        with open(NETDEVSIM_NEW_DEVICE, 'w') as f:
+            f.write(f'{i} 1 4')
+
+    environment['clock_id'] = int(read_nsim_debugfs(
+        environment['dbgfs'] / 'dpll_clock_id'))
+
+    yield environment
+
+    for i in request.param:
+        with open(NETDEVSIM_DEL_DEVICE, 'w') as f:
+            f.write(f'{i}')
+
+
+class TestDPLL:
+    def test_if_module_is_loaded(self):
+        '''
+        Checks if the module is successfully loaded at all. It should be already
+        covered in the class setup (raise exception) - but just to make sure.
+        '''
+        s = subprocess.run(['lsmod'], check=True, capture_output=True)
+        assert TEST_MODULE in str(s.stdout)
+
+    def test_get_two_dplls(self, env):
+        '''
+        Checks if the netlink is returning the expected DPLLs. Need to make sure
+        that even if "other" DPLLs exist in the system we check only ours.
+        '''
+        yfh = YnlFamilyHandler()
+        yfh.dump = 'device-get'
+        reply = yfh.execute()
+
+        dplls = filter(lambda i: TEST_MODULE == i['module-name']
+                       and i['clock-id'] == env['clock_id'],
+                       reply)
+        assert len(list(dplls)) == 2
+
+    def test_get_two_distinct_dplls(self):
+        '''
+        Checks if the netlink is returning the expected, distinct DPLLs created
+        by the tested module. Expect EEC and PPS.
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
+    def test_finding_dpll_id(self, env, dtype):
+        '''
+        Checks if it is possible to find the DPLL id using 'device-id-get' do cmd.
+        '''
+        _id = get_dpll_id(env['clock_id'], TEST_MODULE,
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
+    def test_get_only_one_dpll(self, env, dtype):
+        '''
+        Checks if the netlink is returning the expected DPLLs created
+        by the tested module, filtered on input. Expect EEC and PPS here.
+        '''
+        _id = get_dpll_id(env['clock_id'], TEST_MODULE, dtype.value)
+
+        yfh = YnlFamilyHandler()
+        yfh.do = 'device-get'
+        yfh.attrs = {'id': _id}
+        reply = yfh.execute()
+
+        assert reply['type'] == dtype.name.lower()
+
+    @pytest.mark.parametrize("dtype, dbgf", [(DPLL_TYPE.EEC, 'dpll_e_temp'),
+                                             (DPLL_TYPE.PPS, 'dpll_p_temp')])
+    def test_get_temperature(self, env, dtype, dbgf):
+        '''
+        Checks if it is possible to get correct DPLL temperature for both DPLLs.
+        '''
+        desired_temp = int(read_nsim_debugfs(env['dbgfs'] / dbgf))
+
+        dpll = get_dpll(env['clock_id'], TEST_MODULE, dtype.value)
+
+        assert dpll['temp'] == desired_temp
+
+    @pytest.mark.parametrize("dtype, lock, dbgf",
+                             [(DPLL_TYPE.EEC, DPLL_LOCK_STATUS.UNLOCKED, "dpll_e_status"),
+                              (DPLL_TYPE.PPS, DPLL_LOCK_STATUS.UNLOCKED,
+                               "dpll_p_status"),
+                              (DPLL_TYPE.EEC, DPLL_LOCK_STATUS.LOCKED, "dpll_e_status"),
+                              (DPLL_TYPE.PPS, DPLL_LOCK_STATUS.LOCKED, "dpll_p_status")])
+    def test_get_lock(self, env, dtype, lock, dbgf):
+        '''
+        Checks if it is possible to get correct DPLL lock status for both DPLLs.
+        '''
+        write_nsim_debugfs(env['dbgfs'] / dbgf, str(lock.value))
+
+        dpll = get_dpll(env['clock_id'], TEST_MODULE,
+                        dtype.value)
+        assert dpll['lock-status'] == lock.name.lower()
+
+    @pytest.mark.parametrize("dtype, desired_pins", [(DPLL_TYPE.EEC, 3), (DPLL_TYPE.PPS, 2)])
+    def test_dump_pins_in_each_dpll(self, env, dtype, desired_pins):
+        '''
+        Checks if it is possible to dump all pins for each DPLL separetely,
+        filtered on output.
+        '''
+        dpll = get_dpll(env['clock_id'], TEST_MODULE,
+                        dtype.value)
+
+        yfh = YnlFamilyHandler()
+        yfh.dump = 'pin-get'
+        reply = yfh.execute()
+
+        pins = filter(lambda p: any(i['parent-id'] == dpll['id']
+                      for i in p.get('parent-device', [])), reply)
+
+        assert len(list(pins)) == desired_pins
+
+    def test_dump_all_pins_in_both_dplls(self, env):
+        '''
+        Checks if it is possible to dump all pins for both DPLLs, filtered by
+        clock id on output.
+        '''
+        desired_pins = 3  # all pins are in EEC
+
+        reply = get_all_pins()
+
+        pins = filter(lambda p: p['clock-id'] == env['clock_id'], reply)
+
+        assert len(list(pins)) == desired_pins
+
+    @pytest.mark.parametrize("pin, pin_name, priority, caps",
+                             [(DPLL_PIN_TYPE.SYNCE_ETH_PORT, 'RCLK', 7,
+                               DPLL_PIN_CAPS.PRIO_CAN_CHG.value |
+                               DPLL_PIN_CAPS.STATE_CAN_CHG.value),
+                              (DPLL_PIN_TYPE.GNSS, 'GNSS', 5,
+                               DPLL_PIN_CAPS.PRIO_CAN_CHG.value),
+                              (DPLL_PIN_TYPE.EXT, 'PPS', 6,
+                               DPLL_PIN_CAPS.PRIO_CAN_CHG.value |
+                               DPLL_PIN_CAPS.STATE_CAN_CHG.value |
+                               DPLL_PIN_CAPS.DIR_CAN_CHG.value)])
+    def test_get_a_single_pin_from_dump(self, env, pin, pin_name, priority,
+                                        caps):
+        '''
+        Checks if it is possible to get all distinct pins for both DPLLs, filtered
+        by clock id and type on output. Additionally, verify if the priority is
+        assigned correctly and not mixed up.
+        '''
+        reply = get_all_pins()
+
+        pin_name = pin.name.lower().replace('_', '-')
+        pins = filter(lambda p:
+                      p['clock-id'] == env['clock_id'] and p['type'] == pin_name, reply)
+        pins = list(pins)
+
+        assert len(pins) == 1
+        assert pins[0]['capabilities'] == caps
+        for p in pins[0]['parent-device']:
+            assert p['prio'] == priority
+
+    @pytest.mark.parametrize("pin, pin_name",
+                             [(DPLL_PIN_TYPE.EXT, 'PPS'),
+                              (DPLL_PIN_TYPE.GNSS, 'GNSS'),
+                              (DPLL_PIN_TYPE.SYNCE_ETH_PORT, 'RCLK_0')])
+    def test_get_a_single_pin_id(self, env, pin, pin_name):
+        '''
+        Checks if it is possible to get single pins using 'get-pin-id' do
+        command.
+        '''
+        board_l = f'{pin_name}_brd'
+        panel_l = f'{pin_name}_pnl'
+        package = f'{pin_name}_pcg'
+
+        _id = get_pin_id(TEST_MODULE, env['clock_id'], board_l, panel_l,
+                         package, pin.value)
+        assert isinstance(_id, int)
+
+    @pytest.mark.parametrize("pin, pin_name, param, value",
+                             [(DPLL_PIN_TYPE.EXT, 'PPS', 'prio', 1),
+                              (DPLL_PIN_TYPE.GNSS, 'GNSS', 'prio', 2),
+                              (DPLL_PIN_TYPE.SYNCE_ETH_PORT, 'RCLK_0', 'prio', 3)])
+    def test_set_a_single_pin_prio(self, env, pin, pin_name, param, value):
+        '''
+        Checks if it is possible to set pins priority using 'set-pin' do
+        command.
+        '''
+        board_l = f'{pin_name}_brd'
+        panel_l = f'{pin_name}_pnl'
+        package = f'{pin_name}_pcg'
+
+        _id = get_pin_id(TEST_MODULE, env['clock_id'], board_l, panel_l,
+                         package, pin.value)
+
+        pins_before = get_all_pins()
+        pin_before = get_pin(_id)
+
+        # both DPLL's are handled the same in the test module
+        first_dpll_id = pin_before['parent-device'][0]['parent-id']
+        set_pin(_id, {"parent-device":
+                      {"parent-id": first_dpll_id, param: value}})
+
+        pins_after = get_all_pins()
+
+        # assume same order, if that might change - test need to be updated
+        for i in range(len(pins_before)):
+            if pins_after[i]['id'] != _id:
+                assert pins_after[i] == pins_before[i]
+            else:
+                assert pins_after[i]["parent-device"][0][param] == value
+
+        # set the original value back to leave the same state after test
+        original_value = pin_before["parent-device"][0][param]
+        set_pin(_id, {"parent-device":
+                      {"parent-id": first_dpll_id, param: original_value}})
+
+    @pytest.mark.parametrize("pin, pin_name, param, value",
+                             [(DPLL_PIN_TYPE.SYNCE_ETH_PORT, 'RCLK_0',
+                               'frequency', int(1e6)),
+                              (DPLL_PIN_TYPE.SYNCE_ETH_PORT, 'RCLK_0',
+                               'frequency', int(12e6))])
+    def test_set_a_single_pin_freq(self, env, pin, pin_name, param, value):
+        '''
+        Checks if it is possible to set pins frequency using 'set-pin' do
+        command.
+        '''
+        board_l = f'{pin_name}_brd'
+        panel_l = f'{pin_name}_pnl'
+        package = f'{pin_name}_pcg'
+
+        _id = get_pin_id(TEST_MODULE, env['clock_id'], board_l, panel_l,
+                         package, pin.value)
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
+            if pins_after[i]['id'] != _id:
+                assert pins_after[i] == pins_before[i]
+            else:
+                assert pins_after[i][param] == value
+
+        # set the original value back to leave the same state after test
+        set_pin(_id, {param: pin_before[param]})
+
+    @pytest.mark.parametrize("pin, pin_name, param, value",
+                             [(DPLL_PIN_TYPE.SYNCE_ETH_PORT, 'RCLK_0',
+                               'frequency', int(1e5)),
+                              (DPLL_PIN_TYPE.SYNCE_ETH_PORT, 'RCLK_0',
+                               'frequency', int(130e6))])
+    def test_set_a_single_pin_fail(self, env, pin, pin_name, param, value):
+        '''
+        Checks if we fail correctly trying to set incorrect pin frequency.
+        '''
+        board_l = f'{pin_name}_brd'
+        panel_l = f'{pin_name}_pnl'
+        package = f'{pin_name}_pcg'
+
+        _id = get_pin_id(TEST_MODULE, env['clock_id'], board_l, panel_l,
+                         package, pin.value)
+
+        with pytest.raises(NlError):
+            set_pin(_id, {param: value})
+
+
+@pytest.fixture(scope="class")
+def ntf_env():
+    '''
+    This test suite prepares the env by arming the event tracking,
+    loading the driver, changing pin, unloading the driver and gathering
+    logs for further processing.
+    '''
+    environment = {}
+    environment['dev_id'] = 0
+    environment['dbgfs'] = Path(
+        NETDEVSIM_DEBUGFS.format(environment['dev_id']))
+
+    yfh = YnlFamilyHandler(ntf='monitor')
+
+    with open(NETDEVSIM_NEW_DEVICE, 'w') as f:
+        f.write(f'{environment["dev_id"]} 1 4')
+
+    pin = DPLL_PIN_TYPE.GNSS
+    clock_id = read_nsim_debugfs(environment['dbgfs'] / 'dpll_clock_id')
+    board_l = f'{pin.name}_brd'
+    panel_l = f'{pin.name}_pnl'
+    package = f'{pin.name}_pcg'
+
+    _id = get_pin_id(TEST_MODULE, clock_id, board_l,
+                     panel_l, package, pin.value)
+
+    g_pin = get_pin(_id)
+
+    # both DPLL's are handled the same in the test module
+    first_dpll_id = g_pin['parent-device'][0]['parent-id']
+    set_pin(_id, {"parent-device": {"parent-id": first_dpll_id, 'prio': 2}})
+
+    with open(NETDEVSIM_DEL_DEVICE, 'w') as f:
+        f.write(f'{environment["dev_id"]}')
+
+    yfh.ynl.check_ntf()
+    environment['events'] = yfh.ynl.async_msg_queue
+
+    yield environment
+
+
+class TestDPLLsNTF:
+    @pytest.mark.parametrize(('event', 'count'), [('device-create-ntf', 2),
+                                                  ('device-delete-ntf', 2),
+                                                  ('pin-change-ntf', 1),
+                                                  ('pin-create-ntf', 5),
+                                                  ('pin-delete-ntf', 5)])
+    def test_number_of_events(self, ntf_env, event, count):
+        '''
+        Checks if we are getting exact number of events that we expect to be
+        gathered while monitoring the DPLL subsystem.
+        '''
+        f_events = filter(lambda i: i['name'] == event, ntf_env['events'])
+        assert len(list(f_events)) == count
diff --git a/tools/testing/selftests/drivers/net/netdevsim/dpll/ynlfamilyhandler.py b/tools/testing/selftests/drivers/net/netdevsim/dpll/ynlfamilyhandler.py
new file mode 100644
index 0000000..2aac23f
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netdevsim/dpll/ynlfamilyhandler.py
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
+            reply = self.ynl.do(self.do, self.attrs, [])
+        elif self.dump:
+            reply = self.ynl.dump(self.dump, self.attrs)
+        else:
+            raise ValueError('Wrong command - Set either "do" or "dump" before executing')
+
+        return reply
-- 
2.9.5


