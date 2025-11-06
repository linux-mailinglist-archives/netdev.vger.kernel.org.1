Return-Path: <netdev+bounces-236288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 136C7C3A8B9
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FBF11A47215
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C9E2F39DC;
	Thu,  6 Nov 2025 11:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FGc6sukJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F2F30DEAC
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 11:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428217; cv=none; b=g0zXqCp2STuJ5Aq3EEVb/jCGj23VW5jGvuDH0kPymeDRdFaDQWpNZaMtHjRirWgp5Z3WDCQBn0rGr6AslCcrajOXMNCUQxcG6ZemqWKx4xAx43fcJ/xAIsiK+gtpG9+xZoaGRBRbGmGHmHSTxvSkbxLE0uZEPuriYIOZdn+EKFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428217; c=relaxed/simple;
	bh=u5JRMV6ZaOD+PfJyYnMEEOFBrOELIcP3O51hQs3t37Y=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=rW/VTifNRTP/1ykMj341ytj8carwu8SnlOgS0jP8ILazNDhPzXmFh30VQmcv5IB/nteO2BY0NpVgaVSSbDoI2qpbKiulCJSyCHWMQKrYGlvMQBsOUKZMp66t4Q4r2baDW1QCssIl44IRQ5ky2uRmqd/Cb++68ACaNxJwmioBoVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FGc6sukJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Js07L2+stsnCOsHYtwgWgYhrIURfTXFROESqW1QevdM=; b=FGc6sukJ2lsJ2sauwWWQGny/zi
	QqmYQScqqSHJgY02Eofk2csdW/YSRtvHSH/h5T/LkWLDWTfMevAUNx1UdE81Le5o+oQLGKOPYJBy0
	7qROGXanjD0s5qs0SlX/jvNwMq07ok2//++rgFkxSzZmdr4PTAeL4tbY25XxhJ3/R/mV3ZUZ8ibbR
	zdB17AuzqwcWemuGz3d9MIZTjD0eLGEi4GEPEoCU5DbRT/aksFL60hjKa3FLU7ndCzVxkGo21ytpS
	Q6e0mfalnSSETbxqN604WklQAuK8Av6b8guFPbIcHRMK54CpgGz23ZoQOWwRNdqH/EO+b5XY76Jxk
	IhpyVoUA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52994 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vGy5Q-000000004v4-1qao;
	Thu, 06 Nov 2025 11:23:28 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vGy5P-0000000DhQJ-0Oi3;
	Thu, 06 Nov 2025 11:23:27 +0000
In-Reply-To: <aQyEs4DAZRWpAz32@shell.armlinux.org.uk>
References: <aQyEs4DAZRWpAz32@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 4/9] net: stmmac: lpc18xx: validate phy_intf_sel
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vGy5P-0000000DhQJ-0Oi3@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 06 Nov 2025 11:23:27 +0000

Validate the phy_intf_sel value rather than the PHY interface mode.
This will allow us to transition to the ->set_phy_intf_sel() method.
Note that this will allow GMII as well as MII as the phy_intf_sel
value is the same for both.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
index 0f6be2a17e65..ec60968113b8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
@@ -47,14 +47,13 @@ static int lpc18xx_dwmac_probe(struct platform_device *pdev)
 		return PTR_ERR(reg);
 	}
 
-	if (plat_dat->phy_interface != PHY_INTERFACE_MODE_MII &&
-	    plat_dat->phy_interface != PHY_INTERFACE_MODE_RMII) {
+	ethmode = stmmac_get_phy_intf_sel(plat_dat->phy_interface);
+	if (ethmode != PHY_INTF_SEL_GMII_MII &&
+	    ethmode != PHY_INTF_SEL_RMII) {
 		dev_err(&pdev->dev, "Only MII and RMII mode supported\n");
 		return -EINVAL;
 	}
 
-	ethmode = stmmac_get_phy_intf_sel(plat_dat->phy_interface);
-
 	regmap_update_bits(reg, LPC18XX_CREG_CREG6,
 			   LPC18XX_CREG_CREG6_ETHMODE_MASK, ethmode);
 
-- 
2.47.3


