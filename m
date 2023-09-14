Return-Path: <netdev+bounces-33910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F877A0990
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78959281C01
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E702B2628F;
	Thu, 14 Sep 2023 15:36:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A6710A1E
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:36:09 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7061099
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 08:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=74quIK+EB9/R45DrrLyqAv877SOVaIWYdEk2D90w5q8=; b=rWf9V5AqGsDSDfC6UTxnAHWX9Z
	dwUDK/u9MIQuVcHxLxFClXCDu480OihH7OxhUL6u6H2amf51nMZ77Td7gDGl0FFCLorRcRIF9jZ7t
	XRXD9eUfUS+gclb7VIw9DfStYU/YRMjaTAmRfPRvvoE/JTZddSLX8GWaShjZuJL3Luvk3rk8s2qTk
	HpeH94HZJDRw51qqLeL0wdPcN9Zn2g+X/ss4NnVCtznn33ZJNnSOwX18Xfn/Qy/QQvrA4m4jGnWDY
	JEIpqDlwVXdyq0O9/AdpvGqdBdEGde/4R0H2SMY30NUB4T+hbLP3xasM6YQNOhjzdwqUJOm2fGP69
	L/p2M5Bw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47380 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qgoNo-0004XC-25;
	Thu, 14 Sep 2023 16:35:56 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qgoNp-007a4a-Dt; Thu, 14 Sep 2023 16:35:57 +0100
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
Subject: [PATCH net-next 6/7] net: phy: split locked and unlocked section of
 phy_state_machine()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qgoNp-007a4a-Dt@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 14 Sep 2023 16:35:57 +0100

Split out the locked and unlocked sections of phy_state_machine() into
two separate functions which can be called inside the phydev lock and
outside the phydev lock as appropriate, thus allowing us to combine
the locked regions in the caller of phy_state_machine() with the
locked region inside phy_state_machine().

This avoids unnecessarily dropping the phydev lock which may allow
races to occur.

Tested-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy.c | 68 ++++++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 26 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 20e23fa9cf96..d78c2cc003ce 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1353,33 +1353,27 @@ void phy_free_interrupt(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(phy_free_interrupt);
 
-/**
- * phy_state_machine - Handle the state machine
- * @work: work_struct that describes the work to be done
- */
-void phy_state_machine(struct work_struct *work)
+enum phy_state_work {
+	PHY_STATE_WORK_NONE,
+	PHY_STATE_WORK_ANEG,
+	PHY_STATE_WORK_SUSPEND,
+};
+
+static enum phy_state_work _phy_state_machine(struct phy_device *phydev)
 {
-	struct delayed_work *dwork = to_delayed_work(work);
-	struct phy_device *phydev =
-			container_of(dwork, struct phy_device, state_queue);
+	enum phy_state_work state_work = PHY_STATE_WORK_NONE;
 	struct net_device *dev = phydev->attached_dev;
-	bool needs_aneg = false, do_suspend = false;
-	enum phy_state old_state;
+	enum phy_state old_state = phydev->state;
 	const void *func = NULL;
 	bool finished = false;
 	int err = 0;
 
-	mutex_lock(&phydev->lock);
-
-	old_state = phydev->state;
-
 	switch (phydev->state) {
 	case PHY_DOWN:
 	case PHY_READY:
 		break;
 	case PHY_UP:
-		needs_aneg = true;
-
+		state_work = PHY_STATE_WORK_ANEG;
 		break;
 	case PHY_NOLINK:
 	case PHY_RUNNING:
@@ -1391,7 +1385,7 @@ void phy_state_machine(struct work_struct *work)
 		if (err) {
 			phy_abort_cable_test(phydev);
 			netif_testing_off(dev);
-			needs_aneg = true;
+			state_work = PHY_STATE_WORK_ANEG;
 			phydev->state = PHY_UP;
 			break;
 		}
@@ -1399,7 +1393,7 @@ void phy_state_machine(struct work_struct *work)
 		if (finished) {
 			ethnl_cable_test_finished(phydev);
 			netif_testing_off(dev);
-			needs_aneg = true;
+			state_work = PHY_STATE_WORK_ANEG;
 			phydev->state = PHY_UP;
 		}
 		break;
@@ -1409,19 +1403,17 @@ void phy_state_machine(struct work_struct *work)
 			phydev->link = 0;
 			phy_link_down(phydev);
 		}
-		do_suspend = true;
+		state_work = PHY_STATE_WORK_SUSPEND;
 		break;
 	}
 
-	if (needs_aneg) {
+	if (state_work == PHY_STATE_WORK_ANEG) {
 		err = _phy_start_aneg(phydev);
 		func = &_phy_start_aneg;
 	}
 
-	if (err == -ENODEV) {
-		mutex_unlock(&phydev->lock);
-		return;
-	}
+	if (err == -ENODEV)
+		return state_work;
 
 	if (err < 0)
 		phy_error_precise(phydev, func, err);
@@ -1438,12 +1430,36 @@ void phy_state_machine(struct work_struct *work)
 	 */
 	if (phy_polling_mode(phydev) && phy_is_started(phydev))
 		phy_queue_state_machine(phydev, PHY_STATE_TIME);
-	mutex_unlock(&phydev->lock);
 
-	if (do_suspend)
+	return state_work;
+}
+
+/* unlocked part of the PHY state machine */
+static void _phy_state_machine_post_work(struct phy_device *phydev,
+					 enum phy_state_work state_work)
+{
+	if (state_work == PHY_STATE_WORK_SUSPEND)
 		phy_suspend(phydev);
 }
 
+/**
+ * phy_state_machine - Handle the state machine
+ * @work: work_struct that describes the work to be done
+ */
+void phy_state_machine(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct phy_device *phydev =
+			container_of(dwork, struct phy_device, state_queue);
+	enum phy_state_work state_work;
+
+	mutex_lock(&phydev->lock);
+	state_work = _phy_state_machine(phydev);
+	mutex_unlock(&phydev->lock);
+
+	_phy_state_machine_post_work(phydev, state_work);
+}
+
 /**
  * phy_stop - Bring down the PHY link, and stop checking the status
  * @phydev: target phy_device struct
-- 
2.30.2


