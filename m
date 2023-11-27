Return-Path: <netdev+bounces-51264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFD47F9DEC
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 11:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3932B20DA9
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 10:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC1818AE1;
	Mon, 27 Nov 2023 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEBC188
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 02:48:42 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Sf2KX4l2dz1P8t8;
	Mon, 27 Nov 2023 18:45:04 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 Nov
 2023 18:48:39 +0800
Subject: Re: [PATCH net-next v3 3/3] skbuff: Optimization of SKB coalescing
 for page pool
To: Liang Chen <liangchen.linux@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <hawk@kernel.org>, <ilias.apalodimas@linaro.org>,
	<netdev@vger.kernel.org>, <linux-mm@kvack.org>
References: <20231124073439.52626-1-liangchen.linux@gmail.com>
 <20231124073439.52626-4-liangchen.linux@gmail.com>
 <d26decd3-7235-c4ce-f083-16a52d15ff1c@huawei.com>
 <CAKhg4tKtsDgaNkmcH8RXVTVq_c2-SOxZTsTDTw_KH5FZ+sZuBQ@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <288af908-eed4-7ba0-17d5-2c7fb2c87233@huawei.com>
Date: Mon, 27 Nov 2023 18:48:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKhg4tKtsDgaNkmcH8RXVTVq_c2-SOxZTsTDTw_KH5FZ+sZuBQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

On 2023/11/27 12:23, Liang Chen wrote:
> On Sat, Nov 25, 2023 at 8:16 PM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2023/11/24 15:34, Liang Chen wrote:
>>
>> ...
>>
>>> --- a/include/net/page_pool/helpers.h
>>> +++ b/include/net/page_pool/helpers.h
>>> @@ -402,4 +402,26 @@ static inline void page_pool_nid_changed(struct page_pool *pool, int new_nid)
>>>               page_pool_update_nid(pool, new_nid);
>>>  }
>>>
>>> +static inline bool page_pool_is_pp_page(struct page *page)
>>> +{
>>
>> We have a page->pp_magic checking in napi_pp_put_page() in skbuff.c already,
>> it seems better to move it to skbuff.c or skbuff.h and use it for
>> napi_pp_put_page() too, as we seem to have chosen to demux the page_pool
>> owned page and non-page_pool owned page handling in the skbuff core.
>>
>> If we move it to skbuff.c or skbuff.h, we might need a better prefix than
>> page_pool_* too.
>>
> 
> How about keeping the 'page_pool_is_pp_page' function in 'helper.h'
> and letting 'skbbuff.c' use it? It seems like the function's logic is
> better suited to be internal to the page pool, and it might be needed
> outside of 'skbuff.c' in the future.

Yes, we can always extend it outside of 'skbuff' if there is a need in
the future.

For now, maybe it makes more sense to export as litte as possible in the
.h file mirroring the napi_pp_put_page().

> .
> 

