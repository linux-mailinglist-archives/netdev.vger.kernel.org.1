Return-Path: <netdev+bounces-170753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E3DA49C91
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 15:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE0A174190
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 14:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC70028134B;
	Fri, 28 Feb 2025 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QOM92Ljj"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923A427FE85;
	Fri, 28 Feb 2025 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754557; cv=none; b=nnVycqzSHRD5QhFT3iD4imFLDMNaDub0FPL6l5sFtFDA7Nn8UsMk/JYKW49GM2mkN+4OD7N03Vp4Zw5Nji1SoHYVKZM5YT3fZMDePaB4qbmyatx+auzZf01AE/BbBSPdCv9XPLR196vRrPE+v7E/0Qm6CRzO8j+1m9pCcFBE6aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754557; c=relaxed/simple;
	bh=HaGWPiQLi8g2oCBDshsuN4+48r5L5ts5ve2sX78DEr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNghlNBSb2YJby+S5W9xPmQAsuMY5qQTxEN8tdWuwIFCFolsKlo5Iw0uoXa02FmR6vaGhL8sfEREQkazpwtjqIz8D/8C16iCLUplRZrKBQvTl0KDt3NqD8FMnQUMi2gELElo/xh3le4eSyxhs/pucgTsC43lqAWl3xFMxgmJhC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QOM92Ljj; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F1F22443FA;
	Fri, 28 Feb 2025 14:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740754554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kxC2ZGFkbRAqIZMBmo0qAZXeuOHlxHKdlpDBQ0LMTAE=;
	b=QOM92LjjM62/ZcRAraYYD2ngWtiUKVHgE1OMbG80GwNtiAXb1HqJFBfOfj4UNVFQZJ8D+d
	f6RRnf/WBcBZiaDHTA6YUbXJR7ywmMMKaG1CN1EaVljML6fmDebEHW8Wjosbbr2Wz5JIjJ
	oxTeZ+GU4dyKXPHu1Xr5hHgSjzD0mzKX9KMIX2rwJ7/EuvmhoCFuKr57UioYcBwBSfmhTU
	u8c3Na68MuSBAbNpiFkhE54lgCoEeZPdAgocwLuNpfNusOSeUYcrvExTL0UEDB9OcTtvlU
	CF3pK+0LaFBwmeyatv+B0RgwbAd4jtdow3NeFCWR5bRXYgQ8j86JDm/lZAqHEg==
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
Subject: [PATCH net-next v3 10/13] net: phy: drop phy_settings and the associated lookup helpers
Date: Fri, 28 Feb 2025 15:55:35 +0100
Message-ID: <20250228145540.2209551-11-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdeilecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgedtffelffelveeuleelgfejfeevvdejhfehgeefgfffvdefteegvedutefftdenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpeejnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgri
 igvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

The phy_settings array is no longer relevant as it has now been replaced
by the link_caps array and associated phy_caps helpers.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy-core.c | 184 -------------------------------------
 include/linux/phy.h        |  13 ---
 2 files changed, 197 deletions(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 6cb8f857a7f1..e7d0137abd48 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -156,190 +156,6 @@ int phy_interface_num_ports(phy_interface_t interface)
 }
 EXPORT_SYMBOL_GPL(phy_interface_num_ports);
 
