Return-Path: <netdev+bounces-287602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMk8BpKFBGrVKwIAu9opvQ
	(envelope-from <netdev+bounces-287602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 16:07:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCFD534AFE
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 16:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46DA8323C75D
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 13:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C2C2868A9;
	Wed, 13 May 2026 13:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NDng7bxU"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6332840B6C4
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 13:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677548; cv=none; b=mQfm/n5bJINTVYP+cggtgGVtpHWNXU4GX+jNwf+lmLxtr60oLB9XzCcwr21Qvbl11S/pI6nyDZGed2GJ0ci0CfZmVKsssyczGfGRTjUQPdhykxW6eKoxZboHMYDGEJRSAfNEguUaaYfbAuh14Tb7wltCFov74zsB99DIDkt+zd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677548; c=relaxed/simple;
	bh=3ufzLCgBXsMWcaOwhVA8HNhFuxdtplQmonHBDjoBits=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a53OJQkCMD0pMoozlGdBrkvXTRUQJYq66epY9JX1rpsOZEjMh9CQ4GHtACe/OgqlyMhAKOaUZPXBR9eKAV73XrkFvtzDJMlwYUzAoa70oK3GHjZl1WYmWEHYChW8YRFca7fGhu14UNx7oqlXYIy7jNlpLFK7nLlMOSrURUwe8tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NDng7bxU; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 91B5DC5DC59;
	Wed, 13 May 2026 13:06:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 227495FE21;
	Wed, 13 May 2026 13:05:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 21DE811AF9022;
	Wed, 13 May 2026 15:05:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778677543; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=jPxhlMrncMg4LubFLNH7Y+akI8X0nDkXdk+dzfrjf80=;
	b=NDng7bxUaNaKy/Gi4Yp1UPTcm40tfR0Wy/TXjqJbTbNxvHU71CbMaPUzY5kKfzn1bmxCq1
	D0n+koLyYs6o7vLlsxX+pSBmZJRLjyv8wF6oRkZ8HVr7z/wEtXpMe/PaHw3NbIHalDTRlx
	VloBs9WhEilGlrdtFO9rdB/yNUgew7oaLulI9IyaeG6+aVSsFWUDAQqqkE/7nrVDkXmb4N
	si4zVqPVMXTXAThTR0Vn6lAB80LNP1+RbAvu+4xn5CZmN1d8gtWwzbdgCzPVUsavaiBNBx
	I8UjKv4/S5qKLWOxL9jk2RObT3r1aZOJy0pXs/ymhGk5M0lOo0YsjuiQwd+1cg==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Frank Wunderlich <frank.wunderlich@linux.dev>
Subject: [PATCH net-next v10 5/9] net: phy: Represent PHY-less SFP modules with phy_port
Date: Wed, 13 May 2026 15:05:16 +0200
Message-ID: <20260513130521.1064094-6-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513130521.1064094-1-maxime.chevallier@bootlin.com>
References: <20260513130521.1064094-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 8FCFD534AFE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-287602-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Now that the SFP bus infrastructure notifies when PHY-less modules are
connected, we can create a phy_port to represent it. Instead of letting
the SFP subsystem handle that, the Bus' upstream is in charge of
maintaining that phy_port and register it to the topology, as the
upstream (in this case a phy device) is directly interacting with the
underlying net_device.

Add a phy_caps helper to get the achievable modes on this module based
on what the phy_port representing the bus supports.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy-caps.h   |   2 +
 drivers/net/phy/phy_caps.c   |  26 +++++++++
 drivers/net/phy/phy_device.c | 101 +++++++++++++++++++++++++++++++++--
 drivers/net/phy/phylink.c    |  76 ++++++++++++++++++++++++--
 include/linux/phy.h          |   6 +++
 5 files changed, 204 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/phy-caps.h b/drivers/net/phy/phy-caps.h
index 421088e6f6e8..ec3d39a0ae06 100644
--- a/drivers/net/phy/phy-caps.h
+++ b/drivers/net/phy/phy-caps.h
@@ -66,5 +66,7 @@ void phy_caps_medium_get_supported(unsigned long *supported,
 				   enum ethtool_link_medium medium,
 				   int lanes);
 u32 phy_caps_mediums_from_linkmodes(unsigned long *linkmodes);
+void phy_caps_linkmode_filter_ifaces(unsigned long *to, const unsigned long *from,
+				     const unsigned long *interfaces);
 
 #endif /* __PHY_CAPS_H */
diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
index 942d43191561..558e4df4d63c 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -445,3 +445,29 @@ u32 phy_caps_mediums_from_linkmodes(unsigned long *linkmodes)
 	return mediums;
 }
 EXPORT_SYMBOL_GPL(phy_caps_mediums_from_linkmodes);
