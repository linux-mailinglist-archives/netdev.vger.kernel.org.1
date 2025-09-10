Return-Path: <netdev+bounces-221773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D44FB51D63
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 18:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D1A173DFA
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 16:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B7033CE8A;
	Wed, 10 Sep 2025 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Sbsa6cNf"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299273376A3;
	Wed, 10 Sep 2025 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521005; cv=none; b=pOHF5DWkPm+84M3KlBWObidn3WhXwRCk7pUBa/4cQuLr3kVJP5aGa67mGWegRrjK6zTKdJoW+0BGlQT0+MeOnzpHD2H01iLA23cn2enqkKeTQ098yScBPQSjs1nclty3l8W9DnvMZhVOfRB7SSHpDBfOf0gTXHcuVgSvAwS5GV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521005; c=relaxed/simple;
	bh=cAG4P4/fGEfPCrbBFPw8+oF3biefjVuSP/JkdO9TtMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I4btij9Vqr9a9y6ttY31+eTvL1mT4Fm6Is4dzYixzk/CCJhSjUFEuvVVYw6KYBst72juxjby4ibGvv0dU6+QNfDAyUlMY0/WoenstBIMQwlMcjmq9/U5SgxVKbfzcBmiLnlcmIl0LMGl90oLAKJ7YhIiVCOBSho7hlw4zZno2ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Sbsa6cNf; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A7166C6B38C;
	Wed, 10 Sep 2025 16:16:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 766CE606D4;
	Wed, 10 Sep 2025 16:16:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 97FA9102F28F3;
	Wed, 10 Sep 2025 18:16:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757520999; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=oMWyc4KCjaYuFjPAmTfCSPaCrCpIfWNEPyjtZueqdro=;
	b=Sbsa6cNffE58RlgGBZ0jIEwF5lbWbkw5ZPpa5bkln+ZahGyHnHYmef4YVlL3YROlaVxvr1
	iOVZVS0fRolkeAogoTlRjXTlR1aOwOm9EDkmRS1zkv0AnPF78DSoDYyGmYZPYCKr4k8fpm
	Y//5nCYhS+dj0b4TDrFHpBAMzDPyjMJaJq+IhVO0NsldJINuKCLGStMRsDDyxqAxtkzKrJ
	FaULjBpFkqG8lAhQ6TP2JnW0Xo09gpua6TFgTggSsYLc/WStyknvgD4CaWOuz6KuvoI2Ur
	Dsm2K88YHDuCf8xunbb350MIUM9A5U4zBRJBKf1TIiH3MBHjqWO5YFBnDYAIBw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 10 Sep 2025 18:15:33 +0200
Subject: [PATCH net v5 4/5] net: macb: single dma_alloc_coherent() for DMA
 descriptors
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250910-macb-fixes-v5-4-f413a3601ce4@bootlin.com>
References: <20250910-macb-fixes-v5-0-f413a3601ce4@bootlin.com>
In-Reply-To: <20250910-macb-fixes-v5-0-f413a3601ce4@bootlin.com>
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
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Tested-by: Nicolas Ferre <nicolas.ferre@microchip.com> # on sam9x75
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 80 ++++++++++++++++----------------
 1 file changed, 41 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 73840808ea801b35a64a296dedc3a91e6e1f9f51..fc082a7a5a313be3d58a008533c3815cb1b1639a 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2478,32 +2478,30 @@ static unsigned int macb_rx_ring_size_per_queue(struct macb *bp)
 
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
 
@@ -2545,41 +2543,45 @@ static int macb_alloc_rx_buffers(struct macb *bp)
 
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
2.51.0


