Return-Path: <netdev+bounces-248432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCB7D08692
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 11:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C67F03024EE4
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 10:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB5333B6DF;
	Fri,  9 Jan 2026 10:03:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-30.us.a.mail.aliyun.com (out198-30.us.a.mail.aliyun.com [47.90.198.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE923385AC;
	Fri,  9 Jan 2026 10:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767952982; cv=none; b=m/Ges+b7GMwOEF3Q2ETp4ZYCR2aKOuH4mBBokqZOt4b0NpXW1DAGlCJ1f4ueGxSSZNVMX0QFQV55ZsbG+pWUF2eAzvuFKvy+AAB1TzGa4W9fWprofucLT6Y7Fhv+cXdxupwIYQ1g1gFzZ68AjZyI63HoNc/THKn/GNJvHt7gML0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767952982; c=relaxed/simple;
	bh=+K6dyjJ8EAA50+h6WfA+6XTtd9twOtGpdX5NlxeUuFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtBJMoQp8+HXhhwJZP8HX7B7WY2wCoxaWxNNpdvnKrEtbLtzJun7nwITFMIUnhCxe+a3J4FgwAm+KlcsRB9eceONAKDoE1+Bf7nwZA4psDdCPVRO7l6BYcojjrJOfnPZ8esQMyF1Wsfz0j68fwQQcqW/YKB3dkxjB+isgw1Y22g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.g2QQApz_1767952958 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 09 Jan 2026 18:02:39 +0800
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
Subject: [PATCH v2 net-next 09/15] net/nebula-matrix: add flow resource definitions and implementation
Date: Fri,  9 Jan 2026 18:01:27 +0800
Message-ID: <20260109100146.63569-10-illusion.wang@nebula-matrix.com>
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

flow resource management functions include:
Flow Configuration: Setting the actions and key-value pairs for flows.
Flow Management: Allocating/releasing flow IDs, TCAM IDs, MCC IDs, etc.
Multicast Control: Managing multicast control groups.
Hash Table Management: Enabling rapid lookup of flow entries.
LLDP/LACP Flow Management: Managing flows related to link-layer
protocols.
Multicast Flow Management: Managing multicast flows.
MTU Management: Managing the MTU of Virtual Switching Instances (VSIs).
Initialization and Cleanup: Initializing/cleaning up the flow management
module.

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |    1 +
 .../nbl_hw/nbl_hw_leonis/nbl_flow_leonis.c    | 2268 +++++++++++++++++
 .../nbl_hw/nbl_hw_leonis/nbl_flow_leonis.h    |  204 ++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  |  519 ++++
 .../nbl_hw_leonis/nbl_resource_leonis.c       |   10 +
 .../nbl_hw_leonis/nbl_resource_leonis.h       |    3 +
 .../nbl/nbl_include/nbl_def_common.h          |   87 +
 .../nbl/nbl_include/nbl_def_hw.h              |   18 +
 8 files changed, 3110 insertions(+)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_flow_leonis.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_flow_leonis.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index e611110ac369..16d751e01b8e 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_NBL_CORE) := nbl_core.o
 nbl_core-objs +=       nbl_common/nbl_common.o \
 				nbl_channel/nbl_channel.o \
 				nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
+				nbl_hw/nbl_hw_leonis/nbl_flow_leonis.o \
 				nbl_hw/nbl_hw_leonis/nbl_queue_leonis.o \
 				nbl_hw/nbl_hw_leonis/nbl_resource_leonis.o \
 				nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.o \
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_flow_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_flow_leonis.c
new file mode 100644
index 000000000000..62681d64c3e0
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_flow_leonis.c
@@ -0,0 +1,2268 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+#include <linux/etherdevice.h>
+#include <linux/if_vlan.h>
+
+#include "nbl_flow_leonis.h"
+#include "nbl_resource_leonis.h"
+
+#define NBL_ACT_SET_AUX_FIELD 1
+#define NBL_ACT_SET_DPORT 9
+#define NBL_ACT_SET_MCC 13
+#define NBL_FLOW_LEONIS_VSI_NUM_PER_ETH		256
+
+static u32 nbl_flow_cfg_action_set_dport(u16 upcall_flag, u16 port_type,
+					 u16 vsi, u16 next_stg_sel)
+{
+	union nbl_action_data set_dport = { .data = 0 };
+
+	set_dport.dport.up.upcall_flag = upcall_flag;
+	set_dport.dport.up.port_type = port_type;
+	set_dport.dport.up.port_id = vsi;
+	set_dport.dport.up.next_stg_sel = next_stg_sel;
+
+	return set_dport.data + (NBL_ACT_SET_DPORT << 16);
+}
+
+static u16 nbl_flow_cfg_action_set_dport_mcc_eth(u8 eth)
+{
+	union nbl_action_data set_dport = { .data = 0 };
+
+	set_dport.dport.down.upcall_flag = AUX_FWD_TYPE_NML_FWD;
+	set_dport.dport.down.port_type = SET_DPORT_TYPE_ETH_LAG;
+	set_dport.dport.down.next_stg_sel = NEXT_STG_SEL_EPRO;
+	set_dport.dport.down.lag_vld = 0;
+	set_dport.dport.down.eth_vld = 1;
+	set_dport.dport.down.eth_id = eth;
+
+	return set_dport.data;
+}
+
+static u16 nbl_flow_cfg_action_set_dport_mcc_vsi(u16 vsi)
+{
+	union nbl_action_data set_dport = { .data = 0 };
+
+	set_dport.dport.up.upcall_flag = AUX_FWD_TYPE_NML_FWD;
+	set_dport.dport.up.port_type = SET_DPORT_TYPE_VSI_HOST;
+	set_dport.dport.up.port_id = vsi;
+	set_dport.dport.up.next_stg_sel = NEXT_STG_SEL_ACL_S0;
+
+	return set_dport.data;
+}
+
+static u32 nbl_flow_cfg_action_set_dport_mcc_bmc(void)
+{
+	union nbl_action_data set_dport = { .data = 0 };
+
+	set_dport.dport.up.upcall_flag = AUX_FWD_TYPE_NML_FWD;
+	set_dport.dport.up.port_type = SET_DPORT_TYPE_SP_PORT;
+	set_dport.dport.up.port_id = NBL_FLOW_MCC_BMC_DPORT;
+	set_dport.dport.up.next_stg_sel = NEXT_STG_SEL_EPRO;
+
+	return set_dport.data + (NBL_ACT_SET_DPORT << 16);
+}
+
+static int nbl_flow_cfg_action_mcc(u16 mcc_id, u32 *action0, u32 *action1)
+{
+	union nbl_action_data mcc_idx_act = { .data = 0 },
+			      set_aux_act = { .data = 0 };
+
+	mcc_idx_act.mcc_idx.mcc_id = mcc_id;
+	*action0 = (u32)mcc_idx_act.data + (NBL_ACT_SET_MCC << 16);
+
+	set_aux_act.set_aux.sub_id = NBL_SET_AUX_SET_AUX;
+	set_aux_act.set_aux.nstg_vld = 1;
+	set_aux_act.set_aux.nstg_val = NBL_NEXT_STG_MCC;
+	*action1 = (u32)set_aux_act.data + (NBL_ACT_SET_AUX_FIELD << 16);
+
+	return 0;
+}
+
+static int nbl_flow_cfg_action_up_tnl(struct nbl_flow_param param, u32 *action0,
+				      u32 *action1)
+{
+	*action1 = 0;
+	if (param.mcc_id == NBL_MCC_ID_INVALID)
+		*action0 =
+			nbl_flow_cfg_action_set_dport(AUX_FWD_TYPE_NML_FWD,
+						      SET_DPORT_TYPE_VSI_HOST,
+						      param.vsi,
+						      NEXT_STG_SEL_ACL_S0);
+	else
+		nbl_flow_cfg_action_mcc(param.mcc_id, action0, action1);
+
+	return 0;
+}
+
+static int nbl_flow_cfg_action_lldp_lacp_up(struct nbl_flow_param param,
+					    u32 *action0, u32 *action1)
+{
+	*action1 = 0;
+	*action0 = nbl_flow_cfg_action_set_dport(AUX_FWD_TYPE_NML_FWD,
+						 SET_DPORT_TYPE_VSI_HOST,
+						 param.vsi,
+						 NEXT_STG_SEL_ACL_S0);
+
+	return 0;
+}
+
+static int nbl_flow_cfg_action_up(struct nbl_flow_param param, u32 *action0,
+				  u32 *action1)
+{
+	*action1 = 0;
+	if (param.mcc_id == NBL_MCC_ID_INVALID)
+		*action0 =
+			nbl_flow_cfg_action_set_dport(AUX_FWD_TYPE_NML_FWD,
+						      SET_DPORT_TYPE_VSI_HOST,
+						      param.vsi,
+						      NEXT_STG_SEL_NONE);
+	else
+		nbl_flow_cfg_action_mcc(param.mcc_id, action0, action1);
+
+	return 0;
+}
+
+static int nbl_flow_cfg_action_down(struct nbl_flow_param param, u32 *action0,
+				    u32 *action1)
+{
+	*action1 = 0;
+	if (param.mcc_id == NBL_MCC_ID_INVALID)
+		*action0 =
+			nbl_flow_cfg_action_set_dport(AUX_FWD_TYPE_NML_FWD,
+						      SET_DPORT_TYPE_VSI_HOST,
+						      param.vsi,
+						      NEXT_STG_SEL_ACL_S0);
+	else
+		nbl_flow_cfg_action_mcc(param.mcc_id, action0, action1);
+
+	return 0;
+}
+
+static int nbl_flow_cfg_up_tnl_key_value(union nbl_common_data_u *data,
+					 struct nbl_flow_param param,
+					 u8 eth_mode)
+{
+	union nbl_l2_hw_up_data_u *kt_data = (union nbl_l2_hw_up_data_u *)data;
+	u64 dst_mac = 0;
+	u8 sport;
+	u8 reverse_mac[ETH_ALEN];
+
+	nbl_convert_mac(param.mac, reverse_mac);
+
+	memset(kt_data->hash_key, 0x0, sizeof(kt_data->hash_key));
+	ether_addr_copy((u8 *)&dst_mac, reverse_mac);
+
+	kt_data->info.dst_mac = dst_mac;
+	kt_data->info.svlan_id = param.vid;
+	kt_data->info.template = NBL_EM0_PT_HW_UP_TUNNEL_L2;
+	kt_data->info.padding = 0;
+
+	sport = param.eth;
+	kt_data->info.sport = sport + NBL_SPORT_ETH_OFFSET;
+
+	return 0;
+}
+
+static int nbl_flow_cfg_lldp_lacp_up_key_value(union nbl_common_data_u *data,
+					       struct nbl_flow_param param,
+					       u8 eth_mode)
+{
+	union nbl_l2_hw_lldp_lacp_data_u *kt_data =
+		(union nbl_l2_hw_lldp_lacp_data_u *)data;
+	u8 sport;
+
+	kt_data->info.template = NBL_EM0_PT_HW_UP_LLDP_LACP;
+
+	kt_data->info.ether_type = param.ether_type;
+
+	sport = param.eth;
+	kt_data->info.sport = sport + NBL_SPORT_ETH_OFFSET;
+
+	return 0;
+}
+
+static int nbl_flow_cfg_up_key_value(union nbl_common_data_u *data,
+				     struct nbl_flow_param param, u8 eth_mode)
+{
+	union nbl_l2_hw_up_data_u *kt_data = (union nbl_l2_hw_up_data_u *)data;
+	u64 dst_mac = 0;
+	u8 sport;
+	u8 reverse_mac[ETH_ALEN];
+
+	nbl_convert_mac(param.mac, reverse_mac);
+
+	memset(kt_data->hash_key, 0x0, sizeof(kt_data->hash_key));
+	ether_addr_copy((u8 *)&dst_mac, reverse_mac);
+
+	kt_data->info.dst_mac = dst_mac;
+	kt_data->info.svlan_id = param.vid;
+	kt_data->info.template = NBL_EM0_PT_HW_UP_L2;
+	kt_data->info.padding = 0;
+
+	sport = param.eth;
+	kt_data->info.sport = sport + NBL_SPORT_ETH_OFFSET;
+
+	return 0;
+}
+
+static int nbl_flow_cfg_down_key_value(union nbl_common_data_u *data,
+				       struct nbl_flow_param param, u8 eth_mode)
+{
+	union nbl_l2_hw_down_data_u *kt_data =
+		(union nbl_l2_hw_down_data_u *)data;
+	u64 dst_mac = 0;
+	u8 sport;
+	u8 reverse_mac[ETH_ALEN];
+
+	nbl_convert_mac(param.mac, reverse_mac);
+
+	memset(kt_data->hash_key, 0x0, sizeof(kt_data->hash_key));
+	ether_addr_copy((u8 *)&dst_mac, reverse_mac);
+
+	kt_data->info.dst_mac = dst_mac;
+	kt_data->info.svlan_id = param.vid;
+	kt_data->info.template = NBL_EM0_PT_HW_DOWN_L2;
+	kt_data->info.padding = 0;
+
+	sport = param.vsi >> 8;
+	if (eth_mode == NBL_TWO_ETHERNET_PORT)
+		sport &= 0xFE;
+	if (eth_mode == NBL_ONE_ETHERNET_PORT)
+		sport = 0;
+	kt_data->info.sport = sport;
+
+	return 0;
+}
+
+static void nbl_flow_cfg_kt_action_up_tnl(union nbl_common_data_u *data,
+					  u32 action0, u32 action1)
+{
+	union nbl_l2_hw_up_data_u *kt_data = (union nbl_l2_hw_up_data_u *)data;
+
+	kt_data->info.act0 = action0;
+	kt_data->info.act1 = action1;
+}
+
+static void nbl_flow_cfg_kt_action_lldp_lacp_up(union nbl_common_data_u *data,
+						u32 action0, u32 action1)
+{
+	union nbl_l2_hw_lldp_lacp_data_u *kt_data =
+		(union nbl_l2_hw_lldp_lacp_data_u *)data;
+
+	kt_data->info.act0 = action0;
+}
+
+static void nbl_flow_cfg_kt_action_up(union nbl_common_data_u *data,
+				      u32 action0, u32 action1)
+{
+	union nbl_l2_hw_up_data_u *kt_data = (union nbl_l2_hw_up_data_u *)data;
+
+	kt_data->info.act0 = action0;
+	kt_data->info.act1 = action1;
+}
+
+static void nbl_flow_cfg_kt_action_down(union nbl_common_data_u *data,
+					u32 action0, u32 action1)
+{
+	union nbl_l2_hw_down_data_u *kt_data =
+		(union nbl_l2_hw_down_data_u *)data;
+
+	kt_data->info.act0 = action0;
+	kt_data->info.act1 = action1;
+}
+
+static int nbl_flow_cfg_action_multi_mcast(struct nbl_flow_param param,
+					   u32 *action0, u32 *action1)
+{
+	return nbl_flow_cfg_action_mcc(param.mcc_id, action0, action1);
+}
+
+static int
+nbl_flow_cfg_l2up_multi_mcast_key_value(union nbl_common_data_u *data,
+					struct nbl_flow_param param,
+					u8 eth_mode)
+{
+	union nbl_l2_hw_up_multi_mcast_data_u *kt_data =
+		(union nbl_l2_hw_up_multi_mcast_data_u *)data;
+	u8 sport;
+
+	kt_data->info.template = NBL_EM0_PT_HW_L2_UP_MULTI_MCAST;
+
+	sport = param.eth;
+	kt_data->info.sport = sport + NBL_SPORT_ETH_OFFSET;
+
+	return 0;
+}
+
+static void
+nbl_flow_cfg_kt_action_l2up_multi_mcast(union nbl_common_data_u *data,
+					u32 action0, u32 action1)
+{
+	union nbl_l2_hw_up_multi_mcast_data_u *kt_data =
+		(union nbl_l2_hw_up_multi_mcast_data_u *)data;
+
+	kt_data->info.act0 = action0;
+}
+
+static int
+nbl_flow_cfg_l3up_multi_mcast_key_value(union nbl_common_data_u *data,
+					struct nbl_flow_param param,
+					u8 eth_mode)
+{
+	union nbl_l2_hw_up_multi_mcast_data_u *kt_data =
+		(union nbl_l2_hw_up_multi_mcast_data_u *)data;
+	u8 sport;
+
+	kt_data->info.template = NBL_EM0_PT_HW_L3_UP_MULTI_MCAST;
+
+	sport = param.eth;
+	kt_data->info.sport = sport + NBL_SPORT_ETH_OFFSET;
+
+	return 0;
+}
+
+static int
+nbl_flow_cfg_l2down_multi_mcast_key_value(union nbl_common_data_u *data,
+					  struct nbl_flow_param param,
+					  u8 eth_mode)
+{
+	union nbl_l2_hw_down_multi_mcast_data_u *kt_data =
+		(union nbl_l2_hw_down_multi_mcast_data_u *)data;
+	u8 sport;
+
+	kt_data->info.template = NBL_EM0_PT_HW_L2_DOWN_MULTI_MCAST;
+
+	sport = param.eth;
+	kt_data->info.sport = sport + NBL_SPORT_ETH_OFFSET;
+
+	return 0;
+}
+
+static void
+nbl_flow_cfg_kt_action_l2down_multi_mcast(union nbl_common_data_u *data,
+					  u32 action0, u32 action1)
+{
+	union nbl_l2_hw_down_multi_mcast_data_u *kt_data =
+		(union nbl_l2_hw_down_multi_mcast_data_u *)data;
+
+	kt_data->info.act0 = action0;
+}
+
+static int
+nbl_flow_cfg_l3down_multi_mcast_key_value(union nbl_common_data_u *data,
+					  struct nbl_flow_param param,
+					  u8 eth_mode)
+{
+	union nbl_l2_hw_down_multi_mcast_data_u *kt_data =
+		(union nbl_l2_hw_down_multi_mcast_data_u *)data;
+	u8 sport;
+
+	kt_data->info.template = NBL_EM0_PT_HW_L3_DOWN_MULTI_MCAST;
+
+	sport = param.eth;
+	kt_data->info.sport = sport + NBL_SPORT_ETH_OFFSET;
+
+	return 0;
+}
+
+#define NBL_FLOW_OPS_ARR_ENTRY(type, action_func, kt_func, kt_action_func) \
+	[type] = {.cfg_action = action_func, .cfg_key = kt_func,	\
+		  .cfg_kt_action = kt_action_func}
+static const struct nbl_flow_rule_cfg_ops cfg_ops[] = {
+	NBL_FLOW_OPS_ARR_ENTRY(NBL_FLOW_UP_TNL,
+			       nbl_flow_cfg_action_up_tnl,
+			       nbl_flow_cfg_up_tnl_key_value,
+			       nbl_flow_cfg_kt_action_up_tnl),
+	NBL_FLOW_OPS_ARR_ENTRY(NBL_FLOW_UP,
+			       nbl_flow_cfg_action_up,
+			       nbl_flow_cfg_up_key_value,
+			       nbl_flow_cfg_kt_action_up),
+	NBL_FLOW_OPS_ARR_ENTRY(NBL_FLOW_DOWN,
+			       nbl_flow_cfg_action_down,
+			       nbl_flow_cfg_down_key_value,
+			       nbl_flow_cfg_kt_action_down),
+	NBL_FLOW_OPS_ARR_ENTRY(NBL_FLOW_LLDP_LACP_UP,
+			       nbl_flow_cfg_action_lldp_lacp_up,
+			       nbl_flow_cfg_lldp_lacp_up_key_value,
+			       nbl_flow_cfg_kt_action_lldp_lacp_up),
+	NBL_FLOW_OPS_ARR_ENTRY(NBL_FLOW_L2_UP_MULTI_MCAST,
+			       nbl_flow_cfg_action_multi_mcast,
+			       nbl_flow_cfg_l2up_multi_mcast_key_value,
+			       nbl_flow_cfg_kt_action_l2up_multi_mcast),
+	NBL_FLOW_OPS_ARR_ENTRY(NBL_FLOW_L3_UP_MULTI_MCAST,
+			       nbl_flow_cfg_action_multi_mcast,
+			       nbl_flow_cfg_l3up_multi_mcast_key_value,
+			       nbl_flow_cfg_kt_action_l2up_multi_mcast),
+	NBL_FLOW_OPS_ARR_ENTRY(NBL_FLOW_L2_DOWN_MULTI_MCAST,
+			       nbl_flow_cfg_action_multi_mcast,
+			       nbl_flow_cfg_l2down_multi_mcast_key_value,
+			       nbl_flow_cfg_kt_action_l2down_multi_mcast),
+	NBL_FLOW_OPS_ARR_ENTRY(NBL_FLOW_L3_DOWN_MULTI_MCAST,
+			       nbl_flow_cfg_action_multi_mcast,
+			       nbl_flow_cfg_l3down_multi_mcast_key_value,
+			       nbl_flow_cfg_kt_action_l2down_multi_mcast),
+};
+
+static int nbl_flow_alloc_flow_id(struct nbl_flow_mgt *flow_mgt,
+				  struct nbl_flow_fem_entry *flow)
+{
+	u32 flow_id;
+
+	if (flow->flow_type == NBL_KT_HALF_MODE) {
+		flow_id = find_first_zero_bit(flow_mgt->flow_id_bitmap,
+					      NBL_MACVLAN_TABLE_LEN);
+		if (flow_id == NBL_MACVLAN_TABLE_LEN)
+			return -ENOSPC;
+		set_bit(flow_id, flow_mgt->flow_id_bitmap);
+		flow_mgt->flow_id_cnt--;
+	} else {
+		flow_id = nbl_common_find_free_idx(flow_mgt->flow_id_bitmap,
+						   NBL_MACVLAN_TABLE_LEN,
+						   2, 2);
+		if (flow_id == NBL_MACVLAN_TABLE_LEN)
+			return -ENOSPC;
+		set_bit(flow_id, flow_mgt->flow_id_bitmap);
+		set_bit(flow_id + 1, flow_mgt->flow_id_bitmap);
+		flow_mgt->flow_id_cnt -= 2;
+	}
+
+	flow->flow_id = flow_id;
+	return 0;
+}
+
+static void nbl_flow_free_flow_id(struct nbl_flow_mgt *flow_mgt,
+				  struct nbl_flow_fem_entry *flow)
+{
+	if (flow->flow_id == U16_MAX)
+		return;
+
+	if (flow->flow_type == NBL_KT_HALF_MODE) {
+		clear_bit(flow->flow_id, flow_mgt->flow_id_bitmap);
+		flow->flow_id = 0xFFFF;
+		flow_mgt->flow_id_cnt++;
+	} else {
+		clear_bit(flow->flow_id, flow_mgt->flow_id_bitmap);
+		clear_bit(flow->flow_id + 1, flow_mgt->flow_id_bitmap);
+		flow->flow_id = 0xFFFF;
+		flow_mgt->flow_id_cnt += 2;
+	}
+}
+
+static int nbl_flow_alloc_tcam_id(struct nbl_flow_mgt *flow_mgt,
+				  struct nbl_tcam_item *tcam_item)
+{
+	u32 tcam_id;
+
+	tcam_id = find_first_zero_bit(flow_mgt->tcam_id, NBL_TCAM_TABLE_LEN);
+	if (tcam_id == NBL_TCAM_TABLE_LEN)
+		return -ENOSPC;
+
+	set_bit(tcam_id, flow_mgt->tcam_id);
+	tcam_item->tcam_index = tcam_id;
+
+	return 0;
+}
+
+static void nbl_flow_free_tcam_id(struct nbl_flow_mgt *flow_mgt,
+				  struct nbl_tcam_item *tcam_item)
+{
+	clear_bit(tcam_item->tcam_index, flow_mgt->tcam_id);
+	tcam_item->tcam_index = 0;
+}
+
+static int nbl_flow_alloc_mcc_id(struct nbl_flow_mgt *flow_mgt)
+{
+	u32 mcc_id;
+
+	mcc_id = find_first_zero_bit(flow_mgt->mcc_id_bitmap,
+				     NBL_FLOW_MCC_INDEX_SIZE);
+	if (mcc_id == NBL_FLOW_MCC_INDEX_SIZE)
+		return -ENOSPC;
+
+	set_bit(mcc_id, flow_mgt->mcc_id_bitmap);
+
+	return mcc_id + NBL_FLOW_MCC_INDEX_START;
+}
+
+static void nbl_flow_free_mcc_id(struct nbl_flow_mgt *flow_mgt, u32 mcc_id)
+{
+	if (mcc_id >= NBL_FLOW_MCC_INDEX_START)
+		clear_bit(mcc_id - NBL_FLOW_MCC_INDEX_START,
+			  flow_mgt->mcc_id_bitmap);
+}
+
+static void nbl_flow_set_mt_input(struct nbl_mt_input *mt_input,
+				  union nbl_common_data_u *kt_data, u8 type,
+				  u16 flow_id)
+{
+	int i;
+	u16 key_len;
+
+	key_len = ((type) == NBL_KT_HALF_MODE ? NBL_KT_BYTE_HALF_LEN :
+						NBL_KT_BYTE_LEN);
+	for (i = 0; i < key_len; i++)
+		mt_input->key[i] = kt_data->hash_key[key_len - 1 - i];
+
+	mt_input->tbl_id = flow_id + NBL_EM_HW_KT_OFFSET;
+	mt_input->depth = 0;
+	mt_input->power = NBL_PP0_POWER;
+}
+
+static void nbl_flow_key_hash(struct nbl_flow_fem_entry *flow,
+			      struct nbl_mt_input *mt_input)
+{
+	u16 ht0_hash = 0;
+	u16 ht1_hash = 0;
+
+	ht0_hash = NBL_CRC16_CCITT(mt_input->key, NBL_KT_BYTE_LEN);
+	ht1_hash = NBL_CRC16_IBM(mt_input->key, NBL_KT_BYTE_LEN);
+	flow->ht0_hash =
+		nbl_hash_transfer(ht0_hash, mt_input->power, mt_input->depth);
+	flow->ht1_hash =
+		nbl_hash_transfer(ht1_hash, mt_input->power, mt_input->depth);
+}
+
+static bool nbl_pp_ht0_ht1_search(struct nbl_flow_ht_mng *pp_ht0_mng,
+				  u16 ht0_hash,
+				  struct nbl_flow_ht_mng *pp_ht1_mng,
+				  u16 ht1_hash, struct nbl_common_info *common)
+{
+	struct nbl_flow_ht_tbl *node0 = NULL;
+	struct nbl_flow_ht_tbl *node1 = NULL;
+	u16 i = 0;
+	bool is_find = false;
+
+	node0 = pp_ht0_mng->hash_map[ht0_hash];
+	if (node0)
+		for (i = 0; i < NBL_HASH_CFT_MAX; i++)
+			if (node0->key[i].vid &&
+			    node0->key[i].ht_other_index == ht1_hash) {
+				is_find = true;
+				nbl_debug(common,
+					  "Conflicted ht on vid %d and kt_index %u\n",
+					  node0->key[i].vid,
+					  node0->key[i].kt_index);
+				return is_find;
+			}
+
+	node1 = pp_ht1_mng->hash_map[ht1_hash];
+	if (node1)
+		for (i = 0; i < NBL_HASH_CFT_MAX; i++)
+			if (node1->key[i].vid &&
+			    node1->key[i].ht_other_index == ht0_hash) {
+				is_find = true;
+				nbl_debug(common,
+					  "Conflicted ht on vid %d and kt_index %u\n",
+					  node1->key[i].vid,
+					  node1->key[i].kt_index);
+				return is_find;
+			}
+
+	return is_find;
+}
+
+static bool nbl_flow_check_ht_conflict(struct nbl_flow_ht_mng *pp_ht0_mng,
+				       struct nbl_flow_ht_mng *pp_ht1_mng,
+				       u16 ht0_hash, u16 ht1_hash,
+				       struct nbl_common_info *common)
+{
+	return nbl_pp_ht0_ht1_search(pp_ht0_mng, ht0_hash, pp_ht1_mng, ht1_hash,
+				     common);
+}
+
+static int nbl_flow_find_ht_avail_table(struct nbl_flow_ht_mng *pp_ht0_mng,
+					struct nbl_flow_ht_mng *pp_ht1_mng,
+					u16 ht0_hash, u16 ht1_hash)
+{
+	struct nbl_flow_ht_tbl *pp_ht0_node = NULL;
+	struct nbl_flow_ht_tbl *pp_ht1_node = NULL;
+
+	pp_ht0_node = pp_ht0_mng->hash_map[ht0_hash];
+	pp_ht1_node = pp_ht1_mng->hash_map[ht1_hash];
+
+	if (!pp_ht0_node && !pp_ht1_node) {
+		return 0;
+	} else if (pp_ht0_node && !pp_ht1_node) {
+		if (pp_ht0_node->ref_cnt >= NBL_HASH_CFT_AVL)
+			return 1;
+		else
+			return 0;
+	} else if (!pp_ht0_node && pp_ht1_node) {
+		if (pp_ht1_node->ref_cnt >= NBL_HASH_CFT_AVL)
+			return 0;
+		else
+			return 1;
+	} else {
+		if ((pp_ht0_node->ref_cnt <= NBL_HASH_CFT_AVL ||
+		     (pp_ht0_node->ref_cnt > NBL_HASH_CFT_AVL &&
+		      pp_ht0_node->ref_cnt < NBL_HASH_CFT_MAX &&
+		      pp_ht1_node->ref_cnt > NBL_HASH_CFT_AVL)))
+			return 0;
+		else if (((pp_ht0_node->ref_cnt > NBL_HASH_CFT_AVL &&
+			   pp_ht1_node->ref_cnt <= NBL_HASH_CFT_AVL) ||
+			  (pp_ht0_node->ref_cnt == NBL_HASH_CFT_MAX &&
+			   pp_ht1_node->ref_cnt > NBL_HASH_CFT_AVL &&
+			   pp_ht1_node->ref_cnt < NBL_HASH_CFT_MAX)))
+			return 1;
+		else
+			return -1;
+	}
+}
+
+static int nbl_flow_insert_pp_ht(struct nbl_flow_ht_mng *pp_ht_mng, u16 hash,
+				 u16 hash_other, u32 key_index)
+{
+	struct nbl_flow_ht_tbl *node;
+	int i;
+
+	node = pp_ht_mng->hash_map[hash];
+	if (!node) {
+		node = kzalloc(sizeof(*node), GFP_KERNEL);
+		if (!node)
+			return -ENOSPC;
+		pp_ht_mng->hash_map[hash] = node;
+	}
+
+	for (i = 0; i < NBL_HASH_CFT_MAX; i++) {
+		if (node->key[i].vid == 0) {
+			node->key[i].vid = 1;
+			node->key[i].ht_other_index = hash_other;
+			node->key[i].kt_index = key_index;
+			node->ref_cnt++;
+			break;
+		}
+	}
+
+	return i;
+}
+
+static void nbl_flow_add_ht(struct nbl_ht_item *ht_item,
+			    struct nbl_flow_fem_entry *flow, u32 key_index,
+			    struct nbl_flow_ht_mng *pp_ht_mng, u8 ht_table)
+{
+	u16 ht_hash;
+	u16 ht_other_hash;
+
+	ht_hash = ht_table == NBL_HT0 ? flow->ht0_hash : flow->ht1_hash;
+	ht_other_hash = ht_table == NBL_HT0 ? flow->ht1_hash : flow->ht0_hash;
+
+	ht_item->hash_bucket = nbl_flow_insert_pp_ht(pp_ht_mng, ht_hash,
+						     ht_other_hash, key_index);
+	if (ht_item->hash_bucket < 0)
+		return;
+
+	ht_item->ht_table = ht_table;
+	ht_item->key_index = key_index;
+	ht_item->ht0_hash = flow->ht0_hash;
+	ht_item->ht1_hash = flow->ht1_hash;
+
+	flow->hash_bucket = ht_item->hash_bucket;
+	flow->hash_table = ht_item->ht_table;
+}
+
+static void nbl_flow_del_ht(struct nbl_ht_item *ht_item,
+			    struct nbl_flow_fem_entry *flow,
+			    struct nbl_flow_ht_mng *pp_ht_mng)
+{
+	struct nbl_flow_ht_tbl *pp_ht_node = NULL;
+	u16 ht_hash;
+	u16 ht_other_hash;
+	int i;
+
+	ht_hash = ht_item->ht_table == NBL_HT0 ? flow->ht0_hash :
+						 flow->ht1_hash;
+	ht_other_hash = ht_item->ht_table == NBL_HT0 ? flow->ht1_hash :
+						       flow->ht0_hash;
+
+	pp_ht_node = pp_ht_mng->hash_map[ht_hash];
+	if (!pp_ht_node)
+		return;
+
+	for (i = 0; i < NBL_HASH_CFT_MAX; i++) {
+		if (pp_ht_node->key[i].vid == 1 &&
+		    pp_ht_node->key[i].ht_other_index == ht_other_hash) {
+			memset(&pp_ht_node->key[i], 0,
+			       sizeof(pp_ht_node->key[i]));
+			pp_ht_node->ref_cnt--;
+			break;
+		}
+	}
+
+	if (!pp_ht_node->ref_cnt) {
+		kfree(pp_ht_node);
+		pp_ht_mng->hash_map[ht_hash] = NULL;
+	}
+}
+
+static int nbl_flow_send_2hw(struct nbl_resource_mgt *res_mgt,
+			     struct nbl_ht_item ht_item,
+			     struct nbl_kt_item kt_item, u8 key_type)
+{
+	struct nbl_hw_ops *hw_ops;
+	u16 hash, hash_other;
+	int ret = 0;
+
+	hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+
+	ret = hw_ops->set_kt(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+			     kt_item.kt_data.hash_key, ht_item.key_index,
+			     key_type);
+	if (ret)
+		goto set_kt_fail;
+
+	hash = ht_item.ht_table == NBL_HT0 ? ht_item.ht0_hash :
+					     ht_item.ht1_hash;
+	hash_other = ht_item.ht_table == NBL_HT0 ? ht_item.ht1_hash :
+						   ht_item.ht0_hash;
+	ret = hw_ops->set_ht(NBL_RES_MGT_TO_HW_PRIV(res_mgt), hash, hash_other,
+			     ht_item.ht_table, ht_item.hash_bucket,
+			     ht_item.key_index, 1);
+	if (ret)
+		goto set_ht_fail;
+
+	ret = hw_ops->search_key(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+				 kt_item.kt_data.hash_key, key_type);
+	if (ret)
+		goto search_fail;
+
+	return 0;
+
+search_fail:
+	ret = hw_ops->set_ht(NBL_RES_MGT_TO_HW_PRIV(res_mgt), hash, 0,
+			     ht_item.ht_table, ht_item.hash_bucket, 0, 0);
+set_ht_fail:
+	memset(kt_item.kt_data.hash_key, 0, sizeof(kt_item.kt_data.hash_key));
+	hw_ops->set_kt(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+		       kt_item.kt_data.hash_key, ht_item.key_index, key_type);
+set_kt_fail:
+	return ret;
+}
+
+static int nbl_flow_del_2hw(struct nbl_resource_mgt *res_mgt,
+			    struct nbl_ht_item ht_item,
+			    struct nbl_kt_item kt_item, u8 key_type)
+{
+	struct nbl_hw_ops *hw_ops;
+	u16 hash;
+
+	hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+
+	hash = ht_item.ht_table == NBL_HT0 ? ht_item.ht0_hash :
+					     ht_item.ht1_hash;
+	hw_ops->set_ht(NBL_RES_MGT_TO_HW_PRIV(res_mgt), hash, 0,
+		       ht_item.ht_table, ht_item.hash_bucket, 0, 0);
+
+	return 0;
+}
+
+static void nbl_flow_cfg_tcam(struct nbl_tcam_item *tcam_item,
+			      struct nbl_ht_item *ht_item,
+			      struct nbl_kt_item *kt_item, u32 action0,
+			      u32 action1)
+{
+	tcam_item->key_mode = NBL_KT_HALF_MODE;
+	tcam_item->pp_type = NBL_PT_PP0;
+	tcam_item->tcam_action[0] = action0;
+	tcam_item->tcam_action[1] = action1;
+	memcpy(&tcam_item->ht_item, ht_item, sizeof(struct nbl_ht_item));
+	memcpy(&tcam_item->kt_item, kt_item, sizeof(struct nbl_kt_item));
+}
+
+static int nbl_flow_add_tcam(struct nbl_resource_mgt *res_mgt,
+			     struct nbl_tcam_item tcam_item)
+{
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+
+	return hw_ops->add_tcam(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+				tcam_item.tcam_index,
+				tcam_item.kt_item.kt_data.hash_key,
+				tcam_item.tcam_action, tcam_item.key_mode,
+				NBL_PT_PP0);
+}
+
+static void nbl_flow_del_tcam(struct nbl_resource_mgt *res_mgt,
+			      struct nbl_tcam_item tcam_item)
+{
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+
+	hw_ops->del_tcam(NBL_RES_MGT_TO_HW_PRIV(res_mgt), tcam_item.tcam_index,
+			 tcam_item.key_mode, NBL_PT_PP0);
+}
+
+static int nbl_flow_add_flow(struct nbl_resource_mgt *res_mgt,
+			     struct nbl_flow_param param, s32 type,
+			     struct nbl_flow_fem_entry *flow)
+{
+	struct nbl_flow_mgt *flow_mgt;
+	struct nbl_common_info *common;
+	struct nbl_mt_input mt_input;
+	struct nbl_ht_item ht_item;
+	struct nbl_kt_item kt_item;
+	struct nbl_tcam_item *tcam_item = NULL;
+	struct nbl_flow_ht_mng *pp_ht_mng = NULL;
+	u32 action0, action1;
+	int ht_table;
+	int ret = 0;
+
+	memset(&mt_input, 0, sizeof(mt_input));
+	memset(&ht_item, 0, sizeof(ht_item));
+	memset(&kt_item, 0, sizeof(kt_item));
+
+	tcam_item = kzalloc(sizeof(*tcam_item), GFP_ATOMIC);
+	if (!tcam_item)
+		return -ENOMEM;
+
+	flow_mgt = NBL_RES_MGT_TO_FLOW_MGT(res_mgt);
+	common = NBL_RES_MGT_TO_COMMON(res_mgt);
+
+	flow->flow_type = param.type;
+	flow->type = type;
+	flow->flow_id = 0xFFFF;
+
+	ret = nbl_flow_alloc_flow_id(flow_mgt, flow);
+	if (ret)
+		goto free_mem;
+
+	ret = cfg_ops[type].cfg_action(param, &action0, &action1);
+	if (ret)
+		goto free_mem;
+
+	ret = cfg_ops[type].cfg_key(&kt_item.kt_data, param,
+				    NBL_COMMON_TO_ETH_MODE(common));
+	if (ret)
+		goto free_mem;
+
+	nbl_flow_set_mt_input(&mt_input, &kt_item.kt_data, param.type,
+			      flow->flow_id);
+	nbl_flow_key_hash(flow, &mt_input);
+
+	if (nbl_flow_check_ht_conflict(&flow_mgt->pp0_ht0_mng,
+				       &flow_mgt->pp0_ht1_mng, flow->ht0_hash,
+				       flow->ht1_hash, common))
+		flow->tcam_flag = true;
+
+	ht_table = nbl_flow_find_ht_avail_table(&flow_mgt->pp0_ht0_mng,
+						&flow_mgt->pp0_ht1_mng,
+						flow->ht0_hash, flow->ht1_hash);
+	if (ht_table < 0)
+		flow->tcam_flag = true;
+
+	if (!flow->tcam_flag) {
+		pp_ht_mng = ht_table == NBL_HT0 ? &flow_mgt->pp0_ht0_mng :
+						  &flow_mgt->pp0_ht1_mng;
+		nbl_flow_add_ht(&ht_item, flow, mt_input.tbl_id, pp_ht_mng,
+				ht_table);
+
+		cfg_ops[type].cfg_kt_action(&kt_item.kt_data, action0, action1);
+		ret = nbl_flow_send_2hw(res_mgt, ht_item, kt_item, param.type);
+	} else {
+		ret = nbl_flow_alloc_tcam_id(flow_mgt, tcam_item);
+		if (ret)
+			goto out;
+
+		nbl_flow_cfg_tcam(tcam_item, &ht_item, &kt_item, action0,
+				  action1);
+		flow->tcam_index = tcam_item->tcam_index;
+
+		ret = nbl_flow_add_tcam(res_mgt, *tcam_item);
+	}
+
+out:
+	if (ret) {
+		if (flow->tcam_flag)
+			nbl_flow_free_tcam_id(flow_mgt, tcam_item);
+		else
+			nbl_flow_del_ht(&ht_item, flow, pp_ht_mng);
+
+		nbl_flow_free_flow_id(flow_mgt, flow);
+	}
+
+free_mem:
+	kfree(tcam_item);
+
+	return ret;
+}
+
+static void nbl_flow_del_flow(struct nbl_resource_mgt *res_mgt,
+			      struct nbl_flow_fem_entry *flow)
+{
+	struct nbl_flow_mgt *flow_mgt;
+	struct nbl_ht_item ht_item;
+	struct nbl_kt_item kt_item;
+	struct nbl_tcam_item tcam_item;
+	struct nbl_flow_ht_mng *pp_ht_mng = NULL;
+
+	if (flow->flow_id == 0xFFFF)
+		return;
+
+	memset(&ht_item, 0, sizeof(ht_item));
+	memset(&kt_item, 0, sizeof(kt_item));
+	memset(&tcam_item, 0, sizeof(tcam_item));
+
+	flow_mgt = NBL_RES_MGT_TO_FLOW_MGT(res_mgt);
+
+	if (!flow->tcam_flag) {
+		ht_item.ht_table = flow->hash_table;
+		ht_item.ht0_hash = flow->ht0_hash;
+		ht_item.ht1_hash = flow->ht1_hash;
+		ht_item.hash_bucket = flow->hash_bucket;
+
+		pp_ht_mng = flow->hash_table == NBL_HT0 ?
+				    &flow_mgt->pp0_ht0_mng :
+				    &flow_mgt->pp0_ht1_mng;
+
+		nbl_flow_del_ht(&ht_item, flow, pp_ht_mng);
+		nbl_flow_del_2hw(res_mgt, ht_item, kt_item, flow->flow_type);
+	} else {
+		tcam_item.tcam_index = flow->tcam_index;
+		nbl_flow_del_tcam(res_mgt, tcam_item);
+		nbl_flow_free_tcam_id(flow_mgt, &tcam_item);
+	}
+
+	nbl_flow_free_flow_id(flow_mgt, flow);
+}
+
+static struct nbl_flow_mcc_node *
+nbl_flow_alloc_mcc_node(struct nbl_flow_mgt *flow_mgt, u8 type, u16 data,
+			u16 head)
+{
+	struct nbl_flow_mcc_node *node;
+	int mcc_id;
+	u16 mcc_action;
+
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return NULL;
+
+	mcc_id = nbl_flow_alloc_mcc_id(flow_mgt);
+	if (mcc_id < 0) {
+		kfree(node);
+		return NULL;
+	}
+
+	switch (type) {
+	case NBL_MCC_INDEX_ETH:
+		mcc_action = nbl_flow_cfg_action_set_dport_mcc_eth((u8)data);
+		break;
+	case NBL_MCC_INDEX_VSI:
+		mcc_action = nbl_flow_cfg_action_set_dport_mcc_vsi(data);
+		break;
+	case NBL_MCC_INDEX_BMC:
+		mcc_action = nbl_flow_cfg_action_set_dport_mcc_bmc();
+		break;
+	default:
+		nbl_flow_free_mcc_id(flow_mgt, mcc_id);
+		kfree(node);
+		return NULL;
+	}
+
+	INIT_LIST_HEAD(&node->node);
+	node->mcc_id = mcc_id;
+	node->mcc_head = head;
+	node->type = type;
+	node->data = data;
+	node->mcc_action = mcc_action;
+
+	return node;
+}
+
+static void nbl_flow_free_mcc_node(struct nbl_flow_mgt *flow_mgt,
+				   struct nbl_flow_mcc_node *node)
+{
+	nbl_flow_free_mcc_id(flow_mgt, node->mcc_id);
+	kfree(node);
+}
+
+/* not consider multicast node first change, need modify all macvlan mcc */
+static int nbl_flow_add_mcc_node(struct nbl_resource_mgt *res_mgt,
+				 struct nbl_flow_mcc_node *mcc_node,
+				 struct list_head *head, struct list_head *list,
+				 struct list_head *suffix)
+{
+	struct nbl_flow_mcc_node *mcc_head = NULL;
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	u16 prev_mcc_id, next_mcc_id = NBL_MCC_ID_INVALID;
+	int ret = 0;
+
+	/* mcc_head must init before mcc_list */
+	if (mcc_node->mcc_head) {
+		list_add_tail(&mcc_node->node, head);
+		prev_mcc_id = NBL_MCC_ID_INVALID;
+
+		WARN_ON(!list_empty(list));
+		ret = hw_ops->add_mcc(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+				      mcc_node->mcc_id, prev_mcc_id,
+				      NBL_MCC_ID_INVALID, mcc_node->mcc_action);
+		goto check_ret;
+	}
+
+	list_add_tail(&mcc_node->node, list);
+
+	if (list_is_first(&mcc_node->node, list))
+		prev_mcc_id = NBL_MCC_ID_INVALID;
+	else
+		prev_mcc_id = list_prev_entry(mcc_node, node)->mcc_id;
+
+	/* not head, next mcc may point suffix */
+	if (suffix && !list_empty(suffix))
+		next_mcc_id =
+			list_first_entry(suffix, struct nbl_flow_mcc_node, node)
+				->mcc_id;
+	else
+		next_mcc_id = NBL_MCC_ID_INVALID;
+
+	/* first add mcc_list */
+	if (prev_mcc_id == NBL_MCC_ID_INVALID && !list_empty(head)) {
+		list_for_each_entry(mcc_head, head, node) {
+			prev_mcc_id = mcc_head->mcc_id;
+			ret |= hw_ops->add_mcc(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+					       mcc_node->mcc_id, prev_mcc_id,
+					       next_mcc_id,
+					       mcc_node->mcc_action);
+		}
+		goto check_ret;
+	}
+
+	ret = hw_ops->add_mcc(NBL_RES_MGT_TO_HW_PRIV(res_mgt), mcc_node->mcc_id,
+			      prev_mcc_id, next_mcc_id, mcc_node->mcc_action);
+check_ret:
+	if (ret) {
+		list_del(&mcc_node->node);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/* not consider multicast node first change, need modify all macvlan mcc */
+static void nbl_flow_del_mcc_node(struct nbl_resource_mgt *res_mgt,
+				  struct nbl_flow_mcc_node *mcc_node,
+				  struct list_head *head,
+				  struct list_head *list,
+				  struct list_head *suffix)
+{
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	struct nbl_flow_mcc_node *mcc_head = NULL;
+	u16 prev_mcc_id, next_mcc_id;
+
+	if (list_entry_is_head(mcc_node, head, node) ||
+	    list_entry_is_head(mcc_node, list, node))
+		return;
+
+	if (mcc_node->mcc_head) {
+		WARN_ON(!list_empty(list));
+		prev_mcc_id = NBL_MCC_ID_INVALID;
+		next_mcc_id = NBL_MCC_ID_INVALID;
+		hw_ops->del_mcc(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+				mcc_node->mcc_id, prev_mcc_id, next_mcc_id);
+		goto free_node;
+	}
+
+	if (list_is_first(&mcc_node->node, list))
+		prev_mcc_id = NBL_MCC_ID_INVALID;
+	else
+		prev_mcc_id = list_prev_entry(mcc_node, node)->mcc_id;
+
+	if (list_is_last(&mcc_node->node, list))
+		next_mcc_id = NBL_MCC_ID_INVALID;
+	else
+		next_mcc_id = list_next_entry(mcc_node, node)->mcc_id;
+
+	/* not head, next mcc may point suffix */
+	if (next_mcc_id == NBL_MCC_ID_INVALID && suffix && !list_empty(suffix))
+		next_mcc_id =
+			list_first_entry(suffix, struct nbl_flow_mcc_node, node)
+				->mcc_id;
+
+	if (prev_mcc_id == NBL_MCC_ID_INVALID && !list_empty(head)) {
+		list_for_each_entry(mcc_head, head, node) {
+			prev_mcc_id = mcc_head->mcc_id;
+			hw_ops->del_mcc(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+					mcc_node->mcc_id, prev_mcc_id,
+					next_mcc_id);
+		}
+		goto free_node;
+	}
+
+	hw_ops->del_mcc(NBL_RES_MGT_TO_HW_PRIV(res_mgt), mcc_node->mcc_id,
+			 prev_mcc_id, next_mcc_id);
+free_node:
+	list_del(&mcc_node->node);
+}
+
+static struct nbl_flow_mcc_group *
+nbl_flow_alloc_mcc_group(struct nbl_resource_mgt *res_mgt,
+			 unsigned long *vsi_bitmap, u16 eth_id, bool multi,
+			 u16 vsi_num)
+{
+	struct nbl_flow_mgt *flow_mgt = NBL_RES_MGT_TO_FLOW_MGT(res_mgt);
+	struct nbl_flow_switch_res *res = &flow_mgt->switch_res[eth_id];
+	struct nbl_flow_mcc_group *group;
+	struct nbl_flow_mcc_node *mcc_node, *mcc_node_safe;
+	int ret;
+	int bit;
+
+	/* The structure for mc macvlan list is:
+	 *
+	 *    macvlan up
+	 *         |
+	 *         |
+	 *        BMC       ->       |
+	 *                           VSI 0  ->  VSI 1  ->     -> allmulti list
+	 *        ETH       ->       |
+	 *         |
+	 *         |
+	 *    macvlan down
+	 *
+	 * So that the up mc pkts will be send to BMC, not need broadcast to
+	 *eth, but the down mc pkts will send to eth, not send to BMC.
+	 * Per mac flow entry has independent bmc/eth mcc nodes.
+	 * All mac flow entry share all allmuti vsi nodes.
+	 */
+	group = kzalloc(sizeof(*group), GFP_KERNEL);
+	if (!group)
+		return NULL;
+
+	group->vsi_base = eth_id * NBL_FLOW_LEONIS_VSI_NUM_PER_ETH;
+	group->multi = multi;
+	group->nbits = flow_mgt->vsi_max_per_switch;
+	group->ref_cnt = 1;
+	group->vsi_num = vsi_num;
+
+	INIT_LIST_HEAD(&group->group_node);
+	INIT_LIST_HEAD(&group->mcc_node);
+	INIT_LIST_HEAD(&group->mcc_head);
+
+	group->vsi_bitmap = kcalloc(BITS_TO_LONGS(flow_mgt->vsi_max_per_switch),
+				    sizeof(long), GFP_KERNEL);
+	if (!group->vsi_bitmap)
+		goto alloc_vsi_bitmap_failed;
+
+	bitmap_copy(group->vsi_bitmap, vsi_bitmap,
+		    flow_mgt->vsi_max_per_switch);
+	if (!multi)
+		goto add_mcc_node;
+
+	mcc_node =
+		nbl_flow_alloc_mcc_node(flow_mgt, NBL_MCC_INDEX_ETH, eth_id, 1);
+	if (!mcc_node)
+		goto free_nodes;
+
+	ret = nbl_flow_add_mcc_node(res_mgt, mcc_node, &group->mcc_head,
+				    &group->mcc_node, NULL);
+	if (ret) {
+		nbl_flow_free_mcc_node(flow_mgt, mcc_node);
+		goto free_nodes;
+	}
+
+	group->down_mcc_id = mcc_node->mcc_id;
+	mcc_node = nbl_flow_alloc_mcc_node(flow_mgt, NBL_MCC_INDEX_BMC,
+					   NBL_FLOW_MCC_BMC_DPORT, 1);
+	if (!mcc_node)
+		goto free_nodes;
+
+	ret = nbl_flow_add_mcc_node(res_mgt, mcc_node, &group->mcc_head,
+				    &group->mcc_node, NULL);
+	if (ret) {
+		nbl_flow_free_mcc_node(flow_mgt, mcc_node);
+		goto free_nodes;
+	}
+	group->up_mcc_id = mcc_node->mcc_id;
+
+add_mcc_node:
+	for_each_set_bit(bit, vsi_bitmap, flow_mgt->vsi_max_per_switch) {
+		mcc_node = nbl_flow_alloc_mcc_node(flow_mgt, NBL_MCC_INDEX_VSI,
+						   bit + group->vsi_base, 0);
+		if (!mcc_node)
+			goto free_nodes;
+
+		if (multi)
+			ret = nbl_flow_add_mcc_node(res_mgt, mcc_node,
+						    &group->mcc_head,
+						    &group->mcc_node,
+						    &res->allmulti_list);
+		else
+			ret = nbl_flow_add_mcc_node(res_mgt, mcc_node,
+						    &group->mcc_head,
+						    &group->mcc_node, NULL);
+
+		if (ret) {
+			nbl_flow_free_mcc_node(flow_mgt, mcc_node);
+			goto free_nodes;
+		}
+	}
+
+	if (list_empty(&group->mcc_head)) {
+		group->down_mcc_id = list_first_entry(&group->mcc_node,
+						      struct nbl_flow_mcc_node,
+						      node)
+					     ->mcc_id;
+		group->up_mcc_id = list_first_entry(&group->mcc_node,
+						    struct nbl_flow_mcc_node,
+						    node)
+					   ->mcc_id;
+	}
+	list_add_tail(&group->group_node, &res->mcc_group_head);
+
+	return group;
+
+free_nodes:
+	list_for_each_entry_safe(mcc_node, mcc_node_safe, &group->mcc_node,
+				 node) {
+		nbl_flow_del_mcc_node(res_mgt, mcc_node, &group->mcc_head,
+				      &group->mcc_node, NULL);
+		nbl_flow_free_mcc_node(flow_mgt, mcc_node);
+	}
+
+	list_for_each_entry_safe(mcc_node, mcc_node_safe, &group->mcc_head,
+				 node) {
+		nbl_flow_del_mcc_node(res_mgt, mcc_node, &group->mcc_head,
+				      &group->mcc_node, NULL);
+		nbl_flow_free_mcc_node(flow_mgt, mcc_node);
+	}
+	kfree(group->vsi_bitmap);
+alloc_vsi_bitmap_failed:
+	kfree(group);
+
+	return NULL;
+}
+
+static void nbl_flow_free_mcc_group(struct nbl_resource_mgt *res_mgt,
+				    struct nbl_flow_mcc_group *group)
+{
+	struct nbl_flow_mgt *flow_mgt = NBL_RES_MGT_TO_FLOW_MGT(res_mgt);
+	struct nbl_flow_mcc_node *mcc_node, *mcc_node_safe;
+
+	group->ref_cnt--;
+	if (group->ref_cnt)
+		return;
+
+	list_del(&group->group_node);
+	list_for_each_entry_safe(mcc_node, mcc_node_safe, &group->mcc_node,
+				 node) {
+		nbl_flow_del_mcc_node(res_mgt, mcc_node, &group->mcc_head,
+				      &group->mcc_node, NULL);
+		nbl_flow_free_mcc_node(flow_mgt, mcc_node);
+	}
+
+	list_for_each_entry_safe(mcc_node, mcc_node_safe, &group->mcc_head,
+				 node) {
+		nbl_flow_del_mcc_node(res_mgt, mcc_node, &group->mcc_head,
+				      &group->mcc_node, NULL);
+		nbl_flow_free_mcc_node(flow_mgt, mcc_node);
+	}
+
+	kfree(group->vsi_bitmap);
+	kfree(group);
+}
+
+static struct nbl_flow_mcc_group *
+nbl_find_same_mcc_group(struct nbl_flow_switch_res *res,
+			unsigned long *vsi_bitmap, bool multi)
+{
+	struct nbl_flow_mcc_group *group = NULL;
+
+	list_for_each_entry(group, &res->mcc_group_head, group_node)
+		if (group->multi == multi &&
+		    __bitmap_equal(group->vsi_bitmap, vsi_bitmap,
+				   group->nbits)) {
+			group->ref_cnt++;
+			return group;
+		}
+
+	return NULL;
+}
+
+static void nbl_flow_macvlan_node_del_action_func(void *priv, void *x_key,
+						  void *y_key, void *data)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_flow_l2_data *rule_data = (struct nbl_flow_l2_data *)data;
+	int i;
+
+	for (i = 0; i < NBL_FLOW_MACVLAN_MAX; i++) {
+		if (i == NBL_FLOW_UP_TNL && rule_data->multi)
+			continue;
+		nbl_flow_del_flow(res_mgt, &rule_data->entry[i]);
+	}
+
+	/* delete mcc */
+	if (rule_data->mcast_flow)
+		nbl_flow_free_mcc_group(res_mgt, rule_data->mcc_group);
+}
+
+static u32 nbl_flow_get_reserve_macvlan_cnt(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_flow_mgt *flow_mgt = NBL_RES_MGT_TO_FLOW_MGT(res_mgt);
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	struct nbl_flow_switch_res *res;
+	int i;
+	u32 reserve_cnt = 0;
+
+	for_each_set_bit(i, eth_info->eth_bitmap, NBL_MAX_ETHERNET) {
+		res = &flow_mgt->switch_res[i];
+		if (res->num_vfs)
+			reserve_cnt += (res->num_vfs - res->active_vfs) * 3;
+	}
+
+	return reserve_cnt;
+}
+
+static int nbl_flow_macvlan_node_vsi_match_func(void *condition, void *x_key,
+						void *y_key, void *data)
+{
+	u16 vsi = *(u16 *)condition;
+	struct nbl_flow_l2_data *rule_data = (struct nbl_flow_l2_data *)data;
+
+	if (!rule_data->mcast_flow)
+		return rule_data->vsi == vsi ? 0 : -1;
+	else
+		return !test_bit(vsi - rule_data->mcc_group->vsi_base,
+				 rule_data->mcc_group->vsi_bitmap);
+}
+
+static void nbl_flow_macvlan_node_found_vsi_action(void *priv, void *x_key,
+						   void *y_key, void *data)
+{
+	bool *match = (bool *)(priv);
+
+	*match = 1;
+}
+
+static int nbl_flow_add_macvlan(void *priv, u8 *mac, u16 vlan, u16 vsi)
+{
+	struct nbl_hash_xy_tbl_scan_key scan_key;
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_flow_mgt *flow_mgt = NBL_RES_MGT_TO_FLOW_MGT(res_mgt);
+	struct nbl_flow_switch_res *res;
+	struct nbl_flow_l2_data *rule_data;
+	struct nbl_flow_mcc_group *mcc_group = NULL, *pend_group = NULL;
+	unsigned long *vsi_bitmap;
+	struct nbl_flow_param param = { 0 };
+	void *tbl;
+	int i;
+	int ret = 0;
+	int pf_id, vf_id;
+	u32 reserve_cnt;
+	u16 eth_id;
+	u16 vsi_base;
+	u16 vsi_num = 0;
+	u16 func_id;
+	bool alloc_rule = 0;
+	bool need_mcast = 0;
+	bool vsi_match = 0;
+
+	eth_id = nbl_res_vsi_id_to_eth_id(res_mgt, vsi);
+	res = &flow_mgt->switch_res[eth_id];
+
+	func_id = nbl_res_vsi_id_to_func_id(res_mgt, vsi);
+	nbl_res_func_id_to_pfvfid(res_mgt, func_id, &pf_id, &vf_id);
+	reserve_cnt = nbl_flow_get_reserve_macvlan_cnt(res_mgt);
+
+	if (flow_mgt->flow_id_cnt <= reserve_cnt &&
+	    (vf_id == U32_MAX || test_bit(vf_id, res->vf_bitmap)))
+		return -ENOSPC;
+
+	vsi_bitmap = kcalloc(BITS_TO_LONGS(flow_mgt->vsi_max_per_switch),
+			     sizeof(long), GFP_KERNEL);
+	if (!vsi_bitmap)
+		return -ENOMEM;
+
+	NBL_HASH_XY_TBL_SCAN_KEY_INIT(&scan_key,
+				      NBL_HASH_TBL_OP_SHOW,
+				      NBL_HASH_TBL_ALL_SCAN,
+				      false, NULL, NULL, &vsi,
+				      &nbl_flow_macvlan_node_vsi_match_func,
+				      &vsi_match,
+				      &nbl_flow_macvlan_node_found_vsi_action);
+
+	param.mac = mac;
+	param.vid = vlan;
+	param.eth = eth_id;
+	param.vsi = vsi;
+	param.mcc_id = NBL_MCC_ID_INVALID;
+
+	vsi_base = eth_id * NBL_FLOW_LEONIS_VSI_NUM_PER_ETH;
+	tbl = res->mac_hash_tbl;
+	rule_data =
+		(struct nbl_flow_l2_data *)nbl_common_get_hash_xy_node(tbl,
+								       mac,
+								       &vlan);
+	if (rule_data) {
+		if (rule_data->mcast_flow &&
+		    test_bit(vsi - rule_data->mcc_group->vsi_base,
+			     rule_data->mcc_group->vsi_bitmap))
+			goto success;
+		else if (!rule_data->mcast_flow && rule_data->vsi == vsi)
+			goto success;
+
+		if (!rule_data->mcast_flow) {
+			vsi_num = 1;
+			set_bit(rule_data->vsi - vsi_base, vsi_bitmap);
+		} else {
+			vsi_num = rule_data->mcc_group->vsi_num;
+			bitmap_copy(vsi_bitmap,
+				    rule_data->mcc_group->vsi_bitmap,
+				    flow_mgt->vsi_max_per_switch);
+		}
+		need_mcast = 1;
+
+	} else {
+		rule_data = kzalloc(sizeof(*rule_data), GFP_KERNEL);
+		if (!rule_data) {
+			ret = -ENOMEM;
+			goto alloc_rule_failed;
+		}
+		alloc_rule = 1;
+		rule_data->multi = is_multicast_ether_addr(mac);
+		rule_data->mcast_flow = 0;
+	}
+
+	if (rule_data->multi)
+		need_mcast = 1;
+
+	if (need_mcast) {
+		set_bit(vsi - vsi_base, vsi_bitmap);
+		vsi_num++;
+		mcc_group = nbl_find_same_mcc_group(res, vsi_bitmap,
+						    rule_data->multi);
+		if (!mcc_group) {
+			mcc_group = nbl_flow_alloc_mcc_group(res_mgt,
+							     vsi_bitmap, eth_id,
+							     rule_data->multi,
+							     vsi_num);
+			if (!mcc_group) {
+				ret = -ENOMEM;
+				goto alloc_mcc_group_failed;
+			}
+		}
+		if (rule_data->mcast_flow)
+			pend_group = rule_data->mcc_group;
+	} else {
+		rule_data->vsi = vsi;
+	}
+
+	if (!alloc_rule) {
+		for (i = 0; i < NBL_FLOW_MACVLAN_MAX; i++) {
+			if (i == NBL_FLOW_UP_TNL && rule_data->multi)
+				continue;
+
+			nbl_flow_del_flow(res_mgt, &rule_data->entry[i]);
+		}
+
+		if (pend_group)
+			nbl_flow_free_mcc_group(res_mgt, pend_group);
+	}
+
+	for (i = 0; i < NBL_FLOW_MACVLAN_MAX; i++) {
+		if (i == NBL_FLOW_UP_TNL && rule_data->multi)
+			continue;
+		if (mcc_group) {
+			if (i <= NBL_FLOW_UP)
+				param.mcc_id = mcc_group->up_mcc_id;
+			else
+				param.mcc_id = mcc_group->down_mcc_id;
+		}
+		ret = nbl_flow_add_flow(res_mgt, param, i,
+					&rule_data->entry[i]);
+		if (ret)
+			goto add_flow_failed;
+	}
+
+	if (mcc_group) {
+		rule_data->mcast_flow = 1;
+		rule_data->mcc_group = mcc_group;
+	} else {
+		rule_data->mcast_flow = 0;
+		rule_data->vsi = vsi;
+	}
+
+	if (alloc_rule) {
+		ret = nbl_common_alloc_hash_xy_node(res->mac_hash_tbl, mac,
+						    &vlan, rule_data);
+		if (ret)
+			goto add_flow_failed;
+	}
+
+	if (alloc_rule)
+		kfree(rule_data);
+success:
+	kfree(vsi_bitmap);
+
+	if (vf_id != U32_MAX && !test_bit(vf_id, res->vf_bitmap)) {
+		set_bit(vf_id, res->vf_bitmap);
+		res->active_vfs++;
+	}
+
+	return 0;
+
+add_flow_failed:
+	while (--i + 1) {
+		if (i == NBL_FLOW_UP_TNL && rule_data->multi)
+			continue;
+		nbl_flow_del_flow(res_mgt, &rule_data->entry[i]);
+	}
+	if (!alloc_rule)
+		nbl_common_free_hash_xy_node(res->mac_hash_tbl, mac, &vlan);
+	if (mcc_group)
+		nbl_flow_free_mcc_group(res_mgt, mcc_group);
+alloc_mcc_group_failed:
+	if (alloc_rule)
+		kfree(rule_data);
+alloc_rule_failed:
+	kfree(vsi_bitmap);
+
+	nbl_common_scan_hash_xy_node(res->mac_hash_tbl, &scan_key);
+	if (vf_id != U32_MAX && test_bit(vf_id, res->vf_bitmap) && !vsi_match) {
+		clear_bit(vf_id, res->vf_bitmap);
+		res->active_vfs--;
+	}
+
+	return ret;
+}
+
+static void nbl_flow_del_macvlan(void *priv, u8 *mac, u16 vlan, u16 vsi)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_flow_mgt *flow_mgt = NBL_RES_MGT_TO_FLOW_MGT(res_mgt);
+	struct nbl_flow_mcc_group *mcc_group = NULL, *pend_group = NULL;
+	unsigned long *vsi_bitmap;
+	struct nbl_flow_switch_res *res;
+	struct nbl_flow_l2_data *rule_data;
+	struct nbl_flow_param param = { 0 };
+	struct nbl_hash_xy_tbl_scan_key scan_key;
+	int i;
+	int ret;
+	int pf_id, vf_id;
+	u32 vsi_num;
+	u16 vsi_base = 0;
+	u16 eth_id;
+	u16 func_id;
+	bool need_mcast = false;
+	bool add_flow = false;
+	bool vsi_match = 0;
+
+	eth_id = nbl_res_vsi_id_to_eth_id(res_mgt, vsi);
+	res = &flow_mgt->switch_res[eth_id];
+
+	rule_data = nbl_common_get_hash_xy_node(res->mac_hash_tbl, mac, &vlan);
+	if (!rule_data)
+		return;
+	if (!rule_data->mcast_flow && rule_data->vsi != vsi)
+		return;
+	else if (rule_data->mcast_flow &&
+		 !test_bit(vsi - rule_data->mcc_group->vsi_base,
+			   rule_data->mcc_group->vsi_bitmap))
+		return;
+
+	vsi_bitmap = kcalloc(BITS_TO_LONGS(flow_mgt->vsi_max_per_switch),
+			     sizeof(long), GFP_KERNEL);
+	if (!vsi_bitmap)
+		return;
+
+	func_id = nbl_res_vsi_id_to_func_id(res_mgt, vsi);
+	nbl_res_func_id_to_pfvfid(res_mgt, func_id, &pf_id, &vf_id);
+	NBL_HASH_XY_TBL_SCAN_KEY_INIT(&scan_key, NBL_HASH_TBL_OP_SHOW,
+				      NBL_HASH_TBL_ALL_SCAN, false, NULL, NULL,
+				      &vsi,
+				      &nbl_flow_macvlan_node_vsi_match_func,
+				      &vsi_match,
+				      &nbl_flow_macvlan_node_found_vsi_action);
+
+	if (rule_data->mcast_flow) {
+		bitmap_copy(vsi_bitmap, rule_data->mcc_group->vsi_bitmap,
+			    flow_mgt->vsi_max_per_switch);
+		vsi_num = rule_data->mcc_group->vsi_num;
+		clear_bit(vsi - rule_data->mcc_group->vsi_base, vsi_bitmap);
+		vsi_num--;
+		vsi_base = (u16)rule_data->mcc_group->vsi_base;
+
+		if (rule_data->mcc_group->vsi_num > 1)
+			add_flow = true;
+
+		if ((rule_data->multi && rule_data->mcc_group->vsi_num > 1) ||
+		    (!rule_data->multi && rule_data->mcc_group->vsi_num > 2))
+			need_mcast = 1;
+		pend_group = rule_data->mcc_group;
+	}
+
+	if (need_mcast) {
+		mcc_group = nbl_find_same_mcc_group(res, vsi_bitmap,
+						    rule_data->multi);
+		if (!mcc_group) {
+			mcc_group = nbl_flow_alloc_mcc_group(res_mgt,
+							     vsi_bitmap, eth_id,
+							     rule_data->multi,
+							     vsi_num);
+			if (!mcc_group)
+				goto alloc_mcc_group_failed;
+		}
+	}
+
+	for (i = 0; i < NBL_FLOW_MACVLAN_MAX; i++) {
+		if (i == NBL_FLOW_UP_TNL && rule_data->multi)
+			continue;
+
+		nbl_flow_del_flow(res_mgt, &rule_data->entry[i]);
+	}
+
+	if (pend_group)
+		nbl_flow_free_mcc_group(res_mgt, pend_group);
+
+	if (add_flow) {
+		param.mac = mac;
+		param.vid = vlan;
+		param.eth = eth_id;
+		param.mcc_id = NBL_MCC_ID_INVALID;
+		param.vsi = (u16)find_first_bit(vsi_bitmap,
+						flow_mgt->vsi_max_per_switch) +
+			    vsi_base;
+
+		for (i = 0; i < NBL_FLOW_MACVLAN_MAX; i++) {
+			if (i == NBL_FLOW_UP_TNL && rule_data->multi)
+				continue;
+			if (mcc_group) {
+				if (i <= NBL_FLOW_UP)
+					param.mcc_id = mcc_group->up_mcc_id;
+				else
+					param.mcc_id = mcc_group->down_mcc_id;
+			}
+			ret = nbl_flow_add_flow(res_mgt, param, i,
+						&rule_data->entry[i]);
+			if (ret)
+				goto add_flow_failed;
+		}
+
+		if (mcc_group) {
+			rule_data->mcast_flow = 1;
+			rule_data->mcc_group = mcc_group;
+		} else {
+			rule_data->mcast_flow = 0;
+			rule_data->vsi = param.vsi;
+		}
+	}
+
+	if (!add_flow)
+		nbl_common_free_hash_xy_node(res->mac_hash_tbl, mac, &vlan);
+
+alloc_mcc_group_failed:
+	kfree(vsi_bitmap);
+
+	nbl_common_scan_hash_xy_node(res->mac_hash_tbl, &scan_key);
+	if (vf_id != U32_MAX && test_bit(vf_id, res->vf_bitmap) && !vsi_match) {
+		clear_bit(vf_id, res->vf_bitmap);
+		res->active_vfs--;
+	}
+
+	return;
+
+add_flow_failed:
+	while (--i + 1) {
+		if (i == NBL_FLOW_UP_TNL && rule_data->multi)
+			continue;
+		nbl_flow_del_flow(res_mgt, &rule_data->entry[i]);
+	}
+	if (mcc_group)
+		nbl_flow_free_mcc_group(res_mgt, mcc_group);
+	nbl_common_free_hash_xy_node(res->mac_hash_tbl, mac, &vlan);
+	kfree(vsi_bitmap);
+	nbl_common_scan_hash_xy_node(res->mac_hash_tbl, &scan_key);
+	if (vf_id != U32_MAX && test_bit(vf_id, res->vf_bitmap) && !vsi_match) {
+		clear_bit(vf_id, res->vf_bitmap);
+		res->active_vfs--;
+	}
+}
+
+static int nbl_flow_add_lldp(void *priv, u16 vsi)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_flow_mgt *flow_mgt = NBL_RES_MGT_TO_FLOW_MGT(res_mgt);
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct nbl_flow_lldp_rule *rule;
+	struct nbl_flow_param param = { 0 };
+
+	list_for_each_entry(rule, &flow_mgt->lldp_list, node)
+		if (rule->vsi == vsi)
+			return 0;
+
+	rule = kzalloc(sizeof(*rule), GFP_KERNEL);
+	if (!rule)
+		return -ENOMEM;
+
+	param.eth = nbl_res_vsi_id_to_eth_id(res_mgt, vsi);
+	param.vsi = vsi;
+	param.ether_type = ETH_P_LLDP;
+
+	if (nbl_flow_add_flow(res_mgt, param, NBL_FLOW_LLDP_LACP_UP,
+			      &rule->entry)) {
+		nbl_err(common, "Fail to add lldp flow for vsi %d", vsi);
+		kfree(rule);
+		return -EFAULT;
+	}
+
+	rule->vsi = vsi;
+	list_add_tail(&rule->node, &flow_mgt->lldp_list);
+
+	return 0;
+}
+
+static void nbl_flow_del_lldp(void *priv, u16 vsi)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_flow_mgt *flow_mgt;
+	struct nbl_flow_lldp_rule *rule;
+
+	flow_mgt = NBL_RES_MGT_TO_FLOW_MGT(res_mgt);
+
+	list_for_each_entry(rule, &flow_mgt->lldp_list, node)
+		if (rule->vsi == vsi)
+			break;
+
+	if (list_entry_is_head(rule, &flow_mgt->lldp_list, node))
+		return;
+
+	nbl_flow_del_flow(res_mgt, &rule->entry);
+
+	list_del(&rule->node);
+	kfree(rule);
+}
+
+static int nbl_flow_change_mcc_group_chain(struct nbl_resource_mgt *res_mgt,
+					   u8 eth, u16 current_mcc_id)
+{
+	struct nbl_flow_mgt *flow_mgt = NBL_RES_MGT_TO_FLOW_MGT(res_mgt);
+	struct nbl_flow_switch_res *switch_res = &flow_mgt->switch_res[eth];
+	struct nbl_flow_mcc_group *group;
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	void *p = NBL_RES_MGT_TO_HW_PRIV(res_mgt);
+	u16 node_mcc;
+
+	list_for_each_entry(group, &switch_res->mcc_group_head, group_node)
+		if (group->multi && !list_empty(&group->mcc_node)) {
+			node_mcc = list_last_entry(&group->mcc_node,
+						   struct nbl_flow_mcc_node,
+						   node)
+					   ->mcc_id;
+			hw_ops->update_mcc_next_node(p, node_mcc,
+						     current_mcc_id);
+		}
+	switch_res->allmulti_first_mcc = current_mcc_id;
+	return 0;
+}
+
+static int nbl_flow_add_multi_mcast(void *priv, u16 vsi)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_flow_mgt *flow_mgt = NBL_RES_MGT_TO_FLOW_MGT(res_mgt);
+	struct nbl_flow_switch_res *switch_res;
+	struct nbl_flow_mcc_node *node;
+	int ret;
+	u16 current_mcc_id;
+	u8 eth = nbl_res_vsi_id_to_eth_id(res_mgt, vsi);
+
+	switch_res = &flow_mgt->switch_res[eth];
+	list_for_each_entry(node, &switch_res->allmulti_list, node)
+		if (node->data == vsi && node->type == NBL_MCC_INDEX_VSI)
+			return 0;
+
+	node = nbl_flow_alloc_mcc_node(flow_mgt, NBL_MCC_INDEX_VSI, vsi, 0);
+	if (!node)
+		return -ENOSPC;
+
+	switch_res = &flow_mgt->switch_res[eth];
+	ret = nbl_flow_add_mcc_node(res_mgt, node, &switch_res->allmulti_head,
+				    &switch_res->allmulti_list, NULL);
+	if (ret) {
+		nbl_flow_free_mcc_node(flow_mgt, node);
+		return ret;
+	}
+
+	if (list_empty(&switch_res->allmulti_list))
+		current_mcc_id = NBL_MCC_ID_INVALID;
+	else
+		current_mcc_id = list_first_entry(&switch_res->allmulti_list,
+						  struct nbl_flow_mcc_node,
+						  node)
+					 ->mcc_id;
+
+	if (current_mcc_id != switch_res->allmulti_first_mcc)
+		nbl_flow_change_mcc_group_chain(res_mgt, eth, current_mcc_id);
+
+	return 0;
+}
+
+static void nbl_flow_del_multi_mcast(void *priv, u16 vsi)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_flow_mgt *flow_mgt = NBL_RES_MGT_TO_FLOW_MGT(res_mgt);
+	struct nbl_flow_switch_res *switch_res;
+	struct nbl_flow_mcc_node *mcc_node;
+	u16 current_mcc_id;
+	u8 eth = nbl_res_vsi_id_to_eth_id(res_mgt, vsi);
+
+	switch_res = &flow_mgt->switch_res[eth];
+	list_for_each_entry(mcc_node, &switch_res->allmulti_list, node)
+		if (mcc_node->data == vsi &&
+		    mcc_node->type == NBL_MCC_INDEX_VSI) {
+			nbl_flow_del_mcc_node(res_mgt, mcc_node,
+					      &switch_res->allmulti_head,
+					      &switch_res->allmulti_list, NULL);
+			nbl_flow_free_mcc_node(flow_mgt, mcc_node);
+			break;
+		}
+
+	if (list_empty(&switch_res->allmulti_list))
+		current_mcc_id = NBL_MCC_ID_INVALID;
+	else
+		current_mcc_id = list_first_entry(&switch_res->allmulti_list,
+						  struct nbl_flow_mcc_node,
+						  node)
+					 ->mcc_id;
+
+	if (current_mcc_id != switch_res->allmulti_first_mcc)
+		nbl_flow_change_mcc_group_chain(res_mgt, eth, current_mcc_id);
+}
+
+static int nbl_flow_add_multi_group(struct nbl_resource_mgt *res_mgt, u8 eth)
+{
+	struct nbl_flow_mgt *flow_mgt = NBL_RES_MGT_TO_FLOW_MGT(res_mgt);
+	struct nbl_flow_switch_res *switch_res = &flow_mgt->switch_res[eth];
+	struct nbl_flow_param param_up = {0};
+	struct nbl_flow_mcc_node *up_node;
+	struct nbl_flow_param param_down = {0};
+	struct nbl_flow_mcc_node *down_node;
+	int i, ret;
+
+	down_node =
+		nbl_flow_alloc_mcc_node(flow_mgt, NBL_MCC_INDEX_ETH, eth, 1);
+	if (!down_node)
+		return -ENOSPC;
+
+	ret = nbl_flow_add_mcc_node(res_mgt, down_node,
+				    &switch_res->allmulti_head,
+				    &switch_res->allmulti_list, NULL);
+	if (ret)
+		goto add_eth_mcc_node_failed;
+
+	param_down.mcc_id = down_node->mcc_id;
+	param_down.eth = eth;
+	for (i = 0;
+	     i < NBL_FLOW_DOWN_MULTI_MCAST_END - NBL_FLOW_L2_DOWN_MULTI_MCAST;
+	     i++) {
+		ret = nbl_flow_add_flow(res_mgt, param_down,
+					i + NBL_FLOW_L2_DOWN_MULTI_MCAST,
+					&switch_res->allmulti_down[i]);
+		if (ret)
+			goto add_down_flow_failed;
+	}
+
+	up_node = nbl_flow_alloc_mcc_node(flow_mgt, NBL_MCC_INDEX_BMC,
+					  NBL_FLOW_MCC_BMC_DPORT, 1);
+	if (!up_node) {
+		ret = -ENOSPC;
+		goto alloc_bmc_node_failed;
+	}
+
+	ret = nbl_flow_add_mcc_node(res_mgt, up_node,
+				    &switch_res->allmulti_head,
+				    &switch_res->allmulti_list, NULL);
+	if (ret)
+		goto add_bmc_mcc_node_failed;
+
+	param_up.mcc_id = up_node->mcc_id;
+	param_up.eth = eth;
+	for (i = 0;
+	     i < NBL_FLOW_UP_MULTI_MCAST_END - NBL_FLOW_L2_UP_MULTI_MCAST;
+	     i++) {
+		ret = nbl_flow_add_flow(res_mgt, param_up,
+					i + NBL_FLOW_L2_UP_MULTI_MCAST,
+					&switch_res->allmulti_up[i]);
+		if (ret)
+			goto add_up_flow_failed;
+	}
+
+	switch_res->ether_id = eth;
+	switch_res->allmulti_first_mcc = NBL_MCC_ID_INVALID;
+	switch_res->vld = 1;
+
+	return 0;
+
+add_up_flow_failed:
+	while (--i >= 0)
+		nbl_flow_del_flow(res_mgt, &switch_res->allmulti_up[i]);
+	nbl_flow_del_mcc_node(res_mgt, up_node, &switch_res->allmulti_head,
+			      &switch_res->allmulti_list, NULL);
+add_bmc_mcc_node_failed:
+	nbl_flow_free_mcc_node(flow_mgt, up_node);
+alloc_bmc_node_failed:
+add_down_flow_failed:
+	while (--i >= 0)
+		nbl_flow_del_flow(res_mgt, &switch_res->allmulti_down[i]);
+	nbl_flow_del_mcc_node(res_mgt, down_node, &switch_res->allmulti_head,
+			      &switch_res->allmulti_list, NULL);
+add_eth_mcc_node_failed:
+	nbl_flow_free_mcc_node(flow_mgt, down_node);
+	return ret;
+}
+
+static void nbl_flow_del_multi_group(struct nbl_resource_mgt *res_mgt, u8 eth)
+{
+	struct nbl_flow_mgt *flow_mgt = NBL_RES_MGT_TO_FLOW_MGT(res_mgt);
+	struct nbl_flow_switch_res *switch_res = &flow_mgt->switch_res[eth];
+	struct nbl_flow_mcc_node *mcc_node, *mcc_node_safe;
+
+	if (!switch_res->vld)
+		return;
+
+	nbl_flow_del_flow(res_mgt, &switch_res->allmulti_up[0]);
+	nbl_flow_del_flow(res_mgt, &switch_res->allmulti_up[1]);
+	nbl_flow_del_flow(res_mgt, &switch_res->allmulti_down[0]);
+	nbl_flow_del_flow(res_mgt, &switch_res->allmulti_down[1]);
+
+	list_for_each_entry_safe(mcc_node, mcc_node_safe,
+				 &switch_res->allmulti_list, node) {
+		nbl_flow_del_mcc_node(res_mgt, mcc_node,
+				      &switch_res->allmulti_head,
+				      &switch_res->allmulti_list, NULL);
+		nbl_flow_free_mcc_node(flow_mgt, mcc_node);
+	}
+
+	list_for_each_entry_safe(mcc_node, mcc_node_safe,
+				 &switch_res->allmulti_head, node) {
+		nbl_flow_del_mcc_node(res_mgt, mcc_node,
+				      &switch_res->allmulti_head,
+				      &switch_res->allmulti_list, NULL);
+		nbl_flow_free_mcc_node(flow_mgt, mcc_node);
+	}
+
+	INIT_LIST_HEAD(&switch_res->allmulti_list);
+	INIT_LIST_HEAD(&switch_res->allmulti_head);
+	switch_res->vld = 0;
+	switch_res->allmulti_first_mcc = NBL_MCC_ID_INVALID;
+}
+
+static void nbl_flow_remove_multi_group(void *priv)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	int i;
+
+	for_each_set_bit(i, eth_info->eth_bitmap, NBL_MAX_ETHERNET)
+		nbl_flow_del_multi_group(res_mgt, i);
+}
+
+static int nbl_flow_setup_multi_group(void *priv)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	int i, ret = 0;
+
+	for_each_set_bit(i, eth_info->eth_bitmap, NBL_MAX_ETHERNET) {
+		ret = nbl_flow_add_multi_group(res_mgt, i);
+		if (ret)
+			goto fail;
+	}
+
+	return 0;
+
+fail:
+	nbl_flow_remove_multi_group(res_mgt);
+	return ret;
+}
+
+static u16 nbl_vsi_mtu_index(struct nbl_resource_mgt *res_mgt, u16 vsi_id)
+{
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	u16 index;
+
+	index = hw_ops->get_mtu_index(NBL_RES_MGT_TO_HW_PRIV(res_mgt), vsi_id);
+	return index - 1;
+}
+
+static void nbl_clear_mtu_entry(struct nbl_resource_mgt *res_mgt, u16 vsi_id)
+{
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	u16 mtu_index;
+
+	mtu_index = nbl_vsi_mtu_index(res_mgt, vsi_id);
+	if (mtu_index < NBL_MAX_MTU_NUM) {
+		res_mgt->resource_info->mtu_list[mtu_index].ref_count--;
+		hw_ops->set_vsi_mtu(NBL_RES_MGT_TO_HW_PRIV(res_mgt), vsi_id, 0);
+		if (res_mgt->resource_info->mtu_list[mtu_index].ref_count ==
+		    0) {
+			hw_ops->set_mtu(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+					mtu_index + 1, 0);
+			res_mgt->resource_info->mtu_list[mtu_index].mtu_value =
+				0;
+		}
+	}
+}
+
+static void nbl_flow_clear_flow(void *priv, u16 vsi_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_flow_mgt *flow_mgt = NBL_RES_MGT_TO_FLOW_MGT(res_mgt);
+	void *mac_hash_tbl;
+	struct nbl_hash_xy_tbl_scan_key scan_key;
+	u8 eth_id;
+
+	eth_id = nbl_res_vsi_id_to_eth_id(res_mgt, vsi_id);
+	mac_hash_tbl = flow_mgt->switch_res[eth_id].mac_hash_tbl;
+
+	nbl_clear_mtu_entry(res_mgt, vsi_id);
+	NBL_HASH_XY_TBL_SCAN_KEY_INIT(&scan_key, NBL_HASH_TBL_OP_DELETE,
+				      NBL_HASH_TBL_ALL_SCAN, false, NULL, NULL,
+				      &vsi_id,
+				      &nbl_flow_macvlan_node_vsi_match_func,
+				      res_mgt,
+				      &nbl_flow_macvlan_node_del_action_func);
+	nbl_common_scan_hash_xy_node(mac_hash_tbl, &scan_key);
+	nbl_flow_del_multi_mcast(res_mgt, vsi_id);
+}
+
+static void nbl_res_flr_clear_flow(void *priv, u16 vf_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	u16 func_id = vf_id + NBL_MAX_PF;
+	u16 vsi_id = nbl_res_func_id_to_vsi_id(res_mgt, func_id,
+					       NBL_VSI_SERV_VF_DATA_TYPE);
+
+	if (nbl_res_vf_is_active(priv, func_id))
+		nbl_flow_clear_flow(priv, vsi_id);
+}
+
+static int nbl_res_flow_check_flow_table_spec(void *priv, u16 vlan_cnt,
+					      u16 unicast_cnt,
+					      u16 multicast_cnt)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_flow_mgt *flow_mgt = NBL_RES_MGT_TO_FLOW_MGT(res_mgt);
+	u32 reserve_cnt = nbl_flow_get_reserve_macvlan_cnt(res_mgt);
+	u32 need = vlan_cnt * (3 * unicast_cnt + 2 * multicast_cnt);
+
+	if (reserve_cnt + need > flow_mgt->flow_id_cnt)
+		return -ENOSPC;
+
+	return 0;
+}
+
+static int nbl_res_set_mtu(void *priv, u16 vsi_id, u16 mtu)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	struct nbl_mtu_entry *mtu_list = &res_mgt->resource_info->mtu_list[0];
+	int i, found_idx = -1, first_zero_idx = -1;
+	u16 real_mtu = mtu + ETH_HLEN + 2 * VLAN_HLEN;
+
+	nbl_clear_mtu_entry(res_mgt, vsi_id);
+	if (mtu == 0)
+		return 0;
+
+	for (i = 0; i < NBL_MAX_MTU_NUM; i++) {
+		if (mtu_list[i].mtu_value == real_mtu) {
+			found_idx = i;
+			break;
+		}
+
+		if (!mtu_list[i].mtu_value)
+			first_zero_idx = i;
+	}
+
+	if (first_zero_idx == -1 && found_idx == -1)
+		return 0;
+
+	if (found_idx != -1) {
+		mtu_list[found_idx].ref_count++;
+		hw_ops->set_vsi_mtu(NBL_RES_MGT_TO_HW_PRIV(res_mgt), vsi_id,
+				    found_idx + 1);
+		return 0;
+	}
+
+	if (first_zero_idx != -1) {
+		mtu_list[first_zero_idx].ref_count++;
+		mtu_list[first_zero_idx].mtu_value = real_mtu;
+		hw_ops->set_vsi_mtu(NBL_RES_MGT_TO_HW_PRIV(res_mgt), vsi_id,
+				    first_zero_idx + 1);
+		hw_ops->set_mtu(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+				first_zero_idx + 1, real_mtu);
+	}
+
+	return 0;
+}
+
+/* NBL_FLOW_SET_OPS(ops_name, func)
+ *
+ * Use X Macros to reduce setup and remove codes.
+ */
+#define NBL_FLOW_OPS_TBL						\
+do {									\
+	NBL_FLOW_SET_OPS(add_macvlan, nbl_flow_add_macvlan);		\
+	NBL_FLOW_SET_OPS(del_macvlan, nbl_flow_del_macvlan);		\
+	NBL_FLOW_SET_OPS(add_lldp_flow, nbl_flow_add_lldp);		\
+	NBL_FLOW_SET_OPS(del_lldp_flow, nbl_flow_del_lldp);		\
+	NBL_FLOW_SET_OPS(add_multi_mcast, nbl_flow_add_multi_mcast);	\
+	NBL_FLOW_SET_OPS(del_multi_mcast, nbl_flow_del_multi_mcast);	\
+	NBL_FLOW_SET_OPS(setup_multi_group, nbl_flow_setup_multi_group); \
+	NBL_FLOW_SET_OPS(remove_multi_group, nbl_flow_remove_multi_group); \
+	NBL_FLOW_SET_OPS(clear_flow, nbl_flow_clear_flow);		\
+	NBL_FLOW_SET_OPS(flr_clear_flows, nbl_res_flr_clear_flow);	\
+	NBL_FLOW_SET_OPS(set_mtu, nbl_res_set_mtu);			\
+	NBL_FLOW_SET_OPS(check_flow_table_spec,				\
+			 nbl_res_flow_check_flow_table_spec);		\
+} while (0)
+
+static void nbl_flow_remove_mgt(struct device *dev,
+				struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_flow_mgt *fl_mgt = NBL_RES_MGT_TO_FLOW_MGT(res_mgt);
+	int i;
+	struct nbl_hash_xy_tbl_del_key del_key;
+
+	NBL_HASH_XY_TBL_DEL_KEY_INIT(&del_key, res_mgt,
+				     &nbl_flow_macvlan_node_del_action_func);
+	for (i = 0; i < NBL_MAX_ETHERNET; i++) {
+		nbl_common_rm_hash_xy_table(fl_mgt->switch_res[i].mac_hash_tbl,
+					    &del_key);
+		if (fl_mgt->switch_res[i].vf_bitmap)
+			devm_kfree(dev, fl_mgt->switch_res[i].vf_bitmap);
+	}
+
+	if (fl_mgt->flow_id_bitmap)
+		devm_kfree(dev, fl_mgt->flow_id_bitmap);
+	if (fl_mgt->mcc_id_bitmap)
+		devm_kfree(dev, fl_mgt->mcc_id_bitmap);
+	fl_mgt->flow_id_cnt = 0;
+	devm_kfree(dev, fl_mgt);
+	NBL_RES_MGT_TO_FLOW_MGT(res_mgt) = NULL;
+}
+
+static int nbl_flow_setup_mgt(struct device *dev,
+			      struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_hash_xy_tbl_key macvlan_tbl_key;
+	struct nbl_flow_mgt *flow_mgt;
+	struct nbl_eth_info *eth_info;
+	int i;
+	int vf_num = -1;
+	u16 pf_id;
+
+	flow_mgt = devm_kzalloc(dev, sizeof(struct nbl_flow_mgt), GFP_KERNEL);
+	if (!flow_mgt)
+		return -ENOMEM;
+
+	NBL_RES_MGT_TO_FLOW_MGT(res_mgt) = flow_mgt;
+	eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+
+	flow_mgt->flow_id_bitmap =
+		devm_kcalloc(dev, BITS_TO_LONGS(NBL_MACVLAN_TABLE_LEN),
+			     sizeof(long), GFP_KERNEL);
+	if (!flow_mgt->flow_id_bitmap)
+		goto setup_mgt_failed;
+	flow_mgt->flow_id_cnt = NBL_MACVLAN_TABLE_LEN;
+
+	flow_mgt->mcc_id_bitmap =
+		devm_kcalloc(dev, BITS_TO_LONGS(NBL_FLOW_MCC_INDEX_SIZE),
+			     sizeof(long), GFP_KERNEL);
+	if (!flow_mgt->mcc_id_bitmap)
+		goto setup_mgt_failed;
+
+	NBL_HASH_XY_TBL_KEY_INIT(&macvlan_tbl_key, dev, ETH_ALEN, sizeof(u16),
+				 sizeof(struct nbl_flow_l2_data),
+				 NBL_MACVLAN_TBL_BUCKET_SIZE,
+				 NBL_MACVLAN_X_AXIS_BUCKET_SIZE,
+				 NBL_MACVLAN_Y_AXIS_BUCKET_SIZE, false);
+	for (i = 0; i < NBL_MAX_ETHERNET; i++) {
+		INIT_LIST_HEAD(&flow_mgt->switch_res[i].allmulti_head);
+		INIT_LIST_HEAD(&flow_mgt->switch_res[i].allmulti_list);
+		INIT_LIST_HEAD(&flow_mgt->switch_res[i].mcc_group_head);
+
+		flow_mgt->switch_res[i].mac_hash_tbl =
+			nbl_common_init_hash_xy_table(&macvlan_tbl_key);
+		if (!flow_mgt->switch_res[i].mac_hash_tbl)
+			goto setup_mgt_failed;
+		pf_id = find_first_bit((unsigned long *)&eth_info->pf_bitmap[i],
+				       8);
+		if (pf_id != 8)
+			vf_num = nbl_res_get_pf_vf_num(res_mgt, pf_id);
+
+		if (vf_num != -1) {
+			flow_mgt->switch_res[i].num_vfs = vf_num;
+			flow_mgt->switch_res[i].vf_bitmap =
+				devm_kcalloc(dev, BITS_TO_LONGS(vf_num),
+					     sizeof(long), GFP_KERNEL);
+			if (!flow_mgt->switch_res[i].vf_bitmap)
+				goto setup_mgt_failed;
+		} else {
+			flow_mgt->switch_res[i].num_vfs = 0;
+			flow_mgt->switch_res[i].vf_bitmap = NULL;
+		}
+		flow_mgt->switch_res[i].active_vfs = 0;
+	}
+
+	INIT_LIST_HEAD(&flow_mgt->lldp_list);
+	INIT_LIST_HEAD(&flow_mgt->lacp_list);
+	INIT_LIST_HEAD(&flow_mgt->ul4s_head);
+	INIT_LIST_HEAD(&flow_mgt->dprbac_head);
+
+	flow_mgt->vsi_max_per_switch = NBL_VSI_MAX_ID / eth_info->eth_num;
+
+	return 0;
+
+setup_mgt_failed:
+	nbl_flow_remove_mgt(dev, res_mgt);
+	return -1;
+}
+
+int nbl_flow_mgt_start_leonis(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_hw_ops *hw_ops;
+	struct device *dev;
+	int ret = 0;
+
+	dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+
+	ret = nbl_flow_setup_mgt(dev, res_mgt);
+	if (ret)
+		goto setup_mgt_fail;
+
+	ret = hw_ops->init_fem(NBL_RES_MGT_TO_HW_PRIV(res_mgt));
+	if (ret)
+		goto init_fem_fail;
+
+	return 0;
+
+init_fem_fail:
+	nbl_flow_remove_mgt(dev, res_mgt);
+setup_mgt_fail:
+	return -1;
+}
+
+void nbl_flow_mgt_stop_leonis(struct nbl_resource_mgt *res_mgt)
+{
+	struct device *dev;
+	struct nbl_flow_mgt *flow_mgt;
+
+	dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	flow_mgt = NBL_RES_MGT_TO_FLOW_MGT(res_mgt);
+	if (!flow_mgt)
+		return;
+
+	nbl_flow_remove_mgt(dev, res_mgt);
+}
+
+int nbl_flow_setup_ops_leonis(struct nbl_resource_ops *res_ops)
+{
+#define NBL_FLOW_SET_OPS(name, func)		\
+	do {					\
+		res_ops->NBL_NAME(name) = func; \
+		;				\
+	} while (0)
+	NBL_FLOW_OPS_TBL;
+#undef  NBL_FLOW_SET_OPS
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_flow_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_flow_leonis.h
new file mode 100644
index 000000000000..b513eb2afd87
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_flow_leonis.h
@@ -0,0 +1,204 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+#ifndef _NBL_FLOW_LEONIS_H_
+#define _NBL_FLOW_LEONIS_H_
+
+#include "nbl_core.h"
+#include "nbl_hw.h"
+#include "nbl_resource.h"
+
+#define NBL_EM_HW_KT_OFFSET				(0x1E000)
+
+#define NBL_TOTAL_MACVLAN_NUM				4096
+#define NBL_MAX_ACTION_NUM				16
+
+#define NBL_FLOW_MCC_PXE_SIZE				8
+#define NBL_FLOW_MCC_INDEX_SIZE (4096 - NBL_FLOW_MCC_PXE_SIZE)
+#define NBL_FLOW_MCC_INDEX_START			(4 * 1024)
+#define NBL_FLOW_MCC_BMC_DPORT				0x30D
+
+#define NBL_MACVLAN_TBL_BUCKET_SIZE			64
+#define NBL_MACVLAN_X_AXIS_BUCKET_SIZE			64
+#define NBL_MACVLAN_Y_AXIS_BUCKET_SIZE			16
+
+#define NBL_PP0_POWER					11
+
+enum nbl_flow_mcc_index_type {
+	NBL_MCC_INDEX_ETH,
+	NBL_MCC_INDEX_VSI,
+	NBL_MCC_INDEX_BOND,
+	NBL_MCC_INDEX_BMC,
+};
+
+#pragma pack(1)
+
+#define NBL_DUPPKT_PTYPE_NA				135
+#define NBL_DUPPKT_PTYPE_NS				136
+
+struct nbl_flow_l2_data {
+	struct nbl_flow_fem_entry entry[NBL_FLOW_MACVLAN_MAX];
+	union {
+		struct nbl_flow_mcc_group *mcc_group;
+		u16 vsi;
+	};
+	bool multi;
+	bool mcast_flow;
+};
+
+union nbl_l2_hw_up_data_u {
+	struct nbl_l2_hw_up_data {
+		u32 act0:22;
+		u32 act1:22;
+		u64 rsv1:40;
+		u32 padding:4;
+		u32 sport:4;
+		u32 svlan_id:16;
+		u64 dst_mac:48;
+		u32 template:4;
+		u32 rsv[5];
+	} __packed info;
+#define NBL_L2_HW_UP_DATA_TAB_WIDTH \
+	(sizeof(struct nbl_l2_hw_up_data) / sizeof(u32))
+	u32 data[NBL_L2_HW_UP_DATA_TAB_WIDTH];
+	u8 hash_key[sizeof(struct nbl_l2_hw_up_data)];
+};
+
+union nbl_l2_hw_lldp_lacp_data_u {
+	struct nbl_l2_hw_lldp_lacp_data {
+		u32 act0:22;
+		u32 rsv1:2;
+		u8 padding[14];
+		u32 sport:4;
+		u32 ether_type:16;
+		u32 template:4;
+		u32 rsv[5];
+	} __packed info;
+#define NBL_L2_HW_LLDP_LACP_DATA_TAB_WIDTH \
+	(sizeof(struct nbl_l2_hw_lldp_lacp_data) / sizeof(u32))
+	u32 data[NBL_L2_HW_LLDP_LACP_DATA_TAB_WIDTH];
+	u8 hash_key[sizeof(struct nbl_l2_hw_lldp_lacp_data)];
+};
+
+union nbl_l2_hw_up_multi_mcast_data_u {
+	struct nbl_l2_hw_up_multi_mcast_data {
+		u32 act0:22;
+		u32 rsv1:2;
+		u8 padding[16];
+		u32 sport:4;
+		u32 template:4;
+		u32 rsv[5];
+	} __packed info;
+#define NBL_L2_HW_UP_MULTI_MCAST_DATA_TAB_WIDTH \
+	(sizeof(struct nbl_l2_hw_up_multi_mcast_data) / sizeof(u32))
+	u32 data[NBL_L2_HW_UP_MULTI_MCAST_DATA_TAB_WIDTH];
+	u8 hash_key[sizeof(struct nbl_l2_hw_up_multi_mcast_data)];
+};
+
+union nbl_l2_hw_down_multi_mcast_data_u {
+	struct nbl_l2_hw_down_multi_mcast_data {
+		u32 act0:22;
+		u32 rsv1:2;
+		u8 rsv2[16];
+		u32 padding:2;
+		u32 sport:2;
+		u32 template:4;
+		u32 rsv[5];
+	} __packed info;
+#define NBL_L2_HW_DOWN_MULTI_MCAST_DATA_TAB_WIDTH \
+		(sizeof(struct nbl_l2_hw_down_multi_mcast_data) / sizeof(u32))
+	u32 data[NBL_L2_HW_DOWN_MULTI_MCAST_DATA_TAB_WIDTH];
+	u8 hash_key[sizeof(struct nbl_l2_hw_down_multi_mcast_data)];
+};
+
+union nbl_l2_hw_down_data_u {
+	struct nbl_l2_hw_down_data {
+		u32 act0:22;
+		u32 act1:22;
+		u64 rsv2:40;
+		u32 padding:6;
+		u32 sport:2;
+		u32 svlan_id:16;
+		u64 dst_mac:48;
+		u32 template:4;
+		u32 rsv[5];
+	} __packed info;
+#define NBL_L2_HW_DOWN_DATA_TAB_WIDTH \
+	(sizeof(struct nbl_l2_hw_down_data) / sizeof(u32))
+	u32 data[NBL_L2_HW_DOWN_DATA_TAB_WIDTH];
+	u8 hash_key[sizeof(struct nbl_l2_hw_down_data)];
+};
+
+union nbl_common_data_u {
+	struct nbl_common_data {
+		u32 rsv[10];
+	} __packed info;
+#define NBL_COMMON_DATA_TAB_WIDTH (sizeof(struct nbl_common_data) / sizeof(u32))
+	u32 data[NBL_COMMON_DATA_TAB_WIDTH];
+	u8 hash_key[sizeof(struct nbl_common_data)];
+};
+
+#pragma pack()
+
+struct nbl_flow_param {
+	u8 *mac;
+	u8 type;
+	u8 eth;
+	u16 ether_type;
+	u16 vid;
+	u16 vsi;
+	u16 mcc_id;
+	u32 index;
+	u32 *data;
+	u32 priv_data;
+	bool for_pmd;
+};
+
+struct nbl_mt_input {
+	u8 key[NBL_KT_BYTE_LEN];
+	u8 at_num;
+	u8 kt_left_num;
+	u32 tbl_id;
+	u16 depth;
+	u16 power;
+};
+
+struct nbl_ht_item {
+	u16 ht0_hash;
+	u16 ht1_hash;
+	u16 hash_bucket;
+	u32 key_index;
+	u8 ht_table;
+};
+
+struct nbl_kt_item {
+	union nbl_common_data_u kt_data;
+};
+
+struct nbl_tcam_item {
+	struct nbl_ht_item ht_item;
+	struct nbl_kt_item kt_item;
+	u32 tcam_action[NBL_MAX_ACTION_NUM];
+	bool tcam_flag;
+	u8 key_mode;
+	u8 pp_type;
+	u32 *pp_tcam_count;
+	u16 tcam_index;
+};
+
+struct nbl_tcam_ad_item {
+	u32 action[NBL_MAX_ACTION_NUM];
+};
+
+struct nbl_flow_rule_cfg_ops {
+	int (*cfg_action)(struct nbl_flow_param param, u32 *action0,
+			  u32 *action1);
+	int (*cfg_key)(union nbl_common_data_u *data,
+		       struct nbl_flow_param param, u8 eth_mode);
+	void (*cfg_kt_action)(union nbl_common_data_u *data, u32 action0,
+			      u32 action1);
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
index 4ee35f46c785..0b15d6365513 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -25,6 +25,467 @@ static u32 nbl_hw_get_quirks(void *priv)
 	return quirks;
 }
 
+static int nbl_send_kt_data(struct nbl_hw_mgt *hw_mgt,
+			    union nbl_fem_kt_acc_ctrl_u *kt_ctrl, u8 *data,
+			    struct nbl_common_info *common)
+{
+	union nbl_fem_kt_acc_ack_u kt_ack = { .info = { 0 } };
+	u32 times = 3;
+
+	nbl_hw_wr_regs(hw_mgt, NBL_FEM_KT_ACC_DATA, data, NBL_KT_HW_L2_DW_LEN);
+	nbl_debug(common, "Set kt = %08x-%08x-%08x-%08x-%08x", ((u32 *)data)[0],
+		  ((u32 *)data)[1], ((u32 *)data)[2], ((u32 *)data)[3],
+		  ((u32 *)data)[4]);
+
+	kt_ctrl->info.rw = NBL_ACC_MODE_WRITE;
+	nbl_hw_wr_regs(hw_mgt, NBL_FEM_KT_ACC_CTRL, kt_ctrl->data,
+		       NBL_FEM_KT_ACC_CTRL_TBL_WIDTH);
+
+	times = 3;
+	do {
+		nbl_hw_rd_regs(hw_mgt, NBL_FEM_KT_ACC_ACK, kt_ack.data,
+			       NBL_FEM_KT_ACC_ACK_TBL_WIDTH);
+		if (!kt_ack.info.done) {
+			times--;
+			usleep_range(100, 200);
+		} else {
+			break;
+		}
+	} while (times);
+
+	if (!times) {
+		nbl_err(common, "Config kt flowtale failed");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int nbl_send_ht_data(struct nbl_hw_mgt *hw_mgt,
+			    union nbl_fem_ht_acc_ctrl_u *ht_ctrl, u8 *data,
+			    struct nbl_common_info *common)
+{
+	union nbl_fem_ht_acc_ack_u ht_ack = { .info = { 0 } };
+	u32 times = 3;
+
+	nbl_hw_wr_regs(hw_mgt, NBL_FEM_HT_ACC_DATA, data,
+		       NBL_FEM_HT_ACC_DATA_TBL_WIDTH);
+	nbl_debug(common, "Set ht data = %x", *(u32 *)data);
+
+	ht_ctrl->info.rw = NBL_ACC_MODE_WRITE;
+	nbl_hw_wr_regs(hw_mgt, NBL_FEM_HT_ACC_CTRL, ht_ctrl->data,
+		       NBL_FEM_HT_ACC_CTRL_TBL_WIDTH);
+
+	times = 3;
+	do {
+		nbl_hw_rd_regs(hw_mgt, NBL_FEM_HT_ACC_ACK, ht_ack.data,
+			       NBL_FEM_HT_ACC_ACK_TBL_WIDTH);
+		if (!ht_ack.info.done) {
+			times--;
+			usleep_range(100, 200);
+		} else {
+			break;
+		}
+	} while (times);
+
+	if (!times) {
+		nbl_err(common, "Config ht flowtale failed");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static void nbl_check_kt_data(struct nbl_hw_mgt *hw_mgt,
+			      union nbl_fem_kt_acc_ctrl_u *kt_ctrl,
+			      struct nbl_common_info *common)
+{
+	union nbl_fem_kt_acc_ack_u ack = { .info = { 0 } };
+	u32 data[10] = { 0 };
+
+	kt_ctrl->info.rw = NBL_ACC_MODE_READ;
+	kt_ctrl->info.access_size = NBL_ACC_SIZE_320B;
+
+	nbl_hw_wr_regs(hw_mgt, NBL_FEM_KT_ACC_CTRL, kt_ctrl->data,
+		       NBL_FEM_KT_ACC_CTRL_TBL_WIDTH);
+
+	nbl_hw_rd_regs(hw_mgt, NBL_FEM_KT_ACC_ACK, ack.data,
+		       NBL_FEM_KT_ACC_ACK_TBL_WIDTH);
+	nbl_debug(common, "Check kt done:%u status:%u.", ack.info.done,
+		  ack.info.status);
+	if (ack.info.done) {
+		nbl_hw_rd_regs(hw_mgt, NBL_FEM_KT_ACC_DATA, (u8 *)data,
+			       NBL_KT_HW_L2_DW_LEN);
+		nbl_debug(common,
+			  "Check kt data:0x%x-%x-%x-%x-%x-%x-%x-%x-%x-%x.",
+			  data[9], data[8], data[7], data[6], data[5], data[4],
+			  data[3], data[2], data[1], data[0]);
+	}
+}
+
+static void nbl_check_ht_data(struct nbl_hw_mgt *hw_mgt,
+			      union nbl_fem_ht_acc_ctrl_u *ht_ctrl,
+			      struct nbl_common_info *common)
+{
+	union nbl_fem_ht_acc_ack_u ack = { .info = { 0 } };
+	u32 data[4] = { 0 };
+
+	ht_ctrl->info.rw = NBL_ACC_MODE_READ;
+	ht_ctrl->info.access_size = NBL_ACC_SIZE_128B;
+
+	nbl_hw_wr_regs(hw_mgt, NBL_FEM_HT_ACC_CTRL, ht_ctrl->data,
+		       NBL_FEM_HT_ACC_CTRL_TBL_WIDTH);
+
+	nbl_hw_rd_regs(hw_mgt, NBL_FEM_HT_ACC_ACK, ack.data,
+		       NBL_FEM_HT_ACC_ACK_TBL_WIDTH);
+	nbl_debug(common, "Check ht done:%u status:%u.", ack.info.done,
+		  ack.info.status);
+	if (ack.info.done) {
+		nbl_hw_rd_regs(hw_mgt, NBL_FEM_HT_ACC_DATA, (u8 *)data,
+			       NBL_FEM_HT_ACC_DATA_TBL_WIDTH);
+		nbl_debug(common, "Check ht data:0x%x-%x-%x-%x.", data[0],
+			  data[1], data[2], data[3]);
+	}
+}
+
+static void nbl_hw_fem_set_bank(struct nbl_hw_mgt *hw_mgt)
+{
+	u32 bank_sel = 0;
+
+	/* HT bank sel */
+	bank_sel = HT_PORT0_BANK_SEL | HT_PORT1_BANK_SEL << NBL_8BIT |
+		   HT_PORT2_BANK_SEL << NBL_16BIT;
+	nbl_hw_wr_regs(hw_mgt, NBL_FEM_HT_BANK_SEL_BITMAP, (u8 *)&bank_sel,
+		       sizeof(bank_sel));
+
+	/* KT bank sel */
+	bank_sel = KT_PORT0_BANK_SEL | KT_PORT1_BANK_SEL << NBL_8BIT |
+		   KT_PORT2_BANK_SEL << NBL_16BIT;
+	nbl_hw_wr_regs(hw_mgt, NBL_FEM_KT_BANK_SEL_BITMAP, (u8 *)&bank_sel,
+		       sizeof(bank_sel));
+
+	/* AT bank sel */
+	bank_sel = AT_PORT0_BANK_SEL | AT_PORT1_BANK_SEL << NBL_16BIT;
+	nbl_hw_wr_regs(hw_mgt, NBL_FEM_AT_BANK_SEL_BITMAP, (u8 *)&bank_sel,
+		       sizeof(bank_sel));
+	bank_sel = AT_PORT2_BANK_SEL;
+	nbl_hw_wr_regs(hw_mgt, NBL_FEM_AT_BANK_SEL_BITMAP2, (u8 *)&bank_sel,
+		       sizeof(bank_sel));
+}
+
+static void nbl_hw_fem_clear_tcam_ad(struct nbl_hw_mgt *hw_mgt)
+{
+	union fem_em_ad_table_u ad_table = { .info = { 0 } };
+	union fem_em_tcam_table_u tcam_table;
+	int i, j;
+
+	memset(&tcam_table, 0, sizeof(tcam_table));
+
+	for (i = 0; i < NBL_PT_LEN; i++) {
+		for (j = 0; j < NBL_TCAM_TABLE_LEN; j++) {
+			nbl_hw_wr_regs(hw_mgt, NBL_FEM_EM_TCAM_TABLE_REG(i, j),
+				       tcam_table.hash_key, sizeof(tcam_table));
+			nbl_hw_wr_regs(hw_mgt, NBL_FEM_EM_AD_TABLE_REG(i, j),
+				       ad_table.hash_key, sizeof(ad_table));
+			nbl_hw_rd32(hw_mgt, NBL_FEM_EM_TCAM_TABLE_REG(i, 1));
+		}
+	}
+}
+
+static int nbl_hw_set_ht(void *priv, u16 hash, u16 hash_other, u8 ht_table,
+			 u8 bucket, u32 key_index, u8 valid)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	union nbl_fem_ht_acc_data_u ht = { .info = { 0 } };
+	union nbl_fem_ht_acc_ctrl_u ht_ctrl = { .info = { 0 } };
+	struct nbl_common_info *common;
+
+	common = NBL_HW_MGT_TO_COMMON(hw_mgt);
+
+	ht.info.vld = valid;
+	ht.info.hash = hash_other;
+	ht.info.kt_index = key_index;
+
+	ht_ctrl.info.ht_id = ht_table == NBL_HT0 ? NBL_ACC_HT0 : NBL_ACC_HT1;
+	ht_ctrl.info.entry_id = hash;
+	ht_ctrl.info.bucket_id = bucket;
+	ht_ctrl.info.port = NBL_PT_PP0;
+	ht_ctrl.info.access_size = NBL_ACC_SIZE_32B;
+	ht_ctrl.info.start = 1;
+
+	if (nbl_send_ht_data(hw_mgt, &ht_ctrl, ht.data, common))
+		return -EIO;
+
+	nbl_check_ht_data(hw_mgt, &ht_ctrl, common);
+	return 0;
+}
+
+static int nbl_hw_set_kt(void *priv, u8 *key, u32 key_index, u8 key_type)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	union nbl_fem_kt_acc_ctrl_u kt_ctrl = { .info = { 0 } };
+	struct nbl_common_info *common;
+
+	common = NBL_HW_MGT_TO_COMMON(hw_mgt);
+
+	kt_ctrl.info.addr = key_index;
+	kt_ctrl.info.access_size = key_type == NBL_KT_HALF_MODE ?
+					   NBL_ACC_SIZE_160B :
+					   NBL_ACC_SIZE_320B;
+	kt_ctrl.info.start = 1;
+
+	if (nbl_send_kt_data(hw_mgt, &kt_ctrl, key, common))
+		return -EIO;
+
+	nbl_check_kt_data(hw_mgt, &kt_ctrl, common);
+	return 0;
+}
+
+static int nbl_hw_search_key(void *priv, u8 *key, u8 key_type)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_common_info *common;
+	union nbl_search_ctrl_u s_ctrl = { .info = { 0 } };
+	union nbl_search_ack_u s_ack = { .info = { 0 } };
+	u8 key_data[NBL_KT_BYTE_LEN] = { 0 };
+	u8 search_key[NBL_FEM_SEARCH_KEY_LEN] = { 0 };
+	u8 data[NBL_FEM_SEARCH_KEY_LEN] = { 0 };
+	u8 times = 3;
+
+	common = NBL_HW_MGT_TO_COMMON(hw_mgt);
+
+	if (key_type == NBL_KT_HALF_MODE)
+		memcpy(key_data, key, NBL_KT_BYTE_HALF_LEN);
+	else
+		memcpy(key_data, key, NBL_KT_BYTE_LEN);
+
+	key_data[0] &= KT_MASK_LEN32_ACTION_INFO;
+	key_data[1] &= KT_MASK_LEN12_ACTION_INFO;
+	if (key_type == NBL_KT_HALF_MODE)
+		memcpy(&search_key[20], key_data, NBL_KT_BYTE_HALF_LEN);
+	else
+		memcpy(search_key, key_data, NBL_KT_BYTE_LEN);
+
+	nbl_debug(common, "Search key:0x%x-%x-%x-%x-%x-%x-%x-%x-%x-%x",
+		  ((u32 *)search_key)[9], ((u32 *)search_key)[8],
+		  ((u32 *)search_key)[7], ((u32 *)search_key)[6],
+		  ((u32 *)search_key)[5], ((u32 *)search_key)[4],
+		  ((u32 *)search_key)[3], ((u32 *)search_key)[2],
+		  ((u32 *)search_key)[1], ((u32 *)search_key)[0]);
+	nbl_hw_wr_regs(hw_mgt, NBL_FEM_INSERT_SEARCH0_DATA, search_key,
+		       NBL_FEM_SEARCH_KEY_LEN);
+
+	s_ctrl.info.start = 1;
+	nbl_hw_wr_regs(hw_mgt, NBL_FEM_INSERT_SEARCH0_CTRL, (u8 *)&s_ctrl,
+		       NBL_SEARCH_CTRL_WIDTH);
+
+	do {
+		nbl_hw_rd_regs(hw_mgt, NBL_FEM_INSERT_SEARCH0_ACK, s_ack.data,
+			       NBL_SEARCH_ACK_WIDTH);
+		nbl_debug(common, "Search key ack:done:%u status:%u.",
+			  s_ack.info.done, s_ack.info.status);
+
+		if (!s_ack.info.done) {
+			times--;
+			usleep_range(100, 200);
+		} else {
+			nbl_hw_rd_regs(hw_mgt, NBL_FEM_INSERT_SEARCH0_DATA,
+				       data, NBL_FEM_SEARCH_KEY_LEN);
+			nbl_debug(common,
+				  "Search key data:0x%x-%x-%x-%x-%x-%x-%x-%x-%x-%x-%x.",
+				  ((u32 *)data)[10], ((u32 *)data)[9],
+				  ((u32 *)data)[8], ((u32 *)data)[7],
+				  ((u32 *)data)[6], ((u32 *)data)[5],
+				  ((u32 *)data)[4], ((u32 *)data)[3],
+				  ((u32 *)data)[2], ((u32 *)data)[1],
+				  ((u32 *)data)[0]);
+			break;
+		}
+	} while (times);
+
+	if (!times) {
+		nbl_err(common, "Search ht/kt failed.");
+		return -EAGAIN;
+	}
+
+	return 0;
+}
+
+static int nbl_hw_add_tcam(void *priv, u32 index, u8 *key, u32 *action,
+			   u8 key_type, u8 pp_type)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	union fem_em_tcam_table_u tcam_table;
+	union fem_em_tcam_table_u tcam_table_second;
+	union fem_em_ad_table_u ad_table;
+
+	memset(&tcam_table, 0, sizeof(tcam_table));
+	memset(&tcam_table_second, 0, sizeof(tcam_table_second));
+	memset(&ad_table, 0, sizeof(ad_table));
+
+	memcpy(tcam_table.info.key, key, NBL_KT_BYTE_HALF_LEN);
+	tcam_table.info.key_vld = 1;
+
+	if (key_type == NBL_KT_FULL_MODE) {
+		tcam_table.info.key_size = 1;
+		memcpy(tcam_table_second.info.key, &key[5],
+		       NBL_KT_BYTE_HALF_LEN);
+		tcam_table_second.info.key_vld = 1;
+		tcam_table_second.info.key_size = 1;
+
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_FEM_EM_TCAM_TABLE_REG(pp_type, index + 1),
+			       tcam_table_second.hash_key,
+			       NBL_FLOW_TCAM_TOTAL_LEN);
+	}
+	nbl_hw_wr_regs(hw_mgt, NBL_FEM_EM_TCAM_TABLE_REG(pp_type, index),
+		       tcam_table.hash_key, NBL_FLOW_TCAM_TOTAL_LEN);
+
+	ad_table.info.action0 = action[0];
+	ad_table.info.action1 = action[1];
+	ad_table.info.action2 = action[2];
+	ad_table.info.action3 = action[3];
+	ad_table.info.action4 = action[4];
+	ad_table.info.action5 = action[5];
+	ad_table.info.action6 = action[6];
+	ad_table.info.action7 = action[7];
+	ad_table.info.action8 = action[8];
+	ad_table.info.action9 = action[9];
+	ad_table.info.action10 = action[10];
+	ad_table.info.action11 = action[11];
+	ad_table.info.action12 = action[12];
+	ad_table.info.action13 = action[13];
+	ad_table.info.action14 = action[14];
+	ad_table.info.action15 = action[15];
+	nbl_hw_wr_regs(hw_mgt, NBL_FEM_EM_AD_TABLE_REG(pp_type, index),
+		       ad_table.hash_key, NBL_FLOW_AD_TOTAL_LEN);
+
+	return 0;
+}
+
+static void nbl_hw_del_tcam(void *priv, u32 index, u8 key_type, u8 pp_type)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	union fem_em_tcam_table_u tcam_table;
+	union fem_em_tcam_table_u tcam_table_second;
+	union fem_em_ad_table_u ad_table;
+
+	memset(&tcam_table, 0, sizeof(tcam_table));
+	memset(&tcam_table_second, 0, sizeof(tcam_table_second));
+	memset(&ad_table, 0, sizeof(ad_table));
+	if (key_type == NBL_KT_FULL_MODE)
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_FEM_EM_TCAM_TABLE_REG(pp_type, index + 1),
+			       tcam_table_second.hash_key,
+			       NBL_FLOW_TCAM_TOTAL_LEN);
+	nbl_hw_wr_regs(hw_mgt, NBL_FEM_EM_TCAM_TABLE_REG(pp_type, index),
+		       tcam_table.hash_key, NBL_FLOW_TCAM_TOTAL_LEN);
+
+	nbl_hw_wr_regs(hw_mgt, NBL_FEM_EM_AD_TABLE_REG(pp_type, index),
+		       ad_table.hash_key, NBL_FLOW_AD_TOTAL_LEN);
+}
+
+static int nbl_hw_add_mcc(void *priv, u16 mcc_id, u16 prev_mcc_id,
+			  u16 next_mcc_id, u16 action)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_mcc_tbl node = { 0 };
+
+	node.vld = 1;
+	if (next_mcc_id == NBL_MCC_ID_INVALID) {
+		node.next_pntr = 0;
+		node.tail = 1;
+	} else {
+		node.next_pntr = next_mcc_id;
+		node.tail = 0;
+	}
+
+	node.stateid_filter = 1;
+	node.flowid_filter = 1;
+	node.dport_act = action;
+
+	nbl_hw_wr_regs(hw_mgt, NBL_MCC_LEAF_NODE_TABLE(mcc_id), (u8 *)&node,
+		       sizeof(node));
+	if (prev_mcc_id != NBL_MCC_ID_INVALID) {
+		nbl_hw_rd_regs(hw_mgt, NBL_MCC_LEAF_NODE_TABLE(prev_mcc_id),
+			       (u8 *)&node, sizeof(node));
+		node.next_pntr = mcc_id;
+		node.tail = 0;
+		nbl_hw_wr_regs(hw_mgt, NBL_MCC_LEAF_NODE_TABLE(prev_mcc_id),
+			       (u8 *)&node, sizeof(node));
+	}
+
+	return 0;
+}
+
+static void nbl_hw_del_mcc(void *priv, u16 mcc_id, u16 prev_mcc_id,
+			   u16 next_mcc_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_mcc_tbl node = { 0 };
+
+	if (prev_mcc_id != NBL_MCC_ID_INVALID) {
+		nbl_hw_rd_regs(hw_mgt, NBL_MCC_LEAF_NODE_TABLE(prev_mcc_id),
+			       (u8 *)&node, sizeof(node));
+
+		if (next_mcc_id != NBL_MCC_ID_INVALID) {
+			node.next_pntr = next_mcc_id;
+		} else {
+			node.next_pntr = 0;
+			node.tail = 1;
+		}
+
+		nbl_hw_wr_regs(hw_mgt, NBL_MCC_LEAF_NODE_TABLE(prev_mcc_id),
+			       (u8 *)&node, sizeof(node));
+	}
+
+	memset(&node, 0, sizeof(node));
+	nbl_hw_wr_regs(hw_mgt, NBL_MCC_LEAF_NODE_TABLE(mcc_id), (u8 *)&node,
+		       sizeof(node));
+}
+
+static void nbl_hw_update_mcc_next_node(void *priv, u16 mcc_id, u16 next_mcc_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_mcc_tbl node = { 0 };
+
+	nbl_hw_rd_regs(hw_mgt, NBL_MCC_LEAF_NODE_TABLE(mcc_id), (u8 *)&node,
+		       sizeof(node));
+	if (next_mcc_id != NBL_MCC_ID_INVALID) {
+		node.next_pntr = next_mcc_id;
+		node.tail = 0;
+	} else {
+		node.next_pntr = 0;
+		node.tail = 1;
+	}
+
+	nbl_hw_wr_regs(hw_mgt, NBL_MCC_LEAF_NODE_TABLE(mcc_id), (u8 *)&node,
+		       sizeof(node));
+}
+
+static int nbl_hw_init_fem(void *priv)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	union nbl_fem_ht_size_table_u ht_size = { .info = { 0 } };
+	u32 fem_start = NBL_FEM_INIT_START_KERN;
+	int ret = 0;
+
+	nbl_hw_wr_regs(hw_mgt, NBL_FEM_INIT_START, (u8 *)&fem_start,
+		       sizeof(fem_start));
+
+	nbl_hw_fem_set_bank(hw_mgt);
+
+	ht_size.info.pp0_size = HT_PORT0_BTM;
+	ht_size.info.pp1_size = HT_PORT1_BTM;
+	ht_size.info.pp2_size = HT_PORT2_BTM;
+	nbl_hw_wr_regs(hw_mgt, NBL_FEM_HT_SIZE_REG, ht_size.data,
+		       NBL_FEM_HT_SIZE_TBL_WIDTH);
+
+	nbl_hw_fem_clear_tcam_ad(hw_mgt);
+
+	return ret;
+}
+
 static void nbl_configure_dped_checksum(struct nbl_hw_mgt *hw_mgt)
 {
 	union dped_l4_ck_cmd_40_u l4_ck_cmd_40;
@@ -2007,6 +2468,20 @@ static void nbl_hw_set_coalesce(void *priv, u16 interrupt_id, u16 pnum,
 		       (u8 *)&msix_info, sizeof(msix_info));
 }
 
