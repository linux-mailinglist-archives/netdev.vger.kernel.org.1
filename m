Return-Path: <netdev+bounces-20283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD0275EF14
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B0761C20AA6
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660506FD2;
	Mon, 24 Jul 2023 09:26:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4AE6FD1
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:26:15 +0000 (UTC)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15310121
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:26:12 -0700 (PDT)
X-QQ-mid: bizesmtp83t1690190766t0gssa93
Received: from localhost.localdomain ( [183.128.134.159])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 24 Jul 2023 17:26:05 +0800 (CST)
X-QQ-SSF: 01400000000000N0Z000000A0000000
X-QQ-FEAT: CR3LFp2JE4kd1ybrnLj6GfQjTY3QjQVqUVGuHUI0u91KMDVc/8IVhT+vylt6k
	t7t7q4z74CdWclyZLGN3YkV+qLKVrtw7nzVOshmQunpaEZgmEWjN5IHONT/F02e6ytGMYua
	EoPl3XaKn07nNZn4wXk0286siUFMvz3xafST5OwA4APEkifoHGKLZ9v5gXfxpAY5eeL8gW5
	WT79YC6vh86GcCvx8vh3h5zgjiA5dQVDNmIKsrkPVQWk1JC4XhomKHAwDHtjkoJApCL9e3m
	+KhQMfXo1NMrIJ5/YlPZaLaPYMn3IbuKcXS0aBTz3fp8Ial40WMNrOUIhuJw1WC6Eu5oZJc
	5UW69e9X0jIIR+LWLaTUmyEnBSusN3KJz/+aYjXvd4mO5NujGR/3tZnQSBrqLa9bz42RsYn
	65PVdrBcnnKtghSm0VLwJw==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 11289264760922880588
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next 2/2] net: phy: add keep_data_connection to struct phydev
Date: Mon, 24 Jul 2023 17:24:59 +0800
Message-ID: <20207E0578DCE44C+20230724092544.73531-3-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724092544.73531-1-mengyuanlou@net-swift.com>
References: <20230724092544.73531-1-mengyuanlou@net-swift.com>
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

Add flag keep_data_connection to struct phydev indicating whether
phy need to keep data connection.
Phy_suspend() will use it to decide whether PHY can be suspended
or not.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/phy/phy_device.c | 6 ++++--
 include/linux/phy.h          | 3 +++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 0c2014accba7..4fe26660458e 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1860,8 +1860,10 @@ int phy_suspend(struct phy_device *phydev)
 
 	phy_ethtool_get_wol(phydev, &wol);
 	phydev->wol_enabled = wol.wolopts || (netdev && netdev->wol_enabled);
-	/* If the device has WOL enabled, we cannot suspend the PHY */
-	if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
+	phydev->keep_data_connection = phydev->wol_enabled ||
+				       (netdev && netdev->ncsi_enabled);
+	/* We cannot suspend the PHY, when phy and mac need to receive packets. */
+	if (phydev->keep_data_connection && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
 		return -EBUSY;
 
 	if (!phydrv || !phydrv->suspend)
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 11c1e91563d4..bda646e7cc23 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -554,6 +554,8 @@ struct macsec_ops;
  * @mac_managed_pm: Set true if MAC driver takes of suspending/resuming PHY
  * @wol_enabled: Set to true if the PHY or the attached MAC have Wake-on-LAN
  * 		 enabled.
+ * @keep_data_connection: Set to true if the PHY or the attached MAC need
+ *                        physical connection to receive packets.
  * @state: State of the PHY for management purposes
  * @dev_flags: Device-specific flags used by the PHY driver.
  *
@@ -651,6 +653,7 @@ struct phy_device {
 	unsigned is_on_sfp_module:1;
 	unsigned mac_managed_pm:1;
 	unsigned wol_enabled:1;
+	unsigned keep_data_connection:1;
 
 	unsigned autoneg:1;
 	/* The most recently read link state */
-- 
2.41.0


