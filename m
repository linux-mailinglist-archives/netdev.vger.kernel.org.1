Return-Path: <netdev+bounces-183866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82310A92438
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 19:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89550169F55
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8D12561BD;
	Thu, 17 Apr 2025 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YSM4B2c5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524002550DC
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744911631; cv=none; b=cRNYI15pcLxRM9NT35LG6nR14mD1Nsy9kswrSKwGrn0IpcyLIx+iMo6/hglGaZ3fbjdlnd2ZRi+wILIcR/BbseqAVmhk6iwAEUrRUj9g0+hvcdgsXQf+Okw8XcqiaZ0gQTHm4+l6eNXBJn5/QMOshwEm8gvbckq/pGj3BPOZ7yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744911631; c=relaxed/simple;
	bh=EOInJqz3SSsR3SfMgfEaE59yxaDfxa8aYfQqn0AbCls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hE5yu3IdnKS0LF1/jVs2JuPJzzCRBqEd/OIDncNjqq5FITqLpfTXxNT3WetNlkspn6P7Rzbm7j4DK80XWDCNZ5Rtl5VssA0R1aYSRinfgG20NWobGah8G30/RwTJPmi1H1GLjiDrGokd5QgU+RCLVQFaWfVcIpxcDf6fMXlvvp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YSM4B2c5; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224341bbc1dso12860535ad.3
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 10:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744911629; x=1745516429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dDBg6maTTzuwRDGp8PFv9HLN1q5K7jSth9S5/3WTU6I=;
        b=YSM4B2c5M3jCwqJtQDAIuTCki7wWCaedPn6hzGViSc62JPcS4GG1B3MF4iYJtEigTe
         wuNKJY8nzffq0kRW0rO+7+UBrU1hbjNhbsGL9Q1Ld6HWlKItJjHCIlNQPv7DNVazov8F
         OdT+pzfj9xUF/owXecVXceuomGlBGSvlZ1lKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744911629; x=1745516429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dDBg6maTTzuwRDGp8PFv9HLN1q5K7jSth9S5/3WTU6I=;
        b=Mz3A6ytMOwRIIzGdx6m6ORRLBe7d727OUjc7VzPWNMG0zoOF13Q4rDh6/+fzfbS5gf
         hzqNZA+OYzZa7avhKaybTCAapl3ThMIRgTUBiZx1GTZdfnrkRVIEqnxES2p9fhQGC3Qm
         yFZWgkTD2xGfu4ndwUQCtcUVVt3d5RXV14nC3SgKX0Q9Iu0bb2CPPEn9sXjVlg5JQ8Og
         Qa7Z12gPQxvMdgRvD12PdUII0lS5+L8ynYhRptKisaSjkgg9Jw+u34UbIPC4ykMFkTE/
         k68VsauXoRID4lW1RDWK6ZxebkjTQGPVwFgBjsq6rHLRePDLYvYzR9zUfUX8Z3PP1q8W
         n5Hg==
X-Forwarded-Encrypted: i=1; AJvYcCU3A8kBGZqCE79a/aizFquVFUD/9q83hmqJAbuTHnkK3JhF7ROmXZ/NGNtOaibw+wqP6JvVDJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEpAJE1+kb/mYW1clYHJexRMOEhpKVX9sQRIBm6r2zbzl4AEkX
	JsWI37R/LxThDY5QH7jVsnZjfWoa8kRxEXUxuxzp12AIkQ0HA2AGi+TQ3GPSMw==
X-Gm-Gg: ASbGncvb6bgfwPkvyHb/cP2L5FdgG6jYrhX+j1qbk24sU/oTUNEnGX9G4YEYQuYD2pO
	Xm+7IhjPkpvGgm5JLHSgUNrBRYeeV3xwvegT+O8SEo+DUVclyoX7mztfNqbhGNYE3a8V8SUzd3D
	Y5Uk3zJ4QamhyF76NLsMxvCosXXlfKS3IchPajJ8rmrrZySB5d+2PHy7Gfg3EtEUNzIW86zYmZ1
	At0Ef9tpv8CNHCLQFY3EH5CP0Ur34cRxvtg20wPFBLhmtBNSba4m+38bdBo4V0MfJ0GZlUwvNHz
	/41y3f+jxv9m0ugSlb4SLNxr7QxO2oRp/XabP14AYoo8qEj7ASfY6VJRPNwbcj2QHg==
