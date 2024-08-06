Return-Path: <netdev+bounces-116077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62395948F7D
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 14:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D12F28290E
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 12:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF051C5786;
	Tue,  6 Aug 2024 12:50:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D231EB46;
	Tue,  6 Aug 2024 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722948613; cv=none; b=TgYX1hhQdI7KCJZKA7kcmxArMQfn96p1JbIG9eQvh/ZL0vLX3V9oBah+HOM04SmboNQJJDhxBXAwd8a9haWFL1i5TAOMxgZkxd8LXnSqPZMB0iUt2HCv+XCiDQLqOQknz54wZnPsQth9u4Dv9+H4xItLx3hy/UoeryD8HXPEY5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722948613; c=relaxed/simple;
	bh=qiB1pIDrpr161u3H5M6pgp7TwSMXFUJdUlIbecnDkGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OF/HXOrENiJ+v2Nunqzt8LW51orEYoyNv3N4JxYidpRoR7jVRH1Xw+Zk4CmG7OW59hqtBSzM6AFbfyhfto2qKiq2rbpm5vhW8AIhqUOYCn+0YedrKJnE6ejjnB4DJPFyyHH5I5Y7zkI+29/7iArLSlWYCIZrUnBRc1o+23j6Bfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22386FEC;
	Tue,  6 Aug 2024 05:50:37 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 704F73F766;
	Tue,  6 Aug 2024 05:50:09 -0700 (PDT)
Message-ID: <ae995d55-daa9-4060-85fa-31b4f725a17d@arm.com>
Date: Tue, 6 Aug 2024 13:50:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG REPORT]net: page_pool: kernel crash at
 iommu_get_dma_domain+0xc/0x20
To: Yunsheng Lin <linyunsheng@huawei.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Yonglong Liu <liuyonglong@huawei.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 pabeni@redhat.com, ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, "shenjian (K)" <shenjian15@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, joro@8bytes.org, will@kernel.org,
 iommu@lists.linux.dev
References: <0e54954b-0880-4ebc-8ef0-13b3ac0a6838@huawei.com>
 <8743264a-9700-4227-a556-5f931c720211@huawei.com>
 <e980d20f-ea8a-43e3-8d3f-179a269b5956@kernel.org>
 <CAOBf=musxZcjYNHjdD+MGp0y6epnNO5ryC6JgeAJbP6YQ+sVUA@mail.gmail.com>
 <ad84acd2-36ba-433c-bdf7-c16c0d992e1c@huawei.com>
 <190d5a15-d6bf-47d6-be86-991853b7b51d@arm.com>
 <5b0415ff-9bbe-4553-89d6-17d12fd44b47@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <5b0415ff-9bbe-4553-89d6-17d12fd44b47@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/08/2024 12:54 pm, Yunsheng Lin wrote:
> On 2024/8/5 20:53, Robin Murphy wrote:
>>>>>
>>>>> The page_pool bumps refcnt via get_device() + put_device() on the DMA
>>>>> 'struct device', to avoid it going away, but I guess there is also some
>>>>> IOMMU code that we need to make sure doesn't go away (until all inflight
>>>>> pages are returned) ???
>>>
>>> I guess the above is why thing went wrong here, the question is which
>>> IOMMU code need to be called here to stop them from going away.
>>
>> This looks like the wrong device is being passed to dma_unmap_page() - if a device had an IOMMU DMA domain at the point when the DMA mapping was create, then neither that domain nor its group can legitimately have disappeared while that device still had a driver bound. Or if it *was* the right device, but it's already had device_del() called on it, then you have a fundamental lifecycle problem - a device with no driver bound should not be passed to the DMA API, much less a dead device that's already been removed from its parent bus.
> 
> Yes, the device *was* the right device, And it's already had device_del()
> called on it.
> page_pool tries to call get_device() on the DMA 'struct device' to avoid the
> above lifecycle problem, it seems get_device() does not stop device_del()
> from being called, and that is where we have the problem here:
> https://elixir.bootlin.com/linux/v6.11-rc2/source/net/core/page_pool.c#L269
> 
> The above happens because driver with page_pool support may hand over
> page still with dma mapping to network stack and try to reuse that page
> after network stack is done with it and passes it back to page_pool to avoid
> the penalty of dma mapping/unmapping. With all the caching in the network
> stack, some pages may be held in the network stack without returning to the
> page_pool soon enough, and with VF disable causing the driver unbound, the
> page_pool does not stop the driver from doing it's unbounding work, instead
> page_pool uses workqueue to check if there is some pages coming back from the
> network stack periodically, if there is any, it will do the dma unmmapping
> related cleanup work.

OK, that sounds like a more insidious problem - it's not just IOMMU 
stuff, in general the page pool should not be holding and using the 
device pointer after the device has already been destroyed. Even without 
an IOMMU, attempting DMA unmaps after the driver has already unbound may 
leak resources or at worst corrupt memory. Fundamentally, the page pool 
code cannot allow DMA mappings to outlive the driver they belong to.

Thanks,
Robin.

