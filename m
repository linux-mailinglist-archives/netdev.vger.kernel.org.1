Return-Path: <netdev+bounces-214528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0BCB2A087
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 13:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6996B3A5182
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 11:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8402231A047;
	Mon, 18 Aug 2025 11:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F450319844;
	Mon, 18 Aug 2025 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755516623; cv=none; b=kEzcB26edvM6LbCoYY+hD8IyEDlSjjjJYKzCZmua/X3GBin4u7tYldn7i4YU+HTanBCj1avfadSIgtkeZ7ffhm86PuCTduw3ErfU+aJ+6lB+sA7D57j4cQ1NvImq7hwIcj/K9VqQS2s5XEtVERvHe+ahmXuY6IN6naGTRPTqg/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755516623; c=relaxed/simple;
	bh=l9ooZ8gy7FGYW/x2Q0sQeWUwxu3Bp+3SrOVWrUhC2fA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fAhw85qeaL7nHGwE/mnZ65VdjeEZUwOFhoy321Y7+y8pqVVTkustLzi31sGGrVWGI8hsr2+3NJliY4RZ1g0G3ebTGX9SYRYHm4X7GVYM3jmX7PVgws7khy/vGy1n86+GOTDNZdIsDVaD57K7YMKGmTSzE4Jz92X/najhRkeCK6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz2t1755516561t827d485b
X-QQ-Originating-IP: XrS6hKLHwXj9PXkOtpzmYmvyGRW+icGoGOfTcVzcJHc=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 Aug 2025 19:29:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1020227122016948603
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
Subject: [PATCH v5 2/5] net: rnpgbe: Add n500/n210 chip support
Date: Mon, 18 Aug 2025 19:28:53 +0800
Message-Id: <20250818112856.1446278-3-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250818112856.1446278-1-dong100@mucse.com>
References: <20250818112856.1446278-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MIYVF5Pddf3wqG3EVNpZQyT5fD4t+7gN+v3BVHE7k0kXwbFVgWcHishz
	LLN+/cxTjQmGN4qcoI2hE3QoUbn7t9iafTn/EadAtPHM76jVIMYsoElfNpRyefBcrx6CKJ3
	oX80X2TPSzIoD0CFwl/hX7g5RAE1FUrI/eSjdEbYW7lvHCf3GByq7cp55uo+S18redfQG38
	3eh+AnAgYVlUIGMiLfovf22RiGDFwnKbiiMneQCp72Q9Zph6GkBpA8TUT8usyVSE89pBgqs
	hox9pwh2pzTDuWsP1v11J1ADz+XLDAzkbZrVI12Nhl7z1FStyyfcagDPlItzV/Xt3HJ+8jx
	1xLzzIEN7dOnyG68hl0iHXllcRs3kx9z8PPXAZG8CQ3G92q7qMTwailY9ujxUSmG7X7icl8
	okW5iyB25lvhKpp/U+ELZ5O1UNb8T3gVfY8CSYd2sTjioT90in2xiaOX9HVPov6TwNvY6kv
	eiokQYsr+FlBQf3KLeuZdTFeBdLv+FmVogrDtUbNiNnrFIhc78BzscEj1C5ODTVfxhldoQG
	L2oj9qnC0mtmJ9c0n8WU56Ss/W5WVw8okzdimYtTY1g2/vo18th/1qXX468ceJHtWPZGyhY
	A1FM2L9xYuCKrR9mnjTdC5x9gqQjm8nZd30xAvZcK3h5XqyqS+YAAQD6wdLBVcTMr+e0OH3
	FlBjQzbwHuSeuonB5iFRp96hctr4ywofavltBADe8/3F8SHLmBC5DgkzsGT6NRAHL4AjczK
	JycceDNyT8q30tt18rivDotyjfC8iUyRp9BVaPB5ifOGClTrOtaEucQgmYJ/cU7pyoPooJt
	hc/dq9ERT9Rxa3gKFtnWhRUwMAGl/kgbp7o8QggHLNjTd4Hnozb+oJtXoycpJz9Gb7u8f/M
	V+o00YqwSWcCJL2Jst6Neru1hXT6vnTYvpYGmzUVVNNfUTuGyqTXdHlhS+FZ8OS92pv7eIg
	eCJo9ZAF77yYhDNyROvg66jI5X3slGexOFLnEpOKAEV1Pusl7Og0m9/jShg+fO29Q5FnBSE
	hWw6JVXa7RcSiGLxwC0fZ9bpHptxvTtl7QUQvLhma22zWGQN1h
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Initialize n500/n210 chip bar resource map and
dma, eth, mbx ... info for future use.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |  3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 54 +++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 85 +++++++++++++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h | 23 +++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 91 +++++++++++++++++++
 5 files changed, 255 insertions(+), 1 deletion(-)
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
index 64b2c093bc6e..a1553c1efa86 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -4,15 +4,69 @@
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
+	rnpgbe_hw_unknown
+};
+
+struct mucse_dma_info {
+	void __iomem *dma_base_addr;
+	void __iomem *dma_ring_addr;
+	u32 dma_version;
+};
+
+struct mucse_eth_info {
+	void __iomem *eth_base_addr;
+};
+
+struct mucse_mac_info {
+	void __iomem *mac_addr;
+};
+
+struct mucse_mbx_info {
+	/* fw <--> pf mbx */
+	u32 fw_pf_shm_base;
+	u32 pf2fw_mbox_ctrl;
+	u32 fw_pf_mbox_mask;
+	u32 fw2pf_mbox_vec;
+};
+
+struct mucse_hw {
+	void __iomem *hw_addr;
+	void __iomem *ring_msix_base;
+	struct pci_dev *pdev;
+	enum rnpgbe_hw_type hw_type;
+	struct mucse_dma_info dma;
+	struct mucse_eth_info eth;
+	struct mucse_mac_info mac;
+	struct mucse_mbx_info mbx;
+	u32 usecstocount;
+};
+
 struct mucse {
 	struct net_device *netdev;
 	struct pci_dev *pdev;
+	struct mucse_hw hw;
+};
+
+struct rnpgbe_info {
+	int total_queue_pair_cnts;
+	enum rnpgbe_hw_type hw_type;
+	void (*init)(struct mucse_hw *hw);
 };
 
 /* Device IDs */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
