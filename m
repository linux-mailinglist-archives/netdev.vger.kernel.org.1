Return-Path: <netdev+bounces-160717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B5AA1AEF6
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 04:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C7116BEC6
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 03:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3C31D7E26;
	Fri, 24 Jan 2025 03:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4GusRpD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873C71D79A3
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 03:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737688733; cv=none; b=BYV0r37MlbzQhNg8RMqcRqLkNRGuNd1gEx6KbDAKtc8+1Tc/ljcMNZrjslYKWyOQc6lx5yUpfwMJZTtuQ/NGXsFXB6YenuBZO16s4Q2vv6ySlKWR9T+N7hywqO5j6SYII4/KzBedg5yurdCGBQhl4eayFKPyzFTmqovekUaxXm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737688733; c=relaxed/simple;
	bh=qa2rZAi3N1RbnoDhs7JUcNfFKs/4/RPKTeuiSyvn9nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ca/j7+pptrabhG0fL7Dcqfi/rH2F1O0+1un7NY7VqxLh8E5gxDpp+8sp4iUm/4R74S8NCdB9xGWWw0coJRBDNVtejEQWyoQn6ra1+E40hP50mkUQ9NJfUlxbxXmA5v9bZ3sMviu7lTeNLfiywjCwCohESBiNS6v8wjfCo9g84bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4GusRpD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E0DC4CED2;
	Fri, 24 Jan 2025 03:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737688733;
	bh=qa2rZAi3N1RbnoDhs7JUcNfFKs/4/RPKTeuiSyvn9nY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D4GusRpDZS0C607S67ttErEM/dqEAkzhv2hn2g81eqCG4lb2PT8Be86xT6Gxm7eRB
	 krqDjTlbT0ctMUp2IUyRnZDNEKpN7pbfde3LRXTgH1IQFNcaSas84oeWBwsF37vvLG
	 CO1ozLuVSihtK2V+QwMepM9JhvrOpgYGlgsi1jN1FO8QruI/pZxKM1jslAnTuWaZly
	 tZJHG5arbuNxxXfgAL0vX9zkoSsYT8atBNCwuXivYGmV2jKf2ySo5oYZzSyBS00UEx
	 LpMic0zQbzPgEXi4WKK9sS5eveMR4Nx05vT8ONZ/Vm2E+8Nqfq0M5cB8kOypUqa2+Q
	 mKg3asHT9y3qw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	dan.carpenter@linaro.org,
	Jakub Kicinski <kuba@kernel.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	rain.1986.08.12@gmail.com
Subject: [PATCH net v3 2/7] eth: forcedeth: remove local wrappers for napi enable/disable
Date: Thu, 23 Jan 2025 19:18:36 -0800
Message-ID: <20250124031841.1179756-3-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124031841.1179756-1-kuba@kernel.org>
References: <20250124031841.1179756-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The local helpers for calling napi_enable() and napi_disable()
don't serve much purpose and they will complicate the fix in
the subsequent patch. Remove them, call the core functions
directly.

Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: rain.1986.08.12@gmail.com
---
 drivers/net/ethernet/nvidia/forcedeth.c | 30 +++++++------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/nvidia/forcedeth.c b/drivers/net/ethernet/nvidia/forcedeth.c
index 720f577929db..b00df57f2ca3 100644
--- a/drivers/net/ethernet/nvidia/forcedeth.c
+++ b/drivers/net/ethernet/nvidia/forcedeth.c
@@ -1120,20 +1120,6 @@ static void nv_disable_hw_interrupts(struct net_device *dev, u32 mask)
 	}
 }
 
-static void nv_napi_enable(struct net_device *dev)
-{
-	struct fe_priv *np = get_nvpriv(dev);
-
-	napi_enable(&np->napi);
-}
-
-static void nv_napi_disable(struct net_device *dev)
-{
-	struct fe_priv *np = get_nvpriv(dev);
-
-	napi_disable(&np->napi);
-}
-
 #define MII_READ	(-1)
 /* mii_rw: read/write a register on the PHY.
  *
@@ -3114,7 +3100,7 @@ static int nv_change_mtu(struct net_device *dev, int new_mtu)
 		 * Changing the MTU is a rare event, it shouldn't matter.
 		 */
 		nv_disable_irq(dev);
-		nv_napi_disable(dev);
+		napi_disable(&np->napi);
 		netif_tx_lock_bh(dev);
 		netif_addr_lock(dev);
 		spin_lock(&np->lock);
@@ -3143,7 +3129,7 @@ static int nv_change_mtu(struct net_device *dev, int new_mtu)
 		spin_unlock(&np->lock);
 		netif_addr_unlock(dev);
 		netif_tx_unlock_bh(dev);
-		nv_napi_enable(dev);
+		napi_enable(&np->napi);
 		nv_enable_irq(dev);
 	}
 	return 0;
@@ -4731,7 +4717,7 @@ static int nv_set_ringparam(struct net_device *dev,
 
 	if (netif_running(dev)) {
 		nv_disable_irq(dev);
-		nv_napi_disable(dev);
+		napi_disable(&np->napi);
 		netif_tx_lock_bh(dev);
 		netif_addr_lock(dev);
 		spin_lock(&np->lock);
@@ -4784,7 +4770,7 @@ static int nv_set_ringparam(struct net_device *dev,
 		spin_unlock(&np->lock);
 		netif_addr_unlock(dev);
 		netif_tx_unlock_bh(dev);
-		nv_napi_enable(dev);
+		napi_enable(&np->napi);
 		nv_enable_irq(dev);
 	}
 	return 0;
@@ -5277,7 +5263,7 @@ static void nv_self_test(struct net_device *dev, struct ethtool_test *test, u64
 	if (test->flags & ETH_TEST_FL_OFFLINE) {
 		if (netif_running(dev)) {
 			netif_stop_queue(dev);
-			nv_napi_disable(dev);
+			napi_disable(&np->napi);
 			netif_tx_lock_bh(dev);
 			netif_addr_lock(dev);
 			spin_lock_irq(&np->lock);
@@ -5334,7 +5320,7 @@ static void nv_self_test(struct net_device *dev, struct ethtool_test *test, u64
 			/* restart rx engine */
 			nv_start_rxtx(dev);
 			netif_start_queue(dev);
-			nv_napi_enable(dev);
+			napi_enable(&np->napi);
 			nv_enable_hw_interrupts(dev, np->irqmask);
 		}
 	}
@@ -5594,7 +5580,7 @@ static int nv_open(struct net_device *dev)
 	ret = nv_update_linkspeed(dev);
 	nv_start_rxtx(dev);
 	netif_start_queue(dev);
-	nv_napi_enable(dev);
+	napi_enable(&np->napi);
 
 	if (ret) {
 		netif_carrier_on(dev);
@@ -5632,7 +5618,7 @@ static int nv_close(struct net_device *dev)
 	spin_lock_irq(&np->lock);
 	np->in_shutdown = 1;
 	spin_unlock_irq(&np->lock);
-	nv_napi_disable(dev);
+	napi_disable(&np->napi);
 	synchronize_irq(np->pci_dev->irq);
 
 	del_timer_sync(&np->oom_kick);
-- 
2.48.1


