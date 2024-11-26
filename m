Return-Path: <netdev+bounces-147361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7468C9D945E
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35EE5280C77
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5780D1BCA0D;
	Tue, 26 Nov 2024 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Bngp1Upj"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E379938DE0
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 09:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732613083; cv=none; b=CC38Z3rwgKlbN3dXK51QVAXnNJKSZ746JqYxFHG7tidU1kfRYxYkllHFB86ku1xzyBPloOSZ3QkgLVN9nDjnbRQlKIuTiTgqwVavUIuRJbgPu3MktWo2/bxC4nvD88sSZTXxB0oj+cf6CPt+ziPlCcKnHtHumbfP04zJiaum2cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732613083; c=relaxed/simple;
	bh=9NUJL/D2Blmwzn+POGPtw9d3LJPJ697+cMKLTCGVP50=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=tj9KczinQXnSyz/Lk7GADIxshbSkYc1TYtbXKPIDbiUvdFG+eF7q/NVtUNWolGWJeL0MCG5FYZ1WxDrawaDUiRe0Tr21kSDzS9FKZwHRZNyWvI+9dgdNZoVpXpHnMSF/hPWvEb4ke8c6qWCjPY3b5BqrldkLXZ/hhR17misVLXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Bngp1Upj; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mDzGazdSdeqAUGNAn5wuH8X9eWo9ToswwiNMcCeAoaY=; b=Bngp1UpjpHnm79JFKfpzKKtVl4
	FrgV93Y2hT7m82AKx+XBfZY2Q+9+Peg3x1lFx83rI8JM/dBORSKlFTp9XoJH7uJhyalpDP9T5xgS5
	5sUSXfgdXM18PNTdXj0Pk8iYs89Nifuhgp9BhMYxfe6jdJZn6kv0YvP/l7qqO8lirPexdSIDLZlBh
	Uwlp3POxrHpGs2/xCxyRwiwqJUCuy95+8lCmeBjUyp218f7yFLHGNHnYZb4jFUBlXPizHfKy6WV92
	WjV2c9vtK5ab/rvxwiZ65NpUN7S05CgL2pjcKWSFGYBURYS3ZaWrb4rjrbrWASTTNtk0iUxLvK41I
	3FBfLg/w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35826 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tFro2-0006S3-2R;
	Tue, 26 Nov 2024 09:24:27 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tFro1-005xPk-O5; Tue, 26 Nov 2024 09:24:25 +0000
In-Reply-To: <Z0WTpE8wkpjMiv_J@shell.armlinux.org.uk>
References: <Z0WTpE8wkpjMiv_J@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Couzens <lynxis@fe80.eu>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RFC net-next 02/16] net: phylink: split cur_link_an_mode into
 requested and active
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tFro1-005xPk-O5@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 26 Nov 2024 09:24:25 +0000

There is an interdependence between the current link_an_mode and
pcs_neg_mode that some drivers rely upon to know whether inband or PHY
mode will be used.

In order to support detection of PCS and PHY inband capabilities
resulting in automatic selection of inband or PHY mode, we need to
cater for this, and support changing the MAC link_an_mode. However, we
end up with an inter-dependency between the current link_an_mode and
pcs_neg_mode.

To solve this, split the current link_an_mode into the requested
link_an_mode and active link_an_mode. The requested link_an_mode will
always be passed to phylink_pcs_neg_mode(), and the active link_an_mode
will be used for everything else, and only updated during
phylink_major_config(). This will ensure that phylink_pcs_neg_mode()'s
link_an_mode will not depend on the active link_an_mode that will,
in a future patch, depend on pcs_neg_mode.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 60 ++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 8a43b81d5846..43a817de4bc8 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -56,7 +56,8 @@ struct phylink {
 	struct phy_device *phydev;
 	phy_interface_t link_interface;	/* PHY_INTERFACE_xxx */
 	u8 cfg_link_an_mode;		/* MLO_AN_xxx */
-	u8 cur_link_an_mode;
+	u8 req_link_an_mode;		/* Requested MLO_AN_xxx mode */
+	u8 act_link_an_mode;		/* Active MLO_AN_xxx mode */
 	u8 link_port;			/* The current non-phy ethtool port */
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported);
 
