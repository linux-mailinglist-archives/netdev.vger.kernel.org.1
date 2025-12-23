Return-Path: <netdev+bounces-245804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD92CD806F
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 05:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2C7E301FBD4
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 04:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EBD30EF9A;
	Tue, 23 Dec 2025 03:57:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-93.mail.aliyun.com (out28-93.mail.aliyun.com [115.124.28.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2D5303CB0;
	Tue, 23 Dec 2025 03:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766462257; cv=none; b=D9El8ko3Er/STviic79hMndOBUFGWmQvT76BEd6oY1zuyGXOcMYaON8hnmy6zANWd70XAw8Rjwhb3js3/WtRpcpgB7qGvaeeyKan8hnZhlLe0xroalVsukYaWnpdKd1szk9WBSE+etX0akmknK73zj9AKh4+YQ3xO/w3kB/icZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766462257; c=relaxed/simple;
	bh=hxdTgL5ici4zmn9sCmgzCZOAn7k9hS3JqgiNhwmY2h4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NlKNEFoT3ABQqcXeP1An/+UjH1dt7g+3fChWNWOFI2J6RFMlBdYgNhtizE4NJ+E8NNL2RbNycSBzreYkvMJwrKczOMwQ2AdV3nfGIqK/qSU/3TpfmwydV626xZ/ayayj1OQ+jnFRkYyVcVo7AnY8ff/SBqCNN68BPr7HN88nH/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.fqrxWiz_1766461894 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 11:51:36 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 net-next 07/15] net/nebula-matrix: add vsi, queue, adminq resource definitions and implementation
Date: Tue, 23 Dec 2025 11:50:30 +0800
Message-ID: <20251223035113.31122-8-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223035113.31122-1-illusion.wang@nebula-matrix.com>
References: <20251223035113.31122-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

vsi resource management functions include:
  VSI basic operations (promiscuous mode, anti-spoofing checks, etc.)
  Hardware module initialization and de-initialization
  Function registration (MAC address, VLAN, trust status, etc.)
queue resource management functions include:
  queue init, queue deinit
  queue alooc, free
  queue rss cfg
  queue hw cfg
  queue qos and rate control
  queue desc gother
Adminq resource management functions include:
  Hardware Configuration: Send configuration commands to the hardware via AdminQ 
(such as setting port properties, queue quantities, MAC addresses, etc.).
  State Monitoring: Obtain hardware status (such as link status, port properties, 
statistical information, etc.).
  Firmware Management: Support firmware reading, writing, erasing, checksum 
verification, and activation.
  Event Notification: Handle hardware events (such as link status changes, 
module insertion and removal).
  Command Filtering: Conduct legality checks on commands sent to the hardware.

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
Change-Id: Ic1e66ca2b6f4ed94b2367a996161d2f5f874caae
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |    4 +
 .../nebula-matrix/nbl/nbl_hw/nbl_adminq.c     | 1413 ++++++
 .../nbl_hw/nbl_hw_leonis/base/nbl_datapath.h  |   14 +
 .../nbl_hw_leonis/base/nbl_datapath_dpa.h     |  765 ++++
 .../nbl_hw_leonis/base/nbl_datapath_dped.h    | 2152 +++++++++
 .../nbl_hw_leonis/base/nbl_datapath_dstore.h  |  957 ++++
 .../nbl_hw_leonis/base/nbl_datapath_ucar.h    |  414 ++
 .../nbl_hw_leonis/base/nbl_datapath_upa.h     |  822 ++++
 .../nbl_hw_leonis/base/nbl_datapath_uped.h    | 1499 +++++++
 .../nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe.h   |   16 +
 .../nbl_hw/nbl_hw_leonis/base/nbl_ppe_acl.h   | 2417 +++++++++++
 .../nbl_hw/nbl_hw_leonis/base/nbl_ppe_epro.h  |  665 +++
 .../nbl_hw/nbl_hw_leonis/base/nbl_ppe_fem.h   | 1490 +++++++
 .../nbl_hw/nbl_hw_leonis/base/nbl_ppe_ipro.h  | 1397 ++++++
 .../nbl_hw/nbl_hw_leonis/base/nbl_ppe_mcc.h   |  412 ++
 .../nbl_hw/nbl_hw_leonis/base/nbl_ppe_pp0.h   |  619 +++
 .../nbl_hw/nbl_hw_leonis/base/nbl_ppe_pp1.h   |  701 +++
 .../nbl_hw/nbl_hw_leonis/base/nbl_ppe_pp2.h   |  619 +++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  | 1682 ++++++-
 .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.c | 3864 +++++++++++++++++
 .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.h |   12 +
 .../nbl_hw/nbl_hw_leonis/nbl_queue_leonis.c   | 1373 ++++++
 .../nbl_hw/nbl_hw_leonis/nbl_queue_leonis.h   |   25 +
 .../nbl_hw_leonis/nbl_resource_leonis.c       |   31 +
 .../nbl_hw_leonis/nbl_resource_leonis.h       |   10 +
 .../nebula-matrix/nbl/nbl_hw/nbl_p4_actions.h |   59 +
 .../nebula-matrix/nbl/nbl_hw/nbl_queue.c      |   56 +
 .../nebula-matrix/nbl/nbl_hw/nbl_queue.h      |   11 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.c   |   16 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |   10 +
 .../nebula-matrix/nbl/nbl_hw/nbl_vsi.c        |  270 ++
 .../nebula-matrix/nbl/nbl_hw/nbl_vsi.h        |   12 +
 .../nbl/nbl_include/nbl_def_hw.h              |   50 +
 .../nbl/nbl_include/nbl_include.h             |  119 +
 34 files changed, 23969 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_dpa.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_dped.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_dstore.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_ucar.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_upa.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_uped.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_acl.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_epro.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_fem.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_ipro.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_mcc.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_pp0.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_pp1.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_pp2.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_queue_leonis.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_queue_leonis.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_p4_actions.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_queue.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_queue.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index f7a78a2b2f54..ab6bb61d7b03 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -7,9 +7,13 @@ obj-$(CONFIG_NBL_CORE) := nbl_core.o
 nbl_core-objs +=       nbl_common/nbl_common.o \
 				nbl_channel/nbl_channel.o \
 				nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
+				nbl_hw/nbl_hw_leonis/nbl_queue_leonis.o \
 				nbl_hw/nbl_hw_leonis/nbl_resource_leonis.o \
+				nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.o \
 				nbl_hw/nbl_resource.o \
 				nbl_hw/nbl_interrupt.o \
+				nbl_hw/nbl_queue.o \
+				nbl_hw/nbl_vsi.o \
 				nbl_hw/nbl_adminq.o \
 				nbl_main.o
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_adminq.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_adminq.c
index fadb5cf41154..edc63d69b8cc 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_adminq.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_adminq.c
@@ -6,6 +6,265 @@
 
 #include "nbl_adminq.h"
 
+static int nbl_res_adminq_update_ring_num(void *priv);
+
+/* ****   FW CMD FILTERS START  **** */
+
+static int nbl_res_adminq_check_net_ring_num(struct nbl_resource_mgt *res_mgt,
+					     struct nbl_fw_cmd_net_ring_num_param *param)
+{
+	struct nbl_resource_info *res_info = NBL_RES_MGT_TO_RES_INFO(res_mgt);
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	u32 sum = 0, pf_real_num = 0, vf_real_num = 0;
+	int i;
+
+	pf_real_num = NBL_VSI_PF_LEGAL_QUEUE_NUM(param->pf_def_max_net_qp_num);
+	vf_real_num = NBL_VSI_VF_REAL_QUEUE_NUM(param->vf_def_max_net_qp_num);
+
+	if (pf_real_num > NBL_MAX_TXRX_QUEUE_PER_FUNC || vf_real_num > NBL_MAX_TXRX_QUEUE_PER_FUNC)
+		return -EINVAL;
+
+	for (i = 0; i < NBL_COMMON_TO_ETH_MODE(common); i++) {
+		pf_real_num = param->net_max_qp_num[i] ?
+			      NBL_VSI_PF_LEGAL_QUEUE_NUM(param->net_max_qp_num[i]) :
+			      NBL_VSI_PF_LEGAL_QUEUE_NUM(param->pf_def_max_net_qp_num);
+
+		if (pf_real_num > NBL_MAX_TXRX_QUEUE_PER_FUNC)
+			return -EINVAL;
+
+		pf_real_num = param->net_max_qp_num[i] ?
+			      NBL_VSI_PF_MAX_QUEUE_NUM(param->net_max_qp_num[i]) :
+			      NBL_VSI_PF_MAX_QUEUE_NUM(param->pf_def_max_net_qp_num);
+		if (pf_real_num > NBL_MAX_TXRX_QUEUE_PER_FUNC)
+			pf_real_num = NBL_MAX_TXRX_QUEUE_PER_FUNC;
+
+		sum += pf_real_num;
+	}
+
+	for (i = 0; i < res_info->max_vf_num; i++) {
+		vf_real_num = param->net_max_qp_num[i + NBL_MAX_PF] ?
+			      NBL_VSI_VF_REAL_QUEUE_NUM(param->net_max_qp_num[i + NBL_MAX_PF]) :
+			      NBL_VSI_VF_REAL_QUEUE_NUM(param->vf_def_max_net_qp_num);
+
+		if (vf_real_num > NBL_MAX_TXRX_QUEUE_PER_FUNC)
+			return -EINVAL;
+
+		sum += vf_real_num;
+	}
+
+	if (sum > NBL_MAX_TXRX_QUEUE)
+		return -EINVAL;
+
+	return 0;
+}
+
+static u32 nbl_res_adminq_sum_vf_num(struct nbl_fw_cmd_vf_num_param *param)
+{
+	u32 count = 0;
+	int i;
+
+	for (i = 0; i < NBL_VF_NUM_CMD_LEN; i++)
+		count += param->vf_max_num[i];
+
+	return count;
+}
+
+static int nbl_res_adminq_check_vf_num_type(struct nbl_resource_mgt *res_mgt,
+					    struct nbl_fw_cmd_vf_num_param *param)
+{
+	u32 count;
+
+	count = nbl_res_adminq_sum_vf_num(param);
+	if (count > NBL_MAX_VF)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int nbl_res_fw_cmd_filter_rw_in(struct nbl_resource_mgt *res_mgt, void *data, u16 len)
+{
+	struct nbl_chan_resource_write_param *param = (struct nbl_chan_resource_write_param *)data;
+	struct nbl_fw_cmd_net_ring_num_param *net_ring_num_param;
+	struct nbl_fw_cmd_vf_num_param *vf_num_param;
+
+	switch (param->resid) {
+	case NBL_ADMINQ_PFA_TLV_NET_RING_NUM:
+		net_ring_num_param = (struct nbl_fw_cmd_net_ring_num_param *)param->data;
+		return nbl_res_adminq_check_net_ring_num(res_mgt, net_ring_num_param);
+	case NBL_ADMINQ_PFA_TLV_VF_NUM:
+		vf_num_param = (struct nbl_fw_cmd_vf_num_param *)param->data;
+		return nbl_res_adminq_check_vf_num_type(res_mgt, vf_num_param);
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int nbl_res_fw_cmd_filter_rw_out(struct nbl_resource_mgt *res_mgt, void *in, u16 in_len,
+					void *out, u16 out_len)
+{
+	struct nbl_resource_info *res_info = NBL_RES_MGT_TO_RES_INFO(res_mgt);
+	struct nbl_net_ring_num_info *num_info = &res_info->net_ring_num_info;
+	struct nbl_chan_resource_write_param *param = (struct nbl_chan_resource_write_param *)in;
+	struct nbl_fw_cmd_net_ring_num_param *net_ring_num_param;
+	struct nbl_fw_cmd_vf_num_param *vf_num_param;
+	size_t copy_len;
+	u32 count;
+
+	switch (param->resid) {
+	case NBL_ADMINQ_PFA_TLV_NET_RING_NUM:
+		net_ring_num_param = (struct nbl_fw_cmd_net_ring_num_param *)param->data;
+		copy_len = min_t(size_t, sizeof(*num_info), (size_t)in_len);
+		memcpy(num_info, net_ring_num_param, copy_len);
+		break;
+	case NBL_ADMINQ_PFA_TLV_VF_NUM:
+		vf_num_param = (struct nbl_fw_cmd_vf_num_param *)param->data;
+		count = nbl_res_adminq_sum_vf_num(vf_num_param);
+		res_info->max_vf_num = count;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static void nbl_res_adminq_add_cmd_filter_res_write(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_adminq_mgt *adminq_mgt = NBL_RES_MGT_TO_ADMINQ_MGT(res_mgt);
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct nbl_res_fw_cmd_filter filter = {
+		.in = nbl_res_fw_cmd_filter_rw_in,
+		.out = nbl_res_fw_cmd_filter_rw_out,
+	};
+	u16 key = 0;
+
+	key = NBL_CHAN_MSG_ADMINQ_RESOURCE_WRITE;
+
+	if (nbl_common_alloc_hash_node(adminq_mgt->cmd_filter, &key, &filter, NULL))
+		nbl_warn(common, NBL_DEBUG_ADMINQ, "Fail to register res_write in filter");
+}
+
+/* ****   FW CMD FILTERS END   **** */
+
+static int nbl_res_adminq_set_module_eeprom_info(struct nbl_resource_mgt *res_mgt,
+						 u8 eth_id,
+						 u8 i2c_address,
+						 u8 page,
+						 u8 bank,
+						 u32 offset,
+						 u32 length,
+						 u8 *data)
+{
+	struct nbl_channel_ops *chan_ops = NBL_RES_MGT_TO_CHAN_OPS(res_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(res_mgt->common);
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	struct nbl_chan_send_info chan_send;
+	struct nbl_chan_param_module_eeprom_info param = {0};
+	u32 xfer_size = 0;
+	u32 byte_offset = 0;
+	int data_length = length;
+	int ret = 0;
+
+	do {
+		xfer_size = min_t(u32, data_length, NBL_MODULE_EEPRO_WRITE_MAX_LEN);
+		data_length -= xfer_size;
+
+		param.eth_id = eth_id;
+		param.i2c_address = i2c_address;
+		param.page = page;
+		param.bank = bank;
+		param.write = 1;
+		param.version = 1;
+		param.offset = offset + byte_offset;
+		param.length = xfer_size;
+		memcpy(param.data, data + byte_offset, xfer_size);
+
+		NBL_CHAN_SEND(chan_send, NBL_CHAN_ADMINQ_FUNCTION_ID,
+			      NBL_CHAN_MSG_ADMINQ_GET_MODULE_EEPROM,
+			      &param, sizeof(param), NULL, 0, 1);
+		ret = chan_ops->send_msg(NBL_RES_MGT_TO_CHAN_PRIV(res_mgt), &chan_send);
+		if (ret) {
+			dev_err(dev, "adminq send msg failed: %d, msg: 0x%x, eth_id:%d, addr:%d,",
+				ret, NBL_CHAN_MSG_ADMINQ_GET_MODULE_EEPROM,
+				eth_info->logic_eth_id[eth_id], i2c_address);
+			dev_err(dev, "page:%d, bank:%d, offset:%d, length:%d\n",
+				page, bank, offset + byte_offset, xfer_size);
+		}
+		byte_offset += xfer_size;
+	} while (!ret && data_length > 0);
+
+	return ret;
+}
+
+static int nbl_res_adminq_turn_module_eeprom_page(struct nbl_resource_mgt *res_mgt,
+						  u8 eth_id, u8 page)
+{
+	int ret;
+	struct device *dev = NBL_COMMON_TO_DEV(res_mgt->common);
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+
+	ret = nbl_res_adminq_set_module_eeprom_info(res_mgt, eth_id, I2C_DEV_ADDR_A0, 0, 0,
+						    SFF_8636_TURNPAGE_ADDR, 1, &page);
+	if (ret) {
+		dev_err(dev, "eth %d set_module_eeprom_info failed %d\n",
+			eth_info->logic_eth_id[eth_id], ret);
+		return -EIO;
+	}
+
+	return ret;
+}
+
+static int nbl_res_adminq_get_module_eeprom_info(struct nbl_resource_mgt *res_mgt,
+						 u8 eth_id,
+						 u8 i2c_address,
+						 u8 page,
+						 u8 bank,
+						 u32 offset,
+						 u32 length,
+						 u8 *data)
+{
+	struct nbl_channel_ops *chan_ops = NBL_RES_MGT_TO_CHAN_OPS(res_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(res_mgt->common);
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	struct nbl_chan_send_info chan_send;
+	struct nbl_chan_param_module_eeprom_info param = {0};
+	u32 xfer_size = 0;
+	u32 byte_offset = 0;
+	int data_length = length;
+	int ret = 0;
+
+	/* read a maximum of 128 bytes each time */
+	do {
+		xfer_size = min_t(u32, data_length, NBL_MAX_HW_I2C_RESP_SIZE);
+		data_length -= xfer_size;
+
+		param.eth_id = eth_id;
+		param.i2c_address = i2c_address;
+		param.page = page;
+		param.bank = bank;
+		param.write = 0;
+		param.version = 1;
+		param.offset = offset + byte_offset;
+		param.length = xfer_size;
+
+		NBL_CHAN_SEND(chan_send, NBL_CHAN_ADMINQ_FUNCTION_ID,
+			      NBL_CHAN_MSG_ADMINQ_GET_MODULE_EEPROM,
+			      &param, sizeof(param), data + byte_offset, xfer_size, 1);
+		ret = chan_ops->send_msg(NBL_RES_MGT_TO_CHAN_PRIV(res_mgt), &chan_send);
+		if (ret) {
+			dev_err(dev, "adminq send msg failed: %d, msg: 0x%x, eth_id:%d, addr:%d,",
+				ret, NBL_CHAN_MSG_ADMINQ_GET_MODULE_EEPROM,
+				eth_info->logic_eth_id[eth_id], i2c_address);
+			dev_err(dev, "page:%d, bank:%d, offset:%d, length:%d\n",
+				page, bank, offset + byte_offset, xfer_size);
+		}
+		byte_offset += xfer_size;
+	} while (!ret && data_length > 0);
+
+	return ret;
+}
+
 static int nbl_res_adminq_set_sfp_state(void *priv, u8 eth_id, u8 state)
 {
 	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
@@ -55,6 +314,451 @@ int nbl_res_open_sfp(struct nbl_resource_mgt *res_mgt, u8 eth_id)
 	return nbl_res_adminq_set_sfp_state(res_mgt, eth_id, NBL_SFP_MODULE_ON);
 }
 
+static bool nbl_res_adminq_check_fw_heartbeat(void *priv)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_adminq_mgt *adminq_mgt = NBL_RES_MGT_TO_ADMINQ_MGT(res_mgt);
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	unsigned long check_time;
+	u32 seq_acked;
+
+	if (adminq_mgt->fw_resetting) {
+		adminq_mgt->fw_last_hb_seq++;
+		return false;
+	}
+
+	check_time = jiffies;
+	if (time_before(check_time, adminq_mgt->fw_last_hb_time + 5 * HZ))
+		return true;
+
+	seq_acked = hw_ops->get_fw_pong(NBL_RES_MGT_TO_HW_PRIV(res_mgt));
+	if (adminq_mgt->fw_last_hb_seq == seq_acked) {
+		adminq_mgt->fw_last_hb_seq++;
+		adminq_mgt->fw_last_hb_time = check_time;
+		hw_ops->set_fw_ping(NBL_RES_MGT_TO_HW_PRIV(res_mgt), adminq_mgt->fw_last_hb_seq);
+		return true;
+	}
+
+	return false;
+}
+
+static bool nbl_res_adminq_check_fw_reset(void *priv)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_adminq_mgt *adminq_mgt = NBL_RES_MGT_TO_ADMINQ_MGT(res_mgt);
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	u32 seq_acked;
+
+	seq_acked = hw_ops->get_fw_pong(NBL_RES_MGT_TO_HW_PRIV(res_mgt));
+	if (adminq_mgt->fw_last_hb_seq != seq_acked) {
+		hw_ops->set_fw_ping(NBL_RES_MGT_TO_HW_PRIV(res_mgt), adminq_mgt->fw_last_hb_seq);
+		return false;
+	}
+
+	adminq_mgt->fw_resetting = false;
+	wake_up(&adminq_mgt->wait_queue);
+	return true;
+}
+
+static int nbl_res_adminq_get_port_attributes(void *priv)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_RES_MGT_TO_CHAN_OPS(res_mgt);
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(res_mgt->common);
+	struct nbl_chan_send_info chan_send;
+	struct nbl_port_key *param;
+	int param_len = 0;
+	u64 port_caps = 0;
+	u64 port_advertising = 0;
+	u64 key = 0;
+	int eth_id = 0;
+	int ret;
+
+	param_len = sizeof(struct nbl_port_key) + 1 * sizeof(u64);
+	param = kzalloc(param_len, GFP_KERNEL);
+
+	for_each_set_bit(eth_id, eth_info->eth_bitmap, NBL_MAX_ETHERNET) {
+		key = NBL_PORT_KEY_CAPABILITIES;
+		port_caps = 0;
+
+		memset(param, 0, param_len);
+		param->id = eth_id;
+		param->subop = NBL_PORT_SUBOP_READ;
+		param->data[0] = key << NBL_PORT_KEY_KEY_SHIFT;
+
+		NBL_CHAN_SEND(chan_send, NBL_CHAN_ADMINQ_FUNCTION_ID,
+			      NBL_CHAN_MSG_ADMINQ_MANAGE_PORT_ATTRIBUTES,
+			      param, param_len, (void *)&port_caps, sizeof(port_caps), 1);
+		ret = chan_ops->send_msg(NBL_RES_MGT_TO_CHAN_PRIV(res_mgt), &chan_send);
+		if (ret) {
+			dev_err(dev, "adminq send msg failed with ret: %d, msg_type: 0x%x, eth_id:%d, get_port_caps\n",
+				ret, NBL_CHAN_MSG_ADMINQ_MANAGE_PORT_ATTRIBUTES,
+				eth_info->logic_eth_id[eth_id]);
+			kfree(param);
+			return ret;
+		}
+
+		eth_info->port_caps[eth_id] = port_caps & NBL_PORT_KEY_DATA_MASK;
+
+		dev_info(dev, "ctrl dev get eth %d port caps: %llx\n",
+			 eth_info->logic_eth_id[eth_id],
+			 eth_info->port_caps[eth_id]);
+	}
+
+	for_each_set_bit(eth_id, eth_info->eth_bitmap, NBL_MAX_ETHERNET) {
+		key = NBL_PORT_KEY_ADVERT;
+		port_advertising = 0;
+
+		memset(param, 0, param_len);
+		param->id = eth_id;
+		param->subop = NBL_PORT_SUBOP_READ;
+		param->data[0] = key << NBL_PORT_KEY_KEY_SHIFT;
+
+		NBL_CHAN_SEND(chan_send, NBL_CHAN_ADMINQ_FUNCTION_ID,
+			      NBL_CHAN_MSG_ADMINQ_MANAGE_PORT_ATTRIBUTES,
+			      param, param_len,
+			      (void *)&port_advertising, sizeof(port_advertising), 1);
+		ret = chan_ops->send_msg(NBL_RES_MGT_TO_CHAN_PRIV(res_mgt), &chan_send);
+		if (ret) {
+			dev_err(dev, "adminq send msg failed with ret: %d, msg_type: 0x%x, eth_id:%d, port_advertising\n",
+				ret, NBL_CHAN_MSG_ADMINQ_MANAGE_PORT_ATTRIBUTES,
+				eth_info->logic_eth_id[eth_id]);
+			kfree(param);
+			return ret;
+		}
+
+		port_advertising = port_advertising & NBL_PORT_KEY_DATA_MASK;
+		/* set default FEC mode: auto */
+		port_advertising = port_advertising & ~NBL_PORT_CAP_FEC_MASK;
+		port_advertising += BIT(NBL_PORT_CAP_FEC_RS);
+		port_advertising += BIT(NBL_PORT_CAP_FEC_BASER);
+		/* set default pause: tx on, rx on */
+		port_advertising = port_advertising & ~NBL_PORT_CAP_PAUSE_MASK;
+		port_advertising += BIT(NBL_PORT_CAP_TX_PAUSE);
+		port_advertising += BIT(NBL_PORT_CAP_RX_PAUSE);
+		eth_info->port_advertising[eth_id] = port_advertising;
+
+		dev_info(dev, "ctrl dev get eth %d port advertising: %llx\n",
+			 eth_info->logic_eth_id[eth_id],
+			 eth_info->port_advertising[eth_id]);
+	}
+
+	kfree(param);
+	return 0;
+}
+
+static int nbl_res_adminq_enable_port(void *priv, bool enable)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_RES_MGT_TO_CHAN_OPS(res_mgt);
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(res_mgt->common);
+	struct nbl_chan_send_info chan_send;
+	struct nbl_port_key *param;
+	int param_len = 0;
+	u64 data = 0;
+	u64 key = 0;
+	int eth_id = 0;
+	int ret;
+
+	param_len = sizeof(struct nbl_port_key) + 1 * sizeof(u64);
+	param = kzalloc(param_len, GFP_KERNEL);
+
+	if (enable) {
+		key = NBL_PORT_KEY_ENABLE;
+		data = NBL_PORT_FLAG_ENABLE_NOTIFY + (key << NBL_PORT_KEY_KEY_SHIFT);
+	} else {
+		key = NBL_PORT_KEY_DISABLE;
+		data = key << NBL_PORT_KEY_KEY_SHIFT;
+	}
+
+	for_each_set_bit(eth_id, eth_info->eth_bitmap, NBL_MAX_ETHERNET) {
+		nbl_res_adminq_set_sfp_state(res_mgt, eth_id, NBL_SFP_MODULE_ON);
+
+		memset(param, 0, param_len);
+		param->id = eth_id;
+		param->subop = NBL_PORT_SUBOP_WRITE;
+		param->data[0] = data;
+
+		NBL_CHAN_SEND(chan_send, NBL_CHAN_ADMINQ_FUNCTION_ID,
+			      NBL_CHAN_MSG_ADMINQ_MANAGE_PORT_ATTRIBUTES,
+			      param, param_len, NULL, 0, 1);
+		ret = chan_ops->send_msg(NBL_RES_MGT_TO_CHAN_PRIV(res_mgt), &chan_send);
+		if (ret) {
+			dev_err(dev, "adminq send msg failed with ret: %d, msg_type: 0x%x, eth_id:%d, %s port\n",
+				ret, NBL_CHAN_MSG_ADMINQ_MANAGE_PORT_ATTRIBUTES,
+				eth_info->logic_eth_id[eth_id], enable ? "enable" : "disable");
+			kfree(param);
+			return ret;
+		}
+
+		dev_info(dev, "ctrl dev %s eth %d\n", enable ? "enable" : "disable",
+			 eth_info->logic_eth_id[eth_id]);
+	}
+
+	kfree(param);
+	return 0;
+}
+
+static int nbl_res_adminq_get_special_port_type(struct nbl_resource_mgt *res_mgt, u8 eth_id)
+{
+	struct device *dev = NBL_COMMON_TO_DEV(res_mgt->common);
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	u8 port_type = NBL_PORT_TYPE_UNKNOWN;
+	u8 cable_tech = 0;
+	int ret;
+
+	ret = nbl_res_adminq_turn_module_eeprom_page(res_mgt, eth_id, 0);
+	if (ret) {
+		dev_err(dev, "eth %d get_module_eeprom_info failed %d\n",
+			eth_info->logic_eth_id[eth_id], ret);
+		port_type = NBL_PORT_TYPE_UNKNOWN;
+		return port_type;
+	}
+
+	ret = nbl_res_adminq_get_module_eeprom_info(res_mgt, eth_id, I2C_DEV_ADDR_A0,
+						    0, 0, SFF8636_DEVICE_TECH_OFFSET,
+						    1, &cable_tech);
+	if (ret) {
+		dev_err(dev, "eth %d get_module_eeprom_info failed %d\n",
+			eth_info->logic_eth_id[eth_id], ret);
+		port_type = NBL_PORT_TYPE_UNKNOWN;
+		return port_type;
+	}
+	cable_tech = (cable_tech >> 4) & 0x0f;
+	switch (cable_tech) {
+	case SFF8636_TRANSMIT_FIBER_850nm_VCSEL:
+	case SFF8636_TRANSMIT_FIBER_1310nm_VCSEL:
+	case SFF8636_TRANSMIT_FIBER_1550nm_VCSEL:
+	case SFF8636_TRANSMIT_FIBER_1310nm_FP:
+	case SFF8636_TRANSMIT_FIBER_1310nm_DFB:
+	case SFF8636_TRANSMIT_FIBER_1550nm_DFB:
+	case SFF8636_TRANSMIT_FIBER_1310nm_EML:
+	case SFF8636_TRANSMIT_FIBER_1550nm_EML:
+	case SFF8636_TRANSMIT_FIBER_1490nm_DFB:
+		port_type = NBL_PORT_TYPE_FIBRE;
+		break;
+	case SFF8636_TRANSMIT_COPPER_UNEQUA:
+	case SFF8636_TRANSMIT_COPPER_PASSIVE_EQUALIZED:
+	case SFF8636_TRANSMIT_COPPER_NEAR_FAR_END:
+	case SFF8636_TRANSMIT_COPPER_FAR_END:
+	case SFF8636_TRANSMIT_COPPER_NEAR_END:
+	case SFF8636_TRANSMIT_COPPER_LINEAR_ACTIVE:
+		port_type = NBL_PORT_TYPE_COPPER;
+		break;
+	default:
+		dev_err(dev, "eth %d unknown port_type\n", eth_info->logic_eth_id[eth_id]);
+		port_type = NBL_PORT_TYPE_UNKNOWN;
+		break;
+	}
+	return port_type;
+}
+
+static int nbl_res_adminq_get_common_port_type(struct nbl_resource_mgt *res_mgt, u8 eth_id)
+{
+	struct device *dev = NBL_COMMON_TO_DEV(res_mgt->common);
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	u8 data[SFF_8472_CABLE_SPEC_COMP + 1];
+	u8 cable_tech = 0;
+	u8 cable_comp = 0;
+	u8 port_type = NBL_PORT_TYPE_UNKNOWN;
+	int ret;
+
+	ret = nbl_res_adminq_get_module_eeprom_info(res_mgt, eth_id, I2C_DEV_ADDR_A0, 0, 0, 0,
+						    SFF_8472_CABLE_SPEC_COMP + 1, data);
+	if (ret) {
+		dev_err(dev, "eth %d get_module_eeprom_info failed %d\n",
+			eth_info->logic_eth_id[eth_id], ret);
+		port_type = NBL_PORT_TYPE_UNKNOWN;
+		return port_type;
+	}
+
+	cable_tech = data[SFF_8472_CABLE_TECHNOLOGY];
+
+	if (cable_tech & SFF_PASSIVE_CABLE) {
+		cable_comp = data[SFF_8472_CABLE_SPEC_COMP];
+
+		/* determine if the port is a cooper cable */
+		if (cable_comp == SFF_COPPER_UNSPECIFIED ||
+		    cable_comp == SFF_COPPER_8431_APPENDIX_E)
+			port_type = NBL_PORT_TYPE_COPPER;
+		else
+			port_type = NBL_PORT_TYPE_FIBRE;
+	} else if (cable_tech & SFF_ACTIVE_CABLE) {
+		cable_comp = data[SFF_8472_CABLE_SPEC_COMP];
+
+		/* determine if the port is a cooper cable */
+		if (cable_comp == SFF_COPPER_UNSPECIFIED ||
+		    cable_comp == SFF_COPPER_8431_APPENDIX_E ||
+		    cable_comp == SFF_COPPER_8431_LIMITING)
+			port_type = NBL_PORT_TYPE_COPPER;
+		else
+			port_type = NBL_PORT_TYPE_FIBRE;
+	} else {
+		port_type = NBL_PORT_TYPE_FIBRE;
+	}
+
+	return port_type;
+}
+
+static int nbl_res_adminq_get_port_type(struct nbl_resource_mgt *res_mgt, u8 eth_id)
+{
+	if (res_mgt->resource_info->board_info.eth_speed == NBL_FW_PORT_SPEED_100G)
+		return nbl_res_adminq_get_special_port_type(res_mgt, eth_id);
+
+	return nbl_res_adminq_get_common_port_type(res_mgt, eth_id);
+}
+
+static s32 nbl_res_adminq_get_module_bitrate(struct nbl_resource_mgt *res_mgt, u8 eth_id)
+{
+	struct device *dev = NBL_COMMON_TO_DEV(res_mgt->common);
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	u8 data[SFF_8472_SIGNALING_RATE_MAX + 1];
+	u32 result;
+	u8 br_nom;
+	u8 br_max;
+	u8 identifier;
+	u8 encoding = 0;
+	int port_max_rate;
+	int ret;
+
+	if (res_mgt->resource_info->board_info.eth_speed == NBL_FW_PORT_SPEED_100G) {
+		ret = nbl_res_adminq_turn_module_eeprom_page(res_mgt, eth_id, 0);
+		if (ret) {
+			dev_err(dev, "eth %d get_module_eeprom_info failed %d\n",
+				eth_info->logic_eth_id[eth_id], ret);
+			return NBL_PORT_MAX_RATE_UNKNOWN;
+		}
+	}
+
+	ret = nbl_res_adminq_get_module_eeprom_info(res_mgt, eth_id, I2C_DEV_ADDR_A0, 0, 0, 0,
+						    SFF_8472_SIGNALING_RATE_MAX + 1, data);
+	if (ret) {
+		dev_err(dev, "eth %d get_module_eeprom_info failed %d\n",
+			eth_info->logic_eth_id[eth_id], ret);
+		return NBL_PORT_MAX_RATE_UNKNOWN;
+	}
+
+	if (res_mgt->resource_info->board_info.eth_speed == NBL_FW_PORT_SPEED_100G) {
+		ret = nbl_res_adminq_get_module_eeprom_info(res_mgt, eth_id,
+							    I2C_DEV_ADDR_A0, 0, 0,
+							    SFF_8636_VENDOR_ENCODING,
+							    1, &encoding);
+		if (ret) {
+			dev_err(dev, "eth %d get_module_eeprom_info failed %d\n",
+				eth_info->logic_eth_id[eth_id], ret);
+			return NBL_PORT_MAX_RATE_UNKNOWN;
+		}
+	}
+
+	br_nom = data[SFF_8472_SIGNALING_RATE];
+	br_max = data[SFF_8472_SIGNALING_RATE_MAX];
+	identifier = data[SFF_8472_IDENTIFIER];
+
+	/* sff-8472 section 5.6 */
+	if (br_nom == 255)
+		result = (u32)br_max * 250;
+	else if (br_nom == 0)
+		result = 0;
+	else
+		result = (u32)br_nom * 100;
+
+	switch (result / 1000) {
+	case 25:
+		port_max_rate = NBL_PORT_MAX_RATE_25G;
+		break;
+	case 10:
+		port_max_rate = NBL_PORT_MAX_RATE_10G;
+		break;
+	case 1:
+		port_max_rate = NBL_PORT_MAX_RATE_1G;
+		break;
+	default:
+		port_max_rate = NBL_PORT_MAX_RATE_UNKNOWN;
+		break;
+	}
+
+	if (identifier == SFF_IDENTIFIER_QSFP28)
+		port_max_rate = NBL_PORT_MAX_RATE_100G;
+
+	if (identifier == SFF_IDENTIFIER_PAM4 || encoding == SFF_8636_ENCODING_PAM4)
+		port_max_rate = NBL_PORT_MAX_RATE_100G_PAM4;
+
+	return port_max_rate;
+}
+
+static void nbl_res_eth_task_schedule(struct nbl_adminq_mgt *adminq_mgt)
+{
+	nbl_common_queue_work(&adminq_mgt->eth_task, true);
+}
+
+static void nbl_res_adminq_recv_port_notify(void *priv, void *data)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_adminq_mgt *adminq_mgt = NBL_RES_MGT_TO_ADMINQ_MGT(res_mgt);
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(res_mgt->common);
+	struct nbl_port_notify *notify;
+	u8 last_module_inplace = 0;
+	u8 last_link_state = 0;
+	int eth_id = 0;
+
+	notify = (struct nbl_port_notify *)data;
+	eth_id = notify->id;
+
+	dev_info(dev, "eth_id:%d link_state:%d, module_inplace:%d, speed:%d, flow_ctrl:%d, fec:%d, advertising:%llx, lp_advertising:%llx\n",
+		 eth_info->logic_eth_id[eth_id], notify->link_state, notify->module_inplace,
+		 notify->speed * 10, notify->flow_ctrl,
+		 notify->fec, notify->advertising, notify->lp_advertising);
+
+	mutex_lock(&adminq_mgt->eth_lock);
+
+	last_module_inplace = eth_info->module_inplace[eth_id];
+	last_link_state = eth_info->link_state[eth_id];
+
+	if (!notify->link_state)
+		eth_info->link_down_count[eth_id]++;
+
+	eth_info->link_state[eth_id] = notify->link_state;
+	eth_info->module_inplace[eth_id] = notify->module_inplace;
+	/* when eth link down, don not update speed
+	 * when config autoneg to off, ethtool read speed and set it with disable autoneg command,
+	 * if eth is link down, the speed from emp is not credible,
+	 * need to reserver last link up speed.
+	 */
+	if (notify->link_state || !eth_info->link_speed[eth_id])
+		eth_info->link_speed[eth_id] = notify->speed * 10;
+	eth_info->active_fc[eth_id] = notify->flow_ctrl;
+	eth_info->active_fec[eth_id] = notify->fec;
+	eth_info->port_lp_advertising[eth_id] = notify->lp_advertising;
+	eth_info->port_advertising[eth_id] = notify->advertising;
+
+	if (!last_module_inplace && notify->module_inplace) {
+		adminq_mgt->module_inplace_changed[eth_id] = 1;
+		nbl_res_eth_task_schedule(adminq_mgt);
+	}
+
+	if (last_link_state != notify->link_state) {
+		adminq_mgt->link_state_changed[eth_id] = 1;
+		nbl_res_eth_task_schedule(adminq_mgt);
+	}
+
+	mutex_unlock(&adminq_mgt->eth_lock);
+}
+
+static int nbl_res_adminq_get_link_state(void *priv, u8 eth_id,
+					 struct nbl_eth_link_info *eth_link_info)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+
+	eth_link_info->link_status = eth_info->link_state[eth_id];
+	eth_link_info->link_speed = eth_info->link_speed[eth_id];
+
+	return 0;
+}
+
 static int nbl_res_adminq_get_eth_mac_addr(void *priv, u8 *mac, u8 eth_id)
 {
 	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
@@ -105,3 +809,712 @@ int nbl_res_get_eth_mac(struct nbl_resource_mgt *res_mgt, u8 *mac, u8 eth_id)
 {
 	return nbl_res_adminq_get_eth_mac_addr(res_mgt, mac, eth_id);
 }
+
+static int nbl_res_adminq_set_eth_mac_addr(void *priv, u8 *mac, u8 eth_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_RES_MGT_TO_CHAN_OPS(res_mgt);
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(res_mgt->common);
+	struct nbl_chan_send_info chan_send;
+	struct nbl_port_key *param;
+	int param_len = 0;
+	u64 data = 0;
+	u64 key = 0;
+	int ret;
+	int i;
+	u8 reverse_mac[ETH_ALEN];
+
+	param_len = sizeof(struct nbl_port_key) + 1 * sizeof(u64);
+	param = kzalloc(param_len, GFP_KERNEL);
+
+	key = NBL_PORT_KEY_MAC_ADDRESS;
+
+	/*convert mac address*/
+	for (i = 0; i < ETH_ALEN; i++)
+		reverse_mac[i] = mac[ETH_ALEN - 1 - i];
+
+	memcpy(&data, reverse_mac, ETH_ALEN);
+
+	data += (key << NBL_PORT_KEY_KEY_SHIFT);
+
+	memset(param, 0, param_len);
+	param->id = eth_id;
+	param->subop = NBL_PORT_SUBOP_WRITE;
+	param->data[0] = data;
+
+	NBL_CHAN_SEND(chan_send, NBL_CHAN_ADMINQ_FUNCTION_ID,
+		      NBL_CHAN_MSG_ADMINQ_MANAGE_PORT_ATTRIBUTES,
+		      param, param_len, NULL, 0, 1);
+	ret = chan_ops->send_msg(NBL_RES_MGT_TO_CHAN_PRIV(res_mgt), &chan_send);
+	if (ret) {
+		dev_err(dev, "adminq send msg failed with ret: %d, msg_type: 0x%x, eth_id:%d, reverse_mac=0x%x:%x:%x:%x:%x:%x\n",
+			ret, NBL_CHAN_MSG_ADMINQ_MANAGE_PORT_ATTRIBUTES,
+			eth_info->logic_eth_id[eth_id], reverse_mac[0],
+			reverse_mac[1], reverse_mac[2], reverse_mac[3],
+			reverse_mac[4], reverse_mac[5]);
+		kfree(param);
+		return ret;
+	}
+
+	kfree(param);
+	return 0;
+}
+
+static int nbl_res_adminq_pt_filter_in(struct nbl_resource_mgt *res_mgt,
+				       struct nbl_passthrough_fw_cmd_param *param)
+{
+	struct nbl_adminq_mgt *adminq_mgt = NBL_RES_MGT_TO_ADMINQ_MGT(res_mgt);
+	struct nbl_res_fw_cmd_filter *filter;
+
+	filter = nbl_common_get_hash_node(adminq_mgt->cmd_filter, &param->opcode);
+	if (filter && filter->in)
+		return filter->in(res_mgt, param->data, param->in_size);
+
+	return 0;
+}
+
+static int nbl_res_adminq_pt_filter_out(struct nbl_resource_mgt *res_mgt,
+					struct nbl_passthrough_fw_cmd_param *param,
+					struct nbl_passthrough_fw_cmd_param *result)
+{
+	struct nbl_adminq_mgt *adminq_mgt = NBL_RES_MGT_TO_ADMINQ_MGT(res_mgt);
+	struct nbl_res_fw_cmd_filter *filter;
+	int ret = 0;
+
+	filter = nbl_common_get_hash_node(adminq_mgt->cmd_filter, &param->opcode);
+	if (filter && filter->out)
+		ret = filter->out(res_mgt, param->data, param->in_size,
+				  result->data, result->out_size);
+
+	return 0;
+}
+
+static int nbl_res_adminq_passthrough(void *priv, struct nbl_passthrough_fw_cmd_param *param,
+				      struct nbl_passthrough_fw_cmd_param *result)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_RES_MGT_TO_CHAN_OPS(res_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(res_mgt->common);
+	struct nbl_chan_send_info chan_send;
+	u8 *in_data = NULL, *out_data = NULL;
+	int ret = 0;
+
+	ret = nbl_res_adminq_pt_filter_in(res_mgt, param);
+	if (ret)
+		return ret;
+
+	if (param->in_size) {
+		in_data = kzalloc(param->in_size, GFP_KERNEL);
+		if (!in_data)
+			goto in_data_fail;
+		memcpy(in_data, param->data, param->in_size);
+	}
+	if (param->out_size) {
+		out_data = kzalloc(param->out_size, GFP_KERNEL);
+		if (!out_data)
+			goto out_data_fail;
+	}
+
+	NBL_CHAN_SEND(chan_send, NBL_CHAN_ADMINQ_FUNCTION_ID, param->opcode,
+		      in_data, param->in_size, out_data, param->out_size, 1);
+	ret = chan_ops->send_msg(NBL_RES_MGT_TO_CHAN_PRIV(res_mgt), &chan_send);
+	if (ret) {
+		dev_dbg(dev, "adminq send msg failed with ret: %d, msg_type: 0x%x\n",
+			ret, param->opcode);
+		goto send_fail;
+	}
+
+	result->opcode = param->opcode;
+	result->errcode = ret;
+	result->out_size = param->out_size;
+	if (result->out_size)
+		memcpy(result->data, out_data, param->out_size);
+
+	nbl_res_adminq_pt_filter_out(res_mgt, param, result);
+
+send_fail:
+	kfree(out_data);
+out_data_fail:
+	kfree(in_data);
+in_data_fail:
+	return ret;
+}
+
+static int nbl_res_adminq_update_ring_num(void *priv)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_resource_info *res_info = NBL_RES_MGT_TO_RES_INFO(res_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_RES_MGT_TO_CHAN_OPS(res_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(NBL_RES_MGT_TO_COMMON(res_mgt));
+	struct nbl_chan_send_info chan_send;
+	struct nbl_chan_resource_read_param *param;
+	struct nbl_net_ring_num_info *info;
+	int ret = 0;
+
+	param = kzalloc(sizeof(*param), GFP_KERNEL);
+	if (!param) {
+		ret = -ENOMEM;
+		goto alloc_param_fail;
+	}
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		ret = -ENOMEM;
+		goto alloc_info_fail;
+	}
+
+	param->resid = NBL_ADMINQ_PFA_TLV_NET_RING_NUM;
+	param->offset = 0;
+	param->len = sizeof(*info);
+	NBL_CHAN_SEND(chan_send, NBL_CHAN_ADMINQ_FUNCTION_ID, NBL_CHAN_MSG_ADMINQ_RESOURCE_READ,
+		      param, sizeof(*param), info, sizeof(*info), 1);
+
+	ret = chan_ops->send_msg(NBL_RES_MGT_TO_CHAN_PRIV(res_mgt), &chan_send);
+	if (ret) {
+		dev_err(dev, "adminq send msg failed with ret: %d, msg_type: 0x%x\n",
+			ret, NBL_CHAN_MSG_ADMINQ_RESOURCE_READ);
+		goto send_fail;
+	}
+
+	if (info->pf_def_max_net_qp_num && info->vf_def_max_net_qp_num &&
+	    !nbl_res_adminq_check_net_ring_num(res_mgt,
+					      (struct nbl_fw_cmd_net_ring_num_param *)info))
+		memcpy(&res_info->net_ring_num_info, info, sizeof(res_info->net_ring_num_info));
+
+send_fail:
+	kfree(info);
+alloc_info_fail:
+	kfree(param);
+alloc_param_fail:
+	return ret;
+}
+
+static int nbl_res_adminq_set_ring_num(void *priv, struct nbl_fw_cmd_net_ring_num_param *param)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_RES_MGT_TO_CHAN_OPS(res_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(NBL_RES_MGT_TO_COMMON(res_mgt));
+	struct nbl_chan_send_info chan_send;
+	struct nbl_chan_resource_write_param *data;
+	int data_len = sizeof(struct nbl_fw_cmd_net_ring_num_param);
+	int ret = 0;
+
+	data = kzalloc(sizeof(*data) + data_len, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->resid = NBL_ADMINQ_PFA_TLV_NET_RING_NUM;
+	data->offset = 0;
+	data->len = data_len;
+
+	memcpy(data + 1, param, data_len);
+
+	NBL_CHAN_SEND(chan_send, NBL_CHAN_ADMINQ_FUNCTION_ID, NBL_CHAN_MSG_ADMINQ_RESOURCE_WRITE,
+		      data, sizeof(*data) + data_len, NULL, 0, 1);
+	ret = chan_ops->send_msg(NBL_RES_MGT_TO_CHAN_PRIV(res_mgt), &chan_send);
+	if (ret)
+		dev_err(dev, "adminq send msg failed with ret: %d\n", ret);
+
+	kfree(data);
+	return ret;
+}
+
+static int nbl_res_adminq_restore_default_cfg(void *priv, u8 eth_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_RES_MGT_TO_CHAN_OPS(res_mgt);
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(res_mgt->common);
+	struct nbl_chan_send_info chan_send;
+	struct nbl_port_key *param;
+	int param_len = 0;
+	u64 data = 0;
+	u64 key = 0;
+	int ret;
+
+	key = NBL_PORT_KEY_RESTORE_DEFAULTE_CFG;
+	data = (key << NBL_PORT_KEY_KEY_SHIFT);
+	param_len = sizeof(struct nbl_port_key) + 1 * sizeof(u64);
+	param = kzalloc(param_len, GFP_KERNEL);
+	param->id = eth_id;
+	param->subop = NBL_PORT_SUBOP_WRITE;
+	param->data[0] = data;
+
+	NBL_CHAN_SEND(chan_send, NBL_CHAN_ADMINQ_FUNCTION_ID,
+		      NBL_CHAN_MSG_ADMINQ_MANAGE_PORT_ATTRIBUTES,
+		      param, param_len, NULL, 0, 1);
+	ret = chan_ops->send_msg(NBL_RES_MGT_TO_CHAN_PRIV(res_mgt), &chan_send);
+	if (ret) {
+		dev_err(dev, "ctrl eth %d restore defaulte cfg failed ret %d\n",
+			eth_info->logic_eth_id[eth_id], ret);
+		kfree(param);
+		return ret;
+	}
+
+	kfree(param);
+	return 0;
+}
+
+static int nbl_res_adminq_init_port(void *priv)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	u8 eth_id;
+
+	for_each_set_bit(eth_id, eth_info->eth_bitmap, NBL_MAX_ETHERNET)
+		nbl_res_adminq_restore_default_cfg(priv, eth_id);
+
+	return 0;
+}
+
+static int nbl_res_adminq_set_wol(void *priv, u8 eth_id, bool enable)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_RES_MGT_TO_CHAN_OPS(res_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(NBL_RES_MGT_TO_COMMON(res_mgt));
+	struct nbl_chan_send_info chan_send;
+	struct nbl_chan_adminq_reg_write_param reg_write = {0};
+	struct nbl_chan_adminq_reg_read_param reg_read = {0};
+	u32 value;
+	int ret = 0;
+
+	dev_info(dev, "set_wol ethid %d %sabled", eth_id, enable ? "en" : "dis");
+
+	reg_read.reg = NBL_ADMINQ_ETH_WOL_REG_OFFSET;
+	NBL_CHAN_SEND(chan_send, NBL_CHAN_ADMINQ_FUNCTION_ID, NBL_CHAN_MSG_ADMINQ_REGISTER_READ,
+		      &reg_read, sizeof(reg_read), &value, sizeof(value), 1);
+	ret = chan_ops->send_msg(NBL_RES_MGT_TO_CHAN_PRIV(res_mgt), &chan_send);
+	if (ret) {
+		dev_err(dev, "adminq send msg failed with ret: %d\n", ret);
+		return ret;
+	}
+
+	reg_write.reg = NBL_ADMINQ_ETH_WOL_REG_OFFSET;
+	reg_write.value = (value & ~(1 << eth_id)) | (enable << eth_id);
+	NBL_CHAN_SEND(chan_send, NBL_CHAN_ADMINQ_FUNCTION_ID, NBL_CHAN_MSG_ADMINQ_REGISTER_WRITE,
+		      &reg_write, sizeof(reg_write), NULL, 0, 1);
+	ret = chan_ops->send_msg(NBL_RES_MGT_TO_CHAN_PRIV(res_mgt), &chan_send);
+	if (ret)
+		dev_err(dev, "adminq send msg failed with ret: %d\n", ret);
+
+	return ret;
+}
+
+#define ADD_ETH_STATISTICS(name)  {#name}
+static struct nbl_leonis_eth_stats_info _eth_statistics[] = {
+	ADD_ETH_STATISTICS(eth_frames_tx),
+	ADD_ETH_STATISTICS(eth_frames_tx_ok),
+	ADD_ETH_STATISTICS(eth_frames_tx_badfcs),
+	ADD_ETH_STATISTICS(eth_unicast_frames_tx_ok),
+	ADD_ETH_STATISTICS(eth_multicast_frames_tx_ok),
+	ADD_ETH_STATISTICS(eth_broadcast_frames_tx_ok),
+	ADD_ETH_STATISTICS(eth_macctrl_frames_tx_ok),
+	ADD_ETH_STATISTICS(eth_fragment_frames_tx),
+	ADD_ETH_STATISTICS(eth_fragment_frames_tx_ok),
+	ADD_ETH_STATISTICS(eth_pause_frames_tx),
+	ADD_ETH_STATISTICS(eth_pause_macctrl_frames_tx),
+	ADD_ETH_STATISTICS(eth_pfc_frames_tx),
+	ADD_ETH_STATISTICS(eth_pfc_frames_tx_prio0),
+	ADD_ETH_STATISTICS(eth_pfc_frames_tx_prio1),
+	ADD_ETH_STATISTICS(eth_pfc_frames_tx_prio2),
+	ADD_ETH_STATISTICS(eth_pfc_frames_tx_prio3),
+	ADD_ETH_STATISTICS(eth_pfc_frames_tx_prio4),
+	ADD_ETH_STATISTICS(eth_pfc_frames_tx_prio5),
+	ADD_ETH_STATISTICS(eth_pfc_frames_tx_prio6),
+	ADD_ETH_STATISTICS(eth_pfc_frames_tx_prio7),
+	ADD_ETH_STATISTICS(eth_verify_frames_tx),
+	ADD_ETH_STATISTICS(eth_respond_frames_tx),
+	ADD_ETH_STATISTICS(eth_frames_tx_64B),
+	ADD_ETH_STATISTICS(eth_frames_tx_65_to_127B),
+	ADD_ETH_STATISTICS(eth_frames_tx_128_to_255B),
+	ADD_ETH_STATISTICS(eth_frames_tx_256_to_511B),
+	ADD_ETH_STATISTICS(eth_frames_tx_512_to_1023B),
+	ADD_ETH_STATISTICS(eth_frames_tx_1024_to_1518B),
+	ADD_ETH_STATISTICS(eth_frames_tx_1519_to_2047B),
+	ADD_ETH_STATISTICS(eth_frames_tx_2048_to_MAXB),
+	ADD_ETH_STATISTICS(eth_undersize_frames_tx_goodfcs),
+	ADD_ETH_STATISTICS(eth_oversize_frames_tx_goodfcs),
+	ADD_ETH_STATISTICS(eth_undersize_frames_tx_badfcs),
+	ADD_ETH_STATISTICS(eth_oversize_frames_tx_badfcs),
+	ADD_ETH_STATISTICS(eth_octets_tx),
+	ADD_ETH_STATISTICS(eth_octets_tx_ok),
+	ADD_ETH_STATISTICS(eth_octets_tx_badfcs),
+	ADD_ETH_STATISTICS(eth_frames_rx),
+	ADD_ETH_STATISTICS(eth_frames_rx_ok),
+	ADD_ETH_STATISTICS(eth_frames_rx_badfcs),
+	ADD_ETH_STATISTICS(eth_undersize_frames_rx_goodfcs),
+	ADD_ETH_STATISTICS(eth_undersize_frames_rx_badfcs),
+	ADD_ETH_STATISTICS(eth_oversize_frames_rx_goodfcs),
+	ADD_ETH_STATISTICS(eth_oversize_frames_rx_badfcs),
+	ADD_ETH_STATISTICS(eth_frames_rx_misc_error),
+	ADD_ETH_STATISTICS(eth_frames_rx_misc_dropped),
+	ADD_ETH_STATISTICS(eth_unicast_frames_rx_ok),
+	ADD_ETH_STATISTICS(eth_multicast_frames_rx_ok),
+	ADD_ETH_STATISTICS(eth_broadcast_frames_rx_ok),
+	ADD_ETH_STATISTICS(eth_pause_frames_rx),
+	ADD_ETH_STATISTICS(eth_pfc_frames_rx),
+	ADD_ETH_STATISTICS(eth_pfc_frames_rx_prio0),
+	ADD_ETH_STATISTICS(eth_pfc_frames_rx_prio1),
+	ADD_ETH_STATISTICS(eth_pfc_frames_rx_prio2),
+	ADD_ETH_STATISTICS(eth_pfc_frames_rx_prio3),
+	ADD_ETH_STATISTICS(eth_pfc_frames_rx_prio4),
+	ADD_ETH_STATISTICS(eth_pfc_frames_rx_prio5),
+	ADD_ETH_STATISTICS(eth_pfc_frames_rx_prio6),
+	ADD_ETH_STATISTICS(eth_pfc_frames_rx_prio7),
+	ADD_ETH_STATISTICS(eth_macctrl_frames_rx),
+	ADD_ETH_STATISTICS(eth_verify_frames_rx_ok),
+	ADD_ETH_STATISTICS(eth_respond_frames_rx_ok),
+	ADD_ETH_STATISTICS(eth_fragment_frames_rx_ok),
+	ADD_ETH_STATISTICS(eth_fragment_rx_smdc_nocontext),
+	ADD_ETH_STATISTICS(eth_fragment_rx_smds_seq_error),
+	ADD_ETH_STATISTICS(eth_fragment_rx_smdc_seq_error),
+	ADD_ETH_STATISTICS(eth_fragment_rx_frag_cnt_error),
+	ADD_ETH_STATISTICS(eth_frames_assembled_ok),
+	ADD_ETH_STATISTICS(eth_frames_assembled_error),
+	ADD_ETH_STATISTICS(eth_frames_rx_64B),
+	ADD_ETH_STATISTICS(eth_frames_rx_65_to_127B),
+	ADD_ETH_STATISTICS(eth_frames_rx_128_to_255B),
+	ADD_ETH_STATISTICS(eth_frames_rx_256_to_511B),
+	ADD_ETH_STATISTICS(eth_frames_rx_512_to_1023B),
+	ADD_ETH_STATISTICS(eth_frames_rx_1024_to_1518B),
+	ADD_ETH_STATISTICS(eth_frames_rx_1519_to_2047B),
+	ADD_ETH_STATISTICS(eth_frames_rx_2048_to_MAXB),
+	ADD_ETH_STATISTICS(eth_octets_rx),
+	ADD_ETH_STATISTICS(eth_octets_rx_ok),
+	ADD_ETH_STATISTICS(eth_octets_rx_badfcs),
+	ADD_ETH_STATISTICS(eth_octets_rx_dropped),
+	ADD_ETH_STATISTICS(eth_unsupported_opcodes_rx),
+};
+
+static void nbl_res_adminq_get_private_stat_len(void *priv, u32 *len)
+{
+	*len = ARRAY_SIZE(_eth_statistics);
+}
+
+static void nbl_res_adminq_get_private_stat_data(void *priv, u32 eth_id, u64 *data, u32 data_len)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_RES_MGT_TO_CHAN_OPS(res_mgt);
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(res_mgt->common);
+	struct nbl_chan_send_info chan_send;
+	int ret = 0;
+
+	NBL_CHAN_SEND(chan_send, NBL_CHAN_ADMINQ_FUNCTION_ID,
+		      NBL_CHAN_MSG_ADMINQ_GET_ETH_STATS,
+		      &eth_id, sizeof(eth_id), data, data_len, 1);
+	ret = chan_ops->send_msg(NBL_RES_MGT_TO_CHAN_PRIV(res_mgt), &chan_send);
+	if (ret)
+		dev_err(dev, "adminq get eth %d stats failed ret: %d\n",
+			eth_info->logic_eth_id[eth_id], ret);
+}
+
+static int nbl_res_get_part_number(void *priv, char *part_number)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_RES_MGT_TO_CHAN_OPS(res_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(NBL_RES_MGT_TO_COMMON(res_mgt));
+	struct nbl_chan_send_info chan_send;
+	struct nbl_chan_resource_read_param *param;
+	struct nbl_host_board_config *info;
+	int ret = 0;
+
+	param = kzalloc(sizeof(*param), GFP_KERNEL);
+	if (!param) {
+		ret = -ENOMEM;
+		goto alloc_param_fail;
+	}
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		ret = -ENOMEM;
+		goto alloc_info_fail;
+	}
+
+	param->resid = NBL_ADMINQ_RESID_FSI_SECTION_HBC;
+	param->offset = 0;
+	param->len = sizeof(*info);
+	NBL_CHAN_SEND(chan_send, NBL_CHAN_ADMINQ_FUNCTION_ID, NBL_CHAN_MSG_ADMINQ_RESOURCE_READ,
+		      param, sizeof(*param), info, sizeof(*info), 1);
+
+	ret = chan_ops->send_msg(NBL_RES_MGT_TO_CHAN_PRIV(res_mgt), &chan_send);
+	if (ret) {
+		dev_err(dev, "adminq send msg failed with ret: %d, msg_type: 0x%x, resid: 0x%x\n",
+			ret, NBL_CHAN_MSG_ADMINQ_RESOURCE_READ, NBL_ADMINQ_RESID_FSI_SECTION_HBC);
+		goto send_fail;
+	}
+
+	memcpy(part_number, info->product_name, sizeof(info->product_name));
+
+send_fail:
+	kfree(info);
+alloc_info_fail:
+	kfree(param);
+alloc_param_fail:
+	return ret;
+}
+
+static int nbl_res_get_serial_number(void *priv, char *serial_number)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_RES_MGT_TO_CHAN_OPS(res_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(NBL_RES_MGT_TO_COMMON(res_mgt));
+	struct nbl_chan_send_info chan_send;
+	struct nbl_chan_resource_read_param *param;
+	struct nbl_serial_number_info *info;
+	int ret = 0;
+
+	param = kzalloc(sizeof(*param), GFP_KERNEL);
+	if (!param) {
+		ret = -ENOMEM;
+		goto alloc_param_fail;
+	}
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		ret = -ENOMEM;
+		goto alloc_info_fail;
+	}
+
+	param->resid = NBL_ADMINQ_RESID_FSI_TLV_SERIAL_NUMBER;
+	param->offset = 0;
+	param->len = sizeof(*info);
+	NBL_CHAN_SEND(chan_send, NBL_CHAN_ADMINQ_FUNCTION_ID, NBL_CHAN_MSG_ADMINQ_RESOURCE_READ,
+		      param, sizeof(*param), info, sizeof(*info), 1);
+
+	ret = chan_ops->send_msg(NBL_RES_MGT_TO_CHAN_PRIV(res_mgt), &chan_send);
+	if (ret) {
+		dev_err(dev, "adminq send msg failed with ret: %d, msg_type: 0x%x, resid: 0x%x\n",
+			ret, NBL_CHAN_MSG_ADMINQ_RESOURCE_READ,
+			NBL_ADMINQ_RESID_FSI_TLV_SERIAL_NUMBER);
+		goto send_fail;
+	}
+	memcpy(serial_number, info->sn, info->len);
+
+send_fail:
+	kfree(info);
+alloc_info_fail:
+	kfree(param);
+alloc_param_fail:
+	return ret;
+}
+
+/* NBL_ADMINQ_SET_OPS(ops_name, func)
+ *
+ * Use X Macros to reduce setup and remove codes.
+ */
+#define NBL_ADMINQ_OPS_TBL									\
+do {												\
+	NBL_ADMINQ_SET_OPS(set_sfp_state, nbl_res_adminq_set_sfp_state);			\
+	NBL_ADMINQ_SET_OPS(check_fw_heartbeat, nbl_res_adminq_check_fw_heartbeat);		\
+	NBL_ADMINQ_SET_OPS(check_fw_reset, nbl_res_adminq_check_fw_reset);			\
+	NBL_ADMINQ_SET_OPS(get_port_attributes, nbl_res_adminq_get_port_attributes);		\
+	NBL_ADMINQ_SET_OPS(update_ring_num, nbl_res_adminq_update_ring_num);			\
+	NBL_ADMINQ_SET_OPS(set_ring_num, nbl_res_adminq_set_ring_num);				\
+	NBL_ADMINQ_SET_OPS(init_port, nbl_res_adminq_init_port);				\
+	NBL_ADMINQ_SET_OPS(enable_port, nbl_res_adminq_enable_port);				\
+	NBL_ADMINQ_SET_OPS(recv_port_notify, nbl_res_adminq_recv_port_notify);			\
+	NBL_ADMINQ_SET_OPS(get_link_state, nbl_res_adminq_get_link_state);			\
+	NBL_ADMINQ_SET_OPS(set_eth_mac_addr, nbl_res_adminq_set_eth_mac_addr);			\
+	NBL_ADMINQ_SET_OPS(set_wol, nbl_res_adminq_set_wol);					\
+	NBL_ADMINQ_SET_OPS(passthrough_fw_cmd, nbl_res_adminq_passthrough);			\
+	NBL_ADMINQ_SET_OPS(get_private_stat_len, nbl_res_adminq_get_private_stat_len);		\
+	NBL_ADMINQ_SET_OPS(get_private_stat_data, nbl_res_adminq_get_private_stat_data);	\
+	NBL_ADMINQ_SET_OPS(get_part_number, nbl_res_get_part_number);			\
+	NBL_ADMINQ_SET_OPS(get_serial_number, nbl_res_get_serial_number);			\
+} while (0)
+
+/* Structure starts here, adding an op should not modify anything below */
+static int nbl_adminq_setup_mgt(struct device *dev, struct nbl_adminq_mgt **adminq_mgt)
+{
+	*adminq_mgt = devm_kzalloc(dev, sizeof(struct nbl_adminq_mgt), GFP_KERNEL);
+	if (!*adminq_mgt)
+		return -ENOMEM;
+
+	init_waitqueue_head(&(*adminq_mgt)->wait_queue);
+	return 0;
+}
+
+static void nbl_adminq_remove_mgt(struct device *dev, struct nbl_adminq_mgt **adminq_mgt)
+{
+	devm_kfree(dev, *adminq_mgt);
+	*adminq_mgt = NULL;
+}
+
+static int nbl_res_adminq_chan_notify_link_state_req(struct nbl_resource_mgt *res_mgt,
+						     u16 fid, u8 link_state, u32 link_speed)
+{
+	struct nbl_channel_ops *chan_ops = NBL_RES_MGT_TO_CHAN_OPS(res_mgt);
+	struct nbl_chan_send_info chan_send;
+	struct nbl_chan_param_notify_link_state link_info = {0};
+
+	chan_ops = NBL_RES_MGT_TO_CHAN_OPS(res_mgt);
+
+	link_info.link_state = link_state;
+	link_info.link_speed = link_speed;
+	NBL_CHAN_SEND(chan_send, fid, NBL_CHAN_MSG_NOTIFY_LINK_STATE, &link_info,
+		      sizeof(link_info), NULL, 0, 0);
+	return chan_ops->send_msg(NBL_RES_MGT_TO_CHAN_PRIV(res_mgt), &chan_send);
+}
+
+static void nbl_res_adminq_notify_link_state(struct nbl_resource_mgt *res_mgt, u8 eth_id,
+					     u8 link_state)
+{
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_sriov_info *sriov_info;
+	struct nbl_queue_info *queue_info;
+	u16 pf_fid = 0, vf_fid = 0, link_speed = 0;
+	int i = 0, j = 0;
+
+	for (i = 0; i < NBL_RES_MGT_TO_PF_NUM(res_mgt); i++) {
+		if (eth_info->pf_bitmap[eth_id] & BIT(i))
+			pf_fid = nbl_res_pfvfid_to_func_id(res_mgt, i, -1);
+		else
+			continue;
+
+		sriov_info = &NBL_RES_MGT_TO_SRIOV_INFO(res_mgt)[pf_fid];
+		queue_info = &queue_mgt->queue_info[pf_fid];
+
+		/* send eth's link state to pf */
+		if (queue_info->num_txrx_queues)
+			nbl_res_adminq_chan_notify_link_state_req(res_mgt,
+								  pf_fid,
+								  link_state,
+								  eth_info->link_speed[eth_id]);
+
+		/* send eth's link state to pf's all vf */
+		for (j = 0; j < sriov_info->num_vfs; j++) {
+			vf_fid = sriov_info->start_vf_func_id + j;
+			queue_info = &queue_mgt->queue_info[vf_fid];
+			if (queue_info->num_txrx_queues) {
+				link_speed = eth_info->link_speed[eth_id];
+				nbl_res_adminq_chan_notify_link_state_req(res_mgt, vf_fid,
+									  link_state,
+									  link_speed);
+			}
+		}
+	}
+}
+
+static void nbl_res_adminq_eth_task(struct work_struct *work)
+{
+	struct nbl_adminq_mgt *adminq_mgt = container_of(work, struct nbl_adminq_mgt,
+							 eth_task);
+	struct nbl_resource_mgt *res_mgt = adminq_mgt->res_mgt;
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	u8 eth_id = 0;
+	u8 port_max_rate = 0;
+
+	for (eth_id = 0 ; eth_id < NBL_MAX_ETHERNET; eth_id++) {
+		if (adminq_mgt->module_inplace_changed[eth_id]) {
+			/* module not-inplace, transitions to inplace status */
+			/* read module register */
+			port_max_rate = nbl_res_adminq_get_module_bitrate(res_mgt, eth_id);
+
+			eth_info->port_max_rate[eth_id] = port_max_rate;
+			eth_info->port_type[eth_id] = nbl_res_adminq_get_port_type(res_mgt, eth_id);
+			eth_info->module_repluged[eth_id] = 1;
+			/* cooper support auto-negotiation */
+			if (eth_info->port_type[eth_id] == NBL_PORT_TYPE_COPPER)
+				eth_info->port_caps[eth_id] |= BIT(NBL_PORT_CAP_AUTONEG);
+			else
+				eth_info->port_caps[eth_id] &= ~BIT_MASK(NBL_PORT_CAP_AUTONEG);
+
+			adminq_mgt->module_inplace_changed[eth_id] = 0;
+		}
+
+		mutex_lock(&adminq_mgt->eth_lock);
+		if (adminq_mgt->link_state_changed[eth_id]) {
+			/* eth link state changed, notify pf and vf */
+			nbl_res_adminq_notify_link_state(res_mgt, eth_id,
+							 eth_info->link_state[eth_id]);
+			adminq_mgt->link_state_changed[eth_id] = 0;
+		}
+		mutex_unlock(&adminq_mgt->eth_lock);
+	}
+}
+
+static int nbl_res_adminq_setup_cmd_filter(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_adminq_mgt *adminq_mgt = NBL_RES_MGT_TO_ADMINQ_MGT(res_mgt);
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct nbl_hash_tbl_key tbl_key = {0};
+
+	NBL_HASH_TBL_KEY_INIT(&tbl_key, NBL_COMMON_TO_DEV(common), sizeof(u16),
+			      sizeof(struct nbl_res_fw_cmd_filter),
+			      NBL_RES_FW_CMD_FILTER_MAX, false);
+
+	adminq_mgt->cmd_filter = nbl_common_init_hash_table(&tbl_key);
+	if (!adminq_mgt->cmd_filter)
+		return -EFAULT;
+
+	return 0;
+}
+
+static void nbl_res_adminq_remove_cmd_filter(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_adminq_mgt *adminq_mgt = NBL_RES_MGT_TO_ADMINQ_MGT(res_mgt);
+
+	if (adminq_mgt->cmd_filter)
+		nbl_common_remove_hash_table(adminq_mgt->cmd_filter, NULL);
+
+	adminq_mgt->cmd_filter = NULL;
+}
+
+int nbl_adminq_mgt_start(struct nbl_resource_mgt *res_mgt)
+{
+	struct device *dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	struct nbl_adminq_mgt **adminq_mgt = &NBL_RES_MGT_TO_ADMINQ_MGT(res_mgt);
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	int ret;
+
+	ret = nbl_adminq_setup_mgt(dev, adminq_mgt);
+	if (ret)
+		goto setup_mgt_fail;
+
+	(*adminq_mgt)->res_mgt = res_mgt;
+
+	(*adminq_mgt)->fw_last_hb_seq = (u32)hw_ops->get_fw_pong(NBL_RES_MGT_TO_HW_PRIV(res_mgt));
+
+	INIT_WORK(&(*adminq_mgt)->eth_task, nbl_res_adminq_eth_task);
+	mutex_init(&(*adminq_mgt)->eth_lock);
+
+	ret = nbl_res_adminq_setup_cmd_filter(res_mgt);
+	if (ret)
+		goto set_filter_fail;
+
+	nbl_res_adminq_add_cmd_filter_res_write(res_mgt);
+
+	return 0;
+
+set_filter_fail:
+	cancel_work_sync(&((*adminq_mgt)->eth_task));
+	nbl_adminq_remove_mgt(dev, adminq_mgt);
+setup_mgt_fail:
+	return ret;
+}
+
+void nbl_adminq_mgt_stop(struct nbl_resource_mgt *res_mgt)
+{
+	struct device *dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	struct nbl_adminq_mgt **adminq_mgt = &NBL_RES_MGT_TO_ADMINQ_MGT(res_mgt);
+
+	if (!(*adminq_mgt))
+		return;
+
+	nbl_res_adminq_remove_cmd_filter(res_mgt);
+
+	cancel_work_sync(&((*adminq_mgt)->eth_task));
+	nbl_adminq_remove_mgt(dev, adminq_mgt);
+}
+
+int nbl_adminq_setup_ops(struct nbl_resource_ops *res_ops)
+{
+#define NBL_ADMINQ_SET_OPS(name, func) do {res_ops->NBL_NAME(name) = func; ; } while (0)
+	NBL_ADMINQ_OPS_TBL;
+#undef  NBL_ADMINQ_SET_OPS
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath.h
new file mode 100644
index 000000000000..534902b9fbd0
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+// Code generated by interstellar. DO NOT EDIT.
+// Compatible with leonis RTL tag 0710
+
+#include "nbl_datapath_upa.h"
+#include "nbl_datapath_dpa.h"
+#include "nbl_datapath_ucar.h"
+#include "nbl_datapath_uped.h"
+#include "nbl_datapath_dped.h"
+#include "nbl_datapath_dstore.h"
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_dpa.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_dpa.h
new file mode 100644
index 000000000000..4a9a7209351a
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_dpa.h
@@ -0,0 +1,765 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+// Code generated by interstellar. DO NOT EDIT.
+// Compatible with leonis RTL tag 0710
+
+#ifndef NBL_DPA_H
+#define NBL_DPA_H 1
+
+#include <linux/types.h>
+
+#define NBL_DPA_BASE (0x0085C000)
+
+#define NBL_DPA_INT_STATUS_ADDR  (0x85c000)
+#define NBL_DPA_INT_STATUS_DEPTH (1)
+#define NBL_DPA_INT_STATUS_WIDTH (32)
+#define NBL_DPA_INT_STATUS_DWLEN (1)
+union dpa_int_status_u {
+	struct dpa_int_status {
+		u32 fatal_err:1;         /* [0] Default:0x0 RWC */
+		u32 fifo_underflow:1;    /* [1] Default:0x0 RWC */
+		u32 fifo_overflow:1;     /* [2] Default:0x0 RWC */
+		u32 fsm_err:1;           /* [3] Default:0x0 RWC */
+		u32 cif_err:1;           /* [4] Default:0x0 RWC */
+		u32 rsv1:1;              /* [5] Default:0x0 RO */
+		u32 cfg_err:1;           /* [6] Default:0x0 RWC */
+		u32 ucor_err:1;          /* [7] Default:0x0 RWC */
+		u32 cor_err:1;           /* [8] Default:0x0 RWC */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_INT_STATUS_DWLEN];
+} __packed;
+
+#define NBL_DPA_INT_MASK_ADDR  (0x85c004)
+#define NBL_DPA_INT_MASK_DEPTH (1)
+#define NBL_DPA_INT_MASK_WIDTH (32)
+#define NBL_DPA_INT_MASK_DWLEN (1)
+union dpa_int_mask_u {
+	struct dpa_int_mask {
+		u32 fatal_err:1;         /* [0] Default:0x0 RW */
+		u32 fifo_underflow:1;    /* [1] Default:0x0 RW */
+		u32 fifo_overflow:1;     /* [2] Default:0x0 RW */
+		u32 fsm_err:1;           /* [3] Default:0x0 RW */
+		u32 cif_err:1;           /* [4] Default:0x0 RW */
+		u32 rsv1:1;              /* [5] Default:0x0 RO */
+		u32 cfg_err:1;           /* [6] Default:0x0 RW */
+		u32 ucor_err:1;          /* [7] Default:0x0 RW */
+		u32 cor_err:1;           /* [8] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_INT_MASK_DWLEN];
+} __packed;
+
+#define NBL_DPA_INT_SET_ADDR  (0x85c008)
+#define NBL_DPA_INT_SET_DEPTH (1)
+#define NBL_DPA_INT_SET_WIDTH (32)
+#define NBL_DPA_INT_SET_DWLEN (1)
+union dpa_int_set_u {
+	struct dpa_int_set {
+		u32 fatal_err:1;         /* [0] Default:0x0 WO */
+		u32 fifo_underflow:1;    /* [1] Default:0x0 WO */
+		u32 fifo_overflow:1;     /* [2] Default:0x0 WO */
+		u32 fsm_err:1;           /* [3] Default:0x0 WO */
+		u32 cif_err:1;           /* [4] Default:0x0 WO */
+		u32 rsv1:1;              /* [5] Default:0x0 RO */
+		u32 cfg_err:1;           /* [6] Default:0x0 WO */
+		u32 ucor_err:1;          /* [7] Default:0x0 WO */
+		u32 cor_err:1;           /* [8] Default:0x0 WO */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_INT_SET_DWLEN];
+} __packed;
+
+#define NBL_DPA_INIT_DONE_ADDR  (0x85c00c)
+#define NBL_DPA_INIT_DONE_DEPTH (1)
+#define NBL_DPA_INIT_DONE_WIDTH (32)
+#define NBL_DPA_INIT_DONE_DWLEN (1)
+union dpa_init_done_u {
+	struct dpa_init_done {
+		u32 done:1;              /* [0] Default:0x0 RO */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_INIT_DONE_DWLEN];
+} __packed;
+
+#define NBL_DPA_CIF_ERR_INFO_ADDR  (0x85c040)
+#define NBL_DPA_CIF_ERR_INFO_DEPTH (1)
+#define NBL_DPA_CIF_ERR_INFO_WIDTH (32)
+#define NBL_DPA_CIF_ERR_INFO_DWLEN (1)
+union dpa_cif_err_info_u {
+	struct dpa_cif_err_info {
+		u32 addr:30;             /* [29:0] Default:0x0 RO */
+		u32 wr_err:1;            /* [30] Default:0x0 RO */
+		u32 ucor_err:1;          /* [31] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_CIF_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_DPA_CFG_ERR_INFO_ADDR  (0x85c050)
+#define NBL_DPA_CFG_ERR_INFO_DEPTH (1)
+#define NBL_DPA_CFG_ERR_INFO_WIDTH (32)
+#define NBL_DPA_CFG_ERR_INFO_DWLEN (1)
+union dpa_cfg_err_info_u {
+	struct dpa_cfg_err_info {
+		u32 id0:2;               /* [1:0] Default:0x0 RO */
+		u32 rsv:30;              /* [31:2] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_CFG_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_DPA_CAR_CTRL_ADDR  (0x85c100)
+#define NBL_DPA_CAR_CTRL_DEPTH (1)
+#define NBL_DPA_CAR_CTRL_WIDTH (32)
+#define NBL_DPA_CAR_CTRL_DWLEN (1)
+union dpa_car_ctrl_u {
+	struct dpa_car_ctrl {
+		u32 sctr_car:1;          /* [0] Default:0x1 RW */
+		u32 rctr_car:1;          /* [1] Default:0x1 RW */
+		u32 rc_car:1;            /* [2] Default:0x1 RW */
+		u32 tbl_rc_car:1;        /* [3] Default:0x1 RW */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_CAR_CTRL_DWLEN];
+} __packed;
+
+#define NBL_DPA_INIT_START_ADDR  (0x85c180)
+#define NBL_DPA_INIT_START_DEPTH (1)
+#define NBL_DPA_INIT_START_WIDTH (32)
+#define NBL_DPA_INIT_START_DWLEN (1)
+union dpa_init_start_u {
+	struct dpa_init_start {
+		u32 start:1;             /* [0] Default:0x0 WO */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_INIT_START_DWLEN];
+} __packed;
+
+#define NBL_DPA_LAYO_CKSUM0_CTRL_ADDR  (0x85c1b0)
+#define NBL_DPA_LAYO_CKSUM0_CTRL_DEPTH (4)
+#define NBL_DPA_LAYO_CKSUM0_CTRL_WIDTH (32)
+#define NBL_DPA_LAYO_CKSUM0_CTRL_DWLEN (1)
+union dpa_layo_cksum0_ctrl_u {
+	struct dpa_layo_cksum0_ctrl {
+		u32 data:32;             /* [31:0] Default:0xFFFFFFFF RW */
+	} __packed info;
+	u32 data[NBL_DPA_LAYO_CKSUM0_CTRL_DWLEN];
+} __packed;
+#define NBL_DPA_LAYO_CKSUM0_CTRL_REG(r) (NBL_DPA_LAYO_CKSUM0_CTRL_ADDR + \
+		(NBL_DPA_LAYO_CKSUM0_CTRL_DWLEN * 4) * (r))
+
+#define NBL_DPA_FWD_TYPE_STAGE_0_ADDR  (0x85c1d0)
+#define NBL_DPA_FWD_TYPE_STAGE_0_DEPTH (1)
+#define NBL_DPA_FWD_TYPE_STAGE_0_WIDTH (32)
+#define NBL_DPA_FWD_TYPE_STAGE_0_DWLEN (1)
+union dpa_fwd_type_stage_0_u {
+	struct dpa_fwd_type_stage_0 {
+		u32 tbl:32;              /* [31:0] Default:0xF3FFFFC2 RW */
+	} __packed info;
+	u32 data[NBL_DPA_FWD_TYPE_STAGE_0_DWLEN];
+} __packed;
+
+#define NBL_DPA_FWD_TYPE_STAGE_1_ADDR  (0x85c1d4)
+#define NBL_DPA_FWD_TYPE_STAGE_1_DEPTH (1)
+#define NBL_DPA_FWD_TYPE_STAGE_1_WIDTH (32)
+#define NBL_DPA_FWD_TYPE_STAGE_1_DWLEN (1)
+union dpa_fwd_type_stage_1_u {
+	struct dpa_fwd_type_stage_1 {
+		u32 tbl:32;              /* [31:0] Default:0xFFFFFFFF RW */
+	} __packed info;
+	u32 data[NBL_DPA_FWD_TYPE_STAGE_1_DWLEN];
+} __packed;
+
+#define NBL_DPA_FWD_TYPE_STAGE_2_ADDR  (0x85c1d8)
+#define NBL_DPA_FWD_TYPE_STAGE_2_DEPTH (1)
+#define NBL_DPA_FWD_TYPE_STAGE_2_WIDTH (32)
+#define NBL_DPA_FWD_TYPE_STAGE_2_DWLEN (1)
+union dpa_fwd_type_stage_2_u {
+	struct dpa_fwd_type_stage_2 {
+		u32 tbl:32;              /* [31:0] Default:0xFFFFFFFF RW */
+	} __packed info;
+	u32 data[NBL_DPA_FWD_TYPE_STAGE_2_DWLEN];
+} __packed;
+
+#define NBL_DPA_FWD_TYPE_BYPASS_0_ADDR  (0x85c1e0)
+#define NBL_DPA_FWD_TYPE_BYPASS_0_DEPTH (1)
+#define NBL_DPA_FWD_TYPE_BYPASS_0_WIDTH (32)
+#define NBL_DPA_FWD_TYPE_BYPASS_0_DWLEN (1)
+union dpa_fwd_type_bypass_0_u {
+	struct dpa_fwd_type_bypass_0 {
+		u32 tbl:8;               /* [7:0] Default:0x80 RW */
+		u32 rsv:24;              /* [31:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_FWD_TYPE_BYPASS_0_DWLEN];
+} __packed;
+
+#define NBL_DPA_FWD_TYPE_BYPASS_1_ADDR  (0x85c1e4)
+#define NBL_DPA_FWD_TYPE_BYPASS_1_DEPTH (1)
+#define NBL_DPA_FWD_TYPE_BYPASS_1_WIDTH (32)
+#define NBL_DPA_FWD_TYPE_BYPASS_1_DWLEN (1)
+union dpa_fwd_type_bypass_1_u {
+	struct dpa_fwd_type_bypass_1 {
+		u32 tbl:8;               /* [7:0] Default:0x80 RW */
+		u32 rsv:24;              /* [31:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_FWD_TYPE_BYPASS_1_DWLEN];
+} __packed;
+
+#define NBL_DPA_FWD_TYPE_BYPASS_2_ADDR  (0x85c1e8)
+#define NBL_DPA_FWD_TYPE_BYPASS_2_DEPTH (1)
+#define NBL_DPA_FWD_TYPE_BYPASS_2_WIDTH (32)
+#define NBL_DPA_FWD_TYPE_BYPASS_2_DWLEN (1)
+union dpa_fwd_type_bypass_2_u {
+	struct dpa_fwd_type_bypass_2 {
+		u32 tbl:8;               /* [7:0] Default:0x80 RW */
+		u32 rsv:24;              /* [31:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_FWD_TYPE_BYPASS_2_DWLEN];
+} __packed;
+
+#define NBL_DPA_DPORT_EXTRACT_ADDR  (0x85c1ec)
+#define NBL_DPA_DPORT_EXTRACT_DEPTH (1)
+#define NBL_DPA_DPORT_EXTRACT_WIDTH (32)
+#define NBL_DPA_DPORT_EXTRACT_DWLEN (1)
+union dpa_dport_extract_u {
+	struct dpa_dport_extract {
+		u32 id:6;                /* [5:0] Default:0x9 RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_DPORT_EXTRACT_DWLEN];
+} __packed;
+
+#define NBL_DPA_LAYO_PHV_ADDR  (0x85c1f0)
+#define NBL_DPA_LAYO_PHV_DEPTH (1)
+#define NBL_DPA_LAYO_PHV_WIDTH (32)
+#define NBL_DPA_LAYO_PHV_DWLEN (1)
+union dpa_layo_phv_u {
+	struct dpa_layo_phv {
+		u32 len:7;               /* [6:0] Default:0x5A RW */
+		u32 rsv:25;              /* [31:7] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_LAYO_PHV_DWLEN];
+} __packed;
+
+#define NBL_DPA_L4S_PAD_ADDR  (0x85c1f4)
+#define NBL_DPA_L4S_PAD_DEPTH (1)
+#define NBL_DPA_L4S_PAD_WIDTH (32)
+#define NBL_DPA_L4S_PAD_DWLEN (1)
+union dpa_l4s_pad_u {
+	struct dpa_l4s_pad {
+		u32 p_length:7;          /* [6:0] Default:0x3C RW */
+		u32 en:1;                /* [7] Default:0x0 RW */
+		u32 rsv:24;              /* [31:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_L4S_PAD_DWLEN];
+} __packed;
+
+#define NBL_DPA_IP_EXT_PROTOCOL_ADDR  (0x85c1fc)
+#define NBL_DPA_IP_EXT_PROTOCOL_DEPTH (1)
+#define NBL_DPA_IP_EXT_PROTOCOL_WIDTH (32)
+#define NBL_DPA_IP_EXT_PROTOCOL_DWLEN (1)
+union dpa_ip_ext_protocol_u {
+	struct dpa_ip_ext_protocol {
+		u32 tcp:8;               /* [7:0] Default:0x6 RW */
+		u32 udp:8;               /* [15:8] Default:0x11 RW */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_IP_EXT_PROTOCOL_DWLEN];
+} __packed;
+
+#define NBL_DPA_L3V6_ML_DA_ADDR  (0x85c204)
+#define NBL_DPA_L3V6_ML_DA_DEPTH (1)
+#define NBL_DPA_L3V6_ML_DA_WIDTH (32)
+#define NBL_DPA_L3V6_ML_DA_DWLEN (1)
+union dpa_l3v6_ml_da_u {
+	struct dpa_l3v6_ml_da {
+		u32 ml_da:16;            /* [15:0] Default:0x3333 RW */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_L3V6_ML_DA_DWLEN];
+} __packed;
+
+#define NBL_DPA_NEXT_KEY_ADDR  (0x85c208)
+#define NBL_DPA_NEXT_KEY_DEPTH (1)
+#define NBL_DPA_NEXT_KEY_WIDTH (32)
+#define NBL_DPA_NEXT_KEY_DWLEN (1)
+union dpa_next_key_u {
+	struct dpa_next_key {
+		u32 key_b:8;             /* [7:0] Default:0x10 RW */
+		u32 key_a:8;             /* [15:8] Default:0x0C RW */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_NEXT_KEY_DWLEN];
+} __packed;
+
+#define NBL_DPA_L3_ML_DA_ADDR  (0x85c20c)
+#define NBL_DPA_L3_ML_DA_DEPTH (1)
+#define NBL_DPA_L3_ML_DA_WIDTH (32)
+#define NBL_DPA_L3_ML_DA_DWLEN (1)
+union dpa_l3_ml_da_u {
+	struct dpa_l3_ml_da {
+		u32 ml_da_0:16;          /* [15:0] Default:0x5e00 RW */
+		u32 ml_da_1:16;          /* [31:16] Default:0x0100 RW */
+	} __packed info;
+	u32 data[NBL_DPA_L3_ML_DA_DWLEN];
+} __packed;
+
+#define NBL_DPA_CK_CTRL_ADDR  (0x85c210)
+#define NBL_DPA_CK_CTRL_DEPTH (1)
+#define NBL_DPA_CK_CTRL_WIDTH (32)
+#define NBL_DPA_CK_CTRL_DWLEN (1)
+union dpa_ck_ctrl_u {
+	struct dpa_ck_ctrl {
+		u32 tcp_csum_en:1;       /* [0] Default:0x1 RW */
+		u32 udp_csum_en:1;       /* [1] Default:0x1 RW */
+		u32 sctp_crc32c_en:1;    /* [2] Default:0x1 RW */
+		u32 ipv4_ck_en:1;        /* [3] Default:0x1 RW */
+		u32 ipv6_ck_en:1;        /* [4] Default:0x1 RW */
+		u32 DA_ck_en:1;          /* [5] Default:0x1 RW */
+		u32 ipv6_ext_en:1;       /* [6] Default:0x0 RW */
+		u32 vlan_error_en:1;     /* [7] Default:0x1 RW */
+		u32 ctrl_p_en:1;         /* [8] Default:0x0 RW */
+		u32 ip_tlen_ck_en:1;     /* [9] Default:0x0 RW */
+		u32 not_uc_p_plck_aux_en:1; /* [10] Default:0x0 RW */
+		u32 sctp_crc_plck_aux_en:1; /* [11] Default:0x1 RW */
+		u32 tcp_csum_offset_id:2; /* [13:12] Default:0x2 RW */
+		u32 udp_csum_offset_id:2; /* [15:14] Default:0x2 RW */
+		u32 sctp_crc32c_offset_id:2; /* [17:16] Default:0x2 RW */
+		u32 ipv4_ck_offset_id:2; /* [19:18] Default:0x1 RW */
+		u32 ipv6_ck_offset_id:2; /* [21:20] Default:0x1 RW */
+		u32 DA_ck_offset_id:2;   /* [23:22] Default:0x0 RW */
+		u32 plck_offset_id:2;    /* [25:24] Default:0x3 RW */
+		u32 rsv:6;               /* [31:26] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_CK_CTRL_DWLEN];
+} __packed;
+
+#define NBL_DPA_MC_INDEX_ADDR  (0x85c214)
+#define NBL_DPA_MC_INDEX_DEPTH (1)
+#define NBL_DPA_MC_INDEX_WIDTH (32)
+#define NBL_DPA_MC_INDEX_DWLEN (1)
+union dpa_mc_index_u {
+	struct dpa_mc_index {
+		u32 l2_mc_index:5;       /* [4:0] Default:0x8 RW */
+		u32 rsv2:3;              /* [7:5] Default:0x00 RO */
+		u32 l3_mc_index:5;       /* [12:8] Default:0x9 RW */
+		u32 rsv1:3;              /* [15:13] Default:0x00 RO */
+		u32 ctrl_p_index:5;      /* [20:16] Default:0xF RW */
+		u32 rsv:11;              /* [31:21] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_MC_INDEX_DWLEN];
+} __packed;
+
+#define NBL_DPA_CTRL_P_DA_ADDR  (0x85c218)
+#define NBL_DPA_CTRL_P_DA_DEPTH (1)
+#define NBL_DPA_CTRL_P_DA_WIDTH (32)
+#define NBL_DPA_CTRL_P_DA_DWLEN (1)
+union dpa_ctrl_p_da_u {
+	struct dpa_ctrl_p_da {
+		u32 ctrl_da_0:16;        /* [15:0] Default:0xC200 RW */
+		u32 ctrl_da_1:16;        /* [31:16] Default:0x0180 RW */
+	} __packed info;
+	u32 data[NBL_DPA_CTRL_P_DA_DWLEN];
+} __packed;
+
+#define NBL_DPA_VLAN_INDEX_ADDR  (0x85c220)
+#define NBL_DPA_VLAN_INDEX_DEPTH (1)
+#define NBL_DPA_VLAN_INDEX_WIDTH (32)
+#define NBL_DPA_VLAN_INDEX_DWLEN (1)
+union dpa_vlan_index_u {
+	struct dpa_vlan_index {
+		u32 o_vlan2_index:5;     /* [4:0] Default:0x11 RW */
+		u32 rsv1:3;              /* [7:5] Default:0x0 RO */
+		u32 o_vlan1_index:5;     /* [12:8] Default:0x10 RW */
+		u32 rsv:19;              /* [31:13] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_VLAN_INDEX_DWLEN];
+} __packed;
+
+#define NBL_DPA_PRI_VLAN_INDEX_ADDR  (0x85c224)
+#define NBL_DPA_PRI_VLAN_INDEX_DEPTH (1)
+#define NBL_DPA_PRI_VLAN_INDEX_WIDTH (32)
+#define NBL_DPA_PRI_VLAN_INDEX_DWLEN (1)
+union dpa_pri_vlan_index_u {
+	struct dpa_pri_vlan_index {
+		u32 ext_vlan2:7;         /* [6:0] Default:0x30 RW */
+		u32 rsv1:1;              /* [7] Default:0x0 RO */
+		u32 ext_vlan1:7;         /* [14:8] Default:0x2E RW */
+		u32 rsv:17;              /* [31:15] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_PRI_VLAN_INDEX_DWLEN];
+} __packed;
+
+#define NBL_DPA_PRI_DSCP_INDEX_ADDR  (0x85c228)
+#define NBL_DPA_PRI_DSCP_INDEX_DEPTH (1)
+#define NBL_DPA_PRI_DSCP_INDEX_WIDTH (32)
+#define NBL_DPA_PRI_DSCP_INDEX_DWLEN (1)
+union dpa_pri_dscp_index_u {
+	struct dpa_pri_dscp_index {
+		u32 ext_dscp:7;          /* [6:0] Default:0x32 RW */
+		u32 rsv2:9;              /* [15:7] Default:0x0 RO */
+		u32 ipv4_flag:5;         /* [20:16] Default:0x1 RW */
+		u32 rsv1:3;              /* [23:21] Default:0x0 RO */
+		u32 ipv6_flag:5;         /* [28:24] Default:0x2 RW */
+		u32 rsv:3;               /* [31:29] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_PRI_DSCP_INDEX_DWLEN];
+} __packed;
+
+#define NBL_DPA_RDMA_INDEX_ADDR  (0x85c22c)
+#define NBL_DPA_RDMA_INDEX_DEPTH (1)
+#define NBL_DPA_RDMA_INDEX_WIDTH (32)
+#define NBL_DPA_RDMA_INDEX_DWLEN (1)
+union dpa_rdma_index_u {
+	struct dpa_rdma_index {
+		u32 rdma_index:5;        /* [4:0] Default:0xA RW */
+		u32 rsv:27;              /* [31:5] Default:0x00 RO */
+	} __packed info;
+	u32 data[NBL_DPA_RDMA_INDEX_DWLEN];
+} __packed;
+
+#define NBL_DPA_PRI_SEL_CONF_ADDR  (0x85c230)
+#define NBL_DPA_PRI_SEL_CONF_DEPTH (6)
+#define NBL_DPA_PRI_SEL_CONF_WIDTH (32)
+#define NBL_DPA_PRI_SEL_CONF_DWLEN (1)
+union dpa_pri_sel_conf_u {
+	struct dpa_pri_sel_conf {
+		u32 pri_sel:5;           /* [4:0] Default:0x0 RW */
+		u32 pri_default:3;       /* [7:5] Default:0x0 RW */
+		u32 pri_disen:1;         /* [8] Default:0x1 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_PRI_SEL_CONF_DWLEN];
+} __packed;
+#define NBL_DPA_PRI_SEL_CONF_REG(r) (NBL_DPA_PRI_SEL_CONF_ADDR + \
+		(NBL_DPA_PRI_SEL_CONF_DWLEN * 4) * (r))
+
+#define NBL_DPA_ERROR_DROP_ADDR  (0x85c248)
+#define NBL_DPA_ERROR_DROP_DEPTH (1)
+#define NBL_DPA_ERROR_DROP_WIDTH (32)
+#define NBL_DPA_ERROR_DROP_DWLEN (1)
+union dpa_error_drop_u {
+	struct dpa_error_drop {
+		u32 en:7;                /* [6:0] Default:0x0 RW */
+		u32 rsv:25;              /* [31:7] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_ERROR_DROP_DWLEN];
+} __packed;
+
+#define NBL_DPA_ERROR_CODE_ADDR  (0x85c24c)
+#define NBL_DPA_ERROR_CODE_DEPTH (1)
+#define NBL_DPA_ERROR_CODE_WIDTH (32)
+#define NBL_DPA_ERROR_CODE_DWLEN (1)
+union dpa_error_code_u {
+	struct dpa_error_code {
+		u32 no:32;               /* [31:0] Default:0x09123456 RW */
+	} __packed info;
+	u32 data[NBL_DPA_ERROR_CODE_DWLEN];
+} __packed;
+
+#define NBL_DPA_PTYPE_SCAN_ADDR  (0x85c250)
+#define NBL_DPA_PTYPE_SCAN_DEPTH (1)
+#define NBL_DPA_PTYPE_SCAN_WIDTH (32)
+#define NBL_DPA_PTYPE_SCAN_DWLEN (1)
+union dpa_ptype_scan_u {
+	struct dpa_ptype_scan {
+		u32 en:1;                /* [0] Default:0x0 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_PTYPE_SCAN_DWLEN];
+} __packed;
+
+#define NBL_DPA_PTYPE_SCAN_TH_ADDR  (0x85c254)
+#define NBL_DPA_PTYPE_SCAN_TH_DEPTH (1)
+#define NBL_DPA_PTYPE_SCAN_TH_WIDTH (32)
+#define NBL_DPA_PTYPE_SCAN_TH_DWLEN (1)
+union dpa_ptype_scan_th_u {
+	struct dpa_ptype_scan_th {
+		u32 th:32;               /* [31:00] Default:0x40 RW */
+	} __packed info;
+	u32 data[NBL_DPA_PTYPE_SCAN_TH_DWLEN];
+} __packed;
+
+#define NBL_DPA_PTYPE_SCAN_MASK_ADDR  (0x85c258)
+#define NBL_DPA_PTYPE_SCAN_MASK_DEPTH (1)
+#define NBL_DPA_PTYPE_SCAN_MASK_WIDTH (32)
+#define NBL_DPA_PTYPE_SCAN_MASK_DWLEN (1)
+union dpa_ptype_scan_mask_u {
+	struct dpa_ptype_scan_mask {
+		u32 addr:8;              /* [7:0] Default:0x0 RW */
+		u32 en:1;                /* [8] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_PTYPE_SCAN_MASK_DWLEN];
+} __packed;
+
+#define NBL_DPA_PTYPE_INSERT_SEARCH_ADDR  (0x85c25c)
+#define NBL_DPA_PTYPE_INSERT_SEARCH_DEPTH (1)
+#define NBL_DPA_PTYPE_INSERT_SEARCH_WIDTH (32)
+#define NBL_DPA_PTYPE_INSERT_SEARCH_DWLEN (1)
+union dpa_ptype_insert_search_u {
+	struct dpa_ptype_insert_search {
+		u32 ctrl:1;              /* [0] Default:0x0 WO */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_PTYPE_INSERT_SEARCH_DWLEN];
+} __packed;
+
+#define NBL_DPA_PTYPE_INSERT_SEARCH_0_ADDR  (0x85c260)
+#define NBL_DPA_PTYPE_INSERT_SEARCH_0_DEPTH (1)
+#define NBL_DPA_PTYPE_INSERT_SEARCH_0_WIDTH (32)
+#define NBL_DPA_PTYPE_INSERT_SEARCH_0_DWLEN (1)
+union dpa_ptype_insert_search_0_u {
+	struct dpa_ptype_insert_search_0 {
+		u32 key0:32;             /* [31:00] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DPA_PTYPE_INSERT_SEARCH_0_DWLEN];
+} __packed;
+
+#define NBL_DPA_PTYPE_INSERT_SEARCH_RESULT_ADDR  (0x85c268)
+#define NBL_DPA_PTYPE_INSERT_SEARCH_RESULT_DEPTH (1)
+#define NBL_DPA_PTYPE_INSERT_SEARCH_RESULT_WIDTH (32)
+#define NBL_DPA_PTYPE_INSERT_SEARCH_RESULT_DWLEN (1)
+union dpa_ptype_insert_search_result_u {
+	struct dpa_ptype_insert_search_result {
+		u32 result:8;            /* [7:0] Default:0x0 RO */
+		u32 hit:1;               /* [8] Default:0x0 RO */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_PTYPE_INSERT_SEARCH_RESULT_DWLEN];
+} __packed;
+
+#define NBL_DPA_PTYPE_INSERT_SEARCH_RESULT_ACK_ADDR  (0x85c270)
+#define NBL_DPA_PTYPE_INSERT_SEARCH_RESULT_ACK_DEPTH (1)
+#define NBL_DPA_PTYPE_INSERT_SEARCH_RESULT_ACK_WIDTH (32)
+#define NBL_DPA_PTYPE_INSERT_SEARCH_RESULT_ACK_DWLEN (1)
+union dpa_ptype_insert_search_result_ack_u {
+	struct dpa_ptype_insert_search_result_ack {
+		u32 vld:1;               /* [0] Default:0x0 RC */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_PTYPE_INSERT_SEARCH_RESULT_ACK_DWLEN];
+} __packed;
+
+#define NBL_DPA_CFG_TEST_ADDR  (0x85c80c)
+#define NBL_DPA_CFG_TEST_DEPTH (1)
+#define NBL_DPA_CFG_TEST_WIDTH (32)
+#define NBL_DPA_CFG_TEST_DWLEN (1)
+union dpa_cfg_test_u {
+	struct dpa_cfg_test {
+		u32 test:32;             /* [31:00] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DPA_CFG_TEST_DWLEN];
+} __packed;
+
+#define NBL_DPA_BP_STATE_ADDR  (0x85cb00)
+#define NBL_DPA_BP_STATE_DEPTH (1)
+#define NBL_DPA_BP_STATE_WIDTH (32)
+#define NBL_DPA_BP_STATE_DWLEN (1)
+union dpa_bp_state_u {
+	struct dpa_bp_state {
+		u32 pa_rmux_data_bp:1;   /* [0] Default:0x0 RO */
+		u32 pa_rmux_info_bp:1;   /* [1] Default:0x0 RO */
+		u32 store_pa_data_bp:1;  /* [2] Default:0x0 RO */
+		u32 store_pa_info_bp:1;  /* [3] Default:0x0 RO */
+		u32 rx_data_fifo_afull:1; /* [4] Default:0x0 RO */
+		u32 rx_info_fifo_afull:1; /* [5] Default:0x0 RO */
+		u32 rx_ctrl_fifo_afull:1; /* [6] Default:0x0 RO */
+		u32 cinf1_fifo_afull:1;  /* [7] Default:0x0 RO */
+		u32 ctrl_cinf1_fifo_afull:1; /* [8] Default:0x0 RO */
+		u32 layo_info_fifo_afull:1; /* [9] Default:0x0 RO */
+		u32 rsv:22;              /* [31:10] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_BP_STATE_DWLEN];
+} __packed;
+
+#define NBL_DPA_BP_HISTORY_ADDR  (0x85cb04)
+#define NBL_DPA_BP_HISTORY_DEPTH (1)
+#define NBL_DPA_BP_HISTORY_WIDTH (32)
+#define NBL_DPA_BP_HISTORY_DWLEN (1)
+union dpa_bp_history_u {
+	struct dpa_bp_history {
+		u32 pa_rmux_data_bp:1;   /* [0] Default:0x0 RC */
+		u32 pa_rmux_info_bp:1;   /* [1] Default:0x0 RC */
+		u32 store_pa_data_bp:1;  /* [2] Default:0x0 RC */
+		u32 store_pa_info_bp:1;  /* [3] Default:0x0 RC */
+		u32 rx_data_fifo_afull:1; /* [4] Default:0x0 RC */
+		u32 rx_info_fifo_afull:1; /* [5] Default:0x0 RC */
+		u32 rx_ctrl_fifo_afull:1; /* [6] Default:0x0 RC */
+		u32 cinf1_fifo_afull:1;  /* [7] Default:0x0 RC */
+		u32 ctrl_cinf1_fifo_afull:1; /* [8] Default:0x0 RC */
+		u32 layo_info_fifo_afull:1; /* [9] Default:0x0 RC */
+		u32 rsv:22;              /* [31:10] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_BP_HISTORY_DWLEN];
+} __packed;
+
+#define NBL_DPA_PRI_CONF_TABLE_ADDR  (0x85e000)
+#define NBL_DPA_PRI_CONF_TABLE_DEPTH (48)
+#define NBL_DPA_PRI_CONF_TABLE_WIDTH (32)
+#define NBL_DPA_PRI_CONF_TABLE_DWLEN (1)
+union dpa_pri_conf_table_u {
+	struct dpa_pri_conf_table {
+		u32 pri0:4;              /* [3:0] Default:0x0 RW */
+		u32 pri1:4;              /* [7:4] Default:0x0 RW */
+		u32 pri2:4;              /* [11:8] Default:0x0 RW */
+		u32 pri3:4;              /* [15:12] Default:0x0 RW */
+		u32 pri4:4;              /* [19:16] Default:0x0 RW */
+		u32 pri5:4;              /* [23:20] Default:0x0 RW */
+		u32 pri6:4;              /* [27:24] Default:0x0 RW */
+		u32 pri7:4;              /* [31:28] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DPA_PRI_CONF_TABLE_DWLEN];
+} __packed;
+#define NBL_DPA_PRI_CONF_TABLE_REG(r) (NBL_DPA_PRI_CONF_TABLE_ADDR + \
+		(NBL_DPA_PRI_CONF_TABLE_DWLEN * 4) * (r))
+
+#define NBL_DPA_KEY_TCAM_ADDR  (0x85f000)
+#define NBL_DPA_KEY_TCAM_DEPTH (128)
+#define NBL_DPA_KEY_TCAM_WIDTH (64)
+#define NBL_DPA_KEY_TCAM_DWLEN (2)
+union dpa_key_tcam_u {
+	struct dpa_key_tcam {
+		u32 key_b:16;            /* [15:0] Default:0x0 RW */
+		u32 key_a:16;            /* [31:16] Default:0x0 RW */
+		u32 key_valid:1;         /* [32] Default:0x0 RW */
+		u32 rsv:31;              /* [63:33] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_KEY_TCAM_DWLEN];
+} __packed;
+#define NBL_DPA_KEY_TCAM_REG(r) (NBL_DPA_KEY_TCAM_ADDR + \
+		(NBL_DPA_KEY_TCAM_DWLEN * 4) * (r))
+
+#define NBL_DPA_MASK_TCAM_ADDR  (0x85f800)
+#define NBL_DPA_MASK_TCAM_DEPTH (128)
+#define NBL_DPA_MASK_TCAM_WIDTH (32)
+#define NBL_DPA_MASK_TCAM_DWLEN (1)
+union dpa_mask_tcam_u {
+	struct dpa_mask_tcam {
+		u32 mask_b:16;           /* [15:0] Default:0x0 RW */
+		u32 mask_a:16;           /* [31:16] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DPA_MASK_TCAM_DWLEN];
+} __packed;
+#define NBL_DPA_MASK_TCAM_REG(r) (NBL_DPA_MASK_TCAM_ADDR + \
+		(NBL_DPA_MASK_TCAM_DWLEN * 4) * (r))
+
+#define NBL_DPA_ACT_TABLE_ADDR  (0x860000)
+#define NBL_DPA_ACT_TABLE_DEPTH (128)
+#define NBL_DPA_ACT_TABLE_WIDTH (128)
+#define NBL_DPA_ACT_TABLE_DWLEN (4)
+union dpa_act_table_u {
+	struct dpa_act_table {
+		u32 flag_control_0:8;    /* [7:0] Default:0x0 RW */
+		u32 flag_control_1:8;    /* [15:8] Default:0x0 RW */
+		u32 flag_control_2:8;    /* [23:16] Default:0x0 RW */
+		u32 legality_check:8;    /* [31:24] Default:0x0 RW */
+		u32 nxt_off_B:8;         /* [39:32] Default:0x0 RW */
+		u32 nxt_off_A:8;         /* [47:40] Default:0x0 RW */
+		u32 protocol_header_off:8; /* [55:48] Default:0x0 RW */
+		u32 payload_length:8;    /* [63:56] Default:0x0 RW */
+		u32 mask:8;              /* [71:64] Default:0x0 RW */
+		u32 nxt_stg:4;           /* [75:72] Default:0x0 RW */
+		u32 rsv_l:32;            /* [127:76] Default:0x0 RO */
+		u32 rsv_h:20;            /* [127:76] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_ACT_TABLE_DWLEN];
+} __packed;
+#define NBL_DPA_ACT_TABLE_REG(r) (NBL_DPA_ACT_TABLE_ADDR + \
+		(NBL_DPA_ACT_TABLE_DWLEN * 4) * (r))
+
+#define NBL_DPA_EXT_CONF_TABLE_ADDR  (0x861000)
+#define NBL_DPA_EXT_CONF_TABLE_DEPTH (512)
+#define NBL_DPA_EXT_CONF_TABLE_WIDTH (32)
+#define NBL_DPA_EXT_CONF_TABLE_DWLEN (1)
+union dpa_ext_conf_table_u {
+	struct dpa_ext_conf_table {
+		u32 dst_offset:8;        /* [7:0] Default:0x0 RW */
+		u32 source_offset:6;     /* [13:8] Default:0x0 RW */
+		u32 mode_start_off:2;    /* [15:14] Default:0x0 RW */
+		u32 lx_sel:2;            /* [17:16] Default:0x0 RW */
+		u32 mode_sel:1;          /* [18] Default:0x0 RW */
+		u32 op_en:1;             /* [19] Default:0x0 RW */
+		u32 rsv:8;               /* [31:24] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_EXT_CONF_TABLE_DWLEN];
+} __packed;
+#define NBL_DPA_EXT_CONF_TABLE_REG(r) (NBL_DPA_EXT_CONF_TABLE_ADDR + \
+		(NBL_DPA_EXT_CONF_TABLE_DWLEN * 4) * (r))
+
+#define NBL_DPA_EXT_INDEX_TCAM_ADDR  (0x862000)
+#define NBL_DPA_EXT_INDEX_TCAM_DEPTH (32)
+#define NBL_DPA_EXT_INDEX_TCAM_WIDTH (64)
+#define NBL_DPA_EXT_INDEX_TCAM_DWLEN (2)
+union dpa_ext_index_tcam_u {
+	struct dpa_ext_index_tcam {
+		u32 type_index:32;       /* [31:0] Default:0x0 RW */
+		u32 type_valid:1;        /* [32] Default:0x0 RW */
+		u32 rsv:31;              /* [63:33] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_EXT_INDEX_TCAM_DWLEN];
+} __packed;
+#define NBL_DPA_EXT_INDEX_TCAM_REG(r) (NBL_DPA_EXT_INDEX_TCAM_ADDR + \
+		(NBL_DPA_EXT_INDEX_TCAM_DWLEN * 4) * (r))
+
+#define NBL_DPA_EXT_INDEX_TCAM_MASK_ADDR  (0x862200)
+#define NBL_DPA_EXT_INDEX_TCAM_MASK_DEPTH (32)
+#define NBL_DPA_EXT_INDEX_TCAM_MASK_WIDTH (32)
+#define NBL_DPA_EXT_INDEX_TCAM_MASK_DWLEN (1)
+union dpa_ext_index_tcam_mask_u {
+	struct dpa_ext_index_tcam_mask {
+		u32 mask:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DPA_EXT_INDEX_TCAM_MASK_DWLEN];
+} __packed;
+#define NBL_DPA_EXT_INDEX_TCAM_MASK_REG(r) (NBL_DPA_EXT_INDEX_TCAM_MASK_ADDR + \
+		(NBL_DPA_EXT_INDEX_TCAM_MASK_DWLEN * 4) * (r))
+
+#define NBL_DPA_EXT_INDEX_TABLE_ADDR  (0x862300)
+#define NBL_DPA_EXT_INDEX_TABLE_DEPTH (32)
+#define NBL_DPA_EXT_INDEX_TABLE_WIDTH (32)
+#define NBL_DPA_EXT_INDEX_TABLE_DWLEN (1)
+union dpa_ext_index_table_u {
+	struct dpa_ext_index_table {
+		u32 p_index:3;           /* [2:0] Default:0x0 RW */
+		u32 rsv:29;              /* [31:3] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_EXT_INDEX_TABLE_DWLEN];
+} __packed;
+#define NBL_DPA_EXT_INDEX_TABLE_REG(r) (NBL_DPA_EXT_INDEX_TABLE_ADDR + \
+		(NBL_DPA_EXT_INDEX_TABLE_DWLEN * 4) * (r))
+
+#define NBL_DPA_TYPE_INDEX_TCAM_ADDR  (0x864000)
+#define NBL_DPA_TYPE_INDEX_TCAM_DEPTH (256)
+#define NBL_DPA_TYPE_INDEX_TCAM_WIDTH (128)
+#define NBL_DPA_TYPE_INDEX_TCAM_DWLEN (4)
+union dpa_type_index_tcam_u {
+	struct dpa_type_index_tcam {
+		u32 layo_x:32;           /* [31:0] Default:0xFFFFFFFF RW */
+		u32 layo_y:32;           /* [63:32] Default:0xFFFFFFFF RW */
+		u32 type_valid:1;        /* [64] Default:0x0 RW */
+		u32 rsv_l:32;            /* [127:65] Default:0x0 RO */
+		u32 rsv_h:31;            /* [127:65] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_TYPE_INDEX_TCAM_DWLEN];
+} __packed;
+#define NBL_DPA_TYPE_INDEX_TCAM_REG(r) (NBL_DPA_TYPE_INDEX_TCAM_ADDR + \
+		(NBL_DPA_TYPE_INDEX_TCAM_DWLEN * 4) * (r))
+
+#define NBL_DPA_PACKET_TYPE_TABLE_ADDR  (0x866000)
+#define NBL_DPA_PACKET_TYPE_TABLE_DEPTH (256)
+#define NBL_DPA_PACKET_TYPE_TABLE_WIDTH (32)
+#define NBL_DPA_PACKET_TYPE_TABLE_DWLEN (1)
+union dpa_packet_type_table_u {
+	struct dpa_packet_type_table {
+		u32 p_type:8;            /* [7:0] Default:0x0 RW */
+		u32 rsv:24;              /* [31:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPA_PACKET_TYPE_TABLE_DWLEN];
+} __packed;
+#define NBL_DPA_PACKET_TYPE_TABLE_REG(r) (NBL_DPA_PACKET_TYPE_TABLE_ADDR + \
+		(NBL_DPA_PACKET_TYPE_TABLE_DWLEN * 4) * (r))
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_dped.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_dped.h
new file mode 100644
index 000000000000..2715ce4ae32a
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_dped.h
@@ -0,0 +1,2152 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+ // Code generated by interstellar. DO NOT EDIT.
+// Compatible with leonis RTL tag 0710
+
+#ifndef NBL_DPED_H
+#define NBL_DPED_H 1
+
+#include <linux/types.h>
+
+#define NBL_DPED_BASE (0x0075C000)
+
+#define NBL_DPED_INT_STATUS_ADDR  (0x75c000)
+#define NBL_DPED_INT_STATUS_DEPTH (1)
+#define NBL_DPED_INT_STATUS_WIDTH (32)
+#define NBL_DPED_INT_STATUS_DWLEN (1)
+union dped_int_status_u {
+	struct dped_int_status {
+		u32 pkt_length_err:1;    /* [0] Default:0x0 RWC */
+		u32 fifo_uflw_err:1;     /* [1] Default:0x0 RWC */
+		u32 fifo_dflw_err:1;     /* [2] Default:0x0 RWC */
+		u32 fsm_err:1;           /* [3] Default:0x0 RWC */
+		u32 cif_err:1;           /* [4] Default:0x0 RWC */
+		u32 input_err:1;         /* [5] Default:0x0 RWC */
+		u32 cfg_err:1;           /* [6] Default:0x0 RWC */
+		u32 data_ucor_err:1;     /* [7] Default:0x0 RWC */
+		u32 inmeta_ucor_err:1;   /* [8] Default:0x0 RWC */
+		u32 meta_ucor_err:1;     /* [9] Default:0x0 RWC */
+		u32 meta_cor_ecc_err:1;  /* [10] Default:0x0 RWC */
+		u32 fwd_atid_nomat_err:1; /* [11] Default:0x0 RWC */
+		u32 meta_value_err:1;    /* [12] Default:0x0 RWC */
+		u32 edit_atnum_err:1;    /* [13] Default:0x0 RWC */
+		u32 header_oft_ovf:1;    /* [14] Default:0x0 RWC */
+		u32 edit_pos_err:1;      /* [15] Default:0x0 RWC */
+		u32 da_oft_len_ovf:1;    /* [16] Default:0x0 RWC */
+		u32 lxoffset_ovf:1;      /* [17] Default:0x0 RWC */
+		u32 add_head_ovf:1;      /* [18] Default:0x0 RWC */
+		u32 rsv:13;              /* [31:19] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_INT_STATUS_DWLEN];
+} __packed;
+
+#define NBL_DPED_INT_MASK_ADDR  (0x75c004)
+#define NBL_DPED_INT_MASK_DEPTH (1)
+#define NBL_DPED_INT_MASK_WIDTH (32)
+#define NBL_DPED_INT_MASK_DWLEN (1)
+union dped_int_mask_u {
+	struct dped_int_mask {
+		u32 pkt_length_err:1;    /* [0] Default:0x0 RW */
+		u32 fifo_uflw_err:1;     /* [1] Default:0x0 RW */
+		u32 fifo_dflw_err:1;     /* [2] Default:0x0 RW */
+		u32 fsm_err:1;           /* [3] Default:0x0 RW */
+		u32 cif_err:1;           /* [4] Default:0x0 RW */
+		u32 input_err:1;         /* [5] Default:0x0 RW */
+		u32 cfg_err:1;           /* [6] Default:0x0 RW */
+		u32 data_ucor_err:1;     /* [7] Default:0x0 RW */
+		u32 inmeta_ucor_err:1;   /* [8] Default:0x0 RW */
+		u32 meta_ucor_err:1;     /* [9] Default:0x0 RW */
+		u32 meta_cor_ecc_err:1;  /* [10] Default:0x0 RW */
+		u32 fwd_atid_nomat_err:1; /* [11] Default:0x1 RW */
+		u32 meta_value_err:1;    /* [12] Default:0x0 RW */
+		u32 edit_atnum_err:1;    /* [13] Default:0x0 RW */
+		u32 header_oft_ovf:1;    /* [14] Default:0x0 RW */
+		u32 edit_pos_err:1;      /* [15] Default:0x0 RW */
+		u32 da_oft_len_ovf:1;    /* [16] Default:0x0 RW */
+		u32 lxoffset_ovf:1;      /* [17] Default:0x0 RW */
+		u32 add_head_ovf:1;      /* [18] Default:0x0 RW */
+		u32 rsv:13;              /* [31:19] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_INT_MASK_DWLEN];
+} __packed;
+
+#define NBL_DPED_INT_SET_ADDR  (0x75c008)
+#define NBL_DPED_INT_SET_DEPTH (1)
+#define NBL_DPED_INT_SET_WIDTH (32)
+#define NBL_DPED_INT_SET_DWLEN (1)
+union dped_int_set_u {
+	struct dped_int_set {
+		u32 pkt_length_err:1;    /* [0] Default:0x0 WO */
+		u32 fifo_uflw_err:1;     /* [1] Default:0x0 WO */
+		u32 fifo_dflw_err:1;     /* [2] Default:0x0 WO */
+		u32 fsm_err:1;           /* [3] Default:0x0 WO */
+		u32 cif_err:1;           /* [4] Default:0x0 WO */
+		u32 input_err:1;         /* [5] Default:0x0 WO */
+		u32 cfg_err:1;           /* [6] Default:0x0 WO */
+		u32 data_ucor_err:1;     /* [7] Default:0x0 WO */
+		u32 inmeta_ucor_err:1;   /* [8] Default:0x0 WO */
+		u32 meta_ucor_err:1;     /* [9] Default:0x0 WO */
+		u32 meta_cor_ecc_err:1;  /* [10] Default:0x0 WO */
+		u32 fwd_atid_nomat_err:1; /* [11] Default:0x0 WO */
+		u32 meta_value_err:1;    /* [12] Default:0x0 WO */
+		u32 edit_atnum_err:1;    /* [13] Default:0x0 WO */
+		u32 header_oft_ovf:1;    /* [14] Default:0x0 WO */
+		u32 edit_pos_err:1;      /* [15] Default:0x0 WO */
+		u32 da_oft_len_ovf:1;    /* [16] Default:0x0 WO */
+		u32 lxoffset_ovf:1;      /* [17] Default:0x0 WO */
+		u32 add_head_ovf:1;      /* [18] Default:0x0 WO */
+		u32 rsv:13;              /* [31:19] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_INT_SET_DWLEN];
+} __packed;
+
+#define NBL_DPED_INIT_DONE_ADDR  (0x75c00c)
+#define NBL_DPED_INIT_DONE_DEPTH (1)
+#define NBL_DPED_INIT_DONE_WIDTH (32)
+#define NBL_DPED_INIT_DONE_DWLEN (1)
+union dped_init_done_u {
+	struct dped_init_done {
+		u32 done:1;              /* [00:00] Default:0x0 RO */
+		u32 rsv:31;              /* [31:01] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_INIT_DONE_DWLEN];
+} __packed;
+
+#define NBL_DPED_PKT_LENGTH_ERR_INFO_ADDR  (0x75c020)
+#define NBL_DPED_PKT_LENGTH_ERR_INFO_DEPTH (1)
+#define NBL_DPED_PKT_LENGTH_ERR_INFO_WIDTH (32)
+#define NBL_DPED_PKT_LENGTH_ERR_INFO_DWLEN (1)
+union dped_pkt_length_err_info_u {
+	struct dped_pkt_length_err_info {
+		u32 ptr_eop:1;           /* [0] Default:0x0 RC */
+		u32 pkt_eop:1;           /* [1] Default:0x0 RC */
+		u32 pkt_mod:1;           /* [2] Default:0x0 RC */
+		u32 rsv:29;              /* [31:3] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_PKT_LENGTH_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_DPED_CIF_ERR_INFO_ADDR  (0x75c040)
+#define NBL_DPED_CIF_ERR_INFO_DEPTH (1)
+#define NBL_DPED_CIF_ERR_INFO_WIDTH (32)
+#define NBL_DPED_CIF_ERR_INFO_DWLEN (1)
+union dped_cif_err_info_u {
+	struct dped_cif_err_info {
+		u32 addr:30;             /* [29:0] Default:0x0 RO */
+		u32 wr_err:1;            /* [30] Default:0x0 RO */
+		u32 ucor_err:1;          /* [31] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_CIF_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_DPED_INPUT_ERR_INFO_ADDR  (0x75c048)
+#define NBL_DPED_INPUT_ERR_INFO_DEPTH (1)
+#define NBL_DPED_INPUT_ERR_INFO_WIDTH (32)
+#define NBL_DPED_INPUT_ERR_INFO_DWLEN (1)
+union dped_input_err_info_u {
+	struct dped_input_err_info {
+		u32 eoc_miss:1;          /* [0] Default:0x0 RC */
+		u32 soc_miss:1;          /* [1] Default:0x0 RC */
+		u32 rsv:30;              /* [31:2] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_INPUT_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_DPED_CFG_ERR_INFO_ADDR  (0x75c050)
+#define NBL_DPED_CFG_ERR_INFO_DEPTH (1)
+#define NBL_DPED_CFG_ERR_INFO_WIDTH (32)
+#define NBL_DPED_CFG_ERR_INFO_DWLEN (1)
+union dped_cfg_err_info_u {
+	struct dped_cfg_err_info {
+		u32 length:1;            /* [0] Default:0x0 RC */
+		u32 rd_conflict:1;       /* [1] Default:0x0 RC */
+		u32 rd_addr:8;           /* [9:2] Default:0x0 RC */
+		u32 rsv:22;              /* [31:10] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_CFG_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_DPED_FWD_ATID_NOMAT_ERR_INFO_ADDR  (0x75c06c)
+#define NBL_DPED_FWD_ATID_NOMAT_ERR_INFO_DEPTH (1)
+#define NBL_DPED_FWD_ATID_NOMAT_ERR_INFO_WIDTH (32)
+#define NBL_DPED_FWD_ATID_NOMAT_ERR_INFO_DWLEN (1)
+union dped_fwd_atid_nomat_err_info_u {
+	struct dped_fwd_atid_nomat_err_info {
+		u32 dport:1;             /* [0] Default:0x0 RC */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_FWD_ATID_NOMAT_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_DPED_META_VALUE_ERR_INFO_ADDR  (0x75c070)
+#define NBL_DPED_META_VALUE_ERR_INFO_DEPTH (1)
+#define NBL_DPED_META_VALUE_ERR_INFO_WIDTH (32)
+#define NBL_DPED_META_VALUE_ERR_INFO_DWLEN (1)
+union dped_meta_value_err_info_u {
+	struct dped_meta_value_err_info {
+		u32 sport:1;             /* [0] Default:0x0 RC */
+		u32 dport:1;             /* [1] Default:0x0 RC */
+		u32 dscp_ecn:1;          /* [2] Default:0x0 RC */
+		u32 tnl:1;               /* [3] Default:0x0 RC */
+		u32 vni:1;               /* [4] Default:0x0 RC */
+		u32 vni_one:1;           /* [5] Default:0x0 RC */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_META_VALUE_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_DPED_EDIT_ATNUM_ERR_INFO_ADDR  (0x75c078)
+#define NBL_DPED_EDIT_ATNUM_ERR_INFO_DEPTH (1)
+#define NBL_DPED_EDIT_ATNUM_ERR_INFO_WIDTH (32)
+#define NBL_DPED_EDIT_ATNUM_ERR_INFO_DWLEN (1)
+union dped_edit_atnum_err_info_u {
+	struct dped_edit_atnum_err_info {
+		u32 replace:1;           /* [0] Default:0x0 RC */
+		u32 del_add:1;           /* [1] Default:0x0 RC */
+		u32 ttl:1;               /* [2] Default:0x0 RC */
+		u32 dscp:1;              /* [3] Default:0x0 RC */
+		u32 tnl:1;               /* [4] Default:0x0 RC */
+		u32 sport:1;             /* [5] Default:0x0 RC */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_EDIT_ATNUM_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_DPED_HEADER_OFT_OVF_ADDR  (0x75c080)
+#define NBL_DPED_HEADER_OFT_OVF_DEPTH (1)
+#define NBL_DPED_HEADER_OFT_OVF_WIDTH (32)
+#define NBL_DPED_HEADER_OFT_OVF_DWLEN (1)
+union dped_header_oft_ovf_u {
+	struct dped_header_oft_ovf {
+		u32 replace:1;           /* [0] Default:0x0 RC */
+		u32 rsv2:7;              /* [7:1] Default:0x0 RO */
+		u32 add_del:6;           /* [13:8] Default:0x0 RC */
+		u32 dscp_ecn:1;          /* [14] Default:0x0 RC */
+		u32 rsv1:1;              /* [15] Default:0x0 RO */
+		u32 ttl:1;               /* [16] Default:0x0 RC */
+		u32 sctp:1;              /* [17] Default:0x0 RC */
+		u32 dscp:1;              /* [18] Default:0x0 RC */
+		u32 pri:1;               /* [19] Default:0x0 RC */
+		u32 len0:1;              /* [20] Default:0x0 RC */
+		u32 len1:1;              /* [21] Default:0x0 RC */
+		u32 ck0:1;               /* [22] Default:0x0 RC */
+		u32 ck1:1;               /* [23] Default:0x0 RC */
+		u32 ck_start0_0:1;       /* [24] Default:0x0 RC */
+		u32 ck_start0_1:1;       /* [25] Default:0x0 RC */
+		u32 ck_start1_0:1;       /* [26] Default:0x0 RC */
+		u32 ck_start1_1:1;       /* [27] Default:0x0 RC */
+		u32 head:1;              /* [28] Default:0x0 RC */
+		u32 ck_len0:1;           /* [29] Default:0x0 RC */
+		u32 ck_len1:1;           /* [30] Default:0x0 RC */
+		u32 rsv:1;               /* [31] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_HEADER_OFT_OVF_DWLEN];
+} __packed;
+
+#define NBL_DPED_EDIT_POS_ERR_ADDR  (0x75c088)
+#define NBL_DPED_EDIT_POS_ERR_DEPTH (1)
+#define NBL_DPED_EDIT_POS_ERR_WIDTH (32)
+#define NBL_DPED_EDIT_POS_ERR_DWLEN (1)
+union dped_edit_pos_err_u {
+	struct dped_edit_pos_err {
+		u32 replace:1;           /* [0] Default:0x0 RC */
+		u32 cross_level:6;       /* [6:1] Default:0x0 RC */
+		u32 rsv2:1;              /* [7] Default:0x0 RO */
+		u32 add_del:6;           /* [13:8] Default:0x0 RC */
+		u32 dscp_ecn:1;          /* [14] Default:0x0 RC */
+		u32 rsv1:1;              /* [15] Default:0x0 RO */
+		u32 ttl:1;               /* [16] Default:0x0 RC */
+		u32 sctp:1;              /* [17] Default:0x0 RC */
+		u32 dscp:1;              /* [18] Default:0x0 RC */
+		u32 pri:1;               /* [19] Default:0x0 RC */
+		u32 len0:1;              /* [20] Default:0x0 RC */
+		u32 len1:1;              /* [21] Default:0x0 RC */
+		u32 ck0:1;               /* [22] Default:0x0 RC */
+		u32 ck1:1;               /* [23] Default:0x0 RC */
+		u32 ck_start0_0:1;       /* [24] Default:0x0 RC */
+		u32 ck_start0_1:1;       /* [25] Default:0x0 RC */
+		u32 ck_start1_0:1;       /* [26] Default:0x0 RC */
+		u32 ck_start1_1:1;       /* [27] Default:0x0 RC */
+		u32 ck_len0:1;           /* [28] Default:0x0 RC */
+		u32 ck_len1:1;           /* [29] Default:0x0 RC */
+		u32 rsv:2;               /* [31:30] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_EDIT_POS_ERR_DWLEN];
+} __packed;
+
+#define NBL_DPED_DA_OFT_LEN_OVF_ADDR  (0x75c090)
+#define NBL_DPED_DA_OFT_LEN_OVF_DEPTH (1)
+#define NBL_DPED_DA_OFT_LEN_OVF_WIDTH (32)
+#define NBL_DPED_DA_OFT_LEN_OVF_DWLEN (1)
+union dped_da_oft_len_ovf_u {
+	struct dped_da_oft_len_ovf {
+		u32 at0:5;               /* [4:0] Default:0x0 RC */
+		u32 at1:5;               /* [9:5] Default:0x0 RC */
+		u32 at2:5;               /* [14:10] Default:0x0 RC */
+		u32 at3:5;               /* [19:15] Default:0x0 RC */
+		u32 at4:5;               /* [24:20] Default:0x0 RC */
+		u32 at5:5;               /* [29:25] Default:0x0 RC */
+		u32 rsv:2;               /* [31:30] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_DA_OFT_LEN_OVF_DWLEN];
+} __packed;
+
+#define NBL_DPED_LXOFFSET_OVF_ADDR  (0x75c098)
+#define NBL_DPED_LXOFFSET_OVF_DEPTH (1)
+#define NBL_DPED_LXOFFSET_OVF_WIDTH (32)
+#define NBL_DPED_LXOFFSET_OVF_DWLEN (1)
+union dped_lxoffset_ovf_u {
+	struct dped_lxoffset_ovf {
+		u32 l2:1;                /* [0] Default:0x0 RC */
+		u32 l3:1;                /* [1] Default:0x0 RC */
+		u32 l4:1;                /* [2] Default:0x0 RC */
+		u32 pld:1;               /* [3] Default:0x0 RC */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_LXOFFSET_OVF_DWLEN];
+} __packed;
+
+#define NBL_DPED_ADD_HEAD_OVF_ADDR  (0x75c0a0)
+#define NBL_DPED_ADD_HEAD_OVF_DEPTH (1)
+#define NBL_DPED_ADD_HEAD_OVF_WIDTH (32)
+#define NBL_DPED_ADD_HEAD_OVF_DWLEN (1)
+union dped_add_head_ovf_u {
+	struct dped_add_head_ovf {
+		u32 tnl_l2:1;            /* [0] Default:0x0 RC */
+		u32 tnl_pkt:1;           /* [1] Default:0x0 RC */
+		u32 rsv1:14;             /* [15:2] Default:0x0 RO */
+		u32 mir_l2:1;            /* [16] Default:0x0 RC */
+		u32 mir_pkt:1;           /* [17] Default:0x0 RC */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_ADD_HEAD_OVF_DWLEN];
+} __packed;
+
+#define NBL_DPED_CAR_CTRL_ADDR  (0x75c100)
+#define NBL_DPED_CAR_CTRL_DEPTH (1)
+#define NBL_DPED_CAR_CTRL_WIDTH (32)
+#define NBL_DPED_CAR_CTRL_DWLEN (1)
+union dped_car_ctrl_u {
+	struct dped_car_ctrl {
+		u32 sctr_car:1;          /* [00:00] Default:0x1 RW */
+		u32 rctr_car:1;          /* [01:01] Default:0x1 RW */
+		u32 rc_car:1;            /* [02:02] Default:0x1 RW */
+		u32 tbl_rc_car:1;        /* [03:03] Default:0x1 RW */
+		u32 rsv:28;              /* [31:04] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_CAR_CTRL_DWLEN];
+} __packed;
+
+#define NBL_DPED_INIT_START_ADDR  (0x75c10c)
+#define NBL_DPED_INIT_START_DEPTH (1)
+#define NBL_DPED_INIT_START_WIDTH (32)
+#define NBL_DPED_INIT_START_DWLEN (1)
+union dped_init_start_u {
+	struct dped_init_start {
+		u32 start:1;             /* [00:00] Default:0x0 WO */
+		u32 rsv:31;              /* [31:01] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_INIT_START_DWLEN];
+} __packed;
+
+#define NBL_DPED_TIMEOUT_CFG_ADDR  (0x75c110)
+#define NBL_DPED_TIMEOUT_CFG_DEPTH (1)
+#define NBL_DPED_TIMEOUT_CFG_WIDTH (32)
+#define NBL_DPED_TIMEOUT_CFG_DWLEN (1)
+union dped_timeout_cfg_u {
+	struct dped_timeout_cfg {
+		u32 fsm_max_num:16;      /* [15:00] Default:0xfff RW */
+		u32 tab:8;               /* [23:16] Default:0x40 RW */
+		u32 rsv:8;               /* [31:24] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_TIMEOUT_CFG_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_MAX_LENGTH_ADDR  (0x75c154)
+#define NBL_DPED_TNL_MAX_LENGTH_DEPTH (1)
+#define NBL_DPED_TNL_MAX_LENGTH_WIDTH (32)
+#define NBL_DPED_TNL_MAX_LENGTH_DWLEN (1)
+union dped_tnl_max_length_u {
+	struct dped_tnl_max_length {
+		u32 th:7;                /* [6:0] Default:0x5A RW */
+		u32 rsv:25;              /* [31:7] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_MAX_LENGTH_DWLEN];
+} __packed;
+
+#define NBL_DPED_PKT_DROP_EN_ADDR  (0x75c170)
+#define NBL_DPED_PKT_DROP_EN_DEPTH (1)
+#define NBL_DPED_PKT_DROP_EN_WIDTH (32)
+#define NBL_DPED_PKT_DROP_EN_DWLEN (1)
+union dped_pkt_drop_en_u {
+	struct dped_pkt_drop_en {
+		u32 en:1;                /* [0] Default:0x1 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_PKT_DROP_EN_DWLEN];
+} __packed;
+
+#define NBL_DPED_PKT_HERR_DROP_EN_ADDR  (0x75c174)
+#define NBL_DPED_PKT_HERR_DROP_EN_DEPTH (1)
+#define NBL_DPED_PKT_HERR_DROP_EN_WIDTH (32)
+#define NBL_DPED_PKT_HERR_DROP_EN_DWLEN (1)
+union dped_pkt_herr_drop_en_u {
+	struct dped_pkt_herr_drop_en {
+		u32 en:1;                /* [0] Default:0x1 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_PKT_HERR_DROP_EN_DWLEN];
+} __packed;
+
+#define NBL_DPED_PKT_PARITY_DROP_EN_ADDR  (0x75c178)
+#define NBL_DPED_PKT_PARITY_DROP_EN_DEPTH (1)
+#define NBL_DPED_PKT_PARITY_DROP_EN_WIDTH (32)
+#define NBL_DPED_PKT_PARITY_DROP_EN_DWLEN (1)
+union dped_pkt_parity_drop_en_u {
+	struct dped_pkt_parity_drop_en {
+		u32 en0:1;               /* [0] Default:0x1 RW */
+		u32 en1:1;               /* [1] Default:0x1 RW */
+		u32 rsv:30;              /* [31:2] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_PKT_PARITY_DROP_EN_DWLEN];
+} __packed;
+
+#define NBL_DPED_TTL_DROP_EN_ADDR  (0x75c17c)
+#define NBL_DPED_TTL_DROP_EN_DEPTH (1)
+#define NBL_DPED_TTL_DROP_EN_WIDTH (32)
+#define NBL_DPED_TTL_DROP_EN_DWLEN (1)
+union dped_ttl_drop_en_u {
+	struct dped_ttl_drop_en {
+		u32 en:1;                /* [0] Default:0x1 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_TTL_DROP_EN_DWLEN];
+} __packed;
+
+#define NBL_DPED_TTL_ERROR_CODE_ADDR  (0x75c188)
+#define NBL_DPED_TTL_ERROR_CODE_DEPTH (1)
+#define NBL_DPED_TTL_ERROR_CODE_WIDTH (32)
+#define NBL_DPED_TTL_ERROR_CODE_DWLEN (1)
+union dped_ttl_error_code_u {
+	struct dped_ttl_error_code {
+		u32 en:1;                /* [0] Default:0x1 RW */
+		u32 rsv1:7;              /* [7:1] Default:0x0 RO */
+		u32 id:4;                /* [11:8] Default:0x6 RW */
+		u32 rsv:20;              /* [31:12] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_TTL_ERROR_CODE_DWLEN];
+} __packed;
+
+#define NBL_DPED_HIGH_PRI_PKT_EN_ADDR  (0x75c190)
+#define NBL_DPED_HIGH_PRI_PKT_EN_DEPTH (1)
+#define NBL_DPED_HIGH_PRI_PKT_EN_WIDTH (32)
+#define NBL_DPED_HIGH_PRI_PKT_EN_DWLEN (1)
+union dped_high_pri_pkt_en_u {
+	struct dped_high_pri_pkt_en {
+		u32 en:1;                /* [0] Default:0x1 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_HIGH_PRI_PKT_EN_DWLEN];
+} __packed;
+
+#define NBL_DPED_PADDING_CFG_ADDR  (0x75c194)
+#define NBL_DPED_PADDING_CFG_DEPTH (1)
+#define NBL_DPED_PADDING_CFG_WIDTH (32)
+#define NBL_DPED_PADDING_CFG_DWLEN (1)
+union dped_padding_cfg_u {
+	struct dped_padding_cfg {
+		u32 th:6;                /* [5:0] Default:0x3B RW */
+		u32 rsv1:2;              /* [7:6] Default:0x0 RO */
+		u32 mode:2;              /* [9:8] Default:0x0 RW */
+		u32 rsv:22;              /* [31:10] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_PADDING_CFG_DWLEN];
+} __packed;
+
+#define NBL_DPED_HW_EDIT_FLAG_SEL0_ADDR  (0x75c204)
+#define NBL_DPED_HW_EDIT_FLAG_SEL0_DEPTH (1)
+#define NBL_DPED_HW_EDIT_FLAG_SEL0_WIDTH (32)
+#define NBL_DPED_HW_EDIT_FLAG_SEL0_DWLEN (1)
+union dped_hw_edit_flag_sel0_u {
+	struct dped_hw_edit_flag_sel0 {
+		u32 oft:5;               /* [4:0] Default:0x1 RW */
+		u32 rsv:27;              /* [31:5] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_HW_EDIT_FLAG_SEL0_DWLEN];
+} __packed;
+
+#define NBL_DPED_HW_EDIT_FLAG_SEL1_ADDR  (0x75c208)
+#define NBL_DPED_HW_EDIT_FLAG_SEL1_DEPTH (1)
+#define NBL_DPED_HW_EDIT_FLAG_SEL1_WIDTH (32)
+#define NBL_DPED_HW_EDIT_FLAG_SEL1_DWLEN (1)
+union dped_hw_edit_flag_sel1_u {
+	struct dped_hw_edit_flag_sel1 {
+		u32 oft:5;               /* [4:0] Default:0x2 RW */
+		u32 rsv:27;              /* [31:5] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_HW_EDIT_FLAG_SEL1_DWLEN];
+} __packed;
+
+#define NBL_DPED_HW_EDIT_FLAG_SEL2_ADDR  (0x75c20c)
+#define NBL_DPED_HW_EDIT_FLAG_SEL2_DEPTH (1)
+#define NBL_DPED_HW_EDIT_FLAG_SEL2_WIDTH (32)
+#define NBL_DPED_HW_EDIT_FLAG_SEL2_DWLEN (1)
+union dped_hw_edit_flag_sel2_u {
+	struct dped_hw_edit_flag_sel2 {
+		u32 oft:5;               /* [4:0] Default:0x3 RW */
+		u32 rsv:27;              /* [31:5] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_HW_EDIT_FLAG_SEL2_DWLEN];
+} __packed;
+
+#define NBL_DPED_HW_EDIT_FLAG_SEL3_ADDR  (0x75c210)
+#define NBL_DPED_HW_EDIT_FLAG_SEL3_DEPTH (1)
+#define NBL_DPED_HW_EDIT_FLAG_SEL3_WIDTH (32)
+#define NBL_DPED_HW_EDIT_FLAG_SEL3_DWLEN (1)
+union dped_hw_edit_flag_sel3_u {
+	struct dped_hw_edit_flag_sel3 {
+		u32 oft:5;               /* [4:0] Default:0x4 RW */
+		u32 rsv:27;              /* [31:5] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_HW_EDIT_FLAG_SEL3_DWLEN];
+} __packed;
+
+#define NBL_DPED_HW_EDIT_FLAG_SEL4_ADDR  (0x75c214)
+#define NBL_DPED_HW_EDIT_FLAG_SEL4_DEPTH (1)
+#define NBL_DPED_HW_EDIT_FLAG_SEL4_WIDTH (32)
+#define NBL_DPED_HW_EDIT_FLAG_SEL4_DWLEN (1)
+union dped_hw_edit_flag_sel4_u {
+	struct dped_hw_edit_flag_sel4 {
+		u32 oft:5;               /* [4:0] Default:0xe RW */
+		u32 rsv:27;              /* [31:5] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_HW_EDIT_FLAG_SEL4_DWLEN];
+} __packed;
+
+#define NBL_DPED_RDMA_FLAG_ADDR  (0x75c22c)
+#define NBL_DPED_RDMA_FLAG_DEPTH (1)
+#define NBL_DPED_RDMA_FLAG_WIDTH (32)
+#define NBL_DPED_RDMA_FLAG_DWLEN (1)
+union dped_rdma_flag_u {
+	struct dped_rdma_flag {
+		u32 oft:5;               /* [4:0] Default:0xa RW */
+		u32 rsv:27;              /* [31:5] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_RDMA_FLAG_DWLEN];
+} __packed;
+
+#define NBL_DPED_FWD_DPORT_ADDR  (0x75c230)
+#define NBL_DPED_FWD_DPORT_DEPTH (1)
+#define NBL_DPED_FWD_DPORT_WIDTH (32)
+#define NBL_DPED_FWD_DPORT_DWLEN (1)
+union dped_fwd_dport_u {
+	struct dped_fwd_dport {
+		u32 id:6;                /* [5:0] Default:0x9 RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_FWD_DPORT_DWLEN];
+} __packed;
+
+#define NBL_DPED_FWD_MIRID_ADDR  (0x75c238)
+#define NBL_DPED_FWD_MIRID_DEPTH (1)
+#define NBL_DPED_FWD_MIRID_WIDTH (32)
+#define NBL_DPED_FWD_MIRID_DWLEN (1)
+union dped_fwd_mirid_u {
+	struct dped_fwd_mirid {
+		u32 id:6;                /* [5:0] Default:0x8 RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_FWD_MIRID_DWLEN];
+} __packed;
+
+#define NBL_DPED_FWD_VNI0_ADDR  (0x75c244)
+#define NBL_DPED_FWD_VNI0_DEPTH (1)
+#define NBL_DPED_FWD_VNI0_WIDTH (32)
+#define NBL_DPED_FWD_VNI0_DWLEN (1)
+union dped_fwd_vni0_u {
+	struct dped_fwd_vni0 {
+		u32 id:6;                /* [5:0] Default:0xe RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_FWD_VNI0_DWLEN];
+} __packed;
+
+#define NBL_DPED_FWD_VNI1_ADDR  (0x75c248)
+#define NBL_DPED_FWD_VNI1_DEPTH (1)
+#define NBL_DPED_FWD_VNI1_WIDTH (32)
+#define NBL_DPED_FWD_VNI1_DWLEN (1)
+union dped_fwd_vni1_u {
+	struct dped_fwd_vni1 {
+		u32 id:6;                /* [5:0] Default:0xf RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_FWD_VNI1_DWLEN];
+} __packed;
+
+#define NBL_DPED_FWD_PRI_MDF_ADDR  (0x75c250)
+#define NBL_DPED_FWD_PRI_MDF_DEPTH (1)
+#define NBL_DPED_FWD_PRI_MDF_WIDTH (32)
+#define NBL_DPED_FWD_PRI_MDF_DWLEN (1)
+union dped_fwd_pri_mdf_u {
+	struct dped_fwd_pri_mdf {
+		u32 id:6;                /* [5:0] Default:0x15 RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_FWD_PRI_MDF_DWLEN];
+} __packed;
+
+#define NBL_DPED_VLAN_TYPE0_ADDR  (0x75c260)
+#define NBL_DPED_VLAN_TYPE0_DEPTH (1)
+#define NBL_DPED_VLAN_TYPE0_WIDTH (32)
+#define NBL_DPED_VLAN_TYPE0_DWLEN (1)
+union dped_vlan_type0_u {
+	struct dped_vlan_type0 {
+		u32 vau:16;              /* [15:0] Default:0x8100 RW */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_VLAN_TYPE0_DWLEN];
+} __packed;
+
+#define NBL_DPED_VLAN_TYPE1_ADDR  (0x75c264)
+#define NBL_DPED_VLAN_TYPE1_DEPTH (1)
+#define NBL_DPED_VLAN_TYPE1_WIDTH (32)
+#define NBL_DPED_VLAN_TYPE1_DWLEN (1)
+union dped_vlan_type1_u {
+	struct dped_vlan_type1 {
+		u32 vau:16;              /* [15:0] Default:0x88A8 RW */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_VLAN_TYPE1_DWLEN];
+} __packed;
+
+#define NBL_DPED_VLAN_TYPE2_ADDR  (0x75c268)
+#define NBL_DPED_VLAN_TYPE2_DEPTH (1)
+#define NBL_DPED_VLAN_TYPE2_WIDTH (32)
+#define NBL_DPED_VLAN_TYPE2_DWLEN (1)
+union dped_vlan_type2_u {
+	struct dped_vlan_type2 {
+		u32 vau:16;              /* [15:0] Default:0x9100 RW */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_VLAN_TYPE2_DWLEN];
+} __packed;
+
+#define NBL_DPED_VLAN_TYPE3_ADDR  (0x75c26c)
+#define NBL_DPED_VLAN_TYPE3_DEPTH (1)
+#define NBL_DPED_VLAN_TYPE3_WIDTH (32)
+#define NBL_DPED_VLAN_TYPE3_DWLEN (1)
+union dped_vlan_type3_u {
+	struct dped_vlan_type3 {
+		u32 vau:16;              /* [15:0] Default:0x0 RW */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_VLAN_TYPE3_DWLEN];
+} __packed;
+
+#define NBL_DPED_L3_LEN_MDY_CMD_0_ADDR  (0x75c300)
+#define NBL_DPED_L3_LEN_MDY_CMD_0_DEPTH (1)
+#define NBL_DPED_L3_LEN_MDY_CMD_0_WIDTH (32)
+#define NBL_DPED_L3_LEN_MDY_CMD_0_DWLEN (1)
+union dped_l3_len_mdy_cmd_0_u {
+	struct dped_l3_len_mdy_cmd_0 {
+		u32 value:8;             /* [7:0] Default:0x0 RW */
+		u32 in_oft:7;            /* [14:8] Default:0x2 RW */
+		u32 rsv3:1;              /* [15] Default:0x0 RO */
+		u32 phid:2;              /* [17:16] Default:0x2 RW */
+		u32 rsv2:2;              /* [19:18] Default:0x0 RO */
+		u32 mode:2;              /* [21:20] Default:0x2 RW */
+		u32 rsv1:2;              /* [23:22] Default:0x0 RO */
+		u32 unit:1;              /* [24] Default:0x0 RW */
+		u32 rsv:6;               /* [30:25] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L3_LEN_MDY_CMD_0_DWLEN];
+} __packed;
+
+#define NBL_DPED_L3_LEN_MDY_CMD_1_ADDR  (0x75c304)
+#define NBL_DPED_L3_LEN_MDY_CMD_1_DEPTH (1)
+#define NBL_DPED_L3_LEN_MDY_CMD_1_WIDTH (32)
+#define NBL_DPED_L3_LEN_MDY_CMD_1_DWLEN (1)
+union dped_l3_len_mdy_cmd_1_u {
+	struct dped_l3_len_mdy_cmd_1 {
+		u32 value:8;             /* [7:0] Default:0x28 RW */
+		u32 in_oft:7;            /* [14:8] Default:0x4 RW */
+		u32 rsv3:1;              /* [15] Default:0x0 RO */
+		u32 phid:2;              /* [17:16] Default:0x2 RW */
+		u32 rsv2:2;              /* [19:18] Default:0x0 RO */
+		u32 mode:2;              /* [21:20] Default:0x1 RW */
+		u32 rsv1:2;              /* [23:22] Default:0x0 RO */
+		u32 unit:1;              /* [24] Default:0x0 RW */
+		u32 rsv:6;               /* [30:25] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L3_LEN_MDY_CMD_1_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_LEN_MDY_CMD_0_ADDR  (0x75c308)
+#define NBL_DPED_L4_LEN_MDY_CMD_0_DEPTH (1)
+#define NBL_DPED_L4_LEN_MDY_CMD_0_WIDTH (32)
+#define NBL_DPED_L4_LEN_MDY_CMD_0_DWLEN (1)
+union dped_l4_len_mdy_cmd_0_u {
+	struct dped_l4_len_mdy_cmd_0 {
+		u32 value:8;             /* [7:0] Default:0x0 RW */
+		u32 in_oft:7;            /* [14:8] Default:0xc RW */
+		u32 rsv3:1;              /* [15] Default:0x0 RO */
+		u32 phid:2;              /* [17:16] Default:0x3 RW */
+		u32 rsv2:2;              /* [19:18] Default:0x0 RO */
+		u32 mode:2;              /* [21:20] Default:0x0 RW */
+		u32 rsv1:2;              /* [23:22] Default:0x0 RO */
+		u32 unit:1;              /* [24] Default:0x1 RW */
+		u32 rsv:6;               /* [30:25] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_LEN_MDY_CMD_0_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_LEN_MDY_CMD_1_ADDR  (0x75c30c)
+#define NBL_DPED_L4_LEN_MDY_CMD_1_DEPTH (1)
+#define NBL_DPED_L4_LEN_MDY_CMD_1_WIDTH (32)
+#define NBL_DPED_L4_LEN_MDY_CMD_1_DWLEN (1)
+union dped_l4_len_mdy_cmd_1_u {
+	struct dped_l4_len_mdy_cmd_1 {
+		u32 value:8;             /* [7:0] Default:0x0 RW */
+		u32 in_oft:7;            /* [14:8] Default:0x4 RW */
+		u32 rsv3:1;              /* [15] Default:0x0 RO */
+		u32 phid:2;              /* [17:16] Default:0x3 RW */
+		u32 rsv2:2;              /* [19:18] Default:0x0 RO */
+		u32 mode:2;              /* [21:20] Default:0x0 RW */
+		u32 rsv1:2;              /* [23:22] Default:0x0 RO */
+		u32 unit:1;              /* [24] Default:0x1 RW */
+		u32 rsv:6;               /* [30:25] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_LEN_MDY_CMD_1_DWLEN];
+} __packed;
+
+#define NBL_DPED_L3_CK_CMD_00_ADDR  (0x75c310)
+#define NBL_DPED_L3_CK_CMD_00_DEPTH (1)
+#define NBL_DPED_L3_CK_CMD_00_WIDTH (32)
+#define NBL_DPED_L3_CK_CMD_00_DWLEN (1)
+union dped_l3_ck_cmd_00_u {
+	struct dped_l3_ck_cmd_00 {
+		u32 value:8;             /* [7:0] Default:0x0 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x0 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x0 RW */
+		u32 len_vld:1;           /* [17] Default:0x0 RW */
+		u32 data_vld:1;          /* [18] Default:0x0 RW */
+		u32 in_oft:7;            /* [25:19] Default:0xa RW */
+		u32 phid:2;              /* [27:26] Default:0x2 RW */
+		u32 flag:1;              /* [28] Default:0x0 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L3_CK_CMD_00_DWLEN];
+} __packed;
+
+#define NBL_DPED_L3_CK_CMD_01_ADDR  (0x75c314)
+#define NBL_DPED_L3_CK_CMD_01_DEPTH (1)
+#define NBL_DPED_L3_CK_CMD_01_WIDTH (32)
+#define NBL_DPED_L3_CK_CMD_01_DWLEN (1)
+union dped_l3_ck_cmd_01_u {
+	struct dped_l3_ck_cmd_01 {
+		u32 ck_start0:6;         /* [5:0] Default:0x0 RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x0 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x0 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x0 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L3_CK_CMD_01_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_CK_CMD_00_ADDR  (0x75c318)
+#define NBL_DPED_L4_CK_CMD_00_DEPTH (1)
+#define NBL_DPED_L4_CK_CMD_00_WIDTH (32)
+#define NBL_DPED_L4_CK_CMD_00_DWLEN (1)
+union dped_l4_ck_cmd_00_u {
+	struct dped_l4_ck_cmd_00 {
+		u32 value:8;             /* [7:0] Default:0x6 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x2 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x2 RW */
+		u32 len_vld:1;           /* [17] Default:0x1 RW */
+		u32 data_vld:1;          /* [18] Default:0x1 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x10 RW */
+		u32 phid:2;              /* [27:26] Default:0x3 RW */
+		u32 flag:1;              /* [28] Default:0x0 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_CK_CMD_00_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_CK_CMD_01_ADDR  (0x75c31c)
+#define NBL_DPED_L4_CK_CMD_01_DEPTH (1)
+#define NBL_DPED_L4_CK_CMD_01_WIDTH (32)
+#define NBL_DPED_L4_CK_CMD_01_DWLEN (1)
+union dped_l4_ck_cmd_01_u {
+	struct dped_l4_ck_cmd_01 {
+		u32 ck_start0:6;         /* [5:0] Default:0xc RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x8 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x3 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x0 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_CK_CMD_01_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_CK_CMD_10_ADDR  (0x75c320)
+#define NBL_DPED_L4_CK_CMD_10_DEPTH (1)
+#define NBL_DPED_L4_CK_CMD_10_WIDTH (32)
+#define NBL_DPED_L4_CK_CMD_10_DWLEN (1)
+union dped_l4_ck_cmd_10_u {
+	struct dped_l4_ck_cmd_10 {
+		u32 value:8;             /* [7:0] Default:0x11 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x2 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x2 RW */
+		u32 len_vld:1;           /* [17] Default:0x1 RW */
+		u32 data_vld:1;          /* [18] Default:0x1 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x6 RW */
+		u32 phid:2;              /* [27:26] Default:0x3 RW */
+		u32 flag:1;              /* [28] Default:0x1 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_CK_CMD_10_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_CK_CMD_11_ADDR  (0x75c324)
+#define NBL_DPED_L4_CK_CMD_11_DEPTH (1)
+#define NBL_DPED_L4_CK_CMD_11_WIDTH (32)
+#define NBL_DPED_L4_CK_CMD_11_DWLEN (1)
+union dped_l4_ck_cmd_11_u {
+	struct dped_l4_ck_cmd_11 {
+		u32 ck_start0:6;         /* [5:0] Default:0xc RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x8 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x3 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x0 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_CK_CMD_11_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_CK_CMD_20_ADDR  (0x75c328)
+#define NBL_DPED_L4_CK_CMD_20_DEPTH (1)
+#define NBL_DPED_L4_CK_CMD_20_WIDTH (32)
+#define NBL_DPED_L4_CK_CMD_20_DWLEN (1)
+union dped_l4_ck_cmd_20_u {
+	struct dped_l4_ck_cmd_20 {
+		u32 value:8;             /* [7:0] Default:0x2e RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x4 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x2 RW */
+		u32 len_vld:1;           /* [17] Default:0x1 RW */
+		u32 data_vld:1;          /* [18] Default:0x1 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x10 RW */
+		u32 phid:2;              /* [27:26] Default:0x3 RW */
+		u32 flag:1;              /* [28] Default:0x0 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_CK_CMD_20_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_CK_CMD_21_ADDR  (0x75c32c)
+#define NBL_DPED_L4_CK_CMD_21_DEPTH (1)
+#define NBL_DPED_L4_CK_CMD_21_WIDTH (32)
+#define NBL_DPED_L4_CK_CMD_21_DWLEN (1)
+union dped_l4_ck_cmd_21_u {
+	struct dped_l4_ck_cmd_21 {
+		u32 ck_start0:6;         /* [5:0] Default:0x8 RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x20 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x3 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x0 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_CK_CMD_21_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_CK_CMD_30_ADDR  (0x75c330)
+#define NBL_DPED_L4_CK_CMD_30_DEPTH (1)
+#define NBL_DPED_L4_CK_CMD_30_WIDTH (32)
+#define NBL_DPED_L4_CK_CMD_30_DWLEN (1)
+union dped_l4_ck_cmd_30_u {
+	struct dped_l4_ck_cmd_30 {
+		u32 value:8;             /* [7:0] Default:0x39 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x4 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x2 RW */
+		u32 len_vld:1;           /* [17] Default:0x1 RW */
+		u32 data_vld:1;          /* [18] Default:0x1 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x6 RW */
+		u32 phid:2;              /* [27:26] Default:0x3 RW */
+		u32 flag:1;              /* [28] Default:0x1 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_CK_CMD_30_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_CK_CMD_31_ADDR  (0x75c334)
+#define NBL_DPED_L4_CK_CMD_31_DEPTH (1)
+#define NBL_DPED_L4_CK_CMD_31_WIDTH (32)
+#define NBL_DPED_L4_CK_CMD_31_DWLEN (1)
+union dped_l4_ck_cmd_31_u {
+	struct dped_l4_ck_cmd_31 {
+		u32 ck_start0:6;         /* [5:0] Default:0x8 RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x20 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x3 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x0 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_CK_CMD_31_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_CK_CMD_40_ADDR  (0x75c338)
+#define NBL_DPED_L4_CK_CMD_40_DEPTH (1)
+#define NBL_DPED_L4_CK_CMD_40_WIDTH (32)
+#define NBL_DPED_L4_CK_CMD_40_DWLEN (1)
+union dped_l4_ck_cmd_40_u {
+	struct dped_l4_ck_cmd_40 {
+		u32 value:8;             /* [7:0] Default:0x0 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x0 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x0 RW */
+		u32 len_vld:1;           /* [17] Default:0x0 RW */
+		u32 data_vld:1;          /* [18] Default:0x0 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x8 RW */
+		u32 phid:2;              /* [27:26] Default:0x3 RW */
+		u32 flag:1;              /* [28] Default:0x0 RW */
+		u32 mode:1;              /* [29] Default:0x1 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_CK_CMD_40_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_CK_CMD_41_ADDR  (0x75c33c)
+#define NBL_DPED_L4_CK_CMD_41_DEPTH (1)
+#define NBL_DPED_L4_CK_CMD_41_WIDTH (32)
+#define NBL_DPED_L4_CK_CMD_41_DWLEN (1)
+union dped_l4_ck_cmd_41_u {
+	struct dped_l4_ck_cmd_41 {
+		u32 ck_start0:6;         /* [5:0] Default:0x0 RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x0 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x0 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x0 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x0 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x0 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_CK_CMD_41_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_CK_CMD_50_ADDR  (0x75c340)
+#define NBL_DPED_L4_CK_CMD_50_DEPTH (1)
+#define NBL_DPED_L4_CK_CMD_50_WIDTH (32)
+#define NBL_DPED_L4_CK_CMD_50_DWLEN (1)
+union dped_l4_ck_cmd_50_u {
+	struct dped_l4_ck_cmd_50 {
+		u32 value:8;             /* [7:0] Default:0x0 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x2 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x2 RW */
+		u32 len_vld:1;           /* [17] Default:0x0 RW */
+		u32 data_vld:1;          /* [18] Default:0x1 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x2 RW */
+		u32 phid:2;              /* [27:26] Default:0x3 RW */
+		u32 flag:1;              /* [28] Default:0x0 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_CK_CMD_50_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_CK_CMD_51_ADDR  (0x75c344)
+#define NBL_DPED_L4_CK_CMD_51_DEPTH (1)
+#define NBL_DPED_L4_CK_CMD_51_WIDTH (32)
+#define NBL_DPED_L4_CK_CMD_51_DWLEN (1)
+union dped_l4_ck_cmd_51_u {
+	struct dped_l4_ck_cmd_51 {
+		u32 ck_start0:6;         /* [5:0] Default:0xc RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x8 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x0 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x3 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x0 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_CK_CMD_51_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_CK_CMD_60_ADDR  (0x75c348)
+#define NBL_DPED_L4_CK_CMD_60_DEPTH (1)
+#define NBL_DPED_L4_CK_CMD_60_WIDTH (32)
+#define NBL_DPED_L4_CK_CMD_60_DWLEN (1)
+union dped_l4_ck_cmd_60_u {
+	struct dped_l4_ck_cmd_60 {
+		u32 value:8;             /* [7:0] Default:0x62 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x4 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x2 RW */
+		u32 len_vld:1;           /* [17] Default:0x1 RW */
+		u32 data_vld:1;          /* [18] Default:0x1 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x2 RW */
+		u32 phid:2;              /* [27:26] Default:0x3 RW */
+		u32 flag:1;              /* [28] Default:0x0 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_CK_CMD_60_DWLEN];
+} __packed;
+
+#define NBL_DPED_L4_CK_CMD_61_ADDR  (0x75c34c)
+#define NBL_DPED_L4_CK_CMD_61_DEPTH (1)
+#define NBL_DPED_L4_CK_CMD_61_WIDTH (32)
+#define NBL_DPED_L4_CK_CMD_61_DWLEN (1)
+union dped_l4_ck_cmd_61_u {
+	struct dped_l4_ck_cmd_61 {
+		u32 ck_start0:6;         /* [5:0] Default:0x0 RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x0 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x0 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x0 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x0 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x0 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DPED_L4_CK_CMD_61_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L3_CK_CMD_00_ADDR  (0x75c350)
+#define NBL_DPED_TNL_L3_CK_CMD_00_DEPTH (1)
+#define NBL_DPED_TNL_L3_CK_CMD_00_WIDTH (32)
+#define NBL_DPED_TNL_L3_CK_CMD_00_DWLEN (1)
+union dped_tnl_l3_ck_cmd_00_u {
+	struct dped_tnl_l3_ck_cmd_00 {
+		u32 value:8;             /* [7:0] Default:0x0 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x0 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x0 RW */
+		u32 len_vld:1;           /* [17] Default:0x0 RW */
+		u32 data_vld:1;          /* [18] Default:0x0 RW */
+		u32 in_oft:7;            /* [25:19] Default:0xa RW */
+		u32 phid:2;              /* [27:26] Default:0x2 RW */
+		u32 flag:1;              /* [28] Default:0x0 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L3_CK_CMD_00_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L3_CK_CMD_01_ADDR  (0x75c354)
+#define NBL_DPED_TNL_L3_CK_CMD_01_DEPTH (1)
+#define NBL_DPED_TNL_L3_CK_CMD_01_WIDTH (32)
+#define NBL_DPED_TNL_L3_CK_CMD_01_DWLEN (1)
+union dped_tnl_l3_ck_cmd_01_u {
+	struct dped_tnl_l3_ck_cmd_01 {
+		u32 ck_start0:6;         /* [5:0] Default:0x0 RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x0 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x0 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x0 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L3_CK_CMD_01_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L4_CK_CMD_00_ADDR  (0x75c360)
+#define NBL_DPED_TNL_L4_CK_CMD_00_DEPTH (1)
+#define NBL_DPED_TNL_L4_CK_CMD_00_WIDTH (32)
+#define NBL_DPED_TNL_L4_CK_CMD_00_DWLEN (1)
+union dped_tnl_l4_ck_cmd_00_u {
+	struct dped_tnl_l4_ck_cmd_00 {
+		u32 value:8;             /* [7:0] Default:0x11 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x2 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x2 RW */
+		u32 len_vld:1;           /* [17] Default:0x1 RW */
+		u32 data_vld:1;          /* [18] Default:0x1 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x6 RW */
+		u32 phid:2;              /* [27:26] Default:0x3 RW */
+		u32 flag:1;              /* [28] Default:0x1 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L4_CK_CMD_00_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L4_CK_CMD_01_ADDR  (0x75c364)
+#define NBL_DPED_TNL_L4_CK_CMD_01_DEPTH (1)
+#define NBL_DPED_TNL_L4_CK_CMD_01_WIDTH (32)
+#define NBL_DPED_TNL_L4_CK_CMD_01_DWLEN (1)
+union dped_tnl_l4_ck_cmd_01_u {
+	struct dped_tnl_l4_ck_cmd_01 {
+		u32 ck_start0:6;         /* [5:0] Default:0xc RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x8 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x3 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x0 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L4_CK_CMD_01_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L4_CK_CMD_10_ADDR  (0x75c368)
+#define NBL_DPED_TNL_L4_CK_CMD_10_DEPTH (1)
+#define NBL_DPED_TNL_L4_CK_CMD_10_WIDTH (32)
+#define NBL_DPED_TNL_L4_CK_CMD_10_DWLEN (1)
+union dped_tnl_l4_ck_cmd_10_u {
+	struct dped_tnl_l4_ck_cmd_10 {
+		u32 value:8;             /* [7:0] Default:0x39 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x4 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x2 RW */
+		u32 len_vld:1;           /* [17] Default:0x1 RW */
+		u32 data_vld:1;          /* [18] Default:0x1 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x6 RW */
+		u32 phid:2;              /* [27:26] Default:0x3 RW */
+		u32 flag:1;              /* [28] Default:0x1 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L4_CK_CMD_10_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L4_CK_CMD_11_ADDR  (0x75c36c)
+#define NBL_DPED_TNL_L4_CK_CMD_11_DEPTH (1)
+#define NBL_DPED_TNL_L4_CK_CMD_11_WIDTH (32)
+#define NBL_DPED_TNL_L4_CK_CMD_11_DWLEN (1)
+union dped_tnl_l4_ck_cmd_11_u {
+	struct dped_tnl_l4_ck_cmd_11 {
+		u32 ck_start0:6;         /* [5:0] Default:0x8 RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x20 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x3 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x0 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L4_CK_CMD_11_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L4_CK_CMD_20_ADDR  (0x75c370)
+#define NBL_DPED_TNL_L4_CK_CMD_20_DEPTH (1)
+#define NBL_DPED_TNL_L4_CK_CMD_20_WIDTH (32)
+#define NBL_DPED_TNL_L4_CK_CMD_20_DWLEN (1)
+union dped_tnl_l4_ck_cmd_20_u {
+	struct dped_tnl_l4_ck_cmd_20 {
+		u32 value:8;             /* [7:0] Default:0x0 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x0 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x0 RW */
+		u32 len_vld:1;           /* [17] Default:0x0 RW */
+		u32 data_vld:1;          /* [18] Default:0x0 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x0 RW */
+		u32 phid:2;              /* [27:26] Default:0x0 RW */
+		u32 flag:1;              /* [28] Default:0x0 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L4_CK_CMD_20_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L4_CK_CMD_21_ADDR  (0x75c374)
+#define NBL_DPED_TNL_L4_CK_CMD_21_DEPTH (1)
+#define NBL_DPED_TNL_L4_CK_CMD_21_WIDTH (32)
+#define NBL_DPED_TNL_L4_CK_CMD_21_DWLEN (1)
+union dped_tnl_l4_ck_cmd_21_u {
+	struct dped_tnl_l4_ck_cmd_21 {
+		u32 ck_start0:6;         /* [5:0] Default:0x8 RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x20 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x3 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x14 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L4_CK_CMD_21_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L4_CK_CMD_30_ADDR  (0x75c378)
+#define NBL_DPED_TNL_L4_CK_CMD_30_DEPTH (1)
+#define NBL_DPED_TNL_L4_CK_CMD_30_WIDTH (32)
+#define NBL_DPED_TNL_L4_CK_CMD_30_DWLEN (1)
+union dped_tnl_l4_ck_cmd_30_u {
+	struct dped_tnl_l4_ck_cmd_30 {
+		u32 value:8;             /* [7:0] Default:0x0 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x0 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x0 RW */
+		u32 len_vld:1;           /* [17] Default:0x0 RW */
+		u32 data_vld:1;          /* [18] Default:0x0 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x0 RW */
+		u32 phid:2;              /* [27:26] Default:0x0 RW */
+		u32 flag:1;              /* [28] Default:0x0 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L4_CK_CMD_30_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L4_CK_CMD_31_ADDR  (0x75c37c)
+#define NBL_DPED_TNL_L4_CK_CMD_31_DEPTH (1)
+#define NBL_DPED_TNL_L4_CK_CMD_31_WIDTH (32)
+#define NBL_DPED_TNL_L4_CK_CMD_31_DWLEN (1)
+union dped_tnl_l4_ck_cmd_31_u {
+	struct dped_tnl_l4_ck_cmd_31 {
+		u32 ck_start0:6;         /* [5:0] Default:0x8 RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x20 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x3 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x8 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L4_CK_CMD_31_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L4_CK_CMD_40_ADDR  (0x75c380)
+#define NBL_DPED_TNL_L4_CK_CMD_40_DEPTH (1)
+#define NBL_DPED_TNL_L4_CK_CMD_40_WIDTH (32)
+#define NBL_DPED_TNL_L4_CK_CMD_40_DWLEN (1)
+union dped_tnl_l4_ck_cmd_40_u {
+	struct dped_tnl_l4_ck_cmd_40 {
+		u32 value:8;             /* [7:0] Default:0x0 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x0 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x0 RW */
+		u32 len_vld:1;           /* [17] Default:0x0 RW */
+		u32 data_vld:1;          /* [18] Default:0x0 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x0 RW */
+		u32 phid:2;              /* [27:26] Default:0x0 RW */
+		u32 flag:1;              /* [28] Default:0x0 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L4_CK_CMD_40_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L4_CK_CMD_41_ADDR  (0x75c384)
+#define NBL_DPED_TNL_L4_CK_CMD_41_DEPTH (1)
+#define NBL_DPED_TNL_L4_CK_CMD_41_WIDTH (32)
+#define NBL_DPED_TNL_L4_CK_CMD_41_DWLEN (1)
+union dped_tnl_l4_ck_cmd_41_u {
+	struct dped_tnl_l4_ck_cmd_41 {
+		u32 ck_start0:6;         /* [5:0] Default:0x8 RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x20 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x3 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x8 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L4_CK_CMD_41_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L4_CK_CMD_50_ADDR  (0x75c388)
+#define NBL_DPED_TNL_L4_CK_CMD_50_DEPTH (1)
+#define NBL_DPED_TNL_L4_CK_CMD_50_WIDTH (32)
+#define NBL_DPED_TNL_L4_CK_CMD_50_DWLEN (1)
+union dped_tnl_l4_ck_cmd_50_u {
+	struct dped_tnl_l4_ck_cmd_50 {
+		u32 value:8;             /* [7:0] Default:0x0 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x0 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x0 RW */
+		u32 len_vld:1;           /* [17] Default:0x0 RW */
+		u32 data_vld:1;          /* [18] Default:0x0 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x0 RW */
+		u32 phid:2;              /* [27:26] Default:0x0 RW */
+		u32 flag:1;              /* [28] Default:0x0 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L4_CK_CMD_50_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L4_CK_CMD_51_ADDR  (0x75c38c)
+#define NBL_DPED_TNL_L4_CK_CMD_51_DEPTH (1)
+#define NBL_DPED_TNL_L4_CK_CMD_51_WIDTH (32)
+#define NBL_DPED_TNL_L4_CK_CMD_51_DWLEN (1)
+union dped_tnl_l4_ck_cmd_51_u {
+	struct dped_tnl_l4_ck_cmd_51 {
+		u32 ck_start0:6;         /* [5:0] Default:0x8 RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x20 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x3 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x8 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L4_CK_CMD_51_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L4_CK_CMD_60_ADDR  (0x75c390)
+#define NBL_DPED_TNL_L4_CK_CMD_60_DEPTH (1)
+#define NBL_DPED_TNL_L4_CK_CMD_60_WIDTH (32)
+#define NBL_DPED_TNL_L4_CK_CMD_60_DWLEN (1)
+union dped_tnl_l4_ck_cmd_60_u {
+	struct dped_tnl_l4_ck_cmd_60 {
+		u32 value:8;             /* [7:0] Default:0x0 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x0 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x0 RW */
+		u32 len_vld:1;           /* [17] Default:0x0 RW */
+		u32 data_vld:1;          /* [18] Default:0x0 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x0 RW */
+		u32 phid:2;              /* [27:26] Default:0x0 RW */
+		u32 flag:1;              /* [28] Default:0x0 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L4_CK_CMD_60_DWLEN];
+} __packed;
+
+#define NBL_DPED_TNL_L4_CK_CMD_61_ADDR  (0x75c394)
+#define NBL_DPED_TNL_L4_CK_CMD_61_DEPTH (1)
+#define NBL_DPED_TNL_L4_CK_CMD_61_WIDTH (32)
+#define NBL_DPED_TNL_L4_CK_CMD_61_DWLEN (1)
+union dped_tnl_l4_ck_cmd_61_u {
+	struct dped_tnl_l4_ck_cmd_61 {
+		u32 ck_start0:6;         /* [5:0] Default:0x8 RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x20 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x3 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x8 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TNL_L4_CK_CMD_61_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_00_ADDR  (0x75c3a0)
+#define NBL_DPED_MIR_CMD_00_DEPTH (1)
+#define NBL_DPED_MIR_CMD_00_WIDTH (32)
+#define NBL_DPED_MIR_CMD_00_DWLEN (1)
+union dped_mir_cmd_00_u {
+	struct dped_mir_cmd_00 {
+		u32 len:7;               /* [6:0] Default:0x0 RW */
+		u32 rsv2:1;              /* [7] Default:0x0 RO */
+		u32 oft:7;               /* [14:8] Default:0x0 RW */
+		u32 rsv1:1;              /* [15] Default:0x0 RO */
+		u32 mode:1;              /* [16] Default:0x0 RW */
+		u32 en:1;                /* [17] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_00_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_01_ADDR  (0x75c3a4)
+#define NBL_DPED_MIR_CMD_01_DEPTH (1)
+#define NBL_DPED_MIR_CMD_01_WIDTH (32)
+#define NBL_DPED_MIR_CMD_01_DWLEN (1)
+union dped_mir_cmd_01_u {
+	struct dped_mir_cmd_01 {
+		u32 vau:16;              /* [15:0] Default:0x0 RW */
+		u32 type_sel:2;          /* [17:16] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_01_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_10_ADDR  (0x75c3a8)
+#define NBL_DPED_MIR_CMD_10_DEPTH (1)
+#define NBL_DPED_MIR_CMD_10_WIDTH (32)
+#define NBL_DPED_MIR_CMD_10_DWLEN (1)
+union dped_mir_cmd_10_u {
+	struct dped_mir_cmd_10 {
+		u32 len:7;               /* [6:0] Default:0x0 RW */
+		u32 rsv2:1;              /* [7] Default:0x0 RO */
+		u32 oft:7;               /* [14:8] Default:0x0 RW */
+		u32 rsv1:1;              /* [15] Default:0x0 RO */
+		u32 mode:1;              /* [16] Default:0x0 RW */
+		u32 en:1;                /* [17] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_10_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_11_ADDR  (0x75c3ac)
+#define NBL_DPED_MIR_CMD_11_DEPTH (1)
+#define NBL_DPED_MIR_CMD_11_WIDTH (32)
+#define NBL_DPED_MIR_CMD_11_DWLEN (1)
+union dped_mir_cmd_11_u {
+	struct dped_mir_cmd_11 {
+		u32 vau:16;              /* [15:0] Default:0x0 RW */
+		u32 type_sel:2;          /* [17:16] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_11_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_20_ADDR  (0x75c3b0)
+#define NBL_DPED_MIR_CMD_20_DEPTH (1)
+#define NBL_DPED_MIR_CMD_20_WIDTH (32)
+#define NBL_DPED_MIR_CMD_20_DWLEN (1)
+union dped_mir_cmd_20_u {
+	struct dped_mir_cmd_20 {
+		u32 len:7;               /* [6:0] Default:0x0 RW */
+		u32 rsv2:1;              /* [7] Default:0x0 RO */
+		u32 oft:7;               /* [14:8] Default:0x0 RW */
+		u32 rsv1:1;              /* [15] Default:0x0 RO */
+		u32 mode:1;              /* [16] Default:0x0 RW */
+		u32 en:1;                /* [17] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_20_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_21_ADDR  (0x75c3b4)
+#define NBL_DPED_MIR_CMD_21_DEPTH (1)
+#define NBL_DPED_MIR_CMD_21_WIDTH (32)
+#define NBL_DPED_MIR_CMD_21_DWLEN (1)
+union dped_mir_cmd_21_u {
+	struct dped_mir_cmd_21 {
+		u32 vau:16;              /* [15:0] Default:0x0 RW */
+		u32 type_sel:2;          /* [17:16] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_21_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_30_ADDR  (0x75c3b8)
+#define NBL_DPED_MIR_CMD_30_DEPTH (1)
+#define NBL_DPED_MIR_CMD_30_WIDTH (32)
+#define NBL_DPED_MIR_CMD_30_DWLEN (1)
+union dped_mir_cmd_30_u {
+	struct dped_mir_cmd_30 {
+		u32 len:7;               /* [6:0] Default:0x0 RW */
+		u32 rsv2:1;              /* [7] Default:0x0 RO */
+		u32 oft:7;               /* [14:8] Default:0x0 RW */
+		u32 rsv1:1;              /* [15] Default:0x0 RO */
+		u32 mode:1;              /* [16] Default:0x0 RW */
+		u32 en:1;                /* [17] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_30_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_31_ADDR  (0x75c3bc)
+#define NBL_DPED_MIR_CMD_31_DEPTH (1)
+#define NBL_DPED_MIR_CMD_31_WIDTH (32)
+#define NBL_DPED_MIR_CMD_31_DWLEN (1)
+union dped_mir_cmd_31_u {
+	struct dped_mir_cmd_31 {
+		u32 vau:16;              /* [15:0] Default:0x0 RW */
+		u32 type_sel:2;          /* [17:16] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_31_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_40_ADDR  (0x75c3c0)
+#define NBL_DPED_MIR_CMD_40_DEPTH (1)
+#define NBL_DPED_MIR_CMD_40_WIDTH (32)
+#define NBL_DPED_MIR_CMD_40_DWLEN (1)
+union dped_mir_cmd_40_u {
+	struct dped_mir_cmd_40 {
+		u32 len:7;               /* [6:0] Default:0x0 RW */
+		u32 rsv2:1;              /* [7] Default:0x0 RO */
+		u32 oft:7;               /* [14:8] Default:0x0 RW */
+		u32 rsv1:1;              /* [15] Default:0x0 RO */
+		u32 mode:1;              /* [16] Default:0x0 RW */
+		u32 en:1;                /* [17] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_40_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_41_ADDR  (0x75c3c4)
+#define NBL_DPED_MIR_CMD_41_DEPTH (1)
+#define NBL_DPED_MIR_CMD_41_WIDTH (32)
+#define NBL_DPED_MIR_CMD_41_DWLEN (1)
+union dped_mir_cmd_41_u {
+	struct dped_mir_cmd_41 {
+		u32 vau:16;              /* [15:0] Default:0x0 RW */
+		u32 type_sel:2;          /* [17:16] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_41_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_50_ADDR  (0x75c3c8)
+#define NBL_DPED_MIR_CMD_50_DEPTH (1)
+#define NBL_DPED_MIR_CMD_50_WIDTH (32)
+#define NBL_DPED_MIR_CMD_50_DWLEN (1)
+union dped_mir_cmd_50_u {
+	struct dped_mir_cmd_50 {
+		u32 len:7;               /* [6:0] Default:0x0 RW */
+		u32 rsv2:1;              /* [7] Default:0x0 RO */
+		u32 oft:7;               /* [14:8] Default:0x0 RW */
+		u32 rsv1:1;              /* [15] Default:0x0 RO */
+		u32 mode:1;              /* [16] Default:0x0 RW */
+		u32 en:1;                /* [17] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_50_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_51_ADDR  (0x75c3cc)
+#define NBL_DPED_MIR_CMD_51_DEPTH (1)
+#define NBL_DPED_MIR_CMD_51_WIDTH (32)
+#define NBL_DPED_MIR_CMD_51_DWLEN (1)
+union dped_mir_cmd_51_u {
+	struct dped_mir_cmd_51 {
+		u32 vau:16;              /* [15:0] Default:0x0 RW */
+		u32 type_sel:2;          /* [17:16] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_51_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_60_ADDR  (0x75c3d0)
+#define NBL_DPED_MIR_CMD_60_DEPTH (1)
+#define NBL_DPED_MIR_CMD_60_WIDTH (32)
+#define NBL_DPED_MIR_CMD_60_DWLEN (1)
+union dped_mir_cmd_60_u {
+	struct dped_mir_cmd_60 {
+		u32 len:7;               /* [6:0] Default:0x0 RW */
+		u32 rsv2:1;              /* [7] Default:0x0 RO */
+		u32 oft:7;               /* [14:8] Default:0x0 RW */
+		u32 rsv1:1;              /* [15] Default:0x0 RO */
+		u32 mode:1;              /* [16] Default:0x0 RW */
+		u32 en:1;                /* [17] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_60_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_61_ADDR  (0x75c3d4)
+#define NBL_DPED_MIR_CMD_61_DEPTH (1)
+#define NBL_DPED_MIR_CMD_61_WIDTH (32)
+#define NBL_DPED_MIR_CMD_61_DWLEN (1)
+union dped_mir_cmd_61_u {
+	struct dped_mir_cmd_61 {
+		u32 vau:16;              /* [15:0] Default:0x0 RW */
+		u32 type_sel:2;          /* [17:16] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_61_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_70_ADDR  (0x75c3d8)
+#define NBL_DPED_MIR_CMD_70_DEPTH (1)
+#define NBL_DPED_MIR_CMD_70_WIDTH (32)
+#define NBL_DPED_MIR_CMD_70_DWLEN (1)
+union dped_mir_cmd_70_u {
+	struct dped_mir_cmd_70 {
+		u32 len:7;               /* [6:0] Default:0x0 RW */
+		u32 rsv2:1;              /* [7] Default:0x0 RO */
+		u32 oft:7;               /* [14:8] Default:0x0 RW */
+		u32 rsv1:1;              /* [15] Default:0x0 RO */
+		u32 mode:1;              /* [16] Default:0x0 RW */
+		u32 en:1;                /* [17] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_70_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIR_CMD_71_ADDR  (0x75c3dc)
+#define NBL_DPED_MIR_CMD_71_DEPTH (1)
+#define NBL_DPED_MIR_CMD_71_WIDTH (32)
+#define NBL_DPED_MIR_CMD_71_DWLEN (1)
+union dped_mir_cmd_71_u {
+	struct dped_mir_cmd_71 {
+		u32 vau:16;              /* [15:0] Default:0x0 RW */
+		u32 type_sel:2;          /* [17:16] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIR_CMD_71_DWLEN];
+} __packed;
+
+#define NBL_DPED_DSCP_CK_EN_ADDR  (0x75c3e8)
+#define NBL_DPED_DSCP_CK_EN_DEPTH (1)
+#define NBL_DPED_DSCP_CK_EN_WIDTH (32)
+#define NBL_DPED_DSCP_CK_EN_DWLEN (1)
+union dped_dscp_ck_en_u {
+	struct dped_dscp_ck_en {
+		u32 l4_en:1;             /* [0] Default:0x0 RW */
+		u32 l3_en:1;             /* [1] Default:0x1 RW */
+		u32 rsv:30;              /* [31:2] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_DSCP_CK_EN_DWLEN];
+} __packed;
+
+#define NBL_DPED_RDMA_ECN_REMARK_ADDR  (0x75c3f0)
+#define NBL_DPED_RDMA_ECN_REMARK_DEPTH (1)
+#define NBL_DPED_RDMA_ECN_REMARK_WIDTH (32)
+#define NBL_DPED_RDMA_ECN_REMARK_DWLEN (1)
+union dped_rdma_ecn_remark_u {
+	struct dped_rdma_ecn_remark {
+		u32 vau:2;               /* [1:0] Default:0x1 RW */
+		u32 rsv1:2;              /* [3:2] Default:0x0 RO */
+		u32 en:1;                /* [4] Default:0x0 RW */
+		u32 rsv:27;              /* [31:5] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_RDMA_ECN_REMARK_DWLEN];
+} __packed;
+
+#define NBL_DPED_VLAN_OFFSET_ADDR  (0x75c3f4)
+#define NBL_DPED_VLAN_OFFSET_DEPTH (1)
+#define NBL_DPED_VLAN_OFFSET_WIDTH (32)
+#define NBL_DPED_VLAN_OFFSET_DWLEN (1)
+union dped_vlan_offset_u {
+	struct dped_vlan_offset {
+		u32 oft:8;               /* [7:0] Default:0xC RW */
+		u32 rsv:24;              /* [31:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_VLAN_OFFSET_DWLEN];
+} __packed;
+
+#define NBL_DPED_DSCP_OFFSET_0_ADDR  (0x75c3f8)
+#define NBL_DPED_DSCP_OFFSET_0_DEPTH (1)
+#define NBL_DPED_DSCP_OFFSET_0_WIDTH (32)
+#define NBL_DPED_DSCP_OFFSET_0_DWLEN (1)
+union dped_dscp_offset_0_u {
+	struct dped_dscp_offset_0 {
+		u32 oft:8;               /* [7:0] Default:0x8 RW */
+		u32 rsv:24;              /* [31:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_DSCP_OFFSET_0_DWLEN];
+} __packed;
+
+#define NBL_DPED_DSCP_OFFSET_1_ADDR  (0x75c3fc)
+#define NBL_DPED_DSCP_OFFSET_1_DEPTH (1)
+#define NBL_DPED_DSCP_OFFSET_1_WIDTH (32)
+#define NBL_DPED_DSCP_OFFSET_1_DWLEN (1)
+union dped_dscp_offset_1_u {
+	struct dped_dscp_offset_1 {
+		u32 oft:8;               /* [7:0] Default:0x4 RW */
+		u32 rsv:24;              /* [31:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_DSCP_OFFSET_1_DWLEN];
+} __packed;
+
+#define NBL_DPED_CFG_TEST_ADDR  (0x75c600)
+#define NBL_DPED_CFG_TEST_DEPTH (1)
+#define NBL_DPED_CFG_TEST_WIDTH (32)
+#define NBL_DPED_CFG_TEST_DWLEN (1)
+union dped_cfg_test_u {
+	struct dped_cfg_test {
+		u32 test:32;             /* [31:00] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DPED_CFG_TEST_DWLEN];
+} __packed;
+
+#define NBL_DPED_BP_STATE_ADDR  (0x75c608)
+#define NBL_DPED_BP_STATE_DEPTH (1)
+#define NBL_DPED_BP_STATE_WIDTH (32)
+#define NBL_DPED_BP_STATE_DWLEN (1)
+union dped_bp_state_u {
+	struct dped_bp_state {
+		u32 bm_rtn_tout:1;       /* [0] Default:0x0 RO */
+		u32 bm_not_rdy:1;        /* [1] Default:0x0 RO */
+		u32 dprbac_fc:1;         /* [2] Default:0x0 RO */
+		u32 qm_fc:1;             /* [3] Default:0x0 RO */
+		u32 rsv:28;              /* [31:04] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_BP_STATE_DWLEN];
+} __packed;
+
+#define NBL_DPED_BP_HISTORY_ADDR  (0x75c60c)
+#define NBL_DPED_BP_HISTORY_DEPTH (1)
+#define NBL_DPED_BP_HISTORY_WIDTH (32)
+#define NBL_DPED_BP_HISTORY_DWLEN (1)
+union dped_bp_history_u {
+	struct dped_bp_history {
+		u32 bm_rtn_tout:1;       /* [0] Default:0x0 RC */
+		u32 bm_not_rdy:1;        /* [1] Default:0x0 RC */
+		u32 dprbac_fc:1;         /* [2] Default:0x0 RC */
+		u32 qm_fc:1;             /* [3] Default:0x0 RC */
+		u32 rsv:28;              /* [31:04] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_BP_HISTORY_DWLEN];
+} __packed;
+
+#define NBL_DPED_MIRID_IND_ADDR  (0x75c900)
+#define NBL_DPED_MIRID_IND_DEPTH (1)
+#define NBL_DPED_MIRID_IND_WIDTH (32)
+#define NBL_DPED_MIRID_IND_DWLEN (1)
+union dped_mirid_ind_u {
+	struct dped_mirid_ind {
+		u32 nomat:1;             /* [0] Default:0x0 RC */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MIRID_IND_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_AUX_OFT_ADDR  (0x75c904)
+#define NBL_DPED_MD_AUX_OFT_DEPTH (1)
+#define NBL_DPED_MD_AUX_OFT_WIDTH (32)
+#define NBL_DPED_MD_AUX_OFT_DWLEN (1)
+union dped_md_aux_oft_u {
+	struct dped_md_aux_oft {
+		u32 l2_oft:8;            /* [7:0] Default:0x0 RO */
+		u32 l3_oft:8;            /* [15:8] Default:0x0 RO */
+		u32 l4_oft:8;            /* [23:16] Default:0x0 RO */
+		u32 pld_oft:8;           /* [31:24] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_AUX_OFT_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_AUX_PKT_LEN_ADDR  (0x75c908)
+#define NBL_DPED_MD_AUX_PKT_LEN_DEPTH (1)
+#define NBL_DPED_MD_AUX_PKT_LEN_WIDTH (32)
+#define NBL_DPED_MD_AUX_PKT_LEN_DWLEN (1)
+union dped_md_aux_pkt_len_u {
+	struct dped_md_aux_pkt_len {
+		u32 len:14;              /* [13:0] Default:0x0 RO */
+		u32 rsv:18;              /* [31:14] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_AUX_PKT_LEN_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_FWD_MIR_ADDR  (0x75c90c)
+#define NBL_DPED_MD_FWD_MIR_DEPTH (1)
+#define NBL_DPED_MD_FWD_MIR_WIDTH (32)
+#define NBL_DPED_MD_FWD_MIR_DWLEN (1)
+union dped_md_fwd_mir_u {
+	struct dped_md_fwd_mir {
+		u32 id:4;                /* [3:0] Default:0x0 RO */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_FWD_MIR_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_FWD_DPORT_ADDR  (0x75c910)
+#define NBL_DPED_MD_FWD_DPORT_DEPTH (1)
+#define NBL_DPED_MD_FWD_DPORT_WIDTH (32)
+#define NBL_DPED_MD_FWD_DPORT_DWLEN (1)
+union dped_md_fwd_dport_u {
+	struct dped_md_fwd_dport {
+		u32 id:16;               /* [15:0] Default:0x0 RO */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_FWD_DPORT_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_AUX_PLD_CKSUM_ADDR  (0x75c914)
+#define NBL_DPED_MD_AUX_PLD_CKSUM_DEPTH (1)
+#define NBL_DPED_MD_AUX_PLD_CKSUM_WIDTH (32)
+#define NBL_DPED_MD_AUX_PLD_CKSUM_DWLEN (1)
+union dped_md_aux_pld_cksum_u {
+	struct dped_md_aux_pld_cksum {
+		u32 ck:32;               /* [31:0] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_AUX_PLD_CKSUM_DWLEN];
+} __packed;
+
+#define NBL_DPED_INNER_PKT_CKSUM_ADDR  (0x75c918)
+#define NBL_DPED_INNER_PKT_CKSUM_DEPTH (1)
+#define NBL_DPED_INNER_PKT_CKSUM_WIDTH (32)
+#define NBL_DPED_INNER_PKT_CKSUM_DWLEN (1)
+union dped_inner_pkt_cksum_u {
+	struct dped_inner_pkt_cksum {
+		u32 ck:16;               /* [15:0] Default:0x0 RO */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_INNER_PKT_CKSUM_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_EDIT_0_ADDR  (0x75c920)
+#define NBL_DPED_MD_EDIT_0_DEPTH (1)
+#define NBL_DPED_MD_EDIT_0_WIDTH (32)
+#define NBL_DPED_MD_EDIT_0_DWLEN (1)
+union dped_md_edit_0_u {
+	struct dped_md_edit_0 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_EDIT_0_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_EDIT_1_ADDR  (0x75c924)
+#define NBL_DPED_MD_EDIT_1_DEPTH (1)
+#define NBL_DPED_MD_EDIT_1_WIDTH (32)
+#define NBL_DPED_MD_EDIT_1_DWLEN (1)
+union dped_md_edit_1_u {
+	struct dped_md_edit_1 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_EDIT_1_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_EDIT_2_ADDR  (0x75c928)
+#define NBL_DPED_MD_EDIT_2_DEPTH (1)
+#define NBL_DPED_MD_EDIT_2_WIDTH (32)
+#define NBL_DPED_MD_EDIT_2_DWLEN (1)
+union dped_md_edit_2_u {
+	struct dped_md_edit_2 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_EDIT_2_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_EDIT_3_ADDR  (0x75c92c)
+#define NBL_DPED_MD_EDIT_3_DEPTH (1)
+#define NBL_DPED_MD_EDIT_3_WIDTH (32)
+#define NBL_DPED_MD_EDIT_3_DWLEN (1)
+union dped_md_edit_3_u {
+	struct dped_md_edit_3 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_EDIT_3_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_EDIT_4_ADDR  (0x75c930)
+#define NBL_DPED_MD_EDIT_4_DEPTH (1)
+#define NBL_DPED_MD_EDIT_4_WIDTH (32)
+#define NBL_DPED_MD_EDIT_4_DWLEN (1)
+union dped_md_edit_4_u {
+	struct dped_md_edit_4 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_EDIT_4_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_EDIT_5_ADDR  (0x75c934)
+#define NBL_DPED_MD_EDIT_5_DEPTH (1)
+#define NBL_DPED_MD_EDIT_5_WIDTH (32)
+#define NBL_DPED_MD_EDIT_5_DWLEN (1)
+union dped_md_edit_5_u {
+	struct dped_md_edit_5 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_EDIT_5_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_EDIT_6_ADDR  (0x75c938)
+#define NBL_DPED_MD_EDIT_6_DEPTH (1)
+#define NBL_DPED_MD_EDIT_6_WIDTH (32)
+#define NBL_DPED_MD_EDIT_6_DWLEN (1)
+union dped_md_edit_6_u {
+	struct dped_md_edit_6 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_EDIT_6_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_EDIT_7_ADDR  (0x75c93c)
+#define NBL_DPED_MD_EDIT_7_DEPTH (1)
+#define NBL_DPED_MD_EDIT_7_WIDTH (32)
+#define NBL_DPED_MD_EDIT_7_DWLEN (1)
+union dped_md_edit_7_u {
+	struct dped_md_edit_7 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_EDIT_7_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_EDIT_8_ADDR  (0x75c940)
+#define NBL_DPED_MD_EDIT_8_DEPTH (1)
+#define NBL_DPED_MD_EDIT_8_WIDTH (32)
+#define NBL_DPED_MD_EDIT_8_DWLEN (1)
+union dped_md_edit_8_u {
+	struct dped_md_edit_8 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_EDIT_8_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_EDIT_9_ADDR  (0x75c944)
+#define NBL_DPED_MD_EDIT_9_DEPTH (1)
+#define NBL_DPED_MD_EDIT_9_WIDTH (32)
+#define NBL_DPED_MD_EDIT_9_DWLEN (1)
+union dped_md_edit_9_u {
+	struct dped_md_edit_9 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_EDIT_9_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_EDIT_10_ADDR  (0x75c948)
+#define NBL_DPED_MD_EDIT_10_DEPTH (1)
+#define NBL_DPED_MD_EDIT_10_WIDTH (32)
+#define NBL_DPED_MD_EDIT_10_DWLEN (1)
+union dped_md_edit_10_u {
+	struct dped_md_edit_10 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_EDIT_10_DWLEN];
+} __packed;
+
+#define NBL_DPED_MD_EDIT_11_ADDR  (0x75c94c)
+#define NBL_DPED_MD_EDIT_11_DEPTH (1)
+#define NBL_DPED_MD_EDIT_11_WIDTH (32)
+#define NBL_DPED_MD_EDIT_11_DWLEN (1)
+union dped_md_edit_11_u {
+	struct dped_md_edit_11 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_MD_EDIT_11_DWLEN];
+} __packed;
+
+#define NBL_DPED_ADD_DEL_LEN_ADDR  (0x75c950)
+#define NBL_DPED_ADD_DEL_LEN_DEPTH (1)
+#define NBL_DPED_ADD_DEL_LEN_WIDTH (32)
+#define NBL_DPED_ADD_DEL_LEN_DWLEN (1)
+union dped_add_del_len_u {
+	struct dped_add_del_len {
+		u32 len:9;               /* [8:0] Default:0x0 RO */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_ADD_DEL_LEN_DWLEN];
+} __packed;
+
+#define NBL_DPED_TTL_INFO_ADDR  (0x75c970)
+#define NBL_DPED_TTL_INFO_DEPTH (1)
+#define NBL_DPED_TTL_INFO_WIDTH (32)
+#define NBL_DPED_TTL_INFO_DWLEN (1)
+union dped_ttl_info_u {
+	struct dped_ttl_info {
+		u32 old_ttl:8;           /* [7:0] Default:0x0 RO */
+		u32 new_ttl:8;           /* [15:8] Default:0x0 RO */
+		u32 ttl_val:1;           /* [16] Default:0x0 RC */
+		u32 rsv:15;              /* [31:17] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_TTL_INFO_DWLEN];
+} __packed;
+
+#define NBL_DPED_LEN_INFO_VLD_ADDR  (0x75c974)
+#define NBL_DPED_LEN_INFO_VLD_DEPTH (1)
+#define NBL_DPED_LEN_INFO_VLD_WIDTH (32)
+#define NBL_DPED_LEN_INFO_VLD_DWLEN (1)
+union dped_len_info_vld_u {
+	struct dped_len_info_vld {
+		u32 length0:1;           /* [0] Default:0x0 RC */
+		u32 length1:1;           /* [1] Default:0x0 RC */
+		u32 rsv:30;              /* [31:2] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_LEN_INFO_VLD_DWLEN];
+} __packed;
+
+#define NBL_DPED_LEN0_INFO_ADDR  (0x75c978)
+#define NBL_DPED_LEN0_INFO_DEPTH (1)
+#define NBL_DPED_LEN0_INFO_WIDTH (32)
+#define NBL_DPED_LEN0_INFO_DWLEN (1)
+union dped_len0_info_u {
+	struct dped_len0_info {
+		u32 old_len:16;          /* [15:0] Default:0x0 RO */
+		u32 new_len:16;          /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_LEN0_INFO_DWLEN];
+} __packed;
+
+#define NBL_DPED_LEN1_INFO_ADDR  (0x75c97c)
+#define NBL_DPED_LEN1_INFO_DEPTH (1)
+#define NBL_DPED_LEN1_INFO_WIDTH (32)
+#define NBL_DPED_LEN1_INFO_DWLEN (1)
+union dped_len1_info_u {
+	struct dped_len1_info {
+		u32 old_len:16;          /* [15:0] Default:0x0 RO */
+		u32 new_len:16;          /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_LEN1_INFO_DWLEN];
+} __packed;
+
+#define NBL_DPED_EDIT_ATNUM_INFO_ADDR  (0x75c980)
+#define NBL_DPED_EDIT_ATNUM_INFO_DEPTH (1)
+#define NBL_DPED_EDIT_ATNUM_INFO_WIDTH (32)
+#define NBL_DPED_EDIT_ATNUM_INFO_DWLEN (1)
+union dped_edit_atnum_info_u {
+	struct dped_edit_atnum_info {
+		u32 replace:4;           /* [3:0] Default:0x0 RO */
+		u32 del:4;               /* [7:4] Default:0x0 RO */
+		u32 add:4;               /* [11:8] Default:0x0 RO */
+		u32 ttl:4;               /* [15:12] Default:0x0 RO */
+		u32 dscp:4;              /* [19:16] Default:0x0 RO */
+		u32 tnl:4;               /* [23:20] Default:0x0 RO */
+		u32 sport:4;             /* [27:24] Default:0x0 RO */
+		u32 rsv:4;               /* [31:28] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_EDIT_ATNUM_INFO_DWLEN];
+} __packed;
+
+#define NBL_DPED_EDIT_NO_AT_INFO_ADDR  (0x75c984)
+#define NBL_DPED_EDIT_NO_AT_INFO_DEPTH (1)
+#define NBL_DPED_EDIT_NO_AT_INFO_WIDTH (32)
+#define NBL_DPED_EDIT_NO_AT_INFO_DWLEN (1)
+union dped_edit_no_at_info_u {
+	struct dped_edit_no_at_info {
+		u32 l3_len:1;            /* [0] Default:0x0 RC */
+		u32 l4_len:1;            /* [1] Default:0x0 RC */
+		u32 l3_ck:1;             /* [2] Default:0x0 RC */
+		u32 l4_ck:1;             /* [3] Default:0x0 RC */
+		u32 sctp_ck:1;           /* [4] Default:0x0 RC */
+		u32 padding:1;           /* [5] Default:0x0 RC */
+		u32 rsv:26;              /* [31:06] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_EDIT_NO_AT_INFO_DWLEN];
+} __packed;
+
+#define NBL_DPED_HW_EDT_PROF_ADDR  (0x75d000)
+#define NBL_DPED_HW_EDT_PROF_DEPTH (32)
+#define NBL_DPED_HW_EDT_PROF_WIDTH (32)
+#define NBL_DPED_HW_EDT_PROF_DWLEN (1)
+union dped_hw_edt_prof_u {
+	struct dped_hw_edt_prof {
+		u32 l4_len:2;            /* [1:0] Default:0x2 RW */
+		u32 l3_len:2;            /* [3:2] Default:0x2 RW */
+		u32 l4_ck:3;             /* [6:4] Default:0x7 RW */
+		u32 l3_ck:1;             /* [7:7] Default:0x0 RW */
+		u32 l4_ck_zero_free:1;   /* [8:8] Default:0x1 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_HW_EDT_PROF_DWLEN];
+} __packed;
+#define NBL_DPED_HW_EDT_PROF_REG(r) (NBL_DPED_HW_EDT_PROF_ADDR + \
+		(NBL_DPED_HW_EDT_PROF_DWLEN * 4) * (r))
+
+#define NBL_DPED_OUT_MASK_ADDR  (0x75e000)
+#define NBL_DPED_OUT_MASK_DEPTH (24)
+#define NBL_DPED_OUT_MASK_WIDTH (64)
+#define NBL_DPED_OUT_MASK_DWLEN (2)
+union dped_out_mask_u {
+	struct dped_out_mask {
+		u32 flag:32;             /* [31:0] Default:0x0 RW */
+		u32 fwd:30;              /* [61:32] Default:0x0 RW */
+		u32 rsv:2;               /* [63:62] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_OUT_MASK_DWLEN];
+} __packed;
+#define NBL_DPED_OUT_MASK_REG(r) (NBL_DPED_OUT_MASK_ADDR + \
+		(NBL_DPED_OUT_MASK_DWLEN * 4) * (r))
+
+#define NBL_DPED_TAB_EDIT_CMD_ADDR  (0x75f000)
+#define NBL_DPED_TAB_EDIT_CMD_DEPTH (32)
+#define NBL_DPED_TAB_EDIT_CMD_WIDTH (32)
+#define NBL_DPED_TAB_EDIT_CMD_DWLEN (1)
+union dped_tab_edit_cmd_u {
+	struct dped_tab_edit_cmd {
+		u32 in_offset:8;         /* [7:0] Default:0x0 RW */
+		u32 phid:2;              /* [9:8] Default:0x0 RW */
+		u32 len:7;               /* [16:10] Default:0x0 RW */
+		u32 mode:4;              /* [20:17] Default:0xf RW */
+		u32 l4_ck_ofld_upt:1;    /* [21] Default:0x1 RW */
+		u32 l3_ck_ofld_upt:1;    /* [22] Default:0x1 RW */
+		u32 rsv:9;               /* [31:23] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_TAB_EDIT_CMD_DWLEN];
+} __packed;
+#define NBL_DPED_TAB_EDIT_CMD_REG(r) (NBL_DPED_TAB_EDIT_CMD_ADDR + \
+		(NBL_DPED_TAB_EDIT_CMD_DWLEN * 4) * (r))
+
+#define NBL_DPED_TAB_MIR_ADDR  (0x760000)
+#define NBL_DPED_TAB_MIR_DEPTH (8)
+#define NBL_DPED_TAB_MIR_WIDTH (1024)
+#define NBL_DPED_TAB_MIR_DWLEN (32)
+union dped_tab_mir_u {
+	struct dped_tab_mir {
+		u32 cfg_mir_data:16;     /* [719:0] Default:0x0 RW */
+		u32 cfg_mir_data_arr[22]; /* [719:0] Default:0x0 RW */
+		u32 cfg_mir_info_l:32;   /* [755:720] Default:0x0 RW */
+		u32 cfg_mir_info_h:4;    /* [755:720] Default:0x0 RW */
+		u32 rsv:12;              /* [1023:756] Default:0x0 RO */
+		u32 rsv_arr[8];          /* [1023:756] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_TAB_MIR_DWLEN];
+} __packed;
+#define NBL_DPED_TAB_MIR_REG(r) (NBL_DPED_TAB_MIR_ADDR + \
+		(NBL_DPED_TAB_MIR_DWLEN * 4) * (r))
+
+#define NBL_DPED_TAB_VSI_TYPE_ADDR  (0x761000)
+#define NBL_DPED_TAB_VSI_TYPE_DEPTH (1031)
+#define NBL_DPED_TAB_VSI_TYPE_WIDTH (32)
+#define NBL_DPED_TAB_VSI_TYPE_DWLEN (1)
+union dped_tab_vsi_type_u {
+	struct dped_tab_vsi_type {
+		u32 sel:4;               /* [3:0] Default:0x0 RW */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_TAB_VSI_TYPE_DWLEN];
+} __packed;
+#define NBL_DPED_TAB_VSI_TYPE_REG(r) (NBL_DPED_TAB_VSI_TYPE_ADDR + \
+		(NBL_DPED_TAB_VSI_TYPE_DWLEN * 4) * (r))
+
+#define NBL_DPED_TAB_REPLACE_ADDR  (0x763000)
+#define NBL_DPED_TAB_REPLACE_DEPTH (2048)
+#define NBL_DPED_TAB_REPLACE_WIDTH (64)
+#define NBL_DPED_TAB_REPLACE_DWLEN (2)
+union dped_tab_replace_u {
+	struct dped_tab_replace {
+		u32 vau_arr[2];          /* [63:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DPED_TAB_REPLACE_DWLEN];
+} __packed;
+#define NBL_DPED_TAB_REPLACE_REG(r) (NBL_DPED_TAB_REPLACE_ADDR + \
+		(NBL_DPED_TAB_REPLACE_DWLEN * 4) * (r))
+
+#define NBL_DPED_TAB_TNL_ADDR  (0x7dc000)
+#define NBL_DPED_TAB_TNL_DEPTH (4096)
+#define NBL_DPED_TAB_TNL_WIDTH (1024)
+#define NBL_DPED_TAB_TNL_DWLEN (32)
+union dped_tab_tnl_u {
+	struct dped_tab_tnl {
+		u32 cfg_tnl_data:16;     /* [719:0] Default:0x0 RW */
+		u32 cfg_tnl_data_arr[22]; /* [719:0] Default:0x0 RW */
+		u32 cfg_tnl_info:8;      /* [791:720] Default:0x0 RW */
+		u32 cfg_tnl_info_arr[2]; /* [791:720] Default:0x0 RW */
+		u32 rsv_l:32;            /* [1023:792] Default:0x0 RO */
+		u32 rsv_h:8;             /* [1023:792] Default:0x0 RO */
+		u32 rsv_arr[6];          /* [1023:792] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DPED_TAB_TNL_DWLEN];
+} __packed;
+#define NBL_DPED_TAB_TNL_REG(r) (NBL_DPED_TAB_TNL_ADDR + \
+		(NBL_DPED_TAB_TNL_DWLEN * 4) * (r))
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_dstore.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_dstore.h
new file mode 100644
index 000000000000..7f6f3d8892ac
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_dstore.h
@@ -0,0 +1,957 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+// Code generated by interstellar. DO NOT EDIT.
+// Compatible with leonis RTL tag 0710
+
+#ifndef NBL_DSTORE_H
+#define NBL_DSTORE_H 1
+
+#include <linux/types.h>
+
+#define NBL_DSTORE_BASE (0x00704000)
+
+#define NBL_DSTORE_INT_STATUS_ADDR  (0x704000)
+#define NBL_DSTORE_INT_STATUS_DEPTH (1)
+#define NBL_DSTORE_INT_STATUS_WIDTH (32)
+#define NBL_DSTORE_INT_STATUS_DWLEN (1)
+union dstore_int_status_u {
+	struct dstore_int_status {
+		u32 ucor_err:1;          /* [0] Default:0x0 RWC */
+		u32 cor_err:1;           /* [1] Default:0x0 RWC */
+		u32 fifo_uflw_err:1;     /* [2] Default:0x0 RWC */
+		u32 fifo_dflw_err:1;     /* [3] Default:0x0 RWC */
+		u32 cif_err:1;           /* [4] Default:0x0 RWC */
+		u32 parity_err:1;        /* [5] Default:0x0 RWC */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_INT_STATUS_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_INT_MASK_ADDR  (0x704004)
+#define NBL_DSTORE_INT_MASK_DEPTH (1)
+#define NBL_DSTORE_INT_MASK_WIDTH (32)
+#define NBL_DSTORE_INT_MASK_DWLEN (1)
+union dstore_int_mask_u {
+	struct dstore_int_mask {
+		u32 ucor_err:1;          /* [0] Default:0x0 RW */
+		u32 cor_err:1;           /* [1] Default:0x0 RW */
+		u32 fifo_uflw_err:1;     /* [2] Default:0x0 RW */
+		u32 fifo_dflw_err:1;     /* [3] Default:0x0 RW */
+		u32 cif_err:1;           /* [4] Default:0x0 RW */
+		u32 parity_err:1;        /* [5] Default:0x0 RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_INT_MASK_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_INT_SET_ADDR  (0x704008)
+#define NBL_DSTORE_INT_SET_DEPTH (0)
+#define NBL_DSTORE_INT_SET_WIDTH (32)
+#define NBL_DSTORE_INT_SET_DWLEN (1)
+union dstore_int_set_u {
+	struct dstore_int_set {
+		u32 ucor_err:1;          /* [0] Default:0x0 WO */
+		u32 cor_err:1;           /* [1] Default:0x0 WO */
+		u32 fifo_uflw_err:1;     /* [2] Default:0x0 WO */
+		u32 fifo_dflw_err:1;     /* [3] Default:0x0 WO */
+		u32 cif_err:1;           /* [4] Default:0x0 WO */
+		u32 parity_err:1;        /* [5] Default:0x0 WO */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_INT_SET_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_COR_ERR_INFO_ADDR  (0x70400c)
+#define NBL_DSTORE_COR_ERR_INFO_DEPTH (1)
+#define NBL_DSTORE_COR_ERR_INFO_WIDTH (32)
+#define NBL_DSTORE_COR_ERR_INFO_DWLEN (1)
+union dstore_cor_err_info_u {
+	struct dstore_cor_err_info {
+		u32 ram_addr:10;         /* [9:0] Default:0x0 RO */
+		u32 rsv1:6;              /* [15:10] Default:0x0 RO */
+		u32 ram_id:4;            /* [19:16] Default:0x0 RO */
+		u32 rsv:12;              /* [31:20] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_COR_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_PARITY_ERR_INFO_ADDR  (0x704014)
+#define NBL_DSTORE_PARITY_ERR_INFO_DEPTH (1)
+#define NBL_DSTORE_PARITY_ERR_INFO_WIDTH (32)
+#define NBL_DSTORE_PARITY_ERR_INFO_DWLEN (1)
+union dstore_parity_err_info_u {
+	struct dstore_parity_err_info {
+		u32 ram_addr:10;         /* [9:0] Default:0x0 RO */
+		u32 rsv1:6;              /* [15:10] Default:0x0 RO */
+		u32 ram_id:4;            /* [19:16] Default:0x0 RO */
+		u32 rsv:12;              /* [31:20] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_PARITY_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_CIF_ERR_INFO_ADDR  (0x70401c)
+#define NBL_DSTORE_CIF_ERR_INFO_DEPTH (1)
+#define NBL_DSTORE_CIF_ERR_INFO_WIDTH (32)
+#define NBL_DSTORE_CIF_ERR_INFO_DWLEN (1)
+union dstore_cif_err_info_u {
+	struct dstore_cif_err_info {
+		u32 addr:30;             /* [29:0] Default:0x0 RO */
+		u32 wr_err:1;            /* [30] Default:0x0 RO */
+		u32 ucor_err:1;          /* [31] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_CIF_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_CAR_CTRL_ADDR  (0x704100)
+#define NBL_DSTORE_CAR_CTRL_DEPTH (1)
+#define NBL_DSTORE_CAR_CTRL_WIDTH (32)
+#define NBL_DSTORE_CAR_CTRL_DWLEN (1)
+union dstore_car_ctrl_u {
+	struct dstore_car_ctrl {
+		u32 sctr_car:1;          /* [0] Default:0x1 RW */
+		u32 rctr_car:1;          /* [1] Default:0x1 RW */
+		u32 rc_car:1;            /* [2] Default:0x1 RW */
+		u32 tbl_rc_car:1;        /* [3] Default:0x1 RW */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_CAR_CTRL_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_INIT_START_ADDR  (0x704104)
+#define NBL_DSTORE_INIT_START_DEPTH (1)
+#define NBL_DSTORE_INIT_START_WIDTH (32)
+#define NBL_DSTORE_INIT_START_DWLEN (1)
+union dstore_init_start_u {
+	struct dstore_init_start {
+		u32 init_start:1;        /* [0] Default:0x0 WO */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_INIT_START_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_PKT_LEN_ADDR  (0x704108)
+#define NBL_DSTORE_PKT_LEN_DEPTH (1)
+#define NBL_DSTORE_PKT_LEN_WIDTH (32)
+#define NBL_DSTORE_PKT_LEN_DWLEN (1)
+union dstore_pkt_len_u {
+	struct dstore_pkt_len {
+		u32 min:7;               /* [6:0] Default:60 RW */
+		u32 rsv1:8;              /* [14:7] Default:0x0 RO */
+		u32 min_chk_en:1;        /* [15] Default:0x0 RW */
+		u32 max:14;              /* [29:16] Default:9600 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 max_chk_en:1;        /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DSTORE_PKT_LEN_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_SCH_PD_BUFFER_TH_ADDR  (0x704128)
+#define NBL_DSTORE_SCH_PD_BUFFER_TH_DEPTH (1)
+#define NBL_DSTORE_SCH_PD_BUFFER_TH_WIDTH (32)
+#define NBL_DSTORE_SCH_PD_BUFFER_TH_DWLEN (1)
+union dstore_sch_pd_buffer_th_u {
+	struct dstore_sch_pd_buffer_th {
+		u32 aful_th:9;           /* [8:0] Default:500 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_SCH_PD_BUFFER_TH_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_GLB_FC_TH_ADDR  (0x70412c)
+#define NBL_DSTORE_GLB_FC_TH_DEPTH (1)
+#define NBL_DSTORE_GLB_FC_TH_WIDTH (32)
+#define NBL_DSTORE_GLB_FC_TH_DWLEN (1)
+union dstore_glb_fc_th_u {
+	struct dstore_glb_fc_th {
+		u32 xoff_th:10;          /* [9:0] Default:900 RW */
+		u32 rsv1:6;              /* [15:10] Default:0x0 RO */
+		u32 xon_th:10;           /* [25:16] Default:850 RW */
+		u32 rsv:5;               /* [30:26] Default:0x0 RO */
+		u32 fc_en:1;             /* [31:31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DSTORE_GLB_FC_TH_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_GLB_DROP_TH_ADDR  (0x704130)
+#define NBL_DSTORE_GLB_DROP_TH_DEPTH (1)
+#define NBL_DSTORE_GLB_DROP_TH_WIDTH (32)
+#define NBL_DSTORE_GLB_DROP_TH_DWLEN (1)
+union dstore_glb_drop_th_u {
+	struct dstore_glb_drop_th {
+		u32 disc_th:10;          /* [9:0] Default:985 RW */
+		u32 rsv:21;              /* [30:10] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DSTORE_GLB_DROP_TH_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_PORT_FC_TH_ADDR  (0x704134)
+#define NBL_DSTORE_PORT_FC_TH_DEPTH (6)
+#define NBL_DSTORE_PORT_FC_TH_WIDTH (32)
+#define NBL_DSTORE_PORT_FC_TH_DWLEN (1)
+union dstore_port_fc_th_u {
+	struct dstore_port_fc_th {
+		u32 xoff_th:10;          /* [9:0] Default:400 RW */
+		u32 rsv1:6;              /* [15:10] Default:0x0 RO */
+		u32 xon_th:10;           /* [25:16] Default:400 RW */
+		u32 rsv:4;               /* [29:26] Default:0x0 RO */
+		u32 fc_set:1;            /* [30:30] Default:0x0 RW */
+		u32 fc_en:1;             /* [31:31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DSTORE_PORT_FC_TH_DWLEN];
+} __packed;
+#define NBL_DSTORE_PORT_FC_TH_REG(r) (NBL_DSTORE_PORT_FC_TH_ADDR + \
+		(NBL_DSTORE_PORT_FC_TH_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_PORT_DROP_TH_ADDR  (0x704150)
+#define NBL_DSTORE_PORT_DROP_TH_DEPTH (6)
+#define NBL_DSTORE_PORT_DROP_TH_WIDTH (32)
+#define NBL_DSTORE_PORT_DROP_TH_DWLEN (1)
+union dstore_port_drop_th_u {
+	struct dstore_port_drop_th {
+		u32 disc_th:10;          /* [9:0] Default:800 RW */
+		u32 rsv:21;              /* [30:10] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_DSTORE_PORT_DROP_TH_DWLEN];
+} __packed;
+#define NBL_DSTORE_PORT_DROP_TH_REG(r) (NBL_DSTORE_PORT_DROP_TH_ADDR + \
+		(NBL_DSTORE_PORT_DROP_TH_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_CFG_TEST_ADDR  (0x704170)
+#define NBL_DSTORE_CFG_TEST_DEPTH (1)
+#define NBL_DSTORE_CFG_TEST_WIDTH (32)
+#define NBL_DSTORE_CFG_TEST_DWLEN (1)
+union dstore_cfg_test_u {
+	struct dstore_cfg_test {
+		u32 test:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DSTORE_CFG_TEST_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_HIGH_PRI_PKT_ADDR  (0x70417c)
+#define NBL_DSTORE_HIGH_PRI_PKT_DEPTH (1)
+#define NBL_DSTORE_HIGH_PRI_PKT_WIDTH (32)
+#define NBL_DSTORE_HIGH_PRI_PKT_DWLEN (1)
+union dstore_high_pri_pkt_u {
+	struct dstore_high_pri_pkt {
+		u32 en:1;                /* [0:0] Default:0x0 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_HIGH_PRI_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_COS_FC_TH_ADDR  (0x704200)
+#define NBL_DSTORE_COS_FC_TH_DEPTH (48)
+#define NBL_DSTORE_COS_FC_TH_WIDTH (32)
+#define NBL_DSTORE_COS_FC_TH_DWLEN (1)
+union dstore_cos_fc_th_u {
+	struct dstore_cos_fc_th {
+		u32 xoff_th:10;          /* [9:0] Default:100 RW */
+		u32 rsv1:6;              /* [15:10] Default:0x0 RO */
+		u32 xon_th:10;           /* [25:16] Default:100 RW */
+		u32 rsv:4;               /* [29:26] Default:0x0 RO */
+		u32 fc_set:1;            /* [30:30] Default:0x0 RW */
+		u32 fc_en:1;             /* [31:31] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DSTORE_COS_FC_TH_DWLEN];
+} __packed;
+#define NBL_DSTORE_COS_FC_TH_REG(r) (NBL_DSTORE_COS_FC_TH_ADDR + \
+		(NBL_DSTORE_COS_FC_TH_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_COS_DROP_TH_ADDR  (0x704300)
+#define NBL_DSTORE_COS_DROP_TH_DEPTH (48)
+#define NBL_DSTORE_COS_DROP_TH_WIDTH (32)
+#define NBL_DSTORE_COS_DROP_TH_DWLEN (1)
+union dstore_cos_drop_th_u {
+	struct dstore_cos_drop_th {
+		u32 disc_th:10;          /* [9:0] Default:120 RW */
+		u32 rsv:21;              /* [30:10] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DSTORE_COS_DROP_TH_DWLEN];
+} __packed;
+#define NBL_DSTORE_COS_DROP_TH_REG(r) (NBL_DSTORE_COS_DROP_TH_ADDR + \
+		(NBL_DSTORE_COS_DROP_TH_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_SCH_PD_WRR_WGT_ADDR  (0x704400)
+#define NBL_DSTORE_SCH_PD_WRR_WGT_DEPTH (36)
+#define NBL_DSTORE_SCH_PD_WRR_WGT_WIDTH (32)
+#define NBL_DSTORE_SCH_PD_WRR_WGT_DWLEN (1)
+union dstore_sch_pd_wrr_wgt_u {
+	struct dstore_sch_pd_wrr_wgt {
+		u32 wgt_cos:4;           /* [3:0] Default:0x0 RW */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_SCH_PD_WRR_WGT_DWLEN];
+} __packed;
+#define NBL_DSTORE_SCH_PD_WRR_WGT_REG(r) (NBL_DSTORE_SCH_PD_WRR_WGT_ADDR + \
+		(NBL_DSTORE_SCH_PD_WRR_WGT_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_COS7_FORCE_ADDR  (0x704504)
+#define NBL_DSTORE_COS7_FORCE_DEPTH (1)
+#define NBL_DSTORE_COS7_FORCE_WIDTH (32)
+#define NBL_DSTORE_COS7_FORCE_DWLEN (1)
+union dstore_cos7_force_u {
+	struct dstore_cos7_force {
+		u32 en:1;                /* [0] Default:0x0 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_COS7_FORCE_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_D_DPORT_FC_TH_ADDR  (0x704600)
+#define NBL_DSTORE_D_DPORT_FC_TH_DEPTH (5)
+#define NBL_DSTORE_D_DPORT_FC_TH_WIDTH (32)
+#define NBL_DSTORE_D_DPORT_FC_TH_DWLEN (1)
+union dstore_d_dport_fc_th_u {
+	struct dstore_d_dport_fc_th {
+		u32 xoff_th:11;          /* [10:0] Default:200 RW */
+		u32 rsv1:5;              /* [15:11] Default:0x0 RO */
+		u32 xon_th:11;           /* [26:16] Default:100 RW */
+		u32 rsv:3;               /* [29:27] Default:0x0 RO */
+		u32 fc_set:1;            /* [30:30] Default:0x0 RW */
+		u32 fc_en:1;             /* [31:31] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_DSTORE_D_DPORT_FC_TH_DWLEN];
+} __packed;
+#define NBL_DSTORE_D_DPORT_FC_TH_REG(r) (NBL_DSTORE_D_DPORT_FC_TH_ADDR + \
+		(NBL_DSTORE_D_DPORT_FC_TH_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_INIT_DONE_ADDR  (0x704800)
+#define NBL_DSTORE_INIT_DONE_DEPTH (1)
+#define NBL_DSTORE_INIT_DONE_WIDTH (32)
+#define NBL_DSTORE_INIT_DONE_DWLEN (1)
+union dstore_init_done_u {
+	struct dstore_init_done {
+		u32 done:1;              /* [0] Default:0x0 RO */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_INIT_DONE_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_SCH_IDLE_LIST_STATUS_CURR_ADDR  (0x70481c)
+#define NBL_DSTORE_SCH_IDLE_LIST_STATUS_CURR_DEPTH (1)
+#define NBL_DSTORE_SCH_IDLE_LIST_STATUS_CURR_WIDTH (32)
+#define NBL_DSTORE_SCH_IDLE_LIST_STATUS_CURR_DWLEN (1)
+union dstore_sch_idle_list_status_curr_u {
+	struct dstore_sch_idle_list_status_curr {
+		u32 empt:1;              /* [0] Default:0x0 RO */
+		u32 full:1;              /* [1] Default:0x1 RO */
+		u32 cnt:10;              /* [11:2] Default:0x200 RO */
+		u32 rsv:20;              /* [31:12] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_SCH_IDLE_LIST_STATUS_CURR_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_SCH_QUE_LIST_STATUS_ADDR  (0x704820)
+#define NBL_DSTORE_SCH_QUE_LIST_STATUS_DEPTH (48)
+#define NBL_DSTORE_SCH_QUE_LIST_STATUS_WIDTH (32)
+#define NBL_DSTORE_SCH_QUE_LIST_STATUS_DWLEN (1)
+union dstore_sch_que_list_status_u {
+	struct dstore_sch_que_list_status {
+		u32 curr_empt:1;         /* [0] Default:0x1 RO */
+		u32 curr_cnt:10;         /* [10:1] Default:0x0 RO */
+		u32 history_udf:1;       /* [11] Default:0x0 RC */
+		u32 rsv:20;              /* [31:12] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_SCH_QUE_LIST_STATUS_DWLEN];
+} __packed;
+#define NBL_DSTORE_SCH_QUE_LIST_STATUS_REG(r) (NBL_DSTORE_SCH_QUE_LIST_STATUS_ADDR + \
+		(NBL_DSTORE_SCH_QUE_LIST_STATUS_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_RCV_TOTAL_PKT_ADDR  (0x705050)
+#define NBL_DSTORE_RCV_TOTAL_PKT_DEPTH (1)
+#define NBL_DSTORE_RCV_TOTAL_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_TOTAL_PKT_DWLEN (1)
+union dstore_rcv_total_pkt_u {
+	struct dstore_rcv_total_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_TOTAL_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_RCV_TOTAL_BYTE_ADDR  (0x705054)
+#define NBL_DSTORE_RCV_TOTAL_BYTE_DEPTH (1)
+#define NBL_DSTORE_RCV_TOTAL_BYTE_WIDTH (48)
+#define NBL_DSTORE_RCV_TOTAL_BYTE_DWLEN (2)
+union dstore_rcv_total_byte_u {
+	struct dstore_rcv_total_byte {
+		u32 cnt_l:32;            /* [47:0] Default:0x0 RCTR */
+		u32 cnt_h:16;            /* [47:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_TOTAL_BYTE_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_RCV_TOTAL_RIGHT_PKT_ADDR  (0x70505c)
+#define NBL_DSTORE_RCV_TOTAL_RIGHT_PKT_DEPTH (1)
+#define NBL_DSTORE_RCV_TOTAL_RIGHT_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_TOTAL_RIGHT_PKT_DWLEN (1)
+union dstore_rcv_total_right_pkt_u {
+	struct dstore_rcv_total_right_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_TOTAL_RIGHT_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_RCV_TOTAL_WRONG_PKT_ADDR  (0x705060)
+#define NBL_DSTORE_RCV_TOTAL_WRONG_PKT_DEPTH (1)
+#define NBL_DSTORE_RCV_TOTAL_WRONG_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_TOTAL_WRONG_PKT_DWLEN (1)
+union dstore_rcv_total_wrong_pkt_u {
+	struct dstore_rcv_total_wrong_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_TOTAL_WRONG_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_RCV_FWD_RIGHT_PKT_ADDR  (0x705064)
+#define NBL_DSTORE_RCV_FWD_RIGHT_PKT_DEPTH (1)
+#define NBL_DSTORE_RCV_FWD_RIGHT_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_FWD_RIGHT_PKT_DWLEN (1)
+union dstore_rcv_fwd_right_pkt_u {
+	struct dstore_rcv_fwd_right_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_FWD_RIGHT_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_RCV_FWD_WRONG_PKT_ADDR  (0x705068)
+#define NBL_DSTORE_RCV_FWD_WRONG_PKT_DEPTH (1)
+#define NBL_DSTORE_RCV_FWD_WRONG_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_FWD_WRONG_PKT_DWLEN (1)
+union dstore_rcv_fwd_wrong_pkt_u {
+	struct dstore_rcv_fwd_wrong_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_FWD_WRONG_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_RCV_HERR_RIGHT_PKT_ADDR  (0x70506c)
+#define NBL_DSTORE_RCV_HERR_RIGHT_PKT_DEPTH (1)
+#define NBL_DSTORE_RCV_HERR_RIGHT_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_HERR_RIGHT_PKT_DWLEN (1)
+union dstore_rcv_herr_right_pkt_u {
+	struct dstore_rcv_herr_right_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_HERR_RIGHT_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_RCV_HERR_WRONG_PKT_ADDR  (0x705070)
+#define NBL_DSTORE_RCV_HERR_WRONG_PKT_DEPTH (1)
+#define NBL_DSTORE_RCV_HERR_WRONG_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_HERR_WRONG_PKT_DWLEN (1)
+union dstore_rcv_herr_wrong_pkt_u {
+	struct dstore_rcv_herr_wrong_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_HERR_WRONG_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_IPRO_TOTAL_PKT_ADDR  (0x705074)
+#define NBL_DSTORE_IPRO_TOTAL_PKT_DEPTH (1)
+#define NBL_DSTORE_IPRO_TOTAL_PKT_WIDTH (32)
+#define NBL_DSTORE_IPRO_TOTAL_PKT_DWLEN (1)
+union dstore_ipro_total_pkt_u {
+	struct dstore_ipro_total_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_IPRO_TOTAL_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_IPRO_TOTAL_BYTE_ADDR  (0x705078)
+#define NBL_DSTORE_IPRO_TOTAL_BYTE_DEPTH (1)
+#define NBL_DSTORE_IPRO_TOTAL_BYTE_WIDTH (48)
+#define NBL_DSTORE_IPRO_TOTAL_BYTE_DWLEN (2)
+union dstore_ipro_total_byte_u {
+	struct dstore_ipro_total_byte {
+		u32 cnt_l:32;            /* [47:0] Default:0x0 RCTR */
+		u32 cnt_h:16;            /* [47:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_IPRO_TOTAL_BYTE_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_IPRO_FWD_RIGHT_PKT_ADDR  (0x705080)
+#define NBL_DSTORE_IPRO_FWD_RIGHT_PKT_DEPTH (1)
+#define NBL_DSTORE_IPRO_FWD_RIGHT_PKT_WIDTH (32)
+#define NBL_DSTORE_IPRO_FWD_RIGHT_PKT_DWLEN (1)
+union dstore_ipro_fwd_right_pkt_u {
+	struct dstore_ipro_fwd_right_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_IPRO_FWD_RIGHT_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_IPRO_FWD_WRONG_PKT_ADDR  (0x705084)
+#define NBL_DSTORE_IPRO_FWD_WRONG_PKT_DEPTH (1)
+#define NBL_DSTORE_IPRO_FWD_WRONG_PKT_WIDTH (32)
+#define NBL_DSTORE_IPRO_FWD_WRONG_PKT_DWLEN (1)
+union dstore_ipro_fwd_wrong_pkt_u {
+	struct dstore_ipro_fwd_wrong_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_IPRO_FWD_WRONG_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_IPRO_HERR_RIGHT_PKT_ADDR  (0x705088)
+#define NBL_DSTORE_IPRO_HERR_RIGHT_PKT_DEPTH (1)
+#define NBL_DSTORE_IPRO_HERR_RIGHT_PKT_WIDTH (32)
+#define NBL_DSTORE_IPRO_HERR_RIGHT_PKT_DWLEN (1)
+union dstore_ipro_herr_right_pkt_u {
+	struct dstore_ipro_herr_right_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_IPRO_HERR_RIGHT_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_IPRO_HERR_WRONG_PKT_ADDR  (0x70508c)
+#define NBL_DSTORE_IPRO_HERR_WRONG_PKT_DEPTH (1)
+#define NBL_DSTORE_IPRO_HERR_WRONG_PKT_WIDTH (32)
+#define NBL_DSTORE_IPRO_HERR_WRONG_PKT_DWLEN (1)
+union dstore_ipro_herr_wrong_pkt_u {
+	struct dstore_ipro_herr_wrong_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_IPRO_HERR_WRONG_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_PMEM_TOTAL_PKT_ADDR  (0x705090)
+#define NBL_DSTORE_PMEM_TOTAL_PKT_DEPTH (1)
+#define NBL_DSTORE_PMEM_TOTAL_PKT_WIDTH (32)
+#define NBL_DSTORE_PMEM_TOTAL_PKT_DWLEN (1)
+union dstore_pmem_total_pkt_u {
+	struct dstore_pmem_total_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_PMEM_TOTAL_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_PMEM_TOTAL_BYTE_ADDR  (0x705094)
+#define NBL_DSTORE_PMEM_TOTAL_BYTE_DEPTH (1)
+#define NBL_DSTORE_PMEM_TOTAL_BYTE_WIDTH (48)
+#define NBL_DSTORE_PMEM_TOTAL_BYTE_DWLEN (2)
+union dstore_pmem_total_byte_u {
+	struct dstore_pmem_total_byte {
+		u32 cnt_l:32;            /* [47:0] Default:0x0 RCTR */
+		u32 cnt_h:16;            /* [47:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_PMEM_TOTAL_BYTE_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_RCV_TOTAL_ERR_DROP_PKT_ADDR  (0x70509c)
+#define NBL_DSTORE_RCV_TOTAL_ERR_DROP_PKT_DEPTH (1)
+#define NBL_DSTORE_RCV_TOTAL_ERR_DROP_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_TOTAL_ERR_DROP_PKT_DWLEN (1)
+union dstore_rcv_total_err_drop_pkt_u {
+	struct dstore_rcv_total_err_drop_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 SCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_TOTAL_ERR_DROP_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_RCV_TOTAL_SHORT_PKT_ADDR  (0x7050a0)
+#define NBL_DSTORE_RCV_TOTAL_SHORT_PKT_DEPTH (1)
+#define NBL_DSTORE_RCV_TOTAL_SHORT_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_TOTAL_SHORT_PKT_DWLEN (1)
+union dstore_rcv_total_short_pkt_u {
+	struct dstore_rcv_total_short_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 SCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_TOTAL_SHORT_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_RCV_TOTAL_LONG_PKT_ADDR  (0x7050a4)
+#define NBL_DSTORE_RCV_TOTAL_LONG_PKT_DEPTH (1)
+#define NBL_DSTORE_RCV_TOTAL_LONG_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_TOTAL_LONG_PKT_DWLEN (1)
+union dstore_rcv_total_long_pkt_u {
+	struct dstore_rcv_total_long_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 SCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_TOTAL_LONG_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_BUF_TOTAL_DROP_PKT_ADDR  (0x7050a8)
+#define NBL_DSTORE_BUF_TOTAL_DROP_PKT_DEPTH (1)
+#define NBL_DSTORE_BUF_TOTAL_DROP_PKT_WIDTH (32)
+#define NBL_DSTORE_BUF_TOTAL_DROP_PKT_DWLEN (1)
+union dstore_buf_total_drop_pkt_u {
+	struct dstore_buf_total_drop_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 SCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_BUF_TOTAL_DROP_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_BUF_TOTAL_TRUN_PKT_ADDR  (0x7050ac)
+#define NBL_DSTORE_BUF_TOTAL_TRUN_PKT_DEPTH (1)
+#define NBL_DSTORE_BUF_TOTAL_TRUN_PKT_WIDTH (32)
+#define NBL_DSTORE_BUF_TOTAL_TRUN_PKT_DWLEN (1)
+union dstore_buf_total_trun_pkt_u {
+	struct dstore_buf_total_trun_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 SCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_BUF_TOTAL_TRUN_PKT_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_RCV_PORT_PKT_ADDR  (0x706000)
+#define NBL_DSTORE_RCV_PORT_PKT_DEPTH (12)
+#define NBL_DSTORE_RCV_PORT_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_PORT_PKT_DWLEN (1)
+union dstore_rcv_port_pkt_u {
+	struct dstore_rcv_port_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_PORT_PKT_DWLEN];
+} __packed;
+#define NBL_DSTORE_RCV_PORT_PKT_REG(r) (NBL_DSTORE_RCV_PORT_PKT_ADDR + \
+		(NBL_DSTORE_RCV_PORT_PKT_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_RCV_PORT_BYTE_ADDR  (0x706040)
+#define NBL_DSTORE_RCV_PORT_BYTE_DEPTH (12)
+#define NBL_DSTORE_RCV_PORT_BYTE_WIDTH (48)
+#define NBL_DSTORE_RCV_PORT_BYTE_DWLEN (2)
+union dstore_rcv_port_byte_u {
+	struct dstore_rcv_port_byte {
+		u32 cnt_l:32;            /* [47:0] Default:0x0 RCTR */
+		u32 cnt_h:16;            /* [47:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_PORT_BYTE_DWLEN];
+} __packed;
+#define NBL_DSTORE_RCV_PORT_BYTE_REG(r) (NBL_DSTORE_RCV_PORT_BYTE_ADDR + \
+		(NBL_DSTORE_RCV_PORT_BYTE_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_RCV_PORT_TOTAL_RIGHT_PKT_ADDR  (0x7060c0)
+#define NBL_DSTORE_RCV_PORT_TOTAL_RIGHT_PKT_DEPTH (12)
+#define NBL_DSTORE_RCV_PORT_TOTAL_RIGHT_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_PORT_TOTAL_RIGHT_PKT_DWLEN (1)
+union dstore_rcv_port_total_right_pkt_u {
+	struct dstore_rcv_port_total_right_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_PORT_TOTAL_RIGHT_PKT_DWLEN];
+} __packed;
+#define NBL_DSTORE_RCV_PORT_TOTAL_RIGHT_PKT_REG(r) (NBL_DSTORE_RCV_PORT_TOTAL_RIGHT_PKT_ADDR + \
+		(NBL_DSTORE_RCV_PORT_TOTAL_RIGHT_PKT_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_RCV_PORT_TOTAL_WRONG_PKT_ADDR  (0x706100)
+#define NBL_DSTORE_RCV_PORT_TOTAL_WRONG_PKT_DEPTH (12)
+#define NBL_DSTORE_RCV_PORT_TOTAL_WRONG_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_PORT_TOTAL_WRONG_PKT_DWLEN (1)
+union dstore_rcv_port_total_wrong_pkt_u {
+	struct dstore_rcv_port_total_wrong_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_PORT_TOTAL_WRONG_PKT_DWLEN];
+} __packed;
+#define NBL_DSTORE_RCV_PORT_TOTAL_WRONG_PKT_REG(r) (NBL_DSTORE_RCV_PORT_TOTAL_WRONG_PKT_ADDR + \
+		(NBL_DSTORE_RCV_PORT_TOTAL_WRONG_PKT_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_RCV_PORT_FWD_RIGHT_PKT_ADDR  (0x706140)
+#define NBL_DSTORE_RCV_PORT_FWD_RIGHT_PKT_DEPTH (12)
+#define NBL_DSTORE_RCV_PORT_FWD_RIGHT_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_PORT_FWD_RIGHT_PKT_DWLEN (1)
+union dstore_rcv_port_fwd_right_pkt_u {
+	struct dstore_rcv_port_fwd_right_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_PORT_FWD_RIGHT_PKT_DWLEN];
+} __packed;
+#define NBL_DSTORE_RCV_PORT_FWD_RIGHT_PKT_REG(r) (NBL_DSTORE_RCV_PORT_FWD_RIGHT_PKT_ADDR + \
+		(NBL_DSTORE_RCV_PORT_FWD_RIGHT_PKT_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_RCV_PORT_FWD_WRONG_PKT_ADDR  (0x706180)
+#define NBL_DSTORE_RCV_PORT_FWD_WRONG_PKT_DEPTH (12)
+#define NBL_DSTORE_RCV_PORT_FWD_WRONG_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_PORT_FWD_WRONG_PKT_DWLEN (1)
+union dstore_rcv_port_fwd_wrong_pkt_u {
+	struct dstore_rcv_port_fwd_wrong_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_PORT_FWD_WRONG_PKT_DWLEN];
+} __packed;
+#define NBL_DSTORE_RCV_PORT_FWD_WRONG_PKT_REG(r) (NBL_DSTORE_RCV_PORT_FWD_WRONG_PKT_ADDR + \
+		(NBL_DSTORE_RCV_PORT_FWD_WRONG_PKT_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_RCV_PORT_HERR_RIGHT_PKT_ADDR  (0x7061c0)
+#define NBL_DSTORE_RCV_PORT_HERR_RIGHT_PKT_DEPTH (12)
+#define NBL_DSTORE_RCV_PORT_HERR_RIGHT_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_PORT_HERR_RIGHT_PKT_DWLEN (1)
+union dstore_rcv_port_herr_right_pkt_u {
+	struct dstore_rcv_port_herr_right_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_PORT_HERR_RIGHT_PKT_DWLEN];
+} __packed;
+#define NBL_DSTORE_RCV_PORT_HERR_RIGHT_PKT_REG(r) (NBL_DSTORE_RCV_PORT_HERR_RIGHT_PKT_ADDR + \
+		(NBL_DSTORE_RCV_PORT_HERR_RIGHT_PKT_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_RCV_PORT_HERR_WRONG_PKT_ADDR  (0x706200)
+#define NBL_DSTORE_RCV_PORT_HERR_WRONG_PKT_DEPTH (12)
+#define NBL_DSTORE_RCV_PORT_HERR_WRONG_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_PORT_HERR_WRONG_PKT_DWLEN (1)
+union dstore_rcv_port_herr_wrong_pkt_u {
+	struct dstore_rcv_port_herr_wrong_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_PORT_HERR_WRONG_PKT_DWLEN];
+} __packed;
+#define NBL_DSTORE_RCV_PORT_HERR_WRONG_PKT_REG(r) (NBL_DSTORE_RCV_PORT_HERR_WRONG_PKT_ADDR + \
+		(NBL_DSTORE_RCV_PORT_HERR_WRONG_PKT_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_IPRO_PORT_PKT_ADDR  (0x706240)
+#define NBL_DSTORE_IPRO_PORT_PKT_DEPTH (12)
+#define NBL_DSTORE_IPRO_PORT_PKT_WIDTH (32)
+#define NBL_DSTORE_IPRO_PORT_PKT_DWLEN (1)
+union dstore_ipro_port_pkt_u {
+	struct dstore_ipro_port_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_IPRO_PORT_PKT_DWLEN];
+} __packed;
+#define NBL_DSTORE_IPRO_PORT_PKT_REG(r) (NBL_DSTORE_IPRO_PORT_PKT_ADDR + \
+		(NBL_DSTORE_IPRO_PORT_PKT_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_IPRO_PORT_BYTE_ADDR  (0x706280)
+#define NBL_DSTORE_IPRO_PORT_BYTE_DEPTH (12)
+#define NBL_DSTORE_IPRO_PORT_BYTE_WIDTH (48)
+#define NBL_DSTORE_IPRO_PORT_BYTE_DWLEN (2)
+union dstore_ipro_port_byte_u {
+	struct dstore_ipro_port_byte {
+		u32 cnt_l:32;            /* [47:0] Default:0x0 RCTR */
+		u32 cnt_h:16;            /* [47:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_IPRO_PORT_BYTE_DWLEN];
+} __packed;
+#define NBL_DSTORE_IPRO_PORT_BYTE_REG(r) (NBL_DSTORE_IPRO_PORT_BYTE_ADDR + \
+		(NBL_DSTORE_IPRO_PORT_BYTE_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_IPRO_PORT_FWD_RIGHT_PKT_ADDR  (0x706300)
+#define NBL_DSTORE_IPRO_PORT_FWD_RIGHT_PKT_DEPTH (12)
+#define NBL_DSTORE_IPRO_PORT_FWD_RIGHT_PKT_WIDTH (32)
+#define NBL_DSTORE_IPRO_PORT_FWD_RIGHT_PKT_DWLEN (1)
+union dstore_ipro_port_fwd_right_pkt_u {
+	struct dstore_ipro_port_fwd_right_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_IPRO_PORT_FWD_RIGHT_PKT_DWLEN];
+} __packed;
+#define NBL_DSTORE_IPRO_PORT_FWD_RIGHT_PKT_REG(r) (NBL_DSTORE_IPRO_PORT_FWD_RIGHT_PKT_ADDR + \
+		(NBL_DSTORE_IPRO_PORT_FWD_RIGHT_PKT_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_IPRO_PORT_FWD_WRONG_PKT_ADDR  (0x706340)
+#define NBL_DSTORE_IPRO_PORT_FWD_WRONG_PKT_DEPTH (12)
+#define NBL_DSTORE_IPRO_PORT_FWD_WRONG_PKT_WIDTH (32)
+#define NBL_DSTORE_IPRO_PORT_FWD_WRONG_PKT_DWLEN (1)
+union dstore_ipro_port_fwd_wrong_pkt_u {
+	struct dstore_ipro_port_fwd_wrong_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_IPRO_PORT_FWD_WRONG_PKT_DWLEN];
+} __packed;
+#define NBL_DSTORE_IPRO_PORT_FWD_WRONG_PKT_REG(r) (NBL_DSTORE_IPRO_PORT_FWD_WRONG_PKT_ADDR + \
+		(NBL_DSTORE_IPRO_PORT_FWD_WRONG_PKT_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_PMEM_PORT_PKT_ADDR  (0x706380)
+#define NBL_DSTORE_PMEM_PORT_PKT_DEPTH (12)
+#define NBL_DSTORE_PMEM_PORT_PKT_WIDTH (32)
+#define NBL_DSTORE_PMEM_PORT_PKT_DWLEN (1)
+union dstore_pmem_port_pkt_u {
+	struct dstore_pmem_port_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_PMEM_PORT_PKT_DWLEN];
+} __packed;
+#define NBL_DSTORE_PMEM_PORT_PKT_REG(r) (NBL_DSTORE_PMEM_PORT_PKT_ADDR + \
+		(NBL_DSTORE_PMEM_PORT_PKT_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_PMEM_PORT_BYTE_ADDR  (0x7063c0)
+#define NBL_DSTORE_PMEM_PORT_BYTE_DEPTH (12)
+#define NBL_DSTORE_PMEM_PORT_BYTE_WIDTH (48)
+#define NBL_DSTORE_PMEM_PORT_BYTE_DWLEN (2)
+union dstore_pmem_port_byte_u {
+	struct dstore_pmem_port_byte {
+		u32 cnt_l:32;            /* [47:0] Default:0x0 RCTR */
+		u32 cnt_h:16;            /* [47:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_PMEM_PORT_BYTE_DWLEN];
+} __packed;
+#define NBL_DSTORE_PMEM_PORT_BYTE_REG(r) (NBL_DSTORE_PMEM_PORT_BYTE_ADDR + \
+		(NBL_DSTORE_PMEM_PORT_BYTE_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_RCV_ERR_PORT_DROP_PKT_ADDR  (0x706440)
+#define NBL_DSTORE_RCV_ERR_PORT_DROP_PKT_DEPTH (12)
+#define NBL_DSTORE_RCV_ERR_PORT_DROP_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_ERR_PORT_DROP_PKT_DWLEN (1)
+union dstore_rcv_err_port_drop_pkt_u {
+	struct dstore_rcv_err_port_drop_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 SCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_ERR_PORT_DROP_PKT_DWLEN];
+} __packed;
+#define NBL_DSTORE_RCV_ERR_PORT_DROP_PKT_REG(r) (NBL_DSTORE_RCV_ERR_PORT_DROP_PKT_ADDR + \
+		(NBL_DSTORE_RCV_ERR_PORT_DROP_PKT_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_RCV_PORT_SHORT_DROP_PKT_ADDR  (0x706480)
+#define NBL_DSTORE_RCV_PORT_SHORT_DROP_PKT_DEPTH (12)
+#define NBL_DSTORE_RCV_PORT_SHORT_DROP_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_PORT_SHORT_DROP_PKT_DWLEN (1)
+union dstore_rcv_port_short_drop_pkt_u {
+	struct dstore_rcv_port_short_drop_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 SCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_PORT_SHORT_DROP_PKT_DWLEN];
+} __packed;
+#define NBL_DSTORE_RCV_PORT_SHORT_DROP_PKT_REG(r) (NBL_DSTORE_RCV_PORT_SHORT_DROP_PKT_ADDR + \
+		(NBL_DSTORE_RCV_PORT_SHORT_DROP_PKT_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_RCV_PORT_LONG_PKT_ADDR  (0x7064c0)
+#define NBL_DSTORE_RCV_PORT_LONG_PKT_DEPTH (12)
+#define NBL_DSTORE_RCV_PORT_LONG_PKT_WIDTH (32)
+#define NBL_DSTORE_RCV_PORT_LONG_PKT_DWLEN (1)
+union dstore_rcv_port_long_pkt_u {
+	struct dstore_rcv_port_long_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 SCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_RCV_PORT_LONG_PKT_DWLEN];
+} __packed;
+#define NBL_DSTORE_RCV_PORT_LONG_PKT_REG(r) (NBL_DSTORE_RCV_PORT_LONG_PKT_ADDR + \
+		(NBL_DSTORE_RCV_PORT_LONG_PKT_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_BUF_PORT_DROP_PKT_ADDR  (0x706500)
+#define NBL_DSTORE_BUF_PORT_DROP_PKT_DEPTH (12)
+#define NBL_DSTORE_BUF_PORT_DROP_PKT_WIDTH (32)
+#define NBL_DSTORE_BUF_PORT_DROP_PKT_DWLEN (1)
+union dstore_buf_port_drop_pkt_u {
+	struct dstore_buf_port_drop_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 SCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_BUF_PORT_DROP_PKT_DWLEN];
+} __packed;
+#define NBL_DSTORE_BUF_PORT_DROP_PKT_REG(r) (NBL_DSTORE_BUF_PORT_DROP_PKT_ADDR + \
+		(NBL_DSTORE_BUF_PORT_DROP_PKT_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_BUF_PORT_TRUN_PKT_ADDR  (0x706540)
+#define NBL_DSTORE_BUF_PORT_TRUN_PKT_DEPTH (12)
+#define NBL_DSTORE_BUF_PORT_TRUN_PKT_WIDTH (32)
+#define NBL_DSTORE_BUF_PORT_TRUN_PKT_DWLEN (1)
+union dstore_buf_port_trun_pkt_u {
+	struct dstore_buf_port_trun_pkt {
+		u32 cnt:32;              /* [31:0] Default:0x0 SCTR */
+	} __packed info;
+	u32 data[NBL_DSTORE_BUF_PORT_TRUN_PKT_DWLEN];
+} __packed;
+#define NBL_DSTORE_BUF_PORT_TRUN_PKT_REG(r) (NBL_DSTORE_BUF_PORT_TRUN_PKT_ADDR + \
+		(NBL_DSTORE_BUF_PORT_TRUN_PKT_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_BP_CUR_1ST_ADDR  (0x706580)
+#define NBL_DSTORE_BP_CUR_1ST_DEPTH (1)
+#define NBL_DSTORE_BP_CUR_1ST_WIDTH (32)
+#define NBL_DSTORE_BP_CUR_1ST_DWLEN (1)
+union dstore_bp_cur_1st_u {
+	struct dstore_bp_cur_1st {
+		u32 link_fc:6;           /* [5:0] Default:0x0 RO */
+		u32 rsv:2;               /* [7:6] Default:0x0 RO */
+		u32 pfc:24;              /* [31:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_BP_CUR_1ST_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_BP_CUR_2ND_ADDR  (0x706584)
+#define NBL_DSTORE_BP_CUR_2ND_DEPTH (1)
+#define NBL_DSTORE_BP_CUR_2ND_WIDTH (32)
+#define NBL_DSTORE_BP_CUR_2ND_DWLEN (1)
+union dstore_bp_cur_2nd_u {
+	struct dstore_bp_cur_2nd {
+		u32 pfc:24;              /* [23:0] Default:0x0 RO */
+		u32 rsv:8;               /* [31:24] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_BP_CUR_2ND_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_BP_HISTORY_LINK_ADDR  (0x706590)
+#define NBL_DSTORE_BP_HISTORY_LINK_DEPTH (6)
+#define NBL_DSTORE_BP_HISTORY_LINK_WIDTH (32)
+#define NBL_DSTORE_BP_HISTORY_LINK_DWLEN (1)
+union dstore_bp_history_link_u {
+	struct dstore_bp_history_link {
+		u32 fc:1;                /* [0] Default:0x0 RC */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_BP_HISTORY_LINK_DWLEN];
+} __packed;
+#define NBL_DSTORE_BP_HISTORY_LINK_REG(r) (NBL_DSTORE_BP_HISTORY_LINK_ADDR + \
+		(NBL_DSTORE_BP_HISTORY_LINK_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_BP_HISTORY_ADDR  (0x7065b0)
+#define NBL_DSTORE_BP_HISTORY_DEPTH (48)
+#define NBL_DSTORE_BP_HISTORY_WIDTH (32)
+#define NBL_DSTORE_BP_HISTORY_DWLEN (1)
+union dstore_bp_history_u {
+	struct dstore_bp_history {
+		u32 pfc:1;               /* [0] Default:0x0 RC */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_BP_HISTORY_DWLEN];
+} __packed;
+#define NBL_DSTORE_BP_HISTORY_REG(r) (NBL_DSTORE_BP_HISTORY_ADDR + \
+		(NBL_DSTORE_BP_HISTORY_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_WRR_CUR_ADDR  (0x706800)
+#define NBL_DSTORE_WRR_CUR_DEPTH (36)
+#define NBL_DSTORE_WRR_CUR_WIDTH (32)
+#define NBL_DSTORE_WRR_CUR_DWLEN (1)
+union dstore_wrr_cur_u {
+	struct dstore_wrr_cur {
+		u32 wgt_cos:5;           /* [4:0] Default:0x0 RO */
+		u32 rsv:27;              /* [31:5] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_WRR_CUR_DWLEN];
+} __packed;
+#define NBL_DSTORE_WRR_CUR_REG(r) (NBL_DSTORE_WRR_CUR_ADDR + \
+		(NBL_DSTORE_WRR_CUR_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_DDPORT_CUR_ADDR  (0x707018)
+#define NBL_DSTORE_DDPORT_CUR_DEPTH (1)
+#define NBL_DSTORE_DDPORT_CUR_WIDTH (32)
+#define NBL_DSTORE_DDPORT_CUR_DWLEN (1)
+union dstore_ddport_cur_u {
+	struct dstore_ddport_cur {
+		u32 link_fc:5;           /* [4:0] Default:0x0 RO */
+		u32 rsv:27;              /* [31:5] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_DDPORT_CUR_DWLEN];
+} __packed;
+
+#define NBL_DSTORE_DDPORT_HISTORY_ADDR  (0x70701c)
+#define NBL_DSTORE_DDPORT_HISTORY_DEPTH (5)
+#define NBL_DSTORE_DDPORT_HISTORY_WIDTH (32)
+#define NBL_DSTORE_DDPORT_HISTORY_DWLEN (1)
+union dstore_ddport_history_u {
+	struct dstore_ddport_history {
+		u32 link_fc:1;           /* [0] Default:0x0 RC */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_DDPORT_HISTORY_DWLEN];
+} __packed;
+#define NBL_DSTORE_DDPORT_HISTORY_REG(r) (NBL_DSTORE_DDPORT_HISTORY_ADDR + \
+		(NBL_DSTORE_DDPORT_HISTORY_DWLEN * 4) * (r))
+
+#define NBL_DSTORE_DDPORT_RSC_ADD_ADDR  (0x707050)
+#define NBL_DSTORE_DDPORT_RSC_ADD_DEPTH (5)
+#define NBL_DSTORE_DDPORT_RSC_ADD_WIDTH (32)
+#define NBL_DSTORE_DDPORT_RSC_ADD_DWLEN (1)
+union dstore_ddport_rsc_add_u {
+	struct dstore_ddport_rsc_add {
+		u32 cnt:12;              /* [11:0] Default:0x0 RO */
+		u32 rsv:20;              /* [31:12] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_DSTORE_DDPORT_RSC_ADD_DWLEN];
+} __packed;
+#define NBL_DSTORE_DDPORT_RSC_ADD_REG(r) (NBL_DSTORE_DDPORT_RSC_ADD_ADDR + \
+		(NBL_DSTORE_DDPORT_RSC_ADD_DWLEN * 4) * (r))
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_ucar.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_ucar.h
new file mode 100644
index 000000000000..3504c272c4d4
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_ucar.h
@@ -0,0 +1,414 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+// Code generated by interstellar. DO NOT EDIT.
+// Compatible with leonis RTL tag 0710
+
+#ifndef NBL_UCAR_H
+#define NBL_UCAR_H 1
+
+#include <linux/types.h>
+
+#define NBL_UCAR_BASE (0x00E84000)
+
+#define NBL_UCAR_INT_STATUS_ADDR  (0xe84000)
+#define NBL_UCAR_INT_STATUS_DEPTH (1)
+#define NBL_UCAR_INT_STATUS_WIDTH (32)
+#define NBL_UCAR_INT_STATUS_DWLEN (1)
+union ucar_int_status_u {
+	struct ucar_int_status {
+		u32 color_err:1;         /* [0] Default:0x0 RWC */
+		u32 parity_err:1;        /* [1] Default:0x0 RWC */
+		u32 fifo_uflw_err:1;     /* [2] Default:0x0 RWC */
+		u32 cif_err:1;           /* [3] Default:0x0 RWC */
+		u32 fifo_dflw_err:1;     /* [4] Default:0x0 RWC */
+		u32 atid_nomat_err:1;    /* [5] Default:0x0 RWC */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_INT_STATUS_DWLEN];
+} __packed;
+
+#define NBL_UCAR_INT_MASK_ADDR  (0xe84004)
+#define NBL_UCAR_INT_MASK_DEPTH (1)
+#define NBL_UCAR_INT_MASK_WIDTH (32)
+#define NBL_UCAR_INT_MASK_DWLEN (1)
+union ucar_int_mask_u {
+	struct ucar_int_mask {
+		u32 color_err:1;         /* [0] Default:0x1 RW */
+		u32 parity_err:1;        /* [1] Default:0x0 RW */
+		u32 fifo_uflw_err:1;     /* [2] Default:0x0 RW */
+		u32 cif_err:1;           /* [3] Default:0x0 RW */
+		u32 fifo_dflw_err:1;     /* [4] Default:0x0 RW */
+		u32 atid_nomat_err:1;    /* [5] Default:0x1 RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_INT_MASK_DWLEN];
+} __packed;
+
+#define NBL_UCAR_INT_SET_ADDR  (0xe84008)
+#define NBL_UCAR_INT_SET_DEPTH (1)
+#define NBL_UCAR_INT_SET_WIDTH (32)
+#define NBL_UCAR_INT_SET_DWLEN (1)
+union ucar_int_set_u {
+	struct ucar_int_set {
+		u32 color_err:1;         /* [0] Default:0x0 WO */
+		u32 parity_err:1;        /* [1] Default:0x0 WO */
+		u32 fifo_uflw_err:1;     /* [2] Default:0x0 WO */
+		u32 cif_err:1;           /* [3] Default:0x0 WO */
+		u32 fifo_dflw_err:1;     /* [4] Default:0x0 WO */
+		u32 atid_nomat_err:1;    /* [5] Default:0x0 WO */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_INT_SET_DWLEN];
+} __packed;
+
+#define NBL_UCAR_PARITY_ERR_INFO_ADDR  (0xe84104)
+#define NBL_UCAR_PARITY_ERR_INFO_DEPTH (1)
+#define NBL_UCAR_PARITY_ERR_INFO_WIDTH (32)
+#define NBL_UCAR_PARITY_ERR_INFO_DWLEN (1)
+union ucar_parity_err_info_u {
+	struct ucar_parity_err_info {
+		u32 ram_addr:12;         /* [11:0] Default:0x0 RO */
+		u32 ram_id:3;            /* [14:12] Default:0x0 RO */
+		u32 rsv:17;              /* [31:15] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_PARITY_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_UCAR_CIF_ERR_INFO_ADDR  (0xe8411c)
+#define NBL_UCAR_CIF_ERR_INFO_DEPTH (1)
+#define NBL_UCAR_CIF_ERR_INFO_WIDTH (32)
+#define NBL_UCAR_CIF_ERR_INFO_DWLEN (1)
+union ucar_cif_err_info_u {
+	struct ucar_cif_err_info {
+		u32 addr:30;             /* [29:0] Default:0x0 RO */
+		u32 wr_err:1;            /* [30] Default:0x0 RO */
+		u32 ucor_err:1;          /* [31] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_CIF_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_UCAR_ATID_NOMAT_ERR_INFO_ADDR  (0xe84134)
+#define NBL_UCAR_ATID_NOMAT_ERR_INFO_DEPTH (1)
+#define NBL_UCAR_ATID_NOMAT_ERR_INFO_WIDTH (32)
+#define NBL_UCAR_ATID_NOMAT_ERR_INFO_DWLEN (1)
+union ucar_atid_nomat_err_info_u {
+	struct ucar_atid_nomat_err_info {
+		u32 id:2;                /* [1:0] Default:0x0 RO */
+		u32 rsv:30;              /* [31:2] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_ATID_NOMAT_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_UCAR_CAR_CTRL_ADDR  (0xe84200)
+#define NBL_UCAR_CAR_CTRL_DEPTH (1)
+#define NBL_UCAR_CAR_CTRL_WIDTH (32)
+#define NBL_UCAR_CAR_CTRL_DWLEN (1)
+union ucar_car_ctrl_u {
+	struct ucar_car_ctrl {
+		u32 sctr_car:1;          /* [0] Default:0x1 RW */
+		u32 rctr_car:1;          /* [1] Default:0x1 RW */
+		u32 rc_car:1;            /* [2] Default:0x1 RW */
+		u32 tbl_rc_car:1;        /* [3] Default:0x1 RW */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_CAR_CTRL_DWLEN];
+} __packed;
+
+#define NBL_UCAR_INIT_START_ADDR  (0xe84204)
+#define NBL_UCAR_INIT_START_DEPTH (1)
+#define NBL_UCAR_INIT_START_WIDTH (32)
+#define NBL_UCAR_INIT_START_DWLEN (1)
+union ucar_init_start_u {
+	struct ucar_init_start {
+		u32 start:1;             /* [0] Default:0x0 WO */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_INIT_START_DWLEN];
+} __packed;
+
+#define NBL_UCAR_FWD_CARID_ADDR  (0xe84210)
+#define NBL_UCAR_FWD_CARID_DEPTH (1)
+#define NBL_UCAR_FWD_CARID_WIDTH (32)
+#define NBL_UCAR_FWD_CARID_DWLEN (1)
+union ucar_fwd_carid_u {
+	struct ucar_fwd_carid {
+		u32 act_id:6;            /* [5:0] Default:0x5 RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_FWD_CARID_DWLEN];
+} __packed;
+
+#define NBL_UCAR_FWD_FLOW_CAR_ADDR  (0xe84214)
+#define NBL_UCAR_FWD_FLOW_CAR_DEPTH (1)
+#define NBL_UCAR_FWD_FLOW_CAR_WIDTH (32)
+#define NBL_UCAR_FWD_FLOW_CAR_DWLEN (1)
+union ucar_fwd_flow_car_u {
+	struct ucar_fwd_flow_car {
+		u32 act_id:6;            /* [5:0] Default:0x6 RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_FWD_FLOW_CAR_DWLEN];
+} __packed;
+
+#define NBL_UCAR_PBS_SUB_ADDR  (0xe84224)
+#define NBL_UCAR_PBS_SUB_DEPTH (1)
+#define NBL_UCAR_PBS_SUB_WIDTH (32)
+#define NBL_UCAR_PBS_SUB_DWLEN (1)
+union ucar_pbs_sub_u {
+	struct ucar_pbs_sub {
+		u32 sel:1;               /* [0] Default:0x0 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_PBS_SUB_DWLEN];
+} __packed;
+
+#define NBL_UCAR_FLOW_TIMMING_ADD_ADDR  (0xe84400)
+#define NBL_UCAR_FLOW_TIMMING_ADD_DEPTH (1)
+#define NBL_UCAR_FLOW_TIMMING_ADD_WIDTH (32)
+#define NBL_UCAR_FLOW_TIMMING_ADD_DWLEN (1)
+union ucar_flow_timming_add_u {
+	struct ucar_flow_timming_add {
+		u32 cycle_max:12;        /* [11:0] Default:0x4 RW */
+		u32 rsv1:4;              /* [15:12] Default:0x0 RO */
+		u32 depth:14;            /* [29:16] Default:0x4B0 RW */
+		u32 rsv:2;               /* [31:30] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_FLOW_TIMMING_ADD_DWLEN];
+} __packed;
+
+#define NBL_UCAR_FLOW_4K_TIMMING_ADD_ADDR  (0xe84404)
+#define NBL_UCAR_FLOW_4K_TIMMING_ADD_DEPTH (1)
+#define NBL_UCAR_FLOW_4K_TIMMING_ADD_WIDTH (32)
+#define NBL_UCAR_FLOW_4K_TIMMING_ADD_DWLEN (1)
+union ucar_flow_4k_timming_add_u {
+	struct ucar_flow_4k_timming_add {
+		u32 cycle_max:12;        /* [11:0] Default:0x4 RW */
+		u32 depth:18;            /* [29:12] Default:0x12C0 RW */
+		u32 rsv:2;               /* [31:30] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_FLOW_4K_TIMMING_ADD_DWLEN];
+} __packed;
+
+#define NBL_UCAR_INIT_DONE_ADDR  (0xe84408)
+#define NBL_UCAR_INIT_DONE_DEPTH (1)
+#define NBL_UCAR_INIT_DONE_WIDTH (32)
+#define NBL_UCAR_INIT_DONE_DWLEN (1)
+union ucar_init_done_u {
+	struct ucar_init_done {
+		u32 done:1;              /* [0] Default:0x0 RO */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_INIT_DONE_DWLEN];
+} __packed;
+
+#define NBL_UCAR_INPUT_CELL_ADDR  (0xe8441c)
+#define NBL_UCAR_INPUT_CELL_DEPTH (1)
+#define NBL_UCAR_INPUT_CELL_WIDTH (32)
+#define NBL_UCAR_INPUT_CELL_DWLEN (1)
+union ucar_input_cell_u {
+	struct ucar_input_cell {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_UCAR_INPUT_CELL_DWLEN];
+} __packed;
+
+#define NBL_UCAR_RD_CELL_ADDR  (0xe84420)
+#define NBL_UCAR_RD_CELL_DEPTH (1)
+#define NBL_UCAR_RD_CELL_WIDTH (32)
+#define NBL_UCAR_RD_CELL_DWLEN (1)
+union ucar_rd_cell_u {
+	struct ucar_rd_cell {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_UCAR_RD_CELL_DWLEN];
+} __packed;
+
+#define NBL_UCAR_CAR_CELL_ADDR  (0xe84424)
+#define NBL_UCAR_CAR_CELL_DEPTH (1)
+#define NBL_UCAR_CAR_CELL_WIDTH (32)
+#define NBL_UCAR_CAR_CELL_DWLEN (1)
+union ucar_car_cell_u {
+	struct ucar_car_cell {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_UCAR_CAR_CELL_DWLEN];
+} __packed;
+
+#define NBL_UCAR_CAR_FLOW_CELL_ADDR  (0xe84428)
+#define NBL_UCAR_CAR_FLOW_CELL_DEPTH (1)
+#define NBL_UCAR_CAR_FLOW_CELL_WIDTH (32)
+#define NBL_UCAR_CAR_FLOW_CELL_DWLEN (1)
+union ucar_car_flow_cell_u {
+	struct ucar_car_flow_cell {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_UCAR_CAR_FLOW_CELL_DWLEN];
+} __packed;
+
+#define NBL_UCAR_CAR_FLOW_4K_CELL_ADDR  (0xe8442c)
+#define NBL_UCAR_CAR_FLOW_4K_CELL_DEPTH (1)
+#define NBL_UCAR_CAR_FLOW_4K_CELL_WIDTH (32)
+#define NBL_UCAR_CAR_FLOW_4K_CELL_DWLEN (1)
+union ucar_car_flow_4k_cell_u {
+	struct ucar_car_flow_4k_cell {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_UCAR_CAR_FLOW_4K_CELL_DWLEN];
+} __packed;
+
+#define NBL_UCAR_NOCAR_CELL_ADDR  (0xe84430)
+#define NBL_UCAR_NOCAR_CELL_DEPTH (1)
+#define NBL_UCAR_NOCAR_CELL_WIDTH (32)
+#define NBL_UCAR_NOCAR_CELL_DWLEN (1)
+union ucar_nocar_cell_u {
+	struct ucar_nocar_cell {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_UCAR_NOCAR_CELL_DWLEN];
+} __packed;
+
+#define NBL_UCAR_NOCAR_ERR_ADDR  (0xe84434)
+#define NBL_UCAR_NOCAR_ERR_DEPTH (1)
+#define NBL_UCAR_NOCAR_ERR_WIDTH (32)
+#define NBL_UCAR_NOCAR_ERR_DWLEN (1)
+union ucar_nocar_err_u {
+	struct ucar_nocar_err {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_UCAR_NOCAR_ERR_DWLEN];
+} __packed;
+
+#define NBL_UCAR_GREEN_CELL_ADDR  (0xe84438)
+#define NBL_UCAR_GREEN_CELL_DEPTH (1)
+#define NBL_UCAR_GREEN_CELL_WIDTH (32)
+#define NBL_UCAR_GREEN_CELL_DWLEN (1)
+union ucar_green_cell_u {
+	struct ucar_green_cell {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_UCAR_GREEN_CELL_DWLEN];
+} __packed;
+
+#define NBL_UCAR_YELLOW_CELL_ADDR  (0xe8443c)
+#define NBL_UCAR_YELLOW_CELL_DEPTH (1)
+#define NBL_UCAR_YELLOW_CELL_WIDTH (32)
+#define NBL_UCAR_YELLOW_CELL_DWLEN (1)
+union ucar_yellow_cell_u {
+	struct ucar_yellow_cell {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_UCAR_YELLOW_CELL_DWLEN];
+} __packed;
+
+#define NBL_UCAR_RED_CELL_ADDR  (0xe84440)
+#define NBL_UCAR_RED_CELL_DEPTH (1)
+#define NBL_UCAR_RED_CELL_WIDTH (32)
+#define NBL_UCAR_RED_CELL_DWLEN (1)
+union ucar_red_cell_u {
+	struct ucar_red_cell {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_UCAR_RED_CELL_DWLEN];
+} __packed;
+
+#define NBL_UCAR_NOCAR_PKT_ADDR  (0xe84444)
+#define NBL_UCAR_NOCAR_PKT_DEPTH (1)
+#define NBL_UCAR_NOCAR_PKT_WIDTH (48)
+#define NBL_UCAR_NOCAR_PKT_DWLEN (2)
+union ucar_nocar_pkt_u {
+	struct ucar_nocar_pkt {
+		u32 cnt_l:32;            /* [47:0] Default:0x0 RCTR */
+		u32 cnt_h:16;            /* [47:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_UCAR_NOCAR_PKT_DWLEN];
+} __packed;
+
+#define NBL_UCAR_GREEN_PKT_ADDR  (0xe8444c)
+#define NBL_UCAR_GREEN_PKT_DEPTH (1)
+#define NBL_UCAR_GREEN_PKT_WIDTH (48)
+#define NBL_UCAR_GREEN_PKT_DWLEN (2)
+union ucar_green_pkt_u {
+	struct ucar_green_pkt {
+		u32 cnt_l:32;            /* [47:0] Default:0x0 RCTR */
+		u32 cnt_h:16;            /* [47:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_UCAR_GREEN_PKT_DWLEN];
+} __packed;
+
+#define NBL_UCAR_YELLOW_PKT_ADDR  (0xe84454)
+#define NBL_UCAR_YELLOW_PKT_DEPTH (1)
+#define NBL_UCAR_YELLOW_PKT_WIDTH (48)
+#define NBL_UCAR_YELLOW_PKT_DWLEN (2)
+union ucar_yellow_pkt_u {
+	struct ucar_yellow_pkt {
+		u32 cnt_l:32;            /* [47:0] Default:0x0 RCTR */
+		u32 cnt_h:16;            /* [47:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_UCAR_YELLOW_PKT_DWLEN];
+} __packed;
+
+#define NBL_UCAR_RED_PKT_ADDR  (0xe8445c)
+#define NBL_UCAR_RED_PKT_DEPTH (1)
+#define NBL_UCAR_RED_PKT_WIDTH (48)
+#define NBL_UCAR_RED_PKT_DWLEN (2)
+union ucar_red_pkt_u {
+	struct ucar_red_pkt {
+		u32 cnt_l:32;            /* [47:0] Default:0x0 RCTR */
+		u32 cnt_h:16;            /* [47:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_UCAR_RED_PKT_DWLEN];
+} __packed;
+
+#define NBL_UCAR_FWD_TYPE_WRONG_CELL_ADDR  (0xe84464)
+#define NBL_UCAR_FWD_TYPE_WRONG_CELL_DEPTH (1)
+#define NBL_UCAR_FWD_TYPE_WRONG_CELL_WIDTH (32)
+#define NBL_UCAR_FWD_TYPE_WRONG_CELL_DWLEN (1)
+union ucar_fwd_type_wrong_cell_u {
+	struct ucar_fwd_type_wrong_cell {
+		u32 cnt:32;              /* [31:0] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_UCAR_FWD_TYPE_WRONG_CELL_DWLEN];
+} __packed;
+
+#define NBL_UCAR_FLOW_ADDR  (0xe88000)
+#define NBL_UCAR_FLOW_DEPTH (1024)
+#define NBL_UCAR_FLOW_WIDTH (128)
+#define NBL_UCAR_FLOW_DWLEN (4)
+union ucar_flow_u {
+	struct ucar_flow {
+		u32 valid:1;             /* [0] Default:0x0 RW */
+		u32 depth:19;            /* [19:1] Default:0x0 RW */
+		u32 cir:19;              /* [38:20] Default:0x0 RW */
+		u32 pir:19;              /* [57:39] Default:0x0 RW */
+		u32 cbs:21;              /* [78:58] Default:0x0 RW */
+		u32 pbs:21;              /* [99:79] Default:0x0 RW */
+		u32 rsv:28;              /* [127:100] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_FLOW_DWLEN];
+} __packed;
+#define NBL_UCAR_FLOW_REG(r) (NBL_UCAR_FLOW_ADDR + \
+		(NBL_UCAR_FLOW_DWLEN * 4) * (r))
+
+#define NBL_UCAR_FLOW_4K_ADDR  (0xe94000)
+#define NBL_UCAR_FLOW_4K_DEPTH (4096)
+#define NBL_UCAR_FLOW_4K_WIDTH (128)
+#define NBL_UCAR_FLOW_4K_DWLEN (4)
+union ucar_flow_4k_u {
+	struct ucar_flow_4k {
+		u32 valid:1;             /* [0] Default:0x0 RW */
+		u32 depth:21;            /* [21:1] Default:0x0 RW */
+		u32 cir:21;              /* [42:22] Default:0x0 RW */
+		u32 pir:21;              /* [63:43] Default:0x0 RW */
+		u32 cbs:23;              /* [86:64] Default:0x0 RW */
+		u32 pbs:23;              /* [109:87] Default:0x0 RW */
+		u32 rsv:18;              /* [127:110] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UCAR_FLOW_4K_DWLEN];
+} __packed;
+#define NBL_UCAR_FLOW_4K_REG(r) (NBL_UCAR_FLOW_4K_ADDR + \
+		(NBL_UCAR_FLOW_4K_DWLEN * 4) * (r))
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_upa.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_upa.h
new file mode 100644
index 000000000000..eea7b015fb5a
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_upa.h
@@ -0,0 +1,822 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+// Code generated by interstellar. DO NOT EDIT.
+// Compatible with leonis RTL tag 0710
+
+#ifndef NBL_UPA_H
+#define NBL_UPA_H 1
+
+#include <linux/types.h>
+
+#define NBL_UPA_BASE (0x0008C000)
+
+#define NBL_UPA_INT_STATUS_ADDR  (0x8c000)
+#define NBL_UPA_INT_STATUS_DEPTH (1)
+#define NBL_UPA_INT_STATUS_WIDTH (32)
+#define NBL_UPA_INT_STATUS_DWLEN (1)
+union upa_int_status_u {
+	struct upa_int_status {
+		u32 fatal_err:1;         /* [0] Default:0x0 RWC */
+		u32 fifo_underflow:1;    /* [1] Default:0x0 RWC */
+		u32 fifo_overflow:1;     /* [2] Default:0x0 RWC */
+		u32 fsm_err:1;           /* [3] Default:0x0 RWC */
+		u32 cif_err:1;           /* [4] Default:0x0 RWC */
+		u32 rsv1:1;              /* [5] Default:0x0 RO */
+		u32 cfg_err:1;           /* [6] Default:0x0 RWC */
+		u32 ucor_err:1;          /* [7] Default:0x0 RWC */
+		u32 cor_err:1;           /* [8] Default:0x0 RWC */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_INT_STATUS_DWLEN];
+} __packed;
+
+#define NBL_UPA_INT_MASK_ADDR  (0x8c004)
+#define NBL_UPA_INT_MASK_DEPTH (1)
+#define NBL_UPA_INT_MASK_WIDTH (32)
+#define NBL_UPA_INT_MASK_DWLEN (1)
+union upa_int_mask_u {
+	struct upa_int_mask {
+		u32 fatal_err:1;         /* [0] Default:0x0 RW */
+		u32 fifo_underflow:1;    /* [1] Default:0x0 RW */
+		u32 fifo_overflow:1;     /* [2] Default:0x0 RW */
+		u32 fsm_err:1;           /* [3] Default:0x0 RW */
+		u32 cif_err:1;           /* [4] Default:0x0 RW */
+		u32 rsv1:1;              /* [5] Default:0x0 RO */
+		u32 cfg_err:1;           /* [6] Default:0x0 RW */
+		u32 ucor_err:1;          /* [7] Default:0x0 RW */
+		u32 cor_err:1;           /* [8] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_INT_MASK_DWLEN];
+} __packed;
+
+#define NBL_UPA_INT_SET_ADDR  (0x8c008)
+#define NBL_UPA_INT_SET_DEPTH (1)
+#define NBL_UPA_INT_SET_WIDTH (32)
+#define NBL_UPA_INT_SET_DWLEN (1)
+union upa_int_set_u {
+	struct upa_int_set {
+		u32 fatal_err:1;         /* [0] Default:0x0 WO */
+		u32 fifo_underflow:1;    /* [1] Default:0x0 WO */
+		u32 fifo_overflow:1;     /* [2] Default:0x0 WO */
+		u32 fsm_err:1;           /* [3] Default:0x0 WO */
+		u32 cif_err:1;           /* [4] Default:0x0 WO */
+		u32 rsv1:1;              /* [5] Default:0x0 RO */
+		u32 cfg_err:1;           /* [6] Default:0x0 WO */
+		u32 ucor_err:1;          /* [7] Default:0x0 WO */
+		u32 cor_err:1;           /* [8] Default:0x0 WO */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_INT_SET_DWLEN];
+} __packed;
+
+#define NBL_UPA_INIT_DONE_ADDR  (0x8c00c)
+#define NBL_UPA_INIT_DONE_DEPTH (1)
+#define NBL_UPA_INIT_DONE_WIDTH (32)
+#define NBL_UPA_INIT_DONE_DWLEN (1)
+union upa_init_done_u {
+	struct upa_init_done {
+		u32 done:1;              /* [0] Default:0x0 RO */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_INIT_DONE_DWLEN];
+} __packed;
+
+#define NBL_UPA_CIF_ERR_INFO_ADDR  (0x8c040)
+#define NBL_UPA_CIF_ERR_INFO_DEPTH (1)
+#define NBL_UPA_CIF_ERR_INFO_WIDTH (32)
+#define NBL_UPA_CIF_ERR_INFO_DWLEN (1)
+union upa_cif_err_info_u {
+	struct upa_cif_err_info {
+		u32 addr:30;             /* [29:0] Default:0x0 RO */
+		u32 wr_err:1;            /* [30] Default:0x0 RO */
+		u32 ucor_err:1;          /* [31] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_CIF_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_UPA_CFG_ERR_INFO_ADDR  (0x8c050)
+#define NBL_UPA_CFG_ERR_INFO_DEPTH (1)
+#define NBL_UPA_CFG_ERR_INFO_WIDTH (32)
+#define NBL_UPA_CFG_ERR_INFO_DWLEN (1)
+union upa_cfg_err_info_u {
+	struct upa_cfg_err_info {
+		u32 id0:2;               /* [1:0] Default:0x0 RO */
+		u32 rsv:30;              /* [31:2] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_CFG_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_UPA_CAR_CTRL_ADDR  (0x8c100)
+#define NBL_UPA_CAR_CTRL_DEPTH (1)
+#define NBL_UPA_CAR_CTRL_WIDTH (32)
+#define NBL_UPA_CAR_CTRL_DWLEN (1)
+union upa_car_ctrl_u {
+	struct upa_car_ctrl {
+		u32 sctr_car:1;          /* [0] Default:0x1 RW */
+		u32 rctr_car:1;          /* [1] Default:0x1 RW */
+		u32 rc_car:1;            /* [2] Default:0x1 RW */
+		u32 tbl_rc_car:1;        /* [3] Default:0x1 RW */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_CAR_CTRL_DWLEN];
+} __packed;
+
+#define NBL_UPA_INIT_START_ADDR  (0x8c180)
+#define NBL_UPA_INIT_START_DEPTH (1)
+#define NBL_UPA_INIT_START_WIDTH (32)
+#define NBL_UPA_INIT_START_DWLEN (1)
+union upa_init_start_u {
+	struct upa_init_start {
+		u32 start:1;             /* [0] Default:0x0 WO */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_INIT_START_DWLEN];
+} __packed;
+
+#define NBL_UPA_LAYO_CKSUM0_CTRL_ADDR  (0x8c1b0)
+#define NBL_UPA_LAYO_CKSUM0_CTRL_DEPTH (4)
+#define NBL_UPA_LAYO_CKSUM0_CTRL_WIDTH (32)
+#define NBL_UPA_LAYO_CKSUM0_CTRL_DWLEN (1)
+union upa_layo_cksum0_ctrl_u {
+	struct upa_layo_cksum0_ctrl {
+		u32 data:32;             /* [31:0] Default:0xFFFFFFFF RW */
+	} __packed info;
+	u32 data[NBL_UPA_LAYO_CKSUM0_CTRL_DWLEN];
+} __packed;
+#define NBL_UPA_LAYO_CKSUM0_CTRL_REG(r) (NBL_UPA_LAYO_CKSUM0_CTRL_ADDR + \
+		(NBL_UPA_LAYO_CKSUM0_CTRL_DWLEN * 4) * (r))
+
+#define NBL_UPA_LAYI_CKSUM0_CTRL_ADDR  (0x8c1c0)
+#define NBL_UPA_LAYI_CKSUM0_CTRL_DEPTH (4)
+#define NBL_UPA_LAYI_CKSUM0_CTRL_WIDTH (32)
+#define NBL_UPA_LAYI_CKSUM0_CTRL_DWLEN (1)
+union upa_layi_cksum0_ctrl_u {
+	struct upa_layi_cksum0_ctrl {
+		u32 data:32;             /* [31:0] Default:0xFFFFFFFF RW */
+	} __packed info;
+	u32 data[NBL_UPA_LAYI_CKSUM0_CTRL_DWLEN];
+} __packed;
+#define NBL_UPA_LAYI_CKSUM0_CTRL_REG(r) (NBL_UPA_LAYI_CKSUM0_CTRL_ADDR + \
+		(NBL_UPA_LAYI_CKSUM0_CTRL_DWLEN * 4) * (r))
+
+#define NBL_UPA_FWD_TYPE_STAGE_0_ADDR  (0x8c1d0)
+#define NBL_UPA_FWD_TYPE_STAGE_0_DEPTH (1)
+#define NBL_UPA_FWD_TYPE_STAGE_0_WIDTH (32)
+#define NBL_UPA_FWD_TYPE_STAGE_0_DWLEN (1)
+union upa_fwd_type_stage_0_u {
+	struct upa_fwd_type_stage_0 {
+		u32 tbl:32;              /* [31:0] Default:0xF3FFFFF2 RW */
+	} __packed info;
+	u32 data[NBL_UPA_FWD_TYPE_STAGE_0_DWLEN];
+} __packed;
+
+#define NBL_UPA_FWD_TYPE_STAGE_1_ADDR  (0x8c1d4)
+#define NBL_UPA_FWD_TYPE_STAGE_1_DEPTH (1)
+#define NBL_UPA_FWD_TYPE_STAGE_1_WIDTH (32)
+#define NBL_UPA_FWD_TYPE_STAGE_1_DWLEN (1)
+union upa_fwd_type_stage_1_u {
+	struct upa_fwd_type_stage_1 {
+		u32 tbl:32;              /* [31:0] Default:0xFFFFFFFF RW */
+	} __packed info;
+	u32 data[NBL_UPA_FWD_TYPE_STAGE_1_DWLEN];
+} __packed;
+
+#define NBL_UPA_FWD_TYPE_STAGE_2_ADDR  (0x8c1d8)
+#define NBL_UPA_FWD_TYPE_STAGE_2_DEPTH (1)
+#define NBL_UPA_FWD_TYPE_STAGE_2_WIDTH (32)
+#define NBL_UPA_FWD_TYPE_STAGE_2_DWLEN (1)
+union upa_fwd_type_stage_2_u {
+	struct upa_fwd_type_stage_2 {
+		u32 tbl:32;              /* [31:0] Default:0xFFFFFFFF RW */
+	} __packed info;
+	u32 data[NBL_UPA_FWD_TYPE_STAGE_2_DWLEN];
+} __packed;
+
+#define NBL_UPA_FWD_TYPE_BYPASS_0_ADDR  (0x8c1e0)
+#define NBL_UPA_FWD_TYPE_BYPASS_0_DEPTH (1)
+#define NBL_UPA_FWD_TYPE_BYPASS_0_WIDTH (32)
+#define NBL_UPA_FWD_TYPE_BYPASS_0_DWLEN (1)
+union upa_fwd_type_bypass_0_u {
+	struct upa_fwd_type_bypass_0 {
+		u32 tbl:8;               /* [7:0] Default:0x80 RW */
+		u32 rsv:24;              /* [31:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_FWD_TYPE_BYPASS_0_DWLEN];
+} __packed;
+
+#define NBL_UPA_FWD_TYPE_BYPASS_1_ADDR  (0x8c1e4)
+#define NBL_UPA_FWD_TYPE_BYPASS_1_DEPTH (1)
+#define NBL_UPA_FWD_TYPE_BYPASS_1_WIDTH (32)
+#define NBL_UPA_FWD_TYPE_BYPASS_1_DWLEN (1)
+union upa_fwd_type_bypass_1_u {
+	struct upa_fwd_type_bypass_1 {
+		u32 tbl:8;               /* [7:0] Default:0x80 RW */
+		u32 rsv:24;              /* [31:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_FWD_TYPE_BYPASS_1_DWLEN];
+} __packed;
+
+#define NBL_UPA_FWD_TYPE_BYPASS_2_ADDR  (0x8c1e8)
+#define NBL_UPA_FWD_TYPE_BYPASS_2_DEPTH (1)
+#define NBL_UPA_FWD_TYPE_BYPASS_2_WIDTH (32)
+#define NBL_UPA_FWD_TYPE_BYPASS_2_DWLEN (1)
+union upa_fwd_type_bypass_2_u {
+	struct upa_fwd_type_bypass_2 {
+		u32 tbl:8;               /* [7:0] Default:0x80 RW */
+		u32 rsv:24;              /* [31:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_FWD_TYPE_BYPASS_2_DWLEN];
+} __packed;
+
+#define NBL_UPA_DPORT_EXTRACT_ADDR  (0x8c1ec)
+#define NBL_UPA_DPORT_EXTRACT_DEPTH (1)
+#define NBL_UPA_DPORT_EXTRACT_WIDTH (32)
+#define NBL_UPA_DPORT_EXTRACT_DWLEN (1)
+union upa_dport_extract_u {
+	struct upa_dport_extract {
+		u32 id:6;                /* [5:0] Default:0x9 RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_DPORT_EXTRACT_DWLEN];
+} __packed;
+
+#define NBL_UPA_LAYO_PHV_ADDR  (0x8c1f0)
+#define NBL_UPA_LAYO_PHV_DEPTH (1)
+#define NBL_UPA_LAYO_PHV_WIDTH (32)
+#define NBL_UPA_LAYO_PHV_DWLEN (1)
+union upa_layo_phv_u {
+	struct upa_layo_phv {
+		u32 len:7;               /* [6:0] Default:0x46 RW */
+		u32 change_en:1;         /* [7] Default:0x1 RW */
+		u32 rsv:24;              /* [31:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_LAYO_PHV_DWLEN];
+} __packed;
+
+#define NBL_UPA_L4S_PAD_ADDR  (0x8c1f4)
+#define NBL_UPA_L4S_PAD_DEPTH (1)
+#define NBL_UPA_L4S_PAD_WIDTH (32)
+#define NBL_UPA_L4S_PAD_DWLEN (1)
+union upa_l4s_pad_u {
+	struct upa_l4s_pad {
+		u32 p_length:7;          /* [6:0] Default:0x3C RW */
+		u32 en:1;                /* [7] Default:0x0 RW */
+		u32 rsv:24;              /* [31:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_L4S_PAD_DWLEN];
+} __packed;
+
+#define NBL_UPA_LAYO_FLAG_ADDR  (0x8c1f8)
+#define NBL_UPA_LAYO_FLAG_DEPTH (1)
+#define NBL_UPA_LAYO_FLAG_WIDTH (32)
+#define NBL_UPA_LAYO_FLAG_DWLEN (1)
+union upa_layo_flag_u {
+	struct upa_layo_flag {
+		u32 mask:32;             /* [31:0] Default:0x00 RW */
+	} __packed info;
+	u32 data[NBL_UPA_LAYO_FLAG_DWLEN];
+} __packed;
+
+#define NBL_UPA_IP_EXT_PROTOCOL_ADDR  (0x8c1fc)
+#define NBL_UPA_IP_EXT_PROTOCOL_DEPTH (1)
+#define NBL_UPA_IP_EXT_PROTOCOL_WIDTH (32)
+#define NBL_UPA_IP_EXT_PROTOCOL_DWLEN (1)
+union upa_ip_ext_protocol_u {
+	struct upa_ip_ext_protocol {
+		u32 tcp:8;               /* [7:0] Default:0x6 RW */
+		u32 udp:8;               /* [15:8] Default:0x11 RW */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_IP_EXT_PROTOCOL_DWLEN];
+} __packed;
+
+#define NBL_UPA_L3V6_ML_DA_ADDR  (0x8c204)
+#define NBL_UPA_L3V6_ML_DA_DEPTH (1)
+#define NBL_UPA_L3V6_ML_DA_WIDTH (32)
+#define NBL_UPA_L3V6_ML_DA_DWLEN (1)
+union upa_l3v6_ml_da_u {
+	struct upa_l3v6_ml_da {
+		u32 ml_da:16;            /* [15:0] Default:0x3333 RW */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_L3V6_ML_DA_DWLEN];
+} __packed;
+
+#define NBL_UPA_NEXT_KEY_ADDR  (0x8c208)
+#define NBL_UPA_NEXT_KEY_DEPTH (1)
+#define NBL_UPA_NEXT_KEY_WIDTH (32)
+#define NBL_UPA_NEXT_KEY_DWLEN (1)
+union upa_next_key_u {
+	struct upa_next_key {
+		u32 key_b:8;             /* [7:0] Default:0x10 RW */
+		u32 key_a:8;             /* [15:8] Default:0x0C RW */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_NEXT_KEY_DWLEN];
+} __packed;
+
+#define NBL_UPA_L3_ML_DA_ADDR  (0x8c20c)
+#define NBL_UPA_L3_ML_DA_DEPTH (1)
+#define NBL_UPA_L3_ML_DA_WIDTH (32)
+#define NBL_UPA_L3_ML_DA_DWLEN (1)
+union upa_l3_ml_da_u {
+	struct upa_l3_ml_da {
+		u32 ml_da_0:16;          /* [15:0] Default:0x5e00 RW */
+		u32 ml_da_1:16;          /* [31:16] Default:0x0100 RW */
+	} __packed info;
+	u32 data[NBL_UPA_L3_ML_DA_DWLEN];
+} __packed;
+
+#define NBL_UPA_CK_CTRL_ADDR  (0x8c210)
+#define NBL_UPA_CK_CTRL_DEPTH (1)
+#define NBL_UPA_CK_CTRL_WIDTH (32)
+#define NBL_UPA_CK_CTRL_DWLEN (1)
+union upa_ck_ctrl_u {
+	struct upa_ck_ctrl {
+		u32 tcp_csum_en:1;       /* [0] Default:0x1 RW */
+		u32 udp_csum_en:1;       /* [1] Default:0x1 RW */
+		u32 sctp_crc32c_en:1;    /* [2] Default:0x1 RW */
+		u32 ipv4_ck_en:1;        /* [3] Default:0x1 RW */
+		u32 ipv6_ck_en:1;        /* [4] Default:0x1 RW */
+		u32 DA_ck_en:1;          /* [5] Default:0x1 RW */
+		u32 ipv6_ext_en:1;       /* [6] Default:0x0 RW */
+		u32 vlan_error_en:1;     /* [7] Default:0x1 RW */
+		u32 ctrl_p_en:1;         /* [8] Default:0x0 RW */
+		u32 ip_tlen_ck_en:1;     /* [9] Default:0x0 RW */
+		u32 not_uc_p_plck_aux_en:1; /* [10] Default:0x0 RW */
+		u32 sctp_crc_plck_aux_en:1; /* [11] Default:0x1 RW */
+		u32 tcp_csum_offset_id:2; /* [13:12] Default:0x2 RW */
+		u32 udp_csum_offset_id:2; /* [15:14] Default:0x2 RW */
+		u32 sctp_crc32c_offset_id:2; /* [17:16] Default:0x2 RW */
+		u32 ipv4_ck_offset_id:2; /* [19:18] Default:0x1 RW */
+		u32 ipv6_ck_offset_id:2; /* [21:20] Default:0x1 RW */
+		u32 DA_ck_offset_id:2;   /* [23:22] Default:0x0 RW */
+		u32 plck_offset_id:2;    /* [25:24] Default:0x3 RW */
+		u32 rsv:6;               /* [31:26] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_CK_CTRL_DWLEN];
+} __packed;
+
+#define NBL_UPA_MC_INDEX_ADDR  (0x8c214)
+#define NBL_UPA_MC_INDEX_DEPTH (1)
+#define NBL_UPA_MC_INDEX_WIDTH (32)
+#define NBL_UPA_MC_INDEX_DWLEN (1)
+union upa_mc_index_u {
+	struct upa_mc_index {
+		u32 l2_mc_index:5;       /* [4:0] Default:0x8 RW */
+		u32 rsv2:3;              /* [7:5] Default:0x00 RO */
+		u32 l3_mc_index:5;       /* [12:8] Default:0x9 RW */
+		u32 rsv1:3;              /* [15:13] Default:0x00 RO */
+		u32 ctrl_p_index:5;      /* [20:16] Default:0xF RW */
+		u32 rsv:11;              /* [31:21] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_MC_INDEX_DWLEN];
+} __packed;
+
+#define NBL_UPA_CTRL_P_DA_ADDR  (0x8c218)
+#define NBL_UPA_CTRL_P_DA_DEPTH (1)
+#define NBL_UPA_CTRL_P_DA_WIDTH (32)
+#define NBL_UPA_CTRL_P_DA_DWLEN (1)
+union upa_ctrl_p_da_u {
+	struct upa_ctrl_p_da {
+		u32 ctrl_da_0:16;        /* [15:0] Default:0xC200 RW */
+		u32 ctrl_da_1:16;        /* [31:16] Default:0x0180 RW */
+	} __packed info;
+	u32 data[NBL_UPA_CTRL_P_DA_DWLEN];
+} __packed;
+
+#define NBL_UPA_VLAN_INDEX_ADDR  (0x8c220)
+#define NBL_UPA_VLAN_INDEX_DEPTH (1)
+#define NBL_UPA_VLAN_INDEX_WIDTH (32)
+#define NBL_UPA_VLAN_INDEX_DWLEN (1)
+union upa_vlan_index_u {
+	struct upa_vlan_index {
+		u32 i_vlan2_index:5;     /* [4:0] Default:0x7 RW */
+		u32 rsv3:3;              /* [7:5] Default:0x00 RO */
+		u32 i_vlan1_index:5;     /* [12:8] Default:0x6 RW */
+		u32 rsv2:3;              /* [15:13] Default:0x00 RO */
+		u32 o_vlan2_index:5;     /* [20:16] Default:0x11 RW */
+		u32 rsv1:3;              /* [23:21] Default:0x0 RO */
+		u32 o_vlan1_index:5;     /* [28:24] Default:0x10 RW */
+		u32 rsv:3;               /* [31:29] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_VLAN_INDEX_DWLEN];
+} __packed;
+
+#define NBL_UPA_PRI_VLAN_INDEX_ADDR  (0x8c224)
+#define NBL_UPA_PRI_VLAN_INDEX_DEPTH (1)
+#define NBL_UPA_PRI_VLAN_INDEX_WIDTH (32)
+#define NBL_UPA_PRI_VLAN_INDEX_DWLEN (1)
+union upa_pri_vlan_index_u {
+	struct upa_pri_vlan_index {
+		u32 int_vlan2:7;         /* [6:0] Default:0x30 RW */
+		u32 rsv3:1;              /* [7] Default:0x0 RO */
+		u32 int_vlan1:7;         /* [14:8] Default:0x2E RW */
+		u32 rsv2:1;              /* [15] Default:0x0 RO */
+		u32 ext_vlan2:7;         /* [22:16] Default:0x10 RW */
+		u32 rsv1:1;              /* [23] Default:0x0 RO */
+		u32 ext_vlan1:7;         /* [30:24] Default:0xE RW */
+		u32 rsv:1;               /* [31] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_PRI_VLAN_INDEX_DWLEN];
+} __packed;
+
+#define NBL_UPA_PRI_DSCP_INDEX_ADDR  (0x8c228)
+#define NBL_UPA_PRI_DSCP_INDEX_DEPTH (1)
+#define NBL_UPA_PRI_DSCP_INDEX_WIDTH (32)
+#define NBL_UPA_PRI_DSCP_INDEX_DWLEN (1)
+union upa_pri_dscp_index_u {
+	struct upa_pri_dscp_index {
+		u32 int_dscp:7;          /* [6:0] Default:0x32 RW */
+		u32 rsv3:1;              /* [7] Default:0x0 RO */
+		u32 ext_dscp:7;          /* [14:8] Default:0x12 RW */
+		u32 rsv2:1;              /* [15] Default:0x0 RO */
+		u32 ipv4_flag:5;         /* [20:16] Default:0x1 RW */
+		u32 rsv1:3;              /* [23:21] Default:0x0 RO */
+		u32 ipv6_flag:5;         /* [28:24] Default:0x2 RW */
+		u32 rsv:3;               /* [31:29] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_PRI_DSCP_INDEX_DWLEN];
+} __packed;
+
+#define NBL_UPA_RDMA_INDEX_ADDR  (0x8c22c)
+#define NBL_UPA_RDMA_INDEX_DEPTH (1)
+#define NBL_UPA_RDMA_INDEX_WIDTH (32)
+#define NBL_UPA_RDMA_INDEX_DWLEN (1)
+union upa_rdma_index_u {
+	struct upa_rdma_index {
+		u32 ext_qpn:7;           /* [6:0] Default:0x42 RW */
+		u32 rsv1:1;              /* [7] Default:0x0 RO */
+		u32 rdma_index:5;        /* [12:8] Default:0xA RW */
+		u32 rsv:19;              /* [31:13] Default:0x00 RO */
+	} __packed info;
+	u32 data[NBL_UPA_RDMA_INDEX_DWLEN];
+} __packed;
+
+#define NBL_UPA_PRI_SEL_CONF_ADDR  (0x8c230)
+#define NBL_UPA_PRI_SEL_CONF_DEPTH (5)
+#define NBL_UPA_PRI_SEL_CONF_WIDTH (32)
+#define NBL_UPA_PRI_SEL_CONF_DWLEN (1)
+union upa_pri_sel_conf_u {
+	struct upa_pri_sel_conf {
+		u32 pri_sel:5;           /* [4:0] Default:0x0 RW */
+		u32 pri_default:3;       /* [7:5] Default:0x0 RW */
+		u32 pri_disen:1;         /* [8] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_PRI_SEL_CONF_DWLEN];
+} __packed;
+#define NBL_UPA_PRI_SEL_CONF_REG(r) (NBL_UPA_PRI_SEL_CONF_ADDR + \
+		(NBL_UPA_PRI_SEL_CONF_DWLEN * 4) * (r))
+
+#define NBL_UPA_ERROR_DROP_ADDR  (0x8c248)
+#define NBL_UPA_ERROR_DROP_DEPTH (1)
+#define NBL_UPA_ERROR_DROP_WIDTH (32)
+#define NBL_UPA_ERROR_DROP_DWLEN (1)
+union upa_error_drop_u {
+	struct upa_error_drop {
+		u32 en:7;                /* [6:0] Default:0x0 RW */
+		u32 rsv:25;              /* [31:7] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_ERROR_DROP_DWLEN];
+} __packed;
+
+#define NBL_UPA_ERROR_CODE_ADDR  (0x8c24c)
+#define NBL_UPA_ERROR_CODE_DEPTH (1)
+#define NBL_UPA_ERROR_CODE_WIDTH (32)
+#define NBL_UPA_ERROR_CODE_DWLEN (1)
+union upa_error_code_u {
+	struct upa_error_code {
+		u32 no:32;               /* [31:0] Default:0x09123456 RW */
+	} __packed info;
+	u32 data[NBL_UPA_ERROR_CODE_DWLEN];
+} __packed;
+
+#define NBL_UPA_PTYPE_SCAN_ADDR  (0x8c250)
+#define NBL_UPA_PTYPE_SCAN_DEPTH (1)
+#define NBL_UPA_PTYPE_SCAN_WIDTH (32)
+#define NBL_UPA_PTYPE_SCAN_DWLEN (1)
+union upa_ptype_scan_u {
+	struct upa_ptype_scan {
+		u32 en:1;                /* [0] Default:0x0 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_PTYPE_SCAN_DWLEN];
+} __packed;
+
+#define NBL_UPA_PTYPE_SCAN_TH_ADDR  (0x8c254)
+#define NBL_UPA_PTYPE_SCAN_TH_DEPTH (1)
+#define NBL_UPA_PTYPE_SCAN_TH_WIDTH (32)
+#define NBL_UPA_PTYPE_SCAN_TH_DWLEN (1)
+union upa_ptype_scan_th_u {
+	struct upa_ptype_scan_th {
+		u32 th:32;               /* [31:00] Default:0x40 RW */
+	} __packed info;
+	u32 data[NBL_UPA_PTYPE_SCAN_TH_DWLEN];
+} __packed;
+
+#define NBL_UPA_PTYPE_SCAN_MASK_ADDR  (0x8c258)
+#define NBL_UPA_PTYPE_SCAN_MASK_DEPTH (1)
+#define NBL_UPA_PTYPE_SCAN_MASK_WIDTH (32)
+#define NBL_UPA_PTYPE_SCAN_MASK_DWLEN (1)
+union upa_ptype_scan_mask_u {
+	struct upa_ptype_scan_mask {
+		u32 addr:8;              /* [7:0] Default:0x0 RW */
+		u32 en:1;                /* [8] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_PTYPE_SCAN_MASK_DWLEN];
+} __packed;
+
+#define NBL_UPA_PTYPE_INSERT_SEARCH_ADDR  (0x8c25c)
+#define NBL_UPA_PTYPE_INSERT_SEARCH_DEPTH (1)
+#define NBL_UPA_PTYPE_INSERT_SEARCH_WIDTH (32)
+#define NBL_UPA_PTYPE_INSERT_SEARCH_DWLEN (1)
+union upa_ptype_insert_search_u {
+	struct upa_ptype_insert_search {
+		u32 ctrl:1;              /* [0] Default:0x0 WO */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_PTYPE_INSERT_SEARCH_DWLEN];
+} __packed;
+
+#define NBL_UPA_PTYPE_INSERT_SEARCH_0_ADDR  (0x8c260)
+#define NBL_UPA_PTYPE_INSERT_SEARCH_0_DEPTH (1)
+#define NBL_UPA_PTYPE_INSERT_SEARCH_0_WIDTH (32)
+#define NBL_UPA_PTYPE_INSERT_SEARCH_0_DWLEN (1)
+union upa_ptype_insert_search_0_u {
+	struct upa_ptype_insert_search_0 {
+		u32 key0:32;             /* [31:00] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_UPA_PTYPE_INSERT_SEARCH_0_DWLEN];
+} __packed;
+
+#define NBL_UPA_PTYPE_INSERT_SEARCH_1_ADDR  (0x8c264)
+#define NBL_UPA_PTYPE_INSERT_SEARCH_1_DEPTH (1)
+#define NBL_UPA_PTYPE_INSERT_SEARCH_1_WIDTH (32)
+#define NBL_UPA_PTYPE_INSERT_SEARCH_1_DWLEN (1)
+union upa_ptype_insert_search_1_u {
+	struct upa_ptype_insert_search_1 {
+		u32 key1:32;             /* [31:00] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_UPA_PTYPE_INSERT_SEARCH_1_DWLEN];
+} __packed;
+
+#define NBL_UPA_PTYPE_INSERT_SEARCH_RESULT_ADDR  (0x8c268)
+#define NBL_UPA_PTYPE_INSERT_SEARCH_RESULT_DEPTH (1)
+#define NBL_UPA_PTYPE_INSERT_SEARCH_RESULT_WIDTH (32)
+#define NBL_UPA_PTYPE_INSERT_SEARCH_RESULT_DWLEN (1)
+union upa_ptype_insert_search_result_u {
+	struct upa_ptype_insert_search_result {
+		u32 result:8;            /* [7:0] Default:0x0 RO */
+		u32 hit:1;               /* [8] Default:0x0 RO */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_PTYPE_INSERT_SEARCH_RESULT_DWLEN];
+} __packed;
+
+#define NBL_UPA_PTYPE_INSERT_SEARCH_RESULT_ACK_ADDR  (0x8c270)
+#define NBL_UPA_PTYPE_INSERT_SEARCH_RESULT_ACK_DEPTH (1)
+#define NBL_UPA_PTYPE_INSERT_SEARCH_RESULT_ACK_WIDTH (32)
+#define NBL_UPA_PTYPE_INSERT_SEARCH_RESULT_ACK_DWLEN (1)
+union upa_ptype_insert_search_result_ack_u {
+	struct upa_ptype_insert_search_result_ack {
+		u32 vld:1;               /* [0] Default:0x0 RC */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_PTYPE_INSERT_SEARCH_RESULT_ACK_DWLEN];
+} __packed;
+
+#define NBL_UPA_CFG_TEST_ADDR  (0x8c80c)
+#define NBL_UPA_CFG_TEST_DEPTH (1)
+#define NBL_UPA_CFG_TEST_WIDTH (32)
+#define NBL_UPA_CFG_TEST_DWLEN (1)
+union upa_cfg_test_u {
+	struct upa_cfg_test {
+		u32 test:32;             /* [31:00] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_UPA_CFG_TEST_DWLEN];
+} __packed;
+
+#define NBL_UPA_BP_STATE_ADDR  (0x8cb00)
+#define NBL_UPA_BP_STATE_DEPTH (1)
+#define NBL_UPA_BP_STATE_WIDTH (32)
+#define NBL_UPA_BP_STATE_DWLEN (1)
+union upa_bp_state_u {
+	struct upa_bp_state {
+		u32 pa_rmux_data_bp:1;   /* [0] Default:0x0 RO */
+		u32 pa_rmux_info_bp:1;   /* [1] Default:0x0 RO */
+		u32 store_pa_data_bp:1;  /* [2] Default:0x0 RO */
+		u32 store_pa_info_bp:1;  /* [3] Default:0x0 RO */
+		u32 rx_data_fifo_afull:1; /* [4] Default:0x0 RO */
+		u32 rx_info_fifo_afull:1; /* [5] Default:0x0 RO */
+		u32 rx_ctrl_fifo_afull:1; /* [6] Default:0x0 RO */
+		u32 cinf1_fifo_afull:1;  /* [7] Default:0x0 RO */
+		u32 ctrl_cinf1_fifo_afull:1; /* [8] Default:0x0 RO */
+		u32 layo_info_fifo_afull:1; /* [9] Default:0x0 RO */
+		u32 cinf2_fifo_afull:1;  /* [10] Default:0x0 RO */
+		u32 ctrl_cinf2_fifo_afull:1; /* [11] Default:0x0 RO */
+		u32 layi_info_fifo_afull:1; /* [12] Default:0x0 RO */
+		u32 rsv:19;              /* [31:13] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_BP_STATE_DWLEN];
+} __packed;
+
+#define NBL_UPA_BP_HISTORY_ADDR  (0x8cb04)
+#define NBL_UPA_BP_HISTORY_DEPTH (1)
+#define NBL_UPA_BP_HISTORY_WIDTH (32)
+#define NBL_UPA_BP_HISTORY_DWLEN (1)
+union upa_bp_history_u {
+	struct upa_bp_history {
+		u32 pa_rmux_data_bp:1;   /* [0] Default:0x0 RC */
+		u32 pa_rmux_info_bp:1;   /* [1] Default:0x0 RC */
+		u32 store_pa_data_bp:1;  /* [2] Default:0x0 RC */
+		u32 store_pa_info_bp:1;  /* [3] Default:0x0 RC */
+		u32 rx_data_fifo_afull:1; /* [4] Default:0x0 RC */
+		u32 rx_info_fifo_afull:1; /* [5] Default:0x0 RC */
+		u32 rx_ctrl_fifo_afull:1; /* [6] Default:0x0 RC */
+		u32 cinf1_fifo_afull:1;  /* [7] Default:0x0 RC */
+		u32 ctrl_cinf1_fifo_afull:1; /* [8] Default:0x0 RC */
+		u32 layo_info_fifo_afull:1; /* [9] Default:0x0 RC */
+		u32 cinf2_fifo_afull:1;  /* [10] Default:0x0 RC */
+		u32 ctrl_cinf2_fifo_afull:1; /* [11] Default:0x0 RC */
+		u32 layi_info_fifo_afull:1; /* [12] Default:0x0 RC */
+		u32 rsv:19;              /* [31:13] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_BP_HISTORY_DWLEN];
+} __packed;
+
+#define NBL_UPA_PRI_CONF_TABLE_ADDR  (0x8e000)
+#define NBL_UPA_PRI_CONF_TABLE_DEPTH (40)
+#define NBL_UPA_PRI_CONF_TABLE_WIDTH (32)
+#define NBL_UPA_PRI_CONF_TABLE_DWLEN (1)
+union upa_pri_conf_table_u {
+	struct upa_pri_conf_table {
+		u32 pri0:4;              /* [3:0] Default:0x0 RW */
+		u32 pri1:4;              /* [7:4] Default:0x0 RW */
+		u32 pri2:4;              /* [11:8] Default:0x0 RW */
+		u32 pri3:4;              /* [15:12] Default:0x0 RW */
+		u32 pri4:4;              /* [19:16] Default:0x0 RW */
+		u32 pri5:4;              /* [23:20] Default:0x0 RW */
+		u32 pri6:4;              /* [27:24] Default:0x0 RW */
+		u32 pri7:4;              /* [31:28] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_UPA_PRI_CONF_TABLE_DWLEN];
+} __packed;
+#define NBL_UPA_PRI_CONF_TABLE_REG(r) (NBL_UPA_PRI_CONF_TABLE_ADDR + \
+		(NBL_UPA_PRI_CONF_TABLE_DWLEN * 4) * (r))
+
+#define NBL_UPA_KEY_TCAM_ADDR  (0x8f000)
+#define NBL_UPA_KEY_TCAM_DEPTH (256)
+#define NBL_UPA_KEY_TCAM_WIDTH (64)
+#define NBL_UPA_KEY_TCAM_DWLEN (2)
+union upa_key_tcam_u {
+	struct upa_key_tcam {
+		u32 key_b:16;            /* [15:0] Default:0x0 RW */
+		u32 key_a:16;            /* [31:16] Default:0x0 RW */
+		u32 key_valid:1;         /* [32] Default:0x0 RW */
+		u32 rsv:31;              /* [63:33] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_KEY_TCAM_DWLEN];
+} __packed;
+#define NBL_UPA_KEY_TCAM_REG(r) (NBL_UPA_KEY_TCAM_ADDR + \
+		(NBL_UPA_KEY_TCAM_DWLEN * 4) * (r))
+
+#define NBL_UPA_MASK_TCAM_ADDR  (0x8f800)
+#define NBL_UPA_MASK_TCAM_DEPTH (256)
+#define NBL_UPA_MASK_TCAM_WIDTH (32)
+#define NBL_UPA_MASK_TCAM_DWLEN (1)
+union upa_mask_tcam_u {
+	struct upa_mask_tcam {
+		u32 mask_b:16;           /* [15:0] Default:0x0 RW */
+		u32 mask_a:16;           /* [31:16] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_UPA_MASK_TCAM_DWLEN];
+} __packed;
+#define NBL_UPA_MASK_TCAM_REG(r) (NBL_UPA_MASK_TCAM_ADDR + \
+		(NBL_UPA_MASK_TCAM_DWLEN * 4) * (r))
+
+#define NBL_UPA_ACT_TABLE_ADDR  (0x90000)
+#define NBL_UPA_ACT_TABLE_DEPTH (256)
+#define NBL_UPA_ACT_TABLE_WIDTH (128)
+#define NBL_UPA_ACT_TABLE_DWLEN (4)
+union upa_act_table_u {
+	struct upa_act_table {
+		u32 flag_control_0:8;    /* [7:0] Default:0x0 RW */
+		u32 flag_control_1:8;    /* [15:8] Default:0x0 RW */
+		u32 flag_control_2:8;    /* [23:16] Default:0x0 RW */
+		u32 legality_check:8;    /* [31:24] Default:0x0 RW */
+		u32 nxt_off_B:8;         /* [39:32] Default:0x0 RW */
+		u32 nxt_off_A:8;         /* [47:40] Default:0x0 RW */
+		u32 protocol_header_off:8; /* [55:48] Default:0x0 RW */
+		u32 payload_length:8;    /* [63:56] Default:0x0 RW */
+		u32 mask:8;              /* [71:64] Default:0x0 RW */
+		u32 nxt_stg:4;           /* [75:72] Default:0x0 RW */
+		u32 rsv_l:32;            /* [127:76] Default:0x0 RO */
+		u32 rsv_h:20;            /* [127:76] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_ACT_TABLE_DWLEN];
+} __packed;
+#define NBL_UPA_ACT_TABLE_REG(r) (NBL_UPA_ACT_TABLE_ADDR + \
+		(NBL_UPA_ACT_TABLE_DWLEN * 4) * (r))
+
+#define NBL_UPA_EXT_CONF_TABLE_ADDR  (0x91000)
+#define NBL_UPA_EXT_CONF_TABLE_DEPTH (1024)
+#define NBL_UPA_EXT_CONF_TABLE_WIDTH (32)
+#define NBL_UPA_EXT_CONF_TABLE_DWLEN (1)
+union upa_ext_conf_table_u {
+	struct upa_ext_conf_table {
+		u32 dst_offset:8;        /* [7:0] Default:0x0 RW */
+		u32 source_offset:6;     /* [13:8] Default:0x0 RW */
+		u32 mode_start_off:2;    /* [15:14] Default:0x0 RW */
+		u32 lx_sel:2;            /* [17:16] Default:0x0 RW */
+		u32 mode_sel:1;          /* [18] Default:0x0 RW */
+		u32 op_en:1;             /* [19] Default:0x0 RW */
+		u32 rsv:8;               /* [31:24] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_EXT_CONF_TABLE_DWLEN];
+} __packed;
+#define NBL_UPA_EXT_CONF_TABLE_REG(r) (NBL_UPA_EXT_CONF_TABLE_ADDR + \
+		(NBL_UPA_EXT_CONF_TABLE_DWLEN * 4) * (r))
+
+#define NBL_UPA_EXT_INDEX_TCAM_ADDR  (0x92000)
+#define NBL_UPA_EXT_INDEX_TCAM_DEPTH (64)
+#define NBL_UPA_EXT_INDEX_TCAM_WIDTH (64)
+#define NBL_UPA_EXT_INDEX_TCAM_DWLEN (2)
+union upa_ext_index_tcam_u {
+	struct upa_ext_index_tcam {
+		u32 type_index:32;       /* [31:0] Default:0x0 RW */
+		u32 type_valid:1;        /* [32] Default:0x0 RW */
+		u32 rsv:31;              /* [63:33] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_EXT_INDEX_TCAM_DWLEN];
+} __packed;
+#define NBL_UPA_EXT_INDEX_TCAM_REG(r) (NBL_UPA_EXT_INDEX_TCAM_ADDR + \
+		(NBL_UPA_EXT_INDEX_TCAM_DWLEN * 4) * (r))
+
+#define NBL_UPA_EXT_INDEX_TCAM_MASK_ADDR  (0x92200)
+#define NBL_UPA_EXT_INDEX_TCAM_MASK_DEPTH (64)
+#define NBL_UPA_EXT_INDEX_TCAM_MASK_WIDTH (32)
+#define NBL_UPA_EXT_INDEX_TCAM_MASK_DWLEN (1)
+union upa_ext_index_tcam_mask_u {
+	struct upa_ext_index_tcam_mask {
+		u32 mask:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_UPA_EXT_INDEX_TCAM_MASK_DWLEN];
+} __packed;
+#define NBL_UPA_EXT_INDEX_TCAM_MASK_REG(r) (NBL_UPA_EXT_INDEX_TCAM_MASK_ADDR + \
+		(NBL_UPA_EXT_INDEX_TCAM_MASK_DWLEN * 4) * (r))
+
+#define NBL_UPA_EXT_INDEX_TABLE_ADDR  (0x92300)
+#define NBL_UPA_EXT_INDEX_TABLE_DEPTH (64)
+#define NBL_UPA_EXT_INDEX_TABLE_WIDTH (32)
+#define NBL_UPA_EXT_INDEX_TABLE_DWLEN (1)
+union upa_ext_index_table_u {
+	struct upa_ext_index_table {
+		u32 p_index:3;           /* [2:0] Default:0x0 RW */
+		u32 rsv:29;              /* [31:3] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_EXT_INDEX_TABLE_DWLEN];
+} __packed;
+#define NBL_UPA_EXT_INDEX_TABLE_REG(r) (NBL_UPA_EXT_INDEX_TABLE_ADDR + \
+		(NBL_UPA_EXT_INDEX_TABLE_DWLEN * 4) * (r))
+
+#define NBL_UPA_TYPE_INDEX_TCAM_ADDR  (0x94000)
+#define NBL_UPA_TYPE_INDEX_TCAM_DEPTH (256)
+#define NBL_UPA_TYPE_INDEX_TCAM_WIDTH (256)
+#define NBL_UPA_TYPE_INDEX_TCAM_DWLEN (8)
+union upa_type_index_tcam_u {
+	struct upa_type_index_tcam {
+		u32 layi_x:32;           /* [31:0] Default:0xFFFFFFFF RW */
+		u32 layo_x:32;           /* [63:32] Default:0xFFFFFFFF RW */
+		u32 layi_y:32;           /* [95:64] Default:0xFFFFFFFF RW */
+		u32 layo_y:32;           /* [127:96] Default:0xFFFFFFFF RW */
+		u32 type_valid:1;        /* [128] Default:0x0 RW */
+		u32 rsv_l:32;            /* [255:129] Default:0x0 RO */
+		u32 rsv_h:31;            /* [255:129] Default:0x0 RO */
+		u32 rsv_arr[2];          /* [255:129] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_TYPE_INDEX_TCAM_DWLEN];
+} __packed;
+#define NBL_UPA_TYPE_INDEX_TCAM_REG(r) (NBL_UPA_TYPE_INDEX_TCAM_ADDR + \
+		(NBL_UPA_TYPE_INDEX_TCAM_DWLEN * 4) * (r))
+
+#define NBL_UPA_PACKET_TYPE_TABLE_ADDR  (0x96000)
+#define NBL_UPA_PACKET_TYPE_TABLE_DEPTH (256)
+#define NBL_UPA_PACKET_TYPE_TABLE_WIDTH (32)
+#define NBL_UPA_PACKET_TYPE_TABLE_DWLEN (1)
+union upa_packet_type_table_u {
+	struct upa_packet_type_table {
+		u32 p_type:8;            /* [7:0] Default:0x0 RW */
+		u32 rsv:24;              /* [31:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPA_PACKET_TYPE_TABLE_DWLEN];
+} __packed;
+#define NBL_UPA_PACKET_TYPE_TABLE_REG(r) (NBL_UPA_PACKET_TYPE_TABLE_ADDR + \
+		(NBL_UPA_PACKET_TYPE_TABLE_DWLEN * 4) * (r))
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_uped.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_uped.h
new file mode 100644
index 000000000000..7168ba777677
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_datapath_uped.h
@@ -0,0 +1,1499 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+// Code generated by interstellar. DO NOT EDIT.
+// Compatible with leonis RTL tag 0710
+
+#ifndef NBL_UPED_H
+#define NBL_UPED_H 1
+
+#include <linux/types.h>
+
+#define NBL_UPED_BASE (0x0015C000)
+
+#define NBL_UPED_INT_STATUS_ADDR  (0x15c000)
+#define NBL_UPED_INT_STATUS_DEPTH (1)
+#define NBL_UPED_INT_STATUS_WIDTH (32)
+#define NBL_UPED_INT_STATUS_DWLEN (1)
+union uped_int_status_u {
+	struct uped_int_status {
+		u32 pkt_length_err:1;    /* [0] Default:0x0 RWC */
+		u32 fifo_uflw_err:1;     /* [1] Default:0x0 RWC */
+		u32 fifo_dflw_err:1;     /* [2] Default:0x0 RWC */
+		u32 fsm_err:1;           /* [3] Default:0x0 RWC */
+		u32 cif_err:1;           /* [4] Default:0x0 RWC */
+		u32 input_err:1;         /* [5] Default:0x0 RWC */
+		u32 cfg_err:1;           /* [6] Default:0x0 RWC */
+		u32 data_ucor_err:1;     /* [7] Default:0x0 RWC */
+		u32 inmeta_ucor_err:1;   /* [8] Default:0x0 RWC */
+		u32 meta_ucor_err:1;     /* [9] Default:0x0 RWC */
+		u32 meta_cor_ecc_err:1;  /* [10] Default:0x0 RWC */
+		u32 fwd_atid_nomat_err:1; /* [11] Default:0x0 RWC */
+		u32 meta_value_err:1;    /* [12] Default:0x0 RWC */
+		u32 edit_atnum_err:1;    /* [13] Default:0x0 RWC */
+		u32 header_oft_ovf:1;    /* [14] Default:0x0 RWC */
+		u32 edit_pos_err:1;      /* [15] Default:0x0 RWC */
+		u32 da_oft_len_ovf:1;    /* [16] Default:0x0 RWC */
+		u32 lxoffset_ovf:1;      /* [17] Default:0x0 RWC */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_INT_STATUS_DWLEN];
+} __packed;
+
+#define NBL_UPED_INT_MASK_ADDR  (0x15c004)
+#define NBL_UPED_INT_MASK_DEPTH (1)
+#define NBL_UPED_INT_MASK_WIDTH (32)
+#define NBL_UPED_INT_MASK_DWLEN (1)
+union uped_int_mask_u {
+	struct uped_int_mask {
+		u32 pkt_length_err:1;    /* [0] Default:0x0 RW */
+		u32 fifo_uflw_err:1;     /* [1] Default:0x0 RW */
+		u32 fifo_dflw_err:1;     /* [2] Default:0x0 RW */
+		u32 fsm_err:1;           /* [3] Default:0x0 RW */
+		u32 cif_err:1;           /* [4] Default:0x0 RW */
+		u32 input_err:1;         /* [5] Default:0x0 RW */
+		u32 cfg_err:1;           /* [6] Default:0x0 RW */
+		u32 data_ucor_err:1;     /* [7] Default:0x0 RW */
+		u32 inmeta_ucor_err:1;   /* [8] Default:0x0 RW */
+		u32 meta_ucor_err:1;     /* [9] Default:0x0 RW */
+		u32 meta_cor_ecc_err:1;  /* [10] Default:0x0 RW */
+		u32 fwd_atid_nomat_err:1; /* [11] Default:0x1 RW */
+		u32 meta_value_err:1;    /* [12] Default:0x0 RW */
+		u32 edit_atnum_err:1;    /* [13] Default:0x0 RW */
+		u32 header_oft_ovf:1;    /* [14] Default:0x0 RW */
+		u32 edit_pos_err:1;      /* [15] Default:0x0 RW */
+		u32 da_oft_len_ovf:1;    /* [16] Default:0x0 RW */
+		u32 lxoffset_ovf:1;      /* [17] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_INT_MASK_DWLEN];
+} __packed;
+
+#define NBL_UPED_INT_SET_ADDR  (0x15c008)
+#define NBL_UPED_INT_SET_DEPTH (1)
+#define NBL_UPED_INT_SET_WIDTH (32)
+#define NBL_UPED_INT_SET_DWLEN (1)
+union uped_int_set_u {
+	struct uped_int_set {
+		u32 pkt_length_err:1;    /* [0] Default:0x0 WO */
+		u32 fifo_uflw_err:1;     /* [1] Default:0x0 WO */
+		u32 fifo_dflw_err:1;     /* [2] Default:0x0 WO */
+		u32 fsm_err:1;           /* [3] Default:0x0 WO */
+		u32 cif_err:1;           /* [4] Default:0x0 WO */
+		u32 input_err:1;         /* [5] Default:0x0 WO */
+		u32 cfg_err:1;           /* [6] Default:0x0 WO */
+		u32 data_ucor_err:1;     /* [7] Default:0x0 WO */
+		u32 inmeta_ucor_err:1;   /* [8] Default:0x0 WO */
+		u32 meta_ucor_err:1;     /* [9] Default:0x0 WO */
+		u32 meta_cor_ecc_err:1;  /* [10] Default:0x0 WO */
+		u32 fwd_atid_nomat_err:1; /* [11] Default:0x0 WO */
+		u32 meta_value_err:1;    /* [12] Default:0x0 WO */
+		u32 edit_atnum_err:1;    /* [13] Default:0x0 WO */
+		u32 header_oft_ovf:1;    /* [14] Default:0x0 WO */
+		u32 edit_pos_err:1;      /* [15] Default:0x0 WO */
+		u32 da_oft_len_ovf:1;    /* [16] Default:0x0 WO */
+		u32 lxoffset_ovf:1;      /* [17] Default:0x0 WO */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_INT_SET_DWLEN];
+} __packed;
+
+#define NBL_UPED_INIT_DONE_ADDR  (0x15c00c)
+#define NBL_UPED_INIT_DONE_DEPTH (1)
+#define NBL_UPED_INIT_DONE_WIDTH (32)
+#define NBL_UPED_INIT_DONE_DWLEN (1)
+union uped_init_done_u {
+	struct uped_init_done {
+		u32 done:1;              /* [00:00] Default:0x0 RO */
+		u32 rsv:31;              /* [31:01] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_INIT_DONE_DWLEN];
+} __packed;
+
+#define NBL_UPED_PKT_LENGTH_ERR_INFO_ADDR  (0x15c020)
+#define NBL_UPED_PKT_LENGTH_ERR_INFO_DEPTH (1)
+#define NBL_UPED_PKT_LENGTH_ERR_INFO_WIDTH (32)
+#define NBL_UPED_PKT_LENGTH_ERR_INFO_DWLEN (1)
+union uped_pkt_length_err_info_u {
+	struct uped_pkt_length_err_info {
+		u32 ptr_eop:1;           /* [0] Default:0x0 RC */
+		u32 pkt_eop:1;           /* [1] Default:0x0 RC */
+		u32 pkt_mod:1;           /* [2] Default:0x0 RC */
+		u32 rsv:29;              /* [31:3] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_PKT_LENGTH_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_UPED_CIF_ERR_INFO_ADDR  (0x15c040)
+#define NBL_UPED_CIF_ERR_INFO_DEPTH (1)
+#define NBL_UPED_CIF_ERR_INFO_WIDTH (32)
+#define NBL_UPED_CIF_ERR_INFO_DWLEN (1)
+union uped_cif_err_info_u {
+	struct uped_cif_err_info {
+		u32 addr:30;             /* [29:0] Default:0x0 RO */
+		u32 wr_err:1;            /* [30] Default:0x0 RO */
+		u32 ucor_err:1;          /* [31] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_CIF_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_UPED_INPUT_ERR_INFO_ADDR  (0x15c048)
+#define NBL_UPED_INPUT_ERR_INFO_DEPTH (1)
+#define NBL_UPED_INPUT_ERR_INFO_WIDTH (32)
+#define NBL_UPED_INPUT_ERR_INFO_DWLEN (1)
+union uped_input_err_info_u {
+	struct uped_input_err_info {
+		u32 eoc_miss:1;          /* [0] Default:0x0 RC */
+		u32 soc_miss:1;          /* [1] Default:0x0 RC */
+		u32 rsv:30;              /* [31:2] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_INPUT_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_UPED_CFG_ERR_INFO_ADDR  (0x15c050)
+#define NBL_UPED_CFG_ERR_INFO_DEPTH (1)
+#define NBL_UPED_CFG_ERR_INFO_WIDTH (32)
+#define NBL_UPED_CFG_ERR_INFO_DWLEN (1)
+union uped_cfg_err_info_u {
+	struct uped_cfg_err_info {
+		u32 length:1;            /* [0] Default:0x0 RC */
+		u32 rd_conflict:1;       /* [1] Default:0x0 RC */
+		u32 rd_addr:8;           /* [9:2] Default:0x0 RC */
+		u32 rsv:22;              /* [31:10] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_CFG_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_UPED_FWD_ATID_NOMAT_ERR_INFO_ADDR  (0x15c06c)
+#define NBL_UPED_FWD_ATID_NOMAT_ERR_INFO_DEPTH (1)
+#define NBL_UPED_FWD_ATID_NOMAT_ERR_INFO_WIDTH (32)
+#define NBL_UPED_FWD_ATID_NOMAT_ERR_INFO_DWLEN (1)
+union uped_fwd_atid_nomat_err_info_u {
+	struct uped_fwd_atid_nomat_err_info {
+		u32 dport:1;             /* [0] Default:0x0 RC */
+		u32 dqueue:1;            /* [1] Default:0x0 RC */
+		u32 hash0:1;             /* [2] Default:0x0 RC */
+		u32 hash1:1;             /* [3] Default:0x0 RC */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_FWD_ATID_NOMAT_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_UPED_META_VALUE_ERR_INFO_ADDR  (0x15c070)
+#define NBL_UPED_META_VALUE_ERR_INFO_DEPTH (1)
+#define NBL_UPED_META_VALUE_ERR_INFO_WIDTH (32)
+#define NBL_UPED_META_VALUE_ERR_INFO_DWLEN (1)
+union uped_meta_value_err_info_u {
+	struct uped_meta_value_err_info {
+		u32 sport:1;             /* [0] Default:0x0 RC */
+		u32 dport:1;             /* [1] Default:0x0 RC */
+		u32 dscp_ecn:1;          /* [2] Default:0x0 RC */
+		u32 rsv:29;              /* [31:3] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_META_VALUE_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_UPED_EDIT_ATNUM_ERR_INFO_ADDR  (0x15c078)
+#define NBL_UPED_EDIT_ATNUM_ERR_INFO_DEPTH (1)
+#define NBL_UPED_EDIT_ATNUM_ERR_INFO_WIDTH (32)
+#define NBL_UPED_EDIT_ATNUM_ERR_INFO_DWLEN (1)
+union uped_edit_atnum_err_info_u {
+	struct uped_edit_atnum_err_info {
+		u32 replace:1;           /* [0] Default:0x0 RC */
+		u32 del_add:1;           /* [1] Default:0x0 RC */
+		u32 ttl:1;               /* [2] Default:0x0 RC */
+		u32 dscp:1;              /* [3] Default:0x0 RC */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_EDIT_ATNUM_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_UPED_HEADER_OFT_OVF_ADDR  (0x15c080)
+#define NBL_UPED_HEADER_OFT_OVF_DEPTH (1)
+#define NBL_UPED_HEADER_OFT_OVF_WIDTH (32)
+#define NBL_UPED_HEADER_OFT_OVF_DWLEN (1)
+union uped_header_oft_ovf_u {
+	struct uped_header_oft_ovf {
+		u32 replace:1;           /* [0] Default:0x0 RC */
+		u32 rsv2:7;              /* [7:1] Default:0x0 RO */
+		u32 add_del:6;           /* [13:8] Default:0x0 RC */
+		u32 dscp_ecn:1;          /* [14] Default:0x0 RC */
+		u32 rsv1:1;              /* [15] Default:0x0 RO */
+		u32 ttl:1;               /* [16] Default:0x0 RC */
+		u32 sctp:1;              /* [17] Default:0x0 RC */
+		u32 ck_len0:1;           /* [18] Default:0x0 RC */
+		u32 ck_len1:1;           /* [19] Default:0x0 RC */
+		u32 len0:1;              /* [20] Default:0x0 RC */
+		u32 len1:1;              /* [21] Default:0x0 RC */
+		u32 ck0:1;               /* [22] Default:0x0 RC */
+		u32 ck1:1;               /* [23] Default:0x0 RC */
+		u32 ck_start0_0:1;       /* [24] Default:0x0 RC */
+		u32 ck_start0_1:1;       /* [25] Default:0x0 RC */
+		u32 ck_start1_0:1;       /* [26] Default:0x0 RC */
+		u32 ck_start1_1:1;       /* [27] Default:0x0 RC */
+		u32 head:1;              /* [28] Default:0x0 RC */
+		u32 head_out:1;          /* [29] Default:0x0 RC */
+		u32 l4_head:1;           /* [30] Default:0x0 RC */
+		u32 rsv:1;               /* [31] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_HEADER_OFT_OVF_DWLEN];
+} __packed;
+
+#define NBL_UPED_EDIT_POS_ERR_ADDR  (0x15c088)
+#define NBL_UPED_EDIT_POS_ERR_DEPTH (1)
+#define NBL_UPED_EDIT_POS_ERR_WIDTH (32)
+#define NBL_UPED_EDIT_POS_ERR_DWLEN (1)
+union uped_edit_pos_err_u {
+	struct uped_edit_pos_err {
+		u32 replace:1;           /* [0] Default:0x0 RC */
+		u32 cross_level:6;       /* [6:1] Default:0x0 RC */
+		u32 rsv2:1;              /* [7] Default:0x0 RO */
+		u32 add_del:6;           /* [13:8] Default:0x0 RC */
+		u32 dscp_ecn:1;          /* [14] Default:0x0 RC */
+		u32 rsv1:1;              /* [15] Default:0x0 RO */
+		u32 ttl:1;               /* [16] Default:0x0 RC */
+		u32 sctp:1;              /* [17] Default:0x0 RC */
+		u32 ck_len0:1;           /* [18] Default:0x0 RC */
+		u32 ck_len1:1;           /* [19] Default:0x0 RC */
+		u32 len0:1;              /* [20] Default:0x0 RC */
+		u32 len1:1;              /* [21] Default:0x0 RC */
+		u32 ck0:1;               /* [22] Default:0x0 RC */
+		u32 ck1:1;               /* [23] Default:0x0 RC */
+		u32 ck_start0_0:1;       /* [24] Default:0x0 RC */
+		u32 ck_start0_1:1;       /* [25] Default:0x0 RC */
+		u32 ck_start1_0:1;       /* [26] Default:0x0 RC */
+		u32 ck_start1_1:1;       /* [27] Default:0x0 RC */
+		u32 bth_header:1;        /* [28] Default:0x0 RC */
+		u32 rsv:3;               /* [31:29] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_EDIT_POS_ERR_DWLEN];
+} __packed;
+
+#define NBL_UPED_DA_OFT_LEN_OVF_ADDR  (0x15c090)
+#define NBL_UPED_DA_OFT_LEN_OVF_DEPTH (1)
+#define NBL_UPED_DA_OFT_LEN_OVF_WIDTH (32)
+#define NBL_UPED_DA_OFT_LEN_OVF_DWLEN (1)
+union uped_da_oft_len_ovf_u {
+	struct uped_da_oft_len_ovf {
+		u32 at0:5;               /* [4:0] Default:0x0 RC */
+		u32 at1:5;               /* [9:5] Default:0x0 RC */
+		u32 at2:5;               /* [14:10] Default:0x0 RC */
+		u32 at3:5;               /* [19:15] Default:0x0 RC */
+		u32 at4:5;               /* [24:20] Default:0x0 RC */
+		u32 at5:5;               /* [29:25] Default:0x0 RC */
+		u32 rsv:2;               /* [31:30] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_DA_OFT_LEN_OVF_DWLEN];
+} __packed;
+
+#define NBL_UPED_LXOFFSET_OVF_ADDR  (0x15c098)
+#define NBL_UPED_LXOFFSET_OVF_DEPTH (1)
+#define NBL_UPED_LXOFFSET_OVF_WIDTH (32)
+#define NBL_UPED_LXOFFSET_OVF_DWLEN (1)
+union uped_lxoffset_ovf_u {
+	struct uped_lxoffset_ovf {
+		u32 l2:1;                /* [0] Default:0x0 RC */
+		u32 l3:1;                /* [1] Default:0x0 RC */
+		u32 l4:1;                /* [2] Default:0x0 RC */
+		u32 pld:1;               /* [3] Default:0x0 RC */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_LXOFFSET_OVF_DWLEN];
+} __packed;
+
+#define NBL_UPED_CAR_CTRL_ADDR  (0x15c100)
+#define NBL_UPED_CAR_CTRL_DEPTH (1)
+#define NBL_UPED_CAR_CTRL_WIDTH (32)
+#define NBL_UPED_CAR_CTRL_DWLEN (1)
+union uped_car_ctrl_u {
+	struct uped_car_ctrl {
+		u32 sctr_car:1;          /* [00:00] Default:0x1 RW */
+		u32 rctr_car:1;          /* [01:01] Default:0x1 RW */
+		u32 rc_car:1;            /* [02:02] Default:0x1 RW */
+		u32 tbl_rc_car:1;        /* [03:03] Default:0x1 RW */
+		u32 rsv:28;              /* [31:04] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_CAR_CTRL_DWLEN];
+} __packed;
+
+#define NBL_UPED_INIT_START_ADDR  (0x15c10c)
+#define NBL_UPED_INIT_START_DEPTH (1)
+#define NBL_UPED_INIT_START_WIDTH (32)
+#define NBL_UPED_INIT_START_DWLEN (1)
+union uped_init_start_u {
+	struct uped_init_start {
+		u32 start:1;             /* [00:00] Default:0x0 WO */
+		u32 rsv:31;              /* [31:01] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_INIT_START_DWLEN];
+} __packed;
+
+#define NBL_UPED_TIMEOUT_CFG_ADDR  (0x15c110)
+#define NBL_UPED_TIMEOUT_CFG_DEPTH (1)
+#define NBL_UPED_TIMEOUT_CFG_WIDTH (32)
+#define NBL_UPED_TIMEOUT_CFG_DWLEN (1)
+union uped_timeout_cfg_u {
+	struct uped_timeout_cfg {
+		u32 fsm_max_num:16;      /* [15:00] Default:0xfff RW */
+		u32 tab:8;               /* [23:16] Default:0x40 RW */
+		u32 rsv:8;               /* [31:24] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_TIMEOUT_CFG_DWLEN];
+} __packed;
+
+#define NBL_UPED_PKT_DROP_EN_ADDR  (0x15c170)
+#define NBL_UPED_PKT_DROP_EN_DEPTH (1)
+#define NBL_UPED_PKT_DROP_EN_WIDTH (32)
+#define NBL_UPED_PKT_DROP_EN_DWLEN (1)
+union uped_pkt_drop_en_u {
+	struct uped_pkt_drop_en {
+		u32 en:1;                /* [0] Default:0x1 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_PKT_DROP_EN_DWLEN];
+} __packed;
+
+#define NBL_UPED_PKT_HERR_DROP_EN_ADDR  (0x15c174)
+#define NBL_UPED_PKT_HERR_DROP_EN_DEPTH (1)
+#define NBL_UPED_PKT_HERR_DROP_EN_WIDTH (32)
+#define NBL_UPED_PKT_HERR_DROP_EN_DWLEN (1)
+union uped_pkt_herr_drop_en_u {
+	struct uped_pkt_herr_drop_en {
+		u32 en:1;                /* [0] Default:0x1 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_PKT_HERR_DROP_EN_DWLEN];
+} __packed;
+
+#define NBL_UPED_PKT_PARITY_DROP_EN_ADDR  (0x15c178)
+#define NBL_UPED_PKT_PARITY_DROP_EN_DEPTH (1)
+#define NBL_UPED_PKT_PARITY_DROP_EN_WIDTH (32)
+#define NBL_UPED_PKT_PARITY_DROP_EN_DWLEN (1)
+union uped_pkt_parity_drop_en_u {
+	struct uped_pkt_parity_drop_en {
+		u32 en0:1;               /* [0] Default:0x1 RW */
+		u32 en1:1;               /* [1] Default:0x1 RW */
+		u32 rsv:30;              /* [31:2] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_PKT_PARITY_DROP_EN_DWLEN];
+} __packed;
+
+#define NBL_UPED_TTL_DROP_EN_ADDR  (0x15c17c)
+#define NBL_UPED_TTL_DROP_EN_DEPTH (1)
+#define NBL_UPED_TTL_DROP_EN_WIDTH (32)
+#define NBL_UPED_TTL_DROP_EN_DWLEN (1)
+union uped_ttl_drop_en_u {
+	struct uped_ttl_drop_en {
+		u32 en:1;                /* [0] Default:0x1 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_TTL_DROP_EN_DWLEN];
+} __packed;
+
+#define NBL_UPED_DQUEUE_DROP_EN_ADDR  (0x15c180)
+#define NBL_UPED_DQUEUE_DROP_EN_DEPTH (1)
+#define NBL_UPED_DQUEUE_DROP_EN_WIDTH (32)
+#define NBL_UPED_DQUEUE_DROP_EN_DWLEN (1)
+union uped_dqueue_drop_en_u {
+	struct uped_dqueue_drop_en {
+		u32 en:1;                /* [0] Default:0x1 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_DQUEUE_DROP_EN_DWLEN];
+} __packed;
+
+#define NBL_UPED_INTF_ECC_ERR_EN_ADDR  (0x15c184)
+#define NBL_UPED_INTF_ECC_ERR_EN_DEPTH (1)
+#define NBL_UPED_INTF_ECC_ERR_EN_WIDTH (32)
+#define NBL_UPED_INTF_ECC_ERR_EN_DWLEN (1)
+union uped_intf_ecc_err_en_u {
+	struct uped_intf_ecc_err_en {
+		u32 en:1;                /* [0] Default:0x1 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_INTF_ECC_ERR_EN_DWLEN];
+} __packed;
+
+#define NBL_UPED_TTL_ERROR_CODE_ADDR  (0x15c188)
+#define NBL_UPED_TTL_ERROR_CODE_DEPTH (1)
+#define NBL_UPED_TTL_ERROR_CODE_WIDTH (32)
+#define NBL_UPED_TTL_ERROR_CODE_DWLEN (1)
+union uped_ttl_error_code_u {
+	struct uped_ttl_error_code {
+		u32 en:1;                /* [0] Default:0x1 RW */
+		u32 rsv1:7;              /* [7:1] Default:0x0 RO */
+		u32 id:4;                /* [11:8] Default:0x6 RW */
+		u32 rsv:20;              /* [31:12] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_TTL_ERROR_CODE_DWLEN];
+} __packed;
+
+#define NBL_UPED_HIGH_PRI_PKT_EN_ADDR  (0x15c190)
+#define NBL_UPED_HIGH_PRI_PKT_EN_DEPTH (1)
+#define NBL_UPED_HIGH_PRI_PKT_EN_WIDTH (32)
+#define NBL_UPED_HIGH_PRI_PKT_EN_DWLEN (1)
+union uped_high_pri_pkt_en_u {
+	struct uped_high_pri_pkt_en {
+		u32 en:1;                /* [0] Default:0x0 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_HIGH_PRI_PKT_EN_DWLEN];
+} __packed;
+
+#define NBL_UPED_HW_EDIT_FLAG_SEL0_ADDR  (0x15c204)
+#define NBL_UPED_HW_EDIT_FLAG_SEL0_DEPTH (1)
+#define NBL_UPED_HW_EDIT_FLAG_SEL0_WIDTH (32)
+#define NBL_UPED_HW_EDIT_FLAG_SEL0_DWLEN (1)
+union uped_hw_edit_flag_sel0_u {
+	struct uped_hw_edit_flag_sel0 {
+		u32 oft:5;               /* [4:0] Default:0x1 RW */
+		u32 rsv:27;              /* [31:5] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_HW_EDIT_FLAG_SEL0_DWLEN];
+} __packed;
+
+#define NBL_UPED_HW_EDIT_FLAG_SEL1_ADDR  (0x15c208)
+#define NBL_UPED_HW_EDIT_FLAG_SEL1_DEPTH (1)
+#define NBL_UPED_HW_EDIT_FLAG_SEL1_WIDTH (32)
+#define NBL_UPED_HW_EDIT_FLAG_SEL1_DWLEN (1)
+union uped_hw_edit_flag_sel1_u {
+	struct uped_hw_edit_flag_sel1 {
+		u32 oft:5;               /* [4:0] Default:0x2 RW */
+		u32 rsv:27;              /* [31:5] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_HW_EDIT_FLAG_SEL1_DWLEN];
+} __packed;
+
+#define NBL_UPED_HW_EDIT_FLAG_SEL2_ADDR  (0x15c20c)
+#define NBL_UPED_HW_EDIT_FLAG_SEL2_DEPTH (1)
+#define NBL_UPED_HW_EDIT_FLAG_SEL2_WIDTH (32)
+#define NBL_UPED_HW_EDIT_FLAG_SEL2_DWLEN (1)
+union uped_hw_edit_flag_sel2_u {
+	struct uped_hw_edit_flag_sel2 {
+		u32 oft:5;               /* [4:0] Default:0x3 RW */
+		u32 rsv:27;              /* [31:5] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_HW_EDIT_FLAG_SEL2_DWLEN];
+} __packed;
+
+#define NBL_UPED_HW_EDIT_FLAG_SEL3_ADDR  (0x15c210)
+#define NBL_UPED_HW_EDIT_FLAG_SEL3_DEPTH (1)
+#define NBL_UPED_HW_EDIT_FLAG_SEL3_WIDTH (32)
+#define NBL_UPED_HW_EDIT_FLAG_SEL3_DWLEN (1)
+union uped_hw_edit_flag_sel3_u {
+	struct uped_hw_edit_flag_sel3 {
+		u32 oft:5;               /* [4:0] Default:0x4 RW */
+		u32 rsv:27;              /* [31:5] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_HW_EDIT_FLAG_SEL3_DWLEN];
+} __packed;
+
+#define NBL_UPED_HW_EDIT_FLAG_SEL4_ADDR  (0x15c214)
+#define NBL_UPED_HW_EDIT_FLAG_SEL4_DEPTH (1)
+#define NBL_UPED_HW_EDIT_FLAG_SEL4_WIDTH (32)
+#define NBL_UPED_HW_EDIT_FLAG_SEL4_DWLEN (1)
+union uped_hw_edit_flag_sel4_u {
+	struct uped_hw_edit_flag_sel4 {
+		u32 oft:5;               /* [4:0] Default:0xe RW */
+		u32 rsv:27;              /* [31:5] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_HW_EDIT_FLAG_SEL4_DWLEN];
+} __packed;
+
+#define NBL_UPED_FWD_DPORT_ADDR  (0x15c230)
+#define NBL_UPED_FWD_DPORT_DEPTH (1)
+#define NBL_UPED_FWD_DPORT_WIDTH (32)
+#define NBL_UPED_FWD_DPORT_DWLEN (1)
+union uped_fwd_dport_u {
+	struct uped_fwd_dport {
+		u32 id:6;                /* [5:0] Default:0x9 RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_FWD_DPORT_DWLEN];
+} __packed;
+
+#define NBL_UPED_FWD_DQUEUE_ADDR  (0x15c234)
+#define NBL_UPED_FWD_DQUEUE_DEPTH (1)
+#define NBL_UPED_FWD_DQUEUE_WIDTH (32)
+#define NBL_UPED_FWD_DQUEUE_DWLEN (1)
+union uped_fwd_dqueue_u {
+	struct uped_fwd_dqueue {
+		u32 id:6;                /* [5:0] Default:0xa RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_FWD_DQUEUE_DWLEN];
+} __packed;
+
+#define NBL_UPED_FWD_MIRID_ADDR  (0x15c238)
+#define NBL_UPED_FWD_MIRID_DEPTH (1)
+#define NBL_UPED_FWD_MIRID_WIDTH (32)
+#define NBL_UPED_FWD_MIRID_DWLEN (1)
+union uped_fwd_mirid_u {
+	struct uped_fwd_mirid {
+		u32 id:6;                /* [5:0] Default:0x8 RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_FWD_MIRID_DWLEN];
+} __packed;
+
+#define NBL_UPED_FWD_L4IDX_ADDR  (0x15c23c)
+#define NBL_UPED_FWD_L4IDX_DEPTH (1)
+#define NBL_UPED_FWD_L4IDX_WIDTH (32)
+#define NBL_UPED_FWD_L4IDX_DWLEN (1)
+union uped_fwd_l4idx_u {
+	struct uped_fwd_l4idx {
+		u32 id:6;                /* [5:0] Default:0x11 RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_FWD_L4IDX_DWLEN];
+} __packed;
+
+#define NBL_UPED_FWD_HASH_0_ADDR  (0x15c244)
+#define NBL_UPED_FWD_HASH_0_DEPTH (1)
+#define NBL_UPED_FWD_HASH_0_WIDTH (32)
+#define NBL_UPED_FWD_HASH_0_DWLEN (1)
+union uped_fwd_hash_0_u {
+	struct uped_fwd_hash_0 {
+		u32 id:6;                /* [5:0] Default:0x13 RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_FWD_HASH_0_DWLEN];
+} __packed;
+
+#define NBL_UPED_FWD_HASH_1_ADDR  (0x15c248)
+#define NBL_UPED_FWD_HASH_1_DEPTH (1)
+#define NBL_UPED_FWD_HASH_1_WIDTH (32)
+#define NBL_UPED_FWD_HASH_1_DWLEN (1)
+union uped_fwd_hash_1_u {
+	struct uped_fwd_hash_1 {
+		u32 id:6;                /* [5:0] Default:0x14 RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_FWD_HASH_1_DWLEN];
+} __packed;
+
+#define NBL_UPED_L4_OFT_ADJUST_ADDR  (0x15c250)
+#define NBL_UPED_L4_OFT_ADJUST_DEPTH (1)
+#define NBL_UPED_L4_OFT_ADJUST_WIDTH (32)
+#define NBL_UPED_L4_OFT_ADJUST_DWLEN (1)
+union uped_l4_oft_adjust_u {
+	struct uped_l4_oft_adjust {
+		u32 vau:8;               /* [7:0] Default:0x0 RW */
+		u32 rsv:24;              /* [31:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_L4_OFT_ADJUST_DWLEN];
+} __packed;
+
+#define NBL_UPED_PLD_OFT_ADJUST_ADDR  (0x15c254)
+#define NBL_UPED_PLD_OFT_ADJUST_DEPTH (1)
+#define NBL_UPED_PLD_OFT_ADJUST_WIDTH (32)
+#define NBL_UPED_PLD_OFT_ADJUST_DWLEN (1)
+union uped_pld_oft_adjust_u {
+	struct uped_pld_oft_adjust {
+		u32 vau:8;               /* [7:0] Default:0x0 RW */
+		u32 rsv:24;              /* [31:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_PLD_OFT_ADJUST_DWLEN];
+} __packed;
+
+#define NBL_UPED_VLAN_TYPE0_ADDR  (0x15c260)
+#define NBL_UPED_VLAN_TYPE0_DEPTH (1)
+#define NBL_UPED_VLAN_TYPE0_WIDTH (32)
+#define NBL_UPED_VLAN_TYPE0_DWLEN (1)
+union uped_vlan_type0_u {
+	struct uped_vlan_type0 {
+		u32 vau:16;              /* [15:0] Default:0x8100 RW */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_VLAN_TYPE0_DWLEN];
+} __packed;
+
+#define NBL_UPED_VLAN_TYPE1_ADDR  (0x15c264)
+#define NBL_UPED_VLAN_TYPE1_DEPTH (1)
+#define NBL_UPED_VLAN_TYPE1_WIDTH (32)
+#define NBL_UPED_VLAN_TYPE1_DWLEN (1)
+union uped_vlan_type1_u {
+	struct uped_vlan_type1 {
+		u32 vau:16;              /* [15:0] Default:0x88A8 RW */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_VLAN_TYPE1_DWLEN];
+} __packed;
+
+#define NBL_UPED_VLAN_TYPE2_ADDR  (0x15c268)
+#define NBL_UPED_VLAN_TYPE2_DEPTH (1)
+#define NBL_UPED_VLAN_TYPE2_WIDTH (32)
+#define NBL_UPED_VLAN_TYPE2_DWLEN (1)
+union uped_vlan_type2_u {
+	struct uped_vlan_type2 {
+		u32 vau:16;              /* [15:0] Default:0x9100 RW */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_VLAN_TYPE2_DWLEN];
+} __packed;
+
+#define NBL_UPED_VLAN_TYPE3_ADDR  (0x15c26c)
+#define NBL_UPED_VLAN_TYPE3_DEPTH (1)
+#define NBL_UPED_VLAN_TYPE3_WIDTH (32)
+#define NBL_UPED_VLAN_TYPE3_DWLEN (1)
+union uped_vlan_type3_u {
+	struct uped_vlan_type3 {
+		u32 vau:16;              /* [15:0] Default:0x0 RW */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_VLAN_TYPE3_DWLEN];
+} __packed;
+
+#define NBL_UPED_L3_LEN_MDY_CMD_0_ADDR  (0x15c300)
+#define NBL_UPED_L3_LEN_MDY_CMD_0_DEPTH (1)
+#define NBL_UPED_L3_LEN_MDY_CMD_0_WIDTH (32)
+#define NBL_UPED_L3_LEN_MDY_CMD_0_DWLEN (1)
+union uped_l3_len_mdy_cmd_0_u {
+	struct uped_l3_len_mdy_cmd_0 {
+		u32 value:8;             /* [7:0] Default:0x0 RW */
+		u32 in_oft:7;            /* [14:8] Default:0x2 RW */
+		u32 rsv3:1;              /* [15] Default:0x0 RO */
+		u32 phid:2;              /* [17:16] Default:0x2 RW */
+		u32 rsv2:2;              /* [19:18] Default:0x0 RO */
+		u32 mode:2;              /* [21:20] Default:0x2 RW */
+		u32 rsv1:2;              /* [23:22] Default:0x0 RO */
+		u32 unit:1;              /* [24] Default:0x0 RW */
+		u32 rsv:6;               /* [30:25] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_UPED_L3_LEN_MDY_CMD_0_DWLEN];
+} __packed;
+
+#define NBL_UPED_L3_LEN_MDY_CMD_1_ADDR  (0x15c304)
+#define NBL_UPED_L3_LEN_MDY_CMD_1_DEPTH (1)
+#define NBL_UPED_L3_LEN_MDY_CMD_1_WIDTH (32)
+#define NBL_UPED_L3_LEN_MDY_CMD_1_DWLEN (1)
+union uped_l3_len_mdy_cmd_1_u {
+	struct uped_l3_len_mdy_cmd_1 {
+		u32 value:8;             /* [7:0] Default:0x28 RW */
+		u32 in_oft:7;            /* [14:8] Default:0x4 RW */
+		u32 rsv3:1;              /* [15] Default:0x0 RO */
+		u32 phid:2;              /* [17:16] Default:0x2 RW */
+		u32 rsv2:2;              /* [19:18] Default:0x0 RO */
+		u32 mode:2;              /* [21:20] Default:0x1 RW */
+		u32 rsv1:2;              /* [23:22] Default:0x0 RO */
+		u32 unit:1;              /* [24] Default:0x0 RW */
+		u32 rsv:6;               /* [30:25] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_UPED_L3_LEN_MDY_CMD_1_DWLEN];
+} __packed;
+
+#define NBL_UPED_L4_LEN_MDY_CMD_0_ADDR  (0x15c308)
+#define NBL_UPED_L4_LEN_MDY_CMD_0_DEPTH (1)
+#define NBL_UPED_L4_LEN_MDY_CMD_0_WIDTH (32)
+#define NBL_UPED_L4_LEN_MDY_CMD_0_DWLEN (1)
+union uped_l4_len_mdy_cmd_0_u {
+	struct uped_l4_len_mdy_cmd_0 {
+		u32 value:8;             /* [7:0] Default:0x0 RW */
+		u32 in_oft:7;            /* [14:8] Default:0xc RW */
+		u32 rsv3:1;              /* [15] Default:0x0 RO */
+		u32 phid:2;              /* [17:16] Default:0x3 RW */
+		u32 rsv2:2;              /* [19:18] Default:0x0 RO */
+		u32 mode:2;              /* [21:20] Default:0x0 RW */
+		u32 rsv1:2;              /* [23:22] Default:0x0 RO */
+		u32 unit:1;              /* [24] Default:0x1 RW */
+		u32 rsv:6;               /* [30:25] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_UPED_L4_LEN_MDY_CMD_0_DWLEN];
+} __packed;
+
+#define NBL_UPED_L4_LEN_MDY_CMD_1_ADDR  (0x15c30c)
+#define NBL_UPED_L4_LEN_MDY_CMD_1_DEPTH (1)
+#define NBL_UPED_L4_LEN_MDY_CMD_1_WIDTH (32)
+#define NBL_UPED_L4_LEN_MDY_CMD_1_DWLEN (1)
+union uped_l4_len_mdy_cmd_1_u {
+	struct uped_l4_len_mdy_cmd_1 {
+		u32 value:8;             /* [7:0] Default:0x0 RW */
+		u32 in_oft:7;            /* [14:8] Default:0x4 RW */
+		u32 rsv3:1;              /* [15] Default:0x0 RO */
+		u32 phid:2;              /* [17:16] Default:0x3 RW */
+		u32 rsv2:2;              /* [19:18] Default:0x0 RO */
+		u32 mode:2;              /* [21:20] Default:0x0 RW */
+		u32 rsv1:2;              /* [23:22] Default:0x0 RO */
+		u32 unit:1;              /* [24] Default:0x1 RW */
+		u32 rsv:6;               /* [30:25] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_UPED_L4_LEN_MDY_CMD_1_DWLEN];
+} __packed;
+
+#define NBL_UPED_L3_CK_CMD_00_ADDR  (0x15c310)
+#define NBL_UPED_L3_CK_CMD_00_DEPTH (1)
+#define NBL_UPED_L3_CK_CMD_00_WIDTH (32)
+#define NBL_UPED_L3_CK_CMD_00_DWLEN (1)
+union uped_l3_ck_cmd_00_u {
+	struct uped_l3_ck_cmd_00 {
+		u32 value:8;             /* [7:0] Default:0x0 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x0 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x0 RW */
+		u32 len_vld:1;           /* [17] Default:0x0 RW */
+		u32 data_vld:1;          /* [18] Default:0x0 RW */
+		u32 in_oft:7;            /* [25:19] Default:0xa RW */
+		u32 phid:2;              /* [27:26] Default:0x2 RW */
+		u32 flag:1;              /* [28] Default:0x0 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_UPED_L3_CK_CMD_00_DWLEN];
+} __packed;
+
+#define NBL_UPED_L3_CK_CMD_01_ADDR  (0x15c314)
+#define NBL_UPED_L3_CK_CMD_01_DEPTH (1)
+#define NBL_UPED_L3_CK_CMD_01_WIDTH (32)
+#define NBL_UPED_L3_CK_CMD_01_DWLEN (1)
+union uped_l3_ck_cmd_01_u {
+	struct uped_l3_ck_cmd_01 {
+		u32 ck_start0:6;         /* [5:0] Default:0x0 RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x0 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x0 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x0 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_UPED_L3_CK_CMD_01_DWLEN];
+} __packed;
+
+#define NBL_UPED_L4_CK_CMD_00_ADDR  (0x15c318)
+#define NBL_UPED_L4_CK_CMD_00_DEPTH (1)
+#define NBL_UPED_L4_CK_CMD_00_WIDTH (32)
+#define NBL_UPED_L4_CK_CMD_00_DWLEN (1)
+union uped_l4_ck_cmd_00_u {
+	struct uped_l4_ck_cmd_00 {
+		u32 value:8;             /* [7:0] Default:0x6 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x2 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x2 RW */
+		u32 len_vld:1;           /* [17] Default:0x1 RW */
+		u32 data_vld:1;          /* [18] Default:0x1 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x10 RW */
+		u32 phid:2;              /* [27:26] Default:0x3 RW */
+		u32 flag:1;              /* [28] Default:0x0 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_UPED_L4_CK_CMD_00_DWLEN];
+} __packed;
+
+#define NBL_UPED_L4_CK_CMD_01_ADDR  (0x15c31c)
+#define NBL_UPED_L4_CK_CMD_01_DEPTH (1)
+#define NBL_UPED_L4_CK_CMD_01_WIDTH (32)
+#define NBL_UPED_L4_CK_CMD_01_DWLEN (1)
+union uped_l4_ck_cmd_01_u {
+	struct uped_l4_ck_cmd_01 {
+		u32 ck_start0:6;         /* [5:0] Default:0xc RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x8 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x3 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x0 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_UPED_L4_CK_CMD_01_DWLEN];
+} __packed;
+
+#define NBL_UPED_L4_CK_CMD_10_ADDR  (0x15c320)
+#define NBL_UPED_L4_CK_CMD_10_DEPTH (1)
+#define NBL_UPED_L4_CK_CMD_10_WIDTH (32)
+#define NBL_UPED_L4_CK_CMD_10_DWLEN (1)
+union uped_l4_ck_cmd_10_u {
+	struct uped_l4_ck_cmd_10 {
+		u32 value:8;             /* [7:0] Default:0x11 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x2 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x2 RW */
+		u32 len_vld:1;           /* [17] Default:0x1 RW */
+		u32 data_vld:1;          /* [18] Default:0x1 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x6 RW */
+		u32 phid:2;              /* [27:26] Default:0x3 RW */
+		u32 flag:1;              /* [28] Default:0x1 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_UPED_L4_CK_CMD_10_DWLEN];
+} __packed;
+
+#define NBL_UPED_L4_CK_CMD_11_ADDR  (0x15c324)
+#define NBL_UPED_L4_CK_CMD_11_DEPTH (1)
+#define NBL_UPED_L4_CK_CMD_11_WIDTH (32)
+#define NBL_UPED_L4_CK_CMD_11_DWLEN (1)
+union uped_l4_ck_cmd_11_u {
+	struct uped_l4_ck_cmd_11 {
+		u32 ck_start0:6;         /* [5:0] Default:0xc RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x8 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x3 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x0 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_UPED_L4_CK_CMD_11_DWLEN];
+} __packed;
+
+#define NBL_UPED_L4_CK_CMD_20_ADDR  (0x15c328)
+#define NBL_UPED_L4_CK_CMD_20_DEPTH (1)
+#define NBL_UPED_L4_CK_CMD_20_WIDTH (32)
+#define NBL_UPED_L4_CK_CMD_20_DWLEN (1)
+union uped_l4_ck_cmd_20_u {
+	struct uped_l4_ck_cmd_20 {
+		u32 value:8;             /* [7:0] Default:0x2e RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x4 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x2 RW */
+		u32 len_vld:1;           /* [17] Default:0x1 RW */
+		u32 data_vld:1;          /* [18] Default:0x1 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x10 RW */
+		u32 phid:2;              /* [27:26] Default:0x3 RW */
+		u32 flag:1;              /* [28] Default:0x0 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_UPED_L4_CK_CMD_20_DWLEN];
+} __packed;
+
+#define NBL_UPED_L4_CK_CMD_21_ADDR  (0x15c32c)
+#define NBL_UPED_L4_CK_CMD_21_DEPTH (1)
+#define NBL_UPED_L4_CK_CMD_21_WIDTH (32)
+#define NBL_UPED_L4_CK_CMD_21_DWLEN (1)
+union uped_l4_ck_cmd_21_u {
+	struct uped_l4_ck_cmd_21 {
+		u32 ck_start0:6;         /* [5:0] Default:0x8 RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x20 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x3 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x0 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_UPED_L4_CK_CMD_21_DWLEN];
+} __packed;
+
+#define NBL_UPED_L4_CK_CMD_30_ADDR  (0x15c330)
+#define NBL_UPED_L4_CK_CMD_30_DEPTH (1)
+#define NBL_UPED_L4_CK_CMD_30_WIDTH (32)
+#define NBL_UPED_L4_CK_CMD_30_DWLEN (1)
+union uped_l4_ck_cmd_30_u {
+	struct uped_l4_ck_cmd_30 {
+		u32 value:8;             /* [7:0] Default:0x39 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x4 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x2 RW */
+		u32 len_vld:1;           /* [17] Default:0x1 RW */
+		u32 data_vld:1;          /* [18] Default:0x1 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x6 RW */
+		u32 phid:2;              /* [27:26] Default:0x3 RW */
+		u32 flag:1;              /* [28] Default:0x1 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_UPED_L4_CK_CMD_30_DWLEN];
+} __packed;
+
+#define NBL_UPED_L4_CK_CMD_31_ADDR  (0x15c334)
+#define NBL_UPED_L4_CK_CMD_31_DEPTH (1)
+#define NBL_UPED_L4_CK_CMD_31_WIDTH (32)
+#define NBL_UPED_L4_CK_CMD_31_DWLEN (1)
+union uped_l4_ck_cmd_31_u {
+	struct uped_l4_ck_cmd_31 {
+		u32 ck_start0:6;         /* [5:0] Default:0x8 RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x20 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x3 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x0 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_UPED_L4_CK_CMD_31_DWLEN];
+} __packed;
+
+#define NBL_UPED_L4_CK_CMD_40_ADDR  (0x15c338)
+#define NBL_UPED_L4_CK_CMD_40_DEPTH (1)
+#define NBL_UPED_L4_CK_CMD_40_WIDTH (32)
+#define NBL_UPED_L4_CK_CMD_40_DWLEN (1)
+union uped_l4_ck_cmd_40_u {
+	struct uped_l4_ck_cmd_40 {
+		u32 value:8;             /* [7:0] Default:0x0 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x0 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x0 RW */
+		u32 len_vld:1;           /* [17] Default:0x0 RW */
+		u32 data_vld:1;          /* [18] Default:0x0 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x8 RW */
+		u32 phid:2;              /* [27:26] Default:0x3 RW */
+		u32 flag:1;              /* [28] Default:0x0 RW */
+		u32 mode:1;              /* [29] Default:0x1 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_UPED_L4_CK_CMD_40_DWLEN];
+} __packed;
+
+#define NBL_UPED_L4_CK_CMD_41_ADDR  (0x15c33c)
+#define NBL_UPED_L4_CK_CMD_41_DEPTH (1)
+#define NBL_UPED_L4_CK_CMD_41_WIDTH (32)
+#define NBL_UPED_L4_CK_CMD_41_DWLEN (1)
+union uped_l4_ck_cmd_41_u {
+	struct uped_l4_ck_cmd_41 {
+		u32 ck_start0:6;         /* [5:0] Default:0x0 RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x0 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x0 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x0 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x0 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x0 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_UPED_L4_CK_CMD_41_DWLEN];
+} __packed;
+
+#define NBL_UPED_L4_CK_CMD_50_ADDR  (0x15c340)
+#define NBL_UPED_L4_CK_CMD_50_DEPTH (1)
+#define NBL_UPED_L4_CK_CMD_50_WIDTH (32)
+#define NBL_UPED_L4_CK_CMD_50_DWLEN (1)
+union uped_l4_ck_cmd_50_u {
+	struct uped_l4_ck_cmd_50 {
+		u32 value:8;             /* [7:0] Default:0x0 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x2 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x2 RW */
+		u32 len_vld:1;           /* [17] Default:0x0 RW */
+		u32 data_vld:1;          /* [18] Default:0x1 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x2 RW */
+		u32 phid:2;              /* [27:26] Default:0x3 RW */
+		u32 flag:1;              /* [28] Default:0x0 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_UPED_L4_CK_CMD_50_DWLEN];
+} __packed;
+
+#define NBL_UPED_L4_CK_CMD_51_ADDR  (0x15c344)
+#define NBL_UPED_L4_CK_CMD_51_DEPTH (1)
+#define NBL_UPED_L4_CK_CMD_51_WIDTH (32)
+#define NBL_UPED_L4_CK_CMD_51_DWLEN (1)
+union uped_l4_ck_cmd_51_u {
+	struct uped_l4_ck_cmd_51 {
+		u32 ck_start0:6;         /* [5:0] Default:0xc RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x8 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x0 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x3 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x0 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_UPED_L4_CK_CMD_51_DWLEN];
+} __packed;
+
+#define NBL_UPED_L4_CK_CMD_60_ADDR  (0x15c348)
+#define NBL_UPED_L4_CK_CMD_60_DEPTH (1)
+#define NBL_UPED_L4_CK_CMD_60_WIDTH (32)
+#define NBL_UPED_L4_CK_CMD_60_DWLEN (1)
+union uped_l4_ck_cmd_60_u {
+	struct uped_l4_ck_cmd_60 {
+		u32 value:8;             /* [7:0] Default:0x62 RW */
+		u32 len_in_oft:7;        /* [14:8] Default:0x4 RW */
+		u32 len_phid:2;          /* [16:15] Default:0x2 RW */
+		u32 len_vld:1;           /* [17] Default:0x1 RW */
+		u32 data_vld:1;          /* [18] Default:0x1 RW */
+		u32 in_oft:7;            /* [25:19] Default:0x2 RW */
+		u32 phid:2;              /* [27:26] Default:0x3 RW */
+		u32 flag:1;              /* [28] Default:0x0 RW */
+		u32 mode:1;              /* [29] Default:0x0 RW */
+		u32 rsv:1;               /* [30] Default:0x0 RO */
+		u32 en:1;                /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_UPED_L4_CK_CMD_60_DWLEN];
+} __packed;
+
+#define NBL_UPED_L4_CK_CMD_61_ADDR  (0x15c34c)
+#define NBL_UPED_L4_CK_CMD_61_DEPTH (1)
+#define NBL_UPED_L4_CK_CMD_61_WIDTH (32)
+#define NBL_UPED_L4_CK_CMD_61_DWLEN (1)
+union uped_l4_ck_cmd_61_u {
+	struct uped_l4_ck_cmd_61 {
+		u32 ck_start0:6;         /* [5:0] Default:0x8 RW */
+		u32 ck_phid0:2;          /* [7:6] Default:0x2 RW */
+		u32 ck_len0:7;           /* [14:8] Default:0x20 RW */
+		u32 ck_vld0:1;           /* [15] Default:0x1 RW */
+		u32 ck_start1:6;         /* [21:16] Default:0x0 RW */
+		u32 ck_phid1:2;          /* [23:22] Default:0x3 RW */
+		u32 ck_len1:7;           /* [30:24] Default:0x0 RW */
+		u32 ck_vld1:1;           /* [31] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_UPED_L4_CK_CMD_61_DWLEN];
+} __packed;
+
+#define NBL_UPED_CFG_TEST_ADDR  (0x15c600)
+#define NBL_UPED_CFG_TEST_DEPTH (1)
+#define NBL_UPED_CFG_TEST_WIDTH (32)
+#define NBL_UPED_CFG_TEST_DWLEN (1)
+union uped_cfg_test_u {
+	struct uped_cfg_test {
+		u32 test:32;             /* [31:00] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_UPED_CFG_TEST_DWLEN];
+} __packed;
+
+#define NBL_UPED_BP_STATE_ADDR  (0x15c608)
+#define NBL_UPED_BP_STATE_DEPTH (1)
+#define NBL_UPED_BP_STATE_WIDTH (32)
+#define NBL_UPED_BP_STATE_DWLEN (1)
+union uped_bp_state_u {
+	struct uped_bp_state {
+		u32 bm_rtn_tout:1;       /* [0] Default:0x0 RO */
+		u32 bm_not_rdy:1;        /* [1] Default:0x0 RO */
+		u32 rsv1:1;              /* [2] Default:0x0 RO */
+		u32 qm_fc:1;             /* [3] Default:0x0 RO */
+		u32 rsv:28;              /* [31:04] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_BP_STATE_DWLEN];
+} __packed;
+
+#define NBL_UPED_BP_HISTORY_ADDR  (0x15c60c)
+#define NBL_UPED_BP_HISTORY_DEPTH (1)
+#define NBL_UPED_BP_HISTORY_WIDTH (32)
+#define NBL_UPED_BP_HISTORY_DWLEN (1)
+union uped_bp_history_u {
+	struct uped_bp_history {
+		u32 bm_rtn_tout:1;       /* [0] Default:0x0 RC */
+		u32 bm_not_rdy:1;        /* [1] Default:0x0 RC */
+		u32 rsv1:1;              /* [2] Default:0x0 RC */
+		u32 qm_fc:1;             /* [3] Default:0x0 RC */
+		u32 rsv:28;              /* [31:04] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_BP_HISTORY_DWLEN];
+} __packed;
+
+#define NBL_UPED_MIRID_IND_ADDR  (0x15c900)
+#define NBL_UPED_MIRID_IND_DEPTH (1)
+#define NBL_UPED_MIRID_IND_WIDTH (32)
+#define NBL_UPED_MIRID_IND_DWLEN (1)
+union uped_mirid_ind_u {
+	struct uped_mirid_ind {
+		u32 nomat:1;             /* [0] Default:0x0 RC */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_MIRID_IND_DWLEN];
+} __packed;
+
+#define NBL_UPED_MD_AUX_OFT_ADDR  (0x15c904)
+#define NBL_UPED_MD_AUX_OFT_DEPTH (1)
+#define NBL_UPED_MD_AUX_OFT_WIDTH (32)
+#define NBL_UPED_MD_AUX_OFT_DWLEN (1)
+union uped_md_aux_oft_u {
+	struct uped_md_aux_oft {
+		u32 l2_oft:8;            /* [7:0] Default:0x0 RO */
+		u32 l3_oft:8;            /* [15:8] Default:0x0 RO */
+		u32 l4_oft:8;            /* [23:16] Default:0x0 RO */
+		u32 pld_oft:8;           /* [31:24] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_MD_AUX_OFT_DWLEN];
+} __packed;
+
+#define NBL_UPED_MD_AUX_PKT_LEN_ADDR  (0x15c908)
+#define NBL_UPED_MD_AUX_PKT_LEN_DEPTH (1)
+#define NBL_UPED_MD_AUX_PKT_LEN_WIDTH (32)
+#define NBL_UPED_MD_AUX_PKT_LEN_DWLEN (1)
+union uped_md_aux_pkt_len_u {
+	struct uped_md_aux_pkt_len {
+		u32 len:14;              /* [13:0] Default:0x0 RO */
+		u32 rsv:18;              /* [31:14] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_MD_AUX_PKT_LEN_DWLEN];
+} __packed;
+
+#define NBL_UPED_MD_FWD_DPORT_ADDR  (0x15c910)
+#define NBL_UPED_MD_FWD_DPORT_DEPTH (1)
+#define NBL_UPED_MD_FWD_DPORT_WIDTH (32)
+#define NBL_UPED_MD_FWD_DPORT_DWLEN (1)
+union uped_md_fwd_dport_u {
+	struct uped_md_fwd_dport {
+		u32 id:16;               /* [15:0] Default:0x0 RO */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_MD_FWD_DPORT_DWLEN];
+} __packed;
+
+#define NBL_UPED_MD_AUX_PLD_CKSUM_ADDR  (0x15c914)
+#define NBL_UPED_MD_AUX_PLD_CKSUM_DEPTH (1)
+#define NBL_UPED_MD_AUX_PLD_CKSUM_WIDTH (32)
+#define NBL_UPED_MD_AUX_PLD_CKSUM_DWLEN (1)
+union uped_md_aux_pld_cksum_u {
+	struct uped_md_aux_pld_cksum {
+		u32 ck:32;               /* [31:0] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_MD_AUX_PLD_CKSUM_DWLEN];
+} __packed;
+
+#define NBL_UPED_INNER_PKT_CKSUM_ADDR  (0x15c918)
+#define NBL_UPED_INNER_PKT_CKSUM_DEPTH (1)
+#define NBL_UPED_INNER_PKT_CKSUM_WIDTH (32)
+#define NBL_UPED_INNER_PKT_CKSUM_DWLEN (1)
+union uped_inner_pkt_cksum_u {
+	struct uped_inner_pkt_cksum {
+		u32 ck:16;               /* [15:0] Default:0x0 RO */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_INNER_PKT_CKSUM_DWLEN];
+} __packed;
+
+#define NBL_UPED_MD_EDIT_0_ADDR  (0x15c920)
+#define NBL_UPED_MD_EDIT_0_DEPTH (1)
+#define NBL_UPED_MD_EDIT_0_WIDTH (32)
+#define NBL_UPED_MD_EDIT_0_DWLEN (1)
+union uped_md_edit_0_u {
+	struct uped_md_edit_0 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_MD_EDIT_0_DWLEN];
+} __packed;
+
+#define NBL_UPED_MD_EDIT_1_ADDR  (0x15c924)
+#define NBL_UPED_MD_EDIT_1_DEPTH (1)
+#define NBL_UPED_MD_EDIT_1_WIDTH (32)
+#define NBL_UPED_MD_EDIT_1_DWLEN (1)
+union uped_md_edit_1_u {
+	struct uped_md_edit_1 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_MD_EDIT_1_DWLEN];
+} __packed;
+
+#define NBL_UPED_MD_EDIT_2_ADDR  (0x15c928)
+#define NBL_UPED_MD_EDIT_2_DEPTH (1)
+#define NBL_UPED_MD_EDIT_2_WIDTH (32)
+#define NBL_UPED_MD_EDIT_2_DWLEN (1)
+union uped_md_edit_2_u {
+	struct uped_md_edit_2 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_MD_EDIT_2_DWLEN];
+} __packed;
+
+#define NBL_UPED_MD_EDIT_3_ADDR  (0x15c92c)
+#define NBL_UPED_MD_EDIT_3_DEPTH (1)
+#define NBL_UPED_MD_EDIT_3_WIDTH (32)
+#define NBL_UPED_MD_EDIT_3_DWLEN (1)
+union uped_md_edit_3_u {
+	struct uped_md_edit_3 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_MD_EDIT_3_DWLEN];
+} __packed;
+
+#define NBL_UPED_MD_EDIT_4_ADDR  (0x15c930)
+#define NBL_UPED_MD_EDIT_4_DEPTH (1)
+#define NBL_UPED_MD_EDIT_4_WIDTH (32)
+#define NBL_UPED_MD_EDIT_4_DWLEN (1)
+union uped_md_edit_4_u {
+	struct uped_md_edit_4 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_MD_EDIT_4_DWLEN];
+} __packed;
+
+#define NBL_UPED_MD_EDIT_5_ADDR  (0x15c934)
+#define NBL_UPED_MD_EDIT_5_DEPTH (1)
+#define NBL_UPED_MD_EDIT_5_WIDTH (32)
+#define NBL_UPED_MD_EDIT_5_DWLEN (1)
+union uped_md_edit_5_u {
+	struct uped_md_edit_5 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_MD_EDIT_5_DWLEN];
+} __packed;
+
+#define NBL_UPED_MD_EDIT_6_ADDR  (0x15c938)
+#define NBL_UPED_MD_EDIT_6_DEPTH (1)
+#define NBL_UPED_MD_EDIT_6_WIDTH (32)
+#define NBL_UPED_MD_EDIT_6_DWLEN (1)
+union uped_md_edit_6_u {
+	struct uped_md_edit_6 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_MD_EDIT_6_DWLEN];
+} __packed;
+
+#define NBL_UPED_MD_EDIT_7_ADDR  (0x15c93c)
+#define NBL_UPED_MD_EDIT_7_DEPTH (1)
+#define NBL_UPED_MD_EDIT_7_WIDTH (32)
+#define NBL_UPED_MD_EDIT_7_DWLEN (1)
+union uped_md_edit_7_u {
+	struct uped_md_edit_7 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_MD_EDIT_7_DWLEN];
+} __packed;
+
+#define NBL_UPED_MD_EDIT_8_ADDR  (0x15c940)
+#define NBL_UPED_MD_EDIT_8_DEPTH (1)
+#define NBL_UPED_MD_EDIT_8_WIDTH (32)
+#define NBL_UPED_MD_EDIT_8_DWLEN (1)
+union uped_md_edit_8_u {
+	struct uped_md_edit_8 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_MD_EDIT_8_DWLEN];
+} __packed;
+
+#define NBL_UPED_MD_EDIT_9_ADDR  (0x15c944)
+#define NBL_UPED_MD_EDIT_9_DEPTH (1)
+#define NBL_UPED_MD_EDIT_9_WIDTH (32)
+#define NBL_UPED_MD_EDIT_9_DWLEN (1)
+union uped_md_edit_9_u {
+	struct uped_md_edit_9 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_MD_EDIT_9_DWLEN];
+} __packed;
+
+#define NBL_UPED_MD_EDIT_10_ADDR  (0x15c948)
+#define NBL_UPED_MD_EDIT_10_DEPTH (1)
+#define NBL_UPED_MD_EDIT_10_WIDTH (32)
+#define NBL_UPED_MD_EDIT_10_DWLEN (1)
+union uped_md_edit_10_u {
+	struct uped_md_edit_10 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_MD_EDIT_10_DWLEN];
+} __packed;
+
+#define NBL_UPED_MD_EDIT_11_ADDR  (0x15c94c)
+#define NBL_UPED_MD_EDIT_11_DEPTH (1)
+#define NBL_UPED_MD_EDIT_11_WIDTH (32)
+#define NBL_UPED_MD_EDIT_11_DWLEN (1)
+union uped_md_edit_11_u {
+	struct uped_md_edit_11 {
+		u32 vau:16;              /* [15:0] Default:0x0 RO */
+		u32 id:6;                /* [21:16] Default:0x0 RO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_MD_EDIT_11_DWLEN];
+} __packed;
+
+#define NBL_UPED_ADD_DEL_LEN_ADDR  (0x15c950)
+#define NBL_UPED_ADD_DEL_LEN_DEPTH (1)
+#define NBL_UPED_ADD_DEL_LEN_WIDTH (32)
+#define NBL_UPED_ADD_DEL_LEN_DWLEN (1)
+union uped_add_del_len_u {
+	struct uped_add_del_len {
+		u32 len:9;               /* [8:0] Default:0x0 RO */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_ADD_DEL_LEN_DWLEN];
+} __packed;
+
+#define NBL_UPED_TTL_INFO_ADDR  (0x15c970)
+#define NBL_UPED_TTL_INFO_DEPTH (1)
+#define NBL_UPED_TTL_INFO_WIDTH (32)
+#define NBL_UPED_TTL_INFO_DWLEN (1)
+union uped_ttl_info_u {
+	struct uped_ttl_info {
+		u32 old_ttl:8;           /* [7:0] Default:0x0 RO */
+		u32 new_ttl:8;           /* [15:8] Default:0x0 RO */
+		u32 ttl_val:1;           /* [16] Default:0x0 RC */
+		u32 rsv:15;              /* [31:17] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_TTL_INFO_DWLEN];
+} __packed;
+
+#define NBL_UPED_LEN_INFO_VLD_ADDR  (0x15c974)
+#define NBL_UPED_LEN_INFO_VLD_DEPTH (1)
+#define NBL_UPED_LEN_INFO_VLD_WIDTH (32)
+#define NBL_UPED_LEN_INFO_VLD_DWLEN (1)
+union uped_len_info_vld_u {
+	struct uped_len_info_vld {
+		u32 length0:1;           /* [0] Default:0x0 RC */
+		u32 length1:1;           /* [1] Default:0x0 RC */
+		u32 rsv:30;              /* [31:2] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_LEN_INFO_VLD_DWLEN];
+} __packed;
+
+#define NBL_UPED_LEN0_INFO_ADDR  (0x15c978)
+#define NBL_UPED_LEN0_INFO_DEPTH (1)
+#define NBL_UPED_LEN0_INFO_WIDTH (32)
+#define NBL_UPED_LEN0_INFO_DWLEN (1)
+union uped_len0_info_u {
+	struct uped_len0_info {
+		u32 old_len:16;          /* [15:0] Default:0x0 RO */
+		u32 new_len:16;          /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_LEN0_INFO_DWLEN];
+} __packed;
+
+#define NBL_UPED_LEN1_INFO_ADDR  (0x15c97c)
+#define NBL_UPED_LEN1_INFO_DEPTH (1)
+#define NBL_UPED_LEN1_INFO_WIDTH (32)
+#define NBL_UPED_LEN1_INFO_DWLEN (1)
+union uped_len1_info_u {
+	struct uped_len1_info {
+		u32 old_len:16;          /* [15:0] Default:0x0 RO */
+		u32 new_len:16;          /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_LEN1_INFO_DWLEN];
+} __packed;
+
+#define NBL_UPED_EDIT_ATNUM_INFO_ADDR  (0x15c980)
+#define NBL_UPED_EDIT_ATNUM_INFO_DEPTH (1)
+#define NBL_UPED_EDIT_ATNUM_INFO_WIDTH (32)
+#define NBL_UPED_EDIT_ATNUM_INFO_DWLEN (1)
+union uped_edit_atnum_info_u {
+	struct uped_edit_atnum_info {
+		u32 replace:4;           /* [3:0] Default:0x0 RO */
+		u32 del:4;               /* [7:4] Default:0x0 RO */
+		u32 add:4;               /* [11:8] Default:0x0 RO */
+		u32 ttl:4;               /* [15:12] Default:0x0 RO */
+		u32 dscp:4;              /* [19:16] Default:0x0 RO */
+		u32 rsv:12;              /* [31:20] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_EDIT_ATNUM_INFO_DWLEN];
+} __packed;
+
+#define NBL_UPED_EDIT_NO_AT_INFO_ADDR  (0x15c984)
+#define NBL_UPED_EDIT_NO_AT_INFO_DEPTH (1)
+#define NBL_UPED_EDIT_NO_AT_INFO_WIDTH (32)
+#define NBL_UPED_EDIT_NO_AT_INFO_DWLEN (1)
+union uped_edit_no_at_info_u {
+	struct uped_edit_no_at_info {
+		u32 l3_len:1;            /* [0] Default:0x0 RC */
+		u32 l4_len:1;            /* [1] Default:0x0 RC */
+		u32 l3_ck:1;             /* [2] Default:0x0 RC */
+		u32 l4_ck:1;             /* [3] Default:0x0 RC */
+		u32 sctp_ck:1;           /* [4] Default:0x0 RC */
+		u32 rsv:27;              /* [31:05] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_EDIT_NO_AT_INFO_DWLEN];
+} __packed;
+
+#define NBL_UPED_UL4S_TOTAL_LENGTH_ADDR  (0x15c988)
+#define NBL_UPED_UL4S_TOTAL_LENGTH_DEPTH (1)
+#define NBL_UPED_UL4S_TOTAL_LENGTH_WIDTH (32)
+#define NBL_UPED_UL4S_TOTAL_LENGTH_DWLEN (1)
+union uped_ul4s_total_length_u {
+	struct uped_ul4s_total_length {
+		u32 vau:14;              /* [13:0] Default:0x0 RO */
+		u32 rsv:16;              /* [29:14] Default:0x0 RO */
+		u32 tls_ind:1;           /* [30] Default:0x0 RO */
+		u32 vld:1;               /* [31] Default:0x0 RC */
+	} __packed info;
+	u32 data[NBL_UPED_UL4S_TOTAL_LENGTH_DWLEN];
+} __packed;
+
+#define NBL_UPED_HW_EDT_PROF_ADDR  (0x15d000)
+#define NBL_UPED_HW_EDT_PROF_DEPTH (32)
+#define NBL_UPED_HW_EDT_PROF_WIDTH (32)
+#define NBL_UPED_HW_EDT_PROF_DWLEN (1)
+union uped_hw_edt_prof_u {
+	struct uped_hw_edt_prof {
+		u32 l4_len:2;            /* [1:0] Default:0x2 RW */
+		u32 l3_len:2;            /* [3:2] Default:0x2 RW */
+		u32 l4_ck:3;             /* [6:4] Default:0x7 RW */
+		u32 l3_ck:1;             /* [7:7] Default:0x0 RW */
+		u32 l4_ck_zero_free:1;   /* [8:8] Default:0x1 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_HW_EDT_PROF_DWLEN];
+} __packed;
+#define NBL_UPED_HW_EDT_PROF_REG(r) (NBL_UPED_HW_EDT_PROF_ADDR + \
+		(NBL_UPED_HW_EDT_PROF_DWLEN * 4) * (r))
+
+#define NBL_UPED_OUT_MASK_ADDR  (0x15e000)
+#define NBL_UPED_OUT_MASK_DEPTH (24)
+#define NBL_UPED_OUT_MASK_WIDTH (64)
+#define NBL_UPED_OUT_MASK_DWLEN (2)
+union uped_out_mask_u {
+	struct uped_out_mask {
+		u32 flag:32;             /* [31:0] Default:0x0 RW */
+		u32 fwd:30;              /* [61:32] Default:0x0 RW */
+		u32 rsv:2;               /* [63:62] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_OUT_MASK_DWLEN];
+} __packed;
+#define NBL_UPED_OUT_MASK_REG(r) (NBL_UPED_OUT_MASK_ADDR + \
+		(NBL_UPED_OUT_MASK_DWLEN * 4) * (r))
+
+#define NBL_UPED_TAB_EDIT_CMD_ADDR  (0x15f000)
+#define NBL_UPED_TAB_EDIT_CMD_DEPTH (32)
+#define NBL_UPED_TAB_EDIT_CMD_WIDTH (32)
+#define NBL_UPED_TAB_EDIT_CMD_DWLEN (1)
+union uped_tab_edit_cmd_u {
+	struct uped_tab_edit_cmd {
+		u32 in_offset:8;         /* [7:0] Default:0x0 RW */
+		u32 phid:2;              /* [9:8] Default:0x0 RW */
+		u32 len:7;               /* [16:10] Default:0x0 RW */
+		u32 mode:4;              /* [20:17] Default:0xf RW */
+		u32 l4_ck_ofld_upt:1;    /* [21] Default:0x1 RW */
+		u32 l3_ck_ofld_upt:1;    /* [22] Default:0x1 RW */
+		u32 rsv:9;               /* [31:23] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_TAB_EDIT_CMD_DWLEN];
+} __packed;
+#define NBL_UPED_TAB_EDIT_CMD_REG(r) (NBL_UPED_TAB_EDIT_CMD_ADDR + \
+		(NBL_UPED_TAB_EDIT_CMD_DWLEN * 4) * (r))
+
+#define NBL_UPED_TAB_VSI_TYPE_ADDR  (0x161000)
+#define NBL_UPED_TAB_VSI_TYPE_DEPTH (1031)
+#define NBL_UPED_TAB_VSI_TYPE_WIDTH (32)
+#define NBL_UPED_TAB_VSI_TYPE_DWLEN (1)
+union uped_tab_vsi_type_u {
+	struct uped_tab_vsi_type {
+		u32 sel:4;               /* [3:0] Default:0x0 RW */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_UPED_TAB_VSI_TYPE_DWLEN];
+} __packed;
+#define NBL_UPED_TAB_VSI_TYPE_REG(r) (NBL_UPED_TAB_VSI_TYPE_ADDR + \
+		(NBL_UPED_TAB_VSI_TYPE_DWLEN * 4) * (r))
+
+#define NBL_UPED_TAB_REPLACE_ADDR  (0x164000)
+#define NBL_UPED_TAB_REPLACE_DEPTH (2048)
+#define NBL_UPED_TAB_REPLACE_WIDTH (64)
+#define NBL_UPED_TAB_REPLACE_DWLEN (2)
+union uped_tab_replace_u {
+	struct uped_tab_replace {
+		u32 vau_arr[2];          /* [63:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_UPED_TAB_REPLACE_DWLEN];
+} __packed;
+#define NBL_UPED_TAB_REPLACE_REG(r) (NBL_UPED_TAB_REPLACE_ADDR + \
+		(NBL_UPED_TAB_REPLACE_DWLEN * 4) * (r))
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe.h
new file mode 100644
index 000000000000..fbe823372484
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+// Code generated by interstellar. DO NOT EDIT.
+// Compatible with leonis RTL tag 0710
+
+#include "nbl_ppe_ipro.h"
+#include "nbl_ppe_epro.h"
+#include "nbl_ppe_pp0.h"
+#include "nbl_ppe_pp1.h"
+#include "nbl_ppe_pp2.h"
+#include "nbl_ppe_fem.h"
+#include "nbl_ppe_mcc.h"
+#include "nbl_ppe_acl.h"
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_acl.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_acl.h
new file mode 100644
index 000000000000..c2aee2a19a32
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_acl.h
@@ -0,0 +1,2417 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+// Code generated by interstellar. DO NOT EDIT.
+// Compatible with leonis RTL tag 0710
+
+#ifndef NBL_ACL_H
+#define NBL_ACL_H 1
+
+#include <linux/types.h>
+
+#define NBL_ACL_BASE (0x00B64000)
+
+#define NBL_ACL_INT_STATUS_ADDR  (0xb64000)
+#define NBL_ACL_INT_STATUS_DEPTH (1)
+#define NBL_ACL_INT_STATUS_WIDTH (32)
+#define NBL_ACL_INT_STATUS_DWLEN (1)
+union acl_int_status_u {
+	struct acl_int_status {
+		u32 fifo_uflw_err:1;     /* [00:00] Default:0x0 RWC */
+		u32 fifo_dflw_err:1;     /* [01:01] Default:0x0 RWC */
+		u32 data_ucor_err:1;     /* [02:02] Default:0x0 RWC */
+		u32 data_cor_err:1;      /* [03:03] Default:0x0 RWC */
+		u32 cif_err:1;           /* [04:04] Default:0x0 RWC */
+		u32 set_dport_encode_cfg_err:1; /* [05:05] Default:0x0 RWC */
+		u32 tcam_cor_err:1;      /* [06:06] Default:0x0 RWC */
+		u32 tcam_ucor_err:1;     /* [07:07] Default:0x0 RWC */
+		u32 flow_id_err:1;       /* [08:08] Default:0x0 RWC */
+		u32 stat_id_conflict_int:1; /* [09:09] Default:0x0 RWC */
+		u32 flow_id_conflict_int:1; /* [10:10] Default:0x0 RWC */
+		u32 fsm_err:1;           /* [11:11] Default:0x0 RWC */
+		u32 nxt_stage_lp_cfg_err:1; /* [12:12] Default:0x0 RWC */
+		u32 input_err:1;         /* [13:13] Default:0x0 RWC */
+		u32 rsv:18;              /* [31:14] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_INT_STATUS_DWLEN];
+} __packed;
+
+#define NBL_ACL_INT_MASK_ADDR  (0xb64004)
+#define NBL_ACL_INT_MASK_DEPTH (1)
+#define NBL_ACL_INT_MASK_WIDTH (32)
+#define NBL_ACL_INT_MASK_DWLEN (1)
+union acl_int_mask_u {
+	struct acl_int_mask {
+		u32 fifo_uflw_err:1;     /* [00:00] Default:0x0 RW */
+		u32 fifo_dflw_err:1;     /* [01:01] Default:0x0 RW */
+		u32 data_ucor_err:1;     /* [02:02] Default:0x0 RW */
+		u32 data_cor_err:1;      /* [03:03] Default:0x0 RW */
+		u32 cif_err:1;           /* [04:04] Default:0x0 RW */
+		u32 set_dport_encode_cfg_err:1; /* [05:05] Default:0x0 RW */
+		u32 tcam_cor_err:1;      /* [06:06] Default:0x0 RW */
+		u32 tcam_ucor_err:1;     /* [07:07] Default:0x0 RW */
+		u32 flow_id_err:1;       /* [08:08] Default:0x0 RW */
+		u32 stat_id_conflict_int:1; /* [09:09] Default:0x0 RW */
+		u32 flow_id_conflict_int:1; /* [10:10] Default:0x0 RW */
+		u32 fsm_err:1;           /* [11:11] Default:0x0 RW */
+		u32 nxt_stage_lp_cfg_err:1; /* [12:12] Default:0x0 RW */
+		u32 input_err:1;         /* [13:13] Default:0x0 RW */
+		u32 rsv:18;              /* [31:14] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_INT_MASK_DWLEN];
+} __packed;
+
+#define NBL_ACL_INT_SET_ADDR  (0xb64008)
+#define NBL_ACL_INT_SET_DEPTH (1)
+#define NBL_ACL_INT_SET_WIDTH (32)
+#define NBL_ACL_INT_SET_DWLEN (1)
+union acl_int_set_u {
+	struct acl_int_set {
+		u32 fifo_uflw_err:1;     /* [00:00] Default:0x0 WO */
+		u32 fifo_dflw_err:1;     /* [01:01] Default:0x0 WO */
+		u32 data_ucor_err:1;     /* [02:02] Default:0x0 WO */
+		u32 data_cor_err:1;      /* [03:03] Default:0x0 WO */
+		u32 cif_err:1;           /* [04:04] Default:0x0 WO */
+		u32 set_dport_encode_cfg_err:1; /* [05:05] Default:0x0 WO */
+		u32 tcam_cor_err:1;      /* [06:06] Default:0x0 WO */
+		u32 tcam_ucor_err:1;     /* [07:07] Default:0x0 WO */
+		u32 flow_id_err:1;       /* [08:08] Default:0x0 WO */
+		u32 stat_id_conflict_int:1; /* [09:09] Default:0x0 WO */
+		u32 flow_id_conflict_int:1; /* [10:10] Default:0x0 WO */
+		u32 fsm_err:1;           /* [11:11] Default:0x0 WO */
+		u32 nxt_stage_lp_cfg_err:1; /* [12:12] Default:0x0 WO */
+		u32 input_err:1;         /* [13:13] Default:0x0 WO */
+		u32 rsv:18;              /* [31:14] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_INT_SET_DWLEN];
+} __packed;
+
+#define NBL_ACL_INIT_DONE_ADDR  (0xb6400c)
+#define NBL_ACL_INIT_DONE_DEPTH (1)
+#define NBL_ACL_INIT_DONE_WIDTH (32)
+#define NBL_ACL_INIT_DONE_DWLEN (1)
+union acl_init_done_u {
+	struct acl_init_done {
+		u32 done:1;              /* [00:00] Default:0x0 RO */
+		u32 rsv:31;              /* [31:01] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_INIT_DONE_DWLEN];
+} __packed;
+
+#define NBL_ACL_CIF_ERR_INFO_ADDR  (0xb64084)
+#define NBL_ACL_CIF_ERR_INFO_DEPTH (1)
+#define NBL_ACL_CIF_ERR_INFO_WIDTH (32)
+#define NBL_ACL_CIF_ERR_INFO_DWLEN (1)
+union acl_cif_err_info_u {
+	struct acl_cif_err_info {
+		u32 addr:30;             /* [29:00] Default:0x0 RO */
+		u32 wr_err:1;            /* [30:30] Default:0x0 RO */
+		u32 ucor_err:1;          /* [31:31] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_CIF_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_ACL_INIT_START_ADDR  (0xb6409c)
+#define NBL_ACL_INIT_START_DEPTH (1)
+#define NBL_ACL_INIT_START_WIDTH (32)
+#define NBL_ACL_INIT_START_DWLEN (1)
+union acl_init_start_u {
+	struct acl_init_start {
+		u32 start:1;             /* [00:00] Default:0x0 WO */
+		u32 rsv:31;              /* [31:01] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_INIT_START_DWLEN];
+} __packed;
+
+#define NBL_ACL_BYPASS_REG_ADDR  (0xb64100)
+#define NBL_ACL_BYPASS_REG_DEPTH (1)
+#define NBL_ACL_BYPASS_REG_WIDTH (32)
+#define NBL_ACL_BYPASS_REG_DWLEN (1)
+union acl_bypass_reg_u {
+	struct acl_bypass_reg {
+		u32 acl_bypass:1;        /* [00:00] Default:0x0 RW */
+		u32 rsv:31;              /* [31:01] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_BYPASS_REG_DWLEN];
+} __packed;
+
+#define NBL_ACL_LOOP_BACK_EN_ADDR  (0xb64108)
+#define NBL_ACL_LOOP_BACK_EN_DEPTH (1)
+#define NBL_ACL_LOOP_BACK_EN_WIDTH (32)
+#define NBL_ACL_LOOP_BACK_EN_DWLEN (1)
+union acl_loop_back_en_u {
+	struct acl_loop_back_en {
+		u32 loop_back_en:1;      /* [00:00] Default:0x0 RW */
+		u32 rsv:31;              /* [31:01] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_LOOP_BACK_EN_DWLEN];
+} __packed;
+
+#define NBL_ACL_LOOP_FLAG_EN_ADDR  (0xb6410c)
+#define NBL_ACL_LOOP_FLAG_EN_DEPTH (1)
+#define NBL_ACL_LOOP_FLAG_EN_WIDTH (32)
+#define NBL_ACL_LOOP_FLAG_EN_DWLEN (1)
+union acl_loop_flag_en_u {
+	struct acl_loop_flag_en {
+		u32 flag_en:1;           /* [00:00] Default:0x0 RW */
+		u32 rsv:31;              /* [31:01] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_LOOP_FLAG_EN_DWLEN];
+} __packed;
+
+#define NBL_ACL_DEFAULT_ACTION0_ADDR  (0xb64160)
+#define NBL_ACL_DEFAULT_ACTION0_DEPTH (1)
+#define NBL_ACL_DEFAULT_ACTION0_WIDTH (32)
+#define NBL_ACL_DEFAULT_ACTION0_DWLEN (1)
+union acl_default_action0_u {
+	struct acl_default_action0 {
+		u32 data:22;             /* [21:0] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_DEFAULT_ACTION0_DWLEN];
+} __packed;
+
+#define NBL_ACL_DEFAULT_ACTION1_ADDR  (0xb64164)
+#define NBL_ACL_DEFAULT_ACTION1_DEPTH (1)
+#define NBL_ACL_DEFAULT_ACTION1_WIDTH (32)
+#define NBL_ACL_DEFAULT_ACTION1_DWLEN (1)
+union acl_default_action1_u {
+	struct acl_default_action1 {
+		u32 data:22;             /* [21:0] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_DEFAULT_ACTION1_DWLEN];
+} __packed;
+
+#define NBL_ACL_DEFAULT_ACTION2_ADDR  (0xb64168)
+#define NBL_ACL_DEFAULT_ACTION2_DEPTH (1)
+#define NBL_ACL_DEFAULT_ACTION2_WIDTH (32)
+#define NBL_ACL_DEFAULT_ACTION2_DWLEN (1)
+union acl_default_action2_u {
+	struct acl_default_action2 {
+		u32 data:22;             /* [21:0] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_DEFAULT_ACTION2_DWLEN];
+} __packed;
+
+#define NBL_ACL_DEFAULT_ACTION3_ADDR  (0xb6416c)
+#define NBL_ACL_DEFAULT_ACTION3_DEPTH (1)
+#define NBL_ACL_DEFAULT_ACTION3_WIDTH (32)
+#define NBL_ACL_DEFAULT_ACTION3_DWLEN (1)
+union acl_default_action3_u {
+	struct acl_default_action3 {
+		u32 data:22;             /* [21:0] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_DEFAULT_ACTION3_DWLEN];
+} __packed;
+
+#define NBL_ACL_DEFAULT_ACTION4_ADDR  (0xb64170)
+#define NBL_ACL_DEFAULT_ACTION4_DEPTH (1)
+#define NBL_ACL_DEFAULT_ACTION4_WIDTH (32)
+#define NBL_ACL_DEFAULT_ACTION4_DWLEN (1)
+union acl_default_action4_u {
+	struct acl_default_action4 {
+		u32 data:22;             /* [21:0] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_DEFAULT_ACTION4_DWLEN];
+} __packed;
+
+#define NBL_ACL_DEFAULT_ACTION5_ADDR  (0xb64174)
+#define NBL_ACL_DEFAULT_ACTION5_DEPTH (1)
+#define NBL_ACL_DEFAULT_ACTION5_WIDTH (32)
+#define NBL_ACL_DEFAULT_ACTION5_DWLEN (1)
+union acl_default_action5_u {
+	struct acl_default_action5 {
+		u32 data:22;             /* [21:0] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_DEFAULT_ACTION5_DWLEN];
+} __packed;
+
+#define NBL_ACL_DEFAULT_ACTION6_ADDR  (0xb64178)
+#define NBL_ACL_DEFAULT_ACTION6_DEPTH (1)
+#define NBL_ACL_DEFAULT_ACTION6_WIDTH (32)
+#define NBL_ACL_DEFAULT_ACTION6_DWLEN (1)
+union acl_default_action6_u {
+	struct acl_default_action6 {
+		u32 data:22;             /* [21:0] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_DEFAULT_ACTION6_DWLEN];
+} __packed;
+
+#define NBL_ACL_DEFAULT_ACTION7_ADDR  (0xb6417c)
+#define NBL_ACL_DEFAULT_ACTION7_DEPTH (1)
+#define NBL_ACL_DEFAULT_ACTION7_WIDTH (32)
+#define NBL_ACL_DEFAULT_ACTION7_DWLEN (1)
+union acl_default_action7_u {
+	struct acl_default_action7 {
+		u32 data:22;             /* [21:0] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_DEFAULT_ACTION7_DWLEN];
+} __packed;
+
+#define NBL_ACL_SET_FLAG_ADDR  (0xb64200)
+#define NBL_ACL_SET_FLAG_DEPTH (1)
+#define NBL_ACL_SET_FLAG_WIDTH (32)
+#define NBL_ACL_SET_FLAG_DWLEN (1)
+union acl_set_flag_u {
+	struct acl_set_flag {
+		u32 set_flag0:32;        /* [31:00] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_ACL_SET_FLAG_DWLEN];
+} __packed;
+
+#define NBL_ACL_CLEAR_FLAG_ADDR  (0xb64204)
+#define NBL_ACL_CLEAR_FLAG_DEPTH (1)
+#define NBL_ACL_CLEAR_FLAG_WIDTH (32)
+#define NBL_ACL_CLEAR_FLAG_DWLEN (1)
+union acl_clear_flag_u {
+	struct acl_clear_flag {
+		u32 clear_flag0:32;      /* [31:00] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_ACL_CLEAR_FLAG_DWLEN];
+} __packed;
+
+#define NBL_ACL_SET_FLAG0_ADDR  (0xb64208)
+#define NBL_ACL_SET_FLAG0_DEPTH (1)
+#define NBL_ACL_SET_FLAG0_WIDTH (32)
+#define NBL_ACL_SET_FLAG0_DWLEN (1)
+union acl_set_flag0_u {
+	struct acl_set_flag0 {
+		u32 set_flag0:32;        /* [31:00] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_ACL_SET_FLAG0_DWLEN];
+} __packed;
+
+#define NBL_ACL_CLEAR_FLAG0_ADDR  (0xb6420c)
+#define NBL_ACL_CLEAR_FLAG0_DEPTH (1)
+#define NBL_ACL_CLEAR_FLAG0_WIDTH (32)
+#define NBL_ACL_CLEAR_FLAG0_DWLEN (1)
+union acl_clear_flag0_u {
+	struct acl_clear_flag0 {
+		u32 clear_flag0:32;      /* [31:00] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_ACL_CLEAR_FLAG0_DWLEN];
+} __packed;
+
+#define NBL_ACL_DPORT_CFG_ADDR  (0xb64220)
+#define NBL_ACL_DPORT_CFG_DEPTH (1)
+#define NBL_ACL_DPORT_CFG_WIDTH (32)
+#define NBL_ACL_DPORT_CFG_DWLEN (1)
+union acl_dport_cfg_u {
+	struct acl_dport_cfg {
+		u32 act_id:6;            /* [05:00] Default:0x9 RW */
+		u32 rsv:26;              /* [31:06] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_DPORT_CFG_DWLEN];
+} __packed;
+
+#define NBL_ACL_ACTION_PRIORITY0_ADDR  (0xb64230)
+#define NBL_ACL_ACTION_PRIORITY0_DEPTH (1)
+#define NBL_ACL_ACTION_PRIORITY0_WIDTH (32)
+#define NBL_ACL_ACTION_PRIORITY0_DWLEN (1)
+union acl_action_priority0_u {
+	struct acl_action_priority0 {
+		u32 action_id3_pri:2;    /* [01:00] Default:0x0 RW */
+		u32 action_id4_pri:2;    /* [03:02] Default:0x0 RW */
+		u32 action_id5_pri:2;    /* [05:04] Default:0x0 RW */
+		u32 action_id6_pri:2;    /* [07:06] Default:0x0 RW */
+		u32 action_id7_pri:2;    /* [09:08] Default:0x0 RW */
+		u32 action_id8_pri:2;    /* [11:10] Default:0x0 RW */
+		u32 action_id9_pri:2;    /* [13:12] Default:0x0 RW */
+		u32 action_id10_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id11_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id12_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id13_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id14_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 action_id15_pri:2;   /* [25:24] Default:0x0 RW */
+		u32 action_id16_pri:2;   /* [27:26] Default:0x0 RW */
+		u32 action_id17_pri:2;   /* [29:28] Default:0x0 RW */
+		u32 action_id18_pri:2;   /* [31:30] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_ACL_ACTION_PRIORITY0_DWLEN];
+} __packed;
+
+#define NBL_ACL_ACTION_PRIORITY1_ADDR  (0xb64234)
+#define NBL_ACL_ACTION_PRIORITY1_DEPTH (1)
+#define NBL_ACL_ACTION_PRIORITY1_WIDTH (32)
+#define NBL_ACL_ACTION_PRIORITY1_DWLEN (1)
+union acl_action_priority1_u {
+	struct acl_action_priority1 {
+		u32 action_id19_pri:2;   /* [01:00] Default:0x0 RW */
+		u32 action_id20_pri:2;   /* [03:02] Default:0x0 RW */
+		u32 action_id21_pri:2;   /* [05:04] Default:0x0 RW */
+		u32 action_id22_pri:2;   /* [07:06] Default:0x0 RW */
+		u32 action_id23_pri:2;   /* [09:08] Default:0x0 RW */
+		u32 action_id24_pri:2;   /* [11:10] Default:0x0 RW */
+		u32 action_id25_pri:2;   /* [13:12] Default:0x0 RW */
+		u32 action_id26_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id27_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id28_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id29_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id30_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 action_id31_pri:2;   /* [25:24] Default:0x0 RW */
+		u32 action_id32_pri:2;   /* [27:26] Default:0x0 RW */
+		u32 action_id33_pri:2;   /* [29:28] Default:0x0 RW */
+		u32 action_id34_pri:2;   /* [31:30] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_ACL_ACTION_PRIORITY1_DWLEN];
+} __packed;
+
+#define NBL_ACL_ACTION_PRIORITY2_ADDR  (0xb64238)
+#define NBL_ACL_ACTION_PRIORITY2_DEPTH (1)
+#define NBL_ACL_ACTION_PRIORITY2_WIDTH (32)
+#define NBL_ACL_ACTION_PRIORITY2_DWLEN (1)
+union acl_action_priority2_u {
+	struct acl_action_priority2 {
+		u32 action_id35_pri:2;   /* [01:00] Default:0x0 RW */
+		u32 action_id36_pri:2;   /* [03:02] Default:0x0 RW */
+		u32 action_id37_pri:2;   /* [05:04] Default:0x0 RW */
+		u32 action_id38_pri:2;   /* [07:06] Default:0x0 RW */
+		u32 action_id39_pri:2;   /* [09:08] Default:0x0 RW */
+		u32 action_id40_pri:2;   /* [11:10] Default:0x0 RW */
+		u32 action_id41_pri:2;   /* [13:12] Default:0x0 RW */
+		u32 action_id42_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id43_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id44_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id45_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id46_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 action_id47_pri:2;   /* [25:24] Default:0x0 RW */
+		u32 action_id48_pri:2;   /* [27:26] Default:0x0 RW */
+		u32 action_id49_pri:2;   /* [29:28] Default:0x0 RW */
+		u32 action_id50_pri:2;   /* [31:30] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_ACL_ACTION_PRIORITY2_DWLEN];
+} __packed;
+
+#define NBL_ACL_ACTION_PRIORITY3_ADDR  (0xb6423c)
+#define NBL_ACL_ACTION_PRIORITY3_DEPTH (1)
+#define NBL_ACL_ACTION_PRIORITY3_WIDTH (32)
+#define NBL_ACL_ACTION_PRIORITY3_DWLEN (1)
+union acl_action_priority3_u {
+	struct acl_action_priority3 {
+		u32 action_id51_pri:2;   /* [01:00] Default:0x0 RW */
+		u32 action_id52_pri:2;   /* [03:02] Default:0x0 RW */
+		u32 action_id53_pri:2;   /* [05:04] Default:0x0 RW */
+		u32 action_id54_pri:2;   /* [07:06] Default:0x0 RW */
+		u32 action_id55_pri:2;   /* [09:08] Default:0x0 RW */
+		u32 action_id56_pri:2;   /* [11:10] Default:0x0 RW */
+		u32 action_id57_pri:2;   /* [13:12] Default:0x0 RW */
+		u32 action_id58_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id59_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id60_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id61_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id62_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 rsv:8;               /* [31:24] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_ACTION_PRIORITY3_DWLEN];
+} __packed;
+
+#define NBL_ACL_ACTION_PRIORITY4_ADDR  (0xb64240)
+#define NBL_ACL_ACTION_PRIORITY4_DEPTH (1)
+#define NBL_ACL_ACTION_PRIORITY4_WIDTH (32)
+#define NBL_ACL_ACTION_PRIORITY4_DWLEN (1)
+union acl_action_priority4_u {
+	struct acl_action_priority4 {
+		u32 action_id3_pri:2;    /* [01:00] Default:0x0 RW */
+		u32 action_id4_pri:2;    /* [03:02] Default:0x0 RW */
+		u32 action_id5_pri:2;    /* [05:04] Default:0x0 RW */
+		u32 action_id6_pri:2;    /* [07:06] Default:0x0 RW */
+		u32 action_id7_pri:2;    /* [09:08] Default:0x0 RW */
+		u32 action_id8_pri:2;    /* [11:10] Default:0x0 RW */
+		u32 action_id9_pri:2;    /* [13:12] Default:0x0 RW */
+		u32 action_id10_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id11_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id12_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id13_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id14_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 action_id15_pri:2;   /* [25:24] Default:0x0 RW */
+		u32 action_id16_pri:2;   /* [27:26] Default:0x0 RW */
+		u32 action_id17_pri:2;   /* [29:28] Default:0x0 RW */
+		u32 action_id18_pri:2;   /* [31:30] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_ACL_ACTION_PRIORITY4_DWLEN];
+} __packed;
+
+#define NBL_ACL_ACTION_PRIORITY5_ADDR  (0xb64244)
+#define NBL_ACL_ACTION_PRIORITY5_DEPTH (1)
+#define NBL_ACL_ACTION_PRIORITY5_WIDTH (32)
+#define NBL_ACL_ACTION_PRIORITY5_DWLEN (1)
+union acl_action_priority5_u {
+	struct acl_action_priority5 {
+		u32 action_id19_pri:2;   /* [01:00] Default:0x0 RW */
+		u32 action_id20_pri:2;   /* [03:02] Default:0x0 RW */
+		u32 action_id21_pri:2;   /* [05:04] Default:0x0 RW */
+		u32 action_id22_pri:2;   /* [07:06] Default:0x0 RW */
+		u32 action_id23_pri:2;   /* [09:08] Default:0x0 RW */
+		u32 action_id24_pri:2;   /* [11:10] Default:0x0 RW */
+		u32 action_id25_pri:2;   /* [13:12] Default:0x0 RW */
+		u32 action_id26_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id27_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id28_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id29_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id30_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 action_id31_pri:2;   /* [25:24] Default:0x0 RW */
+		u32 action_id32_pri:2;   /* [27:26] Default:0x0 RW */
+		u32 action_id33_pri:2;   /* [29:28] Default:0x0 RW */
+		u32 action_id34_pri:2;   /* [31:30] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_ACL_ACTION_PRIORITY5_DWLEN];
+} __packed;
+
+#define NBL_ACL_ACTION_PRIORITY6_ADDR  (0xb64248)
+#define NBL_ACL_ACTION_PRIORITY6_DEPTH (1)
+#define NBL_ACL_ACTION_PRIORITY6_WIDTH (32)
+#define NBL_ACL_ACTION_PRIORITY6_DWLEN (1)
+union acl_action_priority6_u {
+	struct acl_action_priority6 {
+		u32 action_id35_pri:2;   /* [01:00] Default:0x0 RW */
+		u32 action_id36_pri:2;   /* [03:02] Default:0x0 RW */
+		u32 action_id37_pri:2;   /* [05:04] Default:0x0 RW */
+		u32 action_id38_pri:2;   /* [07:06] Default:0x0 RW */
+		u32 action_id39_pri:2;   /* [09:08] Default:0x0 RW */
+		u32 action_id40_pri:2;   /* [11:10] Default:0x0 RW */
+		u32 action_id41_pri:2;   /* [13:12] Default:0x0 RW */
+		u32 action_id42_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id43_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id44_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id45_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id46_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 action_id47_pri:2;   /* [25:24] Default:0x0 RW */
+		u32 action_id48_pri:2;   /* [27:26] Default:0x0 RW */
+		u32 action_id49_pri:2;   /* [29:28] Default:0x0 RW */
+		u32 action_id50_pri:2;   /* [31:30] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_ACL_ACTION_PRIORITY6_DWLEN];
+} __packed;
+
+#define NBL_ACL_ACTION_PRIORITY7_ADDR  (0xb6424c)
+#define NBL_ACL_ACTION_PRIORITY7_DEPTH (1)
+#define NBL_ACL_ACTION_PRIORITY7_WIDTH (32)
+#define NBL_ACL_ACTION_PRIORITY7_DWLEN (1)
+union acl_action_priority7_u {
+	struct acl_action_priority7 {
+		u32 action_id51_pri:2;   /* [01:00] Default:0x0 RW */
+		u32 action_id52_pri:2;   /* [03:02] Default:0x0 RW */
+		u32 action_id53_pri:2;   /* [05:04] Default:0x0 RW */
+		u32 action_id54_pri:2;   /* [07:06] Default:0x0 RW */
+		u32 action_id55_pri:2;   /* [09:08] Default:0x0 RW */
+		u32 action_id56_pri:2;   /* [11:10] Default:0x0 RW */
+		u32 action_id57_pri:2;   /* [13:12] Default:0x0 RW */
+		u32 action_id58_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id59_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id60_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id61_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id62_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 rsv:8;               /* [31:24] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_ACTION_PRIORITY7_DWLEN];
+} __packed;
+
+#define NBL_ACL_TCAM_MASK_ADDR_ADDR  (0xb64280)
+#define NBL_ACL_TCAM_MASK_ADDR_DEPTH (1)
+#define NBL_ACL_TCAM_MASK_ADDR_WIDTH (32)
+#define NBL_ACL_TCAM_MASK_ADDR_DWLEN (1)
+union acl_tcam_mask_addr_u {
+	struct acl_tcam_mask_addr {
+		u32 addr0:9;             /* [08:00] Default:0x0 RW */
+		u32 addr0_en:1;          /* [09:09] Default:0x0 RW */
+		u32 addr1:9;             /* [18:10] Default:0x0 RW */
+		u32 addr1_en:1;          /* [19:19] Default:0x0 RW */
+		u32 rsv:12;              /* [31:20] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_TCAM_MASK_ADDR_DWLEN];
+} __packed;
+
+#define NBL_ACL_TCAM_MASK_BTM_ADDR  (0xb64284)
+#define NBL_ACL_TCAM_MASK_BTM_DEPTH (1)
+#define NBL_ACL_TCAM_MASK_BTM_WIDTH (32)
+#define NBL_ACL_TCAM_MASK_BTM_DWLEN (1)
+union acl_tcam_mask_btm_u {
+	struct acl_tcam_mask_btm {
+		u32 btm:16;              /* [15:00] Default:0x0 RW */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_TCAM_MASK_BTM_DWLEN];
+} __packed;
+
+#define NBL_ACL_CAP_ADDR  (0xb64288)
+#define NBL_ACL_CAP_DEPTH (1)
+#define NBL_ACL_CAP_WIDTH (32)
+#define NBL_ACL_CAP_DWLEN (1)
+union acl_cap_u {
+	struct acl_cap {
+		u32 onloop_cap_mode:1;   /* [00:00] Default:0x0 RW */
+		u32 noloop_cap_start:1;  /* [01:01] Default:0x0 WO */
+		u32 loop_cap_mode:1;     /* [02:02] Default:0x0 RW */
+		u32 loop_cap_start:1;    /* [03:03] Default:0x0 WO */
+		u32 rsv:28;              /* [31:04] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_CAP_DWLEN];
+} __packed;
+
+#define NBL_ACL_FLOW_ID_STAT_ACT_ADDR  (0xb64300)
+#define NBL_ACL_FLOW_ID_STAT_ACT_DEPTH (1)
+#define NBL_ACL_FLOW_ID_STAT_ACT_WIDTH (32)
+#define NBL_ACL_FLOW_ID_STAT_ACT_DWLEN (1)
+union acl_flow_id_stat_act_u {
+	struct acl_flow_id_stat_act {
+		u32 flow_id_en:1;        /* [00:00] Default:0x0 RW */
+		u32 rsv:31;              /* [31:01] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_FLOW_ID_STAT_ACT_DWLEN];
+} __packed;
+
+#define NBL_ACL_FLOW_ID_STAT_GLB_CLR_ADDR  (0xb64304)
+#define NBL_ACL_FLOW_ID_STAT_GLB_CLR_DEPTH (1)
+#define NBL_ACL_FLOW_ID_STAT_GLB_CLR_WIDTH (32)
+#define NBL_ACL_FLOW_ID_STAT_GLB_CLR_DWLEN (1)
+union acl_flow_id_stat_glb_clr_u {
+	struct acl_flow_id_stat_glb_clr {
+		u32 glb_clr:1;           /* [00:00] Default:0x0 WO */
+		u32 rsv:31;              /* [31:01] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_FLOW_ID_STAT_GLB_CLR_DWLEN];
+} __packed;
+
+#define NBL_ACL_FLOW_ID_STAT_RD_CLR_ADDR  (0xb64308)
+#define NBL_ACL_FLOW_ID_STAT_RD_CLR_DEPTH (1)
+#define NBL_ACL_FLOW_ID_STAT_RD_CLR_WIDTH (32)
+#define NBL_ACL_FLOW_ID_STAT_RD_CLR_DWLEN (1)
+union acl_flow_id_stat_rd_clr_u {
+	struct acl_flow_id_stat_rd_clr {
+		u32 cpu_rd_clr:1;        /* [00:00] Default:0x0 RW */
+		u32 rsv:31;              /* [31:01] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_FLOW_ID_STAT_RD_CLR_DWLEN];
+} __packed;
+
+#define NBL_ACL_FLOW_ID_STAT_DONE_ADDR  (0xb64310)
+#define NBL_ACL_FLOW_ID_STAT_DONE_DEPTH (1)
+#define NBL_ACL_FLOW_ID_STAT_DONE_WIDTH (32)
+#define NBL_ACL_FLOW_ID_STAT_DONE_DWLEN (1)
+union acl_flow_id_stat_done_u {
+	struct acl_flow_id_stat_done {
+		u32 glb_clr_done:1;      /* [00:00] Default:0x0 RO */
+		u32 stat_init_done:1;    /* [01:01] Default:0x0 RO */
+		u32 rsv:30;              /* [31:02] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_FLOW_ID_STAT_DONE_DWLEN];
+} __packed;
+
+#define NBL_ACL_SCAN_TH_ADDR  (0xb64318)
+#define NBL_ACL_SCAN_TH_DEPTH (1)
+#define NBL_ACL_SCAN_TH_WIDTH (32)
+#define NBL_ACL_SCAN_TH_DWLEN (1)
+union acl_scan_th_u {
+	struct acl_scan_th {
+		u32 scan_th:10;          /* [09:00] Default:0xff RW */
+		u32 rsv:22;              /* [31:10] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_SCAN_TH_DWLEN];
+} __packed;
+
+#define NBL_ACL_SCAN_EN_ADDR  (0xb6431c)
+#define NBL_ACL_SCAN_EN_DEPTH (1)
+#define NBL_ACL_SCAN_EN_WIDTH (32)
+#define NBL_ACL_SCAN_EN_DWLEN (1)
+union acl_scan_en_u {
+	struct acl_scan_en {
+		u32 scan_en:1;           /* [00:00] Default:0x0 RW */
+		u32 rsv:31;              /* [31:01] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_SCAN_EN_DWLEN];
+} __packed;
+
+#define NBL_ACL_STAT_ID_STAT_GLB_CLR_ADDR  (0xb64320)
+#define NBL_ACL_STAT_ID_STAT_GLB_CLR_DEPTH (1)
+#define NBL_ACL_STAT_ID_STAT_GLB_CLR_WIDTH (32)
+#define NBL_ACL_STAT_ID_STAT_GLB_CLR_DWLEN (1)
+union acl_stat_id_stat_glb_clr_u {
+	struct acl_stat_id_stat_glb_clr {
+		u32 glb_clr:1;           /* [00:00] Default:0x0 WO */
+		u32 rsv:31;              /* [31:01] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_ACL_STAT_ID_STAT_GLB_CLR_DWLEN];
+} __packed;
+
+#define NBL_ACL_STAT_ID_STAT_RD_CLR_ADDR  (0xb64324)
+#define NBL_ACL_STAT_ID_STAT_RD_CLR_DEPTH (1)
+#define NBL_ACL_STAT_ID_STAT_RD_CLR_WIDTH (32)
+#define NBL_ACL_STAT_ID_STAT_RD_CLR_DWLEN (1)
+union acl_stat_id_stat_rd_clr_u {
+	struct acl_stat_id_stat_rd_clr {
+		u32 cpu_rd_clr:1;        /* [00:00] Default:0x0 RW */
+		u32 rsv:31;              /* [31:01] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_STAT_ID_STAT_RD_CLR_DWLEN];
+} __packed;
+
+#define NBL_ACL_STAT_ID_STAT_DONE_ADDR  (0xb64328)
+#define NBL_ACL_STAT_ID_STAT_DONE_DEPTH (1)
+#define NBL_ACL_STAT_ID_STAT_DONE_WIDTH (32)
+#define NBL_ACL_STAT_ID_STAT_DONE_DWLEN (1)
+union acl_stat_id_stat_done_u {
+	struct acl_stat_id_stat_done {
+		u32 glb_clr_done:1;      /* [00:00] Default:0x0 RO */
+		u32 stat_init_done:1;    /* [01:01] Default:0x0 RO */
+		u32 rsv:30;              /* [31:02] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_STAT_ID_STAT_DONE_DWLEN];
+} __packed;
+
+#define NBL_ACL_STAT_ID_ACT_ADDR  (0xb6432c)
+#define NBL_ACL_STAT_ID_ACT_DEPTH (1)
+#define NBL_ACL_STAT_ID_ACT_WIDTH (32)
+#define NBL_ACL_STAT_ID_ACT_DWLEN (1)
+union acl_stat_id_act_u {
+	struct acl_stat_id_act {
+		u32 act_id:6;            /* [05:00] Default:0x10 RW */
+		u32 act_en:1;            /* [06:06] Default:0x0 RW */
+		u32 rsv:25;              /* [31:07] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_STAT_ID_ACT_DWLEN];
+} __packed;
+
+#define NBL_ACL_CAR_CTRL_ADDR  (0xb64410)
+#define NBL_ACL_CAR_CTRL_DEPTH (1)
+#define NBL_ACL_CAR_CTRL_WIDTH (32)
+#define NBL_ACL_CAR_CTRL_DWLEN (1)
+union acl_car_ctrl_u {
+	struct acl_car_ctrl {
+		u32 sctr_car:1;          /* [00:00] Default:0x1 RW */
+		u32 rctr_car:1;          /* [01:01] Default:0x1 RW */
+		u32 rc_car:1;            /* [02:02] Default:0x1 RW */
+		u32 tbl_rc_car:1;        /* [03:03] Default:0x1 RW */
+		u32 rsv:28;              /* [31:04] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_CAR_CTRL_DWLEN];
+} __packed;
+
+#define NBL_ACL_IN_ADDR  (0xb64600)
+#define NBL_ACL_IN_DEPTH (1)
+#define NBL_ACL_IN_WIDTH (32)
+#define NBL_ACL_IN_DWLEN (1)
+union acl_in_u {
+	struct acl_in {
+		u32 cnt:32;              /* [31:00] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_ACL_IN_DWLEN];
+} __packed;
+
+#define NBL_ACL_OUT_ADDR  (0xb64608)
+#define NBL_ACL_OUT_DEPTH (1)
+#define NBL_ACL_OUT_WIDTH (32)
+#define NBL_ACL_OUT_DWLEN (1)
+union acl_out_u {
+	struct acl_out {
+		u32 cnt:32;              /* [31:00] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_ACL_OUT_DWLEN];
+} __packed;
+
+#define NBL_ACL_TCAM_SE_ADDR  (0xb6461c)
+#define NBL_ACL_TCAM_SE_DEPTH (1)
+#define NBL_ACL_TCAM_SE_WIDTH (32)
+#define NBL_ACL_TCAM_SE_DWLEN (1)
+union acl_tcam_se_u {
+	struct acl_tcam_se {
+		u32 cnt:32;              /* [31:00] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_ACL_TCAM_SE_DWLEN];
+} __packed;
+
+#define NBL_ACL_TCAM_HIT_ADDR  (0xb64624)
+#define NBL_ACL_TCAM_HIT_DEPTH (1)
+#define NBL_ACL_TCAM_HIT_WIDTH (32)
+#define NBL_ACL_TCAM_HIT_DWLEN (1)
+union acl_tcam_hit_u {
+	struct acl_tcam_hit {
+		u32 cnt:32;              /* [31:00] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_ACL_TCAM_HIT_DWLEN];
+} __packed;
+
+#define NBL_ACL_TCAM_HIT_ADDR0_ADDR  (0xb6462c)
+#define NBL_ACL_TCAM_HIT_ADDR0_DEPTH (1)
+#define NBL_ACL_TCAM_HIT_ADDR0_WIDTH (32)
+#define NBL_ACL_TCAM_HIT_ADDR0_DWLEN (1)
+union acl_tcam_hit_addr0_u {
+	struct acl_tcam_hit_addr0 {
+		u32 addr0:9;             /* [08:00] Default:0x0 RO */
+		u32 tcam_id0:4;          /* [12:09] Default:0x0 RO */
+		u32 addr1:9;             /* [21:13] Default:0x0 RO */
+		u32 tcam_id1:4;          /* [25:22] Default:0x0 RO */
+		u32 rsv:6;               /* [31:26] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_TCAM_HIT_ADDR0_DWLEN];
+} __packed;
+
+#define NBL_ACL_TCAM_HIT_ADDR1_ADDR  (0xb64630)
+#define NBL_ACL_TCAM_HIT_ADDR1_DEPTH (1)
+#define NBL_ACL_TCAM_HIT_ADDR1_WIDTH (32)
+#define NBL_ACL_TCAM_HIT_ADDR1_DWLEN (1)
+union acl_tcam_hit_addr1_u {
+	struct acl_tcam_hit_addr1 {
+		u32 addr2:9;             /* [08:00] Default:0x0 RO */
+		u32 tcam_id2:4;          /* [12:09] Default:0x0 RO */
+		u32 addr3:9;             /* [21:13] Default:0x0 RO */
+		u32 tcam_id3:4;          /* [25:22] Default:0x0 RO */
+		u32 rsv:6;               /* [31:26] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_TCAM_HIT_ADDR1_DWLEN];
+} __packed;
+
+#define NBL_ACL_TCAM_HIT_ADDR2_ADDR  (0xb64634)
+#define NBL_ACL_TCAM_HIT_ADDR2_DEPTH (1)
+#define NBL_ACL_TCAM_HIT_ADDR2_WIDTH (32)
+#define NBL_ACL_TCAM_HIT_ADDR2_DWLEN (1)
+union acl_tcam_hit_addr2_u {
+	struct acl_tcam_hit_addr2 {
+		u32 addr4:9;             /* [08:00] Default:0x0 RO */
+		u32 tcam_id4:4;          /* [12:09] Default:0x0 RO */
+		u32 addr5:9;             /* [21:13] Default:0x0 RO */
+		u32 tcam_id5:4;          /* [25:22] Default:0x0 RO */
+		u32 rsv:6;               /* [31:26] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_TCAM_HIT_ADDR2_DWLEN];
+} __packed;
+
+#define NBL_ACL_TCAM_HIT_ADDR3_ADDR  (0xb64638)
+#define NBL_ACL_TCAM_HIT_ADDR3_DEPTH (1)
+#define NBL_ACL_TCAM_HIT_ADDR3_WIDTH (32)
+#define NBL_ACL_TCAM_HIT_ADDR3_DWLEN (1)
+union acl_tcam_hit_addr3_u {
+	struct acl_tcam_hit_addr3 {
+		u32 addr6:9;             /* [08:00] Default:0x0 RO */
+		u32 tcam_id6:4;          /* [12:09] Default:0x0 RO */
+		u32 addr7:9;             /* [21:13] Default:0x0 RO */
+		u32 tcam_id7:4;          /* [25:22] Default:0x0 RO */
+		u32 rsv:6;               /* [31:26] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_TCAM_HIT_ADDR3_DWLEN];
+} __packed;
+
+#define NBL_ACL_TCAM_HIT_ADDR4_ADDR  (0xb6463c)
+#define NBL_ACL_TCAM_HIT_ADDR4_DEPTH (1)
+#define NBL_ACL_TCAM_HIT_ADDR4_WIDTH (32)
+#define NBL_ACL_TCAM_HIT_ADDR4_DWLEN (1)
+union acl_tcam_hit_addr4_u {
+	struct acl_tcam_hit_addr4 {
+		u32 addr8:9;             /* [08:00] Default:0x0 RO */
+		u32 tcam_id8:4;          /* [12:09] Default:0x0 RO */
+		u32 addr9:9;             /* [21:13] Default:0x0 RO */
+		u32 tcam_id9:4;          /* [25:22] Default:0x0 RO */
+		u32 rsv:6;               /* [31:26] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_TCAM_HIT_ADDR4_DWLEN];
+} __packed;
+
+#define NBL_ACL_TCAM_HIT_ADDR5_ADDR  (0xb64640)
+#define NBL_ACL_TCAM_HIT_ADDR5_DEPTH (1)
+#define NBL_ACL_TCAM_HIT_ADDR5_WIDTH (32)
+#define NBL_ACL_TCAM_HIT_ADDR5_DWLEN (1)
+union acl_tcam_hit_addr5_u {
+	struct acl_tcam_hit_addr5 {
+		u32 addr10:9;            /* [08:00] Default:0x0 RO */
+		u32 tcam_id10:4;         /* [12:09] Default:0x0 RO */
+		u32 addr11:9;            /* [21:13] Default:0x0 RO */
+		u32 tcam_id11:4;         /* [25:22] Default:0x0 RO */
+		u32 rsv:6;               /* [31:26] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_TCAM_HIT_ADDR5_DWLEN];
+} __packed;
+
+#define NBL_ACL_TCAM_HIT_ADDR6_ADDR  (0xb64644)
+#define NBL_ACL_TCAM_HIT_ADDR6_DEPTH (1)
+#define NBL_ACL_TCAM_HIT_ADDR6_WIDTH (32)
+#define NBL_ACL_TCAM_HIT_ADDR6_DWLEN (1)
+union acl_tcam_hit_addr6_u {
+	struct acl_tcam_hit_addr6 {
+		u32 addr12:9;            /* [08:00] Default:0x0 RO */
+		u32 tcam_id12:4;         /* [12:09] Default:0x0 RO */
+		u32 addr13:9;            /* [21:13] Default:0x0 RO */
+		u32 tcam_id13:4;         /* [25:22] Default:0x0 RO */
+		u32 rsv:6;               /* [31:26] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_TCAM_HIT_ADDR6_DWLEN];
+} __packed;
+
+#define NBL_ACL_TCAM_HIT_ADDR7_ADDR  (0xb64648)
+#define NBL_ACL_TCAM_HIT_ADDR7_DEPTH (1)
+#define NBL_ACL_TCAM_HIT_ADDR7_WIDTH (32)
+#define NBL_ACL_TCAM_HIT_ADDR7_DWLEN (1)
+union acl_tcam_hit_addr7_u {
+	struct acl_tcam_hit_addr7 {
+		u32 addr14:9;            /* [08:00] Default:0x0 RO */
+		u32 tcam_id14:4;         /* [12:09] Default:0x0 RO */
+		u32 addr15:9;            /* [21:13] Default:0x0 RO */
+		u32 tcam_id15:4;         /* [25:22] Default:0x0 RO */
+		u32 rsv:6;               /* [31:26] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_TCAM_HIT_ADDR7_DWLEN];
+} __packed;
+
+#define NBL_ACL_CMP_SET_VEC_ADDR  (0xb64650)
+#define NBL_ACL_CMP_SET_VEC_DEPTH (1)
+#define NBL_ACL_CMP_SET_VEC_WIDTH (32)
+#define NBL_ACL_CMP_SET_VEC_DWLEN (1)
+union acl_cmp_set_vec_u {
+	struct acl_cmp_set_vec {
+		u32 vec:32;              /* [31:00] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_CMP_SET_VEC_DWLEN];
+} __packed;
+
+#define NBL_ACL_TCAM_NOLOOP_HIT_VLD_ADDR  (0xb64670)
+#define NBL_ACL_TCAM_NOLOOP_HIT_VLD_DEPTH (1)
+#define NBL_ACL_TCAM_NOLOOP_HIT_VLD_WIDTH (32)
+#define NBL_ACL_TCAM_NOLOOP_HIT_VLD_DWLEN (1)
+union acl_tcam_noloop_hit_vld_u {
+	struct acl_tcam_noloop_hit_vld {
+		u32 hit_vld:16;          /* [15:00] Default:0x0 RO */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_TCAM_NOLOOP_HIT_VLD_DWLEN];
+} __packed;
+
+#define NBL_ACL_TCAM_LOOP_HIT_VLD_ADDR  (0xb64674)
+#define NBL_ACL_TCAM_LOOP_HIT_VLD_DEPTH (1)
+#define NBL_ACL_TCAM_LOOP_HIT_VLD_WIDTH (32)
+#define NBL_ACL_TCAM_LOOP_HIT_VLD_DWLEN (1)
+union acl_tcam_loop_hit_vld_u {
+	struct acl_tcam_loop_hit_vld {
+		u32 hit_vld:16;          /* [15:00] Default:0x0 RO */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_TCAM_LOOP_HIT_VLD_DWLEN];
+} __packed;
+
+#define NBL_ACL_ISE_TCAM_HIT_ADDR  (0xb64680)
+#define NBL_ACL_ISE_TCAM_HIT_DEPTH (1)
+#define NBL_ACL_ISE_TCAM_HIT_WIDTH (32)
+#define NBL_ACL_ISE_TCAM_HIT_DWLEN (1)
+union acl_ise_tcam_hit_u {
+	struct acl_ise_tcam_hit {
+		u32 cnt:32;              /* [31:00] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_ACL_ISE_TCAM_HIT_DWLEN];
+} __packed;
+
+#define NBL_ACL_ISE_TCAM_NOHIT_ADDR  (0xb64684)
+#define NBL_ACL_ISE_TCAM_NOHIT_DEPTH (1)
+#define NBL_ACL_ISE_TCAM_NOHIT_WIDTH (32)
+#define NBL_ACL_ISE_TCAM_NOHIT_DWLEN (1)
+union acl_ise_tcam_nohit_u {
+	struct acl_ise_tcam_nohit {
+		u32 cnt:32;              /* [31:00] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_ACL_ISE_TCAM_NOHIT_DWLEN];
+} __packed;
+
+#define NBL_ACL_LOOP_TCAM_HIT_ADDR  (0xb64688)
+#define NBL_ACL_LOOP_TCAM_HIT_DEPTH (1)
+#define NBL_ACL_LOOP_TCAM_HIT_WIDTH (32)
+#define NBL_ACL_LOOP_TCAM_HIT_DWLEN (1)
+union acl_loop_tcam_hit_u {
+	struct acl_loop_tcam_hit {
+		u32 cnt:32;              /* [31:00] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_ACL_LOOP_TCAM_HIT_DWLEN];
+} __packed;
+
+#define NBL_ACL_NOLOOP_TCAM_HIT_ADDR  (0xb6468c)
+#define NBL_ACL_NOLOOP_TCAM_HIT_DEPTH (1)
+#define NBL_ACL_NOLOOP_TCAM_HIT_WIDTH (32)
+#define NBL_ACL_NOLOOP_TCAM_HIT_DWLEN (1)
+union acl_noloop_tcam_hit_u {
+	struct acl_noloop_tcam_hit {
+		u32 cnt:32;              /* [31:00] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_ACL_NOLOOP_TCAM_HIT_DWLEN];
+} __packed;
+
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR0_ADDR  (0xb64690)
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR0_DEPTH (1)
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR0_WIDTH (32)
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR0_DWLEN (1)
+union acl_tcam_hit_loop_addr0_u {
+	struct acl_tcam_hit_loop_addr0 {
+		u32 addr0:9;             /* [08:00] Default:0x0 RO */
+		u32 tcam_id0:4;          /* [12:09] Default:0x0 RO */
+		u32 addr1:9;             /* [21:13] Default:0x0 RO */
+		u32 tcam_id1:4;          /* [25:22] Default:0x0 RO */
+		u32 rsv:6;               /* [31:26] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_TCAM_HIT_LOOP_ADDR0_DWLEN];
+} __packed;
+
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR1_ADDR  (0xb64694)
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR1_DEPTH (1)
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR1_WIDTH (32)
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR1_DWLEN (1)
+union acl_tcam_hit_loop_addr1_u {
+	struct acl_tcam_hit_loop_addr1 {
+		u32 addr2:9;             /* [08:00] Default:0x0 RO */
+		u32 tcam_id2:4;          /* [12:09] Default:0x0 RO */
+		u32 addr3:9;             /* [21:13] Default:0x0 RO */
+		u32 tcam_id3:4;          /* [25:22] Default:0x0 RO */
+		u32 rsv:6;               /* [31:26] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_TCAM_HIT_LOOP_ADDR1_DWLEN];
+} __packed;
+
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR2_ADDR  (0xb64698)
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR2_DEPTH (1)
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR2_WIDTH (32)
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR2_DWLEN (1)
+union acl_tcam_hit_loop_addr2_u {
+	struct acl_tcam_hit_loop_addr2 {
+		u32 addr4:9;             /* [08:00] Default:0x0 RO */
+		u32 tcam_id4:4;          /* [12:09] Default:0x0 RO */
+		u32 addr5:9;             /* [21:13] Default:0x0 RO */
+		u32 tcam_id5:4;          /* [25:22] Default:0x0 RO */
+		u32 rsv:6;               /* [31:26] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_TCAM_HIT_LOOP_ADDR2_DWLEN];
+} __packed;
+
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR3_ADDR  (0xb6469c)
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR3_DEPTH (1)
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR3_WIDTH (32)
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR3_DWLEN (1)
+union acl_tcam_hit_loop_addr3_u {
+	struct acl_tcam_hit_loop_addr3 {
+		u32 addr6:9;             /* [08:00] Default:0x0 RO */
+		u32 tcam_id6:4;          /* [12:09] Default:0x0 RO */
+		u32 addr7:9;             /* [21:13] Default:0x0 RO */
+		u32 tcam_id7:4;          /* [25:22] Default:0x0 RO */
+		u32 rsv:6;               /* [31:26] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_TCAM_HIT_LOOP_ADDR3_DWLEN];
+} __packed;
+
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR4_ADDR  (0xb646a0)
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR4_DEPTH (1)
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR4_WIDTH (32)
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR4_DWLEN (1)
+union acl_tcam_hit_loop_addr4_u {
+	struct acl_tcam_hit_loop_addr4 {
+		u32 addr8:9;             /* [08:00] Default:0x0 RO */
+		u32 tcam_id8:4;          /* [12:09] Default:0x0 RO */
+		u32 addr9:9;             /* [21:13] Default:0x0 RO */
+		u32 tcam_id9:4;          /* [25:22] Default:0x0 RO */
+		u32 rsv:6;               /* [31:26] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_TCAM_HIT_LOOP_ADDR4_DWLEN];
+} __packed;
+
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR5_ADDR  (0xb646a4)
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR5_DEPTH (1)
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR5_WIDTH (32)
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR5_DWLEN (1)
+union acl_tcam_hit_loop_addr5_u {
+	struct acl_tcam_hit_loop_addr5 {
+		u32 addr10:9;            /* [08:00] Default:0x0 RO */
+		u32 tcam_id10:4;         /* [12:09] Default:0x0 RO */
+		u32 addr11:9;            /* [21:13] Default:0x0 RO */
+		u32 tcam_id11:4;         /* [25:22] Default:0x0 RO */
+		u32 rsv:6;               /* [31:26] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_TCAM_HIT_LOOP_ADDR5_DWLEN];
+} __packed;
+
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR6_ADDR  (0xb646a8)
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR6_DEPTH (1)
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR6_WIDTH (32)
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR6_DWLEN (1)
+union acl_tcam_hit_loop_addr6_u {
+	struct acl_tcam_hit_loop_addr6 {
+		u32 addr12:9;            /* [08:00] Default:0x0 RO */
+		u32 tcam_id12:4;         /* [12:09] Default:0x0 RO */
+		u32 addr13:9;            /* [21:13] Default:0x0 RO */
+		u32 tcam_id13:4;         /* [25:22] Default:0x0 RO */
+		u32 rsv:6;               /* [31:26] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_TCAM_HIT_LOOP_ADDR6_DWLEN];
+} __packed;
+
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR7_ADDR  (0xb646ac)
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR7_DEPTH (1)
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR7_WIDTH (32)
+#define NBL_ACL_TCAM_HIT_LOOP_ADDR7_DWLEN (1)
+union acl_tcam_hit_loop_addr7_u {
+	struct acl_tcam_hit_loop_addr7 {
+		u32 addr14:9;            /* [08:00] Default:0x0 RO */
+		u32 tcam_id14:4;         /* [12:09] Default:0x0 RO */
+		u32 addr15:9;            /* [21:13] Default:0x0 RO */
+		u32 tcam_id15:4;         /* [25:22] Default:0x0 RO */
+		u32 rsv:6;               /* [31:26] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_TCAM_HIT_LOOP_ADDR7_DWLEN];
+} __packed;
+
+#define NBL_ACL_OUT_DROP_ADDR  (0xb646c8)
+#define NBL_ACL_OUT_DROP_DEPTH (1)
+#define NBL_ACL_OUT_DROP_WIDTH (32)
+#define NBL_ACL_OUT_DROP_DWLEN (1)
+union acl_out_drop_u {
+	struct acl_out_drop {
+		u32 cnt:32;              /* [31:00] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_ACL_OUT_DROP_DWLEN];
+} __packed;
+
+#define NBL_ACL_NXT_STAGE_ADDR  (0xb646d0)
+#define NBL_ACL_NXT_STAGE_DEPTH (1)
+#define NBL_ACL_NXT_STAGE_WIDTH (32)
+#define NBL_ACL_NXT_STAGE_DWLEN (1)
+union acl_nxt_stage_u {
+	struct acl_nxt_stage {
+		u32 in_nxt_stage:4;      /* [03:00] Default:0x0 RO */
+		u32 out_nxt_satge:4;     /* [07:04] Default:0x0 RO */
+		u32 rsv:24;              /* [31:08] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_NXT_STAGE_DWLEN];
+} __packed;
+
+#define NBL_ACL_BP_STATE_ADDR  (0xb64700)
+#define NBL_ACL_BP_STATE_DEPTH (1)
+#define NBL_ACL_BP_STATE_WIDTH (32)
+#define NBL_ACL_BP_STATE_DWLEN (1)
+union acl_bp_state_u {
+	struct acl_bp_state {
+		u32 in_bp:1;             /* [00:00] Default:0x0 RO */
+		u32 out_bp:1;            /* [01:01] Default:0x0 RO */
+		u32 inter_bp:1;          /* [02:02] Default:0x0 RO */
+		u32 rsv:29;              /* [31:03] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_BP_STATE_DWLEN];
+} __packed;
+
+#define NBL_ACL_CMDQ_REQ_HIT_ADDR  (0xb647a0)
+#define NBL_ACL_CMDQ_REQ_HIT_DEPTH (1)
+#define NBL_ACL_CMDQ_REQ_HIT_WIDTH (32)
+#define NBL_ACL_CMDQ_REQ_HIT_DWLEN (1)
+union acl_cmdq_req_hit_u {
+	struct acl_cmdq_req_hit {
+		u32 cnt:32;              /* [31:00] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_ACL_CMDQ_REQ_HIT_DWLEN];
+} __packed;
+
+#define NBL_ACL_CMDQ_REQ_NO_HIT_ADDR  (0xb647a8)
+#define NBL_ACL_CMDQ_REQ_NO_HIT_DEPTH (1)
+#define NBL_ACL_CMDQ_REQ_NO_HIT_WIDTH (32)
+#define NBL_ACL_CMDQ_REQ_NO_HIT_DWLEN (1)
+union acl_cmdq_req_no_hit_u {
+	struct acl_cmdq_req_no_hit {
+		u32 cnt:32;              /* [31:00] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_ACL_CMDQ_REQ_NO_HIT_DWLEN];
+} __packed;
+
+#define NBL_ACL_INSERT_SEARCH_CTRL_ADDR  (0xb64880)
+#define NBL_ACL_INSERT_SEARCH_CTRL_DEPTH (1)
+#define NBL_ACL_INSERT_SEARCH_CTRL_WIDTH (32)
+#define NBL_ACL_INSERT_SEARCH_CTRL_DWLEN (1)
+union acl_insert_search_ctrl_u {
+	struct acl_insert_search_ctrl {
+		u32 profile_idx:4;       /* [03:00] Default:0x0 RW */
+		u32 start:1;             /* [04:04] Default:0x0 WO */
+		u32 rsv:27;              /* [31:05] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_INSERT_SEARCH_CTRL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INSERT_SEARCH_ACK_ADDR  (0xb64884)
+#define NBL_ACL_INSERT_SEARCH_ACK_DEPTH (1)
+#define NBL_ACL_INSERT_SEARCH_ACK_WIDTH (32)
+#define NBL_ACL_INSERT_SEARCH_ACK_DWLEN (1)
+union acl_insert_search_ack_u {
+	struct acl_insert_search_ack {
+		u32 ack:1;               /* [00:00] Default:0x0 RC */
+		u32 status:2;            /* [02:01] Default:0x0 RWW */
+		u32 rsv:29;              /* [31:03] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_INSERT_SEARCH_ACK_DWLEN];
+} __packed;
+
+#define NBL_ACL_INSERT_SEARCH_DATA_ADDR  (0xb64890)
+#define NBL_ACL_INSERT_SEARCH_DATA_DEPTH (20)
+#define NBL_ACL_INSERT_SEARCH_DATA_WIDTH (32)
+#define NBL_ACL_INSERT_SEARCH_DATA_DWLEN (1)
+union acl_insert_search_data_u {
+	struct acl_insert_search_data {
+		u32 data:32;             /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INSERT_SEARCH_DATA_DWLEN];
+} __packed;
+#define NBL_ACL_INSERT_SEARCH_DATA_REG(r) (NBL_ACL_INSERT_SEARCH_DATA_ADDR + \
+		(NBL_ACL_INSERT_SEARCH_DATA_DWLEN * 4) * (r))
+
+#define NBL_ACL_INDIRECT_ACCESS_ACK_ADDR  (0xb648f0)
+#define NBL_ACL_INDIRECT_ACCESS_ACK_DEPTH (1)
+#define NBL_ACL_INDIRECT_ACCESS_ACK_WIDTH (32)
+#define NBL_ACL_INDIRECT_ACCESS_ACK_DWLEN (1)
+union acl_indirect_access_ack_u {
+	struct acl_indirect_access_ack {
+		u32 done:1;              /* [00:00] Default:0x0 RC */
+		u32 status:16;           /* [16:01] Default:0x0 RWW */
+		u32 rsv:15;              /* [31:17] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_ACCESS_ACK_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_CTRL_ADDR  (0xb648f4)
+#define NBL_ACL_INDIRECT_CTRL_DEPTH (1)
+#define NBL_ACL_INDIRECT_CTRL_WIDTH (32)
+#define NBL_ACL_INDIRECT_CTRL_DWLEN (1)
+union acl_indirect_ctrl_u {
+	struct acl_indirect_ctrl {
+		u32 tcam_addr:9;         /* [08:00] Default:0x0 RW */
+		u32 cpu_acl_cfg_start:1; /* [09:09] Default:0x0 WO */
+		u32 cpu_acl_cfg_rw:1;    /* [10:10] Default:0x0 RW */
+		u32 rsv:5;               /* [15:11] Default:0x0 WO */
+		u32 acc_btm:16;          /* [31:16] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_CTRL_DWLEN];
+} __packed;
+
+#define NBL_ACL_VALID_BIT_ADDR  (0xb64900)
+#define NBL_ACL_VALID_BIT_DEPTH (1)
+#define NBL_ACL_VALID_BIT_WIDTH (32)
+#define NBL_ACL_VALID_BIT_DWLEN (1)
+union acl_valid_bit_u {
+	struct acl_valid_bit {
+		u32 valid_bit:16;        /* [15:00] Default:0x0 RWW */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_VALID_BIT_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM0_XL_ADDR  (0xb64904)
+#define NBL_ACL_INDIRECT_TCAM0_XL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM0_XL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM0_XL_DWLEN (1)
+union acl_indirect_tcam0_xl_u {
+	struct acl_indirect_tcam0_xl {
+		u32 xl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM0_XL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM0_XH_ADDR  (0xb64908)
+#define NBL_ACL_INDIRECT_TCAM0_XH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM0_XH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM0_XH_DWLEN (1)
+union acl_indirect_tcam0_xh_u {
+	struct acl_indirect_tcam0_xh {
+		u32 xh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM0_XH_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM1_XL_ADDR  (0xb6490c)
+#define NBL_ACL_INDIRECT_TCAM1_XL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM1_XL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM1_XL_DWLEN (1)
+union acl_indirect_tcam1_xl_u {
+	struct acl_indirect_tcam1_xl {
+		u32 xl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM1_XL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM1_XH_ADDR  (0xb64910)
+#define NBL_ACL_INDIRECT_TCAM1_XH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM1_XH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM1_XH_DWLEN (1)
+union acl_indirect_tcam1_xh_u {
+	struct acl_indirect_tcam1_xh {
+		u32 xh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM1_XH_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM2_XL_ADDR  (0xb64914)
+#define NBL_ACL_INDIRECT_TCAM2_XL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM2_XL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM2_XL_DWLEN (1)
+union acl_indirect_tcam2_xl_u {
+	struct acl_indirect_tcam2_xl {
+		u32 xl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM2_XL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM2_XH_ADDR  (0xb64918)
+#define NBL_ACL_INDIRECT_TCAM2_XH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM2_XH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM2_XH_DWLEN (1)
+union acl_indirect_tcam2_xh_u {
+	struct acl_indirect_tcam2_xh {
+		u32 xh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM2_XH_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM3_XL_ADDR  (0xb6491c)
+#define NBL_ACL_INDIRECT_TCAM3_XL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM3_XL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM3_XL_DWLEN (1)
+union acl_indirect_tcam3_xl_u {
+	struct acl_indirect_tcam3_xl {
+		u32 xl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM3_XL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM3_XH_ADDR  (0xb64920)
+#define NBL_ACL_INDIRECT_TCAM3_XH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM3_XH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM3_XH_DWLEN (1)
+union acl_indirect_tcam3_xh_u {
+	struct acl_indirect_tcam3_xh {
+		u32 xh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM3_XH_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM4_XL_ADDR  (0xb64924)
+#define NBL_ACL_INDIRECT_TCAM4_XL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM4_XL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM4_XL_DWLEN (1)
+union acl_indirect_tcam4_xl_u {
+	struct acl_indirect_tcam4_xl {
+		u32 xl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM4_XL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM4_XH_ADDR  (0xb64928)
+#define NBL_ACL_INDIRECT_TCAM4_XH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM4_XH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM4_XH_DWLEN (1)
+union acl_indirect_tcam4_xh_u {
+	struct acl_indirect_tcam4_xh {
+		u32 xh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM4_XH_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM5_XL_ADDR  (0xb6492c)
+#define NBL_ACL_INDIRECT_TCAM5_XL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM5_XL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM5_XL_DWLEN (1)
+union acl_indirect_tcam5_xl_u {
+	struct acl_indirect_tcam5_xl {
+		u32 xl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM5_XL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM5_XH_ADDR  (0xb64930)
+#define NBL_ACL_INDIRECT_TCAM5_XH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM5_XH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM5_XH_DWLEN (1)
+union acl_indirect_tcam5_xh_u {
+	struct acl_indirect_tcam5_xh {
+		u32 xh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM5_XH_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM6_XL_ADDR  (0xb64934)
+#define NBL_ACL_INDIRECT_TCAM6_XL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM6_XL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM6_XL_DWLEN (1)
+union acl_indirect_tcam6_xl_u {
+	struct acl_indirect_tcam6_xl {
+		u32 xl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM6_XL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM6_XH_ADDR  (0xb64938)
+#define NBL_ACL_INDIRECT_TCAM6_XH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM6_XH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM6_XH_DWLEN (1)
+union acl_indirect_tcam6_xh_u {
+	struct acl_indirect_tcam6_xh {
+		u32 xh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM6_XH_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM7_XL_ADDR  (0xb6493c)
+#define NBL_ACL_INDIRECT_TCAM7_XL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM7_XL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM7_XL_DWLEN (1)
+union acl_indirect_tcam7_xl_u {
+	struct acl_indirect_tcam7_xl {
+		u32 xl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM7_XL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM7_XH_ADDR  (0xb64940)
+#define NBL_ACL_INDIRECT_TCAM7_XH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM7_XH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM7_XH_DWLEN (1)
+union acl_indirect_tcam7_xh_u {
+	struct acl_indirect_tcam7_xh {
+		u32 xh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM7_XH_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM8_XL_ADDR  (0xb64944)
+#define NBL_ACL_INDIRECT_TCAM8_XL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM8_XL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM8_XL_DWLEN (1)
+union acl_indirect_tcam8_xl_u {
+	struct acl_indirect_tcam8_xl {
+		u32 xl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM8_XL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM8_XH_ADDR  (0xb64948)
+#define NBL_ACL_INDIRECT_TCAM8_XH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM8_XH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM8_XH_DWLEN (1)
+union acl_indirect_tcam8_xh_u {
+	struct acl_indirect_tcam8_xh {
+		u32 xh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM8_XH_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM9_XL_ADDR  (0xb6494c)
+#define NBL_ACL_INDIRECT_TCAM9_XL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM9_XL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM9_XL_DWLEN (1)
+union acl_indirect_tcam9_xl_u {
+	struct acl_indirect_tcam9_xl {
+		u32 xl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM9_XL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM9_XH_ADDR  (0xb64950)
+#define NBL_ACL_INDIRECT_TCAM9_XH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM9_XH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM9_XH_DWLEN (1)
+union acl_indirect_tcam9_xh_u {
+	struct acl_indirect_tcam9_xh {
+		u32 xh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM9_XH_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM10_XL_ADDR  (0xb64954)
+#define NBL_ACL_INDIRECT_TCAM10_XL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM10_XL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM10_XL_DWLEN (1)
+union acl_indirect_tcam10_xl_u {
+	struct acl_indirect_tcam10_xl {
+		u32 xl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM10_XL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM10_XH_ADDR  (0xb64958)
+#define NBL_ACL_INDIRECT_TCAM10_XH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM10_XH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM10_XH_DWLEN (1)
+union acl_indirect_tcam10_xh_u {
+	struct acl_indirect_tcam10_xh {
+		u32 xh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM10_XH_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM11_XL_ADDR  (0xb6495c)
+#define NBL_ACL_INDIRECT_TCAM11_XL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM11_XL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM11_XL_DWLEN (1)
+union acl_indirect_tcam11_xl_u {
+	struct acl_indirect_tcam11_xl {
+		u32 xl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM11_XL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM11_XH_ADDR  (0xb64960)
+#define NBL_ACL_INDIRECT_TCAM11_XH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM11_XH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM11_XH_DWLEN (1)
+union acl_indirect_tcam11_xh_u {
+	struct acl_indirect_tcam11_xh {
+		u32 xh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM11_XH_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM12_XL_ADDR  (0xb64964)
+#define NBL_ACL_INDIRECT_TCAM12_XL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM12_XL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM12_XL_DWLEN (1)
+union acl_indirect_tcam12_xl_u {
+	struct acl_indirect_tcam12_xl {
+		u32 xl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM12_XL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM12_XH_ADDR  (0xb64968)
+#define NBL_ACL_INDIRECT_TCAM12_XH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM12_XH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM12_XH_DWLEN (1)
+union acl_indirect_tcam12_xh_u {
+	struct acl_indirect_tcam12_xh {
+		u32 xh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM12_XH_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM13_XL_ADDR  (0xb6496c)
+#define NBL_ACL_INDIRECT_TCAM13_XL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM13_XL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM13_XL_DWLEN (1)
+union acl_indirect_tcam13_xl_u {
+	struct acl_indirect_tcam13_xl {
+		u32 xl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM13_XL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM13_XH_ADDR  (0xb64970)
+#define NBL_ACL_INDIRECT_TCAM13_XH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM13_XH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM13_XH_DWLEN (1)
+union acl_indirect_tcam13_xh_u {
+	struct acl_indirect_tcam13_xh {
+		u32 xh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM13_XH_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM14_XL_ADDR  (0xb64974)
+#define NBL_ACL_INDIRECT_TCAM14_XL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM14_XL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM14_XL_DWLEN (1)
+union acl_indirect_tcam14_xl_u {
+	struct acl_indirect_tcam14_xl {
+		u32 xl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM14_XL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM14_XH_ADDR  (0xb64978)
+#define NBL_ACL_INDIRECT_TCAM14_XH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM14_XH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM14_XH_DWLEN (1)
+union acl_indirect_tcam14_xh_u {
+	struct acl_indirect_tcam14_xh {
+		u32 xh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM14_XH_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM15_XL_ADDR  (0xb6497c)
+#define NBL_ACL_INDIRECT_TCAM15_XL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM15_XL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM15_XL_DWLEN (1)
+union acl_indirect_tcam15_xl_u {
+	struct acl_indirect_tcam15_xl {
+		u32 xl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM15_XL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM15_XH_ADDR  (0xb64980)
+#define NBL_ACL_INDIRECT_TCAM15_XH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM15_XH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM15_XH_DWLEN (1)
+union acl_indirect_tcam15_xh_u {
+	struct acl_indirect_tcam15_xh {
+		u32 xh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM15_XH_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM0_YL_ADDR  (0xb64990)
+#define NBL_ACL_INDIRECT_TCAM0_YL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM0_YL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM0_YL_DWLEN (1)
+union acl_indirect_tcam0_yl_u {
+	struct acl_indirect_tcam0_yl {
+		u32 yl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM0_YL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM0_YH_ADDR  (0xb64994)
+#define NBL_ACL_INDIRECT_TCAM0_YH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM0_YH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM0_YH_DWLEN (1)
+union acl_indirect_tcam0_yh_u {
+	struct acl_indirect_tcam0_yh {
+		u32 yh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM0_YH_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM1_YL_ADDR  (0xb64998)
+#define NBL_ACL_INDIRECT_TCAM1_YL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM1_YL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM1_YL_DWLEN (1)
+union acl_indirect_tcam1_yl_u {
+	struct acl_indirect_tcam1_yl {
+		u32 yl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM1_YL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM1_YH_ADDR  (0xb6499c)
+#define NBL_ACL_INDIRECT_TCAM1_YH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM1_YH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM1_YH_DWLEN (1)
+union acl_indirect_tcam1_yh_u {
+	struct acl_indirect_tcam1_yh {
+		u32 yh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM1_YH_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM2_YL_ADDR  (0xb649a0)
+#define NBL_ACL_INDIRECT_TCAM2_YL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM2_YL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM2_YL_DWLEN (1)
+union acl_indirect_tcam2_yl_u {
+	struct acl_indirect_tcam2_yl {
+		u32 yl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM2_YL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM2_YH_ADDR  (0xb649a4)
+#define NBL_ACL_INDIRECT_TCAM2_YH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM2_YH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM2_YH_DWLEN (1)
+union acl_indirect_tcam2_yh_u {
+	struct acl_indirect_tcam2_yh {
+		u32 yh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM2_YH_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM3_YL_ADDR  (0xb649a8)
+#define NBL_ACL_INDIRECT_TCAM3_YL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM3_YL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM3_YL_DWLEN (1)
+union acl_indirect_tcam3_yl_u {
+	struct acl_indirect_tcam3_yl {
+		u32 yl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM3_YL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM3_YH_ADDR  (0xb649ac)
+#define NBL_ACL_INDIRECT_TCAM3_YH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM3_YH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM3_YH_DWLEN (1)
+union acl_indirect_tcam3_yh_u {
+	struct acl_indirect_tcam3_yh {
+		u32 yh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM3_YH_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM4_YL_ADDR  (0xb649b0)
+#define NBL_ACL_INDIRECT_TCAM4_YL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM4_YL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM4_YL_DWLEN (1)
+union acl_indirect_tcam4_yl_u {
+	struct acl_indirect_tcam4_yl {
+		u32 yl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM4_YL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM4_YH_ADDR  (0xb649b4)
+#define NBL_ACL_INDIRECT_TCAM4_YH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM4_YH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM4_YH_DWLEN (1)
+union acl_indirect_tcam4_yh_u {
+	struct acl_indirect_tcam4_yh {
+		u32 yh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM4_YH_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM5_YL_ADDR  (0xb649b8)
+#define NBL_ACL_INDIRECT_TCAM5_YL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM5_YL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM5_YL_DWLEN (1)
+union acl_indirect_tcam5_yl_u {
+	struct acl_indirect_tcam5_yl {
+		u32 yl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM5_YL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM5_YH_ADDR  (0xb649bc)
+#define NBL_ACL_INDIRECT_TCAM5_YH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM5_YH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM5_YH_DWLEN (1)
+union acl_indirect_tcam5_yh_u {
+	struct acl_indirect_tcam5_yh {
+		u32 yh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM5_YH_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM6_YL_ADDR  (0xb649c0)
+#define NBL_ACL_INDIRECT_TCAM6_YL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM6_YL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM6_YL_DWLEN (1)
+union acl_indirect_tcam6_yl_u {
+	struct acl_indirect_tcam6_yl {
+		u32 yl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM6_YL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM6_YH_ADDR  (0xb649c4)
+#define NBL_ACL_INDIRECT_TCAM6_YH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM6_YH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM6_YH_DWLEN (1)
+union acl_indirect_tcam6_yh_u {
+	struct acl_indirect_tcam6_yh {
+		u32 yh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM6_YH_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM7_YL_ADDR  (0xb649c8)
+#define NBL_ACL_INDIRECT_TCAM7_YL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM7_YL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM7_YL_DWLEN (1)
+union acl_indirect_tcam7_yl_u {
+	struct acl_indirect_tcam7_yl {
+		u32 yl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM7_YL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM7_YH_ADDR  (0xb649cc)
+#define NBL_ACL_INDIRECT_TCAM7_YH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM7_YH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM7_YH_DWLEN (1)
+union acl_indirect_tcam7_yh_u {
+	struct acl_indirect_tcam7_yh {
+		u32 yh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM7_YH_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM8_YL_ADDR  (0xb649d0)
+#define NBL_ACL_INDIRECT_TCAM8_YL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM8_YL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM8_YL_DWLEN (1)
+union acl_indirect_tcam8_yl_u {
+	struct acl_indirect_tcam8_yl {
+		u32 yl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM8_YL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM8_YH_ADDR  (0xb649d4)
+#define NBL_ACL_INDIRECT_TCAM8_YH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM8_YH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM8_YH_DWLEN (1)
+union acl_indirect_tcam8_yh_u {
+	struct acl_indirect_tcam8_yh {
+		u32 yh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM8_YH_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM9_YL_ADDR  (0xb649d8)
+#define NBL_ACL_INDIRECT_TCAM9_YL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM9_YL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM9_YL_DWLEN (1)
+union acl_indirect_tcam9_yl_u {
+	struct acl_indirect_tcam9_yl {
+		u32 yl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM9_YL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM9_YH_ADDR  (0xb649dc)
+#define NBL_ACL_INDIRECT_TCAM9_YH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM9_YH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM9_YH_DWLEN (1)
+union acl_indirect_tcam9_yh_u {
+	struct acl_indirect_tcam9_yh {
+		u32 yh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM9_YH_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM10_YL_ADDR  (0xb649e0)
+#define NBL_ACL_INDIRECT_TCAM10_YL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM10_YL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM10_YL_DWLEN (1)
+union acl_indirect_tcam10_yl_u {
+	struct acl_indirect_tcam10_yl {
+		u32 yl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM10_YL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM10_YH_ADDR  (0xb649e4)
+#define NBL_ACL_INDIRECT_TCAM10_YH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM10_YH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM10_YH_DWLEN (1)
+union acl_indirect_tcam10_yh_u {
+	struct acl_indirect_tcam10_yh {
+		u32 yh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM10_YH_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM11_YL_ADDR  (0xb649e8)
+#define NBL_ACL_INDIRECT_TCAM11_YL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM11_YL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM11_YL_DWLEN (1)
+union acl_indirect_tcam11_yl_u {
+	struct acl_indirect_tcam11_yl {
+		u32 yl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM11_YL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM11_YH_ADDR  (0xb649ec)
+#define NBL_ACL_INDIRECT_TCAM11_YH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM11_YH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM11_YH_DWLEN (1)
+union acl_indirect_tcam11_yh_u {
+	struct acl_indirect_tcam11_yh {
+		u32 yh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM11_YH_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM12_YL_ADDR  (0xb649f0)
+#define NBL_ACL_INDIRECT_TCAM12_YL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM12_YL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM12_YL_DWLEN (1)
+union acl_indirect_tcam12_yl_u {
+	struct acl_indirect_tcam12_yl {
+		u32 yl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM12_YL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM12_YH_ADDR  (0xb649f4)
+#define NBL_ACL_INDIRECT_TCAM12_YH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM12_YH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM12_YH_DWLEN (1)
+union acl_indirect_tcam12_yh_u {
+	struct acl_indirect_tcam12_yh {
+		u32 yh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM12_YH_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM13_YL_ADDR  (0xb649f8)
+#define NBL_ACL_INDIRECT_TCAM13_YL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM13_YL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM13_YL_DWLEN (1)
+union acl_indirect_tcam13_yl_u {
+	struct acl_indirect_tcam13_yl {
+		u32 yl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM13_YL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM13_YH_ADDR  (0xb649fc)
+#define NBL_ACL_INDIRECT_TCAM13_YH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM13_YH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM13_YH_DWLEN (1)
+union acl_indirect_tcam13_yh_u {
+	struct acl_indirect_tcam13_yh {
+		u32 yh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM13_YH_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM14_YL_ADDR  (0xb64a00)
+#define NBL_ACL_INDIRECT_TCAM14_YL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM14_YL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM14_YL_DWLEN (1)
+union acl_indirect_tcam14_yl_u {
+	struct acl_indirect_tcam14_yl {
+		u32 yl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM14_YL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM14_YH_ADDR  (0xb64a04)
+#define NBL_ACL_INDIRECT_TCAM14_YH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM14_YH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM14_YH_DWLEN (1)
+union acl_indirect_tcam14_yh_u {
+	struct acl_indirect_tcam14_yh {
+		u32 yh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM14_YH_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM15_YL_ADDR  (0xb64a08)
+#define NBL_ACL_INDIRECT_TCAM15_YL_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM15_YL_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM15_YL_DWLEN (1)
+union acl_indirect_tcam15_yl_u {
+	struct acl_indirect_tcam15_yl {
+		u32 yl:32;               /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM15_YL_DWLEN];
+} __packed;
+
+#define NBL_ACL_INDIRECT_TCAM15_YH_ADDR  (0xb64a0c)
+#define NBL_ACL_INDIRECT_TCAM15_YH_DEPTH (1)
+#define NBL_ACL_INDIRECT_TCAM15_YH_WIDTH (32)
+#define NBL_ACL_INDIRECT_TCAM15_YH_DWLEN (1)
+union acl_indirect_tcam15_yh_u {
+	struct acl_indirect_tcam15_yh {
+		u32 yh:8;                /* [07:00] Default:0x0 RWW */
+		u32 rsv:24;              /* [31:08] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_ACL_INDIRECT_TCAM15_YH_DWLEN];
+} __packed;
+
+#define NBL_ACL_KGEN_TCAM_ADDR  (0xb65800)
+#define NBL_ACL_KGEN_TCAM_DEPTH (16)
+#define NBL_ACL_KGEN_TCAM_WIDTH (64)
+#define NBL_ACL_KGEN_TCAM_DWLEN (2)
+union acl_kgen_tcam_u {
+	struct acl_kgen_tcam {
+		u32 mask:16;
+		u32 data:16;
+		u32 valid_bit:1;
+		u32 rsv:31;
+	} __packed info;
+	u32 data[NBL_ACL_KGEN_TCAM_DWLEN];
+} __packed;
+#define NBL_ACL_KGEN_TCAM_REG(r) (NBL_ACL_KGEN_TCAM_ADDR + \
+		(NBL_ACL_KGEN_TCAM_DWLEN * 4) * (r))
+
+#define NBL_ACL_TCAM_CFG_ADDR  (0xb65a00)
+#define NBL_ACL_TCAM_CFG_DEPTH (16)
+#define NBL_ACL_TCAM_CFG_WIDTH (128)
+#define NBL_ACL_TCAM_CFG_DWLEN (4)
+union acl_tcam_cfg_u {
+	struct acl_tcam_cfg {
+		u32 startcompare0:1;     /* [00:00] Default:0x1 RW */
+		u32 startset0:1;         /* [01:01] Default:0x1 RW */
+		u32 tcam0_enable:1;      /* [02:02] Default:0x0 RW */
+		u32 startcompare1:1;     /* [03:03] Default:0x1 RW */
+		u32 startset1:1;         /* [04:04] Default:0x1 RW */
+		u32 tcam1_enable:1;      /* [05:05] Default:0x0 RW */
+		u32 startcompare2:1;     /* [06:06] Default:0x1 RW */
+		u32 startset2:1;         /* [07:07] Default:0x1 RW */
+		u32 tcam2_enable:1;      /* [08:08] Default:0x0 RW */
+		u32 startcompare3:1;     /* [09:09] Default:0x1 RW */
+		u32 startset3:1;         /* [10:10] Default:0x1 RW */
+		u32 tcam3_enable:1;      /* [11:11] Default:0x0 RW */
+		u32 startcompare4:1;     /* [12:12] Default:0x1 RW */
+		u32 startset4:1;         /* [13:13] Default:0x1 RW */
+		u32 tcam4_enable:1;      /* [14:14] Default:0x0 RW */
+		u32 startcompare5:1;     /* [15:15] Default:0x1 RW */
+		u32 startset5:1;         /* [16:16] Default:0x1 RW */
+		u32 tcam5_enable:1;      /* [17:17] Default:0x0 RW */
+		u32 startcompare6:1;     /* [18:18] Default:0x1 RW */
+		u32 startset6:1;         /* [19:19] Default:0x1 RW */
+		u32 tcam6_enable:1;      /* [20:20] Default:0x0 RW */
+		u32 startcompare7:1;     /* [21:21] Default:0x1 RW */
+		u32 startset7:1;         /* [22:22] Default:0x1 RW */
+		u32 tcam7_enable:1;      /* [23:23] Default:0x0 RW */
+		u32 startcompare8:1;     /* [24:24] Default:0x1 RW */
+		u32 startset8:1;         /* [25:25] Default:0x1 RW */
+		u32 tcam8_enable:1;      /* [26:26] Default:0x0 RW */
+		u32 startcompare9:1;     /* [27:27] Default:0x1 RW */
+		u32 startset9:1;         /* [28:28] Default:0x1 RW */
+		u32 tcam9_enable:1;      /* [29:29] Default:0x0 RW */
+		u32 startcompare10:1;    /* [30:30] Default:0x1 RW */
+		u32 startset10:1;        /* [31:31] Default:0x1 RW */
+		u32 tcam10_enable:1;     /* [32:32] Default:0x0 RW */
+		u32 startcompare11:1;    /* [33:33] Default:0x1 RW */
+		u32 startset11:1;        /* [34:34] Default:0x1 RW */
+		u32 tcam11_enable:1;     /* [35:35] Default:0x0 RW */
+		u32 startcompare12:1;    /* [36:36] Default:0x1 RW */
+		u32 startset12:1;        /* [37:37] Default:0x1 RW */
+		u32 tcam12_enable:1;     /* [38:38] Default:0x0 RW */
+		u32 startcompare13:1;    /* [39:39] Default:0x1 RW */
+		u32 startset13:1;        /* [40:40] Default:0x1 RW */
+		u32 tcam13_enable:1;     /* [41:41] Default:0x0 RW */
+		u32 startcompare14:1;    /* [42:42] Default:0x1 RW */
+		u32 startset14:1;        /* [43:43] Default:0x1 RW */
+		u32 tcam14_enable:1;     /* [44:44] Default:0x0 RW */
+		u32 startcompare15:1;    /* [45:45] Default:0x1 RW */
+		u32 startset15:1;        /* [46:46] Default:0x1 RW */
+		u32 tcam15_enable:1;     /* [47:47] Default:0x0 RW */
+		u32 key_id0:4;           /* [51:48] Default:0x0 RW */
+		u32 key_id1:4;           /* [55:52] Default:0x0 RW */
+		u32 key_id2:4;           /* [59:56] Default:0x0 RW */
+		u32 key_id3:4;           /* [63:60] Default:0x0 RW */
+		u32 key_id4:4;           /* [67:64] Default:0x0 RW */
+		u32 key_id5:4;           /* [71:68] Default:0x0 RW */
+		u32 key_id6:4;           /* [75:72] Default:0x0 RW */
+		u32 key_id7:4;           /* [79:76] Default:0x0 RW */
+		u32 key_id8:4;           /* [83:80] Default:0x0 RW */
+		u32 key_id9:4;           /* [87:84] Default:0x0 RW */
+		u32 key_id10:4;          /* [91:88] Default:0x0 RW */
+		u32 key_id11:4;          /* [95:92] Default:0x0 RW */
+		u32 key_id12:4;          /* [99:96] Default:0x0 RW */
+		u32 key_id13:4;          /* [103:100] Default:0x0 RW */
+		u32 key_id14:4;          /* [107:104] Default:0x0 RW */
+		u32 key_id15:4;          /* [111:108] Default:0x0 RW */
+		u32 rsv:16;              /* [127:112] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_TCAM_CFG_DWLEN];
+} __packed;
+#define NBL_ACL_TCAM_CFG_REG(r) (NBL_ACL_TCAM_CFG_ADDR + \
+		(NBL_ACL_TCAM_CFG_DWLEN * 4) * (r))
+
+#define NBL_ACL_ACTION_RAM_CFG_ADDR  (0xb65c00)
+#define NBL_ACL_ACTION_RAM_CFG_DEPTH (16)
+#define NBL_ACL_ACTION_RAM_CFG_WIDTH (128)
+#define NBL_ACL_ACTION_RAM_CFG_DWLEN (4)
+union acl_action_ram_cfg_u {
+	struct acl_action_ram_cfg {
+		u32 action_ram0_alloc_id:4; /* [03:00] Default:0x0 RW */
+		u32 action_ram0_enable:1; /* [04:04] Default:0x0 RW */
+		u32 action_ram1_alloc_id:4; /* [08:05] Default:0x0 RW */
+		u32 action_ram1_enable:1; /* [09:09] Default:0x0 RW */
+		u32 action_ram2_alloc_id:4; /* [13:10] Default:0x0 RW */
+		u32 action_ram2_enable:1; /* [14:14] Default:0x0 RW */
+		u32 action_ram3_alloc_id:4; /* [18:15] Default:0x0 RW */
+		u32 action_ram3_enable:1; /* [19:19] Default:0x0 RW */
+		u32 action_ram4_alloc_id:4; /* [23:20] Default:0x0 RW */
+		u32 action_ram4_enable:1; /* [24:24] Default:0x0 RW */
+		u32 action_ram5_alloc_id:4; /* [28:25] Default:0x0 RW */
+		u32 action_ram5_enable:1; /* [29:29] Default:0x0 RW */
+		u32 action_ram6_alloc_id:4; /* [33:30] Default:0x0 RW */
+		u32 action_ram6_enable:1; /* [34:34] Default:0x0 RW */
+		u32 action_ram7_alloc_id:4; /* [38:35] Default:0x0 RW */
+		u32 action_ram7_enable:1; /* [39:39] Default:0x0 RW */
+		u32 action_ram8_alloc_id:4; /* [43:40] Default:0x0 RW */
+		u32 action_ram8_enable:1; /* [44:44] Default:0x0 RW */
+		u32 action_ram9_alloc_id:4; /* [48:45] Default:0x0 RW */
+		u32 action_ram9_enable:1; /* [49:49] Default:0x0 RW */
+		u32 action_ram10_alloc_id:4; /* [53:50] Default:0x0 RW */
+		u32 action_ram10_enable:1; /* [54:54] Default:0x0 RW */
+		u32 action_ram11_alloc_id:4; /* [58:55] Default:0x0 RW */
+		u32 action_ram11_enable:1; /* [59:59] Default:0x0 RW */
+		u32 action_ram12_alloc_id:4; /* [63:60] Default:0x0 RW */
+		u32 action_ram12_enable:1; /* [64:64] Default:0x0 RW */
+		u32 action_ram13_alloc_id:4; /* [68:65] Default:0x0 RW */
+		u32 action_ram13_enable:1; /* [69:69] Default:0x0 RW */
+		u32 action_ram14_alloc_id:4; /* [73:70] Default:0x0 RW */
+		u32 action_ram14_enable:1; /* [74:74] Default:0x0 RW */
+		u32 action_ram15_alloc_id:4; /* [78:75] Default:0x0 RW */
+		u32 action_ram15_enable:1; /* [79:79] Default:0x0 RW */
+		u32 rsv_l:32;            /* [127:80] Default:0x0 RO */
+		u32 rsv_h:16;            /* [127:80] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_ACTION_RAM_CFG_DWLEN];
+} __packed;
+#define NBL_ACL_ACTION_RAM_CFG_REG(r) (NBL_ACL_ACTION_RAM_CFG_ADDR + \
+		(NBL_ACL_ACTION_RAM_CFG_DWLEN * 4) * (r))
+
+#define NBL_ACL_ACTION_RAM0_ADDR  (0xb66000)
+#define NBL_ACL_ACTION_RAM0_DEPTH (512)
+#define NBL_ACL_ACTION_RAM0_WIDTH (128)
+#define NBL_ACL_ACTION_RAM0_DWLEN (4)
+union acl_action_ram0_u {
+	struct acl_action_ram0 {
+		u32 action0:22;          /* [21:00] Default:0x0 RW */
+		u32 action1:22;          /* [43:22] Default:0x0 RW */
+		u32 action2:22;          /* [65:44] Default:0x0 RW */
+		u32 action3:22;          /* [87:66] Default:0x0 RW */
+		u32 rsv_l:32;            /* [127:88] Default:0x0 RO */
+		u32 rsv_h:8;             /* [127:88] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_ACTION_RAM0_DWLEN];
+} __packed;
+#define NBL_ACL_ACTION_RAM0_REG(r) (NBL_ACL_ACTION_RAM0_ADDR + \
+		(NBL_ACL_ACTION_RAM0_DWLEN * 4) * (r))
+
+#define NBL_ACL_ACTION_RAM1_ADDR  (0xb68000)
+#define NBL_ACL_ACTION_RAM1_DEPTH (512)
+#define NBL_ACL_ACTION_RAM1_WIDTH (128)
+#define NBL_ACL_ACTION_RAM1_DWLEN (4)
+union acl_action_ram1_u {
+	struct acl_action_ram1 {
+		u32 action0:22;          /* [21:0] Default:0x0 RW */
+		u32 action1:22;          /* [43:22] Default:0x0 RW */
+		u32 action2:22;          /* [65:44] Default:0x0 RW */
+		u32 action3:22;          /* [87:66] Default:0x0 RW */
+		u32 rsv_l:32;            /* [127:88] Default:0x0 RO */
+		u32 rsv_h:8;             /* [127:88] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_ACTION_RAM1_DWLEN];
+} __packed;
+#define NBL_ACL_ACTION_RAM1_REG(r) (NBL_ACL_ACTION_RAM1_ADDR + \
+		(NBL_ACL_ACTION_RAM1_DWLEN * 4) * (r))
+
+#define NBL_ACL_ACTION_RAM2_ADDR  (0xb6a000)
+#define NBL_ACL_ACTION_RAM2_DEPTH (512)
+#define NBL_ACL_ACTION_RAM2_WIDTH (128)
+#define NBL_ACL_ACTION_RAM2_DWLEN (4)
+union acl_action_ram2_u {
+	struct acl_action_ram2 {
+		u32 action0:22;          /* [21:0] Default:0x0 RW */
+		u32 action1:22;          /* [43:22] Default:0x0 RW */
+		u32 action2:22;          /* [65:44] Default:0x0 RW */
+		u32 action3:22;          /* [87:66] Default:0x0 RW */
+		u32 rsv_l:32;            /* [127:88] Default:0x0 RO */
+		u32 rsv_h:8;             /* [127:88] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_ACTION_RAM2_DWLEN];
+} __packed;
+#define NBL_ACL_ACTION_RAM2_REG(r) (NBL_ACL_ACTION_RAM2_ADDR + \
+		(NBL_ACL_ACTION_RAM2_DWLEN * 4) * (r))
+
+#define NBL_ACL_ACTION_RAM3_ADDR  (0xb6c000)
+#define NBL_ACL_ACTION_RAM3_DEPTH (512)
+#define NBL_ACL_ACTION_RAM3_WIDTH (128)
+#define NBL_ACL_ACTION_RAM3_DWLEN (4)
+union acl_action_ram3_u {
+	struct acl_action_ram3 {
+		u32 action0:22;          /* [21:0] Default:0x0 RW */
+		u32 action1:22;          /* [43:22] Default:0x0 RW */
+		u32 action2:22;          /* [65:44] Default:0x0 RW */
+		u32 action3:22;          /* [87:66] Default:0x0 RW */
+		u32 rsv_l:32;            /* [127:88] Default:0x0 RO */
+		u32 rsv_h:8;             /* [127:88] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_ACTION_RAM3_DWLEN];
+} __packed;
+#define NBL_ACL_ACTION_RAM3_REG(r) (NBL_ACL_ACTION_RAM3_ADDR + \
+		(NBL_ACL_ACTION_RAM3_DWLEN * 4) * (r))
+
+#define NBL_ACL_ACTION_RAM4_ADDR  (0xb6e000)
+#define NBL_ACL_ACTION_RAM4_DEPTH (512)
+#define NBL_ACL_ACTION_RAM4_WIDTH (128)
+#define NBL_ACL_ACTION_RAM4_DWLEN (4)
+union acl_action_ram4_u {
+	struct acl_action_ram4 {
+		u32 action0:22;          /* [21:0] Default:0x0 RW */
+		u32 action1:22;          /* [43:22] Default:0x0 RW */
+		u32 action2:22;          /* [65:44] Default:0x0 RW */
+		u32 action3:22;          /* [87:66] Default:0x0 RW */
+		u32 rsv_l:32;            /* [127:88] Default:0x0 RO */
+		u32 rsv_h:8;             /* [127:88] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_ACTION_RAM4_DWLEN];
+} __packed;
+#define NBL_ACL_ACTION_RAM4_REG(r) (NBL_ACL_ACTION_RAM4_ADDR + \
+		(NBL_ACL_ACTION_RAM4_DWLEN * 4) * (r))
+
+#define NBL_ACL_ACTION_RAM5_ADDR  (0xb70000)
+#define NBL_ACL_ACTION_RAM5_DEPTH (512)
+#define NBL_ACL_ACTION_RAM5_WIDTH (128)
+#define NBL_ACL_ACTION_RAM5_DWLEN (4)
+union acl_action_ram5_u {
+	struct acl_action_ram5 {
+		u32 action0:22;          /* [21:0] Default:0x0 RW */
+		u32 action1:22;          /* [43:22] Default:0x0 RW */
+		u32 action2:22;          /* [65:44] Default:0x0 RW */
+		u32 action3:22;          /* [87:66] Default:0x0 RW */
+		u32 rsv_l:32;            /* [127:88] Default:0x0 RO */
+		u32 rsv_h:8;             /* [127:88] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_ACTION_RAM5_DWLEN];
+} __packed;
+#define NBL_ACL_ACTION_RAM5_REG(r) (NBL_ACL_ACTION_RAM5_ADDR + \
+		(NBL_ACL_ACTION_RAM5_DWLEN * 4) * (r))
+
+#define NBL_ACL_ACTION_RAM6_ADDR  (0xb72000)
+#define NBL_ACL_ACTION_RAM6_DEPTH (512)
+#define NBL_ACL_ACTION_RAM6_WIDTH (128)
+#define NBL_ACL_ACTION_RAM6_DWLEN (4)
+union acl_action_ram6_u {
+	struct acl_action_ram6 {
+		u32 action0:22;          /* [21:0] Default:0x0 RW */
+		u32 action1:22;          /* [43:22] Default:0x0 RW */
+		u32 action2:22;          /* [65:44] Default:0x0 RW */
+		u32 action3:22;          /* [87:66] Default:0x0 RW */
+		u32 rsv_l:32;            /* [127:88] Default:0x0 RO */
+		u32 rsv_h:8;             /* [127:88] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_ACTION_RAM6_DWLEN];
+} __packed;
+#define NBL_ACL_ACTION_RAM6_REG(r) (NBL_ACL_ACTION_RAM6_ADDR + \
+		(NBL_ACL_ACTION_RAM6_DWLEN * 4) * (r))
+
+#define NBL_ACL_ACTION_RAM7_ADDR  (0xb74000)
+#define NBL_ACL_ACTION_RAM7_DEPTH (512)
+#define NBL_ACL_ACTION_RAM7_WIDTH (128)
+#define NBL_ACL_ACTION_RAM7_DWLEN (4)
+union acl_action_ram7_u {
+	struct acl_action_ram7 {
+		u32 action0:22;          /* [21:0] Default:0x0 RW */
+		u32 action1:22;          /* [43:22] Default:0x0 RW */
+		u32 action2:22;          /* [65:44] Default:0x0 RW */
+		u32 action3:22;          /* [87:66] Default:0x0 RW */
+		u32 rsv_l:32;            /* [127:88] Default:0x0 RO */
+		u32 rsv_h:8;             /* [127:88] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_ACTION_RAM7_DWLEN];
+} __packed;
+#define NBL_ACL_ACTION_RAM7_REG(r) (NBL_ACL_ACTION_RAM7_ADDR + \
+		(NBL_ACL_ACTION_RAM7_DWLEN * 4) * (r))
+
+#define NBL_ACL_ACTION_RAM8_ADDR  (0xb76000)
+#define NBL_ACL_ACTION_RAM8_DEPTH (512)
+#define NBL_ACL_ACTION_RAM8_WIDTH (128)
+#define NBL_ACL_ACTION_RAM8_DWLEN (4)
+union acl_action_ram8_u {
+	struct acl_action_ram8 {
+		u32 action0:22;          /* [21:0] Default:0x0 RW */
+		u32 action1:22;          /* [43:22] Default:0x0 RW */
+		u32 action2:22;          /* [65:44] Default:0x0 RW */
+		u32 action3:22;          /* [87:66] Default:0x0 RW */
+		u32 rsv_l:32;            /* [127:88] Default:0x0 RO */
+		u32 rsv_h:8;             /* [127:88] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_ACTION_RAM8_DWLEN];
+} __packed;
+#define NBL_ACL_ACTION_RAM8_REG(r) (NBL_ACL_ACTION_RAM8_ADDR + \
+		(NBL_ACL_ACTION_RAM8_DWLEN * 4) * (r))
+
+#define NBL_ACL_ACTION_RAM9_ADDR  (0xb78000)
+#define NBL_ACL_ACTION_RAM9_DEPTH (512)
+#define NBL_ACL_ACTION_RAM9_WIDTH (128)
+#define NBL_ACL_ACTION_RAM9_DWLEN (4)
+union acl_action_ram9_u {
+	struct acl_action_ram9 {
+		u32 action0:22;          /* [21:0] Default:0x0 RW */
+		u32 action1:22;          /* [43:22] Default:0x0 RW */
+		u32 action2:22;          /* [65:44] Default:0x0 RW */
+		u32 action3:22;          /* [87:66] Default:0x0 RW */
+		u32 rsv_l:32;            /* [127:88] Default:0x0 RO */
+		u32 rsv_h:8;             /* [127:88] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_ACTION_RAM9_DWLEN];
+} __packed;
+#define NBL_ACL_ACTION_RAM9_REG(r) (NBL_ACL_ACTION_RAM9_ADDR + \
+		(NBL_ACL_ACTION_RAM9_DWLEN * 4) * (r))
+
+#define NBL_ACL_ACTION_RAM10_ADDR  (0xb7a000)
+#define NBL_ACL_ACTION_RAM10_DEPTH (512)
+#define NBL_ACL_ACTION_RAM10_WIDTH (128)
+#define NBL_ACL_ACTION_RAM10_DWLEN (4)
+union acl_action_ram10_u {
+	struct acl_action_ram10 {
+		u32 action0:22;          /* [21:0] Default:0x0 RW */
+		u32 action1:22;          /* [43:22] Default:0x0 RW */
+		u32 action2:22;          /* [65:44] Default:0x0 RW */
+		u32 action3:22;          /* [87:66] Default:0x0 RW */
+		u32 rsv_l:32;            /* [127:88] Default:0x0 RO */
+		u32 rsv_h:8;             /* [127:88] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_ACTION_RAM10_DWLEN];
+} __packed;
+#define NBL_ACL_ACTION_RAM10_REG(r) (NBL_ACL_ACTION_RAM10_ADDR + \
+		(NBL_ACL_ACTION_RAM10_DWLEN * 4) * (r))
+
+#define NBL_ACL_ACTION_RAM11_ADDR  (0xb7c000)
+#define NBL_ACL_ACTION_RAM11_DEPTH (512)
+#define NBL_ACL_ACTION_RAM11_WIDTH (128)
+#define NBL_ACL_ACTION_RAM11_DWLEN (4)
+union acl_action_ram11_u {
+	struct acl_action_ram11 {
+		u32 action0:22;          /* [21:0] Default:0x0 RW */
+		u32 action1:22;          /* [43:22] Default:0x0 RW */
+		u32 action2:22;          /* [65:44] Default:0x0 RW */
+		u32 action3:22;          /* [87:66] Default:0x0 RW */
+		u32 rsv_l:32;            /* [127:88] Default:0x0 RO */
+		u32 rsv_h:8;             /* [127:88] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_ACTION_RAM11_DWLEN];
+} __packed;
+#define NBL_ACL_ACTION_RAM11_REG(r) (NBL_ACL_ACTION_RAM11_ADDR + \
+		(NBL_ACL_ACTION_RAM11_DWLEN * 4) * (r))
+
+#define NBL_ACL_ACTION_RAM12_ADDR  (0xb7e000)
+#define NBL_ACL_ACTION_RAM12_DEPTH (512)
+#define NBL_ACL_ACTION_RAM12_WIDTH (128)
+#define NBL_ACL_ACTION_RAM12_DWLEN (4)
+union acl_action_ram12_u {
+	struct acl_action_ram12 {
+		u32 action0:22;          /* [21:0] Default:0x0 RW */
+		u32 action1:22;          /* [43:22] Default:0x0 RW */
+		u32 action2:22;          /* [65:44] Default:0x0 RW */
+		u32 action3:22;          /* [87:66] Default:0x0 RW */
+		u32 rsv_l:32;            /* [127:88] Default:0x0 RO */
+		u32 rsv_h:8;             /* [127:88] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_ACTION_RAM12_DWLEN];
+} __packed;
+#define NBL_ACL_ACTION_RAM12_REG(r) (NBL_ACL_ACTION_RAM12_ADDR + \
+		(NBL_ACL_ACTION_RAM12_DWLEN * 4) * (r))
+
+#define NBL_ACL_ACTION_RAM13_ADDR  (0xb80000)
+#define NBL_ACL_ACTION_RAM13_DEPTH (512)
+#define NBL_ACL_ACTION_RAM13_WIDTH (128)
+#define NBL_ACL_ACTION_RAM13_DWLEN (4)
+union acl_action_ram13_u {
+	struct acl_action_ram13 {
+		u32 action0:22;          /* [21:0] Default:0x0 RW */
+		u32 action1:22;          /* [43:22] Default:0x0 RW */
+		u32 action2:22;          /* [65:44] Default:0x0 RW */
+		u32 action3:22;          /* [87:66] Default:0x0 RW */
+		u32 rsv_l:32;            /* [127:88] Default:0x0 RO */
+		u32 rsv_h:8;             /* [127:88] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_ACTION_RAM13_DWLEN];
+} __packed;
+#define NBL_ACL_ACTION_RAM13_REG(r) (NBL_ACL_ACTION_RAM13_ADDR + \
+		(NBL_ACL_ACTION_RAM13_DWLEN * 4) * (r))
+
+#define NBL_ACL_ACTION_RAM14_ADDR  (0xb82000)
+#define NBL_ACL_ACTION_RAM14_DEPTH (512)
+#define NBL_ACL_ACTION_RAM14_WIDTH (128)
+#define NBL_ACL_ACTION_RAM14_DWLEN (4)
+union acl_action_ram14_u {
+	struct acl_action_ram14 {
+		u32 action0:22;          /* [21:0] Default:0x0 RW */
+		u32 action1:22;          /* [43:22] Default:0x0 RW */
+		u32 action2:22;          /* [65:44] Default:0x0 RW */
+		u32 action3:22;          /* [87:66] Default:0x0 RW */
+		u32 rsv_l:32;            /* [127:88] Default:0x0 RO */
+		u32 rsv_h:8;             /* [127:88] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_ACTION_RAM14_DWLEN];
+} __packed;
+#define NBL_ACL_ACTION_RAM14_REG(r) (NBL_ACL_ACTION_RAM14_ADDR + \
+		(NBL_ACL_ACTION_RAM14_DWLEN * 4) * (r))
+
+#define NBL_ACL_ACTION_RAM15_ADDR  (0xb84000)
+#define NBL_ACL_ACTION_RAM15_DEPTH (512)
+#define NBL_ACL_ACTION_RAM15_WIDTH (128)
+#define NBL_ACL_ACTION_RAM15_DWLEN (4)
+union acl_action_ram15_u {
+	struct acl_action_ram15 {
+		u32 action0:22;          /* [21:0] Default:0x0 RW */
+		u32 action1:22;          /* [43:22] Default:0x0 RW */
+		u32 action2:22;          /* [65:44] Default:0x0 RW */
+		u32 action3:22;          /* [87:66] Default:0x0 RW */
+		u32 rsv_l:32;            /* [127:88] Default:0x0 RO */
+		u32 rsv_h:8;             /* [127:88] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_ACTION_RAM15_DWLEN];
+} __packed;
+#define NBL_ACL_ACTION_RAM15_REG(r) (NBL_ACL_ACTION_RAM15_ADDR + \
+		(NBL_ACL_ACTION_RAM15_DWLEN * 4) * (r))
+
+#define NBL_ACL_DEFAULT_ACTION_RAM_ADDR  (0xb86000)
+#define NBL_ACL_DEFAULT_ACTION_RAM_DEPTH (16)
+#define NBL_ACL_DEFAULT_ACTION_RAM_WIDTH (256)
+#define NBL_ACL_DEFAULT_ACTION_RAM_DWLEN (8)
+union acl_default_action_ram_u {
+	struct acl_default_action_ram {
+		u32 action0:22;          /* [21:00] Default:0x0 RW */
+		u32 action1:22;          /* [43:22] Default:0x0 RW */
+		u32 action2:22;          /* [65:44] Default:0x0 RW */
+		u32 action3:22;          /* [87:66] Default:0x0 RW */
+		u32 action4:22;          /* [109:88] Default:0x0 RW */
+		u32 action5:22;          /* [131:110] Default:0x0 RW */
+		u32 actoin6:22;          /* [153:132] Default:0x0 RW */
+		u32 action7:22;          /* [175:154] Default:0x0 RW */
+		u32 rsv:16;              /* [255:176] Default:0x0 RO */
+		u32 rsv_arr[2];          /* [255:176] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_DEFAULT_ACTION_RAM_DWLEN];
+} __packed;
+#define NBL_ACL_DEFAULT_ACTION_RAM_REG(r) (NBL_ACL_DEFAULT_ACTION_RAM_ADDR + \
+		(NBL_ACL_DEFAULT_ACTION_RAM_DWLEN * 4) * (r))
+
+#define NBL_ACL_FLOW_ID_STAT_RAM_ADDR  (0xb94000)
+#define NBL_ACL_FLOW_ID_STAT_RAM_DEPTH (131072)
+#define NBL_ACL_FLOW_ID_STAT_RAM_WIDTH (128)
+#define NBL_ACL_FLOW_ID_STAT_RAM_DWLEN (4)
+union acl_flow_id_stat_ram_u {
+	struct acl_flow_id_stat_ram {
+		u32 pkt_byte_l:32;       /* [47:00] Default:0x0 RO */
+		u32 pkt_byte_h:16;       /* [47:00] Default:0x0 RO */
+		u32 pkt_cnt_l:32;        /* [87:48] Default:0x0 RO */
+		u32 pkt_cnt_h:8;         /* [87:48] Default:0x0 RO */
+		u32 rsv_l:32;            /* [127:88] Default:0x0 RO */
+		u32 rsv_h:8;             /* [127:88] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_FLOW_ID_STAT_RAM_DWLEN];
+} __packed;
+#define NBL_ACL_FLOW_ID_STAT_RAM_REG(r) (NBL_ACL_FLOW_ID_STAT_RAM_ADDR + \
+		(NBL_ACL_FLOW_ID_STAT_RAM_DWLEN * 4) * (r))
+
+#define NBL_ACL_STAT_ID_STAT_RAM_ADDR  (0xd94000)
+#define NBL_ACL_STAT_ID_STAT_RAM_DEPTH (2048)
+#define NBL_ACL_STAT_ID_STAT_RAM_WIDTH (128)
+#define NBL_ACL_STAT_ID_STAT_RAM_DWLEN (4)
+union acl_stat_id_stat_ram_u {
+	struct acl_stat_id_stat_ram {
+		u32 pkt_byte_arr[2];     /* [63:0] Default:0x0 RO */
+		u32 pkt_cnt_arr[2];      /* [127:64] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_ACL_STAT_ID_STAT_RAM_DWLEN];
+} __packed;
+#define NBL_ACL_STAT_ID_STAT_RAM_REG(r) (NBL_ACL_STAT_ID_STAT_RAM_ADDR + \
+		(NBL_ACL_STAT_ID_STAT_RAM_DWLEN * 4) * (r))
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_epro.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_epro.h
new file mode 100644
index 000000000000..7c36f4ad11b4
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_epro.h
@@ -0,0 +1,665 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+// Code generated by interstellar. DO NOT EDIT.
+// Compatible with leonis RTL tag 0710
+
+#ifndef NBL_EPRO_H
+#define NBL_EPRO_H 1
+
+#include <linux/types.h>
+
+#define NBL_EPRO_BASE (0x00E74000)
+
+#define NBL_EPRO_INT_STATUS_ADDR  (0xe74000)
+#define NBL_EPRO_INT_STATUS_DEPTH (1)
+#define NBL_EPRO_INT_STATUS_WIDTH (32)
+#define NBL_EPRO_INT_STATUS_DWLEN (1)
+union epro_int_status_u {
+	struct epro_int_status {
+		u32 fatal_err:1;         /* [0] Default:0x0 RWC */
+		u32 fifo_uflw_err:1;     /* [1] Default:0x0 RWC */
+		u32 fifo_dflw_err:1;     /* [2] Default:0x0 RWC */
+		u32 cif_err:1;           /* [3] Default:0x0 RWC */
+		u32 input_err:1;         /* [4] Default:0x0 RWC */
+		u32 cfg_err:1;           /* [5] Default:0x0 RWC */
+		u32 data_ucor_err:1;     /* [6] Default:0x0 RWC */
+		u32 data_cor_err:1;      /* [7] Default:0x0 RWC */
+		u32 rsv:24;              /* [31:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_INT_STATUS_DWLEN];
+} __packed;
+
+#define NBL_EPRO_INT_MASK_ADDR  (0xe74004)
+#define NBL_EPRO_INT_MASK_DEPTH (1)
+#define NBL_EPRO_INT_MASK_WIDTH (32)
+#define NBL_EPRO_INT_MASK_DWLEN (1)
+union epro_int_mask_u {
+	struct epro_int_mask {
+		u32 fatal_err:1;         /* [0] Default:0x0 RW */
+		u32 fifo_uflw_err:1;     /* [1] Default:0x0 RW */
+		u32 fifo_dflw_err:1;     /* [2] Default:0x0 RW */
+		u32 cif_err:1;           /* [3] Default:0x0 RW */
+		u32 input_err:1;         /* [4] Default:0x0 RW */
+		u32 cfg_err:1;           /* [5] Default:0x0 RW */
+		u32 data_ucor_err:1;     /* [6] Default:0x0 RW */
+		u32 data_cor_err:1;      /* [7] Default:0x0 RW */
+		u32 rsv:24;              /* [31:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_INT_MASK_DWLEN];
+} __packed;
+
+#define NBL_EPRO_INT_SET_ADDR  (0xe74008)
+#define NBL_EPRO_INT_SET_DEPTH (1)
+#define NBL_EPRO_INT_SET_WIDTH (32)
+#define NBL_EPRO_INT_SET_DWLEN (1)
+union epro_int_set_u {
+	struct epro_int_set {
+		u32 fatal_err:1;         /* [0] Default:0x0 WO */
+		u32 fifo_uflw_err:1;     /* [1] Default:0x0 WO */
+		u32 fifo_dflw_err:1;     /* [2] Default:0x0 WO */
+		u32 cif_err:1;           /* [3] Default:0x0 WO */
+		u32 input_err:1;         /* [4] Default:0x0 WO */
+		u32 cfg_err:1;           /* [5] Default:0x0 WO */
+		u32 data_ucor_err:1;     /* [6] Default:0x0 WO */
+		u32 data_cor_err:1;      /* [7] Default:0x0 WO */
+		u32 rsv:24;              /* [31:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_INT_SET_DWLEN];
+} __packed;
+
+#define NBL_EPRO_INIT_DONE_ADDR  (0xe7400c)
+#define NBL_EPRO_INIT_DONE_DEPTH (1)
+#define NBL_EPRO_INIT_DONE_WIDTH (32)
+#define NBL_EPRO_INIT_DONE_DWLEN (1)
+union epro_init_done_u {
+	struct epro_init_done {
+		u32 done:1;              /* [0] Default:0x0 RO */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_INIT_DONE_DWLEN];
+} __packed;
+
+#define NBL_EPRO_CIF_ERR_INFO_ADDR  (0xe74040)
+#define NBL_EPRO_CIF_ERR_INFO_DEPTH (1)
+#define NBL_EPRO_CIF_ERR_INFO_WIDTH (32)
+#define NBL_EPRO_CIF_ERR_INFO_DWLEN (1)
+union epro_cif_err_info_u {
+	struct epro_cif_err_info {
+		u32 addr:30;             /* [29:0] Default:0x0 RO */
+		u32 wr_err:1;            /* [30] Default:0x0 RO */
+		u32 ucor_err:1;          /* [31] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_CIF_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_EPRO_CFG_ERR_INFO_ADDR  (0xe74050)
+#define NBL_EPRO_CFG_ERR_INFO_DEPTH (1)
+#define NBL_EPRO_CFG_ERR_INFO_WIDTH (32)
+#define NBL_EPRO_CFG_ERR_INFO_DWLEN (1)
+union epro_cfg_err_info_u {
+	struct epro_cfg_err_info {
+		u32 addr:10;             /* [9:0] Default:0x0 RO */
+		u32 id:3;                /* [12:10] Default:0x0 RO */
+		u32 rsv:19;              /* [31:13] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_CFG_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_EPRO_CAR_CTRL_ADDR  (0xe74100)
+#define NBL_EPRO_CAR_CTRL_DEPTH (1)
+#define NBL_EPRO_CAR_CTRL_WIDTH (32)
+#define NBL_EPRO_CAR_CTRL_DWLEN (1)
+union epro_car_ctrl_u {
+	struct epro_car_ctrl {
+		u32 sctr_car:1;          /* [0] Default:0x1 RW */
+		u32 rctr_car:1;          /* [1] Default:0x1 RW */
+		u32 rc_car:1;            /* [2] Default:0x1 RW */
+		u32 tbl_rc_car:1;        /* [3] Default:0x1 RW */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_CAR_CTRL_DWLEN];
+} __packed;
+
+#define NBL_EPRO_INIT_START_ADDR  (0xe74180)
+#define NBL_EPRO_INIT_START_DEPTH (1)
+#define NBL_EPRO_INIT_START_WIDTH (32)
+#define NBL_EPRO_INIT_START_DWLEN (1)
+union epro_init_start_u {
+	struct epro_init_start {
+		u32 start:1;             /* [0] Default:0x0 WO */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_INIT_START_DWLEN];
+} __packed;
+
+#define NBL_EPRO_FLAG_SEL_ADDR  (0xe74200)
+#define NBL_EPRO_FLAG_SEL_DEPTH (1)
+#define NBL_EPRO_FLAG_SEL_WIDTH (32)
+#define NBL_EPRO_FLAG_SEL_DWLEN (1)
+union epro_flag_sel_u {
+	struct epro_flag_sel {
+		u32 dir_offset_en:1;     /* [0] Default:0x1 RW */
+		u32 dir_offset:5;        /* [5:1] Default:0x0 RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_FLAG_SEL_DWLEN];
+} __packed;
+
+#define NBL_EPRO_ACT_SEL_EN_ADDR  (0xe74214)
+#define NBL_EPRO_ACT_SEL_EN_DEPTH (1)
+#define NBL_EPRO_ACT_SEL_EN_WIDTH (32)
+#define NBL_EPRO_ACT_SEL_EN_DWLEN (1)
+union epro_act_sel_en_u {
+	struct epro_act_sel_en {
+		u32 rssidx_en:1;         /* [0] Default:0x1 RW */
+		u32 dport_en:1;          /* [1] Default:0x1 RW */
+		u32 mirroridx_en:1;      /* [2] Default:0x1 RW */
+		u32 dqueue_en:1;         /* [3] Default:0x1 RW */
+		u32 encap_en:1;          /* [4] Default:0x1 RW */
+		u32 pop_8021q_en:1;      /* [5] Default:0x1 RW */
+		u32 pop_qinq_en:1;       /* [6] Default:0x1 RW */
+		u32 push_cvlan_en:1;     /* [7] Default:0x1 RW */
+		u32 push_svlan_en:1;     /* [8] Default:0x1 RW */
+		u32 replace_cvlan_en:1;  /* [9] Default:0x1 RW */
+		u32 replace_svlan_en:1;  /* [10] Default:0x1 RW */
+		u32 rsv:21;              /* [31:11] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_ACT_SEL_EN_DWLEN];
+} __packed;
+
+#define NBL_EPRO_AM_ACT_ID0_ADDR  (0xe74218)
+#define NBL_EPRO_AM_ACT_ID0_DEPTH (1)
+#define NBL_EPRO_AM_ACT_ID0_WIDTH (32)
+#define NBL_EPRO_AM_ACT_ID0_DWLEN (1)
+union epro_am_act_id0_u {
+	struct epro_am_act_id0 {
+		u32 replace_cvlan:6;     /* [5:0] Default:0x2b RW */
+		u32 rsv3:2;              /* [7:6] Default:0x0 RO */
+		u32 replace_svlan:6;     /* [13:8] Default:0x2a RW */
+		u32 rsv2:2;              /* [15:14] Default:0x0 RO */
+		u32 push_cvlan:6;        /* [21:16] Default:0x2d RW */
+		u32 rsv1:2;              /* [23:22] Default:0x0 RO */
+		u32 push_svlan:6;        /* [29:24] Default:0x2c RW */
+		u32 rsv:2;               /* [31:30] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_AM_ACT_ID0_DWLEN];
+} __packed;
+
+#define NBL_EPRO_AM_ACT_ID1_ADDR  (0xe7421c)
+#define NBL_EPRO_AM_ACT_ID1_DEPTH (1)
+#define NBL_EPRO_AM_ACT_ID1_WIDTH (32)
+#define NBL_EPRO_AM_ACT_ID1_DWLEN (1)
+union epro_am_act_id1_u {
+	struct epro_am_act_id1 {
+		u32 pop_qinq:6;          /* [5:0] Default:0x29 RW */
+		u32 rsv3:2;              /* [7:6] Default:0x0 RO */
+		u32 pop_8021q:6;         /* [13:08] Default:0x28 RW */
+		u32 rsv2:2;              /* [15:14] Default:0x0 RO */
+		u32 dport:6;             /* [21:16] Default:0x9 RW */
+		u32 rsv1:2;              /* [23:22] Default:0x0 RO */
+		u32 dqueue:6;            /* [29:24] Default:0xa RW */
+		u32 rsv:2;               /* [31:30] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_AM_ACT_ID1_DWLEN];
+} __packed;
+
+#define NBL_EPRO_AM_ACT_ID2_ADDR  (0xe74220)
+#define NBL_EPRO_AM_ACT_ID2_DEPTH (1)
+#define NBL_EPRO_AM_ACT_ID2_WIDTH (32)
+#define NBL_EPRO_AM_ACT_ID2_DWLEN (1)
+union epro_am_act_id2_u {
+	struct epro_am_act_id2 {
+		u32 rssidx:6;            /* [5:0] Default:0x4 RW */
+		u32 rsv3:2;              /* [7:6] Default:0x0 RO */
+		u32 mirroridx:6;         /* [13:8] Default:0x8 RW */
+		u32 rsv2:2;              /* [15:14] Default:0x0 RO */
+		u32 car:6;               /* [21:16] Default:0x5 RW */
+		u32 rsv1:2;              /* [23:22] Default:0x0 RO */
+		u32 encap:6;             /* [29:24] Default:0x2e RW */
+		u32 rsv:2;               /* [31:30] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_AM_ACT_ID2_DWLEN];
+} __packed;
+
+#define NBL_EPRO_AM_ACT_ID3_ADDR  (0xe74224)
+#define NBL_EPRO_AM_ACT_ID3_DEPTH (1)
+#define NBL_EPRO_AM_ACT_ID3_WIDTH (32)
+#define NBL_EPRO_AM_ACT_ID3_DWLEN (1)
+union epro_am_act_id3_u {
+	struct epro_am_act_id3 {
+		u32 outer_sport_mdf:6;   /* [5:0] Default:0x30 RW */
+		u32 rsv3:2;              /* [7:6] Default:0x0 RO */
+		u32 pri_mdf:6;           /* [13:8] Default:0x15 RW */
+		u32 rsv2:2;              /* [15:14] Default:0x0 RO */
+		u32 dp_hash0:6;          /* [21:16] Default:0x13 RW */
+		u32 rsv1:2;              /* [23:22] Default:0x0 RO */
+		u32 dp_hash1:6;          /* [29:24] Default:0x14 RW */
+		u32 rsv:2;               /* [31:30] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_AM_ACT_ID3_DWLEN];
+} __packed;
+
+#define NBL_EPRO_ACTION_PRIORITY_ADDR  (0xe74230)
+#define NBL_EPRO_ACTION_PRIORITY_DEPTH (1)
+#define NBL_EPRO_ACTION_PRIORITY_WIDTH (32)
+#define NBL_EPRO_ACTION_PRIORITY_DWLEN (1)
+union epro_action_priority_u {
+	struct epro_action_priority {
+		u32 mirroridx:2;         /* [1:0] Default:0x0 RW */
+		u32 car:2;               /* [3:2] Default:0x0 RW */
+		u32 dqueue:2;            /* [5:4] Default:0x0 RW */
+		u32 dport:2;             /* [7:6] Default:0x0 RW */
+		u32 pop_8021q:2;         /* [9:8] Default:0x0 RW */
+		u32 pop_qinq:2;          /* [11:10] Default:0x0 RW */
+		u32 replace_inner_vlan:2; /* [13:12] Default:0x0 RW */
+		u32 replace_outer_vlan:2; /* [15:14] Default:0x0 RW */
+		u32 push_inner_vlan:2;   /* [17:16] Default:0x0 RW */
+		u32 push_outer_vlan:2;   /* [19:18] Default:0x0 RW */
+		u32 outer_sport_mdf:2;   /* [21:20] Default:0x0 RW */
+		u32 pri_mdf:2;           /* [23:22] Default:0x0 RW */
+		u32 dp_hash0:2;          /* [25:24] Default:0x0 RW */
+		u32 dp_hash1:2;          /* [27:26] Default:0x0 RW */
+		u32 rsv:4;               /* [31:28] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_ACTION_PRIORITY_DWLEN];
+} __packed;
+
+#define NBL_EPRO_MIRROR_ACTION_PRIORITY_ADDR  (0xe74234)
+#define NBL_EPRO_MIRROR_ACTION_PRIORITY_DEPTH (1)
+#define NBL_EPRO_MIRROR_ACTION_PRIORITY_WIDTH (32)
+#define NBL_EPRO_MIRROR_ACTION_PRIORITY_DWLEN (1)
+union epro_mirror_action_priority_u {
+	struct epro_mirror_action_priority {
+		u32 car:2;               /* [1:0] Default:0x0 RW */
+		u32 dqueue:2;            /* [3:2] Default:0x0 RW */
+		u32 dport:2;             /* [5:4] Default:0x0 RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_MIRROR_ACTION_PRIORITY_DWLEN];
+} __packed;
+
+#define NBL_EPRO_SET_FLAGS_ADDR  (0xe74238)
+#define NBL_EPRO_SET_FLAGS_DEPTH (1)
+#define NBL_EPRO_SET_FLAGS_WIDTH (32)
+#define NBL_EPRO_SET_FLAGS_DWLEN (1)
+union epro_set_flags_u {
+	struct epro_set_flags {
+		u32 set_flags:32;        /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_EPRO_SET_FLAGS_DWLEN];
+} __packed;
+
+#define NBL_EPRO_CLEAR_FLAGS_ADDR  (0xe7423c)
+#define NBL_EPRO_CLEAR_FLAGS_DEPTH (1)
+#define NBL_EPRO_CLEAR_FLAGS_WIDTH (32)
+#define NBL_EPRO_CLEAR_FLAGS_DWLEN (1)
+union epro_clear_flags_u {
+	struct epro_clear_flags {
+		u32 clear_flags:32;      /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_EPRO_CLEAR_FLAGS_DWLEN];
+} __packed;
+
+#define NBL_EPRO_RSS_SK_ADDR  (0xe74400)
+#define NBL_EPRO_RSS_SK_DEPTH (1)
+#define NBL_EPRO_RSS_SK_WIDTH (320)
+#define NBL_EPRO_RSS_SK_DWLEN (10)
+union epro_rss_sk_u {
+	struct epro_rss_sk {
+		u32 sk_arr[10];          /* [319:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_EPRO_RSS_SK_DWLEN];
+} __packed;
+
+#define NBL_EPRO_VXLAN_SP_ADDR  (0xe74500)
+#define NBL_EPRO_VXLAN_SP_DEPTH (1)
+#define NBL_EPRO_VXLAN_SP_WIDTH (32)
+#define NBL_EPRO_VXLAN_SP_DWLEN (1)
+union epro_vxlan_sp_u {
+	struct epro_vxlan_sp {
+		u32 vxlan_tnl_sp_min:16; /* [15:0] Default:0x8000 RW */
+		u32 vxlan_tnl_sp_max:16; /* [31:16] Default:0xee48 RW */
+	} __packed info;
+	u32 data[NBL_EPRO_VXLAN_SP_DWLEN];
+} __packed;
+
+#define NBL_EPRO_LOOP_SCH_COS_DEFAULT_ADDR  (0xe74600)
+#define NBL_EPRO_LOOP_SCH_COS_DEFAULT_DEPTH (1)
+#define NBL_EPRO_LOOP_SCH_COS_DEFAULT_WIDTH (32)
+#define NBL_EPRO_LOOP_SCH_COS_DEFAULT_DWLEN (1)
+union epro_loop_sch_cos_default_u {
+	struct epro_loop_sch_cos_default {
+		u32 sch_cos:3;           /* [2:0] Default:0x0 RW */
+		u32 pfc_mode:1;          /* [3] Default:0x0 RW */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_LOOP_SCH_COS_DEFAULT_DWLEN];
+} __packed;
+
+#define NBL_EPRO_MIRROR_PKT_COS_DEFAULT_ADDR  (0xe74604)
+#define NBL_EPRO_MIRROR_PKT_COS_DEFAULT_DEPTH (1)
+#define NBL_EPRO_MIRROR_PKT_COS_DEFAULT_WIDTH (32)
+#define NBL_EPRO_MIRROR_PKT_COS_DEFAULT_DWLEN (1)
+union epro_mirror_pkt_cos_default_u {
+	struct epro_mirror_pkt_cos_default {
+		u32 pkt_cos:3;           /* [2:0] Default:0x0 RW */
+		u32 rsv:29;              /* [31:3] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_MIRROR_PKT_COS_DEFAULT_DWLEN];
+} __packed;
+
+#define NBL_EPRO_NO_DPORT_REDIRECT_ADDR  (0xe7463c)
+#define NBL_EPRO_NO_DPORT_REDIRECT_DEPTH (1)
+#define NBL_EPRO_NO_DPORT_REDIRECT_WIDTH (32)
+#define NBL_EPRO_NO_DPORT_REDIRECT_DWLEN (1)
+union epro_no_dport_redirect_u {
+	struct epro_no_dport_redirect {
+		u32 dport:16;            /* [15:0] Default:0x0 RW */
+		u32 dqueue:11;           /* [26:16] Default:0x0 RW */
+		u32 dqueue_en:1;         /* [27] Default:0x0 RW */
+		u32 rsv:4;               /* [31:28] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_NO_DPORT_REDIRECT_DWLEN];
+} __packed;
+
+#define NBL_EPRO_SCH_COS_MAP_ETH0_ADDR  (0xe74640)
+#define NBL_EPRO_SCH_COS_MAP_ETH0_DEPTH (8)
+#define NBL_EPRO_SCH_COS_MAP_ETH0_WIDTH (32)
+#define NBL_EPRO_SCH_COS_MAP_ETH0_DWLEN (1)
+union epro_sch_cos_map_eth0_u {
+	struct epro_sch_cos_map_eth0 {
+		u32 pkt_cos:3;           /* [2:0] Default:0x0 RW */
+		u32 dscp:6;              /* [8:3] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_SCH_COS_MAP_ETH0_DWLEN];
+} __packed;
+#define NBL_EPRO_SCH_COS_MAP_ETH0_REG(r) (NBL_EPRO_SCH_COS_MAP_ETH0_ADDR + \
+		(NBL_EPRO_SCH_COS_MAP_ETH0_DWLEN * 4) * (r))
+
+#define NBL_EPRO_SCH_COS_MAP_ETH1_ADDR  (0xe74660)
+#define NBL_EPRO_SCH_COS_MAP_ETH1_DEPTH (8)
+#define NBL_EPRO_SCH_COS_MAP_ETH1_WIDTH (32)
+#define NBL_EPRO_SCH_COS_MAP_ETH1_DWLEN (1)
+union epro_sch_cos_map_eth1_u {
+	struct epro_sch_cos_map_eth1 {
+		u32 pkt_cos:3;           /* [2:0] Default:0x0 RW */
+		u32 dscp:6;              /* [8:3] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_SCH_COS_MAP_ETH1_DWLEN];
+} __packed;
+#define NBL_EPRO_SCH_COS_MAP_ETH1_REG(r) (NBL_EPRO_SCH_COS_MAP_ETH1_ADDR + \
+		(NBL_EPRO_SCH_COS_MAP_ETH1_DWLEN * 4) * (r))
+
+#define NBL_EPRO_SCH_COS_MAP_ETH2_ADDR  (0xe74680)
+#define NBL_EPRO_SCH_COS_MAP_ETH2_DEPTH (8)
+#define NBL_EPRO_SCH_COS_MAP_ETH2_WIDTH (32)
+#define NBL_EPRO_SCH_COS_MAP_ETH2_DWLEN (1)
+union epro_sch_cos_map_eth2_u {
+	struct epro_sch_cos_map_eth2 {
+		u32 pkt_cos:3;           /* [2:0] Default:0x0 RW */
+		u32 dscp:6;              /* [8:3] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_SCH_COS_MAP_ETH2_DWLEN];
+} __packed;
+#define NBL_EPRO_SCH_COS_MAP_ETH2_REG(r) (NBL_EPRO_SCH_COS_MAP_ETH2_ADDR + \
+		(NBL_EPRO_SCH_COS_MAP_ETH2_DWLEN * 4) * (r))
+
+#define NBL_EPRO_SCH_COS_MAP_ETH3_ADDR  (0xe746a0)
+#define NBL_EPRO_SCH_COS_MAP_ETH3_DEPTH (8)
+#define NBL_EPRO_SCH_COS_MAP_ETH3_WIDTH (32)
+#define NBL_EPRO_SCH_COS_MAP_ETH3_DWLEN (1)
+union epro_sch_cos_map_eth3_u {
+	struct epro_sch_cos_map_eth3 {
+		u32 pkt_cos:3;           /* [2:0] Default:0x0 RW */
+		u32 dscp:6;              /* [8:3] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_SCH_COS_MAP_ETH3_DWLEN];
+} __packed;
+#define NBL_EPRO_SCH_COS_MAP_ETH3_REG(r) (NBL_EPRO_SCH_COS_MAP_ETH3_ADDR + \
+		(NBL_EPRO_SCH_COS_MAP_ETH3_DWLEN * 4) * (r))
+
+#define NBL_EPRO_SCH_COS_MAP_LOOP_ADDR  (0xe746c0)
+#define NBL_EPRO_SCH_COS_MAP_LOOP_DEPTH (8)
+#define NBL_EPRO_SCH_COS_MAP_LOOP_WIDTH (32)
+#define NBL_EPRO_SCH_COS_MAP_LOOP_DWLEN (1)
+union epro_sch_cos_map_loop_u {
+	struct epro_sch_cos_map_loop {
+		u32 pkt_cos:3;           /* [2:0] Default:0x0 RW */
+		u32 dscp:6;              /* [8:3] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_SCH_COS_MAP_LOOP_DWLEN];
+} __packed;
+#define NBL_EPRO_SCH_COS_MAP_LOOP_REG(r) (NBL_EPRO_SCH_COS_MAP_LOOP_ADDR + \
+		(NBL_EPRO_SCH_COS_MAP_LOOP_DWLEN * 4) * (r))
+
+#define NBL_EPRO_PORT_PRI_MDF_EN_ADDR  (0xe746e0)
+#define NBL_EPRO_PORT_PRI_MDF_EN_DEPTH (1)
+#define NBL_EPRO_PORT_PRI_MDF_EN_WIDTH (32)
+#define NBL_EPRO_PORT_PRI_MDF_EN_DWLEN (1)
+union epro_port_pri_mdf_en_u {
+	struct epro_port_pri_mdf_en {
+		u32 eth0:1;              /* [0] Default:0x0 RW */
+		u32 eth1:1;              /* [1] Default:0x0 RW */
+		u32 eth2:1;              /* [2] Default:0x0 RW */
+		u32 eth3:1;              /* [3] Default:0x0 RW */
+		u32 loop:1;              /* [4] Default:0x0 RW */
+		u32 rsv:27;              /* [31:5] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_PORT_PRI_MDF_EN_DWLEN];
+} __packed;
+
+#define NBL_EPRO_CFG_TEST_ADDR  (0xe7480c)
+#define NBL_EPRO_CFG_TEST_DEPTH (1)
+#define NBL_EPRO_CFG_TEST_WIDTH (32)
+#define NBL_EPRO_CFG_TEST_DWLEN (1)
+union epro_cfg_test_u {
+	struct epro_cfg_test {
+		u32 test:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_EPRO_CFG_TEST_DWLEN];
+} __packed;
+
+#define NBL_EPRO_BP_STATE_ADDR  (0xe74b00)
+#define NBL_EPRO_BP_STATE_DEPTH (1)
+#define NBL_EPRO_BP_STATE_WIDTH (32)
+#define NBL_EPRO_BP_STATE_DWLEN (1)
+union epro_bp_state_u {
+	struct epro_bp_state {
+		u32 in_bp:1;             /* [0] Default:0x0 RO */
+		u32 out_bp:1;            /* [1] Default:0x0 RO */
+		u32 inter_bp:1;          /* [2] Default:0x0 RO */
+		u32 rsv:29;              /* [31:3] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_BP_STATE_DWLEN];
+} __packed;
+
+#define NBL_EPRO_BP_HISTORY_ADDR  (0xe74b04)
+#define NBL_EPRO_BP_HISTORY_DEPTH (1)
+#define NBL_EPRO_BP_HISTORY_WIDTH (32)
+#define NBL_EPRO_BP_HISTORY_DWLEN (1)
+union epro_bp_history_u {
+	struct epro_bp_history {
+		u32 in_bp:1;             /* [0] Default:0x0 RC */
+		u32 out_bp:1;            /* [1] Default:0x0 RC */
+		u32 inter_bp:1;          /* [2] Default:0x0 RC */
+		u32 rsv:29;              /* [31:3] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_BP_HISTORY_DWLEN];
+} __packed;
+
+#define NBL_EPRO_MT_ADDR  (0xe75400)
+#define NBL_EPRO_MT_DEPTH (16)
+#define NBL_EPRO_MT_WIDTH (64)
+#define NBL_EPRO_MT_DWLEN (2)
+#define NBL_EPRO_MT_MAX   (8)
+union epro_mt_u {
+	struct epro_mt {
+		u32 dport:16;            /* [15:0] Default:0x0 RW */
+		u32 dqueue:11;           /* [26:16] Default:0x0 RW */
+		u32 car_en:1;            /* [27] Default:0x0 RW */
+		u32 car_id:10;           /* [37:28] Default:0x0 RW */
+		u32 vld:1;               /* [38] Default:0x0 RW */
+		u32 rsv:25;              /* [63:39] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_MT_DWLEN];
+} __packed;
+#define NBL_EPRO_MT_REG(r) (NBL_EPRO_MT_ADDR + \
+		(NBL_EPRO_MT_DWLEN * 4) * (r))
+
+#define NBL_EPRO_KG_TCAM_ADDR  (0xe75480)
+#define NBL_EPRO_KG_TCAM_DEPTH (16)
+#define NBL_EPRO_KG_TCAM_WIDTH (64)
+#define NBL_EPRO_KG_TCAM_DWLEN (2)
+union epro_kg_tcam_u {
+	struct epro_kg_tcam {
+		u32 mask:16;             /* [15:0] Default:0x0 RW */
+		u32 data:16;             /* [31:16] Default:0x0 RW */
+		u32 valid_bit:1;         /* [32] Default:0x0 RW */
+		u32 rsv:31;              /* [63:33] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_KG_TCAM_DWLEN];
+} __packed;
+#define NBL_EPRO_KG_TCAM_REG(r) (NBL_EPRO_KG_TCAM_ADDR + \
+		(NBL_EPRO_KG_TCAM_DWLEN * 4) * (r))
+
+#define NBL_EPRO_VPT_ADDR  (0xe78000)
+#define NBL_EPRO_VPT_DEPTH (1024)
+#define NBL_EPRO_VPT_WIDTH (64)
+#define NBL_EPRO_VPT_DWLEN (2)
+union epro_vpt_u {
+	struct epro_vpt {
+		u32 cvlan:16;            /* [15:0] Default:0x0 RW */
+		u32 svlan:16;            /* [31:16] Default:0x0 RW */
+		u32 fwd:1;               /* [32] Default:0x0 RW */
+		u32 mirror_en:1;         /* [33] Default:0x0 RW */
+		u32 mirror_id:4;         /* [37:34] Default:0x0 RW */
+		u32 car_en:1;            /* [38] Default:0x0 RW */
+		u32 car_id:10;           /* [48:39] Default:0x0 RW */
+		u32 pop_vlan:2;          /* [50:49] Default:0x0 RW */
+		u32 push_vlan:2;         /* [52:51] Default:0x0 RW */
+		u32 replace_vlan:2;      /* [54:53] Default:0x0 RW */
+		u32 rss_alg_sel:1;       /* [55] Default:0x0 RW */
+		u32 rss_key_type_btm:2;  /* [57:56] Default:0x0 RW */
+		u32 vld:1;               /* [58] Default:0x0 RW */
+		u32 rsv:5;               /* [63:59] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_VPT_DWLEN];
+} __packed;
+#define NBL_EPRO_VPT_REG(r) (NBL_EPRO_VPT_ADDR + \
+		(NBL_EPRO_VPT_DWLEN * 4) * (r))
+
+#define NBL_EPRO_EPT_ADDR  (0xe75800)
+#define NBL_EPRO_EPT_DEPTH (8)
+#define NBL_EPRO_EPT_WIDTH (64)
+#define NBL_EPRO_EPT_DWLEN (2)
+union epro_ept_u {
+	struct epro_ept {
+		u32 cvlan:16;            /* [15:0] Default:0x0 RW */
+		u32 svlan:16;            /* [31:16] Default:0x0 RW */
+		u32 fwd:1;               /* [32] Default:0x0 RW */
+		u32 mirror_en:1;         /* [33] Default:0x0 RW */
+		u32 mirror_id:4;         /* [37:34] Default:0x0 RW */
+		u32 pop_vlan:2;          /* [39:38] Default:0x0 RW */
+		u32 push_vlan:2;         /* [41:40] Default:0x0 RW */
+		u32 replace_vlan:2;      /* [43:42] Default:0x0 RW */
+		u32 lag_alg_sel:2;       /* [45:44] Default:0x0 RW */
+		u32 lag_port_btm:4;      /* [49:46] Default:0x0 RW */
+		u32 lag_l2_protect_en:1; /* [50] Default:0x0 RW */
+		u32 pfc_sch_cos_default:3; /* [53:51] Default:0x0 RW */
+		u32 pfc_mode:1;          /* [54] Default:0x0 RW */
+		u32 vld:1;               /* [55] Default:0x0 RW */
+		u32 rsv:8;               /* [63:56] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_EPT_DWLEN];
+} __packed;
+#define NBL_EPRO_EPT_REG(r) (NBL_EPRO_EPT_ADDR + \
+		(NBL_EPRO_EPT_DWLEN * 4) * (r))
+
+#define NBL_EPRO_AFT_ADDR  (0xe75900)
+#define NBL_EPRO_AFT_DEPTH (16)
+#define NBL_EPRO_AFT_WIDTH (64)
+#define NBL_EPRO_AFT_DWLEN (2)
+union epro_aft_u {
+	struct epro_aft {
+		u32 action_filter_btm_arr[2]; /* [63:0] Default:0x0 RW */
+	} __packed info;
+	u64 data;
+} __packed;
+#define NBL_EPRO_AFT_REG(r) (NBL_EPRO_AFT_ADDR + \
+		(NBL_EPRO_AFT_DWLEN * 4) * (r))
+
+#define NBL_EPRO_RSS_PT_ADDR  (0xe76000)
+#define NBL_EPRO_RSS_PT_DEPTH (1024)
+#define NBL_EPRO_RSS_PT_WIDTH (64)
+#define NBL_EPRO_RSS_PT_DWLEN (2)
+union epro_rss_pt_u {
+	struct epro_rss_pt {
+		u32 entry_size:3;        /* [2:0] Default:0x0 RW */
+		u32 offset1:14;          /* [16:3] Default:0x0 RW */
+		u32 offset1_vld:1;       /* [17:17] Default:0x0 RW */
+		u32 offset0:14;          /* [31:18] Default:0x0 RW */
+		u32 offset0_vld:1;       /* [32] Default:0x0 RW */
+		u32 vld:1;               /* [33] Default:0x0 RW */
+		u32 rsv:30;              /* [63:34] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_RSS_PT_DWLEN];
+} __packed;
+#define NBL_EPRO_RSS_PT_REG(r) (NBL_EPRO_RSS_PT_ADDR + \
+		(NBL_EPRO_RSS_PT_DWLEN * 4) * (r))
+
+#define NBL_EPRO_ECPVPT_ADDR  (0xe7a000)
+#define NBL_EPRO_ECPVPT_DEPTH (256)
+#define NBL_EPRO_ECPVPT_WIDTH (32)
+#define NBL_EPRO_ECPVPT_DWLEN (1)
+union epro_ecpvpt_u {
+	struct epro_ecpvpt {
+		u32 encap_cvlan_vld0:1;  /* [0] Default:0x0 RW */
+		u32 encap_svlan_vld0:1;  /* [1] Default:0x0 RW */
+		u32 encap_vlan_vld1_15:30; /* [31:2] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_EPRO_ECPVPT_DWLEN];
+} __packed;
+#define NBL_EPRO_ECPVPT_REG(r) (NBL_EPRO_ECPVPT_ADDR + \
+		(NBL_EPRO_ECPVPT_DWLEN * 4) * (r))
+
+#define NBL_EPRO_ECPIPT_ADDR  (0xe7b000)
+#define NBL_EPRO_ECPIPT_DEPTH (128)
+#define NBL_EPRO_ECPIPT_WIDTH (32)
+#define NBL_EPRO_ECPIPT_DWLEN (1)
+union epro_ecpipt_u {
+	struct epro_ecpipt {
+		u32 encap_ip_type0:1;    /* [0] Default:0x0 RW */
+		u32 encap_ip_type1_31:31; /* [31:1] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_EPRO_ECPIPT_DWLEN];
+} __packed;
+#define NBL_EPRO_ECPIPT_REG(r) (NBL_EPRO_ECPIPT_ADDR + \
+		(NBL_EPRO_ECPIPT_DWLEN * 4) * (r))
+
+#define NBL_EPRO_RSS_RET_ADDR  (0xe7c000)
+#define NBL_EPRO_RSS_RET_DEPTH (8192)
+#define NBL_EPRO_RSS_RET_WIDTH (32)
+#define NBL_EPRO_RSS_RET_DWLEN (1)
+union epro_rss_ret_u {
+	struct epro_rss_ret {
+		u32 dqueue0:11;          /* [10:0] Default:0x0 RW */
+		u32 vld0:1;              /* [11] Default:0x0 RW */
+		u32 rsv1:4;              /* [15:12] Default:0x0 RO */
+		u32 dqueue1:11;          /* [26:16] Default:0x0 RW */
+		u32 vld1:1;              /* [27] Default:0x0 RW */
+		u32 rsv:4;               /* [31:28] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_EPRO_RSS_RET_DWLEN];
+} __packed;
+#define NBL_EPRO_RSS_RET_REG(r) (NBL_EPRO_RSS_RET_ADDR + \
+		(NBL_EPRO_RSS_RET_DWLEN * 4) * (r))
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_fem.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_fem.h
new file mode 100644
index 000000000000..a895385b16ff
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_fem.h
@@ -0,0 +1,1490 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+// Code generated by interstellar. DO NOT EDIT.
+// Compatible with leonis RTL tag 0710
+
+#ifndef NBL_FEM_H
+#define NBL_FEM_H 1
+
+#include <linux/types.h>
+
+#define NBL_FEM_BASE (0x00A04000)
+
+#define NBL_FEM_INT_STATUS_ADDR  (0xa04000)
+#define NBL_FEM_INT_STATUS_DEPTH (1)
+#define NBL_FEM_INT_STATUS_WIDTH (32)
+#define NBL_FEM_INT_STATUS_DWLEN (1)
+union fem_int_status_u {
+	struct fem_int_status {
+		u32 rsv3:2;              /* [01:00] Default:0x0 RO */
+		u32 fifo_ovf_err:1;      /* [02:02] Default:0x0 RWC */
+		u32 fifo_udf_err:1;      /* [03:03] Default:0x0 RWC */
+		u32 cif_err:1;           /* [04:04] Default:0x0 RWC */
+		u32 rsv2:1;              /* [05:05] Default:0x0 RO */
+		u32 cfg_err:1;           /* [06:06] Default:0x0 RWC */
+		u32 data_ucor_err:1;     /* [07:07] Default:0x0 RWC */
+		u32 bank_cflt_err:1;     /* [08:08] Default:0x0 RWC */
+		u32 rsv1:1;              /* [09:09] Default:0x0 RO */
+		u32 rsv:22;              /* [31:10] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_INT_STATUS_DWLEN];
+} __packed;
+
+#define NBL_FEM_INT_MASK_ADDR  (0xa04004)
+#define NBL_FEM_INT_MASK_DEPTH (1)
+#define NBL_FEM_INT_MASK_WIDTH (32)
+#define NBL_FEM_INT_MASK_DWLEN (1)
+union fem_int_mask_u {
+	struct fem_int_mask {
+		u32 rsv3:2;              /* [01:00] Default:0x0 RO */
+		u32 fifo_ovf_err:1;      /* [02:02] Default:0x0 RW */
+		u32 fifo_udf_err:1;      /* [03:03] Default:0x0 RW */
+		u32 cif_err:1;           /* [04:04] Default:0x0 RW */
+		u32 rsv2:1;              /* [05:05] Default:0x0 RO */
+		u32 cfg_err:1;           /* [06:06] Default:0x0 RW */
+		u32 data_ucor_err:1;     /* [07:07] Default:0x0 RW */
+		u32 bank_cflt_err:1;     /* [08:08] Default:0x0 RW */
+		u32 rsv1:1;              /* [09:09] Default:0x0 RO */
+		u32 rsv:22;              /* [31:10] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_INT_MASK_DWLEN];
+} __packed;
+
+#define NBL_FEM_INT_SET_ADDR  (0xa04008)
+#define NBL_FEM_INT_SET_DEPTH (1)
+#define NBL_FEM_INT_SET_WIDTH (32)
+#define NBL_FEM_INT_SET_DWLEN (1)
+union fem_int_set_u {
+	struct fem_int_set {
+		u32 rsv3:2;              /* [01:00] Default:0x0 RO */
+		u32 fifo_ovf_err:1;      /* [02:02] Default:0x0 WO */
+		u32 fifo_udf_err:1;      /* [03:03] Default:0x0 WO */
+		u32 cif_err:1;           /* [04:04] Default:0x0 WO */
+		u32 rsv2:1;              /* [05:05] Default:0x0 RO */
+		u32 cfg_err:1;           /* [06:06] Default:0x0 WO */
+		u32 data_ucor_err:1;     /* [07:07] Default:0x0 WO */
+		u32 bank_cflt_err:1;     /* [08:08] Default:0x0 WO */
+		u32 rsv1:1;              /* [09:09] Default:0x0 RO */
+		u32 rsv:22;              /* [31:10] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_INT_SET_DWLEN];
+} __packed;
+
+#define NBL_FEM_INIT_DONE_ADDR  (0xa0400c)
+#define NBL_FEM_INIT_DONE_DEPTH (1)
+#define NBL_FEM_INIT_DONE_WIDTH (32)
+#define NBL_FEM_INIT_DONE_DWLEN (1)
+union fem_init_done_u {
+	struct fem_init_done {
+		u32 done:1;              /* [00:00] Default:0x0 RO */
+		u32 rsv:31;              /* [31:01] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_INIT_DONE_DWLEN];
+} __packed;
+
+#define NBL_FEM_CIF_ERR_INFO_ADDR  (0xa04040)
+#define NBL_FEM_CIF_ERR_INFO_DEPTH (1)
+#define NBL_FEM_CIF_ERR_INFO_WIDTH (32)
+#define NBL_FEM_CIF_ERR_INFO_DWLEN (1)
+union fem_cif_err_info_u {
+	struct fem_cif_err_info {
+		u32 addr:30;             /* [29:00] Default:0x0 RO */
+		u32 wr_err:1;            /* [30:30] Default:0x0 RO */
+		u32 ucor_err:1;          /* [31:31] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_CIF_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_FEM_CFG_ERR_INFO_ADDR  (0xa04068)
+#define NBL_FEM_CFG_ERR_INFO_DEPTH (1)
+#define NBL_FEM_CFG_ERR_INFO_WIDTH (32)
+#define NBL_FEM_CFG_ERR_INFO_DWLEN (1)
+union fem_cfg_err_info_u {
+	struct fem_cfg_err_info {
+		u32 addr:24;             /* [23:00] Default:0x0 RO */
+		u32 id:8;                /* [31:24] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_CFG_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_FEM_BANK_CFLT_ERR_INFO0_ADDR  (0xa04074)
+#define NBL_FEM_BANK_CFLT_ERR_INFO0_DEPTH (1)
+#define NBL_FEM_BANK_CFLT_ERR_INFO0_WIDTH (32)
+#define NBL_FEM_BANK_CFLT_ERR_INFO0_DWLEN (1)
+union fem_bank_cflt_err_info0_u {
+	struct fem_bank_cflt_err_info0 {
+		u32 addr0:24;            /* [23:00] Default:0x0 RO */
+		u32 id:8;                /* [31:24] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_BANK_CFLT_ERR_INFO0_DWLEN];
+} __packed;
+
+#define NBL_FEM_BANK_CFLT_ERR_INFO1_ADDR  (0xa04078)
+#define NBL_FEM_BANK_CFLT_ERR_INFO1_DEPTH (1)
+#define NBL_FEM_BANK_CFLT_ERR_INFO1_WIDTH (32)
+#define NBL_FEM_BANK_CFLT_ERR_INFO1_DWLEN (1)
+union fem_bank_cflt_err_info1_u {
+	struct fem_bank_cflt_err_info1 {
+		u32 addr1:24;            /* [23:00] Default:0x0 RO */
+		u32 rsv:8;               /* [31:24] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_BANK_CFLT_ERR_INFO1_DWLEN];
+} __packed;
+
+#define NBL_FEM_CAR_CTRL_ADDR  (0xa04100)
+#define NBL_FEM_CAR_CTRL_DEPTH (1)
+#define NBL_FEM_CAR_CTRL_WIDTH (32)
+#define NBL_FEM_CAR_CTRL_DWLEN (1)
+union fem_car_ctrl_u {
+	struct fem_car_ctrl {
+		u32 sctr_car:1;          /* [00:00] Default:0x1 RW */
+		u32 rctr_car:1;          /* [01:01] Default:0x1 RW */
+		u32 rc_car:1;            /* [02:02] Default:0x1 RW */
+		u32 tbl_rc_car:1;        /* [03:03] Default:0x1 RW */
+		u32 rsv:28;              /* [31:04] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_CAR_CTRL_DWLEN];
+} __packed;
+
+#define NBL_FEM_BP_TH_ADDR  (0xa04118)
+#define NBL_FEM_BP_TH_DEPTH (1)
+#define NBL_FEM_BP_TH_WIDTH (32)
+#define NBL_FEM_BP_TH_DWLEN (1)
+union fem_bp_th_u {
+	struct fem_bp_th {
+		u32 th:12;               /* [11:00] Default:0xf RW */
+		u32 rsv:20;              /* [31:12] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_BP_TH_DWLEN];
+} __packed;
+
+#define NBL_FEM_HT_BANK_SEL_BTM_ADDR  (0xa0411c)
+#define NBL_FEM_HT_BANK_SEL_BTM_DEPTH (1)
+#define NBL_FEM_HT_BANK_SEL_BTM_WIDTH (32)
+#define NBL_FEM_HT_BANK_SEL_BTM_DWLEN (1)
+union fem_ht_bank_sel_btm_u {
+	struct fem_ht_bank_sel_btm {
+		u32 port0_ht_depth:5;    /* [04:00] Default:0x8 RW */
+		u32 rsv2:3;              /* [07:05] Default:0x0 RO */
+		u32 port1_ht_depth:5;    /* [12:08] Default:0x8 RW */
+		u32 rsv1:3;              /* [15:13] Default:0x0 RO */
+		u32 port2_ht_depth:5;    /* [20:16] Default:0x8 RW */
+		u32 rsv:11;              /* [31:21] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_HT_BANK_SEL_BTM_DWLEN];
+} __packed;
+
+#define NBL_FEM_INIT_START_ADDR  (0xa04180)
+#define NBL_FEM_INIT_START_DEPTH (1)
+#define NBL_FEM_INIT_START_WIDTH (32)
+#define NBL_FEM_INIT_START_DWLEN (1)
+union fem_init_start_u {
+	struct fem_init_start {
+		u32 start:1;             /* [00:00] Default:0x0 WO */
+		u32 ht_bank_init:7;      /* [07:01] Default:0x0 WO */
+		u32 rsv:24;              /* [31:08] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_INIT_START_DWLEN];
+} __packed;
+
+#define NBL_FEM_MHASH_ADDR  (0xa04188)
+#define NBL_FEM_MHASH_DEPTH (1)
+#define NBL_FEM_MHASH_WIDTH (32)
+#define NBL_FEM_MHASH_DWLEN (1)
+union fem_mhash_u {
+	struct fem_mhash {
+		u32 mod_action_id:6;     /* [05:00] Default:0x12 RW */
+		u32 hash0_action_id:6;   /* [11:06] Default:0x13 RW */
+		u32 hash1_action_id:6;   /* [17:12] Default:0x14 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_MHASH_DWLEN];
+} __packed;
+
+#define NBL_FEM_CPU_ACCESS_CFG_ADDR  (0xa04190)
+#define NBL_FEM_CPU_ACCESS_CFG_DEPTH (1)
+#define NBL_FEM_CPU_ACCESS_CFG_WIDTH (32)
+#define NBL_FEM_CPU_ACCESS_CFG_DWLEN (1)
+union fem_cpu_access_cfg_u {
+	struct fem_cpu_access_cfg {
+		u32 cpu_access_bp_th:8;  /* [7:0] Default:0xf RW */
+		u32 rsv1:8;              /* [15:8] Default:0x0 RO */
+		u32 cpu_access_timeout_th:10; /* [25:16] Default:0x50 RW */
+		u32 rsv:6;               /* [31:26] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_CPU_ACCESS_CFG_DWLEN];
+} __packed;
+
+#define NBL_FEM_HT_BANK_SEL_BITMAP_ADDR  (0xa04200)
+#define NBL_FEM_HT_BANK_SEL_BITMAP_DEPTH (1)
+#define NBL_FEM_HT_BANK_SEL_BITMAP_WIDTH (32)
+#define NBL_FEM_HT_BANK_SEL_BITMAP_DWLEN (1)
+union fem_ht_bank_sel_bitmap_u {
+	struct fem_ht_bank_sel_bitmap {
+		u32 port0_bank_sel:8;    /* [7:0] Default:0x1 RW */
+		u32 port1_bank_sel:8;    /* [15:8] Default:0x6 RW */
+		u32 port2_bank_sel:8;    /* [23:16] Default:0x78 RW */
+		u32 rsv:8;               /* [31:24] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_HT_BANK_SEL_BITMAP_DWLEN];
+} __packed;
+
+#define NBL_FEM_KT_BANK_SEL_BITMAP_ADDR  (0xa04204)
+#define NBL_FEM_KT_BANK_SEL_BITMAP_DEPTH (1)
+#define NBL_FEM_KT_BANK_SEL_BITMAP_WIDTH (32)
+#define NBL_FEM_KT_BANK_SEL_BITMAP_DWLEN (1)
+union fem_kt_bank_sel_bitmap_u {
+	struct fem_kt_bank_sel_bitmap {
+		u32 port0_bank_sel:8;    /* [7:0] Default:0x1 RW */
+		u32 port1_bank_sel:8;    /* [15:8] Default:0x6 RW */
+		u32 port2_bank_sel:8;    /* [23:16] Default:0xF8 RW */
+		u32 rsv:8;               /* [31:24] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_KT_BANK_SEL_BITMAP_DWLEN];
+} __packed;
+
+#define NBL_FEM_AT_BANK_SEL_BITMAP_ADDR  (0xa04208)
+#define NBL_FEM_AT_BANK_SEL_BITMAP_DEPTH (1)
+#define NBL_FEM_AT_BANK_SEL_BITMAP_WIDTH (32)
+#define NBL_FEM_AT_BANK_SEL_BITMAP_DWLEN (1)
+union fem_at_bank_sel_bitmap_u {
+	struct fem_at_bank_sel_bitmap {
+		u32 port0_bank_sel:12;   /* [11:0] Default:0x3 RW */
+		u32 rsv1:4;              /* [15:12] Default:0x0 RO */
+		u32 port1_bank_sel:12;   /* [27:16] Default:0x1C RW */
+		u32 rsv:4;               /* [31:28] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_AT_BANK_SEL_BITMAP_DWLEN];
+} __packed;
+
+#define NBL_FEM_AT_BANK_SEL_BITMAP2_ADDR  (0xa0420c)
+#define NBL_FEM_AT_BANK_SEL_BITMAP2_DEPTH (1)
+#define NBL_FEM_AT_BANK_SEL_BITMAP2_WIDTH (32)
+#define NBL_FEM_AT_BANK_SEL_BITMAP2_DWLEN (1)
+union fem_at_bank_sel_bitmap2_u {
+	struct fem_at_bank_sel_bitmap2 {
+		u32 port2_bank_sel:12;   /* [11:0] Default:0xFE0 RW */
+		u32 rsv:20;              /* [31:12] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_AT_BANK_SEL_BITMAP2_DWLEN];
+} __packed;
+
+#define NBL_FEM_AGE_EN_ADDR  (0xa04210)
+#define NBL_FEM_AGE_EN_DEPTH (1)
+#define NBL_FEM_AGE_EN_WIDTH (32)
+#define NBL_FEM_AGE_EN_DWLEN (1)
+union fem_age_en_u {
+	struct fem_age_en {
+		u32 en:1;                /* [0] Default:0x0 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_AGE_EN_DWLEN];
+} __packed;
+
+#define NBL_FEM_AGE_HARD_STEP_ADDR  (0xa04214)
+#define NBL_FEM_AGE_HARD_STEP_DEPTH (1)
+#define NBL_FEM_AGE_HARD_STEP_WIDTH (32)
+#define NBL_FEM_AGE_HARD_STEP_DWLEN (1)
+union fem_age_hard_step_u {
+	struct fem_age_hard_step {
+		u32 data:3;              /* [2:0] Default:0x6 RW */
+		u32 rsv:29;              /* [31:3] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_AGE_HARD_STEP_DWLEN];
+} __packed;
+
+#define NBL_FEM_AGE_TIME_UNIT_ADDR  (0xa04218)
+#define NBL_FEM_AGE_TIME_UNIT_DEPTH (1)
+#define NBL_FEM_AGE_TIME_UNIT_WIDTH (32)
+#define NBL_FEM_AGE_TIME_UNIT_DWLEN (1)
+union fem_age_time_unit_u {
+	struct fem_age_time_unit {
+		u32 data:32;             /* [31:0] Default:0x17CB5 RW */
+	} __packed info;
+	u32 data[NBL_FEM_AGE_TIME_UNIT_DWLEN];
+} __packed;
+
+#define NBL_FEM_AGE_INFO_HEAD_ADDR  (0xa04220)
+#define NBL_FEM_AGE_INFO_HEAD_DEPTH (1)
+#define NBL_FEM_AGE_INFO_HEAD_WIDTH (32)
+#define NBL_FEM_AGE_INFO_HEAD_DWLEN (1)
+union fem_age_info_head_u {
+	struct fem_age_info_head {
+		u32 data:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_FEM_AGE_INFO_HEAD_DWLEN];
+} __packed;
+
+#define NBL_FEM_KEY_IN_ADDR  (0xa04240)
+#define NBL_FEM_KEY_IN_DEPTH (1)
+#define NBL_FEM_KEY_IN_WIDTH (32)
+#define NBL_FEM_KEY_IN_DWLEN (1)
+union fem_key_in_u {
+	struct fem_key_in {
+		u32 em0_cap_mode:1;      /* [0:0] Default:0x1 RW */
+		u32 em1_cap_mode:1;      /* [01:01] Default:0x1 RW */
+		u32 em2_cap_mode:1;      /* [02:02] Default:0x1 RW */
+		u32 rsv:29;              /* [31:03] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_KEY_IN_DWLEN];
+} __packed;
+
+#define NBL_FEM_CAP_ADDR  (0xa04244)
+#define NBL_FEM_CAP_DEPTH (1)
+#define NBL_FEM_CAP_WIDTH (32)
+#define NBL_FEM_CAP_DWLEN (1)
+union fem_cap_u {
+	struct fem_cap {
+		u32 em0_cap_start:1;     /* [0:0] Default:0x0 WO */
+		u32 em1_cap_start:1;     /* [01:01] Default:0x0 WO */
+		u32 em2_cap_start:1;     /* [02:02] Default:0x0 WO */
+		u32 rsv:29;              /* [31:03] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_CAP_DWLEN];
+} __packed;
+
+#define NBL_FEM_HT_ACCESS_CTRL_ADDR  (0xa04300)
+#define NBL_FEM_HT_ACCESS_CTRL_DEPTH (1)
+#define NBL_FEM_HT_ACCESS_CTRL_WIDTH (32)
+#define NBL_FEM_HT_ACCESS_CTRL_DWLEN (1)
+union fem_ht_access_ctrl_u {
+	struct fem_ht_access_ctrl {
+		u32 addr:17;             /* [16:00] Default:0x0 RW */
+		u32 port:2;              /* [18:17] Default:0x0 RW */
+		u32 rsv:10;              /* [28:19] Default:0x0 RO */
+		u32 access_size:1;       /* [29:29] Default:0x0 RW */
+		u32 rw:1;                /* [30:30] Default:0x0 RW */
+		u32 start:1;             /* [31:31] Default:0x0 WO */
+	} __packed info;
+	u32 data[NBL_FEM_HT_ACCESS_CTRL_DWLEN];
+} __packed;
+
+#define NBL_FEM_HT_ACCESS_ACK_ADDR  (0xa04304)
+#define NBL_FEM_HT_ACCESS_ACK_DEPTH (1)
+#define NBL_FEM_HT_ACCESS_ACK_WIDTH (32)
+#define NBL_FEM_HT_ACCESS_ACK_DWLEN (1)
+union fem_ht_access_ack_u {
+	struct fem_ht_access_ack {
+		u32 done:1;              /* [00:00] Default:0x0 RC */
+		u32 status:1;            /* [01:01] Default:0x0 RWW */
+		u32 rsv:30;              /* [31:02] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_HT_ACCESS_ACK_DWLEN];
+} __packed;
+
+#define NBL_FEM_HT_ACCESS_DATA_ADDR  (0xa04308)
+#define NBL_FEM_HT_ACCESS_DATA_DEPTH (4)
+#define NBL_FEM_HT_ACCESS_DATA_WIDTH (32)
+#define NBL_FEM_HT_ACCESS_DATA_DWLEN (1)
+union fem_ht_access_data_u {
+	struct fem_ht_access_data {
+		u32 data:32;             /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_FEM_HT_ACCESS_DATA_DWLEN];
+} __packed;
+#define NBL_FEM_HT_ACCESS_DATA_REG(r) (NBL_FEM_HT_ACCESS_DATA_ADDR + \
+		(NBL_FEM_HT_ACCESS_DATA_DWLEN * 4) * (r))
+
+#define NBL_FEM_KT_ACCESS_CTRL_ADDR  (0xa04340)
+#define NBL_FEM_KT_ACCESS_CTRL_DEPTH (1)
+#define NBL_FEM_KT_ACCESS_CTRL_WIDTH (32)
+#define NBL_FEM_KT_ACCESS_CTRL_DWLEN (1)
+union fem_kt_access_ctrl_u {
+	struct fem_kt_access_ctrl {
+		u32 addr:17;             /* [16:00] Default:0x0 RW */
+		u32 rsv:12;              /* [28:17] Default:0x0 RO */
+		u32 access_size:1;       /* [29:29] Default:0x0 RW */
+		u32 rw:1;                /* [30:30] Default:0x0 RW */
+		u32 start:1;             /* [31:31] Default:0x0 WO */
+	} __packed info;
+	u32 data[NBL_FEM_KT_ACCESS_CTRL_DWLEN];
+} __packed;
+
+#define NBL_FEM_KT_ACCESS_ACK_ADDR  (0xa04344)
+#define NBL_FEM_KT_ACCESS_ACK_DEPTH (1)
+#define NBL_FEM_KT_ACCESS_ACK_WIDTH (32)
+#define NBL_FEM_KT_ACCESS_ACK_DWLEN (1)
+union fem_kt_access_ack_u {
+	struct fem_kt_access_ack {
+		u32 done:1;              /* [00:00] Default:0x0 RC */
+		u32 status:1;            /* [01:01] Default:0x0 RWW */
+		u32 rsv:30;              /* [31:02] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_KT_ACCESS_ACK_DWLEN];
+} __packed;
+
+#define NBL_FEM_KT_ACCESS_DATA_ADDR  (0xa04348)
+#define NBL_FEM_KT_ACCESS_DATA_DEPTH (10)
+#define NBL_FEM_KT_ACCESS_DATA_WIDTH (32)
+#define NBL_FEM_KT_ACCESS_DATA_DWLEN (1)
+union fem_kt_access_data_u {
+	struct fem_kt_access_data {
+		u32 data:32;             /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_FEM_KT_ACCESS_DATA_DWLEN];
+} __packed;
+#define NBL_FEM_KT_ACCESS_DATA_REG(r) (NBL_FEM_KT_ACCESS_DATA_ADDR + \
+		(NBL_FEM_KT_ACCESS_DATA_DWLEN * 4) * (r))
+
+#define NBL_FEM_AT_ACCESS_CTRL_ADDR  (0xa04390)
+#define NBL_FEM_AT_ACCESS_CTRL_DEPTH (1)
+#define NBL_FEM_AT_ACCESS_CTRL_WIDTH (32)
+#define NBL_FEM_AT_ACCESS_CTRL_DWLEN (1)
+union fem_at_access_ctrl_u {
+	struct fem_at_access_ctrl {
+		u32 addr:17;             /* [16:00] Default:0x0 RW */
+		u32 rsv:12;              /* [28:17] Default:0x0 RO */
+		u32 access_size:1;       /* [29:29] Default:0x0 RW */
+		u32 rw:1;                /* [30:30] Default:0x0 RW */
+		u32 start:1;             /* [31:31] Default:0x0 WO */
+	} __packed info;
+	u32 data[NBL_FEM_AT_ACCESS_CTRL_DWLEN];
+} __packed;
+
+#define NBL_FEM_AT_ACCESS_ACK_ADDR  (0xa04394)
+#define NBL_FEM_AT_ACCESS_ACK_DEPTH (1)
+#define NBL_FEM_AT_ACCESS_ACK_WIDTH (32)
+#define NBL_FEM_AT_ACCESS_ACK_DWLEN (1)
+union fem_at_access_ack_u {
+	struct fem_at_access_ack {
+		u32 done:1;              /* [00:00] Default:0x0 RC */
+		u32 status:1;            /* [01:01] Default:0x0 RWW */
+		u32 rsv:30;              /* [31:02] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_AT_ACCESS_ACK_DWLEN];
+} __packed;
+
+#define NBL_FEM_AT_ACCESS_DATA_ADDR  (0xa04398)
+#define NBL_FEM_AT_ACCESS_DATA_DEPTH (6)
+#define NBL_FEM_AT_ACCESS_DATA_WIDTH (32)
+#define NBL_FEM_AT_ACCESS_DATA_DWLEN (1)
+union fem_at_access_data_u {
+	struct fem_at_access_data {
+		u32 data:32;             /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_FEM_AT_ACCESS_DATA_DWLEN];
+} __packed;
+#define NBL_FEM_AT_ACCESS_DATA_REG(r) (NBL_FEM_AT_ACCESS_DATA_ADDR + \
+		(NBL_FEM_AT_ACCESS_DATA_DWLEN * 4) * (r))
+
+#define NBL_FEM_AGE_TBL_ACCESS_CTRL_ADDR  (0xa04400)
+#define NBL_FEM_AGE_TBL_ACCESS_CTRL_DEPTH (1)
+#define NBL_FEM_AGE_TBL_ACCESS_CTRL_WIDTH (32)
+#define NBL_FEM_AGE_TBL_ACCESS_CTRL_DWLEN (1)
+union fem_age_tbl_access_ctrl_u {
+	struct fem_age_tbl_access_ctrl {
+		u32 addr:17;             /* [16:0] Default:0x0 RW */
+		u32 rsv:13;              /* [29:17] Default:0x0 RO */
+		u32 rw:1;                /* [30:30] Default:0x0 RW */
+		u32 start:1;             /* [31] Default:0x0 WO */
+	} __packed info;
+	u32 data[NBL_FEM_AGE_TBL_ACCESS_CTRL_DWLEN];
+} __packed;
+
+#define NBL_FEM_AGE_TBL_ACCESS_ACK_ADDR  (0xa04404)
+#define NBL_FEM_AGE_TBL_ACCESS_ACK_DEPTH (1)
+#define NBL_FEM_AGE_TBL_ACCESS_ACK_WIDTH (32)
+#define NBL_FEM_AGE_TBL_ACCESS_ACK_DWLEN (1)
+union fem_age_tbl_access_ack_u {
+	struct fem_age_tbl_access_ack {
+		u32 done:1;              /* [0] Default:0x0 RC */
+		u32 status:1;            /* [1] Default:0x0 RWW */
+		u32 rsv:30;              /* [31:2] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_AGE_TBL_ACCESS_ACK_DWLEN];
+} __packed;
+
+#define NBL_FEM_AGE_TBL_ACCESS_DATA_ADDR  (0xa04408)
+#define NBL_FEM_AGE_TBL_ACCESS_DATA_DEPTH (12)
+#define NBL_FEM_AGE_TBL_ACCESS_DATA_WIDTH (32)
+#define NBL_FEM_AGE_TBL_ACCESS_DATA_DWLEN (1)
+union fem_age_tbl_access_data_u {
+	struct fem_age_tbl_access_data {
+		u32 data:32;             /* [31:0] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_FEM_AGE_TBL_ACCESS_DATA_DWLEN];
+} __packed;
+#define NBL_FEM_AGE_TBL_ACCESS_DATA_REG(r) (NBL_FEM_AGE_TBL_ACCESS_DATA_ADDR + \
+		(NBL_FEM_AGE_TBL_ACCESS_DATA_DWLEN * 4) * (r))
+
+#define NBL_FEM_CPU_INSERT_SEARCH0_CTRL_ADDR  (0xa04500)
+#define NBL_FEM_CPU_INSERT_SEARCH0_CTRL_DEPTH (1)
+#define NBL_FEM_CPU_INSERT_SEARCH0_CTRL_WIDTH (32)
+#define NBL_FEM_CPU_INSERT_SEARCH0_CTRL_DWLEN (1)
+union fem_cpu_insert_search0_ctrl_u {
+	struct fem_cpu_insert_search0_ctrl {
+		u32 rsv:31;              /* [30:00] Default:0x0 RO */
+		u32 start:1;             /* [31:31] Default:0x0 WO */
+	} __packed info;
+	u32 data[NBL_FEM_CPU_INSERT_SEARCH0_CTRL_DWLEN];
+} __packed;
+
+#define NBL_FEM_CPU_INSERT_SEARCH0_ACK_ADDR  (0xa04504)
+#define NBL_FEM_CPU_INSERT_SEARCH0_ACK_DEPTH (1)
+#define NBL_FEM_CPU_INSERT_SEARCH0_ACK_WIDTH (32)
+#define NBL_FEM_CPU_INSERT_SEARCH0_ACK_DWLEN (1)
+union fem_cpu_insert_search0_ack_u {
+	struct fem_cpu_insert_search0_ack {
+		u32 done:1;              /* [00:00] Default:0x0 RC */
+		u32 status:2;            /* [02:01] Default:0x0 RWW */
+		u32 rsv:29;              /* [31:03] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_CPU_INSERT_SEARCH0_ACK_DWLEN];
+} __packed;
+
+#define NBL_FEM_CPU_INSERT_SEARCH0_DATA_ADDR  (0xa04508)
+#define NBL_FEM_CPU_INSERT_SEARCH0_DATA_DEPTH (11)
+#define NBL_FEM_CPU_INSERT_SEARCH0_DATA_WIDTH (32)
+#define NBL_FEM_CPU_INSERT_SEARCH0_DATA_DWLEN (1)
+union fem_cpu_insert_search0_data_u {
+	struct fem_cpu_insert_search0_data {
+		u32 data:32;             /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_FEM_CPU_INSERT_SEARCH0_DATA_DWLEN];
+} __packed;
+#define NBL_FEM_CPU_INSERT_SEARCH0_DATA_REG(r) (NBL_FEM_CPU_INSERT_SEARCH0_DATA_ADDR + \
+		(NBL_FEM_CPU_INSERT_SEARCH0_DATA_DWLEN * 4) * (r))
+
+#define NBL_FEM_CPU_INSERT_SEARCH1_CTRL_ADDR  (0xa04550)
+#define NBL_FEM_CPU_INSERT_SEARCH1_CTRL_DEPTH (1)
+#define NBL_FEM_CPU_INSERT_SEARCH1_CTRL_WIDTH (32)
+#define NBL_FEM_CPU_INSERT_SEARCH1_CTRL_DWLEN (1)
+union fem_cpu_insert_search1_ctrl_u {
+	struct fem_cpu_insert_search1_ctrl {
+		u32 rsv:31;              /* [30:00] Default:0x0 RO */
+		u32 start:1;             /* [31:31] Default:0x0 WO */
+	} __packed info;
+	u32 data[NBL_FEM_CPU_INSERT_SEARCH1_CTRL_DWLEN];
+} __packed;
+
+#define NBL_FEM_CPU_INSERT_SEARCH1_ACK_ADDR  (0xa04554)
+#define NBL_FEM_CPU_INSERT_SEARCH1_ACK_DEPTH (1)
+#define NBL_FEM_CPU_INSERT_SEARCH1_ACK_WIDTH (32)
+#define NBL_FEM_CPU_INSERT_SEARCH1_ACK_DWLEN (1)
+union fem_cpu_insert_search1_ack_u {
+	struct fem_cpu_insert_search1_ack {
+		u32 done:1;              /* [00:00] Default:0x0 RC */
+		u32 status:2;            /* [02:01] Default:0x0 RWW */
+		u32 rsv:29;              /* [31:03] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_CPU_INSERT_SEARCH1_ACK_DWLEN];
+} __packed;
+
+#define NBL_FEM_CPU_INSERT_SEARCH1_DATA_ADDR  (0xa04558)
+#define NBL_FEM_CPU_INSERT_SEARCH1_DATA_DEPTH (11)
+#define NBL_FEM_CPU_INSERT_SEARCH1_DATA_WIDTH (32)
+#define NBL_FEM_CPU_INSERT_SEARCH1_DATA_DWLEN (1)
+union fem_cpu_insert_search1_data_u {
+	struct fem_cpu_insert_search1_data {
+		u32 data:32;             /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_FEM_CPU_INSERT_SEARCH1_DATA_DWLEN];
+} __packed;
+#define NBL_FEM_CPU_INSERT_SEARCH1_DATA_REG(r) (NBL_FEM_CPU_INSERT_SEARCH1_DATA_ADDR + \
+		(NBL_FEM_CPU_INSERT_SEARCH1_DATA_DWLEN * 4) * (r))
+
+#define NBL_FEM_CPU_INSERT_SEARCH2_CTRL_ADDR  (0xa045a0)
+#define NBL_FEM_CPU_INSERT_SEARCH2_CTRL_DEPTH (1)
+#define NBL_FEM_CPU_INSERT_SEARCH2_CTRL_WIDTH (32)
+#define NBL_FEM_CPU_INSERT_SEARCH2_CTRL_DWLEN (1)
+union fem_cpu_insert_search2_ctrl_u {
+	struct fem_cpu_insert_search2_ctrl {
+		u32 rsv:31;              /* [30:00] Default:0x0 RO */
+		u32 start:1;             /* [31:31] Default:0x0 WO */
+	} __packed info;
+	u32 data[NBL_FEM_CPU_INSERT_SEARCH2_CTRL_DWLEN];
+} __packed;
+
+#define NBL_FEM_CPU_INSERT_SEARCH2_ACK_ADDR  (0xa045a4)
+#define NBL_FEM_CPU_INSERT_SEARCH2_ACK_DEPTH (1)
+#define NBL_FEM_CPU_INSERT_SEARCH2_ACK_WIDTH (32)
+#define NBL_FEM_CPU_INSERT_SEARCH2_ACK_DWLEN (1)
+union fem_cpu_insert_search2_ack_u {
+	struct fem_cpu_insert_search2_ack {
+		u32 done:1;              /* [00:00] Default:0x0 RC */
+		u32 status:2;            /* [02:01] Default:0x0 RWW */
+		u32 rsv:29;              /* [31:03] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_CPU_INSERT_SEARCH2_ACK_DWLEN];
+} __packed;
+
+#define NBL_FEM_CPU_INSERT_SEARCH2_DATA_ADDR  (0xa045a8)
+#define NBL_FEM_CPU_INSERT_SEARCH2_DATA_DEPTH (11)
+#define NBL_FEM_CPU_INSERT_SEARCH2_DATA_WIDTH (32)
+#define NBL_FEM_CPU_INSERT_SEARCH2_DATA_DWLEN (1)
+union fem_cpu_insert_search2_data_u {
+	struct fem_cpu_insert_search2_data {
+		u32 data:32;             /* [31:00] Default:0x0 RWW */
+	} __packed info;
+	u32 data[NBL_FEM_CPU_INSERT_SEARCH2_DATA_DWLEN];
+} __packed;
+#define NBL_FEM_CPU_INSERT_SEARCH2_DATA_REG(r) (NBL_FEM_CPU_INSERT_SEARCH2_DATA_ADDR + \
+		(NBL_FEM_CPU_INSERT_SEARCH2_DATA_DWLEN * 4) * (r))
+
+#define NBL_FEM_CFG_TEST_ADDR  (0xa0480c)
+#define NBL_FEM_CFG_TEST_DEPTH (1)
+#define NBL_FEM_CFG_TEST_WIDTH (32)
+#define NBL_FEM_CFG_TEST_DWLEN (1)
+union fem_cfg_test_u {
+	struct fem_cfg_test {
+		u32 test:32;             /* [31:00] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_FEM_CFG_TEST_DWLEN];
+} __packed;
+
+#define NBL_FEM_RCV_CMDQ_ADDR  (0xa04818)
+#define NBL_FEM_RCV_CMDQ_DEPTH (1)
+#define NBL_FEM_RCV_CMDQ_WIDTH (32)
+#define NBL_FEM_RCV_CMDQ_DWLEN (1)
+union fem_rcv_cmdq_u {
+	struct fem_rcv_cmdq {
+		u32 cnt:32;              /* [31:00] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_FEM_RCV_CMDQ_DWLEN];
+} __packed;
+
+#define NBL_FEM_SND_CMDQ_ADDR  (0xa0481c)
+#define NBL_FEM_SND_CMDQ_DEPTH (1)
+#define NBL_FEM_SND_CMDQ_WIDTH (32)
+#define NBL_FEM_SND_CMDQ_DWLEN (1)
+union fem_snd_cmdq_u {
+	struct fem_snd_cmdq {
+		u32 cnt:32;              /* [31:00] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_FEM_SND_CMDQ_DWLEN];
+} __packed;
+
+#define NBL_FEM_CMDQ_PRO_ADDR  (0xa04820)
+#define NBL_FEM_CMDQ_PRO_DEPTH (1)
+#define NBL_FEM_CMDQ_PRO_WIDTH (32)
+#define NBL_FEM_CMDQ_PRO_DWLEN (1)
+union fem_cmdq_pro_u {
+	struct fem_cmdq_pro {
+		u32 cnt:32;              /* [31:00] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_FEM_CMDQ_PRO_DWLEN];
+} __packed;
+
+#define NBL_FEM_PP0_REQ_ADDR  (0xa04850)
+#define NBL_FEM_PP0_REQ_DEPTH (1)
+#define NBL_FEM_PP0_REQ_WIDTH (32)
+#define NBL_FEM_PP0_REQ_DWLEN (1)
+union fem_pp0_req_u {
+	struct fem_pp0_req {
+		u32 cnt:32;              /* [31:00] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_FEM_PP0_REQ_DWLEN];
+} __packed;
+
+#define NBL_FEM_PP0_ALL_RSP_ADDR  (0xa04854)
+#define NBL_FEM_PP0_ALL_RSP_DEPTH (1)
+#define NBL_FEM_PP0_ALL_RSP_WIDTH (32)
+#define NBL_FEM_PP0_ALL_RSP_DWLEN (1)
+union fem_pp0_all_rsp_u {
+	struct fem_pp0_all_rsp {
+		u32 cnt:32;              /* [31:00] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_FEM_PP0_ALL_RSP_DWLEN];
+} __packed;
+
+#define NBL_FEM_PP0_RSP_ADDR  (0xa04858)
+#define NBL_FEM_PP0_RSP_DEPTH (1)
+#define NBL_FEM_PP0_RSP_WIDTH (32)
+#define NBL_FEM_PP0_RSP_DWLEN (1)
+union fem_pp0_rsp_u {
+	struct fem_pp0_rsp {
+		u32 miss_cnt:16;         /* [15:00] Default:0x0 RCTR */
+		u32 err_cnt:16;          /* [31:16] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_FEM_PP0_RSP_DWLEN];
+} __packed;
+
+#define NBL_FEM_EM0_HT_LOOKUP_ADDR  (0xa04878)
+#define NBL_FEM_EM0_HT_LOOKUP_DEPTH (1)
+#define NBL_FEM_EM0_HT_LOOKUP_WIDTH (32)
+#define NBL_FEM_EM0_HT_LOOKUP_DWLEN (1)
+union fem_em0_ht_lookup_u {
+	struct fem_em0_ht_lookup {
+		u32 cnt:16;              /* [15:00] Default:0x0 RCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM0_HT_LOOKUP_DWLEN];
+} __packed;
+
+#define NBL_FEM_EM0_HT_HIT_ADDR  (0xa0487c)
+#define NBL_FEM_EM0_HT_HIT_DEPTH (1)
+#define NBL_FEM_EM0_HT_HIT_WIDTH (32)
+#define NBL_FEM_EM0_HT_HIT_DWLEN (1)
+union fem_em0_ht_hit_u {
+	struct fem_em0_ht_hit {
+		u32 cnt:16;              /* [15:00] Default:0x0 RCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM0_HT_HIT_DWLEN];
+} __packed;
+
+#define NBL_FEM_EM0_TCAM_LOOKUP_ADDR  (0xa04880)
+#define NBL_FEM_EM0_TCAM_LOOKUP_DEPTH (1)
+#define NBL_FEM_EM0_TCAM_LOOKUP_WIDTH (32)
+#define NBL_FEM_EM0_TCAM_LOOKUP_DWLEN (1)
+union fem_em0_tcam_lookup_u {
+	struct fem_em0_tcam_lookup {
+		u32 cnt:16;              /* [15:00] Default:0x0 RCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM0_TCAM_LOOKUP_DWLEN];
+} __packed;
+
+#define NBL_FEM_EM0_TCAM_HIT_ADDR  (0xa04884)
+#define NBL_FEM_EM0_TCAM_HIT_DEPTH (1)
+#define NBL_FEM_EM0_TCAM_HIT_WIDTH (32)
+#define NBL_FEM_EM0_TCAM_HIT_DWLEN (1)
+union fem_em0_tcam_hit_u {
+	struct fem_em0_tcam_hit {
+		u32 cnt:16;              /* [15:00] Default:0x0 RCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM0_TCAM_HIT_DWLEN];
+} __packed;
+
+#define NBL_FEM_EM0_KT_LOOKUP_ADDR  (0xa04888)
+#define NBL_FEM_EM0_KT_LOOKUP_DEPTH (1)
+#define NBL_FEM_EM0_KT_LOOKUP_WIDTH (32)
+#define NBL_FEM_EM0_KT_LOOKUP_DWLEN (1)
+union fem_em0_kt_lookup_u {
+	struct fem_em0_kt_lookup {
+		u32 cnt:16;              /* [15:00] Default:0x0 RCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM0_KT_LOOKUP_DWLEN];
+} __packed;
+
+#define NBL_FEM_EM0_KT_HIT_ADDR  (0xa0488c)
+#define NBL_FEM_EM0_KT_HIT_DEPTH (1)
+#define NBL_FEM_EM0_KT_HIT_WIDTH (32)
+#define NBL_FEM_EM0_KT_HIT_DWLEN (1)
+union fem_em0_kt_hit_u {
+	struct fem_em0_kt_hit {
+		u32 cnt:16;              /* [15:00] Default:0x0 RCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM0_KT_HIT_DWLEN];
+} __packed;
+
+#define NBL_FEM_PP1_REQ_ADDR  (0xa048b0)
+#define NBL_FEM_PP1_REQ_DEPTH (1)
+#define NBL_FEM_PP1_REQ_WIDTH (32)
+#define NBL_FEM_PP1_REQ_DWLEN (1)
+union fem_pp1_req_u {
+	struct fem_pp1_req {
+		u32 cnt:32;              /* [31:00] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_FEM_PP1_REQ_DWLEN];
+} __packed;
+
+#define NBL_FEM_PP1_ALL_RSP_ADDR  (0xa048b4)
+#define NBL_FEM_PP1_ALL_RSP_DEPTH (1)
+#define NBL_FEM_PP1_ALL_RSP_WIDTH (32)
+#define NBL_FEM_PP1_ALL_RSP_DWLEN (1)
+union fem_pp1_all_rsp_u {
+	struct fem_pp1_all_rsp {
+		u32 cnt:32;              /* [31:00] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_FEM_PP1_ALL_RSP_DWLEN];
+} __packed;
+
+#define NBL_FEM_PP1_RSP_ADDR  (0xa048b8)
+#define NBL_FEM_PP1_RSP_DEPTH (1)
+#define NBL_FEM_PP1_RSP_WIDTH (32)
+#define NBL_FEM_PP1_RSP_DWLEN (1)
+union fem_pp1_rsp_u {
+	struct fem_pp1_rsp {
+		u32 miss_cnt:16;         /* [15:00] Default:0x0 RCTR */
+		u32 err_cnt:16;          /* [31:16] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_FEM_PP1_RSP_DWLEN];
+} __packed;
+
+#define NBL_FEM_EM1_HT_LOOKUP_ADDR  (0xa048d8)
+#define NBL_FEM_EM1_HT_LOOKUP_DEPTH (1)
+#define NBL_FEM_EM1_HT_LOOKUP_WIDTH (32)
+#define NBL_FEM_EM1_HT_LOOKUP_DWLEN (1)
+union fem_em1_ht_lookup_u {
+	struct fem_em1_ht_lookup {
+		u32 cnt:16;              /* [15:00] Default:0x0 RCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM1_HT_LOOKUP_DWLEN];
+} __packed;
+
+#define NBL_FEM_EM1_HT_HIT_ADDR  (0xa048dc)
+#define NBL_FEM_EM1_HT_HIT_DEPTH (1)
+#define NBL_FEM_EM1_HT_HIT_WIDTH (32)
+#define NBL_FEM_EM1_HT_HIT_DWLEN (1)
+union fem_em1_ht_hit_u {
+	struct fem_em1_ht_hit {
+		u32 cnt:16;              /* [15:00] Default:0x0 RCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM1_HT_HIT_DWLEN];
+} __packed;
+
+#define NBL_FEM_EM1_TCAM_LOOKUP_ADDR  (0xa048e0)
+#define NBL_FEM_EM1_TCAM_LOOKUP_DEPTH (1)
+#define NBL_FEM_EM1_TCAM_LOOKUP_WIDTH (32)
+#define NBL_FEM_EM1_TCAM_LOOKUP_DWLEN (1)
+union fem_em1_tcam_lookup_u {
+	struct fem_em1_tcam_lookup {
+		u32 cnt:16;              /* [15:00] Default:0x0 RCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM1_TCAM_LOOKUP_DWLEN];
+} __packed;
+
+#define NBL_FEM_EM1_TCAM_HIT_ADDR  (0xa048e4)
+#define NBL_FEM_EM1_TCAM_HIT_DEPTH (1)
+#define NBL_FEM_EM1_TCAM_HIT_WIDTH (32)
+#define NBL_FEM_EM1_TCAM_HIT_DWLEN (1)
+union fem_em1_tcam_hit_u {
+	struct fem_em1_tcam_hit {
+		u32 cnt:16;              /* [15:00] Default:0x0 RCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM1_TCAM_HIT_DWLEN];
+} __packed;
+
+#define NBL_FEM_EM1_KT_LOOKUP_ADDR  (0xa048e8)
+#define NBL_FEM_EM1_KT_LOOKUP_DEPTH (1)
+#define NBL_FEM_EM1_KT_LOOKUP_WIDTH (32)
+#define NBL_FEM_EM1_KT_LOOKUP_DWLEN (1)
+union fem_em1_kt_lookup_u {
+	struct fem_em1_kt_lookup {
+		u32 cnt:16;              /* [15:00] Default:0x0 RCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM1_KT_LOOKUP_DWLEN];
+} __packed;
+
+#define NBL_FEM_EM1_KT_HIT_ADDR  (0xa048ec)
+#define NBL_FEM_EM1_KT_HIT_DEPTH (1)
+#define NBL_FEM_EM1_KT_HIT_WIDTH (32)
+#define NBL_FEM_EM1_KT_HIT_DWLEN (1)
+union fem_em1_kt_hit_u {
+	struct fem_em1_kt_hit {
+		u32 cnt:16;              /* [15:00] Default:0x0 RCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM1_KT_HIT_DWLEN];
+} __packed;
+
+#define NBL_FEM_PP2_REQ_ADDR  (0xa04910)
+#define NBL_FEM_PP2_REQ_DEPTH (1)
+#define NBL_FEM_PP2_REQ_WIDTH (32)
+#define NBL_FEM_PP2_REQ_DWLEN (1)
+union fem_pp2_req_u {
+	struct fem_pp2_req {
+		u32 cnt:32;              /* [31:00] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_FEM_PP2_REQ_DWLEN];
+} __packed;
+
+#define NBL_FEM_PP2_ALL_RSP_ADDR  (0xa04914)
+#define NBL_FEM_PP2_ALL_RSP_DEPTH (1)
+#define NBL_FEM_PP2_ALL_RSP_WIDTH (32)
+#define NBL_FEM_PP2_ALL_RSP_DWLEN (1)
+union fem_pp2_all_rsp_u {
+	struct fem_pp2_all_rsp {
+		u32 cnt:32;              /* [31:00] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_FEM_PP2_ALL_RSP_DWLEN];
+} __packed;
+
+#define NBL_FEM_PP2_RSP_ADDR  (0xa04918)
+#define NBL_FEM_PP2_RSP_DEPTH (1)
+#define NBL_FEM_PP2_RSP_WIDTH (32)
+#define NBL_FEM_PP2_RSP_DWLEN (1)
+union fem_pp2_rsp_u {
+	struct fem_pp2_rsp {
+		u32 miss_cnt:16;         /* [15:00] Default:0x0 RCTR */
+		u32 err_cnt:16;          /* [31:16] Default:0x0 RCTR */
+	} __packed info;
+	u32 data[NBL_FEM_PP2_RSP_DWLEN];
+} __packed;
+
+#define NBL_FEM_EM2_HT_LOOKUP_ADDR  (0xa04938)
+#define NBL_FEM_EM2_HT_LOOKUP_DEPTH (1)
+#define NBL_FEM_EM2_HT_LOOKUP_WIDTH (32)
+#define NBL_FEM_EM2_HT_LOOKUP_DWLEN (1)
+union fem_em2_ht_lookup_u {
+	struct fem_em2_ht_lookup {
+		u32 cnt:16;              /* [15:00] Default:0x0 RCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM2_HT_LOOKUP_DWLEN];
+} __packed;
+
+#define NBL_FEM_EM2_HT_HIT_ADDR  (0xa0493c)
+#define NBL_FEM_EM2_HT_HIT_DEPTH (1)
+#define NBL_FEM_EM2_HT_HIT_WIDTH (32)
+#define NBL_FEM_EM2_HT_HIT_DWLEN (1)
+union fem_em2_ht_hit_u {
+	struct fem_em2_ht_hit {
+		u32 cnt:16;              /* [15:00] Default:0x0 RCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM2_HT_HIT_DWLEN];
+} __packed;
+
+#define NBL_FEM_EM2_TCAM_LOOKUP_ADDR  (0xa04940)
+#define NBL_FEM_EM2_TCAM_LOOKUP_DEPTH (1)
+#define NBL_FEM_EM2_TCAM_LOOKUP_WIDTH (32)
+#define NBL_FEM_EM2_TCAM_LOOKUP_DWLEN (1)
+union fem_em2_tcam_lookup_u {
+	struct fem_em2_tcam_lookup {
+		u32 cnt:16;              /* [15:00] Default:0x0 RCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM2_TCAM_LOOKUP_DWLEN];
+} __packed;
+
+#define NBL_FEM_EM2_TCAM_HIT_ADDR  (0xa04944)
+#define NBL_FEM_EM2_TCAM_HIT_DEPTH (1)
+#define NBL_FEM_EM2_TCAM_HIT_WIDTH (32)
+#define NBL_FEM_EM2_TCAM_HIT_DWLEN (1)
+union fem_em2_tcam_hit_u {
+	struct fem_em2_tcam_hit {
+		u32 cnt:16;              /* [15:00] Default:0x0 RCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM2_TCAM_HIT_DWLEN];
+} __packed;
+
+#define NBL_FEM_EM2_KT_LOOKUP_ADDR  (0xa04948)
+#define NBL_FEM_EM2_KT_LOOKUP_DEPTH (1)
+#define NBL_FEM_EM2_KT_LOOKUP_WIDTH (32)
+#define NBL_FEM_EM2_KT_LOOKUP_DWLEN (1)
+union fem_em2_kt_lookup_u {
+	struct fem_em2_kt_lookup {
+		u32 cnt:16;              /* [15:00] Default:0x0 RCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM2_KT_LOOKUP_DWLEN];
+} __packed;
+
+#define NBL_FEM_EM2_KT_HIT_ADDR  (0xa0494c)
+#define NBL_FEM_EM2_KT_HIT_DEPTH (1)
+#define NBL_FEM_EM2_KT_HIT_WIDTH (32)
+#define NBL_FEM_EM2_KT_HIT_DWLEN (1)
+union fem_em2_kt_hit_u {
+	struct fem_em2_kt_hit {
+		u32 cnt:16;              /* [15:00] Default:0x0 RCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM2_KT_HIT_DWLEN];
+} __packed;
+
+#define NBL_FEM_AGE_INFO_DROP_ADDR  (0xa04950)
+#define NBL_FEM_AGE_INFO_DROP_DEPTH (1)
+#define NBL_FEM_AGE_INFO_DROP_WIDTH (32)
+#define NBL_FEM_AGE_INFO_DROP_DWLEN (1)
+union fem_age_info_drop_u {
+	struct fem_age_info_drop {
+		u32 cnt:32;              /* [31:00] Default:0x0 SCTR */
+	} __packed info;
+	u32 data[NBL_FEM_AGE_INFO_DROP_DWLEN];
+} __packed;
+
+#define NBL_FEM_EM0_PP_KEY_CHANGE_ADDR  (0xa04954)
+#define NBL_FEM_EM0_PP_KEY_CHANGE_DEPTH (1)
+#define NBL_FEM_EM0_PP_KEY_CHANGE_WIDTH (32)
+#define NBL_FEM_EM0_PP_KEY_CHANGE_DWLEN (1)
+union fem_em0_pp_key_change_u {
+	struct fem_em0_pp_key_change {
+		u32 cnt:32;              /* [31:00] Default:0x0 SCTR */
+	} __packed info;
+	u32 data[NBL_FEM_EM0_PP_KEY_CHANGE_DWLEN];
+} __packed;
+
+#define NBL_FEM_EM1_PP_KEY_CHANGE_ADDR  (0xa04958)
+#define NBL_FEM_EM1_PP_KEY_CHANGE_DEPTH (1)
+#define NBL_FEM_EM1_PP_KEY_CHANGE_WIDTH (32)
+#define NBL_FEM_EM1_PP_KEY_CHANGE_DWLEN (1)
+union fem_em1_pp_key_change_u {
+	struct fem_em1_pp_key_change {
+		u32 cnt:32;              /* [31:00] Default:0x0 SCTR */
+	} __packed info;
+	u32 data[NBL_FEM_EM1_PP_KEY_CHANGE_DWLEN];
+} __packed;
+
+#define NBL_FEM_EM2_PP_KEY_CHANGE_ADDR  (0xa0495c)
+#define NBL_FEM_EM2_PP_KEY_CHANGE_DEPTH (1)
+#define NBL_FEM_EM2_PP_KEY_CHANGE_WIDTH (32)
+#define NBL_FEM_EM2_PP_KEY_CHANGE_DWLEN (1)
+union fem_em2_pp_key_change_u {
+	struct fem_em2_pp_key_change {
+		u32 cnt:32;              /* [31:00] Default:0x0 SCTR */
+	} __packed info;
+	u32 data[NBL_FEM_EM2_PP_KEY_CHANGE_DWLEN];
+} __packed;
+
+#define NBL_FEM_BP_STATE_ADDR  (0xa04b00)
+#define NBL_FEM_BP_STATE_DEPTH (1)
+#define NBL_FEM_BP_STATE_WIDTH (32)
+#define NBL_FEM_BP_STATE_DWLEN (1)
+union fem_bp_state_u {
+	struct fem_bp_state {
+		u32 fem_pp0_bp:1;        /* [00:00] Default:0x0 RO */
+		u32 fem_pp1_bp:1;        /* [01:01] Default:0x0 RO */
+		u32 fem_pp2_bp:1;        /* [02:02] Default:0x0 RO */
+		u32 up_cmdq_bp:1;        /* [03:03] Default:0x0 RO */
+		u32 dn_acl_cmdq_bp:1;    /* [04:04] Default:0x0 RO */
+		u32 dn_age_msgq_bp:1;    /* [05:05] Default:0x0 RO */
+		u32 p0_ht0_cpu_acc_bp:1; /* [06:06] Default:0x0 RO */
+		u32 p1_ht0_cpu_acc_bp:1; /* [07:07] Default:0x0 RO */
+		u32 p2_ht0_cpu_acc_bp:1; /* [08:08] Default:0x0 RO */
+		u32 p0_ht1_cpu_acc_bp:1; /* [09:09] Default:0x0 RO */
+		u32 p1_ht1_cpu_acc_bp:1; /* [10:10] Default:0x0 RO */
+		u32 p2_ht1_cpu_acc_bp:1; /* [11:11] Default:0x0 RO */
+		u32 p0_kt_cpu_acc_bp:1;  /* [12:12] Default:0x0 RO */
+		u32 p1_kt_cpu_acc_bp:1;  /* [13:13] Default:0x0 RO */
+		u32 p2_kt_cpu_acc_bp:1;  /* [14:14] Default:0x0 RO */
+		u32 p0_at_cpu_acc_bp:1;  /* [15:15] Default:0x0 RO */
+		u32 p1_at_cpu_acc_bp:1;  /* [16:16] Default:0x0 RO */
+		u32 p2_at_cpu_acc_bp:1;  /* [17:17] Default:0x0 RO */
+		u32 p0_age_cpu_acc_bp:1; /* [18:18] Default:0x0 RO */
+		u32 p1_age_cpu_acc_bp:1; /* [19:19] Default:0x0 RO */
+		u32 p2_age_cpu_acc_bp:1; /* [20:20] Default:0x0 RO */
+		u32 rsv:11;              /* [31:21] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_BP_STATE_DWLEN];
+} __packed;
+
+#define NBL_FEM_BP_HISTORY_ADDR  (0xa04b04)
+#define NBL_FEM_BP_HISTORY_DEPTH (1)
+#define NBL_FEM_BP_HISTORY_WIDTH (32)
+#define NBL_FEM_BP_HISTORY_DWLEN (1)
+union fem_bp_history_u {
+	struct fem_bp_history {
+		u32 fem_pp0_bp:1;        /* [00:00] Default:0x0 RC */
+		u32 fem_pp1_bp:1;        /* [01:01] Default:0x0 RC */
+		u32 fem_pp2_bp:1;        /* [02:02] Default:0x0 RC */
+		u32 up_cmdq_bp:1;        /* [03:03] Default:0x0 RC */
+		u32 dn_acl_cmdq_bp:1;    /* [04:04] Default:0x0 RC */
+		u32 dn_age_msgq_bp:1;    /* [05:05] Default:0x0 RC */
+		u32 p0_ht0_cpu_acc_bp:1; /* [06:06] Default:0x0 RC */
+		u32 p1_ht0_cpu_acc_bp:1; /* [07:07] Default:0x0 RC */
+		u32 p2_ht0_cpu_acc_bp:1; /* [08:08] Default:0x0 RC */
+		u32 p0_ht1_cpu_acc_bp:1; /* [09:09] Default:0x0 RC */
+		u32 p1_ht1_cpu_acc_bp:1; /* [10:10] Default:0x0 RC */
+		u32 p2_ht1_cpu_acc_bp:1; /* [11:11] Default:0x0 RC */
+		u32 p0_kt_cpu_acc_bp:1;  /* [12:12] Default:0x0 RC */
+		u32 p1_kt_cpu_acc_bp:1;  /* [13:13] Default:0x0 RC */
+		u32 p2_kt_cpu_acc_bp:1;  /* [14:14] Default:0x0 RC */
+		u32 p0_at_cpu_acc_bp:1;  /* [15:15] Default:0x0 RC */
+		u32 p1_at_cpu_acc_bp:1;  /* [16:16] Default:0x0 RC */
+		u32 p2_at_cpu_acc_bp:1;  /* [17:17] Default:0x0 RC */
+		u32 p0_age_cpu_acc_bp:1; /* [18:18] Default:0x0 RC */
+		u32 p1_age_cpu_acc_bp:1; /* [19:19] Default:0x0 RC */
+		u32 p2_age_cpu_acc_bp:1; /* [20:20] Default:0x0 RC */
+		u32 rsv:11;              /* [31:21] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_BP_HISTORY_DWLEN];
+} __packed;
+
+#define NBL_FEM_EM0_LOCK_SEARCH_ADDR  (0xa04c00)
+#define NBL_FEM_EM0_LOCK_SEARCH_DEPTH (10)
+#define NBL_FEM_EM0_LOCK_SEARCH_WIDTH (32)
+#define NBL_FEM_EM0_LOCK_SEARCH_DWLEN (1)
+union fem_em0_lock_search_u {
+	struct fem_em0_lock_search {
+		u32 key:32;              /* [31:00] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM0_LOCK_SEARCH_DWLEN];
+} __packed;
+#define NBL_FEM_EM0_LOCK_SEARCH_REG(r) (NBL_FEM_EM0_LOCK_SEARCH_ADDR + \
+		(NBL_FEM_EM0_LOCK_SEARCH_DWLEN * 4) * (r))
+
+#define NBL_FEM_EM0_HT_VALUE_ADDR  (0xa04c28)
+#define NBL_FEM_EM0_HT_VALUE_DEPTH (1)
+#define NBL_FEM_EM0_HT_VALUE_WIDTH (32)
+#define NBL_FEM_EM0_HT_VALUE_DWLEN (1)
+union fem_em0_ht_value_u {
+	struct fem_em0_ht_value {
+		u32 ht0_value:16;        /* [15:00] Default:0x0 RO */
+		u32 ht1_value:16;        /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM0_HT_VALUE_DWLEN];
+} __packed;
+
+#define NBL_FEM_EM0_HT_INDEX_ADDR  (0xa04c2c)
+#define NBL_FEM_EM0_HT_INDEX_DEPTH (1)
+#define NBL_FEM_EM0_HT_INDEX_WIDTH (32)
+#define NBL_FEM_EM0_HT_INDEX_DWLEN (1)
+union fem_em0_ht_index_u {
+	struct fem_em0_ht_index {
+		u32 ht0_idx:14;          /* [13:00] Default:0x0 RO */
+		u32 rsv1:2;              /* [15:14] Default:0x0 RO */
+		u32 ht1_idx:14;          /* [29:16] Default:0x0 RO */
+		u32 rsv:2;               /* [31:30] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM0_HT_INDEX_DWLEN];
+} __packed;
+
+#define NBL_FEM_EM1_LOCK_SEARCH_ADDR  (0xa04c30)
+#define NBL_FEM_EM1_LOCK_SEARCH_DEPTH (10)
+#define NBL_FEM_EM1_LOCK_SEARCH_WIDTH (32)
+#define NBL_FEM_EM1_LOCK_SEARCH_DWLEN (1)
+union fem_em1_lock_search_u {
+	struct fem_em1_lock_search {
+		u32 key:32;              /* [31:00] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM1_LOCK_SEARCH_DWLEN];
+} __packed;
+#define NBL_FEM_EM1_LOCK_SEARCH_REG(r) (NBL_FEM_EM1_LOCK_SEARCH_ADDR + \
+		(NBL_FEM_EM1_LOCK_SEARCH_DWLEN * 4) * (r))
+
+#define NBL_FEM_EM1_HT_VALUE_ADDR  (0xa04c58)
+#define NBL_FEM_EM1_HT_VALUE_DEPTH (1)
+#define NBL_FEM_EM1_HT_VALUE_WIDTH (32)
+#define NBL_FEM_EM1_HT_VALUE_DWLEN (1)
+union fem_em1_ht_value_u {
+	struct fem_em1_ht_value {
+		u32 ht0_value:16;        /* [15:00] Default:0x0 RO */
+		u32 ht1_value:16;        /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM1_HT_VALUE_DWLEN];
+} __packed;
+
+#define NBL_FEM_EM1_HT_INDEX_ADDR  (0xa04c5c)
+#define NBL_FEM_EM1_HT_INDEX_DEPTH (1)
+#define NBL_FEM_EM1_HT_INDEX_WIDTH (32)
+#define NBL_FEM_EM1_HT_INDEX_DWLEN (1)
+union fem_em1_ht_index_u {
+	struct fem_em1_ht_index {
+		u32 ht0_idx:14;          /* [13:00] Default:0x0 RO */
+		u32 rsv1:2;              /* [15:14] Default:0x0 RO */
+		u32 ht1_idx:14;          /* [29:16] Default:0x0 RO */
+		u32 rsv:2;               /* [31:30] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM1_HT_INDEX_DWLEN];
+} __packed;
+
+#define NBL_FEM_EM2_LOCK_SEARCH_ADDR  (0xa04c60)
+#define NBL_FEM_EM2_LOCK_SEARCH_DEPTH (10)
+#define NBL_FEM_EM2_LOCK_SEARCH_WIDTH (32)
+#define NBL_FEM_EM2_LOCK_SEARCH_DWLEN (1)
+union fem_em2_lock_search_u {
+	struct fem_em2_lock_search {
+		u32 key:32;              /* [31:00] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM2_LOCK_SEARCH_DWLEN];
+} __packed;
+#define NBL_FEM_EM2_LOCK_SEARCH_REG(r) (NBL_FEM_EM2_LOCK_SEARCH_ADDR + \
+		(NBL_FEM_EM2_LOCK_SEARCH_DWLEN * 4) * (r))
+
+#define NBL_FEM_EM2_HT_VALUE_ADDR  (0xa04c88)
+#define NBL_FEM_EM2_HT_VALUE_DEPTH (1)
+#define NBL_FEM_EM2_HT_VALUE_WIDTH (32)
+#define NBL_FEM_EM2_HT_VALUE_DWLEN (1)
+union fem_em2_ht_value_u {
+	struct fem_em2_ht_value {
+		u32 ht0_value:16;        /* [15:00] Default:0x0 RO */
+		u32 ht1_value:16;        /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM2_HT_VALUE_DWLEN];
+} __packed;
+
+#define NBL_FEM_EM2_HT_INDEX_ADDR  (0xa04c8c)
+#define NBL_FEM_EM2_HT_INDEX_DEPTH (1)
+#define NBL_FEM_EM2_HT_INDEX_WIDTH (32)
+#define NBL_FEM_EM2_HT_INDEX_DWLEN (1)
+union fem_em2_ht_index_u {
+	struct fem_em2_ht_index {
+		u32 ht0_idx:14;          /* [13:00] Default:0x0 RO */
+		u32 rsv1:2;              /* [15:14] Default:0x0 RO */
+		u32 ht1_idx:14;          /* [29:16] Default:0x0 RO */
+		u32 rsv:2;               /* [31:30] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM2_HT_INDEX_DWLEN];
+} __packed;
+
+#define NBL_FEM_EM0_LOCK_MISS_ADDR  (0xa04c90)
+#define NBL_FEM_EM0_LOCK_MISS_DEPTH (10)
+#define NBL_FEM_EM0_LOCK_MISS_WIDTH (32)
+#define NBL_FEM_EM0_LOCK_MISS_DWLEN (1)
+union fem_em0_lock_miss_u {
+	struct fem_em0_lock_miss {
+		u32 key:32;              /* [31:00] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM0_LOCK_MISS_DWLEN];
+} __packed;
+#define NBL_FEM_EM0_LOCK_MISS_REG(r) (NBL_FEM_EM0_LOCK_MISS_ADDR + \
+		(NBL_FEM_EM0_LOCK_MISS_DWLEN * 4) * (r))
+
+#define NBL_FEM_EM1_LOCK_MISS_ADDR  (0xa04cb8)
+#define NBL_FEM_EM1_LOCK_MISS_DEPTH (10)
+#define NBL_FEM_EM1_LOCK_MISS_WIDTH (32)
+#define NBL_FEM_EM1_LOCK_MISS_DWLEN (1)
+union fem_em1_lock_miss_u {
+	struct fem_em1_lock_miss {
+		u32 key:32;              /* [31:00] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM1_LOCK_MISS_DWLEN];
+} __packed;
+#define NBL_FEM_EM1_LOCK_MISS_REG(r) (NBL_FEM_EM1_LOCK_MISS_ADDR + \
+		(NBL_FEM_EM1_LOCK_MISS_DWLEN * 4) * (r))
+
+#define NBL_FEM_EM2_LOCK_MISS_ADDR  (0xa04ce0)
+#define NBL_FEM_EM2_LOCK_MISS_DEPTH (10)
+#define NBL_FEM_EM2_LOCK_MISS_WIDTH (32)
+#define NBL_FEM_EM2_LOCK_MISS_DWLEN (1)
+union fem_em2_lock_miss_u {
+	struct fem_em2_lock_miss {
+		u32 key:32;              /* [31:00] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM2_LOCK_MISS_DWLEN];
+} __packed;
+#define NBL_FEM_EM2_LOCK_MISS_REG(r) (NBL_FEM_EM2_LOCK_MISS_ADDR + \
+		(NBL_FEM_EM2_LOCK_MISS_DWLEN * 4) * (r))
+
+#define NBL_FEM_EM0_PROFILE_TABLE_ADDR  (0xa05000)
+#define NBL_FEM_EM0_PROFILE_TABLE_DEPTH (16)
+#define NBL_FEM_EM0_PROFILE_TABLE_WIDTH (512)
+#define NBL_FEM_EM0_PROFILE_TABLE_DWLEN (16)
+union fem_em0_profile_table_u {
+	struct fem_em0_profile_table {
+		u32 cmd:1;               /* [0] Default:0x0 RW */
+		u32 key_size:1;          /* [1] Default:0x0 RW */
+		u32 mask_btm:16;         /* [81:2] Default:0x0 RW */
+		u32 mask_btm_arr[2];     /* [81:2] Default:0x0 RW */
+		u32 hash_sel0:2;         /* [83:82] Default:0x0 RW */
+		u32 hash_sel1:2;         /* [85:84] Default:0x0 RW */
+		u32 action0:22;          /* [107:86] Default:0x0 RW */
+		u32 action1:22;          /* [129:108] Default:0x0 RW */
+		u32 action2:22;          /* [151:130] Default:0x0 RW */
+		u32 action3:22;          /* [173:152] Default:0x0 RW */
+		u32 action4:22;          /* [195:174] Default:0x0 RW */
+		u32 action5:22;          /* [217:196] Default:0x0 RW */
+		u32 action6:22;          /* [239:218] Default:0x0 RW */
+		u32 action7:22;          /* [261:240] Default:0x0 RW */
+		u32 act_num:4;           /* [265:262] Default:0x0 RW */
+		u32 vld:1;               /* [266] Default:0x0 RW */
+		u32 rsv_l:32;            /* [511:267] Default:0x0 RO */
+		u32 rsv_h:21;            /* [511:267] Default:0x0 RO */
+		u32 rsv_arr[6];          /* [511:267] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM0_PROFILE_TABLE_DWLEN];
+} __packed;
+#define NBL_FEM_EM0_PROFILE_TABLE_REG(r) (NBL_FEM_EM0_PROFILE_TABLE_ADDR + \
+		(NBL_FEM_EM0_PROFILE_TABLE_DWLEN * 4) * (r))
+
+#define NBL_FEM_EM1_PROFILE_TABLE_ADDR  (0xa06000)
+#define NBL_FEM_EM1_PROFILE_TABLE_DEPTH (16)
+#define NBL_FEM_EM1_PROFILE_TABLE_WIDTH (512)
+#define NBL_FEM_EM1_PROFILE_TABLE_DWLEN (16)
+union fem_em1_profile_table_u {
+	struct fem_em1_profile_table {
+		u32 cmd:1;               /* [0] Default:0x0 RW */
+		u32 key_size:1;          /* [1] Default:0x0 RW */
+		u32 mask_btm:16;         /* [81:2] Default:0x0 RW */
+		u32 mask_btm_arr[2];     /* [81:2] Default:0x0 RW */
+		u32 hash_sel0:2;         /* [83:82] Default:0x0 RW */
+		u32 hash_sel1:2;         /* [85:84] Default:0x0 RW */
+		u32 action0:22;          /* [107:86] Default:0x0 RW */
+		u32 action1:22;          /* [129:108] Default:0x0 RW */
+		u32 action2:22;          /* [151:130] Default:0x0 RW */
+		u32 action3:22;          /* [173:152] Default:0x0 RW */
+		u32 action4:22;          /* [195:174] Default:0x0 RW */
+		u32 action5:22;          /* [217:196] Default:0x0 RW */
+		u32 action6:22;          /* [239:218] Default:0x0 RW */
+		u32 action7:22;          /* [261:240] Default:0x0 RW */
+		u32 act_num:4;           /* [265:262] Default:0x0 RW */
+		u32 vld:1;               /* [266] Default:0x0 RW */
+		u32 rsv_l:32;            /* [511:267] Default:0x0 RO */
+		u32 rsv_h:21;            /* [511:267] Default:0x0 RO */
+		u32 rsv_arr[6];          /* [511:267] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM1_PROFILE_TABLE_DWLEN];
+} __packed;
+#define NBL_FEM_EM1_PROFILE_TABLE_REG(r) (NBL_FEM_EM1_PROFILE_TABLE_ADDR + \
+		(NBL_FEM_EM1_PROFILE_TABLE_DWLEN * 4) * (r))
+
+#define NBL_FEM_EM2_PROFILE_TABLE_ADDR  (0xa07000)
+#define NBL_FEM_EM2_PROFILE_TABLE_DEPTH (16)
+#define NBL_FEM_EM2_PROFILE_TABLE_WIDTH (512)
+#define NBL_FEM_EM2_PROFILE_TABLE_DWLEN (16)
+union fem_em2_profile_table_u {
+	struct fem_em2_profile_table {
+		u32 cmd:1;               /* [0] Default:0x0 RW */
+		u32 key_size:1;          /* [1] Default:0x0 RW */
+		u32 mask_btm:16;         /* [81:2] Default:0x0 RW */
+		u32 mask_btm_arr[2];     /* [81:2] Default:0x0 RW */
+		u32 hash_sel0:2;         /* [83:82] Default:0x0 RW */
+		u32 hash_sel1:2;         /* [85:84] Default:0x0 RW */
+		u32 action0:22;          /* [107:86] Default:0x0 RW */
+		u32 action1:22;          /* [129:108] Default:0x0 RW */
+		u32 action2:22;          /* [151:130] Default:0x0 RW */
+		u32 action3:22;          /* [173:152] Default:0x0 RW */
+		u32 action4:22;          /* [195:174] Default:0x0 RW */
+		u32 action5:22;          /* [217:196] Default:0x0 RW */
+		u32 action6:22;          /* [239:218] Default:0x0 RW */
+		u32 action7:22;          /* [261:240] Default:0x0 RW */
+		u32 act_num:4;           /* [265:262] Default:0x0 RW */
+		u32 vld:1;               /* [266] Default:0x0 RW */
+		u32 rsv_l:32;            /* [511:267] Default:0x0 RO */
+		u32 rsv_h:21;            /* [511:267] Default:0x0 RO */
+		u32 rsv_arr[6];          /* [511:267] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM2_PROFILE_TABLE_DWLEN];
+} __packed;
+#define NBL_FEM_EM2_PROFILE_TABLE_REG(r) (NBL_FEM_EM2_PROFILE_TABLE_ADDR + \
+		(NBL_FEM_EM2_PROFILE_TABLE_DWLEN * 4) * (r))
+
+#define NBL_FEM_EM0_AD_TABLE_ADDR  (0xa08000)
+#define NBL_FEM_EM0_AD_TABLE_DEPTH (64)
+#define NBL_FEM_EM0_AD_TABLE_WIDTH (512)
+#define NBL_FEM_EM0_AD_TABLE_DWLEN (16)
+union fem_em0_ad_table_u {
+	struct fem_em0_ad_table {
+		u32 action0:22;          /* [21:0] Default:0x0 RW */
+		u32 action1:22;          /* [43:22] Default:0x0 RW */
+		u32 action2:22;          /* [65:44] Default:0x0 RW */
+		u32 action3:22;          /* [87:66] Default:0x0 RW */
+		u32 action4:22;          /* [109:88] Default:0x0 RW */
+		u32 action5:22;          /* [131:110] Default:0x0 RW */
+		u32 action6:22;          /* [153:132] Default:0x0 RW */
+		u32 action7:22;          /* [175:154] Default:0x0 RW */
+		u32 action8:22;          /* [197:176] Default:0x0 RW */
+		u32 action9:22;          /* [219:198] Default:0x0 RW */
+		u32 action10:22;         /* [241:220] Default:0x0 RW */
+		u32 action11:22;         /* [263:242] Default:0x0 RW */
+		u32 action12:22;         /* [285:264] Default:0x0 RW */
+		u32 action13:22;         /* [307:286] Default:0x0 RW */
+		u32 action14:22;         /* [329:308] Default:0x0 RW */
+		u32 action15:22;         /* [351:330] Default:0x0 RW */
+		u32 rsv:32;              /* [511:352] Default:0x0 RO */
+		u32 rsv_arr[4];          /* [511:352] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM0_AD_TABLE_DWLEN];
+} __packed;
+#define NBL_FEM_EM0_AD_TABLE_REG(r) (NBL_FEM_EM0_AD_TABLE_ADDR + \
+		(NBL_FEM_EM0_AD_TABLE_DWLEN * 4) * (r))
+
+#define NBL_FEM_EM1_AD_TABLE_ADDR  (0xa09000)
+#define NBL_FEM_EM1_AD_TABLE_DEPTH (64)
+#define NBL_FEM_EM1_AD_TABLE_WIDTH (512)
+#define NBL_FEM_EM1_AD_TABLE_DWLEN (16)
+union fem_em1_ad_table_u {
+	struct fem_em1_ad_table {
+		u32 action0:22;          /* [21:0] Default:0x0 RW */
+		u32 action1:22;          /* [43:22] Default:0x0 RW */
+		u32 action2:22;          /* [65:44] Default:0x0 RW */
+		u32 action3:22;          /* [87:66] Default:0x0 RW */
+		u32 action4:22;          /* [109:88] Default:0x0 RW */
+		u32 action5:22;          /* [131:110] Default:0x0 RW */
+		u32 action6:22;          /* [153:132] Default:0x0 RW */
+		u32 action7:22;          /* [175:154] Default:0x0 RW */
+		u32 action8:22;          /* [197:176] Default:0x0 RW */
+		u32 action9:22;          /* [219:198] Default:0x0 RW */
+		u32 action10:22;         /* [241:220] Default:0x0 RW */
+		u32 action11:22;         /* [263:242] Default:0x0 RW */
+		u32 action12:22;         /* [285:264] Default:0x0 RW */
+		u32 action13:22;         /* [307:286] Default:0x0 RW */
+		u32 action14:22;         /* [329:308] Default:0x0 RW */
+		u32 action15:22;         /* [351:330] Default:0x0 RW */
+		u32 rsv:32;              /* [511:352] Default:0x0 RO */
+		u32 rsv_arr[4];          /* [511:352] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM1_AD_TABLE_DWLEN];
+} __packed;
+#define NBL_FEM_EM1_AD_TABLE_REG(r) (NBL_FEM_EM1_AD_TABLE_ADDR + \
+		(NBL_FEM_EM1_AD_TABLE_DWLEN * 4) * (r))
+
+#define NBL_FEM_EM2_AD_TABLE_ADDR  (0xa0a000)
+#define NBL_FEM_EM2_AD_TABLE_DEPTH (64)
+#define NBL_FEM_EM2_AD_TABLE_WIDTH (512)
+#define NBL_FEM_EM2_AD_TABLE_DWLEN (16)
+union fem_em2_ad_table_u {
+	struct fem_em2_ad_table {
+		u32 action0:22;          /* [21:0] Default:0x0 RW */
+		u32 action1:22;          /* [43:22] Default:0x0 RW */
+		u32 action2:22;          /* [65:44] Default:0x0 RW */
+		u32 action3:22;          /* [87:66] Default:0x0 RW */
+		u32 action4:22;          /* [109:88] Default:0x0 RW */
+		u32 action5:22;          /* [131:110] Default:0x0 RW */
+		u32 action6:22;          /* [153:132] Default:0x0 RW */
+		u32 action7:22;          /* [175:154] Default:0x0 RW */
+		u32 action8:22;          /* [197:176] Default:0x0 RW */
+		u32 action9:22;          /* [219:198] Default:0x0 RW */
+		u32 action10:22;         /* [241:220] Default:0x0 RW */
+		u32 action11:22;         /* [263:242] Default:0x0 RW */
+		u32 action12:22;         /* [285:264] Default:0x0 RW */
+		u32 action13:22;         /* [307:286] Default:0x0 RW */
+		u32 action14:22;         /* [329:308] Default:0x0 RW */
+		u32 action15:22;         /* [351:330] Default:0x0 RW */
+		u32 rsv:32;              /* [511:352] Default:0x0 RO */
+		u32 rsv_arr[4];          /* [511:352] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM2_AD_TABLE_DWLEN];
+} __packed;
+#define NBL_FEM_EM2_AD_TABLE_REG(r) (NBL_FEM_EM2_AD_TABLE_ADDR + \
+		(NBL_FEM_EM2_AD_TABLE_DWLEN * 4) * (r))
+
+#define NBL_FEM_EM0_TCAM_TABLE_ADDR  (0xa0b000)
+#define NBL_FEM_EM0_TCAM_TABLE_DEPTH (64)
+#define NBL_FEM_EM0_TCAM_TABLE_WIDTH (256)
+#define NBL_FEM_EM0_TCAM_TABLE_DWLEN (8)
+union fem_em0_tcam_table_u {
+	struct fem_em0_tcam_table {
+		u32 key:32;              /* [159:0] Default:0x0 RW */
+		u32 key_arr[4];          /* [159:0] Default:0x0 RW */
+		u32 key_vld:1;           /* [160] Default:0x0 RW */
+		u32 key_size:1;          /* [161] Default:0x0 RW */
+		u32 rsv:30;              /* [255:162] Default:0x0 RO */
+		u32 rsv_arr[2];          /* [255:162] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM0_TCAM_TABLE_DWLEN];
+} __packed;
+#define NBL_FEM_EM0_TCAM_TABLE_REG(r) (NBL_FEM_EM0_TCAM_TABLE_ADDR + \
+		(NBL_FEM_EM0_TCAM_TABLE_DWLEN * 4) * (r))
+
+#define NBL_FEM_EM1_TCAM_TABLE_ADDR  (0xa0c000)
+#define NBL_FEM_EM1_TCAM_TABLE_DEPTH (64)
+#define NBL_FEM_EM1_TCAM_TABLE_WIDTH (256)
+#define NBL_FEM_EM1_TCAM_TABLE_DWLEN (8)
+union fem_em1_tcam_table_u {
+	struct fem_em1_tcam_table {
+		u32 key:32;              /* [159:0] Default:0x0 RW */
+		u32 key_arr[4];          /* [159:0] Default:0x0 RW */
+		u32 key_vld:1;           /* [160] Default:0x0 RW */
+		u32 key_size:1;          /* [161] Default:0x0 RW */
+		u32 rsv:30;              /* [255:162] Default:0x0 RO */
+		u32 rsv_arr[2];          /* [255:162] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM1_TCAM_TABLE_DWLEN];
+} __packed;
+#define NBL_FEM_EM1_TCAM_TABLE_REG(r) (NBL_FEM_EM1_TCAM_TABLE_ADDR + \
+		(NBL_FEM_EM1_TCAM_TABLE_DWLEN * 4) * (r))
+
+#define NBL_FEM_EM2_TCAM_TABLE_ADDR  (0xa0d000)
+#define NBL_FEM_EM2_TCAM_TABLE_DEPTH (64)
+#define NBL_FEM_EM2_TCAM_TABLE_WIDTH (256)
+#define NBL_FEM_EM2_TCAM_TABLE_DWLEN (8)
+union fem_em2_tcam_table_u {
+	struct fem_em2_tcam_table {
+		u32 key:32;              /* [159:0] Default:0x0 RW */
+		u32 key_arr[4];          /* [159:0] Default:0x0 RW */
+		u32 key_vld:1;           /* [160] Default:0x0 RW */
+		u32 key_size:1;          /* [161] Default:0x0 RW */
+		u32 rsv:30;              /* [255:162] Default:0x0 RO */
+		u32 rsv_arr[2];          /* [255:162] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_FEM_EM2_TCAM_TABLE_DWLEN];
+} __packed;
+#define NBL_FEM_EM2_TCAM_TABLE_REG(r) (NBL_FEM_EM2_TCAM_TABLE_ADDR + \
+		(NBL_FEM_EM2_TCAM_TABLE_DWLEN * 4) * (r))
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_ipro.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_ipro.h
new file mode 100644
index 000000000000..5f74a458a09a
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_ipro.h
@@ -0,0 +1,1397 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+// Code generated by interstellar. DO NOT EDIT.
+// Compatible with leonis RTL tag 0710
+
+#ifndef NBL_IPRO_H
+#define NBL_IPRO_H 1
+
+#include <linux/types.h>
+
+#define NBL_IPRO_BASE (0x00B04000)
+
+#define NBL_IPRO_INT_STATUS_ADDR  (0xb04000)
+#define NBL_IPRO_INT_STATUS_DEPTH (1)
+#define NBL_IPRO_INT_STATUS_WIDTH (32)
+#define NBL_IPRO_INT_STATUS_DWLEN (1)
+union ipro_int_status_u {
+	struct ipro_int_status {
+		u32 fatal_err:1;         /* [0] Default:0x0 RWC */
+		u32 fifo_uflw_err:1;     /* [1] Default:0x0 RWC */
+		u32 fifo_dflw_err:1;     /* [2] Default:0x0 RWC */
+		u32 cif_err:1;           /* [3] Default:0x0 RWC */
+		u32 input_err:1;         /* [4] Default:0x0 RWC */
+		u32 cfg_err:1;           /* [5] Default:0x0 RWC */
+		u32 data_ucor_err:1;     /* [6] Default:0x0 RWC */
+		u32 rsv:25;              /* [31:7] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_INT_STATUS_DWLEN];
+} __packed;
+
+#define NBL_IPRO_INT_MASK_ADDR  (0xb04004)
+#define NBL_IPRO_INT_MASK_DEPTH (1)
+#define NBL_IPRO_INT_MASK_WIDTH (32)
+#define NBL_IPRO_INT_MASK_DWLEN (1)
+union ipro_int_mask_u {
+	struct ipro_int_mask {
+		u32 fatal_err:1;         /* [0] Default:0x0 RW */
+		u32 fifo_uflw_err:1;     /* [1] Default:0x0 RW */
+		u32 fifo_dflw_err:1;     /* [2] Default:0x0 RW */
+		u32 cif_err:1;           /* [3] Default:0x0 RW */
+		u32 input_err:1;         /* [4] Default:0x0 RW */
+		u32 cfg_err:1;           /* [5] Default:0x0 RW */
+		u32 data_ucor_err:1;     /* [6] Default:0x0 RW */
+		u32 rsv:25;              /* [31:7] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_INT_MASK_DWLEN];
+} __packed;
+
+#define NBL_IPRO_INT_SET_ADDR  (0xb04008)
+#define NBL_IPRO_INT_SET_DEPTH (1)
+#define NBL_IPRO_INT_SET_WIDTH (32)
+#define NBL_IPRO_INT_SET_DWLEN (1)
+union ipro_int_set_u {
+	struct ipro_int_set {
+		u32 fatal_err:1;         /* [0] Default:0x0 WO */
+		u32 fifo_uflw_err:1;     /* [1] Default:0x0 WO */
+		u32 fifo_dflw_err:1;     /* [2] Default:0x0 WO */
+		u32 cif_err:1;           /* [3] Default:0x0 WO */
+		u32 input_err:1;         /* [4] Default:0x0 WO */
+		u32 cfg_err:1;           /* [5] Default:0x0 WO */
+		u32 data_ucor_err:1;     /* [6] Default:0x0 WO */
+		u32 rsv:25;              /* [31:7] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_INT_SET_DWLEN];
+} __packed;
+
+#define NBL_IPRO_INIT_DONE_ADDR  (0xb0400c)
+#define NBL_IPRO_INIT_DONE_DEPTH (1)
+#define NBL_IPRO_INIT_DONE_WIDTH (32)
+#define NBL_IPRO_INIT_DONE_DWLEN (1)
+union ipro_init_done_u {
+	struct ipro_init_done {
+		u32 done:1;              /* [0] Default:0x0 RO */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_INIT_DONE_DWLEN];
+} __packed;
+
+#define NBL_IPRO_CIF_ERR_INFO_ADDR  (0xb04040)
+#define NBL_IPRO_CIF_ERR_INFO_DEPTH (1)
+#define NBL_IPRO_CIF_ERR_INFO_WIDTH (32)
+#define NBL_IPRO_CIF_ERR_INFO_DWLEN (1)
+union ipro_cif_err_info_u {
+	struct ipro_cif_err_info {
+		u32 addr:30;             /* [29:0] Default:0x0 RO */
+		u32 wr_err:1;            /* [30] Default:0x0 RO */
+		u32 ucor_err:1;          /* [31] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_CIF_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_IPRO_INPUT_ERR_INFO_ADDR  (0xb04048)
+#define NBL_IPRO_INPUT_ERR_INFO_DEPTH (1)
+#define NBL_IPRO_INPUT_ERR_INFO_WIDTH (32)
+#define NBL_IPRO_INPUT_ERR_INFO_DWLEN (1)
+union ipro_input_err_info_u {
+	struct ipro_input_err_info {
+		u32 id:2;                /* [1:0] Default:0x0 RO */
+		u32 rsv:30;              /* [31:2] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_INPUT_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_IPRO_CFG_ERR_INFO_ADDR  (0xb04050)
+#define NBL_IPRO_CFG_ERR_INFO_DEPTH (1)
+#define NBL_IPRO_CFG_ERR_INFO_WIDTH (32)
+#define NBL_IPRO_CFG_ERR_INFO_DWLEN (1)
+union ipro_cfg_err_info_u {
+	struct ipro_cfg_err_info {
+		u32 id:2;                /* [1:0] Default:0x0 RO */
+		u32 rsv:30;              /* [31:2] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_CFG_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_IPRO_CAR_CTRL_ADDR  (0xb04100)
+#define NBL_IPRO_CAR_CTRL_DEPTH (1)
+#define NBL_IPRO_CAR_CTRL_WIDTH (32)
+#define NBL_IPRO_CAR_CTRL_DWLEN (1)
+union ipro_car_ctrl_u {
+	struct ipro_car_ctrl {
+		u32 sctr_car:1;          /* [0] Default:0x1 RW */
+		u32 rctr_car:1;          /* [1] Default:0x1 RW */
+		u32 rc_car:1;            /* [2] Default:0x1 RW */
+		u32 tbl_rc_car:1;        /* [3] Default:0x1 RW */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_CAR_CTRL_DWLEN];
+} __packed;
+
+#define NBL_IPRO_INIT_START_ADDR  (0xb04180)
+#define NBL_IPRO_INIT_START_DEPTH (1)
+#define NBL_IPRO_INIT_START_WIDTH (32)
+#define NBL_IPRO_INIT_START_DWLEN (1)
+union ipro_init_start_u {
+	struct ipro_init_start {
+		u32 init_start:1;        /* [0] Default:0x0 WO */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_INIT_START_DWLEN];
+} __packed;
+
+#define NBL_IPRO_CREDIT_TOKEN_ADDR  (0xb041c0)
+#define NBL_IPRO_CREDIT_TOKEN_DEPTH (1)
+#define NBL_IPRO_CREDIT_TOKEN_WIDTH (32)
+#define NBL_IPRO_CREDIT_TOKEN_DWLEN (1)
+union ipro_credit_token_u {
+	struct ipro_credit_token {
+		u32 up_token_num:8;      /* [7:0] Default:0x80 RW */
+		u32 down_token_num:8;    /* [15:8] Default:0x80 RW */
+		u32 up_init_vld:1;       /* [16] Default:0x0 WO */
+		u32 down_init_vld:1;     /* [17] Default:0x0 WO */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_CREDIT_TOKEN_DWLEN];
+} __packed;
+
+#define NBL_IPRO_AM_SET_FLAG_ADDR  (0xb041e0)
+#define NBL_IPRO_AM_SET_FLAG_DEPTH (1)
+#define NBL_IPRO_AM_SET_FLAG_WIDTH (32)
+#define NBL_IPRO_AM_SET_FLAG_DWLEN (1)
+union ipro_am_set_flag_u {
+	struct ipro_am_set_flag {
+		u32 set_flag:32;         /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_AM_SET_FLAG_DWLEN];
+} __packed;
+
+#define NBL_IPRO_AM_CLEAR_FLAG_ADDR  (0xb041e4)
+#define NBL_IPRO_AM_CLEAR_FLAG_DEPTH (1)
+#define NBL_IPRO_AM_CLEAR_FLAG_WIDTH (32)
+#define NBL_IPRO_AM_CLEAR_FLAG_DWLEN (1)
+union ipro_am_clear_flag_u {
+	struct ipro_am_clear_flag {
+		u32 clear_flag:32;       /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_AM_CLEAR_FLAG_DWLEN];
+} __packed;
+
+#define NBL_IPRO_FLAG_OFFSET_0_ADDR  (0xb04200)
+#define NBL_IPRO_FLAG_OFFSET_0_DEPTH (1)
+#define NBL_IPRO_FLAG_OFFSET_0_WIDTH (32)
+#define NBL_IPRO_FLAG_OFFSET_0_DWLEN (1)
+union ipro_flag_offset_0_u {
+	struct ipro_flag_offset_0 {
+		u32 dir_offset_en:1;     /* [0] Default:0x1 RW */
+		u32 dir_offset:5;        /* [5:1] Default:0x00 RW */
+		u32 rsv1:2;              /* [7:6] Default:0x0 RO */
+		u32 hw_flow_offset_en:1; /* [8] Default:0x1 RW */
+		u32 hw_flow_offset:5;   /* [13:9] Default:0xb RW */
+		u32 rsv:18;              /* [31:14] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_FLAG_OFFSET_0_DWLEN];
+} __packed;
+
+#define NBL_IPRO_DROP_NXT_STAGE_ADDR  (0xb04210)
+#define NBL_IPRO_DROP_NXT_STAGE_DEPTH (1)
+#define NBL_IPRO_DROP_NXT_STAGE_WIDTH (32)
+#define NBL_IPRO_DROP_NXT_STAGE_DWLEN (1)
+union ipro_drop_nxt_stage_u {
+	struct ipro_drop_nxt_stage {
+		u32 stage:4;             /* [3:0] Default:0xf RW */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_DROP_NXT_STAGE_DWLEN];
+} __packed;
+
+#define NBL_IPRO_FWD_ACTION_PRI_ADDR  (0xb04220)
+#define NBL_IPRO_FWD_ACTION_PRI_DEPTH (1)
+#define NBL_IPRO_FWD_ACTION_PRI_WIDTH (32)
+#define NBL_IPRO_FWD_ACTION_PRI_DWLEN (1)
+union ipro_fwd_action_pri_u {
+	struct ipro_fwd_action_pri {
+		u32 dqueue:2;            /* [1:0] Default:0x0 RW */
+		u32 set_dport:2;         /* [3:2] Default:0x0 RW */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_FWD_ACTION_PRI_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MTU_CHECK_CTRL_ADDR  (0xb0427c)
+#define NBL_IPRO_MTU_CHECK_CTRL_DEPTH (1)
+#define NBL_IPRO_MTU_CHECK_CTRL_WIDTH (32)
+#define NBL_IPRO_MTU_CHECK_CTRL_DWLEN (1)
+union ipro_mtu_check_ctrl_u {
+	struct ipro_mtu_check_ctrl {
+		u32 set_dport:16;        /* [15:0] Default:0xFFFF RW */
+		u32 set_dport_pri:2;     /* [17:16] Default:0x3 RW */
+		u32 proc_done:1;         /* [18] Default:0x1 RW */
+		u32 rsv:13;              /* [31:19] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MTU_CHECK_CTRL_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MTU_SEL_ADDR  (0xb04280)
+#define NBL_IPRO_MTU_SEL_DEPTH (8)
+#define NBL_IPRO_MTU_SEL_WIDTH (32)
+#define NBL_IPRO_MTU_SEL_DWLEN (1)
+union ipro_mtu_sel_u {
+	struct ipro_mtu_sel {
+		u32 mtu_1:16;            /* [15:0] Default:0x0 RW */
+		u32 mtu_0:16;            /* [31:16] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_MTU_SEL_DWLEN];
+} __packed;
+#define NBL_IPRO_MTU_SEL_REG(r) (NBL_IPRO_MTU_SEL_ADDR + \
+		(NBL_IPRO_MTU_SEL_DWLEN * 4) * (r))
+
+#define NBL_IPRO_UDL_PKT_FLT_DMAC_ADDR  (0xb04300)
+#define NBL_IPRO_UDL_PKT_FLT_DMAC_DEPTH (16)
+#define NBL_IPRO_UDL_PKT_FLT_DMAC_WIDTH (64)
+#define NBL_IPRO_UDL_PKT_FLT_DMAC_DWLEN (2)
+union ipro_udl_pkt_flt_dmac_u {
+	struct ipro_udl_pkt_flt_dmac {
+		u32 dmac_l:32;           /* [47:0] Default:0x0 RW */
+		u32 dmac_h:16;           /* [47:0] Default:0x0 RW */
+		u32 rsv:16;              /* [63:48] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_UDL_PKT_FLT_DMAC_DWLEN];
+} __packed;
+#define NBL_IPRO_UDL_PKT_FLT_DMAC_REG(r) (NBL_IPRO_UDL_PKT_FLT_DMAC_ADDR + \
+		(NBL_IPRO_UDL_PKT_FLT_DMAC_DWLEN * 4) * (r))
+
+#define NBL_IPRO_UDL_PKT_FLT_VLAN_ADDR  (0xb04380)
+#define NBL_IPRO_UDL_PKT_FLT_VLAN_DEPTH (16)
+#define NBL_IPRO_UDL_PKT_FLT_VLAN_WIDTH (32)
+#define NBL_IPRO_UDL_PKT_FLT_VLAN_DWLEN (1)
+union ipro_udl_pkt_flt_vlan_u {
+	struct ipro_udl_pkt_flt_vlan {
+		u32 vlan_0:12;           /* [11:0] Default:0x0 RW */
+		u32 vlan_1:12;           /* [23:12] Default:0x0 RW */
+		u32 vlan_layer:2;        /* [25:24] Default:0x0 RW */
+		u32 rsv:6;               /* [31:26] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_UDL_PKT_FLT_VLAN_DWLEN];
+} __packed;
+#define NBL_IPRO_UDL_PKT_FLT_VLAN_REG(r) (NBL_IPRO_UDL_PKT_FLT_VLAN_ADDR + \
+		(NBL_IPRO_UDL_PKT_FLT_VLAN_DWLEN * 4) * (r))
+
+#define NBL_IPRO_UDL_PKT_FLT_CTRL_ADDR  (0xb043c0)
+#define NBL_IPRO_UDL_PKT_FLT_CTRL_DEPTH (1)
+#define NBL_IPRO_UDL_PKT_FLT_CTRL_WIDTH (32)
+#define NBL_IPRO_UDL_PKT_FLT_CTRL_DWLEN (1)
+union ipro_udl_pkt_flt_ctrl_u {
+	struct ipro_udl_pkt_flt_ctrl {
+		u32 vld:16;              /* [15:0] Default:0x0 RW */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_UDL_PKT_FLT_CTRL_DWLEN];
+} __packed;
+
+#define NBL_IPRO_UDL_PKT_FLT_ACTION_ADDR  (0xb043c4)
+#define NBL_IPRO_UDL_PKT_FLT_ACTION_DEPTH (1)
+#define NBL_IPRO_UDL_PKT_FLT_ACTION_WIDTH (32)
+#define NBL_IPRO_UDL_PKT_FLT_ACTION_DWLEN (1)
+union ipro_udl_pkt_flt_action_u {
+	struct ipro_udl_pkt_flt_action {
+		u32 dqueue:11;           /* [10:0] Default:0x0 RW */
+		u32 dqueue_en:1;         /* [11] Default:0x0 RW */
+		u32 rsv:2;               /* [13:12] Default:0x0 RO */
+		u32 proc_done:1;         /* [14] Default:0x0 RW */
+		u32 set_dport_en:1;      /* [15] Default:0x0 RW */
+		u32 set_dport:16;        /* [31:16] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_UDL_PKT_FLT_ACTION_DWLEN];
+} __packed;
+
+#define NBL_IPRO_ANTI_FAKE_ADDR_ERRCODE_ADDR  (0xb043e0)
+#define NBL_IPRO_ANTI_FAKE_ADDR_ERRCODE_DEPTH (1)
+#define NBL_IPRO_ANTI_FAKE_ADDR_ERRCODE_WIDTH (32)
+#define NBL_IPRO_ANTI_FAKE_ADDR_ERRCODE_DWLEN (1)
+union ipro_anti_fake_addr_errcode_u {
+	struct ipro_anti_fake_addr_errcode {
+		u32 num:4;               /* [3:0] Default:0xA RW */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_ANTI_FAKE_ADDR_ERRCODE_DWLEN];
+} __packed;
+
+#define NBL_IPRO_ANTI_FAKE_ADDR_ACTION_ADDR  (0xb043e4)
+#define NBL_IPRO_ANTI_FAKE_ADDR_ACTION_DEPTH (1)
+#define NBL_IPRO_ANTI_FAKE_ADDR_ACTION_WIDTH (32)
+#define NBL_IPRO_ANTI_FAKE_ADDR_ACTION_DWLEN (1)
+union ipro_anti_fake_addr_action_u {
+	struct ipro_anti_fake_addr_action {
+		u32 dqueue:11;           /* [10:0] Default:0x0 RW */
+		u32 dqueue_en:1;         /* [11] Default:0x0 RW */
+		u32 rsv:2;               /* [13:12] Default:0x0 RO */
+		u32 proc_done:1;         /* [14] Default:0x1 RW */
+		u32 set_dport_en:1;      /* [15] Default:0x1 RW */
+		u32 set_dport:16;        /* [31:16] Default:0xFFFF RW */
+	} __packed info;
+	u32 data[NBL_IPRO_ANTI_FAKE_ADDR_ACTION_DWLEN];
+} __packed;
+
+#define NBL_IPRO_VLAN_NUM_CHK_ERRCODE_ADDR  (0xb043f0)
+#define NBL_IPRO_VLAN_NUM_CHK_ERRCODE_DEPTH (1)
+#define NBL_IPRO_VLAN_NUM_CHK_ERRCODE_WIDTH (32)
+#define NBL_IPRO_VLAN_NUM_CHK_ERRCODE_DWLEN (1)
+union ipro_vlan_num_chk_errcode_u {
+	struct ipro_vlan_num_chk_errcode {
+		u32 num:4;               /* [3:0] Default:0x1 RW */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_VLAN_NUM_CHK_ERRCODE_DWLEN];
+} __packed;
+
+#define NBL_IPRO_VLAN_NUM_CHK_ACTION_ADDR  (0xb043f4)
+#define NBL_IPRO_VLAN_NUM_CHK_ACTION_DEPTH (1)
+#define NBL_IPRO_VLAN_NUM_CHK_ACTION_WIDTH (32)
+#define NBL_IPRO_VLAN_NUM_CHK_ACTION_DWLEN (1)
+union ipro_vlan_num_chk_action_u {
+	struct ipro_vlan_num_chk_action {
+		u32 dqueue:11;           /* [10:0] Default:0x0 RW */
+		u32 dqueue_en:1;         /* [11] Default:0x0 RW */
+		u32 rsv:2;               /* [13:12] Default:0x0 RO */
+		u32 proc_done:1;         /* [14] Default:0x1 RW */
+		u32 set_dport_en:1;      /* [15] Default:0x1 RW */
+		u32 set_dport:16;        /* [31:16] Default:0xFFFF RW */
+	} __packed info;
+	u32 data[NBL_IPRO_VLAN_NUM_CHK_ACTION_DWLEN];
+} __packed;
+
+#define NBL_IPRO_TCP_STATE_PROBE_ADDR  (0xb04400)
+#define NBL_IPRO_TCP_STATE_PROBE_DEPTH (1)
+#define NBL_IPRO_TCP_STATE_PROBE_WIDTH (32)
+#define NBL_IPRO_TCP_STATE_PROBE_DWLEN (1)
+union ipro_tcp_state_probe_u {
+	struct ipro_tcp_state_probe {
+		u32 up_chk_en:1;         /* [0] Default:0x0 RW */
+		u32 dn_chk_en:1;         /* [1] Default:0x0 RW */
+		u32 rsv:14;              /* [15:2] Default:0x0 RO */
+		u32 up_bitmap:8;         /* [23:16] Default:0x0 RW */
+		u32 dn_bitmap:8;         /* [31:24] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_TCP_STATE_PROBE_DWLEN];
+} __packed;
+
+#define NBL_IPRO_TCP_STATE_UP_ACTION_ADDR  (0xb04404)
+#define NBL_IPRO_TCP_STATE_UP_ACTION_DEPTH (1)
+#define NBL_IPRO_TCP_STATE_UP_ACTION_WIDTH (32)
+#define NBL_IPRO_TCP_STATE_UP_ACTION_DWLEN (1)
+union ipro_tcp_state_up_action_u {
+	struct ipro_tcp_state_up_action {
+		u32 dqueue:11;           /* [10:0] Default:0x0 RW */
+		u32 dqueue_en:1;         /* [11] Default:0x0 RW */
+		u32 rsv:2;               /* [13:12] Default:0x0 RO */
+		u32 proc_done:1;         /* [14] Default:0x0 RW */
+		u32 set_dport_en:1;      /* [15] Default:0x0 RW */
+		u32 set_dport:16;        /* [31:16] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_TCP_STATE_UP_ACTION_DWLEN];
+} __packed;
+
+#define NBL_IPRO_TCP_STATE_DN_ACTION_ADDR  (0xb04408)
+#define NBL_IPRO_TCP_STATE_DN_ACTION_DEPTH (1)
+#define NBL_IPRO_TCP_STATE_DN_ACTION_WIDTH (32)
+#define NBL_IPRO_TCP_STATE_DN_ACTION_DWLEN (1)
+union ipro_tcp_state_dn_action_u {
+	struct ipro_tcp_state_dn_action {
+		u32 dqueue:11;           /* [10:0] Default:0x0 RW */
+		u32 dqueue_en:1;         /* [11] Default:0x0 RW */
+		u32 rsv:2;               /* [13:12] Default:0x0 RO */
+		u32 proc_done:1;         /* [14] Default:0x0 RW */
+		u32 set_dport_en:1;      /* [15] Default:0x0 RW */
+		u32 set_dport:16;        /* [31:16] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_TCP_STATE_DN_ACTION_DWLEN];
+} __packed;
+
+#define NBL_IPRO_FWD_ACTION_ID_ADDR  (0xb04440)
+#define NBL_IPRO_FWD_ACTION_ID_DEPTH (1)
+#define NBL_IPRO_FWD_ACTION_ID_WIDTH (32)
+#define NBL_IPRO_FWD_ACTION_ID_DWLEN (1)
+union ipro_fwd_action_id_u {
+	struct ipro_fwd_action_id {
+		u32 mirror_index:6;      /* [5:0] Default:0x8 RW */
+		u32 dport:6;             /* [11:6] Default:0x9 RW */
+		u32 dqueue:6;            /* [17:12] Default:0xA RW */
+		u32 car:6;               /* [23:18] Default:0x5 RW */
+		u32 rsv:8;               /* [31:24] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_FWD_ACTION_ID_DWLEN];
+} __packed;
+
+#define NBL_IPRO_PED_ACTION_ID_ADDR  (0xb04448)
+#define NBL_IPRO_PED_ACTION_ID_DEPTH (1)
+#define NBL_IPRO_PED_ACTION_ID_WIDTH (32)
+#define NBL_IPRO_PED_ACTION_ID_DWLEN (1)
+union ipro_ped_action_id_u {
+	struct ipro_ped_action_id {
+		u32 encap:6;             /* [5:0] Default:0x2E RW */
+		u32 decap:6;             /* [11:6] Default:0x2F RW */
+		u32 rsv:20;              /* [31:12] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_PED_ACTION_ID_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MNG_HIT_ACTION_ADDR  (0xb04510)
+#define NBL_IPRO_MNG_HIT_ACTION_DEPTH (8)
+#define NBL_IPRO_MNG_HIT_ACTION_WIDTH (32)
+#define NBL_IPRO_MNG_HIT_ACTION_DWLEN (1)
+union ipro_mng_hit_action_u {
+	struct ipro_mng_hit_action {
+		u32 data:24;             /* [23:0] Default:0x0 RW */
+		u32 rsv:8;               /* [31:24] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_HIT_ACTION_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_HIT_ACTION_REG(r) (NBL_IPRO_MNG_HIT_ACTION_ADDR + \
+		(NBL_IPRO_MNG_HIT_ACTION_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_DECISION_FLT_0_ADDR  (0xb04530)
+#define NBL_IPRO_MNG_DECISION_FLT_0_DEPTH (4)
+#define NBL_IPRO_MNG_DECISION_FLT_0_WIDTH (32)
+#define NBL_IPRO_MNG_DECISION_FLT_0_DWLEN (1)
+union ipro_mng_decision_flt_0_u {
+	struct ipro_mng_decision_flt_0 {
+		u32 en:1;                /* [0] Default:0x0 RW */
+		u32 pkt_len_and:1;       /* [1] Default:0x0 RW */
+		u32 flow_ctrl_and:1;     /* [2] Default:0x0 RW */
+		u32 ncsi_and:1;          /* [3] Default:0x0 RW */
+		u32 eth_id:2;            /* [5:4] Default:0x0 RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_DECISION_FLT_0_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_DECISION_FLT_0_REG(r) (NBL_IPRO_MNG_DECISION_FLT_0_ADDR + \
+		(NBL_IPRO_MNG_DECISION_FLT_0_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_DECISION_FLT_1_ADDR  (0xb04540)
+#define NBL_IPRO_MNG_DECISION_FLT_1_DEPTH (4)
+#define NBL_IPRO_MNG_DECISION_FLT_1_WIDTH (32)
+#define NBL_IPRO_MNG_DECISION_FLT_1_DWLEN (1)
+union ipro_mng_decision_flt_1_u {
+	struct ipro_mng_decision_flt_1 {
+		u32 dmac_and:4;          /* [3:0] Default:0x0 RW */
+		u32 brcast_and:1;        /* [4] Default:0x0 RW */
+		u32 mulcast_and:1;       /* [5] Default:0x0 RW */
+		u32 vlan_and:8;          /* [13:6] Default:0x0 RW */
+		u32 ipv4_dip_and:4;      /* [17:14] Default:0x0 RW */
+		u32 ipv6_dip_and:4;      /* [21:18] Default:0x0 RW */
+		u32 ethertype_and:4;     /* [25:22] Default:0x0 RW */
+		u32 brcast_or:1;         /* [26] Default:0x0 RW */
+		u32 icmpv4_or:1;         /* [27] Default:0x0 RW */
+		u32 mld_or:4;            /* [31:28] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_DECISION_FLT_1_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_DECISION_FLT_1_REG(r) (NBL_IPRO_MNG_DECISION_FLT_1_ADDR + \
+		(NBL_IPRO_MNG_DECISION_FLT_1_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_DECISION_FLT_2_ADDR  (0xb04550)
+#define NBL_IPRO_MNG_DECISION_FLT_2_DEPTH (4)
+#define NBL_IPRO_MNG_DECISION_FLT_2_WIDTH (32)
+#define NBL_IPRO_MNG_DECISION_FLT_2_DWLEN (1)
+union ipro_mng_decision_flt_2_u {
+	struct ipro_mng_decision_flt_2 {
+		u32 neighbor_or:4;       /* [3:0] Default:0x0 RW */
+		u32 port_or:16;          /* [19:4] Default:0x0 RW */
+		u32 ethertype_or:4;      /* [23:20] Default:0x0 RW */
+		u32 arp_rsp_or:2;        /* [25:24] Default:0x0 RW */
+		u32 arp_req_or:2;        /* [27:26] Default:0x0 RW */
+		u32 dmac_or:4;           /* [31:28] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_DECISION_FLT_2_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_DECISION_FLT_2_REG(r) (NBL_IPRO_MNG_DECISION_FLT_2_ADDR + \
+		(NBL_IPRO_MNG_DECISION_FLT_2_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_DMAC_FLT_0_ADDR  (0xb04560)
+#define NBL_IPRO_MNG_DMAC_FLT_0_DEPTH (4)
+#define NBL_IPRO_MNG_DMAC_FLT_0_WIDTH (32)
+#define NBL_IPRO_MNG_DMAC_FLT_0_DWLEN (1)
+union ipro_mng_dmac_flt_0_u {
+	struct ipro_mng_dmac_flt_0 {
+		u32 data:16;             /* [15:0] Default:0x0 RW */
+		u32 en:1;                /* [16] Default:0x0 RW */
+		u32 rsv:15;              /* [31:17] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_DMAC_FLT_0_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_DMAC_FLT_0_REG(r) (NBL_IPRO_MNG_DMAC_FLT_0_ADDR + \
+		(NBL_IPRO_MNG_DMAC_FLT_0_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_DMAC_FLT_1_ADDR  (0xb04570)
+#define NBL_IPRO_MNG_DMAC_FLT_1_DEPTH (4)
+#define NBL_IPRO_MNG_DMAC_FLT_1_WIDTH (32)
+#define NBL_IPRO_MNG_DMAC_FLT_1_DWLEN (1)
+union ipro_mng_dmac_flt_1_u {
+	struct ipro_mng_dmac_flt_1 {
+		u32 data:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_DMAC_FLT_1_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_DMAC_FLT_1_REG(r) (NBL_IPRO_MNG_DMAC_FLT_1_ADDR + \
+		(NBL_IPRO_MNG_DMAC_FLT_1_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_VLAN_FLT_ADDR  (0xb04580)
+#define NBL_IPRO_MNG_VLAN_FLT_DEPTH (8)
+#define NBL_IPRO_MNG_VLAN_FLT_WIDTH (32)
+#define NBL_IPRO_MNG_VLAN_FLT_DWLEN (1)
+union ipro_mng_vlan_flt_u {
+	struct ipro_mng_vlan_flt {
+		u32 data:12;             /* [11:0] Default:0x0 RW */
+		u32 sel:1;               /* [12] Default:0x0 RW */
+		u32 nontag:1;            /* [13] Default:0x0 RW */
+		u32 en:1;                /* [14] Default:0x0 RW */
+		u32 rsv:17;              /* [31:15] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_VLAN_FLT_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_VLAN_FLT_REG(r) (NBL_IPRO_MNG_VLAN_FLT_ADDR + \
+		(NBL_IPRO_MNG_VLAN_FLT_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_ETHERTYPE_FLT_ADDR  (0xb045a0)
+#define NBL_IPRO_MNG_ETHERTYPE_FLT_DEPTH (4)
+#define NBL_IPRO_MNG_ETHERTYPE_FLT_WIDTH (32)
+#define NBL_IPRO_MNG_ETHERTYPE_FLT_DWLEN (1)
+union ipro_mng_ethertype_flt_u {
+	struct ipro_mng_ethertype_flt {
+		u32 data:16;             /* [15:0] Default:0x0 RW */
+		u32 en:1;                /* [16] Default:0x0 RW */
+		u32 rsv:15;              /* [31:17] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_ETHERTYPE_FLT_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_ETHERTYPE_FLT_REG(r) (NBL_IPRO_MNG_ETHERTYPE_FLT_ADDR + \
+		(NBL_IPRO_MNG_ETHERTYPE_FLT_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_IPV4_FLT_0_ADDR  (0xb045b0)
+#define NBL_IPRO_MNG_IPV4_FLT_0_DEPTH (4)
+#define NBL_IPRO_MNG_IPV4_FLT_0_WIDTH (32)
+#define NBL_IPRO_MNG_IPV4_FLT_0_DWLEN (1)
+union ipro_mng_ipv4_flt_0_u {
+	struct ipro_mng_ipv4_flt_0 {
+		u32 en:1;                /* [0] Default:0x0 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_IPV4_FLT_0_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_IPV4_FLT_0_REG(r) (NBL_IPRO_MNG_IPV4_FLT_0_ADDR + \
+		(NBL_IPRO_MNG_IPV4_FLT_0_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_IPV4_FLT_1_ADDR  (0xb045c0)
+#define NBL_IPRO_MNG_IPV4_FLT_1_DEPTH (4)
+#define NBL_IPRO_MNG_IPV4_FLT_1_WIDTH (32)
+#define NBL_IPRO_MNG_IPV4_FLT_1_DWLEN (1)
+union ipro_mng_ipv4_flt_1_u {
+	struct ipro_mng_ipv4_flt_1 {
+		u32 data:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_IPV4_FLT_1_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_IPV4_FLT_1_REG(r) (NBL_IPRO_MNG_IPV4_FLT_1_ADDR + \
+		(NBL_IPRO_MNG_IPV4_FLT_1_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_IPV6_FLT_0_ADDR  (0xb04600)
+#define NBL_IPRO_MNG_IPV6_FLT_0_DEPTH (4)
+#define NBL_IPRO_MNG_IPV6_FLT_0_WIDTH (32)
+#define NBL_IPRO_MNG_IPV6_FLT_0_DWLEN (1)
+union ipro_mng_ipv6_flt_0_u {
+	struct ipro_mng_ipv6_flt_0 {
+		u32 en:1;                /* [0] Default:0x0 RW */
+		u32 rsv:15;              /* [15:1] Default:0x0 RO */
+		u32 mask:16;             /* [31:16] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_IPV6_FLT_0_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_IPV6_FLT_0_REG(r) (NBL_IPRO_MNG_IPV6_FLT_0_ADDR + \
+		(NBL_IPRO_MNG_IPV6_FLT_0_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_IPV6_FLT_1_ADDR  (0xb04610)
+#define NBL_IPRO_MNG_IPV6_FLT_1_DEPTH (4)
+#define NBL_IPRO_MNG_IPV6_FLT_1_WIDTH (32)
+#define NBL_IPRO_MNG_IPV6_FLT_1_DWLEN (1)
+union ipro_mng_ipv6_flt_1_u {
+	struct ipro_mng_ipv6_flt_1 {
+		u32 data:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_IPV6_FLT_1_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_IPV6_FLT_1_REG(r) (NBL_IPRO_MNG_IPV6_FLT_1_ADDR + \
+		(NBL_IPRO_MNG_IPV6_FLT_1_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_IPV6_FLT_2_ADDR  (0xb04620)
+#define NBL_IPRO_MNG_IPV6_FLT_2_DEPTH (4)
+#define NBL_IPRO_MNG_IPV6_FLT_2_WIDTH (32)
+#define NBL_IPRO_MNG_IPV6_FLT_2_DWLEN (1)
+union ipro_mng_ipv6_flt_2_u {
+	struct ipro_mng_ipv6_flt_2 {
+		u32 data:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_IPV6_FLT_2_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_IPV6_FLT_2_REG(r) (NBL_IPRO_MNG_IPV6_FLT_2_ADDR + \
+		(NBL_IPRO_MNG_IPV6_FLT_2_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_IPV6_FLT_3_ADDR  (0xb04630)
+#define NBL_IPRO_MNG_IPV6_FLT_3_DEPTH (4)
+#define NBL_IPRO_MNG_IPV6_FLT_3_WIDTH (32)
+#define NBL_IPRO_MNG_IPV6_FLT_3_DWLEN (1)
+union ipro_mng_ipv6_flt_3_u {
+	struct ipro_mng_ipv6_flt_3 {
+		u32 data:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_IPV6_FLT_3_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_IPV6_FLT_3_REG(r) (NBL_IPRO_MNG_IPV6_FLT_3_ADDR + \
+		(NBL_IPRO_MNG_IPV6_FLT_3_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_IPV6_FLT_4_ADDR  (0xb04640)
+#define NBL_IPRO_MNG_IPV6_FLT_4_DEPTH (4)
+#define NBL_IPRO_MNG_IPV6_FLT_4_WIDTH (32)
+#define NBL_IPRO_MNG_IPV6_FLT_4_DWLEN (1)
+union ipro_mng_ipv6_flt_4_u {
+	struct ipro_mng_ipv6_flt_4 {
+		u32 data:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_IPV6_FLT_4_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_IPV6_FLT_4_REG(r) (NBL_IPRO_MNG_IPV6_FLT_4_ADDR + \
+		(NBL_IPRO_MNG_IPV6_FLT_4_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_PORT_FLT_ADDR  (0xb04650)
+#define NBL_IPRO_MNG_PORT_FLT_DEPTH (16)
+#define NBL_IPRO_MNG_PORT_FLT_WIDTH (32)
+#define NBL_IPRO_MNG_PORT_FLT_DWLEN (1)
+union ipro_mng_port_flt_u {
+	struct ipro_mng_port_flt {
+		u32 data:16;             /* [15:0] Default:0x0 RW */
+		u32 en:1;                /* [16] Default:0x0 RW */
+		u32 mode:1;              /* [17] Default:0x0 RW */
+		u32 tcp:1;               /* [18] Default:0x0 RW */
+		u32 udp:1;               /* [19] Default:0x0 RW */
+		u32 rsv:12;              /* [31:20] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_PORT_FLT_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_PORT_FLT_REG(r) (NBL_IPRO_MNG_PORT_FLT_ADDR + \
+		(NBL_IPRO_MNG_PORT_FLT_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_ARP_REQ_FLT_0_ADDR  (0xb04690)
+#define NBL_IPRO_MNG_ARP_REQ_FLT_0_DEPTH (2)
+#define NBL_IPRO_MNG_ARP_REQ_FLT_0_WIDTH (32)
+#define NBL_IPRO_MNG_ARP_REQ_FLT_0_DWLEN (1)
+union ipro_mng_arp_req_flt_0_u {
+	struct ipro_mng_arp_req_flt_0 {
+		u32 en:1;                /* [0] Default:0x0 RW */
+		u32 rsv:15;              /* [15:1] Default:0x0 RO */
+		u32 op:16;               /* [31:16] Default:0x1 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_ARP_REQ_FLT_0_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_ARP_REQ_FLT_0_REG(r) (NBL_IPRO_MNG_ARP_REQ_FLT_0_ADDR + \
+		(NBL_IPRO_MNG_ARP_REQ_FLT_0_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_ARP_REQ_FLT_1_ADDR  (0xb046a0)
+#define NBL_IPRO_MNG_ARP_REQ_FLT_1_DEPTH (2)
+#define NBL_IPRO_MNG_ARP_REQ_FLT_1_WIDTH (32)
+#define NBL_IPRO_MNG_ARP_REQ_FLT_1_DWLEN (1)
+union ipro_mng_arp_req_flt_1_u {
+	struct ipro_mng_arp_req_flt_1 {
+		u32 data:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_ARP_REQ_FLT_1_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_ARP_REQ_FLT_1_REG(r) (NBL_IPRO_MNG_ARP_REQ_FLT_1_ADDR + \
+		(NBL_IPRO_MNG_ARP_REQ_FLT_1_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_ARP_RSP_FLT_0_ADDR  (0xb046b0)
+#define NBL_IPRO_MNG_ARP_RSP_FLT_0_DEPTH (2)
+#define NBL_IPRO_MNG_ARP_RSP_FLT_0_WIDTH (32)
+#define NBL_IPRO_MNG_ARP_RSP_FLT_0_DWLEN (1)
+union ipro_mng_arp_rsp_flt_0_u {
+	struct ipro_mng_arp_rsp_flt_0 {
+		u32 en:1;                /* [0] Default:0x0 RW */
+		u32 rsv:15;              /* [15:1] Default:0x0 RO */
+		u32 op:16;               /* [31:16] Default:0x2 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_ARP_RSP_FLT_0_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_ARP_RSP_FLT_0_REG(r) (NBL_IPRO_MNG_ARP_RSP_FLT_0_ADDR + \
+		(NBL_IPRO_MNG_ARP_RSP_FLT_0_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_ARP_RSP_FLT_1_ADDR  (0xb046c0)
+#define NBL_IPRO_MNG_ARP_RSP_FLT_1_DEPTH (2)
+#define NBL_IPRO_MNG_ARP_RSP_FLT_1_WIDTH (32)
+#define NBL_IPRO_MNG_ARP_RSP_FLT_1_DWLEN (1)
+union ipro_mng_arp_rsp_flt_1_u {
+	struct ipro_mng_arp_rsp_flt_1 {
+		u32 data:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_ARP_RSP_FLT_1_DWLEN];
+} __packed;
+#define NBL_IPRO_MNG_ARP_RSP_FLT_1_REG(r) (NBL_IPRO_MNG_ARP_RSP_FLT_1_ADDR + \
+		(NBL_IPRO_MNG_ARP_RSP_FLT_1_DWLEN * 4) * (r))
+
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_86_ADDR  (0xb046d0)
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_86_DEPTH (1)
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_86_WIDTH (32)
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_86_DWLEN (1)
+union ipro_mng_neighbor_flt_86_u {
+	struct ipro_mng_neighbor_flt_86 {
+		u32 data:8;              /* [7:0] Default:0x86 RW */
+		u32 en:1;                /* [8] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_NEIGHBOR_FLT_86_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_87_ADDR  (0xb046d4)
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_87_DEPTH (1)
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_87_WIDTH (32)
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_87_DWLEN (1)
+union ipro_mng_neighbor_flt_87_u {
+	struct ipro_mng_neighbor_flt_87 {
+		u32 data:8;              /* [7:0] Default:0x87 RW */
+		u32 en:1;                /* [8] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_NEIGHBOR_FLT_87_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_88_ADDR  (0xb046d8)
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_88_DEPTH (1)
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_88_WIDTH (32)
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_88_DWLEN (1)
+union ipro_mng_neighbor_flt_88_u {
+	struct ipro_mng_neighbor_flt_88 {
+		u32 data:8;              /* [7:0] Default:0x88 RW */
+		u32 en:1;                /* [8] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_NEIGHBOR_FLT_88_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_89_ADDR  (0xb046dc)
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_89_DEPTH (1)
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_89_WIDTH (32)
+#define NBL_IPRO_MNG_NEIGHBOR_FLT_89_DWLEN (1)
+union ipro_mng_neighbor_flt_89_u {
+	struct ipro_mng_neighbor_flt_89 {
+		u32 data:8;              /* [7:0] Default:0x89 RW */
+		u32 en:1;                /* [8] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_NEIGHBOR_FLT_89_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MNG_MLD_FLT_82_ADDR  (0xb046e0)
+#define NBL_IPRO_MNG_MLD_FLT_82_DEPTH (1)
+#define NBL_IPRO_MNG_MLD_FLT_82_WIDTH (32)
+#define NBL_IPRO_MNG_MLD_FLT_82_DWLEN (1)
+union ipro_mng_mld_flt_82_u {
+	struct ipro_mng_mld_flt_82 {
+		u32 data:8;              /* [7:0] Default:0x82 RW */
+		u32 en:1;                /* [8] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_MLD_FLT_82_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MNG_MLD_FLT_83_ADDR  (0xb046e4)
+#define NBL_IPRO_MNG_MLD_FLT_83_DEPTH (1)
+#define NBL_IPRO_MNG_MLD_FLT_83_WIDTH (32)
+#define NBL_IPRO_MNG_MLD_FLT_83_DWLEN (1)
+union ipro_mng_mld_flt_83_u {
+	struct ipro_mng_mld_flt_83 {
+		u32 data:8;              /* [7:0] Default:0x83 RW */
+		u32 en:1;                /* [8] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_MLD_FLT_83_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MNG_MLD_FLT_84_ADDR  (0xb046e8)
+#define NBL_IPRO_MNG_MLD_FLT_84_DEPTH (1)
+#define NBL_IPRO_MNG_MLD_FLT_84_WIDTH (32)
+#define NBL_IPRO_MNG_MLD_FLT_84_DWLEN (1)
+union ipro_mng_mld_flt_84_u {
+	struct ipro_mng_mld_flt_84 {
+		u32 data:8;              /* [7:0] Default:0x84 RW */
+		u32 en:1;                /* [8] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_MLD_FLT_84_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MNG_MLD_FLT_8F_ADDR  (0xb046ec)
+#define NBL_IPRO_MNG_MLD_FLT_8F_DEPTH (1)
+#define NBL_IPRO_MNG_MLD_FLT_8F_WIDTH (32)
+#define NBL_IPRO_MNG_MLD_FLT_8F_DWLEN (1)
+union ipro_mng_mld_flt_8f_u {
+	struct ipro_mng_mld_flt_8f {
+		u32 data:8;              /* [7:0] Default:0x8f RW */
+		u32 en:1;                /* [8] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_MLD_FLT_8F_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MNG_ICMPV4_FLT_ADDR  (0xb046f0)
+#define NBL_IPRO_MNG_ICMPV4_FLT_DEPTH (1)
+#define NBL_IPRO_MNG_ICMPV4_FLT_WIDTH (32)
+#define NBL_IPRO_MNG_ICMPV4_FLT_DWLEN (1)
+union ipro_mng_icmpv4_flt_u {
+	struct ipro_mng_icmpv4_flt {
+		u32 en:1;                /* [0] Default:0x0 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_ICMPV4_FLT_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MNG_BRCAST_FLT_ADDR  (0xb04700)
+#define NBL_IPRO_MNG_BRCAST_FLT_DEPTH (1)
+#define NBL_IPRO_MNG_BRCAST_FLT_WIDTH (32)
+#define NBL_IPRO_MNG_BRCAST_FLT_DWLEN (1)
+union ipro_mng_brcast_flt_u {
+	struct ipro_mng_brcast_flt {
+		u32 en:1;                /* [0] Default:0x0 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_BRCAST_FLT_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MNG_MULCAST_FLT_ADDR  (0xb04704)
+#define NBL_IPRO_MNG_MULCAST_FLT_DEPTH (1)
+#define NBL_IPRO_MNG_MULCAST_FLT_WIDTH (32)
+#define NBL_IPRO_MNG_MULCAST_FLT_DWLEN (1)
+union ipro_mng_mulcast_flt_u {
+	struct ipro_mng_mulcast_flt {
+		u32 en:1;                /* [0] Default:0x0 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_MULCAST_FLT_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MNG_FLOW_CTRL_FLT_ADDR  (0xb04710)
+#define NBL_IPRO_MNG_FLOW_CTRL_FLT_DEPTH (1)
+#define NBL_IPRO_MNG_FLOW_CTRL_FLT_WIDTH (32)
+#define NBL_IPRO_MNG_FLOW_CTRL_FLT_DWLEN (1)
+union ipro_mng_flow_ctrl_flt_u {
+	struct ipro_mng_flow_ctrl_flt {
+		u32 data:16;             /* [15:0] Default:0x8808 RW */
+		u32 en:1;                /* [16] Default:0x0 RW */
+		u32 bow:1;               /* [17] Default:0x0 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_FLOW_CTRL_FLT_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MNG_NCSI_FLT_ADDR  (0xb04714)
+#define NBL_IPRO_MNG_NCSI_FLT_DEPTH (1)
+#define NBL_IPRO_MNG_NCSI_FLT_WIDTH (32)
+#define NBL_IPRO_MNG_NCSI_FLT_DWLEN (1)
+union ipro_mng_ncsi_flt_u {
+	struct ipro_mng_ncsi_flt {
+		u32 data:16;             /* [15:0] Default:0x88F8 RW */
+		u32 en:1;                /* [16] Default:0x0 RW */
+		u32 bow:1;               /* [17] Default:0x1 RW */
+		u32 rsv:14;              /* [31:18] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_NCSI_FLT_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MNG_PKT_LEN_FLT_ADDR  (0xb04720)
+#define NBL_IPRO_MNG_PKT_LEN_FLT_DEPTH (1)
+#define NBL_IPRO_MNG_PKT_LEN_FLT_WIDTH (32)
+#define NBL_IPRO_MNG_PKT_LEN_FLT_DWLEN (1)
+union ipro_mng_pkt_len_flt_u {
+	struct ipro_mng_pkt_len_flt {
+		u32 max:16;              /* [15:0] Default:0x800 RW */
+		u32 en:1;                /* [16] Default:0x0 RW */
+		u32 rsv:15;              /* [31:17] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_PKT_LEN_FLT_DWLEN];
+} __packed;
+
+#define NBL_IPRO_FLOW_STOP_ADDR  (0xb04810)
+#define NBL_IPRO_FLOW_STOP_DEPTH (1)
+#define NBL_IPRO_FLOW_STOP_WIDTH (32)
+#define NBL_IPRO_FLOW_STOP_DWLEN (1)
+union ipro_flow_stop_u {
+	struct ipro_flow_stop {
+		u32 en:1;                /* [0] Default:0x0 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_FLOW_STOP_DWLEN];
+} __packed;
+
+#define NBL_IPRO_TOKEN_NUM_ADDR  (0xb04814)
+#define NBL_IPRO_TOKEN_NUM_DEPTH (1)
+#define NBL_IPRO_TOKEN_NUM_WIDTH (32)
+#define NBL_IPRO_TOKEN_NUM_DWLEN (1)
+union ipro_token_num_u {
+	struct ipro_token_num {
+		u32 dn_cnt:8;            /* [7:0] Default:0x80 RO */
+		u32 up_cnt:8;            /* [15:8] Default:0x80 RO */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_TOKEN_NUM_DWLEN];
+} __packed;
+
+#define NBL_IPRO_BYPASS_ADDR  (0xb04818)
+#define NBL_IPRO_BYPASS_DEPTH (1)
+#define NBL_IPRO_BYPASS_WIDTH (32)
+#define NBL_IPRO_BYPASS_DWLEN (1)
+union ipro_bypass_u {
+	struct ipro_bypass {
+		u32 en:1;                /* [0] Default:0x0 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_BYPASS_DWLEN];
+} __packed;
+
+#define NBL_IPRO_RR_REQ_MASK_ADDR  (0xb0481c)
+#define NBL_IPRO_RR_REQ_MASK_DEPTH (1)
+#define NBL_IPRO_RR_REQ_MASK_WIDTH (32)
+#define NBL_IPRO_RR_REQ_MASK_DWLEN (1)
+union ipro_rr_req_mask_u {
+	struct ipro_rr_req_mask {
+		u32 dn:1;                /* [0] Default:0x0 RW */
+		u32 up:1;                /* [1] Default:0x0 RW */
+		u32 rsv:30;              /* [31:2] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_RR_REQ_MASK_DWLEN];
+} __packed;
+
+#define NBL_IPRO_BP_STATE_ADDR  (0xb04828)
+#define NBL_IPRO_BP_STATE_DEPTH (1)
+#define NBL_IPRO_BP_STATE_WIDTH (32)
+#define NBL_IPRO_BP_STATE_DWLEN (1)
+union ipro_bp_state_u {
+	struct ipro_bp_state {
+		u32 pp_up_link_fc:1;     /* [0] Default:0x0 RO */
+		u32 pp_dn_link_fc:1;     /* [1] Default:0x0 RO */
+		u32 pp_up_creadit:1;     /* [2] Default:0x0 RO */
+		u32 pp_dn_creadit:1;     /* [3] Default:0x0 RO */
+		u32 mcc_up_creadit:1;    /* [4] Default:0x0 RO */
+		u32 mcc_dn_creadit:1;    /* [5] Default:0x0 RO */
+		u32 pp_rdy:1;            /* [6] Default:0x1 RO */
+		u32 dn_rdy:1;            /* [7] Default:0x1 RO */
+		u32 up_rdy:1;            /* [8] Default:0x1 RO */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_BP_STATE_DWLEN];
+} __packed;
+
+#define NBL_IPRO_BP_HISTORY_ADDR  (0xb0482c)
+#define NBL_IPRO_BP_HISTORY_DEPTH (1)
+#define NBL_IPRO_BP_HISTORY_WIDTH (32)
+#define NBL_IPRO_BP_HISTORY_DWLEN (1)
+union ipro_bp_history_u {
+	struct ipro_bp_history {
+		u32 pp_rdy:1;            /* [0] Default:0x0 RC */
+		u32 dn_rdy:1;            /* [1] Default:0x0 RC */
+		u32 up_rdy:1;            /* [2] Default:0x0 RC */
+		u32 rsv:29;              /* [31:3] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_BP_HISTORY_DWLEN];
+} __packed;
+
+#define NBL_IPRO_ERRCODE_TBL_DROP_ADDR  (0xb0486c)
+#define NBL_IPRO_ERRCODE_TBL_DROP_DEPTH (1)
+#define NBL_IPRO_ERRCODE_TBL_DROP_WIDTH (32)
+#define NBL_IPRO_ERRCODE_TBL_DROP_DWLEN (1)
+union ipro_errcode_tbl_drop_u {
+	struct ipro_errcode_tbl_drop {
+		u32 cnt:16;              /* [15:0] Default:0x0 SCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_ERRCODE_TBL_DROP_DWLEN];
+} __packed;
+
+#define NBL_IPRO_SPORT_TBL_DROP_ADDR  (0xb04870)
+#define NBL_IPRO_SPORT_TBL_DROP_DEPTH (1)
+#define NBL_IPRO_SPORT_TBL_DROP_WIDTH (32)
+#define NBL_IPRO_SPORT_TBL_DROP_DWLEN (1)
+union ipro_sport_tbl_drop_u {
+	struct ipro_sport_tbl_drop {
+		u32 cnt:16;              /* [15:0] Default:0x0 SCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_SPORT_TBL_DROP_DWLEN];
+} __packed;
+
+#define NBL_IPRO_PTYPE_TBL_DROP_ADDR  (0xb04874)
+#define NBL_IPRO_PTYPE_TBL_DROP_DEPTH (1)
+#define NBL_IPRO_PTYPE_TBL_DROP_WIDTH (32)
+#define NBL_IPRO_PTYPE_TBL_DROP_DWLEN (1)
+union ipro_ptype_tbl_drop_u {
+	struct ipro_ptype_tbl_drop {
+		u32 cnt:16;              /* [15:0] Default:0x0 SCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_PTYPE_TBL_DROP_DWLEN];
+} __packed;
+
+#define NBL_IPRO_UDL_DROP_ADDR  (0xb04878)
+#define NBL_IPRO_UDL_DROP_DEPTH (1)
+#define NBL_IPRO_UDL_DROP_WIDTH (32)
+#define NBL_IPRO_UDL_DROP_DWLEN (1)
+union ipro_udl_drop_u {
+	struct ipro_udl_drop {
+		u32 cnt:16;              /* [15:0] Default:0x0 SCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_UDL_DROP_DWLEN];
+} __packed;
+
+#define NBL_IPRO_ANTIFAKE_DROP_ADDR  (0xb0487c)
+#define NBL_IPRO_ANTIFAKE_DROP_DEPTH (1)
+#define NBL_IPRO_ANTIFAKE_DROP_WIDTH (32)
+#define NBL_IPRO_ANTIFAKE_DROP_DWLEN (1)
+union ipro_antifake_drop_u {
+	struct ipro_antifake_drop {
+		u32 cnt:16;              /* [15:0] Default:0x0 SCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_ANTIFAKE_DROP_DWLEN];
+} __packed;
+
+#define NBL_IPRO_VLAN_NUM_DROP_ADDR  (0xb04880)
+#define NBL_IPRO_VLAN_NUM_DROP_DEPTH (1)
+#define NBL_IPRO_VLAN_NUM_DROP_WIDTH (32)
+#define NBL_IPRO_VLAN_NUM_DROP_DWLEN (1)
+union ipro_vlan_num_drop_u {
+	struct ipro_vlan_num_drop {
+		u32 cnt:16;              /* [15:0] Default:0x0 SCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_VLAN_NUM_DROP_DWLEN];
+} __packed;
+
+#define NBL_IPRO_TCP_STATE_DROP_ADDR  (0xb04884)
+#define NBL_IPRO_TCP_STATE_DROP_DEPTH (1)
+#define NBL_IPRO_TCP_STATE_DROP_WIDTH (32)
+#define NBL_IPRO_TCP_STATE_DROP_DWLEN (1)
+union ipro_tcp_state_drop_u {
+	struct ipro_tcp_state_drop {
+		u32 cnt:16;              /* [15:0] Default:0x0 SCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_TCP_STATE_DROP_DWLEN];
+} __packed;
+
+#define NBL_IPRO_RAM_ERR_DROP_ADDR  (0xb04888)
+#define NBL_IPRO_RAM_ERR_DROP_DEPTH (1)
+#define NBL_IPRO_RAM_ERR_DROP_WIDTH (32)
+#define NBL_IPRO_RAM_ERR_DROP_DWLEN (1)
+union ipro_ram_err_drop_u {
+	struct ipro_ram_err_drop {
+		u32 cnt:16;              /* [15:0] Default:0x0 SCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_RAM_ERR_DROP_DWLEN];
+} __packed;
+
+#define NBL_IPRO_KG_MISS_ADDR  (0xb0488c)
+#define NBL_IPRO_KG_MISS_DEPTH (1)
+#define NBL_IPRO_KG_MISS_WIDTH (32)
+#define NBL_IPRO_KG_MISS_DWLEN (1)
+union ipro_kg_miss_u {
+	struct ipro_kg_miss {
+		u32 drop_cnt:16;         /* [15:0] Default:0x0 SCTR */
+		u32 cnt:16;              /* [31:16] Default:0x0 SCTR */
+	} __packed info;
+	u32 data[NBL_IPRO_KG_MISS_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MNG_DROP_ADDR  (0xb04890)
+#define NBL_IPRO_MNG_DROP_DEPTH (1)
+#define NBL_IPRO_MNG_DROP_WIDTH (32)
+#define NBL_IPRO_MNG_DROP_DWLEN (1)
+union ipro_mng_drop_u {
+	struct ipro_mng_drop {
+		u32 cnt:16;              /* [15:0] Default:0x0 SCTR */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_MNG_DROP_DWLEN];
+} __packed;
+
+#define NBL_IPRO_MTU_CHECK_DROP_ADDR  (0xb04900)
+#define NBL_IPRO_MTU_CHECK_DROP_DEPTH (256)
+#define NBL_IPRO_MTU_CHECK_DROP_WIDTH (32)
+#define NBL_IPRO_MTU_CHECK_DROP_DWLEN (1)
+union ipro_mtu_check_drop_u {
+	struct ipro_mtu_check_drop {
+		u32 vsi_3:8;             /* [7:0] Default:0x0 SCTR */
+		u32 vsi_2:8;             /* [15:8] Default:0x0 SCTR */
+		u32 vsi_1:8;             /* [23:16] Default:0x0 SCTR */
+		u32 vsi_0:8;             /* [31:24] Default:0x0 SCTR */
+	} __packed info;
+	u32 data[NBL_IPRO_MTU_CHECK_DROP_DWLEN];
+} __packed;
+#define NBL_IPRO_MTU_CHECK_DROP_REG(r) (NBL_IPRO_MTU_CHECK_DROP_ADDR + \
+		(NBL_IPRO_MTU_CHECK_DROP_DWLEN * 4) * (r))
+
+#define NBL_IPRO_LAST_QUEUE_RAM_ERR_ADDR  (0xb04d08)
+#define NBL_IPRO_LAST_QUEUE_RAM_ERR_DEPTH (1)
+#define NBL_IPRO_LAST_QUEUE_RAM_ERR_WIDTH (32)
+#define NBL_IPRO_LAST_QUEUE_RAM_ERR_DWLEN (1)
+union ipro_last_queue_ram_err_u {
+	struct ipro_last_queue_ram_err {
+		u32 info:32;             /* [31:0] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_LAST_QUEUE_RAM_ERR_DWLEN];
+} __packed;
+
+#define NBL_IPRO_LAST_DN_SRC_PORT_RAM_ERR_ADDR  (0xb04d0c)
+#define NBL_IPRO_LAST_DN_SRC_PORT_RAM_ERR_DEPTH (1)
+#define NBL_IPRO_LAST_DN_SRC_PORT_RAM_ERR_WIDTH (32)
+#define NBL_IPRO_LAST_DN_SRC_PORT_RAM_ERR_DWLEN (1)
+union ipro_last_dn_src_port_ram_err_u {
+	struct ipro_last_dn_src_port_ram_err {
+		u32 info:32;             /* [31:0] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_LAST_DN_SRC_PORT_RAM_ERR_DWLEN];
+} __packed;
+
+#define NBL_IPRO_LAST_UP_SRC_PORT_RAM_ERR_ADDR  (0xb04d10)
+#define NBL_IPRO_LAST_UP_SRC_PORT_RAM_ERR_DEPTH (1)
+#define NBL_IPRO_LAST_UP_SRC_PORT_RAM_ERR_WIDTH (32)
+#define NBL_IPRO_LAST_UP_SRC_PORT_RAM_ERR_DWLEN (1)
+union ipro_last_up_src_port_ram_err_u {
+	struct ipro_last_up_src_port_ram_err {
+		u32 info:32;             /* [31:0] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_LAST_UP_SRC_PORT_RAM_ERR_DWLEN];
+} __packed;
+
+#define NBL_IPRO_LAST_DN_PTYPE_RAM_ERR_ADDR  (0xb04d14)
+#define NBL_IPRO_LAST_DN_PTYPE_RAM_ERR_DEPTH (1)
+#define NBL_IPRO_LAST_DN_PTYPE_RAM_ERR_WIDTH (32)
+#define NBL_IPRO_LAST_DN_PTYPE_RAM_ERR_DWLEN (1)
+union ipro_last_dn_ptype_ram_err_u {
+	struct ipro_last_dn_ptype_ram_err {
+		u32 info:32;             /* [31:0] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_LAST_DN_PTYPE_RAM_ERR_DWLEN];
+} __packed;
+
+#define NBL_IPRO_LAST_UP_PTYPE_RAM_ERR_ADDR  (0xb04d18)
+#define NBL_IPRO_LAST_UP_PTYPE_RAM_ERR_DEPTH (1)
+#define NBL_IPRO_LAST_UP_PTYPE_RAM_ERR_WIDTH (32)
+#define NBL_IPRO_LAST_UP_PTYPE_RAM_ERR_DWLEN (1)
+union ipro_last_up_ptype_ram_err_u {
+	struct ipro_last_up_ptype_ram_err {
+		u32 info:32;             /* [31:0] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_LAST_UP_PTYPE_RAM_ERR_DWLEN];
+} __packed;
+
+#define NBL_IPRO_LAST_KG_PROF_RAM_ERR_ADDR  (0xb04d20)
+#define NBL_IPRO_LAST_KG_PROF_RAM_ERR_DEPTH (1)
+#define NBL_IPRO_LAST_KG_PROF_RAM_ERR_WIDTH (32)
+#define NBL_IPRO_LAST_KG_PROF_RAM_ERR_DWLEN (1)
+union ipro_last_kg_prof_ram_err_u {
+	struct ipro_last_kg_prof_ram_err {
+		u32 info:32;             /* [31:0] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_LAST_KG_PROF_RAM_ERR_DWLEN];
+} __packed;
+
+#define NBL_IPRO_LAST_ERRCODE_RAM_ERR_ADDR  (0xb04d28)
+#define NBL_IPRO_LAST_ERRCODE_RAM_ERR_DEPTH (1)
+#define NBL_IPRO_LAST_ERRCODE_RAM_ERR_WIDTH (32)
+#define NBL_IPRO_LAST_ERRCODE_RAM_ERR_DWLEN (1)
+union ipro_last_errcode_ram_err_u {
+	struct ipro_last_errcode_ram_err {
+		u32 info:32;             /* [31:0] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_LAST_ERRCODE_RAM_ERR_DWLEN];
+} __packed;
+
+#define NBL_IPRO_IN_PKT_CAP_EN_ADDR  (0xb04dfc)
+#define NBL_IPRO_IN_PKT_CAP_EN_DEPTH (1)
+#define NBL_IPRO_IN_PKT_CAP_EN_WIDTH (32)
+#define NBL_IPRO_IN_PKT_CAP_EN_DWLEN (1)
+union ipro_in_pkt_cap_en_u {
+	struct ipro_in_pkt_cap_en {
+		u32 en:1;                /* [0] Default:0x0 RW */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_IN_PKT_CAP_EN_DWLEN];
+} __packed;
+
+#define NBL_IPRO_IN_PKT_CAP_ADDR  (0xb04e00)
+#define NBL_IPRO_IN_PKT_CAP_DEPTH (64)
+#define NBL_IPRO_IN_PKT_CAP_WIDTH (32)
+#define NBL_IPRO_IN_PKT_CAP_DWLEN (1)
+union ipro_in_pkt_cap_u {
+	struct ipro_in_pkt_cap {
+		u32 data:32;             /* [31:0] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_IN_PKT_CAP_DWLEN];
+} __packed;
+#define NBL_IPRO_IN_PKT_CAP_REG(r) (NBL_IPRO_IN_PKT_CAP_ADDR + \
+		(NBL_IPRO_IN_PKT_CAP_DWLEN * 4) * (r))
+
+#define NBL_IPRO_ERRCODE_TBL_ADDR  (0xb05000)
+#define NBL_IPRO_ERRCODE_TBL_DEPTH (16)
+#define NBL_IPRO_ERRCODE_TBL_WIDTH (64)
+#define NBL_IPRO_ERRCODE_TBL_DWLEN (2)
+union ipro_errcode_tbl_u {
+	struct ipro_errcode_tbl {
+		u32 dqueue:11;           /* [10:0] Default:0x0 RW */
+		u32 dqueue_en:1;         /* [11] Default:0x0 RW */
+		u32 dqueue_pri:2;        /* [13:12] Default:0x0 RW */
+		u32 set_dport_pri:2;     /* [15:14] Default:0x0 RW */
+		u32 set_dport:16;        /* [31:16] Default:0x0 RW */
+		u32 set_dport_en:1;      /* [32] Default:0x0 RW */
+		u32 proc_done:1;         /* [33] Default:0x0 RW */
+		u32 vld:1;               /* [34] Default:0x0 RW */
+		u32 rsv:29;              /* [63:35] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_ERRCODE_TBL_DWLEN];
+} __packed;
+#define NBL_IPRO_ERRCODE_TBL_REG(r) (NBL_IPRO_ERRCODE_TBL_ADDR + \
+		(NBL_IPRO_ERRCODE_TBL_DWLEN * 4) * (r))
+
+#define NBL_IPRO_DN_PTYPE_TBL_ADDR  (0xb06000)
+#define NBL_IPRO_DN_PTYPE_TBL_DEPTH (256)
+#define NBL_IPRO_DN_PTYPE_TBL_WIDTH (64)
+#define NBL_IPRO_DN_PTYPE_TBL_DWLEN (2)
+union ipro_dn_ptype_tbl_u {
+	struct ipro_dn_ptype_tbl {
+		u32 dn_entry_vld:1;      /* [0] Default:0x0 RW */
+		u32 dn_mirror_en:1;      /* [1] Default:0x0 RW */
+		u32 dn_mirror_pri:2;     /* [3:2] Default:0x0 RW */
+		u32 dn_mirror_id:4;      /* [7:4] Default:0x0 RW */
+		u32 dn_encap_en:1;       /* [8] Default:0x0 RW */
+		u32 dn_encap_pri:2;      /* [10:9] Default:0x0 RW */
+		u32 dn_encap_index:13;   /* [23:11] Default:0x0 RW */
+		u32 not_used_0:6;        /* [29:24] Default:0x0 RW */
+		u32 proc_done:1;         /* [30] Default:0x0 RW */
+		u32 set_dport_en:1;      /* [31] Default:0x0 RW */
+		u32 set_dport:16;        /* [47:32] Default:0x0 RW */
+		u32 set_dport_pri:2;     /* [49:48] Default:0x0 RW */
+		u32 dqueue_pri:2;        /* [51:50] Default:0x0 RW */
+		u32 dqueue:11;           /* [62:52] Default:0x0 RW */
+		u32 dqueue_en:1;         /* [63] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_DN_PTYPE_TBL_DWLEN];
+} __packed;
+#define NBL_IPRO_DN_PTYPE_TBL_REG(r) (NBL_IPRO_DN_PTYPE_TBL_ADDR + \
+		(NBL_IPRO_DN_PTYPE_TBL_DWLEN * 4) * (r))
+
+#define NBL_IPRO_UP_PTYPE_TBL_ADDR  (0xb06800)
+#define NBL_IPRO_UP_PTYPE_TBL_DEPTH (256)
+#define NBL_IPRO_UP_PTYPE_TBL_WIDTH (64)
+#define NBL_IPRO_UP_PTYPE_TBL_DWLEN (2)
+union ipro_up_ptype_tbl_u {
+	struct ipro_up_ptype_tbl {
+		u32 up_entry_vld:1;      /* [0] Default:0x0 RW */
+		u32 up_mirror_en:1;      /* [1] Default:0x0 RW */
+		u32 up_mirror_pri:2;     /* [3:2] Default:0x0 RW */
+		u32 up_mirror_id:4;      /* [7:4] Default:0x0 RW */
+		u32 up_decap_en:1;       /* [8] Default:0x0 RW */
+		u32 up_decap_pri:2;      /* [10:9] Default:0x0 RW */
+		u32 not_used_1:19;       /* [29:11] Default:0x0 RW */
+		u32 proc_done:1;         /* [30] Default:0x0 RW */
+		u32 set_dport_en:1;      /* [31] Default:0x0 RW */
+		u32 set_dport:16;        /* [47:32] Default:0x0 RW */
+		u32 set_dport_pri:2;     /* [49:48] Default:0x0 RW */
+		u32 dqueue_pri:2;        /* [51:50] Default:0x0 RW */
+		u32 dqueue:11;           /* [62:52] Default:0x0 RW */
+		u32 dqueue_en:1;         /* [63] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_IPRO_UP_PTYPE_TBL_DWLEN];
+} __packed;
+#define NBL_IPRO_UP_PTYPE_TBL_REG(r) (NBL_IPRO_UP_PTYPE_TBL_ADDR + \
+		(NBL_IPRO_UP_PTYPE_TBL_DWLEN * 4) * (r))
+
+#define NBL_IPRO_QUEUE_TBL_ADDR  (0xb08000)
+#define NBL_IPRO_QUEUE_TBL_DEPTH (2048)
+#define NBL_IPRO_QUEUE_TBL_WIDTH (32)
+#define NBL_IPRO_QUEUE_TBL_DWLEN (1)
+union ipro_queue_tbl_u {
+	struct ipro_queue_tbl {
+		u32 vsi:10;              /* [9:0] Default:0x0 RW */
+		u32 vsi_en:1;            /* [10] Default:0x0 RW */
+		u32 rsv:21;              /* [31:11] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_QUEUE_TBL_DWLEN];
+} __packed;
+#define NBL_IPRO_QUEUE_TBL_REG(r) (NBL_IPRO_QUEUE_TBL_ADDR + \
+		(NBL_IPRO_QUEUE_TBL_DWLEN * 4) * (r))
+
+#define NBL_IPRO_UP_SRC_PORT_TBL_ADDR  (0xb0b000)
+#define NBL_IPRO_UP_SRC_PORT_TBL_DEPTH (4)
+#define NBL_IPRO_UP_SRC_PORT_TBL_WIDTH (64)
+#define NBL_IPRO_UP_SRC_PORT_TBL_DWLEN (2)
+union ipro_up_src_port_tbl_u {
+	struct ipro_up_src_port_tbl {
+		u32 entry_vld:1;         /* [0] Default:0x0 RW */
+		u32 vlan_layer_num_0:2;  /* [2:1] Default:0x0 RW */
+		u32 vlan_layer_num_1:2;  /* [4:3] Default:0x0 RW */
+		u32 lag_vld:1;           /* [5] Default:0x0 RW */
+		u32 lag_id:2;            /* [7:6] Default:0x0 RW */
+		u32 hw_flow:1;          /* [8] Default:0x0 RW */
+		u32 mirror_en:1;         /* [9] Default:0x0 RW */
+		u32 mirror_pr:2;         /* [11:10] Default:0x0 RW */
+		u32 mirror_id:4;         /* [15:12] Default:0x0 RW */
+		u32 dqueue_pri:2;        /* [17:16] Default:0x0 RW */
+		u32 set_dport_pri:2;     /* [19:18] Default:0x0 RW */
+		u32 dqueue:11;           /* [30:20] Default:0x0 RW */
+		u32 dqueue_en:1;         /* [31] Default:0x0 RW */
+		u32 set_dport:16;        /* [47:32] Default:0x0 RW */
+		u32 set_dport_en:1;      /* [48] Default:0x0 RW */
+		u32 proc_done:1;         /* [49] Default:0x0 RW */
+		u32 car_en:1;            /* [50] Default:0x0 RW */
+		u32 car_pr:2;            /* [52:51] Default:0x0 RW */
+		u32 car_id:10;           /* [62:53] Default:0x0 RW */
+		u32 rsv:1;               /* [63] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_UP_SRC_PORT_TBL_DWLEN];
+} __packed;
+#define NBL_IPRO_UP_SRC_PORT_TBL_REG(r) (NBL_IPRO_UP_SRC_PORT_TBL_ADDR + \
+		(NBL_IPRO_UP_SRC_PORT_TBL_DWLEN * 4) * (r))
+
+#define NBL_IPRO_DN_SRC_PORT_TBL_ADDR  (0xb0c000)
+#define NBL_IPRO_DN_SRC_PORT_TBL_DEPTH (1024)
+#define NBL_IPRO_DN_SRC_PORT_TBL_WIDTH (128)
+#define NBL_IPRO_DN_SRC_PORT_TBL_DWLEN (4)
+union ipro_dn_src_port_tbl_u {
+	struct ipro_dn_src_port_tbl {
+		u32 entry_vld:1;         /* [0] Default:0x0 RW */
+		u32 mirror_en:1;         /* [1] Default:0x0 RW */
+		u32 mirror_pr:2;         /* [3:2] Default:0x0 RW */
+		u32 mirror_id:4;         /* [7:4] Default:0x0 RW */
+		u32 vlan_layer_num_1:2;  /* [9:8] Default:0x0 RW */
+		u32 hw_flow:1;          /* [10] Default:0x0 RW */
+		u32 mtu_sel:4;           /* [14:11] Default:0x0 RW */
+		u32 addr_check_en:1;     /* [15] Default:0x0 RW */
+		u32 smac_l:32;           /* [63:16] Default:0x0 RW */
+		u32 smac_h:16;           /* [63:16] Default:0x0 RW */
+		u32 dqueue:11;           /* [74:64] Default:0x0 RW */
+		u32 dqueue_en:1;         /* [75] Default:0x0 RW */
+		u32 dqueue_pri:2;        /* [77:76] Default:0x0 RW */
+		u32 set_dport_pri:2;     /* [79:78] Default:0x0 RW */
+		u32 set_dport:16;        /* [95:80] Default:0x0 RW */
+		u32 set_dport_en:1;      /* [96] Default:0x0 RW */
+		u32 proc_done:1;         /* [97] Default:0x0 RW */
+		u32 not_used_1:2;        /* [99:98] Default:0x0 RW */
+		u32 rsv:28;              /* [127:100] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_IPRO_DN_SRC_PORT_TBL_DWLEN];
+} __packed;
+#define NBL_IPRO_DN_SRC_PORT_TBL_REG(r) (NBL_IPRO_DN_SRC_PORT_TBL_ADDR + \
+		(NBL_IPRO_DN_SRC_PORT_TBL_DWLEN * 4) * (r))
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_mcc.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_mcc.h
new file mode 100644
index 000000000000..79d99ab98a23
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_mcc.h
@@ -0,0 +1,412 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+// Code generated by interstellar. DO NOT EDIT.
+// Compatible with leonis RTL tag 0710
+
+#ifndef NBL_MCC_H
+#define NBL_MCC_H 1
+
+#include <linux/types.h>
+
+#define NBL_MCC_BASE (0x00B44000)
+
+#define NBL_MCC_INT_STATUS_ADDR  (0xb44000)
+#define NBL_MCC_INT_STATUS_DEPTH (1)
+#define NBL_MCC_INT_STATUS_WIDTH (32)
+#define NBL_MCC_INT_STATUS_DWLEN (1)
+union mcc_int_status_u {
+	struct mcc_int_status {
+		u32 fatal_err:1;         /* [0] Default:0x0 RWC */
+		u32 fifo_uflw_err:1;     /* [1] Default:0x0 RWC */
+		u32 fifo_dflw_err:1;     /* [2] Default:0x0 RWC */
+		u32 fsm_err:1;           /* [3] Default:0x0 RWC */
+		u32 cif_err:1;           /* [4] Default:0x0 RWC */
+		u32 cfg_err:1;           /* [5] Default:0x0 RWC */
+		u32 data_ucor_err:1;     /* [6] Default:0x0 RWC */
+		u32 rsv:25;              /* [31:7] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_MCC_INT_STATUS_DWLEN];
+} __packed;
+
+#define NBL_MCC_INT_MASK_ADDR  (0xb44004)
+#define NBL_MCC_INT_MASK_DEPTH (1)
+#define NBL_MCC_INT_MASK_WIDTH (32)
+#define NBL_MCC_INT_MASK_DWLEN (1)
+union mcc_int_mask_u {
+	struct mcc_int_mask {
+		u32 fatal_err:1;         /* [0] Default:0x0 RW */
+		u32 fifo_uflw_err:1;     /* [1] Default:0x0 RW */
+		u32 fifo_dflw_err:1;     /* [2] Default:0x0 RW */
+		u32 fsm_err:1;           /* [3] Default:0x0 RW */
+		u32 cif_err:1;           /* [4] Default:0x0 RW */
+		u32 cfg_err:1;           /* [5] Default:0x0 RW */
+		u32 data_ucor_err:1;     /* [6] Default:0x0 RW */
+		u32 rsv:25;              /* [31:7] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_MCC_INT_MASK_DWLEN];
+} __packed;
+
+#define NBL_MCC_INT_SET_ADDR  (0xb44008)
+#define NBL_MCC_INT_SET_DEPTH (1)
+#define NBL_MCC_INT_SET_WIDTH (32)
+#define NBL_MCC_INT_SET_DWLEN (1)
+union mcc_int_set_u {
+	struct mcc_int_set {
+		u32 fatal_err:1;         /* [0] Default:0x0 WO */
+		u32 fifo_uflw_err:1;     /* [1] Default:0x0 WO */
+		u32 fifo_dflw_err:1;     /* [2] Default:0x0 WO */
+		u32 fsm_err:1;           /* [3] Default:0x0 WO */
+		u32 cif_err:1;           /* [4] Default:0x0 WO */
+		u32 cfg_err:1;           /* [5] Default:0x0 WO */
+		u32 data_ucor_err:1;     /* [6] Default:0x0 WO */
+		u32 rsv:25;              /* [31:7] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_MCC_INT_SET_DWLEN];
+} __packed;
+
+#define NBL_MCC_INIT_DONE_ADDR  (0xb4400c)
+#define NBL_MCC_INIT_DONE_DEPTH (1)
+#define NBL_MCC_INIT_DONE_WIDTH (32)
+#define NBL_MCC_INIT_DONE_DWLEN (1)
+union mcc_init_done_u {
+	struct mcc_init_done {
+		u32 done:1;              /* [0] Default:0x0 RO */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_MCC_INIT_DONE_DWLEN];
+} __packed;
+
+#define NBL_MCC_CIF_ERR_INFO_ADDR  (0xb44040)
+#define NBL_MCC_CIF_ERR_INFO_DEPTH (1)
+#define NBL_MCC_CIF_ERR_INFO_WIDTH (32)
+#define NBL_MCC_CIF_ERR_INFO_DWLEN (1)
+union mcc_cif_err_info_u {
+	struct mcc_cif_err_info {
+		u32 addr:30;             /* [29:0] Default:0x0 RO */
+		u32 wr_err:1;            /* [30] Default:0x0 RO */
+		u32 ucor_err:1;          /* [31] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_MCC_CIF_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_MCC_CFG_ERR_INFO_ADDR  (0xb44050)
+#define NBL_MCC_CFG_ERR_INFO_DEPTH (1)
+#define NBL_MCC_CFG_ERR_INFO_WIDTH (32)
+#define NBL_MCC_CFG_ERR_INFO_DWLEN (1)
+union mcc_cfg_err_info_u {
+	struct mcc_cfg_err_info {
+		u32 id:8;                /* [7:0] Default:0x0 RO */
+		u32 addr:16;             /* [23:8] Default:0x0 RO */
+		u32 rsv:8;               /* [31:24] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_MCC_CFG_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_MCC_CAR_CTRL_ADDR  (0xb44100)
+#define NBL_MCC_CAR_CTRL_DEPTH (1)
+#define NBL_MCC_CAR_CTRL_WIDTH (32)
+#define NBL_MCC_CAR_CTRL_DWLEN (1)
+union mcc_car_ctrl_u {
+	struct mcc_car_ctrl {
+		u32 sctr_car:1;          /* [0] Default:0x1 RW */
+		u32 rctr_car:1;          /* [1] Default:0x1 RW */
+		u32 rc_car:1;            /* [2] Default:0x1 RW */
+		u32 tbl_rc_car:1;        /* [3] Default:0x1 RW */
+		u32 rsv:28;              /* [31:4] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_MCC_CAR_CTRL_DWLEN];
+} __packed;
+
+#define NBL_MCC_TIMEOUT_CFG_ADDR  (0xb44140)
+#define NBL_MCC_TIMEOUT_CFG_DEPTH (1)
+#define NBL_MCC_TIMEOUT_CFG_WIDTH (32)
+#define NBL_MCC_TIMEOUT_CFG_DWLEN (1)
+union mcc_timeout_cfg_u {
+	struct mcc_timeout_cfg {
+		u32 fsm_max_num:32;      /* [31:0] Default:0x0ffffffff RW */
+	} __packed info;
+	u32 data[NBL_MCC_TIMEOUT_CFG_DWLEN];
+} __packed;
+
+#define NBL_MCC_INIT_START_ADDR  (0xb44180)
+#define NBL_MCC_INIT_START_DEPTH (1)
+#define NBL_MCC_INIT_START_WIDTH (32)
+#define NBL_MCC_INIT_START_DWLEN (1)
+union mcc_init_start_u {
+	struct mcc_init_start {
+		u32 start:1;             /* [0] Default:0x0 WO */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_MCC_INIT_START_DWLEN];
+} __packed;
+
+#define NBL_MCC_RATE_CTRL_ADDR  (0xb44300)
+#define NBL_MCC_RATE_CTRL_DEPTH (1)
+#define NBL_MCC_RATE_CTRL_WIDTH (32)
+#define NBL_MCC_RATE_CTRL_DWLEN (1)
+union mcc_rate_ctrl_u {
+	struct mcc_rate_ctrl {
+		u32 rate_ctrl_eth_bandwidth:3; /* [2:0] Default:0x0 RW */
+		u32 rate_ctrl_eth_switch:2; /* [4:3] Default:0x0 RW */
+		u32 rate_ctrl_gear:3;    /* [7:5] Default:0x0 RW */
+		u32 rate_ctrl_en:1;      /* [8] Default:0x0 RW */
+		u32 rsv:23;              /* [31:9] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_MCC_RATE_CTRL_DWLEN];
+} __packed;
+
+#define NBL_MCC_CREDIT_ADDR  (0xb44400)
+#define NBL_MCC_CREDIT_DEPTH (1)
+#define NBL_MCC_CREDIT_WIDTH (32)
+#define NBL_MCC_CREDIT_DWLEN (1)
+union mcc_credit_u {
+	struct mcc_credit {
+		u32 mcc_up_credit:5;     /* [4:0] Default:0x1d RW */
+		u32 mcc_up_vld:1;        /* [5] Default:0x0 WO */
+		u32 rsv1:10;             /* [15:6] Default:0x0 RO */
+		u32 mcc_dn_credit:5;     /* [20:16] Default:0x1d RW */
+		u32 mcc_dn_vld:1;        /* [21] Default:0x0 WO */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_MCC_CREDIT_DWLEN];
+} __packed;
+
+#define NBL_MCC_ACTION_PRIORITY_ADDR  (0xb44500)
+#define NBL_MCC_ACTION_PRIORITY_DEPTH (1)
+#define NBL_MCC_ACTION_PRIORITY_WIDTH (32)
+#define NBL_MCC_ACTION_PRIORITY_DWLEN (1)
+union mcc_action_priority_u {
+	struct mcc_action_priority {
+		u32 statidx_act_pri:2;   /* [1:0] Default:0x0 RW */
+		u32 dport_act_pri:2;     /* [3:2] Default:0x0 RW */
+		u32 dqueue_act_pri:2;    /* [5:4] Default:0x0 RW */
+		u32 rsv:26;              /* [31:6] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_MCC_ACTION_PRIORITY_DWLEN];
+} __packed;
+
+#define NBL_MCC_UU_WEIGHT_ADDR  (0xb44600)
+#define NBL_MCC_UU_WEIGHT_DEPTH (1)
+#define NBL_MCC_UU_WEIGHT_WIDTH (32)
+#define NBL_MCC_UU_WEIGHT_DWLEN (1)
+union mcc_uu_weight_u {
+	struct mcc_uu_weight {
+		u32 uu_weight:8;         /* [7:0] Default:0x2 RW */
+		u32 rsv:24;              /* [31:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_MCC_UU_WEIGHT_DWLEN];
+} __packed;
+
+#define NBL_MCC_DU_WEIGHT_ADDR  (0xb44604)
+#define NBL_MCC_DU_WEIGHT_DEPTH (1)
+#define NBL_MCC_DU_WEIGHT_WIDTH (32)
+#define NBL_MCC_DU_WEIGHT_DWLEN (1)
+union mcc_du_weight_u {
+	struct mcc_du_weight {
+		u32 du_weight:8;         /* [7:0] Default:0x2 RW */
+		u32 rsv:24;              /* [31:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_MCC_DU_WEIGHT_DWLEN];
+} __packed;
+
+#define NBL_MCC_UCH_WEIGHT_ADDR  (0xb44608)
+#define NBL_MCC_UCH_WEIGHT_DEPTH (1)
+#define NBL_MCC_UCH_WEIGHT_WIDTH (32)
+#define NBL_MCC_UCH_WEIGHT_DWLEN (1)
+union mcc_uch_weight_u {
+	struct mcc_uch_weight {
+		u32 uch_weight:8;        /* [7:0] Default:0x1 RW */
+		u32 rsv:24;              /* [31:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_MCC_UCH_WEIGHT_DWLEN];
+} __packed;
+
+#define NBL_MCC_DCH_WEIGHT_ADDR  (0xb4460c)
+#define NBL_MCC_DCH_WEIGHT_DEPTH (1)
+#define NBL_MCC_DCH_WEIGHT_WIDTH (32)
+#define NBL_MCC_DCH_WEIGHT_DWLEN (1)
+union mcc_dch_weight_u {
+	struct mcc_dch_weight {
+		u32 dch_weight:8;        /* [7:0] Default:0x1 RW */
+		u32 rsv:24;              /* [31:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_MCC_DCH_WEIGHT_DWLEN];
+} __packed;
+
+#define NBL_MCC_SPD_TIMEOUT_TH_ADDR  (0xb44740)
+#define NBL_MCC_SPD_TIMEOUT_TH_DEPTH (1)
+#define NBL_MCC_SPD_TIMEOUT_TH_WIDTH (32)
+#define NBL_MCC_SPD_TIMEOUT_TH_DWLEN (1)
+union mcc_spd_timeout_th_u {
+	struct mcc_spd_timeout_th {
+		u32 timeout_th:8;        /* [7:0] Default:0xff RW */
+		u32 rsv:14;              /* [21:8] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_MCC_SPD_TIMEOUT_TH_DWLEN];
+} __packed;
+
+#define NBL_MCC_EXT_FLAG_OFFSET_ADDR  (0xb44800)
+#define NBL_MCC_EXT_FLAG_OFFSET_DEPTH (1)
+#define NBL_MCC_EXT_FLAG_OFFSET_WIDTH (32)
+#define NBL_MCC_EXT_FLAG_OFFSET_DWLEN (1)
+union mcc_ext_flag_offset_u {
+	struct mcc_ext_flag_offset {
+		u32 dir_offset:5;        /* [4:0] Default:0x00 RW */
+		u32 rsv:27;              /* [31:5] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_MCC_EXT_FLAG_OFFSET_DWLEN];
+} __packed;
+
+#define NBL_MCC_EXT_MCIDX_ADDR  (0xb44804)
+#define NBL_MCC_EXT_MCIDX_DEPTH (1)
+#define NBL_MCC_EXT_MCIDX_WIDTH (32)
+#define NBL_MCC_EXT_MCIDX_DWLEN (1)
+union mcc_ext_mcidx_u {
+	struct mcc_ext_mcidx {
+		u32 mcidx_act_id:6;      /* [5:0] Default:0x0d RW */
+		u32 mcidx_vld:1;         /* [6] Default:0x1 RW */
+		u32 rsv:25;              /* [31:7] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_MCC_EXT_MCIDX_DWLEN];
+} __packed;
+
+#define NBL_MCC_MC_ORIGINAL_DPORT_ADDR  (0xb44808)
+#define NBL_MCC_MC_ORIGINAL_DPORT_DEPTH (1)
+#define NBL_MCC_MC_ORIGINAL_DPORT_WIDTH (32)
+#define NBL_MCC_MC_ORIGINAL_DPORT_DWLEN (1)
+union mcc_mc_original_dport_u {
+	struct mcc_mc_original_dport {
+		u32 dport:16;            /* [15:0] Default:0x2fef RW */
+		u32 rsv:16;              /* [31:16] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_MCC_MC_ORIGINAL_DPORT_DWLEN];
+} __packed;
+
+#define NBL_MCC_AM_SET_FLAGS_ADDR  (0xb44900)
+#define NBL_MCC_AM_SET_FLAGS_DEPTH (1)
+#define NBL_MCC_AM_SET_FLAGS_WIDTH (32)
+#define NBL_MCC_AM_SET_FLAGS_DWLEN (1)
+union mcc_am_set_flags_u {
+	struct mcc_am_set_flags {
+		u32 set_flags:32;        /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_MCC_AM_SET_FLAGS_DWLEN];
+} __packed;
+
+#define NBL_MCC_AM_CLEAR_FLAGS_ADDR  (0xb44904)
+#define NBL_MCC_AM_CLEAR_FLAGS_DEPTH (1)
+#define NBL_MCC_AM_CLEAR_FLAGS_WIDTH (32)
+#define NBL_MCC_AM_CLEAR_FLAGS_DWLEN (1)
+union mcc_am_clear_flags_u {
+	struct mcc_am_clear_flags {
+		u32 clear_flags:32;      /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_MCC_AM_CLEAR_FLAGS_DWLEN];
+} __packed;
+
+#define NBL_MCC_AM_ACT_ID_ADDR  (0xb44a00)
+#define NBL_MCC_AM_ACT_ID_DEPTH (1)
+#define NBL_MCC_AM_ACT_ID_WIDTH (32)
+#define NBL_MCC_AM_ACT_ID_DWLEN (1)
+union mcc_am_act_id_u {
+	struct mcc_am_act_id {
+		u32 dport_act_id:6;      /* [5:0] Default:0x9 RW */
+		u32 rsv3:2;              /* [7:6] Default:0x0 RO */
+		u32 dqueue_act_id:6;     /* [13:8] Default:0xa RW */
+		u32 rsv2:2;              /* [15:14] Default:0x0 RO */
+		u32 statidx_act_id:6;    /* [21:16] Default:0x10 RW */
+		u32 rsv1:2;              /* [23:22] Default:0x0 RO */
+		u32 mirroridx_act_id:6;  /* [29:24] Default:0x08 RW */
+		u32 rsv:2;               /* [31:30] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_MCC_AM_ACT_ID_DWLEN];
+} __packed;
+
+#define NBL_MCC_QUEUE_EN_CTRL_ADDR  (0xb44b00)
+#define NBL_MCC_QUEUE_EN_CTRL_DEPTH (1)
+#define NBL_MCC_QUEUE_EN_CTRL_WIDTH (32)
+#define NBL_MCC_QUEUE_EN_CTRL_DWLEN (1)
+union mcc_queue_en_ctrl_u {
+	struct mcc_queue_en_ctrl {
+		u32 uuq_en:1;            /* [0] Default:0x1 RW */
+		u32 duq_en:1;            /* [1] Default:0x1 RW */
+		u32 umhq_en:1;           /* [2] Default:0x1 RW */
+		u32 dmhq_en:1;           /* [3] Default:0x1 RW */
+		u32 umlq_en:1;           /* [4] Default:0x1 RW */
+		u32 dmlq_en:1;           /* [5] Default:0x1 RW */
+		u32 uchq_en:1;           /* [6] Default:0x1 RW */
+		u32 dchq_en:1;           /* [7] Default:0x1 RW */
+		u32 uclq_en:1;           /* [8] Default:0x1 RW */
+		u32 dclq_en:1;           /* [9] Default:0x1 RW */
+		u32 rsv:22;              /* [31:10] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_MCC_QUEUE_EN_CTRL_DWLEN];
+} __packed;
+
+#define NBL_MCC_CFG_TEST_ADDR  (0xb44c00)
+#define NBL_MCC_CFG_TEST_DEPTH (1)
+#define NBL_MCC_CFG_TEST_WIDTH (32)
+#define NBL_MCC_CFG_TEST_DWLEN (1)
+union mcc_cfg_test_u {
+	struct mcc_cfg_test {
+		u32 test:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_MCC_CFG_TEST_DWLEN];
+} __packed;
+
+#define NBL_MCC_BP_STATE_ADDR  (0xb44f00)
+#define NBL_MCC_BP_STATE_DEPTH (1)
+#define NBL_MCC_BP_STATE_WIDTH (32)
+#define NBL_MCC_BP_STATE_DWLEN (1)
+union mcc_bp_state_u {
+	struct mcc_bp_state {
+		u32 in_bp:1;             /* [0] Default:0x0 RO */
+		u32 out_bp:1;            /* [1] Default:0x0 RO */
+		u32 inter_bp:1;          /* [2] Default:0x0 RO */
+		u32 rsv:29;              /* [31:3] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_MCC_BP_STATE_DWLEN];
+} __packed;
+
+#define NBL_MCC_BP_HISTORY_ADDR  (0xb44f04)
+#define NBL_MCC_BP_HISTORY_DEPTH (1)
+#define NBL_MCC_BP_HISTORY_WIDTH (32)
+#define NBL_MCC_BP_HISTORY_DWLEN (1)
+union mcc_bp_history_u {
+	struct mcc_bp_history {
+		u32 in_bp:1;             /* [0] Default:0x0 RC */
+		u32 out_bp:1;            /* [1] Default:0x0 RC */
+		u32 inter_bp:1;          /* [2] Default:0x0 RC */
+		u32 rsv:29;              /* [31:3] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_MCC_BP_HISTORY_DWLEN];
+} __packed;
+
+#define NBL_MCC_TBL_ADDR  (0xb54000)
+#define NBL_MCC_TBL_DEPTH (8192)
+#define NBL_MCC_TBL_WIDTH (64)
+#define NBL_MCC_TBL_DWLEN (2)
+union mcc_tbl_u {
+	struct mcc_tbl {
+		u32 dport_act:16;        /* [15:0] Default:0x0 RW */
+		u32 dqueue_act:11;       /* [26:16] Default:0x0 RW */
+		u32 dqueue_en:1;         /* [27] Default:0x0 RW */
+		u32 dqueue_rsv:4;        /* [31:28] Default:0x0 RO */
+		u32 statid_act:11;       /* [42:32] Default:0x0 RW */
+		u32 statid_filter:1;     /* [43] Default:0x0 RW */
+		u32 flowid_filter:1;     /* [44] Default:0x0 RW */
+		u32 stateid_rsv:3;       /* [47:45] Default:0x0 RO */
+		u32 next_pntr:13;        /* [60:48] Default:0x0 RW */
+		u32 tail:1;              /* [61] Default:0x0 RW */
+		u32 vld:1;               /* [62] Default:0x0 RW */
+		u32 rsv:1;               /* [63] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_MCC_TBL_DWLEN];
+} __packed;
+#define NBL_MCC_TBL_REG(r) (NBL_MCC_TBL_ADDR + \
+		(NBL_MCC_TBL_DWLEN * 4) * (r))
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_pp0.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_pp0.h
new file mode 100644
index 000000000000..1a5f857eb1ef
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_pp0.h
@@ -0,0 +1,619 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+// Code generated by interstellar. DO NOT EDIT.
+// Compatible with leonis RTL tag 0710
+
+#ifndef NBL_PP0_H
+#define NBL_PP0_H 1
+
+#include <linux/types.h>
+
+#define NBL_PP0_BASE (0x00B14000)
+
+#define NBL_PP0_INT_STATUS_ADDR  (0xb14000)
+#define NBL_PP0_INT_STATUS_DEPTH (1)
+#define NBL_PP0_INT_STATUS_WIDTH (32)
+#define NBL_PP0_INT_STATUS_DWLEN (1)
+union pp0_int_status_u {
+	struct pp0_int_status {
+		u32 rsv5:1;              /* [00:00] Default:0x0 RO */
+		u32 fifo_uflw_err:1;     /* [01:01] Default:0x0 RWC */
+		u32 fifo_dflw_err:1;     /* [02:02] Default:0x0 RWC */
+		u32 rsv4:1;              /* [03:03] Default:0x0 RO */
+		u32 cif_err:1;           /* [04:04] Default:0x0 RWC */
+		u32 rsv3:1;              /* [05:05] Default:0x0 RO */
+		u32 cfg_err:1;           /* [06:06] Default:0x0 RWC */
+		u32 data_ucor_err:1;     /* [07:07] Default:0x0 RWC */
+		u32 rsv2:1;              /* [08:08] Default:0x0 RO */
+		u32 rsv1:1;              /* [09:09] Default:0x0 RO */
+		u32 rsv:22;              /* [31:10] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP0_INT_STATUS_DWLEN];
+} __packed;
+
+#define NBL_PP0_INT_MASK_ADDR  (0xb14004)
+#define NBL_PP0_INT_MASK_DEPTH (1)
+#define NBL_PP0_INT_MASK_WIDTH (32)
+#define NBL_PP0_INT_MASK_DWLEN (1)
+union pp0_int_mask_u {
+	struct pp0_int_mask {
+		u32 rsv5:1;              /* [00:00] Default:0x0 RO */
+		u32 fifo_uflw_err:1;     /* [01:01] Default:0x0 RW */
+		u32 fifo_dflw_err:1;     /* [02:02] Default:0x0 RW */
+		u32 rsv4:1;              /* [03:03] Default:0x0 RO */
+		u32 cif_err:1;           /* [04:04] Default:0x0 RW */
+		u32 rsv3:1;              /* [05:05] Default:0x0 RO */
+		u32 cfg_err:1;           /* [06:06] Default:0x0 RW */
+		u32 data_ucor_err:1;     /* [07:07] Default:0x0 RW */
+		u32 rsv2:1;              /* [08:08] Default:0x0 RO */
+		u32 rsv1:1;              /* [09:09] Default:0x0 RO */
+		u32 rsv:22;              /* [31:10] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP0_INT_MASK_DWLEN];
+} __packed;
+
+#define NBL_PP0_INT_SET_ADDR  (0xb14008)
+#define NBL_PP0_INT_SET_DEPTH (1)
+#define NBL_PP0_INT_SET_WIDTH (32)
+#define NBL_PP0_INT_SET_DWLEN (1)
+union pp0_int_set_u {
+	struct pp0_int_set {
+		u32 rsv5:1;              /* [00:00] Default:0x0 RO */
+		u32 fifo_uflw_err:1;     /* [01:01] Default:0x0 WO */
+		u32 fifo_dflw_err:1;     /* [02:02] Default:0x0 WO */
+		u32 rsv4:1;              /* [03:03] Default:0x0 RO */
+		u32 cif_err:1;           /* [04:04] Default:0x0 WO */
+		u32 rsv3:1;              /* [05:05] Default:0x0 RO */
+		u32 cfg_err:1;           /* [06:06] Default:0x0 WO */
+		u32 data_ucor_err:1;     /* [07:07] Default:0x0 WO */
+		u32 rsv2:1;              /* [08:08] Default:0x0 RO */
+		u32 rsv1:1;              /* [09:09] Default:0x0 RO */
+		u32 rsv:22;              /* [31:10] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP0_INT_SET_DWLEN];
+} __packed;
+
+#define NBL_PP0_INIT_DONE_ADDR  (0xb1400c)
+#define NBL_PP0_INIT_DONE_DEPTH (1)
+#define NBL_PP0_INIT_DONE_WIDTH (32)
+#define NBL_PP0_INIT_DONE_DWLEN (1)
+union pp0_init_done_u {
+	struct pp0_init_done {
+		u32 done:1;              /* [00:00] Default:0x0 RO */
+		u32 rsv:31;              /* [31:01] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP0_INIT_DONE_DWLEN];
+} __packed;
+
+#define NBL_PP0_CFG_ERR_INFO_ADDR  (0xb14038)
+#define NBL_PP0_CFG_ERR_INFO_DEPTH (1)
+#define NBL_PP0_CFG_ERR_INFO_WIDTH (32)
+#define NBL_PP0_CFG_ERR_INFO_DWLEN (1)
+union pp0_cfg_err_info_u {
+	struct pp0_cfg_err_info {
+		u32 id:1;                /* [0:0] Default:0x0 RO */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP0_CFG_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_PP0_CIF_ERR_INFO_ADDR  (0xb14040)
+#define NBL_PP0_CIF_ERR_INFO_DEPTH (1)
+#define NBL_PP0_CIF_ERR_INFO_WIDTH (32)
+#define NBL_PP0_CIF_ERR_INFO_DWLEN (1)
+union pp0_cif_err_info_u {
+	struct pp0_cif_err_info {
+		u32 addr:30;             /* [29:00] Default:0x0 RO */
+		u32 wr_err:1;            /* [30:30] Default:0x0 RO */
+		u32 ucor_err:1;          /* [31:31] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP0_CIF_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_PP0_CAR_CTRL_ADDR  (0xb14100)
+#define NBL_PP0_CAR_CTRL_DEPTH (1)
+#define NBL_PP0_CAR_CTRL_WIDTH (32)
+#define NBL_PP0_CAR_CTRL_DWLEN (1)
+union pp0_car_ctrl_u {
+	struct pp0_car_ctrl {
+		u32 sctr_car:1;          /* [00:00] Default:0x1 RW */
+		u32 rctr_car:1;          /* [01:01] Default:0x1 RW */
+		u32 rc_car:1;            /* [02:02] Default:0x1 RW */
+		u32 tbl_rc_car:1;        /* [03:03] Default:0x1 RW */
+		u32 rsv:28;              /* [31:04] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP0_CAR_CTRL_DWLEN];
+} __packed;
+
+#define NBL_PP0_MODE_ADDR  (0xb14104)
+#define NBL_PP0_MODE_DEPTH (1)
+#define NBL_PP0_MODE_WIDTH (32)
+#define NBL_PP0_MODE_DWLEN (1)
+union pp0_mode_u {
+	struct pp0_mode {
+		u32 bypass:1;            /* [0] Default:0x0 RW */
+		u32 internal_loopback_en:1; /* [1] Default:0x0 RW */
+		u32 rsv:30;              /* [31:2] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP0_MODE_DWLEN];
+} __packed;
+
+#define NBL_PP0_SET_FLAGS0_ADDR  (0xb14108)
+#define NBL_PP0_SET_FLAGS0_DEPTH (1)
+#define NBL_PP0_SET_FLAGS0_WIDTH (32)
+#define NBL_PP0_SET_FLAGS0_DWLEN (1)
+union pp0_set_flags0_u {
+	struct pp0_set_flags0 {
+		u32 data:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP0_SET_FLAGS0_DWLEN];
+} __packed;
+
+#define NBL_PP0_SET_FLAGS1_ADDR  (0xb1410c)
+#define NBL_PP0_SET_FLAGS1_DEPTH (1)
+#define NBL_PP0_SET_FLAGS1_WIDTH (32)
+#define NBL_PP0_SET_FLAGS1_DWLEN (1)
+union pp0_set_flags1_u {
+	struct pp0_set_flags1 {
+		u32 data:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP0_SET_FLAGS1_DWLEN];
+} __packed;
+
+#define NBL_PP0_CLEAR_FLAGS0_ADDR  (0xb14110)
+#define NBL_PP0_CLEAR_FLAGS0_DEPTH (1)
+#define NBL_PP0_CLEAR_FLAGS0_WIDTH (32)
+#define NBL_PP0_CLEAR_FLAGS0_DWLEN (1)
+union pp0_clear_flags0_u {
+	struct pp0_clear_flags0 {
+		u32 data:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP0_CLEAR_FLAGS0_DWLEN];
+} __packed;
+
+#define NBL_PP0_CLEAR_FLAGS1_ADDR  (0xb14114)
+#define NBL_PP0_CLEAR_FLAGS1_DEPTH (1)
+#define NBL_PP0_CLEAR_FLAGS1_WIDTH (32)
+#define NBL_PP0_CLEAR_FLAGS1_DWLEN (1)
+union pp0_clear_flags1_u {
+	struct pp0_clear_flags1 {
+		u32 data:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP0_CLEAR_FLAGS1_DWLEN];
+} __packed;
+
+#define NBL_PP0_ACTION_PRIORITY0_ADDR  (0xb14118)
+#define NBL_PP0_ACTION_PRIORITY0_DEPTH (1)
+#define NBL_PP0_ACTION_PRIORITY0_WIDTH (32)
+#define NBL_PP0_ACTION_PRIORITY0_DWLEN (1)
+union pp0_action_priority0_u {
+	struct pp0_action_priority0 {
+		u32 action_id3_pri:2;    /* [01:00] Default:0x0 RW */
+		u32 action_id4_pri:2;    /* [03:02] Default:0x0 RW */
+		u32 action_id5_pri:2;    /* [05:04] Default:0x0 RW */
+		u32 action_id6_pri:2;    /* [07:06] Default:0x0 RW */
+		u32 action_id7_pri:2;    /* [09:08] Default:0x0 RW */
+		u32 action_id8_pri:2;    /* [11:10] Default:0x0 RW */
+		u32 action_id9_pri:2;    /* [13:12] Default:0x0 RW */
+		u32 action_id10_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id11_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id12_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id13_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id14_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 action_id15_pri:2;   /* [25:24] Default:0x0 RW */
+		u32 action_id16_pri:2;   /* [27:26] Default:0x0 RW */
+		u32 action_id17_pri:2;   /* [29:28] Default:0x0 RW */
+		u32 action_id18_pri:2;   /* [31:30] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP0_ACTION_PRIORITY0_DWLEN];
+} __packed;
+
+#define NBL_PP0_ACTION_PRIORITY1_ADDR  (0xb1411c)
+#define NBL_PP0_ACTION_PRIORITY1_DEPTH (1)
+#define NBL_PP0_ACTION_PRIORITY1_WIDTH (32)
+#define NBL_PP0_ACTION_PRIORITY1_DWLEN (1)
+union pp0_action_priority1_u {
+	struct pp0_action_priority1 {
+		u32 action_id19_pri:2;   /* [01:00] Default:0x0 RW */
+		u32 action_id20_pri:2;   /* [03:02] Default:0x0 RW */
+		u32 action_id21_pri:2;   /* [05:04] Default:0x0 RW */
+		u32 action_id22_pri:2;   /* [07:06] Default:0x0 RW */
+		u32 action_id23_pri:2;   /* [09:08] Default:0x0 RW */
+		u32 action_id24_pri:2;   /* [11:10] Default:0x0 RW */
+		u32 action_id25_pri:2;   /* [13:12] Default:0x0 RW */
+		u32 action_id26_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id27_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id28_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id29_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id30_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 action_id31_pri:2;   /* [25:24] Default:0x0 RW */
+		u32 action_id32_pri:2;   /* [27:26] Default:0x0 RW */
+		u32 action_id33_pri:2;   /* [29:28] Default:0x0 RW */
+		u32 action_id34_pri:2;   /* [31:30] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP0_ACTION_PRIORITY1_DWLEN];
+} __packed;
+
+#define NBL_PP0_ACTION_PRIORITY2_ADDR  (0xb14120)
+#define NBL_PP0_ACTION_PRIORITY2_DEPTH (1)
+#define NBL_PP0_ACTION_PRIORITY2_WIDTH (32)
+#define NBL_PP0_ACTION_PRIORITY2_DWLEN (1)
+union pp0_action_priority2_u {
+	struct pp0_action_priority2 {
+		u32 action_id35_pri:2;   /* [01:00] Default:0x0 RW */
+		u32 action_id36_pri:2;   /* [03:02] Default:0x0 RW */
+		u32 action_id37_pri:2;   /* [05:04] Default:0x0 RW */
+		u32 action_id38_pri:2;   /* [07:06] Default:0x0 RW */
+		u32 action_id39_pri:2;   /* [09:08] Default:0x0 RW */
+		u32 action_id40_pri:2;   /* [11:10] Default:0x0 RW */
+		u32 action_id41_pri:2;   /* [13:12] Default:0x0 RW */
+		u32 action_id42_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id43_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id44_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id45_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id46_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 action_id47_pri:2;   /* [25:24] Default:0x0 RW */
+		u32 action_id48_pri:2;   /* [27:26] Default:0x0 RW */
+		u32 action_id49_pri:2;   /* [29:28] Default:0x0 RW */
+		u32 action_id50_pri:2;   /* [31:30] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP0_ACTION_PRIORITY2_DWLEN];
+} __packed;
+
+#define NBL_PP0_ACTION_PRIORITY3_ADDR  (0xb14124)
+#define NBL_PP0_ACTION_PRIORITY3_DEPTH (1)
+#define NBL_PP0_ACTION_PRIORITY3_WIDTH (32)
+#define NBL_PP0_ACTION_PRIORITY3_DWLEN (1)
+union pp0_action_priority3_u {
+	struct pp0_action_priority3 {
+		u32 action_id51_pri:2;   /* [01:00] Default:0x0 RW */
+		u32 action_id52_pri:2;   /* [03:02] Default:0x0 RW */
+		u32 action_id53_pri:2;   /* [05:04] Default:0x0 RW */
+		u32 action_id54_pri:2;   /* [07:06] Default:0x0 RW */
+		u32 action_id55_pri:2;   /* [09:08] Default:0x0 RW */
+		u32 action_id56_pri:2;   /* [11:10] Default:0x0 RW */
+		u32 action_id57_pri:2;   /* [13:12] Default:0x0 RW */
+		u32 action_id58_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id59_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id60_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id61_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id62_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 rsv:8;               /* [31:24] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP0_ACTION_PRIORITY3_DWLEN];
+} __packed;
+
+#define NBL_PP0_ACTION_PRIORITY4_ADDR  (0xb14128)
+#define NBL_PP0_ACTION_PRIORITY4_DEPTH (1)
+#define NBL_PP0_ACTION_PRIORITY4_WIDTH (32)
+#define NBL_PP0_ACTION_PRIORITY4_DWLEN (1)
+union pp0_action_priority4_u {
+	struct pp0_action_priority4 {
+		u32 action_id3_pri:2;    /* [01:00] Default:0x0 RW */
+		u32 action_id4_pri:2;    /* [03:02] Default:0x0 RW */
+		u32 action_id5_pri:2;    /* [05:04] Default:0x0 RW */
+		u32 action_id6_pri:2;    /* [07:06] Default:0x0 RW */
+		u32 action_id7_pri:2;    /* [09:08] Default:0x0 RW */
+		u32 action_id8_pri:2;    /* [11:10] Default:0x0 RW */
+		u32 action_id9_pri:2;    /* [13:12] Default:0x0 RW */
+		u32 action_id10_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id11_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id12_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id13_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id14_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 action_id15_pri:2;   /* [25:24] Default:0x0 RW */
+		u32 action_id16_pri:2;   /* [27:26] Default:0x0 RW */
+		u32 action_id17_pri:2;   /* [29:28] Default:0x0 RW */
+		u32 action_id18_pri:2;   /* [31:30] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP0_ACTION_PRIORITY4_DWLEN];
+} __packed;
+
+#define NBL_PP0_ACTION_PRIORITY5_ADDR  (0xb1412c)
+#define NBL_PP0_ACTION_PRIORITY5_DEPTH (1)
+#define NBL_PP0_ACTION_PRIORITY5_WIDTH (32)
+#define NBL_PP0_ACTION_PRIORITY5_DWLEN (1)
+union pp0_action_priority5_u {
+	struct pp0_action_priority5 {
+		u32 action_id19_pri:2;   /* [01:00] Default:0x0 RW */
+		u32 action_id20_pri:2;   /* [03:02] Default:0x0 RW */
+		u32 action_id21_pri:2;   /* [05:04] Default:0x0 RW */
+		u32 action_id22_pri:2;   /* [07:06] Default:0x0 RW */
+		u32 action_id23_pri:2;   /* [09:08] Default:0x0 RW */
+		u32 action_id24_pri:2;   /* [11:10] Default:0x0 RW */
+		u32 action_id25_pri:2;   /* [13:12] Default:0x0 RW */
+		u32 action_id26_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id27_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id28_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id29_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id30_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 action_id31_pri:2;   /* [25:24] Default:0x0 RW */
+		u32 action_id32_pri:2;   /* [27:26] Default:0x0 RW */
+		u32 action_id33_pri:2;   /* [29:28] Default:0x0 RW */
+		u32 action_id34_pri:2;   /* [31:30] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP0_ACTION_PRIORITY5_DWLEN];
+} __packed;
+
+#define NBL_PP0_ACTION_PRIORITY6_ADDR  (0xb14130)
+#define NBL_PP0_ACTION_PRIORITY6_DEPTH (1)
+#define NBL_PP0_ACTION_PRIORITY6_WIDTH (32)
+#define NBL_PP0_ACTION_PRIORITY6_DWLEN (1)
+union pp0_action_priority6_u {
+	struct pp0_action_priority6 {
+		u32 action_id35_pri:2;   /* [01:00] Default:0x0 RW */
+		u32 action_id36_pri:2;   /* [03:02] Default:0x0 RW */
+		u32 action_id37_pri:2;   /* [05:04] Default:0x0 RW */
+		u32 action_id38_pri:2;   /* [07:06] Default:0x0 RW */
+		u32 action_id39_pri:2;   /* [09:08] Default:0x0 RW */
+		u32 action_id40_pri:2;   /* [11:10] Default:0x0 RW */
+		u32 action_id41_pri:2;   /* [13:12] Default:0x0 RW */
+		u32 action_id42_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id43_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id44_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id45_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id46_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 action_id47_pri:2;   /* [25:24] Default:0x0 RW */
+		u32 action_id48_pri:2;   /* [27:26] Default:0x0 RW */
+		u32 action_id49_pri:2;   /* [29:28] Default:0x0 RW */
+		u32 action_id50_pri:2;   /* [31:30] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP0_ACTION_PRIORITY6_DWLEN];
+} __packed;
+
+#define NBL_PP0_ACTION_PRIORITY7_ADDR  (0xb14134)
+#define NBL_PP0_ACTION_PRIORITY7_DEPTH (1)
+#define NBL_PP0_ACTION_PRIORITY7_WIDTH (32)
+#define NBL_PP0_ACTION_PRIORITY7_DWLEN (1)
+union pp0_action_priority7_u {
+	struct pp0_action_priority7 {
+		u32 action_id51_pri:2;   /* [01:00] Default:0x0 RW */
+		u32 action_id52_pri:2;   /* [03:02] Default:0x0 RW */
+		u32 action_id53_pri:2;   /* [05:04] Default:0x0 RW */
+		u32 action_id54_pri:2;   /* [07:06] Default:0x0 RW */
+		u32 action_id55_pri:2;   /* [09:08] Default:0x0 RW */
+		u32 action_id56_pri:2;   /* [11:10] Default:0x0 RW */
+		u32 action_id57_pri:2;   /* [13:12] Default:0x0 RW */
+		u32 action_id58_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id59_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id60_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id61_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id62_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 rsv:8;               /* [31:24] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP0_ACTION_PRIORITY7_DWLEN];
+} __packed;
+
+#define NBL_PP0_CPU_ACCESS_ADDR  (0xb1416c)
+#define NBL_PP0_CPU_ACCESS_DEPTH (1)
+#define NBL_PP0_CPU_ACCESS_WIDTH (32)
+#define NBL_PP0_CPU_ACCESS_DWLEN (1)
+union pp0_cpu_access_u {
+	struct pp0_cpu_access {
+		u32 bp_th:10;            /* [9:0] Default:0x34 RW */
+		u32 rsv1:6;              /* [15:10] Default:0x0 RO */
+		u32 timeout_th:10;       /* [25:16] Default:0x100 RW */
+		u32 rsv:6;               /* [31:26] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP0_CPU_ACCESS_DWLEN];
+} __packed;
+
+#define NBL_PP0_RDMA_BYPASS_ADDR  (0xb14170)
+#define NBL_PP0_RDMA_BYPASS_DEPTH (1)
+#define NBL_PP0_RDMA_BYPASS_WIDTH (32)
+#define NBL_PP0_RDMA_BYPASS_DWLEN (1)
+union pp0_rdma_bypass_u {
+	struct pp0_rdma_bypass {
+		u32 rdma_flag_offset:5;  /* [4:0] Default:0x0 RW */
+		u32 dn_bypass_en:1;      /* [5] Default:0x0 RW */
+		u32 up_bypass_en:1;      /* [6] Default:0x0 RW */
+		u32 rsv1:1;              /* [7] Default:0x0 RO */
+		u32 dir_flag_offset:5;   /* [12:8] Default:0x0 RW */
+		u32 rsv:19;              /* [31:13] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP0_RDMA_BYPASS_DWLEN];
+} __packed;
+
+#define NBL_PP0_INIT_START_ADDR  (0xb141fc)
+#define NBL_PP0_INIT_START_DEPTH (1)
+#define NBL_PP0_INIT_START_WIDTH (32)
+#define NBL_PP0_INIT_START_DWLEN (1)
+union pp0_init_start_u {
+	struct pp0_init_start {
+		u32 en:1;                /* [0] Default:0x0 WO */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP0_INIT_START_DWLEN];
+} __packed;
+
+#define NBL_PP0_BP_SET_ADDR  (0xb14200)
+#define NBL_PP0_BP_SET_DEPTH (1)
+#define NBL_PP0_BP_SET_WIDTH (32)
+#define NBL_PP0_BP_SET_DWLEN (1)
+union pp0_bp_set_u {
+	struct pp0_bp_set {
+		u32 pp_up:1;             /* [00:00] Default:0x0 RW */
+		u32 rsv:31;              /* [31:01] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP0_BP_SET_DWLEN];
+} __packed;
+
+#define NBL_PP0_BP_MASK_ADDR  (0xb14204)
+#define NBL_PP0_BP_MASK_DEPTH (1)
+#define NBL_PP0_BP_MASK_WIDTH (32)
+#define NBL_PP0_BP_MASK_DWLEN (1)
+union pp0_bp_mask_u {
+	struct pp0_bp_mask {
+		u32 dn_pp:1;             /* [00:00] Default:0x0 RW */
+		u32 fem_pp:1;            /* [01:01] Default:0x0 RW */
+		u32 rsv:30;              /* [31:02] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP0_BP_MASK_DWLEN];
+} __packed;
+
+#define NBL_PP0_BP_STATE_ADDR  (0xb14308)
+#define NBL_PP0_BP_STATE_DEPTH (1)
+#define NBL_PP0_BP_STATE_WIDTH (32)
+#define NBL_PP0_BP_STATE_DWLEN (1)
+union pp0_bp_state_u {
+	struct pp0_bp_state {
+		u32 dn_pp_bp:1;          /* [00:00] Default:0x0 RO */
+		u32 fem_pp_bp:1;         /* [01:01] Default:0x0 RO */
+		u32 pp_up_bp:1;          /* [02:02] Default:0x0 RO */
+		u32 inter_pp_bp:1;       /* [03:03] Default:0x0 RO */
+		u32 rsv:28;              /* [31:04] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP0_BP_STATE_DWLEN];
+} __packed;
+
+#define NBL_PP0_BP_HISTORY_ADDR  (0xb1430c)
+#define NBL_PP0_BP_HISTORY_DEPTH (1)
+#define NBL_PP0_BP_HISTORY_WIDTH (32)
+#define NBL_PP0_BP_HISTORY_DWLEN (1)
+union pp0_bp_history_u {
+	struct pp0_bp_history {
+		u32 dn_pp_bp:1;          /* [00:00] Default:0x0 RC */
+		u32 fem_pp_bp:1;         /* [01:01] Default:0x0 RC */
+		u32 pp_up_bp:1;          /* [02:02] Default:0x0 RC */
+		u32 inter_pp_bp:1;       /* [03:03] Default:0x0 RC */
+		u32 rsv:28;              /* [31:04] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP0_BP_HISTORY_DWLEN];
+} __packed;
+
+#define NBL_PP0_CFG_TEST_ADDR  (0xb1442c)
+#define NBL_PP0_CFG_TEST_DEPTH (1)
+#define NBL_PP0_CFG_TEST_WIDTH (32)
+#define NBL_PP0_CFG_TEST_DWLEN (1)
+union pp0_cfg_test_u {
+	struct pp0_cfg_test {
+		u32 test:32;             /* [31:00] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP0_CFG_TEST_DWLEN];
+} __packed;
+
+#define NBL_PP0_ABNORMAL_ACTION0_ADDR  (0xb14430)
+#define NBL_PP0_ABNORMAL_ACTION0_DEPTH (1)
+#define NBL_PP0_ABNORMAL_ACTION0_WIDTH (32)
+#define NBL_PP0_ABNORMAL_ACTION0_DWLEN (1)
+union pp0_abnormal_action0_u {
+	struct pp0_abnormal_action0 {
+		u32 data:22;             /* [21:00] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP0_ABNORMAL_ACTION0_DWLEN];
+} __packed;
+
+#define NBL_PP0_ABNORMAL_ACTION1_ADDR  (0xb14434)
+#define NBL_PP0_ABNORMAL_ACTION1_DEPTH (1)
+#define NBL_PP0_ABNORMAL_ACTION1_WIDTH (32)
+#define NBL_PP0_ABNORMAL_ACTION1_DWLEN (1)
+union pp0_abnormal_action1_u {
+	struct pp0_abnormal_action1 {
+		u32 data:22;             /* [21:00] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP0_ABNORMAL_ACTION1_DWLEN];
+} __packed;
+
+#define NBL_PP0_ABNORMAL_ACTION2_ADDR  (0xb14438)
+#define NBL_PP0_ABNORMAL_ACTION2_DEPTH (1)
+#define NBL_PP0_ABNORMAL_ACTION2_WIDTH (32)
+#define NBL_PP0_ABNORMAL_ACTION2_DWLEN (1)
+union pp0_abnormal_action2_u {
+	struct pp0_abnormal_action2 {
+		u32 data:22;             /* [21:00] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP0_ABNORMAL_ACTION2_DWLEN];
+} __packed;
+
+#define NBL_PP0_ABNORMAL_ACTION3_ADDR  (0xb1443c)
+#define NBL_PP0_ABNORMAL_ACTION3_DEPTH (1)
+#define NBL_PP0_ABNORMAL_ACTION3_WIDTH (32)
+#define NBL_PP0_ABNORMAL_ACTION3_DWLEN (1)
+union pp0_abnormal_action3_u {
+	struct pp0_abnormal_action3 {
+		u32 data:22;             /* [21:00] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP0_ABNORMAL_ACTION3_DWLEN];
+} __packed;
+
+#define NBL_PP0_ABNORMAL_ACTION4_ADDR  (0xb14440)
+#define NBL_PP0_ABNORMAL_ACTION4_DEPTH (1)
+#define NBL_PP0_ABNORMAL_ACTION4_WIDTH (32)
+#define NBL_PP0_ABNORMAL_ACTION4_DWLEN (1)
+union pp0_abnormal_action4_u {
+	struct pp0_abnormal_action4 {
+		u32 data:22;             /* [21:00] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP0_ABNORMAL_ACTION4_DWLEN];
+} __packed;
+
+#define NBL_PP0_ABNORMAL_ACTION5_ADDR  (0xb14444)
+#define NBL_PP0_ABNORMAL_ACTION5_DEPTH (1)
+#define NBL_PP0_ABNORMAL_ACTION5_WIDTH (32)
+#define NBL_PP0_ABNORMAL_ACTION5_DWLEN (1)
+union pp0_abnormal_action5_u {
+	struct pp0_abnormal_action5 {
+		u32 data:22;             /* [21:00] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP0_ABNORMAL_ACTION5_DWLEN];
+} __packed;
+
+#define NBL_PP0_ABNORMAL_ACTION6_ADDR  (0xb14448)
+#define NBL_PP0_ABNORMAL_ACTION6_DEPTH (1)
+#define NBL_PP0_ABNORMAL_ACTION6_WIDTH (32)
+#define NBL_PP0_ABNORMAL_ACTION6_DWLEN (1)
+union pp0_abnormal_action6_u {
+	struct pp0_abnormal_action6 {
+		u32 data:22;             /* [21:00] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP0_ABNORMAL_ACTION6_DWLEN];
+} __packed;
+
+#define NBL_PP0_ABNORMAL_ACTION7_ADDR  (0xb1444c)
+#define NBL_PP0_ABNORMAL_ACTION7_DEPTH (1)
+#define NBL_PP0_ABNORMAL_ACTION7_WIDTH (32)
+#define NBL_PP0_ABNORMAL_ACTION7_DWLEN (1)
+union pp0_abnormal_action7_u {
+	struct pp0_abnormal_action7 {
+		u32 data:22;             /* [21:00] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP0_ABNORMAL_ACTION7_DWLEN];
+} __packed;
+
+#define NBL_PP0_FWD_DPORT_ACTION_ADDR  (0xb14450)
+#define NBL_PP0_FWD_DPORT_ACTION_DEPTH (1)
+#define NBL_PP0_FWD_DPORT_ACTION_WIDTH (32)
+#define NBL_PP0_FWD_DPORT_ACTION_DWLEN (1)
+union pp0_fwd_dport_action_u {
+	struct pp0_fwd_dport_action {
+		u32 action_id:6;         /* [05:00] Default:0x9 RW */
+		u32 rsv:26;              /* [31:06] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP0_FWD_DPORT_ACTION_DWLEN];
+} __packed;
+
+#define NBL_PP0_RDMA_VSI_BTM_ADDR  (0xb14454)
+#define NBL_PP0_RDMA_VSI_BTM_DEPTH (32)
+#define NBL_PP0_RDMA_VSI_BTM_WIDTH (32)
+#define NBL_PP0_RDMA_VSI_BTM_DWLEN (1)
+union pp0_rdma_vsi_btm_u {
+	struct pp0_rdma_vsi_btm {
+		u32 btm:32;              /* [31:00] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP0_RDMA_VSI_BTM_DWLEN];
+} __packed;
+#define NBL_PP0_RDMA_VSI_BTM_REG(r) (NBL_PP0_RDMA_VSI_BTM_ADDR + \
+		(NBL_PP0_RDMA_VSI_BTM_DWLEN * 4) * (r))
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_pp1.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_pp1.h
new file mode 100644
index 000000000000..c4afc93b2a21
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_pp1.h
@@ -0,0 +1,701 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+// Code generated by interstellar. DO NOT EDIT.
+// Compatible with leonis RTL tag 0710
+
+#ifndef NBL_PP1_H
+#define NBL_PP1_H 1
+
+#include <linux/types.h>
+
+#define NBL_PP1_BASE (0x00B24000)
+
+#define NBL_PP1_INT_STATUS_ADDR  (0xb24000)
+#define NBL_PP1_INT_STATUS_DEPTH (1)
+#define NBL_PP1_INT_STATUS_WIDTH (32)
+#define NBL_PP1_INT_STATUS_DWLEN (1)
+union pp1_int_status_u {
+	struct pp1_int_status {
+		u32 rsv5:1;              /* [00:00] Default:0x0 RO */
+		u32 fifo_uflw_err:1;     /* [01:01] Default:0x0 RWC */
+		u32 fifo_dflw_err:1;     /* [02:02] Default:0x0 RWC */
+		u32 rsv4:1;              /* [03:03] Default:0x0 RO */
+		u32 cif_err:1;           /* [04:04] Default:0x0 RWC */
+		u32 rsv3:1;              /* [05:05] Default:0x0 RO */
+		u32 cfg_err:1;           /* [06:06] Default:0x0 RWC */
+		u32 data_ucor_err:1;     /* [07:07] Default:0x0 RWC */
+		u32 rsv2:1;              /* [08:08] Default:0x0 RO */
+		u32 rsv1:1;              /* [09:09] Default:0x0 RO */
+		u32 rsv:22;              /* [31:10] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP1_INT_STATUS_DWLEN];
+} __packed;
+
+#define NBL_PP1_INT_MASK_ADDR  (0xb24004)
+#define NBL_PP1_INT_MASK_DEPTH (1)
+#define NBL_PP1_INT_MASK_WIDTH (32)
+#define NBL_PP1_INT_MASK_DWLEN (1)
+union pp1_int_mask_u {
+	struct pp1_int_mask {
+		u32 rsv5:1;              /* [00:00] Default:0x0 RO */
+		u32 fifo_uflw_err:1;     /* [01:01] Default:0x0 RW */
+		u32 fifo_dflw_err:1;     /* [02:02] Default:0x0 RW */
+		u32 rsv4:1;              /* [03:03] Default:0x0 RO */
+		u32 cif_err:1;           /* [04:04] Default:0x0 RW */
+		u32 rsv3:1;              /* [05:05] Default:0x0 RO */
+		u32 cfg_err:1;           /* [06:06] Default:0x0 RW */
+		u32 data_ucor_err:1;     /* [07:07] Default:0x0 RW */
+		u32 rsv2:1;              /* [08:08] Default:0x0 RO */
+		u32 rsv1:1;              /* [09:09] Default:0x0 RO */
+		u32 rsv:22;              /* [31:10] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP1_INT_MASK_DWLEN];
+} __packed;
+
+#define NBL_PP1_INT_SET_ADDR  (0xb24008)
+#define NBL_PP1_INT_SET_DEPTH (1)
+#define NBL_PP1_INT_SET_WIDTH (32)
+#define NBL_PP1_INT_SET_DWLEN (1)
+union pp1_int_set_u {
+	struct pp1_int_set {
+		u32 rsv5:1;              /* [00:00] Default:0x0 RO */
+		u32 fifo_uflw_err:1;     /* [01:01] Default:0x0 WO */
+		u32 fifo_dflw_err:1;     /* [02:02] Default:0x0 WO */
+		u32 rsv4:1;              /* [03:03] Default:0x0 RO */
+		u32 cif_err:1;           /* [04:04] Default:0x0 WO */
+		u32 rsv3:1;              /* [05:05] Default:0x0 RO */
+		u32 cfg_err:1;           /* [06:06] Default:0x0 WO */
+		u32 data_ucor_err:1;     /* [07:07] Default:0x0 WO */
+		u32 rsv2:1;              /* [08:08] Default:0x0 RO */
+		u32 rsv1:1;              /* [09:09] Default:0x0 RO */
+		u32 rsv:22;              /* [31:10] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP1_INT_SET_DWLEN];
+} __packed;
+
+#define NBL_PP1_INIT_DONE_ADDR  (0xb2400c)
+#define NBL_PP1_INIT_DONE_DEPTH (1)
+#define NBL_PP1_INIT_DONE_WIDTH (32)
+#define NBL_PP1_INIT_DONE_DWLEN (1)
+union pp1_init_done_u {
+	struct pp1_init_done {
+		u32 done:1;              /* [00:00] Default:0x0 RO */
+		u32 rsv:31;              /* [31:01] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP1_INIT_DONE_DWLEN];
+} __packed;
+
+#define NBL_PP1_CFG_ERR_INFO_ADDR  (0xb24038)
+#define NBL_PP1_CFG_ERR_INFO_DEPTH (1)
+#define NBL_PP1_CFG_ERR_INFO_WIDTH (32)
+#define NBL_PP1_CFG_ERR_INFO_DWLEN (1)
+union pp1_cfg_err_info_u {
+	struct pp1_cfg_err_info {
+		u32 id:1;                /* [0:0] Default:0x0 RO */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP1_CFG_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_PP1_CIF_ERR_INFO_ADDR  (0xb24040)
+#define NBL_PP1_CIF_ERR_INFO_DEPTH (1)
+#define NBL_PP1_CIF_ERR_INFO_WIDTH (32)
+#define NBL_PP1_CIF_ERR_INFO_DWLEN (1)
+union pp1_cif_err_info_u {
+	struct pp1_cif_err_info {
+		u32 addr:30;             /* [29:00] Default:0x0 RO */
+		u32 wr_err:1;            /* [30:30] Default:0x0 RO */
+		u32 ucor_err:1;          /* [31:31] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP1_CIF_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_PP1_CAR_CTRL_ADDR  (0xb24100)
+#define NBL_PP1_CAR_CTRL_DEPTH (1)
+#define NBL_PP1_CAR_CTRL_WIDTH (32)
+#define NBL_PP1_CAR_CTRL_DWLEN (1)
+union pp1_car_ctrl_u {
+	struct pp1_car_ctrl {
+		u32 sctr_car:1;          /* [00:00] Default:0x1 RW */
+		u32 rctr_car:1;          /* [01:01] Default:0x1 RW */
+		u32 rc_car:1;            /* [02:02] Default:0x1 RW */
+		u32 tbl_rc_car:1;        /* [03:03] Default:0x1 RW */
+		u32 rsv:28;              /* [31:04] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP1_CAR_CTRL_DWLEN];
+} __packed;
+
+#define NBL_PP1_MODE_ADDR  (0xb24104)
+#define NBL_PP1_MODE_DEPTH (1)
+#define NBL_PP1_MODE_WIDTH (32)
+#define NBL_PP1_MODE_DWLEN (1)
+union pp1_mode_u {
+	struct pp1_mode {
+		u32 bypass:1;            /* [0] Default:0x0 RW */
+		u32 internal_loopback_en:1; /* [1] Default:0x0 RW */
+		u32 rsv:30;              /* [31:2] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP1_MODE_DWLEN];
+} __packed;
+
+#define NBL_PP1_SET_FLAGS0_ADDR  (0xb24108)
+#define NBL_PP1_SET_FLAGS0_DEPTH (1)
+#define NBL_PP1_SET_FLAGS0_WIDTH (32)
+#define NBL_PP1_SET_FLAGS0_DWLEN (1)
+union pp1_set_flags0_u {
+	struct pp1_set_flags0 {
+		u32 data:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP1_SET_FLAGS0_DWLEN];
+} __packed;
+
+#define NBL_PP1_SET_FLAGS1_ADDR  (0xb2410c)
+#define NBL_PP1_SET_FLAGS1_DEPTH (1)
+#define NBL_PP1_SET_FLAGS1_WIDTH (32)
+#define NBL_PP1_SET_FLAGS1_DWLEN (1)
+union pp1_set_flags1_u {
+	struct pp1_set_flags1 {
+		u32 data:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP1_SET_FLAGS1_DWLEN];
+} __packed;
+
+#define NBL_PP1_CLEAR_FLAGS0_ADDR  (0xb24110)
+#define NBL_PP1_CLEAR_FLAGS0_DEPTH (1)
+#define NBL_PP1_CLEAR_FLAGS0_WIDTH (32)
+#define NBL_PP1_CLEAR_FLAGS0_DWLEN (1)
+union pp1_clear_flags0_u {
+	struct pp1_clear_flags0 {
+		u32 data:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP1_CLEAR_FLAGS0_DWLEN];
+} __packed;
+
+#define NBL_PP1_CLEAR_FLAGS1_ADDR  (0xb24114)
+#define NBL_PP1_CLEAR_FLAGS1_DEPTH (1)
+#define NBL_PP1_CLEAR_FLAGS1_WIDTH (32)
+#define NBL_PP1_CLEAR_FLAGS1_DWLEN (1)
+union pp1_clear_flags1_u {
+	struct pp1_clear_flags1 {
+		u32 data:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP1_CLEAR_FLAGS1_DWLEN];
+} __packed;
+
+#define NBL_PP1_ACTION_PRIORITY0_ADDR  (0xb24118)
+#define NBL_PP1_ACTION_PRIORITY0_DEPTH (1)
+#define NBL_PP1_ACTION_PRIORITY0_WIDTH (32)
+#define NBL_PP1_ACTION_PRIORITY0_DWLEN (1)
+union pp1_action_priority0_u {
+	struct pp1_action_priority0 {
+		u32 action_id3_pri:2;    /* [01:00] Default:0x0 RW */
+		u32 action_id4_pri:2;    /* [03:02] Default:0x0 RW */
+		u32 action_id5_pri:2;    /* [05:04] Default:0x0 RW */
+		u32 action_id6_pri:2;    /* [07:06] Default:0x0 RW */
+		u32 action_id7_pri:2;    /* [09:08] Default:0x0 RW */
+		u32 action_id8_pri:2;    /* [11:10] Default:0x0 RW */
+		u32 action_id9_pri:2;    /* [13:12] Default:0x0 RW */
+		u32 action_id10_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id11_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id12_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id13_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id14_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 action_id15_pri:2;   /* [25:24] Default:0x0 RW */
+		u32 action_id16_pri:2;   /* [27:26] Default:0x0 RW */
+		u32 action_id17_pri:2;   /* [29:28] Default:0x0 RW */
+		u32 action_id18_pri:2;   /* [31:30] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP1_ACTION_PRIORITY0_DWLEN];
+} __packed;
+
+#define NBL_PP1_ACTION_PRIORITY1_ADDR  (0xb2411c)
+#define NBL_PP1_ACTION_PRIORITY1_DEPTH (1)
+#define NBL_PP1_ACTION_PRIORITY1_WIDTH (32)
+#define NBL_PP1_ACTION_PRIORITY1_DWLEN (1)
+union pp1_action_priority1_u {
+	struct pp1_action_priority1 {
+		u32 action_id19_pri:2;   /* [01:00] Default:0x0 RW */
+		u32 action_id20_pri:2;   /* [03:02] Default:0x0 RW */
+		u32 action_id21_pri:2;   /* [05:04] Default:0x0 RW */
+		u32 action_id22_pri:2;   /* [07:06] Default:0x0 RW */
+		u32 action_id23_pri:2;   /* [09:08] Default:0x0 RW */
+		u32 action_id24_pri:2;   /* [11:10] Default:0x0 RW */
+		u32 action_id25_pri:2;   /* [13:12] Default:0x0 RW */
+		u32 action_id26_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id27_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id28_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id29_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id30_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 action_id31_pri:2;   /* [25:24] Default:0x0 RW */
+		u32 action_id32_pri:2;   /* [27:26] Default:0x0 RW */
+		u32 action_id33_pri:2;   /* [29:28] Default:0x0 RW */
+		u32 action_id34_pri:2;   /* [31:30] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP1_ACTION_PRIORITY1_DWLEN];
+} __packed;
+
+#define NBL_PP1_ACTION_PRIORITY2_ADDR  (0xb24120)
+#define NBL_PP1_ACTION_PRIORITY2_DEPTH (1)
+#define NBL_PP1_ACTION_PRIORITY2_WIDTH (32)
+#define NBL_PP1_ACTION_PRIORITY2_DWLEN (1)
+union pp1_action_priority2_u {
+	struct pp1_action_priority2 {
+		u32 action_id35_pri:2;   /* [01:00] Default:0x0 RW */
+		u32 action_id36_pri:2;   /* [03:02] Default:0x0 RW */
+		u32 action_id37_pri:2;   /* [05:04] Default:0x0 RW */
+		u32 action_id38_pri:2;   /* [07:06] Default:0x0 RW */
+		u32 action_id39_pri:2;   /* [09:08] Default:0x0 RW */
+		u32 action_id40_pri:2;   /* [11:10] Default:0x0 RW */
+		u32 action_id41_pri:2;   /* [13:12] Default:0x0 RW */
+		u32 action_id42_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id43_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id44_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id45_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id46_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 action_id47_pri:2;   /* [25:24] Default:0x0 RW */
+		u32 action_id48_pri:2;   /* [27:26] Default:0x0 RW */
+		u32 action_id49_pri:2;   /* [29:28] Default:0x0 RW */
+		u32 action_id50_pri:2;   /* [31:30] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP1_ACTION_PRIORITY2_DWLEN];
+} __packed;
+
+#define NBL_PP1_ACTION_PRIORITY3_ADDR  (0xb24124)
+#define NBL_PP1_ACTION_PRIORITY3_DEPTH (1)
+#define NBL_PP1_ACTION_PRIORITY3_WIDTH (32)
+#define NBL_PP1_ACTION_PRIORITY3_DWLEN (1)
+union pp1_action_priority3_u {
+	struct pp1_action_priority3 {
+		u32 action_id51_pri:2;   /* [01:00] Default:0x0 RW */
+		u32 action_id52_pri:2;   /* [03:02] Default:0x0 RW */
+		u32 action_id53_pri:2;   /* [05:04] Default:0x0 RW */
+		u32 action_id54_pri:2;   /* [07:06] Default:0x0 RW */
+		u32 action_id55_pri:2;   /* [09:08] Default:0x0 RW */
+		u32 action_id56_pri:2;   /* [11:10] Default:0x0 RW */
+		u32 action_id57_pri:2;   /* [13:12] Default:0x0 RW */
+		u32 action_id58_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id59_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id60_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id61_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id62_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 rsv:8;               /* [31:24] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP1_ACTION_PRIORITY3_DWLEN];
+} __packed;
+
+#define NBL_PP1_ACTION_PRIORITY4_ADDR  (0xb24128)
+#define NBL_PP1_ACTION_PRIORITY4_DEPTH (1)
+#define NBL_PP1_ACTION_PRIORITY4_WIDTH (32)
+#define NBL_PP1_ACTION_PRIORITY4_DWLEN (1)
+union pp1_action_priority4_u {
+	struct pp1_action_priority4 {
+		u32 action_id3_pri:2;    /* [01:00] Default:0x0 RW */
+		u32 action_id4_pri:2;    /* [03:02] Default:0x0 RW */
+		u32 action_id5_pri:2;    /* [05:04] Default:0x0 RW */
+		u32 action_id6_pri:2;    /* [07:06] Default:0x0 RW */
+		u32 action_id7_pri:2;    /* [09:08] Default:0x0 RW */
+		u32 action_id8_pri:2;    /* [11:10] Default:0x0 RW */
+		u32 action_id9_pri:2;    /* [13:12] Default:0x0 RW */
+		u32 action_id10_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id11_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id12_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id13_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id14_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 action_id15_pri:2;   /* [25:24] Default:0x0 RW */
+		u32 action_id16_pri:2;   /* [27:26] Default:0x0 RW */
+		u32 action_id17_pri:2;   /* [29:28] Default:0x0 RW */
+		u32 action_id18_pri:2;   /* [31:30] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP1_ACTION_PRIORITY4_DWLEN];
+} __packed;
+
+#define NBL_PP1_ACTION_PRIORITY5_ADDR  (0xb2412c)
+#define NBL_PP1_ACTION_PRIORITY5_DEPTH (1)
+#define NBL_PP1_ACTION_PRIORITY5_WIDTH (32)
+#define NBL_PP1_ACTION_PRIORITY5_DWLEN (1)
+union pp1_action_priority5_u {
+	struct pp1_action_priority5 {
+		u32 action_id19_pri:2;   /* [01:00] Default:0x0 RW */
+		u32 action_id20_pri:2;   /* [03:02] Default:0x0 RW */
+		u32 action_id21_pri:2;   /* [05:04] Default:0x0 RW */
+		u32 action_id22_pri:2;   /* [07:06] Default:0x0 RW */
+		u32 action_id23_pri:2;   /* [09:08] Default:0x0 RW */
+		u32 action_id24_pri:2;   /* [11:10] Default:0x0 RW */
+		u32 action_id25_pri:2;   /* [13:12] Default:0x0 RW */
+		u32 action_id26_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id27_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id28_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id29_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id30_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 action_id31_pri:2;   /* [25:24] Default:0x0 RW */
+		u32 action_id32_pri:2;   /* [27:26] Default:0x0 RW */
+		u32 action_id33_pri:2;   /* [29:28] Default:0x0 RW */
+		u32 action_id34_pri:2;   /* [31:30] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP1_ACTION_PRIORITY5_DWLEN];
+} __packed;
+
+#define NBL_PP1_ACTION_PRIORITY6_ADDR  (0xb24130)
+#define NBL_PP1_ACTION_PRIORITY6_DEPTH (1)
+#define NBL_PP1_ACTION_PRIORITY6_WIDTH (32)
+#define NBL_PP1_ACTION_PRIORITY6_DWLEN (1)
+union pp1_action_priority6_u {
+	struct pp1_action_priority6 {
+		u32 action_id35_pri:2;   /* [01:00] Default:0x0 RW */
+		u32 action_id36_pri:2;   /* [03:02] Default:0x0 RW */
+		u32 action_id37_pri:2;   /* [05:04] Default:0x0 RW */
+		u32 action_id38_pri:2;   /* [07:06] Default:0x0 RW */
+		u32 action_id39_pri:2;   /* [09:08] Default:0x0 RW */
+		u32 action_id40_pri:2;   /* [11:10] Default:0x0 RW */
+		u32 action_id41_pri:2;   /* [13:12] Default:0x0 RW */
+		u32 action_id42_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id43_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id44_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id45_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id46_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 action_id47_pri:2;   /* [25:24] Default:0x0 RW */
+		u32 action_id48_pri:2;   /* [27:26] Default:0x0 RW */
+		u32 action_id49_pri:2;   /* [29:28] Default:0x0 RW */
+		u32 action_id50_pri:2;   /* [31:30] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP1_ACTION_PRIORITY6_DWLEN];
+} __packed;
+
+#define NBL_PP1_ACTION_PRIORITY7_ADDR  (0xb24134)
+#define NBL_PP1_ACTION_PRIORITY7_DEPTH (1)
+#define NBL_PP1_ACTION_PRIORITY7_WIDTH (32)
+#define NBL_PP1_ACTION_PRIORITY7_DWLEN (1)
+union pp1_action_priority7_u {
+	struct pp1_action_priority7 {
+		u32 action_id51_pri:2;   /* [01:00] Default:0x0 RW */
+		u32 action_id52_pri:2;   /* [03:02] Default:0x0 RW */
+		u32 action_id53_pri:2;   /* [05:04] Default:0x0 RW */
+		u32 action_id54_pri:2;   /* [07:06] Default:0x0 RW */
+		u32 action_id55_pri:2;   /* [09:08] Default:0x0 RW */
+		u32 action_id56_pri:2;   /* [11:10] Default:0x0 RW */
+		u32 action_id57_pri:2;   /* [13:12] Default:0x0 RW */
+		u32 action_id58_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id59_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id60_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id61_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id62_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 rsv:8;               /* [31:24] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP1_ACTION_PRIORITY7_DWLEN];
+} __packed;
+
+#define NBL_PP1_CPU_ACCESS_ADDR  (0xb2416c)
+#define NBL_PP1_CPU_ACCESS_DEPTH (1)
+#define NBL_PP1_CPU_ACCESS_WIDTH (32)
+#define NBL_PP1_CPU_ACCESS_DWLEN (1)
+union pp1_cpu_access_u {
+	struct pp1_cpu_access {
+		u32 bp_th:10;            /* [9:0] Default:0x34 RW */
+		u32 rsv1:6;              /* [15:10] Default:0x0 RO */
+		u32 timeout_th:10;       /* [25:16] Default:0x100 RW */
+		u32 rsv:6;               /* [31:26] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP1_CPU_ACCESS_DWLEN];
+} __packed;
+
+#define NBL_PP1_RDMA_BYPASS_ADDR  (0xb24170)
+#define NBL_PP1_RDMA_BYPASS_DEPTH (1)
+#define NBL_PP1_RDMA_BYPASS_WIDTH (32)
+#define NBL_PP1_RDMA_BYPASS_DWLEN (1)
+union pp1_rdma_bypass_u {
+	struct pp1_rdma_bypass {
+		u32 rdma_flag_offset:5;  /* [4:0] Default:0x0 RW */
+		u32 dn_bypass_en:1;      /* [5] Default:0x0 RW */
+		u32 up_bypass_en:1;      /* [6] Default:0x0 RW */
+		u32 rsv1:1;              /* [7] Default:0x0 RO */
+		u32 dir_flag_offset:5;   /* [12:8] Default:0x0 RW */
+		u32 rsv:19;              /* [31:13] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP1_RDMA_BYPASS_DWLEN];
+} __packed;
+
+#define NBL_PP1_INIT_START_ADDR  (0xb241fc)
+#define NBL_PP1_INIT_START_DEPTH (1)
+#define NBL_PP1_INIT_START_WIDTH (32)
+#define NBL_PP1_INIT_START_DWLEN (1)
+union pp1_init_start_u {
+	struct pp1_init_start {
+		u32 en:1;                /* [0] Default:0x0 WO */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP1_INIT_START_DWLEN];
+} __packed;
+
+#define NBL_PP1_BP_SET_ADDR  (0xb24200)
+#define NBL_PP1_BP_SET_DEPTH (1)
+#define NBL_PP1_BP_SET_WIDTH (32)
+#define NBL_PP1_BP_SET_DWLEN (1)
+union pp1_bp_set_u {
+	struct pp1_bp_set {
+		u32 pp_up:1;             /* [00:00] Default:0x0 RW */
+		u32 rsv:31;              /* [31:01] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP1_BP_SET_DWLEN];
+} __packed;
+
+#define NBL_PP1_BP_MASK_ADDR  (0xb24204)
+#define NBL_PP1_BP_MASK_DEPTH (1)
+#define NBL_PP1_BP_MASK_WIDTH (32)
+#define NBL_PP1_BP_MASK_DWLEN (1)
+union pp1_bp_mask_u {
+	struct pp1_bp_mask {
+		u32 dn_pp:1;             /* [00:00] Default:0x0 RW */
+		u32 fem_pp:1;            /* [01:01] Default:0x0 RW */
+		u32 rsv:30;              /* [31:02] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP1_BP_MASK_DWLEN];
+} __packed;
+
+#define NBL_PP1_BP_STATE_ADDR  (0xb24308)
+#define NBL_PP1_BP_STATE_DEPTH (1)
+#define NBL_PP1_BP_STATE_WIDTH (32)
+#define NBL_PP1_BP_STATE_DWLEN (1)
+union pp1_bp_state_u {
+	struct pp1_bp_state {
+		u32 dn_pp_bp:1;          /* [00:00] Default:0x0 RO */
+		u32 fem_pp_bp:1;         /* [01:01] Default:0x0 RO */
+		u32 pp_up_bp:1;          /* [02:02] Default:0x0 RO */
+		u32 inter_pp_bp:1;       /* [03:03] Default:0x0 RO */
+		u32 rsv:28;              /* [31:04] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP1_BP_STATE_DWLEN];
+} __packed;
+
+#define NBL_PP1_BP_HISTORY_ADDR  (0xb2430c)
+#define NBL_PP1_BP_HISTORY_DEPTH (1)
+#define NBL_PP1_BP_HISTORY_WIDTH (32)
+#define NBL_PP1_BP_HISTORY_DWLEN (1)
+union pp1_bp_history_u {
+	struct pp1_bp_history {
+		u32 dn_pp_bp:1;          /* [00:00] Default:0x0 RC */
+		u32 fem_pp_bp:1;         /* [01:01] Default:0x0 RC */
+		u32 pp_up_bp:1;          /* [02:02] Default:0x0 RC */
+		u32 inter_pp_bp:1;       /* [03:03] Default:0x0 RC */
+		u32 rsv:28;              /* [31:04] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP1_BP_HISTORY_DWLEN];
+} __packed;
+
+#define NBL_PP1_CFG_TEST_ADDR  (0xb2442c)
+#define NBL_PP1_CFG_TEST_DEPTH (1)
+#define NBL_PP1_CFG_TEST_WIDTH (32)
+#define NBL_PP1_CFG_TEST_DWLEN (1)
+union pp1_cfg_test_u {
+	struct pp1_cfg_test {
+		u32 test:32;             /* [31:00] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP1_CFG_TEST_DWLEN];
+} __packed;
+
+#define NBL_PP1_ABNORMAL_ACTION0_ADDR  (0xb24430)
+#define NBL_PP1_ABNORMAL_ACTION0_DEPTH (1)
+#define NBL_PP1_ABNORMAL_ACTION0_WIDTH (32)
+#define NBL_PP1_ABNORMAL_ACTION0_DWLEN (1)
+union pp1_abnormal_action0_u {
+	struct pp1_abnormal_action0 {
+		u32 data:22;             /* [21:00] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP1_ABNORMAL_ACTION0_DWLEN];
+} __packed;
+
+#define NBL_PP1_ABNORMAL_ACTION1_ADDR  (0xb24434)
+#define NBL_PP1_ABNORMAL_ACTION1_DEPTH (1)
+#define NBL_PP1_ABNORMAL_ACTION1_WIDTH (32)
+#define NBL_PP1_ABNORMAL_ACTION1_DWLEN (1)
+union pp1_abnormal_action1_u {
+	struct pp1_abnormal_action1 {
+		u32 data:22;             /* [21:00] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP1_ABNORMAL_ACTION1_DWLEN];
+} __packed;
+
+#define NBL_PP1_ABNORMAL_ACTION2_ADDR  (0xb24438)
+#define NBL_PP1_ABNORMAL_ACTION2_DEPTH (1)
+#define NBL_PP1_ABNORMAL_ACTION2_WIDTH (32)
+#define NBL_PP1_ABNORMAL_ACTION2_DWLEN (1)
+union pp1_abnormal_action2_u {
+	struct pp1_abnormal_action2 {
+		u32 data:22;             /* [21:00] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP1_ABNORMAL_ACTION2_DWLEN];
+} __packed;
+
+#define NBL_PP1_ABNORMAL_ACTION3_ADDR  (0xb2443c)
+#define NBL_PP1_ABNORMAL_ACTION3_DEPTH (1)
+#define NBL_PP1_ABNORMAL_ACTION3_WIDTH (32)
+#define NBL_PP1_ABNORMAL_ACTION3_DWLEN (1)
+union pp1_abnormal_action3_u {
+	struct pp1_abnormal_action3 {
+		u32 data:22;             /* [21:00] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP1_ABNORMAL_ACTION3_DWLEN];
+} __packed;
+
+#define NBL_PP1_ABNORMAL_ACTION4_ADDR  (0xb24440)
+#define NBL_PP1_ABNORMAL_ACTION4_DEPTH (1)
+#define NBL_PP1_ABNORMAL_ACTION4_WIDTH (32)
+#define NBL_PP1_ABNORMAL_ACTION4_DWLEN (1)
+union pp1_abnormal_action4_u {
+	struct pp1_abnormal_action4 {
+		u32 data:22;             /* [21:00] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP1_ABNORMAL_ACTION4_DWLEN];
+} __packed;
+
+#define NBL_PP1_ABNORMAL_ACTION5_ADDR  (0xb24444)
+#define NBL_PP1_ABNORMAL_ACTION5_DEPTH (1)
+#define NBL_PP1_ABNORMAL_ACTION5_WIDTH (32)
+#define NBL_PP1_ABNORMAL_ACTION5_DWLEN (1)
+union pp1_abnormal_action5_u {
+	struct pp1_abnormal_action5 {
+		u32 data:22;             /* [21:00] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP1_ABNORMAL_ACTION5_DWLEN];
+} __packed;
+
+#define NBL_PP1_ABNORMAL_ACTION6_ADDR  (0xb24448)
+#define NBL_PP1_ABNORMAL_ACTION6_DEPTH (1)
+#define NBL_PP1_ABNORMAL_ACTION6_WIDTH (32)
+#define NBL_PP1_ABNORMAL_ACTION6_DWLEN (1)
+union pp1_abnormal_action6_u {
+	struct pp1_abnormal_action6 {
+		u32 data:22;             /* [21:00] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP1_ABNORMAL_ACTION6_DWLEN];
+} __packed;
+
+#define NBL_PP1_ABNORMAL_ACTION7_ADDR  (0xb2444c)
+#define NBL_PP1_ABNORMAL_ACTION7_DEPTH (1)
+#define NBL_PP1_ABNORMAL_ACTION7_WIDTH (32)
+#define NBL_PP1_ABNORMAL_ACTION7_DWLEN (1)
+union pp1_abnormal_action7_u {
+	struct pp1_abnormal_action7 {
+		u32 data:22;             /* [21:00] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP1_ABNORMAL_ACTION7_DWLEN];
+} __packed;
+
+#define NBL_PP1_FWD_DPORT_ACTION_ADDR  (0xb24450)
+#define NBL_PP1_FWD_DPORT_ACTION_DEPTH (1)
+#define NBL_PP1_FWD_DPORT_ACTION_WIDTH (32)
+#define NBL_PP1_FWD_DPORT_ACTION_DWLEN (1)
+union pp1_fwd_dport_action_u {
+	struct pp1_fwd_dport_action {
+		u32 action_id:6;         /* [05:00] Default:0x9 RW */
+		u32 rsv:26;              /* [31:06] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP1_FWD_DPORT_ACTION_DWLEN];
+} __packed;
+
+#define NBL_PP1_RDMA_VSI_BTM_ADDR  (0xb24454)
+#define NBL_PP1_RDMA_VSI_BTM_DEPTH (32)
+#define NBL_PP1_RDMA_VSI_BTM_WIDTH (32)
+#define NBL_PP1_RDMA_VSI_BTM_DWLEN (1)
+union pp1_rdma_vsi_btm_u {
+	struct pp1_rdma_vsi_btm {
+		u32 btm:32;              /* [31:00] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP1_RDMA_VSI_BTM_DWLEN];
+} __packed;
+#define NBL_PP1_RDMA_VSI_BTM_REG(r) (NBL_PP1_RDMA_VSI_BTM_ADDR + \
+		(NBL_PP1_RDMA_VSI_BTM_DWLEN * 4) * (r))
+
+#define NBL_PP1_KGEN_KEY_PRF_ADDR (0xb25000)
+#define NBL_PP1_KGEN_KEY_PRF_DEPTH (16)
+#define NBL_PP1_KGEN_KEY_PRF_WIDTH (512)
+#define NBL_PP1_KGEN_KEY_PRF_DWLEN (16)
+union pp1_kgen_key_prf_u {
+	struct pp1_kgen_key_prf {
+		u32 ext4_0_src:10;
+		u32 ext4_0_dst:7;
+		u32 ext4_1_src:10;
+		u32 ext4_1_dst:7;
+		u32 ext4_2_src:10;
+		u32 ext4_2_dst:7;
+		u32 ext4_3_src:10;
+		u32 ext4_3_dst:7;
+		u32 ext8_0_src:9;
+		u32 ext8_0_dst:6;
+		u32 ext8_1_src:9;
+		u32 ext8_1_dst:6;
+		u32 ext8_2_src:9;
+		u32 ext8_2_dst:6;
+		u32 ext8_3_src:9;
+		u32 ext8_3_dst:6;
+		u32 ext8_4_src:9;
+		u32 ext8_4_dst:6;
+		u32 ext8_5_src:9;
+		u32 ext8_5_dst:6;
+		u32 ext8_6_src:9;
+		u32 ext8_6_dst:6;
+		u32 ext8_7_src:9;
+		u32 ext8_7_dst:6;
+		u32 ext16_0_src:8;
+		u32 ext16_0_dst:5;
+		u32 ext16_1_src:8;
+		u32 ext16_1_dst:5;
+		u32 ext16_2_src:8;
+		u32 ext16_2_dst:5;
+		u32 ext16_3_src:8;
+		u32 ext16_3_dst:5;
+		u32 ext32_0_src:7;
+		u32 ext32_0_dst:4;
+		u32 ext32_1_src:7;
+		u32 ext32_1_dst:4;
+		u32 ext32_2_src:7;
+		u32 ext32_2_dst:4;
+		u32 ext32_3_src:7;
+		u32 ext32_3_dst:4;
+		u32 sp_2_en:1;
+		u32 sp_2_src_offset:3;
+		u32 sp_2_dst_offset:8;
+		u32 sp_4_en:1;
+		u32 sp_4_src_offset:2;
+		u32 sp_4_dst_offset:7;
+		u32 sp_8_en:1;
+		u32 sp_8_src_offset:1;
+		u32 sp_8_dst_offset:6;
+		u32 fwdact0_en:1;
+		u32 fwdact0_id:6;
+		u32 fwdact0_dst_offset:5;
+		u32 fwdact1_en:1;
+		u32 fwdact1_id:6;
+		u32 fwdact1_dst_offset:5;
+		u32 bts_en0:1;
+		u32 bts_data0:1;
+		u32 bts_des_offset0:9;
+		u32 bts_en1:1;
+		u32 bts_data1:1;
+		u32 bts_des_offset1:9;
+		u32 bts_en2:1;
+		u32 bts_data2:1;
+		u32 bts_des_offset2:9;
+		u32 bts_en3:1;
+		u32 bts_data3:1;
+		u32 bts_des_offset3:9;
+		u32 rsv1:2;
+		u32 rsv[4];
+	} __packed info;
+	u32 data[NBL_PP1_KGEN_KEY_PRF_DWLEN];
+};
+
+#define NBL_PP1_KGEN_KEY_PRF_REG(r) (NBL_PP1_KGEN_KEY_PRF_ADDR + \
+		(NBL_PP1_KGEN_KEY_PRF_DWLEN * 4) * (r))
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_pp2.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_pp2.h
new file mode 100644
index 000000000000..a4cb17ce60c6
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/base/nbl_ppe_pp2.h
@@ -0,0 +1,619 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+// Code generated by interstellar. DO NOT EDIT.
+// Compatible with leonis RTL tag 0710
+
+#ifndef NBL_PP2_H
+#define NBL_PP2_H 1
+
+#include <linux/types.h>
+
+#define NBL_PP2_BASE (0x00B34000)
+
+#define NBL_PP2_INT_STATUS_ADDR  (0xb34000)
+#define NBL_PP2_INT_STATUS_DEPTH (1)
+#define NBL_PP2_INT_STATUS_WIDTH (32)
+#define NBL_PP2_INT_STATUS_DWLEN (1)
+union pp2_int_status_u {
+	struct pp2_int_status {
+		u32 rsv5:1;              /* [00:00] Default:0x0 RO */
+		u32 fifo_uflw_err:1;     /* [01:01] Default:0x0 RWC */
+		u32 fifo_dflw_err:1;     /* [02:02] Default:0x0 RWC */
+		u32 rsv4:1;              /* [03:03] Default:0x0 RO */
+		u32 cif_err:1;           /* [04:04] Default:0x0 RWC */
+		u32 rsv3:1;              /* [05:05] Default:0x0 RO */
+		u32 cfg_err:1;           /* [06:06] Default:0x0 RWC */
+		u32 data_ucor_err:1;     /* [07:07] Default:0x0 RWC */
+		u32 rsv2:1;              /* [08:08] Default:0x0 RO */
+		u32 rsv1:1;              /* [09:09] Default:0x0 RO */
+		u32 rsv:22;              /* [31:10] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP2_INT_STATUS_DWLEN];
+} __packed;
+
+#define NBL_PP2_INT_MASK_ADDR  (0xb34004)
+#define NBL_PP2_INT_MASK_DEPTH (1)
+#define NBL_PP2_INT_MASK_WIDTH (32)
+#define NBL_PP2_INT_MASK_DWLEN (1)
+union pp2_int_mask_u {
+	struct pp2_int_mask {
+		u32 rsv5:1;              /* [00:00] Default:0x0 RO */
+		u32 fifo_uflw_err:1;     /* [01:01] Default:0x0 RW */
+		u32 fifo_dflw_err:1;     /* [02:02] Default:0x0 RW */
+		u32 rsv4:1;              /* [03:03] Default:0x0 RO */
+		u32 cif_err:1;           /* [04:04] Default:0x0 RW */
+		u32 rsv3:1;              /* [05:05] Default:0x0 RO */
+		u32 cfg_err:1;           /* [06:06] Default:0x0 RW */
+		u32 data_ucor_err:1;     /* [07:07] Default:0x0 RW */
+		u32 rsv2:1;              /* [08:08] Default:0x0 RO */
+		u32 rsv1:1;              /* [09:09] Default:0x0 RO */
+		u32 rsv:22;              /* [31:10] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP2_INT_MASK_DWLEN];
+} __packed;
+
+#define NBL_PP2_INT_SET_ADDR  (0xb34008)
+#define NBL_PP2_INT_SET_DEPTH (1)
+#define NBL_PP2_INT_SET_WIDTH (32)
+#define NBL_PP2_INT_SET_DWLEN (1)
+union pp2_int_set_u {
+	struct pp2_int_set {
+		u32 rsv5:1;              /* [00:00] Default:0x0 RO */
+		u32 fifo_uflw_err:1;     /* [01:01] Default:0x0 WO */
+		u32 fifo_dflw_err:1;     /* [02:02] Default:0x0 WO */
+		u32 rsv4:1;              /* [03:03] Default:0x0 RO */
+		u32 cif_err:1;           /* [04:04] Default:0x0 WO */
+		u32 rsv3:1;              /* [05:05] Default:0x0 RO */
+		u32 cfg_err:1;           /* [06:06] Default:0x0 WO */
+		u32 data_ucor_err:1;     /* [07:07] Default:0x0 WO */
+		u32 rsv2:1;              /* [08:08] Default:0x0 RO */
+		u32 rsv1:1;              /* [09:09] Default:0x0 RO */
+		u32 rsv:22;              /* [31:10] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP2_INT_SET_DWLEN];
+} __packed;
+
+#define NBL_PP2_INIT_DONE_ADDR  (0xb3400c)
+#define NBL_PP2_INIT_DONE_DEPTH (1)
+#define NBL_PP2_INIT_DONE_WIDTH (32)
+#define NBL_PP2_INIT_DONE_DWLEN (1)
+union pp2_init_done_u {
+	struct pp2_init_done {
+		u32 done:1;              /* [00:00] Default:0x0 RO */
+		u32 rsv:31;              /* [31:01] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP2_INIT_DONE_DWLEN];
+} __packed;
+
+#define NBL_PP2_CFG_ERR_INFO_ADDR  (0xb34038)
+#define NBL_PP2_CFG_ERR_INFO_DEPTH (1)
+#define NBL_PP2_CFG_ERR_INFO_WIDTH (32)
+#define NBL_PP2_CFG_ERR_INFO_DWLEN (1)
+union pp2_cfg_err_info_u {
+	struct pp2_cfg_err_info {
+		u32 id:1;                /* [0:0] Default:0x0 RO */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP2_CFG_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_PP2_CIF_ERR_INFO_ADDR  (0xb34040)
+#define NBL_PP2_CIF_ERR_INFO_DEPTH (1)
+#define NBL_PP2_CIF_ERR_INFO_WIDTH (32)
+#define NBL_PP2_CIF_ERR_INFO_DWLEN (1)
+union pp2_cif_err_info_u {
+	struct pp2_cif_err_info {
+		u32 addr:30;             /* [29:00] Default:0x0 RO */
+		u32 wr_err:1;            /* [30:30] Default:0x0 RO */
+		u32 ucor_err:1;          /* [31:31] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP2_CIF_ERR_INFO_DWLEN];
+} __packed;
+
+#define NBL_PP2_CAR_CTRL_ADDR  (0xb34100)
+#define NBL_PP2_CAR_CTRL_DEPTH (1)
+#define NBL_PP2_CAR_CTRL_WIDTH (32)
+#define NBL_PP2_CAR_CTRL_DWLEN (1)
+union pp2_car_ctrl_u {
+	struct pp2_car_ctrl {
+		u32 sctr_car:1;          /* [00:00] Default:0x1 RW */
+		u32 rctr_car:1;          /* [01:01] Default:0x1 RW */
+		u32 rc_car:1;            /* [02:02] Default:0x1 RW */
+		u32 tbl_rc_car:1;        /* [03:03] Default:0x1 RW */
+		u32 rsv:28;              /* [31:04] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP2_CAR_CTRL_DWLEN];
+} __packed;
+
+#define NBL_PP2_MODE_ADDR  (0xb34104)
+#define NBL_PP2_MODE_DEPTH (1)
+#define NBL_PP2_MODE_WIDTH (32)
+#define NBL_PP2_MODE_DWLEN (1)
+union pp2_mode_u {
+	struct pp2_mode {
+		u32 bypass:1;            /* [0] Default:0x0 RW */
+		u32 internal_loopback_en:1; /* [1] Default:0x0 RW */
+		u32 rsv:30;              /* [31:2] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP2_MODE_DWLEN];
+} __packed;
+
+#define NBL_PP2_SET_FLAGS0_ADDR  (0xb34108)
+#define NBL_PP2_SET_FLAGS0_DEPTH (1)
+#define NBL_PP2_SET_FLAGS0_WIDTH (32)
+#define NBL_PP2_SET_FLAGS0_DWLEN (1)
+union pp2_set_flags0_u {
+	struct pp2_set_flags0 {
+		u32 data:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP2_SET_FLAGS0_DWLEN];
+} __packed;
+
+#define NBL_PP2_SET_FLAGS1_ADDR  (0xb3410c)
+#define NBL_PP2_SET_FLAGS1_DEPTH (1)
+#define NBL_PP2_SET_FLAGS1_WIDTH (32)
+#define NBL_PP2_SET_FLAGS1_DWLEN (1)
+union pp2_set_flags1_u {
+	struct pp2_set_flags1 {
+		u32 data:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP2_SET_FLAGS1_DWLEN];
+} __packed;
+
+#define NBL_PP2_CLEAR_FLAGS0_ADDR  (0xb34110)
+#define NBL_PP2_CLEAR_FLAGS0_DEPTH (1)
+#define NBL_PP2_CLEAR_FLAGS0_WIDTH (32)
+#define NBL_PP2_CLEAR_FLAGS0_DWLEN (1)
+union pp2_clear_flags0_u {
+	struct pp2_clear_flags0 {
+		u32 data:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP2_CLEAR_FLAGS0_DWLEN];
+} __packed;
+
+#define NBL_PP2_CLEAR_FLAGS1_ADDR  (0xb34114)
+#define NBL_PP2_CLEAR_FLAGS1_DEPTH (1)
+#define NBL_PP2_CLEAR_FLAGS1_WIDTH (32)
+#define NBL_PP2_CLEAR_FLAGS1_DWLEN (1)
+union pp2_clear_flags1_u {
+	struct pp2_clear_flags1 {
+		u32 data:32;             /* [31:0] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP2_CLEAR_FLAGS1_DWLEN];
+} __packed;
+
+#define NBL_PP2_ACTION_PRIORITY0_ADDR  (0xb34118)
+#define NBL_PP2_ACTION_PRIORITY0_DEPTH (1)
+#define NBL_PP2_ACTION_PRIORITY0_WIDTH (32)
+#define NBL_PP2_ACTION_PRIORITY0_DWLEN (1)
+union pp2_action_priority0_u {
+	struct pp2_action_priority0 {
+		u32 action_id3_pri:2;    /* [01:00] Default:0x0 RW */
+		u32 action_id4_pri:2;    /* [03:02] Default:0x0 RW */
+		u32 action_id5_pri:2;    /* [05:04] Default:0x0 RW */
+		u32 action_id6_pri:2;    /* [07:06] Default:0x0 RW */
+		u32 action_id7_pri:2;    /* [09:08] Default:0x0 RW */
+		u32 action_id8_pri:2;    /* [11:10] Default:0x0 RW */
+		u32 action_id9_pri:2;    /* [13:12] Default:0x0 RW */
+		u32 action_id10_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id11_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id12_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id13_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id14_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 action_id15_pri:2;   /* [25:24] Default:0x0 RW */
+		u32 action_id16_pri:2;   /* [27:26] Default:0x0 RW */
+		u32 action_id17_pri:2;   /* [29:28] Default:0x0 RW */
+		u32 action_id18_pri:2;   /* [31:30] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP2_ACTION_PRIORITY0_DWLEN];
+} __packed;
+
+#define NBL_PP2_ACTION_PRIORITY1_ADDR  (0xb3411c)
+#define NBL_PP2_ACTION_PRIORITY1_DEPTH (1)
+#define NBL_PP2_ACTION_PRIORITY1_WIDTH (32)
+#define NBL_PP2_ACTION_PRIORITY1_DWLEN (1)
+union pp2_action_priority1_u {
+	struct pp2_action_priority1 {
+		u32 action_id19_pri:2;   /* [01:00] Default:0x0 RW */
+		u32 action_id20_pri:2;   /* [03:02] Default:0x0 RW */
+		u32 action_id21_pri:2;   /* [05:04] Default:0x0 RW */
+		u32 action_id22_pri:2;   /* [07:06] Default:0x0 RW */
+		u32 action_id23_pri:2;   /* [09:08] Default:0x0 RW */
+		u32 action_id24_pri:2;   /* [11:10] Default:0x0 RW */
+		u32 action_id25_pri:2;   /* [13:12] Default:0x0 RW */
+		u32 action_id26_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id27_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id28_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id29_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id30_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 action_id31_pri:2;   /* [25:24] Default:0x0 RW */
+		u32 action_id32_pri:2;   /* [27:26] Default:0x0 RW */
+		u32 action_id33_pri:2;   /* [29:28] Default:0x0 RW */
+		u32 action_id34_pri:2;   /* [31:30] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP2_ACTION_PRIORITY1_DWLEN];
+} __packed;
+
+#define NBL_PP2_ACTION_PRIORITY2_ADDR  (0xb34120)
+#define NBL_PP2_ACTION_PRIORITY2_DEPTH (1)
+#define NBL_PP2_ACTION_PRIORITY2_WIDTH (32)
+#define NBL_PP2_ACTION_PRIORITY2_DWLEN (1)
+union pp2_action_priority2_u {
+	struct pp2_action_priority2 {
+		u32 action_id35_pri:2;   /* [01:00] Default:0x0 RW */
+		u32 action_id36_pri:2;   /* [03:02] Default:0x0 RW */
+		u32 action_id37_pri:2;   /* [05:04] Default:0x0 RW */
+		u32 action_id38_pri:2;   /* [07:06] Default:0x0 RW */
+		u32 action_id39_pri:2;   /* [09:08] Default:0x0 RW */
+		u32 action_id40_pri:2;   /* [11:10] Default:0x0 RW */
+		u32 action_id41_pri:2;   /* [13:12] Default:0x0 RW */
+		u32 action_id42_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id43_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id44_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id45_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id46_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 action_id47_pri:2;   /* [25:24] Default:0x0 RW */
+		u32 action_id48_pri:2;   /* [27:26] Default:0x0 RW */
+		u32 action_id49_pri:2;   /* [29:28] Default:0x0 RW */
+		u32 action_id50_pri:2;   /* [31:30] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP2_ACTION_PRIORITY2_DWLEN];
+} __packed;
+
+#define NBL_PP2_ACTION_PRIORITY3_ADDR  (0xb34124)
+#define NBL_PP2_ACTION_PRIORITY3_DEPTH (1)
+#define NBL_PP2_ACTION_PRIORITY3_WIDTH (32)
+#define NBL_PP2_ACTION_PRIORITY3_DWLEN (1)
+union pp2_action_priority3_u {
+	struct pp2_action_priority3 {
+		u32 action_id51_pri:2;   /* [01:00] Default:0x0 RW */
+		u32 action_id52_pri:2;   /* [03:02] Default:0x0 RW */
+		u32 action_id53_pri:2;   /* [05:04] Default:0x0 RW */
+		u32 action_id54_pri:2;   /* [07:06] Default:0x0 RW */
+		u32 action_id55_pri:2;   /* [09:08] Default:0x0 RW */
+		u32 action_id56_pri:2;   /* [11:10] Default:0x0 RW */
+		u32 action_id57_pri:2;   /* [13:12] Default:0x0 RW */
+		u32 action_id58_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id59_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id60_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id61_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id62_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 rsv:8;               /* [31:24] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP2_ACTION_PRIORITY3_DWLEN];
+} __packed;
+
+#define NBL_PP2_ACTION_PRIORITY4_ADDR  (0xb34128)
+#define NBL_PP2_ACTION_PRIORITY4_DEPTH (1)
+#define NBL_PP2_ACTION_PRIORITY4_WIDTH (32)
+#define NBL_PP2_ACTION_PRIORITY4_DWLEN (1)
+union pp2_action_priority4_u {
+	struct pp2_action_priority4 {
+		u32 action_id3_pri:2;    /* [01:00] Default:0x0 RW */
+		u32 action_id4_pri:2;    /* [03:02] Default:0x0 RW */
+		u32 action_id5_pri:2;    /* [05:04] Default:0x0 RW */
+		u32 action_id6_pri:2;    /* [07:06] Default:0x0 RW */
+		u32 action_id7_pri:2;    /* [09:08] Default:0x0 RW */
+		u32 action_id8_pri:2;    /* [11:10] Default:0x0 RW */
+		u32 action_id9_pri:2;    /* [13:12] Default:0x0 RW */
+		u32 action_id10_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id11_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id12_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id13_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id14_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 action_id15_pri:2;   /* [25:24] Default:0x0 RW */
+		u32 action_id16_pri:2;   /* [27:26] Default:0x0 RW */
+		u32 action_id17_pri:2;   /* [29:28] Default:0x0 RW */
+		u32 action_id18_pri:2;   /* [31:30] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP2_ACTION_PRIORITY4_DWLEN];
+} __packed;
+
+#define NBL_PP2_ACTION_PRIORITY5_ADDR  (0xb3412c)
+#define NBL_PP2_ACTION_PRIORITY5_DEPTH (1)
+#define NBL_PP2_ACTION_PRIORITY5_WIDTH (32)
+#define NBL_PP2_ACTION_PRIORITY5_DWLEN (1)
+union pp2_action_priority5_u {
+	struct pp2_action_priority5 {
+		u32 action_id19_pri:2;   /* [01:00] Default:0x0 RW */
+		u32 action_id20_pri:2;   /* [03:02] Default:0x0 RW */
+		u32 action_id21_pri:2;   /* [05:04] Default:0x0 RW */
+		u32 action_id22_pri:2;   /* [07:06] Default:0x0 RW */
+		u32 action_id23_pri:2;   /* [09:08] Default:0x0 RW */
+		u32 action_id24_pri:2;   /* [11:10] Default:0x0 RW */
+		u32 action_id25_pri:2;   /* [13:12] Default:0x0 RW */
+		u32 action_id26_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id27_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id28_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id29_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id30_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 action_id31_pri:2;   /* [25:24] Default:0x0 RW */
+		u32 action_id32_pri:2;   /* [27:26] Default:0x0 RW */
+		u32 action_id33_pri:2;   /* [29:28] Default:0x0 RW */
+		u32 action_id34_pri:2;   /* [31:30] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP2_ACTION_PRIORITY5_DWLEN];
+} __packed;
+
+#define NBL_PP2_ACTION_PRIORITY6_ADDR  (0xb34130)
+#define NBL_PP2_ACTION_PRIORITY6_DEPTH (1)
+#define NBL_PP2_ACTION_PRIORITY6_WIDTH (32)
+#define NBL_PP2_ACTION_PRIORITY6_DWLEN (1)
+union pp2_action_priority6_u {
+	struct pp2_action_priority6 {
+		u32 action_id35_pri:2;   /* [01:00] Default:0x0 RW */
+		u32 action_id36_pri:2;   /* [03:02] Default:0x0 RW */
+		u32 action_id37_pri:2;   /* [05:04] Default:0x0 RW */
+		u32 action_id38_pri:2;   /* [07:06] Default:0x0 RW */
+		u32 action_id39_pri:2;   /* [09:08] Default:0x0 RW */
+		u32 action_id40_pri:2;   /* [11:10] Default:0x0 RW */
+		u32 action_id41_pri:2;   /* [13:12] Default:0x0 RW */
+		u32 action_id42_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id43_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id44_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id45_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id46_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 action_id47_pri:2;   /* [25:24] Default:0x0 RW */
+		u32 action_id48_pri:2;   /* [27:26] Default:0x0 RW */
+		u32 action_id49_pri:2;   /* [29:28] Default:0x0 RW */
+		u32 action_id50_pri:2;   /* [31:30] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP2_ACTION_PRIORITY6_DWLEN];
+} __packed;
+
+#define NBL_PP2_ACTION_PRIORITY7_ADDR  (0xb34134)
+#define NBL_PP2_ACTION_PRIORITY7_DEPTH (1)
+#define NBL_PP2_ACTION_PRIORITY7_WIDTH (32)
+#define NBL_PP2_ACTION_PRIORITY7_DWLEN (1)
+union pp2_action_priority7_u {
+	struct pp2_action_priority7 {
+		u32 action_id51_pri:2;   /* [01:00] Default:0x0 RW */
+		u32 action_id52_pri:2;   /* [03:02] Default:0x0 RW */
+		u32 action_id53_pri:2;   /* [05:04] Default:0x0 RW */
+		u32 action_id54_pri:2;   /* [07:06] Default:0x0 RW */
+		u32 action_id55_pri:2;   /* [09:08] Default:0x0 RW */
+		u32 action_id56_pri:2;   /* [11:10] Default:0x0 RW */
+		u32 action_id57_pri:2;   /* [13:12] Default:0x0 RW */
+		u32 action_id58_pri:2;   /* [15:14] Default:0x0 RW */
+		u32 action_id59_pri:2;   /* [17:16] Default:0x0 RW */
+		u32 action_id60_pri:2;   /* [19:18] Default:0x0 RW */
+		u32 action_id61_pri:2;   /* [21:20] Default:0x0 RW */
+		u32 action_id62_pri:2;   /* [23:22] Default:0x0 RW */
+		u32 rsv:8;               /* [31:24] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP2_ACTION_PRIORITY7_DWLEN];
+} __packed;
+
+#define NBL_PP2_CPU_ACCESS_ADDR  (0xb3416c)
+#define NBL_PP2_CPU_ACCESS_DEPTH (1)
+#define NBL_PP2_CPU_ACCESS_WIDTH (32)
+#define NBL_PP2_CPU_ACCESS_DWLEN (1)
+union pp2_cpu_access_u {
+	struct pp2_cpu_access {
+		u32 bp_th:10;            /* [9:0] Default:0x34 RW */
+		u32 rsv1:6;              /* [15:10] Default:0x0 RO */
+		u32 timeout_th:10;       /* [25:16] Default:0x100 RW */
+		u32 rsv:6;               /* [31:26] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP2_CPU_ACCESS_DWLEN];
+} __packed;
+
+#define NBL_PP2_RDMA_BYPASS_ADDR  (0xb34170)
+#define NBL_PP2_RDMA_BYPASS_DEPTH (1)
+#define NBL_PP2_RDMA_BYPASS_WIDTH (32)
+#define NBL_PP2_RDMA_BYPASS_DWLEN (1)
+union pp2_rdma_bypass_u {
+	struct pp2_rdma_bypass {
+		u32 rdma_flag_offset:5;  /* [4:0] Default:0x0 RW */
+		u32 dn_bypass_en:1;      /* [5] Default:0x0 RW */
+		u32 up_bypass_en:1;      /* [6] Default:0x0 RW */
+		u32 rsv1:1;              /* [7] Default:0x0 RO */
+		u32 dir_flag_offset:5;   /* [12:8] Default:0x0 RW */
+		u32 rsv:19;              /* [31:13] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP2_RDMA_BYPASS_DWLEN];
+} __packed;
+
+#define NBL_PP2_INIT_START_ADDR  (0xb341fc)
+#define NBL_PP2_INIT_START_DEPTH (1)
+#define NBL_PP2_INIT_START_WIDTH (32)
+#define NBL_PP2_INIT_START_DWLEN (1)
+union pp2_init_start_u {
+	struct pp2_init_start {
+		u32 en:1;                /* [0] Default:0x0 WO */
+		u32 rsv:31;              /* [31:1] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP2_INIT_START_DWLEN];
+} __packed;
+
+#define NBL_PP2_BP_SET_ADDR  (0xb34200)
+#define NBL_PP2_BP_SET_DEPTH (1)
+#define NBL_PP2_BP_SET_WIDTH (32)
+#define NBL_PP2_BP_SET_DWLEN (1)
+union pp2_bp_set_u {
+	struct pp2_bp_set {
+		u32 pp_up:1;             /* [00:00] Default:0x0 RW */
+		u32 rsv:31;              /* [31:01] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP2_BP_SET_DWLEN];
+} __packed;
+
+#define NBL_PP2_BP_MASK_ADDR  (0xb34204)
+#define NBL_PP2_BP_MASK_DEPTH (1)
+#define NBL_PP2_BP_MASK_WIDTH (32)
+#define NBL_PP2_BP_MASK_DWLEN (1)
+union pp2_bp_mask_u {
+	struct pp2_bp_mask {
+		u32 dn_pp:1;             /* [00:00] Default:0x0 RW */
+		u32 fem_pp:1;            /* [01:01] Default:0x0 RW */
+		u32 rsv:30;              /* [31:02] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP2_BP_MASK_DWLEN];
+} __packed;
+
+#define NBL_PP2_BP_STATE_ADDR  (0xb34308)
+#define NBL_PP2_BP_STATE_DEPTH (1)
+#define NBL_PP2_BP_STATE_WIDTH (32)
+#define NBL_PP2_BP_STATE_DWLEN (1)
+union pp2_bp_state_u {
+	struct pp2_bp_state {
+		u32 dn_pp_bp:1;          /* [00:00] Default:0x0 RO */
+		u32 fem_pp_bp:1;         /* [01:01] Default:0x0 RO */
+		u32 pp_up_bp:1;          /* [02:02] Default:0x0 RO */
+		u32 inter_pp_bp:1;       /* [03:03] Default:0x0 RO */
+		u32 rsv:28;              /* [31:04] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP2_BP_STATE_DWLEN];
+} __packed;
+
+#define NBL_PP2_BP_HISTORY_ADDR  (0xb3430c)
+#define NBL_PP2_BP_HISTORY_DEPTH (1)
+#define NBL_PP2_BP_HISTORY_WIDTH (32)
+#define NBL_PP2_BP_HISTORY_DWLEN (1)
+union pp2_bp_history_u {
+	struct pp2_bp_history {
+		u32 dn_pp_bp:1;          /* [00:00] Default:0x0 RC */
+		u32 fem_pp_bp:1;         /* [01:01] Default:0x0 RC */
+		u32 pp_up_bp:1;          /* [02:02] Default:0x0 RC */
+		u32 inter_pp_bp:1;       /* [03:03] Default:0x0 RC */
+		u32 rsv:28;              /* [31:04] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP2_BP_HISTORY_DWLEN];
+} __packed;
+
+#define NBL_PP2_CFG_TEST_ADDR  (0xb3442c)
+#define NBL_PP2_CFG_TEST_DEPTH (1)
+#define NBL_PP2_CFG_TEST_WIDTH (32)
+#define NBL_PP2_CFG_TEST_DWLEN (1)
+union pp2_cfg_test_u {
+	struct pp2_cfg_test {
+		u32 test:32;             /* [31:00] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP2_CFG_TEST_DWLEN];
+} __packed;
+
+#define NBL_PP2_ABNORMAL_ACTION0_ADDR  (0xb34430)
+#define NBL_PP2_ABNORMAL_ACTION0_DEPTH (1)
+#define NBL_PP2_ABNORMAL_ACTION0_WIDTH (32)
+#define NBL_PP2_ABNORMAL_ACTION0_DWLEN (1)
+union pp2_abnormal_action0_u {
+	struct pp2_abnormal_action0 {
+		u32 data:22;             /* [21:00] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP2_ABNORMAL_ACTION0_DWLEN];
+} __packed;
+
+#define NBL_PP2_ABNORMAL_ACTION1_ADDR  (0xb34434)
+#define NBL_PP2_ABNORMAL_ACTION1_DEPTH (1)
+#define NBL_PP2_ABNORMAL_ACTION1_WIDTH (32)
+#define NBL_PP2_ABNORMAL_ACTION1_DWLEN (1)
+union pp2_abnormal_action1_u {
+	struct pp2_abnormal_action1 {
+		u32 data:22;             /* [21:00] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP2_ABNORMAL_ACTION1_DWLEN];
+} __packed;
+
+#define NBL_PP2_ABNORMAL_ACTION2_ADDR  (0xb34438)
+#define NBL_PP2_ABNORMAL_ACTION2_DEPTH (1)
+#define NBL_PP2_ABNORMAL_ACTION2_WIDTH (32)
+#define NBL_PP2_ABNORMAL_ACTION2_DWLEN (1)
+union pp2_abnormal_action2_u {
+	struct pp2_abnormal_action2 {
+		u32 data:22;             /* [21:00] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP2_ABNORMAL_ACTION2_DWLEN];
+} __packed;
+
+#define NBL_PP2_ABNORMAL_ACTION3_ADDR  (0xb3443c)
+#define NBL_PP2_ABNORMAL_ACTION3_DEPTH (1)
+#define NBL_PP2_ABNORMAL_ACTION3_WIDTH (32)
+#define NBL_PP2_ABNORMAL_ACTION3_DWLEN (1)
+union pp2_abnormal_action3_u {
+	struct pp2_abnormal_action3 {
+		u32 data:22;             /* [21:00] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP2_ABNORMAL_ACTION3_DWLEN];
+} __packed;
+
+#define NBL_PP2_ABNORMAL_ACTION4_ADDR  (0xb34440)
+#define NBL_PP2_ABNORMAL_ACTION4_DEPTH (1)
+#define NBL_PP2_ABNORMAL_ACTION4_WIDTH (32)
+#define NBL_PP2_ABNORMAL_ACTION4_DWLEN (1)
+union pp2_abnormal_action4_u {
+	struct pp2_abnormal_action4 {
+		u32 data:22;             /* [21:00] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP2_ABNORMAL_ACTION4_DWLEN];
+} __packed;
+
+#define NBL_PP2_ABNORMAL_ACTION5_ADDR  (0xb34444)
+#define NBL_PP2_ABNORMAL_ACTION5_DEPTH (1)
+#define NBL_PP2_ABNORMAL_ACTION5_WIDTH (32)
+#define NBL_PP2_ABNORMAL_ACTION5_DWLEN (1)
+union pp2_abnormal_action5_u {
+	struct pp2_abnormal_action5 {
+		u32 data:22;             /* [21:00] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP2_ABNORMAL_ACTION5_DWLEN];
+} __packed;
+
+#define NBL_PP2_ABNORMAL_ACTION6_ADDR  (0xb34448)
+#define NBL_PP2_ABNORMAL_ACTION6_DEPTH (1)
+#define NBL_PP2_ABNORMAL_ACTION6_WIDTH (32)
+#define NBL_PP2_ABNORMAL_ACTION6_DWLEN (1)
+union pp2_abnormal_action6_u {
+	struct pp2_abnormal_action6 {
+		u32 data:22;             /* [21:00] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP2_ABNORMAL_ACTION6_DWLEN];
+} __packed;
+
+#define NBL_PP2_ABNORMAL_ACTION7_ADDR  (0xb3444c)
+#define NBL_PP2_ABNORMAL_ACTION7_DEPTH (1)
+#define NBL_PP2_ABNORMAL_ACTION7_WIDTH (32)
+#define NBL_PP2_ABNORMAL_ACTION7_DWLEN (1)
+union pp2_abnormal_action7_u {
+	struct pp2_abnormal_action7 {
+		u32 data:22;             /* [21:00] Default:0x0 RW */
+		u32 rsv:10;              /* [31:22] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP2_ABNORMAL_ACTION7_DWLEN];
+} __packed;
+
+#define NBL_PP2_FWD_DPORT_ACTION_ADDR  (0xb34450)
+#define NBL_PP2_FWD_DPORT_ACTION_DEPTH (1)
+#define NBL_PP2_FWD_DPORT_ACTION_WIDTH (32)
+#define NBL_PP2_FWD_DPORT_ACTION_DWLEN (1)
+union pp2_fwd_dport_action_u {
+	struct pp2_fwd_dport_action {
+		u32 action_id:6;         /* [05:00] Default:0x9 RW */
+		u32 rsv:26;              /* [31:06] Default:0x0 RO */
+	} __packed info;
+	u32 data[NBL_PP2_FWD_DPORT_ACTION_DWLEN];
+} __packed;
+
+#define NBL_PP2_RDMA_VSI_BTM_ADDR  (0xb34454)
+#define NBL_PP2_RDMA_VSI_BTM_DEPTH (32)
+#define NBL_PP2_RDMA_VSI_BTM_WIDTH (32)
+#define NBL_PP2_RDMA_VSI_BTM_DWLEN (1)
+union pp2_rdma_vsi_btm_u {
+	struct pp2_rdma_vsi_btm {
+		u32 btm:32;              /* [31:00] Default:0x0 RW */
+	} __packed info;
+	u32 data[NBL_PP2_RDMA_VSI_BTM_DWLEN];
+} __packed;
+#define NBL_PP2_RDMA_VSI_BTM_REG(r) (NBL_PP2_RDMA_VSI_BTM_ADDR + \
+		(NBL_PP2_RDMA_VSI_BTM_DWLEN * 4) * (r))
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
index 393a9197c767..b0f53a755e86 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -5,18 +5,1557 @@
  */
 
 #include "nbl_hw_leonis.h"
+#include "nbl_hw/nbl_p4_actions.h"
+#include "nbl_hw/nbl_hw_leonis/base/nbl_datapath.h"
+#include "nbl_hw/nbl_hw_leonis/base/nbl_ppe.h"
+#include "nbl_hw_leonis_regs.h"
+
+static int dvn_descreq_num_cfg = DEFAULT_DVN_DESCREQ_NUMCFG;
+module_param(dvn_descreq_num_cfg, int, 0);
+MODULE_PARM_DESC(dvn_descreq_num_cfg,
+		 "bit[31:16]:split ring,support 8/16,bit[15:0]:packed ring, support 4*n,n:2-8");
+
 static u32 nbl_hw_get_quirks(void *priv)
 {
-	struct nbl_hw_mgt *hw_mgt = priv;
-	u32 quirks;
+	struct nbl_hw_mgt *hw_mgt = priv;
+	u32 quirks;
+
+	nbl_hw_read_mbx_regs(hw_mgt, NBL_LEONIS_QUIRKS_OFFSET,
+			     (u8 *)&quirks, sizeof(u32));
+
+	if (quirks == NBL_LEONIS_ILLEGAL_REG_VALUE)
+		return 0;
+
+	return quirks;
+}
+
+static void nbl_configure_dped_checksum(struct nbl_hw_mgt *hw_mgt)
+{
+	union dped_l4_ck_cmd_40_u l4_ck_cmd_40;
+
+	/* DPED dped_l4_ck_cmd_40 for sctp */
+	nbl_hw_read_regs(hw_mgt, NBL_DPED_L4_CK_CMD_40_ADDR,
+			 (u8 *)&l4_ck_cmd_40, sizeof(l4_ck_cmd_40));
+	l4_ck_cmd_40.info.en = 1;
+	nbl_hw_write_regs(hw_mgt, NBL_DPED_L4_CK_CMD_40_ADDR,
+			  (u8 *)&l4_ck_cmd_40, sizeof(l4_ck_cmd_40));
+}
+
+static int nbl_dped_init(struct nbl_hw_mgt *hw_mgt)
+{
+	nbl_hw_wr32(hw_mgt, NBL_DPED_VLAN_OFFSET, 0xC);
+	nbl_hw_wr32(hw_mgt, NBL_DPED_DSCP_OFFSET_0, 0x8);
+	nbl_hw_wr32(hw_mgt, NBL_DPED_DSCP_OFFSET_1, 0x4);
+
+	// dped checksum offload
+	nbl_configure_dped_checksum(hw_mgt);
+
+	return 0;
+}
+
+static int nbl_uped_init(struct nbl_hw_mgt *hw_mgt)
+{
+	struct ped_hw_edit_profile hw_edit;
+
+	nbl_hw_read_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(5), (u8 *)&hw_edit, sizeof(hw_edit));
+	hw_edit.l3_len = 0;
+	nbl_hw_write_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(5), (u8 *)&hw_edit, sizeof(hw_edit));
+
+	nbl_hw_read_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(6), (u8 *)&hw_edit, sizeof(hw_edit));
+	hw_edit.l3_len = 1;
+	nbl_hw_write_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(6), (u8 *)&hw_edit, sizeof(hw_edit));
+
+	return 0;
+}
+
+static void nbl_shaping_eth_init(struct nbl_hw_mgt *hw_mgt, u8 eth_id, u8 speed)
+{
+	struct nbl_shaping_dport dport = {0};
+	struct nbl_shaping_dvn_dport dvn_dport = {0};
+	u32 rate, half_rate;
+
+	if (speed == NBL_FW_PORT_SPEED_100G) {
+		rate = NBL_SHAPING_DPORT_100G_RATE;
+		half_rate = NBL_SHAPING_DPORT_HALF_100G_RATE;
+	} else {
+		rate = NBL_SHAPING_DPORT_25G_RATE;
+		half_rate = NBL_SHAPING_DPORT_HALF_25G_RATE;
+	}
+
+	dport.cir = rate;
+	dport.pir = rate;
+	dport.depth = max(dport.cir * 2, NBL_LR_LEONIS_NET_BUCKET_DEPTH);
+	dport.cbs = dport.depth;
+	dport.pbs = dport.depth;
+	dport.valid = 1;
+
+	dvn_dport.cir = half_rate;
+	dvn_dport.pir = rate;
+	dvn_dport.depth = dport.depth;
+	dvn_dport.cbs = dvn_dport.depth;
+	dvn_dport.pbs = dvn_dport.depth;
+	dvn_dport.valid = 1;
+
+	nbl_hw_write_regs(hw_mgt, NBL_SHAPING_DPORT_REG(eth_id), (u8 *)&dport, sizeof(dport));
+	nbl_hw_write_regs(hw_mgt, NBL_SHAPING_DVN_DPORT_REG(eth_id),
+			  (u8 *)&dvn_dport, sizeof(dvn_dport));
+}
+
+static int nbl_shaping_init(struct nbl_hw_mgt *hw_mgt, u8 speed)
+{
+	struct dsch_psha_en psha_en = {0};
+	struct nbl_shaping_net net_shaping = {0};
+
+	int i;
+
+	for (i = 0; i < NBL_MAX_ETHERNET; i++)
+		nbl_shaping_eth_init(hw_mgt, i, speed);
+
+	psha_en.en = 0xF;
+	nbl_hw_write_regs(hw_mgt, NBL_DSCH_PSHA_EN_ADDR, (u8 *)&psha_en, sizeof(psha_en));
+
+	for (i = 0; i < NBL_MAX_FUNC; i++)
+		nbl_hw_write_regs(hw_mgt, NBL_SHAPING_NET_REG(i),
+				  (u8 *)&net_shaping, sizeof(net_shaping));
+	return 0;
+}
+
+static int nbl_dsch_qid_max_init(struct nbl_hw_mgt *hw_mgt)
+{
+	struct dsch_vn_quanta quanta = {0};
+
+	quanta.h_qua = NBL_HOST_QUANTA;
+	quanta.e_qua = NBL_ECPU_QUANTA;
+	nbl_hw_write_regs(hw_mgt, NBL_DSCH_VN_QUANTA_ADDR,
+			  (u8 *)&quanta, sizeof(quanta));
+	nbl_hw_wr32(hw_mgt, NBL_DSCH_HOST_QID_MAX, NBL_MAX_QUEUE_ID);
+
+	nbl_hw_wr32(hw_mgt, NBL_DVN_ECPU_QUEUE_NUM, 0);
+	nbl_hw_wr32(hw_mgt, NBL_UVN_ECPU_QUEUE_NUM, 0);
+
+	return 0;
+}
+
+static int nbl_ustore_init(struct nbl_hw_mgt *hw_mgt, u8 eth_num)
+{
+	struct ustore_pkt_len pkt_len;
+	struct nbl_ustore_port_drop_th drop_th;
+	int i;
+
+	nbl_hw_read_regs(hw_mgt, NBL_USTORE_PKT_LEN_ADDR, (u8 *)&pkt_len, sizeof(pkt_len));
+	/* min arp packet length 42 (14 + 28) */
+	pkt_len.min = 42;
+	nbl_hw_write_regs(hw_mgt, NBL_USTORE_PKT_LEN_ADDR, (u8 *)&pkt_len, sizeof(pkt_len));
+
+	drop_th.en = 1;
+	if (eth_num == 1)
+		drop_th.disc_th = NBL_USTORE_SIGNLE_ETH_DROP_TH;
+	else if (eth_num == 2)
+		drop_th.disc_th = NBL_USTORE_DUAL_ETH_DROP_TH;
+	else
+		drop_th.disc_th = NBL_USTORE_QUAD_ETH_DROP_TH;
+
+	for (i = 0; i < 4; i++)
+		nbl_hw_write_regs(hw_mgt, NBL_USTORE_PORT_DROP_TH_REG_ARR(i),
+				  (u8 *)&drop_th, sizeof(drop_th));
+
+	for (i = 0; i < NBL_MAX_ETHERNET; i++) {
+		nbl_hw_rd32(hw_mgt, NBL_USTORE_BUF_PORT_DROP_PKT(i));
+		nbl_hw_rd32(hw_mgt, NBL_USTORE_BUF_PORT_TRUN_PKT(i));
+	}
+
+	return 0;
+}
+
+static int nbl_dstore_init(struct nbl_hw_mgt *hw_mgt, u8 speed)
+{
+	struct dstore_d_dport_fc_th fc_th;
+	struct dstore_port_drop_th drop_th;
+	struct dstore_disc_bp_th bp_th;
+	int i;
+
+	for (i = 0; i < 6; i++) {
+		nbl_hw_read_regs(hw_mgt, NBL_DSTORE_PORT_DROP_TH_REG(i),
+				 (u8 *)&drop_th, sizeof(drop_th));
+		drop_th.en = 0;
+		nbl_hw_write_regs(hw_mgt, NBL_DSTORE_PORT_DROP_TH_REG(i),
+				  (u8 *)&drop_th, sizeof(drop_th));
+	}
+
+	nbl_hw_read_regs(hw_mgt, NBL_DSTORE_DISC_BP_TH,
+			 (u8 *)&bp_th, sizeof(bp_th));
+	bp_th.en = 1;
+	nbl_hw_write_regs(hw_mgt, NBL_DSTORE_DISC_BP_TH,
+			  (u8 *)&bp_th, sizeof(bp_th));
+
+	for (i = 0; i < 4; i++) {
+		nbl_hw_read_regs(hw_mgt, NBL_DSTORE_D_DPORT_FC_TH_REG(i),
+				 (u8 *)&fc_th, sizeof(fc_th));
+		if (speed == NBL_FW_PORT_SPEED_100G) {
+			fc_th.xoff_th = NBL_DSTORE_DROP_XOFF_TH_100G;
+			fc_th.xon_th = NBL_DSTORE_DROP_XON_TH_100G;
+		} else {
+			fc_th.xoff_th = NBL_DSTORE_DROP_XOFF_TH;
+			fc_th.xon_th = NBL_DSTORE_DROP_XON_TH;
+		}
+
+		fc_th.fc_en = 1;
+		nbl_hw_write_regs(hw_mgt, NBL_DSTORE_D_DPORT_FC_TH_REG(i),
+				  (u8 *)&fc_th, sizeof(fc_th));
+	}
+
+	return 0;
+}
+
+static int nbl_ul4s_init(struct nbl_hw_mgt *hw_mgt)
+{
+	struct ul4s_sch_pad sch_pad;
+
+	nbl_hw_read_regs(hw_mgt, NBL_UL4S_SCH_PAD_ADDR, (u8 *)&sch_pad, sizeof(sch_pad));
+	sch_pad.en = 1;
+	nbl_hw_write_regs(hw_mgt, NBL_UL4S_SCH_PAD_ADDR, (u8 *)&sch_pad, sizeof(sch_pad));
+
+	return 0;
+}
+
+static void nbl_dvn_descreq_num_cfg(void *priv, u32 descreq_num)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_dvn_descreq_num_cfg descreq_num_cfg = { 0 };
+	u32 packet_ring_prefect_num = descreq_num & 0xffff;
+	u32 split_ring_prefect_num = (descreq_num >> 16) & 0xffff;
+
+	packet_ring_prefect_num = packet_ring_prefect_num > 32 ? 32 : packet_ring_prefect_num;
+	packet_ring_prefect_num = packet_ring_prefect_num < 8 ? 8 : packet_ring_prefect_num;
+	descreq_num_cfg.packed_l1_num = (packet_ring_prefect_num - 8) / 4;
+
+	split_ring_prefect_num = split_ring_prefect_num > 16 ? 16 : split_ring_prefect_num;
+	split_ring_prefect_num = split_ring_prefect_num < 8 ? 8 : split_ring_prefect_num;
+	descreq_num_cfg.avring_cfg_num = split_ring_prefect_num > 8 ? 1 : 0;
+
+	nbl_hw_write_regs(hw_mgt, NBL_DVN_DESCREQ_NUM_CFG,
+			  (u8 *)&descreq_num_cfg, sizeof(descreq_num_cfg));
+}
+
+static int nbl_dvn_init(struct nbl_hw_mgt *hw_mgt, u8 speed)
+{
+	struct nbl_dvn_desc_wr_merge_timeout timeout = {0};
+	struct nbl_dvn_dif_req_rd_ro_flag ro_flag = {0};
+
+	timeout.cfg_cycle = DEFAULT_DVN_DESC_WR_MERGE_TIMEOUT_MAX;
+	nbl_hw_write_regs(hw_mgt, NBL_DVN_DESC_WR_MERGE_TIMEOUT,
+			  (u8 *)&timeout, sizeof(timeout));
+
+	ro_flag.rd_desc_ro_en = 1;
+	ro_flag.rd_data_ro_en = 1;
+	ro_flag.rd_avring_ro_en = 1;
+	nbl_hw_write_regs(hw_mgt, NBL_DVN_DIF_REQ_RD_RO_FLAG,
+			  (u8 *)&ro_flag, sizeof(ro_flag));
+
+	if (speed == NBL_FW_PORT_SPEED_100G)
+		nbl_dvn_descreq_num_cfg(hw_mgt, DEFAULT_DVN_100G_DESCREQ_NUMCFG);
+	else
+		nbl_dvn_descreq_num_cfg(hw_mgt, dvn_descreq_num_cfg);
+
+	return 0;
+}
+
+static int nbl_uvn_init(struct nbl_hw_mgt *hw_mgt)
+{
+	struct pci_dev *pdev;
+	struct uvn_queue_err_mask mask = {0};
+	struct uvn_dif_req_ro_flag flag = {0};
+	struct uvn_desc_prefetch_init prefetch_init = {0};
+	u32 timeout = 119760; /* 200us 200000/1.67 */
+	u32 quirks;
+	struct uvn_desc_wr_timeout desc_wr_timeout = {0};
+	u16 wr_timeout = 0x12c;
+
+	pdev = NBL_COMMON_TO_PDEV(hw_mgt->common);
+	nbl_hw_wr32(hw_mgt, NBL_UVN_DESC_RD_WAIT, timeout);
+
+	desc_wr_timeout.num = wr_timeout;
+	nbl_hw_write_regs(hw_mgt, NBL_UVN_DESC_WR_TIMEOUT,
+			  (u8 *)&desc_wr_timeout, sizeof(desc_wr_timeout));
+
+	flag.avail_rd = 1;
+	flag.desc_rd = 1;
+	flag.pkt_wr = 1;
+	flag.desc_wr = 0;
+	nbl_hw_write_regs(hw_mgt, NBL_UVN_DIF_REQ_RO_FLAG, (u8 *)&flag, sizeof(flag));
+
+	nbl_hw_read_regs(hw_mgt, NBL_UVN_QUEUE_ERR_MASK, (u8 *)&mask, sizeof(mask));
+	mask.dif_err = 1;
+	nbl_hw_write_regs(hw_mgt, NBL_UVN_QUEUE_ERR_MASK, (u8 *)&mask, sizeof(mask));
+
+	prefetch_init.num = NBL_UVN_DESC_PREFETCH_NUM;
+	prefetch_init.sel = 0;
+
+	quirks = nbl_hw_get_quirks(hw_mgt);
+
+	if (!(quirks & BIT(NBL_QUIRKS_UVN_PREFETCH_ALIGN)))
+		prefetch_init.sel = 1;
+
+	nbl_hw_write_regs(hw_mgt, NBL_UVN_DESC_PREFETCH_INIT,
+			  (u8 *)&prefetch_init, sizeof(prefetch_init));
+
+	return 0;
+}
+
+static int nbl_uqm_init(struct nbl_hw_mgt *hw_mgt)
+{
+	struct nbl_uqm_que_type que_type = {0};
+	u32 cnt = 0;
+	int i;
+
+	nbl_hw_write_regs(hw_mgt, NBL_UQM_FWD_DROP_CNT, (u8 *)&cnt, sizeof(cnt));
+
+	nbl_hw_write_regs(hw_mgt, NBL_UQM_DROP_PKT_CNT, (u8 *)&cnt, sizeof(cnt));
+	nbl_hw_write_regs(hw_mgt, NBL_UQM_DROP_PKT_SLICE_CNT, (u8 *)&cnt, sizeof(cnt));
+	nbl_hw_write_regs(hw_mgt, NBL_UQM_DROP_PKT_LEN_ADD_CNT, (u8 *)&cnt, sizeof(cnt));
+	nbl_hw_write_regs(hw_mgt, NBL_UQM_DROP_HEAD_PNTR_ADD_CNT, (u8 *)&cnt, sizeof(cnt));
+	nbl_hw_write_regs(hw_mgt, NBL_UQM_DROP_WEIGHT_ADD_CNT, (u8 *)&cnt, sizeof(cnt));
+
+	for (i = 0; i < NBL_UQM_PORT_DROP_DEPTH; i++) {
+		nbl_hw_write_regs(hw_mgt, NBL_UQM_PORT_DROP_PKT_CNT + (sizeof(cnt) * i),
+				  (u8 *)&cnt, sizeof(cnt));
+		nbl_hw_write_regs(hw_mgt, NBL_UQM_PORT_DROP_PKT_SLICE_CNT + (sizeof(cnt) * i),
+				  (u8 *)&cnt, sizeof(cnt));
+		nbl_hw_write_regs(hw_mgt, NBL_UQM_PORT_DROP_PKT_LEN_ADD_CNT + (sizeof(cnt) * i),
+				  (u8 *)&cnt, sizeof(cnt));
+		nbl_hw_write_regs(hw_mgt, NBL_UQM_PORT_DROP_HEAD_PNTR_ADD_CNT + (sizeof(cnt) * i),
+				  (u8 *)&cnt, sizeof(cnt));
+		nbl_hw_write_regs(hw_mgt, NBL_UQM_PORT_DROP_WEIGHT_ADD_CNT + (sizeof(cnt) * i),
+				  (u8 *)&cnt, sizeof(cnt));
+	}
+
+	for (i = 0; i < NBL_UQM_DPORT_DROP_DEPTH; i++)
+		nbl_hw_write_regs(hw_mgt, NBL_UQM_DPORT_DROP_CNT + (sizeof(cnt) * i),
+				  (u8 *)&cnt, sizeof(cnt));
+
+	que_type.bp_drop = 0;
+	nbl_hw_write_regs(hw_mgt, NBL_UQM_QUE_TYPE, (u8 *)&que_type, sizeof(que_type));
+
+	return 0;
+}
+
+static int nbl_dp_init(struct nbl_hw_mgt *hw_mgt, u8 speed, u8 eth_num)
+{
+	nbl_dped_init(hw_mgt);
+	nbl_uped_init(hw_mgt);
+	nbl_shaping_init(hw_mgt, speed);
+	nbl_dsch_qid_max_init(hw_mgt);
+	nbl_ustore_init(hw_mgt, eth_num);
+	nbl_dstore_init(hw_mgt, speed);
+	nbl_ul4s_init(hw_mgt);
+	nbl_dvn_init(hw_mgt, speed);
+	nbl_uvn_init(hw_mgt);
+	nbl_uqm_init(hw_mgt);
+
+	return 0;
+}
+
+static void nbl_epro_mirror_act_pri_init(struct nbl_hw_mgt *hw_mgt,
+					 struct nbl_epro_mirror_act_pri *cfg)
+{
+	struct nbl_epro_mirror_act_pri epro_mirror_act_pri_def = {
+		.car_idx_pri		= EPRO_MIRROR_ACT_CARIDX_PRI,
+		.dqueue_pri		= EPRO_MIRROR_ACT_DQUEUE_PRI,
+		.dport_pri		= EPRO_MIRROR_ACT_DPORT_PRI,
+		.rsv			= 0
+	};
+
+	if (cfg)
+		epro_mirror_act_pri_def = *cfg;
+
+	nbl_hw_write_regs(hw_mgt, NBL_EPRO_MIRROR_ACT_PRI_REG, (u8 *)&epro_mirror_act_pri_def, 1);
+}
+
+static struct nbl_epro_action_filter_tbl epro_action_filter_tbl_def[NBL_FWD_TYPE_MAX] = {
+	[NBL_FWD_TYPE_NORMAL]		= {
+		BIT(NBL_MD_ACTION_MCIDX) | BIT(NBL_MD_ACTION_TABLE_INDEX) |
+		BIT(NBL_MD_ACTION_MIRRIDX)},
+	[NBL_FWD_TYPE_CPU_ASSIGNED]	= {
+		BIT(NBL_MD_ACTION_MCIDX) | BIT(NBL_MD_ACTION_TABLE_INDEX) |
+		BIT(NBL_MD_ACTION_MIRRIDX)
+	},
+	[NBL_FWD_TYPE_UPCALL]		= {0},
+	[NBL_FWD_TYPE_SRC_MIRROR]	= {
+			BIT(NBL_MD_ACTION_FLOWID0) | BIT(NBL_MD_ACTION_FLOWID1) |
+			BIT(NBL_MD_ACTION_RSSIDX) | BIT(NBL_MD_ACTION_TABLE_INDEX) |
+			BIT(NBL_MD_ACTION_MCIDX) | BIT(NBL_MD_ACTION_VNI0) |
+			BIT(NBL_MD_ACTION_VNI1) | BIT(NBL_MD_ACTION_PRBAC_IDX) |
+			BIT(NBL_MD_ACTION_L4S_IDX) | BIT(NBL_MD_ACTION_DP_HASH0) |
+			BIT(NBL_MD_ACTION_DP_HASH1) | BIT(NBL_MD_ACTION_MDF_PRI) |
+			BIT(NBL_MD_ACTION_FLOW_CARIDX) |
+			((u64)0xffffffff << 32)},
+	[NBL_FWD_TYPE_OTHER_MIRROR]	= {
+			BIT(NBL_MD_ACTION_FLOWID0) | BIT(NBL_MD_ACTION_FLOWID1) |
+			BIT(NBL_MD_ACTION_RSSIDX) | BIT(NBL_MD_ACTION_TABLE_INDEX) |
+			BIT(NBL_MD_ACTION_MCIDX) | BIT(NBL_MD_ACTION_VNI0) |
+			BIT(NBL_MD_ACTION_VNI1) | BIT(NBL_MD_ACTION_PRBAC_IDX) |
+			BIT(NBL_MD_ACTION_L4S_IDX) | BIT(NBL_MD_ACTION_DP_HASH0) |
+			BIT(NBL_MD_ACTION_DP_HASH1) | BIT(NBL_MD_ACTION_MDF_PRI)},
+	[NBL_FWD_TYPE_MNG]		= {0},
+	[NBL_FWD_TYPE_GLB_LB]		= {0},
+	[NBL_FWD_TYPE_DROP]		= {0},
+};
+
+static void nbl_epro_action_filter_cfg(struct nbl_hw_mgt *hw_mgt, u32 fwd_type,
+				       struct nbl_epro_action_filter_tbl *cfg)
+{
+	if (fwd_type >= NBL_FWD_TYPE_MAX) {
+		pr_err("fwd_type %u exceed the max num %u.", fwd_type, NBL_FWD_TYPE_MAX);
+		return;
+	}
+
+	nbl_hw_write_regs(hw_mgt, NBL_EPRO_ACTION_FILTER_TABLE(fwd_type),
+			  (u8 *)cfg, sizeof(*cfg));
+}
+
+static int nbl_epro_init(struct nbl_hw_mgt *hw_mgt)
+{
+	u32 fwd_type = 0;
+
+	nbl_epro_mirror_act_pri_init(hw_mgt, NULL);
+
+	for (fwd_type = 0; fwd_type < NBL_FWD_TYPE_MAX; fwd_type++)
+		nbl_epro_action_filter_cfg(hw_mgt, fwd_type,
+					   &epro_action_filter_tbl_def[fwd_type]);
+
+	return 0;
+}
+
+static int nbl_ppe_init(struct nbl_hw_mgt *hw_mgt)
+{
+	nbl_epro_init(hw_mgt);
+
+	return 0;
+}
+
+static int nbl_host_padpt_init(struct nbl_hw_mgt *hw_mgt)
+{
+	/* padpt flow  control register */
+	nbl_hw_wr32(hw_mgt, NBL_HOST_PADPT_HOST_CFG_FC_CPLH_UP, 0x10400);
+	nbl_hw_wr32(hw_mgt, NBL_HOST_PADPT_HOST_CFG_FC_PD_DN, 0x10080);
+	nbl_hw_wr32(hw_mgt, NBL_HOST_PADPT_HOST_CFG_FC_PH_DN, 0x10010);
+	nbl_hw_wr32(hw_mgt, NBL_HOST_PADPT_HOST_CFG_FC_NPH_DN, 0x10010);
+
+	return 0;
+}
+
+/* set padpt debug reg to cap for aged stop */
+static void nbl_host_pcap_init(struct nbl_hw_mgt *hw_mgt)
+{
+	int addr;
+
+	/* tx */
+	nbl_hw_wr32(hw_mgt, 0x15a4204, 0x4);
+	nbl_hw_wr32(hw_mgt, 0x15a4208, 0x10);
+
+	for (addr = 0x15a4300; addr <= 0x15a4338; addr += 4)
+		nbl_hw_wr32(hw_mgt, addr, 0x0);
+	nbl_hw_wr32(hw_mgt, 0x15a433c, 0xdf000000);
+
+	for (addr = 0x15a4340; addr <= 0x15a437c; addr += 4)
+		nbl_hw_wr32(hw_mgt, addr, 0x0);
+
+	/* rx */
+	nbl_hw_wr32(hw_mgt, 0x15a4804, 0x4);
+	nbl_hw_wr32(hw_mgt, 0x15a4808, 0x20);
+
+	for (addr = 0x15a4940; addr <= 0x15a4978; addr += 4)
+		nbl_hw_wr32(hw_mgt, addr, 0x0);
+	nbl_hw_wr32(hw_mgt, 0x15a497c, 0x0a000000);
+
+	for (addr = 0x15a4900; addr <= 0x15a4938; addr += 4)
+		nbl_hw_wr32(hw_mgt, addr, 0x0);
+	nbl_hw_wr32(hw_mgt, 0x15a493c, 0xbe000000);
+
+	nbl_hw_wr32(hw_mgt, 0x15a420c, 0x1);
+	nbl_hw_wr32(hw_mgt, 0x15a480c, 0x1);
+	nbl_hw_wr32(hw_mgt, 0x15a420c, 0x0);
+	nbl_hw_wr32(hw_mgt, 0x15a480c, 0x0);
+	nbl_hw_wr32(hw_mgt, 0x15a4200, 0x1);
+	nbl_hw_wr32(hw_mgt, 0x15a4800, 0x1);
+}
+
+static int nbl_intf_init(struct nbl_hw_mgt *hw_mgt)
+{
+	nbl_host_padpt_init(hw_mgt);
+	nbl_host_pcap_init(hw_mgt);
+
+	return 0;
+}
+
+static void nbl_hw_set_driver_status(struct nbl_hw_mgt *hw_mgt, bool active)
+{
+	u32 status = 0;
+
+	status = nbl_hw_rd32(hw_mgt, NBL_DRIVER_STATUS_REG);
+
+	status = (status & ~(1 << NBL_DRIVER_STATUS_BIT)) | (active << NBL_DRIVER_STATUS_BIT);
+
+	nbl_hw_wr32(hw_mgt, NBL_DRIVER_STATUS_REG, status);
+}
+
+static void nbl_hw_deinit_chip_module(void *priv)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+
+	nbl_hw_set_driver_status(hw_mgt, false);
+}
+
+static int nbl_hw_init_chip_module(void *priv, u8 eth_speed, u8 eth_num)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+
+	nbl_info(NBL_HW_MGT_TO_COMMON(hw_mgt), NBL_DEBUG_HW, "hw_chip_init");
+
+	nbl_dp_init(hw_mgt, eth_speed, eth_num);
+	nbl_ppe_init(hw_mgt);
+	nbl_intf_init(hw_mgt);
+
+	nbl_write_all_regs(hw_mgt);
+	nbl_hw_set_driver_status(hw_mgt, true);
+	hw_mgt->version = nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
+
+	return 0;
+}
+
+static int nbl_hw_init_qid_map_table(void *priv)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_virtio_qid_map_table info = {0}, info2 = {0};
+	struct device *dev = NBL_HW_MGT_TO_DEV(hw_mgt);
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
+				nbl_hw_write_regs(hw_mgt, NBL_PCOMPLETER_QID_MAP_REG_ARR(k, i),
+						  (u8 *)&info, sizeof(info));
+				nbl_hw_read_regs(hw_mgt, NBL_PCOMPLETER_QID_MAP_REG_ARR(k, i),
+						 (u8 *)&info2, sizeof(info2));
+				if (likely(!memcmp(&info, &info2, sizeof(info))))
+					break;
+				j++;
+			} while (j < NBL_REG_WRITE_MAX_TRY_TIMES);
+
+			if (j == NBL_REG_WRITE_MAX_TRY_TIMES)
+				dev_err(dev, "Write to qid map table entry %hu failed\n", i);
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
+	struct nbl_virtio_qid_map_table info = {0}, info_data = {0};
+	struct nbl_queue_table_select select = {0};
+	u64 reg;
+	int i, j;
+
+	if (hw_mgt->hw_status)
+		return 0;
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
+			reg = NBL_PCOMPLETER_QID_MAP_REG_ARR(qid_map_select, param->start + i);
+			nbl_hw_write_regs(hw_mgt, reg, (u8 *)(&info), sizeof(info));
+			nbl_hw_read_regs(hw_mgt, reg, (u8 *)(&info_data), sizeof(info_data));
+			if (likely(!memcmp(&info, &info_data, sizeof(info))))
+				break;
+			j++;
+		} while (j < NBL_REG_WRITE_MAX_TRY_TIMES);
+
+		if (j == NBL_REG_WRITE_MAX_TRY_TIMES)
+			nbl_err(common, NBL_DEBUG_QUEUE, "Write to qid map table entry %d failed\n",
+				param->start + i);
+	}
+
+	select.select = qid_map_select;
+	nbl_hw_write_regs(hw_mgt, NBL_PCOMPLETER_QUEUE_TABLE_SELECT_REG,
+			  (u8 *)&select, sizeof(select));
+
+	return 0;
+}
+
+static int nbl_hw_set_qid_map_ready(void *priv, bool ready)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_queue_table_ready queue_table_ready = {0};
+
+	queue_table_ready.ready = ready;
+	nbl_hw_write_regs(hw_mgt, NBL_PCOMPLETER_QUEUE_TABLE_READY_REG,
+			  (u8 *)&queue_table_ready, sizeof(queue_table_ready));
+
+	return 0;
+}
+
+static int nbl_hw_cfg_ipro_queue_tbl(void *priv, u16 queue_id, u16 vsi_id, u8 enable)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_ipro_queue_tbl ipro_queue_tbl = {0};
+
+	ipro_queue_tbl.vsi_en = enable;
+	ipro_queue_tbl.vsi_id = vsi_id;
+
+	nbl_hw_write_regs(hw_mgt, NBL_IPRO_QUEUE_TBL(queue_id),
+			  (u8 *)&ipro_queue_tbl, sizeof(ipro_queue_tbl));
+
+	return 0;
+}
+
+static int nbl_hw_cfg_ipro_dn_sport_tbl(void *priv, u16 vsi_id, u16 dst_eth_id,
+					u16 bmode, bool binit)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_ipro_dn_src_port_tbl dpsport = {0};
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
+		nbl_hw_read_regs(hw_mgt, NBL_IPRO_DN_SRC_PORT_TABLE(vsi_id),
+				 (u8 *)&dpsport, sizeof(struct nbl_ipro_dn_src_port_tbl));
+	}
+
+	if (bmode == BRIDGE_MODE_VEPA)
+		dpsport.set_dport.dport.down.next_stg_sel = NEXT_STG_SEL_EPRO;
+	else
+		dpsport.set_dport.dport.down.next_stg_sel = NEXT_STG_SEL_NONE;
+
+	nbl_hw_write_regs(hw_mgt, NBL_IPRO_DN_SRC_PORT_TABLE(vsi_id),
+			  (u8 *)&dpsport, sizeof(struct nbl_ipro_dn_src_port_tbl));
+
+	return 0;
+}
+
+static int nbl_hw_set_vnet_queue_info(void *priv, struct nbl_vnet_queue_info_param *param,
+				      u16 queue_id)
+{
+	struct nbl_hw_mgt_leonis *hw_mgt_leonis = (struct nbl_hw_mgt_leonis *)priv;
+	struct nbl_hw_mgt *hw_mgt = &hw_mgt_leonis->hw_mgt;
+	struct nbl_host_vnet_qinfo host_vnet_qinfo = {0};
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
+	nbl_hw_write_regs(hw_mgt, NBL_PADPT_HOST_VNET_QINFO_REG_ARR(queue_id),
+			  (u8 *)&host_vnet_qinfo, sizeof(host_vnet_qinfo));
+
+	return 0;
+}
+
+static int nbl_hw_clear_vnet_queue_info(void *priv, u16 queue_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_host_vnet_qinfo host_vnet_qinfo = {0};
+
+	nbl_hw_write_regs(hw_mgt, NBL_PADPT_HOST_VNET_QINFO_REG_ARR(queue_id),
+			  (u8 *)&host_vnet_qinfo, sizeof(host_vnet_qinfo));
+	return 0;
+}
+
+static int nbl_hw_reset_dvn_cfg(void *priv, u16 queue_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_common_info *common = NBL_HW_MGT_TO_COMMON(hw_mgt);
+	struct nbl_dvn_queue_reset queue_reset = {0};
+	struct nbl_dvn_queue_reset_done queue_reset_done = {0};
+	int i = 0;
+
+	queue_reset.dvn_queue_index = queue_id;
+	queue_reset.vld = 1;
+	nbl_hw_write_regs(hw_mgt, NBL_DVN_QUEUE_RESET_REG,
+			  (u8 *)&queue_reset, sizeof(queue_reset));
+
+	udelay(5);
+	nbl_hw_read_regs(hw_mgt, NBL_DVN_QUEUE_RESET_DONE_REG,
+			 (u8 *)&queue_reset_done, sizeof(queue_reset_done));
+	while (!queue_reset_done.flag) {
+		i++;
+		if (!(i % 10)) {
+			nbl_err(common, NBL_DEBUG_QUEUE, "Wait too long for tx queue reset to be done");
+			break;
+		}
+
+		udelay(5);
+		nbl_hw_read_regs(hw_mgt, NBL_DVN_QUEUE_RESET_DONE_REG,
+				 (u8 *)&queue_reset_done, sizeof(queue_reset_done));
+	}
+
+	nbl_debug(common, NBL_DEBUG_QUEUE, "dvn:%u cfg reset succedd, wait %d 5ns\n", queue_id, i);
+	return 0;
+}
+
+static int nbl_hw_reset_uvn_cfg(void *priv, u16 queue_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_common_info *common = NBL_HW_MGT_TO_COMMON(hw_mgt);
+	struct nbl_uvn_queue_reset queue_reset = {0};
+	struct nbl_uvn_queue_reset_done queue_reset_done = {0};
+	int i = 0;
+
+	queue_reset.index = queue_id;
+	queue_reset.vld = 1;
+	nbl_hw_write_regs(hw_mgt, NBL_UVN_QUEUE_RESET_REG,
+			  (u8 *)&queue_reset, sizeof(queue_reset));
+
+	udelay(5);
+	nbl_hw_read_regs(hw_mgt, NBL_UVN_QUEUE_RESET_DONE_REG,
+			 (u8 *)&queue_reset_done, sizeof(queue_reset_done));
+	while (!queue_reset_done.flag) {
+		i++;
+		if (!(i % 10)) {
+			nbl_err(common, NBL_DEBUG_QUEUE, "Wait too long for rx queue reset to be done");
+			break;
+		}
+
+		udelay(5);
+		nbl_hw_read_regs(hw_mgt, NBL_UVN_QUEUE_RESET_DONE_REG,
+				 (u8 *)&queue_reset_done, sizeof(queue_reset_done));
+	}
+
+	nbl_debug(common, NBL_DEBUG_QUEUE, "uvn:%u cfg reset succedd, wait %d 5ns\n", queue_id, i);
+	return 0;
+}
+
+static int nbl_hw_restore_dvn_context(void *priv, u16 queue_id, u16 split, u16 last_avail_index)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_common_info *common = NBL_HW_MGT_TO_COMMON(hw_mgt);
+	struct dvn_queue_context cxt = {0};
+
+	cxt.dvn_ring_wrap_counter = last_avail_index >> 15;
+	if (split)
+		cxt.dvn_avail_ring_read = last_avail_index;
+	else
+		cxt.dvn_l1_ring_read = last_avail_index & 0x7FFF;
+
+	nbl_hw_write_regs(hw_mgt, NBL_DVN_QUEUE_CXT_TABLE_ARR(queue_id), (u8 *)&cxt, sizeof(cxt));
+	nbl_info(common, NBL_DEBUG_QUEUE, "config tx ring: %u, last avail idx: %u\n",
+		 queue_id, last_avail_index);
+
+	return 0;
+}
+
+static int nbl_hw_restore_uvn_context(void *priv, u16 queue_id, u16 split, u16 last_avail_index)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_common_info *common = NBL_HW_MGT_TO_COMMON(hw_mgt);
+	struct uvn_queue_cxt cxt = {0};
+
+	cxt.wrap_count = last_avail_index >> 15;
+	if (split)
+		cxt.queue_head = last_avail_index;
+	else
+		cxt.queue_head = last_avail_index & 0x7FFF;
+
+	nbl_hw_write_regs(hw_mgt, NBL_UVN_QUEUE_CXT_TABLE_ARR(queue_id), (u8 *)&cxt, sizeof(cxt));
+	nbl_info(common, NBL_DEBUG_QUEUE, "config rx ring: %u, last avail idx: %u\n",
+		 queue_id, last_avail_index);
+
+	return 0;
+}
+
+static int nbl_hw_get_tx_queue_cfg(void *priv, void *data, u16 queue_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_queue_cfg_param *queue_cfg = (struct nbl_queue_cfg_param *)data;
+	struct dvn_queue_table info = {0};
+
+	nbl_hw_read_regs(hw_mgt, NBL_DVN_QUEUE_TABLE_ARR(queue_id), (u8 *)&info, sizeof(info));
+
+	queue_cfg->desc = info.dvn_queue_baddr;
+	queue_cfg->avail = info.dvn_avail_baddr;
+	queue_cfg->used = info.dvn_used_baddr;
+	queue_cfg->size = info.dvn_queue_size;
+	queue_cfg->split = info.dvn_queue_type;
+	queue_cfg->extend_header = info.dvn_extend_header_en;
+
+	return 0;
+}
+
+static int nbl_hw_get_rx_queue_cfg(void *priv, void *data, u16 queue_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_queue_cfg_param *queue_cfg = (struct nbl_queue_cfg_param *)data;
+	struct uvn_queue_table info = {0};
+
+	nbl_hw_read_regs(hw_mgt, NBL_UVN_QUEUE_TABLE_ARR(queue_id), (u8 *)&info, sizeof(info));
+
+	queue_cfg->desc = info.queue_baddr;
+	queue_cfg->avail = info.avail_baddr;
+	queue_cfg->used = info.used_baddr;
+	queue_cfg->size = info.queue_size_mask_pow;
+	queue_cfg->split = info.queue_type;
+	queue_cfg->extend_header = info.extend_header_en;
+	queue_cfg->half_offload_en = info.half_offload_en;
+	queue_cfg->rxcsum = info.guest_csum_en;
+
+	return 0;
+}
+
+static int nbl_hw_cfg_tx_queue(void *priv, void *data, u16 queue_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_queue_cfg_param *queue_cfg = (struct nbl_queue_cfg_param *)data;
+	struct dvn_queue_table info = {0};
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
+	nbl_hw_write_regs(hw_mgt, NBL_DVN_QUEUE_TABLE_ARR(queue_id), (u8 *)&info, sizeof(info));
+
+	return 0;
+}
+
+static int nbl_hw_cfg_rx_queue(void *priv, void *data, u16 queue_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_queue_cfg_param *queue_cfg = (struct nbl_queue_cfg_param *)data;
+	struct uvn_queue_table info = {0};
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
+	nbl_hw_write_regs(hw_mgt, NBL_UVN_QUEUE_TABLE_ARR(queue_id), (u8 *)&info, sizeof(info));
+
+	return 0;
+}
+
+static bool nbl_hw_check_q2tc(void *priv, u16 queue_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct dsch_vn_q2tc_cfg_tbl info;
 
-	nbl_hw_read_mbx_regs(hw_mgt, NBL_LEONIS_QUIRKS_OFFSET,
-			     (u8 *)&quirks, sizeof(u32));
+	nbl_hw_read_regs(hw_mgt, NBL_DSCH_VN_Q2TC_CFG_TABLE_REG_ARR(queue_id),
+			 (u8 *)&info, sizeof(info));
+	return info.vld;
+}
 
-	if (quirks == NBL_LEONIS_ILLEGAL_REG_VALUE)
-		return 0;
+static int nbl_hw_cfg_q2tc_netid(void *priv, u16 queue_id, u16 netid, u16 vld)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct dsch_vn_q2tc_cfg_tbl info;
 
-	return quirks;
+	nbl_hw_read_regs(hw_mgt, NBL_DSCH_VN_Q2TC_CFG_TABLE_REG_ARR(queue_id),
+			 (u8 *)&info, sizeof(info));
+	info.tcid = (info.tcid & 0x7) | (netid << 3);
+	info.vld = vld;
+
+	nbl_hw_write_regs(hw_mgt, NBL_DSCH_VN_Q2TC_CFG_TABLE_REG_ARR(queue_id),
+			  (u8 *)&info, sizeof(info));
+	return 0;
+}
+
+static void nbl_hw_active_shaping(void *priv, u16 func_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_shaping_net shaping_net = {0};
+	struct dsch_vn_sha2net_map_tbl sha2net = {0};
+	struct dsch_vn_net2sha_map_tbl net2sha = {0};
+
+	nbl_hw_read_regs(hw_mgt, NBL_SHAPING_NET(func_id),
+			 (u8 *)&shaping_net, sizeof(shaping_net));
+
+	if (!shaping_net.depth)
+		return;
+
+	sha2net.vld = 1;
+	nbl_hw_write_regs(hw_mgt, NBL_DSCH_VN_SHA2NET_MAP_TABLE_REG_ARR(func_id),
+			  (u8 *)&sha2net, sizeof(sha2net));
+
+	shaping_net.valid = 1;
+	nbl_hw_write_regs(hw_mgt, NBL_SHAPING_NET(func_id),
+			  (u8 *)&shaping_net, sizeof(shaping_net));
+
+	net2sha.vld = 1;
+	nbl_hw_write_regs(hw_mgt, NBL_DSCH_VN_NET2SHA_MAP_TABLE_REG_ARR(func_id),
+			  (u8 *)&net2sha, sizeof(net2sha));
+}
+
+static void nbl_hw_deactive_shaping(void *priv, u16 func_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_shaping_net shaping_net = {0};
+	struct dsch_vn_sha2net_map_tbl sha2net = {0};
+	struct dsch_vn_net2sha_map_tbl net2sha = {0};
+
+	nbl_hw_write_regs(hw_mgt, NBL_DSCH_VN_NET2SHA_MAP_TABLE_REG_ARR(func_id),
+			  (u8 *)&net2sha, sizeof(net2sha));
+
+	nbl_hw_read_regs(hw_mgt, NBL_SHAPING_NET(func_id),
+			 (u8 *)&shaping_net, sizeof(shaping_net));
+	shaping_net.valid = 0;
+	nbl_hw_write_regs(hw_mgt, NBL_SHAPING_NET(func_id),
+			  (u8 *)&shaping_net, sizeof(shaping_net));
+
+	nbl_hw_write_regs(hw_mgt, NBL_DSCH_VN_SHA2NET_MAP_TABLE_REG_ARR(func_id),
+			  (u8 *)&sha2net, sizeof(sha2net));
+}
+
+static int nbl_hw_set_shaping(void *priv, u16 func_id, u64 total_tx_rate, u64 burst,
+			      u8 vld, bool active)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_shaping_net shaping_net = {0};
+	struct dsch_vn_sha2net_map_tbl sha2net = {0};
+	struct dsch_vn_net2sha_map_tbl net2sha = {0};
+
+	if (vld) {
+		sha2net.vld = active;
+		nbl_hw_write_regs(hw_mgt, NBL_DSCH_VN_SHA2NET_MAP_TABLE_REG_ARR(func_id),
+				  (u8 *)&sha2net, sizeof(sha2net));
+	} else {
+		net2sha.vld = vld;
+		nbl_hw_write_regs(hw_mgt, NBL_DSCH_VN_NET2SHA_MAP_TABLE_REG_ARR(func_id),
+				  (u8 *)&net2sha, sizeof(net2sha));
+	}
+
+	/* cfg shaping cir/pir */
+	if (vld) {
+		shaping_net.valid = active;
+		/* total_tx_rate unit Mb/s  */
+		/* cir 1 default represents 1Mbps */
+		shaping_net.cir = total_tx_rate;
+		/* pir equal cir */
+		shaping_net.pir = shaping_net.cir;
+		if (burst)
+			shaping_net.depth = burst;
+		else
+			shaping_net.depth = max(shaping_net.cir * 2,
+						NBL_LR_LEONIS_NET_BUCKET_DEPTH);
+		shaping_net.cbs = shaping_net.depth;
+		shaping_net.pbs = shaping_net.depth;
+	}
+
+	nbl_hw_write_regs(hw_mgt, NBL_SHAPING_NET(func_id),
+			  (u8 *)&shaping_net, sizeof(shaping_net));
+
+	if (!vld) {
+		sha2net.vld = vld;
+		nbl_hw_write_regs(hw_mgt, NBL_DSCH_VN_SHA2NET_MAP_TABLE_REG_ARR(func_id),
+				  (u8 *)&sha2net, sizeof(sha2net));
+	} else {
+		net2sha.vld = active;
+		nbl_hw_write_regs(hw_mgt, NBL_DSCH_VN_NET2SHA_MAP_TABLE_REG_ARR(func_id),
+				  (u8 *)&net2sha, sizeof(net2sha));
+	}
+
+	return 0;
+}
+
+static int nbl_hw_set_ucar(void *priv, u16 vsi_id, u64 totel_rx_rate, u64 burst,
+			   u8 vld)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_common_info *common = NBL_HW_MGT_TO_COMMON(hw_mgt);
+	union ucar_flow_u ucar_flow = {.info = {0}};
+	union epro_vpt_u epro_vpt = {.info = {0}};
+	int car_id = 0;
+	int index = 0;
+
+	nbl_hw_read_regs(hw_mgt, NBL_EPRO_VPT_REG(vsi_id),
+			 (u8 *)&epro_vpt, sizeof(epro_vpt));
+	if (vld) {
+		if (epro_vpt.info.car_en) {
+			car_id = epro_vpt.info.car_id;
+		} else {
+			epro_vpt.info.car_en = 1;
+			for (; index < 1024; index++) {
+				nbl_hw_read_regs(hw_mgt, NBL_UCAR_FLOW_REG(index),
+						 (u8 *)&ucar_flow, sizeof(ucar_flow));
+				if (ucar_flow.info.valid == 0) {
+					car_id = index;
+					break;
+				}
+			}
+			if (car_id == 1024) {
+				nbl_err(common, NBL_DEBUG_HW, "Car ID exceeds the valid range!");
+				return -ENOMEM;
+			}
+			epro_vpt.info.car_id = car_id;
+			nbl_hw_write_regs(hw_mgt, NBL_EPRO_VPT_REG(vsi_id),
+					  (u8 *)&epro_vpt, sizeof(epro_vpt));
+		}
+	} else {
+		epro_vpt.info.car_en = 0;
+		car_id = epro_vpt.info.car_id;
+		epro_vpt.info.car_id = 0;
+		nbl_hw_write_regs(hw_mgt, NBL_EPRO_VPT_REG(vsi_id),
+				  (u8 *)&epro_vpt, sizeof(epro_vpt));
+	}
+
+	if (vld) {
+		ucar_flow.info.valid = 1;
+		ucar_flow.info.cir = totel_rx_rate;
+		ucar_flow.info.pir = totel_rx_rate;
+		if (burst)
+			ucar_flow.info.depth = burst;
+		else
+			ucar_flow.info.depth = NBL_UCAR_MAX_BUCKET_DEPTH;
+		ucar_flow.info.cbs = ucar_flow.info.depth;
+		ucar_flow.info.pbs = ucar_flow.info.depth;
+	}
+	nbl_hw_write_regs(hw_mgt, NBL_UCAR_FLOW_REG(car_id),
+			  (u8 *)&ucar_flow, sizeof(ucar_flow));
+
+	return 0;
+}
+
+static int nbl_hw_cfg_dsch_net_to_group(void *priv, u16 func_id, u16 group_id, u16 vld)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct dsch_vn_n2g_cfg_tbl info = {0};
+
+	info.grpid = group_id;
+	info.vld = vld;
+	nbl_hw_write_regs(hw_mgt, NBL_DSCH_VN_N2G_CFG_TABLE_REG_ARR(func_id),
+			  (u8 *)&info, sizeof(info));
+	return 0;
+}
+
+static int nbl_hw_cfg_epro_rss_ret(void *priv, u32 index, u8 size_type, u32 q_num,
+				   u16 *queue_list, const u32 *indir)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_common_info *common = NBL_HW_MGT_TO_COMMON(hw_mgt);
+	struct nbl_epro_rss_ret_tbl rss_ret = {0};
+	u32 table_id, table_end, group_count, odd_num, queue_id = 0;
+
+	group_count = NBL_EPRO_RSS_ENTRY_SIZE_UNIT << size_type;
+	if (group_count > NBL_EPRO_RSS_ENTRY_MAX_COUNT) {
+		nbl_err(common, NBL_DEBUG_QUEUE,
+			"Rss group entry size type %u exceed the max value %u",
+			size_type, NBL_EPRO_RSS_ENTRY_SIZE_256);
+		return -EINVAL;
+	}
+
+	if (q_num > group_count) {
+		nbl_err(common, NBL_DEBUG_QUEUE,
+			"q_num %u exceed the rss group count %u\n", q_num, group_count);
+		return -EINVAL;
+	}
+	if (index >= NBL_EPRO_RSS_RET_TBL_DEPTH ||
+	    (index + group_count) > NBL_EPRO_RSS_RET_TBL_DEPTH) {
+		nbl_err(common, NBL_DEBUG_QUEUE,
+			"index %u exceed the max table entry %u, entry size: %u\n",
+			index, NBL_EPRO_RSS_RET_TBL_DEPTH, group_count);
+		return -EINVAL;
+	}
+
+	table_id = index / 2;
+	table_end = (index + group_count) / 2;
+	odd_num = index % 2;
+	nbl_hw_read_regs(hw_mgt, NBL_EPRO_RSS_RET_TABLE(table_id),
+			 (u8 *)&rss_ret, sizeof(rss_ret));
+
+	if (indir) {
+		if (odd_num) {
+			rss_ret.vld1 = 1;
+			rss_ret.dqueue1 = indir[queue_id++];
+			nbl_hw_write_regs(hw_mgt, NBL_EPRO_RSS_RET_TABLE(table_id),
+					  (u8 *)&rss_ret, sizeof(rss_ret));
+			table_id++;
+		}
+
+		for (; table_id < table_end; table_id++) {
+			rss_ret.vld0 = 1;
+			rss_ret.dqueue0 = indir[queue_id++];
+			rss_ret.vld1 = 1;
+			rss_ret.dqueue1 = indir[queue_id++];
+			nbl_hw_write_regs(hw_mgt, NBL_EPRO_RSS_RET_TABLE(table_id),
+					  (u8 *)&rss_ret, sizeof(rss_ret));
+		}
+
+		nbl_hw_read_regs(hw_mgt, NBL_EPRO_RSS_RET_TABLE(table_id),
+				 (u8 *)&rss_ret, sizeof(rss_ret));
+
+		if (odd_num) {
+			rss_ret.vld0 = 1;
+			rss_ret.dqueue0 = indir[queue_id++];
+			nbl_hw_write_regs(hw_mgt, NBL_EPRO_RSS_RET_TABLE(table_id),
+					  (u8 *)&rss_ret, sizeof(rss_ret));
+		}
+	} else {
+		if (odd_num) {
+			rss_ret.vld1 = 1;
+			rss_ret.dqueue1 = queue_list[queue_id++];
+			nbl_hw_write_regs(hw_mgt, NBL_EPRO_RSS_RET_TABLE(table_id),
+					  (u8 *)&rss_ret, sizeof(rss_ret));
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
+			nbl_hw_write_regs(hw_mgt, NBL_EPRO_RSS_RET_TABLE(table_id),
+					  (u8 *)&rss_ret, sizeof(rss_ret));
+		}
+
+		nbl_hw_read_regs(hw_mgt, NBL_EPRO_RSS_RET_TABLE(table_id),
+				 (u8 *)&rss_ret, sizeof(rss_ret));
+
+		if (odd_num) {
+			rss_ret.vld0 = 1;
+			rss_ret.dqueue0 = queue_list[queue_id++];
+			nbl_hw_write_regs(hw_mgt, NBL_EPRO_RSS_RET_TABLE(table_id),
+					  (u8 *)&rss_ret, sizeof(rss_ret));
+		}
+	}
+
+	return 0;
+}
+
+static struct nbl_epro_rss_key epro_rss_key_def = {
+	.key0		= 0x6d5a6d5a6d5a6d5a,
+	.key1		= 0x6d5a6d5a6d5a6d5a,
+	.key2		= 0x6d5a6d5a6d5a6d5a,
+	.key3		= 0x6d5a6d5a6d5a6d5a,
+	.key4		= 0x6d5a6d5a6d5a6d5a,
+};
+
+static int nbl_hw_init_epro_rss_key(void *priv)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+
+	nbl_hw_write_regs(hw_mgt, NBL_EPRO_RSS_KEY_REG,
+			  (u8 *)&epro_rss_key_def, sizeof(epro_rss_key_def));
+
+	return 0;
+}
+
+static int nbl_hw_init_epro_vpt_tbl(void *priv, u16 vsi_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_epro_vpt_tbl epro_vpt_tbl = {0};
+
+	epro_vpt_tbl.vld = 1;
+	epro_vpt_tbl.fwd = NBL_EPRO_FWD_TYPE_DROP;
+	epro_vpt_tbl.rss_alg_sel = NBL_EPRO_RSS_ALG_TOEPLITZ_HASH;
+	epro_vpt_tbl.rss_key_type_ipv4	= NBL_EPRO_RSS_KEY_TYPE_IPV4_L4;
+	epro_vpt_tbl.rss_key_type_ipv6	= NBL_EPRO_RSS_KEY_TYPE_IPV6_L4;
+
+	nbl_hw_write_regs(hw_mgt, NBL_EPRO_VPT_TABLE(vsi_id),
+			  (u8 *)&epro_vpt_tbl,
+			  sizeof(struct nbl_epro_vpt_tbl));
+
+	return 0;
+}
+
+static int nbl_hw_set_epro_rss_pt(void *priv, u16 vsi_id, u16 rss_ret_base, u16 rss_entry_size)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_epro_rss_pt_tbl epro_rss_pt_tbl = {0};
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
+				rss_ret_base + (NBL_EPRO_RSS_ENTRY_SIZE_UNIT << entry_size);
+	} else {
+		epro_rss_pt_tbl.offset1_vld = 0;
+		epro_rss_pt_tbl.offset1 = 0;
+	}
+
+	nbl_hw_write_regs(hw_mgt, NBL_EPRO_RSS_PT_TABLE(vsi_id), (u8 *)&epro_rss_pt_tbl,
+			  sizeof(epro_rss_pt_tbl));
+
+	nbl_hw_read_regs(hw_mgt, NBL_EPRO_VPT_TABLE(vsi_id), (u8 *)&epro_vpt_tbl,
+			 sizeof(epro_vpt_tbl));
+	epro_vpt_tbl.fwd = NBL_EPRO_FWD_TYPE_NORMAL;
+	nbl_hw_write_regs(hw_mgt, NBL_EPRO_VPT_TABLE(vsi_id), (u8 *)&epro_vpt_tbl,
+			  sizeof(epro_vpt_tbl));
+
+	return 0;
+}
+
+static int nbl_hw_clear_epro_rss_pt(void *priv, u16 vsi_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_epro_rss_pt_tbl epro_rss_pt_tbl = {0};
+	struct nbl_epro_vpt_tbl epro_vpt_tbl;
+
+	nbl_hw_write_regs(hw_mgt, NBL_EPRO_RSS_PT_TABLE(vsi_id), (u8 *)&epro_rss_pt_tbl,
+			  sizeof(epro_rss_pt_tbl));
+
+	nbl_hw_read_regs(hw_mgt, NBL_EPRO_VPT_TABLE(vsi_id), (u8 *)&epro_vpt_tbl,
+			 sizeof(epro_vpt_tbl));
+	epro_vpt_tbl.fwd = NBL_EPRO_FWD_TYPE_DROP;
+	nbl_hw_write_regs(hw_mgt, NBL_EPRO_VPT_TABLE(vsi_id), (u8 *)&epro_vpt_tbl,
+			  sizeof(epro_vpt_tbl));
+
+	return 0;
+}
+
+static int nbl_hw_disable_dvn(void *priv, u16 queue_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct dvn_queue_table info = {0};
+
+	nbl_hw_read_regs(hw_mgt, NBL_DVN_QUEUE_TABLE_ARR(queue_id), (u8 *)&info, sizeof(info));
+	info.dvn_queue_en = 0;
+	nbl_hw_write_regs(hw_mgt, NBL_DVN_QUEUE_TABLE_ARR(queue_id), (u8 *)&info, sizeof(info));
+	return 0;
+}
+
+static int nbl_hw_disable_uvn(void *priv, u16 queue_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct uvn_queue_table info = {0};
+
+	nbl_hw_write_regs(hw_mgt, NBL_UVN_QUEUE_TABLE_ARR(queue_id), (u8 *)&info, sizeof(info));
+	return 0;
+}
+
+static bool nbl_hw_is_txq_drain_out(struct nbl_hw_mgt *hw_mgt, u16 queue_id,
+				    struct dsch_vn_tc_q_list_tbl *tc_q_list)
+{
+	nbl_hw_read_regs(hw_mgt, NBL_DSCH_VN_TC_Q_LIST_TABLE_REG_ARR(queue_id),
+			 (u8 *)tc_q_list, sizeof(*tc_q_list));
+	if (!tc_q_list->regi && !tc_q_list->fly)
+		return true;
+
+	return false;
+}
+
+static bool nbl_hw_is_rxq_drain_out(struct nbl_hw_mgt *hw_mgt, u16 queue_id)
+{
+	struct uvn_desc_cxt cache_ctx = {0};
+
+	nbl_hw_read_regs(hw_mgt, NBL_UVN_DESC_CXT_TABLE_ARR(queue_id),
+			 (u8 *)&cache_ctx, sizeof(cache_ctx));
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
+	struct dsch_vn_tc_q_list_tbl tc_q_list = {0};
+	struct dsch_vn_q2tc_cfg_tbl info;
+	int i = 0;
+
+	nbl_hw_read_regs(hw_mgt, NBL_DSCH_VN_Q2TC_CFG_TABLE_REG_ARR(queue_id),
+			 (u8 *)&info, sizeof(info));
+	info.vld = 0;
+	nbl_hw_write_regs(hw_mgt, NBL_DSCH_VN_Q2TC_CFG_TABLE_REG_ARR(queue_id),
+			  (u8 *)&info, sizeof(info));
+	do {
+		if (nbl_hw_is_txq_drain_out(hw_mgt, queue_id, &tc_q_list))
+			break;
+
+		usleep_range(10, 20);
+	} while (++i < NBL_DRAIN_WAIT_TIMES);
+
+	if (i >= NBL_DRAIN_WAIT_TIMES) {
+		nbl_err(common, NBL_DEBUG_QUEUE, "nbl queue %u lso dsch drain, regi %u, fly %u, vld %u\n",
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
+		nbl_err(common, NBL_DEBUG_QUEUE, "nbl queue %u rsc cache drain timeout\n",
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
+	struct dvn_queue_context dvn_ctx = {0};
+
+	nbl_hw_read_regs(hw_mgt, NBL_DVN_QUEUE_CXT_TABLE_ARR(queue_id),
+			 (u8 *)&dvn_ctx, sizeof(dvn_ctx));
+
+	nbl_debug(common, NBL_DEBUG_QUEUE, "DVNQ save ctx: %d packed: %08x %08x split: %08x\n",
+		  queue_id, dvn_ctx.dvn_ring_wrap_counter, dvn_ctx.dvn_l1_ring_read,
+		  dvn_ctx.dvn_avail_ring_idx);
+
+	if (split)
+		return (dvn_ctx.dvn_avail_ring_idx);
+	else
+		return (dvn_ctx.dvn_l1_ring_read & 0x7FFF) | (dvn_ctx.dvn_ring_wrap_counter << 15);
+}
+
+static u16 nbl_hw_save_uvn_ctx(void *priv, u16 queue_id, u16 split, u16 queue_size)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_common_info *common = NBL_HW_MGT_TO_COMMON(hw_mgt);
+	struct uvn_queue_cxt queue_cxt = {0};
+	struct uvn_desc_cxt desc_cxt = {0};
+	u16 cache_diff, queue_head, wrap_count;
+
+	nbl_hw_read_regs(hw_mgt, NBL_UVN_QUEUE_CXT_TABLE_ARR(queue_id),
+			 (u8 *)&queue_cxt, sizeof(queue_cxt));
+	nbl_hw_read_regs(hw_mgt, NBL_UVN_DESC_CXT_TABLE_ARR(queue_id),
+			 (u8 *)&desc_cxt, sizeof(desc_cxt));
+
+	nbl_debug(common, NBL_DEBUG_QUEUE,
+		  "UVN save ctx: %d cache_tail: %08x cache_head %08x queue_head: %08x\n",
+		  queue_id, desc_cxt.cache_tail, desc_cxt.cache_head, queue_cxt.queue_head);
+
+	cache_diff = (desc_cxt.cache_tail - desc_cxt.cache_head + 64) & (0x3F);
+	queue_head = (queue_cxt.queue_head - cache_diff + 65536) & (0xFFFF);
+	if (queue_size)
+		wrap_count = !((queue_head / queue_size) & 0x1);
+	else
+		return 0xffff;
+
+	nbl_debug(common, NBL_DEBUG_QUEUE, "UVN save ctx: %d packed: %08x %08x split: %08x\n",
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
+	struct nbl_ipro_upsport_tbl upsport = {0};
+	struct nbl_epro_ept_tbl ept_tbl = {0};
+	struct dsch_vn_g2p_cfg_tbl info = {0};
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
+	nbl_hw_write_regs(hw_mgt, NBL_IPRO_UP_SPORT_TABLE(eth_id),
+			  (u8 *)&upsport, sizeof(upsport));
+
+	nbl_hw_write_regs(hw_mgt, NBL_EPRO_EPT_TABLE(eth_id), (u8 *)&ept_tbl,
+			  sizeof(struct nbl_epro_ept_tbl));
+
+	nbl_hw_write_regs(hw_mgt, NBL_DSCH_VN_G2P_CFG_TABLE_REG_ARR(eth_id),
+			  (u8 *)&info, sizeof(info));
+}
+
+static void nbl_hw_init_pfc(void *priv, u8 ether_ports)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_epro_cos_map cos_map = {0};
+	struct nbl_upa_pri_sel_conf sel_conf = {0};
+	struct nbl_upa_pri_conf conf_table = {0};
+	struct nbl_dqm_rxmac_tx_port_bp_en_cfg dqm_port_bp_en = {0};
+	struct nbl_dqm_rxmac_tx_cos_bp_en_cfg dqm_cos_bp_en = {0};
+	struct nbl_uqm_rx_cos_bp_en_cfg uqm_rx_cos_bp_en = {0};
+	struct nbl_uqm_tx_cos_bp_en_cfg uqm_tx_cos_bp_en = {0};
+	struct nbl_ustore_port_fc_th ustore_port_fc_th = {0};
+	struct nbl_ustore_cos_fc_th ustore_cos_fc_th = {0};
+	struct nbl_epro_port_pri_mdf_en_cfg pri_mdf_en_cfg = {0};
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
+	nbl_hw_write_regs(hw_mgt, NBL_DQM_RXMAC_TX_PORT_BP_EN,
+			  (u8 *)(&dqm_port_bp_en), sizeof(dqm_port_bp_en));
+
+	/* TX bp: dqm donot send received ETH RX PFC to DSCH */
+	/* dqm rxmac_tx_cos_bp_en */
+	dqm_cos_bp_en.eth0 = 0;
+	dqm_cos_bp_en.eth1 = 0;
+	dqm_cos_bp_en.eth2 = 0;
+	dqm_cos_bp_en.eth3 = 0;
+	nbl_hw_write_regs(hw_mgt, NBL_DQM_RXMAC_TX_COS_BP_EN,
+			  (u8 *)(&dqm_cos_bp_en), sizeof(dqm_cos_bp_en));
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
+	nbl_hw_write_regs(hw_mgt, NBL_UQM_RX_COS_BP_EN, (u8 *)(&uqm_rx_cos_bp_en),
+			  sizeof(uqm_rx_cos_bp_en));
+
+	/* RX bp: uqm send received loopback/emp/rdma_e/rdma_h/l4s_e/l4s_h cos bp to USTORE */
+	/* uqm tx_cos_bp_en */
+	uqm_tx_cos_bp_en.vld_l = 0xFFFFFFFF;
+	uqm_tx_cos_bp_en.vld_h = 0xFF;
+	nbl_hw_write_regs(hw_mgt, NBL_UQM_TX_COS_BP_EN, (u8 *)(&uqm_tx_cos_bp_en),
+			  sizeof(uqm_tx_cos_bp_en));
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
+	nbl_hw_write_regs(hw_mgt, NBL_EPRO_PORT_PRI_MDF_EN, (u8 *)(&pri_mdf_en_cfg),
+			  sizeof(pri_mdf_en_cfg));
+
+	for (i = 0; i < ether_ports; i++) {
+		/* set default bp_mode: port */
+		/* RX bp: USTORE port bp th, enable send pause frame */
+		/* ustore port_fc_th */
+		ustore_port_fc_th.xoff_th = 0x190;
+		ustore_port_fc_th.xon_th = 0x190;
+		ustore_port_fc_th.fc_set = 0;
+		ustore_port_fc_th.fc_en = 1;
+		nbl_hw_write_regs(hw_mgt, NBL_USTORE_PORT_FC_TH_REG_ARR(i),
+				  (u8 *)(&ustore_port_fc_th), sizeof(ustore_port_fc_th));
+
+		for (j = 0; j < 8; j++) {
+			/* RX bp: ustore cos bp th, disable send pfc frame */
+			/* ustore cos_fc_th */
+			ustore_cos_fc_th.xoff_th = 0x64;
+			ustore_cos_fc_th.xon_th = 0x64;
+			ustore_cos_fc_th.fc_set = 0;
+			ustore_cos_fc_th.fc_en = 0;
+			nbl_hw_write_regs(hw_mgt, NBL_USTORE_COS_FC_TH_REG_ARR(i * 8 + j),
+					  (u8 *)(&ustore_cos_fc_th), sizeof(ustore_cos_fc_th));
+
+			/* downstream: sch_cos->pkt_cos or sch_cos->dscp */
+			/* epro sch_cos_map */
+			cos_map.pkt_cos = j;
+			cos_map.dscp = j << 3;
+			nbl_hw_write_regs(hw_mgt, NBL_EPRO_SCH_COS_MAP_TABLE(i, j),
+					  (u8 *)(&cos_map), sizeof(cos_map));
+		}
+	}
+
+	/* upstream: pkt dscp/802.1p -> sch_cos */
+	for (i = 0; i < ether_ports; i++) {
+		/* upstream: when pfc_mode is 802.1p, vlan pri -> sch_cos map table */
+		/* upa pri_conf_table */
+		conf_table.pri0 = 0;
+		conf_table.pri1 = 1;
+		conf_table.pri2 = 2;
+		conf_table.pri3 = 3;
+		conf_table.pri4 = 4;
+		conf_table.pri5 = 5;
+		conf_table.pri6 = 6;
+		conf_table.pri7 = 7;
+		nbl_hw_write_regs(hw_mgt, NBL_UPA_PRI_CONF_TABLE(i * 8),
+				  (u8 *)(&conf_table), sizeof(conf_table));
+
+		/* upstream: set default pfc_mode is 802.1p, use outer vlan */
+		/* upa pri_sel_conf */
+		sel_conf.pri_sel = (1 << 4 | 1 << 3);
+		nbl_hw_write_regs(hw_mgt, NBL_UPA_PRI_SEL_CONF_TABLE(i),
+				  (u8 *)(&sel_conf), sizeof(sel_conf));
+	}
 }
 
 static void nbl_hw_enable_mailbox_irq(void *priv, u16 func_id, bool enable_msix,
@@ -333,6 +1872,24 @@ static void nbl_hw_cfg_mailbox_qinfo(void *priv, u16 func_id, u16 bus, u16 devid
 			  (u8 *)&mb_qinfo_map, sizeof(mb_qinfo_map));
 }
 
+static void nbl_hw_set_promisc_mode(void *priv, u16 vsi_id, u16 eth_id, u16 mode)
+{
+	struct nbl_ipro_upsport_tbl upsport;
+
+	nbl_hw_read_regs(priv, NBL_IPRO_UP_SPORT_TABLE(eth_id),
+			 (u8 *)&upsport, sizeof(upsport));
+	if (mode) {
+		upsport.set_dport.dport.up.upcall_flag = AUX_FWD_TYPE_NML_FWD;
+		upsport.set_dport.dport.up.port_type = SET_DPORT_TYPE_VSI_HOST;
+		upsport.set_dport.dport.up.port_id = vsi_id;
+		upsport.set_dport.dport.up.next_stg_sel = NEXT_STG_SEL_NONE;
+	} else {
+		upsport.set_dport.data = 0xFFF;
+	}
+	nbl_hw_write_regs(priv, NBL_IPRO_UP_SPORT_TABLE(eth_id),
+			  (u8 *)&upsport, sizeof(upsport));
+}
+
 static void nbl_hw_set_coalesce(void *priv, u16 interrupt_id, u16 pnum, u16 rate)
 {
 	struct nbl_host_msix_info msix_info = { 0 };
@@ -346,6 +1903,41 @@ static void nbl_hw_set_coalesce(void *priv, u16 interrupt_id, u16 pnum, u16 rate
 			  (u8 *)&msix_info, sizeof(msix_info));
 }
 
+static int nbl_hw_set_spoof_check_addr(void *priv, u16 vsi_id, u8 *mac)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_ipro_dn_src_port_tbl dpsport = {0};
+	u8 reverse_mac[ETH_ALEN];
+
+	nbl_hw_read_regs(hw_mgt, NBL_IPRO_DN_SRC_PORT_TABLE(vsi_id),
+			 (u8 *)&dpsport, sizeof(struct nbl_ipro_dn_src_port_tbl));
+
+	nbl_convert_mac(mac, reverse_mac);
+	dpsport.smac_low = reverse_mac[0] | reverse_mac[1] << 8;
+	memcpy(&dpsport.smac_high, &reverse_mac[2], sizeof(u32));
+
+	nbl_hw_write_regs(hw_mgt, NBL_IPRO_DN_SRC_PORT_TABLE(vsi_id),
+			  (u8 *)&dpsport, sizeof(struct nbl_ipro_dn_src_port_tbl));
+
+	return 0;
+}
+
+static int nbl_hw_set_spoof_check_enable(void *priv, u16 vsi_id, u8 enable)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_ipro_dn_src_port_tbl dpsport = {0};
+
+	nbl_hw_read_regs(hw_mgt, NBL_IPRO_DN_SRC_PORT_TABLE(vsi_id),
+			 (u8 *)&dpsport, sizeof(struct nbl_ipro_dn_src_port_tbl));
+
+	dpsport.addr_check_en = enable;
+
+	nbl_hw_write_regs(hw_mgt, NBL_IPRO_DN_SRC_PORT_TABLE(vsi_id),
+			  (u8 *)&dpsport, sizeof(struct nbl_ipro_dn_src_port_tbl));
+
+	return 0;
+}
+
 static void nbl_hw_config_adminq_rxq(void *priv, dma_addr_t dma_addr, int size_bwid)
 {
 	struct nbl_mailbox_qinfo_cfg_table qinfo_cfg_rx_table = { 0 };
@@ -634,6 +2226,19 @@ static int nbl_hw_process_abnormal_event(void *priv, struct nbl_abnormal_event_i
 	return ret;
 }
 
+static u32 nbl_hw_get_uvn_desc_entry_stats(void *priv)
+{
+	return nbl_hw_rd32(priv, NBL_UVN_DESC_RD_ENTRY);
+}
+
+static void nbl_hw_set_uvn_desc_wr_timeout(void *priv, u16 timeout)
+{
+	struct uvn_desc_wr_timeout wr_timeout = {0};
+
+	wr_timeout.num = timeout;
+	nbl_hw_write_regs(priv, NBL_UVN_DESC_WR_TIMEOUT, (u8 *)&wr_timeout, sizeof(wr_timeout));
+}
+
 static void nbl_hw_get_board_info(void *priv, struct nbl_board_port_info *board_info)
 {
 	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
@@ -677,7 +2282,62 @@ static enum nbl_hw_status nbl_hw_get_hw_status(void *priv)
 	return hw_mgt->hw_status;
 };
 
+static int nbl_hw_get_uvn_pkt_drop_stats(void *priv, u16 global_queue_id, u32 *uvn_stat_pkt_drop)
+{
+	*uvn_stat_pkt_drop = nbl_hw_rd32(priv, NBL_UVN_STATIS_PKT_DROP(global_queue_id));
+	return 0;
+}
+
+static int nbl_hw_get_ustore_pkt_drop_stats(void *priv, u8 eth_id,
+					    struct nbl_ustore_stats *ustore_stats)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+
+	ustore_stats->rx_drop_packets = nbl_hw_rd32(hw_mgt, NBL_USTORE_BUF_PORT_DROP_PKT(eth_id));
+	ustore_stats->rx_trun_packets = nbl_hw_rd32(hw_mgt, NBL_USTORE_BUF_PORT_TRUN_PKT(eth_id));
+
+	return 0;
+}
+
 static struct nbl_hw_ops hw_ops = {
+	.init_chip_module		= nbl_hw_init_chip_module,
+	.deinit_chip_module		= nbl_hw_deinit_chip_module,
+	.init_qid_map_table		= nbl_hw_init_qid_map_table,
+	.set_qid_map_table		= nbl_hw_set_qid_map_table,
+	.set_qid_map_ready		= nbl_hw_set_qid_map_ready,
+	.cfg_ipro_queue_tbl		= nbl_hw_cfg_ipro_queue_tbl,
+	.cfg_ipro_dn_sport_tbl		= nbl_hw_cfg_ipro_dn_sport_tbl,
+	.set_vnet_queue_info		= nbl_hw_set_vnet_queue_info,
+	.clear_vnet_queue_info		= nbl_hw_clear_vnet_queue_info,
+	.reset_dvn_cfg			= nbl_hw_reset_dvn_cfg,
+	.reset_uvn_cfg			= nbl_hw_reset_uvn_cfg,
+	.restore_dvn_context		= nbl_hw_restore_dvn_context,
+	.restore_uvn_context		= nbl_hw_restore_uvn_context,
+	.get_tx_queue_cfg		= nbl_hw_get_tx_queue_cfg,
+	.get_rx_queue_cfg		= nbl_hw_get_rx_queue_cfg,
+	.cfg_tx_queue			= nbl_hw_cfg_tx_queue,
+	.cfg_rx_queue			= nbl_hw_cfg_rx_queue,
+	.check_q2tc			= nbl_hw_check_q2tc,
+	.cfg_q2tc_netid			= nbl_hw_cfg_q2tc_netid,
+	.active_shaping			= nbl_hw_active_shaping,
+	.deactive_shaping		= nbl_hw_deactive_shaping,
+	.set_shaping			= nbl_hw_set_shaping,
+	.set_ucar			= nbl_hw_set_ucar,
+	.cfg_dsch_net_to_group		= nbl_hw_cfg_dsch_net_to_group,
+	.init_epro_rss_key		= nbl_hw_init_epro_rss_key,
+	.init_epro_vpt_tbl		= nbl_hw_init_epro_vpt_tbl,
+	.cfg_epro_rss_ret		= nbl_hw_cfg_epro_rss_ret,
+	.set_epro_rss_pt		= nbl_hw_set_epro_rss_pt,
+	.clear_epro_rss_pt		= nbl_hw_clear_epro_rss_pt,
+	.set_promisc_mode		= nbl_hw_set_promisc_mode,
+	.disable_dvn			= nbl_hw_disable_dvn,
+	.disable_uvn			= nbl_hw_disable_uvn,
+	.lso_dsch_drain			= nbl_hw_lso_dsch_drain,
+	.rsc_cache_drain		= nbl_hw_rsc_cache_drain,
+	.save_dvn_ctx			= nbl_hw_save_dvn_ctx,
+	.save_uvn_ctx			= nbl_hw_save_uvn_ctx,
+	.setup_queue_switch		= nbl_hw_setup_queue_switch,
+	.init_pfc			= nbl_hw_init_pfc,
 	.configure_msix_map		= nbl_hw_configure_msix_map,
 	.configure_msix_info		= nbl_hw_configure_msix_info,
 	.set_coalesce			= nbl_hw_set_coalesce,
@@ -708,11 +2368,16 @@ static struct nbl_hw_ops hw_ops = {
 	.update_adminq_queue_tail_ptr	= nbl_hw_update_adminq_queue_tail_ptr,
 	.check_adminq_dma_err		= nbl_hw_check_adminq_dma_err,
 
+	.set_spoof_check_addr		= nbl_hw_set_spoof_check_addr,
+	.set_spoof_check_enable		= nbl_hw_set_spoof_check_enable,
 	.get_hw_addr			= nbl_hw_get_hw_addr,
 	.set_fw_ping			= nbl_hw_set_fw_ping,
 	.get_fw_pong			= nbl_hw_get_fw_pong,
 	.set_fw_pong			= nbl_hw_set_fw_pong,
+
 	.process_abnormal_event		= nbl_hw_process_abnormal_event,
+	.get_uvn_desc_entry_stats	= nbl_hw_get_uvn_desc_entry_stats,
+	.set_uvn_desc_wr_timeout	= nbl_hw_set_uvn_desc_wr_timeout,
 	.get_fw_eth_num			= nbl_hw_get_fw_eth_num,
 	.get_fw_eth_map			= nbl_hw_get_fw_eth_map,
 	.get_board_info			= nbl_hw_get_board_info,
@@ -720,6 +2385,8 @@ static struct nbl_hw_ops hw_ops = {
 	.set_hw_status			= nbl_hw_set_hw_status,
 	.get_hw_status			= nbl_hw_get_hw_status,
 
+	.get_uvn_pkt_drop_stats		= nbl_hw_get_uvn_pkt_drop_stats,
+	.get_ustore_pkt_drop_stats	= nbl_hw_get_ustore_pkt_drop_stats,
 };
 
 /* Structure starts here, adding an op should not modify anything below */
@@ -879,3 +2546,4 @@ void nbl_hw_remove_leonis(void *p)
 
 	nbl_hw_remove_ops(common, hw_ops_tbl);
 }
+
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.c
new file mode 100644
index 000000000000..2c480d89c5c1
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.c
@@ -0,0 +1,3864 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#include "nbl_hw_reg.h"
+#include "nbl_hw_leonis.h"
+#include "nbl_hw_leonis_regs.h"
+
+#define NBL_SEC_BLOCK_SIZE		(0x100)
+#define NBL_SEC000_SIZE			(1)
+#define NBL_SEC000_ADDR			(0x114150)
+#define NBL_SEC001_SIZE			(1)
+#define NBL_SEC001_ADDR			(0x15c190)
+#define NBL_SEC002_SIZE			(1)
+#define NBL_SEC002_ADDR			(0x10417c)
+#define NBL_SEC003_SIZE			(1)
+#define NBL_SEC003_ADDR			(0x714154)
+#define NBL_SEC004_SIZE			(1)
+#define NBL_SEC004_ADDR			(0x75c190)
+#define NBL_SEC005_SIZE			(1)
+#define NBL_SEC005_ADDR			(0x70417c)
+#define NBL_SEC006_SIZE			(512)
+#define NBL_SEC006_ADDR			(0x8f000)
+#define NBL_SEC006_REGI(i)		(0x8f000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC007_SIZE			(256)
+#define NBL_SEC007_ADDR			(0x8f800)
+#define NBL_SEC007_REGI(i)		(0x8f800 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC008_SIZE			(1024)
+#define NBL_SEC008_ADDR			(0x90000)
+#define NBL_SEC008_REGI(i)		(0x90000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC009_SIZE			(2048)
+#define NBL_SEC009_ADDR			(0x94000)
+#define NBL_SEC009_REGI(i)		(0x94000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC010_SIZE			(256)
+#define NBL_SEC010_ADDR			(0x96000)
+#define NBL_SEC010_REGI(i)		(0x96000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC011_SIZE			(1024)
+#define NBL_SEC011_ADDR			(0x91000)
+#define NBL_SEC011_REGI(i)		(0x91000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC012_SIZE			(128)
+#define NBL_SEC012_ADDR			(0x92000)
+#define NBL_SEC012_REGI(i)		(0x92000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC013_SIZE			(64)
+#define NBL_SEC013_ADDR			(0x92200)
+#define NBL_SEC013_REGI(i)		(0x92200 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC014_SIZE			(64)
+#define NBL_SEC014_ADDR			(0x92300)
+#define NBL_SEC014_REGI(i)		(0x92300 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC015_SIZE			(1)
+#define NBL_SEC015_ADDR			(0x8c214)
+#define NBL_SEC016_SIZE			(1)
+#define NBL_SEC016_ADDR			(0x8c220)
+#define NBL_SEC017_SIZE			(1)
+#define NBL_SEC017_ADDR			(0x8c224)
+#define NBL_SEC018_SIZE			(1)
+#define NBL_SEC018_ADDR			(0x8c228)
+#define NBL_SEC019_SIZE			(1)
+#define NBL_SEC019_ADDR			(0x8c22c)
+#define NBL_SEC020_SIZE			(1)
+#define NBL_SEC020_ADDR			(0x8c1f0)
+#define NBL_SEC021_SIZE			(1)
+#define NBL_SEC021_ADDR			(0x8c1f8)
+#define NBL_SEC022_SIZE			(256)
+#define NBL_SEC022_ADDR			(0x85f000)
+#define NBL_SEC022_REGI(i)		(0x85f000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC023_SIZE			(128)
+#define NBL_SEC023_ADDR			(0x85f800)
+#define NBL_SEC023_REGI(i)		(0x85f800 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC024_SIZE			(512)
+#define NBL_SEC024_ADDR			(0x860000)
+#define NBL_SEC024_REGI(i)		(0x860000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC025_SIZE			(1024)
+#define NBL_SEC025_ADDR			(0x864000)
+#define NBL_SEC025_REGI(i)		(0x864000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC026_SIZE			(256)
+#define NBL_SEC026_ADDR			(0x866000)
+#define NBL_SEC026_REGI(i)		(0x866000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC027_SIZE			(512)
+#define NBL_SEC027_ADDR			(0x861000)
+#define NBL_SEC027_REGI(i)		(0x861000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC028_SIZE			(64)
+#define NBL_SEC028_ADDR			(0x862000)
+#define NBL_SEC028_REGI(i)		(0x862000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC029_SIZE			(32)
+#define NBL_SEC029_ADDR			(0x862200)
+#define NBL_SEC029_REGI(i)		(0x862200 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC030_SIZE			(32)
+#define NBL_SEC030_ADDR			(0x862300)
+#define NBL_SEC030_REGI(i)		(0x862300 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC031_SIZE			(1)
+#define NBL_SEC031_ADDR			(0x85c214)
+#define NBL_SEC032_SIZE			(1)
+#define NBL_SEC032_ADDR			(0x85c220)
+#define NBL_SEC033_SIZE			(1)
+#define NBL_SEC033_ADDR			(0x85c224)
+#define NBL_SEC034_SIZE			(1)
+#define NBL_SEC034_ADDR			(0x85c228)
+#define NBL_SEC035_SIZE			(1)
+#define NBL_SEC035_ADDR			(0x85c22c)
+#define NBL_SEC036_SIZE			(1)
+#define NBL_SEC036_ADDR			(0xb04200)
+#define NBL_SEC037_SIZE			(1)
+#define NBL_SEC037_ADDR			(0xb04230)
+#define NBL_SEC038_SIZE			(1)
+#define NBL_SEC038_ADDR			(0xb04234)
+#define NBL_SEC039_SIZE			(64)
+#define NBL_SEC039_ADDR			(0xb05800)
+#define NBL_SEC039_REGI(i)		(0xb05800 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC040_SIZE			(32)
+#define NBL_SEC040_ADDR			(0xb05400)
+#define NBL_SEC040_REGI(i)		(0xb05400 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC041_SIZE			(16)
+#define NBL_SEC041_ADDR			(0xb05500)
+#define NBL_SEC041_REGI(i)		(0xb05500 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC042_SIZE			(1)
+#define NBL_SEC042_ADDR			(0xb14148)
+#define NBL_SEC043_SIZE			(1)
+#define NBL_SEC043_ADDR			(0xb14104)
+#define NBL_SEC044_SIZE			(1)
+#define NBL_SEC044_ADDR			(0xb1414c)
+#define NBL_SEC045_SIZE			(1)
+#define NBL_SEC045_ADDR			(0xb14150)
+#define NBL_SEC046_SIZE			(256)
+#define NBL_SEC046_ADDR			(0xb15000)
+#define NBL_SEC046_REGI(i)		(0xb15000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC047_SIZE			(32)
+#define NBL_SEC047_ADDR			(0xb15800)
+#define NBL_SEC047_REGI(i)		(0xb15800 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC048_SIZE			(1)
+#define NBL_SEC048_ADDR			(0xb24148)
+#define NBL_SEC049_SIZE			(1)
+#define NBL_SEC049_ADDR			(0xb24104)
+#define NBL_SEC050_SIZE			(1)
+#define NBL_SEC050_ADDR			(0xb2414c)
+#define NBL_SEC051_SIZE			(1)
+#define NBL_SEC051_ADDR			(0xb24150)
+#define NBL_SEC052_SIZE			(256)
+#define NBL_SEC052_ADDR			(0xb25000)
+#define NBL_SEC052_REGI(i)		(0xb25000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC053_SIZE			(32)
+#define NBL_SEC053_ADDR			(0xb25800)
+#define NBL_SEC053_REGI(i)		(0xb25800 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC054_SIZE			(1)
+#define NBL_SEC054_ADDR			(0xb34148)
+#define NBL_SEC055_SIZE			(1)
+#define NBL_SEC055_ADDR			(0xb34104)
+#define NBL_SEC056_SIZE			(1)
+#define NBL_SEC056_ADDR			(0xb3414c)
+#define NBL_SEC057_SIZE			(1)
+#define NBL_SEC057_ADDR			(0xb34150)
+#define NBL_SEC058_SIZE			(256)
+#define NBL_SEC058_ADDR			(0xb35000)
+#define NBL_SEC058_REGI(i)		(0xb35000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC059_SIZE			(32)
+#define NBL_SEC059_ADDR			(0xb35800)
+#define NBL_SEC059_REGI(i)		(0xb35800 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC060_SIZE			(1)
+#define NBL_SEC060_ADDR			(0xe74630)
+#define NBL_SEC061_SIZE			(1)
+#define NBL_SEC061_ADDR			(0xe74634)
+#define NBL_SEC062_SIZE			(64)
+#define NBL_SEC062_ADDR			(0xe75000)
+#define NBL_SEC062_REGI(i)		(0xe75000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC063_SIZE			(32)
+#define NBL_SEC063_ADDR			(0xe75480)
+#define NBL_SEC063_REGI(i)		(0xe75480 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC064_SIZE			(16)
+#define NBL_SEC064_ADDR			(0xe75980)
+#define NBL_SEC064_REGI(i)		(0xe75980 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC065_SIZE			(32)
+#define NBL_SEC065_ADDR			(0x15f000)
+#define NBL_SEC065_REGI(i)		(0x15f000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC066_SIZE			(32)
+#define NBL_SEC066_ADDR			(0x75f000)
+#define NBL_SEC066_REGI(i)		(0x75f000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC067_SIZE			(1)
+#define NBL_SEC067_ADDR			(0xb64108)
+#define NBL_SEC068_SIZE			(1)
+#define NBL_SEC068_ADDR			(0xb6410c)
+#define NBL_SEC069_SIZE			(1)
+#define NBL_SEC069_ADDR			(0xb64140)
+#define NBL_SEC070_SIZE			(1)
+#define NBL_SEC070_ADDR			(0xb64144)
+#define NBL_SEC071_SIZE			(512)
+#define NBL_SEC071_ADDR			(0xb65000)
+#define NBL_SEC071_REGI(i)		(0xb65000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC072_SIZE			(32)
+#define NBL_SEC072_ADDR			(0xb65800)
+#define NBL_SEC072_REGI(i)		(0xb65800 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC073_SIZE			(1)
+#define NBL_SEC073_ADDR			(0x8c210)
+#define NBL_SEC074_SIZE			(1)
+#define NBL_SEC074_ADDR			(0x85c210)
+#define NBL_SEC075_SIZE			(4)
+#define NBL_SEC075_ADDR			(0x8c1b0)
+#define NBL_SEC075_REGI(i)		(0x8c1b0 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC076_SIZE			(4)
+#define NBL_SEC076_ADDR			(0x8c1c0)
+#define NBL_SEC076_REGI(i)		(0x8c1c0 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC077_SIZE			(4)
+#define NBL_SEC077_ADDR			(0x85c1b0)
+#define NBL_SEC077_REGI(i)		(0x85c1b0 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC078_SIZE			(1)
+#define NBL_SEC078_ADDR			(0x85c1ec)
+#define NBL_SEC079_SIZE			(1)
+#define NBL_SEC079_ADDR			(0x8c1ec)
+#define NBL_SEC080_SIZE			(1)
+#define NBL_SEC080_ADDR			(0xb04440)
+#define NBL_SEC081_SIZE			(1)
+#define NBL_SEC081_ADDR			(0xb04448)
+#define NBL_SEC082_SIZE			(1)
+#define NBL_SEC082_ADDR			(0xb14450)
+#define NBL_SEC083_SIZE			(1)
+#define NBL_SEC083_ADDR			(0xb24450)
+#define NBL_SEC084_SIZE			(1)
+#define NBL_SEC084_ADDR			(0xb34450)
+#define NBL_SEC085_SIZE			(1)
+#define NBL_SEC085_ADDR			(0xa04188)
+#define NBL_SEC086_SIZE			(1)
+#define NBL_SEC086_ADDR			(0xe74218)
+#define NBL_SEC087_SIZE			(1)
+#define NBL_SEC087_ADDR			(0xe7421c)
+#define NBL_SEC088_SIZE			(1)
+#define NBL_SEC088_ADDR			(0xe74220)
+#define NBL_SEC089_SIZE			(1)
+#define NBL_SEC089_ADDR			(0xe74224)
+#define NBL_SEC090_SIZE			(1)
+#define NBL_SEC090_ADDR			(0x75c22c)
+#define NBL_SEC091_SIZE			(1)
+#define NBL_SEC091_ADDR			(0x75c230)
+#define NBL_SEC092_SIZE			(1)
+#define NBL_SEC092_ADDR			(0x75c238)
+#define NBL_SEC093_SIZE			(1)
+#define NBL_SEC093_ADDR			(0x75c244)
+#define NBL_SEC094_SIZE			(1)
+#define NBL_SEC094_ADDR			(0x75c248)
+#define NBL_SEC095_SIZE			(1)
+#define NBL_SEC095_ADDR			(0x75c250)
+#define NBL_SEC096_SIZE			(1)
+#define NBL_SEC096_ADDR			(0x15c230)
+#define NBL_SEC097_SIZE			(1)
+#define NBL_SEC097_ADDR			(0x15c234)
+#define NBL_SEC098_SIZE			(1)
+#define NBL_SEC098_ADDR			(0x15c238)
+#define NBL_SEC099_SIZE			(1)
+#define NBL_SEC099_ADDR			(0x15c23c)
+#define NBL_SEC100_SIZE			(1)
+#define NBL_SEC100_ADDR			(0x15c244)
+#define NBL_SEC101_SIZE			(1)
+#define NBL_SEC101_ADDR			(0x15c248)
+#define NBL_SEC102_SIZE			(1)
+#define NBL_SEC102_ADDR			(0xb6432c)
+#define NBL_SEC103_SIZE			(1)
+#define NBL_SEC103_ADDR			(0xb64220)
+#define NBL_SEC104_SIZE			(1)
+#define NBL_SEC104_ADDR			(0xb44804)
+#define NBL_SEC105_SIZE			(1)
+#define NBL_SEC105_ADDR			(0xb44a00)
+#define NBL_SEC106_SIZE			(1)
+#define NBL_SEC106_ADDR			(0xe84210)
+#define NBL_SEC107_SIZE			(1)
+#define NBL_SEC107_ADDR			(0xe84214)
+#define NBL_SEC108_SIZE			(1)
+#define NBL_SEC108_ADDR			(0xe64228)
+#define NBL_SEC109_SIZE			(1)
+#define NBL_SEC109_ADDR			(0x65413c)
+#define NBL_SEC110_SIZE			(1)
+#define NBL_SEC110_ADDR			(0x984144)
+#define NBL_SEC111_SIZE			(1)
+#define NBL_SEC111_ADDR			(0x114130)
+#define NBL_SEC112_SIZE			(1)
+#define NBL_SEC112_ADDR			(0x714138)
+#define NBL_SEC113_SIZE			(1)
+#define NBL_SEC113_ADDR			(0x114134)
+#define NBL_SEC114_SIZE			(1)
+#define NBL_SEC114_ADDR			(0x71413c)
+#define NBL_SEC115_SIZE			(1)
+#define NBL_SEC115_ADDR			(0x90437c)
+#define NBL_SEC116_SIZE			(32)
+#define NBL_SEC116_ADDR			(0xb05000)
+#define NBL_SEC116_REGI(i)		(0xb05000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC117_SIZE			(1)
+#define NBL_SEC117_ADDR			(0xb043e0)
+#define NBL_SEC118_SIZE			(1)
+#define NBL_SEC118_ADDR			(0xb043f0)
+#define NBL_SEC119_SIZE			(5)
+#define NBL_SEC119_ADDR			(0x8c230)
+#define NBL_SEC119_REGI(i)		(0x8c230 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC120_SIZE			(1)
+#define NBL_SEC120_ADDR			(0x8c1f4)
+#define NBL_SEC121_SIZE			(1)
+#define NBL_SEC121_ADDR			(0x2046c4)
+#define NBL_SEC122_SIZE			(1)
+#define NBL_SEC122_ADDR			(0x85c1f4)
+#define NBL_SEC123_SIZE			(1)
+#define NBL_SEC123_ADDR			(0x75c194)
+#define NBL_SEC124_SIZE			(256)
+#define NBL_SEC124_ADDR			(0xa05000)
+#define NBL_SEC124_REGI(i)		(0xa05000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC125_SIZE			(256)
+#define NBL_SEC125_ADDR			(0xa06000)
+#define NBL_SEC125_REGI(i)		(0xa06000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC126_SIZE			(256)
+#define NBL_SEC126_ADDR			(0xa07000)
+#define NBL_SEC126_REGI(i)		(0xa07000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC127_SIZE			(1)
+#define NBL_SEC127_ADDR			(0x75c204)
+#define NBL_SEC128_SIZE			(1)
+#define NBL_SEC128_ADDR			(0x15c204)
+#define NBL_SEC129_SIZE			(1)
+#define NBL_SEC129_ADDR			(0x75c208)
+#define NBL_SEC130_SIZE			(1)
+#define NBL_SEC130_ADDR			(0x15c208)
+#define NBL_SEC131_SIZE			(1)
+#define NBL_SEC131_ADDR			(0x75c20c)
+#define NBL_SEC132_SIZE			(1)
+#define NBL_SEC132_ADDR			(0x15c20c)
+#define NBL_SEC133_SIZE			(1)
+#define NBL_SEC133_ADDR			(0x75c210)
+#define NBL_SEC134_SIZE			(1)
+#define NBL_SEC134_ADDR			(0x15c210)
+#define NBL_SEC135_SIZE			(1)
+#define NBL_SEC135_ADDR			(0x75c214)
+#define NBL_SEC136_SIZE			(1)
+#define NBL_SEC136_ADDR			(0x15c214)
+#define NBL_SEC137_SIZE			(32)
+#define NBL_SEC137_ADDR			(0x15d000)
+#define NBL_SEC137_REGI(i)		(0x15d000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC138_SIZE			(32)
+#define NBL_SEC138_ADDR			(0x75d000)
+#define NBL_SEC138_REGI(i)		(0x75d000 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC139_SIZE			(1)
+#define NBL_SEC139_ADDR			(0x75c310)
+#define NBL_SEC140_SIZE			(1)
+#define NBL_SEC140_ADDR			(0x75c314)
+#define NBL_SEC141_SIZE			(1)
+#define NBL_SEC141_ADDR			(0x75c340)
+#define NBL_SEC142_SIZE			(1)
+#define NBL_SEC142_ADDR			(0x75c344)
+#define NBL_SEC143_SIZE			(1)
+#define NBL_SEC143_ADDR			(0x75c348)
+#define NBL_SEC144_SIZE			(1)
+#define NBL_SEC144_ADDR			(0x75c34c)
+#define NBL_SEC145_SIZE			(32)
+#define NBL_SEC145_ADDR			(0xb15800)
+#define NBL_SEC145_REGI(i)		(0xb15800 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC146_SIZE			(32)
+#define NBL_SEC146_ADDR			(0xb25800)
+#define NBL_SEC146_REGI(i)		(0xb25800 + NBL_BYTES_IN_REG * (i))
+#define NBL_SEC147_SIZE			(32)
+#define NBL_SEC147_ADDR			(0xb35800)
+#define NBL_SEC147_REGI(i)		(0xb35800 + NBL_BYTES_IN_REG * (i))
+
+static u32 nbl_sec046_1p_data[] = {
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0xa0000000, 0x00077c2b, 0x005c0000,
+	0x00000000, 0x00008100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x20000000, 0x00073029, 0x00480000,
+	0x00000000, 0x00008100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x20000000, 0x00073029, 0x00480000,
+	0x70000000, 0x00000020, 0x24140000, 0x00000020,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0xa0000000, 0x00000009, 0x00000000,
+	0x00000000, 0x00002100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0xb0000000, 0x00000009, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x70000000, 0x00000000, 0x20140000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x70000000, 0x00000000, 0x20140000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x38430000,
+	0x70000006, 0x00000020, 0x24140000, 0x00000020,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x98cb1180, 0x6e36d469,
+	0x9d8eb91c, 0x87e3ef47, 0xa2931288, 0x08405c5a,
+	0x73865086, 0x00000080, 0x30140000, 0x00000080,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0xb0000000, 0x000b3849, 0x38430000,
+	0x00000006, 0x0000c100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0xb0000000, 0x00133889, 0x08400000,
+	0x03865086, 0x4c016100, 0x00000014, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec071_1p_data[] = {
+	0x00000000, 0x00000000, 0x00113d00, 0x00000000,
+	0x00000000, 0x00000000, 0xe7029b00, 0x00000000,
+	0x00000000, 0x43000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x51e00000, 0x00000c9c,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00293d00, 0x00000000,
+	0x00000000, 0x00000000, 0x67089b00, 0x00000002,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x80000000, 0x00000000, 0xb1e00000, 0x0000189c,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00213d00, 0x00000000,
+	0x00000000, 0x00000000, 0xe7069b00, 0x00000001,
+	0x00000000, 0x43000000, 0x014b0c70, 0x00000000,
+	0x00000000, 0x00000000, 0x92600000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00213d00, 0x00000000,
+	0x00000000, 0x00000000, 0xe7069b00, 0x00000001,
+	0x00000000, 0x43000000, 0x015b0c70, 0x00000000,
+	0x00000000, 0x00000000, 0x92600000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00553d00, 0x00000000,
+	0x00000000, 0x00000000, 0xe6d29a00, 0x000149c4,
+	0x00000000, 0x4b000000, 0x00000004, 0x00000000,
+	0x80000000, 0x00022200, 0x62600000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00553d00, 0x00000000,
+	0x00000000, 0x00000000, 0xe6d2c000, 0x000149c4,
+	0x00000000, 0x5b000000, 0x00000004, 0x00000000,
+	0x80000000, 0x00022200, 0x62600000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x006d3d00, 0x00000000,
+	0x00000000, 0x00000000, 0x64d49200, 0x5e556945,
+	0xc666d89a, 0x4b0001a9, 0x00004c84, 0x00000000,
+	0x80000000, 0x00022200, 0xc2600000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x006d3d00, 0x00000000,
+	0x00000000, 0x00000000, 0x6ed4ba00, 0x5ef56bc5,
+	0xc666d8c0, 0x5b0001a9, 0x00004dc4, 0x00000000,
+	0x80000000, 0x00022200, 0xc2600000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000002, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00700000, 0x00000000, 0x08028000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec046_2p_data[] = {
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0xa0000000, 0x00077c2b, 0x005c0000,
+	0x00000000, 0x00008100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x20000000, 0x00073029, 0x00480000,
+	0x00000000, 0x00008100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x20000000, 0x00073029, 0x00480000,
+	0x70000000, 0x00000020, 0x04140000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0xa0000000, 0x00000009, 0x00000000,
+	0x00000000, 0x00002100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0xb0000000, 0x00000009, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x70000000, 0x00000000, 0x00140000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x70000000, 0x00000000, 0x00140000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x38430000,
+	0x70000006, 0x00000020, 0x04140000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x98cb1180, 0x6e36d469,
+	0x9d8eb91c, 0x87e3ef47, 0xa2931288, 0x08405c5a,
+	0x73865086, 0x00000080, 0x10140000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0xb0000000, 0x000b3849, 0x38430000,
+	0x00000006, 0x0000c100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0xb0000000, 0x00133889, 0x08400000,
+	0x03865086, 0x4c016100, 0x00000014, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec071_2p_data[] = {
+	0x00000000, 0x00000000, 0x00113d00, 0x00000000,
+	0x00000000, 0x00000000, 0xe7029b00, 0x00000000,
+	0x00000000, 0x43000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x51e00000, 0x00000c9c,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00293d00, 0x00000000,
+	0x00000000, 0x00000000, 0x67089b00, 0x00000002,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x80000000, 0x00000000, 0xb1e00000, 0x0000189c,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00213d00, 0x00000000,
+	0x00000000, 0x00000000, 0xe7069b00, 0x00000001,
+	0x00000000, 0x43000000, 0x014b0c70, 0x00000000,
+	0x00000000, 0x00000000, 0x92600000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00213d00, 0x00000000,
+	0x00000000, 0x00000000, 0xe7069b00, 0x00000001,
+	0x00000000, 0x43000000, 0x015b0c70, 0x00000000,
+	0x00000000, 0x00000000, 0x92600000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00553d00, 0x00000000,
+	0x00000000, 0x00000000, 0xe6d29a00, 0x000149c4,
+	0x00000000, 0x4b000000, 0x00000004, 0x00000000,
+	0x80000000, 0x00022200, 0x62600000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00553d00, 0x00000000,
+	0x00000000, 0x00000000, 0xe6d2c000, 0x000149c4,
+	0x00000000, 0x5b000000, 0x00000004, 0x00000000,
+	0x80000000, 0x00022200, 0x62600000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x006d3d00, 0x00000000,
+	0x00000000, 0x00000000, 0x64d49200, 0x5e556945,
+	0xc666d89a, 0x4b0001a9, 0x00004c84, 0x00000000,
+	0x80000000, 0x00022200, 0xc2600000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x006d3d00, 0x00000000,
+	0x00000000, 0x00000000, 0x6ed4ba00, 0x5ef56bc5,
+	0xc666d8c0, 0x5b0001a9, 0x00004dc4, 0x00000000,
+	0x80000000, 0x00022200, 0xc2600000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000002, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00700000, 0x00000000, 0x00028000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec006_data[] = {
+	0x81008100, 0x00000001, 0x88a88100, 0x00000001,
+	0x810088a8, 0x00000001, 0x88a888a8, 0x00000001,
+	0x81000000, 0x00000001, 0x88a80000, 0x00000001,
+	0x00000000, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x08004000, 0x00000001, 0x86dd6000, 0x00000001,
+	0x81000000, 0x00000001, 0x88a80000, 0x00000001,
+	0x08060000, 0x00000001, 0x80350000, 0x00000001,
+	0x88080000, 0x00000001, 0x88f70000, 0x00000001,
+	0x88cc0000, 0x00000001, 0x88090000, 0x00000001,
+	0x89150000, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000001,
+	0x11006000, 0x00000001, 0x06006000, 0x00000001,
+	0x02006000, 0x00000001, 0x3a006000, 0x00000001,
+	0x2f006000, 0x00000001, 0x84006000, 0x00000001,
+	0x32006000, 0x00000001, 0x2c006000, 0x00000001,
+	0x3c006000, 0x00000001, 0x2b006000, 0x00000001,
+	0x00006000, 0x00000001, 0x00004000, 0x00000001,
+	0x00004000, 0x00000001, 0x20004000, 0x00000001,
+	0x40004000, 0x00000001, 0x00000000, 0x00000001,
+	0x11000000, 0x00000001, 0x06000000, 0x00000001,
+	0x02000000, 0x00000001, 0x3a000000, 0x00000001,
+	0x2f000000, 0x00000001, 0x84000000, 0x00000001,
+	0x32000000, 0x00000001, 0x2c000000, 0x00000001,
+	0x2b000000, 0x00000001, 0x3c000000, 0x00000001,
+	0x3b000000, 0x00000001, 0x00000000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x11000000, 0x00000001, 0x06000000, 0x00000001,
+	0x02000000, 0x00000001, 0x3a000000, 0x00000001,
+	0x2f000000, 0x00000001, 0x84000000, 0x00000001,
+	0x32000000, 0x00000001, 0x00000000, 0x00000000,
+	0x2c000000, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x2b000000, 0x00000001, 0x3c000000, 0x00000001,
+	0x3b000000, 0x00000001, 0x00000000, 0x00000001,
+	0x06001072, 0x00000001, 0x06000000, 0x00000001,
+	0x110017c1, 0x00000001, 0x110012b7, 0x00000001,
+	0x110012b5, 0x00000001, 0x01000000, 0x00000001,
+	0x02000000, 0x00000001, 0x3a000000, 0x00000001,
+	0x11000043, 0x00000001, 0x11000044, 0x00000001,
+	0x11000222, 0x00000001, 0x11000000, 0x00000001,
+	0x2f006558, 0x00000001, 0x32000000, 0x00000001,
+	0x84000000, 0x00000001, 0x00000000, 0x00000001,
+	0x65582000, 0x00000001, 0x65583000, 0x00000001,
+	0x6558a000, 0x00000001, 0x6558b000, 0x00000001,
+	0x65580000, 0x00000001, 0x12b50000, 0x00000001,
+	0x02000102, 0x00000001, 0x00000000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x65580000, 0x00000001, 0x00000000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x81008100, 0x00000001, 0x88a88100, 0x00000001,
+	0x810088a8, 0x00000001, 0x88a888a8, 0x00000001,
+	0x81000000, 0x00000001, 0x88a80000, 0x00000001,
+	0x00000000, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x08004000, 0x00000001, 0x86dd6000, 0x00000001,
+	0x81000000, 0x00000001, 0x88a80000, 0x00000001,
+	0x08060000, 0x00000001, 0x80350000, 0x00000001,
+	0x88080000, 0x00000001, 0x88f70000, 0x00000001,
+	0x88cc0000, 0x00000001, 0x88090000, 0x00000001,
+	0x89150000, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000001,
+	0x11006000, 0x00000001, 0x06006000, 0x00000001,
+	0x02006000, 0x00000001, 0x3a006000, 0x00000001,
+	0x2f006000, 0x00000001, 0x84006000, 0x00000001,
+	0x32006000, 0x00000001, 0x2c006000, 0x00000001,
+	0x3c006000, 0x00000001, 0x2b006000, 0x00000001,
+	0x00006000, 0x00000001, 0x00004000, 0x00000001,
+	0x00004000, 0x00000001, 0x20004000, 0x00000001,
+	0x40004000, 0x00000001, 0x00000000, 0x00000001,
+	0x11000000, 0x00000001, 0x06000000, 0x00000001,
+	0x02000000, 0x00000001, 0x3a000000, 0x00000001,
+	0x2f000000, 0x00000001, 0x84000000, 0x00000001,
+	0x32000000, 0x00000001, 0x2c000000, 0x00000001,
+	0x2b000000, 0x00000001, 0x3c000000, 0x00000001,
+	0x3b000000, 0x00000001, 0x00000000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x11000000, 0x00000001, 0x06000000, 0x00000001,
+	0x02000000, 0x00000001, 0x3a000000, 0x00000001,
+	0x2f000000, 0x00000001, 0x84000000, 0x00000001,
+	0x32000000, 0x00000001, 0x00000000, 0x00000000,
+	0x2c000000, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x2b000000, 0x00000001, 0x3c000000, 0x00000001,
+	0x3b000000, 0x00000001, 0x00000000, 0x00000001,
+	0x06001072, 0x00000001, 0x06000000, 0x00000001,
+	0x110012b7, 0x00000001, 0x01000000, 0x00000001,
+	0x02000000, 0x00000001, 0x3a000000, 0x00000001,
+	0x32000000, 0x00000001, 0x84000000, 0x00000001,
+	0x11000043, 0x00000001, 0x11000044, 0x00000001,
+	0x11000222, 0x00000001, 0x11000000, 0x00000001,
+	0x2f006558, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec007_data[] = {
+	0x10001000, 0x00001000, 0x10000000, 0x00000000,
+	0x1000ffff, 0x0000ffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0x00000fff, 0x00000fff, 0x1000ffff, 0x0000ffff,
+	0x0000ffff, 0x0000ffff, 0x0000ffff, 0x0000ffff,
+	0x0000ffff, 0x0000ffff, 0x0000ffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0x00ff0fff, 0x00ff0fff, 0x00ff0fff, 0x00ff0fff,
+	0x00ff0fff, 0x00ff0fff, 0x00ff0fff, 0x00ff0fff,
+	0x00ff0fff, 0x10ff0fff, 0xffff0fff, 0x00000fff,
+	0x1fff0fff, 0x1fff0fff, 0x1fff0fff, 0xffffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0xffffffff,
+	0x00ffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0xffffffff,
+	0x00ff0000, 0x00ffffff, 0x00ff0000, 0x00ff0000,
+	0x00ff0000, 0x00ffffff, 0x00ffffff, 0x00ffffff,
+	0x00ff0000, 0x00ff0000, 0x00ff0001, 0x00ffffff,
+	0x00ff0000, 0x00ffffff, 0x00ffffff, 0xffffffff,
+	0x00000fff, 0x00000fff, 0x00000fff, 0x00000fff,
+	0x00000fff, 0x0000ffff, 0xc0ff0000, 0xc0ffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0x0000ffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0x10001000, 0x00001000, 0x10000000, 0x00000000,
+	0x1000ffff, 0x0000ffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0x00000fff, 0x00000fff, 0x1000ffff, 0x0000ffff,
+	0x0000ffff, 0x0000ffff, 0x0000ffff, 0x0000ffff,
+	0x0000ffff, 0x0000ffff, 0x0000ffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0x00ff0fff, 0x00ff0fff, 0x00ff0fff, 0x00ff0fff,
+	0x00ff0fff, 0x00ff0fff, 0x00ff0fff, 0x00ff0fff,
+	0x00ff0fff, 0x10ff0fff, 0xffff0fff, 0x00000fff,
+	0x1fff0fff, 0x1fff0fff, 0x1fff0fff, 0xffffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0xffffffff,
+	0x00ffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0xffffffff,
+	0x00ff0000, 0x00ffffff, 0x00ff0000, 0x00ffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff,
+	0x00ff0000, 0x00ff0000, 0x00ff0001, 0x00ffffff,
+	0x00ff0000, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+};
+
+static u32 nbl_sec008_data[] = {
+	0x00809190, 0x16009496, 0x00000100, 0x00000000,
+	0x00809190, 0x16009496, 0x00000100, 0x00000000,
+	0x00809190, 0x16009496, 0x00000100, 0x00000000,
+	0x00809190, 0x16009496, 0x00000100, 0x00000000,
+	0x00800090, 0x12009092, 0x00000100, 0x00000000,
+	0x00800090, 0x12009092, 0x00000100, 0x00000000,
+	0x00800000, 0x0e008c8e, 0x00000100, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x08909581, 0x00008680, 0x00000200, 0x00000000,
+	0x10900082, 0x28008680, 0x00000200, 0x00000000,
+	0x809b0093, 0x00000000, 0x00000100, 0x00000000,
+	0x809b0093, 0x00000000, 0x00000100, 0x00000000,
+	0x009b008f, 0x00000000, 0x00000100, 0x00000000,
+	0x009b008f, 0x00000000, 0x00000100, 0x00000000,
+	0x009b008f, 0x00000000, 0x00000100, 0x00000000,
+	0x009b008f, 0x00000000, 0x00000100, 0x00000000,
+	0x009b008f, 0x00000000, 0x00000100, 0x00000000,
+	0x009b008f, 0x00000000, 0x00000100, 0x00000000,
+	0x009b0000, 0x00000000, 0x00000100, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x009b0000, 0x00000000, 0x00000100, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00ab0085, 0x08000000, 0x00000200, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000200, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000200, 0x00000000,
+	0x40000000, 0x01c180c2, 0x00000300, 0x00000000,
+	0x00000000, 0x00a089c2, 0x000005f0, 0x00000000,
+	0x000b0085, 0x00a00000, 0x000002f0, 0x00000000,
+	0x000b0085, 0x00a00000, 0x000002f0, 0x00000000,
+	0x00000000, 0x00a089c2, 0x000005f0, 0x00000000,
+	0x000b0000, 0x00000000, 0x00000200, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00ab0085, 0x08000000, 0x00000300, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000300, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000300, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000300, 0x00000000,
+	0x40000000, 0x01c180c2, 0x00000400, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00ab0085, 0x08000000, 0x00000400, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000400, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000400, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000400, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000400, 0x00000000,
+	0x01ab0083, 0x0ca00000, 0x0000050f, 0x00000000,
+	0x01ab0083, 0x0ca00000, 0x0000050f, 0x00000000,
+	0x02a00084, 0x08008890, 0x00000600, 0x00000000,
+	0x02ab848a, 0x08000000, 0x00000500, 0x00000000,
+	0x02a00084, 0x10008200, 0x00000600, 0x00000000,
+	0x00ab8f8e, 0x04000000, 0x00000500, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000500, 0x00000000,
+	0x00ab8f8e, 0x04000000, 0x00000500, 0x00000000,
+	0x02ab848f, 0x08000000, 0x00000500, 0x00000000,
+	0x02ab848f, 0x08000000, 0x00000500, 0x00000000,
+	0x02ab848f, 0x08000000, 0x00000500, 0x00000000,
+	0x02ab0084, 0x08000000, 0x00000500, 0x00000000,
+	0x00a00000, 0x04008280, 0x00000600, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000500, 0x00000000,
+	0x04ab8e84, 0x0c000000, 0x00000500, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000500, 0x00000000,
+	0x00000000, 0x0400ccd0, 0x00000800, 0x00000000,
+	0x00000000, 0x0800ccd0, 0x00000800, 0x00000000,
+	0x00000000, 0x0800ccd0, 0x00000800, 0x00000000,
+	0x00000000, 0x0c00ccd0, 0x00000800, 0x00000000,
+	0x00000000, 0x0000ccd0, 0x00000800, 0x00000000,
+	0x00000000, 0x0000ccd0, 0x00000800, 0x00000000,
+	0x00000000, 0x10008200, 0x00000700, 0x00000000,
+	0x00000000, 0x08008200, 0x00000700, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x0000ccd0, 0x00000800, 0x00000000,
+	0x00000000, 0x0000ccd0, 0x00000800, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00808786, 0x16009496, 0x00000900, 0x00000000,
+	0x00808786, 0x16009496, 0x00000900, 0x00000000,
+	0x00808786, 0x16009496, 0x00000900, 0x00000000,
+	0x00808786, 0x16009496, 0x00000900, 0x00000000,
+	0x00800086, 0x12009092, 0x00000900, 0x00000000,
+	0x00800086, 0x12009092, 0x00000900, 0x00000000,
+	0x00800000, 0x0e008c8e, 0x00000900, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x08908192, 0x00008680, 0x00000a00, 0x00000000,
+	0x10908292, 0x28008680, 0x00000a00, 0x00000000,
+	0x809b9392, 0x00000000, 0x00000900, 0x00000000,
+	0x809b9392, 0x00000000, 0x00000900, 0x00000000,
+	0x009b8f92, 0x00000000, 0x00000900, 0x00000000,
+	0x009b8f92, 0x00000000, 0x00000900, 0x00000000,
+	0x009b8f92, 0x00000000, 0x00000900, 0x00000000,
+	0x009b8f92, 0x00000000, 0x00000900, 0x00000000,
+	0x009b8f92, 0x00000000, 0x00000900, 0x00000000,
+	0x009b8f92, 0x00000000, 0x00000900, 0x00000000,
+	0x009b0092, 0x00000000, 0x00000900, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x009b0092, 0x00000000, 0x00000900, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00ab0085, 0x08000000, 0x00000a00, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000a00, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000a00, 0x00000000,
+	0x40000000, 0x01c180c2, 0x00000b00, 0x00000000,
+	0x00000000, 0x00a089c2, 0x00000df0, 0x00000000,
+	0x000b0085, 0x00a00000, 0x00000af0, 0x00000000,
+	0x000b0085, 0x00a00000, 0x00000af0, 0x00000000,
+	0x00000000, 0x00a089c2, 0x00000df0, 0x00000000,
+	0x000b0000, 0x00000000, 0x00000a00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00ab0085, 0x08000000, 0x00000b00, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000b00, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000b00, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000b00, 0x00000000,
+	0x40000000, 0x01c180c2, 0x00000c00, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000082, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00ab0085, 0x08000000, 0x00000c00, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000c00, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000c00, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000c00, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000c00, 0x00000000,
+	0x01ab0083, 0x0ca00000, 0x00000d0f, 0x00000000,
+	0x01ab0083, 0x0ca00000, 0x00000d0f, 0x00000000,
+	0x02ab8a84, 0x08000000, 0x00000d00, 0x00000000,
+	0x00ab8f8e, 0x04000000, 0x00000d00, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000d00, 0x00000000,
+	0x00ab8f8e, 0x04000000, 0x00000d00, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000d00, 0x00000000,
+	0x04ab8e84, 0x0c000000, 0x00000d00, 0x00000000,
+	0x02ab848f, 0x08000000, 0x00000d00, 0x00000000,
+	0x02ab848f, 0x08000000, 0x00000d00, 0x00000000,
+	0x02ab848f, 0x08000000, 0x00000d00, 0x00000000,
+	0x02ab0084, 0x08000000, 0x00000d00, 0x00000000,
+	0x00ab0000, 0x04000000, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000d00, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec009_data[] = {
+	0x00000000, 0x00000060, 0x00000000, 0x00000090,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000050, 0x00000000, 0x000000a0,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x000000a0, 0x00000000, 0x00000050,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000800, 0x00000000, 0x00000700,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000900, 0x00000000, 0x00000600,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00008000, 0x00000000, 0x00007000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00009000, 0x00000000, 0x00006000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x0000a000, 0x00000000, 0x00005000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x000c0000, 0x00000000, 0x00030000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x000d0000, 0x00000000, 0x00020000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x000e0000, 0x00000000, 0x00010000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000040, 0x00000000, 0x000000b0,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000070, 0x00000000, 0x00000080,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000090, 0x00000000, 0x00000060,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000080, 0x00000000, 0x00000070,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000700, 0x00000000, 0x00000800,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00007000, 0x00000000, 0x00008000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00080000, 0x00000000, 0x00070000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000c00, 0x00000000, 0x00000300,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000d00, 0x00000000, 0x00000200,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00600000, 0x00000000, 0x00900000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00d00000, 0x00000000, 0x00200000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00500000, 0x00000000, 0x00a00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00700000, 0x00000000, 0x00800000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00e00000, 0x00000000, 0x00100000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00f00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00f00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00100000, 0x00000000, 0x00e00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00300000, 0x00000000, 0x00c00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00800000, 0x00000000, 0x00700000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00900000, 0x00000000, 0x00600000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00a00000, 0x00000000, 0x00500000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00b00000, 0x00000000, 0x00400000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000060, 0x00400000, 0x00000090, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000050, 0x00400000, 0x000000a0, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000000a0, 0x00400000, 0x00000050, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000800, 0x00400000, 0x00000700, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000900, 0x00400000, 0x00000600, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00008000, 0x00400000, 0x00007000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00009000, 0x00400000, 0x00006000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x0000a000, 0x00400000, 0x00005000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000c0000, 0x00400000, 0x00030000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000d0000, 0x00400000, 0x00020000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000e0000, 0x00400000, 0x00010000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000070, 0x00400000, 0x00000080, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000700, 0x00400000, 0x00000800, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00007000, 0x00400000, 0x00008000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00080000, 0x00400000, 0x00070000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000c00, 0x00400000, 0x00000300, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000d00, 0x00400000, 0x00000200, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000040, 0x00400000, 0x000000b0, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000090, 0x00400000, 0x00000060, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000080, 0x00400000, 0x00000070, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000060, 0x06000000, 0x00000090, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000060, 0x07000000, 0x00000090, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000050, 0x06000000, 0x000000a0, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000050, 0x07000000, 0x000000a0, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000000a0, 0x06000000, 0x00000050, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000000a0, 0x07000000, 0x00000050, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000800, 0x06000000, 0x00000700, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000900, 0x06000000, 0x00000600, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00008000, 0x06000000, 0x00007000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00009000, 0x06000000, 0x00006000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x0000a000, 0x06000000, 0x00005000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000c0000, 0x06000000, 0x00030000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000d0000, 0x06000000, 0x00020000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000e0000, 0x06000000, 0x00010000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000800, 0x07000000, 0x00000700, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000900, 0x07000000, 0x00000600, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00008000, 0x07000000, 0x00007000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00009000, 0x07000000, 0x00006000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x0000a000, 0x07000000, 0x00005000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000c0000, 0x07000000, 0x00030000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000d0000, 0x07000000, 0x00020000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000e0000, 0x07000000, 0x00010000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000070, 0x06000000, 0x00000080, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000070, 0x07000000, 0x00000080, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000700, 0x06000000, 0x00000800, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00007000, 0x06000000, 0x00008000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00080000, 0x06000000, 0x00070000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000c00, 0x06000000, 0x00000300, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000d00, 0x06000000, 0x00000200, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000700, 0x07000000, 0x00000800, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00007000, 0x07000000, 0x00008000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00080000, 0x07000000, 0x00070000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000c00, 0x07000000, 0x00000300, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000d00, 0x07000000, 0x00000200, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000040, 0x06000000, 0x000000b0, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000040, 0x07000000, 0x000000b0, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000090, 0x06000000, 0x00000060, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000090, 0x07000000, 0x00000060, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000080, 0x06000000, 0x00000070, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000080, 0x07000000, 0x00000070, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000060, 0x00c00000, 0x00000090, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000050, 0x00c00000, 0x000000a0, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000000a0, 0x00c00000, 0x00000050, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000800, 0x00c00000, 0x00000700, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000900, 0x00c00000, 0x00000600, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00008000, 0x00c00000, 0x00007000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00009000, 0x00c00000, 0x00006000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x0000a000, 0x00c00000, 0x00005000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000c0000, 0x00c00000, 0x00030000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000d0000, 0x00c00000, 0x00020000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000e0000, 0x00c00000, 0x00010000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000070, 0x00c00000, 0x00000080, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000700, 0x00c00000, 0x00000800, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00007000, 0x00c00000, 0x00008000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00080000, 0x00c00000, 0x00070000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000c00, 0x00c00000, 0x00000300, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000d00, 0x00c00000, 0x00000200, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000040, 0x00c00000, 0x000000b0, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000090, 0x00c00000, 0x00000060, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000080, 0x00c00000, 0x00000070, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00400000, 0x00400000, 0x00b00000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00600000, 0x00400000, 0x00900000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00300000, 0x00400000, 0x00c00000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00500000, 0x00400000, 0x00a00000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00700000, 0x00400000, 0x00800000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00200000, 0x00400000, 0x00d00000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00800000, 0x00400000, 0x00700000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00900000, 0x00400000, 0x00600000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00a00000, 0x00400000, 0x00500000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00b00000, 0x00400000, 0x00400000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00400000, 0x00f00000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00400000, 0x00f00000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00100000, 0x00400000, 0x00e00000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00400000, 0x06000000, 0x00b00000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00400000, 0x07000000, 0x00b00000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00600000, 0x06000000, 0x00900000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00600000, 0x07000000, 0x00900000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00300000, 0x06000000, 0x00c00000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00300000, 0x07000000, 0x00c00000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00500000, 0x06000000, 0x00a00000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00500000, 0x07000000, 0x00a00000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00700000, 0x06000000, 0x00800000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00700000, 0x07000000, 0x00800000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00200000, 0x06000000, 0x00d00000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00200000, 0x07000000, 0x00d00000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00800000, 0x06000000, 0x00700000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00900000, 0x06000000, 0x00600000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00a00000, 0x06000000, 0x00500000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00b00000, 0x06000000, 0x00400000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00800000, 0x07000000, 0x00700000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00900000, 0x07000000, 0x00600000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00a00000, 0x07000000, 0x00500000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00b00000, 0x07000000, 0x00400000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x06000000, 0x00f00000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x07000000, 0x00f00000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x06000000, 0x00f00000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00100000, 0x06000000, 0x00e00000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x07000000, 0x00f00000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00100000, 0x07000000, 0x00e00000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00400000, 0x00c00000, 0x00b00000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00600000, 0x00c00000, 0x00900000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00300000, 0x00c00000, 0x00c00000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00500000, 0x00c00000, 0x00a00000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00700000, 0x00c00000, 0x00800000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00200000, 0x00c00000, 0x00d00000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00800000, 0x00c00000, 0x00700000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00900000, 0x00c00000, 0x00600000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00a00000, 0x00c00000, 0x00500000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00b00000, 0x00c00000, 0x00400000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00c00000, 0x00f00000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00c00000, 0x00f00000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00100000, 0x00c00000, 0x00e00000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000f0000, 0x00400000, 0x00000000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00f00000, 0x00400000, 0x00000000, 0x00b00000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000f0000, 0x06000000, 0x00000000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00f00000, 0x06000000, 0x00000000, 0x09000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000f0000, 0x07000000, 0x00000000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00f00000, 0x07000000, 0x00000000, 0x08000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x000f0000, 0x00c00000, 0x00000000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00f00000, 0x00c00000, 0x00000000, 0x00300000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x000f0000, 0x00000000, 0x00000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00f00000, 0x00000000, 0x00000000,
+	0x00000001, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec010_data[] = {
+	0x0000000a, 0x0000000a, 0x0000000a, 0x0000000a,
+	0x0000000a, 0x0000000a, 0x0000000a, 0x0000000a,
+	0x0000000a, 0x0000000a, 0x0000000a, 0x00000000,
+	0x0000000b, 0x00000008, 0x00000009, 0x0000000f,
+	0x0000000f, 0x0000000f, 0x0000000f, 0x0000000f,
+	0x0000000c, 0x0000000d, 0x00000001, 0x00000001,
+	0x0000000e, 0x00000005, 0x00000002, 0x00000002,
+	0x00000004, 0x00000003, 0x00000003, 0x00000003,
+	0x00000003, 0x00000040, 0x00000040, 0x00000040,
+	0x00000040, 0x00000040, 0x00000040, 0x00000040,
+	0x00000040, 0x00000040, 0x00000040, 0x00000040,
+	0x00000045, 0x00000044, 0x00000044, 0x00000044,
+	0x00000044, 0x00000044, 0x00000041, 0x00000042,
+	0x00000043, 0x00000046, 0x00000046, 0x00000046,
+	0x00000046, 0x00000046, 0x00000046, 0x00000046,
+	0x00000046, 0x00000046, 0x00000046, 0x00000046,
+	0x00000046, 0x00000046, 0x00000046, 0x00000046,
+	0x00000046, 0x00000046, 0x00000046, 0x00000046,
+	0x00000046, 0x00000046, 0x00000046, 0x0000004b,
+	0x0000004b, 0x0000004a, 0x0000004a, 0x0000004a,
+	0x0000004a, 0x0000004a, 0x0000004a, 0x0000004a,
+	0x0000004a, 0x0000004a, 0x0000004a, 0x00000047,
+	0x00000047, 0x00000048, 0x00000048, 0x00000049,
+	0x00000049, 0x0000004c, 0x0000004c, 0x0000004c,
+	0x0000004c, 0x0000004c, 0x0000004c, 0x0000004c,
+	0x0000004c, 0x0000004c, 0x0000004c, 0x0000004c,
+	0x00000051, 0x00000050, 0x00000050, 0x00000050,
+	0x00000050, 0x00000050, 0x0000004d, 0x0000004e,
+	0x0000004f, 0x00000052, 0x00000053, 0x00000054,
+	0x00000054, 0x00000055, 0x00000056, 0x00000057,
+	0x00000057, 0x00000057, 0x00000057, 0x00000058,
+	0x00000059, 0x00000059, 0x0000005a, 0x0000005a,
+	0x0000005b, 0x0000005b, 0x0000005c, 0x0000005c,
+	0x0000005c, 0x0000005c, 0x0000005d, 0x0000005d,
+	0x0000005e, 0x0000005e, 0x0000005f, 0x0000005f,
+	0x0000005f, 0x0000005f, 0x0000005f, 0x0000005f,
+	0x0000005f, 0x0000005f, 0x00000060, 0x00000060,
+	0x00000061, 0x00000061, 0x00000061, 0x00000061,
+	0x00000062, 0x00000063, 0x00000064, 0x00000064,
+	0x00000065, 0x00000066, 0x00000067, 0x00000067,
+	0x00000067, 0x00000067, 0x00000068, 0x00000069,
+	0x00000069, 0x00000040, 0x00000040, 0x00000046,
+	0x00000046, 0x00000046, 0x00000046, 0x0000004c,
+	0x0000004c, 0x0000000a, 0x0000000a, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec011_data[] = {
+	0x0008002c, 0x00080234, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00080230,
+	0x00080332, 0x0008063c, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0008002c, 0x00080234, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00080230,
+	0x00080332, 0x00080738, 0x0008083c, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0008002c, 0x00080234, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00080230,
+	0x00080332, 0x00080738, 0x0008093a, 0x00080a3c,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00080020, 0x00080228, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00080224,
+	0x00080326, 0x00080634, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00080020, 0x00080228, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00080224,
+	0x00080326, 0x00080730, 0x00080834, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00080020, 0x00080228, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00080224,
+	0x00080326, 0x00080730, 0x00080932, 0x00080a34,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00090200, 0x00090304, 0x00090408, 0x0009050c,
+	0x00090610, 0x00090714, 0x00090818, 0x0009121c,
+	0x0009131e, 0x00000000, 0x00000000, 0x00000000,
+	0x00090644, 0x00000000, 0x000d8045, 0x000d4145,
+	0x0009030c, 0x0009041c, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00090145, 0x00090944, 0x00000000, 0x00000000,
+	0x0009061c, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x0009033a,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00090200, 0x00090304, 0x00090408, 0x0009050c,
+	0x00090610, 0x00090714, 0x00090818, 0x0009121c,
+	0x0009131e, 0x00000000, 0x00000000, 0x00000000,
+	0x0009063d, 0x00090740, 0x000d803f, 0x000d413f,
+	0x0009030c, 0x0009041c, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0009013f, 0x00090840, 0x000dc93d, 0x000d093d,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x000a0324, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x000a003e,
+	0x000a0140, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x000a0324, 0x000a0520, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x000a003e,
+	0x000a0140, 0x000a0842, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x000a0124, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x000a0224, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x000a003c, 0x000a0037, 0x000ec139, 0x000e0139,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x000a0036,
+	0x000a0138, 0x000a0742, 0x00000000, 0x00000000,
+	0x000a0d41, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x000a0036,
+	0x000a0138, 0x00000000, 0x00000000, 0x00000000,
+	0x000a0d3e, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x000a0036,
+	0x000a0138, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x000a0037, 0x000a0139, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00080020, 0x00080228, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00080224,
+	0x00080326, 0x00080634, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00080020, 0x00080228, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00080224,
+	0x00080326, 0x00080730, 0x00080834, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00080020, 0x00080228, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00080224,
+	0x00080326, 0x00080730, 0x00080932, 0x00080a34,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0009061c, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x0009033a,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00090200, 0x00090304, 0x00090408, 0x0009050c,
+	0x00090610, 0x00090714, 0x00090818, 0x0009121c,
+	0x0009131e, 0x00000000, 0x00000000, 0x00000000,
+	0x0009063d, 0x00090740, 0x000d803f, 0x000d413f,
+	0x0009030c, 0x0009041c, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0009013f, 0x00090840, 0x000dc93d, 0x000d093d,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x000a003c, 0x000a0037, 0x000ec139, 0x000e0139,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x000a0036,
+	0x000a0138, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x000a0036,
+	0x000a0138, 0x000a0742, 0x00000000, 0x00000000,
+	0x000a0d41, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x000a0036,
+	0x000a0138, 0x00000000, 0x00000000, 0x00000000,
+	0x000a0d3e, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x000a0037, 0x000a0139, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec012_data[] = {
+	0x00000006, 0x00000001, 0x00000004, 0x00000001,
+	0x00000006, 0x00000001, 0x00000000, 0x00000001,
+	0x00000004, 0x00000001, 0x00000000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000010, 0x00000001, 0x00000000, 0x00000001,
+	0x00000040, 0x00000001, 0x00000010, 0x00000001,
+	0x00000000, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x06200000, 0x00000001, 0x00c00000, 0x00000001,
+	0x02c00000, 0x00000001, 0x00200000, 0x00000001,
+	0x00400000, 0x00000001, 0x00700000, 0x00000001,
+	0x00300000, 0x00000001, 0x00000000, 0x00000001,
+	0x00a00000, 0x00000001, 0x00b00000, 0x00000001,
+	0x00e00000, 0x00000001, 0x00500000, 0x00000001,
+	0x00800000, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000004, 0x00000001, 0x00000000, 0x00000001,
+	0x00000000, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000040, 0x00000001, 0x00000010, 0x00000001,
+	0x00000000, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00500000, 0x00000001, 0x00700000, 0x00000001,
+	0x00a00000, 0x00000001, 0x00b00000, 0x00000001,
+	0x00200000, 0x00000001, 0x00000000, 0x00000001,
+	0x00300000, 0x00000001, 0x00800000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec013_data[] = {
+	0xf7fffff0, 0xf7fffff1, 0xfffffff0, 0xf7fffff3,
+	0xfffffff1, 0xfffffff3, 0xffffffff, 0xffffffff,
+	0xf7ffff0f, 0xf7ffff0f, 0xffffff0f, 0xffffff0f,
+	0xffffff0f, 0xffffffff, 0xffffffff, 0xffffffff,
+	0x100fffff, 0xf10fffff, 0xf10fffff, 0xf70fffff,
+	0xf70fffff, 0xff0fffff, 0xff0fffff, 0xff1fffff,
+	0xff0fffff, 0xff0fffff, 0xff0fffff, 0xff0fffff,
+	0xff1fffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xfffffff1, 0xfffffff3, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffff0f, 0xffffff0f, 0xffffff0f, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xff0fffff, 0xff0fffff, 0xff0fffff, 0xff0fffff,
+	0xff0fffff, 0xff1fffff, 0xff0fffff, 0xff1fffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+};
+
+static u32 nbl_sec014_data[] = {
+	0x00000000, 0x00000001, 0x00000003, 0x00000002,
+	0x00000004, 0x00000005, 0x00000000, 0x00000000,
+	0x00000000, 0x00000001, 0x00000002, 0x00000003,
+	0x00000004, 0x00000000, 0x00000000, 0x00000000,
+	0x00000001, 0x00000002, 0x00000003, 0x00000000,
+	0x00000000, 0x00000004, 0x00000005, 0x00000006,
+	0x00000000, 0x00000000, 0x00000000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000001, 0x00000002, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000001, 0x00000002, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000001, 0x00000001, 0x00000001,
+	0x00000002, 0x00000003, 0x00000004, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec022_data[] = {
+	0x81008100, 0x00000001, 0x88a88100, 0x00000001,
+	0x810088a8, 0x00000001, 0x88a888a8, 0x00000001,
+	0x81000000, 0x00000001, 0x88a80000, 0x00000001,
+	0x00000000, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x08004000, 0x00000001, 0x86dd6000, 0x00000001,
+	0x81000000, 0x00000001, 0x88a80000, 0x00000001,
+	0x08060000, 0x00000001, 0x80350000, 0x00000001,
+	0x88080000, 0x00000001, 0x88f70000, 0x00000001,
+	0x88cc0000, 0x00000001, 0x88090000, 0x00000001,
+	0x89150000, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000001,
+	0x11006000, 0x00000001, 0x06006000, 0x00000001,
+	0x02006000, 0x00000001, 0x3a006000, 0x00000001,
+	0x2f006000, 0x00000001, 0x84006000, 0x00000001,
+	0x32006000, 0x00000001, 0x2c006000, 0x00000001,
+	0x3c006000, 0x00000001, 0x2b006000, 0x00000001,
+	0x00006000, 0x00000001, 0x00004000, 0x00000001,
+	0x00004000, 0x00000001, 0x20004000, 0x00000001,
+	0x40004000, 0x00000001, 0x00000000, 0x00000001,
+	0x11000000, 0x00000001, 0x06000000, 0x00000001,
+	0x02000000, 0x00000001, 0x3a000000, 0x00000001,
+	0x2f000000, 0x00000001, 0x84000000, 0x00000001,
+	0x32000000, 0x00000001, 0x2c000000, 0x00000001,
+	0x2b000000, 0x00000001, 0x3c000000, 0x00000001,
+	0x3b000000, 0x00000001, 0x00000000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x11000000, 0x00000001, 0x06000000, 0x00000001,
+	0x02000000, 0x00000001, 0x3a000000, 0x00000001,
+	0x2f000000, 0x00000001, 0x84000000, 0x00000001,
+	0x32000000, 0x00000001, 0x00000000, 0x00000000,
+	0x2c000000, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x2b000000, 0x00000001, 0x3c000000, 0x00000001,
+	0x3b000000, 0x00000001, 0x00000000, 0x00000001,
+	0x06001072, 0x00000001, 0x06000000, 0x00000001,
+	0x110012b7, 0x00000001, 0x01000000, 0x00000001,
+	0x02000000, 0x00000001, 0x3a000000, 0x00000001,
+	0x32000000, 0x00000001, 0x84000000, 0x00000001,
+	0x11000043, 0x00000001, 0x11000044, 0x00000001,
+	0x11000222, 0x00000001, 0x11000000, 0x00000001,
+	0x2f006558, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec023_data[] = {
+	0x10001000, 0x00001000, 0x10000000, 0x00000000,
+	0x1000ffff, 0x0000ffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0x00000fff, 0x00000fff, 0x1000ffff, 0x0000ffff,
+	0x0000ffff, 0x0000ffff, 0x0000ffff, 0x0000ffff,
+	0x0000ffff, 0x0000ffff, 0x0000ffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0x00ff0fff, 0x00ff0fff, 0x00ff0fff, 0x00ff0fff,
+	0x00ff0fff, 0x00ff0fff, 0x00ff0fff, 0x00ff0fff,
+	0x00ff0fff, 0x10ff0fff, 0xffff0fff, 0x00000fff,
+	0x1fff0fff, 0x1fff0fff, 0x1fff0fff, 0xffffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0xffffffff,
+	0x00ffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0xffffffff,
+	0x00ff0000, 0x00ffffff, 0x00ff0000, 0x00ffffff,
+	0x00ffffff, 0x00ffffff, 0x00ffffff, 0x00ffffff,
+	0x00ff0000, 0x00ff0000, 0x00ff0001, 0x00ffffff,
+	0x00ff0000, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+};
+
+static u32 nbl_sec024_data[] = {
+	0x00809190, 0x16009496, 0x00000100, 0x00000000,
+	0x00809190, 0x16009496, 0x00000100, 0x00000000,
+	0x00809190, 0x16009496, 0x00000100, 0x00000000,
+	0x00809190, 0x16009496, 0x00000100, 0x00000000,
+	0x00800090, 0x12009092, 0x00000100, 0x00000000,
+	0x00800090, 0x12009092, 0x00000100, 0x00000000,
+	0x00800000, 0x0e008c8e, 0x00000100, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x08900081, 0x00008680, 0x00000200, 0x00000000,
+	0x10900082, 0x28008680, 0x00000200, 0x00000000,
+	0x809b0093, 0x00000000, 0x00000100, 0x00000000,
+	0x809b0093, 0x00000000, 0x00000100, 0x00000000,
+	0x009b008f, 0x00000000, 0x00000100, 0x00000000,
+	0x009b008f, 0x00000000, 0x00000100, 0x00000000,
+	0x009b008f, 0x00000000, 0x00000100, 0x00000000,
+	0x009b008f, 0x00000000, 0x00000100, 0x00000000,
+	0x009b008f, 0x00000000, 0x00000100, 0x00000000,
+	0x009b008f, 0x00000000, 0x00000100, 0x00000000,
+	0x009b0000, 0x00000000, 0x00000100, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x009b0000, 0x00000000, 0x00000100, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00ab0085, 0x08000000, 0x00000200, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000200, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000200, 0x00000000,
+	0x40000000, 0x01c180c2, 0x00000300, 0x00000000,
+	0x00000000, 0x00a089c2, 0x000005f0, 0x00000000,
+	0x000b0085, 0x00a00000, 0x000002f0, 0x00000000,
+	0x000b0085, 0x00a00000, 0x000002f0, 0x00000000,
+	0x00000000, 0x00a089c2, 0x000005f0, 0x00000000,
+	0x000b0000, 0x00000000, 0x00000200, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00ab0085, 0x08000000, 0x00000300, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000300, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000300, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000300, 0x00000000,
+	0x40000000, 0x01c180c2, 0x00000400, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000082, 0x00000500, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00ab0085, 0x08000000, 0x00000400, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000400, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000400, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000400, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000400, 0x00000000,
+	0x01ab0083, 0x0ca00000, 0x0000050f, 0x00000000,
+	0x01ab0083, 0x0ca00000, 0x0000050f, 0x00000000,
+	0x02ab848a, 0x08000000, 0x00000500, 0x00000000,
+	0x00ab8f8e, 0x04000000, 0x00000500, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000500, 0x00000000,
+	0x00ab8f8e, 0x04000000, 0x00000500, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000500, 0x00000000,
+	0x04ab8e84, 0x0c000000, 0x00000500, 0x00000000,
+	0x02ab848f, 0x08000000, 0x00000500, 0x00000000,
+	0x02ab848f, 0x08000000, 0x00000500, 0x00000000,
+	0x02ab848f, 0x08000000, 0x00000500, 0x00000000,
+	0x02ab0084, 0x08000000, 0x00000500, 0x00000000,
+	0x00ab0000, 0x04000000, 0x00000500, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00ab0000, 0x00000000, 0x00000500, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec025_data[] = {
+	0x00000060, 0x00000090, 0x00000001, 0x00000000,
+	0x00000050, 0x000000a0, 0x00000001, 0x00000000,
+	0x000000a0, 0x00000050, 0x00000001, 0x00000000,
+	0x00000800, 0x00000700, 0x00000001, 0x00000000,
+	0x00000900, 0x00000600, 0x00000001, 0x00000000,
+	0x00008000, 0x00007000, 0x00000001, 0x00000000,
+	0x00009000, 0x00006000, 0x00000001, 0x00000000,
+	0x0000a000, 0x00005000, 0x00000001, 0x00000000,
+	0x000c0000, 0x00030000, 0x00000001, 0x00000000,
+	0x000d0000, 0x00020000, 0x00000001, 0x00000000,
+	0x000e0000, 0x00010000, 0x00000001, 0x00000000,
+	0x00000040, 0x000000b0, 0x00000001, 0x00000000,
+	0x00000070, 0x00000080, 0x00000001, 0x00000000,
+	0x00000090, 0x00000060, 0x00000001, 0x00000000,
+	0x00000080, 0x00000070, 0x00000001, 0x00000000,
+	0x00000700, 0x00000800, 0x00000001, 0x00000000,
+	0x00007000, 0x00008000, 0x00000001, 0x00000000,
+	0x00080000, 0x00070000, 0x00000001, 0x00000000,
+	0x00000c00, 0x00000300, 0x00000001, 0x00000000,
+	0x00000d00, 0x00000200, 0x00000001, 0x00000000,
+	0x00400000, 0x00b00000, 0x00000001, 0x00000000,
+	0x00600000, 0x00900000, 0x00000001, 0x00000000,
+	0x00300000, 0x00c00000, 0x00000001, 0x00000000,
+	0x00500000, 0x00a00000, 0x00000001, 0x00000000,
+	0x00700000, 0x00800000, 0x00000001, 0x00000000,
+	0x00000000, 0x00f00000, 0x00000001, 0x00000000,
+	0x00000000, 0x00f00000, 0x00000001, 0x00000000,
+	0x00100000, 0x00e00000, 0x00000001, 0x00000000,
+	0x00200000, 0x00d00000, 0x00000001, 0x00000000,
+	0x00800000, 0x00700000, 0x00000001, 0x00000000,
+	0x00900000, 0x00600000, 0x00000001, 0x00000000,
+	0x00a00000, 0x00500000, 0x00000001, 0x00000000,
+	0x00b00000, 0x00400000, 0x00000001, 0x00000000,
+	0x000f0000, 0x00000000, 0x00000001, 0x00000000,
+	0x00f00000, 0x00000000, 0x00000001, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec026_data[] = {
+	0x0000000a, 0x0000000a, 0x0000000a, 0x0000000a,
+	0x0000000a, 0x0000000a, 0x0000000a, 0x0000000a,
+	0x0000000a, 0x0000000a, 0x0000000a, 0x00000000,
+	0x0000000b, 0x00000008, 0x00000009, 0x0000000f,
+	0x0000000f, 0x0000000f, 0x0000000f, 0x0000000f,
+	0x0000000c, 0x0000000d, 0x00000001, 0x00000001,
+	0x0000000e, 0x00000005, 0x00000002, 0x00000002,
+	0x00000004, 0x00000003, 0x00000003, 0x00000003,
+	0x00000003, 0x0000000a, 0x0000000a, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec027_data[] = {
+	0x00080020, 0x00080228, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00080224,
+	0x00080326, 0x00080634, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00080020, 0x00080228, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00080224,
+	0x00080326, 0x00080730, 0x00080834, 0x0008082e,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00080020, 0x00080228, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00080224,
+	0x00080326, 0x00080730, 0x00080932, 0x00080a34,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0009061c, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x0009033a,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00090200, 0x00090304, 0x00090408, 0x0009050c,
+	0x00090610, 0x00090714, 0x00090818, 0x0009121c,
+	0x0009131e, 0x00000000, 0x00000000, 0x00000000,
+	0x0009063d, 0x00090740, 0x000d803f, 0x000d413f,
+	0x0009030c, 0x0009041c, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0009013f, 0x00090840, 0x000dc93d, 0x000d093d,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x000a003c, 0x000a0037, 0x000ec139, 0x000e0139,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x000a0036,
+	0x000a0138, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x000a0036,
+	0x000a0138, 0x000a0742, 0x00000000, 0x00000000,
+	0x000a0d41, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x000a0036,
+	0x000a0138, 0x00000000, 0x00000000, 0x00000000,
+	0x000a0d3e, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x000a0037, 0x000a0139, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec028_data[] = {
+	0x00000006, 0x00000001, 0x00000004, 0x00000001,
+	0x00000000, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000040, 0x00000001, 0x00000010, 0x00000001,
+	0x00000000, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00500000, 0x00000001, 0x00700000, 0x00000001,
+	0x00a00000, 0x00000001, 0x00b00000, 0x00000001,
+	0x00200000, 0x00000001, 0x00000000, 0x00000001,
+	0x00300000, 0x00000001, 0x00800000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec029_data[] = {
+	0xfffffff0, 0xfffffff1, 0xfffffff3, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffff0f, 0xffffff0f, 0xffffff0f, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xff0fffff, 0xff0fffff, 0xff0fffff, 0xff0fffff,
+	0xff0fffff, 0xff1fffff, 0xff0fffff, 0xff1fffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff,
+};
+
+static u32 nbl_sec030_data[] = {
+	0x00000000, 0x00000001, 0x00000002, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000001, 0x00000002, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000001, 0x00000001, 0x00000001,
+	0x00000002, 0x00000003, 0x00000004, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec039_data[] = {
+	0xfef80000, 0x00000002, 0x000002e0, 0x00000000,
+	0xfef8013e, 0x00000002, 0x000002e0, 0x00000000,
+	0x6660013e, 0x726e6802, 0x02224e42, 0x00000000,
+	0x6660013e, 0x726e6802, 0x02224e42, 0x00000000,
+	0x66600000, 0x726e6802, 0x02224e42, 0x00000000,
+	0x66600000, 0x726e6802, 0x02224e42, 0x00000000,
+	0x66600000, 0x00026802, 0x02224e40, 0x00000000,
+	0x66627800, 0x00026802, 0x02224e40, 0x00000000,
+	0x66600000, 0x00026a76, 0x02224e40, 0x00000000,
+	0x66600000, 0x00026802, 0x00024e40, 0x00000000,
+	0x66600000, 0x00026802, 0x00024e40, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec040_data[] = {
+	0x0040fb3f, 0x00000001, 0x0440fb3f, 0x00000001,
+	0x0502fa00, 0x00000001, 0x0602f900, 0x00000001,
+	0x0903e600, 0x00000001, 0x0a03e500, 0x00000001,
+	0x1101e600, 0x00000001, 0x1201e500, 0x00000001,
+	0x0000ff00, 0x00000001, 0x0008ff07, 0x00000001,
+	0x00ffff00, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec046_4p_data[] = {
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0xa0000000, 0x00077c2b, 0x005c0000,
+	0x00000000, 0x00008100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x20000000, 0x00073029, 0x00480000,
+	0x00000000, 0x00008100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x20000000, 0x00073029, 0x00480000,
+	0x70000000, 0x00000020, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0xa0000000, 0x00000009, 0x00000000,
+	0x00000000, 0x00002100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0xb0000000, 0x00000009, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x70000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x70000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x38430000,
+	0x70000006, 0x00000020, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x98cb1180, 0x6e36d469,
+	0x9d8eb91c, 0x87e3ef47, 0xa2931288, 0x08405c5a,
+	0x73865086, 0x00000080, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0xb0000000, 0x000b3849, 0x38430000,
+	0x00000006, 0x0000c100, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0xb0000000, 0x00133889, 0x08400000,
+	0x03865086, 0x4c016100, 0x00000014, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec047_data[] = {
+	0x2040dc3f, 0x00000001, 0x2000dcff, 0x00000001,
+	0x2200dcff, 0x00000001, 0x0008dc01, 0x00000001,
+	0x0001de00, 0x00000001, 0x2900c4ff, 0x00000001,
+	0x3100c4ff, 0x00000001, 0x2b00c4ff, 0x00000001,
+	0x3300c4ff, 0x00000001, 0x2700d8ff, 0x00000001,
+	0x2300d8ff, 0x00000001, 0x2502d800, 0x00000001,
+	0x2102d800, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec052_data[] = {
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x30000000, 0x000b844c, 0xc8580000,
+	0x00000006, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x20000000, 0xb0d3668b, 0xb0555e12,
+	0x03b055c6, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x20000000, 0xa64b3449, 0x405a3cc1,
+	0x00000006, 0x3d2d3300, 0x00000010, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x20000000, 0x26473429, 0x00482cc1,
+	0x00000000, 0x00ccd300, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec053_data[] = {
+	0x0840f03f, 0x00000001, 0x0040f03f, 0x00000001,
+	0x0140fa3f, 0x00000001, 0x0100fa0f, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec058_data[] = {
+	0x00000000, 0x00000000, 0x59f89400, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00470000,
+	0x00000000, 0x3c000000, 0xa2e40006, 0x00000017,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x19fa1400, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x28440000,
+	0x038e5186, 0x3c000000, 0xa8e40012, 0x00000047,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x0001f3d0, 0x00000000,
+	0x00000000, 0xb0000000, 0x00133889, 0x38c30000,
+	0x0000000a, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x0001f3d0, 0x00000000,
+	0x00000000, 0xb0000000, 0x00133889, 0x38c30000,
+	0x0000000a, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x000113d0, 0x00000000,
+	0x00000000, 0xb0000000, 0x00073829, 0x00430000,
+	0x00000000, 0x3c000000, 0x0000000a, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x000293d0, 0x00000000,
+	0x00000000, 0xb0000000, 0x00133889, 0x08400000,
+	0x03865086, 0x3c000000, 0x00000016, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec059_data[] = {
+	0x0200e4ff, 0x00000001, 0x0400e2ff, 0x00000001,
+	0x1300ecff, 0x00000001, 0x1500eaff, 0x00000001,
+	0x0300e4ff, 0x00000001, 0x0500e2ff, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec062_data[] = {
+	0x90939899, 0x88809c9b, 0x0000013d, 0x00000000,
+	0x90939899, 0x88809c9b, 0x0000013d, 0x00000000,
+	0x90939899, 0x88809c9b, 0x0000013d, 0x00000000,
+	0x90939899, 0x88809c9b, 0x0000013d, 0x00000000,
+	0x90939899, 0x88809c9b, 0x0000013d, 0x00000000,
+	0x90939899, 0x88809c9b, 0x0000013d, 0x00000000,
+	0x90939899, 0x88809c9b, 0x0000013d, 0x00000000,
+	0x90939899, 0x88809c9b, 0x0000013d, 0x00000000,
+	0x90939899, 0x88809c9b, 0x0000013d, 0x00000000,
+	0x90939899, 0x88809c9b, 0x0000013d, 0x00000000,
+	0x90939899, 0x88809c9b, 0x0000013d, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec063_data[] = {
+	0x0500e2ff, 0x00000001, 0x0900e2ff, 0x00000001,
+	0x1900e2ff, 0x00000001, 0x1100e2ff, 0x00000001,
+	0x0100e2ff, 0x00000001, 0x0600e1ff, 0x00000001,
+	0x0a00e1ff, 0x00000001, 0x1a00e1ff, 0x00000001,
+	0x1200e1ff, 0x00000001, 0x0200e1ff, 0x00000001,
+	0x0000fcff, 0x00000001, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec065_data[] = {
+	0x006e120c, 0x006e1210, 0x006e4208, 0x006e4218,
+	0x00200b02, 0x00200b00, 0x000e1900, 0x000e1906,
+	0x00580208, 0x00580204, 0x004c0208, 0x004c0207,
+	0x0002110c, 0x0002110c, 0x0012010c, 0x00100110,
+	0x0010010c, 0x000a010c, 0x0008010c, 0x00060000,
+	0x00160000, 0x00140000, 0x001e0000, 0x001e0000,
+	0x001e0000, 0x001e0000, 0x001e0000, 0x001e0000,
+	0x001e0000, 0x001e0000, 0x001e0000, 0x001e0000,
+};
+
+static u32 nbl_sec066_data[] = {
+	0x006e120c, 0x006e1210, 0x006e4208, 0x006e4218,
+	0x00200b02, 0x00200b00, 0x000e1900, 0x000e1906,
+	0x00580208, 0x00580204, 0x004c0208, 0x004c0207,
+	0x0002110c, 0x0002110c, 0x0012010c, 0x00100110,
+	0x0010010c, 0x000a010c, 0x0008010c, 0x00060000,
+	0x00160000, 0x00140000, 0x001e0000, 0x001e0000,
+	0x001e0000, 0x001e0000, 0x001e0000, 0x001e0000,
+	0x001e0000, 0x001e0000, 0x001e0000, 0x001e0000,
+};
+
+static u32 nbl_sec071_4p_data[] = {
+	0x00000000, 0x00000000, 0x00113d00, 0x00000000,
+	0x00000000, 0x00000000, 0xe7029b00, 0x00000000,
+	0x00000000, 0x43000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x51e00000, 0x00000c9c,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00293d00, 0x00000000,
+	0x00000000, 0x00000000, 0x67089b00, 0x00000002,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x80000000, 0x00000000, 0xb1e00000, 0x0000189c,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00213d00, 0x00000000,
+	0x00000000, 0x00000000, 0xe7069b00, 0x00000001,
+	0x00000000, 0x43000000, 0x014b0c70, 0x00000000,
+	0x00000000, 0x00000000, 0x92600000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00213d00, 0x00000000,
+	0x00000000, 0x00000000, 0xe7069b00, 0x00000001,
+	0x00000000, 0x43000000, 0x015b0c70, 0x00000000,
+	0x00000000, 0x00000000, 0x92600000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00553d00, 0x00000000,
+	0x00000000, 0x00000000, 0xe6d29a00, 0x000149c4,
+	0x00000000, 0x4b000000, 0x00000004, 0x00000000,
+	0x80000000, 0x00022200, 0x62600000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00553d00, 0x00000000,
+	0x00000000, 0x00000000, 0xe6d2c000, 0x000149c4,
+	0x00000000, 0x5b000000, 0x00000004, 0x00000000,
+	0x80000000, 0x00022200, 0x62600000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x006d3d00, 0x00000000,
+	0x00000000, 0x00000000, 0x64d49200, 0x5e556945,
+	0xc666d89a, 0x4b0001a9, 0x00004c84, 0x00000000,
+	0x80000000, 0x00022200, 0xc2600000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x006d3d00, 0x00000000,
+	0x00000000, 0x00000000, 0x6ed4ba00, 0x5ef56bc5,
+	0xc666d8c0, 0x5b0001a9, 0x00004dc4, 0x00000000,
+	0x80000000, 0x00022200, 0xc2600000, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000002, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00700000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec072_data[] = {
+	0x84006aff, 0x00000001, 0x880066ff, 0x00000001,
+	0x140040ff, 0x00000001, 0x70000cff, 0x00000001,
+	0x180040ff, 0x00000001, 0x30000cff, 0x00000001,
+	0x10004cff, 0x00000001, 0x30004cff, 0x00000001,
+	0x0100ecff, 0x00000001, 0x0300ecff, 0x00000001,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec116_data[] = {
+	0x00000000, 0x00000000, 0x3fff8000, 0x00000007,
+	0x3fff8000, 0x00000007, 0x3fff8000, 0x00000007,
+	0x3fff8000, 0x00000003, 0x3fff8000, 0x00000003,
+	0x3fff8000, 0x00000007, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec124_data[] = {
+	0xfffffffc, 0xffffffff, 0x00300000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000500, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffc, 0xffffffff, 0x00300010, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000500, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffc, 0xffffffff, 0x00300010, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000500, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffc, 0xffffffff, 0x00300fff, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000580, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffc, 0xffffffff, 0x00301fff, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000580, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffc, 0xffffffff, 0x0030ffff, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000580, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffc, 0xffffffff, 0x0030ffff, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000580, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffc, 0xffffffff, 0x0030ffff, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000580, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffc, 0xffffffff, 0x0030ffff, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000580, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffc, 0xffffffff, 0x00300000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000500, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x0000fffe, 0x00000000, 0x00300000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000480, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffc, 0x00ffffff, 0x00300000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000480, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffe, 0x0000000f, 0x00300000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000580, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec125_data[] = {
+	0xfffffffc, 0x01ffffff, 0x00300000, 0x70000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000480, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffe, 0x00000001, 0x00300000, 0x70000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000540, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffe, 0x011003ff, 0x00300000, 0x70000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x000005c0, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffc, 0x103fffff, 0x00300001, 0x70000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000480, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec126_data[] = {
+	0xfffffffc, 0xffffffff, 0x00300001, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000500, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffe, 0x000001ff, 0x00300000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x000005c0, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00002013, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000400, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00002013, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000400, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffc, 0x01ffffff, 0x00300000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000480, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0xfffffffe, 0x00000001, 0x00300000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000540, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+};
+
+static u32 nbl_sec137_data[] = {
+	0x0000017a, 0x000000f2, 0x00000076, 0x0000017a,
+	0x0000017a, 0x00000080, 0x00000024, 0x0000017a,
+	0x0000017a, 0x00000191, 0x00000035, 0x0000017a,
+	0x0000017a, 0x0000017a, 0x0000017a, 0x0000017a,
+	0x0000017a, 0x000000d2, 0x00000066, 0x0000017a,
+	0x0000017a, 0x0000017a, 0x0000017a, 0x0000017a,
+	0x0000017a, 0x000000f2, 0x00000076, 0x0000017a,
+	0x0000017a, 0x0000017a, 0x0000017a, 0x0000017a,
+};
+
+static u32 nbl_sec138_data[] = {
+	0x0000017a, 0x000000f2, 0x00000076, 0x0000017a,
+	0x0000017a, 0x00000080, 0x00000024, 0x0000017a,
+	0x0000017a, 0x00000191, 0x00000035, 0x0000017a,
+	0x0000017a, 0x0000017a, 0x0000017a, 0x0000017a,
+	0x0000017a, 0x000000d2, 0x00000066, 0x0000017a,
+	0x0000017a, 0x0000017a, 0x0000017a, 0x0000017a,
+	0x0000017a, 0x000000f2, 0x00000076, 0x0000017a,
+	0x0000017a, 0x0000017a, 0x0000017a, 0x0000017a,
+};
+
+void nbl_write_all_regs(void *priv)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_common_info *common = NBL_HW_MGT_TO_COMMON(hw_mgt);
+	u32 *nbl_sec046_data;
+	u32 *nbl_sec071_data;
+	u8 eth_mode = NBL_COMMON_TO_ETH_MODE(common);
+	u32 i = 0;
+
+	switch (eth_mode) {
+	case 1:
+		nbl_sec046_data = nbl_sec046_1p_data;
+		nbl_sec071_data = nbl_sec071_1p_data;
+		break;
+	case 2:
+		nbl_sec046_data = nbl_sec046_2p_data;
+		nbl_sec071_data = nbl_sec071_2p_data;
+		break;
+	case 4:
+		nbl_sec046_data = nbl_sec046_4p_data;
+		nbl_sec071_data = nbl_sec071_4p_data;
+		break;
+	default:
+		nbl_sec046_data = nbl_sec046_2p_data;
+		nbl_sec071_data = nbl_sec071_2p_data;
+	}
+
+	for (i = 0; i < NBL_SEC006_SIZE; i++) {
+		if ((i + 1) % NBL_SEC_BLOCK_SIZE == 0)
+			nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
+
+		nbl_hw_wr32(hw_mgt, NBL_SEC006_REGI(i), nbl_sec006_data[i]);
+	}
+
+	for (i = 0; i < NBL_SEC007_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC007_REGI(i), nbl_sec007_data[i]);
+
+	for (i = 0; i < NBL_SEC008_SIZE; i++) {
+		if ((i + 1) % NBL_SEC_BLOCK_SIZE == 0)
+			nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
+
+		nbl_hw_wr32(hw_mgt, NBL_SEC008_REGI(i), nbl_sec008_data[i]);
+	}
+
+	for (i = 0; i < NBL_SEC009_SIZE; i++) {
+		if ((i + 1) % NBL_SEC_BLOCK_SIZE == 0)
+			nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
+
+		nbl_hw_wr32(hw_mgt, NBL_SEC009_REGI(i), nbl_sec009_data[i]);
+	}
+
+	for (i = 0; i < NBL_SEC010_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC010_REGI(i), nbl_sec010_data[i]);
+
+	for (i = 0; i < NBL_SEC011_SIZE; i++) {
+		if ((i + 1) % NBL_SEC_BLOCK_SIZE == 0)
+			nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
+
+		nbl_hw_wr32(hw_mgt, NBL_SEC011_REGI(i), nbl_sec011_data[i]);
+	}
+
+	for (i = 0; i < NBL_SEC012_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC012_REGI(i), nbl_sec012_data[i]);
+
+	for (i = 0; i < NBL_SEC013_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC013_REGI(i), nbl_sec013_data[i]);
+
+	for (i = 0; i < NBL_SEC014_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC014_REGI(i), nbl_sec014_data[i]);
+
+	for (i = 0; i < NBL_SEC022_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC022_REGI(i), nbl_sec022_data[i]);
+
+	for (i = 0; i < NBL_SEC023_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC023_REGI(i), nbl_sec023_data[i]);
+
+	for (i = 0; i < NBL_SEC024_SIZE; i++) {
+		if ((i + 1) % NBL_SEC_BLOCK_SIZE == 0)
+			nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
+
+		nbl_hw_wr32(hw_mgt, NBL_SEC024_REGI(i), nbl_sec024_data[i]);
+	}
+
+	for (i = 0; i < NBL_SEC025_SIZE; i++) {
+		if ((i + 1) % NBL_SEC_BLOCK_SIZE == 0)
+			nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
+
+		nbl_hw_wr32(hw_mgt, NBL_SEC025_REGI(i), nbl_sec025_data[i]);
+	}
+
+	for (i = 0; i < NBL_SEC026_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC026_REGI(i), nbl_sec026_data[i]);
+
+	for (i = 0; i < NBL_SEC027_SIZE; i++) {
+		if ((i + 1) % NBL_SEC_BLOCK_SIZE == 0)
+			nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
+
+		nbl_hw_wr32(hw_mgt, NBL_SEC027_REGI(i), nbl_sec027_data[i]);
+	}
+
+	for (i = 0; i < NBL_SEC028_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC028_REGI(i), nbl_sec028_data[i]);
+
+	for (i = 0; i < NBL_SEC029_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC029_REGI(i), nbl_sec029_data[i]);
+
+	for (i = 0; i < NBL_SEC030_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC030_REGI(i), nbl_sec030_data[i]);
+
+	for (i = 0; i < NBL_SEC039_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC039_REGI(i), nbl_sec039_data[i]);
+
+	for (i = 0; i < NBL_SEC040_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC040_REGI(i), nbl_sec040_data[i]);
+
+	for (i = 0; i < NBL_SEC046_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC046_REGI(i), nbl_sec046_data[i]);
+
+	for (i = 0; i < NBL_SEC047_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC047_REGI(i), nbl_sec047_data[i]);
+
+	for (i = 0; i < NBL_SEC052_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC052_REGI(i), nbl_sec052_data[i]);
+
+	for (i = 0; i < NBL_SEC053_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC053_REGI(i), nbl_sec053_data[i]);
+
+	for (i = 0; i < NBL_SEC058_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC058_REGI(i), nbl_sec058_data[i]);
+
+	for (i = 0; i < NBL_SEC059_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC059_REGI(i), nbl_sec059_data[i]);
+
+	for (i = 0; i < NBL_SEC062_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC062_REGI(i), nbl_sec062_data[i]);
+
+	for (i = 0; i < NBL_SEC063_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC063_REGI(i), nbl_sec063_data[i]);
+
+	for (i = 0; i < NBL_SEC065_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC065_REGI(i), nbl_sec065_data[i]);
+
+	for (i = 0; i < NBL_SEC066_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC066_REGI(i), nbl_sec066_data[i]);
+
+	for (i = 0; i < NBL_SEC071_SIZE; i++) {
+		if ((i + 1) % NBL_SEC_BLOCK_SIZE == 0)
+			nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
+
+		nbl_hw_wr32(hw_mgt, NBL_SEC071_REGI(i), nbl_sec071_data[i]);
+	}
+
+	for (i = 0; i < NBL_SEC072_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC072_REGI(i), nbl_sec072_data[i]);
+
+	for (i = 0; i < NBL_SEC116_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC116_REGI(i), nbl_sec116_data[i]);
+
+	for (i = 0; i < NBL_SEC124_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC124_REGI(i), nbl_sec124_data[i]);
+
+	for (i = 0; i < NBL_SEC125_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC125_REGI(i), nbl_sec125_data[i]);
+
+	for (i = 0; i < NBL_SEC126_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC126_REGI(i), nbl_sec126_data[i]);
+
+	for (i = 0; i < NBL_SEC137_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC137_REGI(i), nbl_sec137_data[i]);
+
+	for (i = 0; i < NBL_SEC138_SIZE; i++)
+		nbl_hw_wr32(hw_mgt, NBL_SEC138_REGI(i), nbl_sec138_data[i]);
+
+	nbl_hw_wr32(hw_mgt, NBL_SEC000_ADDR, 0x00000001);
+	nbl_hw_wr32(hw_mgt, NBL_SEC001_ADDR, 0x00000001);
+	nbl_hw_wr32(hw_mgt, NBL_SEC002_ADDR, 0x00000001);
+	nbl_hw_wr32(hw_mgt, NBL_SEC003_ADDR, 0x00000001);
+	nbl_hw_wr32(hw_mgt, NBL_SEC004_ADDR, 0x00000001);
+	nbl_hw_wr32(hw_mgt, NBL_SEC005_ADDR, 0x00000001);
+	nbl_hw_wr32(hw_mgt, NBL_SEC015_ADDR, 0x000f0908);
+	nbl_hw_wr32(hw_mgt, NBL_SEC016_ADDR, 0x10110607);
+	nbl_hw_wr32(hw_mgt, NBL_SEC017_ADDR, 0x383a3032);
+	nbl_hw_wr32(hw_mgt, NBL_SEC018_ADDR, 0x0201453f);
+	nbl_hw_wr32(hw_mgt, NBL_SEC019_ADDR, 0x00000a41);
+	nbl_hw_wr32(hw_mgt, NBL_SEC020_ADDR, 0x000000c8);
+	nbl_hw_wr32(hw_mgt, NBL_SEC021_ADDR, 0x00000400);
+	nbl_hw_wr32(hw_mgt, NBL_SEC031_ADDR, 0x000f0908);
+	nbl_hw_wr32(hw_mgt, NBL_SEC032_ADDR, 0x00001011);
+	nbl_hw_wr32(hw_mgt, NBL_SEC033_ADDR, 0x00003032);
+	nbl_hw_wr32(hw_mgt, NBL_SEC034_ADDR, 0x0201003f);
+	nbl_hw_wr32(hw_mgt, NBL_SEC035_ADDR, 0x0000000a);
+	nbl_hw_wr32(hw_mgt, NBL_SEC036_ADDR, 0x00001701);
+	nbl_hw_wr32(hw_mgt, NBL_SEC037_ADDR, 0x009238a1);
+	nbl_hw_wr32(hw_mgt, NBL_SEC038_ADDR, 0x0000002e);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(0), 0x00000200);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(1), 0x00000300);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(2), 0x00000105);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(3), 0x00000106);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(4), 0x00000009);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(5), 0x0000000a);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(6), 0x00000041);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(7), 0x00000082);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(8), 0x00000020);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(9), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(10), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(11), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(12), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(13), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(14), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC041_REGI(15), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC042_ADDR, 0x00000001);
+	nbl_hw_wr32(hw_mgt, NBL_SEC043_ADDR, 0x00000002);
+	nbl_hw_wr32(hw_mgt, NBL_SEC044_ADDR, 0x28212000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC045_ADDR, 0x00002b29);
+	nbl_hw_wr32(hw_mgt, NBL_SEC048_ADDR, 0x00000001);
+	nbl_hw_wr32(hw_mgt, NBL_SEC049_ADDR, 0x00000002);
+	nbl_hw_wr32(hw_mgt, NBL_SEC050_ADDR, 0x352b2000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC051_ADDR, 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC054_ADDR, 0x00000001);
+	nbl_hw_wr32(hw_mgt, NBL_SEC055_ADDR, 0x00000002);
+	nbl_hw_wr32(hw_mgt, NBL_SEC056_ADDR, 0x2b222100);
+	nbl_hw_wr32(hw_mgt, NBL_SEC057_ADDR, 0x00000038);
+	nbl_hw_wr32(hw_mgt, NBL_SEC060_ADDR, 0x24232221);
+	nbl_hw_wr32(hw_mgt, NBL_SEC061_ADDR, 0x0000002e);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(0), 0x00000009);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(1), 0x00000005);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(2), 0x00000011);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(3), 0x00000005);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(4), 0x00000001);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(5), 0x0000000a);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(6), 0x00000006);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(7), 0x00000012);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(8), 0x00000006);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(9), 0x00000002);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(10), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(11), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(12), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(13), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(14), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC064_REGI(15), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC067_ADDR, 0x00000001);
+	nbl_hw_wr32(hw_mgt, NBL_SEC068_ADDR, 0x00000001);
+	nbl_hw_wr32(hw_mgt, NBL_SEC069_ADDR, 0x22212000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC070_ADDR, 0x3835322b);
+	nbl_hw_wr32(hw_mgt, NBL_SEC073_ADDR, 0x0316a5ff);
+	nbl_hw_wr32(hw_mgt, NBL_SEC074_ADDR, 0x0316a5ff);
+	nbl_hw_wr32(hw_mgt, NBL_SEC075_REGI(0), 0x08802080);
+	nbl_hw_wr32(hw_mgt, NBL_SEC075_REGI(1), 0x12a05080);
+	nbl_hw_wr32(hw_mgt, NBL_SEC075_REGI(2), 0xffffffff);
+	nbl_hw_wr32(hw_mgt, NBL_SEC075_REGI(3), 0xffffffff);
+	nbl_hw_wr32(hw_mgt, NBL_SEC076_REGI(0), 0x08802080);
+	nbl_hw_wr32(hw_mgt, NBL_SEC076_REGI(1), 0x12a05080);
+	nbl_hw_wr32(hw_mgt, NBL_SEC076_REGI(2), 0xffffffff);
+	nbl_hw_wr32(hw_mgt, NBL_SEC076_REGI(3), 0xffffffff);
+	nbl_hw_wr32(hw_mgt, NBL_SEC077_REGI(0), 0x08802080);
+	nbl_hw_wr32(hw_mgt, NBL_SEC077_REGI(1), 0x12a05080);
+	nbl_hw_wr32(hw_mgt, NBL_SEC077_REGI(2), 0xffffffff);
+	nbl_hw_wr32(hw_mgt, NBL_SEC077_REGI(3), 0xffffffff);
+	nbl_hw_wr32(hw_mgt, NBL_SEC078_ADDR, 0x00000009);
+	nbl_hw_wr32(hw_mgt, NBL_SEC079_ADDR, 0x00000009);
+	nbl_hw_wr32(hw_mgt, NBL_SEC080_ADDR, 0x0014a248);
+	nbl_hw_wr32(hw_mgt, NBL_SEC081_ADDR, 0x00000d33);
+	nbl_hw_wr32(hw_mgt, NBL_SEC082_ADDR, 0x00000009);
+	nbl_hw_wr32(hw_mgt, NBL_SEC083_ADDR, 0x00000009);
+	nbl_hw_wr32(hw_mgt, NBL_SEC084_ADDR, 0x00000009);
+	nbl_hw_wr32(hw_mgt, NBL_SEC085_ADDR, 0x000144d2);
+	nbl_hw_wr32(hw_mgt, NBL_SEC086_ADDR, 0x31322e2f);
+	nbl_hw_wr32(hw_mgt, NBL_SEC087_ADDR, 0x0a092d2c);
+	nbl_hw_wr32(hw_mgt, NBL_SEC088_ADDR, 0x33050804);
+	nbl_hw_wr32(hw_mgt, NBL_SEC089_ADDR, 0x14131535);
+	nbl_hw_wr32(hw_mgt, NBL_SEC090_ADDR, 0x0000000a);
+	nbl_hw_wr32(hw_mgt, NBL_SEC091_ADDR, 0x00000009);
+	nbl_hw_wr32(hw_mgt, NBL_SEC092_ADDR, 0x00000008);
+	nbl_hw_wr32(hw_mgt, NBL_SEC093_ADDR, 0x0000000e);
+	nbl_hw_wr32(hw_mgt, NBL_SEC094_ADDR, 0x0000000f);
+	nbl_hw_wr32(hw_mgt, NBL_SEC095_ADDR, 0x00000015);
+	nbl_hw_wr32(hw_mgt, NBL_SEC096_ADDR, 0x00000009);
+	nbl_hw_wr32(hw_mgt, NBL_SEC097_ADDR, 0x0000000a);
+	nbl_hw_wr32(hw_mgt, NBL_SEC098_ADDR, 0x00000008);
+	nbl_hw_wr32(hw_mgt, NBL_SEC099_ADDR, 0x00000011);
+	nbl_hw_wr32(hw_mgt, NBL_SEC100_ADDR, 0x00000013);
+	nbl_hw_wr32(hw_mgt, NBL_SEC101_ADDR, 0x00000014);
+	nbl_hw_wr32(hw_mgt, NBL_SEC102_ADDR, 0x00000010);
+	nbl_hw_wr32(hw_mgt, NBL_SEC103_ADDR, 0x00000009);
+	nbl_hw_wr32(hw_mgt, NBL_SEC104_ADDR, 0x0000004d);
+	nbl_hw_wr32(hw_mgt, NBL_SEC105_ADDR, 0x08020a09);
+	nbl_hw_wr32(hw_mgt, NBL_SEC106_ADDR, 0x00000005);
+	nbl_hw_wr32(hw_mgt, NBL_SEC107_ADDR, 0x00000006);
+	nbl_hw_wr32(hw_mgt, NBL_SEC108_ADDR, 0x00000009);
+	nbl_hw_wr32(hw_mgt, NBL_SEC109_ADDR, 0x00110a09);
+	nbl_hw_wr32(hw_mgt, NBL_SEC110_ADDR, 0x00000009);
+	nbl_hw_wr32(hw_mgt, NBL_SEC111_ADDR, 0x00000009);
+	nbl_hw_wr32(hw_mgt, NBL_SEC112_ADDR, 0x00000009);
+	nbl_hw_wr32(hw_mgt, NBL_SEC113_ADDR, 0x0000000a);
+	nbl_hw_wr32(hw_mgt, NBL_SEC114_ADDR, 0x0000000a);
+	nbl_hw_wr32(hw_mgt, NBL_SEC115_ADDR, 0x00000009);
+	nbl_hw_wr32(hw_mgt, NBL_SEC117_ADDR, 0x0000000a);
+	nbl_hw_wr32(hw_mgt, NBL_SEC118_ADDR, 0x00000001);
+	nbl_hw_wr32(hw_mgt, NBL_SEC119_REGI(0), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC119_REGI(1), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC119_REGI(2), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC119_REGI(3), 0x00000000);
+	nbl_hw_wr32(hw_mgt, NBL_SEC119_REGI(4), 0x00000100);
+	nbl_hw_wr32(hw_mgt, NBL_SEC120_ADDR, 0x0000003c);
+	nbl_hw_wr32(hw_mgt, NBL_SEC121_ADDR, 0x00000003);
+	nbl_hw_wr32(hw_mgt, NBL_SEC122_ADDR, 0x000000bc);
+	nbl_hw_wr32(hw_mgt, NBL_SEC123_ADDR, 0x0000023b);
+	nbl_hw_wr32(hw_mgt, NBL_SEC127_ADDR, 0x00000001);
+	nbl_hw_wr32(hw_mgt, NBL_SEC128_ADDR, 0x00000001);
+	nbl_hw_wr32(hw_mgt, NBL_SEC129_ADDR, 0x00000002);
+	nbl_hw_wr32(hw_mgt, NBL_SEC130_ADDR, 0x00000002);
+	nbl_hw_wr32(hw_mgt, NBL_SEC131_ADDR, 0x00000003);
+	nbl_hw_wr32(hw_mgt, NBL_SEC132_ADDR, 0x00000003);
+	nbl_hw_wr32(hw_mgt, NBL_SEC133_ADDR, 0x00000004);
+	nbl_hw_wr32(hw_mgt, NBL_SEC134_ADDR, 0x00000004);
+	nbl_hw_wr32(hw_mgt, NBL_SEC135_ADDR, 0x0000000e);
+	nbl_hw_wr32(hw_mgt, NBL_SEC136_ADDR, 0x0000000e);
+}
+
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.h
new file mode 100644
index 000000000000..187f7557cc9e
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_HW_LEONIS_REGS_H_
+#define _NBL_HW_LEONIS_REGS_H_
+
+void nbl_write_all_regs(void *priv);
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_queue_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_queue_leonis.c
new file mode 100644
index 000000000000..58a588c7a733
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_queue_leonis.c
@@ -0,0 +1,1373 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#include "nbl_queue_leonis.h"
+#include "nbl_resource_leonis.h"
+
+static int nbl_res_queue_reset_uvn_pkt_drop_stats(void *priv, u16 func_id, u16 global_queue_id);
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
+	case NBL_VSI_USER:
+	case NBL_VSI_CTRL:
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
+static int nbl_res_queue_setup_queue_info(struct nbl_resource_mgt *res_mgt, u16 func_id,
+					  u16 num_queues)
+{
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_queue_info *queue_info = &queue_mgt->queue_info[func_id];
+	u16 *txrx_queues, *queues_context;
+	u32 *uvn_stat_pkt_drop;
+	u16 queue_index;
+	int i, ret = 0;
+
+	nbl_info(common, NBL_DEBUG_QUEUE,
+		 "Setup qid map, func_id:%d, num_queues:%d", func_id, num_queues);
+
+	txrx_queues = kcalloc(num_queues, sizeof(txrx_queues[0]), GFP_ATOMIC);
+	if (!txrx_queues) {
+		ret = -ENOMEM;
+		goto alloc_txrx_queues_fail;
+	}
+
+	queues_context = kcalloc(num_queues * 2, sizeof(txrx_queues[0]), GFP_ATOMIC);
+	if (!queues_context) {
+		ret = -ENOMEM;
+		goto alloc_queue_contex_fail;
+	}
+
+	uvn_stat_pkt_drop = kcalloc(num_queues, sizeof(*uvn_stat_pkt_drop), GFP_ATOMIC);
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
+		queue_index = find_first_zero_bit(queue_mgt->txrx_queue_bitmap, NBL_MAX_TXRX_QUEUE);
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
+static void nbl_res_queue_remove_queue_info(struct nbl_resource_mgt *res_mgt, u16 func_id)
+{
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_queue_info *queue_info = &queue_mgt->queue_info[func_id];
+	u16 i;
+
+	for (i = 0; i < queue_info->num_txrx_queues; i++)
+		clear_bit(queue_info->txrx_queues[i], queue_mgt->txrx_queue_bitmap);
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
+static inline u64 nbl_res_queue_qid_map_key(struct nbl_qid_map_table qid_map)
+{
+	u64 notify_addr_l = qid_map.notify_addr_l;
+	u64 notify_addr_h = qid_map.notify_addr_h;
+
+	return (notify_addr_h << NBL_QID_MAP_NOTIFY_ADDR_LOW_PART_LEN) | notify_addr_l;
+}
+
+static void nbl_res_queue_set_qid_map_table(struct nbl_resource_mgt *res_mgt, u16 tail)
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
+				   queue_mgt->qid_map_select);
+	queue_mgt->qid_map_select = !queue_mgt->qid_map_select;
+
+	if (!queue_mgt->qid_map_ready) {
+		hw_ops->set_qid_map_ready(NBL_RES_MGT_TO_HW_PRIV(res_mgt), true);
+		queue_mgt->qid_map_ready = true;
+	}
+
+	kfree(param.qid_map);
+}
+
+int nbl_res_queue_setup_qid_map_table_leonis(struct nbl_resource_mgt *res_mgt, u16 func_id,
+					     u64 notify_addr)
+{
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_queue_info *queue_info = &queue_mgt->queue_info[func_id];
+	struct nbl_qid_map_table qid_map;
+	u64 key;
+	u16 *txrx_queues = queue_info->txrx_queues;
+	u16 qid_map_entries = queue_info->num_txrx_queues, qid_map_base, tail;
+	int i;
+
+	/* Get base location */
+	queue_info->notify_addr = notify_addr;
+	key = notify_addr >> NBL_QID_MAP_NOTIFY_ADDR_SHIFT;
+
+	for (i = 0; i < NBL_QID_MAP_TABLE_ENTRIES; i++) {
+		WARN_ON(key == nbl_res_queue_qid_map_key(queue_mgt->qid_map_table[i]));
+		if (key < nbl_res_queue_qid_map_key(queue_mgt->qid_map_table[i])) {
+			qid_map_base = i;
+			break;
+		}
+	}
+	if (i == NBL_QID_MAP_TABLE_ENTRIES) {
+		nbl_err(common, NBL_DEBUG_QUEUE, "No valid qid map key for func %d", func_id);
+		return -ENOSPC;
+	}
+
+	/* Calc tail, we will set the qid_map from 0 to tail.
+	 * We have to make sure that this range (0, tail) can cover all the changes, which need to
+	 * consider all the two tables. Therefore, it is necessary to store each table's tail, and
+	 * always use the larger one between this table's tail and the added tail.
+	 *
+	 * The reason can be illustrated in the following example:
+	 * Step 1: del some entries, which happens on table 1, and each table could be
+	 *      Table 0: 0 - 31 used
+	 *      Table 1: 0 - 15 used
+	 *      SW     : queue_mgt->total_qid_map_entries = 16
+	 * Step 2: add 2 entries, which happens on table 0, if we use 16 + 2 as the tail, then
+	 *      Table 0: 0 - 17 correctly added, 18 - 31 garbage data
+	 *      Table 1: 0 - 15 used
+	 *      SW     : queue_mgt->total_qid_map_entries = 18
+	 * And this is definitely wrong, it should use 32, table 0's original tail
+	 */
+	queue_mgt->total_qid_map_entries += qid_map_entries;
+	tail = max(queue_mgt->total_qid_map_entries,
+		   queue_mgt->qid_map_tail[queue_mgt->qid_map_select]);
+	queue_mgt->qid_map_tail[queue_mgt->qid_map_select] = queue_mgt->total_qid_map_entries;
+
+	/* Update qid map */
+	for (i = NBL_QID_MAP_TABLE_ENTRIES - qid_map_entries; i > qid_map_base; i--)
+		queue_mgt->qid_map_table[i - 1 + qid_map_entries] = queue_mgt->qid_map_table[i - 1];
+
+	for (i = 0; i < queue_info->num_txrx_queues; i++) {
+		qid_map.local_qid = 2 * i + 1;
+		qid_map.notify_addr_l = key;
+		qid_map.notify_addr_h = key >> NBL_QID_MAP_NOTIFY_ADDR_LOW_PART_LEN;
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
+void nbl_res_queue_remove_qid_map_table_leonis(struct nbl_resource_mgt *res_mgt, u16 func_id)
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
+		if (key == nbl_res_queue_qid_map_key(queue_mgt->qid_map_table[i])) {
+			qid_map_base = i;
+			break;
+		}
+	}
+	if (i == NBL_QID_MAP_TABLE_ENTRIES) {
+		nbl_err(common, NBL_DEBUG_QUEUE, "No valid qid map key for func %d", func_id);
+		return;
+	}
+
+	/* Calc tail, we will set the qid_map from 0 to tail.
+	 * We have to make sure that this range (0, tail) can cover all the changes, which need to
+	 * consider all the two tables. Therefore, it is necessary to store each table's tail, and
+	 * always use the larger one between this table's tail and the driver-stored tail.
+	 *
+	 * The reason can be illustrated in the following example:
+	 * Step 1: del some entries, which happens on table 1, and each table could be
+	 *      Table 0: 0 - 31 used
+	 *      Table 1: 0 - 15 used
+	 *      SW     : queue_mgt->total_qid_map_entries = 16
+	 * Step 2: del 2 entries, which happens on table 0, if we use 16 as the tail, then
+	 *      Table 0: 0 - 13 correct, 14 - 31 garbage data
+	 *      Table 1: 0 - 15 used
+	 *      SW     : queue_mgt->total_qid_map_entries = 14
+	 * And this is definitely wrong, it should use 32, table 0's original tail
+	 */
+	tail = max(queue_mgt->total_qid_map_entries,
+		   queue_mgt->qid_map_tail[queue_mgt->qid_map_select]);
+	queue_mgt->total_qid_map_entries -= qid_map_entries;
+	queue_mgt->qid_map_tail[queue_mgt->qid_map_select] = queue_mgt->total_qid_map_entries;
+
+	/* Update qid map */
+	memset(&qid_map, U8_MAX, sizeof(qid_map));
+
+	for (i = qid_map_base; i < NBL_QID_MAP_TABLE_ENTRIES - qid_map_entries; i++)
+		queue_mgt->qid_map_table[i] = queue_mgt->qid_map_table[i + qid_map_entries];
+	for (; i < NBL_QID_MAP_TABLE_ENTRIES; i++)
+		queue_mgt->qid_map_table[i] = qid_map;
+
+	nbl_res_queue_set_qid_map_table(res_mgt, tail);
+}
+
+static int
+nbl_res_queue_get_rss_ret_base(struct nbl_resource_mgt *res_mgt, u16 count, u16 rss_entry_size,
+			       struct nbl_queue_vsi_info *vsi_info)
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
+	    (vsi_info->vsi_index == NBL_VSI_DATA || vsi_info->vsi_index == NBL_VSI_USER)) {
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
+			nbl_err(common, NBL_DEBUG_QUEUE, "There is no available rss ret left");
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
+	u16 func_id;
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
+	     i < queue_info->num_txrx_queues; i++) {
+		ret = hw_ops->cfg_ipro_queue_tbl(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+						  queue_info->txrx_queues[i], vsi_id, 1);
+		if (ret) {
+			while (--i + 1)
+				hw_ops->cfg_ipro_queue_tbl(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+							    queue_info->txrx_queues[i], 0, 0);
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
+	     i < vsi_info->queue_offset + vsi_info->queue_num && i < queue_info->num_txrx_queues;
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
+	rss_entry_size = (vsi_info->queue_num + NBL_EPRO_RSS_ENTRY_SIZE_UNIT - 1)
+			  / NBL_EPRO_RSS_ENTRY_SIZE_UNIT;
+
+	rss_entry_size = ilog2(roundup_pow_of_two(rss_entry_size));
+	count = NBL_EPRO_RSS_ENTRY_SIZE_UNIT << rss_entry_size;
+
+	ret = nbl_res_queue_get_rss_ret_base(res_mgt, count, rss_entry_size, vsi_info);
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
+static void nbl_res_queue_setup_queue_cfg(struct nbl_queue_mgt *queue_mgt,
+					  struct nbl_queue_cfg_param *cfg_param,
+					  struct nbl_txrx_queue_param *queue_param,
+					  bool is_tx, u16 func_id)
+{
+	struct nbl_queue_info *queue_info = &queue_mgt->queue_info[func_id];
+
+	cfg_param->desc = queue_param->dma;
+	cfg_param->size = queue_param->desc_num;
+	cfg_param->global_vector = queue_param->global_vector_id;
+	cfg_param->global_queue_id = queue_info->txrx_queues[queue_param->local_queue_id];
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
+static void nbl_res_queue_update_netid_refnum(struct nbl_queue_mgt *queue_mgt, u16 net_id, bool add)
+{
+	if (net_id >= NBL_MAX_NET_ID)
+		return;
+
+	if (add) {
+		queue_mgt->net_id_ref_vsinum[net_id]++;
+	} else {
+		/* probe call clear_queue first, so judge nor zero to support disable dsch more than
+		 * once
+		 */
+		if (queue_mgt->net_id_ref_vsinum[net_id])
+			queue_mgt->net_id_ref_vsinum[net_id]--;
+	}
+}
+
+static u16 nbl_res_queue_get_netid_refnum(struct nbl_queue_mgt *queue_mgt, u16 net_id)
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
+	u16 global_queue_id = queue_cfg->global_queue_id;
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
+		hw_ops->set_vnet_queue_info(NBL_RES_MGT_TO_HW_PRIV(res_mgt), &param,
+					     NBL_PAIR_ID_GET_TX(global_queue_id));
+		hw_ops->reset_dvn_cfg(NBL_RES_MGT_TO_HW_PRIV(res_mgt), global_queue_id);
+		if (!queue_cfg->extend_header)
+			hw_ops->restore_dvn_context(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+						     global_queue_id, queue_cfg->split,
+						     queue_cfg->last_avail_idx);
+		hw_ops->cfg_tx_queue(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+				      queue_cfg, global_queue_id);
+		if (nbl_res_queue_get_netid_refnum(queue_mgt, vsi_info->net_id))
+			hw_ops->cfg_q2tc_netid(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+						global_queue_id, vsi_info->net_id, 1);
+
+	} else {
+		hw_ops->set_vnet_queue_info(NBL_RES_MGT_TO_HW_PRIV(res_mgt), &param,
+					     NBL_PAIR_ID_GET_RX(global_queue_id));
+		hw_ops->reset_uvn_cfg(NBL_RES_MGT_TO_HW_PRIV(res_mgt), global_queue_id);
+		nbl_res_queue_reset_uvn_pkt_drop_stats(res_mgt, func_id, global_queue_id);
+		if (!queue_cfg->extend_header)
+			hw_ops->restore_uvn_context(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+						     global_queue_id, queue_cfg->split,
+						     queue_cfg->last_avail_idx);
+		hw_ops->cfg_rx_queue(NBL_RES_MGT_TO_HW_PRIV(res_mgt), queue_cfg,
+				      global_queue_id);
+	}
+}
+
+static void nbl_res_queue_remove_all_hw_dq(struct nbl_resource_mgt *res_mgt, u16 func_id,
+					   struct nbl_queue_vsi_info *vsi_info)
+{
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_queue_info *queue_info = &queue_mgt->queue_info[func_id];
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	u16 start = vsi_info->queue_offset, end = vsi_info->queue_offset + vsi_info->queue_num;
+	u16 global_queue;
+	int i;
+
+	for (i = start; i < end; i++) {
+		global_queue = queue_info->txrx_queues[i];
+
+		hw_ops->lso_dsch_drain(NBL_RES_MGT_TO_HW_PRIV(res_mgt), global_queue);
+		hw_ops->disable_dvn(NBL_RES_MGT_TO_HW_PRIV(res_mgt), global_queue);
+	}
+
+	for (i = start; i < end; i++) {
+		global_queue = queue_info->txrx_queues[i];
+
+		hw_ops->disable_uvn(NBL_RES_MGT_TO_HW_PRIV(res_mgt), global_queue);
+		hw_ops->rsc_cache_drain(NBL_RES_MGT_TO_HW_PRIV(res_mgt), global_queue);
+	}
+
+	for (i = start; i < end; i++) {
+		global_queue = queue_info->txrx_queues[i];
+		queue_info->queues_context[NBL_PAIR_ID_GET_RX(i)] =
+			hw_ops->save_uvn_ctx(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+					      global_queue, queue_info->split,
+					      queue_info->queue_size);
+		queue_info->queues_context[NBL_PAIR_ID_GET_TX(i)] =
+			hw_ops->save_dvn_ctx(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+					      global_queue, queue_info->split);
+	}
+
+	for (i = start; i < end; i++) {
+		global_queue = queue_info->txrx_queues[i];
+		hw_ops->reset_uvn_cfg(NBL_RES_MGT_TO_HW_PRIV(res_mgt), global_queue);
+		nbl_res_queue_reset_uvn_pkt_drop_stats(res_mgt, func_id, global_queue);
+		hw_ops->reset_dvn_cfg(NBL_RES_MGT_TO_HW_PRIV(res_mgt), global_queue);
+	}
+
+	for (i = start; i < end; i++) {
+		global_queue = queue_info->txrx_queues[i];
+		hw_ops->clear_vnet_queue_info(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+					       NBL_PAIR_ID_GET_RX(global_queue));
+		hw_ops->clear_vnet_queue_info(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+					       NBL_PAIR_ID_GET_TX(global_queue));
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
+static int nbl_res_queue_init_epro_vpt_table(struct nbl_resource_mgt *res_mgt, u16 func_id)
+{
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	struct nbl_sriov_info *sriov_info = &NBL_RES_MGT_TO_SRIOV_INFO(res_mgt)[func_id];
+	int pfid, vfid;
+	u16 vsi_id, vf_vsi_id;
+	u16 i;
+
+	vsi_id = nbl_res_func_id_to_vsi_id(res_mgt, func_id, NBL_VSI_SERV_PF_DATA_TYPE);
+	nbl_res_func_id_to_pfvfid(res_mgt, func_id, &pfid, &vfid);
+
+	if (sriov_info->bdf != 0) {
+		/* init pf vsi */
+		for (i = NBL_VSI_SERV_PF_DATA_TYPE; i <= NBL_VSI_SERV_PF_USER_TYPE; i++) {
+			vsi_id = nbl_res_func_id_to_vsi_id(res_mgt, func_id, i);
+			hw_ops->init_epro_vpt_tbl(NBL_RES_MGT_TO_HW_PRIV(res_mgt), vsi_id);
+		}
+
+		for (vfid = 0; vfid < sriov_info->num_vfs; vfid++) {
+			vf_vsi_id = nbl_res_pfvfid_to_vsi_id(res_mgt, pfid, vfid, NBL_VSI_DATA);
+			if (vf_vsi_id == 0xFFFF)
+				continue;
+
+			hw_ops->init_epro_vpt_tbl(NBL_RES_MGT_TO_HW_PRIV(res_mgt), vf_vsi_id);
+		}
+	}
+
+	return 0;
+}
+
+static int nbl_res_queue_init_ipro_dn_sport_tbl(struct nbl_resource_mgt *res_mgt,
+						u16 func_id, u16 bmode, bool binit)
+
+{
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	struct nbl_sriov_info *sriov_info = &NBL_RES_MGT_TO_SRIOV_INFO(res_mgt)[func_id];
+	int pfid, vfid;
+	u16 eth_id, vsi_id, vf_vsi_id;
+	int i;
+
+	vsi_id = nbl_res_func_id_to_vsi_id(res_mgt, func_id, NBL_VSI_SERV_PF_DATA_TYPE);
+	nbl_res_func_id_to_pfvfid(res_mgt, func_id, &pfid, &vfid);
+
+	if (sriov_info->bdf != 0) {
+		eth_id =  nbl_res_vsi_id_to_eth_id(res_mgt, vsi_id);
+
+		for (i = 0; i < NBL_VSI_MAX; i++)
+			hw_ops->cfg_ipro_dn_sport_tbl(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+						       vsi_id + i, eth_id, bmode, binit);
+
+		for (vfid = 0; vfid < sriov_info->num_vfs; vfid++) {
+			vf_vsi_id = nbl_res_pfvfid_to_vsi_id(res_mgt, pfid, vfid, NBL_VSI_DATA);
+			if (vf_vsi_id == 0xFFFF)
+				continue;
+
+			hw_ops->cfg_ipro_dn_sport_tbl(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+							vf_vsi_id, eth_id, bmode, binit);
+		}
+	}
+
+	return 0;
+}
+
+static int nbl_res_queue_set_bridge_mode(void *priv, u16 func_id, u16 bmode)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+
+	return nbl_res_queue_init_ipro_dn_sport_tbl(res_mgt, func_id, bmode, false);
+}
+
+static int nbl_res_queue_init_rss(struct nbl_resource_mgt *res_mgt,
+				  struct nbl_queue_mgt *queue_mgt,
+				  struct nbl_hw_ops *hw_ops)
+{
+	return nbl_res_queue_init_epro_rss_key(res_mgt, hw_ops);
+}
+
+static int nbl_res_queue_alloc_txrx_queues(void *priv, u16 vsi_id, u16 queue_num)
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
+	ret = nbl_res_queue_setup_qid_map_table_leonis(res_mgt, func_id, notify_addr);
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
+static int nbl_res_queue_setup_queue(void *priv, struct nbl_txrx_queue_param *param, bool is_tx)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_queue_cfg_param cfg_param = {0};
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
+	vsi_info->net_id = nbl_res_queue_get_net_id(func_id, vsi_info->vsi_index);
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
+	u16 group_id = nbl_res_vsi_id_to_eth_id(res_mgt, vsi_id); /* group_id is same with eth_id */
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
+		hw_ops->deactive_shaping(NBL_RES_MGT_TO_HW_PRIV(res_mgt), vsi_info->net_id);
+		for (i = start; i < end; i++)
+			hw_ops->cfg_q2tc_netid(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+						queue_info->txrx_queues[i], vsi_info->net_id, vld);
+		nbl_res_queue_update_netid_refnum(queue_mgt, vsi_info->net_id, false);
+	}
+
+	if (!nbl_res_queue_get_netid_refnum(queue_mgt, vsi_info->net_id)) {
+		ret = hw_ops->cfg_dsch_net_to_group(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+					     vsi_info->net_id, group_id, vld);
+		if (ret)
+			return ret;
+	}
+
+	if (vld) {
+		for (i = start; i < end; i++)
+			hw_ops->cfg_q2tc_netid(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+						queue_info->txrx_queues[i], vsi_info->net_id, vld);
+		hw_ops->active_shaping(NBL_RES_MGT_TO_HW_PRIV(res_mgt), vsi_info->net_id);
+		nbl_res_queue_update_netid_refnum(queue_mgt, vsi_info->net_id, true);
+	}
+
+	return 0;
+}
+
+static int nbl_res_queue_setup_cqs(void *priv, u16 vsi_id, u16 real_qps, bool rss_indir_set)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_queue_info *queue_info;
+	struct nbl_queue_vsi_info *vsi_info = NULL;
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
+	if (real_qps && rss_indir_set)
+		hw_ops->cfg_epro_rss_ret(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+					  vsi_info->rss_ret_base,
+					  vsi_info->rss_entry_size, real_qps,
+					  queue_info->txrx_queues + vsi_info->queue_offset, NULL);
+
+	if (!vsi_info->curr_qps)
+		hw_ops->set_epro_rss_pt(NBL_RES_MGT_TO_HW_PRIV(res_mgt), vsi_id,
+					 vsi_info->rss_ret_base, vsi_info->rss_entry_size);
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
+		nbl_res_queue_init_ipro_dn_sport_tbl(res_mgt, i, BRIDGE_MODE_VEB, true);
+	}
+	hw_ops->init_pfc(NBL_RES_MGT_TO_HW_PRIV(res_mgt), NBL_MAX_ETHERNET);
+
+	return 0;
+
+init_queue_fail:
+	return ret;
+}
+
+static u16 nbl_res_queue_get_local_queue_id(void *priv, u16 vsi_id, u16 global_queue_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_queue_info *queue_info;
+	u16 func_id = nbl_res_vsi_id_to_func_id(res_mgt, vsi_id);
+	int i;
+
+	queue_info = &queue_mgt->queue_info[func_id];
+
+	if (queue_info->txrx_queues)
+		for (i = 0; i < queue_info->num_txrx_queues; i++)
+			if (global_queue_id == queue_info->txrx_queues[i])
+				return i;
+
+	return U16_MAX;
+}
+
+static u16 nbl_res_queue_get_vsi_global_qid(void *priv, u16 vsi_id, u16 local_qid)
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
+static void nbl_res_queue_get_rxfh_indir_size(void *priv, u16 vsi_id, u32 *rxfh_indir_size)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_queue_vsi_info *vsi_info = NULL;
+
+	vsi_info = nbl_res_queue_get_vsi_info(res_mgt, vsi_id);
+	if (!vsi_info)
+		return;
+
+	*rxfh_indir_size = NBL_EPRO_RSS_ENTRY_SIZE_UNIT << vsi_info->rss_entry_size;
+}
+
+static int nbl_res_queue_set_rxfh_indir(void *priv, u16 vsi_id, const u32 *indir, u32 indir_size)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	struct nbl_queue_vsi_info *vsi_info = NULL;
+	struct nbl_queue_info *queue_info = NULL;
+	u32 *rss_ret;
+	u16 func_id = 0;
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
+		func_id = NBL_COMMON_TO_MGT_PF(common);
+		queue_info = &queue_mgt->queue_info[func_id];
+		/* local queue to global queue */
+		for (i = 0; i < indir_size; i++)
+			rss_ret[i] = nbl_res_queue_get_vsi_global_qid(res_mgt, vsi_id,
+								      vsi_info->queue_offset +
+								      indir[i]);
+		hw_ops->cfg_epro_rss_ret(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+					  vsi_info->rss_ret_base,
+					  vsi_info->rss_entry_size, 0,
+					  NULL, rss_ret);
+		kfree(rss_ret);
+	}
+
+	if (!vsi_info->curr_qps)
+		hw_ops->set_epro_rss_pt(NBL_RES_MGT_TO_HW_PRIV(res_mgt), vsi_id,
+					 vsi_info->rss_ret_base, vsi_info->rss_entry_size);
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
+static u16 nbl_get_adapt_desc_gother_level(u16 last_level, u64 rates)
+{
+	switch (last_level) {
+	case NBL_ADAPT_DESC_GOTHER_LEVEL0:
+		if (rates > NBL_ADAPT_DESC_GOTHER_LEVEL1_TH)
+			return NBL_ADAPT_DESC_GOTHER_LEVEL1;
+		else
+			return NBL_ADAPT_DESC_GOTHER_LEVEL0;
+	case NBL_ADAPT_DESC_GOTHER_LEVEL1:
+		if (rates > NBL_ADAPT_DESC_GOTHER_LEVEL1_DOWNGRADE_TH)
+			return NBL_ADAPT_DESC_GOTHER_LEVEL1;
+		else
+			return NBL_ADAPT_DESC_GOTHER_LEVEL0;
+	default:
+		return NBL_ADAPT_DESC_GOTHER_LEVEL0;
+	}
+}
+
+static u16 nbl_get_adapt_desc_gother_timeout(u16 level)
+{
+	switch (level) {
+	case NBL_ADAPT_DESC_GOTHER_LEVEL0:
+		return NBL_ADAPT_DESC_GOTHER_LEVEL0_TIMEOUT;
+	case NBL_ADAPT_DESC_GOTHER_LEVEL1:
+		return NBL_ADAPT_DESC_GOTHER_LEVEL1_TIMEOUT;
+	default:
+		return NBL_ADAPT_DESC_GOTHER_LEVEL0_TIMEOUT;
+	}
+}
+
+static void nbl_res_queue_adapt_desc_gother(void *priv)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_adapt_desc_gother *adapt_desc_gother = &queue_mgt->adapt_desc_gother;
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	u32 last_uvn_desc_rd_entry = adapt_desc_gother->uvn_desc_rd_entry;
+	u64 last_get_stats_jiffies = adapt_desc_gother->get_desc_stats_jiffies;
+	u64 time_diff;
+	u32 uvn_desc_rd_entry;
+	u32 rx_rate;
+	u16 level, last_level, timeout;
+
+	last_level = adapt_desc_gother->level;
+	time_diff = jiffies - last_get_stats_jiffies;
+	uvn_desc_rd_entry = hw_ops->get_uvn_desc_entry_stats(NBL_RES_MGT_TO_HW_PRIV(res_mgt));
+	rx_rate = (uvn_desc_rd_entry - last_uvn_desc_rd_entry) / time_diff * HZ;
+	adapt_desc_gother->get_desc_stats_jiffies = jiffies;
+	adapt_desc_gother->uvn_desc_rd_entry = uvn_desc_rd_entry;
+
+	level = nbl_get_adapt_desc_gother_level(last_level, rx_rate);
+	if (level != last_level) {
+		timeout = nbl_get_adapt_desc_gother_timeout(level);
+		hw_ops->set_uvn_desc_wr_timeout(NBL_RES_MGT_TO_HW_PRIV(res_mgt), timeout);
+		adapt_desc_gother->level = level;
+	}
+}
+
+static void nbl_res_queue_set_desc_high_throughput(void *priv)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_adapt_desc_gother *adapt_desc_gother = &queue_mgt->adapt_desc_gother;
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+
+	if (adapt_desc_gother->level != NBL_ADAPT_DESC_GOTHER_LEVEL1) {
+		hw_ops->set_uvn_desc_wr_timeout(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+						NBL_ADAPT_DESC_GOTHER_LEVEL1_TIMEOUT);
+		adapt_desc_gother->level = NBL_ADAPT_DESC_GOTHER_LEVEL1;
+	}
+}
+
+static void nbl_res_flr_clear_queues(void *priv, u16 vf_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	u16 func_id = vf_id + NBL_MAX_PF;
+	u16 vsi_id = nbl_res_func_id_to_vsi_id(res_mgt, func_id, NBL_VSI_SERV_VF_DATA_TYPE);
+
+	if (nbl_res_vf_is_active(priv, func_id))
+		nbl_res_queue_clear_queues(priv, vsi_id);
+}
+
+static int
+nbl_res_queue_stop_abnormal_hw_queue(void *priv, u16 vsi_id, u16 local_queue_id, int type)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	struct nbl_queue_info *queue_info;
+	u16 global_queue, func_id = nbl_res_vsi_id_to_func_id(res_mgt, vsi_id);
+
+	queue_info = &queue_mgt->queue_info[func_id];
+	global_queue = queue_info->txrx_queues[local_queue_id];
+	switch (type) {
+	case NBL_TX:
+		hw_ops->lso_dsch_drain(NBL_RES_MGT_TO_HW_PRIV(res_mgt), global_queue);
+		hw_ops->disable_dvn(NBL_RES_MGT_TO_HW_PRIV(res_mgt), global_queue);
+
+		hw_ops->reset_dvn_cfg(NBL_RES_MGT_TO_HW_PRIV(res_mgt), global_queue);
+		return 0;
+	case NBL_RX:
+		hw_ops->disable_uvn(NBL_RES_MGT_TO_HW_PRIV(res_mgt), global_queue);
+		hw_ops->rsc_cache_drain(NBL_RES_MGT_TO_HW_PRIV(res_mgt), global_queue);
+
+		hw_ops->reset_uvn_cfg(NBL_RES_MGT_TO_HW_PRIV(res_mgt), global_queue);
+		nbl_res_queue_reset_uvn_pkt_drop_stats(res_mgt, func_id, global_queue);
+		return 0;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int nbl_res_queue_set_tx_rate(void *priv, u16 func_id, int tx_rate, int burst)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_resource_info *res_info = NBL_RES_MGT_TO_RES_INFO(res_mgt);
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_queue_info *queue_info = &queue_mgt->queue_info[func_id];
+	struct nbl_queue_vsi_info *vsi_info = NULL;
+	u16 vsi_id, queue_id;
+	bool is_active = false;
+	int max_rate = 0, i;
+
+	vsi_id = nbl_res_func_id_to_vsi_id(res_mgt, func_id, NBL_VSI_SERV_VF_DATA_TYPE);
+	vsi_info = nbl_res_queue_get_vsi_info(res_mgt, vsi_id);
+
+	if (!vsi_info)
+		return 0;
+
+	switch (res_info->board_info.eth_speed) {
+	case NBL_FW_PORT_SPEED_100G:
+		max_rate = NBL_RATE_MBPS_100G;
+		break;
+	case NBL_FW_PORT_SPEED_25G:
+		max_rate = NBL_RATE_MBPS_25G;
+		break;
+	case NBL_FW_PORT_SPEED_10G:
+		max_rate = NBL_RATE_MBPS_10G;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	if (tx_rate > max_rate)
+		return -EINVAL;
+
+	if (queue_info->txrx_queues)
+		for (i = 0; i < vsi_info->curr_qps; i++) {
+			queue_id = queue_info->txrx_queues[i + vsi_info->queue_offset];
+			is_active |= hw_ops->check_q2tc(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+							 queue_id);
+		}
+
+	/* Config shaping */
+	return hw_ops->set_shaping(NBL_RES_MGT_TO_HW_PRIV(res_mgt), vsi_info->net_id, tx_rate,
+				    burst, !!(tx_rate), is_active);
+}
+
+static int nbl_res_queue_set_rx_rate(void *priv, u16 func_id, int rx_rate, int burst)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_resource_info *res_info = NBL_RES_MGT_TO_RES_INFO(res_mgt);
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	struct nbl_queue_vsi_info *vsi_info = NULL;
+	u16 vsi_id;
+	int max_rate = 0;
+
+	vsi_id = nbl_res_func_id_to_vsi_id(res_mgt, func_id, NBL_VSI_DATA);
+	vsi_info = nbl_res_queue_get_vsi_info(res_mgt, vsi_id);
+
+	if (!vsi_info)
+		return 0;
+
+	switch (res_info->board_info.eth_speed) {
+	case NBL_FW_PORT_SPEED_100G:
+		max_rate = NBL_RATE_MBPS_100G;
+		break;
+	case NBL_FW_PORT_SPEED_25G:
+		max_rate = NBL_RATE_MBPS_25G;
+		break;
+	case NBL_FW_PORT_SPEED_10G:
+		max_rate = NBL_RATE_MBPS_10G;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	if (rx_rate > max_rate)
+		return -EINVAL;
+
+	/* Config ucar */
+	return hw_ops->set_ucar(NBL_RES_MGT_TO_HW_PRIV(res_mgt), vsi_id, rx_rate,
+				 burst, !!(rx_rate));
+}
+
+static void nbl_res_queue_get_active_func_bitmaps(void *priv, unsigned long *bitmap, int max_func)
+{
+	int i;
+	int func_id_end;
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+
+	func_id_end = max_func > NBL_MAX_FUNC ? NBL_MAX_FUNC : max_func;
+	for (i = 0; i < func_id_end; i++) {
+		if (!nbl_res_check_func_active_by_queue(res_mgt, i))
+			continue;
+
+		set_bit(i, bitmap);
+	}
+}
+
+static int nbl_res_queue_reset_uvn_pkt_drop_stats(void *priv, u16 func_id, u16 global_queue_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_queue_info *queue_info = &queue_mgt->queue_info[func_id];
+	u16 vsi_id = nbl_res_func_id_to_vsi_id(res_mgt, func_id, NBL_VSI_SERV_PF_DATA_TYPE);
+	u16 local_queue_id;
+
+	local_queue_id = nbl_res_queue_get_local_queue_id(res_mgt, vsi_id, global_queue_id);
+	queue_info->uvn_stat_pkt_drop[local_queue_id] = 0;
+	return 0;
+}
+
+static int nbl_res_queue_get_uvn_pkt_drop_stats(void *priv, u16 vsi_id,
+						u16 num_queues, u32 *uvn_stat_pkt_drop)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_queue_info *queue_info = NULL;
+	struct nbl_queue_vsi_info *vsi_info = NULL;
+	u16 func_id = 0;
+	u32 pkt_drop_num = 0;
+	int i = 0;
+
+	func_id = nbl_res_vsi_id_to_func_id(res_mgt, vsi_id);
+	queue_info = &queue_mgt->queue_info[func_id];
+	vsi_info = nbl_res_queue_get_vsi_info(res_mgt, vsi_id);
+	if (!vsi_info)
+		return -ENOENT;
+
+	for (i = vsi_info->queue_offset;
+	     i < vsi_info->queue_offset + num_queues &&
+	     i < queue_info->num_txrx_queues; i++) {
+		hw_ops->get_uvn_pkt_drop_stats(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+						queue_info->txrx_queues[i], &pkt_drop_num);
+		*uvn_stat_pkt_drop = pkt_drop_num - queue_info->uvn_stat_pkt_drop[i];
+		uvn_stat_pkt_drop++;
+		queue_info->uvn_stat_pkt_drop[i] = pkt_drop_num;
+	}
+
+	return 0;
+}
+
+/* NBL_QUEUE_SET_OPS(ops_name, func)
+ *
+ * Use X Macros to reduce setup and remove codes.
+ */
+#define NBL_QUEUE_OPS_TBL									\
+do {												\
+	NBL_QUEUE_SET_OPS(alloc_txrx_queues, nbl_res_queue_alloc_txrx_queues);			\
+	NBL_QUEUE_SET_OPS(free_txrx_queues, nbl_res_queue_free_txrx_queues);			\
+	NBL_QUEUE_SET_OPS(register_vsi2q, nbl_res_queue_register_vsi2q);			\
+	NBL_QUEUE_SET_OPS(setup_q2vsi, nbl_res_queue_setup_q2vsi);				\
+	NBL_QUEUE_SET_OPS(remove_q2vsi, nbl_res_queue_remove_q2vsi);				\
+	NBL_QUEUE_SET_OPS(setup_rss, nbl_res_queue_setup_rss);					\
+	NBL_QUEUE_SET_OPS(remove_rss, nbl_res_queue_remove_rss);				\
+	NBL_QUEUE_SET_OPS(setup_queue, nbl_res_queue_setup_queue);				\
+	NBL_QUEUE_SET_OPS(remove_all_queues, nbl_res_queue_remove_all_queues);			\
+	NBL_QUEUE_SET_OPS(cfg_dsch, nbl_res_queue_cfg_dsch);					\
+	NBL_QUEUE_SET_OPS(setup_cqs, nbl_res_queue_setup_cqs);					\
+	NBL_QUEUE_SET_OPS(remove_cqs, nbl_res_queue_remove_cqs);				\
+	NBL_QUEUE_SET_OPS(queue_init, nbl_res_queue_init);					\
+	NBL_QUEUE_SET_OPS(get_rxfh_indir_size, nbl_res_queue_get_rxfh_indir_size);		\
+	NBL_QUEUE_SET_OPS(set_rxfh_indir, nbl_res_queue_set_rxfh_indir);			\
+	NBL_QUEUE_SET_OPS(clear_queues, nbl_res_queue_clear_queues);				\
+	NBL_QUEUE_SET_OPS(get_vsi_global_queue_id, nbl_res_queue_get_vsi_global_qid);		\
+	NBL_QUEUE_SET_OPS(adapt_desc_gother, nbl_res_queue_adapt_desc_gother);			\
+	NBL_QUEUE_SET_OPS(set_desc_high_throughput, nbl_res_queue_set_desc_high_throughput);	\
+	NBL_QUEUE_SET_OPS(flr_clear_queues, nbl_res_flr_clear_queues);				\
+	NBL_QUEUE_SET_OPS(get_local_queue_id, nbl_res_queue_get_local_queue_id);		\
+	NBL_QUEUE_SET_OPS(set_bridge_mode, nbl_res_queue_set_bridge_mode);			\
+	NBL_QUEUE_SET_OPS(set_tx_rate, nbl_res_queue_set_tx_rate);				\
+	NBL_QUEUE_SET_OPS(set_rx_rate, nbl_res_queue_set_rx_rate);				\
+	NBL_QUEUE_SET_OPS(stop_abnormal_hw_queue, nbl_res_queue_stop_abnormal_hw_queue);	\
+	NBL_QUEUE_SET_OPS(get_active_func_bitmaps, nbl_res_queue_get_active_func_bitmaps);	\
+	NBL_QUEUE_SET_OPS(get_uvn_pkt_drop_stats, nbl_res_queue_get_uvn_pkt_drop_stats);	\
+} while (0)
+
+int nbl_queue_setup_ops_leonis(struct nbl_resource_ops *res_ops)
+{
+#define NBL_QUEUE_SET_OPS(name, func) do {res_ops->NBL_NAME(name) = func; ; } while (0)
+	NBL_QUEUE_OPS_TBL;
+#undef  NBL_QUEUE_SET_OPS
+
+	return 0;
+}
+
+void nbl_queue_remove_ops_leonis(struct nbl_resource_ops *res_ops)
+{
+#define NBL_QUEUE_SET_OPS(name, func)								\
+do {												\
+	(void)(func);										\
+	res_ops->NBL_NAME(name) = NULL; ;							\
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
index 000000000000..60ae1c5bc88f
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_queue_leonis.h
@@ -0,0 +1,25 @@
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
+#define NBL_ADAPT_DESC_GOTHER_LEVEL1_TH	(1000000) /* 1000k  */
+#define NBL_ADAPT_DESC_GOTHER_LEVEL1_DOWNGRADE_TH	(700000) /* 700k */
+#define NBL_ADAPT_DESC_GOTHER_LEVEL0		(0)
+#define NBL_ADAPT_DESC_GOTHER_LEVEL1		(1)
+
+#define NBL_ADAPT_DESC_GOTHER_LEVEL0_TIMEOUT	(0x12c)
+#define NBL_ADAPT_DESC_GOTHER_LEVEL1_TIMEOUT	(0x960)
+
+#define NBL_SHAPING_WGT_MAX			(255)
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
index a7cc2aa1429a..0e31060803bf 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
@@ -504,6 +504,7 @@ static struct nbl_resource_ops res_ops = {
 	.get_ustore_total_pkt_drop_stats = nbl_res_get_ustore_total_pkt_drop_stats,
 
 	.process_abnormal_event = nbl_res_process_abnormal_event,
+
 	.get_board_id = nbl_res_get_board_id,
 
 	.set_hw_status = nbl_res_set_hw_status,
@@ -512,6 +513,10 @@ static struct nbl_resource_ops res_ops = {
 };
 
 static struct nbl_res_product_ops product_ops = {
+	.queue_mgt_init			= nbl_queue_mgt_init_leonis,
+	.setup_qid_map_table		= nbl_res_queue_setup_qid_map_table_leonis,
+	.remove_qid_map_table		= nbl_res_queue_remove_qid_map_table_leonis,
+	.init_qid_map_table		= nbl_res_queue_init_qid_map_table,
 };
 
 static bool is_ops_inited;
@@ -562,7 +567,18 @@ static int nbl_res_setup_ops(struct device *dev, struct nbl_resource_ops_tbl **r
 		return -ENOMEM;
 
 	if (!is_ops_inited) {
+		ret = nbl_queue_setup_ops_leonis(&res_ops);
+		if (ret)
+			goto setup_fail;
 		ret = nbl_intr_setup_ops(&res_ops);
+		if (ret)
+			goto setup_fail;
+
+		ret = nbl_vsi_setup_ops(&res_ops);
+		if (ret)
+			goto setup_fail;
+
+		ret = nbl_adminq_setup_ops(&res_ops);
 		if (ret)
 			goto setup_fail;
 		is_ops_inited = true;
@@ -866,7 +882,10 @@ static void nbl_res_stop(struct nbl_resource_mgt_leonis *res_mgt_leonis)
 {
 	struct nbl_resource_mgt *res_mgt = &res_mgt_leonis->res_mgt;
 
+	nbl_queue_mgt_stop(res_mgt);
 	nbl_intr_mgt_stop(res_mgt);
+	nbl_adminq_mgt_stop(res_mgt);
+	nbl_vsi_mgt_stop(res_mgt);
 	nbl_res_ctrl_dev_ustore_stats_remove(res_mgt);
 	nbl_res_ctrl_dev_remove_vsi_info(res_mgt);
 	nbl_res_ctrl_dev_remove_eth_info(res_mgt);
@@ -919,6 +938,18 @@ static int nbl_res_start(struct nbl_resource_mgt_leonis *res_mgt_leonis,
 		if (ret)
 			goto start_fail;
 
+		ret = nbl_queue_mgt_start(res_mgt);
+		if (ret)
+			goto start_fail;
+
+		ret = nbl_vsi_mgt_start(res_mgt);
+		if (ret)
+			goto start_fail;
+
+		ret = nbl_adminq_mgt_start(res_mgt);
+		if (ret)
+			goto start_fail;
+
 		ret = nbl_intr_mgt_start(res_mgt);
 		if (ret)
 			goto start_fail;
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
index a0a25a2b71ee..689ef84b2ce0 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
@@ -10,4 +10,14 @@
 #include "nbl_resource.h"
 
 #define NBL_MAX_PF_LEONIS			8
+
+int nbl_queue_setup_ops_leonis(struct nbl_resource_ops *resource_ops);
+void nbl_queue_remove_ops_leonis(struct nbl_resource_ops *resource_ops);
+
+void nbl_queue_mgt_init_leonis(struct nbl_queue_mgt *queue_mgt);
+int nbl_res_queue_setup_qid_map_table_leonis(struct nbl_resource_mgt *res_mgt, u16 func_id,
+					     u64 notify_addr);
+void nbl_res_queue_remove_qid_map_table_leonis(struct nbl_resource_mgt *res_mgt, u16 func_id);
+int nbl_res_queue_init_qid_map_table(struct nbl_resource_mgt *res_mgt,
+				     struct nbl_queue_mgt *queue_mgt, struct nbl_hw_ops *hw_ops);
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_p4_actions.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_p4_actions.h
new file mode 100644
index 000000000000..43701985d267
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_p4_actions.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_P4_ACTION_H
+#define _NBL_P4_ACTION_H
+
+// Code generated by P4 compiler. DO NOT EDIT.
+#define NBL_ACT_SET_FLAGS 1
+#define NBL_ACT_CLEAR_FLAGS 1
+#define NBL_ACT_SET_AUX_FIELD 1
+#define NBL_ACT_SET_FLOW_STAT0 2
+#define NBL_ACT_SET_FLOW_STAT1 3
+#define NBL_ACT_SET_RSS 4
+#define NBL_ACT_SET_CAR 5
+#define NBL_ACT_SET_FLOW_CAR 6
+#define NBL_ACT_SET_TAB_INDEX 7
+#define NBL_ACT_SET_MIRROR 8
+#define NBL_ACT_SET_DPORT 9
+#define NBL_ACT_SET_QUE_IDX 10
+#define NBL_ACT_SET_MCC 13
+#define NBL_ACT_SET_VNI0 14
+#define NBL_ACT_SET_VNI1 15
+#define NBL_ACT_SET_SPECIAL_FLOW_STAT 16
+#define NBL_ACT_SET_PRBAC 17
+#define NBL_ACT_SET_DP_HASH0 19
+#define NBL_ACT_SET_DP_HASH1 20
+#define NBL_ACT_SET_PRI_MDF0 21
+#define NBL_ACT_SET_PRI_MDF1 21
+#define NBL_ACT_NEXT_AT_HALF0 60
+#define NBL_ACT_NEXT_AT_HALF1 61
+#define NBL_ACT_NEXT_AT_FULL0 62
+#define NBL_ACT_NEXT_AT_FULL1 63
+#define NBL_ACT_REP_IPV4_SIP 32
+#define NBL_ACT_REP_IPV4_DIP 33
+#define NBL_ACT_REP_IPV6_SIP 34
+#define NBL_ACT_REP_IPV6_DIP 35
+#define NBL_ACT_REP_DPORT 36
+#define NBL_ACT_REP_SPORT 37
+#define NBL_ACT_REP_DMAC 38
+#define NBL_ACT_REP_SMAC 39
+#define NBL_ACT_REP_IPV4_DSCP 40
+#define NBL_ACT_REP_IPV6_DSCP 41
+#define NBL_ACT_REP_IPV4_TTL 42
+#define NBL_ACT_REP_IPV6_TTL 43
+#define NBL_ACT_DEL_CVLAN 44
+#define NBL_ACT_DEL_SVLAN 45
+#define NBL_ACT_REP_SVLAN 46
+#define NBL_ACT_REP_CVLAN 47
+#define NBL_ACT_REP_SINGLE_CVLAN 48
+#define NBL_ACT_ADD_SVLAN 49
+#define NBL_ACT_ADD_CVLAN 50
+#define NBL_ACT_TNL_ENCAP 51
+#define NBL_ACT_TNL_DECAP 52
+#define NBL_ACT_REP_OUTER_SPORT 53
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_queue.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_queue.c
new file mode 100644
index 000000000000..1dc0d1060516
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_queue.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#include "nbl_queue.h"
+
+/* Structure starts here, adding an op should not modify anything below */
+static int nbl_queue_setup_mgt(struct device *dev, struct nbl_queue_mgt **queue_mgt)
+{
+	*queue_mgt = devm_kzalloc(dev, sizeof(struct nbl_queue_mgt), GFP_KERNEL);
+	if (!*queue_mgt)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void nbl_queue_remove_mgt(struct device *dev, struct nbl_queue_mgt **queue_mgt)
+{
+	devm_kfree(dev, *queue_mgt);
+	*queue_mgt = NULL;
+}
+
+int nbl_queue_mgt_start(struct nbl_resource_mgt *res_mgt)
+{
+	struct device *dev;
+	struct nbl_queue_mgt **queue_mgt;
+	struct nbl_res_product_ops *product_ops = NBL_RES_MGT_TO_PROD_OPS(res_mgt);
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
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
index d07f2d624315..97f5265e095b 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
@@ -258,6 +258,14 @@ static u8 eth_id_to_pf_id(void *p, u8 eth_id)
 	return pf_id_offset + NBL_COMMON_TO_MGT_PF(common);
 }
 
+static bool check_func_active_by_queue(void *p, u16 func_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)p;
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+
+	return queue_mgt->queue_info[func_id].txrx_queues ? true : false;
+}
+
 int nbl_res_func_id_to_pfvfid(struct nbl_resource_mgt *res_mgt, u16 func_id, int *pfid, int *vfid)
 {
 	if (!res_mgt->common_ops.func_id_to_pfvfid)
@@ -339,6 +347,14 @@ u8 nbl_res_eth_id_to_pf_id(struct nbl_resource_mgt *res_mgt, u8 eth_id)
 	return res_mgt->common_ops.eth_id_to_pf_id(res_mgt, eth_id);
 }
 
+bool nbl_res_check_func_active_by_queue(struct nbl_resource_mgt *res_mgt, u16 func_id)
+{
+	if (!res_mgt->common_ops.check_func_active_by_queue)
+		return check_func_active_by_queue(res_mgt, func_id);
+
+	return res_mgt->common_ops.check_func_active_by_queue(res_mgt, func_id);
+}
+
 bool nbl_res_get_fix_capability(void *priv, enum nbl_fix_cap_type cap_type)
 {
 	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
index 03314f9bf4f3..21f9444822d8 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
@@ -761,6 +761,7 @@ struct nbl_resource_common_ops {
 	u8 (*vsi_id_to_eth_id)(void *res_mgt, u16 vsi_id);
 	u8 (*eth_id_to_pf_id)(void *res_mgt, u8 eth_id);
 	u8 (*eth_id_to_lag_id)(void *res_mgt, u8 eth_id);
+	bool (*check_func_active_by_queue)(void *res_mgt, u16 func_id);
 	int (*get_queue_num)(void *res_mgt, u16 func_id, u16 *tx_queue_num, u16 *rx_queue_num);
 };
 
@@ -818,6 +819,7 @@ int nbl_res_func_id_to_bdf(struct nbl_resource_mgt *res_mgt, u16 func_id, u8 *bu
 			   u8 *dev, u8 *function);
 u64 nbl_res_get_func_bar_base_addr(struct nbl_resource_mgt *res_mgt, u16 func_id);
 u8 nbl_res_vsi_id_to_eth_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id);
+bool nbl_res_check_func_active_by_queue(struct nbl_resource_mgt *res_mgt, u16 func_id);
 
 int nbl_adminq_mgt_start(struct nbl_resource_mgt *res_mgt);
 void nbl_adminq_mgt_stop(struct nbl_resource_mgt *res_mgt);
@@ -826,6 +828,14 @@ int nbl_adminq_setup_ops(struct nbl_resource_ops *resource_ops);
 int nbl_intr_mgt_start(struct nbl_resource_mgt *res_mgt);
 void nbl_intr_mgt_stop(struct nbl_resource_mgt *res_mgt);
 int nbl_intr_setup_ops(struct nbl_resource_ops *resource_ops);
+
+int nbl_queue_mgt_start(struct nbl_resource_mgt *res_mgt);
+void nbl_queue_mgt_stop(struct nbl_resource_mgt *res_mgt);
+
+int nbl_vsi_mgt_start(struct nbl_resource_mgt *res_mgt);
+void nbl_vsi_mgt_stop(struct nbl_resource_mgt *res_mgt);
+int nbl_vsi_setup_ops(struct nbl_resource_ops *resource_ops);
+
 bool nbl_res_get_fix_capability(void *priv, enum nbl_fix_cap_type cap_type);
 void nbl_res_set_fix_capability(struct nbl_resource_mgt *res_mgt, enum nbl_fix_cap_type cap_type);
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.c
new file mode 100644
index 000000000000..a5a2107f8595
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.c
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#include "nbl_vsi.h"
+
+static int nbl_res_set_promisc_mode(void *priv, u16 vsi_id, u16 mode)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	u16 pf_id = nbl_res_vsi_id_to_pf_id(res_mgt, vsi_id);
+	u16 eth_id = nbl_res_vsi_id_to_eth_id(res_mgt, vsi_id);
+
+	if (pf_id >= NBL_RES_MGT_TO_PF_NUM(res_mgt))
+		return -EINVAL;
+
+	hw_ops->set_promisc_mode(NBL_RES_MGT_TO_HW_PRIV(res_mgt), vsi_id, eth_id, mode);
+
+	return 0;
+}
+
+static int nbl_res_set_spoof_check_addr(void *priv, u16 vsi_id, u8 *mac)
+{
+	u16 func_id;
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_vsi_info *vsi_info = NBL_RES_MGT_TO_VSI_INFO(res_mgt);
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+
+	func_id = nbl_res_vsi_id_to_func_id(res_mgt, vsi_id);
+	/* if pf has cfg vf-mac, and the vf has active. it can change spoof mac. */
+	if (!is_zero_ether_addr(vsi_info->mac_info[func_id].mac) &&
+	    nbl_res_check_func_active_by_queue(res_mgt, func_id)) {
+		return 0;
+	}
+
+	return hw_ops->set_spoof_check_addr(NBL_RES_MGT_TO_HW_PRIV(res_mgt), vsi_id, mac);
+}
+
+static int nbl_res_set_vf_spoof_check(void *priv, u16 vsi_id, int vfid, u8 enable)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	u16 func_id = nbl_res_vsi_id_to_func_id(res_mgt, vsi_id);
+	u16 pfid = 0;
+	u16 vf_vsi_id = 0;
+
+	/* when ip link set eth0 vf <num> spoofchk */
+	if (func_id < NBL_MAX_PF) {
+		pfid = nbl_res_vsi_id_to_pf_id(res_mgt, vsi_id);
+		vf_vsi_id = nbl_res_pfvfid_to_vsi_id(res_mgt, pfid, vfid, NBL_VSI_DATA);
+	} else {
+		vf_vsi_id = vsi_id;
+	}
+
+	return hw_ops->set_spoof_check_enable(NBL_RES_MGT_TO_HW_PRIV(res_mgt), vf_vsi_id, enable);
+}
+
+static u16 nbl_res_get_vf_function_id(void *priv, u16 vsi_id, int vfid)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	u16 vf_vsi;
+	int pfid = nbl_res_vsi_id_to_pf_id(res_mgt, vsi_id);
+
+	vf_vsi = vfid == -1 ? vsi_id : nbl_res_pfvfid_to_vsi_id(res_mgt, pfid, vfid, NBL_VSI_DATA);
+
+	return nbl_res_vsi_id_to_func_id(res_mgt, vf_vsi);
+}
+
+static u16 nbl_res_get_vf_vsi_id(void *priv, u16 vsi_id, int vfid)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	u16 vf_vsi;
+	int pfid = nbl_res_vsi_id_to_pf_id(res_mgt, vsi_id);
+
+	vf_vsi = vfid == -1 ? vsi_id : nbl_res_pfvfid_to_vsi_id(res_mgt, pfid, vfid, NBL_VSI_DATA);
+	return vf_vsi;
+}
+
+static void nbl_res_vsi_deinit_chip_module(void *priv)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_hw_ops *hw_ops;
+
+	hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+
+	hw_ops->deinit_chip_module(NBL_RES_MGT_TO_HW_PRIV(res_mgt));
+}
+
+static int nbl_res_vsi_init_chip_module(void *priv)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_queue_mgt *queue_mgt;
+	struct nbl_hw_ops *hw_ops;
+	int ret = 0;
+
+	if (!res_mgt)
+		return -EINVAL;
+
+	queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+
+	ret = hw_ops->init_chip_module(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+					res_mgt->resource_info->board_info.eth_speed,
+					res_mgt->resource_info->board_info.eth_num);
+
+	return ret;
+}
+
+static int nbl_res_vsi_init(void *priv)
+{
+	return 0;
+}
+
+static void nbl_res_register_func_mac(void *priv, u8 *mac, u16 func_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_vsi_info *vsi_info = NBL_RES_MGT_TO_VSI_INFO(res_mgt);
+
+	if (func_id >= NBL_MAX_FUNC)
+		return;
+
+	ether_addr_copy(vsi_info->mac_info[func_id].mac, mac);
+}
+
+static int nbl_res_register_func_link_forced(void *priv, u16 func_id, u8 link_forced,
+					     bool *should_notify)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_resource_info *resource_info = NBL_RES_MGT_TO_RES_INFO(res_mgt);
+
+	if (func_id >= NBL_MAX_FUNC)
+		return -EINVAL;
+
+	resource_info->link_forced_info[func_id] = link_forced;
+	*should_notify = test_bit(func_id, resource_info->func_bitmap);
+
+	return 0;
+}
+
+static int nbl_res_get_link_forced(void *priv, u16 vsi_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_resource_info *resource_info = NBL_RES_MGT_TO_RES_INFO(res_mgt);
+	u16 func_id = nbl_res_vsi_id_to_func_id(res_mgt, vsi_id);
+
+	if (func_id >= NBL_MAX_FUNC)
+		return -EINVAL;
+
+	return resource_info->link_forced_info[func_id];
+}
+
+static int nbl_res_register_func_trust(void *priv, u16 func_id,
+				       bool trusted, bool *should_notify)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_resource_info *resource_info = NBL_RES_MGT_TO_RES_INFO(res_mgt);
+	struct nbl_vsi_info *vsi_info = NBL_RES_MGT_TO_VSI_INFO(res_mgt);
+
+	if (func_id >= NBL_MAX_FUNC)
+		return -EINVAL;
+
+	vsi_info->mac_info[func_id].trusted = trusted;
+	*should_notify = test_bit(func_id, resource_info->func_bitmap);
+
+	return 0;
+}
+
+static int nbl_res_register_func_vlan(void *priv, u16 func_id,
+				      u16 vlan_tci, u16 vlan_proto, bool *should_notify)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_resource_info *resource_info = NBL_RES_MGT_TO_RES_INFO(res_mgt);
+	struct nbl_vsi_info *vsi_info = NBL_RES_MGT_TO_VSI_INFO(res_mgt);
+
+	if (func_id >= NBL_MAX_FUNC)
+		return -EINVAL;
+
+	vsi_info->mac_info[func_id].vlan_proto = vlan_proto;
+	vsi_info->mac_info[func_id].vlan_tci = vlan_tci;
+	*should_notify = test_bit(func_id, resource_info->func_bitmap);
+
+	return 0;
+}
+
+static int nbl_res_register_rate(void *priv, u16 func_id, int rate)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_vsi_info *vsi_info = NBL_RES_MGT_TO_VSI_INFO(res_mgt);
+
+	if (func_id >= NBL_MAX_FUNC)
+		return -EINVAL;
+
+	vsi_info->mac_info[func_id].rate = rate;
+
+	return 0;
+}
+
+/* NBL_vsi_SET_OPS(ops_name, func)
+ *
+ * Use X Macros to reduce setup and remove codes.
+ */
+#define NBL_VSI_OPS_TBL								\
+do {										\
+	NBL_VSI_SET_OPS(init_chip_module, nbl_res_vsi_init_chip_module);	\
+	NBL_VSI_SET_OPS(deinit_chip_module, nbl_res_vsi_deinit_chip_module);	\
+	NBL_VSI_SET_OPS(vsi_init, nbl_res_vsi_init);				\
+	NBL_VSI_SET_OPS(set_promisc_mode, nbl_res_set_promisc_mode);		\
+	NBL_VSI_SET_OPS(set_spoof_check_addr, nbl_res_set_spoof_check_addr);	\
+	NBL_VSI_SET_OPS(set_vf_spoof_check, nbl_res_set_vf_spoof_check);	\
+	NBL_VSI_SET_OPS(get_vf_function_id, nbl_res_get_vf_function_id);	\
+	NBL_VSI_SET_OPS(get_vf_vsi_id, nbl_res_get_vf_vsi_id);			\
+	NBL_VSI_SET_OPS(register_func_mac, nbl_res_register_func_mac);		\
+	NBL_VSI_SET_OPS(register_func_link_forced, nbl_res_register_func_link_forced);	\
+	NBL_VSI_SET_OPS(register_func_vlan, nbl_res_register_func_vlan);	\
+	NBL_VSI_SET_OPS(get_link_forced, nbl_res_get_link_forced);		\
+	NBL_VSI_SET_OPS(register_func_rate, nbl_res_register_rate);		\
+	NBL_VSI_SET_OPS(register_func_trust, nbl_res_register_func_trust);	\
+} while (0)
+
+/* Structure starts here, adding an op should not modify anything below */
+static int nbl_vsi_setup_mgt(struct device *dev, struct nbl_vsi_mgt **vsi_mgt)
+{
+	*vsi_mgt = devm_kzalloc(dev, sizeof(struct nbl_vsi_mgt), GFP_KERNEL);
+	if (!*vsi_mgt)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void nbl_vsi_remove_mgt(struct device *dev, struct nbl_vsi_mgt **vsi_mgt)
+{
+	devm_kfree(dev, *vsi_mgt);
+	*vsi_mgt = NULL;
+}
+
+int nbl_vsi_mgt_start(struct nbl_resource_mgt *res_mgt)
+{
+	struct device *dev;
+	struct nbl_vsi_mgt **vsi_mgt;
+
+	dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	vsi_mgt = &NBL_RES_MGT_TO_VSI_MGT(res_mgt);
+
+	return nbl_vsi_setup_mgt(dev, vsi_mgt);
+}
+
+void nbl_vsi_mgt_stop(struct nbl_resource_mgt *res_mgt)
+{
+	struct device *dev;
+	struct nbl_vsi_mgt **vsi_mgt;
+
+	dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	vsi_mgt = &NBL_RES_MGT_TO_VSI_MGT(res_mgt);
+
+	if (!(*vsi_mgt))
+		return;
+
+	nbl_vsi_remove_mgt(dev, vsi_mgt);
+}
+
+int nbl_vsi_setup_ops(struct nbl_resource_ops *res_ops)
+{
+#define NBL_VSI_SET_OPS(name, func) do {res_ops->NBL_NAME(name) = func; ; } while (0)
+	NBL_VSI_OPS_TBL;
+#undef  NBL_VSI_SET_OPS
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.h
new file mode 100644
index 000000000000..94831e00b89a
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_VSI_H_
+#define _NBL_VSI_H_
+
+#include "nbl_resource.h"
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
index 4a9661d79de8..b30d54f0755f 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
@@ -13,6 +13,49 @@
 #define NBL_HW_OPS_TBL_TO_PRIV(hw_ops_tbl)		((hw_ops_tbl)->priv)
 
 struct nbl_hw_ops {
+	int (*init_chip_module)(void *priv, u8 eth_speed, u8 eth_num);
+	void (*deinit_chip_module)(void *priv);
+	int (*init_qid_map_table)(void *priv);
+	int (*set_qid_map_table)(void *priv, void *data, int qid_map_select);
+	int (*set_qid_map_ready)(void *priv, bool ready);
+	int (*cfg_ipro_queue_tbl)(void *priv, u16 queue_id, u16 vsi_id, u8 enable);
+	int (*cfg_ipro_dn_sport_tbl)(void *priv, u16 vsi_id, u16 dst_eth_id, u16 bmode, bool binit);
+	int (*set_vnet_queue_info)(void *priv, struct nbl_vnet_queue_info_param *param,
+				   u16 queue_id);
+	int (*clear_vnet_queue_info)(void *priv, u16 queue_id);
+	int (*reset_dvn_cfg)(void *priv, u16 queue_id);
+	int (*reset_uvn_cfg)(void *priv, u16 queue_id);
+	int (*restore_dvn_context)(void *priv, u16 queue_id, u16 split, u16 last_avail_index);
+	int (*restore_uvn_context)(void *priv, u16 queue_id, u16 split, u16 last_avail_index);
+	int (*get_tx_queue_cfg)(void *priv, void *data, u16 queue_id);
+	int (*get_rx_queue_cfg)(void *priv, void *data, u16 queue_id);
+	int (*cfg_tx_queue)(void *priv, void *data, u16 queue_id);
+	int (*cfg_rx_queue)(void *priv, void *data, u16 queue_id);
+	bool (*check_q2tc)(void *priv, u16 queue_id);
+	int (*cfg_q2tc_netid)(void *priv, u16 queue_id, u16 netid, u16 vld);
+	int (*set_shaping)(void *priv, u16 func_id, u64 total_tx_rate, u64 burst,
+			   u8 vld, bool active);
+	void (*active_shaping)(void *priv, u16 func_id);
+	void (*deactive_shaping)(void *priv, u16 func_id);
+	int (*set_ucar)(void *priv, u16 func_id, u64 total_tx_rate, u64 burst,
+			u8 vld);
+	int (*cfg_dsch_net_to_group)(void *priv, u16 func_id, u16 group_id, u16 vld);
+	int (*init_epro_rss_key)(void *priv);
+
+	int (*init_epro_vpt_tbl)(void *priv, u16 vsi_id);
+	int (*cfg_epro_rss_ret)(void *priv, u32 index, u8 size_type, u32 q_num,
+				u16 *queue_list, const u32 *indir);
+	int (*set_epro_rss_pt)(void *priv, u16 vsi_id, u16 rss_ret_base, u16 rss_entry_size);
+	int (*clear_epro_rss_pt)(void *priv, u16 vsi_id);
+	int (*disable_dvn)(void *priv, u16 queue_id);
+	int (*disable_uvn)(void *priv, u16 queue_id);
+	int (*lso_dsch_drain)(void *priv, u16 queue_id);
+	int (*rsc_cache_drain)(void *priv, u16 queue_id);
+	u16 (*save_dvn_ctx)(void *priv, u16 queue_id, u16 split);
+	u16 (*save_uvn_ctx)(void *priv, u16 queue_id, u16 split, u16 queue_size);
+	void (*setup_queue_switch)(void *priv, u16 eth_id);
+	void (*init_pfc)(void *priv, u8 ether_ports);
+	void (*set_promisc_mode)(void *priv, u16 vsi_id, u16 eth_id, u16 mode);
 	void (*configure_msix_map)(void *priv, u16 func_id, bool valid, dma_addr_t dma_addr,
 				   u8 bus, u8 devid, u8 function);
 	void (*configure_msix_info)(void *priv, u16 func_id, bool valid, u16 interrupt_id,
@@ -45,13 +88,19 @@ struct nbl_hw_ops {
 	void (*update_adminq_queue_tail_ptr)(void *priv, u16 tail_ptr, u8 txrx);
 	bool (*check_adminq_dma_err)(void *priv, bool tx);
 
+	int (*set_spoof_check_addr)(void *priv, u16 vsi_id, u8 *mac);
+	int (*set_spoof_check_enable)(void *priv, u16 vsi_id, u8 enable);
 	u8 __iomem * (*get_hw_addr)(void *priv, size_t *size);
+	int (*set_sfp_state)(void *priv, u8 eth_id, u8 state);
 	void (*set_hw_status)(void *priv, enum nbl_hw_status hw_status);
 	enum nbl_hw_status (*get_hw_status)(void *priv);
 	void (*set_fw_ping)(void *priv, u32 ping);
 	u32 (*get_fw_pong)(void *priv);
 	void (*set_fw_pong)(void *priv, u32 pong);
 	int (*process_abnormal_event)(void *priv, struct nbl_abnormal_event_info *abnomal_info);
+	u32 (*get_uvn_desc_entry_stats)(void *priv);
+	void (*set_uvn_desc_wr_timeout)(void *priv, u16 timeout);
+	int (*get_uvn_pkt_drop_stats)(void *priv, u16 global_queue_id, u32 *uvn_stat_pkt_drop);
 	int (*get_ustore_pkt_drop_stats)(void *priv, u8 eth_id,
 					 struct nbl_ustore_stats *ustore_stats);
 
@@ -60,6 +109,7 @@ struct nbl_hw_ops {
 	u32 (*get_fw_eth_map)(void *priv);
 	void (*get_board_info)(void *priv, struct nbl_board_port_info *board);
 	u32 (*get_quirks)(void *priv);
+
 };
 
 struct nbl_hw_ops_tbl {
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index cd9b931be98c..ad359e95d206 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -98,6 +98,11 @@ enum {
 	NBL_VSI_MAX,
 };
 
+enum {
+	NBL_TX = 0,
+	NBL_RX,
+};
+
 enum nbl_hw_status {
 	NBL_HW_NOMAL,
 	NBL_HW_FATAL_ERR, /* Most hw module is not work nomal exclude pcie/emp */
@@ -261,6 +266,34 @@ struct nbl_notify_param {
 	u16 tail_ptr;
 };
 
+enum nbl_flow_ctrl {
+	NBL_PORT_TX_PAUSE = 0x1,
+	NBL_PORT_RX_PAUSE = 0x2,
+	NBL_PORT_TXRX_PAUSE_OFF = 0x4, /* used for ethtool, means ethtool close tx and rx pause */
+};
+
+enum nbl_port_fec {
+	NBL_PORT_FEC_OFF = 1,
+	NBL_PORT_FEC_RS = 2,
+	NBL_PORT_FEC_BASER = 3,
+	NBL_PORT_FEC_AUTO = 4, /* ethtool may set Auto mode, used for PF mailbox msg*/
+};
+
+enum nbl_port_type {
+	NBL_PORT_TYPE_UNKNOWN = 0,
+	NBL_PORT_TYPE_FIBRE,
+	NBL_PORT_TYPE_COPPER,
+};
+
+enum nbl_port_max_rate {
+	NBL_PORT_MAX_RATE_UNKNOWN = 0,
+	NBL_PORT_MAX_RATE_1G,
+	NBL_PORT_MAX_RATE_10G,
+	NBL_PORT_MAX_RATE_25G,
+	NBL_PORT_MAX_RATE_100G,
+	NBL_PORT_MAX_RATE_100G_PAM4,
+};
+
 enum nbl_port_mode {
 	NBL_PORT_NRZ_NORSFEC,
 	NBL_PORT_NRZ_544,
@@ -269,6 +302,80 @@ enum nbl_port_mode {
 	NBL_PORT_MODE_MAX,
 };
 
+#define NBL_PORT_CAP_AUTONEG_MASK (BIT(NBL_PORT_CAP_AUTONEG))
+#define NBL_PORT_CAP_FEC_MASK \
+	(BIT(NBL_PORT_CAP_FEC_OFF) | BIT(NBL_PORT_CAP_FEC_RS) | BIT(NBL_PORT_CAP_FEC_BASER))
+#define NBL_PORT_CAP_PAUSE_MASK (BIT(NBL_PORT_CAP_TX_PAUSE) | BIT(NBL_PORT_CAP_RX_PAUSE))
+#define NBL_PORT_CAP_SPEED_1G_MASK\
+	(BIT(NBL_PORT_CAP_1000BASE_T) | BIT(NBL_PORT_CAP_1000BASE_X))
+#define NBL_PORT_CAP_SPEED_10G_MASK\
+	(BIT(NBL_PORT_CAP_10GBASE_T) | BIT(NBL_PORT_CAP_10GBASE_KR) | BIT(NBL_PORT_CAP_10GBASE_SR))
+#define NBL_PORT_CAP_SPEED_25G_MASK \
+	(BIT(NBL_PORT_CAP_25GBASE_KR) | BIT(NBL_PORT_CAP_25GBASE_SR) |\
+	 BIT(NBL_PORT_CAP_25GBASE_CR) | BIT(NBL_PORT_CAP_25G_AUI))
+#define NBL_PORT_CAP_SPEED_50G_MASK \
+	(BIT(NBL_PORT_CAP_50GBASE_KR2) | BIT(NBL_PORT_CAP_50GBASE_SR2) |\
+	 BIT(NBL_PORT_CAP_50GBASE_CR2) | BIT(NBL_PORT_CAP_50G_AUI2) |\
+	 BIT(NBL_PORT_CAP_50GBASE_KR_PAM4) | BIT(NBL_PORT_CAP_50GBASE_SR_PAM4) |\
+	 BIT(NBL_PORT_CAP_50GBASE_CR_PAM4) | BIT(NBL_PORT_CAP_50G_AUI_PAM4))
+#define NBL_PORT_CAP_SPEED_100G_MASK \
+	(BIT(NBL_PORT_CAP_100GBASE_KR4) | BIT(NBL_PORT_CAP_100GBASE_SR4) |\
+	 BIT(NBL_PORT_CAP_100GBASE_CR4) | BIT(NBL_PORT_CAP_100G_AUI4) |\
+	 BIT(NBL_PORT_CAP_100G_CAUI4) | BIT(NBL_PORT_CAP_100GBASE_KR2_PAM4) |\
+	 BIT(NBL_PORT_CAP_100GBASE_SR2_PAM4) | BIT(NBL_PORT_CAP_100GBASE_CR2_PAM4) |\
+	 BIT(NBL_PORT_CAP_100G_AUI2_PAM4))
+#define NBL_PORT_CAP_SPEED_MASK \
+	(NBL_PORT_CAP_SPEED_1G_MASK | NBL_PORT_CAP_SPEED_10G_MASK |\
+	 NBL_PORT_CAP_SPEED_25G_MASK | NBL_PORT_CAP_SPEED_50G_MASK |\
+	 NBL_PORT_CAP_SPEED_100G_MASK)
+#define NBL_PORT_CAP_PAM4_MASK\
+	(BIT(NBL_PORT_CAP_50GBASE_KR_PAM4) | BIT(NBL_PORT_CAP_50GBASE_SR_PAM4) |\
+	 BIT(NBL_PORT_CAP_50GBASE_CR_PAM4) | BIT(NBL_PORT_CAP_50G_AUI_PAM4) |\
+	 BIT(NBL_PORT_CAP_100GBASE_KR2_PAM4) | BIT(NBL_PORT_CAP_100GBASE_SR2_PAM4) |\
+	 BIT(NBL_PORT_CAP_100GBASE_CR2_PAM4) | BIT(NBL_PORT_CAP_100G_AUI2_PAM4))
+#define NBL_ETH_1G_DEFAULT_FEC_MODE NBL_PORT_FEC_OFF
+#define NBL_ETH_10G_DEFAULT_FEC_MODE NBL_PORT_FEC_OFF
+#define NBL_ETH_25G_DEFAULT_FEC_MODE NBL_PORT_FEC_RS
+#define NBL_ETH_100G_DEFAULT_FEC_MODE NBL_PORT_FEC_RS
+
+enum nbl_port_cap {
+	NBL_PORT_CAP_TX_PAUSE,
+	NBL_PORT_CAP_RX_PAUSE,
+	NBL_PORT_CAP_AUTONEG,
+	NBL_PORT_CAP_FEC_NONE,
+	NBL_PORT_CAP_FEC_OFF = NBL_PORT_CAP_FEC_NONE,
+	NBL_PORT_CAP_FEC_RS,
+	NBL_PORT_CAP_FEC_BASER,
+	NBL_PORT_CAP_1000BASE_T,
+	NBL_PORT_CAP_1000BASE_X,
+	NBL_PORT_CAP_10GBASE_T,
+	NBL_PORT_CAP_10GBASE_KR,
+	NBL_PORT_CAP_10GBASE_SR,
+	NBL_PORT_CAP_25GBASE_KR,
+	NBL_PORT_CAP_25GBASE_SR,
+	NBL_PORT_CAP_25GBASE_CR,
+	NBL_PORT_CAP_25G_AUI,
+	NBL_PORT_CAP_50GBASE_KR2,
+	NBL_PORT_CAP_50GBASE_SR2,
+	NBL_PORT_CAP_50GBASE_CR2,
+	NBL_PORT_CAP_50G_AUI2,
+	NBL_PORT_CAP_50GBASE_KR_PAM4,
+	NBL_PORT_CAP_50GBASE_SR_PAM4,
+	NBL_PORT_CAP_50GBASE_CR_PAM4,
+	NBL_PORT_CAP_50G_AUI_PAM4,
+	NBL_PORT_CAP_100GBASE_KR4,
+	NBL_PORT_CAP_100GBASE_SR4,
+	NBL_PORT_CAP_100GBASE_CR4,
+	NBL_PORT_CAP_100G_AUI4,
+	NBL_PORT_CAP_100G_CAUI4,
+	NBL_PORT_CAP_100GBASE_KR2_PAM4,
+	NBL_PORT_CAP_100GBASE_SR2_PAM4,
+	NBL_PORT_CAP_100GBASE_CR2_PAM4,
+	NBL_PORT_CAP_100G_AUI2_PAM4,
+	NBL_PORT_CAP_FEC_AUTONEG,
+	NBL_PORT_CAP_MAX
+};
+
 enum nbl_fw_port_speed {
 	NBL_FW_PORT_SPEED_10G,
 	NBL_FW_PORT_SPEED_25G,
@@ -292,6 +399,16 @@ struct nbl_fw_cmd_net_ring_num_param {
 	u16 net_max_qp_num[NBL_NET_RING_NUM_CMD_LEN];
 };
 
+#define NBL_VF_NUM_CMD_LEN					(8)
+struct nbl_fw_cmd_vf_num_param {
+	u32 valid;
+	u16 vf_max_num[NBL_VF_NUM_CMD_LEN];
+};
+
+#define NBL_OPS_CALL(func, para)								\
+	({ typeof(func) _func = (func);								\
+	 (!_func) ? 0 : _func para; })
+
 struct nbl_flow_index_key {
 	union {
 		u64 cookie;
@@ -403,6 +520,8 @@ struct nbl_ring_param {
 	u16 queue_size;
 };
 
+#define NBL_VSI_MAX_ID 1024
+
 struct nbl_mtu_entry {
 	u32 ref_count;
 	u16 mtu_value;
-- 
2.43.0


