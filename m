Return-Path: <netdev+bounces-136102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8B49A0515
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 11:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C044F1F2548E
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 09:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373BF204F88;
	Wed, 16 Oct 2024 09:09:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B0E1C07C0;
	Wed, 16 Oct 2024 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069758; cv=none; b=RbF4I6yXKZEvFf9x48IyEA5aGmaH+hWCep2VvIJVmQfrjxZN3c11GDvVd5Uh4OITIKUhBuxQIZortwO7WlIFrQ9wZVWeExtv2TjyM+9d+2v1YmuYfMyfQgLfY0yMIXh/QcOgeIcJEV0Wp1QoDMzkMVx4t6sHGbod4J71f7ROdIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069758; c=relaxed/simple;
	bh=qFbIhEho6rdakA1Ti0OsYz8WwMysSLJvsQsqM8Gj4Hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pPAzmuvb/MpHVmzLSPQ9wL2Wq9TGHtJjfyVy5x1zEe6zg4myj/sqiUUL4n77flCqxH1vbyjJNmSJVLkJoIO7G+7bMUPh/QBmoJturm5o+ly8dPRxVZ08ErxZcVEwHxEzaOAZcJlGRIzMNY+ldE4i8hPHX0m3bADPGq+9Xwe982g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XT4mW303Nz1HL1D;
	Wed, 16 Oct 2024 17:04:59 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id AAE9B1A016C;
	Wed, 16 Oct 2024 17:09:12 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 16 Oct 2024 17:09:12 +0800
Message-ID: <f2e480e8-f4c9-47a5-af85-60c68279a43f@huawei.com>
Date: Wed, 16 Oct 2024 17:09:12 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] page_pool: check for dma_sync_size earlier
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: Furong Xu <0x1207@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<xfr@outlook.com>
References: <20241010114019.1734573-1-0x1207@gmail.com>
 <601d59f4-d554-4431-81ca-32bb02fb541f@huawei.com>
 <20241011101455.00006b35@gmail.com>
 <CAC_iWjL7Z6qtOkxXFRUnnOruzQsBNoKeuZ1iStgXJxTJ_P9Axw@mail.gmail.com>
 <20241011143158.00002eca@gmail.com>
 <21036339-3eeb-4606-9a84-d36bddba2b31@huawei.com>
 <CAC_iWjLE+R8sGYx74dZqc+XegLxvd4GGG2rQP4yY_p0DVuK-pQ@mail.gmail.com>
 <d920e23b-643d-4d35-9b1a-8b4bfa5b545f@huawei.com>
 <20241014143542.000028dc@gmail.com>
 <14627cec-d54a-4732-8a99-3b1b5757987d@huawei.com>
 <CAC_iWjKWjRbhfHz4CJbq-SXEd=rDJP+Go0bfLQ4pMxFNNuPXNQ@mail.gmail.com>
 <625cdab0-7348-41a1-b07f-6e5fe7962eec@huawei.com>
 <CAC_iWjKr7ZBmYT+pp-hWRGWJfWiC5TmzEDPtkorqiL9WQOHtJQ@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAC_iWjKr7ZBmYT+pp-hWRGWJfWiC5TmzEDPtkorqiL9WQOHtJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/15 21:25, Ilias Apalodimas wrote:

...

>>>>
>>>> --- a/include/net/page_pool/helpers.h
>>>> +++ b/include/net/page_pool/helpers.h
>>>> @@ -317,8 +317,10 @@ static inline void page_pool_put_netmem(struct page_pool *pool,
>>>>          * allow registering MEM_TYPE_PAGE_POOL, but shield linker.
>>>>          */
>>>>  #ifdef CONFIG_PAGE_POOL
>>>> -       if (!page_pool_is_last_ref(netmem))
>>>> +       if (!page_pool_is_last_ref(netmem)) {
>>>> +               /* Big comment why frag API is not support yet */
>>>> +               DEBUG_NET_WARN_ON_ONCE(!dma_sync_size);
>>
>> Note, the above checking is not 100% reliable, as which frag user
>> is the last one depending on runtime execution.
> 
> I am not sure I understand the problem here. If we are about to call
> page_pool_return_page() we don't care what happens to that page.
> If we end up calling __page_pool_put_page() it's the *callers* job now
> to sync the page now once all fragments are released. So why is this
> different from syncing an entire page?

It also would be that we end up calling nothing for non-last-frag-user
too when page_pool_is_last_ref() return false as the above 'if' checking
in page_pool_put_netmem() if frag related API is used.

If the above happens, there is no dma_sync done here even if the caller
passes a non-zero 'dma_sync_size' which means it is not supposed to call
page_pool_put_unrefed_netmem() for the same page with both zero and
non-zero 'dma_sync_size'.

For example:
1. If page_pool_put_page() with dma_sync_size being non-zero is first
   called for a page, and there might be no dma_sync operation if it is
   not the last frag.
2. Then page_pool_put_page() with dma_sync_size being zero is called for
   the same page to skip the dma_sync operation.

Then we might have problem here as the dma_sync operation is only expected
to be skipped for a specific page fragment, but the above calling order causes
the dma_sync operation to be skipped for the whole page.

IOW, there is currently no way to tell which fragment is being freed when
page_pool_put_page() API is called for a page split into multi fragments now,
so we might need to call page_pool_put_page() with 'dma_sync_size' all being
'-1' if the page_pool is expected to do the dma sync operation for now.

> 
>>


