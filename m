Return-Path: <netdev+bounces-253887-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QP5qOCLDeGmltAEAu9opvQ
	(envelope-from <netdev+bounces-253887-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:52:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC4295232
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFF1330C2C70
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBD935D615;
	Tue, 27 Jan 2026 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GPopLQC6"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3724B35D5EA
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769521361; cv=none; b=Bn/n2T6wp8KukEyChFRCbaEdMByfw3fSHOv+JH4pl35CZ6XpqZ2OmZNWNNM3bTpL2XUNnuOW0S9y3xdVUgBj9ru7tX8r25CEQA4UEbnRxICYO0bFcQdvpcsANDOE2kxJa8i1ZfCO4wm7RhNTZhXZFExaN13j3F1C3T0JHqpo9Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769521361; c=relaxed/simple;
	bh=TQJLvfrLbkpH2tgRH3T5MjUllU/MA6zjpa35N8wYB34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z45VPzFgIHoSoNOk3kwjzJbYeCcnUSHvCs9xvKRe0/RbtzG1nCe08IWTkjtYSby1MQXf8i2hJdL2iihUhtkJWhxyqsCD1bjfIsdm40fHVAZ+0eOwBZjX55AnrQjCIQLJYyLbpzeUpGsk+tMFNY9+7rEf1es50l5kWW9WM+B4utg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GPopLQC6; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E9BBDC211C3;
	Tue, 27 Jan 2026 13:42:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D62FC606F5;
	Tue, 27 Jan 2026 13:42:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ECA88119A8690;
	Tue, 27 Jan 2026 14:42:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769521357; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=bqj8JUK2+OuAF2zK25RJrBtPlN18kp54KfaV+cibShA=;
	b=GPopLQC6LSNgHlCia3rwWxec0uztQlGP+UuCOMvVpCOdkw9sGVYn/i207piacN4zQmfxCQ
	6A+/+8N57XOMqaboDH4UWokjmuI6OKha7oSmd/EhnKzPUmjUxx4WKussaS/2oMlXkOJlyb
	CSyPZ/YV/gsMUj9TFFvyf/6ZMRkwUvTrQ1Mw0299YgoL8UILWefrO2DIos1KwesZFzpceq
	mkD0ePs0k3hZ2RTdStmXwMvHfaXbOimzV19yTm2LEduYBnPbwHh/qzSlNK52TCy6pDR6M1
	VV850IdpcOaNqdJwMlHaEbyEhJ2RDv1yGGzjBCeC/GoWVCu3UuHE6MjnvHMM2A==
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
Subject: [PATCH net-next 08/13] net: phylink: Represent PHY-less SFP modules with phy_port
Date: Tue, 27 Jan 2026 14:41:56 +0100
Message-ID: <20260127134202.8208-9-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127134202.8208-1-maxime.chevallier@bootlin.com>
References: <20260127134202.8208-1-maxime.chevallier@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-253887-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: 7BC4295232
X-Rspamd-Action: no action

Let phylink handle the phy_port for PHY-less modules, and register it to
the topology.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phylink.c | 68 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 310af33d49a0..6c62604b00a6 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -96,6 +96,7 @@ struct phylink {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(sfp_support);
 	u8 sfp_port;
 	struct phy_port *sfp_bus_port;
+	struct phy_port *mod_port;
 
 	struct eee_config eee_cfg;
 
@@ -1786,13 +1787,31 @@ static int phylink_create_sfp_port(struct phylink *pl)
 	else
 		pl->sfp_bus_port = port;
 
+	if (pl->mod_port) {
+		ret = phy_link_topo_add_port(pl->netdev, pl->mod_port);
+		if (ret)
+			goto out_bus_port;
+	}
+
+	return 0;
+out_bus_port:
+	phy_link_topo_del_port(pl->netdev, port);
+	phy_port_destroy(port);
 	return ret;
 }
 
 static void phylink_destroy_sfp_port(struct phylink *pl)
 {
-	if (pl->netdev && pl->sfp_bus_port)
-		phy_link_topo_del_port(pl->netdev, pl->sfp_bus_port);
+	if (pl->netdev) {
+		if (pl->sfp_bus_port)
+			phy_link_topo_del_port(pl->netdev, pl->sfp_bus_port);
+
+		/* Only remove it from the topology, it will be destroyed at
+		 * module removal.
+		 */
+		if (pl->mod_port)
+			phy_link_topo_del_port(pl->netdev, pl->mod_port);
+	}
 
 	if (pl->sfp_bus_port)
 		phy_port_destroy(pl->sfp_bus_port);
@@ -3998,6 +4017,49 @@ static void phylink_sfp_disconnect_phy(void *upstream,
 	phylink_disconnect_phy(upstream);
 }
 
+static int phylink_sfp_connect_nophy(void *upstream)
+{
+	const struct sfp_module_caps *caps;
+	struct phylink *pl = upstream;
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
+	caps = sfp_get_module_caps(pl->sfp_bus);
+
+	phy_caps_linkmode_filter_ifaces(port->supported, caps->link_modes,
+					pl->sfp_bus_port->interfaces);
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
+static void phylink_sfp_disconnect_nophy(void *upstream)
+{
+	struct phylink *pl = upstream;
+
+	if (pl->netdev)
+		phy_link_topo_del_port(pl->netdev, pl->mod_port);
+
+	phy_port_destroy(pl->mod_port);
+	pl->mod_port = NULL;
+}
+
 static const struct sfp_upstream_ops sfp_phylink_ops = {
 	.attach = phylink_sfp_attach,
 	.detach = phylink_sfp_detach,
@@ -4009,6 +4071,8 @@ static const struct sfp_upstream_ops sfp_phylink_ops = {
 	.link_down = phylink_sfp_link_down,
 	.connect_phy = phylink_sfp_connect_phy,
 	.disconnect_phy = phylink_sfp_disconnect_phy,
+	.connect_nophy = phylink_sfp_connect_nophy,
+	.disconnect_nophy = phylink_sfp_disconnect_nophy,
 };
 
 /* Helpers for MAC drivers */
-- 
2.49.0


