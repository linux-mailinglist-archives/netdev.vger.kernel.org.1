Return-Path: <netdev+bounces-163660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363F7A2B310
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 21:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E23B3A4792
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 20:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C246D1D4335;
	Thu,  6 Feb 2025 20:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qggsptGd"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A8A1D07BA
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 20:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738872677; cv=none; b=d6U1XBGjQJMXdJ6pt9++FyclR01vpNNSnVf6nKVAEtFx7Yv0O8LddlJVsZAkXv5TTNGGq5niMM0JOhXdz+tJjlo4dsOx8RA9WIGmBy5XQYv1g1XMPJuS5YC/U7gWywgN9FhCGML7ORzaFYbOz4hiVdjLD1kK6haPy4uxNRdU2bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738872677; c=relaxed/simple;
	bh=0ahfcfXvduwegKwL8GvGGFBIQenHgnxg2fJRLgq9luU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VZzWuI9MoE0B9dDFx03Mtk/TILBwEBdgUNlxehmfc4kKwOy+ru6vEWuATYG3rp8F0hDng+lqN93gahgQ+x3Pd8gPL5MChzZYmdJS0RbMtFwsJHOo5I4/90Evwxqgs1YCtivG/1iBIEHXf0O+vm6BAN6OEFvDgHzz528QxqXuH/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qggsptGd; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738872667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PF5hZGMvLAEl9volfS3ZgWDttX3TNY4bhsRMPhjvOic=;
	b=qggsptGdqozsGhq8QqxQXXmw3SaPpQw8+MKsVudm47RUGIkGnKpLnSA7i/RV72tSiG/nVy
	Y3w3vynPWj6eit5fm1V4YNLS+s4grHu7uxut61Y4HzJNDbUKe8JAeFraeanD3bRHTQS3o8
	fM6jmqQHKTpnvOGbJcyUToj282Va7DM=
From: Sean Anderson <sean.anderson@linux.dev>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Shannon Nelson <shannon.nelson@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next v5 1/4] net: xilinx: axienet: Combine CR calculation
Date: Thu,  6 Feb 2025 15:10:33 -0500
Message-Id: <20250206201036.1516800-2-sean.anderson@linux.dev>
In-Reply-To: <20250206201036.1516800-1-sean.anderson@linux.dev>
References: <20250206201036.1516800-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Combine the common parts of the CR calculations for better code reuse.
While we're at it, simplify the code a bit.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
---

(no changes since v3)

Changes in v3:
- Fix mismatched parameter name documentation for axienet_calc_cr
- Integrate some cleanups originally included in
  https://lore.kernel.org/netdev/20240909230908.1319982-1-sean.anderson@linux.dev/

Changes in v2:
- Split off from runtime coalesce modification support

 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  3 -
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 64 ++++++++++---------
 2 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index a3f4f3e42587..8fd3b45ef6aa 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -112,9 +112,6 @@
 #define XAXIDMA_DELAY_MASK		0xFF000000 /* Delay timeout counter */
 #define XAXIDMA_COALESCE_MASK		0x00FF0000 /* Coalesce counter */
 
-#define XAXIDMA_DELAY_SHIFT		24
-#define XAXIDMA_COALESCE_SHIFT		16
-
 #define XAXIDMA_IRQ_IOC_MASK		0x00001000 /* Completion intr */
 #define XAXIDMA_IRQ_DELAY_MASK		0x00002000 /* Delay interrupt */
 #define XAXIDMA_IRQ_ERROR_MASK		0x00004000 /* Error interrupt */
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 9e7fa012e4fa..bd95f2ba3bae 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -224,22 +224,40 @@ static void axienet_dma_bd_release(struct net_device *ndev)
 }
 
 /**
- * axienet_usec_to_timer - Calculate IRQ delay timer value
- * @lp:		Pointer to the axienet_local structure
- * @coalesce_usec: Microseconds to convert into timer value
+ * axienet_calc_cr() - Calculate control register value
+ * @lp: Device private data
+ * @count: Number of completions before an interrupt
+ * @usec: Microseconds after the last completion before an interrupt
+ *
+ * Calculate a control register value based on the coalescing settings. The
+ * run/stop bit is not set.
  */
