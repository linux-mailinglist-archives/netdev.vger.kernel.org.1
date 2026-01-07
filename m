Return-Path: <netdev+bounces-247644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D6ACFCB5E
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 10:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74EA03060A5B
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 09:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AD92F747A;
	Wed,  7 Jan 2026 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="Ht0tcx+y"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3AD2F5A35
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767776480; cv=none; b=XcvIewOhstolOoZ1L0RgU/crF761YSAgdvmmCDGNyj9YAwsoLIbSjp/LLYs2AarT/nTapgPAX4BapEr+tm9iT0mPz5AZxNi1q8O0EHt43ebeVAdiFrTeUYgvJrVp8ea5wb6u2haVKRrBeGdbjF0xzRb/ryympjkzMY2Vn95vUqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767776480; c=relaxed/simple;
	bh=H3OnxDRAS0shDLGQ0ZLvYwcLOKNCjkTwY0TUegqfDwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVIRLEAQsEZjeg510JKLMYzf4lxb9rlk0/Nkh61jHhszEG9MRtwqbwUICbiBpUVkUeQGHDkTB2lH577KY5HlnHP18cY0KywOoa/mG2go739/o8fWuZ++E+S3ZjRL+6xronGM0Mglb5XhZ56JhUbg2XVh3Hy7yYpVSsQfX0O9Gm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=Ht0tcx+y; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202601070900224801a48a020002071c
        for <netdev@vger.kernel.org>;
        Wed, 07 Jan 2026 10:01:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=XGRkifYiNIH0MU4OanM2O++Y3tzI7py9j4qll4AuISw=;
 b=Ht0tcx+yV0eHTJomDzPZ3/QgnNF6rKOuMqPEdYfHFc3I8rvs6TkBU6NRA1oDHB9BYYB4cP
 z06eX9w1Gdw9G+JBFRhScr/tZGINWdJLOQvSfy8gJ2ulZvoeYnqFAShQf1nUH9V+BX9OQsEh
 ev8btOB/TVUFqJVtujDzhdb787W5XqbTDo8Iwmiugqm6B/Uyah02UAq0Px5XOQnob6bUQF8s
 4VJ4OxZKmzkzw0C0qrOfT3osby/G0K+Dymq2icU5XsBs57QIOHbu4CAer4Ns9qeY94ni+5L0
 EVTh/AvLI/O7+vO8ru2EirE444lGTdvbnyEENxjAdEP20kzNDkMYca2Q==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: netdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH net-next v4 2/2] net: dsa: mxl-gsw1xx: Support R(G)MII slew rate configuration
Date: Wed,  7 Jan 2026 10:00:17 +0100
Message-ID: <20260107090019.2257867-3-alexander.sverdlin@siemens.com>
In-Reply-To: <20260107090019.2257867-1-alexander.sverdlin@siemens.com>
References: <20260107090019.2257867-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Support newly introduced maxlinear,slew-rate-txc and
maxlinear,slew-rate-txd device tree properties to configure R(G)MII
interface pins' slew rate. It might be used to reduce the radiated
emissions.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
Changelog:
v4:
- separate properties for TXD and TXC pads
v3:
- use [pinctrl] standard "slew-rate" property as suggested by Rob
  https://lore.kernel.org/all/20251219204324.GA3881969-robh@kernel.org/
- better sorted struct gswip_hw_info initialisers as suggested by Daniel
v2:
- do not hijack gsw1xx_phylink_mac_select_pcs() for configuring the port,
  introduce struct gswip_hw_info::port_setup callback
- actively configure "normal" slew rate (if the new DT property is missing)
- properly use regmap_set_bits() (v1 had reg and value mixed up)

 drivers/net/dsa/lantiq/lantiq_gswip.h        |  1 +
 drivers/net/dsa/lantiq/lantiq_gswip_common.c |  6 +++
 drivers/net/dsa/lantiq/mxl-gsw1xx.c          | 40 ++++++++++++++++++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.h          |  2 +
 4 files changed, 49 insertions(+)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.h b/drivers/net/dsa/lantiq/lantiq_gswip.h
index 2e0f2afbadbbc..8fc4c7cc5283a 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.h
@@ -263,6 +263,7 @@ struct gswip_hw_info {
 				 struct phylink_config *config);
 	struct phylink_pcs *(*mac_select_pcs)(struct phylink_config *config,
 					      phy_interface_t interface);
