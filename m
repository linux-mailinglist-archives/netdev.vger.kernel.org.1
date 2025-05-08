Return-Path: <netdev+bounces-188920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75779AAF5F8
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 10:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84CBA1C0557C
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 08:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3741A21C9E9;
	Thu,  8 May 2025 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ws0abTau"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E35821CA0A
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 08:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746693984; cv=none; b=aIbaHS8D0nqAt2pAFxVROpY4rVpaUMF1E8SRMNAf85jMhsm01ECfkhylkE6V2ozahGtYvgM0eNe4NLakBcCjqqyi2ES/iNNkkP4tEdSMBWPq202uzdgk7bQxNzY3QO1jrLK9ppSA+xp9jG/EpB1hE1QYAN55W8dTguRpufEskbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746693984; c=relaxed/simple;
	bh=4HU8oiKCoDW8I7We41fVsq6xE7etMMpLP3NwPzozuBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LqJJZn7gh9Upxno0020xYEgdniKYeIUf5PMdZh3zXxFSL/dITMmuKy1/eELtAvAJFXRKTAa88wgC1OaQrP17g1BDUl2z9IIXNE4hQrLfEbRwVV+JDsnTQAArTXkp9exNHo9e8O/dunWupLWDkB3P/Ke6zZ2rC/hEXWBJVIoiJYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ws0abTau; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746693981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZM2rfxZmGn+Pb7oDTzTtUVYRHj/xEqslB58SleMISA=;
	b=Ws0abTaucUO61NMwpLY1sa8zYR2Xg8MgbsWHHOPNsn/fG9IeYxVbiUY0vg2fpEJUe+BbSh
	IzFucVkNpsBr2atwsmeW4DyzhJvGn4vtWuoCuHCVGAqk0OdSaQumEUUoydvxoSJJvgPTEg
	Tbs3nNjJzGhH4Y+mdE4YwyA3SQDxbTM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-uyM9EHu4Ow-7YfZlWlAVsA-1; Thu, 08 May 2025 04:46:20 -0400
X-MC-Unique: uyM9EHu4Ow-7YfZlWlAVsA-1
X-Mimecast-MFC-AGG-ID: uyM9EHu4Ow-7YfZlWlAVsA_1746693979
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43efa869b19so4491605e9.2
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 01:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746693978; x=1747298778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JZM2rfxZmGn+Pb7oDTzTtUVYRHj/xEqslB58SleMISA=;
        b=oAuz66zefFZfab+qDn9FTkeT5NLRmjumUTnt42rqBwQZjTgwIvDpDrC+Zubbxzxscv
         MGq98TRJOFwnFsqu26Kv5aJcZ2VW6BbLq1274ztXtVhrHqzeP6QFWH6TozHDhvcDqGmp
         53hi005aNQNKhdjluxfSYNGXf3l0MA0RHZRNqkkzpewSXi3j9v/ETExyo5DBz9IGbHS4
         awVIOu+KtC8Tav3XCw8YR6zWSOo2uGkcSsU4EtitZBmDdqNgPRGESh8T860HkWRnRmgu
         BHpD3cEZY2DYAFvlqGAy8O6EIg7uDL76Msdqz9kJ5ZiY1QsxwdYnabEKTu+lnOF/aRm9
         XLjQ==
X-Gm-Message-State: AOJu0YyyKIe9y/yrn+5cDuH+eB0qozfx/hbJBs888WLzmuvYDDwt/Tbr
	w8CtA41ka2A599odsHmhE8sUvKSCeZdAM2uCsGKfA5UuXnb0zYICN+fSQmeCk1SQEXboPXhMrb9
	epaojPyqidn1M0sx0FKjb1qxa/FoNA/zVqEDlt/QoplHacrfSqdPMD+7pAKfasSXy
X-Gm-Gg: ASbGncsE5kJdzWT01CUjCR8OC6Q9gMNpCf15jRhI9KEIVC+DKXwXE19/TryPfMhbB9B
	Kjea4aU3CvnVnU2pqO53huG5O+sBxywls4nvWdaaEB/y6oGMH8hAxg8KRPkV/EYiOeHjy13dfS8
	R4xi3YHkFZQ43eu2xA7GZAww1B7i3Cbh/8Xs5RLq3CBw9h+AFd3Oowr1kOTlG9uhkuOwNvxVhND
	GgNeR1uunKtrHpUaFv8BENvXFB0VYGmqKxr0b6O/2nZ3zcAVxDW5rI4jHKl031mU6h4g44Ay4cQ
	LJ/6zAS/emXBD+7Z
X-Received: by 2002:a05:600c:1c8c:b0:43d:683:8cb2 with SMTP id 5b1f17b1804b1-441d4eeb512mr38786755e9.14.1746693978494;
        Thu, 08 May 2025 01:46:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnG944ZTQEsiKw7GKbX+anmpQL79FH96aDK1XjGSXilGwo4xo0Ow122A9pOfEKgJo9fzTVOA==
