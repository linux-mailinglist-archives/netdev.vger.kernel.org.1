Return-Path: <netdev+bounces-189215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 060D0AB129F
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81C5524641
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008F829292F;
	Fri,  9 May 2025 11:51:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CEF291161;
	Fri,  9 May 2025 11:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746791509; cv=none; b=YBsuAJawphVz0+ht6v1kbMZ/XQCyM5wojxcUH+Z/5pHtWWW1EcQAUimuT1PMI4yCmBDbLwIiQzmfAJk5+No3y6ZPw0oWEPzNgdgZ5byRp/oQZbO0NH6JaAnKznUhMpIAu3rdB73QoGa7DSdpITuu/RTd15/V9aw0YvTR+RQEbb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746791509; c=relaxed/simple;
	bh=DkJp7wAjvMrUDAYuBwcYLyJ+TyU1S0lf69KyTOnLseo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=enF7NwD8e2jD4kBxPNcAIWL0OzouaJxHZJpFZMONcRcL9V2p7E9zV+J/SdgxKe9v1FKZ/TaPnztdGBWqZdfq3AT1gFqI6/U/zXfTdnkwfRmkq9HZ+w9LdzKan+mqYXAkmdC+VzmuBK89GWwwxwlJ8G6E2ktUAK7b6u0M+q+r26w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-80-681dec49033a
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	kuba@kernel.org,
	almasrymina@google.com,
	ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com,
	hawk@kernel.org,
	akpm@linux-foundation.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	john.fastabend@gmail.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	vishal.moola@gmail.com
Subject: [RFC 15/19] mlx5: use netmem descriptor and API for page pool
Date: Fri,  9 May 2025 20:51:22 +0900
Message-Id: <20250509115126.63190-16-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250509115126.63190-1-byungchul@sk.com>
References: <20250509115126.63190-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsXC9ZZnoa7nG9kMgw9XzC3mrF/DZrH6R4XF
	8gc7WC2+/LzNbrF44TdmiznnW1gsnh57xG5xf9kzFos97duZLXpbfjNbNO1YwWRxYVsfq8Xl
	XXPYLO6t+c9qcWyBmMW3028YLdbvu8Fq8fvHHDYHIY8tK28yeeycdZfdY8GmUo/NK7Q8um5c
	YvbYtKqTzWPTp0nsHneu7WHzODHjN4vHzh2fmTw+Pr3F4vF+31U2j8+b5AJ4o7hsUlJzMstS
	i/TtErgyPhzdwFZwuoWx4vr2bsYGxjO5XYycHBICJhItJ34zwthv+94xg9hsAuoSN278BLNF
	BAwlPj86ztLFyMXBLLCQWeLK4p/sIAlhATeJm8tusoDYLAKqEn+/fGQFsXkFzCTu7frCBDFU
	XmL1hgNAgzg4OIHi/R/VQcJCAqYSy6YsYAOZKSHQzC4x8d5/qCMkJQ6uuMEygZF3ASPDKkah
	zLyy3MTMHBO9jMq8zAq95PzcTYzAOFhW+yd6B+OnC8GHGAU4GJV4eC2ey2YIsSaWFVfmHmKU
	4GBWEuF93imTIcSbklhZlVqUH19UmpNafIhRmoNFSZzX6Ft5ipBAemJJanZqakFqEUyWiYNT
	qoExcWeg6F7rYj8t4eOzrxbv/s7azj05osxDy+GPbPYrkXqn3tcrsl5mdOfsZrfvufDZufB9
	wdO6ix0H5Fi8D5q+Vsr2Do82m3p98pNNPzduiluXedI64f/2HJnNd8o/x5bzBhh33e3gcRM+
	kGfkka8v8XvV0vVxpy8biN356BfKLXL46AXF1rNKLMUZiYZazEXFiQAHayQrfwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsXC5WfdrOv5RjbDYMMCXYs569ewWaz+UWGx
	/MEOVosvP2+zWyxe+I3ZYs75FhaLp8cesVvcX/aMxWJP+3Zmi96W38wWTTtWMFkcnnuS1eLC
	tj5Wi8u75rBZ3Fvzn9Xi2AIxi2+n3zBarN93g9Xi9485bA7CHltW3mTy2DnrLrvHgk2lHptX
	aHl03bjE7LFpVSebx6ZPk9g97lzbw+ZxYsZvFo+dOz4zeXx8eovF4/2+q2wei198YPL4vEku
	gC+KyyYlNSezLLVI3y6BK+PD0Q1sBadbGCuub+9mbGA8k9vFyMkhIWAi8bbvHTOIzSagLnHj
	xk8wW0TAUOLzo+MsXYxcHMwCC5klriz+yQ6SEBZwk7i57CYLiM0ioCrx98tHVhCbV8BM4t6u
	L0wQQ+UlVm84ADSIg4MTKN7/UR0kLCRgKrFsygK2CYxcCxgZVjGKZOaV5SZm5pjqFWdnVOZl
	Vugl5+duYgQG9bLaPxN3MH657H6IUYCDUYmH1+K5bIYQa2JZcWXuIUYJDmYlEd7nnTIZQrwp
	iZVVqUX58UWlOanFhxilOViUxHm9wlMThATSE0tSs1NTC1KLYLJMHJxSDYxPb+dGaoUUHZbJ
	eLCUOT1I+8Sqf/ufLD20Z//7LO7lb3c4XjNySl11e+2Cq60z+l24Bd6tcvSWOd7w5Vfo9/ad
	ff8kWULbCvl89u3TWdjyTNK4emqD8MOz+xoOWCutCPO3+Gvp2LnJTs2H83yyZvaUEvbX7/ZV
	HV58bH9x7a3FF+00ts3z61mixFKckWioxVxUnAgAe95HIWYCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

