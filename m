Return-Path: <netdev+bounces-224083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A4AB8092F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380C1623FE3
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC1930C110;
	Wed, 17 Sep 2025 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cmLmfPjn"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA63A30C100
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122965; cv=none; b=ipdR0e2AmtIfQ7Mvi/U9Q+PvZot+/FlHNs2iYGUjmHD3IP6e/9PEXwGS6TY5V/wO7AZDGuD6vLDhHIHO9jhXO8AO9CbXrqpIEPGWarFySpQcy3zX8RVylC1wCxtcn6spla7PGudgXFpk7jf9l6Rng5Ygr+oU14urzo1moNGjlmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122965; c=relaxed/simple;
	bh=+3tp+XBFxUD228D6hv/nxzpWNrGkhM4J6eg/MJaE7rY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=m7NTO9yRJylWQQCVTL6Shf7CuCYyj9B9hwJBhhqaDoYKnleeuBuF+1ELD7N9hOej/pvC3wkrLK2YIqLwb1MR7d5Lw16O9kqxA1lgItOshD+Y7gsa+LNpeYROnyKKWDegFeVWjt3Ak+XL+Zr9BFXaaDwcgpVDxZ5f7ZgoJ6Om6yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=cmLmfPjn; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xtZeWx9KqJQHyw/RwePAF9k/RAwt4wluWSxKJcfUeCU=; b=cmLmfPjnvDCQAT+4j4CDP/CqP2
	f9se6tU2GSHHFs2/ZKmDFUJECu+41yF3IJuR3tgPqhxBrmeKO00vPY4wEJsBuiXrROerDtefj0e5L
	3uxX34vV3QCJgBKz9rY9eTWSUDFR3A6UMaWCOAgXwFljG9OFlctEbZIjvIbTo65S+IWe3uSk62+ta
	vJEZQOlRae+y+ZlL/MZhPc4wm2RWWSiHhmToiL8nbMTCFDwMv+WozI8us5n1RVKhj2iGYxVWXBrQs
	we6nbF3GePtbZP3AHiSy+yEMfMAIWSQagl/ymveh19RWWdpor5uHVFj4foxiGRFdSir85U72CO2OU
	OAY1GLZA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57100 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uytq1-000000004nF-1c12;
	Wed, 17 Sep 2025 16:12:53 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uytpv-00000006H2x-196h;
	Wed, 17 Sep 2025 16:12:47 +0100
In-Reply-To: <aMrPpc8oRxqGtVPJ@shell.armlinux.org.uk>
References: <aMrPpc8oRxqGtVPJ@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chen-Yu Tsai <wens@csie.org>,
	"David S. Miller" <davem@davemloft.net>,
	Drew Fustini <fustini@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Fu Wei <wefu@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Samuel Holland <samuel@sholland.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH net-next 10/10] net: stmmac: remove mac_interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uytpv-00000006H2x-196h@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 17 Sep 2025 16:12:47 +0100

mac_interface has served little purpose, and has only caused confusion.
Now that we have cleaned up all platform glue drivers which should not
have been using mac_interface, there are no users remaining. Remove
mac_interface.

This results in the special dwmac specific "mac-mode" DT property
becoming redundant, and an in case, no DTS files in the kernel make use
of this property. Add a warning if the property is set, and it is
different from the "phy-mode".

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c  |  2 --
 drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c   |  1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c     |  5 +----
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c |  6 +++++-
 include/linux/stmmac.h                                | 11 +++--------
 5 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index dd82dc2189e9..592aa9d636e5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -98,8 +98,6 @@ static void loongson_default_data(struct pci_dev *pdev,
 	/* Set default value for multicast hash bins */
 	plat->multicast_filter_bins = 256;
 
-	plat->mac_interface = PHY_INTERFACE_MODE_NA;
-
 	/* Set default value for unicast filter entries */
 	plat->unicast_filter_entries = 1;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
index c0c44916f849..2562a6d036a2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
@@ -41,7 +41,6 @@ static int lpc18xx_dwmac_probe(struct platform_device *pdev)
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
-	plat_dat->mac_interface = PHY_INTERFACE_MODE_NA;
 	plat_dat->has_gmac = true;
 
 	reg = syscon_regmap_lookup_by_compatible("nxp,lpc1850-creg");
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a23017a886f3..d17820d9e7f1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1118,10 +1118,7 @@ static const struct phylink_mac_ops stmmac_phylink_mac_ops = {
  */
 static void stmmac_check_pcs_mode(struct stmmac_priv *priv)
 {
-	int interface = priv->plat->mac_interface;
-
-	if (interface == PHY_INTERFACE_MODE_NA)
-		interface = priv->plat->phy_interface;
+	int interface = priv->plat->phy_interface;
 
 	if (priv->dma_cap.pcs) {
 		if ((interface == PHY_INTERFACE_MODE_RGMII) ||
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index a3e077f225d1..712ef235f0f4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -453,8 +453,12 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 		return ERR_PTR(phy_mode);
 
 	plat->phy_interface = phy_mode;
+
 	rc = stmmac_of_get_mac_mode(np);
-	plat->mac_interface = rc < 0 ? plat->phy_interface : rc;
+	if (rc >= 0 && rc != phy_mode)
+		dev_warn(&pdev->dev,
+			 "\"mac-mode\" property used for %s but differs to \"phy-mode\" of %s, and will be ignored. Please report.\n",
+			 phy_modes(rc), phy_modes(phy_mode));
 
 	/* Some wrapper drivers still rely on phy_node. Let's save it while
 	 * they are not converted to phylink. */
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index f14f34ec6d5e..fa1318bac06c 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -190,8 +190,8 @@ struct plat_stmmacenet_data {
 	int bus_id;
 	int phy_addr;
 	/* MAC ----- optional PCS ----- SerDes ----- optional PHY ----- Media
-	 *                          ^            ^
-	 *                    mac_interface phy_interface
+	 *                                       ^
+	 *                                  phy_interface
 	 *
 	 * The Synopsys dwmac core only covers the MAC and an optional
 	 * integrated PCS. Where the integrated PCS is used with a SerDes,
@@ -208,12 +208,7 @@ struct plat_stmmacenet_data {
 	 * is used, this counts as "the rest of the SoC" in the above
 	 * paragraph.
 	 *
-	 * Thus, mac_interface is of little use inside the stmmac code;
-	 * please do not use unless there is a definite requirement, and
-	 * make sure to gain review feedback first.
-	 */
-	phy_interface_t mac_interface;
-	/* phy_interface is the PHY-side interface - the interface used by
+	 * phy_interface is the PHY-side interface - the interface used by
 	 * an attached PHY or SFP etc. This is equivalent to the interface
 	 * that phylink uses.
 	 */
-- 
2.47.3


