Return-Path: <netdev+bounces-143727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF419C3DF7
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 13:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1511C217E0
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 12:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE91C19993B;
	Mon, 11 Nov 2024 12:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CYohmhPb"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB2319B3FF
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 12:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731326847; cv=none; b=XOUObfgXGMbyzMPO2z0OxbRFp0BhKTTixJtel23XU4p4ZPv1/HUKuVFfw2osx3dfG3N/hAszyDtrLLGQaYcTbi8Fjqe4Bvmh5AC7YYG0fkokGNIIcWTVBWiA+636SnAAK8zvZzgwRjRvUyXwlxwuSMo9uy3x8VG9ezFCMqM+9mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731326847; c=relaxed/simple;
	bh=tnBLR1RojMlnFgZDcoxL5i+wgiMSz+tAGrcpkCeqofQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NtjpjJc+AOfFOpu+KTM10zR5JBb7QAnlOLwJOCqtBrT/MO7G12RM+hvWkcYvJDOZX5h6Vzfx7lWlr7PRuyqDgZTb7QEX7LcN75hiXEnLn5U2+3dy0PYvjzabwVT609SLuzBJQfmsWNpUrdoPbZGnYv5aT6RPyWFsLfFike/z07I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CYohmhPb; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9984afe3-2d5f-4ac0-9736-523ce4755e1c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731326843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fm7YQOTuUAMJc6LehKMPlFnyAn78mxLYsW+ZQCazCnE=;
	b=CYohmhPbFYfRehHHr6jfIDHReW/21Uk4icexc0BCp5HFf557jy+6Sx86HVrpQ5yUOGu4cR
	K//ATc+dw1WAQTSuOqHgKRjFR/G3CPZb9aqTfQa6RKctqpIn7Rx8mlEDSdPtWz7nxRlx1v
	lKtWKZjEYwiIe/iA9aI5X4vK+B3WzpY=
Date: Mon, 11 Nov 2024 12:07:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2] Avoid traversing addrconf hash on ifdown
To: Gilad Naaman <gnaaman@drivenets.com>, Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, horms@kernel.org,
 kuba@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, pabeni@redhat.com
References: <daef8c89-a27b-492f-935e-60fd55718841@linux.dev>
 <20241111052124.3030623-1-gnaaman@drivenets.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241111052124.3030623-1-gnaaman@drivenets.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/11/2024 05:21, Gilad Naaman wrote:
>> On 10/11/2024 06:53, Gilad Naaman wrote:
>>>>> -           spin_unlock_bh(&net->ipv6.addrconf_hash_lock);
>>>>> +   list_for_each_entry(ifa, &idev->addr_list, if_list) {
>>>>> +           addrconf_del_dad_work(ifa);
>>>>> +
>>>>> +           /* combined flag + permanent flag decide if
>>>>> +            * address is retained on a down event
>>>>> +            */
>>>>> +           if (!keep_addr ||
>>>>> +               !(ifa->flags & IFA_F_PERMANENT) ||
>>>>> +               addr_is_local(&ifa->addr))
>>>>> +                   hlist_del_init_rcu(&ifa->addr_lst);
>>>>>      }
>>>>>
>>>>> +   spin_unlock(&net->ipv6.addrconf_hash_lock);
>>>>> +   read_unlock_bh(&idev->lock);
>>>>
>>>> Why is this read lock needed here? spinlock addrconf_hash_lock will
>>>> block any RCU grace period to happen, so we can safely traverse
>>>> idev->addr_list with list_for_each_entry_rcu()...
>>>
>>> Oh, sorry, I didn't realize the hash lock encompasses this one;
>>> although it seems obvious in retrospect.
>>>
>>>>> +
>>>>>      write_lock_bh(&idev->lock);
>>>>
>>>> if we are trying to protect idev->addr_list against addition, then we
>>>> have to extend write_lock scope. Otherwise it may happen that another
>>>> thread will grab write lock between read_unlock and write_lock.
>>>>
>>>> Am I missing something?
>>>
>>> I wanted to ensure that access to `idev->addr_list` is performed under lock,
>>> the same way it is done immediately afterwards;
>>> No particular reason not to extend the existing lock, I just didn't think
>>> about it.
>>>
>>> For what it's worth, the original code didn't have this protection either,
>>> since the another thread could have grabbed the lock between
>>> `spin_unlock_bh(&net->ipv6.addrconf_hash_lock);` of the last loop iteration,
>>> and the `write_lock`.
>>>
>>> Should I extend the write_lock upwards, or just leave it off?
>>
>> Well, you are doing write manipulation with the list, which is protected
>> by read-write lock. I would expect this lock to be held in write mode.
>> And you have to protect hash map at the same time. So yes, write_lock
>> and spin_lock altogether, I believe.
>>
> 
> Note that within the changed lines, the list itself is only iterated-on,
> not manipulated.
> The changes are to the `addr_lst` list, which is the hashtable, not the
> list this lock protects.
> 
> I'll send v3 with the write-lock extended.
> Thank you!

Reading it one more time, I'm not quite sure that locking hashmap
spinlock under idev->lock in write mode is a good idea... We have to
think more about it, maybe ask for another opinion. Looks like RTNL
should protect idev->addr_list from modification while idev->lock is
more about changes to idev, not only about addr_list.

@Eric could you please shed some light on the locking schema here?

