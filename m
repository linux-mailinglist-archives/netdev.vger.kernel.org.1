Return-Path: <netdev+bounces-171134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAA9A4BA49
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6DAA18919F3
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED171F4616;
	Mon,  3 Mar 2025 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TM8k0GKz"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7125A1F3FC0;
	Mon,  3 Mar 2025 09:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740992626; cv=none; b=iZZbRXH1EbVBW6JBo6n3yuZQ91VOXSscHwzWncZu2xpw1G5956QDSSRyPenMkdztDYMdSuXMQzuuyWAdpU+63QGdG6xZ9K8U1RD1wm2H6hNBtDgESZri5dvOwwAtqfRFN3CwD0D25bFbRZUr0sauu6Ed43Qjs7bmiunZ1jl6Nww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740992626; c=relaxed/simple;
	bh=hy84rzjS7+8uPHR7m9CHhBOJhDLwxhKnLDhbfNxfkEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKKqguAwYdonHVQkvU1kGxsFBFqoFUkv6SIp5TLmVjmTnHjKCvsh0tmexC0wgMtLYYdykosqug/O9Ycog5fXdkt348Rviz+IeOOZfibfz2zTuIFA1IBnelfs4ArB3BfG4qboN1pDhbDVRPTPqMruFUQZZPniQzpN+rfNtXtI8NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TM8k0GKz; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9C6A444530;
	Mon,  3 Mar 2025 09:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740992622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SohpPzuxeSg5EmDhX+WiEB/PtEK9LrVBuJuK+Acd2Qs=;
	b=TM8k0GKzioHAV1TSikAQCfuMh58lWKMWVAs9geYrbieGjilZoRxObkYWIJg7sQFA6vzLLa
	rWo/L4G1HrL+WexXozRDsi8KdFEkfeR/cXdTBayamiBzxGusEzVxGvB4mTDhexlsTyOYG5
	hbKzEZNN/OrxHWC0WlMhKTBnjjnEFLqO68Be/iCCeqqsNkoIvfT0SjifIXt2v7yP+rKWxs
	2gybj+xvCB9V52JjzKBSkPWQvHXqFz2E9dSaZ2u3bTwEGASpzbaC5rTacWmE7rOqPQQgFh
	kB3e4/BewCQvvbMeBbyJa7m//NMBsjXbCfoCMvSEGwOStV1Bcavgdy8VjAJqjA==
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
Subject: [PATCH net-next v4 13/13] net: phy: phy_caps: Allow getting an phy_interface's capabilities
Date: Mon,  3 Mar 2025 10:03:19 +0100
Message-ID: <20250303090321.805785-14-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeejudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgedtffelffelveeuleelgfejfeevvdejhfehgeefgfffvdefteegvedutefftdenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpeduudenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmr
 giivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

Phylink has internal code to get the MAC capabilities of a given PHY
interface (what are the supported speed and duplex).

Extract that into phy_caps, but use the link_capa for conversion. Add an
internal phylink helper for the link caps -> mac caps conversion, and
use this in phylink_caps_to_linkmodes().

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V4: No changes

 drivers/net/phy/phy-caps.h |  4 ++
 drivers/net/phy/phy_caps.c | 92 ++++++++++++++++++++++++++++++++++++++
 drivers/net/phy/phylink.c  | 90 ++++++-------------------------------
 3 files changed, 110 insertions(+), 76 deletions(-)

diff --git a/drivers/net/phy/phy-caps.h b/drivers/net/phy/phy-caps.h
index db53f380392e..e1fe19d11e5f 100644
--- a/drivers/net/phy/phy-caps.h
+++ b/drivers/net/phy/phy-caps.h
@@ -8,6 +8,7 @@
 #define __PHY_CAPS_H
 
 #include <linux/ethtool.h>
