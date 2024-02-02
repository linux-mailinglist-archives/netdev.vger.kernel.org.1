Return-Path: <netdev+bounces-68573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995B284742E
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80D128DB25
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 16:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C1814A4E6;
	Fri,  2 Feb 2024 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ie1QxmsK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4D814A4D4
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889976; cv=none; b=CVF0pVkP5xZcvVh0pr6ZvZVLALPW2Nruz5Yu2iRpYr7+UE6r4b62/bKpk/M1+H4rdVt153azwuo47OIyGsQSCJ5KncxI+MCMAc8Wge8dm1VM1TL9MHeNaDf3AbPuvp6Vzf6AJNNinADnIDuCv8OxvAkgzi/coX23idfWlOuq0Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889976; c=relaxed/simple;
	bh=6PgOz8U7qU8GlqWPEa+8+IA1IKsxalufvNOR8HK5pSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYiV/oEOBkEhdF2rFB4UL9L/J0gJW1xy8AHpWu/bW57Svm7ZKRbiyXLLr8zA0Jh6+AcmIOR3Zk7neLuTDHK5W93rvZw4NtqtXT36jl7ABHfOB0OCKR1b0XlGkBiDU3SL092VTv5Req/gTEYqvxyGHrb95wW954ShwBXpnogPkhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ie1QxmsK; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56002e7118dso600854a12.0
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 08:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706889969; x=1707494769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UxN0j1YpyuhSwJ7YCVqg9cu7lcc/ZACNKaeGbenboMg=;
        b=Ie1QxmsKbPcPSRZHYhzGxOuUt+xXSNY9rJEgB/7IPBbQqlieAw5uok8KYZxlphla+E
         9uARS7yP6y1QjS6YOvGD+DapInqKoQGs2Tpz5YS6Dq1ZPdyXvcvMyBTum43QV0w0FyOV
         gahP6OwrNtXXyBZ9UMgHeBS1f5pxOpvz01JZoH2BDIrgVqV9r1DRvvp9VuUsHYyVYEQm
         puH94dlkWcfKIMR6Qf2N5PL1cAE1th1eXOYwkHgBOPaz+ftr+s601kAYq2+NUMR4Wpuu
         2G0ck+77qNMDdReKHvL0eAc/5hChPGGXkvThCmpn/e1FBz85Xgb/0hSYZ0cvOM/0ESdp
         u+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706889969; x=1707494769;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxN0j1YpyuhSwJ7YCVqg9cu7lcc/ZACNKaeGbenboMg=;
        b=X9hBknU5eQV7ICFX+8hWS3F0VoLY5Repm5+W06pFRWktDPevPEvdXc8+5w58NJYDry
         n8zk9+LzLMpeD5f3FSGXHuO5By+dwNEAFcEGIRRknXJL0l2y0Q6kqHNYpwl+MYbNoCQG
         BxRT+CIDVC3SPuBawBrmzx92LLLrR48+giTkhjkbk2Pq4QxIexGE0939oXr+RQy1K7/i
         oSbRJWKQ0wfQIRVNuFXTBmKsFjRIHqJ2Ul5KYsGykPLQYSSn0zdQb7Y9QfZoaAZRViYR
         yWrtvF/TXvmIS4eAwoF132b6Fx6l8NOJRsM5NTjCHcLEhbNocSpP0r3MAbtJbAMVKPJQ
         qVfQ==
X-Gm-Message-State: AOJu0Yx+7lcRGlR6QCu9gyz+oZL0zHqQuPZP8dfB6i7tGD8bHGujEzS3
	vmzNVCGbXmzRZEskqmSbqnk2AnPwtl/KoRtragKu9zqtDFBquPvnNLTSYc67
