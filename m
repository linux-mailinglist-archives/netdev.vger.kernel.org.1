Return-Path: <netdev+bounces-143766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7096D9C414E
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 15:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1D501C21C70
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 14:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D4519FA92;
	Mon, 11 Nov 2024 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VuBL65AA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6722A19F118
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731336988; cv=none; b=l5NpQFTKiA792dWTI0VTTLB8yy2kpYzL08zzRYGAL24oNOBYqEdbr9fCJI8eU+iOmugRIiSKsG/Io5YNm1klnampWqeV2t8aYVkFowq/E4Wp1GA66ya4ie0XT4K5VKbf5txkqB3hBiAjqpNn4SNTngL0O/WU7B9uo5zhj57wYE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731336988; c=relaxed/simple;
	bh=Rc1sRMajBqol8PkpcdIHqktnhJ1mfBUdbymKHe68NlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ObKFDVIeC7e7F8YbcA1QJNXdM4Ikqb4/2FbFslF4c2YaN+wK2J61UJq+0yIPsY2xTRSLDt7TaMKEpHKjCR6mP1O52jmA/p3upwjHDZX80ExOCA/Yq/fdDExkfpFrYPyfRl7s3/ncF6tcGnildCKHxTqPr5gdzBzCxnVLP/LKfYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VuBL65AA; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ea9739647bso3173732a12.0
        for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 06:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731336985; x=1731941785; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eZd/EjnWmgAuy60fuDZKLN+XOAuuOC53CPPMrFonDz0=;
        b=VuBL65AA/E05d6xwa709hWlWIZl9c57hIy/c2i/SFr6w7bYfz5Lh9dm1UY7ssCMwZ4
         yQm4+rGiMvV1tOTCGubmvllMr2hsW5/G6byfZ4TtN2O2P4WURIjSucVl5l+EMPBFX957
         aArT+gmBQPvwy1WJWMwX+/+5XcrvzwDigqJ13w2IK8ngwhpWxEmfCFxiHkUcJPf/zH5R
         8j5NIq1WpXiAGRK069vfTpbPkFqY9q+z0Rdn1SH4NDuC9n4qduGfYvTXzXVpRDFwJsgr
         G5n6OHMrVW/A/o6vuYA/UMoP9j80ZHOlCn3I++sbaM7G4M7kb5MEPXhQRPnhZwkVVNSd
         PvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731336985; x=1731941785;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eZd/EjnWmgAuy60fuDZKLN+XOAuuOC53CPPMrFonDz0=;
        b=t18/YvFE4U9a4m41P3Nr7famBr2Nk+WOoZGrWVNpAU6E1TrIG/VWWkxgIn0Gsg614H
         6hCZBAh1vXmdTjcjYo/sb7MKwS5fgmpzUS37I7zsB5USsXKF/kfI6GJp99fknF2LOYQb
         zHJPt4Kwt9+c8GCOV/XmVLRu1iOY/zsAKCQsVJh5gtjEhUCIhsYahA6jJoAfl63jnlSt
         ax21gyb++GAaca/x5u7xLHFFSkDhpiJuxfKDrXos80qrS1PWQoXxtwlo11wVlGKpnBiU
         nJXQu40quFbnFdBjt7iHkbDIVeQDiDccVXLfL1186y8+pa2jihj5lg2HEy/FaEF/e1lr
         uaig==
X-Forwarded-Encrypted: i=1; AJvYcCVEQKUQHPcBrTDOBtRV3iWit0YIe1n+zJXybjeKHRhNm18r5B4mOcU5wuwvSkQSBWS0TDkFXn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBfg8lVyROT1Q1Pv9+ItVjof765XkxeNikzBL4/ZY3kRS4HLC3
	INpy3lgzccSVUUO+/M2+bQ+OhRyUVjj6hr8tU1/0HQDsEngGOvXPBuCjlGKdCORqJrJJ+enqTXF
	DKNlqtGFPrPU3HAXttknUtdzOhYe/ub+Ocy10mA==
X-Google-Smtp-Source: AGHT+IEoddJNGlcAuhAdV/2qFrS5W1ymI2SyzO6p1e3qF4gI6KrUS7ZUy74kpaWr1/qPfnDdAG3as7+hmNipDqdjJMo=
X-Received: by 2002:a17:90b:4b09:b0:2e2:c98e:c33f with SMTP id
 98e67ed59e1d1-2e9b16eb860mr19570475a91.1.1731336985543; Mon, 11 Nov 2024
 06:56:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109023303.3366500-1-kuba@kernel.org>
In-Reply-To: <20241109023303.3366500-1-kuba@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 11 Nov 2024 16:55:49 +0200
Message-ID: <CAC_iWjLaYV3utEDKwM1UyBtOW-WB179NMF6Qy=-=BnbLan41Gw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: page_pool: do not count normal frag
 allocation in stats
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, hawk@kernel.org, lorenzo@kernel.org, wangjie125@huawei.com, 
	huangguangbin2@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 9 Nov 2024 at 04:33, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Commit 0f6deac3a079 ("net: page_pool: add page allocation stats for
> two fast page allocate path") added increments for "fast path"
> allocation to page frag alloc. It mentions performance degradation
> analysis but the details are unclear. Could be that the author
> was simply surprised by the alloc stats not matching packet count.
>
> In my experience the key metric for page pool is the recycling rate.
> Page return stats, however, count returned _pages_ not frags.
> This makes it impossible to calculate recycling rate for drivers
> using the frag API. Here is example output of the page-pool
> YNL sample for a driver allocating 1200B frags (4k pages)
> with nearly perfect recycling:
>
>   $ ./page-pool
>     eth0[2]     page pools: 32 (zombies: 0)
>                 refs: 291648 bytes: 1194590208 (refs: 0 bytes: 0)
>                 recycling: 33.3% (alloc: 4557:2256365862 recycle: 200476245:551541893)
>
> The recycling rate is reported as 33.3% because we give out
> 4096 // 1200 = 3 frags for every recycled page.
>
> Effectively revert the aforementioned commit. This also aligns
> with the stats we would see for drivers which do the fragmentation
> themselves, although that's not a strong reason in itself.
>
> On the (very unlikely) path where we can reuse the current page
> let's bump the "cached" stat. The fact that we don't put the page
> in the cache is just an optimization.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: hawk@kernel.org
> CC: ilias.apalodimas@linaro.org
> CC: lorenzo@kernel.org
> CC: wangjie125@huawei.com
> CC: huangguangbin2@huawei.com
> ---
>  net/core/page_pool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index a813d30d2135..f89cf93f6eb4 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -950,6 +950,7 @@ netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
>         if (netmem && *offset + size > max_size) {
>                 netmem = page_pool_drain_frag(pool, netmem);
>                 if (netmem) {
> +                       recycle_stat_inc(pool, cached);
>                         alloc_stat_inc(pool, fast);
>                         goto frag_reset;
>                 }
> @@ -974,7 +975,6 @@ netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
>
>         pool->frag_users++;
>         pool->frag_offset = *offset + size;
> -       alloc_stat_inc(pool, fast);
>         return netmem;
>  }
>  EXPORT_SYMBOL(page_pool_alloc_frag_netmem);
> --
> 2.47.0
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

