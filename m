Return-Path: <netdev+bounces-248492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 119ACD0A147
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 13:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B57A430D4E6B
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 12:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9A535B137;
	Fri,  9 Jan 2026 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="hqAwRBW1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D841DF72C
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962444; cv=none; b=afW7vMrs8vVItVQXWoxxG8aSmsUmtUuy0FPOhJJ8A8JPE7KzVQSleJbpWYGNwQQh1i+vXABzxld6ncUJDBCBnvelDqqOfYfs0il4XXAJCCrJOaP6dHTDGUPWeoMq2R7MB78GPqd6nZfoqBxdxr3hX37w0WP8svQLyfX4rvyU0nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962444; c=relaxed/simple;
	bh=nfqPrA3vvRkG6Tmb3LIiS7KgpHc+6H/TE8anC3X9D5A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PmSinsSOfJIFwhp9sM9erP9XEkUi77P+EbS2/E+GmMDfBF/oRkVOI8CS7jPGMxcm/WgKO2fIwF1RNYpN9iZVO+9sHSVT74uJPxq1Ge8di39KKBvyxBAeFg9lpxicf9uXeAlnYc/oNQvgPCzN2nepJgR3DCoI7LI9mpHCRBl/hTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=hqAwRBW1; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8427c74ef3so640033266b.2
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 04:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1767962441; x=1768567241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XmbzNcIB7zmVJRvzuFkngXTnhqTy/rGzx/z/GUGBVgA=;
        b=hqAwRBW1M6kOoxm4WcrZycmTbOfa6KKz6R1+D/NIE7kJDohPlAcuLItLnihO+RG76R
         3AVV6bBv19AxSvMrhwXfRx2k3/PjVitApb6OKg8htmX05qfEiPShLInQbghtsGNn8LWo
         NKacD4rWK0753o/MMgu0yLiaY0padX//tcirglBJx3ofjhCHq8tc3WwZ1AvSGNaxzfwy
         Ke0ZRahtgIW+h0dvx8KfUDO6Aoq67fibTTg1+QqTmMubZ134I+1W3+9ZNbEYRMzheMjC
         cnV+UltbqcgBZR6CYH2SqwtGAno184+dk5s/NVzYGIl+EVoDNZmcOkO9H2NMHslH8Fac
         Xmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767962441; x=1768567241;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XmbzNcIB7zmVJRvzuFkngXTnhqTy/rGzx/z/GUGBVgA=;
        b=IzaeR66x+Er5R5ECPHUY+enT/BKb6ug6lAWyqumeaYegIebPpOJCbNbXvX9h2+QiQ7
         p4TaMLkLgiL9bbXhfmYrPVzySgKibztfYg6yNGk76c3Xv6n2wRx449R7RWMvrx8Dmr4X
         TEgdFV4JfDsMMiKp7zEJK60oPkVhexJDXJKPqVgAfNBUCf0qkPVvkUmvS+CSyM7VmwsQ
         72v+BLAM57Zox1AHLZTHLrvjnj9ERDZS/6sOMcPyLL3GyVgCkMSlRj4L8Su5lrfKBuS6
         uON4BwzpF/Gkes95FDKVhBMlPpMxo5tBxfah3HatsZdnk/DKnW6RHmXZPA6xylENVOiz
         sTqA==
X-Forwarded-Encrypted: i=1; AJvYcCWFEZhnQ5OVE9XVpwyNhp+60iS2BBTMLCMzBwcWv2ogsec/2706X4mumo20S2t7t7PAlYV3rME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/CQrFp+xTT0TTGsdMOLvO20jDz/WL8UbhgFimE5RKm3Fz+mVq
	VYY7i2X4NaxfoMG0Ndj7WaXj1dLBWK5AQjvp+pzvA3/GZveb/tSg6EhnOf8ubkjk7do=
