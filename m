Return-Path: <netdev+bounces-139022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B05F29AFD82
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 11:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC752812FC
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 09:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3511D460E;
	Fri, 25 Oct 2024 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dEhdXP9z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9307B18C93E
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 09:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846943; cv=none; b=FP0x5KQWzPiehjo18IW7LIAPqxgVR/xmDVqw63ynxyeKvyfJV3scVA30w4C8+w+tVru++f/BQeluOfyjg00dkKgVOeGxks2XRbDFEjkB3pKT033EMcl/k0nuKOJiKnDGpcmo0k5awmZpTgXyXpsyCr8VTk+XJ1kiNBWeldFptWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846943; c=relaxed/simple;
	bh=r5M6mZuE88sOuVWOLOscicgaixmHpM6cVFDzDfu2VYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X3PRM1I3FETJZLOmFtjheGHwa8m+7+dw8wFtBUFzeEylltgYFVnKrxMKu/zhbhjzBxuWNbBweu8O/L6SXBIItqNWhWpRMFq8gBteAxPZEVlOGb0S9q7qgHXH3K3xHKmXIeUMSGD9/EhMP0pFYI/csD/vlDe3G3yVKeAjwhIkPBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dEhdXP9z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729846940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZfhrTngfM57HMIfFGEzWPnYKXDDrrYdK30yFoITPvn0=;
	b=dEhdXP9z0tmipBjMk92BKa1ItV4nc1WsdRe2M/WwhEK0CajbbaHvJRRNCNCktXtLYAbzkC
	CcTbu1lOt+oSWYbNRBuEem2z3a98rdPTyzqSOZMGqmk3i0sa87197zOs9UDsaOqlHk7eqz
	edYQD2XtXCX98LYh1GJZqocJluNP25o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-SzfKhkTwM7Gpt9H-dZ8DEQ-1; Fri, 25 Oct 2024 05:02:19 -0400
X-MC-Unique: SzfKhkTwM7Gpt9H-dZ8DEQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d49887a2cso954310f8f.0
        for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 02:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729846938; x=1730451738;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfhrTngfM57HMIfFGEzWPnYKXDDrrYdK30yFoITPvn0=;
        b=roCcCZ8rut0ocyMdN1Cec1Rc1hNDf2Mh7bSdeh3VFHU9UMxIPZZuDaunSSslX8kH5C
         UcZVuF4CAIRx/CAishJGAjnEUDGZqufqgnMFnz1ITgkjZMuD5ccR+9qbFf5cgIfKiHbQ
         DoqhV1OtbPlMhm6rw6r0P5aoyysYsbx8JUB1iyVk/3HXk90KvjmpjchRyg1Th1KmH+cF
         T3tSWr1dB69MdQcv5ZTUStK60U1QkaO+58MK5nxk7XD0bPr9ZAwDSxYHIrulJjqRxR0L
         ZxKQbefuEMbHlhM9rIDSs5ZwAVES//I2PBXORtLraOqHOGCtplYAwe4xAZ42zc0UCTg2
         GpSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdtsmbv9SCl0PdUM+hAdzAnr0ik99wWZ1vDvQjqlCf7bCe6BS/8YJfsa0axWQEydvwCw9vADg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuliDtyKVvxkLgiRrHoxTSt/BgUhEUftoNYb/+o/QYCxvBMNqo
	dInpU8448yjKFo9Jb99Al+WGiRmEKktH+GxScFp/y96qe/9aX29e/bwn8ImkJ8K6FPqzamxLEV6
	U+/b+Z8s2O+NgluwBirW22WQ0cjA2azQTSN0MVEl1qj61k6sXEhOCMA==
X-Received: by 2002:a05:6000:c6:b0:37d:3f81:153f with SMTP id ffacd0b85a97d-3803ac0670fmr3631792f8f.17.1729846937844;
        Fri, 25 Oct 2024 02:02:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGogjfR6qKx/91KErMxxRp0/mnMMFQGkL6EzcQdmtlyrtRJESDnhf7d8Nfw7jYiYWhD15vfsQ==
X-Received: by 2002:a05:6000:c6:b0:37d:3f81:153f with SMTP id ffacd0b85a97d-3803ac0670fmr3631660f8f.17.1729846936131;
        Fri, 25 Oct 2024 02:02:16 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70d50sm986996f8f.76.2024.10.25.02.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 02:02:15 -0700 (PDT)
Message-ID: <ad78a2bb-9dc4-4f80-9011-b49fd721a425@redhat.com>
Date: Fri, 25 Oct 2024 11:02:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 3/3] ipv4/udp: Add 4-tuple hash for connected
 socket
