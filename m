Return-Path: <netdev+bounces-173272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B188A5841C
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 13:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610F53AE5EE
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 12:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CD71D61B7;
	Sun,  9 Mar 2025 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aeNf6moa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BF81C9B62
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741524160; cv=none; b=FRYLTMlxH4B8WZ136fuw0V7P+vXg2UXlrASXBx4hk9goN7VcZqulWCrMHOsrDdGUAJZ4AbsjYziwhuJBpvnErSHu7223A/lc8XURU5XDk8jAuGqgBUICBeLnd2zQKldW2eeg+M9umqqWXrdL4qbb/U6p65sgyUvfZXY+Og27AWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741524160; c=relaxed/simple;
	bh=wakJHmryr/W0Yg7ZPLkHn/l/K42kHDSBHjc6PXqPPV0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PgViFvvdth/PJwaUbgQTKMK9k42JvxezJbsBIG9QHUsE/Ij3MhTmo8hXcai39cuMRlPqafvwrKbkED+GE2C86oZMUJejg8dxvKsX3TQRUneZ5ezVYIjzYeo6IjWaxgEdyVjrQBqNRUsdYARotXrXxnZsNafwt/iJd0hG6CEWmLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aeNf6moa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741524156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wakJHmryr/W0Yg7ZPLkHn/l/K42kHDSBHjc6PXqPPV0=;
	b=aeNf6moa/MI+MrT4GZ1YO1deYuJ/uYf5oQTGqWt7IBSgO4f37yQlpmfXrgF6QT69XwV6xR
	WNL7bQVhCVFB94Ib/0mrTS3OWf5KKTNHkkoEq8n2Aj5fwlCrtUwMol2BneGqpgAe6T2C98
	PiFNrgTwsxt7pLdjzai41DnWWjJAh2c=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-BGpKTC0RMWufIKjjy-PDYw-1; Sun, 09 Mar 2025 08:42:34 -0400
X-MC-Unique: BGpKTC0RMWufIKjjy-PDYw-1
X-Mimecast-MFC-AGG-ID: BGpKTC0RMWufIKjjy-PDYw_1741524153
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5499c383444so361400e87.2
        for <netdev@vger.kernel.org>; Sun, 09 Mar 2025 05:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741524153; x=1742128953;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wakJHmryr/W0Yg7ZPLkHn/l/K42kHDSBHjc6PXqPPV0=;
        b=LW6Ci2xUU1VzOPwlhyaOEQRntQ8iFsL1Iu7R3DIo8hGTm1F2i5GJfX3Z4tIR2SyqKM
         xSqzmLaJEcGR3PBsGShYu8TXlEVBiTwXIsIg0+tnaz0JxUGgNc0aOdwXHZaRwb4hHWf2
         ypSYR7Ndrfh2L9U+00V27h94na3t6bkBaKlBfoh2+IVCe3HuSE5wzTttYb6d8M4nlkIO
         AJdEiPR+AIFaD6lhiB2EtlGBkDxS6m52nTkGEiJ8Ciu8NFmUPRMfJ+5L5sl4ULkUvuld
         y33WIkWoqdz0q9qLZMmJxX8Yd3J35sCkoFbgwXZf2nXxDtnb4rKstUCtzZ1g2SkIME9O
         f6nw==
X-Forwarded-Encrypted: i=1; AJvYcCVvDWlEMqffb3hzzgOBs8WM7lxJ9pSUv5ZEv9/YpBY+K3AjosyOLczc0DnxmEx4KGF9ISPOjg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztp2GbiC6uwm4q7VlO0lSgmDTmjgfg3gk6e8/1oKEKTmpW8//y
	KqsPm4jQJngJYeeib3MftVmRHlU2dNNwQ+si5hzXz3VBsTne5Giv7VxFLmSwg8UYZA4dAO/lemy
	utDVRZ2paI5DnHIDRTHAMZgkL/X/L5O4dkcYOihjszZ+R1HOaqwGK1A==
X-Gm-Gg: ASbGncsrFrZ15y+aaJVXYc5+2sF7hj1pP5n/f7pI1GG/NfksPE31/rr7eZEqzhMEokJ
	uxEPcQ4GdC2wyR6vWV4ryn4mYRQsy2QGdLSQihpPv/HWvFwiBpesrc4e4GeE02Vtl1EPPPlaVMo
	sj59WxTIHk9S7qNd2H//uPRkZuBAikNFJ4b/MlOo3PttH5o6IXFEBDndeTczgFwIsK3O57HV5df
	Z37xcL0m1A+gZde2ccY31z7TUBli00iWrq9XDGbaLRm+QHDnplpUuu4EnxaPM+RxVxbM/XSUxah
	dMtRMhYMcohyyUOjygYRqMwSHK1YdORnwKQucIsO
