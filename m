Return-Path: <netdev+bounces-170169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CC5A478E1
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 10:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768C71890E5D
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 09:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211D7225762;
	Thu, 27 Feb 2025 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PJkQgzSI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B52A22688A
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740647844; cv=none; b=nzXCWXJSuoJ20275FkQBIHmZgQ0OJRQh1W8cilw+IIMcynVNlK3JFv3ti3qjml8XWt5HmfYnNgOD6SxUojM05zEy/BeedCbU8L52OkUK8Vkzzd/DcQAD6UZCf9Vo2tbDdefTXAkxjC7Jyez6zs3MiMhmAEQ0+SEYMf3mOlciP5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740647844; c=relaxed/simple;
	bh=DO3iM1VWm+uB3JVKtzaNPt3s3ewxgUg8hWDzptLJESg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=PA9E5aVmje5cezqh9jifbsY9h8l1h3EvW9pd/Mi9QuSd7OxRESwZIIG2mYipZQIJECcvKK5gNJIcEDvjewYxfSUB8hPu9fFJa1VvYlUuUcRW/VJswWUSeEZRdvt7K21hfl/0tJ5jtCPllShbXoFqOobU4no+0m2pZ0jWabXh0Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PJkQgzSI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/+jnfv4T4k7CTh7+WrQNUNK6eoyhvoxfgqp97EMPQ8g=; b=PJkQgzSIApM+YosfnFFysQpIXi
	246rbKLo/IRljGDTaHaXhM1d6ONggo3ihSiYFXVUct0NoR8RL4s8aUesdXrLTFaoFHXEoR7tDBt59
	xDc33IWpRdHqvAJqB8eVCXTKpQfeDhrZO0ya5D33+Dg+IrAUfbwiD/wMNDD0D/4yiO0TT9niP0Oa+
	CJlbxtxNdOq4nG8aZwYVFyDPZ/rYafS9FI8LFbSL31qQalFFtItcD2MW7s7bCxAurR/8Hu8Xp/d73
	/ypmP89JqkuuJGBtf/lavvs95PZc4ueLojD0FINQvwnMapricEqQVzA2AdkkO0uzQq0FWXOThpnc7
	htiRLAYg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38762 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tna14-0006dC-2R;
	Thu, 27 Feb 2025 09:17:14 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tna0k-0052t2-Cc; Thu, 27 Feb 2025 09:16:54 +0000
In-Reply-To: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
References: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH net-next 07/11] net: stmmac: imx: use generic
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
Message-Id: <E1tna0k-0052t2-Cc@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 27 Feb 2025 09:16:54 +0000

Convert non-i.MX93 users to use the generic stmmac_set_clk_tx_rate() to
configure the MAC transmit clock rate.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 21 +++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 610204b51e3f..5d279fa54b3e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -192,6 +192,19 @@ static void imx_dwmac_exit(struct platform_device *pdev, void *priv)
 	/* nothing to do now */
 }
 
+static int imx_dwmac_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
+				     phy_interface_t interface, int speed)
+{
+	struct imx_priv_data *dwmac = bsp_priv;
+
+	interface = dwmac->plat_dat->mac_interface;
+	if (interface == PHY_INTERFACE_MODE_RMII ||
+	    interface == PHY_INTERFACE_MODE_MII)
+		return 0;
+
+	return stmmac_set_clk_tx_rate(bsp_priv, clk_tx_i, interface, speed);
+}
+
 static void imx_dwmac_fix_speed(void *priv, int speed, unsigned int mode)
 {
 	struct plat_stmmacenet_data *plat_dat;
@@ -358,7 +371,6 @@ static int imx_dwmac_probe(struct platform_device *pdev)
 	plat_dat->init = imx_dwmac_init;
 	plat_dat->exit = imx_dwmac_exit;
 	plat_dat->clks_config = imx_dwmac_clks_config;
-	plat_dat->fix_mac_speed = imx_dwmac_fix_speed;
 	plat_dat->bsp_priv = dwmac;
 	dwmac->plat_dat = plat_dat;
 	dwmac->base_addr = stmmac_res.addr;
@@ -371,8 +383,13 @@ static int imx_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_dwmac_init;
 
-	if (dwmac->ops->fix_mac_speed)
+	if (dwmac->ops->fix_mac_speed) {
 		plat_dat->fix_mac_speed = dwmac->ops->fix_mac_speed;
+	} else if (!dwmac->ops->mac_rgmii_txclk_auto_adj) {
+		plat_dat->clk_tx_i = dwmac->clk_tx;
+		plat_dat->set_clk_tx_rate = imx_dwmac_set_clk_tx_rate;
+	}
+
 	dwmac->plat_dat->fix_soc_reset = dwmac->ops->fix_soc_reset;
 
 	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
-- 
2.30.2


