Return-Path: <netdev+bounces-171128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA9FA4BA3D
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287AA3B1BDE
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52A41F1906;
	Mon,  3 Mar 2025 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lOH5T/zF"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF7D1F0E45;
	Mon,  3 Mar 2025 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740992621; cv=none; b=W6I3wf4puX1VD+neX/l4PR8TzjRHDyEtoSG9RagmERQPnt9666ER4dgrP7KPOSir27wQgs9Us1Rrk2S+jvCO3NLxRW3SUH7tssKprV/AGCYM5CkqJ3bGjtRrdcP5C9SKHPWV2wVDwOUdj6GZ/4KMvfEoAVipaxjg2eyPlP/6mTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740992621; c=relaxed/simple;
	bh=RoHjDZVilDblKHGgJDjvWcx8Y+lD2cNS3JB1IA0xgNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2nH67Qo2fBf7VzYD79rvMw9ve39MCc84QBm4szSxfmJGWVtCeBgItyTPvng5LV13SuGPRKpNlbOwDhzBKAIhNBD1heRG6tZjX0qzU7yBRUp3LHjGCXPB81FtjyCXkUxdASwTU4GtM2Im8BADguVnp2Za+mKI9zDcu3OValZN50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lOH5T/zF; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 465B84453B;
	Mon,  3 Mar 2025 09:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740992618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K7de/OtF8soUmxaxOwbDw+qGUhPRZ5ORnq2JELjEnq4=;
	b=lOH5T/zFSwOZQwtjT0gEQM1V043YHa7mtJES4OwvqbBmjLTKCqgbncxuKZ5JMFwuvrwRkz
	VY0ktdI0f71h83Z+/AsS6BjWGKwvh1JeezWqnpOy8N8Tm5IY74JWDBH/B4+kxvp8gvGmwF
	7H+rITQbrZHeJAPZL9VXBSaut4grHHamGlgAe1JzUW60x4Z6oNYTG59SdGqSJ6Ebkgs03Z
	aGnbuUNJYU8Bv4wzOGtAR8fYWeSpKX7ODeK4dWhhts0IYwP7/hxcicfQJFvePVmbvONHG1
	1UuucOQV7sd6et7J23ZFyQxFqX17UZugAClm06YZZIADUmEtEp2wsDMzzxqrVg==
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
Subject: [PATCH net-next v4 09/13] net: phylink: Use phy_caps_lookup for fixed-link configuration
Date: Mon,  3 Mar 2025 10:03:15 +0100
Message-ID: <20250303090321.805785-10-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303090321.805785-1-maxime.chevallier@bootlin.com>
References: <20250303090321.805785-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeejudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgedtffelffelveeuleelgfejfeevvdejhfehgeefgfffvdefteegvedutefftdenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpeeinecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgri
 igvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

When phylink creates a fixed-link configuration, it finds a matching
linkmode to set as the advertised, lp_advertising and supported modes
based on the speed and duplex of the fixed link.

Use the newly introduced phy_caps_lookup to get these modes instead of
phy_lookup_settings(). This has the side effect that the matched
settings and configured linkmodes may now contain several linkmodes (the
intersection of supported linkmodes from the phylink settings and the
linkmodes that match speed/duplex) instead of the one from
phy_lookup_settings().

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V4: Remove unnecessary linklmode_zero in phylink_set_fixed_link(),
follwing Russell's comment

 drivers/net/phy/phylink.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 6c67d5c9b787..0b9585cb508e 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -805,9 +805,10 @@ static int phylink_validate(struct phylink *pl, unsigned long *supported,
 static int phylink_parse_fixedlink(struct phylink *pl,
 				   const struct fwnode_handle *fwnode)
 {
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(match) = { 0, };
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = { 0, };
+	const struct link_capabilities *c;
 	struct fwnode_handle *fixed_node;
-	const struct phy_setting *s;
 	struct gpio_desc *desc;
 	u32 speed;
 	int ret;
@@ -879,8 +880,10 @@ static int phylink_parse_fixedlink(struct phylink *pl,
 	linkmode_copy(pl->link_config.advertising, pl->supported);
 	phylink_validate(pl, pl->supported, &pl->link_config);
 
-	s = phy_lookup_setting(pl->link_config.speed, pl->link_config.duplex,
-			       pl->supported, true);
+	c = phy_caps_lookup(pl->link_config.speed, pl->link_config.duplex,
+			    pl->supported, true);
+	if (c)
+		linkmode_and(match, pl->supported, c->linkmodes);
 
 	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, mask);
 	linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, mask);
@@ -889,9 +892,10 @@ static int phylink_parse_fixedlink(struct phylink *pl,
 
 	phylink_set(pl->supported, MII);
 
-	if (s) {
-		__set_bit(s->bit, pl->supported);
-		__set_bit(s->bit, pl->link_config.lp_advertising);
+	if (c) {
+		linkmode_or(pl->supported, pl->supported, match);
+		linkmode_or(pl->link_config.lp_advertising,
+			    pl->link_config.lp_advertising, match);
 	} else {
 		phylink_warn(pl, "fixed link %s duplex %dMbps not recognised\n",
 			     pl->link_config.duplex == DUPLEX_FULL ? "full" : "half",
@@ -1879,21 +1883,20 @@ static int phylink_register_sfp(struct phylink *pl,
 int phylink_set_fixed_link(struct phylink *pl,
 			   const struct phylink_link_state *state)
 {
-	const struct phy_setting *s;
+	const struct link_capabilities *c;
 	unsigned long *adv;
 
 	if (pl->cfg_link_an_mode != MLO_AN_PHY || !state ||
 	    !test_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state))
 		return -EINVAL;
 
-	s = phy_lookup_setting(state->speed, state->duplex,
-			       pl->supported, true);
-	if (!s)
+	c = phy_caps_lookup(state->speed, state->duplex,
+			    pl->supported, true);
+	if (!c)
 		return -EINVAL;
 
 	adv = pl->link_config.advertising;
-	linkmode_zero(adv);
-	linkmode_set_bit(s->bit, adv);
+	linkmode_and(adv, pl->supported, c->linkmodes);
 	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, adv);
 
 	pl->link_config.speed = state->speed;
-- 
2.48.1


