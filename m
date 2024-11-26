Return-Path: <netdev+bounces-147529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D82E9D9FD9
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 00:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E236728320E
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 23:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E151DFE09;
	Tue, 26 Nov 2024 23:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3rviiPK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E19D299;
	Tue, 26 Nov 2024 23:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732665273; cv=none; b=fKWfFxRPsOrHTqUzgEkP7dHyOsC9FyhQlKD9boXJY2loNxu92/+7Tvi4FIlytSVWJlOCIvqvuuBxuBxYcCdUZN1smpwukF9jNE8T6VMwSV1EDrTWU/Sh/pYwF1qmXHgFnR1oGgVuGGBdOmVy2ynCArNJ315O8KX2gQkxgm+N6B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732665273; c=relaxed/simple;
	bh=x63pMP4OLfWRH+KuRzokRHFrfyWUaoWvW8veNR5AVMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tNnzX+Iysp1AAW/tocqBIfWzlFBaTwZBUyrPmSGdchVNq7TBXfntbMhRYjg1By1IKkRv+SQ4RQOIp7v/PjM7lEyKi+Ig/1NqEHh0NLMJIM9Cgi41fYL6XbC0aY8oFitxQnNrkNqm2OfXbGqGVgpg9WsOJF8XIo7AfZ2EsLMndKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3rviiPK; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3823f1ed492so134414f8f.1;
        Tue, 26 Nov 2024 15:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732665270; x=1733270070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2u5ocyAxhRtJ7w+0LT+WI0tq8J0AZWlWuu8DjpM/jI=;
        b=Q3rviiPK4r2pec4yNpvG/pR7HXBabNgNtjhJjoNG2wTlRZwt61kpUQsPDBAYtszXNK
         yyfiZBE0eWszwJYN/bBzOg+AHeB7mpPEZZ6M4Gm9RMq4IBeZAZJdA0GB3eZC0tyKuVcL
         6lNpEoUK4NGqUe2VzJR4M81WPKJBIB3uyXLsSusBcZSoN6OX2YQCBGtyQ+ew2m+suCH5
         14gGOOzqAQHYiMFtimCxfqps0L4CfnM5PjzKt9M3AVwC2VP1Fmy4hJDilFLP1DWTQKGz
         eWEMXmoehvKGVCse1Fb8fdikNSIWgm5xFuLT61qQFa1briNj1jiC8bQkUJgM1L0ksIKR
         kvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732665270; x=1733270070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2u5ocyAxhRtJ7w+0LT+WI0tq8J0AZWlWuu8DjpM/jI=;
        b=raGLI9uE+JAFqRpQ2gqjkD7F1oJkQQu3I4tFcQNg1ASzMmwzX8YPaWH5DUqESZ/D31
         XQyiws6FFBX2YK+rn2ntldA+aw0xxU5s+8yuHknGyI64krJGOa9GPhK9+InuJ2mwtIFN
         NvDIDW8Eb4syak3dil0T+WYGVxIP0HQSTznIBDKQD1wSzudOvS5fO1H1kxVjj6vqIOu3
         rYkuRGBoKMIBOcaU9Nr3mi99t4kielifSC4PG9+hTBevns/9dI9pwD0sNl8UQ5UySP8k
         Feg5o0IHycvelYsEgsBKXWCAY5wNzxpKq/0HNv3k1NYLdzDlXezFXf5Fs1sPyUCyh4s5
         W9MA==
X-Forwarded-Encrypted: i=1; AJvYcCW5EGm5bRWceBsu5EbXcJblNF6Hobw7+5KsqVb+1ThUYlptccd+teNz5f9HNInv8dTyqjq+zG8Y@vger.kernel.org, AJvYcCWwYfsiIHX91lqH8M+WHglrieLhwzlD+nDCiKX9SUfx1pALrTY967HV1X05dHAL2YhyhUbUUI4TeWAHPmE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1NbinP6sQlKMtsNVoFhiKUj226qFcDJIB2OnYvNJ62MBRRapi
	HDhXsVq9ARlgaHlXjivGLXefE0smR1KzlVPDwVgZSaJMnLBnIBg+5sAdinkq+B/hhM3y9eCszZA
	UkUAhaFPtpuEDLXFJYOiy4jdlgSk=
X-Gm-Gg: ASbGncuf/K4DJ08dSivdPBEGC+DnIxxE6mjix2j94nVgiM3liwk0vwohc37YsgQoUU1
	cbvGgGZocIVF1bfDSw+W2b2bFJR8WZUiulBDrBx0OjNB569sIAtfsYj07ApFqpS5c
X-Google-Smtp-Source: AGHT+IFtH1P3ItFz7u/rM/m1aucdE4ilOQvI4yoohlQC7SXR7UEilmGjmt5k6+4jadT8AZZ+mnnALhcPNWhrUveUGRI=
X-Received: by 2002:a5d:5986:0:b0:382:2e9e:d695 with SMTP id
 ffacd0b85a97d-385c6841615mr711578f8f.24.1732665269562; Tue, 26 Nov 2024
 15:54:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120103456.396577-1-linyunsheng@huawei.com>
 <20241120103456.396577-3-linyunsheng@huawei.com> <3366bf89-4544-4b82-83ec-fd89dd009228@kernel.org>
 <27475b57-eda1-4d67-93f2-5ca443632f6b@huawei.com> <CAHS8izM+sK=48gfa3gRNffu=T6t6-2vaS60QvH79zFA3gSDv9g@mail.gmail.com>