+
+/**
+ * phy_caps_linkmode_filter_ifaces() - Filter linkmodes with an interface list
+ * @to: Stores the filtered linkmodes
+ * @from: Linkmodes to filter
+ * @interfaces: Bitfield of phy_interface_t that we use for filtering
+ *
+ * Filter the provided linkmodes, only to keep the ones we can possibly achieve
+ * when using any of the provided MII interfaces.
+ */
+void phy_caps_linkmode_filter_ifaces(unsigned long *to,
+				     const unsigned long *from,
+				     const unsigned long *interfaces)
+{
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(ifaces_supported) = {};
+	unsigned int ifaces_caps = 0;
+	phy_interface_t interface;
+
+	for_each_set_bit(interface, interfaces, PHY_INTERFACE_MODE_MAX)
+		ifaces_caps |= phy_caps_from_interface(interface);
+
+	phy_caps_linkmodes(ifaces_caps, ifaces_supported);
+
+	linkmode_and(to, from, ifaces_supported);
+}
+EXPORT_SYMBOL_GPL(phy_caps_linkmode_filter_ifaces);
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 301e9c365345..03bcaf5e5fe3 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1490,11 +1490,21 @@ static int phy_sfp_connect_phy(void *upstream, struct phy_device *phy)
 {
 	struct phy_device *phydev = upstream;
 	struct net_device *dev = phydev->attached_dev;
+	int ret;
 
-	if (dev)
-		return phy_link_topo_add_phy(dev, phy, PHY_UPSTREAM_PHY, phydev);
+	phydev->has_sfp_mod_phy = true;
 
-	return 0;
+	/* If we aren't attached to a netdev, we can't add the SFP PHY to its
+	 * topology.
+	 */
+	if (!dev)
+		return 0;
+
+	ret = phy_link_topo_add_phy(dev, phy, PHY_UPSTREAM_PHY, phydev);
+	if (ret)
+		phydev->has_sfp_mod_phy = false;
+
+	return ret;
 }
 
 /**
@@ -1512,6 +1522,8 @@ static void phy_sfp_disconnect_phy(void *upstream, struct phy_device *phy)
 	struct phy_device *phydev = upstream;
 	struct net_device *dev = phydev->attached_dev;
 
+	phydev->has_sfp_mod_phy = false;
+
 	if (dev)
 		phy_link_topo_del_phy(dev, phy);
 }
@@ -1617,6 +1629,75 @@ static void phy_sfp_link_down(void *upstream)
 		port->ops->link_down(port);
 }
 
+static int phy_add_sfp_mod_port(struct phy_device *phydev)
+{
+	const struct sfp_module_caps *caps;
+	struct phy_port *port;
+	int ret = 0;
+
+	/* Create mod port */
+	port = phy_port_alloc();
+	if (!port)
+		return -ENOMEM;
+
+	port->active = true;
+
+	caps = sfp_get_module_caps(phydev->sfp_bus);
+
+	phy_caps_linkmode_filter_ifaces(port->supported, caps->link_modes,
+					phydev->sfp_cage_port->interfaces);
+
+	if (phydev->attached_dev) {
+		ret = phy_link_topo_add_port(phydev->attached_dev, port);
+		if (ret) {
+			phy_port_destroy(port);
+			return ret;
+		}
+	}
+
+	/* we don't use phy_add_port() here as the module port isn't a direct
+	 * interface from the PHY, but rather an extension to the sfp-bus, that
+	 * is already represented by its own phy_port
+	 */
+	phydev->mod_port = port;
+
+	return 0;
+}
+
+static void phy_del_sfp_mod_port(struct phy_device *phydev)
+{
+	if (!phydev->mod_port)
+		return;
+
+	if (phydev->attached_dev)
+		phy_link_topo_del_port(phydev->attached_dev, phydev->mod_port);
+
+	phy_port_destroy(phydev->mod_port);
+	phydev->mod_port = NULL;
+}
+
+static int phy_sfp_module_start(void *upstream)
+{
+	struct phy_device *phydev = upstream;
+
+	/* If there's a downstream SFP module, and it doesn't contain a PHY
+	 * device, let's create a phy_port to represent that module.
+	 */
+	if (!phydev->has_sfp_mod_phy)
+		return phy_add_sfp_mod_port(phydev);
+
+	return 0;
+}
+
+static void phy_sfp_module_stop(void *upstream)
+{
+	struct phy_device *phydev = upstream;
+
+	/* Called upon module removal or upstream removal */
+	if (!phydev->has_sfp_mod_phy)
+		phy_del_sfp_mod_port(phydev);
+}
+
 static const struct sfp_upstream_ops sfp_phydev_ops = {
 	.attach = phy_sfp_attach,
 	.detach = phy_sfp_detach,
@@ -1626,6 +1707,8 @@ static const struct sfp_upstream_ops sfp_phydev_ops = {
 	.link_down = phy_sfp_link_down,
 	.connect_phy = phy_sfp_connect_phy,
 	.disconnect_phy = phy_sfp_disconnect_phy,
+	.module_start = phy_sfp_module_start,
+	.module_stop = phy_sfp_module_stop,
 };
 
 static int phy_add_port(struct phy_device *phydev, struct phy_port *port)
@@ -1736,8 +1819,11 @@ static int phy_sfp_probe(struct phy_device *phydev)
 	if (ret && port) {
 		phy_del_port(phydev, port);
 		phy_port_destroy(port);
+		port = NULL;
 	}
 
+	phydev->sfp_cage_port = port;
+
 	return ret;
 }
 
