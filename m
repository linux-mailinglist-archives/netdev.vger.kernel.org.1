Return-Path: <netdev+bounces-300023-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R50oNLYnMmpMvwUAu9opvQ
	(envelope-from <netdev+bounces-300023-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 06:51:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDE169680D
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 06:51:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300023-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300023-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EADE317800B
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 04:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD03F32571D;
	Wed, 17 Jun 2026 04:47:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-98.mail.aliyun.com (out28-98.mail.aliyun.com [115.124.28.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A9430C372;
	Wed, 17 Jun 2026 04:47:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781671644; cv=none; b=qKNJ0SEHHlNBDNGS6qtpQN395m0eOEztftJVmka8lP1BnZLmbMMI4riO3JITCnfmFozzfLwvn02Rtj89wDvhmyfilzXDHMbkBE5aJEwes9cUdEFpkRJdcLe0slmEqyKjjuRl+w+tyXnJH1uaKfR+T4RwoIhL3j8en5KBK/OiwNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781671644; c=relaxed/simple;
	bh=j6nz4RE5TxVi5uB2+UYvyIy/fLvZZYoGS9PhpnqG2J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3hBXHcQuwzAF1i/AbLZ9q+JmJrtleoW3B65/oxwGjeeI9AkSg0NNrrnC26yG+dUvZDUbr7CGIkev+in9y2MgUx9HNMogNXg6vQpTRAxELK1rXLAUaLd7idefw9qqT6RWPGnB/cUMEsj3D+gkfd9EaoTZ6zMBYfGxKXDFaAVZMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.98
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712911|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0757389-0.00157105-0.92269;FP=16023610102580272770|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033023018039;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.i-FkB9L_1781671633;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.i-FkB9L_1781671633 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 17 Jun 2026 12:47:13 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v19 net-next 06/11] net/nebula-matrix: add common resource implementation
Date: Wed, 17 Jun 2026 12:46:51 +0800
Message-ID: <20260617044702.2439-7-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617044702.2439-1-illusion.wang@nebula-matrix.com>
References: <20260617044702.2439-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300023-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	DMARC_NA(0.00)[nebula-matrix.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
	FORGED_RECIPIENTS(0.00)[m:dimon.zhao@nebula-matrix.com,m:illusion.wang@nebula-matrix.com,m:alvin.wang@nebula-matrix.com,m:sam.chen@nebula-matrix.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:kuba@kernel.org,m:horms@kernel.org,m:linux-doc@vger.kernel.org,m:pabeni@redhat.com,m:vadim.fedorenko@linux.dev,m:lukas.bulwahn@redhat.com,m:edumazet@google.com,m:enelsonmoore@gmail.com,m:skhan@linuxfoundation.org,m:hkallweit1@gmail.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[illusion.wang:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nebula-matrix.com:email,nebula-matrix.com:mid,nebula-matrix.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6EDE169680D

The Resource layer processes the entries/data of various modules within
the processing chip to accomplish specific entry management operations,
this describes the module business capabilities of the chip and the data
it manages.
The resource layer comprises the following sub-modules: common,
interrupt, and vsi(txrx,queue not contained this time)

This patch provides the common part, including the conversion
relationships among vsi_id, func_id, eth_id, and pf_id. These
relationships may be utilized in the upper layer or the resource layer.

Key Assumptions:
- nbl_res_start() initializes VSI/Eth/PF data structures **only for
control devices** (`common->has_ctrl == true`).
- APIs like nbl_res_func_id_to_vsi_id() **are guaranteed to be called
 only on control devices** by the framework's dispatch layer.

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   1 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  |  47 +++++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  |  14 ++
 .../nbl_hw_leonis/nbl_resource_leonis.c       | 190 ++++++++++++++++++
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.c   | 143 +++++++++++++
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |  49 ++++-
 .../nbl/nbl_include/nbl_def_common.h          |  15 ++
 .../nbl/nbl_include/nbl_def_resource.h        |  16 ++
 .../nbl/nbl_include/nbl_include.h             |   8 +
 9 files changed, 482 insertions(+), 1 deletion(-)
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
index 1d25d7770d8d..f31f54d1f4f7 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -10,6 +10,18 @@
 #include <linux/bitfield.h>
 #include "nbl_hw_leonis.h"
 
+static void nbl_hw_read_mbx_regs(struct nbl_hw_mgt *hw_mgt, u64 reg, u32 *data,
+				 u32 len)
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
@@ -52,6 +64,15 @@ static void nbl_hw_wr_regs(struct nbl_hw_mgt *hw_mgt, u64 reg, const u32 *data,
 	spin_unlock(&hw_mgt->reg_lock);
 }
 
+static u32 nbl_hw_get_fw_eth_map(struct nbl_hw_mgt *hw_mgt)
+{
+	u32 data;
+
+	nbl_hw_read_mbx_regs(hw_mgt, NBL_FW_BOARD_DW6_OFFSET, &data,
+			     sizeof(data));
+	return FIELD_GET(NBL_FW_BOARD_DW6_ETH_BITMAP_MASK, data);
+}
+
 static void nbl_hw_update_mailbox_queue_tail_ptr(struct nbl_hw_mgt *hw_mgt,
 						 u16 tail_ptr, u8 txrx)
 {
@@ -133,6 +154,14 @@ static u32 nbl_hw_get_host_pf_mask(struct nbl_hw_mgt *hw_mgt)
 	return data;
 }
 
+static u8 nbl_hw_get_real_bus(struct nbl_hw_mgt *hw_mgt)
+{
+	u32 data;
+
+	data = nbl_hw_rd32(hw_mgt, NBL_PCIE_HOST_TL_CFG_BUSDEV);
+	return FIELD_GET(NBL_PCIE_BUS_MASK, data);
+}
+
 static void nbl_hw_cfg_mailbox_qinfo(struct nbl_hw_mgt *hw_mgt, u16 func_id,
 				     u8 bus, u8 devid, u8 function)
 {
@@ -145,6 +174,20 @@ static void nbl_hw_cfg_mailbox_qinfo(struct nbl_hw_mgt *hw_mgt, u16 func_id,
 		       sizeof(data));
 }
 
+static void nbl_hw_get_board_info(struct nbl_hw_mgt *hw_mgt,
+				  struct nbl_board_port_info *board_info)
+{
+	u32 data = 0;
+
+	nbl_hw_read_mbx_regs(hw_mgt, NBL_FW_BOARD_DW3_OFFSET, &data,
+			     sizeof(data));
+	board_info->eth_num = FIELD_GET(NBL_FW_BOARD_DW3_PORT_NUM_MASK, data);
+	board_info->eth_speed =
+		FIELD_GET(NBL_FW_BOARD_DW3_PORT_SPEED_MASK, data);
+	board_info->p4_version =
+		FIELD_GET(NBL_FW_BOARD_DW3_P4_VERSION_MASK, data);
+}
+
 static struct nbl_hw_ops hw_ops = {
 	.update_mailbox_queue_tail_ptr = nbl_hw_update_mailbox_queue_tail_ptr,
 	.config_mailbox_rxq = nbl_hw_config_mailbox_rxq,
@@ -152,8 +195,12 @@ static struct nbl_hw_ops hw_ops = {
 	.stop_mailbox_rxq = nbl_hw_stop_mailbox_rxq,
 	.stop_mailbox_txq = nbl_hw_stop_mailbox_txq,
 	.get_host_pf_mask = nbl_hw_get_host_pf_mask,
+	.get_real_bus = nbl_hw_get_real_bus,
+
 	.cfg_mailbox_qinfo = nbl_hw_cfg_mailbox_qinfo,
 
+	.get_fw_eth_map = nbl_hw_get_fw_eth_map,
+	.get_board_info = nbl_hw_get_board_info,
 };
 
 /* Structure starts here, adding an op should not modify anything below */
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
index d2c85175554d..e32f740d8d3f 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
@@ -69,4 +69,18 @@ struct nbl_mailbox_qinfo_cfg_table {
 #define NBL_PCIE_HOST_K_PF_MASK_REG (NBL_INTF_HOST_PCIE_BASE + 0x00001004)
 #define NBL_PCIE_HOST_TL_CFG_BUSDEV (NBL_INTF_HOST_PCIE_BASE + 0x11040)
 
+#define NBL_PCIE_BUS_MASK	GENMASK(12, 5)
+#define NBL_FW_BOARD_CONFIG			0x200
+#define NBL_FW_BOARD_DW3_OFFSET			(NBL_FW_BOARD_CONFIG + 12)
+#define NBL_FW_BOARD_DW6_OFFSET			(NBL_FW_BOARD_CONFIG + 24)
+
+#define NBL_FW_BOARD_DW3_PORT_TYPE_MASK BIT(0)
+#define NBL_FW_BOARD_DW3_PORT_NUM_MASK GENMASK(7, 1)
+#define NBL_FW_BOARD_DW3_PORT_SPEED_MASK GENMASK(9, 8)
+#define NBL_FW_BOARD_DW3_GPIO_TYPE_MASK GENMASK(12, 10)
+#define NBL_FW_BOARD_DW3_P4_VERSION_MASK GENMASK(13, 13)
+
+#define NBL_FW_BOARD_DW6_LANE_BITMAP_MASK GENMASK(7, 0)
+#define NBL_FW_BOARD_DW6_ETH_BITMAP_MASK GENMASK(15, 8)
+
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
index 4b4f8e2e7fe7..47e4b6d70cbd 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
@@ -4,9 +4,12 @@
  */
 #include <linux/device.h>
 #include <linux/pci.h>
+#include <linux/bits.h>
 #include "nbl_resource_leonis.h"
 
 static struct nbl_resource_ops res_ops = {
+	.get_vsi_id = nbl_res_func_id_to_vsi_id,
+	.get_eth_id = nbl_res_get_eth_id,
 };
 
 static struct nbl_resource_mgt *
@@ -45,8 +48,195 @@ nbl_res_setup_ops(struct device *dev, struct nbl_resource_mgt *res_mgt)
 	return res_ops_tbl;
 }
 
+static int nbl_res_ctrl_dev_setup_eth_info(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
+	struct device *dev = res_mgt->common->dev;
+	struct nbl_eth_info *eth_info;
+	u32 eth_bitmap, eth_id;
+	u32 eth_num = 0;
+	u32 fw_port_num;
+	int i;
+
+	eth_info = devm_kzalloc(dev, sizeof(*eth_info), GFP_KERNEL);
+	if (!eth_info)
+		return -ENOMEM;
+
+	res_mgt->resource_info->eth_info = eth_info;
+
+	fw_port_num = res_mgt->resource_info->board_info.eth_num;
+	eth_bitmap = hw_ops->get_fw_eth_map(res_mgt->hw_ops_tbl->priv);
+	if (eth_bitmap & ~((1 << NBL_MAX_ETHERNET) - 1)) {
+		dev_err(dev, "FW reported invalid eth_bitmap 0x%x\n",
+			eth_bitmap);
+		return -EINVAL;
+	}
+	if (fw_port_num !=  hweight32(eth_bitmap)) {
+		dev_err(dev, "FW inconsistency: port_num=%u, bitmap=0x%x\n",
+			fw_port_num, eth_bitmap);
+		return -EINVAL;
+	}
+
+	if (fw_port_num > NBL_MAX_ETHERNET || fw_port_num == 3) {
+		dev_warn(dev, "FW reports %u Ethernet ports, not supported\n",
+			 fw_port_num);
+		return -EINVAL;
+	}
+	eth_info->eth_num = fw_port_num;
+	/* Intentional design constraint: each PF maps to exactly one
+	 * Ethernet port. This couples PF identity to port identity
+	 * and is required by nbl_res_get_eth_id() which indexes
+	 * eth_info->eth_id[] by relative PF id.
+	 */
+	if (res_mgt->resource_info->max_pf != eth_info->eth_num) {
+		dev_err(dev, "Invalid PF-to-port topology: max_pf=%u, eth_num=%u\n",
+			res_mgt->resource_info->max_pf, eth_info->eth_num);
+		return -EINVAL;
+	}
+
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
+		eth_id = eth_info->eth_id[i];
+		eth_info->pf_bitmap[eth_id] |= BIT(i);
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
+	u16 function;
+	u16 func_id;
+
+	sriov_info = devm_kcalloc(dev, res_mgt->resource_info->max_pf,
+				  sizeof(*sriov_info), GFP_KERNEL);
+	if (!sriov_info)
+		return -ENOMEM;
+
+	res_mgt->resource_info->sriov_info = sriov_info;
+	common->hw_bus = hw_ops->get_real_bus(p);
+	if (common->function + res_mgt->resource_info->max_pf > NBL_MAX_PF) {
+		dev_err(dev, "PF count exceeds available function space\n");
+		return -EINVAL;
+	}
+	for (func_id = 0; func_id < res_mgt->resource_info->max_pf; func_id++) {
+		sriov_info = res_mgt->resource_info->sriov_info + func_id;
+		function = common->function + func_id;
+		sriov_info->bdf = PCI_DEVID(common->hw_bus,
+					    PCI_DEVFN(common->devid, function));
+	}
+
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
+	vsi_info = devm_kzalloc(dev, sizeof(*vsi_info), GFP_KERNEL);
+	if (!vsi_info)
+		return -ENOMEM;
+
+	res_mgt->resource_info->vsi_info = vsi_info;
+	/*
+	 * case 1 one port(1pf)
+	 * pf0 (NBL_VSI_SERV_PF_DATA_TYPE) vsi is 0
+	 * case 2 two port(2pf)
+	 * pf0,pf1(NBL_VSI_SERV_PF_DATA_TYPE) vsi is 0,512
+	 * case 3 four port(4pf)
+	 * pf0,pf1,pf2,pf3(NBL_VSI_SERV_PF_DATA_TYPE) vsi is 0,256,512,768
+
+	 */
+
+	vsi_info->num = eth_info->eth_num;
+	/* eth_num is guaranteed to be 1/2/4 here, so NBL_VSI_ID_GAP()
+	 * will always hit one of the explicit branches.
+	 */
+	for (i = 0; i < vsi_info->num; i++) {
+		vsi_info->serv_info[i][NBL_VSI_SERV_PF_DATA_TYPE].base_id =
+			i * NBL_VSI_ID_GAP(vsi_info->num);
+		vsi_info->serv_info[i][NBL_VSI_SERV_PF_DATA_TYPE].num = 1;
+	}
+
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
+	/*
+	 * Hardware guarantees pf_mask has contiguous cleared bits
+	 * starting from bit 0 (e.g., 0b11111100, not 0b01010101).
+	 * This allows us to stop at the first set bit.
+	 */
+	for (i = 0; i < NBL_MAX_PF; i++) {
+		if (!(pf_mask & (1 << i)))
+			pf_num++;
+		else
+			break;
+	}
+	if (pf_num == 0 || pf_num > NBL_MAX_ETHERNET || pf_num == 3)
+		return -EINVAL;
+	res_mgt->resource_info->max_pf = pf_num;
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
 static int nbl_res_start(struct nbl_resource_mgt *res_mgt)
 {
+	struct nbl_common_info *common = res_mgt->common;
+	int ret = 0;
+
+	if (common->has_ctrl) {
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
index 000000000000..6742da7c6637
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+
+#include <linux/pci.h>
+#include "nbl_resource.h"
+
+int nbl_res_func_id_to_vsi_id(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			      u16 type, u16 *vsi_id)
+{
+	struct nbl_vsi_info *vsi_info = res_mgt->resource_info->vsi_info;
+	enum nbl_vsi_serv_type dst_type = NBL_VSI_SERV_PF_DATA_TYPE;
+	struct nbl_common_info *common = res_mgt->common;
+	struct device *dev = res_mgt->common->dev;
+	int pfid = func_id;
+	u32 diff;
+
+	if (!common->has_ctrl) {
+		dev_dbg(dev, "No control plane available\n");
+		return -EINVAL;
+	}
+	diff = nbl_common_pf_id_subtraction_mgtpf_id(common, pfid);
+	if (diff == U32_MAX) {
+		dev_dbg(dev, "Invalid PF ID subtraction result\n");
+		return -EINVAL;
+	}
+	if (diff >= vsi_info->num) {
+		dev_err(dev, "PF %d (diff=%u) exceeds vsi_info->num (%u)\n",
+			pfid, diff, vsi_info->num);
+		return -EINVAL;
+	}
+
+	nbl_res_pf_dev_vsi_type_to_hw_vsi_type(type, &dst_type);
+	*vsi_id = vsi_info->serv_info[diff][dst_type].base_id;
+	return 0;
+}
+
+int nbl_res_vsi_id_to_pf_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id)
+{
+	struct nbl_vsi_info *vsi_info = res_mgt->resource_info->vsi_info;
+	struct nbl_common_info *common = res_mgt->common;
+	struct device *dev = res_mgt->common->dev;
+	int j = NBL_VSI_SERV_PF_DATA_TYPE;
+	int pf_id, i;
+
+	if (!common->has_ctrl) {
+		dev_dbg(dev, "No control plane available\n");
+		return -EINVAL;
+	}
+	for (i = 0; i < vsi_info->num; i++) {
+		if (vsi_id >= vsi_info->serv_info[i][j].base_id &&
+		    (vsi_id < vsi_info->serv_info[i][j].base_id +
+					vsi_info->serv_info[i][j].num)) {
+			pf_id = i + common->mgt_pf;
+			if (pf_id >= NBL_MAX_PF) {
+				dev_err(dev, "PF ID overflow\n");
+				return -ERANGE;
+			}
+			return pf_id;
+		}
+	}
+
+	dev_dbg(dev, "VSI ID %u not found\n", vsi_id);
+	return -ENOENT;
+}
+
+int nbl_res_func_id_to_bdf(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			   u8 *bus, u8 *dev, u8 *function)
+{
+	struct nbl_common_info *common = res_mgt->common;
+	struct nbl_sriov_info *sriov_info;
+	int pfid = func_id;
+	u8 pf_bus, devfn;
+	u32 diff;
+
+	if (!common->has_ctrl || !bus || !dev || !function)
+		return -EINVAL;
+	diff = nbl_common_pf_id_subtraction_mgtpf_id(common, pfid);
+	if (diff == U32_MAX)
+		return -EINVAL;
+	if (diff >= res_mgt->resource_info->max_pf) {
+		dev_err(common->dev, "PF ID %u exceeds maximum supported PF count %u\n",
+			pfid, res_mgt->resource_info->max_pf);
+		return -ERANGE;
+	}
+	sriov_info = res_mgt->resource_info->sriov_info + diff;
+	pf_bus = PCI_BUS_NUM(sriov_info->bdf);
+	devfn = sriov_info->bdf & 0xff;
+	*bus = pf_bus;
+	*dev = PCI_SLOT(devfn);
+	*function = PCI_FUNC(devfn);
+
+	return 0;
+}
+
+int nbl_res_get_eth_id(struct nbl_resource_mgt *res_mgt, u16 func_id,
+		       u16 vsi_id, u8 *eth_num, u8 *eth_id, u8 *logic_eth_id)
+{
+	struct nbl_eth_info *eth_info = res_mgt->resource_info->eth_info;
+	struct nbl_common_info *common = res_mgt->common;
+	struct device *dev = res_mgt->common->dev;
+	int pfid = func_id;
+	int rel_pf_id;
+	int abs_pf_id;
+
+	if (!common->has_ctrl || !eth_num || !eth_id || !logic_eth_id)
+		return -EINVAL;
+	abs_pf_id = nbl_res_vsi_id_to_pf_id(res_mgt, vsi_id);
+	if (abs_pf_id < 0) {
+		dev_err(dev, "Failed to get PF ID from VSI ID %u\n", vsi_id);
+		return -EINVAL;
+	}
+	if (abs_pf_id != pfid) {
+		dev_err(dev, "invalid pf id %u\n", pfid);
+		return -EINVAL;
+	}
+	rel_pf_id = abs_pf_id - common->mgt_pf;
+
+	if (rel_pf_id >= eth_info->eth_num) {
+		dev_err(dev, "rel_pf_id %d out of range [0, %u)\n",
+			rel_pf_id, eth_info->eth_num);
+		return -ERANGE;
+	}
+
+	*eth_num = eth_info->eth_num;
+	*eth_id = eth_info->eth_id[rel_pf_id];
+	*logic_eth_id = rel_pf_id;
+	return 0;
+}
+
+void nbl_res_pf_dev_vsi_type_to_hw_vsi_type(u16 src_type,
+					    enum nbl_vsi_serv_type *dst_type)
+{
+	switch (src_type) {
+	case NBL_VSI_DATA:
+		*dst_type = NBL_VSI_SERV_PF_DATA_TYPE;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		break;
+	}
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
index 5bfd0ddd1cec..daa3aa5fb265 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
@@ -16,8 +16,46 @@
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
-	void *reserved;  /* placeholder to be replaced in the future*/
+	/* ctrl-dev owned pfs */
+	DECLARE_BITMAP(func_bitmap, NBL_MAX_FUNC);
+	struct nbl_sriov_info *sriov_info;
+	struct nbl_eth_info *eth_info;
+	struct nbl_vsi_info *vsi_info;
+	u8 max_pf;
+	struct nbl_board_port_info board_info;
 };
 
 struct nbl_resource_mgt {
@@ -28,4 +66,13 @@ struct nbl_resource_mgt {
 	struct nbl_interrupt_mgt *intr_mgt;
 };
 
+int nbl_res_vsi_id_to_pf_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id);
+int nbl_res_func_id_to_vsi_id(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			      u16 type, u16 *vsi_id);
+int nbl_res_func_id_to_bdf(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			   u8 *bus, u8 *dev, u8 *function);
+int nbl_res_get_eth_id(struct nbl_resource_mgt *res_mgt, u16 func_id,
+		       u16 vsi_id, u8 *eth_num, u8 *eth_id, u8 *logic_eth_id);
+void nbl_res_pf_dev_vsi_type_to_hw_vsi_type(u16 src_type,
+					    enum nbl_vsi_serv_type *dst_type);
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
index 633f7100beb0..bc741b7df7b9 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
@@ -12,6 +12,21 @@
 #include "nbl_include.h"
 
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
index d55934af5a9a..bbcd06806899 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
@@ -6,10 +6,26 @@
 #ifndef _NBL_DEF_RESOURCE_H_
 #define _NBL_DEF_RESOURCE_H_
 
+#include <linux/types.h>
+
 struct nbl_resource_mgt;
 struct nbl_adapter;
 
 struct nbl_resource_ops {
+	int (*init_chip_module)(struct nbl_resource_mgt *res_mgt);
+	void (*deinit_chip_module)(struct nbl_resource_mgt *res_mgt);
+
+	int (*configure_msix_map)(struct nbl_resource_mgt *res_mgt, u16 func_id,
+				  u16 num_net_msix, u16 num_others_msix,
+				  bool net_msix_mask_en);
+	int (*destroy_msix_map)(struct nbl_resource_mgt *res_mgt, u16 func_id);
+	int (*set_mailbox_irq)(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			       u16 vector_id, bool enable_msix);
+	int (*get_vsi_id)(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			  u16 type, u16 *vsi_id);
+	int (*get_eth_id)(struct nbl_resource_mgt *res_mgt, u16 func_id,
+			  u16 vsi_id, u8 *eth_num, u8 *eth_id,
+			  u8 *logic_eth_id);
 };
 
 struct nbl_resource_ops_tbl {
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index fcd26cf898b0..be72bc100adb 100644
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


