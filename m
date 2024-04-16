Return-Path: <netdev+bounces-88263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 029958A6824
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 12:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B0DFB21330
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 10:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C037127B47;
	Tue, 16 Apr 2024 10:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nv6k+Hld"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9AB85624
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 10:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262759; cv=none; b=F2GSWnZ2V/xGmnPsX+A7FrllTvXjgPzKEmIoCxAxyLUbRin8T5uSFITgzw1QYp6H0OQOtzdadvQF66I7UvDqlzZpA5EFJ8CXTNOzmZsnX5hbs+mxEgb7rxFrUUrPFR+jZGHuI9T5Oro/QnNYSzXBZMCBuyrqxx7vyB8VXgdcuf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262759; c=relaxed/simple;
	bh=vOOgRjB5ucQRBKkiEgHT3tjRpOOSoLw/siD9KpSh1gI=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=nK8k9LQQoKFkR9x9b+KpaAqBsRsSoaWVAzFcm/d6SmNUDSEdCPkJ9+KTwpj1xNaPUWrj9Gk96ITOcGDfDDiDBXS60z0aP25nzNPkD0s76ITKXCGgpdVMuhyV58TA/h+46xHtW5Ydl6SKhLhjBrt7MCBUfpEstcG1jMQPw06PGWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nv6k+Hld; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0sRRUzi1xc9cir3LWNBUZGX5SNC1LWl11WajyicP5BY=; b=nv6k+HldwbZV3rheuNwLdVov89
	6hqYp569ZqXHngs+GTepi7SkhFmJ7J+Q+87lVH0RnVMmRdUL/4PD+/W0nGyQjgPcmuVRvtVTpHR2o
	Oe0INMf79GZh3mS+YN8ETNXwvxhCdr5XWFMTZ4Q67n2WZ9qhnpURvBfh7K3ixEpV2bWMAfw4BP/PN
	7tcsdZ1g1ghb20Cnr1wQErq13c4CjdivBR3X0vJp4fg+hmhGVxZxKO11Y1aWN0oZ/W8AcOpd5SLSg
	xllR1xP+pMJPpV5iFu8cW0TgqMhJ5tTuGTxyIcqvy7r1+BeiNNW38xCf3k1RnwtMiN2oMzn7dAZHX
	EBmjATvw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:49960 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rwfu2-0008Pi-2W;
	Tue, 16 Apr 2024 11:19:02 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rwfu3-00752s-On; Tue, 16 Apr 2024 11:19:03 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	 Vladimir Oltean <olteanv@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: dsa: bcm_sf2: provide own phylink MAC
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
Message-Id: <E1rwfu3-00752s-On@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 16 Apr 2024 11:19:03 +0100

Convert bcm_sf2 to provide its own phylink MAC operations, thus
avoiding the shim layer in DSA's port.c

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/bcm_sf2.c | 49 +++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index bc77ee9e6d0a..ed1e6560df25 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -740,16 +740,19 @@ static void bcm_sf2_sw_get_caps(struct dsa_switch *ds, int port,
 		MAC_10 | MAC_100 | MAC_1000;
 }
 
