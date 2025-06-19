Return-Path: <netdev+bounces-199472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F14D9AE06DC
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D92F4A3116
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 13:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262DF24DD04;
	Thu, 19 Jun 2025 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="U6InJxZ2"
X-Original-To: netdev@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5817B24BBFC;
	Thu, 19 Jun 2025 13:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750339304; cv=none; b=ehHOesrYsPGFOnQ1TcjXKT2KKZ/w0SgqPRV0Vnet2OEaYBs4pU0isaih6tt3l3I/GHgSdIXxggrr9lK8tJ0CGIK3d4Koeq1Jzalbv/9StFXygIYBFc2vXsJ4g40yy9eVi9k/VdrIg3IG47ZTJwPlyaWtbfUm+eFRv9xfU4JHOIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750339304; c=relaxed/simple;
	bh=BWG7vmJnWNo7yijQKcbCHKcWSJkqta2GdiPL/0mkoNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAjoZqzxwym5fksQodviD05DDW1SdmvqfpzzfIgc8ZE8QYs5vZp1ZrsHS3yxxtUmGQtsWFTNPuJuHgBbSERqOXEc8fdSgFxp6Mqul8X14O8/W3php+EmB+LBQGe6TFg5Lt16PAYZlsTSTxGGfONA/N/UrY600LiybLxLgZhrqc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=U6InJxZ2; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout4.routing.net (Postfix) with ESMTP id A54E110094F;
	Thu, 19 Jun 2025 13:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1750339294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yYV5OhX7IqnBNWpRHDSoVk4uEaTxigiqwKGaEqQ6CRo=;
	b=U6InJxZ22XRbyJmdpYQxg+bC6FC/Ixlv5drcdcPUZdcu36lpi8OwNmD6W5QzxhHLAQEXMp
	1HnwG1Hsbr3zXSmrZZFHmbxsZ2I9LvOtL8TZJW7U7MdfWAb27nuvp9Gy5jj3ReybRhp6jj
	9zcaTcRaGHj23oDu1K0BklkUrTxHsdE=
Received: from frank-u24.. (fttx-pool-80.245.76.73.bambit.de [80.245.76.73])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 65D05122703;
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
Subject: [net-next v6 1/4] net: ethernet: mtk_eth_soc: support named IRQs
Date: Thu, 19 Jun 2025 15:21:21 +0200
Message-ID: <20250619132125.78368-2-linux@fw-web.de>
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

Add named interrupts and keep index based fallback for existing
devicetrees.

Currently only rx and tx IRQs are defined to be used with mt7988, but
later extended with RSS/LRO support.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v6:
- change irq names from tx/rx to fe1/fe2 because reserved irqs
  are usable and not bound to specific function
- dropped Simons RB because of this
v5:
- fix typo in description
- add comments from previous patch #3 with changes suggested by simon

v2:
- move irqs loading part into own helper function
- reduce indentation
- place mtk_get_irqs helper before the irq_handler (note for simon)

net: mtk_eth_soc: change irq name back to fe1 + fe2
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 46 ++++++++++++++++-----
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index b38e4f2de674..c5deb8183afe 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -3336,6 +3336,37 @@ static void mtk_tx_timeout(struct net_device *dev, unsigned int txqueue)
 	schedule_work(&eth->pending_work);
 }
 
+static int mtk_get_irqs(struct platform_device *pdev, struct mtk_eth *eth)
+{
+	int i;
+
+	/* future SoCs beginning with MT7988 should use named IRQs in dts */
+	eth->irq[1] = platform_get_irq_byname(pdev, "fe1");
+	eth->irq[2] = platform_get_irq_byname(pdev, "fe2");
+	if (eth->irq[1] >= 0 && eth->irq[2] >= 0)
+		return 0;
+
+	/* legacy way:
+	 * On MTK_SHARED_INT SoCs (MT7621 + MT7628) the first IRQ is taken
+	 * from devicetree and used for both RX and TX - it is shared.
+	 * On SoCs with non-shared IRQs the first entry is not used,
+	 * the second is for TX, and the third is for RX.
+	 */
+	for (i = 0; i < 3; i++) {
+		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT) && i > 0)
+			eth->irq[i] = eth->irq[0];
+		else
+			eth->irq[i] = platform_get_irq(pdev, i);
+
+		if (eth->irq[i] < 0) {
+			dev_err(&pdev->dev, "no IRQ%d resource found\n", i);
+			return -ENXIO;
+		}
+	}
+
+	return 0;
+}
+
 static irqreturn_t mtk_handle_irq_rx(int irq, void *_eth)
 {
 	struct mtk_eth *eth = _eth;
@@ -5105,17 +5136,10 @@ static int mtk_probe(struct platform_device *pdev)
 		}
 	}
 
-	for (i = 0; i < 3; i++) {
-		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT) && i > 0)
-			eth->irq[i] = eth->irq[0];
-		else
-			eth->irq[i] = platform_get_irq(pdev, i);
-		if (eth->irq[i] < 0) {
-			dev_err(&pdev->dev, "no IRQ%d resource found\n", i);
-			err = -ENXIO;
-			goto err_wed_exit;
-		}
-	}
+	err = mtk_get_irqs(pdev, eth);
+	if (err)
+		goto err_wed_exit;
+
 	for (i = 0; i < ARRAY_SIZE(eth->clks); i++) {
 		eth->clks[i] = devm_clk_get(eth->dev,
 					    mtk_clks_source_name[i]);
-- 
2.43.0


