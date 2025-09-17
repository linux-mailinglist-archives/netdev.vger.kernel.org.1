Return-Path: <netdev+bounces-224079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE10B80768
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656CC1898BC9
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CEE306B3C;
	Wed, 17 Sep 2025 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Ky4aasfZ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29389330D47
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121990; cv=none; b=bXFHyZwr3GmT7R+jHsi64nKCwsGtAqiiuFJWd2Cwkr4HBmF9KeLSx7Py2uCW20tJaVRGJYLuEG5MUCStRdz/v13EOGNh2G15D/Wj1haeX7mI252s22IT9Zs/U7bLTNo7W8W/CCt1jmgAJp8bRB3J8MMCJNSv5/4YdJVVh9qkIVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121990; c=relaxed/simple;
	bh=2o4jP5pOMc4mAfDOReHTE+0fpmXU6ZL9807Bimuu3y0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=gbp9KqkV9Eayfq+i0hA2WSfWpW18zVOtIZwhQ2JSoT91eiE1wI4SMBMHSDVk2Oo5gpMf2BdIrzWcFT4eSin9Cs3NhCMm+Ia1n7RJ1N81Fwvxb4X6sqhBr/lcVJyIsn81KJbog30zu8yjxXcaPBNChK7sDT+7gwWQc14x6mYypNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Ky4aasfZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PLGSCkhJYkYCcobuSQ5Oyaf1uTdDzYldkQNkhdDB1IA=; b=Ky4aasfZomTPEs8qJrkEO+3qSW
	R+FEbkZwUTF3AVeo4jl+6lmcokTr3ASdPmX3cAoDOnIzqYLLYIVHLDSQ+rG7DxOkiJiKXq9GJyC5X
	8h5tF0n2ewXaLazmDSEpe+y1ae24MT3D60FIsCPBiH41ERffhxDePikqTk3P4PYqU+G1Nj6FgLBlh
	qTb1fnO0wDSjezlqtu++O4VmGYgHDQzkYkxW/CIxn4YBuhvkBaDw+/apGHqaI9uHFYheS+QjW0Bm5
	5GTeaDgY8ynejLytv4jFUYvtq2HE/b7WVgfdoAnvrJb27nHkBC7kvUt9K6EoGDEJE77TQKP3dc19o
	3skCHiuA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60996 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uytpl-000000004m2-0fIP;
	Wed, 17 Sep 2025 16:12:37 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uytpf-00000006H2c-3hiU;
	Wed, 17 Sep 2025 16:12:31 +0100
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
Subject: [PATCH net-next 07/10] net: stmmac: stm32: convert to use
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
Message-Id: <E1uytpf-00000006H2c-3hiU@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 17 Sep 2025 16:12:31 +0100

dwmac-stm32 supports MII, RMII, GMII and RGMII interface modes,
selecting the dwmac core interface mode via bits 23:21 of the
SYSCFG register. The bit combinations are identical to the
dwmac phy_intf_sel_i signals.

None of the DTS files set "mac-mode", so mac_interface will be
identical to phy_interface.

Convert dwmac-stm32 to use phy_interface when determining the
interface mode rather than mac_interface.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index 77a04c4579c9..6c179911ef3f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -171,7 +171,7 @@ static int stm32mp1_select_ethck_external(struct plat_stmmacenet_data *plat_dat)
 {
 	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
 
-	switch (plat_dat->mac_interface) {
+	switch (plat_dat->phy_interface) {
 	case PHY_INTERFACE_MODE_MII:
 		dwmac->enable_eth_ck = dwmac->ext_phyclk;
 		return 0;
@@ -193,7 +193,7 @@ static int stm32mp1_select_ethck_external(struct plat_stmmacenet_data *plat_dat)
 	default:
 		dwmac->enable_eth_ck = false;
 		dev_err(dwmac->dev, "Mode %s not supported",
-			phy_modes(plat_dat->mac_interface));
+			phy_modes(plat_dat->phy_interface));
 		return -EINVAL;
 	}
 }
@@ -206,7 +206,7 @@ static int stm32mp1_validate_ethck_rate(struct plat_stmmacenet_data *plat_dat)
 	if (!dwmac->enable_eth_ck)
 		return 0;
 
