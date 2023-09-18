Return-Path: <netdev+bounces-34524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F27017A474E
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 12:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6283281814
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 10:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4541210F3;
	Mon, 18 Sep 2023 10:30:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C595A328C8;
	Mon, 18 Sep 2023 10:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48814C433C8;
	Mon, 18 Sep 2023 10:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695033057;
	bh=YZs1XJfFuWZA9VRK32Cru3UJQlK2w2xfeBUQ4+exUiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QyZircFa/Z36MdLlfPpbJbzkQu+y2oIylUT7enGE9tng6DPQu4n8OEzZxuZoqaCvu
	 5B3cSxHAtu3FuO/OX9TsxYPgRN1Ki9oX5X9DpK5DSfekY+gDud8GKlnQi+xOIKVov+
	 8hDwvbUYW7WfKxkDNrdlVyQTwGuN/saQgolhwf+n9TD1v8UCKOTn6B6obIXZ/pDQRE
	 gB0CCfeXrhAQhwGJoXFF/V1+eLGrbwNSN1kxw5bENXp88N05pQKrwpN2CJHESUestT
	 ueM8pJQzrUCCDO3pMv8njMBCv/YsG2gHjKuMLzT184DAyyIzJEfGs5rs7/PVUv8GgX
	 wHF+YW8e9SEMg==
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
Subject: [PATCH v2 net-next 17/17] net: ethernet: mtk_wed: add wed 3.0 reset support
Date: Mon, 18 Sep 2023 12:29:19 +0200
Message-ID: <6cdf97939521aaccd63a4ea62d9c75d108361009.1695032291.git.lorenzo@kernel.org>
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

Introduce support for resetting Wireless Ethernet Dispatcher 3.0
available on MT988 SoC.

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
---
 drivers/net/ethernet/mediatek/mtk_wed.c      | 289 ++++++++++++++++++-
 drivers/net/ethernet/mediatek/mtk_wed_regs.h |  60 ++++
 2 files changed, 339 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 2a0be1f2d43e..9a6744c0d458 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -149,6 +149,90 @@ mtk_wdma_read_reset(struct mtk_wed_device *dev)
 	return wdma_r32(dev, MTK_WDMA_GLO_CFG);
 }
 
