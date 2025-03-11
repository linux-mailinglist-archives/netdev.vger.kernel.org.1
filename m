Return-Path: <netdev+bounces-173955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8952FA5C8C3
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 16:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 255AC1881E4A
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DC01E1A32;
	Tue, 11 Mar 2025 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7pc926f"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB78F23C9
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708122; cv=none; b=ZTsLO8IEtgDPhuMQWL9fWgCY1Va2kVOnCm4cFOxf2zcLNruNFiR6akBoTXXo6Tj3eTcozDsJqzyBNcEObpChYv2UxJILInXKREuGtZAxKucQFtq2Gx8UJYGCm3YwEy15k4z4C8QUy1cYbWRqjs75qEM5wVeOQ5E0iFHy/HkMlX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708122; c=relaxed/simple;
	bh=TI3zCJ9NRFviJcoIbIJXFFpl1vVQozYvxr0hiItBHWg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AY7RJL43+aOgTovc1IXi43v3S4R1iJ2zvHFpzqW9UsYvfD1EBBX6X0ObIzISGHih5BubAe7I/Zi8r4ZZGNTLZD/fo6tpoUS14fES0/zzaAWJ9D/JL9/fuUfRrJs0TW2dJQlRdxzq8wPYo2s/g743itQqM0LCWx9UIKWbp9vauek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z7pc926f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741708119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TI3zCJ9NRFviJcoIbIJXFFpl1vVQozYvxr0hiItBHWg=;
	b=Z7pc926fBtnlA1n+iHoTjW5I+9xy6dgkn9WmmHz0PIOaxBvgl2chjPNsbNx5an7+duUgE7
	B8VsCSjrkOHrhHRwFJMk9TAKEceWoC3G6O9s5Aw7aT/gHT8ozw+VVCsc1Edo28mVxHin7P
	N+rsjNLOzgsPkjjXIpO9DJfL1r+JUWw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-hAtJV632NqijE2rYk9HE_g-1; Tue, 11 Mar 2025 11:48:38 -0400
X-MC-Unique: hAtJV632NqijE2rYk9HE_g-1
X-Mimecast-MFC-AGG-ID: hAtJV632NqijE2rYk9HE_g_1741708117
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac297c79dabso245657766b.0
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 08:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741708117; x=1742312917;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TI3zCJ9NRFviJcoIbIJXFFpl1vVQozYvxr0hiItBHWg=;
        b=FLnQ1YCgEVOX2wvuAXgXqMho+IpykqVQwWDAsXHL9CRbFwkiFyxHkti+pivoOMIiYx
         3ZZj3xEDT1ryFt+DEnkYKlBkzUp4rk+JgCmzgIXPujPK4AG/B/D4TaDEx22GMk4L7+UR
         EUMm9q+XD7yTbZ8CAYHTGUwpcbmx8r1p7mf+gmhIfWU3CfM6HOE3vZjW1nay1R1XGxKr
         9uGGpn0I4YCb7+4iKD8nUAA/5o69JcDhl4fkBCTpwO7Q2q4oPWGfQfmSbLv/O+OW/z6T
         qCdGZ+ujOR2yYsMz6KYaPv0Cs9zWwISsxxTL7a6q6zeH/6Aiz4lCoBnKiuY5PxYpS2mP
         rYfg==
X-Forwarded-Encrypted: i=1; AJvYcCXKCMvMZ9SunUwX272n9ZRgIaIsYm38oQ23fzKTKH8+PY4PUXmvRQPuJ0m4K7dU69MHTtrI7vY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4UM0Y+H7G08T56Fbntfbjc5E9YDBybUTwPfT9SKK2T/YQnniL
	XxgVyq4kMVOjZpaeruHxnI73FRlZheENV4gTHqOatvsi9/QkWtmY9k8N/q38RkTgL0B2hWmI68A
	2PViQvsb0YMVAIj947O6iswTN7KFShtA+IgFAVhOF2lSbfMf8dedFIQ==
