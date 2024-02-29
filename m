Return-Path: <netdev+bounces-76178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8369786CAF3
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 15:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17F1A1F235E9
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 14:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594B113699E;
	Thu, 29 Feb 2024 14:08:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C928E12A177
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709215704; cv=none; b=sIKAGpt158xAQxcTS95AliiR1yZ0S57ylnJJt3eGJqSX0i9NIT9m484WqStsKoQEWgExGcdUoA3Z37XMJoQdQeE9fOAHQ/MhCl+vWoxe9zJ4be44xjMRLF3fU+CKdoHB7nT3jGbIvQEZavYFoFOefxnQtLdHVaEx18OYkm4r3jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709215704; c=relaxed/simple;
	bh=7Ye85qjcN7kaawh5AqqUO/lIXibzvDdJYFw778hqsHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aWR1FHzPKT48bMbCy1qffnAgto2Pbz6Ar+35jlBbs3vnJUXvQtDnPD74Jbl6WqcQMlYaCmV7vqp42NPTufEzwoZrXydeiog4PQcnKuH6c8B6d1KGTU8m+1j39f3NLibYVLUjtW+2FfHjqkjt4VJA44Umzn1Y3aEhZlTDV2qu0Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rfh4t-0000Sx-CE; Thu, 29 Feb 2024 15:08:03 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rfh4s-003ba2-3c; Thu, 29 Feb 2024 15:08:02 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rfh4r-00ELmw-2x;
	Thu, 29 Feb 2024 15:08:01 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH net-next v7 6/8] net: phy: Add phy_support_eee() indicating MAC support EEE
Date: Thu, 29 Feb 2024 15:07:58 +0100
Message-Id: <20240229140800.3420180-7-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240229140800.3420180-1-o.rempel@pengutronix.de>
References: <20240229140800.3420180-1-o.rempel@pengutronix.de>
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

From: Andrew Lunn <andrew@lunn.ch>

In order for EEE to operate, both the MAC and the PHY need to support
it, similar to how pause works. With some exception - a number of PHYs
have SmartEEE or AutoGrEEEn support in order to provide some EEE-like
power savings with non-EEE capable MACs.

Copy the pause concept and add the call phy_support_eee() which the MAC
makes after connecting the PHY to indicate it supports EEE. phylib will
then advertise EEE when auto-neg is performed.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
v6: reword commit message and comment for phy_support_eee()
---
 drivers/net/phy/phy_device.c | 28 ++++++++++++++++++++++++++++
 include/linux/phy.h          |  3 ++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 2eefee9708510..72452e6a478c0 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2910,6 +2910,34 @@ void phy_advertise_eee_all(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(phy_advertise_eee_all);
 
+/**
+ * phy_support_eee - Set initial EEE policy configuration
+ * @phydev: Target phy_device struct
+ *
+ * This function configures the initial policy for Energy Efficient Ethernet
+ * (EEE) on the specified PHY device, influencing that EEE capabilities are
+ * advertised before the link is established. It should be called during PHY
+ * registration by the MAC driver and/or the PHY driver (for SmartEEE PHYs)
+ * if MAC supports LPI or PHY is capable to compensate missing LPI functionality
+ * of the MAC.
+ *
+ * The function sets default EEE policy parameters, including preparing the PHY
+ * to advertise EEE capabilities based on hardware support.
+ *
+ * It also sets the expected configuration for Low Power Idle (LPI) in the MAC
+ * driver. If the PHY framework determines that both local and remote
+ * advertisements support EEE, and the negotiated link mode is compatible with
+ * EEE, it will set enable_tx_lpi = true. The MAC driver is expected to act on
+ * this setting by enabling the LPI timer if enable_tx_lpi is set.
+ */
+void phy_support_eee(struct phy_device *phydev)
+{
+	linkmode_copy(phydev->advertising_eee, phydev->supported_eee);
+	phydev->eee_cfg.tx_lpi_enabled = true;
+	phydev->eee_cfg.eee_enabled = true;
+}
+EXPORT_SYMBOL(phy_support_eee);
+
 /**
  * phy_support_sym_pause - Enable support of symmetrical pause
  * @phydev: target phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index c315928357c8c..661c2c969b191 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -706,7 +706,7 @@ struct phy_device {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising);
 	/* used with phy_speed_down */
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(adv_old);
-	/* used for eee validation */
+	/* used for eee validation and configuration*/
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported_eee);
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising_eee);
 	bool eee_enabled;
@@ -1973,6 +1973,7 @@ void phy_advertise_supported(struct phy_device *phydev);
 void phy_advertise_eee_all(struct phy_device *phydev);
 void phy_support_sym_pause(struct phy_device *phydev);
 void phy_support_asym_pause(struct phy_device *phydev);
+void phy_support_eee(struct phy_device *phydev);
 void phy_set_sym_pause(struct phy_device *phydev, bool rx, bool tx,
 		       bool autoneg);
 void phy_set_asym_pause(struct phy_device *phydev, bool rx, bool tx);
-- 
2.39.2