+static void
+mtk_wdma_v3_rx_reset(struct mtk_wed_device *dev)
+{
+	u32 status;
+
+	if (!mtk_wed_is_v3_or_greater(dev->hw))
+		return;
+
+	wdma_clr(dev, MTK_WDMA_PREF_TX_CFG, MTK_WDMA_PREF_TX_CFG_PREF_EN);
+	wdma_clr(dev, MTK_WDMA_PREF_RX_CFG, MTK_WDMA_PREF_RX_CFG_PREF_EN);
+
+	if (read_poll_timeout(wdma_r32, status,
+			      !(status & MTK_WDMA_PREF_TX_CFG_PREF_BUSY),
+			      0, 10000, false, dev, MTK_WDMA_PREF_TX_CFG))
+		dev_err(dev->hw->dev, "rx reset failed\n");
+
+	if (read_poll_timeout(wdma_r32, status,
+			      !(status & MTK_WDMA_PREF_RX_CFG_PREF_BUSY),
+			      0, 10000, false, dev, MTK_WDMA_PREF_RX_CFG))
+		dev_err(dev->hw->dev, "rx reset failed\n");
+
+	wdma_clr(dev, MTK_WDMA_WRBK_TX_CFG, MTK_WDMA_WRBK_TX_CFG_WRBK_EN);
+	wdma_clr(dev, MTK_WDMA_WRBK_RX_CFG, MTK_WDMA_WRBK_RX_CFG_WRBK_EN);
+
+	if (read_poll_timeout(wdma_r32, status,
+			      !(status & MTK_WDMA_WRBK_TX_CFG_WRBK_BUSY),
+			      0, 10000, false, dev, MTK_WDMA_WRBK_TX_CFG))
+		dev_err(dev->hw->dev, "rx reset failed\n");
+
+	if (read_poll_timeout(wdma_r32, status,
+			      !(status & MTK_WDMA_WRBK_RX_CFG_WRBK_BUSY),
+			      0, 10000, false, dev, MTK_WDMA_WRBK_RX_CFG))
+		dev_err(dev->hw->dev, "rx reset failed\n");
+
+	/* prefetch FIFO */
+	wdma_w32(dev, MTK_WDMA_PREF_RX_FIFO_CFG,
+		 MTK_WDMA_PREF_RX_FIFO_CFG_RING0_CLEAR |
+		 MTK_WDMA_PREF_RX_FIFO_CFG_RING1_CLEAR);
+	wdma_clr(dev, MTK_WDMA_PREF_RX_FIFO_CFG,
+		 MTK_WDMA_PREF_RX_FIFO_CFG_RING0_CLEAR |
+		 MTK_WDMA_PREF_RX_FIFO_CFG_RING1_CLEAR);
+
+	/* core FIFO */
+	wdma_w32(dev, MTK_WDMA_XDMA_RX_FIFO_CFG,
+		 MTK_WDMA_XDMA_RX_FIFO_CFG_RX_PAR_FIFO_CLEAR |
+		 MTK_WDMA_XDMA_RX_FIFO_CFG_RX_CMD_FIFO_CLEAR |
+		 MTK_WDMA_XDMA_RX_FIFO_CFG_RX_DMAD_FIFO_CLEAR |
+		 MTK_WDMA_XDMA_RX_FIFO_CFG_RX_ARR_FIFO_CLEAR |
+		 MTK_WDMA_XDMA_RX_FIFO_CFG_RX_LEN_FIFO_CLEAR |
+		 MTK_WDMA_XDMA_RX_FIFO_CFG_RX_WID_FIFO_CLEAR |
+		 MTK_WDMA_XDMA_RX_FIFO_CFG_RX_BID_FIFO_CLEAR);
+	wdma_clr(dev, MTK_WDMA_XDMA_RX_FIFO_CFG,
+		 MTK_WDMA_XDMA_RX_FIFO_CFG_RX_PAR_FIFO_CLEAR |
+		 MTK_WDMA_XDMA_RX_FIFO_CFG_RX_CMD_FIFO_CLEAR |
+		 MTK_WDMA_XDMA_RX_FIFO_CFG_RX_DMAD_FIFO_CLEAR |
+		 MTK_WDMA_XDMA_RX_FIFO_CFG_RX_ARR_FIFO_CLEAR |
+		 MTK_WDMA_XDMA_RX_FIFO_CFG_RX_LEN_FIFO_CLEAR |
+		 MTK_WDMA_XDMA_RX_FIFO_CFG_RX_WID_FIFO_CLEAR |
+		 MTK_WDMA_XDMA_RX_FIFO_CFG_RX_BID_FIFO_CLEAR);
+
+	/* writeback FIFO */
+	wdma_w32(dev, MTK_WDMA_WRBK_RX_FIFO_CFG(0),
+		 MTK_WDMA_WRBK_RX_FIFO_CFG_RING_CLEAR);
+	wdma_w32(dev, MTK_WDMA_WRBK_RX_FIFO_CFG(1),
+		 MTK_WDMA_WRBK_RX_FIFO_CFG_RING_CLEAR);
+
+	wdma_clr(dev, MTK_WDMA_WRBK_RX_FIFO_CFG(0),
+		 MTK_WDMA_WRBK_RX_FIFO_CFG_RING_CLEAR);
+	wdma_clr(dev, MTK_WDMA_WRBK_RX_FIFO_CFG(1),
+		 MTK_WDMA_WRBK_RX_FIFO_CFG_RING_CLEAR);
+
+	/* prefetch ring status */
+	wdma_w32(dev, MTK_WDMA_PREF_SIDX_CFG,
+		 MTK_WDMA_PREF_SIDX_CFG_RX_RING_CLEAR);
+	wdma_clr(dev, MTK_WDMA_PREF_SIDX_CFG,
+		 MTK_WDMA_PREF_SIDX_CFG_RX_RING_CLEAR);
+
+	/* writeback ring status */
+	wdma_w32(dev, MTK_WDMA_WRBK_SIDX_CFG,
+		 MTK_WDMA_WRBK_SIDX_CFG_RX_RING_CLEAR);
+	wdma_clr(dev, MTK_WDMA_WRBK_SIDX_CFG,
+		 MTK_WDMA_WRBK_SIDX_CFG_RX_RING_CLEAR);
+}
+
 static int
 mtk_wdma_rx_reset(struct mtk_wed_device *dev)
 {
@@ -161,6 +245,7 @@ mtk_wdma_rx_reset(struct mtk_wed_device *dev)
 	if (ret)
 		dev_err(dev->hw->dev, "rx reset failed\n");
 
+	mtk_wdma_v3_rx_reset(dev);
 	wdma_w32(dev, MTK_WDMA_RESET_IDX, MTK_WDMA_RESET_IDX_RX);
 	wdma_w32(dev, MTK_WDMA_RESET_IDX, 0);
 
@@ -192,6 +277,84 @@ mtk_wed_poll_busy(struct mtk_wed_device *dev, u32 reg, u32 mask)
 				 timeout, false, dev, reg, mask);
 }
 
