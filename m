Return-Path: <netdev+bounces-236198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E31C39B01
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 09:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7E3F934FD31
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 08:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244C53093C9;
	Thu,  6 Nov 2025 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Dt05tnpx"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E2B3093C8
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 08:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419484; cv=none; b=Ou8azKXE9LwOvSrFjDItodyuFpUtAUyCbU1rCd7xr04CI6lhQMuz842e4GD1DD2a2Pof4GUfvLuf8/Z4bl745t5mwtdaaDHKC5YxQxKy28rS8YX/2IrM98w+BPzWxBsdKnenjH/PsWYI0X65K69CDyy9SoMjHq/vs5QGG6ivL+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419484; c=relaxed/simple;
	bh=sCjxBaqZIIHDYiVLorqGhbd2Usa2U8Wh+HgnV4JYK2M=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=l1Zxcj/IqKKPFVf+89ho+9jlHSk31ChNoUOoRL2yfpDmCaY4JfM5LWsKxDDd0AyYh9vBMG0TrM0HLpMIlwnUTPdZxjioQW8d69vl3xbvwEcgGF2v2B679W6JBYJx7QHbiD+Wdn7glDTmJo4fUHiEz1iMuX5edUg443rEmsYG1Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Dt05tnpx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6MUkjUGs5htCVWXpvlmUC7jdUvESYY4WRqn6CV5pz6o=; b=Dt05tnpxwaLbiScxwLYsBakCjJ
	KNsUq2+37NaAqRkAEosj+kibwPF1LpdS6Oe6o8e/cR5apjLwQBYI4zC+LLBbzJSc6/pDeQueAOXul
	yhX+7wxLbECOQSocqOyrJ/a08CMplHgxyXzObNI21PrW3uWg7v0G/w7Qhsgc/TCpt2YmmWy3IIUF0
	lIBd0jccojJYx9hngTP/3WbQ0AYgMpEUKJIs3v+MvInO/WUVciGz0O1CX0hv7lL1pK/qe/W3bg6Iy
	w6FeLfFAw5vqsep1sWMcLzp1ESr7IKIlzh+F8dXSXRJ86NELYwMtfHlo96orB/B9MnLqbbVjrLWQY
	aTCJYivg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56276 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vGvoW-000000004Yq-2azd;
	Thu, 06 Nov 2025 08:57:52 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vGvoU-0000000DWot-29Rw;
	Thu, 06 Nov 2025 08:57:50 +0000
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
Subject: [PATCH net-next v2 07/11] net: stmmac: ingenic: move "MAC PHY control
 register" debug
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vGvoU-0000000DWot-29Rw@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 06 Nov 2025 08:57:50 +0000

Move the printing of the MAC PHY control register interface mode
setting into ingenic_set_phy_intf_sel(), and use phy_modes() to
print the string rather than using the enum name.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac-ingenic.c    | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
index 79735a476e86..539513890db1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
@@ -77,22 +77,12 @@ static int jz4775_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
 
 	switch (plat_dat->phy_interface) {
 	case PHY_INTERFACE_MODE_MII:
-		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_MII\n");
-		break;
-
 	case PHY_INTERFACE_MODE_GMII:
-		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_GMII\n");
-		break;
-
 	case PHY_INTERFACE_MODE_RMII:
-		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RMII\n");
-		break;
-
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 	case PHY_INTERFACE_MODE_RGMII_RXID:
-		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RGMII\n");
 		break;
 
 	default:
@@ -115,7 +105,6 @@ static int x1000_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
 
 	switch (plat_dat->phy_interface) {
 	case PHY_INTERFACE_MODE_RMII:
-		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RMII\n");
 		break;
 
 	default:
@@ -136,7 +125,6 @@ static int x1600_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
 
 	switch (plat_dat->phy_interface) {
 	case PHY_INTERFACE_MODE_RMII:
-		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RMII\n");
 		break;
 
 	default:
@@ -160,7 +148,6 @@ static int x1830_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
 	switch (plat_dat->phy_interface) {
 	case PHY_INTERFACE_MODE_RMII:
 		val = FIELD_PREP(MACPHYC_MODE_SEL_MASK, MACPHYC_MODE_SEL_RMII);
-		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RMII\n");
 		break;
 
 	default:
@@ -185,7 +172,6 @@ static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
 	case PHY_INTERFACE_MODE_RMII:
 		val = FIELD_PREP(MACPHYC_TX_SEL_MASK, MACPHYC_TX_SEL_ORIGIN) |
 			  FIELD_PREP(MACPHYC_RX_SEL_MASK, MACPHYC_RX_SEL_ORIGIN);
-		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RMII\n");
 		break;
 
 	case PHY_INTERFACE_MODE_RGMII:
@@ -205,7 +191,6 @@ static int x2000_mac_set_mode(struct plat_stmmacenet_data *plat_dat,
 			val |= FIELD_PREP(MACPHYC_RX_SEL_MASK, MACPHYC_RX_SEL_DELAY) |
 				   FIELD_PREP(MACPHYC_RX_DELAY_MASK, (mac->rx_delay + 9750) / 19500 - 1);
 
-		dev_dbg(mac->dev, "MAC PHY Control Register: PHY_INTERFACE_MODE_RGMII\n");
 		break;
 
 	default:
@@ -237,6 +222,9 @@ static int ingenic_mac_init(struct platform_device *pdev, void *bsp_priv)
 			return phy_intf_sel < 0 ? phy_intf_sel : -EINVAL;
 		}
 
+		dev_dbg(mac->dev, "MAC PHY control register: interface %s\n",
+			phy_modes(interface));
+
 		ret = mac->soc_info->set_mode(mac->plat_dat, phy_intf_sel);
 		if (ret)
 			return ret;
-- 
2.47.3


