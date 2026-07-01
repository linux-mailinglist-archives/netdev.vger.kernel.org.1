Return-Path: <netdev+bounces-303602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZGJDBWn1RGoj4AoAu9opvQ
	(envelope-from <netdev+bounces-303602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 13:09:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4606EC943
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 13:09:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=1Qj4nHae;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303602-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303602-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F0DDC300C321
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 11:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D299144E041;
	Wed,  1 Jul 2026 11:04:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B574144A72C
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 11:04:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903894; cv=none; b=nVFIUR49A0tatzcolpkvvwFP6pb95/abjJGBwKIVvHNZsZGKBQRYiX5BjLSP5hM767MaAmHGSemAM0O8trXGhYg+7ImeQoH+YFnyg3uUb8fzItgsfwXrW7vs5kqZuv3AOAZqB64qHenxzZEGWZ/5sAt9kzUR0CgAuyUrLUxIT4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903894; c=relaxed/simple;
	bh=1YZU7dH7fPlp9zONHLGvUAlYCuTXupOBSOBty8mVy28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFoSNbUHSAyxNloXp88blRMgy/AjPsUVBK5TMUeXx1Nkd7QoQezgpFZAd5ai8jioTzhW61AjBfPHuEo5PcsZzWAP2cbDdIqaDz3tscitEWua0fq9Ehvos4nAhFssfD0nAmSiIYzmC/8p8OD28dziD0w7PiQgHAVveodBsSLKpik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1Qj4nHae; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 03DC3C79AB8;
	Wed,  1 Jul 2026 11:05:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 17E6060288;
	Wed,  1 Jul 2026 11:04:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 06B09104C9E3C;
	Wed,  1 Jul 2026 13:04:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782903887; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=iC4GkYIAH14WqAV+6c8Frc3eKB+R7uoSo8Sbhew0WyU=;
	b=1Qj4nHaeI+Xnc0bDivzFbYUL9bZDAXQXld57JRH/JcwOXoOmtPqnOAWFwLJGGeoGJnvSXe
	QmiREtxIY3V59EgvAWBzLqbVYy7iL+IWboreg7oAYFfoEl3x578nW8LK+2iRCaTK64KpWl
	AWfUJwVgYkgQVMxGqkpwlQJCh2+MkZR9FwMrG7AB6N/zeIMym/g5dUJiCsGmq2r80+2b2M
	BDrFanTL4pEE16TmFj3Ui/J/G4j0Gr5/Mjh764cgJ4g3eZOw6P/1kp0cq/rTxG9gC5cMzy
	HZy8pRZ9pH41m9HbQvHyNG95mdKjRuLKiRQJPgwGW+7uA/iJkzN7HkvbR0ZPkg==
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
Subject: [PATCH net-next v13 04/10] net: phy: Create SFP phy_port before registering upstream
Date: Wed,  1 Jul 2026 13:04:20 +0200
Message-ID: <20260701110427.143945-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701110427.143945-1-maxime.chevallier@bootlin.com>
References: <20260701110427.143945-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303602-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:andrew@lunn.ch,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:thomas.petazzoni@bootlin.com,m:christophe.leroy@csgroup.eu,m:herve.codina@bootlin.com,m:f.fainelli@gmail.com,m:vladimir.oltean@nxp.com,m:kory.maincent@bootlin.com,m:kabel@kernel.org,m:o.rempel@pengutronix.de,m:nicveronese@gmail.com,m:horms@kernel.org,m:mwojtas@chromium.org,m:romain.gantois@bootlin.com,m:daniel@makrotopia.org,m:dimitri.fedrau@liebherr.com,m:frank.wunderlich@linux.dev,m:ffainelli@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com,linux.dev];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,bootlin.com:from_mime,vger.kernel.org:from_smtp,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C4606EC943

When dealing with PHY-driven SFP, we create a phy_port representing the
SFP bus when we know we have such a bus.

We can move the port creation before registering the sfp upstream ops,
as long as we know the SFP bus is there. This will allow passing the
phy_port along with the upstream information to the SFP bus.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_device.c | 55 +++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 16 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 0615228459ef..ad2546169360 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1673,13 +1673,13 @@ static void phy_del_port(struct phy_device *phydev, struct phy_port *port)
 	phydev->n_ports--;
 }
 
-static int phy_setup_sfp_port(struct phy_device *phydev)
+static struct phy_port *phy_setup_sfp_port(struct phy_device *phydev)
 {
 	struct phy_port *port = phy_port_alloc();
 	int ret;
 
 	if (!port)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	port->parent_type = PHY_PORT_PHY;
 	port->phy = phydev;
@@ -1694,10 +1694,12 @@ static int phy_setup_sfp_port(struct phy_device *phydev)
 	 * when attaching the port to the phydev.
 	 */
 	ret = phy_add_port(phydev, port);
-	if (ret)
+	if (ret) {
 		phy_port_destroy(port);
+		return ERR_PTR(ret);
+	}
 
-	return ret;
+	return port;
 }
 
 /**
@@ -1706,25 +1708,46 @@ static int phy_setup_sfp_port(struct phy_device *phydev)
  */
 static int phy_sfp_probe(struct phy_device *phydev)
 {
+	struct phy_port *port = NULL;
 	struct sfp_bus *bus;
-	int ret = 0;
+	int ret;
 
-	if (phydev->mdio.dev.fwnode) {
-		bus = sfp_bus_find_fwnode(phydev->mdio.dev.fwnode);
-		if (IS_ERR(bus))
-			return PTR_ERR(bus);
+	if (!phydev->mdio.dev.fwnode)
+		return 0;
 
-		phydev->sfp_bus = bus;
+	bus = sfp_bus_find_fwnode(phydev->mdio.dev.fwnode);
+	if (IS_ERR(bus))
+		return PTR_ERR(bus);
 
-		ret = sfp_bus_add_upstream(bus, phydev, &sfp_phydev_ops);
-		sfp_bus_put(bus);
+	phydev->sfp_bus = bus;
 
-		if (ret)
-			phydev->sfp_bus = NULL;
+	if (bus) {
+		port = phy_setup_sfp_port(phydev);
+		if (IS_ERR(port)) {
+			ret = PTR_ERR(port);
+			goto out_sfp;
+		}
 	}
 
-	if (!ret && phydev->sfp_bus)
-		ret = phy_setup_sfp_port(phydev);
+	ret = sfp_bus_add_upstream(bus, phydev, &sfp_phydev_ops);
+	if (ret)
+		goto out_port;
+
+	/* sfp_bus_add_upstream() grabs a ref to the sfp bus on success, it's
+	 * safe to release it now.
+	 */
+	sfp_bus_put(bus);
+
+	return ret;
+
+out_port:
+	if (port) {
+		phy_del_port(phydev, port);
+		phy_port_destroy(port);
+	}
+out_sfp:
+	sfp_bus_put(bus);
+	phydev->sfp_bus = NULL;
 
 	return ret;
 }
-- 
2.54.0


