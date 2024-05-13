Return-Path: <netdev+bounces-95936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 784C28C3E23
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7421F2235F
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 09:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0891487E3;
	Mon, 13 May 2024 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="bYbR06SU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379151487E2
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715592619; cv=none; b=ATW0CY4430Fgj8NffdZ/R5HJAEIhdva1wGJAFUVkxofe8mSASzvtmeVRQV6oIOHGHIbqR2ztqQpWctS9d6sR8ArQSPWSuXGZEDwtzEjCXS8OdGiMPQpu6guoYDgIxwfCrCdWaOBvKDaRTpWTFuehP1HqCkBTTTxVi56G/jxZM6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715592619; c=relaxed/simple;
	bh=YhyN9HgEQxvRkgHFBcycPIaUzMSKBWyHrjpi0ZTkHTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c/QhY3LcMgivRCA1mB1VJACRqU829zeFCJPl4/m0Nlw0RJ59wIxSbyIJq4Q5XhsxxdxKmga3KE6KsISQDrAVCFqd6LBgmuFzhlKMxSzplwwn3PdTw/m+M2eF2/PgN/AtpgJ/CSTaf96HXEBh2WV0AczvHzOrclUwBYoU9QUM3yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=bYbR06SU; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e538a264e0so40045971fa.1
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 02:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715592615; x=1716197415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6g//TlHlLYQxLBNznZsrdWmB56OlPntFCh/5zXrqD90=;
        b=bYbR06SUond48gM3/00CWhTimt7SDoWQJINDiZbIuHNFlpqCqpIS4R6+dwOyVi8nXg
         qPOM2JF9+1g2m8ilv1kc1IAk4JWc5u28WQ3WJOsMtNXm3d323LdpLqWRUtwkKGMuBdyZ
         xz36PRHstiiDVPlVve0nfFXsajzOet6Zn032uzrrJTNheZAcw9vItdLYCJWtbogJuadw
         jFjUgqXwslwAjfYGJOrv4LOG7iG3OESRr7EWyOS/POVsjCOx+Qv4H3Y9ajJo7gNg6qgQ
         qeCzj35rZXHJf13FVDogixP1IREE6meVJ2iGhApVJskIHJWG6Tbpk2pTxkBkl7RYAno8
         /IAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715592615; x=1716197415;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6g//TlHlLYQxLBNznZsrdWmB56OlPntFCh/5zXrqD90=;
        b=uxLVtjvHrEQ6HT3Glw3I5EFcPq9JOTZtfvRr5eNyv0iNqlDeaB+CFUj2KJ5lXLO6te
         0XxZWtHja7Uk+3/oLnhinu5uWfkrJEpp3cYq9eri5dXqc14gx/9z1HBXmMLxnhBpItqL
         UzRioR0dUYvHy9wdBVSMwrRqCviiTvDxqut48LdPEtIwsYjx92oYzW9++Ma6DZcII44D
         v5AOy5AMjdxqxJ0pGyuj6HYUIx1rxFDUCZ4CDvZSF4WhkBJUHzGLiOJX4I73CHQAT1BP
         MRkOfUx6atcif053pzLyUgKGjwmXsjmNytfQmVGLxrse1+DnzCDTSUDVsYVjIjbb3RDC
         Ry/A==
X-Gm-Message-State: AOJu0YwQqKrPwkraxmBqbLXGI6zDlQe1mc526B/fc3qCcgy+chwrgmw4
	j8D48QaKEB4NCGufTqLRgFJkUPV7CPf8uQ3W3yJW/7/LUhK2iGgJhVPawW7q+bg=
