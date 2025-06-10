Return-Path: <netdev+bounces-195979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90637AD2F93
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 10:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5509188E9C2
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 08:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3F522172F;
	Tue, 10 Jun 2025 08:11:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8CA28002D
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 08:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543096; cv=none; b=BcN6fxaBMGwcYiBpTCZ05mdX+iZN1K6NwCgVUiK5toAdLvZSPFhNELdJXi6ZXFLi+P9RN3dbtuDWWUEX8sQc6Tj92BMULKsUXWU5iY1OwV0EAoBM4HUe3JKFoQRJXRmTDYrT5lg3YmEwa105sRTbz5o0R2nC6o/VxSaVU+TM+uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543096; c=relaxed/simple;
	bh=womUStL4FmravSMae7BUndIaCWMA0mdK+0Ej0yn5NnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nZ0gLZmGsk5ziqFXfm0C7kgfFIVawCzYX1gm9ThELmB9iFXe7FNLGE+aTa0KfRtHHeEnrMHOsnHXJQt2itDye8rS9jsvWLcMZ5iQxriMtPxruwJZeTgZLwatP2PZueQ9vt9Q52moLZs+hff8/AqyAsiX0mZrwelCP0CNi7j02PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uOu4T-0006BF-Dh; Tue, 10 Jun 2025 10:11:01 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uOu4S-002jx3-0Y;
	Tue, 10 Jun 2025 10:11:00 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uOu4S-00G7cZ-0K;
	Tue, 10 Jun 2025 10:11:00 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Jander <david@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v1 1/3] net: phy: dp83tg720: implement soft reset with asymmetric delay
Date: Tue, 10 Jun 2025 10:10:57 +0200
Message-Id: <20250610081059.3842459-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250610081059.3842459-1-o.rempel@pengutronix.de>
References: <20250610081059.3842459-1-o.rempel@pengutronix.de>
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

From: David Jander <david@protonic.nl>

Add a .soft_reset callback for the DP83TG720 PHY that issues a hardware
reset followed by an asymmetric post-reset delay. The delay differs
based on the PHY's master/slave role to avoid synchronized reset
deadlocks, which are known to occur when both link partners use
identical reset intervals.

The delay includes:
- a fixed 1ms wait to satisfy MDC access timing per datasheet, and
- an empirically chosen extra delay (97ms for master, 149ms for slave).

Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/net/phy/dp83tg720.c | 75 ++++++++++++++++++++++++++++++++-----
 1 file changed, 65 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/dp83tg720.c b/drivers/net/phy/dp83tg720.c
index 7e76323409c4..2c86d05bf857 100644
--- a/drivers/net/phy/dp83tg720.c
+++ b/drivers/net/phy/dp83tg720.c
@@ -12,6 +12,42 @@
 
 #include "open_alliance_helpers.h"
 
