Return-Path: <netdev+bounces-168768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91268A408FF
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 15:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB64188ADFF
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 14:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACB92063E5;
	Sat, 22 Feb 2025 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kg+yXU3f"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D99198E76;
	Sat, 22 Feb 2025 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740234467; cv=none; b=XPs4p3iE7WEGvn3ibKCYYV/DIXzuDvSY61KWmeJN2oJsXPQSuhsud2pz0MG/tUq7i0ATDWU+zrASbZhKSDi0VoeZtWv8wq0CXQoVhM4MBv54IQIOi3rrT6nkKo9JQiLLvitWBbuVnWeOfR1gcT94O4iKrPAiTYktCMs1ALr//KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740234467; c=relaxed/simple;
	bh=17W5DpwWLDJnjZP+zIQ9TCJhoF/q9wgqNkB2qi1qqE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPPPVha2VP2Xh+6eaeKjjwNOjb4JsCbHiAkR8pVu64SYIMbPS0neaFG3aLCKado18/ySbD9dxaUUy6IScVnYJ+Gps/O28Piy7tJ4KDR7LDapaxdfIo6f2lbuhlGna0ZO26/BLgK/x/xHIDQuDDy5aOAbo0tyMc5FC8pbcuzT0S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kg+yXU3f; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8A4D54427C;
	Sat, 22 Feb 2025 14:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740234456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mE0nVjhMYce8SyWUFO7qJ6cOt2Ec4eykh043tqwW/j0=;
	b=kg+yXU3fy/ljhnW2SfxHbOcJ67Ex9VH0ep52fRRup+5/aYbcewrM0MbzER5B8P2SO4HToU
	zKsnv2OVEh5ts8pYGj8S6ri/Px+fBQ4M084e38zviC53p5sZrZ1c0A7e5UxY4vw/jySoqk
	JdUvrWFWp79xxQmwcr/4jcvHK50mcOwyqWHx90rTfVPLaYctkLGeSWwYFi9g/vIuKQmD6S
	3UQWh5ZLdd99QW16w8LE6E5tfQOBxTBfREpSr2MzLJcxkpWRMcMl242pKbScO70o9n3bXr
	y1sctQzljJXJ4jx/bZOh2BW4IZTdlOOsZZRplZpmlh/DfZGHMMI4y063TlsmrQ==
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
Subject: [PATCH net-next 03/13] net: phy: phylink: Extract getting the max speed for a given interface
Date: Sat, 22 Feb 2025 15:27:15 +0100
Message-ID: <20250222142727.894124-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250222142727.894124-1-maxime.chevallier@bootlin.com>
References: <20250222142727.894124-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejfeduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgedtffelffelveeuleelgfejfeevvdejhfehgeefgfffvdefteegvedutefftdenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgri
 igvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

Make the phylink helper 'phylink_interface_max_speed' part of the
phy_caps helper set, making phy_interface_t parameter handling
accessible for other uses.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy-caps.h |  1 +
 drivers/net/phy/phy_caps.c | 72 +++++++++++++++++++++++++++++++++++
 drivers/net/phy/phylink.c  | 77 ++------------------------------------
 3 files changed, 76 insertions(+), 74 deletions(-)

diff --git a/drivers/net/phy/phy-caps.h b/drivers/net/phy/phy-caps.h
index ecb63b28c5fb..9580754fff1f 100644
--- a/drivers/net/phy/phy-caps.h
+++ b/drivers/net/phy/phy-caps.h
@@ -10,5 +10,6 @@
 void linkmode_from_caps(unsigned long *linkmode, unsigned long caps);
 
 unsigned long phy_interface_caps(phy_interface_t interface);
+int phy_interface_max_speed(phy_interface_t interface);
 
 #endif /* __PHY_CAPS_H */
diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
index 59e4505b7336..cf68a2829bde 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -251,3 +251,75 @@ unsigned long phy_interface_caps(phy_interface_t interface)
 	return caps;
 }
 EXPORT_SYMBOL_GPL(phy_interface_caps);
+
+/**
+ * phy_interface_max_speed() - get the maximum speed of a phy interface
+ * @interface: phy interface mode defined by &typedef phy_interface_t
+ *
+ * Determine the maximum speed of a phy interface. This is intended to help
+ * determine the correct speed to pass to the MAC when the phy is performing
+ * rate matching.
+ *
+ * Return: The maximum speed of @interface
+ */
+int phy_interface_max_speed(phy_interface_t interface)
+{
+	switch (interface) {
+	case PHY_INTERFACE_MODE_100BASEX:
+	case PHY_INTERFACE_MODE_REVRMII:
+	case PHY_INTERFACE_MODE_RMII:
+	case PHY_INTERFACE_MODE_SMII:
+	case PHY_INTERFACE_MODE_REVMII:
+	case PHY_INTERFACE_MODE_MII:
+		return SPEED_100;
+
+	case PHY_INTERFACE_MODE_TBI:
+	case PHY_INTERFACE_MODE_MOCA:
+	case PHY_INTERFACE_MODE_RTBI:
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_1000BASEKX:
+	case PHY_INTERFACE_MODE_TRGMII:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_PSGMII:
+	case PHY_INTERFACE_MODE_QSGMII:
+	case PHY_INTERFACE_MODE_QUSGMII:
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_GMII:
+		return SPEED_1000;
+
+	case PHY_INTERFACE_MODE_2500BASEX:
+	case PHY_INTERFACE_MODE_10G_QXGMII:
+		return SPEED_2500;
+
+	case PHY_INTERFACE_MODE_5GBASER:
+		return SPEED_5000;
+
+	case PHY_INTERFACE_MODE_XGMII:
+	case PHY_INTERFACE_MODE_RXAUI:
+	case PHY_INTERFACE_MODE_XAUI:
+	case PHY_INTERFACE_MODE_10GBASER:
+	case PHY_INTERFACE_MODE_10GKR:
+	case PHY_INTERFACE_MODE_USXGMII:
+		return SPEED_10000;
+
+	case PHY_INTERFACE_MODE_25GBASER:
+		return SPEED_25000;
+
+	case PHY_INTERFACE_MODE_XLGMII:
+		return SPEED_40000;
+
+	case PHY_INTERFACE_MODE_INTERNAL:
+	case PHY_INTERFACE_MODE_NA:
+	case PHY_INTERFACE_MODE_MAX:
+		/* No idea! Garbage in, unknown out */
+		return SPEED_UNKNOWN;
+	}
+
+	/* If we get here, someone forgot to add an interface mode above */
+	WARN_ON_ONCE(1);
+	return SPEED_UNKNOWN;
+}
+EXPORT_SYMBOL_GPL(phy_interface_max_speed);
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index c05c0921c5d0..af04be1d23c5 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -221,77 +221,6 @@ static unsigned int phylink_interface_signal_rate(phy_interface_t interface)
 	}
 }
 
