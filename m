Return-Path: <netdev+bounces-226079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B12B9BC44
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 21:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB323AB004
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 19:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB20A27145C;
	Wed, 24 Sep 2025 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkdZ3Osg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0827A21FF46
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 19:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758743406; cv=none; b=UutmPAs/TQlGWOOXmtgRWQXMqGzw7xNOmLGBcpaFytAlENflTmz1d++P/x+y6pZh8oibE2hopF13HayV8B0wVJ3vyOqqIBbXDphTeHZo0BwSDsq19yFdZD3Y4/3Kn+A4t/8wmqoEQsNEeqMUlZkpD4k+wman+MfVo7MbZU3Gxzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758743406; c=relaxed/simple;
	bh=T49vNSY6pz1wPu4gr1Mzr/cSbWhjFf8g2c27jGwl6CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEalIJHATARD/HzstIfTOENoRDlQeQUMRuLfRfnkwXMWbDhsUV+wFQfN9YsTr0zbi+LsFAAqs+U//dU9YawsFbbH1keE/9LQlqVg/Xf1CnAcUIEAtJDjVQQwMho3oL02eqGnSAQUcow3SZac0LznJ4nw0zgjuMYIG6xnilSWL1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkdZ3Osg; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-743ba48eb71so13414437b3.1
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 12:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758743404; x=1759348204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kY96mX97MRxfvZCK7M9VqGP7HciWDDUZY+NtwzfPinY=;
        b=AkdZ3OsgH7DTX75NTGhMvUxfVXuAcB5uBOqL/6w3TaAvFKvRu9680PP9FfwtR4ABmw
         oQff0LezPt5ccR5gEfyZRUQTF0NCd14cLXTO3nEx0sN5l3M6vKNs2a6zM4fe5qPDMHri
         d4Nyg4OuL4iuGgRm/sSuXJoZok+d8cQn62A2XFntUsSktosxS/kG84d5EhsDBr8HJfuN
         lnVRIRhdbqwA2+eohadlJLlDoX6hDnTaA17b3uliBA0wWt+qgW0iWQPs8kVotOlz1Ixn
         hN2ZWcyQF72GivnzA+2wno9VUi2b9xsqkdpl+ldksqgp4DndhGbE7KvqCaXhNV3wiP/V
         fg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758743404; x=1759348204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kY96mX97MRxfvZCK7M9VqGP7HciWDDUZY+NtwzfPinY=;
        b=mDG43p5Q7zG+NPq65U0LFGyH0FkcEdrtuUP8YYkinDv8ZzTf0dLsHgN9TvXamxHf1W
         ksS+4NACbA4pcCol47137ZLMrH7cj5nA6dUfUQwekCTSKa3j3KU0UOK+GfwH38F91ay5
         TdVXG7ue0ahUNFAwkMdxt5Nq+SHHLgMdH2y6LbIXT3kbtt891gyPE3KVI7ZthvyoukBy
         26TEdEegkVvF1eiW55TMTLqCL8eOO/q6KiX/vYCz3PtDo41lsivcPduZk6I650REGRy2
         x+Q0yX6aG3uOjFPsBln2IlqJugju2Yh6xgSn+c/j8h28zrjAAGYdJ6TueE1X7a+l7juH
         lbTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeqYRoYq6Am5eTLtyiuj77zsg9QYGpOFDYjuTnrbDkiTJkBQeU/CrMHT6eyvUAVlo4rqR7T/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXt7dTsRBqtsutToD46qHNBe7G9+WYi9cBZX/31WqzznlVpUjI
	QpQGst9ycDOoviL7l/rVk8RFDLDur0m49vHFeD8peaUoeIPRRTgKPOFp
X-Gm-Gg: ASbGnct56Ow68nwtY/I+zdE1R6c+kB8WA/EIN0MgXsC6ocPJGuCbCuUXN0Mw/nSGtpT
	gwuyZa/HKI7onR1Otj6uRYYOLXLfiU/GT32a8Nd1Yvrci5OtLXyPVJRyb+HCzS25HAh+Q+1hVHs
	9tr7LHcYyDmh0JPPTU3thShGnTZWtqDx7sJerp7y2NiWZ4mVO3Ya0TGOH9chUbleQpIpeD2sW3J
	cKRg7qwbN5QoU/fJxvZPjJvDkacsLCsoTZy6vH888WejM3zwR2sbj8wiZZUnc+fcznpEQ9X3gJD
	LhnqVdEeTM8AxLz6ckoFmSa8vT5Y8g0xh+O/lRzJl3psz4Um4+t84COlBpt2nJPIbOPkGrHNJIT
	ZHUi2NpHbd/O22WySg4Ed
X-Google-Smtp-Source: AGHT+IGwe3rk8yYngyycVzC18xS4tv9hQOKC0bOeHGwAmmjTwHfFzjkEzdOIYGfgSBZ7nGp7h8RZzg==
X-Received: by 2002:a05:690c:6d12:b0:737:506f:da08 with SMTP id 00721157ae682-76559b62b77mr493347b3.15.1758743403813;
        Wed, 24 Sep 2025 12:50:03 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:44::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-739718cc2dcsm51322287b3.67.2025.09.24.12.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 12:50:03 -0700 (PDT)
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
	netdev@vger.kernel.org
Subject: [PATCH net-next 3/9] selftests: drv-net: base device access API test
Date: Wed, 24 Sep 2025 12:49:49 -0700
Message-ID: <20250924194959.2845473-4-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250924194959.2845473-1-daniel.zahka@gmail.com>
References: <20250924194959.2845473-1-daniel.zahka@gmail.com>
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
 tools/testing/selftests/drivers/net/Makefile  |  1 +
 tools/testing/selftests/drivers/net/config    |  1 +
 .../drivers/net/hw/lib/py/__init__.py         |  2 +-
 .../selftests/drivers/net/lib/py/__init__.py  |  2 +-
 tools/testing/selftests/drivers/net/psp.py    | 68 +++++++++++++++++++
 .../testing/selftests/net/lib/py/__init__.py  |  2 +-
 tools/testing/selftests/net/lib/py/ynl.py     |  5 ++
 7 files changed, 78 insertions(+), 3 deletions(-)
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
index f27172ddee0a..ac13da8847ca 100644
--- a/tools/testing/selftests/drivers/net/config
+++ b/tools/testing/selftests/drivers/net/config
@@ -5,3 +5,4 @@ CONFIG_NETCONSOLE=m
 CONFIG_NETCONSOLE_DYNAMIC=y
 CONFIG_NETCONSOLE_EXTENDED_LOG=y
 CONFIG_XDP_SOCKETS=y
+CONFIG_INET_PSP=y
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
index 000000000000..965e456836d2
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -0,0 +1,68 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""Test suite for PSP capable drivers."""
+
+from lib.py import ksft_run, ksft_exit
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
+        ksft_run(globs=globals(), case_pfx={"dev_"},
+                 args=(cfg, ), skip_all=(cfg.psp_dev_id is None))
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


