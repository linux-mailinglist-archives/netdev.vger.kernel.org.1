Return-Path: <netdev+bounces-244928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C12CCC2B83
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 13:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A51C8302A0AA
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 12:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6F936C0A1;
	Tue, 16 Dec 2025 12:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="Adaifra/"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDAC36BCCC
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 12:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765887439; cv=none; b=c24uESBXvKi/hq8PNE23JnWIv4QHpC5HznQ1BNdIJOR2JExEoD0rVVJdf6CFLaaBcNl+q31zbHc1BBRcHJNQnv+qGYQIWTzAGUm8QuEmq29mCsLserqA+kMQwnKl5z9oYKqcMaPyox38jvjXq+zIGO7+3tIvhRqeXqfjChDVowU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765887439; c=relaxed/simple;
	bh=vuq4eF9sjeQ4XhtBW4fUIOK6VBkbSp52r/WJd8GvaRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElGl41DrDBWv6Ve6watrbb94phdW+M45nv6nnaNJQvGwnDSrVU9ZpUnFK6l9rd+Usx6gsF8ahhV1tftCxhmUI1CGEk4257mbT4X/EPnogd5R9ORl1oZJZWV3VcbXMmNbZDkasKu2jLNNmguVxx/TU2fDYB/wTntTbYiJZhbSjqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=Adaifra/; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20251216121708ba6d10947500020743
        for <netdev@vger.kernel.org>;
        Tue, 16 Dec 2025 13:17:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=kxa/wxHoMM+iUpsXVC+Um989vKgYKN1K4z4nEt1mwcw=;
 b=Adaifra/dnRGT2aB00yBGbiYl1y4bux9DmxCMjp+D3YpK1mqiO/zJstTC6ZlX1xWMNymKN
 32SKBiP84d6ULdp+S6OQfyDKtYGzwzXYLDFpLBGX14Kc6ETBypf1g72LHNDDnBCn5fK7smoF
 s/OWWSFRfmcxLmqyDgXqRls0kEG/YeORmVVHhRZHOWyIkDbeeyKgP8B3DvrTQ+OMwpZqGau9
 c+sAujJBh85QlBeUUD9AKuY9Je0oixNFBiYwsnHH0M/B5oLRW+Ni0G4H3iOo9F/qBEVC5d6n
 KXK3q7QPrQR9qHcHRwZlDVeAvwXC6wqlhHX9XlJ29cje+JEtg9KmJjpw==;
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
Subject: [PATCH net-next v2 2/2] net: dsa: mxl-gsw1xx: Support R(G)MII slew rate configuration
Date: Tue, 16 Dec 2025 13:17:01 +0100
Message-ID: <20251216121705.65156-3-alexander.sverdlin@siemens.com>
In-Reply-To: <20251216121705.65156-1-alexander.sverdlin@siemens.com>
References: <20251216121705.65156-1-alexander.sverdlin@siemens.com>
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

Support newly introduced maxlinear,mii-slew-rate-slow device tree property
to configure R(G)MII interface pins slew rate into "slow" mode. It might be
used to reduce the radiated emissions.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
Changelog:
v2:
- do not hijack gsw1xx_phylink_mac_select_pcs() for configuring the port,
  introduce struct gswip_hw_info::port_setup callback
- actively configure "normal" slew rate (if the new DT property is missing)
- properly use regmap_set_bits() (v1 had reg and value mixed up)

 drivers/net/dsa/lantiq/lantiq_gswip.h        |  1 +
 drivers/net/dsa/lantiq/lantiq_gswip_common.c |  6 +++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.c          | 26 ++++++++++++++++++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.h          |  2 ++
 4 files changed, 35 insertions(+)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.h b/drivers/net/dsa/lantiq/lantiq_gswip.h
index 9c38e51a75e80..3dc6c232a2e7b 100644
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
index 9da39edf8f574..efa7526609a41 100644
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
index 0816c61a47f12..cf35d5a00b7c8 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
@@ -531,6 +531,29 @@ static struct phylink_pcs *gsw1xx_phylink_mac_select_pcs(struct phylink_config *
 	}
 }
 
+static int gsw1xx_port_setup(struct dsa_switch *ds, int port)
+{
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct gsw1xx_priv *gsw1xx_priv;
+	struct gswip_priv *gswip_priv;
+	int ret;
+
+	if (dp->index != GSW1XX_MII_PORT)
+		return 0;
+
+	gswip_priv = ds->priv;
+	gsw1xx_priv = container_of(gswip_priv, struct gsw1xx_priv, gswip);
+
+	if (of_property_read_bool(dp->dn, "maxlinear,mii-slew-rate-slow"))
+		ret = regmap_set_bits(gsw1xx_priv->shell, GSW1XX_SHELL_RGMII_SLEW_CFG,
+				      RGMII_SLEW_CFG_DRV_TXD | RGMII_SLEW_CFG_DRV_TXC);
+	else
+		ret = regmap_clear_bits(gsw1xx_priv->shell, GSW1XX_SHELL_RGMII_SLEW_CFG,
+					RGMII_SLEW_CFG_DRV_TXD | RGMII_SLEW_CFG_DRV_TXC);
+
+	return ret;
+}
+
 static struct regmap *gsw1xx_regmap_init(struct gsw1xx_priv *priv,
 					 const char *name,
 					 unsigned int reg_base,
@@ -674,6 +697,7 @@ static const struct gswip_hw_info gsw12x_data = {
 	.pce_microcode		= &gsw1xx_pce_microcode,
 	.pce_microcode_size	= ARRAY_SIZE(gsw1xx_pce_microcode),
 	.tag_protocol		= DSA_TAG_PROTO_MXL_GSW1XX,
+	.port_setup		= gsw1xx_port_setup,
 };
 
 static const struct gswip_hw_info gsw140_data = {
@@ -687,6 +711,7 @@ static const struct gswip_hw_info gsw140_data = {
 	.pce_microcode		= &gsw1xx_pce_microcode,
 	.pce_microcode_size	= ARRAY_SIZE(gsw1xx_pce_microcode),
 	.tag_protocol		= DSA_TAG_PROTO_MXL_GSW1XX,
+	.port_setup		= gsw1xx_port_setup,
 };
 
 static const struct gswip_hw_info gsw141_data = {
@@ -699,6 +724,7 @@ static const struct gswip_hw_info gsw141_data = {
 	.pce_microcode		= &gsw1xx_pce_microcode,
 	.pce_microcode_size	= ARRAY_SIZE(gsw1xx_pce_microcode),
 	.tag_protocol		= DSA_TAG_PROTO_MXL_GSW1XX,
+	.port_setup		= gsw1xx_port_setup,
 };
 
 /*
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


