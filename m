Return-Path: <netdev+bounces-250791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D760ED3925D
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 04:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8AB33013EC2
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 03:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E822356A4;
	Sun, 18 Jan 2026 03:22:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51AB1FBC8C;
	Sun, 18 Jan 2026 03:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768706543; cv=none; b=el7eWElpx04QtKimyXJ7x8J1X5KezGAHe0G0yWEsjItmqMfQQ7IUkj6o8aQJHWu3HBd0/kkGNxSRT4Mxd/cY/OW6ZnhX1AhzqDE9x20YRcy/YF0JGMLSDcn3TpVgmMap1aXxe1P6m3fjWpklwCpK6ShyF8ohGjoAxUfYEhsrmFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768706543; c=relaxed/simple;
	bh=i4GUx2BXRZEd9YqFVANT1HZyNcRluQRUF9KwrgKPsxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odcN5MhML42/FMYgyxr1zeFJlFy77w1bwOZpQmFast07E81VP1jVoXpqoYTgdDlF62V1WSaLV8CQrqE73dMH8yQeCUOlwhHEd2tTOjl1dzSm4QhCqFKX9R1SgSVjoYTgtpFajI7OJBjLTkaK6ptQyrQGa8nzMhuZwkHm+o6Wjwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vhJMn-000000000dw-1Fai;
	Sun, 18 Jan 2026 03:22:17 +0000
Date: Sun, 18 Jan 2026 03:22:08 +0000
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
Subject: [PATCH net-next v5 3/6] net: dsa: lantiq: allow arbitrary MII
 registers
Message-ID: <920ad57b333c1d88265ade78c49e68c02f129ed5.1768704116.git.daniel@makrotopia.org>
References: <cover.1768704116.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768704116.git.daniel@makrotopia.org>

The Lantiq GSWIP and MaxLinear GSW1xx drivers are currently relying on a
hard-coded mapping of MII ports to their respective MII_CFG and MII_PCDU
registers and only allow applying an offset to the port index.

While this is sufficient for the currently supported hardware, the very
similar Intel GSW150 (aka. Lantiq PEB7084) cannot be described using
this arrangement.

Introduce two arrays to specify the MII_CFG and MII_PCDU registers for
each port, replacing the current bitmap used to safeguard MII ports as
well as the port index offset.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v5: fix wrong indexes in array initializers

v4: spell out mii_cfg and mii_pcdu values in struct gswip_hw_info instead
    of using default initializer which requires diag exception

v3: enclose the gswip_hw_info initializers in compiler diag exception
    to prevent triggering -Woverride-init

