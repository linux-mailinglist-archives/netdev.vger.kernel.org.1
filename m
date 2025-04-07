Return-Path: <netdev+bounces-179537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CB6A7D8AE
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 10:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0808817111C
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 08:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB13A22687C;
	Mon,  7 Apr 2025 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ydk0xJHM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD569228CBE
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 08:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744016042; cv=none; b=D/WlP14+RfwJxQ6CR0fRAaJP9X9Q77B0qRLxT8kFgXSz7tymM+AHloyysRAzMZ7u3x3XKzBp3KDMfwkqC7qhucavrtAw3J6i+p3/3OgYQh7jqmQSjQrh98N+w2HPOXeQj5595Xac5TrZk6b5KBx0Iuhb3jEo+SkkCcTkvgeyq60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744016042; c=relaxed/simple;
	bh=pOXia/AC4waKdD2HU2F4EacxLHFYKsgGieOUXINuaVM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PUY6KxpjVNAiAhW1urIbAFPntDSh+TGEZ+7nIrHKXuiS2cBwWtLxsYrS6CKWlJb7UpDPSphpdlEeRXzygYaXvrc5NeJ/CEgsptITSrrKfqLiAbA7agWcIfGty+Bm5wYM35jUH5GZsht7jiFluHWenv/EsEodvQpHkmsJSCR/zD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ydk0xJHM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744016039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WX08fMyjATa1UCoVjYCNjOKyQjVIMz6mY8L2vI8owLs=;
	b=Ydk0xJHMg0RZwxinWe6SOtx1HwpDce3h7bFPAvCWTydUT/eblyMdp9jgdTggLmTjNxfI7/
	3OE78WZyrkrc6WhQrdioasAq0mCrO48tVsjvrHpvlHPmrfHdfSghyNu1oPedE5SLuonrPd
	2NECcBYIrkj0x5ygNx4zFvDyeMGB6Hw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-E6bKEp45P3-Gs4bnnG0mFA-1; Mon, 07 Apr 2025 04:53:58 -0400
X-MC-Unique: E6bKEp45P3-Gs4bnnG0mFA-1
X-Mimecast-MFC-AGG-ID: E6bKEp45P3-Gs4bnnG0mFA_1744016037
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac2db121f95so327193466b.1
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 01:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744016037; x=1744620837;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WX08fMyjATa1UCoVjYCNjOKyQjVIMz6mY8L2vI8owLs=;
        b=gFDGQ6QgUKHZ2KGr9waafURFazPJduJe2IfVKIr5B84kSVYgsUDJpwHtHcJ4fu22LE
         4XAyqKHW0LNAniQRPve6duyfVcTDm2O95fywJQQLWcwNMrfL1KQGGo2iQ1vkfV3rzVqX
         5Lc9UYX1d6GN8Prjr+xr24BTAqsDNXuT6Jy4bAd8dRDtXpq2wnBimeCVsI49HvkXTbKf
         U7WCyMhUJb+uLKh74Y0AmsZ/qyYd0UgxryD365upPTfJbAlOQzyA6o4e9FwMBkNflBeI
         yoOrpyID6zCBFqETE/xIfDG2f9kJCU5eQMoJ9dQrMySZNowFcboRV9VUN3+fTeensHW+
         rbdg==
X-Gm-Message-State: AOJu0YzszEo7aMqlgDyLZDzaP7jKPAkhJdyPm9XizUX1uCjprREGOTbK
	q1/NqhqMXNHE0hUXdlWEiD4HoP454g4UNVrKQRAaA0E9PlCdvml42v2nBV+Uvzsh5TQlvqLwzqr
	P2Sxm+TB1r9KwKj7Wby96WPcywji0MlZsupYT0eu5F6i3eDOKPeR6sw==
X-Gm-Gg: ASbGnct9ZQLZArbGCAkSnuR2Cp9c3hvE3fO0i9EYsp3Kd3HQc0GfhDnry03nywwRlWU
	R5xf78T0C8LKYbe0WpNxSsqHlxdUOQ/WF/UMzPY/T6E6H2aOKhBlQDbvEXxxj0pvzjMqOlix1m3
	2nwkTYfk+2/mt8iKk/Kw53eKPoOThZ5N/fq+09+qZUJgpVjyNznI1/waowpGcc+wVVvj2nEJX19
	9D+h7JOmgIdUHnWQbPCeuVRtHZxQlCJNLfCQO5gLNChG6TZXHJFK3lfzHGP45GRwtCT2MErMPzt
	9bAyWF67SKncHA+7FMqJIHC4qTc98/QRif++HRlG
X-Received: by 2002:a17:907:60d1:b0:ac2:66ff:878 with SMTP id a640c23a62f3a-ac7e77b48afmr787963666b.50.1744016037491;
        Mon, 07 Apr 2025 01:53:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVb33+8wF4lK6cnuu9f4nRUChR41f7hK0+8LtHxpAhi3vaXbXMmuVF5DNGsf7Ha6IvN6oWCg==
X-Received: by 2002:a17:907:60d1:b0:ac2:66ff:878 with SMTP id a640c23a62f3a-ac7e77b48afmr787959466b.50.1744016037067;
        Mon, 07 Apr 2025 01:53:57 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c013f71asm706325866b.112.2025.04.07.01.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 01:53:56 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 521BF1991859; Mon, 07 Apr 2025 10:53:55 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Zi Yan <ziy@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mina Almasry
 <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>, Yunsheng
 Lin <linyunsheng@huawei.com>, Pavel Begunkov <asml.silence@gmail.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH net-next v7 1/2] page_pool: Move pp_magic check into
 helper functions
