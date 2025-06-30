Return-Path: <netdev+bounces-202685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19744AEE996
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 23:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F418017C733
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 21:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2025B1FFC55;
	Mon, 30 Jun 2025 21:47:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4D922FF2D;
	Mon, 30 Jun 2025 21:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751320032; cv=none; b=FUouaNsun5AjYZmX7ZkZfxYPX7/ISk7NBclm6/WJsNcfrF+AqIV9IGhYzCEK1AKgXGgN5uMpLVvrKNkApHpRaZ6CJgAdjp5M/PmoP1rpFYlhtqfJH9P//HbqPKvJRbtHw5vYB5JUm9JYhpv4TDREHH9kocdgtHB0fu2sCnTtNhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751320032; c=relaxed/simple;
	bh=AURy5RoiCD0K69XxdYzpmhF+JbiihjsvLp8AKCK0RDE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esQ6ZiPx3oQTPzAw3MqIs0EOTPGveTQfxv/A/eST5vTSXf8yk1btGCmyRs/3Pg8XERLQ+d5XliTrqoGte1pcq9dzYS8oSYM0y5hQwzW5eZIMbZ5cazEKKkC9jN/3e6CJ3pB98be3duKB/a+0wtb3dmlO4eUBuLXbskAuBl1P6pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uWMLB-000000007Mt-1ikl;
	Mon, 30 Jun 2025 21:47:05 +0000
Date: Mon, 30 Jun 2025 22:47:02 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Felix Fietkau <nbd@nbd.name>,
	Frank Wunderlich <frank-w@public-files.de>,
	Eric Woudstra <ericwouds@gmail.com>, Elad Yifee <eladwf@gmail.com>,
	Bo-Cun Chen <bc-bocun.chen@mediatek.com>,
	Sky Huang <skylake.huang@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v3 3/3] net: ethernet: mtk_eth_soc: use genpool
 allocator for SRAM
Message-ID: <ec99dca250c0805a2307b0aaa9cf30b29ee2a989.1751319620.git.daniel@makrotopia.org>
References: <cover.1751319620.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751319620.git.daniel@makrotopia.org>

Use a dedicated "mmio-sram" and the genpool allocator instead of
open-coding SRAM allocation for DMA rings.
Keep support for legacy device trees but notify the user via a
warning to update.

Co-developed-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3: fix resource leak on error in mtk_probe()
v2: fix return type of mtk_dma_ring_alloc() in case of error

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 117 +++++++++++++-------
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |   4 +-
 2 files changed, 83 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 8f55069441f4..29b95d96f3d4 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -27,6 +27,7 @@
 #include <net/dsa.h>
 #include <net/dst_metadata.h>
 #include <net/page_pool/helpers.h>
+#include <linux/genalloc.h>
 
 #include "mtk_eth_soc.h"
 #include "mtk_wed.h"
@@ -1267,6 +1268,45 @@ static void *mtk_max_lro_buf_alloc(gfp_t gfp_mask)
 	return (void *)data;
 }
 
+static bool mtk_use_legacy_sram(struct mtk_eth *eth)
+{
+	return !eth->sram_pool && MTK_HAS_CAPS(eth->soc->caps, MTK_SRAM);
+}
+
+static void *mtk_dma_ring_alloc(struct mtk_eth *eth, size_t size,
+				dma_addr_t *dma_handle)
+{
+	void *dma_ring;
+
+	if (WARN_ON(mtk_use_legacy_sram(eth)))
+		return NULL;
+
+	if (eth->sram_pool) {
+		dma_ring = (void *)gen_pool_alloc(eth->sram_pool, size);
+		if (!dma_ring)
+			return dma_ring;
+		*dma_handle = gen_pool_virt_to_phys(eth->sram_pool,
+						    (unsigned long)dma_ring);
+	} else {
+		dma_ring = dma_alloc_coherent(eth->dma_dev, size, dma_handle,
+					      GFP_KERNEL);
+	}
+
+	return dma_ring;
+}
+
+static void mtk_dma_ring_free(struct mtk_eth *eth, size_t size, void *dma_ring,
+			      dma_addr_t dma_handle)
+{
+	if (WARN_ON(mtk_use_legacy_sram(eth)))
+		return;
+
+	if (eth->sram_pool)
+		gen_pool_free(eth->sram_pool, (unsigned long)dma_ring, size);
+	else
+		dma_free_coherent(eth->dma_dev, size, dma_ring, dma_handle);
+}
+
 /* the qdma core needs scratch memory to be setup */
 static int mtk_init_fq_dma(struct mtk_eth *eth)
 {
@@ -1276,13 +1316,12 @@ static int mtk_init_fq_dma(struct mtk_eth *eth)
 	dma_addr_t dma_addr;
 	int i, j, len;
 
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SRAM))
+	if (!mtk_use_legacy_sram(eth)) {
+		eth->scratch_ring = mtk_dma_ring_alloc(eth, cnt * soc->tx.desc_size,
+						       &eth->phy_scratch_ring);
+	} else {
 		eth->scratch_ring = eth->sram_base;
-	else
-		eth->scratch_ring = dma_alloc_coherent(eth->dma_dev,
-						       cnt * soc->tx.desc_size,
-						       &eth->phy_scratch_ring,
-						       GFP_KERNEL);
+	}
 
 	if (unlikely(!eth->scratch_ring))
 		return -ENOMEM;
