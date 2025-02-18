Return-Path: <netdev+bounces-167301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A60F5A39A76
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 12:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4968A1721BD
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 11:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873642417E5;
	Tue, 18 Feb 2025 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tgNGnRsz"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C7A241112
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 11:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877334; cv=none; b=WdxaTwZ3/wFB2gAyj5kzSQKp6BPY/6EUi8jKsr++UzhvrgE9n70S/NrEfb7wMYoXlT1K1bndGNzQ07TlVEnBF79+wuWXVecTz4IxjnszDi/vjsqTci5r7FpAg1Noxrdd+s4uBXiXzRr7CImS6BaMfmsLFOpDkZAVzomUrykVMoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877334; c=relaxed/simple;
	bh=ZBbAU6aZYUxx8GiuPh4r3KM1vI1ygzO1mkdIyktcr/k=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=GoA2TYLnIsKc3VtMwu+GQx1is4rj4wLQ8G26QDVuwCMdqvLBEnH081U4k4JHJ7eLWEFuakx5p34uFY9oEPUX8XV9YMpwLOZgSu8cf39LNvBtqI6i6MkVkRepVOz5eOHGtylYxrPhOZb8TmaQFO3FKmOjAu41Hze9T6/ujhVXPO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tgNGnRsz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=z6JrrogbArX3EwFwjiBuFp6vVepOdYswoCOinStaIO8=; b=tgNGnRszu7KRQVhPsRSiPbUQnN
	2jqrw/fF1aEgjDY6+hiFyt5hv9Pea+7JKyP9erfYrpn95M2bx2tHzI/zmKJkZpPXvBt+V9ZENGXdy
	jDO9jdH9KiblQ54w5p3mCP6FjT4TEhMDDRWD2hNjTW7UF+p3RDGiEfHt7rzGzkyzoZeDxmtOemDZZ
	MVdl/XSiGYzjO4be4wgFNuF/lEoc3Drx7X+aKLKJr4EmbYdBOrMNpE+FsMaDa9MDSPjQ5gC+aUZJR
	Jjw5XxKKJxs0Bk/MZv7SuIwVo3Tze5qVq4/OowF7HnslVfOTw42rCNUebXHQOR3bC4NUJydKUzxHc
	P8gMRr0g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51248 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tkLZL-0001j4-1N;
	Tue, 18 Feb 2025 11:15:15 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tkLZ0-004RZH-SL; Tue, 18 Feb 2025 11:14:54 +0000
In-Reply-To: <Z7RrnyER5ewy0f3T@shell.armlinux.org.uk>
References: <Z7RrnyER5ewy0f3T@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev,
	Inochi Amaoto <inochiama@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	netdev@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH RFC net-next 4/7] net: stmmac: starfive: use generic
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
Message-Id: <E1tkLZ0-004RZH-SL@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 18 Feb 2025 11:14:54 +0000

Use the generic stmmac_set_clk_tx_rate() to configure the MAC transmit
clock.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac-starfive.c  | 26 +++----------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
index 282c846dad0b..5e31cb3bb4b8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
@@ -27,27 +27,9 @@ struct starfive_dwmac_data {
 
 struct starfive_dwmac {
 	struct device *dev;
-	struct clk *clk_tx;
 	const struct starfive_dwmac_data *data;
 };
 
-static void starfive_dwmac_fix_mac_speed(void *priv, int speed, unsigned int mode)
-{
-	struct starfive_dwmac *dwmac = priv;
-	long rate;
-	int err;
-
-	rate = rgmii_clock(speed);
-	if (rate < 0) {
-		dev_err(dwmac->dev, "invalid speed %d\n", speed);
-		return;
-	}
-
-	err = clk_set_rate(dwmac->clk_tx, rate);
-	if (err)
-		dev_err(dwmac->dev, "failed to set tx rate %lu\n", rate);
-}
-
 static int starfive_dwmac_set_mode(struct plat_stmmacenet_data *plat_dat)
 {
 	struct starfive_dwmac *dwmac = plat_dat->bsp_priv;
@@ -122,9 +104,9 @@ static int starfive_dwmac_probe(struct platform_device *pdev)
 
 	dwmac->data = device_get_match_data(&pdev->dev);
 
-	dwmac->clk_tx = devm_clk_get_enabled(&pdev->dev, "tx");
-	if (IS_ERR(dwmac->clk_tx))
-		return dev_err_probe(&pdev->dev, PTR_ERR(dwmac->clk_tx),
+	plat_dat->clk_tx_i = devm_clk_get_enabled(&pdev->dev, "tx");
+	if (IS_ERR(plat_dat->clk_tx_i))
+		return dev_err_probe(&pdev->dev, PTR_ERR(plat_dat->clk_tx_i),
 				     "error getting tx clock\n");
 
 	clk_gtx = devm_clk_get_enabled(&pdev->dev, "gtx");
@@ -139,7 +121,7 @@ static int starfive_dwmac_probe(struct platform_device *pdev)
 	 * internally, because rgmii_rxin will be adaptively adjusted.
 	 */
 	if (!device_property_read_bool(&pdev->dev, "starfive,tx-use-rgmii-clk"))
-		plat_dat->fix_mac_speed = starfive_dwmac_fix_mac_speed;
+		plat_dat->set_clk_tx_rate = stmmac_set_clk_tx_rate;
 
 	dwmac->dev = &pdev->dev;
 	plat_dat->bsp_priv = dwmac;
-- 
2.30.2