-/* A mapping of all SUPPORTED settings to speed/duplex.  This table
- * must be grouped by speed and sorted in descending match priority
- * - iow, descending speed.
- */
-
-#define PHY_SETTING(s, d, b) { .speed = SPEED_ ## s, .duplex = DUPLEX_ ## d, \
-			       .bit = ETHTOOL_LINK_MODE_ ## b ## _BIT}
-
-static const struct phy_setting settings[] = {
-	/* 800G */
-	PHY_SETTING( 800000, FULL, 800000baseCR8_Full		),
-	PHY_SETTING( 800000, FULL, 800000baseKR8_Full		),
-	PHY_SETTING( 800000, FULL, 800000baseDR8_Full		),
-	PHY_SETTING( 800000, FULL, 800000baseDR8_2_Full		),
-	PHY_SETTING( 800000, FULL, 800000baseSR8_Full		),
-	PHY_SETTING( 800000, FULL, 800000baseVR8_Full		),
-	PHY_SETTING( 800000, FULL, 800000baseCR4_Full		),
-	PHY_SETTING( 800000, FULL, 800000baseKR4_Full		),
-	PHY_SETTING( 800000, FULL, 800000baseDR4_Full		),
-	PHY_SETTING( 800000, FULL, 800000baseDR4_2_Full		),
-	PHY_SETTING( 800000, FULL, 800000baseSR4_Full		),
-	PHY_SETTING( 800000, FULL, 800000baseVR4_Full		),
-	/* 400G */
-	PHY_SETTING( 400000, FULL, 400000baseCR8_Full		),
-	PHY_SETTING( 400000, FULL, 400000baseKR8_Full		),
-	PHY_SETTING( 400000, FULL, 400000baseLR8_ER8_FR8_Full	),
-	PHY_SETTING( 400000, FULL, 400000baseDR8_Full		),
-	PHY_SETTING( 400000, FULL, 400000baseSR8_Full		),
-	PHY_SETTING( 400000, FULL, 400000baseCR4_Full		),
-	PHY_SETTING( 400000, FULL, 400000baseKR4_Full		),
-	PHY_SETTING( 400000, FULL, 400000baseLR4_ER4_FR4_Full	),
-	PHY_SETTING( 400000, FULL, 400000baseDR4_Full		),
-	PHY_SETTING( 400000, FULL, 400000baseSR4_Full		),
-	PHY_SETTING( 400000, FULL, 400000baseCR2_Full		),
-	PHY_SETTING( 400000, FULL, 400000baseKR2_Full		),
-	PHY_SETTING( 400000, FULL, 400000baseDR2_Full		),
-	PHY_SETTING( 400000, FULL, 400000baseDR2_2_Full		),
-	PHY_SETTING( 400000, FULL, 400000baseSR2_Full		),
-	PHY_SETTING( 400000, FULL, 400000baseVR2_Full		),
-	/* 200G */
-	PHY_SETTING( 200000, FULL, 200000baseCR4_Full		),
-	PHY_SETTING( 200000, FULL, 200000baseKR4_Full		),
-	PHY_SETTING( 200000, FULL, 200000baseLR4_ER4_FR4_Full	),
-	PHY_SETTING( 200000, FULL, 200000baseDR4_Full		),
-	PHY_SETTING( 200000, FULL, 200000baseSR4_Full		),
-	PHY_SETTING( 200000, FULL, 200000baseCR2_Full		),
-	PHY_SETTING( 200000, FULL, 200000baseKR2_Full		),
-	PHY_SETTING( 200000, FULL, 200000baseLR2_ER2_FR2_Full	),
-	PHY_SETTING( 200000, FULL, 200000baseDR2_Full		),
-	PHY_SETTING( 200000, FULL, 200000baseSR2_Full		),
-	PHY_SETTING( 200000, FULL, 200000baseCR_Full		),
-	PHY_SETTING( 200000, FULL, 200000baseKR_Full		),
-	PHY_SETTING( 200000, FULL, 200000baseDR_Full		),
-	PHY_SETTING( 200000, FULL, 200000baseDR_2_Full		),
-	PHY_SETTING( 200000, FULL, 200000baseSR_Full		),
-	PHY_SETTING( 200000, FULL, 200000baseVR_Full		),
-	/* 100G */
-	PHY_SETTING( 100000, FULL, 100000baseCR4_Full		),
-	PHY_SETTING( 100000, FULL, 100000baseKR4_Full		),
-	PHY_SETTING( 100000, FULL, 100000baseLR4_ER4_Full	),
-	PHY_SETTING( 100000, FULL, 100000baseSR4_Full		),
-	PHY_SETTING( 100000, FULL, 100000baseCR2_Full		),
-	PHY_SETTING( 100000, FULL, 100000baseKR2_Full		),
-	PHY_SETTING( 100000, FULL, 100000baseLR2_ER2_FR2_Full	),
-	PHY_SETTING( 100000, FULL, 100000baseDR2_Full		),
-	PHY_SETTING( 100000, FULL, 100000baseSR2_Full		),
-	PHY_SETTING( 100000, FULL, 100000baseCR_Full		),
-	PHY_SETTING( 100000, FULL, 100000baseKR_Full		),
-	PHY_SETTING( 100000, FULL, 100000baseLR_ER_FR_Full	),
-	PHY_SETTING( 100000, FULL, 100000baseDR_Full		),
-	PHY_SETTING( 100000, FULL, 100000baseSR_Full		),
-	/* 56G */
-	PHY_SETTING(  56000, FULL,  56000baseCR4_Full	  	),
-	PHY_SETTING(  56000, FULL,  56000baseKR4_Full	  	),
-	PHY_SETTING(  56000, FULL,  56000baseLR4_Full	  	),
-	PHY_SETTING(  56000, FULL,  56000baseSR4_Full	  	),
-	/* 50G */
-	PHY_SETTING(  50000, FULL,  50000baseCR2_Full		),
-	PHY_SETTING(  50000, FULL,  50000baseKR2_Full		),
-	PHY_SETTING(  50000, FULL,  50000baseSR2_Full		),
-	PHY_SETTING(  50000, FULL,  50000baseCR_Full		),
-	PHY_SETTING(  50000, FULL,  50000baseKR_Full		),
-	PHY_SETTING(  50000, FULL,  50000baseLR_ER_FR_Full	),
-	PHY_SETTING(  50000, FULL,  50000baseDR_Full		),
-	PHY_SETTING(  50000, FULL,  50000baseSR_Full		),
-	/* 40G */
-	PHY_SETTING(  40000, FULL,  40000baseCR4_Full		),
-	PHY_SETTING(  40000, FULL,  40000baseKR4_Full		),
-	PHY_SETTING(  40000, FULL,  40000baseLR4_Full		),
-	PHY_SETTING(  40000, FULL,  40000baseSR4_Full		),
-	/* 25G */
-	PHY_SETTING(  25000, FULL,  25000baseCR_Full		),
-	PHY_SETTING(  25000, FULL,  25000baseKR_Full		),
-	PHY_SETTING(  25000, FULL,  25000baseSR_Full		),
-	/* 20G */
-	PHY_SETTING(  20000, FULL,  20000baseKR2_Full		),
-	PHY_SETTING(  20000, FULL,  20000baseMLD2_Full		),
-	/* 10G */
-	PHY_SETTING(  10000, FULL,  10000baseCR_Full		),
-	PHY_SETTING(  10000, FULL,  10000baseER_Full		),
-	PHY_SETTING(  10000, FULL,  10000baseKR_Full		),
-	PHY_SETTING(  10000, FULL,  10000baseKX4_Full		),
-	PHY_SETTING(  10000, FULL,  10000baseLR_Full		),
-	PHY_SETTING(  10000, FULL,  10000baseLRM_Full		),
-	PHY_SETTING(  10000, FULL,  10000baseR_FEC		),
-	PHY_SETTING(  10000, FULL,  10000baseSR_Full		),
-	PHY_SETTING(  10000, FULL,  10000baseT_Full		),
-	/* 5G */
-	PHY_SETTING(   5000, FULL,   5000baseT_Full		),
-	/* 2.5G */
-	PHY_SETTING(   2500, FULL,   2500baseT_Full		),
-	PHY_SETTING(   2500, FULL,   2500baseX_Full		),
-	/* 1G */
-	PHY_SETTING(   1000, FULL,   1000baseT_Full		),
-	PHY_SETTING(   1000, HALF,   1000baseT_Half		),
-	PHY_SETTING(   1000, FULL,   1000baseT1_Full		),
-	PHY_SETTING(   1000, FULL,   1000baseX_Full		),
-	PHY_SETTING(   1000, FULL,   1000baseKX_Full		),
-	/* 100M */
-	PHY_SETTING(    100, FULL,    100baseT_Full		),
-	PHY_SETTING(    100, FULL,    100baseT1_Full		),
-	PHY_SETTING(    100, HALF,    100baseT_Half		),
-	PHY_SETTING(    100, HALF,    100baseFX_Half		),
-	PHY_SETTING(    100, FULL,    100baseFX_Full		),
-	/* 10M */
-	PHY_SETTING(     10, FULL,     10baseT_Full		),
-	PHY_SETTING(     10, HALF,     10baseT_Half		),
-	PHY_SETTING(     10, FULL,     10baseT1L_Full		),
-	PHY_SETTING(     10, FULL,     10baseT1S_Full		),
-	PHY_SETTING(     10, HALF,     10baseT1S_Half		),
-	PHY_SETTING(     10, HALF,     10baseT1S_P2MP_Half	),
-	PHY_SETTING(     10, FULL,     10baseT1BRR_Full		),
-};
-#undef PHY_SETTING
-
-/**
- * phy_lookup_setting - lookup a PHY setting
- * @speed: speed to match
- * @duplex: duplex to match
- * @mask: allowed link modes
- * @exact: an exact match is required
- *
- * Search the settings array for a setting that matches the speed and
- * duplex, and which is supported.
- *
- * If @exact is unset, either an exact match or %NULL for no match will
- * be returned.
- *
- * If @exact is set, an exact match, the fastest supported setting at
- * or below the specified speed, the slowest supported setting, or if
- * they all fail, %NULL will be returned.
- */
-const struct phy_setting *
-phy_lookup_setting(int speed, int duplex, const unsigned long *mask, bool exact)
-{
-	const struct phy_setting *p, *match = NULL, *last = NULL;
-	int i;
-
-	for (i = 0, p = settings; i < ARRAY_SIZE(settings); i++, p++) {
-		if (p->bit < __ETHTOOL_LINK_MODE_MASK_NBITS &&
-		    test_bit(p->bit, mask)) {
-			last = p;
-			if (p->speed == speed && p->duplex == duplex) {
-				/* Exact match for speed and duplex */
-				match = p;
-				break;
-			} else if (!exact) {
-				if (!match && p->speed <= speed)
-					/* Candidate */
-					match = p;
-
-				if (p->speed < speed)
-					break;
-			}
-		}
-	}
-
-	if (!match && !exact)
-		match = last;
-
-	return match;
-}
-EXPORT_SYMBOL_GPL(phy_lookup_setting);
-
 static void __set_phy_supported(struct phy_device *phydev, u32 max_speed)
 {
 	phy_caps_linkmode_max_speed(max_speed, phydev->supported);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 5749aad96862..4a59aa7254f4 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1310,19 +1310,6 @@ const char *phy_rate_matching_to_str(int rate_matching);
 
 int phy_interface_num_ports(phy_interface_t interface);
 
-/* A structure for mapping a particular speed and duplex
- * combination to a particular SUPPORTED and ADVERTISED value
- */
-struct phy_setting {
-	u32 speed;
-	u8 duplex;
-	u8 bit;
-};
-
-const struct phy_setting *
-phy_lookup_setting(int speed, int duplex, const unsigned long *mask,
-		   bool exact);
-
 /**
  * phy_is_started - Convenience function to check whether PHY is started
  * @phydev: The phy_device struct
-- 
2.48.1


