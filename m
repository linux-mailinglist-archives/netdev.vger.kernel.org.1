Return-Path: <netdev+bounces-250360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A94B1D29603
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 01:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9D673035CF3
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 00:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A939B2C181;
	Fri, 16 Jan 2026 00:07:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F5A17BA6;
	Fri, 16 Jan 2026 00:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768522067; cv=none; b=Rifh+N1JXxuOsDH3ttL7WkomdmWOAGCQjbQtY2o1TKBLSQE6riUubnd8xdZlIe8vqRvraPyxawYXW/o0gWMjkBeLT0bLpJ6/Pb2olbiw5Ejifw49nZ/jUdHqgSna+trU2Lg1RozrrigZWdwjYazuUaRa5etyhXdUM6nV9WWe2VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768522067; c=relaxed/simple;
	bh=J0jy5Vgt0JVcAU1n47ZiVBLNQUVN8cJ4oVmdcvpd2GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZBlaBQ0ydGUlJm4cAk3BKUSUVCJvRVGocfR+v49HVQLXhcnRQBTPA/XaAwt62YYMM3ICP4yBcRH/Ixx0sf6GreGx3qFk7Dphb+jwpyquRgL4QiqoIxec6mBMNNsRnNP8fpTVcZG1VJvpb9+7rxNTB4/uw/I065NLc7Qwh+8JBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vgXNM-000000007Yv-3Fha;
	Fri, 16 Jan 2026 00:07:40 +0000
Date: Fri, 16 Jan 2026 00:07:37 +0000
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
Subject: [PATCH net-next v3 3/6] net: dsa: lantiq: allow arbitrary MII
 registers
Message-ID: <c1b9bc590aa097c98816a3fda6931db9b3d080af.1768519376.git.daniel@makrotopia.org>
References: <cover.1768519376.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768519376.git.daniel@makrotopia.org>

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
v3: enclose the gswip_hw_info initializers in compiler diag exception
    to prevent triggering -Woverride-init

