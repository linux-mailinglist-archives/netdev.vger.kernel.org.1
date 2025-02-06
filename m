Return-Path: <netdev+bounces-163486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCE8A2A5F8
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 11:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3FF11889E9D
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 10:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789A722756A;
	Thu,  6 Feb 2025 10:39:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E4922688C
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738838351; cv=none; b=XNTpxoSJGXfaJ7eDmKcfiG/ZxAb81yE96vGEJrJZswdH3u1ChfSo3PFzo4VYhCB+ZIA6qLUgoj211/dORTfHejwnCZHx2Lx9PVqMb2g8GC7LvYnSL1XzmM6sCpLAzmOpQknCgZp5BknJwKV0w5PO3Famd5I3c9FWZvvJZP227CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738838351; c=relaxed/simple;
	bh=foFyiTPntNERNN9jkaF7WIaFPD2jh3bIwRjV4mSWets=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZbNrBPs0xtclAUdIn4itoQhBitzRiiwDcm7y+7Sgp8h1XyOavzEWPdXN7YctAHaLkcVA2LSAUPAoHvKZKOElZPFd4i6ZXv1guoI91jm8kFfcUhjDxuadzkKitrocATbhVShablRZAOHPEsdz7x7NqsGSX5TnvEJA8E/9RTGtWvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp78t1738838319tlx4fe5q
X-QQ-Originating-IP: jKxPy+znLf0ikUVuV8K11IoUwQG/RqJoswFyH87MFk0=
Received: from localhost.localdomain ( [125.120.70.88])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Feb 2025 18:38:37 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 12011417759079770716
From: mengyuanlou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v7 6/6] net: txgbe: add sriov function support
Date: Thu,  6 Feb 2025 18:37:50 +0800
Message-Id: <20250206103750.36064-7-mengyuanlou@net-swift.com>
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
X-QQ-XMAILINFO: NbaNCZAwxYkCIdff6esaCeBbiw0NY0LPQ1rsKkzSYqZ2oq6/tdPJp6+m
	5bXa0u07XYtFqgDS4hSoSeFkLN2rMQdcfebJufiwVaLYvpyNihSiWS3bwzKO/G0d342oGss
	eP2lerzmS1yWOR++cOwQssGfo/rXzA/nZNJvTZukQ0By9gB3t0nlwH1eFpG1F3M2LlbS/mb
	oHwqkdUyv1fQuDoGas2p7LFwDcG+/JdS6tSnjVRwVnkkeMPcio+311qp/Qbbi1QPKHug774
	dxDxNnnj1vtLcpHvmClKbY1PgC9ebahD+EJQ1cXWE2wP41n78iyrivGtJPrJkT1Ipdb29K0
	08KW0CXoGb/PN86sY90Gd5bDz2qvAujBO/+Chb4lVVIElSjeZRni5Gqv48cjwewTkXyfdAx
	hlaKnR8VN1Hf13SskgPT/QDFqoheiivn6LpZTeah0NCySZSAvdpdkhkA6ppr29qtMb89Hv+
	dstTTfWl8OXwMSt+Jy+9bLMXTAtyBOyo3VBLuRmmcwtgplg4Wmee4htjMWt/0n5gGl3PPnD
	PgdWBuOP8w1DDHdXJ1U5JXjNm3/mbnHPcQmH5hlYWwQFHpFZYVCIfEoHsmy29HOJjKVRFPT
	D+5vCpv85siD/DSx9GMmfInTkpvXuLeqoeMnX8uY5eYVffhK+0NSB1qaGctr+hBMztWAeOi
	+qdSaIEybZ2V3amRkirTqnsv/TTADWd+nwVv8pTSlHuQMob9bS1kqbjgh709bXaSSQYFWcm
	7kkjkwParjoXBkz89heSDoBJqZO1hNEpTr+gaFEBPhrFMBcfwYSyXXfawK09Fcs7cni8qo+
	mdumFBBpVU5qneJSp0depn3tYpNutCCxXtfx/QZhVl3CoeHNBSdYpnV0PbukDkk9AO2vSIm
	E554BwPmXi3XXxK9Zr2jQ/OgwPD9h2VenXI3yWRStUTLLbRJXKBUkU5XriHRMWpYdoM2Z5x
	L3DlV2ls/wN8AnBi0oZ9AIVfhjuQMgadLpXztrHXcDdzAMX6d0+tfIybqd+oL4rARq2T5lp
	d9QIiF5rfDgCKoCuQDAN0CGDannHbfW3HM9TCh4FWpt8hejMeg8bDpFqok/aI=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

From: Mengyuan Lou <mengyuanlou@net-swift.com>

Add sriov_configure for driver ops.
Add mailbox handler wx_msg_task for txgbe.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 42 +++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.h |  1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  1 +
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    | 21 ++++++++--
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 28 ++++++++++++-
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |  8 ++++
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  7 +++-
 7 files changed, 103 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