-static u32 axienet_usec_to_timer(struct axienet_local *lp, u32 coalesce_usec)
+static u32 axienet_calc_cr(struct axienet_local *lp, u32 count, u32 usec)
 {
-	u32 result;
-	u64 clk_rate = 125000000; /* arbitrary guess if no clock rate set */
+	u32 cr;
 
-	if (lp->axi_clk)
-		clk_rate = clk_get_rate(lp->axi_clk);
+	cr = FIELD_PREP(XAXIDMA_COALESCE_MASK, count) | XAXIDMA_IRQ_IOC_MASK |
+	     XAXIDMA_IRQ_ERROR_MASK;
+	/* Only set interrupt delay timer if not generating an interrupt on
+	 * the first packet. Otherwise leave at 0 to disable delay interrupt.
+	 */
+	if (count > 1) {
+		u64 clk_rate = 125000000; /* arbitrary guess if no clock rate set */
+		u32 timer;
 
-	/* 1 Timeout Interval = 125 * (clock period of SG clock) */
-	result = DIV64_U64_ROUND_CLOSEST((u64)coalesce_usec * clk_rate,
-					 XAXIDMA_DELAY_SCALE);
-	return min(result, FIELD_MAX(XAXIDMA_DELAY_MASK));
+		if (lp->axi_clk)
+			clk_rate = clk_get_rate(lp->axi_clk);
+
+		/* 1 Timeout Interval = 125 * (clock period of SG clock) */
+		timer = DIV64_U64_ROUND_CLOSEST((u64)usec * clk_rate,
+						XAXIDMA_DELAY_SCALE);
+
+		timer = min(timer, FIELD_MAX(XAXIDMA_DELAY_MASK));
+		cr |= FIELD_PREP(XAXIDMA_DELAY_MASK, timer) |
+		      XAXIDMA_IRQ_DELAY_MASK;
+	}
+
+	return cr;
 }
 
 /**
@@ -249,27 +267,13 @@ static u32 axienet_usec_to_timer(struct axienet_local *lp, u32 coalesce_usec)
 static void axienet_dma_start(struct axienet_local *lp)
 {
 	/* Start updating the Rx channel control register */
-	lp->rx_dma_cr = (lp->coalesce_count_rx << XAXIDMA_COALESCE_SHIFT) |
-			XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_ERROR_MASK;
-	/* Only set interrupt delay timer if not generating an interrupt on
-	 * the first RX packet. Otherwise leave at 0 to disable delay interrupt.
-	 */
-	if (lp->coalesce_count_rx > 1)
-		lp->rx_dma_cr |= (axienet_usec_to_timer(lp, lp->coalesce_usec_rx)
-					<< XAXIDMA_DELAY_SHIFT) |
-				 XAXIDMA_IRQ_DELAY_MASK;
+	lp->rx_dma_cr = axienet_calc_cr(lp, lp->coalesce_count_rx,
+					lp->coalesce_usec_rx);
 	axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, lp->rx_dma_cr);
 
 	/* Start updating the Tx channel control register */
-	lp->tx_dma_cr = (lp->coalesce_count_tx << XAXIDMA_COALESCE_SHIFT) |
-			XAXIDMA_IRQ_IOC_MASK | XAXIDMA_IRQ_ERROR_MASK;
-	/* Only set interrupt delay timer if not generating an interrupt on
-	 * the first TX packet. Otherwise leave at 0 to disable delay interrupt.
-	 */
-	if (lp->coalesce_count_tx > 1)
-		lp->tx_dma_cr |= (axienet_usec_to_timer(lp, lp->coalesce_usec_tx)
-					<< XAXIDMA_DELAY_SHIFT) |
-				 XAXIDMA_IRQ_DELAY_MASK;
+	lp->tx_dma_cr = axienet_calc_cr(lp, lp->coalesce_count_tx,
+					lp->coalesce_usec_tx);
 	axienet_dma_out32(lp, XAXIDMA_TX_CR_OFFSET, lp->tx_dma_cr);
 
 	/* Populate the tail pointer and bring the Rx Axi DMA engine out of
-- 
2.35.1.1320.gc452695387.dirty


