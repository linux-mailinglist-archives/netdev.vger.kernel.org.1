Return-Path: <netdev+bounces-257385-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id g6fcDKxPhWlN/wMAu9opvQ
	(envelope-from <netdev+bounces-257385-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 03:19:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF51AF933A
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 03:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D45F30300FB
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 02:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858E72505B2;
	Fri,  6 Feb 2026 02:18:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-19.us.a.mail.aliyun.com (out198-19.us.a.mail.aliyun.com [47.90.198.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6898B273F9;
	Fri,  6 Feb 2026 02:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770344317; cv=none; b=UfE7R7uOaToEwUu8i6Fc1o2Ix+B2ehWYym9fnXSbfX7I9j9JFbJxOkcL/kZMT+44myTa2L7SJW2beotGciW/32hEIUvipRtDnLZe1Bn83h0Eqa18ty+Oi17ynQEyLUDeTtl3ua4hfyHLcFnDFRJCOiVE94FGVPYeo1JHDIylZXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770344317; c=relaxed/simple;
	bh=2jh2nj8iKXRRZmW9v9kpI1H2QyX/vXlMlzuy5E8bg7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fcphm/i7UKFnIy7p8/EOI4awscKiR8RxavVPPJIsSXUIGPthD68pPS9bM19w0btKZF7+3iDMgMH2IU/BGuu24s51K6nLh+Rf2m2n/azt2Rylw2rqOSy+FyPifL06vq/AmayHekAeu1X5jnqToHP6H8yCT3RVBk2EgVm0MBwZm50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.gQHg4jl_1770344295 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Feb 2026 10:18:16 +0800
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
Subject: [PATCH v4 net-next 05/11] net/nebula-matrix: add channel layer
Date: Fri,  6 Feb 2026 10:15:57 +0800
Message-ID: <20260206021608.85381-6-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206021608.85381-1-illusion.wang@nebula-matrix.com>
References: <20260206021608.85381-1-illusion.wang@nebula-matrix.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[nebula-matrix.com];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257385-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.id:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nebula-matrix.com:mid,nebula-matrix.com:email,illusion.wang:url]
X-Rspamd-Queue-Id: BF51AF933A
X-Rspamd-Action: no action

a channel management layer provides structured approach to handle
communication between different components and drivers. Here's a summary
of its key functionalities:

1. Message Handling Framework
Message Registration/Unregistration: Functions (nbl_chan_register_msg,
nbl_chan_unregister_msg) allow dynamic registration of message handlers
for specific message types, enabling extensible communication protocols.
Message Sending/Acknowledgment: Core functions (nbl_chan_send_msg,
nbl_chan_send_ack) handle  message transmission, including asynchronous
operations with acknowledgment (ACK) support.
Received ACKs are processed via nbl_chan_recv_ack_msg.
Hash-Based Handler Lookup: A hash table (handle_hash_tbl) stores message
handlers for efficient O(1) lookup by message type.

2. Channel Types and Queue Management
Mailbox Channel: For direct communication between PF0 and Other PF.
Queue Initialization/Teardown: Functions (nbl_chan_init_queue,
nbl_chan_teardown_queue) manage transmit (TX) and receive (RX) queues.

Queue Configuration: Hardware-specific queue parameters (e.g., buffer
sizes, entry counts) are set via nbl_chan_config_queue, with hardware
interactions delegated to hw_ops.

3. Hardware Abstraction Layer (HW Ops)
Hardware-Specific Operations: The nbl_hw_ops structure abstracts
hardware interactions: queue configuration (config_mailbox_txq/rxq),
 tail pointer updates(update_mailbox_queue_tail_ptr).

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   3 +-
 .../nbl/nbl_channel/nbl_channel.c             | 790 ++++++++++++++++++
 .../nbl/nbl_channel/nbl_channel.h             | 122 +++
 .../nebula-matrix/nbl/nbl_common/nbl_common.c | 227 +++++
 .../nebula-matrix/nbl/nbl_common/nbl_common.h |  28 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  | 101 +++
 .../nbl/nbl_include/nbl_def_channel.h         |  88 ++
 .../nbl/nbl_include/nbl_def_common.h          |  73 ++
 .../nbl/nbl_include/nbl_def_hw.h              |  26 +
 .../nbl/nbl_include/nbl_include.h             |   7 +-
 10 files changed, 1463 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index c88c49dafa0d..b93d21a99e99 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -4,7 +4,8 @@
 
 obj-$(CONFIG_NBL_CORE) := nbl_core.o
 
-nbl_core-objs +=       nbl_channel/nbl_channel.o \
+nbl_core-objs +=       nbl_common/nbl_common.o \
+				nbl_channel/nbl_channel.o \
 				nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
 				nbl_hw/nbl_hw_leonis/nbl_resource_leonis.o \
 				nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.o \
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
index 9fc67700c581..a9cfc3295839 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
@@ -6,7 +6,765 @@
 #include <linux/delay.h>
 #include "nbl_channel.h"
 
+static void nbl_chan_delete_msg_handler(struct nbl_channel_mgt *chan_mgt,
+					u16 msg_type)
+{
+	u8 chan_type = NBL_CHAN_TYPE_MAILBOX;
+	struct nbl_chan_info *chan_info;
+
+	nbl_common_free_hash_node(chan_mgt->handle_hash_tbl, &msg_type);
+	chan_info = NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt, chan_type);
+	if (chan_info && chan_info->clean_task)
+		flush_work(chan_info->clean_task);
+}
+
+static int nbl_chan_add_msg_handler(struct nbl_channel_mgt *chan_mgt,
+				    u16 msg_type, nbl_chan_resp func,
+				    void *priv)
+{
+	struct nbl_chan_msg_node_data handler = { 0 };
+	int ret;
+
+	handler.func = func;
+	handler.priv = priv;
+	ret = nbl_common_alloc_hash_node(chan_mgt->handle_hash_tbl, &msg_type,
+					 &handler, NULL);
+
+	return ret;
+}
+
+static int nbl_chan_init_msg_handler(struct nbl_channel_mgt *chan_mgt)
+{
+	struct nbl_common_info *common = chan_mgt->common;
+	struct nbl_hash_tbl_key tbl_key;
+	int ret = 0;
+
+	NBL_HASH_TBL_KEY_INIT(&tbl_key, common->dev, sizeof(u16),
+			      sizeof(struct nbl_chan_msg_node_data),
+			      NBL_CHAN_HANDLER_TBL_BUCKET_SIZE);
+
+	chan_mgt->handle_hash_tbl = nbl_common_init_hash_table(&tbl_key);
+	if (!chan_mgt->handle_hash_tbl) {
+		ret = -ENOMEM;
+		goto alloc_hashtbl_failed;
+	}
+
+	return 0;
+
+alloc_hashtbl_failed:
+	return ret;
+}
+
+static void nbl_chan_remove_msg_handler(struct nbl_channel_mgt *chan_mgt)
+{
+	nbl_common_remove_hash_table(chan_mgt->handle_hash_tbl, NULL);
+
+	chan_mgt->handle_hash_tbl = NULL;
+}
+
+static void nbl_chan_init_queue_param(struct nbl_chan_info *chan_info,
+				      u16 num_txq_entries, u16 num_rxq_entries,
+				      u16 txq_buf_size, u16 rxq_buf_size)
+{
+	spin_lock_init(&chan_info->txq_lock);
+	chan_info->num_txq_entries = num_txq_entries;
+	chan_info->num_rxq_entries = num_rxq_entries;
+	chan_info->txq_buf_size = txq_buf_size;
+	chan_info->rxq_buf_size = rxq_buf_size;
+}
+
+static int nbl_chan_init_tx_queue(struct nbl_common_info *common,
+				  struct nbl_chan_info *chan_info)
+{
+	struct nbl_chan_ring *txq = &chan_info->txq;
+	struct device *dev = common->dev;
+	size_t size =
+		chan_info->num_txq_entries * sizeof(struct nbl_chan_tx_desc);
+
+	txq->desc = dmam_alloc_coherent(dev, size, &txq->dma,
+					GFP_KERNEL | __GFP_ZERO);
+	if (!txq->desc)
+		return -ENOMEM;
+
+	chan_info->wait = devm_kcalloc(dev, chan_info->num_txq_entries,
+				       sizeof(struct nbl_chan_waitqueue_head),
+				       GFP_KERNEL);
+	if (!chan_info->wait)
+		goto req_wait_queue_failed;
+
+	txq->buf = devm_kcalloc(dev, chan_info->num_txq_entries,
+				sizeof(struct nbl_chan_buf), GFP_KERNEL);
+	if (!txq->buf)
+		goto req_num_txq_entries;
+
+	return 0;
+
+req_num_txq_entries:
+req_wait_queue_failed:
+	return -ENOMEM;
+}
+
+static int nbl_chan_init_rx_queue(struct nbl_common_info *common,
+				  struct nbl_chan_info *chan_info)
+{
+	struct nbl_chan_ring *rxq = &chan_info->rxq;
+	struct device *dev = common->dev;
+	size_t size =
+		chan_info->num_rxq_entries * sizeof(struct nbl_chan_rx_desc);
+
+	rxq->desc = dmam_alloc_coherent(dev, size, &rxq->dma,
+					GFP_KERNEL | __GFP_ZERO);
+	if (!rxq->desc) {
+		dev_err(dev,
+			"Allocate DMA for chan rx descriptor ring failed\n");
+		return -ENOMEM;
+	}
+
+	rxq->buf = devm_kcalloc(dev, chan_info->num_rxq_entries,
+				sizeof(struct nbl_chan_buf), GFP_KERNEL);
+	if (!rxq->buf)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int nbl_chan_init_queue(struct nbl_common_info *common,
+			       struct nbl_chan_info *chan_info)
+{
+	int err;
+
+	err = nbl_chan_init_tx_queue(common, chan_info);
+	if (err)
+		return err;
+
+	err = nbl_chan_init_rx_queue(common, chan_info);
+	if (err)
+		goto setup_rx_queue_err;
+
+	return 0;
+
+setup_rx_queue_err:
+	return err;
+}
+
+static void nbl_chan_config_queue(struct nbl_channel_mgt *chan_mgt,
+				  struct nbl_chan_info *chan_info, bool tx)
+{
+	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
+	struct nbl_hw_mgt *p = chan_mgt->hw_ops_tbl->priv;
+	int size_bwid = ilog2(chan_info->num_rxq_entries);
+	struct nbl_chan_ring *ring;
+	dma_addr_t dma_addr;
+
+	if (tx)
+		ring = &chan_info->txq;
+	else
+		ring = &chan_info->rxq;
+	dma_addr = ring->dma;
+	if (tx)
+		hw_ops->config_mailbox_txq(p, dma_addr, size_bwid);
+	else
+		hw_ops->config_mailbox_rxq(p, dma_addr, size_bwid);
+}
+
+static int nbl_chan_alloc_all_tx_bufs(struct nbl_channel_mgt *chan_mgt,
+				      struct nbl_chan_info *chan_info)
+{
+	struct nbl_chan_ring *txq = &chan_info->txq;
+	struct device *dev = chan_mgt->common->dev;
+	struct nbl_chan_buf *buf;
+	u16 i;
+
+	for (i = 0; i < chan_info->num_txq_entries; i++) {
+		buf = &txq->buf[i];
+		buf->va = dmam_alloc_coherent(dev, chan_info->txq_buf_size,
+					      &buf->pa,
+					      GFP_KERNEL | __GFP_ZERO);
+		if (!buf->va) {
+			dev_err(dev,
+				"Allocate buffer for chan tx queue failed\n");
+			goto err;
+		}
+	}
+
+	txq->next_to_clean = 0;
+	txq->next_to_use = 0;
+	txq->tail_ptr = 0;
+
+	return 0;
+err:
+	return -ENOMEM;
+}
+
+static int
+nbl_chan_cfg_mailbox_qinfo_map_table(struct nbl_channel_mgt *chan_mgt)
+{
+	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
+	struct nbl_common_info *common = chan_mgt->common;
+	struct nbl_hw_mgt *p = chan_mgt->hw_ops_tbl->priv;
+	u16 func_id;
+	u32 pf_mask;
+
+	pf_mask = hw_ops->get_host_pf_mask(p);
+	for (func_id = 0; func_id < NBL_MAX_PF; func_id++) {
+		if (!(pf_mask & (1 << func_id)))
+			hw_ops->cfg_mailbox_qinfo(p, func_id, common->hw_bus,
+						  common->devid,
+						  common->function + func_id);
+	}
+
+	return 0;
+}
+
+static int nbl_chan_cfg_qinfo_map_table(struct nbl_channel_mgt *chan_mgt,
+					u8 chan_type)
+{
+	return nbl_chan_cfg_mailbox_qinfo_map_table(chan_mgt);
+}
+
+#define NBL_UPDATE_QUEUE_TAIL_PTR(chan_info, hw_ops, chan_mgt, tail_ptr, qid)\
+do {									\
+	(void)(chan_info);						\
+	typeof(hw_ops) _hw_ops = (hw_ops);				\
+	typeof(chan_mgt) _chan_mgt = (chan_mgt);			\
+	typeof(tail_ptr) _tail_ptr = (tail_ptr);			\
+	typeof(qid) _qid = (qid);					\
+	(_hw_ops)->update_mailbox_queue_tail_ptr(			\
+		_chan_mgt->hw_ops_tbl->priv, _tail_ptr, _qid);	\
+} while (0)
+
+static int nbl_chan_alloc_all_rx_bufs(struct nbl_channel_mgt *chan_mgt,
+				      struct nbl_chan_info *chan_info)
+{
+	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
+	struct nbl_chan_ring *rxq = &chan_info->rxq;
+	struct device *dev = chan_mgt->common->dev;
+	struct nbl_chan_rx_desc *desc;
+	struct nbl_chan_buf *buf;
+	u32 retry_times = 0;
+	u16 i;
+
+	for (i = 0; i < chan_info->num_rxq_entries; i++) {
+		buf = &rxq->buf[i];
+		buf->va = dmam_alloc_coherent(dev, chan_info->rxq_buf_size,
+					      &buf->pa,
+					      GFP_KERNEL | __GFP_ZERO);
+		if (!buf->va) {
+			dev_err(dev,
+				"Allocate buffer for chan rx queue failed\n");
+			goto err;
+		}
+	}
+
+	desc = rxq->desc;
+	for (i = 0; i < chan_info->num_rxq_entries - 1; i++) {
+		buf = &rxq->buf[i];
+		desc[i].flags = NBL_CHAN_RX_DESC_AVAIL;
+		desc[i].buf_addr = buf->pa;
+		desc[i].buf_len = chan_info->rxq_buf_size;
+	}
+
+	rxq->next_to_clean = 0;
+	rxq->next_to_use = chan_info->num_rxq_entries - 1;
+	rxq->tail_ptr = chan_info->num_rxq_entries - 1;
+
+	/* mb for notify */
+	mb();
+
+	NBL_UPDATE_QUEUE_TAIL_PTR(chan_info, hw_ops, chan_mgt, rxq->tail_ptr,
+				  NBL_MB_RX_QID);
+
+	for (retry_times = 0; retry_times < 3; retry_times++) {
+		NBL_UPDATE_QUEUE_TAIL_PTR(chan_info, hw_ops, chan_mgt,
+					  rxq->tail_ptr, NBL_MB_RX_QID);
+		usleep_range(NBL_CHAN_TX_WAIT_US * 50,
+			     NBL_CHAN_TX_WAIT_US * 60);
+	}
+
+	return 0;
+err:
+	return -ENOMEM;
+}
+
+static int nbl_chan_alloc_all_bufs(struct nbl_channel_mgt *chan_mgt,
+				   struct nbl_chan_info *chan_info)
+{
+	int err;
+
+	err = nbl_chan_alloc_all_tx_bufs(chan_mgt, chan_info);
+	if (err)
+		return err;
+	err = nbl_chan_alloc_all_rx_bufs(chan_mgt, chan_info);
+	if (err)
+		goto alloc_rx_bufs_err;
+
+	return 0;
+
+alloc_rx_bufs_err:
+	return err;
+}
+
+static void nbl_chan_stop_queue(struct nbl_channel_mgt *chan_mgt,
+				struct nbl_chan_info *chan_info)
+{
+	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
+
+	hw_ops->stop_mailbox_rxq(chan_mgt->hw_ops_tbl->priv);
+	hw_ops->stop_mailbox_txq(chan_mgt->hw_ops_tbl->priv);
+}
+
+static int nbl_chan_teardown_queue(struct nbl_channel_mgt *chan_mgt,
+				   u8 chan_type)
+{
+	struct nbl_chan_info *chan_info =
+		NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt, chan_type);
+
+	nbl_chan_stop_queue(chan_mgt, chan_info);
+	return 0;
+}
+
+static int nbl_chan_setup_queue(struct nbl_channel_mgt *chan_mgt, u8 chan_type)
+{
+	struct nbl_common_info *common = chan_mgt->common;
+	struct nbl_chan_info *chan_info =
+		NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt, chan_type);
+	int err;
+
+	nbl_chan_init_queue_param(chan_info, NBL_CHAN_QUEUE_LEN,
+				  NBL_CHAN_QUEUE_LEN, NBL_CHAN_BUF_LEN,
+				  NBL_CHAN_BUF_LEN);
+	err = nbl_chan_init_queue(common, chan_info);
+	if (err)
+		return err;
+
+	nbl_chan_config_queue(chan_mgt, chan_info, true); /* tx */
+	nbl_chan_config_queue(chan_mgt, chan_info, false); /* rx */
+
+	err = nbl_chan_alloc_all_bufs(chan_mgt, chan_info);
+	if (err)
+		goto chan_q_setup_fail;
+
+	return 0;
+
+chan_q_setup_fail:
+	nbl_chan_teardown_queue(chan_mgt, chan_type);
+	return err;
+}
+
+static int nbl_chan_update_txqueue(struct nbl_channel_mgt *chan_mgt,
+				   struct nbl_chan_info *chan_info,
+				   struct nbl_chan_tx_param *param)
+{
+	struct nbl_chan_ring *txq = &chan_info->txq;
+	struct nbl_chan_tx_desc *tx_desc =
+		NBL_CHAN_TX_RING_TO_DESC(txq, txq->next_to_use);
+	struct nbl_chan_buf *tx_buf =
+		NBL_CHAN_TX_RING_TO_BUF(txq, txq->next_to_use);
+
+	if (param->arg_len > NBL_CHAN_BUF_LEN - sizeof(*tx_desc))
+		return -EINVAL;
+
+	tx_desc->dstid = param->dstid;
+	tx_desc->msg_type = param->msg_type;
+	tx_desc->msgid = param->msgid;
+
+	if (param->arg_len > NBL_CHAN_TX_DESC_EMBEDDED_DATA_LEN) {
+		memcpy(tx_buf->va, param->arg, param->arg_len);
+		tx_desc->buf_addr = tx_buf->pa;
+		tx_desc->buf_len = param->arg_len;
+		tx_desc->data_len = 0;
+	} else {
+		memcpy(tx_desc->data, param->arg, param->arg_len);
+		tx_desc->buf_len = 0;
+		tx_desc->data_len = param->arg_len;
+	}
+	tx_desc->flags = NBL_CHAN_TX_DESC_AVAIL;
+
+	/* wmb */
+	wmb();
+	txq->next_to_use =
+		NBL_NEXT_ID(txq->next_to_use, chan_info->num_txq_entries - 1);
+	txq->tail_ptr++;
+
+	return 0;
+}
+
+static int nbl_chan_kick_tx_ring(struct nbl_channel_mgt *chan_mgt,
+				 struct nbl_chan_info *chan_info)
+{
+	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
+	struct nbl_chan_ring *txq = &chan_info->txq;
+	struct device *dev = chan_mgt->common->dev;
+	struct nbl_chan_tx_desc *tx_desc;
+	int i = 0;
+
+	/* mb for tx notify */
+	mb();
+
+	NBL_UPDATE_QUEUE_TAIL_PTR(chan_info, hw_ops, chan_mgt, txq->tail_ptr,
+				  NBL_MB_TX_QID);
+
+	tx_desc = NBL_CHAN_TX_RING_TO_DESC(txq, txq->next_to_clean);
+
+	while (!(tx_desc->flags & NBL_CHAN_TX_DESC_USED)) {
+		udelay(NBL_CHAN_TX_WAIT_US);
+		i++;
+
+		if (!(i % NBL_CHAN_TX_REKICK_WAIT_TIMES))
+			NBL_UPDATE_QUEUE_TAIL_PTR(chan_info, hw_ops, chan_mgt,
+						  txq->tail_ptr, NBL_MB_TX_QID);
+
+		if (i == NBL_CHAN_TX_WAIT_TIMES) {
+			dev_err(dev, "chan send message type: %d timeout\n",
+				tx_desc->msg_type);
+			return -EAGAIN;
+		}
+	}
+
+	txq->next_to_clean = txq->next_to_use;
+	return 0;
+}
+
+static void nbl_chan_recv_ack_msg(void *priv, u16 srcid, u16 msgid, void *data,
+				  u32 data_len)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+	struct nbl_chan_info *chan_info = NBL_CHAN_MGT_TO_MBX(chan_mgt);
+	struct nbl_chan_waitqueue_head *wait_head = NULL;
+	union nbl_chan_msg_id ack_msgid = { { 0 } };
+	u32 *payload = (u32 *)data;
+	u32 ack_datalen = 0;
+	u32 copy_len = 0;
+
+	ack_datalen = data_len - 3 * sizeof(u32);
+	ack_msgid.id = *(u16 *)(payload + 1);
+	wait_head = &chan_info->wait[ack_msgid.info.loc];
+	wait_head->ack_err = *(payload + 2);
+
+	copy_len = min_t(u32, wait_head->ack_data_len, ack_datalen);
+	if (wait_head->ack_err >= 0 && copy_len > 0)
+		memcpy((char *)wait_head->ack_data, payload + 3, copy_len);
+	wait_head->ack_data_len = (u16)copy_len;
+
+	/* wmb */
+	wmb();
+	wait_head->acked = 1;
+	if (wait_head->need_waked)
+		wake_up(&wait_head->wait_queue);
+}
+
+static void nbl_chan_recv_msg(struct nbl_channel_mgt *chan_mgt, void *data,
+			      u32 data_len)
+{
+	struct device *dev = chan_mgt->common->dev;
+	struct nbl_chan_msg_node_data *msg_handler;
+	u16 msg_type, payload_len, srcid, msgid;
+	struct nbl_chan_tx_desc *tx_desc;
+	void *payload;
+
+	tx_desc = data;
+	msg_type = tx_desc->msg_type;
+	dev_dbg(dev, "recv msg_type: %d\n", tx_desc->msg_type);
+
+	srcid = tx_desc->srcid;
+	msgid = tx_desc->msgid;
+	if (msg_type >= NBL_CHAN_MSG_MAILBOX_MAX)
+		return;
+
+	if (tx_desc->data_len) {
+		payload = (void *)tx_desc->data;
+		payload_len = tx_desc->data_len;
+	} else {
+		payload = (void *)(tx_desc + 1);
+		payload_len = tx_desc->buf_len;
+	}
+
+	msg_handler =
+		nbl_common_get_hash_node(chan_mgt->handle_hash_tbl, &msg_type);
+	if (msg_handler) {
+		msg_handler->func(msg_handler->priv, srcid, msgid, payload,
+				  payload_len);
+		return;
+	}
+}
+
+static void nbl_chan_advance_rx_ring(struct nbl_channel_mgt *chan_mgt,
+				     struct nbl_chan_info *chan_info,
+				     struct nbl_chan_ring *rxq)
+{
+	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
+	struct nbl_chan_rx_desc *rx_desc;
+	struct nbl_chan_buf *rx_buf;
+	u16 next_to_use;
+
+	next_to_use = rxq->next_to_use;
+	rx_desc = NBL_CHAN_RX_RING_TO_DESC(rxq, next_to_use);
+	rx_buf = NBL_CHAN_RX_RING_TO_BUF(rxq, next_to_use);
+
+	rx_desc->flags = NBL_CHAN_RX_DESC_AVAIL;
+	rx_desc->buf_addr = rx_buf->pa;
+	rx_desc->buf_len = chan_info->rxq_buf_size;
+
+	/* wmb */
+	wmb();
+	rxq->next_to_use++;
+	if (rxq->next_to_use == chan_info->num_rxq_entries)
+		rxq->next_to_use = 0;
+	rxq->tail_ptr++;
+
+	NBL_UPDATE_QUEUE_TAIL_PTR(chan_info, hw_ops, chan_mgt, rxq->tail_ptr,
+				  NBL_MB_RX_QID);
+}
+
+static void nbl_chan_clean_queue(struct nbl_channel_mgt *chan_mgt,
+				 struct nbl_chan_info *chan_info)
+{
+	struct nbl_chan_ring *rxq = &chan_info->rxq;
+	struct device *dev = chan_mgt->common->dev;
+	struct nbl_chan_rx_desc *rx_desc;
+	struct nbl_chan_buf *rx_buf;
+	u16 next_to_clean;
+
+	next_to_clean = rxq->next_to_clean;
+	rx_desc = NBL_CHAN_RX_RING_TO_DESC(rxq, next_to_clean);
+	rx_buf = NBL_CHAN_RX_RING_TO_BUF(rxq, next_to_clean);
+	while (rx_desc->flags & NBL_CHAN_RX_DESC_USED) {
+		if (!(rx_desc->flags & NBL_CHAN_RX_DESC_WRITE))
+			dev_dbg(dev,
+				"mailbox rx flag 0x%x has no NBL_CHAN_RX_DESC_WRITE\n",
+				rx_desc->flags);
+
+		dma_rmb();
+		nbl_chan_recv_msg(chan_mgt, rx_buf->va, rx_desc->buf_len);
+		nbl_chan_advance_rx_ring(chan_mgt, chan_info, rxq);
+		next_to_clean++;
+		if (next_to_clean == chan_info->num_rxq_entries)
+			next_to_clean = 0;
+		rx_desc = NBL_CHAN_RX_RING_TO_DESC(rxq, next_to_clean);
+		rx_buf = NBL_CHAN_RX_RING_TO_BUF(rxq, next_to_clean);
+	}
+	rxq->next_to_clean = next_to_clean;
+}
+
+static void nbl_chan_clean_queue_subtask(struct nbl_channel_mgt *chan_mgt,
+					 u8 chan_type)
+{
+	struct nbl_chan_info *chan_info =
+		NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt, chan_type);
+
+	if (!test_bit(NBL_CHAN_INTERRUPT_READY, chan_info->state) ||
+	    test_bit(NBL_CHAN_RESETTING, chan_info->state))
+		return;
+
+	nbl_chan_clean_queue(chan_mgt, chan_info);
+}
+
+static int nbl_chan_get_msg_id(struct nbl_chan_info *chan_info,
+			       union nbl_chan_msg_id *msgid)
+{
+	struct nbl_chan_waitqueue_head *wait = NULL;
+	int valid_loc = chan_info->wait_head_index, i;
+
+	for (i = 0; i < NBL_CHAN_QUEUE_LEN; i++) {
+		wait = &chan_info->wait[valid_loc];
+
+		if (wait->status != NBL_MBX_STATUS_WAITING) {
+			wait->msg_index = NBL_NEXT_ID(wait->msg_index,
+						      NBL_CHAN_MSG_INDEX_MAX);
+			msgid->info.index = wait->msg_index;
+			msgid->info.loc = valid_loc;
+
+			valid_loc = NBL_NEXT_ID(valid_loc,
+						chan_info->num_txq_entries - 1);
+			chan_info->wait_head_index = valid_loc;
+			return 0;
+		}
+
+		valid_loc =
+			NBL_NEXT_ID(valid_loc, chan_info->num_txq_entries - 1);
+	}
+
+	return -ENOSPC;
+}
+
+static int nbl_chan_send_msg(struct nbl_channel_mgt *chan_mgt,
+			     struct nbl_chan_send_info *chan_send)
+{
+	struct nbl_chan_info *chan_info = NBL_CHAN_MGT_TO_MBX(chan_mgt);
+	struct nbl_common_info *common = chan_mgt->common;
+	struct nbl_chan_waitqueue_head *wait_head;
+	union nbl_chan_msg_id msgid = { { 0 } };
+	struct nbl_chan_tx_param tx_param = { 0 };
+	int i = NBL_CHAN_TX_WAIT_ACK_TIMES, ret;
+	struct device *dev = common->dev;
+
+	if (test_bit(NBL_CHAN_ABNORMAL, chan_info->state))
+		return -EFAULT;
+
+	spin_lock(&chan_info->txq_lock);
+
+	ret = nbl_chan_get_msg_id(chan_info, &msgid);
+	if (ret) {
+		spin_unlock(&chan_info->txq_lock);
+		dev_err(dev,
+			"Channel tx wait head full, send msgtype:%u to dstid:%u failed\n",
+			chan_send->msg_type, chan_send->dstid);
+		return ret;
+	}
+
+	tx_param.msg_type = chan_send->msg_type;
+	tx_param.arg = chan_send->arg;
+	tx_param.arg_len = chan_send->arg_len;
+	tx_param.dstid = chan_send->dstid;
+	tx_param.msgid = msgid.id;
+
+	ret = nbl_chan_update_txqueue(chan_mgt, chan_info, &tx_param);
+	if (ret) {
+		spin_unlock(&chan_info->txq_lock);
+		dev_err(dev,
+			"Channel tx queue full, send msgtype:%u to dstid:%u failed\n",
+			chan_send->msg_type, chan_send->dstid);
+		return ret;
+	}
+
+	wait_head = &chan_info->wait[msgid.info.loc];
+	init_waitqueue_head(&wait_head->wait_queue);
+	wait_head->acked = 0;
+	wait_head->ack_data = chan_send->resp;
+	wait_head->ack_data_len = chan_send->resp_len;
+	wait_head->msg_type = chan_send->msg_type;
+	wait_head->need_waked = chan_send->ack;
+	wait_head->msg_index = msgid.info.index;
+	wait_head->status = chan_send->ack ? NBL_MBX_STATUS_WAITING :
+					     NBL_MBX_STATUS_IDLE;
+
+	ret = nbl_chan_kick_tx_ring(chan_mgt, chan_info);
+
+	spin_unlock(&chan_info->txq_lock);
+
+	if (!chan_send->ack)
+		return 0;
+
+	if (test_bit(NBL_CHAN_INTERRUPT_READY, chan_info->state)) {
+		ret = wait_event_timeout(wait_head->wait_queue,
+					 wait_head->acked,
+					 NBL_CHAN_ACK_WAIT_TIME);
+		if (!ret) {
+			wait_head->status = NBL_MBX_STATUS_TIMEOUT;
+			dev_err(dev,
+				"Channel waiting ack failed, message type: %d, msg id: %u\n",
+				chan_send->msg_type, msgid.id);
+			return -EFAULT;
+		}
+
+		/* rmb for waithead ack */
+		rmb();
+		chan_send->ack_len = wait_head->ack_data_len;
+		wait_head->status = NBL_MBX_STATUS_IDLE;
+		return wait_head->ack_err;
+	}
+
+	/*polling wait mailbox ack*/
+	while (i--) {
+		nbl_chan_clean_queue(chan_mgt, chan_info);
+
+		if (wait_head->acked) {
+			chan_send->ack_len = wait_head->ack_data_len;
+			wait_head->status = NBL_MBX_STATUS_IDLE;
+			return wait_head->ack_err;
+		}
+		usleep_range(NBL_CHAN_TX_WAIT_ACK_US_MIN,
+			     NBL_CHAN_TX_WAIT_ACK_US_MAX);
+	}
+
+	wait_head->status = NBL_MBX_STATUS_TIMEOUT;
+	dev_err(dev,
+		"Channel polling ack failed, message type: %d msg id: %u\n",
+		chan_send->msg_type, msgid.id);
+	return 0;
+}
+
+static int nbl_chan_send_ack(struct nbl_channel_mgt *chan_mgt,
+			     struct nbl_chan_ack_info *chan_ack)
+{
+	u32 len = 3 * sizeof(u32) + chan_ack->data_len;
+	struct nbl_chan_send_info chan_send;
+	u32 *tmp;
+
+	tmp = kzalloc(len, GFP_ATOMIC);
+	if (!tmp)
+		return -ENOMEM;
+
+	tmp[0] = chan_ack->msg_type;
+	tmp[1] = chan_ack->msgid;
+	tmp[2] = (u32)chan_ack->err;
+	if (chan_ack->data && chan_ack->data_len)
+		memcpy(&tmp[3], chan_ack->data, chan_ack->data_len);
+
+	NBL_CHAN_SEND(chan_send, chan_ack->dstid, NBL_CHAN_MSG_ACK, tmp, len,
+		      NULL, 0, 0);
+	nbl_chan_send_msg(chan_mgt, &chan_send);
+	kfree(tmp);
+
+	return 0;
+}
+
+static void nbl_chan_unregister_msg(struct nbl_channel_mgt *chan_mgt,
+				    u16 msg_type)
+{
+	nbl_chan_delete_msg_handler(chan_mgt, msg_type);
+}
+
+static int nbl_chan_register_msg(struct nbl_channel_mgt *chan_mgt, u16 msg_type,
+				 nbl_chan_resp func, void *callback)
+{
+	return nbl_chan_add_msg_handler(chan_mgt, msg_type, func, callback);
+}
+
+static bool nbl_chan_check_queue_exist(struct nbl_channel_mgt *chan_mgt,
+				       u8 chan_type)
+{
+	struct nbl_chan_info *chan_info;
+
+	chan_info = NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt, chan_type);
+
+	return chan_info ? true : false;
+}
+
+static void nbl_chan_register_chan_task(struct nbl_channel_mgt *chan_mgt,
+					u8 chan_type, struct work_struct *task)
+{
+	struct nbl_chan_info *chan_info =
+		NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt, chan_type);
+
+	chan_info->clean_task = task;
+}
+
+static void nbl_chan_set_queue_state(struct nbl_channel_mgt *chan_mgt,
+				     enum nbl_chan_state state, u8 chan_type,
+				     u8 set)
+{
+	struct nbl_chan_info *chan_info =
+		NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt, chan_type);
+
+	if (set)
+		set_bit(state, chan_info->state);
+	else
+		clear_bit(state, chan_info->state);
+}
+
 static struct nbl_channel_ops chan_ops = {
+	.send_msg			= nbl_chan_send_msg,
+	.send_ack			= nbl_chan_send_ack,
+	.register_msg			= nbl_chan_register_msg,
+	.unregister_msg			= nbl_chan_unregister_msg,
+	.cfg_chan_qinfo_map_table	= nbl_chan_cfg_qinfo_map_table,
+	.check_queue_exist		= nbl_chan_check_queue_exist,
+	.setup_queue			= nbl_chan_setup_queue,
+	.teardown_queue			= nbl_chan_teardown_queue,
+	.clean_queue_subtask		= nbl_chan_clean_queue_subtask,
+	.register_chan_task		= nbl_chan_register_chan_task,
+	.set_queue_state		= nbl_chan_set_queue_state,
 };
 
 static int
