Return-Path: <netdev+bounces-163483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB76A2A5F5
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 11:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0D3316841B
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 10:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30832227564;
	Thu,  6 Feb 2025 10:38:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1BE22756A
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 10:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738838339; cv=none; b=u2aB7KFfb1+l8ei/CqCibrmFGDqunOEx8c8Jq0/OFwT9c5sEMlyA65QWoBEVcUCDokzhQdx66pwq4y4I1mfNBCOXMT2lSjRbJuKRmOvoDz6FC2bEdpdfx39CtNF/xduYVfUXKHiA73uLESJzpvc4ezOnXmLThKv6fkrFxHEP2vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738838339; c=relaxed/simple;
	bh=SPQdQ4/lTaPiU3DlBx8QmSHGIGn1catXjApFeQ4TTd0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MxdWU50YHpJ+gLOxcxw97243ks+Nd4LPkIpli4VYKyQtxtEQxQd61BnqtUMDeF92iWu/pD/UHR9I0kOMcTeV93ai/x+FXQaou0XJ5Md5izb/4cyuUU9+1WQP7sToiKBOXVrtDuTsWidgdP9NUchgRJIgLDUjWSE4tONUO+wYaxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp78t1738838316t8icfgpk
X-QQ-Originating-IP: L09zUzNRT53C7cjv5mpAsk4FuJ16jQVt1NP61QqOqIc=
Received: from localhost.localdomain ( [125.120.70.88])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Feb 2025 18:38:34 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 2988504862006282369
From: mengyuanlou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v7 5/6] net: ngbe: add sriov function support
Date: Thu,  6 Feb 2025 18:37:49 +0800
Message-Id: <20250206103750.36064-6-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20250206103750.36064-1-mengyuanlou@net-swift.com>
References: <20250206103750.36064-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Nc/J2CUvEttV/C8g5cSN8FY6tsD2SaFuZ5gTTIARLHMsV+GLWx6dOee4
	elZnyUhUD49ujGDo1vKh9928Cx6GPnS21vycTDLGGsCETAJBWaZ49sBXv6kGSsLnFH3IA9s
	AXaZGAWvMzLtrfz1drCHkPLdczQwHUNFI9gLEnvV1lKcgmCXqKJ+4kT9ToVVIP8XVzmK8N3
	ymVzyAMvvqAeNTCz8kUWVXKCgiyeDFbgQuo+0qYyO+c6c8SdT7gh/VRgb9ElF16Z8CjhbVJ
	z699q2xpy+MdWV3t9rtUQIwbgPe8aECdNm3PhbJl/8XU+dGrnVzSYvuJVrpsGC/c24roGGD
	MPD5r2waAYbL0i7sY2NVDRPEI9So5bRl5Ht/AsieVj5/Lt73Kw3/OakUAUxD+/YPKj8Wuv/
	GJu67ZvJi0MCIr5cZH/2ciq9v1OhP6AvvOt3c0MxkrMqQezDV6jQ24fBUiaWudNx23GD/QZ
	0miF4BBzDynf6SIMCR5XH2IuDsMTlkWimxufwh19lga9GLSXKPFHer9DwJKhJywLPOqNxaM
	nFJw3SoGC6yPdwUvD47NnPL9pCjnZXwDwgqCOGXno/h9wJyyIT0YUnoG6quX2CcKSXJJFHU
	lrby6pkK7h4ka0t2jvJUZo2nBemhmqpF18OFF6hlxNLzD/CyuNcIct+DkB5H6avJetYe/ck
	ZH34QprC+0b7aXt/8dnfAHQaSbaRgbMShhkwO5RLCCNQCzSNGbjuVTgZHugN+qtdzaGLAxX
	xHjLiGO0SaMe5Al4hiGRTNFavqtATW9gJo7oB78xdoBMI2kWak2V2hWz8U7eCI1CUDZEJ7/
	lKHpB2NgnWJHhG6rUerPvfEYt1JUjM7UXhJeRoK+WnZ3r6b/6/DkCTJ3bqVXlISqU201J6k
	zXCZZc9ZXVdmVX5jAykwpoZj9EHwxgjO6LEXXiF5zLYbnvV7MtgLm4kB9CV24lbeMORlK/4
	dBZ4xoFe3UwljFdv/hyvgb0yurNJdgMxh90LIyTjD1/Z3HjyUuCYyqG3Wv+A6PUxfTutm5d
	+hJoEPuMOpWlqopA3D8KdrmzAy0riXhMEQN5GjAvbAUVBmbNO4
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

