Return-Path: <netdev+bounces-248439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5517FD08805
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 11:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 317E5300161F
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 10:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4523F2F6928;
	Fri,  9 Jan 2026 10:18:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-220.mail.aliyun.com (out28-220.mail.aliyun.com [115.124.28.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F37623C8A0;
	Fri,  9 Jan 2026 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767953910; cv=none; b=KYuz0jR6pjl5WfhuO66oSA2NdfPDBJre0s7qJIewRsx0aPUqN/vuvgvZNGyv38UrGYtd4XBs/aATIKVpbnkhHAVGd0Eyz4rbxCn8mMkTmvyXhnBGw+QwY0AQ7QSJk2qtDAxCgWMgsyrNM9wV5MFpPxSxgjZ/j1i9WhjL5r9jjDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767953910; c=relaxed/simple;
	bh=h7JpGGUFehzMskDupWb1xv275sqNodjj4/Pm7wjG6cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jLh0mjg6BEEpHM6wKZ26IE3hIbGDsKp9puhiTuie9Kr/5eyolFKv6usqNZ9JQQp9i+dvSyxjpNlhkQpcEEGrGahG82TQqWlSX7wng0Yvhg99YHrvX8TuRggSMLFEo3kQb2yjqSLJkrkwD/mOL2Sq5lwJgvKs9BYbrR0v1vT9WbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.g2QQAXW_1767952946 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 09 Jan 2026 18:02:27 +0800
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
Subject: [PATCH v2 net-next 02/15] net/nebula-matrix: add simple probe/remove
Date: Fri,  9 Jan 2026 18:01:20 +0800
Message-ID: <20260109100146.63569-3-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109100146.63569-1-illusion.wang@nebula-matrix.com>
References: <20260109100146.63569-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Our driver architecture is relatively complex because the code is highly
reusable and designed to support multiple features. Additionally, the
codebase supports multiple chip variants, each with distinct
hardware-software interactions. 
To ensure compatibility, our architecture is divided into the following
layers:

1. Dev Layer (Device Layer)
The top-level business logic layer where all operations are
device-centric. Every operation is performed relative to the device
context. The intergration of base functions encompasses:
management(ctrl_dev), network(net_dev), common.

2. Service  Layer
The Service layer includes various netops services such as packet
receiving/sending, ethtool services, management services, etc. These are
provided to the upper layer for use or registered as the operations(ops)
of related devices.
It describes all the service capabilities possessed by the device.

3. Dispatch Layer
The distribution from services to specific data operations is mainly
divided into two types: direct pass-through and handling by the
management PF. It shields the upper layer from the differences in
specific underlying locations.
It describes the processing locations and paths of the services.

4. Resource Layer
Handles tasks dispatched from Dispatch Layer. These tasks fall into two
categories:
4.1 Hardware control  
The Resource Layer further invokes the HW Layer when hardware access is
needed, as only the HW Layer has OS-level privileges.
4.2 Software resource management
Operations like packet statistics collection that don't require hardware
access.

5. HW Layer (Hardware Layer)
Serves the Resource Layer by interacting with different hardware
chipsets.Writes to hardware registers to drive the hardware based on
Resource Layer directives.

6. Channel Layer

Handle communication between PF0 and other PF(Our PF0 has ctrl func)
/PF and VF , as well as communication with the EMP (Embedded
Management Processor),and provide basic interaction channels.

7. Common Layer
Provides fundamental services, including Workqueue management,
debug logging, and so on

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |  27 +++-
 .../nbl/nbl_include/nbl_def_common.h          | 108 ++++++++++++++
 .../nbl/nbl_include/nbl_include.h             |  13 +-
 .../nbl/nbl_include/nbl_product_base.h        |  20 +++
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c | 138 ++++++++++++++++++
 5 files changed, 304 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_product_base.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index e91de717bfe8..4e2618bef23a 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -8,7 +8,13 @@
 #define _NBL_CORE_H_
 
 #include <linux/pci.h>
-#include "nbl_include.h"
+#include "nbl_product_base.h"
+#include "nbl_def_common.h"
+
+#define NBL_ADAP_TO_PDEV(adapter)		((adapter)->pdev)
+#define NBL_ADAP_TO_DEV(adapter)		(&((adapter)->pdev->dev))
+#define NBL_ADAP_TO_COMMON(adapter)		(&((adapter)->common))
+#define NBL_ADAP_TO_RPDUCT_BASE_OPS(adapter)	((adapter)->product_base_ops)
 #define NBL_CAP_TEST_BIT(val, loc) (((val) >> (loc)) & 0x1)
 
 #define NBL_CAP_IS_CTRL(val) NBL_CAP_TEST_BIT(val, NBL_CAP_HAS_CTRL_BIT)
@@ -26,4 +32,23 @@ enum {
 	NBL_CAP_IS_LEONIS_BIT,
 	NBL_CAP_IS_OCP_BIT,
 };
+
+struct nbl_interface {
+};
+
+struct nbl_core {
+};
+
+struct nbl_adapter {
+	struct pci_dev *pdev;
+	struct nbl_core core;
+	struct nbl_interface intf;
+	struct nbl_common_info common;
+	struct nbl_product_base_ops *product_base_ops;
+	struct nbl_init_param init_param;
+};
+
+struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
+				  struct nbl_init_param *param);
+void nbl_core_remove(struct nbl_adapter *adapter);
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
new file mode 100644
index 000000000000..3533b853abc4
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_DEF_COMMON_H_
+#define _NBL_DEF_COMMON_H_
+
+#include <linux/netdev_features.h>
+#include "nbl_include.h"
+
+#define nbl_err(common, fmt, ...)					\
+do {									\
+	typeof(common) _common = (common);				\
+		dev_err(NBL_COMMON_TO_DEV(_common), fmt, ##__VA_ARGS__);\
+} while (0)
+
+#define nbl_warn(common, fmt, ...)					\
+do {									\
+	typeof(common) _common = (common);				\
+		dev_warn(NBL_COMMON_TO_DEV(_common), fmt, ##__VA_ARGS__);\
+} while (0)
+
+#define nbl_info(common, fmt, ...)					\
+do {									\
+	typeof(common) _common = (common);				\
+		dev_info(NBL_COMMON_TO_DEV(_common), fmt, ##__VA_ARGS__);\
+} while (0)
+
+#define nbl_debug(common, fmt, ...)					\
+do {									\
+	typeof(common) _common = (common);				\
+		dev_dbg(NBL_COMMON_TO_DEV(_common), fmt, ##__VA_ARGS__);\
+} while (0)
+
+static inline void __maybe_unused nbl_printk(struct device *dev, int level,
+					     const char *format, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	if (WARN_ONCE(level < LOGLEVEL_EMERG || level > LOGLEVEL_DEBUG,
+		      "Level %d is out of range, set to default level\n",
+		      level))
+		level = LOGLEVEL_DEFAULT;
+
+	va_start(args, format);
+	vaf.fmt = format;
+	vaf.va = &args;
+
+	dev_printk_emit(level, dev, "%s %s: %pV", dev_driver_string(dev),
+			dev_name(dev), &vaf);
+	va_end(args);
+}
+
+/* support  LOGLEVEL_EMERG/LOGLEVEL_CRIT logvel */
+#define nbl_log(common, level, format, ...)				\
+do {									\
+	typeof(common) _common = (common);				\
+	nbl_printk(NBL_COMMON_TO_DEV(_common), level, format,		\
+		   ##__VA_ARGS__);					\
+} while (0)
+
+#define NBL_COMMON_TO_PDEV(common)		((common)->pdev)
+#define NBL_COMMON_TO_DEV(common)		((common)->dev)
+#define NBL_COMMON_TO_DMA_DEV(common)		((common)->dma_dev)
+#define NBL_COMMON_TO_VSI_ID(common)		((common)->vsi_id)
+#define NBL_COMMON_TO_ETH_ID(common)		((common)->eth_id)
+#define NBL_COMMON_TO_ETH_MODE(common)		((common)->eth_mode)
+#define NBL_COMMON_TO_DEBUG_LVL(common)		((common)->debug_lvl)
+#define NBL_COMMON_TO_VF_CAP(common)		((common)->is_vf)
+#define NBL_COMMON_TO_OCP_CAP(common)		((common)->is_ocp)
+#define NBL_COMMON_TO_PCI_USING_DAC(common)	((common)->pci_using_dac)
+#define NBL_COMMON_TO_MGT_PF(common)		((common)->mgt_pf)
+#define NBL_COMMON_TO_PCI_FUNC_ID(common)	((common)->function)
+#define NBL_COMMON_TO_BOARD_ID(common)		((common)->board_id)
+#define NBL_COMMON_TO_LOGIC_ETH_ID(common)	((common)->logic_eth_id)
+
+struct nbl_common_info {
+	struct pci_dev *pdev;
+	struct device *dev;
+	struct device *dma_dev;
+	u32 msg_enable;
+	u16 vsi_id;
+	u8 eth_id;
+	u8 logic_eth_id;
+	u8 eth_mode;
+	u8 is_vf;
+
+	u8 function;
+	u8 devid;
+	u8 bus;
+	/* only valid for ctrldev */
+	u8 hw_bus;
+
+	u16 mgt_pf;
+	u8 board_id;
+
+	bool pci_using_dac;
+	u8 is_ocp;
+
+	enum nbl_product_type product_type;
+
+	bool wol_ena;
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index 963e13927a79..6f655d95d654 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -8,10 +8,15 @@
 #define _NBL_INCLUDE_H_
 
 #include <linux/types.h>
-
+#include <linux/netdevice.h>
 /*  ------  Basic definitions  -------  */
 #define NBL_DRIVER_NAME					"nbl_core"
 
+enum nbl_product_type {
+	NBL_LEONIS_TYPE,
+	NBL_PRODUCT_MAX,
+};
+
 struct nbl_func_caps {
 	u32 has_ctrl:1;
 	u32 has_net:1;
@@ -21,4 +26,10 @@ struct nbl_func_caps {
 	u32 rsv:27;
 };
 
+struct nbl_init_param {
+	struct nbl_func_caps caps;
+	enum nbl_product_type product_type;
+	bool pci_using_dac;
+};
+
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_product_base.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_product_base.h
new file mode 100644
index 000000000000..2f530c6b112c
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_product_base.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_DEF_PRODUCT_BASE_H_
+#define _NBL_DEF_PRODUCT_BASE_H_
+
+#include "nbl_include.h"
+struct nbl_product_base_ops {
+	int (*hw_init)(void *p, struct nbl_init_param *param);
+	void (*hw_remove)(void *p);
+	int (*res_init)(void *p, struct nbl_init_param *param);
+	void (*res_remove)(void *p);
+	int (*chan_init)(void *p, struct nbl_init_param *param);
+	void (*chan_remove)(void *p);
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
index ddb45144ff1c..d9d79803bef5 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -7,17 +7,155 @@
 #include <linux/aer.h>
 #include "nbl_core.h"
 
+static struct nbl_product_base_ops nbl_product_base_ops[NBL_PRODUCT_MAX] = {
+	{
+		.hw_init	= NULL,
+		.hw_remove	= NULL,
+		.res_init	= NULL,
+		.res_remove	= NULL,
+		.chan_init	= NULL,
+		.chan_remove	= NULL,
+	},
+};
+
+static void
+nbl_core_setup_product_ops(struct nbl_adapter *adapter,
+			   struct nbl_init_param *param,
+			   struct nbl_product_base_ops **product_base_ops)
+{
+	adapter->product_base_ops = &nbl_product_base_ops[param->product_type];
+	*product_base_ops = adapter->product_base_ops;
+}
+
+struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
+				  struct nbl_init_param *param)
+{
+	struct nbl_adapter *adapter;
+	struct nbl_common_info *common;
+	struct nbl_product_base_ops *product_base_ops;
+
+	if (!pdev)
+		return NULL;
+
+	adapter = devm_kzalloc(&pdev->dev, sizeof(struct nbl_adapter),
+			       GFP_KERNEL);
+	if (!adapter)
+		return NULL;
+
+	adapter->pdev = pdev;
+	common = NBL_ADAP_TO_COMMON(adapter);
+
+	common->pdev = pdev;
+	common->dev = &pdev->dev;
+	common->dma_dev = &pdev->dev;
+	common->is_vf = param->caps.is_vf;
+	common->is_ocp = param->caps.is_ocp;
+	common->pci_using_dac = param->pci_using_dac;
+	common->function = PCI_FUNC(pdev->devfn);
+	common->devid = PCI_SLOT(pdev->devfn);
+	common->bus = pdev->bus->number;
+	common->product_type = param->product_type;
+
+	memcpy(&adapter->init_param, param, sizeof(adapter->init_param));
+
+	nbl_core_setup_product_ops(adapter, param, &product_base_ops);
+
+	return adapter;
+}
+
+void nbl_core_remove(struct nbl_adapter *adapter)
+{
+	struct device *dev;
+
+	dev = NBL_ADAP_TO_DEV(adapter);
+	devm_kfree(dev, adapter);
+}
+
+static void nbl_get_func_param(struct pci_dev *pdev, kernel_ulong_t driver_data,
+			       struct nbl_init_param *param)
+{
+	param->caps.has_ctrl = NBL_CAP_IS_CTRL(driver_data);
+	param->caps.has_net = NBL_CAP_IS_NET(driver_data);
+	param->caps.is_vf = NBL_CAP_IS_VF(driver_data);
+	param->caps.is_nic = NBL_CAP_IS_NIC(driver_data);
+	param->caps.is_ocp = NBL_CAP_IS_OCP(driver_data);
+
+	if (NBL_CAP_IS_LEONIS(driver_data))
+		param->product_type = NBL_LEONIS_TYPE;
+
+	/*
+	 * Leonis only PF0 has ctrl capability, but PF0's pcie device_id
+	 * is same with other PF.So hanle it special.
+	 */
+	if (param->product_type == NBL_LEONIS_TYPE && !param->caps.is_vf &&
+	    (PCI_FUNC(pdev->devfn) == 0))
+		param->caps.has_ctrl = 1;
+}
+
 static int nbl_probe(struct pci_dev *pdev,
 		     const struct pci_device_id __always_unused *id)
 {
 	struct device *dev = &pdev->dev;
+	struct nbl_adapter *adapter = NULL;
+	struct nbl_init_param param = {{0}};
+	int err;
+
+	if (pci_enable_device(pdev)) {
+		dev_err(&pdev->dev, "Failed to enable PCI device\n");
+		return -ENODEV;
+	}
+
+	param.pci_using_dac = true;
+	nbl_get_func_param(pdev, id->driver_data, &param);
 
+	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	if (err) {
+		dev_err(dev, "Configure DMA 64 bit mask failed, err = %d\n",
+			err);
+		param.pci_using_dac = false;
+		err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+		if (err) {
+			dev_err(dev,
+				"Configure DMA 32 bit mask failed, err = %d\n",
+				err);
+			goto configure_dma_err;
+		}
+	}
+
+	pci_set_master(pdev);
+
+	pci_save_state(pdev);
+
+	adapter = nbl_core_init(pdev, &param);
+	if (!adapter) {
+		dev_err(dev, "Nbl adapter init fail\n");
+		err = -ENOMEM;
+		goto adapter_init_err;
+	}
+
+	pci_set_drvdata(pdev, adapter);
 	dev_dbg(dev, "nbl probe ok!\n");
 	return 0;
+adapter_init_err:
+	pci_clear_master(pdev);
+configure_dma_err:
+	pci_disable_device(pdev);
+	return err;
 }
 
 static void nbl_remove(struct pci_dev *pdev)
 {
+	struct nbl_adapter *adapter = pci_get_drvdata(pdev);
+
+	dev_dbg(&pdev->dev, "nbl remove\n");
+	if (!adapter)
+		return;
+	pci_disable_sriov(pdev);
+	nbl_core_remove(adapter);
+
+	pci_clear_master(pdev);
+	pci_disable_device(pdev);
+
 	dev_dbg(&pdev->dev, "nbl remove OK!\n");
 }
 
-- 
2.47.3


