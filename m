Return-Path: <netdev+bounces-129295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C122F97EBB2
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 14:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B967F1C20D5F
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 12:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D88196C86;
	Mon, 23 Sep 2024 12:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="HJsPzt3V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A039D38DF9
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 12:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727095741; cv=none; b=oyo7LiN4zylwUQqrSvqa+1Nl07frQfcpbZAIvqqSpupKQ8DqqZlhxQN8zpWnJZZi3qDGJufv+0yufdNAFqZQW97UL1A0VWv35mHyRfjyetG9JZQ+6oIUKSxKNdXqlJqxs+WyfzHLdfS2kph8QDw8LL5TADmcJeWWnrqSVmytack=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727095741; c=relaxed/simple;
	bh=oyx7qHNoZeOSskUiKCizhdlbSaTUHs85p8cqDl/yy5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPQwfHUZrYScTHY0L6iwIiBLDM0DWh6tSsnwZVHjpvI1Fn398muyDOhgV903xxhL+aDcb9E9kp+LzjEE+z9VejpwdLLpNmqD26hrwAS3S+a5jen5I1pZZMBcTx9O/4PchU8p30NSb7sYu57gNSMp8036JpwBw9iHYsnXSyjYceQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=HJsPzt3V; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-374c4c6cb29so4297541f8f.3
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 05:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1727095737; x=1727700537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EOxzSZs59Nzwv1O1EjkhrAB+iir4+L/w8mJk/itG6uo=;
        b=HJsPzt3VmOgy8ANPsZaLny715U7JnZ4wKzTrPFw/TUE771sYOR6CiP0FQJHfgHtavi
         x14CeTiOgMUUJv3x86NiQOvnxzXAenk9RAIyFxzYBabG1dM1dg2fa+yKnqZr6DGeDfR9
         LromQJ2nJ4R8sLBsYpE8I2x+Cu5z3JLDb9bQVjShfRYOLfheUrwBPLaM4Qoh+LCvoVrQ
         h5Gv+7BQcFe1zwW1T8ko/uicJe2o9hRKC6ipYz8BqQwi/fJiETltqtES4kTW2wdGu/ln
         t+o06x7ALteB73xgDs2pIJ7b+IffOHnp29bMfSKRUcNHYIdoONVRX2F9qFL/jkxS+xej
         HbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727095737; x=1727700537;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOxzSZs59Nzwv1O1EjkhrAB+iir4+L/w8mJk/itG6uo=;
        b=jYqFq8bY0SOX09kVeQF/LlGHPpex8ocYSg6ctQk6GrKFgYOq3ecIKZbXsdCkMRPom1
         bFtt815FzC9q1uGa36h1l2weXfAAlyRftuWvYID41h5iR8d5L6GXqeVgcyQKwcdt/+hf
         NeWMlJz3TXqaJe+qL1fxNzdUeca+XohjlE4tXEjozHNRJY/8s9qhhnT4wEVzfkcPA5Xg
         i3IAvurjXsksnuU5IQUBQNvvdpM88IsCFxv6SOQeoGVwTZZgozDzpsj3Irf+ESal2/WD
         Y/0CPbtVp8dkJQzphzXrpypPFxsLOPD844wXozGHEx68HvEqppz8XRWxe/BPIWglQlxz
         FEyw==
X-Gm-Message-State: AOJu0Yw16agX92KHikc2ptMKORjuXqimbVmkjYPqJ8ZzKUMtTUwLKNLj
	Tyw5qLZJLXLz5x44p36E5DYQqv7fGDd9JLANY+2FkcQwqLwikQy8DofNk3sL24k=
