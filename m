Return-Path: <netdev+bounces-110644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3856792DA1F
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 22:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C08C1C219BF
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 20:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1C91990DE;
	Wed, 10 Jul 2024 20:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sxr3LTKH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE2E198A34
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 20:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720643453; cv=none; b=cSgLQ687fKmb90vGl3JFAgtNl4847D25AqJMA1i8oKNGf6Uljsw+6iaH4y8POPCIIrsvheHgMl/sc8+EJbqxqQE4OV7IjBaoW2/eUXS0+pF51QxV+4nyqs9u/yGxgDOAmT0QPo3mQz9KNVKEw1r3tdjH0F1QmDIAHKN2FHBsb2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720643453; c=relaxed/simple;
	bh=1bah0MfsjCnRuFP4aMBC427nVZJNUpv04Ik+h3qa5pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aIq5C1Yvx8www0UIoXJYmS20PuQ9GjXsPtf+WYf52ywWlTUFovg/U1SEHaYEHCG4yCT8m2Aq/KzcBnAkt1EzUt7DN6+roxVnQoDY9RpR2VQlN2VaspUodh0DZDYbBEF0jEKWi+b/ogP6ZQtwoDnXXk/KPxYm57zx3swFsDuD/ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sxr3LTKH; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720643451; x=1752179451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1bah0MfsjCnRuFP4aMBC427nVZJNUpv04Ik+h3qa5pk=;
  b=Sxr3LTKHlDMDwE8FUGantEiFBoInCSbAdSNbUgQq2+qdyFY6UYhwrgCA
   6Ieyun7Hx2BYRkABzbA71fgPcGF3R0u1Q/ZgmaJBnzU3WKhfwX12FM29Y
   XZNQu29wbaBkEgHO63Kpfs9kg8BicifbvU6EFLSKUuLve9hVQg+6zO55d
   61FUJLcqqbmxhVauMvTFAS7ZZBbkMuPBG8VzKpG22D/ZANf0aQEebEsyB
   6BPXys7J42xXHkoxPVfaSlkAMQGmbLdNzNY4snjk8SxwIwPIZR8GmS6Mt
   xDhOZhth4p0vXOdGk3uqlndWO1kh4pxE7npYLR0fRsxJhXbJFnP/I6o7u
   w==;
X-CSE-ConnectionGUID: 4NyEnoYRRWCWV4QgWJDBBg==
X-CSE-MsgGUID: shlQ26R3SVGvw/o7FLs0KA==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="12483788"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="12483788"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 13:30:43 -0700
X-CSE-ConnectionGUID: Vv19I+qxRU69ho4xYyOJRA==
X-CSE-MsgGUID: py0jYaYgSGaWg+k38zHGUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48223892"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 10 Jul 2024 13:30:43 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	anthony.l.nguyen@intel.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	lihong.yang@intel.com,
	willemb@google.com,
	almasrymina@google.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next 12/14] libeth: support different types of buffers for Rx
Date: Wed, 10 Jul 2024 13:30:28 -0700
Message-ID: <20240710203031.188081-13-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240710203031.188081-1-anthony.l.nguyen@intel.com>
References: <20240710203031.188081-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Lobakin <aleksander.lobakin@intel.com>

Unlike previous generations, idpf requires more buffer types for optimal
performance. This includes: header buffers, short buffers, and
no-overhead buffers (w/o headroom and tailroom, for TCP zerocopy when
the header split is enabled).
Introduce libeth Rx buffer type and calculate page_pool params
accordingly. All the HW-related details like buffer alignment are still
accounted. For the header buffers, pick 256 bytes as in most places in
the kernel (have you ever seen frames with bigger headers?).

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/libeth/rx.c | 132 ++++++++++++++++++++++---
 include/net/libeth/rx.h                |  19 ++++
 2 files changed, 140 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/libeth/rx.c b/drivers/net/ethernet/intel/libeth/rx.c
index 6221b88c34ac..d0b158b6e55b 100644
--- a/drivers/net/ethernet/intel/libeth/rx.c
+++ b/drivers/net/ethernet/intel/libeth/rx.c
@@ -6,7 +6,7 @@
 /* Rx buffer management */
 
 /**
- * libeth_rx_hw_len - get the actual buffer size to be passed to HW
+ * libeth_rx_hw_len_mtu - get the actual buffer size to be passed to HW
  * @pp: &page_pool_params of the netdev to calculate the size for
  * @max_len: maximum buffer size for a single descriptor
  *
@@ -14,7 +14,7 @@
  * MTU the @dev has, HW required alignment, minimum and maximum allowed values,
  * and system's page size.
  */
