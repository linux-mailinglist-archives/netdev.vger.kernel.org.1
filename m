Return-Path: <netdev+bounces-196921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F9DAD6E18
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329FA189B6BA
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA81233D9E;
	Thu, 12 Jun 2025 10:42:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCF423C51A
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724939; cv=none; b=HaroAHnqfSkEh1+sQZ4UdRJNkTSWxzcHxhid8/LAnJ1vCA15+DpyE1oKdqUOK/IuYqlQ+czn2TkN+oH1KTjuB4wodlEdhAwDF61Tx+i/QhcDR4eV99EtQRgN3+SbjwvZcV/aZHCttLCc+DvMss53ifoNnndrrdS/BMtv/8hGKg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724939; c=relaxed/simple;
	bh=dccEvE8z4YXo6tWQOzZnVtCqb27+4nTiKtzvpzK8h3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t2Yvdg/Z2UicKckANkM4tCUd5AoweHaoQOLfCrhcj1BsbTwkjrxsmyPnFuKmOGqg9wMqYbCDEvpUHi6QzZV9vpSqXwQjCswhPEn8u7yHG5KVu50cC7ekedFPVM9xBCYBOHiqxNWvLCz0N2mrnDRk6VvZN3AemY7Ly3s5L1rcSCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uPfNg-00069H-GV; Thu, 12 Jun 2025 12:42:00 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uPfNf-0036k0-0S;
	Thu, 12 Jun 2025 12:41:59 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uPfNf-009UTm-0E;
	Thu, 12 Jun 2025 12:41:59 +0200
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
Subject: [PATCH net-next v2 1/3] net: phy: dp83tg720: implement soft reset with asymmetric delay
Date: Thu, 12 Jun 2025 12:41:55 +0200
Message-Id: <20250612104157.2262058-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250612104157.2262058-1-o.rempel@pengutronix.de>
References: <20250612104157.2262058-1-o.rempel@pengutronix.de>
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
Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v2:
- move by Sob to the end of commit message
- add documentation references to the comment
---
 drivers/net/phy/dp83tg720.c | 81 ++++++++++++++++++++++++++++++++-----
 1 file changed, 71 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/dp83tg720.c b/drivers/net/phy/dp83tg720.c
index 7e76323409c4..a53ea6d6130b 100644
--- a/drivers/net/phy/dp83tg720.c
+++ b/drivers/net/phy/dp83tg720.c
@@ -12,6 +12,48 @@
 
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
+ * to detect or report link status correctly. As of June 2025, no public
+ * errata sheet for the DP83TG720 PHY documents this behavior.
+ * The "DP83TC81x, DP83TG72x Software Implementation Guide" application note
+ * (SNLA404, available at https://www.ti.com/lit/an/snla404/snla404.pdf)
+ * recommends performing a soft restart if polling for a link fails to establish
+ * a connection after 100ms. This procedure is adopted as the workaround for the
+ * observed link detection issue.
+ *
+ * However, in point-to-point setups where both link partners use the same
+ * driver (e.g. Linux on both sides), a synchronized reset pattern may emerge.
+ * This leads to a deadlock, where both PHYs reset at the same time and
+ * continuously miss each other during auto-negotiation.
+ *
+ * To address this, the reset procedure includes two components:
+ *
+ * - A **fixed minimum delay of 1ms** after a hardware reset. The datasheet
+ *   "DP83TG720S-Q1 1000BASE-T1 Automotive Ethernet PHY with SGMII and RGMII"
+ *   specifies this as the "Post reset stabilization-time prior to MDC preamble
+ *   for register access" (T6.2), ensuring the PHY is ready for MDIO
+ *   operations.
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
@@ -19,6 +61,10 @@
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
@@ -28,6 +74,8 @@
 #define DP83TG720S_POLL_ACTIVE_LINK		1000
 #define DP83TG720S_POLL_NO_LINK_MIN		100
 #define DP83TG720S_POLL_NO_LINK_MAX		1000
+#define DP83TG720S_RESET_DELAY_MS_MASTER	97
+#define DP83TG720S_RESET_DELAY_MS_SLAVE		149
 
 #define DP83TG720S_PHY_ID			0x2000a284
 
@@ -201,6 +249,26 @@ static int dp83tg720_update_stats(struct phy_device *phydev)
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
@@ -477,19 +545,11 @@ static int dp83tg720_config_init(struct phy_device *phydev)
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
@@ -582,6 +642,7 @@ static struct phy_driver dp83tg720_driver[] = {
 
 	.flags          = PHY_POLL_CABLE_TEST,
 	.probe		= dp83tg720_probe,
+	.soft_reset	= dp83tg720_soft_reset,
 	.config_aneg	= dp83tg720_config_aneg,
 	.read_status	= dp83tg720_read_status,
 	.get_features	= genphy_c45_pma_read_ext_abilities,
-- 
2.39.5


