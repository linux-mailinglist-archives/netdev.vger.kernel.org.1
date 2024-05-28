Return-Path: <netdev+bounces-98591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F17358D1D77
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49518B21697
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E8616FF36;
	Tue, 28 May 2024 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DpZO8F/m"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A6516F29C;
	Tue, 28 May 2024 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716904177; cv=none; b=g6AevCbHOgnXkw8CVnA7eMi7WbmH1s///ZON+8fcCh98IDZ3m69PwEK9I+u8Bkr1sYz6htesN6HmZOZ3LhjRsz67QsBkbbIr24QK7OIypyn25KjIZZrnRm3OS/a9bpwraRLbpZ63bEDb+zH+OOWuOT3YYXg7tXIxMvmylVU+jAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716904177; c=relaxed/simple;
	bh=Gwn9DRaLVr3DjUwx2XcyIso8ZY8dlTvLvkRtPJ/U2bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a694LbEDsMxzlLYWWIquP2VUNlwHDngRfsB9iiAUkLASe0L2tvL+fSfLEL0JuK325FkqksNMnwOelHUCANnugrmpVFe+8k3Hn+KOgKCeqXy1rsXXhgse5oM/EeplfNMc520ClJrI5DpvZiE1J4kKuvBrJtngn0a8WlMBAEtt1/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DpZO8F/m; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716904176; x=1748440176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gwn9DRaLVr3DjUwx2XcyIso8ZY8dlTvLvkRtPJ/U2bQ=;
  b=DpZO8F/mRzZ3uBTd50ovChvgQS1hdlb2tAxrZJsUNrT6CbSJaP78zVKf
   YfWPHHHe26WAJJlBGcQwFsaqZcg7UrJIaHXKBSnnN6CIpPgUCY8+iOO55
   si8m57Q37pypdpuje3DJ5ILFqQ+FYTI8SrnjvFBiTOPVqfcWsXsV7k8l7
   8C7vrTy6ZoocSPnsTklVSxenzw++pfKJfVeMNVP0ZsKD0zA8VjwtAoQUt
   pZxy9Itr+VbyEMI/k+lPS9OdS/bvWgWNm/o7omHVsZCJSYM7bkK4Sz0n4
   yRV8BkWIv/8N/HyjJ11vfJRMubLcvxHeo9RvWGDvh3Noa9vfUGybmodQu
   A==;
X-CSE-ConnectionGUID: /jYrewWsSdaiUeSOitS2Dw==
X-CSE-MsgGUID: WHXAfEqmQx+56zJEdNLeiQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13437020"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="13437020"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 06:49:35 -0700
X-CSE-ConnectionGUID: cUcvibo6TQqvkHDtS5jRhg==
X-CSE-MsgGUID: LDxLa49uQXyMdb5IdsZMAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="35577431"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 28 May 2024 06:49:32 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mina Almasry <almasrymina@google.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next 05/12] idpf: strictly assert cachelines of queue and queue vector structures
Date: Tue, 28 May 2024 15:48:39 +0200
Message-ID: <20240528134846.148890-6-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528134846.148890-1-aleksander.lobakin@intel.com>
References: <20240528134846.148890-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the queue and queue vector structures are separated and laid
out optimally, group the fields as read-mostly, read-write, and cold
cachelines and add size assertions to make sure new features won't push
something out of its place and provoke perf regression.
Despite looking innocent, this gives up to 2% of perf bump on Rx.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h | 443 +++++++++++---------
 1 file changed, 250 insertions(+), 193 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 9e4ba0aaf3ab..731e2a73def5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -6,6 +6,7 @@
 
 #include <linux/dim.h>
 
+#include <net/libeth/cache.h>
 #include <net/page_pool/helpers.h>
 #include <net/tcp.h>
 #include <net/netdev_queues.h>
