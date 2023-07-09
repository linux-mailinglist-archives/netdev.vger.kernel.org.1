Return-Path: <netdev+bounces-16261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8F174C59A
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 17:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128341C20960
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 15:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8015C143;
	Sun,  9 Jul 2023 15:14:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE7BFBEB
	for <netdev@vger.kernel.org>; Sun,  9 Jul 2023 15:14:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0724C433CB;
	Sun,  9 Jul 2023 15:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688915666;
	bh=xbH6wIwOZG5M2DaP0ZJgalD+ZaD9fshGC5PX0Sdww5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S5lF5mDS68PSVBTZPlZ2tK0skk7qG5YYZ7Zv+WlQrvT48PiWO2slKPl9amolNOff+
	 Tck6kZsBuxpRWM/wt/MYf11ltRLhgtrJckFk8d7r7dVoJ3U76454NTJ4fqLFQYx1pI
	 Q4NLvYQIKYEkviRcmyjqGfcx3zB6/M4/gVXdslghDrob/pYubMSmlgZbKCYiV4OXvT
	 EaU0xTbkdkgKUDnMJJtiHft+uUHZzcCIBL3bX10XJT5wtdD/9ijqZ20oEMy9xxSJ+o
	 0loIDEXTddSX5ocsuuPKWB2P0Sehdo9VzylIXpnROXC6+eelPh3Y6R/gbl3jQpHLmV
	 ScDUAHtewzn2g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Simon Horman <simon.horman@corigine.com>,
	Gabriel Somlo <gsomlo@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kgugala@antmicro.com,
	mholenko@antmicro.com,
	joel@jms.id.au,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 15/22] net: ethernet: litex: add support for 64 bit stats
Date: Sun,  9 Jul 2023 11:13:49 -0400
Message-Id: <20230709151356.513279-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709151356.513279-1-sashal@kernel.org>
References: <20230709151356.513279-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.12
Content-Transfer-Encoding: 8bit

From: Jisheng Zhang <jszhang@kernel.org>

[ Upstream commit 18da174d865a87d47d2f33f5b0a322efcf067728 ]

Implement 64 bit per cpu stats to fix the overflow of netdev->stats
on 32 bit platforms. To simplify the code, we use net core
pcpu_sw_netstats infrastructure. One small drawback is some memory
overhead because litex uses just one queue, but we allocate the
counters per cpu.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Acked-by: Gabriel Somlo <gsomlo@gmail.com>
Link: https://lore.kernel.org/r/20230614162035.300-1-jszhang@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/litex/litex_liteeth.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/litex/litex_liteeth.c b/drivers/net/ethernet/litex/litex_liteeth.c
index 35f24e0f09349..ffa96059079c6 100644
--- a/drivers/net/ethernet/litex/litex_liteeth.c
+++ b/drivers/net/ethernet/litex/litex_liteeth.c
@@ -78,8 +78,7 @@ static int liteeth_rx(struct net_device *netdev)
 	memcpy_fromio(data, priv->rx_base + rx_slot * priv->slot_size, len);
 	skb->protocol = eth_type_trans(skb, netdev);
 
-	netdev->stats.rx_packets++;
-	netdev->stats.rx_bytes += len;
+	dev_sw_netstats_rx_add(netdev, len);
 
 	return netif_rx(skb);
 
@@ -185,8 +184,7 @@ static netdev_tx_t liteeth_start_xmit(struct sk_buff *skb,
 	litex_write16(priv->base + LITEETH_READER_LENGTH, skb->len);
 	litex_write8(priv->base + LITEETH_READER_START, 1);
 
-	netdev->stats.tx_bytes += skb->len;
-	netdev->stats.tx_packets++;
+	dev_sw_netstats_tx_add(netdev, 1, skb->len);
 
 	priv->tx_slot = (priv->tx_slot + 1) % priv->num_tx_slots;
 	dev_kfree_skb_any(skb);
@@ -194,9 +192,17 @@ static netdev_tx_t liteeth_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
+static void
+liteeth_get_stats64(struct net_device *netdev, struct rtnl_link_stats64 *stats)
+{
+	netdev_stats_to_stats64(stats, &netdev->stats);
+	dev_fetch_sw_netstats(stats, netdev->tstats);
+}
+
 static const struct net_device_ops liteeth_netdev_ops = {
 	.ndo_open		= liteeth_open,
 	.ndo_stop		= liteeth_stop,
+	.ndo_get_stats64	= liteeth_get_stats64,
 	.ndo_start_xmit         = liteeth_start_xmit,
 };
 
@@ -242,6 +248,11 @@ static int liteeth_probe(struct platform_device *pdev)
 	priv->netdev = netdev;
 	priv->dev = &pdev->dev;
 
+	netdev->tstats = devm_netdev_alloc_pcpu_stats(&pdev->dev,
+						      struct pcpu_sw_netstats);
+	if (!netdev->tstats)
+		return -ENOMEM;
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
-- 
2.39.2


