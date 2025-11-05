Return-Path: <netdev+bounces-235805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06D9C35D75
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 14:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6763F3A53E2
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 13:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2ED31E10C;
	Wed,  5 Nov 2025 13:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="p8pPMRPg"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E76F3128DF
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349222; cv=none; b=fK3Kjhcx08RCLDonzMmrFVIDbLMii+e3ototRcGr4DBu+r/f46s3vLu7oVWnC764J08qZCI1q5bdagXicj66T2pt2TmfMEpsIMMUjsqyaOaTMI0w1c97ak4f8MfHIK0pIHjiqWa3jO+3yT7Zw0dIVAaC9s1/IeJpCbCiAoyderg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349222; c=relaxed/simple;
	bh=cXK5K+LzXDzOqGCncNCsIGF+lACPMziKJeCDfYGSt38=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=E7x3Z3hg0la9Bnf0+ItmqWzLYpbRSnA8AIClVvNuhdlmXJW8zjuTaGelRoGdSMZaUe3G+oh7mMtk4UJGWYOrXwqqnR8d35yaNRGZq+RkbVvhnzhk5ppk/TGof1nuvtL1UVO6GsN4q2u2sG71OKVsIgQDGxvCEKUclSeFFJCqmGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=p8pPMRPg; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IaRml5eM8v0sO8/PyuoNQT9vv7q3YfUnikJJQRvPq9w=; b=p8pPMRPgR+r4X3uf5qXbPOHmzu
	YNsrQTR0HXMBZsMZPWtexK5XBdTMdqu8kk+vuz3E0ujQa4abUbxmS+Hc/QwHeB51esHG5+BS+fBCI
	wLl3QM6pUavJOIOwAJ1EP9FcojTiWXmTF9lMIhls0wg28CAWbsP8o8WD9wV8PWAwRgU+7/dpMTNwe
	ffwC3Q1/SXmZYODSp5UfNempSS/eSOLL5OS2sjI3IWJA4ZlaPq7FxqbLNbJ8NHTvWWs4Fa3RovYZ3
	Xhr1lAi4X1HWKONwyc18ppsTA3/kaWBUs3b+FLv0SzjkBSR6b6wFsqN79XEnuV00qhkzrNFQDTolz
	vkyy1hlg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56816 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vGdXG-000000003Tj-2G5W;
	Wed, 05 Nov 2025 13:26:50 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vGdXE-0000000Clo4-3Yct;
	Wed, 05 Nov 2025 13:26:48 +0000
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
Subject: [PATCH net-next 08/11] net: stmmac: ingenic: simplify mac_set_mode()
 methods
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vGdXE-0000000Clo4-3Yct@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 05 Nov 2025 13:26:48 +0000

x1000, x1600 and x1830 only accept RMII mode. PHY_INTF_SEL_RMII is only
selected with PHY_INTERFACE_MODE_RMII, and PHY_INTF_SEL_RMII has been
validated by the SoC's .valid_phy_intf_sel bitmask. Thus, checking the
interface mode in these functions becomes unnecessary. Remove these.

jz4775 is similar, except for a greater set of PHY_INTF_SEL_x valies.
Also remove the switch statement here.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac-ingenic.c   | 50 +------------------
 1 file changed, 2 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
index 539513890db1..7b2576fbb1e1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
@@ -75,22 +75,6 @@ static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
 	struct ingenic_mac *mac = plat_dat->bsp_priv;
 	unsigned int val;
 
-	switch (plat_dat->phy_interface) {
-	case PHY_INTERFACE_MODE_MII:
-	case PHY_INTERFACE_MODE_GMII:
-	case PHY_INTERFACE_MODE_RMII:
-	case PHY_INTERFACE_MODE_RGMII:
-	case PHY_INTERFACE_MODE_RGMII_ID:
-	case PHY_INTERFACE_MODE_RGMII_TXID:
-	case PHY_INTERFACE_MODE_RGMII_RXID:
-		break;
-
-	default:
-		dev_err(mac->dev, "Unsupported interface %s\n",
-			phy_modes(plat_dat->phy_interface));
-		return -EINVAL;
-	}
-
 	val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, phy_intf_sel) |
 	      FIELD_PREP(MACPHYC_TXCLK_SEL_MASK, MACPHYC_TXCLK_SEL_INPUT);
 
@@ -103,16 +87,6 @@ static int x1000_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
 {
 	struct ingenic_mac *mac = plat_dat->bsp_priv;
 
-	switch (plat_dat->phy_interface) {
-	case PHY_INTERFACE_MODE_RMII:
-		break;
-
-	default:
-		dev_err(mac->dev, "Unsupported interface %s\n",
-			phy_modes(plat_dat->phy_interface));
-		return -EINVAL;
-	}
-
 	/* Update MAC PHY control register */
 	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, 0);
 }
@@ -123,16 +97,6 @@ static int x1600_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
 	struct ingenic_mac *mac = plat_dat->bsp_priv;
 	unsigned int val;
 
-	switch (plat_dat->phy_interface) {
-	case PHY_INTERFACE_MODE_RMII:
-		break;
-
-	default:
-		dev_err(mac->dev, "Unsupported interface %s\n",
-			phy_modes(plat_dat->phy_interface));
-		return -EINVAL;
-	}
-
 	val = FIELD_PREP(MACPHYC_PHY_INFT_MASK, phy_intf_sel);
 
 	/* Update MAC PHY control register */
@@ -145,18 +109,8 @@ static int x1830_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
 	struct ingenic_mac *mac = plat_dat->bsp_priv;
 	unsigned int val;
 
-	switch (plat_dat->phy_interface) {
-	case PHY_INTERFACE_MODE_RMII:
-		val = FIELD_PREP(MACPHYC_MODE_SEL_MASK, MACPHYC_MODE_SEL_RMII);
-		break;
-
-	default:
-		dev_err(mac->dev, "Unsupported interface %s\n",
-			phy_modes(plat_dat->phy_interface));
-		return -EINVAL;
-	}
-
-	val |= FIELD_PREP(MACPHYC_PHY_INFT_MASK, phy_intf_sel);
+	val = FIELD_PREP(MACPHYC_MODE_SEL_MASK, MACPHYC_MODE_SEL_RMII) |
+	      FIELD_PREP(MACPHYC_PHY_INFT_MASK, phy_intf_sel);
 
 	/* Update MAC PHY control register */
 	return regmap_update_bits(mac->regmap, 0, mac->soc_info->mask, val);
-- 
2.47.3


