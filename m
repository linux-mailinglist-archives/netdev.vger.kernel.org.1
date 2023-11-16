Return-Path: <netdev+bounces-48287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 289087EDF37
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 12:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5518E1C20846
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 11:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9580F2D7A9;
	Thu, 16 Nov 2023 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8641991;
	Thu, 16 Nov 2023 03:10:04 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SWHKX3FJ1zsR46;
	Thu, 16 Nov 2023 19:06:40 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 16 Nov
 2023 19:10:01 +0800
Subject: Re: [PATCH RFC 3/8] memory-provider: dmabuf devmem memory provider
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Mina Almasry <almasrymina@google.com>, Jakub Kicinski <kuba@kernel.org>,
	<davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Willem de Bruijn <willemb@google.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric
 Dumazet <edumazet@google.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
	<christian.koenig@amd.com>, Matthew Wilcox <willy@infradead.org>, Linux-MM
	<linux-mm@kvack.org>
References: <20231113130041.58124-1-linyunsheng@huawei.com>
 <20231113130041.58124-4-linyunsheng@huawei.com>
 <CAHS8izMjmj0DRT_vjzVq5HMQyXtZdVK=o4OP0gzbaN=aJdQ3ig@mail.gmail.com>
 <20231113180554.1d1c6b1a@kernel.org>
 <0c39bd57-5d67-3255-9da2-3f3194ee5a66@huawei.com>
 <CAHS8izNxkqiNbTA1y+BjQPAber4Dks3zVFNYo4Bnwc=0JLustA@mail.gmail.com>
 <ZVNzS2EA4zQRwIQ7@nvidia.com>
 <ed875644-95e8-629a-4c28-bf42329efa56@huawei.com>
 <ZVTJ0/lm1oUDzzHe@nvidia.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <0a1cdd5a-c4c5-3d77-20a2-2beb8e3a6411@huawei.com>
Date: Thu, 16 Nov 2023 19:10:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZVTJ0/lm1oUDzzHe@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

On 2023/11/15 21:38, Jason Gunthorpe wrote:
> On Wed, Nov 15, 2023 at 05:21:02PM +0800, Yunsheng Lin wrote:
> 
>>>>> I would expect net stack, page pool, driver still see the 'struct page',
>>>>> only memory provider see the specific struct for itself, for the above,
>>>>> devmem memory provider sees the 'struct page_pool_iov'.
>>>>>
>>>>> The reason I still expect driver to see the 'struct page' is that driver
>>>>> will still need to support normal memory besides devmem.
>>>
>>> I wouldn't say this approach is unreasonable, but it does have to be
>>> done carefully to isolate the mm. Keeping the struct page in the API
>>> is going to make this very hard.
>>
>> I would expect that most of the isolation is done in page pool, as far as
>> I can see:
> 
> It is the sort of thing that is important enough it should have
> compiler help via types to prove that it is being done
> properly. Otherwise it will be full of mistakes over time.

Yes, agreed.

I have done something similar as willy has done for some of
folio conversion as below:

+#define PAGE_POOL_MATCH(pg, iov)				\
+	static_assert(offsetof(struct page, pg) ==		\
+		      offsetof(struct page_pool_iov, iov))
+PAGE_POOL_MATCH(flags, res0);
+PAGE_POOL_MATCH(pp_magic, pp_magic);
+PAGE_POOL_MATCH(pp, pp);
...

Not sure if we need to add new API for driver to use when the
driver need the devmem support yet.


> 
> Jason
> .
> 

