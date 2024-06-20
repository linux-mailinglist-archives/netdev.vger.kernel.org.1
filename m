Return-Path: <netdev+bounces-105315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40529910701
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8121282C0B
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722561AF680;
	Thu, 20 Jun 2024 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WHTAGcR3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8251AE878;
	Thu, 20 Jun 2024 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718891797; cv=none; b=AGug51bzu4c9+Bv0088cmqUYWc5MOT/2ffuCBL8GMceXD+FhbXHukLSXmpxUdSwMrXtxCbv4VwVdXjvNVH0aCXDo/wR8dOVA1lfpVTIrYDZ9AfQJACja4DA905ZbxHY+NQ9NgRVOlOxhQheC+jCQanV5EPriTJnXlPwb5cmul+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718891797; c=relaxed/simple;
	bh=tBpgWNrGObEE7uxZdOt/eYtpFaomwDlWs/XbxltPbEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=beafEuGn6Ch5CtTLyzzBbM12DE5ol/SvdtsKMKqGSv9tutozTVLqjlPTbHd5VnBhuoGpSv9FEuQQEADrSZfHuOOTmUfPzHiM7jtB42f54q5/qqmNasI+7dx20NzAqcHYVi7pE0HyAjke2HOTV92ir+Q1IRn2ydCP2V+XII8DdVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WHTAGcR3; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718891796; x=1750427796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tBpgWNrGObEE7uxZdOt/eYtpFaomwDlWs/XbxltPbEY=;
  b=WHTAGcR3wE6wh1CVgnaGg7L9oDBgqe9rVk5MWjijAQAnLY7q4urY5i00
   n7hyVApQHXhpcMJUPBBwUEF6FJtVPkvRdmshaCVJeX8hRWE5GLSsj2x/6
   Hng1Ug5aN3Te77qb0ETfIJvuqk6DBbCeJpcpv0jobdAI42Yy9AZJQN0Ia
   Y62Q8GUk55rPFHsWfOvC5RZrKXl2BRmc8Ovll6WyhoB76pHFPUum9Jgt8
   yatMaMMPUNx59m/vTRn+p4brZQpmIzGgz3WoFPdw3Nz+MfgqkNL4DT4Ew
   cJHESPgYr03P96sTW0XdnUBNcLxgL/dDBcOTFmC5QerPHKhmp3PJlGfhY
   w==;
X-CSE-ConnectionGUID: xR0H2Sb1QzO1dzHvrBoFGA==
X-CSE-MsgGUID: N7TffcYfQOmmX/h/X4FdkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15987828"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="15987828"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 06:56:35 -0700
X-CSE-ConnectionGUID: HUwdQ21VQ8GvtPNZLotLuQ==
X-CSE-MsgGUID: 3AiqlEikS+6gL/gTQMGRcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="46772071"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jun 2024 06:56:31 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mina Almasry <almasrymina@google.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v2 04/14] idpf: stop using macros for accessing queue descriptors
Date: Thu, 20 Jun 2024 15:53:37 +0200
Message-ID: <20240620135347.3006818-5-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240620135347.3006818-1-aleksander.lobakin@intel.com>
References: <20240620135347.3006818-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In C, we have structures and unions.
Casting `void *` via macros is not only error-prone, but also looks
confusing and awful in general.
In preparation for splitting the queue structs, replace it with a
union and direct array dereferences.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        |  1 -
 .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |  2 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   | 47 ++++++++++---------
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   | 20 ++++----
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 32 ++++++-------
 5 files changed, 52 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index e7a036538246..0b26dd9b8a51 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -20,7 +20,6 @@ struct idpf_vport_max_q;
 #include <linux/dim.h>
 
 #include "virtchnl2.h"
-#include "idpf_lan_txrx.h"
 #include "idpf_txrx.h"
 #include "idpf_controlq.h"
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h
index a5752dcab888..8c7f8ef8f1a1 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h
@@ -4,6 +4,8 @@
 #ifndef _IDPF_LAN_TXRX_H_
 #define _IDPF_LAN_TXRX_H_
 
