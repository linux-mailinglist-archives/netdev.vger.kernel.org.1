Return-Path: <netdev+bounces-23798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F0676D984
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 23:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7116E281EAB
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 21:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923DD125D4;
	Wed,  2 Aug 2023 21:29:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E5C101FC
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 21:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452C0C433C8;
	Wed,  2 Aug 2023 21:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691011761;
	bh=s5Dw8JAhBv9uOSsXCyz3+dkPe5gQVfLZ75VqV/yv0LE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KpTuLIeDqDwUT5zzLPSj9dMfMPwqB6NB07gEGFDkfmm5hQkfIERn5Tb46wIx86a/t
	 EDxFMTHRNMRYWHAgodmY67Y5L9JvVln7KNkh1i58i+Ufy+LmyI0ql1TaO+EMIG57KI
	 xACefXuRYyqlHx2F0lczTCANaoVNR4PT5i2WXvszQRHUOLl/HJ/v7TIk68HYerpJJF
	 V8qNQ0Xz5hAzIYG/sWTWk5zd7gUGbJRNAnuQdt8TKq/VLOcKjSS8zd099L+XbFLDoc
	 tAlXWLgdAjiWbFYndzK6tEm12I7F+7/OVYFmdWxmZ/fHdfIbl9c6gPJVcBmz/XTn0R
	 kJDgmaNvPMKaQ==
Date: Wed, 2 Aug 2023 14:29:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>, Alexander Duyck
 <alexanderduyck@fb.com>, Jesper Dangaard Brouer <hawk@kernel.org>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Simon Horman
 <simon.horman@corigine.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 5/9] page_pool: don't use driver-set flags
 field directly
Message-ID: <20230802142920.4a777079@kernel.org>
In-Reply-To: <0fe906a2-5ba1-f24a-efd8-7804ef0683b6@intel.com>
References: <20230727144336.1646454-1-aleksander.lobakin@intel.com>
	<20230727144336.1646454-6-aleksander.lobakin@intel.com>
	<a0be882e-558a-9b1d-7514-0aad0080e08c@huawei.com>
	<6f8147ec-b8ad-3905-5279-16817ed6f5ae@intel.com>
	<a7782cf1-e04a-e274-6a87-4952008bcc0c@huawei.com>
	<0fe906a2-5ba1-f24a-efd8-7804ef0683b6@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Aug 2023 15:36:33 +0200 Alexander Lobakin wrote:
> >> You would need a separate patch to convert all the page_pool_create()
> >> users then either way.
> >> And it doesn't look really natural to me to pass both driver-set params
> >> and driver-set flags as separate function arguments. Someone may then
> >> think "why aren't flags just put in the params itself". The fact that
> >> Page Pool copies the whole params in the page_pool struct after
> >> allocating it is internals, page_pool_create() prototype however isn't.
> >> Thoughts? =20
> >=20
> > It just seems odd to me that dma_map and page_frag is duplicated as we
> > seems to have the same info in the page_pool->p.flags. =20
>=20
> It's just because we copy the whole &page_pool_params passed by the
> driver. It doesn't look good to me to define a new structure and copy
> the values field-by-field just to avoid duplicating 3 bits :s

FWIW I'm tempted to do something like the patch below (an obvious move,
I suspect). I want to add another pointer (netdev) to the params and=20
I don't want it to eat up bytes in the first cache line.
The patch is incomplete, we need to stash a one-bit indication in=20
the first cache line to know init_callback is not present without
having to look at @slow. I'll defer doing that cleanly until your
patches land.
With this in place we can move flags outside of @fast, and interpret
it manually while copying all the other members in one go.

--->8-------------------------------

=46rom c1290e74c3ec54090a49d0c88ca9d56c3bede825 Mon Sep 17 00:00:00 2001
From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 2 Aug 2023 14:16:51 -0700
Subject: [PATCH] net: page_pool: split the page_pool_params into fast and s=
low

struct page_pool is rather performance critical and we use
16B of the first cache line to store 2 pointers used only
by test code. Future patches will add more informational
(non-fast path) attributes.

It's convenient for the user of the API to not have to worry
which fields are fast and which are slow path. Use struct
groups to split the params into the two categories internally.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/page_pool.h | 31 +++++++++++++++++++------------
 net/core/page_pool.c    |  7 ++++---
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index 73d4f786418d..f0267279a8cd 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -83,18 +83,22 @@ struct pp_alloc_cache {
  * @offset:	DMA sync address offset for PP_FLAG_DMA_SYNC_DEV
  */
 struct page_pool_params {
-	unsigned int	flags;
-	unsigned int	order;
-	unsigned int	pool_size;
-	int		nid;
-	struct device	*dev;
-	struct napi_struct *napi;
-	enum dma_data_direction dma_dir;
-	unsigned int	max_len;
-	unsigned int	offset;
+	struct_group_tagged(page_pool_params_fast, fast,
+		unsigned int	flags;
+		unsigned int	order;
+		unsigned int	pool_size;
+		int		nid;
+		struct device	*dev;
+		struct napi_struct *napi;
+		enum dma_data_direction dma_dir;
+		unsigned int	max_len;
+		unsigned int	offset;
+	);
+	struct_group_tagged(page_pool_params_slow, slow,
 /* private: used by test code only */
-	void (*init_callback)(struct page *page, void *arg);
-	void *init_arg;
+		void (*init_callback)(struct page *page, void *arg);
+		void *init_arg;
+	);
 };
=20
 #ifdef CONFIG_PAGE_POOL_STATS
@@ -177,7 +181,7 @@ static inline u64 *page_pool_ethtool_stats_get(u64 *dat=
a, void *stats)
 #endif
=20
 struct page_pool {
-	struct page_pool_params p;
+	struct page_pool_params_fast p;
=20
 	struct delayed_work release_dw;
 	void (*disconnect)(void *);
@@ -236,6 +240,9 @@ struct page_pool {
 	refcount_t user_cnt;
=20
 	u64 destroy_cnt;
+
+	/* Slow/Control-path information follows */
+	struct page_pool_params_slow slow;
 };
=20
 struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 5d615a169718..fc3f6878a002 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -173,7 +173,8 @@ static int page_pool_init(struct page_pool *pool,
 {
 	unsigned int ring_qsize =3D 1024; /* Default */
=20
-	memcpy(&pool->p, params, sizeof(pool->p));
+	memcpy(&pool->p, &params->fast, sizeof(pool->p));
+	memcpy(&pool->slow, &params->slow, sizeof(pool->slow));
=20
 	/* Validate only known flags were used */
 	if (pool->p.flags & ~(PP_FLAG_ALL))
@@ -372,8 +373,8 @@ static void page_pool_set_pp_info(struct page_pool *poo=
l,
 {
 	page->pp =3D pool;
 	page->pp_magic |=3D PP_SIGNATURE;
-	if (pool->p.init_callback)
-		pool->p.init_callback(page, pool->p.init_arg);
+	if (pool->slow.init_callback)
+		pool->slow.init_callback(page, pool->slow.init_arg);
 }
=20
 static void page_pool_clear_pp_info(struct page *page)
--=20
2.41.0


