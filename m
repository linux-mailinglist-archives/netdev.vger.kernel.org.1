Return-Path: <netdev+bounces-137295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2D79A54F1
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 18:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA6C61C20975
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A411193436;
	Sun, 20 Oct 2024 16:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ic2AW0kz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3260B567D;
	Sun, 20 Oct 2024 16:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729440339; cv=none; b=K44mM/4hEBIV/oTHUQOU6C4DL3Rxx1IY5WTFMrOcYpRvcgVajv70ivwyTBDfbNR8FM17oy3B641TbEoPu4Ok9wIfmM9qqIYuIjZWXqZBVewQ5zpcY/S3FEyJKOQZdYvGIfjA3tquY/Zye/9a8J8VpehlAkSTiKhPhNLV6NVpVwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729440339; c=relaxed/simple;
	bh=UFG4jRzqjHXc3n1ppQNZKoBh1uR/uxtT3NKkqC7yL1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLqMb6zCBDMSYi9AsTtCLS+FJzPoRb31DPaJMxr18tVF5dYruIn39g4oYI/nLjrdyX0SS5fV4PlaTtbmB4zTL3ZdFCPX7xMB7QULQ7G92HgImaRGhaRSnht+oI8baA1V5XhlWu+3ZhQKTXud9vf16cRpMAxFsKtK7cDE3Fi/qsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ic2AW0kz; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d533b5412so2498449f8f.2;
        Sun, 20 Oct 2024 09:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729440335; x=1730045135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJQ7NzBQmKMeNc7M9zrhC1o48BxNYFY3M9Ix09latD8=;
        b=ic2AW0kzvgM9Rt5HB4gYYyEler4bCSbYrY0IE0xh9O8n4FIPWf6I358fYhHOMQSa+U
         HwRk5+Wm6Pbr4dNzFYWmIhgSvlTroG5YAcARxpHou3NB+VuahVraRr85jcUrUOUnFW6H
         n/D702SL3OjQl+1p0tqejYz3671p7IxEGpOqL2chZZZtkLlpheyfNXLC8U/1/Jx13K/Y
         kYOl2aDM9Yht6W64O8LwuTFuWYpquM4xbZvGKZvWuI1KxoaLedNYNZ9TzhUsfbCuFc1z
         YggqH5YvaSGgb5qOx31so02i9Arryl35lK2O8FZ47Le7fQsrbSO+Vl4y/1cbFHDKqFCu
         1B5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729440335; x=1730045135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJQ7NzBQmKMeNc7M9zrhC1o48BxNYFY3M9Ix09latD8=;
        b=lrsvLBFPCYBEVND4LtawP5nNYLYbhBdvAQN6sY9sUZfFBNtEKdtkgz4UwAdRuWeIw2
         ey0k8UB5sVhnpl3VoBL0GNsR2vXCgcKGR1YaXb/Ag+vwKGKmBx2CUJejvkVK2A5HMoTC
         I/Dc0hZONbWL4UjYaBIu7bjqf5EK2ZTkf4bJEx3/2M53ckvB53a3wV68vNkbMIudybJN
         vLSeasJ+LqSd/zxtbaaxVsAye9gf/ZDPLD0Qr0Er6vTK0889LeeQWomQf6uVUd5MqsUO
         Yy2CcI/MDXMaER6DEnFRom+WZgCaQwaYx6A8nRJG/z0UvsVvUJP1kvkrZkZiZMHAb7Yd
         ACVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyecSEnZWnxCt9rekHdQ4OG6U8/1djQZubqEHKPxCugolvNam7N+StZNggdzFGRCYCzqOTkhHb@vger.kernel.org, AJvYcCXHSV1RUu/rtTmW9Pre5jX0SOuR1S2s+ZAopsKXiLRl7ez2Ee62YRo7x6BGMtSRQ+0FSIXZ+tt0r0WtjTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMwhSoCVX64hjla9NOd8WIiRV4bgyHJFin4seh6sd199XiTnha
	2wqFOUI3WH3MlCayXrezT+/BEdxuruWWUmAmpgz6ENbzFry1A2YvZ7RxMSxtbCr8B6bEAPhuhOl
	S0DbUW6i4sIwBX9Q0tE4NTNdyg3Q=
