Return-Path: <netdev+bounces-122413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6B59612FE
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 17:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 892C9B2AF37
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4B21CC150;
	Tue, 27 Aug 2024 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2KV/Nnk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1001BDA93;
	Tue, 27 Aug 2024 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772696; cv=none; b=j39vv6uaSKMhSJaTndu19R5Ji1pE8/naRHvJLvXvIHo805c0TVUt+kPgOxC7yGz/35pxjJT8gUCOFETNzK1ma5RHR5U1+D4/0ZE+C71zTGryBxQteoxSDl6m1VbtkVbSdRKlXKApeMUbp5xNJp98Pa8Ibe56+gSGIMvIExjqskg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772696; c=relaxed/simple;
	bh=y4iMMsmESopo0zN+fum1KDm4qCF4V+lyxG7NtWHeEQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJssIUv2ucrG1lptCj+dCBkW24aBt4uBkVLuEzNS1I6kYx0jP8od+5YSmnIX6AlCT3fnr84fSSZv59jNhepSXt+1VLaRrp09kAiXGa0sDiOGYJQ9XcBBpMwBj3ReNoaCrEvkKNSMa+UU0n548X2dnpFkCBh+UZu0oKcTPRgFHZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2KV/Nnk; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-81f9339e534so187751939f.3;
        Tue, 27 Aug 2024 08:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724772694; x=1725377494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqcUNaxQm25GRpp+jV0VmnGAyj/IWoEm4mVeyn3fA50=;
        b=Y2KV/NnkH3js6KGhhtGwRYHh8DThX1ppUm+p2wyA2m/pvySmPrh8lvJgiUmLt7rjqh
         V85fXKlpBiny3SnQZSXy4HNjplE70CfBGqPN9iUz4wsTg+D3lFWRqW1kYsHEWk9jI5mk
         XQa2+amMe7UJJ2ZQcIs1NU4eeWtMfEB9NqdHeocA0E+NjjFPWBTKYPvPAAtIHVQNF8Ox
         9dg6A6ETQYUdnPfXV9e7EBNkLg3V6f0n2zxs+1kjWVw6nJRZeNJ0Gp6lhOg9X0H9EsQB
         c+2FQu8uIM9GwQ7Bm48eWDYNKR/FHx5dNnkAEePK2VF1Lzo85PzXn1VGsSBINrxXh2ho
         R8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724772694; x=1725377494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqcUNaxQm25GRpp+jV0VmnGAyj/IWoEm4mVeyn3fA50=;
        b=WqA3Fzw8Q2y3gs02+JY/dVgzycMw9Ly78g9QAIG3cCT+ePEJpee8xjtS15IHI0n+jo
         54GqTlDKLawn3M7ppqcuhG3RXzusrrbgcMJ3a/QQChzrM1gd5ONwNWDUTU/HNvuh/rou
         JA98/DTOVdcsFKGt0dHXm3j2plJbrXgn2LxZtCz8eYFlawM+6Q7IHUqDGRon0OhYQA4K
         ijfYWoH6iXvLQtIL2RpvFYrE2+VH2vPVykV3wyhAQE7fWtH2lkEV+qMn/6sCADbsIhHX
         ZHnkQvqKLQxEBL1Dj+ftxvAWaJmitjyGBeWM8gvVMSu4w5pDsUNXj1Uutt5h3ntq6dr9
         i3mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAeq2lb8WJC9nkd5XcyUTL7ujRxIH8MP7o2kD1GD2VzmYcoS5snRSZh5bn/udF/W+GrIyGfbuh@vger.kernel.org, AJvYcCWpBpvunEpGn3cDUht016yKJ7V4dSyooida8D5YZ0ajnn8JOO2D+VUCujbkC2ggAz3iwPEDIQGKuiOBQB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMUJMU58mznzodF+TApmFvm3YzIbzfsOrqrcTfHXe91T25eFgA
	Kwv9Q8AwWoDk8EqJbqRRfYmQTB9H4KQ6FUShqxGs1DGiMUPEDfGCextGX4Fp3a+PEJ7k/ObAdtK
	eM+jcIeDO0BG4ZP+/iWpxaKgG57g=
X-Google-Smtp-Source: AGHT+IGYv3dP4E+8xvHvi2ISRorEeU+/82nOF/XKfiOihGEHwbyFnfJnqy2jdgRv1T29v0FuP0fzreKhk4djPZ4vfnY=
X-Received: by 2002:a92:c54f:0:b0:397:70e7:143b with SMTP id
 e9e14a558f8ab-39e3c98f968mr156852035ab.14.1724772693457; Tue, 27 Aug 2024
 08:31:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826124021.2635705-1-linyunsheng@huawei.com>
 <20240826124021.2635705-9-linyunsheng@huawei.com> <CAKgT0Ue+6Gke9YguEDiq6whqQg0DdjPjSDDiRHEeVe5MX80+-Q@mail.gmail.com>
 <67c7c28d-bbfa-457d-a5bb-cb06806e5433@huawei.com>
