Return-Path: <netdev+bounces-111124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4573992FED7
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 18:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2561F21C90
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 16:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52CA174EC9;
	Fri, 12 Jul 2024 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1d6X9um"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9936DBE65;
	Fri, 12 Jul 2024 16:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720803385; cv=none; b=krfTIUIiVMTgwc5bZ1f7Q9hTOjc0g0gQFMYjHLKzTlzvarvqMd4cPIO9U2k7XXcujqZV6P3Usg3l3Q1EfxAANM6HDyMSRvIrWmtRzR738UpLnLL1aZ3rLsa2uZn2yQo+LjfB/I7Fx3PI74+CN+37OMXB3Xk+AU0KAarse6snLgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720803385; c=relaxed/simple;
	bh=10KSzaGi6JkQ4845oGiZPzHZRLkRovr7N6Dyeh1fv38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMFIRh1f+BM+hVs3YSOP0W/eeY57b0NqxhXu6+UAackmWv7hCIxi9XuBUQDMkJ/Wqob0/BnYLeUmEP3HdOxN5CIDM5r4yY9E16e50eO3TmzQjzue1TVg6KNwCcvOxObUZDnw6EJngDfv6udyKfZ0zpkEx/RygJmr+0NMVu+rLqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1d6X9um; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-36796d2e5a9so1387710f8f.3;
        Fri, 12 Jul 2024 09:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720803382; x=1721408182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhuiitIAwxRd/b19p99cs5Q4+qnNsSSYtzsOP3NuPvQ=;
        b=A1d6X9umZiqZ3SaE/UwJX6Mbr10uCAAvu5OwLNL8WULxuPgh0YWLPwTW/UVB+UZZZ5
         EW46+mtSDiD413nyFXrp5YqWBddCQDCHjd/94mRJTbBh3t+oP4PJwi/E17AbQFPfRKC9
         x7dQIoiglQHjwoR15RptkC9CO5KMQ8l65KVdesKmNe+fmtPFHn0wU8pjytR1VOCbVl3r
         ZMX6V1ld4YQ+m/8/vgPmEOrW9/5oxfHYuhSCCR0/AWq4OTZrrpI9Wyh2gxG4wqmcr8B6
         uIavC2F1/I6Yp9AYvHHsRrqF+C9NIZBNJfhBIhXC1hXQxaaWDh32qmldSEkLX/JHcgW3
         m44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720803382; x=1721408182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhuiitIAwxRd/b19p99cs5Q4+qnNsSSYtzsOP3NuPvQ=;
        b=NpLT8MvIpnfihgFqzguXmsk2kbOb3XpXZGlyGgrqIgml63ShYg3aZVBFztv/GaWmsd
         Fnux/Ek1apCVgBgIzc0wV8uEO89YL7nkrrjftbL36xJVIZiJILki9oWeouUHVTkX3t0J
         DVlNWGlvu5QmeMP2cEMp1jahWVo3IJaFVYgVFTOMGDLWWVT9Oxfaq259KL/RkmHFewGH
         3gZHVjW+0wdUDPehB/vkyebbdvRH5QkdhK2VE2FnRifrJIxhQ/yOjDCLps0+0SHNynpc
         oq7x0LMc3oBefSv8RIMbIqCCxmYJ9zVr6AKdekh1UsJ4AJ+RFnXQYgdUPD+0RZfCiibt
         StoA==
X-Forwarded-Encrypted: i=1; AJvYcCXirOHVrRfjjaAW+Yb21MiWSM40lKTUzejLX/k0E79RW5FVkgusz8GeLaRAj4x6t45KEhTveqEGvsBSfqq7hhcTwAeLxCi9eRsSXjTtAZ4LyV3TlmbYXs9b41e3yB9ZZxkviltF
X-Gm-Message-State: AOJu0YwlOzfScScdBENFbBHDBQHzKyEURV8ey7ThBFdkvjZLE8o5mFkK
	WsuhrKd4BwYQOHnz+XtwqoARJZ7Fx7cHZ1IPi3GACrZiaJTDQEffoSrPWrgJgAlD9Qd5mcYaFZ7
	cPNt1fbvExZBIExZkn6UaMqe2B8+v55ho
