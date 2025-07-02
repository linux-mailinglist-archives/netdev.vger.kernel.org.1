Return-Path: <netdev+bounces-203346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B49AF584B
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 15:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 006414A811D
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D667127A904;
	Wed,  2 Jul 2025 13:15:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5A5278E7B;
	Wed,  2 Jul 2025 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462106; cv=none; b=a2M8EQpVnuHwf9nPro+M2YrVjd22FMD3VvhNxSXFikjpWpazx4iyqjZj57kqDGeYeXFtJo4QumdQuEYv25YLo0pUT1hiC+Rs37k6Frq5X4kk59OSi5qaZHBCzmOWlXUhAod6ehSIeOKk7hUhiSUD+J1OCXRSD1OsML7iKtPu3I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462106; c=relaxed/simple;
	bh=nTWVnvrDxjxy+y7ZCiNtFIeOBKge8ov7uEPL0sS4PUA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YI+a0BToMMmquPvDPkUoFaw7JwfOC8WeGHfPpxVqbsV6k1HcrCXcTR4+VOKCMKWjVOAd/OBmZ4OlL/vOHy+bJ5PJpCgsWb/RmKlE21nMTxv1nxRSKtFp0LfsLZ6MPmS9z9esYOdAsAT1qeOtoLjBYTJh/R1NHOkPzVHRHllc9LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uWxIh-000000007tp-1UHn;
	Wed, 02 Jul 2025 13:14:59 +0000
Date: Wed, 2 Jul 2025 14:14:56 +0100
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
Subject: [PATCH net-next v5 3/3] net: ethernet: mtk_eth_soc: use generic
 allocator for SRAM
Message-ID: <c2b9242229d06af4e468204bcf42daa1535c3a72.1751461762.git.daniel@makrotopia.org>
References: <cover.1751461762.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751461762.git.daniel@makrotopia.org>

Use a dedicated "mmio-sram" node and the generic allocator
instead of open-coding SRAM allocation for DMA rings.
Keep support for legacy device trees but notify the user via a
warning to update, and let the ethernet driver create the
gen_pool in this case.

Co-developed-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v5: remove unused variable tx_ring_size in mtk_rx_alloc()
    avoid long lines
v4: always use gen_pool allocator completely replacing the
    previous approach of hardcoded SRAM offsets
    added missing Kconfig change
v3: fix resource leak on error in mtk_probe()
v2: fix return type of mtk_dma_ring_alloc() in case of error

 drivers/net/ethernet/mediatek/Kconfig       |   1 +
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 152 +++++++++++---------
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  10 +-
 3 files changed, 90 insertions(+), 73 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/Kconfig b/drivers/net/ethernet/mediatek/Kconfig
index 7bfd3f230ff5..2ba361f8ce7d 100644
--- a/drivers/net/ethernet/mediatek/Kconfig
+++ b/drivers/net/ethernet/mediatek/Kconfig
@@ -17,6 +17,7 @@ config NET_MEDIATEK_SOC
 	select PINCTRL
 	select PHYLINK
 	select DIMLIB
+	select GENERIC_ALLOCATOR
 	select PAGE_POOL
 	select PAGE_POOL_STATS
 	select PCS_MTK_LYNXI
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 8f55069441f4..11ee7e1829bf 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -27,6 +27,7 @@
 #include <net/dsa.h>
 #include <net/dst_metadata.h>
 #include <net/page_pool/helpers.h>
+#include <linux/genalloc.h>
 
 #include "mtk_eth_soc.h"
 #include "mtk_wed.h"
@@ -1267,6 +1268,34 @@ static void *mtk_max_lro_buf_alloc(gfp_t gfp_mask)
 	return (void *)data;
 }
 
+static void *mtk_dma_ring_alloc(struct mtk_eth *eth, size_t size,
+				dma_addr_t *dma_handle, bool use_sram)
+{
+	void *dma_ring;
+
+	if (use_sram && eth->sram_pool) {
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
+			      dma_addr_t dma_handle, bool in_sram)
+{
+	if (in_sram && eth->sram_pool)
+		gen_pool_free(eth->sram_pool, (unsigned long)dma_ring, size);
+	else
+		dma_free_coherent(eth->dma_dev, size, dma_ring, dma_handle);
+}
+
 /* the qdma core needs scratch memory to be setup */
 static int mtk_init_fq_dma(struct mtk_eth *eth)
 {
@@ -1276,13 +1305,8 @@ static int mtk_init_fq_dma(struct mtk_eth *eth)
 	dma_addr_t dma_addr;
 	int i, j, len;
 
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SRAM))
-		eth->scratch_ring = eth->sram_base;
-	else
-		eth->scratch_ring = dma_alloc_coherent(eth->dma_dev,
-						       cnt * soc->tx.desc_size,
-						       &eth->phy_scratch_ring,
-						       GFP_KERNEL);
+	eth->scratch_ring = mtk_dma_ring_alloc(eth, cnt * soc->tx.desc_size,
+					       &eth->phy_scratch_ring, true);
 
 	if (unlikely(!eth->scratch_ring))
 		return -ENOMEM;
