Return-Path: <netdev+bounces-71221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DAD8529FA
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 08:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251331F2289C
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38025175AC;
	Tue, 13 Feb 2024 07:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nNFt9zCY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF0717589
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 07:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809680; cv=none; b=BD4eVaw9yqq408KUSd/rng9WpGP6jhUm+Q/78KwNH7m1xERaZDwpuW0lQKaaKfOn2vBqKVxDSZYDwijGb3Y23tIpvxa9AmvPoxTvnS6h1D6E9ej//7xXbuY5Jy9lktOQUgJWAWHOGXaCSvd2ODyQb4UqnFl6wdY/ozIJuRq8qFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809680; c=relaxed/simple;
	bh=XpRcvk2ycbfCby9sRCvRsXe1R+HhnScg1xpwkWpoTP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZn4vedMKxA2iN8EfhyTqOFJeL6Kiz2gsAeyayDsykoKXealxO2JDd0BWagKUg7us8+NHD8rBlw6X5lTkMjIJBo9Pzn37UuNSBOuLxTtXzQ7gQo4qwz/ratlxNaXWAg0Xj9Vb93naRQuPV7ve7UlDjaEez16i1HYXWw/+PXuBFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nNFt9zCY; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5112bd13a4fso5375018e87.0
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 23:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707809675; x=1708414475; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oNmgCoKzExu2HFXlZ+cX7+uAKGh8najCR9nXU/0f0L4=;
        b=nNFt9zCYLkXWSsedKQZmgudj44w/eyk+litdZJl+OqpNiBotXduxN42cVvGvYpJMAg
         uxgPqYA8I0TXPNLR9J+ZK2rWk3I/NR+Ny2tawOS7tBvdnma2s1EbQSoD31Tea2TfH/aP
         VDAdgEEW+KBsYBCBRJY9n9MXBsP/Zb2a8HIrKICT4jaYRUq4Q5B1GuhTi1Dfuy2MKRPU
         a6EPVKUKcI1u6LtwYR9KriKLXO904Cb6Vyx48S/pZPaXPtJKMqPYuP/OtTlC/YSDpsUM
         SIGCfK8KSsg/zwnwMK+inm00M8yTZkxk1o94FPoAM7/4vPyUBUnLOKlBxIn9AT6KrXhQ
         mz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707809675; x=1708414475;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oNmgCoKzExu2HFXlZ+cX7+uAKGh8najCR9nXU/0f0L4=;
        b=Nesb2H3rnh9mLy/bQUvTdnaf0B3Z2LVeyUn0Ed9cWgIpb9QtpxNA/YOxggKyAKaxbX
         2XFmk1ePTWLxmkhfgG1ug+xA0oppew3JdN+VX0ku4KwwkLBG4iAQgi849jGP+oL5C/AD
         bu3nWc0LYBI7JiCHHJCHrkyU6OrP4baWMmWydqqwI362xj9XtHN0sF1inHm1TtslGG4Y
         VYVjlxlGf/hJWZTO43eTlAZeOSS+iF63oDqfj0FJSkyOlYu5hfiAJNcUn/Uura7JF2Vd
         yo7qb5DgooR8B02TZRwPmjZwT55DEpjVv73ExxQCJfb0Q8cIL+fdfuFGJjNHN/NRSQLg
         /4uQ==
X-Gm-Message-State: AOJu0YwbSptftyW/mP2Y2z4ewEX61yRjLzpTA/XxsM/Bpo9YuvBT3ljS
	SlL1CLwnncvlP0zyR7fIq8eKxntq4rwBA4QA8m3jqGPtc8u/a357ZY4Thuy/dC00oOe/KL9tHMu
	Ju5IAU2/2VtFQEQ5iUhikaJrqp6BHIE++nhHevw==
X-Google-Smtp-Source: AGHT+IHCUUkAT8ZAr9cA1XJrvOZJcRI1hNfxXWXDq9VC8ycMS4zFxRhmpMytgn8AuvAqf4USRRbcCmOx6Z9zJq7uATg=
X-Received: by 2002:ac2:521c:0:b0:511:8f42:9ec with SMTP id
 a28-20020ac2521c000000b005118f4209ecmr567836lfl.14.1707809675075; Mon, 12 Feb
 2024 23:34:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707132752.git.lorenzo@kernel.org> <1b7af9f7bac0d144e3fd44dc62320763349e728b.1707132752.git.lorenzo@kernel.org>
