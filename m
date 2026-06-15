Return-Path: <netdev+bounces-299506-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g07MCgweMGrtNwUAu9opvQ
	(envelope-from <netdev+bounces-299506-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 17:45:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 892E3687D59
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 17:45:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=aJeNc6dr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299506-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299506-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64E183137977
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C0F4071EE;
	Mon, 15 Jun 2026 15:39:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60F9406802
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 15:39:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537969; cv=none; b=sKNjwy2tBcCjufkFu2UinLAU3kFJY2RS03m+II00SCRzvqhSkMLLjGGVVhfz5VXB7imOto1HUjY3l+Z3r5IHI2xY6K8RBXJeVtie6dWS/lztCNdcsqnY9aUX3cflr2BiEJt/SOm1F13D8g0erqQGLOkbRLv3bcHTce2Hni9uQL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537969; c=relaxed/simple;
	bh=oikM9kMOf3D3wSnstY2KS0qPIkMx4DeNVS8cieDejnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDB+fWabbmcknbY+ytu99gcmmGwMk1NgrD5fpd6Cg4fHrPawTErrFJNXH98BHdTacWNKHDd1FqwwkYySk1C5kLtAO9gAujugE1kM0BB1O+6Qw8vPMroVoobZS0hs/Fa+rjZReWkPZNXjjEiaqgoDoeTN4+3pygQaZQYjcaOB3BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aJeNc6dr; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A6389C51474;
	Mon, 15 Jun 2026 15:39:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7E43760015;
	Mon, 15 Jun 2026 15:39:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5E4A6106C9728;
	Mon, 15 Jun 2026 17:39:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781537965; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=q6JmGD2h0hdk4OCPA7IOW7FYLMqebNdRWdEUSON54K0=;
	b=aJeNc6drwgMMtZomH4AtCuvAMFZsycJVM6nKf+2TjCNhP+Ak7jZnWMqp/QvajnLGiah4N6
	dcAGqNzbWhvCQqQtKKPtKcq7GIgS9WuJHYxAmmVtz/rUgnInMaLQkEJ0Ho5VkNCtuO2GDg
	UZtxkCfYo4lbipO5sHPQcYgTRLSi69+DHg2SCVmYyvq2+njJS3OtxOyso9t69Qm3kPNEof
	t0HX+l7XilAfIDycDPkUZz6oTj9RJ9U3IQyTqXf35w/AsvMENOu+byShuNLq9XsrMQsrWX
	p1A7ipPgeYnJYrwu0pDmD6shUKXa1zSW8hj3vMWkREhzu2oLih+BlkS+p4CG/Q==
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
Subject: [PATCH net-next v12 03/10] net: phylink: Register a phy_port for MAC-driven SFP cages
Date: Mon, 15 Jun 2026 17:38:59 +0200
Message-ID: <20260615153907.862987-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615153907.862987-1-maxime.chevallier@bootlin.com>
References: <20260615153907.862987-1-maxime.chevallier@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299506-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,bootlin.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 892E3687D59

phy_port tracks the interfaces that a netdevice feeds into. SFP cages are
such ports, but so far we are only tracking the ones that are driven by
PHYs acting as media-converters.

Let's populate a phy_port for MAC driver SFP cages, handled by phylink.

This phy_port represents the SFP cage itself, and not the module that
may be plugged into it. It's therefore not an MDI interface, so only the
'interfaces' field is relevant here.

The phy_port is only populated for 'NETDEV' phylink instances, as
otherwise we don't have any topology to attach the port to.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phylink.c | 53 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 087ac63f9193..640b3f4f45f9 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -14,6 +14,8 @@
 #include <linux/of_mdio.h>
 #include <linux/phy.h>
 #include <linux/phy_fixed.h>
+#include <linux/phy_link_topology.h>
+#include <linux/phy_port.h>
 #include <linux/phylink.h>
 #include <linux/rtnetlink.h>
 #include <linux/spinlock.h>
@@ -93,6 +95,7 @@ struct phylink {
 	DECLARE_PHY_INTERFACE_MASK(sfp_interfaces);
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(sfp_support);
 	u8 sfp_port;
+	struct phy_port *sfp_cage_port;
 
 	struct eee_config eee_cfg;
 
@@ -1765,6 +1768,46 @@ static void phylink_fixed_poll(struct timer_list *t)
 
 static const struct sfp_upstream_ops sfp_phylink_ops;
 
+static int phylink_create_sfp_cage_port(struct phylink *pl)
+{
+	struct phy_port *port;
+	int ret = 0;
+
+	if (!pl->netdev || !pl->sfp_bus)
+		return 0;
+
+	port = phy_port_alloc();
+	if (!port)
+		return -ENOMEM;
+
+	port->is_sfp = true;
+	port->is_mii = true;
+	port->active = true;
+
+	phy_interface_and(port->interfaces, pl->config->supported_interfaces,
+			  phylink_sfp_interfaces);
+	phy_port_update_supported(port);
+
+	ret = phy_link_topo_add_port(pl->netdev, port);
+	if (ret)
+		phy_port_destroy(port);
+	else
+		pl->sfp_cage_port = port;
+
+	return ret;
+}
+
+static void phylink_destroy_sfp_cage_port(struct phylink *pl)
+{
+	if (pl->netdev && pl->sfp_cage_port)
+		phy_link_topo_del_port(pl->netdev, pl->sfp_cage_port);
+
+	if (pl->sfp_cage_port)
+		phy_port_destroy(pl->sfp_cage_port);
+
+	pl->sfp_cage_port = NULL;
+}
+
 static int phylink_register_sfp(struct phylink *pl,
 				const struct fwnode_handle *fwnode)
 {
@@ -1782,9 +1825,18 @@ static int phylink_register_sfp(struct phylink *pl,
 
 	pl->sfp_bus = bus;
 
+	ret = phylink_create_sfp_cage_port(pl);
+	if (ret) {
+		sfp_bus_put(bus);
+		return ret;
+	}
+
 	ret = sfp_bus_add_upstream(bus, pl, &sfp_phylink_ops);
 	sfp_bus_put(bus);
 
+	if (ret)
+		phylink_destroy_sfp_cage_port(pl);
+
 	return ret;
 }
 
@@ -1946,6 +1998,7 @@ EXPORT_SYMBOL_GPL(phylink_create);
 void phylink_destroy(struct phylink *pl)
 {
 	sfp_bus_del_upstream(pl->sfp_bus);
+	phylink_destroy_sfp_cage_port(pl);
 	if (pl->link_gpio)
 		gpiod_put(pl->link_gpio);
 
-- 
2.54.0


