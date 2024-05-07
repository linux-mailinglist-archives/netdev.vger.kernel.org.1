Return-Path: <netdev+bounces-94102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D09F8BE205
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 14:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 183D31F25CFD
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7841158D9A;
	Tue,  7 May 2024 12:24:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D5C156C6D;
	Tue,  7 May 2024 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084687; cv=none; b=Gg+pSnsBT76FFj8bGjN8vp93oMmxEL9G0EtocHCGMBHu35MKmPiDQtBKsKnOXXHuVEQLMUfd85jR0j9aRN00xXVfJIa544jSY96KZBC5h+qOiUHHcBnTbDsjUZqXVNinLc9kjItfbNlUYq7+OAuX7fgExSN4Zz3FV4d1rbEoxWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084687; c=relaxed/simple;
	bh=OaPsOIHvxLoQPZ79XEB3YZR0K46ob4pA7wxYOLbBsdk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mk55UCzfkcLzQULnPqmROqzQI2fKezlOnVlL3O397+UTwjToN/GLufI/uHe2l1PzybL2VHQVoF6yxi/rEFkOJ7M5B91N2q3ad7ta1M5rZccKo+XZSRdTFP7pOjUTVgC/VLRNlJ7mB1GppMe0dxsqe9sNtzRrBu1tAS/YWIjYlbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1s4Js4-00000000496-1uu0;
	Tue, 07 May 2024 12:24:36 +0000
Date: Tue, 7 May 2024 13:24:28 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net v2 1/2] net: ethernet: mediatek: split tx and rx fields
 in mtk_soc_data struct
Message-ID: <6747c038f4fc3b490e1b7a355cdaaf361e359def.1715084578.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Lorenzo Bianconi <lorenzo@kernel.org>

Split tx and rx fields in mtk_soc_data struct. This is a preliminary
patch to roll back to ADMAv1 for MT7986 and MT7981 SoC in order to fix a
hw hang if the device receives a corrupted packet when using ADMAv2.0.

Fixes: 197c9e9b17b1 ("net: ethernet: mtk_eth_soc: introduce support for mt7986 chipset")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: improve commit message

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 210 ++++++++++++--------
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  29 +--
 2 files changed, 139 insertions(+), 100 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index caa13b9cedff..3eefb735ce19 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1139,7 +1139,7 @@ static int mtk_init_fq_dma(struct mtk_eth *eth)
 		eth->scratch_ring = eth->sram_base;
 	else
 		eth->scratch_ring = dma_alloc_coherent(eth->dma_dev,
-						       cnt * soc->txrx.txd_size,
+						       cnt * soc->tx.desc_size,
 						       &eth->phy_scratch_ring,
 						       GFP_KERNEL);
 	if (unlikely(!eth->scratch_ring))
@@ -1155,17 +1155,17 @@ static int mtk_init_fq_dma(struct mtk_eth *eth)
 	if (unlikely(dma_mapping_error(eth->dma_dev, dma_addr)))
 		return -ENOMEM;
 
