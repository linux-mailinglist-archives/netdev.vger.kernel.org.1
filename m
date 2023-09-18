Return-Path: <netdev+bounces-34511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 396677A4708
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 12:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6027E1C20B76
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 10:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F04E1D53C;
	Mon, 18 Sep 2023 10:30:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F621CAAD;
	Mon, 18 Sep 2023 10:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A69C433CB;
	Mon, 18 Sep 2023 10:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695033009;
	bh=L/ZXfIpsr0xPWE08/jHzg/V9tOJisy1CFvRHjbhY3TY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jUKNzwk+aBm5rZiKUNPBhuITRwY1twIuPOEzQh0W9Ci+P6NsmHvttigSZAdyhKMqL
	 PlJszDWKJMvB1sK4FD6tROcC4zQMODG43IFoX0CIwQKknsIk7ue0OIsZsc6wih7yO4
	 zZZHhPNCo6dyVNfDe45Fh5M+JJ1fi2arW80HjD7I4RCWVGowShptHFx0o5BUFwivIK
	 nlcTJPODlENwuK7qtKxg7jSasHNHOtXuPsJ3QV316ZmDXzv8zaSBZY8PZHdwuJHBRa
	 BaHtxvrUYZDba4FlnYqWThVpKoN2rbn8bWMw8SCnAViYP/NaLB/37GCa9F9zWbvkZW
	 plbWW7plKB5MQ==
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
Subject: [PATCH v2 net-next 04/17] net: ethernet: mtk_wed: do not configure rx offload if not supported
Date: Mon, 18 Sep 2023 12:29:06 +0200
Message-ID: <20df029812d57949fb49f5aa6fd4156182dd7cef.1695032291.git.lorenzo@kernel.org>
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

Check if rx offload is supported running mtk_wed_get_rx_capa routine
before configuring it. This is a preliminary patch to introduce Wireless
Ethernet Dispatcher (WED) support for MT7988 SoC.

Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_wed.c     | 126 +++++++++++---------
 drivers/net/ethernet/mediatek/mtk_wed_mcu.c |   2 +-
 2 files changed, 70 insertions(+), 58 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index ce1ca98ea1d6..750326b298dc 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -606,7 +606,7 @@ mtk_wed_stop(struct mtk_wed_device *dev)
 	wdma_w32(dev, MTK_WDMA_INT_GRP2, 0);
 	wed_w32(dev, MTK_WED_WPDMA_INT_MASK, 0);
 
-	if (mtk_wed_is_v1(dev->hw))
+	if (!mtk_wed_get_rx_capa(dev))
 		return;
 
 	wed_w32(dev, MTK_WED_EXT_INT_MASK1, 0);
@@ -733,16 +733,21 @@ mtk_wed_set_wpdma(struct mtk_wed_device *dev)
 {
 	if (mtk_wed_is_v1(dev->hw)) {
 		wed_w32(dev, MTK_WED_WPDMA_CFG_BASE,  dev->wlan.wpdma_phys);
-	} else {
-		mtk_wed_bus_init(dev);
-
-		wed_w32(dev, MTK_WED_WPDMA_CFG_BASE, dev->wlan.wpdma_int);
-		wed_w32(dev, MTK_WED_WPDMA_CFG_INT_MASK, dev->wlan.wpdma_mask);
-		wed_w32(dev, MTK_WED_WPDMA_CFG_TX, dev->wlan.wpdma_tx);
-		wed_w32(dev, MTK_WED_WPDMA_CFG_TX_FREE, dev->wlan.wpdma_txfree);
-		wed_w32(dev, MTK_WED_WPDMA_RX_GLO_CFG, dev->wlan.wpdma_rx_glo);
-		wed_w32(dev, MTK_WED_WPDMA_RX_RING, dev->wlan.wpdma_rx);
+		return;
 	}
+
+	mtk_wed_bus_init(dev);
+
+	wed_w32(dev, MTK_WED_WPDMA_CFG_BASE, dev->wlan.wpdma_int);
+	wed_w32(dev, MTK_WED_WPDMA_CFG_INT_MASK, dev->wlan.wpdma_mask);
+	wed_w32(dev, MTK_WED_WPDMA_CFG_TX, dev->wlan.wpdma_tx);
+	wed_w32(dev, MTK_WED_WPDMA_CFG_TX_FREE, dev->wlan.wpdma_txfree);
+
+	if (!mtk_wed_get_rx_capa(dev))
+		return;
+
+	wed_w32(dev, MTK_WED_WPDMA_RX_GLO_CFG, dev->wlan.wpdma_rx_glo);
+	wed_w32(dev, MTK_WED_WPDMA_RX_RING, dev->wlan.wpdma_rx);
 }
 
 static void
