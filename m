Return-Path: <netdev+bounces-206109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 366D3B018BB
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 11:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CECCD5C0D7B
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 09:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B625A28507A;
	Fri, 11 Jul 2025 09:49:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DC428136E
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 09:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227366; cv=none; b=VS0TVsV0VA/gGxsceTxqUVLT4qfJCtnE8HDhxHJGBFhDv6/SZYekzxeoVgomXLH+39QcUFhFL2crt7cUWpcDfAHoPrH0GcfTXNXX2ZjqGWDLHcGRSnWEkiZ5HkOsQqgJ++RXcqWA8C8LGYC+doymN4NT5jXvJG8MonUwMZxQOsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227366; c=relaxed/simple;
	bh=1ad/oVGOkNZugVTe+0tx+Mb3hIHVwgGk5vlRRU29NF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=asa8k4icKiiaNhEqSd4YGXz4oWHNwwW+pELMhFeEx/g4Hnna4Vp4JITz0nCyvaUffpNH03OtC6P60/D6jXgNM78Zd/Upeot3IXmGLOxP2NZvdQpB00sfSVK9QnP/TSQi0RsaEJtxCsefKOHThre1QgP7X1b4Qg6qVJdv1AX0Qt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uaANU-0007fW-6b; Fri, 11 Jul 2025 11:49:12 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uaANS-007tqI-1S;
	Fri, 11 Jul 2025 11:49:10 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uaANS-004YgR-1C;
	Fri, 11 Jul 2025 11:49:10 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	Andre Edich <andre.edich@microchip.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: [PATCH net v3 2/3] net: phy: allow drivers to disable polling via get_next_update_time()
Date: Fri, 11 Jul 2025 11:49:08 +0200
Message-Id: <20250711094909.1086417-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250711094909.1086417-1-o.rempel@pengutronix.de>
References: <20250711094909.1086417-1-o.rempel@pengutronix.de>
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

Some PHY drivers can reliably report link-down events via IRQs,
but may fail to generate reliable link-up IRQs. To support such
cases, polling is often needed - but only selectively.

Extend get_next_update_time() so drivers can return PHY_STATE_IRQ
to indicate that polling is not needed and IRQs are sufficient.
This allows finer control over PHY state machine behavior.

Introduce PHY_STATE_IRQ (UINT_MAX) as a sentinel value, and move
PHY_STATE_TIME to phy.h to allow consistent use across the codebase.

This change complements the previous patch enabling polling when
get_next_update_time() is present.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v3:
- handle conflicting configuration if update_stats are supported
changes v2:
- this patch is added
---
 drivers/net/phy/phy.c | 27 ++++++++++++++++++++-------
 include/linux/phy.h   | 15 ++++++++++++++-
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 13df28445f02..3314accedcfd 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -39,8 +39,6 @@
 #include "phylib-internal.h"
 #include "phy-caps.h"
 
-#define PHY_STATE_TIME	HZ
-
 #define PHY_STATE_STR(_state)			\
 	case PHY_##_state:			\
 		return __stringify(_state);	\
@@ -1575,16 +1573,31 @@ static enum phy_state_work _phy_state_machine(struct phy_device *phydev)
 	phy_process_state_change(phydev, old_state);
 
 	/* Only re-schedule a PHY state machine change if we are polling the
-	 * PHY, if PHY_MAC_INTERRUPT is set, then we will be moving
-	 * between states from phy_mac_interrupt().
+	 * PHY. If PHY_MAC_INTERRUPT is set or get_next_update_time() returns
+	 * PHY_STATE_IRQ, then we rely on interrupts for state changes.
 	 *
 	 * In state PHY_HALTED the PHY gets suspended, so rescheduling the
 	 * state machine would be pointless and possibly error prone when
 	 * called from phy_disconnect() synchronously.
 	 */
-	if (phy_polling_mode(phydev) && phy_is_started(phydev))
-		phy_queue_state_machine(phydev,
-					phy_get_next_update_time(phydev));
+	if (phy_polling_mode(phydev) && phy_is_started(phydev)) {
+		unsigned int next_time = phy_get_next_update_time(phydev);
+
+		if (next_time == PHY_STATE_IRQ) {
+			/* A driver requesting IRQ mode while also needing
+			 * polling for stats has a conflicting configuration.
+			 * Warn about this buggy driver and fall back to
+			 * polling to ensure stats are updated.
+			 */
+			if (phydev->drv->update_stats) {
+				WARN_ONCE("phy: %s: driver requested IRQ mode but needs polling for stats\n",
+					  phydev_name(phydev));
+				phy_queue_state_machine(phydev, PHY_STATE_TIME);
+			}
+		} else {
+			phy_queue_state_machine(phydev, next_time);
+		}
+	}
 
 	return state_work;
 }
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 2688c0435b9b..673477700416 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -66,6 +66,11 @@ extern const int phy_basic_ports_array[3];
 #define PHY_ALWAYS_CALL_SUSPEND	0x00000008
 #define MDIO_DEVICE_IS_PHY	0x80000000
 
+/* Default polling interval */
+#define PHY_STATE_TIME		HZ
+/* disable polling, rely on IRQs */
+#define PHY_STATE_IRQ		UINT_MAX
+
 /**
  * enum phy_interface_t - Interface Mode definitions
  *
@@ -1261,7 +1266,15 @@ struct phy_driver {
 	 * dynamically adjust polling intervals based on link state or other
 	 * conditions.
 	 *
-	 * Returns the time in jiffies until the next update event.
+	 * Returning PHY_STATE_IRQ disables polling for link state changes,
+	 * indicating that the driver relies solely on IRQs for this purpose.
+	 * Note that polling may continue at a default rate if needed for
+	 * other callbacks like update_stats(). Requesting IRQ mode while
+	 * implementing update_stats() is considered a driver bug and will
+	 * trigger a kernel warning.
+	 *
+	 * Returns the time in jiffies until the next update event, or
+	 * PHY_STATE_IRQ to disable polling.
 	 */
 	unsigned int (*get_next_update_time)(struct phy_device *dev);
 };
-- 
2.39.5


