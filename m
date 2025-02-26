Return-Path: <netdev+bounces-169837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DC4A45EB2
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 13:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC5127A9CD3
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 12:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B3721D3C7;
	Wed, 26 Feb 2025 12:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="I93yfmCN"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BF721D3F6
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572415; cv=none; b=eTJMuYUVkcM5xF5/BV6aICB4JbhnLuOcldbbsa0e1HL4BbceCui2oNs6EDUnw6ryG5dFcwM4eqG03Iy7DLJcgmhlT26FHVDF8mbQwy5rA3ogXJyaXFcZcL4lm/nqMN0lfcnlM3eMoxn2upGBKyhD+cfqTxX1NmafXtlHdDv+Q70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572415; c=relaxed/simple;
	bh=/lNL6BOsXdH2n2Ljwq+3NnnccrgxUDsTwft5dhFCzBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uByQjxGCN9oNATvaMS71FwaYiThjCipJgl4NE1kYQDOC1tVBeWhWbXqdNJM4aSJ3TxsrqDVgWTNAd2A/zOfg0clTiWSzmwG8ePRJqfmf0spy/tVSNrvSYbqc7jp5QZKLAPON4UJ8xCZNHjijGmoiVz8epsnV8Q/Xv9sE6+XVeZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=I93yfmCN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bZlwIOxkAACUPrshgQHP61y/YpLPScyN6eb23KhD2xM=; b=I93yfmCNTOJXyvpcdVodzhVYqQ
	0VWn5iCDf9O8PsZH/JLw8zF8L9kNKW3Zq/seBdz4VP0ERhNRIrXfekRUh18IM4BPbxsYDT9wKibvl
	Hk5TbcjcjIHyLC/adSlGeXSi2sI+X2qWT6RAY4kqiDzvaFAa+TS3lXPvwj5/OOleV18CCVLTRoh3g
	ugEdNUXe22F+MGuVrbn1BPPkeOJ3GB3ZQqeU+M3D5AOXCKnLBHYeBrSpRWj58nQx2Xzu2KJWFzTiU
	F63dJyLsyB4SKsSKJ/ET8l3F7tgKpUfo40Sa/1r6O24qoWaGOP/o+gnuLwxVmrHUEccpFCpuJXMIy
	ZNGNB3CA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59272)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tnGOM-0004Bm-0r;
	Wed, 26 Feb 2025 12:19:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tnGOF-00074L-06;
	Wed, 26 Feb 2025 12:19:51 +0000
Date: Wed, 26 Feb 2025 12:19:50 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	Inochi Amaoto <inochiama@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Minda Chen <minda.chen@starfivetech.com>, netdev@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH RFC net-next 3/7] net: stmmac: dwc-qos-eth: use generic
 stmmac_set_clk_tx_rate()
Message-ID: <Z78G5tqpMrsm8iUD@shell.armlinux.org.uk>
References: <Z7RrnyER5ewy0f3T@shell.armlinux.org.uk>
 <E1tkLYv-004RZ7-Ot@rmk-PC.armlinux.org.uk>
 <qcarhmsd6u33ij4kupaiyxvyr7jxxv2uxvr6jsnhxjd3o3axkt@z4m3zvdpxogb>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qcarhmsd6u33ij4kupaiyxvyr7jxxv2uxvr6jsnhxjd3o3axkt@z4m3zvdpxogb>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 25, 2025 at 09:35:52PM +0100, Thierry Reding wrote:
> On Tue, Feb 18, 2025 at 11:14:49AM +0000, Russell King (Oracle) wrote:
> > Use the generic stmmac_set_clk_tx_rate() to configure the MAC transmit
> > clock.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >  .../net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> Reviewed-by: Thierry Reding <treding@nvidia.com>

Hi Thierry,

Please note that things changed in this patch as a result of:

cff608268baf net: stmmac: dwc-qos: name struct plat_stmmacenet_data consistently

which has now been merged. Are you still happy for me to add your
r-b? The current patch is below.

8<===
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH net-next] net: stmmac: dwc-qos: use generic
 stmmac_set_clk_tx_rate()

Use the generic stmmac_set_clk_tx_rate() to configure the MAC transmit
clock.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index 6cadf24a575c..3f0f4ea6cf2e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -30,7 +30,6 @@ struct tegra_eqos {
 
 	struct reset_control *rst;
 	struct clk *clk_slave;
-	struct clk *clk_tx;
 
 	struct gpio_desc *reset;
 };
@@ -150,7 +149,6 @@ static void tegra_eqos_fix_speed(void *priv, int speed, unsigned int mode)
 {
 	struct tegra_eqos *eqos = priv;
 	bool needs_calibration = false;
-	long rate = 125000000;
 	u32 value;
 	int err;
 
@@ -161,7 +159,6 @@ static void tegra_eqos_fix_speed(void *priv, int speed, unsigned int mode)
 		fallthrough;
 
 	case SPEED_10:
-		rate = rgmii_clock(speed);
 		break;
 
 	default:
@@ -208,10 +205,6 @@ static void tegra_eqos_fix_speed(void *priv, int speed, unsigned int mode)
 		value &= ~AUTO_CAL_CONFIG_ENABLE;
 		writel(value, eqos->regs + AUTO_CAL_CONFIG);
 	}
-
-	err = clk_set_rate(eqos->clk_tx, rate);
-	if (err < 0)
-		dev_err(eqos->dev, "failed to set TX rate: %d\n", err);
 }
 
 static int tegra_eqos_init(struct platform_device *pdev, void *priv)
@@ -247,7 +240,7 @@ static int tegra_eqos_probe(struct platform_device *pdev,
 	if (!is_of_node(dev->fwnode))
 		goto bypass_clk_reset_gpio;
 
-	eqos->clk_tx = dwc_eth_find_clk(plat_dat, "tx");
+	plat_dat->clk_tx_i = dwc_eth_find_clk(plat_dat, "tx");
 
 	eqos->reset = devm_gpiod_get(&pdev->dev, "phy-reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(eqos->reset)) {
@@ -281,6 +274,7 @@ static int tegra_eqos_probe(struct platform_device *pdev,
 
 bypass_clk_reset_gpio:
 	plat_dat->fix_mac_speed = tegra_eqos_fix_speed;
+	plat_dat->set_clk_tx_rate = stmmac_set_clk_tx_rate;
 	plat_dat->init = tegra_eqos_init;
 	plat_dat->bsp_priv = eqos;
 	plat_dat->flags |= STMMAC_FLAG_SPH_DISABLE;
-- 
2.30.2


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

