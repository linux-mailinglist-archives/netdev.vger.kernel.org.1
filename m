Return-Path: <netdev+bounces-84521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF63897287
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 16:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46636B29A59
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1A1149C68;
	Wed,  3 Apr 2024 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qKaK3J2y"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA93E149017
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153933; cv=none; b=th3I9Io1dowTlO75drT+DMi87+Y+DwoNf2QrBFtkGW6pU4QDtkS3V8I11HPyhIZyOrkcWgXOCYz2FqHQ9az3fc4VVa2/XSvQOKfTz5d8TxDPbMgl+lyqucL0EvZtnwkuV+MHglBFqH/0ZBzZYZ4xdaABOYqLk5IJtHllKRjsv0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153933; c=relaxed/simple;
	bh=oceRgE+LEbXs6IfdF1hTirm/Fe+F0nfuTXDUGZy7rRg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=AwrPHfiyWYG515a/9831pLUMFl9YDLpTjR+siJfzx0bboYo4GAQzHZzeDxPFI6Ojyv+DLd5sW392CIyLfbpNwwGAwQU5xjjv+M3IvkbwBwBSywVArxxiLzHKAf0XtMxYq9vCyADDiKBeF2QL4ZpEytNCTPR88V1+rfkcugW6/mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qKaK3J2y; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=u1xQRMMklLtrpJwdDp+sK1a4czgB3hZJZbp219Gi6WE=; b=qKaK3J2yiMYbLpvUA74fn9eqnj
	1PGzMybgmAKUU/Cs1j4D5u5tVH4gFTsXyprjm+NA/IUXQK+fL5wwxh4lVhjE7WL3X4iUKrFjabwut
	/56U6Z9wGAUGrIApKUZ79TsgoBKLEG2yTw9ie09YyC3SLsWZkHlAESJrBXvuATCqlZVxMqx2YtMiK
	AJmRPqybZioFfEgzCb+QSB0veo41kQsgn1bzBnHNX6m6xDJ3/uKo/8mynyXF0X7rqfe2tQL25djAk
	OfHj9mOyLjy2Q25NZW3OaawtWXcWxJCjYyxK8Bo8Fj3oweXFpIFOc73Zt0zMWqVtB3oJdS6iCQDsG
	1QlFa17g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60028 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rs1Rt-0008Vw-2B;
	Wed, 03 Apr 2024 15:18:45 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rs1Ru-005g7Y-7w; Wed, 03 Apr 2024 15:18:46 +0100
In-Reply-To: <Zg1lEJR4bcczFekm@shell.armlinux.org.uk>
References: <Zg1lEJR4bcczFekm@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RFC net-next 3/3] net: dsa: mv88e6xxx: provide own phylink MAC
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
Message-Id: <E1rs1Ru-005g7Y-7w@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 03 Apr 2024 15:18:46 +0100

Convert mv88e6xxx to provide its own phylink MAC operations, thus
avoiding the shim layer in DSA's port.c

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 63 ++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 9ed1821184ec..2ba7cbea451f 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -790,24 +790,27 @@ static void mv88e6xxx_get_caps(struct dsa_switch *ds, int port,
 	}
 }
 
