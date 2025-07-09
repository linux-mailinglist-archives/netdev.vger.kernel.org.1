Return-Path: <netdev+bounces-205376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 838CBAFE63D
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 12:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6D81895168
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BC52C15A6;
	Wed,  9 Jul 2025 10:42:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC56328FAB9
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 10:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057757; cv=none; b=XViA+ckK8ivjIoXUqwzW1bQFRYpicrMrfMeWkhE33V0d/5cQ6vuSFluzkmhy7JO/1Gcv4tMoqflCRcGDWrMNzWyrBk5CMEMq65yrpOqxv/XigEtOGSpb1WqktZk7Y9KsqmFhihpCsNq0fJ2vul4zuX/3s4CmOAt3VYFI4Kl9PD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057757; c=relaxed/simple;
	bh=KBBCA4ST0AIfZMPfEBu51s+rw1J0kOK14uQSN909J8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MPYjx/Q55mPvk0M7jVQ/BZMZMmwPLxNj1YqT62g3euU6j0x6k9mSQ4MJXaDweWmy7ACfymt2YMmlFw1CWS93XMvgnVqk145KML7R+OT/DAOP/G4tjNM0rGVm87mj+fwdT7aXmcEVHTBSlXbxag4s5+6wggcL3hiw7vTdGG1Io/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uZSFh-0004ms-8r; Wed, 09 Jul 2025 12:42:13 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uZSFf-007ZJl-2d;
	Wed, 09 Jul 2025 12:42:11 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uZSFf-00FyRn-2M;
	Wed, 09 Jul 2025 12:42:11 +0200
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
Subject: [PATCH net v2 3/3] net: phy: smsc: recover missed link-up IRQs on LAN8700 with adaptive polling
Date: Wed,  9 Jul 2025 12:42:10 +0200
Message-Id: <20250709104210.3807203-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250709104210.3807203-1-o.rempel@pengutronix.de>
References: <20250709104210.3807203-1-o.rempel@pengutronix.de>
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

Fix unreliable link detection on the LAN8700 PHY (integrated in LAN9512
and related USB adapters) when configured for 10 Mbit/s half- or
full-duplex with autonegotiation disabled, and connected to a link
partner that still advertises autonegotiation.

In this scenario, the PHY may emit several link-down interrupts during
negotiation but fail to raise a final link-up interrupt. As a result,
phylib never observes the transition and the kernel keeps the network
interface down, even though the link is actually up.

To handle this, add a get_next_update_time() callback that performs 1 Hz
polling for up to 30 seconds after the last interrupt, but only while
the PHY is in this problematic configuration and the link is still down.
This ensures link-up detection without unnecessary long delays or
full-time polling.

After 30 seconds with no further interrupt, the driver switches back to
IRQ-only mode. In all other configurations, IRQ-only mode is used
immediately.

This patch depends on:
- commit 8bf47e4d7b87 ("net: phy: Add support for driver-specific next
  update time")
- a prior patch in this series:
  net: phy: enable polling when driver implements get_next_update_time
  net: phy: allow drivers to disable polling via get_next_update_time()

Fixes: 1ce8b37241ed ("usbnet: smsc95xx: Forward PHY interrupts to PHY driver to avoid polling")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Lukas Wunner <lukas@wunner.de>
---
changes v2:
- Switch to hybrid approach: 1 Hz polling for 30 seconds after last IRQ
  instead of relaxed 30s polling while link is up
- Only enable polling in problematic 10M autoneg-off mode while link is down
- Return PHY_STATE_IRQ in all other configurations
- Updated commit message and comments to reflect new logic
---
 drivers/net/phy/smsc.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index b6489da5cfcd..88eb15700dbd 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -39,6 +39,9 @@
 /* interval between phylib state machine runs in ms */
 #define PHY_STATE_MACH_MS		1000
 
+/* max retry window for missed link-up */
+#define SMSC_IRQ_MAX_POLLING_TIME	secs_to_jiffies(30)
+
 struct smsc_hw_stat {
 	const char *string;
 	u8 reg;
@@ -54,6 +57,7 @@ struct smsc_phy_priv {
 	unsigned int edpd_mode_set_by_user:1;
 	unsigned int edpd_max_wait_ms;
 	bool wol_arp;
+	unsigned long last_irq;
 };
 
 static int smsc_phy_ack_interrupt(struct phy_device *phydev)
@@ -100,6 +104,7 @@ static int smsc_phy_config_edpd(struct phy_device *phydev)
 
 irqreturn_t smsc_phy_handle_interrupt(struct phy_device *phydev)
 {
+	struct smsc_phy_priv *priv = phydev->priv;
 	int irq_status;
 
 	irq_status = phy_read(phydev, MII_LAN83C185_ISF);
@@ -113,6 +118,8 @@ irqreturn_t smsc_phy_handle_interrupt(struct phy_device *phydev)
 	if (!(irq_status & MII_LAN83C185_ISF_INT_PHYLIB_EVENTS))
 		return IRQ_NONE;
 
+	WRITE_ONCE(priv->last_irq, jiffies);
+
 	phy_trigger_machine(phydev);
 
 	return IRQ_HANDLED;
@@ -684,6 +691,38 @@ int smsc_phy_probe(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(smsc_phy_probe);
 
+static unsigned int smsc_phy_get_next_update(struct phy_device *phydev)
+{
+	struct smsc_phy_priv *priv = phydev->priv;
+
+	/* If interrupts are disabled, fall back to default polling */
+	if (phydev->irq == PHY_POLL)
+		return PHY_STATE_TIME;
+
+	/*
+	 * LAN8700 may miss the final link-up IRQ when forced to 10 Mbps
+	 * (half/full duplex) and connected to an autonegotiating partner.
+	 *
+	 * To recover, poll at 1 Hz for up to 30 seconds after the last
+	 * interrupt - but only in this specific configuration and while
+	 * the link is still down.
+	 *
+	 * This keeps link-up latency low in common cases while reliably
+	 * detecting rare transitions. Outside of this mode, rely on IRQs.
+	 */
+	if (phydev->autoneg == AUTONEG_DISABLE && phydev->speed == SPEED_10 &&
+	    !phydev->link) {
+		unsigned long last_irq = READ_ONCE(priv->last_irq);
+
+		if (!time_is_before_jiffies(last_irq +
+					    SMSC_IRQ_MAX_POLLING_TIME))
+			return PHY_STATE_TIME;
+	}
+
+	/* switching to IRQ without polling */
+	return PHY_STATE_IRQ;
+}
+
 static struct phy_driver smsc_phy_driver[] = {
 {
 	.phy_id		= 0x0007c0a0, /* OUI=0x00800f, Model#=0x0a */
@@ -749,6 +788,7 @@ static struct phy_driver smsc_phy_driver[] = {
 	/* IRQ related */
 	.config_intr	= smsc_phy_config_intr,
 	.handle_interrupt = smsc_phy_handle_interrupt,
+	.get_next_update_time = smsc_phy_get_next_update,
 
 	/* Statistics */
 	.get_sset_count = smsc_get_sset_count,
-- 
2.39.5