In-Reply-To: <CAHS8izM+sK=48gfa3gRNffu=T6t6-2vaS60QvH79zFA3gSDv9g@mail.gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 26 Nov 2024 15:53:53 -0800
Message-ID: <CAKgT0Uc-SDHsGkgmLeAuo5GLE0H43i3h7mmzG88BQojfCoQGGA@mail.gmail.com>
Subject: Re: [PATCH RFC v4 2/3] page_pool: fix IOMMU crash when driver has
 already unbound
To: Mina Almasry <almasrymina@google.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, Jesper Dangaard Brouer <hawk@kernel.org>, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, liuyonglong@huawei.com, 
	fanghaiqing@huawei.com, zhangkun09@huawei.com, 
	Robin Murphy <robin.murphy@arm.com>, IOMMU <iommu@lists.linux.dev>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 1:51=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Thu, Nov 21, 2024 at 12:03=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei=
.com> wrote:
> >
> > On 2024/11/20 23:10, Jesper Dangaard Brouer wrote:
> > >
> > >>       page_pool_detached(pool);
> > >>       pool->defer_start =3D jiffies;
> > >>       pool->defer_warn  =3D jiffies + DEFER_WARN_INTERVAL;
> > >> @@ -1159,7 +1228,7 @@ void page_pool_update_nid(struct page_pool *po=
ol, int new_nid)
> > >>       /* Flush pool alloc cache, as refill will check NUMA node */
> > >>       while (pool->alloc.count) {
> > >>           netmem =3D pool->alloc.cache[--pool->alloc.count];
> > >> -        page_pool_return_page(pool, netmem);
> > >> +        __page_pool_return_page(pool, netmem);
> > >>       }
> > >>   }
> > >>   EXPORT_SYMBOL(page_pool_update_nid);
> > >
> > > Thanks for continuing to work on this :-)
> >
> > I am not sure how scalable the scanning is going to be if the memory si=
ze became
> > bigger, which is one of the reason I was posting it as RFC for this ver=
sion.
> >
> > For some quick searching here, it seems there might be server with max =
ram capacity
> > of 12.3TB, which means the scanning might take up to about 10 secs for =
those systems.
> > The spin_lock is used to avoid concurrency as the page_pool_put_page() =
API might be
> > called from the softirq context, which might mean there might be spinni=
ng of 12 secs
> > in the softirq context.
> >
> > And it seems hard to call cond_resched() when the scanning and unmappin=
g takes a lot
> > of time as page_pool_put_page() might be called concurrently when pool-=
>destroy_lock
> > is released, which might means page_pool_get_dma_addr() need to be chec=
ked to decide
> > if the mapping is already done or not for each page.
> >
> > Also, I am not sure it is appropriate to stall the driver unbound up to=
 10 secs here
> > for those large memory systems.
> >
> > https://www.broadberry.com/12tb-ram-supermicro-servers?srsltid=3DAfmBOo=
rCPCZQBSv91mOGH3WTg9Cq0MhksnVYL_eXxOHtHJyuYzjyvwgH
> >
>
> FWIW I'm also concerned about the looping of all memory on the system.
> In addition to the performance, I think (but not sure), that
> CONFIG_MEMORY_HOTPLUG may mess such a loop as memory may appear or
> disappear concurrently. Even if not, the CPU cost of this may be
> significant. I'm imagining the possibility of having many page_pools
> allocated on the system for many hardware queues, (and maybe multiple
> pp's per queue for applications like devmem TCP), and each pp looping
> over the entire xTB memory on page_pool_destroy()...
>
> My 2 cents here is that a more reasonable approach is to have the pp
> track all pages it has dma-mapped, without the problems in the
> previous iterations of this patch:
>
> 1. When we dma-map a page, we add it to some pp->dma_mapped data
> structure (maybe xarray or rculist).
> 2. When we dma-unmap a page, we remove it from pp->dma_mapped.
> 3 When we destroy the pp, we traverse pp->dma_mapped and unmap all the
> pages there.

The thing is this should be a very rare event as it should apply only
when a device is removed and still has pages outstanding shouldn't it?
The problem is that maintaining a list of in-flight DMA pages will be
very costly and will make the use of page pool expensive enough that I
would worry it might be considered less than useful. Once we add too
much overhead the caching of the DMA address doesn't gain us much on
most systems in that case.

> I haven't looked deeply, but with the right data structure we may be
> able to synchronize 1, 2, and 3 without any additional locks. From a
> quick skim it seems maybe rculist and xarray can do this without
> additional locks, maybe.
>
> Like stated in the previous iterations of this approach, we should not
> be putting any hard limit on the amount of memory the pp can allocate,
> and we should not have to mess with the page->pp entry in struct page.

I agree with you on the fact that we shouldn't be setting any sort of
limit. The current approach to doing the unmapping is more-or-less the
brute force way of doing it working around the DMA api. I wonder if we
couldn't look at working with it instead and see if there wouldn't be
some way for us to reduce the overhead instead of having to do the
full scan of the page table.

One thought in that regard though would be to see if there were a way
to have the DMA API itself provide some of that info. I know the DMA
API should be storing some of that data for the mapping as we have to
go through and invalidate it if it is stored.

Another alternative would be to see if we have the option to just
invalidate the DMA side of things entirely for the device. Essentially
unregister the device from the IOMMU instead of the mappings. If that
is an option then we could look at leaving the page pool in a state
where it would essentially claim it no longer has to do the DMA unmap
operations and is just freeing the remaining lingering pages.

