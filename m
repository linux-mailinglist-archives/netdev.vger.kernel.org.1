Return-Path: <netdev+bounces-199471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EFFAE06DA
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8443B780E
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 13:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7154B241679;
	Thu, 19 Jun 2025 13:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="Swo6EbCT"
X-Original-To: netdev@vger.kernel.org
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4569125771;
	Thu, 19 Jun 2025 13:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750339300; cv=none; b=e3Z8fZqhuyWAONgVJMA32/L+6P6KFjlcXT9K00e4PiZyBwb0g4URiX+P/okytnhotShZ9bAj02POsQ2g0YF7OX4ykxR5lKyBWvqFak+XPQqLjkq4G6GXzFMTfzC/EBe6w5RBWU1XmODmbYSrnl7UZIDq/m9cmkNqoyP0X3SYQIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750339300; c=relaxed/simple;
	bh=yxthBGa2kWCaTKfIRuHlpNNysFTQodWfy0JsB152u/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOLFGG2NfGqq4kyTkFCEzHsWAzk4hUHzEAUAamHUj1otq2MjRIKHR76oo7zpRe4aAYlorP5Rsa/HuUp7oIICB6DJ/7UE1xrfHUrojWsYxC/t7Sdy2hxhyq0EH6TubFtVyqioPwFAb6MAuHYxPuo6QYnbVSuZBgNsg4bau81zE20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=Swo6EbCT; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout1.routing.net (Postfix) with ESMTP id E246D3FD38;
	Thu, 19 Jun 2025 13:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1750339295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y2r8lo6RJvLluKg4KIZxEwc9bRBev7HH1fZd4pPyLJ4=;
	b=Swo6EbCTkmGPSfjbgZm9hWHRt2vQ2x0oa968ia9OGzruIclnOlLddRZzzecYYyFxSyreLn
	ukuh7uOuCjzW/heQExis61VIf8xJWzE+pEJdu1T28YNeKg9imuaq8mKkAFvXLWFFELvZ5V
	53riNFQ8myJK6L1R6jHz+VACdezutoY=
Received: from frank-u24.. (fttx-pool-80.245.76.73.bambit.de [80.245.76.73])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id A5C7F1226AA;
	Thu, 19 Jun 2025 13:21:34 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Simon Horman <horms@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	arinc.unal@arinc9.com
Subject: [net-next v6 2/4] net: ethernet: mtk_eth_soc: add consts for irq index
Date: Thu, 19 Jun 2025 15:21:22 +0200
Message-ID: <20250619132125.78368-3-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250619132125.78368-1-linux@fw-web.de>
References: <20250619132125.78368-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

Use consts instead of fixed integers for accessing IRQ array.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Daniel Golle <daniel@makrotopia.org>
---
v5:
- rename consts to be compatible with upcoming RSS/LRO changes
  MTK_ETH_IRQ_SHARED => MTK_FE_IRQ_SHARED
  MTK_ETH_IRQ_TX => MTK_FE_IRQ_TX
  MTK_ETH_IRQ_RX => MTK_FE_IRQ_RX
  MTK_ETH_IRQ_MAX => MTK_FE_IRQ_NUM
v4:
- calculate max from last (rx) irq index and use it for array size too
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 22 ++++++++++-----------
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  7 ++++++-
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index c5deb8183afe..efffdd7e131e 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -3341,9 +3341,9 @@ static int mtk_get_irqs(struct platform_device *pdev, struct mtk_eth *eth)
 	int i;
 
 	/* future SoCs beginning with MT7988 should use named IRQs in dts */
-	eth->irq[1] = platform_get_irq_byname(pdev, "fe1");
-	eth->irq[2] = platform_get_irq_byname(pdev, "fe2");
-	if (eth->irq[1] >= 0 && eth->irq[2] >= 0)
+	eth->irq[MTK_FE_IRQ_TX] = platform_get_irq_byname(pdev, "fe1");
+	eth->irq[MTK_FE_IRQ_RX] = platform_get_irq_byname(pdev, "fe2");
+	if (eth->irq[MTK_FE_IRQ_TX] >= 0 && eth->irq[MTK_FE_IRQ_RX] >= 0)
 		return 0;
 
 	/* legacy way:
@@ -3352,9 +3352,9 @@ static int mtk_get_irqs(struct platform_device *pdev, struct mtk_eth *eth)
 	 * On SoCs with non-shared IRQs the first entry is not used,
 	 * the second is for TX, and the third is for RX.
 	 */
