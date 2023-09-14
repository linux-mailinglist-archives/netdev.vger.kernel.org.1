Return-Path: <netdev+bounces-33863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E136F7A07E4
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 16:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8171F23C57
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 14:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152BA21372;
	Thu, 14 Sep 2023 14:39:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1554628E2A;
	Thu, 14 Sep 2023 14:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57DEC433CA;
	Thu, 14 Sep 2023 14:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694702386;
	bh=/xt+Ss7I7Iyx71b6NcEH4ekpgvO95J12V3F02agSOSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JGHKuX9RlbtUNFBTOn8p90G11ZW2oauCv2pqJhDk0cnSiH3h0aQE4g2Jk5L/bVSfB
	 vm0O3EiJXgReMc6YiWh09vg2erVEUKAhhNNSUZDcMxzqGxP+yfp/Ut+jgSMteFjIJ3
	 TUsMwK+5HJcdDCkooleKh+7hTMVIg31Fxg8WrBFuCf0YPaOPjs7Ub0I5g3JD0yBY3a
	 7vqvzmDlSfRTCCv+JWxo5FHndu1vcqoXKcQB9X/pkOP0YzYt/szUR3osC5vhHhUkzZ
	 in7RJuuSA/i577Omk7cBFrucvCtgzgMVcjEqkGHj8yMFvK5UeFse3tuGKx+FlxUaoE
	 7Y/tJCGTYWN6Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	nbd@nbd.name,
	john@phrozen.org,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@makrotopia.org,
	linux-mediatek@lists.infradead.org,
	sujuan.chen@mediatek.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	devicetree@vger.kernel.org
Subject: [PATCH net-next 10/15] net: ethernet: mtk_wed: introduce WED support for MT7988
Date: Thu, 14 Sep 2023 16:38:15 +0200
Message-ID: <330efa9f15a6da8a8e7596d3a942f3e893730e12.1694701767.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694701767.git.lorenzo@kernel.org>
References: <cover.1694701767.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sujuan Chen <sujuan.chen@mediatek.com>

