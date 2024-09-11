Return-Path: <netdev+bounces-127354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2599752DF
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 14:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69E041F238C7
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 12:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1861885B4;
	Wed, 11 Sep 2024 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="crZFLyvn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37153EC4
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 12:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726059004; cv=none; b=bhoPmzxJqzRovMb9JmFhBCLquQU5tEhQUs3mNb3FgEFZ/AxXiKBTODJOMByOPYwnODxJpfTU1NoASnG8iEuJJ/I904QqdQK4IK+T7IKpNLEU8N9T7vabNmClE6c/vhjYBRy+BR58C87hZyvXVjdFCllOBiCm4cLNsbV2YpIJXlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726059004; c=relaxed/simple;
	bh=tJ93JR0Y4hbHEo179T1UD+zH3lQ2EBbqdh1uoD3juWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mOX+UgI1Ha0Kc5DP9+9YrDgt/onkagoLU+d7vNK/T0sO4JK4BaP/IEDrqSRHwmPKLaj54Tt2M3fs1E60HXKyXOAQ5+DhSFLiXlO+mgsKtt0JWhxPy00XVbj5Qh8sEEpBEcucPDSU1FM/jfRgtY0nlkr+H0zD+ohosLQfWDMcorI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=crZFLyvn; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8a897bd4f1so737602266b.3
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 05:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1726059000; x=1726663800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vCTt/ALI3ynAA/l7UU7HHC8O2lSf8hlEslHgimElybo=;
        b=crZFLyvn2tnbJUV3irfvaMvzOSDdgBYpKRPkA0x2FEhU+p1c5hXlDRBsoYn0ISGCLT
         O1fCd5D8ZqNys2uKBFx2wJc6ozmnU/jmrw8roHuvo6uJLTCK83Wy6Pl1MhRvVP4bvG/j
         8cFETOKj+NWj32Cto4PTao0T356ll2MrjD3bJkqIpWi/vbHD/iYU96aDk1zX3PUXiBR7
         KapbF+WDXg+/rSntwRnQRFtkmLHthPb6oCE15Jr4ay59gMIhywv+a3PRGuQqOFqtWe0q
         WWbD8LBxe8lUYTH37Rivb6hLe5C+hz9ZqH1tLC7FKZgpcoujbPEQMWY6TWKiLbO2YmAE
         fdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726059000; x=1726663800;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCTt/ALI3ynAA/l7UU7HHC8O2lSf8hlEslHgimElybo=;
        b=kA0Hb0c+QzfM8PwU6dreiUQx94JbHe7tWav9Qs4bvo8xz56XNTWhEVRT/NJVyFAPgC
         c+/0lwlI11cBy9Mz5oX+99qCXcdj07EDHMf727M2VBtpRdP2bv1/sOr98zqdRC7eBwTk
         c1M7OGEZMz2pumT8bfgQ7787ral3diyOZZ2YhHU/8CBZlHLjN205C4eM+R94yla4nAPl
         ZIpavKKE4g9G5FyRW24gR2zvOjZr4Hy7TlOii05efX+PoUMOd7xRhqxk0kH4XRqzfOJE
         EDbgsSW63DJEzY7PUBfu7UfOjiIHBQ/STSITp4CkxNNzjSQgU/8OfxofNpWpz0+KREUh
         FnMg==
X-Gm-Message-State: AOJu0YzjTt2WLyznCnBZ1h1L1bh0+LqwR7cRoAWpi5/Gtd4dkgeltpie
	4TN965x/UCnTeweC+38zX2KEz8V3hUCzzwyySA3VD1i/8CUOps/ML+Oq4biVtiA=
X-Google-Smtp-Source: AGHT+IEXDCwrWyexfJ0AAtaqYR+6ucNzFYBY7NGF9dd218xoe8XMbeCuT6EvaO3RWt4M+bNVdic47Q==
X-Received: by 2002:a17:907:60cb:b0:a86:799d:f8d1 with SMTP id a640c23a62f3a-a8ffad97d26mr380148166b.47.1726059000211;
        Wed, 11 Sep 2024 05:50:00 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:740c:c15b:ad12:7441? ([2001:67c:2fbc:1:740c:c15b:ad12:7441])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d259526c3sm610298866b.69.2024.09.11.05.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 05:49:59 -0700 (PDT)
