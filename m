Return-Path: <netdev+bounces-87896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDE78A4E27
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0395EB21197
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 11:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33BB5FBA3;
	Mon, 15 Apr 2024 11:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2rFr9hW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D5D66B5E
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 11:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713182096; cv=none; b=clbmW652GyeBwyUt7oZDppgToz/e5fHtHaev1DWzWsBKk/oItTBb7ZEq+9HaDtWnh7V2I7/y4WPAVsrBN/PeiVsICqMlRzwyAqLkMbez7q7+8m+k80Byr4oFe3ClN3qXxoxpm2oLbkT9aUPzRViHvJ1eElKo+egA6l1ifo9+gX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713182096; c=relaxed/simple;
	bh=nmTq1IazWH0ggpIPNgor9AcBEtE+UG49sIOyfm6Pv+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s516oAfgv0blz59GXrxUmMwX5163UyRqhRuneP3eMSGqkemGR2WOo38fwvQkLn3qDpe9c848QuAtWGgsTvwIkAw5SwtkwcX2DY7lFaJeeqKseml1z6ZSL2VdcwBG1JjLOYJiFxWBnhFSxczjmzuYbVQHeOqOleielJB2Mzf6fhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2rFr9hW; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so4969631a12.2
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 04:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713182093; x=1713786893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ifYOYwSOdGb3z3KqeSqQGutlC3a305b6oeNhEXrjZuU=;
        b=e2rFr9hWdj0g3q9TVGxRdLKxTLiF1ssHZncb97XZK6o+edwqdntehJqeO23V+DK9GW
         LesUj39vGHD3ylJC67rItq/TGtOPLeW8Q95lv4pdJBpvLrk2WNydPzUiYf55jhpzXQMQ
         8i0aleLhls2oqZfYtnCdAKoD9Ts8ER5/xBV0alCmH3FFECFsB39NEPXze2snz5m3bUDZ
         VBLEyZVoKfaBfCTxDJ+2526GSgbbX1ZVV7W4//Ib1dqBg6YMBm2T3Tz1d/xX5MBFzmjy
         OtyFsSTG3BCaWOfqs6PgCTWsestJa4QRp9F+b9p9cNWaae6lpgFAyTZjVQQRwx4UQKaA
         SN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713182093; x=1713786893;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifYOYwSOdGb3z3KqeSqQGutlC3a305b6oeNhEXrjZuU=;
        b=HP9lbawomIAM/IeuKkWC7hq7sj0OikN6ps94SLlmVItRl2S2aLgJqF7OxQ4kDaTaz0
         mlH1TgSsyL6wRZP+X4c9+Q+LlJYWK4V4q7cOQTWKXziZZCkpwyRRuynaMf6xY4m1/KNG
         hKlyq/i9xB5baZ8HwqmD/8wg/wjST0qLNI2j0NJtYg3m6UJbaNSYqFV+JBgY5qgVbJGD
         WipeE+7qXQBH1DNem1qYNQsuEhlSzv4dzAKzoBPcXExkWQJGIMb+Nohp5BbUh4RZutBw
         8VkYbexEO5n8o5SFB43HFcpInvYrb2u535WmsF8wz54kV0xj4caskq6sYF9bKF0GTwDP
         L07Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOnW4D5qAiboKcb7HxUH0TmbYg9UhNBVhLVu9jNsbHl2TDPqt9Jd13crKEhcs65gjxBx1XQjuN9hww0W0btzy47fs3lXvj
X-Gm-Message-State: AOJu0YyzLgQfViFzQseiGbm3dbf3cc9TTL1N8GYKyuBHjw5+U/DeD/w+
	bg2xfxxdCW2EmlxgrG10j4qYucimMOyZke4B1qvqnfjUrHhef4Nrduyq2A==