+/*
+ * DP83TG720 PHY Limitations and Workarounds
+ *
+ * The DP83TG720 1000BASE-T1 PHY has several limitations that require
+ * software-side mitigations. These workarounds are implemented throughout
+ * this driver. This section documents the known issues and their corresponding
+ * mitigation strategies.
+ *
+ * 1. Unreliable Link Detection and Synchronized Reset Deadlock
+ * ------------------------------------------------------------
+ * After a link loss or during link establishment, the DP83TG720 PHY may fail
+ * to detect or report link status correctly. To work around this, the PHY must
+ * be reset periodically when no link is detected.
+ *
+ * However, in point-to-point setups where both link partners use the same
+ * driver (e.g. Linux on both sides), a synchronized reset pattern may emerge.
+ * This leads to a deadlock, where both PHYs reset at the same time and
+ * continuously miss each other during auto-negotiation.
+ *
+ * To address this, the reset procedure includes two components:
+ *
+ * - A **fixed minimum delay of 1ms** after issuing a hardware reset, as
+ *   required by the "DP83TG720S-Q1 1000BASE-T1 Automotive Ethernet PHY with
+ *   SGMII and RGMII" datasheet. This ensures MDC access timing is respected
+ *   before any further MDIO operations.
+ *
+ * - An **additional asymmetric delay**, empirically chosen based on
+ *   master/slave role. This reduces the risk of synchronized resets on both
+ *   link partners. Values are selected to avoid periodic overlap and ensure
+ *   the link is re-established within a few cycles.
+ *
+ * The functions that implement this logic are:
+ * - dp83tg720_soft_reset()
+ * - dp83tg720_get_next_update_time()
+ */
+
 /*
  * DP83TG720S_POLL_ACTIVE_LINK - Polling interval in milliseconds when the link
  *				 is active.
@@ -19,6 +55,10 @@
  *				 the link is down.
  * DP83TG720S_POLL_NO_LINK_MAX - Maximum polling interval in milliseconds when
  *				 the link is down.
+ * DP83TG720S_RESET_DELAY_MS_MASTER - Delay after a reset before attempting
+ *				 to establish a link again for master phy.
+ * DP83TG720S_RESET_DELAY_MS_SLAVE  - Delay after a reset before attempting
+ *				 to establish a link again for slave phy.
  *
  * These values are not documented or officially recommended by the vendor but
  * were determined through empirical testing. They achieve a good balance in
@@ -28,6 +68,8 @@
 #define DP83TG720S_POLL_ACTIVE_LINK		1000
 #define DP83TG720S_POLL_NO_LINK_MIN		100
 #define DP83TG720S_POLL_NO_LINK_MAX		1000
+#define DP83TG720S_RESET_DELAY_MS_MASTER	97
+#define DP83TG720S_RESET_DELAY_MS_SLAVE		149
 
 #define DP83TG720S_PHY_ID			0x2000a284
 
@@ -201,6 +243,26 @@ static int dp83tg720_update_stats(struct phy_device *phydev)
 	return 0;
 }
 
+static int dp83tg720_soft_reset(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = phy_write(phydev, DP83TG720S_PHY_RESET, DP83TG720S_HW_RESET);
+	if (ret)
+		return ret;
+
+	/* Include mandatory MDC-access delay (1ms) + extra asymmetric delay to
+	 * avoid synchronized reset deadlock. See section 1 in the top-of-file
+	 * comment block.
+	 */
+	if (phydev->master_slave_state == MASTER_SLAVE_STATE_SLAVE)
+		msleep(DP83TG720S_RESET_DELAY_MS_SLAVE);
+	else
+		msleep(DP83TG720S_RESET_DELAY_MS_MASTER);
+
+	return ret;
+}
+
 static void dp83tg720_get_link_stats(struct phy_device *phydev,
 				     struct ethtool_link_ext_stats *link_stats)
 {
@@ -477,19 +539,11 @@ static int dp83tg720_config_init(struct phy_device *phydev)
 {
 	int ret;
 
-	/* Software Restart is not enough to recover from a link failure.
-	 * Using Hardware Reset instead.
-	 */
-	ret = phy_write(phydev, DP83TG720S_PHY_RESET, DP83TG720S_HW_RESET);
+	/* Reset the PHY to recover from a link failure */
+	ret = dp83tg720_soft_reset(phydev);
 	if (ret)
 		return ret;
 
-	/* Wait until MDC can be used again.
-	 * The wait value of one 1ms is documented in "DP83TG720S-Q1 1000BASE-T1
-	 * Automotive Ethernet PHY with SGMII and RGMII" datasheet.
-	 */
-	usleep_range(1000, 2000);
-
 	if (phy_interface_is_rgmii(phydev)) {
 		ret = dp83tg720_config_rgmii_delay(phydev);
 		if (ret)
@@ -582,6 +636,7 @@ static struct phy_driver dp83tg720_driver[] = {
 
 	.flags          = PHY_POLL_CABLE_TEST,
 	.probe		= dp83tg720_probe,
+	.soft_reset	= dp83tg720_soft_reset,
 	.config_aneg	= dp83tg720_config_aneg,
 	.read_status	= dp83tg720_read_status,
 	.get_features	= genphy_c45_pma_read_ext_abilities,
-- 
2.39.5