@@ -1827,6 +1913,12 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 		err = phy_link_topo_add_phy(dev, phydev, PHY_UPSTREAM_MAC, dev);
 		if (err)
 			goto error;
+
+		if (phydev->mod_port) {
+			err = phy_link_topo_add_port(dev, phydev->mod_port);
+			if (err)
+				goto error;
+		}
 	}
 
 	/* Some Ethernet drivers try to connect to a PHY device before
@@ -1960,6 +2052,8 @@ void phy_detach(struct phy_device *phydev)
 		phydev->attached_dev->phydev = NULL;
 		phydev->attached_dev = NULL;
 		phy_link_topo_del_phy(dev, phydev);
+		if (phydev->mod_port)
+			phy_link_topo_del_port(dev, phydev->mod_port);
 	}
 
 	phydev->phy_link_change = NULL;
@@ -3815,6 +3909,7 @@ static int phy_remove(struct device *dev)
 
 	sfp_bus_del_upstream(phydev->sfp_bus);
 	phydev->sfp_bus = NULL;
+	phydev->sfp_cage_port = NULL;
 
 	if (phydev->drv && phydev->drv->remove)
 		phydev->drv->remove(phydev);
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 640b3f4f45f9..59ea3a2e5da4 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -96,6 +96,7 @@ struct phylink {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(sfp_support);
 	u8 sfp_port;
 	struct phy_port *sfp_cage_port;
+	struct phy_port *mod_port;
 
 	struct eee_config eee_cfg;
 
@@ -1790,10 +1791,15 @@ static int phylink_create_sfp_cage_port(struct phylink *pl)
 
 	ret = phy_link_topo_add_port(pl->netdev, port);
 	if (ret)
-		phy_port_destroy(port);
-	else
-		pl->sfp_cage_port = port;
+		goto out_destroy_port;
+
+	pl->sfp_cage_port = port;
+
+	return 0;
 
+out_destroy_port:
+	phy_port_destroy(port);
+	pl->sfp_cage_port = NULL;
 	return ret;
 }
 
@@ -3924,14 +3930,65 @@ static void phylink_sfp_module_remove(void *upstream)
 	phy_interface_zero(pl->sfp_interfaces);
 }
 
+static int phylink_add_sfp_mod_port(struct phylink *pl)
+{
+	const struct sfp_module_caps *caps;
+	struct phy_port *port;
+	int ret = 0;
+
+	if (!pl->sfp_cage_port)
+		return 0;
+
+	/* Create mod port */
+	port = phy_port_alloc();
+	if (!port)
+		return -ENOMEM;
+
+	port->active = true;
+
+	caps = sfp_get_module_caps(pl->sfp_bus);
+
+	phy_caps_linkmode_filter_ifaces(port->supported, caps->link_modes,
+					pl->sfp_cage_port->interfaces);
+
+	if (pl->netdev) {
+		ret = phy_link_topo_add_port(pl->netdev, port);
+		if (ret) {
+			phy_port_destroy(port);
+			return ret;
+		}
+	}
+
+	pl->mod_port = port;
+
+	return 0;
+}
+
+static void phylink_del_sfp_mod_port(struct phylink *pl)
+{
+	if (!pl->mod_port)
+		return;
+
+	if (pl->netdev)
+		phy_link_topo_del_port(pl->netdev, pl->mod_port);
+
+	phy_port_destroy(pl->mod_port);
+	pl->mod_port = NULL;
+}
+
 static int phylink_sfp_module_start(void *upstream)
 {
 	struct phylink *pl = upstream;
+	int ret;
 
 	/* If this SFP module has a PHY, start the PHY now. */
 	if (pl->phydev) {
 		phy_start(pl->phydev);
 		return 0;
+	} else {
+		ret = phylink_add_sfp_mod_port(pl);
+		if (ret)
+			return ret;
 	}
 
 	/* If the module may have a PHY but we didn't detect one we
@@ -3940,7 +3997,16 @@ static int phylink_sfp_module_start(void *upstream)
 	if (!pl->sfp_may_have_phy)
 		return 0;
 
-	return phylink_sfp_config_optical(pl);
+	ret = phylink_sfp_config_optical(pl);
+	if (ret)
+		goto del_mod_port;
+
+	return 0;
+
+del_mod_port:
+	phylink_del_sfp_mod_port(pl);
+
+	return ret;
 }
 
 static void phylink_sfp_module_stop(void *upstream)
@@ -3950,6 +4016,8 @@ static void phylink_sfp_module_stop(void *upstream)
 	/* If this SFP module has a PHY, stop it. */
 	if (pl->phydev)
 		phy_stop(pl->phydev);
+	else
+		phylink_del_sfp_mod_port(pl);
 }
 
 static void phylink_sfp_link_down(void *upstream)
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 199a7aaa341b..59903257e978 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -582,6 +582,7 @@ struct phy_oatc14_sqi_capability {
  * @wol_enabled: Set to true if the PHY or the attached MAC have Wake-on-LAN
  * 		 enabled.
  * @is_genphy_driven: PHY is driven by one of the generic PHY drivers
+ * @has_sfp_mod_phy: Set true if downstream SFP bus's module contains a PHY
  * @state: State of the PHY for management purposes
  * @dev_flags: Device-specific flags used by the PHY driver.
  *
@@ -594,6 +595,8 @@ struct phy_oatc14_sqi_capability {
  * @phylink: Pointer to phylink instance for this PHY
  * @sfp_bus_attached: Flag indicating whether the SFP bus has been attached
  * @sfp_bus: SFP bus attached to this PHY's fiber port
+ * @sfp_cage_port: The phy_port connected to the downstream SFP cage
+ * @mod_port: phy_port representing the SFP module, if it is phy-less
  * @attached_dev: The attached enet driver's device instance ptr
  * @adjust_link: Callback for the enet controller to respond to changes: in the
  *               link state.
@@ -706,6 +709,7 @@ struct phy_device {
 	unsigned irq_rerun:1;
 
 	unsigned default_timestamp:1;
+	unsigned has_sfp_mod_phy:1;
 
 	int rate_matching;
 
@@ -785,6 +789,8 @@ struct phy_device {
 	/* This may be modified under the rtnl lock */
 	bool sfp_bus_attached;
 	struct sfp_bus *sfp_bus;
+	struct phy_port *sfp_cage_port;
+	struct phy_port *mod_port;
 	struct phylink *phylink;
 	struct net_device *attached_dev;
 	struct mii_timestamper *mii_ts;
-- 
2.54.0