index 744692fb53fa..93d325de33a9 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
@@ -277,6 +277,15 @@ static void wx_clear_vmvir(struct wx *wx, u32 vf)
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
@@ -896,3 +905,36 @@ void wx_ping_all_vfs_with_link_status(struct wx *wx, bool link_up)
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
+	for (i = 0 ; i < wx->num_vfs; i++)
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
index 7d085b1ffd94..f8e8592b5448 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1093,6 +1093,7 @@ struct vf_data_storage {
 	u16 vf_mc_hashes[WX_MAX_VF_MC_ENTRIES];
 	u16 num_vf_mc_hashes;
 	u16 vlan_count;
+	int link_state;
 };
 
 struct vf_macvlans {
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index 0ee73a265545..4e0e12fe1482 100644
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
@@ -177,7 +192,7 @@ int txgbe_setup_misc_irq(struct txgbe *txgbe)
 	struct wx *wx = txgbe->wx;
 	int hwirq, err;
 
-	txgbe->misc.nirqs = 1;
+	txgbe->misc.nirqs = TXGBE_IRQ_MAX;
 	txgbe->misc.domain = irq_domain_add_simple(NULL, txgbe->misc.nirqs, 0,
 						   &txgbe_misc_irq_domain_ops, txgbe);
 	if (!txgbe->misc.domain)
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index f77450268036..d41059cc9b18 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -14,6 +14,8 @@
 #include "../libwx/wx_type.h"
 #include "../libwx/wx_lib.h"
 #include "../libwx/wx_hw.h"
+#include "../libwx/wx_mbx.h"
+#include "../libwx/wx_sriov.h"
 #include "txgbe_type.h"
 #include "txgbe_hw.h"
 #include "txgbe_phy.h"
@@ -99,6 +101,12 @@ static void txgbe_up_complete(struct wx *wx)
 
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
@@ -144,6 +152,16 @@ static void txgbe_disable_device(struct wx *wx)
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
@@ -276,8 +294,11 @@ static int txgbe_sw_init(struct wx *wx)
 	/* set default work limits */
 	wx->tx_work_limit = TXGBE_DEFAULT_TX_WORK;
 	wx->rx_work_limit = TXGBE_DEFAULT_RX_WORK;
+	wx->mbx.size = WX_VXMAILBOX_SIZE;
 
+	wx->setup_tc = txgbe_setup_tc;
 	wx->do_reset = txgbe_do_reset;
+	set_bit(0, &wx->fwd_bitmask);
 
 	return 0;
 }
@@ -551,7 +572,10 @@ static int txgbe_probe(struct pci_dev *pdev,
 		err = -EIO;
 		goto err_pci_release_regions;
 	}
-
+	/* The emerald supports up to 8 VFs per pf, but physical
+	 * function also need one pool for basic networking.
+	 */
+	pci_sriov_set_totalvfs(pdev, TXGBE_MAX_VFS_DRV_LIMIT);
 	wx->driver_name = txgbe_driver_name;
 	txgbe_set_ethtool_ops(netdev);
 	netdev->netdev_ops = &txgbe_netdev_ops;
@@ -742,6 +766,7 @@ static void txgbe_remove(struct pci_dev *pdev)
 	struct net_device *netdev;
 
 	netdev = wx->netdev;
+	wx_disable_sriov(wx);
 	unregister_netdev(netdev);
 
 	txgbe_remove_phy(txgbe);
@@ -764,6 +789,7 @@ static struct pci_driver txgbe_driver = {
 	.probe    = txgbe_probe,
 	.remove   = txgbe_remove,
 	.shutdown = txgbe_shutdown,
+	.sriov_configure = wx_pci_sriov_configure,
 };
 
 module_pci_driver(txgbe_driver);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 1ae68f94dd49..3e7cc9160c00 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -16,6 +16,7 @@
 #include "../libwx/wx_type.h"
 #include "../libwx/wx_lib.h"
 #include "../libwx/wx_hw.h"
+#include "../libwx/wx_sriov.h"
 #include "txgbe_type.h"
 #include "txgbe_phy.h"
 #include "txgbe_hw.h"
@@ -179,6 +180,9 @@ static void txgbe_mac_link_down(struct phylink_config *config,
 	struct wx *wx = phylink_to_wx(config);
 
 	wr32m(wx, WX_MAC_TX_CFG, WX_MAC_TX_CFG_TE, 0);
+	wx->speed = 0;
+	/* ping all the active vfs to let them know we are going down */
+	wx_ping_all_vfs_with_link_status(wx, false);
 }
 
 static void txgbe_mac_link_up(struct phylink_config *config,
@@ -215,6 +219,10 @@ static void txgbe_mac_link_up(struct phylink_config *config,
 	wr32(wx, WX_MAC_PKT_FLT, WX_MAC_PKT_FLT_PR);
 	wdg = rd32(wx, WX_MAC_WDG_TIMEOUT);
 	wr32(wx, WX_MAC_WDG_TIMEOUT, wdg);
+
+	wx->speed = speed;
+	/* ping all the active vfs to let them know we are going up */
+	wx_ping_all_vfs_with_link_status(wx, true);
 }
 
 static int txgbe_mac_prepare(struct phylink_config *config, unsigned int mode,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 629a13e96b85..047f20532214 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -71,11 +71,13 @@
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
@@ -160,6 +162,8 @@
 #define TXGBE_SP_RX_PB_SIZE     512
 #define TXGBE_SP_TDB_PB_SZ      (160 * 1024) /* 160KB Packet Buffer */
 
+#define TXGBE_MAX_VFS_DRV_LIMIT                 63
+
 #define TXGBE_DEFAULT_ATR_SAMPLE_RATE           20
 
 /* Software ATR hash keys */
@@ -334,6 +338,7 @@ struct txgbe {
 	struct clk *clk;
 	struct gpio_chip *gpio;
 	unsigned int link_irq;
+	u32 eicr;
 
 	/* flow director */
 	struct hlist_head fdir_filter_list;
-- 
2.30.1 (Apple Git-130)


