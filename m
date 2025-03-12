Return-Path: <netdev+bounces-174182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBAFA5DC8D
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 13:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C1A83A718D
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 12:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F715241C89;
	Wed, 12 Mar 2025 12:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqcjnhwu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F89224241
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 12:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741782445; cv=none; b=mOOCb5rI0KXYea5SpthFfoiORXaYx9/m/pZnCQs3BGNeqJ/cj8/sF0p/FFmV+umUZ0BYKuu5naWp3FCOKrgVcLUTqEFpQDj7sx6ZUMGgFf5iA23Jo/tpEJ5BhppZTnpdQlk3UlVegOlZQ7IoMAFLAD77LjbqC1VKvCe3FhRR9c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741782445; c=relaxed/simple;
	bh=3wRnOa+u5sRbwZ9+eMAIK9ISj9z0+KJn8ao3601bMZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fI3FzzJRTSsMKrVwtVNtbpcoUzf9m4i3GW36pJ5Nwx4g6xgxVxbuKYUwiRsZNJxURgD38nn/NM5L2J7KhFwD/2hTYjt2GJ2qyA23CYcq+qRo7f7c5Jvyzd4NRBBYX0GAzU7QYEOp/GgzRzplDRmFRt6tlcP4wmmTFX92QOkeEHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cqcjnhwu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741782442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3wRnOa+u5sRbwZ9+eMAIK9ISj9z0+KJn8ao3601bMZ0=;
	b=cqcjnhwuHN/Tci23oz9jjqHJDA08/YDnFUpwMaD/ehZzccBu87rUz5JY6sPxPRqbmEoDjQ
	JC0r6TtGTFsCwat9u8tx+fizu1TJmc0hg5T1SQSgvPa2xBAjm1MmRnJKhFdkuaflAkyxlB
	daeXd9wn9BfImherCkkhKFrTOSlhhco=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-lhJSmFKzNea8d9jmnrco0Q-1; Wed, 12 Mar 2025 08:27:21 -0400
X-MC-Unique: lhJSmFKzNea8d9jmnrco0Q-1
X-Mimecast-MFC-AGG-ID: lhJSmFKzNea8d9jmnrco0Q_1741782440
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5e5dd82d541so6186320a12.2
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 05:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741782440; x=1742387240;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wRnOa+u5sRbwZ9+eMAIK9ISj9z0+KJn8ao3601bMZ0=;
        b=X75DMjjo+loK/dJc0Kqn9pMfZcpGd3aToRdcoUG/fuYkGZ9fmkbCxusovDkMXBo1AK
         EBegKwYWCuE6pT4+/9obNzAZVEtZKCVUSEurWffWr6GDROQHb1UMA8byL1VRh1YFscoQ
         zxv++iT6sCDVRct51brazZ4NThSiVPUccjH339zklPD+65A4OC8Z9LZITCWKYJGuAdj8
         02P5iJAAbR3oc/8g0UkK/b6fSYoMTKABN9gNRAGnRUyn0OObD6lMEoX7TH4dekBO96SC
         438CvHzOLhwt0TEqPvgUQRkpf3riJfFJ0TzqTlnttZ7ElduVROA7avwNN6Hs9TSoyZXs
         BKyw==
X-Forwarded-Encrypted: i=1; AJvYcCXBHpbkStsFiEWcLrpIYOtGDTfPSuyQLG5QukGk5uuy4vlg6CilmphG9COkHC+Avy1BPdjfoZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCG4fVrf9RP1OOg02kTjEgqFORamJcAJirMWSHc2uwbvb+7vv3
	iJFoZie8P7SVx9zySiiBAW3426+G3RNoU436N3h/fNbkd1nH8I9lUuobB0UhgPNf32aNzMDGNGS
	226NAkbdJSeiwaZ6PB08b8A0JG9D3mzBKn9uEQTges1Alr/FEUMnKpA==
X-Gm-Gg: ASbGncsQqE4tuO1Q+RuRDag2w4AiczVd5aBGG4h5a9RboR3UVxr/UPQ3ntGCDi5dDzK
	WtrsVJcuIG34/PGKpeaVNT0l7QekquNjn6NPKOCzbuzubEbrgTv789XnyIZdg0ERVWT45lxb6z2
	w5ZALN/4aS8pp68cCUmCERZAdXh5NyFqd5Tm67Ah1qlIud1iAVSxey9eRVOIY/4smSTdPDQnIuQ
	CDkqUc9KwxnK2i6GVRKpuly/OU2qud6Ou82ZWTlu+HZGdy5ctDgooFSOBJL11wKMTgChQeNFDZq
	3fGXsL3xsKWD
