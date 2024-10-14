Return-Path: <netdev+bounces-135182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 321C099CA63
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 14:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9FF1F22A7F
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 12:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684F91A725F;
	Mon, 14 Oct 2024 12:39:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7561A7265;
	Mon, 14 Oct 2024 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728909542; cv=none; b=FsF3S9DmvI0tqnQ6RIy5T3AIrvI0KUd95AWugPlVisibIQSQZRHPCWF+1e3KwIRb6A30EYQS48Ain3BdgoKKWngWSFHmIq7zjfnR4OPiHj6XbuZ3sjJJqBAX+lvdQ/apOdmqUm6tNa2Hz47gE4OoE23Sz0N1YFyTAU4EanipUXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728909542; c=relaxed/simple;
	bh=rYDIZbKlan7o80zOmIUX4D3Rm04vlRDItz+xRnK70vU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kFpXaXq+UGbm4fX1jsEyL6DDEyKGK1tA3QIVlV1MpX+tVTKUBwcZD/w+otca38Ar6D2/MCGi+7F3Q3TxEHOhfl/8dYSPkPLpu+guOVAfirzb42ecXGQLQDOfIePsLiT7XFtKJvCPGPyAecfZCwtIoKrdY1WoFJdRMNtBpCzXGAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XRxZj6RbrzyTBb;
	Mon, 14 Oct 2024 20:37:33 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id B53501402CA;
	Mon, 14 Oct 2024 20:38:55 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Oct 2024 20:38:55 +0800
Message-ID: <14627cec-d54a-4732-8a99-3b1b5757987d@huawei.com>
Date: Mon, 14 Oct 2024 20:38:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] page_pool: check for dma_sync_size earlier
To: Furong Xu <0x1207@gmail.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, <netdev@vger.kernel.org>,
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
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20241014143542.000028dc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/14 14:35, Furong Xu wrote:
> Hi Yunsheng,
> 
> On Sat, 12 Oct 2024 14:14:41 +0800, Yunsheng Lin <linyunsheng@huawei.com> wrote:
> 
>> I would prefer to add a new api to do that, as it makes the semantic
>> more obvious and may enable removing some checking in the future.
>>
>> And we may need to disable this 'feature' for frag relate API for now,
>> as currently there may be multi callings to page_pool_put_netmem() for
>> the same page, and dma_sync is only done for the last one, which means
>> it might cause some problem for those usecases when using frag API.
> 
> I am not an expert on page_pool.
> So would you mind sending a new patch to add a non-dma-sync version of
> page_pool_put_page() and CC it to me?

As I have at least two patchsets pending for the net-next, which seems
it might take a while, so it might take a while for me to send another
new patch.

Perhaps just add something like page_pool_put_page_nosync() as
page_pool_put_full_page() does for the case of dma_sync_size being
-1? and leave removing of extra checking as later refactoring and
optimization.

As for the frag related API like page_pool_alloc_frag() and
page_pool_alloc(), we don't really have a corresponding free side
API for them, instead we reuse page_pool_put_page() for the free
side, and don't really do any dma sync unless it is the last frag
user of the same page, see the page_pool_is_last_ref() checking in
page_pool_put_netmem().

So it might require more refactoring to support the usecase of
this patch for frag API, for example we might need to pull the
dma_sync operation out of __page_pool_put_page(), and put it in
page_pool_put_netmem() so that dma_sync is also done for the
non-last frag user too.
Or not support it for frag API for now as stmmac driver does not
seem to be using frag API, and put a warning to catch the case of
misusing of the 'feature' for frag API in the 'if' checking in
page_pool_put_netmem() before returning? something like below:

--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -317,8 +317,10 @@ static inline void page_pool_put_netmem(struct page_pool *pool,
         * allow registering MEM_TYPE_PAGE_POOL, but shield linker.
         */
 #ifdef CONFIG_PAGE_POOL
-       if (!page_pool_is_last_ref(netmem))
+       if (!page_pool_is_last_ref(netmem)) {
+		/* Big comment why frag API is not support yet */
+               DEBUG_NET_WARN_ON_ONCE(!dma_sync_size);
                return;
+       }

        page_pool_put_unrefed_netmem(pool, netmem, dma_sync_size, allow_direct);
 #endif


> I am so glad to test it on my device ;)
> Thanks.
> 
> 