+static void
+mtk_wdma_v3_tx_reset(struct mtk_wed_device *dev)
+{
+	u32 status;
+
+	if (!mtk_wed_is_v3_or_greater(dev->hw))
+		return;
+
+	wdma_clr(dev, MTK_WDMA_PREF_TX_CFG, MTK_WDMA_PREF_TX_CFG_PREF_EN);
+	wdma_clr(dev, MTK_WDMA_PREF_RX_CFG, MTK_WDMA_PREF_RX_CFG_PREF_EN);
+
+	if (read_poll_timeout(wdma_r32, status,
+			      !(status & MTK_WDMA_PREF_TX_CFG_PREF_BUSY),
+			      0, 10000, false, dev, MTK_WDMA_PREF_TX_CFG))
+		dev_err(dev->hw->dev, "tx reset failed\n");
+
+	if (read_poll_timeout(wdma_r32, status,
+			      !(status & MTK_WDMA_PREF_RX_CFG_PREF_BUSY),
+			      0, 10000, false, dev, MTK_WDMA_PREF_RX_CFG))
+		dev_err(dev->hw->dev, "tx reset failed\n");
+
+	wdma_clr(dev, MTK_WDMA_WRBK_TX_CFG, MTK_WDMA_WRBK_TX_CFG_WRBK_EN);
+	wdma_clr(dev, MTK_WDMA_WRBK_RX_CFG, MTK_WDMA_WRBK_RX_CFG_WRBK_EN);
+
+	if (read_poll_timeout(wdma_r32, status,
+			      !(status & MTK_WDMA_WRBK_TX_CFG_WRBK_BUSY),
+			      0, 10000, false, dev, MTK_WDMA_WRBK_TX_CFG))
+		dev_err(dev->hw->dev, "tx reset failed\n");
+
+	if (read_poll_timeout(wdma_r32, status,
+			      !(status & MTK_WDMA_WRBK_RX_CFG_WRBK_BUSY),
+			      0, 10000, false, dev, MTK_WDMA_WRBK_RX_CFG))
+		dev_err(dev->hw->dev, "tx reset failed\n");
+
+	/* prefetch FIFO */
+	wdma_w32(dev, MTK_WDMA_PREF_TX_FIFO_CFG,
+		 MTK_WDMA_PREF_TX_FIFO_CFG_RING0_CLEAR |
+		 MTK_WDMA_PREF_TX_FIFO_CFG_RING1_CLEAR);
+	wdma_clr(dev, MTK_WDMA_PREF_TX_FIFO_CFG,
+		 MTK_WDMA_PREF_TX_FIFO_CFG_RING0_CLEAR |
+		 MTK_WDMA_PREF_TX_FIFO_CFG_RING1_CLEAR);
+
+	/* core FIFO */
+	wdma_w32(dev, MTK_WDMA_XDMA_TX_FIFO_CFG,
+		 MTK_WDMA_XDMA_TX_FIFO_CFG_TX_PAR_FIFO_CLEAR |
+		 MTK_WDMA_XDMA_TX_FIFO_CFG_TX_CMD_FIFO_CLEAR |
+		 MTK_WDMA_XDMA_TX_FIFO_CFG_TX_DMAD_FIFO_CLEAR |
+		 MTK_WDMA_XDMA_TX_FIFO_CFG_TX_ARR_FIFO_CLEAR);
+	wdma_clr(dev, MTK_WDMA_XDMA_TX_FIFO_CFG,
+		 MTK_WDMA_XDMA_TX_FIFO_CFG_TX_PAR_FIFO_CLEAR |
+		 MTK_WDMA_XDMA_TX_FIFO_CFG_TX_CMD_FIFO_CLEAR |
+		 MTK_WDMA_XDMA_TX_FIFO_CFG_TX_DMAD_FIFO_CLEAR |
+		 MTK_WDMA_XDMA_TX_FIFO_CFG_TX_ARR_FIFO_CLEAR);
+
+	/* writeback FIFO */
+	wdma_w32(dev, MTK_WDMA_WRBK_TX_FIFO_CFG(0),
+		 MTK_WDMA_WRBK_TX_FIFO_CFG_RING_CLEAR);
+	wdma_w32(dev, MTK_WDMA_WRBK_TX_FIFO_CFG(1),
+		 MTK_WDMA_WRBK_TX_FIFO_CFG_RING_CLEAR);
+
+	wdma_clr(dev, MTK_WDMA_WRBK_TX_FIFO_CFG(0),
+		 MTK_WDMA_WRBK_TX_FIFO_CFG_RING_CLEAR);
+	wdma_clr(dev, MTK_WDMA_WRBK_TX_FIFO_CFG(1),
+		 MTK_WDMA_WRBK_TX_FIFO_CFG_RING_CLEAR);
+
+	/* prefetch ring status */
+	wdma_w32(dev, MTK_WDMA_PREF_SIDX_CFG,
+		 MTK_WDMA_PREF_SIDX_CFG_TX_RING_CLEAR);
+	wdma_clr(dev, MTK_WDMA_PREF_SIDX_CFG,
+		 MTK_WDMA_PREF_SIDX_CFG_TX_RING_CLEAR);
+
+	/* writeback ring status */
+	wdma_w32(dev, MTK_WDMA_WRBK_SIDX_CFG,
+		 MTK_WDMA_WRBK_SIDX_CFG_TX_RING_CLEAR);
+	wdma_clr(dev, MTK_WDMA_WRBK_SIDX_CFG,
+		 MTK_WDMA_WRBK_SIDX_CFG_TX_RING_CLEAR);
+}
+
 static void
 mtk_wdma_tx_reset(struct mtk_wed_device *dev)
 {
@@ -203,6 +366,7 @@ mtk_wdma_tx_reset(struct mtk_wed_device *dev)
 			       !(status & mask), 0, 10000))
 		dev_err(dev->hw->dev, "tx reset failed\n");
 
+	mtk_wdma_v3_tx_reset(dev);
 	wdma_w32(dev, MTK_WDMA_RESET_IDX, MTK_WDMA_RESET_IDX_TX);
 	wdma_w32(dev, MTK_WDMA_RESET_IDX, 0);
 
@@ -1406,13 +1570,33 @@ mtk_wed_rx_reset(struct mtk_wed_device *dev)
 	if (ret)
 		return ret;
 
