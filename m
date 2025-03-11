Return-Path: <netdev+bounces-173901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0A5A5C2F2
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6715316CE7A
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451EC1C5F14;
	Tue, 11 Mar 2025 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EUqtzIUq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF3B1F94D
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741700667; cv=none; b=d9cKmOM+LEbdtfmWLSQ5EyAJ2tB9sly5LxGA6xuPOYxksnhvVJyfmbISlfhbvZ6GrcUF1yKZ1RxKPWRZ9XMb69rv2Qi1yEYPPY1e1u7DUvQJ8vY06h16BX4LFSNAvKnF48o31RJJo6c9jXE2iKoJDXtW1yfTIxUYud3w2hMS8k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741700667; c=relaxed/simple;
	bh=ZDvh640mXUQQF6buBwSlPYU4wimDdWWpP0QsQuvfiII=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BI9qlV66LbTyd+KbolPnDVH6HeFq2WeH0ujNofEaPhj+2DptAY80bDiwt4+zhzDE69M973sffY474OiuQaCgXvDw2Bh2n9yd7ywJvgydnj+9mPC7o0PA/cawqdmjTJD+5bXcaBeAZ/T0BN+uOVAZq4OqrZJN1Lqf0B3zuMucGiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EUqtzIUq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741700664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZDvh640mXUQQF6buBwSlPYU4wimDdWWpP0QsQuvfiII=;
	b=EUqtzIUqKzfXAOUwhXqGf2YO36s7nD4smKam1WKzfi1viK2xDlEusTTgS3I3s6mTA65xJ+
	gRgry3/7G6nZllgRJ/BZf4ch4JbSbvMlfHH5Gy9s+bWIGzPHdmNjjP2iKJvpC7h6YhbMA3
	NUgqTm6LARYvGkaI0imY3u360+3dO+4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-uKRNHMF1OeykszuG5e1mMw-1; Tue, 11 Mar 2025 09:44:22 -0400
X-MC-Unique: uKRNHMF1OeykszuG5e1mMw-1
X-Mimecast-MFC-AGG-ID: uKRNHMF1OeykszuG5e1mMw_1741700661
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-308fefb2bd0so24731751fa.1
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 06:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741700660; x=1742305460;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDvh640mXUQQF6buBwSlPYU4wimDdWWpP0QsQuvfiII=;
        b=ZfabmE8eXtEamJrEqdHo33L0tTTD22n9v++NY9HTdXXxlY7aphjEM47TeGlISGDkIJ
         5SYmG67hcV9JM7smiVwhmuYKcTA9ZaOHnlQU0s3GyoSeZCHrkPH2mTR+c3yYKFqsLOYy
         mfWkJ0eN7aJTfY/pDA6kgFdc6lf4gndfMD3uq9w+MkrGyNC7KL381H2YtDgNUZZV8kC1
         XoTXUCn1CyqYUZ6s0F5Vk66Uxwlfg7ZLcWE6KA8WKlME6HYwXrt0Lt0NGYlvvu0QiGBS
         klft+mZ75WfZjqQeL2dYCmdGzzURzVRiw2XXSUcQ3D+cMQc1+kFeoFztXchZRFJs9STr
         ULhQ==
X-Forwarded-Encrypted: i=1; AJvYcCX129bWyLHWi2xgM8xmTPnKtdQhmh4nycZpq2hwO/2cxFLIdwJdwTn1VgFS1v5kAebm7sONlRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7gECJgMB3rmf1fOKOrIJwoVvqz97XnVqWUPxWGwcEv1mLJWIm
	Po1JqSudMHV11X4ny5Zow3JDsnE8ESftc35QaPLX+uCHb7rmvtJOGUyUjY9FWTnIrYmuKI9sx+f
	u+skUmeecVVIpoZ64ie3Hrg3Wr09iVsyWaV1FNyK9O03OZWSu0KpzSA==
X-Gm-Gg: ASbGncs3PDBN9FCmgF4GQloxTkkUHkSWFlTxamO5mFPYxO9dc0hQJlDL6s919ei4IMO
	C9eeqpBGt0EYpGOwBSEYnSvscmocg0to3bxQNk2/Wrutyv9auhVmJFUdvtKu+PrKhD4YOQHr9s8
	nA8+kgMjgfC0izqQ59rpNZ8OVqbM3G6pcGjLJ/LGgAqfVBUUABukRhGUY+JsJeRG/IcVs4lpfqR
	9W6oue1IDGMh1tYiGX3gnt/4Ivnx2MHpssnkZFgzKx3Ih7fDENQjdmhp8dcav8jLqvelu9X4ILS
	OezDZvkIKTmJ
X-Received: by 2002:a2e:b8d2:0:b0:308:eb58:6580 with SMTP id 38308e7fff4ca-30bf46387a6mr58649101fa.33.1741700660354;
        Tue, 11 Mar 2025 06:44:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1tGX9fEpRk8FaOlpVoYgpzUcN+2qhGPldpH8b1ULOUF6Trv2KpWAfRh7Mt31RQi4bHuMV0w==
