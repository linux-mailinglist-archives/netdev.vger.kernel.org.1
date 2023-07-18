Return-Path: <netdev+bounces-18453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA4A7571B6
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 04:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444BA28143C
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 02:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD1315BE;
	Tue, 18 Jul 2023 02:21:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2498A15A6
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 02:21:21 +0000 (UTC)
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0FB11C
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 19:21:17 -0700 (PDT)
X-QQ-mid: bizesmtp89t1689646868t4x7xycp
Received: from localhost.localdomain ( [122.235.243.13])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Jul 2023 10:20:59 +0800 (CST)
X-QQ-SSF: 01400000000000N0Z000000A0000000
X-QQ-FEAT: 3M0okmaRx3jtFCnvEZl/CDCJtd4E3hmyqE5gdjBk+p40lcfpC0yizCnkSJSUg
	35QtlYYvB1RfpDoK4wSZvGLKfiuJ6iBAQ0DfjCH+nfCIQaZlRLzbQzu0I0QJ0Eic0nUKJE4
	/mhJW22ZXgBD71Xs9A8s3J4caxhE8Gzj+Jxk3damtRSXjfYWXAv996nOfgaX42pEtnuDl8O
	Oxcr5T3Ut6Txb21NYuHwtIYO/gowUneiD2/HjgVF/c3rk3/cIHBw+2Z5HKDWmDcsqDAm49W
	L/5/2YsZ6PFG2DjehakFukfcgdAMZXQ5TztsGr8IjufY58Xv6ufeyUlbOFNcnBZWMYAb43Y
	EeQn+krvTdBCCxCdWFe/MCSHOpCpxdw25jWilYbFBPMQKV/YF5Wp23hs/tWyQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 10484750702938703334
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v4] net: core: add member ncsi_enabled to net_device
Date: Tue, 18 Jul 2023 10:20:57 +0800
Message-ID: <E807CF57548EE44C+20230718022057.30806-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrgz:qybglogicsvrgz6a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add flag ncsi_enabled to struct net_device indicating whether
NCSI is enabled. Phy_suspend() will use it to decide whether PHY
can be suspended or not.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/phy/phy_device.c | 4 +++-
 include/linux/netdevice.h    | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 2cad9cc3f6b8..6587b35071e9 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1859,7 +1859,9 @@ int phy_suspend(struct phy_device *phydev)
 		return 0;
 
 	phy_ethtool_get_wol(phydev, &wol);
-	phydev->wol_enabled = wol.wolopts || (netdev && netdev->wol_enabled);
+	phydev->wol_enabled = wol.wolopts ||
+			      (netdev && netdev->wol_enabled) ||
+			      (netdev && netdev->ncsi_enabled);
 	/* If the device has WOL enabled, we cannot suspend the PHY */
 	if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
 		return -EBUSY;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index acf706d49c2b..5dfccfe10177 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2024,6 +2024,8 @@ enum netdev_ml_priv_type {
  *
  *	@wol_enabled:	Wake-on-LAN is enabled
  *
+ *	@ncsi_enabled:	NCSI is enabled
+ *
  *	@threaded:	napi threaded mode is enabled
  *
  *	@net_notifier_list:	List of per-net netdev notifier block
@@ -2393,6 +2395,7 @@ struct net_device {
 	struct lock_class_key	*qdisc_tx_busylock;
 	bool			proto_down;
 	unsigned		wol_enabled:1;
+	unsigned		ncsi_enabled:1;
 	unsigned		threaded:1;
 
 	struct list_head	net_notifier_list;
-- 
2.41.0


