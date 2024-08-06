Return-Path: <netdev+bounces-116062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2570A948E2E
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C383E1F22178
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 11:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B421C379B;
	Tue,  6 Aug 2024 11:54:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB051BDA83;
	Tue,  6 Aug 2024 11:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722945280; cv=none; b=G0jF8fh+c+6sDHavkvMFcQmn6p1pXk61HPk9/oIBJ7nYNOINp39L/2QjdDGlu6YHW26mot5CKR+imWS/1alP6zDNIi6MFigMYU1fXh7emTWd100JB3MUXKue4FB1ZFzkWQrfbT8ztGEH14dWGN3CHO+rDcbqFzCb5ds99dYkl78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722945280; c=relaxed/simple;
	bh=Yykmez3ZYSmGq8BR/9ZQu5BlXfIo1K5NXYINP8pOyh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j8pI2Q4LJF+uycX6VBx4YPN7DHeJTLPvjqjittoXcpRoX5SCw2c5h5vB5hXfBSCQCVlQvuYXT6yMAg3HrpFN4tvwfHwXTL34UchAIdlDrVZ8WafWEUa+/mrp8FvIPIral+NX4r2YO5sRa1Th8nXHUdKDF/JBDR+xBTEm+5py7aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WdWnq70VFzQp2C;
	Tue,  6 Aug 2024 19:50:07 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 9DA501800A0;
	Tue,  6 Aug 2024 19:54:33 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 6 Aug 2024 19:54:33 +0800
Message-ID: <5b0415ff-9bbe-4553-89d6-17d12fd44b47@huawei.com>
Date: Tue, 6 Aug 2024 19:54:33 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG REPORT]net: page_pool: kernel crash at
 iommu_get_dma_domain+0xc/0x20
To: Robin Murphy <robin.murphy@arm.com>, Somnath Kotur
	<somnath.kotur@broadcom.com>, Jesper Dangaard Brouer <hawk@kernel.org>
CC: Yonglong Liu <liuyonglong@huawei.com>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, <pabeni@redhat.com>,
	<ilias.apalodimas@linaro.org>, <netdev@vger.kernel.org>,
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
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <190d5a15-d6bf-47d6-be86-991853b7b51d@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/8/5 20:53, Robin Murphy wrote:
>>>>
>>>> The page_pool bumps refcnt via get_device() + put_device() on the DMA
>>>> 'struct device', to avoid it going away, but I guess there is also some
>>>> IOMMU code that we need to make sure doesn't go away (until all inflight
>>>> pages are returned) ???
>>
>> I guess the above is why thing went wrong here, the question is which
>> IOMMU code need to be called here to stop them from going away.
> 
> This looks like the wrong device is being passed to dma_unmap_page() - if a device had an IOMMU DMA domain at the point when the DMA mapping was create, then neither that domain nor its group can legitimately have disappeared while that device still had a driver bound. Or if it *was* the right device, but it's already had device_del() called on it, then you have a fundamental lifecycle problem - a device with no driver bound should not be passed to the DMA API, much less a dead device that's already been removed from its parent bus.

Yes, the device *was* the right device, And it's already had device_del()
called on it.
page_pool tries to call get_device() on the DMA 'struct device' to avoid the
above lifecycle problem, it seems get_device() does not stop device_del()
from being called, and that is where we have the problem here:
https://elixir.bootlin.com/linux/v6.11-rc2/source/net/core/page_pool.c#L269

The above happens because driver with page_pool support may hand over
page still with dma mapping to network stack and try to reuse that page
after network stack is done with it and passes it back to page_pool to avoid
the penalty of dma mapping/unmapping. With all the caching in the network
stack, some pages may be held in the network stack without returning to the
page_pool soon enough, and with VF disable causing the driver unbound, the
page_pool does not stop the driver from doing it's unbounding work, instead
page_pool uses workqueue to check if there is some pages coming back from the
network stack periodically, if there is any, it will do the dma unmmapping
related cleanup work.

> 
> Thanks,
> Robin.
> 
> 

