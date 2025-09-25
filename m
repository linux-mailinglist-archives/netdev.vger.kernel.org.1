Return-Path: <netdev+bounces-226531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96841BA182C
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 23:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62731C22914
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 21:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A215C321284;
	Thu, 25 Sep 2025 21:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esFH7zs5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B0432128D
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 21:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835015; cv=none; b=e9Z7yWsU+mSQET7i9WQYU52OOAVDMekgXORuyezdPu5BqeBmfHHm41BAaxDRFovjn36WC65UmPdFMQ6n4Yq+xz7r5Z0gHYVqevbmUTWmAIbTRq/FEAyD+MYl4fl5LsqRSCfP7+rygIfwTeJUvT8awrUqned1qy9ktPNCQJdv9lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835015; c=relaxed/simple;
	bh=ajY6aSWBs2OXD+nVmvCjwLyL18+8iTchdTnV5QPXQPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzXUDv6EIZz6neZEs7a7xBWOWozfWZ4mEvtX1y3WWTQDxRudWe4/NqS2z3tkU9pduv/S9e6KzcEbzmLyH0C9jEdaid4k8ObcPE9ChCJmmgTt3sWdYP1xjHtoCwrdTILJABLENBNmRGTEztg2+55upXj7HyQJBbmzHo1aw14T4zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esFH7zs5; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-74435335177so34770537b3.0
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 14:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758835012; x=1759439812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TeFOmj8bJcV5vXHGajMd6K520spnD971DgfwwzdUZyM=;
        b=esFH7zs5LkcQ6oVIOQAXjm5tCyMXgp6S3OCeyeDbQE1F3HZwFMY2fPWhQpgcscqdgV
         Z9h71E1jJQUOw+JRRmXJYT6bQwwEsDEi7wt9DjSp9/uoTLlB3M/x9x0VbCTXA3mdvrIm
         x0FDCmkYh8a9VoQUBgI0io5wdVkkREvnfy1wciOy51U5Ks0gckrlxcXUNhSkTP2BkOq8
         Hc+2EMkoTy9xfiYkXD5QVzg+70/RTo0uBLrLEvOnRTZ78AXCD9QstwMuLvGAI88LjlpO
         Zr6SARzvI5ZfdRCdr/40+6S0Vixgpv0jA71Z/cl1GPZN+IRuoW5dioZeYzrqEMalwxMS
         5bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758835012; x=1759439812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TeFOmj8bJcV5vXHGajMd6K520spnD971DgfwwzdUZyM=;
        b=RnvTqfUX5FH1ZkH+ps+YvMyuuzF1aeyo4UN7gMQTwqiTdtd81avUd6fTHAyE0u4qcQ
         XZ0t9m1yh878yCYzG1f1+pqQPs4M1U0x0fV4bScS7MpBwFmaCZNq748+TzWvaQNGNBZe
         jWy6dymbGEk2oiRYO12PXW7DOZsMoCJ7nKiY4NVrZ932C7wMFZFT7Y7io6DpJs88ulc8
         j+U3ifzNnzNLuLw0aSPKJlQ8XUkaWtQCHXrfNxTHyfzXwmOhwj9T04gRyhaupw+vGLu+
         Ql3y/5qAu/kU7KAO9XM8Oo+8E2jgI0cZlxKf5/MSEo1eEIzAKPiWV0txFvYSnEtpgEJb
         u5ig==
X-Forwarded-Encrypted: i=1; AJvYcCVEgA0o/RF/a08/IxXOLEY3cMRC9beXxhP42Y+ZtyEWEFsAQe+RPEfCjbQCL4qBqL8aiMnQjBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC9C37E8ot7gds+qIGqe6VsZnaysaSkzz8xs+N2G7DTA6kPTSq
	rM3oAjW6NW4H1J64hotyIM+fVSS0Y1C9nsuy8l35pR+pMNb4cFhga9S/
