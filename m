Return-Path: <netdev+bounces-50381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1227F5812
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 07:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A821C20C29
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 06:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910D8CA47;
	Thu, 23 Nov 2023 06:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C61110
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 22:18:19 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SbSZt2cXnzQjKt;
	Thu, 23 Nov 2023 14:17:42 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 Nov
 2023 14:18:17 +0800
Subject: Re: [PATCH net-next v2 1/3] page_pool: Rename pp_frag_count to
 pp_ref_count
To: Liang Chen <liangchen.linux@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<hawk@kernel.org>, <ilias.apalodimas@linaro.org>
CC: <netdev@vger.kernel.org>, <linux-mm@kvack.org>
References: <20231123022516.6757-1-liangchen.linux@gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <2198afb3-4eaf-f41b-d58d-a7585f308c8c@huawei.com>
Date: Thu, 23 Nov 2023 14:18:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231123022516.6757-1-liangchen.linux@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

On 2023/11/23 10:25, Liang Chen wrote:
> To support multiple users referencing the same fragment, pp_frag_count is
> renamed to pp_ref_count to better reflect its actual meaning based on the
> suggestion from [1].

The renaming looks good to me, some minor nit.

It is good to add a cover-letter using 'git format-patch --cover-letter'
to explain the overall background or modifications this patchset make when
there is more than one patch.

> 
> [1]
> http://lore.kernel.org/netdev/f71d9448-70c8-8793-dc9a-0eb48a570300@huawei.com
> 
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> ---
>  include/linux/mm_types.h        |  2 +-
>  include/net/page_pool/helpers.h | 31 ++++++++++++++++++-------------
>  2 files changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 957ce38768b2..64e4572ef06d 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -125,7 +125,7 @@ struct page {
>  			struct page_pool *pp;
>  			unsigned long _pp_mapping_pad;
>  			unsigned long dma_addr;
> -			atomic_long_t pp_frag_count;
> +			atomic_long_t pp_ref_count;

It seems that we may have 4 bytes available for 64 bit arch if we change
the 'atomic_long_t' to 'refcount_t':)

>  		};
>  		struct {	/* Tail pages of compound page */
>  			unsigned long compound_head;	/* Bit zero is set */
> diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
> index 4ebd544ae977..a6dc9412c9ae 100644
> --- a/include/net/page_pool/helpers.h
> +++ b/include/net/page_pool/helpers.h
> @@ -29,7 +29,7 @@
>   * page allocated from page pool. Page splitting enables memory saving and thus
>   * avoids TLB/cache miss for data access, but there also is some cost to
>   * implement page splitting, mainly some cache line dirtying/bouncing for
> - * 'struct page' and atomic operation for page->pp_frag_count.
> + * 'struct page' and atomic operation for page->pp_ref_count.
>   *
>   * The API keeps track of in-flight pages, in order to let API users know when
>   * it is safe to free a page_pool object, the API users must call
> @@ -214,61 +214,66 @@ inline enum dma_data_direction page_pool_get_dma_dir(struct page_pool *pool)
>  	return pool->p.dma_dir;
>  }
>  
> -/* pp_frag_count represents the number of writers who can update the page
> +/* pp_ref_count represents the number of writers who can update the page
>   * either by updating skb->data or via DMA mappings for the device.
>   * We can't rely on the page refcnt for that as we don't know who might be
>   * holding page references and we can't reliably destroy or sync DMA mappings
>   * of the fragments.
>   *
> - * When pp_frag_count reaches 0 we can either recycle the page if the page
> + * pp_ref_count initially corresponds to the number of fragments. However,
> + * when multiple users start to reference a single fragment, for example in
> + * skb_try_coalesce, the pp_ref_count will become greater than the number of
> + * fragments.
> + *
> + * When pp_ref_count reaches 0 we can either recycle the page if the page
>   * refcnt is 1 or return it back to the memory allocator and destroy any
>   * mappings we have.
>   */
>  static inline void page_pool_fragment_page(struct page *page, long nr)
>  {
> -	atomic_long_set(&page->pp_frag_count, nr);
> +	atomic_long_set(&page->pp_ref_count, nr);
>  }
>  
>  static inline long page_pool_defrag_page(struct page *page, long nr)
>  {
>  	long ret;
>  
> -	/* If nr == pp_frag_count then we have cleared all remaining
> +	/* If nr == pp_ref_count then we have cleared all remaining
>  	 * references to the page:
>  	 * 1. 'n == 1': no need to actually overwrite it.
>  	 * 2. 'n != 1': overwrite it with one, which is the rare case
> -	 *              for pp_frag_count draining.
> +	 *              for pp_ref_count draining.
>  	 *
>  	 * The main advantage to doing this is that not only we avoid a atomic
>  	 * update, as an atomic_read is generally a much cheaper operation than
>  	 * an atomic update, especially when dealing with a page that may be
> -	 * partitioned into only 2 or 3 pieces; but also unify the pp_frag_count
> +	 * partitioned into only 2 or 3 pieces; but also unify the pp_ref_count

Maybe "referenced by only 2 or 3 users" is more appropriate now?

>  	 * handling by ensuring all pages have partitioned into only 1 piece
>  	 * initially, and only overwrite it when the page is partitioned into
>  	 * more than one piece.
>  	 */
> -	if (atomic_long_read(&page->pp_frag_count) == nr) {
> +	if (atomic_long_read(&page->pp_ref_count) == nr) {
>  		/* As we have ensured nr is always one for constant case using
>  		 * the BUILD_BUG_ON(), only need to handle the non-constant case
> -		 * here for pp_frag_count draining, which is a rare case.
> +		 * here for pp_ref_count draining, which is a rare case.
>  		 */
>  		BUILD_BUG_ON(__builtin_constant_p(nr) && nr != 1);
>  		if (!__builtin_constant_p(nr))
> -			atomic_long_set(&page->pp_frag_count, 1);
> +			atomic_long_set(&page->pp_ref_count, 1);
>  
>  		return 0;
>  	}
>  
> -	ret = atomic_long_sub_return(nr, &page->pp_frag_count);
> +	ret = atomic_long_sub_return(nr, &page->pp_ref_count);
>  	WARN_ON(ret < 0);
>  
> -	/* We are the last user here too, reset pp_frag_count back to 1 to
> +	/* We are the last user here too, reset pp_ref_count back to 1 to
>  	 * ensure all pages have been partitioned into 1 piece initially,
>  	 * this should be the rare case when the last two fragment users call
>  	 * page_pool_defrag_page() currently.

Do we need to rename the page_pool_defrag_page() and page_pool_is_last_frag()
too?

>  	 */
>  	if (unlikely(!ret))
> -		atomic_long_set(&page->pp_frag_count, 1);
> +		atomic_long_set(&page->pp_ref_count, 1);
>  
>  	return ret;
>  }
> 

