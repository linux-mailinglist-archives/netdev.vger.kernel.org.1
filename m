Return-Path: <netdev+bounces-271717-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2N1HL5tAxGlHxwQAu9opvQ
	(envelope-from <netdev+bounces-271717-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:07:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B2B32B972
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78B033067595
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 20:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8A8364EAF;
	Wed, 25 Mar 2026 20:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FN2CWT0h"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C23366061;
	Wed, 25 Mar 2026 20:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774469217; cv=none; b=smhX8HEN7/GJMWHs+aGKgaSzaLGgl4G1wcE8QxExvQzSlK1eKTSVnKeDgTvLXoPS0QMB7j57xiKnw4EOslHw8GmOq2KhuZy8D2/1g9fSuCYA0OYFlpvVaAXuplezKXjhj2aNZwxnoxUZcaHAHCVV7t2tu4B8e9fbuf2K0WnxwN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774469217; c=relaxed/simple;
	bh=DU63riVq03R3GBBjNM4Ixo8+toZ2Aln8XLz1Wdr4sqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CmEHS0+IYHn0Pq2KwYtoXzrEY3i2Tet1IseR3O8EaFByqvA6y6rxKRS7SVAwsmilOhsY3OOT5Mbiom4f/QY639bsBW1bv7OimcAlP9ZrPXVf96WR6WWsEBAUqA+DTN3XbmbIKvbgMbx0V+RWj+XrirEKF2iyWGcAJKNdKdQ9DXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FN2CWT0h; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774469216; x=1806005216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DU63riVq03R3GBBjNM4Ixo8+toZ2Aln8XLz1Wdr4sqI=;
  b=FN2CWT0hUHpWesXMIiwBwCIpbz4flV31Y7jOyDzQr1MTJaY1PBN7UOus
   n5/bBLmwjJUB2bGO3dbOQGMPVrm/Cx/pY6Hm9CgwhVQ5yrnGRqWj5Vaux
   d0W56dyBwHcpI2E/Sbv1g6+2QW23s8q40jqIgd0SCTXg8C4ACSlzM58K5
   gnV4ahy1V6oJlTjLfXW8VoMhttGFK/4n4VgYXP6piiUK1m+vSJ+Vc4q/G
   Wo3QO6VvDwVyCVLO0ZH9ZQOmdy7RbaW1hbk+D2CoeOuQG993rd5kcEi+t
   JzQTxkK29MlILxJz9n6TN0lzbvcdhAg76r1XpDoKJXPX5q0471cWdVLhB
   Q==;
X-CSE-ConnectionGUID: iqny3TbBQI+8jvLCBh+LzQ==
X-CSE-MsgGUID: qPIIhAxiT5Wq9qU2uIhnyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="93096546"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="93096546"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 13:06:54 -0700
X-CSE-ConnectionGUID: 401zBgU3TvCpC8ORYo/5AA==
X-CSE-MsgGUID: enhtsFgPQ2iA6hqGa8q20g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="229243683"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 25 Mar 2026 13:06:54 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	horms@kernel.org,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v2 1/5] libeth: pass Rx queue index to PP when creating a fill queue
Date: Wed, 25 Mar 2026 13:06:39 -0700
Message-ID: <20260325200644.2528726-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260325200644.2528726-1-anthony.l.nguyen@intel.com>
References: <20260325200644.2528726-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271717-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 20B2B32B972
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alexander Lobakin <aleksander.lobakin@intel.com>

Since recently, page_pool_create() accepts optional stack index of
the Rx queue which the pool will be created for. It can then be
used on control path for stuff like memory providers.
Add the same field to libeth_fq and pass the index from all the
drivers using libeth for managing Rx to simplify implementing MP
support later.
idpf has one libeth_fq per buffer/fill queue and each Rx queue has
two fill queues, but since fill queues can never be shared, we can
store the corresponding Rx queue index there during the
initialization to pass it to libeth.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c |  1 +
 drivers/net/ethernet/intel/ice/ice_base.c   |  2 ++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 13 +++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  2 ++
 drivers/net/ethernet/intel/libeth/rx.c      |  1 +
 include/net/libeth/rx.h                     |  2 ++
 6 files changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 363c42bf3dcf..d3c68659162b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -771,6 +771,7 @@ int iavf_setup_rx_descriptors(struct iavf_ring *rx_ring)
 		.count		= rx_ring->count,
 		.buf_len	= LIBIE_MAX_RX_BUF_LEN,
 		.nid		= NUMA_NO_NODE,
