Return-Path: <netdev+bounces-47928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B42C47EBF89
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 10:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05EC7B20ACD
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 09:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE2B6AB3;
	Wed, 15 Nov 2023 09:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F5A611A
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 09:33:17 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279849B;
	Wed, 15 Nov 2023 01:33:16 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SVdHl2pfNzWh7S;
	Wed, 15 Nov 2023 17:32:51 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 15 Nov
 2023 17:33:14 +0800
Subject: Re: [PATCH RFC 3/8] memory-provider: dmabuf devmem memory provider
To: Jakub Kicinski <kuba@kernel.org>
CC: Mina Almasry <almasrymina@google.com>, <davem@davemloft.net>,
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
 <20231114172534.124f544c@kernel.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <56314b48-5273-6885-f3eb-5d60535faba0@huawei.com>
Date: Wed, 15 Nov 2023 17:33:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231114172534.124f544c@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

On 2023/11/15 6:25, Jakub Kicinski wrote:
> On Tue, 14 Nov 2023 16:23:29 +0800 Yunsheng Lin wrote:
>> I would expect net stack, page pool, driver still see the 'struct page',
>> only memory provider see the specific struct for itself, for the above,
>> devmem memory provider sees the 'struct page_pool_iov'.
> 
> You can't lie to the driver that an _iov is a page either.

Yes, agreed about that.

As a matter of fact, the driver should be awared of what kind of
memory provider is using when it calls page_pool_create() during
init process.

> The driver must explicitly "opt-in" to using the _iov variant,
> by calling the _iov set of APIs.
> 
> Only drivers which can support header-data split can reasonably
> use the _iov API, for data pages.

But those drivers can still allow allocating normal memory, right?
sometimes for data and header part, and sometimes for the header part.

Do those drivers need to support two sets of APIs? the one with _iov
for devmem, and the one without _iov for normal memory. It seems somewhat
unnecessary from driver' point of veiw to support two sets of APIs?
The driver seems to know which type of page it is expecting when calling
page_pool_alloc() with a specific page_pool instance.

Or do we use the API with _iov to allocate both devmem and normal memory
in the new driver supporting devmem page?  If that is the case, does it
really matter if the API is with _iov or not?

> .
> 

