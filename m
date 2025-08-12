Return-Path: <netdev+bounces-212836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19475B22384
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 11:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB0A1AA6FEF
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 09:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D822EAB93;
	Tue, 12 Aug 2025 09:41:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1042EA742;
	Tue, 12 Aug 2025 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754991677; cv=none; b=Bu9uG0necHj/Cmq14dPIlJJvc+BFhfpCEVoxAfIYk2OBmseXx7MW8Uz+Fd+OGUu/+AGt3lqtrE30q7oTRFBFBinbgy8UkAR1uG6is5kEPDY9DwmEVHDX1Qi7waQc+0p8m6Ir182qBqiGdR5X72v5D9mw84w/igmi0N+HAHXkgiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754991677; c=relaxed/simple;
	bh=x+8JQIzs39c/sl0WNNc79kf1WiWYD2N9yzAZgzCUBLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rFVE4AdP0Hx09RQQZD8qCpOxvQk06jYTVNEQjcnKWazcGqmq9izgRnmAsdVQK5u1w1UINjcP1vB7hE/naMBsKnAuI1l6WA4fQv1p6WLM6chg+qH5olRFtwjrzebCdsIiG1o/Z/6MPLyxJVYJQA8Llj/625M9c0Zw3PdtO5PAy78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz7t1754991605t738a8eb6
X-QQ-Originating-IP: msc+yomllWiNlgpE+l6ZmFuuhrRy1sy/yl0PJf+aS14=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 Aug 2025 17:40:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 750351070740526713
EX-QQ-RecipientCnt: 23
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	gur.stavi@huawei.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	danishanwar@ti.com,
	lee@trager.us,
	gongfan1@huawei.com,
	lorenzo@kernel.org,
	geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com,
	lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com,
	richardcochran@gmail.com
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH v3 2/5] net: rnpgbe: Add n500/n210 chip support
Date: Tue, 12 Aug 2025 17:39:34 +0800
Message-Id: <20250812093937.882045-3-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250812093937.882045-1-dong100@mucse.com>
References: <20250812093937.882045-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Odky5wNUcHo/oezA3GJ4WU9M+r3Q+LdBKRLfg2YABl1XiIVqNqmR0H1Q
	fc8Coc4DNOc2ZGQ6GROK6m8bbUyUn7xDTOmiyFDOje20uYZ7/E8hUoVhLdpniv7YGip3vkJ
	4aVnL+BOfF+caaMuKu7DYCu8n1HE6vKEsadxNcMEC7WdYGAc2cERa04wuC89snch0x4YjKC
	qC9Ao64woX2AyNPUFotGns0WBWiSM7lfOBiCIGHAtFgvbw9eKmfX6b0TipYcFSYDBz9KxsZ
	Ggu3WCn9r6NUgXOtm30EWFeVM54PWRWTTxMp1jLCRB7orddQbepPkXL/SFFl3cCY2QAJOQ/
	5N9lRy9+8wD0vL7hAQbjru+96eG8xZv/f29pRxdF643TkbQe4UexlUC/Mf7GZJuu36hcRBc
	xoAVqmJh1QIwdG7BMJ0k0VPykeUI7TLvhF6f0xMH3neVq6hdccNGAn3ZhrP0Py99ITKulPL
	Ld0fF1JYIT9pHBtL/sxKFyY6x6M9n4fjCm7D5Lj5On0akAMTmmBgqeycjQrM+MKJ0pKrF1b
	cBA5dHaihbz9aGaqyZbMk4I0j+5FaR+hFMDZhclmpB1B+r2ZScGucXgfOC/fwT9Jv57I2Uq
	1LLhjDtGzSU0UGeNPqalDknfxazfv3AbahFmg0umH0tss1bqacN7o2bn4lL5On38JxDJ2X6
	n0+b/aKLhmIWZ3713ryLVXkmiEiIWAvzjYbQSKc9ikHf9g4UfFXswk5YS33gPVJxDFHcunN
	/MqscitKMpf6W7TOqeLDx/+b46Gc6LmpRgs4cAreOxXJFnoVud/KU4EDermnDSKckt25csQ
	2pEZOFBIa9AB9X7YFc9TtU6bkQl1GKqIJSI7a5ENuiisXWVE3TIhEVt5o5RuGiEcWoL1gWA
	QIG1jdDW+DZvnPI9CQYEIK/AityUq91str8DM6JfBi3mk0xWKJ16V3Q6QtM98pEcN/0oTSm
	ENYOWybE3M9x6y2pqvsg0HeILueLMUbgSn647bqloFeN/+9LLgAAwFa7ySNbqU8by+dra/+
	sfxDaMHzDbdmN3j4AopGzQmXy3Zd5K+X+Qyo01WA==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Initialize n500/n210 chip bar resource map and
