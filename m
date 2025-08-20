Return-Path: <netdev+bounces-215308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB421B2E020
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 17:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 306ED17824A
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 14:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A220A322A1C;
	Wed, 20 Aug 2025 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k6XoDNOU"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7692D322765;
	Wed, 20 Aug 2025 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755701760; cv=none; b=cb6h3FTReqq2qK2XD0ANiGULIsoFtJ5KwmtApihLRa8M4DTiTZ+/iUiWgcd5p0Gizy34t5REE1o6S4xsAYoVNCZl8wz9teOQ3ESgvh3wDBbXQLmI/YSX5jAVLlpApA6tFWQEmkp2rLilEhm0FXHX5XiDOfxnlSU8xfHIXENxURM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755701760; c=relaxed/simple;
	bh=pMwgAM3mK5HlmmxttB23AV1CD/3qDJooqvU4uXnUwkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B8POIteDRbc0k6GEVcxEPs86PMyDgEJgZtQZFDBiTb0JS90SMt8ye/XS0jmbGX5b0RuLIgFMxV0OvXk9qBEvm94yJFdJEhagEug8azV3iewGqVMnlvQqaMlaoB+EqlTlg9COqMXqjN6OOQXH+r6ekg9tkBckVBpGYZjJ0DD9Svw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k6XoDNOU; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 019714E40C5C;
	Wed, 20 Aug 2025 14:55:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CE342606A0;
	Wed, 20 Aug 2025 14:55:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 987881C2286DB;
	Wed, 20 Aug 2025 16:55:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755701755; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nsFJ9znWtVRJWAKG3cXq6r3YWRygtCDg6ibIfdm4SIQ=;
	b=k6XoDNOUERVc/EQIdXEPBkmilI1zOHaT5huoe3p903ePzH93Z6H7rbwiXLRvm211gJDddw
	Q3MeJmctVJtBCIdQiMJIESGecqDJuPGvUmigra4RMCjm/mlCYAXjz36N5WlD02gdrJ4lbe
	rL16tMs3pLBuE4JgCobOuF6paXLpCji/8DVzvdgry+65+MUpssMj0lHTc+DCKhFakuhhNl
	L5kfGTssD+0hbzs6OqUD+RPg5woC4K6mDLdI6vPXPHC3Tuz1VFAlJSXWym6Ft83d7tgVJG
	dD44fT5TNoyR5Mq8713RaeW9D/A6OuTkaoXSTnREvvK8B9D56Ak/zAYpZ2dEZw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 20 Aug 2025 16:55:08 +0200
Subject: [PATCH net v4 4/5] net: macb: single dma_alloc_coherent() for DMA
 descriptors
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250820-macb-fixes-v4-4-23c399429164@bootlin.com>
References: <20250820-macb-fixes-v4-0-23c399429164@bootlin.com>
In-Reply-To: <20250820-macb-fixes-v4-0-23c399429164@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Harini Katakam <harini.katakam@xilinx.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Sean Anderson <sean.anderson@linux.dev>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Move from 2*NUM_QUEUES dma_alloc_coherent() for DMA descriptor rings to
2 calls overall.

Issue is with how all queues share the same register for configuring the
upper 32-bits of Tx/Rx descriptor rings. Taking Tx, notice how TBQPH
does *not* depend on the queue index:

	#define GEM_TBQP(hw_q)		(0x0440 + ((hw_q) << 2))
	#define GEM_TBQPH(hw_q)		(0x04C8)

	queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
	#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
	if (bp->hw_dma_cap & HW_DMA_CAP_64B)
		queue_writel(queue, TBQPH, upper_32_bits(queue->tx_ring_dma));
	#endif

