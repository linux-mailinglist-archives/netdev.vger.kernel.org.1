Return-Path: <netdev+bounces-183071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D73A8ACFF
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 02:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9344A19013C6
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 00:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401191DEFD9;
	Wed, 16 Apr 2025 00:51:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E054328DD0;
	Wed, 16 Apr 2025 00:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744764673; cv=none; b=rTXbUE6n4Fv8WtcsEPP58+A4YWHtNMaCS5PF0QI1jR8Ghuv4Gvrp9tWgSuuk+sYKBH8ifpvhU2joHA9Sp0a/IrzcFWWvGYnVAqruqqpBkwSMl00sZqBgqwSRWv+Ocf/SCViNof0DTVMWJUx+spudg+mXRybIzDg4c7jGHXe/rdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744764673; c=relaxed/simple;
	bh=t/CBJuAYr4JZqOfCSMZkbXklPzSfMR/fyE5VpxJIAJo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ggS87yW6YxVwaj9u7NvQU2qXWDqEiWl8165gD77LPJV8Kf9V6EHHrzXEQnHch13NTeREX+8WpejZ0qH6GT7VMzy/8PdHQpisb0vi387t8vg5qJcds4JyxLfNk3gFg3Yogldf9gpfd20MeJ3NEwS9EdybVG1OI4OGa09ArPTu3o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1u4qwl-000000001SU-3xn7;
	Wed, 16 Apr 2025 00:50:49 +0000
Date: Wed, 16 Apr 2025 01:50:46 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net v2 1/5] net: ethernet: mtk_eth_soc: reapply mdc divider
 on reset
Message-ID: <8ab7381447e6cdcb317d5b5a6ddd90a1734efcb0.1744764277.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Bo-Cun Chen <bc-bocun.chen@mediatek.com>

In the current method, the MDC divider was reset to the default setting
of 2.5MHz after the NETSYS SER. Therefore, we need to reapply the MDC
divider configuration function in mtk_hw_init() after reset.

Fixes: c0a440031d431 ("net: ethernet: mtk_eth_soc: set MDIO bus clock frequency")
Signed-off-by: Bo-Cun Chen <bc-bocun.chen@mediatek.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: * only parse DT once, store divider in struct mtk_eth
    * make sure MDC is configured before calling of_mdiobus_register()
    * reapply after reset

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 39 +++++++++++++--------
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  1 +
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 43197b28b3e74..1a235283b0e9b 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -871,9 +871,25 @@ static const struct phylink_mac_ops mtk_phylink_ops = {
 	.mac_enable_tx_lpi = mtk_mac_enable_tx_lpi,
 };
 
+static void mtk_mdio_config(struct mtk_eth *eth)
+{
+	u32 val;
+
+	/* Configure MDC Divider */
+	val = FIELD_PREP(PPSC_MDC_CFG, eth->mdc_divider);
+
+	/* Configure MDC Turbo Mode */
+	if (mtk_is_netsys_v3_or_greater(eth))
+		mtk_m32(eth, 0, MISC_MDC_TURBO, MTK_MAC_MISC_V3);
+	else
+		val |= PPSC_MDC_TURBO;
+
+	mtk_m32(eth, PPSC_MDC_CFG, val, MTK_PPSC);
+}
+
 static int mtk_mdio_init(struct mtk_eth *eth)
 {
-	unsigned int max_clk = 2500000, divider;
+	unsigned int max_clk = 2500000;
 	struct device_node *mii_np;
 	int ret;
 	u32 val;
@@ -908,20 +924,9 @@ static int mtk_mdio_init(struct mtk_eth *eth)
 		}
 		max_clk = val;
 	}
-	divider = min_t(unsigned int, DIV_ROUND_UP(MDC_MAX_FREQ, max_clk), 63);
-
-	/* Configure MDC Turbo Mode */
-	if (mtk_is_netsys_v3_or_greater(eth))
-		mtk_m32(eth, 0, MISC_MDC_TURBO, MTK_MAC_MISC_V3);
-
-	/* Configure MDC Divider */
-	val = FIELD_PREP(PPSC_MDC_CFG, divider);
-	if (!mtk_is_netsys_v3_or_greater(eth))
-		val |= PPSC_MDC_TURBO;
-	mtk_m32(eth, PPSC_MDC_CFG, val, MTK_PPSC);
-
-	dev_dbg(eth->dev, "MDC is running on %d Hz\n", MDC_MAX_FREQ / divider);
-
+	eth->mdc_divider = min_t(unsigned int, DIV_ROUND_UP(MDC_MAX_FREQ, max_clk), 63);
+	mtk_mdio_config(eth);
+	dev_dbg(eth->dev, "MDC is running on %d Hz\n", MDC_MAX_FREQ / eth->mdc_divider);
 	ret = of_mdiobus_register(eth->mii_bus, mii_np);
 
 err_put_node:
@@ -3974,6 +3979,10 @@ static int mtk_hw_init(struct mtk_eth *eth, bool reset)
 	else
 		mtk_hw_reset(eth);
 
+	/* No MT7628/88 support yet */
+	if (reset && !MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628))
+		mtk_mdio_config(eth);
+
 	if (mtk_is_netsys_v3_or_greater(eth)) {
 		/* Set FE to PDMAv2 if necessary */
 		val = mtk_r32(eth, MTK_FE_GLO_MISC);
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 90a377ab4359e..39709649ea8d1 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -1271,6 +1271,7 @@ struct mtk_eth {
 	struct clk			*clks[MTK_CLK_MAX];
 
 	struct mii_bus			*mii_bus;
+	unsigned int			mdc_divider;
 	struct work_struct		pending_work;
 	unsigned long			state;
 
-- 
2.49.0

