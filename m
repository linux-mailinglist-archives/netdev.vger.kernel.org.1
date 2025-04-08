Return-Path: <netdev+bounces-180103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD47A7F941
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142C31899C34
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535FF26463C;
	Tue,  8 Apr 2025 09:17:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A075D20459F
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.80.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744103855; cv=none; b=OgyABIlqX8/Nphq39fPnWmOxgi3XDvLyj2UJtFlPQ+DJOjMsrYS37XCOfPprUN7cmcer5M1Nb2MbUQ5brhvlH2X58Js0p5hZNvnDsIXEl/cv5GVlOc1NOUH+ztHT9cibYCasNa9anXwAyuzZMxLCCMfzBrOrWrTvYHW4BYsfMZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744103855; c=relaxed/simple;
	bh=IN1D4OQLWJIQSJEJvwPFOeTprZSDx/46OsPaQ/xQzZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lq8J+QyxEBWutk7liHg7U+idedIqQeHr55tZ6ne2iXRICfTTJ882BBTrGAjEF7WVybdJccPak5Qmx15gidczYQlhlWMkNLlaZ2HXhRq5EkyLXDxOAcipRv1T8Tabl7k+hCF9LGrReFcTI7meBy5dqUCp3o6CtfzB7nTVNyXI/7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=43.155.80.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpsz3t1744103812t52649b
X-QQ-Originating-IP: fj6yVy2VHvt8ztYGqzlTSr9eSMuof1je10NUX0/E3Bc=
Received: from localhost.localdomain ( [183.159.168.74])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 08 Apr 2025 17:16:50 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 11977231710986717222
EX-QQ-RecipientCnt: 7
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	horms@kernel.org,
	jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	linglingzhang@trustnetic.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v10 6/6] net: txgbe: add sriov function support
Date: Tue,  8 Apr 2025 17:15:56 +0800
Message-ID: <ECDC57CF4F2316B9+20250408091556.9640-7-mengyuanlou@net-swift.com>
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
X-QQ-XMAILINFO: MXeL038M19QBCC5C3sBRN/wOW1y6aY9DcxsE7nLKaLO3ZJYBeWdhPs5U
	7mtf9UH0FWJCFSURUnF1/Fju1c0IE1RMvidlvtoeT8u7t5w6Ms4RNzOqIB0knZ+6ChNS1Zk
	nHCcNGESVmgJFh6M+/ce/6pPJI8EmG7ByftqyxLvn8yyGCRhoh0YPAGoZ58WH8FdklVn6pf
	f5uA+I71AABUCaiu82RwVOiyowVPaAGH8GJHMad8ZBiIHJKoj97EwTcmc+aVzTuY/AvD5nf
	wIjY46GeCMUf/0qf+IJtOCzJ8PRN5bA4MFbaN5aaOrbNonORiqh6dX0yI3X4P+DZVqvlBFC
	0tH7L1rjn1Q2Kg5WJXyxoKst8+yMOjRVxX71qOxDRmr3xN0W80LASEtKCxM8tKp8j004Orm
	nR5c2IEcMJoqVLJ6k0PHQXJSQZlVLVCEAeZG9Kcdl4vuqYFwdoRO/TtRH2dBy0la9+Wb2QO
	5T1T+KGuzltUy7d54NdEig5zPFyrSDAN0PzH035TPxGlT0Y/tAwVJRFlg93zn1NrUWDBbHL
	gLj3EsVOC6krzujz78lVSUVZ4TaEzG0m7GRZka4e+Be6oQB0lYAszXBr1tiwD7EJG8EnPNK
	5As99yjAo1DWvNaZPNgjSi50CZoVG4hMm765CecnJWYaa2NmcllkW00XCnVmcihqn57NSls
	mNIw5x/ycGbV5ysnxWt7b5ZLHkcy2I5pLAVYtpwmYsgCcozJ82veCkYOQPziE/I8hQsN33g
	3S2Hj1rR+3tiesVAA0BXlQFN6OcC/WpeICMXXYdLgDOibt+GBPZY1cA5stXerYNDxsR6enG
	bghta9RJ46ajgn8PZa3c8N5ppLskdeperNdEEVOEgLPHcAZ2hAKFwilCwerjr90bl9ywhYu
	xOj8yexV37hjHGsYtsRmZmx9oMPITyFPcO2ldapHQtMCije9utoPDuqOpT+tLWH3/GEuX7G
	9XdcgyJggsjp0bi6NHot10FM2lLAdaR1AosjcJOvot4JNyutx9NYxJ6jXd4XnXVbx2QbMj1
	cIl0DlUSUn9hiDDwiouVNzZgbTUvgc8vBEWftXn/5K9LwPcXpmyW/ljE0VRDOityO/0YCqU
	K5l/oZsn/DJenrFmkpgBdIft8OcIWa1O5TD7Nrdw4SL
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Add sriov_configure for driver ops.
Add mailbox handler wx_msg_task for txgbe.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 42 +++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.h |  1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  1 +
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    | 21 ++++++++--
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 27 ++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |  6 +++
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  7 +++-
 7 files changed, 101 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