X-Google-Smtp-Source: AGHT+IFZoi6kAs9VZOOhHAQMw21APCmvTbP3/ppkAYHBNtfphG13V8vUG/3onRk1VATKHmpKrgMHvA==
X-Received: by 2002:adf:e8c6:0:b0:374:c69b:5a24 with SMTP id ffacd0b85a97d-37a4238c819mr9612997f8f.51.1727095736825;
        Mon, 23 Sep 2024 05:48:56 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:8a3e:77dd:5f67:bbfc? ([2001:67c:2fbc:1:8a3e:77dd:5f67:bbfc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37a47c1e18asm7049551f8f.55.2024.09.23.05.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 05:48:56 -0700 (PDT)
Message-ID: <e682cf5c-f94d-4200-a747-bb249f85bf41@openvpn.net>
Date: Mon, 23 Sep 2024 14:48:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 12/25] ovpn: implement packet processing
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew@lunn.ch
References: <20240827120805.13681-1-antonio@openvpn.net>
 <20240827120805.13681-13-antonio@openvpn.net> <ZtXOw-NcL9lvwWa8@hog>
 <ae23ac0f-2ff9-4396-9033-617dc60221eb@openvpn.net> <Zth2Trqbn73QDnLn@hog>
 <9ab97386-b83d-484e-8e6d-9f67a325669d@openvpn.net> <ZuBD7TWOQ7huO7_7@hog>
 <af164160-6402-45f9-8ef3-d5a3ffd43452@openvpn.net> <ZuGbZTinqmoBsc6C@hog>
 <1f17e2c5-c844-44a4-8970-64618c6295fb@openvpn.net>
 <f1ba8d14-d157-48d1-8bd2-2dea6e1ecd40@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <f1ba8d14-d157-48d1-8bd2-2dea6e1ecd40@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 22/09/2024 21:51, Sergey Ryazanov wrote:
> Hello Antonio, Sabrina,
> 
> let me join the key management design discussion and put my 2 cents in. 
> Please find my comment below.
> 
> On 12.09.2024 11:33, Antonio Quartulli wrote:
>> On 11/09/2024 15:30, Sabrina Dubroca wrote:
>>> 2024-09-11, 14:52:10 +0200, Antonio Quartulli wrote:
>>>> On 10/09/2024 15:04, Sabrina Dubroca wrote:
>>>>> 2024-09-06, 15:19:08 +0200, Antonio Quartulli wrote:
>>>>>> Therefore, how about having an array large enough to store all key 
>>>>>> IDs (max
>>>>>> ID is 7):
>>>>>
>>>>> Right, I forgot about that. For 8 keys, sure, array sounds ok. MACsec
>>>>> has only 4 and I also implemented it as an array
>>>>> (include/net/macsec.h: macsec_{tx,rx}_sc, sa array).
>>>>
>>>> thanks for the pointer!
>>>>
>>>>>
>>>>>> * array index is the key ID (fast lookup on RX);
>>>>>> * upon SET_KEY we store the provided keys and erase the rest;
>>>>>
>>>>> I'm not sure about erasing the rest. If you're installing the
>>>>> secondary ("next primary") key, you can't just erase the current
>>>>> primary? ("erase the rest" also means you'd only ever have one key in
>>>>> the array, which contradicts your last item in this list)
>>>> Yeah, my point is wrong.
>>>> I fooled myself assuming SET_KEY would install two keys each time, 
>>>> but this
>>>> is not the case, so we can't "erase everything else".
>>>>
>>>> What we can do is:
>>>> * if SET_KEY wants to install a key in PRIMARY, then we erase the 
>>>> key marked
>>>> as "primary" and we mark the new one as such
>>>> * if SET_KEY wants to install a key in SECONDARY, then we erase the key
>>>> without any mark.
>>>
>>> Ok, then the DEL_KEY op would not really be needed.
>>
>> It would be needed only when we want to kick an old key without 
>> installing a new one.
>> IMHO something that should not truly happen during the normal 
>> lifecycle of a peer, but there might be some corner cases where 
>> userspace may still want to do that (I am checking userspace to 
>> understand when this can truly happen, if at all)
>>
>>>
>>>>
>>>> This way we simulate writing into slots.
>>>>
>>>>>
>>>>>> * upon SET_KEY we store in a new field the index/ID of the PRIMARY 
>>>>>> (fast
>>>>>> lookup on TX), namely primary_id;
>>>>
>>>> FTR: this is what "marking as primary" means
>>>>
>>>>>> * upon SWAP we just save in primary_id the "other" index/ID;
>>>>>
>>>>> I'm confused by these two. Both SET_KEY and SWAP modify the 
>>>>> primary_id?
>>>>
>>>> Yes.
>>>> SET_KEY may want to install a key in the primary slot: in that case 
>>>> the new
>>>> key has to be marked as primary immediately.
>>>> This normally happens only upon first SET_KEY after connection, when no
>>>> other key exists.
>>>>
>>>> SWAP will switch primary_id to the other key ID.
>>>>
>>>> makes sense?
>>>
>>> Yes, thanks, that fixes up all my confusion around setting primary_id.
>>>
>>>>>> * at any given time we will have only two keys in the array.
>>>>>
>>>>> This needs to be enforced in the SET_KEY implementation, otherwise
>>>>> SWAP will have inconsistent effects.
>>>>
>>>> yap. I hope what I wrote above about SET_KEY helps clarifying this 
>>>> part.
>>>>
>>>>>
>>>>>
>>>>>> It's pretty much like your option 1 and 2, but using an array
>>>>>> indexed by key ID.
>>>>>
>>>>> Are you decoupling TX and RX keys (so that they can be installed
>>>>> independently) in this proposal? I can't really tell, the array could
>>>>> be key pairs or separate.
>>>>
>>>> I would not decouple TX and RX keys.
>>>> Each array item should be the same as what we are now storing into 
>>>> each slot
>>>> (struct ovpn_crypto_key_slot *).
>>>> I could use two arrays, instead of an array of slots, but that means
>>>> changing way more logic and I don't see the benefit.
>>>
>>> Avoid changing both keys every time when a link has very asymmetric
>>> traffic. And the concept of a primary/secondary key makes no sense on
>>> receive, all you need is keyids, and there's no need to swap slots,
>>> which avoids the "key not available during SWAP" issue
>>> entirely. Primary key only makes sense on TX.
>>>
>>> But I'm guessing the keypair concept is also baked deep into openvpn.
>>
>> Correct. Both keys are recomputed upon each renegotiation, even if one 
>> key was still usable.
>>
>>>
>>>
>>>>>> The concept of slot is a bit lost, but it is not important as long 
>>>>>> as we can
>>>>>> keep the API and its semantics the same.
>>>>>
>>>>> Would it be a problem for userspace to keep track of key IDs, and use
>>>>> that (instead of slots) to communicate with the kernel? Make
>>>>> setkey/delkey be based on keyid, and replace swap with a set_tx
>>>>> operation which updates the current keyid for TX. That would seem like
>>>>> a better API, especially for the per-ID array you're proposing
>>>>> here. The concept of slots would be almost completely lost (only
>>>>> "current tx key" is left, which is similar to the "primary slot").
>>>>> (it becomes almost identical to the way MACsec does things, except
>>>>> possibly that in MACsec the TX and RX keys are not paired at all, so
>>>>> you can install/delete a TX key without touching any RX key)
>>>>>
>>>>
>>>> unfortunately changing userspace that way is not currently viable.
>>>> There are more components (and documentation) that attach to this slot
>>>> abstraction.
>>>
>>> I thought that might be the case. Too bad, it means we have to keep
>>> the slots API and the kernel will be stuck with it forever (even if
>>> some day userspace can manage key ids instead of slots).
>>
>> Yap, but I think there won't be any change like that in the near future.
> 
> As far as I understand the conclusion of the discussion, the best 
> practice for the keys management is to keep keys discrete including the 
> Tx/Rx keys separation. On the other hand, from the OpenVPN protocol 
> perspective, keys are grouped into slots and peers perform so called key 
> slots swapping.
> 
> As I can see, we have two options to adjust userspace application and 
> kernel to each other:
> 1) implement "key slots" abstraction in Netlink API to keep kernel 
> interface similar to the current OpenVPN protocol;
> 2) implement "discrete" keys management via Netlink API and move "slots" 
> abstraction to the userspace application.
> 
> Sabrina already mentioned that kernel will stuck with the slots 
> abstraction forever. This is due to the rule that user's API should not 
> be changed.
> 
> Antonio, can we consider implementing the slot abstraction in the 
> userspace application? It will move complexity from the kernel to the 
> userspace, where it can be easy debugged and maintained.
> 
> And since the keys management is part of the control plane. Keeping 
> abstraction closer to the control plane implementation will allow any 
> protocol modification, while keeping the kernel forward compatible.

