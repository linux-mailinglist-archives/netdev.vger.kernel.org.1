Return-Path: <netdev+bounces-171662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC2DA4E0D3
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 15:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB7C189AB87
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 14:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0122066D3;
	Tue,  4 Mar 2025 14:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dYpWUpQc"
X-Original-To: netdev@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB375207670
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098225; cv=fail; b=u+chb228CwkVOZxpX+NU5amnxLWM3bsIYYQVL70pHoi+5wHSNXw+uYltxPlS7JkQHVktK2Er661d20Bx9xfVgcC7ZwgMlh03EkA/1o5b1oZtcU1P1QKa2UuuO7FlpgPBmhqnvnBsZ0MgjKIPd/Y/DYxELRvw74N4CU76r2AStA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098225; c=relaxed/simple;
	bh=+g7Gn7jFH78d/mjGIDNfJcss5z+8C0d+ADOMmxCzxgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qE0JFuv7w5crYFd3YQ2XZI63hN8IhxhHIrlI3mZmtWWf8s6+0HBdLSXlnO9Hwr7P3y+CQo+OQ86RdZgGmAJYxJunAHOwqikgoBfb234s14CyE1ToMBHcXZHjToh8OCTW4JVi8/tACQ3nqbDxIBJzN5aEE70cvbjRVss5hE3anv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=bootlin.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dYpWUpQc reason="signature verification failed"; arc=none smtp.client-ip=217.70.183.196; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; arc=fail smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 1C01D40F1CDD
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 17:23:42 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=dYpWUpQc
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dBZ2tMCzFwMw
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 17:20:38 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 1C0E342734; Tue,  4 Mar 2025 17:20:29 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dYpWUpQc
X-Envelope-From: <linux-kernel+bounces-541223-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dYpWUpQc
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 085AF42E58
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:05:54 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id D42B13064C12
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:05:54 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1B81891A00
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B141F37B8;
	Mon,  3 Mar 2025 09:03:43 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E161EF376;
	Mon,  3 Mar 2025 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740992618; cv=none; b=ATmMA/VTZg95kPkuSTRGVUUL6Pc0YDrXyahKYA3JDpHSxb/edG3DMn4CLxovuk8anF8keeQ2+4EFFWFRPasl+w3Im6L4FB2M8VLc3B2rhC7/+q+Bs1ZO+wsIjhEF8ODs1P6fDzepgIV4Ci2p3TQXBJkvX+9KuoC3JsjsqtEnp3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740992618; c=relaxed/simple;
	bh=007c1HzORWeBW1+Unljk6A61fsRxfjDsejdgDv3YYj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzZ4Gf2KvwxFIfRlHp3hj4t/Khznqkb17/g4+9+gvbDUs0eV+YFHi0wOwb0BM1VRkMc7stayPbX5k8J8ZQKdoIQhJuNwYH4bwBo47x8B1wuP4xRonvOpM4FRdDRB+CwE3qbmxhptox3cQuAG1Brb2GH0ypIyumeTkkgPMJ+dhsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dYpWUpQc; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DFCD944540;
	Mon,  3 Mar 2025 09:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740992614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D9+W74DUYTC9EfYFTkYyfAzz2dcJpVGh5swL3t37v84=;
	b=dYpWUpQcQbXhxYZXqHSney46LQjb3looF3QUI9Why+kbYKfNrXZgZHbB5PX46KpK9KCHw+
	eljD5p3mazauYJ14Em0EE/R5fH9tIg5XWtHva6tsz0oSYCldHQ7cGzGZJCvfhniL1B40+6
	lp2YmWsuNmccB+hsnoVEp9T67U/CB+FDU00U0kaqkRBkx2yRaRoBjxhpdp5YGaHWvzLno+
	h33s2ZfiaqEJqEM3ZDfVIAlpipW4rSNXvFCCQhpusFDX0mDW2xl6nqVx/bWREIB4RqRohv
	KZxP2r2oYhj5z7pyfKr29pDryN9+wlHHVp3X+R33Z8xGRmW1fJQ9ZAGxTJR2VA==
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
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next v4 06/13] net: phy: phy_caps: Implement link_capabilities lookup by linkmode
Date: Mon,  3 Mar 2025 10:03:12 +0100
Message-ID: <20250303090321.805785-7-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303090321.805785-1-maxime.chevallier@bootlin.com>
References: <20250303090321.805785-1-maxime.chevallier@bootlin.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeejudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgedtffelffelveeuleelgfejfeevvdejhfehgeefgfffvdefteegvedutefftdenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgri
 igvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dBZ2tMCzFwMw
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741702919.74685@cZp0ja7ImT7d44y7KFnpYA
X-ITU-MailScanner-SpamCheck: not spam

In several occasions, phylib needs to lookup a set of matching speed and
duplex against a given linkmode set. Instead of relying on the
phy_settings array and thus iterate over the whole linkmodes list, use
the link_capabilities array to lookup these matches, as we aren't
interested in the actual link setting that matches but rather the speed
and duplex for that setting.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V4: Switch to macro iterators for better readability (Russell)

 drivers/net/phy/phy-caps.h |  5 +++++
 drivers/net/phy/phy-core.c | 36 +++++++++++++-----------------
 drivers/net/phy/phy_caps.c | 45 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 21 deletions(-)

