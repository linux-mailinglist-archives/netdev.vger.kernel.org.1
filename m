Return-Path: <netdev+bounces-245795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9515CD8003
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 04:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20F4D3022E73
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 03:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428A72DF12E;
	Tue, 23 Dec 2025 03:52:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-48.us.a.mail.aliyun.com (out198-48.us.a.mail.aliyun.com [47.90.198.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765792D9496;
	Tue, 23 Dec 2025 03:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766461928; cv=none; b=gLcKLCVivuf8bgsCMGYH79jWQVCayFU1lYPAzU+zcJ1cn27tHfF1PrvtK6o23YL1kgY6mvvxcXKP19eZ4m/CTST5kCfGxKD2PuqwcVO8uZycnUMiBRg+Zk5R7c3P5z1lqF0eD8q/hIwZweBlusO/Tgr0z4B3hjHEPZoE7TeLuG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766461928; c=relaxed/simple;
	bh=QhfyeSBGTV1tniKMz/7fx8oK/LMDrni3x6FHzf5XYfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JIxofLnrdOhJMja75Wr86fgWIvxk79qS+odDc4USZTzm+PldSkfYwmAhWnfGvk2ZfTefxqv+3pwbCCF1m5Yx59lJZU8Q4L6y3/NNKogqxTRgvJEJJ0ctUDLJJASHtbWVSW/1IYjvVM30hR+kv6GpFrwIrxmWp969Y8FCjC5yrFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.fqrxWzQ_1766461908 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 11:51:50 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 net-next 11/15] net/nebula-matrix: add Service layer definitions and implementation
Date: Tue, 23 Dec 2025 11:50:34 +0800
Message-ID: <20251223035113.31122-12-illusion.wang@nebula-matrix.com>
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

Service Layer functions include:
1.queue and Ring Management
2.Network Device Operations
3.VLAN and SubMAC Management
4.Interrupt and IRQ Management
5.Flow and Filter Management
6.VF management
7.link state and SFP Management
8.Statistics and Monitoring
9.Firmware and Device Management

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
Change-Id: I8655cefee2167e85069d5f0897e03e18c429c2b0
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   1 +
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |  16 +
 .../nebula-matrix/nbl/nbl_core/nbl_service.c  | 128 ++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_service.h  | 281 ++++++++++++++++++
 .../nbl/nbl_include/nbl_def_service.h         |  27 ++
 .../nbl/nbl_include/nbl_include.h             |  37 +++
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |   7 +
 7 files changed, 497 insertions(+)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index a4b7672a1972..bb324feb5cc3 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -18,6 +18,7 @@ nbl_core-objs +=       nbl_common/nbl_common.o \
 				nbl_hw/nbl_vsi.o \
 				nbl_hw/nbl_adminq.o \
 				nbl_core/nbl_dispatch.o \
+				nbl_core/nbl_service.o \
 				nbl_main.o
 
 # Do not modify include path, unless you are adding a new file which needs some headers in its
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index 0263426b4e09..12d9fef345b6 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -12,6 +12,7 @@
 #include "nbl_def_hw.h"
 #include "nbl_def_resource.h"
 #include "nbl_def_dispatch.h"
+#include "nbl_def_service.h"
 #include "nbl_def_common.h"
 
 #define NBL_ADAPTER_TO_PDEV(adapter)		((adapter)->pdev)
@@ -22,10 +23,12 @@
 #define NBL_ADAPTER_TO_HW_MGT(adapter)		((adapter)->core.hw_mgt)
 #define NBL_ADAPTER_TO_RES_MGT(adapter)		((adapter)->core.res_mgt)
 #define NBL_ADAPTER_TO_DISP_MGT(adapter)	((adapter)->core.disp_mgt)
+#define NBL_ADAPTER_TO_SERV_MGT(adapter)	((adapter)->core.serv_mgt)
 #define NBL_ADAPTER_TO_CHAN_MGT(adapter)	((adapter)->core.chan_mgt)
 #define NBL_ADAPTER_TO_HW_OPS_TBL(adapter)	((adapter)->intf.hw_ops_tbl)
 #define NBL_ADAPTER_TO_RES_OPS_TBL(adapter)	((adapter)->intf.resource_ops_tbl)
 #define NBL_ADAPTER_TO_DISP_OPS_TBL(adapter)	((adapter)->intf.dispatch_ops_tbl)
+#define NBL_ADAPTER_TO_SERV_OPS_TBL(adapter)	((adapter)->intf.service_ops_tbl)
 #define NBL_ADAPTER_TO_CHAN_OPS_TBL(adapter)	((adapter)->intf.channel_ops_tbl)
 
 #define NBL_ADAPTER_TO_RES_PT_OPS(adapter)	(&(NBL_ADAPTER_TO_SERV_OPS_TBL(adapter)->pt_ops))
@@ -34,6 +37,18 @@
 
 #define NBL_NETDEV_TO_ADAPTER(netdev) \
 	(NBL_NETDEV_PRIV_TO_ADAPTER((struct nbl_netdev_priv *)netdev_priv(netdev)))
+
+#define NBL_NETDEV_TO_SERV_MGT(netdev) \
+	(NBL_ADAPTER_TO_SERV_MGT(NBL_NETDEV_PRIV_TO_ADAPTER(\
+		(struct nbl_netdev_priv *)netdev_priv(netdev))))
+
+#define NBL_NETDEV_TO_DEV_MGT(netdev) \
+	(NBL_ADAPTER_TO_DEV_MGT(NBL_NETDEV_TO_ADAPTER(netdev)))
+
+#define NBL_NETDEV_TO_COMMON(netdev) \
+	(NBL_ADAPTER_TO_COMMON(NBL_NETDEV_PRIV_TO_ADAPTER(\
+		(struct nbl_netdev_priv *)netdev_priv(netdev))))
+
 #define NBL_CAP_SET_BIT(loc)			(1 << (loc))
 #define NBL_CAP_TEST_BIT(val, loc)		(((val) >> (loc)) & 0x1)
 
@@ -72,6 +87,7 @@ struct nbl_interface {
 	struct nbl_hw_ops_tbl *hw_ops_tbl;
 	struct nbl_resource_ops_tbl *resource_ops_tbl;
 	struct nbl_dispatch_ops_tbl *dispatch_ops_tbl;
+	struct nbl_service_ops_tbl *service_ops_tbl;
 	struct nbl_channel_ops_tbl *channel_ops_tbl;
 };
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
new file mode 100644
index 000000000000..bedb6283a891
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#include "nbl_service.h"
+#include <crypto/hash.h>
+
+static void nbl_serv_setup_flow_mgt(struct nbl_serv_flow_mgt *flow_mgt)
+{
+	int i = 0;
+
+	INIT_LIST_HEAD(&flow_mgt->vlan_list);
+	for (i = 0; i < NBL_SUBMAC_MAX; i++)
+		INIT_LIST_HEAD(&flow_mgt->submac_list[i]);
+}
+
+static struct nbl_service_ops serv_ops = {
+};
+
+/* Structure starts here, adding an op should not modify anything below */
+static int nbl_serv_setup_serv_mgt(struct nbl_common_info *common,
+				   struct nbl_service_mgt **serv_mgt)
+{
+	struct device *dev;
+
+	dev = NBL_COMMON_TO_DEV(common);
+	*serv_mgt = devm_kzalloc(dev, sizeof(struct nbl_service_mgt), GFP_KERNEL);
+	if (!*serv_mgt)
+		return -ENOMEM;
+
+	NBL_SERV_MGT_TO_COMMON(*serv_mgt) = common;
+	nbl_serv_setup_flow_mgt(NBL_SERV_MGT_TO_FLOW_MGT(*serv_mgt));
+
+	return 0;
+}
+
+static void nbl_serv_remove_serv_mgt(struct nbl_common_info *common,
+				     struct nbl_service_mgt **serv_mgt)
+{
+	struct device *dev = NBL_COMMON_TO_DEV(common);
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(*serv_mgt);
+
+	if (ring_mgt->rss_indir_user)
+		devm_kfree(dev, ring_mgt->rss_indir_user);
+	devm_kfree(dev, *serv_mgt);
+	*serv_mgt = NULL;
+}
+
+static void nbl_serv_remove_ops(struct device *dev, struct nbl_service_ops_tbl **serv_ops_tbl)
+{
+	devm_kfree(dev, *serv_ops_tbl);
+	*serv_ops_tbl = NULL;
+}
+
+static int nbl_serv_setup_ops(struct device *dev, struct nbl_service_ops_tbl **serv_ops_tbl,
+			      struct nbl_service_mgt *serv_mgt)
+{
+	*serv_ops_tbl = devm_kzalloc(dev, sizeof(struct nbl_service_ops_tbl), GFP_KERNEL);
+	if (!*serv_ops_tbl)
+		return -ENOMEM;
+
+	NBL_SERV_OPS_TBL_TO_OPS(*serv_ops_tbl) = &serv_ops;
+	NBL_SERV_OPS_TBL_TO_PRIV(*serv_ops_tbl) = serv_mgt;
+
+	return 0;
+}
+
+int nbl_serv_init(void *p, struct nbl_init_param *param)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct device *dev;
+	struct nbl_common_info *common;
+	struct nbl_service_mgt **serv_mgt;
+	struct nbl_service_ops_tbl **serv_ops_tbl;
+	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
+	struct nbl_dispatch_ops *disp_ops;
+	struct nbl_channel_ops_tbl *chan_ops_tbl;
+	int ret = 0;
+
+	dev = NBL_ADAPTER_TO_DEV(adapter);
+	common = NBL_ADAPTER_TO_COMMON(adapter);
+	serv_mgt = (struct nbl_service_mgt **)&NBL_ADAPTER_TO_SERV_MGT(adapter);
+	serv_ops_tbl = &NBL_ADAPTER_TO_SERV_OPS_TBL(adapter);
+	disp_ops_tbl = NBL_ADAPTER_TO_DISP_OPS_TBL(adapter);
+	chan_ops_tbl = NBL_ADAPTER_TO_CHAN_OPS_TBL(adapter);
+	disp_ops = disp_ops_tbl->ops;
+
+	ret = nbl_serv_setup_serv_mgt(common, serv_mgt);
+	if (ret)
+		goto setup_mgt_fail;
+
+	ret = nbl_serv_setup_ops(dev, serv_ops_tbl, *serv_mgt);
+	if (ret)
+		goto setup_ops_fail;
+
+	NBL_SERV_MGT_TO_DISP_OPS_TBL(*serv_mgt) = disp_ops_tbl;
+	NBL_SERV_MGT_TO_CHAN_OPS_TBL(*serv_mgt) = chan_ops_tbl;
+	disp_ops->get_resource_pt_ops(disp_ops_tbl->priv, &(*serv_ops_tbl)->pt_ops);
+
+	return 0;
+
+setup_ops_fail:
+	nbl_serv_remove_serv_mgt(common, serv_mgt);
+setup_mgt_fail:
+	return ret;
+}
+
+void nbl_serv_remove(void *p)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct device *dev;
+	struct nbl_common_info *common;
+	struct nbl_service_mgt **serv_mgt;
+	struct nbl_service_ops_tbl **serv_ops_tbl;
+
+	if (!adapter)
+		return;
+
+	dev = NBL_ADAPTER_TO_DEV(adapter);
+	common = NBL_ADAPTER_TO_COMMON(adapter);
+	serv_mgt = (struct nbl_service_mgt **)&NBL_ADAPTER_TO_SERV_MGT(adapter);
+	serv_ops_tbl = &NBL_ADAPTER_TO_SERV_OPS_TBL(adapter);
+
+	nbl_serv_remove_ops(dev, serv_ops_tbl);
+	nbl_serv_remove_serv_mgt(common, serv_mgt);
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.h
new file mode 100644
index 000000000000..f230b11cf4bc
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.h
@@ -0,0 +1,281 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_SERVICE_H_
+#define _NBL_SERVICE_H_
+
+#include <linux/mm.h>
+#include <linux/ptr_ring.h>
+#include "nbl_core.h"
+
+#define NBL_SERV_MGT_TO_COMMON(serv_mgt)	((serv_mgt)->common)
+#define NBL_SERV_MGT_TO_DEV(serv_mgt)		NBL_COMMON_TO_DEV(NBL_SERV_MGT_TO_COMMON(serv_mgt))
+#define NBL_SERV_MGT_TO_RING_MGT(serv_mgt)	(&(serv_mgt)->ring_mgt)
+#define NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt)	(&(serv_mgt)->flow_mgt)
+#define NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt)	((serv_mgt)->net_resource_mgt)
+#define NBL_SERV_MGT_TO_ST_MGT(serv_mgt)	((serv_mgt)->st_mgt)
+
+#define NBL_SERV_MGT_TO_DISP_OPS_TBL(serv_mgt)	((serv_mgt)->disp_ops_tbl)
+#define NBL_SERV_MGT_TO_DISP_OPS(serv_mgt)	(NBL_SERV_MGT_TO_DISP_OPS_TBL(serv_mgt)->ops)
+#define NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt)	(NBL_SERV_MGT_TO_DISP_OPS_TBL(serv_mgt)->priv)
+
+#define NBL_SERV_MGT_TO_CHAN_OPS_TBL(serv_mgt)	((serv_mgt)->chan_ops_tbl)
+#define NBL_SERV_MGT_TO_CHAN_OPS(serv_mgt)	(NBL_SERV_MGT_TO_CHAN_OPS_TBL(serv_mgt)->ops)
+#define NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt)	(NBL_SERV_MGT_TO_CHAN_OPS_TBL(serv_mgt)->priv)
+
+#define NBL_DEFAULT_VLAN_ID				0
+#define NBL_HW_STATS_PERIOD_SECONDS			5
+#define NBL_HW_STATS_RX_RATE_THRESHOLD			(1000) /* 1k pps */
+
+#define NBL_TX_TSO_MSS_MIN				(256)
+#define NBL_TX_TSO_MSS_MAX				(16383)
+#define NBL_TX_TSO_L2L3L4_HDR_LEN_MIN			(42)
+#define NBL_TX_TSO_L2L3L4_HDR_LEN_MAX			(128)
+#define NBL_TX_CHECKSUM_OFFLOAD_L2L3L4_HDR_LEN_MAX	(255)
+
+#define NBL_EEPROM_LENGTH				(0)
+
+/* input set */
+#define NBL_MAC_ADDR_LEN_U8				6
+
+#define NBL_FLOW_IN_PORT_TYPE_ETH			0x0
+#define NBL_FLOW_IN_PORT_TYPE_LAG			0x400
+#define NBL_FLOW_IN_PORT_TYPE_VSI			0x800
+
+#define NBL_FLOW_OUT_PORT_TYPE_VSI			0x0
+#define NBL_FLOW_OUT_PORT_TYPE_ETH			0x10
+#define NBL_FLOW_OUT_PORT_TYPE_LAG			0x20
+
+#define SET_DPORT_TYPE_VSI_HOST				(0)
+#define SET_DPORT_TYPE_VSI_ECPU				(1)
+#define SET_DPORT_TYPE_ETH_LAG				(2)
+#define SET_DPORT_TYPE_SP_PORT				(3)
+
+#define NBL_MAX_BURST					524287
+
+#define NBL_VLAN_PCP_SHIFT				13
+
+/* primary vlan in vlan list */
+#define NBL_NO_TRUST_MAX_VLAN				9
+/* primary mac not in submac list */
+#define NBL_NO_TRUST_MAX_MAC				12
+
+#define NBL_DEVLINK_FLASH_COMPONENT_CRC_SIZE		4
+
+/* For customized P4 */
+#define NBL_P4_ELF_IDENT				"\x7F\x45\x4C\x46\x01\x01\x01\x00"
+#define NBL_P4_ELF_IDENT_LEN				8
+#define NBL_P4_VERIFY_CODE_LEN				9
+#define NBL_P4_PRODUCT_INFO_SECTION_NAME		"product_info"
+#define NBL_MD5SUM_LEN					16
+
+struct nbl_serv_ring {
+	dma_addr_t dma;
+	u16 index;
+	u16 local_queue_id;
+	u16 global_queue_id;
+	bool need_recovery;
+	u32 tx_timeout_count;
+};
+
+struct nbl_serv_vector {
+	char name[32];
+	cpumask_t cpumask;
+	struct net_device *netdev;
+	struct nbl_napi_struct *nbl_napi;
+	struct nbl_serv_ring *tx_ring;
+	struct nbl_serv_ring *rx_ring;
+	u8 __iomem *irq_enable_base;
+	u32 irq_data;
+	u16 local_vector_id;
+	u16 global_vector_id;
+	u16 intr_rate_usecs;
+	u16 intr_suppress_level;
+};
+
+struct nbl_serv_ring_vsi_info {
+	u16 vsi_index;
+	u16 vsi_id;
+	u16 ring_offset;
+	u16 ring_num;
+	u16 active_ring_num;
+	bool itr_dynamic;
+	bool started;
+};
+
+struct nbl_serv_ring_mgt {
+	struct nbl_serv_ring *tx_rings;
+	struct nbl_serv_ring *rx_rings;
+	struct nbl_serv_vector *vectors;
+	struct nbl_serv_ring_vsi_info vsi_info[NBL_VSI_MAX];
+	u32 *rss_indir_user;
+	u16 tx_desc_num;
+	u16 rx_desc_num;
+	u16 tx_ring_num;
+	u16 rx_ring_num;
+	u16 active_ring_num;
+	bool net_msix_mask_en;
+};
+
+struct nbl_serv_vlan_node {
+	struct list_head node;
+	u16 vid;
+	// primary_mac_effective means base mac + vlan ok
+	u16 primary_mac_effective;
+	// sub_mac_effective means sub mac + vlan ok
+	u16 sub_mac_effective;
+	u16 ref_cnt;
+};
+
+struct nbl_serv_submac_node {
+	struct list_head node;
+	u8 mac[ETH_ALEN];
+	// effective means this submac + allvlan flowrule effective
+	u16 effective;
+};
+
+enum {
+	NBL_PROMISC = 0,
+	NBL_ALLMULTI = 1,
+	NBL_USER_FLOW = 2,
+	NBL_MIRROR = 3,
+};
+
+enum {
+	NBL_SUBMAC_UNICAST = 0,
+	NBL_SUBMAC_MULTI = 1,
+	NBL_SUBMAC_MAX = 2
+};
+
+struct nbl_serv_flow_mgt {
+	struct list_head vlan_list;
+	struct list_head submac_list[NBL_SUBMAC_MAX];
+	u16 vid;
+	u8 mac[ETH_ALEN];
+	u8 eth;
+	bool trusted_en;
+	bool trusted_update;
+	u16 vlan_list_cnt;
+	u16 active_submac_list;
+	u16 submac_list_cnt;
+	u16 unicast_mac_cnt;
+	u16 multi_mac_cnt;
+	u16 promisc;
+	bool force_promisc;
+	bool unicast_flow_enable;
+	bool multicast_flow_enable;
+	bool pending_async_work;
+};
+
+struct nbl_mac_filter {
+	struct list_head list;
+	u8 macaddr[ETH_ALEN];
+};
+
+enum nbl_adapter_flags {
+	/* p4 flags must be at the start */
+	NBL_FLAG_P4_DEFAULT,
+	NBL_FLAG_LINK_DOWN_ON_CLOSE,
+	NBL_FLAG_NRZ_RS_FEC_544_SUPPORT,
+	NBL_FLAG_HIGH_THROUGHPUT,
+	NBL_ADAPTER_FLAGS_MAX
+};
+
+struct nbl_serv_netdev_ops {
+	void *pf_netdev_ops;
+};
+
+struct nbl_serv_vf_info {
+	struct kobject kobj;
+	struct kobject meters_kobj;
+	struct kobject rx_kobj;
+	struct kobject tx_kobj;
+	struct kobject rx_bps_kobj;
+	struct kobject tx_bps_kobj;
+	void *priv;
+	u16 vf_id;
+
+	int state;
+	int spoof_check;
+	int max_tx_rate;
+	int meter_tx_rate;
+	int meter_rx_rate;
+	int meter_tx_burst;
+	int meter_rx_burst;
+	u8 mac[ETH_ALEN];
+	u16 vlan;
+	u16 vlan_proto;
+	u8 vlan_qos;
+	bool trusted;
+};
+
+struct nbl_serv_net_resource_mgt {
+	struct nbl_service_mgt *serv_mgt;
+	struct net_device *netdev;
+	struct work_struct rx_mode_async;
+	struct work_struct tx_timeout;
+	struct work_struct update_link_state;
+	struct work_struct update_vlan;
+	struct delayed_work watchdog_task;
+	struct timer_list serv_timer;
+	unsigned long serv_timer_period;
+
+	struct list_head tmp_add_filter_list;
+	struct list_head tmp_del_filter_list;
+	struct list_head indr_dev_priv_list;
+	struct nbl_serv_netdev_ops netdev_ops;
+	u16 curr_promiscuout_mode;
+	u16 num_net_msix;
+	bool update_submac;
+	int num_vfs;
+	int total_vfs;
+
+	/* stats for netdev */
+	u64 get_stats_jiffies;
+	struct nbl_stats stats;
+	struct nbl_hw_stats hw_stats;
+	unsigned long hw_stats_jiffies;
+	unsigned long hw_stats_period;
+	struct nbl_priv_stats priv_stats;
+	struct nbl_serv_vf_info *vf_info;
+	struct kobject *sriov_kobj;
+	u32 configured_speed;
+	u32 configured_fec;
+	u16 bridge_mode;
+	int link_forced;
+
+	u16 vlan_tci;
+	u16 vlan_proto;
+	int max_tx_rate;
+	u32 dump_flag;
+	u32 dump_perf_len;
+};
+
+struct nbl_service_mgt {
+	struct nbl_common_info *common;
+	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
+	struct nbl_channel_ops_tbl *chan_ops_tbl;
+	struct nbl_serv_ring_mgt ring_mgt;
+	struct nbl_serv_flow_mgt flow_mgt;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt;
+	unsigned long old_flags;
+	unsigned long flags;
+};
+
+struct nbl_serv_notify_vlan_param {
+	u16 vlan_tci;
+	u16 vlan_proto;
+};
+
+int nbl_serv_netdev_open(struct net_device *netdev);
+int nbl_serv_netdev_stop(struct net_device *netdev);
+int nbl_serv_vsi_open(void *priv, struct net_device *netdev, u16 vsi_index,
+		      u16 real_qps, bool use_napi);
+int nbl_serv_vsi_stop(void *priv, u16 vsi_index);
+void nbl_serv_cpu_affinity_init(void *priv, u16 rings_num);
+u16 nbl_serv_get_vf_function_id(void *priv, int vf_id);
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h
new file mode 100644
index 000000000000..d5dd7b6726cc
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_DEF_SERVICE_H_
+#define _NBL_DEF_SERVICE_H_
+
+#include "nbl_include.h"
+
+#define NBL_SERV_OPS_TBL_TO_OPS(serv_ops_tbl) ((serv_ops_tbl)->ops)
+#define NBL_SERV_OPS_TBL_TO_PRIV(serv_ops_tbl) ((serv_ops_tbl)->priv)
+
+struct nbl_service_ops {
+};
+
+struct nbl_service_ops_tbl {
+	struct nbl_resource_pt_ops pt_ops;
+	struct nbl_service_ops *ops;
+	void *priv;
+};
+
+int nbl_serv_init(void *priv, struct nbl_init_param *param);
+void nbl_serv_remove(void *priv);
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index ad359e95d206..9341ed6d59fa 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -189,6 +189,11 @@ struct nbl_queue_cfg_param {
 	u16 half_offload_en;
 };
 
