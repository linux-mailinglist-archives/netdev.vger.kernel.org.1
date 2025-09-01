Return-Path: <netdev+bounces-218924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4148AB3F061
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 23:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D92E64E06D2
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 21:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FC62797A4;
	Mon,  1 Sep 2025 21:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCc2p4Cw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EB7278143
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 21:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756761146; cv=none; b=iKdot32PLavLjLR6RYy8uqVUcUi7s9Evl8GYHw9NqOc2harDK30CNS7ZqLUsfV0rgiu0GmjjLKdUk1njdq9taz//on0b3q4xVXeqyQqf3031nfh7u3uwmgH+ZPVs4/Ci/Fsj5gx1TXjuNWs38a7qq51MuSuwTPipMmkTsFvAbrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756761146; c=relaxed/simple;
	bh=YgAo+gsnARQIcPfS6iPw1jBrGDJ0usj5VDiqF3LQpdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bIh5dU64iTmUZicxcFbekPWYClyDPZo+JwicWo8keXkHvBjb95gE4e0vp8baT/Zn6UGyLfovFAaNZq9U06hJKvLHpiJ9USQe1wFMUSzz9HajIwxsPHoWG6hbTgqHJXl+litjXpxgtvkMObMFWx20KodqWgyPvCvxdkmje3W9szA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCc2p4Cw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4412FC4CEF0;
	Mon,  1 Sep 2025 21:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756761145;
	bh=YgAo+gsnARQIcPfS6iPw1jBrGDJ0usj5VDiqF3LQpdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rCc2p4CwosBNSGx8sdvG4L1sovqlSESq/mvX+12CAjsUT/TQlTEK1wDflah0KUoJf
	 T/Iuqu2v91aC36ZBA5NrloIYLKkwy9zZsvTlO5DpSQA6busNZ1z7vxssQ9HcW4tlkx
	 A+BJrKV8+0oG65LAZLigTvlatuJFT1i0EpMBXAYexwKhaLyWE8kWxgYJ+Euj9RYtD7
	 Ay2LmB/3fjeMeBQNgIpWI7nmnedSgSKHZoHZXcfYc+547C5tEgGLc5YO4Q1R+n7B/4
	 bi7+6AF0EgTG97Q3nQfe1NG05zGrju/SN9yoZ4j12YvMrdhtSDwUY5AKISwCvN6WHm
	 lvY0bDFUVxtbw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	almasrymina@google.com,
	tariqt@nvidia.com,
	dtatulea@nvidia.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	alexanderduyck@fb.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 11/14] eth: fbnic: allocate unreadable page pool for the payloads
Date: Mon,  1 Sep 2025 14:12:11 -0700
Message-ID: <20250901211214.1027927-12-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901211214.1027927-1-kuba@kernel.org>
References: <20250901211214.1027927-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow allocating a page pool with unreadable memory for the payload
ring (sub1). We need to provide the queue ID so that the memory provider
can match the PP. Use the appropriate page pool DMA sync helper.
For unreadable mem the direction has to be FROM_DEVICE. The default
is BIDIR for XDP, but obviously unreadable mem is not compatible
with XDP in the first place, so that's fine. While at it remove
the define for page pool flags.

The rxq_idx is passed to fbnic_alloc_rx_qt_resources() explicitly
to make it easy to allocate page pools without NAPI (see the patch
after the next).

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - update commit msg
v1: https://lore.kernel.org/20250820025704.166248-13-kuba@kernel.org
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 31 +++++++++++++-------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 7694b25ef77d..2727cc037663 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -997,9 +997,8 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
 		  FBNIC_BD_FRAG_SIZE;
 
 	/* Sync DMA buffer */
-	dma_sync_single_range_for_cpu(nv->dev,
-				      page_pool_get_dma_addr_netmem(netmem),
-				      pg_off, truesize, DMA_BIDIRECTIONAL);
+	page_pool_dma_sync_netmem_for_cpu(qt->sub1.page_pool, netmem,
+					  pg_off, truesize);
 
 	added = xdp_buff_add_frag(&pkt->buff, netmem, pg_off, len, truesize);
 	if (unlikely(!added)) {
@@ -1515,16 +1514,14 @@ void fbnic_free_napi_vectors(struct fbnic_net *fbn)
 			fbnic_free_napi_vector(fbn, fbn->napi[i]);
 }
 
-#define FBNIC_PAGE_POOL_FLAGS \
-	(PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV)
-
 static int
 fbnic_alloc_qt_page_pools(struct fbnic_net *fbn, struct fbnic_napi_vector *nv,
-			  struct fbnic_q_triad *qt)
+			  struct fbnic_q_triad *qt, unsigned int rxq_idx)
 {
 	struct page_pool_params pp_params = {
 		.order = 0,
-		.flags = FBNIC_PAGE_POOL_FLAGS,
+		.flags = PP_FLAG_DMA_MAP |
+			 PP_FLAG_DMA_SYNC_DEV,
 		.pool_size = fbn->hpq_size + fbn->ppq_size,
 		.nid = NUMA_NO_NODE,
 		.dev = nv->dev,
@@ -1533,6 +1530,7 @@ fbnic_alloc_qt_page_pools(struct fbnic_net *fbn, struct fbnic_napi_vector *nv,
 		.max_len = PAGE_SIZE,
 		.napi	= &nv->napi,
 		.netdev	= fbn->netdev,
+		.queue_idx = rxq_idx,
 	};
 	struct page_pool *pp;
 
@@ -1553,10 +1551,23 @@ fbnic_alloc_qt_page_pools(struct fbnic_net *fbn, struct fbnic_napi_vector *nv,
 		return PTR_ERR(pp);
 
 	qt->sub0.page_pool = pp;
-	page_pool_get(pp);
+	if (netif_rxq_has_unreadable_mp(fbn->netdev, rxq_idx)) {
+		pp_params.flags |= PP_FLAG_ALLOW_UNREADABLE_NETMEM;
+		pp_params.dma_dir = DMA_FROM_DEVICE;
+
+		pp = page_pool_create(&pp_params);
+		if (IS_ERR(pp))
+			goto err_destroy_sub0;
+	} else {
+		page_pool_get(pp);
+	}
 	qt->sub1.page_pool = pp;
 
 	return 0;
+
+err_destroy_sub0:
+	page_pool_destroy(pp);
+	return PTR_ERR(pp);
 }
 
 static void fbnic_ring_init(struct fbnic_ring *ring, u32 __iomem *doorbell,
@@ -1961,7 +1972,7 @@ static int fbnic_alloc_rx_qt_resources(struct fbnic_net *fbn,
 	struct device *dev = fbn->netdev->dev.parent;
 	int err;
 
-	err = fbnic_alloc_qt_page_pools(fbn, nv, qt);
+	err = fbnic_alloc_qt_page_pools(fbn, nv, qt, qt->cmpl.q_idx);
 	if (err)
 		return err;
 
-- 
2.51.0