In-Reply-To: <D8ZSA9FSRHX2.2Q6MA2HLESONR@nvidia.com>
References: <20250404-page-pool-track-dma-v7-0-ad34f069bc18@redhat.com>
 <20250404-page-pool-track-dma-v7-1-ad34f069bc18@redhat.com>
 <D8ZSA9FSRHX2.2Q6MA2HLESONR@nvidia.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 07 Apr 2025 10:53:55 +0200
Message-ID: <87cydoxsgs.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Zi Yan" <ziy@nvidia.com> writes:

> On Fri Apr 4, 2025 at 6:18 AM EDT, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Since we are about to stash some more information into the pp_magic
>> field, let's move the magic signature checks into a pair of helper
>> functions so it can be changed in one place.
>>
>> Reviewed-by: Mina Almasry <almasrymina@google.com>
>> Tested-by: Yonglong Liu <liuyonglong@huawei.com>
>> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 ++--
>>  include/net/page_pool/types.h                    | 18 ++++++++++++++++++
>>  mm/page_alloc.c                                  |  9 +++------
>>  net/core/netmem_priv.h                           |  5 +++++
>>  net/core/skbuff.c                                | 16 ++--------------
>>  net/core/xdp.c                                   |  4 ++--
>>  6 files changed, 32 insertions(+), 24 deletions(-)
>>
>
> <snip>
>
>> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types=
.h
>> index 36eb57d73abc6cfc601e700ca08be20fb8281055..df0d3c1608929605224feb26=
173135ff37951ef8 100644
>> --- a/include/net/page_pool/types.h
>> +++ b/include/net/page_pool/types.h
>> @@ -54,6 +54,14 @@ struct pp_alloc_cache {
>>  	netmem_ref cache[PP_ALLOC_CACHE_SIZE];
>>  };
>>=20=20
>> +/* Mask used for checking in page_pool_page_is_pp() below. page->pp_mag=
ic is
>> + * OR'ed with PP_SIGNATURE after the allocation in order to preserve bi=
t 0 for
>> + * the head page of compound page and bit 1 for pfmemalloc page.
>> + * page_is_pfmemalloc() is checked in __page_pool_put_page() to avoid r=
ecycling
>> + * the pfmemalloc page.
>> + */
>> +#define PP_MAGIC_MASK ~0x3UL
>> +
>>  /**
>>   * struct page_pool_params - page pool parameters
>>   * @fast:	params accessed frequently on hotpath
>> @@ -264,6 +272,11 @@ void page_pool_destroy(struct page_pool *pool);
>>  void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(v=
oid *),
>>  			   const struct xdp_mem_info *mem);
>>  void page_pool_put_netmem_bulk(netmem_ref *data, u32 count);
>> +
>> +static inline bool page_pool_page_is_pp(struct page *page)
>> +{
>> +	return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
>> +}
>>  #else
>>  static inline void page_pool_destroy(struct page_pool *pool)
>>  {
>> @@ -278,6 +291,11 @@ static inline void page_pool_use_xdp_mem(struct pag=
e_pool *pool,
>>  static inline void page_pool_put_netmem_bulk(netmem_ref *data, u32 coun=
t)
>>  {
>>  }
>> +
>> +static inline bool page_pool_page_is_pp(struct page *page)
>> +{
>> +	return false;
>> +}
>>  #endif
>>=20=20
>>  void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref ne=
tmem,
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index f51aa6051a99867d2d7d8c70aa7c30e523629951..347a3cc2c188f4a9ced85e0d=
198947be7c503526 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -55,6 +55,7 @@
>>  #include <linux/delayacct.h>
>>  #include <linux/cacheinfo.h>
>>  #include <linux/pgalloc_tag.h>
>> +#include <net/page_pool/types.h>
>>  #include <asm/div64.h>
>>  #include "internal.h"
>>  #include "shuffle.h"
>> @@ -897,9 +898,7 @@ static inline bool page_expected_state(struct page *=
page,
>>  #ifdef CONFIG_MEMCG
>>  			page->memcg_data |
>>  #endif
>> -#ifdef CONFIG_PAGE_POOL
>> -			((page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE) |
>> -#endif
>> +			page_pool_page_is_pp(page) |
>>  			(page->flags & check_flags)))
>>  		return false;
>>=20=20
>> @@ -926,10 +925,8 @@ static const char *page_bad_reason(struct page *pag=
e, unsigned long flags)
>>  	if (unlikely(page->memcg_data))
>>  		bad_reason =3D "page still charged to cgroup";
>>  #endif
>> -#ifdef CONFIG_PAGE_POOL
>> -	if (unlikely((page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE))
>> +	if (unlikely(page_pool_page_is_pp(page)))
>>  		bad_reason =3D "page_pool leak";
>> -#endif
>>  	return bad_reason;
>>  }
>>=20=20
>
> I wonder if it is OK to make page allocation depend on page_pool from
> net/page_pool.

Why? It's not really a dependency, just a header include with a static
inline function...

> Would linux/mm.h be a better place for page_pool_page_is_pp()?

That would require moving all the definitions introduced in patch 2,
which I don't think is appropriate.

-Toke


