Return-Path: <netdev+bounces-170170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CABA478DC
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 10:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13F1171D8E
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 09:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248EC22687C;
	Thu, 27 Feb 2025 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Fswkmnpd"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB06226188
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740647848; cv=none; b=AFiUD5MSUM+RDJZVHMBwAS4M+eyOrFIygW6Gd2JKL8LTyVbUe/aYY1VD09bjii+0fQfDGQB3nQssDfn/yAMVM5eVDhsgQ6NLMcRNMFZkC3ehMG8BshLhfUT46kVthpdzvMzskY9cKweoyVwv6JZtNwtnvjm7WNLR2YsdX8/SK2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740647848; c=relaxed/simple;
	bh=VWZBKUEMMEzCwJokjrNGgXXMtk8psoxZybFirTb5qzo=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=BgsHuDYq9IKgYvhH/aaGeD7cD4KhaUDbBFPDyiWVpCf9YCI5+s//4TK1xY4+Gr/TstSEDySO/GJfDDP7/AaVImLXjnkfADrshU8Hno9gDp0U6fTqr5X/oZ3rdnSab84Psqc8HrTEdytuQtgxC2oZQqkmn0G0ogpA7/yMWJLhXb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Fswkmnpd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ar9U8vywYkCzFOSigD5N+dM7En/CQg4G4NArSWcUyqA=; b=Fswkmnpdej517Pxe4qm3+867fC
	YjMWTko7DumqM0dYbTHSfmWUvEsMMwez+VmXNT0H724SaEjJ0i5QF0Z+Wk534JzumAZrFDAFJ+n4p
	7ndEDI1ssF+PcDmbutDyLrenDuiDRU17oyV10mibL6i8amtVllQ2e5odagkGof/eqzAfUkmHdZ+7J
	WwwBUoL6/+JPphc8TC5kV4D7pDGPS8IqVwjlL92vT6ethTUizdoH3JV9WGZqb6c48ClSDKcwHMbFh
	fnFa3/21IFQnpP1b1LtsPiETuPucc1ULQKZ/HYyb4ja2jFP6G7pNm+CKDOsrAdqMCRCyQX5HylAsQ
	WljGscJQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38772 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tna19-0006dT-1c;
	Thu, 27 Feb 2025 09:17:19 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tna0p-0052t8-Gn; Thu, 27 Feb 2025 09:16:59 +0000
In-Reply-To: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
References: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 08/11] net: stmmac: rk: switch to use
 set_clk_tx_rate() hook
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tna0p-0052t8-Gn@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 27 Feb 2025 09:16:59 +0000

Switch from using the fix_mac_speed() hook to set_clk_tx_rate() to
manage the transmit clock.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 83d104a274c5..003fa5cf42c3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1920,9 +1920,10 @@ static void rk_gmac_powerdown(struct rk_priv_data *gmac)
 	gmac_clk_enable(gmac, false);
 }
 
-static void rk_fix_speed(void *priv, int speed, unsigned int mode)
+static int rk_set_clk_tx_rate(void *bsp_priv_, struct clk *clk_tx_i,
+			      phy_interface_t interface, int speed)
 {
-	struct rk_priv_data *bsp_priv = priv;
+	struct rk_priv_data *bsp_priv = bsp_priv_;
 	struct device *dev = &bsp_priv->pdev->dev;
 
 	switch (bsp_priv->phy_iface) {
@@ -1940,6 +1941,8 @@ static void rk_fix_speed(void *priv, int speed, unsigned int mode)
 	default:
 		dev_err(dev, "unsupported interface %d", bsp_priv->phy_iface);
 	}
+
+	return 0;
 }
 
 static int rk_gmac_probe(struct platform_device *pdev)
@@ -1968,7 +1971,8 @@ static int rk_gmac_probe(struct platform_device *pdev)
 	 */
 	if (!plat_dat->has_gmac4)
 		plat_dat->has_gmac = true;
-	plat_dat->fix_mac_speed = rk_fix_speed;
+
+	plat_dat->set_clk_tx_rate = rk_set_clk_tx_rate;
 
 	plat_dat->bsp_priv = rk_gmac_setup(pdev, plat_dat, data);
 	if (IS_ERR(plat_dat->bsp_priv))
-- 
2.30.2


