Return-Path: <netdev+bounces-147619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACAF9DABC3
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 17:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFFC3281F65
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 16:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9383200B95;
	Wed, 27 Nov 2024 16:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjsPMIdE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF66C2581;
	Wed, 27 Nov 2024 16:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724860; cv=none; b=txluGMf5itTjRiGPS2lCYKSf+n/oiIATgkgCMO6lJxVtlRriyqUuhrpmfuWIF6HGlOnm67RE4MMraKRyfHn5THGE2ClmXjnJ/jGtO0Lc/93NyXRO+6SFyGb1/mD2E2WDK9GHEpGLPeKk9OxcZHNktYFlZYVfCHNNIYBCmNzRRHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724860; c=relaxed/simple;
	bh=iADUC2p9Xf4qa0czb/Ja4hLEYXyP6low1aLqYk7dSwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kr95moos4F9bhwodgYf8sOs152QtJd0gNb0GEE7vi7bZLmekcaCMN8tOggY6qaZgfhBeusgyw9W9y8w0jL5ui7GbGp8+L6W+Z9GeCAbfkZeXB0Bh8RURAKyzEOhk7yeR1Mg1dkr4IIF5icerFRNvn8gIM5FYWPTOIAKFXiHUgog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjsPMIdE; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38248b810ffso5297644f8f.0;
        Wed, 27 Nov 2024 08:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732724857; x=1733329657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6I/PKx4AbOtXDrsC/W9UiLLi4+KmiegPWZJSbvoADs=;
        b=QjsPMIdEhS4Vchdv6cSJppyBJMXw9uXo63RQVCb4eMhq53lzXXC54wJ4YfOE9OmSYQ
         sPbcOXXT6gf9rCD3NllutP/iV3ZLbEafjdBV48efUkGj25P8AJFs2nhKUL4t4k2s4rmy
         J9rJfVhuIW70m5fPtAs/NI/8lcAyng4SgVQOvlrk0R8g6Ttyk4yS3Yfe3gy12Yo+Vkoi
         IFAlwcananmZx+5cVnARSnVsMPbS7mSZM6mWOHF7l18FUb3IC+8exdbIorHqc/oK0yOf
         7hAsIwg6NwVxtDI8esh4aMGKJgrIb2g1zYEwr8fx1MQAiNgLk6iyLWXkRdS6M2DPPr1R
         Nwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732724857; x=1733329657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6I/PKx4AbOtXDrsC/W9UiLLi4+KmiegPWZJSbvoADs=;
        b=ce84LY5kyKV9p7pz8h40qBni+Kh/U7IpKyCj21CwHhik938KlI3HdpvSt6xVy0c4TA
         1YjfPYhahRWdiF/8gGA1RgQ6Lj1e9OiD+GLQVuCxP1+LM3qkCDsaUuT5HOimTxRI5mb5
         OcxQG0MT4quQ8Kx4gOourSyHx9PvwT6bB24Z75/bWoXkwZ9lmxvWTrvh4csDh51SuQlB
         FSAAXjQBAN+DqzZxceTGJiiaWKiKUDmN/IS9gOV4Ju5B63bAJm1zC6lgEVCTle9wBPbE
         pVzn1EIf4uif5ggT8bg4uonAR6AqeWeJPlqY5QVthf/Mn9fqPC4FntuB1Diojg4E6dN2
         G1jw==
X-Forwarded-Encrypted: i=1; AJvYcCUdcQHQmFifncRscPNGQJ4gtsnqs9a+Tt00ZXJ/VP7xk6Bo+Psv5LJFR7wXhetJc0vrGNzJ1gf1@vger.kernel.org, AJvYcCXe394hxsKtixacvjeWalGug2mFRshvhuVi/8P8c05Hy493qYQka0NPstGUZsW9W00cGPRxdhE4a2pznqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YysrhrfYW1VT3ToaeXoMHQHKb0tbWefhdzHriYtsKKc6rFPM3zC
	/5/LfJ7AsqSP/XXUTigYRsT/BEsn/Myzrh47952iR7t4huc4OYZegCnlvnu+7U3ivrslIYnSfGM
	UhrmN3bjg91abWHoraiepBvyKTNE=
