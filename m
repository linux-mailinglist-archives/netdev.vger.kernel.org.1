Return-Path: <netdev+bounces-199057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D3CADEC47
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 14:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6AFE163DD0
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 12:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3757F2E9754;
	Wed, 18 Jun 2025 12:26:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4685D2BD593
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750249577; cv=none; b=Tq9gFp/+2S2cHg7nzptMPQv/stEcWXg1PompSFhqMlJJZVsU3R7n/jpOueAhEV1LMe27oc3OjyBlF5GXMyEqCL9g1jOhHapl6NXELdD5eEhYzPi3CUxNRVYP3Xw6w4MxjdJbX1cIgUj9XpHs5EzuqO7u8w2WwaU3hrCoClL9zBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750249577; c=relaxed/simple;
	bh=U/U7iAZLQyV2QekzUH0bP3G5BFfFJqldYl8IDa4EX7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nk7XVoU/s51mCyoun6Y7g4ilHqYZO1qzBYmBRzyG6Ruh2CIOYH+vcd8On+c7BzTfwQe0lXmXCyigfztWR4D8TkyFSkVjto17DPdr01HKTxOLTpZBW3kd4qvubpADABdPFMliI6SpWXPt7LWJup2DM74d3ppcvLOJV9ielAHreVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uRrrg-00007h-UX; Wed, 18 Jun 2025 14:26:04 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uRrrf-0048Up-1j;
	Wed, 18 Jun 2025 14:26:03 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uRrrf-00DFCp-1I;
	Wed, 18 Jun 2025 14:26:03 +0200
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
Subject: [PATCH net-next v8 1/6] net: usb: lan78xx: Convert to PHYLINK for improved PHY and MAC management
Date: Wed, 18 Jun 2025 14:25:57 +0200
Message-Id: <20250618122602.3156678-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250618122602.3156678-1-o.rempel@pengutronix.de>
References: <20250618122602.3156678-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Convert the LAN78xx USB Ethernet driver to use the PHYLINK framework for
managing PHY and MAC interactions. This improves consistency with other
network drivers, simplifies pause frame handling, and enables cleaner
suspend/resume support.

Key changes:
- Replace all PHYLIB-based logic with PHYLINK equivalents:
  - Replace phy_connect()/phy_disconnect() with phylink_connect_phy()
  - Replace phy_start()/phy_stop() with phylink_start()/phylink_stop()
  - Replace pauseparam handling with phylink_ethtool_get/set_pauseparam()
- Introduce lan78xx_phylink_setup() to configure PHYLINK
- Add phylink MAC operations:
  - lan78xx_mac_config()
  - lan78xx_mac_link_up()
  - lan78xx_mac_link_down()
- Remove legacy link state handling:
  - lan78xx_link_status_change()
  - lan78xx_link_reset()
- Handle fixed-link fallback for LAN7801 using phylink_set_fixed_link()
- Replace deprecated flow control handling with phylink-managed logic

Power management:
- Switch suspend/resume paths to use phylink_suspend()/phylink_resume()
- Ensure proper use of rtnl_lock() where required
- Note: full runtime testing of power management is currently limited
  due to hardware setup constraints

Note: Conversion of EEE (Energy Efficient Ethernet) handling to the
PHYLINK-managed API will be done in a follow-up patch. For now, the
legacy EEE enable logic is preserved in mac_link_up().

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v8:
- Move netif_start_queue() from open() to the end of lan78xx_mac_link_up()
- Move netif_stop_queue() from close() to the start of lan78xx_mac_link_down()
- lan78xx_mac_link_up: add blank line before link_up_fail
- lan78xx_phy_init: do error cleanup in the function
- Revert EVENT_LINK_RESET rename and move it to a separate, earlier patch
changes v6:
- move functional interface changes and refactoring to separate patches
- switch suspend/resume to use phylink_suspend/resume with correct locking
- avoid setting phydev->interface manually; rely on phylink negotiation
- remove legacy pause/aneg setup and dead code (e.g. lan78xx_link_status_change)
- EEE conversion postponed to follow-up patch
- note that power management testing is limited due to HW constraints
changes v5:
- merge ethtool pause interface changes to this patch
changes v4:
- add PHYLINK dependency
- remove PHYLIB and FIXED_PHY, both are replaced by PHYLINK
changes v3:
- lan78xx_phy_init: drop phy_suspend()
- lan78xx_phylink_setup: use phy_interface_set_rgmii()
changes v2:
- lan78xx_mac_config: remove unused rgmii_id
- lan78xx_mac_config: PHY_INTERFACE_MODE_RGMII* variants
- lan78xx_mac_config: remove auto-speed and duplex configuration
- lan78xx_phylink_setup: set link_interface to PHY_INTERFACE_MODE_RGMII_ID
  instead of PHY_INTERFACE_MODE_NA.
