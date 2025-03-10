Return-Path: <netdev+bounces-173575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6604FA599E6
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 16:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5E03A8649
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 15:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC3B22D7AF;
	Mon, 10 Mar 2025 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XOv95vY0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A07822D7A4
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741620254; cv=none; b=jl7o+qkn3DUKXn9w6yq3Erx46pu7Pi4Z45k6ImcKj3ZsZtD8t1nDnSso6e0RUVqwZB54SOkAkXAgN0boKOQhCm7gvwl6OJXRB3XXxPTGzVi5V34jROgnMdYo0diDlFiC1itPJsyJjU7SFdGeHSRjfLJMHwNbylL9zqXb2LRrzkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741620254; c=relaxed/simple;
	bh=RJxEko8UNxJBMkRL2HYUFfM9qx0wl8Ekv2tZGIzjMdw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PKr8FuVO75jbu8yvIQmsRNzQmom7Xp4dgmd83AcxRhuIPKOSEHNtmm8H6eYNi9Dh3bj+UEICkU68zpHiXUwQLqqcmaqQU5W76OJziG0MU3hiPKEyCc2Ohq6mLmJ5DdcH7MH7zY0QEB5nodIuZOYvnZUpjfKpDtmM74tNXc/mGTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XOv95vY0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741620252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gT0ohx+zOS/zPD/WSmJupNwb94kkNT4Ggfrcv3WdyqA=;
	b=XOv95vY0Alv5U+xLan+vj/1htzjcsc1kAXcM9MiN3hSayZpDGc42fIUM9ERj6BYBU+KPO1
	qk+kz+FafTCjtiLPmFgRgZjwyn/nDpboP79SyzGbPsyH+yvoKKpeuvITQCkh79QTgr7+YL
	PBHT3DimxUqyhDAznQCnGONfCo1Dt24=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-IVIeFVsZPJ-sLBx4YYwu2g-1; Mon, 10 Mar 2025 11:24:10 -0400
X-MC-Unique: IVIeFVsZPJ-sLBx4YYwu2g-1
X-Mimecast-MFC-AGG-ID: IVIeFVsZPJ-sLBx4YYwu2g_1741620249
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-30bf6cdaf17so16035191fa.3
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 08:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741620249; x=1742225049;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gT0ohx+zOS/zPD/WSmJupNwb94kkNT4Ggfrcv3WdyqA=;
        b=unBggB5i4nA/uElocWQoX4I/nrHgWGj0jWtJaD/Fi6Hkq9VuoV6udVNVr+/otdYQHA
         8rvJkv7u1ZgnbZTIzH9qT6/XhYKPbByLtlkITAaYwsvREgZNxlzHNolBzowVmlch80FR
         WdNSAiYY0lbYv+/z61fF6qUGaai3wnwNFsK+MLaLF19BRNwPe6niaU7K5DWKFyIh+J0T
         GNQ9UcE1sCfpGF/72/l4olv5DqLVVIpaRRDJtVZppIaWQ1UUkPSVV31j7kj9DlAtGZfa
         vabvs7hHTCMJbfd5zIed9Vr+rO9rT4VtvFtalH6PS9RQ95eqU2q6Fo8xexSoNrP9ZEXe
         UYfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5lMIfC+2UEDp0Pzovve0T3Wx7FM/Xq1kIdSHqqLkBvYHoI3qN5oTjSO/byvGDNSN8rSlI5uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSAs4V8z7A6MsvOEZWSi/CbHrtVQsG1jsZu+b/ayJybbzJb4LW
	UMC2tCXokFZbX0ORibVEcaQAzCK2TGsO4MwQbyLtT6uAT/CJeJIJ02DVt9rpjoq3sNlR5ANpjCu
	Rd85haFBEllzQ3eMMyOIAmhUcOv1UBI5tHRYbYHKPyRSkUZpkXf5DWQ==
X-Gm-Gg: ASbGnctB6ErSR45E3Sf3jbQr9xJQ+FaSwmu7alv2WXeT5hf/MM/584WVczL/su61Wlc
	2GEhv3J9dy9TTl07b5HEiUIoqrM/dSueYcNj/SrVzbPbePf6VgdqQr53I0tZFQRn+gUR9hHDr0E
	HKSa0/xW8Yn8oSjsZlX71VdrSRyQ7KB6QQsdNfSpP2NpZsBxVdLp+IfM/UeaeM7gDw/6sBXgHqg
	TZN00dKM00ezcBKYLqVYI6Y9OT1cezHsOrm6F6ucnqkmxhcSW7ngcfVc1VkGSykARY9IwXGqCXY
	pWk7ViFC7/s1
X-Received: by 2002:a2e:a98c:0:b0:30c:c7a:dcc with SMTP id 38308e7fff4ca-30c0c7a0f93mr19895281fa.20.1741620249232;
        Mon, 10 Mar 2025 08:24:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdwdFCTP2ui6I3zc3cYUYdtUUmj72eqkPsmEzG3D6wTDHgRFDGSXMZVRRdpiJEJUHtv7zqBw==
