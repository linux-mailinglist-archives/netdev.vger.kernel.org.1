Return-Path: <netdev+bounces-32561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D7D798665
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 13:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FEAA1C20BC1
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 11:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1434C93;
	Fri,  8 Sep 2023 11:21:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FE15385
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 11:21:24 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C573E11B
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 04:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=X4NPzGZ2KK4jPkfZuyoDIOBWTp2DTQZ5cWAvHB5ZS5w=; b=bpYQ9GtzALse1i4Tr8jRuJnRNu
	YC9JP0lebcTutkTuhCDxDyiL3udikOf6nECJXKZZDrm3gFP+Ur1WkQPlJrJ1exAbEeIwz8utKgJKM
	5wzMKYWYwCEu/td4ZonhVVp+xivpWPuasJlBTcLe9nfS1HMuFdE/18EcEVqHVkb/xcjv+Qgi7bN4S
	PTfn3SbvRd4+EQULTRJvB+MDgztF0Oq6el+c0evtN5cP//chR+UsKHfDexO03LXNoRIYa8j1pdThz
	p0DmVaPLBuvTcxD8KGXZwV2dF9fX2yXpb6wlWa82NChfbDTNr7o0NveUr3yanXbRevSh/dmeDeP9w
	Dhzn5hlQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42098 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qeZXt-0004tF-0j;
	Fri, 08 Sep 2023 12:21:05 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qeZXt-007G4b-Pi; Fri, 08 Sep 2023 12:21:05 +0100
