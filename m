Return-Path: <netdev+bounces-247163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 856DDCF51EA
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 18:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A9BF300CF2D
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 17:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C68F344045;
	Mon,  5 Jan 2026 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="e94qT/xt"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1497033BBC4
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767635922; cv=none; b=Zx1BMlQIjOGmDPh7mpO8OkRmCqGvvze0YMwr5bm6bn95ocJP2bt3GneRTygqyGSRHv5iMJgl+SK1rX/+sSBKm+WB9Hh2nf8hc+0uQR9+yo/0dZxvvDxso3unWISKzNjJ5iylmOipjYJNVUkMwgl1Choda2bQkoTMDsHx3h3HzI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767635922; c=relaxed/simple;
	bh=EBm/YQI9I0Cx3kFnWopwMJkeOGt2puAwe2xLZXInpPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cQPizVAHncOhlrN6AsAyUHWuNH8GZX6NDMDZrn8Fmsk+xWuUY2XKzZ5FLHWPJ952Jj9Z7cZ/xhrxlWoOTeq1ePIJRumgFpW1LAsC6V8r/mmD5jXKOt/Pf4UEhQXRqv5E2qq+dk2aLcAecQw1iSu0mchXB77AUHzCkNhyGstLRZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=e94qT/xt; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202601051758385d66aa81c2000207a0
        for <netdev@vger.kernel.org>;
        Mon, 05 Jan 2026 18:58:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=+cNctosICkbQmisl8GDG+alFgnVkKRXfvi6QE6hmyKU=;
 b=e94qT/xtgibjOp9wZmp6uZmhHapD46ZnCHj+N/Rgd0a8wIKuVzhjzCUuH4bjJjJs4kznDl
 ENS6gEtHPTzqFNdHBwPwJCsffS0dGPIgct7tj+DzlsBYlbLIr/Wxsf5D228Gez6FXxOkGh3M
 l0dc9gj0EsjbCMjDthpldAH9alkUDGpu3C5UudFugXtYsu0UHXps700EutAmrDSnZYFagi6r
 ZrRUOJ+LTD+cA+NGldgbNVZdRCoYClvjH7jnyumeL6kilhbx2HfK8XxFDHEC/CTYBfkx9JG9
 +3TTbBshLChGNZ/t4tGkDEJ4k3AtE6hMy0Pp2kNVNCX3BzTV8Omdm/jA==;
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
Subject: [PATCH net-next v3 2/2] net: dsa: mxl-gsw1xx: Support R(G)MII slew rate configuration
Date: Mon,  5 Jan 2026 18:58:34 +0100
Message-ID: <20260105175836.2142263-1-alexander.sverdlin@siemens.com>
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

Support newly introduced slew-rate device tree property to configure
R(G)MII interface pins slew rate. It might be used to reduce the radiated
emissions.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
Changelog:
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
 drivers/net/dsa/lantiq/lantiq_gswip_common.c |  6 ++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.c          | 31 ++++++++++++++++++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.h          |  2 ++
 4 files changed, 40 insertions(+)

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
index f8ff8a604bf53..6c290bac537ad 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
@@ -559,6 +559,34 @@ static struct phylink_pcs *gsw1xx_phylink_mac_select_pcs(struct phylink_config *
 	}
 }
 
+static int gsw1xx_port_setup(struct dsa_switch *ds, int port)
+{
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	struct gsw1xx_priv *gsw1xx_priv;
+	struct gswip_priv *gswip_priv;
+	u32 rate;
+	int ret;
+
+	if (dp->index != GSW1XX_MII_PORT)
+		return 0;
+
+	gswip_priv = ds->priv;
+	gsw1xx_priv = container_of(gswip_priv, struct gsw1xx_priv, gswip);
+
+	ret = of_property_read_u32(dp->dn, "slew-rate", &rate);
+	/* Optional property */
+	if (ret == -EINVAL)
+		return 0;
+	if (ret < 0 || rate > 1) {
+		dev_err(&gsw1xx_priv->mdio_dev->dev, "Invalid slew-rate\n");
+		return (ret < 0) ? ret : -EINVAL;
+	}
+
+	return regmap_update_bits(gsw1xx_priv->shell, GSW1XX_SHELL_RGMII_SLEW_CFG,
+				  RGMII_SLEW_CFG_DRV_TXD | RGMII_SLEW_CFG_DRV_TXC,
+				  (RGMII_SLEW_CFG_DRV_TXD | RGMII_SLEW_CFG_DRV_TXC) * rate);
+}
+
 static struct regmap *gsw1xx_regmap_init(struct gsw1xx_priv *priv,
 					 const char *name,
 					 unsigned int reg_base,
@@ -707,6 +735,7 @@ static const struct gswip_hw_info gsw12x_data = {
 	.mac_select_pcs		= gsw1xx_phylink_mac_select_pcs,
 	.phylink_get_caps	= &gsw1xx_phylink_get_caps,
 	.supports_2500m		= true,
+	.port_setup		= gsw1xx_port_setup,
 	.pce_microcode		= &gsw1xx_pce_microcode,
 	.pce_microcode_size	= ARRAY_SIZE(gsw1xx_pce_microcode),
 	.tag_protocol		= DSA_TAG_PROTO_MXL_GSW1XX,
@@ -720,6 +749,7 @@ static const struct gswip_hw_info gsw140_data = {
 	.mac_select_pcs		= gsw1xx_phylink_mac_select_pcs,
 	.phylink_get_caps	= &gsw1xx_phylink_get_caps,
 	.supports_2500m		= true,
+	.port_setup		= gsw1xx_port_setup,
 	.pce_microcode		= &gsw1xx_pce_microcode,
 	.pce_microcode_size	= ARRAY_SIZE(gsw1xx_pce_microcode),
 	.tag_protocol		= DSA_TAG_PROTO_MXL_GSW1XX,
@@ -732,6 +762,7 @@ static const struct gswip_hw_info gsw141_data = {
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