-static struct phylink_pcs *mv88e6xxx_mac_select_pcs(struct dsa_switch *ds,
-						    int port,
-						    phy_interface_t interface)
+static struct phylink_pcs *
+mv88e6xxx_mac_select_pcs(struct phylink_config *config,
+			 phy_interface_t interface)
 {
-	struct mv88e6xxx_chip *chip = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct mv88e6xxx_chip *chip = dp->ds->priv;
 	struct phylink_pcs *pcs = ERR_PTR(-EOPNOTSUPP);
 
 	if (chip->info->ops->pcs_ops)
-		pcs = chip->info->ops->pcs_ops->pcs_select(chip, port,
+		pcs = chip->info->ops->pcs_ops->pcs_select(chip, dp->index,
 							   interface);
 
 	return pcs;
 }
 
-static int mv88e6xxx_mac_prepare(struct dsa_switch *ds, int port,
+static int mv88e6xxx_mac_prepare(struct phylink_config *config,
 				 unsigned int mode, phy_interface_t interface)
 {
-	struct mv88e6xxx_chip *chip = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct mv88e6xxx_chip *chip = dp->ds->priv;
+	int port = dp->index;
 	int err = 0;
 
 	/* In inband mode, the link may come up at any time while the link
@@ -826,11 +829,13 @@ static int mv88e6xxx_mac_prepare(struct dsa_switch *ds, int port,
 	return err;
 }
 
-static void mv88e6xxx_mac_config(struct dsa_switch *ds, int port,
+static void mv88e6xxx_mac_config(struct phylink_config *config,
 				 unsigned int mode,
 				 const struct phylink_link_state *state)
 {
-	struct mv88e6xxx_chip *chip = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct mv88e6xxx_chip *chip = dp->ds->priv;
+	int port = dp->index;
 	int err = 0;
 
 	mv88e6xxx_reg_lock(chip);
@@ -846,13 +851,15 @@ static void mv88e6xxx_mac_config(struct dsa_switch *ds, int port,
 	mv88e6xxx_reg_unlock(chip);
 
 	if (err && err != -EOPNOTSUPP)
-		dev_err(ds->dev, "p%d: failed to configure MAC/PCS\n", port);
+		dev_err(chip->dev, "p%d: failed to configure MAC/PCS\n", port);
 }
 
-static int mv88e6xxx_mac_finish(struct dsa_switch *ds, int port,
+static int mv88e6xxx_mac_finish(struct phylink_config *config,
 				unsigned int mode, phy_interface_t interface)
 {
-	struct mv88e6xxx_chip *chip = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct mv88e6xxx_chip *chip = dp->ds->priv;
+	int port = dp->index;
 	int err = 0;
 
 	/* Undo the forced down state above after completing configuration
@@ -876,12 +883,14 @@ static int mv88e6xxx_mac_finish(struct dsa_switch *ds, int port,
 	return err;
 }
 
-static void mv88e6xxx_mac_link_down(struct dsa_switch *ds, int port,
+static void mv88e6xxx_mac_link_down(struct phylink_config *config,
 				    unsigned int mode,
 				    phy_interface_t interface)
 {
-	struct mv88e6xxx_chip *chip = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct mv88e6xxx_chip *chip = dp->ds->priv;
 	const struct mv88e6xxx_ops *ops;
+	int port = dp->index;
 	int err = 0;
 
 	ops = chip->info->ops;
@@ -904,14 +913,16 @@ static void mv88e6xxx_mac_link_down(struct dsa_switch *ds, int port,
 			"p%d: failed to force MAC link down\n", port);
 }
 
-static void mv88e6xxx_mac_link_up(struct dsa_switch *ds, int port,
-				  unsigned int mode, phy_interface_t interface,
+static void mv88e6xxx_mac_link_up(struct phylink_config *config,
 				  struct phy_device *phydev,
+				  unsigned int mode, phy_interface_t interface,
 				  int speed, int duplex,
 				  bool tx_pause, bool rx_pause)
 {
-	struct mv88e6xxx_chip *chip = ds->priv;
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct mv88e6xxx_chip *chip = dp->ds->priv;
 	const struct mv88e6xxx_ops *ops;
+	int port = dp->index;
 	int err = 0;
 
 	ops = chip->info->ops;
@@ -937,7 +948,7 @@ static void mv88e6xxx_mac_link_up(struct dsa_switch *ds, int port,
 	mv88e6xxx_reg_unlock(chip);
 
 	if (err && err != -EOPNOTSUPP)
-		dev_err(ds->dev,
+		dev_err(chip->dev,
 			"p%d: failed to configure MAC link up\n", port);
 }
 
@@ -6918,6 +6929,15 @@ static int mv88e6xxx_crosschip_lag_leave(struct dsa_switch *ds, int sw_index,
 	return err_sync ? : err_pvt;
 }
 
+static const struct phylink_mac_ops mv88e6xxx_phylink_mac_ops = {
+	.mac_select_pcs		= mv88e6xxx_mac_select_pcs,
+	.mac_prepare		= mv88e6xxx_mac_prepare,
+	.mac_config		= mv88e6xxx_mac_config,
+	.mac_finish		= mv88e6xxx_mac_finish,
+	.mac_link_down		= mv88e6xxx_mac_link_down,
+	.mac_link_up		= mv88e6xxx_mac_link_up,
+};
+
 static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
 	.get_tag_protocol	= mv88e6xxx_get_tag_protocol,
 	.change_tag_protocol	= mv88e6xxx_change_tag_protocol,
@@ -6926,12 +6946,6 @@ static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
 	.port_setup		= mv88e6xxx_port_setup,
 	.port_teardown		= mv88e6xxx_port_teardown,
 	.phylink_get_caps	= mv88e6xxx_get_caps,
-	.phylink_mac_select_pcs	= mv88e6xxx_mac_select_pcs,
-	.phylink_mac_prepare	= mv88e6xxx_mac_prepare,
-	.phylink_mac_config	= mv88e6xxx_mac_config,
-	.phylink_mac_finish	= mv88e6xxx_mac_finish,
-	.phylink_mac_link_down	= mv88e6xxx_mac_link_down,
-	.phylink_mac_link_up	= mv88e6xxx_mac_link_up,
 	.get_strings		= mv88e6xxx_get_strings,
 	.get_ethtool_stats	= mv88e6xxx_get_ethtool_stats,
 	.get_eth_mac_stats	= mv88e6xxx_get_eth_mac_stats,
@@ -7000,6 +7014,7 @@ static int mv88e6xxx_register_switch(struct mv88e6xxx_chip *chip)
 	ds->priv = chip;
 	ds->dev = dev;
 	ds->ops = &mv88e6xxx_switch_ops;
+	ds->phylink_mac_ops = &mv88e6xxx_phylink_mac_ops;
 	ds->ageing_time_min = chip->info->age_time_coeff;
 	ds->ageing_time_max = chip->info->age_time_coeff * U8_MAX;
 
-- 
2.30.2


