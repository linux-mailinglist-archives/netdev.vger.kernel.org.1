Return-Path: <netdev+bounces-248421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FD0D08643
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 11:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C88383000B6B
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 10:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F362D8760;
	Fri,  9 Jan 2026 10:02:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-194.mail.aliyun.com (out28-194.mail.aliyun.com [115.124.28.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B03023EAAF;
	Fri,  9 Jan 2026 10:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767952963; cv=none; b=pWehKh+ec952Z7XwNoj8xqJT3kyYEOUeoLm57q2jopd5/cLKcT9Pi5ysiFf3b/mVTKPOXxb0a1l2RNYgpgIuM9JGnaSC/tfop+L9cA7dV54AY/CU6DkLR9atW2RMis47yP2aj3jrnUNY3j/ZryCux5luPb1AdW6IjcU5Rtv+WRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767952963; c=relaxed/simple;
	bh=diA792uACsIMLt1rAqvSVGQS+7rx9BDOYL6xlC+Wvxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BgXU24F8gysD+VXnNOnu/707+Ph6sFGs3xZ90F17OnYe+JtE6aHWqXO39wHsVGCiaYH5RE+9spF8r4+c5bmH6f6o749VQWHYEIVD9GFA9fX0JNUdOlJ4vWIe82kt9AW8pVH5GWyDanK+4OskGV0DVYYGE8IPcl6+DWo/kT44dGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.g2QQAZd_1767952948 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 09 Jan 2026 18:02:29 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	lorenzo@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 net-next 03/15] net/nebula-matrix: add HW layer definitions and implementation
Date: Fri,  9 Jan 2026 18:01:21 +0800
Message-ID: <20260109100146.63569-4-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109100146.63569-1-illusion.wang@nebula-matrix.com>
References: <20260109100146.63569-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add HW layer related definitions and product ops

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   4 +-
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |  11 ++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  | 179 ++++++++++++++++++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  |  13 ++
 .../nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h     | 156 +++++++++++++++
 .../nbl/nbl_include/nbl_def_hw.h              |  23 +++
 .../nbl/nbl_include/nbl_include.h             |  14 ++
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |  19 +-
 8 files changed, 416 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index df16a3436a5c..d5cadc289366 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -4,8 +4,10 @@
 
 obj-$(CONFIG_NBL_CORE) := nbl_core.o
 
-nbl_core-objs +=      nbl_main.o
+nbl_core-objs +=      nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
+				nbl_main.o
 
 # Provide include files
 ccflags-y += -I$(srctree)/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/
+ccflags-y += -I$(srctree)/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw
 ccflags-y += -I$(srctree)/drivers/net/ethernet/nebula-matrix/nbl/
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index 4e2618bef23a..33ed810ec7d0 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -9,12 +9,16 @@
 
 #include <linux/pci.h>
 #include "nbl_product_base.h"
+#include "nbl_def_hw.h"
 #include "nbl_def_common.h"
 
 #define NBL_ADAP_TO_PDEV(adapter)		((adapter)->pdev)
 #define NBL_ADAP_TO_DEV(adapter)		(&((adapter)->pdev->dev))
 #define NBL_ADAP_TO_COMMON(adapter)		(&((adapter)->common))
 #define NBL_ADAP_TO_RPDUCT_BASE_OPS(adapter)	((adapter)->product_base_ops)
+
+#define NBL_ADAP_TO_HW_MGT(adapter) ((adapter)->core.hw_mgt)
+#define NBL_ADAP_TO_HW_OPS_TBL(adapter) ((adapter)->intf.hw_ops_tbl)
 #define NBL_CAP_TEST_BIT(val, loc) (((val) >> (loc)) & 0x1)
 
 #define NBL_CAP_IS_CTRL(val) NBL_CAP_TEST_BIT(val, NBL_CAP_HAS_CTRL_BIT)
@@ -34,9 +38,16 @@ enum {
 };
 
 struct nbl_interface {
+	struct nbl_hw_ops_tbl *hw_ops_tbl;
 };
 
 struct nbl_core {
+	void *hw_mgt;
+	void *res_mgt;
+	void *disp_mgt;
+	void *serv_mgt;
+	void *dev_mgt;
+	void *chan_mgt;
 };
 
 struct nbl_adapter {
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
new file mode 100644
index 000000000000..40701ff147e2
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#include "nbl_hw_leonis.h"
+
+static struct nbl_hw_ops hw_ops = {
+};
+
+/* Structure starts here, adding an op should not modify anything below */
+static int nbl_hw_setup_hw_mgt(struct nbl_common_info *common,
+			       struct nbl_hw_mgt_leonis **hw_mgt_leonis)
+{
+	struct device *dev;
+
+	dev = NBL_COMMON_TO_DEV(common);
+	*hw_mgt_leonis =
+		devm_kzalloc(dev, sizeof(struct nbl_hw_mgt_leonis), GFP_KERNEL);
+	if (!*hw_mgt_leonis)
+		return -ENOMEM;
+
+	(&(*hw_mgt_leonis)->hw_mgt)->common = common;
+
+	return 0;
+}
+
+static void nbl_hw_remove_hw_mgt(struct nbl_common_info *common,
+				 struct nbl_hw_mgt_leonis **hw_mgt_leonis)
+{
+	struct device *dev;
+
+	dev = NBL_COMMON_TO_DEV(common);
+	devm_kfree(dev, *hw_mgt_leonis);
+	*hw_mgt_leonis = NULL;
+}
+
+static int nbl_hw_setup_ops(struct nbl_common_info *common,
+			    struct nbl_hw_ops_tbl **hw_ops_tbl,
+			    struct nbl_hw_mgt_leonis *hw_mgt_leonis)
+{
+	struct device *dev;
+
+	dev = NBL_COMMON_TO_DEV(common);
+	*hw_ops_tbl =
+		devm_kzalloc(dev, sizeof(struct nbl_hw_ops_tbl), GFP_KERNEL);
+	if (!*hw_ops_tbl)
+		return -ENOMEM;
+
+	(*hw_ops_tbl)->ops = &hw_ops;
+	(*hw_ops_tbl)->priv = hw_mgt_leonis;
+
+	return 0;
+}
+
+static void nbl_hw_remove_ops(struct nbl_common_info *common,
+			      struct nbl_hw_ops_tbl **hw_ops_tbl)
+{
+	struct device *dev;
+
+	dev = NBL_COMMON_TO_DEV(common);
+	devm_kfree(dev, *hw_ops_tbl);
+	*hw_ops_tbl = NULL;
+}
+
+int nbl_hw_init_leonis(void *p, struct nbl_init_param *param)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct nbl_common_info *common;
+	struct pci_dev *pdev;
+	struct nbl_hw_mgt_leonis **hw_mgt_leonis;
+	struct nbl_hw_mgt *hw_mgt;
+	struct nbl_hw_ops_tbl **hw_ops_tbl;
+	int bar_mask;
+	int ret = 0;
+
+	common = NBL_ADAP_TO_COMMON(adapter);
+	hw_mgt_leonis =
+		(struct nbl_hw_mgt_leonis **)&NBL_ADAP_TO_HW_MGT(adapter);
+	hw_ops_tbl = &NBL_ADAP_TO_HW_OPS_TBL(adapter);
+	pdev = NBL_COMMON_TO_PDEV(common);
+
+	ret = nbl_hw_setup_hw_mgt(common, hw_mgt_leonis);
+	if (ret)
+		goto setup_mgt_fail;
+
+	hw_mgt = &(*hw_mgt_leonis)->hw_mgt;
+	bar_mask = BIT(NBL_MEMORY_BAR) | BIT(NBL_MAILBOX_BAR);
+	ret = pci_request_selected_regions(pdev, bar_mask, NBL_DRIVER_NAME);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Request memory bar and mailbox bar failed, err = %d\n",
+			ret);
+		goto request_bar_region_fail;
+	}
+
+	if (param->caps.has_ctrl) {
+		hw_mgt->hw_addr =
+			ioremap(pci_resource_start(pdev, NBL_MEMORY_BAR),
+				pci_resource_len(pdev, NBL_MEMORY_BAR) -
+					NBL_RDMA_NOTIFY_OFF);
+		if (!hw_mgt->hw_addr) {
+			dev_err(&pdev->dev, "Memory bar ioremap failed\n");
+			ret = -EIO;
+			goto ioremap_err;
+		}
+		hw_mgt->hw_size = pci_resource_len(pdev, NBL_MEMORY_BAR) -
+				  NBL_RDMA_NOTIFY_OFF;
+	} else {
+		hw_mgt->hw_addr =
+			ioremap(pci_resource_start(pdev, NBL_MEMORY_BAR),
+				NBL_RDMA_NOTIFY_OFF);
+		if (!hw_mgt->hw_addr) {
+			dev_err(&pdev->dev, "Memory bar ioremap failed\n");
+			ret = -EIO;
+			goto ioremap_err;
+		}
+		hw_mgt->hw_size = NBL_RDMA_NOTIFY_OFF;
+	}
+
+	hw_mgt->notify_offset = 0;
+	hw_mgt->mailbox_bar_hw_addr = pci_ioremap_bar(pdev, NBL_MAILBOX_BAR);
+	if (!hw_mgt->mailbox_bar_hw_addr) {
+		dev_err(&pdev->dev, "Mailbox bar ioremap failed\n");
+		ret = -EIO;
+		goto mailbox_ioremap_err;
+	}
+
+	spin_lock_init(&hw_mgt->reg_lock);
+	hw_mgt->should_lock = true;
+
+	ret = nbl_hw_setup_ops(common, hw_ops_tbl, *hw_mgt_leonis);
+	if (ret)
+		goto setup_ops_fail;
+
+	(*hw_mgt_leonis)->ro_enable = pcie_relaxed_ordering_enabled(pdev);
+
+	return 0;
+
+setup_ops_fail:
+	iounmap(hw_mgt->mailbox_bar_hw_addr);
+mailbox_ioremap_err:
+	iounmap(hw_mgt->hw_addr);
+ioremap_err:
+	pci_release_selected_regions(pdev, bar_mask);
+request_bar_region_fail:
+	nbl_hw_remove_hw_mgt(common, hw_mgt_leonis);
+setup_mgt_fail:
+	return ret;
+}
+
+void nbl_hw_remove_leonis(void *p)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct nbl_common_info *common;
+	struct nbl_hw_mgt_leonis **hw_mgt_leonis;
+	struct nbl_hw_ops_tbl **hw_ops_tbl;
+	struct pci_dev *pdev;
+	u8 __iomem *hw_addr;
+	u8 __iomem *mailbox_bar_hw_addr;
+	int bar_mask = BIT(NBL_MEMORY_BAR) | BIT(NBL_MAILBOX_BAR);
+
+	common = NBL_ADAP_TO_COMMON(adapter);
+	hw_mgt_leonis =
+		(struct nbl_hw_mgt_leonis **)&NBL_ADAP_TO_HW_MGT(adapter);
+	hw_ops_tbl = &NBL_ADAP_TO_HW_OPS_TBL(adapter);
+	pdev = NBL_COMMON_TO_PDEV(common);
+
+	hw_addr = (*hw_mgt_leonis)->hw_mgt.hw_addr;
+	mailbox_bar_hw_addr = (*hw_mgt_leonis)->hw_mgt.mailbox_bar_hw_addr;
+
+	iounmap(mailbox_bar_hw_addr);
+	iounmap(hw_addr);
+	pci_release_selected_regions(pdev, bar_mask);
+	nbl_hw_remove_hw_mgt(common, hw_mgt_leonis);
+
+	nbl_hw_remove_ops(common, hw_ops_tbl);
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
new file mode 100644
index 000000000000..b078b765f772
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_HW_LEONIS_H_
+#define _NBL_HW_LEONIS_H_
+
+#include "nbl_core.h"
+#include "nbl_hw_reg.h"
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
new file mode 100644
index 000000000000..51518bb78b4f
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
@@ -0,0 +1,156 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_HW_REG_H_
+#define _NBL_HW_REG_H_
+
+#include "nbl_core.h"
+
+#define NBL_HW_MGT_TO_COMMON(hw_mgt)		((hw_mgt)->common)
+#define NBL_HW_MGT_TO_DEV(hw_mgt) \
+	NBL_COMMON_TO_DEV(NBL_HW_MGT_TO_COMMON(hw_mgt))
+#define NBL_MEMORY_BAR				(0)
+#define NBL_MAILBOX_BAR				(2)
+#define NBL_RDMA_NOTIFY_OFF			(8192)
+
+struct nbl_hw_mgt {
+	struct nbl_common_info *common;
+	u8 __iomem *hw_addr;
+	u8 __iomem *mailbox_bar_hw_addr;
+	u64 notify_offset;
+	u32 version;
+	u32 hw_size;
+	spinlock_t reg_lock;  /* Protect reg access */
+	bool should_lock;
+	u8 resv[3];
+	enum nbl_hw_status hw_status;
+};
+
+static inline u32 rd32(u8 __iomem *addr, u64 reg)
+{
+	return readl(addr + (reg));
+}
+
+static inline void wr32_barrier(u8 __iomem *addr, u64 reg, u32 value)
+{
+	writel((value), (addr + (reg)));
+}
+
+static inline void nbl_hw_rd_regs(struct nbl_hw_mgt *hw_mgt, u64 reg,
+				  u8 *data, u32 len)
+{
+	u32 size = len / 4;
+	u32 i = 0;
+
+	if (len % 4)
+		return;
+
+	if (hw_mgt->hw_status) {
+		for (i = 0; i < size; i++)
+			*(u32 *)(data + i * sizeof(u32)) = U32_MAX;
+		return;
+	}
+
+	spin_lock(&hw_mgt->reg_lock);
+
+	for (i = 0; i < size; i++)
+		*(u32 *)(data + i * sizeof(u32)) =
+			rd32(hw_mgt->hw_addr, reg + i * sizeof(u32));
+	spin_unlock(&hw_mgt->reg_lock);
+}
+
+static inline void nbl_hw_wr_regs(struct nbl_hw_mgt *hw_mgt,
+				  u64 reg, const u8 *data, u32 len)
+{
+	u32 size = len / 4;
+	u32 i = 0;
+
+	if (len % 4)
+		return;
+
+	if (hw_mgt->hw_status)
+		return;
+	spin_lock(&hw_mgt->reg_lock);
+	for (i = 0; i < size; i++)
+		/* Used for emu, make sure that we won't write too frequently */
+		wr32_barrier(hw_mgt->hw_addr, reg + i * sizeof(u32),
+			     *(u32 *)(data + i * sizeof(u32)));
+	spin_unlock(&hw_mgt->reg_lock);
+}
+
+static inline void nbl_hw_wr32(struct nbl_hw_mgt *hw_mgt, u64 reg, u32 value)
+{
+	if (hw_mgt->hw_status)
+		return;
+
+	/* Used for emu, make sure that we won't write too frequently */
+	wr32_barrier(hw_mgt->hw_addr, reg, value);
+}
+
+static inline u32 nbl_hw_rd32(struct nbl_hw_mgt *hw_mgt, u64 reg)
+{
+	if (hw_mgt->hw_status)
+		return U32_MAX;
+
+	return rd32(hw_mgt->hw_addr, reg);
+}
+
+static inline void nbl_mbx_wr32(void *priv, u64 reg, u32 value)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+
+	if (hw_mgt->hw_status)
+		return;
+
+	writel((value), ((hw_mgt)->mailbox_bar_hw_addr + (reg)));
+}
+
+static inline u32 nbl_mbx_rd32(void *priv, u64 reg)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+
+	if (hw_mgt->hw_status)
+		return U32_MAX;
+
+	return readl((hw_mgt)->mailbox_bar_hw_addr + (reg));
+}
+
+static inline void nbl_hw_read_mbx_regs(struct nbl_hw_mgt *hw_mgt,
+					u64 reg, u8 *data, u32 len)
+{
+	u32 i = 0;
+
+	if (len % 4)
+		return;
+
+	for (i = 0; i < len / 4; i++)
+		*(u32 *)(data + i * sizeof(u32)) =
+			nbl_mbx_rd32(hw_mgt, reg + i * sizeof(u32));
+}
+
+static inline void nbl_hw_write_mbx_regs(struct nbl_hw_mgt *hw_mgt,
+					 u64 reg, const u8 *data, u32 len)
+{
+	u32 i = 0;
+
+	if (len % 4)
+		return;
+
+	for (i = 0; i < len / 4; i++)
+		/* Used for emu, make sure that we won't write too frequently */
+		nbl_mbx_wr32(hw_mgt, reg + i * sizeof(u32),
+			     *(u32 *)(data + i * sizeof(u32)));
+}
+
+/* Mgt structure for each product.
+ * Every indivisual mgt must have the common mgt as its first member,
+ * and contains its unique data structure in the reset of it.
+ */
+struct nbl_hw_mgt_leonis {
+	struct nbl_hw_mgt hw_mgt;
+	bool ro_enable;
+};
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
new file mode 100644
index 000000000000..6ac72e26ccd6
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_DEF_HW_H_
+#define _NBL_DEF_HW_H_
+
+#include "nbl_include.h"
+
+struct nbl_hw_ops {
+};
+
+struct nbl_hw_ops_tbl {
+	struct nbl_hw_ops *ops;
+	void *priv;
+};
+
+int nbl_hw_init_leonis(void *p, struct nbl_init_param *param);
+void nbl_hw_remove_leonis(void *p);
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index 6f655d95d654..e620feb382c1 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -12,11 +12,25 @@
 /*  ------  Basic definitions  -------  */
 #define NBL_DRIVER_NAME					"nbl_core"
 
