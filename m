Return-Path: <netdev+bounces-156246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF85A05B3F
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 13:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775351888F89
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 12:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310961FE44A;
	Wed,  8 Jan 2025 12:13:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E514D1FBEAC
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 12:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736338438; cv=none; b=kUCpjOIBq0L7f5MDR/9mxRcxVG4FizJpW6pK7vdKJG8JbrjeHGZjbcTsCoNpB85r2/lUFJs9NbjqzgLVaoejKPNEKQJA4mGUdUaZrFAALRLbOWfTOtOCmBlsxP+vuZ/8zaJJJYJbJIqEXqSoo+0E9jTCy/rS9vnDO2KX9whZFiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736338438; c=relaxed/simple;
	bh=dHR7pXfW0WZ6nVY3YvBRoCrEW9CuNPyC8mLM9MnZD5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rh8N+jJVU/tIqIgS1x4VLsxhmlhCErYePG7lLkIEavaJtyPTNJV2Z+rGQ4A7iq5+yABzXyiduFtOy16DUKU/gj/PdtvTXPxfHeUbQ46mPcrwGaQxcb1TpfFJX53XCuqeEMbjsuTWtjuntuGQvuZl/qHQ8GAfV9isAaxhr0tqRqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tVUwR-0002eB-PS; Wed, 08 Jan 2025 13:13:43 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVUwP-007W4a-15;
	Wed, 08 Jan 2025 13:13:42 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVUwQ-00BHZk-09;
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
Subject: [PATCH net-next v1 1/7] net: usb: lan78xx: Convert to PHYlink for improved PHY and MAC management
Date: Wed,  8 Jan 2025 13:13:35 +0100
Message-Id: <20250108121341.2689130-2-o.rempel@pengutronix.de>
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

Convert the LAN78xx driver to use the PHYlink framework for managing
PHY and MAC interactions.

Key changes include:
- Replace direct PHY operations with phylink equivalents (e.g.,
  phylink_start, phylink_stop).
- Introduce lan78xx_phylink_setup for phylink initialization and
  configuration.
- Add phylink MAC operations (lan78xx_mac_config,
  lan78xx_mac_link_down, lan78xx_mac_link_up) for managing link
  settings and flow control.
- Remove redundant and now phylink-managed functions like
  `lan78xx_link_status_change`.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 525 +++++++++++++++++++++-----------------
 1 file changed, 287 insertions(+), 238 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index a91bf9c7e31d..6dfd9301279f 100644
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
@@ -384,7 +385,7 @@ struct skb_data {		/* skb->cb is one of these */
 #define EVENT_RX_HALT			1
 #define EVENT_RX_MEMORY			2
 #define EVENT_STS_SPLIT			3
-#define EVENT_LINK_RESET		4
+#define EVENT_PHY_INT_ACK		4
 #define EVENT_RX_PAUSED			5
 #define EVENT_DEV_WAKING		6
 #define EVENT_DEV_ASLEEP		7
@@ -470,6 +471,9 @@ struct lan78xx_net {
 	struct statstage	stats;
 
 	struct irq_domain_data	domain_data;
+
+	struct phylink		*phylink;
+	struct phylink_config	phylink_config;
 };
 
 /* use ethtool to change the level for any given device */
@@ -1554,40 +1558,6 @@ static void lan78xx_set_multicast(struct net_device *netdev)
 	schedule_work(&pdata->set_multicast);
 }
 
