Return-Path: <netdev+bounces-153788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D52E49F9AF5
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 21:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2423316D6BC
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 20:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2B219F104;
	Fri, 20 Dec 2024 20:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fhBGHpbF"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2A1223E9D;
	Fri, 20 Dec 2024 20:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734725721; cv=none; b=o1hkeKJ3eHH0SdVbzEVE1fKNDb7kRrkDiqE+sQs6Uc7mh9Etv8633RLC49wmXO4i2KPIiQfaQlRqxY2769kZG8WFtvf6+QG3s09pA9uGPA7IVeTuhMvHtXzlyuv5CAWL9gq0Myp81NDaG5YKlHUnKdMNRIIu44WBy7TRAWVfQSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734725721; c=relaxed/simple;
	bh=dOAuVNzY9+MXdf84V+ZZ17GUb0ZfkFgbvkoG/RrbuD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5p3BBFxG+Fpuvb7AEnkC0Z2WrWcPiHVxW/hUHLE9abRo+8yj2EewSq8qKhOiM2V8V8KcSVvDLIbJIGvnRJrcmqcDoGfcmlXT+NOoboJFW+e6YOJACgXk3r2c8SmgxgplUJ2CTWE5BG4ARidGo/wotTP+yn/gopv12CBFrczvtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fhBGHpbF; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 78F96E0008;
	Fri, 20 Dec 2024 20:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734725716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MCQOXUQrkl6IGWgunRyyLbwk1HB+GOwt1j3mvyiwwok=;
	b=fhBGHpbFj1A390nEBl+AWAE4HTbVfQGFbaHtzxSjRU+GX9W1cmi6zxbxs49wjZfgA4aron
	sjFyjTffiSudTbhFrGyABg9HPDLAN2vmFde6Gi/zWuy0FJsfFWYB/eh95zS0mJv8oovBJd
	5mG/CahkTysr1K6ErX4ECE3fr0qinI4RgizkUGh2JT84o/9W6MbUjCkLO99ZfYW4ODXYDt
	0ILOTy3NhLLhlTgutTHIOjLGiiDeAJSrhnyV99IaxV39OGiFj1x9OzM/DnEjN9tVn0o1pb
	qv7V/kjYYCzY5n+qrz0AGl4VivRrTk7BlfzkLX10m0ochaP6lx+vyepo4ppuAw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Antoine Tenart <atenart@kernel.org>
Subject: [PATCH net-next RFC 5/5] net: phy: dp83822: Add support for phy_port representation
Date: Fri, 20 Dec 2024 21:15:04 +0100
Message-ID: <20241220201506.2791940-6-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220201506.2791940-1-maxime.chevallier@bootlin.com>
References: <20241220201506.2791940-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

With the phy_port representation intrduced, we can use .attach_port to
populate the port information based on either the straps or the
ti,fiber-mode property. This allows simplifying the probe function and
allow users to override the strapping configuration.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/dp83822.c | 60 +++++++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 21 deletions(-)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index 334c17a68edd..96a0ad1a0e83 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -637,17 +637,6 @@ static int dp83822_of_init(struct phy_device *phydev)
 	struct device *dev = &phydev->mdio.dev;
 	const char *of_val;
 
-	/* Signal detection for the PHY is only enabled if the FX_EN and the
-	 * SD_EN pins are strapped. Signal detection can only enabled if FX_EN
-	 * is strapped otherwise signal detection is disabled for the PHY.
-	 */
-	if (dp83822->fx_enabled && dp83822->fx_sd_enable)
-		dp83822->fx_signal_det_low = device_property_present(dev,
-								     "ti,link-loss-low");
-	if (!dp83822->fx_enabled)
-		dp83822->fx_enabled = device_property_present(dev,
-							      "ti,fiber-mode");
-
 	if (!device_property_read_string(dev, "ti,gpio2-clk-out", &of_val)) {
 		if (strcmp(of_val, "mac-if") == 0) {
 			dp83822->gpio2_clk_out = DP83822_CLK_SRC_MAC_IF;
@@ -740,6 +729,44 @@ static int dp83822_read_straps(struct phy_device *phydev)
 	return 0;
 }
 
+static int dp83822_attach_port(struct phy_device *phydev, struct phy_port *port)
+{
+	struct dp83822_private *dp83822 = phydev->priv;
+	struct device *dev = &phydev->mdio.dev;
+	int ret;
+
+	if (port->mediums) {
+		if (phy_port_is_fiber(port) ||
+		    port->mediums & BIT(ETHTOOL_LINK_MEDIUM_BASEX))
+			dp83822->fx_enabled = true;
+	} else {
+		ret = dp83822_read_straps(phydev);
+		if (ret)
+			return ret;
+
+#ifdef CONFIG_OF_MDIO
+		if (dp83822->fx_enabled && dp83822->fx_sd_enable)
+			dp83822->fx_signal_det_low =
+				device_property_present(dev, "ti,link-loss-low");
+		if (!dp83822->fx_enabled)
+			dp83822->fx_enabled =
+				device_property_present(dev, "ti,fiber-mode");
+#endif
+
+		if (dp83822->fx_enabled) {
+			port->lanes = 1;
+			port->mediums = BIT(ETHTOOL_LINK_MEDIUM_BASEF) |
+					BIT(ETHTOOL_LINK_MEDIUM_BASEX);
+		} else {
+			/* This PHY can only to 100BaseTX max, so on 2 lanes */
+			port->lanes = 2;
+			port->mediums = BIT(ETHTOOL_LINK_MEDIUM_BASET);
+		}
+	}
+
+	return 0;
+}
+
 static int dp8382x_probe(struct phy_device *phydev)
 {
 	struct dp83822_private *dp83822;
@@ -756,24 +783,14 @@ static int dp8382x_probe(struct phy_device *phydev)
 
 static int dp83822_probe(struct phy_device *phydev)
 {
-	struct dp83822_private *dp83822;
 	int ret;
 
 	ret = dp8382x_probe(phydev);
 	if (ret)
 		return ret;
 
-	dp83822 = phydev->priv;
-
-	ret = dp83822_read_straps(phydev);
-	if (ret)
-		return ret;
-
 	dp83822_of_init(phydev);
 
-	if (dp83822->fx_enabled)
-		phydev->port = PORT_FIBRE;
-
 	return 0;
 }
 
@@ -831,6 +848,7 @@ static int dp83822_resume(struct phy_device *phydev)
 		.handle_interrupt = dp83822_handle_interrupt,	\
 		.suspend = dp83822_suspend,			\
 		.resume = dp83822_resume,			\
+		.attach_port = dp83822_attach_port		\
 	}
 
 #define DP83825_PHY_DRIVER(_id, _name)				\
-- 
2.47.1