@@ -974,15 +979,17 @@ mtk_wed_hw_init(struct mtk_wed_device *dev)
 			MTK_WED_CTRL_WED_TX_FREE_AGENT_EN);
 	} else {
 		wed_clr(dev, MTK_WED_TX_TKID_CTRL, MTK_WED_TX_TKID_CTRL_PAUSE);
-		/* rx hw init */
-		wed_w32(dev, MTK_WED_WPDMA_RX_D_RST_IDX,
-			MTK_WED_WPDMA_RX_D_RST_CRX_IDX |
-			MTK_WED_WPDMA_RX_D_RST_DRV_IDX);
-		wed_w32(dev, MTK_WED_WPDMA_RX_D_RST_IDX, 0);
-
-		mtk_wed_rx_buffer_hw_init(dev);
-		mtk_wed_rro_hw_init(dev);
-		mtk_wed_route_qm_hw_init(dev);
+		if (mtk_wed_get_rx_capa(dev)) {
+			/* rx hw init */
+			wed_w32(dev, MTK_WED_WPDMA_RX_D_RST_IDX,
+				MTK_WED_WPDMA_RX_D_RST_CRX_IDX |
+				MTK_WED_WPDMA_RX_D_RST_DRV_IDX);
+			wed_w32(dev, MTK_WED_WPDMA_RX_D_RST_IDX, 0);
+
+			mtk_wed_rx_buffer_hw_init(dev);
+			mtk_wed_rro_hw_init(dev);
+			mtk_wed_route_qm_hw_init(dev);
+		}
 	}
 
 	wed_clr(dev, MTK_WED_TX_BM_CTRL, MTK_WED_TX_BM_CTRL_PAUSE);
