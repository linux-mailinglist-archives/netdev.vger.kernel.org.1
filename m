Return-Path: <netdev+bounces-249963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12613D21AFA
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 23:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBB1B3078083
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 22:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB86F392B9A;
	Wed, 14 Jan 2026 22:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TYHJiCVR"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D93738A9B9;
	Wed, 14 Jan 2026 22:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768431482; cv=none; b=cVvl216LD8+vLBRCirbyJ2auCUdGN19/3k/g50pjMlS7jgYXCx7YL2rBstB0DL+cEUJDFsIsYkSGd+Z1KI8wQfh9nfcmWS2DGoIto3DpE+e+MEZKkunsYsssIubwCWaORmAl4E6oFIZq3DD6WeNvz1RZgguYrzmp4GrUdvLjGq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768431482; c=relaxed/simple;
	bh=tFQX9lnNDiRM0fQOJbkTfE+NhfLRa+xgPNzuQfqM65Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7Bs7ultR36UGbn/zKg3nwdH9ukLtaJPdLD+7Pdo7N5AGav2IoH+sZxti8lQfzOp6cL3NJAmxZnbFq0hWakp9UOCPnvZty3HG7Kv5evNm6DUVznSiOaxxl8wBp9ub13jWqmGAXHUzUuvsN4NWEYYBKwYK4zhkwNiiFA2FnlVv5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TYHJiCVR; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9F8FA1A286D;
	Wed, 14 Jan 2026 22:57:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 755E76074A;
	Wed, 14 Jan 2026 22:57:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1E91010B6844D;
	Wed, 14 Jan 2026 23:57:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768431470; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=uYA6wVCtRdWQWw+IybQzQvnWtQbLpvNWV0ujt0iJQw8=;
	b=TYHJiCVRzVzVJPV4+QH3mlcDkGN/i6HICnDsAXPjEQ6dyEVUwbJ8/JboZRuZLZZ3IlnmUL
	rejXt+fskzojknGO7Kips1KLoaTQ3nXu924dZ3s80y32afkOixqY4jMIjfNRfBdYKNUvi5
	hKuH8TCc7d71Q4sjkOcUSqXpUBvr1JR7uwoQWTqG2SBkvj6FVV26X88JzXjuqQPBZH1kkF
	wbZ2390KSOJ6DnHKZ3ty98sR1i8JmBTZyo/gm/SkWE7zzI34OxdcWcJxJ/P2cEZLX7jxII
	HbjC5bOnU+Zm5LE/GTTHbiNccl3N6OcNbM9RhQvJHcjGp0YaI8FeZm85Aj2JwA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH net-next 2/6] net: phylink: Allow more interfaces in SFP interface selection
Date: Wed, 14 Jan 2026 23:57:24 +0100
Message-ID: <20260114225731.811993-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260114225731.811993-1-maxime.chevallier@bootlin.com>
References: <20260114225731.811993-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

When phylink handles an SFP module that contains a PHY, it selects a
phy_interface to use to communicate with it. This selection ensures that
the highest speed gets achieved, based on the linkmodes we want to
support in the module.

This approach doesn't take into account the supported interfaces
reported by the module, but also doesn't handle the fact that the same
linkmode may be achieved using different phy_interface modes.

It becomes an issue when trying to support SGMII to 100FX modules. We
can't feed it 100BaseX, and its MDI isn't 1000BaseT (the modes we expect
for SGMII to be selected).

Let's therefore use a different approach :

 - Get the common interfaces between what the module and the SFP Bus
   support
 - From that common interface list, select the one that can allow us to
   achieve the highest speed

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy-caps.h |  5 ++++
 drivers/net/phy/phy_caps.c | 47 ++++++++++++++++++++++++++++++++++++++
 drivers/net/phy/phylink.c  | 24 ++++++-------------
 3 files changed, 59 insertions(+), 17 deletions(-)

diff --git a/drivers/net/phy/phy-caps.h b/drivers/net/phy/phy-caps.h
index 5f3f757e0b2f..4a07ac74ef13 100644
--- a/drivers/net/phy/phy-caps.h
+++ b/drivers/net/phy/phy-caps.h
@@ -10,6 +10,7 @@
 #include <linux/ethtool.h>
 #include <linux/phy.h>
 