-	phy_ring_tail = eth->phy_scratch_ring + soc->txrx.txd_size * (cnt - 1);
+	phy_ring_tail = eth->phy_scratch_ring + soc->tx.desc_size * (cnt - 1);
 
 	for (i = 0; i < cnt; i++) {
 		dma_addr_t addr = dma_addr + i * MTK_QDMA_PAGE_SIZE;
 		struct mtk_tx_dma_v2 *txd;
 
-		txd = eth->scratch_ring + i * soc->txrx.txd_size;
+		txd = eth->scratch_ring + i * soc->tx.desc_size;
 		txd->txd1 = addr;
 		if (i < cnt - 1)
 			txd->txd2 = eth->phy_scratch_ring +
-				    (i + 1) * soc->txrx.txd_size;
+				    (i + 1) * soc->tx.desc_size;
 
 		txd->txd3 = TX_DMA_PLEN0(MTK_QDMA_PAGE_SIZE);
 		if (MTK_HAS_CAPS(soc->caps, MTK_36BIT_DMA))
@@ -1416,7 +1416,7 @@ static int mtk_tx_map(struct sk_buff *skb, struct net_device *dev,
 	if (itxd == ring->last_free)
 		return -ENOMEM;
 
-	itx_buf = mtk_desc_to_tx_buf(ring, itxd, soc->txrx.txd_size);
+	itx_buf = mtk_desc_to_tx_buf(ring, itxd, soc->tx.desc_size);
 	memset(itx_buf, 0, sizeof(*itx_buf));
 
 	txd_info.addr = dma_map_single(eth->dma_dev, skb->data, txd_info.size,
@@ -1457,7 +1457,7 @@ static int mtk_tx_map(struct sk_buff *skb, struct net_device *dev,
 
 			memset(&txd_info, 0, sizeof(struct mtk_tx_dma_desc_info));
 			txd_info.size = min_t(unsigned int, frag_size,
-					      soc->txrx.dma_max_len);
+					      soc->tx.dma_max_len);
 			txd_info.qid = queue;
 			txd_info.last = i == skb_shinfo(skb)->nr_frags - 1 &&
 					!(frag_size - txd_info.size);
@@ -1470,7 +1470,7 @@ static int mtk_tx_map(struct sk_buff *skb, struct net_device *dev,
 			mtk_tx_set_dma_desc(dev, txd, &txd_info);
 
 			tx_buf = mtk_desc_to_tx_buf(ring, txd,
-						    soc->txrx.txd_size);
+						    soc->tx.desc_size);
 			if (new_desc)
 				memset(tx_buf, 0, sizeof(*tx_buf));
 			tx_buf->data = (void *)MTK_DMA_DUMMY_DESC;
@@ -1513,7 +1513,7 @@ static int mtk_tx_map(struct sk_buff *skb, struct net_device *dev,
 	} else {
 		int next_idx;
 
-		next_idx = NEXT_DESP_IDX(txd_to_idx(ring, txd, soc->txrx.txd_size),
+		next_idx = NEXT_DESP_IDX(txd_to_idx(ring, txd, soc->tx.desc_size),
 					 ring->dma_size);
 		mtk_w32(eth, next_idx, MT7628_TX_CTX_IDX0);
 	}
@@ -1522,7 +1522,7 @@ static int mtk_tx_map(struct sk_buff *skb, struct net_device *dev,
 
 err_dma:
 	do {
-		tx_buf = mtk_desc_to_tx_buf(ring, itxd, soc->txrx.txd_size);
+		tx_buf = mtk_desc_to_tx_buf(ring, itxd, soc->tx.desc_size);
 
 		/* unmap dma */
 		mtk_tx_unmap(eth, tx_buf, NULL, false);
@@ -1547,7 +1547,7 @@ static int mtk_cal_txd_req(struct mtk_eth *eth, struct sk_buff *skb)
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 			frag = &skb_shinfo(skb)->frags[i];
 			nfrags += DIV_ROUND_UP(skb_frag_size(frag),
-					       eth->soc->txrx.dma_max_len);
+					       eth->soc->tx.dma_max_len);
 		}
 	} else {
 		nfrags += skb_shinfo(skb)->nr_frags;
@@ -1654,7 +1654,7 @@ static struct mtk_rx_ring *mtk_get_rx_ring(struct mtk_eth *eth)
 
 		ring = &eth->rx_ring[i];
 		idx = NEXT_DESP_IDX(ring->calc_idx, ring->dma_size);
-		rxd = ring->dma + idx * eth->soc->txrx.rxd_size;
+		rxd = ring->dma + idx * eth->soc->rx.desc_size;
 		if (rxd->rxd2 & RX_DMA_DONE) {
 			ring->calc_idx_update = true;
 			return ring;
@@ -1822,7 +1822,7 @@ static int mtk_xdp_submit_frame(struct mtk_eth *eth, struct xdp_frame *xdpf,
 	}
 	htxd = txd;
 
-	tx_buf = mtk_desc_to_tx_buf(ring, txd, soc->txrx.txd_size);
+	tx_buf = mtk_desc_to_tx_buf(ring, txd, soc->tx.desc_size);
 	memset(tx_buf, 0, sizeof(*tx_buf));
 	htx_buf = tx_buf;
 
@@ -1841,7 +1841,7 @@ static int mtk_xdp_submit_frame(struct mtk_eth *eth, struct xdp_frame *xdpf,
 				goto unmap;
 
 			tx_buf = mtk_desc_to_tx_buf(ring, txd,
-						    soc->txrx.txd_size);
+						    soc->tx.desc_size);
 			memset(tx_buf, 0, sizeof(*tx_buf));
 			n_desc++;
 		}
@@ -1879,7 +1879,7 @@ static int mtk_xdp_submit_frame(struct mtk_eth *eth, struct xdp_frame *xdpf,
 	} else {
 		int idx;
 
-		idx = txd_to_idx(ring, txd, soc->txrx.txd_size);
+		idx = txd_to_idx(ring, txd, soc->tx.desc_size);
 		mtk_w32(eth, NEXT_DESP_IDX(idx, ring->dma_size),
 			MT7628_TX_CTX_IDX0);
 	}
@@ -1890,7 +1890,7 @@ static int mtk_xdp_submit_frame(struct mtk_eth *eth, struct xdp_frame *xdpf,
 
 unmap:
 	while (htxd != txd) {
-		tx_buf = mtk_desc_to_tx_buf(ring, htxd, soc->txrx.txd_size);
+		tx_buf = mtk_desc_to_tx_buf(ring, htxd, soc->tx.desc_size);
 		mtk_tx_unmap(eth, tx_buf, NULL, false);
 
 		htxd->txd3 = TX_DMA_LS0 | TX_DMA_OWNER_CPU;
@@ -2021,7 +2021,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 			goto rx_done;
 
 		idx = NEXT_DESP_IDX(ring->calc_idx, ring->dma_size);
-		rxd = ring->dma + idx * eth->soc->txrx.rxd_size;
+		rxd = ring->dma + idx * eth->soc->rx.desc_size;
 		data = ring->data[idx];
 
 		if (!mtk_rx_get_desc(eth, &trxd, rxd))
@@ -2156,7 +2156,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 			rxdcsum = &trxd.rxd4;
 		}
 
-		if (*rxdcsum & eth->soc->txrx.rx_dma_l4_valid)
+		if (*rxdcsum & eth->soc->rx.dma_l4_valid)
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
 		else
 			skb_checksum_none_assert(skb);
@@ -2280,7 +2280,7 @@ static int mtk_poll_tx_qdma(struct mtk_eth *eth, int budget,
 			break;
 
 		tx_buf = mtk_desc_to_tx_buf(ring, desc,
-					    eth->soc->txrx.txd_size);
+					    eth->soc->tx.desc_size);
 		if (!tx_buf->data)
 			break;
 
@@ -2331,7 +2331,7 @@ static int mtk_poll_tx_pdma(struct mtk_eth *eth, int budget,
 		}
 		mtk_tx_unmap(eth, tx_buf, &bq, true);
 
-		desc = ring->dma + cpu * eth->soc->txrx.txd_size;
+		desc = ring->dma + cpu * eth->soc->tx.desc_size;
 		ring->last_free = desc;
 		atomic_inc(&ring->free_count);
 
@@ -2421,7 +2421,7 @@ static int mtk_napi_rx(struct napi_struct *napi, int budget)
 	do {
 		int rx_done;
 
-		mtk_w32(eth, eth->soc->txrx.rx_irq_done_mask,
+		mtk_w32(eth, eth->soc->rx.irq_done_mask,
 			reg_map->pdma.irq_status);
 		rx_done = mtk_poll_rx(napi, budget - rx_done_total, eth);
 		rx_done_total += rx_done;
@@ -2437,10 +2437,10 @@ static int mtk_napi_rx(struct napi_struct *napi, int budget)
 			return budget;
 
 	} while (mtk_r32(eth, reg_map->pdma.irq_status) &
-		 eth->soc->txrx.rx_irq_done_mask);
+		 eth->soc->rx.irq_done_mask);
 
 	if (napi_complete_done(napi, rx_done_total))
-		mtk_rx_irq_enable(eth, eth->soc->txrx.rx_irq_done_mask);
+		mtk_rx_irq_enable(eth, eth->soc->rx.irq_done_mask);
 
 	return rx_done_total;
 }
@@ -2449,7 +2449,7 @@ static int mtk_tx_alloc(struct mtk_eth *eth)
 {
 	const struct mtk_soc_data *soc = eth->soc;
 	struct mtk_tx_ring *ring = &eth->tx_ring;
-	int i, sz = soc->txrx.txd_size;
+	int i, sz = soc->tx.desc_size;
 	struct mtk_tx_dma_v2 *txd;
 	int ring_size;
 	u32 ofs, val;
@@ -2572,14 +2572,14 @@ static void mtk_tx_clean(struct mtk_eth *eth)
 	}
 	if (!MTK_HAS_CAPS(soc->caps, MTK_SRAM) && ring->dma) {
 		dma_free_coherent(eth->dma_dev,
-				  ring->dma_size * soc->txrx.txd_size,
+				  ring->dma_size * soc->tx.desc_size,
 				  ring->dma, ring->phys);
 		ring->dma = NULL;
 	}
 
 	if (ring->dma_pdma) {
 		dma_free_coherent(eth->dma_dev,
-				  ring->dma_size * soc->txrx.txd_size,
+				  ring->dma_size * soc->tx.desc_size,
 				  ring->dma_pdma, ring->phys_pdma);
 		ring->dma_pdma = NULL;
 	}
@@ -2634,15 +2634,15 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 	if (!MTK_HAS_CAPS(eth->soc->caps, MTK_SRAM) ||
 	    rx_flag != MTK_RX_FLAGS_NORMAL) {
 		ring->dma = dma_alloc_coherent(eth->dma_dev,
-					       rx_dma_size * eth->soc->txrx.rxd_size,
-					       &ring->phys, GFP_KERNEL);
+				rx_dma_size * eth->soc->rx.desc_size,
+				&ring->phys, GFP_KERNEL);
 	} else {
 		struct mtk_tx_ring *tx_ring = &eth->tx_ring;
 
 		ring->dma = tx_ring->dma + tx_ring_size *
-			    eth->soc->txrx.txd_size * (ring_no + 1);
+			    eth->soc->tx.desc_size * (ring_no + 1);
 		ring->phys = tx_ring->phys + tx_ring_size *
-			     eth->soc->txrx.txd_size * (ring_no + 1);
+			     eth->soc->tx.desc_size * (ring_no + 1);
 	}
 
 	if (!ring->dma)
@@ -2653,7 +2653,7 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 		dma_addr_t dma_addr;
 		void *data;
 
-		rxd = ring->dma + i * eth->soc->txrx.rxd_size;
+		rxd = ring->dma + i * eth->soc->rx.desc_size;
 		if (ring->page_pool) {
 			data = mtk_page_pool_get_buff(ring->page_pool,
 						      &dma_addr, GFP_KERNEL);
@@ -2744,7 +2744,7 @@ static void mtk_rx_clean(struct mtk_eth *eth, struct mtk_rx_ring *ring, bool in_
 			if (!ring->data[i])
 				continue;
 
-			rxd = ring->dma + i * eth->soc->txrx.rxd_size;
+			rxd = ring->dma + i * eth->soc->rx.desc_size;
 			if (!rxd->rxd1)
 				continue;
 
@@ -2761,7 +2761,7 @@ static void mtk_rx_clean(struct mtk_eth *eth, struct mtk_rx_ring *ring, bool in_
 
 	if (!in_sram && ring->dma) {
 		dma_free_coherent(eth->dma_dev,
-				  ring->dma_size * eth->soc->txrx.rxd_size,
+				  ring->dma_size * eth->soc->rx.desc_size,
 				  ring->dma, ring->phys);
 		ring->dma = NULL;
 	}
@@ -3124,7 +3124,7 @@ static void mtk_dma_free(struct mtk_eth *eth)
 			netdev_reset_queue(eth->netdev[i]);
 	if (!MTK_HAS_CAPS(soc->caps, MTK_SRAM) && eth->scratch_ring) {
 		dma_free_coherent(eth->dma_dev,
-				  MTK_QDMA_RING_SIZE * soc->txrx.txd_size,
+				  MTK_QDMA_RING_SIZE * soc->tx.desc_size,
 				  eth->scratch_ring, eth->phy_scratch_ring);
 		eth->scratch_ring = NULL;
 		eth->phy_scratch_ring = 0;
@@ -3174,7 +3174,7 @@ static irqreturn_t mtk_handle_irq_rx(int irq, void *_eth)
 
 	eth->rx_events++;
 	if (likely(napi_schedule_prep(&eth->rx_napi))) {
-		mtk_rx_irq_disable(eth, eth->soc->txrx.rx_irq_done_mask);
+		mtk_rx_irq_disable(eth, eth->soc->rx.irq_done_mask);
 		__napi_schedule(&eth->rx_napi);
 	}
 
@@ -3200,9 +3200,9 @@ static irqreturn_t mtk_handle_irq(int irq, void *_eth)
 	const struct mtk_reg_map *reg_map = eth->soc->reg_map;
 
 	if (mtk_r32(eth, reg_map->pdma.irq_mask) &
-	    eth->soc->txrx.rx_irq_done_mask) {
+	    eth->soc->rx.irq_done_mask) {
 		if (mtk_r32(eth, reg_map->pdma.irq_status) &
-		    eth->soc->txrx.rx_irq_done_mask)
+		    eth->soc->rx.irq_done_mask)
 			mtk_handle_irq_rx(irq, _eth);
 	}
 	if (mtk_r32(eth, reg_map->tx_irq_mask) & MTK_TX_DONE_INT) {
@@ -3220,10 +3220,10 @@ static void mtk_poll_controller(struct net_device *dev)
 	struct mtk_eth *eth = mac->hw;
 
 	mtk_tx_irq_disable(eth, MTK_TX_DONE_INT);
-	mtk_rx_irq_disable(eth, eth->soc->txrx.rx_irq_done_mask);
+	mtk_rx_irq_disable(eth, eth->soc->rx.irq_done_mask);
 	mtk_handle_irq_rx(eth->irq[2], dev);
 	mtk_tx_irq_enable(eth, MTK_TX_DONE_INT);
-	mtk_rx_irq_enable(eth, eth->soc->txrx.rx_irq_done_mask);
+	mtk_rx_irq_enable(eth, eth->soc->rx.irq_done_mask);
 }
 #endif
 
@@ -3387,7 +3387,7 @@ static int mtk_open(struct net_device *dev)
 		napi_enable(&eth->tx_napi);
 		napi_enable(&eth->rx_napi);
 		mtk_tx_irq_enable(eth, MTK_TX_DONE_INT);
-		mtk_rx_irq_enable(eth, soc->txrx.rx_irq_done_mask);
+		mtk_rx_irq_enable(eth, soc->rx.irq_done_mask);
 		refcount_set(&eth->dma_refcnt, 1);
 	}
 	else
@@ -3471,7 +3471,7 @@ static int mtk_stop(struct net_device *dev)
 	mtk_gdm_config(eth, MTK_GDMA_DROP_ALL);
 
 	mtk_tx_irq_disable(eth, MTK_TX_DONE_INT);
-	mtk_rx_irq_disable(eth, eth->soc->txrx.rx_irq_done_mask);
+	mtk_rx_irq_disable(eth, eth->soc->rx.irq_done_mask);
 	napi_disable(&eth->tx_napi);
 	napi_disable(&eth->rx_napi);
 
@@ -3947,9 +3947,9 @@ static int mtk_hw_init(struct mtk_eth *eth, bool reset)
 
 	/* FE int grouping */
 	mtk_w32(eth, MTK_TX_DONE_INT, reg_map->pdma.int_grp);
-	mtk_w32(eth, eth->soc->txrx.rx_irq_done_mask, reg_map->pdma.int_grp + 4);
+	mtk_w32(eth, eth->soc->rx.irq_done_mask, reg_map->pdma.int_grp + 4);
 	mtk_w32(eth, MTK_TX_DONE_INT, reg_map->qdma.int_grp);
-	mtk_w32(eth, eth->soc->txrx.rx_irq_done_mask, reg_map->qdma.int_grp + 4);
+	mtk_w32(eth, eth->soc->rx.irq_done_mask, reg_map->qdma.int_grp + 4);
 	mtk_w32(eth, 0x21021000, MTK_FE_INT_GRP);
 
 	if (mtk_is_netsys_v3_or_greater(eth)) {
@@ -5039,11 +5039,15 @@ static const struct mtk_soc_data mt2701_data = {
 	.required_clks = MT7623_CLKS_BITMAP,
 	.required_pctl = true,
 	.version = 1,
-	.txrx = {
-		.txd_size = sizeof(struct mtk_tx_dma),
-		.rxd_size = sizeof(struct mtk_rx_dma),
-		.rx_irq_done_mask = MTK_RX_DONE_INT,
-		.rx_dma_l4_valid = RX_DMA_L4_VALID,
+	.tx = {
+		.desc_size = sizeof(struct mtk_tx_dma),
+		.dma_max_len = MTK_TX_DMA_BUF_LEN,
+		.dma_len_offset = 16,
+	},
+	.rx = {
+		.desc_size = sizeof(struct mtk_rx_dma),
+		.irq_done_mask = MTK_RX_DONE_INT,
+		.dma_l4_valid = RX_DMA_L4_VALID,
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
 	},
@@ -5059,11 +5063,15 @@ static const struct mtk_soc_data mt7621_data = {
 	.offload_version = 1,
 	.hash_offset = 2,
 	.foe_entry_size = MTK_FOE_ENTRY_V1_SIZE,
-	.txrx = {
-		.txd_size = sizeof(struct mtk_tx_dma),
-		.rxd_size = sizeof(struct mtk_rx_dma),
-		.rx_irq_done_mask = MTK_RX_DONE_INT,
-		.rx_dma_l4_valid = RX_DMA_L4_VALID,
+	.tx = {
+		.desc_size = sizeof(struct mtk_tx_dma),
+		.dma_max_len = MTK_TX_DMA_BUF_LEN,
+		.dma_len_offset = 16,
+	},
+	.rx = {
+		.desc_size = sizeof(struct mtk_rx_dma),
+		.irq_done_mask = MTK_RX_DONE_INT,
+		.dma_l4_valid = RX_DMA_L4_VALID,
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
 	},
@@ -5081,11 +5089,15 @@ static const struct mtk_soc_data mt7622_data = {
 	.hash_offset = 2,
 	.has_accounting = true,
 	.foe_entry_size = MTK_FOE_ENTRY_V1_SIZE,
-	.txrx = {
-		.txd_size = sizeof(struct mtk_tx_dma),
-		.rxd_size = sizeof(struct mtk_rx_dma),
-		.rx_irq_done_mask = MTK_RX_DONE_INT,
-		.rx_dma_l4_valid = RX_DMA_L4_VALID,
+	.tx = {
+		.desc_size = sizeof(struct mtk_tx_dma),
+		.dma_max_len = MTK_TX_DMA_BUF_LEN,
+		.dma_len_offset = 16,
+	},
+	.rx = {
+		.desc_size = sizeof(struct mtk_rx_dma),
+		.irq_done_mask = MTK_RX_DONE_INT,
+		.dma_l4_valid = RX_DMA_L4_VALID,
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
 	},
@@ -5102,11 +5114,15 @@ static const struct mtk_soc_data mt7623_data = {
 	.hash_offset = 2,
 	.foe_entry_size = MTK_FOE_ENTRY_V1_SIZE,
 	.disable_pll_modes = true,
-	.txrx = {
-		.txd_size = sizeof(struct mtk_tx_dma),
-		.rxd_size = sizeof(struct mtk_rx_dma),
-		.rx_irq_done_mask = MTK_RX_DONE_INT,
-		.rx_dma_l4_valid = RX_DMA_L4_VALID,
+	.tx = {
+		.desc_size = sizeof(struct mtk_tx_dma),
+		.dma_max_len = MTK_TX_DMA_BUF_LEN,
+		.dma_len_offset = 16,
+	},
+	.rx = {
+		.desc_size = sizeof(struct mtk_rx_dma),
+		.irq_done_mask = MTK_RX_DONE_INT,
+		.dma_l4_valid = RX_DMA_L4_VALID,
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
 	},
@@ -5121,11 +5137,15 @@ static const struct mtk_soc_data mt7629_data = {
 	.required_pctl = false,
 	.has_accounting = true,
 	.version = 1,
-	.txrx = {
-		.txd_size = sizeof(struct mtk_tx_dma),
-		.rxd_size = sizeof(struct mtk_rx_dma),
-		.rx_irq_done_mask = MTK_RX_DONE_INT,
-		.rx_dma_l4_valid = RX_DMA_L4_VALID,
+	.tx = {
+		.desc_size = sizeof(struct mtk_tx_dma),
+		.dma_max_len = MTK_TX_DMA_BUF_LEN,
+		.dma_len_offset = 16,
+	},
+	.rx = {
+		.desc_size = sizeof(struct mtk_rx_dma),
+		.irq_done_mask = MTK_RX_DONE_INT,
+		.dma_l4_valid = RX_DMA_L4_VALID,
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
 	},
@@ -5143,11 +5163,15 @@ static const struct mtk_soc_data mt7981_data = {
 	.hash_offset = 4,
 	.has_accounting = true,
 	.foe_entry_size = MTK_FOE_ENTRY_V2_SIZE,
-	.txrx = {
-		.txd_size = sizeof(struct mtk_tx_dma_v2),
-		.rxd_size = sizeof(struct mtk_rx_dma_v2),
-		.rx_irq_done_mask = MTK_RX_DONE_INT_V2,
-		.rx_dma_l4_valid = RX_DMA_L4_VALID_V2,
+	.tx = {
+		.desc_size = sizeof(struct mtk_tx_dma_v2),
+		.dma_max_len = MTK_TX_DMA_BUF_LEN_V2,
+		.dma_len_offset = 8,
+	},
+	.rx = {
+		.desc_size = sizeof(struct mtk_rx_dma_v2),
+		.irq_done_mask = MTK_RX_DONE_INT_V2,
+		.dma_l4_valid = RX_DMA_L4_VALID_V2,
 		.dma_max_len = MTK_TX_DMA_BUF_LEN_V2,
 		.dma_len_offset = 8,
 	},
@@ -5165,11 +5189,15 @@ static const struct mtk_soc_data mt7986_data = {
 	.hash_offset = 4,
 	.has_accounting = true,
 	.foe_entry_size = MTK_FOE_ENTRY_V2_SIZE,
-	.txrx = {
-		.txd_size = sizeof(struct mtk_tx_dma_v2),
-		.rxd_size = sizeof(struct mtk_rx_dma_v2),
-		.rx_irq_done_mask = MTK_RX_DONE_INT_V2,
-		.rx_dma_l4_valid = RX_DMA_L4_VALID_V2,
+	.tx = {
+		.desc_size = sizeof(struct mtk_tx_dma_v2),
+		.dma_max_len = MTK_TX_DMA_BUF_LEN_V2,
+		.dma_len_offset = 8,
+	},
+	.rx = {
+		.desc_size = sizeof(struct mtk_rx_dma_v2),
+		.irq_done_mask = MTK_RX_DONE_INT_V2,
+		.dma_l4_valid = RX_DMA_L4_VALID_V2,
 		.dma_max_len = MTK_TX_DMA_BUF_LEN_V2,
 		.dma_len_offset = 8,
 	},
@@ -5187,11 +5215,15 @@ static const struct mtk_soc_data mt7988_data = {
 	.hash_offset = 4,
 	.has_accounting = true,
 	.foe_entry_size = MTK_FOE_ENTRY_V3_SIZE,
-	.txrx = {
-		.txd_size = sizeof(struct mtk_tx_dma_v2),
-		.rxd_size = sizeof(struct mtk_rx_dma_v2),
-		.rx_irq_done_mask = MTK_RX_DONE_INT_V2,
-		.rx_dma_l4_valid = RX_DMA_L4_VALID_V2,
+	.tx = {
+		.desc_size = sizeof(struct mtk_tx_dma_v2),
+		.dma_max_len = MTK_TX_DMA_BUF_LEN_V2,
+		.dma_len_offset = 8,
+	},
+	.rx = {
+		.desc_size = sizeof(struct mtk_rx_dma_v2),
+		.irq_done_mask = MTK_RX_DONE_INT_V2,
+		.dma_l4_valid = RX_DMA_L4_VALID_V2,
 		.dma_max_len = MTK_TX_DMA_BUF_LEN_V2,
 		.dma_len_offset = 8,
 	},
@@ -5204,11 +5236,15 @@ static const struct mtk_soc_data rt5350_data = {
 	.required_clks = MT7628_CLKS_BITMAP,
 	.required_pctl = false,
 	.version = 1,
-	.txrx = {
-		.txd_size = sizeof(struct mtk_tx_dma),
-		.rxd_size = sizeof(struct mtk_rx_dma),
-		.rx_irq_done_mask = MTK_RX_DONE_INT,
-		.rx_dma_l4_valid = RX_DMA_L4_VALID_PDMA,
+	.tx = {
+		.desc_size = sizeof(struct mtk_tx_dma),
+		.dma_max_len = MTK_TX_DMA_BUF_LEN,
+		.dma_len_offset = 16,
+	},
+	.rx = {
+		.desc_size = sizeof(struct mtk_rx_dma),
+		.irq_done_mask = MTK_RX_DONE_INT,
+		.dma_l4_valid = RX_DMA_L4_VALID_PDMA,
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
 	},
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 9ae3b8a71d0e..39b50de1decb 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -327,8 +327,8 @@
 /* QDMA descriptor txd3 */
 #define TX_DMA_OWNER_CPU	BIT(31)
 #define TX_DMA_LS0		BIT(30)
-#define TX_DMA_PLEN0(x)		(((x) & eth->soc->txrx.dma_max_len) << eth->soc->txrx.dma_len_offset)
-#define TX_DMA_PLEN1(x)		((x) & eth->soc->txrx.dma_max_len)
+#define TX_DMA_PLEN0(x)		(((x) & eth->soc->tx.dma_max_len) << eth->soc->tx.dma_len_offset)
+#define TX_DMA_PLEN1(x)		((x) & eth->soc->tx.dma_max_len)
 #define TX_DMA_SWC		BIT(14)
 #define TX_DMA_PQID		GENMASK(3, 0)
 #define TX_DMA_ADDR64_MASK	GENMASK(3, 0)
@@ -348,8 +348,8 @@
 /* QDMA descriptor rxd2 */
 #define RX_DMA_DONE		BIT(31)
 #define RX_DMA_LSO		BIT(30)
-#define RX_DMA_PREP_PLEN0(x)	(((x) & eth->soc->txrx.dma_max_len) << eth->soc->txrx.dma_len_offset)
-#define RX_DMA_GET_PLEN0(x)	(((x) >> eth->soc->txrx.dma_len_offset) & eth->soc->txrx.dma_max_len)
+#define RX_DMA_PREP_PLEN0(x)	(((x) & eth->soc->rx.dma_max_len) << eth->soc->rx.dma_len_offset)
+#define RX_DMA_GET_PLEN0(x)	(((x) >> eth->soc->rx.dma_len_offset) & eth->soc->rx.dma_max_len)
 #define RX_DMA_VTAG		BIT(15)
 #define RX_DMA_ADDR64_MASK	GENMASK(3, 0)
 #if IS_ENABLED(CONFIG_64BIT)
@@ -1153,10 +1153,9 @@ struct mtk_reg_map {
  * @foe_entry_size		Foe table entry size.
  * @has_accounting		Bool indicating support for accounting of
  *				offloaded flows.
- * @txd_size			Tx DMA descriptor size.
- * @rxd_size			Rx DMA descriptor size.
- * @rx_irq_done_mask		Rx irq done register mask.
- * @rx_dma_l4_valid		Rx DMA valid register mask.
+ * @desc_size			Tx/Rx DMA descriptor size.
+ * @irq_done_mask		Rx irq done register mask.
+ * @dma_l4_valid		Rx DMA valid register mask.
  * @dma_max_len			Max DMA tx/rx buffer length.
  * @dma_len_offset		Tx/Rx DMA length field offset.
  */
@@ -1174,13 +1173,17 @@ struct mtk_soc_data {
 	bool		has_accounting;
 	bool		disable_pll_modes;
 	struct {
-		u32	txd_size;
-		u32	rxd_size;
-		u32	rx_irq_done_mask;
-		u32	rx_dma_l4_valid;
+		u32	desc_size;
 		u32	dma_max_len;
 		u32	dma_len_offset;
-	} txrx;
+	} tx;
+	struct {
+		u32	desc_size;
+		u32	irq_done_mask;
+		u32	dma_l4_valid;
+		u32	dma_max_len;
+		u32	dma_len_offset;
+	} rx;
 };
 
 #define MTK_DMA_MONITOR_TIMEOUT		msecs_to_jiffies(1000)
-- 
2.45.0

From 9a694114ffbbf5f03384b0cbf0c27b9528c94576 Mon Sep 17 00:00:00 2001
Message-ID: <9a694114ffbbf5f03384b0cbf0c27b9528c94576.1715084578.git.daniel@makrotopia.org>
In-Reply-To: <6747c038f4fc3b490e1b7a355cdaaf361e359def.1715084578.git.daniel@makrotopia.org>
References: <6747c038f4fc3b490e1b7a355cdaaf361e359def.1715084578.git.daniel@makrotopia.org>
From: Daniel Golle <daniel@makrotopia.org>
Date: Fri, 3 May 2024 01:32:42 +0100
Subject: [PATCH net v2 2/2] net: ethernet: mediatek: use ADMAv1 instead of ADMAv2.0 on
 MT7981 and MT7986
To: Felix Fietkau <nbd@nbd.name>,
    Sean Wang <sean.wang@mediatek.com>,
    Mark Lee <Mark-MC.Lee@mediatek.com>,
    Lorenzo Bianconi <lorenzo@kernel.org>,
    David S. Miller <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>,
    Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    Matthias Brugger <matthias.bgg@gmail.com>,
    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
    netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    linux-arm-kernel@lists.infradead.org,
    linux-mediatek@lists.infradead.org

ADMAv2.0 is plagued by RX hangs which can't easily detected and happen upon
receival of a corrupted Ethernet frame.

Use ADMAv1 instead which is also still present and usable, and doesn't
suffer from that problem.

Fixes: 197c9e9b17b1 ("net: ethernet: mtk_eth_soc: introduce support for mt7986 chipset")
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: improve commit message
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 46 ++++++++++-----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 3eefb735ce19..d7d73295f0dc 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -110,16 +110,16 @@ static const struct mtk_reg_map mt7986_reg_map = {
 	.tx_irq_mask		= 0x461c,
 	.tx_irq_status		= 0x4618,
 	.pdma = {
-		.rx_ptr		= 0x6100,
-		.rx_cnt_cfg	= 0x6104,
-		.pcrx_ptr	= 0x6108,
-		.glo_cfg	= 0x6204,
-		.rst_idx	= 0x6208,
-		.delay_irq	= 0x620c,
-		.irq_status	= 0x6220,
-		.irq_mask	= 0x6228,
-		.adma_rx_dbg0	= 0x6238,
-		.int_grp	= 0x6250,
+		.rx_ptr		= 0x4100,
+		.rx_cnt_cfg	= 0x4104,
+		.pcrx_ptr	= 0x4108,
+		.glo_cfg	= 0x4204,
+		.rst_idx	= 0x4208,
+		.delay_irq	= 0x420c,
+		.irq_status	= 0x4220,
+		.irq_mask	= 0x4228,
+		.adma_rx_dbg0	= 0x4238,
+		.int_grp	= 0x4250,
 	},
 	.qdma = {
 		.qtx_cfg	= 0x4400,
@@ -1107,7 +1107,7 @@ static bool mtk_rx_get_desc(struct mtk_eth *eth, struct mtk_rx_dma_v2 *rxd,
 	rxd->rxd1 = READ_ONCE(dma_rxd->rxd1);
 	rxd->rxd3 = READ_ONCE(dma_rxd->rxd3);
 	rxd->rxd4 = READ_ONCE(dma_rxd->rxd4);
-	if (mtk_is_netsys_v2_or_greater(eth)) {
+	if (mtk_is_netsys_v3_or_greater(eth)) {
 		rxd->rxd5 = READ_ONCE(dma_rxd->rxd5);
 		rxd->rxd6 = READ_ONCE(dma_rxd->rxd6);
 	}
@@ -2028,7 +2028,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 			break;
 
 		/* find out which mac the packet come from. values start at 1 */
-		if (mtk_is_netsys_v2_or_greater(eth)) {
+		if (mtk_is_netsys_v3_or_greater(eth)) {
 			u32 val = RX_DMA_GET_SPORT_V2(trxd.rxd5);
 
 			switch (val) {
@@ -2140,7 +2140,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 		skb->dev = netdev;
 		bytes += skb->len;
 
-		if (mtk_is_netsys_v2_or_greater(eth)) {
+		if (mtk_is_netsys_v3_or_greater(eth)) {
 			reason = FIELD_GET(MTK_RXD5_PPE_CPU_REASON, trxd.rxd5);
 			hash = trxd.rxd5 & MTK_RXD5_FOE_ENTRY;
 			if (hash != MTK_RXD5_FOE_ENTRY)
@@ -2690,7 +2690,7 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 
 		rxd->rxd3 = 0;
 		rxd->rxd4 = 0;
-		if (mtk_is_netsys_v2_or_greater(eth)) {
+		if (mtk_is_netsys_v3_or_greater(eth)) {
 			rxd->rxd5 = 0;
 			rxd->rxd6 = 0;
 			rxd->rxd7 = 0;
@@ -3893,7 +3893,7 @@ static int mtk_hw_init(struct mtk_eth *eth, bool reset)
 	else
 		mtk_hw_reset(eth);
 
-	if (mtk_is_netsys_v2_or_greater(eth)) {
+	if (mtk_is_netsys_v3_or_greater(eth)) {
 		/* Set FE to PDMAv2 if necessary */
 		val = mtk_r32(eth, MTK_FE_GLO_MISC);
 		mtk_w32(eth,  val | BIT(4), MTK_FE_GLO_MISC);
@@ -5169,11 +5169,11 @@ static const struct mtk_soc_data mt7981_data = {
 		.dma_len_offset = 8,
 	},
 	.rx = {
-		.desc_size = sizeof(struct mtk_rx_dma_v2),
-		.irq_done_mask = MTK_RX_DONE_INT_V2,
+		.desc_size = sizeof(struct mtk_rx_dma),
+		.irq_done_mask = MTK_RX_DONE_INT,
 		.dma_l4_valid = RX_DMA_L4_VALID_V2,
-		.dma_max_len = MTK_TX_DMA_BUF_LEN_V2,
-		.dma_len_offset = 8,
+		.dma_max_len = MTK_TX_DMA_BUF_LEN,
+		.dma_len_offset = 16,
 	},
 };
 
@@ -5195,11 +5195,11 @@ static const struct mtk_soc_data mt7986_data = {
 		.dma_len_offset = 8,
 	},
 	.rx = {
-		.desc_size = sizeof(struct mtk_rx_dma_v2),
-		.irq_done_mask = MTK_RX_DONE_INT_V2,
+		.desc_size = sizeof(struct mtk_rx_dma),
+		.irq_done_mask = MTK_RX_DONE_INT,
 		.dma_l4_valid = RX_DMA_L4_VALID_V2,
-		.dma_max_len = MTK_TX_DMA_BUF_LEN_V2,
-		.dma_len_offset = 8,
+		.dma_max_len = MTK_TX_DMA_BUF_LEN,
+		.dma_len_offset = 16,
 	},
 };
 
-- 
2.45.0


