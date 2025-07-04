Return-Path: <netdev+bounces-204115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B54AF8F2A
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 11:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE37A487E2A
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 09:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6332ED86C;
	Fri,  4 Jul 2025 09:51:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B792ECD27
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 09:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751622709; cv=none; b=Qwyd3ZqAXrVUL/sU7E55XzoQT8sF3SdiNdnom3N+O3EfWmNNjQWewAQlVFcABzu/INZEOzT3hH3V4vrp+iknv3FaV1hxHaUz3LPih7cYUzBfC+Nb1ZdJAkZC7KOjOiF+uFeD31gYZ+QTW30IH3t+mKsQJPGbJ9i+BwR/KKBL5q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751622709; c=relaxed/simple;
	bh=QRDUQWUy1mtmgg1W5ZdwbBbUmrPETZg+BInLRMdGu+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SHFENS5qCcD55y5yD+MBp2+5d1Qta2grkYVqWKtUKRyf1CR0T0InOGReWlapvjSw6JapqZKj3lu/2Bk0cKOwS8ZW6qBkUv6+SCZEgjPOGNX2mcrD0dtou4f1ZZPb4S6zeOo7KUPgRznTq1dQaeXR2LVJg8YQFkxPL92P18TP1Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz1t1751622621te896f5cd
X-QQ-Originating-IP: o5I2oCG0bdz8/OTYsgCc4lwg+A2iy4I2bvlqUH2+aO4=
Received: from localhost.localdomain ( [156.146.53.122])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 04 Jul 2025 17:50:16 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 11958852852574583984
EX-QQ-RecipientCnt: 10
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: michal.swiatkowski@linux.intel.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	duanqiangwen@net-swift.com,
	linglingzhang@trustnetic.com,
	jiawenwu@trustnetic.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v3 06/12] net: txgbevf: init interrupts and request irqs
Date: Fri,  4 Jul 2025 17:49:17 +0800
Message-Id: <20250704094923.652-7-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20250704094923.652-1-mengyuanlou@net-swift.com>
References: <20250704094923.652-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Nbou3Tqew2la8b4UbXSIQNSNGy25iefmn2S1T57RIoIR1nwO/P00h9dL
	AaTM1tan4zCXBCoWEZryHZuViN4XWNvzUEb7M7xMxFEKks4r+SO0YEZVMdmSIqzxrAdfCyx
	NCEhefoSaWYYOEaU2+1TsCNJqnaNiClQDHDxbAjdj5irCJLcPUsKMCU9aZSKaDHdZxZzNQn
	Cnu5UMceVUABWqh+8TDTMZaMoeaJ73Vhi5OClH2ZyMOJHdUvH2nbqBQxoIXnDInDNqK3zBZ
	kbeBIXzOJBmZY6CheXz/LoAmuoxPGNH3IENsP7HCGlzxpgFy+sG0eaBNnZ5wsI5HmhOAIiS
	R/JdKEPoM4VA3IpfPmoQtbJ2npe0KZDcAk4CHvSjE/YSOCrqfLpFGNBXwO3t55F7Wp7zf8Q
	kBmsCxpZ/PLnIlj98h4ONpXtthhmN9CWe5e9D7RS+MODT6Ab4p7sYDlyGeP6dz4WBXsXp1m
	jT6lR+Rw9ZLiIfqzrHzEPhogB7IF0BDMVUWbbf6RwTz3I3IWti3lLictf5TR2WcSZr/7MQ8
	DuwN6tTpGyObkPtz4KO1Kyv2pAD+b5kUM4jZ44VYzfAkcO+pBrD0nrtlyhIkMsrzQ1k8iI+
	HsmE6KzAF+aaV4N1XXo9m/iLlk2qP9C55QRzUiKK8H3gPl4Ad0oudhUidiwo93bru1wo+tG
	8AF4/Vzql2sdndpB9lfUgFojB6XOlQQwrkAOA9QbK0L4MmFUrM970tZe/EaLVTcvGx/d2nC
	3boe1Fps455cb/+8X5FoNe5nPi7TziKsa1XHy9eQbQNw0YmbrvjsD//lyQJaMP7PPV+eEkV
	j5UYhIE/cwz1uIdq1l7C+QwqlGQOvbDkVoeiiqBx9VZ1drOUlTUOzk+zYziLsCgbsmClUGM
	tqBEadrPAl9TkdoG8A2w/JFvGgE7MhZbnToEAc/tTyt2HKzAo7VOB9P3cgQ870lbibw9/wC
	sgzUwYfuFkAwziVjmMGVME3DLX7V5SbaOOc8Rl3g8kGmRaI4/KXlQMOUK+Y3qn1vla7+ZZc
	uXDDI953dIZ/W72WnOZX5Hx3Ibs7GePZCRq6xL6hAERYVlH9y3dOY93ihPq41JCe+aVw/IP
	CZgqEjNS8D/XTr/GG1WzR2OzT0SaqGxFH+3yA5FkTJucnMa2KtZS14=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Add irq alloc flow functions for vf.
