Return-Path: <netdev+bounces-112077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B7F934DC1
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 15:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84331F24319
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 13:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D38813C699;
	Thu, 18 Jul 2024 13:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ofdk//to"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E108713BAC5
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721307864; cv=none; b=CypS2cWz/MUGqOxQ8cw2jhesDO3aNd4y1p3FJXcmpWZaMhUj+iE8FSP35ADbbKZcXp7vtdL2v23/Y5Y9MGBUqDs0po/uI4qQ2pdAF0RvRUV+BlzYHF9QXa801yJFPvlh64O1FvexNpWOL0EgDmQP58Jx6XAk0/x9v8yEy6K92xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721307864; c=relaxed/simple;
	bh=t/t7sZUiz2/KhCqsJKwKkVf10PXpfK+ivqzAv1LbhRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UAB+tGDjrIOMGCfeucCpMqF9dEWN8EXjJxO7o4fjLvT5vhY2Lp31bl/kG0M2AtjF16+eL5nl+E6SDb6/suQUrSLS1c/6SUQZ//j6265O04tizb9hn1qJY72JINFTnHg37m/1lPZYgAKz9hwvq3SoWBAlNcEkAlnY+za4EwsEenw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ofdk//to; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a77e7a6cfa7so83389366b.1
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 06:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1721307860; x=1721912660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w0OiVT1BUUB7iHxYph6GC2ew2V9X1hyNWyNKSJDV2eA=;
        b=Ofdk//tob4G2vffzbNQLXrrdXgADFSGuPPAwnA0Kz1AUz8736RU20oDnB48ANGHwT8
         Etd0SdMgGgJfLWnvgVbjcCAMsFqR/jB1gZggHGlQ/+Zuot+Uu17M3Q7AlQaTECBefbHc
         nSfGNxnMeSb4/75PJquMUQf+fsMCeZyCbTdBjErKkf+CHQ+1fzfL4CWqSOSF82HozZMw
         1FeKIbkXmBQzxVQErnqkDF2WVg+rsYXCuAD4m3vWjESPuXkzQhG4rph4SN8AzWbEdExK
         H/jKdMg5rB8ttvGCKCtzTlIlsTKIaoL2qzKVC/j1tdxYq9jWjs+dAkmyygfEuGGYZ/8w
         v+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721307860; x=1721912660;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0OiVT1BUUB7iHxYph6GC2ew2V9X1hyNWyNKSJDV2eA=;
        b=f2yt+oaIAQbShjdDR0g56GJ9gWLroE1zv58P0NWxh4bynKJs3e8e4YdOZNFm7suq5Q
         eJm/HP4wo9PmsQeTmUUpdvn+phgUN7a9MHwflbRdjfUHphX3cf3UfHNMomimJwMAIcq+
         dHSPhebW7xFwVEtpBU0lZiilXmqSvtPQROeBkWSSgP8NNmx6P0WBpZvuoAOU3XmWCQdL
         CQ+9yeFFghuFmzRyxhWFOlB/AFtp8Tsu8H3eaf9Wk70x5PCowJUxyLwAZwnhaifaoN+h
         99Uw7SXy9G1tkZn3175Kb83bxjAjNwVZVeNNJ7bYSzOlPSQEsXaRQfJR3JYtkUA6evPv
         q2aA==
X-Gm-Message-State: AOJu0YwmQfVBxGow460vtbN0QIglpT5Br1TZ++CHqvzxLOSqe2W+wi2Q
	eaGVMKdOF7yzeJJaB/WzB664EshBkoCahwX2I7Ja5mZ3SU+XlvlQLE5IZTL64F0=
