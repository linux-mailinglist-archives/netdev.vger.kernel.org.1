Return-Path: <netdev+bounces-148567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D649E235D
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E6CFBC0FC5
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089DE1F76C7;
	Tue,  3 Dec 2024 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eDfEmjo5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E851F76DD
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239859; cv=none; b=XvcTxFNX/ikzHsC/GxgPaEgNMeKr/619+6IsuTfaTRvAvVWu5m5a3qMfOBshBDP8jGXWqV30mBGiIa9Ji6ytiE2zuJ+3lAhVv5t1Fp+g+BJMxnY3C39vCPZ663KJLSXLi6KsAEHEWbAciQvD4FtgvQcb0MQE5R4FbmqFEsN+Htw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239859; c=relaxed/simple;
	bh=tmA1kp86SfUJpRbUmr0tdiLQMdBxEuhMxK8+2l0Q5mU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Seg/FjHa4K5am8MK0tAdkfklcK4mgJFKrwlcdF2MbAzGeHchwB4MJgKwLML+fcUCXR0KN7pMF15iwqulxtpsT9BDCtV8b4KRbGp+Sz7OO3s1b0rgI3SkFztAPRq3RP2X5Cj5TyJnbzBtJtzb9zjsYDfR++HxzotoJk1OlaHqFC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eDfEmjo5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rDExw1NdEaNjdjbdwZJLZ+25rVHKLXANnuJ4nyfDxgI=; b=eDfEmjo5kpXpwJ3qTJmDruKuB7
	uOg8v6Yk1OJYZt9tZoghUPeuM5CW47UpN9xX1Hs34XEoTSzkWIsj9hHsk53fBbPhhffQnfLpAn7Mo
	/LHPDLBMObAKoXhiI6AW9H1x5u9TnWVfj9FoVHybEwMr6EaQAS8ti6l16Kh/JikBiVEVDS0h+pcfF
	80MXKf1n9FyUR41V3zRjb4NoDN4UCh56wXTQ06vLgkBIXK2vVLIROknLTpeHL2LWm3HM7/ensac86
	A07N3dn+RUQtDKDZtt722GkLLa4jU++r0OJ4V8MBh4LlRn7Q7CIVUbEGIf3Myo3gbIdW4knfmxYPi
	2Jl1vcTA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37776 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tIUrV-00027i-1K;
	Tue, 03 Dec 2024 15:30:53 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tIUrU-006ITn-Ai; Tue, 03 Dec 2024 15:30:52 +0000
In-Reply-To: <Z08kCwxdkU4n2V6x@shell.armlinux.org.uk>
References: <Z08kCwxdkU4n2V6x@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 02/13] net: phylink: split cur_link_an_mode into
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
Message-Id: <E1tIUrU-006ITn-Ai@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 03 Dec 2024 15:30:52 +0000

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

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 60 ++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index daee679f33b3..098021f1ab49 100644
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
@@ -2189,7 +2191,7 @@ void phylink_start(struct phylink *pl)
 	ASSERT_RTNL();
 
 	phylink_info(pl, "configuring for %s/%s link mode\n",
-		     phylink_an_mode_str(pl->cur_link_an_mode),
+		     phylink_an_mode_str(pl->req_link_an_mode),
 		     phy_modes(pl->link_config.interface));
 
 	/* Always set the carrier off */
@@ -2474,7 +2476,7 @@ int phylink_ethtool_ksettings_get(struct phylink *pl,
 
 	linkmode_copy(kset->link_modes.supported, pl->supported);
 
-	switch (pl->cur_link_an_mode) {
+	switch (pl->act_link_an_mode) {
 	case MLO_AN_FIXED:
 		/* We are using fixed settings. Report these as the
 		 * current link settings - and note that these also
@@ -2566,7 +2568,7 @@ int phylink_ethtool_ksettings_set(struct phylink *pl,
 		/* If we have a fixed link, refuse to change link parameters.
 		 * If the link parameters match, accept them but do nothing.
 		 */
-		if (pl->cur_link_an_mode == MLO_AN_FIXED) {
+		if (pl->req_link_an_mode == MLO_AN_FIXED) {
 			if (s->speed != pl->link_config.speed ||
 			    s->duplex != pl->link_config.duplex)
 				return -EINVAL;
@@ -2582,7 +2584,7 @@ int phylink_ethtool_ksettings_set(struct phylink *pl,
 		 * is our default case) but do not allow the advertisement to
 		 * be changed. If the advertisement matches, simply return.
 		 */
-		if (pl->cur_link_an_mode == MLO_AN_FIXED) {
+		if (pl->req_link_an_mode == MLO_AN_FIXED) {
 			if (!linkmode_equal(config.advertising,
 					    pl->link_config.advertising))
 				return -EINVAL;
@@ -2617,7 +2619,7 @@ int phylink_ethtool_ksettings_set(struct phylink *pl,
 		linkmode_copy(support, pl->supported);
 		if (phylink_validate(pl, support, &config)) {
 			phylink_err(pl, "validation of %s/%s with support %*pb failed\n",
-				    phylink_an_mode_str(pl->cur_link_an_mode),
+				    phylink_an_mode_str(pl->req_link_an_mode),
 				    phy_modes(config.interface),
 				    __ETHTOOL_LINK_MODE_MASK_NBITS, support);
 			return -EINVAL;
@@ -2717,7 +2719,7 @@ int phylink_ethtool_set_pauseparam(struct phylink *pl,
 
 	ASSERT_RTNL();
 
-	if (pl->cur_link_an_mode == MLO_AN_FIXED)
+	if (pl->req_link_an_mode == MLO_AN_FIXED)
 		return -EOPNOTSUPP;
 
 	if (!phylink_test(pl->supported, Pause) &&
@@ -2981,7 +2983,7 @@ static int phylink_mii_read(struct phylink *pl, unsigned int phy_id,
 	struct phylink_link_state state;
 	int val = 0xffff;
 
-	switch (pl->cur_link_an_mode) {
+	switch (pl->act_link_an_mode) {
 	case MLO_AN_FIXED:
 		if (phy_id == 0) {
 			phylink_get_fixed_state(pl, &state);
@@ -3006,7 +3008,7 @@ static int phylink_mii_read(struct phylink *pl, unsigned int phy_id,
 static int phylink_mii_write(struct phylink *pl, unsigned int phy_id,
 			     unsigned int reg, unsigned int val)
 {
-	switch (pl->cur_link_an_mode) {
+	switch (pl->act_link_an_mode) {
 	case MLO_AN_FIXED:
 		break;
 
@@ -3196,9 +3198,9 @@ static void phylink_sfp_set_config(struct phylink *pl, u8 mode,
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


