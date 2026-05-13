Return-Path: <netdev+bounces-287365-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEEBHx3SA2ol/AEAu9opvQ
	(envelope-from <netdev+bounces-287365-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:21:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC1D52BD36
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B50830DE5A3
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 01:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA85914F112;
	Wed, 13 May 2026 01:17:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-5.us.a.mail.aliyun.com (out198-5.us.a.mail.aliyun.com [47.90.198.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78861366560;
	Wed, 13 May 2026 01:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778635046; cv=none; b=ljIMjGFzJvF+lz9/gEXRxibBNSwKX1y/LU4FZhLEIEYhI6Wr/wcy9ULUJJ1nYKnOUZsaSFu/n5BeK3G/u/JNl01yUzUQXoI31I8yWGGrkuiS4vitU9C+CSf+UJJ0VeV/UECtYxLCSAEZjbLfcPQ73xD5AcZQxejv0OTgWbuS66w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778635046; c=relaxed/simple;
	bh=xDCyF6MRneW2gircXs/NcJdPaVYnwx7OoP19YH5y11M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OYtr4qIxcY8/kihl4uOuqgaRUzEgHitru0v6Zx8yLcpOGRMUzcVDWhYTgGjuCtgukWtx7a2nBjCDf/Frn5gzuyP6p2ORV0mOpJir6d34Pedd0ULCe10EPUwTd4oxhD8b8YZmKaL/Kkf8XYIQEmPiPrbWraLtOhKzCI4vvH1PKco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0259847-0.00138743-0.972628;FP=17739958283449017874|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033040074035;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.hVp4DRH_1778635023;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.hVp4DRH_1778635023 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 13 May 2026 09:17:04 +0800
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
Subject: [PATCH v14 net-next 09/11] net/nebula-matrix: add Dispatch layer implementation
Date: Wed, 13 May 2026 09:16:42 +0800
Message-ID: <20260513011649.4404-10-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513011649.4404-1-illusion.wang@nebula-matrix.com>
References: <20260513011649.4404-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DCC1D52BD36
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287365-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[nebula-matrix.com];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[illusion.wang:url,nebula-matrix.com:email,nebula-matrix.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This patch introduces a control-level routing mechanism for the Dispatch layer.

The Dispatch layer supports two routing paths:
- Direct path: Dispatch Layer -> Resource Layer -> HW Layer
  Tasks are dispatched to Resource Layer, which may interact with HW Layer
  for hardware writes.
- Channel path: Dispatch Layer -> Channel Layer
  Tasks are redirected to the Channel Layer for processing.

Routing is controlled by two components:

1. Interface-declared control levels (per operation)
   Each operation interface declares its required control level:
   - NBL_DISP_CTRL_LVL_MGT: management operations
   - NBL_DISP_CTRL_LVL_NET: network operations (reserved, not yet wired)

2. Upper-layer configured control levels (per PF driver)
   The PF driver configures which control levels use the direct path
   via nbl_disp_init(). Currently only the CTRL_LVL_MGT branch is
   implemented and reachable in nbl_disp_init().

Current state:
- Regular PF: configures NET_LVL at Dispatch layer.
  Since NBL_DISP_CTRL_LVL_NET is not yet wired in nbl_disp_init(),
  all operations currently fall through to the CTRL_LVL_MGT branch
  and use the channel path. The direct path for NET_LVL is a
  framework extension point reserved for future use.

- Management PF: configures both NET_LVL and CTRL_LVL.
  Same as above — currently all ops use channel path.

Future work:
Implement the has_net / NBL_DISP_CTRL_LVL_NET branch in nbl_disp_init()
to enable direct path routing for network operations.

Message Handling Framework:
The Channel path is used by all current operations because the
NBL_DISP_CTRL_LVL_NET branch is not yet implemented. This design
allows the framework to be extended later to support direct HW
access for high-performance network operations without changing
the channel layer or existing control-plane operations.

Resource Layer Locking Strategy (related to this patch):

Mutex protection in nbl_dispatch_mgt:
- configure_msix_map():   LOCKED (via NBL_OPS_CALL_LOCK_RET)
- destroy_msix_map():     LOCKED
- enable_mailbox_irq():   LOCKED
- init_chip_module():     UNLOCKED
- deinit_chip_module():   UNLOCKED
- get_vsi_id():           UNLOCKED
- get_eth_id():           UNLOCKED

Design rationale for unlocked call sites:

1. init_chip_module() / deinit_chip_module():
   - Called ONLY from control path (PF0)
   - These are init/teardown functions that run sequentially
   - No concurrent access possible because:
     a) Called during driver probe/remove
     b) Only one control device exists
   - Safe to call without mutex

2. get_vsi_id() / get_eth_id():
   - These are READ-ONLY operations
   - They only query existing state, never modify it
   - Even if called concurrently with locked operations:
     a) Reading shared state without lock is safe on most
        architectures (torn reads are acceptable for IDs)
     b) The locked operations that MODIFY state are:
        - configure_msix_map (allocates resources)
        - destroy_msix_map (frees resources)
        - enable_mailbox_irq (modifies hw state)
     c) Reading while writing is safe if:
        - Writer holds lock (prevents concurrent writes)
        - Reader doesn't care about torn reads (IDs are atomic)

