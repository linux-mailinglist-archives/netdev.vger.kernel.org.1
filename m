Return-Path: <netdev+bounces-297933-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e9C+NhZBKmoIlQMAu9opvQ
	(envelope-from <netdev+bounces-297933-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:01:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5423266E58A
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:01:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297933-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297933-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D607C31CF4F1
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAD82DC78C;
	Thu, 11 Jun 2026 04:55:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-24.us.a.mail.aliyun.com (out198-24.us.a.mail.aliyun.com [47.90.198.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383DD3546E8;
	Thu, 11 Jun 2026 04:55:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781153714; cv=none; b=CmxtuCa1R6yJj9oFIGUNltJv/blJ2kn/UKCtadTqpmSOGdogEIBh93mi1yQ1KocoSg4Lo+NYuB+Vi4PfgCOhIA/4JzpFGjr60mMlY0Vw3M+bf//YzhwQRNwA38UydJ4CqGmJBXpm0b7N3VvI56fwnxEOuyOXCWtNobdc8tyDF6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781153714; c=relaxed/simple;
	bh=4/EPn7ocbZKoNrkRdaVTJIViwY0i6dGRMirqcLwsowA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfwJWEs87H/QezfcUyDE6/9QoNwjoyLw029NhauQN4Mzp6hIzRQTjLcQpkMSjxD6/K2kmXa30Z3f1SE4qXnmzRLIZAIXS9giguUuldZ4kZrbUUl6koOEWu60FyPvXMN99hGXgKsm6KAWFtO6uSlicyoyMjiqoQRFm8kVPIqNxec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.24
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0579195-0.000748248-0.941332;FP=16373254781688884330|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037006180;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.hv5E8S0_1781153366;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.hv5E8S0_1781153366 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 11 Jun 2026 12:49:27 +0800
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
Subject: [PATCH v18 net-next 05/11] net/nebula-matrix: add channel layer
Date: Thu, 11 Jun 2026 12:49:04 +0800
Message-ID: <20260611044916.2383-6-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611044916.2383-1-illusion.wang@nebula-matrix.com>
References: <20260611044916.2383-1-illusion.wang@nebula-matrix.com>
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
	TAGGED_FROM(0.00)[bounces-297933-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tbl_key.dev:url,illusion.wang:url,nebula-matrix.com:email,nebula-matrix.com:mid,nebula-matrix.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5423266E58A

A channel management layer provides a structured approach to handle
communication between different components and drivers. Here's a summary
of its key functionalities:

1. Message Handling Framework
   Message Registration: Functions (nbl_chan_register_msg) allow dynamic
   registration of message handlers for specific message types, enabling
   extensible communication protocols.

   Message Sending/Acknowledgment: Core functions (nbl_chan_send_msg,
   nbl_chan_send_ack) handle message transmission, including asynchronous
   operations with acknowledgment (ACK) support. Received ACKs are
   processed via nbl_chan_recv_ack_msg.

   Hash-Based Handler Lookup: A hash table (`handle_hash_tbl`) stores
   message handlers for efficient O(1) lookup by message type. The
   entire table is removed via `nbl_chan_remove_msg_handler` during
   driver teardown (per-message-type removal is not implemented
   in this version).

2. Channel Types and Queue Management
   Mailbox Channel: For direct communication between PF0 and Other PF.

   Queue Initialization: Functions (nbl_chan_init_queue,
   nbl_chan_init_tx_queue) allocate resources:
   - TX descriptors: dmam_alloc_coherent()
   - RX descriptors: dmam_alloc_coherent()
   - TX/RX buffer metadata arrays (txq->buf, rxq->buf): devm_kcalloc()

   Queue Teardown: nbl_chan_teardown_queue() stops queues, cancels
   pending work items (clean_task), and destroys mutexes. It does NOT
   free DMA memory, which is released automatically via devm on driver
   remove.

   IMPORTANT - Resource Lifecycle Design:
   DMA memory allocated with dmam_alloc_coherent() is intentionally NOT
   freed in nbl_chan_teardown_queue(). The queues are allocated once
   during driver probe and freed only during driver remove (when all
   devm_ resources are released). This assumes queues are NOT dynamically
   torn down and recreated per-PF during normal operation.

   Queue Configuration: Hardware-specific queue parameters (e.g., buffer
   sizes, entry counts) are set via nbl_chan_config_queue, with hardware
   interactions delegated to hw_ops.

3. Hardware Abstraction Layer (HW Ops)
   Hardware-Specific Operations: The nbl_hw_ops structure abstracts
   hardware interactions: queue configuration (config_mailbox_txq/rxq),
   tail pointer updates (update_mailbox_queue_tail_ptr).

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |    3 +-
 .../nbl/nbl_channel/nbl_channel.c             | 1000 ++++++++++++++++-
 .../nbl/nbl_channel/nbl_channel.h             |  137 +++
 .../nebula-matrix/nbl/nbl_common/nbl_common.c |  193 ++++
 .../nebula-matrix/nbl/nbl_common/nbl_common.h |   33 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  |  146 +++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  |   57 +
 .../nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h     |    1 +
 .../nbl/nbl_include/nbl_def_channel.h         |   83 ++
 .../nbl/nbl_include/nbl_def_common.h          |   26 +
 .../nbl/nbl_include/nbl_def_hw.h              |   27 +
 .../nbl/nbl_include/nbl_include.h             |    6 +
 12 files changed, 1708 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index 63116d1d7043..c9bc060732e7 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -3,7 +3,8 @@
 
 obj-$(CONFIG_NBL) := nbl.o
 
-nbl-objs +=       nbl_channel/nbl_channel.o \
+nbl-objs +=       nbl_common/nbl_common.o \
+				nbl_channel/nbl_channel.o \
 				nbl_hw/nbl_hw_leonis/nbl_hw_leonis.o \
 				nbl_hw/nbl_hw_leonis/nbl_resource_leonis.o \
 				nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.o \
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
index c7689f0e4029..de437e34b4c8 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
@@ -2,12 +2,970 @@
 /*
  * Copyright (c) 2025 Nebula Matrix Limited.
  */
-
+#include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/bitfield.h>
 #include <linux/pci.h>
+#include <linux/bits.h>
+#include <linux/dma-mapping.h>
 #include "nbl_channel.h"
 
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
+	struct nbl_hash_tbl_key tbl_key = { 0 };
+
+	tbl_key.dev = common->dev;
+	tbl_key.key_size = sizeof(u16);
+	tbl_key.data_size = sizeof(struct nbl_chan_msg_node_data);
+	tbl_key.bucket_size = NBL_CHAN_HANDLER_TBL_BUCKET_SIZE;
+
+	chan_mgt->handle_hash_tbl = nbl_common_init_hash_table(&tbl_key);
+	if (!chan_mgt->handle_hash_tbl)
+		return -ENOMEM;
+
+	return 0;
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
+	mutex_init(&chan_info->txq_lock);
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
+	int i;
+
+	txq->desc.tx_desc =
+		dmam_alloc_coherent(dev, size, &txq->dma, GFP_KERNEL);
+	if (!txq->desc.tx_desc)
+		return -ENOMEM;
+
+	chan_info->wait = devm_kcalloc(dev, chan_info->num_txq_entries,
+				       sizeof(*chan_info->wait), GFP_KERNEL);
+	if (!chan_info->wait)
+		return -ENOMEM;
+	for (i = 0; i < chan_info->num_txq_entries; i++) {
+		init_waitqueue_head(&chan_info->wait[i].wait_queue);
+		chan_info->wait[i].status = NBL_MBX_STATUS_IDLE;
+	}
+
+	txq->buf = devm_kcalloc(dev, chan_info->num_txq_entries,
+				sizeof(*txq->buf), GFP_KERNEL);
+	if (!txq->buf)
+		return -ENOMEM;
+
+	return 0;
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
+	rxq->desc.rx_desc =
+		dmam_alloc_coherent(dev, size, &rxq->dma, GFP_KERNEL);
+	if (!rxq->desc.rx_desc) {
+		dev_err(dev,
+			"Allocate DMA for chan rx descriptor ring failed\n");
+		return -ENOMEM;
+	}
+
+	rxq->buf = devm_kcalloc(dev, chan_info->num_rxq_entries,
+				sizeof(*rxq->buf), GFP_KERNEL);
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
+
+	return err;
+}
+
+static void nbl_chan_config_queue(struct nbl_channel_mgt *chan_mgt,
+				  struct nbl_chan_info *chan_info, bool tx)
+{
+	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
+	struct nbl_hw_mgt *p = chan_mgt->hw_ops_tbl->priv;
+	int size_bwid;
+	struct nbl_chan_ring *ring;
+	dma_addr_t dma_addr;
+
+	if (tx)
+		ring = &chan_info->txq;
+	else
+		ring = &chan_info->rxq;
+	dma_addr = ring->dma;
+	if (tx) {
+		size_bwid = ilog2(chan_info->num_txq_entries);
+		hw_ops->config_mailbox_txq(p, dma_addr, size_bwid);
+	} else {
+		size_bwid = ilog2(chan_info->num_rxq_entries);
+		hw_ops->config_mailbox_rxq(p, dma_addr, size_bwid);
+	}
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
+					      &buf->pa, GFP_KERNEL);
+		if (!buf->va) {
+			dev_err(dev,
+				"Allocate buffer for chan tx queue failed\n");
+			return -ENOMEM;
+		}
+	}
+
+	txq->next_to_clean = 0;
+	txq->next_to_use = 0;
+	txq->tail_ptr = 0;
+
+	return 0;
+}
+
+static void nbl_chan_cfg_qinfo_map_table(struct nbl_channel_mgt *chan_mgt)
+{
+	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
+	struct nbl_common_info *common = chan_mgt->common;
+	struct nbl_hw_mgt *p = chan_mgt->hw_ops_tbl->priv;
+	u8 func_id;
+	u32 pf_mask;
+
+	pf_mask = hw_ops->get_host_pf_mask(p);
+	for (func_id = 0; func_id < NBL_MAX_PF; func_id++) {
+		if (!(pf_mask & (1 << func_id)))
+			hw_ops->cfg_mailbox_qinfo(p, func_id, common->hw_bus,
+						  common->devid,
+						  common->function + func_id);
+	}
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
+	struct nbl_chan_ring *rxq = &chan_info->rxq;
+	struct device *dev = chan_mgt->common->dev;
+	struct nbl_chan_rx_desc *desc;
+	struct nbl_chan_buf *buf;
+	u16 i;
+
+	for (i = 0; i < chan_info->num_rxq_entries; i++) {
+		buf = &rxq->buf[i];
+		buf->va = dmam_alloc_coherent(dev, chan_info->rxq_buf_size,
+					      &buf->pa, GFP_KERNEL);
+		if (!buf->va) {
+			dev_err(dev,
+				"Allocate buffer for chan rx queue failed\n");
+			goto err;
+		}
+	}
+
+	desc = rxq->desc.rx_desc;
+	for (i = 0; i < chan_info->num_rxq_entries - 1; i++) {
+		buf = &rxq->buf[i];
+		desc[i].buf_addr = cpu_to_le64(buf->pa);
+		desc[i].buf_len = cpu_to_le32(chan_info->rxq_buf_size);
+		desc[i].flags = cpu_to_le16(BIT(NBL_CHAN_RX_DESC_AVAIL));
+	}
+
+	rxq->next_to_clean = 0;
+	rxq->next_to_use = chan_info->num_rxq_entries - 1;
+	rxq->tail_ptr = chan_info->num_rxq_entries - 1;
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
+
+	return err;
+}
+
+static void nbl_chan_stop_queue(struct nbl_channel_mgt *chan_mgt)
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
+	struct nbl_chan_info *chan_info = chan_mgt->chan_info[chan_type];
+	struct nbl_chan_waitqueue_head *wait_head;
+	u16 i;
+
+	/* Mark the channel as abnormal to prevent new operations */
+	set_bit(NBL_CHAN_ABNORMAL, chan_info->state);
+
+	/* Stop hardware queues */
+	nbl_chan_stop_queue(chan_mgt);
+
+	/* Cancel any pending cleanup work */
+	if (chan_info->clean_task)
+		cancel_work_sync(chan_info->clean_task);
+	/*
+	 * Wake up all threads waiting for ACKs to prevent use-after-free.
+	 * This is critical because these threads may be sleeping on waitqueues
+	 * that will be freed when the device is detached.
+	 */
+	for (i = 0; i < chan_info->num_txq_entries; i++) {
+		wait_head = &chan_info->wait[i];
+		spin_lock_irq(&wait_head->status_lock);
+		/* Only wake threads that are actually waiting */
+		if (wait_head->status == NBL_MBX_STATUS_WAITING) {
+			/* Mark as timeout so waking threads know to abort */
+			wait_head->status = NBL_MBX_STATUS_TIMEOUT;
+			/* Ensure status is written */
+			smp_wmb();
+		}
+		spin_unlock_irq(&wait_head->status_lock);
+		if (wait_head->status == NBL_MBX_STATUS_TIMEOUT)
+			wake_up(&wait_head->wait_queue);
+	}
+
+	/*
+	 * Lock and unlock to ensure all in-flight callers have released the
+	 * lock. After unlock returns, we're guaranteed no other thread is
+	 * using the lock, so it's safe to destroy it.
+	 */
+	mutex_lock(&chan_info->txq_lock);
+	mutex_unlock(&chan_info->txq_lock);
+	mutex_destroy(&chan_info->txq_lock);
+
+	/* Clear the abnormal flag */
+	clear_bit(NBL_CHAN_ABNORMAL, chan_info->state);
+	return 0;
+}
+
+static int nbl_chan_setup_queue(struct nbl_channel_mgt *chan_mgt, u8 chan_type)
+{
+	struct nbl_chan_info *chan_info = chan_mgt->chan_info[chan_type];
+	struct nbl_hw_ops *hw_ops = chan_mgt->hw_ops_tbl->ops;
+	struct nbl_common_info *common = chan_mgt->common;
+	struct nbl_chan_ring *rxq = &chan_info->rxq;
+	int err;
+
+	nbl_chan_init_queue_param(chan_info, NBL_CHAN_QUEUE_LEN,
+				  NBL_CHAN_QUEUE_LEN, NBL_CHAN_BUF_LEN,
+				  NBL_CHAN_BUF_LEN);
+	err = nbl_chan_init_queue(common, chan_info);
+	if (err)
+		goto chan_setup_fail;
+	err = nbl_chan_alloc_all_bufs(chan_mgt, chan_info);
+	if (err)
+		goto chan_setup_fail;
+	nbl_chan_config_queue(chan_mgt, chan_info, true); /* tx */
+	nbl_chan_config_queue(chan_mgt, chan_info, false); /* rx */
+	NBL_UPDATE_QUEUE_TAIL_PTR(chan_info, hw_ops, chan_mgt, rxq->tail_ptr,
+				  NBL_MB_RX_QID);
+	return 0;
+chan_setup_fail:
+	mutex_destroy(&chan_info->txq_lock);
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
+	tx_desc->dstid = cpu_to_le16(param->dstid);
+	tx_desc->msg_type = cpu_to_le16(param->msg_type);
+	tx_desc->msgid = cpu_to_le16(param->msgid);
+
+	if (param->arg_len > NBL_CHAN_TX_DESC_EMBEDDED_DATA_LEN) {
+		memcpy(tx_buf->va, param->arg, param->arg_len);
+		tx_desc->buf_addr = cpu_to_le64(tx_buf->pa);
+		tx_desc->buf_len = cpu_to_le16(param->arg_len);
+		tx_desc->data_len = 0;
+		memset(tx_desc->data, 0, sizeof(tx_desc->data));
+	} else {
+		memset(tx_desc->data, 0, sizeof(tx_desc->data));
+		memcpy(tx_desc->data, param->arg, param->arg_len);
+		tx_desc->buf_len = 0;
+		tx_desc->data_len = cpu_to_le16(param->arg_len);
+	}
+	/* Ensure desc body is visible to DMA before writing AVAIL flag */
+	dma_wmb();
+	tx_desc->flags = cpu_to_le16(BIT(NBL_CHAN_TX_DESC_AVAIL));
+
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
+	int max_retries = NBL_CHAN_TX_WAIT_TIMES;
+	struct nbl_chan_tx_desc *tx_desc;
+	int retry_count = 0;
+
+	NBL_UPDATE_QUEUE_TAIL_PTR(chan_info, hw_ops, chan_mgt, txq->tail_ptr,
+				  NBL_MB_TX_QID);
+
+	tx_desc = NBL_CHAN_TX_RING_TO_DESC(txq, txq->next_to_clean);
+	while (retry_count < max_retries) {
+		if (le16_to_cpu(READ_ONCE(tx_desc->flags)) &
+		    BIT(NBL_CHAN_TX_DESC_USED)) {
+			dma_rmb();
+			break;
+		}
+
+		retry_count++;
+		if (retry_count == max_retries) {
+			dev_err(dev, "chan send message type: %d timeout\n",
+				le16_to_cpu(READ_ONCE(tx_desc->msg_type)));
+			return -ETIMEDOUT;
+		}
+		usleep_range(NBL_CHAN_TX_WAIT_US, NBL_CHAN_TX_WAIT_US_MAX);
+	}
+
+	txq->next_to_clean = txq->next_to_use;
+
+	return 0;
+}
+
+static void nbl_chan_recv_ack_msg(void *priv, u16 srcid, u16 msgid, void *data,
+				  u32 data_len)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+	struct nbl_chan_waitqueue_head *wait_head = NULL;
+	struct device *dev = chan_mgt->common->dev;
+	struct nbl_chan_info *chan_info =
+		chan_mgt->chan_info[NBL_CHAN_TYPE_MAILBOX];
+	u32 ack_datalen, ack_msgtype = 0;
+	u32 *payload = data;
+	u16 ack_msgid = 0;
+	u32 copy_len;
+
+	if (data_len > NBL_CHAN_BUF_LEN ||
+	    data_len < NBL_CHAN_ACK_HEAD_LEN * sizeof(u32)) {
+		dev_err(dev, "Invalid ACK data_len: %u\n", data_len);
+		return;
+	}
+	ack_datalen = data_len - NBL_CHAN_ACK_HEAD_LEN * sizeof(u32);
+	ack_msgtype = le16_to_cpu(*(__le16 *)(payload + NBL_CHAN_MSG_TYPE_POS));
+	ack_msgid = le16_to_cpu(*(__le16 *)(payload + NBL_CHAN_MSG_ID_POS));
+	if (FIELD_GET(NBL_CHAN_MSGID_LOC_MASK, ack_msgid) >=
+	    NBL_CHAN_QUEUE_LEN) {
+		dev_err(dev, "chan recv msg id: %d err\n", ack_msgid);
+		return;
+	}
+	wait_head =
+		&chan_info->wait[FIELD_GET(NBL_CHAN_MSGID_LOC_MASK, ack_msgid)];
+	spin_lock_irq(&wait_head->status_lock);
+	if (srcid != wait_head->dstid) {
+		/* Do not modify the status; the slot remains WAITING,
+		 * and the sender will time out normally
+		 */
+		spin_unlock_irq(&wait_head->status_lock);
+		dev_err(dev, "ACK srcid=%u != dstid=%u, rejecting\n", srcid,
+			wait_head->dstid);
+		return;
+	}
+	if (wait_head->status != NBL_MBX_STATUS_WAITING) {
+		spin_unlock_irq(&wait_head->status_lock);
+		dev_err(dev,
+			"Skip ack with invalid status, wait_head msgtype:%u msg_index:%u status:%d ack_data_len:%d, ack msgtype:%u msgid:%u datalen:%d\n",
+			wait_head->msg_type, wait_head->msg_index,
+			wait_head->status, wait_head->ack_data_len, ack_msgtype,
+			ack_msgid, ack_datalen);
+		return;
+	}
+
+	if (wait_head->msg_type != ack_msgtype) {
+		/*
+		 * Mismatched ACK. Restore state to WAITING so the original
+		 * sender will time out and not reuse the slot.
+		 */
+		wait_head->status = NBL_MBX_STATUS_WAITING;
+
+		dev_err(dev,
+			"Skip ack msg type donot match, wait_head msgtype:%u msg_index:%u status:%d ack_data_len:%d, ack msgtype:%u msgid:%u datalen:%d\n",
+			wait_head->msg_type, wait_head->msg_index,
+			wait_head->status, wait_head->ack_data_len, ack_msgtype,
+			ack_msgid, ack_datalen);
+		spin_unlock_irq(&wait_head->status_lock);
+		/* Wake up the sender to let it know the ACK was invalid */
+		wake_up(&wait_head->wait_queue);
+		return;
+	}
+	if (FIELD_GET(NBL_CHAN_MSGID_INDEX_MASK, ack_msgid) !=
+	    wait_head->msg_index) {
+		/*
+		 * Stale ACK. Restore state to WAITING so the original
+		 * sender will time out and not reuse the slot.
+		 */
+		wait_head->status = NBL_MBX_STATUS_WAITING;
+
+		dev_err(dev,
+			"Stale ACK: expected index=%u, got msgid %u\n",
+			wait_head->msg_index, ack_msgid);
+		spin_unlock_irq(&wait_head->status_lock);
+		/* Wake up the sender to let it know the ACK was stale */
+		wake_up(&wait_head->wait_queue);
+		return;
+	}
+
+	wait_head->ack_err =
+		le32_to_cpu(*(__le32 *)(payload + NBL_CHAN_ACK_RET_POS));
+
+	copy_len = min_t(u32, wait_head->ack_data_len, ack_datalen);
+	if (wait_head->ack_err >= 0 && copy_len > 0) {
+		if (!wait_head->ack_data) {
+			dev_err(dev, "ACK payload dropped: ack_data is NULL\n");
+			wait_head->ack_data_len = 0;
+			goto ack_done;
+		}
+		memcpy((char *)wait_head->ack_data,
+		       payload + NBL_CHAN_ACK_HEAD_LEN, copy_len);
+		wait_head->ack_data_len = (u16)copy_len;
+	} else {
+		wait_head->ack_data_len = 0;
+	}
+ack_done:
+	/*
+	 * Ensure all writes to ack_data and ack_data_len are completed
+	 * before setting the 'acked' flag. This prevents other threads
+	 * from observing stale or partially updated data.
+	 */
+	smp_wmb();
+	wait_head->acked = 1;
+	spin_unlock_irq(&wait_head->status_lock);
+	if (wait_head->acked)
+		wake_up(&wait_head->wait_queue);
+}
+
+static void nbl_chan_recv_msg(struct nbl_channel_mgt *chan_mgt, void *data)
+{
+	struct device *dev = chan_mgt->common->dev;
+	struct nbl_chan_msg_node_data *msg_handler;
+	u16 msg_type, payload_len, srcid, msgid;
+	struct nbl_chan_tx_desc *tx_desc;
+	void *payload;
+
+	tx_desc = data;
+	msg_type = le16_to_cpu(tx_desc->msg_type);
+	dev_dbg(dev, "recv msg_type: %d\n", msg_type);
+
+	srcid = le16_to_cpu(tx_desc->srcid);
+	msgid = le16_to_cpu(tx_desc->msgid);
+	/* Only check if the value exceeds the maximum, relying on the hash
+	 * table to filter invalid message IDs.
+	 * The gap values are reserved for future protocol extensions.
+	 */
+	if (msg_type >= NBL_CHAN_MSG_MAILBOX_MAX)
+		return;
+
+	if (tx_desc->data_len) {
+		payload_len = le16_to_cpu(tx_desc->data_len);
+		if (payload_len > NBL_CHAN_TX_DESC_EMBEDDED_DATA_LEN) {
+			dev_err(dev,
+				"data_len=%u exceeds embedded buffer size=%u\n",
+				payload_len,
+				NBL_CHAN_TX_DESC_EMBEDDED_DATA_LEN);
+			return;
+		}
+		payload = tx_desc->data;
+	} else {
+		payload_len = le16_to_cpu(tx_desc->buf_len);
+		if (payload_len > NBL_CHAN_BUF_LEN - sizeof(*tx_desc)) {
+			dev_err(dev,
+				"buf_len=%u exceeds external buffer size=%zu\n",
+				payload_len,
+				NBL_CHAN_BUF_LEN - sizeof(*tx_desc));
+			return;
+		}
+		payload = tx_desc + 1;
+	}
+
+	msg_handler =
+		nbl_common_get_hash_node(chan_mgt->handle_hash_tbl, &msg_type);
+	if (!msg_handler || !msg_handler->func) {
+		dev_err(dev,
+			"No handler for msg_type: %u (srcid=%u, msgid=%u)\n",
+			msg_type, srcid, msgid);
+		return;
+	}
+	msg_handler->func(msg_handler->priv, srcid, msgid, payload,
+			  payload_len);
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
+	rx_desc->buf_addr = cpu_to_le64(rx_buf->pa);
+	rx_desc->buf_len = cpu_to_le32(chan_info->rxq_buf_size);
+
+	/*
+	 * DMA Write Memory Barrier:
+	 * Ensures all previous DMA-mapped writes (buffer address/length)
+	 * are completed before the descriptor flags are updated.
+	 * This prevents hardware from seeing a partially updated descriptor
+	 * where flags are set but buffer info isn't ready yet.
+	 */
+	dma_wmb();
+
+	rx_desc->flags = cpu_to_le16(BIT(NBL_CHAN_RX_DESC_AVAIL));
+
+	/*
+	 * CPU Write Memory Barrier:
+	 * Ensures the descriptor flags update is visible to other CPUs
+	 * before we update the tail pointer. This is important for:
+	 * 1. Software cleaning threads that might be checking the tail pointer
+	 * 2. Maintaining proper memory ordering in multi-core systems
+	 */
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
+/*
+ * Since the channel operates in either polling mode or interrupt mode
+ * (mutually exclusive, configured via set_queue_state), nbl_chan_clean_queue
+ * is always called in a serialized manner:
+ * 1. In polling mode: nbl_chan_clean_queue is called directly within
+ * nbl_chan_send_msg, in the same thread after txq_lock has been released.
+ * No other thread can call it concurrently.
+ * 2. In interrupt mode: nbl_chan_clean_queue is called from a workqueue
+ * (nbl_dev_clean_mailbox_task). Linux workqueue guarantees that the same
+ * work item never runs concurrently on multiple CPUs.
+ * Therefore, at any given time, only one execution context can be inside
+ * nbl_chan_clean_queue. There is no concurrency, and thus no need for
+ * locking
+ */
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
+	while (le16_to_cpu(rx_desc->flags) & BIT(NBL_CHAN_RX_DESC_USED)) {
+		if (!(le16_to_cpu(rx_desc->flags) &
+		      BIT(NBL_CHAN_RX_DESC_WRITE)))
+			dev_dbg(dev,
+				"mailbox rx flag 0x%x has no NBL_CHAN_RX_DESC_WRITE\n",
+				le16_to_cpu(rx_desc->flags));
+
+		dma_rmb();
+		nbl_chan_recv_msg(chan_mgt, rx_buf->va);
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
+	struct nbl_chan_info *chan_info = chan_mgt->chan_info[chan_type];
+
+	if (!test_bit(NBL_CHAN_INTERRUPT_READY, chan_info->state))
+		return;
+
+	nbl_chan_clean_queue(chan_mgt, chan_info);
+}
+
+static int nbl_chan_get_msg_id(struct nbl_chan_info *chan_info,
+			       u16 *msgid)
+{
+	int valid_loc = chan_info->wait_head_index, i;
+	struct nbl_chan_waitqueue_head *wait = NULL;
+	int status;
+
+	for (i = 0; i < NBL_CHAN_QUEUE_LEN; i++) {
+		wait = &chan_info->wait[valid_loc];
+		status = wait->status;
+		if (status == NBL_MBX_STATUS_IDLE ||
+		    status == NBL_MBX_STATUS_TIMEOUT) {
+			wait->msg_index = NBL_NEXT_ID(wait->msg_index,
+						      NBL_CHAN_MSG_INDEX_MAX);
+			*msgid =
+				FIELD_PREP(NBL_CHAN_MSGID_INDEX_MASK,
+					   wait->msg_index) |
+				FIELD_PREP(NBL_CHAN_MSGID_LOC_MASK, valid_loc);
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
+	/*
+	 * the current NBL_CHAN_QUEUE_LEN configuration meets the design
+	 * requirements and theoretically should not return errors, the
+	 * following scenarios may still cause the waiting queue to
+	 * become full:
+	 * High-concurrency scenarios:
+	 * If the sender (calling nbl_chan_send_msg()) generates messages
+	 * at a rate far exceeding the receiver's ability to process
+	 * acknowledgments (ACKs),the waiting queue may become fully occupied.
+	 * Delayed or failed ACK handling by the receiver:
+	 * The receiver may fail to send ACKs in a timely manner due to
+	 * processing delays, blocking, or faults, causing the sender's
+	 * waiting queue slots to remain occupied for an extended period.
+	 */
+	return -EAGAIN;
+}
+
+static int nbl_chan_send_msg(struct nbl_channel_mgt *chan_mgt,
+			     struct nbl_chan_send_info *chan_send)
+{
+	struct nbl_common_info *common = chan_mgt->common;
+	struct nbl_chan_waitqueue_head *wait_head;
+	struct nbl_chan_tx_param tx_param = { 0 };
+	u16 msgid = 0;
+	int i = NBL_CHAN_TX_WAIT_ACK_TIMES, ret;
+	struct nbl_chan_info *chan_info =
+		chan_mgt->chan_info[NBL_CHAN_TYPE_MAILBOX];
+	struct device *dev = common->dev;
+
+	if (test_bit(NBL_CHAN_ABNORMAL, chan_info->state))
+		return -EIO;
+	if (chan_send->resp_len > NBL_CHAN_BUF_LEN) {
+		dev_err(dev, "resp_len %zu exceeds max %d\n",
+			chan_send->resp_len, NBL_CHAN_BUF_LEN);
+		return -EINVAL;
+	}
+	mutex_lock(&chan_info->txq_lock);
+
+	ret = nbl_chan_get_msg_id(chan_info, &msgid);
+	if (ret) {
+		mutex_unlock(&chan_info->txq_lock);
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
+	tx_param.msgid = msgid;
+
+	ret = nbl_chan_update_txqueue(chan_mgt, chan_info, &tx_param);
+	if (ret) {
+		mutex_unlock(&chan_info->txq_lock);
+		dev_err(dev,
+			"Channel tx queue full, send msgtype:%u to dstid:%u failed\n",
+			chan_send->msg_type, chan_send->dstid);
+		return ret;
+	}
+
+	wait_head =
+		&chan_info->wait[FIELD_GET(NBL_CHAN_MSGID_LOC_MASK, msgid)];
+	spin_lock_irq(&wait_head->status_lock);
+	wait_head->acked = 0;
+	wait_head->ack_data = chan_send->resp;
+	wait_head->ack_data_len = chan_send->resp_len;
+	wait_head->msg_type = chan_send->msg_type;
+	wait_head->msg_index = FIELD_GET(NBL_CHAN_MSGID_INDEX_MASK, msgid);
+	wait_head->dstid = chan_send->dstid;
+	/* Ensure all fields above are visible before status update, so receiver
+	 * won't see WAITING with stale data
+	 */
+	smp_wmb();
+	wait_head->status = chan_send->ack ? NBL_MBX_STATUS_WAITING :
+					     NBL_MBX_STATUS_IDLE;
+	spin_unlock_irq(&wait_head->status_lock);
+
+	ret = nbl_chan_kick_tx_ring(chan_mgt, chan_info);
+	mutex_unlock(&chan_info->txq_lock);
+	if (ret) {
+		mutex_lock(&chan_info->txq_lock);
+		spin_lock_irq(&wait_head->status_lock);
+		wait_head->status = NBL_MBX_STATUS_TIMEOUT;
+		spin_unlock_irq(&wait_head->status_lock);
+		mutex_unlock(&chan_info->txq_lock);
+		return ret;
+	}
+
+	if (!chan_send->ack)
+		return 0;
+
+	if (test_bit(NBL_CHAN_INTERRUPT_READY, chan_info->state)) {
+		spin_lock_irq(&wait_head->status_lock);
+		while (!wait_head->acked) {
+			spin_unlock_irq(&wait_head->status_lock);
+			ret = wait_event_timeout(wait_head->wait_queue, 0,
+						 NBL_CHAN_ACK_WAIT_TIME);
+			spin_lock_irq(&wait_head->status_lock);
+
+			if (ret == 0) {
+				if (wait_head->status ==
+				    NBL_MBX_STATUS_WAITING) {
+					wait_head->status =
+						NBL_MBX_STATUS_TIMEOUT;
+					wait_head->acked = 0;
+					wait_head->ack_data = NULL;
+					wait_head->ack_data_len = 0;
+				}
+				spin_unlock_irq(&wait_head->status_lock);
+				dev_err(dev,
+					"Channel waiting ack failed, message type: %d, msg id: %u\n",
+					chan_send->msg_type, msgid);
+				return -ETIMEDOUT;
+			}
+
+			if (wait_head->acked)
+				break;
+		}
+		/*
+		 * ensure that after observing 'acked == 1', all
+		 * subsequent reads (ack_data_len, ack_err) observe
+		 * the latest values written by the sender
+		 * (nbl_chan_recv_ack_msg()). This prevents stale reads
+		 * of ACK data or status.
+		 */
+		smp_rmb();
+		chan_send->ack_len = wait_head->ack_data_len;
+		ret = wait_head->ack_err;
+		wait_head->acked = 0;
+		wait_head->status = NBL_MBX_STATUS_IDLE;
+		spin_unlock_irq(&wait_head->status_lock);
+
+		return ret;
+	}
+
+	/*polling wait mailbox ack*/
+
+	while (i--) {
+		nbl_chan_clean_queue(chan_mgt, chan_info);
+
+		spin_lock_irq(&wait_head->status_lock);
+		if (wait_head->acked) {
+			/*
+			 * ensure that after observing 'acked == 1', all
+			 * subsequent reads (ack_data_len, ack_err) observe
+			 * the latest values written by the sender
+			 * (nbl_chan_recv_ack_msg()). This prevents stale reads
+			 * of ACK data or status.
+			 */
+			smp_rmb();
+			chan_send->ack_len = wait_head->ack_data_len;
+			ret = wait_head->ack_err;
+			wait_head->acked = 0;
+			wait_head->status = NBL_MBX_STATUS_IDLE;
+			spin_unlock_irq(&wait_head->status_lock);
+			return ret;
+		}
+		spin_unlock_irq(&wait_head->status_lock);
+
+		usleep_range(NBL_CHAN_TX_WAIT_ACK_US_MIN,
+			     NBL_CHAN_TX_WAIT_ACK_US_MAX);
+	}
+
+	spin_lock_irq(&wait_head->status_lock);
+	wait_head->acked = 0;
+	wait_head->status = NBL_MBX_STATUS_TIMEOUT;
+	spin_unlock_irq(&wait_head->status_lock);
+
+	dev_err(dev,
+		"Channel polling ack failed, message type: %d msg id: %u\n",
+		chan_send->msg_type, msgid);
+	return -ETIMEDOUT;
+}
+
+static int nbl_chan_send_ack(struct nbl_channel_mgt *chan_mgt,
+			     struct nbl_chan_ack_info *chan_ack)
+{
+	size_t head_len = NBL_CHAN_ACK_HEAD_LEN * sizeof(u32);
+	size_t data_len = chan_ack->data_len;
+	struct nbl_chan_send_info chan_send;
+	__le32 *tmp;
+	size_t len;
+	int ret;
+
+	if (data_len >
+	    NBL_CHAN_BUF_LEN - sizeof(struct nbl_chan_tx_desc) - head_len)
+		return -EINVAL;
+
+	len = head_len + data_len;
+	tmp = kzalloc(len, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	*(__le16 *)&tmp[NBL_CHAN_MSG_TYPE_POS] =
+		cpu_to_le16(chan_ack->msg_type);
+	*(__le16 *)&tmp[NBL_CHAN_MSG_ID_POS] = cpu_to_le16(chan_ack->msgid);
+	tmp[NBL_CHAN_ACK_RET_POS] = cpu_to_le32(chan_ack->err);
+	if (chan_ack->data && chan_ack->data_len)
+		memcpy(&tmp[NBL_CHAN_ACK_HEAD_LEN], chan_ack->data,
+		       chan_ack->data_len);
+
+	NBL_CHAN_SEND(chan_send, chan_ack->dstid, NBL_CHAN_MSG_ACK, tmp, len,
+		      NULL, 0, 0);
+	ret = nbl_chan_send_msg(chan_mgt, &chan_send);
+	kfree(tmp);
+
+	return ret;
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
+	struct nbl_chan_info *chan_info = chan_mgt->chan_info[chan_type];
+
+	return chan_info ? true : false;
+}
+
+static void nbl_chan_register_chan_task(struct nbl_channel_mgt *chan_mgt,
+					u8 chan_type, struct work_struct *task)
+{
+	struct nbl_chan_info *chan_info = chan_mgt->chan_info[chan_type];
+
+	chan_info->clean_task = task;
+}
+
+static void nbl_chan_set_queue_state(struct nbl_channel_mgt *chan_mgt,
+				     enum nbl_chan_state state, u8 chan_type,
+				     u8 set)
+{
+	struct nbl_chan_info *chan_info = chan_mgt->chan_info[chan_type];
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
+	.cfg_chan_qinfo_map_table	= nbl_chan_cfg_qinfo_map_table,
+	.check_queue_exist		= nbl_chan_check_queue_exist,
+	.setup_queue			= nbl_chan_setup_queue,
+	.teardown_queue			= nbl_chan_teardown_queue,
+	.clean_queue_subtask		= nbl_chan_clean_queue_subtask,
+	.register_chan_task		= nbl_chan_register_chan_task,
+	.set_queue_state		= nbl_chan_set_queue_state,
 };
 
 static struct nbl_channel_mgt *
@@ -18,6 +976,7 @@ nbl_chan_setup_chan_mgt(struct nbl_adapter *adapter)
 	struct device *dev = &adapter->pdev->dev;
 	struct nbl_channel_mgt *chan_mgt;
 	struct nbl_chan_info *mailbox;
+	int ret;
 
 	chan_mgt = devm_kzalloc(dev, sizeof(*chan_mgt), GFP_KERNEL);
 	if (!chan_mgt)
@@ -32,6 +991,10 @@ nbl_chan_setup_chan_mgt(struct nbl_adapter *adapter)
 	mailbox->chan_type = NBL_CHAN_TYPE_MAILBOX;
 	chan_mgt->chan_info[NBL_CHAN_TYPE_MAILBOX] = mailbox;
 
+	ret = nbl_chan_init_msg_handler(chan_mgt);
+	if (ret)
+		return ERR_PTR(-ENOMEM);
+
 	return chan_mgt;
 }
 
@@ -39,6 +1002,7 @@ static struct nbl_channel_ops_tbl *
 nbl_chan_setup_ops(struct device *dev, struct nbl_channel_mgt *chan_mgt)
 {
 	struct nbl_channel_ops_tbl *chan_ops_tbl;
+	int ret;
 
 	chan_ops_tbl = devm_kzalloc(dev, sizeof(*chan_ops_tbl), GFP_KERNEL);
 	if (!chan_ops_tbl)
@@ -47,6 +1011,11 @@ nbl_chan_setup_ops(struct device *dev, struct nbl_channel_mgt *chan_mgt)
 	chan_ops_tbl->ops = &chan_ops;
 	chan_ops_tbl->priv = chan_mgt;
 
+	ret = nbl_chan_register_msg(chan_mgt, NBL_CHAN_MSG_ACK,
+				    nbl_chan_recv_ack_msg, chan_mgt);
+	if (ret)
+		return ERR_PTR(-ENOMEM);
+
 	return chan_ops_tbl;
 }
 
@@ -57,22 +1026,47 @@ int nbl_chan_init_common(struct nbl_adapter *adap)
 	struct nbl_channel_mgt *chan_mgt;
 	int ret;
 
+	BUILD_BUG_ON(sizeof(struct nbl_chan_param_cfg_msix_map) != 8);
+	BUILD_BUG_ON(sizeof(struct nbl_chan_param_set_mailbox_irq) != 4);
+	BUILD_BUG_ON(sizeof(struct nbl_chan_param_get_vsi_id) != 4);
+	BUILD_BUG_ON(sizeof(struct nbl_chan_param_get_eth_id) != 8);
+	BUILD_BUG_ON(sizeof(struct nbl_board_port_info) != 8);
 	chan_mgt = nbl_chan_setup_chan_mgt(adap);
 	if (IS_ERR(chan_mgt)) {
 		ret = PTR_ERR(chan_mgt);
-		return ret;
+		goto exit;
 	}
 
 	chan_ops_tbl = nbl_chan_setup_ops(dev, chan_mgt);
 	if (IS_ERR(chan_ops_tbl)) {
 		ret = PTR_ERR(chan_ops_tbl);
-		return ret;
+		goto exit;
 	}
 	adap->intf.channel_ops_tbl = chan_ops_tbl;
 	adap->core.chan_mgt = chan_mgt;
 	return 0;
+
+exit:
+	if (!IS_ERR(chan_mgt)) {
+		nbl_chan_remove_msg_handler(chan_mgt);
+		adap->core.chan_mgt = NULL;
+	}
+	return ret;
 }
 
 void nbl_chan_remove_common(struct nbl_adapter *adap)
 {
+	struct nbl_channel_mgt *chan_mgt = adap->core.chan_mgt;
+
+	if (chan_mgt) {
+		nbl_chan_remove_msg_handler(chan_mgt);
+		adap->core.chan_mgt = NULL;
+	}
+	/*
+	 * Note: nbl_chan_remove_common() does not call teardown_queue() here.
+	 * The work cancellation (cancel_work_sync) is already handled in
+	 * nbl_dev_remove() -> nbl_dev_remove_common_dev()
+	 * -> nbl_dev_remove_chan_queue()-> teardown_queue(),
+	 * which is guaranteed to be called before this function.
+	 */
 }
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
index 637912d1e806..01e1a56ef0d1 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
@@ -15,10 +15,147 @@
 #include "../nbl_include/nbl_def_common.h"
 #include "../nbl_core.h"
 
+#define NBL_CHAN_TX_RING_TO_DESC(tx_ring, i) \
+	(&((((tx_ring)->desc.tx_desc))[i]))
+#define NBL_CHAN_RX_RING_TO_DESC(rx_ring, i) \
+	(&((((rx_ring)->desc.rx_desc))[i]))
+#define NBL_CHAN_TX_RING_TO_BUF(tx_ring, i) (&(((tx_ring)->buf)[i]))
+#define NBL_CHAN_RX_RING_TO_BUF(rx_ring, i) (&(((rx_ring)->buf)[i]))
+
+#define NBL_CHAN_TX_WAIT_US			100
+#define NBL_CHAN_TX_WAIT_US_MAX			120
+#define NBL_CHAN_TX_WAIT_TIMES			100
+#define NBL_CHAN_TX_WAIT_ACK_US_MIN		100
+#define NBL_CHAN_TX_WAIT_ACK_US_MAX		120
+#define NBL_CHAN_TX_WAIT_ACK_TIMES		50000
+#define NBL_CHAN_QUEUE_LEN			256
+#define NBL_CHAN_CLEAN_BATCH_SIZE		32
+#define NBL_CHAN_BUF_LEN			4096
+#define NBL_CHAN_TX_DESC_EMBEDDED_DATA_LEN	16
+
+#define NBL_CHAN_TX_DESC_AVAIL			0
+#define NBL_CHAN_TX_DESC_USED			1
+#define NBL_CHAN_RX_DESC_WRITE			1
+#define NBL_CHAN_RX_DESC_AVAIL			3
+#define NBL_CHAN_RX_DESC_USED			4
+
+#define NBL_CHAN_ACK_HEAD_LEN			3
+#define NBL_CHAN_ACK_RET_POS			2
+#define NBL_CHAN_MSG_ID_POS			1
+#define NBL_CHAN_MSG_TYPE_POS			0
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
+	NBL_MBX_STATUS_TIMEOUT,
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
+	__le16 flags;
+	__le16 srcid;
+	__le16 dstid;
+	__le16 data_len;
+	__le16 buf_len;
+	__le64 buf_addr;
+	__le16 msg_type;
+	u8 data[16];
+	__le16 msgid;
+	u8 rsv[26];
+} __packed;
+
+struct nbl_chan_rx_desc {
+	__le16 flags;
+	__le32 buf_len;
+	__le16 buf_id;
+	__le64 buf_addr;
+} __packed;
+
+union nbl_chan_desc_ptr {
+	struct nbl_chan_tx_desc *tx_desc;
+	struct nbl_chan_rx_desc *rx_desc;
+};
+
+struct nbl_chan_ring {
+	union nbl_chan_desc_ptr desc;
+	struct nbl_chan_buf *buf;
+	u16 next_to_use;
+	u16 tail_ptr;
+	u16 next_to_clean;
+	dma_addr_t dma;
+};
+
+#define NBL_CHAN_MSG_INDEX_MAX 63
+
+#define NBL_CHAN_MSGID_INDEX_MASK GENMASK(5, 0)
+#define NBL_CHAN_MSGID_LOC_MASK GENMASK(13, 6)
+
+struct nbl_chan_waitqueue_head {
+	struct wait_queue_head wait_queue;
+	char *ack_data;
+	int acked;
+	int ack_err;
+	u16 ack_data_len;
+	u16 msg_type;
+	/*
+	 * Spinlock protecting all fields.
+	 * Must be held when reading/writing: status, acked, ack_err,
+	 * ack_data_len, etc.
+	 * The lock ensures atomic updates of these fields and
+	 * proper memory ordering with smp_wmb()/smp_rmb().
+	 */
+	spinlock_t status_lock;
+	int status;
+	u8 msg_index;
+	u16 dstid;
+};
+
 struct nbl_chan_info {
+	struct nbl_chan_ring txq;
+	struct nbl_chan_ring rxq;
+	struct nbl_chan_waitqueue_head *wait;
+	/*
+	 *Protects access to the TX queue (txq) and related metadata.
+	 *This mutex ensures exclusive access when updating the TX queue
+	 */
+	struct mutex txq_lock;
+	struct work_struct *clean_task;
+	u16 wait_head_index;
+	u16 num_txq_entries;
+	u16 num_rxq_entries;
+	u16 txq_buf_size;
+	u16 rxq_buf_size;
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
index 000000000000..2954cbbe0f95
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+
+#include <linux/device.h>
+#include "nbl_common.h"
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
+#define FNV_PRIME_32 0x01000193
+#define FNV_OFFSET_32 0x811C9DC5
+static u32 nbl_common_calc_hash_key(void *key, u32 key_size, u32 bucket_size)
+{
+	u32 hash = FNV_OFFSET_32;
+	u8 *p = (u8 *)key;
+	u32 i;
+
+	if (bucket_size == 0 || bucket_size == NBL_HASH_TBL_LIST_BUCKET_SIZE)
+		return 0;
+
+	for (i = 0; i < key_size; i++) {
+		hash ^= p[i];
+		hash *= FNV_PRIME_32;
+	}
+	/* Use bitmask if bucket_size is a power of 2 */
+	if ((bucket_size & (bucket_size - 1)) == 0)
+		return hash & (bucket_size - 1);
+	else
+		return hash % bucket_size;
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
+	tbl_mgt = devm_kzalloc(key->dev, sizeof(*tbl_mgt), GFP_KERNEL);
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
+ * Allocate a hash node and add to the hash table.
+ *
+ * Note: The hash table is protected by the caller's mutex (txq_lock),
+ * not lock-free. The "single context" comment in nbl_common_alloc_hash_node
+ * refers to: this function is only called during init from
+ * nbl_chan_init_msg_handler, so there is no concurrent mutation during init.
+ * After init, the table is read-only (no unregister API), so no lock is needed
+ * for lookups either.
+ *
+ * The tbl_mgt and bucket array are devm-allocated, so they are automatically
+ * freed on device detach. Only the hash nodes themselves need explicit cleanup.
+ */
+int nbl_common_alloc_hash_node(struct nbl_hash_tbl_mgt *tbl_mgt, void *key,
+			       void *data, void **out_data)
+{
+	struct nbl_hash_entry_node *hash_node;
+	u16 data_size;
+	u32 hash_val;
+	u16 key_size;
+
+	hash_node = devm_kzalloc(tbl_mgt->tbl_key.dev, sizeof(*hash_node),
+				 GFP_KERNEL);
+	if (!hash_node)
+		return -ENOMEM;
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
+	devm_kfree(tbl_mgt->tbl_key.dev, hash_node->key);
+alloc_key_failed:
+	devm_kfree(tbl_mgt->tbl_key.dev, hash_node);
+	return -ENOMEM;
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
+static void nbl_common_detach_hash_node(struct nbl_hash_tbl_mgt *tbl_mgt,
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
+ * Free all hash nodes in the table.
+ *
+ * Note: This function only frees the per-node allocations (key/data/node).
+ * The table skeleton (tbl_mgt + bucket array) is devm-allocated and will be
+ * automatically released by the devm framework on device detach. No need
+ * to free them here.
+ */
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
+			nbl_common_detach_hash_node(tbl_mgt, hash_node);
+		}
+	}
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.h
new file mode 100644
index 000000000000..7a91d4eca105
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_COMMON_H_
+#define _NBL_COMMON_H_
+
+#include <linux/types.h>
+
+#include "../nbl_include/nbl_include.h"
+#include "../nbl_include/nbl_def_common.h"
+
+/* list only need one bucket size */
+#define NBL_HASH_TBL_LIST_BUCKET_SIZE 1
+
+struct nbl_common_wq_mgt {
+	struct workqueue_struct *ctrl_dev_wq;
+};
+
+struct nbl_hash_tbl_mgt {
+	struct nbl_hash_tbl_key tbl_key;
+	struct hlist_head *hash;
+	u16 node_num;
+};
+
+struct nbl_hash_entry_node {
+	struct hlist_node node;
+	void *key;
+	void *data;
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
index 08ddbf5b0eb2..1d25d7770d8d 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -7,9 +7,153 @@
 #include <linux/bits.h>
 #include <linux/io.h>
 #include <linux/spinlock.h>
+#include <linux/bitfield.h>
 #include "nbl_hw_leonis.h"
 
+static void nbl_hw_write_mbx_regs(struct nbl_hw_mgt *hw_mgt, u64 reg,
+				  const u32 *data, u32 len)
+{
+	u32 i;
+
+	if (len % 4)
+		return;
+
+	for (i = 0; i < len / 4; i++)
+		nbl_mbx_wr32(hw_mgt, reg + i * sizeof(u32), data[i]);
+}
+
+static void nbl_hw_rd_regs(struct nbl_hw_mgt *hw_mgt, u64 reg, u32 *data,
+			   u32 len)
+{
+	u32 size = len / 4;
+	u32 i;
+
+	if (len % 4)
+		return;
+
+	spin_lock(&hw_mgt->reg_lock);
+
+	for (i = 0; i < size; i++)
+		data[i] = rd32(hw_mgt->hw_addr, reg + i * sizeof(u32));
+	spin_unlock(&hw_mgt->reg_lock);
+}
+
+static void nbl_hw_wr_regs(struct nbl_hw_mgt *hw_mgt, u64 reg, const u32 *data,
+			   u32 len)
+{
+	u32 size = len / 4;
+	u32 i;
+
+	if (len % 4)
+		return;
+	spin_lock(&hw_mgt->reg_lock);
+	for (i = 0; i < size; i++)
+		wr32(hw_mgt->hw_addr, reg + i * sizeof(u32), data[i]);
+	spin_unlock(&hw_mgt->reg_lock);
+}
+
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
+	struct nbl_mailbox_qinfo_cfg_table cfg_tbl;
+
+	memset(&cfg_tbl, 0, sizeof(cfg_tbl));
+	cfg_tbl.data[3] = FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_RST_MASK, 1);
+	nbl_hw_write_mbx_regs(hw_mgt, NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR,
+			      cfg_tbl.data, sizeof(cfg_tbl));
+
+	cfg_tbl.data[0] = lower_32_bits(dma_addr);
+	cfg_tbl.data[1] = upper_32_bits(dma_addr);
+	cfg_tbl.data[2] = FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_SIZE_BWID_MASK,
+				     size_bwid);
+	cfg_tbl.data[3] = FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_RST_MASK, 0) |
+			  FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_EN_MASK, 1);
+	nbl_hw_write_mbx_regs(hw_mgt, NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR,
+			      cfg_tbl.data, sizeof(cfg_tbl));
+}
+
+static void nbl_hw_config_mailbox_txq(struct nbl_hw_mgt *hw_mgt,
+				      dma_addr_t dma_addr, int size_bwid)
+{
+	struct nbl_mailbox_qinfo_cfg_table cfg_tbl;
+
+	memset(&cfg_tbl, 0, sizeof(cfg_tbl));
+	cfg_tbl.data[3] = FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_RST_MASK, 1);
+	nbl_hw_write_mbx_regs(hw_mgt, NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR,
+			      cfg_tbl.data, sizeof(cfg_tbl));
+
+	cfg_tbl.data[0] = lower_32_bits(dma_addr);
+	cfg_tbl.data[1] = upper_32_bits(dma_addr);
+	cfg_tbl.data[2] = FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_SIZE_BWID_MASK,
+				     size_bwid);
+	cfg_tbl.data[3] = FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_RST_MASK, 0) |
+			  FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_EN_MASK, 1);
+	nbl_hw_write_mbx_regs(hw_mgt, NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR,
+			      cfg_tbl.data, sizeof(cfg_tbl));
+}
+
+static void nbl_hw_stop_mailbox_rxq(struct nbl_hw_mgt *hw_mgt)
+{
+	struct nbl_mailbox_qinfo_cfg_table cfg_tbl;
+
+	memset(&cfg_tbl, 0, sizeof(cfg_tbl));
+	cfg_tbl.data[3] = FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_RST_MASK, 1);
+	nbl_hw_write_mbx_regs(hw_mgt, NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR,
+			      cfg_tbl.data, sizeof(cfg_tbl));
+}
+
+static void nbl_hw_stop_mailbox_txq(struct nbl_hw_mgt *hw_mgt)
+{
+	struct nbl_mailbox_qinfo_cfg_table cfg_tbl;
+
+	memset(&cfg_tbl, 0, sizeof(cfg_tbl));
+	cfg_tbl.data[3] = FIELD_PREP(NBL_MAILBOX_QINFO_CFG_QUEUE_RST_MASK, 1);
+	nbl_hw_write_mbx_regs(hw_mgt, NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR,
+			      cfg_tbl.data, sizeof(cfg_tbl));
+}
+
+static u32 nbl_hw_get_host_pf_mask(struct nbl_hw_mgt *hw_mgt)
+{
+	u32 data;
+
+	nbl_hw_rd_regs(hw_mgt, NBL_PCIE_HOST_K_PF_MASK_REG, &data,
+		       sizeof(data));
+	return data;
+}
+
+static void nbl_hw_cfg_mailbox_qinfo(struct nbl_hw_mgt *hw_mgt, u16 func_id,
+				     u8 bus, u8 devid, u8 function)
+{
+	u32 data = 0;
+
+	data = FIELD_PREP(NBL_MAILBOX_QINFO_MAP_FUNCTION_MASK, function) |
+	       FIELD_PREP(NBL_MAILBOX_QINFO_MAP_DEVID_MASK, devid) |
+	       FIELD_PREP(NBL_MAILBOX_QINFO_MAP_BUS_MASK, bus);
+	nbl_hw_wr_regs(hw_mgt, NBL_MAILBOX_QINFO_MAP_REG_ARR(func_id), &data,
+		       sizeof(data));
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
@@ -105,6 +249,8 @@ int nbl_hw_init_leonis(struct nbl_adapter *adapter)
 		goto mailbox_ioremap_err;
 	}
 