X-Received: by 2002:a2e:b8d2:0:b0:308:eb58:6580 with SMTP id 38308e7fff4ca-30bf46387a6mr58648961fa.33.1741700659848;
        Tue, 11 Mar 2025 06:44:19 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30bfd2737a6sm14329771fa.103.2025.03.11.06.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 06:44:18 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9882818FA5AA; Tue, 11 Mar 2025 14:44:15 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>, Mina Almasry
 <almasrymina@google.com>, David Wei <dw@davidwei.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David
 S. Miller" <davem@davemloft.net>, Yunsheng Lin <linyunsheng@huawei.com>,
 Yonglong Liu <liuyonglong@huawei.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, linux-mm@kvack.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <edc407d1-bd76-4c6b-a2b1-0f1313ca3be7@gmail.com>
References: <20250308145500.14046-1-toke@redhat.com>
 <CAHS8izPLDaF8tdDrXgUp4zLCQ4M+3rz-ncpi8ACxtcAbCNSGrg@mail.gmail.com>
 <87cyeqml3d.fsf@toke.dk> <edc407d1-bd76-4c6b-a2b1-0f1313ca3be7@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 11 Mar 2025 14:44:15 +0100
Message-ID: <87tt7ziswg.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pavel Begunkov <asml.silence@gmail.com> writes:

> On 3/9/25 12:42, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Mina Almasry <almasrymina@google.com> writes:
>>=20
>>> On Sat, Mar 8, 2025 at 6:55=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen=
 <toke@redhat.com> wrote:
>>>>
>>>> When enabling DMA mapping in page_pool, pages are kept DMA mapped until
>>>> they are released from the pool, to avoid the overhead of re-mapping t=
he
>>>> pages every time they are used. This causes problems when a device is
>>>> torn down, because the page pool can't unmap the pages until they are
>>>> returned to the pool. This causes resource leaks and/or crashes when
>>>> there are pages still outstanding while the device is torn down, becau=
se
>>>> page_pool will attempt an unmap of a non-existent DMA device on the
>>>> subsequent page return.
>>>>
>>>> To fix this, implement a simple tracking of outstanding dma-mapped pag=
es
>>>> in page pool using an xarray. This was first suggested by Mina[0], and
>>>> turns out to be fairly straight forward: We simply store pointers to
>>>> pages directly in the xarray with xa_alloc() when they are first DMA
>>>> mapped, and remove them from the array on unmap. Then, when a page pool
>>>> is torn down, it can simply walk the xarray and unmap all pages still
>>>> present there before returning, which also allows us to get rid of the
>>>> get/put_device() calls in page_pool.
>>>
>>> THANK YOU!! I had been looking at the other proposals to fix this here
>>> and there and I had similar feelings to you. They add lots of code
>>> changes and the code changes themselves were hard for me to
>>> understand. I hope we can make this simpler approach work.
>>=20
>> You're welcome :)
>> And yeah, me too!
>>=20
>>>> Using xa_cmpxchg(), no additional
>>>> synchronisation is needed, as a page will only ever be unmapped once.
>>>>
>>>
>>> Very clever. I had been wondering how to handle the concurrency. I
>>> also think this works.
>>=20
>> Thanks!
>>=20
>>>> To avoid having to walk the entire xarray on unmap to find the page
>>>> reference, we stash the ID assigned by xa_alloc() into the page
>>>> structure itself, in the field previously called '_pp_mapping_pad' in
>>>> the page_pool struct inside struct page. This field overlaps with the
>>>> page->mapping pointer, which may turn out to be problematic, so an
>>>> alternative is probably needed. Sticking the ID into some of the upper
>>>> bits of page->pp_magic may work as an alternative, but that requires
>>>> further investigation. Using the 'mapping' field works well enough as
>>>> a demonstration for this RFC, though.
>>>>
>>>
>>> I'm unsure about this. I think page->mapping may be used when we map
>>> the page to the userspace in TCP zerocopy, but I'm really not sure.
>>> Yes, finding somewhere else to put the id would be ideal. Do we really
>>> need a full unsigned long for the pp_magic?
>>=20
>> No, pp_magic was also my backup plan (see the other thread). Tried
>> actually doing that now, and while there's a bit of complication due to
>> the varying definitions of POISON_POINTER_DELTA across architectures,
>> but it seems that this can be defined at compile time. I'll send a v2
>> RFC with this change.
>
> FWIW, personally I like this one much more than an extra indirection
> to pp.
>
> If we're out of space in the page, why can't we use struct page *
> as indices into the xarray? Ala
>
> struct page *p =3D ...;
> xa_store(xarray, index=3D(unsigned long)p, p);
>
> Indices wouldn't be nicely packed, but it's still a map. Is there
> a problem with that I didn't consider?

Huh. As I just replied to Yunsheng, I was under the impression that this
was not supported. But since you're now the second person to suggest
this, I looked again, and it looks like I was wrong. There does indeed
seem to be other places in the kernel that does this.

As you say the indices won't be as densely packed, though. So I'm
wondering if using the bits in pp_magic would be better in any case to
get the better packing? I guess we can try benchmarking both approaches
and see if there's a measurable difference.

-Toke