X-Google-Smtp-Source: AGHT+IF/JrGaqOQaSD7NeGEHqlmSOnxGJmCSNR3wEBhX1ay+g+5dU6r5cev8wDYAdjDeaTK4sAkTQw==
X-Received: by 2002:a17:906:2807:b0:a72:428f:cd66 with SMTP id a640c23a62f3a-a7a011a086emr314065666b.39.1721307859949;
        Thu, 18 Jul 2024 06:04:19 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:14d5:6a6d:7aec:1e83? ([2001:67c:2fbc:1:14d5:6a6d:7aec:1e83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f1b94sm557057766b.112.2024.07.18.06.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 06:04:19 -0700 (PDT)
Message-ID: <10c01ca1-c79a-41ab-b99b-deab81adb552@openvpn.net>
Date: Thu, 18 Jul 2024 15:06:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 10/24] ovpn: implement basic RX path (UDP)
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-11-antonio@openvpn.net> <Zj4k9g1hV1eHQ4Ox@hog>
 <eb9558b3-cd7e-4da6-a496-adca6132a601@openvpn.net> <Zpjyg-nO42rA3W_0@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Zpjyg-nO42rA3W_0@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/07/2024 12:46, Sabrina Dubroca wrote:
> Sorry Antonio, I'm only coming back to this now.

No worries and thanks for fishing this email.

> 
> 2024-05-10, 16:41:43 +0200, Antonio Quartulli wrote:
>> On 10/05/2024 15:45, Sabrina Dubroca wrote:
>>> 2024-05-06, 03:16:23 +0200, Antonio Quartulli wrote:
>>>> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
>>>> index 36cfb95edbf4..9935a863bffe 100644
>>>> --- a/drivers/net/ovpn/io.c
>>>> +++ b/drivers/net/ovpn/io.c
>>>> +/* Called after decrypt to write the IP packet to the device.
>>>> + * This method is expected to manage/free the skb.
>>>> + */
>>>> +static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
>>>> +{
>>>> +	/* packet integrity was verified on the VPN layer - no need to perform
>>>> +	 * any additional check along the stack
>>>
>>> But it could have been corrupted before it got into the VPN?
>>
>> It could, but I believe a VPN should only take care of integrity along its
>> tunnel (and this is guaranteed by the OpenVPN protocol).
>> If something corrupted enters the tunnel, we will just deliver it as is to
>> the other end. Upper layers (where the corruption actually happened) have to
>> deal with that.
> 
> I agree with that, but I don't think that's what CHECKSUM_UNNECESSARY
> (especially with csum_level = MAX) would do. CHECKSUM_UNNECESSARY
> tells the networking stack that the checksum has been verified (up to
> csum_level+1, so 0 means the first level of TCP/UDP type headers has
> been validated):
> 
> // include/linux/skbuff.h
> 
>   * - %CHECKSUM_UNNECESSARY
>   *
>   *   The hardware you're dealing with doesn't calculate the full checksum
>   *   (as in %CHECKSUM_COMPLETE), but it does parse headers and verify checksums
>   *   for specific protocols. For such packets it will set %CHECKSUM_UNNECESSARY
>   *   if their checksums are okay.
> 
>   *   &sk_buff.csum_level indicates the number of consecutive checksums found in
>   *   the packet minus one that have been verified as %CHECKSUM_UNNECESSARY.
>   *   For instance if a device receives an IPv6->UDP->GRE->IPv4->TCP packet
>   *   and a device is able to verify the checksums for UDP (possibly zero),
>   *   GRE (checksum flag is set) and TCP, &sk_buff.csum_level would be set to
>   *   two. If the device were only able to verify the UDP checksum and not
>   *   GRE, either because it doesn't support GRE checksum or because GRE
>   *   checksum is bad, skb->csum_level would be set to zero (TCP checksum is
>   *   not considered in this case).
> 
> I think you want CHECKSUM_NONE:
> 
>   *   Device did not checksum this packet e.g. due to lack of capabilities.
> 
> Then the stack will check if the packet was corrupted.

I went back to the wireguard code, which I used for inspiration for this 
specific part (we are dealing with the same problem here):

https://elixir.bootlin.com/linux/v6.10/source/drivers/net/wireguard/receive.c#L376

basically the idea is: with our encapsulation we can guarantee that what 
entered the tunnel is also exiting the tunnel, without corruption.
Therefore we claim that checksums are all correct.

Doesn't it make sense?

Cheers,

> 
>>
>>>
>>>> +	 */
>>>> +	skb->ip_summed = CHECKSUM_UNNECESSARY;
>>>> +	skb->csum_level = ~0;
>>>> +
>>>
> 

-- 
Antonio Quartulli
OpenVPN Inc.

