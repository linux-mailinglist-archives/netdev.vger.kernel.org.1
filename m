Return-Path: <netdev+bounces-137400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FE59A6034
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 11:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B022F1F2256D
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 09:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B561E377E;
	Mon, 21 Oct 2024 09:34:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BF91E2608;
	Mon, 21 Oct 2024 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503291; cv=none; b=I0gpBB2R4Kg1Gs5HO8JDUC9yX8QU+8B98ckR+PQreu5zxxANI6L/6W/1l2uLbyXVF3GpMtFvgCBkWslteJ+/NoCJ/hlM2+YOeSa08Ry4znVonlCf39IL/BJrqCIfEQOXTEECwex38J6pRzDPYhmevvgFgBvNgs19GW8G8wTorCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503291; c=relaxed/simple;
	bh=PgC55g+yMmrhDOSgWrJWXqM7B3dU93ySEhXl827HqHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TZarhKVDxvNHlU1gd24VJ+GTOrjVRd+fbBieuxTC5RIW8oIIhsWLTI/h8UO9SfEgrEtHLkTtlimmCpJQ9F1njJdwTJmMiiCVhw/euNtVWtk9kaoOpU6QKzp1wTaKmf9yIhAX50M+A4VNz0fINu62A0ASLnUiyf/ExXJ+gpCiTJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XX99156Nrz1jB8L;
	Mon, 21 Oct 2024 17:33:25 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 17D84140360;
	Mon, 21 Oct 2024 17:34:46 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Oct 2024 17:34:45 +0800
Message-ID: <32e73dd8-5cc8-4211-ab5f-ab10281902e6@huawei.com>
Date: Mon, 21 Oct 2024 17:34:45 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v22 07/14] mm: page_frag: some minor refactoring
 before adding new API
To: Alexander Duyck <alexander.duyck@gmail.com>, Yunsheng Lin
	<yunshenglin0825@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20241018105351.1960345-1-linyunsheng@huawei.com>
 <20241018105351.1960345-8-linyunsheng@huawei.com>
 <CAKgT0UcBveXG3D9aHHADHn3yAwA6mLeQeSqoyP+UwyQ3FDEKGw@mail.gmail.com>
 <e38cc22e-afbc-445e-b986-9ab31c799a09@gmail.com>
 <CAKgT0UeM15+HZor5_woJ4Fd_YrHVgrMM86wD4o5xGczQXC2aOg@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0UeM15+HZor5_woJ4Fd_YrHVgrMM86wD4o5xGczQXC2aOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/20 23:45, Alexander Duyck wrote:

...

> 
>>>
>>>
>>>> @@ -132,8 +156,6 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>>>>                          return NULL;
>>>>                  }
>>>>
>>>> -               page = encoded_page_decode_page(encoded_page);
>>>> -
>>>>                  if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
>>>>                          goto refill;
>>>>
>>>> @@ -148,15 +170,17 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
>>>>
>>>>                  /* reset page count bias and offset to start of new frag */
>>>>                  nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
>>>> +               nc->offset = 0;
>>>>                  offset = 0;
>>>>          }
>>>>
>>>> -       nc->pagecnt_bias--;
>>>> -       nc->offset = offset + fragsz;
>>>> +       pfrag->page = page;
>>>> +       pfrag->offset = offset;
>>>> +       pfrag->size = size - offset;
>>>
>>> I really think we should still be moving the nc->offset forward at
>>> least with each allocation. It seems like you end up doing two flavors
>>> of commit, one with and one without the decrement of the bias. So I
>>> would be okay with that being pulled out into some separate logic to
>>> avoid the extra increment in the case of merging the pages. However in
>>> both cases you need to move the offset, so I would recommend keeping
>>> that bit there as it would allow us to essentially call this multiple
>>> times without having to do a commit in between to keep the offset
>>> correct. With that your commit logic only has to verify nothing
>>> changes out from underneath us and then update the pagecnt_bias if
>>> needed.
>>
>> The problem is that we don't really know how much the nc->offset
>> need to be moved forward to and the caller needs the original offset
>> for skb_fill_page_desc() related calling when prepare API is used as
>> an example in 'Preparation & committing API' section of patch 13:
> 
> The thing is you really have 2 different APIs. You have one you were
> doing which was a alloc/abort approach and another that is a
> probe/commit approach. I think for the probe/commit you could probably
> get away with using an "alloc" type approach with a size of 0 which
> would correctly set the start of your offset and then you would need
> to update it later once you know the total size for your commit. For

It seems there are some issues with the above approach as below as I
can see for now:
1. when nc->encoded_page is 0, Calling the "alloc" type API with
fragsz being zero may still allocate a new page from allocator, which
seems to against the purpose of probe API, right?

2. It doesn't allow the caller to specify a fragsz for probing, instead
   it rely on the caller to check if the size of probed fragment is bigger
   enough for its use case.

> the probe/commit we could use the nc->offset as a kind of cookie to
> verify we are working with the expected page and offset.

I am not sure if I am following the above, but I should mention that
nc->offset is not updated for prepare/probe API because the original
offset might be used for calculating the truesize of the fragment
when commit API is called, and the offset returned to the caller might
need to be updated according to alignment requirement, so I am not sure
how nc->offset can be used to verify the exact offset here.

If it is realy about catching misuse of the page_frag API, it might be
better to add something like nc->last_offset to record the offset of
allocated fragment under some config like PAGE_FRAG_DEBUG, as there
are other ways that the caller might mess up here like messing up the
allocation context assumtion.

> 
> For the alloc/abort it would be something similar but more the
> reverse. With that one we would need to have the size + offset and
> then verify the current offset is equal to that before we allow
> reverting the previous nc->offset update. The current patch set is a
> bit too permissive on the abort in my opinion and should be verifying
> that we are updating the correct offset.

I am not sure if I understand what is your idea about how to do an
exact verifying for abort API here.
For abort API, it seems we can do an exact verifying if the 'va' is
also passed to the abort API as the nc->offset is already updated,
something like below:

static inline void page_frag_alloc_abort(struct page_frag_cache *nc,
					 void *va, unsigned int fragsz)
{
        VM_BUG_ON((nc->offset - fragsz) !=
		  (encoded_page_decode_virt(nc->encoded_page) - va));

        nc->pagecnt_bias++;
        nc->offset -= fragsz;
}

But it also might mean we need to put page_frag_alloc_abort() in
page_frag_cache.c instead of a inline helper in page_frag_cache.h, as
the encoded_page_decode_virt() is a static function in c file. Or put
encoded_page_decode_virt() in the h file.

