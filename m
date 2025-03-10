Return-Path: <netdev+bounces-173450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E090A58F2D
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 10:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB84D18860C3
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 09:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE602248AC;
	Mon, 10 Mar 2025 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TEVaPcqu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3E42206A4
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 09:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741598028; cv=none; b=qptLEBVTg2jmWfJmtNQXldNSO2VnO7/i+3F9Jcv4FlkPJ/QFRy4+rzRQ7hxuoTzI2kQqMPOBTwVwqM+DxSyCeGLqrrMiMci/agKUkVqPQsTNbPdGYxrtvbVxK7kmGEi8Q5bMpgq+f3P/Q0esV1k2n2Pi1Xan5ixixqgZGzCEe34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741598028; c=relaxed/simple;
	bh=rWJckccBD6lVD+9Qgzrx8S7a8AXZ47zlKM8HkFIMvaA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vu4A8aRZK7fnKwHFyUTSA2H46vu1OzmwkGOi08zSVbNvfNp+F3xqo2zOC5msECBosq0tFRxgyQWr1lVXtRH7HgFoyQutv8cwBu5pHb30PLEyKTMQe0bDTih95tI/Yrv+3gxqadgQLrTaRVws7ZmREwrFWyFDt1IEgc64CdNX5iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TEVaPcqu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741598024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=exPnN+rMcdOduLx0XQej6ZvVDtMm0qKkMiLUs5zJZKM=;
	b=TEVaPcqugM/plBzIv7N3u0MXyYr0HZ44TjcvWIBeYHgsBmxO8Tm3zBCv0auRe8z+W50rgL
	P7I77nbKgy5T+OWnUF/jdypdYgdlK3vgMDJCSL+WjjsTKCWdWxu1bg5ZN+ZRiDpH+MwaUU
	OplXCXQ9NDsljWGKw2FVA8mua5LeV4M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377--fgXmT9bPkmE_Kr69vu_ZQ-1; Mon, 10 Mar 2025 05:13:43 -0400
X-MC-Unique: -fgXmT9bPkmE_Kr69vu_ZQ-1
X-Mimecast-MFC-AGG-ID: -fgXmT9bPkmE_Kr69vu_ZQ_1741598022
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac29f1e54baso72903966b.3
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 02:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741598022; x=1742202822;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exPnN+rMcdOduLx0XQej6ZvVDtMm0qKkMiLUs5zJZKM=;
        b=HVlUzyd8L8rTG38Oxbc+2kUPNQMyMu9eoH1JnoCQeUJo0RtrJxSz0iQQ9K5kOa3sAK
         s0XsWmile51/4aZxF82/VoQz7QfL0JEij7wkdMn1CsnPD9KdYIuiJiB+VSmC57HZeVl4
         A7/sBcJUjlTSHqcgZSFYx0162m2MdcvVidEb3D85qJJh7V0GJEs8f/TrTrNEsoCk8D9M
         l0b9fkFJOyLOLvzSLxHJwyw6oaP8heQ/67BuN93D9N7oaNQPi+3kbNjkp8dr5HcHg8wV
         EiT219FNwFfXpasOwMTU8bZviqW+NRVjA6JGzZe46H4BPsdjEImrF55qTxzJMA71y4Kp
         W2eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEjvOvqkK+SfwxfN+lk2s4ZKHWw9GvwSwi8AM9ijbXlOhLFIYAIWgtkzH/b9sB+xU2eOcwuQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTIi+MiGN+lLLAL6jtNmOIgbsj2ktAjF+Zx3FNiZGj7+mwohQi
	6nAgf54N5MZQ6iicB3qJ3DpxMimFIV5t9P8Iwn7AZtDNcCq/XdjbDGUqyEfkUhY28FnrfmdN5VI
	3K5PRNSv0+FuAecPCBV6wNWff7aGIwH/5LfYqHT3CJ/sdelqzBHeqbw==
