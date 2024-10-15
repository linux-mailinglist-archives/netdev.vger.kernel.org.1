Return-Path: <netdev+bounces-135605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C681B99E538
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 13:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46DF81F2378B
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984731EF0A8;
	Tue, 15 Oct 2024 11:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="efvsPzX+"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EA41EB9E9;
	Tue, 15 Oct 2024 11:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990598; cv=none; b=rtLlNcevASwEm1z7zvkhhtDzNzK5Lqj9/kNJLlRz2+jip0wIEto5tN62QSwXzNb9CXNi+gqkXa/gVpgXcN9SxGiEt03lRADaCk6nO1TU449DbCrf9jiYAeahzIY5v7j1rkCB/A5Rc3skbvUtWu1w9JzQe15M7VaxmtIvAoGoCto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990598; c=relaxed/simple;
	bh=Xsy8UGz7VuHZv4nic4lbn3L6RUGpi7hIqbvltbjJowI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqCQ4bPBcsuiX5Hh7l3Oi20Foy53JbWlCTRoAK5z6Nv0bHU2E+ohUlmULldfA9PSmkKB0lWPTd3QPr5TkgQcTwCtHOoDQD9gMT1Ex7ml7SkQNhG6bC30n2bJK87idLd1LjMErOXlchienzzZ0oJjIfqHd8muPdHkYPvshCxjC6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=efvsPzX+; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=gFUcBA7bMz011Qon0HV0vr2eacg00nel3rbA3DLVt/4=; b=efvsPzX+JB8We+Ih397/M3nhHV
	tGwrL2hqnVD9l2lhYogTUfNQjcLnU30DtSJxjbaQIjI4EqkbyXH+SNGrsx5mkSV3cZiXuHXpvEyKU
	wey3rbIQlRM3BXAZMLt3igQ0ryft0G0nmMxydsKZ0uyy5M1UdZHDYacrcasICdyVfSmQ=;
Received: from p54ae9bfc.dip0.t-ipconnect.de ([84.174.155.252] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1t0fQt-0096bC-2n;
	Tue, 15 Oct 2024 13:09:43 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next 4/4] net: ethernet: mtk_eth_soc: optimize dma ring address/index calculation
Date: Tue, 15 Oct 2024 13:09:38 +0200
Message-ID: <20241015110940.63702-4-nbd@nbd.name>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015110940.63702-1-nbd@nbd.name>
References: <20241015110940.63702-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since DMA descriptor sizes are all power of 2, we can avoid costly integer
division in favor or simple shifts.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 143 +++++++++++---------
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |   6 +-
 2 files changed, 83 insertions(+), 66 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 58b80af7230b..5e02b9576f2f 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -42,6 +42,11 @@ MODULE_PARM_DESC(msg_level, "Message level (-1=defaults,0=none,...,16=all)");
 				  offsetof(struct mtk_hw_stats, xdp_stats.x) / \
 				  sizeof(u64) }
 
+#define RX_DESC_OFS(eth, i) \
+	((i) << (eth)->soc->rx.desc_shift)
+#define TX_DESC_OFS(eth, i) \
+	((i) << (eth)->soc->tx.desc_shift)
+
 static const struct mtk_reg_map mtk_reg_map = {
 	.tx_irq_mask		= 0x1a1c,
 	.tx_irq_status		= 0x1a18,
@@ -1139,23 +1144,28 @@ static void *mtk_max_lro_buf_alloc(gfp_t gfp_mask)
 static int mtk_init_fq_dma(struct mtk_eth *eth)
 {
 	const struct mtk_soc_data *soc = eth->soc;
-	dma_addr_t phy_ring_tail;
+	dma_addr_t phy_ring_tail, phy_ring_addr;
 	int cnt = soc->tx.fq_dma_size;
 	dma_addr_t dma_addr;
+	void *ring_addr;
+	u32 desc_size;
 	int i, j, len;
 
 	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SRAM))
 		eth->scratch_ring = eth->sram_base;
 	else
 		eth->scratch_ring = dma_alloc_coherent(eth->dma_dev,
-						       cnt * soc->tx.desc_size,
+						       TX_DESC_OFS(eth, cnt),
 						       &eth->phy_scratch_ring,
 						       GFP_KERNEL);
 
 	if (unlikely(!eth->scratch_ring))
 		return -ENOMEM;
 
