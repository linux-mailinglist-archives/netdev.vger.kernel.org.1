Return-Path: <netdev+bounces-303734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IRoWKJY5RWps8woAu9opvQ
	(envelope-from <netdev+bounces-303734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:00:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF356EF720
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:00:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=kzMZvGUa;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303734-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303734-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 432163004C81
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 15:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E955D492188;
	Wed,  1 Jul 2026 15:59:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10308360EFF
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 15:59:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921563; cv=none; b=jfvBv6Oh3UDHoabXm5bvosxDK6eNUpudlnpO+eA8mVMebyFrsf/Cb6PgvRG1glisCYgnhLaNpnF7oRv9K6mz4m6zNb/ZLL/5v6IJtNR5Q5WZgq/bSOvENcD0K5WWbkgncV0FgVTBBKumMGOV6eHu4cJs0o8hasFXtiZGvgIzQVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921563; c=relaxed/simple;
	bh=osmeVGJ32ILQamU8HACuA0jdDt/DkUYYJa/KKs9G7Ik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CNdv2vk90+mqQ1+P0pCR5tETl2i2kGuAyBtVa8oH3w+rpY8zPXihIvIuqDt2OQZAPJcntDAcpGp4witgtfFcsj+eFgVFaHAifHeDkkUIKLtpbpmWYirMr/HKdLUUSWXjxk+KHuM3J0D+LFB7hELMlV8+GXDjQfqd0yBE2/Omxfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kzMZvGUa; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DA8F31A0DB9;
	Wed,  1 Jul 2026 15:59:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AD31C60288;
	Wed,  1 Jul 2026 15:59:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6DEE5104C967E;
	Wed,  1 Jul 2026 17:59:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782921559; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PmznCJlv2fJYMkSf3vBgdPmAhcjSl/EDCYmh5PKLpic=;
	b=kzMZvGUaWt2HgHyo1zClrrS9ZSoQPwgX9YQJkxA5aeqgUcYvXkpgffzeDNCyefi7oEiEao
	CL9xp8unli7qWH5Z/G1S5/PAhS0oMYpBnevyhs535M1BUIG5Yg7z1ZW2y6TLEygMxTSPO8
	pzRWHDjspZ0IDwiZkS/VIOqPMpYuFq+USogz4eWQ0G9cI+bnXOkJO8hdfvRnZoruOAE/AK
	FbTO+DgeHWkhS4Fx+zFGOlN4SoOv5uoB6+heiAvc3BBfBgauE8iPcd8bIaSUq0XrOtnJ3q
	8puIrVQUfCdUL8uZpoRKO/XiOh1nCWdwTIrlhSJoyiR84SrBxaYlWVb9FEnxDA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 01 Jul 2026 17:59:06 +0200
Subject: [PATCH net-next v3 03/15] net: macb: unify variable naming
 convention in at91ether functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260701-macb-context-v3-3-00268d5b1502@bootlin.com>
References: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
In-Reply-To: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Paolo Valerio <pvalerio@redhat.com>, Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303734-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:theo.lebrun@bootlin.com,m:conor.dooley@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:pvalerio@redhat.com,m:nb@tipi-net.de,m:vladimir.kondratiev@mobileye.com,m:gregory.clement@bootlin.com,m:benoit.monin@bootlin.com,m:tawfik.bayouk@mobileye.com,m:thomas.petazzoni@bootlin.com,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,bootlin.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BF356EF720

Follow MACB naming convention throughout on two aspects:
 - Always name `struct macb *bp` rather than `lp`.
 - Always name `struct macb_queue *queue` rather than `q`.

The latter is to reserve `q` for queue indexes.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 176 ++++++++++++++++---------------
 1 file changed, 91 insertions(+), 85 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 7d75cf625556..86c0e9ccbfce 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4946,71 +4946,72 @@ static const struct macb_usrio_config at91_default_usrio = {
 
 static struct sifive_fu540_macb_mgmt *mgmt;
 
-static int at91ether_alloc_coherent(struct macb *lp)
+static int at91ether_alloc_coherent(struct macb *bp)
 {
-	struct macb_queue *q = &lp->queues[0];
+	struct macb_queue *queue = &bp->queues[0];
 
-	q->rx_ring = dma_alloc_coherent(&lp->pdev->dev,
-					 (AT91ETHER_MAX_RX_DESCR *
-					  macb_dma_desc_get_size(lp)),
-					 &q->rx_ring_dma, GFP_KERNEL);
-	if (!q->rx_ring)
+	queue->rx_ring = dma_alloc_coherent(&bp->pdev->dev,
+					    (AT91ETHER_MAX_RX_DESCR *
+					     macb_dma_desc_get_size(bp)),
+					    &queue->rx_ring_dma, GFP_KERNEL);
+	if (!queue->rx_ring)
 		return -ENOMEM;
 
-	q->rx_buffers = dma_alloc_coherent(&lp->pdev->dev,
-					    AT91ETHER_MAX_RX_DESCR *
-					    AT91ETHER_MAX_RBUFF_SZ,
-					    &q->rx_buffers_dma, GFP_KERNEL);
-	if (!q->rx_buffers) {
-		dma_free_coherent(&lp->pdev->dev,
+	queue->rx_buffers = dma_alloc_coherent(&bp->pdev->dev,
+					       AT91ETHER_MAX_RX_DESCR *
+					       AT91ETHER_MAX_RBUFF_SZ,
+					       &queue->rx_buffers_dma,
+					       GFP_KERNEL);
+	if (!queue->rx_buffers) {
+		dma_free_coherent(&bp->pdev->dev,
 				  AT91ETHER_MAX_RX_DESCR *
-				  macb_dma_desc_get_size(lp),
-				  q->rx_ring, q->rx_ring_dma);
-		q->rx_ring = NULL;
+				  macb_dma_desc_get_size(bp),
+				  queue->rx_ring, queue->rx_ring_dma);
+		queue->rx_ring = NULL;
 		return -ENOMEM;
 	}
 
 	return 0;
 }
 
-static void at91ether_free_coherent(struct macb *lp)
+static void at91ether_free_coherent(struct macb *bp)
 {
-	struct macb_queue *q = &lp->queues[0];
+	struct macb_queue *queue = &bp->queues[0];
 
-	if (q->rx_ring) {
-		dma_free_coherent(&lp->pdev->dev,
+	if (queue->rx_ring) {
+		dma_free_coherent(&bp->pdev->dev,
 				  AT91ETHER_MAX_RX_DESCR *
-				  macb_dma_desc_get_size(lp),
-				  q->rx_ring, q->rx_ring_dma);
-		q->rx_ring = NULL;
+				  macb_dma_desc_get_size(bp),
+				  queue->rx_ring, queue->rx_ring_dma);
+		queue->rx_ring = NULL;
 	}
 
-	if (q->rx_buffers) {
-		dma_free_coherent(&lp->pdev->dev,
+	if (queue->rx_buffers) {
+		dma_free_coherent(&bp->pdev->dev,
 				  AT91ETHER_MAX_RX_DESCR *
 				  AT91ETHER_MAX_RBUFF_SZ,
-				  q->rx_buffers, q->rx_buffers_dma);
-		q->rx_buffers = NULL;
+				  queue->rx_buffers, queue->rx_buffers_dma);
+		queue->rx_buffers = NULL;
 	}
 }
 
 /* Initialize and start the Receiver and Transmit subsystems */
-static int at91ether_start(struct macb *lp)
+static int at91ether_start(struct macb *bp)
 {
-	struct macb_queue *q = &lp->queues[0];
+	struct macb_queue *queue = &bp->queues[0];
 	struct macb_dma_desc *desc;
 	dma_addr_t addr;
 	u32 ctl;
 	int i, ret;
 
-	ret = at91ether_alloc_coherent(lp);
+	ret = at91ether_alloc_coherent(bp);
 	if (ret)
 		return ret;
 
-	addr = q->rx_buffers_dma;
+	addr = queue->rx_buffers_dma;
 	for (i = 0; i < AT91ETHER_MAX_RX_DESCR; i++) {
-		desc = macb_rx_desc(q, i);
-		macb_set_addr(lp, desc, addr);
+		desc = macb_rx_desc(queue, i);
+		macb_set_addr(bp, desc, addr);
 		desc->ctrl = 0;
 		addr += AT91ETHER_MAX_RBUFF_SZ;
 	}
@@ -5019,17 +5020,17 @@ static int at91ether_start(struct macb *lp)
 	desc->addr |= MACB_BIT(RX_WRAP);
 
 	/* Reset buffer index */
-	q->rx_tail = 0;
+	queue->rx_tail = 0;
 
 	/* Program address of descriptor list in Rx Buffer Queue register */
-	macb_writel(lp, RBQP, q->rx_ring_dma);
+	macb_writel(bp, RBQP, queue->rx_ring_dma);
 
 	/* Enable Receive and Transmit */
-	ctl = macb_readl(lp, NCR);
-	macb_writel(lp, NCR, ctl | MACB_BIT(RE) | MACB_BIT(TE));
+	ctl = macb_readl(bp, NCR);
+	macb_writel(bp, NCR, ctl | MACB_BIT(RE) | MACB_BIT(TE));
 
 	/* Enable MAC interrupts */
-	macb_writel(lp, IER, MACB_BIT(RCOMP)	|
+	macb_writel(bp, IER, MACB_BIT(RCOMP)	|
 			     MACB_BIT(RXUBR)	|
 			     MACB_BIT(ISR_TUND)	|
 			     MACB_BIT(ISR_RLE)	|
@@ -5040,12 +5041,12 @@ static int at91ether_start(struct macb *lp)
 	return 0;
 }
 
-static void at91ether_stop(struct macb *lp)
+static void at91ether_stop(struct macb *bp)
 {
 	u32 ctl;
 
 	/* Disable MAC interrupts */
-	macb_writel(lp, IDR, MACB_BIT(RCOMP)	|
+	macb_writel(bp, IDR, MACB_BIT(RCOMP)	|
 			     MACB_BIT(RXUBR)	|
 			     MACB_BIT(ISR_TUND)	|
 			     MACB_BIT(ISR_RLE)	|
@@ -5054,35 +5055,35 @@ static void at91ether_stop(struct macb *lp)
 			     MACB_BIT(HRESP));
 
 	/* Disable Receiver and Transmitter */
-	ctl = macb_readl(lp, NCR);
-	macb_writel(lp, NCR, ctl & ~(MACB_BIT(TE) | MACB_BIT(RE)));
+	ctl = macb_readl(bp, NCR);
+	macb_writel(bp, NCR, ctl & ~(MACB_BIT(TE) | MACB_BIT(RE)));
 
 	/* Free resources. */
-	at91ether_free_coherent(lp);
+	at91ether_free_coherent(bp);
 }
 
 /* Open the ethernet interface */
 static int at91ether_open(struct net_device *netdev)
 {
-	struct macb *lp = netdev_priv(netdev);
+	struct macb *bp = netdev_priv(netdev);
 	u32 ctl;
 	int ret;
 
-	ret = pm_runtime_resume_and_get(&lp->pdev->dev);
+	ret = pm_runtime_resume_and_get(&bp->pdev->dev);
 	if (ret < 0)
 		return ret;
 
 	/* Clear internal statistics */
-	ctl = macb_readl(lp, NCR);
-	macb_writel(lp, NCR, ctl | MACB_BIT(CLRSTAT));
+	ctl = macb_readl(bp, NCR);
+	macb_writel(bp, NCR, ctl | MACB_BIT(CLRSTAT));
 
-	macb_set_hwaddr(lp);
+	macb_set_hwaddr(bp);
 
-	ret = at91ether_start(lp);
+	ret = at91ether_start(bp);
 	if (ret)
 		goto pm_exit;
 
-	ret = macb_phylink_connect(lp);
+	ret = macb_phylink_connect(bp);
 	if (ret)
 		goto stop;
 
@@ -5091,25 +5092,25 @@ static int at91ether_open(struct net_device *netdev)
 	return 0;
 
 stop:
-	at91ether_stop(lp);
+	at91ether_stop(bp);
 pm_exit:
-	pm_runtime_put_sync(&lp->pdev->dev);
+	pm_runtime_put_sync(&bp->pdev->dev);
 	return ret;
 }
 
 /* Close the interface */
 static int at91ether_close(struct net_device *netdev)
 {
-	struct macb *lp = netdev_priv(netdev);
+	struct macb *bp = netdev_priv(netdev);
 
 	netif_stop_queue(netdev);
 
-	phylink_stop(lp->phylink);
-	phylink_disconnect_phy(lp->phylink);
+	phylink_stop(bp->phylink);
+	phylink_disconnect_phy(bp->phylink);
 
-	at91ether_stop(lp);
+	at91ether_stop(bp);
 
-	pm_runtime_put(&lp->pdev->dev);
+	pm_runtime_put(&bp->pdev->dev);
 
 	return 0;
 }
@@ -5118,19 +5119,21 @@ static int at91ether_close(struct net_device *netdev)
 static netdev_tx_t at91ether_start_xmit(struct sk_buff *skb,
 					struct net_device *netdev)
 {
-	struct macb *lp = netdev_priv(netdev);
+	struct macb *bp = netdev_priv(netdev);
+	struct device *dev = &bp->pdev->dev;
 
-	if (macb_readl(lp, TSR) & MACB_BIT(RM9200_BNQ)) {
+	if (macb_readl(bp, TSR) & MACB_BIT(RM9200_BNQ)) {
 		int desc = 0;
 
 		netif_stop_queue(netdev);
 
 		/* Store packet information (to free when Tx completed) */
-		lp->rm9200_txq[desc].skb = skb;
-		lp->rm9200_txq[desc].size = skb->len;
-		lp->rm9200_txq[desc].mapping = dma_map_single(&lp->pdev->dev, skb->data,
-							      skb->len, DMA_TO_DEVICE);
-		if (dma_mapping_error(&lp->pdev->dev, lp->rm9200_txq[desc].mapping)) {
+		bp->rm9200_txq[desc].skb = skb;
+		bp->rm9200_txq[desc].size = skb->len;
+		bp->rm9200_txq[desc].mapping = dma_map_single(dev, skb->data,
+							      skb->len,
+							      DMA_TO_DEVICE);
+		if (dma_mapping_error(dev, bp->rm9200_txq[desc].mapping)) {
 			dev_kfree_skb_any(skb);
 			netdev->stats.tx_dropped++;
 			netdev_err(netdev, "%s: DMA mapping error\n", __func__);
@@ -5138,9 +5141,9 @@ static netdev_tx_t at91ether_start_xmit(struct sk_buff *skb,
 		}
 
 		/* Set address of the data in the Transmit Address register */
-		macb_writel(lp, TAR, lp->rm9200_txq[desc].mapping);
+		macb_writel(bp, TAR, bp->rm9200_txq[desc].mapping);
 		/* Set length of the packet in the Transmit Control register */
-		macb_writel(lp, TCR, skb->len);
+		macb_writel(bp, TCR, skb->len);
 
 	} else {
 		netdev_err(netdev, "%s called, but device is busy!\n",
@@ -5156,16 +5159,17 @@ static netdev_tx_t at91ether_start_xmit(struct sk_buff *skb,
  */
 static void at91ether_rx(struct net_device *netdev)
 {
-	struct macb *lp = netdev_priv(netdev);
-	struct macb_queue *q = &lp->queues[0];
+	struct macb *bp = netdev_priv(netdev);
+	struct macb_queue *queue = &bp->queues[0];
 	struct macb_dma_desc *desc;
 	unsigned char *p_recv;
 	struct sk_buff *skb;
 	unsigned int pktlen;
 
-	desc = macb_rx_desc(q, q->rx_tail);
+	desc = macb_rx_desc(queue, queue->rx_tail);
 	while (desc->addr & MACB_BIT(RX_USED)) {
-		p_recv = q->rx_buffers + q->rx_tail * AT91ETHER_MAX_RBUFF_SZ;
+		p_recv = queue->rx_buffers +
+			 queue->rx_tail * AT91ETHER_MAX_RBUFF_SZ;
 		pktlen = MACB_BF(RX_FRMLEN, desc->ctrl);
 		skb = netdev_alloc_skb(netdev, pktlen + 2);
 		if (skb) {
@@ -5187,12 +5191,12 @@ static void at91ether_rx(struct net_device *netdev)
 		desc->addr &= ~MACB_BIT(RX_USED);
 
 		/* wrap after last buffer */
-		if (q->rx_tail == AT91ETHER_MAX_RX_DESCR - 1)
-			q->rx_tail = 0;
+		if (queue->rx_tail == AT91ETHER_MAX_RX_DESCR - 1)
+			queue->rx_tail = 0;
 		else
-			q->rx_tail++;
+			queue->rx_tail++;
 
-		desc = macb_rx_desc(q, q->rx_tail);
+		desc = macb_rx_desc(queue, queue->rx_tail);
 	}
 }
 
@@ -5200,14 +5204,14 @@ static void at91ether_rx(struct net_device *netdev)
 static irqreturn_t at91ether_interrupt(int irq, void *dev_id)
 {
 	struct net_device *netdev = dev_id;
-	struct macb *lp = netdev_priv(netdev);
+	struct macb *bp = netdev_priv(netdev);
 	u32 intstatus, ctl;
 	unsigned int desc;
 
 	/* MAC Interrupt Status register indicates what interrupts are pending.
 	 * It is automatically cleared once read.
 	 */
-	intstatus = macb_readl(lp, ISR);
+	intstatus = macb_readl(bp, ISR);
 
 	/* Receive complete */
 	if (intstatus & MACB_BIT(RCOMP))
@@ -5220,23 +5224,25 @@ static irqreturn_t at91ether_interrupt(int irq, void *dev_id)
 			netdev->stats.tx_errors++;
 
 		desc = 0;
-		if (lp->rm9200_txq[desc].skb) {
-			dev_consume_skb_irq(lp->rm9200_txq[desc].skb);
-			lp->rm9200_txq[desc].skb = NULL;
-			dma_unmap_single(&lp->pdev->dev, lp->rm9200_txq[desc].mapping,
-					 lp->rm9200_txq[desc].size, DMA_TO_DEVICE);
+		if (bp->rm9200_txq[desc].skb) {
+			dev_consume_skb_irq(bp->rm9200_txq[desc].skb);
+			bp->rm9200_txq[desc].skb = NULL;
+			dma_unmap_single(&bp->pdev->dev,
+					 bp->rm9200_txq[desc].mapping,
+					 bp->rm9200_txq[desc].size,
+					 DMA_TO_DEVICE);
 			netdev->stats.tx_packets++;
-			netdev->stats.tx_bytes += lp->rm9200_txq[desc].size;
+			netdev->stats.tx_bytes += bp->rm9200_txq[desc].size;
 		}
 		netif_wake_queue(netdev);
 	}
 
 	/* Work-around for EMAC Errata section 41.3.1 */
 	if (intstatus & MACB_BIT(RXUBR)) {
-		ctl = macb_readl(lp, NCR);
-		macb_writel(lp, NCR, ctl & ~MACB_BIT(RE));
+		ctl = macb_readl(bp, NCR);
+		macb_writel(bp, NCR, ctl & ~MACB_BIT(RE));
 		wmb();
-		macb_writel(lp, NCR, ctl | MACB_BIT(RE));
+		macb_writel(bp, NCR, ctl | MACB_BIT(RE));
 	}
 
 	if (intstatus & MACB_BIT(ISR_ROVR))

-- 
2.55.0