In-Reply-To: <1b7af9f7bac0d144e3fd44dc62320763349e728b.1707132752.git.lorenzo@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 13 Feb 2024 09:33:58 +0200
Message-ID: <CAC_iWjJQ0H90xfD1Jq-DZTPC-GwOh+WMiC24=HnerEkqbF=FDA@mail.gmail.com>
Subject: Re: [PATCH v8 net-next 1/4] net: add generic percpu page_pool allocator
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, davem@davemloft.net, 
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, bpf@vger.kernel.org, 
	toke@redhat.com, willemdebruijn.kernel@gmail.com, jasowang@redhat.com, 
	sdf@google.com, hawk@kernel.org, linyunsheng@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Feb 2024 at 13:35, Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> Introduce generic percpu page_pools allocator.
> Moreover add page_pool_create_percpu() and cpuid filed in page_pool struct
> in order to recycle the page in the page_pool "hot" cache if
> napi_pp_put_page() is running on the same cpu.
> This is a preliminary patch to add xdp multi-buff support for xdp running
> in generic mode.
>
> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Reviewed-by: Toke Hoiland-Jorgensen <toke@redhat.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  include/net/page_pool/types.h |  3 +++
>  net/core/dev.c                | 45 +++++++++++++++++++++++++++++++++++
>  net/core/page_pool.c          | 23 ++++++++++++++----
>  net/core/skbuff.c             |  5 ++--
>  4 files changed, 70 insertions(+), 6 deletions(-)
>
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index 76481c465375..3828396ae60c 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -128,6 +128,7 @@ struct page_pool_stats {
>  struct page_pool {
>         struct page_pool_params_fast p;
>
> +       int cpuid;
>         bool has_init_callback;
>
>         long frag_users;
> @@ -203,6 +204,8 @@ struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
>  struct page *page_pool_alloc_frag(struct page_pool *pool, unsigned int *offset,
>                                   unsigned int size, gfp_t gfp);
>  struct page_pool *page_pool_create(const struct page_pool_params *params);
> +struct page_pool *page_pool_create_percpu(const struct page_pool_params *params,
> +                                         int cpuid);
>
>  struct xdp_mem_info;
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 27ba057d06c4..235421d313c3 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -153,6 +153,8 @@
>  #include <linux/prandom.h>
>  #include <linux/once_lite.h>
>  #include <net/netdev_rx_queue.h>
> +#include <net/page_pool/types.h>
> +#include <net/page_pool/helpers.h>
>
>  #include "dev.h"
>  #include "net-sysfs.h"
> @@ -450,6 +452,12 @@ static RAW_NOTIFIER_HEAD(netdev_chain);
>  DEFINE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
>  EXPORT_PER_CPU_SYMBOL(softnet_data);
>
> +/* Page_pool has a lockless array/stack to alloc/recycle pages.
> + * PP consumers must pay attention to run APIs in the appropriate context
> + * (e.g. NAPI context).
> + */
> +static DEFINE_PER_CPU_ALIGNED(struct page_pool *, system_page_pool);
> +
>  #ifdef CONFIG_LOCKDEP
>  /*
>   * register_netdevice() inits txq->_xmit_lock and sets lockdep class
> @@ -11697,6 +11705,27 @@ static void __init net_dev_struct_check(void)
>   *
>   */
>
> +/* We allocate 256 pages for each CPU if PAGE_SHIFT is 12 */
> +#define SYSTEM_PERCPU_PAGE_POOL_SIZE   ((1 << 20) / PAGE_SIZE)
> +
> +static int net_page_pool_create(int cpuid)
> +{
> +#if IS_ENABLED(CONFIG_PAGE_POOL)
> +       struct page_pool_params page_pool_params = {
> +               .pool_size = SYSTEM_PERCPU_PAGE_POOL_SIZE,
> +               .nid = NUMA_NO_NODE,
> +       };
> +       struct page_pool *pp_ptr;
> +
> +       pp_ptr = page_pool_create_percpu(&page_pool_params, cpuid);
> +       if (IS_ERR(pp_ptr))
> +               return -ENOMEM;
> +
> +       per_cpu(system_page_pool, cpuid) = pp_ptr;
> +#endif
> +       return 0;
> +}
> +
>  /*
>   *       This is called single threaded during boot, so no need
>   *       to take the rtnl semaphore.
> @@ -11749,6 +11778,9 @@ static int __init net_dev_init(void)
>                 init_gro_hash(&sd->backlog);
>                 sd->backlog.poll = process_backlog;
>                 sd->backlog.weight = weight_p;
> +
> +               if (net_page_pool_create(i))
> +                       goto out;
>         }
>
>         dev_boot_phase = 0;
> @@ -11776,6 +11808,19 @@ static int __init net_dev_init(void)
>         WARN_ON(rc < 0);
>         rc = 0;
>  out:
> +       if (rc < 0) {
> +               for_each_possible_cpu(i) {
> +                       struct page_pool *pp_ptr;
> +
> +                       pp_ptr = per_cpu(system_page_pool, i);
> +                       if (!pp_ptr)
> +                               continue;
> +
> +                       page_pool_destroy(pp_ptr);
> +                       per_cpu(system_page_pool, i) = NULL;
> +               }
> +       }
> +
>         return rc;
>  }
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 4933762e5a6b..89c835fcf094 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -171,13 +171,16 @@ static void page_pool_producer_unlock(struct page_pool *pool,
>  }
>
>  static int page_pool_init(struct page_pool *pool,
> -                         const struct page_pool_params *params)
> +                         const struct page_pool_params *params,
> +                         int cpuid)
>  {
>         unsigned int ring_qsize = 1024; /* Default */
>
>         memcpy(&pool->p, &params->fast, sizeof(pool->p));
>         memcpy(&pool->slow, &params->slow, sizeof(pool->slow));
>
> +       pool->cpuid = cpuid;
> +
>         /* Validate only known flags were used */
>         if (pool->p.flags & ~(PP_FLAG_ALL))
>                 return -EINVAL;
> @@ -253,10 +256,12 @@ static void page_pool_uninit(struct page_pool *pool)
>  }
>
>  /**
> - * page_pool_create() - create a page pool.
> + * page_pool_create_percpu() - create a page pool for a given cpu.
>   * @params: parameters, see struct page_pool_params
> + * @cpuid: cpu identifier
>   */
> -struct page_pool *page_pool_create(const struct page_pool_params *params)
> +struct page_pool *
> +page_pool_create_percpu(const struct page_pool_params *params, int cpuid)
>  {
>         struct page_pool *pool;
>         int err;
> @@ -265,7 +270,7 @@ struct page_pool *page_pool_create(const struct page_pool_params *params)
>         if (!pool)
>                 return ERR_PTR(-ENOMEM);
>
> -       err = page_pool_init(pool, params);
> +       err = page_pool_init(pool, params, cpuid);
>         if (err < 0)
>                 goto err_free;
>
> @@ -282,6 +287,16 @@ struct page_pool *page_pool_create(const struct page_pool_params *params)
>         kfree(pool);
>         return ERR_PTR(err);
>  }
> +EXPORT_SYMBOL(page_pool_create_percpu);
> +
> +/**
> + * page_pool_create() - create a page pool
> + * @params: parameters, see struct page_pool_params
> + */
> +struct page_pool *page_pool_create(const struct page_pool_params *params)
> +{
> +       return page_pool_create_percpu(params, -1);
> +}
>  EXPORT_SYMBOL(page_pool_create);
>
>  static void page_pool_return_page(struct page_pool *pool, struct page *page);
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index edbbef563d4d..9e5eb47b4025 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -923,9 +923,10 @@ bool napi_pp_put_page(struct page *page, bool napi_safe)
>          */
>         if (napi_safe || in_softirq()) {
>                 const struct napi_struct *napi = READ_ONCE(pp->p.napi);
> +               unsigned int cpuid = smp_processor_id();
>
> -               allow_direct = napi &&
> -                       READ_ONCE(napi->list_owner) == smp_processor_id();
> +               allow_direct = napi && READ_ONCE(napi->list_owner) == cpuid;
> +               allow_direct |= (pp->cpuid == cpuid);
>         }
>
>         /* Driver set this to memory recycling info. Reset it on recycle.
> --
> 2.43.0
>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

