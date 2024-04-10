Return-Path: <netdev+bounces-86725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D748A00C6
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 21:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EDE01F22F19
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 19:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E6A181335;
	Wed, 10 Apr 2024 19:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xO7cugwm"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E333B28FD
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 19:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712778176; cv=none; b=LPgpjrw1qE6gDa5ABbTrxdqGIp4LEMksaV429kh4WM0SwzXNOgdUL3Sx9lLRVyS7u1qc5vHAIP9xEj9LM3x1AHY2JMr5WsBQ97ymd7wEkEW4PNXBTbtC7q/hx1KQ3uxeHwFUVKXie5nAHd43qgUp2Kqo0JPbNSZ8EixQhYD/qMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712778176; c=relaxed/simple;
	bh=WjsFhjaWYpy+oBggIEZAulMrl/nVqUl5gprLtDR2/m0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=s0ipB1t8pMwAB5zbo6sd0QANKhmg1dqQYs//HrASKq1395z+72iXY0DZ6SED6grj7G8k9iekLprpxyii6st5kQxUV0MeNzHe4UZ0O/IrOSjNtViG3XkdVb1n/DyboJCrcHHEjNhptQNjYx/FHTBh9Vd2DjQNrI4hZaVENRUoFCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xO7cugwm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cuVmm6L5H1rVY12kNEkqB/65W6AYXRjcHkF98nxXlP8=; b=xO7cugwm1J5xpaprHx22yfKkXY
	N26leHbJfabjKOsvZ5jW6HEhmehW+8ekip7TZtCKLFTdZNJ5GzI7ZAImPvz0HZcryg1IFI+MnT+CS
	jRuHHEPNtoRBfScYWQxnbokIMJYWxz58bXJMbINhkSMhTGoHe7Lq9UHarWkz8m6YtCqv8bk30NZlM
	cBBx9+6y7KmmWrHuDGfuNSWIkRq5Qpvq+B31tCAs3iwG0jrzPLNk04PM3VGsd0E/70UMPdVftLeWV
	qFs+GQM1mvX5QTlbnqquHAN4S314zoGbq1KOIy9I9Y/ecfRSiMb+xP0+nQRZe4TE1+XxVi3SD3LKO
	ktspucsQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34808 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rudqJ-0008Tr-2O;
	Wed, 10 Apr 2024 20:42:47 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rudqK-006K9N-HY; Wed, 10 Apr 2024 20:42:48 +0100
In-Reply-To: <ZhbrbM+d5UfgafGp@shell.armlinux.org.uk>
References: <ZhbrbM+d5UfgafGp@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	 Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	 netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 3/3] net: dsa: mv88e6xxx: provide own phylink MAC
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
Message-Id: <E1rudqK-006K9N-HY@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 10 Apr 2024 20:42:48 +0100

Convert mv88e6xxx to provide its own phylink MAC operations, thus
avoiding the shim layer in DSA's port.c

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 63 ++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index c95787cb9086..e950a634a3c7 100644
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
 
@@ -6922,6 +6933,15 @@ static int mv88e6xxx_crosschip_lag_leave(struct dsa_switch *ds, int sw_index,
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
@@ -6930,12 +6950,6 @@ static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
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
@@ -7004,6 +7018,7 @@ static int mv88e6xxx_register_switch(struct mv88e6xxx_chip *chip)
 	ds->priv = chip;
 	ds->dev = dev;
 	ds->ops = &mv88e6xxx_switch_ops;
+	ds->phylink_mac_ops = &mv88e6xxx_phylink_mac_ops;
 	ds->ageing_time_min = chip->info->age_time_coeff;
 	ds->ageing_time_max = chip->info->age_time_coeff * U8_MAX;
 
-- 
2.30.2


