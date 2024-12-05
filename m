Return-Path: <netdev+bounces-149487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E8A9E5C42
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 17:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0EA118872FA
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 16:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B179222593;
	Thu,  5 Dec 2024 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9C6OSkH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE48221457
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733417623; cv=none; b=RYrw/NrPYo+SChBXwWB2r3Hczw9wNxjXr63ubnsrpyTLPOBB9iSpY0gWHxFUVKqgJ66Sn+Ijqo7gGWzq4THWaCO+tgdFuAgf/4WNByg0XLPTUcO3GUJsMAfYqfIdOKCwH0qJSUiNLXM8Xc9GwmG/CLvAz2xg9esahRcR6V1uBdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733417623; c=relaxed/simple;
	bh=bO62y5T8z+I9hXX2y2XqOVi6G0Y0QVDLyjKBT1VnEVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/Rn6gOdzrqvQORqbao+qm73xmXOjiWZgE1WknMvPufH98tb2n/d/UZ0lwTjqmhQ2xJT0EYnsCd63oaV1WdWNSFYDFlHe3ayrJDoMXl2xi5A754q+n/jzP/SQUgtQXb6cLHRkj4zcgLhZuXv5DB5CMjvRwHeLIXe8jRxWY6NjDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q9C6OSkH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733417620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfhLlnWmP3I0Ms9dbo9yF7ekLQA4Nz3MCuFuLI4IlJw=;
	b=Q9C6OSkH+rGJa866Knos8g2HCXzlukFBgScnplJcZlURocsyxj2ruUfpGD7DQeKsK3Y0SE
	ZvtKSv6f4slG0X4VN3REYXpqwccbgbq/j6s/FYW4enk0WQYcbbnU6ESNqd/dAjRpCI7PmY
	e8WSQFKb2rgjVFgDpHnuZ2dL7tb7otU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-6oKmbJwJNQi51tZ0dQPW_g-1; Thu, 05 Dec 2024 11:53:38 -0500
X-MC-Unique: 6oKmbJwJNQi51tZ0dQPW_g-1
X-Mimecast-MFC-AGG-ID: 6oKmbJwJNQi51tZ0dQPW_g
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d884e46548so22732136d6.2
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 08:53:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733417617; x=1734022417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PfhLlnWmP3I0Ms9dbo9yF7ekLQA4Nz3MCuFuLI4IlJw=;
        b=t5+VgYCnCSAoib+08kkpNrlOx1zxutT8SPhHjvh7EN6dopzVpb+yeUBsrYLvZVru1+
         9DMJ51b5WnOWvL61FFpKWfhexOsmOB7Or3iDwfForg9TKJiJPFgz6/NOBRZsvpv1NTAt
         Rdj47+Zr8WE7HZd3VKmgYjg3oEselRWg/lXsoPu7JeHBJINoI6EJaHhN6a3p2RUwddZ2
         ftwcJfe8z5F7lh3KbrJ8S1lp8IDcFs0YXLltpfnO51IcSAMhpUmcpAUD8BthFQHMkiyO
         yJ4qbL5vi9U+uUS0ofktMXMYhrOY9tOginASbIOHxvR+9VarqW1CvpsGrOLTQamsbnl1
         CpLg==
X-Forwarded-Encrypted: i=1; AJvYcCUDXBAEyY8CcbJ3UloTD6sdx5aIH+LL+qN5br8PZb8T5L1J7VxZPg0K90aXypFCpTw8Xrl5R4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI3RHpE/nfM6E18TxkjbnNaUY7ozG+/F7nk5tpRqqUMJ8rBS89
	CsSmdh6frsJdV2Rzh7NUFk1oLQs++Tu0EifxWRtfH5GNMXyYgxM3D+OvUQGNr0fW4z+ecngJ+S0
	p/lNsIHR5sPS54WqKZ1lbNJ1wRD09H0QShlNYcCESnS9ouQFZEXSY6w==
X-Gm-Gg: ASbGnctZb4aqDu8XBKuesXbyHula3zW0GKBzyW+FQhECAPQrgRdT31FKU0on0B2cY54
	HM2d2o7/lDiTZa7SjN/C/dQQOfb3yD44FqB1CI7aXB6HvXMAr7r5jie/KKm+C49V8DTOUyLSR2l
	kMnfpyyf0W1vPiqsXdlFmB2GpB8bY8YQgXKCRz5PBDGhGnUR3LHBncEuPGcuoofub3fZehy8SIb
	ofDiKGplah/oKKSEs4/jhrX6MkZtALS1PoOJpdZU8O+kyQVHw9DEtmJiYxFZjVoZatwp/FzgXls
X-Received: by 2002:a05:6214:4106:b0:6d8:9832:75d0 with SMTP id 6a1803df08f44-6d8b737be0cmr189327606d6.17.1733417617400;
        Thu, 05 Dec 2024 08:53:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEazguy/V8TyXe1abXUYeNkBjnO+sRg5ozizpPTnPT5v1gBfKRQAMIPrgIl9VTd7CB38n8dBg==
X-Received: by 2002:a05:6214:4106:b0:6d8:9832:75d0 with SMTP id 6a1803df08f44-6d8b737be0cmr189327166d6.17.1733417617011;
        Thu, 05 Dec 2024 08:53:37 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da66da32sm8270686d6.2.2024.12.05.08.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 08:53:36 -0800 (PST)
