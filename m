Return-Path: <netdev+bounces-110895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B8592ED09
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 18:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BBCA1C21072
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 16:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEFB16D4EA;
	Thu, 11 Jul 2024 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqih9oiK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849C016D4D2;
	Thu, 11 Jul 2024 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716589; cv=none; b=ow/DEkiAjn9+FnsSQv7457F3XrcxyiG7QGb1j6BCh/9jw/ziHnd1VgYCgnX/xYRMmZzHYPqUSRED9OcVJxB6h+OC+N+0aQKSScR+Ew+f5V+IXvBMQUMKsxneyLhQaqa2x/bufF7yLjsAal/3E/hsrDTWHT8nuZO8C7CaZ7cJzqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716589; c=relaxed/simple;
	bh=9Xsl1MdtyQXkQBqLyqYxifW4nwCeZkftpWPaJudny1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSSAXIixjU5x0vPu1fjYsCvFkmM01RAbeh2WGoY6Qv1UNTnubrGTxkmuY6+VB0H0uOeIbbqPNEwhuRQ5gfY7p6Yx6/QzuCLKfg28nwL35gyfHpez89LUYFAxGwX/vL5vTLuk5ZFx/0n+zkfaLA/CTF1a6a/u7lQM27dMI0S65OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqih9oiK; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4279c924ca6so2672195e9.0;
        Thu, 11 Jul 2024 09:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720716586; x=1721321386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajPnXMpJ4/AzzbvVdXpfE2ZBxYyBVXFGIzlJOg2lq+Q=;
        b=cqih9oiKYA4tJYNfozp9Q6BakEvGiPKHLEL+hJPxKeIyW/62W7tYZYd9SZdaL6eA9q
         HpbjjdhXZxqPT4PuTZ7sP/VYxsDNx2UYFAyuw6E89EIF6nb89zf1GYO6PoZFnCPsWzaD
         C7aq6+3aA/lildcMB4hA6FS7dpa0I7xDxj203afHAytE9ni3eSVUw0weO0GMMa0QUz0r
         ctV1MC9w5bdOkFZOxiXRxX/rs/IUMaSPDuGQJoDfKsnhBj1dau8fjuxf6hBl/BNUw108
         4FFNivOyGlpeLwbVY4aZ0SoeBd39hv5cdtm4nax0DFpInFE36NG+YLF308WnbX3y5/ch
         3ryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720716586; x=1721321386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajPnXMpJ4/AzzbvVdXpfE2ZBxYyBVXFGIzlJOg2lq+Q=;
        b=pfzkQ9GOSIOXcJ2ZnluM3fabl0jTi3aq/Ye0wmUVPm4ch7/9Xkf68wOmNEZf8k2Zs5
         FyzhXt1wGyfe+JbQu2pejj1mA6gq1Ywyyr7AzMLThiUgNxdvCRjZrGBetecbcnBKJiW1
         +WPVK0IA0mcJXzQl6L28+G6NWtneBLuKYOhZddNrnWqdd8iKvrlQSLLGwD5nPgTxgHhp
         fMhMYUFM2DJkRzV0D5zFrHPjMKUSAjEikrJL18cBmOfrUvfwD/MmIGhx6c0vZTSdxw19
         BJqH9/LvZLKSXMqZyC/If1LbJmsyf7qktZE4moaOBW/MgG26+YUOtdRvO6un39AJddiO
         QiGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ7LFTYRj1IH5SNltU0FdrXN85igHLYaJLmL8vGY8GflvQvI8AW83q60eYon3B8m4K1n6nI6mYPiGh+BTwcC+9NkID3NUnVhF2hH3pX+XAeQSttB7IhNpwxziVDhvTajLGA1Bc
X-Gm-Message-State: AOJu0YzZXUnNLXs3nTFD8oLTVQi0ooejM33gHzhnrlPNB6DYTRUIzZFO
	hTCN2FOjNnkj8nL253elU+fDbYM7Nt422tgyadHFBA0zpSXmuiEvaIB++rnCdoTG4S9k588V8Jj
	gUCShrh39K/2kc3Xt6cIXq3OvE+Rweg==
X-Google-Smtp-Source: AGHT+IFc7HUmEYXtlKgYDkVH3yjImijWEKyv1u8Kb7VsEAdpWPEY4UjSG0hV/MtfvCkDNjOpqFv4+gWq457GVJJ4Ezo=
X-Received: by 2002:a05:6000:2ab:b0:367:437f:1784 with SMTP id
 ffacd0b85a97d-367cea46275mr9552545f8f.7.1720716585630; Thu, 11 Jul 2024
 09:49:45 -0700 (PDT)
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
 <5daed410-063b-4d86-b544-d1a85bd86375@huawei.com>