X-Received: by 2002:a05:600c:1c8c:b0:43d:683:8cb2 with SMTP id 5b1f17b1804b1-441d4eeb512mr38786555e9.14.1746693978050;
        Thu, 08 May 2025 01:46:18 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244b:910::f39? ([2a0d:3344:244b:910::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd32f3c2sm29339385e9.15.2025.05.08.01.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 01:46:17 -0700 (PDT)
Message-ID: <d52465a2-f857-4a2b-8d4e-4d30384b6247@redhat.com>
Date: Thu, 8 May 2025 10:46:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 05/15] net: homa: create homa_peer.h and
 homa_peer.c
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
 <20250502233729.64220-6-ouster@cs.stanford.edu>
 <4350bd09-9aad-491c-a38d-08249f082b6d@redhat.com>
 <CAGXJAmyN2XUjk7hp-7o0Em9b_6Y5S3iiS14KXQWSKUWJXnnOvA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAGXJAmyN2XUjk7hp-7o0Em9b_6Y5S3iiS14KXQWSKUWJXnnOvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/7/25 6:11 PM, John Ousterhout wrote:
> On Mon, May 5, 2025 at 4:06 AM Paolo Abeni <pabeni@redhat.com> wrote:
> 
>> On 5/3/25 1:37 AM, John Ousterhout wrote:
>> [...]
>>> +{
>>> +     /* Note: when we return, the object must be initialized so it's
>>> +      * safe to call homa_peertab_destroy, even if this function returns
>>> +      * an error.
>>> +      */
>>> +     int i;
>>> +
>>> +     spin_lock_init(&peertab->write_lock);
>>> +     INIT_LIST_HEAD(&peertab->dead_dsts);
>>> +     peertab->buckets = vmalloc(HOMA_PEERTAB_BUCKETS *
>>> +                                sizeof(*peertab->buckets));
>>
>> This struct looks way too big to be allocated on per netns basis. You
>> should use a global table and include the netns in the lookup key.
> 
> Are there likely to be lots of netns's in a system? 

Yes. In fact a relevant performance metric is the time to create and
destroy thousands of them.

> I thought I read
> someplace that a hardware NIC must belong exclusively to a single
> netns, so from that I assumed there couldn't be more than a few
> netns's. Can there be virtual NICs, leading to lots of netns's?

Yes, veth devices a pretty ubiquitous in containerization setups

> Can
> you give me a ballpark number for how many netns's there might be in a
> system with "lots" of them? This will be useful in making design
> tradeoffs.

You should consider at least 1K as a target number, but a large system
should just work with 10K or more.

>>> +     /* No existing entry; create a new one.
>>> +      *
>>> +      * Note: after we acquire the lock, we have to check again to
>>> +      * make sure the entry still doesn't exist (it might have been
>>> +      * created by a concurrent invocation of this function).
>>> +      */
>>> +     spin_lock_bh(&peertab->write_lock);
>>> +     hlist_for_each_entry(peer, &peertab->buckets[bucket],
>>> +                          peertab_links) {
>>> +             if (ipv6_addr_equal(&peer->addr, addr))
>>> +                     goto done;
>>> +     }
>>> +     peer = kmalloc(sizeof(*peer), GFP_ATOMIC | __GFP_ZERO);
>>
>> Please, move the allocation outside the atomic scope and use GFP_KERNEL.
> 
> I don't think I can do that because homa_peer_find is invoked in
> softirq code, which is atomic, no? It's not disastrous if the
> allocation fails; the worst that happens is that an incoming packet
> must be discarded (it will be retried later).

IMHO a _find() helper that allocates thing has a misleading name.

Usually RX path do only lookups, and state allocation is done in the
control path, that avoid atomic issues

> 
>>> +     if (!peer) {
>>> +             peer = (struct homa_peer *)ERR_PTR(-ENOMEM);
>>> +             goto done;
>>> +     }
>>> +     peer->addr = *addr;
>>> +     dst = homa_peer_get_dst(peer, inet);
>>> +     if (IS_ERR(dst)) {
>>> +             kfree(peer);
>>> +             peer = (struct homa_peer *)PTR_ERR(dst);
>>> +             goto done;
>>> +     }
>>> +     peer->dst = dst;
>>> +     hlist_add_head_rcu(&peer->peertab_links, &peertab->buckets[bucket]);
>>
>> At this point another CPU can lookup 'peer'. Since there are no memory
>> barriers it could observe a NULL peer->dst.
> 
> Oops, good catch. I need to add 'smp_wmb()' just before the
> hlist_add_head_rcu line?

Barriers go in pair, one here and one in the lookup. See the relevant
documentation for the gory details.

[...]
>> Note that freeing the peer at 'runtime' will require additional changes:
>> i.e. likely refcounting will be beeded or the at lookup time, after the
>> rcu unlock the code could hit HaF while accessing the looked-up peer.
> 
> I understand about reference counting, but I couldn't parse the last
> 1.5 lines above. What is HaF?

A lot of typos on my side, sorry.

You likely need to introduce refcounting, or after the RCU unlock (end
of RCU grace period) the peer could be freed causing Use after Free.

>> [...]
>>> +static inline struct dst_entry *homa_get_dst(struct homa_peer *peer,
>>> +                                          struct homa_sock *hsk)
>>> +{
>>> +     if (unlikely(peer->dst->obsolete > 0))
>>
>> you need to additionally call dst->ops->check
> 
> I wasn't aware of dst->ops->check, and I'm a little confused by it
> (usage in the kernel doesn't seem totally consistent):
> * If I call dst->ops->check(), do I also need to check obsolete
> (perhaps only call check if obsolete is true?)?
> * What is the 'cookie' argument to dst->ops->check? Can I just use 0 safely?
> * It looks like dst->ops->check now returns a struct dst_entry
> pointer. What is the meaning of this? ChatGPT suggests that it is a
> replacement dst_entry, if the original is no longer valid. 

Luckily (on unfortunately depending on your PoV), the tool you mentioned
simply does not work (yet?) for kernel code. You could (and should)
review with extreme care basically any output about such topic.

dst_check() is the reference code. You should use that helper.

/P


