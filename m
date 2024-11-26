Return-Path: <netdev+bounces-147527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9F89D9EFB
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 22:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1DC5284E11
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 21:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DB21DF961;
	Tue, 26 Nov 2024 21:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dAF5SO5u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10F81AE009
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 21:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732657886; cv=none; b=qqEs/5dBCYMbHNtNJOJJ8n4SjArKjdSYNCpSq/KM2i1WSNtm0eitPYVjSXB4IC2Kvt9ZqPLUd1MlklndBsou2dGQSajOIpt7sYd+5E5JaDEl2Lox00qALO7DskZB39aev6LTSclYhUHh/DlM1P1DJS6wzhbc3ngFbmR1Jxx6Zv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732657886; c=relaxed/simple;
	bh=845xXqnB33nlJjULLO/nrCqGOfiZyHwIgYSmqaNLCHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScYU4joY2OOi3iMsTtxKEf8T0neZA7UjRTj5kMzmP+nyd/Goz5921dJNAYoM6o1MbeE1TfuP+firQagUcv2Y9TurVGBVtCuE0wLvDx9Y30dvwNDPFePmfZdXXBu0M3xa1ZPfOohNkm8hGkPD1saBz6NckzyZmqUpMnl+9O/8mGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dAF5SO5u; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4668caacfb2so24971cf.0
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 13:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732657883; x=1733262683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4n8OSPqRkLvx2KI0lecepo254y3Ft1HLiSCqdymG99Q=;
        b=dAF5SO5ucAefSepms13lo3ST4YpuQjgkSHLNKPlhs4aUmKbCELCSmotfi/3f4+5cMx
         aZcqp0bTR1zuENQ2BXm2BEEWjBitIu7LC+TxrBWu57Ro+RRac9hWX+J+AJPVObkpYzGg
         PWjq2W7xvF1s6ElP00pulcIddpyr3eLPcoLHD1VKKoNDx3m4FynbKJUJLchLm7kBAwIB
         szKgjOOX8C5J89oXaYcvEOxirJN2PVVp3Q41882qprGO64pOL1ugj5XSujYQLwYPxRW/
         h9Y9l94jerxzfjfqAJvpBdg0+0+bxuZOwDNBU5zlRbxvSFTaQSz7GKdlZhKDStmsEXT/
         kL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732657883; x=1733262683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4n8OSPqRkLvx2KI0lecepo254y3Ft1HLiSCqdymG99Q=;
        b=qkoHveN86wHr6sOZJ88F/L+v0sO9RUaB8vclRCRmwV13uMkHD4i6XJPDmFMO/WjBaV
         IvWtvKC3W2mPu3CAnphULGgpaNPK4ZGNF3XTZR+isM4zo/7KPY1wZTz1fh430RtHFLgC
         xzLgraC2fettnDVcsU0jIT6tfcC+DN5wuWydIGjLVR/ZxTfVfDzPoA262B5YwKSp7c9P
         qczLs1cLe2OcMsE9rTge6pTbRG5XitMZLB4pn0JJK/HyRAowk17czyE5pbz0jikj9UUt
         m+rYy4CBNqxAyM46ub0Fxo6m+G/jjVkjQ4NOkrFt+4gzETX3cyxBMpTgMJRozQA3c7+I
         ySoA==
X-Forwarded-Encrypted: i=1; AJvYcCXFnjZEpXZzTWm8C/wJiPAPq7MXY4/cuk+kPvqX0sy7vXe7gB7GQQqMl/v3UPwpNvNs61QS24w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZjZ0rM/df8WbLErUnpDpLLCfvaphRCIlYeNyJieNWrxo6HwQg
	8zD5lEwi4EHc3bEfdohx+BQlRluG77x+w4Viv6UNlEwFlRGAYbS8lkPz6cHsjgWlb5yu8HdlZ7t
	cXpZ5tze30ovak2kimNJQAifS5eQxpmhxUZ+/
X-Gm-Gg: ASbGnct9Co6KVsw6u54utKjmkuvq0seK8yzWTQ1v+5K67udHj8eSqpfqW5VIG0BNlTX
	6BfRmGknDTJRjWp+7XBHmJfxQwOpTukoHEJqfSplqdZIYOo+AKw0UBLSSfX60aQ==