v2: introduce GSWIP_MAX_PORTS macro

 drivers/net/dsa/lantiq/lantiq_gswip.c        | 34 ++++++++++++++----
 drivers/net/dsa/lantiq/lantiq_gswip.h        |  6 ++--
 drivers/net/dsa/lantiq/lantiq_gswip_common.c | 27 +++------------
 drivers/net/dsa/lantiq/mxl-gsw1xx.c          | 36 ++++++++++++++++----
 4 files changed, 66 insertions(+), 37 deletions(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index b094001a7c805..0377fc0079b54 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -463,10 +463,22 @@ static void gswip_shutdown(struct platform_device *pdev)
 }
 
 static const struct gswip_hw_info gswip_xrx200 = {
-	.max_ports = 7,
+	.max_ports = GSWIP_MAX_PORTS,
 	.allowed_cpu_ports = BIT(6),
-	.mii_ports = BIT(0) | BIT(1) | BIT(5),
-	.mii_port_reg_offset = 0,
+	.mii_cfg = {
+		[0] = GSWIP_MII_CFGp(0),
+		[1] = GSWIP_MII_CFGp(1),
+		[2 ... 4] = -1,
+		[5] = GSWIP_MII_CFGp(5),
+		[6] = -1,
+	},
+	.mii_pcdu = {
+		[0] = GSWIP_MII_PCDU0,
+		[1] = GSWIP_MII_PCDU1,
+		[2 ... 4] = -1,
+		[5] = GSWIP_MII_PCDU5,
+		[6] = -1,
+	},
 	.phylink_get_caps = gswip_xrx200_phylink_get_caps,
 	.pce_microcode = &gswip_pce_microcode,
 	.pce_microcode_size = ARRAY_SIZE(gswip_pce_microcode),
@@ -474,10 +486,20 @@ static const struct gswip_hw_info gswip_xrx200 = {
 };
 
 static const struct gswip_hw_info gswip_xrx300 = {
-	.max_ports = 7,
+	.max_ports = GSWIP_MAX_PORTS,
 	.allowed_cpu_ports = BIT(6),
-	.mii_ports = BIT(0) | BIT(5),
-	.mii_port_reg_offset = 0,
+	.mii_cfg = {
+		[0] = GSWIP_MII_CFGp(0),
+		[1 ... 4] = -1,
+		[5] = GSWIP_MII_CFGp(5),
+		[6] = -1,
+	},
+	.mii_pcdu = {
+		[0] = GSWIP_MII_PCDU0,
+		[1 ... 4] = -1,
+		[5] = GSWIP_MII_PCDU5,
+		[6] = -1,
+	},
 	.phylink_get_caps = gswip_xrx300_phylink_get_caps,
 	.pce_microcode = &gswip_pce_microcode,
 	.pce_microcode_size = ARRAY_SIZE(gswip_pce_microcode),
diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.h b/drivers/net/dsa/lantiq/lantiq_gswip.h
index 2e0f2afbadbbc..524289db7c213 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.h
@@ -243,6 +243,8 @@
 
 #define GSWIP_VLAN_UNAWARE_PVID	0
 
+#define GSWIP_MAX_PORTS		7
+
 struct gswip_pce_microcode {
 	u16 val_3;
 	u16 val_2;
@@ -253,8 +255,8 @@ struct gswip_pce_microcode {
 struct gswip_hw_info {
 	int max_ports;
 	unsigned int allowed_cpu_ports;
-	unsigned int mii_ports;
-	int mii_port_reg_offset;
+	s16 mii_cfg[GSWIP_MAX_PORTS];
+	s16 mii_pcdu[GSWIP_MAX_PORTS];
 	bool supports_2500m;
 	const struct gswip_pce_microcode (*pce_microcode)[];
 	size_t pce_microcode_size;
diff --git a/drivers/net/dsa/lantiq/lantiq_gswip_common.c b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
index e790f2ef75884..05b28b540661a 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip_common.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
@@ -118,15 +118,11 @@ static u32 gswip_switch_r_timeout(struct gswip_priv *priv, u32 offset,
 static void gswip_mii_mask_cfg(struct gswip_priv *priv, u32 mask, u32 set,
 			       int port)
 {
-	int reg_port;
-
 	/* MII_CFG register only exists for MII ports */
-	if (!(priv->hw_info->mii_ports & BIT(port)))
+	if (priv->hw_info->mii_cfg[port] == -1)
 		return;
 
-	reg_port = port + priv->hw_info->mii_port_reg_offset;
-
-	regmap_write_bits(priv->mii, GSWIP_MII_CFGp(reg_port), mask,
+	regmap_write_bits(priv->mii, priv->hw_info->mii_cfg[port], mask,
 			  set);
 }
 
@@ -604,28 +600,13 @@ static void gswip_mii_delay_setup(struct gswip_priv *priv, struct dsa_port *dp,
 	u32 tx_delay = GSWIP_MII_PCDU_TXDLY_DEFAULT;
 	u32 rx_delay = GSWIP_MII_PCDU_RXDLY_DEFAULT;
 	struct device_node *port_dn = dp->dn;
-	u16 mii_pcdu_reg;
 
 	/* As MII_PCDU registers only exist for MII ports, silently return
 	 * unless the port is an MII port
 	 */
-	if (!(priv->hw_info->mii_ports & BIT(dp->index)))
+	if (priv->hw_info->mii_pcdu[dp->index] == -1)
 		return;
 
-	switch (dp->index + priv->hw_info->mii_port_reg_offset) {
-	case 0:
-		mii_pcdu_reg = GSWIP_MII_PCDU0;
-		break;
-	case 1:
-		mii_pcdu_reg = GSWIP_MII_PCDU1;
-		break;
-	case 5:
-		mii_pcdu_reg = GSWIP_MII_PCDU5;
-		break;
-	default:
-		return;
-	}
-
 	/* legacy code to set default delays according to the interface mode */
 	switch (interface) {
 	case PHY_INTERFACE_MODE_RGMII_ID:
@@ -646,7 +627,7 @@ static void gswip_mii_delay_setup(struct gswip_priv *priv, struct dsa_port *dp,
 	of_property_read_u32(port_dn, "rx-internal-delay-ps", &rx_delay);
 	of_property_read_u32(port_dn, "tx-internal-delay-ps", &tx_delay);
 
-	regmap_write_bits(priv->mii, mii_pcdu_reg,
+	regmap_write_bits(priv->mii, priv->hw_info->mii_pcdu[dp->index],
 			  GSWIP_MII_PCDU_TXDLY_MASK |
 			  GSWIP_MII_PCDU_RXDLY_MASK,
 			  GSWIP_MII_PCDU_TXDLY(tx_delay) |
diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
index f8ff8a604bf53..e2df6a3fd2dcc 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
@@ -702,8 +702,16 @@ static void gsw1xx_shutdown(struct mdio_device *mdiodev)
 static const struct gswip_hw_info gsw12x_data = {
 	.max_ports		= GSW1XX_PORTS,
 	.allowed_cpu_ports	= BIT(GSW1XX_MII_PORT) | BIT(GSW1XX_SGMII_PORT),
-	.mii_ports		= BIT(GSW1XX_MII_PORT),
-	.mii_port_reg_offset	= -GSW1XX_MII_PORT,
+	.mii_cfg = {
+		[0 ... GSW1XX_MII_PORT - 1] = -1,
+		[GSW1XX_MII_PORT] = GSWIP_MII_CFGp(0),
+		[GSW1XX_MII_PORT + 1 ... GSWIP_MAX_PORTS - 1] = -1,
+	},
+	.mii_pcdu = {
+		[0 ... GSW1XX_MII_PORT - 1] = -1,
+		[GSW1XX_MII_PORT] = GSWIP_MII_PCDU0,
+		[GSW1XX_MII_PORT + 1 ... GSWIP_MAX_PORTS - 1] = -1,
+	},
 	.mac_select_pcs		= gsw1xx_phylink_mac_select_pcs,
 	.phylink_get_caps	= &gsw1xx_phylink_get_caps,
 	.supports_2500m		= true,
@@ -715,8 +723,16 @@ static const struct gswip_hw_info gsw12x_data = {
 static const struct gswip_hw_info gsw140_data = {
 	.max_ports		= GSW1XX_PORTS,
 	.allowed_cpu_ports	= BIT(GSW1XX_MII_PORT) | BIT(GSW1XX_SGMII_PORT),
-	.mii_ports		= BIT(GSW1XX_MII_PORT),
-	.mii_port_reg_offset	= -GSW1XX_MII_PORT,
+	.mii_cfg = {
+		[0 ... GSW1XX_MII_PORT - 1] = -1,
+		[GSW1XX_MII_PORT] = GSWIP_MII_CFGp(0),
+		[GSW1XX_MII_PORT + 1 ... GSWIP_MAX_PORTS - 1] = -1,
+	},
+	.mii_pcdu = {
+		[0 ... GSW1XX_MII_PORT - 1] = -1,
+		[GSW1XX_MII_PORT] = GSWIP_MII_PCDU0,
+		[GSW1XX_MII_PORT + 1 ... GSWIP_MAX_PORTS - 1] = -1,
+	},
 	.mac_select_pcs		= gsw1xx_phylink_mac_select_pcs,
 	.phylink_get_caps	= &gsw1xx_phylink_get_caps,
 	.supports_2500m		= true,
@@ -728,8 +744,16 @@ static const struct gswip_hw_info gsw140_data = {
 static const struct gswip_hw_info gsw141_data = {
 	.max_ports		= GSW1XX_PORTS,
 	.allowed_cpu_ports	= BIT(GSW1XX_MII_PORT) | BIT(GSW1XX_SGMII_PORT),
-	.mii_ports		= BIT(GSW1XX_MII_PORT),
-	.mii_port_reg_offset	= -GSW1XX_MII_PORT,
+	.mii_cfg = {
+		[0 ... GSW1XX_MII_PORT - 1] = -1,
+		[GSW1XX_MII_PORT] = GSWIP_MII_CFGp(0),
+		[GSW1XX_MII_PORT + 1 ... GSWIP_MAX_PORTS - 1] = -1,
+	},
+	.mii_pcdu = {
+		[0 ... GSW1XX_MII_PORT - 1] = -1,
+		[GSW1XX_MII_PORT] = GSWIP_MII_PCDU0,
+		[GSW1XX_MII_PORT + 1 ... GSWIP_MAX_PORTS - 1] = -1,
+	},
 	.mac_select_pcs		= gsw1xx_phylink_mac_select_pcs,
 	.phylink_get_caps	= gsw1xx_phylink_get_caps,
 	.pce_microcode		= &gsw1xx_pce_microcode,
-- 
2.52.0

