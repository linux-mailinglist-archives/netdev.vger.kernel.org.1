Return-Path: <netdev+bounces-142415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5001E9BEFF2
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 15:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4BB41F23757
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 14:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936A6201016;
	Wed,  6 Nov 2024 14:17:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0AF1DE4CA;
	Wed,  6 Nov 2024 14:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730902660; cv=none; b=rJxhrOnA5x2nr/8r5jSr2lE7PXpP0L2zOzN51hWn9B1fKiDvBS8+5GOkshwSU1EGlqkdHT5O5usIrHXg9L89UMmZmStqa/M0dMsKxYTWm3ZW2bQqWeiu4edKxjHalRTiviSqJ0r052GWeRA1lGExh2VEYhXbNqxsxUbu57FTjBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730902660; c=relaxed/simple;
	bh=h4cDEFZpluB0+iXtoSReBWWQxWLWC+hpea7ZJ0tuiZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OGTCkSLcI4/Z5r5pOmvuV5e9bKoNpYzGdwjFHcGVr5KiiQyb3b1llIPrUxJ2z+vpbL7myqbZPbMeAH5CdFStMD/iIKea8lT0AZTUCR3c+RM3TFWFsyROHqvJ1Ct2YgpBUPdKeVjL8X2XaNpPViE/7CznOXKiGabE24QrmgzW1Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B508497;
	Wed,  6 Nov 2024 06:18:06 -0800 (PST)
