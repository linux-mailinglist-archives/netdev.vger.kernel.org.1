Return-Path: <netdev+bounces-234742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AE4C26B6B
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 20:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2387F1A256D9
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 19:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9B834F48A;
	Fri, 31 Oct 2025 19:22:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA3D348860;
	Fri, 31 Oct 2025 19:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761938560; cv=none; b=NmbW60gGhm/54bAq2wUktGs0pdkRAJ8dtPq5B+7vEy3Cp8M8IhrYtRCP7obOyCtLuV0v8Gty14avP4XsHqZf2iyjZp47NWkJDP/inOT+X85Lv5KRlNe7QcCcqwcYbeRwD2NQLNVEj0iev6gre1YMRG2DGCgNpjlod7A7y9ojB+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761938560; c=relaxed/simple;
	bh=kP3GgWe5eE3cZOc/hWqKVG0Dw1UYwgnSkjbxCmVG24M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ivp+9c0W+bW2X6fs3wJ9bu2VXmQLOquvqjkPP+fopKbU1PFFD/+CXevpHZC+wZ4idmDkTxteEHPiqY7oLzJWpBKRlFlAUQ3vpR1Dqx2IXATxp7OB1ZHGb7yAB4/YAma2umxgxU8hnIrkiPNK7+GtL/jyfMadiPwDHb2aYr9ZbF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vEuhm-000000005uu-06tl;
	Fri, 31 Oct 2025 19:22:34 +0000
Date: Fri, 31 Oct 2025 19:22:30 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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
Subject: [PATCH net-next v6 09/12] net: dsa: lantiq_gswip: allow adjusting
 MII delays
Message-ID: <4153348de172b6645cfaa8eaae7aa6a269ee802d.1761938079.git.daniel@makrotopia.org>
References: <cover.1761938079.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761938079.git.daniel@makrotopia.org>

Currently the MII clk vs. data delay is configured based on the PHY
interface mode.

In addition to that add support for setting up MII delays using the
standard Device Tree properties 'tx-internal-delay-ps' and
'rx-internal-delay-ps', using the values determined by the PHY interface
mode as default to maintain backward compatibility with legacy device
trees.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v4: rework to use legacy codepath as fallback

 drivers/net/dsa/lantiq/lantiq_gswip.h        |  4 +
 drivers/net/dsa/lantiq/lantiq_gswip_common.c | 94 ++++++++++++--------
 2 files changed, 60 insertions(+), 38 deletions(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.h b/drivers/net/dsa/lantiq/lantiq_gswip.h
index 42000954d842..0c32ec85e127 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.h
@@ -82,6 +82,10 @@
 #define GSWIP_MII_PCDU5			0x05
 #define  GSWIP_MII_PCDU_TXDLY_MASK	GENMASK(2, 0)
 #define  GSWIP_MII_PCDU_RXDLY_MASK	GENMASK(9, 7)
+#define  GSWIP_MII_PCDU_TXDLY(x)	u16_encode_bits(((x) / 500), GSWIP_MII_PCDU_TXDLY_MASK)
+#define  GSWIP_MII_PCDU_RXDLY(x)	u16_encode_bits(((x) / 500), GSWIP_MII_PCDU_RXDLY_MASK)
+#define GSWIP_MII_PCDU_RXDLY_DEFAULT	2000 /* picoseconds */
+#define GSWIP_MII_PCDU_TXDLY_DEFAULT	2000 /* picoseconds */
 
 /* GSWIP Core Registers */
 #define GSWIP_SWRES			0x000
diff --git a/drivers/net/dsa/lantiq/lantiq_gswip_common.c b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
index b9d4cd6fcd74..6a4a09ebdd33 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip_common.c
+++ b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
@@ -130,30 +130,6 @@ static void gswip_mii_mask_cfg(struct gswip_priv *priv, u32 mask, u32 set,
 			  set);
 }
 