dma, eth, mbx ... info for future use.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  60 +++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  88 ++++++++++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  12 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 115 ++++++++++++++++++
 5 files changed, 277 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h

diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
index 9df536f0d04c..42c359f459d9 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/Makefile
+++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
@@ -5,4 +5,5 @@
 #
 
 obj-$(CONFIG_MGBE) += rnpgbe.o
-rnpgbe-objs := rnpgbe_main.o
+rnpgbe-objs := rnpgbe_main.o\
+	       rnpgbe_chip.o
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 23c84454e7c7..0dd3d3cb2a4d 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -4,18 +4,78 @@
 #ifndef _RNPGBE_H
 #define _RNPGBE_H
 
+#include <linux/types.h>
+
+extern const struct rnpgbe_info rnpgbe_n500_info;
+extern const struct rnpgbe_info rnpgbe_n210_info;
+extern const struct rnpgbe_info rnpgbe_n210L_info;
+
 enum rnpgbe_boards {
 	board_n500,
 	board_n210,
 	board_n210L,
 };
 
+enum rnpgbe_hw_type {
+	rnpgbe_hw_n500 = 0,
+	rnpgbe_hw_n210,
+	rnpgbe_hw_n210L,
+	rnpgbe_hw_unknow
+};
+
+struct mucse_dma_info {
+	void __iomem *dma_base_addr;
+	void __iomem *dma_ring_addr;
+	void *back;
+	u32 dma_version;
+};
+
+struct mucse_eth_info {
+	void __iomem *eth_base_addr;
+	void *back;
+};
+
+struct mucse_mac_info {
+	void __iomem *mac_addr;
+	void *back;
+};
+
+struct mucse_mbx_info {
+	/* fw <--> pf mbx */
+	u32 fw_pf_shm_base;
+	u32 pf2fw_mbox_ctrl;
+	u32 pf2fw_mbox_mask;
+	u32 fw_pf_mbox_mask;
+	u32 fw2pf_mbox_vec;
+};
+
+struct mucse_hw {
+	void *back;
+	void __iomem *hw_addr;
+	void __iomem *ring_msix_base;
+	struct pci_dev *pdev;
+	enum rnpgbe_hw_type hw_type;
+	struct mucse_dma_info dma;
+	struct mucse_eth_info eth;
+	struct mucse_mac_info mac;
+	struct mucse_mbx_info mbx;
+	u32 driver_version;
+	u16 usecstocount;
+};
+
 struct mucse {
 	struct net_device *netdev;
 	struct pci_dev *pdev;
+	struct mucse_hw hw;
 	u16 bd_number;
 };
 
