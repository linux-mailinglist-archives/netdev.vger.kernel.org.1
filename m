Return-Path: <netdev+bounces-126743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1309C9725E7
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 01:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 372821C221D2
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 23:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF3819007F;
	Mon,  9 Sep 2024 23:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JBV36mWH"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BE118FC81
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 23:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725925944; cv=none; b=E4NYws+Q6Mm3h3MUWrEbrTXq18dKMHDOUKn6/ZYZ+gvbnkuOidjguohrYgU4rwCEcMl8fZwXoJfwV2GrhMFedNO0mVH/dTF29euLyWrwxeSMGXvXcZBUcBB28E/r6zTRSTTszxIHs5w9DMziRmf8hVFRETK2hlTTVbKuGvcj0iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725925944; c=relaxed/simple;
	bh=0ovg86RhwBQc1y9XDgR5iSetIxBkP0lVzSg8ihp4X+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ixopQgWrxPX8j4xZB/sULgQCFl7ilDTVbU1aelKjROz7lMc6ZAJ77FtL6/t39bjFfQ/MNj25XHIlYY1BZvxtLHHC03uIlQ5jkPHYBXFHC+EZ6yYdpO+uqJwzL7zIjEa8DtvE4eNbqf13o/66cx/iLEUL5yAH1J9VoSeqbXKlsMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JBV36mWH; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725925939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ssZDLWuhmg7BjjNQ/xg73GUgeYAa7avYss6Mbv4fsg=;
	b=JBV36mWH6/vKdO3LxZ67bLUKmC9zRy4wAS/wjmJOn7VbfPzPB0jNihXuwUq3PSjbq6j4rP
	RaNprjiFVc2ShMZ/CYLeqB4uWYukNY25z8AbfdfPDhVA6pjSkDHQ0AbB80tbxf8l9lyKJ4
	TvpyafBSztvtwH58vfhQpoC/uAWMXqg=
From: Sean Anderson <sean.anderson@linux.dev>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [RFC PATCH net-next v2 3/6] net: xilinx: axienet: Combine CR calculation
Date: Mon,  9 Sep 2024 19:52:05 -0400
Message-Id: <20240909235208.1331065-4-sean.anderson@linux.dev>
In-Reply-To: <20240909235208.1331065-1-sean.anderson@linux.dev>
References: <20240909235208.1331065-1-sean.anderson@linux.dev>
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
---

Changes in v2:
- Split off from runtime coalesce modification support

 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  2 -
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 69 ++++++++++---------
 2 files changed, 35 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 5c0a21ef96a4..c43ce8f7590c 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -112,8 +112,6 @@
 #define XAXIDMA_DELAY_MASK		((u32)0xFF000000) /* Delay timeout counter */
 #define XAXIDMA_COALESCE_MASK		((u32)0x00FF0000) /* Coalesce counter */
 
-#define XAXIDMA_DELAY_SHIFT		24
-
 #define XAXIDMA_IRQ_IOC_MASK		0x00001000 /* Completion intr */
 #define XAXIDMA_IRQ_DELAY_MASK		0x00002000 /* Delay interrupt */
 #define XAXIDMA_IRQ_ERROR_MASK		0x00004000 /* Error interrupt */
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index bc987f7ca1ea..bff94d378b9f 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -224,22 +224,41 @@ static void axienet_dma_bd_release(struct net_device *ndev)
 }
 
 /**
- * axienet_usec_to_timer - Calculate IRQ delay timer value
- * @lp:		Pointer to the axienet_local structure
- * @coalesce_usec: Microseconds to convert into timer value
+ * axienet_calc_cr() - Calculate control register value
+ * @lp: Device private data
+ * @coalesce_count: Number of completions before an interrupt
+ * @coalesce_usec: Microseconds after the last completion before an interrupt
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
+	count = min(count, FIELD_MAX(XAXIDMA_COALESCE_MASK));
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
@@ -249,31 +268,13 @@ static u32 axienet_usec_to_timer(struct axienet_local *lp, u32 coalesce_usec)
 static void axienet_dma_start(struct axienet_local *lp)
 {
 	/* Start updating the Rx channel control register */
-	lp->rx_dma_cr = FIELD_PREP(XAXIDMA_COALESCE_MASK,
-				   min(lp->coalesce_count_rx,
-				       FIELD_MAX(XAXIDMA_COALESCE_MASK))) |
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
-	lp->tx_dma_cr = FIELD_PREP(XAXIDMA_COALESCE_MASK,
-				   min(lp->coalesce_count_tx,
-				       FIELD_MAX(XAXIDMA_COALESCE_MASK))) |
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


