Return-Path: <netdev+bounces-87444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE388A322C
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 17:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554DB1F25583
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E355D149E16;
	Fri, 12 Apr 2024 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wtASgX/h"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2048F149C72
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934925; cv=none; b=Rd8NZeorYYwfSNzRBYzpvG+kEZXZY90LbC+ft3v88ygddUDITvub3Yzbqms2rVhNMEPuTxuCWI+9Slc04jtRGUTWPyUGxS1kI0h75oC0L1NUjq7FmNCwcweGJQihuuRS/3DZt1b7I2up1y8PoB/qmA5NbcKkOcvgY1r8NymxVYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934925; c=relaxed/simple;
	bh=6pkoeaPr/KQvGYBRMWf9SpFMGLTcdr/M5tGL4GRkVOo=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=b16U2tkohrG/M/rZBbj3O/SOm8HCtpPbm7jsWmgRyjJA3F9yhPB2qJ7RJqd+eQncWlrX0+PuZk6E3hCjsgLKTkkGYG8QP4dGGVziqjIg5ceC75U+Ttxieii9+SCWSB8LdmInY4mpOktGF+WwWNuzA5TVCjvaqDYU9M3BXSPiWss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wtASgX/h; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=69I+J03RKZYhuJhLgqAkVGuuTQ2VqF70PcsHXBpRSQo=; b=wtASgX/hkDt1TMWfHp7keM1ONz
	ethZCcXtQWaCvhiaFQuKYG/EwEa4fwzg6sShxXDupz/2jK9aF7FQsqPS520EBea07r0/P+diBIjT9
	VZkBb10E7K57tYuvBeaoHqajC9luM1IGeOn5WsQW2azK+cB/38Ddz5oMwPWQRcpHCzC2QoZeIkN2F
	5E8vQHOOx7gyqj0rvurSyEl5qGVFpBoRVU0/AQputxM4JNsDqOZd/7LySbgyazhd3BL1DgIcaTIKi
	ychcsVdGgEFxqwC9WrvnF4My1x5K3mGlGyaGdOasKt1HuW2OFqsgGHkCXspgScbyZI+ysJZTxsO21
	dCneXDHg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47788 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rvIcY-0002cM-0m;
	Fri, 12 Apr 2024 16:15:18 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rvIcZ-006bQc-0W; Fri, 12 Apr 2024 16:15:19 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	 Vladimir Oltean <olteanv@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: dsa: ar9331: provide own phylink MAC operations
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rvIcZ-006bQc-0W@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 12 Apr 2024 16:15:19 +0100

Convert ar9331 to provide its own phylink MAC operations, thus
avoiding the shim layer in DSA's port.c.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/qca/ar9331.c | 37 +++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/net/dsa/qca/ar9331.c b/drivers/net/dsa/qca/ar9331.c
index 8d9d271ac3af..968cb81088bf 100644
--- a/drivers/net/dsa/qca/ar9331.c
+++ b/drivers/net/dsa/qca/ar9331.c
@@ -523,28 +523,30 @@ static void ar9331_sw_phylink_get_caps(struct dsa_switch *ds, int port,
 	}
 }
 