+static int nbl_hw_set_vsi_mtu(void *priv, u16 vsi_id, u16 mtu_sel)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_ipro_dn_src_port_tbl dpsport = { 0 };
+
+	nbl_hw_rd_regs(hw_mgt, NBL_IPRO_DN_SRC_PORT_TABLE(vsi_id),
+		       (u8 *)&dpsport, sizeof(struct nbl_ipro_dn_src_port_tbl));
+	dpsport.mtu_sel = mtu_sel;
+	nbl_hw_wr_regs(hw_mgt, NBL_IPRO_DN_SRC_PORT_TABLE(vsi_id),
+		       (u8 *)&dpsport, sizeof(struct nbl_ipro_dn_src_port_tbl));
+
+	return 0;
+}
+
 static void nbl_hw_config_adminq_rxq(void *priv, dma_addr_t dma_addr,
 				     int size_bwid)
 {
@@ -2172,6 +2647,36 @@ static void nbl_hw_set_fw_pong(void *priv, u32 pong)
 		       sizeof(pong));
 }
 
+static int nbl_hw_set_mtu(void *priv, u16 mtu_index, u16 mtu)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_ipro_mtu_sel ipro_mtu_sel = { 0 };
+
+	nbl_hw_rd_regs(hw_mgt, NBL_IPRO_MTU_SEL_REG(mtu_index / 2),
+		       (u8 *)&ipro_mtu_sel, sizeof(ipro_mtu_sel));
+
+	if (mtu_index % 2 == 0)
+		ipro_mtu_sel.mtu_0 = mtu;
+	else
+		ipro_mtu_sel.mtu_1 = mtu;
+
+	nbl_hw_wr_regs(hw_mgt, NBL_IPRO_MTU_SEL_REG(mtu_index / 2),
+		       (u8 *)&ipro_mtu_sel, sizeof(ipro_mtu_sel));
+
+	return 0;
+}
+
+static u16 nbl_hw_get_mtu_index(void *priv, u16 vsi_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_ipro_dn_src_port_tbl ipro_dn_src_port_tbl = { 0 };
+
+	nbl_hw_rd_regs(hw_mgt, NBL_IPRO_DN_SRC_PORT_TBL_REG(vsi_id),
+		       (u8 *)&ipro_dn_src_port_tbl,
+		       sizeof(ipro_dn_src_port_tbl));
+	return ipro_dn_src_port_tbl.mtu_sel;
+}
+
 static int nbl_hw_process_abnormal_queue(struct nbl_hw_mgt *hw_mgt,
 					 u16 queue_id, int type,
 					 struct nbl_abnormal_details *detail)