+struct rnpgbe_info {
+	int total_queue_pair_cnts;
+	enum rnpgbe_hw_type hw_type;
+	void (*init)(struct mucse_hw *hw);
+};
+
 /* Device IDs */
 #define PCI_VENDOR_ID_MUCSE 0x8848
 #define PCI_DEVICE_ID_N500_QUAD_PORT 0x8308
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
new file mode 100644
index 000000000000..20ec67c9391e
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#include "rnpgbe.h"
+#include "rnpgbe_hw.h"
+
+/**
+ * rnpgbe_init_common - Setup common attribute
+ * @hw: hw information structure
+ **/
+static void rnpgbe_init_common(struct mucse_hw *hw)
+{
+	struct mucse_dma_info *dma = &hw->dma;
+	struct mucse_eth_info *eth = &hw->eth;
+	struct mucse_mac_info *mac = &hw->mac;
+
+	dma->dma_base_addr = hw->hw_addr;
+	dma->dma_ring_addr = hw->hw_addr + RNPGBE_RING_BASE;
+	dma->back = hw;
+
+	eth->eth_base_addr = hw->hw_addr + RNPGBE_ETH_BASE;
+	eth->back = hw;
+
+	mac->mac_addr = hw->hw_addr + RNPGBE_MAC_BASE;
+	mac->back = hw;
+}
+
+/**
+ * rnpgbe_init_n500 - Setup n500 hw info
+ * @hw: hw information structure
+ *
+ * rnpgbe_init_n500 initializes all private
+ * structure, such as dma, eth, mac and mbx base on
+ * hw->addr for n500
+ **/
+static void rnpgbe_init_n500(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+
+	rnpgbe_init_common(hw);
+
+	mbx->fw2pf_mbox_vec = 0x28b00;
+	mbx->fw_pf_shm_base = 0x2d000;
+	mbx->pf2fw_mbox_ctrl = 0x2e000;
+	mbx->fw_pf_mbox_mask = 0x2e200;
+	hw->ring_msix_base = hw->hw_addr + 0x28700;
+	hw->usecstocount = 125;
+}
+
+/**
+ * rnpgbe_init_n210 - Setup n210 hw info
+ * @hw: hw information structure
+ *
+ * rnpgbe_init_n210 initializes all private
+ * structure, such as dma, eth, mac and mbx base on
+ * hw->addr for n210
+ **/
+static void rnpgbe_init_n210(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+
+	rnpgbe_init_common(hw);
+
+	mbx->fw2pf_mbox_vec = 0x29400;
+	mbx->fw_pf_shm_base = 0x2d900;
+	mbx->pf2fw_mbox_ctrl = 0x2e900;
+	mbx->fw_pf_mbox_mask = 0x2eb00;
+	hw->ring_msix_base = hw->hw_addr + 0x29000;
+	hw->usecstocount = 62;
+}
+
+const struct rnpgbe_info rnpgbe_n500_info = {
+	.total_queue_pair_cnts = RNPGBE_MAX_QUEUES,
+	.hw_type = rnpgbe_hw_n500,
+	.init = &rnpgbe_init_n500,
+};
+
+const struct rnpgbe_info rnpgbe_n210_info = {
+	.total_queue_pair_cnts = RNPGBE_MAX_QUEUES,
+	.hw_type = rnpgbe_hw_n210,
+	.init = &rnpgbe_init_n210,
+};
+
+const struct rnpgbe_info rnpgbe_n210L_info = {
+	.total_queue_pair_cnts = RNPGBE_MAX_QUEUES,
+	.hw_type = rnpgbe_hw_n210L,
+	.init = &rnpgbe_init_n210,
+};
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
new file mode 100644
index 000000000000..fc57258537cf
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#ifndef _RNPGBE_HW_H
+#define _RNPGBE_HW_H
+
+#define RNPGBE_RING_BASE 0x1000
+#define RNPGBE_MAC_BASE 0x20000
+#define RNPGBE_ETH_BASE 0x10000
+/**************** CHIP Resource ****************************/
+#define RNPGBE_MAX_QUEUES 8
+#endif /* _RNPGBE_HW_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index c2e099bd2639..c151995309f8 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -4,10 +4,17 @@
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
 
 #include "rnpgbe.h"
 
 static const char rnpgbe_driver_name[] = "rnpgbe";
