Return-Path: <netdev+bounces-33864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F371B7A07EC
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 16:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE97281B7D
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 14:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85B7219E3;
	Thu, 14 Sep 2023 14:39:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F092137A;
	Thu, 14 Sep 2023 14:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5747C433C8;
	Thu, 14 Sep 2023 14:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694702390;
	bh=pdNAyyWoHcPfZPFOImFhDdd+CXIxgjMrheWwMocSdGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rzPzWRoGVvuvniyzNWIbBjubfdWysnp5iMNgFhbJoUEqQWFFK+rwMgfM74k8+jxNv
	 5+umePkV47dgFUkknvZX8m0/j04B8U5uSr3FymaEXvCHhLG6kLQERqNvmBrv3Hqtp/
	 sco96PwiV4lV5tgTQwX0jcJXVPuhXv8IQRRLnrIBHdNK6B29H19DwtNd3BJn6+pdPo
	 NGVJnIqDkIZSYRgDQmFgRZs4NDrHkDk9g/zNvJ3wLrmrjkF4lunpM1Wz2frjM/z09V
	 FeG9cMgaAV8TWxl61SQl9K+VOhjrI0+uBrbl/hyakK5AlwIPg7P1FD207ZeIrXAAMS
	 ZJWBhEjWZEyzA==
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
Subject: [PATCH net-next 11/15] net: ethernet: mtk_wed: refactor mtk_wed_check_wfdma_rx_fill routine
Date: Thu, 14 Sep 2023 16:38:16 +0200
Message-ID: <7cc25d625181a5a73c8dab3f79fff310de95b7c3.1694701767.git.lorenzo@kernel.org>
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

Refactor mtk_wed_check_wfdma_rx_fill() in order to be reused adding HW
receive offload support for MT7988 SoC.

Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_wed.c | 44 +++++++++++++++----------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 0d8e10df9da2..ad7cd6c88d64 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -554,22 +554,15 @@ mtk_wed_set_512_support(struct mtk_wed_device *dev, bool enable)
 	}
 }
 
-#define MTK_WFMDA_RX_DMA_EN	BIT(2)
-static void
-mtk_wed_check_wfdma_rx_fill(struct mtk_wed_device *dev, int idx)
+static int
+mtk_wed_check_wfdma_rx_fill(struct mtk_wed_device *dev,
+			    struct mtk_wed_ring *ring)
 {
-	u32 val;
 	int i;
 
-	if (!(dev->rx_ring[idx].flags & MTK_WED_RING_CONFIGURED))
-		return; /* queue is not configured by mt76 */
-
 	for (i = 0; i < 3; i++) {
-		u32 cur_idx;
+		u32 cur_idx = readl(ring->wpdma + MTK_WED_RING_OFS_CPU_IDX);
 
-		cur_idx = wed_r32(dev,
-				  MTK_WED_WPDMA_RING_RX_DATA(idx) +
-				  MTK_WED_RING_OFS_CPU_IDX);
 		if (cur_idx == MTK_WED_RX_RING_SIZE - 1)
 			break;
 
@@ -578,12 +571,10 @@ mtk_wed_check_wfdma_rx_fill(struct mtk_wed_device *dev, int idx)
 
 	if (i == 3) {
 		dev_err(dev->hw->dev, "rx dma enable failed\n");
-		return;
+		return -ETIMEDOUT;
 	}
 
-	val = wifi_r32(dev, dev->wlan.wpdma_rx_glo - dev->wlan.phy_base) |
-	      MTK_WFMDA_RX_DMA_EN;
-	wifi_w32(dev, dev->wlan.wpdma_rx_glo - dev->wlan.phy_base, val);
+	return 0;
 }
 
 static void
@@ -1546,6 +1537,7 @@ mtk_wed_configure_irq(struct mtk_wed_device *dev, u32 irq_mask)
 	wed_w32(dev, MTK_WED_INT_MASK, irq_mask);
 }
 
+#define MTK_WFMDA_RX_DMA_EN	BIT(2)
 static void
 mtk_wed_dma_enable(struct mtk_wed_device *dev)
 {
@@ -1633,8 +1625,26 @@ mtk_wed_dma_enable(struct mtk_wed_device *dev)
 		wdma_set(dev, MTK_WDMA_WRBK_TX_CFG, MTK_WDMA_WRBK_TX_CFG_WRBK_EN);
 	}
 
-	for (i = 0; i < MTK_WED_RX_QUEUES; i++)
-		mtk_wed_check_wfdma_rx_fill(dev, i);
+	for (i = 0; i < MTK_WED_RX_QUEUES; i++) {
+		struct mtk_wed_ring *ring = &dev->rx_ring[i];
+		u32 val;
+
+		if (!(ring->flags & MTK_WED_RING_CONFIGURED))
+			continue; /* queue is not configured by mt76 */
+
+		if (mtk_wed_check_wfdma_rx_fill(dev, ring)) {
+			dev_err(dev->hw->dev,
+				"rx_ring(%d) dma enable failed\n", i);
+			continue;
+		}
+
+		val = wifi_r32(dev,
+			       dev->wlan.wpdma_rx_glo -
+			       dev->wlan.phy_base) | MTK_WFMDA_RX_DMA_EN;
+		wifi_w32(dev,
+			 dev->wlan.wpdma_rx_glo - dev->wlan.phy_base,
+			 val);
+	}
 }
 
 static void
-- 
2.41.0