- lan78xx_phy_init: use phylink_set_fixed_link() instead of allocating
  fixed PHY.
- lan78xx_configure_usb: move function values to separate variables
---
 drivers/net/usb/Kconfig   |   3 +-
 drivers/net/usb/lan78xx.c | 547 ++++++++++++++++++--------------------
 2 files changed, 262 insertions(+), 288 deletions(-)

diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
index 370b32fc2588..0a678e31cfaa 100644
--- a/drivers/net/usb/Kconfig
+++ b/drivers/net/usb/Kconfig
@@ -113,9 +113,8 @@ config USB_RTL8152
 config USB_LAN78XX
 	tristate "Microchip LAN78XX Based USB Ethernet Adapters"
 	select MII
-	select PHYLIB
+	select PHYLINK
 	select MICROCHIP_PHY
-	select FIXED_PHY
 	select CRC32
 	help
 	  This option adds support for Microchip LAN78XX based USB 2
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 64e2597c77cc..61b2a7c26f60 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -6,6 +6,7 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
+#include <linux/phylink.h>
 #include <linux/usb.h>
 #include <linux/crc32.h>
 #include <linux/signal.h>
@@ -455,7 +456,6 @@ struct lan78xx_net {
 
 	unsigned long		data[5];
 
-	int			link_on;
 	u8			mdix_ctrl;
 
 	u32			chipid;
@@ -463,13 +463,13 @@ struct lan78xx_net {
 	struct mii_bus		*mdiobus;
 	phy_interface_t		interface;
 
-	int			fc_autoneg;
-	u8			fc_request_control;
-
 	int			delta;
 	struct statstage	stats;
 
 	struct irq_domain_data	domain_data;
+
+	struct phylink		*phylink;
+	struct phylink_config	phylink_config;
 };
 
 /* use ethtool to change the level for any given device */
@@ -1554,28 +1554,6 @@ static void lan78xx_set_multicast(struct net_device *netdev)
 	schedule_work(&pdata->set_multicast);
 }
 
-static int lan78xx_configure_flowcontrol(struct lan78xx_net *dev,
-					 bool tx_pause, bool rx_pause);
-
-static int lan78xx_update_flowcontrol(struct lan78xx_net *dev, u8 duplex,
-				      u16 lcladv, u16 rmtadv)
-{
-	u8 cap;
-
-	if (dev->fc_autoneg)
-		cap = mii_resolve_flowctrl_fdx(lcladv, rmtadv);
-	else
-		cap = dev->fc_request_control;
-
-	netif_dbg(dev, link, dev->net, "rx pause %s, tx pause %s",
-		  (cap & FLOW_CTRL_RX ? "enabled" : "disabled"),
-		  (cap & FLOW_CTRL_TX ? "enabled" : "disabled"));
-
-	return lan78xx_configure_flowcontrol(dev,
-					     cap & FLOW_CTRL_TX,
-					     cap & FLOW_CTRL_RX);
-}
-
 static void lan78xx_rx_urb_submit_all(struct lan78xx_net *dev);
 
 static int lan78xx_mac_reset(struct lan78xx_net *dev)
@@ -1638,75 +1616,6 @@ static int lan78xx_phy_int_ack(struct lan78xx_net *dev)
 	return lan78xx_write_reg(dev, INT_STS, INT_STS_PHY_INT_);
 }
 