Thanks for chiming in!

Right now the implementation is already pretty simple IMHO, there is not 
much complexity to move to userspace.
And that's because ovpn in kernelspace "thinks" in terms of slots like 
userspace.

If we want to go with a different approach, we have to add the 
"complexity" of converting abstraction from slots to anything being 
proposed here.

I presume you're advocating about moving from slots to key IDs (and 
separate keys for TX and RX)?

How do you see it working in detail?
I.e. how many keys should we store and when should we purge them?
(right now we just keep 2 pair of keys - aka slots - and the lifecycle 
is simply done)
And why do you think it is simpler?

One more advantage I see about using slots is that it's easy to match 
the user and kernel space states: at any point in time userspace can say 
"these are the pairs I have in my two slots" and kernelspace will just 
mirror that, without having to care about old IDs.

Don't you think this approach is already pretty simple and less error 
prone with respect to going through an abstraction conversion?

Thanks!

Cheers,

> 
>>>> Hence my proposal to keep the API the same, but rework the internal for
>>>> better implementation.
>>>
>>> Yeah, that makes sense if you have that constraint imposed by the
>>> existing userspace.
>>>
>>>>
>>>>>
>>>>> Maybe you can also rework the current code to look a bit like this
>>>>> array-based proposal, and not give up the notion of slots, if that's
>>>>> something strongly built into the core of openvpn:
>>>>>
>>>>> - primary/secondary in ovpn_crypto_state become slots[2]
>>>>> - add a one-bit "primary" reference, used to look into the slots array
>>>>> - swap just flips that "primary" bit
>>>>> - TX uses slots[primary]
>>>>> - RX keeps inspecting both slots (now slot[0] and slot[1] instead of
>>>>>     primary/secondary) looking for the correct keyid
>>>>> - setkey/delkey still operate on primary/secondary, but need to figure
>>>>>     out whether slot[0] or slot[1] is primary/secondary based on
>>>>>     ->primary
>>>>>
>>>>> It's almost identical to the current code (and API), except you don't
>>>>> need to reassign any pointers to swap keys, so it should avoid the
>>>>> rekey issue.
>>>>
>>>> This approach sounds very close to what I was aiming for, but simpler
>>>> because we have slots[2] instead of slots[8] (which means that 
>>>> primary_id
>>>> can be just 'one-bit').
>>>
>>> Yes.
>>>
>>>> The only downside is that upon RX we have to check both keys.
>>>> However I don't think this is an issue as we have just 2 keys at most.
>>>>
>>>> I could even optimize the lookup by starting always from the primary 
>>>> key, as
>>>> that's the one being used most of the time by the sender.
>>>
>>> Nice.
>>>
>>>> Ok, I will go with this approach you summarized here at the end.
>>>
>>> Ok. I think it should be a pretty minimal set of changes on top of the
>>> existing code, especially if you hide the primary/secondary accesses
>>> in inline helpers.
>>
>> I think so to - working on it.
> 

-- 
Antonio Quartulli
OpenVPN Inc.

