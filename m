Return-Path: <netdev+bounces-170748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE30CA49C84
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 15:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF2417560D
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 14:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74250276020;
	Fri, 28 Feb 2025 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lwl5WcqA"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F6D27292D;
	Fri, 28 Feb 2025 14:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754552; cv=none; b=HUEPc0VqCgXKSF0Py+lnT50h83cWF5TK8Lylp+dtRuNks608yx27l9nRdtWfkiWDOJPgKG6q7TLAPFzTuWTI8JXrVaMP28MySamICPMkVUaVPTKyirJAozsriuLpLu5nEbaTTeSs1OYXKhh9hgsUl0j/gEDRIGvqptBrt2tM6AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754552; c=relaxed/simple;
	bh=JVfKkDOkzgEkp6mHzBSXin4gLjyh2op0DzUkpV/huXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYFoTIKolOtTcMq994Q+p21LaHQozVU5rNKqObZrZP5oHs6u8UyVLFdOcXxAQsxeKkstQd0CXAFejJpi/X+fm9NqkVcJSZtL+3PkgpN4c8CZsPaeT8zvn0YO15AF1H39YjWLaoFKMFAYbAlMBdbyCcPI892BZDXk/BrACRomyJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lwl5WcqA; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A7827443E8;
	Fri, 28 Feb 2025 14:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740754548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pMHlcctV/OIZ7642zS9OXcCMfmfU8zWgOurqsuMrY4o=;
	b=lwl5WcqAYIrEoasBSNAb2ZjsbPVss6fFdJtowJh8VIxZnCec786BCo0w58cyVxmtnB5U4a
	jfINtKPGL0dtKRDz7rMu4eFaNxvtOwydOmZaac3KncVJB47aBUXqaorP7wecENRFEwAzYA
	dlKXQQBGNa/2dt6wAK+TkE85rB3eiqIVhu2O5DmcPJydEzc3XnGu16CWe8L1REzsfv6fnL
	PaIU++3QELv0FYjRylorhnQov/cWXHz1e8QParEuTYTcbXK7P4HgljtI9lGHGtT19zMh50
	RIzIiaO0aj8wlzfI0DAPifbh7/MAOwxpyOF8Ssq3mQwFLX07lTN4swLn7nYxSQ==
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
Subject: [PATCH net-next v3 05/13] net: phy: phy_caps: Introduce phy_caps_valid
Date: Fri, 28 Feb 2025 15:55:30 +0100
Message-ID: <20250228145540.2209551-6-maxime.chevallier@bootlin.com>
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

With the link_capabilities array, it's trivial to validate a given mask
againts a <speed, duplex> tuple. Create a helper for that purpose, and
use it to replace a phy_settings lookup in phy_check_valid();

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy-caps.h |  1 +
 drivers/net/phy/phy.c      |  2 +-
 drivers/net/phy/phy_caps.c | 19 +++++++++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy-caps.h b/drivers/net/phy/phy-caps.h
index 3f011b63a417..7359983fce0f 100644
--- a/drivers/net/phy/phy-caps.h
+++ b/drivers/net/phy/phy-caps.h
@@ -44,6 +44,7 @@ void phy_caps_init(void);
 size_t phy_caps_speeds(unsigned int *speeds, size_t size,
 		       unsigned long *linkmodes);
 void phy_caps_linkmode_max_speed(u32 max_speed, unsigned long *linkmodes);
+bool phy_caps_valid(int speed, int duplex, const unsigned long *linkmodes);
 
 
 #endif /* __PHY_CAPS_H */
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 3128df03feda..8df37d221fba 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -260,7 +260,7 @@ unsigned int phy_supported_speeds(struct phy_device *phy,
  */
 bool phy_check_valid(int speed, int duplex, unsigned long *features)
 {
-	return !!phy_lookup_setting(speed, duplex, features, true);
+	return phy_caps_valid(speed, duplex, features);
 }
 EXPORT_SYMBOL(phy_check_valid);
 
diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
index 9075f9840ebd..b776375ea9e4 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -119,3 +119,22 @@ void phy_caps_linkmode_max_speed(u32 max_speed, unsigned long *linkmodes)
 		else
 			break;
 }
+
+/**
+ * phy_caps_valid() - Validate a linkmodes set agains given speed and duplex
+ * @speed: input speed to validate
+ * @duplex: input duplex to validate. Passing DUPLEX_UNKNOWN is always not valid
+ * @linkmodes: The linkmodes to validate
+ *
+ * Returns: True if at least one of the linkmodes in @linkmodes can function at
+ *          the given speed and duplex, false otherwise.
+ */
+bool phy_caps_valid(int speed, int duplex, const unsigned long *linkmodes)
+{
+	int capa = speed_duplex_to_capa(speed, duplex);
+
+	if (capa < 0)
+		return false;
+
+	return linkmode_intersects(link_caps[capa].linkmodes, linkmodes);
+}
-- 
2.48.1


