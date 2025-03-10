Return-Path: <netdev+bounces-173532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E838A594A1
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 13:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 057EC1886FDA
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83BB225416;
	Mon, 10 Mar 2025 12:35:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E732248BA
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741610136; cv=none; b=ip0eCl0RHJkULXcnQiT8A+u3TUOpb6Epks7T/bYSSxgO2tJMUwkYD0RNkb025j4oNyWRNLYHyXNB0lcuUzAOCq7U7aN5lz3V+ko524Iezsq7xCoD+tOKVUVy+TqrwYZreMvfyFXXNXQQnolgcQ5VkEzQFq7xjs4vQSE6Dd4r/Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741610136; c=relaxed/simple;
	bh=UkkzVh5I/8aUoMUHeAe49dD5z8jvVpTrDLcH2ks0tTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mke4keCDw42CuBrZ3obCfdu/uGjAkZowYvt2Mjc5LciPaRmO0aQYmrJAooBbY+npJo95W3s7IgCbkI03xn1Fl91i72nUTn84w6eQomck1GrTZ6l0qDNJA4IbFyLDZT/xQMHTQX6/mWrFap6UmFZmkZ21p3ZSwxYYq+QEthOago0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZBGXp4VB2zqVYD;
	Mon, 10 Mar 2025 20:34:02 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 423121400CA;
	Mon, 10 Mar 2025 20:35:32 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Mar 2025 20:35:31 +0800
Message-ID: <2c363f6a-f9e4-4dd2-941d-db446c501885@huawei.com>
Date: Mon, 10 Mar 2025 20:35:31 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] page_pool: Track DMA-mapped pages and unmap
 them when destroying the pool
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, Yunsheng
 Lin <yunshenglin0825@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>
CC: Yonglong Liu <liuyonglong@huawei.com>, Mina Almasry
	<almasrymina@google.com>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <linux-mm@kvack.org>, <netdev@vger.kernel.org>
References: <20250308145500.14046-1-toke@redhat.com>
 <d84e19c9-be0c-4d23-908b-f5e5ab6f3f3f@gmail.com> <87cyepxn7n.fsf@toke.dk>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <87cyepxn7n.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/3/10 17:13, Toke Høiland-Jørgensen wrote:

...

> 
>> Also, we might need a similar locking or synchronisation for the dma
>> sync API in order to skip the dma sync API when page_pool_destroy() is
>> called too.
> 
> Good point, but that seems a separate issue? And simpler to solve (just

If I understand the comment from DMA experts correctly, the dma_sync API
should not be allowed to be called after the dma_unmap API.

> set pool->dma_sync to false when destroying?).

Without locking or synchronisation, there is some small window between
pool->dma_sync checking and dma sync API calling, during which the driver
might have already unbound.

> 
>>> To avoid having to walk the entire xarray on unmap to find the page
>>> reference, we stash the ID assigned by xa_alloc() into the page
>>> structure itself, in the field previously called '_pp_mapping_pad' in
>>> the page_pool struct inside struct page. This field overlaps with the
>>> page->mapping pointer, which may turn out to be problematic, so an
>>> alternative is probably needed. Sticking the ID into some of the upper
>>> bits of page->pp_magic may work as an alternative, but that requires
>>> further investigation. Using the 'mapping' field works well enough as
>>> a demonstration for this RFC, though.
>> page->pp_magic seems to only have 16 bits space available at most when
>> trying to reuse some unused bits in page->pp_magic, as BPF_PTR_POISON
>> and STACK_DEPOT_POISON seems to already use 16 bits, so:
>> 1. For 32 bits system, it seems there is only 16 bits left even if the
>>     ILLEGAL_POINTER_VALUE is defined as 0x0.
>> 2. For 64 bits system, it seems there is only 12 bits left for powerpc
>>     as ILLEGAL_POINTER_VALUE is defined as 0x5deadbeef0000000, see
>>     arch/powerpc/Kconfig.
>>
>> So it seems we might need to limit the dma mapping count to 4096 or
>> 65536?
>>
>> And to be honest, I am not sure if those 'unused' 12/16 bits can really 
>> be reused or not, I guess we might need suggestion from mm and arch
>> experts here.
> 
> Why do we need to care about BPF_PTR_POISON and STACK_DEPOT_POISON?
> AFAICT, we only need to make sure we preserve the PP_SIGNATURE value.
> See v2 of the RFC patch, the bit arithmetic there gives me:
> 
> - 24 bits on 32-bit architectures
> - 21 bits on PPC64 (because of the definition of ILLEGAL_POINTER_VALUE)
> - 32 bits on other 64-bit architectures
> 
> Which seems to be plenty?

I am really doubtful it is that simple, but we always can hear from the
experts if it isn't:)

> 
>>> Since all the tracking is performed on DMA map/unmap, no additional code
>>> is needed in the fast path, meaning the performance overhead of this
>>> tracking is negligible. The extra memory needed to track the pages is
>>> neatly encapsulated inside xarray, which uses the 'struct xa_node'
>>> structure to track items. This structure is 576 bytes long, with slots
>>> for 64 items, meaning that a full node occurs only 9 bytes of overhead
>>> per slot it tracks (in practice, it probably won't be this efficient,
>>> but in any case it should be an acceptable overhead).
>>
>> Even if items is stored sequentially in xa_node at first, is it possible
>> that there may be fragmentation in those xa_node when pages are released
>> and allocated many times during packet processing? If yes, is there any
>> fragmentation info about those xa_node?
> 
> Some (that's what I mean with "not as efficient"). AFAICT, xa_array does
> do some rebalancing of the underlying radix tree, freeing nodes when
> they are no longer used. However, I am not too familiar with the xarray
> code, so I don't know exactly how efficient this is in practice.

I guess that is one of the disadvantages that an advanced struct like
Xarray is used:(

> 

