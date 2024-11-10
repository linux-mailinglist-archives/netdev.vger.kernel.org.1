Return-Path: <netdev+bounces-143612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C09679C3512
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 23:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D64428115F
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 22:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C21149011;
	Sun, 10 Nov 2024 22:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="voOUXqy2"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C72DDD9
	for <netdev@vger.kernel.org>; Sun, 10 Nov 2024 22:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731277891; cv=none; b=RxeRGg4tR9sQJAZfaAY37lpMDLal1xUoeEzUVlA5wmwNstfqzXYwHGnHGZhgGeLlYpVYx60ha/9f8X0naOfE+ur7rzJ3GU8TvVXvNFEUaC5b891OPkRScw97tWrUNYe7NKDpAz5OvlhgwVhtaUDfIz9HujH4xdhMeQThQNaZvlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731277891; c=relaxed/simple;
	bh=smv1JoqJjgO1KCajnvQHL1LcfVSRkWRCNqAgl6T3pO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f1mJ2sG5miUKAO7xGZMvESGnBiKBMn/FXiS4rK+koxTLzZT3OdoB55Y8WlMKZ64g/SMa3S955SERIqvJOVGnpXOhhCEuwH07sEBuvHz9/dDqyNJ65OUKPwC7b0dy0XoR6e78a71j37BEoANQf1AyoIJoTz0gWgOQU7ZFQBfTZa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=voOUXqy2; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <daef8c89-a27b-492f-935e-60fd55718841@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731277886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rko8hK/ai/CdmNkn4xU3PCZQfRpSgayMrHwIRRQM+n4=;
	b=voOUXqy2/2ZfwFB0goeL4n9+3WozaVXsunCTlwHvsXtdXv+8LXC+KU8/IWDjHyzPlCnnKc
	knmUeK/g8qFUSbfZjjzRGg97bZuo2tsLLI1MQrN5x7dk+n9VKY2oBgkmrNH4Ed4gSVEH6I
	NPOYLK37cHYzjH5RHEZZpQTRRUn6y04=
Date: Sun, 10 Nov 2024 22:31:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2] Avoid traversing addrconf hash on ifdown
To: Gilad Naaman <gnaaman@drivenets.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, kuniyu@amazon.com,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <ea009a4a-c9f2-4843-b84d-e6b72982228e@linux.dev>
 <20241110065309.3011785-1-gnaaman@drivenets.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241110065309.3011785-1-gnaaman@drivenets.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/11/2024 06:53, Gilad Naaman wrote:
>>> -		spin_unlock_bh(&net->ipv6.addrconf_hash_lock);
>>> +	list_for_each_entry(ifa, &idev->addr_list, if_list) {
>>> +		addrconf_del_dad_work(ifa);
>>> +
>>> +		/* combined flag + permanent flag decide if
>>> +		 * address is retained on a down event
>>> +		 */
>>> +		if (!keep_addr ||
>>> +		    !(ifa->flags & IFA_F_PERMANENT) ||
>>> +		    addr_is_local(&ifa->addr))
>>> +			hlist_del_init_rcu(&ifa->addr_lst);
>>>    	}
>>>    
>>> +	spin_unlock(&net->ipv6.addrconf_hash_lock);
>>> +	read_unlock_bh(&idev->lock);
>>
>> Why is this read lock needed here? spinlock addrconf_hash_lock will
>> block any RCU grace period to happen, so we can safely traverse
>> idev->addr_list with list_for_each_entry_rcu()...
> 
> Oh, sorry, I didn't realize the hash lock encompasses this one;
> although it seems obvious in retrospect.
> 
>>> +
>>>    	write_lock_bh(&idev->lock);
>>
>> if we are trying to protect idev->addr_list against addition, then we
>> have to extend write_lock scope. Otherwise it may happen that another
>> thread will grab write lock between read_unlock and write_lock.
>>
>> Am I missing something?
> 
> I wanted to ensure that access to `idev->addr_list` is performed under lock,
> the same way it is done immediately afterwards;
> No particular reason not to extend the existing lock, I just didn't think
> about it.
> 
> For what it's worth, the original code didn't have this protection either,
> since the another thread could have grabbed the lock between
> `spin_unlock_bh(&net->ipv6.addrconf_hash_lock);` of the last loop iteration,
> and the `write_lock`.
> 
> Should I extend the write_lock upwards, or just leave it off?

Well, you are doing write manipulation with the list, which is protected
by read-write lock. I would expect this lock to be held in write mode. 
And you have to protect hash map at the same time. So yes, write_lock
and spin_lock altogether, I believe.

> 
> Thank you for your time,
> Gilad


