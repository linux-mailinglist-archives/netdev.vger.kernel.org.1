Return-Path: <netdev+bounces-148364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7529E13F9
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BD971648FC
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 07:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2CA1DF272;
	Tue,  3 Dec 2024 07:22:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69111D95A3
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 07:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210529; cv=none; b=CgWqmnao5AjPxJxHp+AlJ42oi9ekOem3FSsuq4l+Rn1XjACdJT8jQP0/kHZwLggJwx/BuuSe9t+It9mYAtWmREtgUVcAs+WQrKRDpUDr/x5OOVr9iGnIu/al+5biYBJyy8iAXtbEkgbzopO0ilja3Jjnr/O5hSd/YXkZkDWMK84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210529; c=relaxed/simple;
	bh=6+x5xYyp3s9lxBDmUWDHLtkzK8qyqI/R6GxMsVp3+U8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Df/0A59YgS1TBAOkFqZ6cPs9qitGV70Y11GZjywsBQWqzyQy4j1lP7CvX86q00ZdI5MJGKGtAaAumGqTM0f1ZfQFEGyueF2RbaQtmjW61o0O4WiXDmbzpfa0eix8QfW5FAvrWdrLh0D974VxmKJBdZsh2l8h6TBrbBAirFzC9QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEL-0004ry-6E; Tue, 03 Dec 2024 08:21:57 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEI-001Qyk-3A;
	Tue, 03 Dec 2024 08:21:55 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEJ-00AEma-2C;
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
Subject: [PATCH net-next v1 01/21] net: usb: lan78xx: Remove LAN8835 PHY fixup
Date: Tue,  3 Dec 2024 08:21:34 +0100
Message-Id: <20241203072154.2440034-2-o.rempel@pengutronix.de>
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

Remove the PHY fixup for the LAN8835 PHY in the lan78xx driver due to
the following reasons:

- There is no publicly available information about the LAN8835 PHY.
  However, it appears to be the integrated PHY used in the LAN7800 and
  LAN7850 USB Ethernet controllers. These PHYs use the GMII interface,
  not RGMII as configured by the fixup.

- The correct driver for handling the LAN8835 PHY functionality is the
  Microchip PHY driver (`drivers/net/phy/microchip.c`), which properly
  supports these integrated PHYs.

- The PHY ID `0x0007C130` is actually used by the LAN8742A PHY, which
  only supports RMII. This interface is incompatible with the LAN78xx
  MAC, as the LAN7801 (the only LAN78xx version without an integrated
  PHY) supports only RGMII.

- The mask applied for this fixup is overly broad, inadvertently
  covering both Microchip LAN88xx PHYs and unrelated SMSC LAN8742A PHYs,
  leading to potential conflicts with other devices.

- Testing has shown that removing this fixup for LAN7800 and LAN7850
  does not result in any noticeable difference in functionality, as the
  Microchip PHY driver (`drivers/net/phy/microchip.c`) handles all
  necessary configurations for these integrated PHYs.

- Registering this fixup globally (not limited to USB devices) risks
  conflicts by unintentionally modifying other interfaces whenever a
  LAN7801 adapter is connected to the system.

Note that both LAN7800 and LAN7850 USB Ethernet controllers use an
integrated PHY with the ID `0x0007C132`. Additionally, the LAN7515, a
specialized part for Raspberry Pi, includes an integrated LAN7800 USB
Ethernet controller and USB hub in a multifunctional chip design, and it
also uses the same PHY ID (`0x0007C132`).

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 531b1b6a37d1..6e468e77d796 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -473,7 +473,6 @@ struct lan78xx_net {
 };
 
 /* define external phy id */
-#define	PHY_LAN8835			(0x0007C130)
 #define	PHY_KSZ9031RNX			(0x00221620)
 
 /* use ethtool to change the level for any given device */
@@ -2234,29 +2233,6 @@ static void lan78xx_remove_irq_domain(struct lan78xx_net *dev)
 	dev->domain_data.irqdomain = NULL;
 }
 
-static int lan8835_fixup(struct phy_device *phydev)
-{
-	int buf;
-	struct lan78xx_net *dev = netdev_priv(phydev->attached_dev);
-
-	/* LED2/PME_N/IRQ_N/RGMII_ID pin to IRQ_N mode */
-	buf = phy_read_mmd(phydev, MDIO_MMD_PCS, 0x8010);
-	buf &= ~0x1800;
-	buf |= 0x0800;
-	phy_write_mmd(phydev, MDIO_MMD_PCS, 0x8010, buf);
-
-	/* RGMII MAC TXC Delay Enable */
-	lan78xx_write_reg(dev, MAC_RGMII_ID,
-			  MAC_RGMII_ID_TXC_DELAY_EN_);
-
-	/* RGMII TX DLL Tune Adjust */
-	lan78xx_write_reg(dev, RGMII_TX_BYP_DLL, 0x3D00);
-
-	dev->interface = PHY_INTERFACE_MODE_RGMII_TXID;
-
-	return 1;
-}
-
 static int ksz9031rnx_fixup(struct phy_device *phydev)
 {
 	struct lan78xx_net *dev = netdev_priv(phydev->attached_dev);
@@ -2315,14 +2291,6 @@ static struct phy_device *lan7801_phy_init(struct lan78xx_net *dev)
 			netdev_err(dev->net, "Failed to register fixup for PHY_KSZ9031RNX\n");
 			return NULL;
 		}
-		/* external PHY fixup for LAN8835 */
-		ret = phy_register_fixup_for_uid(PHY_LAN8835, 0xfffffff0,
-						 lan8835_fixup);
-		if (ret < 0) {
-			netdev_err(dev->net, "Failed to register fixup for PHY_LAN8835\n");
-			return NULL;
-		}
-		/* add more external PHY fixup here if needed */
 
 		phydev->is_internal = false;
 	}
@@ -2384,8 +2352,6 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 			} else {
 				phy_unregister_fixup_for_uid(PHY_KSZ9031RNX,
 							     0xfffffff0);
-				phy_unregister_fixup_for_uid(PHY_LAN8835,
-							     0xfffffff0);
 			}
 		}
 		return -EIO;
@@ -4243,7 +4209,6 @@ static void lan78xx_disconnect(struct usb_interface *intf)
 	phydev = net->phydev;
 
 	phy_unregister_fixup_for_uid(PHY_KSZ9031RNX, 0xfffffff0);
-	phy_unregister_fixup_for_uid(PHY_LAN8835, 0xfffffff0);
 
 	phy_disconnect(net->phydev);
 
-- 
2.39.5


