Return-Path: <netdev+bounces-271382-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gH3xH2Vew2m1qQQAu9opvQ
	(envelope-from <netdev+bounces-271382-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 05:02:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A3731F61F
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 05:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C44C306519A
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 04:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E722F547F;
	Wed, 25 Mar 2026 04:01:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com [115.124.28.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C0A2DC76F;
	Wed, 25 Mar 2026 04:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774411274; cv=none; b=kHQXxbwNmQnZ9Z4eXAlAsBGNir0O09W3tOHGzyOicAeQ5enhgcl7GQiEMpF7PheN0/Y/JKSLnnAwaKDCN39vvFT/vnFuhqBSuvkjRQ23Ly1FMcsX+SwTJwkCxFtB5uaevL644ESop0fIEEeLUPt7MYtF2NCcnVKqUGUmj79fH18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774411274; c=relaxed/simple;
	bh=goB6qeiLHuTNYK3+cs+HrnbUDfzcOYcsJuIslaRAaUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6iNJ3u+rbtK8yzrgccuylXHUIQREv8VCRqlI0/JYmNs7TtoslhONtTHmqpdwTzEOjpxoeT7VJlSsDqmDTu0FsSQF6JzXzbNq70Scwb120weJKUfiB1zW+4Aco2QhfgcoBXBiXOS7wh6rzO7S9oe3cpcgZc9Zi2NQYzs8mKh3KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0166233-0.00079866-0.982578;FP=18336084077175244310|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032027189;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.gzTMEgn_1774411262;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.gzTMEgn_1774411262 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 25 Mar 2026 12:01:03 +0800
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
Subject: [PATCH v9 net-next 09/11] net/nebula-matrix: add Dispatch layer implementation
Date: Wed, 25 Mar 2026 12:00:41 +0800
Message-ID: <20260325040048.2313-10-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325040048.2313-1-illusion.wang@nebula-matrix.com>
References: <20260325040048.2313-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[nebula-matrix.com];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271382-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nebula-matrix.com:email,nebula-matrix.com:mid,illusion.wang:url]
X-Rspamd-Queue-Id: 40A3731F61F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch introduces a control-level routing mechanism for the Dispatch layer.
Two routing ways:
(Direct path):Dispatch Layer-> Resource Layer -> HW layer
The Dispatch Layer routes tasks to Resource Layer, which may interact
with the HW Layer for hardware writes.

(Channel path):Dispatch Layer->Channel Layer
The Dispatch Layers redirects hooks to the Channel Layer.

Proposed Solution:
Introduce a control level mechanism with two components:
1. Interface-declared control levels
   Each operation interface declares its required control level
(e.g., 'NET_LVL' for networking, 'CTRL_LVL' for management).

2. Upper-layer configured control levels
   The upper layer (e.g., PF driver) dynamically configures which control
levels should use the direct path.

Example:
Regular PF
Configures 'NET_LVL' at Dispatch layer
  All 'NET_LVL' operations use direct path; 'CTRL_LVL' operations go via channel.
Management PF
  Configures both 'NET_LVL' and 'CTRL_LVL'
  All operations use direct path.

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c | 410 ++++++++++++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.h |  31 ++
 .../nbl/nbl_include/nbl_def_dispatch.h        |  14 +
 3 files changed, 455 insertions(+)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
index 347649e74a73..0e0fe8819b57 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
@@ -6,6 +6,396 @@
 #include <linux/pci.h>
 #include "nbl_dispatch.h"
 
+static u16 nbl_disp_chan_get_vsi_id_req(struct nbl_dispatch_mgt *disp_mgt,
+					u16 func_id, u16 type)
+{
+	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
+	struct nbl_common_info *common = disp_mgt->common;
+	struct nbl_chan_param_get_vsi_id result = { 0 };
+	struct nbl_chan_param_get_vsi_id param = { 0 };
+	struct nbl_chan_send_info chan_send;
+
+	param.type = type;
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_GET_VSI_ID,
+		      &param, sizeof(param), &result, sizeof(result), 1);
+	chan_ops->send_msg(disp_mgt->chan_ops_tbl->priv, &chan_send);
+
+	return result.vsi_id;
+}
+
+static void nbl_disp_chan_get_vsi_id_resp(void *priv, u16 src_id, u16 msg_id,
+					  void *data, u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+	struct device *dev = disp_mgt->common->dev;
+	struct nbl_chan_param_get_vsi_id *param;
+	struct nbl_chan_param_get_vsi_id result = { 0 };
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	int ret;
+
+	param = (struct nbl_chan_param_get_vsi_id *)data;
+
+	result.vsi_id =
+		NBL_OPS_CALL_RET(res_ops->get_vsi_id, (p, src_id, param->type));
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_GET_VSI_ID, msg_id, err,
+		     &result, sizeof(result));
+	ret = chan_ops->send_ack(disp_mgt->chan_ops_tbl->priv, &chan_ack);
+	if (ret)
+		dev_err(dev,
+			"channel send ack failed with ret: %d, msg_type: %d\n",
+			ret, NBL_CHAN_MSG_GET_VSI_ID);
+}
+
+static void nbl_disp_chan_get_eth_id_req(struct nbl_dispatch_mgt *disp_mgt,
+					 u16 vsi_id, u8 *eth_mode, u8 *eth_id,
+					 u8 *logic_eth_id)
+{
+	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
+	struct nbl_common_info *common = disp_mgt->common;
+	struct nbl_chan_param_get_eth_id result = { 0 };
+	struct nbl_chan_param_get_eth_id param = { 0 };
+	struct nbl_chan_send_info chan_send;
+
+	param.vsi_id = vsi_id;
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_GET_ETH_ID,
+		      &param, sizeof(param), &result, sizeof(result), 1);
+	chan_ops->send_msg(disp_mgt->chan_ops_tbl->priv, &chan_send);
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
+	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+	struct nbl_chan_param_get_eth_id result = { 0 };
+	struct device *dev = disp_mgt->common->dev;
+	struct nbl_chan_param_get_eth_id *param;
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	int ret;
+
+	param = (struct nbl_chan_param_get_eth_id *)data;
+
+	NBL_OPS_CALL(res_ops->get_eth_id,
+		     (p, param->vsi_id, &result.eth_mode, &result.eth_id,
+		      &result.logic_eth_id));
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_GET_ETH_ID, msg_id, err,
+		     &result, sizeof(result));
+	ret = chan_ops->send_ack(disp_mgt->chan_ops_tbl->priv, &chan_ack);
+	if (ret)
+		dev_err(dev,
+			"channel send ack failed with ret: %d, msg_type: %d\n",
+			ret, NBL_CHAN_MSG_GET_ETH_ID);
+}
+
+static void nbl_disp_deinit_chip_module(struct nbl_dispatch_mgt *disp_mgt)
+{
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+
+	NBL_OPS_CALL(res_ops->deinit_chip_module, (p));
+}
+
+static int nbl_disp_init_chip_module(struct nbl_dispatch_mgt *disp_mgt)
+{
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+
+	return NBL_OPS_CALL_RET(res_ops->init_chip_module, (p));
+}
+
+static int nbl_disp_configure_msix_map(struct nbl_dispatch_mgt *disp_mgt,
+				       u16 num_net_msix, u16 num_others_msix,
+				       bool net_msix_mask_en)
+{
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+
+	return NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->configure_msix_map, p,
+				     0, num_net_msix, num_others_msix,
+				     net_msix_mask_en);
+}
+
+static int
+nbl_disp_chan_configure_msix_map_req(struct nbl_dispatch_mgt *disp_mgt,
+				     u16 num_net_msix, u16 num_others_msix,
+				     bool net_msix_mask_en)
+{
+	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
+	struct nbl_common_info *common = disp_mgt->common;
+	struct nbl_chan_param_cfg_msix_map param = { 0 };
+	struct nbl_chan_send_info chan_send;
+
+	param.num_net_msix = num_net_msix;
+	param.num_others_msix = num_others_msix;
+	param.msix_mask_en = net_msix_mask_en;
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf,
+		      NBL_CHAN_MSG_CONFIGURE_MSIX_MAP, &param, sizeof(param),
+		      NULL, 0, 1);
+	return chan_ops->send_msg(disp_mgt->chan_ops_tbl->priv, &chan_send);
+}
+
+static void nbl_disp_chan_configure_msix_map_resp(void *priv, u16 src_id,
+						  u16 msg_id, void *data,
+						  u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+	struct device *dev = disp_mgt->common->dev;
+	struct nbl_chan_param_cfg_msix_map *param;
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	int ret;
+
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
+	ret = chan_ops->send_ack(disp_mgt->chan_ops_tbl->priv, &chan_ack);
+	if (ret)
+		dev_err(dev,
+			"channel send ack failed with ret: %d, msg_type: %d\n",
+			ret, NBL_CHAN_MSG_CONFIGURE_MSIX_MAP);
+}
+
+static int nbl_disp_chan_destroy_msix_map_req(struct nbl_dispatch_mgt *disp_mgt)
+{
+	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
+	struct nbl_common_info *common = disp_mgt->common;
+	struct nbl_chan_send_info chan_send;
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_DESTROY_MSIX_MAP,
+		      NULL, 0, NULL, 0, 1);
+	return chan_ops->send_msg(disp_mgt->chan_ops_tbl->priv, &chan_send);
+}
+
+static void nbl_disp_chan_destroy_msix_map_resp(void *priv, u16 src_id,
+						u16 msg_id, void *data,
+						u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+	struct device *dev = disp_mgt->common->dev;
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	int ret;
+
+	ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->destroy_msix_map, p,
+				    src_id);
+	if (ret)
+		err = NBL_CHAN_RESP_ERR;
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_DESTROY_MSIX_MAP, msg_id,
+		     err, NULL, 0);
+	ret = chan_ops->send_ack(disp_mgt->chan_ops_tbl->priv, &chan_ack);
+	if (ret)
+		dev_err(dev,
+			"channel send ack failed with ret: %d, msg_type: %d\n",
+			ret, NBL_CHAN_MSG_DESTROY_MSIX_MAP);
+}
+
+static int
+nbl_disp_chan_enable_mailbox_irq_req(struct nbl_dispatch_mgt *disp_mgt,
+				     u16 vector_id, bool enable_msix)
+{
+	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
+	struct nbl_chan_param_enable_mailbox_irq param = { 0 };
+	struct nbl_common_info *common = disp_mgt->common;
+	struct nbl_chan_send_info chan_send;
+
+	param.vector_id = vector_id;
+	param.enable_msix = enable_msix;
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf,
+		      NBL_CHAN_MSG_MAILBOX_ENABLE_IRQ, &param, sizeof(param),
+		      NULL, 0, 1);
+	return chan_ops->send_msg(disp_mgt->chan_ops_tbl->priv, &chan_send);
+}
+
+static void nbl_disp_chan_enable_mailbox_irq_resp(void *priv, u16 src_id,
+						  u16 msg_id, void *data,
+						  u32 data_len)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+	struct nbl_chan_param_enable_mailbox_irq *param;
+	struct device *dev = disp_mgt->common->dev;
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	int ret;
+
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
+	ret = chan_ops->send_ack(disp_mgt->chan_ops_tbl->priv, &chan_ack);
+	if (ret)
+		dev_err(dev,
+			"channel send ack failed with ret: %d, msg_type: %d\n",
+			ret, NBL_CHAN_MSG_MAILBOX_ENABLE_IRQ);
+}
+
+static int nbl_disp_destroy_msix_map(struct nbl_dispatch_mgt *disp_mgt)
+{
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+
+	return NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->destroy_msix_map, p, 0);
+}
+
+static int nbl_disp_enable_mailbox_irq(struct nbl_dispatch_mgt *disp_mgt,
+				       u16 vector_id, bool enable_msix)
+{
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+
+	return NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->enable_mailbox_irq, p,
+				     0, vector_id, enable_msix);
+}
+
+static u16 nbl_disp_get_vsi_id(struct nbl_dispatch_mgt *disp_mgt, u16 func_id,
+			       u16 type)
+{
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+
+	return NBL_OPS_CALL_RET(res_ops->get_vsi_id, (p, func_id, type));
+}
+
+static void nbl_disp_get_eth_id(struct nbl_dispatch_mgt *disp_mgt, u16 vsi_id,
+				u8 *eth_mode, u8 *eth_id, u8 *logic_eth_id)
+{
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+
+	NBL_OPS_CALL(res_ops->get_eth_id,
+		     (p, vsi_id, eth_mode, eth_id, logic_eth_id));
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
+			 NBL_DISP_CTRL_LVL_MGT, -1, NULL, NULL);	\
+	NBL_DISP_SET_OPS(deinit_chip_module,				\
+			 nbl_disp_deinit_chip_module,			\
+			 NBL_DISP_CTRL_LVL_MGT, -1, NULL, NULL);	\
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
+	NBL_DISP_SET_OPS(get_vsi_id, nbl_disp_get_vsi_id,		\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_GET_VSI_ID,\
+			 nbl_disp_chan_get_vsi_id_req,			\
+			 nbl_disp_chan_get_vsi_id_resp);		\
+	NBL_DISP_SET_OPS(get_eth_id, nbl_disp_get_eth_id,		\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_GET_ETH_ID,\
+			 nbl_disp_chan_get_eth_id_req,			\
+			 nbl_disp_chan_get_eth_id_resp);		\
+} while (0)
+
+/* Structure starts here, adding an op should not modify anything below */
+static int nbl_disp_setup_msg(struct nbl_dispatch_mgt *disp_mgt)
+{
+	struct nbl_dispatch_ops *disp_ops = disp_mgt->disp_ops_tbl->ops;
+	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
+	struct nbl_channel_mgt *p = disp_mgt->chan_ops_tbl->priv;
+	int ret = 0;
+
+	mutex_init(&disp_mgt->ops_mutex_lock);
+
+#define NBL_DISP_SET_OPS(disp_op, func, ctrl, msg_type, msg_req, resp) \
+do {									\
+	typeof(msg_type) _msg_type = (msg_type);			\
+	typeof(ctrl) _ctrl_lvl = (ctrl);				\
+	(void)(disp_ops->NBL_NAME(disp_op));				\
+	(void)(func);							\
+	(void)(msg_req);						\
+	(void)_ctrl_lvl;						\
+	if (_msg_type >= 0)						\
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
+	struct nbl_dispatch_ops *disp_ops = disp_mgt->disp_ops_tbl->ops;
+
+	set_bit(lvl, disp_mgt->ctrl_lvl);
+
+#define NBL_DISP_SET_OPS(disp_op, func, ctrl, msg_type, msg_req, msg_resp) \
+do {									\
+	typeof(msg_type) _msg_type = (msg_type);			\
+	(void)(_msg_type);						\
+	(void)(msg_resp);						\
+	disp_ops->NBL_NAME(disp_op) =					\
+		test_bit(ctrl, disp_mgt->ctrl_lvl) ? func : msg_req;	\
+} while (0)
+	NBL_DISP_OPS_TBL;
+#undef  NBL_DISP_SET_OPS
+
+	return 0;
+}
+
 static struct nbl_dispatch_mgt *
 nbl_disp_setup_disp_mgt(struct nbl_common_info *common)
 {
@@ -72,5 +462,25 @@ int nbl_disp_init(struct nbl_adapter *adapter, struct nbl_init_param *param)
 	adapter->core.disp_mgt = disp_mgt;
 	adapter->intf.dispatch_ops_tbl = disp_ops_tbl;
 
+	ret = nbl_disp_setup_msg(disp_mgt);
+	if (ret)
+		return ret;
+
+	if (param->caps.has_ctrl) {
+		ret = nbl_disp_setup_ctrl_lvl(disp_mgt, NBL_DISP_CTRL_LVL_MGT);
+		if (ret)
+			return ret;
+	}
+
+	if (param->caps.has_net) {
+		ret = nbl_disp_setup_ctrl_lvl(disp_mgt, NBL_DISP_CTRL_LVL_NET);
+		if (ret)
+			return ret;
+	}
+
+	ret = nbl_disp_setup_ctrl_lvl(disp_mgt, NBL_DISP_CTRL_LVL_ALWAYS);
+	if (ret)
+		return ret;
+
 	return 0;
 }
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
index fa7f4597febe..3ef5fff59f14 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
@@ -14,12 +14,43 @@
 #include "../nbl_include/nbl_def_common.h"
 #include "../nbl_core.h"
 
+#define NBL_OPS_CALL_LOCK(disp_mgt, func, ...)				\
+do {									\
+	typeof(disp_mgt) _disp_mgt = (disp_mgt);			\
+	typeof(func) _func = (func);					\
+									\
+	mutex_lock(&_disp_mgt->ops_mutex_lock);				\
+									\
+	if (_func)							\
+		_func(__VA_ARGS__);					\
+									\
+	mutex_unlock(&_disp_mgt->ops_mutex_lock);			\
+} while (0)
+
+#define NBL_OPS_CALL_LOCK_RET(disp_mgt, func, ...)			\
+({									\
+	typeof(disp_mgt) _disp_mgt = (disp_mgt);			\
+	typeof(func) _func = (func);					\
+	typeof(_func(__VA_ARGS__)) _ret = 0;				\
+									\
+	mutex_lock(&_disp_mgt->ops_mutex_lock);				\
+									\
+	if (_func)							\
+		_ret = _func(__VA_ARGS__);				\
+									\
+	mutex_unlock(&_disp_mgt->ops_mutex_lock);			\
+									\
+	_ret;								\
+})
+
 struct nbl_dispatch_mgt {
 	struct nbl_common_info *common;
 	struct nbl_resource_ops_tbl *res_ops_tbl;
 	struct nbl_channel_ops_tbl *chan_ops_tbl;
 	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
 	DECLARE_BITMAP(ctrl_lvl, NBL_DISP_CTRL_LVL_MAX);
+	/* use for the caller not in interrupt */
+	struct mutex ops_mutex_lock;
 };
 
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
index 09e408a93a3a..c19760ddff5c 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
@@ -6,6 +6,8 @@
 #ifndef _NBL_DEF_DISPATCH_H_
 #define _NBL_DEF_DISPATCH_H_
 
+#include <linux/types.h>
+
 struct nbl_dispatch_mgt;
 enum {
 	NBL_DISP_CTRL_LVL_NEVER = 0,
@@ -16,6 +18,18 @@ enum {
 };
 
 struct nbl_dispatch_ops {
+	int (*init_chip_module)(struct nbl_dispatch_mgt *disp_mgt);
+	void (*deinit_chip_module)(struct nbl_dispatch_mgt *disp_mgt);
+	int (*configure_msix_map)(struct nbl_dispatch_mgt *disp_mgt,
+				  u16 num_net_msix, u16 num_others_msix,
+				  bool net_msix_mask_en);
+	int (*destroy_msix_map)(struct nbl_dispatch_mgt *disp_mgt);
+	int (*enable_mailbox_irq)(struct nbl_dispatch_mgt *disp_mgt,
+				  u16 vector_id, bool enable_msix);
+	u16 (*get_vsi_id)(struct nbl_dispatch_mgt *disp_mgt, u16 func_id,
+			  u16 type);
+	void (*get_eth_id)(struct nbl_dispatch_mgt *disp_mgt, u16 vsi_id,
+			   u8 *eth_mode, u8 *eth_id, u8 *logic_eth_id);
 };
 
 struct nbl_dispatch_ops_tbl {
-- 
2.47.3