@@ -2620,12 +2659,11 @@ static int mtk_tx_alloc(struct mtk_eth *eth)
 	if (!ring->buf)
 		goto no_tx_mem;
 
-	if (MTK_HAS_CAPS(soc->caps, MTK_SRAM)) {
+	if (!mtk_use_legacy_sram(eth)) {
+		ring->dma = mtk_dma_ring_alloc(eth, ring_size * sz, &ring->phys);
+	} else {
 		ring->dma = eth->sram_base + soc->tx.fq_dma_size * sz;
 		ring->phys = eth->phy_scratch_ring + soc->tx.fq_dma_size * (dma_addr_t)sz;
-	} else {
-		ring->dma = dma_alloc_coherent(eth->dma_dev, ring_size * sz,
-					       &ring->phys, GFP_KERNEL);
 	}
 
 	if (!ring->dma)
@@ -2726,9 +2764,9 @@ static void mtk_tx_clean(struct mtk_eth *eth)
 		kfree(ring->buf);
 		ring->buf = NULL;
 	}
-	if (!MTK_HAS_CAPS(soc->caps, MTK_SRAM) && ring->dma) {
-		dma_free_coherent(eth->dma_dev,
-				  ring->dma_size * soc->tx.desc_size,
+
+	if (!mtk_use_legacy_sram(eth) && ring->dma) {
+		mtk_dma_ring_free(eth, ring->dma_size * soc->tx.desc_size,
 				  ring->dma, ring->phys);
 		ring->dma = NULL;
 	}
@@ -2793,6 +2831,9 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 		ring->dma = dma_alloc_coherent(eth->dma_dev,
 				rx_dma_size * eth->soc->rx.desc_size,
 				&ring->phys, GFP_KERNEL);
+	} else if (eth->sram_pool) {
+		ring->dma = mtk_dma_ring_alloc(eth, rx_dma_size * eth->soc->rx.desc_size,
+					       &ring->phys);
 	} else {
 		struct mtk_tx_ring *tx_ring = &eth->tx_ring;
 
@@ -2921,6 +2962,11 @@ static void mtk_rx_clean(struct mtk_eth *eth, struct mtk_rx_ring *ring, bool in_
 				  ring->dma_size * eth->soc->rx.desc_size,
 				  ring->dma, ring->phys);
 		ring->dma = NULL;
+	} else if (!mtk_use_legacy_sram(eth) && ring->dma) {
+		mtk_dma_ring_free(eth,
+				  ring->dma_size * eth->soc->rx.desc_size,
+				  ring->dma, ring->phys);
+		ring->dma = NULL;
 	}
 
 	if (ring->page_pool) {
@@ -3287,9 +3333,8 @@ static void mtk_dma_free(struct mtk_eth *eth)
 			netdev_tx_reset_subqueue(eth->netdev[i], j);
 	}
 
-	if (!MTK_HAS_CAPS(soc->caps, MTK_SRAM) && eth->scratch_ring) {
-		dma_free_coherent(eth->dma_dev,
-				  MTK_QDMA_RING_SIZE * soc->tx.desc_size,
+	if (!mtk_use_legacy_sram(eth) && eth->scratch_ring) {
+		mtk_dma_ring_free(eth, soc->tx.fq_dma_size * soc->tx.desc_size,
 				  eth->scratch_ring, eth->phy_scratch_ring);
 		eth->scratch_ring = NULL;
 		eth->phy_scratch_ring = 0;
@@ -5009,7 +5054,7 @@ static int mtk_sgmii_init(struct mtk_eth *eth)
 
 static int mtk_probe(struct platform_device *pdev)
 {
-	struct resource *res = NULL, *res_sram;
+	struct resource *res = NULL;
 	struct device_node *mac_np;
 	struct mtk_eth *eth;
 	int err, i;
@@ -5029,20 +5074,6 @@ static int mtk_probe(struct platform_device *pdev)
 	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628))
 		eth->ip_align = NET_IP_ALIGN;
 
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SRAM)) {
-		/* SRAM is actual memory and supports transparent access just like DRAM.
-		 * Hence we don't require __iomem being set and don't need to use accessor
-		 * functions to read from or write to SRAM.
-		 */
-		if (mtk_is_netsys_v3_or_greater(eth)) {
-			eth->sram_base = (void __force *)devm_platform_ioremap_resource(pdev, 1);
-			if (IS_ERR(eth->sram_base))
-				return PTR_ERR(eth->sram_base);
-		} else {
-			eth->sram_base = (void __force *)eth->base + MTK_ETH_SRAM_OFFSET;
-		}
-	}
-
 	if (MTK_HAS_CAPS(eth->soc->caps, MTK_36BIT_DMA)) {
 		err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(36));
 		if (!err)
@@ -5117,16 +5148,28 @@ static int mtk_probe(struct platform_device *pdev)
 			err = -EINVAL;
 			goto err_destroy_sgmii;
 		}