-static int lan78xx_configure_usb(struct lan78xx_net *dev, int speed);
-
-static int lan78xx_link_reset(struct lan78xx_net *dev)
-{
-	struct phy_device *phydev = dev->net->phydev;
-	struct ethtool_link_ksettings ecmd;
-	int ladv, radv, ret, link;
-
-	/* clear LAN78xx interrupt status */
-	ret = lan78xx_phy_int_ack(dev);
-	if (unlikely(ret < 0))
-		return ret;
-
-	mutex_lock(&phydev->lock);
-	phy_read_status(phydev);
-	link = phydev->link;
-	mutex_unlock(&phydev->lock);
-
-	if (!link && dev->link_on) {
-		dev->link_on = false;
-
-		/* reset MAC */
-		ret = lan78xx_mac_reset(dev);
-		if (ret < 0)
-			return ret;
-
-		timer_delete(&dev->stat_monitor);
-	} else if (link && !dev->link_on) {
-		dev->link_on = true;
-
-		phy_ethtool_ksettings_get(phydev, &ecmd);
-
-		ret = lan78xx_configure_usb(dev, ecmd.base.speed);
-		if (ret < 0)
-			return ret;
-
-		ladv = phy_read(phydev, MII_ADVERTISE);
-		if (ladv < 0)
-			return ladv;
-
-		radv = phy_read(phydev, MII_LPA);
-		if (radv < 0)
-			return radv;
-
-		netif_dbg(dev, link, dev->net,
-			  "speed: %u duplex: %d anadv: 0x%04x anlpa: 0x%04x",
-			  ecmd.base.speed, ecmd.base.duplex, ladv, radv);
-
-		ret = lan78xx_update_flowcontrol(dev, ecmd.base.duplex, ladv,
-						 radv);
-		if (ret < 0)
-			return ret;
-
-		if (!timer_pending(&dev->stat_monitor)) {
-			dev->delta = 1;
-			mod_timer(&dev->stat_monitor,
-				  jiffies + STAT_UPDATE_TIMER);
-		}
-
-		lan78xx_rx_urb_submit_all(dev);
-
-		local_bh_disable();
-		napi_schedule(&dev->napi);
-		local_bh_enable();
-	}
-
-	return 0;
-}
-
 /* some work can't be done in tasklets, so we use keventd
  *
  * NOTE:  annoying asymmetry:  if it's active, schedule_work() fails,
@@ -2015,63 +1924,16 @@ static void lan78xx_get_pause(struct net_device *net,
 			      struct ethtool_pauseparam *pause)
 {
 	struct lan78xx_net *dev = netdev_priv(net);
-	struct phy_device *phydev = net->phydev;
-	struct ethtool_link_ksettings ecmd;
 
-	phy_ethtool_ksettings_get(phydev, &ecmd);
-
-	pause->autoneg = dev->fc_autoneg;
-
-	if (dev->fc_request_control & FLOW_CTRL_TX)
-		pause->tx_pause = 1;
-
-	if (dev->fc_request_control & FLOW_CTRL_RX)
-		pause->rx_pause = 1;
+	phylink_ethtool_get_pauseparam(dev->phylink, pause);
 }
 
 static int lan78xx_set_pause(struct net_device *net,
 			     struct ethtool_pauseparam *pause)
 {
 	struct lan78xx_net *dev = netdev_priv(net);
-	struct phy_device *phydev = net->phydev;
-	struct ethtool_link_ksettings ecmd;
-	int ret;
-
-	phy_ethtool_ksettings_get(phydev, &ecmd);
-
-	if (pause->autoneg && !ecmd.base.autoneg) {
-		ret = -EINVAL;
-		goto exit;
-	}
-
-	dev->fc_request_control = 0;
-	if (pause->rx_pause)
-		dev->fc_request_control |= FLOW_CTRL_RX;
-
-	if (pause->tx_pause)
-		dev->fc_request_control |= FLOW_CTRL_TX;
-
-	if (ecmd.base.autoneg) {
-		__ETHTOOL_DECLARE_LINK_MODE_MASK(fc) = { 0, };
-		u32 mii_adv;
-
-		linkmode_clear_bit(ETHTOOL_LINK_MODE_Pause_BIT,
-				   ecmd.link_modes.advertising);
-		linkmode_clear_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
-				   ecmd.link_modes.advertising);
-		mii_adv = (u32)mii_advertise_flowctrl(dev->fc_request_control);
-		mii_adv_to_linkmode_adv_t(fc, mii_adv);
-		linkmode_or(ecmd.link_modes.advertising, fc,
-			    ecmd.link_modes.advertising);
-
-		phy_ethtool_ksettings_set(phydev, &ecmd);
-	}
-
-	dev->fc_autoneg = pause->autoneg;
 
-	ret = 0;
-exit:
-	return ret;
+	return phylink_ethtool_set_pauseparam(dev->phylink, pause);
 }
 
 static int lan78xx_get_regs_len(struct net_device *netdev)
@@ -2332,26 +2194,6 @@ static void lan78xx_remove_mdio(struct lan78xx_net *dev)
 	mdiobus_free(dev->mdiobus);
 }
 
-static void lan78xx_link_status_change(struct net_device *net)
-{
-	struct lan78xx_net *dev = netdev_priv(net);
-	struct phy_device *phydev = net->phydev;
-	u32 data;
-	int ret;
-
-	ret = lan78xx_read_reg(dev, MAC_CR, &data);
-	if (ret < 0)
-		return;
-
-	if (phydev->enable_tx_lpi)
-		data |=  MAC_CR_EEE_EN_;
-	else
-		data &= ~MAC_CR_EEE_EN_;
-	lan78xx_write_reg(dev, MAC_CR, data);
-
-	phy_print_status(phydev);
-}
-
 static int irq_map(struct irq_domain *d, unsigned int irq,
 		   irq_hw_number_t hwirq)
 {
@@ -2481,6 +2323,77 @@ static void lan78xx_remove_irq_domain(struct lan78xx_net *dev)
 	dev->domain_data.irqdomain = NULL;
 }
 
+static void lan78xx_mac_config(struct phylink_config *config, unsigned int mode,
+			       const struct phylink_link_state *state)
+{
+	struct net_device *net = to_net_dev(config->dev);
+	struct lan78xx_net *dev = netdev_priv(net);
+	u32 mac_cr = 0;
+	int ret;
+
+	/* Check if the mode is supported */
+	if (mode != MLO_AN_FIXED && mode != MLO_AN_PHY) {
+		netdev_err(net, "Unsupported negotiation mode: %u\n", mode);
+		return;
+	}
+
+	switch (state->interface) {
+	case PHY_INTERFACE_MODE_GMII:
+		mac_cr |= MAC_CR_GMII_EN_;
+		break;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+		break;
+	default:
+		netdev_warn(net, "Unsupported interface mode: %d\n",
+			    state->interface);
+		return;
+	}
+
+	ret = lan78xx_update_reg(dev, MAC_CR, MAC_CR_GMII_EN_, mac_cr);
+	if (ret < 0)
+		netdev_err(net, "Failed to config MAC with error %pe\n",
+			   ERR_PTR(ret));
+}
+
+static void lan78xx_mac_link_down(struct phylink_config *config,
+				  unsigned int mode, phy_interface_t interface)
+{
+	struct net_device *net = to_net_dev(config->dev);
+	struct lan78xx_net *dev = netdev_priv(net);
+	int ret;
+
+	netif_stop_queue(net);
+
+	/* MAC reset will not de-assert TXEN/RXEN, we need to stop them
+	 * manually before reset. TX and RX should be disabled before running
+	 * link_up sequence.
+	 */
+	ret = lan78xx_stop_tx_path(dev);
+	if (ret < 0)
+		goto link_down_fail;
+
+	ret = lan78xx_stop_rx_path(dev);
+	if (ret < 0)
+		goto link_down_fail;
+
+	/* MAC reset seems to not affect MAC configuration, no idea if it is
+	 * really needed, but it was done in previous driver version. So, leave
+	 * it here.
+	 */
+	ret = lan78xx_mac_reset(dev);
+	if (ret < 0)
+		goto link_down_fail;
+
+	return;
+
+link_down_fail:
+	netdev_err(dev->net, "Failed to set MAC down with error %pe\n",
+		   ERR_PTR(ret));
+}
+
 /**
  * lan78xx_configure_usb - Configure USB link power settings
  * @dev: pointer to the LAN78xx device structure
@@ -2616,28 +2529,103 @@ static int lan78xx_configure_flowcontrol(struct lan78xx_net *dev,
 	return lan78xx_write_reg(dev, FLOW, flow);
 }
 
+static void lan78xx_mac_link_up(struct phylink_config *config,
+				struct phy_device *phy,
+				unsigned int mode, phy_interface_t interface,
+				int speed, int duplex,
+				bool tx_pause, bool rx_pause)
+{
+	struct net_device *net = to_net_dev(config->dev);
+	struct lan78xx_net *dev = netdev_priv(net);
+	u32 mac_cr = 0;
+	int ret;
+
+	switch (speed) {
+	case SPEED_1000:
+		mac_cr |= MAC_CR_SPEED_1000_;
+		break;
+	case SPEED_100:
+		mac_cr |= MAC_CR_SPEED_100_;
+		break;
+	case SPEED_10:
+		mac_cr |= MAC_CR_SPEED_10_;
+		break;
+	default:
+		netdev_err(dev->net, "Unsupported speed %d\n", speed);
+		return;
+	}
+
+	if (duplex == DUPLEX_FULL)
+		mac_cr |= MAC_CR_FULL_DUPLEX_;
+
+	/* make sure TXEN and RXEN are disabled before reconfiguring MAC */
+	ret = lan78xx_update_reg(dev, MAC_CR, MAC_CR_SPEED_MASK_ |
+				 MAC_CR_FULL_DUPLEX_ | MAC_CR_EEE_EN_, mac_cr);
+	if (ret < 0)
+		goto link_up_fail;
+
+	ret = lan78xx_configure_flowcontrol(dev, tx_pause, rx_pause);
+	if (ret < 0)
+		goto link_up_fail;
+
+	ret = lan78xx_configure_usb(dev, speed);
+	if (ret < 0)
+		goto link_up_fail;
+
+	lan78xx_rx_urb_submit_all(dev);
+
+	ret = lan78xx_flush_rx_fifo(dev);
+	if (ret < 0)
+		goto link_up_fail;
+
+	ret = lan78xx_flush_tx_fifo(dev);
+	if (ret < 0)
+		goto link_up_fail;
+
+	ret = lan78xx_start_tx_path(dev);
+	if (ret < 0)
+		goto link_up_fail;
+
+	ret = lan78xx_start_rx_path(dev);
+	if (ret < 0)
+		goto link_up_fail;
+
+	netif_start_queue(net);
+
+	return;
+
+link_up_fail:
+	netdev_err(dev->net, "Failed to set MAC up with error %pe\n",
+		   ERR_PTR(ret));
+}
+
+static const struct phylink_mac_ops lan78xx_phylink_mac_ops = {
+	.mac_config = lan78xx_mac_config,
+	.mac_link_down = lan78xx_mac_link_down,
+	.mac_link_up = lan78xx_mac_link_up,
+};
+
 /**
- * lan78xx_register_fixed_phy() - Register a fallback fixed PHY
+ * lan78xx_set_fixed_link() - Set fixed link configuration for LAN7801
  * @dev: LAN78xx device
  *
- * Registers a fixed PHY with 1 Gbps full duplex. This is used in special cases
- * like EVB-KSZ9897-1, where LAN7801 acts as a USB-to-Ethernet interface to a
- * switch without a visible PHY.
+ * Use fixed link configuration with 1 Gbps full duplex. This is used in special
+ * cases like EVB-KSZ9897-1, where LAN7801 acts as a USB-to-Ethernet interface
+ * to a switch without a visible PHY.
  *
  * Return: pointer to the registered fixed PHY, or ERR_PTR() on error.
  */
