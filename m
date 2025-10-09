Return-Path: <netdev+bounces-228440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDF0BCADBF
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 22:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771A01A6310A
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 20:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8DD277CBF;
	Thu,  9 Oct 2025 20:56:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A7A277037
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760043395; cv=none; b=C45v+KiWnmE8/KNRj4bmsndwGhjjdFrRnnNuRZMJF6ef291UWBT+wAE0j38OH6LBscGbutJCRaKlg6F8Dw8lvu5oLLJQ9EZYrwm9B+02vV02JD7ma3Vqeqe+B+crXlU8wxqwNeCCGEDalSFu9uRoUELTZ+ISRiOSIaRGIFi1crs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760043395; c=relaxed/simple;
	bh=OKcuUIR8qRa8Y6op7yrZ3hdVvWjJUQNXbCaiGsoKxiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eQJXdlgMR2lkhNgUpp7ptMaPEYWbfiLBP8EKK5MXd6pGGainYBbESPxefen78D+t1EPV8vrFsaUxzD82L9+WpEUPUKR1AYwItk4Vt1UH3byUz1gxlBVOccR+/P2Yu8XdQm3Do94jXFCUaWC8RNedmODLCnrXpTj/Bzgr4jFkL4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27d69771e3eso8865175ad.3
        for <netdev@vger.kernel.org>; Thu, 09 Oct 2025 13:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760043391; x=1760648191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qYE1BgboSbVTbjIomRAB1FILfSiVVmoES/QvHMfnTxk=;
        b=nrVFURPdp3nlqb4HabTWJBkQhufME1DpmeSkbssLjXXopLAlK/+UYhVo4TB52x55dr
         y/MP9gfjUACqRwO1JWb/XnZ0RAGNPeBsbW7lKY510e8NllZfsnLa677N76p4KzwGT1bK
         dcuBG5f83+6oQrRYKA+m7wxUuB6lV1+lgsXzdM8WFeMa4VTS7UKvgGSKOU4yW4FEuX/b
         9pPjEyYf5hn6Cv+mpMoa+Ul7z9daLOhZ4OXxj6QJPm+yE0rTywJRnPLQ8ceGYqMJ9y2K
         IGBJRU8kAysZtIhhiYLWQZAvXUjiW7EDO2FCSEJDYlbry+4ks4t3y2G5nlAGD20dvxyj
         vLQQ==
X-Gm-Message-State: AOJu0YwcOCLqz+avIAWxhS7GmIrzwtWIsmm4pIxAikLWhEKkkcLFBkT4
	lDw8Ze1jPDCBPvSo9qd7uDNXVOzu2Rw2SBnShREpbUX2xre6E0wXEr0Yif26
X-Gm-Gg: ASbGncuGWa8kKdr29rs4fKreOzCvU467T8uHIcVqOpV9h74m/UWdf3G0j8d0wQXNCxU
	fPDZtcR1aTFg5fmyMmy1CIiLBPqvyPgXuP8KnhsPLAJkyhUAH4gNl6vPyudwxDc254VK05begm0
	D7BCI/H+YjH+81mlMIpBLJmsQkhkzya+bWSzr/k/yp/HZuuPe+XKb8Vq0/imhV4hq3c67Gel28L
	ydST31neJxwTnQGU7fAAyfn1oNvOZJzRI0zkBb5GQMs4hNevnVAvyps4xmX9iqfxC4+CxRJvJEp
	WHeu4ucLyyZRB3ZmWkzB/ds0jnkpJ0sT0v8BiYLm/7ZNb5nUXc1wsBr+/32TCob1D0MAPNxVlfh
	YYdV73N8sdbjCUj1gcg3dNT0uuRjQF//YsXqmh2iwkkGZxnVlrXAH5qtCe8zVelwMeq5mqBEMzt
	0p0VI8lPjJRlWdm98NZmDec1TzHDpUpzhC4IOSu+P1E/H5tRWheZVYE6QA05y/wiZ0s74pGx0Gu
	saZKioAOyg1DEq2LNg21Os4aTZDwQ==
X-Google-Smtp-Source: AGHT+IH5AxKfshPts4pTtQwKmGkpjIsewTbnycEsHCmNCVK5pu4wYVP7nvHlRvF2DL1tnlygVBI93g==
X-Received: by 2002:a17:903:1b26:b0:248:e3fb:4dc8 with SMTP id d9443c01a7336-290272c045bmr115341075ad.39.1760043390736;
        Thu, 09 Oct 2025 13:56:30 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29034de54d2sm37730755ad.12.2025.10.09.13.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 13:56:30 -0700 (PDT)
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
Subject: [PATCH net v3] selftests: drv-net: update remaining Python init files
Date: Thu,  9 Oct 2025 13:56:29 -0700
Message-ID: <20251009205629.379829-1-sdf@fomichev.me>
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
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
v3:
 - add my SoB (sending on behalf of Jakub)
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


