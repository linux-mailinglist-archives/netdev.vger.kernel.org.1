Return-Path: <netdev+bounces-163196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1577AA298CC
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81CC3AA087
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 18:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9048F1FF1DE;
	Wed,  5 Feb 2025 18:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+2EpQuG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DCD1FDA96;
	Wed,  5 Feb 2025 18:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738779750; cv=none; b=kiSS7ohEaCWUx7cKTcd0ov22l6/xg4yqnkIc+9HVXkT8tzuW68h47AsGN/nXP7N4AD4OqZmgRBb3zqhrI7VzWqMI0iUUlvsw7wXB3TaVwWACMPazZ1fTWS0iEBdMBgkETyRoYXZS9YxC2b+cucuXLIO8vzrrjGhjSDPnvZO/cnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738779750; c=relaxed/simple;
	bh=KP4OR6k8kygdu98W0AQGegWNCkTprYuv54jo7Hq0P0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XI1Zq7E3v2bcCF+fYqE3isnRUFd6ntbUNEB8n3gXcONZdruIb35Oz34v44Mn0CfO8Vm+RsGPK8lhS1x5iYBM3CrvL7v2P6vp0xFn4/CVnnbguEXDEmLrqkmLMhYyO/j6Ybp0EtNGDNaPkkvwHe1Jq6Omw6PQwykb4tmMRjJLXr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+2EpQuG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9F9C4CED1;
	Wed,  5 Feb 2025 18:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738779750;
	bh=KP4OR6k8kygdu98W0AQGegWNCkTprYuv54jo7Hq0P0I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o+2EpQuG0i416zMsI7cZ4RLDxwjEVCWUT2AX1voYUvgtPlg5lQUynyogHxZwJt59i
	 Zeh8tGJ2ffK6J/OQEsqZc8lXGEI8NWDbkquRFemUyK9ly19Pskyf0TXubpyreVB2xv
	 StZD2lxNGyCUDDklcOIhE4t8D3jUBDyc4KUT7QPp/uX3+1yrZRlzJTPZ7eYIAOIKtp
	 dLeR5KvlBB6+13YTg8pA0PyWdoBAGbFDoLyliq1PEUmzpvzdYlaPoR7hxpIXHWeW2r
	 lXtVGn7yMV0CxHTfEypeWTsoSqBtaBS4WX3zZROtIVrH9bn2eV3+XYnrNzZWUzYYoa
	 B3bsVkUQx5NvQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 05 Feb 2025 19:21:29 +0100
Subject: [PATCH net-next 10/13] net: airoha: Introduce PPE initialization
 via NPU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-airoha-en7581-flowtable-offload-v1-10-d362cfa97b01@kernel.org>
References: <20250205-airoha-en7581-flowtable-offload-v1-0-d362cfa97b01@kernel.org>
In-Reply-To: <20250205-airoha-en7581-flowtable-offload-v1-0-d362cfa97b01@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 upstream@airoha.com
X-Mailer: b4 0.14.2

Packet Processor Engine (PPE) module available on EN7581 SoC populates
the PPE table with 5-tuples flower rules learned from traffic forwarded
between the GDM ports connected to the Packet Switch Engine (PSE) module.
The airoha_eth driver can enable hw acceleration of learned 5-tuples
rules if the user configure them in netfilter flowtable (netfilter
flowtable support will be added with subsequent patches).
airoha_eth driver configures and collects data from the PPE module via a
Network Processor Unit (NPU) RISC-V module available on the EN7581 SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/Kconfig       |   5 +
 drivers/net/ethernet/airoha/Makefile      |   4 +-
 drivers/net/ethernet/airoha/airoha_eth.c  |   7 +-
 drivers/net/ethernet/airoha/airoha_eth.h  |  88 ++++++
 drivers/net/ethernet/airoha/airoha_npu.c  | 450 ++++++++++++++++++++++++++++++
 drivers/net/ethernet/airoha/airoha_ppe.c  | 128 +++++++++
 drivers/net/ethernet/airoha/airoha_regs.h | 102 ++++++-
 7 files changed, 775 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/airoha/Kconfig b/drivers/net/ethernet/airoha/Kconfig
index b6a131845f13b23a12464cfc281e3abe5699389f..c5445431595f9d2098cee9be8683b71ca1da1ea4 100644
--- a/drivers/net/ethernet/airoha/Kconfig
+++ b/drivers/net/ethernet/airoha/Kconfig
@@ -7,10 +7,15 @@ config NET_VENDOR_AIROHA
 
 if NET_VENDOR_AIROHA
 
+config NET_AIROHA_NPU
+	depends on ARCH_AIROHA || COMPILE_TEST
+	def_bool NET_AIROHA != n
+
 config NET_AIROHA
 	tristate "Airoha SoC Gigabit Ethernet support"
 	depends on NET_DSA || !NET_DSA
 	select PAGE_POOL
+	select WANT_DEV_COREDUMP
 	help
 	  This driver supports the gigabit ethernet MACs in the
 	  Airoha SoC family.
diff --git a/drivers/net/ethernet/airoha/Makefile b/drivers/net/ethernet/airoha/Makefile
index 73a6f3680a4c4ce92ee785d83b905d76a63421df..50028cfc3e3e04efbdd353b1bd65f46b488637d8 100644
--- a/drivers/net/ethernet/airoha/Makefile
+++ b/drivers/net/ethernet/airoha/Makefile
@@ -3,4 +3,6 @@
 # Airoha for the Mediatek SoCs built-in ethernet macs
 #
 
