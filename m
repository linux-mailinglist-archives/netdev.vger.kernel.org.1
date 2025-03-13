Return-Path: <netdev+bounces-174762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C55A603A6
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 22:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B78A880A9A
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 21:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA16E1F63FE;
	Thu, 13 Mar 2025 21:47:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB971F5821
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 21:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741902472; cv=none; b=pLdW5owfB4LbWG63rDo+gAZs2SbSgjNneb8287yn+U1/Yp2zqBJ8sRASe3a5EuN832uFBjGFhL/pOfFPtuv3nQiaJVRrRVpwahFEq7TNOuCo36hCahVU0lwe+yd4GVvulZoKyatyd5b1RUC2N/k6bQDDuic8ULyTkoQXseerDGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741902472; c=relaxed/simple;
	bh=zKxcka1+PMoy0RgdtyvE/v7vye8csitvZFAO8TUrUcI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FKuBGhKXEpeOCRVvjPeHILeoZTHZF4dx/+BwtYx9g7BNPhoNnQ12GkCRpnlm6sfC+3CzzOxXnJeaaxRWUJpooI4GSHhbvDW4Z0gXdK7o7u536WeX5mFf/8Dx5xNjvFWIuihGHzHmS+VwVGORmY0fo0mOlPIHOF9hyorU2VkRICc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpip2t1741902449tuzh14y
X-QQ-Originating-IP: jpgxEg5PHnaDowPkzIOqmCdIhZT8+zvcG8Sk4/xMGgo=
Received: from 192.168.1.21 ( [192.168.1.21])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 14 Mar 2025 05:47:27 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 9999341813509881630
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [RESEND,PATCH net-next v8 6/6] net: txgbe: add sriov function support
Date: Fri, 14 Mar 2025 05:46:59 +0800
Message-Id: <20250313214659.2785-7-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20250313214659.2785-1-mengyuanlou@net-swift.com>
References: <20250313214659.2785-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OT1af/FwY+++2RzADU8pe6eX5YkxyWpfC4kWEdcHdk/oAhAli4D9mgZx
	KO1J43TjiLriSBrl3Ae21vE90j6BX48W83CQ50c6f843yXZvm7lOfOK4zRp4sqT3lpYyBBo
	GamkukzQllzaGgVcVWaMO3VaI2gAz243hFxtmkGsP0orSq4F2q+OFgwbURFLjCouP2TvJkX
	EIMJws1oDIMYCLYc8Oglep7TYxPFI83l8aytT8eCcaRamzpiOsdwf8Au0NDvDIUrE+Ob2Lr
	5oY57/ehKfu9KGYa/alxSXG21/X60/9o5GhQdmuC89U4sOVN6t15otadch2JIHUUDTwSo38
	jfVMjPtb5bfvYgDpCR/kXKY2HfbknrnDIKfO9JuPibq52THN353AA5wjkc8Agp4wQwys+ci
	QhETsBssRGEf4HSCb3PW+HhyQqJPJd8mh0BNo3LiN/gWLyXdz1gk5fyTpjbDVVeqsKBXM97
	GR3YiBMLEsb2h/AlO5AzrYsWrWBOXggsDahzu2s8yHDEYuCipl/dcUKwjBdofaCjjSWRfkF
	hxC7raS4NSTHZMz+nSywkwZLP/lanxosh1kY5aLMPc4hNUCNd5yf34fEAiMCr0iudul67Ca
	v9p0k5HUBH9h9obeRhEAye0kDSko4eeafH92287pA1AiCbpt5Mt4ZD1tk6j83y3J5r0Zq1l
	6PyLSLYGdP528dWw2hfqiBEjI8rokTrbPERzBWNPT5qRenQCeoW6N7YeSRbt9t/qvZfv5Md
	ZTJLHUdMj7SsoTWZKArrV3jqq6/VCpbMVKyG8V+3XFsfdCSqzLyPrbnrRPG1deLGowqLtNJ
	bHoOVTx0u5JX269mxMlBnXg1rMeVmKgN1CuxuIWG2e1HDCzFyXKcV9zIvWJ0ShN1yubB3H6
	Z5NufFEaDPu1eaK063+kdlSqRenTGXVbh9nShUWpTlrNWKEj2pRjdq1jhT+HjrNFkIZcJtF
	6GQef6fUPnUESzSw8SKKBf/OQ6j7d13DcuEmxXHuFSvVU8+xAtJSLN+AvwXp5CIq1HXczar
	OdXRVE/fOMdCIi+fKfUy+pYI3vCKbqoRLxmVA8sXbkHE/4IuEA
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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
index 12d263890ad9..bbc4da7f2482 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
@@ -283,6 +283,15 @@ static void wx_clear_vmvir(struct wx *wx, u32 vf)
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
@@ -866,3 +875,36 @@ void wx_ping_all_vfs_with_link_status(struct wx *wx, bool link_up)
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
index 3cbec7fb51bc..1eebaa3eb90e 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
@@ -9,5 +9,6 @@ int wx_pci_sriov_configure(struct pci_dev *pdev, int num_vfs);
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
index 8658a51ee810..280c74a57f6e 100644
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
+		eicr = wx_misc_isb(wx, WX_ISB_MISC) & TXGBE_PX_MISC_IEN_MASK;
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
 
+	eicr = wx_misc_isb(wx, WX_ISB_MISC) & TXGBE_PX_MISC_IEN_MASK;
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
index a2e245e3b016..239270c28a89 100644
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
+		for (i = 0 ; i < wx->num_vfs; i++)
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
2.30.1 (Apple Git-130)


