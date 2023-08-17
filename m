Return-Path: <netdev+bounces-28356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3A577F2B6
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 11:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22268281E2A
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7B3100B2;
	Thu, 17 Aug 2023 09:05:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2EDE56C
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 09:05:49 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7871E7C;
	Thu, 17 Aug 2023 02:05:47 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RRJtZ5Mj7zFr28;
	Thu, 17 Aug 2023 17:02:46 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 17 Aug
 2023 17:05:45 +0800
Subject: Re: [PATCH net-next v6 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>, Liang Chen
	<liangchen.linux@gmail.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Eric Dumazet <edumazet@google.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, <linux-rdma@vger.kernel.org>
References: <20230814125643.59334-1-linyunsheng@huawei.com>
 <20230814125643.59334-2-linyunsheng@huawei.com>
 <CAC_iWjKMLoUu4bctrWtK46mpyhQ7LoKe4Nm2t8jZVMM0L9O2xA@mail.gmail.com>
 <06e89203-9eaf-99eb-99de-e5209819b8b3@huawei.com>
 <CAC_iWjJ4Pi7Pj9Rm13y4aXBB3RsP9pTsfRf_A-OraXKwaO_xGA@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <b71d5f5f-0ea1-3a35-8c90-53ef4ae27e79@huawei.com>
Date: Thu, 17 Aug 2023 17:05:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAC_iWjJ4Pi7Pj9Rm13y4aXBB3RsP9pTsfRf_A-OraXKwaO_xGA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/8/17 1:01, Ilias Apalodimas wrote:
> On Wed, 16 Aug 2023 at 15:49, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2023/8/16 19:26, Ilias Apalodimas wrote:
>>> Hi Yunsheng
>>>
>>> On Mon, 14 Aug 2023 at 15:59, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>>>
>>>> Currently page_pool_alloc_frag() is not supported in 32-bit
>>>> arch with 64-bit DMA because of the overlap issue between
>>>> pp_frag_count and dma_addr_upper in 'struct page' for those
>>>> arches, which seems to be quite common, see [1], which means
>>>> driver may need to handle it when using frag API.
>>>
>>> That wasn't so common. IIRC it was a single TI platform that was breaking?
>>
>> I am not so sure about that as grepping 'ARM_LPAE' has a long
>> list for that.
> 
> Shouldn't we be grepping for CONFIG_ARCH_DMA_ADDR_T_64BIT and
> PHYS_ADDR_T_64BIT to find the affected platforms?  Why LPAE?


I used the key in the  original report:

https://www.spinics.net/lists/netdev/msg779890.html

>> Please see the bisection report below about a boot failure on
>> rk3288-rock2-square which is pointing to this patch.  The issue
>> appears to only happen with CONFIG_ARM_LPAE=y.

grepping the 'CONFIG_PHYS_ADDR_T_64BIT' seems to be more common?
https://elixir.free-electrons.com/linux/v6.4-rc6/K/ident/CONFIG_PHYS_ADDR_T_64BIT

> 
>>
>>>
>>>>
>>>> In order to simplify the driver's work when using frag API
>>>> this patch allows page_pool_alloc_frag() to call
>>>> page_pool_alloc_pages() to return pages for those arches.
>>>
>>> Do we have any use cases of people needing this?  Those architectures
>>> should be long dead and although we have to support them in the
>>> kernel,  I don't personally see the advantage of adjusting the API to
>>> do that.  Right now we have a very clear separation between allocating
>>> pages or fragments.   Why should we hide a page allocation under a
>>> frag allocation?  A driver writer can simply allocate pages for those
>>> boards.  Am I the only one not seeing a clean win here?
>>
>> It is also a part of removing the per page_pool PP_FLAG_PAGE_FRAG flag
>> in this patchset.
> 
> Yes, that happens *because* of this patchset.  I am not against the
> change.  In fact, I'll have a closer look tomorrow.  I am just trying
> to figure out if we really need it.  When the recycling patches were
> introduced into page pool we had a very specific reason.  Due to the
> XDP verifier we *had* to allocate a packet per page.  That was

Did you mean a xdp frame containing a frag page can not be passed to the
xdp core?
What is exact reason why the XDP verifier need a packet per page?
Is there a code block that you can point me to?

I wonder if it is still the case for now, as bnxt and mlx5 seems to be
supporting frag page and xdp now.

> expensive so we added the recycling capabilities to compensate and get
> some performance back. Eventually we added page fragments and had a
> very clear separation on the API.
> 
> Regards
> /Ilias
>>
>>>
>>> Thanks
>>> /Ilias
>>>
> .
> 