X-Google-Smtp-Source: AGHT+IFZ/Fy2Ii2u5SIrL80Yn1WMaw2/2zE2RJB2oGdpgKR21e8zwfzBaVyl3DbRVRkWkeI1wZdNcW9hHLkkRdWvQGo=
X-Received: by 2002:adf:f9d0:0:b0:374:c4e2:3ca7 with SMTP id
 ffacd0b85a97d-37eab4d13b7mr4964756f8f.5.1729440335166; Sun, 20 Oct 2024
 09:05:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018105351.1960345-1-linyunsheng@huawei.com>
 <20241018105351.1960345-11-linyunsheng@huawei.com> <CAKgT0UcrbmhJCm4=30Y12ZX9bWD_ChTn5vqHxKdTrGBP-FLk5w@mail.gmail.com>
 <a6703e66-a8bc-43c9-a2b9-08f2a849c4ff@gmail.com>
In-Reply-To: <a6703e66-a8bc-43c9-a2b9-08f2a849c4ff@gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 20 Oct 2024 09:04:58 -0700
Message-ID: <CAKgT0UdawPJgh-J266cpRqNvCHFT=X=OM3CVBorBT0mTEGVpeg@mail.gmail.com>
Subject: Re: [PATCH net-next v22 10/14] mm: page_frag: introduce
 prepare/probe/commit API
To: Yunsheng Lin <yunshenglin0825@gmail.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 1:33=E2=80=AFAM Yunsheng Lin <yunshenglin0825@gmail=
.com> wrote:
>
> On 10/19/2024 2:03 AM, Alexander Duyck wrote:
>
> >
> > Not a huge fan of introducing a ton of new API calls and then having
> > to have them all applied at once in the follow-on patches. Ideally the
> > functions and the header documentation for them would be introduced in
> > the same patch as well as examples on how it would be used.
> >
> > I really think we should break these up as some are used in one case,
> > and others in another and it is a pain to have a pile of abstractions
> > that are all using these functions in different ways.
>
> I am guessing this patch may be split into three parts to make it more
> reviewable and easier to discuss here:
> 1. Prepare & commit related API, which is still the large one.
> 2. Probe API related API.

In my mind the first two listed here are much more related to each
other than this abort api.

> 3. Abort API.

I wonder if we couldn't look at introducing this first as it is
actually closer to the existing API in terms of how you might use it.
The only spot of commonality I can think of in terms of all these is
that we would need to be able to verify the VA, offset, and size. I
partly wonder if for our page frag API we couldn't get away with
passing a virtual address instead of a page for the page frag. It
would save us having to do the virt_to_page or page_to_virt when
trying to verify a commit or a revert.


> And it is worthing mentioning that even if this patch is split into more
> patches, it seems impossible to break patch 12 up as almost everything
> related to changing "page_frag" to "page_frag_cache" need to be one
> patch to avoid compile error.

That is partly true. One issue is that there are more changes there
than just changing out the page APIs. It seems like you went in
performing optimizations as soon as you were changing out the page
allocation method used. For example one thing that jumps out at me was
the removal of linear_to_page and its replacement with
spd_fill_linear_page which seems to take on other pieces of the
function as well as you made it a return path of its own when that
section wasn't previously.

Ideally changing out the APIs used should be more about doing just
that and avoiding additional optimization or deviations from the
original coded path if possible.

