Return-Path: <netdev+bounces-115533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93229946EBD
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 14:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8A628199F
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 12:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5E01EB31;
	Sun,  4 Aug 2024 12:49:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C60B1DFF0
	for <netdev@vger.kernel.org>; Sun,  4 Aug 2024 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722775759; cv=none; b=GIs8vqD2qyOnqdjZItRaqVTF5AaMqYBoxSP687AtufK14q4QVbMGzlfG0OyhA8WKw14+57AmoRG8mOFJkpE62PHxjZcP9kJqxPTvM35ATdy0vPseRA0RmWpSv4zBaBAXFojUuLzW+yI4yh8tsuLkLhDmGBIC1il0Obgw/SA+7sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722775759; c=relaxed/simple;
	bh=ss7TiZYnQ7o5LCIrumgMAkIPmStw+rp9+Q/W6m/d8J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BjFK7koPrQAZVWjAIX0h/cwE15dZlNMeQKJgTvHYuN2nACrjhMmmhIqMcDrO46L3UuhPJ+qkzmB7hKSW78PHeRCIDcExm8bbbtSO/Q8IIHxhvdFVYSG1QNRSxk7SHBNTjCcgzlt9eySo2sDvnkXcXPKFuM9JHWJpfLKMEQvNUqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp85t1722775749t0km1js1
X-QQ-Originating-IP: fMCHlyZP0JDs0qhfHuL+cxviezswY/Cw/6fFdV1hUOU=
Received: from localhost.localdomain ( [101.71.135.53])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 04 Aug 2024 20:49:08 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 3911433554021782640
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v5 06/10] net: txgbe: add sriov function support
Date: Sun,  4 Aug 2024 20:48:37 +0800
Message-ID: <134E28388D6969AC+20240804124841.71177-7-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240804124841.71177-1-mengyuanlou@net-swift.com>
References: <20240804124841.71177-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0

Add sriov_configure for driver ops.
Add ndo_vf_ops for txgbe netdev ops.
Add mailbox handler wx_msg_task for txgbe.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 42 +++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.h |  1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  1 +
 .../net/ethernet/wangxun/txgbe/txgbe_irq.c    | 21 ++++++++--
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 23 ++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |  8 ++++
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  4 +-
 7 files changed, 96 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
index 26f9cce454b2..08738738d02e 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
@@ -292,6 +292,15 @@ static void wx_clear_vmvir(struct wx *wx, u32 vf)
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
@@ -911,3 +920,36 @@ void wx_ping_all_vfs_with_link_status(struct wx *wx, bool link_up)
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
index fa1b2b0ecf0a..2aa68947c0d3 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
@@ -9,5 +9,6 @@ int wx_pci_sriov_configure(struct pci_dev *pdev, int num_vfs);
 void wx_msg_task(struct wx *wx);
 void wx_disable_vf_rx_tx(struct wx *wx);
 void wx_ping_all_vfs_with_link_status(struct wx *wx, bool link_up);
+void wx_set_all_vfs(struct wx *wx);
 
 #endif /* _WX_SRIOV_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index a7d2a27316e4..e50a75e7c58b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1098,6 +1098,7 @@ struct vf_data_storage {
 	u16 vf_mc_hashes[WX_MAX_VF_MC_ENTRIES];
 	u16 num_vf_mc_hashes;
 	u16 vlan_count;
+	int link_state;
 };
 
 struct vf_macvlans {
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index a4cf682dca65..0d414e92ba0b 100644
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
@@ -117,8 +118,17 @@ static irqreturn_t txgbe_misc_irq_handle(int irq, void *data)
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
@@ -137,6 +147,11 @@ static irqreturn_t txgbe_misc_irq_handle(int irq, void *data)
 	q_vector = wx->q_vector[0];
 	napi_schedule_irqoff(&q_vector->napi);
 
+	eicr = wx_misc_isb(wx, WX_ISB_MISC) & TXGBE_PX_MISC_IEN_MASK;
+	if (!eicr)
+		return IRQ_NONE;
+	txgbe->eicr = eicr;
+
 	return IRQ_WAKE_THREAD;
 }
 