+#include <linux/phy.h>
 
 enum {
 	LINK_CAPA_10HD = 0,
@@ -32,6 +33,8 @@ enum {
 	__LINK_CAPA_MAX,
 };
 
+#define LINK_CAPA_ALL	GENMASK((__LINK_CAPA_MAX - 1), 0)
+
 struct link_capabilities {
 	int speed;
 	unsigned int duplex;
@@ -45,6 +48,7 @@ size_t phy_caps_speeds(unsigned int *speeds, size_t size,
 void phy_caps_linkmode_max_speed(u32 max_speed, unsigned long *linkmodes);
 bool phy_caps_valid(int speed, int duplex, const unsigned long *linkmodes);
 void phy_caps_linkmodes(unsigned long caps, unsigned long *linkmodes);
+unsigned long phy_caps_from_interface(phy_interface_t interface);
 
 const struct link_capabilities *
 phy_caps_lookup_by_linkmode(const unsigned long *linkmodes);
diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
index 0a64289a161b..555daaa41d52 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -253,3 +253,95 @@ void phy_caps_linkmodes(unsigned long caps, unsigned long *linkmodes)
 		linkmode_or(linkmodes, linkmodes, link_caps[capa].linkmodes);
 }
 EXPORT_SYMBOL_GPL(phy_caps_linkmodes);
+
+/**
+ * phy_caps_from_interface() - Get the link capa from a given PHY interface
+ * @interface: The PHY interface we want to get the possible Speed/Duplex from
+ *
+ * Returns: A bitmask of LINK_CAPA_xxx values that can be achieved with the
+ *          provided interface.
+ */
+unsigned long phy_caps_from_interface(phy_interface_t interface)
+{
+	unsigned long link_caps = 0;
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_USXGMII:
+		link_caps |= BIT(LINK_CAPA_10000FD) | BIT(LINK_CAPA_5000FD);
+		fallthrough;
+
+	case PHY_INTERFACE_MODE_10G_QXGMII:
+		link_caps |= BIT(LINK_CAPA_2500FD);
+		fallthrough;
+
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_PSGMII:
+	case PHY_INTERFACE_MODE_QSGMII:
+	case PHY_INTERFACE_MODE_QUSGMII:
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_GMII:
+		link_caps |= BIT(LINK_CAPA_1000HD) | BIT(LINK_CAPA_1000FD);
+		fallthrough;
+
+	case PHY_INTERFACE_MODE_REVRMII:
+	case PHY_INTERFACE_MODE_RMII:
+	case PHY_INTERFACE_MODE_SMII:
+	case PHY_INTERFACE_MODE_REVMII:
+	case PHY_INTERFACE_MODE_MII:
+		link_caps |= BIT(LINK_CAPA_10HD) | BIT(LINK_CAPA_10FD);
+		fallthrough;
+
+	case PHY_INTERFACE_MODE_100BASEX:
+		link_caps |= BIT(LINK_CAPA_100HD) | BIT(LINK_CAPA_100FD);
+		break;
+
+	case PHY_INTERFACE_MODE_TBI:
+	case PHY_INTERFACE_MODE_MOCA:
+	case PHY_INTERFACE_MODE_RTBI:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		link_caps |= BIT(LINK_CAPA_1000HD);
+		fallthrough;
+	case PHY_INTERFACE_MODE_1000BASEKX:
+	case PHY_INTERFACE_MODE_TRGMII:
+		link_caps |= BIT(LINK_CAPA_1000FD);
+		break;
+
+	case PHY_INTERFACE_MODE_2500BASEX:
+		link_caps |= BIT(LINK_CAPA_2500FD);
+		break;
+
+	case PHY_INTERFACE_MODE_5GBASER:
+		link_caps |= BIT(LINK_CAPA_5000FD);
+		break;
+
+	case PHY_INTERFACE_MODE_XGMII:
+	case PHY_INTERFACE_MODE_RXAUI:
+	case PHY_INTERFACE_MODE_XAUI:
+	case PHY_INTERFACE_MODE_10GBASER:
+	case PHY_INTERFACE_MODE_10GKR:
+		link_caps |= BIT(LINK_CAPA_10000FD);
+		break;
+
+	case PHY_INTERFACE_MODE_25GBASER:
+		link_caps |= BIT(LINK_CAPA_25000FD);
+		break;
+
+	case PHY_INTERFACE_MODE_XLGMII:
+		link_caps |= BIT(LINK_CAPA_40000FD);
+		break;
+
+	case PHY_INTERFACE_MODE_INTERNAL:
+		link_caps |= LINK_CAPA_ALL;
+		break;
+
+	case PHY_INTERFACE_MODE_NA:
+	case PHY_INTERFACE_MODE_MAX:
+		break;
+	}
+
+	return link_caps;
+}
+EXPORT_SYMBOL_GPL(phy_caps_from_interface);
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 30f0ecb084ef..0162ce09f54d 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -335,6 +335,18 @@ static unsigned long phylink_caps_to_link_caps(unsigned long caps)
 	return link_caps;
 }
 