new file mode 100644
index 000000000000..4db5c910065e
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -0,0 +1,85 @@
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
+	struct mucse_mbx_info *mbx = &hw->mbx;
+
+	dma->dma_base_addr = hw->hw_addr;
+	dma->dma_ring_addr = hw->hw_addr + RNPGBE_RING_BASE;
+
+	eth->eth_base_addr = hw->hw_addr + RNPGBE_ETH_BASE;
+
+	mac->mac_addr = hw->hw_addr + RNPGBE_MAC_BASE;
+
+	mbx->pf2fw_mbox_ctrl = GBE_PF2FW_MBX_MASK_OFFSET;
+	mbx->fw_pf_mbox_mask = GBE_FWPF_MBX_MASK;
+}
+
+/**
+ * rnpgbe_init_n500 - Setup n500 hw info
+ * @hw: hw information structure
+ *
+ * rnpgbe_init_n500 initializes all private
+ * structure, such as dma, eth, mac and mbx base on
+ * hw->hw_addr for n500
+ **/
+static void rnpgbe_init_n500(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+
+	rnpgbe_init_common(hw);
+
+	mbx->fw2pf_mbox_vec = N500_FW2PF_MBX_VEC_OFFSET;
+	mbx->fw_pf_shm_base = N500_FWPF_SHM_BASE_OFFSET;
+	hw->ring_msix_base = hw->hw_addr + N500_RING_MSIX_OFFSET;
+	hw->usecstocount = N500_DEFAULT_USECSTOCOUNT;
+}
+
+/**
+ * rnpgbe_init_n210 - Setup n210 hw info
+ * @hw: hw information structure
+ *
+ * rnpgbe_init_n210 initializes all private
+ * structure, such as dma, eth, mac and mbx base on
+ * hw->hw_addr for n210
+ **/
+static void rnpgbe_init_n210(struct mucse_hw *hw)
+{
+	struct mucse_mbx_info *mbx = &hw->mbx;
+
+	rnpgbe_init_common(hw);
+
+	mbx->fw2pf_mbox_vec = N210_FW2PF_MBX_VEC_OFFSET;
+	mbx->fw_pf_shm_base = N210_FWPF_SHM_BASE_OFFSET;
+	hw->ring_msix_base = hw->hw_addr + N210_RING_MSIX_OFFSET;
+	hw->usecstocount = N210_DEFAULT_USECSTOCOUNT;
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
index 000000000000..8ce0094a88c9
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#ifndef _RNPGBE_HW_H
+#define _RNPGBE_HW_H
+
+#define RNPGBE_RING_BASE 0x1000
+#define RNPGBE_MAC_BASE 0x20000
+#define RNPGBE_ETH_BASE 0x10000
+/**************** MBX Resource ****************************/
+#define N500_FW2PF_MBX_VEC_OFFSET 0x28b00
+#define N500_FWPF_SHM_BASE_OFFSET 0x2d000
+#define GBE_PF2FW_MBX_MASK_OFFSET 0x5500
+#define GBE_FWPF_MBX_MASK 0x5700
+#define N500_RING_MSIX_OFFSET 0x28700
+#define N500_DEFAULT_USECSTOCOUNT 125
+#define N210_FW2PF_MBX_VEC_OFFSET 0x29400
+#define N210_FWPF_SHM_BASE_OFFSET 0x2d900
+#define N210_RING_MSIX_OFFSET 0x29000
+#define N210_DEFAULT_USECSTOCOUNT 62
+/**************** CHIP Resource ****************************/
+#define RNPGBE_MAX_QUEUES 8
+#endif /* _RNPGBE_HW_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 2090942ef633..89d8f78af146 100644
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
@@ -27,6 +34,61 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
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
+	struct mucse *mucse;
+	struct mucse_hw *hw;
+	u32 dma_version;
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
+	pci_set_drvdata(pdev, mucse);
+
+	hw = &mucse->hw;
+	hw->hw_type = info->hw_type;
+	hw->pdev = pdev;
+	hw_addr = devm_ioremap(&pdev->dev,
+			       pci_resource_start(pdev, 2),
+			       pci_resource_len(pdev, 2));
+	if (!hw_addr) {
+		err = -EIO;
+		goto err_free_net;
+	}
+
+	dma_version = readl(hw_addr);
+	hw->hw_addr = hw_addr;
+	hw->dma.dma_version = dma_version;
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
@@ -39,6 +101,7 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
  **/
 static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
+	const struct rnpgbe_info *info = rnpgbe_info_tbl[id->driver_data];
 	int err;
 
 	err = pci_enable_device_mem(pdev);
@@ -61,13 +124,36 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	pci_set_master(pdev);
 	pci_save_state(pdev);
+	err = rnpgbe_add_adapter(pdev, info);
+	if (err)
+		goto err_regions;
 
 	return 0;
+err_regions:
+	pci_release_mem_regions(pdev);
 err_dma:
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
@@ -79,6 +165,7 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
  **/
 static void rnpgbe_remove(struct pci_dev *pdev)
 {
+	rnpgbe_rm_adapter(pdev);
 	pci_release_mem_regions(pdev);
 	pci_disable_device(pdev);
 }
@@ -89,6 +176,10 @@ static void rnpgbe_remove(struct pci_dev *pdev)
  **/
 static void rnpgbe_dev_shutdown(struct pci_dev *pdev)
 {
+	struct mucse *mucse = pci_get_drvdata(pdev);
+	struct net_device *netdev = mucse->netdev;
+
+	netif_device_detach(netdev);
 	pci_disable_device(pdev);
 }
 
-- 
2.25.1


