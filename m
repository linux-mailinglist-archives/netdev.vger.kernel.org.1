Return-Path: <netdev+bounces-118565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF395952144
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 19:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63930281CDB
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 17:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD25B1BD4E2;
	Wed, 14 Aug 2024 17:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zf/+G3Zv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECAA1BC076
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656808; cv=none; b=nWIU0ZTif/7ob4ecwSdp8Otc/U6a2dAeU4FagJ+XzxKiQqj6mYGUu6Z+FnNdgO//evKCl6LkMAwEenjuB1ofXzlxqAAVEug82/ygQec1l1zmo+FBB5hU6H91q31t2cBvm8T5Hanr9mIBHoW+fnYXns1vU6SIA6/Tb9HpDQc4VDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656808; c=relaxed/simple;
	bh=8R2tidISX+EsM5TyfTmqqSRREpEN2iiRlG8ztGDgKgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTKzpZLr2FDus5KYwS9WCQFDPXZtXFKWNVOuRPN4eqhsExZRDVibZ5CdcZXpNoE4uiphXemM9KS27hM64C29I9hVWiFT4QAgGtwRnndvZiy2dsL4pfkCEBruQDWk1k9di5ud+94tDWzE5Ko6nKMFRPyPU+VrMh9Ux2K17C0D4E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zf/+G3Zv; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723656807; x=1755192807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8R2tidISX+EsM5TyfTmqqSRREpEN2iiRlG8ztGDgKgc=;
  b=Zf/+G3ZvBI5goYRtC/O5yxqQ9ElpohzC9DMgE3p92+ll+d/x2TsaJ4Qc
   RQqU91jyzmW4Som+KhU1m4ecBciIcq9eEBMsZkkiijr2HSkIuDD/EdRm+
   tPj4vlNNDNtFmOmuhfbAYmhSSqYfZ8VouYnrTcQKJfDRaa2lyw2QG+APn
   2ACL8+BdOKz3Bhh3A+u82x+QN9c9Nftz5lVa42Axlbm26iB2JacY5/s2Y
   t0MJDK/OTiKjGXLTVcK0qdaVe2iNZlMKKBskZH4+a2tj89L/VjxePc0sC
   dEm9F8zeXd8fryiIJE3s82hEhH3D78m5X40J9CZ0YN4BvwCkgr/Z/hEiu
   g==;
X-CSE-ConnectionGUID: OrNDshWBT0yLAHA9FXlXKw==
X-CSE-MsgGUID: 0xHFcEZ5SeS8SGIHK2q5CQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="21860572"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="21860572"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 10:33:24 -0700
X-CSE-ConnectionGUID: Y1KpxzsmTlCZm7gmIH+kJg==
X-CSE-MsgGUID: a6Q+zs1FQei82AGiSRtHIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="59233864"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 14 Aug 2024 10:33:24 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	joshua.a.hay@intel.com,
	michal.kubiak@intel.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com
Subject: [PATCH net-next 3/9] libie: add Tx buffer completion helpers
Date: Wed, 14 Aug 2024 10:33:00 -0700
Message-ID: <20240814173309.4166149-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240814173309.4166149-1-anthony.l.nguyen@intel.com>
References: <20240814173309.4166149-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Lobakin <aleksander.lobakin@intel.com>

Software-side Tx buffers for storing DMA, frame size, skb pointers etc.
are pretty much generic and every driver defines them the same way. The
same can be said for software Tx completions -- same napi_consume_skb()s
and all that...
Add a couple simple wrappers for doing that to stop repeating the old
tale at least within the Intel code. Drivers are free to use 'priv'
member at the end of the structure.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 include/net/libeth/tx.h | 127 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 include/net/libeth/tx.h

