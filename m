Return-Path: <netdev+bounces-236197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1F0C39B12
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 09:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E73F14F768A
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 08:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7713093C8;
	Thu,  6 Nov 2025 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="t1rrINss"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835173093C6
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 08:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419478; cv=none; b=nLkAqmzjTkHAOgoWtc8gz/g5DXoksDGOnW4J1+eaBA/lfaQyKOqbep5kSORVcL8y76d56Ta37yXVHgEoZ6RK9FqsJrT2dj0V0H9OrxfAXssiVk18dIV2mklrp04wRL0KOnTHp3yZVCLB3zAbQyj8H2wC952tKSMNiwhrArGrxeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419478; c=relaxed/simple;
	bh=8pQSWHAQB33CGmWCTLynGGF8Xalg7yuyJUt4iRyQSKA=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=C6Eo9yeWsXMdnCZBdgclx17doQASy76wRmcFT2kVVF2UFxukbxt/T3rvhHZSnMms8sA2k/4kwOzsr1Ck8mDaBRTP3axVHIjJNCK6Sq8sw7S1rDONVyre4beH4w8rjUnLCDkoEIR95Dbi0UfvE7MvVtArkDqC6cw87qkCxR/qexc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=t1rrINss; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QW/Iy/YgXaPnDYTHZN2tIGLz73bnDzACNiiCiEAutOU=; b=t1rrINssWSEvFR8b44hv1DtYMv
	OUxh8MK1mKjDy2+UbNbK2YUHnRFv/8j158u6RqImsQMROX7VU7zkXDa25Ke1ik8tIfG/GhrFo8Jts
	t77LE6p1fV+Q9B7FeInGL0dOMbdCdCu/mK7cUo2y+d903gFil0W77RcpkYGlwHAf1nYaGowa8PNsY
	+WzGJBdvLc54Zg8QJ5VNJBx9QMYn0gjpBHhvRLWPRnPLRqkeg3Y4zFw/fIalK0nacg1TNgemTLqsi
	B76Rt5xwZ2fupOxYclDQCcxE2Eog67h5eXOugokFEkLM4z6G9T+MsH5qq3iqDPlJD37SJP63FLjEZ
	dXrWJdKA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44192 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vGvoQ-000000004YX-1NrM;
	Thu, 06 Nov 2025 08:57:46 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vGvoP-0000000DWon-1cOI;
	Thu, 06 Nov 2025 08:57:45 +0000
In-Reply-To: <aQxinH5WWcunfP7p@shell.armlinux.org.uk>
References: <aQxinH5WWcunfP7p@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 06/11] net: stmmac: ingenic: use
 stmmac_get_phy_intf_sel()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vGvoP-0000000DWon-1cOI@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 06 Nov 2025 08:57:45 +0000

Use stmmac_get_phy_intf_sel() to decode the PHY interface mode to the
phy_intf_sel value, validate the result against the SoC specific
supported phy_intf_sel values, and pass into the SoC specific
set_mode() methods, replacing the local phy_intf_sel variable. This
provides the value for the MACPHYC_PHY_INFT_MASK field.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac-ingenic.c   | 55 ++++++++++++-------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
index 6680f7d3a469..79735a476e86 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
@@ -64,28 +64,27 @@ struct ingenic_soc_info {
 	enum ingenic_mac_version version;
 	u32 mask;
 
-	int (*set_mode)(struct plat_stmmacenet_data *plat_dat);
+	int (*set_mode)(struct plat_stmmacenet_data *plat_dat, u8 phy_intf_sel);
+
+	u8 valid_phy_intf_sel;
 };
 
-static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
+static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
+			       u8 phy_intf_sel)
 {
 	struct ingenic_mac *mac = plat_dat->bsp_priv;
 	unsigned int val;
-	u8 phy_intf_sel;
 
 	switch (plat_dat->phy_interface) {
 	case PHY_INTERFACE_MODE_MII:
-		phy_intf_sel = PHY_INTF_SEL_GMII_MII;
 		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_MII\n");
 		break;
 
 	case PHY_INTERFACE_MODE_GMII:
-		phy_intf_sel = PHY_INTF_SEL_GMII_MII;
 		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_GMII\n");
 		break;
 
 	case PHY_INTERFACE_MODE_RMII:
-		phy_intf_sel = PHY_INTF_SEL_RMII;
 		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RMII\n");
 		break;
 
@@ -93,7 +92,6 @@ static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 	case PHY_INTERFACE_MODE_RGMII_RXID:
-		phy_intf_sel = PHY_INTF_SEL_RGMII;
 		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RGMII\n");
 		break;
 
@@ -110,7 +108,8 @@ static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
 }
 
-static int x1000_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
+static int x1000_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
+			      u8 phy_intf_sel)
 {
 	struct ingenic_mac *mac = plat_dat->bsp_priv;
 
@@ -129,15 +128,14 @@ static int x1000_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, 0);
 }
 
