Return-Path: <netdev+bounces-235807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F174C35D4B
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 14:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 490E0342808
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 13:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFAA3191C4;
	Wed,  5 Nov 2025 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="clylRTLn"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B03314A83
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349235; cv=none; b=DSrNB8Hix6Uexc87Q1Vk6XkodTF5K3ypnIyAlW+6PMFdzVW8LF2HSqRbp4xJ3tCjzk5l/c7TlKnkWio+RtVmGk36V3cPJKtG1xB0XrKtem0YRBbYFV2yCU85Hd1nThGvtU0OpXLfgIEpoMGXIsbWrzZQQlOuTxNcHwTagGiwXj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349235; c=relaxed/simple;
	bh=C/ikOgSa2JBmfWF0E0AXtkueNvS/5u8O28CPa25+7Ws=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=r0baftrLHFHf33kOg6fVMPYPLN/j/a2lhOYbsXbVqdKUsaTHe3weMZ4jWAYrckK4zUjtuFG5dBYpbSPMGOitxjR+twIHcqfi+CWqNpxr8TuzMuL8mCEVp/guo3/hqD8CX1pkkX+UMtGs/jYOBGaIWohJvNrV36WeYP2xz/EDMFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=clylRTLn; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7vJAkYgDYja28W9+m7ImQv3XKVEjSe37hg9qICz9dao=; b=clylRTLn0FWM3qn0pWTxxY7NO/
	L7x5ZjmAfERGsEFaLrQ5ybgvj7QNVrPiEyhNphNM2w1hXwMo/yGtmoi0a977dlid/fcZasPCFTv+6
	CP3Ee1SGBns/Myph/gYgmK/j60UwtNL/2ZWPX7RvSweeWtHLb8leC7hGcDLTtMyiu8elyqkANv0gU
	raFB7upy1P5unlecHR5rLULHXTMk3HjK2tboR4FTjwUa2jmj7xvrIov2z/zZgmiTLKohG3m1R2Xml
	vhVVerTZky7Fti9+lH3YCRZpaNVLLZBkvJJ0wGG8UsQMhy+bADMpfkmoQNmfIppInlgLrj41QX2Tz
	XnIyf3zg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50732 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vGdXQ-000000003UM-3swe;
	Wed, 05 Nov 2025 13:27:01 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vGdXP-0000000CloH-0FW9;
	Wed, 05 Nov 2025 13:26:59 +0000
In-Reply-To: <aQtQYlEY9crH0IKo@shell.armlinux.org.uk>
References: <aQtQYlEY9crH0IKo@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 10/11] net: stmmac: ingenic: pass ingenic_mac struct
 rather than plat_dat
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vGdXP-0000000CloH-0FW9@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 05 Nov 2025 13:26:59 +0000

It no longer makes sense to pass a pointer to struct
plat_stmmacenet_data when calling the set_mode() methods to only use it
to get a pointer to the ingenic_mac structure that we already had in
the caller. Simplify this by passing the struct ingenic_mac pointer.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac-ingenic.c   | 25 ++++++-------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
index 98fd4c31a694..5ea26ee8e9d8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
@@ -64,15 +64,13 @@ struct ingenic_soc_info {
 	enum ingenic_mac_version version;
 	u32 mask;
 
-	int (*set_mode)(struct plat_stmmacenet_data *plat_dat, u8 phy_intf_sel);
+	int (*set_mode)(struct ingenic_mac *mac, u8 phy_intf_sel);
 
 	u8 valid_phy_intf_sel;
 };
 
-static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
-			       u8 phy_intf_sel)
+static int jz4775_mac_set_mode(struct ingenic_mac *mac, u8 phy_intf_sel)
 {
-	struct ingenic_mac *mac = plat_dat->bsp_priv;
 	unsigned int val;
 
 	val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, phy_intf_sel) |
@@ -82,19 +80,14 @@ static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
 	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
 }
 
-static int x1000_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
-			      u8 phy_intf_sel)
+static int x1000_mac_set_mode(struct ingenic_mac *mac, u8 phy_intf_sel)
 {
-	struct ingenic_mac *mac = plat_dat->bsp_priv;
-
 	/* Update MAC PHY control register */
 	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, 0);
 }
 
-static int x1600_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
-			      u8 phy_intf_sel)
+static int x1600_mac_set_mode(struct ingenic_mac *mac, u8 phy_intf_sel)
 {
-	struct ingenic_mac *mac = plat_dat->bsp_priv;
 	unsigned int val;
 
 	val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, phy_intf_sel);
@@ -103,10 +96,8 @@ static int x1600_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
 	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
 }
 
-static int x1830_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
-			      u8 phy_intf_sel)
+static int x1830_mac_set_mode(struct ingenic_mac *mac, u8 phy_intf_sel)
 {
-	struct ingenic_mac *mac = plat_dat->bsp_priv;
 	unsigned int val;
 
 	val = FIELD_PREP(MACPHYC_MODE_SEL_MASK, MACPHYC_MODE_SEL_RMII) |
@@ -116,10 +107,8 @@ static int x1830_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
 	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
 }
 
-static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
-			      u8 phy_intf_sel)
+static int x2000_mac_set_mode(struct ingenic_mac *mac, u8 phy_intf_sel)
 {
-	struct ingenic_mac *mac = plat_dat->bsp_priv;
 	unsigned int val;
 
 	if (phy_intf_sel == PHY_INTF_SEL_RMII) {
@@ -165,7 +154,7 @@ static int ingenic_mac_init(struct platform_device *pdev, void *bsp_priv)
 		dev_dbg(mac->dev, "MAC PHY control register: interface %s\n",
 			phy_modes(interface));
 
-		ret = mac->soc_info->set_mode(mac->plat_dat, phy_intf_sel);
+		ret = mac->soc_info->set_mode(mac, phy_intf_sel);
 		if (ret)
 			return ret;
 	}
-- 
2.47.3