-static int lan78xx_update_flowcontrol(struct lan78xx_net *dev, u8 duplex,
-				      u16 lcladv, u16 rmtadv)
-{
-	u32 flow = 0, fct_flow = 0;
-	u8 cap;
-
-	if (dev->fc_autoneg)
-		cap = mii_resolve_flowctrl_fdx(lcladv, rmtadv);
-	else
-		cap = dev->fc_request_control;
-
-	if (cap & FLOW_CTRL_TX)
-		flow |= (FLOW_CR_TX_FCEN_ | 0xFFFF);
-
-	if (cap & FLOW_CTRL_RX)
-		flow |= FLOW_CR_RX_FCEN_;
-
-	if (dev->udev->speed == USB_SPEED_SUPER)
-		fct_flow = FLOW_CTRL_THRESHOLD(FLOW_ON_SS, FLOW_OFF_SS);
-	else if (dev->udev->speed == USB_SPEED_HIGH)
-		fct_flow = FLOW_CTRL_THRESHOLD(FLOW_ON_HS, FLOW_OFF_HS);
-
-	netif_dbg(dev, link, dev->net, "rx pause %s, tx pause %s",
-		  (cap & FLOW_CTRL_RX ? "enabled" : "disabled"),
-		  (cap & FLOW_CTRL_TX ? "enabled" : "disabled"));
-
-	lan78xx_write_reg(dev, FCT_FLOW, fct_flow);
-
-	/* threshold value should be set before enabling flow */
-	lan78xx_write_reg(dev, FLOW, flow);
-
-	return 0;
-}
-
 static void lan78xx_rx_urb_submit_all(struct lan78xx_net *dev);
 
 static int lan78xx_mac_reset(struct lan78xx_net *dev)
@@ -1636,99 +1606,10 @@ static int lan78xx_mac_reset(struct lan78xx_net *dev)
 	return ret;
 }
 