+	if (dev->wlan.hw_rro) {
+		wed_clr(dev, MTK_WED_CTRL, MTK_WED_CTRL_WED_RX_IND_CMD_EN);
+		mtk_wed_poll_busy(dev, MTK_WED_RRO_RX_HW_STS,
+				  MTK_WED_RX_IND_CMD_BUSY);
+		mtk_wed_reset(dev, MTK_WED_RESET_RRO_RX_TO_PG);
+	}
+
 	wed_clr(dev, MTK_WED_WPDMA_RX_D_GLO_CFG, MTK_WED_WPDMA_RX_D_RX_DRV_EN);
 	ret = mtk_wed_poll_busy(dev, MTK_WED_WPDMA_RX_D_GLO_CFG,
 				MTK_WED_WPDMA_RX_D_RX_DRV_BUSY);
+	if (!ret && mtk_wed_is_v3_or_greater(dev->hw))
+		ret = mtk_wed_poll_busy(dev, MTK_WED_WPDMA_RX_D_PREF_CFG,
+					MTK_WED_WPDMA_RX_D_PREF_BUSY);
 	if (ret) {
 		mtk_wed_reset(dev, MTK_WED_RESET_WPDMA_INT_AGENT);
 		mtk_wed_reset(dev, MTK_WED_RESET_WPDMA_RX_D_DRV);
 	} else {
+		if (mtk_wed_is_v3_or_greater(dev->hw)) {
+			/* 1.a. disable prefetch HW */
+			wed_clr(dev, MTK_WED_WPDMA_RX_D_PREF_CFG,
+				MTK_WED_WPDMA_RX_D_PREF_EN);
+			mtk_wed_poll_busy(dev, MTK_WED_WPDMA_RX_D_PREF_CFG,
+					  MTK_WED_WPDMA_RX_D_PREF_BUSY);
+			wed_w32(dev, MTK_WED_WPDMA_RX_D_RST_IDX,
+				MTK_WED_WPDMA_RX_D_RST_DRV_IDX_ALL);
+		}
+
 		wed_w32(dev, MTK_WED_WPDMA_RX_D_RST_IDX,
 			MTK_WED_WPDMA_RX_D_RST_CRX_IDX |
 			MTK_WED_WPDMA_RX_D_RST_DRV_IDX);
@@ -1440,23 +1624,52 @@ mtk_wed_rx_reset(struct mtk_wed_device *dev)
 		wed_w32(dev, MTK_WED_RROQM_RST_IDX, 0);
 	}
 
+	if (dev->wlan.hw_rro) {
+		/* disable rro msdu page drv */
+		wed_clr(dev, MTK_WED_RRO_MSDU_PG_RING2_CFG,
+			MTK_WED_RRO_MSDU_PG_DRV_EN);
+
+		/* disable rro data drv */
+		wed_clr(dev, MTK_WED_RRO_RX_D_CFG(2), MTK_WED_RRO_RX_D_DRV_EN);
+
+		/* rro msdu page drv reset */
+		wed_w32(dev, MTK_WED_RRO_MSDU_PG_RING2_CFG,
+			MTK_WED_RRO_MSDU_PG_DRV_CLR);
+		mtk_wed_poll_busy(dev, MTK_WED_RRO_MSDU_PG_RING2_CFG,
+				  MTK_WED_RRO_MSDU_PG_DRV_CLR);
+
+		/* rro data drv reset */
+		wed_w32(dev, MTK_WED_RRO_RX_D_CFG(2),
+			MTK_WED_RRO_RX_D_DRV_CLR);
+		mtk_wed_poll_busy(dev, MTK_WED_RRO_RX_D_CFG(2),
+				  MTK_WED_RRO_RX_D_DRV_CLR);
+	}
+
 	/* reset route qm */
 	wed_clr(dev, MTK_WED_CTRL, MTK_WED_CTRL_RX_ROUTE_QM_EN);
 	ret = mtk_wed_poll_busy(dev, MTK_WED_CTRL,
 				MTK_WED_CTRL_RX_ROUTE_QM_BUSY);
-	if (ret)
+	if (ret) {
 		mtk_wed_reset(dev, MTK_WED_RESET_RX_ROUTE_QM);
-	else
-		wed_set(dev, MTK_WED_RTQM_GLO_CFG,
-			MTK_WED_RTQM_Q_RST);
+	} else if (mtk_wed_is_v3_or_greater(dev->hw)) {
+		wed_set(dev, MTK_WED_RTQM_RST, BIT(0));
+		wed_clr(dev, MTK_WED_RTQM_RST, BIT(0));
+		mtk_wed_reset(dev, MTK_WED_RESET_RX_ROUTE_QM);
+	} else {
+		wed_set(dev, MTK_WED_RTQM_GLO_CFG, MTK_WED_RTQM_Q_RST);
+	}
 
 	/* reset tx wdma */
 	mtk_wdma_tx_reset(dev);
 
 	/* reset tx wdma drv */
 	wed_clr(dev, MTK_WED_WDMA_GLO_CFG, MTK_WED_WDMA_GLO_CFG_TX_DRV_EN);