+static unsigned long phylink_link_caps_to_mac_caps(unsigned long link_caps)
+{
+	unsigned long caps = 0;
+	int i;
+
+	for (i = 0; i <  ARRAY_SIZE(phylink_caps_params); i++)
+		if (link_caps & phylink_caps_params[i].caps_bit)
+			caps |= phylink_caps_params[i].mask;
+
+	return caps;
+}
+
 /**
  * phylink_caps_to_linkmodes() - Convert capabilities to ethtool link modes
  * @linkmodes: ethtool linkmode mask (must be already initialised)
@@ -412,86 +424,12 @@ static unsigned long phylink_get_capabilities(phy_interface_t interface,
 					      unsigned long mac_capabilities,
 					      int rate_matching)
 {
+	unsigned long link_caps = phy_caps_from_interface(interface);
 	int max_speed = phylink_interface_max_speed(interface);
 	unsigned long caps = MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
 	unsigned long matched_caps = 0;
 
-	switch (interface) {
-	case PHY_INTERFACE_MODE_USXGMII:
-		caps |= MAC_10000FD | MAC_5000FD;
-		fallthrough;
-
-	case PHY_INTERFACE_MODE_10G_QXGMII:
-		caps |= MAC_2500FD;
-		fallthrough;
-
-	case PHY_INTERFACE_MODE_RGMII_TXID:
-	case PHY_INTERFACE_MODE_RGMII_RXID:
-	case PHY_INTERFACE_MODE_RGMII_ID:
-	case PHY_INTERFACE_MODE_RGMII:
-	case PHY_INTERFACE_MODE_PSGMII:
-	case PHY_INTERFACE_MODE_QSGMII:
-	case PHY_INTERFACE_MODE_QUSGMII:
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_GMII:
-		caps |= MAC_1000HD | MAC_1000FD;
-		fallthrough;
-
-	case PHY_INTERFACE_MODE_REVRMII:
-	case PHY_INTERFACE_MODE_RMII:
-	case PHY_INTERFACE_MODE_SMII:
-	case PHY_INTERFACE_MODE_REVMII:
-	case PHY_INTERFACE_MODE_MII:
-		caps |= MAC_10HD | MAC_10FD;
-		fallthrough;
-
-	case PHY_INTERFACE_MODE_100BASEX:
-		caps |= MAC_100HD | MAC_100FD;
-		break;
-
-	case PHY_INTERFACE_MODE_TBI:
-	case PHY_INTERFACE_MODE_MOCA:
-	case PHY_INTERFACE_MODE_RTBI:
-	case PHY_INTERFACE_MODE_1000BASEX:
-		caps |= MAC_1000HD;
-		fallthrough;
-	case PHY_INTERFACE_MODE_1000BASEKX:
-	case PHY_INTERFACE_MODE_TRGMII:
-		caps |= MAC_1000FD;
-		break;
-
-	case PHY_INTERFACE_MODE_2500BASEX:
-		caps |= MAC_2500FD;
-		break;
-
-	case PHY_INTERFACE_MODE_5GBASER:
-		caps |= MAC_5000FD;
-		break;
-
-	case PHY_INTERFACE_MODE_XGMII:
-	case PHY_INTERFACE_MODE_RXAUI:
-	case PHY_INTERFACE_MODE_XAUI:
-	case PHY_INTERFACE_MODE_10GBASER:
-	case PHY_INTERFACE_MODE_10GKR:
-		caps |= MAC_10000FD;
-		break;
-
-	case PHY_INTERFACE_MODE_25GBASER:
-		caps |= MAC_25000FD;
-		break;
-
-	case PHY_INTERFACE_MODE_XLGMII:
-		caps |= MAC_40000FD;
-		break;
-
-	case PHY_INTERFACE_MODE_INTERNAL:
-		caps |= ~0;
-		break;
-
-	case PHY_INTERFACE_MODE_NA:
-	case PHY_INTERFACE_MODE_MAX:
-		break;
-	}
+	caps |= phylink_link_caps_to_mac_caps(link_caps);
 
 	switch (rate_matching) {
 	case RATE_MATCH_OPEN_LOOP:
-- 
2.48.1


