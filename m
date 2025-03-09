Return-Path: <netdev+bounces-173323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E59A58575
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 16:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCF937A5836
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 15:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0481DE4F8;
	Sun,  9 Mar 2025 15:44:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EEB1DE3B3
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741535043; cv=none; b=CXK9OOSYF/v1NWJrUC9kYpeR/Ep4VCVt2WNLZOsg4eUB/lbJMVdbt1jEh7Ogia3MzKZ86cNAQgK6r13n4hO2HCg3ZZkk+/sQ2TO07Z4k101m1CA/g3DvuN0Z8yCi7EhBgbtoru9ZN723Ud/yke7NVKgQNFw8j86iGMTWdWmsGxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741535043; c=relaxed/simple;
	bh=UIo2AHvckYWmXjNUb+1vYI3mKgqK+tfcywzgEhSkoh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oxmEHYWduBa23Pjq+wWCrhljtwcAbCgHt1vRIVsvlFjkEvi4AQ8b4V/Ht/Z/U4Cr5Q7WQFPZJG+UEgh0/ZH7hJ1M2UBqLq/j03/nBvfafhTO9oO4or8POXUBzj1KBIX80nGgj2uk//eCSmoQ+3vRnlfQwwBSnpWdSBfQAg3ALvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpsz5t1741535007t8630dj
X-QQ-Originating-IP: woo7DKAusMf8dTBqj98x6FCSGadszD0E27fBRwDjDm8=
Received: from localhost.localdomain ( [122.224.83.35])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 09 Mar 2025 23:43:24 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7664506806954185722
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v8 5/6] net: ngbe: add sriov function support
Date: Sun,  9 Mar 2025 23:42:51 +0800
Message-Id: <20250309154252.79234-6-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20250309154252.79234-1-mengyuanlou@net-swift.com>
References: <20250309154252.79234-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Ndw/mc8X39ObI1NVvehFNmUuf82a02l4Vhy6b8v0oLr+mQo1ps901PXY
	CzkHV/vYdpmuddAU5+xNj25FaABhpItO4LrdpRMokK4xxw91/v5jfpt10nI8+C3B+3BFKfl
	PCPFTopLATIkkSYmJoMhZT4+3WjTpVrhOXDg6KIduKewEZY+54gfPaGF6n/1Q7gEMU6JEgz
	KEHu3XBNzFgZZBYryEw28hjFcrfEzqFX27s8r7fRGOX17KokuBzANQPiNHepFqBbtq9SoR+
	hyD8Ea8SP5qit+GmaQxFZrtrqpin5CwwbkOLKij9jIO0iFOvayO/q56pcl1/Xi2gFrTf7Qn
	ohWmqb+pFhxAyq+ocEOI/xjZBXanO7v7fZ4tJQbUx9SZKY0SbKGhsBfPttnwqguQJzDAyqZ
	2j5Rl0XoOf1Z+QzkS33uXuoR0HzNem7TgoACCRpdstaLDJ8L9nqcNQZhVkzAytJl78xD32d
	i6SN+dRk2eivl0RpAYBucmZX5+INqsUrLTVcRo+j9lAyaiURNvBqogZ8wFikoeCFgwim7go
	okDboNe0lgayTV5aosD02cxTxA133Ah7S+G7JPCmhvNvQxwrNutuS2WtVWQZJVy73VyKEaT
	23c6FVjy3UNYi880VC2rP38HflgMp20IjhiMwfjfm7uGg8a8gqmFrNS+A5I9tzWJbR7Bn3A
	LIQVWQvMJ78xHKe4qsKyGIq9t0/YE4s0pe29zKC7trLLHcN0CRkiEOmXn2brqDI8RBn5rF5
	TgYOX2dfw9+mShaRYF03dWrBRRabqgMDUMokmmVFGtsMxhMwQay8IUP10FXP6wHjlq9RFhj
	2hvowvzGFK/94LFnHEke6GVb51icc1gDOvaa9eAsHqC5OJ9VXhfU1slzflCBuhoPbCuFwNC
	gH5iy2Yp6rh4jNOWIJpT2sEy4mynIBiNPpg22jF39N2PiNDPZKjnR4fIZnVfMIjUgUBk/Ua
	phh1gjLXyS7KN0Xrwt0b0MH6+/1RUqWKEC6dx5OCBt9n1xrzq36BsWO8mQe4908AzA3bzHn
	oqoRMyvexXcMBlxvj5ZsXWUcWZTnc=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Add sriov_configure for driver ops.
Add mailbox handler wx_msg_task for ngbe in
the interrupt handler.
Add the notification flow when the vfs exist.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 31 +++++++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.h |  2 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  2 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 93 +++++++++++++++++--
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c |  5 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |  3 +
 6 files changed, 127 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
