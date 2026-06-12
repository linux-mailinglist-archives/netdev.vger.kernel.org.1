Return-Path: <netdev+bounces-298795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RSPDJ7ZzLGoJRAQAu9opvQ
	(envelope-from <netdev+bounces-298795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 23:01:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2A667C6A3
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 23:01:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b=DjdZcnJz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298795-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298795-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB82B3248918
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 21:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4C43812EB;
	Fri, 12 Jun 2026 21:00:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0342376A1A;
	Fri, 12 Jun 2026 21:00:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781298010; cv=none; b=AlZIuPlvw9beRhBwLKIX/CL2c/D4jRBF5Y6cmH/Yog1e1tOqLFKy5UZOJrn081wh9C0sv1eCVfn3NR2xOU4T+L+XkpUU1tkx+OldUVlmJA3aOL1dzwSE4J1ifwMkASu4xOaV7XlrzUW71r3wzNMZEqTwDFruYoc2HrRwTWIDZtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781298010; c=relaxed/simple;
	bh=CgCiq1pGm9qVLeGZ+6QKUElzhNqdZYl254enpf4n9zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Omq2Negvd2mhachqBUgEEbASohZR8ywIXHkK07cRzcAY/ROkRvxfNsBwuaf/8ZaAUq+VowLBH9A2koPSHqGIQpy0J/3HmsL1mp2OIngfGVIT2i+aMzzXgNrLzXJnbVidioOerdNYks/+dMGAcMG1ktTIiSqY7ExBok7pJdH/o6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=DjdZcnJz; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C74E8A4F7A;
	Fri, 12 Jun 2026 23:00:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1781298003; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=jE0qf9KuoZBwwKHyc1HCvsvWiaAVrC7vwOB3gjPoVKQ=;
	b=DjdZcnJzOV6f7lj4py65r1JNC37JpXOo44ghLgTk7aeK8HTbK3K25wIbaaM1pyBHGBt0JM
	dUwGowswGywUAaU4WeSpwckPN8rV5OZ9mxjpS1Y4bNcoe+AS1aM30fanVNlQeS6g71LW1M
	ZZttS4bwpg4GayPHFnNG/7FJI5kzr5216EVARpVnPFB+Jsp4q1XXg1YMmC9K6hiuuC9alr
	HrjXzN5Kb9SmKwKPuDiu8BOqEwMR2nwJeWsmYOTtDG94EQzsRPP2ESsB+jI5I0nQ/4aDIB
	HZzLXjRwb3btT9i4U4FJyEsBRJe+/3D0fQragZD/KQ9oS4DaXsN2WRepO2jFsQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Justin Chen <justin.chen@broadcom.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next 2/3] net: bcmgenet: remove dead priority queue plumbing
