Return-Path: <netdev+bounces-166663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE819A36DFB
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 13:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D0EF3B0DAD
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 12:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1921AAA0D;
	Sat, 15 Feb 2025 12:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZQIynNc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C0C1A83F8;
	Sat, 15 Feb 2025 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739621635; cv=none; b=fYlq1ySqj7hgVIPpCWZFX2Z+qOoCcLx7hkCI9fO0Zv6Imowfi9AGWpbCo+J6GNwgmXdZAeN6psZxGkzTls3modbYJ4MWRsG5Sn6PtPzrIiNgYkO5sAhY9NdvKgubjmrpfYYGxu/2sS5UMZVqJv+8Lvl9BheVUoHJrmgzctetcjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739621635; c=relaxed/simple;
	bh=8vN4Pj2w1BkLqAkaHk5aHY+IfvITwxap/YSTJ6yR8cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kWZcuL27aYCYniUYpF1Opo+MVdJ+mczg3Nv9saBwAYpiH5gSJWTTRliysT0w32ncdZICRA5CJiIo5GFy94HSh29XDZEHPuSzUYVAEPSTHkE1ffzUcIIONF02YT8qhKPFNLjnrMGdICF0R9kFcnSfYCuWArCy+Ha/pnDTiQSVrHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZQIynNc; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-21f818a980cso46707195ad.3;
        Sat, 15 Feb 2025 04:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739621632; x=1740226432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+u+CA/lSm+9nBXmX/PuduGARGI9A6dkgRJTZchCRgBM=;
        b=HZQIynNchpBLJjy9WLAPDlRkteWg/xbtYOLz7gk62z6TXNKom8kiEz+6iffGP1TyCW
         Sd2eZpi5GuaXCFa87gjMrmL/83XeHT4nJ860BhppUx4KUXixWvK/sXli3Ecx/ZDF5rfe
         HQI7YYLlNa+FLkudV3ObfqU5FOFuquS+7j8V2Ff2Nu8exXBtH9T6fpFfyPyPqr/dUMmm
         mF9P4iDhGDgMMOtnT3wYVuln3dGpvYBWQcUvZYN561PRWpuWyBH1N9Vk+jnR3fPJzYRN
         JhGZt2o6xGZketdDqHxCsTaz+M43fl0KfPpRnLqKykY9hALPM+yXv7GnqKcR0f6DQmIm
         A1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739621632; x=1740226432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+u+CA/lSm+9nBXmX/PuduGARGI9A6dkgRJTZchCRgBM=;
        b=aWToxRYza5ZQebd+6+HNxY/UDWUlcmAMR5Dbyj3aiRGVYC7FVZX1GqRxH4gzNQeJ3A
         v8JPJawvJRsX1jH5towDSImQMBiM78KincSTZVvAfUEO6/YXTfOlnCalVQrME+0ZtiDG
         rf3pgZrszUj9+Wqj7cr3cdcNuLL/lafhf0Y9roZvW7IDKkwQiYXqXuRj6O1J4eztG3vW
         4LcHyW3e/0+iTQ9NZXBhQfRYNfHuLAPSEDKc1NMgarwmo7Kmkvd8OUyy+TlUbBCu1n6W
         wPQUtO8EIXs7Vqi6Wn+vf9JovdDqOCCBOzRrhx1VCLII202cDiEVmvBdNPfJ7EKW8YLS
         2QgA==
X-Forwarded-Encrypted: i=1; AJvYcCXN/SKI8M1g/pcEGYtNCPQ19TSAqCT+uNlCvIf+fQmheMaP+OuvqKlZCYeoxb/ULbZXKJ3YdgFLcN+hWBk=@vger.kernel.org, AJvYcCXXhQRocYlONcQKfOy6SwV4cfzu9J/+Y1VxTEPLtkCEhHvtuOGV3ceIugr2eNLEIy449Cg58wbt@vger.kernel.org
X-Gm-Message-State: AOJu0Yy02iQBqwygoudPqhVY2V1ngzvtsfXSZXHfDp729hdvHetMmSpR
	rEA0XBR2+ExZvWQc1x3Vy3ZWeLi3EKYHIer7nVPcL0PflcuO2a+D
