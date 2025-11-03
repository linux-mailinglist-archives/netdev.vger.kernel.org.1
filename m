Return-Path: <netdev+bounces-235045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06384C2B887
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 12:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3763B5A6E
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 11:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCD83043C7;
	Mon,  3 Nov 2025 11:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TC9hV9eM"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63030303C8E
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170635; cv=none; b=nwE5fkWPpTF+JoJpsj2S704arLQidvl9pNDrwpuI9f9SN7EojwvF5eGvAqcEkJ4U1H9pyZIasr/xanwH2SowGGAkEiAdNHjY33BOgSLQ1zE6X8eOMlj9gsXqiWd1xyDgyZW3b00/3VjXcMAqOAZZry9azk9RqNyBecUppf0yXUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170635; c=relaxed/simple;
	bh=piBiGfvLfvgOg2VqcE8eWAVTyoC0AEiQan1ShMS51r8=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=kN0YbLRgHBxaVBRbJJZ10cNFPa7dcXCzF0zj77uwGLGqYQYFfzopvAgXwfohfk5M/AFDXf9PSnK1aZuU9CVbhPujZTK42xtm0VfQHk1Za0vrzyqinmmd+/yTN9g01g51iatf+Fx3G1/Xhlo4VABTCJVP3phYFjeCnj6KuCEXslk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=TC9hV9eM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5/4C2L52WRh19L+GKh1oHdRlYYwj06G7xm70H4ADUe8=; b=TC9hV9eMJtJD5oJY+VKJfggX1V
	WGpMoM9GZsJL65Oiq1pfSbJlfuaN+6pb+HE0F8v2Ge+YSbobAwmg4iO2C/ktrRLJwXRYk70v0L+Gx
	E/ySypW9ThqEWwgUz0nKCtqJ3nzcJdUveCGfFik1B+asPeKxEVtV/YW0VDmbFRUxXht1pMELVjDoJ
	UhcfqO6mxHjgPUpbA6P/MsVyY4Abiiez0WXdJRjP6lY20bi3ybs32g+5H8AsGnaHfXjbBW5QHP0y4
	Z00VWHKagpd8gS0RYCRJvAvJB6vt+QC0Ka3w05/2e+z/DUVwyELGhBOTRbjGA/XWXZ1ndXa/9XHzI
	/3pwL7oQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56288 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vFt4k-000000000gU-1tMn;
	Mon, 03 Nov 2025 11:50:18 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vFt4h-0000000Chos-3wxX;
	Mon, 03 Nov 2025 11:50:15 +0000
In-Reply-To: <aQiWzyrXU_2hGJ4j@shell.armlinux.org.uk>
References: <aQiWzyrXU_2hGJ4j@shell.armlinux.org.uk>
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
	Jan Petrous <jan.petrous@oss.nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	s32@nxp.com,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH net-next 05/11] net: stmmac: add support for configuring the
 phy_intf_sel inputs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vFt4h-0000000Chos-3wxX@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 03 Nov 2025 11:50:15 +0000

When dwmac is synthesised with support for multiple PHY interfaces, the
core provides phy_intf_sel inputs, sampled on reset, to configure the
PHY facing interface. Use stmmac_get_phy_intf_sel() in core code to
determine the dwmac phy_intf_sel input value, and provide a new
platform method called with this value just before we issue a soft
reset to the dwmac core.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 34 +++++++++++++++++++
 include/linux/stmmac.h                        |  1 +
 2 files changed, 35 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 95d2cd020a0c..596995d2bec3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3102,6 +3102,36 @@ int stmmac_get_phy_intf_sel(phy_interface_t interface)
 }
 EXPORT_SYMBOL_GPL(stmmac_get_phy_intf_sel);
 
+static int stmmac_prereset_configure(struct stmmac_priv *priv)
+{
+	struct plat_stmmacenet_data *plat_dat = priv->plat;
+	phy_interface_t interface;
+	int phy_intf_sel, ret;
+
+	if (!plat_dat->set_phy_intf_sel)
+		return 0;
+
+	interface = plat_dat->phy_interface;
+	phy_intf_sel = stmmac_get_phy_intf_sel(interface);
+	if (phy_intf_sel < 0) {
+		netdev_err(priv->dev,
+			   "failed to get phy_intf_sel for %s: %pe\n",
+			   phy_modes(interface), ERR_PTR(phy_intf_sel));
+		return phy_intf_sel;
+	}
+
+	ret = plat_dat->set_phy_intf_sel(plat_dat->bsp_priv, phy_intf_sel);
+	if (ret == -EINVAL)
+		netdev_err(priv->dev, "platform does not support %s\n",
+			   phy_modes(interface));
+	else if (ret < 0)
+		netdev_err(priv->dev,
+			   "platform failed to set interface %s: %pe\n",
+			   phy_modes(interface), ERR_PTR(ret));
+
+	return ret;
+}
+
 /**
  * stmmac_init_dma_engine - DMA init.
  * @priv: driver private structure
@@ -3128,6 +3158,10 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
 	if (priv->extend_desc && (priv->mode == STMMAC_RING_MODE))
 		priv->plat->dma_cfg->atds = 1;
 
+	ret = stmmac_prereset_configure(priv);
+	if (ret)
+		return ret;
+
 	ret = stmmac_reset(priv, priv->ioaddr);
 	if (ret) {
 		netdev_err(priv->dev, "Failed to reset the dma\n");
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 151c81c560c8..48e9f1d4e17e 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -250,6 +250,7 @@ struct plat_stmmacenet_data {
 	struct stmmac_txq_cfg tx_queues_cfg[MTL_MAX_TX_QUEUES];
 	void (*get_interfaces)(struct stmmac_priv *priv, void *bsp_priv,
 			       unsigned long *interfaces);
+	int (*set_phy_intf_sel)(void *priv, u8 phy_intf_sel);
 	int (*set_clk_tx_rate)(void *priv, struct clk *clk_tx_i,
 			       phy_interface_t interface, int speed);
 	void (*fix_mac_speed)(void *priv, int speed, unsigned int mode);
-- 
2.47.3