Message-ID: <af164160-6402-45f9-8ef3-d5a3ffd43452@openvpn.net>
Date: Wed, 11 Sep 2024 14:52:10 +0200
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
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZuBD7TWOQ7huO7_7@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/09/2024 15:04, Sabrina Dubroca wrote:
> 2024-09-06, 15:19:08 +0200, Antonio Quartulli wrote:
>> On 04/09/2024 17:01, Sabrina Dubroca wrote:
>>> 2024-09-04, 14:07:23 +0200, Antonio Quartulli wrote:
>>>> On 02/09/2024 16:42, Sabrina Dubroca wrote:
>>>>> 2024-08-27, 14:07:52 +0200, Antonio Quartulli wrote:
>>> I can think of a few possibilities if this causes too many unwanted
>>> drops:
>>>
>>>    - use a linked list of keys, set the primary instead of swapping, and
>>>      let delete remove the unused key(s) by ID instead of slot
>>>
>>>    - decouple the TX and RX keys, which also means you don't really need
>>>      to swap keys (swap for the TX key becomes "set primary", swap on RX
>>>      can become a noop since you check both slots for the correct keyid)
>>>      -- and here too delete becomes based on key ID
>>>
>>>    - if cs->mutex becomes a spinlock, take it in the datapath when
>>>      looking up keys. this will make sure we get a consistent view of
>>>      the keys state.
>>>
>>>    - come up with a scheme to let the datapath retry the key lookup if
>>>      it didn't find the key it wanted (maybe something like a seqcount,
>>>      or maybe taking the lock and retrying if the lookup failed)
>>>
>>> I don't know if options 1 and 2 are possible based on how openvpn (the
>>> protocol and the userspace application) models keys, but they seem a
>>> bit "cleaner" on the datapath side (no locking, no retry). But they
>>> require a different API.
>>
>> After chewing over all these ideas I think we can summarize the requirements
>> as follows:
>>
>> * PRIMARY and SECONDARY in the API is just an abstraction for "KEY FOR TX"
>> and "THE OTHER KEY";
>> * SWAP means "mark for TX the key that currently was not marked";
>> * we only need a pointer to the key for TX;
>> * key for RX is picked up by key ID;
>>
>> Therefore, how about having an array large enough to store all key IDs (max
>> ID is 7):
> 
> Right, I forgot about that. For 8 keys, sure, array sounds ok. MACsec
> has only 4 and I also implemented it as an array
> (include/net/macsec.h: macsec_{tx,rx}_sc, sa array).

thanks for the pointer!

> 
>> * array index is the key ID (fast lookup on RX);
>> * upon SET_KEY we store the provided keys and erase the rest;
> 
> I'm not sure about erasing the rest. If you're installing the
> secondary ("next primary") key, you can't just erase the current
> primary? ("erase the rest" also means you'd only ever have one key in
> the array, which contradicts your last item in this list)
Yeah, my point is wrong.
I fooled myself assuming SET_KEY would install two keys each time, but 
this is not the case, so we can't "erase everything else".

What we can do is:
* if SET_KEY wants to install a key in PRIMARY, then we erase the key 
marked as "primary" and we mark the new one as such
* if SET_KEY wants to install a key in SECONDARY, then we erase the key 
without any mark.

This way we simulate writing into slots.

> 
>> * upon SET_KEY we store in a new field the index/ID of the PRIMARY (fast
>> lookup on TX), namely primary_id;

FTR: this is what "marking as primary" means

>> * upon SWAP we just save in primary_id the "other" index/ID;
> 
> I'm confused by these two. Both SET_KEY and SWAP modify the primary_id?

Yes.
SET_KEY may want to install a key in the primary slot: in that case the 
new key has to be marked as primary immediately.
This normally happens only upon first SET_KEY after connection, when no 
other key exists.

SWAP will switch primary_id to the other key ID.

makes sense?

> 
>> * at any given time we will have only two keys in the array.
> 
> This needs to be enforced in the SET_KEY implementation, otherwise
> SWAP will have inconsistent effects.

yap. I hope what I wrote above about SET_KEY helps clarifying this part.

> 
> 
>> It's pretty much like your option 1 and 2, but using an array
>> indexed by key ID.
> 
> Are you decoupling TX and RX keys (so that they can be installed
> independently) in this proposal? I can't really tell, the array could
> be key pairs or separate.

I would not decouple TX and RX keys.
Each array item should be the same as what we are now storing into each 
slot (struct ovpn_crypto_key_slot *).
I could use two arrays, instead of an array of slots, but that means 
changing way more logic and I don't see the benefit.

> 
> 
>> The concept of slot is a bit lost, but it is not important as long as we can
>> keep the API and its semantics the same.
> 
> Would it be a problem for userspace to keep track of key IDs, and use
> that (instead of slots) to communicate with the kernel? Make
> setkey/delkey be based on keyid, and replace swap with a set_tx
> operation which updates the current keyid for TX. That would seem like
> a better API, especially for the per-ID array you're proposing
> here. The concept of slots would be almost completely lost (only
> "current tx key" is left, which is similar to the "primary slot").
> (it becomes almost identical to the way MACsec does things, except
> possibly that in MACsec the TX and RX keys are not paired at all, so
> you can install/delete a TX key without touching any RX key)
> 

unfortunately changing userspace that way is not currently viable.
There are more components (and documentation) that attach to this slot 
abstraction.

Hence my proposal to keep the API the same, but rework the internal for 
better implementation.

> 
> Maybe you can also rework the current code to look a bit like this
> array-based proposal, and not give up the notion of slots, if that's
> something strongly built into the core of openvpn:
> 
> - primary/secondary in ovpn_crypto_state become slots[2]
> - add a one-bit "primary" reference, used to look into the slots array
> - swap just flips that "primary" bit
> - TX uses slots[primary]
> - RX keeps inspecting both slots (now slot[0] and slot[1] instead of
>    primary/secondary) looking for the correct keyid
> - setkey/delkey still operate on primary/secondary, but need to figure
>    out whether slot[0] or slot[1] is primary/secondary based on
>    ->primary
> 
> It's almost identical to the current code (and API), except you don't
> need to reassign any pointers to swap keys, so it should avoid the
> rekey issue.

This approach sounds very close to what I was aiming for, but simpler 
because we have slots[2] instead of slots[8] (which means that 
primary_id can be just 'one-bit').

The only downside is that upon RX we have to check both keys.
However I don't think this is an issue as we have just 2 keys at most.

I could even optimize the lookup by starting always from the primary 
key, as that's the one being used most of the time by the sender.

Ok, I will go with this approach you summarized here at the end.

Thanks a lot!
Cheers,

> 

-- 
Antonio Quartulli
OpenVPN Inc.

