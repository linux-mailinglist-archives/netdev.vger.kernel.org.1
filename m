Return-Path: <netdev+bounces-162570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC334A273E1
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79BAD3A80CE
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0825212F91;
	Tue,  4 Feb 2025 13:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHUoDwel"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA2B212D9C;
	Tue,  4 Feb 2025 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738677092; cv=none; b=QKf6WVsWD2SZq9LQYktA8AUe75ZTMiNRc8UbeJw7IE+Sd+RKNIuret93pueIhY1uMotzD6bISLy3GiLF4EzHnnkG3nrD/8zv8hhumrWjmSCBwJUv+hV4fbYN0HpEQvEcGRxmTrW8C5HcFZGk9HqyR/aT756COaZL7flc1m5v2us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738677092; c=relaxed/simple;
	bh=EdqK4dOG44KVkikAD2uMFzkLSnKvEM9Ta4/c9MzsVM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GuwxPLgZLKStXkuIJYS1z4ahPDsiZDdR40E2zdpq/YTDUYlO5EfFDloLznYQn+A6IaMuoR5L+ZwDxrLu1gXmsCGPEBl83RSy5ahsQ62xed46sDakKkoYbz0EBRfwVs3lerv0ivmP7KD36JGSn6b/TRfcxKXsVeDHP+tLZORpEgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHUoDwel; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2161eb94cceso69564565ad.2;
        Tue, 04 Feb 2025 05:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738677090; x=1739281890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Mrwk9eioiRgkG7loHAuR4qrjcX/aCvJsTaZ/T9ZIX8=;
        b=UHUoDwelIXDvNc50fedWYyTX+h6nQ1Rs8hO9s1LKxlebZLK8TGuwSBgVBO4v7zYy7Z
         A6kWlkB5ksl/HPMEGbm0mpAqJN6DjXWc4FjFBiczQtGmGrNUV+hUTgFGxrgz4jraDHfI
         rvmfMuqcxhBkJDQ+ADRSgulBNw5cUGElctDnbn+K9kuquO/3kL6qw6mBVC0nEOo8ne/9
         le2KuyrdzAkC4TT7EghsiPxqIMdsTPFEVvj/ncx/c2lZZ+zTX/DvJnRbV+JkHjsQ60P6
         7n5teOCU5TizmR8nweQgXEghUl7hsw6kV9TtnHebplZ11LZxgSCufOsH9frtecNFMom6
         J8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738677090; x=1739281890;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Mrwk9eioiRgkG7loHAuR4qrjcX/aCvJsTaZ/T9ZIX8=;
        b=X93TBynRUT56wlWcUgHpVxq8qzd5KBSRhvE22TjmwHPNAXn43Qv2JqqxKlP0VPKGrX
         7IxvfMCUrMEDv09qyOUv5jdGs8+h8yUopzAmBDmkoVRo/qDAijoIkOr5wYpKTOb2pdbZ
         FyYl77Q4P6hMyZ3fAp/hG9ECPsCv5WrUCC6xo0IfMPjB/GDCgsc3u1bmSlO+ytYuNe2n
         9/ITuounRSAfsDArCEuWHD1jITkjcN/AJHLajYZoQmvNDctosawmYhP5Ff4np9ps27wj
         fw0E86TfajIIc3tdR1ZPCZKFy8RbtdzRaKOFD8vJxkrwhxZsvbAe0XaVq0jk2mxe4ogr
         FhTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6pSjBdPF64nkFG3xHwlPeLttCRhYifXmsHsr6k1m5znQRTepPokOQtuydXkG+3lIR5Eev27IizLUqdx8=@vger.kernel.org, AJvYcCUNvil1moEiuCUSJVnOy15PBy0ToW9xQglPjCXYE/H3qzqhE91QTQS37d3C99P/q/LgPwKIf8hB@vger.kernel.org
X-Gm-Message-State: AOJu0YyPizQxHPQuD6bBkKrSQnsH/FLxUjshMPJTn2L0dObfpgkw0YNm
	UBlhgI/wIpFFoH9eReRvgEWvgZ710xPqGpuxew3Oq41ypGHX/3RQ
X-Gm-Gg: ASbGnctM21WUOfm4J/4+DsOBo+Ho08CN05dR7K+knGmxsZSRSmq4+KNS1a/CeSYixqq
	4aVJOSJvFjttNF+v6N542tmR8P9mP8c3n6Q/O4PiF1H5nXhTvvJdAJHXFAo6ka2myfYS7xfnjBV
	bJWxc8RY6dXz4eJWGvLubXvtoZ3SdKk4F4NiGSbf5YJpqUoVuwDxTTjjJ4PtKY9f0wEaurF+bdx
	ntV+ZESBX5hPClTQYxpo6VBZV1/AljzkXsYpmC/5gzfYOOXfV+41INoJpExNJyrmpsrnhT9LD0z
	NNLYzGJ5tHH45D6F5bBO2Rp6+Zy3EokOYWP7zN88uf6iGZuLU7OVUjAG5JKyGbu8YA9WrUHDOay
	ZaC8=
