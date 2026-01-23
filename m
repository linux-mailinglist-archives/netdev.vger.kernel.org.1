Return-Path: <netdev+bounces-252576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BTwJTbNcmlgpgAAu9opvQ
	(envelope-from <netdev+bounces-252576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:21:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C21F06F027
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71045303A252
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 01:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A39336B06C;
	Fri, 23 Jan 2026 01:19:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-194.mail.aliyun.com (out28-194.mail.aliyun.com [115.124.28.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D6826982C;
	Fri, 23 Jan 2026 01:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769131149; cv=none; b=EzYq2RwGLhLJcCjXPSlLqEreDovebwzD3+1YnlUkvqwB2ky1jkShE88f6MIVnde7Eictq0ryrSUUqkPlGRMaxVcS+Dau7Z5ZgYKLe8t35sG0a5V4qnArplpOJH2qM3u84FE3JJjbZCqVLbgee7dp7oKD+Y03Ay6NG1IoAZ3YF94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769131149; c=relaxed/simple;
	bh=tzh0sUELb9pNZjaWtgUo3Wi2gqSjayQT6cHLuU5tQok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKgS9c71UJVIPPfK8Eo2dN5Ptsy7pUHx9P8dA5GEGf/ZlH2ebaehSRDkUUVHnK45tWbPdAS1+uNJImReK34MKtM+8ICz+uKiAJIJP0Y/S6VxJO0atBHrPvYzcP0eR8kSeuNuwI6mGANzfyGTvGTKgZDhw7WGjXc5UmXSzgfNo2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.gDSYW2-_1769131125 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 23 Jan 2026 09:18:46 +0800
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
	hawk@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	sdf@fomichev.me,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	edumazet@google.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 net-next 07/15] net/nebula-matrix: add queue resource implementation
Date: Fri, 23 Jan 2026 09:17:44 +0800
Message-ID: <20260123011804.31263-8-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123011804.31263-1-illusion.wang@nebula-matrix.com>
References: <20260123011804.31263-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252576-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[nebula-matrix.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,redhat.com,linux.dev,fomichev.me,iogearbox.net,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,illusion.wang:url,nebula-matrix.com:mid,nebula-matrix.com:email]
X-Rspamd-Queue-Id: C21F06F027
X-Rspamd-Action: no action

1. Queue Resource Management
Allocation & Release:
nbl_res_queue_alloc_txrx_queues: Allocates transmit/receive queues for
a VSI (Virtual Station Interface).
nbl_res_queue_free_txrx_queues: Releases queue resources.
Initialization:
nbl_res_queue_setup_queue_info: Initializes queue metadata (e.g., queue
count, context).
nbl_res_queue_remove_queue_info: Cleans up queue metadata.
2. Queue Mapping & Configuration
QID Mapping Table:
nbl_res_queue_setup_qid_map_table_leonis: Sets up mappings from local
QIDs to global QIDs.
nbl_res_queue_remove_qid_map_table_leonis: Removes entries from the
mapping table.
Hardware Configuration:
nbl_res_queue_setup_hw_dq: Configures hardware TX/RX queues (descriptor
addresses, interrupt settings).
nbl_res_queue_remove_all_hw_dq: Disables and cleans up hardware queues.
3. RSS (Receive Side Scaling) Support
RSS Table Initialization:
nbl_res_queue_init_epro_rss_key: Initializes RSS hash keys.
nbl_res_queue_setup_rss: Allocates RSS indir table entries for a VSI.
nbl_res_queue_remove_rss: Releases RSS resources.
Indirection Table:
nbl_res_queue_set_rxfh_indir: Configures the RSS indirection table for
traffic distribution.
4. VSI-Queue Association
VSI Registration:
nbl_res_queue_register_vsi2q: Registers a VSI with the queue manager.
nbl_res_queue_setup_q2vsi/nbl_res_queue_remove_q2vsi: Binds/unbinds
queues to a VSI.
Queue Group Configuration:
nbl_res_queue_setup_cqs: Configures queue groups (e.g., for multi-queue
load balancing).
nbl_res_queue_remove_cqs: Cleans up queue groups.
5. Traffic Scheduling & Shaping
Scheduling:
nbl_res_queue_cfg_dsch: Maps queues to traffic classes (QoS).
Hardware Initialization:
nbl_res_queue_init_epro_vpt_table: Initializes virtual port tables.
nbl_res_queue_init_ipro_dn_sport_tbl: Configures downstream traffic
tables.
6. Initialization & Cleanup
Module Initialization:
nbl_res_queue_init: Initializes the queue manager (e.g., mapping tables,
RSS tables).
nbl_res_queue_clear_queues: Cleans up all queue resources.
Operation Registration:
nbl_queue_setup_ops_leonis: Registers queue management function pointers.
nbl_queue_remove_ops_leonis: Unregisters operations.

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |    2 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  |  955 ++++++++++++++
 .../nbl_hw/nbl_hw_leonis/nbl_queue_leonis.c   | 1129 +++++++++++++++++
 .../nbl_hw/nbl_hw_leonis/nbl_queue_leonis.h   |   15 +
 .../nbl_hw_leonis/nbl_resource_leonis.c       |   13 +
 .../nbl_hw_leonis/nbl_resource_leonis.h       |   12 +
 .../nebula-matrix/nbl/nbl_hw/nbl_queue.c      |   60 +
 .../nebula-matrix/nbl/nbl_hw/nbl_queue.h      |   11 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |    4 +
 .../nbl/nbl_include/nbl_def_hw.h              |   48 +
 .../nbl/nbl_include/nbl_def_resource.h        |   27 +
 .../nbl/nbl_include/nbl_include.h             |   28 +
 12 files changed, 2304 insertions(+)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_queue_leonis.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_queue_leonis.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_queue.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_queue.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index d27f0bd7f81b..1e873a4cd31e 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -7,10 +7,12 @@ obj-$(CONFIG_NBL_CORE) := nbl_core.o
 nbl_core-objs +=       nbl_common/nbl_common.o \
 				nbl_channel/nbl_channel.o \
 				nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
+				nbl_hw/nbl_hw_leonis/nbl_queue_leonis.o \
 				nbl_hw/nbl_hw_leonis/nbl_resource_leonis.o \
 				nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.o \
 				nbl_hw/nbl_resource.o \
 				nbl_hw/nbl_interrupt.o \
+				nbl_hw/nbl_queue.o \
 				nbl_core/nbl_dispatch.o \
 				nbl_core/nbl_service.o \
 				nbl_core/nbl_dev.o \
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
index baad9e6ad4c9..9b3ba97428a9 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -4,7 +4,13 @@
  * Author:
  */
 
+#include <linux/if_bridge.h>
+
 #include "nbl_hw_leonis.h"
+#include "nbl_hw/nbl_hw_leonis/base/nbl_datapath.h"
+#include "nbl_hw/nbl_hw_leonis/base/nbl_ppe.h"
+#include "nbl_hw_leonis_regs.h"
+
 static u32 nbl_hw_get_quirks(void *priv)
 {
 	struct nbl_hw_mgt *hw_mgt = priv;
@@ -19,6 +25,924 @@ static u32 nbl_hw_get_quirks(void *priv)
 	return quirks;
 }
 
+static int nbl_hw_init_qid_map_table(void *priv)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_virtio_qid_map_table info = { 0 }, info2 = { 0 };
+	struct device *dev = NBL_HW_MGT_TO_DEV(hw_mgt);
+	u64 reg;
+	u16 i, j, k;
+
+	memset(&info, 0, sizeof(info));
+	info.local_qid = 0x1FF;
+	info.notify_addr_l = 0x7FFFFF;
+	info.notify_addr_h = 0xFFFFFFFF;
+	info.global_qid = 0xFFF;
+	info.ctrlq_flag = 0X1;
+	info.rsv1 = 0;
+	info.rsv2 = 0;
+
+	for (k = 0; k < 2; k++) { /* 0 is primary table , 1 is standby table */
+		for (i = 0; i < NBL_QID_MAP_TABLE_ENTRIES; i++) {
+			j = 0;
+			do {
+				reg = NBL_PCOMPLETER_QID_MAP_REG_ARR(k, i);
+				nbl_hw_wr_regs(hw_mgt, reg, (u8 *)&info,
+					       sizeof(info));
+				nbl_hw_rd_regs(hw_mgt, reg, (u8 *)&info2,
+					       sizeof(info2));
+				if (likely(!memcmp(&info, &info2,
+						   sizeof(info))))
+					break;
+				j++;
+			} while (j < NBL_REG_WRITE_MAX_TRY_TIMES);
+
+			if (j == NBL_REG_WRITE_MAX_TRY_TIMES)
+				dev_err(dev,
+					"Write to qid map table entry %hu failed\n",
+					i);
+		}
+	}
+
+	return 0;
+}
+
+static int nbl_hw_set_qid_map_table(void *priv, void *data, int qid_map_select)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_common_info *common = NBL_HW_MGT_TO_COMMON(hw_mgt);
+	struct nbl_qid_map_param *param = (struct nbl_qid_map_param *)data;
+	struct nbl_virtio_qid_map_table info = { 0 }, info_data = { 0 };
+	struct nbl_queue_table_select select = { 0 };
+	u64 reg;
+	int i, j;
+
+	for (i = 0; i < param->len; i++) {
+		j = 0;
+
+		info.local_qid = param->qid_map[i].local_qid;
+		info.notify_addr_l = param->qid_map[i].notify_addr_l;
+		info.notify_addr_h = param->qid_map[i].notify_addr_h;
+		info.global_qid = param->qid_map[i].global_qid;
+		info.ctrlq_flag = param->qid_map[i].ctrlq_flag;
+
+		do {
+			reg = NBL_PCOMPLETER_QID_MAP_REG_ARR(qid_map_select,
+							     param->start + i);
+			nbl_hw_wr_regs(hw_mgt, reg, (u8 *)(&info),
+				       sizeof(info));
+			nbl_hw_rd_regs(hw_mgt, reg, (u8 *)(&info_data),
+				       sizeof(info_data));
+			if (likely(!memcmp(&info, &info_data, sizeof(info))))
+				break;
+			j++;
+		} while (j < NBL_REG_WRITE_MAX_TRY_TIMES);
+
+		if (j == NBL_REG_WRITE_MAX_TRY_TIMES)
+			nbl_err(common,
+				"Write to qid map table entry %d failed\n",
+				param->start + i);
+	}
+
+	select.select = qid_map_select;
+	nbl_hw_wr_regs(hw_mgt, NBL_PCOMPLETER_QUEUE_TABLE_SELECT_REG,
+		       (u8 *)&select, sizeof(select));
+
+	return 0;
+}
+
+static int nbl_hw_set_qid_map_ready(void *priv, bool ready)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_queue_table_ready queue_table_ready = { 0 };
+
+	queue_table_ready.ready = ready;
+	nbl_hw_wr_regs(hw_mgt, NBL_PCOMPLETER_QUEUE_TABLE_READY_REG,
+		       (u8 *)&queue_table_ready, sizeof(queue_table_ready));
+
+	return 0;
+}
+
+static int nbl_hw_cfg_ipro_queue_tbl(void *priv, u16 queue_id, u16 vsi_id,
+				     u8 enable)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_ipro_queue_tbl ipro_queue_tbl = { 0 };
+
+	ipro_queue_tbl.vsi_en = enable;
+	ipro_queue_tbl.vsi_id = vsi_id;
+
+	nbl_hw_wr_regs(hw_mgt, NBL_IPRO_QUEUE_TBL(queue_id),
+		       (u8 *)&ipro_queue_tbl, sizeof(ipro_queue_tbl));
+
+	return 0;
+}
+
+static int nbl_hw_cfg_ipro_dn_sport_tbl(void *priv, u16 vsi_id, u16 dst_eth_id,
+					u16 bmode, bool binit)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_ipro_dn_src_port_tbl dpsport = { 0 };
+
+	if (binit) {
+		dpsport.entry_vld = 1;
+		dpsport.hw_flow = 1;
+		dpsport.set_dport.dport.down.upcall_flag = AUX_FWD_TYPE_NML_FWD;
+		dpsport.set_dport.dport.down.port_type = SET_DPORT_TYPE_ETH_LAG;
+		dpsport.set_dport.dport.down.lag_vld = 0;
+		dpsport.set_dport.dport.down.eth_vld = 1;
+		dpsport.set_dport.dport.down.eth_id = dst_eth_id;
+		dpsport.vlan_layer_num_1 = 3;
+		dpsport.set_dport_en = 1;
+	} else {
+		nbl_hw_rd_regs(hw_mgt, NBL_IPRO_DN_SRC_PORT_TABLE(vsi_id),
+			       (u8 *)&dpsport,
+			       sizeof(struct nbl_ipro_dn_src_port_tbl));
+	}
+
+	if (bmode == BRIDGE_MODE_VEPA)
+		dpsport.set_dport.dport.down.next_stg_sel = NEXT_STG_SEL_EPRO;
+	else
+		dpsport.set_dport.dport.down.next_stg_sel = NEXT_STG_SEL_NONE;
+
+	nbl_hw_wr_regs(hw_mgt, NBL_IPRO_DN_SRC_PORT_TABLE(vsi_id),
+		       (u8 *)&dpsport, sizeof(struct nbl_ipro_dn_src_port_tbl));
+
+	return 0;
+}
+
+static int nbl_hw_set_vnet_queue_info(void *priv,
+				      struct nbl_vnet_queue_info_param *param,
+				      u16 queue_id)
+{
+	struct nbl_hw_mgt_leonis *hw_mgt_leonis =
+		(struct nbl_hw_mgt_leonis *)priv;
+	struct nbl_hw_mgt *hw_mgt = &hw_mgt_leonis->hw_mgt;
+	struct nbl_host_vnet_qinfo host_vnet_qinfo = { 0 };
+
+	host_vnet_qinfo.function_id = param->function_id;
+	host_vnet_qinfo.device_id = param->device_id;
+	host_vnet_qinfo.bus_id = param->bus_id;
+	host_vnet_qinfo.valid = param->valid;
+	host_vnet_qinfo.msix_idx = param->msix_idx;
+	host_vnet_qinfo.msix_idx_valid = param->msix_idx_valid;
+
+	if (hw_mgt_leonis->ro_enable) {
+		host_vnet_qinfo.ido_en = 1;
+		host_vnet_qinfo.rlo_en = 1;
+	}
+
+	nbl_hw_wr_regs(hw_mgt, NBL_PADPT_HOST_VNET_QINFO_REG_ARR(queue_id),
+		       (u8 *)&host_vnet_qinfo, sizeof(host_vnet_qinfo));
+
+	return 0;
+}
+
+static int nbl_hw_clear_vnet_queue_info(void *priv, u16 queue_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_host_vnet_qinfo host_vnet_qinfo = { 0 };
+
+	nbl_hw_wr_regs(hw_mgt, NBL_PADPT_HOST_VNET_QINFO_REG_ARR(queue_id),
+		       (u8 *)&host_vnet_qinfo, sizeof(host_vnet_qinfo));
+	return 0;
+}
+
+static int nbl_hw_reset_dvn_cfg(void *priv, u16 queue_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_common_info *common = NBL_HW_MGT_TO_COMMON(hw_mgt);
+	struct nbl_dvn_queue_reset queue_reset = { 0 };
+	struct nbl_dvn_queue_reset_done queue_reset_done = { 0 };
+	int i = 0;
+
+	queue_reset.dvn_queue_index = queue_id;
+	queue_reset.vld = 1;
+	nbl_hw_wr_regs(hw_mgt, NBL_DVN_QUEUE_RESET_REG, (u8 *)&queue_reset,
+		       sizeof(queue_reset));
+
+	udelay(5);
+	nbl_hw_rd_regs(hw_mgt, NBL_DVN_QUEUE_RESET_DONE_REG,
+		       (u8 *)&queue_reset_done, sizeof(queue_reset_done));
+	while (!queue_reset_done.flag) {
+		i++;
+		if (!(i % 10)) {
+			nbl_err(common,
+				"Wait too long for tx queue reset to be done");
+			break;
+		}
+
+		udelay(5);
+		nbl_hw_rd_regs(hw_mgt, NBL_DVN_QUEUE_RESET_DONE_REG,
+			       (u8 *)&queue_reset_done,
+			       sizeof(queue_reset_done));
+	}
+
+	nbl_debug(common, "dvn:%u cfg reset succedd, wait %d 5ns\n", queue_id,
+		  i);
+	return 0;
+}
+
+static int nbl_hw_reset_uvn_cfg(void *priv, u16 queue_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_common_info *common = NBL_HW_MGT_TO_COMMON(hw_mgt);
+	struct nbl_uvn_queue_reset queue_reset = { 0 };
+	struct nbl_uvn_queue_reset_done queue_reset_done = { 0 };
+	int i = 0;
+
+	queue_reset.index = queue_id;
+	queue_reset.vld = 1;
+	nbl_hw_wr_regs(hw_mgt, NBL_UVN_QUEUE_RESET_REG, (u8 *)&queue_reset,
+		       sizeof(queue_reset));
+
+	udelay(5);
+	nbl_hw_rd_regs(hw_mgt, NBL_UVN_QUEUE_RESET_DONE_REG,
+		       (u8 *)&queue_reset_done, sizeof(queue_reset_done));
+	while (!queue_reset_done.flag) {
+		i++;
+		if (!(i % 10)) {
+			nbl_err(common,
+				"Wait too long for rx queue reset to be done");
+			break;
+		}
+
+		udelay(5);
+		nbl_hw_rd_regs(hw_mgt, NBL_UVN_QUEUE_RESET_DONE_REG,
+			       (u8 *)&queue_reset_done,
+			       sizeof(queue_reset_done));
+	}
+
+	nbl_debug(common, "uvn:%u cfg reset succedd, wait %d 5ns\n", queue_id,
+		  i);
+	return 0;
+}
+
+static int nbl_hw_restore_dvn_context(void *priv, u16 queue_id, u16 split,
+				      u16 last_avail_index)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_common_info *common = NBL_HW_MGT_TO_COMMON(hw_mgt);
+	struct dvn_queue_context cxt = { 0 };
+
+	cxt.dvn_ring_wrap_counter = last_avail_index >> 15;
+	if (split)
+		cxt.dvn_avail_ring_read = last_avail_index;
+	else
+		cxt.dvn_l1_ring_read = last_avail_index & 0x7FFF;
+
+	nbl_hw_wr_regs(hw_mgt, NBL_DVN_QUEUE_CXT_TABLE_ARR(queue_id),
+		       (u8 *)&cxt, sizeof(cxt));
+	nbl_info(common, "config tx ring: %u, last avail idx: %u\n", queue_id,
+		 last_avail_index);
+
+	return 0;
+}
+
+static int nbl_hw_restore_uvn_context(void *priv, u16 queue_id, u16 split,
+				      u16 last_avail_index)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_common_info *common = NBL_HW_MGT_TO_COMMON(hw_mgt);
+	struct uvn_queue_cxt cxt = { 0 };
+
+	cxt.wrap_count = last_avail_index >> 15;
+	if (split)
+		cxt.queue_head = last_avail_index;
+	else
+		cxt.queue_head = last_avail_index & 0x7FFF;
+
+	nbl_hw_wr_regs(hw_mgt, NBL_UVN_QUEUE_CXT_TABLE_ARR(queue_id),
+		       (u8 *)&cxt, sizeof(cxt));
+	nbl_info(common, "config rx ring: %u, last avail idx: %u\n", queue_id,
+		 last_avail_index);
+
+	return 0;
+}
+
+static int nbl_hw_cfg_tx_queue(void *priv, void *data, u16 queue_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_queue_cfg_param *queue_cfg =
+		(struct nbl_queue_cfg_param *)data;
+	struct dvn_queue_table info = { 0 };
+
+	info.dvn_queue_baddr = queue_cfg->desc;
+	if (!queue_cfg->split && !queue_cfg->extend_header)
+		queue_cfg->avail = queue_cfg->avail | 3;
+	info.dvn_avail_baddr = queue_cfg->avail;
+	info.dvn_used_baddr = queue_cfg->used;
+	info.dvn_queue_size = ilog2(queue_cfg->size);
+	info.dvn_queue_type = queue_cfg->split;
+	info.dvn_queue_en = 1;
+	info.dvn_extend_header_en = queue_cfg->extend_header;
+
+	nbl_hw_wr_regs(hw_mgt, NBL_DVN_QUEUE_TABLE_ARR(queue_id), (u8 *)&info,
+		       sizeof(info));
+
+	return 0;
+}
+
+static int nbl_hw_cfg_rx_queue(void *priv, void *data, u16 queue_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_queue_cfg_param *queue_cfg =
+		(struct nbl_queue_cfg_param *)data;
+	struct uvn_queue_table info = { 0 };
+
+	info.queue_baddr = queue_cfg->desc;
+	info.avail_baddr = queue_cfg->avail;
+	info.used_baddr = queue_cfg->used;
+	info.queue_size_mask_pow = ilog2(queue_cfg->size);
+	info.queue_type = queue_cfg->split;
+	info.extend_header_en = queue_cfg->extend_header;
+	info.half_offload_en = queue_cfg->half_offload_en;
+	info.guest_csum_en = queue_cfg->rxcsum;
+	info.queue_enable = 1;
+
+	nbl_hw_wr_regs(hw_mgt, NBL_UVN_QUEUE_TABLE_ARR(queue_id), (u8 *)&info,
+		       sizeof(info));
+
+	return 0;
+}
+
+static int nbl_hw_cfg_q2tc_netid(void *priv, u16 queue_id, u16 netid, u16 vld)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct dsch_vn_q2tc_cfg_tbl info;
+
+	nbl_hw_rd_regs(hw_mgt, NBL_DSCH_VN_Q2TC_CFG_TABLE_REG_ARR(queue_id),
+		       (u8 *)&info, sizeof(info));
+	info.tcid = (info.tcid & 0x7) | (netid << 3);
+	info.vld = vld;
+
+	nbl_hw_wr_regs(hw_mgt, NBL_DSCH_VN_Q2TC_CFG_TABLE_REG_ARR(queue_id),
+		       (u8 *)&info, sizeof(info));
+	return 0;
+}
+
+static void nbl_hw_active_shaping(void *priv, u16 func_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_shaping_net shaping_net = { 0 };
+	struct dsch_vn_sha2net_map_tbl sha2net = { 0 };
+	struct dsch_vn_net2sha_map_tbl net2sha = { 0 };
+
+	nbl_hw_rd_regs(hw_mgt, NBL_SHAPING_NET(func_id), (u8 *)&shaping_net,
+		       sizeof(shaping_net));
+
+	if (!shaping_net.depth)
+		return;
+
+	sha2net.vld = 1;
+	nbl_hw_wr_regs(hw_mgt, NBL_DSCH_VN_SHA2NET_MAP_TABLE_REG_ARR(func_id),
+		       (u8 *)&sha2net, sizeof(sha2net));
+
+	shaping_net.valid = 1;
+	nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_NET(func_id), (u8 *)&shaping_net,
+		       sizeof(shaping_net));
+
+	net2sha.vld = 1;
+	nbl_hw_wr_regs(hw_mgt, NBL_DSCH_VN_NET2SHA_MAP_TABLE_REG_ARR(func_id),
+		       (u8 *)&net2sha, sizeof(net2sha));
+}
+
+static void nbl_hw_deactive_shaping(void *priv, u16 func_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_shaping_net shaping_net = { 0 };
+	struct dsch_vn_sha2net_map_tbl sha2net = { 0 };
+	struct dsch_vn_net2sha_map_tbl net2sha = { 0 };
+
+	nbl_hw_wr_regs(hw_mgt, NBL_DSCH_VN_NET2SHA_MAP_TABLE_REG_ARR(func_id),
+		       (u8 *)&net2sha, sizeof(net2sha));
+
+	nbl_hw_rd_regs(hw_mgt, NBL_SHAPING_NET(func_id), (u8 *)&shaping_net,
+		       sizeof(shaping_net));
+	shaping_net.valid = 0;
+	nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_NET(func_id), (u8 *)&shaping_net,
+		       sizeof(shaping_net));
+
+	nbl_hw_wr_regs(hw_mgt, NBL_DSCH_VN_SHA2NET_MAP_TABLE_REG_ARR(func_id),
+		       (u8 *)&sha2net, sizeof(sha2net));
+}
+
+static int nbl_hw_cfg_dsch_net_to_group(void *priv, u16 func_id, u16 group_id,
+					u16 vld)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct dsch_vn_n2g_cfg_tbl info = { 0 };
+
+	info.grpid = group_id;
+	info.vld = vld;
+	nbl_hw_wr_regs(hw_mgt, NBL_DSCH_VN_N2G_CFG_TABLE_REG_ARR(func_id),
+		       (u8 *)&info, sizeof(info));
+	return 0;
+}
+
+static int nbl_hw_cfg_epro_rss_ret(void *priv, u32 index, u8 size_type,
+				   u32 q_num, u16 *queue_list, const u32 *indir)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_common_info *common = NBL_HW_MGT_TO_COMMON(hw_mgt);
+	struct nbl_epro_rss_ret_tbl rss_ret = { 0 };
+	u32 table_id, table_end, group_count, odd_num, queue_id = 0;
+
+	group_count = NBL_EPRO_RSS_ENTRY_SIZE_UNIT << size_type;
+	if (group_count > NBL_EPRO_RSS_ENTRY_MAX_COUNT) {
+		nbl_err(common,
+			"Rss group entry size type %u exceed the max value %u",
+			size_type, NBL_EPRO_RSS_ENTRY_SIZE_256);
+		return -EINVAL;
+	}
+
+	if (q_num > group_count) {
+		nbl_err(common, "q_num %u exceed the rss group count %u\n",
+			q_num, group_count);
+		return -EINVAL;
+	}
+	if (index >= NBL_EPRO_RSS_RET_TBL_DEPTH ||
+	    (index + group_count) > NBL_EPRO_RSS_RET_TBL_DEPTH) {
+		nbl_err(common,
+			"index %u exceed the max table entry %u, entry size: %u\n",
+			index, NBL_EPRO_RSS_RET_TBL_DEPTH, group_count);
+		return -EINVAL;
+	}
+
+	table_id = index / 2;
+	table_end = (index + group_count) / 2;
+	odd_num = index % 2;
+	nbl_hw_rd_regs(hw_mgt, NBL_EPRO_RSS_RET_TABLE(table_id), (u8 *)&rss_ret,
+		       sizeof(rss_ret));
+
+	if (indir) {
+		if (odd_num) {
+			rss_ret.vld1 = 1;
+			rss_ret.dqueue1 = indir[queue_id++];
+			nbl_hw_wr_regs(hw_mgt, NBL_EPRO_RSS_RET_TABLE(table_id),
+				       (u8 *)&rss_ret, sizeof(rss_ret));
+			table_id++;
+		}
+
+		for (; table_id < table_end; table_id++) {
+			rss_ret.vld0 = 1;
+			rss_ret.dqueue0 = indir[queue_id++];
+			rss_ret.vld1 = 1;
+			rss_ret.dqueue1 = indir[queue_id++];
+			nbl_hw_wr_regs(hw_mgt, NBL_EPRO_RSS_RET_TABLE(table_id),
+				       (u8 *)&rss_ret, sizeof(rss_ret));
+		}
+
+		nbl_hw_rd_regs(hw_mgt, NBL_EPRO_RSS_RET_TABLE(table_id),
+			       (u8 *)&rss_ret, sizeof(rss_ret));
+
+		if (odd_num) {
+			rss_ret.vld0 = 1;
+			rss_ret.dqueue0 = indir[queue_id++];
+			nbl_hw_wr_regs(hw_mgt, NBL_EPRO_RSS_RET_TABLE(table_id),
+				       (u8 *)&rss_ret, sizeof(rss_ret));
+		}
+	} else {
+		if (odd_num) {
+			rss_ret.vld1 = 1;
+			rss_ret.dqueue1 = queue_list[queue_id++];
+			nbl_hw_wr_regs(hw_mgt, NBL_EPRO_RSS_RET_TABLE(table_id),
+				       (u8 *)&rss_ret, sizeof(rss_ret));
+			table_id++;
+		}
+
+		queue_id = queue_id % q_num;
+		for (; table_id < table_end; table_id++) {
+			rss_ret.vld0 = 1;
+			rss_ret.dqueue0 = queue_list[queue_id++];
+			queue_id = queue_id % q_num;
+			rss_ret.vld1 = 1;
+			rss_ret.dqueue1 = queue_list[queue_id++];
+			queue_id = queue_id % q_num;
+			nbl_hw_wr_regs(hw_mgt, NBL_EPRO_RSS_RET_TABLE(table_id),
+				       (u8 *)&rss_ret, sizeof(rss_ret));
+		}
+
+		nbl_hw_rd_regs(hw_mgt, NBL_EPRO_RSS_RET_TABLE(table_id),
+			       (u8 *)&rss_ret, sizeof(rss_ret));
+
+		if (odd_num) {
+			rss_ret.vld0 = 1;
+			rss_ret.dqueue0 = queue_list[queue_id++];
+			nbl_hw_wr_regs(hw_mgt, NBL_EPRO_RSS_RET_TABLE(table_id),
+				       (u8 *)&rss_ret, sizeof(rss_ret));
+		}
+	}
+
+	return 0;
+}
+
+static struct nbl_epro_rss_key epro_rss_key_def = {
+	.key0 = 0x6d5a6d5a6d5a6d5a,
+	.key1 = 0x6d5a6d5a6d5a6d5a,
+	.key2 = 0x6d5a6d5a6d5a6d5a,
+	.key3 = 0x6d5a6d5a6d5a6d5a,
+	.key4 = 0x6d5a6d5a6d5a6d5a,
+};
+
+static int nbl_hw_init_epro_rss_key(void *priv)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+
+	nbl_hw_wr_regs(hw_mgt, NBL_EPRO_RSS_KEY_REG, (u8 *)&epro_rss_key_def,
+		       sizeof(epro_rss_key_def));
+
+	return 0;
+}
+
+static int nbl_hw_init_epro_vpt_tbl(void *priv, u16 vsi_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_epro_vpt_tbl epro_vpt_tbl = { 0 };
+
+	epro_vpt_tbl.vld = 1;
+	epro_vpt_tbl.fwd = NBL_EPRO_FWD_TYPE_DROP;
+	epro_vpt_tbl.rss_alg_sel = NBL_EPRO_RSS_ALG_TOEPLITZ_HASH;
+	epro_vpt_tbl.rss_key_type_ipv4 = NBL_EPRO_RSS_KEY_TYPE_IPV4_L4;
+	epro_vpt_tbl.rss_key_type_ipv6 = NBL_EPRO_RSS_KEY_TYPE_IPV6_L4;
+
+	nbl_hw_wr_regs(hw_mgt, NBL_EPRO_VPT_TABLE(vsi_id), (u8 *)&epro_vpt_tbl,
+		       sizeof(struct nbl_epro_vpt_tbl));
+
+	return 0;
+}
+
+static int nbl_hw_set_epro_rss_pt(void *priv, u16 vsi_id, u16 rss_ret_base,
+				  u16 rss_entry_size)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_epro_rss_pt_tbl epro_rss_pt_tbl = { 0 };
+	struct nbl_epro_vpt_tbl epro_vpt_tbl;
+	u16 entry_size;
+
+	if (rss_entry_size > NBL_EPRO_RSS_ENTRY_MAX_SIZE)
+		entry_size = NBL_EPRO_RSS_ENTRY_MAX_SIZE;
+	else
+		entry_size = rss_entry_size;
+
+	epro_rss_pt_tbl.vld = 1;
+	epro_rss_pt_tbl.entry_size = entry_size;
+	epro_rss_pt_tbl.offset0_vld = 1;
+	epro_rss_pt_tbl.offset0 = rss_ret_base;
+	if (rss_entry_size > NBL_EPRO_RSS_ENTRY_MAX_SIZE) {
+		epro_rss_pt_tbl.offset1_vld = 1;
+		epro_rss_pt_tbl.offset1 =
+			rss_ret_base +
+			(NBL_EPRO_RSS_ENTRY_SIZE_UNIT << entry_size);
+	} else {
+		epro_rss_pt_tbl.offset1_vld = 0;
+		epro_rss_pt_tbl.offset1 = 0;
+	}
+
+	nbl_hw_wr_regs(hw_mgt, NBL_EPRO_RSS_PT_TABLE(vsi_id),
+		       (u8 *)&epro_rss_pt_tbl, sizeof(epro_rss_pt_tbl));
+
+	nbl_hw_rd_regs(hw_mgt, NBL_EPRO_VPT_TABLE(vsi_id), (u8 *)&epro_vpt_tbl,
+		       sizeof(epro_vpt_tbl));
+	epro_vpt_tbl.fwd = NBL_EPRO_FWD_TYPE_NORMAL;
+	nbl_hw_wr_regs(hw_mgt, NBL_EPRO_VPT_TABLE(vsi_id), (u8 *)&epro_vpt_tbl,
+		       sizeof(epro_vpt_tbl));
+
+	return 0;
+}
+
+static int nbl_hw_clear_epro_rss_pt(void *priv, u16 vsi_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_epro_rss_pt_tbl epro_rss_pt_tbl = { 0 };
+	struct nbl_epro_vpt_tbl epro_vpt_tbl;
+
+	nbl_hw_wr_regs(hw_mgt, NBL_EPRO_RSS_PT_TABLE(vsi_id),
+		       (u8 *)&epro_rss_pt_tbl, sizeof(epro_rss_pt_tbl));
+
+	nbl_hw_rd_regs(hw_mgt, NBL_EPRO_VPT_TABLE(vsi_id), (u8 *)&epro_vpt_tbl,
+		       sizeof(epro_vpt_tbl));
+	epro_vpt_tbl.fwd = NBL_EPRO_FWD_TYPE_DROP;
+	nbl_hw_wr_regs(hw_mgt, NBL_EPRO_VPT_TABLE(vsi_id), (u8 *)&epro_vpt_tbl,
+		       sizeof(epro_vpt_tbl));
+
+	return 0;
+}
+
+static int nbl_hw_disable_dvn(void *priv, u16 queue_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct dvn_queue_table info = { 0 };
+
+	nbl_hw_rd_regs(hw_mgt, NBL_DVN_QUEUE_TABLE_ARR(queue_id), (u8 *)&info,
+		       sizeof(info));
+	info.dvn_queue_en = 0;
+	nbl_hw_wr_regs(hw_mgt, NBL_DVN_QUEUE_TABLE_ARR(queue_id), (u8 *)&info,
+		       sizeof(info));
+	return 0;
+}
+
+static int nbl_hw_disable_uvn(void *priv, u16 queue_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct uvn_queue_table info = { 0 };
+
+	nbl_hw_wr_regs(hw_mgt, NBL_UVN_QUEUE_TABLE_ARR(queue_id), (u8 *)&info,
+		       sizeof(info));
+	return 0;
+}
+
+static bool nbl_hw_is_txq_drain_out(struct nbl_hw_mgt *hw_mgt, u16 queue_id,
+				    struct dsch_vn_tc_q_list_tbl *tc_q_list)
+{
+	nbl_hw_rd_regs(hw_mgt, NBL_DSCH_VN_TC_Q_LIST_TABLE_REG_ARR(queue_id),
+		       (u8 *)tc_q_list, sizeof(*tc_q_list));
+	if (!tc_q_list->regi && !tc_q_list->fly)
+		return true;
+
+	return false;
+}
+
+static bool nbl_hw_is_rxq_drain_out(struct nbl_hw_mgt *hw_mgt, u16 queue_id)
+{
+	struct uvn_desc_cxt cache_ctx = { 0 };
+
+	nbl_hw_rd_regs(hw_mgt, NBL_UVN_DESC_CXT_TABLE_ARR(queue_id),
+		       (u8 *)&cache_ctx, sizeof(cache_ctx));
+	if (cache_ctx.cache_pref_num_prev == cache_ctx.cache_pref_num_post)
+		return true;
+
+	return false;
+}
+
+static int nbl_hw_lso_dsch_drain(void *priv, u16 queue_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_common_info *common = NBL_HW_MGT_TO_COMMON(hw_mgt);
+	struct dsch_vn_tc_q_list_tbl tc_q_list = { 0 };
+	struct dsch_vn_q2tc_cfg_tbl info;
+	int i = 0;
+
+	nbl_hw_rd_regs(hw_mgt, NBL_DSCH_VN_Q2TC_CFG_TABLE_REG_ARR(queue_id),
+		       (u8 *)&info, sizeof(info));
+	info.vld = 0;
+	nbl_hw_wr_regs(hw_mgt, NBL_DSCH_VN_Q2TC_CFG_TABLE_REG_ARR(queue_id),
+		       (u8 *)&info, sizeof(info));
+	do {
+		if (nbl_hw_is_txq_drain_out(hw_mgt, queue_id, &tc_q_list))
+			break;
+
+		usleep_range(10, 20);
+	} while (++i < NBL_DRAIN_WAIT_TIMES);
+
+	if (i >= NBL_DRAIN_WAIT_TIMES) {
+		nbl_err(common,
+			"nbl queue %u lso dsch drain, regi %u, fly %u, vld %u\n",
+			queue_id, tc_q_list.regi, tc_q_list.fly, tc_q_list.vld);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int nbl_hw_rsc_cache_drain(void *priv, u16 queue_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_common_info *common = NBL_HW_MGT_TO_COMMON(hw_mgt);
+	int i = 0;
+
+	do {
+		if (nbl_hw_is_rxq_drain_out(hw_mgt, queue_id))
+			break;
+
+		usleep_range(10, 20);
+	} while (++i < NBL_DRAIN_WAIT_TIMES);
+
+	if (i >= NBL_DRAIN_WAIT_TIMES) {
+		nbl_err(common, "nbl queue %u rsc cache drain timeout\n",
+			queue_id);
+		return -1;
+	}
+
+	return 0;
+}
+
+static u16 nbl_hw_save_dvn_ctx(void *priv, u16 queue_id, u16 split)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_common_info *common = NBL_HW_MGT_TO_COMMON(hw_mgt);
+	struct dvn_queue_context dvn_ctx = { 0 };
+
+	nbl_hw_rd_regs(hw_mgt, NBL_DVN_QUEUE_CXT_TABLE_ARR(queue_id),
+		       (u8 *)&dvn_ctx, sizeof(dvn_ctx));
+
+	nbl_debug(common, "DVNQ save ctx: %d packed: %08x %08x split: %08x\n",
+		  queue_id, dvn_ctx.dvn_ring_wrap_counter,
+		  dvn_ctx.dvn_l1_ring_read, dvn_ctx.dvn_avail_ring_idx);
+
+	if (split)
+		return (dvn_ctx.dvn_avail_ring_idx);
+	else
+		return (dvn_ctx.dvn_l1_ring_read & 0x7FFF) |
+		       (dvn_ctx.dvn_ring_wrap_counter << 15);
+}
+
+static u16 nbl_hw_save_uvn_ctx(void *priv, u16 queue_id, u16 split,
+			       u16 queue_size)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_common_info *common = NBL_HW_MGT_TO_COMMON(hw_mgt);
+	struct uvn_queue_cxt queue_cxt = { 0 };
+	struct uvn_desc_cxt desc_cxt = { 0 };
+	u16 cache_diff, queue_head, wrap_count;
+
+	nbl_hw_rd_regs(hw_mgt, NBL_UVN_QUEUE_CXT_TABLE_ARR(queue_id),
+		       (u8 *)&queue_cxt, sizeof(queue_cxt));
+	nbl_hw_rd_regs(hw_mgt, NBL_UVN_DESC_CXT_TABLE_ARR(queue_id),
+		       (u8 *)&desc_cxt, sizeof(desc_cxt));
+
+	nbl_debug(common,
+		  "UVN save ctx: %d cache_tail: %08x cache_head %08x queue_head: %08x\n",
+		  queue_id, desc_cxt.cache_tail, desc_cxt.cache_head,
+		  queue_cxt.queue_head);
+
+	cache_diff = (desc_cxt.cache_tail - desc_cxt.cache_head + 64) & (0x3F);
+	queue_head = (queue_cxt.queue_head - cache_diff + 65536) & (0xFFFF);
+	if (queue_size)
+		wrap_count = !((queue_head / queue_size) & 0x1);
+	else
+		return 0xffff;
+
+	nbl_debug(common, "UVN save ctx: %d packed: %08x %08x split: %08x\n",
+		  queue_id, wrap_count, queue_head, queue_head);
+
+	if (split)
+		return (queue_head);
+	else
+		return (queue_head & 0x7FFF) | (wrap_count << 15);
+}
+
+static void nbl_hw_setup_queue_switch(void *priv, u16 eth_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_ipro_upsport_tbl upsport = { 0 };
+	struct nbl_epro_ept_tbl ept_tbl = { 0 };
+	struct dsch_vn_g2p_cfg_tbl info = { 0 };
+
+	upsport.hw_flow = 1;
+	upsport.entry_vld = 1;
+	upsport.set_dport_en = 1;
+	upsport.set_dport_pri = 0;
+	upsport.vlan_layer_num_0 = 3;
+	upsport.vlan_layer_num_1 = 3;
+	/* default we close promisc */
+	upsport.set_dport.data = 0xFFF;
+
+	ept_tbl.vld = 1;
+	ept_tbl.fwd = 1;
+
+	info.vld = 1;
+	info.port = (eth_id << 1);
+
+	nbl_hw_wr_regs(hw_mgt, NBL_IPRO_UP_SPORT_TABLE(eth_id), (u8 *)&upsport,
+		       sizeof(upsport));
+
+	nbl_hw_wr_regs(hw_mgt, NBL_EPRO_EPT_TABLE(eth_id), (u8 *)&ept_tbl,
+		       sizeof(struct nbl_epro_ept_tbl));
+
+	nbl_hw_wr_regs(hw_mgt, NBL_DSCH_VN_G2P_CFG_TABLE_REG_ARR(eth_id),
+		       (u8 *)&info, sizeof(info));
+}
+
+static void nbl_hw_init_pfc(void *priv, u8 ether_ports)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_dqm_rxmac_tx_port_bp_en_cfg dqm_port_bp_en = { 0 };
+	struct nbl_dqm_rxmac_tx_cos_bp_en_cfg dqm_cos_bp_en = { 0 };
+	struct nbl_uqm_rx_cos_bp_en_cfg uqm_rx_cos_bp_en = { 0 };
+	struct nbl_uqm_tx_cos_bp_en_cfg uqm_tx_cos_bp_en = { 0 };
+	struct nbl_ustore_port_fc_th ustore_port_fc_th = { 0 };
+	struct nbl_ustore_cos_fc_th ustore_cos_fc_th = { 0 };
+	struct nbl_epro_port_pri_mdf_en_cfg pri_mdf_en_cfg = { 0 };
+	struct nbl_epro_cos_map cos_map = { 0 };
+	struct nbl_upa_pri_sel_conf sel_conf = { 0 };
+	struct nbl_upa_pri_conf conf_table = { 0 };
+	int i, j;
+
+	/* DQM */
+	/* set default bp_mode: port */
+	/* TX bp: dqm send received ETH RX Pause to DSCH */
+	/* dqm rxmac_tx_port_bp_en */
+	dqm_port_bp_en.eth0 = 1;
+	dqm_port_bp_en.eth1 = 1;
+	dqm_port_bp_en.eth2 = 1;
+	dqm_port_bp_en.eth3 = 1;
+	nbl_hw_wr_regs(hw_mgt, NBL_DQM_RXMAC_TX_PORT_BP_EN,
+		       (u8 *)(&dqm_port_bp_en), sizeof(dqm_port_bp_en));
+
+	/* TX bp: dqm donot send received ETH RX PFC to DSCH */
+	/* dqm rxmac_tx_cos_bp_en */
+	dqm_cos_bp_en.eth0 = 0;
+	dqm_cos_bp_en.eth1 = 0;
+	dqm_cos_bp_en.eth2 = 0;
+	dqm_cos_bp_en.eth3 = 0;
+	nbl_hw_wr_regs(hw_mgt, NBL_DQM_RXMAC_TX_COS_BP_EN,
+		       (u8 *)(&dqm_cos_bp_en), sizeof(dqm_cos_bp_en));
+
+	/* UQM */
+	/* RX bp: uqm receive loopback/emp/rdma_e/rdma_h/l4s_e/l4s_h port bp */
+	/* uqm rx_port_bp_en_cfg is ok */
+	/* RX bp: uqm receive loopback/emp/rdma_e/rdma_h/l4s_e/l4s_h port bp */
+	/* uqm tx_port_bp_en_cfg is ok */
+
+	/* RX bp: uqm receive loopback/emp/rdma_e/rdma_h/l4s_e/l4s_h cos bp */
+	/* uqm rx_cos_bp_en */
+	uqm_rx_cos_bp_en.vld_l = 0xFFFFFFFF;
+	uqm_rx_cos_bp_en.vld_h = 0xFFFF;
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_RX_COS_BP_EN, (u8 *)(&uqm_rx_cos_bp_en),
+		       sizeof(uqm_rx_cos_bp_en));
+
+	/* RX bp: uqm send received loopback/emp/rdma_e/rdma_h/l4s_e/l4s_h cos
+	 * bp to USTORE
+	 */
+	/* uqm tx_cos_bp_en */
+	uqm_tx_cos_bp_en.vld_l = 0xFFFFFFFF;
+	uqm_tx_cos_bp_en.vld_h = 0xFF;
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_TX_COS_BP_EN, (u8 *)(&uqm_tx_cos_bp_en),
+		       sizeof(uqm_tx_cos_bp_en));
+
+	/* TX bp: DSCH dp0-3 response to DQM dp0-3 pfc/port bp */
+	/* dsch_dpt_pfc_map_vnh default value is ok */
+	/* TX bp: DSCH response to DQM cos bp, pkt_cos -> sch_cos map table */
+	/* dsch vn_host_dpx_prixx_p2s_map_cfg is ok */
+
+	/* downstream: enable modify packet pri */
+	/* epro port_pri_mdf_en */
+	pri_mdf_en_cfg.eth0 = 0;
+	pri_mdf_en_cfg.eth1 = 0;
+	pri_mdf_en_cfg.eth2 = 0;
+	pri_mdf_en_cfg.eth3 = 0;
+	nbl_hw_wr_regs(hw_mgt, NBL_EPRO_PORT_PRI_MDF_EN,
+		       (u8 *)(&pri_mdf_en_cfg), sizeof(pri_mdf_en_cfg));
+
+	for (i = 0; i < ether_ports; i++) {
+		/* set default bp_mode: port */
+		/* RX bp: USTORE port bp th, enable send pause frame */
+		/* ustore port_fc_th */
+		ustore_port_fc_th.xoff_th = 0x190;
+		ustore_port_fc_th.xon_th = 0x190;
+		ustore_port_fc_th.fc_set = 0;
+		ustore_port_fc_th.fc_en = 1;
+		nbl_hw_wr_regs(hw_mgt, NBL_USTORE_PORT_FC_TH_REG_ARR(i),
+			       (u8 *)(&ustore_port_fc_th),
+			       sizeof(ustore_port_fc_th));
+
+		for (j = 0; j < 8; j++) {
+			/* RX bp: ustore cos bp th, disable send pfc frame */
+			/* ustore cos_fc_th */
+			ustore_cos_fc_th.xoff_th = 0x64;
+			ustore_cos_fc_th.xon_th = 0x64;
+			ustore_cos_fc_th.fc_set = 0;
+			ustore_cos_fc_th.fc_en = 0;
+			nbl_hw_wr_regs(hw_mgt,
+				       NBL_USTORE_COS_FC_TH_REG_ARR(i * 8 + j),
+				       (u8 *)(&ustore_cos_fc_th),
+				       sizeof(ustore_cos_fc_th));
+
+			/* downstream: sch_cos->pkt_cos or sch_cos->dscp */
+			/* epro sch_cos_map */
+			cos_map.pkt_cos = j;
+			cos_map.dscp = j << 3;
+			nbl_hw_wr_regs(hw_mgt, NBL_EPRO_SCH_COS_MAP_TABLE(i, j),
+				       (u8 *)(&cos_map), sizeof(cos_map));
+		}
+	}
+
+	/* upstream: pkt dscp/802.1p -> sch_cos */
+	for (i = 0; i < ether_ports; i++) {
+		/* upstream: when pfc_mode is 802.1p,
+		 * vlan pri -> sch_cos map table
+		 */
+		/* upa pri_conf_table */
+		conf_table.pri0 = 0;
+		conf_table.pri1 = 1;
+		conf_table.pri2 = 2;
+		conf_table.pri3 = 3;
+		conf_table.pri4 = 4;
+		conf_table.pri5 = 5;
+		conf_table.pri6 = 6;
+		conf_table.pri7 = 7;
+		nbl_hw_wr_regs(hw_mgt, NBL_UPA_PRI_CONF_TABLE(i * 8),
+			       (u8 *)(&conf_table), sizeof(conf_table));
+
+		/* upstream: set default pfc_mode is 802.1p, use outer vlan */
+		/* upa pri_sel_conf */
+		sel_conf.pri_sel = (1 << 4 | 1 << 3);
+		nbl_hw_wr_regs(hw_mgt, NBL_UPA_PRI_SEL_CONF_TABLE(i),
+			       (u8 *)(&sel_conf), sizeof(sel_conf));
+	}
+}
+
 static void nbl_hw_enable_mailbox_irq(void *priv, u16 func_id, bool enable_msix,
 				      u16 global_vec_id)
 {
@@ -291,6 +1215,37 @@ static u32 nbl_hw_get_fw_eth_map(void *priv)
 }
 
 static struct nbl_hw_ops hw_ops = {
+	.init_qid_map_table = nbl_hw_init_qid_map_table,
+	.set_qid_map_table = nbl_hw_set_qid_map_table,
+	.set_qid_map_ready = nbl_hw_set_qid_map_ready,
+	.cfg_ipro_queue_tbl = nbl_hw_cfg_ipro_queue_tbl,
+	.cfg_ipro_dn_sport_tbl = nbl_hw_cfg_ipro_dn_sport_tbl,
+	.set_vnet_queue_info = nbl_hw_set_vnet_queue_info,
+	.clear_vnet_queue_info = nbl_hw_clear_vnet_queue_info,
+	.reset_dvn_cfg = nbl_hw_reset_dvn_cfg,
+	.reset_uvn_cfg = nbl_hw_reset_uvn_cfg,
+	.restore_dvn_context = nbl_hw_restore_dvn_context,
+	.restore_uvn_context = nbl_hw_restore_uvn_context,
+
+	.cfg_tx_queue = nbl_hw_cfg_tx_queue,
+	.cfg_rx_queue = nbl_hw_cfg_rx_queue,
+	.cfg_q2tc_netid = nbl_hw_cfg_q2tc_netid,
+	.active_shaping = nbl_hw_active_shaping,
+	.deactive_shaping = nbl_hw_deactive_shaping,
+	.cfg_dsch_net_to_group = nbl_hw_cfg_dsch_net_to_group,
+	.init_epro_rss_key = nbl_hw_init_epro_rss_key,
+	.init_epro_vpt_tbl = nbl_hw_init_epro_vpt_tbl,
+	.cfg_epro_rss_ret = nbl_hw_cfg_epro_rss_ret,
+	.set_epro_rss_pt = nbl_hw_set_epro_rss_pt,
+	.clear_epro_rss_pt = nbl_hw_clear_epro_rss_pt,
+	.disable_dvn = nbl_hw_disable_dvn,
+	.disable_uvn = nbl_hw_disable_uvn,
+	.lso_dsch_drain = nbl_hw_lso_dsch_drain,
+	.rsc_cache_drain = nbl_hw_rsc_cache_drain,
+	.save_dvn_ctx = nbl_hw_save_dvn_ctx,
+	.save_uvn_ctx = nbl_hw_save_uvn_ctx,
+	.setup_queue_switch = nbl_hw_setup_queue_switch,
+	.init_pfc = nbl_hw_init_pfc,
 	.configure_msix_map = nbl_hw_configure_msix_map,
 	.configure_msix_info = nbl_hw_configure_msix_info,
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_queue_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_queue_leonis.c
new file mode 100644
index 000000000000..a140ffafa20c
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_queue_leonis.c
@@ -0,0 +1,1129 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#include <linux/if_bridge.h>
+#include "nbl_queue_leonis.h"
+#include "nbl_resource_leonis.h"
+
+static struct nbl_queue_vsi_info *
+nbl_res_queue_get_vsi_info(struct nbl_resource_mgt *res_mgt, u16 vsi_id)
+{
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_queue_info *queue_info;
+	u16 func_id;
+	int i;
+
+	func_id = nbl_res_vsi_id_to_func_id(res_mgt, vsi_id);
+	queue_info = &queue_mgt->queue_info[func_id];
+
+	for (i = 0; i < NBL_VSI_MAX; i++)
+		if (queue_info->vsi_info[i].vsi_id == vsi_id)
+			return &queue_info->vsi_info[i];
+
+	return NULL;
+}
+
+static int nbl_res_queue_get_net_id(u16 func_id, u16 vsi_type)
+{
+	int net_id;
+
+	switch (vsi_type) {
+	case NBL_VSI_DATA:
+		net_id = func_id + NBL_SPECIFIC_VSI_NET_ID_OFFSET;
+		break;
+	default:
+		net_id = func_id;
+		break;
+	}
+
+	return net_id;
+}
+
+static int nbl_res_queue_setup_queue_info(struct nbl_resource_mgt *res_mgt,
+					  u16 func_id, u16 num_queues)
+{
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_queue_info *queue_info = &queue_mgt->queue_info[func_id];
+	u16 *txrx_queues, *queues_context;
+	u32 *uvn_stat_pkt_drop;
+	u16 queue_index;
+	int i, ret = 0;
+
+	nbl_debug(common, "Setup qid map, func_id:%d, num_queues:%d", func_id,
+		  num_queues);
+
+	txrx_queues = kcalloc(num_queues, sizeof(txrx_queues[0]), GFP_ATOMIC);
+	if (!txrx_queues) {
+		ret = -ENOMEM;
+		goto alloc_txrx_queues_fail;
+	}
+
+	queues_context =
+		kcalloc(num_queues * 2, sizeof(txrx_queues[0]), GFP_ATOMIC);
+	if (!queues_context) {
+		ret = -ENOMEM;
+		goto alloc_queue_contex_fail;
+	}
+
+	uvn_stat_pkt_drop =
+		kcalloc(num_queues, sizeof(*uvn_stat_pkt_drop), GFP_ATOMIC);
+	if (!uvn_stat_pkt_drop) {
+		ret = -ENOMEM;
+		goto alloc_uvn_stat_pkt_drop_fail;
+	}
+
+	queue_info->num_txrx_queues = num_queues;
+	queue_info->txrx_queues = txrx_queues;
+	queue_info->queues_context = queues_context;
+	queue_info->uvn_stat_pkt_drop = uvn_stat_pkt_drop;
+
+	for (i = 0; i < num_queues; i++) {
+		queue_index = find_first_zero_bit(queue_mgt->txrx_queue_bitmap,
+						  NBL_MAX_TXRX_QUEUE);
+		if (queue_index == NBL_MAX_TXRX_QUEUE) {
+			ret = -ENOSPC;
+			goto get_txrx_queue_fail;
+		}
+		txrx_queues[i] = queue_index;
+		set_bit(queue_index, queue_mgt->txrx_queue_bitmap);
+	}
+	return 0;
+
+get_txrx_queue_fail:
+	kfree(uvn_stat_pkt_drop);
+	while (--i + 1) {
+		queue_index = txrx_queues[i];
+		clear_bit(queue_index, queue_mgt->txrx_queue_bitmap);
+	}
+	queue_info->num_txrx_queues = 0;
+	queue_info->txrx_queues = NULL;
+alloc_uvn_stat_pkt_drop_fail:
+	kfree(queues_context);
+alloc_queue_contex_fail:
+	kfree(txrx_queues);
+alloc_txrx_queues_fail:
+	return ret;
+}
+
+static void nbl_res_queue_remove_queue_info(struct nbl_resource_mgt *res_mgt,
+					    u16 func_id)
+{
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_queue_info *queue_info = &queue_mgt->queue_info[func_id];
+	u16 i;
+
+	for (i = 0; i < queue_info->num_txrx_queues; i++)
+		clear_bit(queue_info->txrx_queues[i],
+			  queue_mgt->txrx_queue_bitmap);
+
+	kfree(queue_info->txrx_queues);
+	kfree(queue_info->queues_context);
+	kfree(queue_info->uvn_stat_pkt_drop);
+	queue_info->txrx_queues = NULL;
+	queue_info->queues_context = NULL;
+	queue_info->uvn_stat_pkt_drop = NULL;
+
+	queue_info->num_txrx_queues = 0;
+}
+
+static u64 nbl_res_queue_qid_map_key(struct nbl_qid_map_table *map)
+{
+	return ((u64)map->notify_addr_h
+		<< NBL_QID_MAP_NOTIFY_ADDR_LOW_PART_LEN) |
+		(u64)map->notify_addr_l;
+}
+
+static void nbl_res_queue_set_qid_map_table(struct nbl_resource_mgt *res_mgt,
+					    u16 tail)
+{
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	struct nbl_qid_map_param param;
+	int i;
+
+	param.qid_map = kcalloc(tail, sizeof(param.qid_map[0]), GFP_ATOMIC);
+	if (!param.qid_map)
+		return;
+
+	for (i = 0; i < tail; i++)
+		param.qid_map[i] = queue_mgt->qid_map_table[i];
+
+	param.start = 0;
+	param.len = tail;
+
+	hw_ops->set_qid_map_table(NBL_RES_MGT_TO_HW_PRIV(res_mgt), &param,
+				  queue_mgt->qid_map_select);
+	queue_mgt->qid_map_select = !queue_mgt->qid_map_select;
+
+	if (!queue_mgt->qid_map_ready) {
+		hw_ops->set_qid_map_ready(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+					  true);
+		queue_mgt->qid_map_ready = true;
+	}
+
+	kfree(param.qid_map);
+}
+
+int nbl_res_queue_setup_qid_map_table_leonis(struct nbl_resource_mgt *res_mgt,
+					     u16 func_id, u64 notify_addr)
+{
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_queue_info *queue_info = &queue_mgt->queue_info[func_id];
+	struct nbl_qid_map_table qid_map;
+	u16 *txrx_queues = queue_info->txrx_queues;
+	u16 qid_map_entries = queue_info->num_txrx_queues, qid_map_base, tail;
+	u64 key, tmp;
+	int i;
+
+	/* Get base location */
+	queue_info->notify_addr = notify_addr;
+	key = notify_addr >> NBL_QID_MAP_NOTIFY_ADDR_SHIFT;
+
+	for (i = 0; i < NBL_QID_MAP_TABLE_ENTRIES; i++) {
+		tmp = nbl_res_queue_qid_map_key(&queue_mgt->qid_map_table[i]);
+		WARN_ON(key == tmp);
+		if (key < tmp) {
+			qid_map_base = i;
+			break;
+		}
+	}
+	if (i == NBL_QID_MAP_TABLE_ENTRIES) {
+		nbl_err(common, "No valid qid map key for func %d", func_id);
+		return -ENOSPC;
+	}
+
+	/* Calc tail, we will set the qid_map from 0 to tail.
+	 * We have to make sure that this range (0, tail) can cover all the
+	 * changes, which need to consider all the two tables. Therefore, it is
+	 * necessary to store each table's tail, and always use the larger one
+	 * between this table's tail and the added tail.
+	 *
+	 * The reason can be illustrated in the following example:
+	 * Step 1: del some entries, which happens on table 1, and each table
+	 * could be
+	 *      Table 0: 0 - 31 used
+	 *      Table 1: 0 - 15 used
+	 *      SW     : queue_mgt->total_qid_map_entries = 16
+	 * Step 2: add 2 entries, which happens on table 0, if we use 16 + 2
+	 * as the tail, then
+	 *      Table 0: 0 - 17 correctly added, 18 - 31 garbage data
+	 *      Table 1: 0 - 15 used
+	 *      SW     : queue_mgt->total_qid_map_entries = 18
+	 * And this is definitely wrong, it should use 32, table 0's original
+	 * tail
+	 */
+	queue_mgt->total_qid_map_entries += qid_map_entries;
+	tail = max(queue_mgt->total_qid_map_entries,
+		   queue_mgt->qid_map_tail[queue_mgt->qid_map_select]);
+	queue_mgt->qid_map_tail[queue_mgt->qid_map_select] =
+		queue_mgt->total_qid_map_entries;
+
+	/* Update qid map */
+	for (i = NBL_QID_MAP_TABLE_ENTRIES - qid_map_entries; i > qid_map_base;
+	     i--)
+		queue_mgt->qid_map_table[i - 1 + qid_map_entries] =
+			queue_mgt->qid_map_table[i - 1];
+
+	for (i = 0; i < queue_info->num_txrx_queues; i++) {
+		qid_map.local_qid = 2 * i + 1;
+		qid_map.notify_addr_l = key;
+		qid_map.notify_addr_h = key >>
+					NBL_QID_MAP_NOTIFY_ADDR_LOW_PART_LEN;
+		qid_map.global_qid = txrx_queues[i];
+		qid_map.ctrlq_flag = 0;
+		queue_mgt->qid_map_table[qid_map_base + i] = qid_map;
+	}
+
+	nbl_res_queue_set_qid_map_table(res_mgt, tail);
+
+	return 0;
+}
+
+void nbl_res_queue_remove_qid_map_table_leonis(struct nbl_resource_mgt *res_mgt,
+					       u16 func_id)
+{
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_queue_info *queue_info = &queue_mgt->queue_info[func_id];
+	struct nbl_qid_map_table qid_map;
+	u64 key;
+	u16 qid_map_entries = queue_info->num_txrx_queues, qid_map_base, tail;
+	int i;
+
+	/* Get base location */
+	key = queue_info->notify_addr >> NBL_QID_MAP_NOTIFY_ADDR_SHIFT;
+
+	for (i = 0; i < NBL_QID_MAP_TABLE_ENTRIES; i++) {
+		if (key ==
+		    nbl_res_queue_qid_map_key(&queue_mgt->qid_map_table[i])) {
+			qid_map_base = i;
+			break;
+		}
+	}
+	if (i == NBL_QID_MAP_TABLE_ENTRIES) {
+		nbl_err(common, "No valid qid map key for func %d", func_id);
+		return;
+	}
+
+	/* Calc tail, we will set the qid_map from 0 to tail.
+	 * We have to make sure that this range (0, tail) can cover all the
+	 * changes, which need to consider all the two tables. Therefore, it
+	 * is necessary to store each table's tail, and always use the larger
+	 * one between this table's tail and the driver-stored tail.
+	 *
+	 * The reason can be illustrated in the following example:
+	 * Step 1: del some entries, which happens on table 1, and each table
+	 * could be
+	 *      Table 0: 0 - 31 used
+	 *      Table 1: 0 - 15 used
+	 *      SW     : queue_mgt->total_qid_map_entries = 16
+	 * Step 2: del 2 entries, which happens on table 0, if we use 16 as
+	 * the tail, then
+	 *      Table 0: 0 - 13 correct, 14 - 31 garbage data
+	 *      Table 1: 0 - 15 used
+	 *      SW     : queue_mgt->total_qid_map_entries = 14
+	 * And this is definitely wrong, it should use 32, table 0's original
+	 * tail
+	 */
+	tail = max(queue_mgt->total_qid_map_entries,
+		   queue_mgt->qid_map_tail[queue_mgt->qid_map_select]);
+	queue_mgt->total_qid_map_entries -= qid_map_entries;
+	queue_mgt->qid_map_tail[queue_mgt->qid_map_select] =
+		queue_mgt->total_qid_map_entries;
+
+	/* Update qid map */
+	memset(&qid_map, U8_MAX, sizeof(qid_map));
+
+	for (i = qid_map_base; i < NBL_QID_MAP_TABLE_ENTRIES - qid_map_entries;
+	     i++)
+		queue_mgt->qid_map_table[i] =
+			queue_mgt->qid_map_table[i + qid_map_entries];
+	for (; i < NBL_QID_MAP_TABLE_ENTRIES; i++)
+		queue_mgt->qid_map_table[i] = qid_map;
+
+	nbl_res_queue_set_qid_map_table(res_mgt, tail);
+}
+
+static int nbl_res_queue_get_rss_ret_base(struct nbl_resource_mgt *res_mgt,
+					  u16 count, u16 rss_entry_size,
+					  struct nbl_queue_vsi_info *vsi_info)
+{
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	u32 rss_ret_base_start;
+	u32 rss_ret_base_end;
+	u16 func_id;
+	u16 rss_entry_count;
+	u16 index, i, j, k;
+	int success = 1;
+	int ret = -EFAULT;
+
+	func_id = nbl_res_vsi_id_to_func_id(res_mgt, vsi_info->vsi_id);
+	if (func_id < NBL_MAX_ETHERNET &&
+	    vsi_info->vsi_index == NBL_VSI_DATA) {
+		rss_ret_base_start = 0;
+		rss_ret_base_end = NBL_EPRO_PF_RSS_RET_TBL_DEPTH;
+		vsi_info->rss_entry_size = NBL_EPRO_PF_RSS_ENTRY_SIZE;
+		rss_entry_count = NBL_EPRO_PF_RSS_RET_TBL_COUNT;
+	} else {
+		rss_ret_base_start = NBL_EPRO_PF_RSS_RET_TBL_DEPTH;
+		rss_ret_base_end = NBL_EPRO_RSS_RET_TBL_DEPTH;
+		vsi_info->rss_entry_size = rss_entry_size;
+		rss_entry_count = count;
+	}
+
+	for (i = rss_ret_base_start; i < rss_ret_base_end;) {
+		index = find_next_zero_bit(queue_mgt->rss_ret_bitmap,
+					   rss_ret_base_end, i);
+		if (index == rss_ret_base_end) {
+			nbl_err(common, "There is no available rss ret left");
+			break;
+		}
+
+		success = 1;
+		for (j = index + 1; j < (index + rss_entry_count); j++) {
+			if (j >= rss_ret_base_end) {
+				success = 0;
+				break;
+			}
+
+			if (test_bit(j, queue_mgt->rss_ret_bitmap)) {
+				success = 0;
+				break;
+			}
+		}
+		if (success) {
+			for (k = index; k < (index + rss_entry_count); k++)
+				set_bit(k, queue_mgt->rss_ret_bitmap);
+			vsi_info->rss_ret_base = index;
+			ret = 0;
+			break;
+		}
+		i = j;
+	}
+
+	return ret;
+}
+
+static int nbl_res_queue_setup_q2vsi(void *priv, u16 vsi_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	struct nbl_queue_info *queue_info = NULL;
+	struct nbl_queue_vsi_info *vsi_info = NULL;
+	void *p = NBL_RES_MGT_TO_HW_PRIV(res_mgt);
+	u16 func_id;
+	u16 qid;
+	int ret = 0, i;
+
+	func_id = nbl_res_vsi_id_to_func_id(res_mgt, vsi_id);
+	queue_info = &queue_mgt->queue_info[func_id];
+	vsi_info = nbl_res_queue_get_vsi_info(res_mgt, vsi_id);
+	if (!vsi_info)
+		return -ENOENT;
+
+	/* config ipro queue tbl */
+	for (i = vsi_info->queue_offset;
+	     i < vsi_info->queue_offset + vsi_info->queue_num &&
+	     i < queue_info->num_txrx_queues;
+	     i++) {
+		qid = queue_info->txrx_queues[i];
+		ret = hw_ops->cfg_ipro_queue_tbl(p, qid, vsi_id, 1);
+		if (ret) {
+			while (--i + 1)
+				hw_ops->cfg_ipro_queue_tbl(p, qid, 0, 0);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void nbl_res_queue_remove_q2vsi(void *priv, u16 vsi_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	struct nbl_queue_info *queue_info = NULL;
+	struct nbl_queue_vsi_info *vsi_info = NULL;
+	u16 func_id;
+	int i;
+
+	func_id = nbl_res_vsi_id_to_func_id(res_mgt, vsi_id);
+	queue_info = &queue_mgt->queue_info[func_id];
+	vsi_info = nbl_res_queue_get_vsi_info(res_mgt, vsi_id);
+	if (!vsi_info)
+		return;
+
+	/*config ipro queue tbl*/
+	for (i = vsi_info->queue_offset;
+	     i < vsi_info->queue_offset + vsi_info->queue_num &&
+	     i < queue_info->num_txrx_queues;
+	     i++)
+		hw_ops->cfg_ipro_queue_tbl(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+					    queue_info->txrx_queues[i], 0, 0);
+}
+
+static int nbl_res_queue_setup_rss(void *priv, u16 vsi_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_queue_vsi_info *vsi_info = NULL;
+	u16 rss_entry_size, count;
+	int ret = 0;
+
+	vsi_info = nbl_res_queue_get_vsi_info(res_mgt, vsi_id);
+	if (!vsi_info)
+		return -ENOENT;
+
+	rss_entry_size =
+		(vsi_info->queue_num + NBL_EPRO_RSS_ENTRY_SIZE_UNIT - 1) /
+		NBL_EPRO_RSS_ENTRY_SIZE_UNIT;
+
+	rss_entry_size = ilog2(roundup_pow_of_two(rss_entry_size));
+	count = NBL_EPRO_RSS_ENTRY_SIZE_UNIT << rss_entry_size;
+
+	ret = nbl_res_queue_get_rss_ret_base(res_mgt, count, rss_entry_size,
+					     vsi_info);
+	if (ret)
+		return -ENOSPC;
+
+	vsi_info->rss_vld = true;
+
+	return 0;
+}
+
+static void nbl_res_queue_remove_rss(void *priv, u16 vsi_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_queue_vsi_info *vsi_info = NULL;
+	u16 rss_ret_base, rss_entry_size, count;
+	int i;
+
+	vsi_info = nbl_res_queue_get_vsi_info(res_mgt, vsi_id);
+	if (!vsi_info)
+		return;
+
+	if (!vsi_info->rss_vld)
+		return;
+
+	rss_ret_base = vsi_info->rss_ret_base;
+	rss_entry_size = vsi_info->rss_entry_size;
+	count = NBL_EPRO_RSS_ENTRY_SIZE_UNIT << rss_entry_size;
+
+	for (i = rss_ret_base; i < (rss_ret_base + count); i++)
+		clear_bit(i, queue_mgt->rss_ret_bitmap);
+
+	vsi_info->rss_vld = false;
+}
+
+static void
+nbl_res_queue_setup_queue_cfg(struct nbl_queue_mgt *queue_mgt,
+			      struct nbl_queue_cfg_param *cfg_param,
+			      struct nbl_txrx_queue_param *queue_param,
+			      bool is_tx, u16 func_id)
+{
+	struct nbl_queue_info *queue_info = &queue_mgt->queue_info[func_id];
+
+	cfg_param->desc = queue_param->dma;
+	cfg_param->size = queue_param->desc_num;
+	cfg_param->global_vector = queue_param->global_vec_id;
+	cfg_param->global_queue_id =
+		queue_info->txrx_queues[queue_param->local_queue_id];
+
+	cfg_param->avail = queue_param->avail;
+	cfg_param->used = queue_param->used;
+	cfg_param->extend_header = queue_param->extend_header;
+	cfg_param->split = queue_param->split;
+	cfg_param->last_avail_idx = queue_param->cxt;
+
+	cfg_param->intr_en = queue_param->intr_en;
+	cfg_param->intr_mask = queue_param->intr_mask;
+
+	cfg_param->tx = is_tx;
+	cfg_param->rxcsum = queue_param->rxcsum;
+	cfg_param->half_offload_en = queue_param->half_offload_en;
+}
+
+static void nbl_res_queue_update_netid_refnum(struct nbl_queue_mgt *queue_mgt,
+					      u16 net_id, bool add)
+{
+	if (net_id >= NBL_MAX_NET_ID)
+		return;
+
+	if (add) {
+		queue_mgt->net_id_ref_vsinum[net_id]++;
+	} else {
+		/* probe call clear_queue first, so judge nor zero to support
+		 * disable dsch more than once
+		 */
+		if (queue_mgt->net_id_ref_vsinum[net_id])
+			queue_mgt->net_id_ref_vsinum[net_id]--;
+	}
+}
+
+static u16 nbl_res_queue_get_netid_refnum(struct nbl_queue_mgt *queue_mgt,
+					  u16 net_id)
+{
+	if (net_id >= NBL_MAX_NET_ID)
+		return 0;
+
+	return queue_mgt->net_id_ref_vsinum[net_id];
+}
+
+static void nbl_res_queue_setup_hw_dq(struct nbl_resource_mgt *res_mgt,
+				      struct nbl_queue_cfg_param *queue_cfg,
+				      u16 func_id, u16 vsi_id)
+{
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_queue_info *queue_info = &queue_mgt->queue_info[func_id];
+	struct nbl_queue_vsi_info *vsi_info;
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	struct nbl_vnet_queue_info_param param = {0};
+	void *p = NBL_RES_MGT_TO_HW_PRIV(res_mgt);
+	u16 global_qid = queue_cfg->global_queue_id;
+	u8 bus, dev, func;
+
+	vsi_info = nbl_res_queue_get_vsi_info(res_mgt, vsi_id);
+	if (!vsi_info)
+		return;
+
+	nbl_res_func_id_to_bdf(res_mgt, func_id, &bus, &dev, &func);
+	queue_info->split = queue_cfg->split;
+	queue_info->queue_size = queue_cfg->size;
+
+	param.function_id = func;
+	param.device_id = dev;
+	param.bus_id = bus;
+	param.valid = 1;
+
+	if (queue_cfg->intr_en) {
+		param.msix_idx = queue_cfg->global_vector;
+		param.msix_idx_valid = 1;
+	}
+
+	if (queue_cfg->tx) {
+		hw_ops->set_vnet_queue_info(p, &param,
+					    NBL_PAIR_ID_GET_TX(global_qid));
+		hw_ops->reset_dvn_cfg(p, global_qid);
+		if (!queue_cfg->extend_header)
+			hw_ops->restore_dvn_context(p, global_qid,
+						    queue_cfg->split,
+						    queue_cfg->last_avail_idx);
+		hw_ops->cfg_tx_queue(p, queue_cfg, global_qid);
+		if (nbl_res_queue_get_netid_refnum(queue_mgt, vsi_info->net_id))
+			hw_ops->cfg_q2tc_netid(p, global_qid,
+					       vsi_info->net_id, 1);
+
+	} else {
+		hw_ops->set_vnet_queue_info(p, &param,
+					    NBL_PAIR_ID_GET_RX(global_qid));
+		hw_ops->reset_uvn_cfg(p, global_qid);
+
+		if (!queue_cfg->extend_header)
+			hw_ops->restore_uvn_context(p, global_qid,
+						    queue_cfg->split,
+						    queue_cfg->last_avail_idx);
+		hw_ops->cfg_rx_queue(p, queue_cfg, global_qid);
+	}
+}
+
+static void nbl_res_queue_remove_all_hw_dq(struct nbl_resource_mgt *res_mgt,
+					   u16 func_id,
+					   struct nbl_queue_vsi_info *vsi_info)
+{
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_queue_info *queue_info = &queue_mgt->queue_info[func_id];
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	u16 start = vsi_info->queue_offset,
+	    end = vsi_info->queue_offset + vsi_info->queue_num;
+	u16 global_queue;
+	int i;
+
+	for (i = start; i < end; i++) {
+		global_queue = queue_info->txrx_queues[i];
+
+		hw_ops->lso_dsch_drain(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+				       global_queue);
+		hw_ops->disable_dvn(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+				    global_queue);
+	}
+
+	for (i = start; i < end; i++) {
+		global_queue = queue_info->txrx_queues[i];
+
+		hw_ops->disable_uvn(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+				    global_queue);
+		hw_ops->rsc_cache_drain(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+					global_queue);
+	}
+
+	for (i = start; i < end; i++) {
+		global_queue = queue_info->txrx_queues[i];
+		queue_info->queues_context[NBL_PAIR_ID_GET_RX(i)] =
+			hw_ops->save_uvn_ctx(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+					     global_queue, queue_info->split,
+					     queue_info->queue_size);
+		queue_info->queues_context[NBL_PAIR_ID_GET_TX(i)] =
+			hw_ops->save_dvn_ctx(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+					     global_queue, queue_info->split);
+	}
+
+	for (i = start; i < end; i++) {
+		global_queue = queue_info->txrx_queues[i];
+		hw_ops->reset_uvn_cfg(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+				      global_queue);
+		hw_ops->reset_dvn_cfg(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+				      global_queue);
+	}
+
+	for (i = start; i < end; i++) {
+		global_queue = queue_info->txrx_queues[i];
+		hw_ops->clear_vnet_queue_info(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+					      NBL_PAIR_ID_GET_RX(global_queue));
+		hw_ops->clear_vnet_queue_info(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+					      NBL_PAIR_ID_GET_TX(global_queue));
+	}
+}
+
+int nbl_res_queue_init_qid_map_table(struct nbl_resource_mgt *res_mgt,
+				     struct nbl_queue_mgt *queue_mgt,
+				     struct nbl_hw_ops *hw_ops)
+{
+	struct nbl_qid_map_table invalid_qid_map;
+	u16 i;
+
+	queue_mgt->qid_map_ready = 0;
+	queue_mgt->qid_map_select = NBL_MASTER_QID_MAP_TABLE;
+
+	memset(&invalid_qid_map, 0, sizeof(invalid_qid_map));
+	invalid_qid_map.local_qid = 0x1FF;
+	invalid_qid_map.notify_addr_l = 0x7FFFFF;
+	invalid_qid_map.notify_addr_h = 0xFFFFFFFF;
+	invalid_qid_map.global_qid = 0xFFF;
+	invalid_qid_map.ctrlq_flag = 0X1;
+
+	for (i = 0; i < NBL_QID_MAP_TABLE_ENTRIES; i++)
+		queue_mgt->qid_map_table[i] = invalid_qid_map;
+
+	hw_ops->init_qid_map_table(NBL_RES_MGT_TO_HW_PRIV(res_mgt));
+
+	return 0;
+}
+
+static int nbl_res_queue_init_epro_rss_key(struct nbl_resource_mgt *res_mgt,
+					   struct nbl_hw_ops *hw_ops)
+{
+	int ret = 0;
+
+	ret = hw_ops->init_epro_rss_key(NBL_RES_MGT_TO_HW_PRIV(res_mgt));
+	return ret;
+}
+
+static int nbl_res_queue_init_epro_vpt_table(struct nbl_resource_mgt *res_mgt,
+					     u16 func_id)
+{
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+
+	void *p = NBL_RES_MGT_TO_HW_PRIV(res_mgt);
+	int pfid, vfid;
+	u16 vsi_id;
+	u16 i;
+
+	vsi_id = nbl_res_func_id_to_vsi_id(res_mgt, func_id,
+					   NBL_VSI_SERV_PF_DATA_TYPE);
+	nbl_res_func_id_to_pfvfid(res_mgt, func_id, &pfid, &vfid);
+
+	/* init pf vsi */
+	for (i = NBL_VSI_SERV_PF_DATA_TYPE;
+		i <= NBL_VSI_SERV_PF_DATA_TYPE; i++) {
+		vsi_id = nbl_res_func_id_to_vsi_id(res_mgt, func_id, i);
+		hw_ops->init_epro_vpt_tbl(p, vsi_id);
+	}
+
+	return 0;
+}
+
+static int
+nbl_res_queue_init_ipro_dn_sport_tbl(struct nbl_resource_mgt *res_mgt,
+				     u16 func_id, u16 bmode, bool binit)
+
+{
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+
+	void *p = NBL_RES_MGT_TO_HW_PRIV(res_mgt);
+	int pfid, vfid;
+	u16 eth_id, vsi_id;
+	int i;
+
+	vsi_id = nbl_res_func_id_to_vsi_id(res_mgt, func_id,
+					   NBL_VSI_SERV_PF_DATA_TYPE);
+	nbl_res_func_id_to_pfvfid(res_mgt, func_id, &pfid, &vfid);
+
+	eth_id = nbl_res_vsi_id_to_eth_id(res_mgt, vsi_id);
+
+	for (i = 0; i < NBL_VSI_MAX; i++)
+		hw_ops->cfg_ipro_dn_sport_tbl(p, vsi_id + i, eth_id,
+						      bmode, binit);
+	return 0;
+}
+
+static int nbl_res_queue_init_rss(struct nbl_resource_mgt *res_mgt,
+				  struct nbl_queue_mgt *queue_mgt,
+				  struct nbl_hw_ops *hw_ops)
+{
+	return nbl_res_queue_init_epro_rss_key(res_mgt, hw_ops);
+}
+
+static int nbl_res_queue_alloc_txrx_queues(void *priv, u16 vsi_id,
+					   u16 queue_num)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	u64 notify_addr;
+	u16 func_id = nbl_res_vsi_id_to_func_id(res_mgt, vsi_id);
+	int ret = 0;
+
+	notify_addr = nbl_res_get_func_bar_base_addr(res_mgt, func_id);
+
+	ret = nbl_res_queue_setup_queue_info(res_mgt, func_id, queue_num);
+	if (ret)
+		goto setup_queue_info_fail;
+
+	ret = nbl_res_queue_setup_qid_map_table_leonis(res_mgt, func_id,
+						       notify_addr);
+	if (ret)
+		goto setup_qid_map_fail;
+
+	return 0;
+
+setup_qid_map_fail:
+	nbl_res_queue_remove_queue_info(res_mgt, func_id);
+setup_queue_info_fail:
+	return ret;
+}
+
+static void nbl_res_queue_free_txrx_queues(void *priv, u16 vsi_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	u16 func_id = nbl_res_vsi_id_to_func_id(res_mgt, vsi_id);
+
+	nbl_res_queue_remove_qid_map_table_leonis(res_mgt, func_id);
+	nbl_res_queue_remove_queue_info(res_mgt, func_id);
+}
+
+static int nbl_res_queue_setup_queue(void *priv,
+				     struct nbl_txrx_queue_param *param,
+				     bool is_tx)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_queue_cfg_param cfg_param = { 0 };
+	u16 func_id = nbl_res_vsi_id_to_func_id(res_mgt, param->vsi_id);
+
+	nbl_res_queue_setup_queue_cfg(NBL_RES_MGT_TO_QUEUE_MGT(res_mgt),
+				      &cfg_param, param, is_tx, func_id);
+	nbl_res_queue_setup_hw_dq(res_mgt, &cfg_param, func_id, param->vsi_id);
+	return 0;
+}
+
+static void nbl_res_queue_remove_all_queues(void *priv, u16 vsi_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	u16 func_id = nbl_res_vsi_id_to_func_id(res_mgt, vsi_id);
+	struct nbl_queue_vsi_info *vsi_info = NULL;
+
+	vsi_info = nbl_res_queue_get_vsi_info(res_mgt, vsi_id);
+	if (!vsi_info)
+		return;
+
+	nbl_res_queue_remove_all_hw_dq(res_mgt, func_id, vsi_info);
+}
+
+static int nbl_res_queue_register_vsi2q(void *priv, u16 vsi_index, u16 vsi_id,
+					u16 queue_offset, u16 queue_num)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_queue_info *queue_info = NULL;
+	struct nbl_queue_vsi_info *vsi_info = NULL;
+	u16 func_id;
+
+	func_id = nbl_res_vsi_id_to_func_id(res_mgt, vsi_id);
+	queue_info = &queue_mgt->queue_info[func_id];
+	vsi_info = &queue_info->vsi_info[vsi_index];
+
+	memset(vsi_info, 0, sizeof(*vsi_info));
+	vsi_info->vld = 1;
+	vsi_info->vsi_index = vsi_index;
+	vsi_info->vsi_id = vsi_id;
+	vsi_info->queue_offset = queue_offset;
+	vsi_info->queue_num = queue_num;
+	vsi_info->net_id =
+		nbl_res_queue_get_net_id(func_id, vsi_info->vsi_index);
+
+	return 0;
+}
+
+static int nbl_res_queue_cfg_dsch(void *priv, u16 vsi_id, bool vld)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	u16 func_id = nbl_res_vsi_id_to_func_id(res_mgt, vsi_id);
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_queue_info *queue_info = &queue_mgt->queue_info[func_id];
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	struct nbl_queue_vsi_info *vsi_info;
+	/* group_id is same with eth_id */
+	u16 group_id = nbl_res_vsi_id_to_eth_id(res_mgt, vsi_id);
+	void *p = NBL_RES_MGT_TO_HW_PRIV(res_mgt);
+	u16 start = 0, end = 0;
+	int i, ret = 0;
+
+	vsi_info = nbl_res_queue_get_vsi_info(res_mgt, vsi_id);
+	if (!vsi_info)
+		return -ENOENT;
+
+	start = vsi_info->queue_offset;
+	end = vsi_info->queue_num + vsi_info->queue_offset;
+
+	/* When setting up, g2p -> n2g -> q2tc; when down, q2tc -> n2g -> g2p */
+	if (!vld) {
+		hw_ops->deactive_shaping(p,
+					 vsi_info->net_id);
+		for (i = start; i < end; i++)
+			hw_ops->cfg_q2tc_netid(p,
+					       queue_info->txrx_queues[i],
+					       vsi_info->net_id, vld);
+		nbl_res_queue_update_netid_refnum(queue_mgt, vsi_info->net_id,
+						  false);
+	}
+
+	if (!nbl_res_queue_get_netid_refnum(queue_mgt, vsi_info->net_id)) {
+		ret = hw_ops->cfg_dsch_net_to_group(p, vsi_info->net_id,
+						    group_id, vld);
+		if (ret)
+			return ret;
+	}
+
+	if (vld) {
+		for (i = start; i < end; i++)
+			hw_ops->cfg_q2tc_netid(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+					       queue_info->txrx_queues[i],
+					       vsi_info->net_id, vld);
+		hw_ops->active_shaping(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+				       vsi_info->net_id);
+		nbl_res_queue_update_netid_refnum(queue_mgt, vsi_info->net_id,
+						  true);
+	}
+
+	return 0;
+}
+
+static int nbl_res_queue_setup_cqs(void *priv, u16 vsi_id, u16 real_qps,
+				   bool rss_indir_set)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_queue_info *queue_info;
+	struct nbl_queue_vsi_info *vsi_info = NULL;
+	void *p = NBL_RES_MGT_TO_HW_PRIV(res_mgt);
+	void *q_list;
+	u16 func_id;
+
+	func_id = nbl_res_vsi_id_to_func_id(res_mgt, vsi_id);
+	queue_info = &queue_mgt->queue_info[func_id];
+
+	vsi_info = nbl_res_queue_get_vsi_info(res_mgt, vsi_id);
+	if (!vsi_info)
+		return -ENOENT;
+
+	if (real_qps == vsi_info->curr_qps)
+		return 0;
+
+	if (real_qps && rss_indir_set) {
+		q_list = queue_info->txrx_queues + vsi_info->queue_offset;
+		hw_ops->cfg_epro_rss_ret(p, vsi_info->rss_ret_base,
+					 vsi_info->rss_entry_size, real_qps,
+					 q_list, NULL);
+	}
+
+	if (!vsi_info->curr_qps)
+		hw_ops->set_epro_rss_pt(p, vsi_id, vsi_info->rss_ret_base,
+					vsi_info->rss_entry_size);
+
+	vsi_info->curr_qps = real_qps;
+	vsi_info->curr_qps_static = real_qps;
+	return 0;
+}
+
+static void nbl_res_queue_remove_cqs(void *priv, u16 vsi_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	struct nbl_queue_vsi_info *vsi_info = NULL;
+
+	vsi_info = nbl_res_queue_get_vsi_info(res_mgt, vsi_id);
+	if (!vsi_info)
+		return;
+
+	hw_ops->clear_epro_rss_pt(NBL_RES_MGT_TO_HW_PRIV(res_mgt), vsi_id);
+
+	vsi_info->curr_qps = 0;
+}
+
+static int nbl_res_queue_init_switch(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	int i;
+
+	for_each_set_bit(i, eth_info->eth_bitmap, NBL_MAX_ETHERNET)
+		hw_ops->setup_queue_switch(NBL_RES_MGT_TO_HW_PRIV(res_mgt), i);
+
+	return 0;
+}
+
+static int nbl_res_queue_init(void *priv)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_queue_mgt *queue_mgt;
+	struct nbl_hw_ops *hw_ops;
+	int i, ret = 0;
+
+	if (!res_mgt)
+		return -EINVAL;
+
+	queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+
+	ret = nbl_res_queue_init_qid_map_table(res_mgt, queue_mgt, hw_ops);
+	if (ret)
+		goto init_queue_fail;
+
+	ret = nbl_res_queue_init_rss(res_mgt, queue_mgt, hw_ops);
+	if (ret)
+		goto init_queue_fail;
+
+	ret = nbl_res_queue_init_switch(res_mgt);
+	if (ret)
+		goto init_queue_fail;
+
+	for (i = 0; i < NBL_RES_MGT_TO_PF_NUM(res_mgt); i++) {
+		nbl_res_queue_init_epro_vpt_table(res_mgt, i);
+		nbl_res_queue_init_ipro_dn_sport_tbl(res_mgt, i,
+						     BRIDGE_MODE_VEB, true);
+	}
+	hw_ops->init_pfc(NBL_RES_MGT_TO_HW_PRIV(res_mgt), NBL_MAX_ETHERNET);
+
+	return 0;
+
+init_queue_fail:
+	return ret;
+}
+
+static u16 nbl_res_queue_get_vsi_global_qid(void *priv, u16 vsi_id,
+					    u16 local_qid)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	u16 func_id = nbl_res_vsi_id_to_func_id(res_mgt, vsi_id);
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_queue_info *queue_info = &queue_mgt->queue_info[func_id];
+
+	if (!queue_info->num_txrx_queues)
+		return 0xffff;
+
+	return queue_info->txrx_queues[local_qid];
+}
+
+static void nbl_res_queue_get_rxfh_indir_size(void *priv, u16 vsi_id,
+					      u32 *rxfh_indir_size)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_queue_vsi_info *vsi_info = NULL;
+
+	vsi_info = nbl_res_queue_get_vsi_info(res_mgt, vsi_id);
+	if (!vsi_info)
+		return;
+
+	*rxfh_indir_size = NBL_EPRO_RSS_ENTRY_SIZE_UNIT
+			   << vsi_info->rss_entry_size;
+}
+
+static int nbl_res_queue_set_rxfh_indir(void *priv, u16 vsi_id,
+					const u32 *indir, u32 indir_size)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	struct nbl_queue_vsi_info *vsi_info = NULL;
+	u32 *rss_ret;
+	u16 local_id;
+	int i = 0;
+
+	vsi_info = nbl_res_queue_get_vsi_info(res_mgt, vsi_id);
+	if (!vsi_info)
+		return -ENOENT;
+
+	if (indir) {
+		rss_ret = kcalloc(indir_size, sizeof(indir[0]), GFP_KERNEL);
+		if (!rss_ret)
+			return -ENOMEM;
+		/* local queue to global queue */
+		for (i = 0; i < indir_size; i++) {
+			local_id = vsi_info->queue_offset + indir[i];
+			rss_ret[i] =
+				nbl_res_queue_get_vsi_global_qid(res_mgt,
+								 vsi_id,
+								 local_id);
+		}
+		hw_ops->cfg_epro_rss_ret(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+					 vsi_info->rss_ret_base,
+					 vsi_info->rss_entry_size, 0, NULL,
+					 rss_ret);
+		kfree(rss_ret);
+	}
+
+	if (!vsi_info->curr_qps)
+		hw_ops->set_epro_rss_pt(NBL_RES_MGT_TO_HW_PRIV(res_mgt), vsi_id,
+					vsi_info->rss_ret_base,
+					vsi_info->rss_entry_size);
+
+	return 0;
+}
+
+static void nbl_res_queue_clear_queues(void *priv, u16 vsi_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	u16 func_id = nbl_res_vsi_id_to_func_id(res_mgt, vsi_id);
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_queue_info *queue_info = &queue_mgt->queue_info[func_id];
+
+	nbl_res_queue_remove_rss(priv, vsi_id);
+	nbl_res_queue_remove_q2vsi(priv, vsi_id);
+	if (!queue_info->num_txrx_queues)
+		return;
+	nbl_res_queue_remove_cqs(res_mgt, vsi_id);
+	nbl_res_queue_cfg_dsch(res_mgt, vsi_id, false);
+	nbl_res_queue_remove_all_queues(res_mgt, vsi_id);
+	nbl_res_queue_free_txrx_queues(res_mgt, vsi_id);
+}
+
+/* NBL_QUEUE_SET_OPS(ops_name, func)
+ *
+ * Use X Macros to reduce setup and remove codes.
+ */
+#define NBL_QUEUE_OPS_TBL						\
+do {									\
+	NBL_QUEUE_SET_OPS(alloc_txrx_queues,				\
+			  nbl_res_queue_alloc_txrx_queues);		\
+	NBL_QUEUE_SET_OPS(free_txrx_queues,				\
+			  nbl_res_queue_free_txrx_queues);		\
+	NBL_QUEUE_SET_OPS(register_vsi2q, nbl_res_queue_register_vsi2q);\
+	NBL_QUEUE_SET_OPS(setup_q2vsi, nbl_res_queue_setup_q2vsi);	\
+	NBL_QUEUE_SET_OPS(remove_q2vsi, nbl_res_queue_remove_q2vsi);	\
+	NBL_QUEUE_SET_OPS(setup_rss, nbl_res_queue_setup_rss);		\
+	NBL_QUEUE_SET_OPS(remove_rss, nbl_res_queue_remove_rss);	\
+	NBL_QUEUE_SET_OPS(setup_queue, nbl_res_queue_setup_queue);	\
+	NBL_QUEUE_SET_OPS(remove_all_queues, nbl_res_queue_remove_all_queues);\
+	NBL_QUEUE_SET_OPS(cfg_dsch, nbl_res_queue_cfg_dsch);		\
+	NBL_QUEUE_SET_OPS(setup_cqs, nbl_res_queue_setup_cqs);		\
+	NBL_QUEUE_SET_OPS(remove_cqs, nbl_res_queue_remove_cqs);	\
+	NBL_QUEUE_SET_OPS(queue_init, nbl_res_queue_init);		\
+	NBL_QUEUE_SET_OPS(get_rxfh_indir_size,				\
+			  nbl_res_queue_get_rxfh_indir_size);		\
+	NBL_QUEUE_SET_OPS(set_rxfh_indir, nbl_res_queue_set_rxfh_indir);\
+	NBL_QUEUE_SET_OPS(clear_queues, nbl_res_queue_clear_queues);	\
+} while (0)
+
+int nbl_queue_setup_ops_leonis(struct nbl_resource_ops *res_ops)
+{
+#define NBL_QUEUE_SET_OPS(name, func)			\
+	do {						\
+		res_ops->NBL_NAME(name) = func;		\
+		;					\
+	} while (0)
+	NBL_QUEUE_OPS_TBL;
+#undef  NBL_QUEUE_SET_OPS
+
+	return 0;
+}
+
+void nbl_queue_remove_ops_leonis(struct nbl_resource_ops *res_ops)
+{
+#define NBL_QUEUE_SET_OPS(name, func)			\
+do {							\
+	(void)(func);					\
+	res_ops->NBL_NAME(name) = NULL; ;		\
+} while (0)
+	NBL_QUEUE_OPS_TBL;
+#undef  NBL_QUEUE_SET_OPS
+}
+
+void nbl_queue_mgt_init_leonis(struct nbl_queue_mgt *queue_mgt)
+{
+	queue_mgt->qid_map_select = NBL_MASTER_QID_MAP_TABLE;
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_queue_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_queue_leonis.h
new file mode 100644
index 000000000000..396df65d7088
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_queue_leonis.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_QUEUE_LEONIS_H_
+#define _NBL_QUEUE_LEONIS_H_
+
+#include "nbl_resource.h"
+
+#define NBL_QID_MAP_NOTIFY_ADDR_SHIFT		(9)
+#define NBL_QID_MAP_NOTIFY_ADDR_LOW_PART_LEN	(23)
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
index 16e5941aaf76..032131d1b9fa 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
@@ -171,6 +171,10 @@ static struct nbl_resource_ops res_ops = {
 };
 
 static struct nbl_res_product_ops product_ops = {
+	.queue_mgt_init = nbl_queue_mgt_init_leonis,
+	.setup_qid_map_table = nbl_res_queue_setup_qid_map_table_leonis,
+	.remove_qid_map_table = nbl_res_queue_remove_qid_map_table_leonis,
+	.init_qid_map_table = nbl_res_queue_init_qid_map_table,
 };
 
 static bool is_ops_inited;
@@ -229,6 +233,9 @@ static int nbl_res_setup_ops(struct device *dev,
 		return -ENOMEM;
 
 	if (!is_ops_inited) {
+		ret = nbl_queue_setup_ops_leonis(&res_ops);
+		if (ret)
+			goto setup_fail;
 		ret = nbl_intr_setup_ops(&res_ops);
 		if (ret)
 			goto setup_fail;
@@ -430,7 +437,9 @@ static void nbl_res_stop(struct nbl_resource_mgt_leonis *res_mgt_leonis)
 {
 	struct nbl_resource_mgt *res_mgt = &res_mgt_leonis->res_mgt;
 
+	nbl_queue_mgt_stop(res_mgt);
 	nbl_intr_mgt_stop(res_mgt);
+
 	nbl_res_ctrl_dev_remove_vsi_info(res_mgt);
 	nbl_res_ctrl_dev_remove_eth_info(res_mgt);
 	nbl_res_ctrl_dev_sriov_info_remove(res_mgt);
@@ -470,6 +479,10 @@ static int nbl_res_start(struct nbl_resource_mgt_leonis *res_mgt_leonis,
 		if (ret)
 			goto start_fail;
 
+		ret = nbl_queue_mgt_start(res_mgt);
+		if (ret)
+			goto start_fail;
+
 		ret = nbl_intr_mgt_start(res_mgt);
 		if (ret)
 			goto start_fail;
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
index a0a25a2b71ee..3763c33db00f 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
@@ -10,4 +10,16 @@
 #include "nbl_resource.h"
 
 #define NBL_MAX_PF_LEONIS			8
+
+int nbl_queue_setup_ops_leonis(struct nbl_resource_ops *resource_ops);
+void nbl_queue_remove_ops_leonis(struct nbl_resource_ops *resource_ops);
+
+void nbl_queue_mgt_init_leonis(struct nbl_queue_mgt *queue_mgt);
+int nbl_res_queue_setup_qid_map_table_leonis(struct nbl_resource_mgt *res_mgt,
+					     u16 func_id, u64 notify_addr);
+void nbl_res_queue_remove_qid_map_table_leonis(struct nbl_resource_mgt *res_mgt,
+					       u16 func_id);
+int nbl_res_queue_init_qid_map_table(struct nbl_resource_mgt *res_mgt,
+				     struct nbl_queue_mgt *queue_mgt,
+				     struct nbl_hw_ops *hw_ops);
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_queue.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_queue.c
new file mode 100644
index 000000000000..35c2e34b30b6
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_queue.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#include "nbl_queue.h"
+
+/* Structure starts here, adding an op should not modify anything below */
+static int nbl_queue_setup_mgt(struct device *dev,
+			       struct nbl_queue_mgt **queue_mgt)
+{
+	*queue_mgt =
+		devm_kzalloc(dev, sizeof(struct nbl_queue_mgt), GFP_KERNEL);
+	if (!*queue_mgt)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void nbl_queue_remove_mgt(struct device *dev,
+				 struct nbl_queue_mgt **queue_mgt)
+{
+	devm_kfree(dev, *queue_mgt);
+	*queue_mgt = NULL;
+}
+
+int nbl_queue_mgt_start(struct nbl_resource_mgt *res_mgt)
+{
+	struct device *dev;
+	struct nbl_queue_mgt **queue_mgt;
+	struct nbl_res_product_ops *product_ops =
+		NBL_RES_MGT_TO_PROD_OPS(res_mgt);
+	int ret = 0;
+
+	dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	queue_mgt = &NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+
+	ret = nbl_queue_setup_mgt(dev, queue_mgt);
+	if (ret)
+		return ret;
+
+	NBL_OPS_CALL(product_ops->queue_mgt_init, (*queue_mgt));
+
+	return 0;
+}
+
+void nbl_queue_mgt_stop(struct nbl_resource_mgt *res_mgt)
+{
+	struct device *dev;
+	struct nbl_queue_mgt **queue_mgt;
+
+	dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	queue_mgt = &NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+
+	if (!(*queue_mgt))
+		return;
+
+	nbl_queue_remove_mgt(dev, queue_mgt);
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_queue.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_queue.h
new file mode 100644
index 000000000000..94a5b27f1bcb
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_queue.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_QUEUE_H_
+#define _NBL_QUEUE_H_
+
+#include "nbl_resource.h"
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
index b8653e0039d7..2195e4084040 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
@@ -422,6 +422,10 @@ u8 nbl_res_vsi_id_to_eth_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id);
 int nbl_intr_mgt_start(struct nbl_resource_mgt *res_mgt);
 void nbl_intr_mgt_stop(struct nbl_resource_mgt *res_mgt);
 int nbl_intr_setup_ops(struct nbl_resource_ops *resource_ops);
+
+int nbl_queue_mgt_start(struct nbl_resource_mgt *res_mgt);
+void nbl_queue_mgt_stop(struct nbl_resource_mgt *res_mgt);
+
 void nbl_res_pf_dev_vsi_type_to_hw_vsi_type(u16 src_type,
 					    enum nbl_vsi_serv_type *dst_type);
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
index 977f2bba3d65..0252082c55dc 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
@@ -10,6 +10,54 @@
 #include "nbl_include.h"
 
 struct nbl_hw_ops {
+	int (*init_chip_module)(void *priv, u8 eth_speed, u8 eth_num);
+	void (*deinit_chip_module)(void *priv);
+	int (*init_qid_map_table)(void *priv);
+	int (*set_qid_map_table)(void *priv, void *data, int qid_map_select);
+	int (*set_qid_map_ready)(void *priv, bool ready);
+	int (*cfg_ipro_queue_tbl)(void *priv, u16 queue_id, u16 vsi_id,
+				  u8 enable);
+	int (*cfg_ipro_dn_sport_tbl)(void *priv, u16 vsi_id, u16 dst_eth_id,
+				     u16 bmode, bool binit);
+	int (*set_vnet_queue_info)(void *priv,
+				   struct nbl_vnet_queue_info_param *param,
+				   u16 queue_id);
+	int (*clear_vnet_queue_info)(void *priv, u16 queue_id);
+	int (*reset_dvn_cfg)(void *priv, u16 queue_id);
+	int (*reset_uvn_cfg)(void *priv, u16 queue_id);
+	int (*restore_dvn_context)(void *priv, u16 queue_id, u16 split,
+				   u16 last_avail_index);
+	int (*restore_uvn_context)(void *priv, u16 queue_id, u16 split,
+				   u16 last_avail_index);
+
+	int (*cfg_tx_queue)(void *priv, void *data, u16 queue_id);
+	int (*cfg_rx_queue)(void *priv, void *data, u16 queue_id);
+
+	int (*cfg_q2tc_netid)(void *priv, u16 queue_id, u16 netid, u16 vld);
+
+	void (*active_shaping)(void *priv, u16 func_id);
+	void (*deactive_shaping)(void *priv, u16 func_id);
+
+	int (*cfg_dsch_net_to_group)(void *priv, u16 func_id, u16 group_id,
+				     u16 vld);
+	int (*init_epro_rss_key)(void *priv);
+
+	int (*init_epro_vpt_tbl)(void *priv, u16 vsi_id);
+	int (*cfg_epro_rss_ret)(void *priv, u32 index, u8 size_type, u32 q_num,
+				u16 *queue_list, const u32 *indir);
+	int (*set_epro_rss_pt)(void *priv, u16 vsi_id, u16 rss_ret_base,
+			       u16 rss_entry_size);
+	int (*clear_epro_rss_pt)(void *priv, u16 vsi_id);
+	int (*disable_dvn)(void *priv, u16 queue_id);
+	int (*disable_uvn)(void *priv, u16 queue_id);
+	int (*lso_dsch_drain)(void *priv, u16 queue_id);
+	int (*rsc_cache_drain)(void *priv, u16 queue_id);
+	u16 (*save_dvn_ctx)(void *priv, u16 queue_id, u16 split);
+	u16 (*save_uvn_ctx)(void *priv, u16 queue_id, u16 split,
+			    u16 queue_size);
+	void (*setup_queue_switch)(void *priv, u16 eth_id);
+	void (*init_pfc)(void *priv, u8 ether_ports);
+	void (*set_promisc_mode)(void *priv, u16 vsi_id, u16 eth_id, u16 mode);
 	void (*configure_msix_map)(void *priv, u16 func_id, bool valid,
 				   dma_addr_t dma_addr, u8 bus, u8 devid,
 				   u8 function);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
index 9bc90fe824bd..1379567fb847 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
@@ -16,6 +16,9 @@ struct nbl_resource_pt_ops {
 };
 
 struct nbl_resource_ops {
+	int (*init_chip_module)(void *priv);
+	void (*deinit_chip_module)(void *priv);
+	int (*queue_init)(void *priv);
 	int (*configure_msix_map)(void *priv, u16 func_id, u16 num_net_msix,
 				  u16 num_others_msix, bool net_msix_mask_en);
 	int (*destroy_msix_map)(void *priv, u16 func_id);
@@ -27,11 +30,35 @@ struct nbl_resource_ops {
 			    struct nbl_register_net_param *register_param,
 			    struct nbl_register_net_result *register_result);
 	int (*unregister_net)(void *priv, u16 func_id);
+	int (*alloc_txrx_queues)(void *priv, u16 vsi_id, u16 queue_num);
+	void (*free_txrx_queues)(void *priv, u16 vsi_id);
+	int (*register_vsi2q)(void *priv, u16 vsi_index, u16 vsi_id,
+			      u16 queue_offset, u16 queue_num);
+	int (*setup_q2vsi)(void *priv, u16 vsi_id);
+	void (*remove_q2vsi)(void *priv, u16 vsi_id);
+	int (*setup_rss)(void *priv, u16 vsi_id);
+	void (*remove_rss)(void *priv, u16 vsi_id);
+	int (*setup_queue)(void *priv, struct nbl_txrx_queue_param *param,
+			   bool is_tx);
+	void (*remove_all_queues)(void *priv, u16 vsi_id);
+	int (*cfg_dsch)(void *priv, u16 vsi_id, bool vld);
+	int (*setup_cqs)(void *priv, u16 vsi_id, u16 real_qps,
+			 bool rss_indir_set);
+	void (*remove_cqs)(void *priv, u16 vsi_id);
+	void (*clear_queues)(void *priv, u16 vsi_id);
+
+	u16 (*get_global_queue_id)(void *priv, u16 vsi_id, u16 local_queue_id);
+
 	u8 __iomem *(*get_msix_irq_enable_info)(void *priv, u16 global_vec_id,
 						u32 *irq_data);
 	u16 (*get_vsi_id)(void *priv, u16 func_id, u16 type);
 	void (*get_eth_id)(void *priv, u16 vsi_id, u8 *eth_mode, u8 *eth_id,
 			   u8 *logic_eth_id);
+	int (*set_promisc_mode)(void *priv, u16 vsi_id, u16 mode);
+	void (*get_rxfh_indir_size)(void *priv, u16 vsi_id,
+				    u32 *rxfh_indir_size);
+	int (*set_rxfh_indir)(void *priv, u16 vsi_id, const u32 *indir,
+			      u32 indir_size);
 };
 
 struct nbl_resource_ops_tbl {
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index 651100e59f0a..d4e18f2a2931 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -87,6 +87,15 @@ struct nbl_qid_map_param {
 	u16 len;
 };
 
+struct nbl_vnet_queue_info_param {
+	u32 function_id;
+	u32 device_id;
+	u32 bus_id;
+	u32 msix_idx;
+	u32 msix_idx_valid;
+	u32 valid;
+};
+
 struct nbl_queue_cfg_param {
 	/* queue args*/
 	u64 desc;
@@ -180,6 +189,25 @@ enum nbl_fw_port_speed {
 	NBL_FW_PORT_SPEED_100G,
 };
 
+#define NBL_OPS_CALL(func, para)		\
+do {						\
+	typeof(func) _func = (func);		\
+	if (_func)				\
+		_func para;			\
+} while (0)
+
+#define NBL_OPS_CALL_RET(func, para)		\
+({						\
+	typeof(func) _func = (func);		\
+	_func ? _func para : 0;			\
+})
+
+#define NBL_OPS_CALL_RET_PTR(func, para)	\
+({						\
+	typeof(func) _func = (func);		\
+	_func ? _func para : NULL;		\
+})
+
 enum {
 	NBL_NETIF_F_SG_BIT,			/* Scatter/gather IO. */
 	NBL_NETIF_F_IP_CSUM_BIT,		/* csum TCP/UDP over IPv4 */
-- 
2.47.3