-/**
- * phylink_interface_max_speed() - get the maximum speed of a phy interface
- * @interface: phy interface mode defined by &typedef phy_interface_t
- *
- * Determine the maximum speed of a phy interface. This is intended to help
- * determine the correct speed to pass to the MAC when the phy is performing
- * rate matching.
- *
- * Return: The maximum speed of @interface
- */
-static int phylink_interface_max_speed(phy_interface_t interface)
-{
-	switch (interface) {
-	case PHY_INTERFACE_MODE_100BASEX:
-	case PHY_INTERFACE_MODE_REVRMII:
-	case PHY_INTERFACE_MODE_RMII:
-	case PHY_INTERFACE_MODE_SMII:
-	case PHY_INTERFACE_MODE_REVMII:
-	case PHY_INTERFACE_MODE_MII:
-		return SPEED_100;
-
-	case PHY_INTERFACE_MODE_TBI:
-	case PHY_INTERFACE_MODE_MOCA:
-	case PHY_INTERFACE_MODE_RTBI:
-	case PHY_INTERFACE_MODE_1000BASEX:
-	case PHY_INTERFACE_MODE_1000BASEKX:
-	case PHY_INTERFACE_MODE_TRGMII:
-	case PHY_INTERFACE_MODE_RGMII_TXID:
-	case PHY_INTERFACE_MODE_RGMII_RXID:
-	case PHY_INTERFACE_MODE_RGMII_ID:
-	case PHY_INTERFACE_MODE_RGMII:
-	case PHY_INTERFACE_MODE_PSGMII:
-	case PHY_INTERFACE_MODE_QSGMII:
-	case PHY_INTERFACE_MODE_QUSGMII:
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_GMII:
-		return SPEED_1000;
-
-	case PHY_INTERFACE_MODE_2500BASEX:
-	case PHY_INTERFACE_MODE_10G_QXGMII:
-		return SPEED_2500;
-
-	case PHY_INTERFACE_MODE_5GBASER:
-		return SPEED_5000;
-
-	case PHY_INTERFACE_MODE_XGMII:
-	case PHY_INTERFACE_MODE_RXAUI:
-	case PHY_INTERFACE_MODE_XAUI:
-	case PHY_INTERFACE_MODE_10GBASER:
-	case PHY_INTERFACE_MODE_10GKR:
-	case PHY_INTERFACE_MODE_USXGMII:
-		return SPEED_10000;
-
-	case PHY_INTERFACE_MODE_25GBASER:
-		return SPEED_25000;
-
-	case PHY_INTERFACE_MODE_XLGMII:
-		return SPEED_40000;
-
-	case PHY_INTERFACE_MODE_INTERNAL:
-	case PHY_INTERFACE_MODE_NA:
-	case PHY_INTERFACE_MODE_MAX:
-		/* No idea! Garbage in, unknown out */
-		return SPEED_UNKNOWN;
-	}
-
-	/* If we get here, someone forgot to add an interface mode above */
-	WARN_ON_ONCE(1);
-	return SPEED_UNKNOWN;
-}
-
 static struct {
 	unsigned long mask;
 	int speed;
@@ -371,7 +300,7 @@ static unsigned long phylink_get_capabilities(phy_interface_t interface,
 					      unsigned long mac_capabilities,
 					      int rate_matching)
 {
-	int max_speed = phylink_interface_max_speed(interface);
+	int max_speed = phy_interface_max_speed(interface);
 	unsigned long caps = phy_interface_caps(interface);
 	unsigned long matched_caps = 0;
 
@@ -1418,7 +1347,7 @@ static void phylink_link_up(struct phylink *pl,
 		 * the link_state) to the interface speed, and will send
 		 * pause frames to the MAC to limit its transmission speed.
 		 */
-		speed = phylink_interface_max_speed(link_state.interface);
+		speed = phy_interface_max_speed(link_state.interface);
 		duplex = DUPLEX_FULL;
 		rx_pause = true;
 		break;
@@ -1428,7 +1357,7 @@ static void phylink_link_up(struct phylink *pl,
 		 * the link_state) to the interface speed, and will cause
 		 * collisions to the MAC to limit its transmission speed.
 		 */
-		speed = phylink_interface_max_speed(link_state.interface);
+		speed = phy_interface_max_speed(link_state.interface);
 		duplex = DUPLEX_HALF;
 		break;
 	}
-- 
2.48.1


