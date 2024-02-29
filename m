Return-Path: <netdev+bounces-76179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C7186CAF4
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 15:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EED45B211BC
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 14:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4881369AB;
	Thu, 29 Feb 2024 14:08:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95AD12F38F
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709215704; cv=none; b=hJjyX9gWGL3yiuagjFgh7GWoOJxrpgbEfdDUUDs90yvTB3WgN+NCvm64r7EvYzXBkUE5FAF5JoPlh+9s7iaHzHIN/+a9xsgHrEcejJPVYrBMVI8MBwcZSGfmCaXLH0Y4nqDkLdL2cyCcx1gHWSq3Ksv0QSptLnOxQtVaRqo5OdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709215704; c=relaxed/simple;
	bh=EjUlI4B+nyCavzxwMEbYsYK3pVkIBH0qY41+5ui6lDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LnUGFxI2XFOXhmI45mJzZKz+d9IGt3jhkbEluQTRb8eO1qcmeDr3moNGARWlZg42jUutMzb1qzcRfbfflXoyGkRmxy4misXjm/bP6G60BqXbYE7HBEYu3nyJDjPem3783Sqpz+2qZopmJTovuJ/XFIT5sWtrKuXMFHj+u179ZDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rfh4t-0000Sw-MV; Thu, 29 Feb 2024 15:08:03 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rfh4s-003ba0-0Q; Thu, 29 Feb 2024 15:08:02 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rfh4r-00ELmj-2a;
	Thu, 29 Feb 2024 15:08:01 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH net-next v7 5/8] net: phy: Immediately call adjust_link if only tx_lpi_enabled changes
Date: Thu, 29 Feb 2024 15:07:57 +0100
Message-Id: <20240229140800.3420180-6-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240229140800.3420180-1-o.rempel@pengutronix.de>
References: <20240229140800.3420180-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>

The MAC driver changes its EEE hardware configuration in its
adjust_link callback. This is called when auto-neg
completes. Disabling EEE via eee_enabled false will trigger an
autoneg, and as a result the adjust_link callback will be called with
phydev->enable_tx_lpi set to false. Similarly, eee_enabled set to true
and with a change of advertised link modes will result in a new
autoneg, and a call the adjust_link call.

If set_eee is called with only a change to tx_lpi_enabled which does
not trigger an auto-neg, it is necessary to call the adjust_link
callback so that the MAC is reconfigured to take this change into
account.

When setting phydev->enable_tx_lpi, take both eee_enabled and
tx_lpi_enabled into account, so the MAC drivers just needs to act on
phydev->enable_tx_lpi and not the whole EEE configuration.
The same check should be done for tx_lpi_timer too.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
v7: remove ' comment and parenthesis or return
v8: - add phy_link_down() before phy_link_up()
    - rewrite comment for phy_ethtool_set_eee_noneg()
    - add check for changed tx_lpi_timer
---
 drivers/net/phy/phy-c45.c | 14 ++++++++++++--
 drivers/net/phy/phy.c     | 38 +++++++++++++++++++++++++++++++++++---
 2 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 3e95b8a15f442..5695935fdce97 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1550,6 +1550,8 @@ EXPORT_SYMBOL(genphy_c45_ethtool_get_eee);
  * advertised, but the previously advertised link modes are
  * retained. This allows EEE to be enabled/disabled in a
  * non-destructive way.
+ * Returns either error code, 0 if there was no change, or positive
+ * value if there was a change which triggered auto-neg.
  */
 int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
 			       struct ethtool_keee *data)
@@ -1576,8 +1578,16 @@ int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
 	phydev->eee_enabled = data->eee_enabled;
 
 	ret = genphy_c45_an_config_eee_aneg(phydev);
-	if (ret > 0)
-		return phy_restart_aneg(phydev);
+	if (ret > 0) {
+		ret = phy_restart_aneg(phydev);
+		if (ret < 0)
+			return ret;
+
+		/* explicitly return 1, otherwise (ret > 0) value will be
+		 * overwritten by phy_restart_aneg().
+		 */
+		return 1;
+	}
 
 	return ret;
 }
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index f0ed07c74a36e..8216061ff0e34 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -988,7 +988,8 @@ static int phy_check_link_status(struct phy_device *phydev)
 		if (err < 0)
 			phydev->enable_tx_lpi = false;
 		else
-			phydev->enable_tx_lpi = !!err;
+			phydev->enable_tx_lpi = (err & phydev->eee_cfg.tx_lpi_enabled);
+
 		phy_link_up(phydev);
 	} else if (!phydev->link && phydev->state != PHY_NOLINK) {
 		phydev->state = PHY_NOLINK;
@@ -1679,6 +1680,34 @@ int phy_ethtool_get_eee(struct phy_device *phydev, struct ethtool_keee *data)
 }
 EXPORT_SYMBOL(phy_ethtool_get_eee);
 
+/**
+ * phy_ethtool_set_eee_noneg - Adjusts MAC LPI configuration without PHY
+ *			       renegotiation
+ * @phydev: pointer to the target PHY device structure
+ * @data: pointer to the ethtool_keee structure containing the new EEE settings
+ *
+ * This function updates the Energy Efficient Ethernet (EEE) configuration
+ * for cases where only the MAC's Low Power Idle (LPI) configuration changes,
+ * without triggering PHY renegotiation. It ensures that the MAC is properly
+ * informed of the new LPI settings by cycling the link down and up, which
+ * is necessary for the MAC to adopt the new configuration. This adjustment
+ * is done only if there is a change in the tx_lpi_enabled or tx_lpi_timer
+ * configuration.
+ */
+static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
+				      struct ethtool_keee *data)
+{
+	if (phydev->eee_cfg.tx_lpi_enabled != data->tx_lpi_enabled ||
+	    phydev->eee_cfg.tx_lpi_timer != data->tx_lpi_timer) {
+		eee_to_eeecfg(data, &phydev->eee_cfg);
+		phydev->enable_tx_lpi = eeecfg_mac_can_tx_lpi(&phydev->eee_cfg);
+		if (phydev->link) {
+			phy_link_down(phydev);
+			phy_link_up(phydev);
+		}
+	}
+}
+
 /**
  * phy_ethtool_set_eee - set EEE supported and status
  * @phydev: target phy_device struct
@@ -1695,11 +1724,14 @@ int phy_ethtool_set_eee(struct phy_device *phydev, struct ethtool_keee *data)
 
 	mutex_lock(&phydev->lock);
 	ret = genphy_c45_ethtool_set_eee(phydev, data);
-	if (!ret)
+	if (ret >= 0) {
+		if (ret == 0)
+			phy_ethtool_set_eee_noneg(phydev, data);
 		eee_to_eeecfg(data, &phydev->eee_cfg);
+	}
 	mutex_unlock(&phydev->lock);
 
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 EXPORT_SYMBOL(phy_ethtool_set_eee);
 
-- 
2.39.2