-	for (i = 0; i < 3; i++) {
+	for (i = 0; i < MTK_FE_IRQ_NUM; i++) {
 		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT) && i > 0)
-			eth->irq[i] = eth->irq[0];
+			eth->irq[i] = eth->irq[MTK_FE_IRQ_SHARED];
 		else
 			eth->irq[i] = platform_get_irq(pdev, i);
 
@@ -3420,7 +3420,7 @@ static void mtk_poll_controller(struct net_device *dev)
 
 	mtk_tx_irq_disable(eth, MTK_TX_DONE_INT);
 	mtk_rx_irq_disable(eth, eth->soc->rx.irq_done_mask);
-	mtk_handle_irq_rx(eth->irq[2], dev);
+	mtk_handle_irq_rx(eth->irq[MTK_FE_IRQ_RX], dev);
 	mtk_tx_irq_enable(eth, MTK_TX_DONE_INT);
 	mtk_rx_irq_enable(eth, eth->soc->rx.irq_done_mask);
 }
@@ -4906,7 +4906,7 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
 	eth->netdev[id]->features |= eth->soc->hw_features;
 	eth->netdev[id]->ethtool_ops = &mtk_ethtool_ops;
 
-	eth->netdev[id]->irq = eth->irq[0];
+	eth->netdev[id]->irq = eth->irq[MTK_FE_IRQ_SHARED];
 	eth->netdev[id]->dev.of_node = np;
 
 	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628))
@@ -5183,17 +5183,17 @@ static int mtk_probe(struct platform_device *pdev)
 	}
 
 	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT)) {
-		err = devm_request_irq(eth->dev, eth->irq[0],
+		err = devm_request_irq(eth->dev, eth->irq[MTK_FE_IRQ_SHARED],
 				       mtk_handle_irq, 0,
 				       dev_name(eth->dev), eth);
 	} else {
-		err = devm_request_irq(eth->dev, eth->irq[1],
+		err = devm_request_irq(eth->dev, eth->irq[MTK_FE_IRQ_TX],
 				       mtk_handle_irq_tx, 0,
 				       dev_name(eth->dev), eth);
 		if (err)
 			goto err_free_dev;
 
-		err = devm_request_irq(eth->dev, eth->irq[2],
+		err = devm_request_irq(eth->dev, eth->irq[MTK_FE_IRQ_RX],
 				       mtk_handle_irq_rx, 0,
 				       dev_name(eth->dev), eth);
 	}
@@ -5239,7 +5239,7 @@ static int mtk_probe(struct platform_device *pdev)
 		} else
 			netif_info(eth, probe, eth->netdev[i],
 				   "mediatek frame engine at 0x%08lx, irq %d\n",
-				   eth->netdev[i]->base_addr, eth->irq[0]);
+				   eth->netdev[i]->base_addr, eth->irq[MTK_FE_IRQ_SHARED]);
 	}
 
 	/* we run 2 devices on the same DMA ring so we need a dummy device
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 6f72a8c8ae1e..8cdf1317dff5 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -642,6 +642,11 @@
 
 #define MTK_MAC_FSM(x)		(0x1010C + ((x) * 0x100))
 
+#define MTK_FE_IRQ_SHARED	0
+#define MTK_FE_IRQ_TX		1
+#define MTK_FE_IRQ_RX		2
+#define MTK_FE_IRQ_NUM		(MTK_FE_IRQ_RX + 1)
+
 struct mtk_rx_dma {
 	unsigned int rxd1;
 	unsigned int rxd2;
@@ -1292,7 +1297,7 @@ struct mtk_eth {
 	struct net_device		*dummy_dev;
 	struct net_device		*netdev[MTK_MAX_DEVS];
 	struct mtk_mac			*mac[MTK_MAX_DEVS];
-	int				irq[3];
+	int				irq[MTK_FE_IRQ_NUM];
 	u32				msg_enable;
 	unsigned long			sysclk;
 	struct regmap			*ethsys;
-- 
2.43.0


