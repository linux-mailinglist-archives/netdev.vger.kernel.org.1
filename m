Return-Path: <netdev+bounces-147643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2F69DADF6
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 20:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 737C91634CC
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 19:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B6B20125A;
	Wed, 27 Nov 2024 19:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0YOqD0Tg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6D3140E38
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 19:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732736407; cv=none; b=XIeD3bTcQBQIIvNGYqNXuugy5L1s8pt8Mjev2vLgt2bXjsqibSj7jTlmp+uTS4QCkJk4MYEF5EiDDjBlGS9wVXTkwGm63m5Aq8ePw7YuCr0EpT/N8jnaK7EfhxFp53LrpOtt0pGCPl0L5EakSGndX2+6SK08Try8DFW7ZuO/sco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732736407; c=relaxed/simple;
	bh=x9dS7oAYleHRajlJ27xlcRqC5Yg8HnsAAlu88HSzn04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/N61hWf1QjYQWiQUkO5sQBBydmYGKpm+HFGUWIz9DTPW7RzlrknvWJZlzbRKHqGtB+guB7UKKx+d8ES6UMUlIsaAW6SFJogOjieok/6lfA/6Ji2spY4PqjzrJTo97mwUmYp7et3teA+sStcXVzPAbAFRvT3OPfifs/1RPRqqbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0YOqD0Tg; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4668194603cso10311cf.1
        for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 11:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732736405; x=1733341205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJl9SLmf8+tDJzXXlxRiqoHwxpxlnvk1n/BWGDuOZZo=;
        b=0YOqD0TgQGN7+R44KaCStW6dxHvnYvSWWcWBDhM+2mbdwOBy7BH5YrfhE74qCOHwgh
         8uovI7ZhKgGBeu+4oEDe4DIQb/WDxzxD11F9RzE7YTylWhlwalTn4VeE9GA1Gn45s0k5
         XjYOTVMjIqUun6Atv+hHFhza37Wl9lZj/ziD4JHk1c7N+grMeSRoCRgP4c0wgPpfDe0i
         4/ACh0IxY3oQ2GRTaMeDIDvp04Aj8fq/RtgY8fu16XREE0CwfG+XvbVbdRDOd5tfKmuo
         K1zo04H8IjwVpIhFBWuyd6/2Pc9ZTE9ViIGVL0X/T18FbXD64cKp2EmS1v7e0jU9YTx3
         WhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732736405; x=1733341205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJl9SLmf8+tDJzXXlxRiqoHwxpxlnvk1n/BWGDuOZZo=;
        b=b4Y/KUq7YiPZwnxTAmMAWSxcEJ4/6Q7qZIUgZKl59bXhPlXc4R8zWc9p9VEFVAoER7
         GVXo4M2eKTc9aK9yFHrN90Fu7b+ksATSijGxfa8lZgYKDzpHcqwy6TlTFv0f9ocffGXo
         Lf23zIfxbuRu4ppq00QU0GHwyoYD2LaKEn+deSp50QbaRtWj69lfNwcCUl1rNddEwR4H
         YnHXDMBJ/G2JDxp2ORMKjkaikO2iclfpZdoQd7uek808enpOAYxsZH19RC1Pp6u8Tsxu
         JNQtwJoAhzMhTyA9Zb0cTrdpLdb7bZvlSRjJbZIm9UpcJjdXN5Fdlnl5cvTsdL3Ga2nj
         lCNA==
X-Forwarded-Encrypted: i=1; AJvYcCUrOfuBrb2qylbhMgctnEUiiVAZWKZUa3q0konwaHE7UE9S7lXp5Thm8XSRFI/juG6TbPCXusk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza+bDEgvWPQ9nBEmFKaoVv3W1jk89+fM1yFtmSr3JKdtLfjhK4
	nAZOM6KDLlPbXUUf4/RqF18+yPrFy9g93/pxartU/x2cqilUtDTHd0GUUmxWWMiQJClQqtGCuEo
	eippvzvufJjqSD5FUAQbb2mO9NhVLISrY9rUy
