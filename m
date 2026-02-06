Return-Path: <netdev+bounces-257406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNvUJs1ThWmV/wMAu9opvQ
	(envelope-from <netdev+bounces-257406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 03:37:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FF1F9605
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 03:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75AF7303D2EE
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 02:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AF526982C;
	Fri,  6 Feb 2026 02:34:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-19.us.a.mail.aliyun.com (out198-19.us.a.mail.aliyun.com [47.90.198.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B8A266B72;
	Fri,  6 Feb 2026 02:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770345256; cv=none; b=ZT+t8bgGIYy3fqMMVfV5gHPhAQDbZ43UaK8TlCH3mjcmdJrc4378J+HNO2JKKgJjKTmHEwkxy5QXKXhfN+b8u9xr/D52cekU5OuKssPf4XHJdYzEecp6wm+0Nim1LMAC71RLfC+Q1wu6abVsuEaKZp5NFbWycWcwIdUI1fw1ufY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770345256; c=relaxed/simple;
	bh=E8wzhAvDe96e9qiyqdHOG3KH4CmIOxPxaNywKjezwuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h9V07IknjE0eJTx5euxU+EzAm3UyCsWnIDPW0G80l7tQa3jMo8XNCSIEeyDUL6QJg76FS1J56zm27punwE/JtieuIy57A2j/u/pUGqjlbzaflGJPUcVfdiW2xWTEJAqrMPBXcKVLYJ6Ue6n82PDuQiN4vYC9VHzvlApQ1mPcGX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.gQHg4lW_1770344296 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Feb 2026 10:18:17 +0800
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
Subject: [PATCH v4 net-next 06/11] net/nebula-matrix: add common resource implementation
Date: Fri,  6 Feb 2026 10:15:58 +0800
Message-ID: <20260206021608.85381-7-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206021608.85381-1-illusion.wang@nebula-matrix.com>
References: <20260206021608.85381-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257406-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[nebula-matrix.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nebula-matrix.com:mid,nebula-matrix.com:email,illusion.wang:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1FF1F9605
X-Rspamd-Action: no action

The Resource layer processes the entries/data of various modules within
the processing chip to accomplish specific entry management operations,
this describes the module business capabilities of the chip and the data
it manages.
The resource layer comprises the following sub-modules: common, 
interrupt, and vsi(txrx,queue not contained this time)

This patch provides the common part, including the conversion
relationships among vsi_id, func_id, eth_id, and pf_id. These
relationships may be utilized in the upper layer or the resource layer.

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   1 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  |  43 ++++
 .../nbl_hw_leonis/nbl_resource_leonis.c       | 183 ++++++++++++++++++
 .../nbl_hw_leonis/nbl_resource_leonis.h       |   1 -
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.c   | 142 ++++++++++++++
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |  64 ++++++
 .../nbl/nbl_include/nbl_def_common.h          |  16 ++
 .../nbl/nbl_include/nbl_def_resource.h        |  13 ++
 .../nbl/nbl_include/nbl_include.h             |   7 +
 9 files changed, 469 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index b93d21a99e99..db391bf70b20 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -9,6 +9,7 @@ nbl_core-objs +=       nbl_common/nbl_common.o \
 				nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
 				nbl_hw/nbl_hw_leonis/nbl_resource_leonis.o \
 				nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.o \
+				nbl_hw/nbl_resource.o \
 				nbl_core/nbl_dispatch.o \
 				nbl_core/nbl_dev.o \
 				nbl_main.o
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
index 307e71526143..867eea831c10 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -85,6 +85,14 @@ static u32 nbl_hw_get_host_pf_mask(struct nbl_hw_mgt *hw_mgt)
 	return data;
 }
 
+static u32 nbl_hw_get_real_bus(struct nbl_hw_mgt *hw_mgt)
+{
+	u32 data;
+
+	data = nbl_hw_rd32(hw_mgt, NBL_PCIE_HOST_TL_CFG_BUSDEV);
+	return data >> 5;
+}
+
 static void nbl_hw_cfg_mailbox_qinfo(struct nbl_hw_mgt *hw_mgt, u16 func_id,
 				     u16 bus, u16 devid, u16 function)
 {
@@ -99,6 +107,36 @@ static void nbl_hw_cfg_mailbox_qinfo(struct nbl_hw_mgt *hw_mgt, u16 func_id,
 		       (u8 *)&mb_qinfo_map, sizeof(mb_qinfo_map));
 }
 
+static void nbl_hw_get_board_info(struct nbl_hw_mgt *hw_mgt,
+				  struct nbl_board_port_info *board_info)
+{
+	union nbl_fw_board_cfg_dw3 dw3 = { .info = { 0 } };
+
+	nbl_hw_read_mbx_regs(hw_mgt, NBL_FW_BOARD_DW3_OFFSET, (u8 *)&dw3,
+			     sizeof(dw3));
+	board_info->eth_num = dw3.info.port_num;
+	board_info->eth_speed = dw3.info.port_speed;
+	board_info->p4_version = dw3.info.p4_version;
+}
+
+static u32 nbl_hw_get_fw_eth_num(struct nbl_hw_mgt *hw_mgt)
+{
+	union nbl_fw_board_cfg_dw3 dw3 = { .info = { 0 } };
+
+	nbl_hw_read_mbx_regs(hw_mgt, NBL_FW_BOARD_DW3_OFFSET, (u8 *)&dw3,
+			     sizeof(dw3));
+	return dw3.info.port_num;
+}
+
+static u32 nbl_hw_get_fw_eth_map(struct nbl_hw_mgt *hw_mgt)
+{
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
@@ -106,8 +144,13 @@ static struct nbl_hw_ops hw_ops = {
 	.stop_mailbox_rxq = nbl_hw_stop_mailbox_rxq,
 	.stop_mailbox_txq = nbl_hw_stop_mailbox_txq,
 	.get_host_pf_mask = nbl_hw_get_host_pf_mask,
+	.get_real_bus = nbl_hw_get_real_bus,
+
 	.cfg_mailbox_qinfo = nbl_hw_cfg_mailbox_qinfo,
 
+	.get_fw_eth_num = nbl_hw_get_fw_eth_num,
+	.get_fw_eth_map = nbl_hw_get_fw_eth_map,
+	.get_board_info = nbl_hw_get_board_info,
 };
 
 /* Structure starts here, adding an op should not modify anything below */
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
index bd395e607f5f..f3753771a299 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
@@ -6,7 +6,32 @@
 
 #include "nbl_resource_leonis.h"
 
+static u16 nbl_res_get_vsi_id(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			      u16 type)
+{
+	return nbl_res_func_id_to_vsi_id(res_mgt, func_id, type);
+}
+
+static void nbl_res_get_eth_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id,
+			       u8 *eth_mode, u8 *eth_id, u8 *logic_eth_id)
+{
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	u16 pf_id = nbl_res_vsi_id_to_pf_id(res_mgt, vsi_id);
+
+	*eth_mode = eth_info->eth_num;
+	if (pf_id < eth_info->eth_num) {
+		*eth_id = eth_info->eth_id[pf_id];
+		*logic_eth_id = pf_id;
+		/* if pf_id > eth_num, use eth_id 0 */
+	} else {
+		*eth_id = eth_info->eth_id[0];
+		*logic_eth_id = 0;
+	}
+}
+
 static struct nbl_resource_ops res_ops = {
+	.get_vsi_id = nbl_res_get_vsi_id,
+	.get_eth_id = nbl_res_get_eth_id,
 };
 
 static int
@@ -47,10 +72,167 @@ static int nbl_res_setup_ops(struct device *dev,
 	return 0;
 }
 
+static int nbl_res_ctrl_dev_setup_eth_info(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
+	struct device *dev = res_mgt->common->dev;
+	struct nbl_eth_info *eth_info;
+	u32 eth_bitmap, eth_id;
+	u32 eth_num = 0;
+	int i;
+
+	eth_info = devm_kzalloc(dev, sizeof(struct nbl_eth_info), GFP_KERNEL);
+	if (!eth_info)
+		return -ENOMEM;
+
+	res_mgt->resource_info->eth_info = eth_info;
+
+	eth_info->eth_num =
+		(u8)hw_ops->get_fw_eth_num(res_mgt->hw_ops_tbl->priv);
+	eth_bitmap = hw_ops->get_fw_eth_map(res_mgt->hw_ops_tbl->priv);
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
+static int nbl_res_ctrl_dev_sriov_info_init(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
+	struct nbl_hw_mgt *p = res_mgt->hw_ops_tbl->priv;
+	struct nbl_common_info *common = res_mgt->common;
+	struct nbl_sriov_info *sriov_info;
+	struct device *dev = common->dev;
+	u16 func_id, function;
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
+		function = common->function + func_id;
+
+		common->hw_bus = (u8)hw_ops->get_real_bus(p);
+		sriov_info->bdf = PCI_DEVID(common->hw_bus,
+					    PCI_DEVFN(common->devid, function));
+	}
+	return 0;
+}
+
+static int nbl_res_ctrl_dev_vsi_info_init(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	struct nbl_common_info *common = res_mgt->common;
+	struct device *dev = common->dev;
+	struct nbl_vsi_info *vsi_info;
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
+static int nbl_res_init_pf_num(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
+	u32 pf_num = 0;
+	u32 pf_mask;
+	int i;
+
+	pf_mask = hw_ops->get_host_pf_mask(res_mgt->hw_ops_tbl->priv);
+	for (i = 0; i < NBL_MAX_PF; i++) {
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
+	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
+
+	hw_ops->get_board_info(res_mgt->hw_ops_tbl->priv,
+			       &res_mgt->resource_info->board_info);
+}
+
 static int nbl_res_start(struct nbl_resource_mgt_leonis *res_mgt_leonis,
 			 struct nbl_func_caps caps)
 {
+	struct nbl_resource_mgt *res_mgt = &res_mgt_leonis->res_mgt;
+	int ret = 0;
+
+	if (caps.has_ctrl) {
+		nbl_res_init_board_info(res_mgt);
+
+		ret = nbl_res_init_pf_num(res_mgt);
+		if (ret)
+			return ret;
+
+		ret = nbl_res_ctrl_dev_sriov_info_init(res_mgt);
+		if (ret)
+			return ret;
+
+		ret = nbl_res_ctrl_dev_setup_eth_info(res_mgt);
+		if (ret)
+			goto start_fail;
+
+		ret = nbl_res_ctrl_dev_vsi_info_init(res_mgt);
+		if (ret)
+			goto start_fail;
+	}
 	return 0;
+
+start_fail:
+	return ret;
 }
 
 int nbl_res_init_leonis(struct nbl_adapter *adap, struct nbl_init_param *param)
@@ -63,6 +245,7 @@ int nbl_res_init_leonis(struct nbl_adapter *adap, struct nbl_init_param *param)
 	struct nbl_resource_mgt_leonis **mgt =
 		(struct nbl_resource_mgt_leonis **)&NBL_ADAP_TO_RES_MGT(adap);
 	struct device *dev = &adap->pdev->dev;
+
 	int ret = 0;
 
 	ret = nbl_res_setup_res_mgt(common, mgt);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
index 80925ff9e680..1d42850ee99d 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
@@ -8,5 +8,4 @@
 #define _NBL_RESOURCE_LEONIS_H_
 
 #include "nbl_resource.h"
-
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
new file mode 100644
index 000000000000..cd48e3f152de
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#include "nbl_resource.h"
+
+static u16 pfvfid_to_vsi_id(struct nbl_resource_mgt *res_mgt, int pfid,
+			    int vfid, u16 type)
+{
+	struct nbl_vsi_info *vsi_info = NBL_RES_MGT_TO_VSI_INFO(res_mgt);
+	enum nbl_vsi_serv_type dst_type = NBL_VSI_SERV_PF_DATA_TYPE;
+	struct nbl_common_info *common = res_mgt->common;
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
+static u16 func_id_to_vsi_id(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			     u16 type)
+{
+	int pfid = U32_MAX;
+	int vfid = U32_MAX;
+
+	nbl_res_func_id_to_pfvfid(res_mgt, func_id, &pfid, &vfid);
+	return nbl_res_pfvfid_to_vsi_id(res_mgt, pfid, vfid, type);
+}
+
+static int vsi_id_to_pf_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id)
+{
+	struct nbl_vsi_info *vsi_info = NBL_RES_MGT_TO_VSI_INFO(res_mgt);
+	struct nbl_common_info *common = res_mgt->common;
+	bool vsi_find = false;
+	u32 pf_id = U32_MAX;
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
+			pf_id = i + common->mgt_pf;
+	}
+
+	return pf_id;
+}
+
+static int func_id_to_pfvfid(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			     int *pfid, int *vfid)
+{
+	if (func_id < NBL_RES_MGT_TO_PF_NUM(res_mgt)) {
+		*pfid = func_id;
+		*vfid = U32_MAX;
+		return 0;
+	}
+	return U32_MAX;
+}
+
+static int func_id_to_bdf(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			  u8 *bus, u8 *dev, u8 *function)
+{
+	struct nbl_common_info *common = res_mgt->common;
+	struct nbl_sriov_info *sriov_info;
+	int pfid = U32_MAX;
+	int vfid = U32_MAX;
+	u8 pf_bus, devfn;
+	int diff;
+
+	if (nbl_res_func_id_to_pfvfid(res_mgt, func_id, &pfid, &vfid))
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
+int nbl_res_func_id_to_pfvfid(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			      int *pfid, int *vfid)
+{
+	return func_id_to_pfvfid(res_mgt, func_id, pfid, vfid);
+}
+
+u16 nbl_res_pfvfid_to_vsi_id(struct nbl_resource_mgt *res_mgt, int pfid,
+			     int vfid, u16 type)
+{
+	return pfvfid_to_vsi_id(res_mgt, pfid, vfid, type);
+}
+
+int nbl_res_func_id_to_bdf(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			   u8 *bus, u8 *dev, u8 *function)
+{
+	return func_id_to_bdf(res_mgt, func_id, bus, dev, function);
+}
+
+int nbl_res_vsi_id_to_pf_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id)
+{
+	return vsi_id_to_pf_id(res_mgt, vsi_id);
+}
+
+u16 nbl_res_func_id_to_vsi_id(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			      u16 type)
+{
+	return func_id_to_vsi_id(res_mgt, func_id, type);
+}
+
+void nbl_res_pf_dev_vsi_type_to_hw_vsi_type(u16 src_type,
+					    enum nbl_vsi_serv_type *dst_type)
+{
+	if (src_type == NBL_VSI_DATA)
+		*dst_type = NBL_VSI_SERV_PF_DATA_TYPE;
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
index 8429eb263862..9c4595f9463c 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
@@ -8,8 +8,60 @@
 #define _NBL_RESOURCE_H_
 
 #include "nbl_core.h"
+#include "nbl_hw.h"
+
+struct nbl_resource_mgt;
+
+#define NBL_RES_MGT_TO_RES_INFO(res_mgt)	((res_mgt)->resource_info)
+#define NBL_RES_MGT_TO_SRIOV_INFO(res_mgt) \
+	(NBL_RES_MGT_TO_RES_INFO(res_mgt)->sriov_info)
+#define NBL_RES_MGT_TO_ETH_INFO(res_mgt) \
+	(NBL_RES_MGT_TO_RES_INFO(res_mgt)->eth_info)
+#define NBL_RES_MGT_TO_VSI_INFO(res_mgt) \
+	(NBL_RES_MGT_TO_RES_INFO(res_mgt)->vsi_info)
+#define NBL_RES_MGT_TO_PF_NUM(res_mgt) \
+	(NBL_RES_MGT_TO_RES_INFO(res_mgt)->max_pf)
+
+/* --------- INFO ---------- */
+struct nbl_sriov_info {
+	unsigned int bdf;
+};
+
+struct nbl_eth_info {
+	DECLARE_BITMAP(eth_bitmap, NBL_MAX_ETHERNET);
+	u8 pf_bitmap[NBL_MAX_ETHERNET];
+	u8 eth_num;
+	u8 resv[3];
+	u8 eth_id[NBL_MAX_PF];
+	u8 logic_eth_id[NBL_MAX_PF];
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
 
 struct nbl_resource_info {
+	/* ctrl-dev owned pfs */
+	DECLARE_BITMAP(func_bitmap, NBL_MAX_FUNC);
+	struct nbl_sriov_info *sriov_info;
+	struct nbl_eth_info *eth_info;
+	struct nbl_vsi_info *vsi_info;
+	u32 base_qid;
+	u32 max_vf_num;
+	u8 max_pf;
+	struct nbl_board_port_info board_info;
 };
 
 struct nbl_resource_mgt {
@@ -27,4 +79,16 @@ struct nbl_resource_mgt {
 struct nbl_resource_mgt_leonis {
 	struct nbl_resource_mgt res_mgt;
 };
+
+int nbl_res_vsi_id_to_pf_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id);
+u16 nbl_res_pfvfid_to_vsi_id(struct nbl_resource_mgt *res_mgt, int pfid,
+			     int vfid, u16 type);
+u16 nbl_res_func_id_to_vsi_id(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			      u16 type);
+int nbl_res_func_id_to_pfvfid(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			      int *pfid, int *vfid);
+int nbl_res_func_id_to_bdf(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			   u8 *bus, u8 *dev, u8 *function);
+void nbl_res_pf_dev_vsi_type_to_hw_vsi_type(u16 src_type,
+					    enum nbl_vsi_serv_type *dst_type);
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
index fa53a0019400..eca4b7b901a6 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
@@ -9,6 +9,22 @@
 
 #include "nbl_include.h"
 struct nbl_hash_tbl_mgt;
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
 
 struct nbl_common_info {
 	struct pci_dev *pdev;
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
index 74a6a7ee9af9..b6f7ca1faa34 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
@@ -11,6 +11,19 @@
 struct nbl_resource_mgt;
 
 struct nbl_resource_ops {
+	int (*init_chip_module)(struct nbl_resource_mgt *res_mgt);
+	void (*deinit_chip_module)(struct nbl_resource_mgt *res_mgt);
+
+	int (*configure_msix_map)(struct nbl_resource_mgt *res_mgt, u16 func_id,
+				  u16 num_net_msix, u16 num_others_msix,
+				  bool net_msix_mask_en);
+	int (*destroy_msix_map)(struct nbl_resource_mgt *res_mgt, u16 func_id);
+	int (*enable_mailbox_irq)(struct nbl_resource_mgt *res_mgt, u16 func_id,
+				  u16 vector_id, bool enable_msix);
+	u16 (*get_vsi_id)(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			  u16 type);
+	void (*get_eth_id)(struct nbl_resource_mgt *res_mgt, u16 vsi_id,
+			   u8 *eth_mode, u8 *eth_id, u8 *logic_eth_id);
 };
 
 struct nbl_resource_ops_tbl {
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index f56df4008660..659f8fb84406 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -11,17 +11,24 @@
 #include <linux/netdevice.h>
 /*  ------  Basic definitions  -------  */
 #define NBL_DRIVER_NAME					"nbl_core"
+
 #define NBL_MAX_PF					8
 #define NBL_NEXT_ID(id, max)				\
 	({						\
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
-- 
2.47.3