@@ -148,7 +163,7 @@ static irqreturn_t txgbe_misc_irq_thread_fn(int irq, void *data)
 	unsigned int sub_irq;
 	u32 eicr;
 
-	eicr = wx_misc_isb(wx, WX_ISB_MISC);
+	eicr = txgbe->eicr;
 	if (eicr & TXGBE_PX_MISC_GPIO) {
 		sub_irq = irq_find_mapping(txgbe->misc.domain, TXGBE_IRQ_GPIO);
 		handle_nested_irq(sub_irq);
@@ -191,7 +206,7 @@ int txgbe_setup_misc_irq(struct txgbe *txgbe)
 	struct wx *wx = txgbe->wx;
 	int hwirq, err;
 
-	txgbe->misc.nirqs = 2;
+	txgbe->misc.nirqs = TXGBE_IRQ_MAX;
 	txgbe->misc.domain = irq_domain_add_simple(NULL, txgbe->misc.nirqs, 0,
 						   &txgbe_misc_irq_domain_ops, txgbe);
 	if (!txgbe->misc.domain)
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 93180225a6f1..c95d0611cf25 100644
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
@@ -100,6 +102,12 @@ static void txgbe_up_complete(struct wx *wx)
 
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
@@ -145,6 +153,16 @@ static void txgbe_disable_device(struct wx *wx)
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
@@ -277,8 +295,11 @@ static int txgbe_sw_init(struct wx *wx)
 	/* set default work limits */
 	wx->tx_work_limit = TXGBE_DEFAULT_TX_WORK;
 	wx->rx_work_limit = TXGBE_DEFAULT_RX_WORK;
+	wx->mbx.size = WX_VXMAILBOX_SIZE;
 
+	wx->setup_tc = txgbe_setup_tc;
 	wx->do_reset = txgbe_do_reset;
+	set_bit(0, &wx->fwd_bitmask);
 
 	return 0;
 }
@@ -743,6 +764,7 @@ static void txgbe_remove(struct pci_dev *pdev)
 	struct net_device *netdev;
 
 	netdev = wx->netdev;
+	wx_disable_sriov(wx);
 	unregister_netdev(netdev);
 
 	txgbe_remove_phy(txgbe);
@@ -765,6 +787,7 @@ static struct pci_driver txgbe_driver = {
 	.probe    = txgbe_probe,
 	.remove   = txgbe_remove,
 	.shutdown = txgbe_shutdown,
+	.sriov_configure = wx_pci_sriov_configure,
 };
 
 module_pci_driver(txgbe_driver);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 5f502265f0a6..76635d4366e4 100644
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
index 959102c4c379..6a95423bb253 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -71,12 +71,13 @@
 #define TXGBE_PX_MISC_ETH_LK                    BIT(18)
 #define TXGBE_PX_MISC_ETH_AN                    BIT(19)
 #define TXGBE_PX_MISC_INT_ERR                   BIT(20)
+#define TXGBE_PX_MISC_IC_VF_MBOX                BIT(23)
 #define TXGBE_PX_MISC_GPIO                      BIT(26)
 #define TXGBE_PX_MISC_IEN_MASK                            \
 	(TXGBE_PX_MISC_ETH_LKDN | TXGBE_PX_MISC_DEV_RST | \
 	 TXGBE_PX_MISC_ETH_EVENT | TXGBE_PX_MISC_ETH_LK | \
 	 TXGBE_PX_MISC_ETH_AN | TXGBE_PX_MISC_INT_ERR |   \
-	 TXGBE_PX_MISC_GPIO)
+	 TXGBE_PX_MISC_IC_VF_MBOX | TXGBE_PX_MISC_GPIO)
 
 /* Port cfg registers */
 #define TXGBE_CFG_PORT_ST                       0x14404
@@ -337,6 +338,7 @@ struct txgbe {
 	struct gpio_chip *gpio;
 	unsigned int gpio_irq;
 	unsigned int link_irq;
+	u32 eicr;
 
 	/* flow director */
 	struct hlist_head fdir_filter_list;
-- 
2.45.2


