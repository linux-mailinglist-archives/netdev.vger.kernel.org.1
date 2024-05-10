Return-Path: <netdev+bounces-95513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBD18C27BB
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 17:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2235AB25100
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 15:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68C417556E;
	Fri, 10 May 2024 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="STassKJE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03881171675;
	Fri, 10 May 2024 15:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715354864; cv=none; b=NPLrl+fGKa1yme3YMORy5Etj8Nn5voB4gD/h/WqbVgtxuGPUdicXQdfV2CNIHxPtgjedBXfmaAuwFfzXd3Iuha0jcX1xiT2X5ux4rZIyu0M92EkeUrojd5egVFb6xfeVfMlxX6xeBI2cr/3IDPxqawN2uxc1yp/9H/WJowCxKZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715354864; c=relaxed/simple;
	bh=dcHfwsC47H4Q9WUI+GHlFBQpBQVe5eibuVRrxHZypqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7EyQ9nqIqUp21CPRkiOR0/Q34f7oTy5IYv3d+z4NC0pSEb14C6n4D7GvEMBIRPUqTNKvOopimThcJviBceUsti4QbSf10Fr4PYLe7bk3KsT+hEDTxAyZE3uH690VPOLWW3Up4C7iA9aEBC5+i1WGcR+YLmTvLpUPgg6Mj+Bo9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=STassKJE; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715354855; x=1746890855;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dcHfwsC47H4Q9WUI+GHlFBQpBQVe5eibuVRrxHZypqM=;
  b=STassKJEwq5faa0re0D753lbOB9FiC2m7mxpMT+/JoQonrQ+KOOmha7G
   F01mmHfLIirxRdaT5e9oTHMaCRNA/RSg2Y50z9m06pabmx2fXHSXSQrl2
   4cRaa3ZJJAUR3rf+y6daWnHjjpJu2XGKz2sr3s2Ph/bvp9LrHckYIz40T
   WjEqVJs0VFmZqjTB5d0AMeJ3A7MJC14OzAv+yQ1ITya30aG8Pxg/WIM6G
   xjkd/aszB+OuqOjoh9J0PbHPTFxRdXJNUzOrn8LnN+8b7vv05WFL1TxKR
   TeEUAIe6InND0a324+VKVjo3le8h26YJtEdhHanwOgPojEuv/0igtaKSb
   Q==;
X-CSE-ConnectionGUID: SWnN2VF3RyCoYanMvJFCLg==
X-CSE-MsgGUID: /05SGS7ESeiWHwZmvlL32A==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15152600"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="15152600"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 08:27:35 -0700
X-CSE-ConnectionGUID: 5GMwTn/sQPepF63jbm56MA==
X-CSE-MsgGUID: u92X4obmTtK1wTb12E9URA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="30208268"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 10 May 2024 08:27:32 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC iwl-next 05/12] idpf: strictly assert cachelines of queue and queue vector structures
Date: Fri, 10 May 2024 17:26:13 +0200
Message-ID: <20240510152620.2227312-6-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240510152620.2227312-1-aleksander.lobakin@intel.com>
References: <20240510152620.2227312-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the queue and queue vector structures are separated and layed
out optimally, group the fields as read-mostly, read-write, and cold
cachelines and add size assertions to make sure new features won't push
something out of its place and provoke perf regression.
Despite looking innocent, this gives up to 2% of perf bump on Rx.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h | 370 +++++++++++---------
 1 file changed, 205 insertions(+), 165 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 428b82b4de80..0192d33744ff 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -6,6 +6,7 @@
 
 #include <linux/dim.h>
 
+#include <net/libeth/cache.h>
 #include <net/page_pool/helpers.h>
 #include <net/tcp.h>
 #include <net/netdev_queues.h>
@@ -528,35 +529,43 @@ struct idpf_intr_reg {
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
@@ -641,52 +650,59 @@ struct idpf_txq_stash {
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
  * struct idpf_tx_queue - software structure represting a transmit queue
@@ -750,54 +766,60 @@ struct idpf_rx_queue {
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
  * struct idpf_buf_queue - software structure represting a buffer queue
@@ -822,32 +844,37 @@ struct idpf_tx_queue {
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
+libeth_cacheline_set_assert(struct idpf_buf_queue, 60, 12, 32);
 
 /**
  * struct idpf_compl_queue - software structure represting a completion queue
@@ -870,25 +897,31 @@ struct idpf_buf_queue {
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
+libeth_cacheline_set_assert(struct idpf_compl_queue, 40, 12, 24);
 
 /**
  * struct idpf_sw_queue
@@ -903,13 +936,20 @@ struct idpf_compl_queue {
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
+libeth_cacheline_group_assert(struct idpf_sw_queue, read_mostly, 20);
+libeth_cacheline_group_assert(struct idpf_sw_queue, read_write, 8);
+libeth_cacheline_struct_assert(struct idpf_sw_queue, 20, 8);
 
 /**
  * struct idpf_rxq_set
-- 
2.45.0