In-Reply-To: <ZPsDdqt1RrXB+aTO@shell.armlinux.org.uk>
References: <ZPsDdqt1RrXB+aTO@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jijie Shao <shaojijie@huawei.com>,
	 shaojijie@huawei.com,
	 shenjian15@huawei.com,
	 liuyonglong@huawei.com,
	 wangjie125@huawei.com,
	 chenhao418@huawei.com,
	 lanhao@huawei.com,
	 wangpeiyang1@huawei.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH RFC net-next 5/7] net: phy: move phy_state_machine()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qeZXt-007G4b-Pi@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 08 Sep 2023 12:21:05 +0100
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Move phy_state_machine() before phy_stop() to avoid subsequent patches
introducing forward references.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy.c | 152 +++++++++++++++++++++---------------------
 1 file changed, 76 insertions(+), 76 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 756326f38b14..20e23fa9cf96 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1353,82 +1353,6 @@ void phy_free_interrupt(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(phy_free_interrupt);
 
-/**
- * phy_stop - Bring down the PHY link, and stop checking the status
- * @phydev: target phy_device struct
- */
-void phy_stop(struct phy_device *phydev)
-{
-	struct net_device *dev = phydev->attached_dev;
-	enum phy_state old_state;
-
-	if (!phy_is_started(phydev) && phydev->state != PHY_DOWN &&
-	    phydev->state != PHY_ERROR) {
-		WARN(1, "called from state %s\n",
-		     phy_state_to_str(phydev->state));
-		return;
-	}
-
-	mutex_lock(&phydev->lock);
-	old_state = phydev->state;
-
-	if (phydev->state == PHY_CABLETEST) {
-		phy_abort_cable_test(phydev);
-		netif_testing_off(dev);
-	}
-
-	if (phydev->sfp_bus)
-		sfp_upstream_stop(phydev->sfp_bus);
-
-	phydev->state = PHY_HALTED;
-	phy_process_state_change(phydev, old_state);
-
-	mutex_unlock(&phydev->lock);
-
-	phy_state_machine(&phydev->state_queue.work);
-	phy_stop_machine(phydev);
-
-	/* Cannot call flush_scheduled_work() here as desired because
-	 * of rtnl_lock(), but PHY_HALTED shall guarantee irq handler
-	 * will not reenable interrupts.
-	 */
-}
-EXPORT_SYMBOL(phy_stop);
-
-/**
- * phy_start - start or restart a PHY device
- * @phydev: target phy_device struct
- *
- * Description: Indicates the attached device's readiness to
- *   handle PHY-related work.  Used during startup to start the
- *   PHY, and after a call to phy_stop() to resume operation.
- *   Also used to indicate the MDIO bus has cleared an error
- *   condition.
- */
-void phy_start(struct phy_device *phydev)
-{
-	mutex_lock(&phydev->lock);
-
-	if (phydev->state != PHY_READY && phydev->state != PHY_HALTED) {
-		WARN(1, "called from state %s\n",
-		     phy_state_to_str(phydev->state));
-		goto out;
-	}
-
-	if (phydev->sfp_bus)
-		sfp_upstream_start(phydev->sfp_bus);
-
-	/* if phy was suspended, bring the physical link up again */
-	__phy_resume(phydev);
-
-	phydev->state = PHY_UP;
-
-	phy_start_machine(phydev);
-out:
-	mutex_unlock(&phydev->lock);
-}
-EXPORT_SYMBOL(phy_start);
-
 /**
  * phy_state_machine - Handle the state machine
  * @work: work_struct that describes the work to be done
@@ -1520,6 +1444,82 @@ void phy_state_machine(struct work_struct *work)
 		phy_suspend(phydev);
 }
 
+/**
+ * phy_stop - Bring down the PHY link, and stop checking the status
+ * @phydev: target phy_device struct
+ */
+void phy_stop(struct phy_device *phydev)
+{
+	struct net_device *dev = phydev->attached_dev;
+	enum phy_state old_state;
+
+	if (!phy_is_started(phydev) && phydev->state != PHY_DOWN &&
+	    phydev->state != PHY_ERROR) {
+		WARN(1, "called from state %s\n",
+		     phy_state_to_str(phydev->state));
+		return;
+	}
+
+	mutex_lock(&phydev->lock);
+	old_state = phydev->state;
+
+	if (phydev->state == PHY_CABLETEST) {
+		phy_abort_cable_test(phydev);
+		netif_testing_off(dev);
+	}
+
+	if (phydev->sfp_bus)
+		sfp_upstream_stop(phydev->sfp_bus);
+
+	phydev->state = PHY_HALTED;
+	phy_process_state_change(phydev, old_state);
+
+	mutex_unlock(&phydev->lock);
+
+	phy_state_machine(&phydev->state_queue.work);
+	phy_stop_machine(phydev);
+
+	/* Cannot call flush_scheduled_work() here as desired because
+	 * of rtnl_lock(), but PHY_HALTED shall guarantee irq handler
+	 * will not reenable interrupts.
+	 */
+}
+EXPORT_SYMBOL(phy_stop);
+
+/**
+ * phy_start - start or restart a PHY device
+ * @phydev: target phy_device struct
+ *
+ * Description: Indicates the attached device's readiness to
+ *   handle PHY-related work.  Used during startup to start the
+ *   PHY, and after a call to phy_stop() to resume operation.
+ *   Also used to indicate the MDIO bus has cleared an error
+ *   condition.
+ */
+void phy_start(struct phy_device *phydev)
+{
+	mutex_lock(&phydev->lock);
+
+	if (phydev->state != PHY_READY && phydev->state != PHY_HALTED) {
+		WARN(1, "called from state %s\n",
+		     phy_state_to_str(phydev->state));
+		goto out;
+	}
+
+	if (phydev->sfp_bus)
+		sfp_upstream_start(phydev->sfp_bus);
+
+	/* if phy was suspended, bring the physical link up again */
+	__phy_resume(phydev);
+
+	phydev->state = PHY_UP;
+
+	phy_start_machine(phydev);
+out:
+	mutex_unlock(&phydev->lock);
+}
+EXPORT_SYMBOL(phy_start);
+
 /**
  * phy_mac_interrupt - MAC says the link has changed
  * @phydev: phy_device struct with changed link
-- 
2.30.2