X-Gm-Gg: ASbGncvJqxgUcXAGE9JHHtOZDG+3qJXacEZW9sCY4PouXx5IZ14WZCJbfwdfXBUXOpY
	iaDojawhmsaWp0a9ovZgBxLQbMWbPUm6IH121SRnZIy/gc6NXLbyZxaWg+P4anMKW
X-Google-Smtp-Source: AGHT+IGGWJxqRyKBXVYbw5HA0nIXlk5U7/5i94crLnJMbgsB3lvD8caynw07JTKB6Qy9MHh+Q2GDXXq8klaQqQnE1gM=
X-Received: by 2002:a5d:64aa:0:b0:382:3efc:c6d8 with SMTP id
 ffacd0b85a97d-385c6eb5872mr2932834f8f.12.1732724856834; Wed, 27 Nov 2024
 08:27:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120103456.396577-1-linyunsheng@huawei.com>
 <20241120103456.396577-3-linyunsheng@huawei.com> <3366bf89-4544-4b82-83ec-fd89dd009228@kernel.org>
 <27475b57-eda1-4d67-93f2-5ca443632f6b@huawei.com> <CAHS8izM+sK=48gfa3gRNffu=T6t6-2vaS60QvH79zFA3gSDv9g@mail.gmail.com>
 <CAKgT0Uc-SDHsGkgmLeAuo5GLE0H43i3h7mmzG88BQojfCoQGGA@mail.gmail.com>
 <8f45cc4f-f5fc-4066-9ee1-ba59bf684b07@huawei.com> <41dfc444-1bab-4f9d-af11-4bbd93a9fe4b@arm.com>
In-Reply-To: <41dfc444-1bab-4f9d-af11-4bbd93a9fe4b@arm.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 27 Nov 2024 08:27:00 -0800
Message-ID: <CAKgT0UfGmR9B7WBjANvZ9=dxbsWXDRgpaNAMJWGW4Uj4ueiHJg@mail.gmail.com>
Subject: Re: [PATCH RFC v4 2/3] page_pool: fix IOMMU crash when driver has
 already unbound
To: Robin Murphy <robin.murphy@arm.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, Mina Almasry <almasrymina@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	liuyonglong@huawei.com, fanghaiqing@huawei.com, zhangkun09@huawei.com, 
	IOMMU <iommu@lists.linux.dev>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 7:31=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 27/11/2024 9:35 am, Yunsheng Lin wrote:
> > On 2024/11/27 7:53, Alexander Duyck wrote:
> >> On Tue, Nov 26, 2024 at 1:51=E2=80=AFPM Mina Almasry <almasrymina@goog=
le.com> wrote:
> >>>
> >>> On Thu, Nov 21, 2024 at 12:03=E2=80=AFAM Yunsheng Lin <linyunsheng@hu=
awei.com> wrote:
> >>>>
> >>>> On 2024/11/20 23:10, Jesper Dangaard Brouer wrote:
> >>>>>
> >>>>>>        page_pool_detached(pool);
> >>>>>>        pool->defer_start =3D jiffies;
> >>>>>>        pool->defer_warn  =3D jiffies + DEFER_WARN_INTERVAL;
> >>>>>> @@ -1159,7 +1228,7 @@ void page_pool_update_nid(struct page_pool *=
pool, int new_nid)
> >>>>>>        /* Flush pool alloc cache, as refill will check NUMA node *=
/
> >>>>>>        while (pool->alloc.count) {
> >>>>>>            netmem =3D pool->alloc.cache[--pool->alloc.count];
> >>>>>> -        page_pool_return_page(pool, netmem);
> >>>>>> +        __page_pool_return_page(pool, netmem);
> >>>>>>        }
> >>>>>>    }
> >>>>>>    EXPORT_SYMBOL(page_pool_update_nid);
> >>>>>
> >>>>> Thanks for continuing to work on this :-)
> >>>>
> >>>> I am not sure how scalable the scanning is going to be if the memory=
 size became
> >>>> bigger, which is one of the reason I was posting it as RFC for this =
version.
> >>>>
> >>>> For some quick searching here, it seems there might be server with m=
ax ram capacity
> >>>> of 12.3TB, which means the scanning might take up to about 10 secs f=
or those systems.
> >>>> The spin_lock is used to avoid concurrency as the page_pool_put_page=
() API might be
> >>>> called from the softirq context, which might mean there might be spi=
nning of 12 secs
> >>>> in the softirq context.
> >>>>
> >>>> And it seems hard to call cond_resched() when the scanning and unmap=
ping takes a lot
> >>>> of time as page_pool_put_page() might be called concurrently when po=
ol->destroy_lock
> >>>> is released, which might means page_pool_get_dma_addr() need to be c=
hecked to decide
> >>>> if the mapping is already done or not for each page.
> >>>>
> >>>> Also, I am not sure it is appropriate to stall the driver unbound up=
 to 10 secs here
> >>>> for those large memory systems.
> >>>>
> >>>> https://www.broadberry.com/12tb-ram-supermicro-servers?srsltid=3DAfm=
BOorCPCZQBSv91mOGH3WTg9Cq0MhksnVYL_eXxOHtHJyuYzjyvwgH
> >>>>
> >>>
> >>> FWIW I'm also concerned about the looping of all memory on the system=
.
> >>> In addition to the performance, I think (but not sure), that
> >>> CONFIG_MEMORY_HOTPLUG may mess such a loop as memory may appear or
> >>> disappear concurrently. Even if not, the CPU cost of this may be
> >>> significant. I'm imagining the possibility of having many page_pools
> >>> allocated on the system for many hardware queues, (and maybe multiple
> >>> pp's per queue for applications like devmem TCP), and each pp looping
> >>> over the entire xTB memory on page_pool_destroy()...
> >>>
> >>> My 2 cents here is that a more reasonable approach is to have the pp
> >>> track all pages it has dma-mapped, without the problems in the
> >>> previous iterations of this patch:
> >>>
> >>> 1. When we dma-map a page, we add it to some pp->dma_mapped data
> >>> structure (maybe xarray or rculist).
> >>> 2. When we dma-unmap a page, we remove it from pp->dma_mapped.
> >>> 3 When we destroy the pp, we traverse pp->dma_mapped and unmap all th=
e
> >>> pages there.
> >>
> >> The thing is this should be a very rare event as it should apply only
> >> when a device is removed and still has pages outstanding shouldn't it?
> >> The problem is that maintaining a list of in-flight DMA pages will be
> >> very costly and will make the use of page pool expensive enough that I
> >> would worry it might be considered less than useful. Once we add too
> >> much overhead the caching of the DMA address doesn't gain us much on
> >> most systems in that case.
> >>
> >>> I haven't looked deeply, but with the right data structure we may be
> >>> able to synchronize 1, 2, and 3 without any additional locks. From a
> >>> quick skim it seems maybe rculist and xarray can do this without
> >>> additional locks, maybe.
> >
> > I am not sure how the above right data structure without any additional
> > locks will work, but my feeling is that the issues mentioned in [1] wil=
l
> > likely apply to the above right data structure too.
> >
> > 1. https://lore.kernel.org/all/6233e2c3-3fea-4ed0-bdcc-9a625270da37@hua=
wei.com/
> >
> >>>
> >>> Like stated in the previous iterations of this approach, we should no=
t
> >>> be putting any hard limit on the amount of memory the pp can allocate=
,
> >>> and we should not have to mess with the page->pp entry in struct page=
.
> >
> > It would be good to be more specific about how it is done without 'mess=
ing'
> > with the page->pp entry in struct page using some pseudocode or RFC if =
you
> > call the renaming as messing.
> >
> >>
> >> I agree with you on the fact that we shouldn't be setting any sort of
> >> limit. The current approach to doing the unmapping is more-or-less the
> >> brute force way of doing it working around the DMA api. I wonder if we
> >> couldn't look at working with it instead and see if there wouldn't be
> >> some way for us to reduce the overhead instead of having to do the
> >> full scan of the page table.
> >>
> >> One thought in that regard though would be to see if there were a way
> >> to have the DMA API itself provide some of that info. I know the DMA
> >> API should be storing some of that data for the mapping as we have to
> >> go through and invalidate it if it is stored.
> >>
> >> Another alternative would be to see if we have the option to just
> >> invalidate the DMA side of things entirely for the device. Essentially
> >> unregister the device from the IOMMU instead of the mappings. If that
> >> is an option then we could look at leaving the page pool in a state
> >> where it would essentially claim it no longer has to do the DMA unmap
> >> operations and is just freeing the remaining lingering pages.
> >
> > If we are going to 'invalidate the DMA side of things entirely for the
> > device', synchronization from page_pool might just go to the DMA core a=
s
> > concurrent calling for dma unmapping API and 'invalidating' operation s=
till
> > exist. If the invalidating is a common feature, perhaps it makes sense =
to
> > do that in the DMA core, otherwise it might just add unnecessary overhe=
ad
> > for other callers of DMA API.
> >
> > As mentioned by Robin in [2], the DMA core seems to make a great deal o=
f
> > effort to catch DMA API misuse in kernel/dma/debug.c, it seems doing th=
e
> > above might invalidate some of the dma debug checking.
>
> Has nobody paused to consider *why* dma-debug is an optional feature
> with an explicit performance warning? If you're concerned about the
> impact of keeping track of DMA mappings within the confines of the
> page_pool usage model, do you really imagine it could somehow be cheaper
> to keep track of them at the generic DMA API level without the benefit
> of any assumptions at all?

I get what you are saying, but there are things about the internal
implementations of the individual DMA APIs that might make them much
easier to destroy mappings and essentially invalidate them. For
example if the system doesn't have an IOMMU there isn't much that
actually has to be retained. At most it might be a bitmap for the
SWIOTLB that would have to be retained per device and that could be
used to invalidate the mappings assuming the device has been wiped out
and is somehow actually using the SWIOTLB.

In the case of an IOMMU there are many who run with iommu=3Dpt which
will identity map the entire system memory and then just hand out
individual physical addresses from that range. In reality that should
be almost as easy to handle as the non-iommu case so why shouldn't we
take advantage of that to clean up this use case?

> Yes, in principle we could add a set of "robust" DMA APIs which make
> sure racy sync calls are safe and offer a "clean up all my outstanding
> mappings" op, and they would offer approximately as terrible performance
> as the current streaming APIs with dma-debug enabled, because it would
> be little different from what dma-debug already does. The checks
> themselves aren't complicated; the generally-prohibitive cost lies in
> keeping track of mappings and allocations so that they *can* be checked
> internally.
>
> Whatever you think is hard to do in the page_pool code to fix that
> code's own behaviour, it's even harder to do from elsewhere with less
> information.

My general thought would be to see if there is anything we could
explore within the DMA API itself to optimize the handling for this
sort of bulk unmap request. If not we could fall back to an approach
that requires more overhead and invalidation of individual pages.

You could think of it like the approach that has been taken with
DEFINED_DMA_UNMAP_ADDR/LEN. Basically there are cases where this can
be done much more quickly and it is likely we can clean up large
swaths in one go. So why not expose a function that might be able to
take advantage of that for exception cases like this surprise device
removal.