X-Gm-Gg: ASbGncvOmcGjswk4MnjDycl5xe9kC8l9NjDonNSl3+yuOQqF7H0rgUaOQayCKaK8xFE
	Gi81s0+0ZtU1UeY9BK7nO1Q0egerIFQM=
X-Google-Smtp-Source: AGHT+IFpU3rekOtcEw5rS4VDu/+FdfyXUn4njkcrc7z2/l5oaizj3tMziVrc1xraWFLbxEOWRGr6r/J9olDf9amauwU=
X-Received: by 2002:a05:622a:5e83:b0:461:48f9:4852 with SMTP id
 d75a77b69052e-466c2a6b1a2mr134761cf.28.1732736404883; Wed, 27 Nov 2024
 11:40:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120103456.396577-1-linyunsheng@huawei.com>
 <20241120103456.396577-3-linyunsheng@huawei.com> <3366bf89-4544-4b82-83ec-fd89dd009228@kernel.org>
 <27475b57-eda1-4d67-93f2-5ca443632f6b@huawei.com> <CAHS8izM+sK=48gfa3gRNffu=T6t6-2vaS60QvH79zFA3gSDv9g@mail.gmail.com>
 <CAKgT0Uc-SDHsGkgmLeAuo5GLE0H43i3h7mmzG88BQojfCoQGGA@mail.gmail.com> <8f45cc4f-f5fc-4066-9ee1-ba59bf684b07@huawei.com>
In-Reply-To: <8f45cc4f-f5fc-4066-9ee1-ba59bf684b07@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 27 Nov 2024 11:39:53 -0800
Message-ID: <CAHS8izPg7B5DwKfSuzz-iOop_YRbk3Sd6Y4rX7KBG9DcVJcyWg@mail.gmail.com>
Subject: Re: [PATCH RFC v4 2/3] page_pool: fix IOMMU crash when driver has
 already unbound
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, liuyonglong@huawei.com, 
	fanghaiqing@huawei.com, zhangkun09@huawei.com, 
	Robin Murphy <robin.murphy@arm.com>, IOMMU <iommu@lists.linux.dev>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 1:35=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/11/27 7:53, Alexander Duyck wrote:
> > On Tue, Nov 26, 2024 at 1:51=E2=80=AFPM Mina Almasry <almasrymina@googl=
e.com> wrote:
> >>
> >> On Thu, Nov 21, 2024 at 12:03=E2=80=AFAM Yunsheng Lin <linyunsheng@hua=
wei.com> wrote:
> >>>
> >>> On 2024/11/20 23:10, Jesper Dangaard Brouer wrote:
> >>>>
> >>>>>       page_pool_detached(pool);
> >>>>>       pool->defer_start =3D jiffies;
> >>>>>       pool->defer_warn  =3D jiffies + DEFER_WARN_INTERVAL;
> >>>>> @@ -1159,7 +1228,7 @@ void page_pool_update_nid(struct page_pool *p=
ool, int new_nid)
> >>>>>       /* Flush pool alloc cache, as refill will check NUMA node */
> >>>>>       while (pool->alloc.count) {
> >>>>>           netmem =3D pool->alloc.cache[--pool->alloc.count];
> >>>>> -        page_pool_return_page(pool, netmem);
> >>>>> +        __page_pool_return_page(pool, netmem);
> >>>>>       }
> >>>>>   }
> >>>>>   EXPORT_SYMBOL(page_pool_update_nid);
> >>>>
> >>>> Thanks for continuing to work on this :-)
> >>>
> >>> I am not sure how scalable the scanning is going to be if the memory =
size became
> >>> bigger, which is one of the reason I was posting it as RFC for this v=
ersion.
> >>>
> >>> For some quick searching here, it seems there might be server with ma=
x ram capacity
> >>> of 12.3TB, which means the scanning might take up to about 10 secs fo=
r those systems.
> >>> The spin_lock is used to avoid concurrency as the page_pool_put_page(=
) API might be
> >>> called from the softirq context, which might mean there might be spin=
ning of 12 secs
> >>> in the softirq context.
> >>>
> >>> And it seems hard to call cond_resched() when the scanning and unmapp=
ing takes a lot
> >>> of time as page_pool_put_page() might be called concurrently when poo=
l->destroy_lock
> >>> is released, which might means page_pool_get_dma_addr() need to be ch=
ecked to decide
> >>> if the mapping is already done or not for each page.
> >>>
> >>> Also, I am not sure it is appropriate to stall the driver unbound up =
to 10 secs here
> >>> for those large memory systems.
> >>>
> >>> https://www.broadberry.com/12tb-ram-supermicro-servers?srsltid=3DAfmB=
OorCPCZQBSv91mOGH3WTg9Cq0MhksnVYL_eXxOHtHJyuYzjyvwgH
> >>>
> >>
> >> FWIW I'm also concerned about the looping of all memory on the system.
> >> In addition to the performance, I think (but not sure), that
> >> CONFIG_MEMORY_HOTPLUG may mess such a loop as memory may appear or
> >> disappear concurrently. Even if not, the CPU cost of this may be
> >> significant. I'm imagining the possibility of having many page_pools
> >> allocated on the system for many hardware queues, (and maybe multiple
> >> pp's per queue for applications like devmem TCP), and each pp looping
> >> over the entire xTB memory on page_pool_destroy()...
> >>
> >> My 2 cents here is that a more reasonable approach is to have the pp
> >> track all pages it has dma-mapped, without the problems in the
> >> previous iterations of this patch:
> >>
> >> 1. When we dma-map a page, we add it to some pp->dma_mapped data
> >> structure (maybe xarray or rculist).
> >> 2. When we dma-unmap a page, we remove it from pp->dma_mapped.
> >> 3 When we destroy the pp, we traverse pp->dma_mapped and unmap all the
> >> pages there.
> >
> > The thing is this should be a very rare event as it should apply only
> > when a device is removed and still has pages outstanding shouldn't it?
> > The problem is that maintaining a list of in-flight DMA pages will be
> > very costly and will make the use of page pool expensive enough that I
> > would worry it might be considered less than useful. Once we add too
> > much overhead the caching of the DMA address doesn't gain us much on
> > most systems in that case.
> >
> >> I haven't looked deeply, but with the right data structure we may be
> >> able to synchronize 1, 2, and 3 without any additional locks. From a
> >> quick skim it seems maybe rculist and xarray can do this without
> >> additional locks, maybe.
>
> I am not sure how the above right data structure without any additional
> locks will work, but my feeling is that the issues mentioned in [1] will
> likely apply to the above right data structure too.
>
> 1. https://lore.kernel.org/all/6233e2c3-3fea-4ed0-bdcc-9a625270da37@huawe=
i.com/
>

I don't see the issues called out in the above thread conflict with
what I'm proposing. In fact, I think Jesper's suggestion works
perfectly with what I'm proposing. Maybe I'm missing something.

We can use an atomic pool->destroy_count to synchronize steps 2 and 3.
I.e. If destroy_count > 0, we don't unmap the page in
__page_pool_release_page(), and instead count on the page_pool_destroy
unmapping all the pages in the pp->dma_mapped list.

> >>
> >> Like stated in the previous iterations of this approach, we should not
> >> be putting any hard limit on the amount of memory the pp can allocate,
> >> and we should not have to mess with the page->pp entry in struct page.
>
> It would be good to be more specific about how it is done without 'messin=
g'
> with the page->pp entry in struct page using some pseudocode or RFC if yo=
u
> call the renaming as messing.
>

Yeah, I don't think touching the page->pp entry is needed if you use
an xarray or rculist which hangs off the pp.

I'm currently working on a few bug fixes already and the devmem TCP TX
which is waiting on by a few folks; I don't think I can look into this
right now, but I'll try. If this issue hasn't been resolved by the
time I get some bandwidth, sure, I'll take a stab at it.

--=20
Thanks,
Mina