X-Gm-Gg: ASbGncvhSkPsu24gIeIce3J0iJaLVXA+WekachW5Yds+WACO2kDzy4kHF/O2jeuX7tX
	99AoqbhG3sZTeUEDRO3AW4l+Zyp6Fm2uAyUH7OuJVCHyC1Ht7XKQshufWcSQd3MJBt35Y/PSkt0
	0nHyABGgQz2pc16E5xBdBgggiYUl4u4oXnbzUgFL7uEDkPQsCPqc8/7/pXtQdrkgU2n8Pckbv4o
	2NKymD1/HTx2EVfaIHIDBeotUdpAow2xf6cOt7Id6Qop7yRU2fUugEAWxI2a3g50u4EAcfj9W6B
	+WqofW4cKudUiVZRC5lcvX3Nk9xcc2WNu3dZH19BwB6/xBHipTq5nAZUdw8ahbsdFZDYy+nwFCN
	GLxo=
X-Google-Smtp-Source: AGHT+IFJykoOYu33+zfWUVUg0sZz5RNHHYceinZgxb0Gxr+xnoVpFCsY/aZ5CYDKvVkNHhuFwTfTHQ==
X-Received: by 2002:a05:6a00:c87:b0:732:24ad:8e08 with SMTP id d2e1a72fcca58-73261776247mr3835535b3a.1.1739621632155;
        Sat, 15 Feb 2025 04:13:52 -0800 (PST)
Received: from ?IPV6:2409:8a55:301b:e120:4c58:8d4e:99f3:3687? ([2409:8a55:301b:e120:4c58:8d4e:99f3:3687])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e30dsm4845569b3a.99.2025.02.15.04.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Feb 2025 04:13:51 -0800 (PST)
Message-ID: <e65c19d6-4ce0-4dd2-a607-e08d47b6fe64@gmail.com>
Date: Sat, 15 Feb 2025 20:13:42 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 2/4] page_pool: fix IOMMU crash when driver
 has already unbound
To: Mina Almasry <almasrymina@google.com>,
 Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 zhangkun09@huawei.com, liuyonglong@huawei.com, fanghaiqing@huawei.com,
 Robin Murphy <robin.murphy@arm.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20250212092552.1779679-1-linyunsheng@huawei.com>
 <20250212092552.1779679-3-linyunsheng@huawei.com>
 <CAHS8izPZe0UHn8P38EvzX0ei_jGJnsXg99B5ra9Ldu09aWBU-Q@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <CAHS8izPZe0UHn8P38EvzX0ei_jGJnsXg99B5ra9Ldu09aWBU-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/15/2025 4:58 AM, Mina Almasry wrote:
