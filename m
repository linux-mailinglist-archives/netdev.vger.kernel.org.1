Return-Path: <netdev+bounces-125938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F69296F53B
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 15:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DFC61C21CAC
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 13:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F131CB152;
	Fri,  6 Sep 2024 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="BqQYRWhe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F050B1CB15C
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 13:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725628626; cv=none; b=m3Bc3IA2XLN2lxF0+fb9xIv9L45SJNaKX9oesvGNjbuFt/Fxl1cCnqFDp3i+t+TO/JlzvO7LsPy6r+vBNlEGusbuJyVav07KLSNYYaOJxDZRylj8N9fJgDogm3qyrtGN8yIhN63YgdBQlNuqORBkMZdIN2Ex9TYChJGxAl1P7Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725628626; c=relaxed/simple;
	bh=EtOuL9SLmzCJZfVqnaT4Y0GzIuUbzTmtdcNBbbEAqcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hIlQTEUvLxR+RZZ4MihriG0cCC+BBYshowdeeTKWo8zDSxz8UyGrK1LKnnEp+6r19fmj5UiOqL1xiTxWqdrN6zRrsGQebYu3jeK4a81aAe9AWOvzVReElp0mEsi1gsfgFKyVMCTcCoHl5/w3WZQmLsKzlQlcidYt858Hge64ucI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=BqQYRWhe; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42c7856ed66so15106835e9.3
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 06:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1725628622; x=1726233422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kyoPKYo3YNwzn4pnWN/llg+7EjXU+jU4naOGdTs8O6c=;
        b=BqQYRWheR/DOq2WMSPRdWMLEwk4x2+oNQp+kd2VYTbYxX8yPiOqgIOPAgQ95zNGit8
         F5bjtK59I4qUNRfTfIByWIVWYlH2TREpEnbvSOhkRRjxcTpRYLOKZ+BBdCfLFAQRkOOk
         m61gVpjgYNGDPQT+EvSCUCk7yAiSV12u30XOS0vEymr9Bcw1xZHmXZYfelwUyt2GkkwN
         8RvHRNoIqoEriSUdGHABuS2JYPzD1P6JIEe/zc4VgritWqyvAShpRnjSlBc4aLTV0iPB
         zMjv0IkY8CWJiP1PMvc4vcnm9kE4jNR2q0Ucln/1QScV7mHllPdqAQCAA6lGKcnfZkHM
         3hmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725628622; x=1726233422;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyoPKYo3YNwzn4pnWN/llg+7EjXU+jU4naOGdTs8O6c=;
        b=nkhI4tWbky8+CICxVwtH34jf3j7NJSIDtquXkPM/Q5UcdL+XcYctOYOhSS5gmLCkdU
         Cedhh+wcBPpPbQGb33FacBvSkIAlpqR40sPS2nYP1IDxL8hPaRTyofYDsFMi+vH9ubiA
         fGcVjVF4Lg8E/WJJAfue3RnZ4AfYkP2Ow+WVWn8BsUz/wH78W7MLhuIAjUq8G151zPHx
         0PYqYHPxXdbFDznD0WHRZvNNd9CszLiDtIciypiHCjsWQ31JWpNUzY1zrd5tMY6ghjrG
         rzxb5H998KX3LkQaTZBJK3ccS9yrpPjKoVHEc7EuxxaJBxa9M44B+jx5AxQZegaz6Qeb
         3J2w==
X-Gm-Message-State: AOJu0YwCW/WO0R/XWlhuK4LAJdK+v7MlT9GjjUEmCp0ntNFSd6xPnPEL
	3IUL+vdngHqOJaxrBdtMPVp+Y0HmLIEzRwhSh2FyCS1qq8J5Pa6ac5VLH257uMc=
X-Google-Smtp-Source: AGHT+IFgmpFYJW2l0yJZuyr+mbHLXM9UXDlLGKlWWCB5fUTg4XwrMEW0WxuZKr4gqaE+xOK/KWqlkw==
X-Received: by 2002:a5d:6b51:0:b0:36d:2941:d534 with SMTP id ffacd0b85a97d-3749b558309mr17495647f8f.36.1725628621965;
        Fri, 06 Sep 2024 06:17:01 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:9b0:9865:5539:6303? ([2001:67c:2fbc:1:9b0:9865:5539:6303])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05c2656sm20634815e9.7.2024.09.06.06.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 06:17:01 -0700 (PDT)
