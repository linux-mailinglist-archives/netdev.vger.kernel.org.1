Return-Path: <netdev+bounces-85711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF1C89BE02
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 13:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A883F1F21CEB
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 11:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB46651B4;
	Mon,  8 Apr 2024 11:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uUnzh28g"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CC164CFC
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 11:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712575177; cv=none; b=oXVHgZxpwz9otmaEFndhpweEQsgm+zT8E3LQ3nN3jVui2MIhg+77xcy6fhLwmdw2vDoE9ZmWpTeLVtq84SkEH2CV7e4nETzlqre6/rFfKcTyDtJpNBdW1jccTRrwVKQxbtDYu5NLB1L7k5a6gbktk/l1pfyVL6lhYHKmSf6o5qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712575177; c=relaxed/simple;
	bh=oceRgE+LEbXs6IfdF1hTirm/Fe+F0nfuTXDUGZy7rRg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=fjjaW6HnZ5gamBXoL0ZCHugpSM89J32SLugwo2NSYQlqxpHM2xw3sJZuJQ7u7JBMAAvLsiqFO4E9QAj/YfbgXrPzeQhaqI32j4wgvF6KfQYSz22A6HD8+E9QvDp+yH5ENFf4ZLNR5Q1rGInFr27pZ0tCQlMeVTepVbeQOzRpysU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=uUnzh28g; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=u1xQRMMklLtrpJwdDp+sK1a4czgB3hZJZbp219Gi6WE=; b=uUnzh28gUkvf1H7XK+DK4ygbo9
	CrobSysmvxWGApIkXx0T6SstevV7ZcW9Vc5devSMLXvlx3l9tnD0UvaulJsCBlHLUM4a9xd+DxvcM
	AbHuxXgpMUco1Hu+XCieaHtQGQCKKNjdIn00YBcDSVHRoin3pidYURQmezhHuIXrHdDuc22MIvk0m
	aiC51fsBb/XACTZWN6Onwm+lI/xErQ/19hJtEzurA6zYztxpDsfu7zDfiLpeBEk4enWw6mtooyvG7
	3ft89e5ug82CEn+S9mW67xKWlmG10ryr36mJEq1X0roLGTlR8+cGz/16AMylbKhHyUMj2E+5aYuKy
	29rZgW7Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35332 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rtn29-000575-1b;
	Mon, 08 Apr 2024 12:19:29 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rtn2A-0065p6-6G; Mon, 08 Apr 2024 12:19:30 +0100
In-Reply-To: <ZhPSpvJfvLqWi0Hu@shell.armlinux.org.uk>
References: <ZhPSpvJfvLqWi0Hu@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	 Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	 netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 3/3] net: dsa: mv88e6xxx: provide own phylink MAC
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
Message-Id: <E1rtn2A-0065p6-6G@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 08 Apr 2024 12:19:30 +0100

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


