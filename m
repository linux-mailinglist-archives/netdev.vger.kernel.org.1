Return-Path: <netdev+bounces-47726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1027EB0B9
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 14:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D821C20444
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 13:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3913FE44;
	Tue, 14 Nov 2023 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B2722326
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 13:19:32 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA8419F;
	Tue, 14 Nov 2023 05:19:30 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SV6MN0dHQzvQWh;
	Tue, 14 Nov 2023 21:19:12 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 14 Nov
 2023 21:19:27 +0800
Subject: Re: [PATCH RFC 3/8] memory-provider: dmabuf devmem memory provider
To: Mina Almasry <almasrymina@google.com>
CC: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Willem de Bruijn <willemb@google.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric
 Dumazet <edumazet@google.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
	<christian.koenig@amd.com>, Jason Gunthorpe <jgg@nvidia.com>, Matthew Wilcox
	<willy@infradead.org>, Linux-MM <linux-mm@kvack.org>
References: <20231113130041.58124-1-linyunsheng@huawei.com>
 <20231113130041.58124-4-linyunsheng@huawei.com>
 <CAHS8izMjmj0DRT_vjzVq5HMQyXtZdVK=o4OP0gzbaN=aJdQ3ig@mail.gmail.com>
 <20231113180554.1d1c6b1a@kernel.org>
 <0c39bd57-5d67-3255-9da2-3f3194ee5a66@huawei.com>
 <CAHS8izNxkqiNbTA1y+BjQPAber4Dks3zVFNYo4Bnwc=0JLustA@mail.gmail.com>
 <fa5d2f4c-5ccc-e23e-1926-2d7625b66b91@huawei.com>
 <CAHS8izMj_89dMVaMr73r1-3Kewgc1YL3A1mjvixoax2War8kUg@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <3ff54a20-7e5f-562a-ca2e-b078cc4b4120@huawei.com>
Date: Tue, 14 Nov 2023 21:19:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHS8izMj_89dMVaMr73r1-3Kewgc1YL3A1mjvixoax2War8kUg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

On 2023/11/14 20:58, Mina Almasry wrote:

>>
>> Yes, as above, skb_frags_not_readable() checking is still needed for
>> kmap() and page_address().
>>
>> get_page, put_page related calling is avoided in page_pool_frag_ref()
>> and napi_pp_put_page() for devmem page as the above checking is true
>> for devmem page:
>> (pp_iov->pp_magic & ~0x3UL) == PP_SIGNATURE
>>
> 
> So, devmem needs special handling with if statement for refcounting,
> even after using struct pages for devmem, which is not allowed (IIUC
> the dma-buf maintainer).

It reuses the already existing checking or optimization, that is the point
of 'mirror struct'.

> 
>>>
>>>> The main difference between this patchset and RFC v3:
>>>> 1. It reuses the 'struct page' to have more unified handling between
>>>>    normal page and devmem page for net stack.
>>>
>>> This is what was nacked in RFC v1.
>>>
>>>> 2. It relies on the page->pp_frag_count to do reference counting.
>>>>
>>>
>>> I don't see you change any of the page_ref_* calls in page_pool.c, for
>>> example this one:
>>>
>>> https://elixir.bootlin.com/linux/latest/source/net/core/page_pool.c#L601
>>>
>>> So the reference the page_pool is seeing is actually page->_refcount,
>>> not page->pp_frag_count? I'm confused here. Is this a bug in the
>>> patchset?
>>
>> page->_refcount is the same as page_pool_iov->_refcount for devmem, which
>> is ensured by the 'PAGE_POOL_MATCH(_refcount, _refcount);', and
>> page_pool_iov->_refcount is set to one in mp_dmabuf_devmem_alloc_pages()
>> by calling 'refcount_set(&ppiov->_refcount, 1)' and always remains as one.
>>
>> So the 'page_ref_count(page) == 1' checking is always true for devmem page.
> 
> Which, of course, is a bug in the patchset, and it only works because
> it's a POC for you. devmem pages (which shouldn't exist according to
> the dma-buf maintainer, IIUC) can't be recycled all the time. See
> SO_DEVMEM_DONTNEED patch in my RFC and refcounting needed for devmem.

I am not sure dma-buf maintainer's concern is still there with this patchset.

Whatever name you calling it for the struct, however you arrange each field
in the struct, some metadata is always needed for dmabuf to intergrate into
page pool.

If the above is true, why not utilize the 'struct page' to have more unified
handling?

> 

