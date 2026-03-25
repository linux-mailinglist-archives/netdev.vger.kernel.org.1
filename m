Return-Path: <netdev+bounces-271387-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IO2hALdgw2m1qQQAu9opvQ
	(envelope-from <netdev+bounces-271387-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 05:12:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9949E31F864
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 05:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8B0331A2D10
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 04:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853C63191D3;
	Wed, 25 Mar 2026 04:01:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-17.us.a.mail.aliyun.com (out198-17.us.a.mail.aliyun.com [47.90.198.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329312F9985;
	Wed, 25 Mar 2026 04:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774411280; cv=none; b=KJW70heEAAf+Gv5sRf52ljBz/wto3O4vjar2cBPW7u2LkB5wcU7DJqk+vZI7vq9bIv0QAfMZ4M2FmkZ8X1DAgEfNWgpwJqiUMoMn81E6JbLGsdli9YSGs1WPSeAeWyg8QKXxXyxhnKGYQwklIfYtAz8TKd45UTwhfC+dnGQ9nf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774411280; c=relaxed/simple;
	bh=x3g3qRLvacsUelYXyIpB3qWjyU44VxuWFYj9ACYulzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oylVpKDpEvH+EOB5u3p1scqXdmkqKJfbg55UZMhqg36mY1xmJkLiB8jfQgFRau6D6hEEHpSFpaHXD1Zl/EMcjWJwmMFTi5upG96/JS97fGiTxua7qMbdr1qVpMk1fI29SkSxQL5R+qAjaBcFC/g0kgIm75VLUExny+UyGF8EH0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06718225|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0663011-0.00124657-0.932452;FP=14303254420462786242|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040074035;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.gzTMEd2_1774411259;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.gzTMEd2_1774411259 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 25 Mar 2026 12:01:00 +0800
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
Subject: [PATCH v9 net-next 06/11] net/nebula-matrix: add common resource implementation
Date: Wed, 25 Mar 2026 12:00:38 +0800
Message-ID: <20260325040048.2313-7-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325040048.2313-1-illusion.wang@nebula-matrix.com>
References: <20260325040048.2313-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271387-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[nebula-matrix.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nebula-matrix.com:email,nebula-matrix.com:mid,illusion.wang:url]
X-Rspamd-Queue-Id: 9949E31F864
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  |  55 +++++++
 .../nbl_hw_leonis/nbl_resource_leonis.c       | 155 ++++++++++++++++++
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.c   | 135 +++++++++++++++
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |  54 ++++++
 .../nbl/nbl_include/nbl_def_common.h          |  15 ++
 .../nbl/nbl_include/nbl_def_resource.h        |  15 ++
 .../nbl/nbl_include/nbl_include.h             |   8 +
 8 files changed, 438 insertions(+)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index c9bc060732e7..b03c20f9988e 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -8,6 +8,7 @@ nbl-objs +=       nbl_common/nbl_common.o \
 				nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
 				nbl_hw/nbl_hw_leonis/nbl_resource_leonis.o \
 				nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.o \
+				nbl_hw/nbl_resource.o \
 				nbl_core/nbl_dispatch.o \
 				nbl_core/nbl_dev.o \
 				nbl_main.o
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
index 0df189104d5d..10cd46ed7317 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -8,6 +8,18 @@
 #include <linux/spinlock.h>
 #include "nbl_hw_leonis.h"
 
+static void nbl_hw_read_mbx_regs(struct nbl_hw_mgt *hw_mgt, u64 reg,
+				 u32 *data, u32 len)
+{
+	u32 i;
+
+	if (len % 4)
+		return;
+
+	for (i = 0; i < len / 4; i++)
+		data[i] = nbl_mbx_rd32(hw_mgt, reg + i * sizeof(u32));
+}
+
 static void nbl_hw_write_mbx_regs(struct nbl_hw_mgt *hw_mgt, u64 reg,
 				  const u32 *data, u32 len)
 {
@@ -129,6 +141,14 @@ static u32 nbl_hw_get_host_pf_mask(struct nbl_hw_mgt *hw_mgt)
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
@@ -143,6 +163,36 @@ static void nbl_hw_cfg_mailbox_qinfo(struct nbl_hw_mgt *hw_mgt, u16 func_id,
 		       (u32 *)&mb_qinfo_map, sizeof(mb_qinfo_map));
 }
 
+static void nbl_hw_get_board_info(struct nbl_hw_mgt *hw_mgt,
+				  struct nbl_board_port_info *board_info)
+{
+	union nbl_fw_board_cfg_dw3 dw3 = { .info = { 0 } };
+
+	nbl_hw_read_mbx_regs(hw_mgt, NBL_FW_BOARD_DW3_OFFSET, (u32 *)&dw3,
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
+	nbl_hw_read_mbx_regs(hw_mgt, NBL_FW_BOARD_DW3_OFFSET, (u32 *)&dw3,
+			     sizeof(dw3));
+	return dw3.info.port_num;
+}
+
+static u32 nbl_hw_get_fw_eth_map(struct nbl_hw_mgt *hw_mgt)
+{
+	union nbl_fw_board_cfg_dw6 dw6 = { .info = { 0 } };
+
+	nbl_hw_read_mbx_regs(hw_mgt, NBL_FW_BOARD_DW6_OFFSET, (u32 *)&dw6,
+			     sizeof(dw6));
+	return dw6.info.eth_bitmap;
+}
+
 static struct nbl_hw_ops hw_ops = {
 	.update_mailbox_queue_tail_ptr = nbl_hw_update_mailbox_queue_tail_ptr,
 	.config_mailbox_rxq = nbl_hw_config_mailbox_rxq,
@@ -150,8 +200,13 @@ static struct nbl_hw_ops hw_ops = {
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
index abeab9a1b7ae..d3613f7105b6 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
@@ -7,6 +7,8 @@
 #include "nbl_resource_leonis.h"
 
 static struct nbl_resource_ops res_ops = {
+	.get_vsi_id = nbl_res_func_id_to_vsi_id,
+	.get_eth_id = nbl_res_get_eth_id,
 };
 
 static struct nbl_resource_mgt *
@@ -45,9 +47,162 @@ nbl_res_setup_ops(struct device *dev, struct nbl_resource_mgt *res_mgt)
 	return res_ops_tbl;
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
+	for (i = 0; i < res_mgt->resource_info->max_pf; i++) {
+		/* if pf_id < eth_num, the pf relate corresponding eth_id*/
+		if (i < eth_num) {
+			eth_id = eth_info->eth_id[i];
+			eth_info->pf_bitmap[eth_id] |= BIT(i);
+		}
+		/* if pf_id >= eth_num, the pf relate eth 0*/
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
+	sriov_info = devm_kcalloc(dev, res_mgt->resource_info->max_pf,
+				  sizeof(struct nbl_sriov_info), GFP_KERNEL);
+	if (!sriov_info)
+		return -ENOMEM;
+
+	res_mgt->resource_info->sriov_info = sriov_info;
+
+	for (func_id = 0; func_id < res_mgt->resource_info->max_pf; func_id++) {
+		sriov_info = res_mgt->resource_info->sriov_info + func_id;
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
+	struct nbl_eth_info *eth_info = res_mgt->resource_info->eth_info;
+	struct nbl_common_info *common = res_mgt->common;
+	struct device *dev = common->dev;
+	struct nbl_vsi_info *vsi_info;
+	int i;
+
+	vsi_info = devm_kcalloc(dev, res_mgt->resource_info->max_pf,
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
 static int nbl_res_start(struct nbl_resource_mgt *res_mgt,
 			 struct nbl_func_caps caps)
 {
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
+			return ret;
+
+		ret = nbl_res_ctrl_dev_vsi_info_init(res_mgt);
+		if (ret)
+			return ret;
+	}
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
new file mode 100644
index 000000000000..4c6ae06e208d
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+#include <linux/device.h>
+#include <linux/pci.h>
+#include "nbl_resource.h"
+
+u16 nbl_res_pfvfid_to_vsi_id(struct nbl_resource_mgt *res_mgt, int pfid,
+			     int vfid, u16 type)
+{
+	struct nbl_vsi_info *vsi_info = res_mgt->resource_info->vsi_info;
+	enum nbl_vsi_serv_type dst_type = NBL_VSI_SERV_PF_DATA_TYPE;
+	struct nbl_common_info *common = res_mgt->common;
+	u16 vsi_id = U16_MAX;
+	u32 diff;
+
+	diff = nbl_common_pf_id_subtraction_mgtpf_id(common, pfid);
+	if (diff == U32_MAX)
+		return vsi_id;
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
+u16 nbl_res_func_id_to_vsi_id(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			      u16 type)
+{
+	int pfid = U32_MAX;
+	int vfid = U32_MAX;
+	int ret;
+
+	ret = nbl_res_func_id_to_pfvfid(res_mgt, func_id, &pfid, &vfid);
+	if (ret)
+		return U16_MAX;
+	return nbl_res_pfvfid_to_vsi_id(res_mgt, pfid, vfid, type);
+}
+
+int nbl_res_vsi_id_to_pf_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id)
+{
+	struct nbl_vsi_info *vsi_info = res_mgt->resource_info->vsi_info;
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
+		if (j == NBL_VSI_SERV_PF_DATA_TYPE)
+			pf_id = i + common->mgt_pf;
+	}
+
+	return pf_id;
+}
+
+int nbl_res_func_id_to_pfvfid(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			      int *pfid, int *vfid)
+{
+	if (func_id < res_mgt->resource_info->max_pf) {
+		*pfid = func_id;
+		*vfid = U32_MAX;
+		return 0;
+	}
+	return U32_MAX;
+}
+
+int nbl_res_func_id_to_bdf(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			   u8 *bus, u8 *dev, u8 *function)
+{
+	struct nbl_common_info *common = res_mgt->common;
+	struct nbl_sriov_info *sriov_info;
+	int pfid = U32_MAX;
+	int vfid = U32_MAX;
+	u8 pf_bus, devfn;
+	u32 diff;
+
+	if (nbl_res_func_id_to_pfvfid(res_mgt, func_id, &pfid, &vfid))
+		return U32_MAX;
+
+	diff = nbl_common_pf_id_subtraction_mgtpf_id(common, pfid);
+	if (diff == U32_MAX)
+		return U32_MAX;
+	sriov_info = res_mgt->resource_info->sriov_info + diff;
+	pf_bus = PCI_BUS_NUM(sriov_info->bdf);
+	devfn = sriov_info->bdf & 0xff;
+	*bus = pf_bus;
+	*dev = PCI_SLOT(devfn);
+	*function = PCI_FUNC(devfn);
+	return 0;
+}
+
+void nbl_res_get_eth_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id,
+			u8 *eth_mode, u8 *eth_id, u8 *logic_eth_id)
+{
+	struct nbl_eth_info *eth_info = res_mgt->resource_info->eth_info;
+	u16 pf_id = nbl_res_vsi_id_to_pf_id(res_mgt, vsi_id);
+
+	*eth_mode = eth_info->eth_num;
+	if (pf_id < eth_info->eth_num) {
+		*eth_id = eth_info->eth_id[pf_id];
+		*logic_eth_id = pf_id;
+	} else {
+		/* if pf_id >= eth_num, use eth_id 0 */
+		*eth_id = eth_info->eth_id[0];
+		*logic_eth_id = 0;
+	}
+}
+
+void nbl_res_pf_dev_vsi_type_to_hw_vsi_type(u16 src_type,
+					    enum nbl_vsi_serv_type *dst_type)
+{
+	if (src_type == NBL_VSI_DATA)
+		*dst_type = NBL_VSI_SERV_PF_DATA_TYPE;
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
index e08b6237da32..b090157cfacd 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
@@ -16,7 +16,48 @@
 #include "../nbl_include/nbl_def_common.h"
 #include "../nbl_core.h"
 
+struct nbl_resource_mgt;
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
+
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
@@ -27,4 +68,17 @@ struct nbl_resource_mgt {
 	struct nbl_interrupt_mgt *intr_mgt;
 };
 
+int nbl_res_vsi_id_to_pf_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id);
+u16 nbl_res_pfvfid_to_vsi_id(struct nbl_resource_mgt *res_mgt, int pfid,
+			     int vfid, u16 type);
+u16 nbl_res_func_id_to_vsi_id(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			      u16 type);
+int nbl_res_func_id_to_pfvfid(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			      int *pfid, int *vfid);
+int nbl_res_func_id_to_bdf(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			   u8 *bus, u8 *dev, u8 *function);
+void nbl_res_get_eth_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id,
+			u8 *eth_mode, u8 *eth_id, u8 *logic_eth_id);
+void nbl_res_pf_dev_vsi_type_to_hw_vsi_type(u16 src_type,
+					    enum nbl_vsi_serv_type *dst_type);
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
index 44b01c82e521..fcdc93661d05 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
@@ -9,6 +9,21 @@
 #include <linux/types.h>
 
 struct nbl_hash_tbl_mgt;
+#define NBL_TWO_ETHERNET_PORT			2
+#define NBL_FOUR_ETHERNET_PORT			4
+#define NBL_DEFAULT_VSI_ID_GAP			1024
+#define NBL_TWO_ETHERNET_VSI_ID_GAP		512
+#define NBL_FOUR_ETHERNET_VSI_ID_GAP		256
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
index ecf2e77c7f1c..78fcd2f6ec8a 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
@@ -6,9 +6,24 @@
 #ifndef _NBL_DEF_RESOURCE_H_
 #define _NBL_DEF_RESOURCE_H_
 
+#include <linux/types.h>
+
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
index a01c32f57d84..6a0bf5e8ca32 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -17,11 +17,19 @@
 		((_id) == (max) ? 0 : (_id) + 1);	\
 	})
 
+#define NBL_MAX_FUNC					520
+#define NBL_MAX_ETHERNET				4
+
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