+/* this must be sorted by speed */
 enum {
 	LINK_CAPA_10HD = 0,
 	LINK_CAPA_10FD,
@@ -66,4 +67,8 @@ void phy_caps_medium_get_supported(unsigned long *supported,
 				   int lanes);
 u32 phy_caps_mediums_from_linkmodes(unsigned long *linkmodes);
 
+phy_interface_t
+phy_caps_select_fastest_interface(const unsigned long *interfaces,
+				  const unsigned long *linkmodes);
+
 #endif /* __PHY_CAPS_H */
diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
index 17a63c931335..11e7a1efcf30 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -443,3 +443,50 @@ u32 phy_caps_mediums_from_linkmodes(unsigned long *linkmodes)
 	return mediums;
 }
 EXPORT_SYMBOL_GPL(phy_caps_mediums_from_linkmodes);
+
+/**
+ * phy_caps_select_fastest_interface - Select the fastest interface that can
+ *				       support the fastest of the given
+ *				       linkmodes
+ * @interfaces: The interface list to lookup from
+ * @linkmodes: Linkmodes we want to support
+ *
+ * Returns: The fastest matching interface, PHY_INTERFACE_MODE_NA otherwise.
+ */
+phy_interface_t
+phy_caps_select_fastest_interface(const unsigned long *interfaces,
+				  const unsigned long *linkmodes)
+{
+	phy_interface_t interface = PHY_INTERFACE_MODE_NA;
+	u32 target_link_caps = 0;
+	int i, max_capa = 0;
+
+	/* Link caps from the linkmodes */
+	for_each_set_bit(i, linkmodes, __ETHTOOL_LINK_MODE_MASK_NBITS) {
+		const struct link_mode_info *linkmode;
+
+		linkmode = &link_mode_params[i];
+		target_link_caps |= speed_duplex_to_capa(linkmode->speed,
+							 linkmode->duplex);
+	}
+
+	for_each_set_bit(i, interfaces, PHY_INTERFACE_MODE_MAX) {
+		u32 interface_caps = phy_caps_from_interface(i);
+		u32 interface_max_capa;
+
+		/* Can we achieve at least one mode with this interface ? */
+		if (!(interface_caps & target_link_caps))
+			continue;
+
+		/* Biggest link_capa we can achieve with this interface */
+		interface_max_capa = fls(interface_caps & target_link_caps);
+
+		if (interface_max_capa > max_capa) {
+			max_capa = interface_max_capa;
+			interface = i;
+		}
+	}
+
+	return interface;
+}
+EXPORT_SYMBOL_GPL(phy_caps_select_fastest_interface);
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 43d8380aaefb..18fa417b87dd 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2808,27 +2808,19 @@ EXPORT_SYMBOL_GPL(phylink_ethtool_set_wol);
 static phy_interface_t phylink_sfp_select_interface(struct phylink *pl,
 						const unsigned long *link_modes)
 {
-	phy_interface_t interface;
+	DECLARE_PHY_INTERFACE_MASK(common_interfaces);
 
-	interface = sfp_select_interface(pl->sfp_bus, link_modes);
-	if (interface == PHY_INTERFACE_MODE_NA) {
-		phylink_err(pl,
-			    "selection of interface failed, advertisement %*pb\n",
-			    __ETHTOOL_LINK_MODE_MASK_NBITS,
-			    link_modes);
-		return interface;
-	}
+	/* Interfaces supported both by the module and the bus */
+	phy_interface_and(common_interfaces, pl->sfp_interfaces,
+			  pl->config->supported_interfaces);
 
-	if (!test_bit(interface, pl->config->supported_interfaces)) {
+	if (phy_interface_empty(common_interfaces)) {
 		phylink_err(pl,
-			    "selection of interface failed, SFP selected %s (%u) but MAC supports %*pbl\n",
-			    phy_modes(interface), interface,
-			    (int)PHY_INTERFACE_MODE_MAX,
-			    pl->config->supported_interfaces);
+			    "selection of interface failed, no common interface between MAC and SFP\n");
 		return PHY_INTERFACE_MODE_NA;
 	}
 
-	return interface;
+	return phy_caps_select_fastest_interface(common_interfaces, link_modes);
 }
 
 static phy_interface_t phylink_sfp_select_interface_speed(struct phylink *pl,
@@ -3697,8 +3689,6 @@ static int phylink_sfp_config_phy(struct phylink *pl, struct phy_device *phy)
 	struct phylink_link_state config;
 	int ret;
 
-	/* We're not using pl->sfp_interfaces, so clear it. */
-	phy_interface_zero(pl->sfp_interfaces);
 	linkmode_copy(support, phy->supported);
 
 	memset(&config, 0, sizeof(config));
-- 
2.49.0


