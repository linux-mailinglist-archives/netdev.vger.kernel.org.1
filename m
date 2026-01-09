Return-Path: <netdev+bounces-248431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AA2D086D8
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 11:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F04E304E5D8
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 10:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FA033ADB9;
	Fri,  9 Jan 2026 10:03:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952CF3382D6;
	Fri,  9 Jan 2026 10:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767952982; cv=none; b=I7prr68vvDGt8bmBHuv/K/OQKbQ7euIeySBH0CD8qVeP/WhBT28VViHrJH0eAM8T2ikqn4uPZ/UJeGQ3xTWqYX3YiE8y0IWkTRAHLeA6mIp1aJXTH7eRe966LMctUev6MO1KcQeJCtsl5m270wwp4qA8lMBJk71mmoT1pZTeOFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767952982; c=relaxed/simple;
	bh=/mpNSsL2vGyi8XetwodAYhvH2W6xnrw9P3zHhZ/YmV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hJveZDBWJIpyau25i4czTToUx19Co18srusei6yYin/J1X5Yketc2RnnD8wGVfh0s7fqTCR+AtrEj8+JcdBi61YnnVvXxMO9eGIp5dLXTPOUFIf9jpAE0+pw0qFAOwigWDqNO6o8SnM43D25jlfHjdY7487tq/0ZxQKyQf8mQKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.g2QQAuI_1767952961 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 09 Jan 2026 18:02:42 +0800
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
Subject: [PATCH v2 net-next 11/15] net/nebula-matrix: add Dispatch layer definitions and implementation
Date: Fri,  9 Jan 2026 18:01:29 +0800
Message-ID: <20260109100146.63569-12-illusion.wang@nebula-matrix.com>
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

Two routing ways:
Dispatch Layer-> Resource Layer -> HW layer
The Dispatch Layer routes tasks to Resource Layer, which may interact
with the HW Layer for hardware writes.

Dispatch Layer->Channel Layer
The Dispatch Layers redirects hooks to the Channel Layer.

The primary challenge at the Dispatch layer lies in determining the
routing approach, namely, how to decide which interfaces should directly
invoke the Resource layer's interfaces and which should transmit
requests via channels to the management PF for processing.

To address this, a ctrl_lvl (control level) mechanism is established,
which comprises two parts: the control level declared by each interface
and the control level configured by the upper layer. The effect is that
when the upper layer configures a specific control level, all interfaces
declaring this level will directly call the Resource layer's interfaces;
otherwise, they will send requests via channels.

For instance, consider a regular PF that possesses network (net)
capabilities but lacks control (ctrl) capabilities. It will only
configure NET_LVL at the Dispatch layer. In this scenario, all
interfaces declaring NET_LVL will directly invoke the Resource layer's
interfaces, while those declaring CTRL_LVL will send requests via
channels to the management PF. Conversely, if it is the management PF,
it will configure both NET_LVL and CTRL_LVL at the Dispatch layer.
Consequently, interfaces declaring CTRL_LVL will also directly call the
Resource layer's interfaces without sending requests via channels. This
configuration logic can be dynamic.

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |    1 +
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |    4 +
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c | 4265 +++++++++++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.h |   78 +
 .../nbl/nbl_include/nbl_def_dispatch.h        |  190 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |    7 +
 6 files changed, 4545 insertions(+)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index 7e2aebdad098..dba7bf27be46 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -17,6 +17,7 @@ nbl_core-objs +=       nbl_common/nbl_common.o \
 				nbl_hw/nbl_queue.o \
 				nbl_hw/nbl_vsi.o \
 				nbl_hw/nbl_adminq.o \
+				nbl_core/nbl_dispatch.o \
 				nbl_main.o
 
 # Provide include files
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index eef0e76fb9db..d32a8c4a7519 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -12,6 +12,7 @@
 #include "nbl_def_channel.h"
 #include "nbl_def_hw.h"
 #include "nbl_def_resource.h"
+#include "nbl_def_dispatch.h"
 #include "nbl_def_common.h"
 
 #define NBL_ADAP_TO_PDEV(adapter)		((adapter)->pdev)
@@ -21,9 +22,11 @@
 
 #define NBL_ADAP_TO_HW_MGT(adapter) ((adapter)->core.hw_mgt)
 #define NBL_ADAP_TO_RES_MGT(adapter) ((adapter)->core.res_mgt)
+#define NBL_ADAP_TO_DISP_MGT(adapter) ((adapter)->core.disp_mgt)
 #define NBL_ADAP_TO_CHAN_MGT(adapter) ((adapter)->core.chan_mgt)
 #define NBL_ADAP_TO_HW_OPS_TBL(adapter) ((adapter)->intf.hw_ops_tbl)
 #define NBL_ADAP_TO_RES_OPS_TBL(adapter) ((adapter)->intf.resource_ops_tbl)
+#define NBL_ADAP_TO_DISP_OPS_TBL(adapter) ((adapter)->intf.dispatch_ops_tbl)
 #define NBL_ADAP_TO_CHAN_OPS_TBL(adapter) ((adapter)->intf.channel_ops_tbl)
 
 #define NBL_ADAPTER_TO_RES_PT_OPS(adapter) \