v2: introduce GSWIP_MAX_PORTS macro

 drivers/net/dsa/lantiq/lantiq_gswip.c        | 37 ++++++++++++++++----
 drivers/net/dsa/lantiq/lantiq_gswip.h        |  6 ++--
 drivers/net/dsa/lantiq/lantiq_gswip_common.c | 27 +++-----------
 drivers/net/dsa/lantiq/mxl-gsw1xx.c          | 37 ++++++++++++++++----
 4 files changed, 70 insertions(+), 37 deletions(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
index b094001a7c805..b36bc1416d7ff 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
@@ -12,6 +12,7 @@
 #include "lantiq_pce.h"
 
 #include <linux/clk.h>
+#include <linux/compiler.h>
 #include <linux/delay.h>
 #include <linux/firmware.h>
 #include <linux/mfd/syscon.h>
@@ -462,11 +463,25 @@ static void gswip_shutdown(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 }
 
+__diag_push();
+__diag_ignore_all("-Woverride-init",
+		  "logic to initialize all and then override some is OK");
+
 static const struct gswip_hw_info gswip_xrx200 = {
-	.max_ports = 7,
+	.max_ports = GSWIP_MAX_PORTS,
 	.allowed_cpu_ports = BIT(6),
-	.mii_ports = BIT(0) | BIT(1) | BIT(5),
-	.mii_port_reg_offset = 0,
+	.mii_cfg = {
+		[0 ... GSWIP_MAX_PORTS - 1] = -1,
+		[0] = GSWIP_MII_CFGp(0),
+		[1] = GSWIP_MII_CFGp(1),
+		[5] = GSWIP_MII_CFGp(5),
+	},
+	.mii_pcdu = {
+		[0 ... GSWIP_MAX_PORTS - 1] = -1,
+		[0] = GSWIP_MII_PCDU0,
+		[1] = GSWIP_MII_PCDU1,
+		[5] = GSWIP_MII_PCDU5,
+	},
 	.phylink_get_caps = gswip_xrx200_phylink_get_caps,
 	.pce_microcode = &gswip_pce_microcode,
 	.pce_microcode_size = ARRAY_SIZE(gswip_pce_microcode),
@@ -474,16 +489,26 @@ static const struct gswip_hw_info gswip_xrx200 = {
 };
 
 static const struct gswip_hw_info gswip_xrx300 = {
-	.max_ports = 7,
+	.max_ports = GSWIP_MAX_PORTS,
 	.allowed_cpu_ports = BIT(6),
-	.mii_ports = BIT(0) | BIT(5),
-	.mii_port_reg_offset = 0,
+	.mii_cfg = {
+		[0 ... GSWIP_MAX_PORTS - 1] = -1,
+		[0] = GSWIP_MII_CFGp(0),
+		[5] = GSWIP_MII_CFGp(5),
+	},
+	.mii_pcdu = {
+		[0 ... GSWIP_MAX_PORTS - 1] = -1,
+		[0] = GSWIP_MII_PCDU0,
+		[5] = GSWIP_MII_PCDU5,
+	},
 	.phylink_get_caps = gswip_xrx300_phylink_get_caps,
 	.pce_microcode = &gswip_pce_microcode,
 	.pce_microcode_size = ARRAY_SIZE(gswip_pce_microcode),
 	.tag_protocol = DSA_TAG_PROTO_GSWIP,
 };
 
+__diag_pop();
+
 static const struct of_device_id gswip_of_match[] = {
 	{ .compatible = "lantiq,xrx200-gswip", .data = &gswip_xrx200 },
 	{ .compatible = "lantiq,xrx300-gswip", .data = &gswip_xrx300 },
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
index f8ff8a604bf53..acf9e2465b934 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/bits.h>
+#include <linux/compiler.h>
 #include <linux/delay.h>
 #include <linux/jiffies.h>
 #include <linux/module.h>
@@ -699,11 +700,21 @@ static void gsw1xx_shutdown(struct mdio_device *mdiodev)
 	cancel_delayed_work_sync(&gsw1xx_priv->clear_raneg);
 }
 
+__diag_push();
+__diag_ignore_all("-Woverride-init",
+		  "logic to initialize all and then override some is OK");
+
 static const struct gswip_hw_info gsw12x_data = {
 	.max_ports		= GSW1XX_PORTS,
 	.allowed_cpu_ports	= BIT(GSW1XX_MII_PORT) | BIT(GSW1XX_SGMII_PORT),
-	.mii_ports		= BIT(GSW1XX_MII_PORT),
-	.mii_port_reg_offset	= -GSW1XX_MII_PORT,
+	.mii_cfg = {
+		[0 ... GSWIP_MAX_PORTS - 1] = -1,
+		[GSW1XX_MII_PORT] = GSWIP_MII_CFGp(0),
+	},
+	.mii_pcdu = {
+		[0 ... GSWIP_MAX_PORTS - 1] = -1,
+		[GSW1XX_MII_PORT] = GSWIP_MII_PCDU0,
+	},
 	.mac_select_pcs		= gsw1xx_phylink_mac_select_pcs,
 	.phylink_get_caps	= &gsw1xx_phylink_get_caps,
 	.supports_2500m		= true,
@@ -715,8 +726,14 @@ static const struct gswip_hw_info gsw12x_data = {
 static const struct gswip_hw_info gsw140_data = {
 	.max_ports		= GSW1XX_PORTS,
 	.allowed_cpu_ports	= BIT(GSW1XX_MII_PORT) | BIT(GSW1XX_SGMII_PORT),
-	.mii_ports		= BIT(GSW1XX_MII_PORT),
-	.mii_port_reg_offset	= -GSW1XX_MII_PORT,
+	.mii_cfg = {
+		[0 ... GSWIP_MAX_PORTS - 1] = -1,
+		[GSW1XX_MII_PORT] = GSWIP_MII_CFGp(0),
+	},
+	.mii_pcdu = {
+		[0 ... GSWIP_MAX_PORTS - 1] = -1,
+		[GSW1XX_MII_PORT] = GSWIP_MII_PCDU0,
+	},
 	.mac_select_pcs		= gsw1xx_phylink_mac_select_pcs,
 	.phylink_get_caps	= &gsw1xx_phylink_get_caps,
 	.supports_2500m		= true,
@@ -728,8 +745,14 @@ static const struct gswip_hw_info gsw140_data = {
 static const struct gswip_hw_info gsw141_data = {
 	.max_ports		= GSW1XX_PORTS,
 	.allowed_cpu_ports	= BIT(GSW1XX_MII_PORT) | BIT(GSW1XX_SGMII_PORT),
-	.mii_ports		= BIT(GSW1XX_MII_PORT),
-	.mii_port_reg_offset	= -GSW1XX_MII_PORT,
+	.mii_cfg = {
+		[0 ... GSWIP_MAX_PORTS - 1] = -1,
+		[GSW1XX_MII_PORT] = GSWIP_MII_CFGp(0),
+	},
+	.mii_pcdu = {
+		[0 ... GSWIP_MAX_PORTS - 1] = -1,
+		[GSW1XX_MII_PORT] = GSWIP_MII_PCDU0,
+	},
 	.mac_select_pcs		= gsw1xx_phylink_mac_select_pcs,
 	.phylink_get_caps	= gsw1xx_phylink_get_caps,
 	.pce_microcode		= &gsw1xx_pce_microcode,
@@ -737,6 +760,8 @@ static const struct gswip_hw_info gsw141_data = {
 	.tag_protocol		= DSA_TAG_PROTO_MXL_GSW1XX,
 };
 
+__diag_pop();
+
 /*
  * GSW125 is the industrial temperature version of GSW120.
  * GSW145 is the industrial temperature version of GSW140.
-- 
2.52.0