X-Google-Smtp-Source: AGHT+IF9VQyLvkAaTO5urEuI2/qG8nWKqoESvZN2R4YolJXAB69KV7NscorkImz+5VeUYl0N63NZq6pIUvXZQyVMbsU=
X-Received: by 2002:a5d:6981:0:b0:366:ebd1:3bc1 with SMTP id
 ffacd0b85a97d-367cea45fdamr8599206f8f.3.1720803381607; Fri, 12 Jul 2024
 09:56:21 -0700 (PDT)
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
 <df38c0fb-64a9-48da-95d7-d6729cc6cf34@huawei.com>
In-Reply-To: <df38c0fb-64a9-48da-95d7-d6729cc6cf34@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 12 Jul 2024 09:55:44 -0700
Message-ID: <CAKgT0UdSjmJoaQvTOz3STjBi2PazQ=piWY5wqFsYFBFLcPrLjQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 06/13] mm: page_frag: reuse existing space for
 'size' and 'pfmemalloc'
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 1:42=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/7/12 0:49, Alexander Duyck wrote:
> > On Thu, Jul 11, 2024 at 1:16=E2=80=AFAM Yunsheng Lin <linyunsheng@huawe=
i.com> wrote:
> >>
> >> On 2024/7/10 23:28, Alexander H Duyck wrote:
> >
> > ...
> >
> >>>>
> >>>> Yes, agreed. It would be good to be more specific about how to avoid
> >>>> the above problem using a signed negative number for 'remaining' as
> >>>> I am not sure how it can be done yet.
> >>>>
> >>>
> >>> My advice would be to go back to patch 3 and figure out how to do thi=
s
> >>> re-ordering without changing the alignment behaviour. The old code
> >>> essentially aligned both the offset and fragsz by combining the two a=
nd
> >>> then doing the alignment. Since you are doing a count up setup you wi=
ll
> >>
> >> I am not sure I understand 'aligned both the offset and fragsz ' part,=
 as
> >> 'fragsz' being aligned or not seems to depend on last caller' align_ma=
sk,
> >> for the same page_frag_cache instance, suppose offset =3D 32768 initia=
lly for
> >> the old code:
> >> Step 1: __page_frag_alloc_align() is called with fragsz=3D7 and align_=
mask=3D~0u
> >>        the offset after this is 32761, the true fragsz is 7 too.
> >>
> >> Step 2: __page_frag_alloc_align() is called with fragsz=3D7 and align_=
mask=3D-16
> >>         the offset after this is 32752, the true fragsz is 9, which do=
es
> >>         not seems to be aligned.
> >
> > I was referring to my original code before this patchset. I was doing
> > the subtraction of the fragsz first, and then aligning which would end
> > up padding the end of the frame as it was adding to the total size by
> > pulling the offset down *after* I had already subtracted fragsz. The
> > result was that I was always adding additional room depending on the
> > setting of the fragsz and how it related to the alignment. After
> > changing the code to realign on the start of the next frag the fragsz
> > is at the mercy of the next caller's alignment. In the event that the
> > caller didn't bother to align the fragsz by the align mask before hand
> > they can end up with a scenario that might result in false sharing.
>
> So it is about ensuring the additional room due to alignment requirement
> being placed at the end of a fragment, in order to avoid false sharing
> between the last fragment and the current fragment as much as possible,
> right?
>
> I am generally agreed with above if we can also ensure skb coaleasing by
> doing offset count-up instead of offset countdown.
>
> If there is conflict between them, I am assuming that enabling skb frag
> coaleasing is prefered over avoiding false sharing, right?

The question I would have is where do we have opportunities for this
to result in coalescing? If we are using this to allocate skb->data
then there isn't such a chance as the tailroom gets in the way.

If this is for a device allocating for an Rx buffer we won't get that
chance as we have to preallocate some fixed size not knowing the
buffer that is coming, and it needs to usually be DMA aligned in order
to avoid causing partial cacheline reads/writes. The only way these
would combine well is if you are doing aligned fixed blocks and are
the only consumer of the page frag cache. It is essentially just
optimizing for jumbo frames in that case.

If this is for some software interface why wouldn't it request the
coalesced size and do one allocation rather than trying to figure out
how to perform a bunch of smaller allocations and then trying to merge
them together after the fact.

