Return-Path: <netdev+bounces-129206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B6797E310
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 21:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE7391F2125E
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 19:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C35551C45;
	Sun, 22 Sep 2024 19:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rrae+qAI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C7A3D0AD
	for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727034670; cv=none; b=aiLPtFNyaxGruAOCemeEH/qg7JTDP2Zy6ZOEKD78CrYzjJIeD2pu8W5D8pwtSoUcmmQWrNIxIlJ5hAbi5Nfu00Pxu2g3WsX4swJNZ/SRm5SlhYVlV6l1eb37viSicMGN6dUK44m6PLXTSWsshhLh7NSHwfzdP338K/r8BGlW11E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727034670; c=relaxed/simple;
	bh=AneVyMYgh2ibWW88aKvABdWvNEwO1ucrIce1vlPRBEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WQnIhZ7uh6rg4hOasA9IY3jeIP8LUk5NlMAWakJ9PBoc6PDkfMs+8FFvxaJYxxI6vLztvThIN/0SNx7Yk/dsd8Fd+DjtYdX3RXmSUgH5fmSa0SUNcPzMKCWQzZsIG2+vlmnF8vlPhJs/NUanJmxqN8cdMpR2Yh6Bctley8umSyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rrae+qAI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cbc38a997so22815235e9.1
        for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 12:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727034667; x=1727639467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m5voELsujes6y6tSBpCDVKv9Ag4ESuAIgYJqtpsNvSc=;
        b=Rrae+qAIZsWNI4XPdEL2+/JSWe19zlozxMJVfoynWG8T7Qcge242LuWCP7rB4/nML9
         6BlkSJspI+CAgg8ZY3Y6Kh8x4+aZswUmzMCR0ijFpTg0gIOM3IImG9Ywy2WreRI+wq3U
         aSatiJvZlhdrgXhJGHLChUf92yCp7AZosaPCLDtxCMPZQDjClpOud512qnmYWyBRSrga
         GAVGd3+jKAkuIpljIbsNK0TMe8pdBPYTv3cQkvPJV2Y1e2frfxDv+zwVu+FwR4eAr58h
         C8VOJ5FRPPbNlBwQI7nAYHRiVlGeJnXruWrzwJsCIHChBE8sVm7HoZuVOHjyDZddClN4
         Hkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727034667; x=1727639467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5voELsujes6y6tSBpCDVKv9Ag4ESuAIgYJqtpsNvSc=;
        b=D8/Bp69qMLmu5rQcwya8WdICl3pr+znXpXXz8EG8paNz6moXB351HF+xShbTfNb6uo
         DPluKNO/+aXrOleQoLbh7TTV8z4OKRyPYSlB78/5n3U2bHBe3vqpSYXORm99QGpqrDSN
         Bs4STJTHcWk/5qcV5yJWBZttpVKKyoxFgApIZ+CqPvQ7rAb6PWWTdZq+IOqcbGGjs0zR
         BgNcUVbl1JP5+ryprQ1zMlt6dlEk4EC7IIrmV0nohHB3ft5seIlMGcOAnyXOJRq4EECG
         fEP11pDC8bdP4WZTBFeiut6pzXV82EtxJ8vfi4OF20tTLj8gzLhrVef1Q0AK4W5OuaiD
         hoaA==
X-Gm-Message-State: AOJu0Yy4BmnL26y6zZJbPRdWOMP8PfuILpObREgoHITi8X50COuI87/H
	cPK8AkjhnHPnkgA9575Lu+Yu7P4S46LFwH22kslT9oQ2djIqwIdXM27ePg==
X-Google-Smtp-Source: AGHT+IFcyYIKNmE+aKuqYGwqX+YAAIl3GNdIvKpO1b0egi9H3PKll7NeT+r6WCsM8+evSMB090FuKg==
X-Received: by 2002:a05:600c:4f53:b0:42c:bd4d:e8d6 with SMTP id 5b1f17b1804b1-42e7a8c1d04mr54849945e9.3.1727034666454;
        Sun, 22 Sep 2024 12:51:06 -0700 (PDT)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7afe1437sm81934035e9.33.2024.09.22.12.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 12:51:05 -0700 (PDT)
Message-ID: <f1ba8d14-d157-48d1-8bd2-2dea6e1ecd40@gmail.com>
Date: Sun, 22 Sep 2024 22:51:21 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 12/25] ovpn: implement packet processing
To: Antonio Quartulli <antonio@openvpn.net>,
 Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew@lunn.ch
