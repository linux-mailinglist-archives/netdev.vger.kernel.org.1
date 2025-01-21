Return-Path: <netdev+bounces-160135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2F5A187A1
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 23:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232AB188B89A
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 22:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4FF1F8AEF;
	Tue, 21 Jan 2025 22:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZux5Coi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464711F8AE6
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 22:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737497727; cv=none; b=OKC/Rf1W5isL6mO3+Sb/R6lvDcjX7wW1HuqXhbGG74zx+nrphIsjbDPM5H1f2xu9pEYoIJBLh9jIYVYqQySknjFx61tEU0K/6787BNp5TgpUnmPfQXkdTr6QHsD3tGmg17/RTx7Im2iMms6gcS2wA2WcfmZeTX3NFMrqGCfAPQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737497727; c=relaxed/simple;
	bh=z00kmMyXY2/5bFGvlL+tcZ3FTH6GxHgP3WJl/7v0/Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzj3vnUAHG3HZlJ6OpfeeQRqRvtjthaNNmg3W+tDEPo2YFMmqVB+SAwQY5O9BA9PA1oEaAknS3iwSTBwlYxwe2yYqW6sCm+BzrNSEeNRfh5OKxo9WcWelKArfT+FghWqqipkQ7uoi+MaA1l3S5Pq3XIb7MPchyy9RERFKRuhC5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZux5Coi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94916C4CEE3;
	Tue, 21 Jan 2025 22:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737497726;
	bh=z00kmMyXY2/5bFGvlL+tcZ3FTH6GxHgP3WJl/7v0/Nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZZux5Coi4TeI2By/s5xkNJX3720S4MEUHm7UIJp8cv5JOfcukz6UdQ/oTgUcIF9fB
	 InBemircrFYNiGAavtZaeywkD/RkBd9YZGrfDiqNiJg/ARDT+n+iT7z63B97phBd1Z
	 N2qtVa/XVhYGTNgl4GwJq/SeWaj6Z7g/MHVSee8d1Ek2xxc+UPlJtlGbyfOXTtovou
	 fEddbJHiv6u8XPdQgXjjdFzkPpJHSdqG6uNIsI5e59wqPCc7l+QJBklUqB42ZMUyRC
	 IKauCBrTrrclFtAH2dEbpWFpW2dRcgL8SP5YJcQhs6P1tQD2zOgXuPAQFgHqW3Goih
	 s/sheFR4Z114A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	dan.carpenter@linaro.org,
	Jakub Kicinski <kuba@kernel.org>,
	rain.1986.08.12@gmail.com,
	zyjzyj2000@gmail.com
Subject: [PATCH net-next 2/7] eth: forcedeth: remove local wrappers for napi enable/disable
Date: Tue, 21 Jan 2025 14:15:14 -0800
Message-ID: <20250121221519.392014-3-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250121221519.392014-1-kuba@kernel.org>
References: <20250121221519.392014-1-kuba@kernel.org>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: rain.1986.08.12@gmail.com
CC: zyjzyj2000@gmail.com
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


