Return-Path: <netdev+bounces-224084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA85B80935
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564F36227A2
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5140530C0E5;
	Wed, 17 Sep 2025 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0YjQF4VT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66B730C0E4
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122990; cv=none; b=gjJX/fEVs7o5nHGaxZKhTffhPg3cWMCDfLUmHcP0oKAmreLaJFZyL7UMh1ijXvFZoZ1KRnoYxdijRrvNrO+wrN/tq+TDROztFM9z00QyNOm8bCXxS2Njrf0GkiA/aaZzIe7hJiyzP610Sjt0TJosJOUo6Wka/Gv4m8fpdpBk4qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122990; c=relaxed/simple;
	bh=UdW3ae6sTPDx44OpTpreWT5On9qNKbtCzO7LHscts0I=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=HFmwa7EcmlevDifZF1ly6LAylwfQrsWXcuEBtmDQJtvsO+k274wNBuj+40Tl3l+ymGSnBF2faVgVlxhevvpYAiiSyIkbVO1J5bnVzGREw8K5y9t1R/Exl6Tt627GJiqaZYtLf2e+X44edhwcug2iz78z0i+HonD9oDC0wztXmbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0YjQF4VT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JRAJRW4WfloKke+sA3cXYCgUSWJDPjglxO5sAwdnW9Y=; b=0YjQF4VTUahjY2yLEZTHLsirA9
	PmtQnLqyIa+N9Biz3pWT4UPa3AVij5qesBfp0YDnwdGc7Wq/WQ1+HwQdPkENVqDIksW9znV3+9a1f
	ISQo4WIImUOMmHsM8Emuf9P0MCwoxa9RL6W22jfMyjn+1s9PO1SsErOlhang4vSFhpbtPRs8dVGQp
	0wJvgqB+ECAtCKkcn3K0P85Yls1KJnJij/sQSIbuA/LTdqLRxtrAnUeEZ3MPg26dAqFC1MPz3/QRg
	3j1ZDLRaIkCR2+CcgGv6s86gtpKnLs63wPqVlWK29iTQXbWglpSXwCtqk/uszytdKzEvu+lrUirz3
	9KJyp2Nw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42810 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uytpu-000000004mr-1r1L;
	Wed, 17 Sep 2025 16:12:46 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uytpq-00000006H2q-0ajY;
	Wed, 17 Sep 2025 16:12:42 +0100
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
Subject: [PATCH net-next 09/10] net: stmmac: thead: convert to use
 phy_interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uytpq-00000006H2q-0ajY@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 17 Sep 2025 16:12:42 +0100

dwmac-thead supports either MII or RGMII interface modes only.

None of the DTS files set "mac-mode", so mac_interface will be
identical to phy_interface.

Convert dwmac-thead to use phy_interface when determining the
interface mode rather than mac_interface.

Also convert the error prints to use phy_modes() so that we get a
meaningful string rather than a number for the interface mode.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-thead.c | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
index 6c6c49e4b66f..a3378046b061 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
@@ -56,7 +56,7 @@ static int thead_dwmac_set_phy_if(struct plat_stmmacenet_data *plat)
 	struct thead_dwmac *dwmac = plat->bsp_priv;
 	u32 phyif;
 
-	switch (plat->mac_interface) {
+	switch (plat->phy_interface) {
 	case PHY_INTERFACE_MODE_MII:
 		phyif = PHY_INTF_MII_GMII;
 		break;
@@ -67,8 +67,8 @@ static int thead_dwmac_set_phy_if(struct plat_stmmacenet_data *plat)
 		phyif = PHY_INTF_RGMII;
 		break;
 	default:
-		dev_err(dwmac->dev, "unsupported phy interface %d\n",
-			plat->mac_interface);
+		dev_err(dwmac->dev, "unsupported phy interface %s\n",
+			phy_modes(plat->phy_interface));
 		return -EINVAL;
 	}
 
@@ -81,7 +81,7 @@ static int thead_dwmac_set_txclk_dir(struct plat_stmmacenet_data *plat)
 	struct thead_dwmac *dwmac = plat->bsp_priv;
 	u32 txclk_dir;
 
-	switch (plat->mac_interface) {
+	switch (plat->phy_interface) {
 	case PHY_INTERFACE_MODE_MII:
 		txclk_dir = TXCLK_DIR_INPUT;
 		break;
@@ -92,8 +92,8 @@ static int thead_dwmac_set_txclk_dir(struct plat_stmmacenet_data *plat)
 		txclk_dir = TXCLK_DIR_OUTPUT;
 		break;
 	default:
-		dev_err(dwmac->dev, "unsupported phy interface %d\n",
-			plat->mac_interface);
+		dev_err(dwmac->dev, "unsupported phy interface %s\n",
+			phy_modes(plat->phy_interface));
 		return -EINVAL;
 	}
 
@@ -112,7 +112,7 @@ static int thead_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
 
 	plat = dwmac->plat;
 
-	switch (plat->mac_interface) {
+	switch (plat->phy_interface) {
 	/* For MII, rxc/txc is provided by phy */
 	case PHY_INTERFACE_MODE_MII:
 		return 0;
@@ -143,8 +143,8 @@ static int thead_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
 		return 0;
 
 	default:
-		dev_err(dwmac->dev, "unsupported phy interface %d\n",
-			plat->mac_interface);
+		dev_err(dwmac->dev, "unsupported phy interface %s\n",
+			phy_modes(plat->phy_interface));
 		return -EINVAL;
 	}
 }
@@ -154,7 +154,7 @@ static int thead_dwmac_enable_clk(struct plat_stmmacenet_data *plat)
 	struct thead_dwmac *dwmac = plat->bsp_priv;
 	u32 reg, div;
 
-	switch (plat->mac_interface) {
+	switch (plat->phy_interface) {
 	case PHY_INTERFACE_MODE_MII:
 		reg = GMAC_RX_CLK_EN | GMAC_TX_CLK_EN;
 		break;
@@ -177,8 +177,8 @@ static int thead_dwmac_enable_clk(struct plat_stmmacenet_data *plat)
 		break;
 
 	default:
-		dev_err(dwmac->dev, "unsupported phy interface %d\n",
-			plat->mac_interface);
+		dev_err(dwmac->dev, "unsupported phy interface %s\n",
+			phy_modes(plat->phy_interface));
 		return -EINVAL;
 	}
 
-- 
2.47.3


