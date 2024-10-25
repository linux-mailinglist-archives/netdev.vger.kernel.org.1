Return-Path: <netdev+bounces-138958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FF09AF879
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 05:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98743B216EA
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 03:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715E0502BE;
	Fri, 25 Oct 2024 03:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TmGZTsw6"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE3C23B0;
	Fri, 25 Oct 2024 03:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729828251; cv=none; b=UHLgA+3N9I9USAaKES5MHLqVggEtFe0ux5P792IZvl4RC1GA4PQkH9SwsCLehtseAgJk/JkVu5DDCOup4ibQGP2G/oQpqoFsu4XP4UN6l0k1WSpJTle5UAvM2xKMbDL7u3U63Juso7GirTvATlBjv32Q1HXxeKoZPbBXm/yssP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729828251; c=relaxed/simple;
	bh=BAfCx1BUhJEiTvQh+lxJIaEH29wG0UZqb0XAr0QgVMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BAdYoVXRN0d6bTRscuKcIIo303oR6dXrw+L1wxm0e85xFtmzLO/r4cRk26AftHZYnhqbzBeRoHTTMsDLqRYyBOTA6KVwmZmwQQ7SlXGvpAN5VhSOEikHGkUtUXklEdSxussKAwwOvpcE1P3maOB5Elrk9dzljmItJSDEHHeTkbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TmGZTsw6; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729828244; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=csXrtLmLvSSe1liKlQmsgcqYt2pEi6/QWS4TVjAn6dI=;
	b=TmGZTsw6sbPcd36rUFfg7zARhHdA+UJHiaVEFLnzO0a4k6k3jGOC54Xit+5jDN5qeJmQ1aSCsiSsHRBbtviyGv4XMPZmK6c9hiiOAasUqEq+qvTDalrxlF8bgdgyM+PbePttvfQNGo995duSeckbwzXExv7NzkkYw3xRKu2dcTQ=
