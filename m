Return-Path: <netdev+bounces-153791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B47439F9AFF
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 21:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D67216DCE1
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 20:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2B72288CA;
	Fri, 20 Dec 2024 20:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YXJ9UYo+"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90485225A37;
	Fri, 20 Dec 2024 20:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734725725; cv=none; b=E1E82XM7xAzX+XPGB9di3u+oaxzyXF2E/fMPbLpB1QWyMRogjNhFreMBELq6zCrhnLRa491HQ79puHo1p6CRBScz5+4ENlQzSq3ppEaEu+Ixb7uM/jcpQ+fLHTzKMBqa6C8JpHIw4GGXDDTYUUvoT3vKJm5h48mlq/yMK3hSFqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734725725; c=relaxed/simple;
	bh=OwMfRKpQaZk7+/bq5MsHsFIk4suqIOo8LVlC8v8tAFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jstmJZM/ioj11LajrxXlGNrpmg/3BDGcWG+C1BH4Mb7hjXJmJAMdJFn9y+PCkaENFQ4e1n4zpIO5FoIdvWqJhuW9gW0eb027AjcdiNdB6k6cad3+TM32R/dhVvf5SX4E3qFhGfEKc1B4RP95z2tKh/83CSwmCsluTy8irHr5guE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YXJ9UYo+; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1CCD0E0009;
	Fri, 20 Dec 2024 20:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734725715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=teBga0eoj2IKH/aL1zsdF4SPoBrfkShMhDS6JHNY2aA=;
	b=YXJ9UYo+Z8jdtrgqQ20D/D4UN3Fl68c3psqDr4TmmOrFt9GctDXdWMIZknAos7PD19fr/F
	00wpa5nppAiD5myfvDw59slpM4bijL9fmJYXbG5oyYOykqA/MkC4dljDpKu4k+u0JIiu0S
	JmvrFMxIpFO7v+8zUe/IPHV3ZT6M/j2JGNqE8yQrJ+Vxcar/1GmDUHX2ZdwkJ7tcsDitii
	bqgJBgAXx2eU/1asWuP6W4TvbSRJxHrJ5teeOppU0rXfJDAFS1yW4NfU8jCCKimZO+XF9y
	Fa5Z/oJn3KUFeQ1DTwrrQbEXdIlL9DF5EqoDcNtbIMv3Gom8Ubbj5q42TnJ8Ag==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Antoine Tenart <atenart@kernel.org>
Subject: [PATCH net-next RFC 4/5] net: phy: Introduce PHY ports representation
Date: Fri, 20 Dec 2024 21:15:03 +0100
Message-ID: <20241220201506.2791940-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220201506.2791940-1-maxime.chevallier@bootlin.com>
References: <20241220201506.2791940-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Ethernet provides a wide variety of layer 1 protocols and standards for
data transmission. The front-facing ports of an interface have their own
complexity and configurability.

Introduce a representation of these front-facing ports. The current code
is minimalistic and only support ports controlled by PHY devices, but
the plan is to extend that to SFP as well as raw Ethernet MACs that
don't use PHY devices.

This minimal port representation allows describing the media and number
of lanes of a port. From that information, we can derive the linkmodes
usable on the port, which can be used to limit the capabilities of an
interface.

For now, the port lanes and medium is derived from devicetree, defined
by the PHY driver, or populated with default values (as we assume that
all PHYs expose at least one port).

The typical example is 100M ethernet. 100BaseT can work using only 2
lanes on a Cat 5 cables. However, in the situation where a 10/100/1000
capable PHY is wired to its RJ45 port through 2 lanes only, we have no
way of detecting that. The "max-speed" DT property can be used, but a
more accurate representation can be used :

mdi {
	port@0 {
		media = "BaseT";
		lanes = <2>;
	};
};

From that information, we can derive the max speed reachable on the
port.

Another benefit of having that is to avoid vendor-specific DT properties
(micrel,fiber-mode or ti,fiber-mode).

This basic representation is meant to be expanded, by the introduction
of port ops, userspace listing of ports, and support for multi-port
devices.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/Makefile     |   2 +-
 drivers/net/phy/phy_device.c | 167 +++++++++++++++++++++++++++++++++++
 drivers/net/phy/phy_port.c   | 159 +++++++++++++++++++++++++++++++++
 include/linux/ethtool.h      |   4 +
 include/linux/phy.h          |  31 +++++++
 include/linux/phy_port.h     |  69 +++++++++++++++
 6 files changed, 431 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/phy_port.c
 create mode 100644 include/linux/phy_port.h

diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index e6145153e837..1e324d3ad839 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -2,7 +2,7 @@
 # Makefile for Linux PHY drivers
 
 libphy-y			:= phy.o phy-c45.o phy-core.o phy_device.o \
-				   linkmode.o phy_link_topology.o
+				   linkmode.o phy_link_topology.o phy_port.o
 mdio-bus-y			+= mdio_bus.o mdio_device.o
 
 ifdef CONFIG_MDIO_DEVICE
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 928dc3c509b6..42cce18970e2 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -706,6 +706,13 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
 
 	dev->state = PHY_DOWN;
 	INIT_LIST_HEAD(&dev->leds);
+	INIT_LIST_HEAD(&dev->ports);
+
+	/* The driver's probe function must change that to the real number
+	 * of ports possible on the PHY. We assume by default we are dealing
+	 * with a single-port PHY
+	 */
+	dev->max_n_ports = 1;
 
 	mutex_init(&dev->lock);
 	INIT_DELAYED_WORK(&dev->state_queue, phy_state_machine);
@@ -3454,6 +3461,159 @@ static int of_phy_leds(struct phy_device *phydev)
 	return 0;
 }
 
+static int phy_add_port(struct phy_device *phydev, struct phy_port *port)
+{
+	int ret = 0;
+
+	if (phydev->n_ports == phydev->max_n_ports)
+		return -EBUSY;
+
+	/* We set all ports as active by default, PHY drivers may deactivate
+	 * them (when unused)
+	 */
+	port->active = true;
+
+	if (phydev->drv && phydev->drv->attach_port)
+		ret = phydev->drv->attach_port(phydev, port);
+
+	if (ret)
+		return ret;
+
+	/* The PHY driver might have added, removed or set medium/lanes info,
+	 * so update the port supported accordingly.
+	 */
+	phy_port_update_supported(port);
+
+	list_add(&port->head, &phydev->ports);
+
+	phydev->n_ports++;
+
+	return 0;
+}
+
+static void phy_del_port(struct phy_device *phydev, struct phy_port *port)
+{
+	if (!phydev->n_ports)
+		return;
+
+	list_del(&port->head);
+
+	phydev->n_ports--;
+}
+
+static void phy_cleanup_ports(struct phy_device *phydev)
+{
+	struct phy_port *tmp, *port;
+
+	list_for_each_entry_safe(port, tmp, &phydev->ports, head) {
+		phy_del_port(phydev, port);
+		phy_port_destroy(port);
+	}
+}
+
+static int phy_default_setup_single_port(struct phy_device *phydev)
+{
+	struct phy_port *port = phy_port_alloc();
+
+	if (!port)
+		return -ENOMEM;
+
+	port->parent_type = PHY_PORT_PHY;
+	port->phy = phydev;
+	linkmode_copy(port->supported, phydev->supported);
+
+	/* default medium is copper */
+	if (!port->mediums)
+		port->mediums |= BIT(ETHTOOL_LINK_MEDIUM_BASET);
+
+	phy_add_port(phydev, port);
+
+	return 0;
+}
+
+static int of_phy_ports(struct phy_device *phydev)
+{
+	struct device_node *node = phydev->mdio.dev.of_node;
+	struct device_node *mdi;
+	struct phy_port *port;
+	int err;
+
+	if (!IS_ENABLED(CONFIG_OF_MDIO))
+		return 0;
+
+	if (!node)
+		return 0;
+
+	mdi = of_get_child_by_name(node, "mdi");
+	if (!mdi)
+		return 0;
+
+	for_each_available_child_of_node_scoped(mdi, port_node) {
+		port = phy_of_parse_port(port_node);
+		if (IS_ERR(port)) {
+			err = PTR_ERR(port);
+			goto out_err;
+		}
+
+		port->parent_type = PHY_PORT_PHY;
+		port->phy = phydev;
+		err = phy_add_port(phydev, port);
+		if (err)
+			goto out_err;
+	}
+	of_node_put(mdi);
+
+	return 0;
+
+out_err:
+	phy_cleanup_ports(phydev);
+	of_node_put(mdi);
+	return err;
+}
+
+static int phy_setup_ports(struct phy_device *phydev)
+{
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(ports_supported);
+	struct phy_port *port;
+	int ret;
+
+	ret = of_phy_ports(phydev);
+	if (ret)
+		return ret;
+
+	if (phydev->n_ports < phydev->max_n_ports) {
+		ret = phy_default_setup_single_port(phydev);
+		if (ret)
+			goto out;
+	}
+
+	linkmode_zero(ports_supported);
+
+	/* Aggregate the supported modes, which are made-up of :
+	 *  - What the PHY itself supports
+	 *  - What the sum of all ports support
+	 */
+	list_for_each_entry(port, &phydev->ports, head)
+		if (port->active)
+			linkmode_or(ports_supported, ports_supported,
+				    port->supported);
+
+	if (!linkmode_empty(ports_supported))
+		linkmode_and(phydev->supported, phydev->supported,
+			     ports_supported);
+
+	/* For now, the phy->port field is set as the first active port's type */
+	list_for_each_entry(port, &phydev->ports, head)
+		if (port->active)
+			phydev->port = phy_port_get_type(port);
+
+	return 0;
+
+out:
+	phy_cleanup_ports(phydev);
+	return ret;
+}
+
 /**
  * fwnode_mdio_find_device - Given a fwnode, find the mdio_device
  * @fwnode: pointer to the mdio_device's fwnode
@@ -3603,6 +3763,11 @@ static int phy_probe(struct device *dev)
 		phydev->is_gigabit_capable = 1;
 
 	of_set_phy_supported(phydev);
+
+	err = phy_setup_ports(phydev);
+	if (err)
+		goto out;
+
 	phy_advertise_supported(phydev);
 
 	/* Get PHY default EEE advertising modes and handle them as potentially
@@ -3679,6 +3844,8 @@ static int phy_remove(struct device *dev)
 
 	phydev->state = PHY_DOWN;
 
+	phy_cleanup_ports(phydev);
+
 	sfp_bus_del_upstream(phydev->sfp_bus);
 	phydev->sfp_bus = NULL;
 
diff --git a/drivers/net/phy/phy_port.c b/drivers/net/phy/phy_port.c
new file mode 100644
index 000000000000..d89c572623d7
--- /dev/null
+++ b/drivers/net/phy/phy_port.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Framework to drive Ethernet ports
+ *
+ * Copyright (c) 2024 Maxime Chevallier <maxime.chevallier@bootlin.com>
+ */
+
+#include <linux/linkmode.h>
+#include <linux/of.h>
+#include <linux/phy_port.h>
+
+/**
+ * phy_port_alloc: Allocate a new phy_port
+ *
+ * Returns a newly allocated struct phy_port, or NULL.
+ */
+struct phy_port *phy_port_alloc(void)
+{
+	struct phy_port *port;
+
+	port = kzalloc(sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return NULL;
+
+	linkmode_zero(port->supported);
+	INIT_LIST_HEAD(&port->head);
+
+	return port;
+}
+EXPORT_SYMBOL_GPL(phy_port_alloc);
+
+/**
+ * phy_port_destroy: Free a struct phy_port
+ */
+void phy_port_destroy(struct phy_port *port)
+{
+	kfree(port);
+}
+EXPORT_SYMBOL_GPL(phy_port_destroy);
+
+static void ethtool_medium_get_supported(unsigned long *supported,
+					 enum ethtool_link_medium medium,
+					 int lanes)
+{
+	int i;
+
+	for (i = 0; i < __ETHTOOL_LINK_MODE_MASK_NBITS; i++) {
+		/* Special bits such as Autoneg, Pause, Asym_pause, etc. are
+		 * set and will be masked away by the port parent.
+		 */
+		if (link_mode_params[i].medium == ETHTOOL_LINK_MEDIUM_NONE) {
+			linkmode_set_bit(i, supported);
+			continue;
+		}
+
+		/* For most cases, min_lanes == lanes, except for 10/100BaseT that work
+		 * on 2 lanes but are compatible with 4 lanes mediums
+		 */
+		if (link_mode_params[i].medium == medium &&
+		    link_mode_params[i].lanes >= lanes &&
+		    link_mode_params[i].min_lanes <= lanes) {
+			linkmode_set_bit(i, supported);
+		}
+	}
+}
+
+static enum ethtool_link_medium ethtool_str_to_medium(const char *str)
+{
+	int i;
+
+	for (i = 0; i < __ETHTOOL_LINK_MEDIUM_LAST; i++)
+		if (!strcmp(phy_mediums(i), str))
+			return i;
+
+	return ETHTOOL_LINK_MEDIUM_NONE;
+}
+
+/**
+ * phy_of_parse_port: Create a phy_port from a firmware representation
+ *
+ * Returns a newly allocated and initialized phy_port pointer, or an ERR_PTR.
+ */
+struct phy_port *phy_of_parse_port(struct device_node *dn)
+{
+	struct fwnode_handle *fwnode = of_fwnode_handle(dn);
+	enum ethtool_link_medium medium;
+	struct phy_port *port;
+	struct property *prop;
+	const char *med_str;
+	u32 lanes, mediums = 0;
+	int ret;
+
+	ret = fwnode_property_read_u32(fwnode, "lanes", &lanes);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = fwnode_property_read_string(fwnode, "media", &med_str);
+	if (ret)
+		return ERR_PTR(ret);
+
+	of_property_for_each_string(to_of_node(fwnode), "media", prop, med_str) {
+		medium = ethtool_str_to_medium(med_str);
+		if (medium == ETHTOOL_LINK_MEDIUM_NONE)
+			return ERR_PTR(-EINVAL);
+
+		mediums |= BIT(medium);
+	}
+
+	if (!mediums)
+		return ERR_PTR(-EINVAL);
+
+	port = phy_port_alloc();
+	if (!port)
+		return ERR_PTR(-ENOMEM);
+
+	port->lanes = lanes;
+	port->mediums = mediums;
+
+	return port;
+}
+EXPORT_SYMBOL_GPL(phy_of_parse_port);
+
+/**
+ * phy_port_update_supported: Setup the port->supported field
+ * port: the port to update
+ *
+ * Once the port's medium list and number of lanes has been configured based
+ * on firmware, straps and vendor-specific properties, this function may be
+ * called to update the port's supported linkmodes list.
+ *
+ * Any mode that was manually set in the port's supported list remains set.
+ */
+void phy_port_update_supported(struct phy_port *port)
+{
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported);
+	int i;
+
+	for_each_set_bit(i, &port->mediums, __ETHTOOL_LINK_MEDIUM_LAST) {
+		linkmode_zero(supported);
+		ethtool_medium_get_supported(supported, i, port->lanes);
+		linkmode_or(port->supported, port->supported, supported);
+	}
+}
+EXPORT_SYMBOL_GPL(phy_port_update_supported);
+
+/**
+ * phy_port_get_type: get the PORT_* attribut for that port.
+ */
+int phy_port_get_type(struct phy_port *port)
+{
+	if (port->mediums & ETHTOOL_LINK_MEDIUM_BASET)
+		return PORT_TP;
+
+	if (phy_port_is_fiber(port) ||
+	    (port->mediums & BIT(ETHTOOL_LINK_MEDIUM_BASEX)))
+		return PORT_FIBRE;
+
+	return PORT_OTHER;
+}
+EXPORT_SYMBOL_GPL(phy_port_get_type);
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 51d110dfa8ef..fdb47cfd8c79 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -220,6 +220,10 @@ enum ethtool_link_medium {
 	__ETHTOOL_LINK_MEDIUM_LAST,
 };
 
