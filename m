Return-Path: <netdev+bounces-33866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E867A0805
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 16:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA56281990
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 14:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4498C2421D;
	Thu, 14 Sep 2023 14:40:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B77B24203;
	Thu, 14 Sep 2023 14:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DA8C433C8;
	Thu, 14 Sep 2023 14:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694702398;
	bh=llUNlobGC49KltJ5xNJ1PuIEq+EQTg2fZSDm0l6tVTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QFb5uK5nIsvQkvXKkTOluXjm4tiAbt1JYWdrttW1W608Z4zz1RHOjDApdeY4GpRnJ
	 /jUuTD18DkcX/jK88z4m5hPyD/IqZTeSoaN8sBuvOOOD3uzHJp54rOH4iWAqvWWLdv
	 Z3s0pY+u4NihorcK+FXYyzkul5/cgRntQqURD+MaHp1Ckq94nsGc56SIQvLfGirZeg
	 QbBv+W7fQVoFGAf940n/JZgV2A7Xwdc4Kju0SpEEKIoHbyQ0RejPhj1BGz7HzMuQav
	 otTIfWxAPzs3EqlFZrmyOVyzJePukI3gCI3Iw7Ve5juoBTul/V6NEkDZ+B/89vo3Bz
	 1pwstvztta/tA==
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
Subject: [PATCH net-next 13/15] net: ethernet: mtk_wed: introduce hw_rro support for MT7988
Date: Thu, 14 Sep 2023 16:38:18 +0200
Message-ID: <da27f7333fa31808ceae581d9bef5030c6072f33.1694701767.git.lorenzo@kernel.org>
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

MT7988 SoC support 802.11 receive reordering offload in hw while
MT7986 SoC implements it through the firmware running on the mcu.

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
---
 drivers/net/ethernet/mediatek/mtk_wed.c | 304 +++++++++++++++++++++++-
 include/linux/soc/mediatek/mtk_wed.h    |  44 ++++
 2 files changed, 346 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 7750869509c3..546397e2e40f 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -27,7 +27,7 @@
 #define MTK_WED_BUF_SIZE		2048
 #define MTK_WED_PAGE_BUF_SIZE		128
 #define MTK_WED_BUF_PER_PAGE		(PAGE_SIZE / 2048)
-#define MTK_WED_RX_PAGE_BUF_PER_PAGE	(PAGE_SIZE / 128)
+#define MTK_WED_RX_BUF_PER_PAGE		(PAGE_SIZE / MTK_WED_PAGE_BUF_SIZE)
 #define MTK_WED_RX_RING_SIZE		1536
 #define MTK_WED_RX_PG_BM_CNT		8192
 #define MTK_WED_AMSDU_BUF_SIZE		(PAGE_SIZE << 4)
@@ -565,6 +565,73 @@ mtk_wed_free_tx_buffer(struct mtk_wed_device *dev)
 	kfree(page_list);
 }
 