X-Received: by 2002:a05:6402:43cd:b0:5e0:4276:c39e with SMTP id 4fb4d7f45d1cf-5e5e251190cmr29052229a12.30.1741782436484;
        Wed, 12 Mar 2025 05:27:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVG8B9kssrNX/dypmUvhA8C/yTo7s4UTkpGrLBmy1jM7OUguW6oG4MjZt+HeexMG1YDArA4A==
X-Received: by 2002:a05:6402:43cd:b0:5e0:4276:c39e with SMTP id 4fb4d7f45d1cf-5e5e251190cmr29052168a12.30.1741782435950;
        Wed, 12 Mar 2025 05:27:15 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c74721c3sm9767369a12.22.2025.03.12.05.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:27:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 314FD18FA68A; Wed, 12 Mar 2025 13:27:14 +0100 (CET)
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
In-Reply-To: <ae07144c-9295-4c9d-a400-153bb689fe9e@huawei.com>
References: <20250308145500.14046-1-toke@redhat.com>
 <d84e19c9-be0c-4d23-908b-f5e5ab6f3f3f@gmail.com> <87cyepxn7n.fsf@toke.dk>
 <2c363f6a-f9e4-4dd2-941d-db446c501885@huawei.com> <875xkgykmi.fsf@toke.dk>
 <136f1d94-2cdd-43f6-a195-b87c55df2110@huawei.com> <87wmcvitq8.fsf@toke.dk>
 <ae07144c-9295-4c9d-a400-153bb689fe9e@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 12 Mar 2025 13:27:14 +0100
Message-ID: <871pv2igd9.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yunsheng Lin <linyunsheng@huawei.com> writes:

> On 2025/3/11 21:26, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Yunsheng Lin <linyunsheng@huawei.com> writes:
>>=20
>>> On 2025/3/10 23:24, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>
>>>>>
>>>>> I guess that is one of the disadvantages that an advanced struct like
>>>>> Xarray is used:(
>>>>
>>>> Sure, there will be some overhead from using xarray, but I think the
>>>> simplicity makes up for it; especially since we can limit this to the
>>>
>>> As my understanding, it is more complicated, it is just that
>>> complexity is hidden before xarray now.
>>=20
>> Yes, which encapsulates the complexity into a shared abstraction that is
>> widely used in the kernel, so it does not add new complexity to the
>> kernel as a whole. Whereas your series adds a whole bunch of new
>> complexity to the kernel in the form of a new slab allocator.
>>=20
>>> Even if there is no space in 'struct page' to store the id, the
>>> 'struct page' pointer itself can be used as id if the xarray can
>>> use pointer as id. But it might mean the memory utilization might
>>> not be as efficient as it should be, and performance hurts too if
>>> there is more memory to be allocated and freed.
>>=20
>> I don't think it can. But sure, there can be other ways around this.
>>=20
>> FWIW, I don't think your idea of allocating page_pool_items to use as an
>> indirection is totally crazy, but all the complexity around it (the
>> custom slab allocator etc) is way too much. And if we can avoid the item
>> indirection that is obviously better.
>>=20
>>> It seems it is just a matter of choices between using tailor-made
>>> page_pool specific optimization and using some generic advanced
>>> struct like xarray.
>>=20
>> Yup, basically.
>>=20
>>> I chose the tailor-made one because it ensure least overhead as
>>> much as possibe from performance and memory utilization perspective,
>>> for example, the 'single producer, multiple consumer' guarantee
>>> offered by NAPI context can avoid some lock and atomic operation.
>>=20
>> Right, and my main point is that the complexity of this is not worth it =
:)
>
> Without the complexity, there is about 400ns performance overhead
> for Xarray compared to about 10ns performance overhead for the
> tailor-made one, which means there is about more than 200% performance
> degradation for page_pool03_slow test case:

Great, thanks for testing! I will include this in the non-RFC posting of
this series :)

>>>> cases where it's absolutely needed.
>>>
>>> The above can also be done for using page_pool_item too as the
>>> lower 2 bits can be used to indicate the pointer in 'struct page'
>>> is 'page_pool_item' or 'page_pool', I just don't think it is
>>> necessary yet as it might add more checking in the fast path.
>>=20
>> Yup, did think about using the lower bits to distinguish if it does turn
>> out that we can't avoid an indirection. See above; it's not actually the
>
> The 'memdesc' seems like an indirection to me when using that to shrink
> 'struct page' to a smaller size.

Yes, it does seem like we'll end up with an indirection of some kind
eventually. But let's cross that bridge when we get to it...

-Toke