From: Mengyuan Lou <mengyuanlou@net-swift.com>

Add sriov_configure for driver ops.
Add mailbox handler wx_msg_task for ngbe in
the interrupt handler.
Add the notification flow when the vfs exist.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 31 ++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.h |  2 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  2 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 62 +++++++++++++++++--
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c | 10 +++
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |  3 +
 6 files changed, 106 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
index 2abac0d75939..744692fb53fa 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
@@ -865,3 +865,34 @@ void wx_msg_task(struct wx *wx)
 	}
 }
 EXPORT_SYMBOL(wx_msg_task);
+
+void wx_disable_vf_rx_tx(struct wx *wx)
+{
+	wr32(wx, WX_TDM_VFTE_CLR(0), 0);
+	wr32(wx, WX_RDM_VFRE_CLR(0), 0);
+	if (wx->mac.type == wx_mac_sp) {
+		wr32(wx, WX_TDM_VFTE_CLR(1), 0);
+		wr32(wx, WX_RDM_VFRE_CLR(1), 0);
+	}
+}
+EXPORT_SYMBOL(wx_disable_vf_rx_tx);
+
+void wx_ping_all_vfs_with_link_status(struct wx *wx, bool link_up)
+{
+	u32 msgbuf[2] = {0, 0};
+	u16 i;
+
+	if (!wx->num_vfs)
+		return;
+	msgbuf[0] = WX_PF_NOFITY_VF_LINK_STATUS | WX_PF_CONTROL_MSG;
+	if (link_up)
+		msgbuf[1] = (wx->speed << 1) | link_up;
+	if (wx->notify_down)
+		msgbuf[1] |= WX_PF_NOFITY_VF_NET_NOT_RUNNING;
+	for (i = 0 ; i < wx->num_vfs; i++) {
+		if (wx->vfinfo[i].clear_to_send)
+			msgbuf[0] |= WX_VT_MSGTYPE_CTS;
+		wx_write_mbx_pf(wx, msgbuf, 2, i);
+	}
+}
+EXPORT_SYMBOL(wx_ping_all_vfs_with_link_status);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.h b/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
index 5d1486f92dee..3cbec7fb51bc 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
@@ -7,5 +7,7 @@
 void wx_disable_sriov(struct wx *wx);
 int wx_pci_sriov_configure(struct pci_dev *pdev, int num_vfs);
 void wx_msg_task(struct wx *wx);
+void wx_disable_vf_rx_tx(struct wx *wx);
+void wx_ping_all_vfs_with_link_status(struct wx *wx, bool link_up);
 
 #endif /* _WX_SRIOV_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 84dabedb7e78..7d085b1ffd94 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -90,6 +90,7 @@
 /************************* Port Registers ************************************/
 /* port cfg Registers */
 #define WX_CFG_PORT_CTL              0x14400
+#define WX_CFG_PORT_CTL_PFRSTD       BIT(14)
 #define WX_CFG_PORT_CTL_DRV_LOAD     BIT(3)
 #define WX_CFG_PORT_CTL_QINQ         BIT(2)
 #define WX_CFG_PORT_CTL_D_VLAN       BIT(0) /* double vlan*/
