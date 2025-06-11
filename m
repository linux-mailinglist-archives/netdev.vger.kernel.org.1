Return-Path: <netdev+bounces-196459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61872AD4E8E
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A10F3A80C9
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22F024291B;
	Wed, 11 Jun 2025 08:37:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7660522F75D
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 08:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749631027; cv=none; b=kDvh2aukJSXyeM8DsrLwB3eGWF62UNoHtOv5YjM9Fo0IC+MCzAlUCUBIoM5o/Le1NXVyBdxsw8KjHl1J8gd1s+9uQDfDZW5FC7rA0FtafYsnTX4FtQ5P5iQYZWUmssKnz6r2b58i0BbnSmAYVZ6sjORgpNn558JIU0pAn0qn1VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749631027; c=relaxed/simple;
	bh=S9ggvBBQgNE775A/XYMgPYK2AUui1REsiBxbbeRx7LE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JOcwxXtm/sBDw8/ZDRuCeeEumf35VJOZBuBGcn3FNo9Ghq/d9fVRwNJ/ovs9LBfM+cQb7IY5GLRSrev2nNScBndsggf80n0kfW+bvLBTLzPKpjHf5yGtbxHK6xcQrENIiTOAI6uQ3ZFHumoSaXGIMVrmXqHRwziqySR1OYbCSHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpgz1t1749630978t11ead7c9
X-QQ-Originating-IP: YCJtC7Ot84WKFHpMt2kMeY/Yp2d1/4BeuKRkhKOmdA4=
Received: from localhost.localdomain ( [36.20.60.58])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Jun 2025 16:36:17 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 5225608787540990697
EX-QQ-RecipientCnt: 9
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	duanqiangwen@net-swift.com,
	linglingzhang@trustnetic.com,
	jiawenwu@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next 06/12] net: txgbevf: init interrupts and request irqs
Date: Wed, 11 Jun 2025 16:35:53 +0800
Message-Id: <20250611083559.14175-7-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20250611083559.14175-1-mengyuanlou@net-swift.com>
References: <20250611083559.14175-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NSrFxT2YipI0M36kS8OYo9j+ZXp5sGugxmhXnJWgga7gEyiHTPX6ru43
	JRjOCuNeWlDyrZAATZvF5YeQ99MxsrYKOd3Nd59pHk0XW6/TgjNb654sNpA8z0BkypeM1CM
	H1qzZ3BoUIQwJIQbu12JSWEUS4hkYtGCW8l0oxILEVD3XTqqSV8Kq0aOZ8pXhMpBQO5BMAF
	nts5glOBLa7Tyq/Y0LgkjKV5L30OpnBT4v5y86uZN2nccAUXMb+ui0JoBiU2mcRkLG1bgKV
	IC11DUCXrzWcXRbX5I9aTOE5y0vN5wTs3S6rBMUGDHxyphbd4F5z+BByL6fEXzs29xeGFg9
	CUbOuRCjHA0aDYA/D5FAjTt2w0v45p6c0SzwgCmGxSzSUaX+862gLl0NiBjI82muEZeFCZX
	w0kGq6TYDzAozekhL075FjeNZjHcV9yPd0/dRaQoahUK+Vf+XAROhHfI2GrWkJaJqZy0Xgg
	mMRVlERc1TME9Likw2LLFGBrpnm1gOZmTFWPZSJM+NiU2Gkvwvx8tdxhLM0p+vE4dcpQwtN
	8eH4TIhjEzHLLtx4VKf2lEQVVtpKncIcsYdmDWQKabYkxujeGowjkib9U+dvC61qJ9Cr1zE
	7n0qfzImTGkz4taPaib71KEl7KYuddS/+sSRLyiczf7krkVXNSQKeMYR/F5sbnTjBHv1K4P
	+59LqgyUhTwHfqoS99KLRgiZEpSt+5LIpJt7Bm0dOe6T1/VEgfF11czVQf6fZcCaSqwgxyB
	LYi4D3bWhIKSSRxgHvYS9h8jk3fsuKgLMp1v7y6OaiEuqy9/DKktTgnne0j1nsUG8UcIDE/
	eqxw6Wh2ABwDuTfhxU5qmZbbKASiZTvfcMyIAMk/xW28KG2NLEs84HpM4vewH6RW6TATJin
	q+GJWCV9Aco7YQBK46vKPwiTeSTKjedlvzxQSc95fnEBWfZp0Jkekg/d8DtOazkkYI7/eIm
	myik8EruauFg8A5FIYzfABb1/P78O7UqfWh3aKHycWU3+7Q5baKKgjyoLaKv+xMqktwtDv7
	JGPvRv55q566S/CofZ5f5KNRAjTvlhly+tPyvyM4MRDxD3W0VbBxm+n6pjIZ53eYP8+bMPW
	yXCSFkt0WveMFevFEojYfnkpUuKi5pNpDT978bUH1jW2IVC9mb2jzuQNaFZT1Bs2Q==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Add irq alloc flow functions for vf.