-static struct phy_device *lan78xx_register_fixed_phy(struct lan78xx_net *dev)
+static int lan78xx_set_fixed_link(struct lan78xx_net *dev)
 {
-	static const struct fixed_phy_status fphy_status = {
-		.link = 1,
+	static const struct phylink_link_state state = {
 		.speed = SPEED_1000,
 		.duplex = DUPLEX_FULL,
 	};
 
 	netdev_info(dev->net,
-		    "No PHY found on LAN7801 – registering fixed PHY (e.g. EVB-KSZ9897-1)\n");
+		    "No PHY found on LAN7801 – using fixed link instead (e.g. EVB-KSZ9897-1)\n");
 
-	return fixed_phy_register(&fphy_status, NULL);
+	return phylink_set_fixed_link(dev->phylink, &state);
 }
 
 /**
@@ -2673,7 +2661,7 @@ static struct phy_device *lan78xx_get_phy(struct lan78xx_net *dev)
 
 		dev->interface = PHY_INTERFACE_MODE_RGMII;
 		/* No PHY found – fallback to fixed PHY (e.g. KSZ switch board) */
-		return lan78xx_register_fixed_phy(dev);
+		return NULL;
 
 	case ID_REV_CHIP_ID_7800_:
 	case ID_REV_CHIP_ID_7850_:
