Return-Path: <netdev+bounces-249987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE7FD21EB9
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 01:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D19E30034B3
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 00:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CC71F4CBC;
	Thu, 15 Jan 2026 00:58:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3D41E9B3F;
	Thu, 15 Jan 2026 00:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768438698; cv=none; b=VBiBk5va1kVn6/Sd8/C/0a3kgcrJsPhGNtryJiyOOIydL2/9Pxae7VPhyaq75ix0c3Qn4Q5oB+enGmLhath+6HKluXgKNr2L4SDBUEnnr3dt7ZH584s9hI3O1lWEkruR0J8UIqciQcvgRFgaEZya3V9i4+1Cx3x3M2OdVDs5T5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768438698; c=relaxed/simple;
	bh=Jq5fayYZSIno13tZ3ohP2Nj/cABYxi3lKIkTx+Wr4GY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAqENyhh+waKkwSO1YYTGgyyylPB6VeHK06YlqW86rZIYbdG6suBxVpWlj5gkHGBriRB6yhnyjHKFA0/knas2lfcM8EjT5xvsmJz1Kzl0GXmGAWpyG09+U9d+6OY11uDhbJ8V7hCiSKyz9FUy3ugGXl4du5XMP1/6nyQJy9suLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vgBgi-0000000023U-20is;
	Thu, 15 Jan 2026 00:58:12 +0000
Date: Thu, 15 Jan 2026 00:58:09 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 6/6] net: dsa: mxl-gsw1xx: add support for Intel
 GSW150
Message-ID: <03e4cd6bcd469d261b1916b2135437b0403a7455.1768438019.git.daniel@makrotopia.org>
References: <cover.1768438019.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768438019.git.daniel@makrotopia.org>

Add support for the Intel GSW150 (aka. Lantiq PEB7084) switch IC to
the mxl-gsw1xx driver. This switch comes with 5 Gigabit Ethernet
copper ports (Intel XWAY PHY11G (xRX v1.2 integrated) PHYs) as well as
one GMII/RGMII and one RGMII port.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: clean-up phylink_get_caps

 drivers/net/dsa/lantiq/mxl-gsw1xx.c | 61 ++++++++++++++++++++++++++---
 drivers/net/dsa/lantiq/mxl-gsw1xx.h |  2 +
 2 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
index d6258fe3afb8e..508f960524686 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
@@ -502,6 +502,14 @@ static const struct phylink_pcs_ops gsw1xx_pcs_ops = {
 	.pcs_link_up = gsw1xx_pcs_link_up,
 };
 
+static void gsw1xx_phylink_get_lpi_caps(struct phylink_config *config)
+{
+	config->lpi_capabilities = MAC_100FD | MAC_1000FD;
+	config->lpi_timer_default = 20;
+	memcpy(config->lpi_interfaces, config->supported_interfaces,
+	       sizeof(config->lpi_interfaces));
+}
+
 static void gsw1xx_phylink_get_caps(struct dsa_switch *ds, int port,
 				    struct phylink_config *config)
 {
@@ -535,10 +543,32 @@ static void gsw1xx_phylink_get_caps(struct dsa_switch *ds, int port,
 		break;
 	}
 
-	config->lpi_capabilities = MAC_100FD | MAC_1000FD;
-	config->lpi_timer_default = 20;
-	memcpy(config->lpi_interfaces, config->supported_interfaces,
-	       sizeof(config->lpi_interfaces));
+	gsw1xx_phylink_get_lpi_caps(config);
+}
+
+static void gsw150_phylink_get_caps(struct dsa_switch *ds, int port,
+				    struct phylink_config *config)
+{
+	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+				   MAC_10 | MAC_100 | MAC_1000;
+
+	switch (port) {
+	case 0 ... 4: /* built-in PHYs */
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  config->supported_interfaces);
+		break;
+
+	case 5: /* GMII or RGMII */
+		__set_bit(PHY_INTERFACE_MODE_GMII,
+			  config->supported_interfaces);
+		fallthrough;
+
+	case 6: /* RGMII */
+		phy_interface_set_rgmii(config->supported_interfaces);
+		break;
+	}
+
+	gsw1xx_phylink_get_lpi_caps(config);
 }
 
 static struct phylink_pcs *gsw1xx_phylink_mac_select_pcs(struct phylink_config *config,
@@ -763,11 +793,32 @@ static const struct gswip_hw_info gsw141_data = {
 	.tag_protocol		= DSA_TAG_PROTO_MXL_GSW1XX,
 };
 
+static const struct gswip_hw_info gsw150_data = {
+	.max_ports		= GSW150_PORTS,
+	.allowed_cpu_ports	= BIT(5) | BIT(6),
+	.mii_cfg = {
+		[0 ... GSWIP_MAX_PORTS - 1] = -1,
+		[5] = 0,
+		[6] = 10,
+	},
+	.mii_pcdu = {
+		[0 ... GSWIP_MAX_PORTS - 1] = -1,
+		[5] = 1,
+		[6] = 11,
+	},
+	.phylink_get_caps	= gsw150_phylink_get_caps,
+	.pce_microcode		= &gsw1xx_pce_microcode,
+	.pce_microcode_size	= ARRAY_SIZE(gsw1xx_pce_microcode),
+	.tag_protocol		= DSA_TAG_PROTO_MXL_GSW1XX,
+};
+
 /*
  * GSW125 is the industrial temperature version of GSW120.
  * GSW145 is the industrial temperature version of GSW140.
  */
 static const struct of_device_id gsw1xx_of_match[] = {
+	{ .compatible = "intel,gsw150", .data = &gsw150_data },
+	{ .compatible = "lantiq,peb7084", .data = &gsw150_data },
 	{ .compatible = "maxlinear,gsw120", .data = &gsw12x_data },
 	{ .compatible = "maxlinear,gsw125", .data = &gsw12x_data },
 	{ .compatible = "maxlinear,gsw140", .data = &gsw140_data },
@@ -791,5 +842,5 @@ static struct mdio_driver gsw1xx_driver = {
 mdio_module_driver(gsw1xx_driver);
 
 MODULE_AUTHOR("Daniel Golle <daniel@makrotopia.org>");
-MODULE_DESCRIPTION("Driver for MaxLinear GSW1xx ethernet switch");
+MODULE_DESCRIPTION("Driver for Intel/MaxLinear GSW1xx Ethernet switch");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.h b/drivers/net/dsa/lantiq/mxl-gsw1xx.h
index 38e03c048a26c..087587f62e5e1 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.h
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.h
@@ -10,6 +10,8 @@
 #include <linux/bitfield.h>
 
 #define GSW1XX_PORTS				6
+#define GSW150_PORTS				7
+
 /* Port used for RGMII or optional RMII */
 #define GSW1XX_MII_PORT				5
 /* Port used for SGMII */
-- 
2.52.0

