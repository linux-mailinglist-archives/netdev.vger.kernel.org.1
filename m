Return-Path: <netdev+bounces-144125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BF99C5D49
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 17:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 141C4B2627D
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 14:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6AA1FE10C;
	Tue, 12 Nov 2024 14:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GoBCVBVl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAE4142659
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422480; cv=none; b=oyXnZ1Taq0QLnsZD46gP67+BhpBqRNwXZx1YkhnCxKXIYLCU+u5hT0NvLGTZeWzMxB29FZ4J/Ur9SWujC0p2KfTj2soJMivOKir2OpMFP2Td5hZziYvcqUxp2GpvyxVYgLhDkv2c3Ei8ocO6REmLNrWxILg1flpImFn4wzzGaCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422480; c=relaxed/simple;
	bh=VyjCNByJOB+9ITa105BORQW3GnQsqwPukWsxDtbI7FI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cqXDE0hiKzigeLyEJVsQjjDm8cOhmy6AJjvgrB1AUQYhoi2PUnHg/WJQGLxWnB/sXyvfW6SqMK2MktGt+goUS+2d8qu9Ycc7nVisfKXLLcJZTqkNl/aRNe+Dbyvhk7QoQ19xZJVALHnVqFzAT6InrhEpvYhg2FrVbdH/oHVrdfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GoBCVBVl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731422477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D17VjLLUyhAOheqzxUrV6d9dYpN4WhJ+I5RWJUc1prI=;
	b=GoBCVBVlOqXJ2hpr6+jWt9xX87a0+X/E1/8Wtp4+ihC8nGKpr4sfmLrDq7J/P3uzFwPXR4
	u3Ua6Xznez+eepPjA/u8C+P4sSw2b9ITYkEOZvU/HU4DpSR49lzDk4Jg65T15v6Qh86w1F
	VPaSM5TO+7WJWM+xn0jgR2V0rl8G9Qk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-TG8RSjTjMlSlob0-nh0LSA-1; Tue, 12 Nov 2024 09:41:14 -0500
X-MC-Unique: TG8RSjTjMlSlob0-nh0LSA-1
X-Mimecast-MFC-AGG-ID: TG8RSjTjMlSlob0-nh0LSA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4315a0f25afso44671995e9.3
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 06:41:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731422472; x=1732027272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D17VjLLUyhAOheqzxUrV6d9dYpN4WhJ+I5RWJUc1prI=;
        b=KiHeNSOeNq2ofc3LiTRO3TLrdXo2RhUMC+TAvvRIiSN4jZ3GIJT7cIJhdyei+ld9vk
         yu+s859Q+VjQMlC3y26jiW9U3NcIwlr5KCRP+7uP2vRhTZ6ddrhCceAI9myrQlGT0haG
         ty80fOeBwvZkTlTqRourleYEmJcZ3c1IJ0ci6s3uAPs61Lra6VZJvDQGMbk2hzDgNzKj
         mzU7AngTgh6BRbuLF7GYy7c/nNpb7FwExp7NfqLs79MdgcC507VkOzRDHbRD+oNepGAu
         /QiGTv2Wpx7WwVPUIUBuaHjaM4R/djtV/H7A8AFonxK5tNwaPpDc9pp5z+rMuszSiMK7
         JhDg==
X-Forwarded-Encrypted: i=1; AJvYcCXqXD+vc4zwkQKLtukhCa1gxGUQsigXeaeBouTsDtbg4hU92pGDHmlJv1PonSy3rd6RhyemI+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxitjBtFNlndrl1dg66p8/MGE7F8hF4wLT/2a4P8/Zz9R+IGEZJ
	+fvncZRcOvFenu+SW2O7+oSWOrcuAYxfoKcgc2w4RZwLmeh/DVJO7b0m+08Xzrkerl6vRZIEBxx
	q3f5pS6QbQAmSCQg0q08NYqclLFfsqG8JU8yiY9Zs/VfHUUfTmi0Zbg==
X-Received: by 2002:a5d:5986:0:b0:37d:53dd:4dec with SMTP id ffacd0b85a97d-381f186cbe0mr14227063f8f.15.1731422471754;
        Tue, 12 Nov 2024 06:41:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGP3z7Sbp/DZPPRrooDXPzhNhuJgAHVb0ZfTevI9HWTlt+vyBoNKd4sikgZkl7qACzroqH/Tg==
X-Received: by 2002:a5d:5986:0:b0:37d:53dd:4dec with SMTP id ffacd0b85a97d-381f186cbe0mr14227036f8f.15.1731422471326;
        Tue, 12 Nov 2024 06:41:11 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed99a0efsm15617060f8f.58.2024.11.12.06.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 06:41:10 -0800 (PST)
