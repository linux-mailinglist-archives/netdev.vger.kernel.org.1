Return-Path: <netdev+bounces-213610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C690B25DCF
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 09:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA6A16F1BE
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 07:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D762749C9;
	Thu, 14 Aug 2025 07:40:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3B826FA46;
	Thu, 14 Aug 2025 07:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755157229; cv=none; b=Dx1MG7pwwhf3HHtIMRHljD2v+HZCyimk68PHRbyOakdoD4j62PpmbWQvqNmHc2+y+6bARsyXzjwNLBMu10CMTT1u50ZrRwm/tqYI9d19irGNTacwttpx7449aIfF8ipqF3qge0XvZVTQlQ1g0cInvcYCGprzCmpk22oII1f6S7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755157229; c=relaxed/simple;
	bh=3KU50RPtal1UdfyUHqdepxeTcK5N/cRvkgDHYfnHMzw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=It0sBMVkiU0l8I+LQzQ3DC8KAJLVmCpkkt8MPk3Rp4O2h+26vj/KfhkT5Oui6XI6h2eHvFw7NTF8y4iYRQkBO46McgtfdLZ83wGph/UVUzm6OiPb7+HQ1liO8Q0obDG4N0PvFJ8wVZjgfbFQ1YjmEe4w5RM57CtK0mF5n2b2B6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz8t1755157153t255bec2f
X-QQ-Originating-IP: /M/369QdeFW0S8m/H3wpz5m/kxgcGhm50VzZzzmbEjY=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 Aug 2025 15:39:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16659429040623633048
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
Subject: [PATCH v4 2/5] net: rnpgbe: Add n500/n210 chip support
Date: Thu, 14 Aug 2025 15:38:52 +0800
Message-Id: <20250814073855.1060601-3-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250814073855.1060601-1-dong100@mucse.com>
References: <20250814073855.1060601-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NDd9MucL1yTJSAdpJr0oPbDccw8D8pRql5julmCU14r7RocpvLv04bro
	XYOO731cTOQzJYx85+0kuL2tLrBiAngq8MiuGW3i04TDZRxF8NMBBdxOVzu4AQqtQhmMaN8
	axJIm1/74uoXPPN2iF21JZaMGhSLeqYBbj2s/N6s6ST11/cHIu5jIyz+0fiwuiAWkQAlD1j
	3o9fq4ZqRteWqSmtax2DWeNO9jsknshxVlDic0uPzWg17Qa556KAaFly09VxjdPmv/VpZKl
	0RaOvEOLGjHhrEZmey1qjM9p5PanH4VOViQiwoBQ/XtDHx3fIciggYFSxnYiP7n27VU26Le
	Nt9yJ3SPZmyYo8nWY5HrzXTYsJUt+yAiRpOnbzI8G4vDkanVv+rWQtke7C9LFYXZ+iQbWcR
	1NcTMd/rh85yFMvB5hOK9bFqBNujTp8PyPYFEVUuuMkjNcJVHFT9p4iw119EUDVRfRYOpJl
	LDQ8CulwP1VmXDhG8HUW9kXRHUyfZhE3gv4+N1CTWlteYg8mycDop1tAVN7TVS1GHvWwrOR
	1EeSbAAYIxAiZvfWt8O5vs2v4TL4W7HJAjWIhxaMGKqiwg0QlacI0HvyVz8mfqzyvJ0HSER
	Sh1aFmKPSJWMnYrLDdj6ij8BVNrZXcv/lojmjItW4WSHTz4zK9rMONza011xHsw6l7WW/ye
	2pTzIBdDohGBTRFq/Wg30q0lvzcrLSWazZzfv0VR+RTXEh7WoqH0LGfYCysy0mItJWOwbno
	9IxZxJAj4YwCtse1C0/eJdCfjUyYNVEn+Llgj8IDskmuoh+i7TLRSEo0s1T3QmsN6afJJSO
	XzAOfEzzdy8YtZnWt9mvwJ3o7nEU0GwtK40q1jWY9t4zU98tLfCIP9WG/Czfd42IAvRW4P1
	plOlNyClR6wm+19okplot34cpJmvq3rPVOlIYdkFqw0K6iBLW2hOHoFyGat/jAWa4PnecG/
	M3Xnsfr66AuFyHQ6vtXBP3A69hb0cIPD35tmvReSwVATixfwbyHMBp/fCMrMymuSJgFjuI1
	m0GWtdl8S4LHUo/4ixh7vwUX2Zaiw=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Initialize n500/n210 chip bar resource map and
dma, eth, mbx ... info for future use.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  55 +++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  85 +++++++++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  12 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 112 ++++++++++++++++++
 5 files changed, 266 insertions(+), 1 deletion(-)
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
index 64b2c093bc6e..08faac3a67af 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -4,15 +4,70 @@
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
+	u32 driver_version;
+	u16 usecstocount;
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
index 000000000000..79aefd7e335d
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
+
+	dma->dma_base_addr = hw->hw_addr;
+	dma->dma_ring_addr = hw->hw_addr + RNPGBE_RING_BASE;
+
+	eth->eth_base_addr = hw->hw_addr + RNPGBE_ETH_BASE;
+
+	mac->mac_addr = hw->hw_addr + RNPGBE_MAC_BASE;
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
+ * hw->hw_addr for n210
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
index 44a787789ace..1fef7fa30208 100644
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
@@ -27,6 +34,82 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
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
+	pci_set_drvdata(pdev, mucse);
+
+	hw = &mucse->hw;
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
@@ -39,6 +122,7 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
  **/
 static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
+	const struct rnpgbe_info *info = rnpgbe_info_tbl[id->driver_data];
 	int err;
 
 	err = pci_enable_device_mem(pdev);
@@ -61,13 +145,36 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
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
@@ -79,6 +186,7 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
  **/
 static void rnpgbe_remove(struct pci_dev *pdev)
 {
+	rnpgbe_rm_adapter(pdev);
 	pci_release_mem_regions(pdev);
 	pci_disable_device(pdev);
 }
@@ -91,7 +199,11 @@ static void rnpgbe_remove(struct pci_dev *pdev)
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