@@ -2800,20 +2788,72 @@ static int lan78xx_configure_leds_from_dt(struct lan78xx_net *dev,
 	return lan78xx_write_reg(dev, HW_CFG, reg);
 }
 
+static int lan78xx_phylink_setup(struct lan78xx_net *dev)
+{
+	struct phylink_config *pc = &dev->phylink_config;
+	struct phylink *phylink;
+
+	pc->dev = &dev->net->dev;
+	pc->type = PHYLINK_NETDEV;
+	pc->mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE | MAC_10 |
+			       MAC_100 | MAC_1000FD;
+	pc->mac_managed_pm = true;
+
+	if (dev->chipid == ID_REV_CHIP_ID_7801_)
+		phy_interface_set_rgmii(pc->supported_interfaces);
+	else
+		__set_bit(PHY_INTERFACE_MODE_GMII, pc->supported_interfaces);
+
+	phylink = phylink_create(pc, dev->net->dev.fwnode,
+				 dev->interface, &lan78xx_phylink_mac_ops);
+	if (IS_ERR(phylink))
+		return PTR_ERR(phylink);
+
+	dev->phylink = phylink;
+
+	return 0;
+}
+
+static void lan78xx_phy_uninit(struct lan78xx_net *dev)
+{
+	if (dev->phylink) {
+		phylink_disconnect_phy(dev->phylink);
+		phylink_destroy(dev->phylink);
+		dev->phylink = NULL;
+	}
+}
+
 static int lan78xx_phy_init(struct lan78xx_net *dev)
 {
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(fc) = { 0, };
-	int ret;
-	u32 mii_adv;
 	struct phy_device *phydev;
+	int ret;
 
 	phydev = lan78xx_get_phy(dev);
+	/* phydev can be NULL if no PHY is found and the chip is LAN7801,
+	 * which will use a fixed link later.
+	 * If an  error occurs, return the error code immediately.
+	 */
 	if (IS_ERR(phydev))
 		return PTR_ERR(phydev);
 
+	ret = lan78xx_phylink_setup(dev);
+	if (ret < 0)
+		return ret;
+
+	/* If no PHY is found, set up a fixed link. It is very specific to
+	 * the LAN7801 and is used in special cases like EVB-KSZ9897-1 where
+	 * LAN7801 acts as a USB-to-Ethernet interface to a switch without
+	 * a visible PHY.
+	 */
+	if (!phydev) {
+		ret = lan78xx_set_fixed_link(dev);
+		if (ret < 0)
+			goto phylink_uninit;
+	}
+
 	ret = lan78xx_mac_prepare_for_phy(dev);
 	if (ret < 0)
-		goto free_phy;
+		goto phylink_uninit;
 
 	/* if phyirq is not set, use polling mode in phylib */
 	if (dev->domain_data.phyirq > 0)
@@ -2822,54 +2862,23 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 		phydev->irq = PHY_POLL;
 	netdev_dbg(dev->net, "phydev->irq = %d\n", phydev->irq);
 
-	/* set to AUTOMDIX */
-	phydev->mdix = ETH_TP_MDI_AUTO;
-
-	ret = phy_connect_direct(dev->net, phydev,
-				 lan78xx_link_status_change,
-				 dev->interface);
+	ret = phylink_connect_phy(dev->phylink, phydev);
 	if (ret) {
-		netdev_err(dev->net, "can't attach PHY to %s\n",
-			   dev->mdiobus->id);
-		if (dev->chipid == ID_REV_CHIP_ID_7801_) {
-			if (phy_is_pseudo_fixed_link(phydev)) {
-				fixed_phy_unregister(phydev);
-				phy_device_free(phydev);
-			}
-		}
-		return -EIO;
+		netdev_err(dev->net, "can't attach PHY to %s, error %pe\n",
+			   dev->mdiobus->id, ERR_PTR(ret));
+		goto phylink_uninit;
 	}
 
-	/* MAC doesn't support 1000T Half */
-	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
-
-	/* support both flow controls */
-	dev->fc_request_control = (FLOW_CTRL_RX | FLOW_CTRL_TX);
-	linkmode_clear_bit(ETHTOOL_LINK_MODE_Pause_BIT,
-			   phydev->advertising);
-	linkmode_clear_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
-			   phydev->advertising);
-	mii_adv = (u32)mii_advertise_flowctrl(dev->fc_request_control);
-	mii_adv_to_linkmode_adv_t(fc, mii_adv);
-	linkmode_or(phydev->advertising, fc, phydev->advertising);
-
 	phy_support_eee(phydev);
 
 	ret = lan78xx_configure_leds_from_dt(dev, phydev);