-obj-$(CONFIG_NET_AIROHA) += airoha_eth.o
+obj-$(CONFIG_NET_AIROHA) += airoha-eth.o
+airoha-eth-y := airoha_eth.o airoha_ppe.o
+airoha-eth-$(CONFIG_NET_AIROHA_NPU) += airoha_npu.o
diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 52be276039eff7772b3c604cf7db5d456ec155ab..6c0271899de05f99df32d6ee891f305957abfdc8 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -3,9 +3,6 @@
  * Copyright (c) 2024 AIROHA Inc
  * Author: Lorenzo Bianconi <lorenzo@kernel.org>
  */
-#include <linux/of.h>
-#include <linux/of_net.h>
-#include <linux/platform_device.h>
 #include <linux/tcp.h>
 #include <linux/u64_stats_sync.h>
 #include <net/dsa.h>
@@ -1301,6 +1298,9 @@ static int airoha_hw_init(struct platform_device *pdev,
 			return err;
 	}
 
+	if (airoha_ppe_init(eth))
+		dev_err(eth->dev, "ppe initialization failed\n");
+
 	set_bit(DEV_STATE_INITIALIZED, &eth->state);
 
 	return 0;
@@ -2496,6 +2496,7 @@ static void airoha_remove(struct platform_device *pdev)
 	}
 	free_netdev(eth->napi_dev);
 
+	airoha_ppe_deinit(eth);
 	platform_set_drvdata(pdev, NULL);
 }
 
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 44834227a58982d4491f3d8174b9e0bea542f785..e07c999ed49eca630537bccf37c98762e9e7f585 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -11,8 +11,13 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
+#include <linux/of.h>
+#include <linux/of_net.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/reset.h>
 
+#define AIROHA_NPU_NUM_CORES		8
 #define AIROHA_MAX_NUM_GDM_PORTS	4
 #define AIROHA_MAX_NUM_QDMA		2
 #define AIROHA_MAX_DSA_PORTS		7
@@ -44,6 +49,14 @@
 #define QDMA_METER_IDX(_n)		((_n) & 0xff)
 #define QDMA_METER_GROUP(_n)		(((_n) >> 8) & 0x3)
 
+#define PPE_NUM				2
+#define PPE_SRAM_NUM_ENTRIES		(16 * 1024)
+#define PPE1_SRAM_NUM_ENTRIES		(8 * 1024)
+#define PPE_DRAM_NUM_ENTRIES		(16 * 1024)
+#define PPE_NUM_ENTRIES			(PPE_SRAM_NUM_ENTRIES + PPE_DRAM_NUM_ENTRIES)
+#define PPE_HASH_MASK			(PPE_NUM_ENTRIES - 1)
+#define PPE_ENTRY_SIZE			80
+
 #define MTK_HDR_LEN			4
 #define MTK_HDR_XMIT_TAGGED_TPID_8100	1
 #define MTK_HDR_XMIT_TAGGED_TPID_88A8	2
@@ -195,6 +208,10 @@ struct airoha_hw_stats {
 	u64 rx_len[7];
 };
 