Mutex purpose:
The ops_mutex_lock protects MODIFY operations on shared
resource state (MSI-X map allocation, hardware configuration).
It does NOT protect read-only queries or ctrl-path init/teardown.

This is a deliberate design choice: locking only the
critical sections minimizes contention while maintaining
safety for the common case (concurrent reads).

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c | 423 +++++++++++++++++-
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.h |  31 ++
 .../nbl/nbl_include/nbl_def_dispatch.h        |  13 +
 3 files changed, 466 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
index 281d33051185..0e33b8edde3a 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
@@ -6,6 +6,412 @@
 #include <linux/pci.h>
 #include "nbl_dispatch.h"
 
+static u16 nbl_disp_chan_get_vsi_id_req(struct nbl_dispatch_mgt *disp_mgt,
+					u16 type)
+{
+	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
+	struct nbl_common_info *common = disp_mgt->common;
+	struct nbl_chan_param_get_vsi_id result = { 0 };
+	struct nbl_chan_param_get_vsi_id param = { 0 };
+	struct nbl_chan_send_info chan_send;
+
+	param.type = cpu_to_le16(type);
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_GET_VSI_ID,
+		      &param, sizeof(param), &result, sizeof(result), 1);
+	if (chan_ops->send_msg(disp_mgt->chan_ops_tbl->priv, &chan_send))
+		return U16_MAX;
+
+	return le16_to_cpu(result.vsi_id);
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
+	struct nbl_chan_param_get_vsi_id result = { 0 };
+	struct nbl_chan_param_get_vsi_id param = { 0 };
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	int copy_len;
+	u16 vsi_id;
+	int ret;
+
+	copy_len = data_len < sizeof(param) ? data_len : sizeof(param);
+	memcpy(&param, data, copy_len);
+	vsi_id = NBL_OPS_CALL_RET(res_ops->get_vsi_id,
+				  (p, src_id, le16_to_cpu(param.type)));
+	result.vsi_id = cpu_to_le16(vsi_id);
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_GET_VSI_ID, msg_id, err,
+		     &result, sizeof(result));
+	ret = chan_ops->send_ack(disp_mgt->chan_ops_tbl->priv, &chan_ack);
+	if (ret)
+		dev_err(dev,
+			"channel send ack failed with ret: %d, msg_type: %d\n",
+			ret, NBL_CHAN_MSG_GET_VSI_ID);
+}
+
+static int nbl_disp_chan_get_eth_id_req(struct nbl_dispatch_mgt *disp_mgt,
+					u16 vsi_id, u8 *eth_num, u8 *eth_id,
+					u8 *logic_eth_id)
+{
+	struct nbl_channel_ops *chan_ops = disp_mgt->chan_ops_tbl->ops;
+	struct nbl_common_info *common = disp_mgt->common;
+	struct nbl_chan_param_get_eth_id result = { 0 };
+	struct nbl_chan_param_get_eth_id param = { 0 };
+	struct nbl_chan_send_info chan_send;
+	int ret;
+
+	param.vsi_id = cpu_to_le16(vsi_id);
+
+	NBL_CHAN_SEND(chan_send, common->mgt_pf, NBL_CHAN_MSG_GET_ETH_ID,
+		      &param, sizeof(param), &result, sizeof(result), 1);
+	ret = chan_ops->send_msg(disp_mgt->chan_ops_tbl->priv, &chan_send);
+
+	*eth_num = result.eth_num;
+	*eth_id = result.eth_id;
+	*logic_eth_id = result.logic_eth_id;
+
+	return ret;
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
+	struct nbl_chan_param_get_eth_id param = { 0 };
+	struct device *dev = disp_mgt->common->dev;
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	int copy_len;
+	int ret;
+
+	copy_len = data_len < sizeof(param) ? data_len : sizeof(param);
+	memcpy(&param, data, copy_len);
+	ret = NBL_OPS_CALL_RET(res_ops->get_eth_id,
+			       (p, le16_to_cpu(param.vsi_id), &result.eth_num,
+			       &result.eth_id, &result.logic_eth_id));
+	if (ret)
+		err = NBL_CHAN_RESP_ERR;
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
+	param.num_net_msix = cpu_to_le16(num_net_msix);
+	param.num_others_msix = cpu_to_le16(num_others_msix);
+	param.msix_mask_en = cpu_to_le16(!!net_msix_mask_en);
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
+	struct nbl_chan_param_cfg_msix_map param = { 0 };
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	int copy_len;
+	int ret;
+
+	copy_len = data_len < sizeof(param) ? data_len : sizeof(param);
+	memcpy(&param, data, copy_len);
+	ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->configure_msix_map, p,
+				    src_id, le16_to_cpu(param.num_net_msix),
+				    le16_to_cpu(param.num_others_msix),
+				    le16_to_cpu(param.msix_mask_en));
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
+	param.vector_id = cpu_to_le16(vector_id);
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
+	struct nbl_chan_param_enable_mailbox_irq param = {0};
+	struct device *dev = disp_mgt->common->dev;
+	struct nbl_chan_ack_info chan_ack;
+	int err = NBL_CHAN_RESP_OK;
+	bool enable_msix;
+	u16 vector_id;
+	int copy_len;
+	int ret;
+
+	copy_len = data_len < sizeof(param) ? data_len : sizeof(param);
+	memcpy(&param, data, copy_len);
+	vector_id = le16_to_cpu(param.vector_id);
+	enable_msix = !!param.enable_msix;
+	ret = NBL_OPS_CALL_LOCK_RET(disp_mgt, res_ops->enable_mailbox_irq, p,
+				    src_id, vector_id, enable_msix);
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
+static u16 nbl_disp_get_vsi_id(struct nbl_dispatch_mgt *disp_mgt, u16 type)
+{
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+	struct nbl_common_info *common = disp_mgt->common;
+
+	return NBL_OPS_CALL_RET(res_ops->get_vsi_id, (p, common->mgt_pf, type));
+}
+
+static int nbl_disp_get_eth_id(struct nbl_dispatch_mgt *disp_mgt, u16 vsi_id,
+			       u8 *eth_num, u8 *eth_id, u8 *logic_eth_id)
+{
+	struct nbl_resource_ops *res_ops = disp_mgt->res_ops_tbl->ops;
+	struct nbl_resource_mgt *p = disp_mgt->res_ops_tbl->priv;
+
+	return NBL_OPS_CALL_RET(res_ops->get_eth_id,
+		     (p, vsi_id, eth_num, eth_id, logic_eth_id));
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
+	int _ret;
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
+	if (_msg_type >= 0) {						\
+		_ret = chan_ops->register_msg(p, _msg_type, resp, disp_mgt);\
+		if (_ret < 0 && !ret)					\
+			ret = _ret;					\
+	}								\
+} while (0)
+	NBL_DISP_OPS_TBL;
+#undef  NBL_DISP_SET_OPS
+
+	return ret;
+}
+
+/* Ctrl lvl means that if a certain level is set, then all disp_ops that
+ * declared this lvl will go directly to res_ops, rather than send a
+ * channel msg, and vice versa.
+ */
+static void nbl_disp_setup_ctrl_lvl(struct nbl_dispatch_mgt *disp_mgt, u32 lvl)
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
+}
+
 static struct nbl_dispatch_mgt *
 nbl_disp_setup_disp_mgt(struct nbl_common_info *common)
 {
@@ -71,9 +477,24 @@ int nbl_disp_init(struct nbl_adapter *adapter)
 	adapter->core.disp_mgt = disp_mgt;
 	adapter->intf.dispatch_ops_tbl = disp_ops_tbl;
 
-	return 0;
+	ret = nbl_disp_setup_msg(disp_mgt);
+	if (ret)
+		return ret;
+
+	if (common->has_ctrl)
+		nbl_disp_setup_ctrl_lvl(disp_mgt, NBL_DISP_CTRL_LVL_MGT);
+
+	if (common->has_net)
+		nbl_disp_setup_ctrl_lvl(disp_mgt, NBL_DISP_CTRL_LVL_NET);
+
+	nbl_disp_setup_ctrl_lvl(disp_mgt, NBL_DISP_CTRL_LVL_ALWAYS);
+
+	return ret;
 }
 
 void nbl_disp_remove(struct nbl_adapter *adapter)
 {
+	struct nbl_dispatch_mgt *disp_mgt = adapter->core.disp_mgt;
+
+	mutex_destroy(&disp_mgt->ops_mutex_lock);
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
index 7dc3746b350d..b596edcffda8 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
@@ -6,6 +6,8 @@
 #ifndef _NBL_DEF_DISPATCH_H_
 #define _NBL_DEF_DISPATCH_H_
 
+#include <linux/types.h>
+
 struct nbl_dispatch_mgt;
 struct nbl_adapter;
 enum {
@@ -17,6 +19,17 @@ enum {
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
+	u16 (*get_vsi_id)(struct nbl_dispatch_mgt *disp_mgt, u16 type);
+	int (*get_eth_id)(struct nbl_dispatch_mgt *disp_mgt, u16 vsi_id,
+			  u8 *eth_mode, u8 *eth_id, u8 *logic_eth_id);
 };
 
 struct nbl_dispatch_ops_tbl {
-- 
2.47.3


