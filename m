Return-Path: <netdev+bounces-248434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF591D08717
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 11:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5DD930B505B
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 10:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE73433C19E;
	Fri,  9 Jan 2026 10:03:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-22.us.a.mail.aliyun.com (out198-22.us.a.mail.aliyun.com [47.90.198.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932613376BA;
	Fri,  9 Jan 2026 10:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767952991; cv=none; b=vBmAxFJFlsE3jm9ui3Y2hB4wGTEas1/2qKp+UO9byyhqjUvp7dBJnpCzzOeLU2eRxJHhbYu9R21xW6w47XGnnb6YNl5hhCkbltMgLGdIZ+z7tmQizP8H83JjG+mAuTpz48j5cY5BtcQczTnoSvrCf6ZOj4INIEBG5MiLoDmvxCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767952991; c=relaxed/simple;
	bh=1cZjNnSXNRAFs5oKSsOsaE/BZQPUrNvZYPkZQibmeqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hpd89kN0i7N+joJzPpvFhV5jFqX+mEwUkxABafL1SlBPbehhC6zsNL3+kbygYSGQb8OF26/RKeuwbCSMA/Foy/DlEmytM6FIc7IyBbdXOwgWz+vYqrPOAoFMSoGctX6/0EhZUVKYKyRsxjtbQEHKZMHi0Vuo4qcTtRLaqswEIdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.g2QQAn6_1767952956 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 09 Jan 2026 18:02:37 +0800
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
Subject: [PATCH v2 net-next 08/15] net/nebula-matrix: add vsi, queue, adminq resource definitions and implementation
Date: Fri,  9 Jan 2026 18:01:26 +0800
Message-ID: <20260109100146.63569-9-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109100146.63569-1-illusion.wang@nebula-matrix.com>
References: <20260109100146.63569-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

vsi resource management functions include:
  VSI basic operations (promiscuous mode)
  Hardware module initialization and de-initialization
queue resource management functions include:
  queue init, queue deinit
  queue alooc, free
  queue rss cfg
  queue hw cfg
  queue qos and rate control
  queue desc gother
Adminq resource management functions include:
  Hardware Configuration: Send configuration commands to the hardware
via AdminQ (such as setting port properties, queue quantities, MAC
addresses, etc.).
  State Monitoring: Obtain hardware status (such as link status, port
properties, etc.).
  Firmware Management: Support firmware reading, writing, erasing,
checksum verification, and activation.
  Event Notification: Handle hardware events (such as link status
changes, module insertion and removal).
  Command Filtering: Conduct legality checks on commands sent to the
hardware.

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |    3 +
 .../nebula-matrix/nbl/nbl_hw/nbl_adminq.c     | 1336 +++++++++++++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  | 1703 ++++++++++++++++-
 .../nbl_hw/nbl_hw_leonis/nbl_queue_leonis.c   | 1430 ++++++++++++++
 .../nbl_hw/nbl_hw_leonis/nbl_queue_leonis.h   |   23 +
 .../nbl_hw_leonis/nbl_resource_leonis.c       |   30 +
 .../nbl_hw_leonis/nbl_resource_leonis.h       |   12 +
 .../nebula-matrix/nbl/nbl_hw/nbl_queue.c      |   60 +
 .../nebula-matrix/nbl/nbl_hw/nbl_queue.h      |   11 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.c   |   17 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |   10 +
 .../nebula-matrix/nbl/nbl_hw/nbl_vsi.c        |  168 ++
 .../nebula-matrix/nbl/nbl_hw/nbl_vsi.h        |   12 +
 .../nbl/nbl_include/nbl_def_hw.h              |   55 +
 .../nbl/nbl_include/nbl_include.h             |  134 ++
 15 files changed, 4996 insertions(+), 8 deletions(-)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_queue_leonis.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_queue_leonis.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_queue.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_queue.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index 9c20af47313e..e611110ac369 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -7,10 +7,13 @@ obj-$(CONFIG_NBL_CORE) := nbl_core.o
 nbl_core-objs +=       nbl_common/nbl_common.o \
 				nbl_channel/nbl_channel.o \
 				nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
+				nbl_hw/nbl_hw_leonis/nbl_queue_leonis.o \
 				nbl_hw/nbl_hw_leonis/nbl_resource_leonis.o \
 				nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.o \
 				nbl_hw/nbl_resource.o \
 				nbl_hw/nbl_interrupt.o \
+				nbl_hw/nbl_queue.o \
+				nbl_hw/nbl_vsi.o \
 				nbl_hw/nbl_adminq.o \
 				nbl_main.o
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_adminq.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_adminq.c
index 2db160a92256..a56de810de79 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_adminq.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_adminq.c
@@ -6,6 +6,273 @@
 
 #include "nbl_adminq.h"
 
+static int nbl_res_aq_update_ring_num(void *priv);
+
+/* ****   FW CMD FILTERS START  **** */
+
+static int nbl_res_aq_chk_net_ring_num(struct nbl_resource_mgt *res_mgt,
+				       struct nbl_cmd_net_ring_num *p)
+{
+	struct nbl_resource_info *res_info = NBL_RES_MGT_TO_RES_INFO(res_mgt);
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	u32 sum = 0, pf_real_num = 0, vf_real_num = 0;
+	int i, tmp;
+
+	pf_real_num = NBL_VSI_PF_LEGAL_QUEUE_NUM(p->pf_def_max_net_qp_num);
+	vf_real_num = NBL_VSI_VF_REAL_QUEUE_NUM(p->vf_def_max_net_qp_num);
+
+	if (pf_real_num > NBL_MAX_TXRX_QUEUE_PER_FUNC ||
+	    vf_real_num > NBL_MAX_TXRX_QUEUE_PER_FUNC)
+		return -EINVAL;
+
+	for (i = 0; i < NBL_COMMON_TO_ETH_MODE(common); i++) {
+		pf_real_num = p->net_max_qp_num[i] ?
+			NBL_VSI_PF_LEGAL_QUEUE_NUM(p->net_max_qp_num[i]) :
+			NBL_VSI_PF_LEGAL_QUEUE_NUM(p->pf_def_max_net_qp_num);
+
+		if (pf_real_num > NBL_MAX_TXRX_QUEUE_PER_FUNC)
+			return -EINVAL;
+
+		pf_real_num = p->net_max_qp_num[i] ?
+			NBL_VSI_PF_MAX_QUEUE_NUM(p->net_max_qp_num[i]) :
+			NBL_VSI_PF_MAX_QUEUE_NUM(p->pf_def_max_net_qp_num);
+		if (pf_real_num > NBL_MAX_TXRX_QUEUE_PER_FUNC)
+			pf_real_num = NBL_MAX_TXRX_QUEUE_PER_FUNC;
+
+		sum += pf_real_num;
+	}
+
+	for (i = 0; i < res_info->max_vf_num; i++) {
+		tmp = i + NBL_MAX_PF;
+		vf_real_num = p->net_max_qp_num[tmp] ?
+			NBL_VSI_VF_REAL_QUEUE_NUM(p->net_max_qp_num[tmp]) :
+			NBL_VSI_VF_REAL_QUEUE_NUM(p->vf_def_max_net_qp_num);
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
+static u32 nbl_res_aq_sum_vf_num(struct nbl_cmd_vf_num *param)
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
+static int nbl_res_aq_check_vf_num_type(struct nbl_resource_mgt *res_mgt,
+					struct nbl_cmd_vf_num *param)
+{
+	u32 count;
+
+	count = nbl_res_aq_sum_vf_num(param);
+	if (count > NBL_MAX_VF)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int nbl_res_fw_cmd_filter_rw_in(struct nbl_resource_mgt *res_mgt,
+				       void *data, u16 len)
+{
+	struct nbl_chan_resource_write_param *param =
+		(struct nbl_chan_resource_write_param *)data;
+	struct nbl_cmd_net_ring_num *net_ring_num_param;
+	struct nbl_cmd_vf_num *vf_num_param;
+
+	switch (param->resid) {
+	case NBL_ADMINQ_PFA_TLV_NET_RING_NUM:
+		net_ring_num_param = (struct nbl_cmd_net_ring_num *)param->data;
+		return nbl_res_aq_chk_net_ring_num(res_mgt, net_ring_num_param);
+	case NBL_ADMINQ_PFA_TLV_VF_NUM:
+		vf_num_param = (struct nbl_cmd_vf_num *)param->data;
+		return nbl_res_aq_check_vf_num_type(res_mgt, vf_num_param);
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int nbl_res_fw_cmd_filter_rw_out(struct nbl_resource_mgt *res_mgt,
+					void *in, u16 in_len, void *out,
+					u16 out_len)
+{
+	struct nbl_resource_info *res_info = NBL_RES_MGT_TO_RES_INFO(res_mgt);
+	struct nbl_net_ring_num_info *num_info = &res_info->net_ring_num_info;
+	struct nbl_chan_resource_write_param *param =
+		(struct nbl_chan_resource_write_param *)in;
+	struct nbl_cmd_net_ring_num *net_ring_num_param;
+	struct nbl_cmd_vf_num *vf_num_param;
+	size_t copy_len;
+	u32 count;
+
+	switch (param->resid) {
+	case NBL_ADMINQ_PFA_TLV_NET_RING_NUM:
+		net_ring_num_param = (struct nbl_cmd_net_ring_num *)param->data;
+		copy_len = min_t(size_t, sizeof(*num_info), (size_t)in_len);
+		memcpy(num_info, net_ring_num_param, copy_len);
+		break;
+	case NBL_ADMINQ_PFA_TLV_VF_NUM:
+		vf_num_param = (struct nbl_cmd_vf_num *)param->data;
+		count = nbl_res_aq_sum_vf_num(vf_num_param);
+		res_info->max_vf_num = count;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static void
+nbl_res_aq_add_cmd_filter_res_write(struct nbl_resource_mgt *res_mgt)
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
+	if (nbl_common_alloc_hash_node(adminq_mgt->cmd_filter, &key, &filter,
+				       NULL))
+		nbl_warn(common, "Fail to register res_write in filter");
+}
+
+/* ****   FW CMD FILTERS END   **** */
+
+static int nbl_res_aq_set_module_eeprom_info(struct nbl_resource_mgt *res_mgt,
+					     u8 eth_id, u8 i2c_address, u8 page,
+					     u8 bank, u32 offset, u32 length,
+					     u8 *data)
+{
+	struct nbl_channel_ops *chan_ops = NBL_RES_MGT_TO_CHAN_OPS(res_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(res_mgt->common);
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	struct nbl_chan_send_info chan_send;
+	struct nbl_chan_param_module_eeprom_info param = { 0 };
+	u32 xfer_size = 0;
+	u32 byte_offset = 0;
+	int data_length = length;
+	int ret = 0;
+
+	do {
+		xfer_size =
+			min_t(u32, data_length, NBL_MODULE_EEPRO_WRITE_MAX_LEN);
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
+			      NBL_CHAN_MSG_ADMINQ_GET_MODULE_EEPROM, &param,
+			      sizeof(param), NULL, 0, 1);
+		ret = chan_ops->send_msg(NBL_RES_MGT_TO_CHAN_PRIV(res_mgt),
+					 &chan_send);
+		if (ret) {
+			dev_err(dev,
+				"adminq send msg failed: %d, msg: 0x%x, eth_id:%d, addr:%d,",
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
+static int nbl_res_aq_turn_module_eeprom_page(struct nbl_resource_mgt *res_mgt,
+					      u8 eth_id, u8 page)
+{
+	int ret;
+	struct device *dev = NBL_COMMON_TO_DEV(res_mgt->common);
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+
+	ret = nbl_res_aq_set_module_eeprom_info(res_mgt, eth_id,
+						I2C_DEV_ADDR_A0, 0, 0,
+						SFF_8636_TURNPAGE_ADDR, 1,
+						&page);
+	if (ret) {
+		dev_err(dev, "eth %d set_module_eeprom_info failed %d\n",
+			eth_info->logic_eth_id[eth_id], ret);
+		return -EIO;
+	}
+
+	return ret;
+}
+
+static int nbl_res_aq_get_module_eeprom(struct nbl_resource_mgt *res_mgt,
+					u8 eth_id, u8 i2c_address, u8 page,
+					u8 bank, u32 offset, u32 length,
+					u8 *data)
+{
+	struct nbl_channel_ops *chan_ops = NBL_RES_MGT_TO_CHAN_OPS(res_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(res_mgt->common);
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	struct nbl_chan_send_info chan_send;
+	struct nbl_chan_param_module_eeprom_info param = { 0 };
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
+			      NBL_CHAN_MSG_ADMINQ_GET_MODULE_EEPROM, &param,
+			      sizeof(param), data + byte_offset, xfer_size, 1);
+		ret = chan_ops->send_msg(NBL_RES_MGT_TO_CHAN_PRIV(res_mgt),
+					 &chan_send);
+		if (ret) {
+			dev_err(dev,
+				"adminq send msg failed: %d, msg: 0x%x, eth_id:%d, addr:%d,",
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
 static int nbl_res_aq_set_sfp_state(void *priv, u8 eth_id, u8 state)
 {
 	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
@@ -56,6 +323,481 @@ int nbl_res_open_sfp(struct nbl_resource_mgt *res_mgt, u8 eth_id)
 	return nbl_res_aq_set_sfp_state(res_mgt, eth_id, NBL_SFP_MODULE_ON);
 }
 
+static bool nbl_res_aq_check_fw_heartbeat(void *priv)
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
+		hw_ops->set_fw_ping(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+				    adminq_mgt->fw_last_hb_seq);
+		return true;
+	}
+
+	return false;
+}
+
+static bool nbl_res_aq_check_fw_reset(void *priv)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_adminq_mgt *adminq_mgt = NBL_RES_MGT_TO_ADMINQ_MGT(res_mgt);
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	u32 seq_acked;
+
+	seq_acked = hw_ops->get_fw_pong(NBL_RES_MGT_TO_HW_PRIV(res_mgt));
+	if (adminq_mgt->fw_last_hb_seq != seq_acked) {
+		hw_ops->set_fw_ping(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+				    adminq_mgt->fw_last_hb_seq);
+		return false;
+	}
+
+	adminq_mgt->fw_resetting = false;
+	wake_up(&adminq_mgt->wait_queue);
+	return true;
+}
+
+static int nbl_res_aq_get_port_attributes(void *priv)
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
+	if (!param)
+		return -ENOMEM;
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
+			      NBL_CHAN_MSG_ADMINQ_MANAGE_PORT_ATTRIBUTES, param,
+			      param_len, (void *)&port_caps, sizeof(port_caps),
+			      1);
+		ret = chan_ops->send_msg(NBL_RES_MGT_TO_CHAN_PRIV(res_mgt),
+					 &chan_send);
+		if (ret) {
+			dev_err(dev,
+				"adminq send msg failed with ret: %d, msg_type: 0x%x, eth_id:%d, get_port_caps\n",
+				ret, NBL_CHAN_MSG_ADMINQ_MANAGE_PORT_ATTRIBUTES,
+				eth_info->logic_eth_id[eth_id]);
+			kfree(param);
+			return ret;
+		}
+
+		eth_info->port_caps[eth_id] = port_caps &
+					      NBL_PORT_KEY_DATA_MASK;
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
+			      NBL_CHAN_MSG_ADMINQ_MANAGE_PORT_ATTRIBUTES, param,
+			      param_len, (void *)&port_advertising,
+			      sizeof(port_advertising), 1);
+		ret = chan_ops->send_msg(NBL_RES_MGT_TO_CHAN_PRIV(res_mgt),
+					 &chan_send);
+		if (ret) {
+			dev_err(dev,
+				"adminq send msg failed with ret: %d, msg_type: 0x%x, eth_id:%d, port_advertising\n",
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
+static int nbl_res_aq_enable_port(void *priv, bool enable)
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
+	if (!param)
+		return -ENOMEM;
+	if (enable) {
+		key = NBL_PORT_KEY_ENABLE;
+		data = NBL_PORT_FLAG_ENABLE_NOTIFY +
+		       (key << NBL_PORT_KEY_KEY_SHIFT);
+	} else {
+		key = NBL_PORT_KEY_DISABLE;
+		data = key << NBL_PORT_KEY_KEY_SHIFT;
+	}
+
+	for_each_set_bit(eth_id, eth_info->eth_bitmap, NBL_MAX_ETHERNET) {
+		nbl_res_aq_set_sfp_state(res_mgt, eth_id, NBL_SFP_MODULE_ON);
+
+		memset(param, 0, param_len);
+		param->id = eth_id;
+		param->subop = NBL_PORT_SUBOP_WRITE;
+		param->data[0] = data;
+
+		NBL_CHAN_SEND(chan_send, NBL_CHAN_ADMINQ_FUNCTION_ID,
+			      NBL_CHAN_MSG_ADMINQ_MANAGE_PORT_ATTRIBUTES, param,
+			      param_len, NULL, 0, 1);
+		ret = chan_ops->send_msg(NBL_RES_MGT_TO_CHAN_PRIV(res_mgt),
+					 &chan_send);
+		if (ret) {
+			dev_err(dev,
+				"adminq send msg failed with ret: %d, msg_type: 0x%x, eth_id:%d, %s port\n",
+				ret, NBL_CHAN_MSG_ADMINQ_MANAGE_PORT_ATTRIBUTES,
+				eth_info->logic_eth_id[eth_id],
+				enable ? "enable" : "disable");
+			kfree(param);
+			return ret;
+		}
+
+		dev_info(dev, "ctrl dev %s eth %d\n",
+			 enable ? "enable" : "disable",
+			 eth_info->logic_eth_id[eth_id]);
+	}
+
+	kfree(param);
+	return 0;
+}
+
+static int nbl_res_aq_get_special_port_type(struct nbl_resource_mgt *res_mgt,
+					    u8 eth_id)
+{
+	struct device *dev = NBL_COMMON_TO_DEV(res_mgt->common);
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	u8 port_type = NBL_PORT_TYPE_UNKNOWN;
+	u8 cable_tech = 0;
+	int ret;
+
+	ret = nbl_res_aq_turn_module_eeprom_page(res_mgt, eth_id, 0);
+	if (ret) {
+		dev_err(dev, "eth %d get_module_eeprom_info failed %d\n",
+			eth_info->logic_eth_id[eth_id], ret);
+		port_type = NBL_PORT_TYPE_UNKNOWN;
+		return port_type;
+	}
+
+	ret = nbl_res_aq_get_module_eeprom(res_mgt, eth_id, I2C_DEV_ADDR_A0, 0,
+					   0, SFF8636_DEVICE_TECH_OFFSET, 1,
+					   &cable_tech);
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
+		dev_err(dev, "eth %d unknown port_type\n",
+			eth_info->logic_eth_id[eth_id]);
+		port_type = NBL_PORT_TYPE_UNKNOWN;
+		break;
+	}
+	return port_type;
+}
+
+static int nbl_res_aq_get_common_port_type(struct nbl_resource_mgt *res_mgt,
+					   u8 eth_id)
+{
+	struct device *dev = NBL_COMMON_TO_DEV(res_mgt->common);
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	u8 data[SFF_8472_CABLE_SPEC_COMP + 1];
+	u8 cable_tech = 0;
+	u8 cable_comp = 0;
+	u8 port_type = NBL_PORT_TYPE_UNKNOWN;
+	int ret;
+
+	ret = nbl_res_aq_get_module_eeprom(res_mgt, eth_id, I2C_DEV_ADDR_A0, 0,
+					   0, 0, SFF_8472_CABLE_SPEC_COMP + 1,
+					   data);
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
+static int nbl_res_aq_get_port_type(struct nbl_resource_mgt *res_mgt, u8 eth_id)
+{
+	if (res_mgt->resource_info->board_info.eth_speed ==
+	    NBL_FW_PORT_SPEED_100G)
+		return nbl_res_aq_get_special_port_type(res_mgt, eth_id);
+
+	return nbl_res_aq_get_common_port_type(res_mgt, eth_id);
+}
+
+static s32 nbl_res_aq_get_module_bitrate(struct nbl_resource_mgt *res_mgt,
+					 u8 eth_id)
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
+	if (res_mgt->resource_info->board_info.eth_speed ==
+	    NBL_FW_PORT_SPEED_100G) {
+		ret = nbl_res_aq_turn_module_eeprom_page(res_mgt, eth_id, 0);
+		if (ret) {
+			dev_err(dev,
+				"eth %d get_module_eeprom_info failed %d\n",
+				eth_info->logic_eth_id[eth_id], ret);
+			return NBL_PORT_MAX_RATE_UNKNOWN;
+		}
+	}
+
+	ret = nbl_res_aq_get_module_eeprom(res_mgt, eth_id, I2C_DEV_ADDR_A0, 0,
+					   0, 0,
+					   SFF_8472_SIGNALING_RATE_MAX + 1,
+					   data);
+	if (ret) {
+		dev_err(dev, "eth %d get_module_eeprom_info failed %d\n",
+			eth_info->logic_eth_id[eth_id], ret);
+		return NBL_PORT_MAX_RATE_UNKNOWN;
+	}
+
+	if (res_mgt->resource_info->board_info.eth_speed ==
+	    NBL_FW_PORT_SPEED_100G) {
+		ret = nbl_res_aq_get_module_eeprom(res_mgt, eth_id,
+						   I2C_DEV_ADDR_A0, 0, 0,
+						   SFF_8636_VENDOR_ENCODING, 1,
+						   &encoding);
+		if (ret) {
+			dev_err(dev,
+				"eth %d get_module_eeprom_info failed %d\n",
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
+	if (identifier == SFF_IDENTIFIER_PAM4 ||
+	    encoding == SFF_8636_ENCODING_PAM4)
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
+static void nbl_res_aq_recv_port_notify(void *priv, void *data)
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
+	dev_info(dev,
+		 "eth_id:%d link_state:%d, module_inplace:%d, speed:%d, flow_ctrl:%d, fec:%d, advertising:%llx, lp_advertising:%llx\n",
+		 eth_info->logic_eth_id[eth_id], notify->link_state,
+		 notify->module_inplace, notify->speed * 10, notify->flow_ctrl,
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
+	 * when config autoneg to off, ethtool read speed and set it with
+	 * disable autoneg command, if eth is link down, the speed from emp
+	 * is not credible, need to reserver last link up speed.
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
+static int
+nbl_res_aq_get_link_state(void *priv, u8 eth_id,
+			  struct nbl_eth_link_info *eth_link_info)
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
 static int nbl_res_aq_get_eth_mac_addr(void *priv, u8 *mac, u8 eth_id)
 {
 	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
@@ -108,3 +850,597 @@ int nbl_res_get_eth_mac(struct nbl_resource_mgt *res_mgt, u8 *mac, u8 eth_id)
 {
 	return nbl_res_aq_get_eth_mac_addr(res_mgt, mac, eth_id);
 }
+
+static int nbl_res_aq_set_eth_mac_addr(void *priv, u8 *mac, u8 eth_id)
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
+	if (!param)
+		return -ENOMEM;
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
+		      NBL_CHAN_MSG_ADMINQ_MANAGE_PORT_ATTRIBUTES, param,
+		      param_len, NULL, 0, 1);
+	ret = chan_ops->send_msg(NBL_RES_MGT_TO_CHAN_PRIV(res_mgt), &chan_send);
+	if (ret) {
+		dev_err(dev,
+			"adminq send msg failed with ret: %d, msg_type: 0x%x, eth_id:%d, reverse_mac=0x%x:%x:%x:%x:%x:%x\n",
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
+static int
+nbl_res_aq_pt_filter_in(struct nbl_resource_mgt *res_mgt,
+			struct nbl_passthrough_fw_cmd *param)
+{
+	struct nbl_adminq_mgt *adminq_mgt = NBL_RES_MGT_TO_ADMINQ_MGT(res_mgt);
+	struct nbl_res_fw_cmd_filter *filter;
+
+	filter = nbl_common_get_hash_node(adminq_mgt->cmd_filter,
+					  &param->opcode);
+	if (filter && filter->in)
+		return filter->in(res_mgt, param->data, param->in_size);
+
+	return 0;
+}
+
+static int nbl_res_aq_pt_filter_out(struct nbl_resource_mgt *res_mgt,
+				    struct nbl_passthrough_fw_cmd *param,
+				    struct nbl_passthrough_fw_cmd *result)
+{
+	struct nbl_adminq_mgt *adminq_mgt = NBL_RES_MGT_TO_ADMINQ_MGT(res_mgt);
+	struct nbl_res_fw_cmd_filter *filter;
+	int ret = 0;
+
+	filter = nbl_common_get_hash_node(adminq_mgt->cmd_filter,
+					  &param->opcode);
+	if (filter && filter->out)
+		ret = filter->out(res_mgt, param->data, param->in_size,
+				  result->data, result->out_size);
+
+	return ret;
+}
+
+static int nbl_res_aq_passthrough(void *priv,
+				  struct nbl_passthrough_fw_cmd *param,
+				  struct nbl_passthrough_fw_cmd *result)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_RES_MGT_TO_CHAN_OPS(res_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(res_mgt->common);
+	struct nbl_chan_send_info chan_send;
+	u8 *in_data = NULL, *out_data = NULL;
+	int ret = 0;
+
+	ret = nbl_res_aq_pt_filter_in(res_mgt, param);
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
+		dev_dbg(dev,
+			"adminq send msg failed with ret: %d, msg_type: 0x%x\n",
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
+	nbl_res_aq_pt_filter_out(res_mgt, param, result);
+
+send_fail:
+	kfree(out_data);
+out_data_fail:
+	kfree(in_data);
+in_data_fail:
+	return ret;
+}
+
+static int nbl_res_aq_update_ring_num(void *priv)
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
+	NBL_CHAN_SEND(chan_send, NBL_CHAN_ADMINQ_FUNCTION_ID,
+		      NBL_CHAN_MSG_ADMINQ_RESOURCE_READ, param, sizeof(*param),
+		      info, sizeof(*info), 1);
+
+	ret = chan_ops->send_msg(NBL_RES_MGT_TO_CHAN_PRIV(res_mgt), &chan_send);
+	if (ret) {
+		dev_err(dev,
+			"adminq send msg failed with ret: %d, msg_type: 0x%x\n",
+			ret, NBL_CHAN_MSG_ADMINQ_RESOURCE_READ);
+		goto send_fail;
+	}
+
+	if (info->pf_def_max_net_qp_num && info->vf_def_max_net_qp_num &&
+	    !nbl_res_aq_chk_net_ring_num(res_mgt,
+					 (struct nbl_cmd_net_ring_num *)info))
+		memcpy(&res_info->net_ring_num_info, info,
+		       sizeof(res_info->net_ring_num_info));
+
+send_fail:
+	kfree(info);
+alloc_info_fail:
+	kfree(param);
+alloc_param_fail:
+	return ret;
+}
+
+static int nbl_res_aq_set_ring_num(void *priv,
+				   struct nbl_cmd_net_ring_num *param)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_RES_MGT_TO_CHAN_OPS(res_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(NBL_RES_MGT_TO_COMMON(res_mgt));
+	struct nbl_chan_send_info chan_send;
+	struct nbl_chan_resource_write_param *data;
+	int data_len = sizeof(struct nbl_cmd_net_ring_num);
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
+	NBL_CHAN_SEND(chan_send, NBL_CHAN_ADMINQ_FUNCTION_ID,
+		      NBL_CHAN_MSG_ADMINQ_RESOURCE_WRITE, data,
+		      sizeof(*data) + data_len, NULL, 0, 1);
+	ret = chan_ops->send_msg(NBL_RES_MGT_TO_CHAN_PRIV(res_mgt), &chan_send);
+	if (ret)
+		dev_err(dev, "adminq send msg failed with ret: %d\n", ret);
+
+	kfree(data);
+	return ret;
+}
+
+static int nbl_res_aq_set_wol(void *priv, u8 eth_id, bool enable)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_RES_MGT_TO_CHAN_OPS(res_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(NBL_RES_MGT_TO_COMMON(res_mgt));
+	struct nbl_chan_send_info chan_send;
+	struct nbl_chan_adminq_reg_write_param reg_write = { 0 };
+	struct nbl_chan_adminq_reg_read_param reg_read = { 0 };
+	u32 value;
+	int ret = 0;
+
+	dev_info(dev, "set_wol ethid %d %sabled", eth_id,
+		 enable ? "en" : "dis");
+
+	reg_read.reg = NBL_ADMINQ_ETH_WOL_REG_OFFSET;
+	NBL_CHAN_SEND(chan_send, NBL_CHAN_ADMINQ_FUNCTION_ID,
+		      NBL_CHAN_MSG_ADMINQ_REGISTER_READ, &reg_read,
+		      sizeof(reg_read), &value, sizeof(value), 1);
+	ret = chan_ops->send_msg(NBL_RES_MGT_TO_CHAN_PRIV(res_mgt), &chan_send);
+	if (ret) {
+		dev_err(dev, "adminq send msg failed with ret: %d\n", ret);
+		return ret;
+	}
+
+	reg_write.reg = NBL_ADMINQ_ETH_WOL_REG_OFFSET;
+	reg_write.value = (value & ~(1 << eth_id)) | (enable << eth_id);
+	NBL_CHAN_SEND(chan_send, NBL_CHAN_ADMINQ_FUNCTION_ID,
+		      NBL_CHAN_MSG_ADMINQ_REGISTER_WRITE, &reg_write,
+		      sizeof(reg_write), NULL, 0, 1);
+	ret = chan_ops->send_msg(NBL_RES_MGT_TO_CHAN_PRIV(res_mgt), &chan_send);
+	if (ret)
+		dev_err(dev, "adminq send msg failed with ret: %d\n", ret);
+
+	return ret;
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
+	NBL_CHAN_SEND(chan_send, NBL_CHAN_ADMINQ_FUNCTION_ID,
+		      NBL_CHAN_MSG_ADMINQ_RESOURCE_READ, param, sizeof(*param),
+		      info, sizeof(*info), 1);
+
+	ret = chan_ops->send_msg(NBL_RES_MGT_TO_CHAN_PRIV(res_mgt), &chan_send);
+	if (ret) {
+		dev_err(dev,
+			"adminq send msg failed with ret: %d, msg_type: 0x%x, resid: 0x%x\n",
+			ret, NBL_CHAN_MSG_ADMINQ_RESOURCE_READ,
+			NBL_ADMINQ_RESID_FSI_SECTION_HBC);
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
+	NBL_CHAN_SEND(chan_send, NBL_CHAN_ADMINQ_FUNCTION_ID,
+		      NBL_CHAN_MSG_ADMINQ_RESOURCE_READ, param, sizeof(*param),
+		      info, sizeof(*info), 1);
+
+	ret = chan_ops->send_msg(NBL_RES_MGT_TO_CHAN_PRIV(res_mgt), &chan_send);
+	if (ret) {
+		dev_err(dev,
+			"adminq send msg failed with ret: %d, msg_type: 0x%x, resid: 0x%x\n",
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
+#define NBL_ADMINQ_OPS_TBL						\
+do {									\
+	NBL_ADMINQ_SET_OPS(set_sfp_state, nbl_res_aq_set_sfp_state);\
+	NBL_ADMINQ_SET_OPS(check_fw_heartbeat,				\
+			   nbl_res_aq_check_fw_heartbeat);		\
+	NBL_ADMINQ_SET_OPS(check_fw_reset,				\
+			   nbl_res_aq_check_fw_reset);		\
+	NBL_ADMINQ_SET_OPS(get_port_attributes,				\
+			   nbl_res_aq_get_port_attributes);		\
+	NBL_ADMINQ_SET_OPS(update_ring_num,				\
+			   nbl_res_aq_update_ring_num);		\
+	NBL_ADMINQ_SET_OPS(set_ring_num, nbl_res_aq_set_ring_num);	\
+	NBL_ADMINQ_SET_OPS(enable_port, nbl_res_aq_enable_port);	\
+	NBL_ADMINQ_SET_OPS(recv_port_notify,				\
+			   nbl_res_aq_recv_port_notify);		\
+	NBL_ADMINQ_SET_OPS(get_link_state,				\
+			   nbl_res_aq_get_link_state);		\
+	NBL_ADMINQ_SET_OPS(set_eth_mac_addr,				\
+			   nbl_res_aq_set_eth_mac_addr);		\
+	NBL_ADMINQ_SET_OPS(set_wol, nbl_res_aq_set_wol);		\
+	NBL_ADMINQ_SET_OPS(passthrough_fw_cmd,				\
+			   nbl_res_aq_passthrough);			\
+	NBL_ADMINQ_SET_OPS(get_part_number, nbl_res_get_part_number);	\
+	NBL_ADMINQ_SET_OPS(get_serial_number, nbl_res_get_serial_number);\
+} while (0)
+
+/* Structure starts here, adding an op should not modify anything below */
+static int nbl_adminq_setup_mgt(struct device *dev,
+				struct nbl_adminq_mgt **adminq_mgt)
+{
+	*adminq_mgt =
+		devm_kzalloc(dev, sizeof(struct nbl_adminq_mgt), GFP_KERNEL);
+	if (!*adminq_mgt)
+		return -ENOMEM;
+
+	init_waitqueue_head(&(*adminq_mgt)->wait_queue);
+	return 0;
+}
+
+static void nbl_adminq_remove_mgt(struct device *dev,
+				  struct nbl_adminq_mgt **adminq_mgt)
+{
+	devm_kfree(dev, *adminq_mgt);
+	*adminq_mgt = NULL;
+}
+
+static int
+nbl_res_aq_chan_notify_link_state_req(struct nbl_resource_mgt *res_mgt, u16 fid,
+				      u8 link_state, u32 link_speed)
+{
+	struct nbl_channel_ops *chan_ops = NBL_RES_MGT_TO_CHAN_OPS(res_mgt);
+	struct nbl_chan_send_info chan_send;
+	struct nbl_chan_param_notify_link_state link_info = { 0 };
+
+	chan_ops = NBL_RES_MGT_TO_CHAN_OPS(res_mgt);
+
+	link_info.link_state = link_state;
+	link_info.link_speed = link_speed;
+	NBL_CHAN_SEND(chan_send, fid, NBL_CHAN_MSG_NOTIFY_LINK_STATE,
+		      &link_info, sizeof(link_info), NULL, 0, 0);
+	return chan_ops->send_msg(NBL_RES_MGT_TO_CHAN_PRIV(res_mgt),
+				  &chan_send);
+}
+
+static void nbl_res_aq_notify_link_state(struct nbl_resource_mgt *res_mgt,
+					 u8 eth_id, u8 state)
+{
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_sriov_info *sriov_info;
+	struct nbl_queue_info *queue_info;
+	u16 pf_fid = 0, vf_fid = 0, speed = 0;
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
+		speed = eth_info->link_speed[eth_id];
+		/* send eth's link state to pf */
+		if (queue_info->num_txrx_queues) {
+			nbl_res_aq_chan_notify_link_state_req(res_mgt, pf_fid,
+							      state, speed);
+		}
+
+		/* send eth's link state to pf's all vf */
+		for (j = 0; j < sriov_info->num_vfs; j++) {
+			vf_fid = sriov_info->start_vf_func_id + j;
+			queue_info = &queue_mgt->queue_info[vf_fid];
+			if (queue_info->num_txrx_queues) {
+				nbl_res_aq_chan_notify_link_state_req(res_mgt,
+								      vf_fid,
+								      state,
+								      speed);
+			}
+		}
+	}
+}
+
+static void nbl_res_aq_eth_task(struct work_struct *work)
+{
+	struct nbl_adminq_mgt *adminq_mgt =
+		container_of(work, struct nbl_adminq_mgt, eth_task);
+	struct nbl_resource_mgt *res_mgt = adminq_mgt->res_mgt;
+	struct nbl_eth_info *eth_info = NBL_RES_MGT_TO_ETH_INFO(res_mgt);
+	u8 eth_id = 0;
+	u8 max_rate = 0;
+	u8 link_state;
+
+	for (eth_id = 0; eth_id < NBL_MAX_ETHERNET; eth_id++) {
+		if (adminq_mgt->module_inplace_changed[eth_id]) {
+			/* module not-inplace, transitions to inplace status */
+			/* read module register */
+			max_rate =
+				nbl_res_aq_get_module_bitrate(res_mgt, eth_id);
+
+			eth_info->port_max_rate[eth_id] = max_rate;
+			eth_info->port_type[eth_id] =
+				nbl_res_aq_get_port_type(res_mgt, eth_id);
+			eth_info->module_repluged[eth_id] = 1;
+			/* cooper support auto-negotiation */
+			if (eth_info->port_type[eth_id] == NBL_PORT_TYPE_COPPER)
+				eth_info->port_caps[eth_id] |=
+					BIT(NBL_PORT_CAP_AUTONEG);
+			else
+				eth_info->port_caps[eth_id] &=
+					~BIT_MASK(NBL_PORT_CAP_AUTONEG);
+
+			adminq_mgt->module_inplace_changed[eth_id] = 0;
+		}
+
+		mutex_lock(&adminq_mgt->eth_lock);
+		if (adminq_mgt->link_state_changed[eth_id]) {
+			link_state = eth_info->link_state[eth_id];
+			/* eth link state changed, notify pf and vf */
+			nbl_res_aq_notify_link_state(res_mgt, eth_id,
+						     link_state);
+			adminq_mgt->link_state_changed[eth_id] = 0;
+		}
+		mutex_unlock(&adminq_mgt->eth_lock);
+	}
+}
+
+static int nbl_res_aq_setup_cmd_filter(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_adminq_mgt *adminq_mgt = NBL_RES_MGT_TO_ADMINQ_MGT(res_mgt);
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct nbl_hash_tbl_key tbl_key = { 0 };
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
+static void nbl_res_aq_remove_cmd_filter(struct nbl_resource_mgt *res_mgt)
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
+	struct nbl_adminq_mgt **adminq_mgt =
+		&NBL_RES_MGT_TO_ADMINQ_MGT(res_mgt);
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	int ret;
+
+	ret = nbl_adminq_setup_mgt(dev, adminq_mgt);
+	if (ret)
+		goto setup_mgt_fail;
+
+	(*adminq_mgt)->res_mgt = res_mgt;
+
+	(*adminq_mgt)->fw_last_hb_seq =
+		(u32)hw_ops->get_fw_pong(NBL_RES_MGT_TO_HW_PRIV(res_mgt));
+
+	INIT_WORK(&(*adminq_mgt)->eth_task, nbl_res_aq_eth_task);
+	mutex_init(&(*adminq_mgt)->eth_lock);
+
+	ret = nbl_res_aq_setup_cmd_filter(res_mgt);
+	if (ret)
+		goto set_filter_fail;
+
+	nbl_res_aq_add_cmd_filter_res_write(res_mgt);
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
+	struct nbl_adminq_mgt **adminq_mgt =
+		&NBL_RES_MGT_TO_ADMINQ_MGT(res_mgt);
+
+	if (!(*adminq_mgt))
+		return;
+
+	nbl_res_aq_remove_cmd_filter(res_mgt);
+
+	cancel_work_sync(&((*adminq_mgt)->eth_task));
+	nbl_adminq_remove_mgt(dev, adminq_mgt);
+}
+
+int nbl_adminq_setup_ops(struct nbl_resource_ops *res_ops)
+{
+#define NBL_ADMINQ_SET_OPS(name, func)		\
+	do {					\
+		res_ops->NBL_NAME(name) = func; \
+		;				\
+	} while (0)
+	NBL_ADMINQ_OPS_TBL;
+#undef NBL_ADMINQ_SET_OPS
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
index cc792497d01f..4ee35f46c785 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -4,19 +4,1632 @@
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
-	struct nbl_hw_mgt *hw_mgt = priv;
-	u32 quirks;
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
+
+static void nbl_configure_dped_checksum(struct nbl_hw_mgt *hw_mgt)
+{
+	union dped_l4_ck_cmd_40_u l4_ck_cmd_40;
+
+	/* DPED dped_l4_ck_cmd_40 for sctp */
+	nbl_hw_rd_regs(hw_mgt, NBL_DPED_L4_CK_CMD_40_ADDR, (u8 *)&l4_ck_cmd_40,
+		       sizeof(l4_ck_cmd_40));
+	l4_ck_cmd_40.info.en = 1;
+	nbl_hw_wr_regs(hw_mgt, NBL_DPED_L4_CK_CMD_40_ADDR, (u8 *)&l4_ck_cmd_40,
+		       sizeof(l4_ck_cmd_40));
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
+	nbl_hw_rd_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(5), (u8 *)&hw_edit,
+		       sizeof(hw_edit));
+	hw_edit.l3_len = 0;
+	nbl_hw_wr_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(5), (u8 *)&hw_edit,
+		       sizeof(hw_edit));
+
+	nbl_hw_rd_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(6), (u8 *)&hw_edit,
+		       sizeof(hw_edit));
+	hw_edit.l3_len = 1;
+	nbl_hw_wr_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(6), (u8 *)&hw_edit,
+		       sizeof(hw_edit));
+
+	return 0;
+}
+
+static void nbl_shaping_eth_init(struct nbl_hw_mgt *hw_mgt, u8 eth_id, u8 speed)
+{
+	struct nbl_shaping_dport dport = { 0 };
+	struct nbl_shaping_dvn_dport dvn_dport = { 0 };
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
+	nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_DPORT_REG(eth_id), (u8 *)&dport,
+		       sizeof(dport));
+	nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_DVN_DPORT_REG(eth_id),
+		       (u8 *)&dvn_dport, sizeof(dvn_dport));
+}
+
+static int nbl_shaping_init(struct nbl_hw_mgt *hw_mgt, u8 speed)
+{
+	struct dsch_psha_en psha_en = { 0 };
+	struct nbl_shaping_net net_shaping = { 0 };
+
+	int i;
+
+	for (i = 0; i < NBL_MAX_ETHERNET; i++)
+		nbl_shaping_eth_init(hw_mgt, i, speed);
+
+	psha_en.en = 0xF;
+	nbl_hw_wr_regs(hw_mgt, NBL_DSCH_PSHA_EN_ADDR, (u8 *)&psha_en,
+		       sizeof(psha_en));
+
+	for (i = 0; i < NBL_MAX_FUNC; i++)
+		nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_NET_REG(i),
+			       (u8 *)&net_shaping, sizeof(net_shaping));
+	return 0;
+}
+
+static int nbl_dsch_qid_max_init(struct nbl_hw_mgt *hw_mgt)
+{
+	struct dsch_vn_quanta quanta = { 0 };
+
+	quanta.h_qua = NBL_HOST_QUANTA;
+	quanta.e_qua = NBL_ECPU_QUANTA;
+	nbl_hw_wr_regs(hw_mgt, NBL_DSCH_VN_QUANTA_ADDR, (u8 *)&quanta,
+		       sizeof(quanta));
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
+	nbl_hw_rd_regs(hw_mgt, NBL_USTORE_PKT_LEN_ADDR, (u8 *)&pkt_len,
+		       sizeof(pkt_len));
+	/* min arp packet length 42 (14 + 28) */
+	pkt_len.min = 42;
+	nbl_hw_wr_regs(hw_mgt, NBL_USTORE_PKT_LEN_ADDR, (u8 *)&pkt_len,
+		       sizeof(pkt_len));
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
+		nbl_hw_wr_regs(hw_mgt, NBL_USTORE_PORT_DROP_TH_REG_ARR(i),
+			       (u8 *)&drop_th, sizeof(drop_th));
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
+		nbl_hw_rd_regs(hw_mgt, NBL_DSTORE_PORT_DROP_TH_REG(i),
+			       (u8 *)&drop_th, sizeof(drop_th));
+		drop_th.en = 0;
+		nbl_hw_wr_regs(hw_mgt, NBL_DSTORE_PORT_DROP_TH_REG(i),
+			       (u8 *)&drop_th, sizeof(drop_th));
+	}
+
+	nbl_hw_rd_regs(hw_mgt, NBL_DSTORE_DISC_BP_TH, (u8 *)&bp_th,
+		       sizeof(bp_th));
+	bp_th.en = 1;
+	nbl_hw_wr_regs(hw_mgt, NBL_DSTORE_DISC_BP_TH, (u8 *)&bp_th,
+		       sizeof(bp_th));
+
+	for (i = 0; i < 4; i++) {
+		nbl_hw_rd_regs(hw_mgt, NBL_DSTORE_D_DPORT_FC_TH_REG(i),
+			       (u8 *)&fc_th, sizeof(fc_th));
+		if (speed == NBL_FW_PORT_SPEED_100G) {
+			fc_th.xoff_th = NBL_DSTORE_DROP_XOFF_TH_100G;
+			fc_th.xon_th = NBL_DSTORE_DROP_XON_TH_100G;
+		} else {
+			fc_th.xoff_th = NBL_DSTORE_DROP_XOFF_TH;
+			fc_th.xon_th = NBL_DSTORE_DROP_XON_TH;
+		}
+
+		fc_th.fc_en = 1;
+		nbl_hw_wr_regs(hw_mgt, NBL_DSTORE_D_DPORT_FC_TH_REG(i),
+			       (u8 *)&fc_th, sizeof(fc_th));
+	}
+
+	return 0;
+}
+
+static int nbl_ul4s_init(struct nbl_hw_mgt *hw_mgt)
+{
+	struct ul4s_sch_pad sch_pad;
+
+	nbl_hw_rd_regs(hw_mgt, NBL_UL4S_SCH_PAD_ADDR, (u8 *)&sch_pad,
+		       sizeof(sch_pad));
+	sch_pad.en = 1;
+	nbl_hw_wr_regs(hw_mgt, NBL_UL4S_SCH_PAD_ADDR, (u8 *)&sch_pad,
+		       sizeof(sch_pad));
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
+	packet_ring_prefect_num =
+		packet_ring_prefect_num > 32 ? 32 : packet_ring_prefect_num;
+	packet_ring_prefect_num =
+		packet_ring_prefect_num < 8 ? 8 : packet_ring_prefect_num;
+	descreq_num_cfg.packed_l1_num = (packet_ring_prefect_num - 8) / 4;
+
+	split_ring_prefect_num =
+		split_ring_prefect_num > 16 ? 16 : split_ring_prefect_num;
+	split_ring_prefect_num =
+		split_ring_prefect_num < 8 ? 8 : split_ring_prefect_num;
+	descreq_num_cfg.avring_cfg_num = split_ring_prefect_num > 8 ? 1 : 0;
+
+	nbl_hw_wr_regs(hw_mgt, NBL_DVN_DESCREQ_NUM_CFG, (u8 *)&descreq_num_cfg,
+		       sizeof(descreq_num_cfg));
+}
+
+static int nbl_dvn_init(struct nbl_hw_mgt *hw_mgt, u8 speed)
+{
+	struct nbl_dvn_desc_wr_merge_timeout timeout = { 0 };
+	struct nbl_dvn_dif_req_rd_ro_flag ro_flag = { 0 };
+
+	timeout.cfg_cycle = DEFAULT_DVN_DESC_WR_MERGE_TIMEOUT_MAX;
+	nbl_hw_wr_regs(hw_mgt, NBL_DVN_DESC_WR_MERGE_TIMEOUT, (u8 *)&timeout,
+		       sizeof(timeout));
+
+	ro_flag.rd_desc_ro_en = 1;
+	ro_flag.rd_data_ro_en = 1;
+	ro_flag.rd_avring_ro_en = 1;
+	nbl_hw_wr_regs(hw_mgt, NBL_DVN_DIF_REQ_RD_RO_FLAG, (u8 *)&ro_flag,
+		       sizeof(ro_flag));
+
+	if (speed == NBL_FW_PORT_SPEED_100G)
+		nbl_dvn_descreq_num_cfg(hw_mgt,
+					DEFAULT_DVN_100G_DESCREQ_NUMCFG);
+	else
+		nbl_dvn_descreq_num_cfg(hw_mgt, DEFAULT_DVN_DESCREQ_NUMCFG);
+
+	return 0;
+}
+
+static int nbl_uvn_init(struct nbl_hw_mgt *hw_mgt)
+{
+	struct uvn_desc_prefetch_init prefetch_init = { 0 };
+	struct uvn_desc_wr_timeout desc_wr_timeout = { 0 };
+	struct uvn_queue_err_mask mask = { 0 };
+	struct uvn_dif_req_ro_flag flag = { 0 };
+	u32 timeout = 119760; /* 200us 200000/1.67 */
+	u16 wr_timeout = 0x12c;
+	u32 quirks;
+
+	nbl_hw_wr32(hw_mgt, NBL_UVN_DESC_RD_WAIT, timeout);
+
+	desc_wr_timeout.num = wr_timeout;
+	nbl_hw_wr_regs(hw_mgt, NBL_UVN_DESC_WR_TIMEOUT, (u8 *)&desc_wr_timeout,
+		       sizeof(desc_wr_timeout));
+
+	flag.avail_rd = 1;
+	flag.desc_rd = 1;
+	flag.pkt_wr = 1;
+	flag.desc_wr = 0;
+	nbl_hw_wr_regs(hw_mgt, NBL_UVN_DIF_REQ_RO_FLAG, (u8 *)&flag,
+		       sizeof(flag));
+
+	nbl_hw_rd_regs(hw_mgt, NBL_UVN_QUEUE_ERR_MASK, (u8 *)&mask,
+		       sizeof(mask));
+	mask.dif_err = 1;
+	nbl_hw_wr_regs(hw_mgt, NBL_UVN_QUEUE_ERR_MASK, (u8 *)&mask,
+		       sizeof(mask));
+
+	prefetch_init.num = NBL_UVN_DESC_PREFETCH_NUM;
+	prefetch_init.sel = 0;
+
+	quirks = nbl_hw_get_quirks(hw_mgt);
+
+	if (!(quirks & BIT(NBL_QUIRKS_UVN_PREFETCH_ALIGN)))
+		prefetch_init.sel = 1;
+
+	nbl_hw_wr_regs(hw_mgt, NBL_UVN_DESC_PREFETCH_INIT, (u8 *)&prefetch_init,
+		       sizeof(prefetch_init));
+
+	return 0;
+}
+
+static int nbl_uqm_init(struct nbl_hw_mgt *hw_mgt)
+{
+	struct nbl_uqm_que_type que_type = { 0 };
+	u32 cnt = 0;
+	int i;
+
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_FWD_DROP_CNT, (u8 *)&cnt, sizeof(cnt));
+
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_DROP_PKT_CNT, (u8 *)&cnt, sizeof(cnt));
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_DROP_PKT_SLICE_CNT, (u8 *)&cnt,
+		       sizeof(cnt));
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_DROP_PKT_LEN_ADD_CNT, (u8 *)&cnt,
+		       sizeof(cnt));
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_DROP_HEAD_PNTR_ADD_CNT, (u8 *)&cnt,
+		       sizeof(cnt));
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_DROP_WEIGHT_ADD_CNT, (u8 *)&cnt,
+		       sizeof(cnt));
+
+	for (i = 0; i < NBL_UQM_PORT_DROP_DEPTH; i++) {
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_UQM_PORT_DROP_PKT_CNT + (sizeof(cnt) * i),
+			       (u8 *)&cnt, sizeof(cnt));
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_UQM_PORT_DROP_PKT_SLICE_CNT +
+				       (sizeof(cnt) * i),
+			       (u8 *)&cnt, sizeof(cnt));
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_UQM_PORT_DROP_PKT_LEN_ADD_CNT +
+				       (sizeof(cnt) * i),
+			       (u8 *)&cnt, sizeof(cnt));
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_UQM_PORT_DROP_HEAD_PNTR_ADD_CNT +
+				       (sizeof(cnt) * i),
+			       (u8 *)&cnt, sizeof(cnt));
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_UQM_PORT_DROP_WEIGHT_ADD_CNT +
+				       (sizeof(cnt) * i),
+			       (u8 *)&cnt, sizeof(cnt));
+	}
+
+	for (i = 0; i < NBL_UQM_DPORT_DROP_DEPTH; i++)
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_UQM_DPORT_DROP_CNT + (sizeof(cnt) * i),
+			       (u8 *)&cnt, sizeof(cnt));
+
+	que_type.bp_drop = 0;
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_QUE_TYPE, (u8 *)&que_type,
+		       sizeof(que_type));
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
+static struct nbl_epro_action_filter_tbl
+	epro_action_filter_tbl[NBL_FWD_TYPE_MAX] = {
+		[NBL_FWD_TYPE_NORMAL] = { BIT(NBL_MD_ACTION_MCIDX) |
+					  BIT(NBL_MD_ACTION_TABLE_INDEX) |
+					  BIT(NBL_MD_ACTION_MIRRIDX) },
+		[NBL_FWD_TYPE_CPU_ASSIGNED] = { BIT(NBL_MD_ACTION_MCIDX) |
+						BIT(NBL_MD_ACTION_TABLE_INDEX) |
+						BIT(NBL_MD_ACTION_MIRRIDX) },
+		[NBL_FWD_TYPE_UPCALL] = { 0 },
+		[NBL_FWD_TYPE_SRC_MIRROR] = { BIT(NBL_MD_ACTION_FLOWID0) |
+					      BIT(NBL_MD_ACTION_FLOWID1) |
+					      BIT(NBL_MD_ACTION_RSSIDX) |
+					      BIT(NBL_MD_ACTION_TABLE_INDEX) |
+					      BIT(NBL_MD_ACTION_MCIDX) |
+					      BIT(NBL_MD_ACTION_VNI0) |
+					      BIT(NBL_MD_ACTION_VNI1) |
+					      BIT(NBL_MD_ACTION_PRBAC_IDX) |
+					      BIT(NBL_MD_ACTION_L4S_IDX) |
+					      BIT(NBL_MD_ACTION_DP_HASH0) |
+					      BIT(NBL_MD_ACTION_DP_HASH1) |
+					      BIT(NBL_MD_ACTION_MDF_PRI) |
+					      BIT(NBL_MD_ACTION_FLOW_CARIDX) |
+					      ((u64)0xffffffff << 32) },
+		[NBL_FWD_TYPE_OTHER_MIRROR] = { BIT(NBL_MD_ACTION_FLOWID0) |
+						BIT(NBL_MD_ACTION_FLOWID1) |
+						BIT(NBL_MD_ACTION_RSSIDX) |
+						BIT(NBL_MD_ACTION_TABLE_INDEX) |
+						BIT(NBL_MD_ACTION_MCIDX) |
+						BIT(NBL_MD_ACTION_VNI0) |
+						BIT(NBL_MD_ACTION_VNI1) |
+						BIT(NBL_MD_ACTION_PRBAC_IDX) |
+						BIT(NBL_MD_ACTION_L4S_IDX) |
+						BIT(NBL_MD_ACTION_DP_HASH0) |
+						BIT(NBL_MD_ACTION_DP_HASH1) |
+						BIT(NBL_MD_ACTION_MDF_PRI) },
+		[NBL_FWD_TYPE_MNG] = { 0 },
+		[NBL_FWD_TYPE_GLB_LB] = { 0 },
+		[NBL_FWD_TYPE_DROP] = { 0 },
+	};
+
+static void nbl_epro_action_filter_cfg(struct nbl_hw_mgt *hw_mgt, u32 fwd_type,
+				       struct nbl_epro_action_filter_tbl *cfg)
+{
+	if (fwd_type >= NBL_FWD_TYPE_MAX) {
+		pr_err("fwd_type %u exceed the max num %u.", fwd_type,
+		       NBL_FWD_TYPE_MAX);
+		return;
+	}
+
+	nbl_hw_wr_regs(hw_mgt, NBL_EPRO_ACTION_FILTER_TABLE(fwd_type),
+		       (u8 *)cfg, sizeof(*cfg));
+}
+
+static int nbl_epro_init(struct nbl_hw_mgt *hw_mgt)
+{
+	u32 fwd_type = 0;
+
+	for (fwd_type = 0; fwd_type < NBL_FWD_TYPE_MAX; fwd_type++)
+		nbl_epro_action_filter_cfg(hw_mgt, fwd_type,
+					   &epro_action_filter_tbl[fwd_type]);
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
+	status = (status & ~(1 << NBL_DRIVER_STATUS_BIT)) |
+		 (active << NBL_DRIVER_STATUS_BIT);
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
+	nbl_debug(NBL_HW_MGT_TO_COMMON(hw_mgt), "hw_chip_init");
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
+static int nbl_hw_get_tx_queue_cfg(void *priv, void *data, u16 queue_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_queue_cfg_param *queue_cfg =
+		(struct nbl_queue_cfg_param *)data;
+	struct dvn_queue_table info = { 0 };
 
-	nbl_hw_read_mbx_regs(hw_mgt, NBL_LEONIS_QUIRKS_OFFSET, (u8 *)&quirks,
-			     sizeof(u32));
+	nbl_hw_rd_regs(hw_mgt, NBL_DVN_QUEUE_TABLE_ARR(queue_id), (u8 *)&info,
+		       sizeof(info));
 
-	if (quirks == NBL_LEONIS_ILLEGAL_REG_VALUE)
-		return 0;
+	queue_cfg->desc = info.dvn_queue_baddr;
+	queue_cfg->avail = info.dvn_avail_baddr;
+	queue_cfg->used = info.dvn_used_baddr;
+	queue_cfg->size = info.dvn_queue_size;
+	queue_cfg->split = info.dvn_queue_type;
+	queue_cfg->extend_header = info.dvn_extend_header_en;
 
-	return quirks;
+	return 0;
+}
+
+static int nbl_hw_get_rx_queue_cfg(void *priv, void *data, u16 queue_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_queue_cfg_param *queue_cfg =
+		(struct nbl_queue_cfg_param *)data;
+	struct uvn_queue_table info = { 0 };
+
+	nbl_hw_rd_regs(hw_mgt, NBL_UVN_QUEUE_TABLE_ARR(queue_id), (u8 *)&info,
+		       sizeof(info));
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
+static bool nbl_hw_check_q2tc(void *priv, u16 queue_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct dsch_vn_q2tc_cfg_tbl info;
+
+	nbl_hw_rd_regs(hw_mgt, NBL_DSCH_VN_Q2TC_CFG_TABLE_REG_ARR(queue_id),
+		       (u8 *)&info, sizeof(info));
+	return info.vld;
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
+static int nbl_hw_set_shaping(void *priv, u16 func_id, u64 total_tx_rate,
+			      u64 burst, u8 vld, bool active)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_shaping_net shaping_net = { 0 };
+	struct dsch_vn_sha2net_map_tbl sha2net = { 0 };
+	struct dsch_vn_net2sha_map_tbl net2sha = { 0 };
+
+	if (vld) {
+		sha2net.vld = active;
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_DSCH_VN_SHA2NET_MAP_TABLE_REG_ARR(func_id),
+			       (u8 *)&sha2net, sizeof(sha2net));
+	} else {
+		net2sha.vld = vld;
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_DSCH_VN_NET2SHA_MAP_TABLE_REG_ARR(func_id),
+			       (u8 *)&net2sha, sizeof(net2sha));
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
+	nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_NET(func_id), (u8 *)&shaping_net,
+		       sizeof(shaping_net));
+
+	if (!vld) {
+		sha2net.vld = vld;
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_DSCH_VN_SHA2NET_MAP_TABLE_REG_ARR(func_id),
+			       (u8 *)&sha2net, sizeof(sha2net));
+	} else {
+		net2sha.vld = active;
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_DSCH_VN_NET2SHA_MAP_TABLE_REG_ARR(func_id),
+			       (u8 *)&net2sha, sizeof(net2sha));
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
+	union ucar_flow_u ucar_flow = { .info = { 0 } };
+	union epro_vpt_u epro_vpt = { .info = { 0 } };
+	int car_id = 0;
+	int index = 0;
+
+	nbl_hw_rd_regs(hw_mgt, NBL_EPRO_VPT_REG(vsi_id), (u8 *)&epro_vpt,
+		       sizeof(epro_vpt));
+	if (vld) {
+		if (epro_vpt.info.car_en) {
+			car_id = epro_vpt.info.car_id;
+		} else {
+			epro_vpt.info.car_en = 1;
+			for (; index < 1024; index++) {
+				nbl_hw_rd_regs(hw_mgt, NBL_UCAR_FLOW_REG(index),
+					       (u8 *)&ucar_flow,
+					       sizeof(ucar_flow));
+				if (ucar_flow.info.valid == 0) {
+					car_id = index;
+					break;
+				}
+			}
+			if (car_id == 1024) {
+				nbl_err(common,
+					"Car ID exceeds the valid range!");
+				return -ENOMEM;
+			}
+			epro_vpt.info.car_id = car_id;
+			nbl_hw_wr_regs(hw_mgt, NBL_EPRO_VPT_REG(vsi_id),
+				       (u8 *)&epro_vpt, sizeof(epro_vpt));
+		}
+	} else {
+		epro_vpt.info.car_en = 0;
+		car_id = epro_vpt.info.car_id;
+		epro_vpt.info.car_id = 0;
+		nbl_hw_wr_regs(hw_mgt, NBL_EPRO_VPT_REG(vsi_id),
+			       (u8 *)&epro_vpt, sizeof(epro_vpt));
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
+	nbl_hw_wr_regs(hw_mgt, NBL_UCAR_FLOW_REG(car_id), (u8 *)&ucar_flow,
+		       sizeof(ucar_flow));
+
+	return 0;
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
 }
 
 static void nbl_hw_enable_mailbox_irq(void *priv, u16 func_id, bool enable_msix,
@@ -361,6 +1974,25 @@ static void nbl_hw_cfg_mailbox_qinfo(void *priv, u16 func_id, u16 bus,
 		       (u8 *)&mb_qinfo_map, sizeof(mb_qinfo_map));
 }
 
+static void nbl_hw_set_promisc_mode(void *priv, u16 vsi_id, u16 eth_id,
+				    u16 mode)
+{
+	struct nbl_ipro_upsport_tbl upsport;
+
+	nbl_hw_rd_regs(priv, NBL_IPRO_UP_SPORT_TABLE(eth_id), (u8 *)&upsport,
+		       sizeof(upsport));
+	if (mode) {
+		upsport.set_dport.dport.up.upcall_flag = AUX_FWD_TYPE_NML_FWD;
+		upsport.set_dport.dport.up.port_type = SET_DPORT_TYPE_VSI_HOST;
+		upsport.set_dport.dport.up.port_id = vsi_id;
+		upsport.set_dport.dport.up.next_stg_sel = NEXT_STG_SEL_NONE;
+	} else {
+		upsport.set_dport.data = 0xFFF;
+	}
+	nbl_hw_wr_regs(priv, NBL_IPRO_UP_SPORT_TABLE(eth_id), (u8 *)&upsport,
+		       sizeof(upsport));
+}
+
 static void nbl_hw_set_coalesce(void *priv, u16 interrupt_id, u16 pnum,
 				u16 rate)
 {
@@ -437,7 +2069,7 @@ static void nbl_hw_cfg_adminq_qinfo(void *priv, u16 bus, u16 devid,
 				    u16 function)
 {
 	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
-	struct nbl_adminq_qinfo_map_table adminq_qinfo_map = {0};
+	struct nbl_adminq_qinfo_map_table adminq_qinfo_map = { 0 };
 
 	memset(&adminq_qinfo_map, 0, sizeof(adminq_qinfo_map));
 	adminq_qinfo_map.function = function;
@@ -699,6 +2331,20 @@ nbl_hw_process_abnormal_event(void *priv,
 	return ret;
 }
 
+static u32 nbl_hw_get_uvn_desc_entry_stats(void *priv)
+{
+	return nbl_hw_rd32(priv, NBL_UVN_DESC_RD_ENTRY);
+}
+
+static void nbl_hw_set_uvn_desc_wr_timeout(void *priv, u16 timeout)
+{
+	struct uvn_desc_wr_timeout wr_timeout = { 0 };
+
+	wr_timeout.num = timeout;
+	nbl_hw_wr_regs(priv, NBL_UVN_DESC_WR_TIMEOUT, (u8 *)&wr_timeout,
+		       sizeof(wr_timeout));
+}
+
 static void nbl_hw_get_board_info(void *priv,
 				  struct nbl_board_port_info *board_info)
 {
@@ -747,6 +2393,44 @@ static enum nbl_hw_status nbl_hw_get_hw_status(void *priv)
 };
 
 static struct nbl_hw_ops hw_ops = {
+	.init_chip_module = nbl_hw_init_chip_module,
+	.deinit_chip_module = nbl_hw_deinit_chip_module,
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
+	.get_tx_queue_cfg = nbl_hw_get_tx_queue_cfg,
+	.get_rx_queue_cfg = nbl_hw_get_rx_queue_cfg,
+	.cfg_tx_queue = nbl_hw_cfg_tx_queue,
+	.cfg_rx_queue = nbl_hw_cfg_rx_queue,
+	.check_q2tc = nbl_hw_check_q2tc,
+	.cfg_q2tc_netid = nbl_hw_cfg_q2tc_netid,
+	.active_shaping = nbl_hw_active_shaping,
+	.deactive_shaping = nbl_hw_deactive_shaping,
+	.set_shaping = nbl_hw_set_shaping,
+	.set_ucar = nbl_hw_set_ucar,
+	.cfg_dsch_net_to_group = nbl_hw_cfg_dsch_net_to_group,
+	.init_epro_rss_key = nbl_hw_init_epro_rss_key,
+	.init_epro_vpt_tbl = nbl_hw_init_epro_vpt_tbl,
+	.cfg_epro_rss_ret = nbl_hw_cfg_epro_rss_ret,
+	.set_epro_rss_pt = nbl_hw_set_epro_rss_pt,
+	.clear_epro_rss_pt = nbl_hw_clear_epro_rss_pt,
+	.set_promisc_mode = nbl_hw_set_promisc_mode,
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
 	.set_coalesce = nbl_hw_set_coalesce,
@@ -781,7 +2465,10 @@ static struct nbl_hw_ops hw_ops = {
 	.set_fw_ping = nbl_hw_set_fw_ping,
 	.get_fw_pong = nbl_hw_get_fw_pong,
 	.set_fw_pong = nbl_hw_set_fw_pong,
+
 	.process_abnormal_event = nbl_hw_process_abnormal_event,
+	.get_uvn_desc_entry_stats = nbl_hw_get_uvn_desc_entry_stats,
+	.set_uvn_desc_wr_timeout = nbl_hw_set_uvn_desc_wr_timeout,
 	.get_fw_eth_num = nbl_hw_get_fw_eth_num,
 	.get_fw_eth_map = nbl_hw_get_fw_eth_map,
 	.get_board_info = nbl_hw_get_board_info,
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_queue_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_queue_leonis.c
new file mode 100644
index 000000000000..a4a70d9b8f74
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_queue_leonis.c
@@ -0,0 +1,1430 @@
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
+static int nbl_res_queue_reset_uvn_pkt_drop_stats(void *priv, u16 func_id,
+						  u16 global_queue_id);
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
+		nbl_res_queue_reset_uvn_pkt_drop_stats(res_mgt, func_id,
+						       global_qid);
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
+		nbl_res_queue_reset_uvn_pkt_drop_stats(res_mgt, func_id,
+						       global_queue);
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
+	struct nbl_sriov_info *sriov_info =
+		&NBL_RES_MGT_TO_SRIOV_INFO(res_mgt)[func_id];
+	void *p = NBL_RES_MGT_TO_HW_PRIV(res_mgt);
+	int pfid, vfid;
+	u16 vsi_id, vf_vsi_id;
+	u16 i;
+
+	vsi_id = nbl_res_func_id_to_vsi_id(res_mgt, func_id,
+					   NBL_VSI_SERV_PF_DATA_TYPE);
+	nbl_res_func_id_to_pfvfid(res_mgt, func_id, &pfid, &vfid);
+
+	if (sriov_info->bdf != 0) {
+		/* init pf vsi */
+		for (i = NBL_VSI_SERV_PF_DATA_TYPE;
+		     i <= NBL_VSI_SERV_PF_USER_TYPE; i++) {
+			vsi_id = nbl_res_func_id_to_vsi_id(res_mgt, func_id, i);
+			hw_ops->init_epro_vpt_tbl(p, vsi_id);
+		}
+
+		for (vfid = 0; vfid < sriov_info->num_vfs; vfid++) {
+			vf_vsi_id = nbl_res_pfvfid_to_vsi_id(res_mgt, pfid,
+							     vfid,
+							     NBL_VSI_DATA);
+			if (vf_vsi_id == 0xFFFF)
+				continue;
+
+			hw_ops->init_epro_vpt_tbl(p, vf_vsi_id);
+		}
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
+	struct nbl_sriov_info *sriov_info =
+		&NBL_RES_MGT_TO_SRIOV_INFO(res_mgt)[func_id];
+	void *p = NBL_RES_MGT_TO_HW_PRIV(res_mgt);
+	int pfid, vfid;
+	u16 eth_id, vsi_id, vf_vsi_id;
+	int i;
+
+	vsi_id = nbl_res_func_id_to_vsi_id(res_mgt, func_id,
+					   NBL_VSI_SERV_PF_DATA_TYPE);
+	nbl_res_func_id_to_pfvfid(res_mgt, func_id, &pfid, &vfid);
+
+	if (sriov_info->bdf != 0) {
+		eth_id = nbl_res_vsi_id_to_eth_id(res_mgt, vsi_id);
+
+		for (i = 0; i < NBL_VSI_MAX; i++)
+			hw_ops->cfg_ipro_dn_sport_tbl(p, vsi_id + i, eth_id,
+						      bmode, binit);
+
+		for (vfid = 0; vfid < sriov_info->num_vfs; vfid++) {
+			vf_vsi_id = nbl_res_pfvfid_to_vsi_id(res_mgt, pfid,
+							     vfid,
+							     NBL_VSI_DATA);
+			if (vf_vsi_id == 0xFFFF)
+				continue;
+
+			hw_ops->cfg_ipro_dn_sport_tbl(p, vf_vsi_id, eth_id,
+						      bmode, binit);
+		}
+	}
+
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
+static u16 nbl_res_queue_get_local_queue_id(void *priv, u16 vsi_id,
+					    u16 global_queue_id)
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
+static u16 nbl_get_adapt_desc_gother_level(u16 last_level, u64 rates)
+{
+	switch (last_level) {
+	case NBL_ADAPT_DESC_GOTHER_L0:
+		if (rates > NBL_ADAPT_DESC_GOTHER_L1_TH)
+			return NBL_ADAPT_DESC_GOTHER_L1;
+		else
+			return NBL_ADAPT_DESC_GOTHER_L0;
+	case NBL_ADAPT_DESC_GOTHER_L1:
+		if (rates > NBL_ADAPT_DESC_GOTHER_L1_DOWNGRADE_TH)
+			return NBL_ADAPT_DESC_GOTHER_L1;
+		else
+			return NBL_ADAPT_DESC_GOTHER_L0;
+	default:
+		return NBL_ADAPT_DESC_GOTHER_L0;
+	}
+}
+
+static u16 nbl_get_adapt_desc_gother_timeout(u16 level)
+{
+	switch (level) {
+	case NBL_ADAPT_DESC_GOTHER_L0:
+		return NBL_ADAPT_DESC_GOTHER_L0_TO;
+	case NBL_ADAPT_DESC_GOTHER_L1:
+		return NBL_ADAPT_DESC_GOTHER_L1_TO;
+	default:
+		return NBL_ADAPT_DESC_GOTHER_L0_TO;
+	}
+}
+
+static void nbl_res_queue_adapt_desc_gother(void *priv)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_adapt_desc_gother *adapt_desc_gother =
+		&queue_mgt->adapt_desc_gother;
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	u32 last_uvn_desc_rd_entry = adapt_desc_gother->uvn_desc_rd_entry;
+	u64 last_get_stats_jiffies = adapt_desc_gother->get_desc_stats_jiffies;
+	void *p = NBL_RES_MGT_TO_HW_PRIV(res_mgt);
+	u64 time_diff;
+	u32 uvn_desc_rd_entry;
+	u32 rx_rate;
+	u16 level, last_level, timeout;
+
+	last_level = adapt_desc_gother->level;
+	time_diff = jiffies - last_get_stats_jiffies;
+	uvn_desc_rd_entry = hw_ops->get_uvn_desc_entry_stats(p);
+	rx_rate = (uvn_desc_rd_entry - last_uvn_desc_rd_entry) / time_diff * HZ;
+	adapt_desc_gother->get_desc_stats_jiffies = jiffies;
+	adapt_desc_gother->uvn_desc_rd_entry = uvn_desc_rd_entry;
+
+	level = nbl_get_adapt_desc_gother_level(last_level, rx_rate);
+	if (level != last_level) {
+		timeout = nbl_get_adapt_desc_gother_timeout(level);
+		hw_ops->set_uvn_desc_wr_timeout(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+						timeout);
+		adapt_desc_gother->level = level;
+	}
+}
+
+static void nbl_res_flr_clear_queues(void *priv, u16 vf_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	u16 func_id = vf_id + NBL_MAX_PF;
+	u16 vsi_id = nbl_res_func_id_to_vsi_id(res_mgt, func_id,
+					       NBL_VSI_SERV_VF_DATA_TYPE);
+
+	if (nbl_res_vf_is_active(priv, func_id))
+		nbl_res_queue_clear_queues(priv, vsi_id);
+}
+
+static int nbl_res_queue_stop_abnormal_hw_queue(void *priv, u16 vsi_id,
+						u16 local_queue_id, int type)
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
+		hw_ops->lso_dsch_drain(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+				       global_queue);
+		hw_ops->disable_dvn(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+				    global_queue);
+
+		hw_ops->reset_dvn_cfg(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+				      global_queue);
+		return 0;
+	case NBL_RX:
+		hw_ops->disable_uvn(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+				    global_queue);
+		hw_ops->rsc_cache_drain(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+					global_queue);
+
+		hw_ops->reset_uvn_cfg(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+				      global_queue);
+		nbl_res_queue_reset_uvn_pkt_drop_stats(res_mgt, func_id,
+						       global_queue);
+		return 0;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int nbl_res_queue_set_tx_rate(void *priv, u16 func_id, int tx_rate,
+				     int burst)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_resource_info *res_info = NBL_RES_MGT_TO_RES_INFO(res_mgt);
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_queue_info *queue_info = &queue_mgt->queue_info[func_id];
+	struct nbl_queue_vsi_info *vsi_info = NULL;
+	void *p = NBL_RES_MGT_TO_HW_PRIV(res_mgt);
+	u16 vsi_id, queue_id;
+	bool is_active = false;
+	int max_rate = 0, i;
+
+	vsi_id = nbl_res_func_id_to_vsi_id(res_mgt, func_id,
+					   NBL_VSI_SERV_VF_DATA_TYPE);
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
+			queue_id =
+				queue_info->txrx_queues[i +
+							vsi_info->queue_offset];
+			is_active |= hw_ops->check_q2tc(p, queue_id);
+		}
+
+	/* Config shaping */
+	return hw_ops->set_shaping(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+				   vsi_info->net_id, tx_rate, burst,
+				   !!(tx_rate), is_active);
+}
+
+static int nbl_res_queue_set_rx_rate(void *priv, u16 func_id, int rx_rate,
+				     int burst)
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
+	return hw_ops->set_ucar(NBL_RES_MGT_TO_HW_PRIV(res_mgt), vsi_id,
+				rx_rate, burst, !!(rx_rate));
+}
+
+static void nbl_res_queue_get_active_func_bitmaps(void *priv,
+						  unsigned long *bitmap,
+						  int max_func)
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
+static int nbl_res_queue_reset_uvn_pkt_drop_stats(void *priv, u16 func_id,
+						  u16 global_queue_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_queue_mgt *queue_mgt = NBL_RES_MGT_TO_QUEUE_MGT(res_mgt);
+	struct nbl_queue_info *queue_info = &queue_mgt->queue_info[func_id];
+	u16 vsi_id = nbl_res_func_id_to_vsi_id(res_mgt, func_id,
+					       NBL_VSI_SERV_PF_DATA_TYPE);
+	u16 local_queue_id;
+
+	local_queue_id = nbl_res_queue_get_local_queue_id(res_mgt, vsi_id,
+							  global_queue_id);
+	queue_info->uvn_stat_pkt_drop[local_queue_id] = 0;
+	return 0;
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
+	NBL_QUEUE_SET_OPS(get_vsi_global_queue_id,			\
+			  nbl_res_queue_get_vsi_global_qid);		\
+	NBL_QUEUE_SET_OPS(adapt_desc_gother,				\
+			  nbl_res_queue_adapt_desc_gother);		\
+	NBL_QUEUE_SET_OPS(flr_clear_queues, nbl_res_flr_clear_queues);	\
+	NBL_QUEUE_SET_OPS(get_local_queue_id,				\
+			  nbl_res_queue_get_local_queue_id);		\
+	NBL_QUEUE_SET_OPS(set_tx_rate, nbl_res_queue_set_tx_rate);	\
+	NBL_QUEUE_SET_OPS(set_rx_rate, nbl_res_queue_set_rx_rate);	\
+	NBL_QUEUE_SET_OPS(stop_abnormal_hw_queue,			\
+			  nbl_res_queue_stop_abnormal_hw_queue);	\
+	NBL_QUEUE_SET_OPS(get_active_func_bitmaps,			\
+			  nbl_res_queue_get_active_func_bitmaps);	\
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
index 000000000000..8af3f803b89a
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_queue_leonis.h
@@ -0,0 +1,23 @@
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
+#define NBL_ADAPT_DESC_GOTHER_L1_TH	(1000000) /* 1000k  */
+#define NBL_ADAPT_DESC_GOTHER_L1_DOWNGRADE_TH	(700000) /* 700k */
+#define NBL_ADAPT_DESC_GOTHER_L0		(0)
+#define NBL_ADAPT_DESC_GOTHER_L1		(1)
+
+#define NBL_ADAPT_DESC_GOTHER_L0_TO	(0x12c)
+#define NBL_ADAPT_DESC_GOTHER_L1_TO	(0x960)
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
index b4c6de135a26..161ba88a61c0 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
@@ -488,6 +488,10 @@ static struct nbl_resource_ops res_ops = {
 };
 
 static struct nbl_res_product_ops product_ops = {
+	.queue_mgt_init = nbl_queue_mgt_init_leonis,
+	.setup_qid_map_table = nbl_res_queue_setup_qid_map_table_leonis,
+	.remove_qid_map_table = nbl_res_queue_remove_qid_map_table_leonis,
+	.init_qid_map_table = nbl_res_queue_init_qid_map_table,
 };
 
 static bool is_ops_inited;
@@ -546,7 +550,18 @@ static int nbl_res_setup_ops(struct device *dev,
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
@@ -865,7 +880,10 @@ static void nbl_res_stop(struct nbl_resource_mgt_leonis *res_mgt_leonis)
 {
 	struct nbl_resource_mgt *res_mgt = &res_mgt_leonis->res_mgt;
 
+	nbl_queue_mgt_stop(res_mgt);
 	nbl_intr_mgt_stop(res_mgt);
+	nbl_adminq_mgt_stop(res_mgt);
+	nbl_vsi_mgt_stop(res_mgt);
 	nbl_res_ctrl_dev_ustore_stats_remove(res_mgt);
 	nbl_res_ctrl_dev_remove_vsi_info(res_mgt);
 	nbl_res_ctrl_dev_remove_eth_info(res_mgt);
@@ -918,6 +936,18 @@ static int nbl_res_start(struct nbl_resource_mgt_leonis *res_mgt_leonis,
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
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
index 22205e055100..e1f67ede651a 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
@@ -285,6 +285,14 @@ static u8 eth_id_to_pf_id(void *p, u8 eth_id)
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
 int nbl_res_func_id_to_pfvfid(struct nbl_resource_mgt *res_mgt, u16 func_id,
 			      int *pfid, int *vfid)
 {
@@ -373,6 +381,15 @@ u8 nbl_res_eth_id_to_pf_id(struct nbl_resource_mgt *res_mgt, u8 eth_id)
 	return res_mgt->common_ops.eth_id_to_pf_id(res_mgt, eth_id);
 }
 
+bool nbl_res_check_func_active_by_queue(struct nbl_resource_mgt *res_mgt,
+					u16 func_id)
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
index 5cbe0ebc4f89..de6307d13480 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
@@ -841,6 +841,8 @@ int nbl_res_func_id_to_bdf(struct nbl_resource_mgt *res_mgt, u16 func_id,
 u64 nbl_res_get_func_bar_base_addr(struct nbl_resource_mgt *res_mgt,
 				   u16 func_id);
 u8 nbl_res_vsi_id_to_eth_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id);
+bool nbl_res_check_func_active_by_queue(struct nbl_resource_mgt *res_mgt,
+					u16 func_id);
 
 int nbl_adminq_mgt_start(struct nbl_resource_mgt *res_mgt);
 void nbl_adminq_mgt_stop(struct nbl_resource_mgt *res_mgt);
@@ -849,6 +851,14 @@ int nbl_adminq_setup_ops(struct nbl_resource_ops *resource_ops);
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
 void nbl_res_set_fix_capability(struct nbl_resource_mgt *res_mgt,
 				enum nbl_fix_cap_type cap_type);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.c
new file mode 100644
index 000000000000..84c6b481cfd0
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+#include <linux/etherdevice.h>
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
+	hw_ops->set_promisc_mode(NBL_RES_MGT_TO_HW_PRIV(res_mgt), vsi_id,
+				 eth_id, mode);
+
+	return 0;
+}
+
+static u16 nbl_res_get_vf_function_id(void *priv, u16 vsi_id, int vfid)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	u16 vf_vsi;
+	int pfid = nbl_res_vsi_id_to_pf_id(res_mgt, vsi_id);
+
+	vf_vsi = vfid == -1 ? vsi_id :
+			      nbl_res_pfvfid_to_vsi_id(res_mgt, pfid, vfid,
+						       NBL_VSI_DATA);
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
+	vf_vsi = vfid == -1 ? vsi_id :
+			      nbl_res_pfvfid_to_vsi_id(res_mgt, pfid, vfid,
+						       NBL_VSI_DATA);
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
+	void *p = NBL_RES_MGT_TO_HW_PRIV(res_mgt);
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	u8 eth_speed = res_mgt->resource_info->board_info.eth_speed;
+	u8 eth_num = res_mgt->resource_info->board_info.eth_num;
+
+	int ret = 0;
+
+	if (!res_mgt)
+		return -EINVAL;
+
+	hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	ret = hw_ops->init_chip_module(p, eth_speed, eth_num);
+
+	return ret;
+}
+
+static int nbl_res_vsi_init(void *priv)
+{
+	return 0;
+}
+
+static int nbl_res_get_link_forced(void *priv, u16 vsi_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_resource_info *resource_info =
+		NBL_RES_MGT_TO_RES_INFO(res_mgt);
+	u16 func_id = nbl_res_vsi_id_to_func_id(res_mgt, vsi_id);
+
+	if (func_id >= NBL_MAX_FUNC)
+		return -EINVAL;
+
+	return resource_info->link_forced_info[func_id];
+}
+
+/* NBL_VSI_SET_OPS(ops_name, func)
+ *
+ * Use X Macros to reduce setup and remove codes.
+ */
+#define NBL_VSI_OPS_TBL							\
+do {									\
+	NBL_VSI_SET_OPS(init_chip_module,				\
+			nbl_res_vsi_init_chip_module);			\
+	NBL_VSI_SET_OPS(deinit_chip_module,				\
+			nbl_res_vsi_deinit_chip_module);		\
+	NBL_VSI_SET_OPS(vsi_init, nbl_res_vsi_init);			\
+	NBL_VSI_SET_OPS(set_promisc_mode, nbl_res_set_promisc_mode);	\
+	NBL_VSI_SET_OPS(get_vf_function_id,				\
+			nbl_res_get_vf_function_id);			\
+	NBL_VSI_SET_OPS(get_vf_vsi_id, nbl_res_get_vf_vsi_id);		\
+	NBL_VSI_SET_OPS(get_link_forced, nbl_res_get_link_forced);	\
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
+#define NBL_VSI_SET_OPS(name, func)		\
+	do {					\
+		res_ops->NBL_NAME(name) = func;	\
+		;				\
+	} while (0)
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
index ee4194ab7252..b8f49cc75bc8 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
@@ -10,6 +10,57 @@
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
+	int (*get_tx_queue_cfg)(void *priv, void *data, u16 queue_id);
+	int (*get_rx_queue_cfg)(void *priv, void *data, u16 queue_id);
+	int (*cfg_tx_queue)(void *priv, void *data, u16 queue_id);
+	int (*cfg_rx_queue)(void *priv, void *data, u16 queue_id);
+	bool (*check_q2tc)(void *priv, u16 queue_id);
+	int (*cfg_q2tc_netid)(void *priv, u16 queue_id, u16 netid, u16 vld);
+	int (*set_shaping)(void *priv, u16 func_id, u64 total_tx_rate,
+			   u64 burst, u8 vld, bool active);
+	void (*active_shaping)(void *priv, u16 func_id);
+	void (*deactive_shaping)(void *priv, u16 func_id);
+	int (*set_ucar)(void *priv, u16 func_id, u64 total_tx_rate, u64 burst,
+			u8 vld);
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
@@ -55,6 +106,7 @@ struct nbl_hw_ops {
 	bool (*check_adminq_dma_err)(void *priv, bool tx);
 
 	u8 __iomem *(*get_hw_addr)(void *priv, size_t *size);
+	int (*set_sfp_state)(void *priv, u8 eth_id, u8 state);
 	void (*set_hw_status)(void *priv, enum nbl_hw_status hw_status);
 	enum nbl_hw_status (*get_hw_status)(void *priv);
 	void (*set_fw_ping)(void *priv, u32 ping);
@@ -62,6 +114,9 @@ struct nbl_hw_ops {
 	void (*set_fw_pong)(void *priv, u32 pong);
 	int (*process_abnormal_event)(void *priv,
 				      struct nbl_abnormal_event_info *info);
+	u32 (*get_uvn_desc_entry_stats)(void *priv);
+	void (*set_uvn_desc_wr_timeout)(void *priv, u16 timeout);
+
 	/* for board cfg */
 	u32 (*get_fw_eth_num)(void *priv);
 	u32 (*get_fw_eth_map)(void *priv);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index 134704229116..934612c12fc1 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -64,6 +64,11 @@ enum {
 	NBL_VSI_MAX,
 };
 
+enum {
+	NBL_TX = 0,
+	NBL_RX,
+};
+
 enum nbl_hw_status {
 	NBL_HW_NOMAL,
 	/* Most hw module is not work nomal exclude pcie/emp */
@@ -117,6 +122,15 @@ struct nbl_qid_map_param {
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
@@ -213,6 +227,99 @@ struct nbl_hw_stats {
 	struct nbl_ustore_stats start_ustore_stats;
 };
 
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
+#define NBL_PORT_CAP_AUTONEG_MASK (BIT(NBL_PORT_CAP_AUTONEG))
+#define NBL_PORT_CAP_FEC_MASK						\
+	(BIT(NBL_PORT_CAP_FEC_OFF) | BIT(NBL_PORT_CAP_FEC_RS) |		\
+	 BIT(NBL_PORT_CAP_FEC_BASER))
+#define NBL_PORT_CAP_PAUSE_MASK						\
+	(BIT(NBL_PORT_CAP_TX_PAUSE) | BIT(NBL_PORT_CAP_RX_PAUSE))
+#define NBL_PORT_CAP_SPEED_1G_MASK					\
+	(BIT(NBL_PORT_CAP_1000BASE_T) | BIT(NBL_PORT_CAP_1000BASE_X))
+#define NBL_PORT_CAP_SPEED_10G_MASK					\
+	(BIT(NBL_PORT_CAP_10GBASE_T) | BIT(NBL_PORT_CAP_10GBASE_KR) |	\
+	 BIT(NBL_PORT_CAP_10GBASE_SR))
+#define NBL_PORT_CAP_SPEED_25G_MASK					\
+	(BIT(NBL_PORT_CAP_25GBASE_KR) | BIT(NBL_PORT_CAP_25GBASE_SR) |	\
+	 BIT(NBL_PORT_CAP_25GBASE_CR) | BIT(NBL_PORT_CAP_25G_AUI))
+#define NBL_PORT_CAP_SPEED_50G_MASK					\
+	(BIT(NBL_PORT_CAP_50GBASE_KR2) | BIT(NBL_PORT_CAP_50GBASE_SR2) |\
+	 BIT(NBL_PORT_CAP_50GBASE_CR2) | BIT(NBL_PORT_CAP_50G_AUI2) |	\
+	 BIT(NBL_PORT_CAP_50GBASE_KR_PAM4) |				\
+	 BIT(NBL_PORT_CAP_50GBASE_SR_PAM4) |				\
+	 BIT(NBL_PORT_CAP_50GBASE_CR_PAM4) | BIT(NBL_PORT_CAP_50G_AUI_PAM4))
+#define NBL_PORT_CAP_SPEED_100G_MASK					\
+	(BIT(NBL_PORT_CAP_100GBASE_KR4) | BIT(NBL_PORT_CAP_100GBASE_SR4) |\
+	 BIT(NBL_PORT_CAP_100GBASE_CR4) | BIT(NBL_PORT_CAP_100G_AUI4) |\
+	 BIT(NBL_PORT_CAP_100G_CAUI4) | BIT(NBL_PORT_CAP_100GBASE_KR2_PAM4) |\
+	 BIT(NBL_PORT_CAP_100GBASE_SR2_PAM4) |				\
+	 BIT(NBL_PORT_CAP_100GBASE_CR2_PAM4) |				\
+	 BIT(NBL_PORT_CAP_100G_AUI2_PAM4))
+#define NBL_PORT_CAP_SPEED_MASK						\
+	(NBL_PORT_CAP_SPEED_1G_MASK | NBL_PORT_CAP_SPEED_10G_MASK |	\
+	 NBL_PORT_CAP_SPEED_25G_MASK | NBL_PORT_CAP_SPEED_50G_MASK |	\
+	 NBL_PORT_CAP_SPEED_100G_MASK)
+#define NBL_PORT_CAP_PAM4_MASK						\
+	(BIT(NBL_PORT_CAP_50GBASE_KR_PAM4) |				\
+	 BIT(NBL_PORT_CAP_50GBASE_SR_PAM4) |				\
+	 BIT(NBL_PORT_CAP_50GBASE_CR_PAM4) | BIT(NBL_PORT_CAP_50G_AUI_PAM4) |\
+	 BIT(NBL_PORT_CAP_100GBASE_KR2_PAM4) |				\
+	 BIT(NBL_PORT_CAP_100GBASE_SR2_PAM4) |				\
+	 BIT(NBL_PORT_CAP_100GBASE_CR2_PAM4) |				\
+	 BIT(NBL_PORT_CAP_100G_AUI2_PAM4))
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
@@ -236,6 +343,31 @@ struct nbl_cmd_net_ring_num {
 	u16 net_max_qp_num[NBL_NET_RING_NUM_CMD_LEN];
 };
 
+#define NBL_VF_NUM_CMD_LEN					(8)
+struct nbl_cmd_vf_num {
+	u32 valid;
+	u16 vf_max_num[NBL_VF_NUM_CMD_LEN];
+};
+
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
@@ -298,6 +430,8 @@ struct nbl_ring_param {
 	u16 queue_size;
 };
 
+#define NBL_VSI_MAX_ID 1024
+
 struct nbl_mtu_entry {
 	u32 ref_count;
 	u16 mtu_value;
-- 
2.47.3