+#include <linux/bits.h>
+
 enum idpf_rss_hash {
 	IDPF_HASH_INVALID			= 0,
 	/* Values 1 - 28 are reserved for future use */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 551391e20464..6dce14483215 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -8,6 +8,7 @@
 #include <net/tcp.h>
 #include <net/netdev_queues.h>
 
+#include "idpf_lan_txrx.h"
 #include "virtchnl2_lan_desc.h"
 
 #define IDPF_LARGE_MAX_Q			256
@@ -117,24 +118,6 @@ do {								\
 #define IDPF_RXD_EOF_SPLITQ		VIRTCHNL2_RX_FLEX_DESC_ADV_STATUS0_EOF_M
 #define IDPF_RXD_EOF_SINGLEQ		VIRTCHNL2_RX_BASE_DESC_STATUS_EOF_M
 
-#define IDPF_SINGLEQ_RX_BUF_DESC(rxq, i)	\
-	(&(((struct virtchnl2_singleq_rx_buf_desc *)((rxq)->desc_ring))[i]))
-#define IDPF_SPLITQ_RX_BUF_DESC(rxq, i)	\
-	(&(((struct virtchnl2_splitq_rx_buf_desc *)((rxq)->desc_ring))[i]))
-#define IDPF_SPLITQ_RX_BI_DESC(rxq, i) ((((rxq)->ring))[i])
-
-#define IDPF_BASE_TX_DESC(txq, i)	\
-	(&(((struct idpf_base_tx_desc *)((txq)->desc_ring))[i]))
-#define IDPF_BASE_TX_CTX_DESC(txq, i) \
-	(&(((struct idpf_base_tx_ctx_desc *)((txq)->desc_ring))[i]))
-#define IDPF_SPLITQ_TX_COMPLQ_DESC(txcq, i)	\
-	(&(((struct idpf_splitq_tx_compl_desc *)((txcq)->desc_ring))[i]))
-
-#define IDPF_FLEX_TX_DESC(txq, i) \
-	(&(((union idpf_tx_flex_desc *)((txq)->desc_ring))[i]))
-#define IDPF_FLEX_TX_CTX_DESC(txq, i)	\
-	(&(((struct idpf_flex_tx_ctx_desc *)((txq)->desc_ring))[i]))
-
 #define IDPF_DESC_UNUSED(txq)     \
 	((((txq)->next_to_clean > (txq)->next_to_use) ? 0 : (txq)->desc_count) + \
 	(txq)->next_to_clean - (txq)->next_to_use - 1)
@@ -317,8 +300,6 @@ struct idpf_rx_extracted {
 
 #define IDPF_RX_DMA_ATTR \
 	(DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING)
-#define IDPF_RX_DESC(rxq, i)	\
-	(&(((union virtchnl2_rx_desc *)((rxq)->desc_ring))[i]))
 
 struct idpf_rx_buf {
 	struct page *page;
@@ -655,7 +636,15 @@ union idpf_queue_stats {
  * @q_vector: Backreference to associated vector
  * @size: Length of descriptor ring in bytes
  * @dma: Physical address of ring
- * @desc_ring: Descriptor ring memory
+ * @rx: universal receive descriptor array
+ * @single_buf: Rx buffer descriptor array in singleq
+ * @split_buf: Rx buffer descriptor array in splitq
+ * @base_tx: basic Tx descriptor array
+ * @base_ctx: basic Tx context descriptor array
+ * @flex_tx: flex Tx descriptor array
+ * @flex_ctx: flex Tx context descriptor array
+ * @comp: completion descriptor array
+ * @desc_ring: virtual descriptor ring address
  * @tx_max_bufs: Max buffers that can be transmitted with scatter-gather
  * @tx_min_pkt_len: Min supported packet length
  * @num_completions: Only relevant for TX completion queue. It tracks the
@@ -733,7 +722,21 @@ struct idpf_queue {
 	struct idpf_q_vector *q_vector;
 	unsigned int size;
 	dma_addr_t dma;
-	void *desc_ring;
+	union {
+		union virtchnl2_rx_desc *rx;
+
+		struct virtchnl2_singleq_rx_buf_desc *single_buf;
+		struct virtchnl2_splitq_rx_buf_desc *split_buf;
+
+		struct idpf_base_tx_desc *base_tx;
+		struct idpf_base_tx_ctx_desc *base_ctx;
+		union idpf_tx_flex_desc *flex_tx;
+		struct idpf_flex_tx_ctx_desc *flex_ctx;
+
+		struct idpf_splitq_tx_compl_desc *comp;
+
+		void *desc_ring;
+	};
 
 	u16 tx_max_bufs;
 	u8 tx_min_pkt_len;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index 27b93592c4ba..b17d88e15000 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -205,7 +205,7 @@ static void idpf_tx_singleq_map(struct idpf_queue *tx_q,
 	data_len = skb->data_len;
 	size = skb_headlen(skb);
 
-	tx_desc = IDPF_BASE_TX_DESC(tx_q, i);
+	tx_desc = &tx_q->base_tx[i];
 
 	dma = dma_map_single(tx_q->dev, skb->data, size, DMA_TO_DEVICE);
 
@@ -239,7 +239,7 @@ static void idpf_tx_singleq_map(struct idpf_queue *tx_q,
 			i++;
 
 			if (i == tx_q->desc_count) {
-				tx_desc = IDPF_BASE_TX_DESC(tx_q, 0);
+				tx_desc = &tx_q->base_tx[0];
 				i = 0;
 			}
 
@@ -259,7 +259,7 @@ static void idpf_tx_singleq_map(struct idpf_queue *tx_q,
 		i++;
 
 		if (i == tx_q->desc_count) {
-			tx_desc = IDPF_BASE_TX_DESC(tx_q, 0);
+			tx_desc = &tx_q->base_tx[0];
 			i = 0;
 		}
 
@@ -307,7 +307,7 @@ idpf_tx_singleq_get_ctx_desc(struct idpf_queue *txq)
 	memset(&txq->tx_buf[ntu], 0, sizeof(struct idpf_tx_buf));
 	txq->tx_buf[ntu].ctx_entry = true;
 
-	ctx_desc = IDPF_BASE_TX_CTX_DESC(txq, ntu);
+	ctx_desc = &txq->base_ctx[ntu];
 
 	IDPF_SINGLEQ_BUMP_RING_IDX(txq, ntu);
 	txq->next_to_use = ntu;
@@ -455,7 +455,7 @@ static bool idpf_tx_singleq_clean(struct idpf_queue *tx_q, int napi_budget,
 	struct netdev_queue *nq;
 	bool dont_wake;
 
-	tx_desc = IDPF_BASE_TX_DESC(tx_q, ntc);
+	tx_desc = &tx_q->base_tx[ntc];
 	tx_buf = &tx_q->tx_buf[ntc];
 	ntc -= tx_q->desc_count;
 
@@ -517,7 +517,7 @@ static bool idpf_tx_singleq_clean(struct idpf_queue *tx_q, int napi_budget,
 			if (unlikely(!ntc)) {
 				ntc -= tx_q->desc_count;
 				tx_buf = tx_q->tx_buf;
-				tx_desc = IDPF_BASE_TX_DESC(tx_q, 0);
+				tx_desc = &tx_q->base_tx[0];
 			}
 
 			/* unmap any remaining paged data */
@@ -540,7 +540,7 @@ static bool idpf_tx_singleq_clean(struct idpf_queue *tx_q, int napi_budget,
 		if (unlikely(!ntc)) {
 			ntc -= tx_q->desc_count;
 			tx_buf = tx_q->tx_buf;
-			tx_desc = IDPF_BASE_TX_DESC(tx_q, 0);
+			tx_desc = &tx_q->base_tx[0];
 		}
 	} while (likely(budget));
 
@@ -895,7 +895,7 @@ bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_queue *rx_q,
 	if (!cleaned_count)
 		return false;
 
-	desc = IDPF_SINGLEQ_RX_BUF_DESC(rx_q, nta);
+	desc = &rx_q->single_buf[nta];
 	buf = &rx_q->rx_buf.buf[nta];
 
 	do {
@@ -915,7 +915,7 @@ bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_queue *rx_q,
 		buf++;
 		nta++;
 		if (unlikely(nta == rx_q->desc_count)) {
-			desc = IDPF_SINGLEQ_RX_BUF_DESC(rx_q, 0);
+			desc = &rx_q->single_buf[0];
 			buf = rx_q->rx_buf.buf;
 			nta = 0;
 		}
@@ -1016,7 +1016,7 @@ static int idpf_rx_singleq_clean(struct idpf_queue *rx_q, int budget)
 		struct idpf_rx_buf *rx_buf;
 
 		/* get the Rx desc from Rx queue based on 'next_to_clean' */
-		rx_desc = IDPF_RX_DESC(rx_q, ntc);
+		rx_desc = &rx_q->rx[ntc];
 
 		/* status_error_ptype_len will always be zero for unused
 		 * descriptors because it's cleared in cleanup, and overlaps
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index b023704bbbda..01301e640fba 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -531,7 +531,7 @@ static bool idpf_rx_post_buf_desc(struct idpf_queue *bufq, u16 buf_id)
 	struct idpf_rx_buf *buf;
 	dma_addr_t addr;
 
-	splitq_rx_desc = IDPF_SPLITQ_RX_BUF_DESC(bufq, nta);
+	splitq_rx_desc = &bufq->split_buf[nta];
 	buf = &bufq->rx_buf.buf[buf_id];
 
 	if (bufq->rx_hsplit_en) {
@@ -1584,7 +1584,7 @@ do {								\
 	if (unlikely(!(ntc))) {					\
 		ntc -= (txq)->desc_count;			\
 		buf = (txq)->tx_buf;				\
-		desc = IDPF_FLEX_TX_DESC(txq, 0);		\
+		desc = &(txq)->flex_tx[0];			\
 	} else {						\
 		(buf)++;					\
 		(desc)++;					\
@@ -1617,8 +1617,8 @@ static void idpf_tx_splitq_clean(struct idpf_queue *tx_q, u16 end,
 	s16 ntc = tx_q->next_to_clean;
 	struct idpf_tx_buf *tx_buf;
 
-	tx_desc = IDPF_FLEX_TX_DESC(tx_q, ntc);
-	next_pending_desc = IDPF_FLEX_TX_DESC(tx_q, end);
+	tx_desc = &tx_q->flex_tx[ntc];
+	next_pending_desc = &tx_q->flex_tx[end];
 	tx_buf = &tx_q->tx_buf[ntc];
 	ntc -= tx_q->desc_count;
 
@@ -1814,7 +1814,7 @@ static bool idpf_tx_clean_complq(struct idpf_queue *complq, int budget,
 	int i;
 
 	complq_budget = vport->compln_clean_budget;
-	tx_desc = IDPF_SPLITQ_TX_COMPLQ_DESC(complq, ntc);
+	tx_desc = &complq->comp[ntc];
 	ntc -= complq->desc_count;
 
 	do {
@@ -1879,7 +1879,7 @@ static bool idpf_tx_clean_complq(struct idpf_queue *complq, int budget,
 		ntc++;
 		if (unlikely(!ntc)) {
 			ntc -= complq->desc_count;
-			tx_desc = IDPF_SPLITQ_TX_COMPLQ_DESC(complq, 0);
+			tx_desc = &complq->comp[0];
 			change_bit(__IDPF_Q_GEN_CHK, complq->flags);
 		}
 
@@ -2143,7 +2143,7 @@ void idpf_tx_dma_map_error(struct idpf_queue *txq, struct sk_buff *skb,
 		 * used one additional descriptor for a context
 		 * descriptor. Reset that here.
 		 */
-		tx_desc = IDPF_FLEX_TX_DESC(txq, idx);
+		tx_desc = &txq->flex_tx[idx];
 		memset(tx_desc, 0, sizeof(struct idpf_flex_tx_ctx_desc));
 		if (idx == 0)
 			idx = txq->desc_count;
@@ -2202,7 +2202,7 @@ static void idpf_tx_splitq_map(struct idpf_queue *tx_q,
 	data_len = skb->data_len;
 	size = skb_headlen(skb);
 
-	tx_desc = IDPF_FLEX_TX_DESC(tx_q, i);
+	tx_desc = &tx_q->flex_tx[i];
 
 	dma = dma_map_single(tx_q->dev, skb->data, size, DMA_TO_DEVICE);
 
@@ -2275,7 +2275,7 @@ static void idpf_tx_splitq_map(struct idpf_queue *tx_q,
 			i++;
 
 			if (i == tx_q->desc_count) {
-				tx_desc = IDPF_FLEX_TX_DESC(tx_q, 0);
+				tx_desc = &tx_q->flex_tx[0];
 				i = 0;
 				tx_q->compl_tag_cur_gen =
 					IDPF_TX_ADJ_COMPL_TAG_GEN(tx_q);
@@ -2320,7 +2320,7 @@ static void idpf_tx_splitq_map(struct idpf_queue *tx_q,
 		i++;
 
 		if (i == tx_q->desc_count) {
-			tx_desc = IDPF_FLEX_TX_DESC(tx_q, 0);
+			tx_desc = &tx_q->flex_tx[0];
 			i = 0;
 			tx_q->compl_tag_cur_gen = IDPF_TX_ADJ_COMPL_TAG_GEN(tx_q);
 		}
@@ -2553,7 +2553,7 @@ idpf_tx_splitq_get_ctx_desc(struct idpf_queue *txq)
 	txq->tx_buf[i].compl_tag = IDPF_SPLITQ_TX_INVAL_COMPL_TAG;
 
 	/* grab the next descriptor */
-	desc = IDPF_FLEX_TX_CTX_DESC(txq, i);
+	desc = &txq->flex_ctx[i];
 	txq->next_to_use = idpf_tx_splitq_bump_ntu(txq, i);
 
 	return desc;
@@ -3128,7 +3128,6 @@ static int idpf_rx_splitq_clean(struct idpf_queue *rxq, int budget)
 		struct idpf_sw_queue *refillq = NULL;
 		struct idpf_rxq_set *rxq_set = NULL;
 		struct idpf_rx_buf *rx_buf = NULL;
-		union virtchnl2_rx_desc *desc;
 		unsigned int pkt_len = 0;
 		unsigned int hdr_len = 0;
 		u16 gen_id, buf_id = 0;
@@ -3138,8 +3137,7 @@ static int idpf_rx_splitq_clean(struct idpf_queue *rxq, int budget)
 		u8 rxdid;
 
 		/* get the Rx desc from Rx queue based on 'next_to_clean' */
-		desc = IDPF_RX_DESC(rxq, ntc);
-		rx_desc = (struct virtchnl2_rx_flex_desc_adv_nic_3 *)desc;
+		rx_desc = &rxq->rx[ntc].flex_adv_nic_3_wb;
 
 		/* This memory barrier is needed to keep us from reading
 		 * any other fields out of the rx_desc
@@ -3320,11 +3318,11 @@ static void idpf_rx_clean_refillq(struct idpf_queue *bufq,
 	int cleaned = 0;
 	u16 gen;
 
-	buf_desc = IDPF_SPLITQ_RX_BUF_DESC(bufq, bufq_nta);
+	buf_desc = &bufq->split_buf[bufq_nta];
 
 	/* make sure we stop at ring wrap in the unlikely case ring is full */
 	while (likely(cleaned < refillq->desc_count)) {
-		u16 refill_desc = IDPF_SPLITQ_RX_BI_DESC(refillq, ntc);
+		u16 refill_desc = refillq->ring[ntc];
 		bool failure;
 
 		gen = FIELD_GET(IDPF_RX_BI_GEN_M, refill_desc);
@@ -3342,7 +3340,7 @@ static void idpf_rx_clean_refillq(struct idpf_queue *bufq,
 		}
 
 		if (unlikely(++bufq_nta == bufq->desc_count)) {
-			buf_desc = IDPF_SPLITQ_RX_BUF_DESC(bufq, 0);
+			buf_desc = &bufq->split_buf[0];
 			bufq_nta = 0;
 		} else {
 			buf_desc++;
-- 
2.45.2


