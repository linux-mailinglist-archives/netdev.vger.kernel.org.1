Return-Path: <netdev+bounces-51984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D987FCD58
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 04:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07A27B21530
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 03:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3896525B;
	Wed, 29 Nov 2023 03:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F6219AD;
	Tue, 28 Nov 2023 19:17:53 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Sg4Cc5t3JzShPM;
	Wed, 29 Nov 2023 11:13:32 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 Nov
 2023 11:17:51 +0800
Subject: Re: [PATCH net-next v5 03/14] page_pool: avoid calling no-op
 externals when possible
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Christoph Hellwig
	<hch@lst.de>
CC: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Michal Kubiak
	<michal.kubiak@intel.com>, Larysa Zaremba <larysa.zaremba@intel.com>,
	Alexander Duyck <alexanderduyck@fb.com>, David Christensen
	<drc@linux.vnet.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Paul Menzel
	<pmenzel@molgen.mpg.de>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
 <20231124154732.1623518-4-aleksander.lobakin@intel.com>
 <6bd14aa9-fa65-e4f6-579c-3a1064b2a382@huawei.com>
 <a1a0c27f-f367-40e7-9dc2-9421b4b6379a@intel.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <534e7752-38a9-3e7e-cb04-65789712fb66@huawei.com>
Date: Wed, 29 Nov 2023 11:17:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a1a0c27f-f367-40e7-9dc2-9421b4b6379a@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

On 2023/11/27 22:32, Alexander Lobakin wrote:
> 
> Chris, any thoughts on a global flag for skipping DMA syncs ladder?

It seems there was one already in the past:

https://lore.kernel.org/netdev/7c55a4d7-b4aa-25d4-1917-f6f355bd722e@arm.com/T/

> 
>>
>>

>>> +static inline bool page_pool_set_dma_addr(const struct page_pool *pool,
>>> +					  struct page *page,
>>> +					  dma_addr_t addr)
>>>  {
>>> +	unsigned long val = addr;
>>> +
>>> +	if (unlikely(!addr)) {
>>> +		page->dma_addr = 0;
>>> +		return true;
>>> +	}
>>
>> The above seems unrelated change?
> 
> Related. We use page_put_set_dma_addr() to clear ::dma_addr as well
> (grep for it in page_pool.c). In this case, we don't want
> dma_need_sync() to be called as we explicitly pass zero. This check
> zeroes the field and exits as quickly as possible.

The question seems to be about if we need to ensure the LSB of
page->dma_addr is not set when page_pool releases a page back to page
allocator?

> In case with the call mentioned above, zero is a compile-time constant
> there, so that this little branch will be inlined with the rest dropped.
> 



