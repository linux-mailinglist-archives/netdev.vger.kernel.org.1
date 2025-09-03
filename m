Return-Path: <netdev+bounces-219414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B16B412A2
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 04:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12AFC163890
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 02:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E6E235063;
	Wed,  3 Sep 2025 02:55:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30D022258E;
	Wed,  3 Sep 2025 02:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756868133; cv=none; b=b72C+1ZlsQwU7+M0dPT/A2FqSS2zed7peT+WaY/Tv6d/DUh8RoINt032V8+B16QvtZw9EtTblp6rAvEGnDUPIgN2GlaG33Gqgf7yw8yE73IUvEFGervEaewcogGMevOmocmaix/fopnxIfnCOwpmJZtcZ+/xIqWJIEThH7INo0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756868133; c=relaxed/simple;
	bh=CQMl/bWQcNom0w9E0ye6Iydgedovv8+aZAoXeY/ntsw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jayqBtMKKVCKuqgB8pZvldqLnjrcDJfGnPdnFaaKlWcMMHXxAeLhP/HHUgAle0ZxC/WFZd540Ob9e3jyrGMDsyZDndIkDwmiHNeqr6ED7b+5SCMoofhkOFKXpqO8JQJ6Vy63IHNLlUKzNnSkPBF+mHG6vDzfNmYQ0svYgN1H6SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz11t1756868087t82b3e6a3
X-QQ-Originating-IP: 2b8yhCJYFSa720UZCX+XqFKyo0s3r+DxhO0Osv7UWZs=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Sep 2025 10:54:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13150418046888752316
EX-QQ-RecipientCnt: 28
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
	richardcochran@gmail.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	rdunlap@infradead.org,
	vadim.fedorenko@linux.dev
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v10 2/5] net: rnpgbe: Add n500/n210 chip support
Date: Wed,  3 Sep 2025 10:54:27 +0800
Message-Id: <20250903025430.864836-3-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250903025430.864836-1-dong100@mucse.com>
References: <20250903025430.864836-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N2J0ax+MgH9HZbt3VGVDTWXZL28Zhj/iealEtmwag025zYlz6mf//WaJ
	3P2wy7plEQSwfhzgla8AQwm8H2T8LxdrldEt6B2QuHo+5YwtbTvEJKMlNUGsptC8qTC4TwN
	KYp5QllAogrrUMdnJ93f5n2aXYarFIxv/p06wzMYC/Neoe/HdQT/oMu5bGaWoX+ee4cOz7c
	na5t7tqJE2ce/Z/EMz1WykWWWcLxtZxjNMuNQNfLKKmvRMgVkimS9ZxYQxdM527vnIh55p7
	lI21QfoVvcr89DJwm0ifdJPSBZ55tgT5kAaz2jKZnO3OaDHeA2hkt0YXMi+7N8e557Tqzcp
	NFati6HMaXr/ovpdSh578v4D3MGY92R0kSnlkWOtdI3BLykUeIYowVLV9yit36NPZstaUSO
	oZhKTHndVbQYIVmkdCj7nBnJ5kXzYEkUFiV1yj8BApfh9mB+VTmzhKGPlUIRC9oi4IahiME
	w+qxhhon+tFYX3pgVGyLMaYTWNm7lUWYGURPPdB4QxEpRuQPZMcepc99P3VqmUhHAlsE1Ly
	XbBFtgym7k9TKfetCgmCPCCKOz9TcfjMW3iyK4ja68e113VTfpEuQzNMyRin/3S8x4cGEtD
	Auh18S7r+oZNavMDzKWBkoufzGJppn8uaitapve8tq2HTufIrFvvhHfJPW9PP+zTI0E2CLf
	b00reQjL8JuQQOlO60Sa15tIztjnHFS9r94y4ipl92opr067srPcpsNYM70aOP+clXBLUq4
	v76o90JB5OUp4rlHL6F/ccbMN5sVkINeT5FrUj3XKI8cM0cl1pvoCQFj+FgD9VIRWXlHoLT
	rzf1Wi+bxyHhEXGykus8vsgzaeRrI8EJPTEnq+Ns9z//eiL4EEBMhsxeWFy9F4YrEh3dXpz
	FXil14uWbXR+0W5Lja9zbCiQIll3CtB75pOMuOqD4LWlvWGFZtZ3bA+gXMESX4+TZeFYll1
	XsiizezV5YJupbcES23AnfHEB3eix12iY5hpYwlcs/zlq4VrPfR6XhH1xEBME/PT6o6v3l0
	y2s1qpHXs69s4Qjypp
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Initialize n500/n210 chip bar resource map and
dma, eth, mbx ... info for future use.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |  3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 34 ++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 68 +++++++++++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h | 16 ++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 85 +++++++++++++++++++
 5 files changed, 205 insertions(+), 1 deletion(-)
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
index 64b2c093bc6e..9a86e67d6395 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -4,15 +4,49 @@
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
+	struct pci_dev *pdev;
+	enum rnpgbe_hw_type hw_type;
+	struct mucse_mbx_info mbx;
+};
+
 struct mucse {
 	struct net_device *netdev;
 	struct pci_dev *pdev;
+	struct mucse_hw hw;
+};
+
+struct rnpgbe_info {
+	enum rnpgbe_hw_type hw_type;
+	void (*init)(struct mucse_hw *hw);
 };
 
 /* Device IDs */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