+	spin_lock_init(&hw_mgt->reg_lock);
+
 	hw_ops_tbl = nbl_hw_setup_ops(common, hw_mgt);
 	if (IS_ERR(hw_ops_tbl)) {
 		ret = PTR_ERR(hw_ops_tbl);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
index a554900d9ca6..d2c85175554d 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
@@ -12,4 +12,61 @@
 #include "../nbl_hw_reg.h"
 
 #define NBL_BYTES_IN_REG 4
+
+/*  ----------  REG BASE ADDR  ----------  */
+/* Interface modules base addr */
+#define NBL_INTF_HOST_PCOMPLETER_BASE		0x00f08000
+#define NBL_INTF_HOST_PADPT_BASE		0x00f4c000
+#define NBL_INTF_HOST_MAILBOX_BASE		0x00fb0000
+#define NBL_INTF_HOST_PCIE_BASE			0X01504000
+/* DP modules base addr */
+#define NBL_DP_USTORE_BASE			0x00104000
+#define NBL_DP_UQM_BASE				0x00114000
+#define NBL_DP_UPED_BASE			0x0015c000
+#define NBL_DP_UVN_BASE				0x00244000
+#define NBL_DP_DSCH_BASE			0x00404000
+#define NBL_DP_SHAPING_BASE			0x00504000
+#define NBL_DP_DVN_BASE				0x00514000
+#define NBL_DP_DSTORE_BASE			0x00704000
+#define NBL_DP_DQM_BASE				0x00714000
+#define NBL_DP_DPED_BASE			0x0075c000
+#define NBL_DP_DDMUX_BASE			0x00984000
+/*  --------  MAILBOX BAR2 -----  */
+#define NBL_MAILBOX_NOTIFY_ADDR			0x00000000
+#define NBL_MAILBOX_BAR_REG			0x00000000
+#define NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR	0x10
+#define NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR	0x20
+#define NBL_MAILBOX_QINFO_CFG_DBG_TABLE_ADDR	0x30
+
+/*  --------  MAILBOX  --------  */
+
+/* mailbox BAR qinfo_cfg_table */
+#define MAILBOX_QINFO_CFG_TABLE_DWLEN	4
+/* data[2] */
+#define NBL_MAILBOX_QINFO_CFG_QUEUE_SIZE_BWID_MASK	GENMASK(3, 0)
+/* data[3] */
+#define NBL_MAILBOX_QINFO_CFG_QUEUE_RST_MASK		BIT(0)
+#define NBL_MAILBOX_QINFO_CFG_QUEUE_EN_MASK		BIT(1)
+#define NBL_MAILBOX_QINFO_CFG_DIF_ERR_MASK		BIT(2)
+#define NBL_MAILBOX_QINFO_CFG_PTR_ERR_MASK		BIT(3)
+struct nbl_mailbox_qinfo_cfg_table {
+	u32 data[MAILBOX_QINFO_CFG_TABLE_DWLEN];
+};
+
+/*  --------  MAILBOX BAR0 -----  */
+/* mailbox qinfo_map_table */
+#define NBL_MAILBOX_QINFO_MAP_REG_ARR(func_id) \
+	(NBL_INTF_HOST_MAILBOX_BASE + 0x00001000 + (func_id) * sizeof(u32))
+
+/* MAILBOX qinfo_map_table */
+#define NBL_MAILBOX_QINFO_MAP_FUNCTION_MASK		GENMASK(2, 0)
+#define NBL_MAILBOX_QINFO_MAP_DEVID_MASK		GENMASK(7, 3)
+#define NBL_MAILBOX_QINFO_MAP_BUS_MASK			GENMASK(15, 8)
+#define NBL_MAILBOX_QINFO_MAP_MSIX_IDX_MASK		GENMASK(28, 16)
+#define NBL_MAILBOX_QINFO_MAP_MSIX_IDX_VALID_MASK	BIT(29)
+
+/*  --------  HOST_PCIE  --------  */
+#define NBL_PCIE_HOST_K_PF_MASK_REG (NBL_INTF_HOST_PCIE_BASE + 0x00001004)
+#define NBL_PCIE_HOST_TL_CFG_BUSDEV (NBL_INTF_HOST_PCIE_BASE + 0x11040)
+
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
index 1828251e8c2a..18f3fa078758 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
@@ -26,6 +26,7 @@ struct nbl_hw_mgt {
 	u8 __iomem *mailbox_bar_hw_addr;
 	u64 notify_offset;
 	resource_size_t hw_size;
+	spinlock_t reg_lock; /* Protect reg access */
 };
 
 static inline u32 rd32(u8 __iomem *addr, u64 reg)
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
index f82926e2152c..1a4b3e81e231 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
@@ -10,6 +10,38 @@
 
 struct nbl_channel_mgt;
 struct nbl_adapter;
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
 enum nbl_chan_msg_type {
 	NBL_CHAN_MSG_ACK,
 	NBL_CHAN_MSG_ADD_MACVLAN,
@@ -233,6 +265,12 @@ enum nbl_chan_msg_type {
 	NBL_CHAN_MSG_MAILBOX_MAX,
 };
 
+enum nbl_chan_state {
+	NBL_CHAN_INTERRUPT_READY,
+	NBL_CHAN_ABNORMAL,
+	NBL_CHAN_STATE_NBITS
+};
+
 struct nbl_chan_param_cfg_msix_map {
 	__le16 num_net_msix;
 	__le16 num_others_msix;
@@ -259,12 +297,57 @@ struct nbl_chan_param_get_eth_id {
 	u8 rsvd[3];
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
+	void (*cfg_chan_qinfo_map_table)(struct nbl_channel_mgt *chan_mgt);
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
index 03c19e1c8c3c..633f7100beb0 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
@@ -11,6 +11,8 @@
 #include <linux/device.h>
 #include "nbl_include.h"
 
+struct nbl_hash_tbl_mgt;
+
 struct nbl_common_info {
 	struct pci_dev *pdev;
 	struct device *dev;
@@ -31,4 +33,28 @@ struct nbl_common_info {
 	u8 has_net;
 };
 
+struct nbl_hash_tbl_key {
+	struct device *dev;
+	u16 key_size;
+	u16 data_size; /* no include key or node member */
+	u16 bucket_size;
+	u16 resv;
+};
+
+struct nbl_hash_tbl_del_key {
+	void *action_priv;
+	void (*action_func)(void *priv, void *key, void *data);
+};
+
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
+
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
index 168504b30973..db737157b603 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
@@ -6,9 +6,36 @@
 #ifndef _NBL_DEF_HW_H_
 #define _NBL_DEF_HW_H_
 
+#include <linux/types.h>
+
 struct nbl_hw_mgt;
 struct nbl_adapter;
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
+	u8 (*get_real_bus)(struct nbl_hw_mgt *hw_mgt);
+
+	void (*cfg_mailbox_qinfo)(struct nbl_hw_mgt *hw_mgt, u16 func_id,
+				  u8 bus, u8 devid, u8 function);
+	void (*set_mailbox_irq)(struct nbl_hw_mgt *hw_mgt, u16 func_id,
+				bool enable_msix, u16 global_vec_id);
+	u32 (*get_fw_eth_map)(struct nbl_hw_mgt *hw_mgt);
+	void (*get_board_info)(struct nbl_hw_mgt *hw_mgt,
+			       struct nbl_board_port_info *board);
 };
 
 struct nbl_hw_ops_tbl {
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index 65fe9a42ee2c..2a1ae9a1eb9d 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -10,6 +10,12 @@
 
 /*  ------  Basic definitions  -------  */
 #define NBL_DRIVER_NAME					"nbl"
+#define NBL_MAX_PF					8
+#define NBL_NEXT_ID(id, max)				\
+	({						\
+		typeof(id) _id = (id);			\
+		((_id) == (max) ? 0 : (_id) + 1);	\
+	})
 
 enum nbl_product_type {
 	NBL_LEONIS_TYPE,
-- 
2.47.3