+static const struct rnpgbe_info *rnpgbe_info_tbl[] = {
+	[board_n500] = &rnpgbe_n500_info,
+	[board_n210] = &rnpgbe_n210_info,
+	[board_n210L] = &rnpgbe_n210L_info,
+};
 
 /* rnpgbe_pci_tbl - PCI Device ID Table
  *
@@ -27,6 +34,85 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
 	{0, },
 };
 
+/**
+ * rnpgbe_add_adapter - Add netdev for this pci_dev
+ * @pdev: PCI device information structure
+ * @info: chip info structure
+ *
+ * rnpgbe_add_adapter initializes a netdev for this pci_dev
+ * structure. Initializes Bar map, private structure, and a
+ * hardware reset occur.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int rnpgbe_add_adapter(struct pci_dev *pdev,
+			      const struct rnpgbe_info *info)
+{
+	struct net_device *netdev;
+	void __iomem *hw_addr;
+	static int bd_number;
+	struct mucse *mucse;
+	struct mucse_hw *hw;
+	u32 dma_version = 0;
+	u32 queues;
+	int err;
+
+	queues = info->total_queue_pair_cnts;
+	netdev = alloc_etherdev_mq(sizeof(struct mucse), queues);
+	if (!netdev)
+		return -ENOMEM;
+
+	SET_NETDEV_DEV(netdev, &pdev->dev);
+	mucse = netdev_priv(netdev);
+	mucse->netdev = netdev;
+	mucse->pdev = pdev;
+	mucse->bd_number = bd_number++;
+	pci_set_drvdata(pdev, mucse);
+
+	hw = &mucse->hw;
+	hw->back = mucse;
+	hw->hw_type = info->hw_type;
+	hw->pdev = pdev;
+
+	switch (hw->hw_type) {
+	case rnpgbe_hw_n500:
+		hw_addr = devm_ioremap(&pdev->dev,
+				       pci_resource_start(pdev, 2),
+				       pci_resource_len(pdev, 2));
+		if (!hw_addr) {
+			err = -EIO;
+			goto err_free_net;
+		}
+
+		dma_version = readl(hw_addr);
+		break;
+	case rnpgbe_hw_n210:
+	case rnpgbe_hw_n210L:
+		hw_addr = devm_ioremap(&pdev->dev,
+				       pci_resource_start(pdev, 2),
+				       pci_resource_len(pdev, 2));
+		if (!hw_addr) {
+			err = -EIO;
+			goto err_free_net;
+		}
+
+		dma_version = readl(hw_addr);
+		break;
+	default:
+		err = -EIO;
+		goto err_free_net;
+	}
+	hw->hw_addr = hw_addr;
+	hw->dma.dma_version = dma_version;
+	hw->driver_version = 0x0002040f;
+	info->init(hw);
+	return 0;
+
+err_free_net:
+	free_netdev(netdev);
+	return err;
+}
+
 /**
  * rnpgbe_probe - Device initialization routine
  * @pdev: PCI device information struct
@@ -39,6 +125,7 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
  **/
 static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
+	const struct rnpgbe_info *info = rnpgbe_info_tbl[id->driver_data];
 	int err;
 
 	err = pci_enable_device_mem(pdev);
@@ -61,14 +148,37 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	pci_set_master(pdev);
 	pci_save_state(pdev);
+	err = rnpgbe_add_adapter(pdev, info);
+	if (err)
+		goto err_regions;
 
 	return 0;
+err_regions:
+	pci_release_mem_regions(pdev);
 err_dma:
 err_pci_req:
 	pci_disable_device(pdev);
 	return err;
 }
 
+/**
+ * rnpgbe_rm_adapter - Remove netdev for this mucse structure
+ * @pdev: PCI device information struct
+ *
+ * rnpgbe_rm_adapter remove a netdev for this mucse structure
+ **/
+static void rnpgbe_rm_adapter(struct pci_dev *pdev)
+{
+	struct mucse *mucse = pci_get_drvdata(pdev);
+	struct net_device *netdev;
+
+	if (!mucse)
+		return;
+	netdev = mucse->netdev;
+	mucse->netdev = NULL;
+	free_netdev(netdev);
+}
+
 /**
  * rnpgbe_remove - Device removal routine
  * @pdev: PCI device information struct
@@ -80,6 +190,7 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
  **/
 static void rnpgbe_remove(struct pci_dev *pdev)
 {
+	rnpgbe_rm_adapter(pdev);
 	pci_release_mem_regions(pdev);
 	pci_disable_device(pdev);
 }
@@ -92,7 +203,11 @@ static void rnpgbe_remove(struct pci_dev *pdev)
 static void rnpgbe_dev_shutdown(struct pci_dev *pdev,
 				bool *enable_wake)
 {
+	struct mucse *mucse = pci_get_drvdata(pdev);
+	struct net_device *netdev = mucse->netdev;
+
 	*enable_wake = false;
+	netif_device_detach(netdev);
 	pci_disable_device(pdev);
 }
 
-- 
2.25.1