Message-ID: <c1601a03-0643-41ec-a91c-4eac5d26e693@redhat.com>
Date: Thu, 5 Dec 2024 17:53:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] datagram, udp: Set local address and rehash
 socket atomically against lookup
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Mike Manning <mvrmanning@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Holzinger <pholzing@redhat.com>, Philo Lu <lulie@linux.alibaba.com>,
 Cambda Zhu <cambda@linux.alibaba.com>, Fred Chen <fred.cc@alibaba-inc.com>,
 Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
References: <20241204221254.3537932-1-sbrivio@redhat.com>
 <20241204221254.3537932-3-sbrivio@redhat.com>
 <fa941e0d-2359-4d06-8e61-de40b3d570cb@redhat.com>
 <20241205165830.64da6fd7@elisabeth>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241205165830.64da6fd7@elisabeth>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/24 16:58, Stefano Brivio wrote:
> On Thu, 5 Dec 2024 10:30:14 +0100
> Paolo Abeni <pabeni@redhat.com> wrote:
> 
>> On 12/4/24 23:12, Stefano Brivio wrote:
>>
>>> [...]
>>>
>>> To fix this, replace the rehash operation by a set_rcv_saddr()
>>> callback holding the spinlock on the primary hash chain, just like
>>> the rehash operation used to do, but also setting the address (via
>>> inet_update_saddr(), moved to headers) while holding the spinlock.
>>>
>>> To make this atomic against the lookup operation, also acquire the
>>> spinlock on the primary chain there.  
>>
>> I'm sorry for the late feedback.
>>
>> I'm concerned by the unconditional spinlock in __udp4_lib_lookup(). I
>> fear it could cause performance regressions in different workloads:
>> heavy UDP unicast flow, or even TCP over UDP tunnel when the NIC
>> supports RX offload for the relevant UDP tunnel protocol.
>>
>> In the first case there will be an additional atomic operation per packet.
> 
> So, I've been looking into this a bit, and request-response rates with
> neper's udp_rr (https://github.com/google/neper/blob/master/udp_rr.c)
> for a client/server pair via loopback interface are the same before and
> after this patch.
> 
> The reason is, I suppose, that the only contention on that spinlock is
> the "intended" one, that is, between connect() and lookup.
> 
> Then I moved on to bulk flows, with socat or iperf3. But there (and
> that's the whole point of this fix) we have connected sockets, and once
> they are connected, we switch to early demux, which is not affected by
> this patch.
> 
> In the end, I don't think this will affect "regular", bulk unicast
> flows, because applications using them will typically connect sockets,
> and we'll switch to early demux right away.
> 
> This lookup is not exactly "slow path", but it's not fast path either.

Some (most ?) quick server implementations don't use connect.

DNS servers will be affected, and will see contention on the hash lock

Even deployment using SO_REUSEPORT with a per-cpu UDP socket will see
contention. This latter case would be pretty bad, as it's supposed to
scale linearly.

I really think the hash lock during lookup is a no go.

>> In the latter the spin_lock will be contended with multiple concurrent
>> TCP over UDP tunnel flows: the NIC with UDP tunnel offload can use the
>> inner header to compute the RX hash, and use different rx queues for
>> such flows.
>>
>> The GRO stage will perform UDP tunnel socket lookup and will contend the
>> bucket lock.
> 
> In this case (I couldn't find out yet), aren't sockets connected? I
> would expect that we switch to the early demux path relatively soon for
> anything that needs to have somehow high throughput.

The UDP socket backing tunnels is unconnected and can receive data from
multiple other tunnel endpoints.

> And if we don't, probably the more reasonable alternative would be to
> "fix" that, rather than keeping this relatively common case broken.
> 
> Do you have a benchmark or something I can run?

I'm sorry, but I don't have anything handy. If you have a NIC
implementing i.e. vxlan H/W offload you should be able to observe
contention with multiple simultaneus TCP over vxlan flows targeting an
endpoint on top of it.

>>> This results in some awkwardness at a caller site, specifically
>>> sock_bindtoindex_locked(), where we really just need to rehash the
>>> socket without changing its address. With the new operation, we now
>>> need to forcibly set the current address again.
>>>
>>> On the other hand, this appears more elegant than alternatives such
>>> as fetching the spinlock reference in ip4_datagram_connect() and
>>> ip6_datagram_conect(), and keeping the rehash operation around for
>>> a single user also seems a tad overkill.  
>>
>> Would such option require the same additional lock at lookup time?
> 
> Yes, it's conceptually the same, we would pretty much just move code
> around.
> 
> I've been thinking about possible alternatives but they all involve a
> much bigger rework. One idea could be that we RCU-connect() sockets,
> instead of just having the hash table insertion under RCU. That is, as
> long as we're in the grace period, the lookup would still see the old
> receive address.

I'm wondering if the issue could be solved (almost) entirely in the
rehash callback?!? if the rehash happens on connect and the the socket
does not have hash4 yet (it's not a reconnect) do the l4 hashing before
everything else.

Incoming packets should match the l4 hash and reach the socket even
while later updating the other hash(es).

Cheers,

Paolo


