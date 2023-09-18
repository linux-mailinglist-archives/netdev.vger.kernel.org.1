Return-Path: <netdev+bounces-34520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF607A4741
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 12:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40299282B28
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 10:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF771CAA1;
	Mon, 18 Sep 2023 10:30:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B3028DD7;
	Mon, 18 Sep 2023 10:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C76C433C8;
	Mon, 18 Sep 2023 10:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695033043;
	bh=rKwdHo4ntN6UV8NUZh/VsjTJBAMILyUK2TOhiJouCGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rh7mFkKfp8k2Y3zQqMjPI81MeTKd9N+GYaR0gVatQe5bsnqxhb6qxY+sa8t/vQ0eW
	 jNzMNRYl61OAc4DbOF4/pJIcbh1IIQNs0qOnyDdoe2vRSMCCZQoWiqcGuFdsiD7NRa
	 o6eaYeKnmlsQiEMTb4a/HP7AvxB6MEg9Ovk0tkCk0lZWuOp5Gd/1ovlRJ/nXUwjIQT
	 AmoSvOwjjVZfnF2ZZy9Nxq1qFmsbYbTSKrLjQZfUfuNe2q2Zf8akQrazxKjWEmGAEZ
	 gfuR1Jk+d6LQeccooV9FiJ41G/nYrfUOobXLxgKdXFliTmRDnlQ7sQoeq59PW7rbI/
	 4KhpSPd+mCj2A==
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
	horms@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 net-next 13/17] net: ethernet: mtk_wed: introduce partial AMSDU offload support for MT7988
Date: Mon, 18 Sep 2023 12:29:15 +0200
Message-ID: <5bab49b3e3eda3e1cdc5b42cccf998a0c99d6bca.1695032291.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695032290.git.lorenzo@kernel.org>
References: <cover.1695032290.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sujuan Chen <sujuan.chen@mediatek.com>

Introduce partial AMSDU offload support for MT7988 SoC in order to merge
in hw packets belonging to the same AMSDU before passing them to the
WLAN nic.

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
---
 drivers/net/ethernet/mediatek/mtk_ppe.c       |   4 +-
 drivers/net/ethernet/mediatek/mtk_ppe.h       |  19 ++-
 .../net/ethernet/mediatek/mtk_ppe_offload.c   |   3 +-
 drivers/net/ethernet/mediatek/mtk_wed.c       | 154 ++++++++++++++++--
 drivers/net/ethernet/mediatek/mtk_wed.h       |   7 +
 drivers/net/ethernet/mediatek/mtk_wed_regs.h  |  76 +++++++++
 include/linux/netdevice.h                     |   1 +
 include/linux/soc/mediatek/mtk_wed.h          |  12 ++
 8 files changed, 248 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.c b/drivers/net/ethernet/mediatek/mtk_ppe.c