+#define ETHTOOL_MEDIUM_FIBER_BITS (BIT(ETHTOOL_LINK_MEDIUM_BASES) | \
+				   BIT(ETHTOOL_LINK_MEDIUM_BASEL) | \
+				   BIT(ETHTOOL_LINK_MEDIUM_BASEF))
+
 static inline const char *phy_mediums(enum ethtool_link_medium medium)
 {
 	switch (medium) {
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 5bc71d59910c..14ba3eca7382 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -21,6 +21,7 @@
 #include <linux/mii.h>
 #include <linux/mii_timestamper.h>
 #include <linux/module.h>
+#include <linux/phy_port.h>
 #include <linux/timer.h>
 #include <linux/workqueue.h>
 #include <linux/mod_devicetable.h>
@@ -660,6 +661,9 @@ struct macsec_ops;
  * @master_slave_state: Current master/slave configuration
  * @mii_ts: Pointer to time stamper callbacks
  * @psec: Pointer to Power Sourcing Equipment control struct
+ * @ports: List of PHY ports structures
+ * n_ports: Number of ports currently attached to the PHY
+ * @max_n_ports: Max number of ports this PHY can expose
  * @lock:  Mutex for serialization access to PHY
  * @state_queue: Work queue for state machine
  * @link_down_events: Number of times link was lost
@@ -752,6 +756,7 @@ struct phy_device {
 
 	/* Host supported PHY interface types. Should be ignored if empty. */
 	DECLARE_PHY_INTERFACE_MASK(host_interfaces);
+	DECLARE_PHY_INTERFACE_MASK(sfp_bus_interfaces);
 
 #ifdef CONFIG_LED_TRIGGER_PHY
 	struct phy_led_trigger *phy_led_triggers;
@@ -794,6 +799,10 @@ struct phy_device {
 	struct mii_timestamper *mii_ts;
 	struct pse_control *psec;
 
+	struct list_head ports;
+	int n_ports;
+	int max_n_ports;
+
 	u8 mdix;
 	u8 mdix_ctrl;
 
@@ -1244,6 +1253,27 @@ struct phy_driver {
 	 */
 	int (*led_polarity_set)(struct phy_device *dev, int index,
 				unsigned long modes);
+
+	/**
+	 * @attach_port: Indicates to the PHY driver that a port is detected
+	 * @dev: PHY device to notify
+	 * @port: The port being added
+	 *
+	 * Called when a port that needs to be driven by the PHY is found. The
+	 * number of time this will be called depends on phydev->max_n_ports,
+	 * which the driver can change in .probe().
+	 *
+	 * The port that is being passed may or may not be initialized. If it is
+	 * already initialized, it is by the generic port representation from
+	 * devicetree, which superseeds any strapping or vendor-specific
+	 * properties.
+	 *
+	 * If the port isn't initialized, the port->mediums and port->lanes
+	 * fields must be set, possibly according to stapping information.
+	 *
+	 * Returns 0, or an error code.
+	 */
+	int (*attach_port)(struct phy_device *dev, struct phy_port *port);
 };
 #define to_phy_driver(d) container_of_const(to_mdio_common_driver(d),		\
 				      struct phy_driver, mdiodrv)
@@ -2051,6 +2081,7 @@ void phy_trigger_machine(struct phy_device *phydev);
 void phy_mac_interrupt(struct phy_device *phydev);
 void phy_start_machine(struct phy_device *phydev);
 void phy_stop_machine(struct phy_device *phydev);
+
 void phy_ethtool_ksettings_get(struct phy_device *phydev,
 			       struct ethtool_link_ksettings *cmd);
 int phy_ethtool_ksettings_set(struct phy_device *phydev,
diff --git a/include/linux/phy_port.h b/include/linux/phy_port.h
new file mode 100644
index 000000000000..b34c15523adc
--- /dev/null
+++ b/include/linux/phy_port.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <linux/ethtool.h>
+#include <linux/types.h>
+
+#ifndef __PHY_PORT_H
+#define __PHY_PORT_H
+
+struct phy_port;
+
+/**
+ * enum phy_port_parent - The device this port is attached to
+ *
+ * @PHY_PORT_PHY: Indicates that the port is driven by a PHY device
+ */
+enum phy_port_parent {
+	PHY_PORT_PHY,
+};
+
+/**
+ * struct phy_port - A representation of a network device physical interface
+ *
+ * @head: Used by the port's parent to list ports
+ * @parent_type: The type of device this port is directly connected to
+ * @phy: If the parent is PHY_PORT_PHYDEV, the PHY controlling that port
+ * @lanes: The number of lanes (diff pairs) this port has, 0 if not applicable
+ * @medium: The physical medium this port provides access to
+ * @supported: The link modes this port can expose
+ * @active: Indicates if the port is currently part of the active link.
+ */
+struct phy_port {
+	struct list_head head;
+	enum phy_port_parent parent_type;
+	union {
+		struct phy_device *phy;
+	};
+
+	int lanes;
+	unsigned long mediums;
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported);
+
+	bool active;
+};
+
+struct phy_port *phy_port_alloc(void);
+void phy_port_destroy(struct phy_port *port);
+
+static inline struct phy_device *port_phydev(struct phy_port *port)
+{
+	return port->phy;
+}
+
+struct phy_port *phy_of_parse_port(struct device_node *dn);
+
+static inline bool phy_port_is_copper(struct phy_port *port)
+{
+	return port->mediums == BIT(ETHTOOL_LINK_MEDIUM_BASET);
+}
+
+static inline bool phy_port_is_fiber(struct phy_port *port)
+{
+	return !!(port->mediums & ETHTOOL_MEDIUM_FIBER_BITS);
+}
+
+void phy_port_update_supported(struct phy_port *port);
+
+int phy_port_get_type(struct phy_port *port);
+
+#endif
-- 
2.47.1


