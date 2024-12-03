Return-Path: <netdev+bounces-148362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B6B9E13EE
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2928CB23814
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 07:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FD01DB54C;
	Tue,  3 Dec 2024 07:22:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AFF1D90B6
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 07:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210527; cv=none; b=NmvrWdeQIv2eyPi17SHFxFSKRA+wUR/QOghRDdFkVoYIDCWm5uaLIpZEI0IdkkcQ42/hkeWbn+OV/yLmncghwCEkEIFuvzV0NXfzCDovj2o3kebUWB5kW+SwCe6Td5KWHDmXlcouXetDIiHRbR2euRF1MfKYTqVTMgp54Wvk398=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210527; c=relaxed/simple;
	bh=nSI7uH5fbpQf4VeGeuBwA7sgzei7oc2daJifiQRNLSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UceM+5zuyU3TGQa7VMiivGrPa5YZ/0nr2UnCoIzTk8+jYrnMrqb4nN9LzfeTny0sp4ZVfS6ydF/EVIb2Y0TJ1ylISlbeaMjByjC5jF+xvxv7uwxPzcZmHWPHCGiVzRdU/VDLguDp6oJMLRLjQnhsLoP9/4wdV4pxqe/A1j2jI5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEL-0004s0-6F; Tue, 03 Dec 2024 08:21:57 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEI-001Qyl-3C;
	Tue, 03 Dec 2024 08:21:55 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEJ-00AEmk-2G;
	Tue, 03 Dec 2024 08:21:55 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH net-next v1 02/21] net: usb: lan78xx: Remove KSZ9031 PHY fixup
Date: Tue,  3 Dec 2024 08:21:35 +0100
Message-Id: <20241203072154.2440034-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241203072154.2440034-1-o.rempel@pengutronix.de>
References: <20241203072154.2440034-1-o.rempel@pengutronix.de>
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

Remove the KSZ9031RNX PHY fixup from the lan78xx driver. The fixup applied
specific RGMII pad skew configurations globally, but these settings violate the
RGMII specification and cause more harm than benefit.

Key issues with the fixup:
1. **Non-Compliant Timing**: The fixup's delay settings fall outside the RGMII
   specification requirements of 1.5 ns to 2.0 ns:
   - RX Path: Total delay of **2.16 ns** (PHY internal delay of 1.2 ns + 0.96
     ns skew).
   - TX Path: Total delay of **0.96 ns**, significantly below the RGMII minimum
     of 1.5 ns.

2. **Redundant or Incorrect Configurations**:
   - The RGMII skew registers written by the fixup do not meaningfully alter
     the PHY's default behavior and fail to account for its internal delays.
   - The TX_DATA pad skew was not configured, relying on power-on defaults
     that are insufficient for RGMII compliance.

3. **Micrel Driver Support**: By setting `PHY_INTERFACE_MODE_RGMII_ID`, the
   Micrel driver can calculate and assign appropriate skew values for the
   KSZ9031 PHY.  This ensures better timing configurations without relying on
   external fixups.

4. **System Interference**: The fixup applied globally, reconfiguring all
   KSZ9031 PHYs in the system, even those unrelated to the LAN78xx adapter.
   This could lead to unintended and harmful behavior on unrelated interfaces.

While the fixup is removed, a better mechanism is still needed to dynamically
determine the optimal combination of PHY and MAC delays to fully meet RGMII
requirements without relying on Device Tree or global fixups. This would allow
for robust operation across different hardware configurations.

The Micrel driver is capable of using the interface mode value to calculate and
apply better skew values, providing a configuration much closer to the RGMII
specification than the fixup. Removing the fixup ensures better default
behavior and prevents harm to other system interfaces.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 38 +++++---------------------------------
 1 file changed, 5 insertions(+), 33 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 6e468e77d796..918b88bd9524 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -472,9 +472,6 @@ struct lan78xx_net {
 	struct irq_domain_data	domain_data;
 };
 
-/* define external phy id */
-#define	PHY_KSZ9031RNX			(0x00221620)
-
 /* use ethtool to change the level for any given device */
 static int msg_level = -1;
 module_param(msg_level, int, 0);
@@ -2233,23 +2230,6 @@ static void lan78xx_remove_irq_domain(struct lan78xx_net *dev)
 	dev->domain_data.irqdomain = NULL;
 }
 
-static int ksz9031rnx_fixup(struct phy_device *phydev)
-{
-	struct lan78xx_net *dev = netdev_priv(phydev->attached_dev);
-
-	/* Micrel9301RNX PHY configuration */
-	/* RGMII Control Signal Pad Skew */
-	phy_write_mmd(phydev, MDIO_MMD_WIS, 4, 0x0077);
-	/* RGMII RX Data Pad Skew */
-	phy_write_mmd(phydev, MDIO_MMD_WIS, 5, 0x7777);
-	/* RGMII RX Clock Pad Skew */
-	phy_write_mmd(phydev, MDIO_MMD_WIS, 8, 0x1FF);
-
-	dev->interface = PHY_INTERFACE_MODE_RGMII_RXID;
-
-	return 1;
-}
-
 static struct phy_device *lan7801_phy_init(struct lan78xx_net *dev)
 {
 	u32 buf;
@@ -2283,14 +2263,11 @@ static struct phy_device *lan7801_phy_init(struct lan78xx_net *dev)
 			netdev_err(dev->net, "no PHY driver found\n");
 			return NULL;
 		}
-		dev->interface = PHY_INTERFACE_MODE_RGMII;
-		/* external PHY fixup for KSZ9031RNX */
-		ret = phy_register_fixup_for_uid(PHY_KSZ9031RNX, 0xfffffff0,
-						 ksz9031rnx_fixup);
-		if (ret < 0) {
-			netdev_err(dev->net, "Failed to register fixup for PHY_KSZ9031RNX\n");
-			return NULL;
-		}
+		dev->interface = PHY_INTERFACE_MODE_RGMII_ID;
+		/* The PHY driver is responsible to configure proper RGMII
+		 * interface delays. Disable RGMII delays on MAC side.
+		 */
+		lan78xx_write_reg(dev, MAC_RGMII_ID, 0);
 
 		phydev->is_internal = false;
 	}
@@ -2349,9 +2326,6 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 			if (phy_is_pseudo_fixed_link(phydev)) {
 				fixed_phy_unregister(phydev);
 				phy_device_free(phydev);
-			} else {
-				phy_unregister_fixup_for_uid(PHY_KSZ9031RNX,
-							     0xfffffff0);
 			}
 		}
 		return -EIO;
@@ -4208,8 +4182,6 @@ static void lan78xx_disconnect(struct usb_interface *intf)
 
 	phydev = net->phydev;
 
-	phy_unregister_fixup_for_uid(PHY_KSZ9031RNX, 0xfffffff0);
-
 	phy_disconnect(net->phydev);
 
 	if (phy_is_pseudo_fixed_link(phydev)) {
-- 
2.39.5


