Return-Path: <netdev+bounces-169791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC09A45B60
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 11:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC2263AA744
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAF227425F;
	Wed, 26 Feb 2025 10:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OMR9/VO7"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CED3271836;
	Wed, 26 Feb 2025 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740564590; cv=none; b=R/CV2qAmbXNRprrUagLYhv1xnh7hi6YM3zRwW6J4/xGH5AXWD4fwVUWNnFY9Sn8//+Zjjltw1B3qW/mi+2obF8TcwF9wWCgGOuM1jKoETlfRUQpiDxd74IApRrjk9UV1pP7p+VfbRO77vr5ZYMmN9xVROAEqv5YCag8dXfCkFzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740564590; c=relaxed/simple;
	bh=vMi+sZAKzBQJZm+B5LEMN5rYsKvcBA+jGxi522waCCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gG5rYJrkkY98bscxGO6pYB19MBlg2lTYxoAxn5XT6UCiuuesV5xjDhqYxzOjLyzX3NZdKtMriVbwEiHocuLl12h0z8Gi3NReZpMsnw2mXeRuJ8Lo9F+7upv3DvY2yvGvFBrBQ439r1BOeMUsbK+TjJWoyBcLtGg0pMzKFz8z0Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OMR9/VO7; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 94CA143226;
	Wed, 26 Feb 2025 10:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740564586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RT9OmaMpBxEpgKolltHfi6tCwVWQ03w1ZzbeEoMhF1E=;
	b=OMR9/VO71KB0LLvnr9qM9AYOcygXPdEkAsRVvyZN2rJo7NvUeMmIcj3fzezGAexD0EylQl
	wAbG5l5T6/K6DZfca3p83QDvfHN3pOktNkqf2Fx2c4rLK/UI+EZliuY6v6H9F0vP5Q8DJk
	AxUk1M+0LVmtXW66VvhZvM+Ov7yHV6cz2BS1Vdp0AUYUit/dPO8608rgFRNzcEYVJAqiA8
	+NTAECUVek4hnERQtRFIzDVDWCWzoKaH7i3bqz+UMcpNirHufanA/Ezwn/VPLk81Y8ZcTX
	0yzjHYWZRXVOxDtrOSqg7vEdqdgHjQz5Q8n3O74MV9M3HP/yr0UE/z2TxR2vVg==
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
Subject: [PATCH net-next v2 11/13] net: phy: phylink: Add a mapping between MAC_CAPS and LINK_CAPS
Date: Wed, 26 Feb 2025 11:09:26 +0100
Message-ID: <20250226100929.1646454-12-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226100929.1646454-1-maxime.chevallier@bootlin.com>
References: <20250226100929.1646454-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgeeftdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgedtffelffelveeuleelgfejfeevvdejhfehgeefgfffvdefteegvedutefftdenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpeeinecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgri
 igvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

phylink allows MAC drivers to report the capabilities in terms of speed,
duplex and pause support. This is done through a dedicated set of enum
values in the form of the MAC_ capabilities. They are very close to what
the LINK_CAPA_xxx can express, with the difference that LINK_CAPA don't
have any information about Pause/Asym Pause support.

To prepare converting phylink to using the phy_caps, add the mapping
between MAC capabilities and phy_caps. While doing so, we move the
phylink_caps_params array up a bit to simplify future commits.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V1 -> V2: - New patch

 drivers/net/phy/phylink.c | 49 ++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 63fbf3d8708a..aaf07094b821 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -292,6 +292,31 @@ static int phylink_interface_max_speed(phy_interface_t interface)
 	return SPEED_UNKNOWN;
 }
 
