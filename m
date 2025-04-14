Return-Path: <netdev+bounces-182399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AF0A88AC0
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35BFD3A64F2
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870EB28935A;
	Mon, 14 Apr 2025 18:11:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5BB2749E2;
	Mon, 14 Apr 2025 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744654302; cv=none; b=UZTakHmnoyFPYKWAMApeNoLRyE5KG0mQbhy3DKgz1IDRXQsLe23ijc0yOdS70iozfaTpqURJpID6xDLmqJVfNuats379Z6cU4yPqIpAnR14HR+2QhRFkY4sc5wFzgws/0K2uoykThQiI8wYzjV6O5I9WVeuiGjctSfMuJjRLMnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744654302; c=relaxed/simple;
	bh=L0LuWuYWyu5iFwHL6RLiQ0aKxB+TMYcjnp6vfKBxSFc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=adZEKd4JLEfa0I2Nnf9uZuX11OWxROuJqvYiWKIVFLhnZGBb7M6ksx1mLAshY08pbRBfXI4iom0tFWThSHsavONTG12RN7j7xPYPUoXOfQ1PPnJfnlOsAPp3i7IeiRcABvH1ShO9RvtXmiesy6DDKWKDW6srWGsnLAPFfa70elc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1u4OHE-000000003xa-28sl;
	Mon, 14 Apr 2025 18:11:24 +0000
Date: Mon, 14 Apr 2025 19:11:20 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Bo-Cun Chen <bc-bocun.chen@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
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
Subject: [PATCH net 1/5] net: ethernet: mtk_eth_soc: revise mdc divider
 configuration
Message-ID: <08498e31e830cf0ee1ceb4fc1313d5c528a69150.1744654076.git.daniel@makrotopia.org>
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
of 2.5MHz after the NETSYS SER. Therefore, we need to move the MDC
divider configuration function to mtk_hw_init().

Fixes: c0a440031d431 ("net: ethernet: mtk_eth_soc: set MDIO bus clock frequency")
Signed-off-by: Bo-Cun Chen <bc-bocun.chen@mediatek.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 60 ++++++++++++++-------
 1 file changed, 42 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 43197b28b3e74..fd643cc1b7dd2 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -871,11 +871,11 @@ static const struct phylink_mac_ops mtk_phylink_ops = {
 	.mac_enable_tx_lpi = mtk_mac_enable_tx_lpi,
 };
 
-static int mtk_mdio_init(struct mtk_eth *eth)
+static int mtk_mdio_config(struct mtk_eth *eth)
 {
 	unsigned int max_clk = 2500000, divider;
 	struct device_node *mii_np;
-	int ret;
+	int ret = 0;
 	u32 val;
 
 	mii_np = of_get_available_child_by_name(eth->dev->of_node, "mdio-bus");
@@ -884,22 +884,6 @@ static int mtk_mdio_init(struct mtk_eth *eth)
 		return -ENODEV;
 	}
 
-	eth->mii_bus = devm_mdiobus_alloc(eth->dev);
-	if (!eth->mii_bus) {
-		ret = -ENOMEM;
-		goto err_put_node;
-	}
-
-	eth->mii_bus->name = "mdio";
-	eth->mii_bus->read = mtk_mdio_read_c22;
-	eth->mii_bus->write = mtk_mdio_write_c22;
-	eth->mii_bus->read_c45 = mtk_mdio_read_c45;
-	eth->mii_bus->write_c45 = mtk_mdio_write_c45;
-	eth->mii_bus->priv = eth;
-	eth->mii_bus->parent = eth->dev;
-
-	snprintf(eth->mii_bus->id, MII_BUS_ID_SIZE, "%pOFn", mii_np);
-
 	if (!of_property_read_u32(mii_np, "clock-frequency", &val)) {
 		if (val > MDC_MAX_FREQ || val < MDC_MAX_FREQ / MDC_MAX_DIVIDER) {
 			dev_err(eth->dev, "MDIO clock frequency out of range");
@@ -922,6 +906,42 @@ static int mtk_mdio_init(struct mtk_eth *eth)
 
 	dev_dbg(eth->dev, "MDC is running on %d Hz\n", MDC_MAX_FREQ / divider);
 
+err_put_node:
+	of_node_put(mii_np);
+	return ret;
+}
+
+static int mtk_mdio_init(struct mtk_eth *eth)
+{
+	struct device_node *mii_np;
+	int ret;
+
+	mii_np = of_get_child_by_name(eth->dev->of_node, "mdio-bus");
+	if (!mii_np) {
+		dev_err(eth->dev, "no %s child node found", "mdio-bus");
+		return -ENODEV;
+	}
+
+	if (!of_device_is_available(mii_np)) {
+		ret = -ENODEV;
+		goto err_put_node;
+	}
+
+	eth->mii_bus = devm_mdiobus_alloc(eth->dev);
+	if (!eth->mii_bus) {
+		ret = -ENOMEM;
+		goto err_put_node;
+	}
+
+	eth->mii_bus->name = "mdio";
+	eth->mii_bus->read = mtk_mdio_read_c22;
+	eth->mii_bus->write = mtk_mdio_write_c22;
+	eth->mii_bus->read_c45 = mtk_mdio_read_c45;
+	eth->mii_bus->write_c45 = mtk_mdio_write_c45;
+	eth->mii_bus->priv = eth;
+	eth->mii_bus->parent = eth->dev;
+
+	snprintf(eth->mii_bus->id, MII_BUS_ID_SIZE, "%pOFn", mii_np);
 	ret = of_mdiobus_register(eth->mii_bus, mii_np);
 
 err_put_node:
@@ -3974,6 +3994,10 @@ static int mtk_hw_init(struct mtk_eth *eth, bool reset)
 	else
 		mtk_hw_reset(eth);
 
+	/* No MT7628/88 support yet */
+	if (!MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628))
+		mtk_mdio_config(eth);
+
 	if (mtk_is_netsys_v3_or_greater(eth)) {
 		/* Set FE to PDMAv2 if necessary */
 		val = mtk_r32(eth, MTK_FE_GLO_MISC);
-- 
2.49.0

