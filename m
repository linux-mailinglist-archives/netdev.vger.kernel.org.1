Return-Path: <netdev+bounces-18454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1EE7571BB
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 04:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A66281403
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 02:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C0815BE;
	Tue, 18 Jul 2023 02:23:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED59E15A6
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 02:23:40 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC475EC
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 19:23:38 -0700 (PDT)
X-QQ-mid: bizesmtp80t1689647011thb9acji
Received: from localhost.localdomain ( [122.235.243.13])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Jul 2023 10:23:23 +0800 (CST)
X-QQ-SSF: 01400000000000N0Z000000A0000000
X-QQ-FEAT: 3M0okmaRx3gIrtly7mTynavFVV10FDJYPLJvgqQYfoyuAs550uYkZaJn9/y2m
	krxmeyt5n0NFX4B3xxLm0i78hFDv6F3/A21iyXLOFDpnd5V5+cOCgkEmN7HbBgRwg+oEBxS
	0VBM++3Dj0pGmhGBQz4lXLTQjgtkq/s661fDOhBZEmnz8uULu9t8aaDQtGJ6iUGiiCsHLu+
	795DlzryPsOYrT21OiKwmWIq5YbYYp+T9lj44Vp0XcpSCp/PcbfwPsM0DxESAIDobZEsUj0
	uvyEKfuKIomHAM6hFj2b6gUrTgI5IlLc1sv4bI80F/DuJgyWuzy4CCUv/zj71hu6cpvMYPH
	3ROagYFphkT83iql7E0JHBYKujfP3jRCnbkgYZVxAGVzs1QUVJ4dvVnDpS9OcvsjnqJ0pyt
	z1LK1dnpBfY=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 10636233484625894450
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next] net: core: add member ncsi_enabled to net_device
Date: Tue, 18 Jul 2023 10:23:21 +0800
Message-ID: <3CF66F8947B520BF+20230718022321.30911-1-mengyuanlou@net-swift.com>
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
index 0c2014accba7..83e988043492 100644
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
index b828c7a75be2..828fa2206464 100644
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


