Return-Path: <netdev+bounces-179602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF0DA7DCD9
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 13:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6CA41888622
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 11:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AEF253B40;
	Mon,  7 Apr 2025 11:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IP/PNmva"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D8E24501E
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 11:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744026547; cv=none; b=RlQiTW3Z0cswbucaNT0nR+b5AO/ROp4dTARgf+LvskXRFi0MuSo42rOR7mIH+kRXf58F92DSnsxWD6dldyGSnyS/pnAIdVAfpt5yOkez0MyeAbYL56ySgUk5Rh6W9Fyao67mdoWtrmip0TaT1zsRWFsCqg8JfPP2puw5ODRaVSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744026547; c=relaxed/simple;
	bh=wgVJYy1rEwB53P9pbmWyY7fpKJ+zxw00/Y9QE8ZKGd8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FSV8B7Y/xkc58IuvuzHFKWncPKziNX/LCROfh7mCvfOJxDPxzfyVHIOmi3LOVKqJ8dgG7U6ROtcIsDHLLC0PEhpoZCD45732AUl1LXYxtbjEGmRs2/rQmC5bAlrKplUNWMBoshD3yT1RtPGnVcFwEtw+/DuVYw4Q5aPKnrDt3+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IP/PNmva; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744026544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TLDIfHFc0cnuUtNn3wFV1KRo7sfcAABFYKPb/EFAlBY=;
	b=IP/PNmvaqx/mw6kEleDTTBNxh16C8fMpVDEUVst1v7yQi+R+uAEmimmCG3KwkVwKGEJqo/
	crCiXboenx3Rk+eiuYv8rtTg8p3n2jORUp0OuC+MnhlEOuFm0SioNbU6KdgfN5CqXKlS+/
	L7nq6kd+wl8pHSE2DRnaDN6luGgpU3M=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-LHhlMwfLMeGok8EQeCXBkA-1; Mon, 07 Apr 2025 07:49:03 -0400
X-MC-Unique: LHhlMwfLMeGok8EQeCXBkA-1
X-Mimecast-MFC-AGG-ID: LHhlMwfLMeGok8EQeCXBkA_1744026542
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-30be985454aso20640161fa.2
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 04:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744026542; x=1744631342;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLDIfHFc0cnuUtNn3wFV1KRo7sfcAABFYKPb/EFAlBY=;
        b=CJAKoOZGolmCHqAMzx325INUFHuv8NgSjvvpwm4ZKor1LZDEC6jrdkgE0wSwhRLIDM
         E40o0Th4CPQT/xATe3tCsS9dYdU7XMvsdjrIPImNk3klS1WA80D10vS3ktUJRjgx4TQ2
         MfilPQ2YacTGrVOrhdgCpTXv+wFv9wR2wl861q3WXFGejYXPQnftOGgBCfPg0s0o1++l
         IBv7tpE7b2GjZKCb97eVrQLFmJZSegpCGlpsTnvmlZCPybEKNCJoAdSbipBAmnvLRiW0
         IBhYK9cv24GkmNnpAZ/l1+wopBYmhMkWVPGG+pyCQTsNFsi08cxJKqGaXOIlbraZcpxg
         t81A==
X-Forwarded-Encrypted: i=1; AJvYcCXEjF4CKhotbFlwrgoKIIurNQupoI8Ws43EUrnWxFSbk7vS1ZsDaT4y4hR9t6XLpQ6NVWWK4Fw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ5pZfHb3qQkSc97gJPn4sbJGZKmbW66IyGfJs7VUgLaQmbzyU
	IOaAlcME7U9qR+KdMgi69rz507ae1VkyXrOIGwXhE/nWHfYFwPDpVLY34RHycHQhQDOB5FL9C5y
	OkdhZ40DD2Zj6WaCb7868piHlS9EaZf6DHoIgQJ6tnMVOCBGMjDAZkg==
X-Gm-Gg: ASbGncsHFH6nuq1dFag+oHgn3eLcJJ5zdEoO/Z50NNwCFMew6LO3LvKJ/U/Qs/0ClSq
	uIdh7JHV/hGblZ15h17729fCNubDBKKpUwuy9qjQeAf+/CjhpotZHSGveRQdEfFJXt/LqTHovSq
	Ouk8Xwz0idh0yeIdXOuBuaibJFE6m1rOlh/zy3dU6x7+4Jj2KAvI+cOtELS4L5R6agZNgpas0eK
	PuS4Sy7Niqg9R3poBLI9n3PYKY1qsOOF0rrjBaI+KRjb5EpeQSaCB5WpIDTlDXCdqijZprIKeyP
	GhRFMfD1/MCs
