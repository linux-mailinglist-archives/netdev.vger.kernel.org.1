Return-Path: <netdev+bounces-73808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F036285E893
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 21:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73C491F28D6A
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 20:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0472E1332AC;
	Wed, 21 Feb 2024 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqSoZ2tI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20638132484
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 19:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708545034; cv=none; b=SS0oYrRaPItaTxXF6XV/+FCTeGKJ/fByB5hP8STtpjsOrDJ9N68fl/56v1Zpo5O0qSq0U5DouQBX08JnL3fcg4Py8mLkgtr1hWv+AA/Lud560jPTeVK0jkJfW4SpSPUDmlWe535y9A51PtFzCL6XOnCq6hW0+z5YqbqVNtWVPyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708545034; c=relaxed/simple;
	bh=YXdT7rI/CV3UjpF3BSY/kSfYZMWTIEEQqJLy8Q0vhjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GAI2x/nbSRbpLa5XwCeg+G5hcm+05ZPtwshKDGiAwaYWCQ9S0QIYRrw4jwv1M5HSzhPdsie7j7E8J+tFFsDIbVNs/N+YJXsDwC0Gbe3S1LL9yeDEHwJnpXkeqbhIW76YLcc5X7ebgnqBGizHIg1zrpccOWj6kkBK47bIgkaP2KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqSoZ2tI; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33d32f74833so743416f8f.3
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 11:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708545031; x=1709149831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fqD8rXum4zc96gb4Xl8ikwAvyqd7MGzIyTB1SvHCNfQ=;
        b=EqSoZ2tIwE2/d41sCMeYSBZBHyQrECXpZnQ0OcVvXpJ+L6EPHHgAutYw3TZwWLO8kW
         jq88du5bX0Rmr4vWSTx1KiElkYfxpwa8f9ONEG7dOZLjk+qnli2+WjLX+X5DjgRj4s1/
         LsrMCOkn6gXnJoP4HbxON5JfhgX45A/A0Qdo7VMN22RvVRZE8CL7JpEiof0Ih7fHWX4j
         CjERGKrm7SUEotbBLkQiGrHb2KB1z1KSCn0x2YAMMR23sVIJizXfxSHNLV+lqSo72Yr1
         dAonDxOhHxUYYBlZBfLdhwpimyyygq/YM5PihBquE9tH+Kk1SMxbi+t7dnAuH6n7rKED
         An3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708545031; x=1709149831;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fqD8rXum4zc96gb4Xl8ikwAvyqd7MGzIyTB1SvHCNfQ=;
        b=LypBmExJn4+6MYqqy3QHfAVwECTk2H2B4Wq05afQh6l+D6JQMqGQobgYq/YlaJtiq2
         +N0cZ7xhIe3f/Nc0f9m1lENXzI2P7rcgi9nAIwOdQXGGZIcS4CFNlTKL5PlUAo2EIpKh
         S8yBcBAIdHMlKC9U/IWyE44sLX9RGcFQkYHrPH8hdnQ6cLVrTZIolBhXT3UYr0ROMM/f
         vZXfygjUZUcDY7O7YbPX7q1Yd99dFPbE+Wjp0rQHw4glc3vXxf2tAaVKrTyOgoZ+Rnon
         W3WEXOWmZO78yE12s/XmVGcXmojQK/nbu5T0azJUU0WVtOvZfnfxec5yRUrbvCAV6Hlz
         3e/w==
X-Forwarded-Encrypted: i=1; AJvYcCXXWOot3oXFb/Z55a8s92SJDGfUov33JxkOux9tTNlt3C0CiYAQXrtzzT3FxQ2q7Vc7MA1gFX1KgrK/QITyW6SQBKRQJ+8x
X-Gm-Message-State: AOJu0YwK3nC/wzUGLv4PHoNnbce2ZzTxvWdcN1IK4FZm7UkfR+npgqDC
	xc4s7GUVNylyBmBYmCGQ3UKNB8g7r+uz3xbq785MaFKHQfw81BrUnKi2AmHt
X-Google-Smtp-Source: AGHT+IGx45rZBCPGgKHr4zU0Dyh7lhq8KOMT5SmZgSX/oAASpQCwwkqClNAzbtGnGwRcT5Jf98LFdg==
X-Received: by 2002:adf:e989:0:b0:33d:817e:2c7f with SMTP id h9-20020adfe989000000b0033d817e2c7fmr1629245wrm.41.1708545031097;
        Wed, 21 Feb 2024 11:50:31 -0800 (PST)
Received: from ?IPV6:2a01:c22:6e67:5300:9dc5:383f:2ded:f0d5? (dynamic-2a01-0c22-6e67-5300-9dc5-383f-2ded-f0d5.c22.pool.telefonica.de. [2a01:c22:6e67:5300:9dc5:383f:2ded:f0d5])
        by smtp.googlemail.com with ESMTPSA id az19-20020adfe193000000b0033d6ff7f9edsm6605409wrb.95.2024.02.21.11.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 11:50:30 -0800 (PST)
Message-ID: <6af89ba8-e1bf-4609-8e67-4e9fecf1193a@gmail.com>
Date: Wed, 21 Feb 2024 20:50:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ethtool: ignore unused/unreliable fields in
 set_eee op
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <4806ef46-a162-4782-8c15-17e12ad88de7@gmail.com>
 <7472bddc-86ad-45fb-8337-4ee21ea7a941@lunn.ch>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <7472bddc-86ad-45fb-8337-4ee21ea7a941@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.02.2024 16:41, Andrew Lunn wrote:
> On Wed, Feb 21, 2024 at 08:24:40AM +0100, Heiner Kallweit wrote:
>> This function is used with the set_eee() ethtool operation. Certain
>> fields of struct ethtool_keee() are relevant only for the get_eee()
>> operation. In addition, in case of the ioctl interface, we have no
>> guarantee that userspace sends sane values in struct ethtool_eee.
>> Therefore explicitly ignore all fields not needed for set_eee().
>> This protects from drivers trying to use unchecked and unreliable
>> data, relying on specific userspace behavior.
>>
>> Note: Such unsafe driver behavior has been found and fixed in the
>> tg3 driver.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  net/ethtool/ioctl.c | 7 -------
>>  1 file changed, 7 deletions(-)
>>
>> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
>> index 1763e8b69..ff28c113b 100644
>> --- a/net/ethtool/ioctl.c
>> +++ b/net/ethtool/ioctl.c
>> @@ -1513,20 +1513,13 @@ static void eee_to_keee(struct ethtool_keee *keee,
>>  {
>>  	memset(keee, 0, sizeof(*keee));
>>  
>> -	keee->supported_u32 = eee->supported;
>>  	keee->advertised_u32 = eee->advertised;
>> -	keee->lp_advertised_u32 = eee->lp_advertised;
> 
> This overlaps with the last patch in my series, which removes all the
> _u32 members from keee. They are no longer used at the end of my
> series. I added this removal patch because i kept missing a _u32, and
> i wanted the compiler to tell me.
> 
Ah, didn't see this. Then I'll wait for your series to be applied,
afterwards will check whether parts of my patch are still applicable.

> 	Andrew

Heiner

