Return-Path: <netdev+bounces-157710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CA5A0B523
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 12:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7785A7A373C
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 11:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE86321ADAE;
	Mon, 13 Jan 2025 11:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hW9qbxN+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3145B21ADDB
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 11:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736766519; cv=none; b=QBUmUhZo861s8ixaCAHGcu7H8DnVwByqmScPJe9Jvq8abDs0Zua/L+f1/ZJfkXVZUjzHAK7JgJC99rhBT/GStMbZVoAejaPnUXtpY5rXEeXjhqznSs2ilO7jmRmpkRHusHshTqETSpfCfwTxVqfzixi47IaKIB9LDBFXYOttonQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736766519; c=relaxed/simple;
	bh=Pc/FEHNMnThLxJGUoxCCquNxSiKLqa6Jy1wGIXVEiG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=helwo58lpofPkBUOPeZZNT+po/RQSSsdcXhyZoLZrRo2FGvGqXOeKEVdxPKDa/nTmeTwmA13NtFRv9TZtQTjX0fCRQshbqnMh78OZT8uUh4yvA6YVDop6XBuEgnnzwrdIJiEW0y0ptkmjcYGQG9lTm6sQQwVany/+gEoEmDHCGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hW9qbxN+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4363298fff2so3766295e9.3
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 03:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736766516; x=1737371316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kvoFJS6F9wk4jz44qoey7Q8fjFA+Q2ZM9VARRWQtXsA=;
        b=hW9qbxN+TOEgwEvKBtTyUcf77r3VNpt2GCKPw3Rt+XLt6iGffP3OBZsBuNZEHcsdia
         dDBbsDCMxuxBHQ4zBavCybPvl6Z5dxqsx/rspkJKUcxdF0Y5PXoWlpWfD1U1axmoLuu5
         basrWOIjEdk1nZ7g+ZhL36GOv45p29VH34/m9DVB2KJ64HAkoyWNbUoCaF93ckLrFXvo
         zKEfzMbHS2N2gGGgBFpHvxqweirgA2CVyUfbOqYzU0dGqSrwYMe9dMiEDXo/fHqbJHSk
         JnpfqX8zlL8/vErqywZoQR0l12xtXMED6WWmCItI0W0YGu/OCqRdtpzy2JTh/6oqLT/i
         xy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736766516; x=1737371316;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kvoFJS6F9wk4jz44qoey7Q8fjFA+Q2ZM9VARRWQtXsA=;
        b=BU4I2fGEMyRDEEYewAVLAgjgfNERDdr229xEyT/7is7MYHoh5XpOOuAP2SpEuHBabO
         aiVOF6dftKl+S31BmztDaQDbgre1YmNvBWbL5B46vydTW93qW3wAwr0jFg7fQQtStucB
         E8Ar6T6EuFEiSCL8H2ok8IzNikF3ydeUDB6khaWPwAwy75c9xi1T9k0UlUIW0ZpqQRJ+
         rA67B3Q0s0huYylX8buvJiu6qVoIqpkwIGyCU0hi3/LbuKY4x/xrDnFGiNM4qVI8K9h7
         uP+MgzfdNp6fB9NRooqZ+J6ATQwMDh8DrOPwo3+zgKjuHPsZ2a0TNNHCguqw1/d57wrz
         rDTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvc980dxeWB/aaCJyzw89lc6g97OiF1NnTBdnDt/Tuv4puw3vt7q0siFx6AbO2whnJQISGIrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdg34zXj7Ox6L0pv/Ix/dojeEKQDKovctMqR4dHnaKKRNlT6B2
	YZpywk85ytlK1l64sUJqSe4wWVUd1/gjb/y0Q/TxgMTqA1F6VvXmMKwvsTJCCJA=
X-Gm-Gg: ASbGncshilmm5mtKrLQi7wJVQS0erbgXDEODsjQTCykGY/mIiP8S4meZuigSp0YNElq
	7YsfNQl1h3240SnM/ODlTHZw51aZa0pap6eitPvIDl4tSZlL9UO1qOItfB8Etobe84s/8cmMY9w
	yODRnzEPZFY89qX/HbmSdrDVJJbO/l/jOPA7jLNtEoFVEVP3cFQMAvm9jA3aa4lt//PSpk/UMuv
	N+tBsZH8f2u+aCcl6wzIx3DuqkHytz15wRtj+keY0fK3jZ1uz+bUs67IIlkxfEb54OzbD/fTZWk
X-Google-Smtp-Source: AGHT+IEtKtLo/TYcYGUtHWrN3Y4wjZbk9HsbQfFeClkVRV79rZvw4FVq+Cj27cVFDaCibTRx/n3qjA==
X-Received: by 2002:a05:600c:4f03:b0:436:1ada:944d with SMTP id 5b1f17b1804b1-436e26ff7famr73442685e9.4.1736766516543;
        Mon, 13 Jan 2025 03:08:36 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6271sm173554635e9.9.2025.01.13.03.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 03:08:36 -0800 (PST)
Message-ID: <249902d2-5a03-4c9b-a7e8-61dcfa9b5029@linaro.org>
Date: Mon, 13 Jan 2025 12:08:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/5] net: stmmac: stm32: Use
 syscon_regmap_lookup_by_phandle_args
To: Yanteng Si <si.yanteng@linux.dev>, MD Danish Anwar <danishanwar@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 imx@lists.linux.dev
References: <20250112-syscon-phandle-args-net-v1-0-3423889935f7@linaro.org>
 <20250112-syscon-phandle-args-net-v1-5-3423889935f7@linaro.org>
 <5d97dd34-f293-4403-b605-c0ae7b5490fd@linux.dev>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <5d97dd34-f293-4403-b605-c0ae7b5490fd@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/01/2025 09:05, Yanteng Si wrote:
>> -	dwmac->regmap = syscon_regmap_lookup_by_phandle(np, "st,syscon");
>> +	dwmac->regmap = syscon_regmap_lookup_by_phandle_args(np, "st,syscon",
>> +							     1, &dwmac->mode_reg);
> The network subsystem still requires that the length of
> each line of code should not exceed 80 characters.


Please read the coding style regarding this issue, before you nitpick
such things.

I see you send comments like:
WARNING: line length of 81 exceeds 80 columns

which is not really helpful. That's not the review aspect necessary to
point.

> So, let's silence the warning:
> 
> WARNING: line length of 83 exceeds 80 columns
> #33: FILE: drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c:307:
> +							     &dwmac->intf_reg_off);

Unless networking maintainers tell me otherwise, I find my code more
readable thus it follows the coding style.

Best regards,
Krzysztof