@@ -1145,6 +1146,7 @@ struct wx {
 	enum wx_reset_type reset_type;
 
 	/* PHY stuff */
+	bool notify_down;
 	unsigned int link;
 	int speed;
 	int duplex;
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 53aeae2f884b..5233558cba51 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -14,6 +14,8 @@
 #include "../libwx/wx_type.h"
 #include "../libwx/wx_hw.h"
 #include "../libwx/wx_lib.h"
+#include "../libwx/wx_mbx.h"
+#include "../libwx/wx_sriov.h"
 #include "ngbe_type.h"
 #include "ngbe_mdio.h"
 #include "ngbe_hw.h"
@@ -128,6 +130,10 @@ static int ngbe_sw_init(struct wx *wx)
 	wx->tx_work_limit = NGBE_DEFAULT_TX_WORK;
 	wx->rx_work_limit = NGBE_DEFAULT_RX_WORK;
 
+	wx->mbx.size = WX_VXMAILBOX_SIZE;
+	wx->setup_tc = ngbe_setup_tc;
+	set_bit(0, &wx->fwd_bitmask);
+
 	return 0;
 }
 
@@ -197,11 +203,25 @@ static irqreturn_t ngbe_intr(int __always_unused irq, void *data)
 
 static irqreturn_t ngbe_msix_other(int __always_unused irq, void *data)
 {
-	struct wx *wx = data;
+	struct wx_q_vector *q_vector;
+	struct wx *wx  = data;
+	u32 eicr;
 
-	/* re-enable the original interrupt state, no lsc, no queues */
-	if (netif_running(wx->netdev))
-		ngbe_irq_enable(wx, false);
+	q_vector = wx->q_vector[0];
+
+	eicr = wx_misc_isb(wx, WX_ISB_MISC);
+
+	if (eicr & NGBE_PX_MISC_IC_VF_MBOX)
+		wx_msg_task(wx);
+
+	if (wx->num_vfs == 7) {
+		napi_schedule_irqoff(&q_vector->napi);
+		ngbe_irq_enable(wx, true);
+	} else {
+		/* re-enable the original interrupt state, no lsc, no queues */
+		if (netif_running(wx->netdev))
+			ngbe_irq_enable(wx, false);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -291,6 +311,22 @@ static void ngbe_disable_device(struct wx *wx)
 	struct net_device *netdev = wx->netdev;
 	u32 i;
 
+	if (wx->num_vfs) {
+		/* Clear EITR Select mapping */
+		wr32(wx, WX_PX_ITRSEL, 0);
+
+		/* Mark all the VFs as inactive */
+		for (i = 0 ; i < wx->num_vfs; i++)
+			wx->vfinfo[i].clear_to_send = 0;
+		wx->notify_down = true;
+		/* ping all the active vfs to let them know we are going down */
+		wx_ping_all_vfs_with_link_status(wx, false);
+		wx->notify_down = false;
+
+		/* Disable all VFTE/VFRE TX/RX */
+		wx_disable_vf_rx_tx(wx);
+	}
+
 	/* disable all enabled rx queues */
 	for (i = 0; i < wx->num_rx_queues; i++)
 		/* this call also flushes the previous write */
@@ -313,10 +349,17 @@ static void ngbe_disable_device(struct wx *wx)
 	wx_update_stats(wx);
 }
 
+static void ngbe_reset(struct wx *wx)
+{
+	wx_flush_sw_mac_table(wx);
+	wx_mac_set_default_filter(wx, wx->mac.addr);
+}
+
 void ngbe_down(struct wx *wx)
 {
 	phylink_stop(wx->phylink);
 	ngbe_disable_device(wx);
+	ngbe_reset(wx);
 	wx_clean_all_tx_rings(wx);
 	wx_clean_all_rx_rings(wx);
 }
@@ -339,6 +382,11 @@ void ngbe_up(struct wx *wx)
 		ngbe_sfp_modules_txrx_powerctl(wx, true);
 
 	phylink_start(wx->phylink);
+	/* Set PF Reset Done bit so PF/VF Mail Ops can work */
+	wr32m(wx, WX_CFG_PORT_CTL,
+	      WX_CFG_PORT_CTL_PFRSTD, WX_CFG_PORT_CTL_PFRSTD);
+	if (wx->num_vfs)
+		wx_ping_all_vfs_with_link_status(wx, false);
 }
 
 /**
@@ -578,6 +626,10 @@ static int ngbe_probe(struct pci_dev *pdev,
 		goto err_pci_release_regions;
 	}
 
+	/* The emerald supports up to 8 VFs per pf, but physical
+	 * function also need one pool for basic networking.
+	 */
+	pci_sriov_set_totalvfs(pdev, NGBE_MAX_VFS_DRV_LIMIT);
 	wx->driver_name = ngbe_driver_name;
 	ngbe_set_ethtool_ops(netdev);
 	netdev->netdev_ops = &ngbe_netdev_ops;