new file mode 100644
index 000000000000..179621ea09f3
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -0,0 +1,68 @@
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
+	struct mucse_mbx_info *mbx = &hw->mbx;
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
+}
+
+const struct rnpgbe_info rnpgbe_n500_info = {
+	.hw_type = rnpgbe_hw_n500,
+	.init = &rnpgbe_init_n500,
+};
+
+const struct rnpgbe_info rnpgbe_n210_info = {
+	.hw_type = rnpgbe_hw_n210,
+	.init = &rnpgbe_init_n210,
+};
+
+const struct rnpgbe_info rnpgbe_n210L_info = {
+	.hw_type = rnpgbe_hw_n210L,
+	.init = &rnpgbe_init_n210,
+};
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
new file mode 100644
index 000000000000..746dca78f1df
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#ifndef _RNPGBE_HW_H
+#define _RNPGBE_HW_H
+
+/**************** MBX Resource ****************************/
+#define N500_FW2PF_MBX_VEC_OFFSET 0x28b00
+#define N500_FWPF_SHM_BASE_OFFSET 0x2d000
+#define GBE_PF2FW_MBX_MASK_OFFSET 0x5500
+#define GBE_FWPF_MBX_MASK 0x5700
+#define N210_FW2PF_MBX_VEC_OFFSET 0x29400
+#define N210_FWPF_SHM_BASE_OFFSET 0x2d900
+/**************** CHIP Resource ****************************/
+#define RNPGBE_MAX_QUEUES 8
+#endif /* _RNPGBE_HW_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 98905607e74b..25b7119d6ecb 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -4,10 +4,18 @@
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
 
 #include "rnpgbe.h"
+#include "rnpgbe_hw.h"
 
 static const char rnpgbe_driver_name[] = "rnpgbe";
+static const struct rnpgbe_info *rnpgbe_info_tbl[] = {
+	[board_n500] = &rnpgbe_n500_info,
+	[board_n210] = &rnpgbe_n210_info,
+	[board_n210L] = &rnpgbe_n210L_info,
+};
 
 /* rnpgbe_pci_tbl - PCI Device ID Table
  *
@@ -27,6 +35,56 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
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
+ * Return: 0 on success, negative errno on failure
+ **/
+static int rnpgbe_add_adapter(struct pci_dev *pdev,
+			      const struct rnpgbe_info *info)
+{
+	struct net_device *netdev;
+	void __iomem *hw_addr;
+	struct mucse *mucse;
+	struct mucse_hw *hw;
+	int err;
+
+	netdev = alloc_etherdev_mq(sizeof(struct mucse), RNPGBE_MAX_QUEUES);
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
+	hw->hw_addr = hw_addr;
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
@@ -39,6 +97,7 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
  **/
 static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
+	const struct rnpgbe_info *info = rnpgbe_info_tbl[id->driver_data];
 	int err;
 
 	err = pci_enable_device_mem(pdev);
@@ -65,6 +124,9 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		dev_err(&pdev->dev, "pci_save_state failed %d\n", err);
 		goto err_free_regions;
 	}
+	err = rnpgbe_add_adapter(pdev, info);
+	if (err)
+		goto err_free_regions;
 
 	return 0;
 err_free_regions:
@@ -74,6 +136,24 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -85,6 +165,7 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
  **/
 static void rnpgbe_remove(struct pci_dev *pdev)
 {
+	rnpgbe_rm_adapter(pdev);
 	pci_release_mem_regions(pdev);
 	pci_disable_device(pdev);
 }
@@ -95,6 +176,10 @@ static void rnpgbe_remove(struct pci_dev *pdev)
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