In-Reply-To: <5daed410-063b-4d86-b544-d1a85bd86375@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 11 Jul 2024 09:49:09 -0700
Message-ID: <CAKgT0UdJPcnfOJ=-1ZzXbiFiA=8a0z_oVBgQC-itKB1HWBU+yA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 06/13] mm: page_frag: reuse existing space for
 'size' and 'pfmemalloc'
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 1:16=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/7/10 23:28, Alexander H Duyck wrote:

...

> >>
> >> Yes, agreed. It would be good to be more specific about how to avoid
> >> the above problem using a signed negative number for 'remaining' as
> >> I am not sure how it can be done yet.
> >>
> >
> > My advice would be to go back to patch 3 and figure out how to do this
> > re-ordering without changing the alignment behaviour. The old code
> > essentially aligned both the offset and fragsz by combining the two and
> > then doing the alignment. Since you are doing a count up setup you will
>
> I am not sure I understand 'aligned both the offset and fragsz ' part, as
> 'fragsz' being aligned or not seems to depend on last caller' align_mask,
> for the same page_frag_cache instance, suppose offset =3D 32768 initially=
 for
> the old code:
> Step 1: __page_frag_alloc_align() is called with fragsz=3D7 and align_mas=
k=3D~0u
>        the offset after this is 32761, the true fragsz is 7 too.
>
> Step 2: __page_frag_alloc_align() is called with fragsz=3D7 and align_mas=
k=3D-16
>         the offset after this is 32752, the true fragsz is 9, which does
>         not seems to be aligned.

I was referring to my original code before this patchset. I was doing
the subtraction of the fragsz first, and then aligning which would end
up padding the end of the frame as it was adding to the total size by
pulling the offset down *after* I had already subtracted fragsz. The
result was that I was always adding additional room depending on the
setting of the fragsz and how it related to the alignment. After
changing the code to realign on the start of the next frag the fragsz
is at the mercy of the next caller's alignment. In the event that the
caller didn't bother to align the fragsz by the align mask before hand
they can end up with a scenario that might result in false sharing.

> The above is why I added the below paragraph in the doc to make the seman=
tic
> more explicit:
> "Depending on different aligning requirement, the page_frag API caller ma=
y call
> page_frag_alloc*_align*() to ensure the returned virtual address or offse=
t of
> the page is aligned according to the 'align/alignment' parameter. Note th=
e size
> of the allocated fragment is not aligned, the caller needs to provide an =
aligned
> fragsz if there is an alignment requirement for the size of the fragment.=
"
>
> And existing callers of page_frag aligned API does seems to follow the ab=
ove
> rule last time I checked.
>
> Or did I miss something obvious here?

No you didn't miss anything. It is just that there is now more
potential for error than there was before.

> > need to align the remaining, then add fragsz, and then I guess you
> > could store remaining and then subtract fragsz from your final virtual
> > address to get back to where the starting offset is actually located.
>
> remaining =3D __ALIGN_KERNEL_MASK(nc->remaining, ~align_mask);
> remaining +=3D fragsz;
> nc->remaining =3D remaining;
> return encoded_page_address(nc->encoded_va) + (size + remaining) - fragsz=
;
>
> If yes, I am not sure what is the point of doing the above yet, it
> just seem to make thing more complicated and harder to understand.

That isn't right. I am not sure why you are adding size + remaining or
what those are supposed to represent.

The issue was that the "remaining" ends up being an unaligned value as
you were starting by aligning it and then adding fragsz. So by
subtracting fragsz you can get back to the aliglined start. What this
patch was doing before was adding the raw unaligned nc->remaining at
the end of the function.

> >
> > Basically your "remaining" value isn't a safe number to use for an
> > offset since it isn't aligned to your starting value at any point.
>
> Does using 'aligned_remaining' local variable to make it more obvious
> seem reasonable to you?

No, as the value you are storing above isn't guaranteed to be aligned.
If you stored it before adding fragsz then it would be aligned.

> >
> > As far as the negative value, it is more about making it easier to keep
> > track of what is actually going on. Basically we can use regular
> > pointer math and as such I suspect the compiler is having to do extra
> > instructions to flip your value negative before it can combine the
> > values via something like the LEA (load effective address) assembler
> > call.
>
> I am not an asm expert here, I am not sure I understand the optimization
> trick here.

The LEA instruction takes a base address adds 1/2/4/8 times a multiple
and then a fixed offset all in one function and provides an address as
an output. The general idea is that you could look at converting
things such that you are putting together the page address +
remaining*1 + PAGE_SIZE. Basically what I was getting at is that
addition works, but it doesn't do negative values for the multiple.