X-Gm-Gg: ASbGncvQ1kqrpovjjVEX2oxaIWd6ZE4mPKQh7L9nEeXtaE31Oi3QEb/M7Faf7uu8LEh
	B8dCAGAW21TDOYv98E0AAYOJQ34hPPz18h8mUT+ukZ0GNleijFIWtqEzF/kn5dh8qZYRwjgUKjP
	/YVXO+L77L2zQgy42+cyJwo/DDL5GWtseKdbfSyBKykePOIzsiZ7usjDAmAUKXB1lIUOlZPdDmp
	sIXMgotbvTFSi6YhKSuXkmhoZ1ukYOAeL624TCb7HVqUyMkku1GK7OfCsxpYzoNx7Ol3PjhqNar
	PkAHxEpA5H0E7HUhqct96jn0AIizywUnmcfV4C/51rMQ/a79cy3cvQ4HSjtvssBxqZNtBCv//ZJ
	pu6WMst2YPwpGCvPk+7X7
X-Google-Smtp-Source: AGHT+IH8N3PvBxhbJyoSiHpGmX3jolt159Hg93P229rlnykgVhSepdNqAHh66cGDyUm59F/xvlkunQ==
X-Received: by 2002:a05:690e:23cb:b0:633:102e:93ee with SMTP id 956f58d0204a3-6361d236cc7mr3091528d50.1.1758835012479;
        Thu, 25 Sep 2025 14:16:52 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:41::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6361e985da6sm806563d50.8.2025.09.25.14.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:16:51 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>,
	Breno Leitao <leitao@debian.org>,
	Petr Machata <petrm@nvidia.com>,
	Yuyang Huang <yuyanghuang@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 2/8] selftests: drv-net: base device access API test
Date: Thu, 25 Sep 2025 14:16:38 -0700
Message-ID: <20250925211647.3450332-3-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250925211647.3450332-1-daniel.zahka@gmail.com>
References: <20250925211647.3450332-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Simple PSP test to getting info about PSP devices.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v2:
    - insert CONFIG_INET_PSP in alphebetical order
    - use branch to skip all tests

 tools/testing/selftests/drivers/net/Makefile  |  1 +
 tools/testing/selftests/drivers/net/config    |  1 +
 .../drivers/net/hw/lib/py/__init__.py         |  2 +-
 .../selftests/drivers/net/lib/py/__init__.py  |  2 +-
 tools/testing/selftests/drivers/net/psp.py    | 70 +++++++++++++++++++
 .../testing/selftests/net/lib/py/__init__.py  |  2 +-
 tools/testing/selftests/net/lib/py/ynl.py     |  5 ++
 7 files changed, 80 insertions(+), 3 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/psp.py

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 984ece05f7f9..102cfb36846c 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -19,6 +19,7 @@ TEST_PROGS := \
 	netcons_sysdata.sh \
 	netpoll_basic.py \
 	ping.py \
+	psp.py \
 	queues.py \
 	stats.py \
 	shaper.py \
diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/selftests/drivers/net/config
index f27172ddee0a..af866befa33e 100644
--- a/tools/testing/selftests/drivers/net/config
+++ b/tools/testing/selftests/drivers/net/config
@@ -1,3 +1,4 @@
+CONFIG_INET_PSP=y
 CONFIG_IPV6=y
 CONFIG_NETDEVSIM=m
 CONFIG_CONFIGFS_FS=y
diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index 1462a339a74b..559c572e296a 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -13,7 +13,7 @@ try:
 
     # Import one by one to avoid pylint false positives
     from net.lib.py import EthtoolFamily, NetdevFamily, NetshaperFamily, \
-        NlError, RtnlFamily, DevlinkFamily
+        NlError, RtnlFamily, DevlinkFamily, PSPFamily
     from net.lib.py import CmdExitFailure
     from net.lib.py import bkg, cmd, defer, ethtool, fd_read_timeout, ip, \
         rand_port, tool, wait_port_listen
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index a07b56a75c8a..31ecc618050c 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -12,7 +12,7 @@ try:
 
     # Import one by one to avoid pylint false positives
     from net.lib.py import EthtoolFamily, NetdevFamily, NetshaperFamily, \
