Return-Path: <netdev+bounces-171621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F63A4DDD6
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 13:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5902817838F
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 12:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602E1202994;
	Tue,  4 Mar 2025 12:25:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073D8202989;
	Tue,  4 Mar 2025 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741091133; cv=none; b=p6Nr5xzYFqgKIL+GUPTUQ5IlutGY2vEBM+cnbdzH+gnQzhgEdp5MziiGwj6UL0TnWAMz9tWodYJZZEWwwJ2Mt7wUm1fvkhWHQ4IEoIlFZUkOjKvRhV10qY/5Etc8C9rgXsyov7Ebp0u3QgP9SuxqB7HOIHP3UN6cIODVAVI6eag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741091133; c=relaxed/simple;
	bh=MB1CADvdS6O0JIq3O56tt7iMaZRBTkfdTpP8VouXJEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G3RwJkubQOqZwrCiG2qoNn/hs9nJc7IUiy4Z7Ewe29oa2aKt5Cc+bq8gHzlRq8M5ppPkyjULoTluwhUr4mkTw384oEk3uplPFGKKu0yf6LrqgmFN5LxN4Gh5cDiAlApI4nm198/GVpTeMDrtgiN9Sp/p4XWY4ot0G6uNqcVEbX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Z6ZYg3PJYzCs78;
	Tue,  4 Mar 2025 20:21:59 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id C9BB4140156;
	Tue,  4 Mar 2025 20:25:28 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Mar 2025 20:25:28 +0800
Message-ID: <b67798cf-17e0-444d-be9f-00071c3e32b4@huawei.com>
Date: Tue, 4 Mar 2025 20:25:28 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 3/4] page_pool: support unlimited number of
 inflight pages
To: Simon Horman <horms@kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<zhangkun09@huawei.com>, <liuyonglong@huawei.com>, <fanghaiqing@huawei.com>,
	Robin Murphy <robin.murphy@arm.com>, Alexander Duyck
	<alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, Eric Dumazet
	<edumazet@google.com>, Donald Hunter <donald.hunter@gmail.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250226110340.2671366-1-linyunsheng@huawei.com>
 <20250226110340.2671366-4-linyunsheng@huawei.com>
 <20250303175940.GW1615191@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20250303175940.GW1615191@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/3/4 1:59, Simon Horman wrote:
> On Wed, Feb 26, 2025 at 07:03:38PM +0800, Yunsheng Lin wrote:
>> Currently a fixed size of pre-allocated memory is used to
>> keep track of the inflight pages, in order to use the DMA
>> API correctly.
>>
>> As mentioned [1], the number of inflight pages can be up to
>> 73203 depending on the use cases. Allocate memory dynamically
>> to keep track of the inflight pages when pre-allocated memory
>> runs out.
>>
>> The overhead of using dynamic memory allocation is about 10ns~
>> 20ns, which causes 5%~10% performance degradation for the test
>> case of time_bench_page_pool03_slow() in [2].
>>
>> 1. https://lore.kernel.org/all/b8b7818a-e44b-45f5-91c2-d5eceaa5dd5b@kernel.org/
>> 2. https://github.com/netoptimizer/prototype-kernel
>> CC: Robin Murphy <robin.murphy@arm.com>
>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>> CC: IOMMU <iommu@lists.linux.dev>
>> Fixes: f71fec47c2df ("page_pool: make sure struct device is stable")
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> ---
>>  Documentation/netlink/specs/netdev.yaml | 16 +++++
>>  include/net/page_pool/types.h           | 10 ++++
>>  include/uapi/linux/netdev.h             |  2 +
>>  net/core/page_pool.c                    | 79 ++++++++++++++++++++++++-
>>  net/core/page_pool_priv.h               |  2 +
>>  net/core/page_pool_user.c               | 39 ++++++++++--
>>  tools/net/ynl/samples/page-pool.c       | 11 ++++
>>  7 files changed, 154 insertions(+), 5 deletions(-)
> 
> Hi,
> 
> It looks like the header changes in this patch don't quite
> correspond to the spec changes.
> 
> But if so, perhaps the spec update needs to change,
> because adding values to an enum, other than at the end,
> feels like UAPI breakage to me.
> 
> I see this:
> 
> $ ./tools/net/ynl/ynl-regen.sh -f

Yes, It seems I only tested the tools/net/ynl/samples/page-pool, which
doesn't seems to catch the above problem.

Will update the spec changes to the the header changes and update
tools/include/uapi/linux/netdev.h accordingly too.

Thanks for the reporting.

> $ git diff
> diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> index 9309cbfeb8d2..9e02f6190b07 100644
> --- a/include/uapi/linux/netdev.h
> +++ b/include/uapi/linux/netdev.h
> @@ -100,11 +100,11 @@ enum {
>  	NETDEV_A_PAGE_POOL_NAPI_ID,
>  	NETDEV_A_PAGE_POOL_INFLIGHT,
>  	NETDEV_A_PAGE_POOL_INFLIGHT_MEM,
> +	NETDEV_A_PAGE_POOL_ITEM_MEM_RESIDENT,
> +	NETDEV_A_PAGE_POOL_ITEM_MEM_USED,
>  	NETDEV_A_PAGE_POOL_DETACH_TIME,
>  	NETDEV_A_PAGE_POOL_DMABUF,
>  	NETDEV_A_PAGE_POOL_IO_URING,
> -	NETDEV_A_PAGE_POOL_ITEM_MEM_RESIDENT,
> -	NETDEV_A_PAGE_POOL_ITEM_MEM_USED,
>  
>  	__NETDEV_A_PAGE_POOL_MAX,
>  	NETDEV_A_PAGE_POOL_MAX = (__NETDEV_A_PAGE_POOL_MAX - 1)
> diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
> index 7600bf62dbdf..9e02f6190b07 100644
> --- a/tools/include/uapi/linux/netdev.h
> +++ b/tools/include/uapi/linux/netdev.h
> @@ -100,6 +100,8 @@ enum {
>  	NETDEV_A_PAGE_POOL_NAPI_ID,
>  	NETDEV_A_PAGE_POOL_INFLIGHT,
>  	NETDEV_A_PAGE_POOL_INFLIGHT_MEM,
> +	NETDEV_A_PAGE_POOL_ITEM_MEM_RESIDENT,
> +	NETDEV_A_PAGE_POOL_ITEM_MEM_USED,
>  	NETDEV_A_PAGE_POOL_DETACH_TIME,
>  	NETDEV_A_PAGE_POOL_DMABUF,
>  	NETDEV_A_PAGE_POOL_IO_URING,
> 

