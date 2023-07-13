Return-Path: <netdev+bounces-17466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5087D751BE6
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 10:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379C51C212C8
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 08:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7B08835;
	Thu, 13 Jul 2023 08:42:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AEA8485
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 08:42:11 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7952713
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 01:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=12h8uhORD473D0pUo6fmFgfLpdDVhYklbbO0nliJ8Hs=; b=eVpB/J9Q+r0Y/7Sl6HKN3v3kWf
	R2evL3/59a41jua9+qBiQX6no1JH61dNz6gRoh2doz16NQGUeUqKlQb6O03qfGaI1cZySUMkR4C7A
	lcqDT7/dRCBMJAjX+qOXTXyYDlUbnWEjtnJc7fnyDFM0uaqn6/KiWAbDlvWzm9j/Tc4ZcRn0RgS+Y
	psRY2NgXMILUNQ4bDFGWXdHOWloWvH3//DSOBAZVLKHqgNqGCFky77nHZY1jnpo+pbywMTOS3/LqB
	DQBM6GxL81iE9qlqymp3BerjE+MeIBsV8ZmRYCdUc7vro914icRuh7rdyVFXoBLIhJ2QCgcdY+nuJ
	Z7Jq7jmA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57576 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qJrtn-000682-2I;
	Thu, 13 Jul 2023 09:42:07 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qJrtn-00GkjG-Gj; Thu, 13 Jul 2023 09:42:07 +0100
In-Reply-To: <ZK+4tOD4EpFzNM9x@shell.armlinux.org.uk>
References: <ZK+4tOD4EpFzNM9x@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 01/11] net: phylink: add pcs_enable()/pcs_disable()
 methods
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qJrtn-00GkjG-Gj@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 13 Jul 2023 09:42:07 +0100
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add phylink PCS enable/disable callbacks that will allow us to place
IEEE 802.3 register compliant PCS in power-down mode while not being
used.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 48 +++++++++++++++++++++++++++++++--------
 include/linux/phylink.h   | 16 +++++++++++++
 2 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index d0aaa5cad853..748c62efceb8 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -34,6 +34,10 @@ enum {
 	PHYLINK_DISABLE_STOPPED,
 	PHYLINK_DISABLE_LINK,
 	PHYLINK_DISABLE_MAC_WOL,
+
+	PCS_STATE_DOWN = 0,
+	PCS_STATE_STARTING,
+	PCS_STATE_STARTED,
 };
 
 /**
@@ -72,6 +76,7 @@ struct phylink {
 	struct phylink_link_state phy_state;
 	struct work_struct resolve;
 	unsigned int pcs_neg_mode;
+	unsigned int pcs_state;
 
 	bool mac_link_dropped;
 	bool using_mac_select_pcs;
@@ -993,6 +998,22 @@ static void phylink_resolve_an_pause(struct phylink_link_state *state)
 	}
 }
 
+static void phylink_pcs_disable(struct phylink_pcs *pcs)
+{
+	if (pcs && pcs->ops->pcs_disable)
+		pcs->ops->pcs_disable(pcs);
+}
+
+static int phylink_pcs_enable(struct phylink_pcs *pcs)
+{
+	int err = 0;
+
+	if (pcs && pcs->ops->pcs_enable)
+		err = pcs->ops->pcs_enable(pcs);
+
+	return err;
+}
+
 static int phylink_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 			      const struct phylink_link_state *state,
 			      bool permit_pause_to_mac)
@@ -1095,11 +1116,17 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 	/* If we have a new PCS, switch to the new PCS after preparing the MAC
 	 * for the change.
 	 */
-	if (pcs_changed)
+	if (pcs_changed) {
+		phylink_pcs_disable(pl->pcs);
+
 		pl->pcs = pcs;
+	}
 
 	phylink_mac_config(pl, state);
 
+	if (pl->pcs_state == PCS_STATE_STARTING || pcs_changed)
+		phylink_pcs_enable(pl->pcs);
+
 	neg_mode = pl->cur_link_an_mode;
 	if (pl->pcs && pl->pcs->neg_mode)
 		neg_mode = pl->pcs_neg_mode;