Similar to MT7986 and MT7622, enable Wireless Ethernet Ditpatcher for
MT7988 in order to offload traffic forwarded from LAN/WLAN to WLAN/LAN

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   |   1 +
 drivers/net/ethernet/mediatek/mtk_eth_soc.h   |   2 +-
 .../net/ethernet/mediatek/mtk_ppe_offload.c   |   3 +
 drivers/net/ethernet/mediatek/mtk_wed.c       | 458 +++++++++++++-----
 drivers/net/ethernet/mediatek/mtk_wed.h       |  28 ++
 drivers/net/ethernet/mediatek/mtk_wed_mcu.c   |  33 +-
 drivers/net/ethernet/mediatek/mtk_wed_regs.h  | 228 ++++++++-
 drivers/net/ethernet/mediatek/mtk_wed_wo.h    |   2 +
 include/linux/soc/mediatek/mtk_wed.h          |   9 +-
 9 files changed, 618 insertions(+), 146 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 3cffd1bd3067..697620c6354b 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -197,6 +197,7 @@ static const struct mtk_reg_map mt7988_reg_map = {
 	.wdma_base = {
 		[0]		= 0x4800,
 		[1]		= 0x4c00,
+		[2]		= 0x5000,
 	},
 	.pse_iq_sta		= 0x0180,
 	.pse_oq_sta		= 0x01a0,
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 403219d987ef..9ae3b8a71d0e 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -1132,7 +1132,7 @@ struct mtk_reg_map {
 	u32	gdm1_cnt;
 	u32	gdma_to_ppe;
 	u32	ppe_base;
-	u32	wdma_base[2];
+	u32	wdma_base[3];
 	u32	pse_iq_sta;
 	u32	pse_oq_sta;
 };
diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
index ef3980840695..95f76975f258 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
@@ -201,6 +201,9 @@ mtk_flow_set_output_device(struct mtk_eth *eth, struct mtk_foe_entry *foe,
 			case 1:
 				pse_port = PSE_WDMA1_PORT;
 				break;
+			case 2:
+				pse_port = PSE_WDMA2_PORT;
+				break;
 			default:
 				return -EINVAL;
 			}
diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 58d97be98029..0d8e10df9da2 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -17,17 +17,19 @@
 #include <net/flow_offload.h>
 #include <net/pkt_cls.h>
 #include "mtk_eth_soc.h"
-#include "mtk_wed_regs.h"
 #include "mtk_wed.h"
 #include "mtk_ppe.h"
 #include "mtk_wed_wo.h"
 
 #define MTK_PCIE_BASE(n)		(0x1a143000 + (n) * 0x2000)
 
-#define MTK_WED_PKT_SIZE		1900
+#define MTK_WED_PKT_SIZE		1920
 #define MTK_WED_BUF_SIZE		2048
+#define MTK_WED_PAGE_BUF_SIZE		128
 #define MTK_WED_BUF_PER_PAGE		(PAGE_SIZE / 2048)
+#define MTK_WED_RX_PAGE_BUF_PER_PAGE	(PAGE_SIZE / 128)
 #define MTK_WED_RX_RING_SIZE		1536
+#define MTK_WED_RX_PG_BM_CNT		8192
 
 #define MTK_WED_TX_RING_SIZE		2048
 #define MTK_WED_WDMA_RING_SIZE		1024
@@ -41,7 +43,10 @@
 #define MTK_WED_RRO_QUE_CNT		8192
 #define MTK_WED_MIOD_ENTRY_CNT		128
 
-static struct mtk_wed_hw *hw_list[2];
+#define MTK_WED_TX_BM_DMA_SIZE		65536
+#define MTK_WED_TX_BM_PKT_CNT		32768
+
+static struct mtk_wed_hw *hw_list[3];
 static DEFINE_MUTEX(hw_lock);
 
 struct mtk_wed_flow_block_priv {
@@ -300,33 +305,39 @@ mtk_wed_assign(struct mtk_wed_device *dev)
 static int
 mtk_wed_tx_buffer_alloc(struct mtk_wed_device *dev)
 {
+	int i, page_idx = 0, n_pages, ring_size;
+	int token = dev->wlan.token_start;
 	struct mtk_wed_buf *page_list;
-	struct mtk_wdma_desc *desc;
 	dma_addr_t desc_phys;
-	int token = dev->wlan.token_start;
-	int ring_size;
-	int n_pages;
-	int i, page_idx;
+	void *desc_ptr;
 
-	ring_size = dev->wlan.nbuf & ~(MTK_WED_BUF_PER_PAGE - 1);
-	n_pages = ring_size / MTK_WED_BUF_PER_PAGE;
+	if (!mtk_wed_is_v3_or_greater(dev->hw)) {
+		dev->tx_buf_ring.desc_size = sizeof(struct mtk_wdma_desc);
+		ring_size = dev->wlan.nbuf & ~(MTK_WED_BUF_PER_PAGE - 1);
+		dev->tx_buf_ring.size = ring_size;
+	} else {
+		dev->tx_buf_ring.desc_size = sizeof(struct mtk_wed_bm_desc);
+		dev->tx_buf_ring.size = MTK_WED_TX_BM_DMA_SIZE;
+		ring_size = MTK_WED_TX_BM_PKT_CNT;
+	}
+	n_pages = dev->tx_buf_ring.size / MTK_WED_BUF_PER_PAGE;
 
 	page_list = kcalloc(n_pages, sizeof(*page_list), GFP_KERNEL);
 	if (!page_list)
 		return -ENOMEM;
 
-	dev->tx_buf_ring.size = ring_size;
 	dev->tx_buf_ring.pages = page_list;
 
-	desc = dma_alloc_coherent(dev->hw->dev, ring_size * sizeof(*desc),
-				  &desc_phys, GFP_KERNEL);
-	if (!desc)
+	desc_ptr = dma_alloc_coherent(dev->hw->dev,
+			dev->tx_buf_ring.size * dev->tx_buf_ring.desc_size,
+			&desc_phys, GFP_KERNEL);
+	if (!desc_ptr)
 		return -ENOMEM;
 
-	dev->tx_buf_ring.desc = desc;
+	dev->tx_buf_ring.desc = desc_ptr;
 	dev->tx_buf_ring.desc_phys = desc_phys;
 
-	for (i = 0, page_idx = 0; i < ring_size; i += MTK_WED_BUF_PER_PAGE) {
+	for (i = 0; i < ring_size; i += MTK_WED_BUF_PER_PAGE) {
 		dma_addr_t page_phys, buf_phys;
 		struct page *page;
 		void *buf;
@@ -352,28 +363,34 @@ mtk_wed_tx_buffer_alloc(struct mtk_wed_device *dev)
 		buf_phys = page_phys;
 
 		for (s = 0; s < MTK_WED_BUF_PER_PAGE; s++) {
-			u32 txd_size;
-			u32 ctrl;
-
-			txd_size = dev->wlan.init_buf(buf, buf_phys, token++);
+			struct mtk_wdma_desc *desc = desc_ptr;
 
 			desc->buf0 = cpu_to_le32(buf_phys);
-			desc->buf1 = cpu_to_le32(buf_phys + txd_size);
-
-			if (mtk_wed_is_v1(dev->hw))
-				ctrl = FIELD_PREP(MTK_WDMA_DESC_CTRL_LEN0, txd_size) |
-				       FIELD_PREP(MTK_WDMA_DESC_CTRL_LEN1,
-						  MTK_WED_BUF_SIZE - txd_size) |
-				       MTK_WDMA_DESC_CTRL_LAST_SEG1;
-			else
-				ctrl = FIELD_PREP(MTK_WDMA_DESC_CTRL_LEN0, txd_size) |
-				       FIELD_PREP(MTK_WDMA_DESC_CTRL_LEN1_V2,
-						  MTK_WED_BUF_SIZE - txd_size) |
-				       MTK_WDMA_DESC_CTRL_LAST_SEG0;
-			desc->ctrl = cpu_to_le32(ctrl);
-			desc->info = 0;
-			desc++;
-
+			if (!mtk_wed_is_v3_or_greater(dev->hw)) {
+				u32 txd_size, ctrl;
+
+				txd_size = dev->wlan.init_buf(buf, buf_phys, token++);
+				desc->buf1 = cpu_to_le32(buf_phys + txd_size);
+
+				if (mtk_wed_is_v1(dev->hw))
+					ctrl = FIELD_PREP(MTK_WDMA_DESC_CTRL_LEN0,
+							  txd_size) |
+					       FIELD_PREP(MTK_WDMA_DESC_CTRL_LEN1,
+							  MTK_WED_BUF_SIZE - txd_size) |
+					       MTK_WDMA_DESC_CTRL_LAST_SEG1;
+				else
+					ctrl = FIELD_PREP(MTK_WDMA_DESC_CTRL_LEN0,
+							  txd_size) |
+					       FIELD_PREP(MTK_WDMA_DESC_CTRL_LEN1_V2,
+							  MTK_WED_BUF_SIZE - txd_size) |
+					       MTK_WDMA_DESC_CTRL_LAST_SEG0;
+				desc->ctrl = cpu_to_le32(ctrl);
+				desc->info = 0;
+			} else {
+				desc->ctrl = cpu_to_le32(token << 16);
+			}
+
+			desc_ptr += dev->tx_buf_ring.desc_size;
 			buf += MTK_WED_BUF_SIZE;
 			buf_phys += MTK_WED_BUF_SIZE;
 		}
@@ -389,31 +406,29 @@ static void
 mtk_wed_free_tx_buffer(struct mtk_wed_device *dev)
 {
 	struct mtk_wed_buf *page_list = dev->tx_buf_ring.pages;
-	struct mtk_wdma_desc *desc = dev->tx_buf_ring.desc;
-	int page_idx;
-	int i;
+	int i, page_idx = 0;
 
 	if (!page_list)
 		return;
 
-	if (!desc)
+	if (!dev->tx_buf_ring.desc)
 		goto free_pagelist;
 
-	for (i = 0, page_idx = 0; i < dev->tx_buf_ring.size;
-	     i += MTK_WED_BUF_PER_PAGE) {
-		dma_addr_t buf_addr = page_list[page_idx].phy_addr;
+	for (i = 0; i < dev->tx_buf_ring.size; i += MTK_WED_BUF_PER_PAGE) {
+		dma_addr_t page_phy = page_list[page_idx].phy_addr;
 		void *page = page_list[page_idx++].p;
 
 		if (!page)
 			break;
 
-		dma_unmap_page(dev->hw->dev, buf_addr, PAGE_SIZE,
+		dma_unmap_page(dev->hw->dev, page_phy, PAGE_SIZE,
 			       DMA_BIDIRECTIONAL);
 		__free_page(page);
 	}
 
-	dma_free_coherent(dev->hw->dev, dev->tx_buf_ring.size * sizeof(*desc),
-			  desc, dev->tx_buf_ring.desc_phys);
+	dma_free_coherent(dev->hw->dev,
+			  dev->tx_buf_ring.size * dev->tx_buf_ring.desc_size,
+			  dev->tx_buf_ring.desc, dev->tx_buf_ring.desc_phys);
 
 free_pagelist:
 	kfree(page_list);
@@ -498,13 +513,22 @@ mtk_wed_set_ext_int(struct mtk_wed_device *dev, bool en)
 {
 	u32 mask = MTK_WED_EXT_INT_STATUS_ERROR_MASK;
 
-	if (mtk_wed_is_v1(dev->hw))
+	switch (dev->hw->version) {
+	case 1:
 		mask |= MTK_WED_EXT_INT_STATUS_TX_DRV_R_RESP_ERR;
-	else
+		break;
+	case 2:
 		mask |= MTK_WED_EXT_INT_STATUS_RX_FBUF_LO_TH |
 			MTK_WED_EXT_INT_STATUS_RX_FBUF_HI_TH |
 			MTK_WED_EXT_INT_STATUS_RX_DRV_COHERENT |
 			MTK_WED_EXT_INT_STATUS_TX_DMA_W_RESP_ERR;
+		break;
+	case 3:
+		mask = MTK_WED_EXT_INT_STATUS_RX_DRV_COHERENT;
+		break;
+	default:
+		break;
+	}
 
 	if (!dev->hw->num_flows)
 		mask &= ~MTK_WED_EXT_INT_STATUS_TKID_WO_PYLD;
@@ -516,6 +540,9 @@ mtk_wed_set_ext_int(struct mtk_wed_device *dev, bool en)
 static void
 mtk_wed_set_512_support(struct mtk_wed_device *dev, bool enable)
 {
+	if (!mtk_wed_is_v2(dev->hw))
+		return;
+
 	if (enable) {
 		wed_w32(dev, MTK_WED_TXDP_CTRL, MTK_WED_TXDP_DW9_OVERWR);
 		wed_w32(dev, MTK_WED_TXP_DW1,
@@ -590,6 +617,14 @@ mtk_wed_dma_disable(struct mtk_wed_device *dev)
 			MTK_WED_WPDMA_RX_D_RX_DRV_EN);
 		wed_clr(dev, MTK_WED_WDMA_GLO_CFG,
 			MTK_WED_WDMA_GLO_CFG_TX_DDONE_CHK);
+
+		if (mtk_wed_is_v3_or_greater(dev->hw) &&
+		    mtk_wed_get_rx_capa(dev)) {
+			wdma_clr(dev, MTK_WDMA_PREF_TX_CFG,
+				 MTK_WDMA_PREF_TX_CFG_PREF_EN);
+			wdma_clr(dev, MTK_WDMA_PREF_RX_CFG,
+				 MTK_WDMA_PREF_RX_CFG_PREF_EN);
+		}
 	}
 
 	mtk_wed_set_512_support(dev, false);
@@ -632,6 +667,14 @@ mtk_wed_deinit(struct mtk_wed_device *dev)
 		MTK_WED_CTRL_RX_ROUTE_QM_EN |
 		MTK_WED_CTRL_WED_RX_BM_EN |
 		MTK_WED_CTRL_RX_RRO_QM_EN);
+
+	if (mtk_wed_is_v3_or_greater(dev->hw)) {
+		wed_clr(dev, MTK_WED_CTRL, MTK_WED_CTRL_TX_AMSDU_EN);
+		wed_clr(dev, MTK_WED_RESET, MTK_WED_RESET_TX_AMSDU);
+		wed_clr(dev, MTK_WED_PCIE_INT_CTRL,
+			MTK_WED_PCIE_INT_CTRL_MSK_EN_POLA |
+			MTK_WED_PCIE_INT_CTRL_MSK_IRQ_FILTER);
+	}
 }
 
 static void
@@ -681,21 +724,37 @@ mtk_wed_detach(struct mtk_wed_device *dev)
 	mutex_unlock(&hw_lock);
 }
 
-#define PCIE_BASE_ADDR0		0x11280000
 static void
 mtk_wed_bus_init(struct mtk_wed_device *dev)
 {
 	switch (dev->wlan.bus_type) {
 	case MTK_WED_BUS_PCIE: {
 		struct device_node *np = dev->hw->eth->dev->of_node;
-		struct regmap *regs;
 
-		regs = syscon_regmap_lookup_by_phandle(np,
-						       "mediatek,wed-pcie");
-		if (IS_ERR(regs))
-			break;
+		if (mtk_wed_is_v2(dev->hw)) {
+			struct regmap *regs;
+
+			regs = syscon_regmap_lookup_by_phandle(np,
+							       "mediatek,wed-pcie");
+			if (IS_ERR(regs))
+				break;
 
-		regmap_update_bits(regs, 0, BIT(0), BIT(0));
+			regmap_update_bits(regs, 0, BIT(0), BIT(0));
+		}
+
+		if (dev->wlan.msi) {
+			wed_w32(dev, MTK_WED_PCIE_CFG_INTM,
+				dev->hw->pcie_base | 0xc08);
+			wed_w32(dev, MTK_WED_PCIE_CFG_BASE,
+				dev->hw->pcie_base | 0xc04);
+			wed_w32(dev, MTK_WED_PCIE_INT_TRIGGER, BIT(8));
+		} else {
+			wed_w32(dev, MTK_WED_PCIE_CFG_INTM,
+				dev->hw->pcie_base | 0x180);
+			wed_w32(dev, MTK_WED_PCIE_CFG_BASE,
+				dev->hw->pcie_base | 0x184);
+			wed_w32(dev, MTK_WED_PCIE_INT_TRIGGER, BIT(24));
+		}
 
 		wed_w32(dev, MTK_WED_PCIE_INT_CTRL,
 			FIELD_PREP(MTK_WED_PCIE_INT_CTRL_POLL_EN, 2));
@@ -703,19 +762,9 @@ mtk_wed_bus_init(struct mtk_wed_device *dev)
 		/* pcie interrupt control: pola/source selection */
 		wed_set(dev, MTK_WED_PCIE_INT_CTRL,
 			MTK_WED_PCIE_INT_CTRL_MSK_EN_POLA |
-			FIELD_PREP(MTK_WED_PCIE_INT_CTRL_SRC_SEL, 1));
-		wed_r32(dev, MTK_WED_PCIE_INT_CTRL);
-
-		wed_w32(dev, MTK_WED_PCIE_CFG_INTM, PCIE_BASE_ADDR0 | 0x180);
-		wed_w32(dev, MTK_WED_PCIE_CFG_BASE, PCIE_BASE_ADDR0 | 0x184);
-
-		/* pcie interrupt status trigger register */
-		wed_w32(dev, MTK_WED_PCIE_INT_TRIGGER, BIT(24));
-		wed_r32(dev, MTK_WED_PCIE_INT_TRIGGER);
-
-		/* pola setting */
-		wed_set(dev, MTK_WED_PCIE_INT_CTRL,
-			MTK_WED_PCIE_INT_CTRL_MSK_EN_POLA);
+			MTK_WED_PCIE_INT_CTRL_MSK_IRQ_FILTER  |
+			FIELD_PREP(MTK_WED_PCIE_INT_CTRL_SRC_SEL,
+				   dev->hw->index));
 		break;
 	}
 	case MTK_WED_BUS_AXI:
@@ -747,7 +796,10 @@ mtk_wed_set_wpdma(struct mtk_wed_device *dev)
 		return;
 
 	wed_w32(dev, MTK_WED_WPDMA_RX_GLO_CFG, dev->wlan.wpdma_rx_glo);
-	wed_w32(dev, MTK_WED_WPDMA_RX_RING, dev->wlan.wpdma_rx);
+	if (mtk_wed_is_v3_or_greater(dev->hw))
+		wed_w32(dev, MTK_WED_WPDMA_RX_RING0_V3, dev->wlan.wpdma_rx);
+	else
+		wed_w32(dev, MTK_WED_WPDMA_RX_RING0, dev->wlan.wpdma_rx);
 }
 
 static void
@@ -759,12 +811,17 @@ mtk_wed_hw_init_early(struct mtk_wed_device *dev)
 	mtk_wed_reset(dev, MTK_WED_RESET_WED);
 	mtk_wed_set_wpdma(dev);
 
-	mask = MTK_WED_WDMA_GLO_CFG_BT_SIZE |
-	       MTK_WED_WDMA_GLO_CFG_DYNAMIC_DMAD_RECYCLE |
-	       MTK_WED_WDMA_GLO_CFG_RX_DIS_FSM_AUTO_IDLE;
-	set = FIELD_PREP(MTK_WED_WDMA_GLO_CFG_BT_SIZE, 2) |
-	      MTK_WED_WDMA_GLO_CFG_DYNAMIC_SKIP_DMAD_PREP |
-	      MTK_WED_WDMA_GLO_CFG_IDLE_DMAD_SUPPLY;
+	if (mtk_wed_is_v3_or_greater(dev->hw)) {
+		mask = MTK_WED_WDMA_GLO_CFG_BT_SIZE;
+		set = FIELD_PREP(MTK_WED_WDMA_GLO_CFG_BT_SIZE, 2);
+	} else {
+		mask = MTK_WED_WDMA_GLO_CFG_BT_SIZE |
+		       MTK_WED_WDMA_GLO_CFG_DYNAMIC_DMAD_RECYCLE |
+		       MTK_WED_WDMA_GLO_CFG_RX_DIS_FSM_AUTO_IDLE;
+		set = FIELD_PREP(MTK_WED_WDMA_GLO_CFG_BT_SIZE, 2) |
+		      MTK_WED_WDMA_GLO_CFG_DYNAMIC_SKIP_DMAD_PREP |
+		      MTK_WED_WDMA_GLO_CFG_IDLE_DMAD_SUPPLY;
+	}
 	wed_m32(dev, MTK_WED_WDMA_GLO_CFG, mask, set);
 
 	if (mtk_wed_is_v1(dev->hw)) {
@@ -912,11 +969,18 @@ mtk_wed_route_qm_hw_init(struct mtk_wed_device *dev)
 	}
 
 	/* configure RX_ROUTE_QM */
-	wed_clr(dev, MTK_WED_RTQM_GLO_CFG, MTK_WED_RTQM_Q_RST);
-	wed_clr(dev, MTK_WED_RTQM_GLO_CFG, MTK_WED_RTQM_TXDMAD_FPORT);
-	wed_set(dev, MTK_WED_RTQM_GLO_CFG,
-		FIELD_PREP(MTK_WED_RTQM_TXDMAD_FPORT, 0x3 + dev->hw->index));
-	wed_clr(dev, MTK_WED_RTQM_GLO_CFG, MTK_WED_RTQM_Q_RST);
+	if (mtk_wed_is_v2(dev->hw)) {
+		wed_clr(dev, MTK_WED_RTQM_GLO_CFG, MTK_WED_RTQM_Q_RST);
+		wed_clr(dev, MTK_WED_RTQM_GLO_CFG, MTK_WED_RTQM_TXDMAD_FPORT);
+		wed_set(dev, MTK_WED_RTQM_GLO_CFG,
+			FIELD_PREP(MTK_WED_RTQM_TXDMAD_FPORT,
+				   0x3 + dev->hw->index));
+		wed_clr(dev, MTK_WED_RTQM_GLO_CFG, MTK_WED_RTQM_Q_RST);
+	} else {
+		wed_set(dev, MTK_WED_RTQM_ENQ_CFG0,
+			FIELD_PREP(MTK_WED_RTQM_ENQ_CFG_TXDMAD_FPORT,
+				   0x3 + dev->hw->index));
+	}
 	/* enable RX_ROUTE_QM */
 	wed_set(dev, MTK_WED_CTRL, MTK_WED_CTRL_RX_ROUTE_QM_EN);
 }
@@ -929,18 +993,17 @@ mtk_wed_hw_init(struct mtk_wed_device *dev)
 
 	dev->init_done = true;
 	mtk_wed_set_ext_int(dev, false);
-	wed_w32(dev, MTK_WED_TX_BM_CTRL,
-		MTK_WED_TX_BM_CTRL_PAUSE |
-		FIELD_PREP(MTK_WED_TX_BM_CTRL_VLD_GRP_NUM,
-			   dev->tx_buf_ring.size / 128) |
-		FIELD_PREP(MTK_WED_TX_BM_CTRL_RSV_GRP_NUM,
-			   MTK_WED_TX_RING_SIZE / 256));
 
 	wed_w32(dev, MTK_WED_TX_BM_BASE, dev->tx_buf_ring.desc_phys);
-
 	wed_w32(dev, MTK_WED_TX_BM_BUF_LEN, MTK_WED_PKT_SIZE);
 
 	if (mtk_wed_is_v1(dev->hw)) {
+		wed_w32(dev, MTK_WED_TX_BM_CTRL,
+			MTK_WED_TX_BM_CTRL_PAUSE |
+			FIELD_PREP(MTK_WED_TX_BM_CTRL_VLD_GRP_NUM,
+				   dev->tx_buf_ring.size / 128) |
+			FIELD_PREP(MTK_WED_TX_BM_CTRL_RSV_GRP_NUM,
+				   MTK_WED_TX_RING_SIZE / 256));
 		wed_w32(dev, MTK_WED_TX_BM_TKID,
 			FIELD_PREP(MTK_WED_TX_BM_TKID_START,
 				   dev->wlan.token_start) |
@@ -951,48 +1014,93 @@ mtk_wed_hw_init(struct mtk_wed_device *dev)
 			FIELD_PREP(MTK_WED_TX_BM_DYN_THR_LO, 1) |
 			MTK_WED_TX_BM_DYN_THR_HI);
 	} else {
+		if (mtk_wed_is_v2(dev->hw)) {
+			wed_w32(dev, MTK_WED_TX_BM_CTRL,
+				MTK_WED_TX_BM_CTRL_PAUSE |
+				FIELD_PREP(MTK_WED_TX_BM_CTRL_VLD_GRP_NUM,
+					   dev->tx_buf_ring.size / 128) |
+				FIELD_PREP(MTK_WED_TX_BM_CTRL_RSV_GRP_NUM,
+					   MTK_WED_TX_RING_SIZE / 256));
+			wed_w32(dev, MTK_WED_TX_TKID_DYN_THR,
+				FIELD_PREP(MTK_WED_TX_TKID_DYN_THR_LO, 0) |
+				MTK_WED_TX_TKID_DYN_THR_HI);
+			wed_w32(dev, MTK_WED_TX_BM_DYN_THR,
+				FIELD_PREP(MTK_WED_TX_BM_DYN_THR_LO_V2, 0) |
+				MTK_WED_TX_BM_DYN_THR_HI_V2);
+			wed_w32(dev, MTK_WED_TX_TKID_CTRL,
+				MTK_WED_TX_TKID_CTRL_PAUSE |
+				FIELD_PREP(MTK_WED_TX_TKID_CTRL_VLD_GRP_NUM,
+					   dev->tx_buf_ring.size / 128) |
+				FIELD_PREP(MTK_WED_TX_TKID_CTRL_RSV_GRP_NUM,
+					   dev->tx_buf_ring.size / 128));
+		}
+
 		wed_w32(dev, MTK_WED_TX_BM_TKID_V2,
 			FIELD_PREP(MTK_WED_TX_BM_TKID_START,
 				   dev->wlan.token_start) |
 			FIELD_PREP(MTK_WED_TX_BM_TKID_END,
 				   dev->wlan.token_start +
 				   dev->wlan.nbuf - 1));
-		wed_w32(dev, MTK_WED_TX_BM_DYN_THR,
-			FIELD_PREP(MTK_WED_TX_BM_DYN_THR_LO_V2, 0) |
-			MTK_WED_TX_BM_DYN_THR_HI_V2);
-		wed_w32(dev, MTK_WED_TX_TKID_CTRL,
-			MTK_WED_TX_TKID_CTRL_PAUSE |
-			FIELD_PREP(MTK_WED_TX_TKID_CTRL_VLD_GRP_NUM,
-				   dev->tx_buf_ring.size / 128) |
-			FIELD_PREP(MTK_WED_TX_TKID_CTRL_RSV_GRP_NUM,
-				   dev->tx_buf_ring.size / 128));
-		wed_w32(dev, MTK_WED_TX_TKID_DYN_THR,
-			FIELD_PREP(MTK_WED_TX_TKID_DYN_THR_LO, 0) |
-			MTK_WED_TX_TKID_DYN_THR_HI);
 	}
 
 	mtk_wed_reset(dev, MTK_WED_RESET_TX_BM);
 
+	if (mtk_wed_is_v3_or_greater(dev->hw)) {
+		/* switch to new bm architecture */
+		wed_clr(dev, MTK_WED_TX_BM_CTRL,
+			MTK_WED_TX_BM_CTRL_LEGACY_EN);
+
+		wed_w32(dev, MTK_WED_TX_TKID_CTRL,
+			MTK_WED_TX_TKID_CTRL_PAUSE |
+			FIELD_PREP(MTK_WED_TX_TKID_CTRL_VLD_GRP_NUM_V3,
+				   dev->wlan.nbuf / 128) |
+			FIELD_PREP(MTK_WED_TX_TKID_CTRL_RSV_GRP_NUM_V3,
+				   dev->wlan.nbuf / 128));
+		/* return SKBID + SDP back to bm */
+		wed_set(dev, MTK_WED_TX_TKID_CTRL,
+			MTK_WED_TX_TKID_CTRL_FREE_FORMAT);
+
+		wed_w32(dev, MTK_WED_TX_BM_INIT_PTR,
+			MTK_WED_TX_BM_PKT_CNT |
+			MTK_WED_TX_BM_INIT_SW_TAIL_IDX);
+	}
+
 	if (mtk_wed_is_v1(dev->hw)) {
 		wed_set(dev, MTK_WED_CTRL,
 			MTK_WED_CTRL_WED_TX_BM_EN |
 			MTK_WED_CTRL_WED_TX_FREE_AGENT_EN);
-	} else {
-		wed_clr(dev, MTK_WED_TX_TKID_CTRL, MTK_WED_TX_TKID_CTRL_PAUSE);
-		if (mtk_wed_get_rx_capa(dev)) {
-			/* rx hw init */
-			wed_w32(dev, MTK_WED_WPDMA_RX_D_RST_IDX,
-				MTK_WED_WPDMA_RX_D_RST_CRX_IDX |
-				MTK_WED_WPDMA_RX_D_RST_DRV_IDX);
-			wed_w32(dev, MTK_WED_WPDMA_RX_D_RST_IDX, 0);
-
-			mtk_wed_rx_buffer_hw_init(dev);
-			mtk_wed_rro_hw_init(dev);
-			mtk_wed_route_qm_hw_init(dev);
-		}
+	} else if (mtk_wed_get_rx_capa(dev)) {
+		/* rx hw init */
+		wed_w32(dev, MTK_WED_WPDMA_RX_D_RST_IDX,
+			MTK_WED_WPDMA_RX_D_RST_CRX_IDX |
+			MTK_WED_WPDMA_RX_D_RST_DRV_IDX);
+		wed_w32(dev, MTK_WED_WPDMA_RX_D_RST_IDX, 0);
+
+		/* reset prefetch index of ring */
+		wed_set(dev, MTK_WED_WPDMA_RX_D_PREF_RX0_SIDX,
+			MTK_WED_WPDMA_RX_D_PREF_SIDX_IDX_CLR);
+		wed_clr(dev, MTK_WED_WPDMA_RX_D_PREF_RX0_SIDX,
+			MTK_WED_WPDMA_RX_D_PREF_SIDX_IDX_CLR);
+
+		wed_set(dev, MTK_WED_WPDMA_RX_D_PREF_RX1_SIDX,
+			MTK_WED_WPDMA_RX_D_PREF_SIDX_IDX_CLR);
+		wed_clr(dev, MTK_WED_WPDMA_RX_D_PREF_RX1_SIDX,
+			MTK_WED_WPDMA_RX_D_PREF_SIDX_IDX_CLR);
+
+		/* reset prefetch FIFO of ring */
+		wed_set(dev, MTK_WED_WPDMA_RX_D_PREF_FIFO_CFG,
+			MTK_WED_WPDMA_RX_D_PREF_FIFO_CFG_R0_CLR |
+			MTK_WED_WPDMA_RX_D_PREF_FIFO_CFG_R1_CLR);
+		wed_w32(dev, MTK_WED_WPDMA_RX_D_PREF_FIFO_CFG, 0);
+
+		mtk_wed_rx_buffer_hw_init(dev);
+		mtk_wed_rro_hw_init(dev);
+		mtk_wed_route_qm_hw_init(dev);
 	}
 
 	wed_clr(dev, MTK_WED_TX_BM_CTRL, MTK_WED_TX_BM_CTRL_PAUSE);
+	if (!mtk_wed_is_v1(dev->hw))
+		wed_clr(dev, MTK_WED_TX_TKID_CTRL, MTK_WED_TX_TKID_CTRL_PAUSE);
 }
 
 static void
@@ -1305,6 +1413,24 @@ mtk_wed_wdma_tx_ring_setup(struct mtk_wed_device *dev, int idx, int size,
 					 desc_size, true))
 		return -ENOMEM;
 
+	if (mtk_wed_is_v3_or_greater(dev->hw)) {
+		struct mtk_wdma_desc *desc = wdma->desc;
+		int i;
+
+		for (i = 0; i < MTK_WED_WDMA_RING_SIZE; i++) {
+			desc->buf0 = 0;
+			desc->ctrl = cpu_to_le32(MTK_WDMA_DESC_CTRL_DMA_DONE);
+			desc->buf1 = 0;
+			desc->info = cpu_to_le32(MTK_WDMA_TXD0_DESC_INFO_DMA_DONE);
+			desc++;
+			desc->buf0 = 0;
+			desc->ctrl = cpu_to_le32(MTK_WDMA_DESC_CTRL_DMA_DONE);
+			desc->buf1 = 0;
+			desc->info = cpu_to_le32(MTK_WDMA_TXD1_DESC_INFO_DMA_DONE);
+			desc++;
+		}
+	}
+
 	wdma_w32(dev, MTK_WDMA_RING_TX(idx) + MTK_WED_RING_OFS_BASE,
 		 wdma->desc_phys);
 	wdma_w32(dev, MTK_WDMA_RING_TX(idx) + MTK_WED_RING_OFS_COUNT,
@@ -1370,6 +1496,9 @@ mtk_wed_configure_irq(struct mtk_wed_device *dev, u32 irq_mask)
 
 		wed_clr(dev, MTK_WED_WDMA_INT_CTRL, wdma_mask);
 	} else {
+		if (mtk_wed_is_v3_or_greater(dev->hw))
+			wed_set(dev, MTK_WED_CTRL, MTK_WED_CTRL_TX_TKID_ALI_EN);
+
 		/* initail tx interrupt trigger */
 		wed_w32(dev, MTK_WED_WPDMA_INT_CTRL_TX,
 			MTK_WED_WPDMA_INT_CTRL_TX0_DONE_EN |
@@ -1422,33 +1551,60 @@ mtk_wed_dma_enable(struct mtk_wed_device *dev)
 {
 	int i;
 
-	wed_set(dev, MTK_WED_WPDMA_INT_CTRL, MTK_WED_WPDMA_INT_CTRL_SUBRT_ADV);
+	if (!mtk_wed_is_v3_or_greater(dev->hw)) {
+		wed_set(dev, MTK_WED_WPDMA_INT_CTRL,
+			MTK_WED_WPDMA_INT_CTRL_SUBRT_ADV);
+		wed_set(dev, MTK_WED_WPDMA_GLO_CFG,
+			MTK_WED_WPDMA_GLO_CFG_TX_DRV_EN |
+			MTK_WED_WPDMA_GLO_CFG_RX_DRV_EN);
+		wdma_set(dev, MTK_WDMA_GLO_CFG,
+			 MTK_WDMA_GLO_CFG_TX_DMA_EN |
+			 MTK_WDMA_GLO_CFG_RX_INFO1_PRERES |
+			 MTK_WDMA_GLO_CFG_RX_INFO2_PRERES);
+		wed_set(dev, MTK_WED_WPDMA_CTRL, MTK_WED_WPDMA_CTRL_SDL1_FIXED);
+	} else {
+		wed_set(dev, MTK_WED_WPDMA_GLO_CFG,
+			MTK_WED_WPDMA_GLO_CFG_TX_DRV_EN |
+			MTK_WED_WPDMA_GLO_CFG_RX_DRV_EN |
+			MTK_WED_WPDMA_GLO_CFG_RX_DDONE2_WR);
+		wdma_set(dev, MTK_WDMA_GLO_CFG, MTK_WDMA_GLO_CFG_TX_DMA_EN);
+	}
 
 	wed_set(dev, MTK_WED_GLO_CFG,
 		MTK_WED_GLO_CFG_TX_DMA_EN |
 		MTK_WED_GLO_CFG_RX_DMA_EN);
-	wed_set(dev, MTK_WED_WPDMA_GLO_CFG,
-		MTK_WED_WPDMA_GLO_CFG_TX_DRV_EN |
-		MTK_WED_WPDMA_GLO_CFG_RX_DRV_EN);
+
 	wed_set(dev, MTK_WED_WDMA_GLO_CFG,
 		MTK_WED_WDMA_GLO_CFG_RX_DRV_EN);
 
-	wdma_set(dev, MTK_WDMA_GLO_CFG,
-		 MTK_WDMA_GLO_CFG_TX_DMA_EN |
-		 MTK_WDMA_GLO_CFG_RX_INFO1_PRERES |
-		 MTK_WDMA_GLO_CFG_RX_INFO2_PRERES);
-
 	if (mtk_wed_is_v1(dev->hw)) {
 		wdma_set(dev, MTK_WDMA_GLO_CFG,
 			 MTK_WDMA_GLO_CFG_RX_INFO3_PRERES);
 		return;
 	}
 
-	wed_set(dev, MTK_WED_WPDMA_CTRL,
-		MTK_WED_WPDMA_CTRL_SDL1_FIXED);
 	wed_set(dev, MTK_WED_WPDMA_GLO_CFG,
 		MTK_WED_WPDMA_GLO_CFG_RX_DRV_R0_PKT_PROC |
 		MTK_WED_WPDMA_GLO_CFG_RX_DRV_R0_CRX_SYNC);
+
+	if (mtk_wed_is_v3_or_greater(dev->hw)) {
+		wed_set(dev, MTK_WED_WDMA_RX_PREF_CFG,
+			FIELD_PREP(MTK_WED_WDMA_RX_PREF_BURST_SIZE, 0x10) |
+			FIELD_PREP(MTK_WED_WDMA_RX_PREF_LOW_THRES, 0x8));
+		wed_clr(dev, MTK_WED_WDMA_RX_PREF_CFG,
+			MTK_WED_WDMA_RX_PREF_DDONE2_EN);
+		wed_set(dev, MTK_WED_WDMA_RX_PREF_CFG, MTK_WED_WDMA_RX_PREF_EN);
+
+		wed_clr(dev, MTK_WED_WPDMA_GLO_CFG,
+			MTK_WED_WPDMA_GLO_CFG_TX_DDONE_CHK_LAST);
+		wed_set(dev, MTK_WED_WPDMA_GLO_CFG,
+			MTK_WED_WPDMA_GLO_CFG_TX_DDONE_CHK |
+			MTK_WED_WPDMA_GLO_CFG_RX_DRV_EVENT_PKT_FMT_CHK |
+			MTK_WED_WPDMA_GLO_CFG_RX_DRV_UNS_VER_FORCE_4);
+
+		wdma_set(dev, MTK_WDMA_PREF_RX_CFG, MTK_WDMA_PREF_RX_CFG_PREF_EN);
+	}
+
 	wed_clr(dev, MTK_WED_WPDMA_GLO_CFG,
 		MTK_WED_WPDMA_GLO_CFG_TX_TKID_KEEP |
 		MTK_WED_WPDMA_GLO_CFG_TX_DMAD_DW3_PREV);
@@ -1460,11 +1616,22 @@ mtk_wed_dma_enable(struct mtk_wed_device *dev)
 		MTK_WED_WDMA_GLO_CFG_TX_DRV_EN |
 		MTK_WED_WDMA_GLO_CFG_TX_DDONE_CHK);
 
+	wed_clr(dev, MTK_WED_WPDMA_RX_D_GLO_CFG, MTK_WED_WPDMA_RX_D_RXD_READ_LEN);
 	wed_set(dev, MTK_WED_WPDMA_RX_D_GLO_CFG,
 		MTK_WED_WPDMA_RX_D_RX_DRV_EN |
 		FIELD_PREP(MTK_WED_WPDMA_RX_D_RXD_READ_LEN, 0x18) |
-		FIELD_PREP(MTK_WED_WPDMA_RX_D_INIT_PHASE_RXEN_SEL,
-			   0x2));
+		FIELD_PREP(MTK_WED_WPDMA_RX_D_INIT_PHASE_RXEN_SEL, 0x2));
+
+	if (mtk_wed_is_v3_or_greater(dev->hw)) {
+		wed_set(dev, MTK_WED_WPDMA_RX_D_PREF_CFG,
+			MTK_WED_WPDMA_RX_D_PREF_EN |
+			FIELD_PREP(MTK_WED_WPDMA_RX_D_PREF_BURST_SIZE, 0x10) |
+			FIELD_PREP(MTK_WED_WPDMA_RX_D_PREF_LOW_THRES, 0x8));
+
+		wed_set(dev, MTK_WED_RRO_RX_D_CFG(2), MTK_WED_RRO_RX_D_DRV_EN);
+		wdma_set(dev, MTK_WDMA_PREF_TX_CFG, MTK_WDMA_PREF_TX_CFG_PREF_EN);
+		wdma_set(dev, MTK_WDMA_WRBK_TX_CFG, MTK_WDMA_WRBK_TX_CFG_WRBK_EN);
+	}
 
 	for (i = 0; i < MTK_WED_RX_QUEUES; i++)
 		mtk_wed_check_wfdma_rx_fill(dev, i);
@@ -1504,6 +1671,12 @@ mtk_wed_start(struct mtk_wed_device *dev, u32 irq_mask)
 		wed_r32(dev, MTK_WED_EXT_INT_MASK1);
 		wed_r32(dev, MTK_WED_EXT_INT_MASK2);
 
+		if (mtk_wed_is_v3_or_greater(dev->hw)) {
+			wed_w32(dev, MTK_WED_EXT_INT_MASK3,
+				MTK_WED_EXT_INT_STATUS_WPDMA_MID_RDY);
+			wed_r32(dev, MTK_WED_EXT_INT_MASK3);
+		}
+
 		if (mtk_wed_rro_cfg(dev))
 			return;
 	}
@@ -1555,6 +1728,7 @@ mtk_wed_attach(struct mtk_wed_device *dev)
 	dev->irq = hw->irq;
 	dev->wdma_idx = hw->index;
 	dev->version = hw->version;
+	dev->hw->pcie_base = mtk_wed_get_pcie_base(dev);
 
 	if (hw->eth->dma_dev == hw->eth->dev &&
 	    of_dma_is_coherent(hw->eth->dev->of_node))
@@ -1622,6 +1796,23 @@ mtk_wed_tx_ring_setup(struct mtk_wed_device *dev, int idx, void __iomem *regs,
 	ring->reg_base = MTK_WED_RING_TX(idx);
 	ring->wpdma = regs;
 
+	if (mtk_wed_is_v3_or_greater(dev->hw) && idx == 1) {
+		/* reset prefetch index */
+		wed_set(dev, MTK_WED_WDMA_RX_PREF_CFG,
+			MTK_WED_WDMA_RX_PREF_RX0_SIDX_CLR |
+			MTK_WED_WDMA_RX_PREF_RX1_SIDX_CLR);
+
+		wed_clr(dev, MTK_WED_WDMA_RX_PREF_CFG,
+			MTK_WED_WDMA_RX_PREF_RX0_SIDX_CLR |
+			MTK_WED_WDMA_RX_PREF_RX1_SIDX_CLR);
+
+		/* reset prefetch FIFO */
+		wed_w32(dev, MTK_WED_WDMA_RX_PREF_FIFO_CFG,
+			MTK_WED_WDMA_RX_PREF_FIFO_RX0_CLR |
+			MTK_WED_WDMA_RX_PREF_FIFO_RX1_CLR);
+		wed_w32(dev, MTK_WED_WDMA_RX_PREF_FIFO_CFG, 0);
+	}
+
 	/* WED -> WPDMA */
 	wpdma_tx_w32(dev, idx, MTK_WED_RING_OFS_BASE, ring->desc_phys);
 	wpdma_tx_w32(dev, idx, MTK_WED_RING_OFS_COUNT, MTK_WED_TX_RING_SIZE);
@@ -1698,13 +1889,22 @@ mtk_wed_irq_get(struct mtk_wed_device *dev, u32 mask)
 {
 	u32 val, ext_mask = MTK_WED_EXT_INT_STATUS_ERROR_MASK;
 
-	if (mtk_wed_is_v1(dev->hw))
+	switch (dev->hw->version) {
+	case 1:
 		ext_mask |= MTK_WED_EXT_INT_STATUS_TX_DRV_R_RESP_ERR;
-	else
-		ext_mask |= MTK_WED_EXT_INT_STATUS_RX_FBUF_LO_TH |
-			    MTK_WED_EXT_INT_STATUS_RX_FBUF_HI_TH |
+		break;
+	case 2:
+		ext_mask |= MTK_WED_EXT_INT_STATUS_RX_FBUF_LO_TH_V2 |
+			    MTK_WED_EXT_INT_STATUS_RX_FBUF_HI_TH_V2 |
 			    MTK_WED_EXT_INT_STATUS_RX_DRV_COHERENT |
 			    MTK_WED_EXT_INT_STATUS_TX_DMA_W_RESP_ERR;
+		break;
+	case 3:
+		ext_mask = MTK_WED_EXT_INT_STATUS_RX_DRV_COHERENT;
+		break;
+	default:
+		break;
+	}
 
 	val = wed_r32(dev, MTK_WED_EXT_INT_STATUS);
 	wed_w32(dev, MTK_WED_EXT_INT_STATUS, val);
diff --git a/drivers/net/ethernet/mediatek/mtk_wed.h b/drivers/net/ethernet/mediatek/mtk_wed.h
index 6f5db891a6b9..224ff00bdd8b 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.h
+++ b/drivers/net/ethernet/mediatek/mtk_wed.h
@@ -9,6 +9,8 @@
 #include <linux/regmap.h>
 #include <linux/netdevice.h>
 
+#include "mtk_wed_regs.h"
+
 struct mtk_eth;
 struct mtk_wed_wo;
 
@@ -24,6 +26,7 @@ struct mtk_wed_hw {
 	struct dentry *debugfs_dir;
 	struct mtk_wed_device *wed_dev;
 	struct mtk_wed_wo *wed_wo;
+	u32 pcie_base;
 	u32 debugfs_reg;
 	u32 num_flows;
 	u8 version;
@@ -50,6 +53,16 @@ static inline bool mtk_wed_is_v2(struct mtk_wed_hw *hw)
 	return hw->version == 2;
 }
 
+static inline bool mtk_wed_is_v3(struct mtk_wed_hw *hw)
+{
+	return hw->version == 3;
+}
+
+static inline bool mtk_wed_is_v3_or_greater(struct mtk_wed_hw *hw)
+{
+	return hw->version > 2;
+}
+
 static inline void
 wed_w32(struct mtk_wed_device *dev, u32 reg, u32 val)
 {
@@ -132,6 +145,21 @@ wpdma_txfree_w32(struct mtk_wed_device *dev, u32 reg, u32 val)
 	writel(val, dev->txfree_ring.wpdma + reg);
 }
 
+static inline u32 mtk_wed_get_pcie_base(struct mtk_wed_device *dev)
+{
+	if (!mtk_wed_is_v3_or_greater(dev->hw))
+		return MTK_WED_PCIE_BASE;
+
+	switch (dev->hw->index) {
+	case 1:
+		return MTK_WED_PCIE_BASE1;
+	case 2:
+		return MTK_WED_PCIE_BASE2;
+	default:
+		return MTK_WED_PCIE_BASE0;
+	}
+}
+
 void mtk_wed_add_hw(struct device_node *np, struct mtk_eth *eth,
 		    void __iomem *wdma, phys_addr_t wdma_phy,
 		    int index);
diff --git a/drivers/net/ethernet/mediatek/mtk_wed_mcu.c b/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
index e53531252bd9..65a78e274009 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
@@ -331,10 +331,22 @@ mtk_wed_mcu_load_firmware(struct mtk_wed_wo *wo)
 		wo->hw->index + 1);
 
 	/* load firmware */
-	if (of_device_is_compatible(wo->hw->node, "mediatek,mt7981-wed"))
-		fw_name = MT7981_FIRMWARE_WO;
-	else
-		fw_name = wo->hw->index ? MT7986_FIRMWARE_WO1 : MT7986_FIRMWARE_WO0;
+	switch (wo->hw->version) {
+	case 2:
+		if (of_device_is_compatible(wo->hw->node,
+					    "mediatek,mt7981-wed"))
+			fw_name = MT7981_FIRMWARE_WO;
+		else
+			fw_name = wo->hw->index ? MT7986_FIRMWARE_WO1
+						: MT7986_FIRMWARE_WO0;
+		break;
+	case 3:
+		fw_name = wo->hw->index ? MT7988_FIRMWARE_WO1
+					: MT7988_FIRMWARE_WO0;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	ret = request_firmware(&fw, fw_name, wo->hw->dev);
 	if (ret)
@@ -355,15 +367,16 @@ mtk_wed_mcu_load_firmware(struct mtk_wed_wo *wo)
 	}
 
 	/* set the start address */
-	boot_cr = wo->hw->index ? MTK_WO_MCU_CFG_LS_WA_BOOT_ADDR_ADDR
-				: MTK_WO_MCU_CFG_LS_WM_BOOT_ADDR_ADDR;
+	if (!mtk_wed_is_v3_or_greater(wo->hw) && wo->hw->index)
+		boot_cr = MTK_WO_MCU_CFG_LS_WA_BOOT_ADDR_ADDR;
+	else
+		boot_cr = MTK_WO_MCU_CFG_LS_WM_BOOT_ADDR_ADDR;
 	wo_w32(wo, boot_cr, mem_region[MTK_WED_WO_REGION_EMI].phy_addr >> 16);
 	/* wo firmware reset */
 	wo_w32(wo, MTK_WO_MCU_CFG_LS_WF_MCCR_CLR_ADDR, 0xc00);
 
-	val = wo_r32(wo, MTK_WO_MCU_CFG_LS_WF_MCU_CFG_WM_WA_ADDR);
-	val |= wo->hw->index ? MTK_WO_MCU_CFG_LS_WF_WM_WA_WA_CPU_RSTB_MASK
-			     : MTK_WO_MCU_CFG_LS_WF_WM_WA_WM_CPU_RSTB_MASK;
+	val = wo_r32(wo, MTK_WO_MCU_CFG_LS_WF_MCU_CFG_WM_WA_ADDR) |
+	      MTK_WO_MCU_CFG_LS_WF_WM_WA_WM_CPU_RSTB_MASK;
 	wo_w32(wo, MTK_WO_MCU_CFG_LS_WF_MCU_CFG_WM_WA_ADDR, val);
 out:
 	release_firmware(fw);
@@ -398,3 +411,5 @@ int mtk_wed_mcu_init(struct mtk_wed_wo *wo)
 MODULE_FIRMWARE(MT7981_FIRMWARE_WO);
 MODULE_FIRMWARE(MT7986_FIRMWARE_WO0);
 MODULE_FIRMWARE(MT7986_FIRMWARE_WO1);
+MODULE_FIRMWARE(MT7988_FIRMWARE_WO0);
+MODULE_FIRMWARE(MT7988_FIRMWARE_WO1);
diff --git a/drivers/net/ethernet/mediatek/mtk_wed_regs.h b/drivers/net/ethernet/mediatek/mtk_wed_regs.h
index 47ea69feb3b2..d50ccdd3a69b 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_regs.h
+++ b/drivers/net/ethernet/mediatek/mtk_wed_regs.h
@@ -13,6 +13,9 @@
 #define MTK_WDMA_DESC_CTRL_LAST_SEG0		BIT(30)
 #define MTK_WDMA_DESC_CTRL_DMA_DONE		BIT(31)
 
+#define MTK_WDMA_TXD0_DESC_INFO_DMA_DONE	BIT(29)
+#define MTK_WDMA_TXD1_DESC_INFO_DMA_DONE	BIT(31)
+
 struct mtk_wdma_desc {
 	__le32 buf0;
 	__le32 ctrl;
@@ -37,6 +40,7 @@ struct mtk_wdma_desc {
 #define MTK_WED_RESET_WDMA_INT_AGENT			BIT(19)
 #define MTK_WED_RESET_RX_RRO_QM				BIT(20)
 #define MTK_WED_RESET_RX_ROUTE_QM			BIT(21)
+#define MTK_WED_RESET_TX_AMSDU				BIT(22)
 #define MTK_WED_RESET_WED				BIT(31)
 
 #define MTK_WED_CTRL					0x00c
@@ -44,6 +48,9 @@ struct mtk_wdma_desc {
 #define MTK_WED_CTRL_WPDMA_INT_AGENT_BUSY		BIT(1)
 #define MTK_WED_CTRL_WDMA_INT_AGENT_EN			BIT(2)
 #define MTK_WED_CTRL_WDMA_INT_AGENT_BUSY		BIT(3)
+#define MTK_WED_CTRL_WED_RX_IND_CMD_EN			BIT(5)
+#define MTK_WED_CTRL_WED_RX_PG_BM_EN			BIT(6)
+#define MTK_WED_CTRL_WED_RX_PG_BM_BUSU			BIT(7)
 #define MTK_WED_CTRL_WED_TX_BM_EN			BIT(8)
 #define MTK_WED_CTRL_WED_TX_BM_BUSY			BIT(9)
 #define MTK_WED_CTRL_WED_TX_FREE_AGENT_EN		BIT(10)
@@ -54,9 +61,14 @@ struct mtk_wdma_desc {
 #define MTK_WED_CTRL_RX_RRO_QM_BUSY			BIT(15)
 #define MTK_WED_CTRL_RX_ROUTE_QM_EN			BIT(16)
 #define MTK_WED_CTRL_RX_ROUTE_QM_BUSY			BIT(17)
+#define MTK_WED_CTRL_TX_TKID_ALI_EN			BIT(20)
+#define MTK_WED_CTRL_TX_TKID_ALI_BUSY			BIT(21)
+#define MTK_WED_CTRL_TX_AMSDU_EN			BIT(22)
+#define MTK_WED_CTRL_TX_AMSDU_BUSY			BIT(23)
 #define MTK_WED_CTRL_FINAL_DIDX_READ			BIT(24)
 #define MTK_WED_CTRL_ETH_DMAD_FMT			BIT(25)
 #define MTK_WED_CTRL_MIB_READ_CLEAR			BIT(28)
+#define MTK_WED_CTRL_FLD_MIB_RD_CLR			BIT(28)
 
 #define MTK_WED_EXT_INT_STATUS				0x020
 #define MTK_WED_EXT_INT_STATUS_TF_LEN_ERR		BIT(0)
@@ -64,6 +76,8 @@ struct mtk_wdma_desc {
 #define MTK_WED_EXT_INT_STATUS_TKID_TITO_INVALID	BIT(4)
 #define MTK_WED_EXT_INT_STATUS_TX_FBUF_LO_TH		BIT(8)
 #define MTK_WED_EXT_INT_STATUS_TX_FBUF_HI_TH		BIT(9)
+#define MTK_WED_EXT_INT_STATUS_RX_FBUF_LO_TH_V2		BIT(10)
+#define MTK_WED_EXT_INT_STATUS_RX_FBUF_HI_TH_V2		BIT(11)
 #define MTK_WED_EXT_INT_STATUS_RX_FBUF_LO_TH		BIT(12)
 #define MTK_WED_EXT_INT_STATUS_RX_FBUF_HI_TH		BIT(13)
 #define MTK_WED_EXT_INT_STATUS_RX_DRV_R_RESP_ERR	BIT(16)
@@ -89,6 +103,7 @@ struct mtk_wdma_desc {
 #define MTK_WED_EXT_INT_MASK				0x028
 #define MTK_WED_EXT_INT_MASK1				0x02c
 #define MTK_WED_EXT_INT_MASK2				0x030
+#define MTK_WED_EXT_INT_MASK3				0x034
 
 #define MTK_WED_STATUS					0x060
 #define MTK_WED_STATUS_TX				GENMASK(15, 8)
@@ -96,9 +111,14 @@ struct mtk_wdma_desc {
 #define MTK_WED_TX_BM_CTRL				0x080
 #define MTK_WED_TX_BM_CTRL_VLD_GRP_NUM			GENMASK(6, 0)
 #define MTK_WED_TX_BM_CTRL_RSV_GRP_NUM			GENMASK(22, 16)
+#define MTK_WED_TX_BM_CTRL_LEGACY_EN			BIT(26)
+#define MTK_WED_TX_TKID_CTRL_FREE_FORMAT		BIT(27)
 #define MTK_WED_TX_BM_CTRL_PAUSE			BIT(28)
 
 #define MTK_WED_TX_BM_BASE				0x084
+#define MTK_WED_TX_BM_INIT_PTR				0x088
+#define MTK_WED_TX_BM_SW_TAIL_IDX			GENMASK(16, 0)
+#define MTK_WED_TX_BM_INIT_SW_TAIL_IDX			BIT(16)
 
 #define MTK_WED_TX_BM_TKID				0x088
 #define MTK_WED_TX_BM_TKID_V2				0x0c8
@@ -124,6 +144,9 @@ struct mtk_wdma_desc {
 #define MTK_WED_TX_TKID_CTRL_RSV_GRP_NUM		GENMASK(22, 16)
 #define MTK_WED_TX_TKID_CTRL_PAUSE			BIT(28)
 
+#define MTK_WED_TX_TKID_CTRL_VLD_GRP_NUM_V3		GENMASK(7, 0)
+#define MTK_WED_TX_TKID_CTRL_RSV_GRP_NUM_V3		GENMASK(23, 16)
+
 #define MTK_WED_TX_TKID_DYN_THR				0x0e0
 #define MTK_WED_TX_TKID_DYN_THR_LO			GENMASK(6, 0)
 #define MTK_WED_TX_TKID_DYN_THR_HI			GENMASK(22, 16)
@@ -204,12 +227,15 @@ struct mtk_wdma_desc {
 #define MTK_WED_WPDMA_GLO_CFG_RX_DRV_R1_PKT_PROC	BIT(5)
 #define MTK_WED_WPDMA_GLO_CFG_RX_DRV_R0_CRX_SYNC	BIT(6)
 #define MTK_WED_WPDMA_GLO_CFG_RX_DRV_R1_CRX_SYNC	BIT(7)
-#define MTK_WED_WPDMA_GLO_CFG_RX_DRV_EVENT_PKT_FMT_VER	GENMASK(18, 16)
+#define MTK_WED_WPDMA_GLO_CFG_RX_DRV_EVENT_PKT_FMT_VER	GENMASK(15, 12)
+#define MTK_WED_WPDMA_GLO_CFG_RX_DRV_UNS_VER_FORCE_4	BIT(18)
 #define MTK_WED_WPDMA_GLO_CFG_RX_DRV_UNSUPPORT_FMT	BIT(19)
-#define MTK_WED_WPDMA_GLO_CFG_RX_DRV_UEVENT_PKT_FMT_CHK BIT(20)
+#define MTK_WED_WPDMA_GLO_CFG_RX_DRV_EVENT_PKT_FMT_CHK	BIT(20)
 #define MTK_WED_WPDMA_GLO_CFG_RX_DDONE2_WR		BIT(21)
 #define MTK_WED_WPDMA_GLO_CFG_TX_TKID_KEEP		BIT(24)
+#define MTK_WED_WPDMA_GLO_CFG_TX_DDONE_CHK_LAST		BIT(25)
 #define MTK_WED_WPDMA_GLO_CFG_TX_DMAD_DW3_PREV		BIT(28)
+#define MTK_WED_WPDMA_GLO_CFG_TX_DDONE_CHK		BIT(30)
 
 #define MTK_WED_WPDMA_RESET_IDX				0x50c
 #define MTK_WED_WPDMA_RESET_IDX_TX			GENMASK(3, 0)
@@ -255,9 +281,10 @@ struct mtk_wdma_desc {
 #define MTK_WED_PCIE_INT_TRIGGER_STATUS			BIT(16)
 
 #define MTK_WED_PCIE_INT_CTRL				0x57c
-#define MTK_WED_PCIE_INT_CTRL_MSK_EN_POLA		BIT(20)
-#define MTK_WED_PCIE_INT_CTRL_SRC_SEL			GENMASK(17, 16)
 #define MTK_WED_PCIE_INT_CTRL_POLL_EN			GENMASK(13, 12)
+#define MTK_WED_PCIE_INT_CTRL_SRC_SEL			GENMASK(17, 16)
+#define MTK_WED_PCIE_INT_CTRL_MSK_EN_POLA		BIT(20)
+#define MTK_WED_PCIE_INT_CTRL_MSK_IRQ_FILTER		BIT(21)
 
 #define MTK_WED_WPDMA_CFG_BASE				0x580
 #define MTK_WED_WPDMA_CFG_INT_MASK			0x584
@@ -286,12 +313,27 @@ struct mtk_wdma_desc {
 #define MTK_WED_WPDMA_RX_D_RST_DRV_IDX			GENMASK(25, 24)
 
 #define MTK_WED_WPDMA_RX_GLO_CFG			0x76c
-#define MTK_WED_WPDMA_RX_RING				0x770
+#define MTK_WED_WPDMA_RX_RING0				0x770
+#define MTK_WED_WPDMA_RX_RING0_V3			0x7d0
 
 #define MTK_WED_WPDMA_RX_D_MIB(_n)			(0x774 + (_n) * 4)
 #define MTK_WED_WPDMA_RX_D_PROCESSED_MIB(_n)		(0x784 + (_n) * 4)
 #define MTK_WED_WPDMA_RX_D_COHERENT_MIB			0x78c
 
+#define MTK_WED_WPDMA_RX_D_PREF_CFG			0x7b4
+#define MTK_WED_WPDMA_RX_D_PREF_EN			BIT(0)
+#define MTK_WED_WPDMA_RX_D_PREF_BURST_SIZE		GENMASK(12, 8)
+#define MTK_WED_WPDMA_RX_D_PREF_LOW_THRES		GENMASK(21, 16)
+
+#define MTK_WED_WPDMA_RX_D_PREF_RX0_SIDX		0x7b8
+#define MTK_WED_WPDMA_RX_D_PREF_SIDX_IDX_CLR		BIT(15)
+
+#define MTK_WED_WPDMA_RX_D_PREF_RX1_SIDX		0x7bc
+
+#define MTK_WED_WPDMA_RX_D_PREF_FIFO_CFG		0x7c0
+#define MTK_WED_WPDMA_RX_D_PREF_FIFO_CFG_R0_CLR		BIT(0)
+#define MTK_WED_WPDMA_RX_D_PREF_FIFO_CFG_R1_CLR		BIT(16)
+
 #define MTK_WED_WDMA_RING_TX				0x800
 
 #define MTK_WED_WDMA_TX_MIB				0x810
@@ -299,6 +341,18 @@ struct mtk_wdma_desc {
 #define MTK_WED_WDMA_RING_RX(_n)			(0x900 + (_n) * 0x10)
 #define MTK_WED_WDMA_RX_THRES(_n)			(0x940 + (_n) * 0x4)
 
+#define MTK_WED_WDMA_RX_PREF_CFG			0x950
+#define MTK_WED_WDMA_RX_PREF_EN				BIT(0)
+#define MTK_WED_WDMA_RX_PREF_BURST_SIZE			GENMASK(12, 8)
+#define MTK_WED_WDMA_RX_PREF_LOW_THRES			GENMASK(21, 16)
+#define MTK_WED_WDMA_RX_PREF_RX0_SIDX_CLR		BIT(24)
+#define MTK_WED_WDMA_RX_PREF_RX1_SIDX_CLR		BIT(25)
+#define MTK_WED_WDMA_RX_PREF_DDONE2_EN			BIT(26)
+
+#define MTK_WED_WDMA_RX_PREF_FIFO_CFG			0x95C
+#define MTK_WED_WDMA_RX_PREF_FIFO_RX0_CLR		BIT(0)
+#define MTK_WED_WDMA_RX_PREF_FIFO_RX1_CLR		BIT(16)
+
 #define MTK_WED_WDMA_GLO_CFG				0xa04
 #define MTK_WED_WDMA_GLO_CFG_TX_DRV_EN			BIT(0)
 #define MTK_WED_WDMA_GLO_CFG_TX_DDONE_CHK		BIT(1)
@@ -331,6 +385,7 @@ struct mtk_wdma_desc {
 #define MTK_WED_WDMA_INT_TRIGGER_RX_DONE		GENMASK(17, 16)
 
 #define MTK_WED_WDMA_INT_CTRL				0xa2c
+#define MTK_WED_WDMA_INT_POLL_PRD			GENMASK(7, 0)
 #define MTK_WED_WDMA_INT_CTRL_POLL_SRC_SEL		GENMASK(17, 16)
 
 #define MTK_WED_WDMA_CFG_BASE				0xaa0
@@ -394,6 +449,18 @@ struct mtk_wdma_desc {
 #define MTK_WDMA_INT_GRP1				0x250
 #define MTK_WDMA_INT_GRP2				0x254
 
+#define MTK_WDMA_PREF_TX_CFG				0x2d0
+#define MTK_WDMA_PREF_TX_CFG_PREF_EN			BIT(0)
+
+#define MTK_WDMA_PREF_RX_CFG				0x2dc
+#define MTK_WDMA_PREF_RX_CFG_PREF_EN			BIT(0)
+
+#define MTK_WDMA_WRBK_TX_CFG				0x300
+#define MTK_WDMA_WRBK_TX_CFG_WRBK_EN			BIT(30)
+
+#define MTK_WDMA_WRBK_RX_CFG				0x344
+#define MTK_WDMA_WRBK_RX_CFG_WRBK_EN			BIT(30)
+
 #define MTK_PCIE_MIRROR_MAP(n)				((n) ? 0x4 : 0x0)
 #define MTK_PCIE_MIRROR_MAP_EN				BIT(0)
 #define MTK_PCIE_MIRROR_MAP_WED_ID			BIT(1)
@@ -407,6 +474,30 @@ struct mtk_wdma_desc {
 #define MTK_WED_RTQM_Q_DBG_BYPASS			BIT(5)
 #define MTK_WED_RTQM_TXDMAD_FPORT			GENMASK(23, 20)
 
+#define MTK_WED_RTQM_IGRS0_I2HW_DMAD_CNT		0xb1c
+#define MTK_WED_RTQM_IGRS0_I2H_DMAD_CNT(_n)		(0xb20 + (_n) * 0x4)
+#define	MTK_WED_RTQM_IGRS0_I2HW_PKT_CNT			0xb28
+#define MTK_WED_RTQM_IGRS0_I2H_PKT_CNT(_n)		(0xb2c + (_n) * 0x4)
+#define MTK_WED_RTQM_IGRS0_FDROP_CNT			0xb34
+
+#define MTK_WED_RTQM_IGRS1_I2HW_DMAD_CNT		0xb44
+#define MTK_WED_RTQM_IGRS1_I2H_DMAD_CNT(_n)		(0xb48 + (_n) * 0x4)
+#define MTK_WED_RTQM_IGRS1_I2HW_PKT_CNT			0xb50
+#define MTK_WED_RTQM_IGRS1_I2H_PKT_CNT(_n)		(0xb54 + (_n) * 0x4)
+#define MTK_WED_RTQM_IGRS1_FDROP_CNT			0xb5c
+
+#define MTK_WED_RTQM_IGRS2_I2HW_DMAD_CNT		0xb6c
+#define MTK_WED_RTQM_IGRS2_I2H_DMAD_CNT(_n)		(0xb70 + (_n) * 0x4)
+#define MTK_WED_RTQM_IGRS2_I2HW_PKT_CNT			0xb78
+#define MTK_WED_RTQM_IGRS2_I2H_PKT_CNT(_n)		(0xb7c + (_n) * 0x4)
+#define MTK_WED_RTQM_IGRS2_FDROP_CNT			0xb84
+
+#define MTK_WED_RTQM_IGRS3_I2HW_DMAD_CNT		0xb94
+#define MTK_WED_RTQM_IGRS3_I2H_DMAD_CNT(_n)		(0xb98 + (_n) * 0x4)
+#define MTK_WED_RTQM_IGRS3_I2HW_PKT_CNT			0xba0
+#define MTK_WED_RTQM_IGRS3_I2H_PKT_CNT(_n)		(0xba4 + (_n) * 0x4)
+#define MTK_WED_RTQM_IGRS3_FDROP_CNT			0xbac
+
 #define MTK_WED_RTQM_R2H_MIB(_n)			(0xb70 + (_n) * 0x4)
 #define MTK_WED_RTQM_R2Q_MIB(_n)			(0xb78 + (_n) * 0x4)
 #define MTK_WED_RTQM_Q2N_MIB				0xb80
@@ -415,6 +506,24 @@ struct mtk_wdma_desc {
 #define MTK_WED_RTQM_Q2B_MIB				0xb8c
 #define MTK_WED_RTQM_PFDBK_MIB				0xb90
 
+#define MTK_WED_RTQM_ENQ_CFG0				0xbb8
+#define MTK_WED_RTQM_ENQ_CFG_TXDMAD_FPORT		GENMASK(15, 12)
+
+#define MTK_WED_RTQM_FDROP_MIB				0xb84
+#define MTK_WED_RTQM_ENQ_I2Q_DMAD_CNT			0xbbc
+#define MTK_WED_RTQM_ENQ_I2N_DMAD_CNT			0xbc0
+#define MTK_WED_RTQM_ENQ_I2Q_PKT_CNT			0xbc4
+#define MTK_WED_RTQM_ENQ_I2N_PKT_CNT			0xbc8
+#define MTK_WED_RTQM_ENQ_USED_ENTRY_CNT			0xbcc
+#define MTK_WED_RTQM_ENQ_ERR_CNT			0xbd0
+
+#define MTK_WED_RTQM_DEQ_DMAD_CNT			0xbd8
+#define MTK_WED_RTQM_DEQ_Q2I_DMAD_CNT			0xbdc
+#define MTK_WED_RTQM_DEQ_PKT_CNT			0xbe0
+#define MTK_WED_RTQM_DEQ_Q2I_PKT_CNT			0xbe4
+#define MTK_WED_RTQM_DEQ_USED_PFDBK_CNT			0xbe8
+#define MTK_WED_RTQM_DEQ_ERR_CNT			0xbec
+
 #define MTK_WED_RROQM_GLO_CFG				0xc04
 #define MTK_WED_RROQM_RST_IDX				0xc08
 #define MTK_WED_RROQM_RST_IDX_MIOD			BIT(0)
@@ -464,7 +573,116 @@ struct mtk_wdma_desc {
 #define MTK_WED_RX_BM_INTF				0xd9c
 #define MTK_WED_RX_BM_ERR_STS				0xda8
 
+#define MTK_RRO_IND_CMD_SIGNATURE			0xe00
+#define MTK_RRO_IND_CMD_DMA_IDX				GENMASK(11, 0)
+#define MTK_RRO_IND_CMD_MAGIC_CNT			GENMASK(30, 28)
+
+#define MTK_WED_IND_CMD_RX_CTRL0			0xe04
+#define MTK_WED_IND_CMD_PROC_IDX			GENMASK(11, 0)
+#define MTK_WED_IND_CMD_PREFETCH_FREE_CNT		GENMASK(19, 16)
+#define MTK_WED_IND_CMD_MAGIC_CNT			GENMASK(30, 28)
+
+#define MTK_WED_IND_CMD_RX_CTRL1			0xe08
+#define MTK_WED_IND_CMD_RX_CTRL2			0xe0c
+#define MTK_WED_IND_CMD_MAX_CNT				GENMASK(11, 0)
+#define MTK_WED_IND_CMD_BASE_M				GENMASK(19, 16)
+
+#define MTK_WED_RRO_CFG0				0xe10
+#define MTK_WED_RRO_CFG1				0xe14
+#define MTK_WED_RRO_CFG1_MAX_WIN_SZ			GENMASK(31, 29)
+#define MTK_WED_RRO_CFG1_ACK_SN_BASE_M			GENMASK(19, 16)
+#define MTK_WED_RRO_CFG1_PARTICL_SE_ID			GENMASK(11, 0)
+
+#define MTK_WED_ADDR_ELEM_CFG0				0xe18
+#define MTK_WED_ADDR_ELEM_CFG1				0xe1c
+#define MTK_WED_ADDR_ELEM_PREFETCH_FREE_CNT		GENMASK(19, 16)
+
+#define MTK_WED_ADDR_ELEM_TBL_CFG			0xe20
+#define MTK_WED_ADDR_ELEM_TBL_OFFSET			GENMASK(6, 0)
+#define MTK_WED_ADDR_ELEM_TBL_RD_RDY			BIT(28)
+#define MTK_WED_ADDR_ELEM_TBL_WR_RDY			BIT(29)
+#define MTK_WED_ADDR_ELEM_TBL_RD			BIT(30)
+#define MTK_WED_ADDR_ELEM_TBL_WR			BIT(31)
+
+#define MTK_WED_RADDR_ELEM_TBL_WDATA			0xe24
+#define MTK_WED_RADDR_ELEM_TBL_RDATA			0xe28
+
+#define MTK_WED_PN_CHECK_CFG				0xe30
+#define MTK_WED_PN_CHECK_SE_ID				GENMASK(11, 0)
+#define MTK_WED_PN_CHECK_RD_RDY				BIT(28)
+#define MTK_WED_PN_CHECK_WR_RDY				BIT(29)
+#define MTK_WED_PN_CHECK_RD				BIT(30)
+#define MTK_WED_PN_CHECK_WR				BIT(31)
+
+#define MTK_WED_PN_CHECK_WDATA_M			0xe38
+#define MTK_WED_PN_CHECK_IS_FIRST			BIT(17)
+
+#define MTK_WED_RRO_MSDU_PG_RING_CFG(_n)		(0xe44 + (_n) * 0x8)
+
+#define MTK_WED_RRO_MSDU_PG_RING2_CFG			0xe58
+#define MTK_WED_RRO_MSDU_PG_DRV_CLR			BIT(26)
+#define MTK_WED_RRO_MSDU_PG_DRV_EN			BIT(31)
+
+#define MTK_WED_RRO_MSDU_PG_CTRL0(_n)			(0xe5c + (_n) * 0xc)
+#define MTK_WED_RRO_MSDU_PG_CTRL1(_n)			(0xe60 + (_n) * 0xc)
+#define MTK_WED_RRO_MSDU_PG_CTRL2(_n)			(0xe64 + (_n) * 0xc)
+
+#define MTK_WED_RRO_RX_D_RX(_n)				(0xe80 + (_n) * 0x10)
+
+#define MTK_WED_RRO_RX_MAGIC_CNT			BIT(13)
+
+#define MTK_WED_RRO_RX_D_CFG(_n)			(0xea0 + (_n) * 0x4)
+#define MTK_WED_RRO_RX_D_DRV_CLR			BIT(26)
+#define MTK_WED_RRO_RX_D_DRV_EN				BIT(31)
+
+#define MTK_WED_RRO_PG_BM_RX_DMAM			0xeb0
+#define MTK_WED_RRO_PG_BM_RX_SDL0			GENMASK(13, 0)
+
+#define MTK_WED_RRO_PG_BM_BASE				0xeb4
+#define MTK_WED_RRO_PG_BM_INIT_PTR			0xeb8
+#define MTK_WED_RRO_PG_BM_SW_TAIL_IDX			GENMASK(15, 0)
+#define MTK_WED_RRO_PG_BM_INIT_SW_TAIL_IDX		BIT(16)
+
+#define MTK_WED_WPDMA_INT_CTRL_RRO_RX			0xeec
+#define MTK_WED_WPDMA_INT_CTRL_RRO_RX0_EN		BIT(0)
+#define MTK_WED_WPDMA_INT_CTRL_RRO_RX0_CLR		BIT(1)
+#define MTK_WED_WPDMA_INT_CTRL_RRO_RX0_DONE_TRIG	GENMASK(6, 2)
+#define MTK_WED_WPDMA_INT_CTRL_RRO_RX1_EN		BIT(8)
+#define MTK_WED_WPDMA_INT_CTRL_RRO_RX1_CLR		BIT(9)
+#define MTK_WED_WPDMA_INT_CTRL_RRO_RX1_DONE_TRIG	GENMASK(14, 10)
+
+#define MTK_WED_WPDMA_INT_CTRL_RRO_MSDU_PG		0xef4
+#define MTK_WED_WPDMA_INT_CTRL_RRO_PG0_EN		BIT(0)
+#define MTK_WED_WPDMA_INT_CTRL_RRO_PG0_CLR		BIT(1)
+#define MTK_WED_WPDMA_INT_CTRL_RRO_PG0_DONE_TRIG	GENMASK(6, 2)
+#define MTK_WED_WPDMA_INT_CTRL_RRO_PG1_EN		BIT(8)
+#define MTK_WED_WPDMA_INT_CTRL_RRO_PG1_CLR		BIT(9)
+#define MTK_WED_WPDMA_INT_CTRL_RRO_PG1_DONE_TRIG	GENMASK(14, 10)
+#define MTK_WED_WPDMA_INT_CTRL_RRO_PG2_EN		BIT(16)
+#define MTK_WED_WPDMA_INT_CTRL_RRO_PG2_CLR		BIT(17)
+#define MTK_WED_WPDMA_INT_CTRL_RRO_PG2_DONE_TRIG	GENMASK(22, 18)
+
+#define MTK_WED_RX_IND_CMD_CNT0				0xf20
+#define MTK_WED_RX_IND_CMD_DBG_CNT_EN			BIT(31)
+
+#define MTK_WED_RX_IND_CMD_CNT(_n)			(0xf20 + (_n) * 0x4)
+#define MTK_WED_IND_CMD_MAGIC_CNT_FAIL_CNT		GENMASK(15, 0)
+
+#define MTK_WED_RX_ADDR_ELEM_CNT(_n)			(0xf48 + (_n) * 0x4)
+#define MTK_WED_ADDR_ELEM_SIG_FAIL_CNT			GENMASK(15, 0)
+#define MTK_WED_ADDR_ELEM_FIRST_SIG_FAIL_CNT		GENMASK(31, 16)
+#define MTK_WED_ADDR_ELEM_ACKSN_CNT			GENMASK(27, 0)
+
+#define MTK_WED_RX_MSDU_PG_CNT(_n)			(0xf5c + (_n) * 0x4)
+
+#define MTK_WED_RX_PN_CHK_CNT				0xf70
+#define MTK_WED_PN_CHK_FAIL_CNT				GENMASK(15, 0)
+
 #define MTK_WED_WOCPU_VIEW_MIOD_BASE			0x8000
 #define MTK_WED_PCIE_INT_MASK				0x0
 
+#define MTK_WED_PCIE_BASE			0x11280000
+#define MTK_WED_PCIE_BASE0			0x11300000
+#define MTK_WED_PCIE_BASE1			0x11310000
+#define MTK_WED_PCIE_BASE2			0x11290000
 #endif
diff --git a/drivers/net/ethernet/mediatek/mtk_wed_wo.h b/drivers/net/ethernet/mediatek/mtk_wed_wo.h
index 8ed81761bf10..87a67fa3868d 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_wo.h
+++ b/drivers/net/ethernet/mediatek/mtk_wed_wo.h
@@ -91,6 +91,8 @@ enum mtk_wed_dummy_cr_idx {
 #define MT7981_FIRMWARE_WO	"mediatek/mt7981_wo.bin"
 #define MT7986_FIRMWARE_WO0	"mediatek/mt7986_wo_0.bin"
 #define MT7986_FIRMWARE_WO1	"mediatek/mt7986_wo_1.bin"
+#define MT7988_FIRMWARE_WO0	"mediatek/mt7988_wo_0.bin"
+#define MT7988_FIRMWARE_WO1	"mediatek/mt7988_wo_1.bin"
 
 #define MTK_WO_MCU_CFG_LS_BASE				0
 #define MTK_WO_MCU_CFG_LS_HW_VER_ADDR			(MTK_WO_MCU_CFG_LS_BASE + 0x000)
diff --git a/include/linux/soc/mediatek/mtk_wed.h b/include/linux/soc/mediatek/mtk_wed.h
index 5f00dc26582b..0beccbe45585 100644
--- a/include/linux/soc/mediatek/mtk_wed.h
+++ b/include/linux/soc/mediatek/mtk_wed.h
@@ -102,6 +102,7 @@ struct mtk_wed_device {
 
 	struct {
 		int size;
+		int desc_size;
 		struct mtk_wed_buf *pages;
 		struct mtk_wdma_desc *desc;
 		dma_addr_t desc_phys;
@@ -138,6 +139,8 @@ struct mtk_wed_device {
 		u32 wpdma_rx;
 
 		bool wcid_512;
+		bool hw_rro;
+		bool msi;
 
 		u16 token_start;
 		unsigned int nbuf;
@@ -211,10 +214,12 @@ mtk_wed_device_attach(struct mtk_wed_device *dev)
 	return ret;
 }
 
-static inline bool
-mtk_wed_get_rx_capa(struct mtk_wed_device *dev)
+static inline bool mtk_wed_get_rx_capa(struct mtk_wed_device *dev)
 {
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
+	if (dev->version == 3)
+		return dev->wlan.hw_rro;
+
 	return dev->version != 1;
 #else
 	return false;
-- 
2.41.0