> On Wed, Feb 12, 2025 at 1:34 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> Networking driver with page_pool support may hand over page
>> still with dma mapping to network stack and try to reuse that
>> page after network stack is done with it and passes it back
>> to page_pool to avoid the penalty of dma mapping/unmapping.
>> With all the caching in the network stack, some pages may be
>> held in the network stack without returning to the page_pool
>> soon enough, and with VF disable causing the driver unbound,
>> the page_pool does not stop the driver from doing it's
>> unbounding work, instead page_pool uses workqueue to check
>> if there is some pages coming back from the network stack
>> periodically, if there is any, it will do the dma unmmapping
>> related cleanup work.
>>
>> As mentioned in [1], attempting DMA unmaps after the driver
>> has already unbound may leak resources or at worst corrupt
>> memory. Fundamentally, the page pool code cannot allow DMA
>> mappings to outlive the driver they belong to.
>>
>> Currently it seems there are at least two cases that the page
>> is not released fast enough causing dma unmmapping done after
>> driver has already unbound:
>> 1. ipv4 packet defragmentation timeout: this seems to cause
>>     delay up to 30 secs.
>> 2. skb_defer_free_flush(): this may cause infinite delay if
>>     there is no triggering for net_rx_action().
>>
>> In order not to call DMA APIs to do DMA unmmapping after driver
>> has already unbound and stall the unloading of the networking
>> driver, use some pre-allocated item blocks to record inflight
>> pages including the ones which are handed over to network stack,
>> so the page_pool can do the DMA unmmapping for those pages when
>> page_pool_destroy() is called. As the pre-allocated item blocks
>> need to be large enough to avoid performance degradation, add a
>> 'item_fast_empty' stat to indicate the unavailability of the
>> pre-allocated item blocks.
>>
>> By using the 'struct page_pool_item' referenced by page->pp_item,
>> page_pool is not only able to keep track of the inflight page to
>> do dma unmmaping if some pages are still handled in networking
>> stack when page_pool_destroy() is called, and networking stack is
>> also able to find the page_pool owning the page when returning
>> pages back into page_pool:
>> 1. When a page is added to the page_pool, an item is deleted from
>>     pool->hold_items and set the 'pp_netmem' pointing to that page
>>     and set item->state and item->pp_netmem accordingly in order to
>>     keep track of that page, refill from pool->release_items when
>>     pool->hold_items is empty or use the item from pool->slow_items
>>     when fast items run out.
>> 2. When a page is released from the page_pool, it is able to tell
>>     which page_pool this page belongs to by masking off the lower
>>     bits of the pointer to page_pool_item *item, as the 'struct
>>     page_pool_item_block' is stored in the top of a struct page. And
>>     after clearing the pp_item->state', the item for the released page
>>     is added back to pool->release_items so that it can be reused for
>>     new pages or just free it when it is from the pool->slow_items.
>> 3. When page_pool_destroy() is called, item->state is used to tell if
>>     a specific item is being used/dma mapped or not by scanning all the
>>     item blocks in pool->item_blocks, then item->netmem can be used to
>>     do the dma unmmaping if the corresponding inflight page is dma
>>     mapped.
>>
>> The overhead of tracking of inflight pages is about 10ns~20ns,
>> which causes about 10% performance degradation for the test case
>> of time_bench_page_pool03_slow() in [2].
>>
>> Note, the devmem patchset seems to make the bug harder to fix,
>> and may make backporting harder too. As there is no actual user
>> for the devmem and the fixing for devmem is unclear for now,
>> this patch does not consider fixing the case for devmem yet.
>>
>> 1. https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/
>> 2. https://github.com/netoptimizer/prototype-kernel
>> CC: Robin Murphy <robin.murphy@arm.com>
>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>> CC: IOMMU <iommu@lists.linux.dev>
>> Fixes: f71fec47c2df ("page_pool: make sure struct device is stable")
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> Tested-by: Yonglong Liu <liuyonglong@huawei.com>
> [...]
>> +
>> +/* The size of item_block is always PAGE_SIZE, so that the address of item_block
>> + * for a specific item can be calculated using 'item & PAGE_MASK'
>> + */
>> +struct page_pool_item_block {
>> +       struct page_pool *pp;
>> +       struct list_head list;
>> +       struct page_pool_item items[];
>> +};
>> +
> 
> I think this feedback was mentioned in earlier iterations of the series:
> Can we not hold a struct list_head in the page_pool that keeps track
> of inflight netmems that we need to dma-unmap on page_pool_destroy?
> Why do we have to modify the pp entry in the struct page and struct
> net_iov?

Jesper asked a similar question in [1], see below:

1. 
https://lore.kernel.org/all/95f258b2-52f5-4a80-a670-b9a182caec7c@kernel.org/

> 
> The decision to modify pp entry in struct page and struct net_iov is
> making this patchset bigger and harder to review IMO.

I am open to any better suggestion of simple and easy way to fix this
with little performance impact as much as possible, but I really
doubtful that using some advanced struct like 'list_head" as suggested
above will not cause significant performance degradation.


