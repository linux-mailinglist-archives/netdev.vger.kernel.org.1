Return-Path: <netdev+bounces-250678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7785D38B34
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 02:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B1E3A300ED9B
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 01:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B992773F7;
	Sat, 17 Jan 2026 01:21:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AC1277011;
	Sat, 17 Jan 2026 01:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768612903; cv=none; b=tlgK1P1+AxZAmX522CT6vogz4KdEF/jR2QCus8BiDLhlY+dJ6ZIo+paQa+u+lvk9k1EjUuuoEl+HB0hCitemMQGHPZbYZnuysJ7KFamyH7FZKr/dY1Cb02bONwXfCHfdC5OXKoNPuNwmvNcLTgn5+ATymmm17vMXgjQ0s97LZeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768612903; c=relaxed/simple;
	bh=i3bKr3GUq3j5rU9lxoTZI2SfgJJYbWKr3U1QtgV8h7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAI1W3xqaJjGB93qreZRMPdoWd4LqQ54h0AQyK+ipWCKqzx5BlNNfJv1nr3EtAC34Dg/VChlV1rd2tbcGX43P237f7TlJfcjpURACpb2X2xMVuVVUjbjD47wEl0M8iCPY1o1+Wpizi4pwtRF0+xSzwY/HIimUYOQN/oQcm/zvKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vgv0S-000000005Hi-1z8I;
	Sat, 17 Jan 2026 01:21:36 +0000
Date: Sat, 17 Jan 2026 01:21:33 +0000
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
Cc: Chen Minqiang <ptpt52@gmail.com>, Xinfa Deng <xinfa.deng@gl-inet.com>
Subject: [PATCH net-next v4 6/6] net: dsa: mxl-gsw1xx: add support for Intel
 GSW150
Message-ID: <512b11f4bacf6b4bcc29c80085b58ae1e7b95338.1768612113.git.daniel@makrotopia.org>
References: <cover.1768612113.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768612113.git.daniel@makrotopia.org>

Add support for the Intel GSW150 (aka. Lantiq PEB7084) switch IC to
the mxl-gsw1xx driver. This switch comes with 5 Gigabit Ethernet
copper ports (Intel XWAY PHY11G (xRX v1.2 integrated) PHYs) as well as
one GMII/RGMII and one RGMII port.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v4: spell out mii_cfg and mii_pcdu values in struct gswip_hw_info instead
    of using default initializer which requires diag exception

v3: enclose the gswip_hw_info initializers in compiler diag exception
    to prevent triggering -Woverride-init

v2: clean-up phylink_get_caps

 drivers/net/dsa/lantiq/mxl-gsw1xx.c | 61 ++++++++++++++++++++++++++---
 drivers/net/dsa/lantiq/mxl-gsw1xx.h |  2 +
 2 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
index acc89fba2fcdd..7fc41c371b783 100644
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
@@ -769,11 +799,32 @@ static const struct gswip_hw_info gsw141_data = {
 	.tag_protocol		= DSA_TAG_PROTO_MXL_GSW1XX,
 };
 
+static const struct gswip_hw_info gsw150_data = {
+	.max_ports		= GSW150_PORTS,
+	.allowed_cpu_ports	= BIT(5) | BIT(6),
+	.mii_cfg = {
+		[0 ... 4] = -1,
+		[5] = 0,
+		[6] = 10,
+	},
+	.mii_pcdu = {
+		[0 ... 4] = -1,
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
@@ -797,5 +848,5 @@ static struct mdio_driver gsw1xx_driver = {
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