+struct nbl_msix_info_param {
+	u16 msix_num;
+	struct msix_entry *msix_entries;
+};
+
 struct nbl_queue_stats {
 	u64 packets;
 	u64 bytes;
@@ -251,6 +256,22 @@ struct nbl_stats {
 	u64 rx_bytes;
 };
 
+struct nbl_priv_stats {
+	u64 total_dvn_pkt_drop_cnt;
+	u64 total_uvn_stat_pkt_drop;
+};
+
+struct nbl_vf_stats {
+	u64 rx_packets;
+	u64 tx_packets;
+	u64 rx_bytes;
+	u64 tx_bytes;
+	u64 broadcast;
+	u64 multicast;
+	u64 rx_dropped;
+	u64 tx_dropped;
+};
+
 struct nbl_ustore_stats {
 	u64 rx_drop_packets;
 	u64 rx_trun_packets;
@@ -266,6 +287,15 @@ struct nbl_notify_param {
 	u16 tail_ptr;
 };
 
+struct nbl_common_irq_num {
+	int mbx_irq_num;
+};
+
+struct nbl_ctrl_irq_num {
+	int adminq_irq_num;
+	int abnormal_irq_num;
+};
+
 enum nbl_flow_ctrl {
 	NBL_PORT_TX_PAUSE = 0x1,
 	NBL_PORT_RX_PAUSE = 0x2,
@@ -514,6 +544,13 @@ enum nbl_performance_mode {
 	NBL_QUIRKS_UVN_PREFETCH_ALIGN,
 };
 
+struct nbl_vsi_param {
+	u16 vsi_id;
+	u16 queue_offset;
+	u16 queue_num;
+	u8 index;
+};
+
 struct nbl_ring_param {
 	u16 tx_ring_num;
 	u16 rx_ring_num;
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
index 4d2c787b8f7a..a67f6ce75a93 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -74,7 +74,13 @@ struct nbl_adapter *nbl_core_init(struct pci_dev *pdev, struct nbl_init_param *p
 	ret = nbl_disp_init(adapter, param);
 	if (ret)
 		goto disp_init_fail;
+
+	ret = nbl_serv_init(adapter, param);
+	if (ret)
+		goto serv_init_fail;
 	return adapter;
+serv_init_fail:
+	nbl_disp_remove(adapter);
 disp_init_fail:
 	product_base_ops->res_remove(adapter);
 res_init_fail:
@@ -97,6 +103,7 @@ void nbl_core_remove(struct nbl_adapter *adapter)
 
 	dev = NBL_ADAPTER_TO_DEV(adapter);
 	product_base_ops = NBL_ADAPTER_TO_RPDUCT_BASE_OPS(adapter);
+	nbl_serv_remove(adapter);
 	nbl_disp_remove(adapter);
 	product_base_ops->res_remove(adapter);
 	product_base_ops->chan_remove(adapter);
-- 
2.43.0


