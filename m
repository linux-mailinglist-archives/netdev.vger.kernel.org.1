Return-Path: <netdev+bounces-218083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE44B3B06C
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 03:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86997583E70
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 01:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADF02264C0;
	Fri, 29 Aug 2025 01:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feKcYkf3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868032253EB
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 01:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756430600; cv=none; b=SFrpFTejwA8pWiRuwOK7Z9oJgwUa7YfUNG5nn13xpPX2PzBj/EhkCuJY8SkWnB19h7gna+aoXTSxNIe4LRoXNxoD2dLB2K/a3Ez1ixfrqglwLTM3u7bUjaPARXF+SEUf7EFEf19o7xmlL8kL09Tb0wt3mi4EV9d5HUC9Tf0uz9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756430600; c=relaxed/simple;
	bh=YgAo+gsnARQIcPfS6iPw1jBrGDJ0usj5VDiqF3LQpdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gS6O+q3eInJ0vj3q/gctfIql/gYnwp967Lhdisg96oFe5+qTU6UQjlViBwZk60XWJO4q+zjiImtckQnLvluYGK3J9/wMrWhkMQl6X7vGzs3y6WrWvpIu1jAFZc6ac1O0DtLQ8vhp3mK/F3ZDmEm9v9LXnEKk9t8G5sFBIL87mP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feKcYkf3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E61C4CEF7;
	Fri, 29 Aug 2025 01:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756430600;
	bh=YgAo+gsnARQIcPfS6iPw1jBrGDJ0usj5VDiqF3LQpdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=feKcYkf3WDWQCsmQpQJJbKYZ0DvMZi1GReVuz1xM35hdPBpLRtZ4NoUuPPe8vSa1u
	 44O43pv3Bacx0uQQLonPmGHJWslqcRMDdS3WQM/oyut7rPRqwBiDr3nFOR/gT1g1Fj
	 Yjw1Gj4csACPxIS0064WWhnnPsgbpN/eEbswRzH5JphwkWLZZrXwC58L5Y+he9Dadl
	 YN4I0BzPnojJVPKBrk/Ckg/X1otoSixrGetkSo8EIkshioDPdSj3rYW5nYneWPpKZO
	 5omiifpnUCBlsXh85rtSMtBkFnM8Tsxt3REVdlFtXbHrgvha99eQzj2iggFrL/xUHx
	 LiksXjPFcDlYQ==
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
Subject: [PATCH net-next v2 11/14] eth: fbnic: allocate unreadable page pool for the payloads
Date: Thu, 28 Aug 2025 18:23:01 -0700
Message-ID: <20250829012304.4146195-12-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829012304.4146195-1-kuba@kernel.org>
References: <20250829012304.4146195-1-kuba@kernel.org>
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