To maximise our chances of getting valid DMA addresses, we do a single
dma_alloc_coherent() across queues. This improves the odds because
alloc_pages() guarantees natural alignment. Other codepaths (IOMMU or
dev/arch dma_map_ops) don't give high enough guarantees
(even page-aligned isn't enough).

Two consideration:

 - dma_alloc_coherent() gives us page alignment. Here we remove this
   constraint meaning each queue's ring won't be page-aligned anymore.

 - This can save some tiny amounts of memory. Fewer allocations means
   (1) less overhead (constant cost per alloc) and (2) less wasted bytes
   due to alignment constraints.

   Example for (2): 4 queues, default ring size (512), 64-bit DMA
   descriptors, 16K pages:
    - Before: 8 allocs of 8K, each rounded to 16K => 64K wasted.
    - After:  2 allocs of 32K => 0K wasted.

Fixes: 02c958dd3446 ("net/macb: add TX multiqueue support for gem")
Reviewed-by: Sean Anderson <sean.anderson@linux.dev>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 80 ++++++++++++++++----------------
 1 file changed, 41 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index d413e8bd4977187fd73f7cc48268baf933aab051..7f31f264a6d342ea01e2f61944b12c9b9a3fe66e 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2474,32 +2474,30 @@ static unsigned int macb_rx_ring_size_per_queue(struct macb *bp)
 
 static void macb_free_consistent(struct macb *bp)
 {
+	struct device *dev = &bp->pdev->dev;
 	struct macb_queue *queue;
 	unsigned int q;
+	size_t size;
 
 	if (bp->rx_ring_tieoff) {
-		dma_free_coherent(&bp->pdev->dev, macb_dma_desc_get_size(bp),
+		dma_free_coherent(dev, macb_dma_desc_get_size(bp),
 				  bp->rx_ring_tieoff, bp->rx_ring_tieoff_dma);
 		bp->rx_ring_tieoff = NULL;
 	}
 
 	bp->macbgem_ops.mog_free_rx_buffers(bp);
 
+	size = bp->num_queues * macb_tx_ring_size_per_queue(bp);
+	dma_free_coherent(dev, size, bp->queues[0].tx_ring, bp->queues[0].tx_ring_dma);
+
+	size = bp->num_queues * macb_rx_ring_size_per_queue(bp);
+	dma_free_coherent(dev, size, bp->queues[0].rx_ring, bp->queues[0].rx_ring_dma);
+
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		kfree(queue->tx_skb);
 		queue->tx_skb = NULL;
-		if (queue->tx_ring) {
-			dma_free_coherent(&bp->pdev->dev,
-					  macb_tx_ring_size_per_queue(bp),
-					  queue->tx_ring, queue->tx_ring_dma);
-			queue->tx_ring = NULL;
-		}
-		if (queue->rx_ring) {
-			dma_free_coherent(&bp->pdev->dev,
-					  macb_rx_ring_size_per_queue(bp),
-					  queue->rx_ring, queue->rx_ring_dma);
-			queue->rx_ring = NULL;
-		}
+		queue->tx_ring = NULL;
+		queue->rx_ring = NULL;
 	}
 }
 
@@ -2541,41 +2539,45 @@ static int macb_alloc_rx_buffers(struct macb *bp)
 
 static int macb_alloc_consistent(struct macb *bp)
 {
+	struct device *dev = &bp->pdev->dev;
+	dma_addr_t tx_dma, rx_dma;
 	struct macb_queue *queue;
 	unsigned int q;
-	u32 upper;
-	int size;
+	void *tx, *rx;
+	size_t size;
+
+	/*
+	 * Upper 32-bits of Tx/Rx DMA descriptor for each queues much match!
+	 * We cannot enforce this guarantee, the best we can do is do a single
+	 * allocation and hope it will land into alloc_pages() that guarantees
+	 * natural alignment of physical addresses.
+	 */
+
+	size = bp->num_queues * macb_tx_ring_size_per_queue(bp);
+	tx = dma_alloc_coherent(dev, size, &tx_dma, GFP_KERNEL);
+	if (!tx || upper_32_bits(tx_dma) != upper_32_bits(tx_dma + size - 1))
+		goto out_err;
+	netdev_dbg(bp->dev, "Allocated %zu bytes for %u TX rings at %08lx (mapped %p)\n",
+		   size, bp->num_queues, (unsigned long)tx_dma, tx);
+
+	size = bp->num_queues * macb_rx_ring_size_per_queue(bp);
+	rx = dma_alloc_coherent(dev, size, &rx_dma, GFP_KERNEL);
+	if (!rx || upper_32_bits(rx_dma) != upper_32_bits(rx_dma + size - 1))
+		goto out_err;
+	netdev_dbg(bp->dev, "Allocated %zu bytes for %u RX rings at %08lx (mapped %p)\n",
+		   size, bp->num_queues, (unsigned long)rx_dma, rx);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		size = macb_tx_ring_size_per_queue(bp);
-		queue->tx_ring = dma_alloc_coherent(&bp->pdev->dev, size,
-						    &queue->tx_ring_dma,
-						    GFP_KERNEL);
-		upper = upper_32_bits(queue->tx_ring_dma);
-		if (!queue->tx_ring ||
-		    upper != upper_32_bits(bp->queues[0].tx_ring_dma))
-			goto out_err;
-		netdev_dbg(bp->dev,
-			   "Allocated TX ring for queue %u of %d bytes at %08lx (mapped %p)\n",
-			   q, size, (unsigned long)queue->tx_ring_dma,
-			   queue->tx_ring);
+		queue->tx_ring = tx + macb_tx_ring_size_per_queue(bp) * q;
+		queue->tx_ring_dma = tx_dma + macb_tx_ring_size_per_queue(bp) * q;
+
+		queue->rx_ring = rx + macb_rx_ring_size_per_queue(bp) * q;
+		queue->rx_ring_dma = rx_dma + macb_rx_ring_size_per_queue(bp) * q;
 
 		size = bp->tx_ring_size * sizeof(struct macb_tx_skb);
 		queue->tx_skb = kmalloc(size, GFP_KERNEL);
 		if (!queue->tx_skb)
 			goto out_err;
-
-		size = macb_rx_ring_size_per_queue(bp);
-		queue->rx_ring = dma_alloc_coherent(&bp->pdev->dev, size,
-						    &queue->rx_ring_dma,
-						    GFP_KERNEL);
-		upper = upper_32_bits(queue->rx_ring_dma);
-		if (!queue->rx_ring ||
-		    upper != upper_32_bits(bp->queues[0].rx_ring_dma))
-			goto out_err;
-		netdev_dbg(bp->dev,
-			   "Allocated RX ring of %d bytes at %08lx (mapped %p)\n",
-			   size, (unsigned long)queue->rx_ring_dma, queue->rx_ring);
 	}
 	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
 		goto out_err;

-- 
2.50.1


