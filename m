Return-Path: <netdev+bounces-225183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2604B8FCC9
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 11:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2439C3A4DE5
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 09:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D5727EC80;
	Mon, 22 Sep 2025 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gh+nVJ+T"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05C326E715
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758534081; cv=none; b=BfGBqgAFqBs+kYeS5tljZ8syEvaJfP9cnfmLv8OzQLgRE8xRGTKbqrOhG4Vahwpb9OL1ExCY3mvMCT8rOuCKcaNDaipQYFqQ7ouEdFkIPeV6a97kZLyFJv7zQYaPcKZ+EKUHrQh8tgRVZpluEhG31SDwOWPzkenCJGlglasicIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758534081; c=relaxed/simple;
	bh=/rKmk7+MJ9D3PugW+ckb+crT2rJ+XHb4JxeYiPeBJ+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1te6KUwkoROHYJcnMxCXasF9TGBZlzklJBsHgP+UDyhWxCnjlNtjo90ce9mAi3VOasrjfoQkSmfQWeV87ahJhQt67RJ2jf5C8VwEegG1UZfyGnYcdXVqwIbcqUKdN0Dv5lhtYgMguc3u0tNrFV+HKa+2kHUZoQMq2YHBf7Mo18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gh+nVJ+T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758534078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zW13wsOG7Evs0XbpTboIcFtpWl/aDcAwoOHHhUygs3o=;
	b=gh+nVJ+TtrHJsU5EVYz05O5DTqHLN6r4YOWesRoflT4Hbi1EH6AsMdXaaDZ7kJ53XANUfo
	YGxlVrK588IlCm93Hly8d0MCbhLxpyATbv6FlMgceAnEk0QCHVFMu4+giSSMzr1goSAwmy
	YHXQFd9XCXXOZQFlOsZy6x9/VAT5MKo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-wYZOCQVyNxqCC7D_7p43Ow-1; Mon, 22 Sep 2025 05:41:15 -0400
X-MC-Unique: wYZOCQVyNxqCC7D_7p43Ow-1
X-Mimecast-MFC-AGG-ID: wYZOCQVyNxqCC7D_7p43Ow_1758534075
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b990eb77cso9982775e9.0
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 02:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758534075; x=1759138875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zW13wsOG7Evs0XbpTboIcFtpWl/aDcAwoOHHhUygs3o=;
        b=un9DMU1AU3VqxISM855vJQgueK9R+IIYWd6/6l1ttn8F+bduiVgBOL4XvOAXx3XTV4
         2zA3fo2grZETxtpt4YO6DUzjgctvU3wnKdt5iAmcHk1h6Wy5Gev6+cmgerPOyXwHPOc/
         iG3yyZ3ruAHWn76ENwc4fdhPdZioU6++LyoAvRkcQT4OFqnG0+UzI3URTmMUq7cZU8Yc
         UnQoME1JJMD2Q9BnZTkEwZU1dVpgrewIy6Hq41vXPOZ6ULcKpU6QV1fAg1/h7GB85Mw/
         0YfnsAlSWazEhVfYYKKFwWyG48EPXmpTbcIHMF9S37gWRQerIKc7WGnayLAgqP2Ma2zT
         9Txw==
X-Forwarded-Encrypted: i=1; AJvYcCVw1TdGMLocvORDDLe8j2DorEGVZUKqTO/t/LxyPeoasrVF2QKd02lZ6qIAI92BXIo0R91fxo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YywpXPy9zaNnPV+4C345GMv4EPCQHgWhePCfaEIfIrc+DSDXIoK
	7ZaTgLWXBzZr4QTU7wly6lnCCitEVsz9ad66LJsqk6bm/26FM2vbwZ5oD6NcfQcC+5j9P7roV74
	IhrJZdQCV1VKBGkX5L53sbr9FExNjIONF+yeDz23OCY4ifMrRCN5gaqYlvg==
X-Gm-Gg: ASbGnctplWG/kIaSZ5/ncIkAY2tWUxbzZnvirTu+WI+afcm8VVUNzG7g+5oCGFPvuCO
	1xZKz17N/rUykdJvhdiYblie+6FPvuccHda/soV9dmAjgKO5PGZ2FhFm45yMyDMMjJku/Oe+dfw
	5LoopPgjPzyJNE5g/Z8xzXcsSaL0Yqe6kZKl5WC8edqvSR+/91WyhcX3JNVl7GKIFyC2hCXY2Nq
	mjtGnlngwGr9Y1Q9FieU0jOVTV0DHP7rfj619nos1hToMEfRj9aTey8/QefhfGQ7pjTKHPIEzWJ
	v75FFm0W7jhwxZ0aMscfOlW9VpKRjLN3zjt9Q6Mo++Xqwx+KR6FNYNwETHCBkQJElrTWQzYIanN
	tqE2umXlBUYuz
