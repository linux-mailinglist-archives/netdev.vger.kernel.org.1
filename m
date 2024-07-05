Return-Path: <netdev+bounces-109331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4813927FF3
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 03:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58BF4287A14
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 01:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD56014AB2;
	Fri,  5 Jul 2024 01:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tN4Nt+d1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71E7134DE
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 01:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720144652; cv=none; b=p0Z4VvY/kg49AWJPHXn1Spuhw6C+TSB2L10QsI/gQZLtxrhLr2EWirZVVGMOJkeblKQnDP1dBBRI5aQ+yu88gFf3juds2LA6tGWDSJA+HQ1CKkWavP8kLTh5zCnJktWaOIAOJv/v1uJB9YzxkV8RS0A5qjN1ICXn4wg0TgmT5eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720144652; c=relaxed/simple;
	bh=uj/ZOAC817aZgRZn1gmoCzMHp2tttnLPKaiySG0pFio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gYNIdlT9IT8WoDzfdoYHodYbZD14/15c7SDYMEpEclBPEMEqCNJhZGubWeZICq4+R/Y9ecqTDDlp7+PwR+454HgbYV/xKbpwz+gOGeAPXQGQyIyr05klVVsDkbOWcv5n8ireU75uRsjf3+51YVUO3T8KE9Zz5CYfAsPfZLo+AZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tN4Nt+d1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29600C32781;
	Fri,  5 Jul 2024 01:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720144652;
	bh=uj/ZOAC817aZgRZn1gmoCzMHp2tttnLPKaiySG0pFio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tN4Nt+d1zv0NsLkQeDR6Chj+z1J13eZLW8RTmKk2PU0HoEFMDLyBjnGn1yU6F+7Xa
	 0+Xmb+7S89jYS6Hq8kRmQTMeaBS/GOp9XdFxky4ekal6NfrCVALqc6grXcDRPeExgY
	 x0DIpn6YQk0+j+T7ufHGn7npperlaESCvhuAteO7oRqrqICEr3ddBoVK67U8Vy6XbH
	 VUkOeQ4C5IGteDDJurTZc6M6wbqrDvS3jIVjNoN78NqelQ0S7+paRaWTLnxMfdw12/
	 +/6zaYUi74Pm8Xk6BkNZ5b830t/ZmZJxfWqTWqCB0Ca5iGgipEhERO9u5KR6j0V6Le
	 acn0NmK8//8Pw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	petrm@nvidia.com,
	przemyslaw.kitszel@intel.com,
	willemdebruijn.kernel@gmail.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/5] selftests: drv-net: rss_ctx: factor out send traffic and check
Date: Thu,  4 Jul 2024 18:57:22 -0700
Message-ID: <20240705015725.680275-3-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705015725.680275-1-kuba@kernel.org>
References: <20240705015725.680275-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wrap up sending traffic and checking in which queues it landed
in a helper.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/hw/rss_ctx.py       | 50 ++++++++++++-------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index de2a55c0f35c..a95842baef99 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -63,6 +63,22 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
     return queue_stats
 
 
+def _send_traffic_check(cfg, port, name, params):
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
 
@@ -170,15 +186,10 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
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
@@ -230,18 +241,19 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
 
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
+                    'target': range(2),
+                    'empty':  range(2, 2+2*ctx_cnt)
+                }
+
+            _send_traffic_check(cfg, ports[i], f"context {i}", expected)
 
     # Use queues 0 and 1 for normal traffic
     ethtool(f"-X {cfg.ifname} equal 2")
-- 
2.45.2


