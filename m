Return-Path: <netdev+bounces-230900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC66BF162D
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 14:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B076D4F6179
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 12:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D65231A072;
	Mon, 20 Oct 2025 12:57:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AB63176F4;
	Mon, 20 Oct 2025 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965074; cv=none; b=M8nOOvdlZTqxlYlDUZpkJCCrwp6deq/08D1IZNAmcuSWH5drHaxXQMCSVY9BNCMEACuBLNBuyr94v2XMyQDdfXJU7WsZx1/9rBJAMHia8eD8uWeINp3c3KbYoSveb5X/NZJqg92Jx3buOvmFapBnnv3VdwRkDz9qzZ8XQrJcnmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965074; c=relaxed/simple;
	bh=a0dA5ZhDg1uD1DA/m2br9DGCZ278pLIMpQOd9on0hJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C190sg6KTmOYeTRpBJmujll6biY3l7QWIvYXEr3NZTBOMzpmhxOJX/FAfEZfenNqVkgqPqyvWi8vNq11HRZ1JlDlOp/2HzsHzBFfvS+Tp0Sh/T3VSPL5/c7fojeuw2+3d7+QhSX+dspONshgsKFMrDSrTXQz0yQfLjE9eaUAFD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vApSN-000000003rX-32e4;
	Mon, 20 Oct 2025 12:57:47 +0000
Date: Mon, 20 Oct 2025 13:57:44 +0100
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
Subject: [PATCH net-next v4 2/7] net: dsa: lantiq_gswip: convert accessors to
 use regmap
Message-ID: <90ec656a06156ebb8f7ec96dcf12274552d49ba9.1760964550.git.daniel@makrotopia.org>
References: <cover.1760964550.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1760964550.git.daniel@makrotopia.org>

Use regmap for register access in preparation for supporting the MaxLinear
GSW1xx family of switches connected via MDIO or SPI.
Rewrite the existing accessor read-poll-timeout functions to use calls to
the regmap API for now.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: drop error handling, it wasn't there before and it would anyway be
    removed again by a follow-up change

 drivers/net/dsa/lantiq/Kconfig        |   1 +
 drivers/net/dsa/lantiq/lantiq_gswip.c | 107 +++++++++++++++-----------
 drivers/net/dsa/lantiq/lantiq_gswip.h |   6 +-
 3 files changed, 67 insertions(+), 47 deletions(-)

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
index 86b410a40d32..046feba16a2f 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -113,22 +113,22 @@ static const struct gswip_rmon_cnt_desc gswip_rmon_cnt[] = {
 
 static u32 gswip_switch_r(struct gswip_priv *priv, u32 offset)
 {
-	return __raw_readl(priv->gswip + (offset * 4));
+	u32 val;
+
+	regmap_read(priv->gswip, offset, &val);
+
+	return val;
 }
 
 static void gswip_switch_w(struct gswip_priv *priv, u32 val, u32 offset)
 {
-	__raw_writel(val, priv->gswip + (offset * 4));
+	regmap_write(priv->gswip, offset, val);
 }
 
 static void gswip_switch_mask(struct gswip_priv *priv, u32 clear, u32 set,
 			      u32 offset)
 {
-	u32 val = gswip_switch_r(priv, offset);
-
-	val &= ~(clear);
-	val |= set;
-	gswip_switch_w(priv, val, offset);
+	regmap_write_bits(priv->gswip, offset, clear | set, set);
 }
 
 static u32 gswip_switch_r_timeout(struct gswip_priv *priv, u32 offset,
@@ -136,48 +136,34 @@ static u32 gswip_switch_r_timeout(struct gswip_priv *priv, u32 offset,
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
+
+	regmap_read(priv->mdio, offset, &val);
+
+	return val;
 }
 
 static void gswip_mdio_w(struct gswip_priv *priv, u32 val, u32 offset)
 {
-	__raw_writel(val, priv->mdio + (offset * 4));
+	regmap_write(priv->mdio, offset, val);
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
-
-static void gswip_mii_w(struct gswip_priv *priv, u32 val, u32 offset)
-{
-	__raw_writel(val, priv->mii + (offset * 4));
+	regmap_write_bits(priv->mdio, offset, clear | set, set);
 }
 
 static void gswip_mii_mask(struct gswip_priv *priv, u32 clear, u32 set,
 			   u32 offset)
 {
-	u32 val = gswip_mii_r(priv, offset);
-
-	val &= ~(clear);
-	val |= set;
-	gswip_mii_w(priv, val, offset);
+	regmap_write_bits(priv->mii, offset, clear | set, set);
 }
 
 static void gswip_mii_mask_cfg(struct gswip_priv *priv, u32 clear, u32 set,
@@ -220,17 +206,10 @@ static void gswip_mii_mask_pcdu(struct gswip_priv *priv, u32 clear, u32 set,
 
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
@@ -1893,9 +1872,37 @@ static int gswip_validate_cpu_port(struct dsa_switch *ds)
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
@@ -1906,15 +1913,27 @@ static int gswip_probe(struct platform_device *pdev)
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
index 69c8d2deff2d..24d759e06e15 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.h
@@ -263,9 +263,9 @@ struct gswip_vlan {
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
2.51.1.dirty