index a03861157072..12d263890ad9 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
@@ -835,3 +835,34 @@ void wx_msg_task(struct wx *wx)
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
+	for (i = 0; i < wx->num_vfs; i++) {
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
index a5ca2ca0aba7..9b9345290594 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -92,6 +92,7 @@
 /************************* Port Registers ************************************/
 /* port cfg Registers */
 #define WX_CFG_PORT_CTL              0x14400
+#define WX_CFG_PORT_CTL_PFRSTD       BIT(14)
 #define WX_CFG_PORT_CTL_DRV_LOAD     BIT(3)
 #define WX_CFG_PORT_CTL_QINQ         BIT(2)
 #define WX_CFG_PORT_CTL_D_VLAN       BIT(0) /* double vlan*/
@@ -1231,6 +1232,7 @@ struct wx {
 	u8 swfw_index;
 
 	/* PHY stuff */
+	bool notify_down;
 	unsigned int link;
 	int speed;
 	int duplex;
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index a6159214ec0a..d321c7f23b0b 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -15,6 +15,8 @@
 #include "../libwx/wx_hw.h"
 #include "../libwx/wx_lib.h"
 #include "../libwx/wx_ptp.h"
+#include "../libwx/wx_mbx.h"
+#include "../libwx/wx_sriov.h"
 #include "ngbe_type.h"
 #include "ngbe_mdio.h"
 #include "ngbe_hw.h"
@@ -129,6 +131,10 @@ static int ngbe_sw_init(struct wx *wx)
 	wx->tx_work_limit = NGBE_DEFAULT_TX_WORK;
 	wx->rx_work_limit = NGBE_DEFAULT_RX_WORK;
 
+	wx->mbx.size = WX_VXMAILBOX_SIZE;
+	wx->setup_tc = ngbe_setup_tc;
+	set_bit(0, &wx->fwd_bitmask);
+
 	return 0;
 }
 
@@ -200,12 +206,10 @@ static irqreturn_t ngbe_intr(int __always_unused irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t ngbe_msix_other(int __always_unused irq, void *data)
+static irqreturn_t ngbe_msix_common(struct wx *wx, u32 eicr)
 {
-	struct wx *wx = data;
-	u32 eicr;
-
-	eicr = wx_misc_isb(wx, WX_ISB_MISC);
+	if (eicr & NGBE_PX_MISC_IC_VF_MBOX)
+		wx_msg_task(wx);
 
 	if (unlikely(eicr & NGBE_PX_MISC_IC_TIMESYNC))
 		wx_ptp_check_pps_event(wx);
@@ -217,6 +221,35 @@ static irqreturn_t ngbe_msix_other(int __always_unused irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t ngbe_msix_other(int __always_unused irq, void *data)
+{
+	struct wx *wx = data;
+	u32 eicr;
+
+	eicr = wx_misc_isb(wx, WX_ISB_MISC);
+
+	return ngbe_msix_common(wx, eicr);
+}
+
+static irqreturn_t ngbe_msic_and_queue(int __always_unused irq, void *data)
+{
+	struct wx_q_vector *q_vector;
+	struct wx *wx = data;
+	u32 eicr;
+
+	eicr = wx_misc_isb(wx, WX_ISB_MISC);
+	if (!eicr) {
+		/* queue */
+		q_vector = wx->q_vector[0];
+		napi_schedule_irqoff(&q_vector->napi);
+		if (netif_running(wx->netdev))
+			ngbe_irq_enable(wx, true);
+		return IRQ_HANDLED;
+	}
+
+	return ngbe_msix_common(wx, eicr);
+}
+
 /**
  * ngbe_request_msix_irqs - Initialize MSI-X interrupts
  * @wx: board private structure
@@ -249,8 +282,16 @@ static int ngbe_request_msix_irqs(struct wx *wx)
 		}
 	}
 
-	err = request_irq(wx->msix_entry->vector,
-			  ngbe_msix_other, 0, netdev->name, wx);
+	/* Due to hardware design, when num_vfs < 7, pf can use 0 for misc and 1
+	 * for queue. But when num_vfs == 7, vector[1] is assigned to vf6.
+	 * Misc and queue should reuse interrupt vector[0].
+	 */
+	if (wx->num_vfs == 7)
+		err = request_irq(wx->msix_entry->vector,
+				  ngbe_msic_and_queue, 0, netdev->name, wx);
+	else
+		err = request_irq(wx->msix_entry->vector,
+				  ngbe_msix_other, 0, netdev->name, wx);
 
 	if (err) {
 		wx_err(wx, "request_irq for msix_other failed: %d\n", err);
@@ -302,6 +343,22 @@ static void ngbe_disable_device(struct wx *wx)
 	struct net_device *netdev = wx->netdev;
 	u32 i;
 
+	if (wx->num_vfs) {
+		/* Clear EITR Select mapping */
+		wr32(wx, WX_PX_ITRSEL, 0);
+
+		/* Mark all the VFs as inactive */
+		for (i = 0; i < wx->num_vfs; i++)
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
@@ -324,12 +381,19 @@ static void ngbe_disable_device(struct wx *wx)
 	wx_update_stats(wx);
 }
 
+static void ngbe_reset(struct wx *wx)
+{
+	wx_flush_sw_mac_table(wx);
+	wx_mac_set_default_filter(wx, wx->mac.addr);
+	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
+		wx_ptp_reset(wx);
+}
+
 void ngbe_down(struct wx *wx)
 {
 	phylink_stop(wx->phylink);
 	ngbe_disable_device(wx);
-	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
-		wx_ptp_reset(wx);
+	ngbe_reset(wx);
 	wx_clean_all_tx_rings(wx);
 	wx_clean_all_rx_rings(wx);
 }
@@ -352,6 +416,11 @@ void ngbe_up(struct wx *wx)
 		ngbe_sfp_modules_txrx_powerctl(wx, true);
 
 	phylink_start(wx->phylink);
+	/* Set PF Reset Done bit so PF/VF Mail Ops can work */
+	wr32m(wx, WX_CFG_PORT_CTL,
+	      WX_CFG_PORT_CTL_PFRSTD, WX_CFG_PORT_CTL_PFRSTD);
+	if (wx->num_vfs)
+		wx_ping_all_vfs_with_link_status(wx, false);
 }
 
 /**
@@ -596,6 +665,10 @@ static int ngbe_probe(struct pci_dev *pdev,
 		goto err_pci_release_regions;
 	}
 
+	/* The emerald supports up to 8 VFs per pf, but physical
+	 * function also need one pool for basic networking.
+	 */
+	pci_sriov_set_totalvfs(pdev, NGBE_MAX_VFS_DRV_LIMIT);
 	wx->driver_name = ngbe_driver_name;
 	ngbe_set_ethtool_ops(netdev);
 	netdev->netdev_ops = &ngbe_netdev_ops;
@@ -743,6 +816,7 @@ static void ngbe_remove(struct pci_dev *pdev)
 	struct net_device *netdev;
 
 	netdev = wx->netdev;
+	wx_disable_sriov(wx);
 	unregister_netdev(netdev);
 	phylink_destroy(wx->phylink);
 	pci_release_selected_regions(pdev,
@@ -802,6 +876,7 @@ static struct pci_driver ngbe_driver = {
 	.suspend  = ngbe_suspend,
 	.resume   = ngbe_resume,
 	.shutdown = ngbe_shutdown,
+	.sriov_configure = wx_pci_sriov_configure,
 };
 
 module_pci_driver(ngbe_driver);
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
index ea1d7e9a91f3..c63bb6e6f405 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
@@ -9,6 +9,7 @@
 #include "../libwx/wx_type.h"
 #include "../libwx/wx_ptp.h"
 #include "../libwx/wx_hw.h"
+#include "../libwx/wx_sriov.h"
 #include "ngbe_type.h"
 #include "ngbe_mdio.h"
 
@@ -70,6 +71,8 @@ static void ngbe_mac_link_down(struct phylink_config *config,
 	wx->speed = SPEED_UNKNOWN;
 	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
 		wx_ptp_reset_cyclecounter(wx);
+	/* ping all the active vfs to let them know we are going down */
+	wx_ping_all_vfs_with_link_status(wx, false);
 }
 
 static void ngbe_mac_link_up(struct phylink_config *config,
@@ -114,6 +117,8 @@ static void ngbe_mac_link_up(struct phylink_config *config,
 	wx->last_rx_ptp_check = jiffies;
 	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
 		wx_ptp_reset_cyclecounter(wx);
+	/* ping all the active vfs to let them know we are going up */
+	wx_ping_all_vfs_with_link_status(wx, true);
 }
 
 static const struct phylink_mac_ops ngbe_mac_ops = {
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
index 992adbb98c7d..bb74263f0498 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
@@ -73,12 +73,14 @@
 #define NGBE_PX_MISC_IEN_TIMESYNC		BIT(11)
 #define NGBE_PX_MISC_IEN_ETH_LK			BIT(18)
 #define NGBE_PX_MISC_IEN_INT_ERR		BIT(20)
+#define NGBE_PX_MISC_IC_VF_MBOX			BIT(23)
 #define NGBE_PX_MISC_IEN_GPIO			BIT(26)
 #define NGBE_PX_MISC_IEN_MASK ( \
 				NGBE_PX_MISC_IEN_DEV_RST | \
 				NGBE_PX_MISC_IEN_TIMESYNC | \
 				NGBE_PX_MISC_IEN_ETH_LK | \
 				NGBE_PX_MISC_IEN_INT_ERR | \
+				NGBE_PX_MISC_IC_VF_MBOX | \
 				NGBE_PX_MISC_IEN_GPIO)
 
 /* Extended Interrupt Cause Read */
@@ -134,6 +136,7 @@
 #define NGBE_MAX_RXD				8192
 #define NGBE_MIN_RXD				128
 
+#define NGBE_MAX_VFS_DRV_LIMIT			7
 extern char ngbe_driver_name[];
 
 void ngbe_down(struct wx *wx);
-- 
2.30.1 (Apple Git-130)


