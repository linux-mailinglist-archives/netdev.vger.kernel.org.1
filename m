Return-Path: <netdev+bounces-120018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E99C957F39
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 09:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6421C23A15
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 07:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481E314EC50;
	Tue, 20 Aug 2024 07:18:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9B2179A7;
	Tue, 20 Aug 2024 07:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724138309; cv=none; b=AkXZ2mEzVYkZXEQiYOHubPHx0EgyFnUUJDYsO2etS28gkqpQfInpbx6aQTWRpM4sCWRrMwankapJ2oUhSEKsemJkbLJnRiCi/kr+5tEd7getJD73IrC7mhhFP/cy4Fb/nh03ILxjvdf1ByPooFZEbb/X0ZDsO4otTD0tqYsFF4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724138309; c=relaxed/simple;
	bh=9bplCARZ+J/ETs6+wk14S8Wh1vJdJFxm/J7KEV3c2NM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NN1AQXthLvucVWY0XjU9OI+d/B8SCQXsbvH8iSFjjQJyPhb4PcJRrIQ7ndsDvGhYmg8kRNxH+fsZsAjwOCBTMd4w/p4RMBs6SygRCqpk+d5f6KB5QCpOedD4Y+tTFLcXkW5fNwlMFJP0i43+GjKPVNyB49OiUh8HcN61bY5eWdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Wp15106g1z13Spy;
	Tue, 20 Aug 2024 15:17:41 +0800 (CST)
Received: from kwepemf200007.china.huawei.com (unknown [7.202.181.233])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E48C1400FD;
	Tue, 20 Aug 2024 15:18:18 +0800 (CST)
Received: from [10.67.121.184] (10.67.121.184) by
 kwepemf200007.china.huawei.com (7.202.181.233) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 20 Aug 2024 15:18:17 +0800
Message-ID: <775234bc-84a2-458b-b047-ff6ab2607989@huawei.com>
Date: Tue, 20 Aug 2024 15:18:16 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG REPORT]net: page_pool: kernel crash at
 iommu_get_dma_domain+0xc/0x20
To: Robin Murphy <robin.murphy@arm.com>, Yunsheng Lin
	<linyunsheng@huawei.com>, Somnath Kotur <somnath.kotur@broadcom.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<pabeni@redhat.com>, <ilias.apalodimas@linaro.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>, "shenjian (K)" <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>, <joro@8bytes.org>, <will@kernel.org>,
	<iommu@lists.linux.dev>
References: <0e54954b-0880-4ebc-8ef0-13b3ac0a6838@huawei.com>
 <8743264a-9700-4227-a556-5f931c720211@huawei.com>
 <e980d20f-ea8a-43e3-8d3f-179a269b5956@kernel.org>
 <CAOBf=musxZcjYNHjdD+MGp0y6epnNO5ryC6JgeAJbP6YQ+sVUA@mail.gmail.com>
 <ad84acd2-36ba-433c-bdf7-c16c0d992e1c@huawei.com>
 <190d5a15-d6bf-47d6-be86-991853b7b51d@arm.com>
 <5b0415ff-9bbe-4553-89d6-17d12fd44b47@huawei.com>
 <ae995d55-daa9-4060-85fa-31b4f725a17d@arm.com>
Content-Language: en-US
From: Yonglong Liu <liuyonglong@huawei.com>
In-Reply-To: <ae995d55-daa9-4060-85fa-31b4f725a17d@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf200007.china.huawei.com (7.202.181.233)


On 2024/8/6 20:50, Robin Murphy wrote:
> On 06/08/2024 12:54 pm, Yunsheng Lin wrote:
>> On 2024/8/5 20:53, Robin Murphy wrote:
>>>>>>
>>>>>> The page_pool bumps refcnt via get_device() + put_device() on the 
>>>>>> DMA
>>>>>> 'struct device', to avoid it going away, but I guess there is 
>>>>>> also some
>>>>>> IOMMU code that we need to make sure doesn't go away (until all 
>>>>>> inflight
>>>>>> pages are returned) ???
>>>>
>>>> I guess the above is why thing went wrong here, the question is which
>>>> IOMMU code need to be called here to stop them from going away.
>>>
>>> This looks like the wrong device is being passed to dma_unmap_page() 
>>> - if a device had an IOMMU DMA domain at the point when the DMA 
>>> mapping was create, then neither that domain nor its group can 
>>> legitimately have disappeared while that device still had a driver 
>>> bound. Or if it *was* the right device, but it's already had 
>>> device_del() called on it, then you have a fundamental lifecycle 
>>> problem - a device with no driver bound should not be passed to the 
>>> DMA API, much less a dead device that's already been removed from 
>>> its parent bus.
>>
>> Yes, the device *was* the right device, And it's already had 
>> device_del()
>> called on it.
>> page_pool tries to call get_device() on the DMA 'struct device' to 
>> avoid the
>> above lifecycle problem, it seems get_device() does not stop 
>> device_del()
>> from being called, and that is where we have the problem here:
>> https://elixir.bootlin.com/linux/v6.11-rc2/source/net/core/page_pool.c#L269 
>>
>>
>> The above happens because driver with page_pool support may hand over
>> page still with dma mapping to network stack and try to reuse that page
>> after network stack is done with it and passes it back to page_pool 
>> to avoid
>> the penalty of dma mapping/unmapping. With all the caching in the 
>> network
>> stack, some pages may be held in the network stack without returning 
>> to the
>> page_pool soon enough, and with VF disable causing the driver 
>> unbound, the
>> page_pool does not stop the driver from doing it's unbounding work, 
>> instead
>> page_pool uses workqueue to check if there is some pages coming back 
>> from the
>> network stack periodically, if there is any, it will do the dma 
>> unmmapping
>> related cleanup work.
>
> OK, that sounds like a more insidious problem - it's not just IOMMU 
> stuff, in general the page pool should not be holding and using the 
> device pointer after the device has already been destroyed. Even 
> without an IOMMU, attempting DMA unmaps after the driver has already 
> unbound may leak resources or at worst corrupt memory. Fundamentally, 
> the page pool code cannot allow DMA mappings to outlive the driver 
> they belong to.
>
> Thanks,
> Robin.
>
I found a easier way to reproduce the problem:
1. enable a vf
2. use mz to send only one of the multiple fragments
3. disable the vf in 30 seconds

Jakub's patch:
https://lore.kernel.org/netdev/20240809205717.0c966bad@kernel.org/T/
can solve this case, but can not solve the origin case.

Base on the simple case, I found that v6.9 has no problem, v6.10-rc1 
introduce the problem.
And I trace the differences between the two version:
v6.9: 
page_pool_return_page()->dma_unmap_page_attrs()->*dma_direct_unmap_page()*
v6.10-rc1: 
page_pool_return_page()->dma_unmap_page_attrs()->*iommu_dma_unmap_page()*
That's because in v6.9 dev->dma_ops is NULL and v6.10-rc1 doesn't. (The 
driver has already unbound, but the device is still there)

I revert the patch:
https://lore.kernel.org/linux-arm-kernel/4a4482a0-4408-4d86-9f61-6589ab78686b@somainline.org/T/
then the bug I report can not reproduce.

So maybe this problem is introduced by this patch or the following patch 
set?
https://lore.kernel.org/linux-iommu/cover.1713523152.git.robin.murphy@arm.com/
or the page pool always has the problem: In the version before v6.9, and 
in this case, page pool use iommu_dma_map_page() and 
dma_direct_unmap_page(), not pair?

