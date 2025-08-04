Return-Path: <netdev+bounces-211589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5ECB1A468
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 16:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F638180C62
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 14:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C1727054C;
	Mon,  4 Aug 2025 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2J8rc26"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710BF25D53C
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754317072; cv=none; b=URfhGx2+98G9ZUgmxOsCVOkQcmuEXfhwBvX+oqfXxoN4F6ozCJETz9hV6tne1EF+KU64ZDUTINi9F/jaF+KlqnIwrby/UgMEL2v2RvfdaMV4oDJL0AS0D7qZbBSrBfk6aQdxtT1TyekRbvbDAaQug4Y6vYkU3nC9HUsIl1jU7M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754317072; c=relaxed/simple;
	bh=h4l7UFhbf9jvr/iFpJnnx2a2VU5naGmRpVn90WQpP4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ATJNog2dhaS7R1enwwMENIqaBwxKrc/gDJQmZPGoWJ16JCvgrQlv3wymx4dUC1PEY7NdolPOuESsOXxAgD0dMKmHzXGvH4+Km7iFEBMp86c4JeSs3ACliZ/ocmUscPWOR53bfkN1M8Xk/+KMbltQKxdLjRdMMTtk2wB8L/ZYq9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2J8rc26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC55C4CEE7;
	Mon,  4 Aug 2025 14:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754317071;
	bh=h4l7UFhbf9jvr/iFpJnnx2a2VU5naGmRpVn90WQpP4I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B2J8rc26MlxBavlmjZzh0pAt/6lleBOOSi4OzRRu5+nAllJK6hxBIoopygnc7jCM9
	 4QlOF9NnD0JQVSCt7drieRT/itpDMMasB+X8PBP/+CgQynFHFnXVbs/ijhuHUnve1H
	 9RdM0v2fY72eIp2BHG9l2NtXS9vByRwgs+68R9x6bCQCvNqrQMVotRCsXddby1yMWV
	 VCJmK66lpvaTazRerk8TggDr/nBMIWFW0xwiIOKJw+uDpEEaB1CDaiM9FTadWf0SKy
	 oOIXh3EGSd1kCp6gZF+m/ZOUKp0DmuPGa1Q9GQzqAZDBlG//Bd6I7tyJzZ9QUWFC+c
	 oA6VyHmqesRyg==
Message-ID: <30c4b5c7-3c83-44f6-a469-f46e463635e5@kernel.org>
Date: Mon, 4 Aug 2025 16:17:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: page_pool: allow enabling recycling late, fix
 false positive warning
To: Stanislav Fomichev <stfomichev@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 David Wei <dw@davidwei.uk>, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, ilias.apalodimas@linaro.org,
 almasrymina@google.com, sdf@fomichev.me
References: <20250801173011.2454447-1-kuba@kernel.org>
 <aI0prRzAJkEXdkEa@mini-arch> <20250801140506.5b3e7213@kernel.org>
 <aI0zVd1QJ-CMVX3u@mini-arch>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <aI0zVd1QJ-CMVX3u@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/08/2025 23.36, Stanislav Fomichev wrote:
> On 08/01, Jakub Kicinski wrote:
>> On Fri, 1 Aug 2025 13:55:09 -0700 Stanislav Fomichev wrote:
>>>> +static void bnxt_enable_rx_page_pool(struct bnxt_rx_ring_info *rxr)
>>>> +{
>>>> +	page_pool_enable_direct_recycling(rxr->head_pool, &rxr->bnapi->napi);
>>>> +	page_pool_enable_direct_recycling(rxr->page_pool, &rxr->bnapi->napi);
>>>
>>> We do bnxt_separate_head_pool check for the disable_direct_recycling
>>> of head_pool. Is it safe to skip the check here because we always allocate two
>>> pps from queue_mgmt callbacks? (not clear for me from a quick glance at
>>> bnxt_alloc_rx_page_pool)
>>
>> It's safe (I hope) because the helper is duplicate-call-friendly:
>>
>> +void page_pool_enable_direct_recycling(struct page_pool *pool,
>> +				       struct napi_struct *napi)
>> +{
>> +	if (READ_ONCE(pool->p.napi) == napi)   <<< right here
>> +		return;
>> +	WARN_ON_ONCE(!napi || pool->p.napi);

Why only warn once?
(this is setup code path, so it should not get invoked a lot)

>> +
>> +	mutex_lock(&page_pools_lock);
>> +	WRITE_ONCE(pool->p.napi, napi);
>> +	mutex_unlock(&page_pools_lock);
>> +}
>>
>> We already have a refcount in page pool, I'm planning to add
>> page_pool_get() in net-next and remove the
>>
>> 	if (bnxt_separate_head_pool)
>>
>> before page_pool_destroy(), too.
> 
> Ah, I see, I missed that fact that page_pool and head_pool point to the
> same address when we don't have separate pools. Makes sense, thanks!

If you depend on this side-effect of the API, we better document that
this is the intend of the API.  E.g.
  Calling this function several time with same page_pool and napi is safe
and only enables it on the first call.  Other-wise it is no allowed to 
enable an already enabled page_pool.

(... that's what the WARN is about right?)

The bnxt driver code use-case for doing this seems scary and hard to
follow, e.g. having 'page_pool' and 'head_pool' point to the same
address, sometimes...  I would also add a comment about this in the
driver, but I find this optional and up-to the driver maintainer.

--Jesper

pw-bot: cr