> >
> >> +static inline void page_frag_alloc_abort(struct page_frag_cache *nc,
> >> +                                        unsigned int fragsz)
> >> +{
> >> +       VM_BUG_ON(fragsz > nc->offset);
> >> +
> >> +       nc->pagecnt_bias++;
> >> +       nc->offset -=3D fragsz;
> >> +}
> >> +
> >
> > We should probably have the same checks here you had on the earlier
> > commit. We should not be allowing blind changes. If we are using the
> > commit or abort interfaces we should be verifying a page frag with
> > them to verify that the request to modify this is legitimate.
>
> As an example in 'Preparation & committing API' section of patch 13, the
> abort API is used to abort the operation of page_frag_alloc_*() related
> API, so 'page_frag' is not available for doing those checking like the
> commit API. For some case without the needing of complicated prepare &
> commit API like tun_build_skb(), the abort API can be used to abort the
> operation of page_frag_alloc_*() related API when bpf_prog_run_xdp()
> returns XDP_DROP knowing that no one else is taking extra reference to
> the just allocated fragment.
>
> +Allocation & freeing API
> +------------------------
> +
> +.. code-block:: c
> +
> +    void *va;
> +
> +    va =3D page_frag_alloc_align(nc, size, gfp, align);
> +    if (!va)
> +        goto do_error;
> +
> +    err =3D do_something(va, size);
> +    if (err) {
> +        page_frag_alloc_abort(nc, size);
> +        goto do_error;
> +    }
> +
> +    ...
> +
> +    page_frag_free(va);
>
>
> If there is a need to abort the commit API operation, we probably call
> it something like page_frag_commit_abort()?

I would argue that using an abort API in such a case is likely not
valid then. What we most likely need to be doing is passing the va as
a part of the abort request. With that we should be able to work our
way backwards to get back to verifying the fragment came from the
correct page before we allow stuffing it back on the page.

> >
> >>   void page_frag_free(void *addr);
> >>
> >>   #endif
> >> diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
> >> index f55d34cf7d43..5ea4b663ab8e 100644
> >> --- a/mm/page_frag_cache.c
> >> +++ b/mm/page_frag_cache.c
> >> @@ -112,6 +112,27 @@ unsigned int __page_frag_cache_commit_noref(struc=
t page_frag_cache *nc,
> >>   }
> >>   EXPORT_SYMBOL(__page_frag_cache_commit_noref);
> >>
> >> +void *__page_frag_alloc_refill_probe_align(struct page_frag_cache *nc=
,
> >> +                                          unsigned int fragsz,
> >> +                                          struct page_frag *pfrag,
> >> +                                          unsigned int align_mask)
> >> +{
> >> +       unsigned long encoded_page =3D nc->encoded_page;
> >> +       unsigned int size, offset;
> >> +
> >> +       size =3D PAGE_SIZE << encoded_page_decode_order(encoded_page);
> >> +       offset =3D __ALIGN_KERNEL_MASK(nc->offset, ~align_mask);
> >> +       if (unlikely(!encoded_page || offset + fragsz > size))
> >> +               return NULL;
> >> +
> >> +       pfrag->page =3D encoded_page_decode_page(encoded_page);
> >> +       pfrag->size =3D size - offset;
> >> +       pfrag->offset =3D offset;
> >> +
> >> +       return encoded_page_decode_virt(encoded_page) + offset;
> >> +}
> >> +EXPORT_SYMBOL(__page_frag_alloc_refill_probe_align);
> >> +
> >
> > If I am not mistaken this would be the equivalent of allocating a size
> > 0 fragment right? The only difference is that you are copying out the
> > "remaining" size, but we could get that from the offset if we knew the
> > size couldn't we? Would it maybe make sense to look at limiting this
> > to PAGE_SIZE instead of passing the size of the actual fragment?
>
> I am not sure if I understand what does "limiting this to PAGE_SIZE"
> mean here.

Right now you are returning pfrag->size =3D size - offset. I am
wondering if we should be returning something more like "pfrag->size =3D
PAGE_SIZE - (offset % PAGE_SIZE)".

> I probably should mention the usecase of probe API here. For the usecase
> of mptcp_sendmsg(), the minimum size of a fragment can be smaller when
> the new fragment can be coalesced to previous fragment as there is an
> extra memory needed for some header if the fragment can not be coalesced
> to previous fragment. The probe API is mainly used to see if there is
> any memory left in the 'page_frag_cache' that can be coalesced to
> previous fragment.

What is the fragment size we are talking about? In my example above we
would basically be looking at rounding the page off to the nearest
PAGE_SIZE block before we would have to repeat the call to grab the
next PAGE_SIZE block. Since the request size for the page frag alloc
API is supposed to be limited to 4K or less it would make sense to
limit the probe API similarly.

