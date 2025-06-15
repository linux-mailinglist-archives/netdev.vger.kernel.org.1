Return-Path: <netdev+bounces-197880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBE9ADA235
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 17:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE4F616F431
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 15:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C791C1741;
	Sun, 15 Jun 2025 15:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="PsANyjPF"
X-Original-To: netdev@vger.kernel.org
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F167FBA2;
	Sun, 15 Jun 2025 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749999839; cv=none; b=AxRyMLUdols8Rsg3jG1YoE9jgDWNPfiVkIIoFoYfnPqtMKXX5vZ+iRnE+AgMCQ7zfR2JcGmpG45WtUEBbEUJn7qkPpkp/nsYHP0i76n+DkEvvdC/vVbdSheIBJQS4kQP+o1Y8hCdI0hK/9Kok0GclWDbcJeRERxVUFQ+yPWJFGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749999839; c=relaxed/simple;
	bh=VMTM4/TGstnUHxJMg1MRKr4dOdDAu5tuU3B0/aQiQrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CbwjhyRexb22t74ORk4ua5xuPQBVCvFQWSGxUCaVNqm71Dg21vmv0Q/Cp5WOCWSv1AUH0wDi5H0Phu7OpWQ95EwYUwdbPoT9PPyObXTq8xC9UIuTDFC4kwiqfSTPI2+takVNhyPboAElKCSl2KlCVSqpnJD1iUG2BR+wH/7CmSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=PsANyjPF; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout2.routing.net (Postfix) with ESMTP id 2823B5FBA1;
	Sun, 15 Jun 2025 15:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1749999829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8+4Fhd4ocII9lpkmXR6H0SugqzwdoLPQH4LwtiRqyCc=;
	b=PsANyjPF0b03jF6W/HJSynxOLkuwREAJS8ozumrnEefluiJCFdhSv+DO19RftOA3dkvbWd
	L9BaHERIPEj2CI5qs9IdVIbA2IhVsKAf21J5JNEvC0TlW1OJhI9dFvLd/my/54OXy3py0b
	KeofimBCKKNtw0Wb3VxRsxVKQTQh+hA=
Received: from frank-u24.. (fttx-pool-217.61.157.124.bambit.de [217.61.157.124])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id E0D4F1226A7;
	Sun, 15 Jun 2025 15:03:48 +0000 (UTC)
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
	Daniel Golle <daniel@makrotopia.org>
Subject: [net-next v3 2/3] net: ethernet: mtk_eth_soc: add consts for irq index
Date: Sun, 15 Jun 2025 17:03:17 +0200
Message-ID: <20250615150333.166202-3-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250615150333.166202-1-linux@fw-web.de>
References: <20250615150333.166202-1-linux@fw-web.de>
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
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 22 ++++++++++-----------
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  5 +++++
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index f91ea87d2f72..9aec67c9c6d7 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -3340,14 +3340,14 @@ static int mtk_get_irqs(struct platform_device *pdev, struct mtk_eth *eth)
 {
 	int i;
 
-	eth->irq[1] = platform_get_irq_byname(pdev, "tx");
-	eth->irq[2] = platform_get_irq_byname(pdev, "rx");
-	if (eth->irq[1] >= 0 && eth->irq[2] >= 0)
+	eth->irq[MTK_ETH_IRQ_TX] = platform_get_irq_byname(pdev, "tx");
+	eth->irq[MTK_ETH_IRQ_RX] = platform_get_irq_byname(pdev, "rx");
+	if (eth->irq[MTK_ETH_IRQ_TX] >= 0 && eth->irq[MTK_ETH_IRQ_RX] >= 0)
 		return 0;
 
-	for (i = 0; i < 3; i++) {
+	for (i = 0; i < MTK_ETH_IRQ_MAX; i++) {
 		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT) && i > 0)
-			eth->irq[i] = eth->irq[0];
+			eth->irq[i] = eth->irq[MTK_ETH_IRQ_SHARED];
 		else
 			eth->irq[i] = platform_get_irq(pdev, i);
 
@@ -3413,7 +3413,7 @@ static void mtk_poll_controller(struct net_device *dev)
 
 	mtk_tx_irq_disable(eth, MTK_TX_DONE_INT);
 	mtk_rx_irq_disable(eth, eth->soc->rx.irq_done_mask);
-	mtk_handle_irq_rx(eth->irq[2], dev);
+	mtk_handle_irq_rx(eth->irq[MTK_ETH_IRQ_RX], dev);
 	mtk_tx_irq_enable(eth, MTK_TX_DONE_INT);
 	mtk_rx_irq_enable(eth, eth->soc->rx.irq_done_mask);
 }
@@ -4899,7 +4899,7 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
 	eth->netdev[id]->features |= eth->soc->hw_features;
 	eth->netdev[id]->ethtool_ops = &mtk_ethtool_ops;
 
-	eth->netdev[id]->irq = eth->irq[0];
+	eth->netdev[id]->irq = eth->irq[MTK_ETH_IRQ_SHARED];
 	eth->netdev[id]->dev.of_node = np;
 
 	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628))
@@ -5176,17 +5176,17 @@ static int mtk_probe(struct platform_device *pdev)
 	}
 
 	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT)) {
-		err = devm_request_irq(eth->dev, eth->irq[0],
+		err = devm_request_irq(eth->dev, eth->irq[MTK_ETH_IRQ_SHARED],
 				       mtk_handle_irq, 0,
 				       dev_name(eth->dev), eth);
 	} else {
-		err = devm_request_irq(eth->dev, eth->irq[1],
+		err = devm_request_irq(eth->dev, eth->irq[MTK_ETH_IRQ_TX],
 				       mtk_handle_irq_tx, 0,
 				       dev_name(eth->dev), eth);
 		if (err)
 			goto err_free_dev;
 
-		err = devm_request_irq(eth->dev, eth->irq[2],
+		err = devm_request_irq(eth->dev, eth->irq[MTK_ETH_IRQ_RX],
 				       mtk_handle_irq_rx, 0,
 				       dev_name(eth->dev), eth);
 	}
@@ -5232,7 +5232,7 @@ static int mtk_probe(struct platform_device *pdev)
 		} else
 			netif_info(eth, probe, eth->netdev[i],
 				   "mediatek frame engine at 0x%08lx, irq %d\n",
-				   eth->netdev[i]->base_addr, eth->irq[0]);
+				   eth->netdev[i]->base_addr, eth->irq[MTK_ETH_IRQ_SHARED]);
 	}
 
 	/* we run 2 devices on the same DMA ring so we need a dummy device
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 6f72a8c8ae1e..6b1208d05f79 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -642,6 +642,11 @@
 
 #define MTK_MAC_FSM(x)		(0x1010C + ((x) * 0x100))
 
+#define MTK_ETH_IRQ_SHARED	0
+#define MTK_ETH_IRQ_TX		1
+#define MTK_ETH_IRQ_RX		2
+#define MTK_ETH_IRQ_MAX		3
+
 struct mtk_rx_dma {
 	unsigned int rxd1;
 	unsigned int rxd2;
-- 
2.43.0