X-Google-Smtp-Source: AGHT+IH2DkBJWWOlkU8b6r039H3yJ6RmX5s+iMASKfPlA2IeKl911Bvr1mjjgTP4qk5Gig5sHFO4iA==
X-Received: by 2002:a50:a41d:0:b0:568:9d31:2a75 with SMTP id u29-20020a50a41d000000b005689d312a75mr8021764edb.4.1713182093321;
        Mon, 15 Apr 2024 04:54:53 -0700 (PDT)
Received: from ?IPV6:2a01:c22:6fba:a100:9cae:aacf:9cd8:e36e? (dynamic-2a01-0c22-6fba-a100-9cae-aacf-9cd8-e36e.c22.pool.telefonica.de. [2a01:c22:6fba:a100:9cae:aacf:9cd8:e36e])
        by smtp.googlemail.com with ESMTPSA id dc3-20020a056402310300b0056e672573e5sm4791240edb.88.2024.04.15.04.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 04:54:52 -0700 (PDT)
Message-ID: <bb0b2488-d5f7-4530-ad30-06b30f064fa7@gmail.com>
Date: Mon, 15 Apr 2024 13:54:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] r8169: fix LED-related deadlock on module removal
To: Lukas Wunner <lukas@wunner.de>
Cc: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <6b6b07f5-250c-415e-bdc4-bd08ac69b24d@gmail.com>
 <ZhzqB9_xvEKSkMB7@wunner.de>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <ZhzqB9_xvEKSkMB7@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.04.2024 10:49, Lukas Wunner wrote:
> On Mon, Apr 15, 2024 at 08:44:35AM +0200, Heiner Kallweit wrote:
>> Binding devm_led_classdev_register() to the netdev is problematic
>> because on module removal we get a RTNL-related deadlock.
> 
> More precisely the issue is triggered on driver unbind.
> 
> Module unload as well as device unplug imply driver unbinding.
> 
> 
>> The original change was introduced with 6.8, 6.9 added support for
>> LEDs on RTL8125. Therefore the first version of the fix applied on
>> 6.9-rc only. This is the modified version for 6.8.
> 
> I guess the recipient of this patch should have been the stable
> maintainers then, not netdev maintainers.
> 
OK, seems this has changed over time. Following still mentioned
that netdev is special.
https://www.kernel.org/doc/html/v4.19/process/stable-kernel-rules.html

> 
>> --- a/drivers/net/ethernet/realtek/r8169.h
>> +++ b/drivers/net/ethernet/realtek/r8169.h
>> @@ -72,6 +72,7 @@ enum mac_version {
>>  };
>>  
>>  struct rtl8169_private;
>> +struct r8169_led_classdev;
> 
> Normally these forward declarations are not needed if you're just
> referencing the struct name in a pointer.  Usage of the struct name
> in a pointer implies a forward declaration.
> 
Even if technically not needed, it seems to be kernel best practice
to use forward declarations, see e.g. device.h.
However I'd be interested in hearing the maintainers position to
consider this with the next submissions.

> 
>> +struct r8169_led_classdev *rtl8168_init_leds(struct net_device *ndev)
>>  {
>> -	/* bind resource mgmt to netdev */
>> -	struct device *dev = &ndev->dev;
>>  	struct r8169_led_classdev *leds;
>>  	int i;
>>  
>> -	leds = devm_kcalloc(dev, RTL8168_NUM_LEDS, sizeof(*leds), GFP_KERNEL);
>> +	leds = kcalloc(RTL8168_NUM_LEDS + 1, sizeof(*leds), GFP_KERNEL);
>>  	if (!leds)
>> -		return;
>> +		return NULL;
>>  
>>  	for (i = 0; i < RTL8168_NUM_LEDS; i++)
>>  		rtl8168_setup_ldev(leds + i, ndev, i);
>> +
>> +	return leds;
>> +}
> 
> If registration of some LEDs fails, you seem to continue driver binding.
> So the leds allocation may stick around even if it's not used at all.
> Not a big deal, but not super pretty either.
> 
> Thanks,
> 
> Lukas
> 


