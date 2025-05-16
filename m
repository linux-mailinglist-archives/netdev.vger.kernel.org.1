Return-Path: <netdev+bounces-190965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F531AB9831
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 10:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7124E4A7C
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 08:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC99D22E40E;
	Fri, 16 May 2025 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yA+0c3hx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B37022D4EB
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747385924; cv=none; b=bIafsEIbx5bTQIoWh3r6tJnLoHzDo1eMXmMbaQJnv/UtBNiCmF/1K+YAEY+PSJMSEcDkuP+r8Hj5af8GRBnD+NpcUK1X9VrqfS6NUukThmw7LaUKQ232rhDpx9wfHMDKfgW1vXuUgHocHyWT97lspd/jHP2uHGH5mRh1aZSoThI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747385924; c=relaxed/simple;
	bh=7FffXvLeKVNlR6uoqZ15PUXeCWWDgYVuxgS0Fm8cQd4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YHQHvOSaVnAZCTRilMQHhaTw/dLX7A0MV3+xBBYISTRj/OO/Jo9oXOpcLjQmGxXKJqXe1GetjS9qOUk+pio2bfOIBCnkp93ml1lXg8jAcl2+j7yaqbrFeGu5qHxdslVMPNtw+afsROZWlGpbBLdm1cTXaCKUXT9I+U0QY7lbdBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yA+0c3hx; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a0b201faedso74734f8f.0
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 01:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747385920; x=1747990720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6SuW2sYoRudxoKwWXCHSjr484LyAuBVn8uA/9tnwmd4=;
        b=yA+0c3hxWBlnVQ5N9HBK1fZb5Db4twlxAaS4hIkbFbDa52pQyx4d6JJe9Chc4B00cc
         psDyGqFyd4QzVAdFSmIvrxwgfQuC81+bgHsLB5t5k2xSvFelhH3a/0cJsKRLSMmDWsGb
         iexHtK0OZbZh2yR+fmf/7giG0cq3VC1ZsemtL6oXZkDuK53U8/+UAKYJdDRt8vCVJTNc
         ZGz3vyfCExm7G3fmitKOWQ2vgjGNKo002o+6s8a90gWuTrtoI6Tig4pdjj9w2keyvMU0
         6CC2nwQVhnhmyZnr6t8yXnoQSZs3aAV3utC4hU7PmTCI82MnKt7Xhb9LMxXdwNgRuD55
         UIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747385920; x=1747990720;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6SuW2sYoRudxoKwWXCHSjr484LyAuBVn8uA/9tnwmd4=;
        b=uKiIS58Us/XbklBfFK7SIyVLK1G5YNHZs2L6RuXPBd6rKUmjKCuaSrBh+psFE0zIpw
         3ng4Hq5Cofiw1fJBpKR5SsjyplkdJ3TvLE5P6auDE9clL36PxTjiIdTrdaUpvIcMjQIn
         k8zKJTQxkrtAAuC8ZSN3bBG4G1DVG401MwzOayy70RYuPg51PCJ4SdnZmdwk/wtbIekx
         7z5TkUZw6RC/AqQmcgCGYwEwazvpK3sZlvgGK5CfK0TY2Kv+GVhxMApyNbyxxM1d5gXd
         vciqtjU5AHgI1bj7QFYXPVD2xAcbfs24WKaKTqWL6+zK1Q3kFgTFtJ0R2jWRf1kpexFQ
         6okw==
X-Forwarded-Encrypted: i=1; AJvYcCXxXLra1GlwjHhTd3sBM7+oHzfv3G7a1Z6N4duy6Fmtl8voBgrizQjNGU3FBPQ90Ps2IH1kPqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDozccMqXB9xsKm8lyQxhNZ9j41uk6IqC43e+66EJlMmD1zoie
	rbzLqoHtlid2+iPhoWWbrv5JVWPtcQErAP8imdDcV82CjwFOUwtAlOhHGbZ4csdZhdM=