-static void gswip_mii_mask_pcdu(struct gswip_priv *priv, u32 mask, u32 set,
-				int port)
-{
-	int reg_port;
-
-	/* MII_PCDU register only exists for MII ports */
-	if (!(priv->hw_info->mii_ports & BIT(port)))
-		return;
-
-	reg_port = port + priv->hw_info->mii_port_reg_offset;
-
-	switch (reg_port) {
-	case 0:
-		regmap_write_bits(priv->mii, GSWIP_MII_PCDU0, mask, set);
-		break;
-	case 1:
-		regmap_write_bits(priv->mii, GSWIP_MII_PCDU1, mask, set);
-		break;
-	case 5:
-		regmap_write_bits(priv->mii, GSWIP_MII_PCDU5, mask, set);
-		break;
-	}
-}
-
 static int gswip_mdio_poll(struct gswip_priv *priv)
 {
 	u32 ctrl;
@@ -622,6 +598,61 @@ static int gswip_port_vlan_filtering(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static void gswip_mii_delay_setup(struct gswip_priv *priv, struct dsa_port *dp,
+				  phy_interface_t interface)
+{
+	u32 tx_delay = GSWIP_MII_PCDU_TXDLY_DEFAULT;
+	u32 rx_delay = GSWIP_MII_PCDU_RXDLY_DEFAULT;
+	struct device_node *port_dn = dp->dn;
+	u16 mii_pcdu_reg;
+
+	/* As MII_PCDU registers only exist for MII ports, silently return
+	 * unless the port is an MII port
+	 */
+	if (!(priv->hw_info->mii_ports & BIT(dp->index)))
+		return;
+
+	switch (dp->index + priv->hw_info->mii_port_reg_offset) {
+	case 0:
+		mii_pcdu_reg = GSWIP_MII_PCDU0;
+		break;
+	case 1:
+		mii_pcdu_reg = GSWIP_MII_PCDU1;
+		break;
+	case 5:
+		mii_pcdu_reg = GSWIP_MII_PCDU5;
+		break;
+	default:
+		return;
+	}
+
+	/* legacy code to set default delays according to the interface mode */
+	switch (interface) {
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		tx_delay = 0;
+		rx_delay = 0;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+		rx_delay = 0;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		tx_delay = 0;
+		break;
+	default:
+		break;
+	}
+
+	/* allow settings delays using device tree properties */
+	of_property_read_u32(port_dn, "rx-internal-delay-ps", &rx_delay);
+	of_property_read_u32(port_dn, "tx-internal-delay-ps", &tx_delay);
+
+	regmap_write_bits(priv->mii, mii_pcdu_reg,
+			  GSWIP_MII_PCDU_TXDLY_MASK |
+			  GSWIP_MII_PCDU_RXDLY_MASK,
+			  GSWIP_MII_PCDU_TXDLY(tx_delay) |
+			  GSWIP_MII_PCDU_RXDLY(rx_delay));
+}
+
 static int gswip_setup(struct dsa_switch *ds)
 {
 	unsigned int cpu_ports = dsa_cpu_ports(ds);
@@ -1425,20 +1456,7 @@ static void gswip_phylink_mac_config(struct phylink_config *config,
 			   GSWIP_MII_CFG_RGMII_IBS | GSWIP_MII_CFG_LDCLKDIS,
 			   miicfg, port);
 
-	switch (state->interface) {
-	case PHY_INTERFACE_MODE_RGMII_ID:
-		gswip_mii_mask_pcdu(priv, GSWIP_MII_PCDU_TXDLY_MASK |
-					  GSWIP_MII_PCDU_RXDLY_MASK, 0, port);
-		break;
-	case PHY_INTERFACE_MODE_RGMII_RXID:
-		gswip_mii_mask_pcdu(priv, GSWIP_MII_PCDU_RXDLY_MASK, 0, port);
-		break;
-	case PHY_INTERFACE_MODE_RGMII_TXID:
-		gswip_mii_mask_pcdu(priv, GSWIP_MII_PCDU_TXDLY_MASK, 0, port);
-		break;
-	default:
-		break;
-	}
+	gswip_mii_delay_setup(priv, dp, state->interface);
 }
 
 static void gswip_phylink_mac_link_down(struct phylink_config *config,
-- 
2.51.2

