Return-Path: <netdev+bounces-87445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460BE8A322D
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 17:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90819B26734
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E306A1494A3;
	Fri, 12 Apr 2024 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Cm2nI0H6"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159FE149E1D
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934931; cv=none; b=dvCWZFoRNbzsxvm4SuuVtua97ZYpq3XmFBjh98j5AautHnG8n41ACiOTtQWpGGwyCKFCOkn5eBwAg2f1b1PNh+8mzNMiUMuFrpXsOBn38EgiC/TYT3HyD03l9mdC7ytdpillnc0v8NaSEohzecYk9KN/gdSEp4qlhFCgqCjOx70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934931; c=relaxed/simple;
	bh=oRaNEvIxSCZf001rgavKneo4e/YGSEwfr+ViwuTTP6s=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=JAP1G1HrdhHIsoVftiiX7SSbjxV9mTI1Bk/K2RypBIZZh8a3ANveE8ujAp4zauR/b01XH09APZUNPLml5129KG82JB5xG8lunEgAhXz90FPIbZMtX1BkeTZbzu+Dn++K9xO+Imt9oKpUYUHYLF85cWKWJlw/xuN4KYOJp4FozUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Cm2nI0H6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DzPzEcRUKIY2JLlw5Svz+Agh7qOizmCq3g8kxHRBShc=; b=Cm2nI0H6jV9TCJ9JYw46ZIocAV
	iuUa9JvMuD6/xP5EAkvzgyiQ+4JUgx+b3CmupAh3k+emA8sg/j5vxxZJr9ph6HgHXLLHK9/sSoi3x
	3MaZDpfxAA4JqfkRrLEM2x7yRni+d+WrWFL/Mchuzp39liUxfx/A70A24rNWEOoMH0hvit+iHCwQN
	uLyzYqzSpGP8rZ8QtV3RH8Iro5knMIb0jq+T6jnbdRvJI2FKWuyICMVO+RDheyOLk/byDokGKSPKC
	9FsVaARm4jj/KFpEwM+Kg1Dga1r0aILgYwXdJAFmyd2MWy5RWntwqlLt/DJrl7zcFUsdIzuc9UzqR
	qTrcbSlw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37326 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rvIcd-0002cZ-17;
	Fri, 12 Apr 2024 16:15:23 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rvIce-006bQi-58; Fri, 12 Apr 2024 16:15:24 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	 Vladimir Oltean <olteanv@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: dsa: qca8k: provide own phylink MAC operations
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rvIce-006bQi-58@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 12 Apr 2024 16:15:24 +0100

Convert qca8k to provide its own phylink MAC operations, thus
avoiding the shim layer in DSA's port.c.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 49 +++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index dab66c0c6f64..b3c27cf538e8 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1283,11 +1283,13 @@ qca8k_mac_config_setup_internal_delay(struct qca8k_priv *priv, int cpu_port_inde
 }
 
 static struct phylink_pcs *