To simplify struct page, the effort to seperate its own descriptor from
struct page is required and the work for page pool is on going.

Use netmem descriptor and API for page pool in mlx5 code.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  4 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 18 ++---
 .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 15 +++--
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 66 +++++++++----------
 include/linux/skbuff.h                        | 14 ++++
 include/net/page_pool/helpers.h               |  4 ++
 7 files changed, 73 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 32ed4963b8ada..c3992b9961540 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -551,7 +551,7 @@ struct mlx5e_icosq {
 } ____cacheline_aligned_in_smp;
 
 struct mlx5e_frag_page {
-	struct page *page;
+	netmem_ref netmem;
 	u16 frags;
 };
 
@@ -623,7 +623,7 @@ struct mlx5e_dma_info {
 	dma_addr_t addr;
 	union {
 		struct mlx5e_frag_page *frag_page;
-		struct page *page;
+		netmem_ref netmem;
 	};
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index f803e1c935900..886ed930d6a1f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -61,7 +61,7 @@ static inline bool
 mlx5e_xmit_xdp_buff(struct mlx5e_xdpsq *sq, struct mlx5e_rq *rq,
 		    struct xdp_buff *xdp)
 {
-	struct page *page = virt_to_page(xdp->data);
+	netmem_ref netmem = virt_to_netmem(xdp->data);
 	struct mlx5e_xmit_data_frags xdptxdf = {};
 	struct mlx5e_xmit_data *xdptxd;
 	struct xdp_frame *xdpf;
@@ -122,7 +122,7 @@ mlx5e_xmit_xdp_buff(struct mlx5e_xdpsq *sq, struct mlx5e_rq *rq,
 	 * mode.
 	 */
 
-	dma_addr = page_pool_get_dma_addr(page) + (xdpf->data - (void *)xdpf);
+	dma_addr = page_pool_get_dma_addr_netmem(netmem) + (xdpf->data - (void *)xdpf);
 	dma_sync_single_for_device(sq->pdev, dma_addr, xdptxd->len, DMA_BIDIRECTIONAL);
 
 	if (xdptxd->has_frags) {
@@ -134,7 +134,7 @@ mlx5e_xmit_xdp_buff(struct mlx5e_xdpsq *sq, struct mlx5e_rq *rq,
 			dma_addr_t addr;
 			u32 len;
 
-			addr = page_pool_get_dma_addr(skb_frag_page(frag)) +
+			addr = page_pool_get_dma_addr_netmem(skb_frag_netmem(frag)) +
 				skb_frag_off(frag);
 			len = skb_frag_size(frag);
 			dma_sync_single_for_device(sq->pdev, addr, len,
@@ -157,19 +157,19 @@ mlx5e_xmit_xdp_buff(struct mlx5e_xdpsq *sq, struct mlx5e_rq *rq,
 				     (union mlx5e_xdp_info)
 				     { .page.num = 1 + xdptxdf.sinfo->nr_frags });
 		mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo,
-				     (union mlx5e_xdp_info) { .page.page = page });
+				     (union mlx5e_xdp_info) { .page.netmem = netmem });
 		for (i = 0; i < xdptxdf.sinfo->nr_frags; i++) {
 			skb_frag_t *frag = &xdptxdf.sinfo->frags[i];
 
 			mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo,
 					     (union mlx5e_xdp_info)
-					     { .page.page = skb_frag_page(frag) });
+					     { .page.netmem = skb_frag_netmem(frag) });
 		}
 	} else {
 		mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo,
 				     (union mlx5e_xdp_info) { .page.num = 1 });
 		mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo,
-				     (union mlx5e_xdp_info) { .page.page = page });
+				     (union mlx5e_xdp_info) { .page.netmem = netmem });
 	}
 
 	return true;