Alloc pcie msix irqs for drivers and request_irq for tx/rx rings
and misc other events.
If the application is successful, config vertors for interrupts.
Enable interrupts mask in wxvf_irq_enable.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  6 +++
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 29 +++++++++---
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  1 +
 .../net/ethernet/wangxun/libwx/wx_vf_common.c | 35 ++++++++++++++
 .../ethernet/wangxun/txgbevf/txgbevf_main.c   | 47 +++++++++++++++++++
 .../ethernet/wangxun/txgbevf/txgbevf_type.h   |  2 +
 6 files changed, 113 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 6e830436a19b..fe358a6329fa 100644
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
+		wr32(wx, WX_VXIMC, qmask >> 1);
+		return;
+	}
+
 	mask = (qmask & U32_MAX);
 	if (mask)
 		wr32(wx, WX_PX_IMC(0), mask);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 5c747509d56b..8c0ee4ed9601 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1783,12 +1783,22 @@ static int wx_acquire_msix_vectors(struct wx *wx)
 		return nvecs;
 	}
 
-	wx->msix_entry->entry = 0;
-	wx->msix_entry->vector = pci_irq_vector(wx->pdev, 0);
 	nvecs -= 1;
-	for (i = 0; i < nvecs; i++) {
-		wx->msix_q_entries[i].entry = i;
-		wx->msix_q_entries[i].vector = pci_irq_vector(wx->pdev, i + 1);
+	/* VF has a fixed interrupt mapping. */
+	if (wx->pdev->is_virtfn) {
+		for (i = 0; i < nvecs; i++) {
+			wx->msix_q_entries[i].entry = i;
+			wx->msix_q_entries[i].vector = pci_irq_vector(wx->pdev, i);
+		}
+		wx->msix_entry->entry = i;
+		wx->msix_entry->vector = pci_irq_vector(wx->pdev, i);
+	} else {
+		wx->msix_entry->entry = 0;
+		wx->msix_entry->vector = pci_irq_vector(wx->pdev, 0);
+		for (i = 0; i < nvecs; i++) {
+			wx->msix_q_entries[i].entry = i;
+			wx->msix_q_entries[i].vector = pci_irq_vector(wx->pdev, i + 1);
+		}
 	}
 
 	wx->num_q_vectors = nvecs;
@@ -1810,7 +1820,7 @@ static int wx_set_interrupt_capability(struct wx *wx)
 
 	/* We will try to get MSI-X interrupts first */
 	ret = wx_acquire_msix_vectors(wx);
-	if (ret == 0 || (ret == -ENOMEM))
+	if (ret == 0 || (ret == -ENOMEM) || pdev->is_virtfn)
 		return ret;
 
 	/* Disable VMDq support */
@@ -2161,7 +2171,12 @@ int wx_init_interrupt_scheme(struct wx *wx)
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
index 63bb7785fd19..ba5608416c4e 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1323,6 +1323,7 @@ struct wx {
 	int (*setup_tc)(struct net_device *netdev, u8 tc);
 	void (*do_reset)(struct net_device *netdev);
 	int (*ptp_setup_sdp)(struct wx *wx);
+	void (*set_num_queues)(struct wx *wx);
 
 	bool pps_enabled;
 	u64 pps_width;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index 88e9ceeeecb9..c01ff91a057d 100644
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
@@ -239,9 +242,35 @@ int wx_set_mac_vf(struct net_device *netdev, void *p)
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
 
@@ -249,8 +278,13 @@ static void wxvf_down(struct wx *wx)
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
@@ -258,6 +292,7 @@ int wxvf_close(struct net_device *netdev)
 	struct wx *wx = netdev_priv(netdev);
 
 	wxvf_down(wx);
+	wx_free_irq(wx);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
index 9918d5b2ee57..64f171423b23 100644
--- a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
+++ b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
@@ -10,6 +10,7 @@
 
 #include "../libwx/wx_type.h"
 #include "../libwx/wx_hw.h"
+#include "../libwx/wx_lib.h"
 #include "../libwx/wx_mbx.h"
 #include "../libwx/wx_vf.h"
 #include "../libwx/wx_vf_common.h"
@@ -43,6 +44,42 @@ static const struct net_device_ops txgbevf_netdev_ops = {
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
+		switch (wx->vfinfo->vf_api) {
+		case wx_mbox_api_13:
+			wx->num_rx_queues = rss;
+			wx->num_tx_queues = rss;
+		default:
+			break;
+		}
+	}
+}
+
 static void txgbevf_init_type_code(struct wx *wx)
 {
 	switch (wx->device_id) {
@@ -80,6 +117,8 @@ static int txgbevf_sw_init(struct wx *wx)
 	if (err)
 		goto err_init_mbx_params;
 
+	/* max q_vectors */
+	wx->mac.max_msix_vectors = TXGBEVF_MAX_MSIX_VECTORS;
 	/* Initialize the device type */
 	txgbevf_init_type_code(wx);
 	/* lock to protect mailbox accesses */
@@ -116,6 +155,8 @@ static int txgbevf_sw_init(struct wx *wx)
 	wx->tx_work_limit = TXGBEVF_DEFAULT_TX_WORK;
 	wx->rx_work_limit = TXGBEVF_DEFAULT_RX_WORK;
 
+	wx->set_num_queues = txgbevf_set_num_queues;
+
 	return 0;
 err_reset_hw:
 	kfree(wx->vfinfo);
@@ -211,6 +252,10 @@ static int txgbevf_probe(struct pci_dev *pdev,
 	eth_hw_addr_set(netdev, wx->mac.perm_addr);
 	ether_addr_copy(netdev->perm_addr, wx->mac.addr);
 
+	err = wx_init_interrupt_scheme(wx);
+	if (err)
+		goto err_free_sw_init;
+
 	err = register_netdev(netdev);
 	if (err)
 		goto err_register;
@@ -220,6 +265,8 @@ static int txgbevf_probe(struct pci_dev *pdev,
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