-static int lan78xx_link_reset(struct lan78xx_net *dev)
+static int lan78xx_phy_int_ack(struct lan78xx_net *dev)
 {
-	struct phy_device *phydev = dev->net->phydev;
-	struct ethtool_link_ksettings ecmd;
-	int ladv, radv, ret, link;
-	u32 buf;
-
 	/* clear LAN78xx interrupt status */
-	ret = lan78xx_write_reg(dev, INT_STS, INT_STS_PHY_INT_);
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
-		del_timer(&dev->stat_monitor);
-	} else if (link && !dev->link_on) {
-		dev->link_on = true;
-
-		phy_ethtool_ksettings_get(phydev, &ecmd);
-
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
+	return lan78xx_write_reg(dev, INT_STS, INT_STS_PHY_INT_);
 }
 
 /* some work can't be done in tasklets, so we use keventd
@@ -1757,7 +1638,7 @@ static void lan78xx_status(struct lan78xx_net *dev, struct urb *urb)
 
 	if (intdata & INT_ENP_PHY_INT) {
 		netif_dbg(dev, link, dev->net, "PHY INTR: 0x%08x\n", intdata);
-		lan78xx_defer_kevent(dev, EVENT_LINK_RESET);
+		lan78xx_defer_kevent(dev, EVENT_PHY_INT_ACK);
 
 		if (dev->domain_data.phyirq > 0)
 			generic_handle_irq_safe(dev->domain_data.phyirq);
@@ -2356,26 +2237,6 @@ static void lan78xx_remove_mdio(struct lan78xx_net *dev)
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
@@ -2508,6 +2369,207 @@ static void lan78xx_remove_irq_domain(struct lan78xx_net *dev)
 	dev->domain_data.irqdomain = NULL;
 }
 
+static void lan78xx_mac_config(struct phylink_config *config, unsigned int mode,
+			       const struct phylink_link_state *state)
+{
+	struct net_device *net = to_net_dev(config->dev);
+	struct lan78xx_net *dev = netdev_priv(net);
+	u32 rgmii_id = 0;
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
+	case PHY_INTERFACE_MODE_INTERNAL:
+	case PHY_INTERFACE_MODE_GMII:
+			mac_cr |= MAC_CR_GMII_EN_;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		break;
+	default:
+		netdev_warn(net, "Unsupported interface mode: %d\n",
+			    state->interface);
+		return;
+	}
+
+	/* by the way, make sure auto speed and duplex are disabled */
+	ret = lan78xx_update_reg(dev, MAC_CR, MAC_CR_AUTO_DUPLEX_ |
+				 MAC_CR_AUTO_SPEED_ | MAC_CR_GMII_EN_, mac_cr);
+	if (ret < 0)
+		goto mac_config_fail;
+
+	ret = lan78xx_write_reg(dev, MAC_RGMII_ID, rgmii_id);
+	if (ret < 0)
+		goto mac_config_fail;
+
+	return;
+
+mac_config_fail:
+	netdev_err(net, "Failed to config MAC with error %pe\n", ERR_PTR(ret));
+}
+
+static void lan78xx_mac_link_down(struct phylink_config *config,
+				  unsigned int mode, phy_interface_t interface)
+{
+	struct net_device *net = to_net_dev(config->dev);
+	struct lan78xx_net *dev = netdev_priv(net);
+	int ret;
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
+static int lan78xx_configure_usb(struct lan78xx_net *dev, int speed)
+{
+	int ret;
+
+	if (dev->udev->speed != USB_SPEED_SUPER)
+		return 0;
+
+	if (speed != SPEED_1000)
+		return lan78xx_update_reg(dev, USB_CFG1,
+					  USB_CFG1_DEV_U2_INIT_EN_ |
+					  USB_CFG1_DEV_U1_INIT_EN_,
+					  USB_CFG1_DEV_U2_INIT_EN_ |
+					  USB_CFG1_DEV_U1_INIT_EN_);
+
+	/* disable U2 */
+	ret = lan78xx_update_reg(dev, USB_CFG1,
+				 USB_CFG1_DEV_U2_INIT_EN_, 0);
+	if (ret < 0)
+		return ret;
+	/* enable U1 */
+	return lan78xx_update_reg(dev, USB_CFG1,
+				  USB_CFG1_DEV_U1_INIT_EN_,
+				  USB_CFG1_DEV_U1_INIT_EN_);
+}
+
+static int lan78xx_configure_flowcontrol(struct lan78xx_net *dev,
+					 bool tx_pause, bool rx_pause)
+{
+	u32 flow = 0, fct_flow = 0;
+	int ret;
+
+	if (tx_pause)
+		flow |= (FLOW_CR_TX_FCEN_ | 0xFFFF);
+
+	if (rx_pause)
+		flow |= FLOW_CR_RX_FCEN_;
+
+	if (dev->udev->speed == USB_SPEED_SUPER)
+		fct_flow = FLOW_CTRL_THRESHOLD(FLOW_ON_SS, FLOW_OFF_SS);
+	else if (dev->udev->speed == USB_SPEED_HIGH)
+		fct_flow = FLOW_CTRL_THRESHOLD(FLOW_ON_HS, FLOW_OFF_HS);
+
+	ret = lan78xx_write_reg(dev, FCT_FLOW, fct_flow);
+	if (ret < 0)
+		return ret;
+
+	/* threshold value should be set before enabling flow */
+	return lan78xx_write_reg(dev, FLOW, flow);
+}
+
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
+	return;
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
 static struct phy_device *lan7801_phy_init(struct lan78xx_net *dev)
 {
 	u32 buf;
@@ -2528,7 +2590,7 @@ static struct phy_device *lan7801_phy_init(struct lan78xx_net *dev)
 			return NULL;
 		}
 		netdev_dbg(dev->net, "Registered FIXED PHY\n");
-		dev->interface = PHY_INTERFACE_MODE_RGMII;
+		phydev->interface = PHY_INTERFACE_MODE_RGMII;
 		ret = lan78xx_write_reg(dev, MAC_RGMII_ID,
 					MAC_RGMII_ID_TXC_DELAY_EN_);
 		ret = lan78xx_write_reg(dev, RGMII_TX_BYP_DLL, 0x3D00);
@@ -2541,7 +2603,7 @@ static struct phy_device *lan7801_phy_init(struct lan78xx_net *dev)
 			netdev_err(dev->net, "no PHY driver found\n");
 			return NULL;
 		}
-		dev->interface = PHY_INTERFACE_MODE_RGMII_ID;
+		phydev->interface = PHY_INTERFACE_MODE_RGMII_ID;
 		/* The PHY driver is responsible to configure proper RGMII
 		 * interface delays. Disable RGMII delays on MAC side.
 		 */
