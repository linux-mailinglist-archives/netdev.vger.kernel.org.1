Return-Path: <netdev+bounces-203344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0339CAF5844
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 15:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0534E3BCD83
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714B62777F7;
	Wed,  2 Jul 2025 13:14:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C309C275878;
	Wed,  2 Jul 2025 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462080; cv=none; b=WhM1BpRhpKdTIEdfQ1MvDdjVzTmYBrh9ScYA7J1bsTsvactKHrdTPMJI0NwEZBh72JYdD4aIGY+QoGUmtEVdZ1fTtmxTBnnB/PN4WFc4Jj2xGl10sjc9AuiUDyJSrXNszdcWggMgUBhilkIW9HKag+RmYYv49o8qpWRMtDeYsbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462080; c=relaxed/simple;
	bh=1Mbyc+umDVs8g3mubIddvonuAQdCaXabeh16+O3Qc8A=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPCFHxvnwhlltps43xjs2p1wOFI8PO2YgbJ7JsGfIgV1nEFAHKUtVos0Rmq7nlMUtZLDZgsIIysLzp30DsarGi3Cm7FSi0SzynRI+9vjOB+6FWmkbmx+Ji/ppWWLwx4zwKd6dttD4bCQUBaWfIVV4MUjDUb5cYbGsA+qxE5dqfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uWxIH-000000007sr-0MqR;
	Wed, 02 Jul 2025 13:14:33 +0000
Date: Wed, 2 Jul 2025 14:14:29 +0100
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
Subject: [PATCH net-next v5 1/3] net: ethernet: mtk_eth_soc: improve support
 for named interrupts
Message-ID: <aeccd00eccb7186d39d2c16292019b3b22ec53b8.1751461762.git.daniel@makrotopia.org>
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

Use platform_get_irq_byname_optional() to avoid outputting error
messages when using legacy device trees which rely identifying
interrupts only by index. Instead, output a warning notifying the user
to update their device tree.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v5: unchanged
v4: unchanged
v3: unchanged
v2: unchanged

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index f8a907747db4..8f55069441f4 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -3341,17 +3341,22 @@ static int mtk_get_irqs(struct platform_device *pdev, struct mtk_eth *eth)
 	int i;
 
 	/* future SoCs beginning with MT7988 should use named IRQs in dts */
-	eth->irq[MTK_FE_IRQ_TX] = platform_get_irq_byname(pdev, "fe1");
-	eth->irq[MTK_FE_IRQ_RX] = platform_get_irq_byname(pdev, "fe2");
+	eth->irq[MTK_FE_IRQ_TX] = platform_get_irq_byname_optional(pdev, "fe1");
+	eth->irq[MTK_FE_IRQ_RX] = platform_get_irq_byname_optional(pdev, "fe2");
 	if (eth->irq[MTK_FE_IRQ_TX] >= 0 && eth->irq[MTK_FE_IRQ_RX] >= 0)
 		return 0;
 
-	/* only use legacy mode if platform_get_irq_byname returned -ENXIO */
+	/* only use legacy mode if platform_get_irq_byname_optional returned -ENXIO */
 	if (eth->irq[MTK_FE_IRQ_TX] != -ENXIO)
-		return eth->irq[MTK_FE_IRQ_TX];
+		return dev_err_probe(&pdev->dev, eth->irq[MTK_FE_IRQ_TX],
+				     "Error requesting FE TX IRQ\n");
 
 	if (eth->irq[MTK_FE_IRQ_RX] != -ENXIO)
-		return eth->irq[MTK_FE_IRQ_RX];
+		return dev_err_probe(&pdev->dev, eth->irq[MTK_FE_IRQ_RX],
+				     "Error requesting FE RX IRQ\n");
+
+	if (!MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT))
+		dev_warn(&pdev->dev, "legacy DT: missing interrupt-names.");
 
 	/* legacy way:
 	 * On MTK_SHARED_INT SoCs (MT7621 + MT7628) the first IRQ is taken
-- 
2.50.0