@@ -1354,8 +1361,6 @@ mtk_wed_configure_irq(struct mtk_wed_device *dev, u32 irq_mask)
 
 		wed_clr(dev, MTK_WED_WDMA_INT_CTRL, wdma_mask);
 	} else {
-		wdma_mask |= FIELD_PREP(MTK_WDMA_INT_MASK_TX_DONE,
-					GENMASK(1, 0));
 		/* initail tx interrupt trigger */
 		wed_w32(dev, MTK_WED_WPDMA_INT_CTRL_TX,
 			MTK_WED_WPDMA_INT_CTRL_TX0_DONE_EN |
@@ -1374,15 +1379,20 @@ mtk_wed_configure_irq(struct mtk_wed_device *dev, u32 irq_mask)
 			FIELD_PREP(MTK_WED_WPDMA_INT_CTRL_TX_FREE_DONE_TRIG,
 				   dev->wlan.txfree_tbit));
 
-		wed_w32(dev, MTK_WED_WPDMA_INT_CTRL_RX,
-			MTK_WED_WPDMA_INT_CTRL_RX0_EN |
-			MTK_WED_WPDMA_INT_CTRL_RX0_CLR |
-			MTK_WED_WPDMA_INT_CTRL_RX1_EN |
-			MTK_WED_WPDMA_INT_CTRL_RX1_CLR |
-			FIELD_PREP(MTK_WED_WPDMA_INT_CTRL_RX0_DONE_TRIG,
-				   dev->wlan.rx_tbit[0]) |
-			FIELD_PREP(MTK_WED_WPDMA_INT_CTRL_RX1_DONE_TRIG,
-				   dev->wlan.rx_tbit[1]));
+		if (mtk_wed_get_rx_capa(dev)) {
+			wed_w32(dev, MTK_WED_WPDMA_INT_CTRL_RX,
+				MTK_WED_WPDMA_INT_CTRL_RX0_EN |
+				MTK_WED_WPDMA_INT_CTRL_RX0_CLR |
+				MTK_WED_WPDMA_INT_CTRL_RX1_EN |
+				MTK_WED_WPDMA_INT_CTRL_RX1_CLR |
+				FIELD_PREP(MTK_WED_WPDMA_INT_CTRL_RX0_DONE_TRIG,
+					   dev->wlan.rx_tbit[0]) |
+				FIELD_PREP(MTK_WED_WPDMA_INT_CTRL_RX1_DONE_TRIG,
+					   dev->wlan.rx_tbit[1]));
+
+			wdma_mask |= FIELD_PREP(MTK_WDMA_INT_MASK_TX_DONE,
+						GENMASK(1, 0));
+		}
 
 		wed_w32(dev, MTK_WED_WDMA_INT_CLR, wdma_mask);
 		wed_set(dev, MTK_WED_WDMA_INT_CTRL,
@@ -1401,6 +1411,8 @@ mtk_wed_configure_irq(struct mtk_wed_device *dev, u32 irq_mask)
 static void
 mtk_wed_dma_enable(struct mtk_wed_device *dev)
 {
+	int i;
+
 	wed_set(dev, MTK_WED_WPDMA_INT_CTRL, MTK_WED_WPDMA_INT_CTRL_SUBRT_ADV);
 
 	wed_set(dev, MTK_WED_GLO_CFG,
@@ -1420,33 +1432,33 @@ mtk_wed_dma_enable(struct mtk_wed_device *dev)
 	if (mtk_wed_is_v1(dev->hw)) {
 		wdma_set(dev, MTK_WDMA_GLO_CFG,
 			 MTK_WDMA_GLO_CFG_RX_INFO3_PRERES);
-	} else {
-		int i;
-
-		wed_set(dev, MTK_WED_WPDMA_CTRL,
-			MTK_WED_WPDMA_CTRL_SDL1_FIXED);
+		return;
+	}
 
-		wed_set(dev, MTK_WED_WDMA_GLO_CFG,
-			MTK_WED_WDMA_GLO_CFG_TX_DRV_EN |
-			MTK_WED_WDMA_GLO_CFG_TX_DDONE_CHK);
+	wed_set(dev, MTK_WED_WPDMA_CTRL,
+		MTK_WED_WPDMA_CTRL_SDL1_FIXED);
+	wed_set(dev, MTK_WED_WPDMA_GLO_CFG,
+		MTK_WED_WPDMA_GLO_CFG_RX_DRV_R0_PKT_PROC |
+		MTK_WED_WPDMA_GLO_CFG_RX_DRV_R0_CRX_SYNC);
+	wed_clr(dev, MTK_WED_WPDMA_GLO_CFG,
+		MTK_WED_WPDMA_GLO_CFG_TX_TKID_KEEP |
+		MTK_WED_WPDMA_GLO_CFG_TX_DMAD_DW3_PREV);
 
-		wed_set(dev, MTK_WED_WPDMA_GLO_CFG,
-			MTK_WED_WPDMA_GLO_CFG_RX_DRV_R0_PKT_PROC |
-			MTK_WED_WPDMA_GLO_CFG_RX_DRV_R0_CRX_SYNC);
+	if (!mtk_wed_get_rx_capa(dev))
+		return;
 
-		wed_clr(dev, MTK_WED_WPDMA_GLO_CFG,
-			MTK_WED_WPDMA_GLO_CFG_TX_TKID_KEEP |
-			MTK_WED_WPDMA_GLO_CFG_TX_DMAD_DW3_PREV);
+	wed_set(dev, MTK_WED_WDMA_GLO_CFG,
+		MTK_WED_WDMA_GLO_CFG_TX_DRV_EN |
+		MTK_WED_WDMA_GLO_CFG_TX_DDONE_CHK);
 
-		wed_set(dev, MTK_WED_WPDMA_RX_D_GLO_CFG,
-			MTK_WED_WPDMA_RX_D_RX_DRV_EN |
-			FIELD_PREP(MTK_WED_WPDMA_RX_D_RXD_READ_LEN, 0x18) |
-			FIELD_PREP(MTK_WED_WPDMA_RX_D_INIT_PHASE_RXEN_SEL,
-				   0x2));
+	wed_set(dev, MTK_WED_WPDMA_RX_D_GLO_CFG,
+		MTK_WED_WPDMA_RX_D_RX_DRV_EN |
+		FIELD_PREP(MTK_WED_WPDMA_RX_D_RXD_READ_LEN, 0x18) |
+		FIELD_PREP(MTK_WED_WPDMA_RX_D_INIT_PHASE_RXEN_SEL,
+			   0x2));
 
-		for (i = 0; i < MTK_WED_RX_QUEUES; i++)
-			mtk_wed_check_wfdma_rx_fill(dev, i);
-	}
+	for (i = 0; i < MTK_WED_RX_QUEUES; i++)
+		mtk_wed_check_wfdma_rx_fill(dev, i);
 }
 
 static void
@@ -1473,7 +1485,7 @@ mtk_wed_start(struct mtk_wed_device *dev, u32 irq_mask)
 
 		val |= BIT(0) | (BIT(1) * !!dev->hw->index);
 		regmap_write(dev->hw->mirror, dev->hw->index * 4, val);
-	} else {
+	} else if (mtk_wed_get_rx_capa(dev)) {
 		/* driver set mid ready and only once */
 		wed_w32(dev, MTK_WED_EXT_INT_MASK1,
 			MTK_WED_EXT_INT_STATUS_WPDMA_MID_RDY);
@@ -1485,7 +1497,6 @@ mtk_wed_start(struct mtk_wed_device *dev, u32 irq_mask)
 
 		if (mtk_wed_rro_cfg(dev))
 			return;
-
 	}
 
 	mtk_wed_set_512_support(dev, dev->wlan.wcid_512);
@@ -1551,13 +1562,14 @@ mtk_wed_attach(struct mtk_wed_device *dev)
 	}
 
 	mtk_wed_hw_init_early(dev);
-	if (mtk_wed_is_v1(hw)) {
+	if (mtk_wed_is_v1(hw))
 		regmap_update_bits(hw->hifsys, HIFSYS_DMA_AG_MAP,
 				   BIT(hw->index), 0);
-	} else {
+	else
 		dev->rev_id = wed_r32(dev, MTK_WED_REV_ID);
+
+	if (mtk_wed_get_rx_capa(dev))
 		ret = mtk_wed_wo_init(hw);
-	}
 out:
 	if (ret) {
 		dev_err(dev->hw->dev, "failed to attach wed device\n");
diff --git a/drivers/net/ethernet/mediatek/mtk_wed_mcu.c b/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
index 8216403e5834..4e48905ac70d 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
@@ -207,7 +207,7 @@ int mtk_wed_mcu_msg_update(struct mtk_wed_device *dev, int id, void *data,
 {
 	struct mtk_wed_wo *wo = dev->hw->wed_wo;
 
-	if (mtk_wed_is_v1(dev->hw))
+	if (!mtk_wed_get_rx_capa(dev))
 		return 0;
 
 	if (WARN_ON(!wo))
-- 
2.41.0


