Return-Path: <netdev+bounces-32563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5CF798667
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 13:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C4F2819DF
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 11:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44373567F;
	Fri,  8 Sep 2023 11:21:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3998C4C6D
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 11:21:40 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2268811B
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 04:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1p+b8iwveyuMaSQhj6+T7zPMj4vLFnwbJOcwCKGKkSo=; b=Egt3JcP/Q9QjOrgDf9BZHITno1
	jL9xam1KGxWsqc7iOoGfBZGiqC+c4KL4R8NBqv3z5VphIoQyDMQFYTiTPvl97TsBqmGca3llbf7Kq
	yHXFaaCeNNIAkFaZ0FjzyuyOLCTWYT3UxdpVKNgmJv8/FcMpCXzmEoGa4CZ7xAXbo4/wPW+x1vMEp
	50Y5YywtE4+PkkSbpcsYmJB0AfJleDz97j9mU8Tohz7XOGljukZuPI1eFDJUxLysvCKVYZISRgVCe
	T/W3jngZ5nUqjjIK/Ip8BRWTZ8m8kLHzmKYKO15nEDN20Nl/5wcCHverXnhij3m5NIlvxTB7frXCb
	Oyrf+zHA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42100 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qeZXy-0004ta-17;
	Fri, 08 Sep 2023 12:21:10 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qeZXy-007G4h-Uj; Fri, 08 Sep 2023 12:21:10 +0100
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
Subject: [PATCH RFC net-next 6/7] net: phy: split locked and unlocked section
 of phy_state_machine()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qeZXy-007G4h-Uj@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 08 Sep 2023 12:21:10 +0100
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Split out the locked and unlocked sections of phy_state_machine() into
two separate functions which can be called inside the phydev lock and
outside the phydev lock as appropriate, thus allowing us to combine
the locked regions in the caller of phy_state_machine() with the
locked region inside phy_state_machine().

This avoids unnecessarily dropping the phydev lock which may allow
races to occur.

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