@@ -1586,6 +1613,7 @@ struct phylink *phylink_create(struct phylink_config *config,
 	pl->link_config.pause = MLO_PAUSE_AN;
 	pl->link_config.speed = SPEED_UNKNOWN;
 	pl->link_config.duplex = DUPLEX_UNKNOWN;
+	pl->pcs_state = PCS_STATE_DOWN;
 	pl->mac_ops = mac_ops;
 	__set_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state);
 	timer_setup(&pl->link_poll, phylink_fixed_poll, 0);
@@ -1987,6 +2015,8 @@ void phylink_start(struct phylink *pl)
 	if (pl->netdev)
 		netif_carrier_off(pl->netdev);
 
+	pl->pcs_state = PCS_STATE_STARTING;
+
 	/* Apply the link configuration to the MAC when starting. This allows
 	 * a fixed-link to start with the correct parameters, and also
 	 * ensures that we set the appropriate advertisement for Serdes links.
@@ -1997,6 +2027,8 @@ void phylink_start(struct phylink *pl)
 	 */
 	phylink_mac_initial_config(pl, true);
 
+	pl->pcs_state = PCS_STATE_STARTED;
+
 	phylink_enable_and_run_resolve(pl, PHYLINK_DISABLE_STOPPED);
 
 	if (pl->cfg_link_an_mode == MLO_AN_FIXED && pl->link_gpio) {
@@ -2015,15 +2047,9 @@ void phylink_start(struct phylink *pl)
 			poll = true;
 	}
 
-	switch (pl->cfg_link_an_mode) {
-	case MLO_AN_FIXED:
+	if (pl->cfg_link_an_mode == MLO_AN_FIXED)
 		poll |= pl->config->poll_fixed_state;
-		break;
-	case MLO_AN_INBAND:
-		if (pl->pcs)
-			poll |= pl->pcs->poll;
-		break;
-	}
+
 	if (poll)
 		mod_timer(&pl->link_poll, jiffies + HZ);
 	if (pl->phydev)
@@ -2060,6 +2086,10 @@ void phylink_stop(struct phylink *pl)
 	}
 
 	phylink_run_resolve_and_disable(pl, PHYLINK_DISABLE_STOPPED);
+
+	pl->pcs_state = PCS_STATE_DOWN;
+
+	phylink_pcs_disable(pl->pcs);
 }
 EXPORT_SYMBOL_GPL(phylink_stop);
 
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 1817940a3418..8e2fdd48a935 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -535,6 +535,8 @@ struct phylink_pcs {
 /**
  * struct phylink_pcs_ops - MAC PCS operations structure.
  * @pcs_validate: validate the link configuration.
+ * @pcs_enable: enable the PCS.
+ * @pcs_disable: disable the PCS.
  * @pcs_get_state: read the current MAC PCS link state from the hardware.
  * @pcs_config: configure the MAC PCS for the selected mode and state.
  * @pcs_an_restart: restart 802.3z BaseX autonegotiation.
@@ -544,6 +546,8 @@ struct phylink_pcs {
 struct phylink_pcs_ops {
 	int (*pcs_validate)(struct phylink_pcs *pcs, unsigned long *supported,
 			    const struct phylink_link_state *state);
+	int (*pcs_enable)(struct phylink_pcs *pcs);
+	void (*pcs_disable)(struct phylink_pcs *pcs);
 	void (*pcs_get_state)(struct phylink_pcs *pcs,
 			      struct phylink_link_state *state);
 	int (*pcs_config)(struct phylink_pcs *pcs, unsigned int neg_mode,
@@ -573,6 +577,18 @@ struct phylink_pcs_ops {
 int pcs_validate(struct phylink_pcs *pcs, unsigned long *supported,
 		 const struct phylink_link_state *state);
 
+/**
+ * pcs_enable() - enable the PCS.
+ * @pcs: a pointer to a &struct phylink_pcs.
+ */
+int pcs_enable(struct phylink_pcs *pcs);
+
+/**
+ * pcs_disable() - disable the PCS.
+ * @pcs: a pointer to a &struct phylink_pcs.
+ */
+void pcs_disable(struct phylink_pcs *pcs);
+
 /**
  * pcs_get_state() - Read the current inband link state from the hardware
  * @pcs: a pointer to a &struct phylink_pcs.
-- 
2.30.2


