Return-Path: <netdev+bounces-115008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0988944E25
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D892285174
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18F51A57C2;
	Thu,  1 Aug 2024 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rE0+sm0j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAA51A4F39
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522936; cv=none; b=NQtjZtuAtsniXdiBZhkKiqxO5vwiNZKriS7+DW+kzvOFcO5WzFdUFjhfLHyMyx6BtS99Th8aeroyR9VjIsiJqmQ0xX2O7IAyENI7IRhkMjAXWq7dJ38IC6p9lzY+ey+cSnPvIflsdRRdO8V7USFDyyMwYasFfq5V8aVh/ijDkI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522936; c=relaxed/simple;
	bh=KEhkadlzqJwzpJPP8Fdtmsri2r04puQXB5fLVgnY5SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fcjnli3f6bsFojJI5ES5VOa54L4KH50gVwA+Y5GrDjqhRbETz9ZzrDSO9BRagApea3WDKaJUl2B2DhLXAmhONPo6H3gz476ggbwUywXKCAI8uaIY9fmwFDhq10S0gZ5bcxX8WeFDM94/6Gj9E7HZwgFLkNanMFOtjzLay6saQCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rE0+sm0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEBFC32786;
	Thu,  1 Aug 2024 14:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722522936;
	bh=KEhkadlzqJwzpJPP8Fdtmsri2r04puQXB5fLVgnY5SE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rE0+sm0j289NTigQIfcAoTGkVh3AJHefxrwCIRGbQwouDMN/zG5dtT7kwA0alTLBP
	 B3T81dhoFtHHzd8lXEk3H8hhQKI2C5BUD9nm3jVexz2mMYXAIE2pEVyKrsf5+SqfMI
	 MElOQkhl7X02h6fhCVnYa5SO9EjFAXu31JdY532H48z2DPHwhSj8+5dH6052T0YdLW
	 nApHTeVGueCkgKVI8jRHH0cDAgvXxMA7umaewiGtj3Vqw7La4Wsd6jaNmU9zm9CFck
	 y4+4TxYJ1nJLNHs1tc5nxPtExbU0xa974Efwsl2BjfdWLo1W5mIb3wRneJkkgRzhXv
	 46droMnqoJWYw==
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
Subject: [PATCH v2 net-next 1/8] net: airoha: Introduce airoha_qdma struct
Date: Thu,  1 Aug 2024 16:35:03 +0200
Message-ID: <7df163bdc72ee29c3d27a0cbf54522ffeeafe53c.1722522582.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722522582.git.lorenzo@kernel.org>
References: <cover.1722522582.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce airoha_qdma struct and move qdma IO register mapping in
airoha_qdma. This is a preliminary patch to enable both QDMA controllers
available on EN7581 SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 197 ++++++++++++---------
 1 file changed, 112 insertions(+), 85 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 1c5b85a86df1..7add08bac8cf 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -18,6 +18,7 @@
 #include <uapi/linux/ppp_defs.h>
 
 #define AIROHA_MAX_NUM_GDM_PORTS	1
+#define AIROHA_MAX_NUM_QDMA		1
 #define AIROHA_MAX_NUM_RSTS		3
 #define AIROHA_MAX_NUM_XSI_RSTS		5
 #define AIROHA_MAX_MTU			2000
@@ -782,6 +783,10 @@ struct airoha_hw_stats {
 	u64 rx_len[7];
 };
 