@@ -67,6 +70,7 @@ enum {
 struct nbl_interface {
 	struct nbl_hw_ops_tbl *hw_ops_tbl;
 	struct nbl_resource_ops_tbl *resource_ops_tbl;
+	struct nbl_dispatch_ops_tbl *dispatch_ops_tbl;
 	struct nbl_channel_ops_tbl *channel_ops_tbl;
 };
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
new file mode 100644
index 000000000000..fe8554b0ac16
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
@@ -0,0 +1,4265 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+#include <linux/etherdevice.h>
+#include "nbl_dispatch.h"
+
+static int nbl_disp_chan_add_macvlan_req(void *priv, u8 *mac, u16 vlan, u16 vsi)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_chan_param_add_macvlan param;
+	struct nbl_chan_send_info chan_send;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_common_info *common;
+
+	if (!disp_mgt || !mac)
+		return -EINVAL;
+
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	memcpy(param.mac, mac, sizeof(param.mac));
+	param.vlan = vlan;
+	param.vsi = vsi;
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_ADD_MACVLAN,
+		      &param, sizeof(param), NULL, 0, 1);
+
+	if (chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send))
+		return -EFAULT;
+
+	return 0;
+}
+
+static void nbl_disp_chan_add_macvlan_resp(void *priv, u16 src_id, u16 msg_id,
+					   void *data, u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct device *dev = NBL_COMMON_TO_DEV(disp_mgt->common);
+	struct nbl_chan_param_add_macvlan *param;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	int ret;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	param = (struct nbl_chan_param_add_macvlan *)data;
+
+	ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->add_macvlan, p,
+				    param->mac, param->vlan, param->vsi);
+	if (ret)
+		err = NBL_CHAN_RESP_ERR;
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_ADD_MACVLAN, msg_id, err,
+		     NULL, 0);
+	ret = chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				 &chan_ack);
+	if (ret)
+		dev_err(dev,
+			"channel send ack failed with ret: %d, msg_type: %d\n",
+			ret, NBL_CHAN_MSG_ADD_MACVLAN);
+}
+
+static void nbl_disp_chan_del_macvlan_req(void *priv, u8 *mac, u16 vlan,
+					  u16 vsi)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_param_del_macvlan param;
+	struct nbl_chan_send_info chan_send;
+	struct nbl_common_info *common;
+
+	if (!disp_mgt || !mac)
+		return;
+
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	memcpy(param.mac, mac, sizeof(param.mac));
+	param.vlan = vlan;
+	param.vsi = vsi;
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_DEL_MACVLAN,
+		      &param, sizeof(param), NULL, 0, 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static void nbl_disp_chan_del_macvlan_resp(void *priv, u16 src_id, u16 msg_id,
+					   void *data, u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_chan_param_del_macvlan *param;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+
+	param = (struct nbl_chan_param_del_macvlan *)data;
+
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->del_macvlan, p, param->mac,
+			  param->vlan, param->vsi);
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_DEL_MACVLAN, msg_id, err,
+		     NULL, 0);
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static int nbl_disp_chan_add_multi_rule_req(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_send_info chan_send;
+	struct nbl_common_info *common;
+
+	if (!disp_mgt)
+		return -EINVAL;
+
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_ADD_MULTI_RULE,
+		      &vsi_id, sizeof(vsi_id), NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				  &chan_send);
+}
+
+static void nbl_disp_chan_add_multi_rule_resp(void *priv, u16 src_id,
+					      u16 msg_id, void *data,
+					      u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_ack_info chan_ack;
+	u8 broadcast_mac[ETH_ALEN];
+	int err = NBL_CHAN_RESP_OK;
+	int ret;
+	u16 vsi_id;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+
+	vsi_id = *(u16 *)data;
+	memset(broadcast_mac, 0xFF, ETH_ALEN);
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->add_macvlan, p,
+				    broadcast_mac, 0, vsi_id);
+	if (ret)
+		err = NBL_CHAN_RESP_ERR;
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_ADD_MULTI_RULE, msg_id, err,
+		     NULL, 0);
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static void nbl_disp_chan_del_multi_rule_req(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_send_info chan_send;
+	struct nbl_common_info *common;
+
+	if (!disp_mgt)
+		return;
+
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_DEL_MULTI_RULE,
+		      &vsi_id, sizeof(vsi_id), NULL, 0, 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static void nbl_disp_chan_del_multi_rule_resp(void *priv, u16 src_id,
+					      u16 msg_id, void *data,
+					      u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_ack_info chan_ack;
+	u8 broadcast_mac[ETH_ALEN];
+	int err = NBL_CHAN_RESP_OK;
+	u16 vsi_id;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+
+	vsi_id = *(u16 *)data;
+	memset(broadcast_mac, 0xFF, ETH_ALEN);
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->del_macvlan, p, broadcast_mac, 0,
+			  vsi_id);
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_DEL_MULTI_RULE, msg_id, err,
+		     NULL, 0);
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static int nbl_disp_cfg_multi_mcast(void *priv, u16 vsi, u16 enable)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	int ret = 0;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	if (enable)
+		ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->add_multi_mcast,
+					    p, vsi);
+	else
+		NBL_OPS_CALL_LOCK(disp_mgt, res_ops->del_multi_mcast, p, vsi);
+	return ret;
+}
+
+static int nbl_disp_chan_cfg_multi_mcast_req(void *priv, u16 vsi_id, u16 enable)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_send_info chan_send;
+	struct nbl_common_info *common;
+	struct nbl_chan_param_cfg_multi_mcast mcast;
+
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	mcast.vsi = vsi_id;
+	mcast.enable = enable;
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf,
+		      NBL_CHAN_MSG_CFG_MULTI_MCAST_RULE, &mcast, sizeof(mcast),
+		      NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				  &chan_send);
+}
+
+static void nbl_disp_chan_cfg_multi_mcast_resp(void *priv, u16 src_id,
+					       u16 msg_id, void *data,
+					       u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_param_cfg_multi_mcast *mcast;
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	int ret = 0;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+
+	mcast = (struct nbl_chan_param_cfg_multi_mcast *)data;
+
+	if (mcast->enable)
+		ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->add_multi_mcast,
+					    p, mcast->vsi);
+	else
+		NBL_OPS_CALL_LOCK(disp_mgt, res_ops->del_multi_mcast, p,
+				  mcast->vsi);
+	if (ret)
+		err = NBL_CHAN_RESP_ERR;
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_CFG_MULTI_MCAST_RULE,
+		     msg_id, err, NULL, 0);
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static int nbl_disp_chan_setup_multi_group_req(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_common_info *common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+	struct nbl_chan_send_info chan_send;
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_SETUP_MULTI_GROUP,
+		      NULL, 0, NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				  &chan_send);
+}
+
+static void nbl_disp_chan_setup_multi_group_resp(void *priv, u16 src_id,
+						 u16 msg_id, void *data,
+						 u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	int ret;
+
+	ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->setup_multi_group, p);
+	if (ret)
+		err = NBL_CHAN_RESP_ERR;
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_SETUP_MULTI_GROUP, msg_id,
+		     err, NULL, 0);
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static void nbl_disp_chan_remove_multi_group_req(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_common_info *common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+	struct nbl_chan_send_info chan_send;
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf,
+		      NBL_CHAN_MSG_REMOVE_MULTI_GROUP, NULL, 0, NULL, 0, 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static void nbl_disp_chan_remove_multi_group_resp(void *priv, u16 src_id,
+						  u16 msg_id, void *data,
+						  u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->remove_multi_group, p);
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_REMOVE_MULTI_GROUP, msg_id,
+		     err, NULL, 0);
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static int
+nbl_disp_chan_register_net_req(void *priv,
+			       struct nbl_register_net_param *register_param,
+			       struct nbl_register_net_result *register_result)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_param_register_net_info param = {0};
+	struct nbl_chan_send_info chan_send;
+	struct nbl_common_info *common;
+	int ret;
+
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	param.pf_bar_start = register_param->pf_bar_start;
+	param.pf_bdf = register_param->pf_bdf;
+	param.vf_bar_start = register_param->vf_bar_start;
+	param.vf_bar_size = register_param->vf_bar_size;
+	param.total_vfs = register_param->total_vfs;
+	param.offset = register_param->offset;
+	param.stride = register_param->stride;
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_REGISTER_NET,
+		      &param, sizeof(param), (void *)register_result,
+		      sizeof(*register_result), 1);
+
+	ret = chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				 &chan_send);
+	return ret;
+}
+
+static void nbl_disp_chan_register_net_resp(void *priv, u16 src_id, u16 msg_id,
+					    void *data, u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct device *dev = NBL_COMMON_TO_DEV(disp_mgt->common);
+	struct nbl_resource_ops *res_ops;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_param_register_net_info param;
+	struct nbl_register_net_result result = { 0 };
+	struct nbl_register_net_param register_param = { 0 };
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_chan_ack_info chan_ack;
+	int copy_len;
+	int err = NBL_CHAN_RESP_OK;
+	int ret = 0;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+
+	memset(&param, 0, sizeof(struct nbl_chan_param_register_net_info));
+	copy_len = data_len < sizeof(struct nbl_chan_param_register_net_info) ?
+			   data_len :
+			   sizeof(struct nbl_chan_param_register_net_info);
+	memcpy(&param, data, copy_len);
+
+	register_param.pf_bar_start = param.pf_bar_start;
+	register_param.pf_bdf = param.pf_bdf;
+	register_param.vf_bar_start = param.vf_bar_start;
+	register_param.vf_bar_size = param.vf_bar_size;
+	register_param.total_vfs = param.total_vfs;
+	register_param.offset = param.offset;
+	register_param.stride = param.stride;
+	register_param.is_vdpa = param.is_vdpa;
+
+	ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->register_net, p, src_id,
+				    &register_param, &result);
+	if (ret)
+		err = NBL_CHAN_RESP_ERR;
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_REGISTER_NET, msg_id, err,
+		     &result, sizeof(result));
+	ret = chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				 &chan_ack);
+	if (ret)
+		dev_err(dev,
+			"channel send ack failed with ret: %d, msg_type: %d, src_id:%d\n",
+			ret, NBL_CHAN_MSG_REGISTER_NET, src_id);
+}
+
+static int nbl_disp_unregister_net(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	return NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->unregister_net, p, 0);
+}
+
+static int nbl_disp_chan_unregister_net_req(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_send_info chan_send;
+	struct nbl_common_info *common;
+
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_UNREGISTER_NET,
+		      NULL, 0, NULL, 0, 1);
+
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				  &chan_send);
+}
+
+static void nbl_disp_chan_unregister_net_resp(void *priv, u16 src_id,
+					      u16 msg_id, void *data,
+					      u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct device *dev = NBL_COMMON_TO_DEV(disp_mgt->common);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	int ret = 0;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+
+	ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->unregister_net, p,
+				    src_id);
+	if (ret)
+		err = NBL_CHAN_RESP_ERR;
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_UNREGISTER_NET, msg_id, err,
+		     NULL, 0);
+	ret = chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				 &chan_ack);
+	if (ret)
+		dev_err(dev,
+			"channel send ack failed with ret: %d, msg_type: %d, src_id:%d\n",
+			ret, NBL_CHAN_MSG_UNREGISTER_NET, src_id);
+}
+
+static int nbl_disp_chan_alloc_txrx_queues_req(void *priv, u16 vsi_id,
+					       u16 queue_num)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_param_alloc_txrx_queues param = { 0 };
+	struct nbl_chan_param_alloc_txrx_queues result = { 0 };
+	struct nbl_chan_send_info chan_send;
+	struct nbl_common_info *common;
+
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	param.vsi_id = vsi_id;
+	param.queue_num = queue_num;
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_ALLOC_TXRX_QUEUES,
+		      &param, sizeof(param), &result, sizeof(result), 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				  &chan_send);
+}
+
+static void nbl_disp_chan_alloc_txrx_queues_resp(void *priv, u16 src_id,
+						 u16 msg_id, void *data,
+						 u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_chan_param_alloc_txrx_queues *param;
+	struct nbl_chan_param_alloc_txrx_queues result = {0};
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+
+	param = (struct nbl_chan_param_alloc_txrx_queues *)data;
+	result.queue_num = param->queue_num;
+
+	err = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->alloc_txrx_queues, p,
+				    param->vsi_id, param->queue_num);
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_ALLOC_TXRX_QUEUES, msg_id,
+		     err, &result, sizeof(result));
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static void nbl_disp_chan_free_txrx_queues_req(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_send_info chan_send;
+	struct nbl_common_info *common;
+
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_FREE_TXRX_QUEUES,
+		      &vsi_id, sizeof(vsi_id), NULL, 0, 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static void nbl_disp_chan_free_txrx_queues_resp(void *priv, u16 src_id,
+						u16 msg_id, void *data,
+						u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	u16 vsi_id;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+
+	vsi_id = *(u16 *)data;
+
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->free_txrx_queues, p, vsi_id);
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_FREE_TXRX_QUEUES, msg_id,
+		     err, NULL, 0);
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static int nbl_disp_chan_register_vsi2q_req(void *priv, u16 vsi_index,
+					    u16 vsi_id, u16 queue_offset,
+					    u16 queue_num)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_common_info *common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+	struct nbl_chan_param_register_vsi2q param = {0};
+	struct nbl_chan_send_info chan_send;
+
+	param.vsi_index = vsi_index;
+	param.vsi_id = vsi_id;
+	param.queue_offset = queue_offset;
+	param.queue_num = queue_num;
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_REGISTER_VSI2Q,
+		      &param, sizeof(param), NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				  &chan_send);
+}
+
+static void nbl_disp_chan_register_vsi2q_resp(void *priv, u16 src_id,
+					      u16 msg_id, void *data,
+					      u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_param_register_vsi2q *param = NULL;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+
+	param = (struct nbl_chan_param_register_vsi2q *)data;
+
+	err = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->register_vsi2q, p,
+				    param->vsi_index, param->vsi_id,
+				    param->queue_offset, param->queue_num);
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_REGISTER_VSI2Q, msg_id, err,
+		     NULL, 0);
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static int nbl_disp_chan_setup_q2vsi_req(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_common_info *common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+	struct nbl_chan_send_info chan_send;
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_SETUP_Q2VSI,
+		      &vsi_id, sizeof(vsi_id), NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				  &chan_send);
+}
+
+static void nbl_disp_chan_setup_q2vsi_resp(void *priv, u16 src_id, u16 msg_id,
+					   void *data, u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	u16 vsi_id;
+
+	vsi_id = *(u16 *)data;
+
+	err = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->setup_q2vsi, p, vsi_id);
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_SETUP_Q2VSI, msg_id, err,
+		     NULL, 0);
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static void nbl_disp_chan_remove_q2vsi_req(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_common_info *common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+	struct nbl_chan_send_info chan_send;
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_REMOVE_Q2VSI,
+		      &vsi_id, sizeof(vsi_id), NULL, 0, 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static void nbl_disp_chan_remove_q2vsi_resp(void *priv, u16 src_id, u16 msg_id,
+					    void *data, u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	u16 vsi_id;
+
+	vsi_id = *(u16 *)data;
+
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->remove_q2vsi, p, vsi_id);
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_REMOVE_Q2VSI, msg_id, err,
+		     NULL, 0);
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static int nbl_disp_chan_setup_rss_req(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_common_info *common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+	struct nbl_chan_send_info chan_send;
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_SETUP_RSS,
+		      &vsi_id, sizeof(vsi_id), NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				  &chan_send);
+}
+
+static void nbl_disp_chan_setup_rss_resp(void *priv, u16 src_id, u16 msg_id,
+					 void *data, u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_ack_info chan_ack;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	int err = NBL_CHAN_RESP_OK;
+	u16 vsi_id;
+
+	vsi_id = *(u16 *)data;
+	err = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->setup_rss, p, vsi_id);
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_SETUP_RSS, msg_id, err,
+		     NULL, 0);
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static void nbl_disp_chan_remove_rss_req(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_common_info *common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+	struct nbl_chan_send_info chan_send;
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_REMOVE_RSS,
+		      &vsi_id, sizeof(vsi_id), NULL, 0, 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static void nbl_disp_chan_remove_rss_resp(void *priv, u16 src_id, u16 msg_id,
+					  void *data, u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	u16 vsi_id;
+
+	vsi_id = *(u16 *)data;
+
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->remove_rss, p, vsi_id);
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_REMOVE_RSS, msg_id, err,
+		     NULL, 0);
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static int nbl_disp_chan_setup_queue_req(void *priv,
+					 struct nbl_txrx_queue_param *_param,
+					 bool is_tx)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_param_setup_queue param;
+	struct nbl_chan_send_info chan_send;
+	struct nbl_common_info *common;
+
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	memcpy(&param.queue_param, _param, sizeof(param.queue_param));
+	param.is_tx = is_tx;
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_SETUP_QUEUE,
+		      &param, sizeof(param), NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				  &chan_send);
+}
+
+static void nbl_disp_chan_setup_queue_resp(void *priv, u16 src_id, u16 msg_id,
+					   void *data, u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_param_setup_queue *param;
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+
+	param = (struct nbl_chan_param_setup_queue *)data;
+
+	err = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->setup_queue, p,
+				    &param->queue_param, param->is_tx);
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_SETUP_QUEUE, msg_id, err,
+		     NULL, 0);
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static void nbl_disp_chan_remove_all_queues_req(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_send_info chan_send;
+	struct nbl_common_info *common;
+
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_REMOVE_ALL_QUEUES,
+		      &vsi_id, sizeof(vsi_id), NULL, 0, 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static void nbl_disp_chan_remove_all_queues_resp(void *priv, u16 src_id,
+						 u16 msg_id, void *data,
+						 u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	u16 vsi_id;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+
+	vsi_id = *(u16 *)data;
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->remove_all_queues, p, vsi_id);
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_REMOVE_ALL_QUEUES, msg_id,
+		     err, NULL, 0);
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static int nbl_disp_chan_cfg_dsch_req(void *priv, u16 vsi_id, bool vld)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_common_info *common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+	struct nbl_chan_param_cfg_dsch param = { 0 };
+	struct nbl_chan_send_info chan_send;
+
+	param.vsi_id = vsi_id;
+	param.vld = vld;
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_CFG_DSCH, &param,
+		      sizeof(param), NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				  &chan_send);
+}
+
+static void nbl_disp_chan_cfg_dsch_resp(void *priv, u16 src_id, u16 msg_id,
+					void *data, u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_param_cfg_dsch *param;
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+
+	param = (struct nbl_chan_param_cfg_dsch *)data;
+
+	err = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->cfg_dsch, p,
+				    param->vsi_id, param->vld);
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_CFG_DSCH, msg_id, err, NULL,
+		     0);
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static int nbl_disp_setup_cqs(void *priv, u16 vsi_id, u16 real_qps,
+			      bool rss_indir_set)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	int ret;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->setup_cqs, p, vsi_id,
+				    real_qps, rss_indir_set);
+	return ret;
+}
+
+static int nbl_disp_chan_setup_cqs_req(void *priv, u16 vsi_id, u16 real_qps,
+				       bool rss_indir_set)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_param_setup_cqs param = { 0 };
+	struct nbl_chan_send_info chan_send;
+	struct nbl_common_info *common;
+
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	param.vsi_id = vsi_id;
+	param.real_qps = real_qps;
+	param.rss_indir_set = rss_indir_set;
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_SETUP_CQS, &param,
+		      sizeof(param), NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				  &chan_send);
+}
+
+static void nbl_disp_chan_setup_cqs_resp(void *priv, u16 src_id, u16 msg_id,
+					 void *data, u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_param_setup_cqs param;
+	struct nbl_chan_ack_info chan_ack;
+	int copy_len;
+	int err = NBL_CHAN_RESP_OK;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+
+	memset(&param, 0, sizeof(struct nbl_chan_param_setup_cqs));
+	param.rss_indir_set = true;
+	copy_len = data_len < sizeof(struct nbl_chan_param_setup_cqs) ?
+			   data_len :
+			   sizeof(struct nbl_chan_param_setup_cqs);
+	memcpy(&param, data, copy_len);
+
+	err = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->setup_cqs, p,
+				    param.vsi_id, param.real_qps,
+				    param.rss_indir_set);
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_SETUP_CQS, msg_id, err,
+		     NULL, 0);
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static void nbl_disp_chan_remove_cqs_req(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_send_info chan_send;
+	struct nbl_common_info *common;
+
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_REMOVE_CQS,
+		      &vsi_id, sizeof(vsi_id), NULL, 0, 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static void nbl_disp_chan_remove_cqs_resp(void *priv, u16 src_id, u16 msg_id,
+					  void *data, u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	u16 vsi_id;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+
+	vsi_id = *(u16 *)data;
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->remove_cqs, p, vsi_id);
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_REMOVE_CQS, msg_id, err,
+		     NULL, 0);
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static int nbl_disp_set_promisc_mode(void *priv, u16 vsi_id, u16 mode)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	int ret = 0;
+
+	if (!disp_mgt)
+		return -EINVAL;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->set_promisc_mode, p,
+				    vsi_id, mode);
+	return ret;
+}
+
+static int nbl_disp_chan_set_promisc_mode_req(void *priv, u16 vsi_id, u16 mode)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_common_info *common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+	struct nbl_chan_param_set_promisc_mode param = {0};
+	struct nbl_chan_send_info chan_send = {0};
+
+	param.vsi_id = vsi_id;
+	param.mode = mode;
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_SET_PROSISC_MODE,
+		      &param, sizeof(param), NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				  &chan_send);
+}
+
+static void nbl_disp_chan_set_promisc_mode_resp(void *priv, u16 src_id,
+						u16 msg_id, void *data,
+						u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_chan_param_set_promisc_mode *param = NULL;
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+
+	param = (struct nbl_chan_param_set_promisc_mode *)data;
+	err = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->set_promisc_mode, p,
+				    param->vsi_id, param->mode);
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_SET_PROSISC_MODE, msg_id,
+		     err, NULL, 0);
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static void nbl_disp_chan_get_rxfh_indir_size_req(void *priv, u16 vsi_id,
+						  u32 *rxfh_indir_size)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_send_info chan_send = {0};
+	struct nbl_common_info *common;
+
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf,
+		      NBL_CHAN_MSG_GET_RXFH_INDIR_SIZE, &vsi_id, sizeof(vsi_id),
+		      rxfh_indir_size, sizeof(u32), 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static void nbl_disp_chan_get_rxfh_indir_size_resp(void *priv, u16 src_id,
+						   u16 msg_id, void *data,
+						   u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_ack_info chan_ack;
+	u32 rxfh_indir_size = 0;
+	int ret = NBL_CHAN_RESP_OK;
+	u16 vsi_id;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+
+	vsi_id = *(u16 *)data;
+	NBL_OPS_CALL(res_ops->get_rxfh_indir_size,
+		     (p, vsi_id, &rxfh_indir_size));
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_GET_RXFH_INDIR_SIZE, msg_id,
+		     ret, &rxfh_indir_size, sizeof(u32));
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static int nbl_disp_chan_set_sfp_state_req(void *priv, u8 eth_id, u8 state)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_chan_param_set_sfp_state param = {0};
+	struct nbl_chan_send_info chan_send = {0};
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_common_info *common;
+
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	param.eth_id = eth_id;
+	param.state = state;
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_SET_SFP_STATE,
+		      &param, sizeof(param), NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				  &chan_send);
+}
+
+static void nbl_disp_chan_set_sfp_state_resp(void *priv, u16 src_id, u16 msg_id,
+					     void *data, u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct device *dev = NBL_COMMON_TO_DEV(disp_mgt->common);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_chan_param_set_sfp_state *param;
+	struct nbl_resource_ops *res_ops;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	int ret = 0;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	param = (struct nbl_chan_param_set_sfp_state *)data;
+
+	ret = NBL_OPS_CALL_RET(res_ops->set_sfp_state,
+			       (p, param->eth_id, param->state));
+	if (ret) {
+		err = NBL_CHAN_RESP_ERR;
+		dev_err(dev, "set sfp state failed with ret: %d\n", ret);
+	}
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_SET_SFP_STATE, msg_id, err,
+		     NULL, 0);
+
+	ret = chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				 &chan_ack);
+	if (ret)
+		dev_err(dev,
+			"channel send ack failed with ret: %d, msg_type: %d, src_id: %d\n",
+			ret, NBL_CHAN_MSG_SET_SFP_STATE, src_id);
+}
+
+static u16 nbl_disp_chan_get_function_id_req(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_send_info chan_send = {0};
+	struct nbl_common_info *common;
+	u16 func_id = 0;
+
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_GET_FUNCTION_ID,
+		      &vsi_id, sizeof(vsi_id), &func_id, sizeof(func_id), 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+
+	return func_id;
+}
+
+static void nbl_disp_chan_get_function_id_resp(void *priv, u16 src_id,
+					       u16 msg_id, void *data,
+					       u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_chan_ack_info chan_ack;
+	int ret = NBL_CHAN_RESP_OK;
+	u16 vsi_id, func_id;
+
+	vsi_id = *(u16 *)data;
+
+	func_id = NBL_OPS_CALL_RET(res_ops->get_function_id, (p, vsi_id));
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_GET_FUNCTION_ID, msg_id,
+		     ret, &func_id, sizeof(func_id));
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static void nbl_disp_chan_get_real_bdf_req(void *priv, u16 vsi_id, u8 *bus,
+					   u8 *dev, u8 *function)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_result_get_real_bdf result = { 0 };
+	struct nbl_chan_send_info chan_send = { 0 };
+	struct nbl_common_info *common;
+
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_GET_REAL_BDF,
+		      &vsi_id, sizeof(vsi_id), &result, sizeof(result), 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+
+	*bus = result.bus;
+	*dev = result.dev;
+	*function = result.function;
+}
+
+static void nbl_disp_chan_get_real_bdf_resp(void *priv, u16 src_id, u16 msg_id,
+					    void *data, u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_chan_result_get_real_bdf result = { 0 };
+	struct nbl_chan_ack_info chan_ack;
+	int ret = NBL_CHAN_RESP_OK;
+	u16 vsi_id;
+
+	vsi_id = *(u16 *)data;
+	NBL_OPS_CALL(res_ops->get_real_bdf,
+		     (p, vsi_id, &result.bus, &result.dev, &result.function));
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_GET_REAL_BDF, msg_id, ret,
+		     &result, sizeof(result));
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static int nbl_disp_chan_get_mbx_irq_num_req(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_send_info chan_send = { 0 };
+	struct nbl_common_info *common;
+	int result = 0;
+
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_GET_MBX_IRQ_NUM,
+		      NULL, 0, &result, sizeof(result), 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+
+	return result;
+}
+
+static void nbl_disp_chan_get_mbx_irq_num_resp(void *priv, u16 src_id,
+					       u16 msg_id, void *data,
+					       u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_chan_ack_info chan_ack;
+	int result, ret = NBL_CHAN_RESP_OK;
+
+	result = NBL_OPS_CALL_RET(res_ops->get_mbx_irq_num, (p));
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_GET_MBX_IRQ_NUM, msg_id,
+		     ret, &result, sizeof(result));
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static void nbl_disp_chan_clear_flow_req(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_send_info chan_send = { 0 };
+	struct nbl_common_info *common;
+
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_CLEAR_FLOW,
+		      &vsi_id, sizeof(vsi_id), NULL, 0, 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static void nbl_disp_chan_clear_flow_resp(void *priv, u16 src_id, u16 msg_id,
+					  void *data, u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_chan_ack_info chan_ack;
+	u16 *vsi_id = (u16 *)data;
+
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->clear_flow, p, *vsi_id);
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_CLEAR_FLOW, msg_id,
+		     NBL_CHAN_RESP_OK, NULL, 0);
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static void nbl_disp_chan_clear_queues_req(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_send_info chan_send = { 0 };
+	struct nbl_common_info *common;
+
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_CLEAR_QUEUE,
+		      &vsi_id, sizeof(vsi_id), NULL, 0, 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static void nbl_disp_chan_clear_queues_resp(void *priv, u16 src_id, u16 msg_id,
+					    void *data, u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_chan_ack_info chan_ack;
+	u16 *vsi_id = (u16 *)data;
+
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->clear_queues, p, *vsi_id);
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_CLEAR_QUEUE, msg_id,
+		     NBL_CHAN_RESP_OK, NULL, 0);
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static u16 nbl_disp_chan_get_vsi_id_req(void *priv, u16 func_id, u16 type)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_common_info *common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+	struct nbl_chan_param_get_vsi_id param = {0};
+	struct nbl_chan_param_get_vsi_id result = {0};
+	struct nbl_chan_send_info chan_send;
+
+	param.type = type;
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_GET_VSI_ID,
+		      &param, sizeof(param), &result, sizeof(result), 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+
+	return result.vsi_id;
+}
+
+static void nbl_disp_chan_get_vsi_id_resp(void *priv, u16 src_id, u16 msg_id,
+					  void *data, u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(disp_mgt->common);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_chan_param_get_vsi_id *param;
+	struct nbl_chan_param_get_vsi_id result;
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	int ret = 0;
+
+	param = (struct nbl_chan_param_get_vsi_id *)data;
+
+	result.vsi_id =
+		NBL_OPS_CALL_RET(res_ops->get_vsi_id, (p, src_id, param->type));
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_GET_VSI_ID, msg_id, err,
+		     &result, sizeof(result));
+	ret = chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				 &chan_ack);
+	if (ret)
+		dev_err(dev,
+			"channel send ack failed with ret: %d, msg_type: %d\n",
+			ret, NBL_CHAN_MSG_GET_VSI_ID);
+}
+
+static void nbl_disp_chan_get_eth_id_req(void *priv, u16 vsi_id, u8 *eth_mode,
+					 u8 *eth_id, u8 *logic_eth_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_param_get_eth_id param = { 0 };
+	struct nbl_chan_param_get_eth_id result = { 0 };
+	struct nbl_chan_send_info chan_send;
+	struct nbl_common_info *common;
+
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	param.vsi_id = vsi_id;
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_GET_ETH_ID,
+		      &param, sizeof(param), &result, sizeof(result), 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+
+	*eth_mode = result.eth_mode;
+	*eth_id = result.eth_id;
+	*logic_eth_id = result.logic_eth_id;
+}
+
+static void nbl_disp_chan_get_eth_id_resp(void *priv, u16 src_id, u16 msg_id,
+					  void *data, u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(disp_mgt->common);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_chan_param_get_eth_id *param;
+	struct nbl_chan_param_get_eth_id result = { 0 };
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	int ret = 0;
+
+	param = (struct nbl_chan_param_get_eth_id *)data;
+
+	NBL_OPS_CALL(res_ops->get_eth_id,
+		     (p, param->vsi_id, &result.eth_mode, &result.eth_id,
+		      &result.logic_eth_id));
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_GET_ETH_ID, msg_id, err,
+		     &result, sizeof(result));
+	ret = chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				 &chan_ack);
+	if (ret)
+		dev_err(dev,
+			"channel send ack failed with ret: %d, msg_type: %d\n",
+			ret, NBL_CHAN_MSG_GET_ETH_ID);
+}
+
+static int nbl_disp_alloc_rings(void *priv, struct net_device *netdev,
+				struct nbl_ring_param *ring_param)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	int ret = 0;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	ret = NBL_OPS_CALL_RET(res_ops->alloc_rings, (p, netdev, ring_param));
+	return ret;
+}
+
+static void nbl_disp_remove_rings(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops;
+
+	if (!disp_mgt)
+		return;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	NBL_OPS_CALL(res_ops->remove_rings,
+		     (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt)));
+}
+
+static dma_addr_t nbl_disp_start_tx_ring(void *priv, u8 ring_index)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	dma_addr_t addr = 0;
+
+	if (!disp_mgt)
+		return -EINVAL;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	addr = NBL_OPS_CALL_RET(res_ops->start_tx_ring, (p, ring_index));
+	return addr;
+}
+
+static void nbl_disp_stop_tx_ring(void *priv, u8 ring_index)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+
+	if (!disp_mgt)
+		return;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	NBL_OPS_CALL(res_ops->stop_tx_ring, (p, ring_index));
+}
+
+static dma_addr_t nbl_disp_start_rx_ring(void *priv, u8 ring_index,
+					 bool use_napi)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	dma_addr_t addr = 0;
+
+	if (!disp_mgt)
+		return -EINVAL;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	addr = NBL_OPS_CALL_RET(res_ops->start_rx_ring,
+				(p, ring_index, use_napi));
+
+	return addr;
+}
+
+static void nbl_disp_stop_rx_ring(void *priv, u8 ring_index)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+
+	if (!disp_mgt)
+		return;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	NBL_OPS_CALL(res_ops->stop_rx_ring, (p, ring_index));
+}
+
+static void nbl_disp_kick_rx_ring(void *priv, u16 index)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	NBL_OPS_CALL(res_ops->kick_rx_ring, (p, index));
+}
+
+static struct nbl_napi_struct *nbl_disp_get_vector_napi(void *priv, u16 index)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	return NBL_OPS_CALL_RET_PTR(res_ops->get_vector_napi, (p, index));
+}
+
+static void nbl_disp_set_vector_info(void *priv, u8 __iomem *irq_enable_base,
+				     u32 irq_data, u16 index, bool mask_en)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	NBL_OPS_CALL(res_ops->set_vector_info,
+		     (p, irq_enable_base, irq_data, index, mask_en));
+}
+
+static void nbl_disp_register_vsi_ring(void *priv, u16 vsi_index,
+				       u16 ring_offset, u16 ring_num)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	NBL_OPS_CALL(res_ops->register_vsi_ring,
+		     (p, vsi_index, ring_offset, ring_num));
+}
+
+static void nbl_disp_get_res_pt_ops(void *priv,
+				    struct nbl_resource_pt_ops *pt_ops)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	NBL_OPS_CALL(res_ops->get_resource_pt_ops, (p, pt_ops));
+}
+
+static int
+nbl_disp_register_net(void *priv, struct nbl_register_net_param *register_param,
+		      struct nbl_register_net_result *register_result)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	int ret = 0;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->register_net, p, 0,
+				    register_param, register_result);
+	return ret;
+}
+
+static int nbl_disp_alloc_txrx_queues(void *priv, u16 vsi_id, u16 queue_num)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	int ret = 0;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->alloc_txrx_queues, p,
+				    vsi_id, queue_num);
+	return ret;
+}
+
+static void nbl_disp_free_txrx_queues(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->free_txrx_queues, p, vsi_id);
+}
+
+static int nbl_disp_register_vsi2q(void *priv, u16 vsi_index, u16 vsi_id,
+				   u16 queue_offset, u16 queue_num)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	return NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->register_vsi2q, p,
+				     vsi_index, vsi_id, queue_offset,
+				     queue_num);
+}
+
+static int nbl_disp_setup_q2vsi(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	return NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->setup_q2vsi, p, vsi_id);
+}
+
+static void nbl_disp_remove_q2vsi(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->remove_q2vsi, p, vsi_id);
+}
+
+static int nbl_disp_setup_rss(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	return NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->setup_rss, p, vsi_id);
+}
+
+static void nbl_disp_remove_rss(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->remove_rss, p, vsi_id);
+}
+
+static int nbl_disp_setup_queue(void *priv, struct nbl_txrx_queue_param *param,
+				bool is_tx)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	int ret = 0;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->setup_queue, p, param,
+				    is_tx);
+	return ret;
+}
+
+static void nbl_disp_remove_all_queues(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->remove_all_queues, p, vsi_id);
+}
+
+static int nbl_disp_cfg_dsch(void *priv, u16 vsi_id, bool vld)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	int ret = 0;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->cfg_dsch, p, vsi_id,
+				    vld);
+	return ret;
+}
+
+static void nbl_disp_remove_cqs(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->remove_cqs, p, vsi_id);
+}
+
+static u8 __iomem *
+nbl_disp_get_msix_irq_enable_info(void *priv, u16 global_vec_id, u32 *irq_data)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+
+	if (!disp_mgt)
+		return NULL;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	return NBL_OPS_CALL_RET_PTR(res_ops->get_msix_irq_enable_info,
+				    (p, global_vec_id, irq_data));
+}
+
+static int nbl_disp_add_macvlan(void *priv, u8 *mac, u16 vlan, u16 vsi)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	int ret = 0;
+
+	if (!disp_mgt || !mac)
+		return -EINVAL;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->add_macvlan, p, mac,
+				    vlan, vsi);
+	return ret;
+}
+
+static void nbl_disp_del_macvlan(void *priv, u8 *mac, u16 vlan, u16 vsi)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+
+	if (!disp_mgt || !mac)
+		return;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->del_macvlan, p, mac, vlan, vsi);
+}
+
+static int nbl_disp_add_multi_rule(void *priv, u16 vsi)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	u8 broadcast_mac[ETH_ALEN];
+	int ret;
+
+	memset(broadcast_mac, 0xFF, ETH_ALEN);
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->add_macvlan, p,
+				    broadcast_mac, 0, vsi);
+
+	return ret;
+}
+
+static void nbl_disp_del_multi_rule(void *priv, u16 vsi)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	u8 broadcast_mac[ETH_ALEN];
+
+	memset(broadcast_mac, 0xFF, ETH_ALEN);
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->del_macvlan, p, broadcast_mac, 0,
+			  vsi);
+}
+
+static int nbl_disp_setup_multi_group(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	return NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->setup_multi_group,
+				     NBL_DISP_MGT_TO_RES_PRIV(disp_mgt));
+}
+
+static void nbl_disp_remove_multi_group(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->remove_multi_group,
+			  NBL_DISP_MGT_TO_RES_PRIV(disp_mgt));
+}
+
+static void nbl_disp_get_net_stats(void *priv, struct nbl_stats *net_stats)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	NBL_OPS_CALL(res_ops->get_net_stats, (p, net_stats));
+}
+
+static void nbl_disp_cfg_txrx_vlan(void *priv, u16 vlan_tci, u16 vlan_proto,
+				   u8 vsi_index)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	NBL_OPS_CALL(res_ops->cfg_txrx_vlan,
+		     (p, vlan_tci, vlan_proto, vsi_index));
+}
+
+static void nbl_disp_get_rxfh_indir_size(void *priv, u16 vsi_id,
+					 u32 *rxfh_indir_size)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	NBL_OPS_CALL(res_ops->get_rxfh_indir_size,
+		     (p, vsi_id, rxfh_indir_size));
+}
+
+static int nbl_disp_set_rxfh_indir(void *priv, u16 vsi_id, const u32 *indir,
+				   u32 indir_size)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	int ret = 0;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	ret = NBL_OPS_CALL_RET(res_ops->set_rxfh_indir,
+			       (p, vsi_id, indir, indir_size));
+	return ret;
+}
+
+static int nbl_disp_chan_set_rxfh_indir_req(void *priv, u16 vsi_id,
+					    const u32 *indir, u32 indir_size)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_chan_param_set_rxfh_indir *param = NULL;
+	struct nbl_chan_send_info chan_send = {0};
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_common_info *common;
+	int ret = 0;
+
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	param = kzalloc(sizeof(*param), GFP_KERNEL);
+	if (!param)
+		return -ENOMEM;
+
+	param->vsi_id = vsi_id;
+	param->indir_size = indir_size;
+	memcpy(param->indir, indir, indir_size * sizeof(param->indir[0]));
+
+	NBL_CHAN_SEND(chan_send, NBL_COMMON_TO_MGT_PF(common),
+		      NBL_CHAN_MSG_SET_RXFH_INDIR, param, sizeof(*param), NULL,
+		      0, 1);
+	ret = chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				 &chan_send);
+	kfree(param);
+	return ret;
+}
+
+static void nbl_disp_chan_set_rxfh_indir_resp(void *priv, u16 src_id,
+					      u16 msg_id, void *data,
+					      u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_param_set_rxfh_indir *param;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	param = (struct nbl_chan_param_set_rxfh_indir *)data;
+
+	err = NBL_OPS_CALL_RET(res_ops->set_rxfh_indir,
+			       (p, param->vsi_id, param->indir,
+				param->indir_size));
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_SET_RXFH_INDIR, msg_id, err,
+		     NULL, 0);
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static int nbl_disp_set_sfp_state(void *priv, u8 eth_id, u8 state)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	int ret = 0;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	ret = NBL_OPS_CALL_RET(res_ops->set_sfp_state, (p, eth_id, state));
+	return ret;
+}
+
+static void nbl_disp_deinit_chip_module(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	NBL_OPS_CALL(res_ops->deinit_chip_module,
+		     (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt)));
+}
+
+static int nbl_disp_init_chip_module(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops;
+	int ret;
+
+	if (!disp_mgt)
+		return -EINVAL;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	ret = NBL_OPS_CALL_RET(res_ops->init_chip_module,
+			       (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt)));
+	return ret;
+}
+
+static int nbl_disp_queue_init(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops;
+	int ret;
+
+	if (!disp_mgt)
+		return -EINVAL;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	ret = NBL_OPS_CALL_RET(res_ops->queue_init,
+			       (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt)));
+	return ret;
+}
+
+static int nbl_disp_vsi_init(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops;
+	int ret;
+
+	if (!disp_mgt)
+		return -EINVAL;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	ret = NBL_OPS_CALL_RET(res_ops->vsi_init,
+			       (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt)));
+	return ret;
+}
+
+static int nbl_disp_init_vf_msix_map(void *priv, u16 func_id, bool enable)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	int ret;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->init_vf_msix_map, p,
+				    func_id, enable);
+	return ret;
+}
+
+static int nbl_disp_chan_init_vf_msix_map_req(void *priv, u16 func_id,
+					      bool enable)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_param_init_vf_msix_map param = {0};
+	struct nbl_chan_send_info chan_send;
+	struct nbl_common_info *common;
+
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	param.func_id = func_id;
+	param.enable = enable;
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_INIT_VF_MSIX_MAP,
+		      &param, sizeof(param), NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				  &chan_send);
+}
+
+static void nbl_disp_chan_init_vf_msix_map_resp(void *priv, u16 src_id,
+						u16 msg_id, void *data,
+						u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct device *dev = NBL_COMMON_TO_DEV(disp_mgt->common);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_param_init_vf_msix_map *param;
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	int ret;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	param = (struct nbl_chan_param_init_vf_msix_map *)data;
+
+	ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->init_vf_msix_map, p,
+				    param->func_id, param->enable);
+	if (ret)
+		err = NBL_CHAN_RESP_ERR;
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_INIT_VF_MSIX_MAP, msg_id,
+		     err, NULL, 0);
+	ret = chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				 &chan_ack);
+	if (ret)
+		dev_err(dev,
+			"channel send ack failed with ret: %d, msg_type: %d\n",
+			ret, NBL_CHAN_MSG_INIT_VF_MSIX_MAP);
+}
+
+static int nbl_disp_configure_msix_map(void *priv, u16 num_net_msix,
+				       u16 num_others_msix,
+				       bool net_msix_mask_en)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	int ret;
+
+	if (!disp_mgt)
+		return -EINVAL;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->configure_msix_map, p, 0,
+				    num_net_msix, num_others_msix,
+				    net_msix_mask_en);
+	return ret;
+}
+
+static int nbl_disp_chan_configure_msix_map_req(void *priv, u16 num_net_msix,
+						u16 num_others_msix,
+						bool net_msix_mask_en)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_chan_param_cfg_msix_map param = {0};
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_send_info chan_send;
+	struct nbl_common_info *common;
+
+	if (!disp_mgt)
+		return -EINVAL;
+
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	param.num_net_msix = num_net_msix;
+	param.num_others_msix = num_others_msix;
+	param.msix_mask_en = net_msix_mask_en;
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf,
+		      NBL_CHAN_MSG_CONFIGURE_MSIX_MAP, &param, sizeof(param),
+		      NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				  &chan_send);
+}
+
+static void nbl_disp_chan_configure_msix_map_resp(void *priv, u16 src_id,
+						  u16 msg_id, void *data,
+						  u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct device *dev = NBL_COMMON_TO_DEV(disp_mgt->common);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_param_cfg_msix_map *param;
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	int ret;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	param = (struct nbl_chan_param_cfg_msix_map *)data;
+
+	ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->configure_msix_map, p,
+				    src_id, param->num_net_msix,
+				    param->num_others_msix,
+				    param->msix_mask_en);
+	if (ret)
+		err = NBL_CHAN_RESP_ERR;
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_CONFIGURE_MSIX_MAP, msg_id,
+		     err, NULL, 0);
+	ret = chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				 &chan_ack);
+	if (ret)
+		dev_err(dev,
+			"channel send ack failed with ret: %d, msg_type: %d\n",
+			ret, NBL_CHAN_MSG_CONFIGURE_MSIX_MAP);
+}
+
+static int nbl_disp_chan_destroy_msix_map_req(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_send_info chan_send;
+	struct nbl_common_info *common;
+
+	if (!disp_mgt)
+		return -EINVAL;
+
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_DESTROY_MSIX_MAP,
+		      NULL, 0, NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				  &chan_send);
+}
+
+static void nbl_disp_chan_destroy_msix_map_resp(void *priv, u16 src_id,
+						u16 msg_id, void *data,
+						u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct device *dev = NBL_COMMON_TO_DEV(disp_mgt->common);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	int ret;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+
+	ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->destroy_msix_map, p,
+				    src_id);
+	if (ret)
+		err = NBL_CHAN_RESP_ERR;
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_DESTROY_MSIX_MAP, msg_id,
+		     err, NULL, 0);
+	ret = chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				 &chan_ack);
+	if (ret)
+		dev_err(dev,
+			"channel send ack failed with ret: %d, msg_type: %d\n",
+			ret, NBL_CHAN_MSG_DESTROY_MSIX_MAP);
+}
+
+static int nbl_disp_chan_enable_mailbox_irq_req(void *priv, u16 vector_id,
+						bool enable_msix)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_param_enable_mailbox_irq param = { 0 };
+	struct nbl_chan_send_info chan_send;
+	struct nbl_common_info *common;
+
+	if (!disp_mgt)
+		return -EINVAL;
+
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	param.vector_id = vector_id;
+	param.enable_msix = enable_msix;
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf,
+		      NBL_CHAN_MSG_MAILBOX_ENABLE_IRQ, &param, sizeof(param),
+		      NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				  &chan_send);
+}
+
+static void nbl_disp_chan_enable_mailbox_irq_resp(void *priv, u16 src_id,
+						  u16 msg_id, void *data,
+						  u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct device *dev = NBL_COMMON_TO_DEV(disp_mgt->common);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_param_enable_mailbox_irq *param;
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	int ret;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	param = (struct nbl_chan_param_enable_mailbox_irq *)data;
+
+	ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->enable_mailbox_irq, p,
+				    src_id, param->vector_id,
+				    param->enable_msix);
+	if (ret)
+		err = NBL_CHAN_RESP_ERR;
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_MAILBOX_ENABLE_IRQ, msg_id,
+		     err, NULL, 0);
+	ret = chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				 &chan_ack);
+	if (ret)
+		dev_err(dev,
+			"channel send ack failed with ret: %d, msg_type: %d\n",
+			ret, NBL_CHAN_MSG_MAILBOX_ENABLE_IRQ);
+}
+
+static u16 nbl_disp_chan_get_global_vector_req(void *priv, u16 vsi_id,
+					       u16 local_vec_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_param_get_global_vector param = { 0 };
+	struct nbl_chan_param_get_global_vector result = { 0 };
+	struct nbl_chan_send_info chan_send;
+	struct nbl_common_info *common;
+
+	if (!disp_mgt)
+		return -EINVAL;
+
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	param.vsi_id = vsi_id;
+	param.vector_id = local_vec_id;
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_GET_GLOBAL_VECTOR,
+		      &param, sizeof(param), &result, sizeof(result), 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+
+	return result.vector_id;
+}
+
+static void nbl_disp_chan_get_global_vector_resp(void *priv, u16 src_id,
+						 u16 msg_id, void *data,
+						 u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct device *dev = NBL_COMMON_TO_DEV(disp_mgt->common);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_param_get_global_vector *param;
+	struct nbl_chan_param_get_global_vector result;
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	int ret;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	param = (struct nbl_chan_param_get_global_vector *)data;
+
+	result.vector_id =
+		NBL_OPS_CALL_RET(res_ops->get_global_vector,
+				 (p, param->vsi_id, param->vector_id));
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_GET_GLOBAL_VECTOR, msg_id,
+		     err, &result, sizeof(result));
+	ret = chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				 &chan_ack);
+	if (ret)
+		dev_err(dev,
+			"channel send ack failed with ret: %d, msg_type: %d\n",
+			ret, NBL_CHAN_MSG_GET_GLOBAL_VECTOR);
+}
+
+static int nbl_disp_destroy_msix_map(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	int ret;
+
+	if (!disp_mgt)
+		return -EINVAL;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->destroy_msix_map, p, 0);
+	return ret;
+}
+
+static int nbl_disp_enable_mailbox_irq(void *priv, u16 vector_id,
+				       bool enable_msix)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	int ret;
+
+	if (!disp_mgt)
+		return -EINVAL;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->enable_mailbox_irq, p, 0,
+				    vector_id, enable_msix);
+	return ret;
+}
+
+static int nbl_disp_enable_abnormal_irq(void *priv, u16 vector_id,
+					bool enable_msix)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	int ret;
+
+	if (!disp_mgt)
+		return -EINVAL;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	ret = NBL_OPS_CALL_RET(res_ops->enable_abnormal_irq,
+			       (p, vector_id, enable_msix));
+	return ret;
+}
+
+static int nbl_disp_enable_adminq_irq(void *priv, u16 vector_id,
+				      bool enable_msix)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	int ret;
+
+	if (!disp_mgt)
+		return -EINVAL;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	ret = NBL_OPS_CALL_RET(res_ops->enable_adminq_irq,
+			       (p, vector_id, enable_msix));
+	return ret;
+}
+
+static u16 nbl_disp_get_global_vector(void *priv, u16 vsi_id, u16 local_vec_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	u16 ret;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	ret = NBL_OPS_CALL_RET(res_ops->get_global_vector,
+			       (p, vsi_id, local_vec_id));
+	return ret;
+}
+
+static u16 nbl_disp_get_msix_entry_id(void *priv, u16 vsi_id, u16 local_vec_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	u16 ret;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	ret = NBL_OPS_CALL_RET(res_ops->get_msix_entry_id,
+			       (p, vsi_id, local_vec_id));
+	return ret;
+}
+
+static u16 nbl_disp_get_vsi_id(void *priv, u16 func_id, u16 type)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+
+	if (!disp_mgt)
+		return -EINVAL;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	return NBL_OPS_CALL_RET(res_ops->get_vsi_id, (p, func_id, type));
+}
+
+static void nbl_disp_get_eth_id(void *priv, u16 vsi_id, u8 *eth_mode,
+				u8 *eth_id, u8 *logic_eth_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	NBL_OPS_CALL(res_ops->get_eth_id,
+		     (p, vsi_id, eth_mode, eth_id, logic_eth_id));
+}
+
+static int nbl_disp_chan_add_lldp_flow_req(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_send_info chan_send;
+
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_ADD_LLDP_FLOW, &vsi_id,
+		      sizeof(vsi_id), NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				  &chan_send);
+}
+
+static void nbl_disp_chan_add_lldp_flow_resp(void *priv, u16 src_id, u16 msg_id,
+					     void *data, u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct device *dev = NBL_COMMON_TO_DEV(disp_mgt->common);
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	int ret;
+
+	ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->add_lldp_flow, p,
+				    *(u16 *)data);
+	if (ret)
+		err = NBL_CHAN_RESP_ERR;
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_ADD_LLDP_FLOW, msg_id, err,
+		     NULL, 0);
+	ret = chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				 &chan_ack);
+	if (ret)
+		dev_err(dev,
+			"channel send ack failed with ret: %d, msg_type: %d\n",
+			ret, NBL_CHAN_MSG_ADD_LLDP_FLOW);
+}
+
+static int nbl_disp_add_lldp_flow(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	return NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->add_lldp_flow, p,
+				     vsi_id);
+}
+
+static void nbl_disp_chan_del_lldp_flow_req(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_send_info chan_send;
+
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_DEL_LLDP_FLOW, &vsi_id,
+		      sizeof(vsi_id), NULL, 0, 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static void nbl_disp_chan_del_lldp_flow_resp(void *priv, u16 src_id, u16 msg_id,
+					     void *data, u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct device *dev = NBL_COMMON_TO_DEV(disp_mgt->common);
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	int ret;
+
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->del_lldp_flow, p, *(u16 *)data);
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_DEL_LLDP_FLOW, msg_id, err,
+		     NULL, 0);
+	ret = chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				 &chan_ack);
+	if (ret)
+		dev_err(dev,
+			"channel send ack failed with ret: %d, msg_type: %d\n",
+			ret, NBL_CHAN_MSG_DEL_LLDP_FLOW);
+}
+
+static void nbl_disp_del_lldp_flow(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->del_lldp_flow, p, vsi_id);
+}
+
+static u32 nbl_disp_get_tx_headroom(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	u32 ret;
+
+	ret = NBL_OPS_CALL_RET(res_ops->get_tx_headroom,
+			       (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt)));
+	return ret;
+}
+
+static u8 __iomem *nbl_disp_get_hw_addr(void *priv, size_t *size)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	u8 __iomem *addr = NULL;
+
+	addr = NBL_OPS_CALL_RET_PTR(res_ops->get_hw_addr, (p, size));
+	return addr;
+}
+
+static u16 nbl_disp_get_function_id(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	u16 ret;
+
+	ret = NBL_OPS_CALL_RET(res_ops->get_function_id, (p, vsi_id));
+	return ret;
+}
+
+static void nbl_disp_get_real_bdf(void *priv, u16 vsi_id, u8 *bus, u8 *dev,
+				  u8 *function)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	NBL_OPS_CALL(res_ops->get_real_bdf, (p, vsi_id, bus, dev, function));
+}
+
+static bool nbl_disp_check_fw_heartbeat(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	int ret;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	ret = NBL_OPS_CALL_RET(res_ops->check_fw_heartbeat, (p));
+	return ret;
+}
+
+static bool nbl_disp_check_fw_reset(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	return NBL_OPS_CALL_RET(res_ops->check_fw_reset,
+				(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt)));
+}
+
+static bool nbl_disp_get_product_fix_cap(void *priv,
+					 enum nbl_fix_cap_type cap_type)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	bool has_cap = false;
+
+	has_cap = NBL_OPS_CALL_RET(res_ops->get_product_fix_cap, (p, cap_type));
+	return has_cap;
+}
+
+static int nbl_disp_get_mbx_irq_num(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	return NBL_OPS_CALL_RET(res_ops->get_mbx_irq_num,
+				(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt)));
+}
+
+static int nbl_disp_get_adminq_irq_num(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	return NBL_OPS_CALL_RET(res_ops->get_adminq_irq_num,
+				(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt)));
+}
+
+static int nbl_disp_get_abnormal_irq_num(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	return NBL_OPS_CALL_RET(res_ops->get_abnormal_irq_num,
+				(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt)));
+}
+
+static void nbl_disp_clear_flow(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->clear_flow, p, vsi_id);
+}
+
+static void nbl_disp_clear_queues(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->clear_queues, p, vsi_id);
+}
+
+static u16 nbl_disp_get_vsi_global_qid(void *priv, u16 vsi_id, u16 local_qid)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	return NBL_OPS_CALL_RET(res_ops->get_vsi_global_queue_id,
+				(p, vsi_id, local_qid));
+}
+
+static u16 nbl_disp_chan_get_vsi_global_qid_req(void *priv, u16 vsi_id,
+						u16 local_qid)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_common_info *common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+	struct nbl_chan_vsi_qid_info param = { 0 };
+	struct nbl_chan_send_info chan_send;
+
+	param.vsi_id = vsi_id;
+	param.local_qid = local_qid;
+
+	NBL_CHAN_SEND(chan_send, NBL_COMMON_TO_MGT_PF(common),
+		      NBL_CHAN_MSG_GET_VSI_GLOBAL_QUEUE_ID, &param,
+		      sizeof(param), NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				  &chan_send);
+}
+
+static void nbl_disp_chan_get_vsi_global_qid_resp(void *priv, u16 src_id,
+						  u16 msg_id, void *data,
+						  u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_vsi_qid_info *param;
+	struct nbl_chan_ack_info chan_ack;
+	u16 global_qid;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+
+	param = (struct nbl_chan_vsi_qid_info *)data;
+	global_qid = NBL_OPS_CALL_RET(res_ops->get_vsi_global_queue_id,
+				      (p, param->vsi_id, param->local_qid));
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_GET_VSI_GLOBAL_QUEUE_ID,
+		     msg_id, global_qid, NULL, 0);
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static int nbl_disp_get_port_attributes(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct device *dev = NBL_COMMON_TO_DEV(disp_mgt->common);
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	int ret;
+
+	ret = NBL_OPS_CALL_RET(res_ops->get_port_attributes,
+			       (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt)));
+	if (ret)
+		dev_err(dev, "get port attributes failed with ret: %d\n", ret);
+
+	return ret;
+}
+
+static int nbl_disp_update_ring_num(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	return NBL_OPS_CALL_RET(res_ops->update_ring_num,
+				(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt)));
+}
+
+static int nbl_disp_set_ring_num(void *priv,
+				 struct nbl_cmd_net_ring_num *param)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	return NBL_OPS_CALL_RET(res_ops->set_ring_num, (p, param));
+}
+
+static int nbl_disp_get_part_number(void *priv, char *part_number)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	return NBL_OPS_CALL_RET(res_ops->get_part_number, (p, part_number));
+}
+
+static int nbl_disp_get_serial_number(void *priv, char *serial_number)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	return NBL_OPS_CALL_RET(res_ops->get_serial_number, (p, serial_number));
+}
+
+static int nbl_disp_enable_port(void *priv, bool enable)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct device *dev = NBL_COMMON_TO_DEV(disp_mgt->common);
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	int ret;
+
+	ret = NBL_OPS_CALL_RET(res_ops->enable_port, (p, enable));
+	if (ret)
+		dev_err(dev, "enable port failed with ret: %d\n", ret);
+
+	return ret;
+}
+
+static void nbl_disp_chan_recv_port_notify_resp(void *priv, u16 src_id,
+						u16 msg_id, void *data,
+						u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	NBL_OPS_CALL(res_ops->recv_port_notify, (p, data));
+}
+
+static int nbl_disp_get_link_state(void *priv, u8 eth_id,
+				   struct nbl_eth_link_info *eth_link_info)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	int ret = 0;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	/* if donot have res_ops->get_link_state(), default eth is up */
+	if (res_ops->get_link_state)
+		ret = res_ops->get_link_state(p, eth_id, eth_link_info);
+	else
+		eth_link_info->link_status = 1;
+
+	return ret;
+}
+
+static int
+nbl_disp_chan_get_link_state_req(void *priv, u8 eth_id,
+				 struct nbl_eth_link_info *eth_link_info)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_send_info chan_send;
+	struct nbl_common_info *common;
+
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_GET_LINK_STATE,
+		      &eth_id, sizeof(eth_id), eth_link_info,
+		      sizeof(*eth_link_info), 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				  &chan_send);
+}
+
+static void nbl_disp_chan_get_link_state_resp(void *priv, u16 src_id,
+					      u16 msg_id, void *data,
+					      u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	u8 eth_id;
+	struct nbl_eth_link_info eth_link_info = { 0 };
+	int ret;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+
+	eth_id = *(u8 *)data;
+	ret = res_ops->get_link_state(p, eth_id, &eth_link_info);
+	if (ret)
+		err = NBL_CHAN_RESP_ERR;
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_GET_LINK_STATE, msg_id, err,
+		     &eth_link_info, sizeof(eth_link_info));
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static int nbl_disp_set_wol(void *priv, u8 eth_id, bool enable)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	return NBL_OPS_CALL_RET(res_ops->set_wol, (p, eth_id, enable));
+}
+
+static int nbl_disp_chan_set_wol_req(void *priv, u8 eth_id, bool enable)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_send_info chan_send;
+	struct nbl_chan_param_set_wol param = { 0 };
+	struct nbl_common_info *common;
+
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	param.eth_id = eth_id;
+	param.enable = enable;
+
+	NBL_CHAN_SEND(chan_send, NBL_COMMON_TO_MGT_PF(common),
+		      NBL_CHAN_MSG_SET_WOL, &param, sizeof(param), NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				  &chan_send);
+}
+
+static void nbl_disp_chan_set_wol_resp(void *priv, u16 src_id, u16 msg_id,
+				       void *data, u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_ack_info chan_ack;
+	struct nbl_chan_param_set_wol *param;
+	int err = NBL_CHAN_RESP_OK;
+	int ret;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+
+	param = (struct nbl_chan_param_set_wol *)data;
+	ret = res_ops->set_wol(p, param->eth_id, param->enable);
+	if (ret)
+		err = NBL_CHAN_RESP_ERR;
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_SET_WOL, msg_id, err, NULL,
+		     0);
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static int nbl_disp_set_eth_mac_addr(void *priv, u8 *mac, u8 eth_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	return NBL_OPS_CALL_RET(res_ops->set_eth_mac_addr, (p, mac, eth_id));
+}
+
+static int nbl_disp_chan_set_eth_mac_addr_req(void *priv, u8 *mac, u8 eth_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_param_set_eth_mac_addr param;
+	struct nbl_chan_send_info chan_send;
+	struct nbl_common_info *common;
+
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	memcpy(param.mac, mac, sizeof(param.mac));
+	param.eth_id = eth_id;
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_SET_ETH_MAC_ADDR,
+		      &param, sizeof(param), NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				  &chan_send);
+}
+
+static void nbl_disp_chan_set_eth_mac_addr_resp(void *priv, u16 src_id,
+						u16 msg_id, void *data,
+						u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct device *dev = NBL_COMMON_TO_DEV(disp_mgt->common);
+	struct nbl_resource_ops *res_ops;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_param_set_eth_mac_addr *param;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	int ret;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	param = (struct nbl_chan_param_set_eth_mac_addr *)data;
+
+	ret = NBL_OPS_CALL_RET(res_ops->set_eth_mac_addr,
+			       (p, param->mac, param->eth_id));
+	if (ret)
+		err = NBL_CHAN_RESP_ERR;
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_SET_ETH_MAC_ADDR, msg_id,
+		     err, NULL, 0);
+	ret = chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				 &chan_ack);
+	if (ret)
+		dev_err(dev,
+			"channel send ack failed with ret: %d, msg_type: %d\n",
+			ret, NBL_CHAN_MSG_SET_ETH_MAC_ADDR);
+}
+
+static int
+nbl_disp_process_abnormal_event(void *priv,
+				struct nbl_abnormal_event_info *abnomal_info)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	return res_ops->process_abnormal_event(p, abnomal_info);
+}
+
+static void nbl_disp_adapt_desc_gother(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	NBL_OPS_CALL(res_ops->adapt_desc_gother,
+		     (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt)));
+}
+
+static void nbl_disp_flr_clear_net(void *priv, u16 vf_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->flr_clear_net, p, vf_id);
+}
+
+static void nbl_disp_flr_clear_queues(void *priv, u16 vf_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->flr_clear_queues, p, vf_id);
+}
+
+static void nbl_disp_flr_clear_flows(void *priv, u16 vf_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->flr_clear_flows, p, vf_id);
+}
+
+static void nbl_disp_flr_clear_interrupt(void *priv, u16 vf_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->flr_clear_interrupt, p, vf_id);
+}
+
+static u16 nbl_disp_covert_vfid_to_vsi_id(void *priv, u16 vfid)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	return NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->covert_vfid_to_vsi_id,
+				     p, vfid);
+}
+
+static void nbl_disp_unmask_all_interrupts(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->unmask_all_interrupts,
+			  NBL_DISP_MGT_TO_RES_PRIV(disp_mgt));
+}
+
+static void nbl_disp_keep_alive_req(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_send_info chan_send = { 0 };
+	struct nbl_common_info *common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	NBL_CHAN_SEND(chan_send, NBL_COMMON_TO_MGT_PF(common),
+		      NBL_CHAN_MSG_KEEP_ALIVE, NULL, 0, NULL, 0, 1);
+
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static void nbl_disp_chan_keep_alive_resp(void *priv, u16 src_id, u16 msg_id,
+					  void *data, u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_ack_info chan_ack;
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_KEEP_ALIVE, msg_id, 0, NULL,
+		     0);
+
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static void nbl_disp_chan_get_rep_queue_info_req(void *priv, u16 *queue_num,
+						 u16 *queue_size)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_send_info chan_send = { 0 };
+	struct nbl_chan_param_get_queue_info result = { 0 };
+	struct nbl_common_info *common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf,
+		      NBL_CHAN_MSG_GET_REP_QUEUE_INFO, NULL, 0, &result,
+		      sizeof(result), 1);
+
+	if (!chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				&chan_send)) {
+		*queue_num = result.queue_num;
+		*queue_size = result.queue_size;
+	}
+}
+
+static void nbl_disp_chan_get_rep_queue_info_resp(void *priv, u16 src_id,
+						  u16 msg_id, void *data,
+						  u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_chan_ack_info chan_ack;
+	struct nbl_chan_param_get_queue_info result = { 0 };
+	int ret = NBL_CHAN_RESP_OK;
+
+	NBL_OPS_CALL(res_ops->get_rep_queue_info,
+		     (p, &result.queue_num, &result.queue_size));
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_GET_REP_QUEUE_INFO, msg_id,
+		     ret, &result, sizeof(result));
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static void nbl_disp_get_rep_queue_info(void *priv, u16 *queue_num,
+					u16 *queue_size)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	NBL_OPS_CALL(res_ops->get_rep_queue_info, (p, queue_num, queue_size));
+}
+
+static int
+nbl_disp_passthrough_fw_cmd(void *priv,
+			    struct nbl_passthrough_fw_cmd *param,
+			    struct nbl_passthrough_fw_cmd *result)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	return NBL_OPS_CALL_RET(res_ops->passthrough_fw_cmd,
+				(p, param, result));
+}
+
+static int nbl_disp_chan_get_board_id_req(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_common_info *common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+	struct nbl_chan_send_info chan_send = { 0 };
+	int result = -1;
+
+	NBL_CHAN_SEND(chan_send, NBL_COMMON_TO_MGT_PF(common),
+		      NBL_CHAN_MSG_GET_BOARD_ID, NULL, 0, &result,
+		      sizeof(result), 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+
+	return result;
+}
+
+static void nbl_disp_chan_get_board_id_resp(void *priv, u16 src_id, u16 msg_id,
+					    void *data, u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_ack_info chan_ack;
+	int ret = NBL_CHAN_RESP_OK, result = -1;
+
+	result = NBL_OPS_CALL_RET(res_ops->get_board_id,
+				  (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt)));
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_GET_BOARD_ID, msg_id, ret,
+		     &result, sizeof(result));
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static int nbl_disp_get_board_id(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	return NBL_OPS_CALL_RET(res_ops->get_board_id,
+				(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt)));
+}
+
+static dma_addr_t nbl_disp_restore_abnormal_ring(void *priv, int ring_index,
+						 int type)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	return NBL_OPS_CALL_RET(res_ops->restore_abnormal_ring,
+				(p, ring_index, type));
+}
+
+static int nbl_disp_restart_abnormal_ring(void *priv, int ring_index, int type)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	return NBL_OPS_CALL_RET(res_ops->restart_abnormal_ring,
+				(p, ring_index, type));
+}
+
+static int nbl_disp_chan_stop_abnormal_hw_queue_req(void *priv, u16 vsi_id,
+						    u16 local_queue_id,
+						    int type)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_common_info *common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+	struct nbl_chan_param_stop_abnormal_hw_queue param = { 0 };
+	struct nbl_chan_send_info chan_send = { 0 };
+
+	param.vsi_id = vsi_id;
+	param.local_queue_id = local_queue_id;
+	param.type = type;
+
+	NBL_CHAN_SEND(chan_send, NBL_COMMON_TO_MGT_PF(common),
+		      NBL_CHAN_MSG_STOP_ABNORMAL_HW_QUEUE, &param,
+		      sizeof(param), NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				  &chan_send);
+}
+
+static void nbl_disp_chan_stop_abnormal_hw_queue_resp(void *priv, u16 src_id,
+						      u16 msg_id, void *data,
+						      u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_param_stop_abnormal_hw_queue *param = NULL;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_chan_ack_info chan_ack;
+	int ret = NBL_CHAN_RESP_OK;
+
+	param = (struct nbl_chan_param_stop_abnormal_hw_queue *)data;
+
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->stop_abnormal_hw_queue, p,
+			  param->vsi_id, param->local_queue_id, param->type);
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_STOP_ABNORMAL_HW_QUEUE,
+		     msg_id, ret, NULL, 0);
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static int nbl_disp_stop_abnormal_hw_queue(void *priv, u16 vsi_id,
+					   u16 local_queue_id, int type)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	return NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->stop_abnormal_hw_queue,
+				     p, vsi_id, local_queue_id, type);
+}
+
+static int nbl_disp_stop_abnormal_sw_queue(void *priv, u16 local_queue_id,
+					   int type)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	return NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->stop_abnormal_sw_queue,
+				     p, local_queue_id, type);
+}
+
+static u16 nbl_disp_get_local_queue_id(void *priv, u16 vsi_id,
+				       u16 global_queue_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	return NBL_OPS_CALL_RET(res_ops->get_local_queue_id,
+				(p, vsi_id, global_queue_id));
+}
+
+static u16 nbl_disp_get_vf_function_id(void *priv, u16 vsi_id, int vf_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	return NBL_OPS_CALL_RET(res_ops->get_vf_function_id,
+				(p, vsi_id, vf_id));
+}
+
+static u16 nbl_disp_chan_get_vf_function_id_req(void *priv, u16 vsi_id,
+						int vf_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_send_info chan_send = { 0 };
+	struct nbl_chan_param_get_vf_func_id param;
+	struct nbl_common_info *common;
+	u16 func_id = 0;
+
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+	param.vsi_id = vsi_id;
+	param.vf_id = vf_id;
+
+	NBL_CHAN_SEND(chan_send, NBL_COMMON_TO_MGT_PF(common),
+		      NBL_CHAN_MSG_GET_VF_FUNCTION_ID, &param, sizeof(param),
+		      &func_id, sizeof(func_id), 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+
+	return func_id;
+}
+
+static void nbl_disp_chan_get_vf_function_id_resp(void *priv, u16 src_id,
+						  u16 msg_id, void *data,
+						  u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_chan_param_get_vf_func_id *param;
+	struct nbl_chan_ack_info chan_ack;
+	int ret = NBL_CHAN_RESP_OK;
+	u16 func_id;
+
+	param = (struct nbl_chan_param_get_vf_func_id *)data;
+	func_id = NBL_OPS_CALL_RET(res_ops->get_vf_function_id,
+				   (p, param->vsi_id, param->vf_id));
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_GET_VF_FUNCTION_ID, msg_id,
+		     ret, &func_id, sizeof(func_id));
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static u16 nbl_disp_get_vf_vsi_id(void *priv, u16 vsi_id, int vf_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	return NBL_OPS_CALL_RET(res_ops->get_vf_vsi_id, (p, vsi_id, vf_id));
+}
+
+static u16 nbl_disp_chan_get_vf_vsi_id_req(void *priv, u16 vsi_id, int vf_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_send_info chan_send = { 0 };
+	struct nbl_chan_param_get_vf_vsi_id param;
+	struct nbl_common_info *common;
+	u16 vf_vsi = 0;
+
+	common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+	param.vsi_id = vsi_id;
+	param.vf_id = vf_id;
+
+	NBL_CHAN_SEND(chan_send, NBL_COMMON_TO_MGT_PF(common),
+		      NBL_CHAN_MSG_GET_VF_VSI_ID, &param, sizeof(param),
+		      &vf_vsi, sizeof(vf_vsi), 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+
+	return vf_vsi;
+}
+
+static void nbl_disp_chan_get_vf_vsi_id_resp(void *priv, u16 src_id, u16 msg_id,
+					     void *data, u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_param_get_vf_vsi_id *param;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_chan_ack_info chan_ack;
+	int ret = NBL_CHAN_RESP_OK;
+	u16 vsi_id;
+
+	param = (struct nbl_chan_param_get_vf_vsi_id *)data;
+	vsi_id = NBL_OPS_CALL_RET(res_ops->get_vf_vsi_id,
+				  (p, param->vsi_id, param->vf_id));
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_GET_VF_VSI_ID, msg_id, ret,
+		     &vsi_id, sizeof(vsi_id));
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static bool nbl_disp_check_vf_is_active(void *priv, u16 func_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	int ret;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	ret = NBL_OPS_CALL_RET(res_ops->check_vf_is_active, (p, func_id));
+	return ret;
+}
+
+static bool nbl_disp_chan_check_vf_is_active_req(void *priv, u16 func_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_common_info *common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_send_info chan_send = { 0 };
+	bool is_active;
+
+	NBL_CHAN_SEND(chan_send, NBL_COMMON_TO_MGT_PF(common),
+		      NBL_CHAN_CHECK_VF_IS_ACTIVE, &func_id, sizeof(func_id),
+		      &is_active, sizeof(is_active), 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+
+	return is_active;
+}
+
+static void nbl_disp_chan_check_vf_is_active_resp(void *priv, u16 src_id,
+						  u16 msg_id, void *data,
+						  u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(disp_mgt->common);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	u16 func_id;
+	bool is_active;
+	int ret;
+
+	func_id = *(u16 *)data;
+
+	is_active = NBL_OPS_CALL_RET(res_ops->check_vf_is_active, (p, func_id));
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_CHECK_VF_IS_ACTIVE, msg_id, err,
+		     &is_active, sizeof(is_active));
+	ret = chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				 &chan_ack);
+	if (ret)
+		dev_err(dev,
+			"channel send ack failed with ret: %d, msg_type: %d\n",
+			ret, NBL_CHAN_CHECK_VF_IS_ACTIVE);
+}
+
+static int
+nbl_disp_get_ustore_total_pkt_drop_stats(void *priv, u8 eth_id,
+					 struct nbl_ustore_stats *ustore_stats)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	int ret;
+
+	ret = NBL_OPS_CALL_RET(res_ops->get_ustore_total_pkt_drop_stats,
+			       (p, eth_id, ustore_stats));
+
+	return ret;
+}
+
+static int
+nbl_disp_chan_get_ustore_total_pkt_drop_stats_req(void *priv, u8 eth_id,
+						  struct nbl_ustore_stats *p)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_common_info *common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+	struct nbl_chan_send_info chan_send = { 0 };
+
+	NBL_CHAN_SEND(chan_send, NBL_COMMON_TO_MGT_PF(common),
+		      NBL_CHAN_GET_USTORE_TOTAL_PKT_DROP_STATS, &eth_id,
+		      sizeof(eth_id), p, sizeof(*p), 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				  &chan_send);
+}
+
+static void nbl_disp_chan_get_ustore_total_pkt_drop_stats_resp(void *priv,
+							       u16 src_id,
+							       u16 msg_id,
+							       void *data,
+							       u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_ustore_stats ustore_stats = { 0 };
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	u8 eth_id;
+
+	eth_id = *(u8 *)data;
+
+	err = NBL_OPS_CALL_RET(res_ops->get_ustore_total_pkt_drop_stats,
+			       (p, eth_id, &ustore_stats));
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_GET_USTORE_TOTAL_PKT_DROP_STATS,
+		     msg_id, err, &ustore_stats, sizeof(ustore_stats));
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static int nbl_disp_get_link_forced(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	return NBL_OPS_CALL_RET(res_ops->get_link_forced, (p, vsi_id));
+}
+
+static int nbl_disp_chan_get_link_forced_req(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_common_info *common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+	struct nbl_chan_send_info chan_send = { 0 };
+	int link_forced = 0;
+
+	NBL_CHAN_SEND(chan_send, NBL_COMMON_TO_MGT_PF(common),
+		      NBL_CHAN_MSG_GET_LINK_FORCED, &vsi_id, sizeof(vsi_id),
+		      &link_forced, sizeof(link_forced), 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+
+	return link_forced;
+}
+
+static void nbl_disp_chan_get_link_forced_resp(void *priv, u16 src_id,
+					       u16 msg_id, void *data,
+					       u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_chan_ack_info chan_ack;
+	int ret;
+
+	ret = NBL_OPS_CALL_RET(res_ops->get_link_forced, (p, *(u16 *)data));
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_GET_LINK_FORCED, msg_id,
+		     NBL_CHAN_RESP_OK, &ret, sizeof(ret));
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static int nbl_disp_get_max_mtu(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops;
+	int ret;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	ret = NBL_OPS_CALL_RET(res_ops->get_max_mtu,
+			       (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt)));
+	return ret;
+}
+
+static int nbl_disp_set_mtu(void *priv, u16 vsi_id, u16 mtu)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_resource_ops *res_ops;
+	int ret;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	ret = NBL_OPS_CALL_RET(res_ops->set_mtu, (p, vsi_id, mtu));
+	return ret;
+}
+
+static int nbl_disp_chan_set_mtu_req(void *priv, u16 vsi_id, u16 mtu)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_common_info *common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+	struct nbl_chan_send_info chan_send = { 0 };
+	struct nbl_chan_param_set_mtu param = { 0 };
+
+	param.mtu = mtu;
+	param.vsi_id = vsi_id;
+
+	NBL_CHAN_SEND(chan_send, NBL_COMMON_TO_MGT_PF(common),
+		      NBL_CHAN_MSG_MTU_SET, &param, sizeof(param), NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				  &chan_send);
+}
+
+static void nbl_disp_chan_set_mtu_resp(void *priv, u16 src_id, u16 msg_id,
+				       void *data, u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_ack_info chan_ack;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_chan_param_set_mtu *param = NULL;
+	int err = NBL_CHAN_RESP_OK;
+
+	param = (struct nbl_chan_param_set_mtu *)data;
+	err = NBL_OPS_CALL_RET(res_ops->set_mtu,
+			       (p, param->vsi_id, param->mtu));
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_MTU_SET, msg_id, err, NULL,
+		     0);
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static void nbl_disp_set_hw_status(void *priv, enum nbl_hw_status hw_status)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->set_hw_status, p, hw_status);
+}
+
+static void nbl_disp_get_active_func_bitmaps(void *priv, unsigned long *bitmap,
+					     int max_func)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->get_active_func_bitmaps, p, bitmap,
+			  max_func);
+}
+
+static void nbl_disp_register_dev_name(void *priv, u16 vsi_id, char *name)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->register_dev_name, p, vsi_id,
+			  name);
+}
+
+static void nbl_disp_chan_register_dev_name_req(void *priv, u16 vsi_id,
+						char *name)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_send_info chan_send = { 0 };
+	struct nbl_chan_param_pf_name param = { 0 };
+	struct nbl_common_info *common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	param.vsi_id = vsi_id;
+	strscpy(param.dev_name, name, IFNAMSIZ);
+
+	NBL_CHAN_SEND(chan_send, NBL_COMMON_TO_MGT_PF(common),
+		      NBL_CHAN_MSG_REGISTER_PF_NAME, &param, sizeof(param),
+		      NULL, 0, 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static void nbl_disp_chan_register_dev_name_resp(void *priv, u16 src_id,
+						 u16 msg_id, void *data,
+						 u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_chan_param_pf_name *param;
+	struct nbl_chan_ack_info chan_ack;
+	int ret = NBL_CHAN_RESP_OK;
+
+	param = (struct nbl_chan_param_pf_name *)data;
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->register_dev_name, p,
+			  param->vsi_id, param->dev_name);
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_REGISTER_PF_NAME, msg_id,
+		     ret, NULL, 0);
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static void nbl_disp_get_dev_name(void *priv, u16 vsi_id, char *name)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->get_dev_name, p, vsi_id, name);
+}
+
+static void nbl_disp_chan_get_dev_name_req(void *priv, u16 vsi_id, char *name)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_send_info chan_send = { 0 };
+	struct nbl_chan_param_pf_name param = { 0 };
+	struct nbl_chan_param_pf_name resp = { 0 };
+	struct nbl_common_info *common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	param.vsi_id = vsi_id;
+	NBL_CHAN_SEND(chan_send, NBL_COMMON_TO_MGT_PF(common),
+		      NBL_CHAN_MSG_GET_PF_NAME, &param, sizeof(param), &resp,
+		      sizeof(resp), 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+
+	strscpy(name, resp.dev_name, IFNAMSIZ);
+}
+
+static void nbl_disp_chan_get_dev_name_resp(void *priv, u16 src_id, u16 msg_id,
+					    void *data, u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_chan_param_pf_name *param;
+	struct nbl_chan_param_pf_name resp = { 0 };
+	struct nbl_chan_ack_info chan_ack;
+	int ret = NBL_CHAN_RESP_OK;
+
+	param = (struct nbl_chan_param_pf_name *)data;
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->get_dev_name, p, param->vsi_id,
+			  resp.dev_name);
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_GET_PF_NAME, msg_id, ret,
+		     &resp, sizeof(resp));
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+static int nbl_disp_check_flow_table_spec(void *priv, u16 vlan_list_cnt,
+					  u16 unicast_mac_cnt,
+					  u16 multi_mac_cnt)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	return NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->check_flow_table_spec,
+				     p, vlan_list_cnt, unicast_mac_cnt,
+				     multi_mac_cnt);
+}
+
+static int nbl_disp_chan_check_flow_table_spec_req(void *priv,
+						   u16 vlan_list_cnt,
+						   u16 unicast_mac_cnt,
+						   u16 multi_mac_cnt)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_send_info chan_send = { 0 };
+	struct nbl_chan_param_check_flow_spec param = { 0 };
+	struct nbl_common_info *common = NBL_DISP_MGT_TO_COMMON(disp_mgt);
+
+	param.vlan_list_cnt = vlan_list_cnt;
+	param.unicast_mac_cnt = unicast_mac_cnt;
+	param.multi_mac_cnt = multi_mac_cnt;
+
+	NBL_CHAN_SEND(chan_send, NBL_COMMON_TO_MGT_PF(common),
+		      NBL_CHAN_MSG_CHECK_FLOWTABLE_SPEC, &param, sizeof(param),
+		      NULL, 0, 1);
+
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				  &chan_send);
+}
+
+static void nbl_disp_chan_check_flow_table_spec_resp(void *priv, u16 src_id,
+						     u16 msg_id, void *data,
+						     u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	struct nbl_chan_param_check_flow_spec *param = NULL;
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+	struct nbl_chan_ack_info chan_ack;
+	int ret;
+
+	param = (struct nbl_chan_param_check_flow_spec *)data;
+	ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->check_flow_table_spec, p,
+				    param->vlan_list_cnt,
+				    param->unicast_mac_cnt,
+				    param->multi_mac_cnt);
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_CHECK_FLOWTABLE_SPEC,
+		     msg_id, ret, NULL, 0);
+	chan_ops->send_ack(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_ack);
+}
+
+/* NBL_DISP_SET_OPS(disp_op_name, func, ctrl_lvl, msg_type, msg_req, msg_resp)
+ * ctrl_lvl is to define when this disp_op should go directly to res_op,
+ * not sending a channel msg.
+ * Use X Macros to reduce codes in channel_op and disp_op setup/remove
+ */
+#define NBL_DISP_OPS_TBL						\
+do {									\
+	NBL_DISP_SET_OPS(init_chip_module, nbl_disp_init_chip_module,	\
+			 NBL_DISP_CTRL_LVL_MGT, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(deinit_chip_module,				\
+			 nbl_disp_deinit_chip_module,			\
+			 NBL_DISP_CTRL_LVL_MGT, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(get_resource_pt_ops, nbl_disp_get_res_pt_ops,	\
+			 NBL_DISP_CTRL_LVL_NET, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(queue_init, nbl_disp_queue_init,		\
+			 NBL_DISP_CTRL_LVL_MGT, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(vsi_init, nbl_disp_vsi_init,			\
+			 NBL_DISP_CTRL_LVL_MGT, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(init_vf_msix_map, nbl_disp_init_vf_msix_map,	\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_INIT_VF_MSIX_MAP,			\
+			 nbl_disp_chan_init_vf_msix_map_req,		\
+			 nbl_disp_chan_init_vf_msix_map_resp);		\
+	NBL_DISP_SET_OPS(configure_msix_map,				\
+			 nbl_disp_configure_msix_map,			\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_CONFIGURE_MSIX_MAP,		\
+			 nbl_disp_chan_configure_msix_map_req,		\
+			 nbl_disp_chan_configure_msix_map_resp);	\
+	NBL_DISP_SET_OPS(destroy_msix_map, nbl_disp_destroy_msix_map,	\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_DESTROY_MSIX_MAP,			\
+			 nbl_disp_chan_destroy_msix_map_req,		\
+			 nbl_disp_chan_destroy_msix_map_resp);		\
+	NBL_DISP_SET_OPS(enable_mailbox_irq,				\
+			 nbl_disp_enable_mailbox_irq,			\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_MAILBOX_ENABLE_IRQ,		\
+			 nbl_disp_chan_enable_mailbox_irq_req,		\
+			 nbl_disp_chan_enable_mailbox_irq_resp);	\
+	NBL_DISP_SET_OPS(enable_abnormal_irq,				\
+			 nbl_disp_enable_abnormal_irq,			\
+			 NBL_DISP_CTRL_LVL_MGT, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(enable_adminq_irq,				\
+			 nbl_disp_enable_adminq_irq,			\
+			 NBL_DISP_CTRL_LVL_MGT, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(get_global_vector, nbl_disp_get_global_vector,	\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_GET_GLOBAL_VECTOR,		\
+			 nbl_disp_chan_get_global_vector_req,		\
+			 nbl_disp_chan_get_global_vector_resp);		\
+	NBL_DISP_SET_OPS(get_msix_entry_id, nbl_disp_get_msix_entry_id,	\
+			 NBL_DISP_CTRL_LVL_NET, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(alloc_rings, nbl_disp_alloc_rings,		\
+			 NBL_DISP_CTRL_LVL_NET, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(remove_rings, nbl_disp_remove_rings,		\
+			 NBL_DISP_CTRL_LVL_NET, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(start_tx_ring, nbl_disp_start_tx_ring,		\
+			 NBL_DISP_CTRL_LVL_NET, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(stop_tx_ring, nbl_disp_stop_tx_ring,		\
+			 NBL_DISP_CTRL_LVL_NET, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(start_rx_ring, nbl_disp_start_rx_ring,		\
+			 NBL_DISP_CTRL_LVL_NET, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(stop_rx_ring, nbl_disp_stop_rx_ring,		\
+			 NBL_DISP_CTRL_LVL_NET, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(kick_rx_ring, nbl_disp_kick_rx_ring,		\
+			 NBL_DISP_CTRL_LVL_NET, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(get_vector_napi, nbl_disp_get_vector_napi,	\
+			 NBL_DISP_CTRL_LVL_NET, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(set_vector_info, nbl_disp_set_vector_info,	\
+			 NBL_DISP_CTRL_LVL_NET, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(register_vsi_ring, nbl_disp_register_vsi_ring,	\
+			 NBL_DISP_CTRL_LVL_NET, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(register_net, nbl_disp_register_net,		\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_REGISTER_NET,			\
+			 nbl_disp_chan_register_net_req,		\
+			 nbl_disp_chan_register_net_resp);		\
+	NBL_DISP_SET_OPS(unregister_net, nbl_disp_unregister_net,	\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_UNREGISTER_NET,			\
+			 nbl_disp_chan_unregister_net_req,		\
+			 nbl_disp_chan_unregister_net_resp);		\
+	NBL_DISP_SET_OPS(alloc_txrx_queues, nbl_disp_alloc_txrx_queues,	\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_ALLOC_TXRX_QUEUES,		\
+			 nbl_disp_chan_alloc_txrx_queues_req,		\
+			 nbl_disp_chan_alloc_txrx_queues_resp);		\
+	NBL_DISP_SET_OPS(free_txrx_queues, nbl_disp_free_txrx_queues,	\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_FREE_TXRX_QUEUES,			\
+			 nbl_disp_chan_free_txrx_queues_req,		\
+			 nbl_disp_chan_free_txrx_queues_resp);		\
+	NBL_DISP_SET_OPS(register_vsi2q, nbl_disp_register_vsi2q,	\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_REGISTER_VSI2Q,			\
+			 nbl_disp_chan_register_vsi2q_req,		\
+			 nbl_disp_chan_register_vsi2q_resp);		\
+	NBL_DISP_SET_OPS(setup_q2vsi, nbl_disp_setup_q2vsi,		\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_SETUP_Q2VSI,\
+			 nbl_disp_chan_setup_q2vsi_req,			\
+			 nbl_disp_chan_setup_q2vsi_resp);		\
+	NBL_DISP_SET_OPS(remove_q2vsi, nbl_disp_remove_q2vsi,		\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_REMOVE_Q2VSI,\
+			 nbl_disp_chan_remove_q2vsi_req,		\
+			 nbl_disp_chan_remove_q2vsi_resp);		\
+	NBL_DISP_SET_OPS(setup_rss, nbl_disp_setup_rss,			\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_SETUP_RSS,	\
+			 nbl_disp_chan_setup_rss_req,			\
+			 nbl_disp_chan_setup_rss_resp);			\
+	NBL_DISP_SET_OPS(remove_rss, nbl_disp_remove_rss,		\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_REMOVE_RSS,\
+			 nbl_disp_chan_remove_rss_req,			\
+			 nbl_disp_chan_remove_rss_resp);		\
+	NBL_DISP_SET_OPS(setup_queue, nbl_disp_setup_queue,		\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_SETUP_QUEUE,\
+			 nbl_disp_chan_setup_queue_req,			\
+			 nbl_disp_chan_setup_queue_resp);		\
+	NBL_DISP_SET_OPS(remove_all_queues, nbl_disp_remove_all_queues,	\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_REMOVE_ALL_QUEUES,		\
+			 nbl_disp_chan_remove_all_queues_req,		\
+			 nbl_disp_chan_remove_all_queues_resp);		\
+	NBL_DISP_SET_OPS(cfg_dsch, nbl_disp_cfg_dsch,			\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_CFG_DSCH,	\
+			 nbl_disp_chan_cfg_dsch_req,			\
+			 nbl_disp_chan_cfg_dsch_resp);			\
+	NBL_DISP_SET_OPS(setup_cqs, nbl_disp_setup_cqs,			\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_SETUP_CQS,	\
+			 nbl_disp_chan_setup_cqs_req,			\
+			 nbl_disp_chan_setup_cqs_resp);			\
+	NBL_DISP_SET_OPS(remove_cqs, nbl_disp_remove_cqs,		\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_REMOVE_CQS,\
+			 nbl_disp_chan_remove_cqs_req,			\
+			 nbl_disp_chan_remove_cqs_resp);		\
+	NBL_DISP_SET_OPS(get_msix_irq_enable_info,			\
+			 nbl_disp_get_msix_irq_enable_info,		\
+			 NBL_DISP_CTRL_LVL_NET, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(add_macvlan, nbl_disp_add_macvlan,		\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_ADD_MACVLAN,\
+			 nbl_disp_chan_add_macvlan_req,			\
+			 nbl_disp_chan_add_macvlan_resp);		\
+	NBL_DISP_SET_OPS(del_macvlan, nbl_disp_del_macvlan,		\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_DEL_MACVLAN,\
+			 nbl_disp_chan_del_macvlan_req,			\
+			 nbl_disp_chan_del_macvlan_resp);		\
+	NBL_DISP_SET_OPS(add_multi_rule, nbl_disp_add_multi_rule,	\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_ADD_MULTI_RULE,\
+			 nbl_disp_chan_add_multi_rule_req,		\
+			 nbl_disp_chan_add_multi_rule_resp);		\
+	NBL_DISP_SET_OPS(del_multi_rule, nbl_disp_del_multi_rule,	\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_DEL_MULTI_RULE,\
+			 nbl_disp_chan_del_multi_rule_req,		\
+			 nbl_disp_chan_del_multi_rule_resp);		\
+	NBL_DISP_SET_OPS(cfg_multi_mcast, nbl_disp_cfg_multi_mcast,	\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_CFG_MULTI_MCAST_RULE,		\
+			 nbl_disp_chan_cfg_multi_mcast_req,		\
+			 nbl_disp_chan_cfg_multi_mcast_resp);		\
+	NBL_DISP_SET_OPS(setup_multi_group, nbl_disp_setup_multi_group,	\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_SETUP_MULTI_GROUP,		\
+			 nbl_disp_chan_setup_multi_group_req,		\
+			 nbl_disp_chan_setup_multi_group_resp);		\
+	NBL_DISP_SET_OPS(remove_multi_group, nbl_disp_remove_multi_group,\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_REMOVE_MULTI_GROUP,\
+			 nbl_disp_chan_remove_multi_group_req,		\
+			 nbl_disp_chan_remove_multi_group_resp);	\
+	NBL_DISP_SET_OPS(get_vsi_id, nbl_disp_get_vsi_id,		\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_GET_VSI_ID,\
+			 nbl_disp_chan_get_vsi_id_req,			\
+			 nbl_disp_chan_get_vsi_id_resp);		\
+	NBL_DISP_SET_OPS(get_eth_id, nbl_disp_get_eth_id,		\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_GET_ETH_ID,\
+			 nbl_disp_chan_get_eth_id_req,			\
+			 nbl_disp_chan_get_eth_id_resp);		\
+	NBL_DISP_SET_OPS(add_lldp_flow, nbl_disp_add_lldp_flow,		\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_ADD_LLDP_FLOW,\
+			 nbl_disp_chan_add_lldp_flow_req,		\
+			 nbl_disp_chan_add_lldp_flow_resp);		\
+	NBL_DISP_SET_OPS(del_lldp_flow, nbl_disp_del_lldp_flow,		\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_DEL_LLDP_FLOW,\
+			 nbl_disp_chan_del_lldp_flow_req,		\
+			 nbl_disp_chan_del_lldp_flow_resp);		\
+	NBL_DISP_SET_OPS(set_promisc_mode, nbl_disp_set_promisc_mode,	\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_SET_PROSISC_MODE,\
+			 nbl_disp_chan_set_promisc_mode_req,		\
+			 nbl_disp_chan_set_promisc_mode_resp);		\
+	NBL_DISP_SET_OPS(get_tx_headroom, nbl_disp_get_tx_headroom,	\
+			 NBL_DISP_CTRL_LVL_NET, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(get_net_stats, nbl_disp_get_net_stats,		\
+			 NBL_DISP_CTRL_LVL_NET, -1, NULL, NULL);	\
+	NBL_DISP_SET_OPS(get_rxfh_indir_size, nbl_disp_get_rxfh_indir_size,\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_GET_RXFH_INDIR_SIZE,\
+			 nbl_disp_chan_get_rxfh_indir_size_req,		\
+			 nbl_disp_chan_get_rxfh_indir_size_resp);	\
+	NBL_DISP_SET_OPS(set_rxfh_indir, nbl_disp_set_rxfh_indir,	\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_SET_RXFH_INDIR,\
+			 nbl_disp_chan_set_rxfh_indir_req,		\
+			 nbl_disp_chan_set_rxfh_indir_resp);		\
+	NBL_DISP_SET_OPS(cfg_txrx_vlan, nbl_disp_cfg_txrx_vlan,		\
+			 NBL_DISP_CTRL_LVL_NET,	-1, NULL, NULL);	\
+	NBL_DISP_SET_OPS(get_hw_addr, nbl_disp_get_hw_addr,		\
+			 NBL_DISP_CTRL_LVL_ALWAYS, -1, NULL, NULL);	\
+	NBL_DISP_SET_OPS(get_function_id, nbl_disp_get_function_id,	\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_GET_FUNCTION_ID,\
+			 nbl_disp_chan_get_function_id_req,		\
+			 nbl_disp_chan_get_function_id_resp);		\
+	NBL_DISP_SET_OPS(get_real_bdf, nbl_disp_get_real_bdf,		\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_GET_REAL_BDF,\
+			 nbl_disp_chan_get_real_bdf_req,		\
+			 nbl_disp_chan_get_real_bdf_resp);	\
+	NBL_DISP_SET_OPS(check_fw_heartbeat, nbl_disp_check_fw_heartbeat,\
+			 NBL_DISP_CTRL_LVL_MGT, -1, NULL, NULL);	\
+	NBL_DISP_SET_OPS(check_fw_reset, nbl_disp_check_fw_reset,	\
+			 NBL_DISP_CTRL_LVL_MGT, -1, NULL, NULL);	\
+	NBL_DISP_SET_OPS(set_sfp_state, nbl_disp_set_sfp_state,		\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_SET_SFP_STATE,\
+			 nbl_disp_chan_set_sfp_state_req,		\
+			 nbl_disp_chan_set_sfp_state_resp);		\
+	NBL_DISP_SET_OPS(passthrough_fw_cmd, nbl_disp_passthrough_fw_cmd,\
+			 NBL_DISP_CTRL_LVL_MGT, -1, NULL, NULL);	\
+	NBL_DISP_SET_OPS(get_product_fix_cap, nbl_disp_get_product_fix_cap,\
+			 NBL_DISP_CTRL_LVL_ALWAYS, -1, NULL, NULL);	\
+	NBL_DISP_SET_OPS(get_mbx_irq_num, nbl_disp_get_mbx_irq_num,	\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_GET_MBX_IRQ_NUM,\
+			 nbl_disp_chan_get_mbx_irq_num_req,		\
+			 nbl_disp_chan_get_mbx_irq_num_resp);		\
+	NBL_DISP_SET_OPS(get_adminq_irq_num, nbl_disp_get_adminq_irq_num,\
+			 NBL_DISP_CTRL_LVL_MGT, -1, NULL, NULL);	\
+	NBL_DISP_SET_OPS(get_abnormal_irq_num, nbl_disp_get_abnormal_irq_num,\
+			 NBL_DISP_CTRL_LVL_MGT, -1, NULL, NULL);	\
+	NBL_DISP_SET_OPS(clear_flow, nbl_disp_clear_flow,		\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_CLEAR_FLOW,\
+			 nbl_disp_chan_clear_flow_req,			\
+			 nbl_disp_chan_clear_flow_resp);		\
+	NBL_DISP_SET_OPS(clear_queues, nbl_disp_clear_queues,		\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_CLEAR_QUEUE,\
+			 nbl_disp_chan_clear_queues_req,		\
+			 nbl_disp_chan_clear_queues_resp);		\
+	NBL_DISP_SET_OPS(get_board_id, nbl_disp_get_board_id,		\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_GET_BOARD_ID,\
+			 nbl_disp_chan_get_board_id_req,		\
+			 nbl_disp_chan_get_board_id_resp);		\
+	NBL_DISP_SET_OPS(restore_abnormal_ring,				\
+			 nbl_disp_restore_abnormal_ring,		\
+			 NBL_DISP_CTRL_LVL_NET, -1, NULL, NULL);	\
+	NBL_DISP_SET_OPS(restart_abnormal_ring,				\
+			 nbl_disp_restart_abnormal_ring,		\
+			 NBL_DISP_CTRL_LVL_NET, -1, NULL, NULL);	\
+	NBL_DISP_SET_OPS(stop_abnormal_hw_queue,			\
+			 nbl_disp_stop_abnormal_hw_queue,		\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_STOP_ABNORMAL_HW_QUEUE,		\
+			 nbl_disp_chan_stop_abnormal_hw_queue_req,	\
+			 nbl_disp_chan_stop_abnormal_hw_queue_resp);	\
+	NBL_DISP_SET_OPS(stop_abnormal_sw_queue,			\
+			 nbl_disp_stop_abnormal_sw_queue,		\
+			 NBL_DISP_CTRL_LVL_NET, -1, NULL, NULL);	\
+	NBL_DISP_SET_OPS(get_local_queue_id, nbl_disp_get_local_queue_id,\
+			 NBL_DISP_CTRL_LVL_MGT, -1, NULL, NULL);	\
+	NBL_DISP_SET_OPS(get_vsi_global_queue_id, nbl_disp_get_vsi_global_qid,\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_GET_VSI_GLOBAL_QUEUE_ID,		\
+			 nbl_disp_chan_get_vsi_global_qid_req,		\
+			 nbl_disp_chan_get_vsi_global_qid_resp);	\
+	NBL_DISP_SET_OPS(get_port_attributes, nbl_disp_get_port_attributes,\
+			 NBL_DISP_CTRL_LVL_MGT, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(update_ring_num, nbl_disp_update_ring_num,	\
+			 NBL_DISP_CTRL_LVL_MGT, -1, NULL, NULL);	\
+	NBL_DISP_SET_OPS(set_ring_num, nbl_disp_set_ring_num,		\
+			 NBL_DISP_CTRL_LVL_MGT, -1, NULL, NULL);	\
+	NBL_DISP_SET_OPS(get_part_number, nbl_disp_get_part_number,	\
+			 NBL_DISP_CTRL_LVL_MGT, -1, NULL, NULL);	\
+	NBL_DISP_SET_OPS(get_serial_number, nbl_disp_get_serial_number,	\
+			 NBL_DISP_CTRL_LVL_MGT, -1, NULL, NULL);	\
+	NBL_DISP_SET_OPS(enable_port, nbl_disp_enable_port,		\
+			 NBL_DISP_CTRL_LVL_MGT, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(dummy_func, NULL,				\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_ADMINQ_PORT_NOTIFY,		\
+			 NULL,						\
+			 nbl_disp_chan_recv_port_notify_resp);		\
+	NBL_DISP_SET_OPS(get_link_state, nbl_disp_get_link_state,	\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_GET_LINK_STATE,\
+			 nbl_disp_chan_get_link_state_req,		\
+			 nbl_disp_chan_get_link_state_resp);		\
+	NBL_DISP_SET_OPS(set_wol, nbl_disp_set_wol,			\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_SET_WOL,	\
+			 nbl_disp_chan_set_wol_req,			\
+			 nbl_disp_chan_set_wol_resp);			\
+	NBL_DISP_SET_OPS(set_eth_mac_addr, nbl_disp_set_eth_mac_addr,	\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_SET_ETH_MAC_ADDR,\
+			 nbl_disp_chan_set_eth_mac_addr_req,		\
+			 nbl_disp_chan_set_eth_mac_addr_resp);		\
+	NBL_DISP_SET_OPS(process_abnormal_event,			\
+			 nbl_disp_process_abnormal_event,		\
+			 NBL_DISP_CTRL_LVL_MGT, -1, NULL, NULL);	\
+	NBL_DISP_SET_OPS(adapt_desc_gother, nbl_disp_adapt_desc_gother,	\
+			 NBL_DISP_CTRL_LVL_MGT, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(flr_clear_net, nbl_disp_flr_clear_net,		\
+			 NBL_DISP_CTRL_LVL_MGT, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(flr_clear_queues, nbl_disp_flr_clear_queues,	\
+			 NBL_DISP_CTRL_LVL_MGT, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(flr_clear_flows, nbl_disp_flr_clear_flows,	\
+			 NBL_DISP_CTRL_LVL_MGT, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(flr_clear_interrupt, nbl_disp_flr_clear_interrupt,\
+			 NBL_DISP_CTRL_LVL_MGT, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(covert_vfid_to_vsi_id, nbl_disp_covert_vfid_to_vsi_id,\
+			 NBL_DISP_CTRL_LVL_MGT, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(unmask_all_interrupts, nbl_disp_unmask_all_interrupts,\
+			 NBL_DISP_CTRL_LVL_MGT, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(keep_alive, nbl_disp_keep_alive_req,		\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_KEEP_ALIVE,\
+			 nbl_disp_keep_alive_req,			\
+			 nbl_disp_chan_keep_alive_resp);		\
+	NBL_DISP_SET_OPS(get_rep_queue_info, nbl_disp_get_rep_queue_info,\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_GET_REP_QUEUE_INFO,		\
+			 nbl_disp_chan_get_rep_queue_info_req,		\
+			 nbl_disp_chan_get_rep_queue_info_resp);	\
+	NBL_DISP_SET_OPS(get_vf_function_id, nbl_disp_get_vf_function_id,\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_GET_VF_FUNCTION_ID,		\
+			 nbl_disp_chan_get_vf_function_id_req,		\
+			 nbl_disp_chan_get_vf_function_id_resp);	\
+	NBL_DISP_SET_OPS(get_vf_vsi_id, nbl_disp_get_vf_vsi_id,		\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_GET_VF_VSI_ID,\
+			 nbl_disp_chan_get_vf_vsi_id_req,		\
+			 nbl_disp_chan_get_vf_vsi_id_resp);		\
+	NBL_DISP_SET_OPS(check_vf_is_active, nbl_disp_check_vf_is_active,\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_CHECK_VF_IS_ACTIVE,\
+			 nbl_disp_chan_check_vf_is_active_req,		\
+			 nbl_disp_chan_check_vf_is_active_resp);	\
+	NBL_DISP_SET_OPS(get_ustore_total_pkt_drop_stats,		\
+			 nbl_disp_get_ustore_total_pkt_drop_stats,	\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_GET_USTORE_TOTAL_PKT_DROP_STATS,	\
+			 nbl_disp_chan_get_ustore_total_pkt_drop_stats_req,\
+			 nbl_disp_chan_get_ustore_total_pkt_drop_stats_resp);\
+	NBL_DISP_SET_OPS(get_link_forced, nbl_disp_get_link_forced,	\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_GET_LINK_FORCED,\
+			 nbl_disp_chan_get_link_forced_req,		\
+			 nbl_disp_chan_get_link_forced_resp);		\
+	NBL_DISP_SET_OPS(set_mtu, nbl_disp_set_mtu,			\
+			 NBL_DISP_CTRL_LVL_MGT,	NBL_CHAN_MSG_MTU_SET,	\
+			 nbl_disp_chan_set_mtu_req,			\
+			 nbl_disp_chan_set_mtu_resp);			\
+	NBL_DISP_SET_OPS(get_max_mtu, nbl_disp_get_max_mtu,		\
+			 NBL_DISP_CTRL_LVL_NET,	-1, NULL, NULL);	\
+	NBL_DISP_SET_OPS(set_hw_status, nbl_disp_set_hw_status,		\
+			 NBL_DISP_CTRL_LVL_ALWAYS, -1, NULL, NULL);	\
+	NBL_DISP_SET_OPS(get_active_func_bitmaps,			\
+			 nbl_disp_get_active_func_bitmaps,		\
+			 NBL_DISP_CTRL_LVL_ALWAYS, -1, NULL, NULL);	\
+	NBL_DISP_SET_OPS(register_dev_name, nbl_disp_register_dev_name,	\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_REGISTER_PF_NAME,			\
+			 nbl_disp_chan_register_dev_name_req,		\
+			 nbl_disp_chan_register_dev_name_resp);		\
+	NBL_DISP_SET_OPS(get_dev_name, nbl_disp_get_dev_name,		\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_GET_PF_NAME,\
+			 nbl_disp_chan_get_dev_name_req,		\
+			 nbl_disp_chan_get_dev_name_resp);		\
+	NBL_DISP_SET_OPS(check_flow_table_spec, nbl_disp_check_flow_table_spec,\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_CHECK_FLOWTABLE_SPEC,		\
+			 nbl_disp_chan_check_flow_table_spec_req,	\
+			 nbl_disp_chan_check_flow_table_spec_resp);	\
+} while (0)
+
+/* Structure starts here, adding an op should not modify anything below */
+static int nbl_disp_setup_msg(struct nbl_dispatch_mgt *disp_mgt)
+{
+	struct nbl_dispatch_ops *disp_ops = NBL_DISP_MGT_TO_DISP_OPS(disp_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt);
+	int ret = 0;
+
+	if (!chan_ops->check_queue_exist(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+					 NBL_CHAN_TYPE_MAILBOX))
+		return 0;
+
+	mutex_init(&disp_mgt->ops_mutex_lock);
+	spin_lock_init(&disp_mgt->ops_spin_lock);
+	disp_mgt->ops_lock_required = true;
+
+#define NBL_DISP_SET_OPS(disp_op, func, ctrl, msg_type, msg_req, resp) \
+do {									\
+	typeof(msg_type) _msg_type = (msg_type);			\
+	typeof(ctrl) _ctrl_lvl = (ctrl);			\
+	(void)(disp_ops->NBL_NAME(disp_op));				\
+	(void)(func);						\
+	(void)(msg_req);						\
+	(void)_ctrl_lvl;						\
+	if (_msg_type >= 0)					\
+		ret += chan_ops->register_msg(p, _msg_type, resp, disp_mgt);\
+} while (0)
+	NBL_DISP_OPS_TBL;
+#undef  NBL_DISP_SET_OPS
+
+	return ret;
+}
+
+/* Ctrl lvl means that if a certain level is set, then all disp_ops that
+ * decleared this lvl will go directly to res_ops, rather than send a
+ * channel msg, and vice versa.
+ */
+static int nbl_disp_setup_ctrl_lvl(struct nbl_dispatch_mgt *disp_mgt, u32 lvl)
+{
+	struct nbl_dispatch_ops *disp_ops;
+
+	disp_ops = NBL_DISP_MGT_TO_DISP_OPS(disp_mgt);
+
+	set_bit(lvl, disp_mgt->ctrl_lvl);
+
+#define NBL_DISP_SET_OPS(disp_op, func, ctrl, msg_type, msg_req, msg_resp) \
+do {									\
+	typeof(msg_type) _msg_type = (msg_type);			\
+	(void)(_msg_type);						\
+	(void)(msg_resp);						\
+	disp_ops->NBL_NAME(disp_op) =					\
+		test_bit(ctrl, disp_mgt->ctrl_lvl) ? func : msg_req; ;\
+} while (0)
+	NBL_DISP_OPS_TBL;
+#undef  NBL_DISP_SET_OPS
+
+	return 0;
+}
+
+static int nbl_disp_setup_disp_mgt(struct nbl_common_info *common,
+				   struct nbl_dispatch_mgt **disp_mgt)
+{
+	struct device *dev;
+
+	dev = NBL_COMMON_TO_DEV(common);
+	*disp_mgt =
+		devm_kzalloc(dev, sizeof(struct nbl_dispatch_mgt), GFP_KERNEL);
+	if (!*disp_mgt)
+		return -ENOMEM;
+
+	NBL_DISP_MGT_TO_COMMON(*disp_mgt) = common;
+	return 0;
+}
+
+static void nbl_disp_remove_disp_mgt(struct nbl_common_info *common,
+				     struct nbl_dispatch_mgt **disp_mgt)
+{
+	struct device *dev;
+
+	dev = NBL_COMMON_TO_DEV(common);
+	devm_kfree(dev, *disp_mgt);
+	*disp_mgt = NULL;
+}
+
+static void nbl_disp_remove_ops(struct device *dev,
+				struct nbl_dispatch_ops_tbl **disp_ops_tbl)
+{
+	devm_kfree(dev, NBL_DISP_OPS_TBL_TO_OPS(*disp_ops_tbl));
+	devm_kfree(dev, *disp_ops_tbl);
+	*disp_ops_tbl = NULL;
+}
+
+static int nbl_disp_setup_ops(struct device *dev,
+			      struct nbl_dispatch_ops_tbl **disp_ops_tbl,
+			      struct nbl_dispatch_mgt *disp_mgt)
+{
+	struct nbl_dispatch_ops *disp_ops;
+
+	*disp_ops_tbl = devm_kzalloc(dev, sizeof(struct nbl_dispatch_ops_tbl),
+				     GFP_KERNEL);
+	if (!*disp_ops_tbl)
+		return -ENOMEM;
+
+	disp_ops =
+		devm_kzalloc(dev, sizeof(struct nbl_dispatch_ops), GFP_KERNEL);
+	if (!disp_ops)
+		return -ENOMEM;
+
+	NBL_DISP_OPS_TBL_TO_OPS(*disp_ops_tbl) = disp_ops;
+	NBL_DISP_OPS_TBL_TO_PRIV(*disp_ops_tbl) = disp_mgt;
+
+	return 0;
+}
+
+int nbl_disp_init(void *p, struct nbl_init_param *param)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct nbl_dispatch_mgt **disp_mgt =
+		(struct nbl_dispatch_mgt **)&NBL_ADAP_TO_DISP_MGT(adapter);
+	struct nbl_dispatch_ops_tbl **disp_ops_tbl =
+		&NBL_ADAP_TO_DISP_OPS_TBL(adapter);
+	struct nbl_resource_ops_tbl *res_ops_tbl =
+		NBL_ADAP_TO_RES_OPS_TBL(adapter);
+	struct nbl_channel_ops_tbl *chan_ops_tbl =
+		NBL_ADAP_TO_CHAN_OPS_TBL(adapter);
+	struct nbl_common_info *common = NBL_ADAP_TO_COMMON(adapter);
+	struct device *dev = NBL_ADAP_TO_DEV(adapter);
+	int ret;
+
+	ret = nbl_disp_setup_disp_mgt(common, disp_mgt);
+	if (ret)
+		goto setup_mgt_fail;
+
+	ret = nbl_disp_setup_ops(dev, disp_ops_tbl, *disp_mgt);
+	if (ret)
+		goto setup_ops_fail;
+
+	NBL_DISP_MGT_TO_RES_OPS_TBL(*disp_mgt) = res_ops_tbl;
+	NBL_DISP_MGT_TO_CHAN_OPS_TBL(*disp_mgt) = chan_ops_tbl;
+	NBL_DISP_MGT_TO_DISP_OPS_TBL(*disp_mgt) = *disp_ops_tbl;
+
+	ret = nbl_disp_setup_msg(*disp_mgt);
+	if (ret)
+		goto setup_msg_fail;
+
+	if (param->caps.has_ctrl) {
+		ret = nbl_disp_setup_ctrl_lvl(*disp_mgt, NBL_DISP_CTRL_LVL_MGT);
+		if (ret)
+			goto setup_msg_fail;
+	}
+
+	if (param->caps.has_net) {
+		ret = nbl_disp_setup_ctrl_lvl(*disp_mgt, NBL_DISP_CTRL_LVL_NET);
+		if (ret)
+			goto setup_msg_fail;
+	}
+
+	ret = nbl_disp_setup_ctrl_lvl(*disp_mgt, NBL_DISP_CTRL_LVL_ALWAYS);
+	if (ret)
+		goto setup_msg_fail;
+
+	return 0;
+
+setup_msg_fail:
+	nbl_disp_remove_ops(dev, disp_ops_tbl);
+setup_ops_fail:
+	nbl_disp_remove_disp_mgt(common, disp_mgt);
+setup_mgt_fail:
+	return ret;
+}
+
+void nbl_disp_remove(void *p)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct nbl_dispatch_ops_tbl **disp_ops_tbl;
+	struct nbl_dispatch_mgt **disp_mgt;
+	struct nbl_common_info *common;
+	struct device *dev;
+
+	dev = NBL_ADAP_TO_DEV(adapter);
+	common = NBL_ADAP_TO_COMMON(adapter);
+	disp_mgt = (struct nbl_dispatch_mgt **)&NBL_ADAP_TO_DISP_MGT(adapter);
+	disp_ops_tbl = &NBL_ADAP_TO_DISP_OPS_TBL(adapter);
+
+	nbl_disp_remove_ops(dev, disp_ops_tbl);
+
+	nbl_disp_remove_disp_mgt(common, disp_mgt);
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
new file mode 100644
index 000000000000..541603b52054
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_DISPATCH_H_
+#define _NBL_DISPATCH_H_
+
+#include "nbl_core.h"
+
+#define NBL_DISP_MGT_TO_COMMON(disp_mgt)	((disp_mgt)->common)
+#define NBL_DISP_MGT_TO_DEV(disp_mgt) \
+	NBL_COMMON_TO_DEV(NBL_DISP_MGT_TO_COMMON(disp_mgt))
+
+#define NBL_DISP_MGT_TO_RES_OPS_TBL(disp_mgt)	((disp_mgt)->res_ops_tbl)
+#define NBL_DISP_MGT_TO_RES_OPS(disp_mgt) \
+	(NBL_DISP_MGT_TO_RES_OPS_TBL(disp_mgt)->ops)
+#define NBL_DISP_MGT_TO_RES_PRIV(disp_mgt) \
+	(NBL_DISP_MGT_TO_RES_OPS_TBL(disp_mgt)->priv)
+#define NBL_DISP_MGT_TO_CHAN_OPS_TBL(disp_mgt)	((disp_mgt)->chan_ops_tbl)
+#define NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt) \
+	(NBL_DISP_MGT_TO_CHAN_OPS_TBL(disp_mgt)->ops)
+#define NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt) \
+	(NBL_DISP_MGT_TO_CHAN_OPS_TBL(disp_mgt)->priv)
+#define NBL_DISP_MGT_TO_DISP_OPS_TBL(disp_mgt)	((disp_mgt)->disp_ops_tbl)
+#define NBL_DISP_MGT_TO_DISP_OPS(disp_mgt) \
+	(NBL_DISP_MGT_TO_DISP_OPS_TBL(disp_mgt)->ops)
+#define NBL_DISP_MGT_TO_DISP_PRIV(disp_mgt) \
+	(NBL_DISP_MGT_TO_DISP_OPS_TBL(disp_mgt)->priv)
+
+#define NBL_OPS_CALL_LOCK(disp_mgt, func, ...)				\
+do {									\
+	typeof(disp_mgt) _disp_mgt = (disp_mgt);			\
+	typeof(func) _func = (func);					\
+									\
+	if (_disp_mgt->ops_lock_required)				\
+		mutex_lock(&_disp_mgt->ops_mutex_lock);			\
+									\
+	if (_func)							\
+		_func(__VA_ARGS__);					\
+									\
+	if (_disp_mgt->ops_lock_required)				\
+		mutex_unlock(&_disp_mgt->ops_mutex_lock);		\
+} while (0)
+
+#define NBL_OPS_CALL_LOCK_RET(disp_mgt, func, ...)			\
+({									\
+	typeof(disp_mgt) _disp_mgt = (disp_mgt);	\
+	typeof(func) _func = (func);	\
+	typeof(_func(__VA_ARGS__)) _ret = 0;	\
+	\
+	if (_disp_mgt->ops_lock_required)	\
+		mutex_lock(&_disp_mgt->ops_mutex_lock);	\
+	\
+	if (_func)	\
+		_ret = _func(__VA_ARGS__);	\
+	\
+	if (_disp_mgt->ops_lock_required)	\
+		mutex_unlock(&_disp_mgt->ops_mutex_lock);	\
+	\
+	_ret;	\
+})
+
+struct nbl_dispatch_mgt {
+	struct nbl_common_info *common;
+	struct nbl_resource_ops_tbl *res_ops_tbl;
+	struct nbl_channel_ops_tbl *chan_ops_tbl;
+	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
+	DECLARE_BITMAP(ctrl_lvl, NBL_DISP_CTRL_LVL_MAX);
+	/* use for the caller not in interrupt */
+	struct mutex ops_mutex_lock;
+	/* use for the caller is in interrupt or other can't sleep thread */
+	spinlock_t ops_spin_lock;
+	bool ops_lock_required;
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
new file mode 100644
index 000000000000..852cfea3c9c3
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
@@ -0,0 +1,190 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_DEF_DISPATCH_H_
+#define _NBL_DEF_DISPATCH_H_
+
+#include "nbl_include.h"
+
+#define NBL_DISP_OPS_TBL_TO_OPS(disp_ops_tbl)	((disp_ops_tbl)->ops)
+#define NBL_DISP_OPS_TBL_TO_PRIV(disp_ops_tbl)	((disp_ops_tbl)->priv)
+
+enum {
+	NBL_DISP_CTRL_LVL_NEVER = 0,
+	NBL_DISP_CTRL_LVL_MGT,
+	NBL_DISP_CTRL_LVL_NET,
+	NBL_DISP_CTRL_LVL_ALWAYS,
+	NBL_DISP_CTRL_LVL_MAX,
+};
+
+struct nbl_dispatch_ops {
+	int (*init_chip_module)(void *priv);
+	void (*deinit_chip_module)(void *priv);
+	void (*get_resource_pt_ops)(void *priv,
+				    struct nbl_resource_pt_ops *pt_ops);
+	int (*queue_init)(void *priv);
+	int (*vsi_init)(void *priv);
+	int (*init_vf_msix_map)(void *priv, u16 func_id, bool enable);
+	int (*configure_msix_map)(void *priv, u16 num_net_msix,
+				  u16 num_others_msix, bool net_msix_mask_en);
+	int (*destroy_msix_map)(void *priv);
+	int (*enable_mailbox_irq)(void *p, u16 vector_id, bool enable_msix);
+	int (*enable_abnormal_irq)(void *p, u16 vector_id, bool enable_msix);
+	int (*enable_adminq_irq)(void *p, u16 vector_id, bool enable_msix);
+	u16 (*get_global_vector)(void *priv, u16 vsi_id, u16 local_vec_id);
+	u16 (*get_msix_entry_id)(void *priv, u16 vsi_id, u16 local_vec_id);
+
+	int (*get_mbx_irq_num)(void *priv);
+	int (*get_adminq_irq_num)(void *priv);
+	int (*get_abnormal_irq_num)(void *priv);
+	int (*alloc_rings)(void *priv, struct net_device *netdev,
+			   struct nbl_ring_param *param);
+	void (*remove_rings)(void *priv);
+	dma_addr_t (*start_tx_ring)(void *priv, u8 ring_index);
+	void (*stop_tx_ring)(void *priv, u8 ring_index);
+	dma_addr_t (*start_rx_ring)(void *priv, u8 ring_index, bool use_napi);
+	void (*stop_rx_ring)(void *priv, u8 ring_index);
+	void (*kick_rx_ring)(void *priv, u16 index);
+	struct nbl_napi_struct *(*get_vector_napi)(void *priv, u16 index);
+	void (*set_vector_info)(void *priv, u8 __iomem *irq_enable_base,
+				u32 irq_data, u16 index, bool mask_en);
+	int (*register_net)(void *priv,
+			    struct nbl_register_net_param *register_param,
+			    struct nbl_register_net_result *register_result);
+	void (*register_vsi_ring)(void *priv, u16 vsi_index, u16 ring_offset,
+				  u16 ring_num);
+	int (*unregister_net)(void *priv);
+	int (*alloc_txrx_queues)(void *priv, u16 vsi_id, u16 queue_num);
+	void (*free_txrx_queues)(void *priv, u16 vsi_id);
+	int (*setup_queue)(void *priv, struct nbl_txrx_queue_param *param,
+			   bool is_tx);
+	void (*remove_all_queues)(void *priv, u16 vsi_id);
+	int (*register_vsi2q)(void *priv, u16 vsi_index, u16 vsi_id,
+			      u16 queue_offset, u16 queue_num);
+	int (*setup_q2vsi)(void *priv, u16 vsi_id);
+	void (*remove_q2vsi)(void *priv, u16 vsi_id);
+	int (*setup_rss)(void *priv, u16 vsi_id);
+	void (*remove_rss)(void *priv, u16 vsi_id);
+	int (*cfg_dsch)(void *priv, u16 vsi_id, bool vld);
+	int (*setup_cqs)(void *priv, u16 vsi_id, u16 real_qps,
+			 bool rss_indir_set);
+	void (*remove_cqs)(void *priv, u16 vsi_id);
+
+	void (*clear_queues)(void *priv, u16 vsi_id);
+
+	u16 (*get_vsi_global_qid)(void *priv, u16 vsi_id, u16 local_qid);
+	u16 (*get_local_queue_id)(void *priv, u16 vsi_id, u16 global_queue_id);
+	u16 (*get_vsi_global_queue_id)(void *priv, u16 vsi_id, u16 local_qid);
+
+	u8 __iomem *(*get_msix_irq_enable_info)(void *priv, u16 global_vec_id,
+						u32 *irq_data);
+
+	int (*add_macvlan)(void *priv, u8 *mac, u16 vlan, u16 vsi);
+	void (*del_macvlan)(void *priv, u8 *mac, u16 vlan, u16 vsi);
+	int (*add_lldp_flow)(void *priv, u16 vsi);
+	void (*del_lldp_flow)(void *priv, u16 vsi);
+	int (*add_multi_rule)(void *priv, u16 vsi);
+	void (*del_multi_rule)(void *priv, u16 vsi);
+	int (*cfg_multi_mcast)(void *priv, u16 vsi, u16 enable);
+	int (*setup_multi_group)(void *priv);
+	void (*remove_multi_group)(void *priv);
+	void (*clear_flow)(void *priv, u16 vsi_id);
+
+	u16 (*get_vsi_id)(void *priv, u16 func_id, u16 type);
+	void (*get_eth_id)(void *priv, u16 vsi_id, u8 *eth_mode, u8 *eth_id,
+			   u8 *logic_eth_id);
+	int (*set_promisc_mode)(void *priv, u16 vsi_id, u16 mode);
+	int (*set_mtu)(void *priv, u16 vsi_id, u16 mtu);
+	int (*get_max_mtu)(void *priv);
+	u32 (*get_tx_headroom)(void *priv);
+	void (*get_rep_queue_info)(void *priv, u16 *queue_num, u16 *queue_size);
+	void (*get_net_stats)(void *priv, struct nbl_stats *queue_stats);
+	void (*get_rxfh_indir_size)(void *priv, u16 vsi_id,
+				    u32 *rxfh_indir_size);
+	int (*set_rxfh_indir)(void *priv, u16 vsi_id, const u32 *indir,
+			      u32 indir_size);
+	int (*get_port_attributes)(void *priv);
+	int (*enable_port)(void *priv, bool enable);
+	void (*recv_port_notify)(void *priv);
+	int (*get_link_state)(void *priv, u8 eth_id,
+			      struct nbl_eth_link_info *eth_link_info);
+	int (*set_eth_mac_addr)(void *priv, u8 *mac, u8 eth_id);
+	int (*process_abnormal_event)(void *priv,
+				      struct nbl_abnormal_event_info *info);
+	int (*set_wol)(void *priv, u8 eth_id, bool enable);
+	void (*adapt_desc_gother)(void *priv);
+	void (*flr_clear_net)(void *priv, u16 vfid);
+	void (*flr_clear_queues)(void *priv, u16 vfid);
+
+	void (*flr_clear_flows)(void *priv, u16 vfid);
+	void (*flr_clear_interrupt)(void *priv, u16 vfid);
+
+	u16 (*covert_vfid_to_vsi_id)(void *priv, u16 vfid);
+	void (*unmask_all_interrupts)(void *priv);
+	void (*keep_alive)(void *priv);
+	void (*cfg_txrx_vlan)(void *priv, u16 vlan_tci, u16 vlan_proto,
+			      u8 vsi_index);
+
+	u8 __iomem *(*get_hw_addr)(void *priv, size_t *size);
+	u16 (*get_function_id)(void *priv, u16 vsi_id);
+	void (*get_real_bdf)(void *priv, u16 vsi_id, u8 *bus, u8 *dev,
+			     u8 *function);
+
+	bool (*check_fw_heartbeat)(void *priv);
+	bool (*check_fw_reset)(void *priv);
+
+	int (*set_sfp_state)(void *priv, u8 eth_id, u8 state);
+	int (*passthrough_fw_cmd)(void *priv,
+				  struct nbl_passthrough_fw_cmd *param,
+				  struct nbl_passthrough_fw_cmd *result);
+	int (*update_ring_num)(void *priv);
+	int (*set_ring_num)(void *priv,
+			    struct nbl_cmd_net_ring_num *param);
+	int (*get_part_number)(void *priv, char *part_number);
+	int (*get_serial_number)(void *priv, char *serial_number);
+
+	int (*get_board_id)(void *priv);
+
+	bool (*get_product_fix_cap)(void *priv, enum nbl_fix_cap_type cap_type);
+
+	void (*dummy_func)(void *priv);
+
+	dma_addr_t (*restore_abnormal_ring)(void *priv, int ring_index,
+					    int type);
+	int (*restart_abnormal_ring)(void *priv, int ring_index, int type);
+	int (*stop_abnormal_sw_queue)(void *priv, u16 local_queue_id, int type);
+	int (*stop_abnormal_hw_queue)(void *priv, u16 vsi_id,
+				      u16 local_queue_id, int type);
+	u16 (*get_vf_function_id)(void *priv, u16 vsi_id, int vf_id);
+	u16 (*get_vf_vsi_id)(void *priv, u16 vsi_id, int vf_id);
+	bool (*check_vf_is_active)(void *priv, u16 func_id);
+	int (*get_ustore_total_pkt_drop_stats)(void *priv, u8 eth_id,
+					       struct nbl_ustore_stats *stat);
+
+	int (*get_link_forced)(void *priv, u16 vsi_id);
+	int (*set_tx_rate)(void *priv, u16 func_id, int tx_rate, int burst);
+	int (*set_rx_rate)(void *priv, u16 func_id, int rx_rate, int burst);
+
+	void (*register_dev_name)(void *priv, u16 vsi_id, char *name);
+	void (*get_dev_name)(void *priv, u16 vsi_id, char *name);
+
+	void (*set_hw_status)(void *priv, enum nbl_hw_status hw_status);
+	void (*get_active_func_bitmaps)(void *priv, unsigned long *bitmap,
+					int max_func);
+
+	int (*check_flow_table_spec)(void *priv, u16 vlan_cnt, u16 unicast_cnt,
+				     u16 multicast_cnt);
+};
+
+struct nbl_dispatch_ops_tbl {
+	struct nbl_dispatch_ops *ops;
+	void *priv;
+};
+
+int nbl_disp_init(void *p, struct nbl_init_param *param);
+void nbl_disp_remove(void *p);
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
index 9cee11498e9f..fda55e97d743 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -76,7 +76,13 @@ struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
 	ret = product_base_ops->res_init(adapter, param);
 	if (ret)
 		goto res_init_fail;
+
+	ret = nbl_disp_init(adapter, param);
+	if (ret)
+		goto disp_init_fail;
 	return adapter;
+disp_init_fail:
+	product_base_ops->res_remove(adapter);
 res_init_fail:
 	product_base_ops->chan_remove(adapter);
 chan_init_fail:
@@ -93,6 +99,7 @@ void nbl_core_remove(struct nbl_adapter *adapter)
 
 	dev = NBL_ADAP_TO_DEV(adapter);
 	product_base_ops = NBL_ADAP_TO_RPDUCT_BASE_OPS(adapter);
+	nbl_disp_remove(adapter);
 	product_base_ops->res_remove(adapter);
 	product_base_ops->chan_remove(adapter);
 	product_base_ops->hw_remove(adapter);
-- 
2.47.3