X-Google-Smtp-Source: AGHT+IEgZoC8eMVyfR1wunJ5nSeixVAdywLpEwHN8BQIvFrkag6ck8czwJJW0KFQ49ZAq4z+PBxDaw==
X-Received: by 2002:a2e:86d0:0:b0:2da:7944:9547 with SMTP id 38308e7fff4ca-2e51fd3feb4mr91374981fa.5.1715592615089;
        Mon, 13 May 2024 02:30:15 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:b0a4:8921:8456:9b28? ([2001:67c:2fbc:0:b0a4:8921:8456:9b28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a77f8sm10565649f8f.54.2024.05.13.02.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 02:30:14 -0700 (PDT)
Message-ID: <9d8318b3-81b6-45dd-af91-2edd8381dd98@openvpn.net>
Date: Mon, 13 May 2024 11:31:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 11/24] ovpn: implement packet processing
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-12-antonio@openvpn.net> <ZkCB2sFnpIluo3wm@hog>
 <d2733aaa-58fa-47da-a469-a848a6100759@openvpn.net> <ZkHcMw6p31m-ErqY@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZkHcMw6p31m-ErqY@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/05/2024 11:24, Sabrina Dubroca wrote:
>>>> +struct ovpn_crypto_key_slot *
>>>> +ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc)
>>>> +{
>>>> +	return ovpn_aead_crypto_key_slot_init(kc->cipher_alg,
>>>> +					      kc->encrypt.cipher_key,
>>>> +					      kc->encrypt.cipher_key_size,
>>>> +					      kc->decrypt.cipher_key,
>>>> +					      kc->decrypt.cipher_key_size,
>>>> +					      kc->encrypt.nonce_tail,
>>>> +					      kc->encrypt.nonce_tail_size,
>>>> +					      kc->decrypt.nonce_tail,
>>>> +					      kc->decrypt.nonce_tail_size,
>>>> +					      kc->key_id);
>>>> +}
>>>
>>> Why the wrapper? You could just call ovpn_aead_crypto_key_slot_init
>>> directly.
>>
>> Mostly for ahestetic reasons, being the call very large.
> 
> But that wrapper doesn't really do anything.
> 
> In case my previous comment wasn't clear: I would keep the single
> argument at the callsite (whether it's called _new or _init), and kill
> the 10-args variant (it's too verbose and _very_ easy to mess up).

Oh ok, then I misunderstood your earlier comment.

Now it's clear and I totally agree. Originally there was a crypto 
abstraction in ovpn, to allow more crypto families later on.

But I deemed it being too complex and overkill.
This wrapper is a useless leftover of that approach.

Will get rid of this 10-args variant.

> 
> 
>>>> @@ -132,7 +157,81 @@ int ovpn_recv(struct ovpn_struct *ovpn, struct ovpn_peer *peer,
>>>>    static int ovpn_decrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
>>>>    {
>>>> -	return true;
>>>
>>> I missed that in the RX patch, true isn't an int :)
>>> Were you intending this function to be bool like ovpn_encrypt_one?
>>> Since you're not actually using the returned value in the caller, it
>>> would be reasonable, but you'd have to convert all the <0 error values
>>> to bool.
>>
>> Mhh let me think what's best and I wil make this uniform.
> 
> Yes please. If you can make the returns consistent (on success, one
> returns true and the other returns 0), it would be nice.

I am normally all for int, as I don't like failing with no exact code.
Will most likely go with that.

> 
> 
>>>> +	ret = ptr_ring_produce_bh(&peer->netif_rx_ring, skb);
>>>> +drop:
>>>> +	if (likely(allowed_peer))
>>>> +		ovpn_peer_put(allowed_peer);
>>>> +
>>>> +	if (unlikely(ret < 0))
>>>> +		kfree_skb(skb);
>>>> +
>>>> +	return ret;
>>>
>>> Mixing the drop/success returns looks kind of strange. This would be a
>>> bit simpler:
>>>
>>> ovpn_peer_put(allowed_peer);
>>> return ptr_ring_produce_bh(&peer->netif_rx_ring, skb);
>>>
>>> drop:
>>> if (allowed_peer)
>>>       ovpn_peer_put(allowed_peer);
>>> kfree_skb(skb);
>>> return ret;
> 
> Scratch that, it's broken (we'd leak the skb if ptr_ring_produce_bh
> fails). Let's keep your version.

Right.

> 
>> Honestly I have seen this pattern fairly often (and implemented it this way
>> fairly often).
>>
>> I presume it is mostly a matter of taste.
> 
> Maybe. As a reader I find it confusing to land into the "drop" label
> on success and conditionally free the skb.
> 
>> The idea is: when exiting a function 90% of the code is shared between
>> success and failure, therefore let's just write it once and simply add a few
>> branches based on ret.
> 
> If it's 90%, yes. Here, it looked like very little common code.
> 
>> This way we have less code and if we need to chang somethig in the exit
>> path, we can change it once only.
>>
>> A few examples:
>> * https://elixir.bootlin.com/linux/v6.9-rc7/source/net/batman-adv/translation-table.c#L813
>> * https://elixir.bootlin.com/linux/v6.9-rc7/source/net/batman-adv/routing.c#L269
>> * https://elixir.bootlin.com/linux/v6.9-rc7/source/net/mac80211/scan.c#L1344
>>
>>
>> ovpn code can be further simplified by setting skb to NULL in case of
>> success (this way we avoid checking ret) and let ovpn_peer_put handle the
>> case of peer == NULL (we avoid the NULL check before calling it).
> 
> That won't be needed if you don't take a reference. Anyway,
> netif_rx_ring will be gone if you switch to gro_cells, so that code is
> likely to change.

Yap, working on gro_cells right now!

Thanks

-- 
Antonio Quartulli
OpenVPN Inc.

