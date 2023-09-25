Return-Path: <netdev+bounces-36121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C9B7AD6FF
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 13:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A73F42810D5
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 11:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C99D18E1A;
	Mon, 25 Sep 2023 11:31:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7AF18E0B
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 11:31:44 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29ECC6;
	Mon, 25 Sep 2023 04:31:42 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RvLFz4vpqzNnnZ;
	Mon, 25 Sep 2023 19:27:51 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 25 Sep
 2023 19:31:40 +0800
Subject: Re: [PATCH net-next v8 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: Jesper Dangaard Brouer <jbrouer@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <brouer@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>, Liang Chen
	<liangchen.linux@gmail.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Guillaume Tucker
	<guillaume.tucker@collabora.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Linux-MM <linux-mm@kvack.org>, Matthew
 Wilcox <willy@infradead.org>, Mel Gorman <mgorman@techsingularity.net>
References: <20230912083126.65484-1-linyunsheng@huawei.com>
 <20230912083126.65484-2-linyunsheng@huawei.com>
 <84282e55-519c-0e17-30c5-b6de54d1001c@redhat.com>
 <15f95505-dba9-4afd-6980-5bdf0a64d507@huawei.com>
 <CAC_iWjL_u=R+UK-6rhnv=32qX2P9SY72LFu928Y64u11EVoOPQ@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <b0388db7-d4b2-443b-12f0-fbe6ae4002cd@huawei.com>
Date: Mon, 25 Sep 2023 19:31:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAC_iWjL_u=R+UK-6rhnv=32qX2P9SY72LFu928Y64u11EVoOPQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/9/25 18:37, Ilias Apalodimas wrote:
> Hi
> 
> On Wed, 20 Sept 2023 at 11:59, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2023/9/15 16:28, Jesper Dangaard Brouer wrote:
>>> Hi Lin,
>>>
>>> This looks reasonable, but given you are changing struct-page
>>> (include/linux/mm_types.h) we need to MM-list <linux-mm@kvack.org>.
>>> Also Cc Wilcox.
>>>
>>> I think it was Ilias and Duyck that validated the assumptions, last time
>>> this patch was discussed. Thus I want to see their review before this is
>>> applied.
>>
>> FWIW, PAGE_SIZE aligned buffer being PAGE_SIZE aligned in DMA is
>> validated by Duyck:
>> https://lore.kernel.org/all/CAKgT0UfeUAUQpEffxnkc+gzXsjOrHkuMgxU_Aw0VXSJYKzaovQ@mail.gmail.com/
>>
>> And I had done researching to find out there seems to be no combination of
>> the above arch with an address space >16TB:
>> https://lore.kernel.org/all/2b570282-24f8-f23b-1ff7-ad836794baa9@huawei.com/
> 
> Apologies for the late reply.  I just saw you sent a v9, I'll review
> that instead, but I am traveling right now, will take a while

Actually there is a newer v10, see:
https://lore.kernel.org/all/20230922091138.18014-2-linyunsheng@huawei.com/

Thanks for the time reviewing.

> 
> Thanks
> /Ilias


