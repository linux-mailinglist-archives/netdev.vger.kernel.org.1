Return-Path: <netdev+bounces-127741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 526109764A9
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 10:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D56F41F24651
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 08:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8EB188927;
	Thu, 12 Sep 2024 08:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="XK33/GtJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C031A28D
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 08:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726129876; cv=none; b=CHXCUVlXspDFmUOQRVdOM4y/EuuBb/+yc9gZni8du3lxOPql7isLTdQih5cqRZlAY1XneaRR1bHKmn7KqIgq3c857EekUuk1BpHsku1GcKCFseibx78BHcPfDRfSCNihiBvh/mDACGO5vW3P1cJUkWf8KilkfpIUdj3qMhxYZRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726129876; c=relaxed/simple;
	bh=Rx17n4khnT7LPs5FHL/d5j/PG9bdeRIsYAwJnI4O2nQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UFynzuTLU5OEZ9h9PBMiNqgNM9tZPbdyH5HHhrbHXwt9j1qyxHCiZ5l5f4xr7lFi+eNQwyUzLIfGDmbp7e+Ua+u0d1qlPdGziZKjoRbefcwPqRr0vmrlJYm9XrOccMUyg2pAyGXdYAflRYRbPXCSfJyhKpLK1nSpMFyv96sN5i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=XK33/GtJ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5bf01bdaff0so778412a12.3
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 01:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1726129873; x=1726734673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N6cnJrOT8Yhy5uHNM8FF9XCBKLzyV6MSm2fcyqRhToo=;
        b=XK33/GtJZGAsG7nImW0rlM6ZIeSLcC50lIWNBdjHmqdjMRlVxxFSOms35VjG+Iy2Pq
         h4iExELoAtY+PQbaZCeDwfrI3upfUl8cGzdv8a9IjalClDKduxStGNOmkpwxcyjtSqEQ
         /rL8iwigRWiu/+FgYfdpoDDt3ZIICq3RJ7X1UPuAqvr0jLX0FBc87+mUAPx5IhtePrPC
         sKpwZTuF/3abjE6Om1hO4mg9pW+27WEP1YCktGMlpepBJz/lvjqf+QTlNqKeoV/eiJWd
         PnqoNqQGUyqkSLvhAT+wBTuuuwGy3LlxpCNziY7lUQpQWIg2W2tdSKPjBwBKyYQY+Wmp
         A1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726129873; x=1726734673;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6cnJrOT8Yhy5uHNM8FF9XCBKLzyV6MSm2fcyqRhToo=;
        b=V+t3Vahk27QEj/fFsv6mLvVJ1Imd4oUvFKWVY9CqIkjFmJp+gE1GplBSOVHlr9LL5t
         QujGJesCRy9h3NK5ytl8caj2izkmqTE7CLcCYaX6IFmyHY0mbrJ+Ql9Lzq9agXGEd85b
         ZT4diZ2VikXUO7VYTS5vcNfKoIxV6SLtXSKBm8LZpZ/3pdTncwPArb/LB1JNBK51bAV6
         Tj3uC/5RiropFTA949uHg4YJ/uBHV3bS9Rnj7jNJhl26v/KLRc2Ripspo1+oasUVqxBS
         A9iLu3/uL8/LDrjfPILoz3OSAIJFuUwoAUQwyx9R8hjUtpnO0kXM/SoHZEyilKmq39nQ
         761A==
X-Gm-Message-State: AOJu0Yz83MaNUtLFMik1/pvUQHBUIcubmVMKZ2/rO7wCbuu0wtHPQL3A
	AAlKitEFI5Y1jvANSIs0g+2qQc5KMViKysOXUYvKpr0XhW6DV2qVO8qAujVdz9s=
