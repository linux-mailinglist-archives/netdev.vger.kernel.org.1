Return-Path: <netdev+bounces-243989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C694CACD97
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 11:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6067F3004502
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 10:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99CD2DA75F;
	Mon,  8 Dec 2025 10:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="05I8KFro"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAED1F4169
	for <netdev@vger.kernel.org>; Mon,  8 Dec 2025 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765189387; cv=none; b=Zl/3C9IsTI8vxeQFf4glcXqF1tqfMf65Wt7TfFnrAuQmBWXd+mjZSokvw6+t4hLz+r0z+mrUNDDeC4MB9zGeIiqiEMwLyfwg4oc0Wfsx3jyyut8FP4nqoZ5EeBNyWCrJKjuCfW5tnnKDZahdkEVEDzb4hwJTQ27lJCPqy2WPnM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765189387; c=relaxed/simple;
	bh=ewJtU6TA76FcOM83oJ5aWxsWovb3x9dSEzFTzEvIZgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Um5Tod9geqMv2UqLDJgQ2RbM7qlW1qEBHI5uvKRPC+Of1F/ai3LRzuWpZCKgwY83LdVV7j1v8UM//MPK24c689OSyHNRxUU4aJaIWiP4P4eDu+sxrZR8X2BhFKrmQTR95B4eZpsEgOnNwgfzrzTQt6QXURYqYkia8756jDriTCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=05I8KFro; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5F6961A2023;
	Mon,  8 Dec 2025 10:23:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3367C60707;
	Mon,  8 Dec 2025 10:23:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8426F102F228B;
	Mon,  8 Dec 2025 11:23:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1765189382; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AqPp8nBJtMQTLpx8wk2/iSO4pWuTOzncxljQfFWODpI=;
	b=05I8KFroCyckLDuxTxJN6RF/Xc6ugb647bwcvSCt5UY9oakpZhRJiHtp8IgQbXIY3LDnka
	E2LxOhu8WzLe4lxeTM1BGPApIWQIu/vkfNb9HnSX7ET/r58tbZJ3gKNoz+rhoRpqzM0jcu
	0OedzJSnJ41qaR59qGK7ATiWznGORZzqfjMWfTWqvItRZb3OF28J4/7dNblSADWUfrjRd8
	/l5Rr+i3KH1qw4iHhR8Zqfo46sRZZDjjEP3FK9CRGKRRigbI3sk8ahg78bhU+918RZlzhl
	y/NTczjbLYFFyjQgpADvae38G5mBLvFRbOTiJsqkD8THD3sPivBM4j4Lag3BYg==
From: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
To: theo.lebrun@bootlin.com
Cc: andrew+netdev@lunn.ch,
	benoit.monin@bootlin.com,
	claudiu.beznea@tuxon.dev,
	davem@davemloft.net,
	edumazet@google.com,
	gregory.clement@bootlin.com,
	kuba@kernel.org,
	lorenzo@kernel.org,
	netdev@vger.kernel.org,
	nicolas.ferre@microchip.com,
	pabeni@redhat.com,
	pvalerio@redhat.com,
	thomas.petazzoni@bootlin.com
Subject: [PATCH 1/8] net: macb: move Rx buffers alloc from link up to open
Date: Mon,  8 Dec 2025 11:22:36 +0100
Message-ID: <20251208102236.185367-1-theo.lebrun@bootlin.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <DESRDBL2FBUZ.3LXAM56K3CQV2@bootlin.com>
References: <DESRDBL2FBUZ.3LXAM56K3CQV2@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

mog_alloc_rx_buffers(), getting called at open, does not do rx buffer
alloc on GEM. The bulk of the work is done by gem_rx_refill() filling
up all slots with valid buffers.

gem_rx_refill() is called at link up by
gem_init_rings() == bp->macbgem_ops.mog_init_rings().

Move operation to macb_open(), mostly to allow it to fail early and
loudly rather than init the device with Rx mostly broken.