Received: from [10.57.90.5] (unknown [10.57.90.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 875783F66E;
	Wed,  6 Nov 2024 06:17:33 -0800 (PST)
Message-ID: <caf31b5e-0e8f-4844-b7ba-ef59ed13b74e@arm.com>
Date: Wed, 6 Nov 2024 14:17:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] page_pool: fix IOMMU crash when driver
 has already unbound
To: Yunsheng Lin <linyunsheng@huawei.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc: zhangkun09@huawei.com, fanghaiqing@huawei.com, liuyonglong@huawei.com,
 Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Eric Dumazet
 <edumazet@google.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 kernel-team <kernel-team@cloudflare.com>, Christoph Hellwig <hch@lst.de>,
 m.szyprowski@samsung.com
References: <20241022032214.3915232-1-linyunsheng@huawei.com>
 <20241022032214.3915232-4-linyunsheng@huawei.com>
 <dbd7dca7-d144-4a0f-9261-e8373be6f8a1@kernel.org>
 <113c9835-f170-46cf-92ba-df4ca5dfab3d@huawei.com> <878qudftsn.fsf@toke.dk>
 <d8e0895b-dd37-44bf-ba19-75c93605fc5e@huawei.com> <87r084e8lc.fsf@toke.dk>
 <cf1911c5-622f-484c-9ee5-11e1ac83da24@huawei.com> <878qu7c8om.fsf@toke.dk>
 <1eac33ae-e8e1-4437-9403-57291ba4ced6@huawei.com> <87o731by64.fsf@toke.dk>
 <023fdee7-dbd4-4e78-b911-a7136ff81343@huawei.com> <874j4sb60w.fsf@toke.dk>
 <a50250bf-fe76-4324-96d7-b3acf087a18c@huawei.com>
 <a6cfba96-9164-4497-b075-9359c18a5eef@kernel.org>
 <2f256bce-0c37-4940-9218-9545daa46169@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <2f256bce-0c37-4940-9218-9545daa46169@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-11-06 10:56 am, Yunsheng Lin wrote:
> +cc Christoph & Marek
> 
> On 2024/11/6 4:11, Jesper Dangaard Brouer wrote:
> 
> ...
> 
>>>>
>>>>> I am not sure if I understand the reasoning behind the above suggestion to 'wait
>>>>> and see if this actually turns out to be a problem' when we already know that there
>>>>> are some cases which need cache kicking/flushing for the waiting to work and those
>>>>> kicking/flushing may not be easy and may take indefinite time too, not to mention
>>>>> there might be other cases that need kicking/flushing that we don't know yet.
>>>>>
>>>>> Is there any reason not to consider recording the inflight pages so that unmapping
>>>>> can be done for inflight pages before driver unbound supposing dynamic number of
>>>>> inflight pages can be supported?
>>>>>
>>>>> IOW, Is there any reason you and jesper taking it as axiomatic that recording the
>>>>> inflight pages is bad supposing the inflight pages can be unlimited and recording
>>>>> can be done with least performance overhead?
>>>>
>>>> Well, page pool is a memory allocator, and it already has a mechanism to
>>>> handle returning of memory to it. You're proposing to add a second,
>>>> orthogonal, mechanism to do this, one that adds both overhead and
>>>
>>> I would call it as a replacement/improvement for the old one instead of
>>> 'a second, orthogonal' as the old one doesn't really exist after this patch.
>>>
>>
>> Yes, are proposing doing a very radical change to the page_pool design.
>> And this is getting proposed as a fix patch for IOMMU.
>>
>> It is a very radical change that page_pool needs to keep track of *ALL* in-flight pages.
> 
> I am agreed that it is a radical change, that is why it is targetting net-next
> tree instead of net tree even when there is a Fixes tag for it.
> 
> If there is a proper and non-radical way to fix that, I would prefer the
> non-radical way too.
> 
>>
>> The DMA issue is a life-time issue of DMA object associated with the
>> struct device.  Then, why are you not looking at extending the life-time
> 
> It seems it is not really about the life-time of DMA object associated with the
> life-time of 'struct device', it seems to be the life-time of DMA API associated
> with the life-time of the driver for the 'struct device' from the the opinion of
> experts from IOMMU/DMA subsystem in [1] & [2].

There is no "DMA object". The DMA API expects to be called with a valid 
device bound to a driver. There are parts in many different places all 
built around that expectation to varying degrees. Looking again, it 
seems dma_debug_device_change() has existed for way longer than the 
page_pool code, so frankly I'm a little surprised that this case is only 
coming up now in this context...

Even if one tries to handwave past that with a bogus argument that 
technically these DMA mappings belong to the subsystem rather than the 
driver itself, it is clearly unrealistic to imagine that once a device 
is torn down by device_del() it's still valid for anything. In fact, 
before even that point, it is explicitly documented that a device which 
is merely offlined prior to potential removal "cannot be used for any 
purpose", per Documentation/ABI/testing/sysfs-devices-online.

Holding a refcount so that the memory backing the struct device can 
still be accessed without a literal use-after-free does not represent 
the device being conceptually valid in any API-level sense. Even if the 
device isn't removed, as soon as its driver is unbound its DMA ops can 
change; the driver could then be re-bound, and the device valid for 
*new* DMA mappings again, but it's still bogus to attempt to unmap 
outstanding old mappings through the new ops (which is just as likely to 
throw an error/crash/corrupt memory/whatever). The page pool DMA mapping 
design is just fundamentally incorrect with respect to the device/driver 
model lifecycle.

> I am not sure what is reasoning behind the above, but the implementation seems
> to be the case as mentioned in [3]:
> __device_release_driver -> device_unbind_cleanup -> arch_teardown_dma_ops
> 
> 1. https://lkml.org/lkml/2024/8/6/632
> 2. https://lore.kernel.org/all/20240923175226.GC9634@ziepe.ca/
> 3. https://lkml.org/lkml/2024/10/15/686
> 
>> of the DMA object, or at least detect when DMA object goes away, such
>> that we can change a setting in page_pool to stop calling DMA unmap for
>> the pages in-flight once they get returned (which we have en existing
>> mechanism for).
> 
> To be honest, I was mostly depending on the opinion of the experts from
> IOMMU/DMA subsystem for the correct DMA API usage as mentioned above.
> So I am not sure if skipping DMA unmapping for the inflight pages is the
> correct DMA API usage?
> If it is the correct DMA API usage, how to detect that if DMA unmapping
> can be skipped?

Once page_pool has allowed a driver to unbind from a device without 
cleaning up all outstanding DMA mappings made via that device, then it 
has already leaked those mappings and the damage is done, regardless of 
whether the effects are visible yet. If you'd really rather play 
whack-a-mole trying to paper over secondary symptoms of that issue than 
actually fix it, then fine, but don't expect any driver core/DMA API 
changes to be acceptable for that purpose. However, if people are 
hitting those symptoms now, then I'd imagine they're eventually going to 
come back asking about the ones which can't be papered over, like 
dma-debug reporting the leaks, or just why their system ends up burning 
gigabytes on IOMMU pagetables and IOVA kmem_caches.

Thanks,
Robin.