+static int
+mtk_wed_hwrro_buffer_alloc(struct mtk_wed_device *dev)
+{
+	int n_pages = MTK_WED_RX_PG_BM_CNT / MTK_WED_RX_BUF_PER_PAGE;
+	struct mtk_wed_buf *page_list;
+	struct mtk_wed_bm_desc *desc;
+	dma_addr_t desc_phys;
+	int i, page_idx = 0;
+
+	if (!dev->wlan.hw_rro)
+		return 0;
+
+	page_list = kcalloc(n_pages, sizeof(*page_list), GFP_KERNEL);
+	if (!page_list)
+		return -ENOMEM;
+
+	dev->hw_rro.size = dev->wlan.rx_nbuf & ~(MTK_WED_BUF_PER_PAGE - 1);
+	dev->hw_rro.pages = page_list;
+	desc = dma_alloc_coherent(dev->hw->dev,
+				  dev->wlan.rx_nbuf * sizeof(*desc),
+				  &desc_phys, GFP_KERNEL);
+	if (!desc)
+		return -ENOMEM;
+
+	dev->hw_rro.desc = desc;
+	dev->hw_rro.desc_phys = desc_phys;
+
+	for (i = 0; i < MTK_WED_RX_PG_BM_CNT; i += MTK_WED_RX_BUF_PER_PAGE) {
+		dma_addr_t page_phys, buf_phys;
+		struct page *page;
+		void *buf;
+		int s;
+
+		page = __dev_alloc_page(GFP_KERNEL);
+		if (!page)
+			return -ENOMEM;
+
+		page_phys = dma_map_page(dev->hw->dev, page, 0, PAGE_SIZE,
+					 DMA_BIDIRECTIONAL);
+		if (dma_mapping_error(dev->hw->dev, page_phys)) {
+			__free_page(page);
+			return -ENOMEM;
+		}
+
+		page_list[page_idx].p = page;
+		page_list[page_idx++].phy_addr = page_phys;
+		dma_sync_single_for_cpu(dev->hw->dev, page_phys, PAGE_SIZE,
+					DMA_BIDIRECTIONAL);
+
+		buf = page_to_virt(page);
+		buf_phys = page_phys;
+
+		for (s = 0; s < MTK_WED_RX_BUF_PER_PAGE; s++) {
+			desc->buf0 = cpu_to_le32(buf_phys);
+			desc++;
+
+			buf += MTK_WED_PAGE_BUF_SIZE;
+			buf_phys += MTK_WED_PAGE_BUF_SIZE;
+		}
+
+		dma_sync_single_for_device(dev->hw->dev, page_phys, PAGE_SIZE,
+					   DMA_BIDIRECTIONAL);
+	}
+
+	return 0;
+}
+
 static int
 mtk_wed_rx_buffer_alloc(struct mtk_wed_device *dev)
 {
@@ -582,7 +649,42 @@ mtk_wed_rx_buffer_alloc(struct mtk_wed_device *dev)
 	dev->rx_buf_ring.desc_phys = desc_phys;
 	dev->wlan.init_rx_buf(dev, dev->wlan.rx_npkt);
 
-	return 0;
+	return mtk_wed_hwrro_buffer_alloc(dev);
+}
+
+static void
+mtk_wed_hwrro_free_buffer(struct mtk_wed_device *dev)
+{
+	struct mtk_wed_buf *page_list = dev->hw_rro.pages;
+	struct mtk_wed_bm_desc *desc = dev->hw_rro.desc;
+	int i, page_idx = 0;
+
+	if (!dev->wlan.hw_rro)
+		return;
+
+	if (!page_list)
+		return;
+
+	if (!desc)
+		goto free_pagelist;
+
+	for (i = 0; i < MTK_WED_RX_PG_BM_CNT; i += MTK_WED_RX_BUF_PER_PAGE) {
+		dma_addr_t buf_addr = page_list[page_idx].phy_addr;
+		void *page = page_list[page_idx++].p;
+
+		if (!page)
+			break;
+
+		dma_unmap_page(dev->hw->dev, buf_addr, PAGE_SIZE,
+			       DMA_BIDIRECTIONAL);
+		__free_page(page);
+	}
+
+	dma_free_coherent(dev->hw->dev, dev->hw_rro.size * sizeof(*desc),
+			  desc, dev->hw_rro.desc_phys);
+
+free_pagelist:
+	kfree(page_list);
 }
 
 static void
@@ -596,6 +698,28 @@ mtk_wed_free_rx_buffer(struct mtk_wed_device *dev)
 	dev->wlan.release_rx_buf(dev);
 	dma_free_coherent(dev->hw->dev, dev->rx_buf_ring.size * sizeof(*desc),
 			  desc, dev->rx_buf_ring.desc_phys);
+
+	mtk_wed_hwrro_free_buffer(dev);
+}
+
+static void
+mtk_wed_hwrro_init(struct mtk_wed_device *dev)
+{
+	if (!mtk_wed_get_rx_capa(dev) || !dev->wlan.hw_rro)
+		return;
+
+	wed_set(dev, MTK_WED_RRO_PG_BM_RX_DMAM,
+		FIELD_PREP(MTK_WED_RRO_PG_BM_RX_SDL0, 128));
+
+	wed_w32(dev, MTK_WED_RRO_PG_BM_BASE, dev->hw_rro.desc_phys);
+
+	wed_w32(dev, MTK_WED_RRO_PG_BM_INIT_PTR,
+		MTK_WED_RRO_PG_BM_INIT_SW_TAIL_IDX |
+		FIELD_PREP(MTK_WED_RRO_PG_BM_SW_TAIL_IDX,
+			   MTK_WED_RX_PG_BM_CNT));
+
+	/* enable rx_page_bm to fetch dmad */
+	wed_set(dev, MTK_WED_CTRL, MTK_WED_CTRL_WED_RX_PG_BM_EN);
 }
 
 static void