References: <20240827120805.13681-1-antonio@openvpn.net>
 <20240827120805.13681-13-antonio@openvpn.net> <ZtXOw-NcL9lvwWa8@hog>
 <ae23ac0f-2ff9-4396-9033-617dc60221eb@openvpn.net> <Zth2Trqbn73QDnLn@hog>
 <9ab97386-b83d-484e-8e6d-9f67a325669d@openvpn.net> <ZuBD7TWOQ7huO7_7@hog>
 <af164160-6402-45f9-8ef3-d5a3ffd43452@openvpn.net> <ZuGbZTinqmoBsc6C@hog>
 <1f17e2c5-c844-44a4-8970-64618c6295fb@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <1f17e2c5-c844-44a4-8970-64618c6295fb@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Antonio, Sabrina,

let me join the key management design discussion and put my 2 cents in. 
Please find my comment below.

On 12.09.2024 11:33, Antonio Quartulli wrote:
> On 11/09/2024 15:30, Sabrina Dubroca wrote:
>> 2024-09-11, 14:52:10 +0200, Antonio Quartulli wrote:
>>> On 10/09/2024 15:04, Sabrina Dubroca wrote:
>>>> 2024-09-06, 15:19:08 +0200, Antonio Quartulli wrote:
>>>>> Therefore, how about having an array large enough to store all key 
>>>>> IDs (max
>>>>> ID is 7):
>>>>
>>>> Right, I forgot about that. For 8 keys, sure, array sounds ok. MACsec
>>>> has only 4 and I also implemented it as an array
>>>> (include/net/macsec.h: macsec_{tx,rx}_sc, sa array).
>>>
>>> thanks for the pointer!
>>>
>>>>
>>>>> * array index is the key ID (fast lookup on RX);
>>>>> * upon SET_KEY we store the provided keys and erase the rest;
>>>>
>>>> I'm not sure about erasing the rest. If you're installing the
>>>> secondary ("next primary") key, you can't just erase the current
>>>> primary? ("erase the rest" also means you'd only ever have one key in
>>>> the array, which contradicts your last item in this list)
>>> Yeah, my point is wrong.
>>> I fooled myself assuming SET_KEY would install two keys each time, 
>>> but this
>>> is not the case, so we can't "erase everything else".
>>>
>>> What we can do is:
>>> * if SET_KEY wants to install a key in PRIMARY, then we erase the key 
>>> marked
>>> as "primary" and we mark the new one as such
>>> * if SET_KEY wants to install a key in SECONDARY, then we erase the key
>>> without any mark.
>>
>> Ok, then the DEL_KEY op would not really be needed.
> 
> It would be needed only when we want to kick an old key without 
> installing a new one.
> IMHO something that should not truly happen during the normal lifecycle 
> of a peer, but there might be some corner cases where userspace may 
> still want to do that (I am checking userspace to understand when this 
> can truly happen, if at all)
> 
>>
>>>
>>> This way we simulate writing into slots.
>>>
>>>>
>>>>> * upon SET_KEY we store in a new field the index/ID of the PRIMARY 
>>>>> (fast
>>>>> lookup on TX), namely primary_id;
>>>
>>> FTR: this is what "marking as primary" means
>>>
>>>>> * upon SWAP we just save in primary_id the "other" index/ID;
>>>>
>>>> I'm confused by these two. Both SET_KEY and SWAP modify the primary_id?
>>>
>>> Yes.
>>> SET_KEY may want to install a key in the primary slot: in that case 
>>> the new
>>> key has to be marked as primary immediately.
>>> This normally happens only upon first SET_KEY after connection, when no
>>> other key exists.
>>>
>>> SWAP will switch primary_id to the other key ID.
>>>
>>> makes sense?
>>
>> Yes, thanks, that fixes up all my confusion around setting primary_id.
>>
>>>>> * at any given time we will have only two keys in the array.
>>>>
>>>> This needs to be enforced in the SET_KEY implementation, otherwise
>>>> SWAP will have inconsistent effects.
>>>
>>> yap. I hope what I wrote above about SET_KEY helps clarifying this part.
>>>
>>>>
>>>>
>>>>> It's pretty much like your option 1 and 2, but using an array
>>>>> indexed by key ID.
>>>>
>>>> Are you decoupling TX and RX keys (so that they can be installed
>>>> independently) in this proposal? I can't really tell, the array could
>>>> be key pairs or separate.
>>>
>>> I would not decouple TX and RX keys.
>>> Each array item should be the same as what we are now storing into 
>>> each slot
>>> (struct ovpn_crypto_key_slot *).
>>> I could use two arrays, instead of an array of slots, but that means
>>> changing way more logic and I don't see the benefit.
>>
>> Avoid changing both keys every time when a link has very asymmetric
>> traffic. And the concept of a primary/secondary key makes no sense on
>> receive, all you need is keyids, and there's no need to swap slots,
>> which avoids the "key not available during SWAP" issue
>> entirely. Primary key only makes sense on TX.
>>
>> But I'm guessing the keypair concept is also baked deep into openvpn.
> 
> Correct. Both keys are recomputed upon each renegotiation, even if one 
> key was still usable.
> 
>>
>>
>>>>> The concept of slot is a bit lost, but it is not important as long 
>>>>> as we can
>>>>> keep the API and its semantics the same.
>>>>
>>>> Would it be a problem for userspace to keep track of key IDs, and use
>>>> that (instead of slots) to communicate with the kernel? Make
>>>> setkey/delkey be based on keyid, and replace swap with a set_tx
>>>> operation which updates the current keyid for TX. That would seem like
>>>> a better API, especially for the per-ID array you're proposing
>>>> here. The concept of slots would be almost completely lost (only
>>>> "current tx key" is left, which is similar to the "primary slot").
>>>> (it becomes almost identical to the way MACsec does things, except
>>>> possibly that in MACsec the TX and RX keys are not paired at all, so
>>>> you can install/delete a TX key without touching any RX key)
>>>>
>>>
>>> unfortunately changing userspace that way is not currently viable.
>>> There are more components (and documentation) that attach to this slot
>>> abstraction.
>>
>> I thought that might be the case. Too bad, it means we have to keep
>> the slots API and the kernel will be stuck with it forever (even if
>> some day userspace can manage key ids instead of slots).
> 
> Yap, but I think there won't be any change like that in the near future.