-        NlError, RtnlFamily, DevlinkFamily
+        NlError, RtnlFamily, DevlinkFamily, PSPFamily
     from net.lib.py import CmdExitFailure
     from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
         fd_read_timeout, ip, rand_port, tool, wait_port_listen, wait_file
diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
new file mode 100755
index 000000000000..43dfa497be9b
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -0,0 +1,70 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""Test suite for PSP capable drivers."""
+
+from lib.py import ksft_run, ksft_exit, ksft_pr
+from lib.py import ksft_true, ksft_eq
+from lib.py import NetDrvEpEnv, PSPFamily, NlError
+
+#
+# Test cases
+#
+
+def dev_list_devices(cfg):
+    """ Dump all devices """
+    devices = cfg.pspnl.dev_get({}, dump=True)
+
+    found = False
+    for dev in devices:
+        found |= dev['id'] == cfg.psp_dev_id
+    ksft_true(found)
+
+
+def dev_get_device(cfg):
+    """ Get the device we intend to use """
+    dev = cfg.pspnl.dev_get({'id': cfg.psp_dev_id})
+    ksft_eq(dev['id'], cfg.psp_dev_id)
+
+
+def dev_get_device_bad(cfg):
+    """ Test getting device which doesn't exist """
+    raised = False
+    try:
+        cfg.pspnl.dev_get({'id': cfg.psp_dev_id + 1234567})
+    except NlError as e:
+        ksft_eq(e.nl_msg.error, -19)
+        raised = True
+    ksft_true(raised)
+
+
+def main() -> None:
+    with NetDrvEpEnv(__file__) as cfg:
+        cfg.pspnl = PSPFamily()
+
+        # Figure out which local device we are testing against
+        cfg.psp_dev_id = None
+        versions = None
+        devs = [dev for dev in cfg.pspnl.dev_get({}, dump=True) if dev["ifindex"] == cfg.ifindex]
+        if devs:
+            info = devs[0]
+            cfg.psp_dev_id = info['id']
+
+            # Enable PSP if necessary
+            if info['psp-versions-ena'] != info['psp-versions-cap']:
+                versions = info['psp-versions-ena']
+                cfg.pspnl.dev_set({"id": cfg.psp_dev_id,
+                                   "psp-versions-ena": info['psp-versions-cap']})
+
+                if cfg.psp_dev_id is not None:
+                    ksft_run(globs=globals(), case_pfx={"dev_",}, args=(cfg, ))
+                else:
+                    ksft_pr("No PSP device found, skipping all tests")
+
+        if versions is not None:
+            cfg.pspnl.dev_set({"id": cfg.psp_dev_id, "psp-versions-ena": versions})
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index 02be28dcc089..997b85cc216a 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -6,4 +6,4 @@ from .netns import NetNS, NetNSEnter
 from .nsim import *
 from .utils import *
 from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily
-from .ynl import NetshaperFamily, DevlinkFamily
+from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily
diff --git a/tools/testing/selftests/net/lib/py/ynl.py b/tools/testing/selftests/net/lib/py/ynl.py
index 2b3a61ea3bfa..32c223e93b2c 100644
--- a/tools/testing/selftests/net/lib/py/ynl.py
+++ b/tools/testing/selftests/net/lib/py/ynl.py
@@ -61,3 +61,8 @@ class DevlinkFamily(YnlFamily):
     def __init__(self, recv_size=0):
         super().__init__((SPEC_PATH / Path('devlink.yaml')).as_posix(),
                          schema='', recv_size=recv_size)
+
+class PSPFamily(YnlFamily):
+    def __init__(self, recv_size=0):
+        super().__init__((SPEC_PATH / Path('psp.yaml')).as_posix(),
+                         schema='', recv_size=recv_size)
-- 
2.47.3