X-Received: by 2002:a05:6512:230c:b0:549:38d2:f630 with SMTP id 2adb3069b0e04-54c232e27abmr3822834e87.24.1744026542003;
        Mon, 07 Apr 2025 04:49:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJhH9DwjR+yY0lREbz+MbPKUBDZMsEOgHBc/onNClHx1Rv9EuZnA4xWzVH0KsBqxu+8cjt9A==
X-Received: by 2002:a05:6512:230c:b0:549:38d2:f630 with SMTP id 2adb3069b0e04-54c232e27abmr3822825e87.24.1744026541557;
        Mon, 07 Apr 2025 04:49:01 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e672c38sm1216538e87.254.2025.04.07.04.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 04:49:00 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0B7A4199188E; Mon, 07 Apr 2025 13:49:00 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mina Almasry
 <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>, Pavel
 Begunkov <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>, Yuying Ma
 <yuma@redhat.com>
Subject: Re: [PATCH net-next v7 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <f8bbfe7e-9935-4f4d-a9e8-b3547ed58112@huawei.com>
References: <20250404-page-pool-track-dma-v7-0-ad34f069bc18@redhat.com>
 <20250404-page-pool-track-dma-v7-2-ad34f069bc18@redhat.com>
 <3b933890-7ff2-4aaf-aea5-06e5889ca087@intel.com>
 <d7780007-6df7-45f0-9a08-2e6acf589a6f@intel.com> <87jz7yhix3.fsf@toke.dk>
 <f8bbfe7e-9935-4f4d-a9e8-b3547ed58112@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 07 Apr 2025 13:49:00 +0200
Message-ID: <871pu4xkcz.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yunsheng Lin <linyunsheng@huawei.com> writes:

> On 2025/4/5 20:50, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Alexander Lobakin <aleksander.lobakin@intel.com> writes:
>>=20
>>> From: Alexander Lobakin <aleksander.lobakin@intel.com>
>>> Date: Fri, 4 Apr 2025 17:55:43 +0200
>>>
>>>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>>> Date: Fri, 04 Apr 2025 12:18:36 +0200
>>>>
>>>>> When enabling DMA mapping in page_pool, pages are kept DMA mapped unt=
il
>>>>> they are released from the pool, to avoid the overhead of re-mapping =
the
>>>>> pages every time they are used. This causes resource leaks and/or
>>>>> crashes when there are pages still outstanding while the device is to=
rn
>>>>> down, because page_pool will attempt an unmap through a non-existent =
DMA
>>>>> device on the subsequent page return.
>>>>
>>>> [...]
>>>>
>>>>> -#define PP_MAGIC_MASK ~0x3UL
>>>>> +#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>>>>>=20=20
>>>>>  /**
>>>>>   * struct page_pool_params - page pool parameters
>>>>> @@ -173,10 +212,10 @@ struct page_pool {
>>>>>  	int cpuid;
>>>>>  	u32 pages_state_hold_cnt;
>>>>>=20=20
>>>>> -	bool has_init_callback:1;	/* slow::init_callback is set */
>>>>> +	bool dma_sync;			/* Perform DMA sync for device */
>>>>
>>>> Yunsheng said this change to a full bool is redundant in the v6 thread
>>>> =C2=AF\_(=E3=83=84)_/=C2=AF
>>=20
>> AFAIU, the comment was that the second READ_ONCE() when reading the
>> field was redundant, because of the rcu_read_lock(). Which may be the
>> case, but I think keeping it makes the intent of the code clearer. And
>> in any case, it has nothing to do with changing the type of the field...
>
> For changing the type of the field part, there are only two outcomes here
> when using bit field here:
> 1. The reading returns a correct value.
> 2. The reading returns a incorrect value.
>
> So the question seems to be what would possibly go wrong when the reading
> return an incorrect value when there is an additional reading under the r=
cu
> read lock and there is a rcu sync after clearing pool->dma_sync? Consider=
ing
> we only need to ensure there is no dma sync API called after rcu sync.

Okay, so your argument is basically that the barrier in rcu_read_lock()
should prevent the compiler from coalescing the two reads of the
pp->dma_sync field in page_pool_dma_sync_for_device()? And that
READ/WRITE_ONCE() are not needed for the same reason?

> And it seems data_race() can be used to mark the above reading so that KC=
SAN
> will not complain.

Where would you suggest to add those? Not sure such annotations would
improve readability relative to the current use of READ/WRITE_ONCE()?
The latter is more clear in communicating intent, I would say...

> IOW, changing the type of the field part isn't that necessary as my
> understanding.

Since changing the field doesn't change the size of the structure, I
would be inclined to keep the change for readability reasons, cf the
above.

-Toke


