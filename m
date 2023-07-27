Return-Path: <netdev+bounces-21873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C78E77651D7
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 13:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE2F281B23
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 11:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADAB168A1;
	Thu, 27 Jul 2023 10:58:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ADA171B9
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 10:58:28 +0000 (UTC)
Received: from mint-fitpc2.localdomain (unknown [81.168.73.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADD821FED
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 03:58:25 -0700 (PDT)
Received: from palantir17.mph.net (palantir17 [192.168.0.4])
	by mint-fitpc2.localdomain (Postfix) with ESMTP id 98DC6321B0E;
	Thu, 27 Jul 2023 11:41:21 +0100 (BST)
Received: from localhost ([::1] helo=palantir17.mph.net)
	by palantir17.mph.net with esmtp (Exim 4.95)
	(envelope-from <habetsm.xilinx@gmail.com>)
	id 1qOyQr-0002YS-9x;
	Thu, 27 Jul 2023 11:41:21 +0100
Subject: [PATCH net-next 08/11] sfc: Remove struct efx_special_buffer
From: Martin Habets <habetsm.xilinx@gmail.com>
To: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com
Date: Thu, 27 Jul 2023 11:41:21 +0100
Message-ID: <169045448119.9625.4464967827215369725.stgit@palantir17.mph.net>
In-Reply-To: <169045436482.9625.4994454326362709391.stgit@palantir17.mph.net>
References: <169045436482.9625.4994454326362709391.stgit@palantir17.mph.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FORGED_GMAIL_RCVD,FREEMAIL_FROM,KHOP_HELO_FCRDNS,MAY_BE_FORGED,
	NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The attributes index and entries are no longer needed, so use
struct efx_buffer instead.
next_buffer_table was also Siena specific.
Removed some checkpatch warnings.

Signed-off-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/ef10.c           |    2 +-
 drivers/net/ethernet/sfc/ef100_nic.c      |    2 +-
 drivers/net/ethernet/sfc/ef100_tx.c       |    6 +++---
 drivers/net/ethernet/sfc/efx_channels.c   |   30 +----------------------------
 drivers/net/ethernet/sfc/mcdi_functions.c |   24 ++++++++++++-----------
 drivers/net/ethernet/sfc/net_driver.h     |   28 +++------------------------
 drivers/net/ethernet/sfc/nic_common.h     |    6 +++---
 drivers/net/ethernet/sfc/tx_tso.c         |    2 +-
 8 files changed, 25 insertions(+), 75 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index fca0cf338510..6dfa062feebc 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -2209,7 +2209,7 @@ static int efx_ef10_tx_probe(struct efx_tx_queue *tx_queue)
 	/* low two bits of label are what we want for type */
 	BUILD_BUG_ON((EFX_TXQ_TYPE_OUTER_CSUM | EFX_TXQ_TYPE_INNER_CSUM) != 3);
 	tx_queue->type = tx_queue->label & 3;
-	return efx_nic_alloc_buffer(tx_queue->efx, &tx_queue->txd.buf,
+	return efx_nic_alloc_buffer(tx_queue->efx, &tx_queue->txd,
 				    (tx_queue->ptr_mask + 1) *
 				    sizeof(efx_qword_t),
 				    GFP_KERNEL);
diff --git a/drivers/net/ethernet/sfc/ef100_nic.c b/drivers/net/ethernet/sfc/ef100_nic.c
index 7adde9639c8a..f3e8ed578c09 100644
--- a/drivers/net/ethernet/sfc/ef100_nic.c
+++ b/drivers/net/ethernet/sfc/ef100_nic.c
@@ -224,7 +224,7 @@ int efx_ef100_init_datapath_caps(struct efx_nic *efx)
 static int ef100_ev_probe(struct efx_channel *channel)
 {
 	/* Allocate an extra descriptor for the QMDA status completion entry */
-	return efx_nic_alloc_buffer(channel->efx, &channel->eventq.buf,
+	return efx_nic_alloc_buffer(channel->efx, &channel->eventq,
 				    (channel->eventq_mask + 2) *
 				    sizeof(efx_qword_t),
 				    GFP_KERNEL);
diff --git a/drivers/net/ethernet/sfc/ef100_tx.c b/drivers/net/ethernet/sfc/ef100_tx.c
index 849e5555bd12..e6b6be549581 100644
--- a/drivers/net/ethernet/sfc/ef100_tx.c
+++ b/drivers/net/ethernet/sfc/ef100_tx.c
@@ -23,7 +23,7 @@
 int ef100_tx_probe(struct efx_tx_queue *tx_queue)
 {
 	/* Allocate an extra descriptor for the QMDA status completion entry */
-	return efx_nic_alloc_buffer(tx_queue->efx, &tx_queue->txd.buf,
+	return efx_nic_alloc_buffer(tx_queue->efx, &tx_queue->txd,
 				    (tx_queue->ptr_mask + 2) *
 				    sizeof(efx_oword_t),
 				    GFP_KERNEL);
@@ -101,8 +101,8 @@ static bool ef100_tx_can_tso(struct efx_tx_queue *tx_queue, struct sk_buff *skb)
 
 static efx_oword_t *ef100_tx_desc(struct efx_tx_queue *tx_queue, unsigned int index)
 {
-	if (likely(tx_queue->txd.buf.addr))
-		return ((efx_oword_t *)tx_queue->txd.buf.addr) + index;
+	if (likely(tx_queue->txd.addr))
+		return ((efx_oword_t *)tx_queue->txd.addr) + index;
 	else
 		return NULL;
 }
diff --git a/drivers/net/ethernet/sfc/efx_channels.c b/drivers/net/ethernet/sfc/efx_channels.c
index 41b33a75333c..8d2d7ea2ebef 100644
--- a/drivers/net/ethernet/sfc/efx_channels.c
+++ b/drivers/net/ethernet/sfc/efx_channels.c
@@ -713,9 +713,6 @@ int efx_probe_channels(struct efx_nic *efx)
 	struct efx_channel *channel;
 	int rc;
 
-	/* Restart special buffer allocation */
-	efx->next_buffer_table = 0;
-
 	/* Probe channels in reverse, so that any 'extra' channels
 	 * use the start of the buffer table. This allows the traffic
 	 * channels to be resized without moving them or wasting the
@@ -849,36 +846,14 @@ int efx_realloc_channels(struct efx_nic *efx, u32 rxq_entries, u32 txq_entries)
 	struct efx_channel *other_channel[EFX_MAX_CHANNELS], *channel,
 			   *ptp_channel = efx_ptp_channel(efx);
 	struct efx_ptp_data *ptp_data = efx->ptp_data;
-	unsigned int i, next_buffer_table = 0;
 	u32 old_rxq_entries, old_txq_entries;
+	unsigned int i;
 	int rc, rc2;
 
 	rc = efx_check_disabled(efx);
 	if (rc)
 		return rc;
 
-	/* Not all channels should be reallocated. We must avoid
-	 * reallocating their buffer table entries.
-	 */
-	efx_for_each_channel(channel, efx) {
-		struct efx_rx_queue *rx_queue;
-		struct efx_tx_queue *tx_queue;
-
-		if (channel->type->copy)
-			continue;
-		next_buffer_table = max(next_buffer_table,
-					channel->eventq.index +
-					channel->eventq.entries);
-		efx_for_each_channel_rx_queue(rx_queue, channel)
-			next_buffer_table = max(next_buffer_table,
-						rx_queue->rxd.index +
-						rx_queue->rxd.entries);
-		efx_for_each_channel_tx_queue(tx_queue, channel)
-			next_buffer_table = max(next_buffer_table,
-						tx_queue->txd.index +
-						tx_queue->txd.entries);
-	}
-
 	efx_device_detach_sync(efx);
 	efx_stop_all(efx);
 	efx_soft_disable_interrupts(efx);
@@ -904,9 +879,6 @@ int efx_realloc_channels(struct efx_nic *efx, u32 rxq_entries, u32 txq_entries)
 	for (i = 0; i < efx->n_channels; i++)
 		swap(efx->channel[i], other_channel[i]);
 
-	/* Restart buffer table allocation */
-	efx->next_buffer_table = next_buffer_table;
-
 	for (i = 0; i < efx->n_channels; i++) {
 		channel = efx->channel[i];
 		if (!channel->type->copy)
diff --git a/drivers/net/ethernet/sfc/mcdi_functions.c b/drivers/net/ethernet/sfc/mcdi_functions.c
index d3e6d8239f5c..ff8424167384 100644
--- a/drivers/net/ethernet/sfc/mcdi_functions.c
+++ b/drivers/net/ethernet/sfc/mcdi_functions.c
@@ -62,7 +62,7 @@ int efx_mcdi_alloc_vis(struct efx_nic *efx, unsigned int min_vis,
 
 int efx_mcdi_ev_probe(struct efx_channel *channel)
 {
-	return efx_nic_alloc_buffer(channel->efx, &channel->eventq.buf,
+	return efx_nic_alloc_buffer(channel->efx, &channel->eventq,
 				    (channel->eventq_mask + 1) *
 				    sizeof(efx_qword_t),
 				    GFP_KERNEL);
@@ -74,14 +74,14 @@ int efx_mcdi_ev_init(struct efx_channel *channel, bool v1_cut_thru, bool v2)
 			 MC_CMD_INIT_EVQ_V2_IN_LEN(EFX_MAX_EVQ_SIZE * 8 /
 						   EFX_BUF_SIZE));
 	MCDI_DECLARE_BUF(outbuf, MC_CMD_INIT_EVQ_V2_OUT_LEN);
-	size_t entries = channel->eventq.buf.len / EFX_BUF_SIZE;
+	size_t entries = channel->eventq.len / EFX_BUF_SIZE;
 	struct efx_nic *efx = channel->efx;
 	size_t inlen, outlen;
 	dma_addr_t dma_addr;
 	int rc, i;
 
 	/* Fill event queue with all ones (i.e. empty events) */
-	memset(channel->eventq.buf.addr, 0xff, channel->eventq.buf.len);
+	memset(channel->eventq.addr, 0xff, channel->eventq.len);
 
 	MCDI_SET_DWORD(inbuf, INIT_EVQ_IN_SIZE, channel->eventq_mask + 1);
 	MCDI_SET_DWORD(inbuf, INIT_EVQ_IN_INSTANCE, channel->channel);
@@ -112,7 +112,7 @@ int efx_mcdi_ev_init(struct efx_channel *channel, bool v1_cut_thru, bool v2)
 				      INIT_EVQ_IN_FLAG_CUT_THRU, v1_cut_thru);
 	}
 
-	dma_addr = channel->eventq.buf.dma_addr;
+	dma_addr = channel->eventq.dma_addr;
 	for (i = 0; i < entries; ++i) {
 		MCDI_SET_ARRAY_QWORD(inbuf, INIT_EVQ_IN_DMA_ADDR, i, dma_addr);
 		dma_addr += EFX_BUF_SIZE;
@@ -134,7 +134,7 @@ int efx_mcdi_ev_init(struct efx_channel *channel, bool v1_cut_thru, bool v2)
 
 void efx_mcdi_ev_remove(struct efx_channel *channel)
 {
-	efx_nic_free_buffer(channel->efx, &channel->eventq.buf);
+	efx_nic_free_buffer(channel->efx, &channel->eventq);
 }
 
 void efx_mcdi_ev_fini(struct efx_channel *channel)
@@ -166,7 +166,7 @@ int efx_mcdi_tx_init(struct efx_tx_queue *tx_queue)
 						       EFX_BUF_SIZE));
 	bool csum_offload = tx_queue->type & EFX_TXQ_TYPE_OUTER_CSUM;
 	bool inner_csum = tx_queue->type & EFX_TXQ_TYPE_INNER_CSUM;
-	size_t entries = tx_queue->txd.buf.len / EFX_BUF_SIZE;
+	size_t entries = tx_queue->txd.len / EFX_BUF_SIZE;
 	struct efx_channel *channel = tx_queue->channel;
 	struct efx_nic *efx = tx_queue->efx;
 	dma_addr_t dma_addr;
@@ -182,7 +182,7 @@ int efx_mcdi_tx_init(struct efx_tx_queue *tx_queue)
 	MCDI_SET_DWORD(inbuf, INIT_TXQ_IN_OWNER_ID, 0);
 	MCDI_SET_DWORD(inbuf, INIT_TXQ_IN_PORT_ID, efx->vport_id);
 
-	dma_addr = tx_queue->txd.buf.dma_addr;
+	dma_addr = tx_queue->txd.dma_addr;
 
 	netif_dbg(efx, hw, efx->net_dev, "pushing TXQ %d. %zu entries (%llx)\n",
 		  tx_queue->queue, entries, (u64)dma_addr);
@@ -240,7 +240,7 @@ int efx_mcdi_tx_init(struct efx_tx_queue *tx_queue)
 
 void efx_mcdi_tx_remove(struct efx_tx_queue *tx_queue)
 {
-	efx_nic_free_buffer(tx_queue->efx, &tx_queue->txd.buf);
+	efx_nic_free_buffer(tx_queue->efx, &tx_queue->txd);
 }
 
 void efx_mcdi_tx_fini(struct efx_tx_queue *tx_queue)
@@ -269,7 +269,7 @@ void efx_mcdi_tx_fini(struct efx_tx_queue *tx_queue)
 
 int efx_mcdi_rx_probe(struct efx_rx_queue *rx_queue)
 {
-	return efx_nic_alloc_buffer(rx_queue->efx, &rx_queue->rxd.buf,
+	return efx_nic_alloc_buffer(rx_queue->efx, &rx_queue->rxd,
 				    (rx_queue->ptr_mask + 1) *
 				    sizeof(efx_qword_t),
 				    GFP_KERNEL);
@@ -278,7 +278,7 @@ int efx_mcdi_rx_probe(struct efx_rx_queue *rx_queue)
 void efx_mcdi_rx_init(struct efx_rx_queue *rx_queue)
 {
 	struct efx_channel *channel = efx_rx_queue_channel(rx_queue);
-	size_t entries = rx_queue->rxd.buf.len / EFX_BUF_SIZE;
+	size_t entries = rx_queue->rxd.len / EFX_BUF_SIZE;
 	MCDI_DECLARE_BUF(inbuf, MC_CMD_INIT_RXQ_V4_IN_LEN);
 	struct efx_nic *efx = rx_queue->efx;
 	unsigned int buffer_size;
@@ -306,7 +306,7 @@ void efx_mcdi_rx_init(struct efx_rx_queue *rx_queue)
 	MCDI_SET_DWORD(inbuf, INIT_RXQ_IN_PORT_ID, efx->vport_id);
 	MCDI_SET_DWORD(inbuf, INIT_RXQ_V4_IN_BUFFER_SIZE_BYTES, buffer_size);
 
-	dma_addr = rx_queue->rxd.buf.dma_addr;
+	dma_addr = rx_queue->rxd.dma_addr;
 
 	netif_dbg(efx, hw, efx->net_dev, "pushing RXQ %d. %zu entries (%llx)\n",
 		  efx_rx_queue_index(rx_queue), entries, (u64)dma_addr);
@@ -325,7 +325,7 @@ void efx_mcdi_rx_init(struct efx_rx_queue *rx_queue)
 
 void efx_mcdi_rx_remove(struct efx_rx_queue *rx_queue)
 {
-	efx_nic_free_buffer(rx_queue->efx, &rx_queue->rxd.buf);
+	efx_nic_free_buffer(rx_queue->efx, &rx_queue->rxd);
 }
 
 void efx_mcdi_rx_fini(struct efx_rx_queue *rx_queue)
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 6654fbb8f4c0..27d86e90a3bb 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -122,26 +122,6 @@ struct efx_buffer {
 	unsigned int len;
 };
 
-/**
- * struct efx_special_buffer - DMA buffer entered into buffer table
- * @buf: Standard &struct efx_buffer
- * @index: Buffer index within controller;s buffer table
- * @entries: Number of buffer table entries
- *
- * The NIC has a buffer table that maps buffers of size %EFX_BUF_SIZE.
- * Event and descriptor rings are addressed via one or more buffer
- * table entries (and so can be physically non-contiguous, although we
- * currently do not take advantage of that).  On Falcon and Siena we
- * have to take care of allocating and initialising the entries
- * ourselves.  On later hardware this is managed by the firmware and
- * @index and @entries are left as 0.
- */
-struct efx_special_buffer {
-	struct efx_buffer buf;
-	unsigned int index;
-	unsigned int entries;
-};
-
 /**
  * struct efx_tx_buffer - buffer state for a TX descriptor
  * @skb: When @flags & %EFX_TX_BUF_SKB, the associated socket buffer to be
@@ -268,7 +248,7 @@ struct efx_tx_queue {
 	struct netdev_queue *core_txq;
 	struct efx_tx_buffer *buffer;
 	struct efx_buffer *cb_page;
-	struct efx_special_buffer txd;
+	struct efx_buffer txd;
 	unsigned int ptr_mask;
 	void __iomem *piobuf;
 	unsigned int piobuf_offset;
@@ -397,7 +377,7 @@ struct efx_rx_queue {
 	struct efx_nic *efx;
 	int core_index;
 	struct efx_rx_buffer *buffer;
-	struct efx_special_buffer rxd;
+	struct efx_buffer rxd;
 	unsigned int ptr_mask;
 	bool refill_enabled;
 	bool flush_pending;
@@ -513,7 +493,7 @@ struct efx_channel {
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	unsigned long busy_poll_state;
 #endif
-	struct efx_special_buffer eventq;
+	struct efx_buffer eventq;
 	unsigned int eventq_mask;
 	unsigned int eventq_read_ptr;
 	int event_test_cpu;
@@ -881,7 +861,6 @@ struct efx_mae;
  * @tx_dc_base: Base qword address in SRAM of TX queue descriptor caches
  * @rx_dc_base: Base qword address in SRAM of RX queue descriptor caches
  * @sram_lim_qw: Qword address limit of SRAM
- * @next_buffer_table: First available buffer table id
  * @n_channels: Number of channels in use
  * @n_rx_channels: Number of channels used for RX (= number of RX queues)
  * @n_tx_channels: Number of channels used for TX
@@ -1046,7 +1025,6 @@ struct efx_nic {
 	unsigned tx_dc_base;
 	unsigned rx_dc_base;
 	unsigned sram_lim_qw;
-	unsigned next_buffer_table;
 
 	unsigned int max_channels;
 	unsigned int max_vis;
diff --git a/drivers/net/ethernet/sfc/nic_common.h b/drivers/net/ethernet/sfc/nic_common.h
index e35ecbe8842e..47b1c46c069d 100644
--- a/drivers/net/ethernet/sfc/nic_common.h
+++ b/drivers/net/ethernet/sfc/nic_common.h
@@ -32,7 +32,7 @@ static inline int efx_nic_rev(struct efx_nic *efx)
 static inline efx_qword_t *efx_event(struct efx_channel *channel,
 				     unsigned int index)
 {
-	return ((efx_qword_t *) (channel->eventq.buf.addr)) +
+	return ((efx_qword_t *)(channel->eventq.addr)) +
 		(index & channel->eventq_mask);
 }
 
@@ -58,7 +58,7 @@ static inline int efx_event_present(efx_qword_t *event)
 static inline efx_qword_t *
 efx_tx_desc(struct efx_tx_queue *tx_queue, unsigned int index)
 {
-	return ((efx_qword_t *) (tx_queue->txd.buf.addr)) + index;
+	return ((efx_qword_t *)(tx_queue->txd.addr)) + index;
 }
 
 /* Report whether this TX queue would be empty for the given write_count.
@@ -98,7 +98,7 @@ static inline bool efx_nic_may_push_tx_desc(struct efx_tx_queue *tx_queue,
 static inline efx_qword_t *
 efx_rx_desc(struct efx_rx_queue *rx_queue, unsigned int index)
 {
-	return ((efx_qword_t *) (rx_queue->rxd.buf.addr)) + index;
+	return ((efx_qword_t *)(rx_queue->rxd.addr)) + index;
 }
 
 /* Alignment of PCIe DMA boundaries (4KB) */
diff --git a/drivers/net/ethernet/sfc/tx_tso.c b/drivers/net/ethernet/sfc/tx_tso.c
index d381d8164f07..64a6768f75ea 100644
--- a/drivers/net/ethernet/sfc/tx_tso.c
+++ b/drivers/net/ethernet/sfc/tx_tso.c
@@ -85,7 +85,7 @@ static inline void prefetch_ptr(struct efx_tx_queue *tx_queue)
 	prefetch(ptr);
 	prefetch(ptr + 0x80);
 
-	ptr = (char *) (((efx_qword_t *)tx_queue->txd.buf.addr) + insert_ptr);
+	ptr = (char *)(((efx_qword_t *)tx_queue->txd.addr) + insert_ptr);
 	prefetch(ptr);
 	prefetch(ptr + 0x80);
 }



