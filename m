Return-Path: <netdev+bounces-100965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD93B8FCAD6
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECA1EB211B6
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD40314D435;
	Wed,  5 Jun 2024 11:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lzWoH8t4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EC5144D0D
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587998; cv=none; b=rTvIEvEPWTNKDCwaFwAzzBF9f6VgivvbGJM0uZ3Ps38dWcEt0q8tN77XxBycarVxalIb/i+XqunvER+bWKVhSdjAzRqzQtvaHpkKs11+G+Am4uqAxEMJMYqVis3R2exQW/9T7kxXaKLCw/OOfRlW4Oxwng+9fpUSsOgbDHkEjOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587998; c=relaxed/simple;
	bh=8q8H08zhQ3wU3LBZhUOQGWRIEa/7PVTzUZ9hdcm7i5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1F0qHmzuKWcMFV6wjWEkno4WF7yakGKu7EJ3/yk1004dHmMcskYUMy5a0poLab3rceWNCiQ1PrTGFhpRVOK+0NTq7wgv8DQyegeeUeK4uw9W862xbu83BxjY11CpH93yaUwd6/sjAaw3UjJlctwo3tNACwd1lU/bn4meuhvQIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lzWoH8t4; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4214aa43a66so18093585e9.1
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 04:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717587995; x=1718192795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yD9yrm53fim4eezsyjHDuMWNB/M0t0qE7IVIEDatuVI=;
        b=lzWoH8t4omeXZsD2h2a68CxHaOWSdbAmKNKaiw4Npq06IWCUROUBFUIsr12FGmWIUU
         5oLwhX8fgGU7ZKKHv0FaDBTGHyzfuvqLaNa0yRyqERuC45V4TpBuUPE0fRcIUI/DGPlO
         G4bjDBPQkR9artpaWcOESIVMqNSUA1acVXYKBpjHTBp0o6vLYSNKKm3i5Sw9xRzJpujn
         4xnJ0levepNjFTsEmanMdbmIjIsEgFuNWbyKuho3tN3rW0g8tXo4Aqr4T73IrS8MXOPf
         rWBVWsQFgQhTYegvUlEhWwimAoHmTEijmy/gBlA60j3ANhBnNBgVtIzuFHa1+8hfu9fn
         mOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717587995; x=1718192795;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yD9yrm53fim4eezsyjHDuMWNB/M0t0qE7IVIEDatuVI=;
        b=h228wxGyxZLvRlVtzq0YXZ/t+qJRsmFvKlMvNyPPucNJt+JB8VF2TrW27yX/JfU6hf
         gdbLrEyX7T6o/iorti8BskD6Q/CCe7GKdw2++tfyEcas3+sEQPyuoMxJwDjZQ+cI/GFQ
         t4wAPQBVvDnRYyacAXjvmxEoZN5jSd1upU+Kz1geV8xOWx5SGykSeSDRYHXN2B43dyDn
         V0Dl2g2vE8F8W+UCaKWgtspOthu+9mNNyUlKNy/x6vIUVDmq2dowD+KrksJcMllAZNHu
         09fxTDNdncd3KgG+4ZMI5hejZQnKhksEWL+9af0j3s+6LrOoEU1D3Zlr/2ywm05Rjjd9
         oRSw==
X-Gm-Message-State: AOJu0YxaoRoJK7hu0fwcAhuilLn6VRs6XljbJ0SZonlhZfcQwzf5U5Zd
	XtyP0rollgYzTNZoqgdrRhg9C7DLaYPLA0V2yy+oQi66iHz5cpyphWVzDnpxOmg=
X-Google-Smtp-Source: AGHT+IGX5xScYc70aafJ2AbcljcUtzjjJepnCrCOwShQP1/+ACX6bHMi177JsSxwiRNbDThhaAEmng==
X-Received: by 2002:a05:600c:19c9:b0:421:52ce:6878 with SMTP id 5b1f17b1804b1-4215632d091mr18053745e9.29.1717587995377;
        Wed, 05 Jun 2024 04:46:35 -0700 (PDT)
Received: from [192.168.2.24] ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421580fe37csm19505265e9.3.2024.06.05.04.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 04:46:34 -0700 (PDT)
Message-ID: <c6ff5778-f928-4a65-8a32-a3582d9d8f94@linaro.org>
Date: Wed, 5 Jun 2024 13:46:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/11] dt-bindings: net: add STM32MP13 compatible in
 documentation for stm32
