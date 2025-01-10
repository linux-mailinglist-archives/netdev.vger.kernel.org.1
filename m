Return-Path: <netdev+bounces-157085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968AFA08DFB
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 11:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 337007A0673
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B8C20C00A;
	Fri, 10 Jan 2025 10:27:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB5A20C016
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504870; cv=none; b=BU026feq1JiGB72Kyz/70RLoPQj2ffVNIlESyBwU7P6kyX9K8MW6QbQQdjMCqxANsCC6BeoF6o+rcPfuT04F6gYiuGagjoUKNIXkw602TpMITLhGD6nkc8b7qdo5vdVQBkRy8Hdv0l46624Yl33Kk/Qz7L9TQNcmS0Bf/hxC9E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504870; c=relaxed/simple;
	bh=dOhUOoFZLHNXAGWYD/iZuUm/VEvLWqNXxTga0FviYzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SHIm7XawWoyURA7tiFlus/tnuq0GNdRS/xKO2XYtavxQz+kv80HQIqIPc7e3HpNlF2abdynvabWXB3W1AeitFptIVI3JcKFweSWOAStRurh69KpTCXfcp9jsLXsvTotOSXqktdyd5SBYen0/R9e0YCNJSLT3ZphI2AMGlf2leiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp84t1736504857tc3kbcbn
X-QQ-Originating-IP: QXBtxoCoh5J++0Cs8XQt2+BboPsVmILYuxECocZauco=
Received: from localhost.localdomain ( [218.72.126.41])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 10 Jan 2025 18:27:35 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 5729733740440106594
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: helgaas@kernel.org,
	jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v6 5/6] net: ngbe: add sriov function support
Date: Fri, 10 Jan 2025 18:27:04 +0800
Message-Id: <20250110102705.21846-6-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20250110102705.21846-1-mengyuanlou@net-swift.com>
References: <20250110102705.21846-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MmCmH9jyqHC2cGtbdqK1+lhibRilqaWLN5rMHfKu7mIuZTjgKW+GlVy9
	hcdJpFMZUbnpY0EGj+gDJ64ENhV++bOMHJ4sMxJuVQdh5xkYuhAJzTplPv6TysxUnDvTaKx
	/alCUYEQXV79Vb2vo7TwB6YqQ6E+SXkKNmEKLg2yJrcMBw/uhH+v+gExiPFX0zLUiNmFy02
	6wNcYId7mWQTP1Gff77cA2t49xYNTobdpY+Bjr1ZCuQwzRfgS74+87rSCa+c/fXHlyBD4k4
	p0FDKDdkNUE9Dcqldtd62tN25tssxAMqYDzPW/CEKY/ZYHnULNMdlJcBoJA9KddlwCjgO4c
	COhlaaBi5/tydw+MSlJWkXKPdIrTWek7CLzE7h4FC6F5Li1I51vapBNTsK0/BKtt+L8kK/i
	ozb1dPXlmVWzzpZ8YSRmRFRSjof3iUayGdqo7TsDdHbDum67Ojja4nwa0kmSNgi0BDXmdsq
	/8m/O7g6KTgtznzW3lyewAcGx/70GGQA0ew8bmdU1La4CIWywvMusgluQa78EnLBFVdcH4s
	XtNPcwwXnjCtrsvUaGB/pM1eZtEyuRm2Af3tjK6l9xtYY/ya2yTNKr1QsZO7U/4DxU/xkdA
	iCU9omXj1WymkaGis919G0H4kmIuiROvzsP+d/hBEcToJ4+EGkNNO1K7WFJkwOwVh/wQS8E
	tRoRyyDVN3pp72hk6ic2p68F43Av9XR/hcmhKWX90L7SN5pUSBTGFQqEHu/VfV7OnYOJHAG
	XzYZ/TibB1LHng2DI+NcVDqz+jV09mSDS08SE+Ils0RzNGMQhUwg4s3KU9o7Fg5cgA4mlW9
	jG6Jedt/eFEIfJAvKSyw7Q9pBOg6v5l0keBtw67PaNWUVpv1XXFrj2+DRbeR7m7XmnmyB1F
	s62efhRiUfLBPUPndl2S/C6TMaqvmJq9ze0+mG+QDFwaiRKtPnXTXzYnLJu+MJlo5NXnM+G
	hY4jPsHPRJ6NvfH/lIN5Vy5U5k8C36FhQf3gFc9L+P3qUUX+op5IaCGuCeLGg+Zp2gxVlLV
	ou0cQS51T4mqRJuaN+FzpI6+HmkAmIWSTolMQORo9GcKIRXk+U+Hv75dwodo4=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Add sriov_configure for driver ops.
Add mailbox handler wx_msg_task for ngbe in
the interrupt handler.
Add the notification flow when the vfs exist.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 31 ++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.h |  2 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  2 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 58 +++++++++++++++++--
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c | 10 ++++
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |  2 +
 6 files changed, 101 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
index 025b20481b86..7f217e0d30bc 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
@@ -880,3 +880,34 @@ void wx_msg_task(struct wx *wx)
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
index 53aeae2f884b..a03a4b5f2766 100644
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
@@ -725,6 +773,7 @@ static void ngbe_remove(struct pci_dev *pdev)
 	struct net_device *netdev;
 
 	netdev = wx->netdev;
+	wx_disable_sriov(wx);
 	unregister_netdev(netdev);
 	phylink_destroy(wx->phylink);
 	pci_release_selected_regions(pdev,
@@ -784,6 +833,7 @@ static struct pci_driver ngbe_driver = {
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
index f48ed7fc1805..bb70af035c39 100644
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
-- 
2.30.1 (Apple Git-130)


