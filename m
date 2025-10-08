Return-Path: <netdev+bounces-228273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 34187BC6034
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 18:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A82AD350480
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 16:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2987D286D49;
	Wed,  8 Oct 2025 16:25:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463CD2857F0
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759940707; cv=none; b=JjRNvp01l7rLyqty78HLHgBwB4DDXCbI4VSlCK24qvEMZkylSmHgf+CY8n4EukIkcyTSGB4kRjuUViC4PRZd9AsnobGRB2erQcsUMRoPheDTxtGctbUCPMWNg9ukEExE/BqDsHqG3inJb/w/1AUkdRsZ0U4XN8YiukMRBmraseo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759940707; c=relaxed/simple;
	bh=Dmiwn2mr2rCHOc0TQSND9LLrXQRFE4B6R8jw0RE9nok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PE2OlYvnpoxHQLgwvdKmltKtWt25LIZ6+aD3xkptYN6xbUCtUq2djJi67wbMvlsOYuq0wzzr+Y3/QZAyQOuK8DCLEbO/ZW+IsHVXgcbe+5fKb6VYVOa1wbimIAO0LW95O1o4qqL1ozlLVs0k0TpE8EBpZm11MfxBDSEd2LXveFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-782023ca359so7152284b3a.2
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 09:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759940704; x=1760545504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lha07SgLr6YajsxSBvN4itwnfzekQjZC85rngCVcAvE=;
        b=YHaqCqbbAGhpt2gtq/o2w+szI3+3bWxLFmtUgehkb9htwts9cpoiEh8irX1vJ0vxXM
         EPyLZxxGOXEaT9QsyF8sfmUYyC1Rq9DG7mzDVp5s4Pkj+1K4UJ+Zl1TqMlJvwZBzecHE
         BZNJ4iooEuvQ+mtUb88FoM8Hv1wg9Vv61twrB/IkyyPMCH2Cx8cPOZa1w16iW/GWMGcj
         FWLo1Esx7bU1x4t8KUYy9MSZpUFUXPKYMthYKd+Qal8pLCQp42CF1LZZYHzqGEW+IRzY
         i1qnfzZUZdpOn9JwSEcJtzS8m7D8bnEqp1g2LY4SrXZI49tr9rVPSsh/yy9uOq98UExK
         dqEw==
X-Gm-Message-State: AOJu0YyL/qKfYGRNDq3lcsGOxKAXOjOIYy466VlWMZZATrufCBz2yo7O
	N3E/aOZwzPHqpgVN0M1IDyLGD+q/4ecrzW7DomWazyhpOD3Mgoj4EUALA+oD
X-Gm-Gg: ASbGncvQ4FhXUyx5zYCdQW9IwDLnFlMkTOirSK457mlosEcfi9kQPfAFWI5ItF2OwiS
	27Ub6w2EfoSUoT9otiezUmB7yzn9F4YnjX18G/HcYEvQR5O8egHmX6ILNt9JQ4Iyd7r3KhwQ2Yl
	UM2JXLDjsWG9+y0BUhGJfu7fAJv1yqDpYBIozBxK0W0hUWl9wtD3Kl5rR9TSjGVvTbLqFSOmT3M
	cyFzBWVv/SaROE+YY4eMuRI5+nncQND2SAHiv6BJzO4O+0uVypx4ABUwvAM+QwFbbDGR75uSQRJ
	XUaEzGdZ1UlO2nCTcEGoU6Sy8JIvElFU1n3bIPM4EDMfZ67GRf6Ma8M75E2+2Q2v7Hg8WEQGuWH
	xWVCAEDQO67mK4iZIWAs+OJia3S4IRIp70r0ZbRgn2BtMhl4W+lAK6Ewdm+AqIAPZPt7Kuwtvxr
	mMRKZWVYvigN7iZExFUQYbMy+yiiAKHsutmrwbcmq9wCWss2ihsvDb9Wfp0rXEBGMsW1TqdrEOD
	wfykQ4mWzmELjCmYrf+fXZ8zl+/KA==
X-Google-Smtp-Source: AGHT+IG7rJeTc7BaYSRW2mgEZOIvuZo+hdU8tJz9alDLAEj9qzpkoBMt/mHdSNCv2yx7KPQXHG9lGA==
X-Received: by 2002:a05:6a00:398b:b0:77d:51e5:e5d1 with SMTP id d2e1a72fcca58-7938723dab3mr4584210b3a.19.1759940703895;
        Wed, 08 Oct 2025 09:25:03 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-794e2a4cb5asm156736b3a.71.2025.10.08.09.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 09:25:03 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	horms@kernel.org,
	willemb@google.com,
	daniel.zahka@gmail.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] selftests: drv-net: update remaining Python init files
Date: Wed,  8 Oct 2025 09:25:03 -0700
Message-ID: <20251008162503.1403966-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Convert remaining __init__ files similar to what we did in
commit b615879dbfea ("selftests: drv-net: make linters happy with our imports")

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - remove tool from imports in driver __init__s it's not actually used
v1: https://lore.kernel.org/20251007144326.1763309-1-kuba@kernel.org

CC: shuah@kernel.org
CC: willemb@google.com
CC: daniel.zahka@gmail.com
CC: linux-kselftest@vger.kernel.org
---
 .../drivers/net/hw/lib/py/__init__.py         | 40 ++++++++++++++-----
 .../selftests/drivers/net/lib/py/__init__.py  |  4 +-
 .../testing/selftests/net/lib/py/__init__.py  | 29 ++++++++++++--
 3 files changed, 57 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index 0ceb297e7757..fb010a48a5a1 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -1,5 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
 