-static u32 libeth_rx_hw_len(const struct page_pool_params *pp, u32 max_len)
+static u32 libeth_rx_hw_len_mtu(const struct page_pool_params *pp, u32 max_len)
 {
 	u32 len;
 
@@ -26,6 +26,118 @@ static u32 libeth_rx_hw_len(const struct page_pool_params *pp, u32 max_len)
 	return len;
 }
 
+/**
+ * libeth_rx_hw_len_truesize - get the short buffer size to be passed to HW
+ * @pp: &page_pool_params of the netdev to calculate the size for
+ * @max_len: maximum buffer size for a single descriptor
+ * @truesize: desired truesize for the buffers
+ *
+ * Return: HW-writeable length per one buffer to pass it to the HW ignoring the
+ * MTU and closest to the passed truesize. Can be used for "short" buffer
+ * queues to fragment pages more efficiently.
+ */
+static u32 libeth_rx_hw_len_truesize(const struct page_pool_params *pp,
+				     u32 max_len, u32 truesize)
+{
+	u32 min, len;
+
+	min = SKB_HEAD_ALIGN(pp->offset + LIBETH_RX_BUF_STRIDE);
+	truesize = clamp(roundup_pow_of_two(truesize), roundup_pow_of_two(min),
+			 PAGE_SIZE << LIBETH_RX_PAGE_ORDER);
+
+	len = SKB_WITH_OVERHEAD(truesize - pp->offset);
+	len = ALIGN_DOWN(len, LIBETH_RX_BUF_STRIDE) ? : LIBETH_RX_BUF_STRIDE;
+	len = min3(len, ALIGN_DOWN(max_len ? : U32_MAX, LIBETH_RX_BUF_STRIDE),
+		   pp->max_len);
+
+	return len;
+}
+
+/**
+ * libeth_rx_page_pool_params - calculate params with the stack overhead
+ * @fq: buffer queue to calculate the size for
+ * @pp: &page_pool_params of the netdev
+ *
+ * Set the PP params to will all needed stack overhead (headroom, tailroom) and
+ * both the HW buffer length and the truesize for all types of buffers. For
+ * "short" buffers, truesize never exceeds the "wanted" one; for the rest,
+ * it can be up to the page size.
+ *
+ * Return: true on success, false on invalid input params.
+ */
+static bool libeth_rx_page_pool_params(struct libeth_fq *fq,
+				       struct page_pool_params *pp)
+{
+	pp->offset = LIBETH_SKB_HEADROOM;
+	/* HW-writeable / syncable length per one page */
+	pp->max_len = LIBETH_RX_PAGE_LEN(pp->offset);
+
+	/* HW-writeable length per buffer */
+	switch (fq->type) {
+	case LIBETH_FQE_MTU:
+		fq->buf_len = libeth_rx_hw_len_mtu(pp, fq->buf_len);
+		break;
+	case LIBETH_FQE_SHORT:
+		fq->buf_len = libeth_rx_hw_len_truesize(pp, fq->buf_len,
+							fq->truesize);
+		break;
+	case LIBETH_FQE_HDR:
+		fq->buf_len = ALIGN(LIBETH_MAX_HEAD, LIBETH_RX_BUF_STRIDE);
+		break;
+	default:
+		return false;
+	}
+
+	/* Buffer size to allocate */
+	fq->truesize = roundup_pow_of_two(SKB_HEAD_ALIGN(pp->offset +
+							 fq->buf_len));
+
+	return true;
+}
+
+/**
+ * libeth_rx_page_pool_params_zc - calculate params without the stack overhead
+ * @fq: buffer queue to calculate the size for
+ * @pp: &page_pool_params of the netdev
+ *
+ * Set the PP params to exclude the stack overhead and both the buffer length
+ * and the truesize, which are equal for the data buffers. Note that this
+ * requires separate header buffers to be always active and account the
+ * overhead.
+ * With the MTU == ``PAGE_SIZE``, this allows the kernel to enable the zerocopy
+ * mode.
+ *
+ * Return: true on success, false on invalid input params.
+ */
+static bool libeth_rx_page_pool_params_zc(struct libeth_fq *fq,
+					  struct page_pool_params *pp)
+{
+	u32 mtu, max;
+
+	pp->offset = 0;
+	pp->max_len = PAGE_SIZE << LIBETH_RX_PAGE_ORDER;
+
+	switch (fq->type) {
+	case LIBETH_FQE_MTU:
+		mtu = READ_ONCE(pp->netdev->mtu);
+		break;
+	case LIBETH_FQE_SHORT:
+		mtu = fq->truesize;
+		break;
+	default:
+		return false;
+	}
+
+	mtu = roundup_pow_of_two(mtu);
+	max = min(rounddown_pow_of_two(fq->buf_len ? : U32_MAX),
+		  pp->max_len);
+
+	fq->buf_len = clamp(mtu, LIBETH_RX_BUF_STRIDE, max);
+	fq->truesize = fq->buf_len;
+
+	return true;
+}
+
 /**
  * libeth_rx_fq_create - create a PP with the default libeth settings
  * @fq: buffer queue struct to fill
@@ -44,19 +156,17 @@ int libeth_rx_fq_create(struct libeth_fq *fq, struct napi_struct *napi)
 		.netdev		= napi->dev,
 		.napi		= napi,
 		.dma_dir	= DMA_FROM_DEVICE,
-		.offset		= LIBETH_SKB_HEADROOM,
 	};
 	struct libeth_fqe *fqes;
 	struct page_pool *pool;
+	bool ret;
 
-	/* HW-writeable / syncable length per one page */
-	pp.max_len = LIBETH_RX_PAGE_LEN(pp.offset);
-
-	/* HW-writeable length per buffer */
-	fq->buf_len = libeth_rx_hw_len(&pp, fq->buf_len);
-	/* Buffer size to allocate */
-	fq->truesize = roundup_pow_of_two(SKB_HEAD_ALIGN(pp.offset +
-							 fq->buf_len));
+	if (!fq->hsplit)
+		ret = libeth_rx_page_pool_params(fq, &pp);
+	else
+		ret = libeth_rx_page_pool_params_zc(fq, &pp);
+	if (!ret)
+		return -EINVAL;
 
 	pool = page_pool_create(&pp);
 	if (IS_ERR(pool))
diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
index f29ea3e34c6c..43574bd6612f 100644
--- a/include/net/libeth/rx.h
+++ b/include/net/libeth/rx.h
@@ -17,6 +17,8 @@
 #define LIBETH_MAX_HEADROOM	LIBETH_SKB_HEADROOM
 /* Link layer / L2 overhead: Ethernet, 2 VLAN tags (C + S), FCS */
 #define LIBETH_RX_LL_LEN	(ETH_HLEN + 2 * VLAN_HLEN + ETH_FCS_LEN)
+/* Maximum supported L2-L4 header length */
+#define LIBETH_MAX_HEAD		roundup_pow_of_two(max(MAX_HEADER, 256))
 
 /* Always use order-0 pages */
 #define LIBETH_RX_PAGE_ORDER	0
@@ -43,6 +45,18 @@ struct libeth_fqe {
 	u32			truesize;
 } __aligned_largest;
 
+/**
+ * enum libeth_fqe_type - enum representing types of Rx buffers
+ * @LIBETH_FQE_MTU: buffer size is determined by MTU
+ * @LIBETH_FQE_SHORT: buffer size is smaller than MTU, for short frames
+ * @LIBETH_FQE_HDR: buffer size is ```LIBETH_MAX_HEAD```-sized, for headers
+ */
+enum libeth_fqe_type {
+	LIBETH_FQE_MTU		= 0U,
+	LIBETH_FQE_SHORT,
+	LIBETH_FQE_HDR,
+};
+
 /**
  * struct libeth_fq - structure representing a buffer (fill) queue
  * @fp: hotpath part of the structure
@@ -50,6 +64,8 @@ struct libeth_fqe {
  * @fqes: array of Rx buffers
  * @truesize: size to allocate per buffer, w/overhead
  * @count: number of descriptors/buffers the queue has
+ * @type: type of the buffers this queue has
+ * @hsplit: flag whether header split is enabled
  * @buf_len: HW-writeable length per each buffer
  * @nid: ID of the closest NUMA node with memory
  */
@@ -63,6 +79,9 @@ struct libeth_fq {
 	);
 
 	/* Cold fields */
+	enum libeth_fqe_type	type:2;
+	bool			hsplit:1;
+
 	u32			buf_len;
 	int			nid;
 };
-- 
2.41.0


