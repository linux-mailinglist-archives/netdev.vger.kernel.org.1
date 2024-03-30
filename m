Return-Path: <netdev+bounces-83529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4285D892C97
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 19:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5719B211FB
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 18:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725E222093;
	Sat, 30 Mar 2024 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ovRKAunK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A0F1DFD8
	for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711824026; cv=none; b=YSAx8xkkQXV0X4d379uQH8fg7WqOuJUyistfIo1Z7f+MqA0KhxW89JvRxlavM436WN6oMheIXFXnPTRJdYXTlOz8J01qZDNeV8RN3Sd7SyMzVyxejTC0UnE6ZtLM4Ne6wwjk4RI3NFtmMNX05/Gt+YHFLlOwE7rSEAaBBSQccJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711824026; c=relaxed/simple;
	bh=N2ieWKwF/s/SRgPfVie63l9DGnTbBJVt+ugqWhTyPp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qOisqyxuQSQvuFzubzobIP23h1E71tFuwSNE3DVfqJnfg4sjIApuy9qlw+XZ9lr4TanVxqbCmecN0CuNvylDeVEeL9lJNLgXHmE4fKMYb2lozgTEdjdjjXWGygg0x3NstSOHmNS/F1mIlG0kM4E3HdQxyEny2JUupR4si/FP+14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ovRKAunK; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d6fc3adaacso41181971fa.2
        for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 11:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711824023; x=1712428823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A3VqCu8McawT5v2srPzwVC1CxiNRKF4OzinQo91YGYM=;
        b=ovRKAunKXv25YFrKvZpRWuJUxrXDA/xU4eb93PBEajSnCdebqVbothQ70PnbJoE/pm
         CuF6lk/2MB73hZ/5mOg32dQI5uv4fNq81nepDYnXT7z/D/wSCVYG4mr+LjN4m0GfGvwC
         0laCy1VOmzMnau9XOiOoXCgsG6+/81eUTHS+akK9Pe49LFteT/PQuX4N2h5WDiiRHjg7
         28ZGUlFGBipO14R2GJ+KOsCJu9URaYxjvhzkDlrrq5sQLfGM40+xgfK3+nG+oBcK7Ax2
         fm/GP0ust/L3tuoxkoIdSif33yfCdoc0ssH3QzetP+47WiWPPAqz4AadjP2qSMZeGSpa
         BJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711824023; x=1712428823;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3VqCu8McawT5v2srPzwVC1CxiNRKF4OzinQo91YGYM=;
        b=lSSBGmJ0C5k0eht0JUPe0otSl+E2xPjoaDTh+iGCJLwAGEMIkIVZ4tWgI3OAB6u2J4
         yuICwlkt1Z4du2T+yIOOP5V5C2gN52L47FEHs/mC6BOt7PtUB1AnD/JMkbq77MGBkkuC
         HHYkXvm7B8r0WD4Pi8866LIFY6j8OCs04ttzAVjXeIBJaYfYehIDzMibXbCgVzEkQHxJ
         xEE6DaDqAyPZmAw8qiVL/Mg8P4qtwSUVySNaPhWA5BE9o4sUD6prouCGb+E1jLW9LV6N
         vhjSpDWYS9yyXDFzYbFaJqxoS8kxANQ6hH0Yn+iIycj7jAXyqlMRJ6mRKYjD9KlIB3Mb
         ZhXg==
X-Gm-Message-State: AOJu0YzLpd+3cqHsZvYAoCUnb+FKbGlAocL2nYPy+E3lMEl4719j3qk4
	A4eSS0eP+yle9MFaDDxnSf8LCJTtplO+xqtV1fZcZC6DMh/VbcAUIZgBCEbs22s=
X-Google-Smtp-Source: AGHT+IFAV3o4UY/hu5H0Wy2QF9GFBHA3ATanZSUry4YleUZP9Co40bCkswGTtms9hcvOo/OKxYMGzg==
X-Received: by 2002:a05:651c:1401:b0:2d7:16f6:f678 with SMTP id u1-20020a05651c140100b002d716f6f678mr2611136lje.15.1711824022831;
        Sat, 30 Mar 2024 11:40:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id h11-20020a05600c314b00b0041490467febsm12416252wmo.38.2024.03.30.11.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 11:40:22 -0700 (PDT)
Message-ID: <46b065d1-82d7-4a15-9de2-1e0bdd2a9085@linaro.org>
Date: Sat, 30 Mar 2024 19:40:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] dt-bindings: net: dwmac: Document STM32 property
 st,ext-phyclk
To: Christophe Roullier <christophe.roullier@foss.st.com>,
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
References: <20240328140803.324141-1-christophe.roullier@foss.st.com>
 <20240328140803.324141-2-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240328140803.324141-2-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/03/2024 15:08, Christophe Roullier wrote:
> The Linux kernel dwmac-stm32 driver currently supports three DT
> properties used to configure whether PHY clock are generated by
> the MAC or supplied to the MAC from the PHY.
> 
> Originally there were two properties, st,eth-clk-sel and
> st,eth-ref-clk-sel, each used to configure MAC clocking in
> different bus mode and for different MAC clock frequency.
> Since it is possible to determine the MAC 'eth-ck' clock
> frequency from the clock subsystem and PHY bus mode from
> the 'phy-mode' property, two disparate DT properties are
> no longer required to configure MAC clocking.
> 
> Linux kernel commit 1bb694e20839 ("net: ethernet: stmmac: simplify phy modes management for stm32")
> introduced a third, unified, property st,ext-phyclk. This property
> covers both use cases of st,eth-clk-sel and st,eth-ref-clk-sel DT
> properties, as well as a new use case for 25 MHz clock generated
> by the MAC.
> 
> The third property st,ext-phyclk is so far undocumented,
> document it.
> 
> Below table summarizes the clock requirement and clock sources for
> supported PHY interface modes.
>  __________________________________________________________________________
> |PHY_MODE | Normal | PHY wo crystal|   PHY wo crystal   |No 125Mhz from PHY|
> |         |        |      25MHz    |        50MHz       |                  |
> 
> ---------------------------------------------------------------------------
> |  MII    |    -   |     eth-ck    |        n/a         |       n/a        |
> |         |        | st,ext-phyclk |                    |                  |
> 
> ---------------------------------------------------------------------------
> |  GMII   |    -   |     eth-ck    |        n/a         |       n/a        |
> |         |        | st,ext-phyclk |                    |                  |
> 
> ---------------------------------------------------------------------------
> | RGMII   |    -   |     eth-ck    |        n/a         |      eth-ck      |
> |         |        | st,ext-phyclk |                    | st,eth-clk-sel or|
> |         |        |               |                    | st,ext-phyclk    |
> 
> ---------------------------------------------------------------------------
> | RMII    |    -   |     eth-ck    |      eth-ck        |       n/a        |
> |         |        | st,ext-phyclk | st,eth-ref-clk-sel |                  |
> |         |        |               | or st,ext-phyclk   |                  |
> 
> ---------------------------------------------------------------------------
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>

Can you please start testing patches *before* sending them?

Best regards,
Krzysztof