@@ -2431,9 +2936,23 @@ static struct nbl_hw_ops hw_ops = {
 	.save_uvn_ctx = nbl_hw_save_uvn_ctx,
 	.setup_queue_switch = nbl_hw_setup_queue_switch,
 	.init_pfc = nbl_hw_init_pfc,
+	.set_vsi_mtu = nbl_hw_set_vsi_mtu,
+	.set_mtu = nbl_hw_set_mtu,
+	.get_mtu_index = nbl_hw_get_mtu_index,
+
 	.configure_msix_map = nbl_hw_configure_msix_map,
 	.configure_msix_info = nbl_hw_configure_msix_info,
 	.set_coalesce = nbl_hw_set_coalesce,
+
+	.set_ht = nbl_hw_set_ht,
+	.set_kt = nbl_hw_set_kt,
+	.search_key = nbl_hw_search_key,
+	.add_tcam = nbl_hw_add_tcam,
+	.del_tcam = nbl_hw_del_tcam,
+	.add_mcc = nbl_hw_add_mcc,
+	.del_mcc = nbl_hw_del_mcc,
+	.update_mcc_next_node = nbl_hw_update_mcc_next_node,
+	.init_fem = nbl_hw_init_fem,
 	.update_mailbox_queue_tail_ptr = nbl_hw_update_mailbox_queue_tail_ptr,
 	.config_mailbox_rxq = nbl_hw_config_mailbox_rxq,
 	.config_mailbox_txq = nbl_hw_config_mailbox_txq,
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
index 161ba88a61c0..010a4c1363ed 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
@@ -550,9 +550,14 @@ static int nbl_res_setup_ops(struct device *dev,
 		return -ENOMEM;
 
 	if (!is_ops_inited) {
+		ret = nbl_flow_setup_ops_leonis(&res_ops);
+		if (ret)
+			goto setup_fail;
+
 		ret = nbl_queue_setup_ops_leonis(&res_ops);
 		if (ret)
 			goto setup_fail;
+
 		ret = nbl_intr_setup_ops(&res_ops);
 		if (ret)
 			goto setup_fail;
@@ -884,6 +889,7 @@ static void nbl_res_stop(struct nbl_resource_mgt_leonis *res_mgt_leonis)
 	nbl_intr_mgt_stop(res_mgt);
 	nbl_adminq_mgt_stop(res_mgt);
 	nbl_vsi_mgt_stop(res_mgt);
+	nbl_flow_mgt_stop_leonis(res_mgt);
 	nbl_res_ctrl_dev_ustore_stats_remove(res_mgt);
 	nbl_res_ctrl_dev_remove_vsi_info(res_mgt);
 	nbl_res_ctrl_dev_remove_eth_info(res_mgt);
@@ -936,6 +942,10 @@ static int nbl_res_start(struct nbl_resource_mgt_leonis *res_mgt_leonis,
 		if (ret)
 			goto start_fail;
 
+		ret = nbl_flow_mgt_start_leonis(res_mgt);
+		if (ret)
+			goto start_fail;
+
 		ret = nbl_queue_mgt_start(res_mgt);
 		if (ret)
 			goto start_fail;
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
index 3763c33db00f..a486d2e64626 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
@@ -11,6 +11,9 @@
 
 #define NBL_MAX_PF_LEONIS			8
 
+int nbl_flow_mgt_start_leonis(struct nbl_resource_mgt *res_mgt);
+void nbl_flow_mgt_stop_leonis(struct nbl_resource_mgt *res_mgt);
+int nbl_flow_setup_ops_leonis(struct nbl_resource_ops *resource_ops);
 int nbl_queue_setup_ops_leonis(struct nbl_resource_ops *resource_ops);
 void nbl_queue_remove_ops_leonis(struct nbl_resource_ops *resource_ops);
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
index 853bb3022e51..c52a17acc4f3 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
@@ -10,6 +10,93 @@
 #include <linux/netdev_features.h>
 #include "nbl_include.h"
 
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
 #define nbl_err(common, fmt, ...)					\
 do {									\
 	typeof(common) _common = (common);				\
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
index b8f49cc75bc8..e2c5a865892f 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
@@ -105,10 +105,28 @@ struct nbl_hw_ops {
 	void (*update_adminq_queue_tail_ptr)(void *priv, u16 tail_ptr, u8 txrx);
 	bool (*check_adminq_dma_err)(void *priv, bool tx);
 
+	int (*set_vsi_mtu)(void *priv, u16 vsi_id, u16 mtu_sel);
+
 	u8 __iomem *(*get_hw_addr)(void *priv, size_t *size);
 	int (*set_sfp_state)(void *priv, u8 eth_id, u8 state);
 	void (*set_hw_status)(void *priv, enum nbl_hw_status hw_status);
 	enum nbl_hw_status (*get_hw_status)(void *priv);
+	int (*set_mtu)(void *priv, u16 mtu_index, u16 mtu);
+	u16 (*get_mtu_index)(void *priv, u16 vsi_id);
+
+	int (*set_ht)(void *priv, u16 hash, u16 hash_other, u8 ht_table,
+		      u8 bucket, u32 key_index, u8 valid);
+	int (*set_kt)(void *priv, u8 *key, u32 key_index, u8 key_type);
+	int (*search_key)(void *priv, u8 *key, u8 key_type);
+	int (*add_tcam)(void *priv, u32 index, u8 *key, u32 *action,
+			u8 key_type, u8 pp_type);
+	void (*del_tcam)(void *priv, u32 index, u8 key_type, u8 pp_type);
+	int (*add_mcc)(void *priv, u16 mcc_id, u16 prev_mcc_id, u16 next_mcc_id,
+		       u16 action);
+	void (*del_mcc)(void *priv, u16 mcc_id, u16 prev_mcc_id,
+			u16 next_mcc_id);
+	void (*update_mcc_next_node)(void *priv, u16 mcc_id, u16 next_mcc_id);
+	int (*init_fem)(void *priv);
 	void (*set_fw_ping)(void *priv, u32 ping);
 	u32 (*get_fw_pong)(void *priv);
 	void (*set_fw_pong)(void *priv, u32 pong);
-- 
2.47.3


