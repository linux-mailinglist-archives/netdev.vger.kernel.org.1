Return-Path: <netdev+bounces-164592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1D9A2E65D
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C1C3AAFD2
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 08:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB791C3BE0;
	Mon, 10 Feb 2025 08:24:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDBA1C3039
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739175862; cv=none; b=sSBOaLZNW9b7TorhqOaHp674WsPeBPw1Ha8uXO1HVabKcvBeu5GFktJRpWpni32TiIcjyG2E78c4ncWN52MrdzsOujgEoaWSGGgf7t8FXbR+KnOIp3lC+YRgHena6szc7py7nX/u3ii/+9KhO6W5BhAB2JN62TkOz+scSjWt74c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739175862; c=relaxed/simple;
	bh=8uZ3Bd2+9Y2lL4JbcJ3q0uxnHCxYlNxJIRDfPT99dOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h0fhGiUco4ryj9Soug0lHTjCGsNUkvd5GFoiF4sEhmpzOYhBuJ+owbj4iepllJdcprIvhk+anhunbduPmGRRQXde0BeMpZEJFwbusoyYvR/EGBadvS7ShBnU5T3xmHEAocXCMT3aO9/IJ09SBdF5xrqKYTh8FmsVE2WLz2X8siw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1thP5E-0001zK-SJ; Mon, 10 Feb 2025 09:24:00 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1thP5D-000DBl-15;
	Mon, 10 Feb 2025 09:23:59 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1thP5D-000qEb-0s;
	Mon, 10 Feb 2025 09:23:59 +0100
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
Subject: [PATCH net-next v4 1/2] net: phy: Add support for driver-specific next update time
Date: Mon, 10 Feb 2025 09:23:57 +0100
Message-Id: <20250210082358.200751-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210082358.200751-1-o.rempel@pengutronix.de>
References: <20250210082358.200751-1-o.rempel@pengutronix.de>
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
changes v4:
- fix comment width
- fix copy paste artifact in the comment
changes v3:
- use jiffies instead of milliseconds
changes v2:
- phy_get_next_update_time: remove useless variable
---
 drivers/net/phy/phy.c | 21 ++++++++++++++++++++-
 include/linux/phy.h   | 13 +++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index d0c1718e2b16..347ad1b64497 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1501,6 +1501,24 @@ void phy_free_interrupt(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(phy_free_interrupt);
 
+/**
+ * phy_get_next_update_time - Determine the next PHY update time
+ * @phydev: Pointer to the phy_device structure
+ *
+ * This function queries the PHY driver to get the time for the next polling
+ * event. If the driver does not implement the callback, a default value is
+ * used.
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
@@ -1580,7 +1598,8 @@ static enum phy_state_work _phy_state_machine(struct phy_device *phydev)
 	 * called from phy_disconnect() synchronously.
 	 */
 	if (phy_polling_mode(phydev) && phy_is_started(phydev))
-		phy_queue_state_machine(phydev, PHY_STATE_TIME);
+		phy_queue_state_machine(phydev,
+					phy_get_next_update_time(phydev));
 
 	return state_work;
 }
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 19f076a71f94..0493553ed60b 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1273,6 +1273,19 @@ struct phy_driver {
 	 */
 	int (*led_polarity_set)(struct phy_device *dev, int index,
 				unsigned long modes);
+
+	/**
+	 * @get_next_update_time: Get the time until the next update event
+	 * @dev: PHY device
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