Alloc pcie msix irqs for drivers and request_irq for tx/rx rings
and misc other events.
If the application is successful, config vertors for interrupts.
Enable interrupts mask in wxvf_irq_enable.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  6 +++
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  9 +++-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  1 +
 .../net/ethernet/wangxun/libwx/wx_vf_common.c | 40 +++++++++++++++--
 .../ethernet/wangxun/txgbevf/txgbevf_main.c   | 44 +++++++++++++++++++
 .../ethernet/wangxun/txgbevf/txgbevf_type.h   |  2 +
 6 files changed, 97 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 6e830436a19b..58e9d6a38802 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -11,6 +11,7 @@
 #include "wx_type.h"
 #include "wx_lib.h"
 #include "wx_sriov.h"
+#include "wx_vf.h"
 #include "wx_hw.h"
 
 static int wx_phy_read_reg_mdi(struct mii_bus *bus, int phy_addr, int devnum, int regnum)
@@ -124,6 +125,11 @@ void wx_intr_enable(struct wx *wx, u64 qmask)
 {
 	u32 mask;
 
+	if (wx->pdev->is_virtfn) {
+		wr32(wx, WX_VXIMC, qmask);
+		return;
+	}
+
 	mask = (qmask & U32_MAX);
 	if (mask)
 		wr32(wx, WX_PX_IMC(0), mask);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 55e252789db3..0e76be1c8154 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1819,7 +1819,7 @@ static int wx_set_interrupt_capability(struct wx *wx)
 
 	/* We will try to get MSI-X interrupts first */
 	ret = wx_acquire_msix_vectors(wx);
-	if (ret == 0 || (ret == -ENOMEM))
+	if (ret == 0 || (ret == -ENOMEM) || pdev->is_virtfn)
 		return ret;
 
 	/* Disable VMDq support */
@@ -2170,7 +2170,12 @@ int wx_init_interrupt_scheme(struct wx *wx)
 	int ret;
 
 	/* Number of supported queues */
-	wx_set_num_queues(wx);
+	if (wx->pdev->is_virtfn) {
+		if (wx->set_num_queues)
+			wx->set_num_queues(wx);
+	} else {
+		wx_set_num_queues(wx);
+	}
 
 	/* Set interrupt mode */
 	ret = wx_set_interrupt_capability(wx);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 9e5b0d1fcb21..58e9988388a7 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1324,6 +1324,7 @@ struct wx {
 	int (*setup_tc)(struct net_device *netdev, u8 tc);
 	void (*do_reset)(struct net_device *netdev);
 	int (*ptp_setup_sdp)(struct wx *wx);
+	void (*set_num_queues)(struct wx *wx);
 
 	bool pps_enabled;
 	u64 pps_width;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index ed5daeec598a..7442b195425f 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -17,6 +17,7 @@ int wxvf_suspend(struct device *dev_d)
 	struct wx *wx = pci_get_drvdata(pdev);
 
 	netif_device_detach(wx->netdev);
+	wx_clear_interrupt_scheme(wx);
 	pci_disable_device(pdev);
 
 	return 0;
@@ -35,6 +36,7 @@ int wxvf_resume(struct device *dev_d)
 	struct wx *wx = pci_get_drvdata(pdev);
 
 	pci_set_master(pdev);
+	wx_init_interrupt_scheme(wx);
 	netif_device_attach(wx->netdev);
 
 	return 0;
@@ -51,6 +53,7 @@ void wxvf_remove(struct pci_dev *pdev)
 	kfree(wx->vfinfo);
 	kfree(wx->rss_key);
 	kfree(wx->mac_table);
+	wx_clear_interrupt_scheme(wx);
 	pci_release_selected_regions(pdev,
 				     pci_select_bars(pdev, IORESOURCE_MEM));
 	pci_disable_device(pdev);
@@ -93,9 +96,8 @@ int wx_request_msix_irqs_vf(struct wx *wx)
 		}
 	}
 
