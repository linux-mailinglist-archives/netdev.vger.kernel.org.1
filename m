Return-Path: <netdev+bounces-181223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A4EA84224
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 13:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E84B4C5405
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 11:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABAA2857FF;
	Thu, 10 Apr 2025 11:53:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEEA28368E
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 11:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744286000; cv=none; b=MrCcIm6X+QU2ahgRGudOG6M9ESI2V6/94YS1pR8B6MvUBn+QOo58HKK2417EebyLXWJnG0dT/TW4OR313/KUgkYHHK+gJUyRxQrNbjz3aO+GZp88HkM0VXpBJUU5OGaThVZHGTiYDOBEJibFeQjfrEUQyHtBa8ZYBsSPDPcR//s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744286000; c=relaxed/simple;
	bh=aSGHuyXWdzJpiK7Sqyxgkp+A1f3oFAaiC+59AM6RRsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g6O+gJWdm61tIBypoegUHo5n19aquvlVyCZOKomcx7GBWTP4820OK/TwbidKp+rVLkO0G9L1JgjrsbzaLGuUpokVE3eON2al0whmRa5fN53s9W/3A8A/nca0opVokyo9c+rDahyvht/bvef4XYcPLDTLS+J4QttDm1O/RaLpiVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u2qSw-0002xx-Q3; Thu, 10 Apr 2025 13:53:06 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u2qSu-004GL4-0I;
	Thu, 10 Apr 2025 13:53:04 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u2qSt-00AkfT-37;
	Thu, 10 Apr 2025 13:53:03 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v6 06/12] net: usb: lan78xx: Refactor USB link power configuration into helper
Date: Thu, 10 Apr 2025 13:52:56 +0200
Message-Id: <20250410115302.2562562-7-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250410115302.2562562-1-o.rempel@pengutronix.de>
References: <20250410115302.2562562-1-o.rempel@pengutronix.de>
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

Move the USB link power configuration logic from lan78xx_link_reset()
to a new helper function lan78xx_configure_usb(). This simplifies the
main link reset path and isolates USB-specific logic.

The new function handles U1/U2 enablement based on Ethernet link speed,
but only for SuperSpeed-capable devices (LAN7800 and LAN7801). LAN7850,
a High-Speed-only device, is explicitly excluded. A warning is logged
if SuperSpeed is reported unexpectedly for LAN7850.

Add a forward declaration for lan78xx_configure_usb() as preparation for
the upcoming phylink conversion, where it will also be used from the
mac_link_up() callback.

Open questions remain:

- Why is the 1000 Mbps configuration split into two steps (U2 disable,
  then U1 enable), unlike the single-step config used for 10/100 Mbps?

- U1/U2 behavior appears to depend on proper EEPROM configuration.
  There are known devices in the field without EEPROM. Should the driver
  enforce safe defaults in such cases?

Due to lack of USB subsystem expertise, no changes were made to this logic
beyond structural refactoring.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v6:
- this patch is added in v6
---
 drivers/net/usb/lan78xx.c | 90 +++++++++++++++++++++++++--------------
 1 file changed, 59 insertions(+), 31 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index b79cb8632671..8d29f9932a42 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1650,12 +1650,13 @@ static int lan78xx_phy_int_ack(struct lan78xx_net *dev)
 	return lan78xx_write_reg(dev, INT_STS, INT_STS_PHY_INT_);
 }
 
