Return-Path: <netdev+bounces-163893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDB2A2BF8F
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6B718859E9
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 09:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD521DDC0D;
	Fri,  7 Feb 2025 09:38:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F70E1A2381;
	Fri,  7 Feb 2025 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738921132; cv=none; b=MMebTlJ8RElK4wrbOqRiDmE+ckw1XdIoyRjqk48kwCHIu00oOc3CpeESEzSXlg/x7vTBUgs0hHlfYgu3O9hagpT81ms1m5wjGT8HG/QrlEPeVDxLSPNWG5NyaF4remRbOMIQlSynyu2ft7XFKH9QpGiBfTg+tobnvT8jcYY46ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738921132; c=relaxed/simple;
	bh=dt92bHyl2tynQjJzTBjAbRIq6vr6MS2jUp3orFYczIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ge7JQ3sNBXhQez+CCPHtdZP4Cs80etTH+K+RG5qnXwXwb/83eyOcnosR5hHMh3PXMCQSU1q+yPXTFqhm+am05gTTowDif/f8No9xqmKxs0O/1yPxmV0UqB/pJIvOEp8n5y4Fq3+PpVu4TanAOhbVPcxWS9Y1PjP8k44HZ3UxNLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Yq81v021gz1W5DK;
	Fri,  7 Feb 2025 17:34:27 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C57B18032F;
	Fri,  7 Feb 2025 17:38:47 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Feb 2025 17:38:46 +0800
Message-ID: <ebddfc6b-4d1d-425b-9d20-8b912df36000@huawei.com>
Date: Fri, 7 Feb 2025 17:38:41 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v8 3/5] page_pool: fix IOMMU crash when driver has already
 unbound
To: Mina Almasry <almasrymina@google.com>, Yunsheng Lin
	<yunshenglin0825@gmail.com>
CC: Christoph Hellwig <hch@infradead.org>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <zhangkun09@huawei.com>,
	<liuyonglong@huawei.com>, <fanghaiqing@huawei.com>, Robin Murphy
	<robin.murphy@arm.com>, Alexander Duyck <alexander.duyck@gmail.com>, IOMMU
	<iommu@lists.linux.dev>, Andrew Morton <akpm@linux-foundation.org>, Eric
 Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20250127025734.3406167-1-linyunsheng@huawei.com>
 <20250127025734.3406167-4-linyunsheng@huawei.com>
 <Z5h1OMgcHuPSMaHM@infradead.org>
 <c4b8f494-1928-4cf6-afe2-61ab1ac7e641@gmail.com>
 <CAHS8izO5_=w4x8rhnHujCWQn7nhEDzaNGgJSrcZEwOQ+dN_o3w@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAHS8izO5_=w4x8rhnHujCWQn7nhEDzaNGgJSrcZEwOQ+dN_o3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/2/7 0:54, Mina Almasry wrote:
> On Tue, Feb 4, 2025 at 6:23 AM Yunsheng Lin <yunshenglin0825@gmail.com> wrote:
>>
>> On 1/28/2025 2:12 PM, Christoph Hellwig wrote:
>>> On Mon, Jan 27, 2025 at 10:57:32AM +0800, Yunsheng Lin wrote:
>>>> Note, the devmem patchset seems to make the bug harder to fix,
>>>> and may make backporting harder too. As there is no actual user
>>>> for the devmem and the fixing for devmem is unclear for now,
>>>> this patch does not consider fixing the case for devmem yet.
>>>
>>> Is there another outstanding patchet?  Or do you mean the existing
>>> devmem code already merged?  If that isn't actually used it should
>>> be removed, but otherwise you need to fix it.
>>
>> The last time I checked, only the code for networking stack supporting
>> the devmem had been merged.
>>
>> The first driver suppporting seems to be bnxt, which seems to be under
>> review:
>> https://lore.kernel.org/all/20241022162359.2713094-1-ap420073@gmail.com/
>>
>> As my understanding, this should work for the devmem too if the devmem
> 
>>From a quick look at this patch, it looks like you're handling
> netmem/net_iovs in the implementation, so this implementation is
> indeed considering netmem. I think the paragraph in the commit message
> that Christoph is responding to should be deleted, because in recent
> iterations you're handling netmem.
> 
>> provide a ops to do the per-netmem dma unmapping
>> It would be good that devmem people can have a look at it and see if
>> this fix works for the specific page_pool mp provider.
>>
> 
> We set pool->dma_map==false for memory providers that do not need
> mapping/unmapping, which you are checking in
> __page_pool_release_page_dma.

In page_pool_item_unmap(), it will return early when pool->mp_priv is
set no matter pool->dma_map is set or not, that was why I had the above
paragraph in the commit message.

The question seems to be about whether net_devmem_unbind_dmabuf() might
be called after driver has already unbound as it seems to be doing the
DMA unmapping operation based on the device of netdev->dev.parent, and
page_pool doesn't seems to have direct calling of net_devmem_unbind_dmabuf()
related API.

I am not able to find who and where is seting the netdev->dev.parent, but
I guess the DMA API is also not allowed to be called on the device of
netdev->dev.parent when the networking driver has unbound?

> 

