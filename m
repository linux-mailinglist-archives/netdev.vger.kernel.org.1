Return-Path: <netdev+bounces-249281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2F3D167BB
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 04:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72293302C115
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 03:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD44314B77;
	Tue, 13 Jan 2026 03:25:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2103148A4;
	Tue, 13 Jan 2026 03:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768274742; cv=none; b=tbHf2w79IT9MsWzFhgcz4YGy4V6kmFFEmI6IrLbjlasLrhG6f81L64gM3+RGVbP6YefUk5JB82SpFjwaVDnj11HVEKMdWqhMi7QTGRIy3qkd4kKk+eNDvzs68ny+YvQ9uNHK1Bi1mwkKGY3Sx4ypdNBDvDW03Xm2N03UNdfJOHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768274742; c=relaxed/simple;
	bh=KdrvYMcxvupREz8+X5lmPGvNhwJvqlpUKwHcIgYMTeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cq8A5ytYdHPrBDv71X17Xd+zIEhaKHnZ7OiYvv8EdZVFOovJDVeNByZLmqiR0YARf4MioGbAdlK9zbIN2RerZb2tfpxrr3JiLcAwZaNcl7+htgC28FKCP7f40EBTCvKue3ZdMUbVgqJO7OyeJza/NmrKRvI5d97BB9m6cTKPiG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vfV2H-000000001MK-00XY;
	Tue, 13 Jan 2026 03:25:37 +0000
Date: Tue, 13 Jan 2026 03:25:34 +0000
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
Subject: [PATCH net-next 3/3] net: dsa: mxl-gsw1xx: add support for Intel
 GSW150
Message-ID: <b179f57a3997a84ae15fd3860c2735a7846d6a6b.1768273936.git.daniel@makrotopia.org>
References: <cover.1768273936.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768273936.git.daniel@makrotopia.org>

Add support for the Intel GSW150 (aka. Lantiq PEB7084) switch IC to
the mxl-gsw1xx driver. This switch comes with 5 Gigabit Ethernet
copper ports (Intel XWAY PHY11G (xRX v1.2 integrated) PHYs) as well as
one GMII/RGMII and one RGMII port.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/lantiq/mxl-gsw1xx.c | 63 ++++++++++++++++++++++++++---
 drivers/net/dsa/lantiq/mxl-gsw1xx.h |  2 +
 2 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
index 4390c2df2e4bd..1c6a5456a5caf 100644
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
@@ -536,10 +544,34 @@ static void gsw1xx_phylink_get_caps(struct dsa_switch *ds, int port,
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
+	case 0: /* port 0~4: built-in 1GE PHYs */
+	case 1:
+	case 2:
+	case 3:
+	case 4:
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  config->supported_interfaces);
+		break;
+	case 5: /* port 5: GMII or RGMII */
+		__set_bit(PHY_INTERFACE_MODE_GMII,
+			  config->supported_interfaces);
+		fallthrough;
+	case 6: /* port 6: RGMII */
+		phy_interface_set_rgmii(config->supported_interfaces);
+		break;
+	}
+
+	gsw1xx_phylink_get_lpi_caps(config);
 }
 
 static struct phylink_pcs *gsw1xx_phylink_mac_select_pcs(struct phylink_config *config,
@@ -795,11 +827,32 @@ static const struct gswip_hw_info gsw141_data = {
 	.tag_protocol		= DSA_TAG_PROTO_MXL_GSW1XX,
 };
 
+static const struct gswip_hw_info gsw150_data = {
+	.max_ports		= GSW150_PORTS,
+	.allowed_cpu_ports	= BIT(5) | BIT(6),
+	.mii_cfg = {
+		[0 ... 7] = -1,
+		[5] = 0,
+		[6] = 10,
+	},
+	.mii_pcdu = {
+		[0 ... 7] = -1,
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
@@ -823,5 +876,5 @@ static struct mdio_driver gsw1xx_driver = {
 mdio_module_driver(gsw1xx_driver);
 
 MODULE_AUTHOR("Daniel Golle <daniel@makrotopia.org>");
-MODULE_DESCRIPTION("Driver for MaxLinear GSW1xx ethernet switch");
+MODULE_DESCRIPTION("Driver for Intel/MaxLinear GSW1xx Ethernet switch");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.h b/drivers/net/dsa/lantiq/mxl-gsw1xx.h
index 8c0298b2b7663..6d2ab81b14dde 100644
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

