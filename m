Return-Path: <netdev+bounces-17427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C16F07518A2
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 08:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FBBB281BE8
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 06:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D185681;
	Thu, 13 Jul 2023 06:10:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A5E5679
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 06:10:52 +0000 (UTC)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA7419B9
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 23:10:49 -0700 (PDT)
X-QQ-mid: bizesmtp85t1689228566tqqh8l8x
Received: from localhost.localdomain ( [125.119.254.133])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 13 Jul 2023 14:09:13 +0800 (CST)
X-QQ-SSF: 01400000000000N0Z000000A0000000
X-QQ-FEAT: CR3LFp2JE4kqU8AOlsrhg89XoYsoXb+u0fc708T5+UuuzLwskLl9eRzgdJ7+N
	qE539EdDADfRNAIu4SOKpYBNbVYEPr41iP5s3apy/ockxxso/nxJ3DGVNU6FdXBaSF8Mh6a
	tPKxWdhmAtrimTaYtBVe2IbIG1NxKlNxkeEm4/6Kg7EqEPr3pZd/bbvQYxkcagD3DW7muuT
	0U9gFl4FsplvLOrOspxlGIiuqSGi0Qj6yDoYMBWIbe+Hck4sZjixh3BWEZnvyXr2HQwmzOm
	u6d9IxzJD/ToLd4IBZ3uwHyMAwuDwD2Ll25I8nekvcOWgQH17ErpOBAK0sIVejvD5d2EmxW
	eOdEK7dAfgpFzHzqSzM/tt+6Ezs/sryevC+dxzV8foRsN1GbZOsqy24+mszPXQMHgh4bL6E
	jl6ULDmR+OM1cOxNgP2JwQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 9664159764772589130
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v4] net: ngbe: add Wake on Lan support
Date: Thu, 13 Jul 2023 14:09:11 +0800
Message-ID: <FCC13FFE712616EA+20230713060911.33253-1-mengyuanlou@net-swift.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement ethtool_ops get_wol and set_wol.
Implement Wake-on-LAN support.

Wol requires hardware board support which use sub id
to identify.
Magic packets are checked by fw, for now just support
WAKE_MAGIC.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
v4:
- Remove wol->wolopts check in set_wol.
v3:
- Fix the logic of wol->wolopts mask return.
v2:
- Change flag wol_enbaled to wol_hw_supported in wx.
- Remove smp_mb__before_atomic() in ngbe_resume.

 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  3 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |  1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  6 +-
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  | 35 ++++++++++
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 64 +++++++++++++++++--
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |  1 +
 6 files changed, 102 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 39a9aeee7aab..ad09ab1d1209 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1501,7 +1501,7 @@ static void wx_restore_vlan(struct wx *wx)
  *
  * Configure the Rx unit of the MAC after a reset.
  **/
-static void wx_configure_rx(struct wx *wx)
+void wx_configure_rx(struct wx *wx)
 {
 	u32 psrtype, i;
 	int ret;
@@ -1545,6 +1545,7 @@ static void wx_configure_rx(struct wx *wx)
 	wx_enable_rx(wx);
 	wx_enable_sec_rx_path(wx);
 }
