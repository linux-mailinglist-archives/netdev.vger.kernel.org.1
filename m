Return-Path: <netdev+bounces-248433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A91A4D086FB
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 11:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D625F30A3982
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 10:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E05133B96B;
	Fri,  9 Jan 2026 10:03:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-17.us.a.mail.aliyun.com (out198-17.us.a.mail.aliyun.com [47.90.198.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3FE2FFDE6;
	Fri,  9 Jan 2026 10:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767952984; cv=none; b=ijE0VXtYvPzdsjIWqPLP3/CpVX9k+X0I4RmkIULxbSpUFsFLuZGoAoJ1wtWAqU7nX14iATQr0CYGDjtjtqJxtzUnbcq93SQvYvJaatPZenw7GsmTBYjBwsmyd7Anfjaoz37/pM0b+vnBISAfLoUuTN6gW0qpLV/8KduUO+NP0Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767952984; c=relaxed/simple;
	bh=fkemG3uL2/H/5vTn9FQiVnBZzjDgv1VEWzUhsij7skQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WyPibdvO9FYRVu91GIiCi+RfbZ/UQDfpXuseyCn93AUDWZ/jDcCi8DRVEhqKKOq/Z3XL9c1M4l+Oio//dwFk0zehBWYQGVZ19QqDFDuUUmxsyKdpgNwm3uYCtY1xPl2hZXb2DpyGQ2Ju5kNIFHzRYI2HHF3hrQt33/ZTRu54GNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.g2QQAew_1767952951 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 09 Jan 2026 18:02:32 +0800
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
Subject: [PATCH v2 net-next 05/15] net/nebula-matrix: add channel layer definitions and implementation
Date: Fri,  9 Jan 2026 18:01:23 +0800
Message-ID: <20260109100146.63569-6-illusion.wang@nebula-matrix.com>
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

a channel management layer provides structured approach to handle
communication between different components and drivers. Here's a summary
of its key functionalities:

1. Message Handling Framework
Message Registration/Unregistration: Functions (nbl_chan_register_msg,
nbl_chan_unregister_msg) allow dynamic registration of message handlers
for specific message types, enabling extensible communication protocols.
Message Sending/Acknowledgment: Core functions (nbl_chan_send_msg,
nbl_chan_send_ack) handle  message transmission, including asynchronous
operations with acknowledgment (ACK) support.
Received ACKs are processed via nbl_chan_recv_ack_msg.
Hash-Based Handler Lookup: A hash table (handle_hash_tbl) stores message
handlers for efficient O(1) lookup by message type.

2. Channel Types and Queue Management
Dual Channel Support: The driver supports two channel types:
Mailbox Channel: For direct communication between PF and VF.
Admin Queue (AdminQ): For privileged operations requiring kernel-level
access (e.g., configuration).
Queue Initialization/Teardown: Functions (nbl_chan_init_queue,
nbl_chan_teardown_queue) manage transmit (TX) and receive (RX)
queues, including DMA buffer allocation/deallocation
(dmam_alloc_coherent, dmam_free_coherent).
Queue Configuration: Hardware-specific queue parameters (e.g., buffer
sizes, entry counts) are set via nbl_chan_config_queue, with hardware
interactions delegated to hw_ops.

3. Hardware Abstraction Layer (HW Ops)
Hardware-Specific Operations: The nbl_hw_ops structure abstracts
hardware interactions, allowing different chip variants to implement
their own queue configuration (config_mailbox_txq/rxq,
config_adminq_txq/rxq), tail pointer updates
(update_mailbox_queue_tail_ptr), and DMA error checks
(check_mailbox_dma_err, check_adminq_dma_err).
4. Keepalive Mechanism
Heartbeat Monitoring: A keepalive system (nbl_chan_setup_keepalive,
nbl_chan_keepalive) ensures 
connectivity between drivers by periodically sending heartbeat messages
(NBL_CHAN_MSG_KEEP_ALIVE).
Adjusts timeouts dynamically based on success/failure rates.

5. Error Handling and Recovery
DMA Error Detection: Functions like nbl_chan_check_dma_err detect
hardware-level errors during TX/RX operations, triggering queue resets
(nbl_chan_reset_queue) if needed.
Retry Logic: Message sending includes retry mechanisms (resend_times)
for transient failures (e.g., ACK timeouts).
6. Asynchronous Task Support
Delayed Work Queues: Uses Linux kernel delayed work (delayed_work) for
background tasks like
keepalive checks (nbl_chan_keepalive) and queue cleanup
(nbl_chan_clean_queue_subtask).
7. Initialization and Cleanup
Modular Setup: The nbl_chan_init_common function initializes the channel
management layer,
including memory allocation for channel structures
(nbl_channel_mgt_leonis), message handlers,
and hardware operations tables (nbl_channel_ops_tbl).
Resource Cleanup: Corresponding nbl_chan_remove_common ensures all
allocated resources (memory, workqueues, handlers) are freed during
driver unloading.:

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |    4 +-
 .../nbl/nbl_channel/nbl_channel.c             | 1482 +++++++++++++++++
 .../nbl/nbl_channel/nbl_channel.h             |  205 +++
 .../nebula-matrix/nbl/nbl_common/nbl_common.c |  784 +++++++++
 .../nebula-matrix/nbl/nbl_common/nbl_common.h |   54 +
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |    5 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  |  259 +++
 .../nbl/nbl_include/nbl_def_channel.h         |  715 ++++++++
 .../nbl/nbl_include/nbl_def_common.h          |  187 +++
 .../nbl/nbl_include/nbl_def_hw.h              |   27 +
 .../nbl/nbl_include/nbl_include.h             |   67 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |   10 +-
 12 files changed, 3796 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index f5c1f8030beb..db04128977d5 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -4,7 +4,9 @@
 
 obj-$(CONFIG_NBL_CORE) := nbl_core.o
 
-nbl_core-objs +=      nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
+nbl_core-objs +=       nbl_common/nbl_common.o \
+				nbl_channel/nbl_channel.o \
+				nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
 				nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.o \
 				nbl_main.o
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
new file mode 100644
index 000000000000..f9c7fea7d13c
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
@@ -0,0 +1,1482 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+#include <linux/delay.h>
+#include "nbl_channel.h"
+
+static int nbl_chan_send_ack(void *priv, struct nbl_chan_ack_info *chan_ack);
+
+static void nbl_chan_delete_msg_handler(struct nbl_channel_mgt *chan_mgt,
+					u16 msg_type)
+{
+	struct nbl_chan_info *chan_info;
+	u8 chan_type;
+
+	nbl_common_free_hash_node(chan_mgt->handle_hash_tbl, &msg_type);
+
+	if (msg_type < NBL_CHAN_MSG_ADMINQ_GET_EMP_VERSION)
+		chan_type = NBL_CHAN_TYPE_MAILBOX;
+	else
+		chan_type = NBL_CHAN_TYPE_ADMINQ;
+
+	chan_info = NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt, chan_type);
+	if (chan_info && chan_info->clean_task)
+		nbl_common_flush_task(chan_info->clean_task);
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
+
+	ret = nbl_common_alloc_hash_node(chan_mgt->handle_hash_tbl, &msg_type,
+					 &handler, NULL);
+
+	return ret;
+}
+
+static int nbl_chan_init_msg_handler(struct nbl_channel_mgt *chan_mgt)
+{
+	struct nbl_common_info *common = NBL_CHAN_MGT_TO_COMMON(chan_mgt);
+	struct nbl_hash_tbl_key tbl_key;
+	int ret = 0;
+
+	NBL_HASH_TBL_KEY_INIT(&tbl_key, NBL_COMMON_TO_DEV(common), sizeof(u16),
+			      sizeof(struct nbl_chan_msg_node_data),
+			      NBL_CHAN_HANDLER_TBL_BUCKET_SIZE, false);
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
+static bool nbl_chan_is_admiq(struct nbl_chan_info *chan_info)
+{
+	return chan_info->chan_type == NBL_CHAN_TYPE_ADMINQ;
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
+	struct device *dev = NBL_COMMON_TO_DEV(common);
+	struct device *dma_dev = NBL_COMMON_TO_DMA_DEV(common);
+	struct nbl_chan_ring *txq = &chan_info->txq;
+	size_t size =
+		chan_info->num_txq_entries * sizeof(struct nbl_chan_tx_desc);
+
+	txq->desc = dmam_alloc_coherent(dma_dev, size, &txq->dma,
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
+	devm_kfree(dev, chan_info->wait);
+req_wait_queue_failed:
+	dmam_free_coherent(dma_dev, size, txq->desc, txq->dma);
+
+	txq->desc = NULL;
+	txq->dma = 0;
+	chan_info->wait = NULL;
+	return -ENOMEM;
+}
+
+static int nbl_chan_init_rx_queue(struct nbl_common_info *common,
+				  struct nbl_chan_info *chan_info)
+{
+	struct device *dev = NBL_COMMON_TO_DEV(common);
+	struct device *dma_dev = NBL_COMMON_TO_DMA_DEV(common);
+	struct nbl_chan_ring *rxq = &chan_info->rxq;
+	size_t size =
+		chan_info->num_rxq_entries * sizeof(struct nbl_chan_rx_desc);
+
+	rxq->desc = dmam_alloc_coherent(dma_dev, size, &rxq->dma,
+					GFP_KERNEL | __GFP_ZERO);
+	if (!rxq->desc) {
+		dev_err(dev,
+			"Allocate DMA for chan rx descriptor ring failed\n");
+		return -ENOMEM;
+	}
+
+	rxq->buf = devm_kcalloc(dev, chan_info->num_rxq_entries,
+				sizeof(struct nbl_chan_buf), GFP_KERNEL);
+	if (!rxq->buf) {
+		dmam_free_coherent(dma_dev, size, rxq->desc, rxq->dma);
+		rxq->desc = NULL;
+		rxq->dma = 0;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void nbl_chan_remove_tx_queue(struct nbl_common_info *common,
+				     struct nbl_chan_info *chan_info)
+{
+	struct device *dev = NBL_COMMON_TO_DEV(common);
+	struct device *dma_dev = NBL_COMMON_TO_DMA_DEV(common);
+	struct nbl_chan_ring *txq = &chan_info->txq;
+	size_t size =
+		chan_info->num_txq_entries * sizeof(struct nbl_chan_tx_desc);
+
+	devm_kfree(dev, txq->buf);
+	txq->buf = NULL;
+
+	devm_kfree(dev, chan_info->wait);
+	chan_info->wait = NULL;
+
+	dmam_free_coherent(dma_dev, size, txq->desc, txq->dma);
+	txq->desc = NULL;
+	txq->dma = 0;
+}
+
+static void nbl_chan_remove_rx_queue(struct nbl_common_info *common,
+				     struct nbl_chan_info *chan_info)
+{
+	struct device *dev = NBL_COMMON_TO_DEV(common);
+	struct device *dma_dev = NBL_COMMON_TO_DMA_DEV(common);
+	struct nbl_chan_ring *rxq = &chan_info->rxq;
+	size_t size =
+		chan_info->num_rxq_entries * sizeof(struct nbl_chan_rx_desc);
+
+	devm_kfree(dev, rxq->buf);
+	rxq->buf = NULL;
+
+	dmam_free_coherent(dma_dev, size, rxq->desc, rxq->dma);
+	rxq->desc = NULL;
+	rxq->dma = 0;
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
+	nbl_chan_remove_tx_queue(common, chan_info);
+	return err;
+}
+
+static void nbl_chan_config_queue(struct nbl_channel_mgt *chan_mgt,
+				  struct nbl_chan_info *chan_info, bool tx)
+{
+	struct nbl_hw_ops *hw_ops;
+	struct nbl_chan_ring *ring;
+	dma_addr_t dma_addr;
+	void *p = NBL_CHAN_MGT_TO_HW_PRIV(chan_mgt);
+	int size_bwid = ilog2(chan_info->num_rxq_entries);
+
+	hw_ops = NBL_CHAN_MGT_TO_HW_OPS(chan_mgt);
+
+	if (tx)
+		ring = &chan_info->txq;
+	else
+		ring = &chan_info->rxq;
+
+	dma_addr = ring->dma;
+
+	if (nbl_chan_is_admiq(chan_info)) {
+		if (tx)
+			hw_ops->config_adminq_txq(p, dma_addr, size_bwid);
+		else
+			hw_ops->config_adminq_rxq(p, dma_addr, size_bwid);
+	} else {
+		if (tx)
+			hw_ops->config_mailbox_txq(p, dma_addr, size_bwid);
+		else
+			hw_ops->config_mailbox_rxq(p, dma_addr, size_bwid);
+	}
+}
+
+static int nbl_chan_alloc_all_tx_bufs(struct nbl_channel_mgt *chan_mgt,
+				      struct nbl_chan_info *chan_info)
+{
+	struct device *dma_dev = NBL_COMMON_TO_DMA_DEV(chan_mgt->common);
+	struct device *dev = NBL_COMMON_TO_DEV(chan_mgt->common);
+	struct nbl_chan_ring *txq = &chan_info->txq;
+	struct nbl_chan_buf *buf;
+	u16 i;
+
+	for (i = 0; i < chan_info->num_txq_entries; i++) {
+		buf = &txq->buf[i];
+		buf->va = dmam_alloc_coherent(dma_dev, chan_info->txq_buf_size,
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
+	while (i--) {
+		buf = &txq->buf[i];
+		dmam_free_coherent(dma_dev, chan_info->txq_buf_size, buf->va,
+				   buf->pa);
+		buf->va = NULL;
+		buf->pa = 0;
+	}
+
+	return -ENOMEM;
+}
+
+static int
+nbl_chan_cfg_mailbox_qinfo_map_table(struct nbl_channel_mgt *chan_mgt)
+{
+	struct nbl_common_info *common = NBL_CHAN_MGT_TO_COMMON(chan_mgt);
+	struct nbl_hw_ops *hw_ops = NBL_CHAN_MGT_TO_HW_OPS(chan_mgt);
+	void *p = NBL_CHAN_MGT_TO_HW_PRIV(chan_mgt);
+	u16 func_id;
+	u32 pf_mask;
+
+	pf_mask = hw_ops->get_host_pf_mask(p);
+	for (func_id = 0; func_id < NBL_MAX_PF; func_id++) {
+		if (!(pf_mask & (1 << func_id)))
+			hw_ops->cfg_mailbox_qinfo(p, func_id,
+						  common->hw_bus,
+						  common->devid,
+						  common->function + func_id);
+	}
+
+	return 0;
+}
+
+static int nbl_chan_cfg_adminq_qinfo_map_table(struct nbl_channel_mgt *chan_mgt)
+{
+	struct nbl_common_info *common = NBL_CHAN_MGT_TO_COMMON(chan_mgt);
+	struct nbl_hw_ops *hw_ops = NBL_CHAN_MGT_TO_HW_OPS(chan_mgt);
+
+	hw_ops->cfg_adminq_qinfo(NBL_CHAN_MGT_TO_HW_PRIV(chan_mgt),
+				 common->hw_bus, common->devid,
+				 NBL_COMMON_TO_PCI_FUNC_ID(common));
+
+	return 0;
+}
+
+static int nbl_chan_cfg_qinfo_map_table(void *priv, u8 chan_type)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+	struct nbl_chan_info *chan_info =
+		NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt, chan_type);
+	int err;
+
+	if (!nbl_chan_is_admiq(chan_info))
+		err = nbl_chan_cfg_mailbox_qinfo_map_table(chan_mgt);
+	else
+		err = nbl_chan_cfg_adminq_qinfo_map_table(chan_mgt);
+
+	return err;
+}
+
+static void nbl_chan_free_all_tx_bufs(struct nbl_channel_mgt *chan_mgt,
+				      struct nbl_chan_info *chan_info)
+{
+	struct device *dma_dev = NBL_COMMON_TO_DMA_DEV(chan_mgt->common);
+	struct nbl_chan_ring *txq = &chan_info->txq;
+	struct nbl_chan_buf *buf;
+	u16 i;
+
+	for (i = 0; i < chan_info->num_txq_entries; i++) {
+		buf = &txq->buf[i];
+		dmam_free_coherent(dma_dev, chan_info->txq_buf_size, buf->va,
+				   buf->pa);
+		buf->va = NULL;
+		buf->pa = 0;
+	}
+}
+
+#define NBL_UPDATE_QUEUE_TAIL_PTR(chan_info, hw_ops, chan_mgt, tail_ptr, qid)\
+do {									\
+	typeof(hw_ops) _hw_ops = (hw_ops);				\
+	typeof(chan_mgt) _chan_mgt = (chan_mgt);			\
+	typeof(tail_ptr) _tail_ptr = (tail_ptr);			\
+	typeof(qid) _qid = (qid);					\
+	if (nbl_chan_is_admiq(chan_info))				\
+		(_hw_ops)->update_adminq_queue_tail_ptr(		\
+			NBL_CHAN_MGT_TO_HW_PRIV(_chan_mgt),		\
+			_tail_ptr, _qid);				\
+	else								\
+		(_hw_ops)->update_mailbox_queue_tail_ptr(		\
+			NBL_CHAN_MGT_TO_HW_PRIV(_chan_mgt),		\
+			_tail_ptr, _qid);				\
+	} while (0)
+
+static int nbl_chan_alloc_all_rx_bufs(struct nbl_channel_mgt *chan_mgt,
+				      struct nbl_chan_info *chan_info)
+{
+	struct device *dma_dev = NBL_COMMON_TO_DMA_DEV(chan_mgt->common);
+	struct device *dev = NBL_COMMON_TO_DEV(chan_mgt->common);
+	struct nbl_chan_ring *rxq = &chan_info->rxq;
+	struct nbl_chan_rx_desc *desc;
+	struct nbl_chan_buf *buf;
+	struct nbl_hw_ops *hw_ops;
+	u32 retry_times = 0;
+	u16 i;
+
+	hw_ops = NBL_CHAN_MGT_TO_HW_OPS(chan_mgt);
+
+	for (i = 0; i < chan_info->num_rxq_entries; i++) {
+		buf = &rxq->buf[i];
+		buf->va = dmam_alloc_coherent(dma_dev, chan_info->rxq_buf_size,
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
+	while (i--) {
+		buf = &rxq->buf[i];
+		dmam_free_coherent(dma_dev, chan_info->rxq_buf_size, buf->va,
+				   buf->pa);
+		buf->va = NULL;
+		buf->pa = 0;
+	}
+
+	return -ENOMEM;
+}
+
+static void nbl_chan_free_all_rx_bufs(struct nbl_channel_mgt *chan_mgt,
+				      struct nbl_chan_info *chan_info)
+{
+	struct device *dma_dev = NBL_COMMON_TO_DMA_DEV(chan_mgt->common);
+	struct nbl_chan_ring *rxq = &chan_info->rxq;
+	struct nbl_chan_buf *buf;
+	u16 i;
+
+	for (i = 0; i < chan_info->num_rxq_entries; i++) {
+		buf = &rxq->buf[i];
+		dmam_free_coherent(dma_dev, chan_info->rxq_buf_size, buf->va,
+				   buf->pa);
+		buf->va = NULL;
+		buf->pa = 0;
+	}
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
+
+	err = nbl_chan_alloc_all_rx_bufs(chan_mgt, chan_info);
+	if (err)
+		goto alloc_rx_bufs_err;
+
+	return 0;
+
+alloc_rx_bufs_err:
+	nbl_chan_free_all_tx_bufs(chan_mgt, chan_info);
+	return err;
+}
+
+static void nbl_chan_stop_queue(struct nbl_channel_mgt *chan_mgt,
+				struct nbl_chan_info *chan_info)
+{
+	struct nbl_hw_ops *hw_ops;
+
+	hw_ops = NBL_CHAN_MGT_TO_HW_OPS(chan_mgt);
+
+	if (nbl_chan_is_admiq(chan_info)) {
+		hw_ops->stop_adminq_rxq(NBL_CHAN_MGT_TO_HW_PRIV(chan_mgt));
+		hw_ops->stop_adminq_txq(NBL_CHAN_MGT_TO_HW_PRIV(chan_mgt));
+	} else {
+		hw_ops->stop_mailbox_rxq(NBL_CHAN_MGT_TO_HW_PRIV(chan_mgt));
+		hw_ops->stop_mailbox_txq(NBL_CHAN_MGT_TO_HW_PRIV(chan_mgt));
+	}
+}
+
+static void nbl_chan_free_all_bufs(struct nbl_channel_mgt *chan_mgt,
+				   struct nbl_chan_info *chan_info)
+{
+	nbl_chan_free_all_tx_bufs(chan_mgt, chan_info);
+	nbl_chan_free_all_rx_bufs(chan_mgt, chan_info);
+}
+
+static void nbl_chan_remove_queue(struct nbl_common_info *common,
+				  struct nbl_chan_info *chan_info)
+{
+	nbl_chan_remove_tx_queue(common, chan_info);
+	nbl_chan_remove_rx_queue(common, chan_info);
+}
+
+static int nbl_chan_teardown_queue(void *priv, u8 chan_type)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+	struct nbl_chan_info *chan_info =
+		NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt, chan_type);
+	struct nbl_common_info *common = chan_mgt->common;
+
+	nbl_chan_stop_queue(chan_mgt, chan_info);
+
+	nbl_chan_free_all_bufs(chan_mgt, chan_info);
+
+	nbl_chan_remove_queue(common, chan_info);
+
+	return 0;
+}
+
+static int nbl_chan_setup_queue(void *priv, u8 chan_type)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+	struct nbl_chan_info *chan_info =
+		NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt, chan_type);
+	struct nbl_common_info *common = NBL_CHAN_MGT_TO_COMMON(chan_mgt);
+	int err;
+
+	nbl_chan_init_queue_param(chan_info, NBL_CHAN_QUEUE_LEN,
+				  NBL_CHAN_QUEUE_LEN, NBL_CHAN_BUF_LEN,
+				  NBL_CHAN_BUF_LEN);
+
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
+static void nbl_chan_shutdown_queue(struct nbl_channel_mgt *chan_mgt,
+				    u8 chan_type, bool tx)
+{
+	struct nbl_chan_info *chan_info =
+		NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt, chan_type);
+	struct nbl_common_info *common = NBL_CHAN_MGT_TO_COMMON(chan_mgt);
+	void *p = NBL_CHAN_MGT_TO_HW_PRIV(chan_mgt);
+	struct nbl_hw_ops *hw_ops;
+
+	hw_ops = NBL_CHAN_MGT_TO_HW_OPS(chan_mgt);
+
+	if (tx) {
+		if (nbl_chan_is_admiq(chan_info))
+			hw_ops->stop_adminq_txq(p);
+		else
+			hw_ops->stop_mailbox_txq(p);
+
+		nbl_chan_free_all_tx_bufs(chan_mgt, chan_info);
+		nbl_chan_remove_tx_queue(common, chan_info);
+	} else {
+		if (nbl_chan_is_admiq(chan_info))
+			hw_ops->stop_adminq_rxq(p);
+		else
+			hw_ops->stop_mailbox_rxq(p);
+
+		nbl_chan_free_all_rx_bufs(chan_mgt, chan_info);
+		nbl_chan_remove_rx_queue(common, chan_info);
+	}
+}
+
+static int nbl_chan_start_txq(struct nbl_channel_mgt *chan_mgt, u8 chan_type)
+{
+	struct nbl_chan_info *chan_info =
+		NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt, chan_type);
+	struct nbl_common_info *common = NBL_CHAN_MGT_TO_COMMON(chan_mgt);
+	int ret;
+
+	ret = nbl_chan_init_tx_queue(common, chan_info);
+	if (ret)
+		return ret;
+
+	nbl_chan_config_queue(chan_mgt, chan_info, true); /* tx */
+
+	ret = nbl_chan_alloc_all_tx_bufs(chan_mgt, chan_info);
+	if (ret)
+		goto alloc_buf_failed;
+
+	return 0;
+
+alloc_buf_failed:
+	nbl_chan_shutdown_queue(chan_mgt, chan_type, true);
+	return ret;
+}
+
+static int nbl_chan_start_rxq(struct nbl_channel_mgt *chan_mgt, u8 chan_type)
+{
+	struct nbl_chan_info *chan_info =
+		NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt, chan_type);
+	struct nbl_common_info *common = NBL_CHAN_MGT_TO_COMMON(chan_mgt);
+	int ret;
+
+	ret = nbl_chan_init_rx_queue(common, chan_info);
+	if (ret)
+		return ret;
+
+	nbl_chan_config_queue(chan_mgt, chan_info, false); /* rx */
+
+	ret = nbl_chan_alloc_all_rx_bufs(chan_mgt, chan_info);
+	if (ret)
+		goto alloc_buf_failed;
+
+	return 0;
+
+alloc_buf_failed:
+	nbl_chan_shutdown_queue(chan_mgt, chan_type, false);
+	return ret;
+}
+
+static int nbl_chan_reset_queue(struct nbl_channel_mgt *chan_mgt, u8 chan_type,
+				bool tx)
+{
+	struct nbl_chan_info *chan_info =
+		NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt, chan_type);
+	int i = 0, j = 0, ret = 0;
+
+	/* If someone else is doing resetting, don't bother */
+	if (test_bit(NBL_CHAN_RESETTING, chan_info->state))
+		return 0;
+
+	/* Make sure rx won't enter if we are resetting */
+	set_bit(NBL_CHAN_RESETTING, chan_info->state);
+	if (chan_info->clean_task)
+		nbl_common_flush_task(chan_info->clean_task);
+
+	/* Make sure tx won't enter if we are resetting */
+	spin_lock(&chan_info->txq_lock);
+
+	/* If we are in a race, and someone else has finished it, just return */
+	if (!test_bit(NBL_CHAN_RESETTING, chan_info->state)) {
+		spin_unlock(&chan_info->txq_lock);
+		return 0;
+	}
+
+	/* Make sure no one is waiting before we reset. */
+	while (i++ < (NBL_CHAN_ACK_WAIT_TIME * 2) / HZ) {
+		for (j = 0; j < NBL_CHAN_QUEUE_LEN; j++)
+			if (chan_info->wait[j].status == NBL_MBX_STATUS_WAITING)
+				break;
+
+		if (j == NBL_CHAN_QUEUE_LEN)
+			break;
+		mdelay(1000);
+	}
+
+	if (j != NBL_CHAN_QUEUE_LEN) {
+		nbl_warn(NBL_CHAN_MGT_TO_COMMON(chan_mgt),
+			 "Some wait_head unreleased, fail to reset");
+		clear_bit(NBL_CHAN_RESETTING, chan_info->state);
+		spin_unlock(&chan_info->txq_lock);
+		return 0;
+	}
+
+	nbl_chan_shutdown_queue(chan_mgt, chan_type, tx);
+
+	if (tx)
+		ret = nbl_chan_start_txq(chan_mgt, chan_type);
+	else
+		ret = nbl_chan_start_rxq(chan_mgt, chan_type);
+
+	/* Make sure we clear this bit inside lock, so that we don't reset it
+	 * twice if race
+	 */
+	clear_bit(NBL_CHAN_RESETTING, chan_info->state);
+	spin_unlock(&chan_info->txq_lock);
+
+	return ret;
+}
+
+static bool nbl_chan_check_dma_err(struct nbl_channel_mgt *chan_mgt,
+				   u8 chan_type, bool tx)
+{
+	struct nbl_hw_ops *hw_ops = NBL_CHAN_MGT_TO_HW_OPS(chan_mgt);
+	void *p = NBL_CHAN_MGT_TO_HW_PRIV(chan_mgt);
+
+	if (hw_ops->get_hw_status(p))
+		return false;
+
+	if (chan_type == NBL_CHAN_TYPE_MAILBOX)
+		return hw_ops->check_mailbox_dma_err(p, tx);
+	else
+		return hw_ops->check_adminq_dma_err(p, tx);
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
+	struct nbl_hw_ops *hw_ops = NBL_CHAN_MGT_TO_HW_OPS(chan_mgt);
+	struct nbl_common_info *common = NBL_CHAN_MGT_TO_COMMON(chan_mgt);
+	struct nbl_chan_ring *txq = &chan_info->txq;
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
+			nbl_err(common, "chan send message type: %d timeout\n",
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
+	struct nbl_common_info *common = NBL_CHAN_MGT_TO_COMMON(chan_mgt);
+	struct nbl_chan_info *chan_info = NULL;
+	struct nbl_chan_waitqueue_head *wait_head = NULL;
+	union nbl_chan_msg_id ack_msgid = { { 0 } };
+	u32 *payload = (u32 *)data;
+	u32 ack_datalen = 0, ack_msgtype = 0, copy_len = 0;
+
+	if (srcid == NBL_CHAN_ADMINQ_FUNCTION_ID)
+		chan_info = NBL_CHAN_MGT_TO_ADMINQ(chan_mgt);
+	else
+		chan_info = NBL_CHAN_MGT_TO_MBX(chan_mgt);
+
+	ack_datalen = data_len - 3 * sizeof(u32);
+	ack_msgtype = *payload;
+	ack_msgid.id = *(u16 *)(payload + 1);
+	wait_head = &chan_info->wait[ack_msgid.info.loc];
+	wait_head->ack_err = *(payload + 2);
+	chan_info->failed_cnt = 0;
+
+	if (wait_head->msg_type != ack_msgtype) {
+		nbl_warn(common,
+			 "Skip ack msg type %d donot match msg type %d\n",
+			 ack_msgtype, wait_head->msg_type);
+		return;
+	}
+
+	if (wait_head->status != NBL_MBX_STATUS_WAITING) {
+		nbl_warn(common, "Skip ack with status %d", wait_head->status);
+		return;
+	}
+
+	if (wait_head->msg_index != ack_msgid.info.index) {
+		nbl_warn(common, "Skip ack index %d donot match index %d",
+			 ack_msgid.info.index, wait_head->msg_index);
+		return;
+	}
+
+	if (ack_datalen != wait_head->ack_data_len)
+		nbl_debug(common,
+			  "Channel payload_len donot match ack_data_len, msgtype:%u, msgid:%u, rcv_data_len:%u, expect_data_len:%u\n",
+			   ack_msgtype, ack_msgid.id, ack_datalen,
+			   wait_head->ack_data_len);
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
+	struct device *dev = NBL_COMMON_TO_DEV(chan_mgt->common);
+	struct nbl_chan_ack_info chan_ack;
+	struct nbl_chan_tx_desc *tx_desc;
+	struct nbl_chan_msg_node_data *msg_handler;
+	u16 msg_type, payload_len, srcid, msgid;
+	void *payload;
+
+	tx_desc = data;
+	msg_type = tx_desc->msg_type;
+	dev_dbg(dev, "recv msg_type: %d\n", tx_desc->msg_type);
+
+	srcid = tx_desc->srcid;
+	msgid = tx_desc->msgid;
+	if (msg_type >= NBL_CHAN_MSG_MAX)
+		goto send_warning;
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
+
+send_warning:
+	NBL_CHAN_ACK(chan_ack, srcid, msg_type, msgid, -EPERM, NULL, 0);
+	nbl_chan_send_ack(chan_mgt, &chan_ack);
+	dev_warn(dev, "Recv channel msg_type: %d, but msg_handler is null!\n",
+		 msg_type);
+}
+
+static void nbl_chan_advance_rx_ring(struct nbl_channel_mgt *chan_mgt,
+				     struct nbl_chan_info *chan_info,
+				     struct nbl_chan_ring *rxq)
+{
+	struct nbl_chan_rx_desc *rx_desc;
+	struct nbl_hw_ops *hw_ops;
+	struct nbl_chan_buf *rx_buf;
+	u16 next_to_use;
+
+	hw_ops = NBL_CHAN_MGT_TO_HW_OPS(chan_mgt);
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
+	struct nbl_common_info *common = NBL_CHAN_MGT_TO_COMMON(chan_mgt);
+	struct nbl_chan_ring *rxq = &chan_info->rxq;
+	struct nbl_chan_rx_desc *rx_desc;
+	struct nbl_chan_buf *rx_buf;
+	u16 next_to_clean;
+
+	next_to_clean = rxq->next_to_clean;
+	rx_desc = NBL_CHAN_RX_RING_TO_DESC(rxq, next_to_clean);
+	rx_buf = NBL_CHAN_RX_RING_TO_BUF(rxq, next_to_clean);
+	while (rx_desc->flags & NBL_CHAN_RX_DESC_USED) {
+		if (!(rx_desc->flags & NBL_CHAN_RX_DESC_WRITE))
+			nbl_debug(common,
+				  "mailbox rx flag 0x%x has no NBL_CHAN_RX_DESC_WRITE\n",
+				  rx_desc->flags);
+
+		dma_rmb();
+		nbl_chan_recv_msg(chan_mgt, rx_buf->va, rx_desc->buf_len);
+
+		nbl_chan_advance_rx_ring(chan_mgt, chan_info, rxq);
+
+		next_to_clean++;
+		if (next_to_clean == chan_info->num_rxq_entries)
+			next_to_clean = 0;
+		rx_desc = NBL_CHAN_RX_RING_TO_DESC(rxq, next_to_clean);
+		rx_buf = NBL_CHAN_RX_RING_TO_BUF(rxq, next_to_clean);
+	}
+	rxq->next_to_clean = next_to_clean;
+}
+
+static void nbl_chan_clean_queue_subtask(void *priv, u8 chan_type)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
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
+static int nbl_chan_send_msg(void *priv, struct nbl_chan_send_info *chan_send)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+	struct nbl_common_info *common = NBL_CHAN_MGT_TO_COMMON(chan_mgt);
+	struct nbl_chan_info *chan_info =
+		NBL_CHAN_GET_INFO(chan_mgt, chan_send->dstid);
+	struct nbl_chan_waitqueue_head *wait_head;
+	union nbl_chan_msg_id msgid = { { 0 } };
+	struct nbl_chan_tx_param tx_param = { 0 };
+	int i = NBL_CHAN_TX_WAIT_ACK_TIMES, resend_times = 0, ret = 0;
+	bool need_resend = true; /* neend resend when ack timeout*/
+
+	if (chan_send->arg_len >
+	    NBL_CHAN_BUF_LEN - sizeof(struct nbl_chan_tx_desc))
+		return -EINVAL;
+
+	if (test_bit(NBL_CHAN_ABNORMAL, chan_info->state))
+		return -EFAULT;
+
+	if (chan_info->failed_cnt >= NBL_CHANNEL_FREEZE_FAILED_CNT)
+		return -EFAULT;
+
+resend:
+	spin_lock(&chan_info->txq_lock);
+
+	ret = nbl_chan_get_msg_id(chan_info, &msgid);
+	if (ret) {
+		spin_unlock(&chan_info->txq_lock);
+		nbl_err(common,
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
+		nbl_err(common,
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
+	if (ret) {
+		wait_head->status = NBL_MBX_STATUS_TIMEOUT;
+		goto check_tx_dma_err;
+	}
+
+	if (!chan_send->ack)
+		return 0;
+
+	if (chan_send->dstid != common->mgt_pf &&
+	    chan_send->msg_type != NBL_CHAN_MSG_KEEP_ALIVE)
+		need_resend = false;
+
+	if (test_bit(NBL_CHAN_INTERRUPT_READY, chan_info->state)) {
+		ret = wait_event_timeout(wait_head->wait_queue,
+					 wait_head->acked,
+					 NBL_CHAN_ACK_WAIT_TIME);
+		if (!ret) {
+			wait_head->status = NBL_MBX_STATUS_TIMEOUT;
+			if (!need_resend) {
+				chan_info->failed_cnt++;
+				return 0;
+			}
+			nbl_err(common,
+				"Channel waiting ack failed, message type: %d, msg id: %u\n",
+				chan_send->msg_type, msgid.id);
+			goto check_rx_dma_err;
+		}
+
+		/* rmb for waithead ack */
+		rmb();
+		chan_send->ack_len = wait_head->ack_data_len;
+		wait_head->status = NBL_MBX_STATUS_IDLE;
+		chan_info->failed_cnt = 0;
+
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
+			chan_info->failed_cnt = 0;
+			return wait_head->ack_err;
+		}
+		usleep_range(NBL_CHAN_TX_WAIT_ACK_US_MIN,
+			     NBL_CHAN_TX_WAIT_ACK_US_MAX);
+	}
+
+	wait_head->status = NBL_MBX_STATUS_TIMEOUT;
+	nbl_err(common,
+		"Channel polling ack failed, message type: %d msg id: %u\n",
+		chan_send->msg_type, msgid.id);
+
+check_rx_dma_err:
+	if (nbl_chan_check_dma_err(chan_mgt, chan_info->chan_type, false)) {
+		nbl_err(common, "nbl channel rx dma error\n");
+		nbl_chan_reset_queue(chan_mgt, chan_info->chan_type, false);
+		chan_info->rxq_reset_times++;
+	}
+
+check_tx_dma_err:
+	if (nbl_chan_check_dma_err(chan_mgt, chan_info->chan_type, true)) {
+		nbl_err(common, "nbl channel tx dma error\n");
+		nbl_chan_reset_queue(chan_mgt, chan_info->chan_type, true);
+		chan_info->txq_reset_times++;
+	}
+
+	if (++resend_times >= NBL_CHAN_RESEND_MAX_TIMES) {
+		nbl_err(common, "nbl channel resend_times %d\n", resend_times);
+		chan_info->failed_cnt++;
+
+		return -EFAULT;
+	}
+
+	i = NBL_CHAN_TX_WAIT_ACK_TIMES;
+	goto resend;
+}
+
+static int nbl_chan_send_ack(void *priv, struct nbl_chan_ack_info *chan_ack)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
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
+static void nbl_chan_unregister_msg(void *priv, u16 msg_type)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+
+	nbl_chan_delete_msg_handler(chan_mgt, msg_type);
+}
+
+static int nbl_chan_register_msg(void *priv, u16 msg_type, nbl_chan_resp func,
+				 void *callback_priv)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+	int ret;
+
+	ret = nbl_chan_add_msg_handler(chan_mgt, msg_type, func, callback_priv);
+
+	return ret;
+}
+
+static bool nbl_chan_check_queue_exist(void *priv, u8 chan_type)
+{
+	struct nbl_channel_mgt *chan_mgt;
+	struct nbl_chan_info *chan_info;
+
+	if (!priv)
+		return false;
+
+	chan_mgt = (struct nbl_channel_mgt *)priv;
+	chan_info = NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt, chan_type);
+
+	return chan_info ? true : false;
+}
+
+static void nbl_chan_keepalive_resp(void *priv, u16 srcid, u16 msgid,
+				    void *data, u32 data_len)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+	struct nbl_chan_ack_info chan_ack;
+
+	NBL_CHAN_ACK(chan_ack, srcid, NBL_CHAN_MSG_KEEP_ALIVE, msgid, 0, NULL,
+		     0);
+
+	nbl_chan_send_ack(chan_mgt, &chan_ack);
+}
+
+static void nbl_chan_keepalive(struct delayed_work *work)
+{
+	struct nbl_chan_keepalive_info *keepalive =
+		container_of(work, struct nbl_chan_keepalive_info,
+			     keepalive_task);
+	struct nbl_channel_mgt *chan_mgt =
+		(struct nbl_channel_mgt *)keepalive->chan_mgt;
+	struct nbl_chan_send_info chan_send;
+	u32 delay_time;
+
+	NBL_CHAN_SEND(chan_send, keepalive->keepalive_dest,
+		      NBL_CHAN_MSG_KEEP_ALIVE, NULL, 0, NULL, 0, 1);
+
+	if (nbl_chan_send_msg(chan_mgt, &chan_send)) {
+		if (keepalive->fail_cnt <
+		    NBL_CHAN_KEEPALIVE_TIMEOUT_UPDATE_THRESH)
+			keepalive->fail_cnt++;
+
+		if (keepalive->fail_cnt >=
+			    NBL_CHAN_KEEPALIVE_TIMEOUT_UPDATE_THRESH &&
+		    keepalive->timeout < NBL_CHAN_KEEPALIVE_MAX_TIMEOUT) {
+			get_random_bytes(&delay_time, sizeof(delay_time));
+			keepalive->timeout +=
+				delay_time %
+				NBL_CHAN_KEEPALIVE_TIMEOUT_UPDATE_GAP;
+
+			keepalive->fail_cnt = 0;
+		}
+	} else {
+		if (keepalive->success_cnt <
+		    NBL_CHAN_KEEPALIVE_TIMEOUT_UPDATE_THRESH)
+			keepalive->success_cnt++;
+
+		if (keepalive->success_cnt >=
+			    NBL_CHAN_KEEPALIVE_TIMEOUT_UPDATE_THRESH &&
+		    keepalive->timeout >
+			    NBL_CHAN_KEEPALIVE_DEFAULT_TIMEOUT * 2) {
+			get_random_bytes(&delay_time, sizeof(delay_time));
+			keepalive->timeout -=
+				delay_time %
+				NBL_CHAN_KEEPALIVE_TIMEOUT_UPDATE_GAP;
+
+			keepalive->success_cnt = 0;
+		}
+	}
+
+	nbl_common_q_dwork_keepalive(work,
+				     jiffies_to_msecs(keepalive->timeout));
+}
+
+static int nbl_chan_setup_keepalive(void *priv, u16 dest_id, u8 chan_type)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+	struct nbl_chan_info *chan_info =
+		NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt, chan_type);
+	struct nbl_chan_keepalive_info *keepalive = &chan_info->keepalive;
+	u32 delay_time;
+
+	get_random_bytes(&delay_time, sizeof(delay_time));
+	delay_time = delay_time % NBL_CHAN_KEEPALIVE_TIMEOUT_UPDATE_GAP;
+
+	keepalive->timeout = NBL_CHAN_KEEPALIVE_DEFAULT_TIMEOUT + delay_time;
+	keepalive->chan_mgt = chan_mgt;
+	keepalive->keepalive_dest = dest_id;
+	keepalive->success_cnt = 0;
+	keepalive->fail_cnt = 0;
+
+	nbl_chan_add_msg_handler(chan_mgt, NBL_CHAN_MSG_KEEP_ALIVE,
+				 nbl_chan_keepalive_resp, chan_mgt);
+
+	nbl_common_alloc_delayed_task(&keepalive->keepalive_task,
+				      nbl_chan_keepalive);
+	keepalive->task_setuped = true;
+
+	nbl_common_q_dwork_keepalive(&keepalive->keepalive_task,
+				     jiffies_to_msecs(keepalive->timeout));
+
+	return 0;
+}
+
+static void nbl_chan_remove_keepalive(void *priv, u8 chan_type)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+	struct nbl_chan_info *chan_info =
+		NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt, chan_type);
+
+	if (!chan_info->keepalive.task_setuped)
+		return;
+
+	nbl_common_release_delayed_task(&chan_info->keepalive.keepalive_task);
+	chan_info->keepalive.task_setuped = false;
+}
+
+static void nbl_chan_register_chan_task(void *priv, u8 chan_type,
+					struct work_struct *task)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+	struct nbl_chan_info *chan_info =
+		NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt, chan_type);
+
+	chan_info->clean_task = task;
+}
+
+static void nbl_chan_set_queue_state(void *priv, enum nbl_chan_state state,
+				     u8 chan_type, u8 set)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+	struct nbl_chan_info *chan_info =
+		NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt, chan_type);
+
+	if (set)
+		set_bit(state, chan_info->state);
+	else
+		clear_bit(state, chan_info->state);
+}
+
+static struct nbl_channel_ops chan_ops = {
+	.send_msg			= nbl_chan_send_msg,
+	.send_ack			= nbl_chan_send_ack,
+	.register_msg			= nbl_chan_register_msg,
+	.unregister_msg			= nbl_chan_unregister_msg,
+	.cfg_chan_qinfo_map_table	= nbl_chan_cfg_qinfo_map_table,
+	.check_queue_exist		= nbl_chan_check_queue_exist,
+	.setup_queue			= nbl_chan_setup_queue,
+	.teardown_queue			= nbl_chan_teardown_queue,
+	.clean_queue_subtask		= nbl_chan_clean_queue_subtask,
+
+	.setup_keepalive		= nbl_chan_setup_keepalive,
+	.remove_keepalive		= nbl_chan_remove_keepalive,
+	.register_chan_task		= nbl_chan_register_chan_task,
+	.set_queue_state		= nbl_chan_set_queue_state,
+};
+
+static int
+nbl_chan_setup_chan_mgt(struct nbl_adapter *adapter,
+			struct nbl_init_param *param,
+			struct nbl_channel_mgt_leonis **chan_mgt_leonis)
+{
+	struct nbl_common_info *common;
+	struct nbl_hw_ops_tbl *hw_ops_tbl;
+	struct nbl_chan_info *mailbox;
+	struct nbl_chan_info *adminq = NULL;
+	struct device *dev;
+	int ret;
+
+	dev = NBL_ADAP_TO_DEV(adapter);
+	common = NBL_ADAP_TO_COMMON(adapter);
+	hw_ops_tbl = NBL_ADAP_TO_HW_OPS_TBL(adapter);
+
+	*chan_mgt_leonis = devm_kzalloc(dev,
+					sizeof(struct nbl_channel_mgt_leonis),
+					GFP_KERNEL);
+	if (!*chan_mgt_leonis)
+		goto alloc_channel_mgt_leonis_fail;
+
+	NBL_CHAN_MGT_TO_COMMON(&(*chan_mgt_leonis)->chan_mgt) = common;
+	(*chan_mgt_leonis)->chan_mgt.hw_ops_tbl = hw_ops_tbl;
+
+	mailbox = devm_kzalloc(dev, sizeof(struct nbl_chan_info), GFP_KERNEL);
+	if (!mailbox)
+		goto alloc_mailbox_fail;
+	mailbox->chan_type = NBL_CHAN_TYPE_MAILBOX;
+	NBL_CHAN_MGT_TO_MBX(&(*chan_mgt_leonis)->chan_mgt) = mailbox;
+
+	if (param->caps.has_ctrl) {
+		adminq = devm_kzalloc(dev, sizeof(struct nbl_chan_info),
+				      GFP_KERNEL);
+		if (!adminq)
+			goto alloc_adminq_fail;
+		adminq->chan_type = NBL_CHAN_TYPE_ADMINQ;
+		NBL_CHAN_MGT_TO_ADMINQ(&(*chan_mgt_leonis)->chan_mgt) = adminq;
+	}
+
+	ret = nbl_chan_init_msg_handler(&(*chan_mgt_leonis)->chan_mgt);
+	if (ret)
+		goto init_chan_msg_handle;
+
+	return 0;
+
+init_chan_msg_handle:
+	if (adminq)
+		devm_kfree(dev, adminq);
+alloc_adminq_fail:
+	devm_kfree(dev, mailbox);
+alloc_mailbox_fail:
+	devm_kfree(dev, *chan_mgt_leonis);
+	*chan_mgt_leonis = NULL;
+alloc_channel_mgt_leonis_fail:
+	return -ENOMEM;
+}
+
+static void
+nbl_chan_remove_chan_mgt(struct nbl_common_info *common,
+			 struct nbl_channel_mgt_leonis **chan_mgt)
+{
+	struct device *dev = NBL_COMMON_TO_DEV(common);
+
+	nbl_chan_remove_msg_handler(&(*chan_mgt)->chan_mgt);
+	if (NBL_CHAN_MGT_TO_ADMINQ(&(*chan_mgt)->chan_mgt))
+		devm_kfree(dev,
+			   NBL_CHAN_MGT_TO_ADMINQ(&(*chan_mgt)->chan_mgt));
+	devm_kfree(dev, NBL_CHAN_MGT_TO_MBX(&(*chan_mgt)->chan_mgt));
+
+	/* check and remove command queue */
+	devm_kfree(dev, *chan_mgt);
+	*chan_mgt = NULL;
+}
+
+static void nbl_chan_remove_ops(struct device *dev,
+				struct nbl_channel_ops_tbl **chan_ops_tbl)
+{
+	if (!dev || !chan_ops_tbl)
+		return;
+
+	devm_kfree(dev, *chan_ops_tbl);
+	*chan_ops_tbl = NULL;
+}
+
+static int nbl_chan_setup_ops(struct device *dev,
+			      struct nbl_channel_ops_tbl **chan_ops_tbl,
+			      struct nbl_channel_mgt_leonis *chan_mgt)
+{
+	int ret;
+
+	*chan_ops_tbl = devm_kzalloc(dev, sizeof(struct nbl_channel_ops_tbl),
+				     GFP_KERNEL);
+	if (!*chan_ops_tbl)
+		return -ENOMEM;
+
+	NBL_CHAN_OPS_TBL_TO_OPS(*chan_ops_tbl) = &chan_ops;
+	NBL_CHAN_OPS_TBL_TO_PRIV(*chan_ops_tbl) = chan_mgt;
+
+	if (!chan_mgt)
+		return 0;
+
+	ret = nbl_chan_add_msg_handler(&chan_mgt->chan_mgt, NBL_CHAN_MSG_ACK,
+				       nbl_chan_recv_ack_msg, chan_mgt);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	devm_kfree(dev, *chan_ops_tbl);
+	*chan_ops_tbl = NULL;
+
+	return ret;
+}
+
+int nbl_chan_init_common(void *p, struct nbl_init_param *param)
+{
+	struct nbl_adapter *adap = (struct nbl_adapter *)p;
+	struct nbl_channel_mgt_leonis **chan_mgt_leonis;
+	struct nbl_channel_ops_tbl **chan_ops_tbl;
+	struct nbl_common_info *common;
+	struct device *dev;
+	int ret = 0;
+
+	dev = NBL_ADAP_TO_DEV(adap);
+	common = NBL_ADAP_TO_COMMON(adap);
+	chan_mgt_leonis =
+		(struct nbl_channel_mgt_leonis **)&NBL_ADAP_TO_CHAN_MGT(adap);
+	chan_ops_tbl = &NBL_ADAP_TO_CHAN_OPS_TBL(adap);
+
+	ret = nbl_chan_setup_chan_mgt(adap, param, chan_mgt_leonis);
+	if (ret)
+		goto setup_mgt_fail;
+
+	ret = nbl_chan_setup_ops(dev, chan_ops_tbl, *chan_mgt_leonis);
+	if (ret)
+		goto setup_ops_fail;
+
+	return 0;
+
+setup_ops_fail:
+	nbl_chan_remove_chan_mgt(common, chan_mgt_leonis);
+setup_mgt_fail:
+	return ret;
+}
+
+void nbl_chan_remove_common(void *p)
+{
+	struct nbl_adapter *adap = (struct nbl_adapter *)p;
+	struct nbl_channel_mgt_leonis **chan_mgt_leonis;
+	struct nbl_channel_ops_tbl **chan_ops_tbl;
+	struct nbl_common_info *common;
+	struct device *dev;
+
+	dev = NBL_ADAP_TO_DEV(adap);
+	common = NBL_ADAP_TO_COMMON(adap);
+	chan_mgt_leonis =
+		(struct nbl_channel_mgt_leonis **)&NBL_ADAP_TO_CHAN_MGT(adap);
+	chan_ops_tbl = &NBL_ADAP_TO_CHAN_OPS_TBL(adap);
+
+	nbl_chan_remove_chan_mgt(common, chan_mgt_leonis);
+	nbl_chan_remove_ops(dev, chan_ops_tbl);
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
new file mode 100644
index 000000000000..2d5c23b80f1d
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
@@ -0,0 +1,205 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_CHANNEL_H_
+#define _NBL_CHANNEL_H_
+
+#include "nbl_core.h"
+#define NBL_CHAN_MGT_TO_COMMON(chan_mgt) ((chan_mgt)->common)
+#define NBL_CHAN_MGT_TO_DEV(chan_mgt) \
+	NBL_COMMON_TO_DEV(NBL_CHAN_MGT_TO_COMMON(chan_mgt))
+#define NBL_CHAN_MGT_TO_HW_OPS_TBL(chan_mgt) ((chan_mgt)->hw_ops_tbl)
+#define NBL_CHAN_MGT_TO_HW_OPS(chan_mgt) \
+	(NBL_CHAN_MGT_TO_HW_OPS_TBL(chan_mgt)->ops)
+#define NBL_CHAN_MGT_TO_HW_PRIV(chan_mgt) \
+	(NBL_CHAN_MGT_TO_HW_OPS_TBL(chan_mgt)->priv)
+#define NBL_CHAN_MGT_TO_MBX(chan_mgt) \
+	((chan_mgt)->chan_info[NBL_CHAN_TYPE_MAILBOX])
+#define NBL_CHAN_MGT_TO_ADMINQ(chan_mgt) \
+	((chan_mgt)->chan_info[NBL_CHAN_TYPE_ADMINQ])
+#define NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt, chan_type) \
+	((chan_mgt)->chan_info[chan_type])
+
+#define NBL_CHAN_TX_RING_TO_DESC(tx_ring, i) \
+	(&(((struct nbl_chan_tx_desc *)((tx_ring)->desc))[i]))
+#define NBL_CHAN_RX_RING_TO_DESC(rx_ring, i) \
+	(&(((struct nbl_chan_rx_desc *)((rx_ring)->desc))[i]))
+#define NBL_CHAN_TX_RING_TO_BUF(tx_ring, i) (&(((tx_ring)->buf)[i]))
+#define NBL_CHAN_RX_RING_TO_BUF(rx_ring, i) (&(((rx_ring)->buf)[i]))
+
+#define NBL_CHAN_GET_INFO(chan_mgt, id)					\
+({									\
+		typeof(chan_mgt) _chan_mgt = (chan_mgt);		\
+		((id) == NBL_CHAN_ADMINQ_FUNCTION_ID &&			\
+				 NBL_CHAN_MGT_TO_ADMINQ(_chan_mgt) ?	\
+			 NBL_CHAN_MGT_TO_ADMINQ(_chan_mgt) :		\
+			 NBL_CHAN_MGT_TO_MBX(_chan_mgt));		\
+	})
+
+#define NBL_CHAN_TX_WAIT_US			100
+#define NBL_CHAN_TX_REKICK_WAIT_TIMES		2000
+#define NBL_CHAN_TX_WAIT_TIMES			30000
+
+#define NBL_CHAN_TX_WAIT_ACK_US_MIN		100
+#define NBL_CHAN_TX_WAIT_ACK_US_MAX		120
+#define NBL_CHAN_TX_WAIT_ACK_TIMES		50000
+
+#define NBL_CHAN_QUEUE_LEN			256
+#define NBL_CHAN_BUF_LEN			4096
+
+#define NBL_CHAN_TX_DESC_EMBEDDED_DATA_LEN	16
+#define NBL_CHAN_RESEND_MAX_TIMES		3
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
+#define NBL_CHAN_KEEPALIVE_DEFAULT_TIMEOUT			(10 * HZ)
+#define NBL_CHAN_KEEPALIVE_MAX_TIMEOUT				(1024 * HZ)
+#define NBL_CHAN_KEEPALIVE_TIMEOUT_UPDATE_GAP			(10 * HZ)
+#define NBL_CHAN_KEEPALIVE_TIMEOUT_UPDATE_THRESH		(3)
+
+struct nbl_chan_keepalive_info {
+	struct delayed_work keepalive_task;
+	void *chan_mgt;
+	u32 timeout;
+	u16 keepalive_dest;
+	u8 success_cnt;
+	u8 fail_cnt;
+	bool task_setuped;
+	u8 resv[3];
+};
+
+struct nbl_chan_info {
+	struct nbl_chan_ring txq;
+	struct nbl_chan_ring rxq;
+	struct nbl_chan_waitqueue_head *wait;
+	/* spinlock_t */
+	spinlock_t txq_lock;
+
+	struct work_struct *clean_task;
+	struct nbl_chan_keepalive_info keepalive;
+
+	u16 wait_head_index;
+	u16 num_txq_entries;
+	u16 num_rxq_entries;
+	u16 txq_buf_size;
+	u16 rxq_buf_size;
+
+	u16 txq_reset_times;
+	u16 rxq_reset_times;
+
+	DECLARE_BITMAP(state, NBL_CHAN_STATE_NBITS);
+
+	u8 chan_type;
+	/* three consecutive fails will freeze the queue */
+	u8 failed_cnt;
+};
+
+struct nbl_chan_msg_node_data {
+	nbl_chan_resp func;
+	void *priv;
+};
+
+struct nbl_channel_mgt {
+	struct nbl_common_info *common;
+	struct nbl_hw_ops_tbl *hw_ops_tbl;
+	struct nbl_chan_info *chan_info[NBL_CHAN_TYPE_MAX];
+	struct nbl_cmdq_mgt *cmdq_mgt;
+	void *handle_hash_tbl;
+};
+
+/* Mgt structure for each product.
+ * Every indivisual mgt must have the common mgt as its first member, and
+ * contains its unique data structure in the reset of it.
+ */
+struct nbl_channel_mgt_leonis {
+	struct nbl_channel_mgt chan_mgt;
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
new file mode 100644
index 000000000000..fe18a439b5d8
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
@@ -0,0 +1,784 @@
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
+	struct workqueue_struct *net_dev_wq;
+	struct workqueue_struct *keepalive_wq;
+};
+
+void nbl_convert_mac(u8 *mac, u8 *reverse_mac)
+{
+	int i;
+
+	for (i = 0; i < ETH_ALEN; i++)
+		reverse_mac[i] = mac[ETH_ALEN - 1 - i];
+}
+
+static struct nbl_common_wq_mgt *wq_mgt;
+
+void nbl_common_queue_work(struct work_struct *task, bool ctrl_task)
+{
+	if (ctrl_task)
+		queue_work(wq_mgt->ctrl_dev_wq, task);
+	else
+		queue_work(wq_mgt->net_dev_wq, task);
+}
+
+void nbl_common_q_dwork(struct delayed_work *task, u32 msec, bool ctrl_task)
+{
+	if (ctrl_task)
+		queue_delayed_work(wq_mgt->ctrl_dev_wq, task,
+				   msecs_to_jiffies(msec));
+	else
+		queue_delayed_work(wq_mgt->net_dev_wq, task,
+				   msecs_to_jiffies(msec));
+}
+
+void nbl_common_q_dwork_keepalive(struct delayed_work *task, u32 msec)
+{
+	queue_delayed_work(wq_mgt->keepalive_wq, task, msecs_to_jiffies(msec));
+}
+
+void nbl_common_release_task(struct work_struct *task)
+{
+	cancel_work_sync(task);
+}
+
+void nbl_common_alloc_task(struct work_struct *task, void *func)
+{
+	INIT_WORK(task, func);
+}
+
+void nbl_common_release_delayed_task(struct delayed_work *task)
+{
+	cancel_delayed_work_sync(task);
+}
+
+void nbl_common_alloc_delayed_task(struct delayed_work *task, void *func)
+{
+	INIT_DELAYED_WORK(task, func);
+}
+
+void nbl_common_flush_task(struct work_struct *task)
+{
+	flush_work(task);
+}
+
+void nbl_common_destroy_wq(void)
+{
+	destroy_workqueue(wq_mgt->keepalive_wq);
+	destroy_workqueue(wq_mgt->net_dev_wq);
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
+	wq_mgt->net_dev_wq = alloc_workqueue("%s", WQ_MEM_RECLAIM | WQ_UNBOUND,
+					     0, "nbl_net_dev_wq");
+	if (!wq_mgt->net_dev_wq) {
+		pr_err("Failed to create workqueue nbl_net_dev_wq\n");
+		goto alloc_net_dev_wq_failed;
+	}
+
+	wq_mgt->keepalive_wq =
+		alloc_workqueue("%s", WQ_MEM_RECLAIM | WQ_UNBOUND,
+				0, "nbl_keepalive_wq");
+	if (!wq_mgt->keepalive_wq) {
+		pr_err("Failed to create workqueue nbl_keepalive_wq\n");
+		goto alloc_keepalive_wq_failed;
+	}
+
+	return 0;
+
+alloc_keepalive_wq_failed:
+	destroy_workqueue(wq_mgt->net_dev_wq);
+alloc_net_dev_wq_failed:
+	destroy_workqueue(wq_mgt->ctrl_dev_wq);
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
+	if (pf_id >= NBL_COMMON_TO_MGT_PF(common))
+		diff = pf_id - NBL_COMMON_TO_MGT_PF(common);
+
+	return diff;
+}
+
+static u32 nbl_common_calc_hash_key(void *key, u32 key_size, u32 bucket_size)
+{
+	u32 hash_val;
+	u32 value = 0;
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
+int nbl_common_find_free_idx(unsigned long *addr, u32 size, u32 idx_num,
+			     u32 multiple)
+{
+	u32 idx_num_tmp;
+	u32 first_idx;
+	u32 next_idx;
+	u32 cur_idx;
+
+	first_idx = find_first_zero_bit(addr, size);
+	/* most find a index */
+	if (idx_num == 1)
+		return first_idx;
+
+	while (first_idx < size) {
+		if (first_idx % multiple == 0) {
+			idx_num_tmp = idx_num - 1;
+			cur_idx = first_idx;
+			while (cur_idx < size && idx_num_tmp > 0) {
+				next_idx = find_next_zero_bit(addr, size,
+							      cur_idx + 1);
+				if (next_idx - cur_idx != 1)
+					break;
+				idx_num_tmp--;
+				cur_idx = next_idx;
+			}
+
+			/* has reach tail, return err */
+			if (cur_idx >= size)
+				return size;
+
+			/* has find available idx, return the begin idx */
+			if (!idx_num_tmp)
+				return first_idx;
+
+			first_idx = first_idx + multiple;
+		} else {
+			first_idx = first_idx + 1;
+		}
+
+		first_idx = find_next_zero_bit(addr, size, first_idx);
+	}
+
+	return size;
+}
+
+/*
+ * alloc a hash table
+ * the table support multi thread
+ */
+void *nbl_common_init_hash_table(struct nbl_hash_tbl_key *key)
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
+	if (key->lock_need)
+		mutex_init(&tbl_mgt->lock);
+
+	return tbl_mgt;
+
+alloc_hash_failed:
+	devm_kfree(key->dev, tbl_mgt);
+
+	return NULL;
+}
+
+/*
+ * alloc a hash node, and add to hlist_head
+ */
+int nbl_common_alloc_hash_node(void *priv, void *key, void *data,
+			       void **out_data)
+{
+	struct nbl_hash_tbl_mgt *tbl_mgt = (struct nbl_hash_tbl_mgt *)priv;
+	struct nbl_hash_entry_node *hash_node;
+	u32 hash_val;
+	u16 key_size;
+	u16 data_size;
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
+	if (tbl_mgt->tbl_key.lock_need)
+		mutex_lock(&tbl_mgt->lock);
+
+	hlist_add_head(&hash_node->node, tbl_mgt->hash + hash_val);
+	tbl_mgt->node_num++;
+	if (out_data)
+		*out_data = hash_node->data;
+
+	if (tbl_mgt->tbl_key.lock_need)
+		mutex_unlock(&tbl_mgt->lock);
+
+	return 0;
+
+alloc_data_failed:
+	devm_kfree(tbl_mgt->tbl_key.dev, hash_node->key);
+alloc_key_failed:
+	devm_kfree(tbl_mgt->tbl_key.dev, hash_node);
+
+	return -1;
+}
+
+/*
+ * get a hash node, return the data if node exist
+ */
+void *nbl_common_get_hash_node(void *priv, void *key)
+{
+	struct nbl_hash_tbl_mgt *tbl_mgt = (struct nbl_hash_tbl_mgt *)priv;
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
+	if (tbl_mgt->tbl_key.lock_need)
+		mutex_lock(&tbl_mgt->lock);
+
+	hlist_for_each_entry(hash_node, head, node)
+		if (!memcmp(hash_node->key, key, key_size)) {
+			data = hash_node->data;
+			break;
+		}
+
+	if (tbl_mgt->tbl_key.lock_need)
+		mutex_unlock(&tbl_mgt->lock);
+
+	return data;
+}
+
+static void nbl_common_remove_hash_node(struct nbl_hash_tbl_mgt *tbl_mgt,
+					struct nbl_hash_entry_node *hash_node)
+{
+	hlist_del(&hash_node->node);
+	devm_kfree(tbl_mgt->tbl_key.dev, hash_node->key);
+	devm_kfree(tbl_mgt->tbl_key.dev, hash_node->data);
+	devm_kfree(tbl_mgt->tbl_key.dev, hash_node);
+	tbl_mgt->node_num--;
+}
+
+/*
+ * free a hash node
+ */
+void nbl_common_free_hash_node(void *priv, void *key)
+{
+	struct nbl_hash_tbl_mgt *tbl_mgt = (struct nbl_hash_tbl_mgt *)priv;
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
+	if (tbl_mgt->tbl_key.lock_need)
+		mutex_lock(&tbl_mgt->lock);
+
+	hlist_for_each_entry(hash_node, head, node)
+		if (!memcmp(hash_node->key, key, key_size))
+			break;
+
+	if (hash_node)
+		nbl_common_remove_hash_node(tbl_mgt, hash_node);
+
+	if (tbl_mgt->tbl_key.lock_need)
+		mutex_unlock(&tbl_mgt->lock);
+}
+
+void nbl_common_remove_hash_table(void *priv, struct nbl_hash_tbl_del_key *key)
+{
+	struct nbl_hash_tbl_mgt *tbl_mgt = (struct nbl_hash_tbl_mgt *)priv;
+	struct nbl_hash_entry_node *hash_node;
+	struct hlist_node *safe_node;
+	struct hlist_head *head;
+	struct device *dev;
+	u32 i;
+
+	if (!priv)
+		return;
+
+	if (tbl_mgt->tbl_key.lock_need)
+		mutex_lock(&tbl_mgt->lock);
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
+
+	devm_kfree(tbl_mgt->tbl_key.dev, tbl_mgt->hash);
+
+	if (tbl_mgt->tbl_key.lock_need)
+		mutex_unlock(&tbl_mgt->lock);
+
+	dev = tbl_mgt->tbl_key.dev;
+	devm_kfree(dev, tbl_mgt);
+}
+
+/*
+ * alloc a hash x and y axis table
+ * it support x/y axis store if necessary, so it can scan by x/y axis;
+ * the table support multi thread
+ */
+void *nbl_common_init_hash_xy_table(struct nbl_hash_xy_tbl_key *key)
+{
+	struct nbl_hash_xy_tbl_mgt *tbl_mgt;
+	int i;
+
+	tbl_mgt = devm_kzalloc(key->dev, sizeof(struct nbl_hash_xy_tbl_mgt),
+			       GFP_KERNEL);
+	if (!tbl_mgt)
+		return NULL;
+
+	tbl_mgt->hash = devm_kcalloc(key->dev, key->bucket_size,
+				     sizeof(struct hlist_head), GFP_KERNEL);
+	if (!tbl_mgt->hash)
+		goto alloc_hash_failed;
+
+	tbl_mgt->x_axis_hash = devm_kcalloc(key->dev, key->x_bucket_size,
+					    sizeof(struct hlist_head),
+					    GFP_KERNEL);
+	if (!tbl_mgt->x_axis_hash)
+		goto alloc_x_axis_hash_failed;
+
+	tbl_mgt->y_axis_hash = devm_kcalloc(key->dev, key->y_bucket_size,
+					    sizeof(struct hlist_head),
+					    GFP_KERNEL);
+	if (!tbl_mgt->y_axis_hash)
+		goto alloc_y_axis_hash_failed;
+
+	for (i = 0; i < key->bucket_size; i++)
+		INIT_HLIST_HEAD(tbl_mgt->hash + i);
+
+	for (i = 0; i < key->x_bucket_size; i++)
+		INIT_HLIST_HEAD(tbl_mgt->x_axis_hash + i);
+
+	for (i = 0; i < key->y_bucket_size; i++)
+		INIT_HLIST_HEAD(tbl_mgt->y_axis_hash + i);
+
+	memcpy(&tbl_mgt->tbl_key, key, sizeof(struct nbl_hash_xy_tbl_key));
+
+	if (key->lock_need)
+		mutex_init(&tbl_mgt->lock);
+
+	return tbl_mgt;
+
+alloc_y_axis_hash_failed:
+	devm_kfree(key->dev, tbl_mgt->x_axis_hash);
+alloc_x_axis_hash_failed:
+	devm_kfree(key->dev, tbl_mgt->hash);
+alloc_hash_failed:
+	devm_kfree(key->dev, tbl_mgt);
+
+	return NULL;
+}
+
+/*
+ * alloc a hash x and y node, and add to hlist_head
+ */
+int nbl_common_alloc_hash_xy_node(void *priv, void *x_key, void *y_key,
+				  void *data)
+{
+	struct nbl_hash_xy_tbl_mgt *tbl_mgt =
+		(struct nbl_hash_xy_tbl_mgt *)priv;
+	struct nbl_hash_entry_xy_node *hash_node;
+	void *key;
+
+	u32 hash_val, x_hash_val, y_hash_val;
+
+	u16 key_size, x_key_size, y_key_size, data_size;
+
+	hash_node = devm_kzalloc(tbl_mgt->tbl_key.dev,
+				 sizeof(struct nbl_hash_entry_xy_node),
+				 GFP_KERNEL);
+	if (!hash_node)
+		return -1;
+
+	x_key_size = tbl_mgt->tbl_key.x_key_size;
+	hash_node->x_axis_key =
+		devm_kzalloc(tbl_mgt->tbl_key.dev, x_key_size, GFP_KERNEL);
+	if (!hash_node->x_axis_key)
+		goto alloc_x_key_failed;
+
+	y_key_size = tbl_mgt->tbl_key.y_key_size;
+	hash_node->y_axis_key =
+		devm_kzalloc(tbl_mgt->tbl_key.dev, y_key_size, GFP_KERNEL);
+	if (!hash_node->y_axis_key)
+		goto alloc_y_key_failed;
+
+	key_size = x_key_size + y_key_size;
+	key = devm_kzalloc(tbl_mgt->tbl_key.dev, key_size, GFP_KERNEL);
+	if (!key)
+		goto alloc_key_failed;
+
+	data_size = tbl_mgt->tbl_key.data_size;
+	hash_node->data =
+		devm_kzalloc(tbl_mgt->tbl_key.dev, data_size, GFP_KERNEL);
+	if (!hash_node->data)
+		goto alloc_data_failed;
+
+	memcpy(key, x_key, x_key_size);
+	memcpy(key + x_key_size, y_key, y_key_size);
+	memcpy(hash_node->x_axis_key, x_key, x_key_size);
+	memcpy(hash_node->y_axis_key, y_key, y_key_size);
+	memcpy(hash_node->data, data, data_size);
+
+	hash_val = nbl_common_calc_hash_key(key, key_size,
+					    tbl_mgt->tbl_key.bucket_size);
+	x_hash_val = nbl_common_calc_hash_key(x_key, x_key_size,
+					      tbl_mgt->tbl_key.x_bucket_size);
+	y_hash_val = nbl_common_calc_hash_key(y_key, y_key_size,
+					      tbl_mgt->tbl_key.y_bucket_size);
+
+	devm_kfree(tbl_mgt->tbl_key.dev, key);
+
+	if (tbl_mgt->tbl_key.lock_need)
+		mutex_lock(&tbl_mgt->lock);
+
+	hlist_add_head(&hash_node->node, tbl_mgt->hash + hash_val);
+	hlist_add_head(&hash_node->x_axis_node,
+		       tbl_mgt->x_axis_hash + x_hash_val);
+	hlist_add_head(&hash_node->y_axis_node,
+		       tbl_mgt->y_axis_hash + y_hash_val);
+
+	tbl_mgt->node_num++;
+
+	if (tbl_mgt->tbl_key.lock_need)
+		mutex_unlock(&tbl_mgt->lock);
+
+	return 0;
+
+alloc_data_failed:
+	devm_kfree(tbl_mgt->tbl_key.dev, key);
+alloc_key_failed:
+	devm_kfree(tbl_mgt->tbl_key.dev, hash_node->y_axis_key);
+alloc_y_key_failed:
+	devm_kfree(tbl_mgt->tbl_key.dev, hash_node->x_axis_key);
+alloc_x_key_failed:
+	devm_kfree(tbl_mgt->tbl_key.dev, hash_node);
+
+	return -1;
+}
+
+/*
+ * get a hash node, return the data if node exist
+ */
+void *nbl_common_get_hash_xy_node(void *priv, void *x_key, void *y_key)
+{
+	struct nbl_hash_xy_tbl_mgt *tbl_mgt =
+		(struct nbl_hash_xy_tbl_mgt *)priv;
+	struct nbl_hash_entry_xy_node *hash_node;
+	struct hlist_head *head;
+	void *data = NULL;
+	void *key;
+	u32 hash_val;
+	u16 key_size, x_key_size, y_key_size;
+
+	x_key_size = tbl_mgt->tbl_key.x_key_size;
+	y_key_size = tbl_mgt->tbl_key.y_key_size;
+	key_size = x_key_size + y_key_size;
+	key = devm_kzalloc(tbl_mgt->tbl_key.dev, key_size, GFP_KERNEL);
+	if (!key)
+		return NULL;
+
+	memcpy(key, x_key, x_key_size);
+	memcpy(key + x_key_size, y_key, y_key_size);
+	hash_val = nbl_common_calc_hash_key(key, key_size,
+					    tbl_mgt->tbl_key.bucket_size);
+	head = tbl_mgt->hash + hash_val;
+
+	if (tbl_mgt->tbl_key.lock_need)
+		mutex_lock(&tbl_mgt->lock);
+
+	hlist_for_each_entry(hash_node, head, node)
+		if (!memcmp(hash_node->x_axis_key, x_key, x_key_size) &&
+		    !memcmp(hash_node->y_axis_key, y_key, y_key_size)) {
+			data = hash_node->data;
+			break;
+		}
+
+	if (tbl_mgt->tbl_key.lock_need)
+		mutex_unlock(&tbl_mgt->lock);
+
+	devm_kfree(tbl_mgt->tbl_key.dev, key);
+
+	return data;
+}
+
+static void
+nbl_common_remove_hash_xy_node(struct nbl_hash_xy_tbl_mgt *tbl_mgt,
+			       struct nbl_hash_entry_xy_node *hash_node)
+{
+	hlist_del(&hash_node->node);
+	hlist_del(&hash_node->x_axis_node);
+	hlist_del(&hash_node->y_axis_node);
+	devm_kfree(tbl_mgt->tbl_key.dev, hash_node->x_axis_key);
+	devm_kfree(tbl_mgt->tbl_key.dev, hash_node->y_axis_key);
+	devm_kfree(tbl_mgt->tbl_key.dev, hash_node->data);
+	devm_kfree(tbl_mgt->tbl_key.dev, hash_node);
+	tbl_mgt->node_num--;
+}
+
+/*
+ * free a hash node
+ */
+void nbl_common_free_hash_xy_node(void *priv, void *x_key, void *y_key)
+{
+	struct nbl_hash_xy_tbl_mgt *tbl_mgt =
+		(struct nbl_hash_xy_tbl_mgt *)priv;
+	struct nbl_hash_entry_xy_node *hash_node;
+	struct hlist_head *head;
+	void *key;
+	u32 hash_val;
+
+	u16 key_size, x_key_size, y_key_size;
+
+	x_key_size = tbl_mgt->tbl_key.x_key_size;
+	y_key_size = tbl_mgt->tbl_key.y_key_size;
+	key_size = x_key_size + y_key_size;
+	key = devm_kzalloc(tbl_mgt->tbl_key.dev, key_size, GFP_KERNEL);
+	if (!key)
+		return;
+
+	memcpy(key, x_key, x_key_size);
+	memcpy(key + x_key_size, y_key, y_key_size);
+	hash_val = nbl_common_calc_hash_key(key, key_size,
+					    tbl_mgt->tbl_key.bucket_size);
+	head = tbl_mgt->hash + hash_val;
+
+	if (tbl_mgt->tbl_key.lock_need)
+		mutex_lock(&tbl_mgt->lock);
+
+	hlist_for_each_entry(hash_node, head, node)
+		if (!memcmp(hash_node->x_axis_key, x_key, x_key_size) &&
+		    !memcmp(hash_node->y_axis_key, y_key, y_key_size)) {
+			break;
+		}
+
+	if (hash_node)
+		nbl_common_remove_hash_xy_node(tbl_mgt, hash_node);
+
+	if (tbl_mgt->tbl_key.lock_need)
+		mutex_unlock(&tbl_mgt->lock);
+
+	devm_kfree(tbl_mgt->tbl_key.dev, key);
+}
+
+/* 0: the node accord with the match condition */
+static int
+nbl_common_match_hash_xy_node(struct nbl_hash_xy_tbl_mgt *tbl_mgt,
+			      struct nbl_hash_xy_tbl_scan_key *key,
+			      struct nbl_hash_entry_xy_node *hash_node)
+{
+	int ret = 0;
+
+	if (key->match_func) {
+		ret = key->match_func(key->match_condition,
+				      hash_node->x_axis_key,
+				      hash_node->y_axis_key, hash_node->data);
+		if (ret)
+			return ret;
+	}
+
+	if (key->action_func)
+		key->action_func(key->action_priv, hash_node->x_axis_key,
+				 hash_node->y_axis_key, hash_node->data);
+
+	if (key->op_type == NBL_HASH_TBL_OP_DELETE)
+		nbl_common_remove_hash_xy_node(tbl_mgt, hash_node);
+
+	return 0;
+}
+
+/*
+ * scan by x_axis or y_aixs or none, and return the match node number
+ */
+u16 nbl_common_scan_hash_xy_node(void *priv,
+				 struct nbl_hash_xy_tbl_scan_key *key)
+{
+	struct nbl_hash_xy_tbl_mgt *tbl =
+		(struct nbl_hash_xy_tbl_mgt *)priv;
+	struct nbl_hash_entry_xy_node *hash_node;
+	struct hlist_node *safe_node;
+	struct hlist_head *head;
+	int ret;
+	u32 i;
+	u32 hash_val;
+	u16 x_key_size;
+	u16 y_key_size;
+	u16 node_num = 0;
+
+	if (tbl->tbl_key.lock_need)
+		mutex_lock(&tbl->lock);
+
+	if (key->scan_type == NBL_HASH_TBL_X_AXIS_SCAN) {
+		x_key_size = tbl->tbl_key.x_key_size;
+		hash_val = nbl_common_calc_hash_key(key->x_key, x_key_size,
+						    tbl->tbl_key.x_bucket_size);
+		head = tbl->x_axis_hash + hash_val;
+		hlist_for_each_entry_safe(hash_node, safe_node, head,
+					  x_axis_node) {
+			if (!memcmp(hash_node->x_axis_key, key->x_key,
+				    x_key_size)) {
+				ret = nbl_common_match_hash_xy_node(tbl, key,
+								    hash_node);
+				if (!ret) {
+					node_num++;
+					if (key->only_query_exist)
+						break;
+				}
+			}
+		}
+	} else if (key->scan_type == NBL_HASH_TBL_Y_AXIS_SCAN) {
+		y_key_size = tbl->tbl_key.y_key_size;
+		hash_val = nbl_common_calc_hash_key(key->y_key, y_key_size,
+						    tbl->tbl_key.y_bucket_size);
+		head = tbl->y_axis_hash + hash_val;
+		hlist_for_each_entry_safe(hash_node, safe_node, head,
+					  y_axis_node) {
+			if (!memcmp(hash_node->y_axis_key, key->y_key,
+				    y_key_size)) {
+				ret = nbl_common_match_hash_xy_node(tbl, key,
+								    hash_node);
+				if (!ret) {
+					node_num++;
+					if (key->only_query_exist)
+						break;
+				}
+			}
+		}
+	} else {
+		for (i = 0; i < tbl->tbl_key.bucket_size; i++) {
+			head = tbl->hash + i;
+			hlist_for_each_entry_safe(hash_node, safe_node, head,
+						  node) {
+				ret = nbl_common_match_hash_xy_node(tbl, key,
+								    hash_node);
+				if (!ret)
+					node_num++;
+			}
+		}
+	}
+
+	if (tbl->tbl_key.lock_need)
+		mutex_unlock(&tbl->lock);
+
+	return node_num;
+}
+
+void nbl_common_rm_hash_xy_table(void *priv,
+				 struct nbl_hash_xy_tbl_del_key *key)
+{
+	struct nbl_hash_xy_tbl_mgt *tbl_mgt =
+		(struct nbl_hash_xy_tbl_mgt *)priv;
+	struct nbl_hash_entry_xy_node *hash_node;
+	struct hlist_node *safe_node;
+	struct hlist_head *head;
+	struct device *dev;
+	u32 i;
+
+	if (!priv)
+		return;
+
+	if (tbl_mgt->tbl_key.lock_need)
+		mutex_lock(&tbl_mgt->lock);
+
+	for (i = 0; i < tbl_mgt->tbl_key.bucket_size; i++) {
+		head = tbl_mgt->hash + i;
+		hlist_for_each_entry_safe(hash_node, safe_node, head, node) {
+			if (key->action_func)
+				key->action_func(key->action_priv,
+						 hash_node->x_axis_key,
+						 hash_node->y_axis_key,
+						 hash_node->data);
+			nbl_common_remove_hash_xy_node(tbl_mgt, hash_node);
+		}
+	}
+
+	devm_kfree(tbl_mgt->tbl_key.dev, tbl_mgt->hash);
+	devm_kfree(tbl_mgt->tbl_key.dev, tbl_mgt->x_axis_hash);
+	devm_kfree(tbl_mgt->tbl_key.dev, tbl_mgt->y_axis_hash);
+
+	if (tbl_mgt->tbl_key.lock_need)
+		mutex_unlock(&tbl_mgt->lock);
+
+	dev = tbl_mgt->tbl_key.dev;
+	devm_kfree(dev, tbl_mgt);
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.h
new file mode 100644
index 000000000000..efb9eb410546
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.h
@@ -0,0 +1,54 @@
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
+/*
+ * the key_hash size is index_size/NBL_INDEX_HASH_DIVISOR. eg index_size is
+ * 1024, the key_hash size is 1024/16 = 64
+ */
+#define NBL_INDEX_HASH_DIVISOR 16
+
+/* list only need one bucket size */
+#define NBL_HASH_TBL_LIST_BUCKET_SIZE 1
+
+struct nbl_hash_tbl_mgt {
+	struct nbl_hash_tbl_key tbl_key;
+	struct hlist_head *hash;
+	struct mutex lock; /* support multi thread */
+	u16 node_num;
+};
+
+struct nbl_hash_xy_tbl_mgt {
+	struct nbl_hash_xy_tbl_key tbl_key;
+	struct hlist_head *hash;
+	struct hlist_head *x_axis_hash;
+	struct hlist_head *y_axis_hash;
+	struct mutex lock; /* support multi thread */
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
+/* it used for y_axis no necessay */
+struct nbl_hash_entry_xy_node {
+	struct hlist_node node;
+	struct hlist_node x_axis_node;
+	struct hlist_node y_axis_node;
+	void *x_axis_key;
+	void *y_axis_key;
+	void *data;
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index 33ed810ec7d0..fe83bd9f524c 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -9,6 +9,7 @@
 
 #include <linux/pci.h>
 #include "nbl_product_base.h"
+#include "nbl_def_channel.h"
 #include "nbl_def_hw.h"
 #include "nbl_def_common.h"
 
@@ -18,7 +19,10 @@
 #define NBL_ADAP_TO_RPDUCT_BASE_OPS(adapter)	((adapter)->product_base_ops)
 
 #define NBL_ADAP_TO_HW_MGT(adapter) ((adapter)->core.hw_mgt)
+#define NBL_ADAP_TO_CHAN_MGT(adapter) ((adapter)->core.chan_mgt)
 #define NBL_ADAP_TO_HW_OPS_TBL(adapter) ((adapter)->intf.hw_ops_tbl)
+#define NBL_ADAP_TO_CHAN_OPS_TBL(adapter) ((adapter)->intf.channel_ops_tbl)
+
 #define NBL_CAP_TEST_BIT(val, loc) (((val) >> (loc)) & 0x1)
 
 #define NBL_CAP_IS_CTRL(val) NBL_CAP_TEST_BIT(val, NBL_CAP_HAS_CTRL_BIT)
@@ -39,6 +43,7 @@ enum {
 
 struct nbl_interface {
 	struct nbl_hw_ops_tbl *hw_ops_tbl;
+	struct nbl_channel_ops_tbl *channel_ops_tbl;
 };
 
 struct nbl_core {
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
index 40701ff147e2..bf7c95ea33da 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -6,7 +6,266 @@
 
 #include "nbl_hw_leonis.h"
 
+static void nbl_hw_update_mailbox_queue_tail_ptr(void *priv, u16 tail_ptr,
+						 u8 txrx)
+{
+	/* local_qid 0 and 1 denote rx and tx queue respectively */
+	u32 local_qid = txrx;
+	u32 value = ((u32)tail_ptr << 16) | local_qid;
+
+	/* wmb for doorbell */
+	wmb();
+	nbl_mbx_wr32(priv, NBL_MAILBOX_NOTIFY_ADDR, value);
+}
+
+static void nbl_hw_config_mailbox_rxq(void *priv, dma_addr_t dma_addr,
+				      int size_bwid)
+{
+	struct nbl_mailbox_qinfo_cfg_table qinfo_cfg_rx_table = { 0 };
+
+	qinfo_cfg_rx_table.queue_rst = 1;
+	nbl_hw_write_mbx_regs(priv, NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR,
+			      (u8 *)&qinfo_cfg_rx_table,
+			      sizeof(qinfo_cfg_rx_table));
+
+	qinfo_cfg_rx_table.queue_base_addr_l = (u32)(dma_addr & 0xFFFFFFFF);
+	qinfo_cfg_rx_table.queue_base_addr_h = (u32)(dma_addr >> 32);
+	qinfo_cfg_rx_table.queue_size_bwind = (u32)size_bwid;
+	qinfo_cfg_rx_table.queue_rst = 0;
+	qinfo_cfg_rx_table.queue_en = 1;
+	nbl_hw_write_mbx_regs(priv, NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR,
+			      (u8 *)&qinfo_cfg_rx_table,
+			      sizeof(qinfo_cfg_rx_table));
+}
+
+static void nbl_hw_config_mailbox_txq(void *priv, dma_addr_t dma_addr,
+				      int size_bwid)
+{
+	struct nbl_mailbox_qinfo_cfg_table qinfo_cfg_tx_table = { 0 };
+
+	qinfo_cfg_tx_table.queue_rst = 1;
+	nbl_hw_write_mbx_regs(priv, NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR,
+			      (u8 *)&qinfo_cfg_tx_table,
+			      sizeof(qinfo_cfg_tx_table));
+
+	qinfo_cfg_tx_table.queue_base_addr_l = (u32)(dma_addr & 0xFFFFFFFF);
+	qinfo_cfg_tx_table.queue_base_addr_h = (u32)(dma_addr >> 32);
+	qinfo_cfg_tx_table.queue_size_bwind = (u32)size_bwid;
+	qinfo_cfg_tx_table.queue_rst = 0;
+	qinfo_cfg_tx_table.queue_en = 1;
+	nbl_hw_write_mbx_regs(priv, NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR,
+			      (u8 *)&qinfo_cfg_tx_table,
+			      sizeof(qinfo_cfg_tx_table));
+}
+
+static void nbl_hw_stop_mailbox_rxq(void *priv)
+{
+	struct nbl_mailbox_qinfo_cfg_table qinfo_cfg_rx_table = { 0 };
+
+	nbl_hw_write_mbx_regs(priv, NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR,
+			      (u8 *)&qinfo_cfg_rx_table,
+			      sizeof(qinfo_cfg_rx_table));
+}
+
+static void nbl_hw_stop_mailbox_txq(void *priv)
+{
+	struct nbl_mailbox_qinfo_cfg_table qinfo_cfg_tx_table = { 0 };
+
+	nbl_hw_write_mbx_regs(priv, NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR,
+			      (u8 *)&qinfo_cfg_tx_table,
+			      sizeof(qinfo_cfg_tx_table));
+}
+
+static u16 nbl_hw_get_mailbox_rx_tail_ptr(void *priv)
+{
+	struct nbl_mailbox_qinfo_cfg_dbg_tbl cfg_dbg_tbl = { 0 };
+
+	nbl_hw_read_mbx_regs(priv, NBL_MAILBOX_QINFO_CFG_DBG_TABLE_ADDR,
+			     (u8 *)&cfg_dbg_tbl, sizeof(cfg_dbg_tbl));
+	return cfg_dbg_tbl.rx_tail_ptr;
+}
+
+static bool nbl_hw_check_mailbox_dma_err(void *priv, bool tx)
+{
+	struct nbl_mailbox_qinfo_cfg_table qinfo_cfg_tbl = { 0 };
+	u64 addr;
+
+	if (tx)
+		addr = NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR;
+	else
+		addr = NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR;
+
+	nbl_hw_read_mbx_regs(priv, addr, (u8 *)&qinfo_cfg_tbl,
+			     sizeof(qinfo_cfg_tbl));
+	return !!qinfo_cfg_tbl.dif_err;
+}
+
+static u32 nbl_hw_get_host_pf_mask(void *priv)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	u32 data;
+
+	nbl_hw_rd_regs(hw_mgt, NBL_PCIE_HOST_K_PF_MASK_REG, (u8 *)&data,
+		       sizeof(data));
+	return data;
+}
+
+static void nbl_hw_cfg_mailbox_qinfo(void *priv, u16 func_id, u16 bus,
+				     u16 devid, u16 function)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
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
+static void nbl_hw_config_adminq_rxq(void *priv, dma_addr_t dma_addr,
+				     int size_bwid)
+{
+	struct nbl_mailbox_qinfo_cfg_table qinfo_cfg_rx_table = { 0 };
+
+	qinfo_cfg_rx_table.queue_rst = 1;
+	nbl_hw_write_mbx_regs(priv, NBL_ADMINQ_QINFO_CFG_RX_TABLE_ADDR,
+			      (u8 *)&qinfo_cfg_rx_table,
+			      sizeof(qinfo_cfg_rx_table));
+
+	qinfo_cfg_rx_table.queue_base_addr_l = (u32)(dma_addr & 0xFFFFFFFF);
+	qinfo_cfg_rx_table.queue_base_addr_h = (u32)(dma_addr >> 32);
+	qinfo_cfg_rx_table.queue_size_bwind = (u32)size_bwid;
+	qinfo_cfg_rx_table.queue_rst = 0;
+	qinfo_cfg_rx_table.queue_en = 1;
+	nbl_hw_write_mbx_regs(priv, NBL_ADMINQ_QINFO_CFG_RX_TABLE_ADDR,
+			      (u8 *)&qinfo_cfg_rx_table,
+			      sizeof(qinfo_cfg_rx_table));
+}
+
+static void nbl_hw_config_adminq_txq(void *priv, dma_addr_t dma_addr,
+				     int size_bwid)
+{
+	struct nbl_mailbox_qinfo_cfg_table qinfo_cfg_tx_table = { 0 };
+
+	qinfo_cfg_tx_table.queue_rst = 1;
+	nbl_hw_write_mbx_regs(priv, NBL_ADMINQ_QINFO_CFG_TX_TABLE_ADDR,
+			      (u8 *)&qinfo_cfg_tx_table,
+			      sizeof(qinfo_cfg_tx_table));
+
+	qinfo_cfg_tx_table.queue_base_addr_l = (u32)(dma_addr & 0xFFFFFFFF);
+	qinfo_cfg_tx_table.queue_base_addr_h = (u32)(dma_addr >> 32);
+	qinfo_cfg_tx_table.queue_size_bwind = (u32)size_bwid;
+	qinfo_cfg_tx_table.queue_rst = 0;
+	qinfo_cfg_tx_table.queue_en = 1;
+	nbl_hw_write_mbx_regs(priv, NBL_ADMINQ_QINFO_CFG_TX_TABLE_ADDR,
+			      (u8 *)&qinfo_cfg_tx_table,
+			      sizeof(qinfo_cfg_tx_table));
+}
+
+static void nbl_hw_stop_adminq_rxq(void *priv)
+{
+	struct nbl_mailbox_qinfo_cfg_table qinfo_cfg_rx_table = { 0 };
+
+	nbl_hw_write_mbx_regs(priv, NBL_ADMINQ_QINFO_CFG_RX_TABLE_ADDR,
+			      (u8 *)&qinfo_cfg_rx_table,
+			      sizeof(qinfo_cfg_rx_table));
+}
+
+static void nbl_hw_stop_adminq_txq(void *priv)
+{
+	struct nbl_mailbox_qinfo_cfg_table qinfo_cfg_tx_table = { 0 };
+
+	nbl_hw_write_mbx_regs(priv, NBL_ADMINQ_QINFO_CFG_TX_TABLE_ADDR,
+			      (u8 *)&qinfo_cfg_tx_table,
+			      sizeof(qinfo_cfg_tx_table));
+}
+
+static void nbl_hw_cfg_adminq_qinfo(void *priv, u16 bus, u16 devid,
+				    u16 function)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_adminq_qinfo_map_table adminq_qinfo_map = {0};
+
+	memset(&adminq_qinfo_map, 0, sizeof(adminq_qinfo_map));
+	adminq_qinfo_map.function = function;
+	adminq_qinfo_map.devid = devid;
+	adminq_qinfo_map.bus = bus;
+
+	nbl_hw_write_mbx_regs(hw_mgt, NBL_ADMINQ_MSIX_MAP_TABLE_ADDR,
+			      (u8 *)&adminq_qinfo_map,
+			      sizeof(adminq_qinfo_map));
+}
+
+static void nbl_hw_update_adminq_queue_tail_ptr(void *priv, u16 tail_ptr,
+						u8 txrx)
+{
+	/* local_qid 0 and 1 denote rx and tx queue respectively */
+	u32 local_qid = txrx;
+	u32 value = ((u32)tail_ptr << 16) | local_qid;
+
+	/* wmb for doorbell */
+	wmb();
+	nbl_mbx_wr32(priv, NBL_ADMINQ_NOTIFY_ADDR, value);
+}
+
+static bool nbl_hw_check_adminq_dma_err(void *priv, bool tx)
+{
+	struct nbl_mailbox_qinfo_cfg_table qinfo_cfg_tbl = { 0 };
+	u64 addr;
+
+	if (tx)
+		addr = NBL_ADMINQ_QINFO_CFG_TX_TABLE_ADDR;
+	else
+		addr = NBL_ADMINQ_QINFO_CFG_RX_TABLE_ADDR;
+
+	nbl_hw_read_mbx_regs(priv, addr, (u8 *)&qinfo_cfg_tbl,
+			     sizeof(qinfo_cfg_tbl));
+
+	if (!qinfo_cfg_tbl.rsv1 && !qinfo_cfg_tbl.rsv2 && qinfo_cfg_tbl.dif_err)
+		return true;
+
+	return false;
+}
+
+static void nbl_hw_set_hw_status(void *priv, enum nbl_hw_status hw_status)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+
+	hw_mgt->hw_status = hw_status;
+};
+
+static enum nbl_hw_status nbl_hw_get_hw_status(void *priv)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+
+	return hw_mgt->hw_status;
+};
+
 static struct nbl_hw_ops hw_ops = {
+	.update_mailbox_queue_tail_ptr = nbl_hw_update_mailbox_queue_tail_ptr,
+	.config_mailbox_rxq = nbl_hw_config_mailbox_rxq,
+	.config_mailbox_txq = nbl_hw_config_mailbox_txq,
+	.stop_mailbox_rxq = nbl_hw_stop_mailbox_rxq,
+	.stop_mailbox_txq = nbl_hw_stop_mailbox_txq,
+	.get_mailbox_rx_tail_ptr = nbl_hw_get_mailbox_rx_tail_ptr,
+	.check_mailbox_dma_err = nbl_hw_check_mailbox_dma_err,
+	.get_host_pf_mask = nbl_hw_get_host_pf_mask,
+	.cfg_mailbox_qinfo = nbl_hw_cfg_mailbox_qinfo,
+
+	.config_adminq_rxq = nbl_hw_config_adminq_rxq,
+	.config_adminq_txq = nbl_hw_config_adminq_txq,
+	.stop_adminq_rxq = nbl_hw_stop_adminq_rxq,
+	.stop_adminq_txq = nbl_hw_stop_adminq_txq,
+	.cfg_adminq_qinfo = nbl_hw_cfg_adminq_qinfo,
+	.update_adminq_queue_tail_ptr = nbl_hw_update_adminq_queue_tail_ptr,
+	.check_adminq_dma_err = nbl_hw_check_adminq_dma_err,
+
+	.set_hw_status = nbl_hw_set_hw_status,
+	.get_hw_status = nbl_hw_get_hw_status,
+
 };
 
 /* Structure starts here, adding an op should not modify anything below */
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
new file mode 100644
index 000000000000..aa28fbd589f1
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
@@ -0,0 +1,715 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_DEF_CHANNEL_H_
+#define _NBL_DEF_CHANNEL_H_
+
+#include <linux/if_ether.h>
+#include "nbl_include.h"
+
+#define NBL_CHAN_OPS_TBL_TO_OPS(chan_ops_tbl)	((chan_ops_tbl)->ops)
+#define NBL_CHAN_OPS_TBL_TO_PRIV(chan_ops_tbl)	((chan_ops_tbl)->priv)
+
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
+
+enum nbl_chan_msg_type {
+	NBL_CHAN_MSG_ACK,
+	NBL_CHAN_MSG_ADD_MACVLAN,
+	NBL_CHAN_MSG_DEL_MACVLAN,
+	NBL_CHAN_MSG_ADD_MULTI_RULE,
+	NBL_CHAN_MSG_DEL_MULTI_RULE,
+	NBL_CHAN_MSG_SETUP_MULTI_GROUP,
+	NBL_CHAN_MSG_REMOVE_MULTI_GROUP,
+	NBL_CHAN_MSG_REGISTER_NET,
+	NBL_CHAN_MSG_UNREGISTER_NET,
+	NBL_CHAN_MSG_ALLOC_TXRX_QUEUES,
+	NBL_CHAN_MSG_FREE_TXRX_QUEUES,
+	NBL_CHAN_MSG_SETUP_QUEUE,
+	NBL_CHAN_MSG_REMOVE_ALL_QUEUES,
+	NBL_CHAN_MSG_CFG_DSCH,
+	NBL_CHAN_MSG_SETUP_CQS,
+	NBL_CHAN_MSG_REMOVE_CQS,
+	NBL_CHAN_MSG_CFG_QDISC_MQPRIO,
+	NBL_CHAN_MSG_CONFIGURE_MSIX_MAP,
+	NBL_CHAN_MSG_DESTROY_MSIX_MAP,
+	NBL_CHAN_MSG_MAILBOX_ENABLE_IRQ,
+	NBL_CHAN_MSG_GET_GLOBAL_VECTOR,
+	NBL_CHAN_MSG_GET_VSI_ID,
+	NBL_CHAN_MSG_SET_PROSISC_MODE,
+	NBL_CHAN_MSG_GET_FIRMWARE_VERSION,
+	NBL_CHAN_MSG_GET_QUEUE_ERR_STATS,
+	NBL_CHAN_MSG_GET_COALESCE,
+	NBL_CHAN_MSG_SET_COALESCE,
+	NBL_CHAN_MSG_SET_SPOOF_CHECK_ADDR,
+	NBL_CHAN_MSG_SET_VF_SPOOF_CHECK,
+	NBL_CHAN_MSG_GET_RXFH_INDIR_SIZE,
+	NBL_CHAN_MSG_GET_RXFH_INDIR,
+	NBL_CHAN_MSG_GET_RXFH_RSS_KEY,
+	NBL_CHAN_MSG_GET_RXFH_RSS_ALG_SEL,
+	NBL_CHAN_MSG_GET_HW_CAPS,
+	NBL_CHAN_MSG_GET_HW_STATE,
+	NBL_CHAN_MSG_REGISTER_RDMA,
+	NBL_CHAN_MSG_UNREGISTER_RDMA,
+	NBL_CHAN_MSG_GET_REAL_HW_ADDR,
+	NBL_CHAN_MSG_GET_REAL_BDF,
+	NBL_CHAN_MSG_GRC_PROCESS,
+	NBL_CHAN_MSG_SET_SFP_STATE,
+	NBL_CHAN_MSG_SET_ETH_LOOPBACK,
+	NBL_CHAN_MSG_CHECK_ACTIVE_VF,
+	NBL_CHAN_MSG_GET_PRODUCT_FLEX_CAP,
+	NBL_CHAN_MSG_ALLOC_KTLS_TX_INDEX,
+	NBL_CHAN_MSG_FREE_KTLS_TX_INDEX,
+	NBL_CHAN_MSG_CFG_KTLS_TX_KEYMAT,
+	NBL_CHAN_MSG_ALLOC_KTLS_RX_INDEX,
+	NBL_CHAN_MSG_FREE_KTLS_RX_INDEX,
+	NBL_CHAN_MSG_CFG_KTLS_RX_KEYMAT,
+	NBL_CHAN_MSG_CFG_KTLS_RX_RECORD,
+	NBL_CHAN_MSG_ADD_KTLS_RX_FLOW,
+	NBL_CHAN_MSG_DEL_KTLS_RX_FLOW,
+	NBL_CHAN_MSG_ALLOC_IPSEC_TX_INDEX,
+	NBL_CHAN_MSG_FREE_IPSEC_TX_INDEX,
+	NBL_CHAN_MSG_ALLOC_IPSEC_RX_INDEX,
+	NBL_CHAN_MSG_FREE_IPSEC_RX_INDEX,
+	NBL_CHAN_MSG_CFG_IPSEC_TX_SAD,
+	NBL_CHAN_MSG_CFG_IPSEC_RX_SAD,
+	NBL_CHAN_MSG_ADD_IPSEC_TX_FLOW,
+	NBL_CHAN_MSG_DEL_IPSEC_TX_FLOW,
+	NBL_CHAN_MSG_ADD_IPSEC_RX_FLOW,
+	NBL_CHAN_MSG_DEL_IPSEC_RX_FLOW,
+	NBL_CHAN_MSG_NOTIFY_IPSEC_HARD_EXPIRE,
+	NBL_CHAN_MSG_GET_MBX_IRQ_NUM,
+	NBL_CHAN_MSG_CLEAR_FLOW,
+	NBL_CHAN_MSG_CLEAR_QUEUE,
+	NBL_CHAN_MSG_GET_ETH_ID,
+	NBL_CHAN_MSG_SET_OFFLOAD_STATUS,
+
+	NBL_CHAN_MSG_INIT_OFLD,
+	NBL_CHAN_MSG_INIT_CMDQ,
+	NBL_CHAN_MSG_DESTROY_CMDQ,
+	NBL_CHAN_MSG_RESET_CMDQ,
+	NBL_CHAN_MSG_INIT_FLOW,
+	NBL_CHAN_MSG_DEINIT_FLOW,
+	NBL_CHAN_MSG_OFFLOAD_FLOW_RULE,
+	NBL_CHAN_MSG_GET_ACL_SWITCH,
+	NBL_CHAN_MSG_GET_VSI_GLOBAL_QUEUE_ID,
+	NBL_CHAN_MSG_INIT_REP,
+	NBL_CHAN_MSG_GET_LINE_RATE_INFO,
+
+	NBL_CHAN_MSG_REGISTER_NET_REP,
+	NBL_CHAN_MSG_UNREGISTER_NET_REP,
+	NBL_CHAN_MSG_REGISTER_ETH_REP,
+	NBL_CHAN_MSG_UNREGISTER_ETH_REP,
+	NBL_CHAN_MSG_REGISTER_UPCALL_PORT,
+	NBL_CHAN_MSG_UNREGISTER_UPCALL_PORT,
+	NBL_CHAN_MSG_GET_PORT_STATE,
+	NBL_CHAN_MSG_SET_PORT_ADVERTISING,
+	NBL_CHAN_MSG_GET_MODULE_INFO,
+	NBL_CHAN_MSG_GET_MODULE_EEPROM,
+	NBL_CHAN_MSG_GET_LINK_STATE,
+	NBL_CHAN_MSG_NOTIFY_LINK_STATE,
+
+	NBL_CHAN_MSG_GET_QUEUE_CXT,
+	NBL_CHAN_MSG_CFG_LOG,
+	NBL_CHAN_MSG_INIT_VDPAQ,
+	NBL_CHAN_MSG_DESTROY_VDPAQ,
+	NBL_CHAN_GET_UPCALL_PORT,
+	NBL_CHAN_MSG_NOTIFY_ETH_REP_LINK_STATE,
+	NBL_CHAN_MSG_SET_ETH_MAC_ADDR,
+	NBL_CHAN_MSG_GET_FUNCTION_ID,
+	NBL_CHAN_MSG_GET_CHIP_TEMPERATURE,
+
+	NBL_CHAN_MSG_DISABLE_HW_FLOW,
+	NBL_CHAN_MSG_ENABLE_HW_FLOW,
+	NBL_CHAN_MSG_SET_UPCALL_RULE,
+	NBL_CHAN_MSG_UNSET_UPCALL_RULE,
+
+	NBL_CHAN_MSG_GET_REG_DUMP,
+	NBL_CHAN_MSG_GET_REG_DUMP_LEN,
+
+	NBL_CHAN_MSG_CFG_LAG_HASH_ALGORITHM,
+	NBL_CHAN_MSG_CFG_LAG_MEMBER_FWD,
+	NBL_CHAN_MSG_CFG_LAG_MEMBER_LIST,
+	NBL_CHAN_MSG_CFG_LAG_MEMBER_UP_ATTR,
+	NBL_CHAN_MSG_ADD_LAG_FLOW,
+	NBL_CHAN_MSG_DEL_LAG_FLOW,
+
+	NBL_CHAN_MSG_SWITCHDEV_INIT_CMDQ,
+	NBL_CHAN_MSG_SWITCHDEV_DEINIT_CMDQ,
+	NBL_CHAN_MSG_SET_TC_FLOW_INFO,
+	NBL_CHAN_MSG_UNSET_TC_FLOW_INFO,
+	NBL_CHAN_MSG_INIT_ACL,
+	NBL_CHAN_MSG_UNINIT_ACL,
+
+	NBL_CHAN_MSG_CFG_LAG_MCC,
+
+	NBL_CHAN_MSG_REGISTER_VSI2Q,
+	NBL_CHAN_MSG_SETUP_Q2VSI,
+	NBL_CHAN_MSG_REMOVE_Q2VSI,
+	NBL_CHAN_MSG_SETUP_RSS,
+	NBL_CHAN_MSG_REMOVE_RSS,
+	NBL_CHAN_MSG_GET_REP_QUEUE_INFO,
+	NBL_CHAN_MSG_CTRL_PORT_LED,
+	NBL_CHAN_MSG_NWAY_RESET,
+	NBL_CHAN_MSG_SET_INTL_SUPPRESS_LEVEL,
+	NBL_CHAN_MSG_GET_ETH_STATS,
+	NBL_CHAN_MSG_GET_MODULE_TEMPERATURE,
+	NBL_CHAN_MSG_GET_BOARD_INFO,
+
+	NBL_CHAN_MSG_GET_P4_USED,
+	NBL_CHAN_MSG_GET_VF_BASE_VSI_ID,
+
+	NBL_CHAN_MSG_ADD_LLDP_FLOW,
+	NBL_CHAN_MSG_DEL_LLDP_FLOW,
+
+	NBL_CHAN_MSG_CFG_ETH_BOND_INFO,
+	NBL_CHAN_MSG_CFG_DUPPKT_MCC,
+
+	NBL_CHAN_MSG_ADD_ND_UPCALL_FLOW,
+	NBL_CHAN_MSG_DEL_ND_UPCALL_FLOW,
+
+	NBL_CHAN_MSG_GET_BOARD_ID,
+
+	NBL_CHAN_MSG_SET_SHAPING_DPORT_VLD,
+	NBL_CHAN_MSG_SET_DPORT_FC_TH_VLD,
+
+	NBL_CHAN_MSG_REGISTER_RDMA_BOND,
+	NBL_CHAN_MSG_UNREGISTER_RDMA_BOND,
+
+	NBL_CHAN_MSG_RESTORE_NETDEV_QUEUE,
+	NBL_CHAN_MSG_RESTART_NETDEV_QUEUE,
+	NBL_CHAN_MSG_RESTORE_HW_QUEUE,
+
+	NBL_CHAN_MSG_KEEP_ALIVE,
+
+	NBL_CHAN_MSG_GET_BASE_MAC_ADDR,
+
+	NBL_CHAN_MSG_CFG_BOND_SHAPING,
+	NBL_CHAN_MSG_CFG_BGID_BACK_PRESSURE,
+
+	NBL_CHAN_MSG_ALLOC_KT_BLOCK,
+	NBL_CHAN_MSG_FREE_KT_BLOCK,
+
+	NBL_CHAN_MSG_GET_USER_QUEUE_INFO,
+	NBL_CHAN_MSG_GET_ETH_BOND_INFO,
+
+	NBL_CHAN_MSG_CLEAR_ACCEL_FLOW,
+	NBL_CHAN_MSG_SET_BRIDGE_MODE,
+
+	NBL_CHAN_MSG_GET_VF_FUNCTION_ID,
+	NBL_CHAN_MSG_NOTIFY_LINK_FORCED,
+
+	NBL_CHAN_MSG_SET_PMD_DEBUG,
+
+	NBL_CHAN_MSG_REGISTER_FUNC_MAC,
+	NBL_CHAN_MSG_SET_TX_RATE,
+
+	NBL_CHAN_MSG_REGISTER_FUNC_LINK_FORCED,
+	NBL_CHAN_MSG_GET_LINK_FORCED,
+
+	NBL_CHAN_MSG_REGISTER_FUNC_VLAN,
+
+	NBL_CHAN_MSG_GET_FD_FLOW,
+	NBL_CHAN_MSG_GET_FD_FLOW_CNT,
+	NBL_CHAN_MSG_GET_FD_FLOW_ALL,
+	NBL_CHAN_MSG_GET_FD_FLOW_MAX,
+	NBL_CHAN_MSG_REPLACE_FD_FLOW,
+	NBL_CHAN_MSG_REMOVE_FD_FLOW,
+	NBL_CHAN_MSG_CFG_FD_FLOW_STATE,
+
+	NBL_CHAN_MSG_REGISTER_FUNC_RATE,
+	NBL_CHAN_MSG_NOTIFY_VLAN,
+	NBL_CHAN_MSG_GET_XDP_QUEUE_INFO,
+
+	NBL_CHAN_MSG_STOP_ABNORMAL_SW_QUEUE,
+	NBL_CHAN_MSG_STOP_ABNORMAL_HW_QUEUE,
+	NBL_CHAN_MSG_NOTIFY_RESET_EVENT,
+	NBL_CHAN_MSG_ACK_RESET_EVENT,
+	NBL_CHAN_MSG_GET_VF_VSI_ID,
+
+	NBL_CHAN_MSG_CONFIGURE_QOS,
+	NBL_CHAN_MSG_GET_PFC_BUFFER_SIZE,
+	NBL_CHAN_MSG_SET_PFC_BUFFER_SIZE,
+	NBL_CHAN_MSG_GET_VF_STATS,
+	NBL_CHAN_MSG_REGISTER_FUNC_TRUST,
+	NBL_CHAN_MSG_NOTIFY_TRUST,
+	NBL_CHAN_CHECK_VF_IS_ACTIVE,
+	NBL_CHAN_MSG_GET_ETH_ABNORMAL_STATS,
+	NBL_CHAN_MSG_GET_ETH_CTRL_STATS,
+	NBL_CHAN_MSG_GET_PAUSE_STATS,
+	NBL_CHAN_MSG_GET_ETH_MAC_STATS,
+	NBL_CHAN_MSG_GET_FEC_STATS,
+	NBL_CHAN_MSG_CFG_MULTI_MCAST_RULE,
+	NBL_CHAN_MSG_GET_LINK_DOWN_COUNT,
+	NBL_CHAN_MSG_GET_LINK_STATUS_OPCODE,
+	NBL_CHAN_MSG_GET_RMON_STATS,
+	NBL_CHAN_MSG_REGISTER_PF_NAME,
+	NBL_CHAN_MSG_GET_PF_NAME,
+	NBL_CHAN_MSG_CONFIGURE_RDMA_BW,
+	NBL_CHAN_MSG_SET_RATE_LIMIT,
+	NBL_CHAN_MSG_SET_TC_WGT,
+	NBL_CHAN_MSG_REMOVE_QUEUE,
+	NBL_CHAN_MSG_GET_MIRROR_TABLE_ID,
+	NBL_CHAN_MSG_CONFIGURE_MIRROR,
+	NBL_CHAN_MSG_CONFIGURE_MIRROR_TABLE,
+	NBL_CHAN_MSG_CLEAR_MIRROR_CFG,
+	NBL_CHAN_MSG_MIRROR_OUTPUTPORT_NOTIFY,
+	NBL_CHAN_MSG_CHECK_FLOWTABLE_SPEC,
+	NBL_CHAN_CHECK_VF_IS_VDPA,
+	NBL_CHAN_MSG_GET_VDPA_VF_STATS,
+	NBL_CHAN_MSG_SET_RX_RATE,
+	NBL_CHAN_GET_UVN_PKT_DROP_STATS,
+	NBL_CHAN_GET_USTORE_PKT_DROP_STATS,
+	NBL_CHAN_GET_USTORE_TOTAL_PKT_DROP_STATS,
+	NBL_CHAN_MSG_SET_WOL,
+	NBL_CHAN_MSG_INIT_VF_MSIX_MAP,
+	NBL_CHAN_MSG_GET_ST_NAME,
+
+	NBL_CHAN_MSG_MTU_SET = 501,
+	NBL_CHAN_MSG_SET_RXFH_INDIR = 506,
+	NBL_CHAN_MSG_SET_RXFH_RSS_ALG_SEL = 508,
+
+	/* mailbox msg end */
+	NBL_CHAN_MSG_MAILBOX_MAX,
+
+	/* adminq msg */
+	NBL_CHAN_MSG_ADMINQ_GET_EMP_VERSION =
+		0x8101, /* Deprecated, should not be used */
+	NBL_CHAN_MSG_ADMINQ_GET_NVM_VERSION = 0x8102,
+	NBL_CHAN_MSG_ADMINQ_REBOOT = 0x8104,
+	NBL_CHAN_MSG_ADMINQ_FLR_NOTIFY = 0x8105,
+	NBL_CHAN_MSG_ADMINQ_NOTIFY_FW_RESET = 0x8106,
+	NBL_CHAN_MSG_ADMINQ_LOAD_P4 = 0x8107,
+	NBL_CHAN_MSG_ADMINQ_LOAD_P4_DEFAULT = 0x8108,
+	NBL_CHAN_MSG_ADMINQ_EXT_ALERT = 0x8109,
+	NBL_CHAN_MSG_ADMINQ_FLASH_ERASE = 0x8201,
+	NBL_CHAN_MSG_ADMINQ_FLASH_READ = 0x8202,
+	NBL_CHAN_MSG_ADMINQ_FLASH_WRITE = 0x8203,
+	NBL_CHAN_MSG_ADMINQ_FLASH_ACTIVATE = 0x8204,
+	NBL_CHAN_MSG_ADMINQ_RESOURCE_WRITE = 0x8205,
+	NBL_CHAN_MSG_ADMINQ_RESOURCE_READ = 0x8206,
+	NBL_CHAN_MSG_ADMINQ_REGISTER_WRITE = 0x8207,
+	NBL_CHAN_MSG_ADMINQ_REGISTER_READ = 0x8208,
+	NBL_CHAN_MSG_ADMINQ_GET_NVM_BANK_INDEX = 0x820B,
+	NBL_CHAN_MSG_ADMINQ_VERIFY_NVM_BANK = 0x820C,
+	NBL_CHAN_MSG_ADMINQ_FLASH_LOCK = 0x820D,
+	NBL_CHAN_MSG_ADMINQ_FLASH_UNLOCK = 0x820E,
+	NBL_CHAN_MSG_ADMINQ_MANAGE_PORT_ATTRIBUTES = 0x8300,
+	NBL_CHAN_MSG_ADMINQ_PORT_NOTIFY = 0x8301,
+	NBL_CHAN_MSG_ADMINQ_GET_MODULE_EEPROM = 0x8302,
+	NBL_CHAN_MSG_ADMINQ_GET_ETH_STATS = 0x8303,
+	NBL_CHAN_MSG_ADMINQ_GET_FEC_STATS = 0x8305,
+
+	NBL_CHAN_MSG_ADMINQ_EMP_CONSOLE_WRITE = 0x8F01,
+	NBL_CHAN_MSG_ADMINQ_EMP_CONSOLE_READ = 0x8F02,
+
+	NBL_CHAN_MSG_MAX,
+};
+
+#define NBL_CHAN_ADMINQ_FUNCTION_ID (0xFFFF)
+
+struct nbl_chan_vsi_qid_info {
+	u16 vsi_id;
+	u16 local_qid;
+};
+
+#define NBL_CHANNEL_FREEZE_FAILED_CNT	3
+
+enum nbl_chan_state {
+	NBL_CHAN_INTERRUPT_READY,
+	NBL_CHAN_RESETTING,
+	NBL_CHAN_ABNORMAL,
+	NBL_CHAN_STATE_NBITS
+};
+
+struct nbl_chan_param_add_macvlan {
+	u8 mac[ETH_ALEN];
+	u16 vlan;
+	u16 vsi;
+};
+
+struct nbl_chan_param_del_macvlan {
+	u8 mac[ETH_ALEN];
+	u16 vlan;
+	u16 vsi;
+};
+
+struct nbl_chan_param_cfg_multi_mcast {
+	u16 vsi;
+	u16 enable;
+};
+
+struct nbl_chan_param_register_net_info {
+	u16 pf_bdf;
+	u64 vf_bar_start;
+	u64 vf_bar_size;
+	u16 total_vfs;
+	u16 offset;
+	u16 stride;
+	u64 pf_bar_start;
+	u16 is_vdpa;
+};
+
+struct nbl_chan_param_alloc_txrx_queues {
+	u16 vsi_id;
+	u16 queue_num;
+};
+
+struct nbl_chan_param_register_vsi2q {
+	u16 vsi_index;
+	u16 vsi_id;
+	u16 queue_offset;
+	u16 queue_num;
+};
+
+struct nbl_chan_param_setup_queue {
+	struct nbl_txrx_queue_param queue_param;
+	bool is_tx;
+};
+
+struct nbl_chan_param_cfg_dsch {
+	u16 vsi_id;
+	bool vld;
+};
+
+struct nbl_chan_param_setup_cqs {
+	u16 vsi_id;
+	u16 real_qps;
+	bool rss_indir_set;
+};
+
+struct nbl_chan_param_set_promisc_mode {
+	u16 vsi_id;
+	u16 mode;
+};
+
+struct nbl_chan_param_init_vf_msix_map {
+	u16 func_id;
+	bool enable;
+};
+
+struct nbl_chan_param_cfg_msix_map {
+	u16 num_net_msix;
+	u16 num_others_msix;
+	u16 msix_mask_en;
+};
+
+struct nbl_chan_param_enable_mailbox_irq {
+	u16 vector_id;
+	bool enable_msix;
+};
+
+struct nbl_chan_param_get_global_vector {
+	u16 vsi_id;
+	u16 vector_id;
+};
+
+struct nbl_chan_param_get_vsi_id {
+	u16 vsi_id;
+	u16 type;
+};
+
+struct nbl_chan_param_get_eth_id {
+	u16 vsi_id;
+	u8 eth_mode;
+	u8 eth_id;
+	u8 logic_eth_id;
+};
+
+struct nbl_chan_param_get_queue_info {
+	u16 queue_num;
+	u16 queue_size;
+};
+
+struct nbl_chan_result_get_real_bdf {
+	u8 bus;
+	u8 dev;
+	u8 function;
+};
+
+struct nbl_chan_resource_write_param {
+	u32 resid;
+	u32 offset;
+	u32 len;
+	u8 data[];
+};
+
+struct nbl_chan_resource_read_param {
+	u32 resid;
+	u32 offset;
+	u32 len;
+};
+
+struct nbl_chan_adminq_reg_read_param {
+	u32 reg;
+};
+
+struct nbl_chan_adminq_reg_write_param {
+	u32 reg;
+	u32 value;
+};
+
+struct nbl_chan_param_set_sfp_state {
+	u8 eth_id;
+	u8 state;
+};
+
+struct nbl_chan_param_module_eeprom_info {
+	u8 eth_id;
+	u8 i2c_address;
+	u8 page;
+	u8 bank;
+	u32 write:1;
+	u32 version:2;
+	u32 rsvd:29;
+	u16 offset;
+	u16 length;
+#define NBL_MODULE_EEPRO_WRITE_MAX_LEN (4)
+	u8 data[NBL_MODULE_EEPRO_WRITE_MAX_LEN];
+};
+
+struct nbl_chan_param_set_rxfh_indir {
+	u16 vsi_id;
+	u32 indir_size;
+#define NBL_RXFH_INDIR_MAX_SIZE		(512)
+	u32 indir[NBL_RXFH_INDIR_MAX_SIZE];
+};
+
+struct nbl_chan_param_set_eth_mac_addr {
+	u8 mac[ETH_ALEN];
+	u8 eth_id;
+};
+
+struct nbl_chan_param_get_private_stat_data {
+	u32 eth_id;
+	u32 data_len;
+};
+
+struct nbl_chan_param_restore_queue {
+	u16 local_queue_id;
+	int type;
+};
+
+struct nbl_chan_param_restart_queue {
+	u16 local_queue_id;
+	int type;
+};
+
+struct nbl_chan_param_stop_abnormal_sw_queue {
+	u16 local_queue_id;
+	int type;
+};
+
+struct nbl_chan_param_stop_abnormal_hw_queue {
+	u16 vsi_id;
+	u16 local_queue_id;
+	int type;
+};
+
+struct nbl_chan_param_get_vf_func_id {
+	u16 vsi_id;
+	int vf_id;
+};
+
+struct nbl_chan_param_get_vf_vsi_id {
+	u16 vsi_id;
+	int vf_id;
+};
+
+struct nbl_chan_param_notify_link_state {
+	u8 link_state;
+	u32 link_speed;
+};
+
+struct nbl_chan_param_set_mtu {
+	u16 vsi_id;
+	u16 mtu;
+};
+
+struct nbl_register_net_param {
+	u16 pf_bdf;
+	u64 vf_bar_start;
+	u64 vf_bar_size;
+	u16 total_vfs;
+	u16 offset;
+	u16 stride;
+	u64 pf_bar_start;
+	u16 is_vdpa;
+};
+
+struct nbl_register_net_result {
+	u16 tx_queue_num;
+	u16 rx_queue_num;
+	u16 queue_size;
+	u16 rdma_enable;
+
+	u64 hw_features;
+	u64 features;
+
+	u16 max_mtu;
+	u16 queue_offset;
+
+	u8 mac[ETH_ALEN];
+	u16 vlan_proto;
+	u16 vlan_tci;
+	u32 rate;
+	bool trusted;
+
+	u64 vlan_features;
+	u64 hw_enc_features;
+};
+
+/* emp to ctrl dev notify */
+struct nbl_port_notify {
+	u32 id;
+	u32 speed; /* in 10 Mbps units */
+	u8 link_state:1; /* 0:down, 1:up */
+	u8 module_inplace:1; /* 0: not inplace, 1:inplace */
+	u8 revd0:6;
+	u8 flow_ctrl; /* enum nbl_flow_ctrl */
+	u8 fec; /* enum nbl_port_fec */
+	u8 active_lanes;
+	u8 rsvd1[4];
+	u64 advertising; /* enum nbl_port_cap */
+	u64 lp_advertising; /* enum nbl_port_cap */
+};
+
+#define NBL_EMP_LOG_MAX_SIZE (256)
+struct nbl_emp_alert_log_event {
+	u64 uptime;
+	u8 level;
+	u8 data[256];
+};
+
+#define NBL_EMP_ALERT_DATA_MAX_SIZE (4032)
+struct nbl_chan_param_emp_alert_event {
+	u16 type;
+	u16 len;
+	u8 data[NBL_EMP_ALERT_DATA_MAX_SIZE];
+};
+
+struct nbl_eth_link_info {
+	u8 link_status;
+	u32 link_speed;
+};
+
+struct nbl_board_port_info {
+	u8 eth_num;
+	u8 eth_speed;
+	u8 p4_version;
+	u8 rsv[5];
+};
+
+enum nbl_fw_reset_type {
+	NBL_FW_HIGH_TEMP_RESET,
+	NBL_FW_RESET_TYPE_MAX,
+};
+
+struct nbl_chan_param_notify_fw_reset_info {
+	u16 type; /* enum nbl_fw_reset_type */
+	u16 len;
+	u16 data[];
+};
+
+struct nbl_chan_param_pf_name {
+	u16 vsi_id;
+	char dev_name[IFNAMSIZ];
+};
+
+struct nbl_chan_param_check_flow_spec {
+	u16 vlan_list_cnt;
+	u16 unicast_mac_cnt;
+	u16 multi_mac_cnt;
+};
+
+struct nbl_chan_param_set_wol {
+	u8 eth_id;
+	bool enable;
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
+enum nbl_channel_type {
+	NBL_CHAN_TYPE_MAILBOX,
+	NBL_CHAN_TYPE_ADMINQ,
+	NBL_CHAN_TYPE_MAX
+};
+
+struct nbl_channel_ops {
+	int (*send_msg)(void *priv, struct nbl_chan_send_info *chan_send);
+	int (*send_ack)(void *priv, struct nbl_chan_ack_info *chan_ack);
+	int (*register_msg)(void *priv, u16 msg_type, nbl_chan_resp func,
+			    void *callback_priv);
+	void (*unregister_msg)(void *priv, u16 msg_type);
+	int (*cfg_chan_qinfo_map_table)(void *priv, u8 chan_type);
+	bool (*check_queue_exist)(void *priv, u8 chan_type);
+	int (*setup_queue)(void *priv, u8 chan_type);
+	int (*teardown_queue)(void *priv, u8 chan_type);
+	void (*clean_queue_subtask)(void *priv, u8 chan_type);
+	int (*setup_keepalive)(void *priv, u16 dest_id, u8 chan_type);
+	void (*remove_keepalive)(void *priv, u8 chan_type);
+	void (*register_chan_task)(void *priv, u8 chan_type,
+				   struct work_struct *task);
+	void (*set_queue_state)(void *priv, enum nbl_chan_state state,
+				u8 chan_type, u8 set);
+};
+
+struct nbl_channel_ops_tbl {
+	struct nbl_channel_ops *ops;
+	void *priv;
+};
+
+int nbl_chan_init_common(void *p, struct nbl_init_param *param);
+void nbl_chan_remove_common(void *p);
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
index 3533b853abc4..57d88ef0fb6d 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
@@ -105,4 +105,191 @@ struct nbl_common_info {
 	bool wol_ena;
 };
 
+struct nbl_hash_tbl_key {
+	struct device *dev;
+	u16 key_size;
+	u16 data_size; /* no include key or node member */
+	u16 bucket_size;
+	u8 lock_need;  /* true: support multi thread operation */
+	u8 resv;
+};
+
+#define NBL_HASH_TBL_KEY_INIT(key, dev_arg, key_size_arg, data_size_arg,\
+			      bucket_size_arg, lock_need_args)		\
+do {									\
+	typeof(key)	__key   = key;					\
+	__key->dev		= dev_arg;				\
+	__key->key_size		= key_size_arg;				\
+	__key->data_size	= data_size_arg;			\
+	__key->bucket_size	= bucket_size_arg;			\
+	__key->lock_need	= lock_need_args;			\
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
+struct nbl_hash_xy_tbl_key {
+	struct device *dev;
+	u16 x_key_size;
+	u16 y_key_size; /* y_key_len = key_len - x_key_len */
+	u16 data_size; /* no include key or node member */
+	u16 bucket_size;
+	u16 x_bucket_size;
+	u16 y_bucket_size;
+	u8 lock_need; /* true: support multi thread operation */
+	u8 resv[3];
+};
+
+#define NBL_HASH_XY_TBL_KEY_INIT(key, dev_arg, x_key_size_arg, y_key_size_arg,\
+				 data_size_arg,	bucket_size_args,	\
+				 x_bucket_size_arg, y_bucket_size_arg,	\
+				 lock_need_args)			\
+do {									\
+	typeof(key)	__key   = key;					\
+	__key->dev		= dev_arg;				\
+	__key->x_key_size	= x_key_size_arg;			\
+	__key->y_key_size	= y_key_size_arg;			\
+	__key->data_size	= data_size_arg;			\
+	__key->bucket_size	= bucket_size_args;			\
+	__key->x_bucket_size	= x_bucket_size_arg;		\
+	__key->y_bucket_size	= y_bucket_size_arg;		\
+	__key->lock_need	= lock_need_args;			\
+	memset(__key->resv, 0, sizeof(__key->resv));			\
+} while (0)
+
+enum nbl_hash_xy_tbl_scan_type {
+	NBL_HASH_TBL_ALL_SCAN = 0,
+	NBL_HASH_TBL_X_AXIS_SCAN,
+	NBL_HASH_TBL_Y_AXIS_SCAN,
+};
+
+/* true: only query the match one, eg. if x_axis: mac; y_axist: vlan*/
+/*
+ * member "only_query_exist" use
+ * if true: only query the match one, eg. if x_axis: mac; y_axis: vlan,
+ * if only to query the tbl has a gevin "mac", the nbl_hash_xy_tbl_scan_key
+ * struct use as flow:
+ * op_type = NBL_HASH_TBL_OP_SHOW;
+ * scan_type = NBL_HASH_TBL_X_AXIS_SCAN;
+ * only_query_exist = true;
+ * x_key = the mac_addr;
+ * y_key = NULL;
+ * match_func = NULL;
+ * action_func = NULL;
+ */
+struct nbl_hash_xy_tbl_scan_key {
+	enum nbl_hash_tbl_op_type op_type;
+	enum nbl_hash_xy_tbl_scan_type scan_type;
+	bool only_query_exist;
+	u8 resv[3];
+	void *x_key;
+	void *y_key;
+	void *match_condition;
+	/* match ret value must be 0  if the node accord with the condition */
+	int (*match_func)(void *condition, void *x_key, void *y_key,
+			  void *data);
+	void *action_priv;
+	void (*action_func)(void *priv, void *x_key, void *y_key, void *data);
+};
+
+#define NBL_HASH_XY_TBL_SCAN_KEY_INIT(key, op_type_arg, scan_type_arg,	\
+				      query_flag_arg, x_key_arg, y_key_arg,\
+				      con_arg, match_func_arg, priv_arg,\
+				      act_func_arg)			\
+do {									\
+	typeof(key)	__key   = key;					\
+	__key->op_type		= op_type_arg;				\
+	__key->scan_type	= scan_type_arg;			\
+	__key->only_query_exist	= query_flag_arg;			\
+	memset(__key->resv, 0, sizeof(__key->resv));			\
+	__key->x_key		= x_key_arg;				\
+	__key->y_key		= y_key_arg;				\
+	__key->match_condition	= con_arg;				\
+	__key->match_func	= match_func_arg;			\
+	__key->action_priv	= priv_arg;				\
+	__key->action_func	= act_func_arg;				\
+} while (0)
+
+struct nbl_hash_xy_tbl_del_key {
+	void *action_priv;
+	void (*action_func)(void *priv, void *x_key, void *y_key, void *data);
+};
+
+#define NBL_HASH_XY_TBL_DEL_KEY_INIT(key, priv_arg, act_func_arg)	\
+do {									\
+	typeof(key)	__key   = key;					\
+	__key->action_priv	= priv_arg;				\
+	__key->action_func	= act_func_arg;				\
+} while (0)
+
+void nbl_convert_mac(u8 *mac, u8 *reverse_mac);
+
+void nbl_common_queue_work(struct work_struct *task, bool ctrl_task);
+void nbl_common_q_dwork(struct delayed_work *task, u32 msec, bool ctrl_task);
+void nbl_common_q_dwork_keepalive(struct delayed_work *task, u32 msec);
+void nbl_common_release_task(struct work_struct *task);
+void nbl_common_alloc_task(struct work_struct *task, void *func);
+void nbl_common_release_delayed_task(struct delayed_work *task);
+void nbl_common_alloc_delayed_task(struct delayed_work *task, void *func);
+void nbl_common_flush_task(struct work_struct *task);
+
+void nbl_common_destroy_wq(void);
+int nbl_common_create_wq(void);
+u32 nbl_common_pf_id_subtraction_mgtpf_id(struct nbl_common_info *common,
+					  u32 pf_id);
+
+int nbl_common_find_free_idx(unsigned long *addr, u32 size, u32 idx_num,
+			     u32 multiple);
+
+void *nbl_common_init_hash_table(struct nbl_hash_tbl_key *key);
+void nbl_common_remove_hash_table(void *priv, struct nbl_hash_tbl_del_key *key);
+int nbl_common_alloc_hash_node(void *priv, void *key, void *data,
+			       void **out_data);
+void *nbl_common_get_hash_node(void *priv, void *key);
+void nbl_common_free_hash_node(void *priv, void *key);
+
+void *nbl_common_init_hash_xy_table(struct nbl_hash_xy_tbl_key *key);
+void nbl_common_rm_hash_xy_table(void *priv,
+				 struct nbl_hash_xy_tbl_del_key *key);
+int nbl_common_alloc_hash_xy_node(void *priv, void *x_key, void *y_key,
+				  void *data);
+void *nbl_common_get_hash_xy_node(void *priv, void *x_key, void *y_key);
+void nbl_common_free_hash_xy_node(void *priv, void *x_key, void *y_key);
+u16 nbl_common_scan_hash_xy_node(void *priv,
+				 struct nbl_hash_xy_tbl_scan_key *key);
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
index 6ac72e26ccd6..1096feea5ce6 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
@@ -10,6 +10,33 @@
 #include "nbl_include.h"
 
 struct nbl_hw_ops {
+	void (*update_mailbox_queue_tail_ptr)(void *priv, u16 tail_ptr,
+					      u8 txrx);
+	void (*config_mailbox_rxq)(void *priv, dma_addr_t dma_addr,
+				   int size_bwid);
+	void (*config_mailbox_txq)(void *priv, dma_addr_t dma_addr,
+				   int size_bwid);
+	void (*stop_mailbox_rxq)(void *priv);
+	void (*stop_mailbox_txq)(void *priv);
+	u16 (*get_mailbox_rx_tail_ptr)(void *priv);
+	bool (*check_mailbox_dma_err)(void *priv, bool tx);
+	u32 (*get_host_pf_mask)(void *priv);
+
+	void (*cfg_mailbox_qinfo)(void *priv, u16 func_id, u16 bus, u16 devid,
+				  u16 function);
+	void (*config_adminq_rxq)(void *priv, dma_addr_t dma_addr,
+				  int size_bwid);
+	void (*config_adminq_txq)(void *priv, dma_addr_t dma_addr,
+				  int size_bwid);
+	void (*stop_adminq_rxq)(void *priv);
+	void (*stop_adminq_txq)(void *priv);
+	void (*cfg_adminq_qinfo)(void *priv, u16 bus, u16 devid, u16 function);
+	void (*update_adminq_queue_tail_ptr)(void *priv, u16 tail_ptr, u8 txrx);
+	bool (*check_adminq_dma_err)(void *priv, bool tx);
+
+	void (*set_hw_status)(void *priv, enum nbl_hw_status hw_status);
+	enum nbl_hw_status (*get_hw_status)(void *priv);
+
 };
 
 struct nbl_hw_ops_tbl {
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index e620feb382c1..64ac886f0ba2 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -13,6 +13,7 @@
 #define NBL_DRIVER_NAME					"nbl_core"
 
 #define NBL_MAX_PF					8
+
 #define NBL_NEXT_ID(id, max)				\
 	({						\
 		typeof(id) _id = (id);			\
@@ -46,4 +47,70 @@ struct nbl_init_param {
 	bool pci_using_dac;
 };
 
+struct nbl_txrx_queue_param {
+	u16 vsi_id;
+	u64 dma;
+	u64 avail;
+	u64 used;
+	u16 desc_num;
+	u16 local_queue_id;
+	u16 intr_en;
+	u16 intr_mask;
+	u16 global_vec_id;
+	u16 half_offload_en;
+	u16 split;
+	u16 extend_header;
+	u16 cxt;
+	u16 rxcsum;
+};
+
+struct nbl_qid_map_table {
+	u32 local_qid;
+	u32 notify_addr_l;
+	u32 notify_addr_h;
+	u32 global_qid;
+	u32 ctrlq_flag;
+};
+
+struct nbl_qid_map_param {
+	struct nbl_qid_map_table *qid_map;
+	u16 start;
+	u16 len;
+};
+
+struct nbl_queue_cfg_param {
+	/* queue args*/
+	u64 desc;
+	u64 avail;
+	u64 used;
+	u16 size;
+	u16 extend_header;
+	u16 split;
+	u16 last_avail_idx;
+	u16 global_queue_id;
+
+	/*interrupt args*/
+	u16 global_vector;
+	u16 intr_en;
+	u16 intr_mask;
+
+	/* dvn args */
+	u16 tx;
+
+	/* uvn args*/
+	u16 rxcsum;
+	u16 half_offload_en;
+};
+
+enum nbl_fw_port_speed {
+	NBL_FW_PORT_SPEED_10G,
+	NBL_FW_PORT_SPEED_25G,
+	NBL_FW_PORT_SPEED_50G,
+	NBL_FW_PORT_SPEED_100G,
+};
+
+enum nbl_performance_mode {
+	NBL_QUIRKS_NO_TOE,
+	NBL_QUIRKS_UVN_PREFETCH_ALIGN,
+};
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
index a93aa98f2316..3276dd2936ae 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -13,8 +13,8 @@ static struct nbl_product_base_ops nbl_product_base_ops[NBL_PRODUCT_MAX] = {
 		.hw_remove	= nbl_hw_remove_leonis,
 		.res_init	= NULL,
 		.res_remove	= NULL,
-		.chan_init	= NULL,
-		.chan_remove	= NULL,
+		.chan_init	= nbl_chan_init_common,
+		.chan_remove	= nbl_chan_remove_common,
 	},
 };
 
@@ -69,7 +69,12 @@ struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
 	if (ret)
 		goto hw_init_fail;
 
+	ret = product_base_ops->chan_init(adapter, param);
+	if (ret)
+		goto chan_init_fail;
 	return adapter;
+chan_init_fail:
+	product_base_ops->hw_remove(adapter);
 hw_init_fail:
 	devm_kfree(&pdev->dev, adapter);
 	return NULL;
@@ -82,6 +87,7 @@ void nbl_core_remove(struct nbl_adapter *adapter)
 
 	dev = NBL_ADAP_TO_DEV(adapter);
 	product_base_ops = NBL_ADAP_TO_RPDUCT_BASE_OPS(adapter);
+	product_base_ops->chan_remove(adapter);
 	product_base_ops->hw_remove(adapter);
 	devm_kfree(dev, adapter);
 }
-- 
2.47.3