Date: Fri, 12 Jun 2026 22:59:14 +0200
Message-ID: <20260612205915.3156127-3-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612205915.3156127-1-nb@tipi-net.de>
References: <20260612205915.3156127-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[tipi-net.de];
	FREEMAIL_TO(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:opendmb@gmail.com,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:justin.chen@broadcom.com,m:ovidiu.panait.rb@renesas.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nb@tipi-net.de,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-298795-lists,netdev=lfdr.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid,tipi-net.de:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC2A667C6A3

With a single TX ring there is nothing left to prioritize. Drop the
unused register writes, enum entries, helper macros, and the dead
"flow period for ring != 0" branch in bcmgenet_init_tx_ring().

The DMA_ARBITER_{RR,WRR,SP} and DMA_RING_BUF_PRIORITY_* HW defines
are kept as register documentation.

No functional change.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 84 ++-----------------
 .../net/ethernet/broadcom/genet/bcmgenet.h    |  2 -
 2 files changed, 9 insertions(+), 77 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index c892734b4cd0..25f339eb304f 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -40,10 +40,6 @@
 
 #include "bcmgenet.h"
 
-/* Default highest priority queue for multi queue support */
-#define GENET_Q1_PRIORITY	0
-#define GENET_Q0_PRIORITY	1
-
 #define GENET_Q0_RX_BD_CNT	\
 	(TOTAL_DESC - priv->hw_params->rx_queues * priv->hw_params->rx_bds_per_q)
 #define GENET_Q0_TX_BD_CNT	\
@@ -187,10 +183,6 @@ enum dma_reg {
 	DMA_CTRL,
 	DMA_STATUS,
 	DMA_SCB_BURST_SIZE,
-	DMA_ARB_CTRL,
-	DMA_PRIORITY_0,
-	DMA_PRIORITY_1,
-	DMA_PRIORITY_2,
 	DMA_INDEX2RING_0,
 	DMA_INDEX2RING_1,
 	DMA_INDEX2RING_2,
@@ -223,10 +215,6 @@ static const u8 bcmgenet_dma_regs_v3plus[] = {
 	[DMA_CTRL]		= 0x04,
 	[DMA_STATUS]		= 0x08,
 	[DMA_SCB_BURST_SIZE]	= 0x0C,
-	[DMA_ARB_CTRL]		= 0x2C,
-	[DMA_PRIORITY_0]	= 0x30,
-	[DMA_PRIORITY_1]	= 0x34,
-	[DMA_PRIORITY_2]	= 0x38,
 	[DMA_RING0_TIMEOUT]	= 0x2C,
 	[DMA_RING1_TIMEOUT]	= 0x30,
 	[DMA_RING2_TIMEOUT]	= 0x34,
@@ -259,10 +247,6 @@ static const u8 bcmgenet_dma_regs_v2[] = {
 	[DMA_CTRL]		= 0x04,
 	[DMA_STATUS]		= 0x08,
 	[DMA_SCB_BURST_SIZE]	= 0x0C,
-	[DMA_ARB_CTRL]		= 0x30,
-	[DMA_PRIORITY_0]	= 0x34,
-	[DMA_PRIORITY_1]	= 0x38,
-	[DMA_PRIORITY_2]	= 0x3C,
 	[DMA_RING0_TIMEOUT]	= 0x2C,
 	[DMA_RING1_TIMEOUT]	= 0x30,
 	[DMA_RING2_TIMEOUT]	= 0x34,
@@ -286,10 +270,6 @@ static const u8 bcmgenet_dma_regs_v1[] = {
 	[DMA_CTRL]		= 0x00,
 	[DMA_STATUS]		= 0x04,
 	[DMA_SCB_BURST_SIZE]	= 0x0C,
-	[DMA_ARB_CTRL]		= 0x30,
-	[DMA_PRIORITY_0]	= 0x34,
-	[DMA_PRIORITY_1]	= 0x38,
-	[DMA_PRIORITY_2]	= 0x3C,
 	[DMA_RING0_TIMEOUT]	= 0x2C,
 	[DMA_RING1_TIMEOUT]	= 0x30,
 	[DMA_RING2_TIMEOUT]	= 0x34,
@@ -2126,13 +2106,6 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 	int i;
 
 	index = skb_get_queue_mapping(skb);
-	/* Mapping strategy:
-	 * queue_mapping = 0, unclassified, packet xmited through ring 0
-	 * queue_mapping = 1, goes to ring 1. (highest priority queue)
-	 * queue_mapping = 2, goes to ring 2.
-	 * queue_mapping = 3, goes to ring 3.
-	 * queue_mapping = 4, goes to ring 4.
-	 */
 	ring = &priv->tx_rings[index];
 	txq = netdev_get_tx_queue(dev, index);
 
@@ -2712,7 +2685,6 @@ static void bcmgenet_init_tx_ring(struct bcmgenet_priv *priv,
 {
 	struct bcmgenet_tx_ring *ring = &priv->tx_rings[index];
 	u32 words_per_bd = WORDS_PER_BD(priv);
-	u32 flow_period_val = 0;
 
 	spin_lock_init(&ring->lock);
 	ring->priv = priv;
@@ -2727,16 +2699,11 @@ static void bcmgenet_init_tx_ring(struct bcmgenet_priv *priv,
 	ring->end_ptr = end_ptr - 1;
 	ring->prod_index = 0;
 
-	/* Set flow period for ring != 0 */
-	if (index)
-		flow_period_val = ENET_MAX_MTU_SIZE << 16;
-
 	bcmgenet_tdma_ring_writel(priv, index, 0, TDMA_PROD_INDEX);
 	bcmgenet_tdma_ring_writel(priv, index, 0, TDMA_CONS_INDEX);
 	bcmgenet_tdma_ring_writel(priv, index, 1, DMA_MBUF_DONE_THRESH);
-	/* Disable rate control for now */
-	bcmgenet_tdma_ring_writel(priv, index, flow_period_val,
-				  TDMA_FLOW_PERIOD);
+	/* Rate control disabled */
+	bcmgenet_tdma_ring_writel(priv, index, 0, TDMA_FLOW_PERIOD);
 	bcmgenet_tdma_ring_writel(priv, index,
 				  ((size << DMA_RING_SIZE_SHIFT) |
 				   RX_BUF_LENGTH), DMA_RING_BUF_SIZE);
@@ -2919,52 +2886,20 @@ static int bcmgenet_rdma_disable(struct bcmgenet_priv *priv)
 	return -ETIMEDOUT;
 }
 
-/* Initialize Tx queues
+/* Initialize the single Tx queue.
  *
- * Queues 1-4 are priority-based, each one has 32 descriptors,
- * with queue 1 being the highest priority queue.
- *
- * Queue 0 is the default Tx queue with
- * GENET_Q0_TX_BD_CNT = 256 - 4 * 32 = 128 descriptors.
- *
- * The transmit control block pool is then partitioned as follows:
- * - Tx queue 0 uses tx_cbs[0..127]
- * - Tx queue 1 uses tx_cbs[128..159]
- * - Tx queue 2 uses tx_cbs[160..191]
- * - Tx queue 3 uses tx_cbs[192..223]
- * - Tx queue 4 uses tx_cbs[224..255]
+ * Queue 0 owns the full TX descriptor pool (GENET_Q0_TX_BD_CNT BDs)
+ * and is the only ring enabled in DMA_RING_CFG / DMA_CTRL.
  */
 static void bcmgenet_init_tx_queues(struct net_device *dev)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
-	unsigned int start = 0, end = GENET_Q0_TX_BD_CNT;
-	u32 i, ring_mask, dma_priority[3] = {0, 0, 0};
-
-	/* Enable strict priority arbiter mode */
-	bcmgenet_tdma_writel(priv, DMA_ARBITER_SP, DMA_ARB_CTRL);
 
-	/* Initialize Tx priority queues */
-	for (i = 0; i <= priv->hw_params->tx_queues; i++) {
-		bcmgenet_init_tx_ring(priv, i, end - start, start, end);
-		start = end;
-		end += priv->hw_params->tx_bds_per_q;
-		dma_priority[DMA_PRIO_REG_INDEX(i)] |=
-			(i ? GENET_Q1_PRIORITY : GENET_Q0_PRIORITY)
-			<< DMA_PRIO_REG_SHIFT(i);
-	}
+	bcmgenet_init_tx_ring(priv, 0, GENET_Q0_TX_BD_CNT, 0,
+			      GENET_Q0_TX_BD_CNT);
 
-	/* Set Tx queue priorities */
-	bcmgenet_tdma_writel(priv, dma_priority[0], DMA_PRIORITY_0);
-	bcmgenet_tdma_writel(priv, dma_priority[1], DMA_PRIORITY_1);
-	bcmgenet_tdma_writel(priv, dma_priority[2], DMA_PRIORITY_2);
-
-	/* Configure Tx queues as descriptor rings */
-	ring_mask = (1 << (priv->hw_params->tx_queues + 1)) - 1;
-	bcmgenet_tdma_writel(priv, ring_mask, DMA_RING_CFG);
-
-	/* Enable Tx rings */
-	ring_mask <<= DMA_RING_BUF_EN_SHIFT;
-	bcmgenet_tdma_writel(priv, ring_mask, DMA_CTRL);
+	bcmgenet_tdma_writel(priv, BIT(0), DMA_RING_CFG);
+	bcmgenet_tdma_writel(priv, BIT(DMA_RING_BUF_EN_SHIFT), DMA_CTRL);
 }
 
 static void bcmgenet_enable_rx_napi(struct bcmgenet_priv *priv)
@@ -4123,7 +4058,6 @@ static int bcmgenet_probe(struct platform_device *pdev)
 	if (err)
 		goto err_clk_disable;
 
-	/* setup number of real queues + 1 */
 	netif_set_real_num_tx_queues(priv->dev, priv->hw_params->tx_queues + 1);
 	netif_set_real_num_rx_queues(priv->dev, priv->hw_params->rx_queues + 1);
 
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 22a958ba9902..ce449ea0b40b 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -431,8 +431,6 @@ struct bcmgenet_rx_stats64 {
 #define DMA_ARBITER_MODE_MASK		0x03
 #define DMA_RING_BUF_PRIORITY_MASK	0x1F
 #define DMA_RING_BUF_PRIORITY_SHIFT	5
-#define DMA_PRIO_REG_INDEX(q)		((q) / 6)
-#define DMA_PRIO_REG_SHIFT(q)		(((q) % 6) * DMA_RING_BUF_PRIORITY_SHIFT)
 #define DMA_RATE_ADJ_MASK		0xFF
 
 /* Tx/Rx Dma Descriptor common bits*/
-- 
2.53.0


