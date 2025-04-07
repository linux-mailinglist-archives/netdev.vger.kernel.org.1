Return-Path: <netdev+bounces-179869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F92EA7ECC2
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC6D17CB65
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E860D2222BB;
	Mon,  7 Apr 2025 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="oe0T4ZWd"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05856219A8F
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052373; cv=none; b=dHzBwYYh1V4Xhjm9rAjWW8ewLVpWiDIujRjdK2pEgkXh04GA4Z+pUmpT4wVFGOmSBuM8dvkJ0H6zyD3oriEbTzWfdf+Gyyzi5XS/o3AErMlUWBpZTG42ac+oCSEbqTUFiv/rSBszdQyUsd/sd0RkHCrO8jeZOI76TCsDXUDd8zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052373; c=relaxed/simple;
	bh=1ZT4yIkUI3AA12JoAX1ReogQ69txcRt653+H2xoflmk=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=femew/ler1OyjltEm0tM0lNhIL4x0at+PZwgYD7phA942cL6CkSNNG3/x3QVYwMIHg9TKGsHrAvIiNvj+y1Cpx9igF2IxMNO7bksbo4SJ9sg7p65Og7XVBHZ776lfqQJy+jmUDzLQMS5DcOSTD3OB+RaAwjmtTDXetPjqC0qlY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=oe0T4ZWd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WNdh5DzKkHzYa5BInKwu7W+JyJ1xHiWn4QJkYHQJpjQ=; b=oe0T4ZWdJrQUHI1RLctiKWbMbQ
	jp7LrA30xsy5eMJj75+mY1+PDfwuCESzZsgUqxkkzIFQtCgMWz3lzemH6SMMeBRYEQdlslW5wAgJW
	v4/dH9NbZRlBHGZa+tGq3I1KJhazhmmCix6rDseVCvn7m3k9ZBLtRj+nMj6y7Tak/rPTS3j+c9DfC
	cMZrI6XkQamBGpkfkstrBdDRN/LmElz+gJrLcou6EkTQu6TFnHLPC/RNvh8BJEK+6jmT4cnWoUdXy
	sCGjDDnc1tCDDkQ7h5E2dtxCaDFXWHsbkY2XQSP1LJ0wAbsxxDFSkwt78a+JCLQnQ4VNUCRAsnZsH
	jGdbfzDQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47696 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u1rgp-000697-0g;
	Mon, 07 Apr 2025 19:59:23 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u1rgJ-0013gd-2q; Mon, 07 Apr 2025 19:58:51 +0100
In-Reply-To: <Z_QgOTC1hOSkIdur@shell.armlinux.org.uk>
References: <Z_QgOTC1hOSkIdur@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Richard Cochran <richardcochran@gmail.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH net-next 1/5] net: stmmac: dwc-qos: remove tegra_eqos_init()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u1rgJ-0013gd-2q@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 07 Apr 2025 19:58:51 +0100

tegra_eqos_init() initialises the 1US TIC counter for the EEE timers.
However, the DWGMAC core is reset after this write, which clears
this register to its default.

However, dwmac4_core_init() configures this register using the same
clock, which happens after reset - thus this is the write which
ensures that the register is correctly configured.

Therefore, tegra_eqos_init() is not required and is removed. This also
means eqos->clk_slave can also be removed.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../stmicro/stmmac/dwmac-dwc-qos-eth.c        | 24 +------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index 126702873e2a..2b6ed0f720eb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -29,7 +29,6 @@ struct tegra_eqos {
 	void __iomem *regs;
 
 	struct reset_control *rst;
-	struct clk *clk_slave;
 
 	struct gpio_desc *reset;
 };
@@ -199,20 +198,6 @@ static void tegra_eqos_fix_speed(void *priv, int speed, unsigned int mode)
 	}
 }
 
-static int tegra_eqos_init(struct platform_device *pdev, void *priv)
-{
-	struct tegra_eqos *eqos = priv;
-	unsigned long rate;
-	u32 value;
-
-	rate = clk_get_rate(eqos->clk_slave);
-
-	value = (rate / 1000000) - 1;
-	writel(value, eqos->regs + GMAC_1US_TIC_COUNTER);
-
-	return 0;
-}
-
 static int tegra_eqos_probe(struct platform_device *pdev,
 			    struct plat_stmmacenet_data *plat_dat,
 			    struct stmmac_resources *res)
@@ -227,7 +212,6 @@ static int tegra_eqos_probe(struct platform_device *pdev,
 
 	eqos->dev = &pdev->dev;
 	eqos->regs = res->addr;
-	eqos->clk_slave = plat_dat->stmmac_clk;
 
 	if (!is_of_node(dev->fwnode))
 		goto bypass_clk_reset_gpio;
@@ -267,18 +251,12 @@ static int tegra_eqos_probe(struct platform_device *pdev,
 bypass_clk_reset_gpio:
 	plat_dat->fix_mac_speed = tegra_eqos_fix_speed;
 	plat_dat->set_clk_tx_rate = stmmac_set_clk_tx_rate;
-	plat_dat->init = tegra_eqos_init;
 	plat_dat->bsp_priv = eqos;
 	plat_dat->flags |= STMMAC_FLAG_SPH_DISABLE |
 			   STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP;
 
-	err = tegra_eqos_init(pdev, eqos);
-	if (err < 0)
-		goto reset;
-
 	return 0;
-reset:
-	reset_control_assert(eqos->rst);
+
 reset_phy:
 	gpiod_set_value(eqos->reset, 1);
 
-- 
2.30.2