@@ -2552,12 +2614,47 @@ static struct phy_device *lan7801_phy_init(struct lan78xx_net *dev)
 	return phydev;
 }
 
+static int lan78xx_phylink_setup(struct lan78xx_net *dev)
+{
+	phy_interface_t link_interface;
+	struct phylink *phylink;
+
+	dev->phylink_config.dev = &dev->net->dev;
+	dev->phylink_config.type = PHYLINK_NETDEV;
+	dev->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
+		MAC_10 | MAC_100 | MAC_1000FD;
+	dev->phylink_config.mac_managed_pm = true;
+
+	if (dev->chipid == ID_REV_CHIP_ID_7801_) {
+		__set_bit(PHY_INTERFACE_MODE_RGMII,
+			  dev->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_RGMII_ID,
+			  dev->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_RGMII_RXID,
+			  dev->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_RGMII_TXID,
+			  dev->phylink_config.supported_interfaces);
+		link_interface = PHY_INTERFACE_MODE_NA;
+	} else {
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  dev->phylink_config.supported_interfaces);
+		link_interface = PHY_INTERFACE_MODE_INTERNAL;
+	}
+
+	phylink = phylink_create(&dev->phylink_config, dev->net->dev.fwnode,
+				 link_interface, &lan78xx_phylink_mac_ops);
+	if (IS_ERR(phylink))
+		return PTR_ERR(phylink);
+
+	dev->phylink = phylink;
+
+	return 0;
+}
+
 static int lan78xx_phy_init(struct lan78xx_net *dev)
 {
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(fc) = { 0, };
-	int ret;
-	u32 mii_adv;
 	struct phy_device *phydev;
+	int ret;
 
 	switch (dev->chipid) {
 	case ID_REV_CHIP_ID_7801_:
@@ -2576,7 +2673,7 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 			return -EIO;
 		}
 		phydev->is_internal = true;
-		dev->interface = PHY_INTERFACE_MODE_GMII;
+		phydev->interface = PHY_INTERFACE_MODE_INTERNAL;
 		break;
 
 	default:
@@ -2591,12 +2688,7 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
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
 		netdev_err(dev->net, "can't attach PHY to %s\n",
 			   dev->mdiobus->id);
@@ -2609,18 +2701,7 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 		return -EIO;
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
+	phy_suspend(phydev);
 
 	phy_support_eee(phydev);
 
@@ -2646,10 +2727,6 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 		}
 	}
 
-	genphy_config_aneg(phydev);
-
-	dev->fc_autoneg = phydev->autoneg;
-
 	return 0;
 }
 
@@ -2989,7 +3066,6 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 	unsigned long timeout;
 	int ret;
 	u32 buf;
-	u8 sig;
 
 	ret = lan78xx_read_reg(dev, HW_CFG, &buf);
 	if (ret < 0)
@@ -3146,22 +3222,12 @@ static int lan78xx_reset(struct lan78xx_net *dev)
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
@@ -3211,9 +3277,11 @@ static int lan78xx_open(struct net_device *net)
 
 	mutex_lock(&dev->dev_mutex);
 
-	phy_start(net->phydev);
+	lan78xx_init_stats(dev);
 
-	netif_dbg(dev, ifup, dev->net, "phy initialised successfully");
+	napi_enable(&dev->napi);
+
+	set_bit(EVENT_DEV_OPEN, &dev->flags);
 
 	/* for Link Check */
 	if (dev->urb_intr) {
@@ -3225,31 +3293,9 @@ static int lan78xx_open(struct net_device *net)
 		}
 	}
 
-	ret = lan78xx_flush_rx_fifo(dev);
-	if (ret < 0)
-		goto done;
-	ret = lan78xx_flush_tx_fifo(dev);
-	if (ret < 0)
-		goto done;
-
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
+	phylink_start(dev->phylink);
 
 	netif_start_queue(net);