Message-ID: <9ab97386-b83d-484e-8e6d-9f67a325669d@openvpn.net>
Date: Fri, 6 Sep 2024 15:19:08 +0200
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
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Zth2Trqbn73QDnLn@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/09/2024 17:01, Sabrina Dubroca wrote:
> 2024-09-04, 14:07:23 +0200, Antonio Quartulli wrote:
>> Hi,
>>
>> On 02/09/2024 16:42, Sabrina Dubroca wrote:
>>> 2024-08-27, 14:07:52 +0200, Antonio Quartulli wrote:
>>>> +/* this swap is not atomic, but there will be a very short time frame where the
>>>
>>> Since we're under a mutex, I think we might get put to sleep for a
>>> not-so-short time frame.
>>>
>>>> + * old_secondary key won't be available. This should not be a big deal as most
>>>
>>> I could be misreading the code, but isn't it old_primary that's
>>> unavailable during the swap? rcu_replace_pointer overwrites
>>> cs->primary, so before the final assign, both slots contain
>>> old_secondary?
>>
>> Right. The comment is not correct.
>>
>> cs->secondary (old_secondary, that is the newest key) is what is probably
>> being used by the other peer for sending traffic.
> 
> Right, thanks. I was getting confused about the key slots and which
> key was the newest.
> 
> If the peer has already started sending with the newest key, no
> problem. If we're swapping keys before our peer (or we're on a slow
> network and the peer's packets get delayed), we'll still be receiving
> packets encrypted with the old key.

Right, it's mostly impossible to make the swap happen at the same time 
on both ends.

> 
> 
>> Therefore old_secondary is what is likely to be needed.
>>
>> However, this is pure speculation and may not be accurate.
> 
> I can think of a few possibilities if this causes too many unwanted
> drops:
> 
>   - use a linked list of keys, set the primary instead of swapping, and
>     let delete remove the unused key(s) by ID instead of slot
> 
>   - decouple the TX and RX keys, which also means you don't really need
>     to swap keys (swap for the TX key becomes "set primary", swap on RX
>     can become a noop since you check both slots for the correct keyid)
>     -- and here too delete becomes based on key ID
> 
>   - if cs->mutex becomes a spinlock, take it in the datapath when
>     looking up keys. this will make sure we get a consistent view of
>     the keys state.
> 
>   - come up with a scheme to let the datapath retry the key lookup if
>     it didn't find the key it wanted (maybe something like a seqcount,
>     or maybe taking the lock and retrying if the lookup failed)
> 
> I don't know if options 1 and 2 are possible based on how openvpn (the
> protocol and the userspace application) models keys, but they seem a
> bit "cleaner" on the datapath side (no locking, no retry). But they
> require a different API.

After chewing over all these ideas I think we can summarize the 
requirements as follows:

* PRIMARY and SECONDARY in the API is just an abstraction for "KEY FOR 
TX" and "THE OTHER KEY";
* SWAP means "mark for TX the key that currently was not marked";
* we only need a pointer to the key for TX;
* key for RX is picked up by key ID;

Therefore, how about having an array large enough to store all key IDs 
(max ID is 7):
* array index is the key ID (fast lookup on RX);
* upon SET_KEY we store the provided keys and erase the rest;
* upon SET_KEY we store in a new field the index/ID of the PRIMARY (fast 
lookup on TX), namely primary_id;
* upon SWAP we just save in primary_id the "other" index/ID;
* at any given time we will have only two keys in the array.

It's pretty much like your option 1 and 2, but using an array indexed by 
key ID.

The concept of slot is a bit lost, but it is not important as long as we 
can keep the API and its semantics the same.


Opinions?


> 
> Do you have the same problem in the current userspace implementation?

userspace is single-threaded :-P
nothing happens while we are busy swapping.

> 
> 
>> The fact that we could sleep before having completed the swap sounds like
>> something we want to avoid.
>> Maybe I should convert this mutex to a spinlock. Its usage is fairly
>> contained anyway.
> 
> I think it would make sense. It's only being held for very short
> periods, just to set/swap a few pointers.

ACK

> 
> 
>> FTR: this restructuring is the result of having tested encryption/decryption
>> with pcrypt: sg, that is passed to the crypto code, was initially allocated
>> on the stack, which was obviously not working for async crypto.
>> The solution was to make it part of the skb CB area, so that it can be
>> carried around until crypto is done.
> 
> I see. I thought this patch looked less familiar than the others :)
> 
> An alternative to using the CB is what IPsec does: allocate a chunk of
> memory for all its temporary needs (crypto req, sg, iv, anything else
> it needs during async crypto) and carve the pointers/small chunks out
> of it. See esp_alloc_tmp in net/ipv4/esp4.c.  (I'm just mentioning
> that for reference/curiosity, not asking that you change ovpn)
> 
> 
>> This patch was basically re-written after realizing that the async crypto
>> path was not working as expected, therefore sorry if there were some "kinda
>> obvious" mistakes.
> 
> And I completely missed some of those issues in previous reviews.
> 
>> Thanks a lot for your review.
> 
> Cheers, and thanks for your patience.
> 

Cheers!

-- 
Antonio Quartulli
OpenVPN Inc.