X-Gm-Gg: AY/fxX4eHXEKO8RjENAe9rlTGpPGfNoQrLCpl7VeaYgJCl9yMc2lXwRbs7bQmRMIhbs
	foFw3NN3NjoPX+3R6FYh5cwyl+VMw41dPXO1dQJcYoZFye+Sh0y4GYWpf47s/RG8TdXLkQ6Rt/k
	btLSkbuYUVIPsYXURuiP1TsKmOgXw8Q99mIolZFp6h3ugr9HdqY3XZPKurPQ6d7tv2nErmEWam/
	qpHgmOsFPTZpnWvI4CU5n9FDA6JxehMok7ZsFYTmqrXkMCvtb8ViWIjKAqFz/zmDA6X9DG/lhIH
	rNF+ri/miUKdf4I80ZBNZ4Hs4fq02AL49NNg5VqznnwNpaKOmgPKKHcYTkUkEL5eckbXQt4jVzY
	mn+y23LfmN2Wzn+3IXpIC0UjO8shFNq/SlyUjcp/ESKkO+0YPPoShvCv5ornrjLeKvG7knryIro
	9fDwxRHkQzaqwzHKIDCZdArYmp7WC2y5Z7NF36rZxwj3guWBawC0vyi9ekJQLu6rRmBHEJbA==
X-Google-Smtp-Source: AGHT+IHVhyzPTaDfm/HfRVhOtp5M0BEzqsLqNW+VhIRiyeoVJC8KY5ryR4B7ChzWKucvVAe+aHW94w==
X-Received: by 2002:a17:907:841:b0:b84:40d3:43e7 with SMTP id a640c23a62f3a-b844502c5abmr788464466b.6.1767962441235;
        Fri, 09 Jan 2026 04:40:41 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a2340a2sm1121332166b.5.2026.01.09.04.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 04:40:40 -0800 (PST)
Message-ID: <0b999b82-e39e-43d8-b224-d660de1c21d9@blackwall.org>
Date: Fri, 9 Jan 2026 14:40:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next v2 2/5] net: thunderbolt: Allow changing
 MTU of the device
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>, netdev@vger.kernel.org
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>, Ian MacDonald
 <ian@netstatz.com>, Salvatore Bonaccorso <carnil@debian.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jay Vosburgh <jv@jvosburgh.net>, Simon Horman <horms@kernel.org>
References: <20260109122606.3586895-1-mika.westerberg@linux.intel.com>
 <20260109122606.3586895-3-mika.westerberg@linux.intel.com>
 <b070f4f6-e81b-4674-954b-609ad17f1cda@blackwall.org>
Content-Language: en-US
In-Reply-To: <b070f4f6-e81b-4674-954b-609ad17f1cda@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/01/2026 14:35, Nikolay Aleksandrov wrote:
> On 09/01/2026 14:26, Mika Westerberg wrote:
>> In some cases it is useful to be able to use different MTU than the
>> default one. Especially when dealing against non-Linux networking stack.
>> For this reason add possibility to change the MTU of the device.
>>
>> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> ---
>>   drivers/net/thunderbolt/main.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/ 
>> main.c
>> index 57b226afeb84..20bac55a3e20 100644
>> --- a/drivers/net/thunderbolt/main.c
>> +++ b/drivers/net/thunderbolt/main.c
>> @@ -1257,12 +1257,23 @@ static void tbnet_get_stats64(struct 
>> net_device *dev,
>>       stats->rx_missed_errors = net->stats.rx_missed_errors;
>>   }
>> +static int tbnet_change_mtu(struct net_device *dev, int new_mtu)
>> +{
>> +    /* Keep the MTU within supported range */
>> +    if (new_mtu < 68 || new_mtu > (TBNET_MAX_MTU - ETH_HLEN))
>> +        return -EINVAL;
>> +
>> +    dev->mtu = new_mtu;
>> +    return 0;
>> +}
>> +
>>   static const struct net_device_ops tbnet_netdev_ops = {
>>       .ndo_open = tbnet_open,
>>       .ndo_stop = tbnet_stop,
>>       .ndo_start_xmit = tbnet_start_xmit,
>>       .ndo_set_mac_address = eth_mac_addr,
>>       .ndo_get_stats64 = tbnet_get_stats64,
>> +    .ndo_change_mtu    = tbnet_change_mtu,
>>   };
>>   static void tbnet_generate_mac(struct net_device *dev)
> 
> You can use struct net_device's min/max_mtu instead of a custom 
> ndo_change_mtu.
> They will be validated by dev_validate_mtu().
> 
> Cheers,
>   Nik
> 
> 

In fact it seems they're already set in tbnet_probe(), so you can drop
this patch altogether.