To: Christophe ROULLIER <christophe.roullier@foss.st.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>, Jose Abreu
 <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240604143502.154463-1-christophe.roullier@foss.st.com>
 <20240604143502.154463-2-christophe.roullier@foss.st.com>
 <067d41e5-89cf-45eb-8cfa-b6c3cd434f76@linaro.org>
 <70b66190-2c55-4228-8c31-f58a05829d8b@foss.st.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <70b66190-2c55-4228-8c31-f58a05829d8b@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/06/2024 11:55, Christophe ROULLIER wrote:
> 
> On 6/5/24 10:14, Krzysztof Kozlowski wrote:
>> On 04/06/2024 16:34, Christophe Roullier wrote:
>>> New STM32 SOC have 2 GMACs instances.
>>> GMAC IP version is SNPS 4.20.
>>>
>>> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
>>> ---
>>>   .../devicetree/bindings/net/stm32-dwmac.yaml  | 41 +++++++++++++++----
>>>   1 file changed, 34 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
>>> index 7ccf75676b6d5..ecbed9a7aaf6d 100644
>>> --- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
>>> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
>>> @@ -22,18 +22,17 @@ select:
>>>           enum:
>>>             - st,stm32-dwmac
>>>             - st,stm32mp1-dwmac
>>> +          - st,stm32mp13-dwmac
>>>     required:
>>>       - compatible
>>>   
>>> -allOf:
>>> -  - $ref: snps,dwmac.yaml#
>>> -
>>>   properties:
>>>     compatible:
>>>       oneOf:
>>>         - items:
>>>             - enum:
>>>                 - st,stm32mp1-dwmac
>>> +              - st,stm32mp13-dwmac
>>>             - const: snps,dwmac-4.20a
>>>         - items:
>>>             - enum:
>>> @@ -75,12 +74,15 @@ properties:
>>>     st,syscon:
>>>       $ref: /schemas/types.yaml#/definitions/phandle-array
>>>       items:
>>> -      - items:
>>> +      - minItems: 2
>>> +        items:
>>>             - description: phandle to the syscon node which encompases the glue register
>>>             - description: offset of the control register
>>> +          - description: field to set mask in register
>>>       description:
>>>         Should be phandle/offset pair. The phandle to the syscon node which
>>> -      encompases the glue register, and the offset of the control register
>>> +      encompases the glue register, the offset of the control register and
>>> +      the mask to set bitfield in control register
>>>   
>>>     st,ext-phyclk:
>>>       description:
>>> @@ -112,12 +114,37 @@ required:
>>>   
>>>   unevaluatedProperties: false
>>>   
>>> +allOf:
>>> +  - $ref: snps,dwmac.yaml#
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - st,stm32mp1-dwmac
>>> +              - st,stm32-dwmac
>>> +    then:
>>> +      properties:
>>> +        st,syscon:
>>> +          items:
>>> +            maxItems: 2
>>> +
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - st,stm32mp13-dwmac
>>> +    then:
>>> +      properties:
>>> +        st,syscon:
>>> +          items:
>>> +            minItems: 3
>> I don't think this works. You now constrain the first dimension which
>> had only one item before.
>>
>> Make your example complete and test it.
>>
>> Best regards,
>> Krzysztof
> 
> Hi Krzysztof,
> 
> "Official" bindings for MP15: st,syscon = <&syscfg 0x4>;
> "Official" bindings for MP13: st,syscon = <&syscfg 0x4 0xff0000>; or 
> st,syscon = <&syscfg 0x4 0xff000000>;
> 
> If I execute make dt_binding_check 
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/net/stm32-dwmac.yaml with:
> 
>     For MP15: st,syscon = <&syscfg>; 
> =>bindings/net/stm32-dwmac.example.dtb: ethernet@40027000: st,syscon:0: 
> [4294967295] is too short
> 
>     For MP15: st,syscon = <&syscfg 0x4 0xff0000>; 
> =>devicetree/bindings/net/stm32-dwmac.example.dtb: ethernet@40027000: 
> st,syscon:0: [4294967295, 4, 16711680] is too long
> 
>     For MP13: st,syscon = <&syscfg 0x4>; => 
> devicetree/bindings/net/stm32-dwmac.example.dtb: ethernet@5800a000: 
> st,syscon:0: [4294967295, 4] is too short
> 
>     For MP13: st,syscon = <&syscfg 0x4 0xff0000 0xff>; => 
> devicetree/bindings/net/stm32-dwmac.example.dtb: ethernet@5800a000: 
> st,syscon:0: [4294967295, 4, 16711680, 255] is too long
> 
> So it is seems good :-)

Code is still incorrect, although will work because of how schema parses
matrix. But even by looking it is not symmetrical between allOf:if:then
and properties:. Make it symmetric - apply the number of items on the
second dimension.

Best regards,
Krzysztof


