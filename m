Return-Path: <netdev+bounces-33909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C270D7A098B
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E537282211
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E257926290;
	Thu, 14 Sep 2023 15:36:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66F210A1E
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:36:02 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268C1DD
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 08:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+Q5xU7a1lkRBYmSj89LoPX87ow41lpqP1TCCTG6cSkA=; b=jKse70RnCUkvPBEqt3W0SsM8ey
	jPU2nQYFFMDbwHGSz9zU2uvG3yoEtzQhmWV4LwxPDvQ+bmpnje6dl2L+N20tOSjtcAHy6Fm0zDLIQ
	SoP4ddaFP7OX3ndu5PT9xejVDOjkY0ESJ3E3XE1av7c4xi8Ot02OI1c7x4jUc3/wE4hJLvcyRB/4H
	05rIccXi/gDA9JAwMsDfT2XeMv3WHeH7KBEDB4VXiOKLrtBBxYGJOMW63RkWwdjXZO+gJiyEl31Ix
	EMwWsQvB0c3LBQPrsbg+KXhcGMRAVtpjvnXihh4SOTcCYG8lmWEc15LR+Lt3AXrCXZUHRet5ZqAMc
	AcO7TFxQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46326 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qgoNj-0004Wu-1f;
	Thu, 14 Sep 2023 16:35:51 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qgoNk-007a4U-8r; Thu, 14 Sep 2023 16:35:52 +0100
In-Reply-To: <ZQMn+Wkvod10vdLd@shell.armlinux.org.uk>
References: <ZQMn+Wkvod10vdLd@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	 Heiner Kallweit <hkallweit1@gmail.com>
Cc: chenhao418@huawei.com,
	 "David S. Miller" <davem@davemloft.net>,
	 Eric Dumazet <edumazet@google.com>,
	 Jakub Kicinski <kuba@kernel.org>,
	 Jijie Shao <shaojijie@huawei.com>,
	 lanhao@huawei.com,
	 liuyonglong@huawei.com,
	 netdev@vger.kernel.org,
	 Paolo Abeni <pabeni@redhat.com>,
	 shenjian15@huawei.com,
	 wangjie125@huawei.com,
	 wangpeiyang1@huawei.com
Subject: [PATCH net-next 5/7] net: phy: move phy_state_machine()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qgoNk-007a4U-8r@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 14 Sep 2023 16:35:52 +0100

Move phy_state_machine() before phy_stop() to avoid subsequent patches
introducing forward references.

Tested-by: Jijie Shao <shaojijie@huawei.com>
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


