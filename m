Return-Path: <netdev+bounces-114220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CA9941894
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 18:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D7A1C229C9
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92331A618F;
	Tue, 30 Jul 2024 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXALT9GS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B7B1A6160
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356595; cv=none; b=YR9tI9UMTMXRVFa3+jVCS9eeAvfjtusFSr4gqDTNp6nALpePWV7zRMQKKdMR8KuUlX66G8fJhKmKojIs4dbhNcPGy/+eP6gz/4Et1fxfVHreh4RqD6hTGenk2ExzDN/fqYjnfcvAm20PJN2M/6Hnt5ehbyxPNDw1OhDtKZRpaK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356595; c=relaxed/simple;
	bh=J/VhTyUA10rV8osBS0+AWqiehAKU1LR7+uA4+FB4Y84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LeISVBwgpMyA9yglKPws7r/ow61HQvFLh2Fxq9zVmFMKZybRjuxf0+TG3iO9rPeg2e4BVMBl8YmbXosjLifNLjo4xiVsWKGcWhaBIRvpVKn32u/VJuTWnGf7nzYiHo/ioQisthnG+YGVx/LFV1ACz7V/KB6MWiNyYYXUuz4Httw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXALT9GS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028E3C32782;
	Tue, 30 Jul 2024 16:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722356595;
	bh=J/VhTyUA10rV8osBS0+AWqiehAKU1LR7+uA4+FB4Y84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hXALT9GSgzgOaVje7p6eawFJPG+pl0yw1vINGzNV2C/nmDgC+j7XFmjCtRhKFbSOe
	 6kjSYW5eBWGAg+yOxS4ceWF0yZYuiWdvRb0wPCkHI7zD3QPArQd32mfGfkNVQWPNMk
	 14H8JSEp3dZV1YoVBuHzF3WnnOclmhbNlq/ebaYAhMdKiund17EN8LjcqguatRvfbC
	 sfrJu5Qrr1aDZiVs1XCPTzVbzJwyLN/Q22VWhiP94ZLxrh9f6J9QqkSWudtODumaCN
	 ucPs8J+y0XOpqX21Xj3tW11M/VnOCKxi+mX1OV/2taCoKOXPzhyzzzpHNsGeTrHxcm
	 5R6gm7c5xHf8g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo.bianconi83@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu,
	rkannoth@marvell.com,
	sgoutham@marvell.com,
	andrew@lunn.ch,
	arnd@arndb.de,
	horms@kernel.org
Subject: [PATCH net-next 2/9] net: airoha: Move airoha_queues in airoha_qdma
Date: Tue, 30 Jul 2024 18:22:41 +0200
Message-ID: <4b566f4f6feeb73f195863c01b7c9ae1ad01474a.1722356015.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722356015.git.lorenzo@kernel.org>
References: <cover.1722356015.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

