Return-Path: <netdev+bounces-105486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2B89116B8
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 01:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8577E2837DE
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 23:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60519148841;
	Thu, 20 Jun 2024 23:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yeelds3a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B79E145B0C
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718926154; cv=none; b=cFrGdOddgfj92oahhICc0EOh7rRZd5aQVDT9rBVWgfsx5Ac03CSt3t02AriJOijH6/yJMBOX5JRFwfCQ9Amzn3shwKQnhFnvSjbf29zGTlpt2RFbln9LCo4mVda1liSBVJ3jkSrcg6+qpBJbpCZSgo6p1WeljUXi/2vgOlVWUSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718926154; c=relaxed/simple;
	bh=Nrnikk/qobBM6D4ec6hhxHhazQqRTKohQLMN4Ee5kEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAx2YDnAoO1//Gwqqo1kzzVOrZ3F4K8Xmb/v1+U0vjJ2ugUJ0q88gAN0/OvM0UqcB7I8FwdEJigrcxk7UmJkBFGNiVB47IH9PeZTmiJFQfabMODyOs8YYxTfypNEFk4nkM/ByBUt9PMPzmkrfNyxoehDn1ZMbYV6jg6PKNcUaFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yeelds3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0A2C4AF0A;
	Thu, 20 Jun 2024 23:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718926153;
	bh=Nrnikk/qobBM6D4ec6hhxHhazQqRTKohQLMN4Ee5kEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yeelds3aHhLspcmYwWBTREpoQIV517F1gp5XurzbzEfQ0wQIpHJ6wvouVkOEevrdm
	 ZAMuzizwmksONPMKtRR4inJiIau7ZCfH4l8OG22JFvuVtsysSKdlmVK/f8DxZ6qL3W
	 Y7YtdU792LkYCz/01urhoMYUU32jP7NUwO4M7guX+pfAiNmwm2gb393ZqyvLR9MnD1
	 yrHCn+qbp+QsWsWJodjMOwuyb3jBxrIdF4atmoPXPgLDzbWzr29goCiRd83qx7QVbA
	 TsGZ/tlmTDJtGpkp2P4BO/WgF1hY7CQqXleW5jD+15zOncKG8Y3xBrtNDMJRcrr5uw
	 z14MZqjDoNclA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/4] selftests: drv-net: add helper to wait for HW stats to sync
Date: Thu, 20 Jun 2024 16:28:59 -0700
Message-ID: <20240620232902.1343834-3-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240620232902.1343834-1-kuba@kernel.org>
References: <20240620232902.1343834-1-kuba@kernel.org>
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
 .../selftests/drivers/net/lib/py/env.py       | 21 ++++++++++++++++++-
 tools/testing/selftests/net/lib/py/utils.py   |  4 ++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index edcedd7bffab..34f62002b741 100644
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
@@ -222,3 +225,19 @@ from .remote import Remote
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
+            if 'stats-block-usecs' in data:
+                self._stats_settle_time = data['stats-block-usecs'] / 1000 / 1000
+            else:
+                # Assume sync not required, we may use a small (50ms?) sleep
+                # regardless if we see flakiness
+                self._stats_settle_time = 0
+        time.sleep(self._stats_settle_time)
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 9fa9ec720c89..bf8b5e4d9bac 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -78,6 +78,10 @@ import time
     return tool('ip', args, json=json, host=host)
 
 
+def ethtool(args, json=None, ns=None, host=None):
+    return tool('ethtool', args,  json=json, ns=ns, host=host)
+
+
 def rand_port():
     """
     Get unprivileged port, for now just random, one day we may decide to check if used.
-- 
2.45.2