@@ -18,6 +776,7 @@ nbl_chan_setup_chan_mgt(struct nbl_adapter *adapter,
 	struct nbl_common_info *common = &adapter->common;
 	struct device *dev = &adapter->pdev->dev;
 	struct nbl_chan_info *mailbox;
+	int ret;
 
 	*chan_mgt_leonis = devm_kzalloc(dev,
 					sizeof(struct nbl_channel_mgt_leonis),
@@ -35,16 +794,31 @@ nbl_chan_setup_chan_mgt(struct nbl_adapter *adapter,
 	(&(*chan_mgt_leonis)->chan_mgt)->chan_info[NBL_CHAN_TYPE_MAILBOX] =
 		mailbox;
 
+	ret = nbl_chan_init_msg_handler(&(*chan_mgt_leonis)->chan_mgt);
+	if (ret)
+		goto init_chan_msg_handle;
+
 	return 0;
+
+init_chan_msg_handle:
 alloc_mailbox_fail:
 alloc_channel_mgt_leonis_fail:
 	return -ENOMEM;
 }
 
+static void
+nbl_chan_remove_chan_mgt(struct nbl_common_info *common,
+			 struct nbl_channel_mgt_leonis **chan_mgt_leonis)
+{
+	nbl_chan_remove_msg_handler(&(*chan_mgt_leonis)->chan_mgt);
+}
+
 static int nbl_chan_setup_ops(struct device *dev,
 			      struct nbl_channel_ops_tbl **chan_ops_tbl,
 			      struct nbl_channel_mgt_leonis *chan_mgt)
 {
+	int ret;
+
 	*chan_ops_tbl = devm_kzalloc(dev, sizeof(struct nbl_channel_ops_tbl),
 				     GFP_KERNEL);
 	if (!*chan_ops_tbl)
@@ -52,7 +826,16 @@ static int nbl_chan_setup_ops(struct device *dev,
 
 	(*chan_ops_tbl)->ops = &chan_ops;
 	(*chan_ops_tbl)->priv = &chan_mgt->chan_mgt;
+
+	ret = nbl_chan_register_msg(&chan_mgt->chan_mgt, NBL_CHAN_MSG_ACK,
+				    nbl_chan_recv_ack_msg, chan_mgt);
+	if (ret)
+		goto err;
+
 	return 0;
+
+err:
+	return ret;
 }
 
 int nbl_chan_init_common(struct nbl_adapter *adap, struct nbl_init_param *param)
@@ -60,6 +843,7 @@ int nbl_chan_init_common(struct nbl_adapter *adap, struct nbl_init_param *param)
 	struct nbl_channel_ops_tbl **chan_ops_tbl = &adap->intf.channel_ops_tbl;
 	struct nbl_channel_mgt_leonis **chan_mgt_leonis =
 		(struct nbl_channel_mgt_leonis **)&NBL_ADAP_TO_CHAN_MGT(adap);
+	struct nbl_common_info *common = &adap->common;
 	struct device *dev = &adap->pdev->dev;
 	int ret;
 
@@ -73,10 +857,16 @@ int nbl_chan_init_common(struct nbl_adapter *adap, struct nbl_init_param *param)
 	return 0;
 
 setup_ops_fail:
+	nbl_chan_remove_chan_mgt(common, chan_mgt_leonis);
 setup_mgt_fail:
 	return ret;
 }
 
 void nbl_chan_remove_common(struct nbl_adapter *adap)
 {
+	struct nbl_channel_mgt_leonis **chan_mgt_leonis =
+		(struct nbl_channel_mgt_leonis **)&NBL_ADAP_TO_CHAN_MGT(adap);
+	struct nbl_common_info *common = &adap->common;
+
+	nbl_chan_remove_chan_mgt(common, chan_mgt_leonis);
 }
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
index 717ea402b8e9..391a7ae83bf1 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
@@ -14,11 +14,133 @@
 #define NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt, chan_type) \
 	((chan_mgt)->chan_info[chan_type])
 
+#define NBL_CHAN_TX_RING_TO_DESC(tx_ring, i) \
+	(&(((struct nbl_chan_tx_desc *)((tx_ring)->desc))[i]))
+#define NBL_CHAN_RX_RING_TO_DESC(rx_ring, i) \
+	(&(((struct nbl_chan_rx_desc *)((rx_ring)->desc))[i]))
+#define NBL_CHAN_TX_RING_TO_BUF(tx_ring, i) (&(((tx_ring)->buf)[i]))
+#define NBL_CHAN_RX_RING_TO_BUF(rx_ring, i) (&(((rx_ring)->buf)[i]))
+
+#define NBL_CHAN_TX_WAIT_US			100
+#define NBL_CHAN_TX_REKICK_WAIT_TIMES		2000
+#define NBL_CHAN_TX_WAIT_TIMES			30000
+#define NBL_CHAN_TX_WAIT_ACK_US_MIN		100
+#define NBL_CHAN_TX_WAIT_ACK_US_MAX		120
+#define NBL_CHAN_TX_WAIT_ACK_TIMES		50000
+#define NBL_CHAN_QUEUE_LEN			256
+#define NBL_CHAN_BUF_LEN			4096
+#define NBL_CHAN_TX_DESC_EMBEDDED_DATA_LEN	16
+
+#define NBL_CHAN_TX_DESC_AVAIL			BIT(0)
+#define NBL_CHAN_TX_DESC_USED			BIT(1)
+#define NBL_CHAN_RX_DESC_WRITE			BIT(1)
+#define NBL_CHAN_RX_DESC_AVAIL			BIT(3)
+#define NBL_CHAN_RX_DESC_USED			BIT(4)
+
+#define NBL_CHAN_ACK_WAIT_TIME			(3 * HZ)
+
+#define NBL_CHAN_HANDLER_TBL_BUCKET_SIZE	512
+
+enum {
+	NBL_MB_RX_QID = 0,
+	NBL_MB_TX_QID = 1,
+};
+
+enum {
+	NBL_MBX_STATUS_IDLE = 0,
+	NBL_MBX_STATUS_WAITING,
+	NBL_MBX_STATUS_TIMEOUT = -1,
+};
+
+struct nbl_chan_tx_param {
+	enum nbl_chan_msg_type msg_type;
+	void *arg;
+	size_t arg_len;
+	u16 dstid;
+	u16 msgid;
+};
+
+struct nbl_chan_buf {
+	void *va;
+	dma_addr_t pa;
+	size_t size;
+};
+
+struct nbl_chan_tx_desc {
+	u16 flags;
+	u16 srcid;
+	u16 dstid;
+	u16 data_len;
+	u16 buf_len;
+	u64 buf_addr;
+	u16 msg_type;
+	u8 data[16];
+	u16 msgid;
+	u8 rsv[26];
+} __packed;
+
+struct nbl_chan_rx_desc {
+	u16 flags;
+	u32 buf_len;
+	u16 buf_id;
+	u64 buf_addr;
+} __packed;
+
+struct nbl_chan_ring {
+	void *desc;
+	struct nbl_chan_buf *buf;
+	u16 next_to_use;
+	u16 tail_ptr;
+	u16 next_to_clean;
+	dma_addr_t dma;
+};
+
+#define NBL_CHAN_MSG_INDEX_MAX 63
+
+union nbl_chan_msg_id {
+	struct nbl_chan_msg_id_info {
+		u16 index : 6;
+		u16 loc : 10;
+	} info;
+	u16 id;
+};
+
+struct nbl_chan_waitqueue_head {
+	struct wait_queue_head wait_queue;
+	char *ack_data;
+	int acked;
+	int ack_err;
+	u16 ack_data_len;
+	u16 need_waked;
+	u16 msg_type;
+	u8 status;
+	u8 msg_index;
+};
+
 struct nbl_chan_info {
+	struct nbl_chan_ring txq;
+	struct nbl_chan_ring rxq;
+	struct nbl_chan_waitqueue_head *wait;
+	/* spinlock_t */
+	spinlock_t txq_lock;
+	struct work_struct *clean_task;
+	u16 wait_head_index;
+	u16 num_txq_entries;
+	u16 num_rxq_entries;
+	u16 txq_buf_size;
+	u16 rxq_buf_size;
+	u16 txq_reset_times;
+	u16 rxq_reset_times;
+	DECLARE_BITMAP(state, NBL_CHAN_STATE_NBITS);
 	u8 chan_type;
 
 };
 
+struct nbl_chan_msg_node_data {
+	nbl_chan_resp func;
+	void *priv;
+};
+
 struct nbl_channel_mgt {
 	struct nbl_common_info *common;
 	struct nbl_hw_ops_tbl *hw_ops_tbl;
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
new file mode 100644
index 000000000000..f7175275a6b7
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#include "nbl_common.h"
+
+struct nbl_common_wq_mgt {
+	struct workqueue_struct *ctrl_dev_wq;
+};
+
+static struct nbl_common_wq_mgt *wq_mgt;
+
+void nbl_common_queue_work(struct work_struct *task)
+{
+	queue_work(wq_mgt->ctrl_dev_wq, task);
+}
+
+void nbl_common_destroy_wq(void)
+{
+	destroy_workqueue(wq_mgt->ctrl_dev_wq);
+	kfree(wq_mgt);
+}
+
+int nbl_common_create_wq(void)
+{
+	wq_mgt = kzalloc(sizeof(*wq_mgt), GFP_KERNEL);
+	if (!wq_mgt)
+		return -ENOMEM;
+
+	wq_mgt->ctrl_dev_wq = alloc_workqueue("%s", WQ_MEM_RECLAIM | WQ_UNBOUND,
+					      0, "nbl_ctrldev_wq");
+	if (!wq_mgt->ctrl_dev_wq) {
+		pr_err("Failed to create workqueue nbl_ctrldev_wq\n");
+		goto alloc_ctrl_dev_wq_failed;
+	}
+
+	return 0;
+alloc_ctrl_dev_wq_failed:
+	kfree(wq_mgt);
+	return -ENOMEM;
+}
+
+u32 nbl_common_pf_id_subtraction_mgtpf_id(struct nbl_common_info *common,
+					  u32 pf_id)
+{
+	u32 diff = U32_MAX;
+
+	if (pf_id >= common->mgt_pf)
+		diff = pf_id - common->mgt_pf;
+
+	return diff;
+}
+
+static u32 nbl_common_calc_hash_key(void *key, u32 key_size, u32 bucket_size)
+{
+	u32 value = 0;
+	u32 hash_val;
+	u32 i;
+
+	/* if bucket size little than 1, the hash value always 0 */
+	if (bucket_size == NBL_HASH_TBL_LIST_BUCKET_SIZE)
+		return 0;
+
+	for (i = 0; i < key_size; i++)
+		value += *((u8 *)key + i);
+
+	hash_val = __hash_32(value);
+
+	return hash_val % bucket_size;
+}
+
+/*
+ * alloc a hash table
+ * the table support multi thread
+ */
+struct nbl_hash_tbl_mgt *
+nbl_common_init_hash_table(struct nbl_hash_tbl_key *key)
+{
+	struct nbl_hash_tbl_mgt *tbl_mgt;
+	int bucket_size;
+	int i;
+
+	tbl_mgt = devm_kzalloc(key->dev, sizeof(struct nbl_hash_tbl_mgt),
+			       GFP_KERNEL);
+	if (!tbl_mgt)
+		return NULL;
+
+	bucket_size = key->bucket_size;
+	tbl_mgt->hash = devm_kcalloc(key->dev, bucket_size,
+				     sizeof(struct hlist_head), GFP_KERNEL);
+	if (!tbl_mgt->hash)
+		goto alloc_hash_failed;
+
+	for (i = 0; i < bucket_size; i++)
+		INIT_HLIST_HEAD(tbl_mgt->hash + i);
+
+	memcpy(&tbl_mgt->tbl_key, key, sizeof(struct nbl_hash_tbl_key));
+
+	return tbl_mgt;
+
+alloc_hash_failed:
+	return NULL;
+}
+
+/*
+ * alloc a hash node, and add to hlist_head
+ */
+int nbl_common_alloc_hash_node(struct nbl_hash_tbl_mgt *tbl_mgt, void *key,
+			       void *data, void **out_data)
+{
+	struct nbl_hash_entry_node *hash_node;
+	u16 data_size;
+	u32 hash_val;
+	u16 key_size;
+
+	hash_node = devm_kzalloc(tbl_mgt->tbl_key.dev,
+				 sizeof(struct nbl_hash_entry_node),
+				 GFP_KERNEL);
+	if (!hash_node)
+		return -1;
+
+	key_size = tbl_mgt->tbl_key.key_size;
+	hash_node->key =
+		devm_kzalloc(tbl_mgt->tbl_key.dev, key_size, GFP_KERNEL);
+	if (!hash_node->key)
+		goto alloc_key_failed;
+
+	data_size = tbl_mgt->tbl_key.data_size;
+	hash_node->data =
+		devm_kzalloc(tbl_mgt->tbl_key.dev, data_size, GFP_KERNEL);
+	if (!hash_node->data)
+		goto alloc_data_failed;
+
+	memcpy(hash_node->key, key, key_size);
+	memcpy(hash_node->data, data, data_size);
+
+	hash_val = nbl_common_calc_hash_key(key, key_size,
+					    tbl_mgt->tbl_key.bucket_size);
+
+	hlist_add_head(&hash_node->node, tbl_mgt->hash + hash_val);
+	tbl_mgt->node_num++;
+	if (out_data)
+		*out_data = hash_node->data;
+
+	return 0;
+
+alloc_data_failed:
+alloc_key_failed:
+	return -1;
+}
+
+/*
+ * get a hash node, return the data if node exist
+ */
+void *nbl_common_get_hash_node(struct nbl_hash_tbl_mgt *tbl_mgt, void *key)
+{
+	struct nbl_hash_entry_node *hash_node;
+	struct hlist_head *head;
+	void *data = NULL;
+	u32 hash_val;
+	u16 key_size;
+
+	key_size = tbl_mgt->tbl_key.key_size;
+	hash_val = nbl_common_calc_hash_key(key, key_size,
+					    tbl_mgt->tbl_key.bucket_size);
+	head = tbl_mgt->hash + hash_val;
+
+	hlist_for_each_entry(hash_node, head, node)
+		if (!memcmp(hash_node->key, key, key_size)) {
+			data = hash_node->data;
+			break;
+		}
+
+	return data;
+}
+
+static void nbl_common_remove_hash_node(struct nbl_hash_tbl_mgt *tbl_mgt,
+					struct nbl_hash_entry_node *hash_node)
+{
+	hlist_del(&hash_node->node);
+	tbl_mgt->node_num--;
+}
+
+/*
+ * free a hash node
+ */
+void nbl_common_free_hash_node(struct nbl_hash_tbl_mgt *tbl_mgt, void *key)
+{
+	struct nbl_hash_entry_node *hash_node;
+	struct hlist_head *head;
+	u32 hash_val;
+	u16 key_size;
+
+	key_size = tbl_mgt->tbl_key.key_size;
+	hash_val = nbl_common_calc_hash_key(key, key_size,
+					    tbl_mgt->tbl_key.bucket_size);
+	head = tbl_mgt->hash + hash_val;
+
+	hlist_for_each_entry(hash_node, head, node)
+		if (!memcmp(hash_node->key, key, key_size))
+			break;
+
+	if (hash_node)
+		nbl_common_remove_hash_node(tbl_mgt, hash_node);
+}
+
+void nbl_common_remove_hash_table(struct nbl_hash_tbl_mgt *tbl_mgt,
+				  struct nbl_hash_tbl_del_key *key)
+{
+	struct nbl_hash_entry_node *hash_node;
+	struct hlist_node *safe_node;
+	struct hlist_head *head;
+	u32 i;
+
+	for (i = 0; i < tbl_mgt->tbl_key.bucket_size; i++) {
+		head = tbl_mgt->hash + i;
+		hlist_for_each_entry_safe(hash_node, safe_node, head, node) {
+			if (key && key->action_func)
+				key->action_func(key->action_priv,
+						 hash_node->key,
+						 hash_node->data);
+			nbl_common_remove_hash_node(tbl_mgt, hash_node);
+		}
+	}
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.h
new file mode 100644
index 000000000000..c6a43db41d83
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_COMMON_H_
+#define _NBL_COMMON_H_
+
+#include "nbl_def_common.h"
+
+/* list only need one bucket size */
+#define NBL_HASH_TBL_LIST_BUCKET_SIZE 1
+
+struct nbl_hash_tbl_mgt {
+	struct nbl_hash_tbl_key tbl_key;
+	struct hlist_head *hash;
+	u16 node_num;
+};
+
+/* it used for y_axis no necessay */
+struct nbl_hash_entry_node {
+	struct hlist_node node;
+	void *key;
+	void *data;
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
index 1ff5710cd955..307e71526143 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -6,7 +6,108 @@
 
 #include "nbl_hw_leonis.h"
 
+static void nbl_hw_update_mailbox_queue_tail_ptr(struct nbl_hw_mgt *hw_mgt,
+						 u16 tail_ptr, u8 txrx)
+{
+	/* local_qid 0 and 1 denote rx and tx queue respectively */
+	u32 local_qid = txrx;
+	u32 value = ((u32)tail_ptr << 16) | local_qid;
+
+	/* wmb for doorbell */
+	wmb();
+	nbl_mbx_wr32(hw_mgt, NBL_MAILBOX_NOTIFY_ADDR, value);
+}
+
+static void nbl_hw_config_mailbox_rxq(struct nbl_hw_mgt *hw_mgt,
+				      dma_addr_t dma_addr, int size_bwid)
+{
+	struct nbl_mailbox_qinfo_cfg_table qinfo_cfg_rx_table = { 0 };
+
+	qinfo_cfg_rx_table.queue_rst = 1;
+	nbl_hw_write_mbx_regs(hw_mgt, NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR,
+			      (u8 *)&qinfo_cfg_rx_table,
+			      sizeof(qinfo_cfg_rx_table));
+
+	qinfo_cfg_rx_table.queue_base_addr_l = (u32)(dma_addr & 0xFFFFFFFF);
+	qinfo_cfg_rx_table.queue_base_addr_h = (u32)(dma_addr >> 32);
+	qinfo_cfg_rx_table.queue_size_bwind = (u32)size_bwid;
+	qinfo_cfg_rx_table.queue_rst = 0;
+	qinfo_cfg_rx_table.queue_en = 1;
+	nbl_hw_write_mbx_regs(hw_mgt, NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR,
+			      (u8 *)&qinfo_cfg_rx_table,
+			      sizeof(qinfo_cfg_rx_table));
+}
+
+static void nbl_hw_config_mailbox_txq(struct nbl_hw_mgt *hw_mgt,
+				      dma_addr_t dma_addr, int size_bwid)
+{
+	struct nbl_mailbox_qinfo_cfg_table qinfo_cfg_tx_table = { 0 };
+
+	qinfo_cfg_tx_table.queue_rst = 1;
+	nbl_hw_write_mbx_regs(hw_mgt, NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR,
+			      (u8 *)&qinfo_cfg_tx_table,
+			      sizeof(qinfo_cfg_tx_table));
+
+	qinfo_cfg_tx_table.queue_base_addr_l = (u32)(dma_addr & 0xFFFFFFFF);
+	qinfo_cfg_tx_table.queue_base_addr_h = (u32)(dma_addr >> 32);
+	qinfo_cfg_tx_table.queue_size_bwind = (u32)size_bwid;
+	qinfo_cfg_tx_table.queue_rst = 0;
+	qinfo_cfg_tx_table.queue_en = 1;
+	nbl_hw_write_mbx_regs(hw_mgt, NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR,
+			      (u8 *)&qinfo_cfg_tx_table,
+			      sizeof(qinfo_cfg_tx_table));
+}
+
+static void nbl_hw_stop_mailbox_rxq(struct nbl_hw_mgt *hw_mgt)
+{
+	struct nbl_mailbox_qinfo_cfg_table qinfo_cfg_rx_table = { 0 };
+
+	nbl_hw_write_mbx_regs(hw_mgt, NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR,
+			      (u8 *)&qinfo_cfg_rx_table,
+			      sizeof(qinfo_cfg_rx_table));
+}
+
+static void nbl_hw_stop_mailbox_txq(struct nbl_hw_mgt *hw_mgt)
+{
+	struct nbl_mailbox_qinfo_cfg_table qinfo_cfg_tx_table = { 0 };
+
+	nbl_hw_write_mbx_regs(hw_mgt, NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR,
+			      (u8 *)&qinfo_cfg_tx_table,
+			      sizeof(qinfo_cfg_tx_table));
+}
+
+static u32 nbl_hw_get_host_pf_mask(struct nbl_hw_mgt *hw_mgt)
+{
+	u32 data;
+
+	nbl_hw_rd_regs(hw_mgt, NBL_PCIE_HOST_K_PF_MASK_REG, (u8 *)&data,
+		       sizeof(data));
+	return data;
+}
+
+static void nbl_hw_cfg_mailbox_qinfo(struct nbl_hw_mgt *hw_mgt, u16 func_id,
+				     u16 bus, u16 devid, u16 function)
+{
+	struct nbl_mailbox_qinfo_map_table mb_qinfo_map;
+
+	memset(&mb_qinfo_map, 0, sizeof(mb_qinfo_map));
+	mb_qinfo_map.function = function;
+	mb_qinfo_map.devid = devid;
+	mb_qinfo_map.bus = bus;
+	mb_qinfo_map.msix_idx_valid = 0;
+	nbl_hw_wr_regs(hw_mgt, NBL_MAILBOX_QINFO_MAP_REG_ARR(func_id),
+		       (u8 *)&mb_qinfo_map, sizeof(mb_qinfo_map));
+}
+
 static struct nbl_hw_ops hw_ops = {
+	.update_mailbox_queue_tail_ptr = nbl_hw_update_mailbox_queue_tail_ptr,
+	.config_mailbox_rxq = nbl_hw_config_mailbox_rxq,
+	.config_mailbox_txq = nbl_hw_config_mailbox_txq,
+	.stop_mailbox_rxq = nbl_hw_stop_mailbox_rxq,
+	.stop_mailbox_txq = nbl_hw_stop_mailbox_txq,
+	.get_host_pf_mask = nbl_hw_get_host_pf_mask,
+	.cfg_mailbox_qinfo = nbl_hw_cfg_mailbox_qinfo,
+
 };
 
 /* Structure starts here, adding an op should not modify anything below */
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
index 975924781fe6..61d6038e22bc 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
@@ -9,6 +9,38 @@
 
 #include <linux/if_ether.h>
 #include "nbl_include.h"
+struct nbl_channel_mgt;
+#define NBL_CHAN_SEND(chan_send, dst_id, mesg_type, argument, arg_length,\
+		      response, resp_length, need_ack)			\
+do {									\
+	typeof(chan_send)	*__chan_send = &(chan_send);		\
+	__chan_send->dstid	= (dst_id);				\
+	__chan_send->msg_type	= (mesg_type);				\
+	__chan_send->arg	= (argument);				\
+	__chan_send->arg_len	= (arg_length);				\
+	__chan_send->resp	= (response);				\
+	__chan_send->resp_len	= (resp_length);			\
+	__chan_send->ack	= (need_ack);				\
+} while (0)
+
+#define NBL_CHAN_ACK(chan_ack, dst_id, mesg_type, msg_id, err_code, ack_data, \
+		     data_length)					\
+do {									\
+	typeof(chan_ack)	*__chan_ack = &(chan_ack);		\
+	__chan_ack->dstid	= (dst_id);				\
+	__chan_ack->msg_type	= (mesg_type);				\
+	__chan_ack->msgid	= (msg_id);				\
+	__chan_ack->err		= (err_code);				\
+	__chan_ack->data	= (ack_data);				\
+	__chan_ack->data_len	= (data_length);			\
+} while (0)
+
+typedef void (*nbl_chan_resp)(void *, u16, u16, void *, u32);
+
+enum {
+	NBL_CHAN_RESP_OK,
+	NBL_CHAN_RESP_ERR,
+};
 
 enum nbl_chan_msg_type {
 	NBL_CHAN_MSG_ACK,
@@ -236,6 +268,15 @@ enum nbl_chan_msg_type {
 	NBL_CHAN_MSG_MAILBOX_MAX,
 };
 
+#define NBL_CHANNEL_FREEZE_FAILED_CNT	3
+
+enum nbl_chan_state {
+	NBL_CHAN_INTERRUPT_READY,
+	NBL_CHAN_RESETTING,
+	NBL_CHAN_ABNORMAL,
+	NBL_CHAN_STATE_NBITS
+};
+
 struct nbl_chan_param_cfg_msix_map {
 	u16 num_net_msix;
 	u16 num_others_msix;
@@ -259,12 +300,59 @@ struct nbl_chan_param_get_eth_id {
 	u8 logic_eth_id;
 };
 
+struct nbl_board_port_info {
+	u8 eth_num;
+	u8 eth_speed;
+	u8 p4_version;
+	u8 rsv[5];
+};
+
+struct nbl_chan_send_info {
+	void *arg;
+	size_t arg_len;
+	void *resp;
+	size_t resp_len;
+	u16 dstid;
+	u16 msg_type;
+	u16 ack;
+	u16 ack_len;
+};
+
+struct nbl_chan_ack_info {
+	void *data;
+	int err;
+	u32 data_len;
+	u16 dstid;
+	u16 msg_type;
+	u16 msgid;
+};
+
 enum nbl_channel_type {
 	NBL_CHAN_TYPE_MAILBOX,
 	NBL_CHAN_TYPE_MAX
 };
 
 struct nbl_channel_ops {
+	int (*send_msg)(struct nbl_channel_mgt *chan_mgt,
+			struct nbl_chan_send_info *chan_send);
+	int (*send_ack)(struct nbl_channel_mgt *chan_mgt,
+			struct nbl_chan_ack_info *chan_ack);
+	int (*register_msg)(struct nbl_channel_mgt *chan_mgt, u16 msg_type,
+			    nbl_chan_resp func, void *callback_priv);
+	void (*unregister_msg)(struct nbl_channel_mgt *chan_mgt, u16 msg_type);
+	int (*cfg_chan_qinfo_map_table)(struct nbl_channel_mgt *chan_mgt,
+					u8 chan_type);
+	bool (*check_queue_exist)(struct nbl_channel_mgt *chan_mgt,
+				  u8 chan_type);
+	int (*setup_queue)(struct nbl_channel_mgt *chan_mgt, u8 chan_type);
+	int (*teardown_queue)(struct nbl_channel_mgt *chan_mgt, u8 chan_type);
+	void (*clean_queue_subtask)(struct nbl_channel_mgt *chan_mgt,
+				    u8 chan_type);
+	void (*register_chan_task)(struct nbl_channel_mgt *chan_mgt,
+				   u8 chan_type, struct work_struct *task);
+	void (*set_queue_state)(struct nbl_channel_mgt *chan_mgt,
+				enum nbl_chan_state state, u8 chan_type,
+				u8 set);
 };
 
 struct nbl_channel_ops_tbl {
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
index b98bbc726308..fa53a0019400 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
@@ -8,6 +8,7 @@
 #define _NBL_DEF_COMMON_H_
 
 #include "nbl_include.h"
+struct nbl_hash_tbl_mgt;
 
 struct nbl_common_info {
 	struct pci_dev *pdev;
@@ -30,4 +31,76 @@ struct nbl_common_info {
 	u8 is_ctrl;
 };
 
+struct nbl_hash_tbl_key {
+	struct device *dev;
+	u16 key_size;
+	u16 data_size; /* no include key or node member */
+	u16 bucket_size;
+	u16 resv;
+};
+
+#define NBL_HASH_TBL_KEY_INIT(key, dev_arg, key_size_arg, data_size_arg,\
+			      bucket_size_arg)		\
+do {									\
+	typeof(key)	__key   = key;					\
+	__key->dev		= dev_arg;				\
+	__key->key_size		= key_size_arg;				\
+	__key->data_size	= data_size_arg;			\
+	__key->bucket_size	= bucket_size_arg;			\
+	__key->resv		= 0;					\
+} while (0)
+
+enum nbl_hash_tbl_op_type {
+	NBL_HASH_TBL_OP_SHOW = 0,
+	NBL_HASH_TBL_OP_DELETE,
+};
+
+struct nbl_hash_tbl_del_key {
+	void *action_priv;
+	void (*action_func)(void *priv, void *key, void *data);
+};
+
+#define NBL_HASH_TBL_DEL_KEY_INIT(key, priv_arg, act_func_arg)		\
+do {									\
+	typeof(key)	__key   = key;					\
+	__key->action_priv	= priv_arg;				\
+	__key->action_func	= act_func_arg;				\
+} while (0)
+
+struct nbl_hash_tbl_scan_key {
+	enum nbl_hash_tbl_op_type op_type;
+	void *match_condition;
+	 /* match ret value must be 0  if the node accord with the condition */
+	int (*match_func)(void *condition, void *key, void *data);
+	void *action_priv;
+	void (*action_func)(void *priv, void *key, void *data);
+};
+
+#define NBL_HASH_TBL_SCAN_KEY_INIT(key, op_type_arg, con_arg, match_func_arg,\
+				   priv_arg, act_func_arg)		\
+do {									\
+	typeof(key)	__key   = key;					\
+	__key->op_type		= op_type_arg;				\
+	__key->match_condition	= con_arg;				\
+	__key->match_func	= match_func_arg;			\
+	__key->action_priv	= priv_arg;				\
+	__key->action_func	= act_func_arg;				\
+} while (0)
+
+void nbl_common_queue_work(struct work_struct *task);
+
+void nbl_common_destroy_wq(void);
+int nbl_common_create_wq(void);
+u32 nbl_common_pf_id_subtraction_mgtpf_id(struct nbl_common_info *common,
+					  u32 pf_id);
+
+struct nbl_hash_tbl_mgt *
+nbl_common_init_hash_table(struct nbl_hash_tbl_key *key);
+void nbl_common_remove_hash_table(struct nbl_hash_tbl_mgt *tbl_mgt,
+				  struct nbl_hash_tbl_del_key *key);
+int nbl_common_alloc_hash_node(struct nbl_hash_tbl_mgt *tbl_mgt, void *key,
+			       void *data, void **out_data);
+void *nbl_common_get_hash_node(struct nbl_hash_tbl_mgt *tbl_mgt, void *key);
+void nbl_common_free_hash_node(struct nbl_hash_tbl_mgt *tbl_mgt, void *key);
+
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
index 80ebddec55f8..80b152cad1b0 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
@@ -10,6 +10,32 @@
 #include "nbl_include.h"
 struct nbl_hw_mgt;
 struct nbl_hw_ops {
+	void (*configure_msix_map)(struct nbl_hw_mgt *hw_mgt, u16 func_id,
+				   bool valid, dma_addr_t dma_addr, u8 bus,
+				   u8 devid, u8 function);
+	void (*configure_msix_info)(struct nbl_hw_mgt *hw_mgt, u16 func_id,
+				    bool valid, u16 interrupt_id, u8 bus,
+				    u8 devid, u8 function,
+				    bool net_msix_mask_en);
+	void (*update_mailbox_queue_tail_ptr)(struct nbl_hw_mgt *hw_mgt,
+					      u16 tail_ptr, u8 txrx);
+	void (*config_mailbox_rxq)(struct nbl_hw_mgt *hw_mgt,
+				   dma_addr_t dma_addr, int size_bwid);
+	void (*config_mailbox_txq)(struct nbl_hw_mgt *hw_mgt,
+				   dma_addr_t dma_addr, int size_bwid);
+	void (*stop_mailbox_rxq)(struct nbl_hw_mgt *hw_mgt);
+	void (*stop_mailbox_txq)(struct nbl_hw_mgt *hw_mgt);
+	u32 (*get_host_pf_mask)(struct nbl_hw_mgt *hw_mgt);
+	u32 (*get_real_bus)(struct nbl_hw_mgt *hw_mgt);
+
+	void (*cfg_mailbox_qinfo)(struct nbl_hw_mgt *hw_mgt, u16 func_id,
+				  u16 bus, u16 devid, u16 function);
+	void (*enable_mailbox_irq)(struct nbl_hw_mgt *hw_mgt, u16 func_id,
+				   bool enable_msix, u16 global_vec_id);
+	u32 (*get_fw_eth_num)(struct nbl_hw_mgt *hw_mgt);
+	u32 (*get_fw_eth_map)(struct nbl_hw_mgt *hw_mgt);
+	void (*get_board_info)(struct nbl_hw_mgt *hw_mgt,
+			       struct nbl_board_port_info *board);
 };
 
 struct nbl_hw_ops_tbl {
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index f58b4dbb0aab..f56df4008660 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -11,7 +11,12 @@
 #include <linux/netdevice.h>
 /*  ------  Basic definitions  -------  */
 #define NBL_DRIVER_NAME					"nbl_core"
-
+#define NBL_MAX_PF					8
+#define NBL_NEXT_ID(id, max)				\
+	({						\
+		typeof(id) _id = (id);			\
+		((_id) == (max) ? 0 : (_id) + 1);	\
+	})
 enum nbl_product_type {
 	NBL_LEONIS_TYPE,
 	NBL_PRODUCT_MAX,
-- 
2.47.3