As far as I understand the conclusion of the discussion, the best 
practice for the keys management is to keep keys discrete including the 
Tx/Rx keys separation. On the other hand, from the OpenVPN protocol 
perspective, keys are grouped into slots and peers perform so called key 
slots swapping.

As I can see, we have two options to adjust userspace application and 
kernel to each other:
1) implement "key slots" abstraction in Netlink API to keep kernel 
interface similar to the current OpenVPN protocol;
2) implement "discrete" keys management via Netlink API and move "slots" 
abstraction to the userspace application.

Sabrina already mentioned that kernel will stuck with the slots 
abstraction forever. This is due to the rule that user's API should not 
be changed.

Antonio, can we consider implementing the slot abstraction in the 
userspace application? It will move complexity from the kernel to the 
userspace, where it can be easy debugged and maintained.

And since the keys management is part of the control plane. Keeping 
abstraction closer to the control plane implementation will allow any 
protocol modification, while keeping the kernel forward compatible.

>>> Hence my proposal to keep the API the same, but rework the internal for
>>> better implementation.
>>
>> Yeah, that makes sense if you have that constraint imposed by the
>> existing userspace.
>>
>>>
>>>>
>>>> Maybe you can also rework the current code to look a bit like this
>>>> array-based proposal, and not give up the notion of slots, if that's
>>>> something strongly built into the core of openvpn:
>>>>
>>>> - primary/secondary in ovpn_crypto_state become slots[2]
>>>> - add a one-bit "primary" reference, used to look into the slots array
>>>> - swap just flips that "primary" bit
>>>> - TX uses slots[primary]
>>>> - RX keeps inspecting both slots (now slot[0] and slot[1] instead of
>>>>     primary/secondary) looking for the correct keyid
>>>> - setkey/delkey still operate on primary/secondary, but need to figure
>>>>     out whether slot[0] or slot[1] is primary/secondary based on
>>>>     ->primary
>>>>
>>>> It's almost identical to the current code (and API), except you don't
>>>> need to reassign any pointers to swap keys, so it should avoid the
>>>> rekey issue.
>>>
>>> This approach sounds very close to what I was aiming for, but simpler
>>> because we have slots[2] instead of slots[8] (which means that 
>>> primary_id
>>> can be just 'one-bit').
>>
>> Yes.
>>
>>> The only downside is that upon RX we have to check both keys.
>>> However I don't think this is an issue as we have just 2 keys at most.
>>>
>>> I could even optimize the lookup by starting always from the primary 
>>> key, as
>>> that's the one being used most of the time by the sender.
>>
>> Nice.
>>
>>> Ok, I will go with this approach you summarized here at the end.
>>
>> Ok. I think it should be a pretty minimal set of changes on top of the
>> existing code, especially if you hide the primary/secondary accesses
>> in inline helpers.
> 
> I think so to - working on it.


