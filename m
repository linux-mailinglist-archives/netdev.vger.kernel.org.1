Return-Path: <netdev+bounces-236693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B76BDC3EF78
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 09:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A54E93ADB5A
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 08:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31B430FC33;
	Fri,  7 Nov 2025 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sOIV8YfT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0912E30FC2C
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504162; cv=none; b=c1dv/dxoBKuZrp+/BeUPCwB6kzWhtQQRt4dYSAjYJD2Xnrfy4q0kjC2VXsRKkwdzXwaJGNWksXvFkBRsAVHI7+lzbfx1j2aAFxY5rRYXEHVQ8Ksy797hK/9bMGcQ5ziy/yQg1wKbLmHLcCbgMS1YY4QrkEO+hlLiRFd7ul9ldxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504162; c=relaxed/simple;
	bh=c/p/qTSpTQo+f51VkIx40+6TGEF7igT/sF5NYChYd3s=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=oyKQ29IiWq7t3sAysIw7xeBu9oVEhcfanJ6MwQcGyAJfv8nwmK+Vyh6IGeF0LZuxFculQH7OcSd/f57/nrmDCWb8iomHf3fkm877FsjZA4DYOO/hixQ6dmnQXPLX7Eg3DxpxJbExyD8LVYUBlHM1HPPzgqhmXN9p4esHQ3G40yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sOIV8YfT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yMZwceOBhRsb+BrYRWFJQYGXWxB7qHceFv6SXpC03TY=; b=sOIV8YfTdNH5gVKlTZ/WLbNcfb
	nodIBerrpNgrnrmfG1XiNEhPE+hDGmlw9ynrO6OF0PIHYl1PeLxDutm4XprlR/QfqAJO8VBrH5uvE
	5Hd1SjIieuYiSG1bIieS+rt9xGxFcUt6E/iDAwAz9HDH8EHPPWYoNRpVIneRYMN554l8kG1s3UfJb
	dI8EkdkCPzM8LEpCBgjmBXEvnSi+e7mDM6cX6ox0ZBj8p/9Af0snDG95NzLBC6ZCWPV4I3mQcUMgP
	r5jTTpMqvZ4UdhUEeiSVIAlNhzSgmjSkpe2jYHogMFjsQqkflqnG+VtfzhNhYlNgeX9l5k+2NcOCu
	VMwWT7tw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51596 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vHHqK-000000006AZ-1RxY;
	Fri, 07 Nov 2025 08:29:12 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vHHqI-0000000DjrV-3ygL;
	Fri, 07 Nov 2025 08:29:10 +0000
In-Reply-To: <aQ2tgEu-dudzlZlg@shell.armlinux.org.uk>
References: <aQ2tgEu-dudzlZlg@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v3 08/11] net: stmmac: ingenic: simplify
 mac_set_mode() methods
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vHHqI-0000000DjrV-3ygL@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 07 Nov 2025 08:29:10 +0000

x1000, x1600 and x1830 only accept RMII mode. PHY_INTF_SEL_RMII is only
selected with PHY_INTERFACE_MODE_RMII, and PHY_INTF_SEL_RMII has been
validated by the SoC's .valid_phy_intf_sel bitmask. Thus, checking the
interface mode in these functions becomes unnecessary. Remove these.

jz4775 is similar, except for a greater set of PHY_INTF_SEL_x valies.
Also remove the switch statement here.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
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