X-Google-Smtp-Source: AGHT+IEUB11sMEKCeB/nFn18cuVrgDnNw9IUYOxedNt+pJ4FJpOjy0YKf25iRAJd2NfgsM5n6/ngmA==
X-Received: by 2002:a17:902:dac2:b0:21f:4c8b:c4de with SMTP id d9443c01a7336-22c3596dbe6mr88220975ad.42.1744911629482;
        Thu, 17 Apr 2025 10:40:29 -0700 (PDT)
Received: from [192.168.68.71] ([136.52.67.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bdaad1sm2911915ad.28.2025.04.17.10.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 10:40:29 -0700 (PDT)
Message-ID: <ea48b90d-d01c-46b2-af4d-4c7bdf340f80@broadcom.com>
Date: Thu, 17 Apr 2025 10:40:27 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] dt-bindings: net: brcm,asp-v2.0: Add v3.0
 and remove v2.0
To: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: rafal@milecki.pl, linux@armlinux.org.uk, hkallweit1@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, opendmb@gmail.com,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, florian.fainelli@broadcom.com
References: <20250416224815.2863862-1-justin.chen@broadcom.com>
 <20250416224815.2863862-2-justin.chen@broadcom.com>
 <0b30168d-6969-4385-b184-c2fa69c82390@kernel.org>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <0b30168d-6969-4385-b184-c2fa69c82390@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/16/2025 10:52 PM, Krzysztof Kozlowski wrote:
> On 17/04/2025 00:48, Justin Chen wrote:
>> Add asp-v3.0 support. v3.0 is a major revision that reduces
>> the feature set for cost savings. We have a reduced amount of
>> channels and network filters.
>>
>> Remove asp-v2.0 which was only supported on one SoC that never
>> saw the light of day.
> 
> 
> That's independent commit with its own justification.
> 

Acked

>>
>> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
>> ---
>>   .../bindings/net/brcm,asp-v2.0.yaml           | 19 +++++++++----------
>>   1 file changed, 9 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml b/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
>> index 660e2ca42daf..21a7f70d220f 100644
>> --- a/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
>> +++ b/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
>> @@ -4,7 +4,7 @@
>>   $id: http://devicetree.org/schemas/net/brcm,asp-v2.0.yaml#
>>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>>   
>> -title: Broadcom ASP 2.0 Ethernet controller
>> +title: Broadcom ASP Ethernet controller
>>   
>>   maintainers:
>>     - Justin Chen <justin.chen@broadcom.com>
>> @@ -15,6 +15,10 @@ description: Broadcom Ethernet controller first introduced with 72165
>>   properties:
>>     compatible:
>>       oneOf:
>> +      - items:
>> +          - enum:
>> +              - brcm,bcm74110-asp
>> +          - const: brcm,asp-v3.0
>>         - items:
>>             - enum:
>>                 - brcm,bcm74165b0-asp
>> @@ -23,10 +27,6 @@ properties:
>>             - enum:
>>                 - brcm,bcm74165-asp
>>             - const: brcm,asp-v2.1
>> -      - items:
>> -          - enum:
>> -              - brcm,bcm72165-asp
>> -          - const: brcm,asp-v2.0
>>   
>>     "#address-cells":
>>       const: 1
>> @@ -42,8 +42,7 @@ properties:
>>       minItems: 1
>>       items:
>>         - description: RX/TX interrupt
>> -      - description: Port 0 Wake-on-LAN
>> -      - description: Port 1 Wake-on-LAN
>> +      - description: Wake-on-LAN interrupt
> 
> Why all devices now have different interrupts?
> 

With ASP 2.0 removed, all SoCs will have 2 interrupts now. I need to 
remove minItems here.

Thanks for the review,
Justin

> Best regards,
> Krzysztof