-	if (ret)
-		goto free_phy;
-
-	genphy_config_aneg(phydev);
-
-	dev->fc_autoneg = phydev->autoneg;
+	if (ret < 0)
+		goto phylink_uninit;
 
 	return 0;
 
-free_phy:
-	if (phy_is_pseudo_fixed_link(phydev)) {
-		fixed_phy_unregister(phydev);
-		phy_device_free(phydev);
-	}
+phylink_uninit:
+	lan78xx_phy_uninit(dev);
 
 	return ret;
 }
@@ -3210,7 +3219,6 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 	unsigned long timeout;
 	int ret;
 	u32 buf;
-	u8 sig;
 
 	ret = lan78xx_read_reg(dev, HW_CFG, &buf);
 	if (ret < 0)
@@ -3367,22 +3375,12 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 	if (ret < 0)
 		return ret;
 
+	buf &= ~(MAC_CR_AUTO_DUPLEX_ | MAC_CR_AUTO_SPEED_);
+
 	/* LAN7801 only has RGMII mode */
-	if (dev->chipid == ID_REV_CHIP_ID_7801_) {
+	if (dev->chipid == ID_REV_CHIP_ID_7801_)
 		buf &= ~MAC_CR_GMII_EN_;
-		/* Enable Auto Duplex and Auto speed */
-		buf |= MAC_CR_AUTO_DUPLEX_ | MAC_CR_AUTO_SPEED_;
-	}
 