In-Reply-To: <67c7c28d-bbfa-457d-a5bb-cb06806e5433@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 27 Aug 2024 08:30:55 -0700
Message-ID: <CAKgT0UdiDfL++rC_g8guhChRFsNhKeax8697O5+zfi01Y=iEeg@mail.gmail.com>
Subject: Re: [PATCH net-next v15 08/13] mm: page_frag: use __alloc_pages() to
 replace alloc_pages_node()
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 5:07=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/8/27 1:00, Alexander Duyck wrote:
> > On Mon, Aug 26, 2024 at 5:46=E2=80=AFAM Yunsheng Lin <linyunsheng@huawe=
i.com> wrote:
> >>
> >> It seems there is about 24Bytes binary size increase for
> >> __page_frag_cache_refill() after refactoring in arm64 system
> >> with 64K PAGE_SIZE. By doing the gdb disassembling, It seems
> >> we can have more than 100Bytes decrease for the binary size
> >> by using __alloc_pages() to replace alloc_pages_node(), as
> >> there seems to be some unnecessary checking for nid being
> >> NUMA_NO_NODE, especially when page_frag is part of the mm
> >> system.
> >>
> >> CC: Alexander Duyck <alexander.duyck@gmail.com>
> >> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> >> ---
> >>  mm/page_frag_cache.c | 6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> >> index bba59c87d478..e0ad3de11249 100644
> >> --- a/mm/page_frag_cache.c
> >> +++ b/mm/page_frag_cache.c
> >> @@ -28,11 +28,11 @@ static struct page *__page_frag_cache_refill(struc=
t page_frag_cache *nc,
> >>  #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> >>         gfp_mask =3D (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP =
|
> >>                    __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
> >> -       page =3D alloc_pages_node(NUMA_NO_NODE, gfp_mask,
> >> -                               PAGE_FRAG_CACHE_MAX_ORDER);
> >> +       page =3D __alloc_pages(gfp_mask, PAGE_FRAG_CACHE_MAX_ORDER,
> >> +                            numa_mem_id(), NULL);
> >>  #endif
> >>         if (unlikely(!page)) {
> >> -               page =3D alloc_pages_node(NUMA_NO_NODE, gfp, 0);
> >> +               page =3D __alloc_pages(gfp, 0, numa_mem_id(), NULL);
> >>                 if (unlikely(!page)) {
> >>                         nc->encoded_page =3D 0;
> >>                         return NULL;
> >
> > I still think this would be better served by fixing alloc_pages_node
> > to drop the superfluous checks rather than changing the function. We
> > would get more gain by just addressing the builtin constant and
> > NUMA_NO_NODE case there.
>
> I am supposing by 'just addressing the builtin constant and NUMA_NO_NODE
> case', it meant the below change from the previous discussion:
>
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 01a49be7c98d..009ffb50d8cd 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -290,6 +290,9 @@ struct folio *__folio_alloc_node_noprof(gfp_t gfp, un=
signed int order, int nid)
>  static inline struct page *alloc_pages_node_noprof(int nid, gfp_t gfp_ma=
sk,
>                                                    unsigned int order)
>  {
> +       if (__builtin_constant_p(nid) && nid =3D=3D NUMA_NO_NODE)
> +               return __alloc_pages_noprof(gfp_mask, order, numa_mem_id(=
), NULL);
> +
>         if (nid =3D=3D NUMA_NO_NODE)
>                 nid =3D numa_mem_id();
>
>
> Actually it does not seem to get more gain by judging from binary size
> changing as below, vmlinux.org is the image after this patchset, and
> vmlinux is the image after this patchset with this patch reverted and
> with above change applied.
>
> [linyunsheng@localhost net-next]$ ./scripts/bloat-o-meter vmlinux.org vml=
inux
> add/remove: 0/2 grow/shrink: 16/12 up/down: 432/-340 (92)
> Function                                     old     new   delta
> new_slab                                     808    1124    +316
> its_probe_one                               2860    2908     +48

...

> alloc_slab_page                              284       -    -284
> Total: Before=3D30534822, After=3D30534914, chg +0.00%

Well considering that alloc_slab_page was marked to be "inline" as per
the qualifier applied to it I would say the shrinking had an effect,
but it was just enough to enable the "inline" qualifier to kick in. It
could be argued that the change exposed another issue in that the
alloc_slab_page function is probably large enough that it should just
be "static" and not "static inline". If you can provide you config I
could probably look into this further but I suspect just dropping the
inline for that one function should result in net savings.

The only other big change I see is in its_probe_one which I am not
sure why it would be impacted since it is not passing a constant in
the first place, it is passing its->numa_node. I'd be curious what the
disassembly shows in terms of the change that caused it to increase in
size.

Otherwise the rest of the size changes seem more like code shifts than
anything else likely due to the functions shifting around slightly due
to a few dropping in size.

