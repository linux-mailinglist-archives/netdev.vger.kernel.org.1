Return-Path: <netdev+bounces-109332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FFC927FF4
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 03:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C553A287898
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 01:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45771758D;
	Fri,  5 Jul 2024 01:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rp3UepNl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDE31755A
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 01:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720144653; cv=none; b=Aj3kaZNyCupv9urplGC7EGena/DxgCnDskjGcvQ9UKu6OVFyDaBf08II8BEjMHJUw5BzmTcxY5oEAk0W+SCqUGAZ38HvS/113S1cumUwxPi+VZV4g4FKFykwi/+M4azxrAfmQkWq/rKqskbFnl8Frob+NdfLdE6mXpMMTpFW24I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720144653; c=relaxed/simple;
	bh=eXbbCNsf+ReqjmKdPjkK+/bd3F2B/dRrYSaWfd5Ed3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ljar3b/+066WF/kGiVN9o5Jt+TYNFMLUjRqH9Dig7s/8YUp/N02S/VPop0rmUl434Np3QROyoiwvVmH5AcNlOpoYRr2bQEj4+sECi29eAVr53elgFH2cUwZbKk40+GKywTbSeiJBFsl6eLn+AAkEiu0lWZdvFncRDWOKnT1srxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rp3UepNl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31EFC4AF10;
	Fri,  5 Jul 2024 01:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720144653;
	bh=eXbbCNsf+ReqjmKdPjkK+/bd3F2B/dRrYSaWfd5Ed3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rp3UepNlTQxPAAdM1uRSb/fQBysCZKylrCwSdFPuXN3fedJ/IoGH9t0qT1j0EvSUr
	 6RnUFVOHgGGlOmhnW+FnG3JSbz/y62sLiM1xq/daoaBQ7uYTs6Zg4RuXyGz7MdFkuK
	 ElisefIsk7ihRvBx6S4wYbQMUAmRgKGwoPkJ4ZQP5ITJ1MQsfmr4UHHojxYR1Ei0Fz
	 RYRy/F8bLF/4jxKU0Zg7kyBMWdQ1jx727Cs6Apf//zQUE/4i7tuM4XdFYZbSbUIgZv
	 4Rr5ecmmgyXMgBtB/zRnHtp8mppTmvD57thd1m/E6bb7pG56piRkooQocfJr0qhRbr
	 U5SJaRE5TzYDg==
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
Subject: [PATCH net-next 3/5] selftests: drv-net: rss_ctx: test queue changes vs user RSS config
Date: Thu,  4 Jul 2024 18:57:23 -0700
Message-ID: <20240705015725.680275-4-kuba@kernel.org>
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

By default main RSS table should change to include all queues.
When user sets a specific RSS config the driver should preserve it,
even when queue count changes. Driver should refuse to deactivate
queues used in the user-set RSS config.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/hw/rss_ctx.py       | 81 ++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index a95842baef99..fbc234d6c395 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -129,6 +129,80 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
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
@@ -207,6 +281,10 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
     test_rss_context(cfg, 4, create_with_cfg=True)
 
 
+def test_rss_context_queue_reconfigure(cfg):
+    test_rss_queue_reconfigure(cfg, main_ctx=False)
+
+
 def test_rss_context_out_of_order(cfg, ctx_cnt=4):
     """
     Test separating traffic into RSS contexts.
@@ -358,8 +436,9 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
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