-	phy_ring_tail = eth->phy_scratch_ring + soc->tx.desc_size * (cnt - 1);
+	phy_ring_tail = eth->phy_scratch_ring + TX_DESC_OFS(eth, cnt - 1);
+	ring_addr = eth->scratch_ring;
+	phy_ring_addr = eth->phy_scratch_ring;
+	desc_size = TX_DESC_OFS(eth, 1);
 
 	for (j = 0; j < DIV_ROUND_UP(soc->tx.fq_dma_size, MTK_FQ_DMA_LENGTH); j++) {
 		len = min_t(int, cnt - j * MTK_FQ_DMA_LENGTH, MTK_FQ_DMA_LENGTH);
@@ -1174,11 +1184,12 @@ static int mtk_init_fq_dma(struct mtk_eth *eth)
 		for (i = 0; i < cnt; i++) {
 			struct mtk_tx_dma_v2 *txd;
 
-			txd = eth->scratch_ring + (j * MTK_FQ_DMA_LENGTH + i) * soc->tx.desc_size;
+			txd = ring_addr;
+			ring_addr += desc_size;
+			phy_ring_addr += desc_size;
 			txd->txd1 = dma_addr + i * MTK_QDMA_PAGE_SIZE;
 			if (j * MTK_FQ_DMA_LENGTH + i < cnt)
-				txd->txd2 = eth->phy_scratch_ring +
-					    (j * MTK_FQ_DMA_LENGTH + i + 1) * soc->tx.desc_size;
+				txd->txd2 = eth->phy_scratch_ring + phy_ring_addr;
 
 			txd->txd3 = TX_DMA_PLEN0(MTK_QDMA_PAGE_SIZE);
 			if (MTK_HAS_CAPS(soc->caps, MTK_36BIT_DMA))
@@ -1208,9 +1219,9 @@ static void *mtk_qdma_phys_to_virt(struct mtk_tx_ring *ring, u32 desc)
 }
 
 static struct mtk_tx_buf *mtk_desc_to_tx_buf(struct mtk_tx_ring *ring,
-					     void *txd, u32 txd_size)
+					     void *txd, u32 txd_shift)
 {
-	int idx = (txd - ring->dma) / txd_size;
+	int idx = (txd - ring->dma) >> txd_shift;
 
 	return &ring->buf[idx];
 }
@@ -1221,9 +1232,9 @@ static struct mtk_tx_dma *qdma_to_pdma(struct mtk_tx_ring *ring,
 	return ring->dma_pdma - (struct mtk_tx_dma *)ring->dma + dma;
 }
 