-	err = request_threaded_irq(wx->msix_entry->vector, NULL,
-				   wx_msix_misc_vf, IRQF_ONESHOT,
-				   netdev->name, wx);
+	err = request_threaded_irq(wx->msix_entry->vector, wx_msix_misc_vf,
+				   NULL, IRQF_ONESHOT, netdev->name, wx);
 	if (err) {
 		wx_err(wx, "request_irq for msix_other failed: %d\n", err);
 		goto free_queue_irqs;
@@ -241,9 +243,35 @@ int wx_set_mac_vf(struct net_device *netdev, void *p)
 }
 EXPORT_SYMBOL(wx_set_mac_vf);
 
+static void wxvf_irq_enable(struct wx *wx)
+{
+	wr32(wx, WX_VXIMC, wx->eims_enable_mask);
+}
+
+static void wxvf_up_complete(struct wx *wx)
+{
+	wx_configure_msix_vf(wx);
+
+	/* clear any pending interrupts, may auto mask */
+	wr32(wx, WX_VXICR, U32_MAX);
+	wxvf_irq_enable(wx);
+}
+
 int wxvf_open(struct net_device *netdev)
 {
+	struct wx *wx = netdev_priv(netdev);
+	int err;
+
+	err = wx_request_msix_irqs_vf(wx);
+	if (err)
+		goto err_reset;
+
+	wxvf_up_complete(wx);
+
 	return 0;
+err_reset:
+	wx_reset_vf(wx);
+	return err;
 }
 EXPORT_SYMBOL(wxvf_open);
 
@@ -251,8 +279,13 @@ static void wxvf_down(struct wx *wx)
 {
 	struct net_device *netdev = wx->netdev;
 
+	netif_tx_stop_all_queues(netdev);
 	netif_tx_disable(netdev);
+	wx_napi_disable_all(wx);
 	wx_reset_vf(wx);
+
+	wx_clean_all_tx_rings(wx);
+	wx_clean_all_rx_rings(wx);
 }
 
 int wxvf_close(struct net_device *netdev)
@@ -260,6 +293,7 @@ int wxvf_close(struct net_device *netdev)
 	struct wx *wx = netdev_priv(netdev);
 
 	wxvf_down(wx);
+	wx_free_irq(wx);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
index 9918d5b2ee57..a61e4a0781cf 100644
--- a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
+++ b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
@@ -10,6 +10,7 @@
 
 #include "../libwx/wx_type.h"
 #include "../libwx/wx_hw.h"
+#include "../libwx/wx_lib.h"
 #include "../libwx/wx_mbx.h"
 #include "../libwx/wx_vf.h"
 #include "../libwx/wx_vf_common.h"