-	switch (plat_dat->mac_interface) {
+	switch (plat_dat->phy_interface) {
 	case PHY_INTERFACE_MODE_MII:
 	case PHY_INTERFACE_MODE_GMII:
 		if (clk_rate == ETH_CK_F_25M)
@@ -228,7 +228,7 @@ static int stm32mp1_validate_ethck_rate(struct plat_stmmacenet_data *plat_dat)
 	}
 
 	dev_err(dwmac->dev, "Mode %s does not match eth-ck frequency %d Hz",
-		phy_modes(plat_dat->mac_interface), clk_rate);
+		phy_modes(plat_dat->phy_interface), clk_rate);
 	return -EINVAL;
 }
 
@@ -238,7 +238,7 @@ static int stm32mp1_configure_pmcr(struct plat_stmmacenet_data *plat_dat)
 	u32 reg = dwmac->mode_reg;
 	int val = 0;
 
-	switch (plat_dat->mac_interface) {
+	switch (plat_dat->phy_interface) {
 	case PHY_INTERFACE_MODE_MII:
 		/*
 		 * STM32MP15xx supports both MII and GMII, STM32MP13xx MII only.
@@ -269,12 +269,12 @@ static int stm32mp1_configure_pmcr(struct plat_stmmacenet_data *plat_dat)
 		break;
 	default:
 		dev_err(dwmac->dev, "Mode %s not supported",
-			phy_modes(plat_dat->mac_interface));
+			phy_modes(plat_dat->phy_interface));
 		/* Do not manage others interfaces */
 		return -EINVAL;
 	}
 
-	dev_dbg(dwmac->dev, "Mode %s", phy_modes(plat_dat->mac_interface));
+	dev_dbg(dwmac->dev, "Mode %s", phy_modes(plat_dat->phy_interface));
 
 	/* Shift value at correct ethernet MAC offset in SYSCFG_PMCSETR */
 	val <<= ffs(dwmac->mode_mask) - ffs(SYSCFG_MP1_ETH_MASK);
@@ -294,7 +294,7 @@ static int stm32mp2_configure_syscfg(struct plat_stmmacenet_data *plat_dat)
 	u32 reg = dwmac->mode_reg;
 	int val = 0;
 
-	switch (plat_dat->mac_interface) {
+	switch (plat_dat->phy_interface) {
 	case PHY_INTERFACE_MODE_MII:
 		/* ETH_REF_CLK_SEL bit in SYSCFG register is not applicable in MII mode */
 		break;
@@ -319,12 +319,12 @@ static int stm32mp2_configure_syscfg(struct plat_stmmacenet_data *plat_dat)
 		break;
 	default:
 		dev_err(dwmac->dev, "Mode %s not supported",
-			phy_modes(plat_dat->mac_interface));
+			phy_modes(plat_dat->phy_interface));
 		/* Do not manage others interfaces */
 		return -EINVAL;
 	}
 
-	dev_dbg(dwmac->dev, "Mode %s", phy_modes(plat_dat->mac_interface));
+	dev_dbg(dwmac->dev, "Mode %s", phy_modes(plat_dat->phy_interface));
 
 	/* Select PTP (IEEE1588) clock selection from RCC (ck_ker_ethxptp) */
 	val |= SYSCFG_ETHCR_ETH_PTP_CLK_SEL;
@@ -359,7 +359,7 @@ static int stm32mcu_set_mode(struct plat_stmmacenet_data *plat_dat)
 	u32 reg = dwmac->mode_reg;
 	int val;
 
-	switch (plat_dat->mac_interface) {
+	switch (plat_dat->phy_interface) {
 	case PHY_INTERFACE_MODE_MII:
 		val = SYSCFG_MCU_ETH_SEL_MII;
 		break;
@@ -368,12 +368,12 @@ static int stm32mcu_set_mode(struct plat_stmmacenet_data *plat_dat)
 		break;
 	default:
 		dev_err(dwmac->dev, "Mode %s not supported",
-			phy_modes(plat_dat->mac_interface));
+			phy_modes(plat_dat->phy_interface));
 		/* Do not manage others interfaces */
 		return -EINVAL;
 	}
 
-	dev_dbg(dwmac->dev, "Mode %s", phy_modes(plat_dat->mac_interface));
+	dev_dbg(dwmac->dev, "Mode %s", phy_modes(plat_dat->phy_interface));
 
 	return regmap_update_bits(dwmac->regmap, reg,
 				 SYSCFG_MCU_ETH_MASK, val << 23);
-- 
2.47.3


