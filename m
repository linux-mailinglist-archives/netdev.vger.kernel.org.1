Return-Path: <netdev+bounces-196923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D63BAD6E13
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932AF3AE6FD
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108D72459CD;
	Thu, 12 Jun 2025 10:42:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927D623C51C
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724941; cv=none; b=EGWledKjaC01QqWXJb8FHFX1iabFYihlp2kRZcYF4Izx1ybHd99vgAyNtvG4ZVCR6F+qryJXdWXGc2W4yw6a09RXX0FeBrJ0UWZysWZREgj2Rxh2lwtnVzJ4d8NyRUurufxt7dfQmAEifPP8ku3ndcpmO1iMhjrESh9kwcxHiRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724941; c=relaxed/simple;
	bh=ouu2cHZCiDwpO+QTY/I1XSm6jEuv/+YIdngIZFjwsBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=evSiqHHnkhr8v+8bk6dMyHUlEI05yxnU5wSAmqZnkaTHDpbt33H1Dsh6SAHAtxyvz9sNQ/AzxbVTj4pi7r2c7Iw+p/C1nle5qiveXaGIw0xLzCMHllc58GV9FMrIw5jODJKlWBwa5kXNLqBJbcar1Pfld7ArN62TEKbC2AmCl4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uPfNg-00069J-GV; Thu, 12 Jun 2025 12:42:00 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uPfNf-0036k2-0Z;
	Thu, 12 Jun 2025 12:41:59 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uPfNf-009UU6-0L;
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
Subject: [PATCH net-next v2 3/3] net: phy: dp83tg720: switch to adaptive polling and remove random delays
Date: Thu, 12 Jun 2025 12:41:57 +0200
Message-Id: <20250612104157.2262058-4-o.rempel@pengutronix.de>
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

Now that the PHY reset logic includes a role-specific asymmetric delay
to avoid synchronized reset deadlocks, the previously used randomized
polling intervals are no longer necessary.

This patch removes the get_random_u32_below()-based logic and introduces
an adaptive polling strategy:
- Fast polling for a short time after link-down
- Slow polling if the link remains down
- Slower polling when the link is up

This balances CPU usage and responsiveness while avoiding reset
collisions. Additionally, the driver still relies on polling for
all link state changes, as interrupt support is not implemented,
and link-up events are not reliably signaled by the PHY.

The polling parameters are now documented in the updated top-of-file
comment.

Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v2:
- move by Sob to the end of commit message
---
 drivers/net/phy/dp83tg720.c | 94 ++++++++++++++++++++++---------------
 1 file changed, 55 insertions(+), 39 deletions(-)

diff --git a/drivers/net/phy/dp83tg720.c b/drivers/net/phy/dp83tg720.c
index 92597d12ecb9..391c1d868808 100644
--- a/drivers/net/phy/dp83tg720.c
+++ b/drivers/net/phy/dp83tg720.c
@@ -52,15 +52,37 @@
  * The functions that implement this logic are:
  * - dp83tg720_soft_reset()
  * - dp83tg720_get_next_update_time()
+ *
+ * 2. Polling-Based Link Detection and IRQ Support
+ * -----------------------------------------------
+ * Due to the PHY-specific limitation described in section 1, link-up events
+ * cannot be reliably detected via interrupts on the DP83TG720. Therefore,
+ * polling is required to detect transitions from link-down to link-up.
+ *
+ * While link-down events *can* be detected via IRQs on this PHY, this driver
+ * currently does **not** implement interrupt support. As a result, all link
+ * state changes must be detected using polling.
+ *
+ * Polling behavior:
+ * - When the link is up: slow polling (e.g. 1s).
+ * - When the link just went down: fast polling for a short time.
+ * - When the link stays down: fallback to slow polling.
+ *
+ * This design balances responsiveness and CPU usage. It sacrifices fast link-up
+ * times in cases where the link is expected to remain down for extended periods,
+ * assuming that such systems do not require immediate reactivity.
  */
 
 /*
  * DP83TG720S_POLL_ACTIVE_LINK - Polling interval in milliseconds when the link
  *				 is active.
- * DP83TG720S_POLL_NO_LINK_MIN - Minimum polling interval in milliseconds when
- *				 the link is down.
- * DP83TG720S_POLL_NO_LINK_MAX - Maximum polling interval in milliseconds when
- *				 the link is down.
+ * DP83TG720S_POLL_NO_LINK     - Polling interval in milliseconds when the
+ *				 link is down.
+ * DP83TG720S_FAST_POLL_DURATION_MS - Timeout in milliseconds for no-link
+ *				 polling after which polling interval is
+ *				 increased.
+ * DP83TG720S_POLL_SLOW	       - Slow polling interval when there is no
+ *				 link for a prolongued period.
  * DP83TG720S_RESET_DELAY_MS_MASTER - Delay after a reset before attempting
  *				 to establish a link again for master phy.
  * DP83TG720S_RESET_DELAY_MS_SLAVE  - Delay after a reset before attempting
@@ -71,9 +93,10 @@
  * minimizing the number of reset retries while ensuring reliable link recovery
  * within a reasonable timeframe.
  */
