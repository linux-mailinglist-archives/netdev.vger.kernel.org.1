Return-Path: <netdev+bounces-128918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BDC97C71E
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 11:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B564284795
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 09:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCED198A2C;
	Thu, 19 Sep 2024 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HhkyjU0k"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A675B1DA23
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 09:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726738268; cv=none; b=AFTy+QaAS3bzNKdiOv34QWux8ypGFDzUqKSkuVcp6iXVE9WGYqg4/g2E60ZUF2CXIZ+I0qQs09xN30/Fbx9zRsDI7t9d8gGqjI9dgMKZ3pSpugq6keRzHI55jRKUKAqRiFAobirBMUGAUUDkq6XTNTnBb2+MSZoKgB+JbD+CzRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726738268; c=relaxed/simple;
	bh=cocqJf9qFDdb+hQA+5XlcbWizJ+IyEXwxWfIVF4CRaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HBW4AFQFCPErNSGxPTpT9ZDq1gKTvo1/Trrtiv1yy9rR0BbeWzDy5m8HyUzeCGXWuIgSvNX8Y29kr0veSewxV2dYbN+2ytbip4+QJsBwK13/2DyqJm9mGDAoTIBB4RokpB08gGjg6wGvHRQMyYu15Q+C5UV3MGFpTSW4Ylrx2pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HhkyjU0k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726738264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=El7JI8+2LgE0w2F2wj8UHIF3zYFjg+wj70NciYCG0Lw=;
	b=HhkyjU0k1Ds2RLACDODJbgtxNkQm+8yeyiMWbAVEvujACqJuolvif4XB9tfH7iSg6/FCyS
	lW2oe8DnISRXFx6+jBS4tIUrj2OgGYNydQuqMo6+GkRegndKWBiwFmNxCLua0scDCuXfHH
	8UPm7KbuMXjuwXyxzIFbnPrmw1PGT90=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-8XlIbouIOzaHq1eRB55MZQ-1; Thu, 19 Sep 2024 05:31:03 -0400
X-MC-Unique: 8XlIbouIOzaHq1eRB55MZQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb940cd67so5580335e9.0
        for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 02:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726738261; x=1727343061;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=El7JI8+2LgE0w2F2wj8UHIF3zYFjg+wj70NciYCG0Lw=;
        b=l9BZyxUrcH3IUUDfugzq0frsrQ9Kz5Jwz7VEatWdl7oVGFZXWFz470OY30Nl4mdrVL
         3MNJ/rGnMayEdDAK8rPaZhe+HkbtHag4MkqMlubmvUd9f8sPuhubLtKO3ms5cHfmYiHQ
         KryKHoeU+V6xCrK/XnylABOhmL6nZp/0bvCXMG1CRPf7ipQQo2dKzNGYUy7jYnrHo9hW
         3hZgef9nYgAtyhKqsbGvQc7Bsn7WOOKzKOMpi+2siG4kgRy1c9ElAzYWFyJJA376/u1x
         djh434pyZiSXpTMiRC4S9cyCiHGJHYoOxwKzk+reKyvHhODoRr7mS1voZFQJ3eDvhBEZ
         BtEw==
X-Gm-Message-State: AOJu0YyKY9bucoJg0uwthc1xK2z3xJ67hWEsfnyJYu1MqchQHIBD8SC+
	yMn8MoXvV6WMSP10bKCJICiPRiTiu+25KRChkGELEYfj3Y60TTWmcab+sfUQ7+TlpobRCnpATTM
	lKqlhVudtyGnsDU8IclycMQn1KYoRXWCIioY2A7GEgb+GLJa5tNalH8jPzDnHJ305zjE=
X-Received: by 2002:a5d:5f88:0:b0:374:c8b7:63ec with SMTP id ffacd0b85a97d-378d61e2888mr26147879f8f.21.1726738261496;
        Thu, 19 Sep 2024 02:31:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3jdTEqB+CVKkkeeKdK1YyUbeojVU8ayBI2QL73aVCHFGaat2lToHZ4D7avxuyE3U1UZI5mg==
X-Received: by 2002:a5d:5f88:0:b0:374:c8b7:63ec with SMTP id ffacd0b85a97d-378d61e2888mr26147844f8f.21.1726738261015;
        Thu, 19 Sep 2024 02:31:01 -0700 (PDT)