index a31b574a343e..52e6a6faf715 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
@@ -282,6 +282,15 @@ static void wx_clear_vmvir(struct wx *wx, u32 vf)
 	wr32(wx, WX_TDM_VLAN_INS(vf), 0);
 }
 
+static void wx_ping_vf(struct wx *wx, int vf)
+{
+	u32 ping = WX_PF_CONTROL_MSG;
+
+	if (wx->vfinfo[vf].clear_to_send)
+		ping |= WX_VT_MSGTYPE_CTS;
+	wx_write_mbx_pf(wx, &ping, 1, vf);
+}
+
 static void wx_set_vf_rx_tx(struct wx *wx, int vf)
 {
 	u32 index = WX_VF_REG_OFFSET(vf), vf_bit = WX_VF_IND_SHIFT(vf);
@@ -865,3 +874,36 @@ void wx_ping_all_vfs_with_link_status(struct wx *wx, bool link_up)
 	}
 }
 EXPORT_SYMBOL(wx_ping_all_vfs_with_link_status);
+
+static void wx_set_vf_link_state(struct wx *wx, int vf, int state)
+{
+	wx->vfinfo[vf].link_state = state;
+	switch (state) {
+	case IFLA_VF_LINK_STATE_AUTO:
+		if (netif_running(wx->netdev))
+			wx->vfinfo[vf].link_enable = true;
+		else
+			wx->vfinfo[vf].link_enable = false;
+		break;
+	case IFLA_VF_LINK_STATE_ENABLE:
+		wx->vfinfo[vf].link_enable = true;
+		break;
+	case IFLA_VF_LINK_STATE_DISABLE:
+		wx->vfinfo[vf].link_enable = false;
+		break;
+	}
+	/* restart the VF */
+	wx->vfinfo[vf].clear_to_send = false;
+	wx_ping_vf(wx, vf);
+
+	wx_set_vf_rx_tx(wx, vf);
+}
+
+void wx_set_all_vfs(struct wx *wx)
+{
+	int i;
+
+	for (i = 0; i < wx->num_vfs; i++)
+		wx_set_vf_link_state(wx, i, wx->vfinfo[i].link_state);
+}
+EXPORT_SYMBOL(wx_set_all_vfs);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.h b/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
index 376d8e0e49f3..8a3a47bb5815 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
@@ -13,5 +13,6 @@ int wx_pci_sriov_configure(struct pci_dev *pdev, int num_vfs);
 void wx_msg_task(struct wx *wx);
 void wx_disable_vf_rx_tx(struct wx *wx);
 void wx_ping_all_vfs_with_link_status(struct wx *wx, bool link_up);
+void wx_set_all_vfs(struct wx *wx);
 
 #endif /* _WX_SRIOV_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 9b9345290594..e13172c9eeed 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1173,6 +1173,7 @@ struct vf_data_storage {
 	u16 vf_mc_hashes[WX_MAX_VF_MC_ENTRIES];
 	u16 num_vf_mc_hashes;
 	u16 vlan_count;
