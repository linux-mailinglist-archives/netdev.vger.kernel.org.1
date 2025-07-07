Return-Path: <netdev+bounces-204612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A787AFB771
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 17:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE66421B79
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE25A1F4C9F;
	Mon,  7 Jul 2025 15:32:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74E11F3BB5
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751902371; cv=none; b=k2PjpR/xTDmXOMBFzi0kFS+cK7IbAS7WcJ7s3zB5NZlpUxn+Ww7C31y2zwxxeo9AlwpMey2S3Okkpqe/YKLqPzC9H7oFWQPj+7d9QzscYkEzOfvXPBDbjoMPT8fwERa9JgoJT+vHVsQfGWYP+mbSNWCp0AjqjeVILR5GXZr8hpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751902371; c=relaxed/simple;
	bh=IibsQJ2N3+FhROMlUInFcPRwAna8EUl6stk82qwvWN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r1PtalNZzxg5JZ9JTNkCC9W4Nx8W3h+lUcpvV3HjtCiSZHDyARhulbjAFkKQX9GMvlT1xMqS5ZIfdVeAL6JgCQoOlxICB8rpeLW3xQbFL/PEoPVljuE61ksNX9UAIj3Mjze3bgKz5aGtwqR+K3Rb40UX5Z/EvreJD3c6ac/liv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uYnpb-0007aK-Qn; Mon, 07 Jul 2025 17:32:35 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uYnpa-007GvW-0Z;
	Mon, 07 Jul 2025 17:32:34 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uYnpa-004YFk-0E;
	Mon, 07 Jul 2025 17:32:34 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Lukas Wunner <lukas@wunner.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	Andre Edich <andre.edich@microchip.com>
Subject: [PATCH net v1 2/2] net: phy: smsc: add adaptive polling to recover missed link-up on LAN8700
Date: Mon,  7 Jul 2025 17:32:32 +0200
Message-Id: <20250707153232.1082819-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250707153232.1082819-1-o.rempel@pengutronix.de>
References: <20250707153232.1082819-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Fixe unreliable link detection on LAN8700 configured for 10 Mbit / half-
or full-duplex against an autonegotiating partner and similar scenarios.

The LAN8700 PHY (build in to LAN9512 and similar adapters) can fail to
report a link-up event when it is forced to a fixed speed/duplex and the
link partner still advertises autonegotiation. During link establishment
the PHY raises several interrupts while the link is not yet up; once the
link finally comes up no further interrupt is generated, so phylib never
observes the transition and the kernel keeps the interface down even
though ethtool shows the link as up.

Mitigate this by combining interrupts with adaptive polling:

- When the driver is running in pure polling mode it continues to poll
  once per second (unchanged).
- With an IRQ present we now
  - poll every 30 s while the link is up (low overhead);
  - switch to a 1 s poll for up to 30 s after the last IRQ and while the
    link is down, ensuring we catch the final silent link-up.

This patch depends on:
- commit 8bf47e4d7b87 ("net: phy: Add support for driver-specific next
  update time")
- part of this patch set ("net: phy: enable polling when driver
  implements get_next_update_time")

Fixes: 1ce8b37241ed ("usbnet: smsc95xx: Forward PHY interrupts to PHY driver to avoid polling")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Lukas Wunner <lukas@wunner.de>
---
 drivers/net/phy/smsc.c | 43 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index b6489da5cfcd..118aee834094 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -39,6 +39,17 @@
 /* interval between phylib state machine runs in ms */
 #define PHY_STATE_MACH_MS		1000
 
+/* Poll every 1 s when we have no IRQ line.
+ * Matches the default phylib state-machine cadence.
+ */
+#define SMSC_NOIRQ_POLLING_INTERVAL	secs_to_jiffies(1)
+/* When IRQs are present and the link is already up,
+ * fall back to a light 30 s poll:
+ *  – avoids needless wake-ups for power-management purposes
+ *  – still short enough to recover if the final link-up IRQ was lost
+ */
+#define SMSC_IRQ_POLLING_INTERVAL	secs_to_jiffies(30)
+
 struct smsc_hw_stat {
 	const char *string;
 	u8 reg;
@@ -54,6 +65,7 @@ struct smsc_phy_priv {
 	unsigned int edpd_mode_set_by_user:1;
 	unsigned int edpd_max_wait_ms;
 	bool wol_arp;
+	unsigned long last_irq;
 };
 
 static int smsc_phy_ack_interrupt(struct phy_device *phydev)
@@ -100,6 +112,7 @@ static int smsc_phy_config_edpd(struct phy_device *phydev)
 
 irqreturn_t smsc_phy_handle_interrupt(struct phy_device *phydev)
 {
+	struct smsc_phy_priv *priv = phydev->priv;
 	int irq_status;
 
 	irq_status = phy_read(phydev, MII_LAN83C185_ISF);
@@ -113,6 +126,8 @@ irqreturn_t smsc_phy_handle_interrupt(struct phy_device *phydev)
 	if (!(irq_status & MII_LAN83C185_ISF_INT_PHYLIB_EVENTS))
 		return IRQ_NONE;
 
+	priv->last_irq = jiffies;
+
 	phy_trigger_machine(phydev);
 
 	return IRQ_HANDLED;
@@ -684,6 +699,33 @@ int smsc_phy_probe(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(smsc_phy_probe);
 
+static unsigned int smsc_phy_get_next_update(struct phy_device *phydev)
+{
+	struct smsc_phy_priv *priv = phydev->priv;
+
+	/* If interrupts are disabled, fall back to default polling */
+	if (phydev->irq == PHY_POLL)
+		return SMSC_NOIRQ_POLLING_INTERVAL;
+
+	/* The PHY sometimes drops the *final* link-up IRQ when we run
+	 * with autoneg OFF (10 Mbps HD/FD) against an autonegotiating
+	 * partner: we see several “link down” IRQs, none for “link up”.
+	 *
+	 * Work-around philosophy:
+	 *   - If the link is already up, the hazard is past, so we
+	 *     revert to a relaxed 30 s poll to save power.
+	 *   - Otherwise we stay in a tighter polling loop for up to one
+	 *     full interval after the last IRQ in case the crucial
+	 *     link-up IRQ was lost.  Empirically 5 s is enough but we
+	 *     keep 30 s to be extra conservative.
+	 */
+	if (!priv->last_irq || phydev->link ||
+	    time_is_before_jiffies(priv->last_irq + SMSC_IRQ_POLLING_INTERVAL))
+		return SMSC_IRQ_POLLING_INTERVAL;
+
+	return SMSC_NOIRQ_POLLING_INTERVAL;
+}
+
 static struct phy_driver smsc_phy_driver[] = {
 {
 	.phy_id		= 0x0007c0a0, /* OUI=0x00800f, Model#=0x0a */
@@ -749,6 +791,7 @@ static struct phy_driver smsc_phy_driver[] = {
 	/* IRQ related */
 	.config_intr	= smsc_phy_config_intr,
 	.handle_interrupt = smsc_phy_handle_interrupt,
+	.get_next_update_time = smsc_phy_get_next_update,
 
 	/* Statistics */
 	.get_sset_count = smsc_get_sset_count,
-- 
2.39.5


