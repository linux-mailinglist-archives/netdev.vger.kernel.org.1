Return-Path: <netdev+bounces-215190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B064B2D833
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4451A05DE8
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 09:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92FC2E0B6C;
	Wed, 20 Aug 2025 09:22:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8BE2DE70A;
	Wed, 20 Aug 2025 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681755; cv=none; b=QNQlpLz6G2/LMREIIrpzQtLNbaW9rty0PAvP0fe/0C9D9q1TZB9utw7XWJ2kIXIEr1LvpsNZq3qyDMeDzrASON1J8FHBAJ6CwL2vtKOeA8NX3B6Be0Q46MJMSXIuFWe2fXmSY/eXZUK4qtlu5lp6eEEAKpw0v53TSW+Sl7Us4uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681755; c=relaxed/simple;
	bh=U/YODyrjcBv6SJkVwH7Og1VEt98H1AAx8TDEvCEhjR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R5EWgqZemojZDKsauIGYgysxCrA4M8xV8mRYAtn9ofyg/pFQkq1KFpZHjAPxAseg7kD/dWUs3NMgklUmtIImT3UbeHgMnTv6TPaC7Iy4lXNZiJULQLYJ3YaxDka/d81zneMNaStTEb9YC8ID7fB9N23Yx3tnO9oyUEfhYBFF/UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz10t1755681737tb521dec9
X-QQ-Originating-IP: mZ5gb4xFM/lOoxt5V8kuyf1D72PHVnk+tGKc0zN+IC8=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 20 Aug 2025 17:22:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11971569143370105039
EX-QQ-RecipientCnt: 26
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
	gustavoars@kernel.org
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v6 2/5] net: rnpgbe: Add n500/n210 chip support
Date: Wed, 20 Aug 2025 17:21:51 +0800
Message-Id: <20250820092154.1643120-3-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250820092154.1643120-1-dong100@mucse.com>
References: <20250820092154.1643120-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MIvbLG+CJamsDdboRgdA30lcciT8w9GixOvezbuGszUh2JZrWS8c27zn
	LSyvorygzn3Jw6UGbBG2ixOElbEb/kRuzHRI8xEXSmou3N1iMaNJiMXCRy3+cat6w3J7K7i
	e7ooJErR6MlcuLYcl8pANYvvNzadScrkp59sd829q5GTdUdNkBgliy4OkrULRLYswxHr5sv
	H5KShidD9zDhEUhS8DpZqC8sqRm/PVi4hvG5LPx87rEvBSj7DJ0qPzoTvhod2oeNQOEgrj+
	vLXvJqPCN8VbKtd1zpQJJDeeJiWRsst6FAUPb4eNuCR8CupikL59AL0YcnZldzYfTgCbCxX
	zAqFfjWb22/c96G/5gix5nsNW+SEiX0Vavzsoc0+CMM379SVRctARHM4ZT2RjGak+RREIeA
	29XyKdO+MR4A8Gf33idGn3bgw2YaHHZ+WKzGssmcclUsQXB/L4H5YmuBsAhOFgamSLViqTn
	UuUaej2l//FXBePWA+R4NqdnxRq62SJMwsu0D6K7aBEN8QW1KzTomTSEKJtKG0LSHhIb4im
	ZKgPAkXWAhE7vIfuzU2L5gbvmFgky/29XEh+MkG/zsZDly6pzvkIa0qcygFDemHRMznbyXl
	fJ6mJyjVLMB289XJWlzjVmk9QXfSyM52CoG1wDW4fE08nTafvvcpRvsjT4ayLYcHMBlYiWL
	QeKxsijesjGht7AI30PsuQx3d0hRSSkrF44GoODXO40rwo5QlclOGXIsSWFhjsah9Eq6s+S
	mUb2ZKKW+xRwooOHQHRYTIGVG4bYh4ylVUFmB5KB7CCWoLuML+qg+djG+lmkUKnD1Tik/+S
	yxpdAYU6j7SOOwWhM4jXLF8DVqec5gpHvfCpwY7bpmMlaCvD6gYFh0UC/8qcJg94kbVztAI
	a2dKqWwjrNaxNB4OtWym3jsn/7WhSQYovXKpKwZ8ajYSJU7W3nD+mzk6hkl/iAbwX3ZXUfW
	/uOMrFpEHEWXNEn0YDiAqISwEQThRayfVSFm1ApJtIzzNCkfUhk/tXuAYzP6mc49Rx7s/0s
	qKEX62AgsE94KbVyDqPoADHCohQsBDU03C6SXLTzXLIEly7/frTN78IkJZPIkapyJ/ErHUJ
	QoGdLOpVEnpWOr8auKLQqLI20FWS0P1wvt+4x93Bj3gh88d0YdXeYqqwB/ZiUV1OxB7Lr3U
	/SR5
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Initialize n500/n210 chip bar resource map and
dma, eth, mbx ... info for future use.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |  3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 35 ++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 71 +++++++++++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h | 16 ++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 88 +++++++++++++++++++
 5 files changed, 212 insertions(+), 1 deletion(-)
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
index 64b2c093bc6e..2ae310303a48 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -4,15 +4,50 @@
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
+	int total_queue_pair_cnts;
+	enum rnpgbe_hw_type hw_type;
+	void (*init)(struct mucse_hw *hw);
 };
 
 /* Device IDs */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
new file mode 100644
index 000000000000..3cb25670586e
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -0,0 +1,71 @@
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
index 2090942ef633..9ce81e38e278 100644
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
@@ -27,6 +34,58 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
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
@@ -39,6 +98,7 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
  **/
 static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
+	const struct rnpgbe_info *info = rnpgbe_info_tbl[id->driver_data];
 	int err;
 
 	err = pci_enable_device_mem(pdev);
@@ -61,13 +121,36 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
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
@@ -79,6 +162,7 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
  **/
 static void rnpgbe_remove(struct pci_dev *pdev)
 {
+	rnpgbe_rm_adapter(pdev);
 	pci_release_mem_regions(pdev);
 	pci_disable_device(pdev);
 }
@@ -89,6 +173,10 @@ static void rnpgbe_remove(struct pci_dev *pdev)
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


