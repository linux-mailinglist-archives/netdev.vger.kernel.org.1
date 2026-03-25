Return-Path: <netdev+bounces-271455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIsQKOGbw2myrwQAu9opvQ
	(envelope-from <netdev+bounces-271455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 09:25:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B44321624
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 09:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFA5230AA022
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5F639F180;
	Wed, 25 Mar 2026 08:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wcgAwGmh"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48118396D2E
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 08:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774426819; cv=none; b=FT2jb+tWlkBunL2AUQ5uOYkea2elvQCONf6flchn/ojRDktgS8QxS0rGHjdp21xfiA4poO6Tw31Py0DKG44xfDu9+ziCdPPNTrfu1vzBMSY2hTLwGfg+GKrENnPPp/5dcLgCVBh1oxYsYY7f5Ty1XxOPg8dRIux+3VgXgFziW48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774426819; c=relaxed/simple;
	bh=iDiJ/hD9RyZ/VBe/8q2iwHgY1byzT7ehQ7dGfaxCVmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQp2amEgHlJcI4gayk/LhjGbM/DneXbhg4eGDRHHjP53BlCyhhVMHmw3DuNXz3jlLL/zYFUGQHAVeSz3+qHUOpf6EvZQb4wTxopyPfkVqakC+5M2EtN1w1L44RiSbTBkUgLivQ3hueKXSMNvptEM/KfNvrL9WCf4/7Td9smgVQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wcgAwGmh; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D28851A2FE1;
	Wed, 25 Mar 2026 08:20:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9F848601A1;
	Wed, 25 Mar 2026 08:20:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 853B61045136B;
	Wed, 25 Mar 2026 09:20:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774426814; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=mHopyKwGp0vXHDq7EzOxlyO9Kyr64b+XQr9pdlp672E=;
	b=wcgAwGmh2xKyx7ZJ2WDoTUnsYjHB+uH9/6nVscC7ATgjqYOwe/po30qEHwzU7hVPQ1PvRW
	pDKB4ow37ovJYTfyrZMWRyWleVywlMF89zwA6WNmSUAROwhGZsa4XUJEDiftf+/YdTbCeo
	x8vv6wSHA/iqxhhJNyR1FrYUl38ExzQzrow1fu2f6YKuJweB+AnuWr+EB95Ymy52SrDTzg
	M+Bn7H/BlJqXrJNpwVJPfpvyUH28URXD4wuOc7kZaprztv8aVN8rVm6aBXesDeg39s5IpI
	EkObrj0bnLqNe1dj3id75g/VjxEIcLRFR0MjKuaADCxbGuTF827j6sIDRJ6tew==
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
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: [PATCH net-next v8 07/10] net: phy: phy_port: Store information about a MII port's vacant state
Date: Wed, 25 Mar 2026 09:19:32 +0100
Message-ID: <20260325081937.571115-8-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260325081937.571115-1-maxime.chevallier@bootlin.com>
References: <20260325081937.571115-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-271455-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid]
X-Rspamd-Queue-Id: 27B44321624
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

MII phy_ports are not meant to be connected directly to a link partner.
They are meant to feed into some media converter devices, so far we only
support SFP modules for that.

We have information about what MII they can handle, however we don't
store anything about whether they are currently connected to an SFP
module or not. As phy_port aims at listing the front-facing ports, let's
store an "vacant" bit to know whether or not a MII port is currently
vacant (i.e. there's no module in the SFP cage), or not (i.e.
there's an SFP module).

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_device.c | 17 +++++++++++++----
 drivers/net/phy/phylink.c    | 14 +++++++++++++-
 include/linux/phy_port.h     |  4 ++++
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 2c0b0d275809..855db4431611 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1556,6 +1556,7 @@ static int phy_sfp_module_insert(void *upstream, const struct sfp_eeprom_id *id)
 	struct phy_device *phydev = upstream;
 	const struct sfp_module_caps *caps;
 	struct phy_port *port;
+	int ret = 0;
 
 	phy_interface_t iface;
 
@@ -1584,9 +1585,12 @@ static int phy_sfp_module_insert(void *upstream, const struct sfp_eeprom_id *id)
 		phydev->port = caps->port;
 
 	if (port->ops && port->ops->configure_mii)
-		return port->ops->configure_mii(port, true, iface);
+		ret = port->ops->configure_mii(port, true, iface);
 
-	return 0;
+	if (!ret)
+		port->vacant = false;
+
+	return ret;
 }
 
 static void phy_sfp_module_remove(void *upstream)
