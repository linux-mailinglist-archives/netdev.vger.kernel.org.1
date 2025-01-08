Return-Path: <netdev+bounces-156244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3D1A05B33
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 13:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA5B166CE0
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 12:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1E81FCF45;
	Wed,  8 Jan 2025 12:13:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AECB1FA15C
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 12:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736338436; cv=none; b=dnjALp5ShU9tnycG/MaapLzpy1A4VP1AAViz4bQPB3E7Ri3zQgnLtig9nXFfoFE4yK5jciPyMdsZIVPY9NuzCCHUKfM/05+uIk/XA5wAeIuJFnbSez4SMPLwP8Vsqjl8fIJqwqFQy2SmJjblkQ7Ee7vEY14BAhRPwqCeKQQcj8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736338436; c=relaxed/simple;
	bh=Jd6YMEILuIx8sIyNv/sWF0Inq0P9lLJz2ofnmS73v8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YB7C7+nbOxDVKkG8Dxz+irmvQEPtAcZn1qLfQfHnTL6TFe2d5q5hq0yG8/EIPosgvGBtM20hFIy+q4TZ2ZU5ae2CBRpLwn4m/AE7N3S4yqH3m2btfGWl5Zj6MGSzmAp0DUQR5S5e186sny3k32aV2AbacFRkcuzHs1fU0uW1yds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tVUwR-0002eE-PU; Wed, 08 Jan 2025 13:13:43 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVUwP-007W4b-1C;
	Wed, 08 Jan 2025 13:13:42 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVUwQ-00BHZv-0C;
	Wed, 08 Jan 2025 13:13:42 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <rmk+kernel@armlinux.org.uk>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH net-next v1 2/7] net: usb: lan78xx: Move fixed PHY cleanup to lan78xx_unbind()
Date: Wed,  8 Jan 2025 13:13:36 +0100
Message-Id: <20250108121341.2689130-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250108121341.2689130-1-o.rempel@pengutronix.de>
References: <20250108121341.2689130-1-o.rempel@pengutronix.de>
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

Move the cleanup of the fixed PHY to the lan78xx_unbind() function,
which is invoked during both the probe and disconnect paths.  This
change eliminates duplicate cleanup code in the disconnect routine and
ensures that the fixed PHY is properly freed during other probe steps.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 6dfd9301279f..3d0097d07bcd 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -474,6 +474,8 @@ struct lan78xx_net {
 
 	struct phylink		*phylink;
 	struct phylink_config	phylink_config;
+
+	struct phy_device	*fixed_phy;
 };
 
 /* use ethtool to change the level for any given device */
@@ -2589,6 +2591,8 @@ static struct phy_device *lan7801_phy_init(struct lan78xx_net *dev)
 			netdev_err(dev->net, "No PHY/fixed_PHY found\n");
 			return NULL;
 		}
+
+		dev->fixed_phy = phydev;
 		netdev_dbg(dev->net, "Registered FIXED PHY\n");
 		phydev->interface = PHY_INTERFACE_MODE_RGMII;
 		ret = lan78xx_write_reg(dev, MAC_RGMII_ID,
@@ -2690,14 +2694,8 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 
 	ret = phylink_connect_phy(dev->phylink, phydev);
 	if (ret) {
-		netdev_err(dev->net, "can't attach PHY to %s\n",
-			   dev->mdiobus->id);
-		if (dev->chipid == ID_REV_CHIP_ID_7801_) {
-			if (phy_is_pseudo_fixed_link(phydev)) {
-				fixed_phy_unregister(phydev);
-				phy_device_free(phydev);
-			}
-		}
+		netdev_err(dev->net, "can't attach PHY to %s, error %pe\n",
+			   dev->mdiobus->id, ERR_PTR(ret));
 		return -EIO;
 	}
 
@@ -3652,6 +3650,12 @@ static void lan78xx_unbind(struct lan78xx_net *dev, struct usb_interface *intf)
 {
 	struct lan78xx_priv *pdata = (struct lan78xx_priv *)(dev->data[0]);
 
+	if (dev->fixed_phy) {
+		fixed_phy_unregister(dev->fixed_phy);
+		phy_device_free(dev->fixed_phy);
+		dev->fixed_phy = NULL;
+	}
+
 	lan78xx_remove_irq_domain(dev);
 
 	lan78xx_remove_mdio(dev);
@@ -4378,7 +4382,6 @@ static void lan78xx_disconnect(struct usb_interface *intf)
 	struct lan78xx_net *dev;
 	struct usb_device *udev;
 	struct net_device *net;
-	struct phy_device *phydev;
 
 	dev = usb_get_intfdata(intf);
 	usb_set_intfdata(intf, NULL);
@@ -4401,11 +4404,6 @@ static void lan78xx_disconnect(struct usb_interface *intf)
 	set_bit(EVENT_DEV_DISCONNECT, &dev->flags);
 	cancel_delayed_work_sync(&dev->wq);
 
-	if (phy_is_pseudo_fixed_link(phydev)) {
-		fixed_phy_unregister(phydev);
-		phy_device_free(phydev);
-	}
-
 	phylink_destroy(dev->phylink);
 
 	usb_scuttle_anchored_urbs(&dev->deferred);
-- 
2.39.5


