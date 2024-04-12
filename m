Return-Path: <netdev+bounces-87446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2BD8A322E
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 17:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA3B1F255AA
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B4714A099;
	Fri, 12 Apr 2024 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="K4QrdBfp"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FEA149E1D
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934942; cv=none; b=Hvg9CO0Q4thRqbEo8NWbplJxnU0SVm7qyTFF+HTpt2JTgYUGDHuSrK0lfMdutsp+swm0Yaa9R75AVth2ptP0+5AExOqm+JOFHAy1Xfb6I2/COuT8zCW1MznU9+fpUsv3ElUF4OSgQtdbN1Ji9NRGMvKLwEY+Sxfp0Y/edXf4mlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934942; c=relaxed/simple;
	bh=7mtZcba69f0gxm/j+yiKuBa0E7YWSECjAwSU5ZiUDjQ=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=j63Qm0/a+p2mQjCjJdzwZGXi9DAUoOZinoFvGH/9NUaEgyVoQhgOqZ8rFdS4M/F9JJ+C/btDkhUmgAOxsSYtwM9REErNqMET+i0ktE45GfLGsJTDxSaV4VKbE/oX+8ByFb5SPSAB9eW4JEN5FJuoKbX5NgfsG1CbQO6dt13mIFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=K4QrdBfp; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=s0Xom6IgkHqkDH8Z7yAuNhLFyzIUYw8tL1Oy3OefGY0=; b=K4QrdBfp4u/JLXLrCj+fXvB5Sj
	ceVVOztKCmCdJ+eii05wSnt9HaLkjsfx6MYh3ZFKk4YGcXRjEParXkb4vAB6Xlu8X6REkDCWub39t
	bWzf+vluF2q98FMDgOWZP7UbFQfBK4QjzHFLvM1b72aHqvlEsS4y4RQ1OfbxgVJLUh2rMqeK0qaT4
	6jGIPhEEzE6WmXAY0ASb/eebfXZisjHQpcIu0v1qKNMlkyiUe1HFqLg+N2vufqGJyy5Hf/+bJrytY
	E7uwDBVNAwL1cLiN8SjWTNvzioDqHC5+pr2p5xoVK35NRe+pV0I+escSf5T1Rd/q680SqAvU5LE7L
	RPdf70cw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37340 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rvIci-0002cl-27;
	Fri, 12 Apr 2024 16:15:28 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rvIcj-006bQo-B3; Fri, 12 Apr 2024 16:15:29 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	 Vladimir Oltean <olteanv@gmail.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: dsa: lantiq_gswip: provide own phylink MAC
 operations
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rvIcj-006bQo-B3@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 12 Apr 2024 16:15:29 +0100

Convert lantiq_gswip to provide its own phylink MAC operations, thus
avoiding the shim layer in DSA's port.c. For lantiq_gswip, it means
we end up with a common instance of phylink MAC operations that are
shared between the different variants, rather than having duplicated
initialisers in dsa_switch_ops.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/lantiq_gswip.c | 39 ++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index de48b194048f..a557049e34f5 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -1670,11 +1670,13 @@ static void gswip_port_set_pause(struct gswip_priv *priv, int port,
 			mdio_phy, GSWIP_MDIO_PHYp(port));
 }
 