@@ -725,6 +777,7 @@ static void ngbe_remove(struct pci_dev *pdev)
 	struct net_device *netdev;
 
 	netdev = wx->netdev;
+	wx_disable_sriov(wx);
 	unregister_netdev(netdev);
 	phylink_destroy(wx->phylink);
 	pci_release_selected_regions(pdev,
@@ -784,6 +837,7 @@ static struct pci_driver ngbe_driver = {
 	.suspend  = ngbe_suspend,
 	.resume   = ngbe_resume,
 	.shutdown = ngbe_shutdown,
+	.sriov_configure = wx_pci_sriov_configure,
 };
 
 module_pci_driver(ngbe_driver);
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
index a5e9b779c44d..d44204f7e12a 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
@@ -8,6 +8,7 @@
 
 #include "../libwx/wx_type.h"
 #include "../libwx/wx_hw.h"
+#include "../libwx/wx_sriov.h"
 #include "ngbe_type.h"
 #include "ngbe_mdio.h"
 
@@ -64,6 +65,11 @@ static void ngbe_mac_config(struct phylink_config *config, unsigned int mode,
 static void ngbe_mac_link_down(struct phylink_config *config,
 			       unsigned int mode, phy_interface_t interface)
 {
+	struct wx *wx = phylink_to_wx(config);
+
+	wx->speed = 0;
+	/* ping all the active vfs to let them know we are going down */
+	wx_ping_all_vfs_with_link_status(wx, false);
 }
 
 static void ngbe_mac_link_up(struct phylink_config *config,
@@ -103,6 +109,10 @@ static void ngbe_mac_link_up(struct phylink_config *config,
 	wr32(wx, WX_MAC_PKT_FLT, WX_MAC_PKT_FLT_PR);
 	reg = rd32(wx, WX_MAC_WDG_TIMEOUT);
 	wr32(wx, WX_MAC_WDG_TIMEOUT, reg);
+
+	wx->speed = speed;
+	/* ping all the active vfs to let them know we are going up */
+	wx_ping_all_vfs_with_link_status(wx, true);
 }
 
 static const struct phylink_mac_ops ngbe_mac_ops = {
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
index f48ed7fc1805..2b1302c73a16 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
@@ -72,11 +72,13 @@
 #define NGBE_PX_MISC_IEN_DEV_RST		BIT(10)
 #define NGBE_PX_MISC_IEN_ETH_LK			BIT(18)
 #define NGBE_PX_MISC_IEN_INT_ERR		BIT(20)
+#define NGBE_PX_MISC_IC_VF_MBOX			BIT(23)
 #define NGBE_PX_MISC_IEN_GPIO			BIT(26)
 #define NGBE_PX_MISC_IEN_MASK ( \
 				NGBE_PX_MISC_IEN_DEV_RST | \
 				NGBE_PX_MISC_IEN_ETH_LK | \
 				NGBE_PX_MISC_IEN_INT_ERR | \
+				NGBE_PX_MISC_IC_VF_MBOX | \
 				NGBE_PX_MISC_IEN_GPIO)
 
 #define NGBE_INTR_ALL				0x1FF
@@ -129,6 +131,7 @@
 #define NGBE_MAX_RXD				8192
 #define NGBE_MIN_RXD				128
 
+#define NGBE_MAX_VFS_DRV_LIMIT			7
 extern char ngbe_driver_name[];
 
 void ngbe_down(struct wx *wx);
-- 
2.30.1 (Apple Git-130)


