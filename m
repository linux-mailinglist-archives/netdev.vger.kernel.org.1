Return-Path: <netdev+bounces-92234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 231918B6104
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 20:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1695B20A43
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 18:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7F5128807;
	Mon, 29 Apr 2024 18:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LxLOW1Nh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0EA127E2A
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714414977; cv=none; b=uqcEAGKqiD8J3Qsv0w7Ptkv/wzkHaTogkkXLH8wAsBpRzBIM7vL5v8KckiMulfpb7cCYAPKX1Aw17hTHoex2IagQgSyVzllBXZ+rxW+/rvza8rlsKgKoIcChLbr9i5+DhkM+2ms+DMZdcDXUlHai3ltg1FHUAFmiLrM1J2FrtDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714414977; c=relaxed/simple;
	bh=9DPgT3uw6Y+clGGpSsRmzljwmd2Ouber8k8voXHDBl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SYu2Z9qPAzTtVZw1YPPrydQBRbPoYd+ZrQGtR2zfvh3HMAsNk90wxN1jP1zHnHTGT1/Iqq6jtY8tulVhfDw0aiZDmKl+cq3uHdCeKvqCVMB/w9aEA0FK0fjKDvYC4pkP1jzQBmcAsQUtLnt63IdlOltvrcJVKZ2a8/Z5wBoWLbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LxLOW1Nh; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2db2f6cb312so75662361fa.2
        for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 11:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714414974; x=1715019774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MV4tcYbM0vrj95ZOoIsoEZgFljTqlrV4AU8wxowI8sE=;
        b=LxLOW1Nh6wp+K5JIRbhSfT5R+DlQE3YT3LNVErswXaxugEwvihz+I6xPICH34pN995
         AfFZZ2RHeO2649nkgGFTZ4PdLcaVNJ3hIOgN/YpbfFxX4T8yI6CPBie9SYqQOwQv+Fez
         9V6Xa7OVQa0073zjUKM655ce5yOVnsdo1Ttt28F71ZHCRXNXGE7pzbfKv3xBWwMBo70l
         KoAmRYiQH9S041Emc8i52m2TkqieCtxtSp5Dp60dx43S5/4jP4qDxUvWvLwX7sU4S6ND
         TnPmEruYNvrIZPk3Ep+kyldN6o6H3LmxwynY03DMSKFKsgk8FIvPzvoTELYxjyJHvIZp
         N6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714414974; x=1715019774;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MV4tcYbM0vrj95ZOoIsoEZgFljTqlrV4AU8wxowI8sE=;
        b=HPt3JM7rAAYGS+h8ORX8WRdVe0U9mnQMGzdci+nizUUa6IdXyVHVaq5hQ+2WITj6uy
         PNQgqWCi1KP4NEfIz1wZ6NVkKG6LByzzjRKABryk0in3jaU7S8JDeior12JIGwlojGDt
         e2zE6TO1qYPQYDbj63kmPP2M5woiGybizDrvw8jQUtFXt5xmbP2ehMZta02lxRLOT9Lq
         Fmb9TsM7iDdbal9/BU0uUEohR4kenkUGuZesmj/k8n++QSGIoVzcBVnEfvEvvSTwzCYI
         v4CQTx4L/xExNOjd/TcMFaqlm4OUP7zq0vYtQpa0tlnCV0xs3XnLvL9njqWEYpB+2kBb
         xTvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWHJ71bkmjR9rdoXEMi54mXid+gXNejmbDZFdh6vqufXQ2zkQxzg9ZQfchfLUN54tXyChMxO2JAfb/c3ZQ65s7rJWXAec/
X-Gm-Message-State: AOJu0YyvDxdSJHcDnNOnFGKyLCfsI+xqIIwtEnTv3+BRdkZqNJYaEJIo
	Db3E9KaZIpGNRleBFWijF7kWvl+L7XROuK8zy11gZ0QzkUrp1O4W9XWfM+5Bz6I=
X-Google-Smtp-Source: AGHT+IHTWJlW3inbq+j91+T09l9wjeKR68upzSPtWOOaz2zGxnNvrR/JhwLNTg6hP1pNzFXdSAYSrg==
X-Received: by 2002:a2e:a1c5:0:b0:2d6:c749:17bc with SMTP id c5-20020a2ea1c5000000b002d6c74917bcmr8832501ljm.31.1714414974159;
        Mon, 29 Apr 2024 11:22:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id v5-20020a170906380500b00a58f36e5fecsm2514214ejc.67.2024.04.29.11.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 11:22:53 -0700 (PDT)
Message-ID: <793d016d-2bde-407a-8300-f42182431eb1@linaro.org>
Date: Mon, 29 Apr 2024 20:22:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: net: broadcom-bluetooth: Add CYW43439 DT
 binding
To: Marek Vasut <marex@denx.de>, linux-bluetooth@vger.kernel.org,
 Marcel Holtmann <marcel@holtmann.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Conor Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, netdev@vger.kernel.org
References: <20240319042058.133885-1-marex@denx.de>
 <97eeb05d-9fb4-4c78-8d7b-610629ed76b3@linaro.org>
 <93eeb045-b2a3-41d7-a3f2-1df89c588bfd@denx.de>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <93eeb045-b2a3-41d7-a3f2-1df89c588bfd@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/04/2024 17:10, Marek Vasut wrote:
> On 3/19/24 6:41 AM, Krzysztof Kozlowski wrote:
>> On 19/03/2024 05:20, Marek Vasut wrote:
>>> CYW43439 is a Wi-Fi + Bluetooth combo device from Infineon.
>>> The Bluetooth part is capable of Bluetooth 5.2 BR/EDR/LE .
>>> This chip is present e.g. on muRata 1YN module.
>>>
>>> Extend the binding with its DT compatible using fallback
>>> compatible string to "brcm,bcm4329-bt" which seems to be
>>> the oldest compatible device. This should also prevent the
>>> growth of compatible string tables in drivers. The existing
>>> block of compatible strings is retained.
>>>
>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Is there any action necessary from me to get this applied ?

I recommend resending with proper PATCH prefix matching net-next
expectations.

Best regards,
Krzysztof