-
-	dev->link_on = false;
-
-	napi_enable(&dev->napi);
-
-	lan78xx_defer_kevent(dev, EVENT_LINK_RESET);
 done:
 	mutex_unlock(&dev->dev_mutex);
 
@@ -3317,12 +3363,7 @@ static int lan78xx_stop(struct net_device *net)
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
 
@@ -3332,7 +3373,7 @@ static int lan78xx_stop(struct net_device *net)
 	 */
 	clear_bit(EVENT_TX_HALT, &dev->flags);
 	clear_bit(EVENT_RX_HALT, &dev->flags);
-	clear_bit(EVENT_LINK_RESET, &dev->flags);
+	clear_bit(EVENT_PHY_INT_ACK, &dev->flags);
 	clear_bit(EVENT_STAT_UPDATE, &dev->flags);
 
 	cancel_delayed_work_sync(&dev->wq);
@@ -4256,13 +4297,13 @@ static void lan78xx_delayedwork(struct work_struct *work)
 		}
 	}
 
-	if (test_bit(EVENT_LINK_RESET, &dev->flags)) {
+	if (test_bit(EVENT_PHY_INT_ACK, &dev->flags)) {
 		int ret = 0;
 
-		clear_bit(EVENT_LINK_RESET, &dev->flags);
-		if (lan78xx_link_reset(dev) < 0) {
-			netdev_info(dev->net, "link reset failed (%d)\n",
-				    ret);
+		clear_bit(EVENT_PHY_INT_ACK, &dev->flags);
+		if (lan78xx_phy_int_ack(dev) < 0) {
+			netdev_info(dev->net, "PHY INT ack failed (%pe)\n",
+				    ERR_PTR(ret));
 		}
 	}
 
@@ -4344,26 +4385,29 @@ static void lan78xx_disconnect(struct usb_interface *intf)
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
 	if (phy_is_pseudo_fixed_link(phydev)) {
 		fixed_phy_unregister(phydev);
 		phy_device_free(phydev);
 	}
 
+	phylink_destroy(dev->phylink);
+
 	usb_scuttle_anchored_urbs(&dev->deferred);
 
 	lan78xx_unbind(dev, intf);
@@ -4446,7 +4490,6 @@ static int lan78xx_probe(struct usb_interface *intf,
 		goto out1;
 	}
 
-	/* netdev_printk() needs this */
 	SET_NETDEV_DEV(netdev, &intf->dev);
 
 	dev = netdev_priv(netdev);
@@ -4558,14 +4601,18 @@ static int lan78xx_probe(struct usb_interface *intf,
 	/* driver requires remote-wakeup capability during autosuspend. */
 	intf->needs_remote_wakeup = 1;
 
-	ret = lan78xx_phy_init(dev);
+	ret = lan78xx_phylink_setup(dev);
 	if (ret < 0)
 		goto free_urbs;
 
+	ret = lan78xx_phy_init(dev);
+	if (ret < 0)
+		goto destroy_phylink;
+
 	ret = register_netdev(netdev);
 	if (ret != 0) {
 		netif_err(dev, probe, netdev, "couldn't register the device\n");
-		goto out8;
+		goto disconnect_phy;
 	}
 
 	usb_set_intfdata(intf, dev);
@@ -4580,8 +4627,10 @@ static int lan78xx_probe(struct usb_interface *intf,
 
 	return 0;
 
-out8:
-	phy_disconnect(netdev->phydev);
+disconnect_phy:
+	phylink_disconnect_phy(dev->phylink);
+destroy_phylink:
+	phylink_destroy(dev->phylink);
 free_urbs:
 	usb_free_urb(dev->urb_intr);
 out5:
@@ -5143,7 +5192,7 @@ static int lan78xx_reset_resume(struct usb_interface *intf)
 	if (ret < 0)
 		return ret;
 
-	phy_start(dev->net->phydev);
+	phylink_start(dev->phylink);
 
 	ret = lan78xx_resume(intf);
 
-- 
2.39.5