X-Gm-Gg: ASbGncvj8dYi24PQ6HnjGHlGrkig3HLk9lB7D0PIueBm8DpYgvdsB5dnSvkLwuVo7in
	X9RAM4sNbXoxKABcLZP9RQQA1g5/ttQinxP3UVAQwFfEQetJG9FTBP1d2lNukgnVhhLkmnwerkQ
	HohhAOgIyhDfzb9Tbn4g5/RnVSC5OymZCiklnZw/7KLtKQtNp55NjA9NTQP6itzJ0OEz5A3ar+F
	0qyhv7LaC7IelPqJYqgwnc+G7njVZHEf8D7CshJHQ8DrCcsJ8zmjKS6vlukGFpli6KpsRFnzlDq
	fbzHk6TH35MQ
X-Received: by 2002:a17:907:3e0d:b0:ac1:fb27:d3b0 with SMTP id a640c23a62f3a-ac252aae4damr1037265766b.22.1741598022326;
        Mon, 10 Mar 2025 02:13:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5HVXXzF6q5e64KAfxQdx97a/6tiE9jIfl6inGdhc0FTOo2vMUvbKHaP2p5uLqZ0eOIX09iQ==
X-Received: by 2002:a17:907:3e0d:b0:ac1:fb27:d3b0 with SMTP id a640c23a62f3a-ac252aae4damr1037261866b.22.1741598021800;
        Mon, 10 Mar 2025 02:13:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac282c69e89sm322864766b.167.2025.03.10.02.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 02:13:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A9C2818FA218; Mon, 10 Mar 2025 10:13:32 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <yunshenglin0825@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S. Miller"
 <davem@davemloft.net>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, Yonglong Liu
 <liuyonglong@huawei.com>, Mina Almasry <almasrymina@google.com>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-mm@kvack.org, netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <d84e19c9-be0c-4d23-908b-f5e5ab6f3f3f@gmail.com>
References: <20250308145500.14046-1-toke@redhat.com>
 <d84e19c9-be0c-4d23-908b-f5e5ab6f3f3f@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 10 Mar 2025 10:13:32 +0100
Message-ID: <87cyepxn7n.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yunsheng Lin <yunshenglin0825@gmail.com> writes:

> On 3/8/2025 10:54 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> When enabling DMA mapping in page_pool, pages are kept DMA mapped until
>> they are released from the pool, to avoid the overhead of re-mapping the
>> pages every time they are used. This causes problems when a device is
>> torn down, because the page pool can't unmap the pages until they are
>> returned to the pool. This causes resource leaks and/or crashes when
>> there are pages still outstanding while the device is torn down, because
>> page_pool will attempt an unmap of a non-existent DMA device on the
>> subsequent page return.
>>=20
>> To fix this, implement a simple tracking of outstanding dma-mapped pages
>> in page pool using an xarray. This was first suggested by Mina[0], and
>> turns out to be fairly straight forward: We simply store pointers to
>> pages directly in the xarray with xa_alloc() when they are first DMA
>> mapped, and remove them from the array on unmap. Then, when a page pool
>> is torn down, it can simply walk the xarray and unmap all pages still
>> present there before returning, which also allows us to get rid of the
>> get/put_device() calls in page_pool. Using xa_cmpxchg(), no additional
>> synchronisation is needed, as a page will only ever be unmapped once.
>
> The implementation of xa_cmpxchg() seems to take the xa_lock, which
> seems to be a per-Xarray spin_lock.
> Yes, if if we were to take a per-Xarray lock unconditionaly, additional
> synchronisation like rcu doesn't seems to be needed. But it seems an
> excessive overhead for normal packet processing when page_pool_destroy()
> is not called yet?

I dunno, maybe? It's only done on DMA map/unmap, so it may be
acceptable? We should get some benchmark results to assess :)

> Also, we might need a similar locking or synchronisation for the dma
> sync API in order to skip the dma sync API when page_pool_destroy() is
> called too.

Good point, but that seems a separate issue? And simpler to solve (just
set pool->dma_sync to false when destroying?).