> >
> >> The above is why I added the below paragraph in the doc to make the se=
mantic
> >> more explicit:
> >> "Depending on different aligning requirement, the page_frag API caller=
 may call
> >> page_frag_alloc*_align*() to ensure the returned virtual address or of=
fset of
> >> the page is aligned according to the 'align/alignment' parameter. Note=
 the size
> >> of the allocated fragment is not aligned, the caller needs to provide =
an aligned
> >> fragsz if there is an alignment requirement for the size of the fragme=
nt."
> >>
> >> And existing callers of page_frag aligned API does seems to follow the=
 above
> >> rule last time I checked.
> >>
> >> Or did I miss something obvious here?
> >
> > No you didn't miss anything. It is just that there is now more
> > potential for error than there was before.
>
> I guess the 'error' is referred to the 'false sharing' mentioned above,
> right? If it is indeed an error, are we not supposed to fix it instead
> of allowing such implicit implication? Allowing implicit implication
> seems to make the 'error' harder to reproduce and debug.

The concern with the code as it stands is that if I am not mistaken
remaining isn't actually aligned. You aligned it, then added fragsz.
That becomes the start of the next frame so if fragsz isn't aligned
the next requester will be getting an unaligned buffer, or one that is
only aligned to the previous caller's alignment.

> >
> >>> need to align the remaining, then add fragsz, and then I guess you
> >>> could store remaining and then subtract fragsz from your final virtua=
l
> >>> address to get back to where the starting offset is actually located.
> >>
> >> remaining =3D __ALIGN_KERNEL_MASK(nc->remaining, ~align_mask);
> >> remaining +=3D fragsz;
> >> nc->remaining =3D remaining;
> >> return encoded_page_address(nc->encoded_va) + (size + remaining) - fra=
gsz;
> >>
> >> If yes, I am not sure what is the point of doing the above yet, it
> >> just seem to make thing more complicated and harder to understand.
> >
> > That isn't right. I am not sure why you are adding size + remaining or
> > what those are supposed to represent.
>
> As the above assumes 'remaining' is a negative value as you suggested,
> (size + remaining) is supposed to represent the offset of next fragment
> to ensure we have count-up offset for enabling skb frag coaleasing, and
> '- fragsz' is used to get the offset of current fragment.
>
> >
> > The issue was that the "remaining" ends up being an unaligned value as
> > you were starting by aligning it and then adding fragsz. So by
> > subtracting fragsz you can get back to the aliglined start. What this
> > patch was doing before was adding the raw unaligned nc->remaining at
> > the end of the function.
> >
> >>>
> >>> Basically your "remaining" value isn't a safe number to use for an
> >>> offset since it isn't aligned to your starting value at any point.
> >>
> >> Does using 'aligned_remaining' local variable to make it more obvious
> >> seem reasonable to you?
> >
> > No, as the value you are storing above isn't guaranteed to be aligned.
> > If you stored it before adding fragsz then it would be aligned.
>
> I have a feeling that what you are proposing may be conflict with enablin=
g
> skb frag coaleasing, as doing offset count-up seems to need some room to
> be reserved at the begin of a allocated fragment due to alignment require=
ment,
> and that may mean we need to do both fragsz and offset aligning.
>
> Perhaps the 'remaining' changing in this patch does seems to make things
> harder to discuss. Anyway, it would be more helpful if there is some pseu=
do
> code to show the steps of how the above can be done in your mind.

Basically what you would really need do for all this is:
  remaining =3D __ALIGN_KERNEL_MASK(nc->remaining, ~align_mask);
  nc->remaining =3D remaining + fragsz;
  return encoded_page_address(nc->encoded_va) + size + remaining;

The issue is you cannot be using page_frag_cache_current_va as that
pointer will always be garbage as it isn't aligned to anything. It
isn't like the code that I had that was working backwards as the
offset cannot be used as soon as you compute it since you add fragsz
to it.

For any countup you have to align the current offset/remaining value,
then that value is used for computing the page address, and you store
the offset/remaining plus fragsz adjustment. At which point your
offset/remaining pointer value isn't good for the current buffer
anymore.