-	if (dev->chipid == ID_REV_CHIP_ID_7800_ ||
-	    dev->chipid == ID_REV_CHIP_ID_7850_) {
-		ret = lan78xx_read_raw_eeprom(dev, 0, 1, &sig);
-		if (!ret && sig != EEPROM_INDICATOR) {
-			/* Implies there is no external eeprom. Set mac speed */
-			netdev_info(dev->net, "No External EEPROM. Setting MAC Speed\n");
-			buf |= MAC_CR_AUTO_DUPLEX_ | MAC_CR_AUTO_SPEED_;
-		}
-	}
 	ret = lan78xx_write_reg(dev, MAC_CR, buf);
 	if (ret < 0)
 		return ret;
@@ -3432,9 +3430,11 @@ static int lan78xx_open(struct net_device *net)
 
 	mutex_lock(&dev->dev_mutex);
 
-	phy_start(net->phydev);
+	lan78xx_init_stats(dev);
+
+	napi_enable(&dev->napi);
 
-	netif_dbg(dev, ifup, dev->net, "phy initialised successfully");
+	set_bit(EVENT_DEV_OPEN, &dev->flags);
 
 	/* for Link Check */
 	if (dev->urb_intr) {
@@ -3446,31 +3446,8 @@ static int lan78xx_open(struct net_device *net)
 		}
 	}
 
-	ret = lan78xx_flush_rx_fifo(dev);
-	if (ret < 0)
-		goto done;
-	ret = lan78xx_flush_tx_fifo(dev);
-	if (ret < 0)
-		goto done;
+	phylink_start(dev->phylink);
 
-	ret = lan78xx_start_tx_path(dev);
-	if (ret < 0)
-		goto done;
-	ret = lan78xx_start_rx_path(dev);
-	if (ret < 0)
-		goto done;
-
-	lan78xx_init_stats(dev);
-
-	set_bit(EVENT_DEV_OPEN, &dev->flags);
-
-	netif_start_queue(net);
-
-	dev->link_on = false;
-
-	napi_enable(&dev->napi);
-
-	lan78xx_defer_kevent(dev, EVENT_LINK_RESET);
 done:
 	mutex_unlock(&dev->dev_mutex);
 
@@ -3528,7 +3505,6 @@ static int lan78xx_stop(struct net_device *net)
 		timer_delete_sync(&dev->stat_monitor);
 
 	clear_bit(EVENT_DEV_OPEN, &dev->flags);
-	netif_stop_queue(net);
 	napi_disable(&dev->napi);
 
 	lan78xx_terminate_urbs(dev);
@@ -3538,12 +3514,7 @@ static int lan78xx_stop(struct net_device *net)
 		   net->stats.rx_packets, net->stats.tx_packets,
 		   net->stats.rx_errors, net->stats.tx_errors);
 
