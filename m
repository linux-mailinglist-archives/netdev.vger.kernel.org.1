Return-Path: <netdev+bounces-114219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E7B9418BB
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 18:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E68BAB2B3D7
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A1F1A6195;
	Tue, 30 Jul 2024 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBoMQE4/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B044F1A6166
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356591; cv=none; b=EsJxRbOPn0Xryi9VZr3jINZpIQlCKvydyb+1qG40kU/ucxF6EMbl/CduhPoQm+xAgkEit3yTmh0nTklr/InhUTxLiw5ftDOupNl1Z8tvI79cqRxxhMuqs0j46hOHQz6Qgm7JoJknOZpJUpAO8S4lkByevWgekIZB/GQkQugaiqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356591; c=relaxed/simple;
	bh=feVA7wQAg4vmCcoxb3dTKEftLArL0tl4tJSsezUzLc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/KsJaCd07VUiqyUZsSiAD0oVKdINuKdbBWo/H06octGDURexsKuHp+EMTzCjrB90yXH89lb0+5hNv6scZGSz9JjamQ2wfKkv8D+9zlKeiKavyJGnh78brNvqlRdJTEOeVWmZa4xYrRj5xC3kqtujhr+4AkRNh2ZXKeCxyNxf9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBoMQE4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0311EC32782;
	Tue, 30 Jul 2024 16:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722356591;
	bh=feVA7wQAg4vmCcoxb3dTKEftLArL0tl4tJSsezUzLc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FBoMQE4/YdEHL/z5l+gGlK5gCIkCGu3Smur/mTqUHU6yrYKgtuNW2xvx2+XQmSrXS
	 TH2jmOKOTdNafyvfoutvVRcd8pQII7/lBSCatlrT6afywtQKvSbDakLeWpjykerpvt
	 TWePvOKj4F5v9X7BJhLTZSvBdy3/NxP+vRopeSYpmB3kWedPOgJb5mM5VYtlfI/BZ3
	 9zXa/qyRCoLzA1OffVp/cLka5bnzFzm37xgr/yxT5hEXa6lkuODjMhwvqoWcJH9/66
	 gI58/+tcHYkSwz/+Cxe7JOxRUblY9WgJdtQaDnkPfr8sfe4hydROmkJykLu4XnKC3t
	 KHW+bIq/Xd4kQ==
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
Subject: [PATCH net-next 1/9] net: airoha: Introduce airoha_qdma struct
Date: Tue, 30 Jul 2024 18:22:40 +0200
Message-ID: <586f5674c6f5622605aa9d2ea9fba4e9c901a2f6.1722356015.git.lorenzo@kernel.org>
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

Introduce airoha_qdma struct and move qdma IO register mapping in
airoha_qdma. This is a preliminary patch to enable both QDMA controllers
available on EN7581 SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 168 ++++++++++++---------
 1 file changed, 99 insertions(+), 69 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 1c5b85a86df1..4d0b3cbc8912 100644
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
@@ -1420,7 +1425,8 @@ static int airoha_qdma_fill_rx_queue(struct airoha_queue *q)
 		WRITE_ONCE(desc->msg2, 0);
 		WRITE_ONCE(desc->msg3, 0);
 
-		airoha_qdma_rmw(eth, REG_RX_CPU_IDX(qid), RX_RING_CPU_IDX_MASK,
+		airoha_qdma_rmw(&eth->qdma[0], REG_RX_CPU_IDX(qid),
+				RX_RING_CPU_IDX_MASK,
 				FIELD_PREP(RX_RING_CPU_IDX_MASK, q->head));
 	}
 