+#define NBL_MAX_PF					8
+#define NBL_NEXT_ID(id, max)				\
+	({						\
+		typeof(id) _id = (id);			\
+		((_id) == (max) ? 0 : (_id) + 1);	\
+	})
+
 enum nbl_product_type {
 	NBL_LEONIS_TYPE,
 	NBL_PRODUCT_MAX,
 };
 
+enum nbl_hw_status {
+	NBL_HW_NOMAL,
+	/* Most hw module is not work nomal exclude pcie/emp */
+	NBL_HW_FATAL_ERR,
+	NBL_HW_STATUS_MAX,
+};
+
 struct nbl_func_caps {
 	u32 has_ctrl:1;
 	u32 has_net:1;
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
index d9d79803bef5..a93aa98f2316 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -9,8 +9,8 @@
 
 static struct nbl_product_base_ops nbl_product_base_ops[NBL_PRODUCT_MAX] = {
 	{
-		.hw_init	= NULL,
-		.hw_remove	= NULL,
+		.hw_init	= nbl_hw_init_leonis,
+		.hw_remove	= nbl_hw_remove_leonis,
 		.res_init	= NULL,
 		.res_remove	= NULL,
 		.chan_init	= NULL,
@@ -33,6 +33,7 @@ struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
 	struct nbl_adapter *adapter;
 	struct nbl_common_info *common;
 	struct nbl_product_base_ops *product_base_ops;
+	int ret = 0;
 
 	if (!pdev)
 		return NULL;
@@ -60,14 +61,28 @@ struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
 
 	nbl_core_setup_product_ops(adapter, param, &product_base_ops);
 
+	/*
+	 *every product's hw/chan/res layer has a great difference,
+	 *so call their own init ops
+	 */
+	ret = product_base_ops->hw_init(adapter, param);
+	if (ret)
+		goto hw_init_fail;
+
 	return adapter;
+hw_init_fail:
+	devm_kfree(&pdev->dev, adapter);
+	return NULL;
 }
 
 void nbl_core_remove(struct nbl_adapter *adapter)
 {
+	struct nbl_product_base_ops *product_base_ops;
 	struct device *dev;
 
 	dev = NBL_ADAP_TO_DEV(adapter);
+	product_base_ops = NBL_ADAP_TO_RPDUCT_BASE_OPS(adapter);
+	product_base_ops->hw_remove(adapter);
 	devm_kfree(dev, adapter);
 }
 
-- 
2.47.3