To: Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org
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
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <80fbd73f-ce75-44bf-a444-116217a50c91@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/25/24 05:50, Philo Lu wrote:
> On 2024/10/24 23:01, Paolo Abeni wrote:
>> On 10/18/24 13:45, Philo Lu wrote:
>> [...]
>>> +/* In hash4, rehash can also happen in connect(), where hash4_cnt keeps unchanged. */
>>> +static void udp4_rehash4(struct udp_table *udptable, struct sock *sk, u16 newhash4)
>>> +{
>>> +	struct udp_hslot *hslot4, *nhslot4;
>>> +
>>> +	hslot4 = udp_hashslot4(udptable, udp_sk(sk)->udp_lrpa_hash);
>>> +	nhslot4 = udp_hashslot4(udptable, newhash4);
>>> +	udp_sk(sk)->udp_lrpa_hash = newhash4;
>>> +
>>> +	if (hslot4 != nhslot4) {
>>> +		spin_lock_bh(&hslot4->lock);
>>> +		hlist_del_init_rcu(&udp_sk(sk)->udp_lrpa_node);
>>> +		hslot4->count--;
>>> +		spin_unlock_bh(&hslot4->lock);
>>> +
>>> +		synchronize_rcu();
>>
>> This deserve a comment explaining why it's needed. I had to dig in past
>> revision to understand it.
>>
> 
> Got it. And a short explanation here (see [1] for detail):
> 
> Here, we move a node from a hlist to another new one, i.e., update 
> node->next from the old hlist to the new hlist. For readers traversing 
> the old hlist, if we update node->next just when readers move onto the 
> moved node, then the readers also move to the new hlist. This is unexpected.
> 
>      Reader(lookup)     Writer(rehash)
>      -----------------  ---------------
> 1. rcu_read_lock()
> 2. pos = sk;
> 3.                     hlist_del_init_rcu(sk, old_slot)
> 4.                     hlist_add_head_rcu(sk, new_slot)
> 5. pos = pos->next; <=
> 6. rcu_read_unlock()
> 
> [1]
> https://lore.kernel.org/all/0fb425e0-5482-4cdf-9dc1-3906751f8f81@linux.alibaba.com/

Thanks. AFAICS the problem that such thing could cause is a lookup
failure for a socket positioned later in the same chain when a previous
entry is moved on a different slot during a concurrent lookup.

I think that could be solved the same way TCP is handling such scenario:
using hlist_null RCU list for the hash4 bucket, checking that a failed
lookup ends in the same bucket where it started and eventually
reiterating from the original bucket.

Have a look at __inet_lookup_established() for a more descriptive
reference, especially:

https://elixir.bootlin.com/linux/v6.12-rc4/source/net/ipv4/inet_hashtables.c#L528

>>> +
>>> +		spin_lock_bh(&nhslot4->lock);
>>> +		hlist_add_head_rcu(&udp_sk(sk)->udp_lrpa_node, &nhslot4->head);
>>> +		nhslot4->count++;
>>> +		spin_unlock_bh(&nhslot4->lock);
>>> +	}
>>> +}
>>> +
>>> +static void udp4_unhash4(struct udp_table *udptable, struct sock *sk)
>>> +{
>>> +	struct udp_hslot *hslot2, *hslot4;
>>> +
>>> +	if (udp_hashed4(sk)) {
>>> +		hslot2 = udp_hashslot2(udptable, udp_sk(sk)->udp_portaddr_hash);
>>> +		hslot4 = udp_hashslot4(udptable, udp_sk(sk)->udp_lrpa_hash);
>>> +
>>> +		spin_lock(&hslot4->lock);
>>> +		hlist_del_init_rcu(&udp_sk(sk)->udp_lrpa_node);
>>> +		hslot4->count--;
>>> +		spin_unlock(&hslot4->lock);
>>> +
>>> +		spin_lock(&hslot2->lock);
>>> +		udp_hash4_dec(hslot2);
>>> +		spin_unlock(&hslot2->lock);
>>> +	}
>>> +}
>>> +
>>> +/* call with sock lock */
>>> +static void udp4_hash4(struct sock *sk)
>>> +{
>>> +	struct udp_hslot *hslot, *hslot2, *hslot4;
>>> +	struct net *net = sock_net(sk);
>>> +	struct udp_table *udptable;
>>> +	unsigned int hash;
>>> +
>>> +	if (sk_unhashed(sk) || inet_sk(sk)->inet_rcv_saddr == htonl(INADDR_ANY))
>>> +		return;
>>> +
>>> +	hash = udp_ehashfn(net, inet_sk(sk)->inet_rcv_saddr, inet_sk(sk)->inet_num,
>>> +			   inet_sk(sk)->inet_daddr, inet_sk(sk)->inet_dport);
>>> +
>>> +	udptable = net->ipv4.udp_table;
>>> +	if (udp_hashed4(sk)) {
>>> +		udp4_rehash4(udptable, sk, hash);
>>
>> It's unclear to me how we can enter this branch. Also it's unclear why
>> here you don't need to call udp_hash4_inc()udp_hash4_dec, too. Why such
>> accounting can't be placed in udp4_rehash4()?
>>
> 
> It's possible that a connected udp socket _re-connect_ to another remote 
> address. Then, because the local address is not changed, hash2 and its 
> hash4_cnt keep unchanged. But rehash4 need to be done.
> I'll also add a comment here.

Right, UDP socket could actually connect() successfully twice in a row
without a disconnect in between...

I almost missed the point that the ipv6 implementation is planned to
land afterwards.

I'm sorry, but I think that would be problematic - i.e. if ipv4 support
will land in 6.13, but ipv6 will not make it - due to time constraints -
we will have (at least a release with inconsistent behavior between ipv4
and ipv6. I think it will be better bundle such changes together.

Thanks,

Paolo