@@ -1065,13 +1066,13 @@ static void phylink_mac_config(struct phylink *pl,
 
 	phylink_dbg(pl,
 		    "%s: mode=%s/%s/%s adv=%*pb pause=%02x\n",
-		    __func__, phylink_an_mode_str(pl->cur_link_an_mode),
+		    __func__, phylink_an_mode_str(pl->act_link_an_mode),
 		    phy_modes(st.interface),
 		    phy_rate_matching_to_str(st.rate_matching),
 		    __ETHTOOL_LINK_MODE_MASK_NBITS, st.advertising,
 		    st.pause);
 
-	pl->mac_ops->mac_config(pl->config, pl->cur_link_an_mode, &st);
+	pl->mac_ops->mac_config(pl->config, pl->act_link_an_mode, &st);
 }
 
 static void phylink_pcs_an_restart(struct phylink *pl)
@@ -1079,7 +1080,7 @@ static void phylink_pcs_an_restart(struct phylink *pl)
 	if (pl->pcs && linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
 					 pl->link_config.advertising) &&
 	    phy_interface_mode_is_8023z(pl->link_config.interface) &&
-	    phylink_autoneg_inband(pl->cur_link_an_mode))
+	    phylink_autoneg_inband(pl->act_link_an_mode))
 		pl->pcs->ops->pcs_an_restart(pl->pcs);
 }
 