+
 		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SRAM)) {
-			if (mtk_is_netsys_v3_or_greater(eth)) {
-				res_sram = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-				if (!res_sram) {
+			eth->sram_pool = of_gen_pool_get(pdev->dev.of_node, "sram", 0);
+			if (!eth->sram_pool) {
+				if (!mtk_is_netsys_v3_or_greater(eth)) {
+					/*
+					 * Legacy support for missing 'sram' node in DT.
+					 * SRAM is actual memory and supports transparent access
+					 * just like DRAM. Hence we don't require __iomem being
+					 * set and don't need to use accessor functions to read from
+					 * or write to SRAM.
+					 */
+					eth->sram_base = (void __force *)eth->base +
+							 MTK_ETH_SRAM_OFFSET;
+					eth->phy_scratch_ring = res->start + MTK_ETH_SRAM_OFFSET;
+					dev_warn(&pdev->dev,
+						 "legacy DT: using hard-coded SRAM offset.\n");
+				} else {
+					dev_err(&pdev->dev, "Could not get SRAM pool\n");
 					err = -EINVAL;
 					goto err_destroy_sgmii;
 				}
-				eth->phy_scratch_ring = res_sram->start;
-			} else {
-				eth->phy_scratch_ring = res->start + MTK_ETH_SRAM_OFFSET;
 			}
 		}
 	}
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 1ad9075a9b69..0104659e37f0 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -1245,7 +1245,8 @@ struct mtk_soc_data {
  * @dev:		The device pointer
  * @dma_dev:		The device pointer used for dma mapping/alloc
  * @base:		The mapped register i/o base
- * @sram_base:		The mapped SRAM base
+ * @sram_base:		The mapped SRAM base (deprecated)
+ * @sram_pool:		Pointer to SRAM pool used for DMA descriptor rings
  * @page_lock:		Make sure that register operations are atomic
  * @tx_irq__lock:	Make sure that IRQ register operations are atomic
  * @rx_irq__lock:	Make sure that IRQ register operations are atomic
@@ -1292,6 +1293,7 @@ struct mtk_eth {
 	struct device			*dma_dev;
 	void __iomem			*base;
 	void				*sram_base;
+	struct gen_pool			*sram_pool;
 	spinlock_t			page_lock;
 	spinlock_t			tx_irq_lock;
 	spinlock_t			rx_irq_lock;
-- 
2.50.0

