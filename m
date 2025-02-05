Return-Path: <netdev+bounces-162908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C64A2863E
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 10:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20ECE3A76E3
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 09:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0896922A7E7;
	Wed,  5 Feb 2025 09:12:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437E622A4F4
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738746725; cv=none; b=rl+PvFRpjET/jrCot8ihLXRnVBYtM7TpSjJp+GcxbeA0rLPnGSv1vsjC21tkI3qWiKMMUBJZCj3jXG8Uy7KcfieVdzJ9OZSqk6+znka8DJR3fawwTpP1BwjJh3ubsu8juAKskFtUv4Zlt6UuaL+0UiRCzgWOPvke1l2OhKh93LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738746725; c=relaxed/simple;
	bh=92qfpD71gNQMGZZnMwyLr7xXSzduU0c/YqctgGUjj7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GiExZQVBgaUIa4LALW1LnUmtvwvl5K1UdPpYbCKRBdg0PyRzc3lrAZJ6Qj7cTDBzpRHW9u5d+Q+6k0oDuBz+R/d0oypdG8Cdm0CqAStFeDLyRxKof7VZR61KA2E0J7ckXjQmU295hDxZnEmWpnfQKBLCNasFQ3G846kff7nnI3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tfbRq-0000GJ-C4; Wed, 05 Feb 2025 10:11:54 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tfbRo-003btp-2H;
	Wed, 05 Feb 2025 10:11:52 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tfbRo-0095P4-22;
	Wed, 05 Feb 2025 10:11:52 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 2/2] net: phy: dp83tg720: Add randomized polling intervals for unstable link detection
Date: Wed,  5 Feb 2025 10:11:51 +0100
Message-Id: <20250205091151.2165678-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250205091151.2165678-1-o.rempel@pengutronix.de>
References: <20250205091151.2165678-1-o.rempel@pengutronix.de>
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

Address the limitations of the DP83TG720 PHY, which cannot reliably detect or
report a stable link state. To handle this, the PHY must be periodically reset
when the link is down. However, synchronized reset intervals between the PHY
and its link partner can result in a deadlock, preventing the link from
re-establishing.

This change introduces a randomized polling interval when the link is down to
desynchronize resets between link partners.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/dp83tg720.c | 78 +++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/net/phy/dp83tg720.c b/drivers/net/phy/dp83tg720.c
index 050f4537d140..0599807de5c7 100644
--- a/drivers/net/phy/dp83tg720.c
+++ b/drivers/net/phy/dp83tg720.c
@@ -4,12 +4,31 @@
  */
 #include <linux/bitfield.h>
 #include <linux/ethtool_netlink.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/phy.h>
+#include <linux/random.h>
 
 #include "open_alliance_helpers.h"
 
+/*
+ * DP83TG720S_POLL_ACTIVE_LINK - Polling interval in milliseconds when the link
+ *				 is active.
+ * DP83TG720S_POLL_NO_LINK_MIN - Minimum polling interval in milliseconds when
+ *				 the link is down.
+ * DP83TG720S_POLL_NO_LINK_MAX - Maximum polling interval in milliseconds when
+ *				 the link is down.
+ *
+ * These values are not documented or officially recommended by the vendor but
+ * were determined through empirical testing. They achieve a good balance in
+ * minimizing the number of reset retries while ensuring reliable link recovery
+ * within a reasonable timeframe.
+ */
+#define DP83TG720S_POLL_ACTIVE_LINK		1000
+#define DP83TG720S_POLL_NO_LINK_MIN		100
+#define DP83TG720S_POLL_NO_LINK_MAX		1000
+
 #define DP83TG720S_PHY_ID			0x2000a284
 
 /* MDIO_MMD_VEND2 registers */
@@ -371,6 +390,13 @@ static int dp83tg720_read_status(struct phy_device *phydev)
 		if (ret)
 			return ret;
 
+		/* Sleep 600ms for PHY stabilization post-reset.
+		 * Empirically chosen value (not documented).
+		 * Helps reduce reset bounces with link partners having similar
+		 * issues.
+		 */
+		msleep(600);
+
 		/* After HW reset we need to restore master/slave configuration.
 		 * genphy_c45_pma_baset1_read_master_slave() call will be done
 		 * by the dp83tg720_config_aneg() function.
@@ -498,6 +524,57 @@ static int dp83tg720_probe(struct phy_device *phydev)
 	return 0;
 }
 
+/**
+ * dp83tg720_phy_get_next_update_time - Determine the next update time for PHY
+ *                                      state
+ * @phydev: Pointer to the phy_device structure
+ *
+ * This function addresses a limitation of the DP83TG720 PHY, which cannot
+ * reliably detect or report a stable link state. To recover from such
+ * scenarios, the PHY must be periodically reset when the link is down. However,
+ * if the link partner also runs Linux with the same driver, synchronized reset
+ * intervals can lead to a deadlock where the link never establishes due to
+ * simultaneous resets on both sides.
+ *
+ * To avoid this, the function implements randomized polling intervals when the
+ * link is down. It ensures that reset intervals are desynchronized by
+ * introducing a random delay between a configured minimum and maximum range.
+ * When the link is up, a fixed polling interval is used to minimize overhead.
+ *
+ * This mechanism guarantees that the link will reestablish within 10 seconds
+ * in the worst-case scenario.
+ *
+ * Return: Time (in milliseconds) until the next update event for the PHY state
+ * machine.
+ */
+static unsigned int dp83tg720_phy_get_next_update_time(struct phy_device *phydev)
+{
+	unsigned int jiffy_ms = jiffies_to_msecs(1); /* Jiffy granularity in ms */
+	unsigned int next_time_ms;
+
+	if (phydev->link) {
+		/* When the link is up, use a fixed 1000ms interval */
+		next_time_ms = DP83TG720S_POLL_ACTIVE_LINK;
+	} else {
+		unsigned int min_jiffies, max_jiffies, rand_jiffies;
+		/* When the link is down, randomize interval between
+		 * configured min/max
+		 */
+
+		/* Convert min and max to jiffies */
+		min_jiffies = msecs_to_jiffies(DP83TG720S_POLL_NO_LINK_MIN);
+		max_jiffies = msecs_to_jiffies(DP83TG720S_POLL_NO_LINK_MAX);
+
+		/* Randomize in the jiffie range and convert back to ms */
+		rand_jiffies = min_jiffies +
+			get_random_u32_below(max_jiffies - min_jiffies + 1);
+		next_time_ms = jiffies_to_msecs(rand_jiffies);
+	}
+
+	/* Ensure the polling time is at least one jiffy */
+	return max(next_time_ms, jiffy_ms);
+}
+
 static struct phy_driver dp83tg720_driver[] = {
 {
 	PHY_ID_MATCH_MODEL(DP83TG720S_PHY_ID),
@@ -516,6 +593,7 @@ static struct phy_driver dp83tg720_driver[] = {
 	.get_link_stats	= dp83tg720_get_link_stats,
 	.get_phy_stats	= dp83tg720_get_phy_stats,
 	.update_stats	= dp83tg720_update_stats,
+	.get_next_update_time = dp83tg720_phy_get_next_update_time,
 
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
-- 
2.39.5