X-Received: by 2002:a05:600c:4e42:b0:46d:38c4:1ac9 with SMTP id 5b1f17b1804b1-46d38c41df7mr25452345e9.2.1758534074636;
        Mon, 22 Sep 2025 02:41:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGD3ottamX3vHnEd6CHzeqdmM+1TvJVBzbVJauoFZ8i18NEVOzL2RQUlurr8XgDFgngGOWpbQ==
X-Received: by 2002:a05:600c:4e42:b0:46d:38c4:1ac9 with SMTP id 5b1f17b1804b1-46d38c41df7mr25452075e9.2.1758534074164;
        Mon, 22 Sep 2025 02:41:14 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e00451fa1sm6294775e9.1.2025.09.22.02.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 02:41:13 -0700 (PDT)
Message-ID: <221b8f60-0644-4744-93dc-a46a68411270@redhat.com>
Date: Mon, 22 Sep 2025 11:41:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next] udp: remove busylock and add per NUMA queues
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20250921095802.875191-1-edumazet@google.com>
 <3fbe9533-72e9-4667-9cf4-57dd2acf375c@redhat.com>
 <CANn89i+RbuL9oknRn8uACRF-MMam=LvO6pVoR7BOUk=f5S6iVA@mail.gmail.com>
 <CANn89iKcye6Zsij4=jQ2V9ofbCwRB45HPJUdn7YbFQU1TmQVbw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89iKcye6Zsij4=jQ2V9ofbCwRB45HPJUdn7YbFQU1TmQVbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/22/25 11:34 AM, Eric Dumazet wrote:
> On Mon, Sep 22, 2025 at 1:47 AM Eric Dumazet <edumazet@google.com> wrote:
>> On Mon, Sep 22, 2025 at 1:37 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>> On 9/21/25 11:58 AM, Eric Dumazet wrote:
>>>> @@ -1718,14 +1699,23 @@ static int udp_rmem_schedule(struct sock *sk, int size)
>>>>  int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
>>>>  {
>>>>       struct sk_buff_head *list = &sk->sk_receive_queue;
>>>> +     struct udp_prod_queue *udp_prod_queue;
>>>> +     struct sk_buff *next, *to_drop = NULL;
>>>> +     struct llist_node *ll_list;
>>>>       unsigned int rmem, rcvbuf;
>>>> -     spinlock_t *busy = NULL;
>>>>       int size, err = -ENOMEM;
>>>> +     int total_size = 0;
>>>> +     int q_size = 0;
>>>> +     int nb = 0;
>>>>
>>>>       rmem = atomic_read(&sk->sk_rmem_alloc);
>>>>       rcvbuf = READ_ONCE(sk->sk_rcvbuf);
>>>>       size = skb->truesize;
>>>>
>>>> +     udp_prod_queue = &udp_sk(sk)->udp_prod_queue[numa_node_id()];
>>>> +
>>>> +     rmem += atomic_read(&udp_prod_queue->rmem_alloc);
>>>> +
>>>>       /* Immediately drop when the receive queue is full.
>>>>        * Cast to unsigned int performs the boundary check for INT_MAX.
>>>>        */
>>>
>>> Double checking I'm reading the code correctly... AFAICS the rcvbuf size
>>> check is now only per NUMA node, that means that each node can now add
>>> at most sk_rcvbuf bytes to the socket receive queue simultaneously, am I
>>> correct?
>>
>> This is a transient condition. In my tests with 6 NUMA nodes pushing
>> packets very hard,
>> I was not able to see a  significant bump of sk_rmem_alloc (over sk_rcvbuf)
>>
>>
>>
>>>
>>> What if the user-space process never reads the packets (or is very
>>> slow)? I'm under the impression the max rcvbuf occupation will be
>>> limited only by the memory accounting?!? (and not by sk_rcvbuf)
>>
>> Well, as soon as sk->sk_rmem_alloc is bigger than sk_rcvbuf, all
>> further incoming packets are dropped.
>>
>> As you said, memory accounting is there.
>>
>> This could matter if we had thousands of UDP sockets under flood at
>> the same time,
>> but that would require thousands of cpus and/or NIC rx queues.
>>
>>
>>
>>>
>>> Side note: I'm wondering if we could avoid the numa queue for connected
>>> sockets? With early demux, and no nft/bridge in between the path from
>>> NIC to socket should be pretty fast and possibly the additional queuing
>>> visible?
>>
>> I tried this last week and got no difference in performance on my test machines.
>>
>> I can retry this and give you precise numbers before sending V4.
> 
> I did my experiment again.
> 
> Very little difference (1 or 2 %, but would need many runs to have a
> confirmation)
> 
> Also loopback traffic would be unprotected (Only RSS on a physical NIC
> would properly use a single cpu for all packets)
> 
> Looking at the performance profile of the cpus

[...]

Indeed delta looks in the noise range, thanks for checking.

Just in case there is any doubt:

Acked-by: Paolo Abeni <pabeni@redhat.com>