-qca8k_phylink_mac_select_pcs(struct dsa_switch *ds, int port,
+qca8k_phylink_mac_select_pcs(struct phylink_config *config,
 			     phy_interface_t interface)
 {
-	struct qca8k_priv *priv = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct qca8k_priv *priv = dp->ds->priv;
 	struct phylink_pcs *pcs = NULL;
+	int port = dp->index;
 
 	switch (interface) {
 	case PHY_INTERFACE_MODE_SGMII:
@@ -1311,13 +1313,18 @@ qca8k_phylink_mac_select_pcs(struct dsa_switch *ds, int port,
 }
 
 static void
-qca8k_phylink_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
+qca8k_phylink_mac_config(struct phylink_config *config, unsigned int mode,
 			 const struct phylink_link_state *state)
 {
-	struct qca8k_priv *priv = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct dsa_switch *ds = dp->ds;
+	struct qca8k_priv *priv;
+	int port = dp->index;
 	int cpu_port_index;
 	u32 reg;
 
+	priv = ds->priv;
+
 	switch (port) {
 	case 0: /* 1st CPU port */
 		if (state->interface != PHY_INTERFACE_MODE_RGMII &&
@@ -1426,20 +1433,24 @@ static void qca8k_phylink_get_caps(struct dsa_switch *ds, int port,
 }
 
 static void
-qca8k_phylink_mac_link_down(struct dsa_switch *ds, int port, unsigned int mode,
+qca8k_phylink_mac_link_down(struct phylink_config *config, unsigned int mode,
 			    phy_interface_t interface)
 {
-	struct qca8k_priv *priv = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct qca8k_priv *priv = dp->ds->priv;
 
-	qca8k_port_set_status(priv, port, 0);
+	qca8k_port_set_status(priv, dp->index, 0);
 }
 
 static void
-qca8k_phylink_mac_link_up(struct dsa_switch *ds, int port, unsigned int mode,
-			  phy_interface_t interface, struct phy_device *phydev,
-			  int speed, int duplex, bool tx_pause, bool rx_pause)
+qca8k_phylink_mac_link_up(struct phylink_config *config,
+			  struct phy_device *phydev, unsigned int mode,
+			  phy_interface_t interface, int speed, int duplex,
+			  bool tx_pause, bool rx_pause)
 {
-	struct qca8k_priv *priv = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct qca8k_priv *priv = dp->ds->priv;
+	int port = dp->index;
 	u32 reg;
 
 	if (phylink_autoneg_inband(mode)) {
@@ -1463,10 +1474,10 @@ qca8k_phylink_mac_link_up(struct dsa_switch *ds, int port, unsigned int mode,
 		if (duplex == DUPLEX_FULL)
 			reg |= QCA8K_PORT_STATUS_DUPLEX;
 
-		if (rx_pause || dsa_is_cpu_port(ds, port))
+		if (rx_pause || dsa_port_is_cpu(dp))
 			reg |= QCA8K_PORT_STATUS_RXFLOW;
 
-		if (tx_pause || dsa_is_cpu_port(ds, port))
+		if (tx_pause || dsa_port_is_cpu(dp))
 			reg |= QCA8K_PORT_STATUS_TXFLOW;
 	}
 
@@ -1991,6 +2002,13 @@ qca8k_setup(struct dsa_switch *ds)
 	return 0;
 }
 
+static const struct phylink_mac_ops qca8k_phylink_mac_ops = {
+	.mac_select_pcs	= qca8k_phylink_mac_select_pcs,
+	.mac_config	= qca8k_phylink_mac_config,
+	.mac_link_down	= qca8k_phylink_mac_link_down,
+	.mac_link_up	= qca8k_phylink_mac_link_up,
+};
+
 static const struct dsa_switch_ops qca8k_switch_ops = {
 	.get_tag_protocol	= qca8k_get_tag_protocol,
 	.setup			= qca8k_setup,
@@ -2021,10 +2039,6 @@ static const struct dsa_switch_ops qca8k_switch_ops = {
 	.port_vlan_add		= qca8k_port_vlan_add,
 	.port_vlan_del		= qca8k_port_vlan_del,
 	.phylink_get_caps	= qca8k_phylink_get_caps,
-	.phylink_mac_select_pcs	= qca8k_phylink_mac_select_pcs,
-	.phylink_mac_config	= qca8k_phylink_mac_config,
-	.phylink_mac_link_down	= qca8k_phylink_mac_link_down,
-	.phylink_mac_link_up	= qca8k_phylink_mac_link_up,
 	.get_phy_flags		= qca8k_get_phy_flags,
 	.port_lag_join		= qca8k_port_lag_join,
 	.port_lag_leave		= qca8k_port_lag_leave,
@@ -2091,6 +2105,7 @@ qca8k_sw_probe(struct mdio_device *mdiodev)
 	priv->ds->num_ports = QCA8K_NUM_PORTS;
 	priv->ds->priv = priv;
 	priv->ds->ops = &qca8k_switch_ops;
+	priv->ds->phylink_mac_ops = &qca8k_phylink_mac_ops;
 	mutex_init(&priv->reg_mutex);
 	dev_set_drvdata(&mdiodev->dev, priv);
 
-- 
2.30.2