index 86f32f486043..b2a5d9c3733d 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe.c
@@ -425,7 +425,8 @@ int mtk_foe_entry_set_pppoe(struct mtk_eth *eth, struct mtk_foe_entry *entry,
 }
 
 int mtk_foe_entry_set_wdma(struct mtk_eth *eth, struct mtk_foe_entry *entry,
-			   int wdma_idx, int txq, int bss, int wcid)
+			   int wdma_idx, int txq, int bss, int wcid,
+			   bool amsdu_en)
 {
 	struct mtk_foe_mac_info *l2 = mtk_foe_entry_l2(eth, entry);
 	u32 *ib2 = mtk_foe_entry_ib2(eth, entry);
@@ -437,6 +438,7 @@ int mtk_foe_entry_set_wdma(struct mtk_eth *eth, struct mtk_foe_entry *entry,
 			 MTK_FOE_IB2_WDMA_WINFO_V2;
 		l2->w3info = FIELD_PREP(MTK_FOE_WINFO_WCID_V3, wcid) |
 			     FIELD_PREP(MTK_FOE_WINFO_BSS_V3, bss);
+		l2->amsdu = FIELD_PREP(MTK_FOE_WINFO_AMSDU_EN, amsdu_en);
 		break;
 	case 2:
 		*ib2 &= ~MTK_FOE_IB2_PORT_MG_V2;
diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.h b/drivers/net/ethernet/mediatek/mtk_ppe.h
index e3d0ec72bc69..691806bca372 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe.h
+++ b/drivers/net/ethernet/mediatek/mtk_ppe.h
@@ -88,13 +88,13 @@ enum {
 #define MTK_FOE_WINFO_BSS_V3		GENMASK(23, 16)
 #define MTK_FOE_WINFO_WCID_V3		GENMASK(15, 0)
 
-#define MTK_FOE_WINFO_PAO_USR_INFO	GENMASK(15, 0)
-#define MTK_FOE_WINFO_PAO_TID		GENMASK(19, 16)
-#define MTK_FOE_WINFO_PAO_IS_FIXEDRATE	BIT(20)
-#define MTK_FOE_WINFO_PAO_IS_PRIOR	BIT(21)
-#define MTK_FOE_WINFO_PAO_IS_SP		BIT(22)
-#define MTK_FOE_WINFO_PAO_HF		BIT(23)
-#define MTK_FOE_WINFO_PAO_AMSDU_EN	BIT(24)
+#define MTK_FOE_WINFO_AMSDU_USR_INFO	GENMASK(15, 0)
+#define MTK_FOE_WINFO_AMSDU_TID		GENMASK(19, 16)
+#define MTK_FOE_WINFO_AMSDU_IS_FIXEDRATE	BIT(20)
+#define MTK_FOE_WINFO_AMSDU_IS_PRIOR	BIT(21)
+#define MTK_FOE_WINFO_AMSDU_IS_SP	BIT(22)
+#define MTK_FOE_WINFO_AMSDU_HF		BIT(23)
+#define MTK_FOE_WINFO_AMSDU_EN		BIT(24)
 
 enum {
 	MTK_FOE_STATE_INVALID,
@@ -123,7 +123,7 @@ struct mtk_foe_mac_info {
 
 	/* netsys_v3 */
 	u32 w3info;
-	u32 wpao;
+	u32 amsdu;
 };
 
 /* software-only entry type */
@@ -392,7 +392,8 @@ int mtk_foe_entry_set_vlan(struct mtk_eth *eth, struct mtk_foe_entry *entry,
 int mtk_foe_entry_set_pppoe(struct mtk_eth *eth, struct mtk_foe_entry *entry,
 			    int sid);
 int mtk_foe_entry_set_wdma(struct mtk_eth *eth, struct mtk_foe_entry *entry,
-			   int wdma_idx, int txq, int bss, int wcid);
+			   int wdma_idx, int txq, int bss, int wcid,
+			   bool amsdu_en);
 int mtk_foe_entry_set_queue(struct mtk_eth *eth, struct mtk_foe_entry *entry,
 			    unsigned int queue);
 int mtk_foe_entry_commit(struct mtk_ppe *ppe, struct mtk_flow_entry *entry);
diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
index 95f76975f258..e073d2b5542c 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
@@ -111,6 +111,7 @@ mtk_flow_get_wdma_info(struct net_device *dev, const u8 *addr, struct mtk_wdma_i
 	info->queue = path->mtk_wdma.queue;
 	info->bss = path->mtk_wdma.bss;
 	info->wcid = path->mtk_wdma.wcid;
+	info->amsdu = path->mtk_wdma.amsdu;
 
 	return 0;
 }
@@ -192,7 +193,7 @@ mtk_flow_set_output_device(struct mtk_eth *eth, struct mtk_foe_entry *foe,
 
 	if (mtk_flow_get_wdma_info(dev, dest_mac, &info) == 0) {
 		mtk_foe_entry_set_wdma(eth, foe, info.wdma_idx, info.queue,
-				       info.bss, info.wcid);
+				       info.bss, info.wcid, info.amsdu);
 		if (mtk_is_netsys_v2_or_greater(eth)) {
 			switch (info.wdma_idx) {
 			case 0:
diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 18cbf028f6ed..d4b41ccfbad5 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -30,6 +30,8 @@
 #define MTK_WED_RX_PAGE_BUF_PER_PAGE	(PAGE_SIZE / 128)
 #define MTK_WED_RX_RING_SIZE		1536
 #define MTK_WED_RX_PG_BM_CNT		8192
+#define MTK_WED_AMSDU_BUF_SIZE		(PAGE_SIZE << 4)
+#define MTK_WED_AMSDU_NPAGES		32
 
 #define MTK_WED_TX_RING_SIZE		2048
 #define MTK_WED_WDMA_RING_SIZE		1024
@@ -173,6 +175,23 @@ mtk_wdma_rx_reset(struct mtk_wed_device *dev)
 	return ret;
 }
 
+static u32
+mtk_wed_check_busy(struct mtk_wed_device *dev, u32 reg, u32 mask)
+{
+	return !!(wed_r32(dev, reg) & mask);
+}
+
+static int
+mtk_wed_poll_busy(struct mtk_wed_device *dev, u32 reg, u32 mask)
+{
+	int sleep = 15000;
+	int timeout = 100 * sleep;
+	u32 val;
+
+	return read_poll_timeout(mtk_wed_check_busy, val, !val, sleep,
+				 timeout, false, dev, reg, mask);
+}
+
 static void
 mtk_wdma_tx_reset(struct mtk_wed_device *dev)
 {
@@ -335,6 +354,118 @@ mtk_wed_assign(struct mtk_wed_device *dev)
 	return hw;
 }
 
+static int
+mtk_wed_amsdu_buffer_alloc(struct mtk_wed_device *dev)
+{
+	struct mtk_wed_hw *hw = dev->hw;
+	struct mtk_wed_amsdu *wed_amsdu;
+	int i;
+
+	if (!mtk_wed_is_v3_or_greater(hw))
+		return 0;
+
+	wed_amsdu = devm_kcalloc(hw->dev, MTK_WED_AMSDU_NPAGES,
+				 sizeof(*wed_amsdu), GFP_KERNEL);
+	if (!wed_amsdu)
+		return -ENOMEM;
+
+	for (i = 0; i < MTK_WED_AMSDU_NPAGES; i++) {
+		void *ptr;
+
+		/* each segment is 64K */
+		ptr = (void *)__get_free_pages(GFP_KERNEL | __GFP_NOWARN |
+					       __GFP_ZERO | __GFP_COMP |
+					       GFP_DMA32,
+					       get_order(MTK_WED_AMSDU_BUF_SIZE));
+		if (!ptr)
+			goto error;
+
+		wed_amsdu[i].txd = ptr;
+		wed_amsdu[i].txd_phy = dma_map_single(hw->dev, ptr,
+						      MTK_WED_AMSDU_BUF_SIZE,
+						      DMA_TO_DEVICE);
+		if (dma_mapping_error(hw->dev, wed_amsdu[i].txd_phy))
+			goto error;
+	}
+	dev->hw->wed_amsdu = wed_amsdu;
+
+	return 0;
+
+error:
+	for (i--; i >= 0; i--)
+		dma_unmap_single(hw->dev, wed_amsdu[i].txd_phy,
+				 MTK_WED_AMSDU_BUF_SIZE, DMA_TO_DEVICE);
+	return -ENOMEM;
+}
+
+static void
+mtk_wed_amsdu_free_buffer(struct mtk_wed_device *dev)
+{
+	struct mtk_wed_amsdu *wed_amsdu = dev->hw->wed_amsdu;
+	int i;
+
+	if (!wed_amsdu)
+		return;
+
+	for (i = 0; i < MTK_WED_AMSDU_NPAGES; i++) {
+		dma_unmap_single(dev->hw->dev, wed_amsdu[i].txd_phy,
+				 MTK_WED_AMSDU_BUF_SIZE, DMA_TO_DEVICE);
+		free_pages((unsigned long)wed_amsdu[i].txd,
+			   get_order(MTK_WED_AMSDU_BUF_SIZE));
+	}
+}
+
+static int
+mtk_wed_amsdu_init(struct mtk_wed_device *dev)
+{
+	struct mtk_wed_amsdu *wed_amsdu = dev->hw->wed_amsdu;
+	int i, ret;
+
+	if (!wed_amsdu)
+		return 0;
+
+	for (i = 0; i < MTK_WED_AMSDU_NPAGES; i++)
+		wed_w32(dev, MTK_WED_AMSDU_HIFTXD_BASE_L(i),
+			wed_amsdu[i].txd_phy);
+
+	/* init all sta parameter */
+	wed_w32(dev, MTK_WED_AMSDU_STA_INFO_INIT, MTK_WED_AMSDU_STA_RMVL |
+		MTK_WED_AMSDU_STA_WTBL_HDRT_MODE |
+		FIELD_PREP(MTK_WED_AMSDU_STA_MAX_AMSDU_LEN,
+			   dev->wlan.amsdu_max_len >> 8) |
+		FIELD_PREP(MTK_WED_AMSDU_STA_MAX_AMSDU_NUM,
+			   dev->wlan.amsdu_max_subframes));
+
+	wed_w32(dev, MTK_WED_AMSDU_STA_INFO, MTK_WED_AMSDU_STA_INFO_DO_INIT);
+
+	ret = mtk_wed_poll_busy(dev, MTK_WED_AMSDU_STA_INFO,
+				MTK_WED_AMSDU_STA_INFO_DO_INIT);
+	if (ret) {
+		dev_err(dev->hw->dev, "amsdu initialization failed\n");
+		return ret;
+	}
+
+	/* init partial amsdu offload txd src */
+	wed_set(dev, MTK_WED_AMSDU_HIFTXD_CFG,
+		FIELD_PREP(MTK_WED_AMSDU_HIFTXD_SRC, dev->hw->index));
+
+	/* init qmem */
+	wed_set(dev, MTK_WED_AMSDU_PSE, MTK_WED_AMSDU_PSE_RESET);
+	ret = mtk_wed_poll_busy(dev, MTK_WED_MON_AMSDU_QMEM_STS1, BIT(29));
+	if (ret) {
+		pr_info("%s: amsdu qmem initialization failed\n", __func__);
+		return ret;
+	}
+
+	/* eagle E1 PCIE1 tx ring 22 flow control issue */
+	if (dev->wlan.id == 0x7991)
+		wed_clr(dev, MTK_WED_AMSDU_FIFO, MTK_WED_AMSDU_IS_PRIOR0_RING);
+
+	wed_set(dev, MTK_WED_CTRL, MTK_WED_CTRL_TX_AMSDU_EN);
+
+	return 0;
+}
+
 static int
 mtk_wed_tx_buffer_alloc(struct mtk_wed_device *dev)
 {
@@ -709,6 +840,7 @@ __mtk_wed_detach(struct mtk_wed_device *dev)
 
 	mtk_wdma_rx_reset(dev);
 	mtk_wed_reset(dev, MTK_WED_RESET_WED);
+	mtk_wed_amsdu_free_buffer(dev);
 	mtk_wed_free_tx_buffer(dev);
 	mtk_wed_free_tx_rings(dev);
 
@@ -1129,23 +1261,6 @@ mtk_wed_ring_reset(struct mtk_wed_ring *ring, int size, bool tx)
 	}
 }
 
-static u32
-mtk_wed_check_busy(struct mtk_wed_device *dev, u32 reg, u32 mask)
-{
-	return !!(wed_r32(dev, reg) & mask);
-}
-
-static int
-mtk_wed_poll_busy(struct mtk_wed_device *dev, u32 reg, u32 mask)
-{
-	int sleep = 15000;
-	int timeout = 100 * sleep;
-	u32 val;
-
-	return read_poll_timeout(mtk_wed_check_busy, val, !val, sleep,
-				 timeout, false, dev, reg, mask);
-}
-
 static int
 mtk_wed_rx_reset(struct mtk_wed_device *dev)
 {
@@ -1692,6 +1807,7 @@ mtk_wed_start(struct mtk_wed_device *dev, u32 irq_mask)
 	}
 
 	mtk_wed_set_512_support(dev, dev->wlan.wcid_512);
+	mtk_wed_amsdu_init(dev);
 
 	mtk_wed_dma_enable(dev);
 	dev->running = true;
@@ -1748,6 +1864,10 @@ mtk_wed_attach(struct mtk_wed_device *dev)
 	if (ret)
 		goto out;
 
+	ret = mtk_wed_amsdu_buffer_alloc(dev);
+	if (ret)
+		goto out;
+
 	if (mtk_wed_get_rx_capa(dev)) {
 		ret = mtk_wed_rro_alloc(dev);
 		if (ret)
diff --git a/drivers/net/ethernet/mediatek/mtk_wed.h b/drivers/net/ethernet/mediatek/mtk_wed.h
index 27d336db4d4d..c1f0479d7a71 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.h
+++ b/drivers/net/ethernet/mediatek/mtk_wed.h
@@ -25,6 +25,11 @@ struct mtk_wed_soc_data {
 	u32 wdma_desc_size;
 };
 
+struct mtk_wed_amsdu {
+	void *txd;
+	dma_addr_t txd_phy;
+};
+
 struct mtk_wed_hw {
 	const struct mtk_wed_soc_data *soc;
 	struct device_node *node;
@@ -38,6 +43,7 @@ struct mtk_wed_hw {
 	struct dentry *debugfs_dir;
 	struct mtk_wed_device *wed_dev;
 	struct mtk_wed_wo *wed_wo;
+	struct mtk_wed_amsdu *wed_amsdu;
 	u32 pcie_base;
 	u32 debugfs_reg;
 	u32 num_flows;
@@ -52,6 +58,7 @@ struct mtk_wdma_info {
 	u8 queue;
 	u16 wcid;
 	u8 bss;
+	u8 amsdu;
 };
 
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
diff --git a/drivers/net/ethernet/mediatek/mtk_wed_regs.h b/drivers/net/ethernet/mediatek/mtk_wed_regs.h
index a4d3cf64d090..5a7e4a11a54e 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_regs.h
+++ b/drivers/net/ethernet/mediatek/mtk_wed_regs.h
@@ -672,6 +672,82 @@ struct mtk_wdma_desc {
 #define MTK_WED_WOCPU_VIEW_MIOD_BASE			0x8000
 #define MTK_WED_PCIE_INT_MASK				0x0
 
+#define MTK_WED_AMSDU_FIFO				0x1800
+#define MTK_WED_AMSDU_IS_PRIOR0_RING			BIT(10)
+
+#define MTK_WED_AMSDU_STA_INFO				0x01810
+#define MTK_WED_AMSDU_STA_INFO_DO_INIT			BIT(0)
+#define MTK_WED_AMSDU_STA_INFO_SET_INIT			BIT(1)
+
+#define MTK_WED_AMSDU_STA_INFO_INIT			0x01814
+#define MTK_WED_AMSDU_STA_WTBL_HDRT_MODE		BIT(0)
+#define MTK_WED_AMSDU_STA_RMVL				BIT(1)
+#define MTK_WED_AMSDU_STA_MAX_AMSDU_LEN			GENMASK(7, 2)
+#define MTK_WED_AMSDU_STA_MAX_AMSDU_NUM			GENMASK(11, 8)
+
+#define MTK_WED_AMSDU_HIFTXD_BASE_L(_n)			(0x1980 + (_n) * 0x4)
+
+#define MTK_WED_AMSDU_PSE				0x1910
+#define MTK_WED_AMSDU_PSE_RESET				BIT(16)
+
+#define MTK_WED_AMSDU_HIFTXD_CFG			0x1968
+#define MTK_WED_AMSDU_HIFTXD_SRC			GENMASK(16, 15)
+
+#define MTK_WED_MON_AMSDU_FIFO_DMAD			0x1a34
+
+#define MTK_WED_MON_AMSDU_ENG_DMAD(_n)			(0x1a80 + (_n) * 0x50)
+#define MTK_WED_MON_AMSDU_ENG_QFPL(_n)			(0x1a84 + (_n) * 0x50)
+#define MTK_WED_MON_AMSDU_ENG_QENI(_n)			(0x1a88 + (_n) * 0x50)
+#define MTK_WED_MON_AMSDU_ENG_QENO(_n)			(0x1a8c + (_n) * 0x50)
+#define MTK_WED_MON_AMSDU_ENG_MERG(_n)			(0x1a90 + (_n) * 0x50)
+
+#define MTK_WED_MON_AMSDU_ENG_CNT8(_n)			(0x1a94 + (_n) * 0x50)
+#define MTK_WED_AMSDU_ENG_MAX_QGPP_CNT			GENMASK(10, 0)
+#define MTK_WED_AMSDU_ENG_MAX_PL_CNT			GENMASK(27, 16)
+
+#define MTK_WED_MON_AMSDU_ENG_CNT9(_n)			(0x1a98 + (_n) * 0x50)
+#define MTK_WED_AMSDU_ENG_CUR_ENTRY			GENMASK(10, 0)
+#define MTK_WED_AMSDU_ENG_MAX_BUF_MERGED		GENMASK(20, 16)
+#define MTK_WED_AMSDU_ENG_MAX_MSDU_MERGED		GENMASK(28, 24)
+
+#define MTK_WED_MON_AMSDU_QMEM_STS1			0x1e04
+
+#define MTK_WED_MON_AMSDU_QMEM_CNT(_n)			(0x1e0c + (_n) * 0x4)
+#define MTK_WED_AMSDU_QMEM_FQ_CNT			GENMASK(27, 16)
+#define MTK_WED_AMSDU_QMEM_SP_QCNT			GENMASK(11, 0)
+#define MTK_WED_AMSDU_QMEM_TID0_QCNT			GENMASK(27, 16)
+#define MTK_WED_AMSDU_QMEM_TID1_QCNT			GENMASK(11, 0)
+#define MTK_WED_AMSDU_QMEM_TID2_QCNT			GENMASK(27, 16)
+#define MTK_WED_AMSDU_QMEM_TID3_QCNT			GENMASK(11, 0)
+#define MTK_WED_AMSDU_QMEM_TID4_QCNT			GENMASK(27, 16)
+#define MTK_WED_AMSDU_QMEM_TID5_QCNT			GENMASK(11, 0)
+#define MTK_WED_AMSDU_QMEM_TID6_QCNT			GENMASK(27, 16)
+#define MTK_WED_AMSDU_QMEM_TID7_QCNT			GENMASK(11, 0)
+
+#define MTK_WED_MON_AMSDU_QMEM_PTR(_n)			(0x1e20 + (_n) * 0x4)
+#define MTK_WED_AMSDU_QMEM_FQ_HEAD			GENMASK(27, 16)
+#define MTK_WED_AMSDU_QMEM_SP_QHEAD			GENMASK(11, 0)
+#define MTK_WED_AMSDU_QMEM_TID0_QHEAD			GENMASK(27, 16)
+#define MTK_WED_AMSDU_QMEM_TID1_QHEAD			GENMASK(11, 0)
+#define MTK_WED_AMSDU_QMEM_TID2_QHEAD			GENMASK(27, 16)
+#define MTK_WED_AMSDU_QMEM_TID3_QHEAD			GENMASK(11, 0)
+#define MTK_WED_AMSDU_QMEM_TID4_QHEAD			GENMASK(27, 16)
+#define MTK_WED_AMSDU_QMEM_TID5_QHEAD			GENMASK(11, 0)
+#define MTK_WED_AMSDU_QMEM_TID6_QHEAD			GENMASK(27, 16)
+#define MTK_WED_AMSDU_QMEM_TID7_QHEAD			GENMASK(11, 0)
+#define MTK_WED_AMSDU_QMEM_FQ_TAIL			GENMASK(27, 16)
+#define MTK_WED_AMSDU_QMEM_SP_QTAIL			GENMASK(11, 0)
+#define MTK_WED_AMSDU_QMEM_TID0_QTAIL			GENMASK(27, 16)
+#define MTK_WED_AMSDU_QMEM_TID1_QTAIL			GENMASK(11, 0)
+#define MTK_WED_AMSDU_QMEM_TID2_QTAIL			GENMASK(27, 16)
+#define MTK_WED_AMSDU_QMEM_TID3_QTAIL			GENMASK(11, 0)
+#define MTK_WED_AMSDU_QMEM_TID4_QTAIL			GENMASK(27, 16)
+#define MTK_WED_AMSDU_QMEM_TID5_QTAIL			GENMASK(11, 0)
+#define MTK_WED_AMSDU_QMEM_TID6_QTAIL			GENMASK(27, 16)
+#define MTK_WED_AMSDU_QMEM_TID7_QTAIL			GENMASK(11, 0)
+
+#define MTK_WED_MON_AMSDU_HIFTXD_FETCH_MSDU(_n)		(0x1ec4 + (_n) * 0x4)
+
 #define MTK_WED_PCIE_BASE			0x11280000
 #define MTK_WED_PCIE_BASE0			0x11300000
 #define MTK_WED_PCIE_BASE1			0x11310000
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index db3d8429d50d..7e520c14eb8c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -919,6 +919,7 @@ struct net_device_path {
 			u8 queue;
 			u16 wcid;
 			u8 bss;
+			u8 amsdu;
 		} mtk_wdma;
 	};
 };
diff --git a/include/linux/soc/mediatek/mtk_wed.h b/include/linux/soc/mediatek/mtk_wed.h
index 5b096f9f1975..90d9c9ead3bc 100644
--- a/include/linux/soc/mediatek/mtk_wed.h
+++ b/include/linux/soc/mediatek/mtk_wed.h
@@ -128,6 +128,7 @@ struct mtk_wed_device {
 		enum mtk_wed_bus_tye bus_type;
 		void __iomem *base;
 		u32 phy_base;
+		u32 id;
 
 		u32 wpdma_phys;
 		u32 wpdma_int;
@@ -146,10 +147,12 @@ struct mtk_wed_device {
 		unsigned int rx_nbuf;
 		unsigned int rx_npkt;
 		unsigned int rx_size;
+		unsigned int amsdu_max_len;
 
 		u8 tx_tbit[MTK_WED_TX_QUEUES];
 		u8 rx_tbit[MTK_WED_RX_QUEUES];
 		u8 txfree_tbit;
+		u8 amsdu_max_subframes;
 
 		u32 (*init_buf)(void *ptr, dma_addr_t phys, int token_id);
 		int (*offload_enable)(struct mtk_wed_device *wed);
@@ -225,6 +228,15 @@ static inline bool mtk_wed_get_rx_capa(struct mtk_wed_device *dev)
 #endif
 }
 
+static inline bool mtk_wed_is_amsdu_supported(struct mtk_wed_device *dev)
+{
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+	return dev->version == 3;
+#else
+	return false;
+#endif
+}
+
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
 #define mtk_wed_device_active(_dev) !!(_dev)->ops
 #define mtk_wed_device_detach(_dev) (_dev)->ops->detach(_dev)
-- 
2.41.0


