Return-Path: <netdev+bounces-199389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA11AE0203
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 11:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3005A3BEB0E
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 09:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE866220F4D;
	Thu, 19 Jun 2025 09:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fdRbQF6M"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CA921C161
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 09:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750326499; cv=none; b=R1Gp5QZgCFJAYwJuTK3unBkusrgDiBzjT2mKooIIy2YQ9uv5YbBJGi2RUNkb5wgKoaY8y96BxWi4SB5E4Z9qPe0VYr/uNGyWaY+tGjKlWl4svL+7aGshddBxmFS8vXViYLSl1xT5YumkrnYGKu0GHa9Sgh2wrN/qSEamuw+bh8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750326499; c=relaxed/simple;
	bh=+hI8Xs4QODG0WyLiH7srKpnO6ErrVHPlG4SA6o6CR2k=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=pPKaIeOnXSnsOnt7HQwdNnYA9y5QaW5MfvNmIb9kURKoz5kaAGOyAOTYNcmCb4kEwgXkEb2E/NejpUyX6GYWumLGMDlcYmWxHmqHQPBUseAWOHV62HA7NnzeAlZ1ukq9inueWyk0oO43gM5D4kcY7T1Lssx1Rso90H2BP1Dci9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fdRbQF6M; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AApn2ot00InFaDW5pjrmd9wr1a+/4qJM2q8x8u9VFeM=; b=fdRbQF6MGkCqD0lNx0zAhb1Dqz
	W0tjVHZaO82AfU5sMTZ3dCl0inJV9nwPOx0IW42nB3xqZfYC1Mve+iKAYTU46+V2hMQ6xXHNEpNGt
	TZPtEfLnRZMDLTEdSQIjR5GgxcKB6rKMfgvxPAtCNMvOTeEoYm4Hjk8aQS/pI0Nxn7eaKhJJZIIlp
	V+vW3PAl0K6CoRtA2Pd2C1BndrqbF33ov76LDDxqhNbKfiRPbh+tnwFeIhKiybTaaBkoPnyX59PlR
	JyZh7hVsMQzH05c+d8QJ85xR8cH7zd0yO3YMN0sT//qZb/FlszBqolVK3yolSZGkjSrXFaaEEk7f6
	Gh7KVPTg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51446 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uSBsM-0007jW-3D;
	Thu, 19 Jun 2025 10:48:07 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uSBri-004fL5-FI; Thu, 19 Jun 2025 10:47:26 +0100
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
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH net-next] net: stmmac: lpc18xx: use plat_dat->phy_interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uSBri-004fL5-FI@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 19 Jun 2025 10:47:26 +0100

lpc18xx uses plat_dat->mac_interface, despite wanting to validate the
PHY interface. Checking the DT files (arch/arm/boot/dts/nxp/lpc/), none
of them specify mac-mode which means mac_interface and phy_interface
will be identical.

mac_interface is only used when there is some kind of MII converter
between the DesignWare MAC and PHY, and describes the interface mode
that the DW MAC needs to use, whereas phy_interface describes the
interface mode that the PHY uses.

Noting that lpc18xx only supports MII and RMII interface modes, switch
this glue driver to use plat_dat->phy_interface, and to mark that the
mac_interface is not used, explicitly set it to PHY_INTERFACE_MODE_NA.
The latter is safe as the only user of mac_interface for this platform
would be in stmmac_check_pcs_mode(), which only checks for RGMII or
SGMII.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
index 22653ffd2a04..c0c44916f849 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
@@ -41,6 +41,7 @@ static int lpc18xx_dwmac_probe(struct platform_device *pdev)
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
+	plat_dat->mac_interface = PHY_INTERFACE_MODE_NA;
 	plat_dat->has_gmac = true;
 
 	reg = syscon_regmap_lookup_by_compatible("nxp,lpc1850-creg");
@@ -49,9 +50,9 @@ static int lpc18xx_dwmac_probe(struct platform_device *pdev)
 		return PTR_ERR(reg);
 	}
 
-	if (plat_dat->mac_interface == PHY_INTERFACE_MODE_MII) {
+	if (plat_dat->phy_interface == PHY_INTERFACE_MODE_MII) {
 		ethmode = LPC18XX_CREG_CREG6_ETHMODE_MII;
-	} else if (plat_dat->mac_interface == PHY_INTERFACE_MODE_RMII) {
+	} else if (plat_dat->phy_interface == PHY_INTERFACE_MODE_RMII) {
 		ethmode = LPC18XX_CREG_CREG6_ETHMODE_RMII;
 	} else {
 		dev_err(&pdev->dev, "Only MII and RMII mode supported\n");
-- 
2.30.2