X-Google-Smtp-Source: AGHT+IGvL8j5c0FdSCQXSFe1hSU7qHBctpcOZKZDQ5a5qQlBPy8PmY+fTSKGr+v9njBvTp7goQB5mw==
X-Received: by 2002:a17:903:2444:b0:212:1ebf:9a03 with SMTP id d9443c01a7336-21dd7c3c86amr410177335ad.2.1738677089668;
        Tue, 04 Feb 2025 05:51:29 -0800 (PST)
Received: from ?IPV6:2409:8a55:301b:e120:3936:dcf4:dc64:c1b9? ([2409:8a55:301b:e120:3936:dcf4:dc64:c1b9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de33000ebsm96266855ad.159.2025.02.04.05.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 05:51:29 -0800 (PST)
Message-ID: <72f388e8-adef-4ecc-812d-a1d19c801df5@gmail.com>
Date: Tue, 4 Feb 2025 21:51:18 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/8] page_pool: fix timing for checking and
 disabling napi_local
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com
Cc: zhangkun09@huawei.com, liuyonglong@huawei.com, fanghaiqing@huawei.com,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250110130703.3814407-1-linyunsheng@huawei.com>
 <20250110130703.3814407-3-linyunsheng@huawei.com> <87sepqhe3n.fsf@toke.dk>
 <5059df11-a85b-4404-8c24-a9ccd76924f3@gmail.com> <87plkhn2x7.fsf@toke.dk>
 <2aa84c61-6531-4f17-89e5-101f46ef00d0@huawei.com> <8734h8qgmz.fsf@toke.dk>
 <84282526-6229-41c7-8f6b-5f2c500dcd8e@gmail.com> <874j1kpdwo.fsf@toke.dk>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <874j1kpdwo.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/27/2025 9:47 PM, Toke Høiland-Jørgensen wrote:
> Yunsheng Lin <yunshenglin0825@gmail.com> writes:
> 
>> On 1/25/2025 1:13 AM, Toke Høiland-Jørgensen wrote:
>>> Yunsheng Lin <linyunsheng@huawei.com> writes:
>>>
>>>>> So I really don't see a way for this race to happen with correct usage
>>>>> of the page_pool and NAPI APIs, which means there's no reason to make
>>>>> the change you are proposing here.
>>>>
>>>> I looked at one driver setting pp->napi, it seems the bnxt driver doesn't
>>>> seems to call page_pool_disable_direct_recycling() when unloading, see
>>>> bnxt_half_close_nic(), page_pool_disable_direct_recycling() seems to be
>>>> only called for the new queue_mgmt API:
>>>>
>>>> /* rtnl_lock held, this call can only be made after a previous successful
>>>>    * call to bnxt_half_open_nic().
>>>>    */
>>>> void bnxt_half_close_nic(struct bnxt *bp)
>>>> {
>>>> 	bnxt_hwrm_resource_free(bp, false, true);
>>>> 	bnxt_del_napi(bp);       *----call napi del and rcu sync----*
>>>> 	bnxt_free_skbs(bp);
>>>> 	bnxt_free_mem(bp, true); *------call page_pool_destroy()----*
>>>> 	clear_bit(BNXT_STATE_HALF_OPEN, &bp->state);
>>>> }
>>>>
>>>> Even if there is a page_pool_disable_direct_recycling() called between
>>>> bnxt_del_napi() and bnxt_free_mem(), the timing window still exist as
>>>> rcu sync need to be called after page_pool_disable_direct_recycling(),
>>>> it seems some refactor is needed for bnxt driver to reuse the rcu sync
>>>> from the NAPI API, in order to avoid calling the rcu sync for
>>>> page_pool_destroy().
>>>
>>> Well, I would consider that usage buggy. A page pool object is created
>>> with a reference to the napi struct; so the page pool should also be
>>> destroyed (clearing its reference) before the napi memory is freed. I
>>> guess this is not really documented anywhere, but it's pretty standard
>>> practice to free objects in the opposite order of their creation.
>>
>> I am not so familiar with rule about the creation API of NAPI, but the
>> implementation of bnxt driver can have reference of 'struct napi' before
>> calling netif_napi_add(), see below:
>>
>> static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool
>> link_re_init)
>> {
>> 	.......
>> 	rc = bnxt_alloc_mem(bp, irq_re_init);     *create page_pool*
>> 	if (rc) {
>> 		netdev_err(bp->dev, "bnxt_alloc_mem err: %x\n", rc);
>> 		goto open_err_free_mem;
>> 	}
>>
>> 	if (irq_re_init) {
>> 		bnxt_init_napi(bp);                *netif_napi_add*
>> 		rc = bnxt_request_irq(bp);
>> 		if (rc) {
>> 			netdev_err(bp->dev, "bnxt_request_irq err: %x\n", rc);
>> 			goto open_err_irq;
>> 		}
>> 	}
>>
>> 	.....
>> }
> 
> Regardless of the initialisation error, the fact that bnxt frees the
> NAPI memory before calling page_pool_destroy() is a driver bug. Mina has
> a suggestion for a warning to catch such bugs over in this thread:
> 
> https://lore.kernel.org/r/CAHS8izOv=tUiuzha6NFq1-ZurLGz9Jdi78jb3ey4ExVJirMprA@mail.gmail.com

