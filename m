Return-Path: <netdev+bounces-114238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC7A941B2E
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 18:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EDB21C20BBD
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9391898F3;
	Tue, 30 Jul 2024 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c73hOhee"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2030D188013
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358309; cv=none; b=epgV4K12zAtBAGnNICB2C/jBgbq22VfqxBVOZftggBItfg/mfnjHhqN+nx/9yJaI4lXPQR2RYRvtce9L551dhL71P20fGdiI1262VEEJay9sU7fGurIwxpwRVwuYB0r+nbaAvbUDjg6MLn36pObyZM7ylfAXmElF4pqv7+5Hh8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358309; c=relaxed/simple;
	bh=ADfE1Lt8qM+0qpABUkaU86u8l63sEqNFydbXrQ73Nl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MoZN1t0fvthxfAhbBt15odhkTUlQ+3VFaO62seEUoRhqb0W36kuqgh5RQhT4SRBLM+DfMUl3FiKd1jh3TXfkgsNyO0Vx4ks+/WZd0JoZTX9ggyOTkv4t+PDmSE0uRIaYeHKAagWj1BFqTbR4qDUrUxuIOUunXNa+PCBkRwLGu6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c73hOhee; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a8a4f21aeso629820566b.2
        for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 09:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722358306; x=1722963106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6fRrBntY5SNNpSQn2/H4DTQBpZkc856gUEuyCgFnvMM=;
        b=c73hOheeJyZyJak1PFjRsAs2b3eQ5Pv73H5/wd6zBBSzVg8LuLS3kUTIRffEuSlGJV
         Ro8v8L7SKr16kaRvBsXl7yAL5IirBJUPMvbaDNSmal/4p/irfA22VwqOmk9tS330aMdM
         J0R1P1aI0Zl/iuX/LQabdKN5/k5UxnRMJvZe6rdcfOmlHBvBvmHW9GyxgnJ8AK45kDuS
         ZR+hG8Zck8S1gc/KMD7s2COU76tSRoIHxgHNJXt/l+F4WOsJYwEdR5Y69VN2Ii7fWGGb
         paDu9LRRlQC4MY/md97SXw6fULtJAJnFQbmz8r2fxieHvNyvi7v9NRKwWcVO3LsxBe+V
         BCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722358306; x=1722963106;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6fRrBntY5SNNpSQn2/H4DTQBpZkc856gUEuyCgFnvMM=;
        b=wF0DHAmm6T4BeAc7stTv/tp0HHynK0ViwVU0cZDZ1Ggi6Xj5bV1vM5xuvlH69Rpv3m
         SrrlxLRPGUL0TkWLQ0K35qyiIMeUoHXltHmy1kYwpHPe/nIXgxh0KOZeCvhv+xIYNkzC
         YPePuhherrgzkX3wszDMGwbeNzq+IA6BPtLhrs5DPae1XpdDTtRjBLg77jOKM+CsHnVT
         dfQ+njsbNIEbtgCRhKuORYqeOzOMA10bm4Z/mn9OTCLHyptQhX9jfKPNGGYHDxSn8lyQ
         w3I5sezAsWB6a/gezZquGnqA4DVOlYLQw7zM/bcr2fUO3fCTKeaens3qi9KwgtwUU8mC
         ynRg==
X-Forwarded-Encrypted: i=1; AJvYcCULGeN0mrYufC1g9rpu8kHowBOHulPaeVzuuoNwlYXHRwO20monhVzcTXwQ+n70uv3H/K/JTQztmqQrPThPu8RDisROlvVh
X-Gm-Message-State: AOJu0YyYud821XrgfRKZzhzHyVsoGuqvwDvB9Hbt4AFfvUup/6FLCBkk
	FyWplla+A4a4Odgk/r7bSLU6xx9hDCCa0KDkgXamRi2C+Bk9ZHwIi2XcssNRG+s=
X-Google-Smtp-Source: AGHT+IE1CcDwww1PAFxjIjMv7j4rspGX2aveqObzQA76O3inZ5lhikMfHoED/vjvBpKYwPGyVZyhng==
X-Received: by 2002:a17:907:3d8a:b0:a7a:a30b:7b94 with SMTP id a640c23a62f3a-a7d4000b1dbmr881925666b.28.1722358306362;
        Tue, 30 Jul 2024 09:51:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb98dbsm664965666b.216.2024.07.30.09.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 09:51:45 -0700 (PDT)
Message-ID: <75e70f72-6a5a-4478-86ba-0d24a62b0d4c@linaro.org>
Date: Tue, 30 Jul 2024 18:51:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: MAINTAINERS: Demote Qualcomm IPA to
 "maintained"
To: Alex Elder <elder@ieee.org>, Alex Elder <elder@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240730104016.22103-1-krzysztof.kozlowski@linaro.org>
 <31f49da0-403c-40af-b61b-8e05f5b343e8@ieee.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <31f49da0-403c-40af-b61b-8e05f5b343e8@ieee.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/07/2024 18:29, Alex Elder wrote:
> On 7/30/24 5:40 AM, Krzysztof Kozlowski wrote:
>> To the best of my knowledge, Alex Elder is not being paid to support
>> Qualcomm IPA networking drivers, so drop the status from "supported" to
>> "maintained".
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> I hadn't thought much about the distinction, and it might not
> make a lot of difference right now.  But it's true I'm not
> being *paid* to maintain the IPA driver (but will continue).

It does, existing:
https://www.kernel.org/doc/html/latest/maintainer/feature-and-driver-maintainers.html#bug-reports

and something which will have much, much bigger impact:

https://lore.kernel.org/all/20240425114200.3effe773@kernel.org/#r
e.g.:
"1. Require all netdev Ethernet drivers listed as Supported in
MAINTAINERS to periodically run netdev CI tests."
and some more


> 
> Acked-by: Alex Elder <elder@kernel.org>

Thanks.

Best regards,
Krzysztof




