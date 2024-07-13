Return-Path: <netdev+bounces-111251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F763930685
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 19:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 864131F2408E
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 17:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6B617279C;
	Sat, 13 Jul 2024 16:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMc3e9+O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856E5171E57;
	Sat, 13 Jul 2024 16:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720889797; cv=none; b=BErzNxf7Oad7Wo4PQbv4F5cdBy1Qu0eYYhty4c9FbvovPhnXhzfOGRwU0SZmXDTlmxecGxfkaJ7Y/f+3u13f/qdFjoLWw9usDXbY1V9b3GVtBy87nPJnM4o7JD8mLybEvyhWBZ2SeqswkpSPL2PndEZ7VytyzIrTLSVvbdFdDxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720889797; c=relaxed/simple;
	bh=s4hLEGAo6TkxA2Kn3tloADVBco6FHnB6JolUqrnimpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kf2xb5Hk8aErWKsZSt2GbjNfXxlTMkuHe+VQMv8sQ2B0qazuOF6W/ToeBET/LKehzgEn8KvgLk5tQNtRw13lmCn1lJikbo8pDWS+CwViR8K9IxKymlxNfWV3hBRHfIOU806UgYv0qDxrtb+TBZUrrbbbS3ZGEQVN2jurg+ZlnsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMc3e9+O; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3679df4cb4cso1873757f8f.0;
        Sat, 13 Jul 2024 09:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720889794; x=1721494594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNt1wrkptkd8WR0JstD22LLnVmr+AtU5Ut9aSaxTWAM=;
        b=IMc3e9+Oqw5ZGgWMy1mQqFP/smM6z5am0jDTTFg/HM+l3u2BSh4TxVOiHk70QGDGgP
         +mgQrx6GedpHk+Y6V9eKiqw/ynG5ke5Ems7LcLPu01dBMi6ZY5mSSYFnf+1nCq2pQb3U
         HFopQSwgu7J4FTEzhIA5eE+FYjuuN5MjR9L8bsQoR65NA38QVUpB3GJznjYpPnG9rJAg
         7uLXxzL3SDfR0lQQ3o/xl7x+AoDEajLOuNyDZBx33k4dXXpg9v8YuKX8iZJeUTXsIKQy
         AmDCiNThm/y8yjGVVGtLXlVnO49M5kpGpU2mFr+4zh4Cetcqigoc6gVzGGOctodvmp6j
         E7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720889794; x=1721494594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNt1wrkptkd8WR0JstD22LLnVmr+AtU5Ut9aSaxTWAM=;
        b=XEMtGmaWtwkcBMJilyOkYHZj3916vD3BATvrVrYxADuvV4f8Eg9v5+uCE8sdZQhV/5
         WyGEsli3wPJ3as81/JH3lpMmZ5nkYp5iIWHgiTxjOUuLfRrYhYULm8mE69/qMiM6Wpt6
         jJSoffVMnKlPvgpmEfVuH5LDMrhJSXX719oelYy79SA/quf5A2MJT7s19oZC5cGt+TJw
         X6Qzb7/KdeaY8r4FWr5m1+SErvM3a2BQcoqNwGglNRxH54DEiiOcrME/hr4RjcmwNPTP
         Nibu9yO0hAVnZhvCG5PcDRcMTvBe6doAIeFT9/gEUP86MaNc24VqHJwyqAiISLHWFyFM
         0O3g==
X-Forwarded-Encrypted: i=1; AJvYcCUxU50CxgLeTdMTtWmc7zOyi0L/aYM8tGmboM3UI2hiioQG6m4bcVvSnbteHpd0u/o5pjZOw4AqqG0SfXhIcKrNsxnR6njjEiJ3zIB1nYYeghpE9Jc687JujrvDAYo3dhNFvmMy
X-Gm-Message-State: AOJu0Yyqo9Ih/aib8tuX0EgVOYay4qv9GxpH/M66EjtQ/j4DXB2mkAyn
	GJYl3+rW5iZG3gltcNX9YBEQdwArIxzmFCe8W51343D1Kj+2A96lb4tfzo3UyRyl0hpkJa9gQyT
	FtblSxlYq9fneD8hiZUh48dSElEU=