X-Received: by 2002:a2e:a98c:0:b0:30c:c7a:dcc with SMTP id 38308e7fff4ca-30c0c7a0f93mr19895041fa.20.1741620248525;
        Mon, 10 Mar 2025 08:24:08 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30be98f0187sm16393411fa.43.2025.03.10.08.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:24:08 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 7BC2A18FA322; Mon, 10 Mar 2025 16:24:05 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, Yunsheng Lin
 <yunshenglin0825@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>
Cc: Yonglong Liu <liuyonglong@huawei.com>, Mina Almasry
 <almasrymina@google.com>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, linux-mm@kvack.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <2c363f6a-f9e4-4dd2-941d-db446c501885@huawei.com>
References: <20250308145500.14046-1-toke@redhat.com>
 <d84e19c9-be0c-4d23-908b-f5e5ab6f3f3f@gmail.com> <87cyepxn7n.fsf@toke.dk>
 <2c363f6a-f9e4-4dd2-941d-db446c501885@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 10 Mar 2025 16:24:05 +0100
Message-ID: <875xkgykmi.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yunsheng Lin <linyunsheng@huawei.com> writes:

> On 2025/3/10 17:13, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>
> ...
>
>>=20
>>> Also, we might need a similar locking or synchronisation for the dma
>>> sync API in order to skip the dma sync API when page_pool_destroy() is
>>> called too.
>>=20
>> Good point, but that seems a separate issue? And simpler to solve (just
>
> If I understand the comment from DMA experts correctly, the dma_sync API
> should not be allowed to be called after the dma_unmap API.

Ah, right, I see what you mean; will add a check for this.

>> set pool->dma_sync to false when destroying?).
>
> Without locking or synchronisation, there is some small window between
> pool->dma_sync checking and dma sync API calling, during which the driver
> might have already unbound.
>
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
>>> page->pp_magic seems to only have 16 bits space available at most when
>>> trying to reuse some unused bits in page->pp_magic, as BPF_PTR_POISON
>>> and STACK_DEPOT_POISON seems to already use 16 bits, so:
>>> 1. For 32 bits system, it seems there is only 16 bits left even if the
>>>     ILLEGAL_POINTER_VALUE is defined as 0x0.
>>> 2. For 64 bits system, it seems there is only 12 bits left for powerpc
>>>     as ILLEGAL_POINTER_VALUE is defined as 0x5deadbeef0000000, see
>>>     arch/powerpc/Kconfig.
>>>
>>> So it seems we might need to limit the dma mapping count to 4096 or
>>> 65536?
>>>
>>> And to be honest, I am not sure if those 'unused' 12/16 bits can really=
=20
>>> be reused or not, I guess we might need suggestion from mm and arch
>>> experts here.
>>=20
>> Why do we need to care about BPF_PTR_POISON and STACK_DEPOT_POISON?
>> AFAICT, we only need to make sure we preserve the PP_SIGNATURE value.
>> See v2 of the RFC patch, the bit arithmetic there gives me:
>>=20
>> - 24 bits on 32-bit architectures
>> - 21 bits on PPC64 (because of the definition of ILLEGAL_POINTER_VALUE)
>> - 32 bits on other 64-bit architectures
>>=20
>> Which seems to be plenty?
>
> I am really doubtful it is that simple, but we always can hear from the
> experts if it isn't:)

Do you have any specific reason to think so? :)

>>>> Since all the tracking is performed on DMA map/unmap, no additional co=
de
>>>> is needed in the fast path, meaning the performance overhead of this
>>>> tracking is negligible. The extra memory needed to track the pages is
>>>> neatly encapsulated inside xarray, which uses the 'struct xa_node'
>>>> structure to track items. This structure is 576 bytes long, with slots
>>>> for 64 items, meaning that a full node occurs only 9 bytes of overhead
>>>> per slot it tracks (in practice, it probably won't be this efficient,
>>>> but in any case it should be an acceptable overhead).
>>>
>>> Even if items is stored sequentially in xa_node at first, is it possible
>>> that there may be fragmentation in those xa_node when pages are released
>>> and allocated many times during packet processing? If yes, is there any
>>> fragmentation info about those xa_node?
>>=20
>> Some (that's what I mean with "not as efficient"). AFAICT, xa_array does
>> do some rebalancing of the underlying radix tree, freeing nodes when
>> they are no longer used. However, I am not too familiar with the xarray
>> code, so I don't know exactly how efficient this is in practice.
>
> I guess that is one of the disadvantages that an advanced struct like
> Xarray is used:(

Sure, there will be some overhead from using xarray, but I think the
simplicity makes up for it; especially since we can limit this to the
cases where it's absolutely needed.

-Toke