diff --git a/include/net/libeth/tx.h b/include/net/libeth/tx.h
new file mode 100644
index 000000000000..facfeca96858
--- /dev/null
+++ b/include/net/libeth/tx.h
@@ -0,0 +1,127 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2024 Intel Corporation */
+
+#ifndef __LIBETH_TX_H
+#define __LIBETH_TX_H
+
+#include <net/libeth/stats.h>
+
+/* Tx buffer completion */
+
+/**
+ * enum libeth_sqe_type - type of &libeth_sqe to act on Tx completion
+ * @LIBETH_SQE_EMPTY: unused/empty, no action required
+ * @LIBETH_SQE_CTX: context descriptor with empty SQE, no action required
+ * @LIBETH_SQE_SLAB: kmalloc-allocated buffer, unmap and kfree()
+ * @LIBETH_SQE_FRAG: mapped skb frag, only unmap DMA
+ * @LIBETH_SQE_SKB: &sk_buff, unmap and napi_consume_skb(), update stats
+ */
+enum libeth_sqe_type {
+	LIBETH_SQE_EMPTY		= 0U,
+	LIBETH_SQE_CTX,
+	LIBETH_SQE_SLAB,
+	LIBETH_SQE_FRAG,
+	LIBETH_SQE_SKB,
+};
+
+/**
+ * struct libeth_sqe - represents a Send Queue Element / Tx buffer
+ * @type: type of the buffer, see the enum above
+ * @rs_idx: index of the last buffer from the batch this one was sent in
+ * @raw: slab buffer to free via kfree()
+ * @skb: &sk_buff to consume
+ * @dma: DMA address to unmap
+ * @len: length of the mapped region to unmap
+ * @nr_frags: number of frags in the frame this buffer belongs to
+ * @packets: number of physical packets sent for this frame
+ * @bytes: number of physical bytes sent for this frame
+ * @priv: driver-private scratchpad
+ */
+struct libeth_sqe {
+	enum libeth_sqe_type		type:32;
+	u32				rs_idx;
+
+	union {
+		void				*raw;
+		struct sk_buff			*skb;
+	};
+
+	DEFINE_DMA_UNMAP_ADDR(dma);
+	DEFINE_DMA_UNMAP_LEN(len);
+
+	u32				nr_frags;
+	u32				packets;
+	u32				bytes;
+
+	unsigned long			priv;
+} __aligned_largest;
+
+/**
+ * LIBETH_SQE_CHECK_PRIV - check the driver's private SQE data
+ * @p: type or name of the object the driver wants to fit into &libeth_sqe
+ *
+ * Make sure the driver's private data fits into libeth_sqe::priv. To be used
+ * right after its declaration.
+ */
+#define LIBETH_SQE_CHECK_PRIV(p)					  \
+	static_assert(sizeof(p) <= sizeof_field(struct libeth_sqe, priv))
+
+/**
+ * struct libeth_cq_pp - completion queue poll params
+ * @dev: &device to perform DMA unmapping
+ * @ss: onstack NAPI stats to fill
+ * @napi: whether it's called from the NAPI context
+ *
+ * libeth uses this structure to access objects needed for performing full
+ * Tx complete operation without passing lots of arguments and change the
+ * prototypes each time a new one is added.
+ */
+struct libeth_cq_pp {
+	struct device			*dev;
+	struct libeth_sq_napi_stats	*ss;
+
+	bool				napi;
+};
+
+/**
+ * libeth_tx_complete - perform Tx completion for one SQE
+ * @sqe: SQE to complete
+ * @cp: poll params
+ *
+ * Do Tx complete for all the types of buffers, incl. freeing, unmapping,
+ * updating the stats etc.
+ */
+static inline void libeth_tx_complete(struct libeth_sqe *sqe,
+				      const struct libeth_cq_pp *cp)
+{
+	switch (sqe->type) {
+	case LIBETH_SQE_EMPTY:
+		return;
+	case LIBETH_SQE_SKB:
+	case LIBETH_SQE_FRAG:
+	case LIBETH_SQE_SLAB:
+		dma_unmap_page(cp->dev, dma_unmap_addr(sqe, dma),
+			       dma_unmap_len(sqe, len), DMA_TO_DEVICE);
+		break;
+	default:
+		break;
+	}
+
+	switch (sqe->type) {
+	case LIBETH_SQE_SKB:
+		cp->ss->packets += sqe->packets;
+		cp->ss->bytes += sqe->bytes;
+
+		napi_consume_skb(sqe->skb, cp->napi);
+		break;
+	case LIBETH_SQE_SLAB:
+		kfree(sqe->raw);
+		break;
+	default:
+		break;
+	}
+
+	sqe->type = LIBETH_SQE_EMPTY;
+}
+
+#endif /* __LIBETH_TX_H */
-- 
2.42.0