+	int (*port_setup)(struct dsa_switch *ds, int port);
 };
 
 struct gswip_gphy_fw {
diff --git a/drivers/net/dsa/lantiq/lantiq_gswip_common.c b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
index e790f2ef75884..17a61e445f00f 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip_common.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
@@ -425,6 +425,12 @@ static int gswip_port_setup(struct dsa_switch *ds, int port)
 	struct gswip_priv *priv = ds->priv;
 	int err;
 
+	if (priv->hw_info->port_setup) {
+		err = priv->hw_info->port_setup(ds, port);
+		if (err)
+			return err;
+	}
+
 	if (!dsa_is_cpu_port(ds, port)) {
 		err = gswip_add_single_port_br(priv, port, true);
 		if (err)
diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
index f8ff8a604bf53..6afc7539fefbe 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
@@ -559,6 +559,43 @@ static struct phylink_pcs *gsw1xx_phylink_mac_select_pcs(struct phylink_config *
 	}
 }
 
+static int gsw1xx_rmii_slew_rate(const struct device_node *np, struct gsw1xx_priv *priv,
+				 const char *prop, u16 mask)
+{
+	u32 rate;
+	int ret;
+
+	ret = of_property_read_u32(np, prop, &rate);
+	/* Optional property */
+	if (ret == -EINVAL)
+		return 0;
+	if (ret < 0 || rate > 1) {
+		dev_err(&priv->mdio_dev->dev, "Invalid %s value\n", prop);
+		return (ret < 0) ? ret : -EINVAL;
+	}
+
+	return regmap_update_bits(priv->shell, GSW1XX_SHELL_RGMII_SLEW_CFG, mask, mask * rate);
+}
+
+static int gsw1xx_port_setup(struct dsa_switch *ds, int port)
+{
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct device_node *np = dp->dn;
+	struct gsw1xx_priv *gsw1xx_priv;
+	struct gswip_priv *gswip_priv;
+
+	if (dp->index != GSW1XX_MII_PORT)
+		return 0;
+
+	gswip_priv = ds->priv;
+	gsw1xx_priv = container_of(gswip_priv, struct gsw1xx_priv, gswip);
+
+	return gsw1xx_rmii_slew_rate(np, gsw1xx_priv,
+				     "maxlinear,slew-rate-txc", RGMII_SLEW_CFG_DRV_TXC) ?:
+	       gsw1xx_rmii_slew_rate(np, gsw1xx_priv,
+				     "maxlinear,slew-rate-txd", RGMII_SLEW_CFG_DRV_TXD);
+}
+
 static struct regmap *gsw1xx_regmap_init(struct gsw1xx_priv *priv,
 					 const char *name,
 					 unsigned int reg_base,
@@ -707,6 +744,7 @@ static const struct gswip_hw_info gsw12x_data = {
 	.mac_select_pcs		= gsw1xx_phylink_mac_select_pcs,
 	.phylink_get_caps	= &gsw1xx_phylink_get_caps,
 	.supports_2500m		= true,
+	.port_setup		= gsw1xx_port_setup,
 	.pce_microcode		= &gsw1xx_pce_microcode,
 	.pce_microcode_size	= ARRAY_SIZE(gsw1xx_pce_microcode),
 	.tag_protocol		= DSA_TAG_PROTO_MXL_GSW1XX,
@@ -720,6 +758,7 @@ static const struct gswip_hw_info gsw140_data = {
 	.mac_select_pcs		= gsw1xx_phylink_mac_select_pcs,
 	.phylink_get_caps	= &gsw1xx_phylink_get_caps,
 	.supports_2500m		= true,
+	.port_setup		= gsw1xx_port_setup,
 	.pce_microcode		= &gsw1xx_pce_microcode,
 	.pce_microcode_size	= ARRAY_SIZE(gsw1xx_pce_microcode),
 	.tag_protocol		= DSA_TAG_PROTO_MXL_GSW1XX,
@@ -732,6 +771,7 @@ static const struct gswip_hw_info gsw141_data = {
 	.mii_port_reg_offset	= -GSW1XX_MII_PORT,
 	.mac_select_pcs		= gsw1xx_phylink_mac_select_pcs,
 	.phylink_get_caps	= gsw1xx_phylink_get_caps,
+	.port_setup		= gsw1xx_port_setup,
 	.pce_microcode		= &gsw1xx_pce_microcode,
 	.pce_microcode_size	= ARRAY_SIZE(gsw1xx_pce_microcode),
 	.tag_protocol		= DSA_TAG_PROTO_MXL_GSW1XX,
diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.h b/drivers/net/dsa/lantiq/mxl-gsw1xx.h
index 38e03c048a26c..8c0298b2b7663 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.h
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.h
@@ -110,6 +110,8 @@
 #define   GSW1XX_RST_REQ_SGMII_SHELL		BIT(5)
 /* RGMII PAD Slew Control Register */
 #define  GSW1XX_SHELL_RGMII_SLEW_CFG		0x78
+#define   RGMII_SLEW_CFG_DRV_TXC		BIT(2)
+#define   RGMII_SLEW_CFG_DRV_TXD		BIT(3)
 #define   RGMII_SLEW_CFG_RX_2_5_V		BIT(4)
 #define   RGMII_SLEW_CFG_TX_2_5_V		BIT(5)
 
-- 
2.52.0


