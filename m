Return-Path: <netdev+bounces-170746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A28A49C80
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 15:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1714017550D
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 14:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBB2274242;
	Fri, 28 Feb 2025 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M3IIsWjL"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5542127126A;
	Fri, 28 Feb 2025 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754550; cv=none; b=CkyW/bO9T/74DHxi/CzAQVjUo4BHnsAhH/5nDxP2rtLr8Qd9PHZOa/EP2x4exJRgKlnY6edj0eJxuju3swiVwPciRSJHkXaOzHjrDpxU0BYKMbCAZmo6Ko+PS6zcNX23vlcrUtZI3QmIjb309xqtlY6pxY6SaN32Cfef1qGZ4NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754550; c=relaxed/simple;
	bh=duNj9t20fdYu9a6hryuWMSCYfj2vxCnUt6fS62gMCRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzQNtomCtYUa5/biTMSdDUn1aazTkLN70h9FS62t+WJcc0lfTntBIzvJ+PmBcE3wUcLvvlNUnLdqKqfKpK9YFr7InVDp4CMBMKk3skUgDHMXA1qsUwg2OO087pBpjG+Irt6FmQ7duZ19cCrOB0aaTmUcqbb6V1AdEjezCKG9GAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M3IIsWjL; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 981AA433FE;
	Fri, 28 Feb 2025 14:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740754546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8BXXyCpLWQKQZUulgdadmp4AJPph07YjhBF0pamvEL4=;
	b=M3IIsWjLF33yiO5I7ZPBF9y3jEoFFzKzuqqcZecm9T56n6qblRVusjKIvQFjqDgBzvXoBL
	Iz32qiS7w1BUQdeMdRRvrrwtbgH5qjMDxfVMaXJkBJL2C8ASXf+HlNb4UD0qUB4qGvB+6L
	Z5MnjKnywqi0ShhPwIJzRP4wXaLRlwZOIWAqeT8nEhnxGaXhkvCdbINdTwImy4MRI2OTA/
	bt1ysXKkENp04DAzhDMfwbZuoKhgCW1TuCYEahQwOlUkD/46owZ9fw9itn2sj0TpR1bW3E
	y6dPC51zCuqNLvBAxhpCu85xwEj0yPAzzTxTTyVmT1Cb7I8rhx9fNbQA1lWuwA==
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
Subject: [PATCH net-next v3 03/13] net: phy: phy_caps: Move phy_speeds to phy_caps
Date: Fri, 28 Feb 2025 15:55:28 +0100
Message-ID: <20250228145540.2209551-4-maxime.chevallier@bootlin.com>
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

Use the newly introduced link_capabilities array to derive the list of
possible speeds when given a combination of linkmodes. As
link_capabilities is indexed by speed, we don't have to iterate the
whole phy_settings array.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy-caps.h |  3 +++
 drivers/net/phy/phy-core.c | 15 ---------------
 drivers/net/phy/phy.c      |  3 ++-
 drivers/net/phy/phy_caps.c | 27 +++++++++++++++++++++++++++
 include/linux/phy.h        |  2 --
 5 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/net/phy/phy-caps.h b/drivers/net/phy/phy-caps.h
index 846d483269f6..f8cdfdb09242 100644
--- a/drivers/net/phy/phy-caps.h
+++ b/drivers/net/phy/phy-caps.h
@@ -41,4 +41,7 @@ struct link_capabilities {
 
 void phy_caps_init(void);
 
+size_t phy_caps_speeds(unsigned int *speeds, size_t size,
+		       unsigned long *linkmodes);
+
 #endif /* __PHY_CAPS_H */
diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index b1c1670de23b..8533e57c3500 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -339,21 +339,6 @@ phy_lookup_setting(int speed, int duplex, const unsigned long *mask, bool exact)
 }
 EXPORT_SYMBOL_GPL(phy_lookup_setting);
 
-size_t phy_speeds(unsigned int *speeds, size_t size,
-		  unsigned long *mask)
-{
-	size_t count;
-	int i;
-
-	for (i = 0, count = 0; i < ARRAY_SIZE(settings) && count < size; i++)
-		if (settings[i].bit < __ETHTOOL_LINK_MODE_MASK_NBITS &&
-		    test_bit(settings[i].bit, mask) &&
-		    (count == 0 || speeds[count - 1] != settings[i].speed))
-			speeds[count++] = settings[i].speed;
-
-	return count;
-}
-
 static void __set_linkmode_max_speed(u32 max_speed, unsigned long *addr)
 {
 	const struct phy_setting *p;
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 16ffc00b419c..3128df03feda 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -37,6 +37,7 @@
 #include <net/sock.h>
 
 #include "phylib-internal.h"
+#include "phy-caps.h"
 
 #define PHY_STATE_TIME	HZ
 
@@ -245,7 +246,7 @@ unsigned int phy_supported_speeds(struct phy_device *phy,
 				  unsigned int *speeds,
 				  unsigned int size)
 {
-	return phy_speeds(speeds, size, phy->supported);
+	return phy_caps_speeds(speeds, size, phy->supported);
 }
 
 /**
diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
index 367ca7110ddc..e5c716365b36 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -76,3 +76,30 @@ void phy_caps_init(void)
 		__set_bit(i, link_caps[capa].linkmodes);
 	}
 }
+
+/**
+ * phy_caps_speeds() - Fill an array of supported SPEED_* values for given modes
+ * @speeds: Output array to store the speeds list into
+ * @size: Size of the output array
+ * @linkmodes: Linkmodes to get the speeds from
+ *
+ * Fills the speeds array with all possible speeds that can be achieved with
+ * the specified linkmodes.
+ *
+ * Returns: The number of speeds filled into the array. If the input array isn't
+ *	    big enough to store all speeds, fill it as much as possible.
+ */
+size_t phy_caps_speeds(unsigned int *speeds, size_t size,
+		       unsigned long *linkmodes)
+{
+	size_t count;
+	int capa;
+
+	for (capa = 0, count = 0; capa < __LINK_CAPA_MAX && count < size; capa++) {
+		if (linkmode_intersects(link_caps[capa].linkmodes, linkmodes) &&
+		    (count == 0 || speeds[count - 1] != link_caps[capa].speed))
+			speeds[count++] = link_caps[capa].speed;
+	}
+
+	return count;
+}
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 7bfbae51070a..5749aad96862 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1322,8 +1322,6 @@ struct phy_setting {
 const struct phy_setting *
 phy_lookup_setting(int speed, int duplex, const unsigned long *mask,
 		   bool exact);
-size_t phy_speeds(unsigned int *speeds, size_t size,
-		  unsigned long *mask);
 
 /**
  * phy_is_started - Convenience function to check whether PHY is started
-- 
2.48.1


