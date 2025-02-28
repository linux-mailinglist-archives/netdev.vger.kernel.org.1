Return-Path: <netdev+bounces-170747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F615A49C82
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 15:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C0C1898CFB
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 14:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B60A274272;
	Fri, 28 Feb 2025 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ozLt+qPL"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E40827182A;
	Fri, 28 Feb 2025 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754551; cv=none; b=qUSGsrN+ZYjx636isWY3g9/h0GcqbT8MLgMqKVQCcUP08w0KN26beZ/S7nq+5j/8GGGy6FW1N7ewYHpTOd/VRpE90KbR+P3qhIALNIYhX+uRupjtcIUoSpsY09oBByPyoRncW1EIkc2OEyMEj1LZAuSEgllT0Fpyke+eBeI0xFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754551; c=relaxed/simple;
	bh=q9vwEaBmfzG/aYEWRV+VwZqAt3ozxuTPm1SXZZh/Yis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Goy82MV4KClFFJq4QBvhAEWMwH3IRkP0lRSlbRJY7+BBQELPBfX2UJW71sPbJafYLte15uSgy7Pc6dgbY6dgVDF0naMheJJscOx4jnYHeJT1i60Ax6eJ5X879aQ76zpGjhNzAG/52vR0Q/5X8k7PW4M5kRh8iGO0VoFw8cTo/lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ozLt+qPL; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9CF1C41DF6;
	Fri, 28 Feb 2025 14:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740754547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+J/HpjUPC0uwoncA0e+2cWmDxmgAJ4APiDJo/YhCFEg=;
	b=ozLt+qPLLuklSyoRmzogznyjCRCCvbdAfKRdsF1XeXEzr82UR9Uyv76FQKlj6EkefR8NYG
	yT2n5ejxdjFbE6ysMIAbldmmNkk97WtoKzeDGB6eD/mtRMMP/6rWcdVEomrKsH43MWArFF
	J4FA2IlIbKirpht69cE65e7gW+BInXxL3BFKU9JZ1SdMgEKgxDiKjxPeEMyNAe+twgYAAY
	F9JQc6yRAyNYqw0VW6FDzwh6vCDSOrUinKX5ijVyB6U96EQUE+yUz4pHpjR5+ouO7AXiBc
	fpAADyO8g/qBD7T8jeKLAB7CFhAT8GxarIb9WgpRIIdlCNJastNeDFhmOZRg7Q==
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
Subject: [PATCH net-next v3 04/13] net: phy: phy_caps: Move __set_linkmode_max_speed to phy_caps
Date: Fri, 28 Feb 2025 15:55:29 +0100
Message-ID: <20250228145540.2209551-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228145540.2209551-1-maxime.chevallier@bootlin.com>
References: <20250228145540.2209551-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdeilecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgedtffelffelveeuleelgfejfeevvdejhfehgeefgfffvdefteegvedutefftdenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgri
 igvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

Convert the __set_linkmode_max_speed to use the link_capabilities array.
This makes it easy to clamp the linkmodes to a given max speed.
Introduce a new helper phy_caps_linkmode_max_speed to replace the
previous one that used phy_settings.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy-caps.h |  2 ++
 drivers/net/phy/phy-core.c | 18 +++---------------
 drivers/net/phy/phy_caps.c | 16 ++++++++++++++++
 3 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/net/phy/phy-caps.h b/drivers/net/phy/phy-caps.h
index f8cdfdb09242..3f011b63a417 100644
--- a/drivers/net/phy/phy-caps.h
+++ b/drivers/net/phy/phy-caps.h
@@ -43,5 +43,7 @@ void phy_caps_init(void);
 
 size_t phy_caps_speeds(unsigned int *speeds, size_t size,
 		       unsigned long *linkmodes);
+void phy_caps_linkmode_max_speed(u32 max_speed, unsigned long *linkmodes);
+
 
 #endif /* __PHY_CAPS_H */
diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 8533e57c3500..f62bc1be67b2 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -7,6 +7,7 @@
 #include <linux/of.h>
 
 #include "phylib-internal.h"
+#include "phy-caps.h"
 
 /**
  * phy_speed_to_str - Return a string representing the PHY link speed
@@ -339,22 +340,9 @@ phy_lookup_setting(int speed, int duplex, const unsigned long *mask, bool exact)
 }
 EXPORT_SYMBOL_GPL(phy_lookup_setting);
 
-static void __set_linkmode_max_speed(u32 max_speed, unsigned long *addr)
-{
-	const struct phy_setting *p;
-	int i;
-
-	for (i = 0, p = settings; i < ARRAY_SIZE(settings); i++, p++) {
-		if (p->speed > max_speed)
-			linkmode_clear_bit(p->bit, addr);
-		else
-			break;
-	}
-}
-
 static void __set_phy_supported(struct phy_device *phydev, u32 max_speed)
 {
-	__set_linkmode_max_speed(max_speed, phydev->supported);
+	phy_caps_linkmode_max_speed(max_speed, phydev->supported);
 }
 
 /**
@@ -557,7 +545,7 @@ int phy_speed_down_core(struct phy_device *phydev)
 	if (min_common_speed == SPEED_UNKNOWN)
 		return -EINVAL;
 
-	__set_linkmode_max_speed(min_common_speed, phydev->advertising);
+	phy_caps_linkmode_max_speed(min_common_speed, phydev->advertising);
 
 	return 0;
 }
diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
index e5c716365b36..9075f9840ebd 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -103,3 +103,19 @@ size_t phy_caps_speeds(unsigned int *speeds, size_t size,
 
 	return count;
 }
+
+/**
+ * phy_caps_linkmode_max_speed() - Clamp a linkmodes set to a max speed
+ * @max_speed: Speed limit for the linkmode set
+ * @linkmodes: Linkmodes to limit
+ */
+void phy_caps_linkmode_max_speed(u32 max_speed, unsigned long *linkmodes)
+{
+	int capa;
+
+	for (capa = __LINK_CAPA_LAST; capa >= 0; capa--)
+		if (link_caps[capa].speed > max_speed)
+			linkmode_andnot(linkmodes, linkmodes, link_caps[capa].linkmodes);
+		else
+			break;
+}
-- 
2.48.1


