Return-Path: <netdev+bounces-254439-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKsxN4Z1emmE6wEAu9opvQ
	(envelope-from <netdev+bounces-254439-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:45:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE3FA8C62
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7436C301BEF2
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 20:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE7D376478;
	Wed, 28 Jan 2026 20:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rLhr7Yx4"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2223228DB46
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 20:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769633147; cv=none; b=ZK2+6rzBG/wj7afsRky18rEazgxwutjCsOpcKrcz/zNBS9u/gGC0i39BFctf0nCRuMzd/ZUKvWnF/psevgbluhQ0M2ljGI/fdkD/kiyt/9Qpe8u1lZ/wDkaEPilAKTNIIFSOdUGoT5EVdL4Nt6mfUvvjiY+SeJdmkl0oQJ3RLFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769633147; c=relaxed/simple;
	bh=FzfPssaMTtMlTXsQB3uWK2d1KPWw1AhO9CiOrY0mA4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIusZAqbg3hncS+XFCvMxbR7nsNLRvC5p2QIcI01LaPH81jaJbQqnA+tetV2EukyZWcBgNlfxsT3RRtyX7JawX5WcUr+sgFv0HsfQDuUpu8xDHRDTdqzKSLere9WpFwSsm0Wso5xkENXCZ3u9ibejEqy/8q1iNKCt+mEBNLQDYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rLhr7Yx4; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 5CCE8C211F2;
	Wed, 28 Jan 2026 20:45:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AC3456071F;
	Wed, 28 Jan 2026 20:45:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AEA33119A8834;
	Wed, 28 Jan 2026 21:45:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769633143; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=LWzrt0LzFGZIeHx1tJakp6EzeCmz9kccT2ixoT2csH8=;
	b=rLhr7Yx4httqJE1Oxo8L1AD7ebbspZn5r1nsNkrHKL1mUfXR3IyrEE/FkjSYkPB8BKJHUb
	/y7N8lPAvIaKfdrZTLnrM5tyqO4aty5Bks6RoP0CZzfIk6Q0b5fnbVXHdaOpPXh/QQONZc
	O1SwVIE1Gu0Iw4ZmxC2IrMrdqE0HKIKquf1MOm9PnRsuaU29enw8pfKP9B7ybuXTkAG+5W
	gtYeQjH3E0Ltn5Qck1yD7KF2k0E5pJTcQ8QNiDpYHBnye6zQYfMTpdNUCqpohDROMXp9Xj
	PeZqz6OD1whm0B9EeLR33c9bsYvAUftQuhezLuLhgNPd1n3H7c6yOPMlUuYjhw==
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
Subject: [PATCH net-next v2 02/12] net: phy: phy_link_topology: Add a helper for opportunistic alloc
Date: Wed, 28 Jan 2026 21:45:15 +0100
Message-ID: <20260128204526.170927-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260128204526.170927-1-maxime.chevallier@bootlin.com>
References: <20260128204526.170927-1-maxime.chevallier@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bootlin.com,vger.kernel.org,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-254439-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: 9FE3FA8C62
X-Rspamd-Action: no action

The phy_link_topology structure stores information about the PHY-related
components connected to a net_device. It is opportunistically allocated,
when we add the first item to the topology, as this is not relevant for
all kinds of net_devices.

In preparation for the addition of phy_port tracking in the topology,
let's make a dedicated helper for that allocation sequence.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_link_topology.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
index 0e9e987f37dd..7dc2ff10c74a 100644
--- a/drivers/net/phy/phy_link_topology.c
+++ b/drivers/net/phy/phy_link_topology.c
@@ -27,21 +27,34 @@ static int netdev_alloc_phy_link_topology(struct net_device *dev)
 	return 0;
 }
 
+static struct phy_link_topology *phy_link_topo_get_or_alloc(struct net_device *dev)
+{
+	int ret;
+
+	if (dev->link_topo)
+		return dev->link_topo;
+
+	/* The topology is allocated the first time we add an object to it.
+	 * It is freed alongside the netdev.
+	 */
+	ret = netdev_alloc_phy_link_topology(dev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return dev->link_topo;
+}
+
 int phy_link_topo_add_phy(struct net_device *dev,
 			  struct phy_device *phy,
 			  enum phy_upstream upt, void *upstream)
 {
-	struct phy_link_topology *topo = dev->link_topo;
+	struct phy_link_topology *topo;
 	struct phy_device_node *pdn;
 	int ret;
 
-	if (!topo) {
-		ret = netdev_alloc_phy_link_topology(dev);
-		if (ret)
-			return ret;
-
-		topo = dev->link_topo;
-	}
+	topo = phy_link_topo_get_or_alloc(dev);
+	if (IS_ERR(topo))
+		return PTR_ERR(topo);
 
 	pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
 	if (!pdn)
-- 
2.49.0


