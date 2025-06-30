Return-Path: <netdev+bounces-202306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D45AED19D
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 00:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F5F3B2B24
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 22:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C26323B60C;
	Sun, 29 Jun 2025 22:21:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8561C5486;
	Sun, 29 Jun 2025 22:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751235712; cv=none; b=cQ91XlCckrTY4F+CVq/IsFaikTp0zLj961MrhONZTxz3VJt7K6nC2yukaPVVndTm4TQkH27BbUl5/E00+Ml40K6pSAlGZqH9n7ADcsOWhI5j2QXZCuixlsyqKUPBdNc5fJCyzJ595LbJhfybx6lgffpVnJzV1vGGsJpI+8Xw17A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751235712; c=relaxed/simple;
	bh=/x5Be7ODWhXr5ihjGTResieTPqr3UgETH6ZExbnnoBQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceYJFX5ENr+nYaY4lKBRD7gmCyL7b40GEsJzRojWIWtlFA7CcbaKd/VefKIcGgbzdy5LSMk0C6UrZ+tG4xxzTCR/5Ip0UNOQkl6OjaIf9Nl0Qr/METvZI16hVcMFNTirjDt5BWRcovcKX3+t3HsPdMUhrR/b30Oo3kwqaTXBQ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uW0PB-000000002J3-0WMf;
	Sun, 29 Jun 2025 22:21:45 +0000
Date: Sun, 29 Jun 2025 23:21:42 +0100
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
Subject: [PATCH net-next v2 1/3] net: ethernet: mtk_eth_soc: improve support
 for named interrupts
Message-ID: <20460fe0dee9f1c42f3c1b64177dd569a6fe4ef4.1751229149.git.daniel@makrotopia.org>
References: <cover.1751229149.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751229149.git.daniel@makrotopia.org>

Use platform_get_irq_byname_optional() to avoid outputting error
messages when using legacy device trees which rely identifying
interrupts only by index. Instead, output a warning notifying the user
to update their device tree.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v2: no changes

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

