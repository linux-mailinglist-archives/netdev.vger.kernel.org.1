Return-Path: <netdev+bounces-257092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPdMLqNkhGkh2wMAu9opvQ
	(envelope-from <netdev+bounces-257092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:36:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D6EF0E15
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B9DD30131C4
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 09:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3A7393DE9;
	Thu,  5 Feb 2026 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bgnv3mho"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9552F3A4F2E
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770283439; cv=none; b=Rldv49Hisipgze8p73ocH7EuV0GANx7Vs/4FQIaQKKE4T2g+TSTv5a8ua/obJLV9uq6JNvf67tKMMVGguWPHr0rKPPpKynlRjxEEOonZ7Z8nAocUKhOF4xFyR2ttiU6iKlyccDWS7/n3Hg5J8/q0tceOuxUf4Q4DF4ieIiABPhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770283439; c=relaxed/simple;
	bh=XuD9XVnfKD2QhNJOtOO0uD9i4JYrx1qqI1maL1kgSxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvUMDd3ijoo5fnFvVVJXKgXyHjTR950yCpBLR+163AAr01Oc9iD0dFVjLhMFXDtD+gP0cpyz/wPnX0cCfj/i2NON7HaOxNTM/WMSgc8pzSBOtvWIQY9MbDEY6gx31DDYQo/VsSyQEsokR4hMDAWofnp3yu27udl69qv2CB4NEi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bgnv3mho; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 565E61A2C16;
	Thu,  5 Feb 2026 09:23:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2D217606FD;
	Thu,  5 Feb 2026 09:23:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E2508119A88FD;
	Thu,  5 Feb 2026 10:23:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770283436; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=AKWPF4/lQBEiNWS/oYcnux6E2kWU0lE9deAv3AQANag=;
	b=bgnv3mhoSn7qIZhknVglwpHeAOiouNdJlCjhtoeyW3YPVBV7QZ8r+u4kEbkAbWT/Iib1WH
	6cy+ObTtdHgSSLWFcDmE9aBdPjlgwV8KU7e4fh6ViuuHtIOojMM3Ru4S5mbwVYyL06VbI0
	Z9Kg7SMzu0O4KFkVAA54sMjwLRKAY4PJgmfNrSJdkBYzwwcmJkVifZzYVQkQsmDqpgpqn2
	qhIzwcHbEkU6uc16HAd8VMgdanBtUQgxnVsaOXlRv52s+qrUPQVZ5e3JqTKGgke00NMIu9
	aZMPAKp0edWnsAtDHVwPhJtzvel9syFhPFVfrnAlI/pdr9oyErUXc1Iw3b5vbA==
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
Subject: [PATCH net-next v5 10/13] net: phy: phy_port: Store information about a MII port's vacant state
Date: Thu,  5 Feb 2026 10:23:13 +0100
Message-ID: <20260205092317.755906-11-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260205092317.755906-1-maxime.chevallier@bootlin.com>
References: <20260205092317.755906-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-257092-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:dkim,bootlin.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8D6EF0E15
X-Rspamd-Action: no action

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
 drivers/net/phy/phylink.c    |  6 ++++++
 include/linux/phy_port.h     |  4 ++++
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 0daa87413c66..35051ebe4d6b 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1550,6 +1550,7 @@ static int phy_sfp_module_insert(void *upstream, const struct sfp_eeprom_id *id)
 	struct phy_device *phydev = upstream;
 	const struct sfp_module_caps *caps;
 	struct phy_port *port;
+	int ret = 0;
 
 	phy_interface_t iface;
 
@@ -1578,9 +1579,12 @@ static int phy_sfp_module_insert(void *upstream, const struct sfp_eeprom_id *id)
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
@@ -1588,8 +1592,12 @@ static void phy_sfp_module_remove(void *upstream)
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
@@ -1755,6 +1763,7 @@ static struct phy_port *phy_setup_sfp_port(struct phy_device *phydev)
 	 */
 	port->is_mii = true;
 	port->is_sfp = true;
+	port->vacant = true;
 
 	/* The port->supported and port->interfaces list will be populated
 	 * when attaching the port to the phydev.
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index f26037ec7ba3..8a22cdc4e60b 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3925,6 +3925,9 @@ static int phylink_sfp_module_insert(void *upstream,
 	pl->sfp_may_have_phy = caps->may_have_phy;
 	pl->sfp_port = caps->port;
 
+	if (pl->sfp_bus_port)
+		pl->sfp_bus_port->vacant = false;
+
 	/* If this module may have a PHY connecting later, defer until later */
 	if (pl->sfp_may_have_phy)
 		return 0;
@@ -3936,6 +3939,9 @@ static void phylink_sfp_module_remove(void *upstream)
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


