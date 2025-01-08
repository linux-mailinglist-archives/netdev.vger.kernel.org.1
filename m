Return-Path: <netdev+bounces-156254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A32A05B83
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 13:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D6103A45B9
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 12:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AC61F9F5A;
	Wed,  8 Jan 2025 12:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lOd224tr"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B355B1F9A9C
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 12:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736339122; cv=none; b=JgoGg6TT/iQ/mO7WpNCwzG6TNStBeAuDGZkfXvSjkRqHm3/jAC6KIDQ8hQiZvlipoo+ay2b1hLRD8uQEZ95N0xUgZMR6lF4+Ba2rU3Ze8nwAsdVEv+6UWATgfy2/mR3pdDK0PUtdM38U6xOf3/Ka6/YAQlACgJIFwlROUnlaZYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736339122; c=relaxed/simple;
	bh=65g/g/4WJkhxlIqd9Nrt1PttwoKaNrjDxhYBVXt0f7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukeP8yDnccKrUk5p09z26Ks5N5Pzn3h5uzMlKkjZ0eLk3iotD6YyblbuyGcego/FKickhCnlImmf7V9CXgBimKMp3q86fJXjUYKyw3a2/S3aMOwmEneUuNYDyG8JlmlvBhE3MI6yV4VlYLliTH9GC0/XKmHv/eO5Meoi2sS9o5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lOd224tr; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736339112; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LzHtEUeCMYU3UuQbLzZGZ+pgHGJ++zXUzU8c6VW/R+0=;
	b=lOd224truPwVnA1T04lRFPqDpmvp7lTMo/c+8MMY6QLW4UVHKNcV3oDfbqjmxMsk63BPw2C1bUIHZfL2vYyOWuKRrIUCWYF6wRH09sGn90jCGxAXPq8jb4tTENywJWIG9Z/GPD25Bl3oZpBV9sgPyHzhjuCwxltxYxD2vaaySpQ=
Received: from 30.221.178.144(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WNDwvMP_1736339110 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 08 Jan 2025 20:25:11 +0800
Message-ID: <a1f091fc-727d-470a-835a-863501f28364@linux.alibaba.com>
Date: Wed, 8 Jan 2025 20:25:10 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] udp: fix l4 hash after reconnect
To: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Fred Chen <fred.cc@alibaba-inc.com>,
 Cambda Zhu <cambda@linux.alibaba.com>, Willem de Bruijn
 <willemb@google.com>, Stefano Brivio <sbrivio@redhat.com>
References: <4761e466ab9f7542c68cdc95f248987d127044d2.1733499715.git.pabeni@redhat.com>
 <CANn89i+aKNhzYKo3H3gx5Uhy4iPQ4p=6WDDF-0brGyR=PzJqjQ@mail.gmail.com>
 <CANn89i+k11E9XeJZwvgZ7VO0yr1nWge8+U-ESw2GLYDq7-sdBw@mail.gmail.com>
 <b46a7757-f311-4656-a114-68381d9856e3@redhat.com>
 <a4085013-daaf-4141-af56-cd438bf8b4c9@linux.alibaba.com>
 <63b0f262-066a-4f7b-b55a-a7f0ed4aa7f4@redhat.com>
 <febf62f6-7439-4628-ad47-041ebbb86ede@linux.alibaba.com>
 <939fa561-841e-442a-be0b-0e71c6843e5c@redhat.com>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <939fa561-841e-442a-be0b-0e71c6843e5c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2025/1/7 15:56, Paolo Abeni wrote:
> Hi,
> 
> I'm sorry for the latency, I was off in the past days.
> 
> On 12/31/24 8:55 AM, Philo Lu wrote:
>> On 2024/12/10 16:32, Paolo Abeni wrote:
>>> On 12/7/24 03:34, Philo Lu wrote:
>>>> On 2024/12/7 00:23, Paolo Abeni wrote:
>>>>> On 12/6/24 17:01, Eric Dumazet wrote:
>>>>>> BTW, it seems that udp_lib_rehash() does the udp_rehash4()
>>>>>> only if the hash2 has changed.
>>>>>
>>>>> Oh, you are right, that requires a separate fix.
>>>>>
>>>>> @Philo: could you please have a look at that? basically you need to
>>>>> check separately for hash2 and hash4 changes.
>>>>
>>>> This is a good question. IIUC, the only affected case is when trying to
>>>> re-connect another remote address with the same local address
>>>
>>> AFAICS, there is also another case: when re-connection using a different
>>> local addresses with the same l2 hash...
>>>
>>>> (i.e.,
>>>> hash2 unchanged). And this will be handled by udp_lib_hash4(). So in
>>>> udp_lib_rehash() I put rehash4() inside hash2 checking, which means a
>>>> passive rehash4 following rehash2.
>>>
>>> ... but even the latter case should be covered from the above.
>>>
>>>> So I think it's more about the convention for rehash. We can choose the
>>>> better one.
>>>
>>> IIRC a related question raised during code review for the udp L4 hash
>>> patches. Perhaps refactoring the code slightly to let udp_rehash()
>>> really doing the re-hashing and udp_hash really doing only the hashing
>>> could be worth.
>>>
>>
>> I'm trying to unify rehash() for both hash2 and hash4 in
>> __ip4_datagram_connect, when I noticed the inet_rcv_saddr checking
>> before calling rehash():
>>
>> ```
>> if (!inet->inet_rcv_saddr) {
>> 	inet->inet_rcv_saddr = fl4->saddr;
>> 	if (sk->sk_prot->rehash)
>> 		sk->sk_prot->rehash(sk);
>> }
>> ```
>> This means inet_rcv_saddr is reset at most once no matter how many times
>> connect() is called.
> 
> ... if you make consecutive connect(<dst address>) calls.
> 
>   __udp_disconnect() clears saddr, so:
> 
> connect(<AF_UNSPEC>); connect(<dst address>);
> 
> will yield the expected result
> 
>> I'm not sure if this is by-design for some reason?
>> Or can I remove this checking? like:
>>
>> --- a/net/ipv4/datagram.c
>> +++ b/net/ipv4/datagram.c
>> @@ -67,11 +67,9 @@ int __ip4_datagram_connect(struct sock *sk, struct
>> sockaddr *uaddr, int addr_len
>>           inet->inet_dport = usin->sin_port;
>>           if (!inet->inet_saddr)
>>                   inet->inet_saddr = fl4->saddr;
>> -       if (!inet->inet_rcv_saddr) {
>> -               inet->inet_rcv_saddr = fl4->saddr;
>> -               if (sk->sk_prot->rehash)
>> -                       sk->sk_prot->rehash(sk);
>> -       }
>> +       inet->inet_rcv_saddr = fl4->saddr;
>> +       if (sk->sk_prot->rehash)
>> +               sk->sk_prot->rehash(sk);
>>           reuseport_has_conns_set(sk);
>>           sk->sk_state = TCP_ESTABLISHED;
>>           sk_set_txhash(sk);
> 
> This sounds like an unexpected behaviour change which may broke existing
> applications.
> 
> I suggest retaining the current beheviour.
> 

Thank you for your suggestion. I've sent a fix patch for rehash4 (with 
few build errors I'll solve soon), leaving __ip4_datagram_connect() 
unchanged.

-- 
Philo