-	mtk_wed_poll_busy(dev, MTK_WED_CTRL,
-			  MTK_WED_CTRL_WDMA_INT_AGENT_BUSY);
+	if (mtk_wed_is_v3_or_greater(dev->hw))
+		mtk_wed_poll_busy(dev, MTK_WED_WPDMA_STATUS,
+				  MTK_WED_WPDMA_STATUS_TX_DRV);
+	else
+		mtk_wed_poll_busy(dev, MTK_WED_CTRL,
+				  MTK_WED_CTRL_WDMA_INT_AGENT_BUSY);
 	mtk_wed_reset(dev, MTK_WED_RESET_WDMA_TX_DRV);
 
 	/* reset wed rx dma */
@@ -1477,6 +1690,14 @@ mtk_wed_rx_reset(struct mtk_wed_device *dev)
 			  MTK_WED_CTRL_WED_RX_BM_BUSY);
 	mtk_wed_reset(dev, MTK_WED_RESET_RX_BM);
 
+	if (dev->wlan.hw_rro) {
+		wed_clr(dev, MTK_WED_CTRL, MTK_WED_CTRL_WED_RX_PG_BM_EN);
+		mtk_wed_poll_busy(dev, MTK_WED_CTRL,
+				  MTK_WED_CTRL_WED_RX_PG_BM_BUSY);
+		wed_set(dev, MTK_WED_RESET, MTK_WED_RESET_RX_PG_BM);
+		wed_clr(dev, MTK_WED_RESET, MTK_WED_RESET_RX_PG_BM);
+	}
+
 	/* wo change to enable state */
 	val = MTK_WED_WO_STATE_ENABLE;
 	ret = mtk_wed_mcu_send_msg(wo, MTK_WED_MODULE_ID_WO,
@@ -1494,6 +1715,7 @@ mtk_wed_rx_reset(struct mtk_wed_device *dev)
 				   false);
 	}
 	mtk_wed_free_rx_buffer(dev);
+	mtk_wed_hwrro_free_buffer(dev);
 
 	return 0;
 }
@@ -1527,15 +1749,41 @@ mtk_wed_reset_dma(struct mtk_wed_device *dev)
 
 	/* 2. reset WDMA rx DMA */
 	busy = !!mtk_wdma_rx_reset(dev);
-	wed_clr(dev, MTK_WED_WDMA_GLO_CFG, MTK_WED_WDMA_GLO_CFG_RX_DRV_EN);
+	if (mtk_wed_is_v3_or_greater(dev->hw)) {
+		val = MTK_WED_WDMA_GLO_CFG_RX_DIS_FSM_AUTO_IDLE |
+		      wed_r32(dev, MTK_WED_WDMA_GLO_CFG);
+		val &= ~MTK_WED_WDMA_GLO_CFG_RX_DRV_EN;
+		wed_w32(dev, MTK_WED_WDMA_GLO_CFG, val);
+	} else {
+		wed_clr(dev, MTK_WED_WDMA_GLO_CFG,
+			MTK_WED_WDMA_GLO_CFG_RX_DRV_EN);
+	}
+
 	if (!busy)
 		busy = mtk_wed_poll_busy(dev, MTK_WED_WDMA_GLO_CFG,
 					 MTK_WED_WDMA_GLO_CFG_RX_DRV_BUSY);
+	if (!busy && mtk_wed_is_v3_or_greater(dev->hw))
+		busy = mtk_wed_poll_busy(dev, MTK_WED_WDMA_RX_PREF_CFG,
+					 MTK_WED_WDMA_RX_PREF_BUSY);
 
 	if (busy) {
 		mtk_wed_reset(dev, MTK_WED_RESET_WDMA_INT_AGENT);
 		mtk_wed_reset(dev, MTK_WED_RESET_WDMA_RX_DRV);
 	} else {
+		if (mtk_wed_is_v3_or_greater(dev->hw)) {
+			/* 1.a. disable prefetch HW */
+			wed_clr(dev, MTK_WED_WDMA_RX_PREF_CFG,
+				MTK_WED_WDMA_RX_PREF_EN);
+			mtk_wed_poll_busy(dev, MTK_WED_WDMA_RX_PREF_CFG,
+					  MTK_WED_WDMA_RX_PREF_BUSY);
+			wed_clr(dev, MTK_WED_WDMA_RX_PREF_CFG,
+				MTK_WED_WDMA_RX_PREF_DDONE2_EN);
+
+			/* 2. Reset dma index */
+			wed_w32(dev, MTK_WED_WDMA_RESET_IDX,
+				MTK_WED_WDMA_RESET_IDX_RX_ALL);
+		}
+
 		wed_w32(dev, MTK_WED_WDMA_RESET_IDX,
 			MTK_WED_WDMA_RESET_IDX_RX | MTK_WED_WDMA_RESET_IDX_DRV);
 		wed_w32(dev, MTK_WED_WDMA_RESET_IDX, 0);
@@ -1551,8 +1799,13 @@ mtk_wed_reset_dma(struct mtk_wed_device *dev)
 	wed_clr(dev, MTK_WED_CTRL, MTK_WED_CTRL_WED_TX_FREE_AGENT_EN);
 
 	for (i = 0; i < 100; i++) {
-		val = wed_r32(dev, MTK_WED_TX_BM_INTF);
-		if (FIELD_GET(MTK_WED_TX_BM_INTF_TKFIFO_FDEP, val) == 0x40)
+		if (mtk_wed_is_v1(dev->hw))
+			val = FIELD_GET(MTK_WED_TX_BM_INTF_TKFIFO_FDEP,
+					wed_r32(dev, MTK_WED_TX_BM_INTF));
+		else
+			val = FIELD_GET(MTK_WED_TX_TKID_INTF_TKFIFO_FDEP,
+					wed_r32(dev, MTK_WED_TX_TKID_INTF));
+		if (val == 0x40)
 			break;
 	}
 
@@ -1574,6 +1827,8 @@ mtk_wed_reset_dma(struct mtk_wed_device *dev)
 		mtk_wed_reset(dev, MTK_WED_RESET_WPDMA_INT_AGENT);
 		mtk_wed_reset(dev, MTK_WED_RESET_WPDMA_TX_DRV);
 		mtk_wed_reset(dev, MTK_WED_RESET_WPDMA_RX_DRV);
+		if (mtk_wed_is_v3_or_greater(dev->hw))
+			wed_w32(dev, MTK_WED_RX1_CTRL2, 0);
 	} else {
 		wed_w32(dev, MTK_WED_WPDMA_RESET_IDX,
 			MTK_WED_WPDMA_RESET_IDX_TX |
@@ -1590,7 +1845,14 @@ mtk_wed_reset_dma(struct mtk_wed_device *dev)
 		wed_w32(dev, MTK_WED_RESET_IDX, 0);
 	}
 
-	mtk_wed_rx_reset(dev);
+	if (mtk_wed_is_v3_or_greater(dev->hw)) {
+		/* reset amsdu engine */
+		wed_clr(dev, MTK_WED_CTRL, MTK_WED_CTRL_TX_AMSDU_EN);
+		mtk_wed_reset(dev, MTK_WED_RESET_TX_AMSDU);
+	}
+
+	if (mtk_wed_get_rx_capa(dev))
+		mtk_wed_rx_reset(dev);
 }
 
 static int
