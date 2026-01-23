Return-Path: <netdev+bounces-252579-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFvJFxTNcmlgpgAAu9opvQ
	(envelope-from <netdev+bounces-252579-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:21:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1546F012
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7E5C3007221
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 01:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A109C36682D;
	Fri, 23 Jan 2026 01:19:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-27.us.a.mail.aliyun.com (out198-27.us.a.mail.aliyun.com [47.90.198.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3519361DD6;
	Fri, 23 Jan 2026 01:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769131159; cv=none; b=houk2LpVEm6DQak0i7r3SvSaG07zc68KfwJEqK22s+EZLtF4Cp4baBWfUI90FJG7yi43U7Az7hykUxflARgey1tJPOGjQVOKSxkl0jT/ww4n02RNfckz/3mFBZUh0TyPZH3A8+1gXV/uFiPD3uIQaD7cwVywG/mioDp5TrCrR58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769131159; c=relaxed/simple;
	bh=G5qIzNcNC5d2pqy2RrjkhhKn1sfutOQMJKnqcdA9OgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p086ko6d5JCdFe2Z5s7d0UvIHzCbzu2BGjiQxJF5dZf+OkhoRPJtQyAmqlgAWkUVua7BxMCIChia5SZexFVs6HdUHB8LDjH9fAqlA6WOcCovaSb8ebIAJHX31L5K7HHni0735cZ7TZwfMMuKFwwknHFQvZcxCeCPzdGj1IHpwEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.gDSYVyk_1769131122 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 23 Jan 2026 09:18:43 +0800
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
Subject: [PATCH v3 net-next 05/15] net/nebula-matrix: add resource layer common part implementation
Date: Fri, 23 Jan 2026 09:17:42 +0800
Message-ID: <20260123011804.31263-6-illusion.wang@nebula-matrix.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252579-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.990];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	DBL_BLOCKED_OPENRESOLVER(0.00)[illusion.wang:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nebula-matrix.com:mid,nebula-matrix.com:email]
X-Rspamd-Queue-Id: 7F1546F012
X-Rspamd-Action: no action

The Resource layer processes the entries/data of various modules within
the processing chip to accomplish specific entry management operations,
this describes the module business capabilities of the chip and the data
it manages.
The resource layer comprises the following sub-modules: common,
interrupt, txrx, queue, and vsi.

This patch provides the common part, including the conversion
relationships among vsi_id, func_id, eth_id, and pf_id. These
relationships may be utilized in the upper layer or the resource layer.
Additionally, it offers the register_net/unregister_net interfaces.

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   1 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  |  84 ++++
 .../nbl_hw_leonis/nbl_resource_leonis.c       | 376 ++++++++++++++++++
 .../nbl_hw_leonis/nbl_resource_leonis.h       |   1 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.c   | 299 ++++++++++++++
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   | 101 +++++
 .../nbl/nbl_include/nbl_def_common.h          |  17 +
 .../nbl/nbl_include/nbl_def_resource.h        |   7 +
 .../nbl/nbl_include/nbl_include.h             |  44 ++
 9 files changed, 930 insertions(+)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index db646a54877b..8bf3ca9c6862 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -9,6 +9,7 @@ nbl_core-objs +=       nbl_common/nbl_common.o \
 				nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
 				nbl_hw/nbl_hw_leonis/nbl_resource_leonis.o \
 				nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.o \
+				nbl_hw/nbl_resource.o \
 				nbl_core/nbl_dispatch.o \
 				nbl_core/nbl_service.o \
 				nbl_core/nbl_dev.o \
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
index 23a2111104c5..63d01f790af8 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -5,6 +5,19 @@
  */
 
 #include "nbl_hw_leonis.h"
+static u32 nbl_hw_get_quirks(void *priv)
+{
+	struct nbl_hw_mgt *hw_mgt = priv;
+	u32 quirks;
+
+	nbl_hw_read_mbx_regs(hw_mgt, NBL_LEONIS_QUIRKS_OFFSET, (u8 *)&quirks,
+			     sizeof(u32));
+
+	if (quirks == NBL_LEONIS_ILLEGAL_REG_VALUE)
+		return 0;
+
+	return quirks;
+}
 
 static void nbl_hw_update_mailbox_queue_tail_ptr(void *priv, u16 tail_ptr,
 						 u8 txrx)
@@ -110,6 +123,37 @@ static u32 nbl_hw_get_host_pf_mask(void *priv)
 	return data;
 }
 
+static u32 nbl_hw_get_real_bus(void *priv)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	u32 data;
+
+	data = nbl_hw_rd32(hw_mgt, NBL_PCIE_HOST_TL_CFG_BUSDEV);
+	return data >> 5;
+}
+
+static u64 nbl_hw_get_pf_bar_addr(void *priv, u16 func_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	u64 addr;
+	u32 val;
+	u32 selector;
+
+	selector = NBL_LB_PF_CONFIGSPACE_SELECT_OFFSET +
+		   func_id * NBL_LB_PF_CONFIGSPACE_SELECT_STRIDE;
+	nbl_hw_wr32(hw_mgt, NBL_LB_PCIEX16_TOP_AHB, selector);
+
+	val = nbl_hw_rd32(hw_mgt,
+			  NBL_LB_PF_CONFIGSPACE_BASE_ADDR + PCI_BASE_ADDRESS_0);
+	addr = (u64)(val & PCI_BASE_ADDRESS_MEM_MASK);
+
+	val = nbl_hw_rd32(hw_mgt, NBL_LB_PF_CONFIGSPACE_BASE_ADDR +
+					  PCI_BASE_ADDRESS_0 + 4);
+	addr |= ((u64)val << 32);
+
+	return addr;
+}
+
 static void nbl_hw_cfg_mailbox_qinfo(void *priv, u16 func_id, u16 bus,
 				     u16 devid, u16 function)
 {
@@ -125,6 +169,39 @@ static void nbl_hw_cfg_mailbox_qinfo(void *priv, u16 func_id, u16 bus,
 		       (u8 *)&mb_qinfo_map, sizeof(mb_qinfo_map));
 }
 