-static void gswip_phylink_mac_config(struct dsa_switch *ds, int port,
+static void gswip_phylink_mac_config(struct phylink_config *config,
 				     unsigned int mode,
 				     const struct phylink_link_state *state)
 {
-	struct gswip_priv *priv = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct gswip_priv *priv = dp->ds->priv;
+	int port = dp->index;
 	u32 miicfg = 0;
 
 	miicfg |= GSWIP_MII_CFG_LDCLKDIS;
@@ -1700,7 +1702,7 @@ static void gswip_phylink_mac_config(struct dsa_switch *ds, int port,
 		miicfg |= GSWIP_MII_CFG_MODE_GMII;
 		break;
 	default:
-		dev_err(ds->dev,
+		dev_err(dp->ds->dev,
 			"Unsupported interface: %d\n", state->interface);
 		return;
 	}
@@ -1726,28 +1728,32 @@ static void gswip_phylink_mac_config(struct dsa_switch *ds, int port,
 	}
 }
 
-static void gswip_phylink_mac_link_down(struct dsa_switch *ds, int port,
+static void gswip_phylink_mac_link_down(struct phylink_config *config,
 					unsigned int mode,
 					phy_interface_t interface)
 {
-	struct gswip_priv *priv = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct gswip_priv *priv = dp->ds->priv;
+	int port = dp->index;
 
 	gswip_mii_mask_cfg(priv, GSWIP_MII_CFG_EN, 0, port);
 
-	if (!dsa_is_cpu_port(ds, port))
+	if (!dsa_port_is_cpu(dp))
 		gswip_port_set_link(priv, port, false);
 }
 
-static void gswip_phylink_mac_link_up(struct dsa_switch *ds, int port,
+static void gswip_phylink_mac_link_up(struct phylink_config *config,
+				      struct phy_device *phydev,
 				      unsigned int mode,
 				      phy_interface_t interface,
-				      struct phy_device *phydev,
 				      int speed, int duplex,
 				      bool tx_pause, bool rx_pause)
 {
-	struct gswip_priv *priv = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct gswip_priv *priv = dp->ds->priv;
+	int port = dp->index;
 
-	if (!dsa_is_cpu_port(ds, port)) {
+	if (!dsa_port_is_cpu(dp)) {
 		gswip_port_set_link(priv, port, true);
 		gswip_port_set_speed(priv, port, speed, interface);
 		gswip_port_set_duplex(priv, port, duplex);
@@ -1824,6 +1830,12 @@ static int gswip_get_sset_count(struct dsa_switch *ds, int port, int sset)
 	return ARRAY_SIZE(gswip_rmon_cnt);
 }
 
+static const struct phylink_mac_ops gswip_phylink_mac_ops = {
+	.mac_config	= gswip_phylink_mac_config,
+	.mac_link_down	= gswip_phylink_mac_link_down,
+	.mac_link_up	= gswip_phylink_mac_link_up,
+};
+
 static const struct dsa_switch_ops gswip_xrx200_switch_ops = {
 	.get_tag_protocol	= gswip_get_tag_protocol,
 	.setup			= gswip_setup,
@@ -1842,9 +1854,6 @@ static const struct dsa_switch_ops gswip_xrx200_switch_ops = {
 	.port_change_mtu	= gswip_port_change_mtu,
 	.port_max_mtu		= gswip_port_max_mtu,
 	.phylink_get_caps	= gswip_xrx200_phylink_get_caps,
-	.phylink_mac_config	= gswip_phylink_mac_config,
-	.phylink_mac_link_down	= gswip_phylink_mac_link_down,
-	.phylink_mac_link_up	= gswip_phylink_mac_link_up,
 	.get_strings		= gswip_get_strings,
 	.get_ethtool_stats	= gswip_get_ethtool_stats,
 	.get_sset_count		= gswip_get_sset_count,
@@ -1868,9 +1877,6 @@ static const struct dsa_switch_ops gswip_xrx300_switch_ops = {
 	.port_change_mtu	= gswip_port_change_mtu,
 	.port_max_mtu		= gswip_port_max_mtu,
 	.phylink_get_caps	= gswip_xrx300_phylink_get_caps,
-	.phylink_mac_config	= gswip_phylink_mac_config,
-	.phylink_mac_link_down	= gswip_phylink_mac_link_down,
-	.phylink_mac_link_up	= gswip_phylink_mac_link_up,
 	.get_strings		= gswip_get_strings,
 	.get_ethtool_stats	= gswip_get_ethtool_stats,
 	.get_sset_count		= gswip_get_sset_count,
@@ -2136,6 +2142,7 @@ static int gswip_probe(struct platform_device *pdev)
 	priv->ds->num_ports = priv->hw_info->max_ports;
 	priv->ds->priv = priv;
 	priv->ds->ops = priv->hw_info->ops;
+	priv->ds->phylink_mac_ops = &gswip_phylink_mac_ops;
 	priv->dev = dev;
 	mutex_init(&priv->pce_table_lock);
 	version = gswip_switch_r(priv, GSWIP_VERSION);
-- 
2.30.2