+		.idx		= rx_ring->queue_index,
 	};
 	int ret;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 1667f686ff75..f162cdfc62a7 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -609,6 +609,7 @@ static int ice_rxq_pp_create(struct ice_rx_ring *rq)
 	struct libeth_fq fq = {
 		.count		= rq->count,
 		.nid		= NUMA_NO_NODE,
+		.idx		= rq->q_index,
 		.hsplit		= rq->vsi->hsplit,
 		.xdp		= ice_is_xdp_ena_vsi(rq->vsi),
 		.buf_len	= LIBIE_MAX_RX_BUF_LEN,
@@ -631,6 +632,7 @@ static int ice_rxq_pp_create(struct ice_rx_ring *rq)
 		.count		= rq->count,
 		.type		= LIBETH_FQE_HDR,
 		.nid		= NUMA_NO_NODE,
+		.idx		= rq->q_index,
 		.xdp		= ice_is_xdp_ena_vsi(rq->vsi),
 	};
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 252259993022..45ee5b80479a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -557,6 +557,7 @@ static int idpf_rx_hdr_buf_alloc_all(struct idpf_buf_queue *bufq)
 		.type	= LIBETH_FQE_HDR,
 		.xdp	= idpf_xdp_enabled(bufq->q_vector->vport),
 		.nid	= idpf_q_vector_to_mem(bufq->q_vector),
+		.idx	= bufq->rxq_idx,
 	};
 	int ret;
 
@@ -699,6 +700,7 @@ static int idpf_rx_bufs_init_singleq(struct idpf_rx_queue *rxq)
 		.type		= LIBETH_FQE_MTU,
 		.buf_len	= IDPF_RX_MAX_BUF_SZ,
 		.nid		= idpf_q_vector_to_mem(rxq->q_vector),
+		.idx		= rxq->idx,
 	};
 	int ret;
 
@@ -759,6 +761,7 @@ static int idpf_rx_bufs_init(struct idpf_buf_queue *bufq,
 		.hsplit		= idpf_queue_has(HSPLIT_EN, bufq),
 		.xdp		= idpf_xdp_enabled(bufq->q_vector->vport),
 		.nid		= idpf_q_vector_to_mem(bufq->q_vector),
+		.idx		= bufq->rxq_idx,
 	};
 	int ret;
 
@@ -1913,6 +1916,16 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport,
 							LIBETH_RX_LL_LEN;
 			idpf_rxq_set_descids(rsrc, q);
 		}
+
+		if (!idpf_is_queue_model_split(rsrc->rxq_model))
+			continue;
+
+		for (u32 j = 0; j < rsrc->num_bufqs_per_qgrp; j++) {
+			struct idpf_buf_queue *bufq;
+
+			bufq = &rx_qgrp->splitq.bufq_sets[j].bufq;
+			bufq->rxq_idx = rx_qgrp->splitq.rxq_sets[0]->rxq.idx;
+		}
 	}
 
 err_alloc:
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 4be5b3b6d3ed..a0d92adf11c4 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -748,6 +748,7 @@ libeth_cacheline_set_assert(struct idpf_tx_queue, 64,
  * @size: Length of descriptor ring in bytes
  * @dma: Physical address of ring
  * @q_vector: Backreference to associated vector
+ * @rxq_idx: stack index of the corresponding Rx queue
  * @rx_buffer_low_watermark: RX buffer low watermark
  * @rx_hbuf_size: Header buffer size
  * @rx_buf_size: Buffer size
@@ -791,6 +792,7 @@ struct idpf_buf_queue {
 	dma_addr_t dma;
 
 	struct idpf_q_vector *q_vector;
+	u16 rxq_idx;
 
 	u16 rx_buffer_low_watermark;
 	u16 rx_hbuf_size;
diff --git a/drivers/net/ethernet/intel/libeth/rx.c b/drivers/net/ethernet/intel/libeth/rx.c
index 62521a1f4ec9..8874b714cdcc 100644
--- a/drivers/net/ethernet/intel/libeth/rx.c
+++ b/drivers/net/ethernet/intel/libeth/rx.c
@@ -156,6 +156,7 @@ int libeth_rx_fq_create(struct libeth_fq *fq, struct napi_struct *napi)
 		.order		= LIBETH_RX_PAGE_ORDER,
 		.pool_size	= fq->count,
 		.nid		= fq->nid,
+		.queue_idx	= fq->idx,
 		.dev		= napi->dev->dev.parent,
 		.netdev		= napi->dev,
 		.napi		= napi,
diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
index 5d991404845e..3b3d7acd13c9 100644
--- a/include/net/libeth/rx.h
+++ b/include/net/libeth/rx.h
@@ -71,6 +71,7 @@ enum libeth_fqe_type {
  * @xdp: flag indicating whether XDP is enabled
  * @buf_len: HW-writeable length per each buffer
  * @nid: ID of the closest NUMA node with memory
+ * @idx: stack index of the corresponding Rx queue
  */
 struct libeth_fq {
 	struct_group_tagged(libeth_fq_fp, fp,
@@ -88,6 +89,7 @@ struct libeth_fq {
 
 	u32			buf_len;
 	int			nid;
+	u32			idx;
 };
 
 int libeth_rx_fq_create(struct libeth_fq *fq, struct napi_struct *napi);
-- 
2.47.1