-static void ar9331_sw_phylink_mac_config(struct dsa_switch *ds, int port,
+static void ar9331_sw_phylink_mac_config(struct phylink_config *config,
 					 unsigned int mode,
 					 const struct phylink_link_state *state)
 {
-	struct ar9331_sw_priv *priv = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct ar9331_sw_priv *priv = dp->ds->priv;
 	struct regmap *regmap = priv->regmap;
 	int ret;
 
-	ret = regmap_update_bits(regmap, AR9331_SW_REG_PORT_STATUS(port),
+	ret = regmap_update_bits(regmap, AR9331_SW_REG_PORT_STATUS(dp->index),
 				 AR9331_SW_PORT_STATUS_LINK_EN |
 				 AR9331_SW_PORT_STATUS_FLOW_LINK_EN, 0);
 	if (ret)
 		dev_err_ratelimited(priv->dev, "%s: %i\n", __func__, ret);
 }
 
-static void ar9331_sw_phylink_mac_link_down(struct dsa_switch *ds, int port,
+static void ar9331_sw_phylink_mac_link_down(struct phylink_config *config,
 					    unsigned int mode,
 					    phy_interface_t interface)
 {
-	struct ar9331_sw_priv *priv = ds->priv;
-	struct ar9331_sw_port *p = &priv->port[port];
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct ar9331_sw_priv *priv = dp->ds->priv;
 	struct regmap *regmap = priv->regmap;
+	int port = dp->index;
 	int ret;
 
 	ret = regmap_update_bits(regmap, AR9331_SW_REG_PORT_STATUS(port),
@@ -552,23 +554,24 @@ static void ar9331_sw_phylink_mac_link_down(struct dsa_switch *ds, int port,
 	if (ret)
 		dev_err_ratelimited(priv->dev, "%s: %i\n", __func__, ret);
 
-	cancel_delayed_work_sync(&p->mib_read);
+	cancel_delayed_work_sync(&priv->port[port].mib_read);
 }
 
-static void ar9331_sw_phylink_mac_link_up(struct dsa_switch *ds, int port,
+static void ar9331_sw_phylink_mac_link_up(struct phylink_config *config,
+					  struct phy_device *phydev,
 					  unsigned int mode,
 					  phy_interface_t interface,
-					  struct phy_device *phydev,
 					  int speed, int duplex,
 					  bool tx_pause, bool rx_pause)
 {
-	struct ar9331_sw_priv *priv = ds->priv;
-	struct ar9331_sw_port *p = &priv->port[port];
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct ar9331_sw_priv *priv = dp->ds->priv;
 	struct regmap *regmap = priv->regmap;
+	int port = dp->index;
 	u32 val;
 	int ret;
 
-	schedule_delayed_work(&p->mib_read, 0);
+	schedule_delayed_work(&priv->port[port].mib_read, 0);
 
 	val = AR9331_SW_PORT_STATUS_MAC_MASK;
 	switch (speed) {
@@ -684,14 +687,17 @@ static void ar9331_get_pause_stats(struct dsa_switch *ds, int port,
 	spin_unlock(&p->stats_lock);
 }
 
+static const struct phylink_mac_ops ar9331_phylink_mac_ops = {
+	.mac_config	= ar9331_sw_phylink_mac_config,
+	.mac_link_down	= ar9331_sw_phylink_mac_link_down,
+	.mac_link_up	= ar9331_sw_phylink_mac_link_up,
+};
+
 static const struct dsa_switch_ops ar9331_sw_ops = {
 	.get_tag_protocol	= ar9331_sw_get_tag_protocol,
 	.setup			= ar9331_sw_setup,
 	.port_disable		= ar9331_sw_port_disable,
 	.phylink_get_caps	= ar9331_sw_phylink_get_caps,
-	.phylink_mac_config	= ar9331_sw_phylink_mac_config,
-	.phylink_mac_link_down	= ar9331_sw_phylink_mac_link_down,
-	.phylink_mac_link_up	= ar9331_sw_phylink_mac_link_up,
 	.get_stats64		= ar9331_get_stats64,
 	.get_pause_stats	= ar9331_get_pause_stats,
 };
@@ -1059,6 +1065,7 @@ static int ar9331_sw_probe(struct mdio_device *mdiodev)
 	ds->priv = priv;
 	priv->ops = ar9331_sw_ops;
 	ds->ops = &priv->ops;
+	ds->phylink_mac_ops = &ar9331_phylink_mac_ops;
 	dev_set_drvdata(&mdiodev->dev, priv);
 
 	for (i = 0; i < ARRAY_SIZE(priv->port); i++) {
-- 
2.30.2