@@ -2620,14 +2644,7 @@ static int mtk_tx_alloc(struct mtk_eth *eth)
 	if (!ring->buf)
 		goto no_tx_mem;
 
-	if (MTK_HAS_CAPS(soc->caps, MTK_SRAM)) {
-		ring->dma = eth->sram_base + soc->tx.fq_dma_size * sz;
-		ring->phys = eth->phy_scratch_ring + soc->tx.fq_dma_size * (dma_addr_t)sz;
-	} else {
-		ring->dma = dma_alloc_coherent(eth->dma_dev, ring_size * sz,
-					       &ring->phys, GFP_KERNEL);
-	}
-
+	ring->dma = mtk_dma_ring_alloc(eth, ring_size * sz, &ring->phys, true);
 	if (!ring->dma)
 		goto no_tx_mem;
 
@@ -2726,10 +2743,10 @@ static void mtk_tx_clean(struct mtk_eth *eth)
 		kfree(ring->buf);
 		ring->buf = NULL;
 	}
-	if (!MTK_HAS_CAPS(soc->caps, MTK_SRAM) && ring->dma) {
-		dma_free_coherent(eth->dma_dev,
-				  ring->dma_size * soc->tx.desc_size,
-				  ring->dma, ring->phys);
+
+	if (ring->dma) {
+		mtk_dma_ring_free(eth, ring->dma_size * soc->tx.desc_size,
+				  ring->dma, ring->phys, true);
 		ring->dma = NULL;
 	}
 
@@ -2746,14 +2763,9 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 	const struct mtk_reg_map *reg_map = eth->soc->reg_map;
 	const struct mtk_soc_data *soc = eth->soc;
 	struct mtk_rx_ring *ring;
-	int rx_data_len, rx_dma_size, tx_ring_size;
+	int rx_data_len, rx_dma_size;
 	int i;
 
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_QDMA))
-		tx_ring_size = MTK_QDMA_RING_SIZE;
-	else
-		tx_ring_size = soc->tx.dma_size;
-
 	if (rx_flag == MTK_RX_FLAGS_QDMA) {
 		if (ring_no)
 			return -EINVAL;
@@ -2788,20 +2800,10 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 		ring->page_pool = pp;
 	}
 
-	if (!MTK_HAS_CAPS(eth->soc->caps, MTK_SRAM) ||
-	    rx_flag != MTK_RX_FLAGS_NORMAL) {
-		ring->dma = dma_alloc_coherent(eth->dma_dev,
-				rx_dma_size * eth->soc->rx.desc_size,
-				&ring->phys, GFP_KERNEL);
-	} else {
-		struct mtk_tx_ring *tx_ring = &eth->tx_ring;
-
-		ring->dma = tx_ring->dma + tx_ring_size *
-			    eth->soc->tx.desc_size * (ring_no + 1);
-		ring->phys = tx_ring->phys + tx_ring_size *
-			     eth->soc->tx.desc_size * (ring_no + 1);
-	}
-
+	ring->dma = mtk_dma_ring_alloc(eth,
+				       rx_dma_size * eth->soc->rx.desc_size,
+				       &ring->phys,
+				       rx_flag == MTK_RX_FLAGS_NORMAL);
 	if (!ring->dma)
 		return -ENOMEM;
 
@@ -2916,10 +2918,9 @@ static void mtk_rx_clean(struct mtk_eth *eth, struct mtk_rx_ring *ring, bool in_
 		ring->data = NULL;
 	}
 
-	if (!in_sram && ring->dma) {
-		dma_free_coherent(eth->dma_dev,
-				  ring->dma_size * eth->soc->rx.desc_size,
-				  ring->dma, ring->phys);
+	if (ring->dma) {
+		mtk_dma_ring_free(eth, ring->dma_size * eth->soc->rx.desc_size,
+				  ring->dma, ring->phys, in_sram);
 		ring->dma = NULL;
 	}
 
@@ -3287,15 +3288,16 @@ static void mtk_dma_free(struct mtk_eth *eth)
 			netdev_tx_reset_subqueue(eth->netdev[i], j);
 	}
 