@@ -1842,6 +2104,7 @@ mtk_wed_dma_enable(struct mtk_wed_device *dev)
 			MTK_WED_WPDMA_GLO_CFG_RX_DRV_UNS_VER_FORCE_4);
 
 		wdma_set(dev, MTK_WDMA_PREF_RX_CFG, MTK_WDMA_PREF_RX_CFG_PREF_EN);
+		wdma_set(dev, MTK_WDMA_WRBK_RX_CFG, MTK_WDMA_WRBK_RX_CFG_WRBK_EN);
 	}
 
 	wed_clr(dev, MTK_WED_WPDMA_GLO_CFG,
@@ -1905,6 +2168,12 @@ mtk_wed_start_hw_rro(struct mtk_wed_device *dev, u32 irq_mask, bool reset)
 	if (!mtk_wed_get_rx_capa(dev) || !dev->wlan.hw_rro)
 		return;
 
+	if (reset) {
+		wed_set(dev, MTK_WED_RRO_MSDU_PG_RING2_CFG,
+			MTK_WED_RRO_MSDU_PG_DRV_EN);
+		return;
+	}
+
 	wed_set(dev, MTK_WED_RRO_RX_D_CFG(2), MTK_WED_RRO_MSDU_PG_DRV_CLR);
 	wed_w32(dev, MTK_WED_RRO_MSDU_PG_RING2_CFG,
 		MTK_WED_RRO_MSDU_PG_DRV_CLR);
diff --git a/drivers/net/ethernet/mediatek/mtk_wed_regs.h b/drivers/net/ethernet/mediatek/mtk_wed_regs.h
index 5a7e4a11a54e..c71190924816 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_regs.h
+++ b/drivers/net/ethernet/mediatek/mtk_wed_regs.h
@@ -28,6 +28,8 @@ struct mtk_wdma_desc {
 #define MTK_WED_RESET					0x008
 #define MTK_WED_RESET_TX_BM				BIT(0)
 #define MTK_WED_RESET_RX_BM				BIT(1)
+#define MTK_WED_RESET_RX_PG_BM				BIT(2)
+#define MTK_WED_RESET_RRO_RX_TO_PG			BIT(3)
 #define MTK_WED_RESET_TX_FREE_AGENT			BIT(4)
 #define MTK_WED_RESET_WPDMA_TX_DRV			BIT(8)
 #define MTK_WED_RESET_WPDMA_RX_DRV			BIT(9)
@@ -106,6 +108,9 @@ struct mtk_wdma_desc {
 #define MTK_WED_STATUS					0x060
 #define MTK_WED_STATUS_TX				GENMASK(15, 8)
 
+#define MTK_WED_WPDMA_STATUS				0x068
+#define MTK_WED_WPDMA_STATUS_TX_DRV			GENMASK(15, 8)
+
 #define MTK_WED_TX_BM_CTRL				0x080
 #define MTK_WED_TX_BM_CTRL_VLD_GRP_NUM			GENMASK(6, 0)
 #define MTK_WED_TX_BM_CTRL_RSV_GRP_NUM			GENMASK(22, 16)
@@ -140,6 +145,9 @@ struct mtk_wdma_desc {
 #define MTK_WED_TX_TKID_CTRL_RSV_GRP_NUM		GENMASK(22, 16)
 #define MTK_WED_TX_TKID_CTRL_PAUSE			BIT(28)
 
+#define MTK_WED_TX_TKID_INTF				0x0dc
+#define MTK_WED_TX_TKID_INTF_TKFIFO_FDEP		GENMASK(25, 16)
+
 #define MTK_WED_TX_TKID_CTRL_VLD_GRP_NUM_V3		GENMASK(7, 0)
 #define MTK_WED_TX_TKID_CTRL_RSV_GRP_NUM_V3		GENMASK(23, 16)
 
@@ -190,6 +198,7 @@ struct mtk_wdma_desc {
 #define MTK_WED_RING_RX_DATA(_n)			(0x420 + (_n) * 0x10)
 
 #define MTK_WED_SCR0					0x3c0
+#define MTK_WED_RX1_CTRL2				0x418
 #define MTK_WED_WPDMA_INT_TRIGGER			0x504
 #define MTK_WED_WPDMA_INT_TRIGGER_RX_DONE		BIT(1)
 #define MTK_WED_WPDMA_INT_TRIGGER_TX_DONE		GENMASK(5, 4)
@@ -303,6 +312,7 @@ struct mtk_wdma_desc {
 
 #define MTK_WED_WPDMA_RX_D_RST_IDX			0x760
 #define MTK_WED_WPDMA_RX_D_RST_CRX_IDX			GENMASK(17, 16)
+#define MTK_WED_WPDMA_RX_D_RST_DRV_IDX_ALL		BIT(20)
 #define MTK_WED_WPDMA_RX_D_RST_DRV_IDX			GENMASK(25, 24)
 
 #define MTK_WED_WPDMA_RX_GLO_CFG			0x76c
@@ -313,6 +323,7 @@ struct mtk_wdma_desc {
 
 #define MTK_WED_WPDMA_RX_D_PREF_CFG			0x7b4
 #define MTK_WED_WPDMA_RX_D_PREF_EN			BIT(0)
+#define MTK_WED_WPDMA_RX_D_PREF_BUSY			BIT(1)
 #define MTK_WED_WPDMA_RX_D_PREF_BURST_SIZE		GENMASK(12, 8)
 #define MTK_WED_WPDMA_RX_D_PREF_LOW_THRES		GENMASK(21, 16)
 
@@ -334,11 +345,13 @@ struct mtk_wdma_desc {
 
 #define MTK_WED_WDMA_RX_PREF_CFG			0x950
 #define MTK_WED_WDMA_RX_PREF_EN				BIT(0)
+#define MTK_WED_WDMA_RX_PREF_BUSY			BIT(1)
 #define MTK_WED_WDMA_RX_PREF_BURST_SIZE			GENMASK(12, 8)
 #define MTK_WED_WDMA_RX_PREF_LOW_THRES			GENMASK(21, 16)
 #define MTK_WED_WDMA_RX_PREF_RX0_SIDX_CLR		BIT(24)
 #define MTK_WED_WDMA_RX_PREF_RX1_SIDX_CLR		BIT(25)
 #define MTK_WED_WDMA_RX_PREF_DDONE2_EN			BIT(26)
+#define MTK_WED_WDMA_RX_PREF_DDONE2_BUSY		BIT(27)
 
 #define MTK_WED_WDMA_RX_PREF_FIFO_CFG			0x95C
 #define MTK_WED_WDMA_RX_PREF_FIFO_RX0_CLR		BIT(0)
@@ -367,6 +380,7 @@ struct mtk_wdma_desc {
 
 #define MTK_WED_WDMA_RESET_IDX				0xa08
 #define MTK_WED_WDMA_RESET_IDX_RX			GENMASK(17, 16)
+#define MTK_WED_WDMA_RESET_IDX_RX_ALL			BIT(20)
 #define MTK_WED_WDMA_RESET_IDX_DRV			GENMASK(25, 24)
 
 #define MTK_WED_WDMA_INT_CLR				0xa24
@@ -437,21 +451,62 @@ struct mtk_wdma_desc {
 #define MTK_WDMA_INT_MASK_RX_DELAY			BIT(30)
 #define MTK_WDMA_INT_MASK_RX_COHERENT			BIT(31)
 
+#define MTK_WDMA_XDMA_TX_FIFO_CFG			0x238
+#define MTK_WDMA_XDMA_TX_FIFO_CFG_TX_PAR_FIFO_CLEAR	BIT(0)
+#define MTK_WDMA_XDMA_TX_FIFO_CFG_TX_CMD_FIFO_CLEAR	BIT(4)
+#define MTK_WDMA_XDMA_TX_FIFO_CFG_TX_DMAD_FIFO_CLEAR	BIT(8)
+#define MTK_WDMA_XDMA_TX_FIFO_CFG_TX_ARR_FIFO_CLEAR	BIT(12)
+
+#define MTK_WDMA_XDMA_RX_FIFO_CFG			0x23c
+#define MTK_WDMA_XDMA_RX_FIFO_CFG_RX_PAR_FIFO_CLEAR	BIT(0)
+#define MTK_WDMA_XDMA_RX_FIFO_CFG_RX_CMD_FIFO_CLEAR	BIT(4)
+#define MTK_WDMA_XDMA_RX_FIFO_CFG_RX_DMAD_FIFO_CLEAR	BIT(8)
+#define MTK_WDMA_XDMA_RX_FIFO_CFG_RX_ARR_FIFO_CLEAR	BIT(12)
+#define MTK_WDMA_XDMA_RX_FIFO_CFG_RX_LEN_FIFO_CLEAR	BIT(15)
+#define MTK_WDMA_XDMA_RX_FIFO_CFG_RX_WID_FIFO_CLEAR	BIT(18)
+#define MTK_WDMA_XDMA_RX_FIFO_CFG_RX_BID_FIFO_CLEAR	BIT(21)
+
 #define MTK_WDMA_INT_GRP1				0x250
 #define MTK_WDMA_INT_GRP2				0x254
 
 #define MTK_WDMA_PREF_TX_CFG				0x2d0
 #define MTK_WDMA_PREF_TX_CFG_PREF_EN			BIT(0)
+#define MTK_WDMA_PREF_TX_CFG_PREF_BUSY			BIT(1)
 
 #define MTK_WDMA_PREF_RX_CFG				0x2dc
 #define MTK_WDMA_PREF_RX_CFG_PREF_EN			BIT(0)
+#define MTK_WDMA_PREF_RX_CFG_PREF_BUSY			BIT(1)
+
+#define MTK_WDMA_PREF_RX_FIFO_CFG			0x2e0
+#define MTK_WDMA_PREF_RX_FIFO_CFG_RING0_CLEAR		BIT(0)
+#define MTK_WDMA_PREF_RX_FIFO_CFG_RING1_CLEAR		BIT(16)
+
+#define MTK_WDMA_PREF_TX_FIFO_CFG			0x2d4
+#define MTK_WDMA_PREF_TX_FIFO_CFG_RING0_CLEAR		BIT(0)
+#define MTK_WDMA_PREF_TX_FIFO_CFG_RING1_CLEAR		BIT(16)
+
+#define MTK_WDMA_PREF_SIDX_CFG				0x2e4
+#define MTK_WDMA_PREF_SIDX_CFG_TX_RING_CLEAR		GENMASK(3, 0)
+#define MTK_WDMA_PREF_SIDX_CFG_RX_RING_CLEAR		GENMASK(5, 4)
 
 #define MTK_WDMA_WRBK_TX_CFG				0x300
+#define MTK_WDMA_WRBK_TX_CFG_WRBK_BUSY			BIT(0)
 #define MTK_WDMA_WRBK_TX_CFG_WRBK_EN			BIT(30)
 
+#define MTK_WDMA_WRBK_TX_FIFO_CFG(_n)			(0x304 + (_n) * 0x4)
+#define MTK_WDMA_WRBK_TX_FIFO_CFG_RING_CLEAR		BIT(0)
+
 #define MTK_WDMA_WRBK_RX_CFG				0x344
+#define MTK_WDMA_WRBK_RX_CFG_WRBK_BUSY			BIT(0)
 #define MTK_WDMA_WRBK_RX_CFG_WRBK_EN			BIT(30)
 
+#define MTK_WDMA_WRBK_RX_FIFO_CFG(_n)			(0x348 + (_n) * 0x4)
+#define MTK_WDMA_WRBK_RX_FIFO_CFG_RING_CLEAR		BIT(0)
+
+#define MTK_WDMA_WRBK_SIDX_CFG				0x388
+#define MTK_WDMA_WRBK_SIDX_CFG_TX_RING_CLEAR		GENMASK(3, 0)
+#define MTK_WDMA_WRBK_SIDX_CFG_RX_RING_CLEAR		GENMASK(5, 4)
+
 #define MTK_PCIE_MIRROR_MAP(n)				((n) ? 0x4 : 0x0)
 #define MTK_PCIE_MIRROR_MAP_EN				BIT(0)
 #define MTK_PCIE_MIRROR_MAP_WED_ID			BIT(1)
@@ -465,6 +520,8 @@ struct mtk_wdma_desc {
 #define MTK_WED_RTQM_Q_DBG_BYPASS			BIT(5)
 #define MTK_WED_RTQM_TXDMAD_FPORT			GENMASK(23, 20)
 
+#define MTK_WED_RTQM_RST				0xb04
+
 #define MTK_WED_RTQM_IGRS0_I2HW_DMAD_CNT		0xb1c
 #define MTK_WED_RTQM_IGRS0_I2H_DMAD_CNT(_n)		(0xb20 + (_n) * 0x4)
 #define	MTK_WED_RTQM_IGRS0_I2HW_PKT_CNT			0xb28
@@ -653,6 +710,9 @@ struct mtk_wdma_desc {
 #define MTK_WED_WPDMA_INT_CTRL_RRO_PG2_CLR		BIT(17)
 #define MTK_WED_WPDMA_INT_CTRL_RRO_PG2_DONE_TRIG	GENMASK(22, 18)
 
+#define MTK_WED_RRO_RX_HW_STS				0xf00
+#define MTK_WED_RX_IND_CMD_BUSY				GENMASK(31, 0)
+
 #define MTK_WED_RX_IND_CMD_CNT0				0xf20
 #define MTK_WED_RX_IND_CMD_DBG_CNT_EN			BIT(31)
 
-- 
2.41.0


