Return-Path: <netdev+bounces-109334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1127927FF6
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 03:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8483B1F235D9
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 01:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12511BF2B;
	Fri,  5 Jul 2024 01:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2S7C8V5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C40B1BC4F
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 01:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720144654; cv=none; b=tZtLipmdAQnoyqVhkE7Epm+xeTMSE/rr2j+YCM1yFbXUblO5J408WkvLVP+6PRbpSbAlnWcRL0TLK/G5q32dCguqT04xUThI9JG063jaV+iQpEYUftuWRNBLSklpc1nRWOCYMEXHF3Psoer98E1EkBR1mc3E//veNUWxWSj3k/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720144654; c=relaxed/simple;
	bh=SIbEuTYh7K8QI/UY5f50+6n9Ap0yERyXt1+AyA5bq7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Suwk2owS9/9g3EKZvJWs6Ub7t4pklIA6ejNKbGZOMwlp+9NtFSAQmPVLtGvkF2XeJIfqUJImmgK/+PoEboIzlvdlkHwgcxT1UFLOW2dSsL5RRLTbL0/8WAAaM5vAmZDliauMLugXJCagA/VWm2XY1ybVmvdG0XIhQ5bTdProsCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2S7C8V5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3726C32781;
	Fri,  5 Jul 2024 01:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720144654;
	bh=SIbEuTYh7K8QI/UY5f50+6n9Ap0yERyXt1+AyA5bq7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y2S7C8V5RCbYWdT6YwyrpTcdMLAzHfT6AmwTMP4ez2zMObpJC+LseM1aj2r+UoFhl
	 5EbV4qadRuu6QgB5Zv1ElKaeAvHlWIDWQnx+cfkJ4T0i2GEQytXT+09uy7a2BVT9a5
	 QGcNLKMLo9Fig/2GH9CyQh1ryX8fptYMYILh1N/ofNl9D6Y3yZCJMiMjblu42aHtSu
	 j59C13vIniB3q3gC+M5x+0NYt4YTB0dX56o73w9OIvOoTxtN7WX8biRYsx5/oaKGAr
	 1bAAG0nXPCs6kBp0O+0ndKA3/PDerDypYIIEWUEvrzRAsMVl34gYNZ4sGIclVn4Q64
	 KE22WNvPERmxw==
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
Subject: [PATCH net-next 5/5] selftests: drv-net: rss_ctx: test flow rehashing without impacting traffic
Date: Thu,  4 Jul 2024 18:57:25 -0700
Message-ID: <20240705015725.680275-6-kuba@kernel.org>
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

Some workloads may want to rehash the flows in response to an imbalance.
Most effective way to do that is changing the RSS key. Check that changing
the key does not cause link flaps or traffic disruption.

Disrupting traffic for key update is not incorrect, but makes the key
update unusable for rehashing under load.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/hw/rss_ctx.py       | 32 ++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index f42807e39e0d..3c47ddc509e7 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -236,6 +236,36 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
             f"Table imbalance after resize: {data['rss-indirection-table']}")
 
 
+def test_hitless_key_update(cfg):
+    """Test that flows may be rehashed without impacting traffic.
+
+    Some workloads may want to rehash the flows in response to an imbalance.
+    Most effective way to do that is changing the RSS key. Check that changing
+    the key does not cause link flaps or traffic disruption.
+
+    Disrupting traffic for key update is not a bug, but makes the key
+    update unusable for rehashing under load.
+    """
+    data = get_rss(cfg)
+    key_len = len(data['rss-hash-key'])
+
+    key = _rss_key_rand(key_len)
+
+    tgen = GenerateTraffic(cfg)
+    try:
+        errors0, carrier0 = get_drop_err_sum(cfg)
+        t0 = datetime.datetime.now()
+        ethtool(f"-X {cfg.ifname} hkey " + _rss_key_str(key))
+        t1 = datetime.datetime.now()
+        errors1, carrier1 = get_drop_err_sum(cfg)
+    finally:
+        tgen.wait_pkts_and_stop(5000)
+
+    ksft_lt((t1 - t0).total_seconds(), 0.2)
+    ksft_eq(errors1 - errors1, 0)
+    ksft_eq(carrier1 - carrier0, 0)
+
+
 def test_rss_context(cfg, ctx_cnt=1, create_with_cfg=None):
     """
     Test separating traffic into RSS contexts.
@@ -471,7 +501,7 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
         cfg.netdevnl = NetdevFamily()
 
         ksft_run([test_rss_key_indir, test_rss_queue_reconfigure,
-                  test_rss_resize,
+                  test_rss_resize, test_hitless_key_update,
                   test_rss_context, test_rss_context4, test_rss_context32,
                   test_rss_context_queue_reconfigure,
                   test_rss_context_overlap, test_rss_context_overlap2,
-- 
2.45.2