>> To avoid having to walk the entire xarray on unmap to find the page
>> reference, we stash the ID assigned by xa_alloc() into the page
>> structure itself, in the field previously called '_pp_mapping_pad' in
>> the page_pool struct inside struct page. This field overlaps with the
>> page->mapping pointer, which may turn out to be problematic, so an
>> alternative is probably needed. Sticking the ID into some of the upper
>> bits of page->pp_magic may work as an alternative, but that requires
>> further investigation. Using the 'mapping' field works well enough as
>> a demonstration for this RFC, though.
> page->pp_magic seems to only have 16 bits space available at most when
> trying to reuse some unused bits in page->pp_magic, as BPF_PTR_POISON
> and STACK_DEPOT_POISON seems to already use 16 bits, so:
> 1. For 32 bits system, it seems there is only 16 bits left even if the
>     ILLEGAL_POINTER_VALUE is defined as 0x0.
> 2. For 64 bits system, it seems there is only 12 bits left for powerpc
>     as ILLEGAL_POINTER_VALUE is defined as 0x5deadbeef0000000, see
>     arch/powerpc/Kconfig.
>
> So it seems we might need to limit the dma mapping count to 4096 or
> 65536?
>
> And to be honest, I am not sure if those 'unused' 12/16 bits can really=20
> be reused or not, I guess we might need suggestion from mm and arch
> experts here.

Why do we need to care about BPF_PTR_POISON and STACK_DEPOT_POISON?
AFAICT, we only need to make sure we preserve the PP_SIGNATURE value.
See v2 of the RFC patch, the bit arithmetic there gives me:

- 24 bits on 32-bit architectures
- 21 bits on PPC64 (because of the definition of ILLEGAL_POINTER_VALUE)
- 32 bits on other 64-bit architectures

Which seems to be plenty?

>> Since all the tracking is performed on DMA map/unmap, no additional code
>> is needed in the fast path, meaning the performance overhead of this
>> tracking is negligible. The extra memory needed to track the pages is
>> neatly encapsulated inside xarray, which uses the 'struct xa_node'
>> structure to track items. This structure is 576 bytes long, with slots
>> for 64 items, meaning that a full node occurs only 9 bytes of overhead
>> per slot it tracks (in practice, it probably won't be this efficient,
>> but in any case it should be an acceptable overhead).
>
> Even if items is stored sequentially in xa_node at first, is it possible
> that there may be fragmentation in those xa_node when pages are released
> and allocated many times during packet processing? If yes, is there any
> fragmentation info about those xa_node?

Some (that's what I mean with "not as efficient"). AFAICT, xa_array does
do some rebalancing of the underlying radix tree, freeing nodes when
they are no longer used. However, I am not too familiar with the xarray
code, so I don't know exactly how efficient this is in practice.

>> [0] https://lore.kernel.org/all/CAHS8izPg7B5DwKfSuzz-iOop_YRbk3Sd6Y4rX7K=
BG9DcVJcyWg@mail.gmail.com/
>>=20
>> Fixes: ff7d6b27f894 ("page_pool: refurbish version of page_pool code")
>> Reported-by: Yonglong Liu <liuyonglong@huawei.com>
>> Suggested-by: Mina Almasry <almasrymina@google.com>
>> Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> Tested-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>> This is an alternative to Yunsheng's series. Yunsheng requested I send
>> this as an RFC to better be able to discuss the different approaches; see
>> some initial discussion in[1], also regarding where to store the ID as
>> alluded to above.
>
> As mentioned before, I am not really convinced there is still any
> space left in 'struct page' yet, otherwise we might already use that
> space to fix the DMA address > 32 bits problem in 32 bits system, see
> page_pool_set_dma_addr_netmem().

See above.

> Also, Using the more space in 'struct page' for the page_pool seems to
> make page_pool more coupled to the mm subsystem, which seems to not
> align with the folios work that is trying to decouple non-mm subsystem
> from the mm subsystem by avoid other subsystem using more of the 'struct
> page' as metadata from the long term point of view.

This seems a bit theoretical; any future changes of struct page would
have to shuffle things around so we still have the ID available,
obviously :)

-Toke


