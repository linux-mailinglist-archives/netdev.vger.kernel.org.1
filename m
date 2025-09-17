Return-Path: <netdev+bounces-224075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38239B80760
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C1AF1895F2D
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2C632E739;
	Wed, 17 Sep 2025 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Pqne3nUK"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4212D9EF9
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121964; cv=none; b=eEH/Ypo+1gRnmaoc2p1D++i942LtvbkCQYJvFgXSK+5/M2UJ7UBpuRAGBuYN1dtrsUuEjhPna9Dc56PEaTbJ+HMIpyBEfbjSuIveXYDK5/DnsbRejkyTDpxaVDJgfqaXlly6ujptGrsjgjg9EJDNl+Haa5ivNQEGQbovAZWoXeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121964; c=relaxed/simple;
	bh=PEL2tJih7xHRHD/P9BKdG0mcQ/77rzqZZGZioTU3vAA=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=dROFTsoyo8mnWW2crUob4Ky5yIKcDD/WNbxvCaOd0berGU++g8RKECjZqwOHKN/EI3MSFYq52bpxWfWGMR9ujjfOtBQ2MaiuuDDKilWsdwWX6V/kb/D5IKWlnZH+lisbRFzB7+tnC4URoSazf5CuQmOKC5WPmux2uxOIXZ74MXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Pqne3nUK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=O1d4PdhmWXab487Qmnpyv/UQOdJgyUlVnXpcfDIvvio=; b=Pqne3nUKJrbNd08WmRsH1VgjPS
	crju6qG4wPTq54tK0iiV+OTGCt95Licg+PkwaNVjUswxmPex/LBzA2dXM3JHwWF7Ko323ejBpr4j4
	ob0Tu4hRnpG3sGBgyFs8RxZJVBv0S6dkLI8437zZ9mQtKnaB44Gi4wFiUJ+QvdpUxxLlg/7OHfFWr
	vxWHEWIV252pnqBdU47JAUBjFYYm4NbgaSUaiQI0+PxOoRoALKTHNpO710c9Z1jA8ytQ5wApimbGI
	/+ipugw0VKzafNr3x0TFp7a84epvjUCqRmjbnQRzJO1t7JjiJjlwqIN5VybbnZyJtu/chRqvB1Rkj
	1zrXrAwg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58688 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uytpM-000000004kW-33fd;
	Wed, 17 Sep 2025 16:12:13 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uytpL-00000006H2F-1o6b;
	Wed, 17 Sep 2025 16:12:11 +0100
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
Subject: [PATCH net-next 03/10] net: stmmac: imx: convert to use phy_interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uytpL-00000006H2F-1o6b@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 17 Sep 2025 16:12:11 +0100

Checking the IMX8MP documentation, there is no requirement for a
separate mac_interface mode definition. As mac_interface and
phy_interface will be the same, use phy_interface internally rather
than mac_interface.

Also convert the error prints to use phy_modes() so that we get a
meaningful string rather than a number for the interface mode.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 80200a6aa0cb..4268b9987237 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -72,7 +72,7 @@ static int imx8mp_set_intf_mode(struct plat_stmmacenet_data *plat_dat)
 	struct imx_priv_data *dwmac = plat_dat->bsp_priv;
 	int val;
 
-	switch (plat_dat->mac_interface) {
+	switch (plat_dat->phy_interface) {
 	case PHY_INTERFACE_MODE_MII:
 		val = GPR_ENET_QOS_INTF_SEL_MII;
 		break;
@@ -88,8 +88,8 @@ static int imx8mp_set_intf_mode(struct plat_stmmacenet_data *plat_dat)
 		      GPR_ENET_QOS_RGMII_EN;
 		break;
 	default:
-		pr_debug("imx dwmac doesn't support %d interface\n",
-			 plat_dat->mac_interface);
+		pr_debug("imx dwmac doesn't support %s interface\n",
+			 phy_modes(plat_dat->phy_interface));
 		return -EINVAL;
 	}
 
@@ -112,7 +112,7 @@ static int imx93_set_intf_mode(struct plat_stmmacenet_data *plat_dat)
 	struct imx_priv_data *dwmac = plat_dat->bsp_priv;
 	int val, ret;
 
-	switch (plat_dat->mac_interface) {
+	switch (plat_dat->phy_interface) {
 	case PHY_INTERFACE_MODE_MII:
 		val = MX93_GPR_ENET_QOS_INTF_SEL_MII;
 		break;
@@ -134,8 +134,8 @@ static int imx93_set_intf_mode(struct plat_stmmacenet_data *plat_dat)
 		val = MX93_GPR_ENET_QOS_INTF_SEL_RGMII;
 		break;
 	default:
-		dev_dbg(dwmac->dev, "imx dwmac doesn't support %d interface\n",
-			 plat_dat->mac_interface);
+		dev_dbg(dwmac->dev, "imx dwmac doesn't support %s interface\n",
+			phy_modes(plat_dat->phy_interface));
 		return -EINVAL;
 	}
 
@@ -197,7 +197,7 @@ static int imx_dwmac_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
 {
 	struct imx_priv_data *dwmac = bsp_priv;
 
-	interface = dwmac->plat_dat->mac_interface;
+	interface = dwmac->plat_dat->phy_interface;
 	if (interface == PHY_INTERFACE_MODE_RMII ||
 	    interface == PHY_INTERFACE_MODE_MII)
 		return 0;
@@ -215,8 +215,8 @@ static void imx_dwmac_fix_speed(void *priv, int speed, unsigned int mode)
 	plat_dat = dwmac->plat_dat;
 
 	if (dwmac->ops->mac_rgmii_txclk_auto_adj ||
-	    (plat_dat->mac_interface == PHY_INTERFACE_MODE_RMII) ||
-	    (plat_dat->mac_interface == PHY_INTERFACE_MODE_MII))
+	    (plat_dat->phy_interface == PHY_INTERFACE_MODE_RMII) ||
+	    (plat_dat->phy_interface == PHY_INTERFACE_MODE_MII))
 		return;
 
 	rate = rgmii_clock(speed);
@@ -274,7 +274,7 @@ static int imx_dwmac_mx93_reset(struct stmmac_priv *priv, void __iomem *ioaddr)
 	value |= DMA_BUS_MODE_SFT_RESET;
 	writel(value, ioaddr + DMA_BUS_MODE);
 
-	if (plat_dat->mac_interface == PHY_INTERFACE_MODE_RMII) {
+	if (plat_dat->phy_interface == PHY_INTERFACE_MODE_RMII) {
 		usleep_range(100, 200);
 		writel(RMII_RESET_SPEED, ioaddr + MAC_CTRL_REG);
 	}
-- 
2.47.3


