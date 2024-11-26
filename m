Return-Path: <netdev+bounces-147438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC619D97B5
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 13:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 913B7B273BE
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 12:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7401D4354;
	Tue, 26 Nov 2024 12:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YwtySm9u"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6E21D4324
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732625661; cv=none; b=nPRV+aMt/9znKDg9EpTZEADG30JcmFH+oq+W0JD6y51mO8rqcQEyc7bpEWbRwozQKpj9Ia+uS5IXb4lokumlOv0+Av9eGIizZCflAP4hrpvHY81qKFrDvyCL9kzJSv4Yte50EuS8FbP5b4zL+0JmKT4KB9SuxpJzGCWUsXT3hKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732625661; c=relaxed/simple;
	bh=3AtldjBJQAk8xIR6jbDNwhIHcUoO7VJjz4GSZunka+Q=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=MMeX3/q0jifWGmXvv2ib8GMP1jQpDyhCf1/VgXN0uSMxloINGXIGAShbJS1Iv3YcbIVK+dR19SPX/sCoNrXulMj53pK1b0lYfhDJ6YE1l4n9EGNNINsQFvQ9bvBQrZJxzRIXp24+1mWY0OPfYm7tES3HQcm+Tx5I1Yws9wymTDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YwtySm9u; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=p5iam8LcLfiWFg9yqlxfwUNcEh+T0vPbo6e8JFWKInY=; b=YwtySm9ulAC86bOSqPk+qRTfeF
	zs4q/6kYpd4y/tKnAJNZDJgaKNkRPnEi/Rdfd8DTPAR2uPGblFfwOHEzI2bdzyqhCUa30K0L9qAJN
	5X4kJ5KXOJehIxLrLfhR/mZ0A9dbAizF9NFItuC6FLlxl34Xg5x+0L0Ai7wsvBRMokAeG0pJWpt3C
	DCMfsMykovDdEDXmtz4QDZGiHZ+tFEy0gSihPa+nsYToh1hjEd+ZNnjvqpGWGD3fjxv4sn1yoFM3G
	Axhx/tQ3qnIgbIYJCOkuMn61MnZGBKtyVYoVKGj33n6IWzwfM9yGs8GeUK/GQVi8abEx5U2H2sxto
	ujXbBYvA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56802 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tFv4z-0006yx-2y;
	Tue, 26 Nov 2024 12:54:10 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tFv4y-005yjc-MG; Tue, 26 Nov 2024 12:54:08 +0000
In-Reply-To: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
References: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com
Subject: [PATCH RFC net-next 23/23] net: stmmac: convert to phylink managed
 EEE support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tFv4y-005yjc-MG@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 26 Nov 2024 12:54:08 +0000

Convert stmmac to use phylink managed EEE support rather than delving
into phylib.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 50 +++++++++++++++----
 1 file changed, 39 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 66a43a9aa469..39a4f0da82e5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -973,9 +973,6 @@ static void stmmac_mac_link_down(struct phylink_config *config,
 	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
 
 	stmmac_mac_set(priv, priv->ioaddr, false);
-	priv->eee_active = false;
-	priv->eee_enabled = stmmac_eee_init(priv);
-	stmmac_set_eee_pls(priv, priv->hw, false);
 
 	if (stmmac_fpe_supported(priv))
 		stmmac_fpe_link_state_handle(priv, false);
@@ -1082,14 +1079,6 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 		writel(ctrl, priv->ioaddr + MAC_CTRL_REG);
 
 	stmmac_mac_set(priv, priv->ioaddr, true);
-	if (phy && priv->dma_cap.eee) {
-		phy_eee_rx_clock_stop(phy, !(priv->plat->flags &
-					     STMMAC_FLAG_RX_CLK_RUNS_IN_LPI));
-		priv->eee_active = phy->enable_tx_lpi;
-		priv->eee_enabled = stmmac_eee_init(priv);
-		priv->tx_lpi_timer = phy->eee_cfg.tx_lpi_timer;
-		stmmac_set_eee_pls(priv, priv->hw, true);
-	}
 
 	if (stmmac_fpe_supported(priv))
 		stmmac_fpe_link_state_handle(priv, true);
@@ -1098,12 +1087,34 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 		stmmac_hwtstamp_correct_latency(priv, priv);
 }
 
+static void stmmac_mac_disable_tx_lpi(struct phylink_config *config)
+{
+	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
+
+	priv->eee_active = false;
+	priv->eee_enabled = stmmac_eee_init(priv);
+	stmmac_set_eee_pls(priv, priv->hw, false);
+}
+
+static void stmmac_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
+				     bool tx_clk_stop)
+{
+	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
+
+	priv->eee_active = true;
+	priv->eee_enabled = stmmac_eee_init(priv);
+	priv->tx_lpi_timer = timer;
+	stmmac_set_eee_pls(priv, priv->hw, true);
+}
+
 static const struct phylink_mac_ops stmmac_phylink_mac_ops = {
 	.mac_get_caps = stmmac_mac_get_caps,
 	.mac_select_pcs = stmmac_mac_select_pcs,
 	.mac_config = stmmac_mac_config,
 	.mac_link_down = stmmac_mac_link_down,
 	.mac_link_up = stmmac_mac_link_up,
+	.mac_disable_tx_lpi = stmmac_mac_disable_tx_lpi,
+	.mac_mac_enable_tx_lpi = stmmac_mac_enable_tx_lpi,
 };
 
 /**
@@ -1216,6 +1227,18 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 	/* Stmmac always requires an RX clock for hardware initialization */
 	priv->phylink_config.mac_requires_rxc = true;
 
+	if (!(priv->plat->flags & STMMAC_FLAG_RX_CLK_RUNS_IN_LPI))
+		priv->phylink_config.eee_rx_clk_stop_enable = true;
+
+	if (priv->dma_cap.eee) {
+		/* All full duplex speeds above 100Mbps are supported */
+		priv->phylink_config.lpi_capabilities = ~(MAC_1000FD - 1) |
+							MAC_100FD;
+		priv->phylink_config.lpi_timer_limit_us = U32_MAX;
+		priv->phylink_config.lpi_timer_default = eee_timer * 1000;
+		priv->phylink_config.eee_enabled_default = false;
+	}
+
 	mdio_bus_data = priv->plat->mdio_bus_data;
 	if (mdio_bus_data)
 		priv->phylink_config.default_an_inband =
@@ -1231,6 +1254,11 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 		xpcs_get_interfaces(priv->hw->xpcs,
 				    priv->phylink_config.supported_interfaces);
 
+	/* Assume all supported interfaces also support LPI */
+	memcpy(priv->phylink_config.lpi_interfaces,
+	       priv->phylink_config.supported_interfaces,
+	       sizeof(priv->phylink_config.lpi_interfaces));
+
 	fwnode = priv->plat->port_node;
 	if (!fwnode)
 		fwnode = dev_fwnode(priv->device);
-- 
2.30.2