@@ -1109,7 +1110,7 @@ static void phylink_pcs_neg_mode(struct phylink *pl, struct phylink_pcs *pcs,
 {
 	unsigned int neg_mode, mode;
 
-	mode = pl->cur_link_an_mode;
+	mode = pl->req_link_an_mode;
 
 	switch (interface) {
 	case PHY_INTERFACE_MODE_SGMII:
@@ -1151,6 +1152,7 @@ static void phylink_pcs_neg_mode(struct phylink *pl, struct phylink_pcs *pcs,
 	}
 
 	pl->pcs_neg_mode = neg_mode;
+	pl->act_link_an_mode = mode;
 }
 
 static void phylink_major_config(struct phylink *pl, bool restart,
@@ -1181,7 +1183,7 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 	phylink_pcs_poll_stop(pl);
 
 	if (pl->mac_ops->mac_prepare) {
-		err = pl->mac_ops->mac_prepare(pl->config, pl->cur_link_an_mode,
+		err = pl->mac_ops->mac_prepare(pl->config, pl->act_link_an_mode,
 					       state->interface);
 		if (err < 0) {
 			phylink_err(pl, "mac_prepare failed: %pe\n",
@@ -1215,7 +1217,7 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 	if (pl->pcs_state == PCS_STATE_STARTING || pcs_changed)
 		phylink_pcs_enable(pl->pcs);
 
-	neg_mode = pl->cur_link_an_mode;
+	neg_mode = pl->act_link_an_mode;
 	if (pl->pcs && pl->pcs->neg_mode)
 		neg_mode = pl->pcs_neg_mode;
 
@@ -1231,7 +1233,7 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 		phylink_pcs_an_restart(pl);
 
 	if (pl->mac_ops->mac_finish) {
-		err = pl->mac_ops->mac_finish(pl->config, pl->cur_link_an_mode,
+		err = pl->mac_ops->mac_finish(pl->config, pl->act_link_an_mode,
 					      state->interface);
 		if (err < 0)
 			phylink_err(pl, "mac_finish failed: %pe\n",
@@ -1262,7 +1264,7 @@ static int phylink_change_inband_advert(struct phylink *pl)
 		return 0;
 
 	phylink_dbg(pl, "%s: mode=%s/%s adv=%*pb pause=%02x\n", __func__,
-		    phylink_an_mode_str(pl->cur_link_an_mode),
+		    phylink_an_mode_str(pl->req_link_an_mode),
 		    phy_modes(pl->link_config.interface),
 		    __ETHTOOL_LINK_MODE_MASK_NBITS, pl->link_config.advertising,
 		    pl->link_config.pause);
@@ -1271,7 +1273,7 @@ static int phylink_change_inband_advert(struct phylink *pl)
 	phylink_pcs_neg_mode(pl, pl->pcs, pl->link_config.interface,
 			     pl->link_config.advertising);
 
-	neg_mode = pl->cur_link_an_mode;
+	neg_mode = pl->act_link_an_mode;
 	if (pl->pcs->neg_mode)
 		neg_mode = pl->pcs_neg_mode;
 
@@ -1336,7 +1338,7 @@ static void phylink_mac_initial_config(struct phylink *pl, bool force_restart)
 {
 	struct phylink_link_state link_state;
 
-	switch (pl->cur_link_an_mode) {
+	switch (pl->req_link_an_mode) {
 	case MLO_AN_PHY:
 		link_state = pl->phy_state;
 		break;
@@ -1410,14 +1412,14 @@ static void phylink_link_up(struct phylink *pl,
 
 	pl->cur_interface = link_state.interface;
 
-	neg_mode = pl->cur_link_an_mode;
+	neg_mode = pl->act_link_an_mode;
 	if (pl->pcs && pl->pcs->neg_mode)
 		neg_mode = pl->pcs_neg_mode;
 
 	phylink_pcs_link_up(pl->pcs, neg_mode, pl->cur_interface, speed,
 			    duplex);
 
-	pl->mac_ops->mac_link_up(pl->config, pl->phydev, pl->cur_link_an_mode,
+	pl->mac_ops->mac_link_up(pl->config, pl->phydev, pl->act_link_an_mode,
 				 pl->cur_interface, speed, duplex,
 				 !!(link_state.pause & MLO_PAUSE_TX), rx_pause);
 
@@ -1437,7 +1439,7 @@ static void phylink_link_down(struct phylink *pl)
 
 	if (ndev)
 		netif_carrier_off(ndev);
-	pl->mac_ops->mac_link_down(pl->config, pl->cur_link_an_mode,
+	pl->mac_ops->mac_link_down(pl->config, pl->act_link_an_mode,
 				   pl->cur_interface);
 	phylink_info(pl, "Link is Down\n");
 }
@@ -1463,10 +1465,10 @@ static void phylink_resolve(struct work_struct *w)
 	} else if (pl->link_failed) {
 		link_state.link = false;
 		retrigger = true;
-	} else if (pl->cur_link_an_mode == MLO_AN_FIXED) {
+	} else if (pl->act_link_an_mode == MLO_AN_FIXED) {
 		phylink_get_fixed_state(pl, &link_state);
 		mac_config = link_state.link;
-	} else if (pl->cur_link_an_mode == MLO_AN_PHY) {
+	} else if (pl->act_link_an_mode == MLO_AN_PHY) {
 		link_state = pl->phy_state;
 		mac_config = link_state.link;
 	} else {
@@ -1520,7 +1522,7 @@ static void phylink_resolve(struct work_struct *w)
 		}
 	}
 
-	if (pl->cur_link_an_mode != MLO_AN_FIXED)
+	if (pl->act_link_an_mode != MLO_AN_FIXED)
 		phylink_apply_manual_flow(pl, &link_state);
 
 	if (mac_config) {
@@ -1644,7 +1646,7 @@ int phylink_set_fixed_link(struct phylink *pl,
 	pl->link_config.an_complete = 1;
 
 	pl->cfg_link_an_mode = MLO_AN_FIXED;
-	pl->cur_link_an_mode = pl->cfg_link_an_mode;
+	pl->req_link_an_mode = pl->cfg_link_an_mode;
 
 	return 0;
 }
@@ -1732,7 +1734,7 @@ struct phylink *phylink_create(struct phylink_config *config,
 		}
 	}
 
-	pl->cur_link_an_mode = pl->cfg_link_an_mode;
+	pl->req_link_an_mode = pl->cfg_link_an_mode;
 
 	ret = phylink_register_sfp(pl, fwnode);
 	if (ret < 0) {
@@ -2198,7 +2200,7 @@ void phylink_start(struct phylink *pl)
 	ASSERT_RTNL();
 
 	phylink_info(pl, "configuring for %s/%s link mode\n",
-		     phylink_an_mode_str(pl->cur_link_an_mode),
+		     phylink_an_mode_str(pl->req_link_an_mode),
 		     phy_modes(pl->link_config.interface));
 
 	/* Always set the carrier off */
@@ -2483,7 +2485,7 @@ int phylink_ethtool_ksettings_get(struct phylink *pl,
 
 	linkmode_copy(kset->link_modes.supported, pl->supported);
 
-	switch (pl->cur_link_an_mode) {
+	switch (pl->act_link_an_mode) {
 	case MLO_AN_FIXED:
 		/* We are using fixed settings. Report these as the
 		 * current link settings - and note that these also
@@ -2575,7 +2577,7 @@ int phylink_ethtool_ksettings_set(struct phylink *pl,
 		/* If we have a fixed link, refuse to change link parameters.
 		 * If the link parameters match, accept them but do nothing.
 		 */
-		if (pl->cur_link_an_mode == MLO_AN_FIXED) {
+		if (pl->req_link_an_mode == MLO_AN_FIXED) {
 			if (s->speed != pl->link_config.speed ||
 			    s->duplex != pl->link_config.duplex)
 				return -EINVAL;
@@ -2591,7 +2593,7 @@ int phylink_ethtool_ksettings_set(struct phylink *pl,
 		 * is our default case) but do not allow the advertisement to
 		 * be changed. If the advertisement matches, simply return.
 		 */
-		if (pl->cur_link_an_mode == MLO_AN_FIXED) {
+		if (pl->req_link_an_mode == MLO_AN_FIXED) {
 			if (!linkmode_equal(config.advertising,
 					    pl->link_config.advertising))
 				return -EINVAL;
@@ -2626,7 +2628,7 @@ int phylink_ethtool_ksettings_set(struct phylink *pl,
 		linkmode_copy(support, pl->supported);
 		if (phylink_validate(pl, support, &config)) {
 			phylink_err(pl, "validation of %s/%s with support %*pb failed\n",
-				    phylink_an_mode_str(pl->cur_link_an_mode),
+				    phylink_an_mode_str(pl->req_link_an_mode),
 				    phy_modes(config.interface),
 				    __ETHTOOL_LINK_MODE_MASK_NBITS, support);
 			return -EINVAL;
@@ -2726,7 +2728,7 @@ int phylink_ethtool_set_pauseparam(struct phylink *pl,
 
 	ASSERT_RTNL();
 
-	if (pl->cur_link_an_mode == MLO_AN_FIXED)
+	if (pl->req_link_an_mode == MLO_AN_FIXED)
 		return -EOPNOTSUPP;
 
 	if (!phylink_test(pl->supported, Pause) &&
@@ -2990,7 +2992,7 @@ static int phylink_mii_read(struct phylink *pl, unsigned int phy_id,
 	struct phylink_link_state state;
 	int val = 0xffff;
 
-	switch (pl->cur_link_an_mode) {
+	switch (pl->act_link_an_mode) {
 	case MLO_AN_FIXED:
 		if (phy_id == 0) {
 			phylink_get_fixed_state(pl, &state);
@@ -3015,7 +3017,7 @@ static int phylink_mii_read(struct phylink *pl, unsigned int phy_id,
 static int phylink_mii_write(struct phylink *pl, unsigned int phy_id,
 			     unsigned int reg, unsigned int val)
 {
-	switch (pl->cur_link_an_mode) {
+	switch (pl->act_link_an_mode) {
 	case MLO_AN_FIXED:
 		break;
 
@@ -3205,9 +3207,9 @@ static void phylink_sfp_set_config(struct phylink *pl, u8 mode,
 		changed = true;
 	}
 
-	if (pl->cur_link_an_mode != mode ||
+	if (pl->req_link_an_mode != mode ||
 	    pl->link_config.interface != state->interface) {
-		pl->cur_link_an_mode = mode;
+		pl->req_link_an_mode = mode;
 		pl->link_config.interface = state->interface;
 
 		changed = true;
-- 
2.30.2