-#define DP83TG720S_POLL_ACTIVE_LINK		1000
-#define DP83TG720S_POLL_NO_LINK_MIN		100
-#define DP83TG720S_POLL_NO_LINK_MAX		1000
+#define DP83TG720S_POLL_ACTIVE_LINK		421
+#define DP83TG720S_POLL_NO_LINK			149
+#define DP83TG720S_FAST_POLL_DURATION_MS	6000
+#define DP83TG720S_POLL_SLOW			1117
 #define DP83TG720S_RESET_DELAY_MS_MASTER	97
 #define DP83TG720S_RESET_DELAY_MS_SLAVE		149
 
@@ -172,6 +195,7 @@ struct dp83tg720_stats {
 
 struct dp83tg720_priv {
 	struct dp83tg720_stats stats;
+	unsigned long last_link_down_jiffies;
 };
 
 /**
@@ -575,50 +599,42 @@ static int dp83tg720_probe(struct phy_device *phydev)
 }
 
 /**
- * dp83tg720_get_next_update_time - Determine the next update time for PHY
- *                                  state
+ * dp83tg720_get_next_update_time - Return next polling interval for PHY state
  * @phydev: Pointer to the phy_device structure
  *
- * This function addresses a limitation of the DP83TG720 PHY, which cannot
- * reliably detect or report a stable link state. To recover from such
- * scenarios, the PHY must be periodically reset when the link is down. However,
- * if the link partner also runs Linux with the same driver, synchronized reset
- * intervals can lead to a deadlock where the link never establishes due to
- * simultaneous resets on both sides.
- *
- * To avoid this, the function implements randomized polling intervals when the
- * link is down. It ensures that reset intervals are desynchronized by
- * introducing a random delay between a configured minimum and maximum range.
- * When the link is up, a fixed polling interval is used to minimize overhead.
- *
- * This mechanism guarantees that the link will reestablish within 10 seconds
- * in the worst-case scenario.
+ * Implements adaptive polling interval logic depending on link state and
+ * downtime duration. See the "2. Polling-Based Link Detection and IRQ Support"
+ * section at the top of this file for details.
  *
- * Return: Time (in jiffies) until the next update event for the PHY state
- * machine.
+ * Return: Time (in jiffies) until the next poll
  */
 static unsigned int dp83tg720_get_next_update_time(struct phy_device *phydev)
 {
+	struct dp83tg720_priv *priv = phydev->priv;
 	unsigned int next_time_jiffies;
 
 	if (phydev->link) {
-		/* When the link is up, use a fixed 1000ms interval
-		 * (in jiffies)
-		 */
+		priv->last_link_down_jiffies = 0;
+
+		/* When the link is up, use a slower interval (in jiffies) */
 		next_time_jiffies =
 			msecs_to_jiffies(DP83TG720S_POLL_ACTIVE_LINK);
 	} else {
-		unsigned int min_jiffies, max_jiffies, rand_jiffies;
-
-		/* When the link is down, randomize interval between min/max
-		 * (in jiffies)
-		 */
-		min_jiffies = msecs_to_jiffies(DP83TG720S_POLL_NO_LINK_MIN);
-		max_jiffies = msecs_to_jiffies(DP83TG720S_POLL_NO_LINK_MAX);
-
-		rand_jiffies = min_jiffies +
-			get_random_u32_below(max_jiffies - min_jiffies + 1);
-		next_time_jiffies = rand_jiffies;
+		unsigned long now = jiffies;
+
+		if (!priv->last_link_down_jiffies)
+			priv->last_link_down_jiffies = now;
+
+		if (time_before(now, priv->last_link_down_jiffies +
+			  msecs_to_jiffies(DP83TG720S_FAST_POLL_DURATION_MS))) {
+			/* Link recently went down: fast polling */
+			next_time_jiffies =
+				msecs_to_jiffies(DP83TG720S_POLL_NO_LINK);
+		} else {
+			/* Link has been down for a while: slow polling */
+			next_time_jiffies =
+				msecs_to_jiffies(DP83TG720S_POLL_SLOW);
+		}
 	}
 
 	/* Ensure the polling time is at least one jiffy */
-- 
2.39.5


