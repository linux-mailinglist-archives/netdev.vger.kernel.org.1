Return-Path: <netdev+bounces-147598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 458E99DA841
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 14:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E926E1674F1
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 13:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312661FCF63;
	Wed, 27 Nov 2024 13:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3171FAC3B
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732713023; cv=none; b=nW4jpOv+27jL0P5N5dxNlA0FlVu/+dqxDDJcYfK+XNMB9ZboFF4mz29sTzJAGg+VRJ7IJ9gvBz0Cg6btL23AytT2RkSufUJ3RxBri44KoC4owTE2POUt9xBTw+IyLRoRwNQPesRr9wG+LX3TUN9MaNbLGUB9OwylwvHJ7OltFww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732713023; c=relaxed/simple;
	bh=EOh92bEuxwS6HTMBz3ZSifuHMXu6RBK4J5pkkY7/m8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B3kV1wMgtSO+hgmn6g446jKGbeGoAYYXdAIA/C1+kaSOgxS7NXHF/e43vkGd6pM9zUzB0zDdJxKGu8CKDJvHYANP97oSbRN5PIbXwEPaV0nTriFOmdBf/EJSRe3aSgBzxo6/qB+Rh63Rv0SEexpDYngWLcf1JZMOIJRqPyDZVJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tGHo4-0001wg-VO; Wed, 27 Nov 2024 14:10:12 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tGHo3-000R6b-0o;
	Wed, 27 Nov 2024 14:10:12 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tGHo3-000O9F-35;
	Wed, 27 Nov 2024 14:10:11 +0100
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
Subject: [RFC net-next v1 1/2] net: phy: Add support for driver-specific next update time
Date: Wed, 27 Nov 2024 14:10:10 +0100
Message-Id: <20241127131011.92800-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
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
 drivers/net/phy/phy.c | 29 +++++++++++++++++++++++++++--
 include/linux/phy.h   | 13 +++++++++++++
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index cec3f6280e44..0c9f3c03500c 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1401,6 +1401,26 @@ void phy_free_interrupt(struct phy_device *phydev)
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
+	const unsigned int default_time = PHY_STATE_TIME;
+
+	/* Ensure valid driver and callback are present */
+	if (phydev && phydev->drv && phydev->drv->get_next_update_time)
+		return phydev->drv->get_next_update_time(phydev);
+
+	return default_time;
+}
+
 enum phy_state_work {
 	PHY_STATE_WORK_NONE,
 	PHY_STATE_WORK_ANEG,
@@ -1479,8 +1499,13 @@ static enum phy_state_work _phy_state_machine(struct phy_device *phydev)
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
index 4a4e7c32222f..bdfe5fa01d3d 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1202,6 +1202,19 @@ struct phy_driver {
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