@@ -1568,14 +1574,17 @@ static int airoha_qdma_init_rx_queue(struct airoha_eth *eth,
 
 	netif_napi_add(eth->napi_dev, &q->napi, airoha_qdma_rx_napi_poll);
 
-	airoha_qdma_wr(eth, REG_RX_RING_BASE(qid), dma_addr);
-	airoha_qdma_rmw(eth, REG_RX_RING_SIZE(qid), RX_RING_SIZE_MASK,
+	airoha_qdma_wr(&eth->qdma[0], REG_RX_RING_BASE(qid), dma_addr);
+	airoha_qdma_rmw(&eth->qdma[0], REG_RX_RING_SIZE(qid),
+			RX_RING_SIZE_MASK,
 			FIELD_PREP(RX_RING_SIZE_MASK, ndesc));
 
 	thr = clamp(ndesc >> 3, 1, 32);
-	airoha_qdma_rmw(eth, REG_RX_RING_SIZE(qid), RX_RING_THR_MASK,
+	airoha_qdma_rmw(&eth->qdma[0], REG_RX_RING_SIZE(qid),
+			RX_RING_THR_MASK,
 			FIELD_PREP(RX_RING_THR_MASK, thr));
-	airoha_qdma_rmw(eth, REG_RX_DMA_IDX(qid), RX_RING_DMA_IDX_MASK,
+	airoha_qdma_rmw(&eth->qdma[0], REG_RX_DMA_IDX(qid),
+			RX_RING_DMA_IDX_MASK,
 			FIELD_PREP(RX_RING_DMA_IDX_MASK, q->head));
 
 	airoha_qdma_fill_rx_queue(q);
@@ -1697,9 +1706,9 @@ static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 		int i, len = done >> 7;
 
 		for (i = 0; i < len; i++)
-			airoha_qdma_rmw(eth, REG_IRQ_CLEAR_LEN(id),
+			airoha_qdma_rmw(&eth->qdma[0], REG_IRQ_CLEAR_LEN(id),
 					IRQ_CLEAR_LEN_MASK, 0x80);
-		airoha_qdma_rmw(eth, REG_IRQ_CLEAR_LEN(id),
+		airoha_qdma_rmw(&eth->qdma[0], REG_IRQ_CLEAR_LEN(id),
 				IRQ_CLEAR_LEN_MASK, (done & 0x7f));
 	}
 
@@ -1738,10 +1747,12 @@ static int airoha_qdma_init_tx_queue(struct airoha_eth *eth,
 		WRITE_ONCE(q->desc[i].ctrl, cpu_to_le32(val));
 	}
 
-	airoha_qdma_wr(eth, REG_TX_RING_BASE(qid), dma_addr);
-	airoha_qdma_rmw(eth, REG_TX_CPU_IDX(qid), TX_RING_CPU_IDX_MASK,
+	airoha_qdma_wr(&eth->qdma[0], REG_TX_RING_BASE(qid), dma_addr);
+	airoha_qdma_rmw(&eth->qdma[0], REG_TX_CPU_IDX(qid),
+			TX_RING_CPU_IDX_MASK,
 			FIELD_PREP(TX_RING_CPU_IDX_MASK, q->head));
-	airoha_qdma_rmw(eth, REG_TX_DMA_IDX(qid), TX_RING_DMA_IDX_MASK,
+	airoha_qdma_rmw(&eth->qdma[0], REG_TX_DMA_IDX(qid),
+			TX_RING_DMA_IDX_MASK,
 			FIELD_PREP(TX_RING_DMA_IDX_MASK, q->head));
 
 	return 0;
@@ -1765,10 +1776,12 @@ static int airoha_qdma_tx_irq_init(struct airoha_eth *eth,
 	irq_q->size = size;
 	irq_q->eth = eth;
 
-	airoha_qdma_wr(eth, REG_TX_IRQ_BASE(id), dma_addr);
-	airoha_qdma_rmw(eth, REG_TX_IRQ_CFG(id), TX_IRQ_DEPTH_MASK,
+	airoha_qdma_wr(&eth->qdma[0], REG_TX_IRQ_BASE(id), dma_addr);
+	airoha_qdma_rmw(&eth->qdma[0], REG_TX_IRQ_CFG(id),
+			TX_IRQ_DEPTH_MASK,
 			FIELD_PREP(TX_IRQ_DEPTH_MASK, size));
-	airoha_qdma_rmw(eth, REG_TX_IRQ_CFG(id), TX_IRQ_THR_MASK,
+	airoha_qdma_rmw(&eth->qdma[0], REG_TX_IRQ_CFG(id),
+			TX_IRQ_THR_MASK,
 			FIELD_PREP(TX_IRQ_THR_MASK, 1));
 
 	return 0;
@@ -1826,7 +1839,7 @@ static int airoha_qdma_init_hfwd_queues(struct airoha_eth *eth)
 	if (!eth->hfwd.desc)
 		return -ENOMEM;
 
-	airoha_qdma_wr(eth, REG_FWD_DSCP_BASE, dma_addr);
+	airoha_qdma_wr(&eth->qdma[0], REG_FWD_DSCP_BASE, dma_addr);
 
 	size = AIROHA_MAX_PACKET_SIZE * HW_DSCP_NUM;
 	eth->hfwd.q = dmam_alloc_coherent(eth->dev, size, &dma_addr,
@@ -1834,14 +1847,15 @@ static int airoha_qdma_init_hfwd_queues(struct airoha_eth *eth)
 	if (!eth->hfwd.q)
 		return -ENOMEM;
 
-	airoha_qdma_wr(eth, REG_FWD_BUF_BASE, dma_addr);
+	airoha_qdma_wr(&eth->qdma[0], REG_FWD_BUF_BASE, dma_addr);
 
-	airoha_qdma_rmw(eth, REG_HW_FWD_DSCP_CFG,
+	airoha_qdma_rmw(&eth->qdma[0], REG_HW_FWD_DSCP_CFG,
 			HW_FWD_DSCP_PAYLOAD_SIZE_MASK,
 			FIELD_PREP(HW_FWD_DSCP_PAYLOAD_SIZE_MASK, 0));
-	airoha_qdma_rmw(eth, REG_FWD_DSCP_LOW_THR, FWD_DSCP_LOW_THR_MASK,
+	airoha_qdma_rmw(&eth->qdma[0], REG_FWD_DSCP_LOW_THR,
+			FWD_DSCP_LOW_THR_MASK,
 			FIELD_PREP(FWD_DSCP_LOW_THR_MASK, 128));
-	airoha_qdma_rmw(eth, REG_LMGR_INIT_CFG,
+	airoha_qdma_rmw(&eth->qdma[0], REG_LMGR_INIT_CFG,
 			LMGR_INIT_START | LMGR_SRAM_MODE_MASK |
 			HW_FWD_DESC_NUM_MASK,
 			FIELD_PREP(HW_FWD_DESC_NUM_MASK, HW_DSCP_NUM) |
@@ -1849,57 +1863,65 @@ static int airoha_qdma_init_hfwd_queues(struct airoha_eth *eth)
 
 	return read_poll_timeout(airoha_qdma_rr, status,
 				 !(status & LMGR_INIT_START), USEC_PER_MSEC,
-				 30 * USEC_PER_MSEC, true, eth,
+				 30 * USEC_PER_MSEC, true, &eth->qdma[0],
 				 REG_LMGR_INIT_CFG);
 }
 
 static void airoha_qdma_init_qos(struct airoha_eth *eth)
 {
-	airoha_qdma_clear(eth, REG_TXWRR_MODE_CFG, TWRR_WEIGHT_SCALE_MASK);
-	airoha_qdma_set(eth, REG_TXWRR_MODE_CFG, TWRR_WEIGHT_BASE_MASK);
+	airoha_qdma_clear(&eth->qdma[0], REG_TXWRR_MODE_CFG,
+			  TWRR_WEIGHT_SCALE_MASK);
+	airoha_qdma_set(&eth->qdma[0], REG_TXWRR_MODE_CFG,
+			TWRR_WEIGHT_BASE_MASK);
 
-	airoha_qdma_clear(eth, REG_PSE_BUF_USAGE_CFG,
+	airoha_qdma_clear(&eth->qdma[0], REG_PSE_BUF_USAGE_CFG,
 			  PSE_BUF_ESTIMATE_EN_MASK);
 
-	airoha_qdma_set(eth, REG_EGRESS_RATE_METER_CFG,
+	airoha_qdma_set(&eth->qdma[0], REG_EGRESS_RATE_METER_CFG,
 			EGRESS_RATE_METER_EN_MASK |
 			EGRESS_RATE_METER_EQ_RATE_EN_MASK);
 	/* 2047us x 31 = 63.457ms */
-	airoha_qdma_rmw(eth, REG_EGRESS_RATE_METER_CFG,
+	airoha_qdma_rmw(&eth->qdma[0], REG_EGRESS_RATE_METER_CFG,
 			EGRESS_RATE_METER_WINDOW_SZ_MASK,
 			FIELD_PREP(EGRESS_RATE_METER_WINDOW_SZ_MASK, 0x1f));
-	airoha_qdma_rmw(eth, REG_EGRESS_RATE_METER_CFG,
+	airoha_qdma_rmw(&eth->qdma[0], REG_EGRESS_RATE_METER_CFG,
 			EGRESS_RATE_METER_TIMESLICE_MASK,
 			FIELD_PREP(EGRESS_RATE_METER_TIMESLICE_MASK, 0x7ff));
 
 	/* ratelimit init */
-	airoha_qdma_set(eth, REG_GLB_TRTCM_CFG, GLB_TRTCM_EN_MASK);
+	airoha_qdma_set(&eth->qdma[0], REG_GLB_TRTCM_CFG, GLB_TRTCM_EN_MASK);
 	/* fast-tick 25us */
-	airoha_qdma_rmw(eth, REG_GLB_TRTCM_CFG, GLB_FAST_TICK_MASK,
+	airoha_qdma_rmw(&eth->qdma[0], REG_GLB_TRTCM_CFG, GLB_FAST_TICK_MASK,
 			FIELD_PREP(GLB_FAST_TICK_MASK, 25));
-	airoha_qdma_rmw(eth, REG_GLB_TRTCM_CFG, GLB_SLOW_TICK_RATIO_MASK,
+	airoha_qdma_rmw(&eth->qdma[0], REG_GLB_TRTCM_CFG,
+			GLB_SLOW_TICK_RATIO_MASK,
 			FIELD_PREP(GLB_SLOW_TICK_RATIO_MASK, 40));
 
-	airoha_qdma_set(eth, REG_EGRESS_TRTCM_CFG, EGRESS_TRTCM_EN_MASK);
-	airoha_qdma_rmw(eth, REG_EGRESS_TRTCM_CFG, EGRESS_FAST_TICK_MASK,
+	airoha_qdma_set(&eth->qdma[0], REG_EGRESS_TRTCM_CFG,
+			EGRESS_TRTCM_EN_MASK);
+	airoha_qdma_rmw(&eth->qdma[0], REG_EGRESS_TRTCM_CFG,
+			EGRESS_FAST_TICK_MASK,
 			FIELD_PREP(EGRESS_FAST_TICK_MASK, 25));
-	airoha_qdma_rmw(eth, REG_EGRESS_TRTCM_CFG,
+	airoha_qdma_rmw(&eth->qdma[0], REG_EGRESS_TRTCM_CFG,
 			EGRESS_SLOW_TICK_RATIO_MASK,
 			FIELD_PREP(EGRESS_SLOW_TICK_RATIO_MASK, 40));
 
-	airoha_qdma_set(eth, REG_INGRESS_TRTCM_CFG, INGRESS_TRTCM_EN_MASK);
-	airoha_qdma_clear(eth, REG_INGRESS_TRTCM_CFG,
+	airoha_qdma_set(&eth->qdma[0], REG_INGRESS_TRTCM_CFG,
+			INGRESS_TRTCM_EN_MASK);
+	airoha_qdma_clear(&eth->qdma[0], REG_INGRESS_TRTCM_CFG,
 			  INGRESS_TRTCM_MODE_MASK);
-	airoha_qdma_rmw(eth, REG_INGRESS_TRTCM_CFG, INGRESS_FAST_TICK_MASK,
+	airoha_qdma_rmw(&eth->qdma[0], REG_INGRESS_TRTCM_CFG,
+			INGRESS_FAST_TICK_MASK,
 			FIELD_PREP(INGRESS_FAST_TICK_MASK, 125));
-	airoha_qdma_rmw(eth, REG_INGRESS_TRTCM_CFG,
+	airoha_qdma_rmw(&eth->qdma[0], REG_INGRESS_TRTCM_CFG,
 			INGRESS_SLOW_TICK_RATIO_MASK,
 			FIELD_PREP(INGRESS_SLOW_TICK_RATIO_MASK, 8));
 
-	airoha_qdma_set(eth, REG_SLA_TRTCM_CFG, SLA_TRTCM_EN_MASK);
-	airoha_qdma_rmw(eth, REG_SLA_TRTCM_CFG, SLA_FAST_TICK_MASK,
+	airoha_qdma_set(&eth->qdma[0], REG_SLA_TRTCM_CFG, SLA_TRTCM_EN_MASK);
+	airoha_qdma_rmw(&eth->qdma[0], REG_SLA_TRTCM_CFG, SLA_FAST_TICK_MASK,
 			FIELD_PREP(SLA_FAST_TICK_MASK, 25));
-	airoha_qdma_rmw(eth, REG_SLA_TRTCM_CFG, SLA_SLOW_TICK_RATIO_MASK,
+	airoha_qdma_rmw(&eth->qdma[0], REG_SLA_TRTCM_CFG,
+			SLA_SLOW_TICK_RATIO_MASK,
 			FIELD_PREP(SLA_SLOW_TICK_RATIO_MASK, 40));
 }
 
@@ -1909,7 +1931,7 @@ static int airoha_qdma_hw_init(struct airoha_eth *eth)
 
 	/* clear pending irqs */
 	for (i = 0; i < ARRAY_SIZE(eth->irqmask); i++)
-		airoha_qdma_wr(eth, REG_INT_STATUS(i), 0xffffffff);
+		airoha_qdma_wr(&eth->qdma[0], REG_INT_STATUS(i), 0xffffffff);
 
 	/* setup irqs */
 	airoha_qdma_irq_enable(eth, QDMA_INT_REG_IDX0, INT_IDX0_MASK);
@@ -1922,14 +1944,16 @@ static int airoha_qdma_hw_init(struct airoha_eth *eth)
 			continue;
 
 		if (TX_RING_IRQ_BLOCKING_MAP_MASK & BIT(i))
-			airoha_qdma_set(eth, REG_TX_RING_BLOCKING(i),
+			airoha_qdma_set(&eth->qdma[0],
+					REG_TX_RING_BLOCKING(i),
 					TX_RING_IRQ_BLOCKING_CFG_MASK);
 		else
-			airoha_qdma_clear(eth, REG_TX_RING_BLOCKING(i),
+			airoha_qdma_clear(&eth->qdma[0],
+					  REG_TX_RING_BLOCKING(i),
 					  TX_RING_IRQ_BLOCKING_CFG_MASK);
 	}
 
-	airoha_qdma_wr(eth, REG_QDMA_GLOBAL_CFG,
+	airoha_qdma_wr(&eth->qdma[0], REG_QDMA_GLOBAL_CFG,
 		       GLOBAL_CFG_RX_2B_OFFSET_MASK |
 		       FIELD_PREP(GLOBAL_CFG_DMA_PREFERENCE_MASK, 3) |
 		       GLOBAL_CFG_CPU_TXR_RR_MASK |
@@ -1947,11 +1971,11 @@ static int airoha_qdma_hw_init(struct airoha_eth *eth)
 		if (!eth->q_rx[i].ndesc)
 			continue;
 
-		airoha_qdma_clear(eth, REG_RX_DELAY_INT_IDX(i),
+		airoha_qdma_clear(&eth->qdma[0], REG_RX_DELAY_INT_IDX(i),
 				  RX_DELAY_INT_MASK);
 	}
 
-	airoha_qdma_set(eth, REG_TXQ_CNGST_CFG,
+	airoha_qdma_set(&eth->qdma[0], REG_TXQ_CNGST_CFG,
 			TXQ_CNGST_DROP_EN | TXQ_CNGST_DEI_DROP_EN);
 
 	return 0;
@@ -1964,9 +1988,9 @@ static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(eth->irqmask); i++) {
-		intr[i] = airoha_qdma_rr(eth, REG_INT_STATUS(i));
+		intr[i] = airoha_qdma_rr(&eth->qdma[0], REG_INT_STATUS(i));
 		intr[i] &= eth->irqmask[i];
-		airoha_qdma_wr(eth, REG_INT_STATUS(i), intr[i]);
+		airoha_qdma_wr(&eth->qdma[0], REG_INT_STATUS(i), intr[i]);
 	}
 
 	if (!test_bit(DEV_STATE_INITIALIZED, &eth->state))
@@ -1996,7 +2020,8 @@ static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
 			airoha_qdma_irq_disable(eth, QDMA_INT_REG_IDX0,
 						TX_DONE_INT_MASK(i));
 
-			status = airoha_qdma_rr(eth, REG_IRQ_STATUS(i));
+			status = airoha_qdma_rr(&eth->qdma[0],
+						REG_IRQ_STATUS(i));
 			head = FIELD_GET(IRQ_HEAD_IDX_MASK, status);
 			irq_q->head = head % irq_q->size;
 			irq_q->queued = FIELD_GET(IRQ_ENTRY_LEN_MASK, status);
@@ -2262,8 +2287,9 @@ static int airoha_dev_open(struct net_device *dev)
 		airoha_fe_clear(eth, REG_GDM_INGRESS_CFG(port->id),
 				GDM_STAG_EN_MASK);
 
-	airoha_qdma_set(eth, REG_QDMA_GLOBAL_CFG, GLOBAL_CFG_TX_DMA_EN_MASK);
-	airoha_qdma_set(eth, REG_QDMA_GLOBAL_CFG, GLOBAL_CFG_RX_DMA_EN_MASK);
+	airoha_qdma_set(&eth->qdma[0], REG_QDMA_GLOBAL_CFG,
+			GLOBAL_CFG_TX_DMA_EN_MASK |
+			GLOBAL_CFG_RX_DMA_EN_MASK);
 
 	return 0;
 }
@@ -2279,8 +2305,9 @@ static int airoha_dev_stop(struct net_device *dev)
 	if (err)
 		return err;
 
-	airoha_qdma_clear(eth, REG_QDMA_GLOBAL_CFG, GLOBAL_CFG_TX_DMA_EN_MASK);
-	airoha_qdma_clear(eth, REG_QDMA_GLOBAL_CFG, GLOBAL_CFG_RX_DMA_EN_MASK);
+	airoha_qdma_clear(&eth->qdma[0], REG_QDMA_GLOBAL_CFG,
+			  GLOBAL_CFG_TX_DMA_EN_MASK |
+			  GLOBAL_CFG_RX_DMA_EN_MASK);
 
 	return 0;
 }
@@ -2411,7 +2438,8 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 		e->dma_addr = addr;
 		e->dma_len = len;
 
-		airoha_qdma_rmw(eth, REG_TX_CPU_IDX(qid), TX_RING_CPU_IDX_MASK,
+		airoha_qdma_rmw(&eth->qdma[0], REG_TX_CPU_IDX(qid),
+				TX_RING_CPU_IDX_MASK,
 				FIELD_PREP(TX_RING_CPU_IDX_MASK, index));
 
 		data = skb_frag_address(frag);
@@ -2613,9 +2641,11 @@ static int airoha_probe(struct platform_device *pdev)
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