+"""
+Driver test environment (hardware-only tests).
+NetDrvEnv and NetDrvEpEnv are the main environment classes.
+Former is for local host only tests, latter creates / connects
+to a remote endpoint. See NIPA wiki for more information about
+running and writing driver tests.
+"""
+
 import sys
 from pathlib import Path
 
@@ -8,26 +16,36 @@ KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
 try:
     sys.path.append(KSFT_DIR.as_posix())
 
-    from net.lib.py import *
-    from drivers.net.lib.py import *
-
     # Import one by one to avoid pylint false positives
+    from net.lib.py import NetNS, NetNSEnter, NetdevSimDev
     from net.lib.py import EthtoolFamily, NetdevFamily, NetshaperFamily, \
         NlError, RtnlFamily, DevlinkFamily, PSPFamily
     from net.lib.py import CmdExitFailure
-    from net.lib.py import bkg, cmd, defer, ethtool, fd_read_timeout, ip, \
-        rand_port, tool, wait_port_listen
-    from net.lib.py import fd_read_timeout
+    from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
+        fd_read_timeout, ip, rand_port, wait_port_listen, wait_file
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
         ksft_setup
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
         ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
-    from net.lib.py import NetNSEnter
-    from drivers.net.lib.py import GenerateTraffic
+    from drivers.net.lib.py import GenerateTraffic, Remote
     from drivers.net.lib.py import NetDrvEnv, NetDrvEpEnv
+
+    __all__ = ["NetNS", "NetNSEnter", "NetdevSimDev",
+               "EthtoolFamily", "NetdevFamily", "NetshaperFamily",
+               "NlError", "RtnlFamily", "DevlinkFamily", "PSPFamily",
+               "CmdExitFailure",
+               "bkg", "cmd", "bpftool", "bpftrace", "defer", "ethtool",
+               "fd_read_timeout", "ip", "rand_port",
+               "wait_port_listen", "wait_file",
+               "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
+               "ksft_disruptive", "ksft_exit", "ksft_pr", "ksft_run",
+               "ksft_setup",
+               "ksft_eq", "ksft_ge", "ksft_in", "ksft_is", "ksft_lt",
+               "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
+               "ksft_not_none", "ksft_not_none",
+               "NetDrvEnv", "NetDrvEpEnv", "GenerateTraffic", "Remote"]
 except ModuleNotFoundError as e:
-    ksft_pr("Failed importing `net` library from kernel sources")
-    ksft_pr(str(e))
-    ktap_result(True, comment="SKIP")
+    print("Failed importing `net` library from kernel sources")
+    print(str(e))
     sys.exit(4)
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index e6c070f32f51..b0c6300150fb 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -22,7 +22,7 @@ KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
         NlError, RtnlFamily, DevlinkFamily, PSPFamily
     from net.lib.py import CmdExitFailure
     from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
-        fd_read_timeout, ip, rand_port, tool, wait_port_listen, wait_file
+        fd_read_timeout, ip, rand_port, wait_port_listen, wait_file
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
         ksft_setup
@@ -34,7 +34,7 @@ KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
                "NlError", "RtnlFamily", "DevlinkFamily", "PSPFamily",
                "CmdExitFailure",
                "bkg", "cmd", "bpftool", "bpftrace", "defer", "ethtool",
-               "fd_read_timeout", "ip", "rand_port", "tool",
+               "fd_read_timeout", "ip", "rand_port",
                "wait_port_listen", "wait_file",
                "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
                "ksft_disruptive", "ksft_exit", "ksft_pr", "ksft_run",
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index 997b85cc216a..97b7cf2b20eb 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -1,9 +1,32 @@
 # SPDX-License-Identifier: GPL-2.0
 
+"""
+Python selftest helpers for netdev.
+"""
+
 from .consts import KSRC
-from .ksft import *
+from .ksft import KsftFailEx, KsftSkipEx, KsftXfailEx, ksft_pr, ksft_eq, \
+    ksft_ne, ksft_true, ksft_not_none, ksft_in, ksft_not_in, ksft_is, \
+    ksft_ge, ksft_gt, ksft_lt, ksft_raises, ksft_busy_wait, \
+    ktap_result, ksft_disruptive, ksft_setup, ksft_run, ksft_exit
 from .netns import NetNS, NetNSEnter
-from .nsim import *
-from .utils import *
+from .nsim import NetdevSim, NetdevSimDev
+from .utils import CmdExitFailure, fd_read_timeout, cmd, bkg, defer, \
+    bpftool, ip, ethtool, bpftrace, rand_port, wait_port_listen, wait_file
 from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily
 from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily
+
+__all__ = ["KSRC",
+           "KsftFailEx", "KsftSkipEx", "KsftXfailEx", "ksft_pr", "ksft_eq",
+           "ksft_ne", "ksft_true", "ksft_not_none", "ksft_in", "ksft_not_in",
+           "ksft_is", "ksft_ge", "ksft_gt", "ksft_lt", "ksft_raises",
+           "ksft_busy_wait", "ktap_result", "ksft_disruptive", "ksft_setup",
+           "ksft_run", "ksft_exit",
+           "NetNS", "NetNSEnter",
+           "CmdExitFailure", "fd_read_timeout", "cmd", "bkg", "defer",
+           "bpftool", "ip", "ethtool", "bpftrace", "rand_port",
+           "wait_port_listen", "wait_file",
+           "NetdevSim", "NetdevSimDev",
+           "NetshaperFamily", "DevlinkFamily", "PSPFamily", "NlError",
+           "YnlFamily", "EthtoolFamily", "NetdevFamily", "RtnlFamily",
+           "RtnlAddrFamily"]
-- 
2.51.0