X-Gm-Gg: ASbGncuGfAW9pHl89m6R0mwBxlubXL5ZEmKBUHwp7ddrVb1QB5p4Ngj6HvZ2F2pCPUw
	Wlyu9fT1o3kfrj1581CHg8XUVcSU6mvtC7eaccT9myvmpUSWIaftxRrPwisM0eXE6BPyIh70W91
	Q86IGyh3WuLPIH3LtmvreDbzPHhA+mMGhc3xw4pJVGIZNqYR/LMM8OLogbAP0j5NnIwvHMLzDSm
	X5FGLgDxkiZ/hDvdrHH6L7JtKu7SlofCdZcjiK0zp29igrHpm9Zgn8yAFaDtvOebvWm/J83Sdem
	JgoP4WN7IVjTtWE5dE48NqPsFvwA2x5N/fqF068u2tqEAz+3u5/iCIY5a0tXJedeY9sehhlbQSn
	w1XH8ELXCFdbG+XzgfQ==
X-Google-Smtp-Source: AGHT+IEHIHKYT617wcgqLY+PLBHB4KlvbUAOazu24dgygpwpHFutNx3vJAyishTlkdyTEH23k4nY7g==
X-Received: by 2002:a05:600c:46cf:b0:43e:94fa:4aef with SMTP id 5b1f17b1804b1-442fd6845d2mr8545855e9.8.1747385920323;
        Fri, 16 May 2025 01:58:40 -0700 (PDT)
Received: from [10.61.0.48] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3951854sm96246075e9.24.2025.05.16.01.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 01:58:39 -0700 (PDT)
Message-ID: <3172aba1-77f8-46a7-a967-14fae37f66ea@linaro.org>
Date: Fri, 16 May 2025 10:58:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mux: mmio: Fix missing CONFIG_REGMAP_MMIO
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Davis <afd@ti.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>
Cc: kernel test robot <lkp@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Samuel Holland <samuel@sholland.org>, Arnd Bergmann <arnd@arndb.de>
References: <20250515140555.325601-2-krzysztof.kozlowski@linaro.org>
 <174738338644.6332.8007717408731919554.b4-ty@linaro.org>
 <bfe991fa-f54c-4d58-b2e0-34c4e4eb48f4@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <bfe991fa-f54c-4d58-b2e0-34c4e4eb48f4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/05/2025 10:26, Krzysztof Kozlowski wrote:
> On 16/05/2025 10:16, Krzysztof Kozlowski wrote:
>>
>> On Thu, 15 May 2025 16:05:56 +0200, Krzysztof Kozlowski wrote:
>>> MMIO mux uses now regmap_init_mmio(), so one way or another
>>> CONFIG_REGMAP_MMIO should be enabled, because there are no stubs for
>>> !REGMAP_MMIO case:
>>>
>>>   ERROR: modpost: "__regmap_init_mmio_clk" [drivers/mux/mux-mmio.ko] undefined!
>>>
>>> REGMAP_MMIO should be, because it is a non-visible symbol, but this
>>> causes a circular dependency:
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/1] mux: mmio: Fix missing CONFIG_REGMAP_MMIO
>>       https://git.kernel.org/krzk/linux/c/39bff565b40d26cc51f6e85b3b224c86a563367e
>>
> And dropped. More recursive dependencies are detected, so my fix here is
> incomplete.
> 
> error: recursive dependency detected!
> 	symbol REGMAP default is visible depending on REGMAP_MMIO
> 	symbol REGMAP_MMIO is selected by MUX_MMIO
> 	symbol MUX_MMIO depends on MULTIPLEXER
> 	symbol MULTIPLEXER is selected by MDIO_BUS_MUX_MULTIPLEXER
> 	symbol MDIO_BUS_MUX_MULTIPLEXER depends on MDIO_BUS
> 	symbol MDIO_BUS is selected by REGMAP
> 
> https://krzk.eu/#/builders/43/builds/4855
> 
> That's a mess, I need work on this a bit more.


My branch fails with above error because I do not have Heiner's commit
a3e1c0ad8357 ("net: phy: factor out provider part from mdio_bus.c").
Will it reach current RC (rc7) at some point? I could merge the tag to
my next branch to solve it.


Best regards,
Krzysztof

