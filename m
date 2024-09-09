Return-Path: <netdev+bounces-126428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B915B97123B
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 10:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71738285D65
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 08:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9B51B1D4C;
	Mon,  9 Sep 2024 08:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="IbjLtfFL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCE11AE03C
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725871002; cv=none; b=TL0UYS2JQ314U4O5uFebHZwMpAyId43yfiUCDjiXVHW8R/RlSZsUFU+A/sNq6sAhterZ+eW3Ta1BfRte1LeKY95+dpz4n1eJu0eZFvr7FYYz8vz0kTUAMa2Afy0tT8T7oBCZGJpz1Ob71TbYFvTQU2OwZU7lf40V/SXWe0AkXtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725871002; c=relaxed/simple;
	bh=lmUh1Os2VWUc2Mt5YKTmZXnSHDMqmwPcrvooGcPTRkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PszP7UORlJqgK2ZQm+WjlVcnoLYO0p093pyFxTxuPkGDZK/FvnlLwtJ8z4vfoTedx9KOFzCpGHM/m3UX+hKBs61dRHNo+bjEfV7cCGdDFOraRatxu65LSlE8l4lnL4omyooiJkkWAeBj2+Zaao5WtSzQ4i8FHQwMRJQBnWWkhYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=IbjLtfFL; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c3c3b63135so4218880a12.3
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 01:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1725870998; x=1726475798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U7dk4DU3ijmjiVVEW11CLA+99O0eW8uFugD67ebGDoM=;
        b=IbjLtfFL+9DQ85kRmWN97qlFRkSTur2+UmdSjfk2M1scSLUans8jgA1oULvkFnlB2a
         jmNDkD7CyMquTf43z8XMcdmA7MOPxggsAyE33c4zEYdvBcsaL3FBJpZjHrh+9ym0U3c1
         rq5icWuGmhCOIxG3OQPNxP2p2iuQnitqPXHmxlMnF524fdrEP6ocNHsp3moT/RMrhvlD
         IrRO4WSQ05+h61jqB/N3HsuExUfKR5h0D1wQWZcrEVN6GVyZ6leFyRa3Rq6mnSEWZTIz
         Wukn4pi9V03JuHvQvL0kSP9Rv/w83sE6KUrr0CtYx42zhj+6DNNH7w5DDet5F3CE5Nxz
         vLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725870998; x=1726475798;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7dk4DU3ijmjiVVEW11CLA+99O0eW8uFugD67ebGDoM=;
        b=qzTafffXtTr4mfBekWVXIADIlQYYREcIh0qbRbOJyRvxqYqgrg3ZQVjBNOdpuvpCar
         G712/K48DpZ1Y9CL3YvwOKPg03EzYGB/DzeFE8ogYSytF4T9iiiHdY54ekBtqC/LmX6+
         z6fEPhZvFH5/Rjz9+RXyej6qRZyoOAQT1MvK45ULQ2ZL0uGTy3mwoCv7QEm/fdN93WnR
         PsVxIgdB5qbJscTFep9jFto+C8xAJnR6PR6Omm27EB34XfLXhaKIrkvf3yrXMakQouFu
         fu5CYcQJiDp4kzJECbuz9RsfuDT/luRgEJysWTN+Gq6f0vwDpwDmfm+kKpqxnZWHkqTi
         3+zA==
X-Gm-Message-State: AOJu0YxHSdNgDHJ2FWeCm0L/x4Tq9uSyrWmBIQYnRQv0obphvxP7v7D1
	b4UrhXtpax5bzSj9Fprg2iWeItoXEIwqpX4UKABvpDovy0SkJqPZbes72niBwm4=
X-Google-Smtp-Source: AGHT+IF5xt/urqnGK5kkXMEMkQwK54yzNO6ecXJGgt2RkauZONzjLbplFBAxaWIFDiHIddC4GpI2IQ==
X-Received: by 2002:a05:6402:3596:b0:5c2:112f:aa77 with SMTP id 4fb4d7f45d1cf-5c3dc7c6f49mr9177297a12.31.1725870998510;
        Mon, 09 Sep 2024 01:36:38 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:105f:6dd9:35c9:a9e8? ([2001:67c:2fbc:1:105f:6dd9:35c9:a9e8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd523bfsm2750376a12.53.2024.09.09.01.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 01:36:38 -0700 (PDT)
Message-ID: <c15ca875-4684-455c-ab35-39d28f497417@openvpn.net>
Date: Mon, 9 Sep 2024 10:38:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 12/25] ovpn: implement packet processing
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch,
 sd@queasysnail.net
References: <20240827120805.13681-1-antonio@openvpn.net>
 <20240827120805.13681-13-antonio@openvpn.net>
 <20240906192926.GO2097826@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20240906192926.GO2097826@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/09/2024 21:29, Simon Horman wrote:
> On Tue, Aug 27, 2024 at 02:07:52PM +0200, Antonio Quartulli wrote:
>> This change implements encryption/decryption and
>> encapsulation/decapsulation of OpenVPN packets.
>>
>> Support for generic crypto state is added along with
>> a wrapper for the AEAD crypto kernel API.
>>
>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> 
> ...
> 
>> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> 
> ...
> 
>> @@ -54,39 +56,122 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
>>   		dev_sw_netstats_rx_add(peer->ovpn->dev, skb->len);
>>   }
>>   
>> -static void ovpn_decrypt_post(struct sk_buff *skb, int ret)
>> +void ovpn_decrypt_post(struct sk_buff *skb, int ret)
>>   {
>> -	struct ovpn_peer *peer = ovpn_skb_cb(skb)->peer;
>> +	struct ovpn_crypto_key_slot *ks = ovpn_skb_cb(skb)->ctx->ks;
>> +	struct ovpn_peer *peer = ovpn_skb_cb(skb)->ctx->peer;
>> +	__be16 proto;
>> +	__be32 *pid;
>>   
>> -	if (unlikely(ret < 0))
>> +	/* crypto is happening asyncronously. this function will be called
> 
> nit: asynchronously
> 
>       Flagged by checkpatch.pl --codespell

Thanks! I forgot to add the codespell flag to my last checkpatch run :-(
Will fix it in the next version.

Cheers,

> 
>> +	 * again later by the crypto callback with a proper return code
>> +	 */
>> +	if (unlikely(ret == -EINPROGRESS))
>> +		return;
> 
> ...

-- 
Antonio Quartulli
OpenVPN Inc.

