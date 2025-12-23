Return-Path: <netdev+bounces-245801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C42CD806C
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 05:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B12E3001BE0
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 04:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20A33081CA;
	Tue, 23 Dec 2025 03:56:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-108.mail.aliyun.com (out28-108.mail.aliyun.com [115.124.28.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2D1303CB0;
	Tue, 23 Dec 2025 03:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766462207; cv=none; b=Wy/qnVT36eO8ZFTspe1FthFMxFbrwiX1bx3GHS+cKY0KHKN76npzEOqQ12Q/VFjaPGMEdLiJdjxZiWyicwfmY+WjRTX/ayp9lVo9NN4+c9md5kt2PyvCfmkePzGf5jg7AS5Dneifk3wvhHEnCeM+OQcVkvyE/5bwCqlfJRgwEkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766462207; c=relaxed/simple;
	bh=IBXc8hsXxcIMknge9Ke7TJc6oA/hCvLVsgMSDMpRrTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f17LCcYlUMcgWD1cWv8jZLoI4QSA6Cc1Cv5KOgpA0E/Id15Pu4UxpqLCvcy3PosvT0gbhjisDI+kjZqOfqb/ZYY3cU/57I9aoxWVFp0AmqpLm2jSDnfjNN7rs7vT/puGKH4dOsBZMKPBwBD60oicnK9Q+EIrg+2eE/EGjtmrYaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.fqrxWSp_1766461882 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 11:51:24 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 net-next 02/15] net/nebula-matrix: add simple probe/remove.
Date: Tue, 23 Dec 2025 11:50:25 +0800
Message-ID: <20251223035113.31122-3-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223035113.31122-1-illusion.wang@nebula-matrix.com>
References: <20251223035113.31122-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our driver architecture is relatively complex because the code
is highly reusable and designed to support multiple features.
For example, our driver can support dpdk while also coexisting
with kernel drivers.
Additionally, the codebase supports multiple chip variants,
each with distinct hardware-software interactions.
To ensure compatibility, our architecture is divided
into the following layers:

1. Dev Layer (Device Layer)
The top-level business logic layer where all operations
are device-centric. Every operation is performed relative
to the device context. The intergration of base fuctions encompasses:
management(ctrl_dev), network(net_dev), common.

2. Service  Layer
The Service layer includes various netops services such as packet receiving/
sending,ethtool services, management services, etc. These are provided to the
upper layer for use or registered as the operations (ops) of related devices.
It describes all the service capabilities possessed by the device.

3. Dispatch Layer
The distribution from services to specific data operations is mainly divided into
two types: direct pass-through and handling by the management PF. It shields the
upper layer from the differences in specific underlying locations.
It describes the processing locations and paths of the services.

4. Resource Layer
Handles tasks dispatched from Dispatch Layer. These tasks fall into two categories:
4.1 Hardware control
The Resource Layer further invokes the HW Layer
when hardware access is needed, as only the HW Layer
has OS-level privileges.
4.2 Software resource management: Operations like packet
statistics collection that don't require hardware access.

5. HW Layer (Hardware Layer)
Serves the Resource Layer by interacting with different
hardware chipsets.Writes to hardware registers to drive
the hardware based on Resource Layer directives.

6. Channel Layer

Handle communication between PF0 and other PF(Our PF0 has ctrl func)/ PF and VF ,
as well as communication with the EMP (Embedded Management Processor),
and provide basic interaction channels.

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
Change-Id: I3a13739295db2191001b228b732993ca067d6c2a
---
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |  38 +++
 .../nbl/nbl_include/nbl_def_common.h          | 240 ++++++++++++++++++
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c | 138 ++++++++++
 3 files changed, 416 insertions(+)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index 898f5752d0b3..f28fe8058c75 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -7,6 +7,12 @@
 #ifndef _NBL_CORE_H_
 #define _NBL_CORE_H_
 #include "nbl_product_base.h"
+#include "nbl_def_common.h"
+
+#define NBL_ADAPTER_TO_PDEV(adapter)		((adapter)->pdev)
+#define NBL_ADAPTER_TO_DEV(adapter)		(&((adapter)->pdev->dev))
+#define NBL_ADAPTER_TO_COMMON(adapter)		(&((adapter)->common))
+#define NBL_ADAPTER_TO_RPDUCT_BASE_OPS(adapter)	((adapter)->product_base_ops)
 #define NBL_CAP_SET_BIT(loc)			(1 << (loc))
 #define NBL_CAP_TEST_BIT(val, loc)		(((val) >> (loc)) & 0x1)
 
@@ -27,4 +33,36 @@ enum {
 	NBL_CAP_HAS_USER_BIT,
 	NBL_CAP_IS_OCP_BIT,
 };
+
+enum nbl_adapter_state {
+	NBL_DOWN,
+	NBL_RESETTING,
+	NBL_RESET_REQUESTED,
+	NBL_INITING,
+	NBL_INIT_FAILED,
+	NBL_RUNNING,
+	NBL_TESTING,
+	NBL_USER,
+	NBL_FATAL_ERR,
+	NBL_STATE_NBITS
+};
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
+	DECLARE_BITMAP(state, NBL_STATE_NBITS);
+};
+
+struct nbl_adapter *nbl_core_init(struct pci_dev *pdev, struct nbl_init_param *param);
+void nbl_core_remove(struct nbl_adapter *adapter);
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
new file mode 100644
index 000000000000..5194e0ef5970
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
@@ -0,0 +1,240 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_DEF_COMMON_H_
+#define _NBL_DEF_COMMON_H_
+
+#include "nbl_include.h"
+#include <linux/netdevice.h>
+#include <linux/netdev_features.h>
+
+#define NBL_OK 0
+#define NBL_CONTINUE 1
+#define NBL_FAIL -1
+
+#define NBL_HASH_CFT_MAX				4
+#define NBL_HASH_CFT_AVL				2
+
+#define NBL_CRC16_CCITT(data, size)		\
+			nbl_calc_crc16(data, size, 0x1021, 0x0000, 1, 0x0000)
+#define NBL_CRC16_CCITT_FALSE(data, size)	\
+			nbl_calc_crc16(data, size, 0x1021, 0xFFFF, 0, 0x0000)
+#define NBL_CRC16_XMODEM(data, size)		\
+			nbl_calc_crc16(data, size, 0x1021, 0x0000, 0, 0x0000)
+#define NBL_CRC16_IBM(data, size)		\
+			nbl_calc_crc16(data, size, 0x8005, 0x0000, 1, 0x0000)
+
+static inline void nbl_tcam_truth_value_convert(u64 *data, u64 *mask)
+{
+	u64 tcam_x = 0;
+	u64 tcam_y = 0;
+
+	tcam_x = *data & ~(*mask);
+	tcam_y = ~(*data) & ~(*mask);
+
+	*data = tcam_x;
+	*mask = tcam_y;
+}
+
+static inline u8 nbl_invert_uint8(const u8 data)
+{
+	u8 i, result = 0;
+
+	for (i = 0; i < 8; i++) {
+		if (data & (1 << i))
+			result |= 1 << (7 - i);
+	}
+
+	return result;
+}
+
+static inline u16 nbl_invert_uint16(const u16 data)
+{
+	u16 i, result = 0;
+
+	for (i = 0; i < 16; i++) {
+		if (data & (1 << i))
+			result |= 1 << (15 - i);
+	}
+
+	return result;
+}
+
+static inline u16 nbl_calc_crc16(const u8 *data, u32 size, u16 crc_poly,
+				 u16 init_value, u8 ref_flag, u16 xorout)
+{
+	u16 crc_reg = init_value, tmp = 0;
+	u8 j, byte = 0;
+
+	while (size--) {
+		byte = *(data++);
+		if (ref_flag)
+			byte = nbl_invert_uint8(byte);
+		crc_reg ^= byte << 8;
+		for (j = 0; j < 8; j++) {
+			tmp = crc_reg & 0x8000;
+			crc_reg <<= 1;
+			if (tmp)
+				crc_reg ^= crc_poly;
+		}
+	}
+
+	if (ref_flag)
+		crc_reg = nbl_invert_uint16(crc_reg);
+
+	crc_reg = crc_reg ^ xorout;
+	return crc_reg;
+}
+
+static inline u16 nbl_hash_transfer(u16 hash, u16 power, u16 depth)
+{
+	u16 temp = 0;
+	u16 val = 0;
+	u32 val2 = 0;
+	u16 off = 16 - power;
+
+	temp = (hash >> power);
+	val = hash << off;
+	val = val >> off;
+
+	if (depth == 0) {
+		val = temp + val;
+		val = val << off;
+		val = val >> off;
+	} else {
+		val2 = val;
+		val2 *= depth;
+		val2 = val2 >> power;
+		val = (u16)val2;
+	}
+
+	return val;
+}
+
+/* debug masks - set these bits in adapter->debug_mask to control output */
+enum nbl_debug_mask {
+	/* BIT0~BIT30 use to define adapter debug_mask */
+	NBL_DEBUG_MAIN			= 0x00000001,
+	NBL_DEBUG_COMMON		= 0x00000002,
+	NBL_DEBUG_DEBUGFS		= 0x00000004,
+	NBL_DEBUG_HW			= 0x00000008,
+	NBL_DEBUG_FLOW			= 0x00000010,
+	NBL_DEBUG_RESOURCE		= 0x00000020,
+	NBL_DEBUG_QUEUE			= 0x00000040,
+	NBL_DEBUG_INTR			= 0x00000080,
+	NBL_DEBUG_ADMINQ		= 0x00000100,
+	NBL_DEBUG_DEVLINK		= 0x00000200,
+	NBL_DEBUG_ACCEL			= 0x00000400,
+	NBL_DEBUG_MBX			= 0x00000800,
+	NBL_DEBUG_ST			= 0x00001000,
+	NBL_DEBUG_VSI			= 0x00002000,
+	NBL_DEBUG_CUSTOMIZED_P4		= 0x00004000,
+
+	/* BIT31 use to distinguish netif debug level or adapter debug_mask */
+	NBL_DEBUG_USER			= 0x80000000,
+
+	/* Means turn on all adapter debug_mask */
+	NBL_DEBUG_ALL			= 0xFFFFFFFF
+};
+
+#define nbl_err(common, lvl, fmt, ...)						\
+do {										\
+	typeof(common) _common = (common);					\
+	if (((lvl) & NBL_COMMON_TO_DEBUG_LVL(_common)))				\
+		dev_err(NBL_COMMON_TO_DEV(_common), fmt, ##__VA_ARGS__);	\
+} while (0)
+
+#define nbl_warn(common, lvl, fmt, ...)						\
+do {										\
+	typeof(common) _common = (common);					\
+	if (((lvl) & NBL_COMMON_TO_DEBUG_LVL(_common)))				\
+		dev_warn(NBL_COMMON_TO_DEV(_common), fmt, ##__VA_ARGS__);	\
+} while (0)
+
+#define nbl_info(common, lvl, fmt, ...)						\
+do {										\
+	typeof(common) _common = (common);					\
+	if (((lvl) & NBL_COMMON_TO_DEBUG_LVL(_common)))				\
+		dev_info(NBL_COMMON_TO_DEV(_common), fmt, ##__VA_ARGS__);	\
+} while (0)
+
+#define nbl_debug(common, lvl, fmt, ...)					\
+do {										\
+	typeof(common) _common = (common);					\
+	if (((lvl) & NBL_COMMON_TO_DEBUG_LVL(_common)))				\
+		dev_dbg(NBL_COMMON_TO_DEV(_common), fmt, ##__VA_ARGS__);	\
+} while (0)
+
+static void __maybe_unused nbl_printk(struct device *dev, int level, const char *format, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	if (WARN_ONCE(level < LOGLEVEL_EMERG || level > LOGLEVEL_DEBUG,
+		      "Level %d is out of range, set to default level\n", level))
+		level = LOGLEVEL_DEFAULT;
+
+	va_start(args, format);
+	vaf.fmt = format;
+	vaf.va = &args;
+
+	dev_printk_emit(level, dev, "%s %s: %pV", dev_driver_string(dev), dev_name(dev),
+			&vaf);
+	va_end(args);
+}
+
+/* support  LOGLEVEL_EMERG/LOGLEVEL_CRIT logvel */
+#define nbl_log(common, level, format, ...)						\
+do {											\
+	typeof(common) _common = (common);						\
+	nbl_printk(NBL_COMMON_TO_DEV(_common), level, format, ##__VA_ARGS__);		\
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
+	u32 debug_lvl;
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
+	u32 eth_max_speed;
+	bool wol_ena;
+};
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
index 1565fa20aae8..b690bac3d306 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -7,16 +7,154 @@
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
+static void nbl_core_setup_product_ops(struct nbl_adapter *adapter, struct nbl_init_param *param,
+				       struct nbl_product_base_ops **product_base_ops)
+{
+	adapter->product_base_ops = &nbl_product_base_ops[param->product_type];
+	*product_base_ops = adapter->product_base_ops;
+}
+
+struct nbl_adapter *nbl_core_init(struct pci_dev *pdev, struct nbl_init_param *param)
+{
+	struct nbl_adapter *adapter;
+	struct nbl_common_info *common;
+	struct nbl_product_base_ops *product_base_ops;
+
+	if (!pdev)
+		return NULL;
+
+	adapter = devm_kzalloc(&pdev->dev, sizeof(struct nbl_adapter), GFP_KERNEL);
+	if (!adapter)
+		return NULL;
+
+	adapter->pdev = pdev;
+	common = NBL_ADAPTER_TO_COMMON(adapter);
+
+	NBL_COMMON_TO_PDEV(common) = pdev;
+	NBL_COMMON_TO_DEV(common) = &pdev->dev;
+	NBL_COMMON_TO_DMA_DEV(common) = &pdev->dev;
+	NBL_COMMON_TO_DEBUG_LVL(common) |= NBL_DEBUG_ALL;
+	NBL_COMMON_TO_VF_CAP(common) = param->caps.is_vf;
+	NBL_COMMON_TO_OCP_CAP(common) = param->caps.is_ocp;
+	NBL_COMMON_TO_PCI_USING_DAC(common) = param->pci_using_dac;
+	NBL_COMMON_TO_PCI_FUNC_ID(common) = PCI_FUNC(pdev->devfn);
+	common->devid    = PCI_SLOT(pdev->devfn);
+	common->bus      = pdev->bus->number;
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
+	struct nbl_product_base_ops *product_base_ops;
+
+	if (!adapter)
+		return;
+
+	dev = NBL_ADAPTER_TO_DEV(adapter);
+	product_base_ops = NBL_ADAPTER_TO_RPDUCT_BASE_OPS(adapter);
+	devm_kfree(dev, adapter);
+}
+
+static void nbl_get_func_param(struct pci_dev *pdev, kernel_ulong_t driver_data,
+			       struct nbl_init_param *param)
+{
+	param->caps.has_ctrl = NBL_CAP_IS_CTRL(driver_data);
+	param->caps.has_net = NBL_CAP_IS_NET(driver_data);
+	param->caps.is_vf = NBL_CAP_IS_VF(driver_data);
+	param->caps.has_user = NBL_CAP_IS_USER(driver_data);
+	param->caps.is_nic = NBL_CAP_IS_NIC(driver_data);
+	param->caps.is_ocp = NBL_CAP_IS_OCP(driver_data);
+
+	if (NBL_CAP_IS_LEONIS(driver_data))
+		param->product_type = NBL_LEONIS_TYPE;
+
+	/**
+	 * Leonis only PF0 has ctrl capability, but PF0's pcie device_id is same with other PF.
+	 * So hanle it special.
+	 **/
+	if (param->product_type == NBL_LEONIS_TYPE && !param->caps.is_vf &&
+	    (PCI_FUNC(pdev->devfn) == 0))
+		param->caps.has_ctrl = 1;
+}
+
 static int nbl_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *id)
 {
 	struct device *dev = &pdev->dev;
+	struct nbl_adapter *adapter = NULL;
+	struct nbl_init_param param = {{0}};
+	int err;
+
+	dev_info(dev, "nbl probe\n");
 
+	err = pci_enable_device(pdev);
+	if (err)
+		return err;
+
+	param.pci_using_dac = true;
+	nbl_get_func_param(pdev, id->driver_data, &param);
+
+	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	if (err) {
+		dev_info(dev, "Configure DMA 64 bit mask failed, err = %d\n", err);
+		param.pci_using_dac = false;
+		err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+		if (err) {
+			dev_err(dev, "Configure DMA 32 bit mask failed, err = %d\n", err);
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
+		err = -EAGAIN;
+		goto adapter_init_err;
+	}
+
+	pci_set_drvdata(pdev, adapter);
 	dev_info(dev, "nbl probe finished\n");
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
+	dev_info(&pdev->dev, "nbl remove\n");
+	pci_disable_sriov(pdev);
+	nbl_core_remove(adapter);
+
+	pci_clear_master(pdev);
+	pci_disable_device(pdev);
+
 	dev_info(&pdev->dev, "nbl remove OK!\n");
 }
 
-- 
2.43.0