X-Google-Smtp-Source: AGHT+IEEk5aN1eOwnEFKq2VpTSyQGdQBHpkfnICA0k0tDUjJ3oDS7OJn1bkFEhhsrwVy9UKRgNHio5nOyVpIPjmGRwc=
X-Received: by 2002:a05:622a:5e83:b0:461:48f9:4852 with SMTP id
 d75a77b69052e-466b3dc63bcmr655761cf.28.1732657883030; Tue, 26 Nov 2024
 13:51:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120103456.396577-1-linyunsheng@huawei.com>
 <20241120103456.396577-3-linyunsheng@huawei.com> <3366bf89-4544-4b82-83ec-fd89dd009228@kernel.org>
 <27475b57-eda1-4d67-93f2-5ca443632f6b@huawei.com>
In-Reply-To: <27475b57-eda1-4d67-93f2-5ca443632f6b@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 26 Nov 2024 13:51:11 -0800
Message-ID: <CAHS8izM+sK=48gfa3gRNffu=T6t6-2vaS60QvH79zFA3gSDv9g@mail.gmail.com>
Subject: Re: [PATCH RFC v4 2/3] page_pool: fix IOMMU crash when driver has
 already unbound
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, liuyonglong@huawei.com, fanghaiqing@huawei.com, 
	zhangkun09@huawei.com, Robin Murphy <robin.murphy@arm.com>, 
	Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 12:03=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.c=
om> wrote:
>
> On 2024/11/20 23:10, Jesper Dangaard Brouer wrote:
> >
> >>       page_pool_detached(pool);
> >>       pool->defer_start =3D jiffies;
> >>       pool->defer_warn  =3D jiffies + DEFER_WARN_INTERVAL;
> >> @@ -1159,7 +1228,7 @@ void page_pool_update_nid(struct page_pool *pool=
, int new_nid)
> >>       /* Flush pool alloc cache, as refill will check NUMA node */
> >>       while (pool->alloc.count) {
> >>           netmem =3D pool->alloc.cache[--pool->alloc.count];
> >> -        page_pool_return_page(pool, netmem);
> >> +        __page_pool_return_page(pool, netmem);
> >>       }
> >>   }
> >>   EXPORT_SYMBOL(page_pool_update_nid);
> >
> > Thanks for continuing to work on this :-)
>
> I am not sure how scalable the scanning is going to be if the memory size=
 became
> bigger, which is one of the reason I was posting it as RFC for this versi=
on.
>
> For some quick searching here, it seems there might be server with max ra=
m capacity
> of 12.3TB, which means the scanning might take up to about 10 secs for th=
ose systems.
> The spin_lock is used to avoid concurrency as the page_pool_put_page() AP=
I might be
> called from the softirq context, which might mean there might be spinning=
 of 12 secs
> in the softirq context.
>
> And it seems hard to call cond_resched() when the scanning and unmapping =
takes a lot
> of time as page_pool_put_page() might be called concurrently when pool->d=
estroy_lock
> is released, which might means page_pool_get_dma_addr() need to be checke=
d to decide
> if the mapping is already done or not for each page.
>
> Also, I am not sure it is appropriate to stall the driver unbound up to 1=
0 secs here
> for those large memory systems.
>
> https://www.broadberry.com/12tb-ram-supermicro-servers?srsltid=3DAfmBOorC=
PCZQBSv91mOGH3WTg9Cq0MhksnVYL_eXxOHtHJyuYzjyvwgH
>

FWIW I'm also concerned about the looping of all memory on the system.
In addition to the performance, I think (but not sure), that
CONFIG_MEMORY_HOTPLUG may mess such a loop as memory may appear or
disappear concurrently. Even if not, the CPU cost of this may be
significant. I'm imagining the possibility of having many page_pools
allocated on the system for many hardware queues, (and maybe multiple
pp's per queue for applications like devmem TCP), and each pp looping
over the entire xTB memory on page_pool_destroy()...

My 2 cents here is that a more reasonable approach is to have the pp
track all pages it has dma-mapped, without the problems in the
previous iterations of this patch:

1. When we dma-map a page, we add it to some pp->dma_mapped data
structure (maybe xarray or rculist).
2. When we dma-unmap a page, we remove it from pp->dma_mapped.
3 When we destroy the pp, we traverse pp->dma_mapped and unmap all the
pages there.

I haven't looked deeply, but with the right data structure we may be
able to synchronize 1, 2, and 3 without any additional locks. From a
quick skim it seems maybe rculist and xarray can do this without
additional locks, maybe.

Like stated in the previous iterations of this approach, we should not
be putting any hard limit on the amount of memory the pp can allocate,
and we should not have to mess with the page->pp entry in struct page.

--=20
Thanks,
Mina

