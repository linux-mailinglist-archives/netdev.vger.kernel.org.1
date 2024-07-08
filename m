Return-Path: <netdev+bounces-110030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A7C92AB57
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 23:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C7DF1F22C95
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 21:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E8314F117;
	Mon,  8 Jul 2024 21:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJDfzfqN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D698214EC65
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 21:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720474597; cv=none; b=kGYvLnr0fOkvp4i+O24PdG/S24BMQoLT8AhIIDFRZ8eqVLds6qbbGmytZAvF2G1FWfd/iZJfu2h77CyRq92d91eN1sM43MD4tgiuyBQq3su1fiAcDdhrNy3itlxY1znEk4GeCusAFrC4e34sMPQy6ARhkDpVt7epmDwtp/xv5wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720474597; c=relaxed/simple;
	bh=VmsaBkh0kHzjYcEsMgjF+VALV24jkAW1Cjr6XJRu/AM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VsXG0/r32qAKaQkzCz/SCuL3TIRazeTukJfqN0lY1Jp7ZKo87mkpoSaJGDTYa9NYFqXW/qKlMaktl//AGypYvmVpJdCTfaRwqu+3bmce0k5fqTBIGb/+QIxk1yFQR4DA21rHCCZuULl4d9P93D2fNeOE11n/2dFlHMxnMPdNVwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJDfzfqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4345AC4AF0D;
	Mon,  8 Jul 2024 21:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720474597;
	bh=VmsaBkh0kHzjYcEsMgjF+VALV24jkAW1Cjr6XJRu/AM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oJDfzfqNfeTP5fYcRtIx2yZ9rDUPG3wms4TRlkfdN51Dswih6hPmFYZYEy9P9oYdq
	 64Mnv586Rl35pwUgyH5hQt6J9UlFMc5BnCIUb61Jn9DRlQMScmGQUvvfxPEO1rGAzd
	 Cm80XBBDLe5KQFmxaHDDnCk2okki7PInjxJHFMfOQzWcHOpnut3/Q1KJ3PQVPLvX6j
	 alkfCvSpVM+m6wQCkPB9NIcsufce05VOFoS5zU+eh6jDMMy5PiVcZwkWH5AbVFI4xe
	 2C4By4MQSpO3loBe0JpHTgA20dYyBKbHtT40jZSfXajguEwANwSM2OTuzgLdeV0YL2
	 7fBN8dRqHy52w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	petrm@nvidia.com,
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 2/5] selftests: drv-net: rss_ctx: factor out send traffic and check
Date: Mon,  8 Jul 2024 14:36:24 -0700
Message-ID: <20240708213627.226025-3-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240708213627.226025-1-kuba@kernel.org>
References: <20240708213627.226025-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wrap up sending traffic and checking in which queues it landed
in a helper.

The method used for testing is to send a lot of iperf traffic
and check which queues received the most packets. Those should
be the queues where we expect iperf to land - either because we
installed a filter for the port iperf uses, or we didn't and
expect it to use context 0.

Contexts get disjoint queue sets, but the main context (AKA context 0)
may receive some background traffic (noise).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: add a comment
---
 .../selftests/drivers/net/hw/rss_ctx.py       | 58 +++++++++++++------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index de2a55c0f35c..ede8eee1d9a9 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -63,6 +63,30 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
     return queue_stats
 
 
+def _send_traffic_check(cfg, port, name, params):
+    # params is a dict with 3 possible keys:
+    #  - "target": required, which queues we expect to get iperf traffic
+    #  - "empty": optional, which queues should see no traffic at all
+    #  - "noise": optional, which queues we expect to see low traffic;
+    #             used for queues of the main context, since some background
+    #             OS activity may use those queues while we're testing
+    # the value for each is a list, or some other iterable containing queue ids.
+
+    cnts = _get_rx_cnts(cfg)
+    GenerateTraffic(cfg, port=port).wait_pkts_and_stop(20000)
+    cnts = _get_rx_cnts(cfg, prev=cnts)
+
+    directed = sum(cnts[i] for i in params['target'])
+
+    ksft_ge(directed, 20000, f"traffic on {name}: " + str(cnts))
+    if params.get('noise'):
+        ksft_lt(sum(cnts[i] for i in params['noise']), directed / 2,
+                "traffic on other queues:" + str(cnts))
+    if params.get('empty'):
+        ksft_eq(sum(cnts[i] for i in params['empty']), 0,
+                "traffic on inactive queues: " + str(cnts))
+
+
 def test_rss_key_indir(cfg):
     """Test basics like updating the main RSS key and indirection table."""
 
@@ -170,15 +194,10 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
         defer(ethtool, f"-N {cfg.ifname} delete {ntuple}")
 
     for i in range(ctx_cnt):
-        cnts = _get_rx_cnts(cfg)
-        GenerateTraffic(cfg, port=ports[i]).wait_pkts_and_stop(20000)
-        cnts = _get_rx_cnts(cfg, prev=cnts)
-
-        directed = sum(cnts[2+i*2:4+i*2])
-
-        ksft_lt(sum(cnts[ :2]), directed / 2, "traffic on main context:" + str(cnts))
-        ksft_ge(directed, 20000, f"traffic on context {i}: " + str(cnts))
-        ksft_eq(sum(cnts[2:2+i*2] + cnts[4+i*2:]), 0, "traffic on other contexts: " + str(cnts))
+        _send_traffic_check(cfg, ports[i], f"context {i}",
+                            { 'target': (2+i*2, 3+i*2),
+                              'noise': (0, 1),
+                              'empty': list(range(2, 2+i*2)) + list(range(4+i*2, 2+2*ctx_cnt)) })
 
     if requested_ctx_cnt != ctx_cnt:
         raise KsftSkipEx(f"Tested only {ctx_cnt} contexts, wanted {requested_ctx_cnt}")
@@ -230,18 +249,19 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
 
     def check_traffic():
         for i in range(ctx_cnt):
-            cnts = _get_rx_cnts(cfg)
-            GenerateTraffic(cfg, port=ports[i]).wait_pkts_and_stop(20000)
-            cnts = _get_rx_cnts(cfg, prev=cnts)
-
             if ctx[i]:
-                directed = sum(cnts[2+i*2:4+i*2])
-                ksft_lt(sum(cnts[ :2]), directed / 2, "traffic on main context:" + str(cnts))
-                ksft_ge(directed, 20000, f"traffic on context {i}: " + str(cnts))
-                ksft_eq(sum(cnts[2:2+i*2] + cnts[4+i*2:]), 0, "traffic on other contexts: " + str(cnts))
+                expected = {
+                    'target': (2+i*2, 3+i*2),
+                    'noise': (0, 1),
+                    'empty': list(range(2, 2+i*2)) + list(range(4+i*2, 2+2*ctx_cnt))
+                }
             else:
-                ksft_ge(sum(cnts[ :2]), 20000, "traffic on main context:" + str(cnts))
-                ksft_eq(sum(cnts[2: ]),     0, "traffic on other contexts: " + str(cnts))
+                expected = {
+                    'target': (0, 1),
+                    'empty':  range(2, 2+2*ctx_cnt)
+                }
+
+            _send_traffic_check(cfg, ports[i], f"context {i}", expected)
 
     # Use queues 0 and 1 for normal traffic
     ethtool(f"-X {cfg.ifname} equal 2")
-- 
2.45.2


