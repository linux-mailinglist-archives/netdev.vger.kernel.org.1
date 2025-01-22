Return-Path: <netdev+bounces-160254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E9FA1903E
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 12:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A705188BC8A
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 11:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16DF211269;
	Wed, 22 Jan 2025 11:02:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288B418AE2;
	Wed, 22 Jan 2025 11:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737543761; cv=none; b=sYeviCZFXVKMIuVCnZduIr4g0t+fkKHJ7o+Wf49mTlmvwFbLDyG2gG2MnZZPRpVPgq5Si7HXHCkxMGS/iEwMyk2V/UGCoYJIHdY+qxSdPWOu8vI9mXPwEB3HYUEBMnbbQS4wgAxgk3jZLO2MRaEvPkz4LBuA+BrNbajSVw8dlLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737543761; c=relaxed/simple;
	bh=ebQBzzc/eZbhHWFHhxj4B7qcEDDRD1chZxTyaUXUVUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iiPbV5ZvVYjEt4nrBkE8vWsRQut2UwC75mqGiqlKkQ4Zz1GINvUrNRl9U91XDYBzMMsCf1pySWli49qnkfSwcUtVlx98dVQswUBsr3MpMj9dXEx7IgHv1E0l2e6g4SikhuwUoCjmU102eIahxAiVBh+X76eUdVU06QCFoYz3UqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4YdLg23TGZz1V5KN;
	Wed, 22 Jan 2025 18:59:10 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C6E31A016C;
	Wed, 22 Jan 2025 19:02:30 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Jan 2025 19:02:29 +0800
Message-ID: <2aa84c61-6531-4f17-89e5-101f46ef00d0@huawei.com>
Date: Wed, 22 Jan 2025 19:02:29 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/8] page_pool: fix timing for checking and
 disabling napi_local
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, Yunsheng
 Lin <yunshenglin0825@gmail.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <zhangkun09@huawei.com>, <liuyonglong@huawei.com>,
	<fanghaiqing@huawei.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric
 Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250110130703.3814407-1-linyunsheng@huawei.com>
 <20250110130703.3814407-3-linyunsheng@huawei.com> <87sepqhe3n.fsf@toke.dk>
 <5059df11-a85b-4404-8c24-a9ccd76924f3@gmail.com> <87plkhn2x7.fsf@toke.dk>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <87plkhn2x7.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/1/20 19:24, Toke Høiland-Jørgensen wrote:

...

>>>>   
>>>>   void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
>>>> @@ -1165,6 +1172,12 @@ void page_pool_destroy(struct page_pool *pool)
>>>>   	if (!page_pool_release(pool))
>>>>   		return;
>>>>   
>>>> +	/* Paired with rcu lock in page_pool_napi_local() to enable clearing
>>>> +	 * of pool->p.napi in page_pool_disable_direct_recycling() is seen
>>>> +	 * before returning to driver to free the napi instance.
>>>> +	 */
>>>> +	synchronize_rcu();
>>>
>>> Most drivers call page_pool_destroy() in a loop for each RX queue, so
>>> now you're introducing a full synchronize_rcu() wait for each queue.
>>> That can delay tearing down the device significantly, so I don't think
>>> this is a good idea.
>>
>> synchronize_rcu() is called after page_pool_release(pool), which means
>> it is only called when there are some inflight pages, so there is not
>> necessarily a full synchronize_rcu() wait for each queue.
>>
>> Anyway, it seems that there are some cases that need explicit
>> synchronize_rcu() and some cases depending on the other API providing
>> synchronize_rcu() semantics, maybe we provide two diffferent API for
>> both cases like the netif_napi_del()/__netif_napi_del() APIs do?
> 
> I don't think so. This race can only be triggered if:
> 
> - An skb is allocated from a page_pool with a napi instance attached
> 
> - That skb is freed *in softirq context* while the memory backing the
>   NAPI instance is being freed.
> 
> It's only valid to free a napi instance after calling netif_napi_del(),
> which does a full synchronise_rcu(). This means that any running
> softirqs will have exited at this point, and all packets will have been
> flushed from the deferred freeing queues. And since the NAPI has been
> stopped at this point, no new packets can enter the deferred freeing
> queue from that NAPI instance.

Note that the skb_defer_free_flush() can be called without bounding to
any NAPI instance, see the skb_defer_free_flush() called by net_rx_action(),
which means the packets from that NAPI instance can still be called in
the softirq context even when the NAPI has been stopped.

> 
> So I really don't see a way for this race to happen with correct usage
> of the page_pool and NAPI APIs, which means there's no reason to make
> the change you are proposing here.

I looked at one driver setting pp->napi, it seems the bnxt driver doesn't
seems to call page_pool_disable_direct_recycling() when unloading, see
bnxt_half_close_nic(), page_pool_disable_direct_recycling() seems to be
only called for the new queue_mgmt API:

/* rtnl_lock held, this call can only be made after a previous successful
 * call to bnxt_half_open_nic().
 */
void bnxt_half_close_nic(struct bnxt *bp)
{
	bnxt_hwrm_resource_free(bp, false, true);
	bnxt_del_napi(bp);       *----call napi del and rcu sync----*
	bnxt_free_skbs(bp);
	bnxt_free_mem(bp, true); *------call page_pool_destroy()----*
	clear_bit(BNXT_STATE_HALF_OPEN, &bp->state);
}

Even if there is a page_pool_disable_direct_recycling() called between
bnxt_del_napi() and bnxt_free_mem(), the timing window still exist as
rcu sync need to be called after page_pool_disable_direct_recycling(),
it seems some refactor is needed for bnxt driver to reuse the rcu sync
from the NAPI API, in order to avoid calling the rcu sync for
page_pool_destroy().


> 
> -Toke
> 
> 