-	if (!MTK_HAS_CAPS(soc->caps, MTK_SRAM) && eth->scratch_ring) {
-		dma_free_coherent(eth->dma_dev,
-				  MTK_QDMA_RING_SIZE * soc->tx.desc_size,
-				  eth->scratch_ring, eth->phy_scratch_ring);
+	if (eth->scratch_ring) {
+		mtk_dma_ring_free(eth, soc->tx.fq_dma_size * soc->tx.desc_size,
+				  eth->scratch_ring, eth->phy_scratch_ring,
+				  true);
 		eth->scratch_ring = NULL;
 		eth->phy_scratch_ring = 0;
 	}
+
 	mtk_tx_clean(eth);
-	mtk_rx_clean(eth, &eth->rx_ring[0], MTK_HAS_CAPS(soc->caps, MTK_SRAM));
+	mtk_rx_clean(eth, &eth->rx_ring[0], true);
 	mtk_rx_clean(eth, &eth->rx_ring_qdma, false);
 
 	if (eth->hwlro) {
@@ -5007,9 +5009,30 @@ static int mtk_sgmii_init(struct mtk_eth *eth)
 	return 0;
 }
 
+static int mtk_setup_legacy_sram(struct mtk_eth *eth, struct resource *res)
+{
+	dev_warn(eth->dev, "legacy DT: using hard-coded SRAM offset.\n");
+
+	if (res->start + MTK_ETH_SRAM_OFFSET + MTK_ETH_NETSYS_V2_SRAM_SIZE - 1 >
+	    res->end)
+		return -EINVAL;
+
+	eth->sram_pool = devm_gen_pool_create(eth->dev,
+					      const_ilog2(MTK_ETH_SRAM_GRANULARITY),
+					      NUMA_NO_NODE, dev_name(eth->dev));
+
+	if (IS_ERR(eth->sram_pool))
+		return PTR_ERR(eth->sram_pool);
+
+	return gen_pool_add_virt(eth->sram_pool,
+				 (unsigned long)eth->base + MTK_ETH_SRAM_OFFSET,
+				 res->start + MTK_ETH_SRAM_OFFSET,
+				 MTK_ETH_NETSYS_V2_SRAM_SIZE, NUMA_NO_NODE);
+}
+
 static int mtk_probe(struct platform_device *pdev)
 {
-	struct resource *res = NULL, *res_sram;
+	struct resource *res = NULL;
 	struct device_node *mac_np;
 	struct mtk_eth *eth;
 	int err, i;
@@ -5029,20 +5052,6 @@ static int mtk_probe(struct platform_device *pdev)
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
@@ -5117,16 +5126,21 @@ static int mtk_probe(struct platform_device *pdev)
 			err = -EINVAL;
 			goto err_destroy_sgmii;
 		}
+
 		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SRAM)) {
-			if (mtk_is_netsys_v3_or_greater(eth)) {
-				res_sram = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-				if (!res_sram) {
+			eth->sram_pool = of_gen_pool_get(pdev->dev.of_node,
+							 "sram", 0);
+			if (!eth->sram_pool) {
+				if (!mtk_is_netsys_v3_or_greater(eth)) {
+					err = mtk_setup_legacy_sram(eth, res);
+					if (err)
+						goto err_destroy_sgmii;
+				} else {
+					dev_err(&pdev->dev,
+						"Could not get SRAM pool\n");
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
index 1ad9075a9b69..0168e2fbc619 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -141,8 +141,10 @@
 #define MTK_GDMA_MAC_ADRH(x)	({ typeof(x) _x = (x); (_x == MTK_GMAC3_ID) ?	\
 				   0x54C : 0x50C + (_x * 0x1000); })
 
-/* Internal SRAM offset */
-#define MTK_ETH_SRAM_OFFSET	0x40000
+/* legacy DT support for internal SRAM */
+#define MTK_ETH_SRAM_OFFSET		0x40000
+#define MTK_ETH_SRAM_GRANULARITY	32
+#define MTK_ETH_NETSYS_V2_SRAM_SIZE	0x40000
 
 /* FE global misc reg*/
 #define MTK_FE_GLO_MISC         0x124
@@ -1245,7 +1247,7 @@ struct mtk_soc_data {
  * @dev:		The device pointer
  * @dma_dev:		The device pointer used for dma mapping/alloc
  * @base:		The mapped register i/o base
- * @sram_base:		The mapped SRAM base
+ * @sram_pool:		Pointer to SRAM pool used for DMA descriptor rings
  * @page_lock:		Make sure that register operations are atomic
  * @tx_irq__lock:	Make sure that IRQ register operations are atomic
  * @rx_irq__lock:	Make sure that IRQ register operations are atomic
@@ -1291,7 +1293,7 @@ struct mtk_eth {
 	struct device			*dev;
 	struct device			*dma_dev;
 	void __iomem			*base;
-	void				*sram_base;
+	struct gen_pool			*sram_pool;
 	spinlock_t			page_lock;
 	spinlock_t			tx_irq_lock;
 	spinlock_t			rx_irq_lock;
-- 
2.50.0

