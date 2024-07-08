Return-Path: <netdev+bounces-110031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CB192AB58
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 23:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118481C21E0D
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 21:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911A014F9D2;
	Mon,  8 Jul 2024 21:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/GlJg4Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFD014F9C4
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 21:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720474598; cv=none; b=bEH14Mxm/qEo6ow/qNh0ECZdbT7l6GcTo3JngUZ/b4+XVyH6WcyVhjnzYofgUpWoEAiVbRy81YZctIHjEDwkKpZ6BeEzfwcIZi0cMWgNH12sB57SwU1K39oxP3y9fYfyXc9ASYqOzRbLmG61I2HGn4AHOlbG0MdbZHi0Gqr5mUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720474598; c=relaxed/simple;
	bh=PJlCdL5g0Bjp+86/aLrza2mFoEZinUvGRzqaWZv2xbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UqJCdkP+WORzhUgaGJDpKDV2ikbEjurlBJkQQipKMEUuR56b0OAc7RdUXMlScSaYip71olD1Xr4HEzj2zBJvlfTon/4gZBTz5OZBtL8vzjhEtNEPDqe79VzldWQHE/VVfvbt1e0TVV4T386Yx94qNotQlAE17QkolHAzVi/fQVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/GlJg4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF380C4AF0E;
	Mon,  8 Jul 2024 21:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720474598;
	bh=PJlCdL5g0Bjp+86/aLrza2mFoEZinUvGRzqaWZv2xbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g/GlJg4YM66+tBJCDggvyYUh0TwdPwK+AV+1xlvCEih3MIAkxQghrUnQflpEoFA4V
	 EjvAcqWxhw9Mo6DWiS6jXbsosHPpgD7HwCEb+1EKfnjp4XG3xPv0uIBY9zpUKfBV0L
	 rAraKk6Jugt8h0XS3YVEpo5AiFQY2Q2GFfEqDoP096+AcEXMyXIM1X6hd8nAP+1Rfm
	 A9lgQMkO9rzRHvNE+P7JtGdEbOGa80LnrPLti5zASGKOsxVqkezqD3S9XaM7ARfu9s
	 t6M1GJ6TgARigEY3/BQdnyZPVC8rpTK5JYiZyPO+lPmk5BP/ahyIUS8p8/9y5i3Nnc
	 eKQUJKFD/2wug==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	petrm@nvidia.com,
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 3/5] selftests: drv-net: rss_ctx: test queue changes vs user RSS config
Date: Mon,  8 Jul 2024 14:36:25 -0700
Message-ID: <20240708213627.226025-4-kuba@kernel.org>
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

By default main RSS table should change to include all queues.
When user sets a specific RSS config the driver should preserve it,
even when queue count changes. Driver should refuse to deactivate
queues used in the user-set RSS config.

For additional contexts driver should still refuse to deactivate
queues in use. Whether the contexts should get resized like
context 0 when queue count increases is a bit unclear. I anticipate
most driver today don't do that. Since main use case for additional
contexts is to set the indir table - it doesn't seem worthwhile to
care about behavior of the default table too much. Don't test that.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/hw/rss_ctx.py       | 81 ++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index ede8eee1d9a9..177abfd06412 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -137,6 +137,80 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
     ksft_lt(sum(cnts[:2]), sum(cnts[2:]), "traffic distributed: " + str(cnts))
 
 
+def test_rss_queue_reconfigure(cfg, main_ctx=True):
+    """Make sure queue changes can't override requested RSS config.
+
+    By default main RSS table should change to include all queues.
+    When user sets a specific RSS config the driver should preserve it,
+    even when queue count changes. Driver should refuse to deactivate
+    queues used in the user-set RSS config.
+    """
+
+    if not main_ctx:
+        require_ntuple(cfg)
+
+    # Start with 4 queues, an arbitrary known number.
+    try:
+        qcnt = len(_get_rx_cnts(cfg))
+        ethtool(f"-L {cfg.ifname} combined 4")
+        defer(ethtool, f"-L {cfg.ifname} combined {qcnt}")
+    except:
+        raise KsftSkipEx("Not enough queues for the test or qstat not supported")
+
+    if main_ctx:
+        ctx_id = 0
+        ctx_ref = ""
+    else:
+        ctx_id = ethtool_create(cfg, "-X", "context new")
+        ctx_ref = f"context {ctx_id}"
+        defer(ethtool, f"-X {cfg.ifname} {ctx_ref} delete")
+
+    # Indirection table should be distributing to all queues.
+    data = get_rss(cfg, context=ctx_id)
+    ksft_eq(0, min(data['rss-indirection-table']))
+    ksft_eq(3, max(data['rss-indirection-table']))
+
+    # Increase queues, indirection table should be distributing to all queues.
+    # It's unclear whether tables of additional contexts should be reset, too.
+    if main_ctx:
+        ethtool(f"-L {cfg.ifname} combined 5")
+        data = get_rss(cfg)
+        ksft_eq(0, min(data['rss-indirection-table']))
+        ksft_eq(4, max(data['rss-indirection-table']))
+        ethtool(f"-L {cfg.ifname} combined 4")
+
+    # Configure the table explicitly
+    port = rand_port()
+    ethtool(f"-X {cfg.ifname} {ctx_ref} weight 1 0 0 1")
+    if main_ctx:
+        other_key = 'empty'
+        defer(ethtool, f"-X {cfg.ifname} default")
+    else:
+        other_key = 'noise'
+        flow = f"flow-type tcp{cfg.addr_ipver} dst-port {port} context {ctx_id}"
+        ntuple = ethtool_create(cfg, "-N", flow)
+        defer(ethtool, f"-N {cfg.ifname} delete {ntuple}")
+
+    _send_traffic_check(cfg, port, ctx_ref, { 'target': (0, 3),
+                                              other_key: (1, 2) })
+
+    # We should be able to increase queues, but table should be left untouched
+    ethtool(f"-L {cfg.ifname} combined 5")
+    data = get_rss(cfg, context=ctx_id)
+    ksft_eq({0, 3}, set(data['rss-indirection-table']))
+
+    _send_traffic_check(cfg, port, ctx_ref, { 'target': (0, 3),
+                                              other_key: (1, 2, 4) })
+
+    # Setting queue count to 3 should fail, queue 3 is used
+    try:
+        ethtool(f"-L {cfg.ifname} combined 3")
+    except CmdExitFailure:
+        pass
+    else:
+        raise Exception(f"Driver didn't prevent us from deactivating a used queue (context {ctx_id})")
+
+
 def test_rss_context(cfg, ctx_cnt=1, create_with_cfg=None):
     """
     Test separating traffic into RSS contexts.
@@ -215,6 +289,10 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
     test_rss_context(cfg, 4, create_with_cfg=True)
 
 
+def test_rss_context_queue_reconfigure(cfg):
+    test_rss_queue_reconfigure(cfg, main_ctx=False)
+
+
 def test_rss_context_out_of_order(cfg, ctx_cnt=4):
     """
     Test separating traffic into RSS contexts.
@@ -366,8 +444,9 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
     with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
         cfg.netdevnl = NetdevFamily()
 
-        ksft_run([test_rss_key_indir,
+        ksft_run([test_rss_key_indir, test_rss_queue_reconfigure,
                   test_rss_context, test_rss_context4, test_rss_context32,
+                  test_rss_context_queue_reconfigure,
                   test_rss_context_overlap, test_rss_context_overlap2,
                   test_rss_context_out_of_order, test_rss_context4_create_with_cfg],
                  args=(cfg, ))
-- 
2.45.2


