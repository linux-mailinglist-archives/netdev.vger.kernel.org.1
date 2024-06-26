Return-Path: <netdev+bounces-106723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D97B191758C
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 03:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 285C8B213F7
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 01:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AEDF510;
	Wed, 26 Jun 2024 01:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cc9pRqa8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D464EAC5
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 01:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719365102; cv=none; b=XcVAWhcOOe0u/aQgZ9WB3Gq6yYF1KisMH4MyTIzRwUTBsJArVCdUSL0OO2n2hVOMmpD8JlI+Z73nqqZWlXD4g3PkJvt33kj4vDvbRXxmASXLHRAnstrkclPh9sy/Mr9Y36sVwvCnqXK3LHVrK/em91u1v6HaDnUhDenp+OY414k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719365102; c=relaxed/simple;
	bh=uCedbihfRdH1xyeeUQ7hjXi41pyw4dMCk2YV7mdlLYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPrB9YTfuiiun4PPVeWrS51AfWVm6yhQ6F5XcLHwJMHe/FuKjJGW/vqBhphxblCnpJo5ORqYUEDtHDq4IZpSNblSv9XAUNb3PYeDCynIJ7YdpmW4Ri5uhs+1Mgr6M3sQevUdMAXlPMbYQmOs8xuHbud5nrccivmGG/kEhmwoQ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cc9pRqa8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F45C4AF09;
	Wed, 26 Jun 2024 01:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719365101;
	bh=uCedbihfRdH1xyeeUQ7hjXi41pyw4dMCk2YV7mdlLYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cc9pRqa8xnleieZjn1ZGJjVo9UHlCuYtq2IOUid1LPfE2gGiSTZ4gxaGKd2v4U+l8
	 cuYX6yuDgFmlISmSwju+uI5M2DsxM7IW8QdkZJm0OJIhFWn9PD74QDjoAjxhweq7Sm
	 CN8CDNgMMmS2+HzAUQcoWgjtnRQlGljVg3rYheLrqX+B2Uo2IaNjEpBMPXQOlYjBv6
	 kVZMp812cHnW3i8gBpuDtuBtu1AIIxUMI9H/PPCBURICeI5UHzpWWxrzR/Pq7GZHyi
	 mnu3xcn1e6vo2z1XR7rDjpu481G8gmMry0qYnfhfCfSTiHWP33anpepdcr6G34ViH3
	 D6+IKMR9P49Tg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	ecree.xilinx@gmail.com,
	dw@davidwei.uk,
	przemyslaw.kitszel@intel.com,
	michael.chan@broadcom.com,
	andrew.gospodarek@broadcom.com,
	leitao@debian.org,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 2/4] selftests: drv-net: add helper to wait for HW stats to sync
Date: Tue, 25 Jun 2024 18:24:54 -0700
Message-ID: <20240626012456.2326192-3-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626012456.2326192-1-kuba@kernel.org>
References: <20240626012456.2326192-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some devices DMA stats to the host periodically. Add a helper
which can wait for that to happen, based on frequency reported
by the driver in ethtool.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - use get() for stats-block-usecs (Petr)
 - fix double space (Petr)
v2:
 - sleep for 25ms on top of the driver DMA period
   (and remove confusing comment)
---
 .../selftests/drivers/net/lib/py/env.py       | 19 ++++++++++++++++++-
 tools/testing/selftests/net/lib/py/utils.py   |  4 ++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index edcedd7bffab..a5e800b8f103 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -1,9 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 
 import os
+import time
 from pathlib import Path
 from lib.py import KsftSkipEx, KsftXfailEx
-from lib.py import cmd, ip
+from lib.py import cmd, ethtool, ip
 from lib.py import NetNS, NetdevSimDev
 from .remote import Remote
 
@@ -82,6 +83,8 @@ from .remote import Remote
 
         self.env = _load_env_file(src_path)
 
+        self._stats_settle_time = None
+
         # Things we try to destroy
         self.remote = None
         # These are for local testing state
@@ -222,3 +225,17 @@ from .remote import Remote
         if remote:
             if not self._require_cmd(comm, "remote"):
                 raise KsftSkipEx("Test requires (remote) command: " + comm)
+
+    def wait_hw_stats_settle(self):
+        """
+        Wait for HW stats to become consistent, some devices DMA HW stats
+        periodically so events won't be reflected until next sync.
+        Good drivers will tell us via ethtool what their sync period is.
+        """
+        if self._stats_settle_time is None:
+            data = ethtool("-c " + self.ifname, json=True)[0]
+
+            self._stats_settle_time = 0.025 + \
+                data.get('stats-block-usecs', 0) / 1000 / 1000
+
+        time.sleep(self._stats_settle_time)
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index dd9d2b9f2b20..a6c87bfe532f 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -79,6 +79,10 @@ import time
     return tool('ip', args, json=json, host=host)
 
 
+def ethtool(args, json=None, ns=None, host=None):
+    return tool('ethtool', args, json=json, ns=ns, host=host)
+
+
 def rand_port():
     """
     Get a random unprivileged port, try to make sure it's not already used.
-- 
2.45.2


