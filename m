Return-Path: <netdev+bounces-162907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F83EA2863C
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 10:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7CE03A7556
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 09:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F027722A7E4;
	Wed,  5 Feb 2025 09:12:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4384422A4F5
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738746725; cv=none; b=bu6zqenB4H1Kzh4SPN7285k5ajC9dSsc5IOXuuN9ZWL2Ah/F3Jad26vENL/D0ah4eaYU3VTMIl3d95TQ+d+1sA2J4jGXJqM2JJdawhBHXbdqcK3w8x9rM2z6oMuLMAscnNTS1q+zOf6E4B1gTUn6cXgC8s97A9/1PnbbuVYQTPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738746725; c=relaxed/simple;
	bh=pbXBgqmpa8g7lHJjiKhKj13eV+pZcw3MOSN/M6mpvZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uuwB7RKg7W8YremuWO8i3pzGB/ciFDaN8a9VA1axmeAD0oKMvPrD4e7FrMR7yA/EJwyyD6U9o21ej8iLdHyqH4X7oCKEyR/nrJRtDfg+VmXF8NjUtVHb6jSDQXHGNrZ7CTR7NBeEPVQDMTw6CHY5jYP/G1S2BANlyu5q0Un9rOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tfbRq-0000GC-C3; Wed, 05 Feb 2025 10:11:54 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tfbRo-003bto-2B;
	Wed, 05 Feb 2025 10:11:52 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tfbRo-0095Ou-1x;
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
Subject: [PATCH net-next v2 1/2] net: phy: Add support for driver-specific next update time
Date: Wed,  5 Feb 2025 10:11:50 +0100
Message-Id: <20250205091151.2165678-2-o.rempel@pengutronix.de>
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

Introduce the `phy_get_next_update_time` function to allow PHY drivers
to dynamically determine the time (in milliseconds) until the next state
update event. This enables more flexible and adaptive polling intervals
based on the link state or other conditions.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v2:
- phy_get_next_update_time: remove useless variable
---
 drivers/net/phy/phy.c | 26 ++++++++++++++++++++++++--
 include/linux/phy.h   | 13 +++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index d0c1718e2b16..2df1e57dd9aa 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1501,6 +1501,23 @@ void phy_free_interrupt(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(phy_free_interrupt);
 
+/**
+ * phy_get_next_update_time - Determine the next PHY update time
+ * @phydev: Pointer to the phy_device structure
+ *
+ * This function queries the PHY driver to get the time for the next polling
+ * event. If the driver does not implement the callback, a default value is used.
+ *
+ * Return: The time for the next polling event in milliseconds
+ */
+static unsigned int phy_get_next_update_time(struct phy_device *phydev)
+{
+	if (phydev->drv && phydev->drv->get_next_update_time)
+		return phydev->drv->get_next_update_time(phydev);
+
+	return PHY_STATE_TIME;
+}
+
 enum phy_state_work {
 	PHY_STATE_WORK_NONE,
 	PHY_STATE_WORK_ANEG,
@@ -1579,8 +1596,13 @@ static enum phy_state_work _phy_state_machine(struct phy_device *phydev)
 	 * state machine would be pointless and possibly error prone when
 	 * called from phy_disconnect() synchronously.
 	 */
-	if (phy_polling_mode(phydev) && phy_is_started(phydev))
-		phy_queue_state_machine(phydev, PHY_STATE_TIME);
+	if (phy_polling_mode(phydev) && phy_is_started(phydev)) {
+		unsigned int next_update_time =
+			phy_get_next_update_time(phydev);
+
+		phy_queue_state_machine(phydev,
+					msecs_to_jiffies(next_update_time));
+	}
 
 	return state_work;
 }
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 19f076a71f94..d5cf979f4a6b 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1273,6 +1273,19 @@ struct phy_driver {
 	 */
 	int (*led_polarity_set)(struct phy_device *dev, int index,
 				unsigned long modes);
+
+	/**
+	 * @get_next_update_time: Get the time until the next update event
+	 * @dev: PHY device which has the LED
+	 *
+	 * Callback to determine the time (in milliseconds) until the next
+	 * update event for the PHY state  machine. Allows PHY drivers to
+	 * dynamically adjust polling intervals based on link state or other
+	 * conditions.
+	 *
+	 * Returns the time in milliseconds until the next update event.
+	 */
+	unsigned int (*get_next_update_time)(struct phy_device *dev);
 };
 #define to_phy_driver(d) container_of_const(to_mdio_common_driver(d),		\
 				      struct phy_driver, mdiodrv)
-- 
2.39.5