X-Google-Smtp-Source: AGHT+IFM1aA9fPQwig9kG5G53o8ZVZdSWMlzL8lNEGzlwh+Yw9AUubW1OizJr1MnA3tS1MsWUsOY3FLesOPBVz8bLKI=
X-Received: by 2002:a5d:5f45:0:b0:368:6bb:f79e with SMTP id
 ffacd0b85a97d-36806bbf7e9mr5375120f8f.4.1720889793488; Sat, 13 Jul 2024
 09:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625135216.47007-1-linyunsheng@huawei.com>
 <20240625135216.47007-7-linyunsheng@huawei.com> <12a8b9ddbcb2da8431f77c5ec952ccfb2a77b7ec.camel@gmail.com>
 <808be796-6333-c116-6ecb-95a39f7ad76e@huawei.com> <a026c32218cabc7b6dc579ced1306aefd7029b10.camel@gmail.com>
 <f4ff5a42-9371-bc54-8523-b11d8511c39a@huawei.com> <96b04ebb7f46d73482d5f71213bd800c8195f00d.camel@gmail.com>
 <5daed410-063b-4d86-b544-d1a85bd86375@huawei.com> <CAKgT0UdJPcnfOJ=-1ZzXbiFiA=8a0z_oVBgQC-itKB1HWBU+yA@mail.gmail.com>
 <df38c0fb-64a9-48da-95d7-d6729cc6cf34@huawei.com> <CAKgT0UdSjmJoaQvTOz3STjBi2PazQ=piWY5wqFsYFBFLcPrLjQ@mail.gmail.com>
 <29e8ac53-f7da-4896-8121-2abc25ec2c95@gmail.com>
In-Reply-To: <29e8ac53-f7da-4896-8121-2abc25ec2c95@gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sat, 13 Jul 2024 09:55:56 -0700
Message-ID: <CAKgT0Udmr8q8V7x6ZqHQVxFbCnwB-6Ttybx_PP_3Xr9X-DgjKA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 06/13] mm: page_frag: reuse existing space for
 'size' and 'pfmemalloc'
To: Yunsheng Lin <yunshenglin0825@gmail.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 10:20=E2=80=AFPM Yunsheng Lin <yunshenglin0825@gmai=
l.com> wrote:
>
> On 7/13/2024 12:55 AM, Alexander Duyck wrote:
>
> ...
>
> >>
> >> So it is about ensuring the additional room due to alignment requireme=
nt
> >> being placed at the end of a fragment, in order to avoid false sharing
> >> between the last fragment and the current fragment as much as possible=
,
> >> right?
> >>
> >> I am generally agreed with above if we can also ensure skb coaleasing =
by
> >> doing offset count-up instead of offset countdown.
> >>
> >> If there is conflict between them, I am assuming that enabling skb fra=
g
> >> coaleasing is prefered over avoiding false sharing, right?
> >
> > The question I would have is where do we have opportunities for this
> > to result in coalescing? If we are using this to allocate skb->data
> > then there isn't such a chance as the tailroom gets in the way.
> >
> > If this is for a device allocating for an Rx buffer we won't get that
> > chance as we have to preallocate some fixed size not knowing the
> > buffer that is coming, and it needs to usually be DMA aligned in order
> > to avoid causing partial cacheline reads/writes. The only way these
> > would combine well is if you are doing aligned fixed blocks and are
> > the only consumer of the page frag cache. It is essentially just
> > optimizing for jumbo frames in that case.
>
> And hw-gro or sw-gro.

No and no. The problem is for hw-gro in many cases the device will be
DMA aligning the start of writes for each new frame that comes in. As
such it is possible you won't be able to make use of this unless the
device is either queueing up the entire packet before writing it to
memory, or taking a double penalty for partial cache line writes which
will negatively impact performance. For sw-gro it won't happen since
as I mentioned the device is doing DMA aligned writes usually w/ fixed
size buffers that will be partially empty. As such coalescing will
likely not be possible in either of those scenarios.

This is why I was so comfortable using the reverse ordering for the
allocations. Trying to aggregate frames in this way will be very
difficult and the likelihood of anyone ever needing to do it is
incredibly small.

