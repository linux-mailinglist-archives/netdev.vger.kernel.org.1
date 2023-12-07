Return-Path: <netdev+bounces-54919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EFA808E9F
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94391C20756
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 17:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56640495E1;
	Thu,  7 Dec 2023 17:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FYv0ynVV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4782112
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 09:23:10 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a1e2ded3d9fso149710066b.0
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 09:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701969785; x=1702574585; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xCN86JzuyxYQUTWadW6UZP/CazZ5yOz4g3wliWdYt3U=;
        b=FYv0ynVV5iqfAitzMQocL2iIki+prZTdNTdv7NlkssHhzdTGBJJK3aeD+NKJ0J3eLV
         bzEW+FR4ZoBfDDc6ir0O5PWgwVfJnmTpG4DZoZDAwfa8xFSgZgLZDBOqGkT8wr38vby0
         Doz+d4X2rgi1fmuQcbtCtPQ1Y1bJ8IGyf9D6DOS5qJYKKgwZ/peX0NVk9e+P+y6sys3Q
         VfjqiyoRIXyuPMGizwV/dcMiQZCJ87R4OUZ0iyQoPVXYLGTOpxjsLS8bxrm8Ux9OgVKd
         VxucBEK6abD3LDOY7N1SsIDepyenvch5XUOdS5baIm5r4oVgKy6Hj+wSAtBxuL5/cP5W
         AFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701969785; x=1702574585;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xCN86JzuyxYQUTWadW6UZP/CazZ5yOz4g3wliWdYt3U=;
        b=cQ0KlyrH5WtkodYLIoL2ve11TQ6Mg61ByamAA9iQDeICi1KxAmSd97ofa3H6uxyTKz
         bGv/JPRjjhGiUw7ieyjyd6XxGlFCvLEYs200Jk70ZGhByzihFWXdZ8jBh63tyJUdcbCY
         t9Dn3AJBUi4MtrEoWdU1QFeRGMsXyBnc/NkCR+Uge1NCXcfjkhMu867I8bzMaxjD+jRI
         VIF5547J9XaTI9KWdD3yStb6FjaFQONA4Ocp/srzEb78WTCivTRjfFezVPbSgs1sHcHc
         ZDrUAz5N5h95wBIdV4szmJNuRSkoU5SIgXTsvY92aplvlFVvBBz/DcRcm6SbLn0dAm0I
         uxNA==
X-Gm-Message-State: AOJu0YxHI3W/q2w/h3b4r1cInhXodMTTAbvOUbzsZJMBu3DuuN1Q3Xvx
	ptfTmAnf5Q+4YuCS5SyLo77wfg==
X-Google-Smtp-Source: AGHT+IGuzYvSbRVoaHaUlIQIsKHF0sw1uFqaQroBBzH3JWqKKxvgMFMM/opf+L7LBngFCdfmRmDUxg==
X-Received: by 2002:a17:907:350d:b0:a19:a19b:788c with SMTP id zz13-20020a170907350d00b00a19a19b788cmr1647561ejb.79.1701969784982;
        Thu, 07 Dec 2023 09:23:04 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id q3-20020a1709066b0300b00a1c7f8fe581sm1074082ejr.221.2023.12.07.09.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 09:23:04 -0800 (PST)
Message-ID: <5ec5ee0f-c490-418e-9d37-fdcb67325843@linaro.org>
Date: Thu, 7 Dec 2023 18:23:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] dt-bindings: clock: mediatek: add clock
 controllers of MT7988
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Jianhui Zhao <zhaojh329@gmail.com>,
 Chen-Yu Tsai <wenst@chromium.org>, "Garmin.Chang"
 <Garmin.Chang@mediatek.com>, Sam Shih <sam.shih@mediatek.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 James Liao <jamesjj.liao@mediatek.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
References: <23bc89d407e7797e97b703fa939b43bfe79296ce.1701823757.git.daniel@makrotopia.org>
 <def05aac79ddff872d3e56698b736cb445f14116.1701823757.git.daniel@makrotopia.org>
 <3e72bff6-9f4d-4cd4-845e-b065f1233ec6@collabora.com>
 <ZXBs9GOOOlZrMuSW@makrotopia.org>
 <64ee48fc-4f77-48cc-b235-c9fb2b10afc4@linaro.org>
 <ZXH-Mq_DlW5Oodwt@makrotopia.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZXH-Mq_DlW5Oodwt@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/12/2023 18:17, Daniel Golle wrote:
> On Thu, Dec 07, 2023 at 06:03:44PM +0100, Krzysztof Kozlowski wrote:
>> On 06/12/2023 13:45, Daniel Golle wrote:
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    items:
>>>>> +      - const: mediatek,mt7988-ethwarp
>>>>> +      - const: syscon
>>>>> +      - const: simple-mfd
>>>>
>>>> No, this is not a mfd, I say.
>>>>
>>>> Prove me wrong! :-)
>>>
>>> https://github.com/dangowrt/linux/blob/mt7988-for-next/arch/arm64/boot/dts/mediatek/mt7988a.dtsi#L564
>>>
>>> The 'simple-mfd' compatible is required to have the Linux
>>> kernel probe drivers for sub-nodes -- several drivers will act on
>>> the different aspects of the circuit exposed at this memory range.
>>> From what I understand, this is the definition of a MFD.
>>
>> We know what is MFD, so no need to teach us. We expect you to look at
>> this. You do not have subnodes, so MFD is pointless. Showing DTSI means
>> nothing except that you did not test your bindings.
> 
> Sorry, I simply wasn't aware that this is what I'm being asked for.
> Is the device a MFD? - Yes it is.

You need to answer this :)

> 
> In this case the child node would be a 'ti,syscon-reset' which doesn't
> have YAML bindings. Should I include it as object without $ref or do I
> need to convert ti,syscon-reset.txt to yaml first, and then reference
> it as child node in the MFD?

It would be enough to have:
  system-controller:
    properties:
      compatible:
        foo-bar
    # TODO: Convert to DT schema
    additionalProperties: true

(so no ref, but comaptible present)

Best regards,
Krzysztof