-	/* ignore errors that occur stopping the Tx and Rx data paths */
-	lan78xx_stop_tx_path(dev);
-	lan78xx_stop_rx_path(dev);
-
-	if (net->phydev)
-		phy_stop(net->phydev);
+	phylink_stop(dev->phylink);
 
 	usb_kill_urb(dev->urb_intr);
 
@@ -4481,10 +4452,10 @@ static void lan78xx_delayedwork(struct work_struct *work)
 		int ret = 0;
 
 		clear_bit(EVENT_LINK_RESET, &dev->flags);
-		if (lan78xx_link_reset(dev) < 0) {
-			netdev_info(dev->net, "link reset failed (%d)\n",
-				    ret);
-		}
+		ret = lan78xx_phy_int_ack(dev);
+		if (ret)
+			netdev_info(dev->net, "PHY INT ack failed (%pe)\n",
+				    ERR_PTR(ret));
 	}
 
 	if (test_bit(EVENT_STAT_UPDATE, &dev->flags)) {
@@ -4558,32 +4529,29 @@ static void lan78xx_disconnect(struct usb_interface *intf)
 	struct lan78xx_net *dev;
 	struct usb_device *udev;
 	struct net_device *net;
-	struct phy_device *phydev;
 
 	dev = usb_get_intfdata(intf);
 	usb_set_intfdata(intf, NULL);
 	if (!dev)
 		return;
 
-	netif_napi_del(&dev->napi);
-
 	udev = interface_to_usbdev(intf);
 	net = dev->net;
 
+	rtnl_lock();
+	phylink_stop(dev->phylink);
+	phylink_disconnect_phy(dev->phylink);
+	rtnl_unlock();
+
+	netif_napi_del(&dev->napi);
+
 	unregister_netdev(net);
 
 	timer_shutdown_sync(&dev->stat_monitor);
 	set_bit(EVENT_DEV_DISCONNECT, &dev->flags);
 	cancel_delayed_work_sync(&dev->wq);
 
-	phydev = net->phydev;
-
-	phy_disconnect(net->phydev);
-
-	if (phy_is_pseudo_fixed_link(phydev)) {
-		fixed_phy_unregister(phydev);
-		phy_device_free(phydev);
-	}
+	phylink_destroy(dev->phylink);
 
 	usb_scuttle_anchored_urbs(&dev->deferred);
 
@@ -4667,7 +4635,6 @@ static int lan78xx_probe(struct usb_interface *intf,
 		goto out1;
 	}
 
-	/* netdev_printk() needs this */
 	SET_NETDEV_DEV(netdev, &intf->dev);
 
 	dev = netdev_priv(netdev);
@@ -4786,7 +4753,7 @@ static int lan78xx_probe(struct usb_interface *intf,
 	ret = register_netdev(netdev);
 	if (ret != 0) {
 		netif_err(dev, probe, netdev, "couldn't register the device\n");
-		goto out8;
+		goto phy_uninit;
 	}
 
 	usb_set_intfdata(intf, dev);
@@ -4801,8 +4768,8 @@ static int lan78xx_probe(struct usb_interface *intf,
 
 	return 0;
 
-out8:
-	phy_disconnect(netdev->phydev);
+phy_uninit:
+	lan78xx_phy_uninit(dev);
 free_urbs:
 	usb_free_urb(dev->urb_intr);
 out5:
@@ -5137,6 +5104,10 @@ static int lan78xx_suspend(struct usb_interface *intf, pm_message_t message)
 			spin_unlock_irq(&dev->txq.lock);
 		}
 
+		rtnl_lock();
+		phylink_suspend(dev->phylink, false);
+		rtnl_unlock();
+
 		/* stop RX */
 		ret = lan78xx_stop_rx_path(dev);
 		if (ret < 0)
@@ -5364,11 +5335,15 @@ static int lan78xx_reset_resume(struct usb_interface *intf)
 	if (ret < 0)
 		return ret;
 
-	phy_start(dev->net->phydev);
-
 	ret = lan78xx_resume(intf);
+	if (ret < 0)
+		return ret;
 
-	return ret;
+	rtnl_lock();
+	phylink_resume(dev->phylink);
+	rtnl_unlock();
+
+	return 0;
 }
 
 static const struct usb_device_id products[] = {
-- 
2.39.5


