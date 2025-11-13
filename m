Return-Path: <netdev+bounces-238307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C614C57331
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 10A2B34FF5E
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B5533BBAD;
	Thu, 13 Nov 2025 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VyY0j8Nm"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3953A33B6D2
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033385; cv=none; b=rGQ1bfGEJPj3ZEN8IBspVhjMc9xXqeSsm9oi2WYheGaxF2r+LCGunIVjk+LUgeAb15KdmxY/IqeBZKsDxHpqmg5l+1Iqve60eqwmSg1WOIESsmTzTlRWqK4UkdGzw5A4JvrWg/FJvnx2617HgxS/LaQTJqLQ0V82gotLdxgLddM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033385; c=relaxed/simple;
	bh=Q/+0+J0PElX25raE6B3OD0vTHqEKOnEvc2gZjzdrmWI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Y2IFRLyn+Ry9NiYvGWDlTJSqpbOFbDRhFgnNSDVacHZpVNT39zj3Vzole5+cQN6hAOaXuh3SwKr2CrDUJDZ6voJFZhxZrW3+RzUr91q/jVgZ/awVr09hdzqsnadsxtDaqe4ilGtvG4T5CfuOy3LkQ2u/OENNHOaCIDPhydQqVIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VyY0j8Nm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Sqt5kQtytIqH3Ltutr9kPYj/XSm6hIOAXI6qRdBVOno=; b=VyY0j8NmI8DSuNed/u9U6ER7gn
	ooUm80iLf5fxhY6fqWsANj2+bdRqYity/y6ftjKW5Zw8HtOVC8eGOAu2HiNZRFtWI0c62QeCLm8pm
	xIFE12AsgPQd8FhTp79dqgVyC7LD0oPzUK4KdPR0OsLefWu934ISNMKo5If6uNQNLmTTEueroHMIH
	Rk4HvbWSxMhtKDfUXVjJ85YUGCE8l95EXiy0Mc7KMyn4SwAoTdJC+kXnOLNopkhi2tSWYsp2s0ZL8
	Nq64WdNvXXYs5VwuL91AIwelKNsGtauNZOfK/+rgYKgCVai7v2Llo44rlVeGqt5pRBpDCcRyKHR/8
	GXTD2VBQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57448 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vJVWF-000000005MD-3nez;
	Thu, 13 Nov 2025 11:29:39 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vJVWF-0000000E5F2-0cKz;
	Thu, 13 Nov 2025 11:29:39 +0000
In-Reply-To: <aRXAnpzsvmHQu7wc@shell.armlinux.org.uk>
References: <aRXAnpzsvmHQu7wc@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 1/2] net: phy: allow drivers to disable EEE
 support via .get_features()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vJVWF-0000000E5F2-0cKz@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 13 Nov 2025 11:29:39 +0000

Allow PHY drivers to hook the .get_features() method to disable EEE
support. This is useful for TI PHYs, where we have a statement that
none of their gigabit products support EEE, yet at least DP83867
reports EEE capabilties and implements EEE negotiation.

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy-core.c   |  2 --
 drivers/net/phy/phy_device.c | 32 +++++++++++++++++++++++++++++---
 include/linux/phy.h          |  1 +
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 605ca20ae192..43ccbd3a09f8 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -207,8 +207,6 @@ void of_set_phy_eee_broken(struct phy_device *phydev)
 	if (!IS_ENABLED(CONFIG_OF_MDIO) || !node)
 		return;
 
-	linkmode_zero(modes);
-
 	if (of_property_read_bool(node, "eee-broken-100tx"))
 		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, modes);
 	if (of_property_read_bool(node, "eee-broken-1000t"))
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 81984d4ebb7c..b384f99a40f2 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3397,6 +3397,34 @@ struct fwnode_handle *fwnode_get_phy_node(const struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(fwnode_get_phy_node);
 
+static int phy_get_features(struct phy_device *phydev)
+{
+	int err;
+
+	if (phydev->is_c45)
+		err = genphy_c45_pma_read_abilities(phydev);
+	else
+		err = genphy_read_abilities(phydev);
+
+	return err;
+}
+
+/**
+ * phy_get_features_no_eee - read the PHY features, disabling all EEE
+ * @phydev: phy_device structure to be added to the MDIO bus
+ *
+ * Read the PHY features, and fill the @phydev->eee_disabled_modes to
+ * prevent EEE being used. This is intended to be used for PHY .get_feature
+ * methods where a PHY reports incorrect capabilities.
+ */
+int phy_get_features_no_eee(struct phy_device *phydev)
+{
+	linkmode_fill(phydev->eee_disabled_modes);
+
+	return phy_get_features(phydev);
+}
+EXPORT_SYMBOL_GPL(phy_get_features_no_eee);
+
 /**
  * phy_probe - probe and init a PHY device
  * @dev: device to probe and init
@@ -3442,10 +3470,8 @@ static int phy_probe(struct device *dev)
 	}
 	else if (phydrv->get_features)
 		err = phydrv->get_features(phydev);
-	else if (phydev->is_c45)
-		err = genphy_c45_pma_read_abilities(phydev);
 	else
-		err = genphy_read_abilities(phydev);
+		err = phy_get_features(phydev);
 
 	if (err)
 		goto out;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index bf5457341ca8..2655c0ae6488 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2299,6 +2299,7 @@ void phy_support_sym_pause(struct phy_device *phydev);
 void phy_support_asym_pause(struct phy_device *phydev);
 void phy_support_eee(struct phy_device *phydev);
 void phy_disable_eee(struct phy_device *phydev);
+int phy_get_features_no_eee(struct phy_device *phydev);
 void phy_set_sym_pause(struct phy_device *phydev, bool rx, bool tx,
 		       bool autoneg);
 void phy_set_asym_pause(struct phy_device *phydev, bool rx, bool tx);
-- 
2.47.3