@@ -609,6 +733,8 @@ mtk_wed_rx_buffer_hw_init(struct mtk_wed_device *dev)
 	wed_w32(dev, MTK_WED_RX_BM_DYN_ALLOC_TH,
 		FIELD_PREP(MTK_WED_RX_BM_DYN_ALLOC_TH_H, 0xffff));
 	wed_set(dev, MTK_WED_CTRL, MTK_WED_CTRL_WED_RX_BM_EN);
+
+	mtk_wed_hwrro_init(dev);
 }
 
 static void
@@ -903,6 +1029,8 @@ mtk_wed_bus_init(struct mtk_wed_device *dev)
 static void
 mtk_wed_set_wpdma(struct mtk_wed_device *dev)
 {
+	int i;
+
 	if (mtk_wed_is_v1(dev->hw)) {
 		wed_w32(dev, MTK_WED_WPDMA_CFG_BASE,  dev->wlan.wpdma_phys);
 		return;
@@ -923,6 +1051,15 @@ mtk_wed_set_wpdma(struct mtk_wed_device *dev)
 		wed_w32(dev, MTK_WED_WPDMA_RX_RING0_V3, dev->wlan.wpdma_rx);
 	else
 		wed_w32(dev, MTK_WED_WPDMA_RX_RING0, dev->wlan.wpdma_rx);
+
+	if (!dev->wlan.hw_rro)
+		return;
+
+	wed_w32(dev, MTK_WED_RRO_RX_D_CFG(0), dev->wlan.wpdma_rx_rro[0]);
+	wed_w32(dev, MTK_WED_RRO_RX_D_CFG(1), dev->wlan.wpdma_rx_rro[1]);
+	for (i = 0; i < MTK_WED_RX_PAGE_QUEUES; i++)
+		wed_w32(dev, MTK_WED_RRO_MSDU_PG_RING_CFG(i),
+			dev->wlan.wpdma_rx_pg + i * 0x10);
 }
 
 static void
@@ -1762,6 +1899,165 @@ mtk_wed_dma_enable(struct mtk_wed_device *dev)
 	}
 }
 
