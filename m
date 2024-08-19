Return-Path: <netdev+bounces-119910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9567957778
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 00:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37AB1C2170B
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 22:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BA31DD3B8;
	Mon, 19 Aug 2024 22:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QbaYPezt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB22166F25
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 22:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724106893; cv=none; b=ICndcqNBHXNcMqT+PZNnFdWLIpHjdkP+UpkvXUsl2ATMhuiouj1ZUzknNydsHFa8WBG6S24IW8AtAMO+6KLwMKggZ+PZ4rcJ6MgLcXXJFHHWr0/Dvea3RPsvZwEXH7R8sG3kP9n6EWGoIkm8/KnoxxTJYY6/jTI7Wi3RYL/GIsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724106893; c=relaxed/simple;
	bh=8R2tidISX+EsM5TyfTmqqSRREpEN2iiRlG8ztGDgKgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVYNFm9tHZ0q+PXGHamky1lw10xrs059cjAK1M34BbQpFgbVtiViwxIrC65SMdL0Cvnyw59Z63EIb1RHWKF0CKCMJXYW+glY48ZgMRPGuWlCZh8lAeRbv3+csqdSm/XcXX/Nur6YEIMfBwpsoXDt1q6ybohon6bfHdRCX4/KSQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QbaYPezt; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724106892; x=1755642892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8R2tidISX+EsM5TyfTmqqSRREpEN2iiRlG8ztGDgKgc=;
  b=QbaYPeztPRA/vqa1TJsywhIqJ8aPjFXTtNAhFidUa9GJeiLbsXmcj8Ri
   bQ+c/r5JoMUH8+YBC2I7YnzpXUDzmsZ2pWfVFygV51Mef9aVzbt6iryTZ
   4ThmoNPh3pIHRXewv35/r9/1dMXs0MtVDrN4Ki1VRMvPOnMf5a4rioQ12
   Yd9O+V+ChoR2gp3SLw2ktVsiUo3+G7UQ0kGELsJvFyDLP4LuoMO/zKTw2
   JdaJaoBncvXLv+r96uFSciMkXaZPnTTythFtiyk3cZSnR/wfdYvHwO/X8
   rvjT8UbWsmN2lliXyZa7rCqHUXZUYuvnigJwTJdhJre+gyh/0gn25Wxt1
   w==;
X-CSE-ConnectionGUID: HH9VbHvSRL62x5UHcEXeIw==
X-CSE-MsgGUID: vI1kiWUkQzCUii/Xir9Mdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33535161"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="33535161"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 15:34:50 -0700
X-CSE-ConnectionGUID: 6UbAT1A8RuacmmbGcnW/dg==
X-CSE-MsgGUID: 3HtV9sY1S0OISWgVJO+adw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="64700518"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 19 Aug 2024 15:34:50 -0700
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
Subject: [PATCH net-next v2 3/9] libie: add Tx buffer completion helpers
Date: Mon, 19 Aug 2024 15:34:35 -0700
Message-ID: <20240819223442.48013-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240819223442.48013-1-anthony.l.nguyen@intel.com>
References: <20240819223442.48013-1-anthony.l.nguyen@intel.com>
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