X-Google-Smtp-Source: AGHT+IHlA0/xcNLWQ1F7hLJjimBt7rsTpm5oNmjE+1+bYngu9fX1Wgdhs0P9FFBCjiS16GcDJ9qU3w==
X-Received: by 2002:a17:907:e2d4:b0:a8a:906d:b485 with SMTP id a640c23a62f3a-a902951fa11mr176682066b.26.1726129872487;
        Thu, 12 Sep 2024 01:31:12 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:455:c6f1:853b:139b? ([2001:67c:2fbc:1:455:c6f1:853b:139b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25ceaf86sm712936766b.155.2024.09.12.01.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 01:31:12 -0700 (PDT)
Message-ID: <1f17e2c5-c844-44a4-8970-64618c6295fb@openvpn.net>
Date: Thu, 12 Sep 2024 10:33:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 12/25] ovpn: implement packet processing
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch
References: <20240827120805.13681-1-antonio@openvpn.net>
 <20240827120805.13681-13-antonio@openvpn.net> <ZtXOw-NcL9lvwWa8@hog>
 <ae23ac0f-2ff9-4396-9033-617dc60221eb@openvpn.net> <Zth2Trqbn73QDnLn@hog>
 <9ab97386-b83d-484e-8e6d-9f67a325669d@openvpn.net> <ZuBD7TWOQ7huO7_7@hog>
 <af164160-6402-45f9-8ef3-d5a3ffd43452@openvpn.net> <ZuGbZTinqmoBsc6C@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZuGbZTinqmoBsc6C@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/09/2024 15:30, Sabrina Dubroca wrote:
> 2024-09-11, 14:52:10 +0200, Antonio Quartulli wrote:
>> On 10/09/2024 15:04, Sabrina Dubroca wrote:
>>> 2024-09-06, 15:19:08 +0200, Antonio Quartulli wrote:
>>>> Therefore, how about having an array large enough to store all key IDs (max
>>>> ID is 7):
>>>
>>> Right, I forgot about that. For 8 keys, sure, array sounds ok. MACsec
>>> has only 4 and I also implemented it as an array
>>> (include/net/macsec.h: macsec_{tx,rx}_sc, sa array).
>>
>> thanks for the pointer!
>>
>>>
>>>> * array index is the key ID (fast lookup on RX);
>>>> * upon SET_KEY we store the provided keys and erase the rest;
>>>
>>> I'm not sure about erasing the rest. If you're installing the
>>> secondary ("next primary") key, you can't just erase the current
>>> primary? ("erase the rest" also means you'd only ever have one key in
>>> the array, which contradicts your last item in this list)
>> Yeah, my point is wrong.
>> I fooled myself assuming SET_KEY would install two keys each time, but this
>> is not the case, so we can't "erase everything else".
>>
>> What we can do is:
>> * if SET_KEY wants to install a key in PRIMARY, then we erase the key marked
>> as "primary" and we mark the new one as such
>> * if SET_KEY wants to install a key in SECONDARY, then we erase the key
>> without any mark.
> 
> Ok, then the DEL_KEY op would not really be needed.

It would be needed only when we want to kick an old key without 
installing a new one.
IMHO something that should not truly happen during the normal lifecycle 
of a peer, but there might be some corner cases where userspace may 
still want to do that (I am checking userspace to understand when this 
can truly happen, if at all)

> 
>>
>> This way we simulate writing into slots.
>>
>>>
>>>> * upon SET_KEY we store in a new field the index/ID of the PRIMARY (fast
>>>> lookup on TX), namely primary_id;
>>
>> FTR: this is what "marking as primary" means
>>
>>>> * upon SWAP we just save in primary_id the "other" index/ID;
>>>
>>> I'm confused by these two. Both SET_KEY and SWAP modify the primary_id?
>>
>> Yes.
>> SET_KEY may want to install a key in the primary slot: in that case the new
>> key has to be marked as primary immediately.
>> This normally happens only upon first SET_KEY after connection, when no
>> other key exists.
>>
>> SWAP will switch primary_id to the other key ID.
>>
>> makes sense?
> 
> Yes, thanks, that fixes up all my confusion around setting primary_id.
> 
>>>> * at any given time we will have only two keys in the array.
>>>
>>> This needs to be enforced in the SET_KEY implementation, otherwise
>>> SWAP will have inconsistent effects.
>>
>> yap. I hope what I wrote above about SET_KEY helps clarifying this part.
>>
>>>
>>>
>>>> It's pretty much like your option 1 and 2, but using an array
>>>> indexed by key ID.
>>>
>>> Are you decoupling TX and RX keys (so that they can be installed
>>> independently) in this proposal? I can't really tell, the array could
>>> be key pairs or separate.
>>
>> I would not decouple TX and RX keys.
>> Each array item should be the same as what we are now storing into each slot
>> (struct ovpn_crypto_key_slot *).
>> I could use two arrays, instead of an array of slots, but that means
>> changing way more logic and I don't see the benefit.
> 
> Avoid changing both keys every time when a link has very asymmetric
> traffic. And the concept of a primary/secondary key makes no sense on
> receive, all you need is keyids, and there's no need to swap slots,
> which avoids the "key not available during SWAP" issue
> entirely. Primary key only makes sense on TX.
> 
> But I'm guessing the keypair concept is also baked deep into openvpn.

Correct. Both keys are recomputed upon each renegotiation, even if one 
key was still usable.

> 
> 
>>>> The concept of slot is a bit lost, but it is not important as long as we can
>>>> keep the API and its semantics the same.
>>>
>>> Would it be a problem for userspace to keep track of key IDs, and use
>>> that (instead of slots) to communicate with the kernel? Make
>>> setkey/delkey be based on keyid, and replace swap with a set_tx
>>> operation which updates the current keyid for TX. That would seem like
>>> a better API, especially for the per-ID array you're proposing
>>> here. The concept of slots would be almost completely lost (only
>>> "current tx key" is left, which is similar to the "primary slot").
>>> (it becomes almost identical to the way MACsec does things, except
>>> possibly that in MACsec the TX and RX keys are not paired at all, so
>>> you can install/delete a TX key without touching any RX key)
>>>
>>
>> unfortunately changing userspace that way is not currently viable.
>> There are more components (and documentation) that attach to this slot
>> abstraction.
> 
> I thought that might be the case. Too bad, it means we have to keep
> the slots API and the kernel will be stuck with it forever (even if
> some day userspace can manage key ids instead of slots).

Yap, but I think there won't be any change like that in the near future.

> 
>> Hence my proposal to keep the API the same, but rework the internal for
>> better implementation.
> 
> Yeah, that makes sense if you have that constraint imposed by the
> existing userspace.
> 
>>
>>>
>>> Maybe you can also rework the current code to look a bit like this
>>> array-based proposal, and not give up the notion of slots, if that's
>>> something strongly built into the core of openvpn:
>>>
>>> - primary/secondary in ovpn_crypto_state become slots[2]
>>> - add a one-bit "primary" reference, used to look into the slots array
>>> - swap just flips that "primary" bit
>>> - TX uses slots[primary]
>>> - RX keeps inspecting both slots (now slot[0] and slot[1] instead of
>>>     primary/secondary) looking for the correct keyid
>>> - setkey/delkey still operate on primary/secondary, but need to figure
>>>     out whether slot[0] or slot[1] is primary/secondary based on
>>>     ->primary
>>>
>>> It's almost identical to the current code (and API), except you don't
>>> need to reassign any pointers to swap keys, so it should avoid the
>>> rekey issue.
>>
>> This approach sounds very close to what I was aiming for, but simpler
>> because we have slots[2] instead of slots[8] (which means that primary_id
>> can be just 'one-bit').
> 
> Yes.
> 
>> The only downside is that upon RX we have to check both keys.
>> However I don't think this is an issue as we have just 2 keys at most.
>>
>> I could even optimize the lookup by starting always from the primary key, as
>> that's the one being used most of the time by the sender.
> 
> Nice.
> 
>> Ok, I will go with this approach you summarized here at the end.
> 
> Ok. I think it should be a pretty minimal set of changes on top of the
> existing code, especially if you hide the primary/secondary accesses
> in inline helpers.

I think so to - working on it.

Thanks a lot!
Cheers,

> 

-- 
Antonio Quartulli
OpenVPN Inc.