X-Google-Smtp-Source: AGHT+IGIIZYJvGdOPF28ywnhwG0myfKvS/vVAhN4oE1cGtqKUNOKP7x7HZYBVuPrpAwfniDHCy0BVg==
X-Received: by 2002:a05:6402:12c7:b0:55f:ac37:2cb8 with SMTP id k7-20020a05640212c700b0055fac372cb8mr89372edx.5.1706889968683;
        Fri, 02 Feb 2024 08:06:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXlbcgXuN8KA6c/JOa9qRZLhmQOANHcsRtOeJBKUAPZ/oWH3TCvConfATbF3FhERlAwJdorIYSemdFtEzu3fIcqLtxw2WCCbIn/ZV57kaLNNwOtSin1Z3MgMbmyndFtaE0NWbZ+PTPV8lsMF8NU+2k/TGst6Kc/sa8G3WVh265rpvVGvTdEY8yRZe5TkDeZt7Xl28ax
Received: from ?IPV6:2a01:c22:7392:d000:fd55:b299:8fa4:b649? (dynamic-2a01-0c22-7392-d000-fd55-b299-8fa4-b649.c22.pool.telefonica.de. [2a01:c22:7392:d000:fd55:b299:8fa4:b649])
        by smtp.googlemail.com with ESMTPSA id d13-20020a50fb0d000000b00557d839727esm911103edq.7.2024.02.02.08.06.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 08:06:08 -0800 (PST)
Message-ID: <7122d90b-cdfe-4733-bfad-45ce63f75536@gmail.com>
Date: Fri, 2 Feb 2024 17:06:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESUBMIT net-next] r8169: simplify EEE handling
To: Andrew Lunn <andrew@lunn.ch>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <27c336a8-ea47-483d-815b-02c45ae41da2@gmail.com>
 <d5d18109-e882-43cd-b0e5-a91ffffa7fed@lunn.ch>
 <be436811-af21-4c8e-9298-69706e6895df@gmail.com>
 <219c3309-e676-48e0-9a24-e03332b7b7b4@lunn.ch>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <219c3309-e676-48e0-9a24-e03332b7b7b4@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02.02.2024 14:12, Andrew Lunn wrote:
> On Fri, Feb 02, 2024 at 07:55:38AM +0100, Heiner Kallweit wrote:
>> On 02.02.2024 01:16, Andrew Lunn wrote:
>>>> @@ -5058,7 +5033,9 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
>>>>  	}
>>>>  
>>>>  	tp->phydev->mac_managed_pm = true;
>>>> -
>>>> +	if (rtl_supports_eee(tp))
>>>> +		linkmode_copy(tp->phydev->advertising_eee,
>>>> +			      tp->phydev->supported_eee);
>>>
>>> This looks odd. Does it mean something is missing on phylib?
>>>
>> Reason is that we treat "normal" advertising and EEE advertising differently
>> in phylib. See this code snippet from phy_probe().
>>
>>         phy_advertise_supported(phydev);
>>         /* Get PHY default EEE advertising modes and handle them as potentially
>>          * safe initial configuration.
>>          */
>>         err = genphy_c45_read_eee_adv(phydev, phydev->advertising_eee);
>>
>> For EEE we don't change the initial advertising to what's supported,
>> but preserve the EEE advertising at the time of phy probing.
>> So if I want to mimic the behavior of phy_advertise_supported() for EEE,
>> I have to populate advertising_eee in the driver.
> 
> So the device you are using is advertising less than what it supports?
> 
It may. If on a board with this chip version the BIOS for whatever reason
disabled EEE advertising, then users may complain that their system consumes
more power with r8169 than with r8125. Typical users don't necessarily
know that EEE exists and what it is, and how to enable it with ethtool.
Therefore I'd like to ensure that the supported EEE modes are also advertised.

>> Alternative would be to change phy_advertise_supported(), but this may
>> impact systems with PHY's with EEE flaws.
> 
> If i remember correctly, there was some worry enabling EEE by default
> could upset some low latency use cases, PTP accuracy etc. So lets
> leave it as it is. Maybe a helper would be useful
> phy_advertise_eee_all() with a comment about why it could be used.
> 
Yes, I think that's the way to go.
To minimize efforts I'd like to keep this patch here as it is, then I'll
add the helper and change this place in r8169 to use the new helper.

> 	Andrew
Heiner

