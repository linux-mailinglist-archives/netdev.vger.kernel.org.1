Return-Path: <netdev+bounces-144153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0779B9C5CE9
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 17:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F881F23C16
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 16:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E576206E6C;
	Tue, 12 Nov 2024 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VHpAezxD"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DBA204093
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427718; cv=none; b=u1C3gxED7pjnpKtY5uPmxasvTSzs/GOhum1ppeg12Ejba6Irj7IMSxyMblnFk5vjITtp6IXZoWpc1m9U3SO/dj12sSONGV/NIEU+vfizAQowjefx/Gs3eVWeEPFK2NmXiFvR/He/aGtZhuJ0Z73ZJq+YDKEYa1ZYgpAdmF/92mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427718; c=relaxed/simple;
	bh=hnXhd2zyAyFNo5a2poVOFQAGi3ryDFMJEObDO/NUvsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rr/m4m46Q2rCkSDJKLVa21QkQGV18zPQB7tJPs8Bi1SIVvLTHX5s7Fx/fPmYTr8sVyNkHiXb0Zj2tvSgXGz9IlRKHmrrYPL65rNyteQtrnxEDG3idDTrMsGHSrhauvx8FKXWxAdoOxSeCHXgnIjITb909cayqXzy7jNI6qUHSfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VHpAezxD; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2acb766d-4cbc-426d-9d0d-0d592610e209@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731427713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fvNk7Mg9/LY4oJLhELgyd6faWZuZHlVdGx3n64NTHI8=;
	b=VHpAezxDz40AQ3IycGPSuzKzC1Mlq60swsseINtYcer2wGNbmrDMU06LIIPtUMGtdUJqxw
	7z0RzAQQz2zjOA3WYbdyLeQO8PMs80SCq7iPZX4OOR0wbt7Sw6Exahf+bq/NzblTR26nsS
	bxsLhWo32k2gCQ1yJWY7kJy16qYxaz4=
Date: Tue, 12 Nov 2024 16:08:29 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2] Avoid traversing addrconf hash on ifdown
To: Paolo Abeni <pabeni@redhat.com>, Gilad Naaman <gnaaman@drivenets.com>
Cc: davem@davemloft.net, dsahern@kernel.org, horms@kernel.org,
 kuba@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>
References: <daef8c89-a27b-492f-935e-60fd55718841@linux.dev>
 <20241111052124.3030623-1-gnaaman@drivenets.com>
 <9984afe3-2d5f-4ac0-9736-523ce4755e1c@linux.dev>
 <ecdad6a5-d766-4ff2-a8ad-b605ebb3811c@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <ecdad6a5-d766-4ff2-a8ad-b605ebb3811c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/11/2024 14:41, Paolo Abeni wrote:
> On 11/11/24 13:07, Vadim Fedorenko wrote:
>> On 11/11/2024 05:21, Gilad Naaman wrote:
>>>> On 10/11/2024 06:53, Gilad Naaman wrote:
>>>>>>> -           spin_unlock_bh(&net->ipv6.addrconf_hash_lock);
>>>>>>> +   list_for_each_entry(ifa, &idev->addr_list, if_list) {
>>>>>>> +           addrconf_del_dad_work(ifa);
>>>>>>> +
>>>>>>> +           /* combined flag + permanent flag decide if
>>>>>>> +            * address is retained on a down event
>>>>>>> +            */
>>>>>>> +           if (!keep_addr ||
>>>>>>> +               !(ifa->flags & IFA_F_PERMANENT) ||
>>>>>>> +               addr_is_local(&ifa->addr))
>>>>>>> +                   hlist_del_init_rcu(&ifa->addr_lst);
>>>>>>>       }
>>>>>>>
>>>>>>> +   spin_unlock(&net->ipv6.addrconf_hash_lock);
>>>>>>> +   read_unlock_bh(&idev->lock);
>>>>>>
>>>>>> Why is this read lock needed here? spinlock addrconf_hash_lock will
>>>>>> block any RCU grace period to happen, so we can safely traverse
>>>>>> idev->addr_list with list_for_each_entry_rcu()...
>>>>>
>>>>> Oh, sorry, I didn't realize the hash lock encompasses this one;
>>>>> although it seems obvious in retrospect.
>>>>>
>>>>>>> +
>>>>>>>       write_lock_bh(&idev->lock);
>>>>>>
>>>>>> if we are trying to protect idev->addr_list against addition, then we
>>>>>> have to extend write_lock scope. Otherwise it may happen that another
>>>>>> thread will grab write lock between read_unlock and write_lock.
>>>>>>
>>>>>> Am I missing something?
>>>>>
>>>>> I wanted to ensure that access to `idev->addr_list` is performed under lock,
>>>>> the same way it is done immediately afterwards;
>>>>> No particular reason not to extend the existing lock, I just didn't think
>>>>> about it.
>>>>>
>>>>> For what it's worth, the original code didn't have this protection either,
>>>>> since the another thread could have grabbed the lock between
>>>>> `spin_unlock_bh(&net->ipv6.addrconf_hash_lock);` of the last loop iteration,
>>>>> and the `write_lock`.
>>>>>
>>>>> Should I extend the write_lock upwards, or just leave it off?
>>>>
>>>> Well, you are doing write manipulation with the list, which is protected
>>>> by read-write lock. I would expect this lock to be held in write mode.
>>>> And you have to protect hash map at the same time. So yes, write_lock
>>>> and spin_lock altogether, I believe.
>>>>
>>>
>>> Note that within the changed lines, the list itself is only iterated-on,
>>> not manipulated.
>>> The changes are to the `addr_lst` list, which is the hashtable, not the
>>> list this lock protects.
>>>
>>> I'll send v3 with the write-lock extended.
>>> Thank you!
>>
>> Reading it one more time, I'm not quite sure that locking hashmap
>> spinlock under idev->lock in write mode is a good idea... We have to
>> think more about it, maybe ask for another opinion. Looks like RTNL
>> should protect idev->addr_list from modification while idev->lock is
>> more about changes to idev, not only about addr_list.
>>
>> @Eric could you please shed some light on the locking schema here?
> 
> AFAICS idev->addr_list is (write) protected by write_lock(idev->lock),
> while net->ipv6.inet6_addr_lst is protected by
> spin_lock_bh(&net->ipv6.addrconf_hash_lock).
> 
> Extending the write_lock() scope will create a lock dependency between
> the hashtable lock and the list lock, which in turn could cause more
> problem in the future.
> 
> Note that idev->addr_list locking looks a bit fuzzy, as is traversed in
> several places under the RCU lock only.

Yeah, I was confused exactly because of some places using RCU while
others still using read_lock.

> I suggest finish the conversion
> of idev->addr_list to RCU and do this additional traversal under RCU, too.

That sounds reasonable,

Thanks!