About `bool fail_early`:
 - When called from macb_open(), ring init fails as soon as a queue
   cannot be refilled.
 - When called from macb_hresp_error_task(), we do our best to reinit
   the device: we still iterate over all queues and try refilling all
   even if a previous queue failed.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      |  2 +-
 drivers/net/ethernet/cadence/macb_main.c | 34 ++++++++++++++++++------
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 87414a2ddf6e..2cb65ec37d44 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1180,7 +1180,7 @@ struct macb_queue;
 struct macb_or_gem_ops {
 	int	(*mog_alloc_rx_buffers)(struct macb *bp);
 	void	(*mog_free_rx_buffers)(struct macb *bp);
-	void	(*mog_init_rings)(struct macb *bp);
+	int	(*mog_init_rings)(struct macb *bp, bool fail_early);
 	int	(*mog_rx)(struct macb_queue *queue, struct napi_struct *napi,
 			  int budget);
 };
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index e461f5072884..65431a7e3533 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -705,10 +705,9 @@ static void macb_mac_link_up(struct phylink_config *config,
 		if (rx_pause)
 			ctrl |= MACB_BIT(PAE);
 
-		/* Initialize rings & buffers as clearing MACB_BIT(TE) in link down
-		 * cleared the pipeline and control registers.
+		/* Initialize buffer registers as clearing MACB_BIT(TE) in link
+		 * down cleared the pipeline and control registers.
 		 */
-		bp->macbgem_ops.mog_init_rings(bp);
 		macb_init_buffers(bp);
 
 		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
@@ -1250,13 +1249,14 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	return packets;
 }
 
-static void gem_rx_refill(struct macb_queue *queue)
+static int gem_rx_refill(struct macb_queue *queue)
 {
 	unsigned int		entry;
 	struct sk_buff		*skb;
 	dma_addr_t		paddr;
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
+	int err = 0;
 
 	while (CIRC_SPACE(queue->rx_prepared_head, queue->rx_tail,
 			bp->rx_ring_size) > 0) {
@@ -1273,6 +1273,7 @@ static void gem_rx_refill(struct macb_queue *queue)
 			if (unlikely(!skb)) {
 				netdev_err(bp->dev,
 					   "Unable to allocate sk_buff\n");
+				err = -ENOMEM;
 				break;
 			}
 
@@ -1322,6 +1323,7 @@ static void gem_rx_refill(struct macb_queue *queue)
 
 	netdev_vdbg(bp->dev, "rx ring: queue: %p, prepared head %d, tail %d\n",
 			queue, queue->rx_prepared_head, queue->rx_tail);
+	return err;
 }
 
 /* Mark DMA descriptors from begin up to and not including end as unused */
@@ -1774,7 +1776,7 @@ static void macb_hresp_error_task(struct work_struct *work)
 	netif_tx_stop_all_queues(dev);
 	netif_carrier_off(dev);
 
-	bp->macbgem_ops.mog_init_rings(bp);
+	bp->macbgem_ops.mog_init_rings(bp, false);
 
 	/* Initialize TX and RX buffers */
 	macb_init_buffers(bp);
@@ -2549,6 +2551,8 @@ static int macb_alloc_consistent(struct macb *bp)
 	}
 	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
 		goto out_err;
+	if (bp->macbgem_ops.mog_init_rings(bp, true))
+		goto out_err;
 
 	/* Required for tie off descriptor for PM cases */
 	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE)) {
@@ -2580,11 +2584,13 @@ static void macb_init_tieoff(struct macb *bp)
 	desc->ctrl = 0;
 }
 
-static void gem_init_rings(struct macb *bp)
+static int gem_init_rings(struct macb *bp, bool fail_early)
 {
 	struct macb_queue *queue;
 	struct macb_dma_desc *desc = NULL;
+	int last_err = 0;
 	unsigned int q;
+	int err;
 	int i;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
@@ -2600,13 +2606,24 @@ static void gem_init_rings(struct macb *bp)
 		queue->rx_tail = 0;
 		queue->rx_prepared_head = 0;
 
-		gem_rx_refill(queue);
+		/* We get called in two cases:
+		 *  - open: we can propagate alloc errors (so fail early),
+		 *  - HRESP error: cannot propagate, we attempt to reinit
+		 *    all queues in case of failure.
+		 */
+		err = gem_rx_refill(queue);
+		if (err) {
+			last_err = err;
+			if (fail_early)
+				break;
+		}
 	}
 
 	macb_init_tieoff(bp);
+	return last_err;
 }
 
-static void macb_init_rings(struct macb *bp)
+static int macb_init_rings(struct macb *bp, bool fail_early)
 {
 	int i;
 	struct macb_dma_desc *desc = NULL;
@@ -2623,6 +2640,7 @@ static void macb_init_rings(struct macb *bp)
 	desc->ctrl |= MACB_BIT(TX_WRAP);
 
 	macb_init_tieoff(bp);
+	return 0;
 }
 
 static void macb_reset_hw(struct macb *bp)
-- 
2.52.0


