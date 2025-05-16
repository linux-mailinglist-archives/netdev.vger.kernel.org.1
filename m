Return-Path: <netdev+bounces-190958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09874AB9786
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 10:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27A8517BA44
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 08:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B588322D79B;
	Fri, 16 May 2025 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R8ewAbkf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827E7225A22
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747384013; cv=none; b=vA3Hz0BookKjQaBOQY0y9pey39MGn4rgdAKX3BWJVVbVmxfEs47RTVv5C+Ck7E/+J2HCNZ+SqfQfY0aBKx/fRXZ9tmFgL2yPbsYRzR0t3UBjvKXDxG62J+hUDfGueJGy5/xS85kFH+sTsCYsber2y6Uw/Fb8yM7A4nU3lfnBOuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747384013; c=relaxed/simple;
	bh=UhCeuXAhFdKN+k8NNU9tkzVV4R4qOX/CMxrUrC4RAMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KRrm3X5NMRZOLn+bXHXJjll2t2yQjkuLvzmvt/3pdifQY4RqBwYRhaHqROHNFiUJxvPDziP9FnF9uUxnweTOuCG/XQ2E41noBNxK+62OFDVOTClui32Bd7QqrWc4d0RB2AcM1iTRA7NW78/A2IOxyrNUYHs1pPPK5w40HjDxBuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R8ewAbkf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d4ff56136so2551285e9.3
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 01:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747384010; x=1747988810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f7l73PM002CCN10WrbnnaKwXuL9DVgMrLzlYZMX/umg=;
        b=R8ewAbkfPHUg4/hS5vxRgxAzW4IHY2pQPImuHwwZyvaZsLlPkTnwVOpSAdxnqo48/P
         7GSrd4jb3/yOOpsNf6f9mG1LM9sBPP8ffTFhggd828UsqrLkpnACrE6ImlJONmabQmWX
         5axmIMPTNCJaPRHPO116EzomKY/Dg68yY2Jfp7Krr/F7G0pEIcru7DY6QHcjG5iG3+4N
         rVnOYRTu060TxoOADFpKVRKVb9kQLkSoMK0a2xNPKb70NRoWETjIV4JytlCymTlcrXdR
         vYScqC9JW0DwpxbqEkaMRO/or5e3gMssXBG+be64g21WD+YCwrcCWCULfuGlWhmsXC4V
         A4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747384010; x=1747988810;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f7l73PM002CCN10WrbnnaKwXuL9DVgMrLzlYZMX/umg=;
        b=op/dleCySFM4mZwlZcYBZOButDqqDprjCN4P0GAoFGsLfHROua4jgNY2ZXTksgGDMd
         /N9LgmWaRshD64pQCYkAhOWJhW5s1bZrmSlfUFdoWz3+4JWTItUqunSIOVwq0xCtRILO
         g6PiFeG5XnqzCgAXXUaAN0Rj0l1I9kIcQ8PvNwFCQZ2O33i9t9vS9GvB8GMbXkiR9Qob
         v4eUe9+aQ+wNj0KEwQ8g3rCHbi3kSCukTVK+5bnnLKOvnimiw8c9Ivtfkj9kqgcjJAPP
         oLSIYJlQjWL9xqhV0WtiWHorfsazSGrTEJF4PYNAsR0/iz7sEYy90xx3i9LQlZqYeXB5
         XZQA==
X-Forwarded-Encrypted: i=1; AJvYcCUwazR5yjACsJdXWedCtsj11XwBAcIgnsH7OtQfpAXY0426tILCvcXpv6DwK5WeBw9auRzqoHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN6XdfYYlSy7rMSUR76xZJEly1pl9FqKXgcDgDwEWLdBKPzrdb
	cGeyRDFBC2klbHEQVua9yf0+02R9g928Eooc594a1Bl61x6Hdz76zJdi9d/ktkqU8ag=
X-Gm-Gg: ASbGncv8A9ttWKNFi/KXBT0aLF53XcBFm9RDnqQjWqLPX4ej1vsR5o+Mp4hxTfnI0ir
	T8TGHl4XExsdRBzZIweUKR1FPxxRo71vTCuDsX9Wh5lOThQ3a8hHTdRvsP3+VjJfJXOH2rQkPc3
	xPaQyLyjpXh7d8TrKfyrfpdLPvJz5kxfBQc+iV1+3sVZQBwHCuTWrQ/dQZ+Dia/ymXCfOUIEzWQ
	33fcthLqcK66/isNe8rzsn3eleFBtVHiq9ONdJ4a0ZB1dGcuf+tc042q305GQl3Oe4fCR9e6L8G
	GT8VRJGKqKADFV05fIBJLsKhUYdb3J3Cgc4dtQltHUhsWZ48nSl1j6OfybFFhd/uRDlJEC6H8p5
	M3whnAZQR2aFCtXUnHA==
X-Google-Smtp-Source: AGHT+IGWyXgoAVW4BSrSzUw5Y/5nzOpp23MQkmYnPVtuC71wZostsPX5aKPI88cXnFHlc6qgWlJ01g==
X-Received: by 2002:a05:600c:45cf:b0:43d:301b:5508 with SMTP id 5b1f17b1804b1-442fd60fd95mr9296845e9.2.1747384009669;
        Fri, 16 May 2025 01:26:49 -0700 (PDT)
Received: from [10.61.0.48] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a361a81fd8sm1166197f8f.81.2025.05.16.01.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 01:26:49 -0700 (PDT)
Message-ID: <bfe991fa-f54c-4d58-b2e0-34c4e4eb48f4@linaro.org>
Date: Fri, 16 May 2025 10:26:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mux: mmio: Fix missing CONFIG_REGMAP_MMIO
To: Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Davis <afd@ti.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Samuel Holland <samuel@sholland.org>, Arnd Bergmann <arnd@arndb.de>
References: <20250515140555.325601-2-krzysztof.kozlowski@linaro.org>
 <174738338644.6332.8007717408731919554.b4-ty@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <174738338644.6332.8007717408731919554.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/05/2025 10:16, Krzysztof Kozlowski wrote:
> 
> On Thu, 15 May 2025 16:05:56 +0200, Krzysztof Kozlowski wrote:
>> MMIO mux uses now regmap_init_mmio(), so one way or another
>> CONFIG_REGMAP_MMIO should be enabled, because there are no stubs for
>> !REGMAP_MMIO case:
>>
>>   ERROR: modpost: "__regmap_init_mmio_clk" [drivers/mux/mux-mmio.ko] undefined!
>>
>> REGMAP_MMIO should be, because it is a non-visible symbol, but this
>> causes a circular dependency:
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/1] mux: mmio: Fix missing CONFIG_REGMAP_MMIO
>       https://git.kernel.org/krzk/linux/c/39bff565b40d26cc51f6e85b3b224c86a563367e
> 
And dropped. More recursive dependencies are detected, so my fix here is
incomplete.

error: recursive dependency detected!
	symbol REGMAP default is visible depending on REGMAP_MMIO
	symbol REGMAP_MMIO is selected by MUX_MMIO
	symbol MUX_MMIO depends on MULTIPLEXER
	symbol MULTIPLEXER is selected by MDIO_BUS_MUX_MULTIPLEXER
	symbol MDIO_BUS_MUX_MULTIPLEXER depends on MDIO_BUS
	symbol MDIO_BUS is selected by REGMAP

https://krzk.eu/#/builders/43/builds/4855

That's a mess, I need work on this a bit more.

Best regards,
Krzysztof