+static int lan78xx_configure_usb(struct lan78xx_net *dev, int speed);
+
 static int lan78xx_link_reset(struct lan78xx_net *dev)
 {
 	struct phy_device *phydev = dev->net->phydev;
 	struct ethtool_link_ksettings ecmd;
 	int ladv, radv, ret, link;
-	u32 buf;
 
 	/* clear LAN78xx interrupt status */
 	ret = lan78xx_phy_int_ack(dev);
@@ -1681,36 +1682,9 @@ static int lan78xx_link_reset(struct lan78xx_net *dev)
 
 		phy_ethtool_ksettings_get(phydev, &ecmd);
 
-		if (dev->udev->speed == USB_SPEED_SUPER) {
-			if (ecmd.base.speed == 1000) {
-				/* disable U2 */
-				ret = lan78xx_read_reg(dev, USB_CFG1, &buf);
-				if (ret < 0)
-					return ret;
-				buf &= ~USB_CFG1_DEV_U2_INIT_EN_;
-				ret = lan78xx_write_reg(dev, USB_CFG1, buf);
-				if (ret < 0)
-					return ret;
-				/* enable U1 */
-				ret = lan78xx_read_reg(dev, USB_CFG1, &buf);
-				if (ret < 0)
-					return ret;
-				buf |= USB_CFG1_DEV_U1_INIT_EN_;
-				ret = lan78xx_write_reg(dev, USB_CFG1, buf);
-				if (ret < 0)
-					return ret;
-			} else {
-				/* enable U1 & U2 */
-				ret = lan78xx_read_reg(dev, USB_CFG1, &buf);
-				if (ret < 0)
-					return ret;
-				buf |= USB_CFG1_DEV_U2_INIT_EN_;
-				buf |= USB_CFG1_DEV_U1_INIT_EN_;
-				ret = lan78xx_write_reg(dev, USB_CFG1, buf);
-				if (ret < 0)
-					return ret;
-			}
-		}
+		ret = lan78xx_configure_usb(dev, ecmd.base.speed);
+		if (ret < 0)
+			return ret;
 
 		ladv = phy_read(phydev, MII_ADVERTISE);
 		if (ladv < 0)
@@ -2522,6 +2496,60 @@ static void lan78xx_remove_irq_domain(struct lan78xx_net *dev)
 	dev->domain_data.irqdomain = NULL;
 }
 
+/**
+ * lan78xx_configure_usb - Configure USB link power settings
+ * @dev: pointer to the LAN78xx device structure
+ * @speed: negotiated Ethernet link speed (in Mbps)
+ *
+ * This function configures U1/U2 link power management for SuperSpeed
+ * USB devices based on the current Ethernet link speed. It uses the
+ * USB_CFG1 register to enable or disable U1 and U2 low-power states.
+ *
+ * Note: Only LAN7800 and LAN7801 support SuperSpeed (USB 3.x).
+ *       LAN7850 is a High-Speed-only (USB 2.0) device and is skipped.
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+static int lan78xx_configure_usb(struct lan78xx_net *dev, int speed)
+{
+	u32 mask, val;
+	int ret;
+
+	/* Only configure USB settings for SuperSpeed devices */
+	if (dev->udev->speed != USB_SPEED_SUPER)
+		return 0;
+
+	/* LAN7850 does not support USB 3.x */
+	if (dev->chipid == ID_REV_CHIP_ID_7850_) {
+		netdev_warn_once(dev->net, "Unexpected SuperSpeed for LAN7850 (USB 2.0 only)\n");
+		return 0;
+	}
+
+	switch (speed) {
+	case SPEED_1000:
+		/* Disable U2, enable U1 */
+		ret = lan78xx_update_reg(dev, USB_CFG1,
+					 USB_CFG1_DEV_U2_INIT_EN_, 0);
+		if (ret < 0)
+			return ret;
+
+		return lan78xx_update_reg(dev, USB_CFG1,
+					  USB_CFG1_DEV_U1_INIT_EN_,
+					  USB_CFG1_DEV_U1_INIT_EN_);
+
+	case SPEED_100:
+	case SPEED_10:
+		/* Enable both U1 and U2 */
+		mask = USB_CFG1_DEV_U1_INIT_EN_ | USB_CFG1_DEV_U2_INIT_EN_;
+		val = mask;
+		return lan78xx_update_reg(dev, USB_CFG1, mask, val);
+
+	default:
+		netdev_warn(dev->net, "Unsupported link speed: %d\n", speed);
+		return -EINVAL;
+	}
+}
+
 /**
  * lan78xx_register_fixed_phy() - Register a fallback fixed PHY
  * @dev: LAN78xx device
-- 
2.39.5