+struct airoha_foe_entry {
+	u8 data[PPE_ENTRY_SIZE];
+};
+
 struct airoha_qdma {
 	struct airoha_eth *eth;
 	void __iomem *regs;
@@ -234,12 +251,36 @@ struct airoha_gdm_port {
 	struct metadata_dst *dsa_meta[AIROHA_MAX_DSA_PORTS];
 };
 
+struct airoha_npu {
+	struct platform_device *pdev;
+	struct device_node *np;
+
+	void __iomem *base;
+
+	struct airoha_npu_core {
+		struct airoha_npu *npu;
+		/* protect concurrent npu memory accesses */
+		spinlock_t lock;
+		struct work_struct wdt_work;
+	} cores[AIROHA_NPU_NUM_CORES];
+};
+
+struct airoha_ppe {
+	struct airoha_eth *eth;
+
+	void *foe;
+	dma_addr_t foe_dma;
+};
+
 struct airoha_eth {
 	struct device *dev;
 
 	unsigned long state;
 	void __iomem *fe_regs;
 
+	struct airoha_npu *npu;
+	struct airoha_ppe *ppe;
+
 	struct reset_control_bulk_data rsts[AIROHA_MAX_NUM_RSTS];
 	struct reset_control_bulk_data xsi_rsts[AIROHA_MAX_NUM_XSI_RSTS];
 
@@ -275,4 +316,51 @@ u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val);
 #define airoha_qdma_clear(qdma, offset, val)			\
 	airoha_rmw((qdma)->regs, (offset), (val), 0)
 
+bool airoha_ppe2_is_enabled(struct airoha_eth *eth);
+
+#ifdef CONFIG_NET_AIROHA_NPU
+int airoha_ppe_init(struct airoha_eth *eth);
+void airoha_ppe_deinit(struct airoha_eth *eth);
+struct airoha_npu *airoha_npu_init(struct airoha_eth *eth);
+void airoha_npu_deinit(struct airoha_npu *npu);
+int airoha_npu_ppe_init(struct airoha_npu *npu);
+int airoha_npu_ppe_deinit(struct airoha_npu *npu);
+int airoha_npu_flush_ppe_sram_entries(struct airoha_npu *npu,
+				      struct airoha_ppe *ppe);
+#else
+static inline int airoha_ppe_init(struct airoha_eth *eth)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void airoha_ppe_deinit(struct airoha_eth *eth)
+{
+}
+
+static inline struct airoha_npu *airoha_npu_init(struct airoha_eth *eth)
+{
+	return NULL;
+}
+
+static inline void airoha_npu_deinit(struct airoha_npu *npu)
+{
+}
+
+static inline int airoha_npu_ppe_init(struct airoha_npu *npu)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int airoha_npu_ppe_deinit(struct airoha_npu *npu)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int airoha_npu_flush_ppe_sram_entries(struct airoha_npu *npu,
+						    struct airoha_ppe *ppe)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_NET_AIROHA_NPU */
+
 #endif /* AIROHA_ETH_H */
diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
new file mode 100644
index 0000000000000000000000000000000000000000..23a3c9c410e193f2694b6a4bc974b5d985c7e004
--- /dev/null
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -0,0 +1,450 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 AIROHA Inc
+ * Author: Lorenzo Bianconi <lorenzo@kernel.org>
+ */
+
+#include <linux/devcoredump.h>
+#include <linux/firmware.h>
+#include <linux/of_reserved_mem.h>
+
+#include "airoha_eth.h"
+
+#define NPU_EN7581_FIRMWARE_DATA		"airoha/en7581_npu_data.bin"
+#define NPU_EN7581_FIRMWARE_RV32		"airoha/en7581_npu_rv32.bin"
+#define NPU_EN7581_FIRMWARE_RV32_MAX_SIZE	0x200000
+#define NPU_EN7581_FIRMWARE_DATA_MAX_SIZE	0x10000
+#define NPU_DUMP_SIZE				512
+
+#define REG_NPU_LOCAL_SRAM		0x0
+
+#define NPU_PC_BASE_ADDR		0x305000
+#define REG_PC_DBG(_n)			(0x305000 + ((_n) * 0x100))
+
+#define NPU_CLUSTER_BASE_ADDR		0x306000
+
+#define REG_CR_BOOT_TRIGGER		(NPU_CLUSTER_BASE_ADDR + 0x000)
+#define REG_CR_BOOT_CONFIG		(NPU_CLUSTER_BASE_ADDR + 0x004)
+#define REG_CR_BOOT_BASE(_n)		(NPU_CLUSTER_BASE_ADDR + 0x020 + ((_n) << 2))
+
+#define NPU_MBOX_BASE_ADDR		0x30c000
+
+#define REG_CR_MBOX_INT_STATUS		(NPU_MBOX_BASE_ADDR + 0x000)
+#define MBOX_INT_STATUS_MASK		BIT(8)
+
+#define REG_CR_MBOX_INT_MASK(_n)	(NPU_MBOX_BASE_ADDR + 0x004 + ((_n) << 2))
+#define REG_CR_MBQ0_CTRL(_n)		(NPU_MBOX_BASE_ADDR + 0x030 + ((_n) << 2))
+#define REG_CR_MBQ8_CTRL(_n)		(NPU_MBOX_BASE_ADDR + 0x0b0 + ((_n) << 2))
+#define REG_CR_NPU_MIB(_n)		(NPU_MBOX_BASE_ADDR + 0x140 + ((_n) << 2))
+
+#define NPU_TIMER_BASE_ADDR		0x310100
+#define REG_WDT_TIMER_CTRL(_n)		(NPU_TIMER_BASE_ADDR + ((_n) * 0x100))
+#define WDT_EN_MASK			BIT(25)
+#define WDT_INTR_MASK			BIT(21)
+
+enum {
+	NPU_OP_SET = 1,
+	NPU_OP_SET_NO_WAIT,
+	NPU_OP_GET,
+	NPU_OP_GET_NO_WAIT,
+};
+
+enum {
+	NPU_FUNC_WIFI,
+	NPU_FUNC_TUNNEL,
+	NPU_FUNC_NOTIFY,
+	NPU_FUNC_DBA,
+	NPU_FUNC_TR471,
+	NPU_FUNC_PPE,
+};
+
+enum {
+	NPU_MBOX_ERROR,
+	NPU_MBOX_SUCCESS,
+};
+
+enum {
+	PPE_FUNC_SET_WAIT,
+	PPE_FUNC_SET_WAIT_HWNAT_INIT,
+	PPE_FUNC_SET_WAIT_HWNAT_DEINIT,
+	PPE_FUNC_SET_WAIT_API,
+};
+
+enum {
+	PPE2_SRAM_SET_ENTRY,
+	PPE_SRAM_SET_ENTRY,
+	PPE_SRAM_SET_VAL,
+	PPE_SRAM_RESET_VAL,
+};
+
+enum {
+	QDMA_WAN_ETHER = 1,
+	QDMA_WAN_PON_XDSL,
+};
+
+struct npu_mbox_metadata {
+	union {
+		struct {
+			u16 wait_rsp:1;
+			u16 done:1;
+			u16 status:3;
+			u16 static_buf:1;
+			u16 rsv:5;
+			u16 func_id:4;
+		};
+		u16 data;
+	};
+};
+
+#define PPE_TYPE_L2B_IPV4	2
+#define PPE_TYPE_L2B_IPV4_IPV6	3
+
+struct ppe_mbox_data {
+	u32 func_type;
+	u32 func_id;
+	union {
+		struct {
+			u8 cds;
+			u8 xpon_hal_api;
+			u8 wan_xsi;
+			u8 ct_joyme4;
+			int ppe_type;
+			int wan_mode;
+			int wan_sel;
+		} init_info;
+		struct {
+			int func_id;
+			u32 size;
+			u32 data;
+		} set_info;
+	};
+};
+
+static u32 airoha_npu_rr(struct airoha_npu *npu, u32 reg)
+{
+	return readl(npu->base + reg);
+}
+
+static void airoha_npu_wr(struct airoha_npu *npu, u32 reg, u32 val)
+{
+	writel(val, npu->base + reg);
+}
+
+static u32 airoha_npu_rmw(struct airoha_npu *npu, u32 reg, u32 mask, u32 val)
+{
+	val |= airoha_npu_rr(npu, reg) & ~mask;
+	airoha_npu_wr(npu, reg, val);
+
+	return val;
+}
+
+static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
+			       void *p, int size)
+{
+	struct device *dev = &npu->pdev->dev;
+	struct npu_mbox_metadata meta = {
+		.wait_rsp = 1,
+		.func_id = func_id,
+	};
+	u16 core = 0; /* FIXME */
+	u32 val, offset = core << 4;
+	dma_addr_t dma_addr;
+	void *addr;
+	int ret;
+
+	addr = kzalloc(size, GFP_ATOMIC | GFP_DMA);
+	if (!addr)
+		return -ENOMEM;
+
+	memcpy(addr, p, size);
+	dma_addr = dma_map_single(dev, addr, size, DMA_TO_DEVICE);
+	ret = dma_mapping_error(dev, dma_addr);
+	if (ret)
+		goto out;
+
+	spin_lock_bh(&npu->cores[core].lock);
+
+	airoha_npu_wr(npu, REG_CR_MBQ0_CTRL(0) + offset, dma_addr);
+	airoha_npu_wr(npu, REG_CR_MBQ0_CTRL(1) + offset, size);
+	val = airoha_npu_rr(npu, REG_CR_MBQ0_CTRL(2) + offset);
+	airoha_npu_wr(npu, REG_CR_MBQ0_CTRL(2) + offset, val + 1);
+	airoha_npu_wr(npu, REG_CR_MBQ0_CTRL(3) + offset, meta.data);
+
+	ret = read_poll_timeout_atomic(airoha_npu_rr, meta.data, meta.done,
+				       100, 100 * MSEC_PER_SEC, false, npu,
+				       REG_CR_MBQ0_CTRL(3) + offset);
+	if (!ret)
+		ret = meta.status == NPU_MBOX_SUCCESS ? 0 : -EINVAL;
+
+	spin_unlock_bh(&npu->cores[core].lock);
+
+	dma_unmap_single(dev, dma_addr, size, DMA_TO_DEVICE);
+out:
+	kfree(addr);
+
+	return ret;
+}
+
+static int airoha_npu_run_firmware(struct airoha_npu *npu, struct reserved_mem *rmem)
+{
+	struct device *dev = &npu->pdev->dev;
+	const struct firmware *fw;
+	void __iomem *addr;
+	int ret;
+
+	ret = request_firmware(&fw, NPU_EN7581_FIRMWARE_RV32, dev);
+	if (ret)
+		return ret;
+
+	if (fw->size > NPU_EN7581_FIRMWARE_RV32_MAX_SIZE) {
+		dev_err(dev, "%s: fw size too overlimit (%ld)\n",
+			NPU_EN7581_FIRMWARE_RV32, fw->size);
+		ret = -E2BIG;
+		goto out;
+	}
+
+	addr = devm_ioremap(dev, rmem->base, rmem->size);
+	if (!addr) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	memcpy_toio(addr, fw->data, fw->size);
+	release_firmware(fw);
+
+	ret = request_firmware(&fw, NPU_EN7581_FIRMWARE_DATA, dev);
+	if (ret)
+		return ret;
+
+	if (fw->size > NPU_EN7581_FIRMWARE_DATA_MAX_SIZE) {
+		dev_err(dev, "%s: fw size too overlimit (%ld)\n",
+			NPU_EN7581_FIRMWARE_DATA, fw->size);
+		ret = -E2BIG;
+		goto out;
+	}
+
+	memcpy_toio(npu->base + REG_NPU_LOCAL_SRAM, fw->data, fw->size);
+out:
+	release_firmware(fw);
+
+	return ret;
+}
+
+static irqreturn_t airoha_npu_mbox_handler(int irq, void *npu_instance)
+{
+	struct airoha_npu *npu = npu_instance;
+	struct npu_mbox_metadata meta;
+
+	/* clear mbox interrupt status */
+	airoha_npu_wr(npu, REG_CR_MBOX_INT_STATUS, MBOX_INT_STATUS_MASK);
+
+	/* acknowledge npu */
+	meta.data = airoha_npu_rr(npu, REG_CR_MBQ8_CTRL(3));
+	meta.status = 0;
+	meta.done = 1;
+	airoha_npu_wr(npu, REG_CR_MBQ8_CTRL(3), meta.data);
+
+	return IRQ_HANDLED;
+}
+
+int airoha_npu_ppe_init(struct airoha_npu *npu)
+{
+	struct ppe_mbox_data ppe_data = {
+		.func_type = NPU_OP_SET,
+		.func_id = PPE_FUNC_SET_WAIT_HWNAT_INIT,
+		.init_info = {
+			.ppe_type = PPE_TYPE_L2B_IPV4_IPV6,
+			.wan_mode = QDMA_WAN_ETHER,
+		},
+	};
+
+	return airoha_npu_send_msg(npu, NPU_FUNC_PPE, &ppe_data,
+				   sizeof(struct ppe_mbox_data));
+}
+
+int airoha_npu_ppe_deinit(struct airoha_npu *npu)
+{
+	struct ppe_mbox_data ppe_data = {
+		.func_type = NPU_OP_SET,
+		.func_id = PPE_FUNC_SET_WAIT_HWNAT_DEINIT,
+	};
+
+	return airoha_npu_send_msg(npu, NPU_FUNC_PPE, &ppe_data,
+				   sizeof(struct ppe_mbox_data));
+}
+
+int airoha_npu_flush_ppe_sram_entries(struct airoha_npu *npu,
+				      struct airoha_ppe *ppe)
+{
+	struct ppe_mbox_data ppe_data = {
+		.func_type = NPU_OP_SET,
+		.func_id = PPE_FUNC_SET_WAIT_API,
+		.set_info = {
+			.func_id = PPE_SRAM_RESET_VAL,
+			.data = ppe->foe_dma,
+			.size = PPE_SRAM_NUM_ENTRIES,
+		},
+	};
+	u32 sram_tb_size;
+
+	sram_tb_size = PPE_SRAM_NUM_ENTRIES * sizeof(struct airoha_foe_entry);
+	if (airoha_ppe2_is_enabled(ppe->eth))
+		memset(ppe->foe, 0, sram_tb_size / 2);
+	else
+		memset(ppe->foe, 0, sram_tb_size);
+
+	return airoha_npu_send_msg(npu, NPU_FUNC_PPE, &ppe_data,
+				   sizeof(struct ppe_mbox_data));
+}
+
+static void airoha_npu_wdt_work(struct work_struct *work)
+{
+	struct airoha_npu_core *core;
+	struct airoha_npu *npu;
+	void *dump;
+	int c;
+
+	core = container_of(work, struct airoha_npu_core, wdt_work);
+	npu = core->npu;
+
+	dump = vzalloc(NPU_DUMP_SIZE);
+	if (!dump)
+		return;
+
+	c = core - &npu->cores[0];
+	snprintf(dump, NPU_DUMP_SIZE, "PC: %08x SP: %08x LR: %08x\n",
+		 airoha_npu_rr(npu, REG_PC_DBG(c)),
+		 airoha_npu_rr(npu, REG_PC_DBG(c) + 0x4),
+		 airoha_npu_rr(npu, REG_PC_DBG(c) + 0x8));
+
+	dev_coredumpv(&npu->pdev->dev, dump, NPU_DUMP_SIZE, GFP_KERNEL);
+}
+
+static irqreturn_t airoha_npu_wdt_handler(int irq, void *core_instance)
+{
+	struct airoha_npu_core *core = core_instance;
+	struct airoha_npu *npu = core->npu;
+	int c = core - &npu->cores[0];
+	u32 val;
+
+	airoha_npu_rmw(npu, REG_WDT_TIMER_CTRL(c), 0, WDT_INTR_MASK);
+	val = airoha_npu_rr(npu, REG_WDT_TIMER_CTRL(c));
+	if (FIELD_GET(WDT_EN_MASK, val))
+		schedule_work(&core->wdt_work);
+
+	return IRQ_HANDLED;
+}
+
+struct airoha_npu *airoha_npu_init(struct airoha_eth *eth)
+{
+	struct reserved_mem *rmem;
+	int i, irq, err = -ENODEV;
+	struct airoha_npu *npu;
+	struct device_node *np;
+
+	npu = devm_kzalloc(eth->dev, sizeof(*npu), GFP_KERNEL);
+	if (!npu)
+		return ERR_PTR(-ENOMEM);
+
+	npu->np = of_parse_phandle(eth->dev->of_node, "airoha,npu", 0);
+	if (!npu->np)
+		return ERR_PTR(-ENODEV);
+
+	npu->pdev = of_find_device_by_node(npu->np);
+	if (!npu->pdev)
+		goto error_of_node_put;
+
+	get_device(&npu->pdev->dev);
+
+	npu->base = devm_platform_ioremap_resource(npu->pdev, 0);
+	if (IS_ERR(npu->base))
+		goto error_put_dev;
+
+	np = of_parse_phandle(npu->np, "memory-region", 0);
+	if (!np)
+		goto error_put_dev;
+
+	rmem = of_reserved_mem_lookup(np);
+	of_node_put(np);
+
+	if (!rmem)
+		goto error_put_dev;
+
+	irq = platform_get_irq(npu->pdev, 0);
+	if (irq < 0) {
+		err = irq;
+		goto error_put_dev;
+	}
+
+	err = devm_request_irq(&npu->pdev->dev, irq, airoha_npu_mbox_handler,
+			       IRQF_SHARED, "airoha-npu-mbox", npu);
+	if (err)
+		goto error_put_dev;
+
+	for (i = 0; i < ARRAY_SIZE(npu->cores); i++) {
+		struct airoha_npu_core *core = &npu->cores[i];
+
+		spin_lock_init(&core->lock);
+		core->npu = npu;
+
+		irq = platform_get_irq(npu->pdev, i + 1);
+		if (irq < 0) {
+			err = irq;
+			goto error_put_dev;
+		}
+
+		err = devm_request_irq(&npu->pdev->dev, irq,
+				       airoha_npu_wdt_handler, IRQF_SHARED,
+				       "airoha-npu-wdt", core);
+		if (err)
+			goto error_put_dev;
+
+		INIT_WORK(&core->wdt_work, airoha_npu_wdt_work);
+	}
+
+	if (dma_set_coherent_mask(&npu->pdev->dev, 0xbfffffff))
+		dev_err(&npu->pdev->dev,
+			"failed coherent DMA configuration\n");
+
+	err = airoha_npu_run_firmware(npu, rmem);
+	if (err)
+		goto error_put_dev;
+
+	airoha_npu_wr(npu, REG_CR_NPU_MIB(10),
+		      rmem->base + NPU_EN7581_FIRMWARE_RV32_MAX_SIZE);
+	airoha_npu_wr(npu, REG_CR_NPU_MIB(11), 0x40000); /* SRAM 256K */
+	airoha_npu_wr(npu, REG_CR_NPU_MIB(12), 0);
+	airoha_npu_wr(npu, REG_CR_NPU_MIB(21), 1);
+	msleep(100);
+
+	/* setting booting address */
+	for (i = 0; i < AIROHA_NPU_NUM_CORES; i++)
+		airoha_npu_wr(npu, REG_CR_BOOT_BASE(i), rmem->base);
+	usleep_range(1000, 2000);
+
+	/* enable NPU cores */
+	/* do not start core3 since it is used for WiFi offloading */
+	airoha_npu_wr(npu, REG_CR_BOOT_CONFIG, 0xf7);
+	airoha_npu_wr(npu, REG_CR_BOOT_TRIGGER, 0x1);
+	msleep(100);
+
+	return npu;
+
+error_put_dev:
+	put_device(&npu->pdev->dev);
+error_of_node_put:
+	of_node_put(npu->np);
+
+	return ERR_PTR(err);
+}
+
+void airoha_npu_deinit(struct airoha_npu *npu)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(npu->cores); i++)
+		cancel_work_sync(&npu->cores[i].wdt_work);
+
+	put_device(&npu->pdev->dev);
+	of_node_put(npu->np);
+}
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
new file mode 100644
index 0000000000000000000000000000000000000000..bb64c3c09fa37b797bd028ad7012d81662d82ba6
--- /dev/null
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 AIROHA Inc
+ * Author: Lorenzo Bianconi <lorenzo@kernel.org>
+ */
+
+#include "airoha_regs.h"
+#include "airoha_eth.h"
+
+bool airoha_ppe2_is_enabled(struct airoha_eth *eth)
+{
+	return airoha_fe_rr(eth, REG_PPE_GLO_CFG(1)) & PPE_GLO_CFG_EN_MASK;
+}
+
+static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
+{
+	struct airoha_eth *eth = ppe->eth;
+	u32 sram_tb_size;
+	int i;
+
+	sram_tb_size = PPE_SRAM_NUM_ENTRIES * sizeof(struct airoha_foe_entry);
+	for (i = 0; i < PPE_NUM; i++) {
+		airoha_fe_wr(eth, REG_PPE_TB_BASE(i),
+			     ppe->foe_dma + sram_tb_size);
+
+		airoha_fe_rmw(eth, REG_PPE_BND_AGE0(i),
+			      PPE_BIND_AGE0_DELTA_NON_L4 |
+			      PPE_BIND_AGE0_DELTA_UDP,
+			      FIELD_PREP(PPE_BIND_AGE0_DELTA_NON_L4, 1) |
+			      FIELD_PREP(PPE_BIND_AGE0_DELTA_UDP, 12));
+		airoha_fe_rmw(eth, REG_PPE_BND_AGE1(i),
+			      PPE_BIND_AGE1_DELTA_TCP_FIN |
+			      PPE_BIND_AGE1_DELTA_TCP,
+			      FIELD_PREP(PPE_BIND_AGE1_DELTA_TCP_FIN, 1) |
+			      FIELD_PREP(PPE_BIND_AGE1_DELTA_TCP, 7));
+
+		airoha_fe_rmw(eth, REG_PPE_TB_HASH_CFG(i),
+			      PPE_SRAM_TABLE_EN_MASK |
+			      PPE_SRAM_HASH1_EN_MASK |
+			      PPE_DRAM_TABLE_EN_MASK |
+			      PPE_SRAM_HASH0_MODE_MASK |
+			      PPE_SRAM_HASH1_MODE_MASK |
+			      PPE_DRAM_HASH0_MODE_MASK |
+			      PPE_DRAM_HASH1_MODE_MASK,
+			      FIELD_PREP(PPE_SRAM_TABLE_EN_MASK, 1) |
+			      FIELD_PREP(PPE_SRAM_HASH1_EN_MASK, 1) |
+			      FIELD_PREP(PPE_SRAM_HASH1_MODE_MASK, 1) |
+			      FIELD_PREP(PPE_DRAM_HASH1_MODE_MASK, 3));
+
+		airoha_fe_rmw(eth, REG_PPE_TB_CFG(i),
+			      PPE_TB_CFG_SEARCH_MISS_MASK |
+			      PPE_TB_ENTRY_SIZE_MASK,
+			      FIELD_PREP(PPE_TB_CFG_SEARCH_MISS_MASK, 3) |
+			      FIELD_PREP(PPE_TB_ENTRY_SIZE_MASK, 0));
+
+		airoha_fe_wr(eth, REG_PPE_HASH_SEED(i), PPE_HASH_SEED);
+	}
+
+	if (airoha_ppe2_is_enabled(eth)) {
+		airoha_fe_rmw(eth, REG_PPE_TB_CFG(0),
+			      PPE_SRAM_TB_NUM_ENTRY_MASK |
+			      PPE_DRAM_TB_NUM_ENTRY_MASK,
+			      FIELD_PREP(PPE_SRAM_TB_NUM_ENTRY_MASK, 3) |
+			      FIELD_PREP(PPE_DRAM_TB_NUM_ENTRY_MASK, 4));
+		airoha_fe_rmw(eth, REG_PPE_TB_CFG(1),
+			      PPE_SRAM_TB_NUM_ENTRY_MASK |
+			      PPE_DRAM_TB_NUM_ENTRY_MASK,
+			      FIELD_PREP(PPE_SRAM_TB_NUM_ENTRY_MASK, 3) |
+			      FIELD_PREP(PPE_DRAM_TB_NUM_ENTRY_MASK, 4));
+	} else {
+		airoha_fe_rmw(eth, REG_PPE_TB_CFG(0),
+			      PPE_SRAM_TB_NUM_ENTRY_MASK |
+			      PPE_DRAM_TB_NUM_ENTRY_MASK,
+			      FIELD_PREP(PPE_SRAM_TB_NUM_ENTRY_MASK, 4) |
+			      FIELD_PREP(PPE_DRAM_TB_NUM_ENTRY_MASK, 4));
+	}
+}
+
+int airoha_ppe_init(struct airoha_eth *eth)
+{
+	struct airoha_npu *npu;
+	struct airoha_ppe *ppe;
+	int foe_size, err;
+
+	ppe = devm_kzalloc(eth->dev, sizeof(*ppe), GFP_KERNEL);
+	if (!ppe)
+		return -ENOMEM;
+
+	foe_size = PPE_NUM_ENTRIES * sizeof(struct airoha_foe_entry);
+	ppe->foe = dmam_alloc_coherent(eth->dev, foe_size, &ppe->foe_dma,
+				       GFP_KERNEL);
+	if (!ppe->foe)
+		return -ENOMEM;
+
+	memset(ppe->foe, 0, foe_size);
+	ppe->eth = eth;
+	eth->ppe = ppe;
+
+	npu = airoha_npu_init(eth);
+	if (IS_ERR(npu))
+		return PTR_ERR(npu);
+
+	eth->npu = npu;
+	err = airoha_npu_ppe_init(npu);
+	if (err)
+		goto error;
+
+	airoha_ppe_hw_init(ppe);
+	err = airoha_npu_flush_ppe_sram_entries(npu, ppe);
+	if (err)
+		goto error;
+
+	return 0;
+
+error:
+	airoha_npu_deinit(npu);
+	eth->npu = NULL;
+
+	return err;
+}
+
+void airoha_ppe_deinit(struct airoha_eth *eth)
+{
+	if (eth->npu) {
+		airoha_npu_ppe_deinit(eth->npu);
+		airoha_npu_deinit(eth->npu);
+	}
+}
diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
index e467dd81ff44a9ad560226cab42b7431812f5fb9..3ad2c5d11c2f9b0d00744cc43394d02d47347f61 100644
--- a/drivers/net/ethernet/airoha/airoha_regs.h
+++ b/drivers/net/ethernet/airoha/airoha_regs.h
@@ -15,6 +15,7 @@
 #define CDM1_BASE			0x0400
 #define GDM1_BASE			0x0500
 #define PPE1_BASE			0x0c00