@@ -702,15 +702,15 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 			num = xdpi.page.num;
 
 			do {
-				struct page *page;
+				netmem_ref netmem;
 
 				xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
-				page = xdpi.page.page;
+				netmem = xdpi.page.netmem;
 
 				/* No need to check ((page->pp_magic & ~0x3UL) == PP_SIGNATURE)
 				 * as we know this is a page_pool page.
 				 */
-				page_pool_recycle_direct(page->pp, page);
+				page_pool_recycle_direct_netmem(netmem_get_pp(netmem), netmem);
 			} while (++n < num);
 
 			break;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
index 446e492c6bb8e..b37541837efba 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
@@ -96,7 +96,7 @@ union mlx5e_xdp_info {
 	union {
 		struct mlx5e_rq *rq;
 		u8 num;
-		struct page *page;
+		netmem_ref netmem;
 	} page;
 	struct xsk_tx_metadata_compl xsk_meta;
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 3506024c24539..c152fd454f605 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -708,24 +708,29 @@ static void mlx5e_rq_err_cqe_work(struct work_struct *recover_work)
 
 static int mlx5e_alloc_mpwqe_rq_drop_page(struct mlx5e_rq *rq)
 {
-	rq->wqe_overflow.page = alloc_page(GFP_KERNEL);
-	if (!rq->wqe_overflow.page)
+	struct page *page = alloc_page(GFP_KERNEL);
+
+	if (!page)
 		return -ENOMEM;
 
-	rq->wqe_overflow.addr = dma_map_page(rq->pdev, rq->wqe_overflow.page, 0,
+	rq->wqe_overflow.addr = dma_map_page(rq->pdev, page, 0,
 					     PAGE_SIZE, rq->buff.map_dir);
 	if (dma_mapping_error(rq->pdev, rq->wqe_overflow.addr)) {
-		__free_page(rq->wqe_overflow.page);
+		__free_page(page);
 		return -ENOMEM;
 	}
+
+	rq->wqe_overflow.netmem = page_to_netmem(page);
 	return 0;
 }
 
 static void mlx5e_free_mpwqe_rq_drop_page(struct mlx5e_rq *rq)
 {
+	struct page *page = netmem_to_page(rq->wqe_overflow.netmem);
+
 	 dma_unmap_page(rq->pdev, rq->wqe_overflow.addr, PAGE_SIZE,
 			rq->buff.map_dir);
-	 __free_page(rq->wqe_overflow.page);
+	 __free_page(page);
 }
 
 static int mlx5e_init_rxq_rq(struct mlx5e_channel *c, struct mlx5e_params *params,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 5fd70b4d55beb..ce7052287b2ce 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -276,16 +276,16 @@ static inline u32 mlx5e_decompress_cqes_start(struct mlx5e_rq *rq,
 static int mlx5e_page_alloc_fragmented(struct mlx5e_rq *rq,
 				       struct mlx5e_frag_page *frag_page)
 {
-	struct page *page;
+	netmem_ref netmem;
 
-	page = page_pool_dev_alloc_pages(rq->page_pool);
-	if (unlikely(!page))
+	netmem = page_pool_dev_alloc_netmem(rq->page_pool, NULL, NULL);
+	if (unlikely(!netmem))
 		return -ENOMEM;
 
-	page_pool_fragment_page(page, MLX5E_PAGECNT_BIAS_MAX);
+	page_pool_fragment_netmem(netmem, MLX5E_PAGECNT_BIAS_MAX);
 
 	*frag_page = (struct mlx5e_frag_page) {
-		.page	= page,
+		.netmem	= netmem,
 		.frags	= 0,
 	};
 
@@ -296,10 +296,10 @@ static void mlx5e_page_release_fragmented(struct mlx5e_rq *rq,
 					  struct mlx5e_frag_page *frag_page)
 {
 	u16 drain_count = MLX5E_PAGECNT_BIAS_MAX - frag_page->frags;
-	struct page *page = frag_page->page;
+	netmem_ref netmem = frag_page->netmem;
 
-	if (page_pool_unref_page(page, drain_count) == 0)
-		page_pool_put_unrefed_page(rq->page_pool, page, -1, true);
+	if (page_pool_unref_netmem(netmem, drain_count) == 0)
+		page_pool_put_unrefed_netmem(rq->page_pool, netmem, -1, true);
 }
 
 static inline int mlx5e_get_rx_frag(struct mlx5e_rq *rq,
@@ -358,7 +358,7 @@ static int mlx5e_alloc_rx_wqe(struct mlx5e_rq *rq, struct mlx5e_rx_wqe_cyc *wqe,
 		frag->flags &= ~BIT(MLX5E_WQE_FRAG_SKIP_RELEASE);
 
 		headroom = i == 0 ? rq->buff.headroom : 0;
-		addr = page_pool_get_dma_addr(frag->frag_page->page);
+		addr = page_pool_get_dma_addr_netmem(frag->frag_page->netmem);
 		wqe->data[i].addr = cpu_to_be64(addr + frag->offset + headroom);
 	}
 
@@ -501,7 +501,7 @@ mlx5e_add_skb_shared_info_frag(struct mlx5e_rq *rq, struct skb_shared_info *sinf
 {
 	skb_frag_t *frag;
 
-	dma_addr_t addr = page_pool_get_dma_addr(frag_page->page);
+	dma_addr_t addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
 
 	dma_sync_single_for_cpu(rq->pdev, addr + frag_offset, len, rq->buff.map_dir);
 	if (!xdp_buff_has_frags(xdp)) {
@@ -514,9 +514,9 @@ mlx5e_add_skb_shared_info_frag(struct mlx5e_rq *rq, struct skb_shared_info *sinf
 	}
 
 	frag = &sinfo->frags[sinfo->nr_frags++];
-	skb_frag_fill_page_desc(frag, frag_page->page, frag_offset, len);
+	skb_frag_fill_netmem_desc(frag, frag_page->netmem, frag_offset, len);
 
-	if (page_is_pfmemalloc(frag_page->page))
+	if (netmem_is_pfmemalloc(frag_page->netmem))
 		xdp_buff_set_frag_pfmemalloc(xdp);
 	sinfo->xdp_frags_size += len;
 }
@@ -527,27 +527,27 @@ mlx5e_add_skb_frag(struct mlx5e_rq *rq, struct sk_buff *skb,
 		   u32 frag_offset, u32 len,
 		   unsigned int truesize)
 {
-	dma_addr_t addr = page_pool_get_dma_addr(frag_page->page);
+	dma_addr_t addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
 	u8 next_frag = skb_shinfo(skb)->nr_frags;
 
 	dma_sync_single_for_cpu(rq->pdev, addr + frag_offset, len,
 				rq->buff.map_dir);
 
-	if (skb_can_coalesce(skb, next_frag, frag_page->page, frag_offset)) {
+	if (skb_can_coalesce_netmem(skb, next_frag, frag_page->netmem, frag_offset)) {
 		skb_coalesce_rx_frag(skb, next_frag - 1, len, truesize);
 	} else {
 		frag_page->frags++;
-		skb_add_rx_frag(skb, next_frag, frag_page->page,
+		skb_add_rx_frag_netmem(skb, next_frag, frag_page->netmem,
 				frag_offset, len, truesize);
 	}
 }
 
 static inline void
 mlx5e_copy_skb_header(struct mlx5e_rq *rq, struct sk_buff *skb,
-		      struct page *page, dma_addr_t addr,
+		      netmem_ref netmem, dma_addr_t addr,
 		      int offset_from, int dma_offset, u32 headlen)
 {
-	const void *from = page_address(page) + offset_from;
+	const void *from = netmem_address(netmem) + offset_from;
 	/* Aligning len to sizeof(long) optimizes memcpy performance */
 	unsigned int len = ALIGN(headlen, sizeof(long));
 
@@ -684,7 +684,7 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 			goto err_unmap;
 
 
-		addr = page_pool_get_dma_addr(frag_page->page);
+		addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
 
 		for (int j = 0; j < MLX5E_SHAMPO_WQ_HEADER_PER_PAGE; j++) {
 			header_offset = mlx5e_shampo_hd_offset(index++);
@@ -794,7 +794,7 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 		err = mlx5e_page_alloc_fragmented(rq, frag_page);
 		if (unlikely(err))
 			goto err_unmap;
-		addr = page_pool_get_dma_addr(frag_page->page);
+		addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
 		umr_wqe->inline_mtts[i] = (struct mlx5_mtt) {
 			.ptag = cpu_to_be64(addr | MLX5_EN_WR),
 		};
@@ -1212,7 +1212,7 @@ static void *mlx5e_shampo_get_packet_hd(struct mlx5e_rq *rq, u16 header_index)
 	struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, header_index);
 	u16 head_offset = mlx5e_shampo_hd_offset(header_index) + rq->buff.headroom;
 
-	return page_address(frag_page->page) + head_offset;
+	return netmem_address(frag_page->netmem) + head_offset;
 }
 
 static void mlx5e_shampo_update_ipv4_udp_hdr(struct mlx5e_rq *rq, struct iphdr *ipv4)
@@ -1673,11 +1673,11 @@ mlx5e_skb_from_cqe_linear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi,
 	dma_addr_t addr;
 	u32 frag_size;
 
-	va             = page_address(frag_page->page) + wi->offset;
+	va             = netmem_address(frag_page->netmem) + wi->offset;
 	data           = va + rx_headroom;
 	frag_size      = MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
 
-	addr = page_pool_get_dma_addr(frag_page->page);
+	addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
 	dma_sync_single_range_for_cpu(rq->pdev, addr, wi->offset,
 				      frag_size, rq->buff.map_dir);
 	net_prefetch(data);
@@ -1727,10 +1727,10 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 
 	frag_page = wi->frag_page;
 
-	va = page_address(frag_page->page) + wi->offset;
+	va = netmem_address(frag_page->netmem) + wi->offset;
 	frag_consumed_bytes = min_t(u32, frag_info->frag_size, cqe_bcnt);
 
-	addr = page_pool_get_dma_addr(frag_page->page);
+	addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
 	dma_sync_single_range_for_cpu(rq->pdev, addr, wi->offset,
 				      rq->buff.frame0_sz, rq->buff.map_dir);
 	net_prefetchw(va); /* xdp_frame data area */
@@ -2000,12 +2000,12 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 
 	if (prog) {
 		/* area for bpf_xdp_[store|load]_bytes */
-		net_prefetchw(page_address(frag_page->page) + frag_offset);
+		net_prefetchw(netmem_address(frag_page->netmem) + frag_offset);
 		if (unlikely(mlx5e_page_alloc_fragmented(rq, &wi->linear_page))) {
 			rq->stats->buff_alloc_err++;
 			return NULL;
 		}
-		va = page_address(wi->linear_page.page);
+		va = netmem_address(wi->linear_page.netmem);
 		net_prefetchw(va); /* xdp_frame data area */
 		linear_hr = XDP_PACKET_HEADROOM;
 		linear_data_len = 0;
@@ -2110,8 +2110,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			while (++pagep < frag_page);
 		}
 		/* copy header */
-		addr = page_pool_get_dma_addr(head_page->page);
-		mlx5e_copy_skb_header(rq, skb, head_page->page, addr,
+		addr = page_pool_get_dma_addr_netmem(head_page->netmem);
+		mlx5e_copy_skb_header(rq, skb, head_page->netmem, addr,
 				      head_offset, head_offset, headlen);
 		/* skb linear part was allocated with headlen and aligned to long */
 		skb->tail += headlen;
@@ -2141,11 +2141,11 @@ mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 		return NULL;
 	}
 
-	va             = page_address(frag_page->page) + head_offset;
+	va             = netmem_address(frag_page->netmem) + head_offset;
 	data           = va + rx_headroom;
 	frag_size      = MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
 
-	addr = page_pool_get_dma_addr(frag_page->page);
+	addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
 	dma_sync_single_range_for_cpu(rq->pdev, addr, head_offset,
 				      frag_size, rq->buff.map_dir);
 	net_prefetch(data);
@@ -2184,7 +2184,7 @@ mlx5e_skb_from_cqe_shampo(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 			  struct mlx5_cqe64 *cqe, u16 header_index)
 {
 	struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, header_index);
-	dma_addr_t page_dma_addr = page_pool_get_dma_addr(frag_page->page);
+	dma_addr_t page_dma_addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
 	u16 head_offset = mlx5e_shampo_hd_offset(header_index);
 	dma_addr_t dma_addr = page_dma_addr + head_offset;
 	u16 head_size = cqe->shampo.header_size;
@@ -2193,7 +2193,7 @@ mlx5e_skb_from_cqe_shampo(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 	void *hdr, *data;
 	u32 frag_size;
 
-	hdr		= page_address(frag_page->page) + head_offset;
+	hdr		= netmem_address(frag_page->netmem) + head_offset;
 	data		= hdr + rx_headroom;
 	frag_size	= MLX5_SKB_FRAG_SZ(rx_headroom + head_size);
 
@@ -2218,7 +2218,7 @@ mlx5e_skb_from_cqe_shampo(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 		}
 
 		net_prefetchw(skb->data);
-		mlx5e_copy_skb_header(rq, skb, frag_page->page, dma_addr,
+		mlx5e_copy_skb_header(rq, skb, frag_page->netmem, dma_addr,
 				      head_offset + rx_headroom,
 				      rx_headroom, head_size);
 		/* skb linear part was allocated with headlen and aligned to long */
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index bf67c47319a56..afec5ebed4372 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3882,6 +3882,20 @@ static inline bool skb_can_coalesce(struct sk_buff *skb, int i,
 	return false;
 }
 
+static inline bool skb_can_coalesce_netmem(struct sk_buff *skb, int i,
+				    const netmem_ref netmem, int off)
+{
+	if (skb_zcopy(skb))
+		return false;
+	if (i) {
+		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i - 1];
+
+		return netmem == skb_frag_netmem(frag) &&
+		       off == skb_frag_off(frag) + skb_frag_size(frag);
+	}
+	return false;
+}
+
 static inline int __skb_linearize(struct sk_buff *skb)
 {
 	return __pskb_pull_tail(skb, skb->data_len) ? 0 : -ENOMEM;
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 9b7a3a996bbea..4deb0b32e4bac 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -150,6 +150,10 @@ static inline netmem_ref page_pool_dev_alloc_netmem(struct page_pool *pool,
 {
 	gfp_t gfp = GFP_ATOMIC | __GFP_NOWARN;
 
+	WARN_ON((!offset && size) || (offset && !size));
+	if (!offset || !size)
+		return page_pool_alloc_netmems(pool, gfp);
+
 	return page_pool_alloc_netmem(pool, offset, size, gfp);
 }
 
-- 
2.17.1