@@ -1594,8 +1598,12 @@ static void phy_sfp_module_remove(void *upstream)
 	struct phy_device *phydev = upstream;
 	struct phy_port *port = phy_get_sfp_port(phydev);
 
-	if (port && port->ops && port->ops->configure_mii)
-		port->ops->configure_mii(port, false, PHY_INTERFACE_MODE_NA);
+	if (port) {
+		if (port->ops && port->ops->configure_mii)
+			port->ops->configure_mii(port, false,
+						 PHY_INTERFACE_MODE_NA);
+		port->vacant = true;
+	}
 
 	if (phydev->n_ports == 1)
 		phydev->port = PORT_NONE;
@@ -1762,6 +1770,7 @@ static struct phy_port *phy_setup_sfp_port(struct phy_device *phydev)
 	 */
 	port->is_mii = true;
 	port->is_sfp = true;
+	port->vacant = true;
 
 	/* The port->supported and port->interfaces list will be populated
 	 * when attaching the port to the phydev.
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 73d838b918d1..8bf0e2f143df 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1784,6 +1784,7 @@ static int phylink_create_sfp_port(struct phylink *pl)
 	port->is_sfp = true;
 	port->is_mii = true;
 	port->active = true;
+	port->vacant = true;
 
 	phy_interface_and(port->interfaces, pl->config->supported_interfaces,
 			  phylink_sfp_interfaces);
@@ -3915,6 +3916,7 @@ static int phylink_sfp_module_insert(void *upstream,
 {
 	const struct sfp_module_caps *caps;
 	struct phylink *pl = upstream;
+	int ret;
 
 	ASSERT_RTNL();
 
@@ -3924,17 +3926,27 @@ static int phylink_sfp_module_insert(void *upstream,
 	pl->sfp_may_have_phy = caps->may_have_phy;
 	pl->sfp_port = caps->port;
 
+	if (pl->sfp_bus_port)
+		pl->sfp_bus_port->vacant = false;
+
 	/* If this module may have a PHY connecting later, defer until later */
 	if (pl->sfp_may_have_phy)
 		return 0;
 
-	return phylink_sfp_config_optical(pl);
+	ret = phylink_sfp_config_optical(pl);
+	if (ret && pl->sfp_bus_port)
+		pl->sfp_bus_port->vacant = true;
+
+	return ret;
 }
 
 static void phylink_sfp_module_remove(void *upstream)
 {
 	struct phylink *pl = upstream;
 
+	if (pl->sfp_bus_port)
+		pl->sfp_bus_port->vacant = true;
+
 	phy_interface_zero(pl->sfp_interfaces);
 }
 
diff --git a/include/linux/phy_port.h b/include/linux/phy_port.h
index 4e2a3fdd2f2e..b0b1fa6a67a9 100644
--- a/include/linux/phy_port.h
+++ b/include/linux/phy_port.h
@@ -51,6 +51,9 @@ struct phy_port_ops {
  * @is_mii: Indicates if this port is MII (Media Independent Interface),
  *          or MDI (Media Dependent Interface).
  * @is_sfp: Indicates if this port drives an SFP cage.
+ * @vacant: For MII ports, indicates whether or not the port has a connection to
+ *	    another device (e.g. for SFP ports, indicates the absence or presence
+ *	    of an SFP module)
  */
 struct phy_port {
 	u32 id;
@@ -71,6 +74,7 @@ struct phy_port {
 	unsigned int active:1;
 	unsigned int is_mii:1;
 	unsigned int is_sfp:1;
+	unsigned int vacant:1;
 };
 
 struct phy_port *phy_port_alloc(void);
-- 
2.49.0


