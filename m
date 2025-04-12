Return-Path: <netdev+bounces-181908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EDFA86D9B
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 16:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283EE441BF3
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 14:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFAE1865E2;
	Sat, 12 Apr 2025 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vFTpm1I/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC6A13E02D
	for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744467469; cv=none; b=AJTE0P5Mpl1PXT3omH3X3avT9ia52YnduWC6jjbl5+2i1J1HayH1hzpOk9dijIJ0Or7h7MlnniV3lgKFXDEZsGPFMtGW+qfzXetn13SXXl2cfj0ne95cgiOE+8xDey8WxRf6zjO7QZt7Tg0IiYYrFLquHte9PUUlwY6YVdTSx0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744467469; c=relaxed/simple;
	bh=+4E3QZ+6EFvffFpgMcnR/EDG0WCK67HOo4vgmzM9FM4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=s49m+gwLFlSIuQlUpJF4/a0ytBrLMTKxgMRqyWl2ZE1oHFkbjuM1gWMDkBh/Z5wDzTRRtMEoECEiUkL41TYh03a/sowiWQzcShV/UpzMAlhZBKIzheup31IFTl97m67YP+aGGYruv4wHo6wsLCp35IGAnUhVF1Q3pARq06dQ+5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vFTpm1I/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9OIIjhcKLfkbeExIwpZlDqErivtxHqPAqqed9OPHM0g=; b=vFTpm1I/AYgLDpEEyHctffz9+Q
	MUNXG1LhsrTXRNnJCDLpRhqfK00GzaBnMrqtl6IbIBsvPe7Mh5xhu81lE8thlcKstbDLMfd/fC6IA
	6v51/JflKOO7K054YNhTAf1Vc4/3Aw5S1lS2YFXzSFCN5ZiRvEPwaRkdNq8LVt/nUnmp3vYF3B5he
	9Aj85WZp6Q36+Xn7jAnS0aah9RSCTTTwl4OJgq7U8AkBriqyqctLmCkQxynaC8s97Zj7ZvfiVz6ML
	8D+OE4laZ4k0NCku+r7Oc9fGW1nuoJM0KLudk5ms9BDN8bW51GyG4ChEjeuakf87VNqqDYjqk7Bdt
	iSGsmlsQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50614 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u3bfv-0004cE-2A;
	Sat, 12 Apr 2025 15:17:39 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u3bfK-000Elr-Fa; Sat, 12 Apr 2025 15:17:02 +0100
In-Reply-To: <Z_p16taXJ1sOo4Ws@shell.armlinux.org.uk>
References: <Z_p16taXJ1sOo4Ws@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 2/4] net: stmmac: anarion: clean up interface parsing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u3bfK-000Elr-Fa@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 12 Apr 2025 15:17:02 +0100

anarion_config_dt() used a switch statement to check for the RGMII
modes, complete with an unnecessary "fallthrough", and also printed
the numerical value of the PHY interface mode on error. Clean this
up using the phy_interface_mode_is_rgmii() helper, and print the
English version of the PHY interface mode on error.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-anarion.c    | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
index 232aae752690..941ea724c643 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
@@ -79,17 +79,11 @@ anarion_config_dt(struct platform_device *pdev,
 
 	gmac->ctl_block = ctl_block;
 
-	switch (plat_dat->phy_interface) {
-	case PHY_INTERFACE_MODE_RGMII:
-		fallthrough;
-	case PHY_INTERFACE_MODE_RGMII_ID:
-	case PHY_INTERFACE_MODE_RGMII_RXID:
-	case PHY_INTERFACE_MODE_RGMII_TXID:
+	if (phy_interface_mode_is_rgmii(plat_dat->phy_interface)) {
 		gmac->phy_intf_sel = GMAC_CONFIG_INTF_RGMII;
-		break;
-	default:
-		dev_err(&pdev->dev, "Unsupported phy-mode (%d)\n",
-			plat_dat->phy_interface);
+	} else {
+		dev_err(&pdev->dev, "Unsupported phy-mode (%s)\n",
+			phy_modes(plat_dat->phy_interface));
 		return ERR_PTR(-ENOTSUPP);
 	}
 
-- 
2.30.2


