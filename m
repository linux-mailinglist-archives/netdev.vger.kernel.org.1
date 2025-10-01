Return-Path: <netdev+bounces-227525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD121BB214F
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 01:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E03189F582
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 23:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0377C296BA8;
	Wed,  1 Oct 2025 23:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scckct6a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D380A14A4CC
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 23:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759362194; cv=none; b=l+Xv3R4ArejFxeJTRxMv6IFHhhhVG8aC0Lc2q0+vyNm5rjkENxv++uAI5sJfbJkYWxnIpZ2mcyMWmHaM5DldxuAkJcUdfys9wfjBfShwKxOGV+psF0Z1JCGRR8YEf1gspeMZMwc0wueaVQAWQYTZJeo9bjj0YTxMr0W895VFPYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759362194; c=relaxed/simple;
	bh=vyjoln4eYYYMZ1JnvwBpD0Tkw30iYhwJlUAsxIuXILo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jCFoJ4M8II5l0qk3EdO1r4I4p1Lszbvuty19goM2n9jPnfLMgHXvCoiFJ1FUlRj2eBKzg6KnyqRNEsjrgP8KOHRJeULzMmDpSjQPIemAj7C142XoQST5FS6WvQMEBV+oxaqPKoKG8DRjn5C9iE74Dwj8UosPRhQa4QmvIoz2BUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scckct6a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E89C4CEF1;
	Wed,  1 Oct 2025 23:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759362193;
	bh=vyjoln4eYYYMZ1JnvwBpD0Tkw30iYhwJlUAsxIuXILo=;
	h=From:To:Cc:Subject:Date:From;
	b=scckct6avEXBu+hGoo6bn+zvZAJIZ7Ha8g0TK0Qs3BDOMa54Vdmv6YB5M1ZEhtQAt
	 206JFKbC086ykfISpzxjVJtZs0YIzJJ8gcsbsFmbbPT1y9vQIxTOAvI05Dw0+JtV8G
	 ZGaZnyMQHx7X5TiceB9hdsrScpznaQpEobFyH85U+tvZSLTRasGtDbAKule70T3zGY
	 IrSBR3HQmWbkCEkpOUwWuve0fVDoXCGcofvlx6WLg2RWDWXBowPZkFVQVSi/gDz9UA
	 ZOHEc5yW35Y882pKIUsvzPrNrC603n954G+TZxJZDDgNHQfKAZz/CYm4CBF5FkVKPn
	 V15aFt4/qfAvQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] selftests: drv-net: make linters happy with our imports
Date: Wed,  1 Oct 2025 16:43:08 -0700
Message-ID: <20251001234308.2895998-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linters are still not very happy with our __init__ files,
which was pointed out in recent review (see Link).

We have previously started importing things one by one to
make linters happy with the test files (which import from __init__).
But __init__ file itself still makes linters unhappy.

To clean it up I believe we must completely remove the wildcard
imports, and assign the imported modules to __all__.

hds.py needs to be fixed because it seems to be importing
the Python standard random from lib.net.

We can't use ksft_pr() / ktap_result() in case importing
from net.lib fails. Linters complain that those helpers
themselves may not have been imported.

Link: https://lore.kernel.org/9d215979-6c6d-4e9b-9cdd-39cff595866e@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Sending a fix for the driver's __init__.py first, if this is okay
with everyone I'll convert the rest. I'm not super confident 'cause
my Python isn't properly learned.

Sending for net, even tho its not a real fix. I think that getting
it applied during the merge window may be okay? No strong prefence.
I'm slightly worried that merging it in net-next after the MW will
leave us with a release cycle full of merge conflicts.
---
 tools/testing/selftests/drivers/net/hds.py    |  3 +-
 .../selftests/drivers/net/lib/py/__init__.py  | 43 ++++++++++++++-----
 2 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hds.py b/tools/testing/selftests/drivers/net/hds.py
index a2011474e625..c4fe049e9baa 100755
--- a/tools/testing/selftests/drivers/net/hds.py
+++ b/tools/testing/selftests/drivers/net/hds.py
@@ -3,11 +3,12 @@
 
 import errno
 import os
+import random
 from typing import Union
 from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_raises, KsftSkipEx
 from lib.py import CmdExitFailure, EthtoolFamily, NlError
 from lib.py import NetDrvEnv
-from lib.py import defer, ethtool, ip, random
+from lib.py import defer, ethtool, ip
 
 
 def _get_hds_mode(cfg, netnl) -> str:
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 2a645415c4ca..e6c070f32f51 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -1,5 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
 
+"""
+Driver test environment.
+NetDrvEnv and NetDrvEpEnv are the main environment classes.
+Former is for local host only tests, latter creates / connects
+to a remote endpoint. See NIPA wiki for more information about
+running and writing driver tests.
+"""
+
 import sys
 from pathlib import Path
 
@@ -8,26 +16,39 @@ KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
 try:
     sys.path.append(KSFT_DIR.as_posix())
 
-    from net.lib.py import *
-
     # Import one by one to avoid pylint false positives
+    from net.lib.py import NetNS, NetNSEnter, NetdevSimDev
     from net.lib.py import EthtoolFamily, NetdevFamily, NetshaperFamily, \
         NlError, RtnlFamily, DevlinkFamily, PSPFamily
     from net.lib.py import CmdExitFailure
     from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, \
         fd_read_timeout, ip, rand_port, tool, wait_port_listen, wait_file
-    from net.lib.py import fd_read_timeout
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
     from net.lib.py import ksft_disruptive, ksft_exit, ksft_pr, ksft_run, \
         ksft_setup
     from net.lib.py import ksft_eq, ksft_ge, ksft_in, ksft_is, ksft_lt, \
         ksft_ne, ksft_not_in, ksft_raises, ksft_true, ksft_gt, ksft_not_none
-except ModuleNotFoundError as e:
-    ksft_pr("Failed importing `net` library from kernel sources")
-    ksft_pr(str(e))
-    ktap_result(True, comment="SKIP")
-    sys.exit(4)
 
-from .env import *
-from .load import *
-from .remote import Remote
+    __all__ = ["NetNS", "NetNSEnter", "NetdevSimDev",
+               "EthtoolFamily", "NetdevFamily", "NetshaperFamily",
+               "NlError", "RtnlFamily", "DevlinkFamily", "PSPFamily",
+               "CmdExitFailure",
+               "bkg", "cmd", "bpftool", "bpftrace", "defer", "ethtool",
+               "fd_read_timeout", "ip", "rand_port", "tool",
+               "wait_port_listen", "wait_file",
+               "KsftSkipEx", "KsftFailEx", "KsftXfailEx",
+               "ksft_disruptive", "ksft_exit", "ksft_pr", "ksft_run",
+               "ksft_setup",
+               "ksft_eq", "ksft_ge", "ksft_in", "ksft_is", "ksft_lt",
+               "ksft_ne", "ksft_not_in", "ksft_raises", "ksft_true", "ksft_gt",
+               "ksft_not_none", "ksft_not_none"]
+
+    from .env import NetDrvEnv, NetDrvEpEnv
+    from .load import GenerateTraffic
+    from .remote import Remote
+
+    __all__ += ["NetDrvEnv", "NetDrvEpEnv", "GenerateTraffic", "Remote"]
+except ModuleNotFoundError as e:
+    print("Failed importing `net` library from kernel sources")
+    print(str(e))
+    sys.exit(4)
-- 
2.51.0


