Return-Path: <netdev+bounces-201056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 462D8AE7F03
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6B0E189632B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E982628E607;
	Wed, 25 Jun 2025 10:22:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AF627F170
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 10:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846920; cv=none; b=b2zKaqNUIvLErMMq4y4mrx0pwmZqWUCm1adcC0JT24KZbpX7/KwHRH/BlzxyVQtmB/uga2MTTn+gZdhK+HArxSD6cA7emsH5UWKW4Nmsho9wJUCKjRhfI72BsfgSY7f4TkcxKPeOdSzqJ2O82XNtrUj+g2Cpyx1fV3pQXIonTgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846920; c=relaxed/simple;
	bh=ed+94tYvTgOy3AyxA2AogtsVhGPSxMF9q32qhvn8CQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dNOeHJeOCHDAEjvIKxDZ0GJTUB9O+QWYSaBiTiolGuBiVuKjQMWMh7N6i82fPk7nKngZRVCp5zITqVqKEaxBMV03+NOmb1CImkzdSvo1P/NmPlirgUB/IhGl7V37E71HDTeJhfFf95sFL/9IUPEzuiDo38riqxeNnBc+h/pW1Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpgz13t1750846876t849af785
X-QQ-Originating-IP: id9F5xfVbasASQ0PlxUHjZOn6KGcpeFPWg8gvCvyBso=
Received: from localhost.localdomain ( [60.186.80.242])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 25 Jun 2025 18:21:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16906045616979719712
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
	jiawenwu@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v2 06/12] net: txgbevf: init interrupts and request irqs
Date: Wed, 25 Jun 2025 18:20:52 +0800
Message-Id: <20250625102058.19898-7-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20250625102058.19898-1-mengyuanlou@net-swift.com>
References: <20250625102058.19898-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MOelX/8sneipYBntQxxM+2lJfqNUVsc7eSo3TQLvyZp5469Wki1uHhyv
	bnHV5rhHQZ6Lh7LPm2Nyen12uRk4vt6fNZCxUohNAhW5UgBRXOpM08QATSfNoU5q9vr5Alz
	cldYwfdUivRA/lLMLUWWXhWgly/AmsbiApJfgC4XV/R7YHZeWsjZjSDGoAbSd9PsTE/LM9l
	tzEvbC05TpYlpQV/KHZu+kMkw1GMQAwU2jf0aIioDpX/jdnmc7y9ydmmfQXIaTrtPqbWPPu
	YbbTTqy9vW1s5/keb6+mT6RcW3ZnRG/+6mx4Dhj2WsVSHL/OyeFwRZrLitkXbL9yDYluuD+
	cjXDssHuAc/AjPm8wkw3iqyOa/OMPP0NHeDgCFvO0I8sEQg1IpcLJzzwK5CH4w9RBxJUuKF
	AXVv3m3N1Bf42i6ZpnN5T6hwRTfKEjl5jhtCnyZsIsZINSl/xgZktlahdY87WURAEoBr6a4
	KcC5ltz5j5BYohF6/ZrfKQPzUtHFrobkCjQRgO9bbFP/igWmBM/eBr6scBI1FFWL/4cxOsl
	xuOzNXmrpgjCl2tHeveMF6RQyIpUZ+teHNvLLI/9v9YAPSt5+oQmD8LRGLUgBx5OYg9URcM
	wR2ojIyEbtGv4//74UnXIsZuoVWrS+qH4olAmL6kZzMFpwVRwmqwHXGZ+YnncmkHuEMYX8G
	4cTxaVBz+49oIlvswH64CT+Jk5yn4taz6ON1E1u4MEiqsOMj8vqpK3k1/HmWwJzxgwGLHer
	xjJ6DtSniceoByd/NdCantRC8eVtVPK+nY2Fb14cDk2hcxeIgECfrZOf5cqrshgiYnd/q9M
	PXbRX66lozANDleFFfhJLxMXK5gs0CxANNed0ztbtf3kkDdxMVfG1TBbbIGtZqxmv4L73Q8
	iwJSVxhH8Ov42GTLWg9ay/u00vXG5g+elIx1tWSILEn9UAzQTzdPqsndLzm+Wy2KMmg6zoD
	DXTLHO8sKH9CrVG+6lPept7ptq/ag79bESDJahG87RrT75wa3JjHsYdiJuLcHSkBeA7kD4l
	Zw62HPcpNMSK539xBFAt7fnOuF71UB7AL4tC6O+WUbMf9QMdILwbfLLZ55ZCwJ8XMe6yTw4
	uPJH9fQ3IjSxoODgkh9fgHa7aL51id3tA==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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
 .../net/ethernet/wangxun/libwx/wx_vf_common.c | 35 +++++++++++++++
 .../ethernet/wangxun/txgbevf/txgbevf_main.c   | 44 +++++++++++++++++++
 .../ethernet/wangxun/txgbevf/txgbevf_type.h   |  2 +
 6 files changed, 95 insertions(+), 2 deletions(-)

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
index e5822bf5cabc..c00e8db5a29f 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1818,7 +1818,7 @@ static int wx_set_interrupt_capability(struct wx *wx)
 
 	/* We will try to get MSI-X interrupts first */
 	ret = wx_acquire_msix_vectors(wx);
-	if (ret == 0 || (ret == -ENOMEM))
+	if (ret == 0 || (ret == -ENOMEM) || pdev->is_virtfn)
 		return ret;
 
 	/* Disable VMDq support */
@@ -2169,7 +2169,12 @@ int wx_init_interrupt_scheme(struct wx *wx)
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
index 6714c0b88509..4224578b7974 100644
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
@@ -240,9 +243,35 @@ int wx_set_mac_vf(struct net_device *netdev, void *p)
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
 
@@ -250,8 +279,13 @@ static void wxvf_down(struct wx *wx)
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
@@ -259,6 +293,7 @@ int wxvf_close(struct net_device *netdev)
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