+EXPORT_SYMBOL(wx_configure_rx);
 
 static void wx_configure_isb(struct wx *wx)
 {
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.h b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
index 1f93ca32c921..b95090e973ae 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
@@ -25,6 +25,7 @@ void wx_disable_rx(struct wx *wx);
 void wx_set_rx_mode(struct net_device *netdev);
 int wx_change_mtu(struct net_device *netdev, int new_mtu);
 void wx_disable_rx_queue(struct wx *wx, struct wx_ring *ring);
+void wx_configure_rx(struct wx *wx);
 void wx_configure(struct wx *wx);
 void wx_start_hw(struct wx *wx);
 int wx_disable_pcie_master(struct wx *wx);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 29dfb561887d..1de88a33a698 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -160,6 +160,10 @@
 #define WX_PSR_LAN_FLEX_DW_H(_i)     (0x15C04 + ((_i) * 16))
 #define WX_PSR_LAN_FLEX_MSK(_i)      (0x15C08 + ((_i) * 16))
 
+#define WX_PSR_WKUP_CTL              0x15B80
+/* Wake Up Filter Control Bit */
+#define WX_PSR_WKUP_CTL_MAG          BIT(1) /* Magic Packet Wakeup Enable */
+
 /* vlan tbl */
 #define WX_PSR_VLAN_TBL(_i)          (0x16000 + ((_i) * 4))
 
@@ -846,7 +850,7 @@ struct wx {
 	int duplex;
 	struct phy_device *phydev;
 
-	bool wol_enabled;
+	bool wol_hw_supported;
 	bool ncsi_enabled;
 	bool gpio_ctrl;
 	raw_spinlock_t gpio_lock;
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index 5b25834baf38..ec0e869e9aac 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -6,14 +6,49 @@
 #include <linux/netdevice.h>
 
 #include "../libwx/wx_ethtool.h"
+#include "../libwx/wx_type.h"
 #include "ngbe_ethtool.h"
 
+static void ngbe_get_wol(struct net_device *netdev,
+			 struct ethtool_wolinfo *wol)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	if (!wx->wol_hw_supported)
+		return;
+	wol->supported = WAKE_MAGIC;
+	wol->wolopts = 0;
+	if (wx->wol & WX_PSR_WKUP_CTL_MAG)
+		wol->wolopts |= WAKE_MAGIC;
+}
+
+static int ngbe_set_wol(struct net_device *netdev,
+			struct ethtool_wolinfo *wol)
+{
+	struct wx *wx = netdev_priv(netdev);
+	struct pci_dev *pdev = wx->pdev;
+
+	if (!wx->wol_hw_supported)
+		return -EOPNOTSUPP;
+
+	wx->wol = 0;
+	if (wol->wolopts & WAKE_MAGIC)
+		wx->wol = WX_PSR_WKUP_CTL_MAG;
+	netdev->wol_enabled = !!(wx->wol);
+	wr32(wx, WX_PSR_WKUP_CTL, wx->wol);
+	device_set_wakeup_enable(&pdev->dev, netdev->wol_enabled);
+
+	return 0;
+}
+
 static const struct ethtool_ops ngbe_ethtool_ops = {
 	.get_drvinfo		= wx_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
 	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
 	.nway_reset		= phy_ethtool_nway_reset,
+	.get_wol		= ngbe_get_wol,
+	.set_wol		= ngbe_set_wol,
 };
 
 void ngbe_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index c99a5d3de72e..2b431db6085a 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -62,7 +62,7 @@ static void ngbe_init_type_code(struct wx *wx)
 		       em_mac_type_rgmii :
 		       em_mac_type_mdi;
 
-	wx->wol_enabled = (wol_mask == NGBE_WOL_SUP) ? 1 : 0;
+	wx->wol_hw_supported = (wol_mask == NGBE_WOL_SUP) ? 1 : 0;
 	wx->ncsi_enabled = (ncsi_mask == NGBE_NCSI_MASK ||
 			   type_mask == NGBE_SUBID_OCP_CARD) ? 1 : 0;
 
@@ -440,14 +440,26 @@ static void ngbe_dev_shutdown(struct pci_dev *pdev, bool *enable_wake)
 {
 	struct wx *wx = pci_get_drvdata(pdev);
 	struct net_device *netdev;
+	u32 wufc = wx->wol;
 
 	netdev = wx->netdev;
+	rtnl_lock();
 	netif_device_detach(netdev);
 
-	rtnl_lock();
 	if (netif_running(netdev))
-		ngbe_down(wx);
+		ngbe_close(netdev);
+	wx_clear_interrupt_scheme(wx);
 	rtnl_unlock();
+
+	if (wufc) {
+		wx_set_rx_mode(netdev);
+		wx_configure_rx(wx);
+		wr32(wx, NGBE_PSR_WKUP_CTL, wufc);
+	} else {
+		wr32(wx, NGBE_PSR_WKUP_CTL, 0);
+	}
+	pci_wake_from_d3(pdev, !!wufc);
+	*enable_wake = !!wufc;
 	wx_control_hw(wx, false);
 
 	pci_disable_device(pdev);
@@ -621,12 +633,11 @@ static int ngbe_probe(struct pci_dev *pdev,
 	}
 
 	wx->wol = 0;
-	if (wx->wol_enabled)
+	if (wx->wol_hw_supported)
 		wx->wol = NGBE_PSR_WKUP_CTL_MAG;
 
-	wx->wol_enabled = !!(wx->wol);
+	netdev->wol_enabled = !!(wx->wol);
 	wr32(wx, NGBE_PSR_WKUP_CTL, wx->wol);
-
 	device_set_wakeup_enable(&pdev->dev, wx->wol);
 
 	/* Save off EEPROM version number and Option Rom version which
@@ -712,11 +723,52 @@ static void ngbe_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
+static int ngbe_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	bool wake;
+
+	ngbe_dev_shutdown(pdev, &wake);
+	device_set_wakeup_enable(&pdev->dev, wake);
+
+	return 0;
+}
+
+static int ngbe_resume(struct pci_dev *pdev)
+{
+	struct net_device *netdev;
+	struct wx *wx;
+	u32 err;
+
+	wx = pci_get_drvdata(pdev);
+	netdev = wx->netdev;
+
+	err = pci_enable_device_mem(pdev);
+	if (err) {
+		wx_err(wx, "Cannot enable PCI device from suspend\n");
+		return err;
+	}
+	pci_set_master(pdev);
+	device_wakeup_disable(&pdev->dev);
+
+	ngbe_reset_hw(wx);
+	rtnl_lock();
+	err = wx_init_interrupt_scheme(wx);
+	if (!err && netif_running(netdev))
+		err = ngbe_open(netdev);
+	if (!err)
+		netif_device_attach(netdev);
+	rtnl_unlock();
+
+	return 0;
+}
+
 static struct pci_driver ngbe_driver = {
 	.name     = ngbe_driver_name,
 	.id_table = ngbe_pci_tbl,
 	.probe    = ngbe_probe,
 	.remove   = ngbe_remove,
+	.suspend  = ngbe_suspend,
+	.resume   = ngbe_resume,
 	.shutdown = ngbe_shutdown,
 };
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
index c9ddbbc3fa4f..cc2f325a52f7 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
@@ -236,6 +236,7 @@ static void ngbe_phy_fixup(struct wx *wx)
 	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_100baseT_Half_BIT);
 	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
 
+	phydev->mac_managed_pm = true;
 	if (wx->mac_type != em_mac_type_mdi)
 		return;
 	/* disable EEE, internal phy does not support eee */
-- 
2.41.0


