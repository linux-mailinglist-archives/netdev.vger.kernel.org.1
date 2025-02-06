Return-Path: <netdev+bounces-163454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C814A2A4C2
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 10:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA743168169
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B23F226546;
	Thu,  6 Feb 2025 09:39:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3F6225A4E
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834753; cv=none; b=GPxYigsnvHL7UwTPKnFQWD9N6IMMB7oy6LNF8qoxvEY1v8aVuINLE76qxN9T1MQqOM59ZNwBzJzUSKMF4VDon4x6VDs7pGDfCibGMLHtBviMu/Xk5uvObRazp8mTKatw6/VJLG5Twnp33/jPzUixPK7O5b2DUjzI9UD04ZZw3Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834753; c=relaxed/simple;
	bh=UtTeq36ttG6Qv6ncLvcU8t666fwMFM5i+JqO5dRPlMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ndVp3gUnhTgG1FoUWJ3FSV4plCJjqIEdw0aDf0QoxAMq5w8AXogktumsRNusxsdxlnYhLEl7DY4TpwhqoyruOJxldqxILmNlaYmuSE8HYH+/HuRNJhk92D+smzFavfYzfMNP14EiyCCARcSdqjEE4rnlUqvQf+ZE4vFZ7MfR4cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tfyLg-0006ze-7E; Thu, 06 Feb 2025 10:39:04 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tfyLe-003mdD-3D;
	Thu, 06 Feb 2025 10:39:03 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tfyLe-00Dylv-30;
	Thu, 06 Feb 2025 10:39:02 +0100
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
Subject: [PATCH net-next v3 1/2] net: phy: Add support for driver-specific next update time
Date: Thu,  6 Feb 2025 10:39:01 +0100
Message-Id: <20250206093902.3331832-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250206093902.3331832-1-o.rempel@pengutronix.de>
References: <20250206093902.3331832-1-o.rempel@pengutronix.de>
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
to dynamically determine the time (in jiffies) until the next state
update event. This enables more flexible and adaptive polling intervals
based on the link state or other conditions.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v3:
- use jiffies instead of milliseconds
changes v2:
- phy_get_next_update_time: remove useless variable
---
 drivers/net/phy/phy.c | 20 +++++++++++++++++++-
 include/linux/phy.h   | 13 +++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index d0c1718e2b16..81fa1388a078 100644
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
+ * Return: The time for the next polling event in jiffies
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
@@ -1580,7 +1597,8 @@ static enum phy_state_work _phy_state_machine(struct phy_device *phydev)
 	 * called from phy_disconnect() synchronously.
 	 */
 	if (phy_polling_mode(phydev) && phy_is_started(phydev))
-		phy_queue_state_machine(phydev, PHY_STATE_TIME);
+		phy_queue_state_machine(phydev,
+					phy_get_next_update_time(phydev));
 
 	return state_work;
 }
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 19f076a71f94..00fcdd9258f4 100644
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
+	 * Callback to determine the time (in jiffies) until the next
+	 * update event for the PHY state  machine. Allows PHY drivers to
+	 * dynamically adjust polling intervals based on link state or other
+	 * conditions.
+	 *
+	 * Returns the time in jiffies until the next update event.
+	 */
+	unsigned int (*get_next_update_time)(struct phy_device *dev);
 };
 #define to_phy_driver(d) container_of_const(to_mdio_common_driver(d),		\
 				      struct phy_driver, mdiodrv)
-- 
2.39.5