Message-ID: <ecdad6a5-d766-4ff2-a8ad-b605ebb3811c@redhat.com>
Date: Tue, 12 Nov 2024 15:41:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] Avoid traversing addrconf hash on ifdown
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Gilad Naaman <gnaaman@drivenets.com>, Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, horms@kernel.org,
 kuba@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org
References: <daef8c89-a27b-492f-935e-60fd55718841@linux.dev>
 <20241111052124.3030623-1-gnaaman@drivenets.com>
 <9984afe3-2d5f-4ac0-9736-523ce4755e1c@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <9984afe3-2d5f-4ac0-9736-523ce4755e1c@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 13:07, Vadim Fedorenko wrote:
> On 11/11/2024 05:21, Gilad Naaman wrote:
>>> On 10/11/2024 06:53, Gilad Naaman wrote:
>>>>>> -           spin_unlock_bh(&net->ipv6.addrconf_hash_lock);
>>>>>> +   list_for_each_entry(ifa, &idev->addr_list, if_list) {
>>>>>> +           addrconf_del_dad_work(ifa);
>>>>>> +
>>>>>> +           /* combined flag + permanent flag decide if
>>>>>> +            * address is retained on a down event
>>>>>> +            */
>>>>>> +           if (!keep_addr ||
>>>>>> +               !(ifa->flags & IFA_F_PERMANENT) ||
>>>>>> +               addr_is_local(&ifa->addr))
>>>>>> +                   hlist_del_init_rcu(&ifa->addr_lst);
>>>>>>      }
>>>>>>
>>>>>> +   spin_unlock(&net->ipv6.addrconf_hash_lock);
>>>>>> +   read_unlock_bh(&idev->lock);
>>>>>
>>>>> Why is this read lock needed here? spinlock addrconf_hash_lock will
>>>>> block any RCU grace period to happen, so we can safely traverse
>>>>> idev->addr_list with list_for_each_entry_rcu()...
>>>>
>>>> Oh, sorry, I didn't realize the hash lock encompasses this one;
>>>> although it seems obvious in retrospect.
>>>>
>>>>>> +
>>>>>>      write_lock_bh(&idev->lock);
>>>>>
>>>>> if we are trying to protect idev->addr_list against addition, then we
>>>>> have to extend write_lock scope. Otherwise it may happen that another
>>>>> thread will grab write lock between read_unlock and write_lock.
>>>>>
>>>>> Am I missing something?
>>>>
>>>> I wanted to ensure that access to `idev->addr_list` is performed under lock,
>>>> the same way it is done immediately afterwards;
>>>> No particular reason not to extend the existing lock, I just didn't think
>>>> about it.
>>>>
>>>> For what it's worth, the original code didn't have this protection either,
>>>> since the another thread could have grabbed the lock between
>>>> `spin_unlock_bh(&net->ipv6.addrconf_hash_lock);` of the last loop iteration,
>>>> and the `write_lock`.
>>>>
>>>> Should I extend the write_lock upwards, or just leave it off?
>>>
>>> Well, you are doing write manipulation with the list, which is protected
>>> by read-write lock. I would expect this lock to be held in write mode.
>>> And you have to protect hash map at the same time. So yes, write_lock
>>> and spin_lock altogether, I believe.
>>>
>>
>> Note that within the changed lines, the list itself is only iterated-on,
>> not manipulated.
>> The changes are to the `addr_lst` list, which is the hashtable, not the
>> list this lock protects.
>>
>> I'll send v3 with the write-lock extended.
>> Thank you!
> 
> Reading it one more time, I'm not quite sure that locking hashmap
> spinlock under idev->lock in write mode is a good idea... We have to
> think more about it, maybe ask for another opinion. Looks like RTNL
> should protect idev->addr_list from modification while idev->lock is
> more about changes to idev, not only about addr_list.
> 
> @Eric could you please shed some light on the locking schema here?

AFAICS idev->addr_list is (write) protected by write_lock(idev->lock),
while net->ipv6.inet6_addr_lst is protected by
spin_lock_bh(&net->ipv6.addrconf_hash_lock).

Extending the write_lock() scope will create a lock dependency between
the hashtable lock and the list lock, which in turn could cause more
problem in the future.

Note that idev->addr_list locking looks a bit fuzzy, as is traversed in
several places under the RCU lock only. I suggest finish the conversion
of idev->addr_list to RCU and do this additional traversal under RCU, too.

Cheers,

Paolo


