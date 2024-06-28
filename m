Return-Path: <netdev+bounces-107623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AA291BB8D
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 11:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4858C283AD9
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 09:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A0215278D;
	Fri, 28 Jun 2024 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0jEGxzm9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF6915253D
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719567291; cv=none; b=s8QR3Pd84RocKERnL+imACY/NaoO9d5T2zUQpQvlh41ZSmbyCIfctFraJVM1pnn6dhvVEvSsnfoVSsyE/hTOZiO4kzlSkJdeG8LAEiDvvvnnbsfo8t1d2ep+asZWSskwuQXpjNO9B8NOMfAHAATPEM37UCXMox+YVgGkADREt6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719567291; c=relaxed/simple;
	bh=mVgpkGZeEUIJG9UJ4SJVmxmneMeKnT/4EHHpcMGGZ2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=er6TGkSZuh+w3u5cV2QK3lBB/ullegXhFW1ErygpWpymrmrZpd8v0Dc/wsTNJ+1Tsj88OHgWdi7cNGN8AXiK6+alYNnDvb7Rsa2fWJwXdH6u/QaPvMv2AZvCWjWtGQXR6pzuUdmqNx2910KZKpMvvOFuyePQ0YmOALbBKU+RXao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0jEGxzm9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42565cdf99cso4266945e9.3
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 02:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719567288; x=1720172088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5Gyzd0KEYojFlORA9Zt8V98aCcTYQ8VgOMnEXwuyS0=;
        b=0jEGxzm9bjV7qzwpsbLi/sY/bku21UXzhP846PPiz3H7hFYF4Q/cErPNFDbeJmGcbW
         RzeySL5v8Q/vBMEAB8IQe6Oy7Wm7K6hwHewCnUBeRVbxQwEGzK8rE76ztohLnOmlQYqc
         g5dY7JdMaZsMrJESPO+MhLQ8HDr9C4DSani1tsHd2PSxsvzgnXEPKcb1EwSCuDco6qmH
         HWT/R2Yjn+fTIK47svur0u+p1G8xgJq8y0YroZVtrNGLYukVoX9Wi+uQKV0OomaVDM6u
         yb98FQP9rZ54aoRIv0tn1YFWp1dDQhEZba1Gry3Wss1f6oBNJUOeck4JiuhZbP2KRzKU
         wUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719567288; x=1720172088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5Gyzd0KEYojFlORA9Zt8V98aCcTYQ8VgOMnEXwuyS0=;
        b=EBBxQSKaHdnKX9/IrHZp+AYKR0QlHNEQJgSiQNBTpkzxqSOIq4lqGL/6b5nYWK6zUx
         +colZ3d31DZpm/H7lM+GUZ0z3dKPnMTnKHnrA38tmgcgjtBI/pYa2xpEfQIS2OAVaPnf
         GKBUXLHRrW7EHGc0rX+jQnMc6jZpod4eqjMtemgAasYDk6bujoBHofo4Y1q5K2As1fQw
         L9P3G8NfdVkD5FfBIpiPDiKLJGxAuD+lU7BvbsQDYYlmBPkNPoJ0+OV/bfSb+5y5wb5d
         rGfmVdJ4/w1sVOC4L7Qj44XtJ5qwgNhN9H0kjkMfMA1otDbHpHuIIGSkpQu0XmjWXUX4
         WfHA==
X-Forwarded-Encrypted: i=1; AJvYcCXtQuVBBcFMzjXxF3Iw7SB9MwJGApTuw182wFgH0QLojtIewhDkYZXM9GPaTAs6jNdRESY8fxX2i+DsFtWv4eCRta4a+d/t
X-Gm-Message-State: AOJu0YwCtVB9bSLQTlFOIOpq24AYGjxcNy84cJYJQaWrra5f2wt7e+VJ
	GaTg4pmCBKcBaz7Fsqv2wJ3b5TNbgADzxa8zzx0aMDPhUgqZ2R78F8VKWAq8ndFI2xJNx+PQXbd
	OooFRgBWPcZXeEbzGSlMyl8haIddgL+SsTbyo