QDMA controllers available in EN7581 SoC have independent tx/rx hw queues
so move them in airoha_queues structure.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 285 +++++++++++----------
 1 file changed, 144 insertions(+), 141 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 4d0b3cbc8912..10bb30732c32 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -785,6 +785,17 @@ struct airoha_hw_stats {
 
 struct airoha_qdma {
 	void __iomem *regs;
+
+	struct airoha_tx_irq_queue q_tx_irq[AIROHA_NUM_TX_IRQ];
+
+	struct airoha_queue q_tx[AIROHA_NUM_TX_RING];
+	struct airoha_queue q_rx[AIROHA_NUM_RX_RING];
+
+	/* descriptor and packet buffers for qdma hw forward */
+	struct {
+		void *desc;
+		void *q;
+	} hfwd;
 };
 
 struct airoha_gdm_port {
@@ -809,20 +820,10 @@ struct airoha_eth {
 	struct reset_control_bulk_data rsts[AIROHA_MAX_NUM_RSTS];
 	struct reset_control_bulk_data xsi_rsts[AIROHA_MAX_NUM_XSI_RSTS];
 
-	struct airoha_qdma qdma[AIROHA_MAX_NUM_QDMA];
-	struct airoha_gdm_port *ports[AIROHA_MAX_NUM_GDM_PORTS];
-
 	struct net_device *napi_dev;
-	struct airoha_queue q_tx[AIROHA_NUM_TX_RING];
-	struct airoha_queue q_rx[AIROHA_NUM_RX_RING];
 
-	struct airoha_tx_irq_queue q_tx_irq[AIROHA_NUM_TX_IRQ];
-
-	/* descriptor and packet buffers for qdma hw forward */
-	struct {
-		void *desc;
-		void *q;
-	} hfwd;
+	struct airoha_qdma qdma[AIROHA_MAX_NUM_QDMA];
+	struct airoha_gdm_port *ports[AIROHA_MAX_NUM_GDM_PORTS];
 };
 
 static u32 airoha_rr(void __iomem *base, u32 offset)
@@ -1388,8 +1389,9 @@ static int airoha_fe_init(struct airoha_eth *eth)
 static int airoha_qdma_fill_rx_queue(struct airoha_queue *q)
 {
 	enum dma_data_direction dir = page_pool_get_dma_dir(q->page_pool);
+	struct airoha_qdma *qdma = &q->eth->qdma[0];
 	struct airoha_eth *eth = q->eth;
-	int qid = q - &eth->q_rx[0];
+	int qid = q - &qdma->q_rx[0];
 	int nframes = 0;
 
 	while (q->queued < q->ndesc - 1) {
@@ -1425,7 +1427,7 @@ static int airoha_qdma_fill_rx_queue(struct airoha_queue *q)
 		WRITE_ONCE(desc->msg2, 0);
 		WRITE_ONCE(desc->msg3, 0);
 
-		airoha_qdma_rmw(&eth->qdma[0], REG_RX_CPU_IDX(qid),
+		airoha_qdma_rmw(qdma, REG_RX_CPU_IDX(qid),
 				RX_RING_CPU_IDX_MASK,
 				FIELD_PREP(RX_RING_CPU_IDX_MASK, q->head));
 	}
@@ -1456,8 +1458,9 @@ static int airoha_qdma_get_gdm_port(struct airoha_eth *eth,
 static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 {
 	enum dma_data_direction dir = page_pool_get_dma_dir(q->page_pool);
+	struct airoha_qdma *qdma = &q->eth->qdma[0];
 	struct airoha_eth *eth = q->eth;
-	int qid = q - &eth->q_rx[0];
+	int qid = q - &qdma->q_rx[0];
 	int done = 0;
 
 	while (done < budget) {
@@ -1535,7 +1538,8 @@ static int airoha_qdma_rx_napi_poll(struct napi_struct *napi, int budget)
 }
 
 static int airoha_qdma_init_rx_queue(struct airoha_eth *eth,
-				     struct airoha_queue *q, int ndesc)
+				     struct airoha_queue *q,
+				     struct airoha_qdma *qdma, int ndesc)
 {
 	const struct page_pool_params pp_params = {
 		.order = 0,
@@ -1547,7 +1551,7 @@ static int airoha_qdma_init_rx_queue(struct airoha_eth *eth,
 		.dev = eth->dev,
 		.napi = &q->napi,
 	};
-	int qid = q - &eth->q_rx[0], thr;
+	int qid = q - &qdma->q_rx[0], thr;
 	dma_addr_t dma_addr;
 
 	q->buf_size = PAGE_SIZE / 2;
@@ -1574,17 +1578,15 @@ static int airoha_qdma_init_rx_queue(struct airoha_eth *eth,
 
 	netif_napi_add(eth->napi_dev, &q->napi, airoha_qdma_rx_napi_poll);
 
-	airoha_qdma_wr(&eth->qdma[0], REG_RX_RING_BASE(qid), dma_addr);
-	airoha_qdma_rmw(&eth->qdma[0], REG_RX_RING_SIZE(qid),
+	airoha_qdma_wr(qdma, REG_RX_RING_BASE(qid), dma_addr);
+	airoha_qdma_rmw(qdma, REG_RX_RING_SIZE(qid),
 			RX_RING_SIZE_MASK,
 			FIELD_PREP(RX_RING_SIZE_MASK, ndesc));
 
 	thr = clamp(ndesc >> 3, 1, 32);
-	airoha_qdma_rmw(&eth->qdma[0], REG_RX_RING_SIZE(qid),
-			RX_RING_THR_MASK,
+	airoha_qdma_rmw(qdma, REG_RX_RING_SIZE(qid), RX_RING_THR_MASK,
 			FIELD_PREP(RX_RING_THR_MASK, thr));
-	airoha_qdma_rmw(&eth->qdma[0], REG_RX_DMA_IDX(qid),
-			RX_RING_DMA_IDX_MASK,
+	airoha_qdma_rmw(qdma, REG_RX_DMA_IDX(qid), RX_RING_DMA_IDX_MASK,
 			FIELD_PREP(RX_RING_DMA_IDX_MASK, q->head));
 
 	airoha_qdma_fill_rx_queue(q);
@@ -1608,11 +1610,12 @@ static void airoha_qdma_cleanup_rx_queue(struct airoha_queue *q)
 	}
 }
 
-static int airoha_qdma_init_rx(struct airoha_eth *eth)
+static int airoha_qdma_init_rx(struct airoha_eth *eth,
+			       struct airoha_qdma *qdma)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(eth->q_rx); i++) {
+	for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
 		int err;
 
 		if (!(RX_DONE_INT_MASK & BIT(i))) {
@@ -1620,8 +1623,8 @@ static int airoha_qdma_init_rx(struct airoha_eth *eth)
 			continue;
 		}
 
-		err = airoha_qdma_init_rx_queue(eth, &eth->q_rx[i],
-						RX_DSCP_NUM(i));
+		err = airoha_qdma_init_rx_queue(eth, &qdma->q_rx[i],
+						qdma, RX_DSCP_NUM(i));
 		if (err)
 			return err;
 	}
@@ -1632,12 +1635,14 @@ static int airoha_qdma_init_rx(struct airoha_eth *eth)
 static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 {
 	struct airoha_tx_irq_queue *irq_q;
+	struct airoha_qdma *qdma;
 	struct airoha_eth *eth;
 	int id, done = 0;
 
 	irq_q = container_of(napi, struct airoha_tx_irq_queue, napi);
 	eth = irq_q->eth;
-	id = irq_q - &eth->q_tx_irq[0];
+	qdma = &eth->qdma[0];
+	id = irq_q - &qdma->q_tx_irq[0];
 
 	while (irq_q->queued > 0 && done < budget) {
 		u32 qid, last, val = irq_q->q[irq_q->head];
@@ -1654,10 +1659,10 @@ static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 		last = FIELD_GET(IRQ_DESC_IDX_MASK, val);
 		qid = FIELD_GET(IRQ_RING_IDX_MASK, val);
 
-		if (qid >= ARRAY_SIZE(eth->q_tx))
+		if (qid >= ARRAY_SIZE(qdma->q_tx))
 			continue;
 
-		q = &eth->q_tx[qid];
+		q = &qdma->q_tx[qid];
 		if (!q->ndesc)
 			continue;
 
@@ -1706,9 +1711,9 @@ static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 		int i, len = done >> 7;
 
 		for (i = 0; i < len; i++)
-			airoha_qdma_rmw(&eth->qdma[0], REG_IRQ_CLEAR_LEN(id),
+			airoha_qdma_rmw(qdma, REG_IRQ_CLEAR_LEN(id),
 					IRQ_CLEAR_LEN_MASK, 0x80);
-		airoha_qdma_rmw(&eth->qdma[0], REG_IRQ_CLEAR_LEN(id),
+		airoha_qdma_rmw(qdma, REG_IRQ_CLEAR_LEN(id),
 				IRQ_CLEAR_LEN_MASK, (done & 0x7f));
 	}
 
@@ -1720,9 +1725,10 @@ static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 }
 
 static int airoha_qdma_init_tx_queue(struct airoha_eth *eth,
-				     struct airoha_queue *q, int size)
+				     struct airoha_queue *q,
+				     struct airoha_qdma *qdma, int size)
 {
-	int i, qid = q - &eth->q_tx[0];
+	int i, qid = q - &qdma->q_tx[0];
 	dma_addr_t dma_addr;
 
 	spin_lock_init(&q->lock);
@@ -1747,12 +1753,10 @@ static int airoha_qdma_init_tx_queue(struct airoha_eth *eth,
 		WRITE_ONCE(q->desc[i].ctrl, cpu_to_le32(val));
 	}
 
-	airoha_qdma_wr(&eth->qdma[0], REG_TX_RING_BASE(qid), dma_addr);
-	airoha_qdma_rmw(&eth->qdma[0], REG_TX_CPU_IDX(qid),
-			TX_RING_CPU_IDX_MASK,
+	airoha_qdma_wr(qdma, REG_TX_RING_BASE(qid), dma_addr);
+	airoha_qdma_rmw(qdma, REG_TX_CPU_IDX(qid), TX_RING_CPU_IDX_MASK,
 			FIELD_PREP(TX_RING_CPU_IDX_MASK, q->head));
-	airoha_qdma_rmw(&eth->qdma[0], REG_TX_DMA_IDX(qid),
-			TX_RING_DMA_IDX_MASK,
+	airoha_qdma_rmw(qdma, REG_TX_DMA_IDX(qid), TX_RING_DMA_IDX_MASK,
 			FIELD_PREP(TX_RING_DMA_IDX_MASK, q->head));
 
 	return 0;
@@ -1760,9 +1764,9 @@ static int airoha_qdma_init_tx_queue(struct airoha_eth *eth,
 
 static int airoha_qdma_tx_irq_init(struct airoha_eth *eth,
 				   struct airoha_tx_irq_queue *irq_q,
-				   int size)
+				   struct airoha_qdma *qdma, int size)
 {
-	int id = irq_q - &eth->q_tx_irq[0];
+	int id = irq_q - &qdma->q_tx_irq[0];
 	dma_addr_t dma_addr;
 
 	netif_napi_add_tx(eth->napi_dev, &irq_q->napi,
@@ -1776,31 +1780,30 @@ static int airoha_qdma_tx_irq_init(struct airoha_eth *eth,
 	irq_q->size = size;
 	irq_q->eth = eth;
 
-	airoha_qdma_wr(&eth->qdma[0], REG_TX_IRQ_BASE(id), dma_addr);
-	airoha_qdma_rmw(&eth->qdma[0], REG_TX_IRQ_CFG(id),
-			TX_IRQ_DEPTH_MASK,
+	airoha_qdma_wr(qdma, REG_TX_IRQ_BASE(id), dma_addr);
+	airoha_qdma_rmw(qdma, REG_TX_IRQ_CFG(id), TX_IRQ_DEPTH_MASK,
 			FIELD_PREP(TX_IRQ_DEPTH_MASK, size));
-	airoha_qdma_rmw(&eth->qdma[0], REG_TX_IRQ_CFG(id),
-			TX_IRQ_THR_MASK,
+	airoha_qdma_rmw(qdma, REG_TX_IRQ_CFG(id), TX_IRQ_THR_MASK,
 			FIELD_PREP(TX_IRQ_THR_MASK, 1));
 
 	return 0;
 }
 
-static int airoha_qdma_init_tx(struct airoha_eth *eth)
+static int airoha_qdma_init_tx(struct airoha_eth *eth,
+			       struct airoha_qdma *qdma)
 {
 	int i, err;
 
-	for (i = 0; i < ARRAY_SIZE(eth->q_tx_irq); i++) {
-		err = airoha_qdma_tx_irq_init(eth, &eth->q_tx_irq[i],
-					      IRQ_QUEUE_LEN(i));
+	for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++) {
+		err = airoha_qdma_tx_irq_init(eth, &qdma->q_tx_irq[i],
+					      qdma, IRQ_QUEUE_LEN(i));
 		if (err)
 			return err;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(eth->q_tx); i++) {
-		err = airoha_qdma_init_tx_queue(eth, &eth->q_tx[i],
-						TX_DSCP_NUM);
+	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
+		err = airoha_qdma_init_tx_queue(eth, &qdma->q_tx[i],
+						qdma, TX_DSCP_NUM);
 		if (err)
 			return err;
 	}
@@ -1827,35 +1830,36 @@ static void airoha_qdma_cleanup_tx_queue(struct airoha_queue *q)
 	spin_unlock_bh(&q->lock);
 }
 
-static int airoha_qdma_init_hfwd_queues(struct airoha_eth *eth)
+static int airoha_qdma_init_hfwd_queues(struct airoha_eth *eth,
+					struct airoha_qdma *qdma)
 {
 	dma_addr_t dma_addr;
 	u32 status;
 	int size;
 
 	size = HW_DSCP_NUM * sizeof(struct airoha_qdma_fwd_desc);
-	eth->hfwd.desc = dmam_alloc_coherent(eth->dev, size, &dma_addr,
-					     GFP_KERNEL);
-	if (!eth->hfwd.desc)
+	qdma->hfwd.desc = dmam_alloc_coherent(eth->dev, size, &dma_addr,
+					      GFP_KERNEL);
+	if (!qdma->hfwd.desc)
 		return -ENOMEM;
 
-	airoha_qdma_wr(&eth->qdma[0], REG_FWD_DSCP_BASE, dma_addr);
+	airoha_qdma_wr(qdma, REG_FWD_DSCP_BASE, dma_addr);
 
 	size = AIROHA_MAX_PACKET_SIZE * HW_DSCP_NUM;
-	eth->hfwd.q = dmam_alloc_coherent(eth->dev, size, &dma_addr,
-					  GFP_KERNEL);
-	if (!eth->hfwd.q)
+	qdma->hfwd.q = dmam_alloc_coherent(eth->dev, size, &dma_addr,
+					   GFP_KERNEL);
+	if (!qdma->hfwd.q)
 		return -ENOMEM;
 
-	airoha_qdma_wr(&eth->qdma[0], REG_FWD_BUF_BASE, dma_addr);
+	airoha_qdma_wr(qdma, REG_FWD_BUF_BASE, dma_addr);
 
-	airoha_qdma_rmw(&eth->qdma[0], REG_HW_FWD_DSCP_CFG,
+	airoha_qdma_rmw(qdma, REG_HW_FWD_DSCP_CFG,
 			HW_FWD_DSCP_PAYLOAD_SIZE_MASK,
 			FIELD_PREP(HW_FWD_DSCP_PAYLOAD_SIZE_MASK, 0));
-	airoha_qdma_rmw(&eth->qdma[0], REG_FWD_DSCP_LOW_THR,
+	airoha_qdma_rmw(qdma, REG_FWD_DSCP_LOW_THR,
 			FWD_DSCP_LOW_THR_MASK,
 			FIELD_PREP(FWD_DSCP_LOW_THR_MASK, 128));
-	airoha_qdma_rmw(&eth->qdma[0], REG_LMGR_INIT_CFG,
+	airoha_qdma_rmw(qdma, REG_LMGR_INIT_CFG,
 			LMGR_INIT_START | LMGR_SRAM_MODE_MASK |
 			HW_FWD_DESC_NUM_MASK,
 			FIELD_PREP(HW_FWD_DESC_NUM_MASK, HW_DSCP_NUM) |
@@ -1863,75 +1867,69 @@ static int airoha_qdma_init_hfwd_queues(struct airoha_eth *eth)
 
 	return read_poll_timeout(airoha_qdma_rr, status,
 				 !(status & LMGR_INIT_START), USEC_PER_MSEC,
-				 30 * USEC_PER_MSEC, true, &eth->qdma[0],
+				 30 * USEC_PER_MSEC, true, qdma,
 				 REG_LMGR_INIT_CFG);
 }
 
-static void airoha_qdma_init_qos(struct airoha_eth *eth)
+static void airoha_qdma_init_qos(struct airoha_eth *eth,
+				 struct airoha_qdma *qdma)
 {
-	airoha_qdma_clear(&eth->qdma[0], REG_TXWRR_MODE_CFG,
-			  TWRR_WEIGHT_SCALE_MASK);
-	airoha_qdma_set(&eth->qdma[0], REG_TXWRR_MODE_CFG,
-			TWRR_WEIGHT_BASE_MASK);
+	airoha_qdma_clear(qdma, REG_TXWRR_MODE_CFG, TWRR_WEIGHT_SCALE_MASK);
+	airoha_qdma_set(qdma, REG_TXWRR_MODE_CFG, TWRR_WEIGHT_BASE_MASK);
 
-	airoha_qdma_clear(&eth->qdma[0], REG_PSE_BUF_USAGE_CFG,
+	airoha_qdma_clear(qdma, REG_PSE_BUF_USAGE_CFG,
 			  PSE_BUF_ESTIMATE_EN_MASK);
 
-	airoha_qdma_set(&eth->qdma[0], REG_EGRESS_RATE_METER_CFG,
+	airoha_qdma_set(qdma, REG_EGRESS_RATE_METER_CFG,
 			EGRESS_RATE_METER_EN_MASK |
 			EGRESS_RATE_METER_EQ_RATE_EN_MASK);
 	/* 2047us x 31 = 63.457ms */
-	airoha_qdma_rmw(&eth->qdma[0], REG_EGRESS_RATE_METER_CFG,
+	airoha_qdma_rmw(qdma, REG_EGRESS_RATE_METER_CFG,
 			EGRESS_RATE_METER_WINDOW_SZ_MASK,
 			FIELD_PREP(EGRESS_RATE_METER_WINDOW_SZ_MASK, 0x1f));
-	airoha_qdma_rmw(&eth->qdma[0], REG_EGRESS_RATE_METER_CFG,
+	airoha_qdma_rmw(qdma, REG_EGRESS_RATE_METER_CFG,
 			EGRESS_RATE_METER_TIMESLICE_MASK,
 			FIELD_PREP(EGRESS_RATE_METER_TIMESLICE_MASK, 0x7ff));
 
 	/* ratelimit init */
-	airoha_qdma_set(&eth->qdma[0], REG_GLB_TRTCM_CFG, GLB_TRTCM_EN_MASK);
+	airoha_qdma_set(qdma, REG_GLB_TRTCM_CFG, GLB_TRTCM_EN_MASK);
 	/* fast-tick 25us */
-	airoha_qdma_rmw(&eth->qdma[0], REG_GLB_TRTCM_CFG, GLB_FAST_TICK_MASK,
+	airoha_qdma_rmw(qdma, REG_GLB_TRTCM_CFG, GLB_FAST_TICK_MASK,
 			FIELD_PREP(GLB_FAST_TICK_MASK, 25));
-	airoha_qdma_rmw(&eth->qdma[0], REG_GLB_TRTCM_CFG,
-			GLB_SLOW_TICK_RATIO_MASK,
+	airoha_qdma_rmw(qdma, REG_GLB_TRTCM_CFG, GLB_SLOW_TICK_RATIO_MASK,
 			FIELD_PREP(GLB_SLOW_TICK_RATIO_MASK, 40));
 
-	airoha_qdma_set(&eth->qdma[0], REG_EGRESS_TRTCM_CFG,
-			EGRESS_TRTCM_EN_MASK);
-	airoha_qdma_rmw(&eth->qdma[0], REG_EGRESS_TRTCM_CFG,
-			EGRESS_FAST_TICK_MASK,
+	airoha_qdma_set(qdma, REG_EGRESS_TRTCM_CFG, EGRESS_TRTCM_EN_MASK);
+	airoha_qdma_rmw(qdma, REG_EGRESS_TRTCM_CFG, EGRESS_FAST_TICK_MASK,
 			FIELD_PREP(EGRESS_FAST_TICK_MASK, 25));
-	airoha_qdma_rmw(&eth->qdma[0], REG_EGRESS_TRTCM_CFG,
+	airoha_qdma_rmw(qdma, REG_EGRESS_TRTCM_CFG,
 			EGRESS_SLOW_TICK_RATIO_MASK,
 			FIELD_PREP(EGRESS_SLOW_TICK_RATIO_MASK, 40));
 
-	airoha_qdma_set(&eth->qdma[0], REG_INGRESS_TRTCM_CFG,
-			INGRESS_TRTCM_EN_MASK);
-	airoha_qdma_clear(&eth->qdma[0], REG_INGRESS_TRTCM_CFG,
+	airoha_qdma_set(qdma, REG_INGRESS_TRTCM_CFG, INGRESS_TRTCM_EN_MASK);
+	airoha_qdma_clear(qdma, REG_INGRESS_TRTCM_CFG,
 			  INGRESS_TRTCM_MODE_MASK);
-	airoha_qdma_rmw(&eth->qdma[0], REG_INGRESS_TRTCM_CFG,
-			INGRESS_FAST_TICK_MASK,
+	airoha_qdma_rmw(qdma, REG_INGRESS_TRTCM_CFG, INGRESS_FAST_TICK_MASK,
 			FIELD_PREP(INGRESS_FAST_TICK_MASK, 125));
-	airoha_qdma_rmw(&eth->qdma[0], REG_INGRESS_TRTCM_CFG,
+	airoha_qdma_rmw(qdma, REG_INGRESS_TRTCM_CFG,
 			INGRESS_SLOW_TICK_RATIO_MASK,
 			FIELD_PREP(INGRESS_SLOW_TICK_RATIO_MASK, 8));
 
-	airoha_qdma_set(&eth->qdma[0], REG_SLA_TRTCM_CFG, SLA_TRTCM_EN_MASK);
-	airoha_qdma_rmw(&eth->qdma[0], REG_SLA_TRTCM_CFG, SLA_FAST_TICK_MASK,
+	airoha_qdma_set(qdma, REG_SLA_TRTCM_CFG, SLA_TRTCM_EN_MASK);
+	airoha_qdma_rmw(qdma, REG_SLA_TRTCM_CFG, SLA_FAST_TICK_MASK,
 			FIELD_PREP(SLA_FAST_TICK_MASK, 25));
-	airoha_qdma_rmw(&eth->qdma[0], REG_SLA_TRTCM_CFG,
-			SLA_SLOW_TICK_RATIO_MASK,
+	airoha_qdma_rmw(qdma, REG_SLA_TRTCM_CFG, SLA_SLOW_TICK_RATIO_MASK,
 			FIELD_PREP(SLA_SLOW_TICK_RATIO_MASK, 40));
 }
 
-static int airoha_qdma_hw_init(struct airoha_eth *eth)
+static int airoha_qdma_hw_init(struct airoha_eth *eth,
+			       struct airoha_qdma *qdma)
 {
 	int i;
 
 	/* clear pending irqs */
 	for (i = 0; i < ARRAY_SIZE(eth->irqmask); i++)
-		airoha_qdma_wr(&eth->qdma[0], REG_INT_STATUS(i), 0xffffffff);
+		airoha_qdma_wr(qdma, REG_INT_STATUS(i), 0xffffffff);
 
 	/* setup irqs */
 	airoha_qdma_irq_enable(eth, QDMA_INT_REG_IDX0, INT_IDX0_MASK);
@@ -1939,21 +1937,20 @@ static int airoha_qdma_hw_init(struct airoha_eth *eth)
 	airoha_qdma_irq_enable(eth, QDMA_INT_REG_IDX4, INT_IDX4_MASK);
 
 	/* setup irq binding */
-	for (i = 0; i < ARRAY_SIZE(eth->q_tx); i++) {
-		if (!eth->q_tx[i].ndesc)
+	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
+		if (!qdma->q_tx[i].ndesc)
 			continue;
 
 		if (TX_RING_IRQ_BLOCKING_MAP_MASK & BIT(i))
-			airoha_qdma_set(&eth->qdma[0],
-					REG_TX_RING_BLOCKING(i),
+			airoha_qdma_set(qdma, REG_TX_RING_BLOCKING(i),
 					TX_RING_IRQ_BLOCKING_CFG_MASK);
 		else
-			airoha_qdma_clear(&eth->qdma[0],
+			airoha_qdma_clear(qdma,
 					  REG_TX_RING_BLOCKING(i),
 					  TX_RING_IRQ_BLOCKING_CFG_MASK);
 	}
 
-	airoha_qdma_wr(&eth->qdma[0], REG_QDMA_GLOBAL_CFG,
+	airoha_qdma_wr(qdma, REG_QDMA_GLOBAL_CFG,
 		       GLOBAL_CFG_RX_2B_OFFSET_MASK |
 		       FIELD_PREP(GLOBAL_CFG_DMA_PREFERENCE_MASK, 3) |
 		       GLOBAL_CFG_CPU_TXR_RR_MASK |
@@ -1964,18 +1961,18 @@ static int airoha_qdma_hw_init(struct airoha_eth *eth)
 		       GLOBAL_CFG_TX_WB_DONE_MASK |
 		       FIELD_PREP(GLOBAL_CFG_MAX_ISSUE_NUM_MASK, 2));
 
-	airoha_qdma_init_qos(eth);
+	airoha_qdma_init_qos(eth, qdma);
 
 	/* disable qdma rx delay interrupt */
-	for (i = 0; i < ARRAY_SIZE(eth->q_rx); i++) {
-		if (!eth->q_rx[i].ndesc)
+	for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
+		if (!qdma->q_rx[i].ndesc)
 			continue;
 
-		airoha_qdma_clear(&eth->qdma[0], REG_RX_DELAY_INT_IDX(i),
+		airoha_qdma_clear(qdma, REG_RX_DELAY_INT_IDX(i),
 				  RX_DELAY_INT_MASK);
 	}
 
-	airoha_qdma_set(&eth->qdma[0], REG_TXQ_CNGST_CFG,
+	airoha_qdma_set(qdma, REG_TXQ_CNGST_CFG,
 			TXQ_CNGST_DROP_EN | TXQ_CNGST_DEI_DROP_EN);
 
 	return 0;
@@ -1985,12 +1982,14 @@ static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
 {
 	struct airoha_eth *eth = dev_instance;
 	u32 intr[ARRAY_SIZE(eth->irqmask)];
+	struct airoha_qdma *qdma;
 	int i;
 
+	qdma = &eth->qdma[0];
 	for (i = 0; i < ARRAY_SIZE(eth->irqmask); i++) {
-		intr[i] = airoha_qdma_rr(&eth->qdma[0], REG_INT_STATUS(i));
+		intr[i] = airoha_qdma_rr(qdma, REG_INT_STATUS(i));
 		intr[i] &= eth->irqmask[i];
-		airoha_qdma_wr(&eth->qdma[0], REG_INT_STATUS(i), intr[i]);
+		airoha_qdma_wr(qdma, REG_INT_STATUS(i), intr[i]);
 	}
 
 	if (!test_bit(DEV_STATE_INITIALIZED, &eth->state))
@@ -2000,18 +1999,18 @@ static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
 		airoha_qdma_irq_disable(eth, QDMA_INT_REG_IDX1,
 					RX_DONE_INT_MASK);
 
-		for (i = 0; i < ARRAY_SIZE(eth->q_rx); i++) {
-			if (!eth->q_rx[i].ndesc)
+		for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
+			if (!qdma->q_rx[i].ndesc)
 				continue;
 
 			if (intr[1] & BIT(i))
-				napi_schedule(&eth->q_rx[i].napi);
+				napi_schedule(&qdma->q_rx[i].napi);
 		}
 	}
 
 	if (intr[0] & INT_TX_MASK) {
-		for (i = 0; i < ARRAY_SIZE(eth->q_tx_irq); i++) {
-			struct airoha_tx_irq_queue *irq_q = &eth->q_tx_irq[i];
+		for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++) {
+			struct airoha_tx_irq_queue *irq_q = &qdma->q_tx_irq[i];
 			u32 status, head;
 
 			if (!(intr[0] & TX_DONE_INT_MASK(i)))
@@ -2020,13 +2019,12 @@ static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
 			airoha_qdma_irq_disable(eth, QDMA_INT_REG_IDX0,
 						TX_DONE_INT_MASK(i));
 
-			status = airoha_qdma_rr(&eth->qdma[0],
-						REG_IRQ_STATUS(i));
+			status = airoha_qdma_rr(qdma, REG_IRQ_STATUS(i));
 			head = FIELD_GET(IRQ_HEAD_IDX_MASK, status);
 			irq_q->head = head % irq_q->size;
 			irq_q->queued = FIELD_GET(IRQ_ENTRY_LEN_MASK, status);
 
-			napi_schedule(&eth->q_tx_irq[i].napi);
+			napi_schedule(&qdma->q_tx_irq[i].napi);
 		}
 	}
 
@@ -2035,6 +2033,7 @@ static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
 
 static int airoha_qdma_init(struct airoha_eth *eth)
 {
+	struct airoha_qdma *qdma = &eth->qdma[0];
 	int err;
 
 	err = devm_request_irq(eth->dev, eth->irq, airoha_irq_handler,
@@ -2042,19 +2041,19 @@ static int airoha_qdma_init(struct airoha_eth *eth)
 	if (err)
 		return err;
 
-	err = airoha_qdma_init_rx(eth);
+	err = airoha_qdma_init_rx(eth, qdma);
 	if (err)
 		return err;
 
-	err = airoha_qdma_init_tx(eth);
+	err = airoha_qdma_init_tx(eth, qdma);
 	if (err)
 		return err;
 
-	err = airoha_qdma_init_hfwd_queues(eth);
+	err = airoha_qdma_init_hfwd_queues(eth, qdma);
 	if (err)
 		return err;
 
-	err = airoha_qdma_hw_init(eth);
+	err = airoha_qdma_hw_init(eth, qdma);
 	if (err)
 		return err;
 
@@ -2084,44 +2083,46 @@ static int airoha_hw_init(struct airoha_eth *eth)
 
 static void airoha_hw_cleanup(struct airoha_eth *eth)
 {
+	struct airoha_qdma *qdma = &eth->qdma[0];
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(eth->q_rx); i++) {
-		if (!eth->q_rx[i].ndesc)
+	for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
+		if (!qdma->q_rx[i].ndesc)
 			continue;
 
-		napi_disable(&eth->q_rx[i].napi);
-		netif_napi_del(&eth->q_rx[i].napi);
-		airoha_qdma_cleanup_rx_queue(&eth->q_rx[i]);
-		if (eth->q_rx[i].page_pool)
-			page_pool_destroy(eth->q_rx[i].page_pool);
+		napi_disable(&qdma->q_rx[i].napi);
+		netif_napi_del(&qdma->q_rx[i].napi);
+		airoha_qdma_cleanup_rx_queue(&qdma->q_rx[i]);
+		if (qdma->q_rx[i].page_pool)
+			page_pool_destroy(qdma->q_rx[i].page_pool);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(eth->q_tx_irq); i++) {
-		napi_disable(&eth->q_tx_irq[i].napi);
-		netif_napi_del(&eth->q_tx_irq[i].napi);
+	for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++) {
+		napi_disable(&qdma->q_tx_irq[i].napi);
+		netif_napi_del(&qdma->q_tx_irq[i].napi);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(eth->q_tx); i++) {
-		if (!eth->q_tx[i].ndesc)
+	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
+		if (!qdma->q_tx[i].ndesc)
 			continue;
 
-		airoha_qdma_cleanup_tx_queue(&eth->q_tx[i]);
+		airoha_qdma_cleanup_tx_queue(&qdma->q_tx[i]);
 	}
 }
 
 static void airoha_qdma_start_napi(struct airoha_eth *eth)
 {
+	struct airoha_qdma *qdma = &eth->qdma[0];
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(eth->q_tx_irq); i++)
-		napi_enable(&eth->q_tx_irq[i].napi);
+	for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++)
+		napi_enable(&qdma->q_tx_irq[i].napi);
 
-	for (i = 0; i < ARRAY_SIZE(eth->q_rx); i++) {
-		if (!eth->q_rx[i].ndesc)
+	for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
+		if (!qdma->q_rx[i].ndesc)
 			continue;
 
-		napi_enable(&eth->q_rx[i].napi);
+		napi_enable(&qdma->q_rx[i].napi);
 	}
 }
 
@@ -2367,6 +2368,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	struct airoha_eth *eth = port->eth;
 	u32 nr_frags = 1 + sinfo->nr_frags;
 	struct netdev_queue *txq;
+	struct airoha_qdma *qdma;
 	struct airoha_queue *q;
 	void *data = skb->data;
 	u16 index;
@@ -2394,7 +2396,8 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	msg1 = FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
 	       FIELD_PREP(QDMA_ETH_TXMSG_METER_MASK, 0x7f);
 
-	q = &eth->q_tx[qid];
+	qdma = &eth->qdma[0];
+	q = &qdma->q_tx[qid];
 	if (WARN_ON_ONCE(!q->ndesc))
 		goto error;
 
@@ -2438,7 +2441,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 		e->dma_addr = addr;
 		e->dma_len = len;
 
-		airoha_qdma_rmw(&eth->qdma[0], REG_TX_CPU_IDX(qid),
+		airoha_qdma_rmw(qdma, REG_TX_CPU_IDX(qid),
 				TX_RING_CPU_IDX_MASK,
 				FIELD_PREP(TX_RING_CPU_IDX_MASK, index));
 
-- 
2.45.2