+struct airoha_qdma {
+	void __iomem *regs;
+};
+
 struct airoha_gdm_port {
 	struct net_device *dev;
 	struct airoha_eth *eth;
@@ -794,8 +799,6 @@ struct airoha_eth {
 	struct device *dev;
 
 	unsigned long state;
-
-	void __iomem *qdma_regs;
 	void __iomem *fe_regs;
 
 	/* protect concurrent irqmask accesses */
@@ -806,6 +809,7 @@ struct airoha_eth {
 	struct reset_control_bulk_data rsts[AIROHA_MAX_NUM_RSTS];
 	struct reset_control_bulk_data xsi_rsts[AIROHA_MAX_NUM_XSI_RSTS];
 
+	struct airoha_qdma qdma[AIROHA_MAX_NUM_QDMA];
 	struct airoha_gdm_port *ports[AIROHA_MAX_NUM_GDM_PORTS];
 
 	struct net_device *napi_dev;
@@ -850,16 +854,16 @@ static u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val)
 #define airoha_fe_clear(eth, offset, val)			\
 	airoha_rmw((eth)->fe_regs, (offset), (val), 0)
 
-#define airoha_qdma_rr(eth, offset)				\
-	airoha_rr((eth)->qdma_regs, (offset))
-#define airoha_qdma_wr(eth, offset, val)			\
-	airoha_wr((eth)->qdma_regs, (offset), (val))
-#define airoha_qdma_rmw(eth, offset, mask, val)			\
-	airoha_rmw((eth)->qdma_regs, (offset), (mask), (val))
-#define airoha_qdma_set(eth, offset, val)			\
-	airoha_rmw((eth)->qdma_regs, (offset), 0, (val))
-#define airoha_qdma_clear(eth, offset, val)			\
-	airoha_rmw((eth)->qdma_regs, (offset), (val), 0)
+#define airoha_qdma_rr(qdma, offset)				\
+	airoha_rr((qdma)->regs, (offset))
+#define airoha_qdma_wr(qdma, offset, val)			\
+	airoha_wr((qdma)->regs, (offset), (val))
+#define airoha_qdma_rmw(qdma, offset, mask, val)		\
+	airoha_rmw((qdma)->regs, (offset), (mask), (val))
+#define airoha_qdma_set(qdma, offset, val)			\
+	airoha_rmw((qdma)->regs, (offset), 0, (val))
+#define airoha_qdma_clear(qdma, offset, val)			\
+	airoha_rmw((qdma)->regs, (offset), (val), 0)
 
 static void airoha_qdma_set_irqmask(struct airoha_eth *eth, int index,
 				    u32 clear, u32 set)
@@ -873,11 +877,12 @@ static void airoha_qdma_set_irqmask(struct airoha_eth *eth, int index,
 
 	eth->irqmask[index] &= ~clear;
 	eth->irqmask[index] |= set;
-	airoha_qdma_wr(eth, REG_INT_ENABLE(index), eth->irqmask[index]);
+	airoha_qdma_wr(&eth->qdma[0], REG_INT_ENABLE(index),
+		       eth->irqmask[index]);
 	/* Read irq_enable register in order to guarantee the update above
 	 * completes in the spinlock critical section.
 	 */
-	airoha_qdma_rr(eth, REG_INT_ENABLE(index));
+	airoha_qdma_rr(&eth->qdma[0], REG_INT_ENABLE(index));
 
 	spin_unlock_irqrestore(&eth->irq_lock, flags);
 }
@@ -1383,6 +1388,7 @@ static int airoha_fe_init(struct airoha_eth *eth)
 static int airoha_qdma_fill_rx_queue(struct airoha_queue *q)
 {
 	enum dma_data_direction dir = page_pool_get_dma_dir(q->page_pool);
+	struct airoha_qdma *qdma = &q->eth->qdma[0];
 	struct airoha_eth *eth = q->eth;
 	int qid = q - &eth->q_rx[0];
 	int nframes = 0;
@@ -1420,7 +1426,8 @@ static int airoha_qdma_fill_rx_queue(struct airoha_queue *q)
 		WRITE_ONCE(desc->msg2, 0);
 		WRITE_ONCE(desc->msg3, 0);
 
-		airoha_qdma_rmw(eth, REG_RX_CPU_IDX(qid), RX_RING_CPU_IDX_MASK,
+		airoha_qdma_rmw(qdma, REG_RX_CPU_IDX(qid),
+				RX_RING_CPU_IDX_MASK,
 				FIELD_PREP(RX_RING_CPU_IDX_MASK, q->head));
 	}
 
@@ -1529,7 +1536,8 @@ static int airoha_qdma_rx_napi_poll(struct napi_struct *napi, int budget)
 }
 
 static int airoha_qdma_init_rx_queue(struct airoha_eth *eth,
-				     struct airoha_queue *q, int ndesc)
+				     struct airoha_queue *q,
+				     struct airoha_qdma *qdma, int ndesc)
 {
 	const struct page_pool_params pp_params = {
 		.order = 0,
@@ -1568,14 +1576,15 @@ static int airoha_qdma_init_rx_queue(struct airoha_eth *eth,
 
 	netif_napi_add(eth->napi_dev, &q->napi, airoha_qdma_rx_napi_poll);
 
-	airoha_qdma_wr(eth, REG_RX_RING_BASE(qid), dma_addr);
-	airoha_qdma_rmw(eth, REG_RX_RING_SIZE(qid), RX_RING_SIZE_MASK,
+	airoha_qdma_wr(qdma, REG_RX_RING_BASE(qid), dma_addr);
+	airoha_qdma_rmw(qdma, REG_RX_RING_SIZE(qid),
+			RX_RING_SIZE_MASK,
 			FIELD_PREP(RX_RING_SIZE_MASK, ndesc));
 
 	thr = clamp(ndesc >> 3, 1, 32);
-	airoha_qdma_rmw(eth, REG_RX_RING_SIZE(qid), RX_RING_THR_MASK,
+	airoha_qdma_rmw(qdma, REG_RX_RING_SIZE(qid), RX_RING_THR_MASK,
 			FIELD_PREP(RX_RING_THR_MASK, thr));
-	airoha_qdma_rmw(eth, REG_RX_DMA_IDX(qid), RX_RING_DMA_IDX_MASK,
+	airoha_qdma_rmw(qdma, REG_RX_DMA_IDX(qid), RX_RING_DMA_IDX_MASK,
 			FIELD_PREP(RX_RING_DMA_IDX_MASK, q->head));
 
 	airoha_qdma_fill_rx_queue(q);
@@ -1599,7 +1608,8 @@ static void airoha_qdma_cleanup_rx_queue(struct airoha_queue *q)
 	}
 }
 
-static int airoha_qdma_init_rx(struct airoha_eth *eth)
+static int airoha_qdma_init_rx(struct airoha_eth *eth,
+			       struct airoha_qdma *qdma)
 {
 	int i;
 
@@ -1612,7 +1622,7 @@ static int airoha_qdma_init_rx(struct airoha_eth *eth)
 		}
 
 		err = airoha_qdma_init_rx_queue(eth, &eth->q_rx[i],
-						RX_DSCP_NUM(i));
+						qdma, RX_DSCP_NUM(i));
 		if (err)
 			return err;
 	}
@@ -1623,11 +1633,13 @@ static int airoha_qdma_init_rx(struct airoha_eth *eth)
 static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 {
 	struct airoha_tx_irq_queue *irq_q;
+	struct airoha_qdma *qdma;
 	struct airoha_eth *eth;
 	int id, done = 0;
 
 	irq_q = container_of(napi, struct airoha_tx_irq_queue, napi);
 	eth = irq_q->eth;
+	qdma = &eth->qdma[0];
 	id = irq_q - &eth->q_tx_irq[0];
 
 	while (irq_q->queued > 0 && done < budget) {
@@ -1697,9 +1709,9 @@ static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 		int i, len = done >> 7;
 
 		for (i = 0; i < len; i++)
-			airoha_qdma_rmw(eth, REG_IRQ_CLEAR_LEN(id),
+			airoha_qdma_rmw(qdma, REG_IRQ_CLEAR_LEN(id),
 					IRQ_CLEAR_LEN_MASK, 0x80);
-		airoha_qdma_rmw(eth, REG_IRQ_CLEAR_LEN(id),
+		airoha_qdma_rmw(qdma, REG_IRQ_CLEAR_LEN(id),
 				IRQ_CLEAR_LEN_MASK, (done & 0x7f));
 	}
 
@@ -1711,7 +1723,8 @@ static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 }
 
 static int airoha_qdma_init_tx_queue(struct airoha_eth *eth,
-				     struct airoha_queue *q, int size)
+				     struct airoha_queue *q,
+				     struct airoha_qdma *qdma, int size)
 {
 	int i, qid = q - &eth->q_tx[0];
 	dma_addr_t dma_addr;
@@ -1738,10 +1751,10 @@ static int airoha_qdma_init_tx_queue(struct airoha_eth *eth,
 		WRITE_ONCE(q->desc[i].ctrl, cpu_to_le32(val));
 	}
 
-	airoha_qdma_wr(eth, REG_TX_RING_BASE(qid), dma_addr);
-	airoha_qdma_rmw(eth, REG_TX_CPU_IDX(qid), TX_RING_CPU_IDX_MASK,
+	airoha_qdma_wr(qdma, REG_TX_RING_BASE(qid), dma_addr);
+	airoha_qdma_rmw(qdma, REG_TX_CPU_IDX(qid), TX_RING_CPU_IDX_MASK,
 			FIELD_PREP(TX_RING_CPU_IDX_MASK, q->head));
-	airoha_qdma_rmw(eth, REG_TX_DMA_IDX(qid), TX_RING_DMA_IDX_MASK,
+	airoha_qdma_rmw(qdma, REG_TX_DMA_IDX(qid), TX_RING_DMA_IDX_MASK,
 			FIELD_PREP(TX_RING_DMA_IDX_MASK, q->head));
 
 	return 0;
@@ -1749,7 +1762,7 @@ static int airoha_qdma_init_tx_queue(struct airoha_eth *eth,
 
 static int airoha_qdma_tx_irq_init(struct airoha_eth *eth,
 				   struct airoha_tx_irq_queue *irq_q,
-				   int size)
+				   struct airoha_qdma *qdma, int size)
 {
 	int id = irq_q - &eth->q_tx_irq[0];
 	dma_addr_t dma_addr;
@@ -1765,29 +1778,30 @@ static int airoha_qdma_tx_irq_init(struct airoha_eth *eth,
 	irq_q->size = size;
 	irq_q->eth = eth;
 
-	airoha_qdma_wr(eth, REG_TX_IRQ_BASE(id), dma_addr);
-	airoha_qdma_rmw(eth, REG_TX_IRQ_CFG(id), TX_IRQ_DEPTH_MASK,
+	airoha_qdma_wr(qdma, REG_TX_IRQ_BASE(id), dma_addr);
+	airoha_qdma_rmw(qdma, REG_TX_IRQ_CFG(id), TX_IRQ_DEPTH_MASK,
 			FIELD_PREP(TX_IRQ_DEPTH_MASK, size));
-	airoha_qdma_rmw(eth, REG_TX_IRQ_CFG(id), TX_IRQ_THR_MASK,
+	airoha_qdma_rmw(qdma, REG_TX_IRQ_CFG(id), TX_IRQ_THR_MASK,
 			FIELD_PREP(TX_IRQ_THR_MASK, 1));
 
 	return 0;
 }
 
-static int airoha_qdma_init_tx(struct airoha_eth *eth)
+static int airoha_qdma_init_tx(struct airoha_eth *eth,
+			       struct airoha_qdma *qdma)
 {
 	int i, err;
 
 	for (i = 0; i < ARRAY_SIZE(eth->q_tx_irq); i++) {
 		err = airoha_qdma_tx_irq_init(eth, &eth->q_tx_irq[i],
-					      IRQ_QUEUE_LEN(i));
+					      qdma, IRQ_QUEUE_LEN(i));
 		if (err)
 			return err;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(eth->q_tx); i++) {
 		err = airoha_qdma_init_tx_queue(eth, &eth->q_tx[i],
-						TX_DSCP_NUM);
+						qdma, TX_DSCP_NUM);
 		if (err)
 			return err;
 	}
@@ -1814,7 +1828,8 @@ static void airoha_qdma_cleanup_tx_queue(struct airoha_queue *q)
 	spin_unlock_bh(&q->lock);
 }
 
-static int airoha_qdma_init_hfwd_queues(struct airoha_eth *eth)
+static int airoha_qdma_init_hfwd_queues(struct airoha_eth *eth,
+					struct airoha_qdma *qdma)
 {
 	dma_addr_t dma_addr;
 	u32 status;
@@ -1826,7 +1841,7 @@ static int airoha_qdma_init_hfwd_queues(struct airoha_eth *eth)
 	if (!eth->hfwd.desc)
 		return -ENOMEM;
 
-	airoha_qdma_wr(eth, REG_FWD_DSCP_BASE, dma_addr);
+	airoha_qdma_wr(qdma, REG_FWD_DSCP_BASE, dma_addr);
 
 	size = AIROHA_MAX_PACKET_SIZE * HW_DSCP_NUM;
 	eth->hfwd.q = dmam_alloc_coherent(eth->dev, size, &dma_addr,
@@ -1834,14 +1849,14 @@ static int airoha_qdma_init_hfwd_queues(struct airoha_eth *eth)
 	if (!eth->hfwd.q)
 		return -ENOMEM;
 
-	airoha_qdma_wr(eth, REG_FWD_BUF_BASE, dma_addr);
+	airoha_qdma_wr(qdma, REG_FWD_BUF_BASE, dma_addr);
 
-	airoha_qdma_rmw(eth, REG_HW_FWD_DSCP_CFG,
+	airoha_qdma_rmw(qdma, REG_HW_FWD_DSCP_CFG,
 			HW_FWD_DSCP_PAYLOAD_SIZE_MASK,
 			FIELD_PREP(HW_FWD_DSCP_PAYLOAD_SIZE_MASK, 0));
-	airoha_qdma_rmw(eth, REG_FWD_DSCP_LOW_THR, FWD_DSCP_LOW_THR_MASK,
+	airoha_qdma_rmw(qdma, REG_FWD_DSCP_LOW_THR, FWD_DSCP_LOW_THR_MASK,
 			FIELD_PREP(FWD_DSCP_LOW_THR_MASK, 128));
-	airoha_qdma_rmw(eth, REG_LMGR_INIT_CFG,
+	airoha_qdma_rmw(qdma, REG_LMGR_INIT_CFG,
 			LMGR_INIT_START | LMGR_SRAM_MODE_MASK |
 			HW_FWD_DESC_NUM_MASK,
 			FIELD_PREP(HW_FWD_DESC_NUM_MASK, HW_DSCP_NUM) |
@@ -1849,67 +1864,69 @@ static int airoha_qdma_init_hfwd_queues(struct airoha_eth *eth)
 
 	return read_poll_timeout(airoha_qdma_rr, status,
 				 !(status & LMGR_INIT_START), USEC_PER_MSEC,
-				 30 * USEC_PER_MSEC, true, eth,
+				 30 * USEC_PER_MSEC, true, qdma,
 				 REG_LMGR_INIT_CFG);
 }
 
-static void airoha_qdma_init_qos(struct airoha_eth *eth)
+static void airoha_qdma_init_qos(struct airoha_eth *eth,
+				 struct airoha_qdma *qdma)
 {
-	airoha_qdma_clear(eth, REG_TXWRR_MODE_CFG, TWRR_WEIGHT_SCALE_MASK);
-	airoha_qdma_set(eth, REG_TXWRR_MODE_CFG, TWRR_WEIGHT_BASE_MASK);
+	airoha_qdma_clear(qdma, REG_TXWRR_MODE_CFG, TWRR_WEIGHT_SCALE_MASK);
+	airoha_qdma_set(qdma, REG_TXWRR_MODE_CFG, TWRR_WEIGHT_BASE_MASK);
 
-	airoha_qdma_clear(eth, REG_PSE_BUF_USAGE_CFG,
+	airoha_qdma_clear(qdma, REG_PSE_BUF_USAGE_CFG,
 			  PSE_BUF_ESTIMATE_EN_MASK);
 
-	airoha_qdma_set(eth, REG_EGRESS_RATE_METER_CFG,
+	airoha_qdma_set(qdma, REG_EGRESS_RATE_METER_CFG,
 			EGRESS_RATE_METER_EN_MASK |
 			EGRESS_RATE_METER_EQ_RATE_EN_MASK);
 	/* 2047us x 31 = 63.457ms */
-	airoha_qdma_rmw(eth, REG_EGRESS_RATE_METER_CFG,
+	airoha_qdma_rmw(qdma, REG_EGRESS_RATE_METER_CFG,
 			EGRESS_RATE_METER_WINDOW_SZ_MASK,
 			FIELD_PREP(EGRESS_RATE_METER_WINDOW_SZ_MASK, 0x1f));
-	airoha_qdma_rmw(eth, REG_EGRESS_RATE_METER_CFG,
+	airoha_qdma_rmw(qdma, REG_EGRESS_RATE_METER_CFG,
 			EGRESS_RATE_METER_TIMESLICE_MASK,
 			FIELD_PREP(EGRESS_RATE_METER_TIMESLICE_MASK, 0x7ff));
 
 	/* ratelimit init */
-	airoha_qdma_set(eth, REG_GLB_TRTCM_CFG, GLB_TRTCM_EN_MASK);
+	airoha_qdma_set(qdma, REG_GLB_TRTCM_CFG, GLB_TRTCM_EN_MASK);
 	/* fast-tick 25us */
-	airoha_qdma_rmw(eth, REG_GLB_TRTCM_CFG, GLB_FAST_TICK_MASK,
+	airoha_qdma_rmw(qdma, REG_GLB_TRTCM_CFG, GLB_FAST_TICK_MASK,
 			FIELD_PREP(GLB_FAST_TICK_MASK, 25));
-	airoha_qdma_rmw(eth, REG_GLB_TRTCM_CFG, GLB_SLOW_TICK_RATIO_MASK,
+	airoha_qdma_rmw(qdma, REG_GLB_TRTCM_CFG, GLB_SLOW_TICK_RATIO_MASK,
 			FIELD_PREP(GLB_SLOW_TICK_RATIO_MASK, 40));
 
-	airoha_qdma_set(eth, REG_EGRESS_TRTCM_CFG, EGRESS_TRTCM_EN_MASK);
-	airoha_qdma_rmw(eth, REG_EGRESS_TRTCM_CFG, EGRESS_FAST_TICK_MASK,
+	airoha_qdma_set(qdma, REG_EGRESS_TRTCM_CFG, EGRESS_TRTCM_EN_MASK);
+	airoha_qdma_rmw(qdma, REG_EGRESS_TRTCM_CFG, EGRESS_FAST_TICK_MASK,
 			FIELD_PREP(EGRESS_FAST_TICK_MASK, 25));
-	airoha_qdma_rmw(eth, REG_EGRESS_TRTCM_CFG,
+	airoha_qdma_rmw(qdma, REG_EGRESS_TRTCM_CFG,
 			EGRESS_SLOW_TICK_RATIO_MASK,
 			FIELD_PREP(EGRESS_SLOW_TICK_RATIO_MASK, 40));
 
-	airoha_qdma_set(eth, REG_INGRESS_TRTCM_CFG, INGRESS_TRTCM_EN_MASK);
-	airoha_qdma_clear(eth, REG_INGRESS_TRTCM_CFG,
+	airoha_qdma_set(qdma, REG_INGRESS_TRTCM_CFG, INGRESS_TRTCM_EN_MASK);
+	airoha_qdma_clear(qdma, REG_INGRESS_TRTCM_CFG,
 			  INGRESS_TRTCM_MODE_MASK);
-	airoha_qdma_rmw(eth, REG_INGRESS_TRTCM_CFG, INGRESS_FAST_TICK_MASK,
+	airoha_qdma_rmw(qdma, REG_INGRESS_TRTCM_CFG, INGRESS_FAST_TICK_MASK,
 			FIELD_PREP(INGRESS_FAST_TICK_MASK, 125));
-	airoha_qdma_rmw(eth, REG_INGRESS_TRTCM_CFG,
+	airoha_qdma_rmw(qdma, REG_INGRESS_TRTCM_CFG,
 			INGRESS_SLOW_TICK_RATIO_MASK,
 			FIELD_PREP(INGRESS_SLOW_TICK_RATIO_MASK, 8));
 
-	airoha_qdma_set(eth, REG_SLA_TRTCM_CFG, SLA_TRTCM_EN_MASK);
-	airoha_qdma_rmw(eth, REG_SLA_TRTCM_CFG, SLA_FAST_TICK_MASK,
+	airoha_qdma_set(qdma, REG_SLA_TRTCM_CFG, SLA_TRTCM_EN_MASK);
+	airoha_qdma_rmw(qdma, REG_SLA_TRTCM_CFG, SLA_FAST_TICK_MASK,
 			FIELD_PREP(SLA_FAST_TICK_MASK, 25));
-	airoha_qdma_rmw(eth, REG_SLA_TRTCM_CFG, SLA_SLOW_TICK_RATIO_MASK,
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
-		airoha_qdma_wr(eth, REG_INT_STATUS(i), 0xffffffff);
+		airoha_qdma_wr(qdma, REG_INT_STATUS(i), 0xffffffff);
 
 	/* setup irqs */
 	airoha_qdma_irq_enable(eth, QDMA_INT_REG_IDX0, INT_IDX0_MASK);
@@ -1922,14 +1939,14 @@ static int airoha_qdma_hw_init(struct airoha_eth *eth)
 			continue;
 
 		if (TX_RING_IRQ_BLOCKING_MAP_MASK & BIT(i))
-			airoha_qdma_set(eth, REG_TX_RING_BLOCKING(i),
+			airoha_qdma_set(qdma, REG_TX_RING_BLOCKING(i),
 					TX_RING_IRQ_BLOCKING_CFG_MASK);
 		else
-			airoha_qdma_clear(eth, REG_TX_RING_BLOCKING(i),
+			airoha_qdma_clear(qdma, REG_TX_RING_BLOCKING(i),
 					  TX_RING_IRQ_BLOCKING_CFG_MASK);
 	}
 
-	airoha_qdma_wr(eth, REG_QDMA_GLOBAL_CFG,
+	airoha_qdma_wr(qdma, REG_QDMA_GLOBAL_CFG,
 		       GLOBAL_CFG_RX_2B_OFFSET_MASK |
 		       FIELD_PREP(GLOBAL_CFG_DMA_PREFERENCE_MASK, 3) |
 		       GLOBAL_CFG_CPU_TXR_RR_MASK |
@@ -1940,18 +1957,18 @@ static int airoha_qdma_hw_init(struct airoha_eth *eth)
 		       GLOBAL_CFG_TX_WB_DONE_MASK |
 		       FIELD_PREP(GLOBAL_CFG_MAX_ISSUE_NUM_MASK, 2));
 
-	airoha_qdma_init_qos(eth);
+	airoha_qdma_init_qos(eth, qdma);
 
 	/* disable qdma rx delay interrupt */
 	for (i = 0; i < ARRAY_SIZE(eth->q_rx); i++) {
 		if (!eth->q_rx[i].ndesc)
 			continue;
 
-		airoha_qdma_clear(eth, REG_RX_DELAY_INT_IDX(i),
+		airoha_qdma_clear(qdma, REG_RX_DELAY_INT_IDX(i),
 				  RX_DELAY_INT_MASK);
 	}
 
-	airoha_qdma_set(eth, REG_TXQ_CNGST_CFG,
+	airoha_qdma_set(qdma, REG_TXQ_CNGST_CFG,
 			TXQ_CNGST_DROP_EN | TXQ_CNGST_DEI_DROP_EN);
 
 	return 0;
@@ -1961,12 +1978,14 @@ static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
 {
 	struct airoha_eth *eth = dev_instance;
 	u32 intr[ARRAY_SIZE(eth->irqmask)];
+	struct airoha_qdma *qdma;
 	int i;
 
+	qdma = &eth->qdma[0];
 	for (i = 0; i < ARRAY_SIZE(eth->irqmask); i++) {
-		intr[i] = airoha_qdma_rr(eth, REG_INT_STATUS(i));
+		intr[i] = airoha_qdma_rr(qdma, REG_INT_STATUS(i));
 		intr[i] &= eth->irqmask[i];
-		airoha_qdma_wr(eth, REG_INT_STATUS(i), intr[i]);
+		airoha_qdma_wr(qdma, REG_INT_STATUS(i), intr[i]);
 	}
 
 	if (!test_bit(DEV_STATE_INITIALIZED, &eth->state))
@@ -1996,7 +2015,7 @@ static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
 			airoha_qdma_irq_disable(eth, QDMA_INT_REG_IDX0,
 						TX_DONE_INT_MASK(i));
 
-			status = airoha_qdma_rr(eth, REG_IRQ_STATUS(i));
+			status = airoha_qdma_rr(qdma, REG_IRQ_STATUS(i));
 			head = FIELD_GET(IRQ_HEAD_IDX_MASK, status);
 			irq_q->head = head % irq_q->size;
 			irq_q->queued = FIELD_GET(IRQ_ENTRY_LEN_MASK, status);
@@ -2010,6 +2029,7 @@ static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
 
 static int airoha_qdma_init(struct airoha_eth *eth)
 {
+	struct airoha_qdma *qdma = &eth->qdma[0];
 	int err;
 
 	err = devm_request_irq(eth->dev, eth->irq, airoha_irq_handler,
@@ -2017,19 +2037,19 @@ static int airoha_qdma_init(struct airoha_eth *eth)
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
 
@@ -2262,8 +2282,9 @@ static int airoha_dev_open(struct net_device *dev)
 		airoha_fe_clear(eth, REG_GDM_INGRESS_CFG(port->id),
 				GDM_STAG_EN_MASK);
 
-	airoha_qdma_set(eth, REG_QDMA_GLOBAL_CFG, GLOBAL_CFG_TX_DMA_EN_MASK);
-	airoha_qdma_set(eth, REG_QDMA_GLOBAL_CFG, GLOBAL_CFG_RX_DMA_EN_MASK);
+	airoha_qdma_set(&eth->qdma[0], REG_QDMA_GLOBAL_CFG,
+			GLOBAL_CFG_TX_DMA_EN_MASK |
+			GLOBAL_CFG_RX_DMA_EN_MASK);
 
 	return 0;
 }
@@ -2279,8 +2300,9 @@ static int airoha_dev_stop(struct net_device *dev)
 	if (err)
 		return err;
 
-	airoha_qdma_clear(eth, REG_QDMA_GLOBAL_CFG, GLOBAL_CFG_TX_DMA_EN_MASK);
-	airoha_qdma_clear(eth, REG_QDMA_GLOBAL_CFG, GLOBAL_CFG_RX_DMA_EN_MASK);
+	airoha_qdma_clear(&eth->qdma[0], REG_QDMA_GLOBAL_CFG,
+			  GLOBAL_CFG_TX_DMA_EN_MASK |
+			  GLOBAL_CFG_RX_DMA_EN_MASK);
 
 	return 0;
 }
@@ -2340,6 +2362,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	struct airoha_eth *eth = port->eth;
 	u32 nr_frags = 1 + sinfo->nr_frags;
 	struct netdev_queue *txq;
+	struct airoha_qdma *qdma;
 	struct airoha_queue *q;
 	void *data = skb->data;
 	u16 index;
@@ -2367,6 +2390,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	msg1 = FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
 	       FIELD_PREP(QDMA_ETH_TXMSG_METER_MASK, 0x7f);
 
+	qdma = &eth->qdma[0];
 	q = &eth->q_tx[qid];
 	if (WARN_ON_ONCE(!q->ndesc))
 		goto error;
@@ -2411,7 +2435,8 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 		e->dma_addr = addr;
 		e->dma_len = len;
 
-		airoha_qdma_rmw(eth, REG_TX_CPU_IDX(qid), TX_RING_CPU_IDX_MASK,
+		airoha_qdma_rmw(qdma, REG_TX_CPU_IDX(qid),
+				TX_RING_CPU_IDX_MASK,
 				FIELD_PREP(TX_RING_CPU_IDX_MASK, index));
 
 		data = skb_frag_address(frag);
@@ -2613,9 +2638,11 @@ static int airoha_probe(struct platform_device *pdev)
 		return dev_err_probe(eth->dev, PTR_ERR(eth->fe_regs),
 				     "failed to iomap fe regs\n");
 
-	eth->qdma_regs = devm_platform_ioremap_resource_byname(pdev, "qdma0");
-	if (IS_ERR(eth->qdma_regs))
-		return dev_err_probe(eth->dev, PTR_ERR(eth->qdma_regs),
+	eth->qdma[0].regs = devm_platform_ioremap_resource_byname(pdev,
+								  "qdma0");
+	if (IS_ERR(eth->qdma[0].regs))
+		return dev_err_probe(eth->dev,
+				     PTR_ERR(eth->qdma[0].regs),
 				     "failed to iomap qdma regs\n");
 
 	eth->rsts[0].id = "fe";
-- 
2.45.2