@@ -43,6 +44,39 @@ static const struct net_device_ops txgbevf_netdev_ops = {
 	.ndo_set_mac_address    = wx_set_mac_vf,
 };
 
+static void txgbevf_set_num_queues(struct wx *wx)
+{
+	u32 def_q = 0, num_tcs = 0;
+	u16 rss, queue;
+	int ret = 0;
+
+	/* Start with base case */
+	wx->num_rx_queues = 1;
+	wx->num_tx_queues = 1;
+
+	spin_lock_bh(&wx->mbx.mbx_lock);
+	/* fetch queue configuration from the PF */
+	ret = wx_get_queues_vf(wx, &num_tcs, &def_q);
+	spin_unlock_bh(&wx->mbx.mbx_lock);
+
+	if (ret)
+		return;
+
+	/* we need as many queues as traffic classes */
+	if (num_tcs > 1) {
+		wx->num_rx_queues = num_tcs;
+	} else {
+		rss = min_t(u16, num_online_cpus(), TXGBEVF_MAX_RSS_NUM);
+		queue = min_t(u16, wx->mac.max_rx_queues, wx->mac.max_tx_queues);
+		rss = min_t(u16, queue, rss);
+
+		if (wx->vfinfo->vf_api >= wx_mbox_api_13) {
+			wx->num_rx_queues = rss;
+			wx->num_tx_queues = rss;
+		}
+	}
+}
+
 static void txgbevf_init_type_code(struct wx *wx)
 {
 	switch (wx->device_id) {
@@ -80,6 +114,8 @@ static int txgbevf_sw_init(struct wx *wx)
 	if (err)
 		goto err_init_mbx_params;
 
+	/* max q_vectors */
+	wx->mac.max_msix_vectors = TXGBEVF_MAX_MSIX_VECTORS;
 	/* Initialize the device type */
 	txgbevf_init_type_code(wx);
 	/* lock to protect mailbox accesses */
@@ -116,6 +152,8 @@ static int txgbevf_sw_init(struct wx *wx)
 	wx->tx_work_limit = TXGBEVF_DEFAULT_TX_WORK;
 	wx->rx_work_limit = TXGBEVF_DEFAULT_RX_WORK;
 
+	wx->set_num_queues = txgbevf_set_num_queues;
+
 	return 0;
 err_reset_hw:
 	kfree(wx->vfinfo);
@@ -211,6 +249,10 @@ static int txgbevf_probe(struct pci_dev *pdev,
 	eth_hw_addr_set(netdev, wx->mac.perm_addr);
 	ether_addr_copy(netdev->perm_addr, wx->mac.addr);
 
+	err = wx_init_interrupt_scheme(wx);
+	if (err)
+		goto err_free_sw_init;
+
 	err = register_netdev(netdev);
 	if (err)
 		goto err_register;
@@ -220,6 +262,8 @@ static int txgbevf_probe(struct pci_dev *pdev,
 	return 0;
 
 err_register:
+	wx_clear_interrupt_scheme(wx);
+err_free_sw_init:
 	kfree(wx->vfinfo);
 	kfree(wx->rss_key);
 	kfree(wx->mac_table);
diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_type.h b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_type.h
index 8f4f08ce06c0..1364d2b58bb0 100644
--- a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_type.h
+++ b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_type.h
@@ -14,6 +14,8 @@
 #define TXGBEVF_DEV_ID_AML503F                 0x503f
 #define TXGBEVF_DEV_ID_AML513F                 0x513f
 
+#define TXGBEVF_MAX_MSIX_VECTORS               2
+#define TXGBEVF_MAX_RSS_NUM                    4
 #define TXGBEVF_MAX_RX_QUEUES                  4
 #define TXGBEVF_MAX_TX_QUEUES                  4
 #define TXGBEVF_DEFAULT_TXD                    128
-- 
2.30.1