X-Gm-Gg: ASbGnctO5NZYeh0dQecKMx9I9xFu155MS5LxzXOg7KM/U04nob3M8YKIucSdUqao94O
	0Cwi6ueuRB2gdaxs0CmNZvuFkqzHJiJwyAbZ+4Hhj8dj0Eq6uQ8LqLZcMt5Xm7KHWfONtCSjkXU
	xMybhY7ESlIWN89noWyzLax/ir+Ub5vCw+wbp7Z1g8gzfMUvt6ZZGcFVRKXXAvIrA/DNM9lmAJ1
	VTg32Bxb+hc2ai2/xIdMVdvp502XFQFHZQBV34qiv/OvoI+ctTNpaKW4XPE00bVzj1zPnKJqB6L
	v/RP4OHKZItGqwrkgdWGQVrBLw9vQyV8dgvfpW0Z
X-Received: by 2002:a17:907:9691:b0:ac2:166f:42eb with SMTP id a640c23a62f3a-ac25259836dmr2319326466b.2.1741708117201;
        Tue, 11 Mar 2025 08:48:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHs46zu0NfmV4YgBYokcezaQrfRf8yzsXDxqxrzuVomrpkzeJiCbp8qTIOtJWLPLilraSMmoQ==
X-Received: by 2002:a17:907:9691:b0:ac2:166f:42eb with SMTP id a640c23a62f3a-ac25259836dmr2319321266b.2.1741708116787;
        Tue, 11 Mar 2025 08:48:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac29363d604sm430663766b.76.2025.03.11.08.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 08:48:36 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 238AD18FA5DF; Tue, 11 Mar 2025 16:48:35 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Yunsheng Lin
 <linyunsheng@huawei.com>, Yonglong Liu <liuyonglong@huawei.com>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH net-next v2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <CAHS8izNY73aJ+_JHX0mWWG-ZFfgUvAeYxjQTN2fCyx-3ynD5Hw@mail.gmail.com>
References: <20250309124719.21285-1-toke@redhat.com>
 <CAHS8izNY73aJ+_JHX0mWWG-ZFfgUvAeYxjQTN2fCyx-3ynD5Hw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 11 Mar 2025 16:48:35 +0100
Message-ID: <87ikofin58.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mina Almasry <almasrymina@google.com> writes:

> On Sun, Mar 9, 2025 at 5:50=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
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
>> get/put_device() calls in page_pool. Using xa_cmpxchg(), no additional
>> synchronisation is needed, as a page will only ever be unmapped once.
>>
>> To avoid having to walk the entire xarray on unmap to find the page
>> reference, we stash the ID assigned by xa_alloc() into the page
>> structure itself, using the upper bits of the pp_magic field. This
>> requires a couple of defines to avoid conflicting with the
>> POINTER_POISON_DELTA define, but this is all evaluated at compile-time,
>> so should not affect run-time performance.
>>
>> Since all the tracking is performed on DMA map/unmap, no additional code
>> is needed in the fast path, meaning the performance overhead of this
>> tracking is negligible. The extra memory needed to track the pages is
>> neatly encapsulated inside xarray, which uses the 'struct xa_node'
>> structure to track items. This structure is 576 bytes long, with slots
>> for 64 items, meaning that a full node occurs only 9 bytes of overhead
>> per slot it tracks (in practice, it probably won't be this efficient,
>> but in any case it should be an acceptable overhead).
>>
>> [0] https://lore.kernel.org/all/CAHS8izPg7B5DwKfSuzz-iOop_YRbk3Sd6Y4rX7K=
BG9DcVJcyWg@mail.gmail.com/
>>
>> Fixes: ff7d6b27f894 ("page_pool: refurbish version of page_pool code")
>> Reported-by: Yonglong Liu <liuyonglong@huawei.com>
>> Suggested-by: Mina Almasry <almasrymina@google.com>
>> Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> Tested-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> I only have nits and suggestions for improvement. With and without those:
>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Thanks! Fixed your nits and a couple of others and pushed here:

https://git.kernel.org/toke/c/df6248a71f85

I'll subject it to some testing and submit a non-RFC version once I've
verified that it works and doesn't introduce any new problems :)

-Toke


