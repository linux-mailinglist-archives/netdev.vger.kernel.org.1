Return-Path: <netdev+bounces-128054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A24977B5D
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 10:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51C5AB21835
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 08:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8EF1D79B4;
	Fri, 13 Sep 2024 08:40:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C579C1D79A3
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 08:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726216859; cv=none; b=kl3Cx3ZFNLyZAjpUBDLJpXXFr6csh/JoEMgLR8+Rrfjv1K9Z0CjjZn9uE/XqQ5IobFPKQ6X2KxrKV4sZZbypPT10CGYpCIqu0Mjf7hJLmK1qHFsnptMiA8yLfgexirZCs9FEG6kTHtDrH3WzSSiFMVqpCUUgQEdxrjnA5Yi2d7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726216859; c=relaxed/simple;
	bh=laoe3SnMaiPWtPOUgZ8i4FpD13PW4kdI6pvhyusMybw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mQxblXLuQjVP1vuZdqTh4KIL3hU+c2EkpzVroe7d9CP5hgmqVqOtv3fU1jvUoTpn+Ge9ZyJ6A7XR40pP7hmtRiB5LLCe64ajvNsHbobx4JH8dlsYtHXg6oDiBboukjMRQKKvTG+AXGH9hTulpOZewXJpSeo2n0K7Ig64O28bJfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sp1qr-0005nB-L3; Fri, 13 Sep 2024 10:40:25 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sp1qp-007a7Z-TJ; Fri, 13 Sep 2024 10:40:23 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sp1qp-00E1uc-2g;
	Fri, 13 Sep 2024 10:40:23 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org
Subject: [PATCH net-next v3 2/2] net: phy: Add support for PHY timing-role configuration via device tree
Date: Fri, 13 Sep 2024 10:40:22 +0200
Message-Id: <20240913084022.3343903-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240913084022.3343903-1-o.rempel@pengutronix.de>
References: <20240913084022.3343903-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Introduce support for configuring the master/slave role of PHYs based on
the `timing-role` property in the device tree. While this functionality
is necessary for Single Pair Ethernet (SPE) PHYs (1000/100/10Base-T1)
where hardware strap pins may be unavailable or incorrectly set, it
works for any PHY type.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v3:
- rename master-slave to timing-role
---
 drivers/net/phy/phy-core.c   | 33 +++++++++++++++++++++++++++++++++
 drivers/net/phy/phy_device.c |  3 +++
 include/linux/phy.h          |  1 +
 3 files changed, 37 insertions(+)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 1f98b6a96c153..97ff10e226180 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -412,6 +412,39 @@ void of_set_phy_eee_broken(struct phy_device *phydev)
 	phydev->eee_broken_modes = broken;
 }
 
+/**
+ * of_set_phy_timing_role - Set the master/slave mode of the PHY
+ *
+ * @phydev: The phy_device struct
+ *
+ * Set master/slave configuration of the PHY based on the device tree.
+ */
+void of_set_phy_timing_role(struct phy_device *phydev)
+{
+	struct device_node *node = phydev->mdio.dev.of_node;
+	const char *master;
+
+	if (!IS_ENABLED(CONFIG_OF_MDIO))
+		return;
+
+	if (!node)
+		return;
+
+	if (of_property_read_string(node, "timing-role", &master))
+		return;
+
+	if (strcmp(master, "force-master") == 0)
+		phydev->master_slave_set = MASTER_SLAVE_CFG_MASTER_FORCE;
+	else if (strcmp(master, "force-slave") == 0)
+		phydev->master_slave_set = MASTER_SLAVE_CFG_SLAVE_FORCE;
+	else if (strcmp(master, "prefer-master") == 0)
+		phydev->master_slave_set = MASTER_SLAVE_CFG_MASTER_PREFERRED;
+	else if (strcmp(master, "prefer-slave") == 0)
+		phydev->master_slave_set = MASTER_SLAVE_CFG_SLAVE_PREFERRED;
+	else
+		phydev_warn(phydev, "Unknown master-slave mode %s\n", master);
+}
+
 /**
  * phy_resolve_aneg_pause - Determine pause autoneg results
  *
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 560e338b307a4..4ccf504a8b2c2 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3608,6 +3608,9 @@ static int phy_probe(struct device *dev)
 	 */
 	of_set_phy_eee_broken(phydev);
 
+	/* Get master/slave strap overrides */
+	of_set_phy_timing_role(phydev);
+
 	/* The Pause Frame bits indicate that the PHY can support passing
 	 * pause frames. During autonegotiation, the PHYs will determine if
 	 * they should allow pause frames to pass.  The MAC driver should then
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 4a9a11749c554..898ea2e316d2c 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1260,6 +1260,7 @@ size_t phy_speeds(unsigned int *speeds, size_t size,
 		  unsigned long *mask);
 void of_set_phy_supported(struct phy_device *phydev);
 void of_set_phy_eee_broken(struct phy_device *phydev);
+void of_set_phy_timing_role(struct phy_device *phydev);
 int phy_speed_down_core(struct phy_device *phydev);
 
 /**
-- 
2.39.2