X-Received: by 2002:a05:6512:1598:b0:549:8d67:c48e with SMTP id 2adb3069b0e04-54990e673a2mr2988049e87.29.1741524153257;
        Sun, 09 Mar 2025 05:42:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmmLLcrdnS8oM64WmWKJSQFGa8sEv7PMWa8+/+Bd/zZCIJEK6j2YUdeN/6EfK00WFIH8P5Pg==
X-Received: by 2002:a05:6512:1598:b0:549:8d67:c48e with SMTP id 2adb3069b0e04-54990e673a2mr2988041e87.29.1741524152845;
        Sun, 09 Mar 2025 05:42:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae58c0csm1103754e87.59.2025.03.09.05.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 05:42:32 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 53DF818FA18C; Sun, 09 Mar 2025 13:42:30 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Mina Almasry <almasrymina@google.com>, Pavel Begunkov
 <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David
 S. Miller" <davem@davemloft.net>, Yunsheng Lin <linyunsheng@huawei.com>,
 Yonglong Liu <liuyonglong@huawei.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, linux-mm@kvack.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <CAHS8izPLDaF8tdDrXgUp4zLCQ4M+3rz-ncpi8ACxtcAbCNSGrg@mail.gmail.com>
References: <20250308145500.14046-1-toke@redhat.com>
 <CAHS8izPLDaF8tdDrXgUp4zLCQ4M+3rz-ncpi8ACxtcAbCNSGrg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Sun, 09 Mar 2025 13:42:30 +0100
Message-ID: <87cyeqml3d.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mina Almasry <almasrymina@google.com> writes:

> On Sat, Mar 8, 2025 at 6:55=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
>>
>> When enabling DMA mapping in page_pool, pages are kept DMA mapped until
>> they are released from the pool, to avoid the overhead of re-mapping the
>> pages every time they are used. This causes problems when a device is
>> torn down, because the page pool can't unmap the pages until they are
>> returned to the pool. This causes resource leaks and/or crashes when
>> there are pages still outstanding while the device is torn down, because
>> page_pool will attempt an unmap of a non-existent DMA device on the
>> subsequent page return.
>>
>> To fix this, implement a simple tracking of outstanding dma-mapped pages
>> in page pool using an xarray. This was first suggested by Mina[0], and
>> turns out to be fairly straight forward: We simply store pointers to
>> pages directly in the xarray with xa_alloc() when they are first DMA
>> mapped, and remove them from the array on unmap. Then, when a page pool
>> is torn down, it can simply walk the xarray and unmap all pages still
>> present there before returning, which also allows us to get rid of the
>> get/put_device() calls in page_pool.
>
> THANK YOU!! I had been looking at the other proposals to fix this here
> and there and I had similar feelings to you. They add lots of code
> changes and the code changes themselves were hard for me to
> understand. I hope we can make this simpler approach work.

You're welcome :)
And yeah, me too!

>> Using xa_cmpxchg(), no additional
>> synchronisation is needed, as a page will only ever be unmapped once.
>>
>
> Very clever. I had been wondering how to handle the concurrency. I
> also think this works.

Thanks!

>> To avoid having to walk the entire xarray on unmap to find the page
>> reference, we stash the ID assigned by xa_alloc() into the page
>> structure itself, in the field previously called '_pp_mapping_pad' in
>> the page_pool struct inside struct page. This field overlaps with the
>> page->mapping pointer, which may turn out to be problematic, so an
>> alternative is probably needed. Sticking the ID into some of the upper
>> bits of page->pp_magic may work as an alternative, but that requires
>> further investigation. Using the 'mapping' field works well enough as
>> a demonstration for this RFC, though.
>>
>
> I'm unsure about this. I think page->mapping may be used when we map
> the page to the userspace in TCP zerocopy, but I'm really not sure.
> Yes, finding somewhere else to put the id would be ideal. Do we really
> need a full unsigned long for the pp_magic?

No, pp_magic was also my backup plan (see the other thread). Tried
actually doing that now, and while there's a bit of complication due to
the varying definitions of POISON_POINTER_DELTA across architectures,
but it seems that this can be defined at compile time. I'll send a v2
RFC with this change.

-Toke