-static int txd_to_idx(struct mtk_tx_ring *ring, void *dma, u32 txd_size)
+static int txd_to_idx(struct mtk_tx_ring *ring, void *dma, u32 txd_shift)
 {
-	return (dma - ring->dma) / txd_size;
+	return (dma - ring->dma) >> txd_shift;
 }
 
 static void mtk_tx_unmap(struct mtk_eth *eth, struct mtk_tx_buf *tx_buf,
@@ -1431,7 +1442,7 @@ static int mtk_tx_map(struct sk_buff *skb, struct net_device *dev,
 	if (itxd == ring->last_free)
 		return -ENOMEM;
 
-	itx_buf = mtk_desc_to_tx_buf(ring, itxd, soc->tx.desc_size);
+	itx_buf = mtk_desc_to_tx_buf(ring, itxd, soc->tx.desc_shift);
 	memset(itx_buf, 0, sizeof(*itx_buf));
 
 	txd_info.addr = dma_map_single(eth->dma_dev, skb->data, txd_info.size,
@@ -1485,7 +1496,7 @@ static int mtk_tx_map(struct sk_buff *skb, struct net_device *dev,
 			mtk_tx_set_dma_desc(dev, txd, &txd_info);
 
 			tx_buf = mtk_desc_to_tx_buf(ring, txd,
-						    soc->tx.desc_size);
+						    soc->tx.desc_shift);
 			if (new_desc)
 				memset(tx_buf, 0, sizeof(*tx_buf));
 			tx_buf->data = (void *)MTK_DMA_DUMMY_DESC;
@@ -1528,7 +1539,7 @@ static int mtk_tx_map(struct sk_buff *skb, struct net_device *dev,
 	} else {
 		int next_idx;
 
-		next_idx = NEXT_DESP_IDX(txd_to_idx(ring, txd, soc->tx.desc_size),
+		next_idx = NEXT_DESP_IDX(txd_to_idx(ring, txd, soc->tx.desc_shift),
 					 ring->dma_size);
 		mtk_w32(eth, next_idx, MT7628_TX_CTX_IDX0);
 	}
@@ -1537,7 +1548,7 @@ static int mtk_tx_map(struct sk_buff *skb, struct net_device *dev,
 
 err_dma:
 	do {
-		tx_buf = mtk_desc_to_tx_buf(ring, itxd, soc->tx.desc_size);
+		tx_buf = mtk_desc_to_tx_buf(ring, itxd, soc->tx.desc_shift);
 
 		/* unmap dma */
 		mtk_tx_unmap(eth, tx_buf, NULL, false);
@@ -1701,7 +1712,7 @@ static struct mtk_rx_ring *mtk_get_rx_ring(struct mtk_eth *eth)
 
 		ring = &eth->rx_ring[i];
 		idx = NEXT_DESP_IDX(ring->calc_idx, ring->dma_size);
-		rxd = ring->dma + idx * eth->soc->rx.desc_size;
+		rxd = ring->dma + RX_DESC_OFS(eth, idx);
 		if (rxd->rxd2 & RX_DMA_DONE) {
 			ring->calc_idx_update = true;
 			return ring;
@@ -1869,7 +1880,7 @@ static int mtk_xdp_submit_frame(struct mtk_eth *eth, struct xdp_frame *xdpf,
 	}
 	htxd = txd;
 
-	tx_buf = mtk_desc_to_tx_buf(ring, txd, soc->tx.desc_size);
+	tx_buf = mtk_desc_to_tx_buf(ring, txd, soc->tx.desc_shift);
 	memset(tx_buf, 0, sizeof(*tx_buf));
 	htx_buf = tx_buf;
 
@@ -1888,7 +1899,7 @@ static int mtk_xdp_submit_frame(struct mtk_eth *eth, struct xdp_frame *xdpf,
 				goto unmap;
 
 			tx_buf = mtk_desc_to_tx_buf(ring, txd,
-						    soc->tx.desc_size);
+						    soc->tx.desc_shift);
 			memset(tx_buf, 0, sizeof(*tx_buf));
 			n_desc++;
 		}
@@ -1926,7 +1937,7 @@ static int mtk_xdp_submit_frame(struct mtk_eth *eth, struct xdp_frame *xdpf,
 	} else {
 		int idx;
 
-		idx = txd_to_idx(ring, txd, soc->tx.desc_size);
+		idx = txd_to_idx(ring, txd, soc->tx.desc_shift);
 		mtk_w32(eth, NEXT_DESP_IDX(idx, ring->dma_size),
 			MT7628_TX_CTX_IDX0);
 	}
@@ -1937,7 +1948,7 @@ static int mtk_xdp_submit_frame(struct mtk_eth *eth, struct xdp_frame *xdpf,
 
 unmap:
 	while (htxd != txd) {
-		tx_buf = mtk_desc_to_tx_buf(ring, htxd, soc->tx.desc_size);
+		tx_buf = mtk_desc_to_tx_buf(ring, htxd, soc->tx.desc_shift);
 		mtk_tx_unmap(eth, tx_buf, NULL, false);
 
 		htxd->txd3 = TX_DMA_LS0 | TX_DMA_OWNER_CPU;
@@ -2069,7 +2080,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 			goto rx_done;
 
 		idx = NEXT_DESP_IDX(ring->calc_idx, ring->dma_size);
-		rxd = ring->dma + idx * eth->soc->rx.desc_size;
+		rxd = ring->dma + RX_DESC_OFS(eth, idx);
 		data = ring->data[idx];
 
 		if (!mtk_rx_get_desc(eth, &trxd, rxd))
@@ -2329,7 +2340,7 @@ static int mtk_poll_tx_qdma(struct mtk_eth *eth, int budget,
 			break;
 
 		tx_buf = mtk_desc_to_tx_buf(ring, desc,
-					    eth->soc->tx.desc_size);
+					    eth->soc->tx.desc_shift);
 		if (!tx_buf->data)
 			break;
 
@@ -2380,7 +2391,7 @@ static int mtk_poll_tx_pdma(struct mtk_eth *eth, int budget,
 		}
 		mtk_tx_unmap(eth, tx_buf, &bq, true);
 
-		desc = ring->dma + cpu * eth->soc->tx.desc_size;
+		desc = ring->dma + TX_DESC_OFS(eth, cpu);
 		ring->last_free = desc;
 		atomic_inc(&ring->free_count);
 
@@ -2498,10 +2509,13 @@ static int mtk_tx_alloc(struct mtk_eth *eth)
 {
 	const struct mtk_soc_data *soc = eth->soc;
 	struct mtk_tx_ring *ring = &eth->tx_ring;
-	int i, sz = soc->tx.desc_size;
 	struct mtk_tx_dma_v2 *txd;
+	dma_addr_t desc_phys;
+	void *desc_addr;
+	u32 desc_size;
 	int ring_size;
 	u32 ofs, val;
+	int i;
 
 	if (MTK_HAS_CAPS(soc->caps, MTK_QDMA))
 		ring_size = MTK_QDMA_RING_SIZE;
@@ -2514,22 +2528,24 @@ static int mtk_tx_alloc(struct mtk_eth *eth)
 		goto no_tx_mem;
 
 	if (MTK_HAS_CAPS(soc->caps, MTK_SRAM)) {
-		ring->dma = eth->sram_base + soc->tx.fq_dma_size * sz;
-		ring->phys = eth->phy_scratch_ring + soc->tx.fq_dma_size * (dma_addr_t)sz;
+		ring->dma = eth->sram_base + TX_DESC_OFS(eth, soc->tx.fq_dma_size);
+		ring->phys = eth->phy_scratch_ring + TX_DESC_OFS(eth, soc->tx.fq_dma_size);
 	} else {
-		ring->dma = dma_alloc_coherent(eth->dma_dev, ring_size * sz,
+		ring->dma = dma_alloc_coherent(eth->dma_dev, TX_DESC_OFS(eth, ring_size),
 					       &ring->phys, GFP_KERNEL);
 	}
 
 	if (!ring->dma)
 		goto no_tx_mem;
 
+	desc_addr = ring->dma;
+	desc_phys = ring->phys;
+	desc_size = TX_DESC_OFS(eth, 1);
 	for (i = 0; i < ring_size; i++) {
-		int next = (i + 1) % ring_size;
-		u32 next_ptr = ring->phys + next * sz;
-
-		txd = ring->dma + i * sz;
-		txd->txd2 = next_ptr;
+		txd = desc_addr;
+		desc_addr += desc_size;
+		desc_phys += desc_size;
+		txd->txd2 = desc_phys;
 		txd->txd3 = TX_DMA_LS0 | TX_DMA_OWNER_CPU;
 		txd->txd4 = 0;
 		if (mtk_is_netsys_v2_or_greater(eth)) {
@@ -2545,7 +2561,7 @@ static int mtk_tx_alloc(struct mtk_eth *eth)
 	 * descriptors in ring->dma_pdma.
 	 */
 	if (!MTK_HAS_CAPS(soc->caps, MTK_QDMA)) {
-		ring->dma_pdma = dma_alloc_coherent(eth->dma_dev, ring_size * sz,
+		ring->dma_pdma = dma_alloc_coherent(eth->dma_dev, TX_DESC_OFS(eth, ring_size),
 						    &ring->phys_pdma, GFP_KERNEL);
 		if (!ring->dma_pdma)
 			goto no_tx_mem;
@@ -2560,7 +2576,7 @@ static int mtk_tx_alloc(struct mtk_eth *eth)
 	atomic_set(&ring->free_count, ring_size - 2);
 	ring->next_free = ring->dma;
 	ring->last_free = (void *)txd;
-	ring->last_free_ptr = (u32)(ring->phys + ((ring_size - 1) * sz));
+	ring->last_free_ptr = (u32)(ring->phys + TX_DESC_OFS(eth, ring_size - 1));
 	ring->thresh = MAX_SKB_FRAGS;
 
 	/* make sure that all changes to the dma ring are flushed before we
@@ -2572,7 +2588,7 @@ static int mtk_tx_alloc(struct mtk_eth *eth)
 		mtk_w32(eth, ring->phys, soc->reg_map->qdma.ctx_ptr);
 		mtk_w32(eth, ring->phys, soc->reg_map->qdma.dtx_ptr);
 		mtk_w32(eth,
-			ring->phys + ((ring_size - 1) * sz),
+			ring->phys + TX_DESC_OFS(eth, ring_size - 1),
 			soc->reg_map->qdma.crx_ptr);
 		mtk_w32(eth, ring->last_free_ptr, soc->reg_map->qdma.drx_ptr);
 
@@ -2621,14 +2637,14 @@ static void mtk_tx_clean(struct mtk_eth *eth)
 	}
 	if (!MTK_HAS_CAPS(soc->caps, MTK_SRAM) && ring->dma) {
 		dma_free_coherent(eth->dma_dev,
-				  ring->dma_size * soc->tx.desc_size,
+				  TX_DESC_OFS(eth, ring->dma_size),
 				  ring->dma, ring->phys);
 		ring->dma = NULL;
 	}
 
 	if (ring->dma_pdma) {
 		dma_free_coherent(eth->dma_dev,
-				  ring->dma_size * soc->tx.desc_size,
+				  TX_DESC_OFS(eth, ring->dma_size),
 				  ring->dma_pdma, ring->phys_pdma);
 		ring->dma_pdma = NULL;
 	}
@@ -2684,15 +2700,13 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 	if (!MTK_HAS_CAPS(eth->soc->caps, MTK_SRAM) ||
 	    rx_flag != MTK_RX_FLAGS_NORMAL) {
 		ring->dma = dma_alloc_coherent(eth->dma_dev,
-				rx_dma_size * eth->soc->rx.desc_size,
+				RX_DESC_OFS(eth, rx_dma_size),
 				&ring->phys, GFP_KERNEL);
 	} else {
 		struct mtk_tx_ring *tx_ring = &eth->tx_ring;
 
-		ring->dma = tx_ring->dma + tx_ring_size *
-			    eth->soc->tx.desc_size * (ring_no + 1);
-		ring->phys = tx_ring->phys + tx_ring_size *
-			     eth->soc->tx.desc_size * (ring_no + 1);
+		ring->dma = tx_ring->dma + TX_DESC_OFS(eth, tx_ring_size * (ring_no + 1));
+		ring->phys = tx_ring->phys + TX_DESC_OFS(eth, tx_ring_size * (ring_no + 1));
 	}
 
 	if (!ring->dma)
@@ -2703,7 +2717,7 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 		dma_addr_t dma_addr;
 		void *data;
 
-		rxd = ring->dma + i * eth->soc->rx.desc_size;
+		rxd = ring->dma + RX_DESC_OFS(eth, i);
 		if (ring->page_pool) {
 			data = mtk_page_pool_get_buff(ring->page_pool,
 						      &dma_addr, GFP_KERNEL);
@@ -2794,7 +2808,7 @@ static void mtk_rx_clean(struct mtk_eth *eth, struct mtk_rx_ring *ring, bool in_
 			if (!ring->data[i])
 				continue;
 
-			rxd = ring->dma + i * eth->soc->rx.desc_size;
+			rxd = ring->dma + RX_DESC_OFS(eth, i);
 			if (!rxd->rxd1)
 				continue;
 
@@ -2811,7 +2825,7 @@ static void mtk_rx_clean(struct mtk_eth *eth, struct mtk_rx_ring *ring, bool in_
 
 	if (!in_sram && ring->dma) {
 		dma_free_coherent(eth->dma_dev,
-				  ring->dma_size * eth->soc->rx.desc_size,
+				  RX_DESC_OFS(eth, ring->dma_size),
 				  ring->dma, ring->phys);
 		ring->dma = NULL;
 	}
@@ -3174,7 +3188,7 @@ static void mtk_dma_free(struct mtk_eth *eth)
 			netdev_reset_queue(eth->netdev[i]);
 	if (!MTK_HAS_CAPS(soc->caps, MTK_SRAM) && eth->scratch_ring) {
 		dma_free_coherent(eth->dma_dev,
-				  MTK_QDMA_RING_SIZE * soc->tx.desc_size,
+				  TX_DESC_OFS(eth, MTK_QDMA_RING_SIZE),
 				  eth->scratch_ring, eth->phy_scratch_ring);
 		eth->scratch_ring = NULL;
 		eth->phy_scratch_ring = 0;
@@ -5122,6 +5136,9 @@ static void mtk_remove(struct platform_device *pdev)
 	mtk_mdio_cleanup(eth);
 }
 
+#define DESC_SIZE(struct_name)				\
+	.desc_shift = const_ilog2(sizeof(struct_name))
+
 static const struct mtk_soc_data mt2701_data = {
 	.reg_map = &mtk_reg_map,
 	.caps = MT7623_CAPS | MTK_HWLRO,
@@ -5130,14 +5147,14 @@ static const struct mtk_soc_data mt2701_data = {
 	.required_pctl = true,
 	.version = 1,
 	.tx = {
-		.desc_size = sizeof(struct mtk_tx_dma),
+		DESC_SIZE(struct mtk_tx_dma),
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
 		.dma_size = MTK_DMA_SIZE(2K),
 		.fq_dma_size = MTK_DMA_SIZE(2K),
 	},
 	.rx = {
-		.desc_size = sizeof(struct mtk_rx_dma),
+		DESC_SIZE(struct mtk_rx_dma),
 		.irq_done_mask = MTK_RX_DONE_INT,
 		.dma_l4_valid = RX_DMA_L4_VALID,
 		.dma_size = MTK_DMA_SIZE(512),
@@ -5158,14 +5175,14 @@ static const struct mtk_soc_data mt7621_data = {
 	.hash_offset = 2,
 	.foe_entry_size = MTK_FOE_ENTRY_V1_SIZE,
 	.tx = {
-		.desc_size = sizeof(struct mtk_tx_dma),
+		DESC_SIZE(struct mtk_tx_dma),
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
 		.dma_size = MTK_DMA_SIZE(2K),
 		.fq_dma_size = MTK_DMA_SIZE(2K),
 	},
 	.rx = {
-		.desc_size = sizeof(struct mtk_rx_dma),
+		DESC_SIZE(struct mtk_rx_dma),
 		.irq_done_mask = MTK_RX_DONE_INT,
 		.dma_l4_valid = RX_DMA_L4_VALID,
 		.dma_size = MTK_DMA_SIZE(512),
@@ -5188,14 +5205,14 @@ static const struct mtk_soc_data mt7622_data = {
 	.has_accounting = true,
 	.foe_entry_size = MTK_FOE_ENTRY_V1_SIZE,
 	.tx = {
-		.desc_size = sizeof(struct mtk_tx_dma),
+		DESC_SIZE(struct mtk_tx_dma),
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
 		.dma_size = MTK_DMA_SIZE(2K),
 		.fq_dma_size = MTK_DMA_SIZE(2K),
 	},
 	.rx = {
-		.desc_size = sizeof(struct mtk_rx_dma),
+		DESC_SIZE(struct mtk_rx_dma),
 		.irq_done_mask = MTK_RX_DONE_INT,
 		.dma_l4_valid = RX_DMA_L4_VALID,
 		.dma_size = MTK_DMA_SIZE(512),
@@ -5217,14 +5234,14 @@ static const struct mtk_soc_data mt7623_data = {
 	.foe_entry_size = MTK_FOE_ENTRY_V1_SIZE,
 	.disable_pll_modes = true,
 	.tx = {
-		.desc_size = sizeof(struct mtk_tx_dma),
+		DESC_SIZE(struct mtk_tx_dma),
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
 		.dma_size = MTK_DMA_SIZE(2K),
 		.fq_dma_size = MTK_DMA_SIZE(2K),
 	},
 	.rx = {
-		.desc_size = sizeof(struct mtk_rx_dma),
+		DESC_SIZE(struct mtk_rx_dma),
 		.irq_done_mask = MTK_RX_DONE_INT,
 		.dma_l4_valid = RX_DMA_L4_VALID,
 		.dma_size = MTK_DMA_SIZE(512),
@@ -5243,14 +5260,14 @@ static const struct mtk_soc_data mt7629_data = {
 	.has_accounting = true,
 	.version = 1,
 	.tx = {
-		.desc_size = sizeof(struct mtk_tx_dma),
+		DESC_SIZE(struct mtk_tx_dma),
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
 		.dma_size = MTK_DMA_SIZE(2K),
 		.fq_dma_size = MTK_DMA_SIZE(2K),
 	},
 	.rx = {
-		.desc_size = sizeof(struct mtk_rx_dma),
+		DESC_SIZE(struct mtk_rx_dma),
 		.irq_done_mask = MTK_RX_DONE_INT,
 		.dma_l4_valid = RX_DMA_L4_VALID,
 		.dma_size = MTK_DMA_SIZE(512),
@@ -5273,14 +5290,14 @@ static const struct mtk_soc_data mt7981_data = {
 	.has_accounting = true,
 	.foe_entry_size = MTK_FOE_ENTRY_V2_SIZE,
 	.tx = {
-		.desc_size = sizeof(struct mtk_tx_dma_v2),
+		DESC_SIZE(struct mtk_tx_dma_v2),
 		.dma_max_len = MTK_TX_DMA_BUF_LEN_V2,
 		.dma_len_offset = 8,
 		.dma_size = MTK_DMA_SIZE(2K),
 		.fq_dma_size = MTK_DMA_SIZE(2K),
 	},
 	.rx = {
-		.desc_size = sizeof(struct mtk_rx_dma),
+		DESC_SIZE(struct mtk_rx_dma),
 		.irq_done_mask = MTK_RX_DONE_INT,
 		.dma_l4_valid = RX_DMA_L4_VALID_V2,
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
@@ -5303,14 +5320,14 @@ static const struct mtk_soc_data mt7986_data = {
 	.has_accounting = true,
 	.foe_entry_size = MTK_FOE_ENTRY_V2_SIZE,
 	.tx = {
-		.desc_size = sizeof(struct mtk_tx_dma_v2),
+		DESC_SIZE(struct mtk_tx_dma_v2),
 		.dma_max_len = MTK_TX_DMA_BUF_LEN_V2,
 		.dma_len_offset = 8,
 		.dma_size = MTK_DMA_SIZE(2K),
 		.fq_dma_size = MTK_DMA_SIZE(2K),
 	},
 	.rx = {
-		.desc_size = sizeof(struct mtk_rx_dma),
+		DESC_SIZE(struct mtk_rx_dma),
 		.irq_done_mask = MTK_RX_DONE_INT,
 		.dma_l4_valid = RX_DMA_L4_VALID_V2,
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
@@ -5333,14 +5350,14 @@ static const struct mtk_soc_data mt7988_data = {
 	.has_accounting = true,
 	.foe_entry_size = MTK_FOE_ENTRY_V3_SIZE,
 	.tx = {
-		.desc_size = sizeof(struct mtk_tx_dma_v2),
+		DESC_SIZE(struct mtk_tx_dma_v2),
 		.dma_max_len = MTK_TX_DMA_BUF_LEN_V2,
 		.dma_len_offset = 8,
 		.dma_size = MTK_DMA_SIZE(2K),
 		.fq_dma_size = MTK_DMA_SIZE(4K),
 	},
 	.rx = {
-		.desc_size = sizeof(struct mtk_rx_dma_v2),
+		DESC_SIZE(struct mtk_rx_dma_v2),
 		.irq_done_mask = MTK_RX_DONE_INT_V2,
 		.dma_l4_valid = RX_DMA_L4_VALID_V2,
 		.dma_max_len = MTK_TX_DMA_BUF_LEN_V2,
@@ -5357,13 +5374,13 @@ static const struct mtk_soc_data rt5350_data = {
 	.required_pctl = false,
 	.version = 1,
 	.tx = {
-		.desc_size = sizeof(struct mtk_tx_dma),
+		DESC_SIZE(struct mtk_tx_dma),
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
 		.dma_size = MTK_DMA_SIZE(2K),
 	},
 	.rx = {
-		.desc_size = sizeof(struct mtk_rx_dma),
+		DESC_SIZE(struct mtk_rx_dma),
 		.irq_done_mask = MTK_RX_DONE_INT,
 		.dma_l4_valid = RX_DMA_L4_VALID_PDMA,
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 654897141869..59e63ecb510d 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -1141,7 +1141,7 @@ struct mtk_reg_map {
  * @foe_entry_size		Foe table entry size.
  * @has_accounting		Bool indicating support for accounting of
  *				offloaded flows.
- * @desc_size			Tx/Rx DMA descriptor size.
+ * @desc_shift			Tx/Rx DMA descriptor size (in power-of-2).
  * @irq_done_mask		Rx irq done register mask.
  * @dma_l4_valid		Rx DMA valid register mask.
  * @dma_max_len			Max DMA tx/rx buffer length.
@@ -1162,14 +1162,14 @@ struct mtk_soc_data {
 	bool		has_accounting;
 	bool		disable_pll_modes;
 	struct {
-		u32	desc_size;
+		u32	desc_shift;
 		u32	dma_max_len;
 		u32	dma_len_offset;
 		u32	dma_size;
 		u32	fq_dma_size;
 	} tx;
 	struct {
-		u32	desc_size;
+		u32	desc_shift;
 		u32	irq_done_mask;
 		u32	dma_l4_valid;
 		u32	dma_max_len;
-- 
2.47.0


