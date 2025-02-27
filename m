Return-Path: <netdev+bounces-170165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FD9A478D4
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 10:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26705188FCED
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 09:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8BE21505D;
	Thu, 27 Feb 2025 09:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gcv3fyOq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9961224224
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 09:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740647823; cv=none; b=dJrQXfTEbnZgQoXhMAZAldtJoS9mO+4fHS4eW/sLichIY88DbMKoeSMGq38C6/33j78772ZALldBntkIz8ZX4pidZetBXH0mfMLgQpDOxFwGghuR3t+gJk1PhPLzuv8Jd/Am+l7tgRvZ3EQ6BEWVKNyXlkRGD8eQohFcu7zCOWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740647823; c=relaxed/simple;
	bh=o8Jp3Ln5qHEY5AgbO75OumKS5QRPqqHPsSCjo9len4E=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Hj5+uV6TUtuvx98oghSsI6BTnANdrVNEI5eQPhIRFfhsI8umQ2Y1Y0cQEIxOKSaCG9bdLD9fchFY/FXeZOgilfQBqcniNRc1VaXn0TO/GpLY6g4HzkivkDvNcbsMGXC9X6fkK+IUE7K+T2j9h92cCTvtSxLrL+2mVuBLcuL8Wvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gcv3fyOq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I4Yn1aCx9+lFH2Cf47CL+ZxUVEUt0vYQ0JkUjLrLdvs=; b=gcv3fyOqLZQvldcNiY7pe7oKas
	L5zmrrGFa2zJ6FvZRsJXkAFRvbPcwULJQMna4x0GwPVFZn4Aa15JJLkyByuGgUKQxP5mYi1f0U92/
	++mF84jHN4+jDsbC+wZhi4kdAPV8WdPcsCp5igbJ3kInT1S6E8xU0IcIXhZV+SlcqZoiAhYB2T/0o
	NLvEeoJfQQ5nFIMAmr6Z1x1CbXk4vEN5YyX5JjiHeVyCam9Q9mc2firclOQlZGjOmlmDOg2eR7uny
	m51uOu1Os5I1vYsUAbjFsryxFpMfoo191JZ0wALLoqn92YYTz6QQE4/mdoweLmDRQylGuM0SxGEq6
	HqHTtyrw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41902 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tna0k-0006c3-02;
	Thu, 27 Feb 2025 09:16:54 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tna0P-0052se-Tv; Thu, 27 Feb 2025 09:16:33 +0000
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
Subject: [PATCH net-next 03/11] net: stmmac: dwc-qos: use generic
 stmmac_set_clk_tx_rate()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tna0P-0052se-Tv@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 27 Feb 2025 09:16:33 +0000

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