+static void nbl_hw_get_board_info(void *priv,
+				  struct nbl_board_port_info *board_info)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	union nbl_fw_board_cfg_dw3 dw3 = { .info = { 0 } };
+
+	nbl_hw_read_mbx_regs(hw_mgt, NBL_FW_BOARD_DW3_OFFSET, (u8 *)&dw3,
+			     sizeof(dw3));
+	board_info->eth_num = dw3.info.port_num;
+	board_info->eth_speed = dw3.info.port_speed;
+	board_info->p4_version = dw3.info.p4_version;
+}
+
+static u32 nbl_hw_get_fw_eth_num(void *priv)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	union nbl_fw_board_cfg_dw3 dw3 = { .info = { 0 } };
+
+	nbl_hw_read_mbx_regs(hw_mgt, NBL_FW_BOARD_DW3_OFFSET, (u8 *)&dw3,
+			     sizeof(dw3));
+	return dw3.info.port_num;
+}
+
+static u32 nbl_hw_get_fw_eth_map(void *priv)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	union nbl_fw_board_cfg_dw6 dw6 = { .info = { 0 } };
+
+	nbl_hw_read_mbx_regs(hw_mgt, NBL_FW_BOARD_DW6_OFFSET, (u8 *)&dw6,
+			     sizeof(dw6));
+	return dw6.info.eth_bitmap;
+}
+
 static struct nbl_hw_ops hw_ops = {
 	.update_mailbox_queue_tail_ptr = nbl_hw_update_mailbox_queue_tail_ptr,
 	.config_mailbox_rxq = nbl_hw_config_mailbox_rxq,
@@ -134,8 +211,15 @@ static struct nbl_hw_ops hw_ops = {
 	.get_mailbox_rx_tail_ptr = nbl_hw_get_mailbox_rx_tail_ptr,
 	.check_mailbox_dma_err = nbl_hw_check_mailbox_dma_err,
 	.get_host_pf_mask = nbl_hw_get_host_pf_mask,
+	.get_real_bus = nbl_hw_get_real_bus,
+	.get_pf_bar_addr = nbl_hw_get_pf_bar_addr,
+
 	.cfg_mailbox_qinfo = nbl_hw_cfg_mailbox_qinfo,
 
+	.get_fw_eth_num = nbl_hw_get_fw_eth_num,
+	.get_fw_eth_map = nbl_hw_get_fw_eth_map,
+	.get_board_info = nbl_hw_get_board_info,
+	.get_quirks = nbl_hw_get_quirks,
 };
 
 /* Structure starts here, adding an op should not modify anything below */
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
index d08ab16ed493..308d675478b6 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
@@ -7,12 +7,167 @@
 #include <linux/if_vlan.h>
 
 #include "nbl_resource_leonis.h"
+static int nbl_res_get_queue_num(void *priv, u16 func_id, u16 *tx_queue_num,
+				 u16 *rx_queue_num);
 
 static void nbl_res_setup_common_ops(struct nbl_resource_mgt *res_mgt)
 {
+	res_mgt->common_ops.get_queue_num = nbl_res_get_queue_num;
+}
+
+static u32 nbl_res_get_pfvf_queue_num(struct nbl_resource_mgt *res_mgt,
+				      int pfid, int vfid)
+{
+	struct nbl_resource_info *res_info = NBL_RES_MGT_TO_RES_INFO(res_mgt);
+	struct nbl_net_ring_num_info *num_info = &res_info->net_ring_num_info;
+	u16 func_id = nbl_res_pfvfid_to_func_id(res_mgt, pfid, vfid);
+	u32 queue_num = 0;
+
+	if (num_info->net_max_qp_num[func_id] != 0)
+		queue_num = num_info->net_max_qp_num[func_id];
+	else
+		queue_num = num_info->pf_def_max_net_qp_num;
+
+	if (queue_num > NBL_MAX_TXRX_QUEUE_PER_FUNC) {
+		nbl_warn(NBL_RES_MGT_TO_COMMON(res_mgt),
+			 "Invalid queue num %u for func %d, use default",
+			 queue_num, func_id);
+		queue_num = NBL_DEFAULT_PF_HW_QUEUE_NUM;
+	}
+
+	return queue_num;
+}
+
+static int nbl_res_get_queue_num(void *priv, u16 func_id, u16 *tx_queue_num,
+				 u16 *rx_queue_num)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)(priv);
+	int pfid, vfid;
+
+	nbl_res_func_id_to_pfvfid(res_mgt, func_id, &pfid, &vfid);
+
+	*tx_queue_num = nbl_res_get_pfvf_queue_num(res_mgt, pfid, vfid);
+	*rx_queue_num = nbl_res_get_pfvf_queue_num(res_mgt, pfid, vfid);
+
+	return 0;
+}
+
+static int
+nbl_res_save_bar_info(struct nbl_resource_mgt *res_mgt, u16 func_id,
+		      struct nbl_register_net_param *register_param)
+{
+	struct device *dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	struct nbl_sriov_info *sriov_info =
+		&NBL_RES_MGT_TO_SRIOV_INFO(res_mgt)[func_id];
+	void *p = NBL_RES_MGT_TO_HW_PRIV(res_mgt);
+	u64 pf_bar_start;
+
+	if (func_id < NBL_RES_MGT_TO_PF_NUM(res_mgt)) {
+		pf_bar_start = hw_ops->get_pf_bar_addr(p, func_id);
+		sriov_info->pf_bar_start = pf_bar_start;
+		dev_info(dev, "sriov_info, pf_bar_start:%llx\n",
+			 sriov_info->pf_bar_start);
+	}
+	return 0;
+}
+
+static u32 nbl_res_get_quirks(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+
+	return hw_ops->get_quirks(NBL_RES_MGT_TO_HW_PRIV(res_mgt));
+}
+
+static int nbl_res_register_net(void *priv, u16 func_id,
+				struct nbl_register_net_param *register_param,
+				struct nbl_register_net_result *register_result)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	netdev_features_t csumo_features = 0;
+	netdev_features_t tso_features = 0;
+	netdev_features_t pf_features = 0;
+	netdev_features_t vlano_features = 0;
+	u16 tx_queue_num, rx_queue_num;
+	u32 quirks;
+	int ret = 0;
+
+	pf_features = NBL_FEATURE(NETIF_F_NTUPLE);
+	register_result->trusted = 1;
+
+	quirks = nbl_res_get_quirks(res_mgt);
+	if (!(quirks & BIT(NBL_QUIRKS_NO_TOE))) {
+		csumo_features = NBL_FEATURE(NETIF_F_RXCSUM) |
+				 NBL_FEATURE(NETIF_F_IP_CSUM) |
+				 NBL_FEATURE(NETIF_F_IPV6_CSUM);
+		tso_features = NBL_FEATURE(NETIF_F_TSO) |
+			       NBL_FEATURE(NETIF_F_TSO6) |
+			       NBL_FEATURE(NETIF_F_GSO_UDP_L4);
+	}
+
+	vlano_features = NBL_FEATURE(NETIF_F_HW_VLAN_CTAG_TX) |
+				 NBL_FEATURE(NETIF_F_HW_VLAN_CTAG_RX) |
+				 NBL_FEATURE(NETIF_F_HW_VLAN_STAG_TX) |
+				 NBL_FEATURE(NETIF_F_HW_VLAN_STAG_RX);
+
+	register_result->hw_features |=
+		pf_features | csumo_features | tso_features | vlano_features |
+		NBL_FEATURE(NETIF_F_SG) | NBL_FEATURE(NETIF_F_RXHASH);
+
+	register_result->features |= register_result->hw_features;
+
+	register_result->vlan_features = register_result->features;
+
+	register_result->max_mtu = NBL_MAX_JUMBO_FRAME_SIZE - NBL_PKT_HDR_PAD;
+
+	register_result->vlan_proto = 0;
+	register_result->vlan_tci = 0;
+	register_result->rate = 0;
+
+	nbl_res_get_queue_num(res_mgt, func_id, &tx_queue_num, &rx_queue_num);
+	register_result->tx_queue_num = tx_queue_num;
+	register_result->rx_queue_num = rx_queue_num;
+	register_result->queue_size = NBL_DEFAULT_DESC_NUM;
+
+	ret = nbl_res_save_bar_info(res_mgt, func_id, register_param);
+	return ret;
+}
+
+static int nbl_res_unregister_net(void *priv, u16 func_id)
+{
+	return 0;
+}
+
+static u16 nbl_res_get_vsi_id(void *priv, u16 func_id, u16 type)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+
+	return nbl_res_func_id_to_vsi_id(res_mgt, func_id, type);
+}
+
+static void nbl_res_get_eth_id(void *priv, u16 vsi_id, u8 *eth_mode, u8 *eth_id,
+			       u8 *logic_eth_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	u16 pf_id = nbl_res_vsi_id_to_pf_id(res_mgt, vsi_id);
+
+	*eth_mode = eth_info->eth_num;
+	if (pf_id < eth_info->eth_num) {
+		*eth_id = eth_info->eth_id[pf_id];
+		*logic_eth_id = pf_id;
+	/* if pf_id > eth_num, use eth_id 0 */
+	} else {
+		*eth_id = eth_info->eth_id[0];
+		*logic_eth_id = 0;
+	}
 }
 
 static struct nbl_resource_ops res_ops = {
+	.register_net = nbl_res_register_net,
+	.unregister_net = nbl_res_unregister_net,
+	.get_vsi_id = nbl_res_get_vsi_id,
+	.get_eth_id = nbl_res_get_eth_id,
 };
 
 static struct nbl_res_product_ops product_ops = {
@@ -76,14 +231,235 @@ static int nbl_res_setup_ops(struct device *dev,
 	return 0;
 }
 
+static int nbl_res_ctrl_dev_setup_eth_info(struct nbl_resource_mgt *res_mgt)
+{
+	struct device *dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	struct nbl_eth_info *eth_info;
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	u32 eth_num = 0;
+	u32 eth_bitmap, eth_id;
+	int i;
+
+	eth_info = devm_kzalloc(dev, sizeof(struct nbl_eth_info), GFP_KERNEL);
+	if (!eth_info)
+		return -ENOMEM;
+
+	res_mgt->resource_info->eth_info = eth_info;
+
+	eth_info->eth_num =
+		(u8)hw_ops->get_fw_eth_num(NBL_RES_MGT_TO_HW_PRIV(res_mgt));
+	eth_bitmap = hw_ops->get_fw_eth_map(NBL_RES_MGT_TO_HW_PRIV(res_mgt));
+	/* for 2 eth port board, the eth_id is 0, 2 */
+	for (i = 0; i < NBL_MAX_ETHERNET; i++) {
+		if ((1 << i) & eth_bitmap) {
+			set_bit(i, eth_info->eth_bitmap);
+			eth_info->eth_id[eth_num] = i;
+			eth_info->logic_eth_id[i] = eth_num;
+			eth_num++;
+		}
+	}
+
+	for (i = 0; i < NBL_RES_MGT_TO_PF_NUM(res_mgt); i++) {
+		/* if pf_id <= eth_num, the pf relate corresponding eth_id*/
+		if (i < eth_num) {
+			eth_id = eth_info->eth_id[i];
+			eth_info->pf_bitmap[eth_id] |= BIT(i);
+		}
+		/* if pf_id > eth_num, the pf relate eth 0*/
+		else
+			eth_info->pf_bitmap[0] |= BIT(i);
+	}
+
+	return 0;
+}
+
+static void nbl_res_ctrl_dev_remove_eth_info(struct nbl_resource_mgt *res_mgt)
+{
+	struct device *dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	struct nbl_eth_info **eth_info = &NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+
+	if (*eth_info) {
+		devm_kfree(dev, *eth_info);
+		*eth_info = NULL;
+	}
+}
+
+static int nbl_res_ctrl_dev_sriov_info_init(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(common);
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	struct nbl_sriov_info *sriov_info;
+	void *p = NBL_RES_MGT_TO_HW_PRIV(res_mgt);
+	u16 func_id;
+	u16 function;
+
+	sriov_info = devm_kcalloc(dev, NBL_RES_MGT_TO_PF_NUM(res_mgt),
+				  sizeof(struct nbl_sriov_info), GFP_KERNEL);
+	if (!sriov_info)
+		return -ENOMEM;
+
+	res_mgt->resource_info->sriov_info = sriov_info;
+
+	for (func_id = 0; func_id < NBL_RES_MGT_TO_PF_NUM(res_mgt); func_id++) {
+		sriov_info = &NBL_RES_MGT_TO_SRIOV_INFO(res_mgt)[func_id];
+		function = NBL_COMMON_TO_PCI_FUNC_ID(common) + func_id;
+
+		common->hw_bus = (u8)hw_ops->get_real_bus(p);
+		sriov_info->bdf = PCI_DEVID(common->hw_bus,
+					    PCI_DEVFN(common->devid, function));
+	}
+	return 0;
+}
+
+static void nbl_res_ctrl_dev_sriov_info_remove(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_sriov_info **sriov_info =
+		&NBL_RES_MGT_TO_SRIOV_INFO(res_mgt);
+	struct device *dev = NBL_RES_MGT_TO_DEV(res_mgt);
+
+	if (!(*sriov_info))
+		return;
+
+	devm_kfree(dev, *sriov_info);
+	*sriov_info = NULL;
+}
+
+static int nbl_res_ctrl_dev_vsi_info_init(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(common);
+	struct nbl_vsi_info *vsi_info;
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	int i;
+
+	vsi_info = devm_kcalloc(dev, NBL_RES_MGT_TO_PF_NUM(res_mgt),
+				sizeof(struct nbl_vsi_info), GFP_KERNEL);
+	if (!vsi_info)
+		return -ENOMEM;
+
+	res_mgt->resource_info->vsi_info = vsi_info;
+	/*
+	 * case 1 two port(2pf)
+	 * pf0,pf1(NBL_VSI_SERV_PF_DATA_TYPE) vsi is 0,512
+
+	 * case 2 four port(4pf)
+	 * pf0,pf1,pf2,pf3(NBL_VSI_SERV_PF_DATA_TYPE) vsi is 0,256,512,768
+
+	 */
+
+	vsi_info->num = eth_info->eth_num;
+	for (i = 0; i < vsi_info->num; i++) {
+		vsi_info->serv_info[i][NBL_VSI_SERV_PF_DATA_TYPE].base_id =
+			i * NBL_VSI_ID_GAP(vsi_info->num);
+		vsi_info->serv_info[i][NBL_VSI_SERV_PF_DATA_TYPE].num = 1;
+	}
+	return 0;
+}
+
+static void nbl_res_ctrl_dev_remove_vsi_info(struct nbl_resource_mgt *res_mgt)
+{
+	struct device *dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	struct nbl_vsi_info **vsi_info = &NBL_RES_MGT_TO_VSI_INFO(res_mgt);
+
+	if (!(*vsi_info))
+		return;
+
+	devm_kfree(dev, *vsi_info);
+	*vsi_info = NULL;
+}
+
+static int nbl_res_ring_num_info_init(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_resource_info *resource_info =
+		NBL_RES_MGT_TO_RES_INFO(res_mgt);
+	struct nbl_net_ring_num_info *num_info =
+		&resource_info->net_ring_num_info;
+
+	num_info->pf_def_max_net_qp_num = NBL_DEFAULT_PF_HW_QUEUE_NUM;
+
+	return 0;
+}
+
+static int nbl_res_init_pf_num(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	u32 pf_mask;
+	u32 pf_num = 0;
+	int i;
+
+	pf_mask = hw_ops->get_host_pf_mask(NBL_RES_MGT_TO_HW_PRIV(res_mgt));
+	for (i = 0; i < NBL_MAX_PF_LEONIS; i++) {
+		if (!(pf_mask & (1 << i)))
+			pf_num++;
+		else
+			break;
+	}
+
+	res_mgt->resource_info->max_pf = pf_num;
+
+	if (!pf_num)
+		return -1;
+
+	return 0;
+}
+
+static void nbl_res_init_board_info(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+
+	hw_ops->get_board_info(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+			       &res_mgt->resource_info->board_info);
+}
+
 static void nbl_res_stop(struct nbl_resource_mgt_leonis *res_mgt_leonis)
 {
+	struct nbl_resource_mgt *res_mgt = &res_mgt_leonis->res_mgt;
+
+	nbl_res_ctrl_dev_remove_vsi_info(res_mgt);
+	nbl_res_ctrl_dev_remove_eth_info(res_mgt);
+	nbl_res_ctrl_dev_sriov_info_remove(res_mgt);
 }
 
 static int nbl_res_start(struct nbl_resource_mgt_leonis *res_mgt_leonis,
 			 struct nbl_func_caps caps)
 {
+	struct nbl_resource_mgt *res_mgt = &res_mgt_leonis->res_mgt;
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	int ret = 0;
+
+	if (caps.has_ctrl) {
+		nbl_res_init_board_info(res_mgt);
+
+		ret = nbl_res_init_pf_num(res_mgt);
+		if (ret) {
+			nbl_err(common, "pf number is illegal");
+			return ret;
+		}
+
+		ret = nbl_res_ctrl_dev_sriov_info_init(res_mgt);
+		if (ret) {
+			nbl_err(common, "Failed to init sr_iov info");
+			return ret;
+		}
+
+		ret = nbl_res_ctrl_dev_setup_eth_info(res_mgt);
+		if (ret)
+			goto start_fail;
+
+		ret = nbl_res_ctrl_dev_vsi_info_init(res_mgt);
+		if (ret)
+			goto start_fail;
+
+		ret = nbl_res_ring_num_info_init(res_mgt);
+		if (ret)
+			goto start_fail;
+	}
 	return 0;
+
+start_fail:
+	nbl_res_stop(res_mgt_leonis);
+	return ret;
 }
 
 int nbl_res_init_leonis(void *p, struct nbl_init_param *param)
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
index 80925ff9e680..a0a25a2b71ee 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
@@ -9,4 +9,5 @@
 
 #include "nbl_resource.h"
 
+#define NBL_MAX_PF_LEONIS			8
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
new file mode 100644
index 000000000000..f25b51629014
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
@@ -0,0 +1,299 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#include "nbl_resource.h"
+
+static u16 pfvfid_to_vsi_id(void *p, int pfid, int vfid, u16 type)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)p;
+	struct nbl_vsi_info *vsi_info = NBL_RES_MGT_TO_VSI_INFO(res_mgt);
+	enum nbl_vsi_serv_type dst_type = NBL_VSI_SERV_PF_DATA_TYPE;
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	u16 vsi_id = U16_MAX;
+	int diff;
+
+	diff = nbl_common_pf_id_subtraction_mgtpf_id(common, pfid);
+	if (vfid == U32_MAX || vfid == U16_MAX) {
+		if (diff < vsi_info->num) {
+			nbl_res_pf_dev_vsi_type_to_hw_vsi_type(type, &dst_type);
+			vsi_id = vsi_info->serv_info[diff][dst_type].base_id;
+		}
+	}
+
+	if (vsi_id == U16_MAX)
+		pr_err("convert pfid-vfid %d-%d to vsi_id(%d) failed!\n", pfid,
+		       vfid, type);
+
+	return vsi_id;
+}
+
+static u16 func_id_to_vsi_id(void *p, u16 func_id, u16 type)
+{
+	int pfid = U32_MAX;
+	int vfid = U32_MAX;
+
+	nbl_res_func_id_to_pfvfid(p, func_id, &pfid, &vfid);
+	return nbl_res_pfvfid_to_vsi_id(p, pfid, vfid, type);
+}
+
+static u16 vsi_id_to_func_id(void *p, u16 vsi_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)p;
+	struct nbl_vsi_info *vsi_info = NBL_RES_MGT_TO_VSI_INFO(res_mgt);
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	int i, j;
+	u16 func_id = U16_MAX;
+	bool vsi_find = false;
+
+	for (i = 0; i < vsi_info->num; i++) {
+		for (j = 0; j < NBL_VSI_SERV_MAX_TYPE; j++) {
+			if (vsi_id >= vsi_info->serv_info[i][j].base_id &&
+			    (vsi_id < vsi_info->serv_info[i][j].base_id +
+					      vsi_info->serv_info[i][j].num)) {
+				vsi_find = true;
+				break;
+			}
+		}
+
+		if (vsi_find)
+			break;
+	}
+
+	if (vsi_find) {
+		/* if pf_id < eth_num */
+		if (j >= NBL_VSI_SERV_PF_DATA_TYPE &&
+		    j <= NBL_VSI_SERV_PF_DATA_TYPE)
+			func_id = i + NBL_COMMON_TO_MGT_PF(common);
+	}
+
+	if (func_id == U16_MAX)
+		pr_err("convert vsi_id %d to func_id failed!\n", vsi_id);
+
+	return func_id;
+}
+
+static int vsi_id_to_pf_id(void *p, u16 vsi_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)p;
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct nbl_vsi_info *vsi_info = NBL_RES_MGT_TO_VSI_INFO(res_mgt);
+	u32 pf_id = U32_MAX;
+	bool vsi_find = false;
+	int i, j;
+
+	for (i = 0; i < vsi_info->num; i++) {
+		for (j = 0; j < NBL_VSI_SERV_MAX_TYPE; j++)
+			if (vsi_id >= vsi_info->serv_info[i][j].base_id &&
+			    (vsi_id < vsi_info->serv_info[i][j].base_id +
+					      vsi_info->serv_info[i][j].num)) {
+				vsi_find = true;
+				break;
+			}
+
+		if (vsi_find)
+			break;
+	}
+
+	if (vsi_find) {
+		/* if pf_id < eth_num */
+		if (j >= NBL_VSI_SERV_PF_DATA_TYPE &&
+		    j <= NBL_VSI_SERV_PF_DATA_TYPE)
+			pf_id = i + NBL_COMMON_TO_MGT_PF(common);
+	}
+
+	return pf_id;
+}
+
+static int func_id_to_pfvfid(void *p, u16 func_id, int *pfid, int *vfid)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)p;
+
+	if (func_id < NBL_RES_MGT_TO_PF_NUM(res_mgt)) {
+		*pfid = func_id;
+		*vfid = U32_MAX;
+		return 0;
+	}
+	return U32_MAX;
+}
+
+static int func_id_to_bdf(void *p, u16 func_id, u8 *bus, u8 *dev, u8 *function)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)p;
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct nbl_sriov_info *sriov_info;
+	int pfid = U32_MAX;
+	int vfid = U32_MAX;
+	int diff;
+	u8 pf_bus, devfn;
+
+	if (nbl_res_func_id_to_pfvfid(p, func_id, &pfid, &vfid))
+		return U32_MAX;
+
+	diff = nbl_common_pf_id_subtraction_mgtpf_id(common, pfid);
+	sriov_info = NBL_RES_MGT_TO_SRIOV_INFO(res_mgt) + diff;
+	pf_bus = PCI_BUS_NUM(sriov_info->bdf);
+	devfn = sriov_info->bdf & 0xff;
+	*bus = pf_bus;
+	*dev = PCI_SLOT(devfn);
+	*function = PCI_FUNC(devfn);
+	return 0;
+}
+
+static u16 pfvfid_to_func_id(void *p, int pfid, int vfid)
+{
+	return pfid;
+}
+
+static u64 get_func_bar_base_addr(void *p, u16 func_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)p;
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct nbl_sriov_info *sriov_info;
+	u64 base_addr = 0;
+	int pfid = U32_MAX;
+	int vfid = U32_MAX;
+	int diff;
+
+	if (nbl_res_func_id_to_pfvfid(p, func_id, &pfid, &vfid))
+		return 0;
+
+	diff = nbl_common_pf_id_subtraction_mgtpf_id(common, pfid);
+	sriov_info = NBL_RES_MGT_TO_SRIOV_INFO(res_mgt) + diff;
+	if (!sriov_info->pf_bar_start) {
+		nbl_err(common,
+			"Try to get bar addr for func %d, but PF_%d sriov not init",
+			func_id, pfid);
+		return 0;
+	}
+	base_addr = sriov_info->pf_bar_start;
+	nbl_debug(common, "pfid %d vfid %d base_addr %llx\n", pfid, vfid,
+		  base_addr);
+	return base_addr;
+}
+
+static u8 vsi_id_to_eth_id(void *p, u16 vsi_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)p;
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+
+	if (eth_info)
+		return eth_info
+			->eth_id[nbl_res_vsi_id_to_pf_id(res_mgt, vsi_id)];
+	else
+		return 0;
+}
+
+static u8 eth_id_to_pf_id(void *p, u8 eth_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)p;
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	int i;
+	u8 pf_id_offset = 0;
+
+	for_each_set_bit(i, eth_info->eth_bitmap, NBL_MAX_ETHERNET) {
+		if (i == eth_id)
+			break;
+		pf_id_offset++;
+	}
+
+	return pf_id_offset + NBL_COMMON_TO_MGT_PF(common);
+}
+
+int nbl_res_func_id_to_pfvfid(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			      int *pfid, int *vfid)
+{
+	if (!res_mgt->common_ops.func_id_to_pfvfid)
+		return func_id_to_pfvfid(res_mgt, func_id, pfid, vfid);
+
+	return res_mgt->common_ops.func_id_to_pfvfid(res_mgt, func_id, pfid,
+						     vfid);
+}
+
+u16 nbl_res_pfvfid_to_func_id(struct nbl_resource_mgt *res_mgt, int pfid,
+			      int vfid)
+{
+	if (!res_mgt->common_ops.pfvfid_to_func_id)
+		return pfvfid_to_func_id(res_mgt, pfid, vfid);
+
+	return res_mgt->common_ops.pfvfid_to_func_id(res_mgt, pfid, vfid);
+}
+
+u16 nbl_res_pfvfid_to_vsi_id(struct nbl_resource_mgt *res_mgt, int pfid,
+			     int vfid, u16 type)
+{
+	if (!res_mgt->common_ops.pfvfid_to_vsi_id)
+		return pfvfid_to_vsi_id(res_mgt, pfid, vfid, type);
+
+	return res_mgt->common_ops.pfvfid_to_vsi_id(res_mgt, pfid, vfid, type);
+}
+
+int nbl_res_func_id_to_bdf(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			   u8 *bus, u8 *dev, u8 *function)
+{
+	if (!res_mgt->common_ops.func_id_to_bdf)
+		return func_id_to_bdf(res_mgt, func_id, bus, dev, function);
+
+	return res_mgt->common_ops.func_id_to_bdf(res_mgt, func_id, bus, dev,
+						  function);
+}
+
+u16 nbl_res_vsi_id_to_func_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id)
+{
+	if (!res_mgt->common_ops.vsi_id_to_func_id)
+		return vsi_id_to_func_id(res_mgt, vsi_id);
+
+	return res_mgt->common_ops.vsi_id_to_func_id(res_mgt, vsi_id);
+}
+
+int nbl_res_vsi_id_to_pf_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id)
+{
+	if (!res_mgt->common_ops.vsi_id_to_pf_id)
+		return vsi_id_to_pf_id(res_mgt, vsi_id);
+
+	return res_mgt->common_ops.vsi_id_to_pf_id(res_mgt, vsi_id);
+}
+
+u16 nbl_res_func_id_to_vsi_id(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			      u16 type)
+{
+	if (!res_mgt->common_ops.func_id_to_vsi_id)
+		return func_id_to_vsi_id(res_mgt, func_id, type);
+
+	return res_mgt->common_ops.func_id_to_vsi_id(res_mgt, func_id, type);
+}
+
+u64 nbl_res_get_func_bar_base_addr(struct nbl_resource_mgt *res_mgt,
+				   u16 func_id)
+{
+	if (!res_mgt->common_ops.get_func_bar_base_addr)
+		return get_func_bar_base_addr(res_mgt, func_id);
+
+	return res_mgt->common_ops.get_func_bar_base_addr(res_mgt, func_id);
+}
+
+u8 nbl_res_vsi_id_to_eth_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id)
+{
+	if (!res_mgt->common_ops.vsi_id_to_eth_id)
+		return vsi_id_to_eth_id(res_mgt, vsi_id);
+
+	return res_mgt->common_ops.vsi_id_to_eth_id(res_mgt, vsi_id);
+}
+
+u8 nbl_res_eth_id_to_pf_id(struct nbl_resource_mgt *res_mgt, u8 eth_id)
+{
+	if (!res_mgt->common_ops.eth_id_to_pf_id)
+		return eth_id_to_pf_id(res_mgt, eth_id);
+
+	return res_mgt->common_ops.eth_id_to_pf_id(res_mgt, eth_id);
+}
+
+void nbl_res_pf_dev_vsi_type_to_hw_vsi_type(u16 src_type,
+					    enum nbl_vsi_serv_type *dst_type)
+{
+	if (src_type == NBL_VSI_DATA)
+		*dst_type = NBL_VSI_SERV_PF_DATA_TYPE;
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
index a43f4ca79b2b..f6fd151141d5 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
@@ -8,10 +8,23 @@
 #define _NBL_RESOURCE_H_
 
 #include "nbl_core.h"
+#include "nbl_hw.h"
 
 #define NBL_RES_MGT_TO_COMMON(res_mgt)		((res_mgt)->common)
 #define NBL_RES_MGT_TO_COMMON_OPS(res_mgt)	(&((res_mgt)->common_ops))
+#define NBL_RES_MGT_TO_DEV(res_mgt) \
+	NBL_COMMON_TO_DEV(NBL_RES_MGT_TO_COMMON(res_mgt))
+#define NBL_RES_MGT_TO_DMA_DEV(res_mgt)		\
+	NBL_COMMON_TO_DMA_DEV(NBL_RES_MGT_TO_COMMON(res_mgt))
 #define NBL_RES_MGT_TO_RES_INFO(res_mgt)	((res_mgt)->resource_info)
+#define NBL_RES_MGT_TO_SRIOV_INFO(res_mgt) \
+	(NBL_RES_MGT_TO_RES_INFO(res_mgt)->sriov_info)
+#define NBL_RES_MGT_TO_ETH_INFO(res_mgt) \
+	(NBL_RES_MGT_TO_RES_INFO(res_mgt)->eth_info)
+#define NBL_RES_MGT_TO_VSI_INFO(res_mgt) \
+	(NBL_RES_MGT_TO_RES_INFO(res_mgt)->vsi_info)
+#define NBL_RES_MGT_TO_PF_NUM(res_mgt) \
+	(NBL_RES_MGT_TO_RES_INFO(res_mgt)->max_pf)
 
 #define NBL_RES_MGT_TO_HW_OPS_TBL(res_mgt) ((res_mgt)->hw_ops_tbl)
 #define NBL_RES_MGT_TO_HW_OPS(res_mgt) (NBL_RES_MGT_TO_HW_OPS_TBL(res_mgt)->ops)
@@ -23,10 +36,79 @@
 #define NBL_RES_MGT_TO_CHAN_PRIV(res_mgt) \
 	(NBL_RES_MGT_TO_CHAN_OPS_TBL(res_mgt)->priv)
 
+#define NBL_MAX_NET_ID				NBL_MAX_FUNC
+#define NBL_MAX_JUMBO_FRAME_SIZE		(9600)
+#define NBL_PKT_HDR_PAD		(ETH_HLEN + ETH_FCS_LEN + (VLAN_HLEN * 2))
+#define NBL_DEFAULT_DESC_NUM			(1024)
+#define NBL_MAX_TXRX_QUEUE_PER_FUNC		(256)
+#define NBL_DEFAULT_PF_HW_QUEUE_NUM		(16)
+
+/* --------- INFO ---------- */
+struct nbl_sriov_info {
+	unsigned int bdf;
+	u64 pf_bar_start;
+};
+
+struct nbl_eth_info {
+	DECLARE_BITMAP(eth_bitmap, NBL_MAX_ETHERNET);
+	u8 pf_bitmap[NBL_MAX_ETHERNET];
+	u8 eth_num;
+	u8 resv[3];
+	u8 eth_id[NBL_MAX_PF];
+	u8 logic_eth_id[NBL_MAX_PF];
+
+};
+
+enum nbl_vsi_serv_type {
+	NBL_VSI_SERV_PF_DATA_TYPE,
+	NBL_VSI_SERV_MAX_TYPE,
+};
+
+struct nbl_vsi_serv_info {
+	u16 base_id;
+	u16 num;
+};
+
+struct nbl_vsi_info {
+	u16 num;
+	struct nbl_vsi_serv_info serv_info[NBL_MAX_ETHERNET]
+					  [NBL_VSI_SERV_MAX_TYPE];
+};
+
+struct nbl_net_ring_num_info {
+	u16 pf_def_max_net_qp_num;
+	u16 net_max_qp_num[NBL_MAX_FUNC];
+};
+
 struct nbl_resource_info {
+	/* ctrl-dev owned pfs */
+	DECLARE_BITMAP(func_bitmap, NBL_MAX_FUNC);
+	struct nbl_sriov_info *sriov_info;
+	struct nbl_eth_info *eth_info;
+	struct nbl_vsi_info *vsi_info;
+	u32 base_qid;
+	u32 max_vf_num;
+	struct nbl_net_ring_num_info net_ring_num_info;
+	u8 max_pf;
+	struct nbl_board_port_info board_info;
 };
 
 struct nbl_resource_common_ops {
+	u16 (*vsi_id_to_func_id)(void *res_mgt, u16 vsi_id);
+	int (*vsi_id_to_pf_id)(void *res_mgt, u16 vsi_id);
+	u16 (*vsi_id_to_vf_id)(void *res_mgt, u16 vsi_id);
+	u16 (*pfvfid_to_func_id)(void *res_mgt, int pfid, int vfid);
+	u16 (*pfvfid_to_vsi_id)(void *res_mgt, int pfid, int vfid, u16 type);
+	u16 (*func_id_to_vsi_id)(void *res_mgt, u16 func_id, u16 type);
+	int (*func_id_to_pfvfid)(void *res_mgt, u16 func_id, int *pfid,
+				 int *vfid);
+	int (*func_id_to_bdf)(void *res_mgt, u16 func_id, u8 *bus, u8 *dev,
+			      u8 *function);
+	u64 (*get_func_bar_base_addr)(void *res_mgt, u16 func_id);
+	u8 (*vsi_id_to_eth_id)(void *res_mgt, u16 vsi_id);
+	u8 (*eth_id_to_pf_id)(void *res_mgt, u8 eth_id);
+	int (*get_queue_num)(void *res_mgt, u16 func_id, u16 *tx_queue_num,
+			     u16 *rx_queue_num);
 };
 
 struct nbl_res_product_ops {
@@ -52,4 +134,23 @@ struct nbl_resource_mgt {
 struct nbl_resource_mgt_leonis {
 	struct nbl_resource_mgt res_mgt;
 };
+
+u16 nbl_res_vsi_id_to_func_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id);
+int nbl_res_vsi_id_to_pf_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id);
+u16 nbl_res_pfvfid_to_func_id(struct nbl_resource_mgt *res_mgt, int pfid,
+			      int vfid);
+u16 nbl_res_pfvfid_to_vsi_id(struct nbl_resource_mgt *res_mgt, int pfid,
+			     int vfid, u16 type);
+u16 nbl_res_func_id_to_vsi_id(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			      u16 type);
+int nbl_res_func_id_to_pfvfid(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			      int *pfid, int *vfid);
+u8 nbl_res_eth_id_to_pf_id(struct nbl_resource_mgt *res_mgt, u8 eth_id);
+int nbl_res_func_id_to_bdf(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			   u8 *bus, u8 *dev, u8 *function);
+u64 nbl_res_get_func_bar_base_addr(struct nbl_resource_mgt *res_mgt,
+				   u16 func_id);
+u8 nbl_res_vsi_id_to_eth_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id);
+void nbl_res_pf_dev_vsi_type_to_hw_vsi_type(u16 src_type,
+					    enum nbl_vsi_serv_type *dst_type);
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
index f62623ac8b76..fe176ee72128 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
@@ -48,6 +48,23 @@ do {									\
 #define NBL_COMMON_TO_PCI_FUNC_ID(common)	((common)->function)
 #define NBL_COMMON_TO_LOGIC_ETH_ID(common)	((common)->logic_eth_id)
 
+#define NBL_ONE_ETHERNET_PORT			(1)
+#define NBL_TWO_ETHERNET_PORT			(2)
+#define NBL_FOUR_ETHERNET_PORT			(4)
+#define NBL_DEFAULT_VSI_ID_GAP			(1024)
+#define NBL_TWO_ETHERNET_VSI_ID_GAP		(512)
+#define NBL_FOUR_ETHERNET_VSI_ID_GAP		(256)
+
+#define NBL_VSI_ID_GAP(m)					\
+	({							\
+		typeof(m) _m = (m);				\
+		_m == NBL_FOUR_ETHERNET_PORT ?			\
+			NBL_FOUR_ETHERNET_VSI_ID_GAP :		\
+			(_m == NBL_TWO_ETHERNET_PORT ?		\
+				 NBL_TWO_ETHERNET_VSI_ID_GAP :	\
+				 NBL_DEFAULT_VSI_ID_GAP);	\
+	})
+
 struct nbl_common_info {
 	struct pci_dev *pdev;
 	struct device *dev;
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
index 55cacc94888c..ef8ccb5707f5 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
@@ -16,6 +16,13 @@ struct nbl_resource_pt_ops {
 };
 
 struct nbl_resource_ops {
+	int (*register_net)(void *priv, u16 func_id,
+			    struct nbl_register_net_param *register_param,
+			    struct nbl_register_net_result *register_result);
+	int (*unregister_net)(void *priv, u16 func_id);
+	u16 (*get_vsi_id)(void *priv, u16 func_id, u16 type);
+	void (*get_eth_id)(void *priv, u16 vsi_id, u8 *eth_mode, u8 *eth_id,
+			   u8 *logic_eth_id);
 };
 
 struct nbl_resource_ops_tbl {
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index 375f7d530012..53fbcf43149b 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -18,11 +18,17 @@
 		typeof(id) _id = (id);			\
 		((_id) == (max) ? 0 : (_id) + 1);	\
 	})
+#define NBL_MAX_FUNC					(520)
 enum nbl_product_type {
 	NBL_LEONIS_TYPE,
 	NBL_PRODUCT_MAX,
 };
 
+enum {
+	NBL_VSI_DATA = 0,
+	NBL_VSI_MAX,
+};
+
 struct nbl_func_caps {
 	u32 has_ctrl:1;
 	u32 has_net:1;
@@ -63,4 +69,42 @@ struct nbl_vnet_queue_info_param {
 	u32 valid;
 };
 
+enum {
+	NBL_NETIF_F_SG_BIT,			/* Scatter/gather IO. */
+	NBL_NETIF_F_IP_CSUM_BIT,		/* csum TCP/UDP over IPv4 */
+	NBL_NETIF_F_HW_CSUM_BIT,		/* csum all the packets. */
+	NBL_NETIF_F_IPV6_CSUM_BIT,		/* csum TCP/UDP over IPV6 */
+	NBL_NETIF_F_HIGHDMA_BIT,		/* DMA to high memory. */
+	NBL_NETIF_F_HW_VLAN_CTAG_TX_BIT,	/* Tx VLAN CTAG HW accel */
+	NBL_NETIF_F_HW_VLAN_CTAG_RX_BIT,	/* Rx VLAN CTAG HW accel */
+	NBL_NETIF_F_HW_VLAN_CTAG_FILTER_BIT,	/* Rx filtering on VLAN CTAG */
+	NBL_NETIF_F_TSO_BIT,			/* TCPv4 segmentation */
+	NBL_NETIF_F_GSO_ROBUST_BIT,		/* SKB_GSO_DODGY */
+	NBL_NETIF_F_TSO6_BIT,			/* TCPv6 segmentation */
+	NBL_NETIF_F_GSO_GRE_BIT,		/* GRE with TSO */
+	NBL_NETIF_F_GSO_GRE_CSUM_BIT,		/* GRE with csum with TSO */
+	NBL_NETIF_F_GSO_UDP_TUNNEL_BIT,		/* UDP TUNNEL with TSO */
+	NBL_NETIF_F_GSO_UDP_TUNNEL_CSUM_BIT,	/* UDP TUNNEL with TSO & CSUM */
+	NBL_NETIF_F_GSO_PARTIAL_BIT,		/* Only segment inner-most L4
+						 * in hardware and all other
+						 * headers in software.
+						 */
+	NBL_NETIF_F_GSO_UDP_L4_BIT,		/* UDP payload GSO (not UFO) */
+	NBL_NETIF_F_SCTP_CRC_BIT,		/* SCTP checksum offload */
+	NBL_NETIF_F_NTUPLE_BIT,			/* N-tuple filters supported */
+	NBL_NETIF_F_RXHASH_BIT,			/* Rx hashing offload */
+	NBL_NETIF_F_RXCSUM_BIT,			/* Rx checksumming offload */
+	NBL_NETIF_F_HW_VLAN_STAG_TX_BIT,	/* Tx VLAN STAG HW accel */
+	NBL_NETIF_F_HW_VLAN_STAG_RX_BIT,	/* Rx VLAN STAG HW accel */
+	NBL_NETIF_F_HW_VLAN_STAG_FILTER_BIT,	/* Rx filtering on VLAN STAG */
+	NBL_NETIF_F_HW_TC_BIT,			/* Offload TC infrastructure */
+	NBL_FEATURES_COUNT
+};
+
+#define NBL_FEATURE(name)			(1 << (NBL_##name##_BIT))
+#define NBL_FEATURE_TEST_BIT(val, loc)		(((val) >> (loc)) & 0x1)
+enum nbl_performance_mode {
+	NBL_QUIRKS_NO_TOE,
+	NBL_QUIRKS_UVN_PREFETCH_ALIGN,
+};
 #endif
-- 
2.47.3