-static int x1600_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
+static int x1600_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
+			      u8 phy_intf_sel)
 {
 	struct ingenic_mac *mac = plat_dat->bsp_priv;
 	unsigned int val;
-	u8 phy_intf_sel;
 
 	switch (plat_dat->phy_interface) {
 	case PHY_INTERFACE_MODE_RMII:
-		phy_intf_sel = PHY_INTF_SEL_RMII;
 		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RMII\n");
 		break;
 
@@ -153,16 +151,15 @@ static int x1600_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
 }
 
-static int x1830_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
+static int x1830_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
+			      u8 phy_intf_sel)
 {
 	struct ingenic_mac *mac = plat_dat->bsp_priv;
 	unsigned int val;
-	u8 phy_intf_sel;
 
 	switch (plat_dat->phy_interface) {
 	case PHY_INTERFACE_MODE_RMII:
 		val = FIELD_PREP(MACPHYC_MODE_SEL_MASK, MACPHYC_MODE_SEL_RMII);
-		phy_intf_sel = PHY_INTF_SEL_RMII;
 		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RMII\n");
 		break;
 
@@ -178,17 +175,16 @@ static int x1830_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
 }
 
-static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
+static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
+			      u8 phy_intf_sel)
 {
 	struct ingenic_mac *mac = plat_dat->bsp_priv;
 	unsigned int val;
-	u8 phy_intf_sel;
 
 	switch (plat_dat->phy_interface) {
 	case PHY_INTERFACE_MODE_RMII:
 		val = FIELD_PREP(MACPHYC_TX_SEL_MASK, MACPHYC_TX_SEL_ORIGIN) |
 			  FIELD_PREP(MACPHYC_RX_SEL_MASK, MACPHYC_RX_SEL_ORIGIN);
-		phy_intf_sel = PHY_INTF_SEL_RMII;
 		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RMII\n");
 		break;
 
@@ -197,8 +193,6 @@ static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 		val = 0;
-		phy_intf_sel = PHY_INTF_SEL_RGMII;
-
 		if (mac->tx_delay == 0)
 			val |= FIELD_PREP(MACPHYC_TX_SEL_MASK, MACPHYC_TX_SEL_ORIGIN);
 		else
@@ -229,10 +223,21 @@ static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat)
 static int ingenic_mac_init(struct platform_device *pdev, void *bsp_priv)
 {
 	struct ingenic_mac *mac = bsp_priv;
-	int ret;
+	phy_interface_t interface;
+	int phy_intf_sel, ret;
 
 	if (mac->soc_info->set_mode) {
-		ret = mac->soc_info->set_mode(mac->plat_dat);
+		interface = mac->plat_dat->phy_interface;
+
+		phy_intf_sel = stmmac_get_phy_intf_sel(interface);
+		if (phy_intf_sel < 0 || phy_intf_sel >= BITS_PER_BYTE ||
+		    ~mac->soc_info->valid_phy_intf_sel & BIT(phy_intf_sel)) {
+			dev_err(mac->dev, "unsupported interface %s\n",
+				phy_modes(interface));
+			return phy_intf_sel < 0 ? phy_intf_sel : -EINVAL;
+		}
+
+		ret = mac->soc_info->set_mode(mac->plat_dat, phy_intf_sel);
 		if (ret)
 			return ret;
 	}
@@ -309,6 +314,9 @@ static struct ingenic_soc_info jz4775_soc_info = {
 	.mask = MACPHYC_TXCLK_SEL_MASK | MACPHYC_SOFT_RST_MASK | MACPHYC_PHY_INFT_MASK,
 
 	.set_mode = jz4775_mac_set_mode,
+	.valid_phy_intf_sel = BIT(PHY_INTF_SEL_GMII_MII) |
+			      BIT(PHY_INTF_SEL_RGMII) |
+			      BIT(PHY_INTF_SEL_RMII),
 };
 
 static struct ingenic_soc_info x1000_soc_info = {
@@ -316,6 +324,7 @@ static struct ingenic_soc_info x1000_soc_info = {
 	.mask = MACPHYC_SOFT_RST_MASK,
 
 	.set_mode = x1000_mac_set_mode,
+	.valid_phy_intf_sel = BIT(PHY_INTF_SEL_RMII),
 };
 
 static struct ingenic_soc_info x1600_soc_info = {
@@ -323,6 +332,7 @@ static struct ingenic_soc_info x1600_soc_info = {
 	.mask = MACPHYC_SOFT_RST_MASK | MACPHYC_PHY_INFT_MASK,
 
 	.set_mode = x1600_mac_set_mode,
+	.valid_phy_intf_sel = BIT(PHY_INTF_SEL_RMII),
 };
 
 static struct ingenic_soc_info x1830_soc_info = {
@@ -330,6 +340,7 @@ static struct ingenic_soc_info x1830_soc_info = {
 	.mask = MACPHYC_MODE_SEL_MASK | MACPHYC_SOFT_RST_MASK | MACPHYC_PHY_INFT_MASK,
 
 	.set_mode = x1830_mac_set_mode,
+	.valid_phy_intf_sel = BIT(PHY_INTF_SEL_RMII),
 };
 
 static struct ingenic_soc_info x2000_soc_info = {
@@ -338,6 +349,8 @@ static struct ingenic_soc_info x2000_soc_info = {
 			MACPHYC_RX_DELAY_MASK | MACPHYC_SOFT_RST_MASK | MACPHYC_PHY_INFT_MASK,
 
 	.set_mode = x2000_mac_set_mode,
+	.valid_phy_intf_sel = BIT(PHY_INTF_SEL_RGMII) |
+			      BIT(PHY_INTF_SEL_RMII),
 };
 
 static const struct of_device_id ingenic_mac_of_matches[] = {
-- 
2.47.3