X-Google-Smtp-Source: AGHT+IHkMX5345OLYcmRT3XnelwwzbNOLPwlwqhS2DVYP+oCW1ISdTPYj99BI+fmIoO/MdYp0rp3L25a15KF4hw0UuA=
X-Received: by 2002:a05:600c:1c1e:b0:425:692d:c72d with SMTP id
 5b1f17b1804b1-425692dd443mr23095585e9.32.1719567287924; Fri, 28 Jun 2024
 02:34:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619192131.do.115-kees@kernel.org> <20240619193357.1333772-4-kees@kernel.org>
 <cc301463-da43-4991-b001-d92521384253@suse.cz> <202406201147.8152CECFF@keescook>
 <1917c5a5-62af-4017-8cd0-80446d9f35d3@suse.cz> <Zn5LqMlnbuSMx7H3@Boquns-Mac-mini.home>
 <c5934f76-3ce8-466e-80d1-c56ebb5a158e@suse.cz> <CAH5fLggjrbdUuT-H-5vbQfMazjRDpp2+k3=YhPyS17ezEqxwcw@mail.gmail.com>
 <c45eb0c9-21b9-4e29-a9d8-f3044c77822e@suse.cz>
In-Reply-To: <c45eb0c9-21b9-4e29-a9d8-f3044c77822e@suse.cz>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 28 Jun 2024 11:34:35 +0200
Message-ID: <CAH5fLghsZRemYUwVvhk77o6y1foqnCeDzW4WZv6ScEWna2+_jw@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] mm/slab: Introduce kmem_buckets_create() and family
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Boqun Feng <boqun.feng@gmail.com>, Kees Cook <kees@kernel.org>, 
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, jvoisin <julien.voisin@dustri.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Xiu Jianfeng <xiujianfeng@huawei.com>, 
	Suren Baghdasaryan <surenb@google.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>, Thomas Graf <tgraf@suug.ch>, 
	Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 11:17=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 6/28/24 11:06 AM, Alice Ryhl wrote:
> >> >>
> >> >
> >> > I took a quick look as what kmem_buckets is, and seems to me that al=
ign
> >> > doesn't make sense here (and probably not useful in Rust as well)
> >> > because a kmem_buckets is a set of kmem_caches, each has its own obj=
ect
> >> > size, making them share the same alignment is probably not what you
> >> > want. But I could be missing something.
> >>
> >> How flexible do you need those alignments to be? Besides the power-of-=
two
> >> guarantees, we currently have only two odd sizes with 96 and 192. If t=
hose
> >> were guaranteed to be aligned 32 bytes, would that be sufficient? Also=
 do
> >> you ever allocate anything smaller than 32 bytes then?
> >>
> >> To summarize, if Rust's requirements can be summarized by some rules a=
nd
> >> it's not completely ad-hoc per-allocation alignment requirement (or if=
 it
> >> is, does it have an upper bound?) we could perhaps figure out the crea=
tion
> >> of rust-specific kmem_buckets to give it what's needed?
> >
> > Rust's allocator API can take any size and alignment as long as:
> >
> > 1. The alignment is a power of two.
> > 2. The size is non-zero.
> > 3. When you round up the size to the next multiple of the alignment,
> > then it must not overflow the signed type isize / ssize_t.
> >
> > What happens right now is that when Rust wants an allocation with a
> > higher alignment than ARCH_SLAB_MINALIGN, then it will increase size
> > until it becomes a power of two so that the power-of-two guarantee
> > gives a properly aligned allocation.
>
> So am I correct thinking that, if the cache of size 96 bytes guaranteed a
> 32byte alignment, and 192 bytes guaranteed 64byte alignment, and the rest=
 of
> sizes with the already guaranteed power-of-two alignment, then on rust si=
de
> you would only have to round up sizes to the next multiples of the aligne=
mnt
> (rule 3 above) and that would be sufficient?
>  Abstracting from the specific sizes of 96 and 192, the guarantee on kmal=
loc
> side would have to be - guarantee alignment to the largest power-of-two
> divisor of the size. Does that sound right?
>
> Then I think we could have some flag for kmem_buckets creation that would=
 do
> the right thing.

If kmalloc/krealloc guarantee that an allocation is aligned according
to the largest power-of-two divisor of the size, then the Rust
allocator would definitely be simplified as we would not longer need
this part:

if layout.align() > bindings::ARCH_SLAB_MINALIGN {
    // The alignment requirement exceeds the slab guarantee, thus try
to enlarge the size
    // to use the "power-of-two" size/alignment guarantee (see
comments in `kmalloc()` for
    // more information).
    //
    // Note that `layout.size()` (after padding) is guaranteed to be a
multiple of
    // `layout.align()`, so `next_power_of_two` gives enough alignment
guarantee.
    size =3D size.next_power_of_two();
}

We would only need to keep the part that rounds up the size to a
multiple of the alignment.

Alice