+	int link_state;
 };
 
 struct vf_macvlans {
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index 8658a51ee810..3b9e831cf0ef 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
@@ -7,6 +7,7 @@
 #include "../libwx/wx_type.h"
 #include "../libwx/wx_lib.h"
 #include "../libwx/wx_hw.h"
+#include "../libwx/wx_sriov.h"
 #include "txgbe_type.h"
 #include "txgbe_phy.h"
 #include "txgbe_irq.h"
@@ -109,8 +110,17 @@ static irqreturn_t txgbe_misc_irq_handle(int irq, void *data)
 	struct wx *wx = txgbe->wx;
 	u32 eicr;
 
-	if (wx->pdev->msix_enabled)
+	if (wx->pdev->msix_enabled) {
+		eicr = wx_misc_isb(wx, WX_ISB_MISC);
+		if (!eicr)
+			return IRQ_NONE;
+		txgbe->eicr = eicr;
+		if (eicr & TXGBE_PX_MISC_IC_VF_MBOX) {
+			wx_msg_task(txgbe->wx);
+			wx_intr_enable(wx, TXGBE_INTR_MISC);
+		}
 		return IRQ_WAKE_THREAD;
+	}
 
 	eicr = wx_misc_isb(wx, WX_ISB_VEC0);
 	if (!eicr) {
@@ -129,6 +139,11 @@ static irqreturn_t txgbe_misc_irq_handle(int irq, void *data)
 	q_vector = wx->q_vector[0];
 	napi_schedule_irqoff(&q_vector->napi);
 
+	eicr = wx_misc_isb(wx, WX_ISB_MISC);
+	if (!eicr)
+		return IRQ_NONE;
+	txgbe->eicr = eicr;
+
 	return IRQ_WAKE_THREAD;
 }
 
@@ -140,7 +155,7 @@ static irqreturn_t txgbe_misc_irq_thread_fn(int irq, void *data)
 	unsigned int sub_irq;
 	u32 eicr;
 
-	eicr = wx_misc_isb(wx, WX_ISB_MISC);
+	eicr = txgbe->eicr;
 	if (eicr & (TXGBE_PX_MISC_ETH_LK | TXGBE_PX_MISC_ETH_LKDN |
 		    TXGBE_PX_MISC_ETH_AN)) {
 		sub_irq = irq_find_mapping(txgbe->misc.domain, TXGBE_IRQ_LINK);
@@ -183,7 +198,7 @@ int txgbe_setup_misc_irq(struct txgbe *txgbe)
 	if (wx->mac.type == wx_mac_aml)
 		goto skip_sp_irq;
 
-	txgbe->misc.nirqs = 1;
+	txgbe->misc.nirqs = TXGBE_IRQ_MAX;
 	txgbe->misc.domain = irq_domain_add_simple(NULL, txgbe->misc.nirqs, 0,
 						   &txgbe_misc_irq_domain_ops, txgbe);
 	if (!txgbe->misc.domain)
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index a2e245e3b016..6d9134a3ce4d 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -15,6 +15,8 @@
 #include "../libwx/wx_lib.h"
 #include "../libwx/wx_ptp.h"
 #include "../libwx/wx_hw.h"
+#include "../libwx/wx_mbx.h"
+#include "../libwx/wx_sriov.h"
 #include "txgbe_type.h"
 #include "txgbe_hw.h"
 #include "txgbe_phy.h"
@@ -117,6 +119,12 @@ static void txgbe_up_complete(struct wx *wx)
 
 	/* enable transmits */
 	netif_tx_start_all_queues(netdev);
+
+	/* Set PF Reset Done bit so PF/VF Mail Ops can work */
+	wr32m(wx, WX_CFG_PORT_CTL, WX_CFG_PORT_CTL_PFRSTD,
+	      WX_CFG_PORT_CTL_PFRSTD);
+	/* update setting rx tx for all active vfs */
+	wx_set_all_vfs(wx);
 }
 
 static void txgbe_reset(struct wx *wx)
@@ -165,6 +173,16 @@ static void txgbe_disable_device(struct wx *wx)
 		wx_err(wx, "%s: invalid bus lan id %d\n",
 		       __func__, wx->bus.func);
 
+	if (wx->num_vfs) {
+		/* Clear EITR Select mapping */
+		wr32(wx, WX_PX_ITRSEL, 0);
+		/* Mark all the VFs as inactive */
+		for (i = 0; i < wx->num_vfs; i++)
+			wx->vfinfo[i].clear_to_send = 0;
+		/* update setting rx tx for all active vfs */
+		wx_set_all_vfs(wx);
+	}
+
 	if (!(((wx->subsystem_device_id & WX_NCSI_MASK) == WX_NCSI_SUP) ||
 	      ((wx->subsystem_device_id & WX_WOL_MASK) == WX_WOL_SUP))) {
 		/* disable mac transmiter */
@@ -307,12 +325,15 @@ static int txgbe_sw_init(struct wx *wx)
 	/* set default ring sizes */
 	wx->tx_ring_count = TXGBE_DEFAULT_TXD;
 	wx->rx_ring_count = TXGBE_DEFAULT_RXD;
+	wx->mbx.size = WX_VXMAILBOX_SIZE;
 
 	/* set default work limits */
 	wx->tx_work_limit = TXGBE_DEFAULT_TX_WORK;
 	wx->rx_work_limit = TXGBE_DEFAULT_RX_WORK;
 
+	wx->setup_tc = txgbe_setup_tc;
 	wx->do_reset = txgbe_do_reset;
+	set_bit(0, &wx->fwd_bitmask);
 
 	switch (wx->mac.type) {
 	case wx_mac_sp:
@@ -604,6 +625,10 @@ static int txgbe_probe(struct pci_dev *pdev,
 		goto err_pci_release_regions;
 	}
 
+	/* The sapphire supports up to 63 VFs per pf, but physical
+	 * function also need one pool for basic networking.
+	 */
+	pci_sriov_set_totalvfs(pdev, TXGBE_MAX_VFS_DRV_LIMIT);
 	wx->driver_name = txgbe_driver_name;
 	txgbe_set_ethtool_ops(netdev);
 	netdev->netdev_ops = &txgbe_netdev_ops;
@@ -794,6 +819,7 @@ static void txgbe_remove(struct pci_dev *pdev)
 	struct net_device *netdev;
 
 	netdev = wx->netdev;
+	wx_disable_sriov(wx);
 	unregister_netdev(netdev);
 
 	txgbe_remove_phy(txgbe);
@@ -816,6 +842,7 @@ static struct pci_driver txgbe_driver = {
 	.probe    = txgbe_probe,
 	.remove   = txgbe_remove,
 	.shutdown = txgbe_shutdown,
+	.sriov_configure = wx_pci_sriov_configure,
 };
 
 module_pci_driver(txgbe_driver);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 85f022ceef4f..1863cfd27ee7 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -16,6 +16,8 @@
 #include "../libwx/wx_type.h"
 #include "../libwx/wx_lib.h"
 #include "../libwx/wx_ptp.h"
+#include "../libwx/wx_sriov.h"
+#include "../libwx/wx_mbx.h"
 #include "../libwx/wx_hw.h"
 #include "txgbe_type.h"
 #include "txgbe_phy.h"
@@ -184,6 +186,8 @@ static void txgbe_mac_link_down(struct phylink_config *config,
 	wx->speed = SPEED_UNKNOWN;
 	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
 		wx_ptp_reset_cyclecounter(wx);
+	/* ping all the active vfs to let them know we are going down */
+	wx_ping_all_vfs_with_link_status(wx, false);
 }
 
 static void txgbe_mac_link_up(struct phylink_config *config,
@@ -225,6 +229,8 @@ static void txgbe_mac_link_up(struct phylink_config *config,
 	wx->last_rx_ptp_check = jiffies;
 	if (test_bit(WX_STATE_PTP_RUNNING, wx->state))
 		wx_ptp_reset_cyclecounter(wx);
+	/* ping all the active vfs to let them know we are going up */
+	wx_ping_all_vfs_with_link_status(wx, true);
 }
 
 static int txgbe_mac_prepare(struct phylink_config *config, unsigned int mode,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 9c1c26234cad..5937cbc6bd05 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -77,11 +77,13 @@
 #define TXGBE_PX_MISC_ETH_LK                    BIT(18)
 #define TXGBE_PX_MISC_ETH_AN                    BIT(19)
 #define TXGBE_PX_MISC_INT_ERR                   BIT(20)
+#define TXGBE_PX_MISC_IC_VF_MBOX                BIT(23)
 #define TXGBE_PX_MISC_GPIO                      BIT(26)
 #define TXGBE_PX_MISC_IEN_MASK                            \
 	(TXGBE_PX_MISC_ETH_LKDN | TXGBE_PX_MISC_DEV_RST | \
 	 TXGBE_PX_MISC_ETH_EVENT | TXGBE_PX_MISC_ETH_LK | \
-	 TXGBE_PX_MISC_ETH_AN | TXGBE_PX_MISC_INT_ERR)
+	 TXGBE_PX_MISC_ETH_AN | TXGBE_PX_MISC_INT_ERR | \
+	 TXGBE_PX_MISC_IC_VF_MBOX)
 
 /* Port cfg registers */
 #define TXGBE_CFG_PORT_ST                       0x14404
@@ -174,6 +176,8 @@
 #define TXGBE_SP_RX_PB_SIZE     512
 #define TXGBE_SP_TDB_PB_SZ      (160 * 1024) /* 160KB Packet Buffer */
 
+#define TXGBE_MAX_VFS_DRV_LIMIT                 63
+
 #define TXGBE_DEFAULT_ATR_SAMPLE_RATE           20
 
 /* Software ATR hash keys */
@@ -348,6 +352,7 @@ struct txgbe {
 	struct clk *clk;
 	struct gpio_chip *gpio;
 	unsigned int link_irq;
+	u32 eicr;
 
 	/* flow director */
 	struct hlist_head fdir_filter_list;
-- 
2.48.1