Thanks for the reminder.
As the main problem is about adding a rcu sync between
page_pool_disable_direct_recycling() and page_pool_destroy(), I am
really doubtful that a warning can be added to catch such bugs if
page_pool_destroy() does not use an explicit rcu sync and rely on
the rcu sync from napi del API.

> 
>>> So no, I don't think this is something that should be fixed on the page
>>> pool side (and certainly not by adding another synchronize_rcu() call
>>> per queue!); rather, we should fix the drivers that get this wrong (and
>>> probably document the requirement a bit better).
>>
>> Even if timing problem of checking and disabling napi_local should not
>> be fixed on the page_pool side, do we have some common understanding
>> about fixing the DMA API misuse problem on the page_pool side?
>> If yes, do we have some common understanding about some mechanism
>> like synchronize_rcu() might be still needed on the page_pool side?
> 
> I have not reviewed the rest of your patch set, I only looked at this
> patch. I see you posted v8 without addressing Jesper's ask for a
> conceptual description of your design. I am not going to review a
> 600-something line patch series without such a description to go by, so
> please address that first.

I thought what Jesper'ask was mainly about why hijacking the page->pp
pointer.
I summarized the discussion in [1] as below, please let me know if that
addresses your concern too.

"By using the 'struct page_pool_item' referenced by page->pp_item,
page_pool is not only able to keep track of the inflight page to do dma
unmmaping when page_pool_destroy() is called if some pages are still
handled in networking stack, and networking stack is also able to find
the page_pool owning the page when returning pages back into page_pool.

struct page_pool_item {
	unsigned long state;
	
	union {
		netmem_ref pp_netmem;
		struct llist_node lentry;
	};
};

When a page is added to the page_pool, an item is deleted from
pool->hold_items and set the 'pp_netmem' pointing to that page and set
'state' accordingly in order to keep track of that page, refill from
pool->release_items when pool->hold_items is empty or use the item from
pool->slow_items when fast items run out.

When a page is released from the page_pool, it is able to tell which
page_pool this page belongs to by using the below functions:

static inline struct page_pool_item_block *
page_pool_item_to_block(struct page_pool_item *item)
{
	return (struct page_pool_item_block *)((unsigned long)item & PAGE_MASK);
}

static inline struct page_pool *page_pool_get_pp(struct page *page)
{
	/* The size of item_block is always PAGE_SIZE, the address of item_block
	 * for a specific item can be calculated using 'item & PAGE_MASK', so
	 * that we can find the page_pool object it belongs to.
	 */
	return page_pool_item_to_block(page->pp_item)->pp;
  }

and after clearing the pp_item->state', the item for the released page
is added back to pool->release_items so that it can be reused for new
pages or just free it when it is from the pool->slow_items.

When page_pool_destroy() is called, pp_item->state is used to tell if a 
specific item is being used/dma mapped or not by scanning all the item 
blocks in pool->item_blocks, then pp_item->netmem can be used to do the
dma unmmaping if the corresponding inflight page is dma mapped."

1. 
https://lore.kernel.org/all/2b5a58f3-d67a-4bf7-921a-033326958ac6@huawei.com/

> 
>> If yes, it may be better to focus on discussing how to avoid calling rcu
>> sync for each queue mentioned in [1].
> 
> Regardless of whether a synchronize_rcu() is needed in the final design
> (and again, note that I don't have an opinion on this before reviewing
> the whole series), this patch should be dropped from the series. The bug
> it is purporting to fix is a driver API misuse and should be fixed in
> the drivers, cf the above.

I am still a little doubltful it is a driver API misuse problem yet as
I am not true if page_pool_destroy() can depend on the rcu sync from
napi del API for all cases. Even if it is, this driver API misuse
problem seems to only exist after page_pool NAPI recycling feature/API
is added, which might mean some refactoring needed from the driver side
to support page_pool NAPI recycling.

Anyway, it seems to make sense to drop this patch from the series for
better forward progressing for the dma misuse problem as they are not
really related.

> 
> -Toke
> 