> >
> > If this is for some software interface why wouldn't it request the
> > coalesced size and do one allocation rather than trying to figure out
> > how to perform a bunch of smaller allocations and then trying to merge
> > them together after the fact.
>
> I am not sure I understand what 'some software interface' is referring
> to, I hope you are not suggesting the below optimizations utilizing of
> skb_can_coalesce() checking is unnecessary:(
>
> https://elixir.bootlin.com/linux/v6.10-rc7/C/ident/skb_can_coalesce
>
> Most of the usecases do that for the reason below as mentioned in the
> Documentation/mm/page_frags.rst as my understanding:
> "There is also a use case that needs minimum memory in order for forward
> progress, but more performant if more memory is available."

No what I am talking about is that it will be expensive to use and
have very little benefit to coalesce frames coming from a NIC as I
called out above. Most NICs won't use page frags anyway they will be
using page pool which is a slightly different beast anyway.

> >
> >>>
> >>>> The above is why I added the below paragraph in the doc to make the =
semantic
> >>>> more explicit:
> >>>> "Depending on different aligning requirement, the page_frag API call=
er may call
> >>>> page_frag_alloc*_align*() to ensure the returned virtual address or =
offset of
> >>>> the page is aligned according to the 'align/alignment' parameter. No=
te the size
> >>>> of the allocated fragment is not aligned, the caller needs to provid=
e an aligned
> >>>> fragsz if there is an alignment requirement for the size of the frag=
ment."
> >>>>
> >>>> And existing callers of page_frag aligned API does seems to follow t=
he above
> >>>> rule last time I checked.
> >>>>
> >>>> Or did I miss something obvious here?
> >>>
> >>> No you didn't miss anything. It is just that there is now more
> >>> potential for error than there was before.
> >>
> >> I guess the 'error' is referred to the 'false sharing' mentioned above=
,
> >> right? If it is indeed an error, are we not supposed to fix it instead
> >> of allowing such implicit implication? Allowing implicit implication
> >> seems to make the 'error' harder to reproduce and debug.
> >
> > The concern with the code as it stands is that if I am not mistaken
> > remaining isn't actually aligned. You aligned it, then added fragsz.
> > That becomes the start of the next frame so if fragsz isn't aligned
> > the next requester will be getting an unaligned buffer, or one that is
> > only aligned to the previous caller's alignment.
>
> As mentioned below:
> https://lore.kernel.org/all/3da33d4c-a70e-23a4-8e00-23fe96dd0c1a@huawei.c=
om/
>
> what alignment semantics are we providing here:
> 1. Ensure alignment for both offset and fragsz.
> 2. Ensure alignment for offset only.
> 3. Ensure alignment for fragsz only.
>
> As my understanding, the original code before this patchset is only
> ensuring alignment for offset too. So there may be 'false sharing'
> both before this patchset and after this patchset. It would be better
> not to argue about which implementation having more/less potential
> to avoid the 'false sharing', it is an undefined behavior, the argument
> would be endless depending on usecase and personal preference.
>
> As I said before, I would love to retain the old undefined behavior
> when there is a reasonable way to support the new usecases.

My main concern is that you were aligning "remaining", then adding
fragsz, and storing that. That was then used as the offset for the
next buffer. That isn't aligned since fragsz and the previous offset
aren't guaranteed to align with the new allocation.

So at a minimum the existing code cannot be using nc->remaining when
generating the pointer to the page. Instead it has to be using the
aligned version of that value that you generated before adding fragsz
and verifying there is space.

> >
> >>>
> >>>>> need to align the remaining, then add fragsz, and then I guess you
> >>>>> could store remaining and then subtract fragsz from your final virt=
ual
> >>>>> address to get back to where the starting offset is actually locate=
d.
> >>>>
> >>>> remaining =3D __ALIGN_KERNEL_MASK(nc->remaining, ~align_mask);
> >>>> remaining +=3D fragsz;
> >>>> nc->remaining =3D remaining;
> >>>> return encoded_page_address(nc->encoded_va) + (size + remaining) - f=
ragsz;
> >>>>
> >>>> If yes, I am not sure what is the point of doing the above yet, it
> >>>> just seem to make thing more complicated and harder to understand.
> >>>
> >>> That isn't right. I am not sure why you are adding size + remaining o=
r
> >>> what those are supposed to represent.
> >>
> >> As the above assumes 'remaining' is a negative value as you suggested,
> >> (size + remaining) is supposed to represent the offset of next fragmen=
t
> >> to ensure we have count-up offset for enabling skb frag coaleasing, an=
d
> >> '- fragsz' is used to get the offset of current fragment.
> >>
> >>>
> >>> The issue was that the "remaining" ends up being an unaligned value a=
s
> >>> you were starting by aligning it and then adding fragsz. So by
> >>> subtracting fragsz you can get back to the aliglined start. What this
> >>> patch was doing before was adding the raw unaligned nc->remaining at
> >>> the end of the function.
> >>>
> >>>>>
> >>>>> Basically your "remaining" value isn't a safe number to use for an
> >>>>> offset since it isn't aligned to your starting value at any point.
> >>>>
> >>>> Does using 'aligned_remaining' local variable to make it more obviou=
s
> >>>> seem reasonable to you?
> >>>
> >>> No, as the value you are storing above isn't guaranteed to be aligned=
.
> >>> If you stored it before adding fragsz then it would be aligned.
> >>
> >> I have a feeling that what you are proposing may be conflict with enab=
ling
> >> skb frag coaleasing, as doing offset count-up seems to need some room =
to
> >> be reserved at the begin of a allocated fragment due to alignment requ=
irement,
> >> and that may mean we need to do both fragsz and offset aligning.
> >>
> >> Perhaps the 'remaining' changing in this patch does seems to make thin=
gs
> >> harder to discuss. Anyway, it would be more helpful if there is some p=
seudo
> >> code to show the steps of how the above can be done in your mind.
> >
> > Basically what you would really need do for all this is:
> >    remaining =3D __ALIGN_KERNEL_MASK(nc->remaining, ~align_mask);
> >    nc->remaining =3D remaining + fragsz;
> >    return encoded_page_address(nc->encoded_va) + size + remaining;
>

I might have mixed my explanation up a bit. This is assuming remaining
is a negative value as I mentioned before.

Basically the issue is your current code is using nc->remaining to
generate the current address and that is bad as it isn't aligned to
anything as fragsz was added to it and no alignment check had been
done on that value.

