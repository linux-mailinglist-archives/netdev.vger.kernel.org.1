Return-Path: <netdev+bounces-252577-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DiUIWzNcmlgpgAAu9opvQ
	(envelope-from <netdev+bounces-252577-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:22:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A37DA6F036
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83041301D6AE
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 01:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416C837105C;
	Fri, 23 Jan 2026 01:19:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-121.mail.aliyun.com (out28-121.mail.aliyun.com [115.124.28.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574E52DF6F4;
	Fri, 23 Jan 2026 01:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769131154; cv=none; b=atJ9A901iI2fXG7j9REdrcNIYw5Tld7AdLec6EP+LLHWnvJ8IayBKAJpoMTnhjloPVsL7cZcSQgP0m7KVgA8XTCP53L9HGFUq+p5YqGGXG1ZVYlxg8oGoOyv9qPy1rR6COa1eUzUHaZHy9r0ssvI9RAkDX8jKO1oSK+eYcAciwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769131154; c=relaxed/simple;
	bh=Wo4DeiGPBuMxGhD8MZ8KjpSWGxbgTuc8me+Q2LnTTuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfgOQBEsjk/zipXkKsR7qwszLHPWloy5LzdWIgl226fbhmmnZ32l+f5qcRmTDOlrLbRZOPaHGYsxNrs5/5mGKJYT8El4TAQa+NKpEP2CfPwwqoyqyC6i7nbUK6v2f3pjHoxBt4I6TVwHNbxb53oKVXUVmNKuXsSnDcKAOn5Iet8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.gDSYWCu_1769131131 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 23 Jan 2026 09:18:52 +0800
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
Subject: [PATCH v3 net-next 11/15] net/nebula-matrix: add Dispatch layer implementation
Date: Fri, 23 Jan 2026 09:17:48 +0800
Message-ID: <20260123011804.31263-12-illusion.wang@nebula-matrix.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252577-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nebula-matrix.com:mid,nebula-matrix.com:email,illusion.wang:url]
X-Rspamd-Queue-Id: A37DA6F036
X-Rspamd-Action: no action

This patch can have a quick review, function is similar

The primary issue in the Dispatch layer is how to determine
the routing approach
Two routing ways:
Dispatch Layer-> Resource Layer -> HW layer
The Dispatch Layer routes tasks to Resource Layer, which may interact
with the HW Layer for hardware writes.

Dispatch Layer->Channel Layer
The Dispatch Layers redirects hooks to the Channel Layer.

The primary challenge at the Dispatch layer lies in determining the
routing approach, namely, how to decide which interfaces should directly
invoke the Resource layer's interfaces and which should transmit
requests via channels to the management PF for processing.

To address this, a ctrl_lvl (control level) mechanism is established,
which comprises two parts: the control level declared by each interface
and the control level configured by the upper layer. The effect is that
when the upper layer configures a specific control level, all interfaces
declaring this level will directly call the Resource layer's interfaces;
otherwise, they will send requests via channels.

For instance, consider a regular PF that possesses network (net)
capabilities but lacks control (ctrl) capabilities. It will only
configure NET_LVL at the Dispatch layer. In this scenario, all
interfaces declaring NET_LVL will directly invoke the Resource layer's
interfaces, while those declaring CTRL_LVL will send requests via
channels to the management PF. Conversely, if it is the management PF,
it will configure both NET_LVL and CTRL_LVL at the Dispatch layer.
Consequently, interfaces declaring CTRL_LVL will also directly call the
Resource layer's interfaces without sending requests via channels. This
configuration logic can be dynamic.(nbl_disp_setup_ctrl_lvl)

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c | 1863 +++++++++++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.h |   33 +
 .../nbl/nbl_include/nbl_def_dispatch.h        |   58 +
 3 files changed, 1954 insertions(+)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
index 51cb298ffb1a..181ec3796819 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
@@ -6,6 +6,1846 @@
 #include <linux/etherdevice.h>
 #include "nbl_dispatch.h"
 
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
+static void nbl_disp_clear_queues(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	void *p = NBL_DISP_MGT_TO_RES_PRIV(disp_mgt);
+
+	NBL_OPS_CALL_LOCK(disp_mgt, res_ops->clear_queues, p, vsi_id);
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
+	NBL_DISP_SET_OPS(get_vsi_id, nbl_disp_get_vsi_id,		\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_GET_VSI_ID,\
+			 nbl_disp_chan_get_vsi_id_req,			\
+			 nbl_disp_chan_get_vsi_id_resp);		\
+	NBL_DISP_SET_OPS(get_eth_id, nbl_disp_get_eth_id,		\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_GET_ETH_ID,\
+			 nbl_disp_chan_get_eth_id_req,			\
+			 nbl_disp_chan_get_eth_id_resp);		\
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
+	NBL_DISP_SET_OPS(clear_queues, nbl_disp_clear_queues,		\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_CLEAR_QUEUE,\
+			 nbl_disp_chan_clear_queues_req,		\
+			 nbl_disp_chan_clear_queues_resp);		\
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
 static int nbl_disp_setup_disp_mgt(struct nbl_common_info *common,
 				   struct nbl_dispatch_mgt **disp_mgt)
 {
@@ -88,7 +1928,30 @@ int nbl_disp_init(void *p, struct nbl_init_param *param)
 	NBL_DISP_MGT_TO_CHAN_OPS_TBL(*disp_mgt) = chan_ops_tbl;
 	NBL_DISP_MGT_TO_DISP_OPS_TBL(*disp_mgt) = *disp_ops_tbl;
 
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
 	return 0;
+
+setup_msg_fail:
+	nbl_disp_remove_ops(dev, disp_ops_tbl);
 setup_ops_fail:
 	nbl_disp_remove_disp_mgt(common, disp_mgt);
 setup_mgt_fail:
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
index 21cfb5a1000e..4670f22c44e2 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
@@ -29,6 +29,39 @@
 #define NBL_DISP_MGT_TO_DISP_PRIV(disp_mgt) \
 	(NBL_DISP_MGT_TO_DISP_OPS_TBL(disp_mgt)->priv)
 
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
 struct nbl_dispatch_mgt {
 	struct nbl_common_info *common;
 	struct nbl_resource_ops_tbl *res_ops_tbl;
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
index 2f6f1ffedafc..9985b0330020 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
@@ -21,6 +21,64 @@ enum {
 };
 
 struct nbl_dispatch_ops {
+	int (*init_chip_module)(void *priv);
+	void (*deinit_chip_module)(void *priv);
+	void (*get_resource_pt_ops)(void *priv,
+				    struct nbl_resource_pt_ops *pt_ops);
+	int (*queue_init)(void *priv);
+	int (*configure_msix_map)(void *priv, u16 num_net_msix,
+				  u16 num_others_msix, bool net_msix_mask_en);
+	int (*destroy_msix_map)(void *priv);
+	int (*enable_mailbox_irq)(void *p, u16 vector_id, bool enable_msix);
+	u16 (*get_global_vector)(void *priv, u16 vsi_id, u16 local_vec_id);
+	u16 (*get_msix_entry_id)(void *priv, u16 vsi_id, u16 local_vec_id);
+
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
+	u8 __iomem *(*get_msix_irq_enable_info)(void *priv, u16 global_vec_id,
+						u32 *irq_data);
+	u16 (*get_vsi_id)(void *priv, u16 func_id, u16 type);
+	void (*get_eth_id)(void *priv, u16 vsi_id, u8 *eth_mode, u8 *eth_id,
+			   u8 *logic_eth_id);
+	int (*set_promisc_mode)(void *priv, u16 vsi_id, u16 mode);
+	u32 (*get_tx_headroom)(void *priv);
+	void (*get_net_stats)(void *priv, struct nbl_stats *queue_stats);
+	void (*get_rxfh_indir_size)(void *priv, u16 vsi_id,
+				    u32 *rxfh_indir_size);
+	int (*set_rxfh_indir)(void *priv, u16 vsi_id, const u32 *indir,
+			      u32 indir_size);
 };
 
 struct nbl_dispatch_ops_tbl {
-- 
2.47.3


