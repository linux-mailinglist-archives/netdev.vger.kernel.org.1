Return-Path: <netdev+bounces-98598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A5F8D1D87
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2D891F23B7E
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393DB171E58;
	Tue, 28 May 2024 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QTja+ggb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E53171E41;
	Tue, 28 May 2024 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716904194; cv=none; b=LdyZGKZFIOrhYPNdfYMUNwzeYva3VglBZbU0REqdyei2r4MAUWMhSVWWVYBBrem12invqMuEI1bunoWRCOobyPNVcIlylGEymvoD3BHV5lxPO4w7HDm3scnTwse7Ma8aOFJhQlSWrpMUMPvLlsNOqWVghMN4m45xSHh6oPwNTsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716904194; c=relaxed/simple;
	bh=HfTLD4S6rwkoYK0h4P9IRQHkN5hvJ0D+MSCj3pqgcgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZhKCo228hZKaAuzaNWFpDeDDSFqEEFy84nWYYaaX6+OgSmP7HWod6GJMBfY2Tio9Q7XFND5UziR9/3101gkBauR/wnQwwHkK8UeYFNr6MEoOc1kVDMqbcytL3eROIxNonblmEmnPZvW63zFfSF6xjFpyP5AgIAf8Te6kjYGNMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QTja+ggb; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716904193; x=1748440193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HfTLD4S6rwkoYK0h4P9IRQHkN5hvJ0D+MSCj3pqgcgM=;
  b=QTja+ggbVqy0dfhMHvnnUaEi6IofnxFQ80c88HovqLw6mNyg6+9PysCO
   lwePjVKOEIGB9ks5LDk8zErbFpp+VMS9gv7kDmqCXRy2m6nnZluToVDxf
   JRnceoIQ+XEiidqV97aoPi3wuAVMioHpXhTNKOgH2BdGPGzjU6WOpZt6a
   iLIG9MOh7ymQ/Zbzi97JjLASrF/mzupgOrIvXnMjIJRKG4T9MvWcUrRnk
   1mnjZnvY/04E4hskWAsL/M767MniaTSPjGNwnTQyAd92zb5ynaalsEB5w
   AI6Jyq7/6nDXNSWdwBaHkeDS0CdO5F7O58/Jt3iJKpD3vQ8YMEA5ECsPa
   Q==;
X-CSE-ConnectionGUID: cUCGfDTvTXe5/XUJDUmCFA==
X-CSE-MsgGUID: kwQ7bWO/RO+2fhB2jUBx/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13437060"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="13437060"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 06:49:52 -0700
X-CSE-ConnectionGUID: ivBc2xwuR6KBExW3/xAPPA==
X-CSE-MsgGUID: SMMzTK2LRImwXCLHKPVhEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="35577456"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 28 May 2024 06:49:49 -0700
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
Subject: [PATCH iwl-next 10/12] libeth: support different types of buffers for Rx
Date: Tue, 28 May 2024 15:48:44 +0200
Message-ID: <20240528134846.148890-11-aleksander.lobakin@intel.com>
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
---
 include/net/libeth/rx.h                |  19 ++++
 drivers/net/ethernet/intel/libeth/rx.c | 132 ++++++++++++++++++++++---
 2 files changed, 140 insertions(+), 11 deletions(-)

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
-- 
2.45.1


