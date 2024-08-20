Return-Path: <netdev+bounces-120079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBA995838D
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 12:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DE8D1C210EF
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 10:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8930F18C935;
	Tue, 20 Aug 2024 10:05:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F1318991B;
	Tue, 20 Aug 2024 10:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724148337; cv=none; b=NnxbO9kvk8oShxSIVz9CV+HchGc9IjO3tA1KEhty/+B2C0h+dhPdhNm0mEy2IZWtUuGavl0kpzsU79juk5RYxO1ddPocYlxJhvSg0Z+WB/TgRHKpHklssPXY7VlzkXvKKR1sgr8bCnH5QWLpe1IrkwQABN3soEMWAnESGxfiflY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724148337; c=relaxed/simple;
	bh=7924WqlDUJrIrxpN04wq3ddA9MJDlHcP1SLcKcpKas4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=edJQDA0IVUP6I9d7BDH39EM2JoUDguDNCYis1ScOrfFL4WdUF4MwxeRpLHmnyvRsLQDTTjcsQdG6iF0mUsvEzjKD3hXQGt7OR1ddQidhuvC55S154liQJnQLF9aQrvnxc1jUFHanm3HnCRXUuOFkeaEC7EM0GwKF+JqS9LJpKNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34179DA7;
	Tue, 20 Aug 2024 03:06:01 -0700 (PDT)
Received: from [10.57.70.101] (unknown [10.57.70.101])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 633F63F66E;
	Tue, 20 Aug 2024 03:05:32 -0700 (PDT)
Message-ID: <2bc8d8c0-3e7f-47e3-99eb-be4f0983a54d@arm.com>
Date: Tue, 20 Aug 2024 11:05:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG REPORT]net: page_pool: kernel crash at
 iommu_get_dma_domain+0xc/0x20
To: Yonglong Liu <liuyonglong@huawei.com>,
 Yunsheng Lin <linyunsheng@huawei.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, pabeni@redhat.com, ilias.apalodimas@linaro.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexander Duyck <alexander.duyck@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, "shenjian (K)" <shenjian15@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, joro@8bytes.org, will@kernel.org,
 iommu@lists.linux.dev, Matthew Rosato <mjrosato@linux.ibm.com>
References: <0e54954b-0880-4ebc-8ef0-13b3ac0a6838@huawei.com>
 <8743264a-9700-4227-a556-5f931c720211@huawei.com>
 <e980d20f-ea8a-43e3-8d3f-179a269b5956@kernel.org>
 <CAOBf=musxZcjYNHjdD+MGp0y6epnNO5ryC6JgeAJbP6YQ+sVUA@mail.gmail.com>
 <ad84acd2-36ba-433c-bdf7-c16c0d992e1c@huawei.com>
 <190d5a15-d6bf-47d6-be86-991853b7b51d@arm.com>
 <5b0415ff-9bbe-4553-89d6-17d12fd44b47@huawei.com>
 <ae995d55-daa9-4060-85fa-31b4f725a17d@arm.com>
 <775234bc-84a2-458b-b047-ff6ab2607989@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <775234bc-84a2-458b-b047-ff6ab2607989@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-08-20 8:18 am, Yonglong Liu wrote:
> 
> On 2024/8/6 20:50, Robin Murphy wrote:
>> On 06/08/2024 12:54 pm, Yunsheng Lin wrote:
>>> On 2024/8/5 20:53, Robin Murphy wrote:
>>>>>>>
>>>>>>> The page_pool bumps refcnt via get_device() + put_device() on the 
>>>>>>> DMA
>>>>>>> 'struct device', to avoid it going away, but I guess there is 
>>>>>>> also some
>>>>>>> IOMMU code that we need to make sure doesn't go away (until all 
>>>>>>> inflight
>>>>>>> pages are returned) ???
>>>>>
>>>>> I guess the above is why thing went wrong here, the question is which
>>>>> IOMMU code need to be called here to stop them from going away.
>>>>
>>>> This looks like the wrong device is being passed to dma_unmap_page() 
>>>> - if a device had an IOMMU DMA domain at the point when the DMA 
>>>> mapping was create, then neither that domain nor its group can 
>>>> legitimately have disappeared while that device still had a driver 
>>>> bound. Or if it *was* the right device, but it's already had 
>>>> device_del() called on it, then you have a fundamental lifecycle 
>>>> problem - a device with no driver bound should not be passed to the 
>>>> DMA API, much less a dead device that's already been removed from 
>>>> its parent bus.
>>>
>>> Yes, the device *was* the right device, And it's already had 
>>> device_del()
>>> called on it.
>>> page_pool tries to call get_device() on the DMA 'struct device' to 
>>> avoid the
>>> above lifecycle problem, it seems get_device() does not stop 
>>> device_del()
>>> from being called, and that is where we have the problem here:
>>> https://elixir.bootlin.com/linux/v6.11-rc2/source/net/core/page_pool.c#L269
>>>
>>> The above happens because driver with page_pool support may hand over
>>> page still with dma mapping to network stack and try to reuse that page
>>> after network stack is done with it and passes it back to page_pool 
>>> to avoid
>>> the penalty of dma mapping/unmapping. With all the caching in the 
>>> network
>>> stack, some pages may be held in the network stack without returning 
>>> to the
>>> page_pool soon enough, and with VF disable causing the driver 
>>> unbound, the
>>> page_pool does not stop the driver from doing it's unbounding work, 
>>> instead
>>> page_pool uses workqueue to check if there is some pages coming back 
>>> from the
>>> network stack periodically, if there is any, it will do the dma 
>>> unmmapping
>>> related cleanup work.
>>
>> OK, that sounds like a more insidious problem - it's not just IOMMU 
>> stuff, in general the page pool should not be holding and using the 
>> device pointer after the device has already been destroyed. Even 
>> without an IOMMU, attempting DMA unmaps after the driver has already 
>> unbound may leak resources or at worst corrupt memory. Fundamentally, 
>> the page pool code cannot allow DMA mappings to outlive the driver 
>> they belong to.
>>
>> Thanks,
>> Robin.
>>
> I found a easier way to reproduce the problem:
> 1. enable a vf
> 2. use mz to send only one of the multiple fragments
> 3. disable the vf in 30 seconds
> 
> Jakub's patch:
> https://lore.kernel.org/netdev/20240809205717.0c966bad@kernel.org/T/
> can solve this case, but can not solve the origin case.
> 
> Base on the simple case, I found that v6.9 has no problem, v6.10-rc1 
> introduce the problem.

No, just because you don't see this particular crash symptom doesn't 
mean the fundamental issue isn't still there. Besides, Matthew already 
said he reproduced it on s390 back to v6.7 (and with the old DMA API 
implementation before then I think it wouldn't have crashed, but would 
have still leaked the hypervisor DMA mappings).

> And I trace the differences between the two version:
> v6.9: 
> page_pool_return_page()->dma_unmap_page_attrs()->*dma_direct_unmap_page()*
> v6.10-rc1: 
> page_pool_return_page()->dma_unmap_page_attrs()->*iommu_dma_unmap_page()*
> That's because in v6.9 dev->dma_ops is NULL and v6.10-rc1 doesn't. (The 
> driver has already unbound, but the device is still there)
> 
> I revert the patch:
> https://lore.kernel.org/linux-arm-kernel/4a4482a0-4408-4d86-9f61-6589ab78686b@somainline.org/T/
> then the bug I report can not reproduce.
> 
> So maybe this problem is introduced by this patch or the following patch 
> set?

That patch fixes a bug. Reintroducing that bug and breaking probe 
deferral on arm64 to attempt to paper over a design flaw in the page 
pool code is clearly not a reasonable course of action.

> https://lore.kernel.org/linux-iommu/cover.1713523152.git.robin.murphy@arm.com/
> or the page pool always has the problem: In the version before v6.9, and 
> in this case, page pool use iommu_dma_map_page() and 
> dma_direct_unmap_page(), not pair?

OK, do you start to see the problem there? If you got an address from 
vmalloc() and passed it to free_pages() would you expect that to work 
either? Sure, with enough luck on a cache-coherent system you may have 
been getting away with dma_direct_unmap_page() being largely a no-op, 
but if the arbitrary IOVA DMA address from iommu-dma happens to look 
like a SWIOTLB DMA address to dma-direct, that could be much more fun.

Thanks,
Robin.