diff --git a/drivers/net/phy/phy-caps.h b/drivers/net/phy/phy-caps.h
index f35ede4e557d..7103cf508d7e 100644
--- a/drivers/net/phy/phy-caps.h
+++ b/drivers/net/phy/phy-caps.h
@@ -45,5 +45,10 @@ size_t phy_caps_speeds(unsigned int *speeds, size_t si=
ze,
 void phy_caps_linkmode_max_speed(u32 max_speed, unsigned long *linkmodes=
);
 bool phy_caps_valid(int speed, int duplex, const unsigned long *linkmode=
s);
=20
+const struct link_capabilities *
+phy_caps_lookup_by_linkmode(const unsigned long *linkmodes);
+
+const struct link_capabilities *
+phy_caps_lookup_by_linkmode_rev(const unsigned long *linkmodes, bool fdx=
_only);
=20
 #endif /* __PHY_CAPS_H */
diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index f62bc1be67b2..6cb8f857a7f1 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -468,16 +468,15 @@ EXPORT_SYMBOL_GPL(phy_resolve_aneg_pause);
 void phy_resolve_aneg_linkmode(struct phy_device *phydev)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
-	int i;
+	const struct link_capabilities *c;
=20
 	linkmode_and(common, phydev->lp_advertising, phydev->advertising);
=20
-	for (i =3D 0; i < ARRAY_SIZE(settings); i++)
-		if (test_bit(settings[i].bit, common)) {
-			phydev->speed =3D settings[i].speed;
-			phydev->duplex =3D settings[i].duplex;
-			break;
-		}
+	c =3D phy_caps_lookup_by_linkmode(common);
+	if (c) {
+		phydev->speed =3D c->speed;
+		phydev->duplex =3D c->duplex;
+	}
=20
 	phy_resolve_aneg_pause(phydev);
 }
@@ -495,7 +494,8 @@ EXPORT_SYMBOL_GPL(phy_resolve_aneg_linkmode);
 void phy_check_downshift(struct phy_device *phydev)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
-	int i, speed =3D SPEED_UNKNOWN;
+	const struct link_capabilities *c;
+	int speed =3D SPEED_UNKNOWN;
=20
 	phydev->downshifted_rate =3D 0;
=20
@@ -505,11 +505,9 @@ void phy_check_downshift(struct phy_device *phydev)
=20
 	linkmode_and(common, phydev->lp_advertising, phydev->advertising);
=20
-	for (i =3D 0; i < ARRAY_SIZE(settings); i++)
-		if (test_bit(settings[i].bit, common)) {
-			speed =3D settings[i].speed;
-			break;
-		}
+	c =3D phy_caps_lookup_by_linkmode(common);
+	if (c)
+		speed =3D c->speed;
=20
 	if (speed =3D=3D SPEED_UNKNOWN || phydev->speed >=3D speed)
 		return;
@@ -523,17 +521,13 @@ void phy_check_downshift(struct phy_device *phydev)
 static int phy_resolve_min_speed(struct phy_device *phydev, bool fdx_onl=
y)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
-	int i =3D ARRAY_SIZE(settings);
+	const struct link_capabilities *c;
=20
 	linkmode_and(common, phydev->lp_advertising, phydev->advertising);
=20
-	while (--i >=3D 0) {
-		if (test_bit(settings[i].bit, common)) {
-			if (fdx_only && settings[i].duplex !=3D DUPLEX_FULL)
-				continue;
-			return settings[i].speed;
-		}
-	}
+	c =3D phy_caps_lookup_by_linkmode_rev(common, fdx_only);
+	if (c)
+		return c->speed;
=20
 	return SPEED_UNKNOWN;
 }
diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
index 8ce7dca1acd0..8160cb53b5ae 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -113,6 +113,51 @@ size_t phy_caps_speeds(unsigned int *speeds, size_t =
size,
 	return count;
 }
=20
+/**
+ * phy_caps_lookup_by_linkmode() - Lookup the fastest matching link_capa=
bilities
+ * @linkmodes: Linkmodes to match against
+ *
+ * Returns: The highest-speed link_capabilities that intersects the give=
n
+ *	    linkmodes. In case several DUPLEX_ options exist at that speed,
+ *	    DUPLEX_FULL is matched first. NULL is returned if no match.
+ */
+const struct link_capabilities *
+phy_caps_lookup_by_linkmode(const unsigned long *linkmodes)
+{
+	struct link_capabilities *lcap;
+
+	for_each_link_caps_desc_speed(lcap)
+		if (linkmode_intersects(lcap->linkmodes, linkmodes))
+			return lcap;
+
+	return NULL;
+}
+
+/**
+ * phy_caps_lookup_by_linkmode_rev() - Lookup the slowest matching link_=
capabilities
+ * @linkmodes: Linkmodes to match against
+ * @fdx_only: Full duplex match only when set
+ *
+ * Returns: The lowest-speed link_capabilities that intersects the given
+ *	    linkmodes. When set, fdx_only will ignore half-duplex matches.
+ *	    NULL is returned if no match.
+ */
+const struct link_capabilities *
+phy_caps_lookup_by_linkmode_rev(const unsigned long *linkmodes, bool fdx=
_only)
+{
+	struct link_capabilities *lcap;
+
+	for_each_link_caps_asc_speed(lcap) {
+		if (fdx_only && lcap->duplex !=3D DUPLEX_FULL)
+			continue;
+
+		if (linkmode_intersects(lcap->linkmodes, linkmodes))
+			return lcap;
+	}
+
+	return NULL;
+}
+
 /**
  * phy_caps_linkmode_max_speed() - Clamp a linkmodes set to a max speed
  * @max_speed: Speed limit for the linkmode set
--=20
2.48.1



