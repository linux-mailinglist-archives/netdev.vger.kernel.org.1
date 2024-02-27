Return-Path: <netdev+bounces-75196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E21B868965
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 07:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE1811F27564
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 06:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09EE537FC;
	Tue, 27 Feb 2024 06:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rdYD1A5Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC22D54656
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 06:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709016931; cv=none; b=K28wAUt6Su9txR2iO2H9SF7hbH+UpUt18Kcic7U0/bVFngHytTYvWI9wGyY2mzijo6FnHkewX4bUJOm5torv/UPvEng3HxJqUXQJEk9sFWR3vOHfDBE412d2Xb+ZPNgU9o3tm4fh2cTDSh53KgDGJI9Ol32RaQd68T1LEaW0W9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709016931; c=relaxed/simple;
	bh=stDsqiTeTO9ZAv923ZYDVJq0DbjgBnDtats1p53igfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLMOnOSYBfd1+H102CHwYiP00djaY0RK288uHEYmMjnrlXwrQc2+haPdPScVf6oPa6GyWe84Id6ihfu73vwGjOpL16zMWa6IjMlVydRwaSgl5lgLbJx46Q4ZNg3SmHI4xW4wqRJHqMhTeJ+O8IaSJkm/2FbhefA3K/1yqV060qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rdYD1A5Y; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-563f675be29so4073360a12.0
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 22:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709016928; x=1709621728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p5LMWifGYvAVa7FBn8fs5JS5BqiF3tT1rVBI+M0zqeo=;
        b=rdYD1A5YCFa5oZJ8GK+7NN4eha6Y/U2PjtWOGGfTtl4fkZSGHMROUf6C2bdicYQYwG
         uE13Wlsrh7I3wp32JBbk60nqSl3T88Fl+TA8gy0QR0JAHwcReGD+zGU5N3nhNDkgm6lx
         sBIXo4H6wRcbSuY3MgLQ1PAvJsIHguBQVBgc7FxUa/TsLj60a1UxVkbyZ5MnJzt+lTMw
         TIu9z68OXb1whPzC6viZYr/FB2Xk4Zl4QQd8YTOUxMwzAPB2RKmP6hmlx4Bzvv+dzzX/
         yubCo0aD20WeTTLE263D0LkkNOy9y780ULQEbwnjLkquP8OJmgRweNooSZTBZbh9ys8x
         vgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709016928; x=1709621728;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p5LMWifGYvAVa7FBn8fs5JS5BqiF3tT1rVBI+M0zqeo=;
        b=m2S5TlzdTuCZMUh9yvAZFCLN0bGchDIHJbgS0k/xi1mA5wcAWhMLbfuUKAQMyv99jG
         gpEzlAmz3695Hv7oG/kb5gpieeSO/m/ISfFmv18FoJEocaBCtIiZf8mx27NuV7pYuu4m
         6eZkKdcTPjcF7KlC9rlPAwxqMNb26gAPqc/PTvv2bYarIDBFVliN8cgvKmcb0Z9704p3
         KoruR4MxJJZM7igZjb8luNtiyVB2snRmzu4kORhfJK9SK8nnxRTTbR27TutkaWfIAdID
         c5Yo1MrivYnUkgLjdXbrMgZjoDHT/dBlkvXHMqN/mTl+2RXIlUOzNaSzLd8sn2vPX2a1
         vkyw==
X-Forwarded-Encrypted: i=1; AJvYcCWQlYqptk9XZixPWw0/3TeFY3UD9K1ABhE6KKvd1K9HbmH5NtZxIkKh+XJmLxHF7fGvnpUWn9OjmCblZjFA7arpQJvy8LWW
X-Gm-Message-State: AOJu0Yx9dOYYxzYHd8eNQmU+7KsVBd31hgxCigL7TJ3O9xHkSSTDUcMN
	eP3eFuzN9+Ejb0x8bouETOB8PYOTS+IObKcF0OpuCLUkEUjR+AUmEhopWzqBOHM=
X-Google-Smtp-Source: AGHT+IH7fPPNkLtZSScRegvw5/EYLfraKgmuUkavdIt5xx0O9asNd1SRe94aOWu7KBPB6Y1PWdhxKA==
X-Received: by 2002:a17:906:4a14:b0:a3f:2b6f:6d57 with SMTP id w20-20020a1709064a1400b00a3f2b6f6d57mr4804221eju.29.1709016928096;
        Mon, 26 Feb 2024 22:55:28 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id h5-20020a1709063c0500b00a432f3bc3a5sm461205ejg.76.2024.02.26.22.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 22:55:27 -0800 (PST)
Message-ID: <c0e9eb68-f485-40a9-b025-82a73af06006@linaro.org>
Date: Tue, 27 Feb 2024 07:55:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next resend 2/6] dt-bindings: net: brcm,asp-v2.0: Add
 asp-v2.2
Content-Language: en-US
To: Justin Chen <justin.chen@broadcom.com>, netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com, florian.fainelli@broadcom.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, opendmb@gmail.com, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, rafal@milecki.pl,
 devicetree@vger.kernel.org
References: <20240223222434.590191-1-justin.chen@broadcom.com>
 <20240223222434.590191-3-justin.chen@broadcom.com>
 <b9164eae-69e2-44f3-8deb-e3a5180e459c@linaro.org>
 <b6c74bbe-89f0-4201-b968-57996f0e0223@broadcom.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <b6c74bbe-89f0-4201-b968-57996f0e0223@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/02/2024 20:42, Justin Chen wrote:
> 
> 
> On 2/24/24 2:22 AM, Krzysztof Kozlowski wrote:
>> On 23/02/2024 23:24, Justin Chen wrote:
>>> Add support for ASP 2.2.
>>>
>>> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
>>> ---
>>>   Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml b/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
>>> index 75d8138298fb..5a345f03de17 100644
>>> --- a/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
>>> +++ b/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
>>> @@ -15,6 +15,10 @@ description: Broadcom Ethernet controller first introduced with 72165
>>>   properties:
>>>     compatible:
>>>       oneOf:
>>> +      - items:
>>> +          - enum:
>>> +              - brcm,bcm74165-asp
>>> +          - const: brcm,asp-v2.2
>>>         - items:
>>>             - enum:
>>>                 - brcm,bcm74165-asp
>>
>> Hm, this confuses me: why do you have same SoC with three different
>> versions of the same block?
>>
> 
> bcm72165 -> asp-v2.0
> bcm74165 -> asp-v2.1
> Are two different SoCs.

Ah, right, existing bindings has two SoCs.

> 
> The entry I just added is
> bcm74165 -> asp-v2.2
> This is a SoC minor revision. Maybe it should bcm74165b0-asp instead? 
> Not sure what the protocol is.

So still the confusion - same SoC with different IP blocks. That's
totally opposite of what we expect: same version of IP block used in
multiple SoCs.



Best regards,
Krzysztof


