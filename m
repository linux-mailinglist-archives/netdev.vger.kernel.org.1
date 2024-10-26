Return-Path: <netdev+bounces-139278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D95C9B1415
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 03:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD801C21528
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 01:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E54B2AE69;
	Sat, 26 Oct 2024 01:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZiFl9pXG"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48C5217F38;
	Sat, 26 Oct 2024 01:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729907129; cv=none; b=DaDa+4Nx9IpNOd2uOnk2RpAs5IX3OZPklBUAK/ou+0DNSz3rwTxP96hKhjGkTtnkam94BXcyfcJLKIy06bclsH8c7OI71JF8uuAsF2oKUzGrsAlsvsGhWccC9CzDsey69rBvT6c51t2hcllm76EwIFA1PkMBMtBwi4zjXpifEc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729907129; c=relaxed/simple;
	bh=C5rlSrSq+PgamV78k5HVwdelHn3s+iACPNFmVLodQSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tei3pb6gZUjXnwOl818WQU0xRPXicyNmBxXcb4XJ2QtDvvQjmVWVCnaZfRY1n0KzKFYZcOgswv9dp2tmtcIj16rPBO29vkW8agYw5Dtvus+CjKV1EgX1NMDBNfhc/gn8Z2TQJwqw06KzRMgkjajkrzd3BNCGlNUlddTOoIOx5sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZiFl9pXG; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729907118; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0l3yIwgoWoL0tCyh89mUAlT7tbkPIvMt+0P/7Vp3Nwg=;
	b=ZiFl9pXG77ZzDBKCBvPTzoi+xVSW/G0aPJxtGHOzmFFAl397GHT0zDOzKBTmeXuBXak0Wqx9WO10OR9KoGm4dB1PLE9oX4UMMCZbHTkDhOV5LDrglXgWeQEf7a97birRTrN9+OhfIYPHvnEaHQDgA4C0N/HT8UtMEVO8DT1AlF8=
Received: from 30.170.3.10(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WHtjziJ_1729906797 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 26 Oct 2024 09:39:58 +0800
Message-ID: <c1eca766-d5e7-4fd8-8ffa-9301f060d6c9@linux.alibaba.com>
Date: Sat, 26 Oct 2024 09:39:57 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 3/3] ipv4/udp: Add 4-tuple hash for connected
 socket
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, dsahern@kernel.org,
 antony.antony@secunet.com, steffen.klassert@secunet.com,
 linux-kernel@vger.kernel.org, dust.li@linux.alibaba.com,
 jakub@cloudflare.com, fred.cc@alibaba-inc.com,
 yubing.qiuyubing@alibaba-inc.com
References: <20241018114535.35712-1-lulie@linux.alibaba.com>
 <20241018114535.35712-4-lulie@linux.alibaba.com>
 <b232a642-2f0d-4bac-9bcf-50d653ea875d@redhat.com>
 <80fbd73f-ce75-44bf-a444-116217a50c91@linux.alibaba.com>
 <ad78a2bb-9dc4-4f80-9011-b49fd721a425@redhat.com>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <ad78a2bb-9dc4-4f80-9011-b49fd721a425@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/25 17:02, Paolo Abeni wrote:
> On 10/25/24 05:50, Philo Lu wrote:
>> On 2024/10/24 23:01, Paolo Abeni wrote:
>>> On 10/18/24 13:45, Philo Lu wrote:
>>> [...]
>>>> +/* In hash4, rehash can also happen in connect(), where hash4_cnt keeps unchanged. */
>>>> +static void udp4_rehash4(struct udp_table *udptable, struct sock *sk, u16 newhash4)
>>>> +{
>>>> +	struct udp_hslot *hslot4, *nhslot4;
>>>> +
>>>> +	hslot4 = udp_hashslot4(udptable, udp_sk(sk)->udp_lrpa_hash);
>>>> +	nhslot4 = udp_hashslot4(udptable, newhash4);
>>>> +	udp_sk(sk)->udp_lrpa_hash = newhash4;
>>>> +
>>>> +	if (hslot4 != nhslot4) {
>>>> +		spin_lock_bh(&hslot4->lock);
>>>> +		hlist_del_init_rcu(&udp_sk(sk)->udp_lrpa_node);
>>>> +		hslot4->count--;
>>>> +		spin_unlock_bh(&hslot4->lock);
>>>> +
>>>> +		synchronize_rcu();
>>>
>>> This deserve a comment explaining why it's needed. I had to dig in past
>>> revision to understand it.
>>>
>>
>> Got it. And a short explanation here (see [1] for detail):
>>
>> Here, we move a node from a hlist to another new one, i.e., update
>> node->next from the old hlist to the new hlist. For readers traversing
>> the old hlist, if we update node->next just when readers move onto the
>> moved node, then the readers also move to the new hlist. This is unexpected.
>>
>>       Reader(lookup)     Writer(rehash)
>>       -----------------  ---------------
>> 1. rcu_read_lock()
>> 2. pos = sk;
>> 3.                     hlist_del_init_rcu(sk, old_slot)
>> 4.                     hlist_add_head_rcu(sk, new_slot)
>> 5. pos = pos->next; <=
>> 6. rcu_read_unlock()
>>
>> [1]
>> https://lore.kernel.org/all/0fb425e0-5482-4cdf-9dc1-3906751f8f81@linux.alibaba.com/
> 
> Thanks. AFAICS the problem that such thing could cause is a lookup
> failure for a socket positioned later in the same chain when a previous
> entry is moved on a different slot during a concurrent lookup.
> 

Yes, you're right.

> I think that could be solved the same way TCP is handling such scenario:
> using hlist_null RCU list for the hash4 bucket, checking that a failed
> lookup ends in the same bucket where it started and eventually
> reiterating from the original bucket.
> 
> Have a look at __inet_lookup_established() for a more descriptive
> reference, especially:
> 
> https://elixir.bootlin.com/linux/v6.12-rc4/source/net/ipv4/inet_hashtables.c#L528
> 

Thank you! I'll try it in the next version.

>>>> +
...
>>>> +
>>>> +/* call with sock lock */
>>>> +static void udp4_hash4(struct sock *sk)
>>>> +{
>>>> +	struct udp_hslot *hslot, *hslot2, *hslot4;
>>>> +	struct net *net = sock_net(sk);
>>>> +	struct udp_table *udptable;
>>>> +	unsigned int hash;
>>>> +
>>>> +	if (sk_unhashed(sk) || inet_sk(sk)->inet_rcv_saddr == htonl(INADDR_ANY))
>>>> +		return;
>>>> +
>>>> +	hash = udp_ehashfn(net, inet_sk(sk)->inet_rcv_saddr, inet_sk(sk)->inet_num,
>>>> +			   inet_sk(sk)->inet_daddr, inet_sk(sk)->inet_dport);
>>>> +
>>>> +	udptable = net->ipv4.udp_table;
>>>> +	if (udp_hashed4(sk)) {
>>>> +		udp4_rehash4(udptable, sk, hash);
>>>
>>> It's unclear to me how we can enter this branch. Also it's unclear why
>>> here you don't need to call udp_hash4_inc()udp_hash4_dec, too. Why such
>>> accounting can't be placed in udp4_rehash4()?
>>>
>>
>> It's possible that a connected udp socket _re-connect_ to another remote
>> address. Then, because the local address is not changed, hash2 and its
>> hash4_cnt keep unchanged. But rehash4 need to be done.
>> I'll also add a comment here.
> 
> Right, UDP socket could actually connect() successfully twice in a row
> without a disconnect in between...
> 
> I almost missed the point that the ipv6 implementation is planned to
> land afterwards.
> 
> I'm sorry, but I think that would be problematic - i.e. if ipv4 support
> will land in 6.13, but ipv6 will not make it - due to time constraints -
> we will have (at least a release with inconsistent behavior between ipv4
> and ipv6. I think it will be better bundle such changes together.
> 

No problem. I can add ipv6 support in the next version too.

Thanks.
-- 
Philo