+static struct {
+	unsigned long mask;
+	int speed;
+	unsigned int duplex;
+	unsigned int caps_bit;
+} phylink_caps_params[] = {
+	{ MAC_400000FD, SPEED_400000, DUPLEX_FULL, BIT(LINK_CAPA_400000FD) },
+	{ MAC_200000FD, SPEED_200000, DUPLEX_FULL, BIT(LINK_CAPA_200000FD) },
+	{ MAC_100000FD, SPEED_100000, DUPLEX_FULL, BIT(LINK_CAPA_100000FD) },
+	{ MAC_56000FD,  SPEED_56000,  DUPLEX_FULL, BIT(LINK_CAPA_56000FD) },
+	{ MAC_50000FD,  SPEED_50000,  DUPLEX_FULL, BIT(LINK_CAPA_50000FD) },
+	{ MAC_40000FD,  SPEED_40000,  DUPLEX_FULL, BIT(LINK_CAPA_40000FD) },
+	{ MAC_25000FD,  SPEED_25000,  DUPLEX_FULL, BIT(LINK_CAPA_25000FD) },
+	{ MAC_20000FD,  SPEED_20000,  DUPLEX_FULL, BIT(LINK_CAPA_20000FD) },
+	{ MAC_10000FD,  SPEED_10000,  DUPLEX_FULL, BIT(LINK_CAPA_10000FD) },
+	{ MAC_5000FD,   SPEED_5000,   DUPLEX_FULL, BIT(LINK_CAPA_5000FD) },
+	{ MAC_2500FD,   SPEED_2500,   DUPLEX_FULL, BIT(LINK_CAPA_2500FD) },
+	{ MAC_1000FD,   SPEED_1000,   DUPLEX_FULL, BIT(LINK_CAPA_1000FD) },
+	{ MAC_1000HD,   SPEED_1000,   DUPLEX_HALF, BIT(LINK_CAPA_1000HD) },
+	{ MAC_100FD,    SPEED_100,    DUPLEX_FULL, BIT(LINK_CAPA_100FD) },
+	{ MAC_100HD,    SPEED_100,    DUPLEX_HALF, BIT(LINK_CAPA_100HD) },
+	{ MAC_10FD,     SPEED_10,     DUPLEX_FULL, BIT(LINK_CAPA_10FD) },
+	{ MAC_10HD,     SPEED_10,     DUPLEX_HALF, BIT(LINK_CAPA_10HD) },
+};
+
 /**
  * phylink_caps_to_linkmodes() - Convert capabilities to ethtool link modes
  * @linkmodes: ethtool linkmode mask (must be already initialised)
@@ -445,30 +470,6 @@ static void phylink_caps_to_linkmodes(unsigned long *linkmodes,
 	}
 }
 
-static struct {
-	unsigned long mask;
-	int speed;
-	unsigned int duplex;
-} phylink_caps_params[] = {
-	{ MAC_400000FD, SPEED_400000, DUPLEX_FULL },
-	{ MAC_200000FD, SPEED_200000, DUPLEX_FULL },
-	{ MAC_100000FD, SPEED_100000, DUPLEX_FULL },
-	{ MAC_56000FD,  SPEED_56000,  DUPLEX_FULL },
-	{ MAC_50000FD,  SPEED_50000,  DUPLEX_FULL },
-	{ MAC_40000FD,  SPEED_40000,  DUPLEX_FULL },
-	{ MAC_25000FD,  SPEED_25000,  DUPLEX_FULL },
-	{ MAC_20000FD,  SPEED_20000,  DUPLEX_FULL },
-	{ MAC_10000FD,  SPEED_10000,  DUPLEX_FULL },
-	{ MAC_5000FD,   SPEED_5000,   DUPLEX_FULL },
-	{ MAC_2500FD,   SPEED_2500,   DUPLEX_FULL },
-	{ MAC_1000FD,   SPEED_1000,   DUPLEX_FULL },
-	{ MAC_1000HD,   SPEED_1000,   DUPLEX_HALF },
-	{ MAC_100FD,    SPEED_100,    DUPLEX_FULL },
-	{ MAC_100HD,    SPEED_100,    DUPLEX_HALF },
-	{ MAC_10FD,     SPEED_10,     DUPLEX_FULL },
-	{ MAC_10HD,     SPEED_10,     DUPLEX_HALF },
-};
-
 /**
  * phylink_limit_mac_speed - limit the phylink_config to a maximum speed
  * @config: pointer to a &struct phylink_config
-- 
2.48.1