Received: from 30.221.128.174(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WHqz3cK_1729828242 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Oct 2024 11:50:43 +0800
Message-ID: <80fbd73f-ce75-44bf-a444-116217a50c91@linux.alibaba.com>
Date: Fri, 25 Oct 2024 11:50:42 +0800
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
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <b232a642-2f0d-4bac-9bcf-50d653ea875d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/24 23:01, Paolo Abeni wrote:
> On 10/18/24 13:45, Philo Lu wrote:
> [...]
>> +/* In hash4, rehash can also happen in connect(), where hash4_cnt keeps unchanged. */
>> +static void udp4_rehash4(struct udp_table *udptable, struct sock *sk, u16 newhash4)
>> +{
>> +	struct udp_hslot *hslot4, *nhslot4;
>> +
>> +	hslot4 = udp_hashslot4(udptable, udp_sk(sk)->udp_lrpa_hash);
>> +	nhslot4 = udp_hashslot4(udptable, newhash4);
>> +	udp_sk(sk)->udp_lrpa_hash = newhash4;
>> +
>> +	if (hslot4 != nhslot4) {
>> +		spin_lock_bh(&hslot4->lock);
>> +		hlist_del_init_rcu(&udp_sk(sk)->udp_lrpa_node);
>> +		hslot4->count--;
>> +		spin_unlock_bh(&hslot4->lock);
>> +
>> +		synchronize_rcu();
> 
> This deserve a comment explaining why it's needed. I had to dig in past
> revision to understand it.
> 

Got it. And a short explanation here (see [1] for detail):

Here, we move a node from a hlist to another new one, i.e., update 
node->next from the old hlist to the new hlist. For readers traversing 
the old hlist, if we update node->next just when readers move onto the 
moved node, then the readers also move to the new hlist. This is unexpected.

     Reader(lookup)     Writer(rehash)
     -----------------  ---------------
1. rcu_read_lock()
2. pos = sk;
3.                     hlist_del_init_rcu(sk, old_slot)
4.                     hlist_add_head_rcu(sk, new_slot)
5. pos = pos->next; <=
6. rcu_read_unlock()

[1]
https://lore.kernel.org/all/0fb425e0-5482-4cdf-9dc1-3906751f8f81@linux.alibaba.com/

>> +
>> +		spin_lock_bh(&nhslot4->lock);
>> +		hlist_add_head_rcu(&udp_sk(sk)->udp_lrpa_node, &nhslot4->head);
>> +		nhslot4->count++;
>> +		spin_unlock_bh(&nhslot4->lock);
>> +	}
>> +}
>> +
>> +static void udp4_unhash4(struct udp_table *udptable, struct sock *sk)
>> +{
>> +	struct udp_hslot *hslot2, *hslot4;
>> +
>> +	if (udp_hashed4(sk)) {
>> +		hslot2 = udp_hashslot2(udptable, udp_sk(sk)->udp_portaddr_hash);
>> +		hslot4 = udp_hashslot4(udptable, udp_sk(sk)->udp_lrpa_hash);
>> +
>> +		spin_lock(&hslot4->lock);
>> +		hlist_del_init_rcu(&udp_sk(sk)->udp_lrpa_node);
>> +		hslot4->count--;
>> +		spin_unlock(&hslot4->lock);
>> +
>> +		spin_lock(&hslot2->lock);
>> +		udp_hash4_dec(hslot2);
>> +		spin_unlock(&hslot2->lock);
>> +	}
>> +}
>> +
>> +/* call with sock lock */
>> +static void udp4_hash4(struct sock *sk)
>> +{
>> +	struct udp_hslot *hslot, *hslot2, *hslot4;
>> +	struct net *net = sock_net(sk);
>> +	struct udp_table *udptable;
>> +	unsigned int hash;
>> +
>> +	if (sk_unhashed(sk) || inet_sk(sk)->inet_rcv_saddr == htonl(INADDR_ANY))
>> +		return;
>> +
>> +	hash = udp_ehashfn(net, inet_sk(sk)->inet_rcv_saddr, inet_sk(sk)->inet_num,
>> +			   inet_sk(sk)->inet_daddr, inet_sk(sk)->inet_dport);
>> +
>> +	udptable = net->ipv4.udp_table;
>> +	if (udp_hashed4(sk)) {
>> +		udp4_rehash4(udptable, sk, hash);
> 
> It's unclear to me how we can enter this branch. Also it's unclear why
> here you don't need to call udp_hash4_inc()udp_hash4_dec, too. Why such
> accounting can't be placed in udp4_rehash4()?
> 

It's possible that a connected udp socket _re-connect_ to another remote 
address. Then, because the local address is not changed, hash2 and its 
hash4_cnt keep unchanged. But rehash4 need to be done.

I'll also add a comment here.

> [...]
>> @@ -2031,6 +2180,19 @@ void udp_lib_rehash(struct sock *sk, u16 newhash)
>>   				spin_unlock(&nhslot2->lock);
>>   			}
>>   
>> +			if (udp_hashed4(sk)) {
>> +				udp4_rehash4(udptable, sk, newhash4);
>> +
>> +				if (hslot2 != nhslot2) {
>> +					spin_lock(&hslot2->lock);
>> +					udp_hash4_dec(hslot2);
>> +					spin_unlock(&hslot2->lock);
>> +
>> +					spin_lock(&nhslot2->lock);
>> +					udp_hash4_inc(nhslot2);
>> +					spin_unlock(&nhslot2->lock);
>> +				}
>> +			}
>>   			spin_unlock_bh(&hslot->lock);
> 
> The udp4_rehash4() call above is in atomic context and could end-up
> calling synchronize_rcu() which is a blocking function. You must avoid that.
> 

I see, synchronize_rcu() cannot be used with spinlock. However, I don't 
have a good idea to solve it by now. Do you have any thoughts or 
suggestions?

> Cheers,
> 
> Paolo

Thanks for your reviewing, Paolo. I'll address all your concerns in the 
next version.

-- 
Philo