-static void bcm_sf2_sw_mac_config(struct dsa_switch *ds, int port,
+static void bcm_sf2_sw_mac_config(struct phylink_config *config,
 				  unsigned int mode,
 				  const struct phylink_link_state *state)
 {
-	struct bcm_sf2_priv *priv = bcm_sf2_to_priv(ds);
+	struct dsa_port *dp = dsa_phylink_to_port(config);
 	u32 id_mode_dis = 0, port_mode;
+	struct bcm_sf2_priv *priv;
 	u32 reg_rgmii_ctrl;
 	u32 reg;
 
-	if (port == core_readl(priv, CORE_IMP0_PRT_ID))
+	priv = bcm_sf2_to_priv(dp->ds);
+
+	if (dp->index == core_readl(priv, CORE_IMP0_PRT_ID))
 		return;
 
 	switch (state->interface) {
@@ -770,7 +773,7 @@ static void bcm_sf2_sw_mac_config(struct dsa_switch *ds, int port,
 		return;
 	}
 
-	reg_rgmii_ctrl = bcm_sf2_reg_rgmii_cntrl(priv, port);
+	reg_rgmii_ctrl = bcm_sf2_reg_rgmii_cntrl(priv, dp->index);
 
 	/* Clear id_mode_dis bit, and the existing port mode, let
 	 * RGMII_MODE_EN bet set by mac_link_{up,down}
@@ -809,13 +812,16 @@ static void bcm_sf2_sw_mac_link_set(struct dsa_switch *ds, int port,
 	reg_writel(priv, reg, reg_rgmii_ctrl);
 }
 
-static void bcm_sf2_sw_mac_link_down(struct dsa_switch *ds, int port,
+static void bcm_sf2_sw_mac_link_down(struct phylink_config *config,
 				     unsigned int mode,
 				     phy_interface_t interface)
 {
-	struct bcm_sf2_priv *priv = bcm_sf2_to_priv(ds);
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct bcm_sf2_priv *priv;
+	int port = dp->index;
 	u32 reg, offset;
 
+	priv = bcm_sf2_to_priv(dp->ds);
 	if (priv->wol_ports_mask & BIT(port))
 		return;
 
@@ -824,23 +830,26 @@ static void bcm_sf2_sw_mac_link_down(struct dsa_switch *ds, int port,
 	reg &= ~LINK_STS;
 	core_writel(priv, reg, offset);
 
-	bcm_sf2_sw_mac_link_set(ds, port, interface, false);
+	bcm_sf2_sw_mac_link_set(dp->ds, port, interface, false);
 }
 
-static void bcm_sf2_sw_mac_link_up(struct dsa_switch *ds, int port,
+static void bcm_sf2_sw_mac_link_up(struct phylink_config *config,
+				   struct phy_device *phydev,
 				   unsigned int mode,
 				   phy_interface_t interface,
-				   struct phy_device *phydev,
 				   int speed, int duplex,
 				   bool tx_pause, bool rx_pause)
 {
-	struct bcm_sf2_priv *priv = bcm_sf2_to_priv(ds);
-	struct ethtool_keee *p = &priv->dev->ports[port].eee;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct bcm_sf2_priv *priv;
 	u32 reg_rgmii_ctrl = 0;
+	struct ethtool_keee *p;
+	int port = dp->index;
 	u32 reg, offset;
 
-	bcm_sf2_sw_mac_link_set(ds, port, interface, true);
+	bcm_sf2_sw_mac_link_set(dp->ds, port, interface, true);
 
+	priv = bcm_sf2_to_priv(dp->ds);
 	offset = bcm_sf2_port_override_offset(priv, port);
 
 	if (phy_interface_mode_is_rgmii(interface) ||
@@ -886,8 +895,10 @@ static void bcm_sf2_sw_mac_link_up(struct dsa_switch *ds, int port,
 
 	core_writel(priv, reg, offset);
 
-	if (mode == MLO_AN_PHY && phydev)
-		p->eee_enabled = b53_eee_init(ds, port, phydev);
+	if (mode == MLO_AN_PHY && phydev) {
+		p = &priv->dev->ports[port].eee;
+		p->eee_enabled = b53_eee_init(dp->ds, port, phydev);
+	}
 }
 
 static void bcm_sf2_sw_fixed_state(struct dsa_switch *ds, int port,
@@ -1196,6 +1207,12 @@ static int bcm_sf2_sw_get_sset_count(struct dsa_switch *ds, int port,
 	return cnt;
 }
 
+static const struct phylink_mac_ops bcm_sf2_phylink_mac_ops = {
+	.mac_config	= bcm_sf2_sw_mac_config,
+	.mac_link_down	= bcm_sf2_sw_mac_link_down,
+	.mac_link_up	= bcm_sf2_sw_mac_link_up,
+};
+
 static const struct dsa_switch_ops bcm_sf2_ops = {
 	.get_tag_protocol	= b53_get_tag_protocol,
 	.setup			= bcm_sf2_sw_setup,
@@ -1206,9 +1223,6 @@ static const struct dsa_switch_ops bcm_sf2_ops = {
 	.get_ethtool_phy_stats	= b53_get_ethtool_phy_stats,
 	.get_phy_flags		= bcm_sf2_sw_get_phy_flags,
 	.phylink_get_caps	= bcm_sf2_sw_get_caps,
-	.phylink_mac_config	= bcm_sf2_sw_mac_config,
-	.phylink_mac_link_down	= bcm_sf2_sw_mac_link_down,
-	.phylink_mac_link_up	= bcm_sf2_sw_mac_link_up,
 	.phylink_fixed_state	= bcm_sf2_sw_fixed_state,
 	.suspend		= bcm_sf2_sw_suspend,
 	.resume			= bcm_sf2_sw_resume,
@@ -1399,6 +1413,7 @@ static int bcm_sf2_sw_probe(struct platform_device *pdev)
 	priv->dev = dev;
 	ds = dev->ds;
 	ds->ops = &bcm_sf2_ops;
+	ds->phylink_mac_ops = &bcm_sf2_phylink_mac_ops;
 
 	/* Advertise the 8 egress queues */
 	ds->num_tx_queues = SF2_NUM_EGRESS_QUEUES;
-- 
2.30.2