Received: from [192.168.88.100] (146-241-67-136.dyn.eolo.it. [146.241.67.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e81e2sm14547911f8f.37.2024.09.19.02.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 02:31:00 -0700 (PDT)
Message-ID: <027597ba-4dc8-4837-975a-be23babb710b@redhat.com>
Date: Thu, 19 Sep 2024 11:30:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net] smc: use RCU version of lower netdev searching
To: "D. Wythe" <alibuda@linux.alibaba.com>,
 Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
 syzbot+c75d1de73d3b8b76272f@syzkaller.appspotmail.com,
 Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>
References: <20240912000446.1025844-1-xiyou.wangcong@gmail.com>
 <a054f2ef-c72f-4679-a123-003e0cf7839d@linux.alibaba.com>
 <ZuTehlEoyi4PPmQA@pop-os.localdomain>
 <e0842025-5e21-4755-8e60-1832e9cfe672@linux.alibaba.com>
 <ZuUDv8PLR4FHg+oC@pop-os.localdomain>
 <ad8da8d1-4ae4-41e2-a047-e4adc4c044f5@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ad8da8d1-4ae4-41e2-a047-e4adc4c044f5@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
On 9/18/24 04:23, D. Wythe wrote:
> On 9/14/24 11:32 AM, Cong Wang wrote:
>> On Sat, Sep 14, 2024 at 10:28:15AM +0800, D. Wythe wrote:
>>>
>>>
>>> On 9/14/24 8:53 AM, Cong Wang wrote:
>>>> On Thu, Sep 12, 2024 at 02:20:47PM +0800, D. Wythe wrote:
>>>>>
>>>>>
>>>>> On 9/12/24 8:04 AM, Cong Wang wrote:
>>>>>> From: Cong Wang <cong.wang@bytedance.com>
>>>>>>
>>>>>> Both netdev_walk_all_lower_dev() and netdev_lower_get_next() have a
>>>>>> RCU version, which are netdev_walk_all_lower_dev_rcu() and
>>>>>> netdev_next_lower_dev_rcu(). Switching to the RCU version would
>>>>>> eliminate the need for RTL lock, thus could amend the deadlock
>>>>>> complaints from syzbot. And it could also potentially speed up its
>>>>>> callers like smc_connect().
>>>>>>
>>>>>> Reported-by: syzbot+c75d1de73d3b8b76272f@syzkaller.appspotmail.com
>>>>>> Closes: https://syzkaller.appspot.com/bug?extid=c75d1de73d3b8b76272f
>>>>>> Cc: Wenjia Zhang <wenjia@linux.ibm.com>
>>>>>> Cc: Jan Karcher <jaka@linux.ibm.com>
>>>>>> Cc: "D. Wythe" <alibuda@linux.alibaba.com>
>>>>>> Cc: Tony Lu <tonylu@linux.alibaba.com>
>>>>>> Cc: Wen Gu <guwen@linux.alibaba.com>
>>>>>> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
>>>>>
>>>>>
>>>>> Haven't looked at your code yet, but the issue you fixed doesn't exist.
>>>>> The real reason is that we lacks some lockdep annotations for
>>>>> IPPROTO_SMC.
>>>>
>>>> If you look at the code, it is not about sock lock annotations, it is
>>>> about RTNL lock which of course has annotations.
>>>>
>>>
>>> If so, please explain the deadlock issue mentioned in sysbot and
>>> how it triggers deadlocks.
>>
>> Sure, but what questions do you have here? To me, the lockdep output is
>> self-explained. Please kindly let me know if you have any troubles
>> understanding it, I am always happy to help.
>>
>> Thanks.
> 
> Just explain (https://syzkaller.appspot.com/bug?extid=c75d1de73d3b8b76272f)
> 
> -> #1 (sk_lock-AF_INET6){+.+.}-{0:0}:
>          lock_sock_nested+0x3a/0xf0 net/core/sock.c:3543
>          lock_sock include/net/sock.h:1607 [inline]
>          sockopt_lock_sock net/core/sock.c:1061 [inline]
>          sockopt_lock_sock+0x54/0x70 net/core/sock.c:1052
>          do_ipv6_setsockopt+0x216a/0x47b0 net/ipv6/ipv6_sockglue.c:567
>          ipv6_setsockopt+0xe3/0x1a0 net/ipv6/ipv6_sockglue.c:993
>          udpv6_setsockopt+0x7d/0xd0 net/ipv6/udp.c:1702
>          do_sock_setsockopt+0x222/0x480 net/socket.c:2324
>          __sys_setsockopt+0x1a4/0x270 net/socket.c:2347
>          __do_sys_setsockopt net/socket.c:2356 [inline]
>          __se_sys_setsockopt net/socket.c:2353 [inline]
>          __x64_sys_setsockopt+0xbd/0x160 net/socket.c:2353
>          do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>          do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>          entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Why is that udpv6_setsockopt was reported here.

If I read correctly, your doubt is somewhat alike the following: the SMC 
code does not call UDP sockopt-related function, so the above stacktrace 
refers to a non SMC socket and the reported splat is really harmless, as 
no deadlock will really happens (UDP sockets do not acquire nested rtnl 
lock, smc does not acquire nested socket lock).

Still the splat happens we need - or at least we should - address it, 
because this splat prevents syzkaller from finding other possibly more 
significant issues.

One way for addressing the splat would be adding the proper annotation 
to the socket lock. Another way is the present patch, which looks legit 
to me and should give performances benefit (every time we don't need to 
acquire the rtnl lock is a win!)

@Wythe: does the above clarify a bit?

Thanks!

Paolo


