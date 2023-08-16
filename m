Return-Path: <netdev+bounces-28063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F00277E1CB
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A029F1C21067
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 12:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77027101FD;
	Wed, 16 Aug 2023 12:42:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF55322A
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 12:42:50 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBB526B7;
	Wed, 16 Aug 2023 05:42:47 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RQnlP6dRdzFqcj;
	Wed, 16 Aug 2023 20:39:45 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 20:42:43 +0800
Subject: Re: [PATCH net-next v7 2/6] page_pool: unify frag_count handling in
 page_pool_is_last_frag()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>, Liang Chen
	<liangchen.linux@gmail.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Maryam Tahhan <mtahhan@redhat.com>
References: <20230816100113.41034-1-linyunsheng@huawei.com>
 <20230816100113.41034-3-linyunsheng@huawei.com>
 <CAC_iWjLgDii_Y0p38w+Xs-nVb9uENG_-WyN7YTxxG5m7kn=bcQ@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <874b2a66-01db-423a-fe0f-17643f3db02a@huawei.com>
Date: Wed, 16 Aug 2023 20:42:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAC_iWjLgDii_Y0p38w+Xs-nVb9uENG_-WyN7YTxxG5m7kn=bcQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/8/16 19:30, Ilias Apalodimas wrote:
> On Wed, 16 Aug 2023 at 13:04, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> Currently when page_pool_create() is called with
>> PP_FLAG_PAGE_FRAG flag, page_pool_alloc_pages() is only
>> allowed to be called under the below constraints:
>> 1. page_pool_fragment_page() need to be called to setup
>>    page->pp_frag_count immediately.
>> 2. page_pool_defrag_page() often need to be called to drain
>>    the page->pp_frag_count when there is no more user will
>>    be holding on to that page.
>>
>> Those constraints exist in order to support a page to be
>> split into multi frags.
>>
>> And those constraints have some overhead because of the
>> cache line dirtying/bouncing and atomic update.
>>
>> Those constraints are unavoidable for case when we need a
>> page to be split into more than one frag, but there is also
>> case that we want to avoid the above constraints and their
>> overhead when a page can't be split as it can only hold a big
>> frag as requested by user, depending on different use cases:
>> use case 1: allocate page without page splitting.
>> use case 2: allocate page with page splitting.
>> use case 3: allocate page with or without page splitting
>>             depending on the frag size.
>>
>> Currently page pool only provide page_pool_alloc_pages() and
>> page_pool_alloc_frag() API to enable the 1 & 2 separately,
>> so we can not use a combination of 1 & 2 to enable 3, it is
>> not possible yet because of the per page_pool flag
>> PP_FLAG_PAGE_FRAG.
>>
> 
> I really think we are inventing problems to solve here.
> What would be more useful here would be an example with numbers.  Most
> of what you mention are true, but what % of the packets would split a
> page in a way that the remaining part cant be used is unknown.  Do you
> have a usecase in the hns3 driver?  Are there any numbers that justify
> the change?

There is no usecase for the hns3 driver yet.

As mentioned in the cover letter, there are usecases for veth and virtio_net
to use both frag page and non frag page in order to have the best performance
with the least memory depending on the head/tail room space for xdp_frame/shinfo
and mtu/packet size.

For virtio_net case:
I am guessing that allocating the non frag page has some advantage in some
case and allocating frag page has some advantage in other case, that
is why there is module param for the switching between those two mode.
It would be good that Liang Chen can help to confirm the gusessing with some
data.

For veth case:
It would be good that Maryam(cc) can help to do some testing to justify the
change as suggested by Jesper.


For iavf case, Alexander Lobakin mentioned some data in below disscusion:
https://patchwork.kernel.org/project/netdevbpf/patch/20230612130256.4572-5-linyunsheng@huawei.com/#25384716

> 


