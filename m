Return-Path: <netdev+bounces-214343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F983B29074
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 21:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FFCFAE775B
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 19:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070FE22618F;
	Sat, 16 Aug 2025 19:56:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035A0222575;
	Sat, 16 Aug 2025 19:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755374174; cv=none; b=jgZ+XqK0V+PYYMchColSbyspZiJLtlsT8I7q5GMcQ4oAdSkQkI4xYYd9TPs020DdoMj6KU+ODfcNamLVOZ1cvjs0tChB8ouPMUZzZBC7ZkVqQifRg00e091Zc2bAhzHQ9QeQ4PpI/IOpkN4pTlr+V3yejFo32cXKmbVjh3p6E2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755374174; c=relaxed/simple;
	bh=kg6RLLCk2stGfRvV5bp2knnJBCW9Kq/BGqjkFyhmg5c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W5Vc6wQY9Aqp4M9qCVXG/X2m5BQU6XtiLTq2ZzSVADCOycVNCfvcUKNlsE814LGeqFEFOo7iCwl9bMowlp0zacisIAZBLyp1UjWiY8EMem1UbFxyDM2nl0To0C5ACgtH0PHZBqAWFX0AkNKlpY/wXlqnIG5wX8L/SLZj+i0is9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1unN0X-00000000772-1QUk;
	Sat, 16 Aug 2025 19:56:05 +0000
Date: Sat, 16 Aug 2025 20:56:01 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Arkadi Sharshevsky <arkadis@mellanox.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH RFC net-next 18/23] net: dsa: lantiq_gswip: convert to use
 regmap
Message-ID: <aKDiUb084FhsmsTv@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use regmap for register access in preparation for supporting the MaxLinear
GSW1xx family of switches connected via MDIO or SPI.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/Kconfig        |   1 +
 drivers/net/dsa/lantiq_gswip.c | 157 +++++++++++++++++++++++----------
 drivers/net/dsa/lantiq_gswip.h |   6 +-
 3 files changed, 114 insertions(+), 50 deletions(-)

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index ec759f8cb0e2..26e54958e61e 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -30,6 +30,7 @@ config NET_DSA_LANTIQ_GSWIP
 	tristate "Lantiq / Intel GSWIP"
 	depends on HAS_IOMEM
 	select NET_DSA_TAG_GSWIP
+	select REGMAP
 	help
 	  This enables support for the Lantiq / Intel GSWIP 2.1 found in
 	  the xrx200 / VR9 SoC.
diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 6a263a0387d1..2d91f5c79439 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -115,22 +115,41 @@ static const struct gswip_rmon_cnt_desc gswip_rmon_cnt[] = {
 
 static u32 gswip_switch_r(struct gswip_priv *priv, u32 offset)
 {
-	return __raw_readl(priv->gswip + (offset * 4));
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(priv->gswip, offset, &val);
+	if (ret) {
+		WARN_ON_ONCE(1);
+		dev_err(priv->dev, "failed to read switch register\n");
+		return 0;
+	}
+
+	return val;
 }
 
 static void gswip_switch_w(struct gswip_priv *priv, u32 val, u32 offset)
 {
-	__raw_writel(val, priv->gswip + (offset * 4));
+	int ret;
+
+	ret = regmap_write(priv->gswip, offset, val);
+	if (ret) {
+		WARN_ON_ONCE(1);
+		dev_err(priv->dev, "failed to write switch register\n");
+	}
 }
 
 static void gswip_switch_mask(struct gswip_priv *priv, u32 clear, u32 set,
 			      u32 offset)
 {
-	u32 val = gswip_switch_r(priv, offset);
+	int ret;
 
-	val &= ~(clear);
-	val |= set;
-	gswip_switch_w(priv, val, offset);
+	ret = regmap_update_bits_base(priv->gswip, offset, clear | set, set,
+				      NULL, false, true);
+	if (ret) {
+		WARN_ON_ONCE(1);
+		dev_err(priv->dev, "failed to update switch register\n");
+	}
 }
 
 static u32 gswip_switch_r_timeout(struct gswip_priv *priv, u32 offset,
@@ -138,48 +157,60 @@ static u32 gswip_switch_r_timeout(struct gswip_priv *priv, u32 offset,
 {
 	u32 val;
 
-	return readx_poll_timeout(__raw_readl, priv->gswip + (offset * 4), val,
-				  (val & cleared) == 0, 20, 50000);
+	return regmap_read_poll_timeout(priv->gswip, offset, val,
+					!(val & cleared), 20, 50000);
 }
 
 static u32 gswip_mdio_r(struct gswip_priv *priv, u32 offset)
 {
-	return __raw_readl(priv->mdio + (offset * 4));
+	u32 val;
+	int ret;
+
+	ret = regmap_read(priv->mdio, offset, &val);
+	if (ret) {
+		WARN_ON_ONCE(1);
+		dev_err(priv->dev, "failed to read mdio register\n");
+		return 0;
+	}
+
+	return val;
 }
 
 static void gswip_mdio_w(struct gswip_priv *priv, u32 val, u32 offset)
 {
-	__raw_writel(val, priv->mdio + (offset * 4));
+	int ret;
+
+	ret = regmap_write(priv->mdio, offset, val);
+	if (ret) {
+		WARN_ON_ONCE(1);
+		dev_err(priv->dev, "failed to write mdio register\n");
+	}
 }
 
 static void gswip_mdio_mask(struct gswip_priv *priv, u32 clear, u32 set,
 			    u32 offset)
 {
-	u32 val = gswip_mdio_r(priv, offset);
-
-	val &= ~(clear);
-	val |= set;
-	gswip_mdio_w(priv, val, offset);
-}
-
-static u32 gswip_mii_r(struct gswip_priv *priv, u32 offset)
-{
-	return __raw_readl(priv->mii + (offset * 4));
-}
+	int ret;
 
-static void gswip_mii_w(struct gswip_priv *priv, u32 val, u32 offset)
-{
-	__raw_writel(val, priv->mii + (offset * 4));
+	ret = regmap_update_bits_base(priv->mdio, offset, clear | set, set,
+				      NULL, false, true);
+	if (ret) {
+		WARN_ON_ONCE(1);
+		dev_err(priv->dev, "failed to update mdio register\n");
+	}
 }
 
 static void gswip_mii_mask(struct gswip_priv *priv, u32 clear, u32 set,
 			   u32 offset)
 {
-	u32 val = gswip_mii_r(priv, offset);
+	int ret;
 
-	val &= ~(clear);
-	val |= set;
-	gswip_mii_w(priv, val, offset);
+	ret = regmap_update_bits_base(priv->mii, offset, clear | set, set, NULL,
+				      false, true);
+	if (ret) {
+		WARN_ON_ONCE(1);
+		dev_err(priv->dev, "failed to update mdio register\n");
+	}
 }
 
 static void gswip_mii_mask_cfg(struct gswip_priv *priv, u32 clear, u32 set,
@@ -222,17 +253,10 @@ static void gswip_mii_mask_pcdu(struct gswip_priv *priv, u32 clear, u32 set,
 
 static int gswip_mdio_poll(struct gswip_priv *priv)
 {
-	int cnt = 100;
-
-	while (likely(cnt--)) {
-		u32 ctrl = gswip_mdio_r(priv, GSWIP_MDIO_CTRL);
+	u32 ctrl;
 
-		if ((ctrl & GSWIP_MDIO_CTRL_BUSY) == 0)
-			return 0;
-		usleep_range(20, 40);
-	}
-
-	return -ETIMEDOUT;
+	return regmap_read_poll_timeout(priv->mdio, GSWIP_MDIO_CTRL, ctrl,
+					!(ctrl & GSWIP_MDIO_CTRL_BUSY), 40, 4000);
 }
 
 static int gswip_mdio_wr(struct mii_bus *bus, int addr, int reg, u16 val)
@@ -2031,11 +2055,41 @@ static int gswip_allocate_vlans(struct gswip_priv *priv)
 	return 0;
 }
 
+static const struct regmap_config sw_regmap_config = {
+	.name = "switch",
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_shift = -2,
+	.val_format_endian = REGMAP_ENDIAN_NATIVE,
+	.max_register = GSWIP_SDMA_PCTRLp(6),
+};
+
+static const struct regmap_config mdio_regmap_config = {
+	.name = "mdio",
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_shift = -2,
+	.val_format_endian = REGMAP_ENDIAN_NATIVE,
+	.max_register = GSWIP_MDIO_PHYp(0),
+};
+
+static const struct regmap_config mii_regmap_config = {
+	.name = "mii",
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_shift = -2,
+	.val_format_endian = REGMAP_ENDIAN_NATIVE,
+	.max_register = GSWIP_MII_CFGp(6),
+};
+
 static int gswip_probe(struct platform_device *pdev)
 {
 	struct device_node *np, *gphy_fw_np;
 	struct device *dev = &pdev->dev;
 	struct gswip_priv *priv;
+	__iomem void *gswip;
+	__iomem void *mdio;
+	__iomem void *mii;
 	int err;
 	int i;
 
@@ -2043,17 +2097,26 @@ static int gswip_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->gswip = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(priv->gswip))
-		return PTR_ERR(priv->gswip);
+	gswip = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(gswip))
+		return PTR_ERR(gswip);
+
+	mdio = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(mdio))
+		return PTR_ERR(mdio);
+
+	mii = devm_platform_ioremap_resource(pdev, 2);
+	if (IS_ERR(mii))
+		return PTR_ERR(mii);
+
+	priv->gswip = devm_regmap_init_mmio(&pdev->dev, gswip,
+					    &sw_regmap_config);
 
-	priv->mdio = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(priv->mdio))
-		return PTR_ERR(priv->mdio);
+	priv->mdio = devm_regmap_init_mmio(&pdev->dev, mdio,
+					   &mdio_regmap_config);
 
-	priv->mii = devm_platform_ioremap_resource(pdev, 2);
-	if (IS_ERR(priv->mii))
-		return PTR_ERR(priv->mii);
+	priv->mii = devm_regmap_init_mmio(&pdev->dev, mii,
+					  &mii_regmap_config);
 
 	priv->hw_info = of_device_get_match_data(dev);
 	if (!priv->hw_info)
diff --git a/drivers/net/dsa/lantiq_gswip.h b/drivers/net/dsa/lantiq_gswip.h
index 1b97842b77e7..8efe298a5be3 100644
--- a/drivers/net/dsa/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq_gswip.h
@@ -270,9 +270,9 @@ struct gswip_vlan {
 };
 
 struct gswip_priv {
-	__iomem void *gswip;
-	__iomem void *mdio;
-	__iomem void *mii;
+	struct regmap *gswip;
+	struct regmap *mdio;
+	struct regmap *mii;
 	const struct gswip_hw_info *hw_info;
 	const struct xway_gphy_match_data *gphy_fw_name_cfg;
 	struct dsa_switch *ds;
-- 
2.50.1

