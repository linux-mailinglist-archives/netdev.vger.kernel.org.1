Return-Path: <netdev+bounces-130053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5385987D65
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 05:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211601C21749
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 03:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB88A170A0A;
	Fri, 27 Sep 2024 03:58:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4004E170854;
	Fri, 27 Sep 2024 03:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727409533; cv=none; b=mVGeTg17fkN3Mpdb5INjQ82VRc07d5jwvz9A5d0buNbhcUQYkljkHczlz67NAYc37uzqsKhKOxmmveb8ugiwfna3qQCvsXyL2jzUum0imGu2cWgEq9OlokBILRdD2cdUOxQ+z5kAq2C8jbsUc1FK9Wvr5Dbs8NmJY60p3gZxGx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727409533; c=relaxed/simple;
	bh=3hDG/ygzY27dtTjKfW77NKMg1gZKhXO9wYT9u5Wdvko=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e99oxX7qUt2YbjR3zCpbaJmorKhLsw5MxgE2cWiuJWZX1Y/tamwLnRdSrDWY869zrsQOs0lsRjQqEJSDOV9eBA51XGM3vg8qv/kqPxt4H30mWq0SwrqpRmMowaeZ33uOX0RvHqw4Bmvu4bkNCPpAuq5kStE3+KTR2Cnf2ZQGf20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XFGt23XZzz1ymGy;
	Fri, 27 Sep 2024 11:58:50 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 81C6C1A0188;
	Fri, 27 Sep 2024 11:58:48 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 27 Sep 2024 11:58:48 +0800
Message-ID: <64eeeee0-8ec8-458b-b01a-ac1dd6c96583@huawei.com>
Date: Fri, 27 Sep 2024 11:58:47 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] page_pool: fix timing for checking and
 disabling napi_local
To: Joe Damato <jdamato@fastly.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <liuyonglong@huawei.com>, <fanghaiqing@huawei.com>,
	<zhangkun09@huawei.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mkarsten@uwaterloo.ca>
References: <20240925075707.3970187-1-linyunsheng@huawei.com>
 <20240925075707.3970187-2-linyunsheng@huawei.com>
 <ZvW-uEXITmZtncub@LQ3V64L9R2>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <ZvW-uEXITmZtncub@LQ3V64L9R2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/9/27 4:06, Joe Damato wrote:
> On Wed, Sep 25, 2024 at 03:57:06PM +0800, Yunsheng Lin wrote:
>> page_pool page may be freed from skb_defer_free_flush() to
>> softirq context, it may cause concurrent access problem for
>> pool->alloc cache due to the below time window, as below,
>> both CPU0 and CPU1 may access the pool->alloc cache
>> concurrently in page_pool_empty_alloc_cache_once() and
>> page_pool_recycle_in_cache():
>>
>>           CPU 0                           CPU1
>>     page_pool_destroy()          skb_defer_free_flush()
>>            .                               .
>>            .                   page_pool_put_unrefed_page()
>>            .                               .
>>            .               allow_direct = page_pool_napi_local()
>>            .                               .
>> page_pool_disable_direct_recycling()       .
>>            .                               .
>> page_pool_empty_alloc_cache_once() page_pool_recycle_in_cache()
>>
>> Use rcu mechanism to avoid the above concurrent access problem.
>>
>> Note, the above was found during code reviewing on how to fix
>> the problem in [1].
>>
>> 1. https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/
>>
>> Fixes: dd64b232deb8 ("page_pool: unlink from napi during destroy")
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> Sorry for the noise, but I hit an assert in page_pool_unref_netmem
> and I am trying to figure out if it is related to what you all are
> debugging? I thought it might be, but if not, my apologies.
> 
> Just in case it is, I've put the backtrace on github [1]. I
> triggered this while testing an RFC [2] I've been working on. Please
> note, the RFC posted publicly does not currently apply cleanly to
> net-next and has some bugs I've fixed in my v4. I had planned to
> send the v4 early next week and mention the page pool issue I am
> hitting.
> 
> After triggering the assert in [1], I tried applying the patches of
> this series and retesting the RFC v4 I have queued locally. When I
> did that, I hit a new assertion page_pool_destroy [3].
> 
> There are a few possibilities:
>    1. I am hitting the same issue you are hitting
>    2. I am hitting a different issue caused by a bug I introduced
>    3. I am hitting a different page pool issue entirely
> 
> In case of 2 and 3, my apologies for the noise.
> 
> In case of 1: If you think I am hitting the same issue as you are
> trying to solve, I can reliably reproduce this with my RFC v4 and
> would be happy to test any patches meant to fix the issue.
> 
> [1]: https://gist.githubusercontent.com/jdamato-fsly/eb628c8bf4e4d1c8158441644cdb7e52/raw/96dcf422303d9e64b5060f2fb0f1d71e04ab048e/warning1.txt

It seems there may be some concurrent access of page->pp_ref_count/
page_pool->frag_users or imbalance‌ incrementing and decrementing of
page->pp_ref_count.

For the concurrent access part, you may refer to the below patch
for debugging, but it seems mlx5 driver doesn't use frag API directly
as my last recall, so you can't use it directly.

https://lore.kernel.org/all/20240903122208.3379182-1-linyunsheng@huawei.com/

> [2]: https://lore.kernel.org/all/20240912100738.16567-1-jdamato@fastly.com/#r
> [3]: https://gist.githubusercontent.com/jdamato-fsly/eb628c8bf4e4d1c8158441644cdb7e52/raw/96dcf422303d9e64b5060f2fb0f1d71e04ab048e/warning2.txt

There warning is only added to see if there is any infight page that
need dma unmapping when page_pool_destroy() is called, you can ignore
that warning or remove that WARN_ONCE() in page_pool_item_uninit()
when testing.

> 