@@ -504,59 +505,70 @@ struct idpf_intr_reg {
 
 /**
  * struct idpf_q_vector
+ * @read_mostly: CL group with rarely written hot fields
  * @vport: Vport back pointer
- * @napi: napi handler
- * @v_idx: Vector index
- * @intr_reg: See struct idpf_intr_reg
+ * @num_rxq: Number of RX queues
  * @num_txq: Number of TX queues
+ * @num_bufq: Number of buffer queues
  * @num_complq: number of completion queues
+ * @rx: Array of RX queues to service
  * @tx: Array of TX queues to service
+ * @bufq: Array of buffer queues to service
  * @complq: array of completion queues
+ * @intr_reg: See struct idpf_intr_reg
+ * @read_write: CL group with both read/write hot fields
+ * @napi: napi handler
+ * @total_events: Number of interrupts processed
  * @tx_dim: Data for TX net_dim algorithm
  * @tx_itr_value: TX interrupt throttling rate
  * @tx_intr_mode: Dynamic ITR or not
  * @tx_itr_idx: TX ITR index
- * @num_rxq: Number of RX queues
- * @rx: Array of RX queues to service
  * @rx_dim: Data for RX net_dim algorithm
  * @rx_itr_value: RX interrupt throttling rate
  * @rx_intr_mode: Dynamic ITR or not
  * @rx_itr_idx: RX ITR index
- * @num_bufq: Number of buffer queues
- * @bufq: Array of buffer queues to service
- * @total_events: Number of interrupts processed
+ * @cold: CL group with fields no touched on hotpath
+ * @v_idx: Vector index
  * @affinity_mask: CPU affinity mask
  */
 struct idpf_q_vector {
-	struct idpf_vport *vport;
-	struct napi_struct napi;
-	u16 v_idx;
-	struct idpf_intr_reg intr_reg;
-
-	u16 num_txq;
-	u16 num_complq;
-	struct idpf_tx_queue **tx;
-	struct idpf_compl_queue **complq;
-
-	struct dim tx_dim;
-	u16 tx_itr_value;
-	bool tx_intr_mode;
-	u32 tx_itr_idx;
-
-	u16 num_rxq;
-	struct idpf_rx_queue **rx;
-	struct dim rx_dim;
-	u16 rx_itr_value;
-	bool rx_intr_mode;
-	u32 rx_itr_idx;
-
-	u16 num_bufq;
-	struct idpf_buf_queue **bufq;
-
-	u16 total_events;
-
-	cpumask_var_t affinity_mask;
+	libeth_cacheline_group(read_mostly,
+		struct idpf_vport *vport;
+
+		u16 num_rxq;
+		u16 num_txq;
+		u16 num_bufq;
+		u16 num_complq;
+		struct idpf_rx_queue **rx;
+		struct idpf_tx_queue **tx;
+		struct idpf_buf_queue **bufq;
+		struct idpf_compl_queue **complq;
+
+		struct idpf_intr_reg intr_reg;
+	);
+	libeth_cacheline_group(read_write,
+		struct napi_struct napi;
+		u16 total_events;
+
+		struct dim tx_dim;
+		u16 tx_itr_value;
+		bool tx_intr_mode;
+		u32 tx_itr_idx;
+
+		struct dim rx_dim;
+		u16 rx_itr_value;
+		bool rx_intr_mode;
+		u32 rx_itr_idx;
+	);
+	libeth_cacheline_group(cold,
+		u16 v_idx;
+
+		cpumask_var_t affinity_mask;
+	);
 };
+libeth_cacheline_set_assert(struct idpf_q_vector, 104,
+			    424 + 2 * sizeof(struct dim),
+			    8 + sizeof(cpumask_var_t));
 
 struct idpf_rx_queue_stats {
 	u64_stats_t packets;
@@ -610,6 +622,7 @@ struct idpf_txq_stash {
 
 /**
  * struct idpf_rx_queue - software structure representing a receive queue
+ * @read_mostly: CL group with rarely written hot fields
  * @rx: universal receive descriptor array
  * @single_buf: buffer descriptor array in singleq
  * @desc_ring: virtual descriptor ring address
@@ -623,14 +636,16 @@ struct idpf_txq_stash {
  * @idx: For RX queue, it is used to index to total RX queue across groups and
  *	 used for skb reporting.
  * @desc_count: Number of descriptors
+ * @rxdids: Supported RX descriptor ids
+ * @rx_ptype_lkup: LUT of Rx ptypes
+ * @read_write: CL group with both read/write hot fields
  * @next_to_use: Next descriptor to use
  * @next_to_clean: Next descriptor to clean
  * @next_to_alloc: RX buffer to allocate at
- * @rxdids: Supported RX descriptor ids
- * @rx_ptype_lkup: LUT of Rx ptypes
  * @skb: Pointer to the skb
  * @stats_sync: See struct u64_stats_sync
  * @q_stats: See union idpf_rx_queue_stats
+ * @cold: CL group with fields no touched on hotpath
  * @q_id: Queue id
  * @size: Length of descriptor ring in bytes
  * @dma: Physical address of ring
@@ -641,55 +656,63 @@ struct idpf_txq_stash {
  * @rx_max_pkt_size: RX max packet size
  */
 struct idpf_rx_queue {
-	union {
-		union virtchnl2_rx_desc *rx;
-		struct virtchnl2_singleq_rx_buf_desc *single_buf;
+	libeth_cacheline_group(read_mostly,
+		union {
+			union virtchnl2_rx_desc *rx;
+			struct virtchnl2_singleq_rx_buf_desc *single_buf;
 
-		void *desc_ring;
-	};
-	union {
-		struct {
-			struct idpf_bufq_set *bufq_sets;
-			struct napi_struct *napi;
+			void *desc_ring;
 		};
-		struct {
-			struct idpf_rx_buf *rx_buf;
-			struct page_pool *pp;
+		union {
+			struct {
+				struct idpf_bufq_set *bufq_sets;
+				struct napi_struct *napi;
+			};
+			struct {
+				struct idpf_rx_buf *rx_buf;
+				struct page_pool *pp;
+			};
 		};
-	};
-	struct net_device *netdev;
-	void __iomem *tail;
-
-	DECLARE_BITMAP(flags, __IDPF_Q_FLAGS_NBITS);
-	u16 idx;
-	u16 desc_count;
-	u16 next_to_use;
-	u16 next_to_clean;
-	u16 next_to_alloc;
-
-	u32 rxdids;
-
-	const struct idpf_rx_ptype_decoded *rx_ptype_lkup;
-	struct sk_buff *skb;
-
-	struct u64_stats_sync stats_sync;
-	struct idpf_rx_queue_stats q_stats;
-
-	/* Slowpath */
-	u32 q_id;
-	u32 size;
-	dma_addr_t dma;
-
-	struct idpf_q_vector *q_vector;
-
-	u16 rx_buffer_low_watermark;
-	u16 rx_hbuf_size;
-	u16 rx_buf_size;
-	u16 rx_max_pkt_size;
-} ____cacheline_aligned;
+		struct net_device *netdev;
+		void __iomem *tail;
+
+		DECLARE_BITMAP(flags, __IDPF_Q_FLAGS_NBITS);
+		u16 idx;
+		u16 desc_count;
+
+		u32 rxdids;
+		const struct idpf_rx_ptype_decoded *rx_ptype_lkup;
+	);
+	libeth_cacheline_group(read_write,
+		u16 next_to_use;
+		u16 next_to_clean;
+		u16 next_to_alloc;
+
+		struct sk_buff *skb;
+
+		struct u64_stats_sync stats_sync;
+		struct idpf_rx_queue_stats q_stats;
+	);
+	libeth_cacheline_group(cold,
+		u32 q_id;
+		u32 size;
+		dma_addr_t dma;
+
+		struct idpf_q_vector *q_vector;
+
+		u16 rx_buffer_low_watermark;
+		u16 rx_hbuf_size;
+		u16 rx_buf_size;
+		u16 rx_max_pkt_size;
+	);
+};
+libeth_cacheline_set_assert(struct idpf_rx_queue, 64,
+			    72 + sizeof(struct u64_stats_sync),
+			    32);
 
 /**
  * struct idpf_tx_queue - software structure representing a transmit queue
+ * @read_mostly: CL group with rarely written hot fields
  * @base_tx: base Tx descriptor array
  * @base_ctx: base Tx context descriptor array
  * @flex_tx: flex Tx descriptor array
@@ -703,22 +726,7 @@ struct idpf_rx_queue {
  * @idx: For TX queue, it is used as index to map between TX queue group and
  *	 hot path TX pointers stored in vport. Used in both singleq/splitq.
  * @desc_count: Number of descriptors
- * @next_to_use: Next descriptor to use
- * @next_to_clean: Next descriptor to clean
- * @netdev: &net_device corresponding to this queue
- * @cleaned_bytes: Splitq only, TXQ only: When a TX completion is received on
- *		   the TX completion queue, it can be for any TXQ associated
- *		   with that completion queue. This means we can clean up to
- *		   N TXQs during a single call to clean the completion queue.
- *		   cleaned_bytes|pkts tracks the clean stats per TXQ during
- *		   that single call to clean the completion queue. By doing so,
- *		   we can update BQL with aggregate cleaned stats for each TXQ
- *		   only once at the end of the cleaning routine.
- * @clean_budget: singleq only, queue cleaning budget
- * @cleaned_pkts: Number of packets cleaned for the above said case
- * @tx_max_bufs: Max buffers that can be transmitted with scatter-gather
  * @tx_min_pkt_len: Min supported packet length
- * @compl_tag_bufid_m: Completion tag buffer id mask
  * @compl_tag_gen_s: Completion tag generation bit
  *	The format of the completion tag will change based on the TXQ
  *	descriptor ring size so that we can maintain roughly the same level
@@ -739,68 +747,92 @@ struct idpf_rx_queue {
  *	--------------------------------
  *
  *	This gives us 8*8160 = 65280 possible unique values.
+ * @netdev: &net_device corresponding to this queue
+ * @read_write: CL group with both read/write hot fields
+ * @next_to_use: Next descriptor to use
+ * @next_to_clean: Next descriptor to clean
+ * @cleaned_bytes: Splitq only, TXQ only: When a TX completion is received on
+ *		   the TX completion queue, it can be for any TXQ associated
+ *		   with that completion queue. This means we can clean up to
+ *		   N TXQs during a single call to clean the completion queue.
+ *		   cleaned_bytes|pkts tracks the clean stats per TXQ during
+ *		   that single call to clean the completion queue. By doing so,
+ *		   we can update BQL with aggregate cleaned stats for each TXQ
+ *		   only once at the end of the cleaning routine.
+ * @clean_budget: singleq only, queue cleaning budget
+ * @cleaned_pkts: Number of packets cleaned for the above said case
+ * @tx_max_bufs: Max buffers that can be transmitted with scatter-gather
+ * @stash: Tx buffer stash for Flow-based scheduling mode
+ * @compl_tag_bufid_m: Completion tag buffer id mask
  * @compl_tag_cur_gen: Used to keep track of current completion tag generation
  * @compl_tag_gen_max: To determine when compl_tag_cur_gen should be reset
- * @stash: Tx buffer stash for Flow-based scheduling mode
  * @stats_sync: See struct u64_stats_sync
  * @q_stats: See union idpf_tx_queue_stats
+ * @cold: CL group with fields no touched on hotpath
  * @q_id: Queue id
  * @size: Length of descriptor ring in bytes
  * @dma: Physical address of ring
  * @q_vector: Backreference to associated vector
  */
 struct idpf_tx_queue {
-	union {
-		struct idpf_base_tx_desc *base_tx;
-		struct idpf_base_tx_ctx_desc *base_ctx;
-		union idpf_tx_flex_desc *flex_tx;
-		struct idpf_flex_tx_ctx_desc *flex_ctx;
-
-		void *desc_ring;
-	};
-	struct idpf_tx_buf *tx_buf;
-	struct idpf_txq_group *txq_grp;
-	struct device *dev;
-	void __iomem *tail;
-
-	DECLARE_BITMAP(flags, __IDPF_Q_FLAGS_NBITS);
-	u16 idx;
-	u16 desc_count;
-	u16 next_to_use;
-	u16 next_to_clean;
-
-	struct net_device *netdev;
-
-	union {
-		u32 cleaned_bytes;
-		u32 clean_budget;
-	};
-	u16 cleaned_pkts;
-
-	u16 tx_max_bufs;
-	u16 tx_min_pkt_len;
-
-	u16 compl_tag_bufid_m;
-	u16 compl_tag_gen_s;
-
-	u16 compl_tag_cur_gen;
-	u16 compl_tag_gen_max;
+	libeth_cacheline_group(read_mostly,
+		union {
+			struct idpf_base_tx_desc *base_tx;
+			struct idpf_base_tx_ctx_desc *base_ctx;
+			union idpf_tx_flex_desc *flex_tx;
+			struct idpf_flex_tx_ctx_desc *flex_ctx;
+
+			void *desc_ring;
+		};
+		struct idpf_tx_buf *tx_buf;
+		struct idpf_txq_group *txq_grp;
+		struct device *dev;
+		void __iomem *tail;
+
+		DECLARE_BITMAP(flags, __IDPF_Q_FLAGS_NBITS);
+		u16 idx;
+		u16 desc_count;
+
+		u16 tx_min_pkt_len;
+		u16 compl_tag_gen_s;
+
+		struct net_device *netdev;
+	);
+	libeth_cacheline_group(read_write,
+		u16 next_to_use;
+		u16 next_to_clean;
+
+		union {
+			u32 cleaned_bytes;
+			u32 clean_budget;
+		};
+		u16 cleaned_pkts;
 
-	struct idpf_txq_stash *stash;
+		u16 tx_max_bufs;
+		struct idpf_txq_stash *stash;
 
-	struct u64_stats_sync stats_sync;
-	struct idpf_tx_queue_stats q_stats;
+		u16 compl_tag_bufid_m;
+		u16 compl_tag_cur_gen;
+		u16 compl_tag_gen_max;
 
-	/* Slowpath */
-	u32 q_id;
-	u32 size;
-	dma_addr_t dma;
+		struct u64_stats_sync stats_sync;
+		struct idpf_tx_queue_stats q_stats;
+	);
+	libeth_cacheline_group(cold,
+		u32 q_id;
+		u32 size;
+		dma_addr_t dma;
 
-	struct idpf_q_vector *q_vector;
-} ____cacheline_aligned;
+		struct idpf_q_vector *q_vector;
+	);
+};
+libeth_cacheline_set_assert(struct idpf_tx_queue, 64,
+			    88 + sizeof(struct u64_stats_sync),
+			    24);
 
 /**
  * struct idpf_buf_queue - software structure representing a buffer queue
+ * @read_mostly: CL group with rarely written hot fields
  * @split_buf: buffer descriptor array
  * @rx_buf: Struct with RX buffer related members
  * @rx_buf.buf: See struct idpf_rx_buf
@@ -810,9 +842,11 @@ struct idpf_tx_queue {
  * @tail: Tail offset
  * @flags: See enum idpf_queue_flags_t
  * @desc_count: Number of descriptors
+ * @read_write: CL group with both read/write hot fields
  * @next_to_use: Next descriptor to use
  * @next_to_clean: Next descriptor to clean
  * @next_to_alloc: RX buffer to allocate at
+ * @cold: CL group with fields no touched on hotpath
  * @q_id: Queue id
  * @size: Length of descriptor ring in bytes
  * @dma: Physical address of ring
@@ -822,79 +856,95 @@ struct idpf_tx_queue {
  * @rx_buf_size: Buffer size
  */
 struct idpf_buf_queue {
-	struct virtchnl2_splitq_rx_buf_desc *split_buf;
-	struct {
-		struct idpf_rx_buf *buf;
-		dma_addr_t hdr_buf_pa;
-		void *hdr_buf_va;
-	} rx_buf;
-	struct page_pool *pp;
-	void __iomem *tail;
-
-	DECLARE_BITMAP(flags, __IDPF_Q_FLAGS_NBITS);
-	u16 desc_count;
-	u16 next_to_use;
-	u16 next_to_clean;
-	u16 next_to_alloc;
-
-	/* Slowpath */
-	u32 q_id;
-	u32 size;
-	dma_addr_t dma;
-
-	struct idpf_q_vector *q_vector;
-
-	u16 rx_buffer_low_watermark;
-	u16 rx_hbuf_size;
-	u16 rx_buf_size;
-} ____cacheline_aligned;
+	libeth_cacheline_group(read_mostly,
+		struct virtchnl2_splitq_rx_buf_desc *split_buf;
+		struct {
+			struct idpf_rx_buf *buf;
+			dma_addr_t hdr_buf_pa;
+			void *hdr_buf_va;
+		} rx_buf;
+		struct page_pool *pp;
+		void __iomem *tail;
+
+		DECLARE_BITMAP(flags, __IDPF_Q_FLAGS_NBITS);
+		u32 desc_count;
+	);
+	libeth_cacheline_group(read_write,
+		u32 next_to_use;
+		u32 next_to_clean;
+		u32 next_to_alloc;
+	);
+	libeth_cacheline_group(cold,
+		u32 q_id;
+		u32 size;
+		dma_addr_t dma;
+
+		struct idpf_q_vector *q_vector;
+
+		u16 rx_buffer_low_watermark;
+		u16 rx_hbuf_size;
+		u16 rx_buf_size;
+	);
+};
+libeth_cacheline_set_assert(struct idpf_buf_queue, 64, 16, 32);
 
 /**
  * struct idpf_compl_queue - software structure representing a completion queue
+ * @read_mostly: CL group with rarely written hot fields
  * @comp: completion descriptor array
  * @txq_grp: See struct idpf_txq_group
  * @flags: See enum idpf_queue_flags_t
  * @desc_count: Number of descriptors
+ * @clean_budget: queue cleaning budget
+ * @netdev: &net_device corresponding to this queue
+ * @read_write: CL group with both read/write hot fields
  * @next_to_use: Next descriptor to use. Relevant in both split & single txq
  *		 and bufq.
  * @next_to_clean: Next descriptor to clean
- * @netdev: &net_device corresponding to this queue
- * @clean_budget: queue cleaning budget
  * @num_completions: Only relevant for TX completion queue. It tracks the
  *		     number of completions received to compare against the
  *		     number of completions pending, as accumulated by the
  *		     TX queues.
+ * @cold: CL group with fields no touched on hotpath
  * @q_id: Queue id
  * @size: Length of descriptor ring in bytes
  * @dma: Physical address of ring
  * @q_vector: Backreference to associated vector
  */
 struct idpf_compl_queue {
-	struct idpf_splitq_tx_compl_desc *comp;
-	struct idpf_txq_group *txq_grp;
-
-	DECLARE_BITMAP(flags, __IDPF_Q_FLAGS_NBITS);
-	u16 desc_count;
-	u16 next_to_use;
-	u16 next_to_clean;
-
-	struct net_device *netdev;
-	u32 clean_budget;
-	u32 num_completions;
+	libeth_cacheline_group(read_mostly,
+		struct idpf_splitq_tx_compl_desc *comp;
+		struct idpf_txq_group *txq_grp;
 
-	/* Slowpath */
-	u32 q_id;
-	u32 size;
-	dma_addr_t dma;
+		DECLARE_BITMAP(flags, __IDPF_Q_FLAGS_NBITS);
+		u32 desc_count;
 
-	struct idpf_q_vector *q_vector;
-} ____cacheline_aligned;
+		u32 clean_budget;
+		struct net_device *netdev;
+	);
+	libeth_cacheline_group(read_write,
+		u32 next_to_use;
+		u32 next_to_clean;
+
+		u32 num_completions;
+	);
+	libeth_cacheline_group(cold,
+		u32 q_id;
+		u32 size;
+		dma_addr_t dma;
+
+		struct idpf_q_vector *q_vector;
+	);
+};
+libeth_cacheline_set_assert(struct idpf_compl_queue, 40, 16, 24);
 
 /**
  * struct idpf_sw_queue
+ * @read_mostly: CL group with rarely written hot fields
  * @ring: Pointer to the ring
  * @flags: See enum idpf_queue_flags_t
  * @desc_count: Descriptor count
+ * @read_write: CL group with both read/write hot fields
  * @next_to_use: Buffer to allocate at
  * @next_to_clean: Next descriptor to clean
  *
@@ -903,13 +953,20 @@ struct idpf_compl_queue {
  * lockless buffer management system and are strictly software only constructs.
  */
 struct idpf_sw_queue {
-	u32 *ring;
-
-	DECLARE_BITMAP(flags, __IDPF_Q_FLAGS_NBITS);
-	u16 desc_count;
-	u16 next_to_use;
-	u16 next_to_clean;
-} ____cacheline_aligned;
+	libeth_cacheline_group(read_mostly,
+		u32 *ring;
+
+		DECLARE_BITMAP(flags, __IDPF_Q_FLAGS_NBITS);
+		u32 desc_count;
+	);
+	libeth_cacheline_group(read_write,
+		u32 next_to_use;
+		u32 next_to_clean;
+	);
+};
+libeth_cacheline_group_assert(struct idpf_sw_queue, read_mostly, 24);
+libeth_cacheline_group_assert(struct idpf_sw_queue, read_write, 8);
+libeth_cacheline_struct_assert(struct idpf_sw_queue, 24, 8);
 
 /**
  * struct idpf_rxq_set
-- 
2.45.1


