Return-Path: <netdev+bounces-180102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EF9A7F937
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B68E16FBAB
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABB1264A88;
	Tue,  8 Apr 2025 09:17:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F258264A85
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744103846; cv=none; b=TiGwGYiyY8FGenA5Rt5UVJ2XaptxWhbzdeaEE3yGw595ztukS7T96aXlz2w+G3JPZTSUIxm1mviL6DFW/uRixcvLL8fHnnh+kEeiCopmZ8LMO/31WbAHe3X4w+su1vQbgU6cl08nwpzn7XuxTx6eb2+PtbKeIamkFNQfrDzqivQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744103846; c=relaxed/simple;
	bh=QDRhNBQmsiB1Ue2vykleqFk688GFvjEADDnIGC6Sq8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQd/LtAQJQutCBZg6190A32B1zeh7vwrcd1wMZ518wjZh8Y2A1KxYKvaLAs8nwqxBm5wTRA/mNRAoUrpdZs6ry3TmzMGLdEac9Bmjen/8VNfPWqhNfrT2CPP9Fgx3JKIHtVbvfGmHRl4YlrMx16c/8PTr+x1mNT+mjCed/CPL6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpsz3t1744103809td6b8b8
X-QQ-Originating-IP: G4y8Jzx+Aq/MnFQjeSTnSvX8mLQ4LsT5/lcHb5eZOw8=
Received: from localhost.localdomain ( [183.159.168.74])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 08 Apr 2025 17:16:47 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17811922499680823643
EX-QQ-RecipientCnt: 7
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	horms@kernel.org,
	jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	linglingzhang@trustnetic.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v10 5/6] net: ngbe: add sriov function support
Date: Tue,  8 Apr 2025 17:15:55 +0800
Message-ID: <C9A0A43732966022+20250408091556.9640-6-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250408091556.9640-1-mengyuanlou@net-swift.com>
References: <20250408091556.9640-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: M09gqB+k9NCmr7g2uulNT7XEbYg7Xqd04ZqKjKT52dXKWT5n0ULFp2tp
	ZOOqyhnH6avvJ9PA5WeiD9y1AzyM7GpgpdvoNiMfWqjr6H//i8Toj03LZjyioDKQ87p6RRI
	zcdBzkQoLivFjxS6vPqbrsXbQ5MmfZKmAtGrnQaci8M63ee7vLlTGFS8DtPnssS0g2ucw1w
	lMH7LD8gtBATAH4GRbF3SEtGrMCjQpqilnH09UWvF2HDlH7TDHNC+Mz6HLE7itJYuN2xuLx
	er/cbqt7BEJopGGFSTOvIssvHrPooFziqjVI3Ayv1ZpjUSsLSDIXV2cHsVUGAx/EsEk94nn
	9Dw4j09Km3EBckvJWhS3Pnciou9rmnrPykYR7pJAY/AHstORRQvuqkuE67BX9/XY7cuoXOd
	2wLSg5bnwcBoGLlsZ890f4jBKuHl5miMJfDFvb0YARsZHHZpXw8kudZTvm9pnkpJM84mLV0
	NNlitDC/RLC6liAacL74OEEnqt9bXZX4XdU2fnQWyT1EyVWi+HGw6yOOMcnyW9r4eAxUamt
	428tTp6RjePBBAUn365iTI7XDzdVvv/wHdw700Bf1qzqqVxbY+Auw4js/h9A3x1qycUmMTH
	I8mXjEFLUjJN7uNNB5MLq2Y1v55eC7XuWo2QE2BThVrYaO++PyrnNCIsrgEs6SqeQ+1ZuK/
	OX+4+EIZAeZkrZF7uqM3wAU+dNE8qv3MX1BEAurL2UKIquFFlJ5fZl/4qtfavnvtPIAb5wW
	jezkMV2PrKYAG0FdH5QBcr9kNItd9F6vW/Xwk3g3p/UBZUWYTrzknOm7TjiKV4tna2EW8s0
	kF/KNWnQeBGuNBER4Mwrzetfq65qHp+J9WwYc8XS5OrzDOjiy0lcwr+GN9NQdBqZKap7sib
	gdSCOKpRTlkV+dZY/GJvBlrkviZUdBf2DhCrfnCw4AWYe57zPZj203vMIBn7oFnsqtxNd3F
	Rfm+F9+oF/qUWTyI7AmEBs/5eXzhHV66GRVkN39kRuLNcExMyBqp1csSSX5R2gYXcf3Ghxl
	p8yZpp6dGrrTsIow1mTHkgXcrFdW6aZaIeHUQfZpRSQyLg1967tystU1weslv4zthHR9usI
	vnZzjU3mLCL
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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
index 1a7cadbf7234..a31b574a343e 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
@@ -834,3 +834,34 @@ void wx_msg_task(struct wx *wx)
 	}
 }
 EXPORT_SYMBOL(wx_msg_task);
+
+void wx_disable_vf_rx_tx(struct wx *wx)
+{
+	wr32(wx, WX_TDM_VFTE_CLR(0), U32_MAX);
+	wr32(wx, WX_RDM_VFRE_CLR(0), U32_MAX);
+	if (wx->mac.type != wx_mac_em) {
+		wr32(wx, WX_TDM_VFTE_CLR(1), U32_MAX);
+		wr32(wx, WX_RDM_VFRE_CLR(1), U32_MAX);
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
+		msgbuf[1] = FIELD_PREP(GENMASK(31, 1), wx->speed) | link_up;
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
index d3f29617c7d3..376d8e0e49f3 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
@@ -11,5 +11,7 @@
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
index a6159214ec0a..fd102078f5c9 100644
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
+static irqreturn_t __ngbe_msix_misc(struct wx *wx, u32 eicr)
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
 
+static irqreturn_t ngbe_msix_misc(int __always_unused irq, void *data)
+{
+	struct wx *wx = data;
+	u32 eicr;
+
+	eicr = wx_misc_isb(wx, WX_ISB_MISC);
+
+	return __ngbe_msix_misc(wx, eicr);
+}
+
+static irqreturn_t ngbe_misc_and_queue(int __always_unused irq, void *data)
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
+	return __ngbe_msix_misc(wx, eicr);
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
+				  ngbe_misc_and_queue, 0, netdev->name, wx);
+	else
+		err = request_irq(wx->msix_entry->vector,
+				  ngbe_msix_misc, 0, netdev->name, wx);
 
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
2.48.1


