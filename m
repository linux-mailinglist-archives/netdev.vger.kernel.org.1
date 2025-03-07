Return-Path: <netdev+bounces-173036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8902A56F38
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 18:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEF07179FCC
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 17:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A2F241670;
	Fri,  7 Mar 2025 17:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SXgA8NnI"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CD42417D7;
	Fri,  7 Mar 2025 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368990; cv=none; b=mdqdZ6inwPayo2frvxrWh1r3l2gjoANsx4zl3eChwdk/tH5kA+WeNsarbU8LHSneNxeg7DP25jQw33sAjkjwvtqwoKAMPYzOoG+LrPTN+shJCdAKVOr3U1YnRCxad+AXij0wOpl2dwp1M8WwTwvpW8jRQY0X2X6UZXzWWksgZ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368990; c=relaxed/simple;
	bh=LcrmNFqkf9mltWpePWv4YcSsz7kpJAo6wt+wT/rSss4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPmNMvxhLzkdM5tesvEXHkC5134EnLcX12Si81vXnucqGJ19+9P1hPHnNsAeyerlHYGIIb9fY/OFR5+rQxdkPtmq8Z+iqx/zUESwJv494BD2lqZC7mYKq+H1Q89FtRKHy1Yft6pbwGk/ncC6dlzdG9JuJKEIHQWX5gCDAnlI3tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SXgA8NnI; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3FACE204CC;
	Fri,  7 Mar 2025 17:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741368986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gOTBrAWgomwpXzetebdPwqIn4CzSTSazGmOiV/vOWH0=;
	b=SXgA8NnIIQhvUl8fZMdzrcIdgW2JwjZ+Pvs0V80j+ajbjJ8VCm+M1fFypevRJ0xrcQBD8c
	GvbR0nwQjXYHna7xPwNS/nSwMMnZE4Lfg5Vbyw670x/Xz6vnEEAjf062WxuvVfJSO0DvVf
	zwsPj4UuCgd0nvFm4uCZRcjxjhn3yuNRBN8MHMbLPMbp7GQ62j4/Z94sSMyl+p5ilQEAEJ
	+CDBAWpNVDkkxxyeVET3wXmMraNWvp19aKkhMNzN9CNtU4UFFcGSab0BiRtvO4D64kyKbK
	E/Kb+0ICBqT7p6K6z6+rvcKf/k8/Br9i6SDve5pxQaUrKaMCVuIGmyLOf+wbJw==
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
Subject: [PATCH net-next v5 09/13] net: phylink: Use phy_caps_lookup for fixed-link configuration
Date: Fri,  7 Mar 2025 18:36:06 +0100
Message-ID: <20250307173611.129125-10-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
References: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveegtdffleffleevueellefgjeefvedvjefhheegfefgffdvfeetgeevudetffdtnecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgepjeenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmr
 giivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhm
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
 drivers/net/phy/phylink.c | 44 +++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index cf9f019382ad..8e2b7d647a92 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -802,12 +802,26 @@ static int phylink_validate(struct phylink *pl, unsigned long *supported,
 	return phylink_validate_mac_and_pcs(pl, supported, state);
 }
 
+static void phylink_fill_fixedlink_supported(unsigned long *supported)
+{
+	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, supported);
+}
+
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
@@ -875,12 +889,16 @@ static int phylink_parse_fixedlink(struct phylink *pl,
 		phylink_warn(pl, "fixed link specifies half duplex for %dMbps link?\n",
 			     pl->link_config.speed);
 
-	linkmode_fill(pl->supported);
+	linkmode_zero(pl->supported);
+	phylink_fill_fixedlink_supported(pl->supported);
+
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
@@ -889,9 +907,10 @@ static int phylink_parse_fixedlink(struct phylink *pl,
 
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
@@ -1879,21 +1898,20 @@ static int phylink_register_sfp(struct phylink *pl,
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