+#define PPE2_BASE			0x1c00
 
 #define CDM2_BASE			0x1400
 #define GDM2_BASE			0x1500
@@ -36,6 +37,7 @@
 #define FE_RST_GDM3_MBI_ARB_MASK	BIT(2)
 #define FE_RST_CORE_MASK		BIT(0)
 
+#define REG_FE_FOE_TS			0x0010
 #define REG_FE_WAN_MAC_H		0x0030
 #define REG_FE_LAN_MAC_H		0x0040
 
@@ -192,11 +194,101 @@
 #define REG_FE_GDM_RX_ETH_L511_CNT_L(_n)	(GDM_BASE(_n) + 0x198)
 #define REG_FE_GDM_RX_ETH_L1023_CNT_L(_n)	(GDM_BASE(_n) + 0x19c)
 
-#define REG_PPE1_TB_HASH_CFG		(PPE1_BASE + 0x250)
-#define PPE1_SRAM_TABLE_EN_MASK		BIT(0)
-#define PPE1_SRAM_HASH1_EN_MASK		BIT(8)
-#define PPE1_DRAM_TABLE_EN_MASK		BIT(16)
-#define PPE1_DRAM_HASH1_EN_MASK		BIT(24)
+#define REG_PPE_GLO_CFG(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x200)
+#define PPE_GLO_CFG_BUSY_MASK			BIT(31)
+#define PPE_GLO_CFG_FLOW_DROP_UPDATE_MASK	BIT(9)
+#define PPE_GLO_CFG_PSE_HASH_OFS_MASK		BIT(6)
+#define PPE_GLO_CFG_PPE_BSWAP_MASK		BIT(5)
+#define PPE_GLO_CFG_TTL_DROP_MASK		BIT(4)
+#define PPE_GLO_CFG_IP4_CS_DROP_MASK		BIT(3)
+#define PPE_GLO_CFG_IP4_L4_CS_DROP_MASK		BIT(2)
+#define PPE_GLO_CFG_EN_MASK			BIT(0)
+
+#define REG_PPE_PPE_FLOW_CFG(_n)		(((_n) ? PPE2_BASE : PPE1_BASE) + 0x204)
+#define PPE_FLOW_CFG_IP6_HASH_GRE_KEY_MASK	BIT(20)
+#define PPE_FLOW_CFG_IP4_HASH_GRE_KEY_MASK	BIT(19)
+#define PPE_FLOW_CFG_IP4_HASH_FLOW_LABEL_MASK	BIT(18)
+#define PPE_FLOW_CFG_IP4_NAT_FRAG_MASK		BIT(17)
+#define PPE_FLOW_CFG_IP_PROTO_BLACKLIST_MASK	BIT(16)
+#define PPE_FLOW_CFG_IP4_DSLITE_MASK		BIT(14)
+#define PPE_FLOW_CFG_IP4_NAPT_MASK		BIT(13)
+#define PPE_FLOW_CFG_IP4_NAT_MASK		BIT(12)
+#define PPE_FLOW_CFG_IP6_6RD_MASK		BIT(10)
+#define PPE_FLOW_CFG_IP6_5T_ROUTE_MASK		BIT(9)
+#define PPE_FLOW_CFG_IP6_3T_ROUTE_MASK		BIT(8)
+#define PPE_FLOW_CFG_IP4_UDP_FRAG_MASK		BIT(7)
+#define PPE_FLOW_CFG_IP4_TCP_FRAG_MASK		BIT(6)
+
+#define REG_PPE_IP_PROTO_CHK(_n)		(((_n) ? PPE2_BASE : PPE1_BASE) + 0x208)
+#define PPE_IP_PROTO_CHK_IPV4_MASK		GENMASK(15, 0)
+#define PPE_IP_PROTO_CHK_IPV6_MASK		GENMASK(31, 16)
+
+#define REG_PPE_TB_CFG(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x21c)
+#define PPE_SRAM_TB_NUM_ENTRY_MASK		GENMASK(26, 24)
+#define PPE_TB_CFG_KEEPALIVE_MASK		GENMASK(13, 12)
+#define PPE_TB_CFG_AGE_TCP_FIN_MASK		BIT(11)
+#define PPE_TB_CFG_AGE_UDP_MASK			BIT(10)
+#define PPE_TB_CFG_AGE_TCP_MASK			BIT(9)
+#define PPE_TB_CFG_AGE_UNBIND_MASK		BIT(8)
+#define PPE_TB_CFG_AGE_NON_L4_MASK		BIT(7)
+#define PPE_TB_CFG_AGE_PREBIND_MASK		BIT(6)
+#define PPE_TB_CFG_SEARCH_MISS_MASK		GENMASK(5, 4)
+#define PPE_TB_ENTRY_SIZE_MASK			BIT(3)
+#define PPE_DRAM_TB_NUM_ENTRY_MASK		GENMASK(2, 0)
+
+#define REG_PPE_TB_BASE(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x220)
+
+#define REG_PPE_BIND_RATE(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x228)
+#define PPE_BIND_RATE_L2B_BIND_MASK		GENMASK(31, 16)
+#define PPE_BIND_RATE_BIND_MASK			GENMASK(15, 0)
+
+#define REG_PPE_BIND_LIMIT0(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x22c)
+#define PPE_BIND_LIMIT0_HALF_MASK		GENMASK(29, 16)
+#define PPE_BIND_LIMIT0_QUARTER_MASK		GENMASK(13, 0)
+
+#define REG_PPE_BIND_LIMIT1(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x230)
+#define PPE_BIND_LIMIT1_NON_L4_MASK		GENMASK(23, 16)
+#define PPE_BIND_LIMIT1_FULL_MASK		GENMASK(13, 0)
+
+#define REG_PPE_BND_AGE0(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x23c)
+#define PPE_BIND_AGE0_DELTA_NON_L4		GENMASK(30, 16)
+#define PPE_BIND_AGE0_DELTA_UDP			GENMASK(14, 0)
+
+#define REG_PPE_UNBIND_AGE(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x238)
+#define PPE_UNBIND_AGE_MIN_PACKETS_MASK		GENMASK(31, 16)
+#define PPE_UNBIND_AGE_DELTA_MASK		GENMASK(7, 0)
+
+#define REG_PPE_BND_AGE1(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x240)
+#define PPE_BIND_AGE1_DELTA_TCP_FIN		GENMASK(30, 16)
+#define PPE_BIND_AGE1_DELTA_TCP			GENMASK(14, 0)
+
+#define REG_PPE_HASH_SEED(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x244)
+#define PPE_HASH_SEED				0x12345678
+
+#define REG_PPE_DFT_CPORT0(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x248)
+
+#define REG_PPE_DFT_CPORT1(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x24c)
+
+#define REG_PPE_TB_HASH_CFG(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x250)
+#define PPE_DRAM_HASH1_MODE_MASK		GENMASK(31, 28)
+#define PPE_DRAM_HASH1_EN_MASK			BIT(24)
+#define PPE_DRAM_HASH0_MODE_MASK		GENMASK(23, 20)
+#define PPE_DRAM_TABLE_EN_MASK			BIT(16)
+#define PPE_SRAM_HASH1_MODE_MASK		GENMASK(15, 12)
+#define PPE_SRAM_HASH1_EN_MASK			BIT(8)
+#define PPE_SRAM_HASH0_MODE_MASK		GENMASK(7, 4)
+#define PPE_SRAM_TABLE_EN_MASK			BIT(0)
+
+#define REG_PPE_RAM_CTRL(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x31c)
+#define PPE_SRAM_CTRL_ACK_MASK			BIT(31)
+#define PPE_SRAM_CTRL_DUAL_SUCESS_MASK		BIT(30)
+#define PPE_SRAM_CTRL_ENTRY_MASK		GENMASK(23, 8)
+#define PPE_SRAM_WR_DUAL_DIRECTION_MASK		BIT(2)
+#define PPE_SRAM_CTRL_WR_MASK			BIT(1)
+#define PPE_SRAM_CTRL_REQ_MASK			BIT(0)
+
+#define REG_PPE_RAM_BASE(_n)			(((_n) ? PPE2_BASE : PPE1_BASE) + 0x320)
+#define REG_PPE_RAM_ENTRY(_m, _n)		(REG_PPE_RAM_BASE(_m) + ((_n) << 2))
 
 #define REG_FE_GDM_TX_OK_PKT_CNT_H(_n)		(GDM_BASE(_n) + 0x280)
 #define REG_FE_GDM_TX_OK_BYTE_CNT_H(_n)		(GDM_BASE(_n) + 0x284)

-- 
2.48.1