+static void
+mtk_wed_start_hw_rro(struct mtk_wed_device *dev, u32 irq_mask)
+{
+	int i;
+
+	wed_w32(dev, MTK_WED_WPDMA_INT_MASK, irq_mask);
+	wed_w32(dev, MTK_WED_INT_MASK, irq_mask);
+
+	if (!mtk_wed_get_rx_capa(dev) || !dev->wlan.hw_rro)
+		return;
+
+	wed_set(dev, MTK_WED_RRO_RX_D_CFG(2), MTK_WED_RRO_MSDU_PG_DRV_CLR);
+	wed_w32(dev, MTK_WED_RRO_MSDU_PG_RING2_CFG,
+		MTK_WED_RRO_MSDU_PG_DRV_CLR);
+
+	wed_w32(dev, MTK_WED_WPDMA_INT_CTRL_RRO_RX,
+		MTK_WED_WPDMA_INT_CTRL_RRO_RX0_EN |
+		MTK_WED_WPDMA_INT_CTRL_RRO_RX0_CLR |
+		MTK_WED_WPDMA_INT_CTRL_RRO_RX1_EN |
+		MTK_WED_WPDMA_INT_CTRL_RRO_RX1_CLR |
+		FIELD_PREP(MTK_WED_WPDMA_INT_CTRL_RRO_RX0_DONE_TRIG,
+			   dev->wlan.rro_rx_tbit[0]) |
+		FIELD_PREP(MTK_WED_WPDMA_INT_CTRL_RRO_RX1_DONE_TRIG,
+			   dev->wlan.rro_rx_tbit[1]));
+
+	wed_w32(dev, MTK_WED_WPDMA_INT_CTRL_RRO_MSDU_PG,
+		MTK_WED_WPDMA_INT_CTRL_RRO_PG0_EN |
+		MTK_WED_WPDMA_INT_CTRL_RRO_PG0_CLR |
+		MTK_WED_WPDMA_INT_CTRL_RRO_PG1_EN |
+		MTK_WED_WPDMA_INT_CTRL_RRO_PG1_CLR |
+		MTK_WED_WPDMA_INT_CTRL_RRO_PG2_EN |
+		MTK_WED_WPDMA_INT_CTRL_RRO_PG2_CLR |
+		FIELD_PREP(MTK_WED_WPDMA_INT_CTRL_RRO_PG0_DONE_TRIG,
+			   dev->wlan.rx_pg_tbit[0]) |
+		FIELD_PREP(MTK_WED_WPDMA_INT_CTRL_RRO_PG1_DONE_TRIG,
+			   dev->wlan.rx_pg_tbit[1]) |
+		FIELD_PREP(MTK_WED_WPDMA_INT_CTRL_RRO_PG2_DONE_TRIG,
+			   dev->wlan.rx_pg_tbit[2]));
+
+	/* RRO_MSDU_PG_RING2_CFG1_FLD_DRV_EN should be enabled after
+	 * WM FWDL completed, otherwise RRO_MSDU_PG ring may broken
+	 */
+	wed_set(dev, MTK_WED_RRO_MSDU_PG_RING2_CFG,
+		MTK_WED_RRO_MSDU_PG_DRV_EN);
+
+	for (i = 0; i < MTK_WED_RX_QUEUES; i++) {
+		struct mtk_wed_ring *ring = &dev->rx_rro_ring[i];
+
+		if (!(ring->flags & MTK_WED_RING_CONFIGURED))
+			continue;
+
+		if (mtk_wed_check_wfdma_rx_fill(dev, ring))
+			dev_err(dev->hw->dev,
+				"rx_rro_ring(%d) initialization failed\n", i);
+	}
+
+	for (i = 0; i < MTK_WED_RX_PAGE_QUEUES; i++) {
+		struct mtk_wed_ring *ring = &dev->rx_page_ring[i];
+
+		if (!(ring->flags & MTK_WED_RING_CONFIGURED))
+			continue;
+
+		if (mtk_wed_check_wfdma_rx_fill(dev, ring))
+			dev_err(dev->hw->dev,
+				"rx_page_ring(%d) initialization failed\n", i);
+	}
+}
+
+static void
+mtk_wed_rro_rx_ring_setup(struct mtk_wed_device *dev, int idx,
+			  void __iomem *regs)
+{
+	struct mtk_wed_ring *ring = &dev->rx_rro_ring[idx];
+
+	ring->wpdma = regs;
+	wed_w32(dev, MTK_WED_RRO_RX_D_RX(idx) + MTK_WED_RING_OFS_BASE,
+		readl(regs));
+	wed_w32(dev, MTK_WED_RRO_RX_D_RX(idx) + MTK_WED_RING_OFS_COUNT,
+		readl(regs + MTK_WED_RING_OFS_COUNT));
+	ring->flags |= MTK_WED_RING_CONFIGURED;
+}
+
+static void
+mtk_wed_msdu_pg_rx_ring_setup(struct mtk_wed_device *dev, int idx, void __iomem *regs)
+{
+	struct mtk_wed_ring *ring = &dev->rx_page_ring[idx];
+
+	ring->wpdma = regs;
+	wed_w32(dev, MTK_WED_RRO_MSDU_PG_CTRL0(idx) + MTK_WED_RING_OFS_BASE,
+		readl(regs));
+	wed_w32(dev, MTK_WED_RRO_MSDU_PG_CTRL0(idx) + MTK_WED_RING_OFS_COUNT,
+		readl(regs + MTK_WED_RING_OFS_COUNT));
+	ring->flags |= MTK_WED_RING_CONFIGURED;
+}
+
+static int
+mtk_wed_ind_rx_ring_setup(struct mtk_wed_device *dev, void __iomem *regs)
+{
+	struct mtk_wed_ring *ring = &dev->ind_cmd_ring;
+	u32 val = readl(regs + MTK_WED_RING_OFS_COUNT);
+	int i, count = 0;
+
+	ring->wpdma = regs;
+	wed_w32(dev, MTK_WED_IND_CMD_RX_CTRL1 + MTK_WED_RING_OFS_BASE,
+		readl(regs) & 0xfffffff0);
+
+	wed_w32(dev, MTK_WED_IND_CMD_RX_CTRL1 + MTK_WED_RING_OFS_COUNT,
+		readl(regs + MTK_WED_RING_OFS_COUNT));
+
+	/* ack sn cr */
+	wed_w32(dev, MTK_WED_RRO_CFG0, dev->wlan.phy_base +
+		dev->wlan.ind_cmd.ack_sn_addr);
+	wed_w32(dev, MTK_WED_RRO_CFG1,
+		FIELD_PREP(MTK_WED_RRO_CFG1_MAX_WIN_SZ,
+			   dev->wlan.ind_cmd.win_size) |
+		FIELD_PREP(MTK_WED_RRO_CFG1_PARTICL_SE_ID,
+			   dev->wlan.ind_cmd.particular_sid));
+
+	/* particular session addr element */
+	wed_w32(dev, MTK_WED_ADDR_ELEM_CFG0,
+		dev->wlan.ind_cmd.particular_se_phys);
+
+	for (i = 0; i < dev->wlan.ind_cmd.se_group_nums; i++) {
+		wed_w32(dev, MTK_WED_RADDR_ELEM_TBL_WDATA,
+			dev->wlan.ind_cmd.addr_elem_phys[i] >> 4);
+		wed_w32(dev, MTK_WED_ADDR_ELEM_TBL_CFG,
+			MTK_WED_ADDR_ELEM_TBL_WR | (i & 0x7f));
+
+		val = wed_r32(dev, MTK_WED_ADDR_ELEM_TBL_CFG);
+		while (!(val & MTK_WED_ADDR_ELEM_TBL_WR_RDY) && count++ < 100)
+			val = wed_r32(dev, MTK_WED_ADDR_ELEM_TBL_CFG);
+		if (count >= 100)
+			dev_err(dev->hw->dev,
+				"write ba session base failed\n");
+	}
+
+	/* pn check init */
+	for (i = 0; i < dev->wlan.ind_cmd.particular_sid; i++) {
+		wed_w32(dev, MTK_WED_PN_CHECK_WDATA_M,
+			MTK_WED_PN_CHECK_IS_FIRST);
+
+		wed_w32(dev, MTK_WED_PN_CHECK_CFG, MTK_WED_PN_CHECK_WR |
+			FIELD_PREP(MTK_WED_PN_CHECK_SE_ID, i));
+
+		count = 0;
+		val = wed_r32(dev, MTK_WED_PN_CHECK_CFG);
+		while (!(val & MTK_WED_PN_CHECK_WR_RDY) && count++ < 100)
+			val = wed_r32(dev, MTK_WED_PN_CHECK_CFG);
+		if (count >= 100)
+			dev_err(dev->hw->dev,
+				"session(%d) initialization failed\n", i);
+	}
+
+	wed_w32(dev, MTK_WED_RX_IND_CMD_CNT0, MTK_WED_RX_IND_CMD_DBG_CNT_EN);
+	wed_set(dev, MTK_WED_CTRL, MTK_WED_CTRL_WED_RX_IND_CMD_EN);
+
+	return 0;
+}
+
 static void
 mtk_wed_start(struct mtk_wed_device *dev, u32 irq_mask)
 {
@@ -2227,6 +2523,10 @@ void mtk_wed_add_hw(struct device_node *np, struct mtk_eth *eth,
 		.detach = mtk_wed_detach,
 		.ppe_check = mtk_wed_ppe_check,
 		.setup_tc = mtk_wed_setup_tc,
+		.start_hw_rro = mtk_wed_start_hw_rro,
+		.rro_rx_ring_setup = mtk_wed_rro_rx_ring_setup,
+		.msdu_pg_rx_ring_setup = mtk_wed_msdu_pg_rx_ring_setup,
+		.ind_rx_ring_setup = mtk_wed_ind_rx_ring_setup,
 	};
 	struct device_node *eth_np = eth->dev->of_node;
 	struct platform_device *pdev;
diff --git a/include/linux/soc/mediatek/mtk_wed.h b/include/linux/soc/mediatek/mtk_wed.h
index 802e38e0840d..dc32e3529d10 100644
--- a/include/linux/soc/mediatek/mtk_wed.h
+++ b/include/linux/soc/mediatek/mtk_wed.h
@@ -10,6 +10,7 @@
 
 #define MTK_WED_TX_QUEUES		2
 #define MTK_WED_RX_QUEUES		2
+#define MTK_WED_RX_PAGE_QUEUES		3
 
 #define WED_WO_STA_REC			0x6
 
@@ -99,6 +100,9 @@ struct mtk_wed_device {
 	struct mtk_wed_ring txfree_ring;
 	struct mtk_wed_ring tx_wdma[MTK_WED_TX_QUEUES];
 	struct mtk_wed_ring rx_wdma[MTK_WED_RX_QUEUES];
+	struct mtk_wed_ring rx_rro_ring[MTK_WED_RX_QUEUES];
+	struct mtk_wed_ring rx_page_ring[MTK_WED_RX_PAGE_QUEUES];
+	struct mtk_wed_ring ind_cmd_ring;
 
 	struct {
 		int size;
@@ -120,6 +124,13 @@ struct mtk_wed_device {
 		dma_addr_t fdbk_phys;
 	} rro;
 
+	struct {
+		int size;
+		struct mtk_wed_buf *pages;
+		struct mtk_wed_bm_desc *desc;
+		dma_addr_t desc_phys;
+	} hw_rro;
+
 	/* filled by driver: */
 	struct {
 		union {
@@ -138,6 +149,8 @@ struct mtk_wed_device {
 		u32 wpdma_txfree;
 		u32 wpdma_rx_glo;
 		u32 wpdma_rx;
+		u32 wpdma_rx_rro[MTK_WED_RX_QUEUES];
+		u32 wpdma_rx_pg;
 
 		bool wcid_512;
 		bool hw_rro;
@@ -152,9 +165,20 @@ struct mtk_wed_device {
 
 		u8 tx_tbit[MTK_WED_TX_QUEUES];
 		u8 rx_tbit[MTK_WED_RX_QUEUES];
+		u8 rro_rx_tbit[MTK_WED_RX_QUEUES];
+		u8 rx_pg_tbit[MTK_WED_RX_PAGE_QUEUES];
 		u8 txfree_tbit;
 		u8 amsdu_max_subframes;
 
+		struct {
+			u8 se_group_nums;
+			u16 win_size;
+			u16 particular_sid;
+			u32 ack_sn_addr;
+			dma_addr_t particular_se_phys;
+			dma_addr_t addr_elem_phys[1024];
+		} ind_cmd;
+
 		u32 (*init_buf)(void *ptr, dma_addr_t phys, int token_id);
 		int (*offload_enable)(struct mtk_wed_device *wed);
 		void (*offload_disable)(struct mtk_wed_device *wed);
@@ -193,6 +217,13 @@ struct mtk_wed_ops {
 	void (*irq_set_mask)(struct mtk_wed_device *dev, u32 mask);
 	int (*setup_tc)(struct mtk_wed_device *wed, struct net_device *dev,
 			enum tc_setup_type type, void *type_data);
+	void (*start_hw_rro)(struct mtk_wed_device *dev, u32 irq_mask);
+	void (*rro_rx_ring_setup)(struct mtk_wed_device *dev, int ring,
+				  void __iomem *regs);
+	void (*msdu_pg_rx_ring_setup)(struct mtk_wed_device *dev, int ring,
+				      void __iomem *regs);
+	int (*ind_rx_ring_setup)(struct mtk_wed_device *dev,
+				 void __iomem *regs);
 };
 
 extern const struct mtk_wed_ops __rcu *mtk_soc_wed_ops;
@@ -264,6 +295,15 @@ static inline bool mtk_wed_is_amsdu_supported(struct mtk_wed_device *dev)
 #define mtk_wed_device_dma_reset(_dev) (_dev)->ops->reset_dma(_dev)
 #define mtk_wed_device_setup_tc(_dev, _netdev, _type, _type_data) \
 	(_dev)->ops->setup_tc(_dev, _netdev, _type, _type_data)
+#define mtk_wed_device_start_hw_rro(_dev, _mask) \
+	(_dev)->ops->start_hw_rro(_dev, _mask)
+#define mtk_wed_device_rro_rx_ring_setup(_dev, _ring, _regs) \
+	(_dev)->ops->rro_rx_ring_setup(_dev, _ring, _regs)
+#define mtk_wed_device_msdu_pg_rx_ring_setup(_dev, _ring, _regs) \
+	(_dev)->ops->msdu_pg_rx_ring_setup(_dev, _ring, _regs)
+#define mtk_wed_device_ind_rx_ring_setup(_dev, _regs) \
+	(_dev)->ops->ind_rx_ring_setup(_dev, _regs)
+
 #else
 static inline bool mtk_wed_device_active(struct mtk_wed_device *dev)
 {
@@ -283,6 +323,10 @@ static inline bool mtk_wed_device_active(struct mtk_wed_device *dev)
 #define mtk_wed_device_stop(_dev) do {} while (0)
 #define mtk_wed_device_dma_reset(_dev) do {} while (0)
 #define mtk_wed_device_setup_tc(_dev, _netdev, _type, _type_data) -EOPNOTSUPP
+#define mtk_wed_device_start_hw_rro(_dev, _mask) do {} while (0)
+#define mtk_wed_device_rro_rx_ring_setup(_dev, _ring, _regs) -ENODEV
+#define mtk_wed_device_msdu_pg_rx_ring_setup(_dev, _ring, _regs) -ENODEV
+#define mtk_wed_device_ind_rx_ring_setup(_dev, _regs) -ENODEV
 #endif
 
 #endif
-- 
2.41.0


