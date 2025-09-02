Return-Path: <netdev+bounces-219370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC93B410D3
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 812AE7B43FE
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E439F27F72C;
	Tue,  2 Sep 2025 23:36:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8531AAA1B;
	Tue,  2 Sep 2025 23:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756856162; cv=none; b=s7BnR02NbnUqt0BEznS4gmjd4a49GMfDS2NN1f5fBWMXqvntO6NBi4L/MoqSW/vZQ21H+GeLoaN8FPmbgq+oyXEkEj0/yn9JZDzbyuoxLic1JskWkxjfX1IsLN8XqZARv9AcShA+bYW8ip0xxUKGVhknV7HuxZKeyHEO/rzQCFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756856162; c=relaxed/simple;
	bh=BQvZJDMZodJlpBViAy9kpZCvOy9n725TV2pRR86zggM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyw6ho6JAD68nBHcPYrDfQUQB2TfgtNNHWaAs2L14YK6j8aN33FZKWoSq1d7EMIKovwXT9GClAgYyV8aHn1ibldIeSrbI08447UldJxSBUcR1H8kB2WNmysHmklXWruUJxjAm+aCfw9ZyzESz/AJgHrRWgQsdkomf7fVnUYzqfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1utaXc-000000001Hh-0hCU;
	Tue, 02 Sep 2025 23:35:56 +0000
Date: Wed, 3 Sep 2025 00:35:52 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
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
Subject: [RFC PATCH net-next 1/6] net: dsa: lantiq_gswip: convert accessors
 to use regmap
Message-ID: <97c2b3d65a0cd550922f809f6e6f51645ccc4ef9.1756855069.git.daniel@makrotopia.org>
References: <cover.1756855069.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756855069.git.daniel@makrotopia.org>

Use regmap for register access in preparation for supporting the MaxLinear
GSW1xx family of switches connected via MDIO or SPI.
Rewrite the existing accessor read-poll-timeout functions to use calls to
the regmap API for now.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq/Kconfig        |   1 +
 drivers/net/dsa/lantiq/lantiq_gswip.c | 143 ++++++++++++++++++--------
 drivers/net/dsa/lantiq/lantiq_gswip.h |   6 +-
 3 files changed, 106 insertions(+), 44 deletions(-)

diff --git a/drivers/net/dsa/lantiq/Kconfig b/drivers/net/dsa/lantiq/Kconfig
index 1cb053c823f7..3cfa16840cf5 100644
--- a/drivers/net/dsa/lantiq/Kconfig
+++ b/drivers/net/dsa/lantiq/Kconfig
@@ -2,6 +2,7 @@ config NET_DSA_LANTIQ_GSWIP
 	tristate "Lantiq / Intel GSWIP"
 	depends on HAS_IOMEM
 	select NET_DSA_TAG_GSWIP
+	select REGMAP
 	help
 	  This enables support for the Lantiq / Intel GSWIP 2.1 found in
 	  the xrx200 / VR9 SoC.
diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index 1d9b9689ef9f..00de075b027a 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -113,22 +113,40 @@ static const struct gswip_rmon_cnt_desc gswip_rmon_cnt[] = {
 
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
+	ret = regmap_write_bits(priv->gswip, offset, clear | set, set);
+	if (ret) {
+		WARN_ON_ONCE(1);
+		dev_err(priv->dev, "failed to update switch register\n");
+	}
 }
 
 static u32 gswip_switch_r_timeout(struct gswip_priv *priv, u32 offset,
@@ -136,48 +154,58 @@ static u32 gswip_switch_r_timeout(struct gswip_priv *priv, u32 offset,
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
+	ret = regmap_write_bits(priv->mdio, offset, clear | set, set);
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
+	ret = regmap_write_bits(priv->mii, offset, clear | set, set);
+	if (ret) {
+		WARN_ON_ONCE(1);
+		dev_err(priv->dev, "failed to update mdio register\n");
+	}
 }
 
 static void gswip_mii_mask_cfg(struct gswip_priv *priv, u32 clear, u32 set,
@@ -220,17 +248,10 @@ static void gswip_mii_mask_pcdu(struct gswip_priv *priv, u32 clear, u32 set,
 
 static int gswip_mdio_poll(struct gswip_priv *priv)
 {
-	int cnt = 100;
-
-	while (likely(cnt--)) {
-		u32 ctrl = gswip_mdio_r(priv, GSWIP_MDIO_CTRL);
-
-		if ((ctrl & GSWIP_MDIO_CTRL_BUSY) == 0)
-			return 0;
-		usleep_range(20, 40);
-	}
+	u32 ctrl;
 
-	return -ETIMEDOUT;
+	return regmap_read_poll_timeout(priv->mdio, GSWIP_MDIO_CTRL, ctrl,
+					!(ctrl & GSWIP_MDIO_CTRL_BUSY), 40, 4000);
 }
 
 static int gswip_mdio_wr(struct mii_bus *bus, int addr, int reg, u16 val)
@@ -1900,9 +1921,37 @@ static int gswip_validate_cpu_port(struct dsa_switch *ds)
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
+	__iomem void *gswip, *mdio, *mii;
 	struct device *dev = &pdev->dev;
 	struct gswip_priv *priv;
 	int err;
@@ -1913,15 +1962,27 @@ static int gswip_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->gswip = devm_platform_ioremap_resource(pdev, 0);
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
+	priv->gswip = devm_regmap_init_mmio(dev, gswip, &sw_regmap_config);
 	if (IS_ERR(priv->gswip))
 		return PTR_ERR(priv->gswip);
 
-	priv->mdio = devm_platform_ioremap_resource(pdev, 1);
+	priv->mdio = devm_regmap_init_mmio(dev, mdio, &mdio_regmap_config);
 	if (IS_ERR(priv->mdio))
 		return PTR_ERR(priv->mdio);
 
-	priv->mii = devm_platform_ioremap_resource(pdev, 2);
+	priv->mii = devm_regmap_init_mmio(dev, mii, &mii_regmap_config);
 	if (IS_ERR(priv->mii))
 		return PTR_ERR(priv->mii);
 
diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.h b/drivers/net/dsa/lantiq/lantiq_gswip.h
index 2df9c8e8cfd0..efc2e9041815 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.h
@@ -257,9 +257,9 @@ struct gswip_vlan {
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
2.51.0

