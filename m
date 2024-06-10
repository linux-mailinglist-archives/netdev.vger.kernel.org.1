Return-Path: <netdev+bounces-102267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0981902232
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654A91F214FB
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 12:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07BD81742;
	Mon, 10 Jun 2024 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o99VGThd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3641781728
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718024329; cv=none; b=S+c3uhPhtzx/lrHeo5n8JL2BUFLGsPZPr6UOjFKoIXjSaLrxZZyN13MI5NbC7R97jMnFctEj57+Po7KD0ltBrVtbyubI6oZ+SueK3nl3YAvOTLQAkRkysM0aUQkr1uVkORcq5BForLb7rkcPGEaSQTEMFhDXhQYnKBJ+XK0DXds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718024329; c=relaxed/simple;
	bh=69yZ/2KQxzDzZZIRemtwFN2dhIn84qTlZc+PTH2+QiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Porso8XpSy4dmTDWlzUYCH/7fQfQsXenvgNryY54TI87QAzIlL+oUkUKpKO3XPvx68Yrj1S5zpQSk3VpXXSVQvvz/KlRRM94wrrS8PlW/y/anM/rR0yuknjXNmet4F5oGnAaDUj02DeMNe0b/7NCXQH3wLJr1Gdm0jfallJ6AW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o99VGThd; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so5844108a12.0
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 05:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718024326; x=1718629126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KAUSKKQr31j0lfTllkRYhCjky92C69fh0mBqZOOmhtQ=;
        b=o99VGThdJeuGk0QU6HRTEiuKmSq+eEkka6C8Qas9tsQHprqiOJg1TShKz2lJqs+HNi
         gJLXFCxGkWB5WllaJwDGVwjsYj5qf8DaY+OmtVoCPSRUS3hDMGBNjzxQMDrrsyiTzsQh
         F/eFX3vp6VKQWIIg1XOJRUk1hsYtJQ8/AYlz5Yr0tNXseM3ghn/kwps8TNLmoHVdfpyj
         DWeWWRkyz/tIdDqMQ0Q4n0yGdvIIXiAIOb5fZVas05oIgx8ZDY0fIXhLsu6uCMGbHYnl
         QoTDGjQJvQ57GO9DvorFOYb1wMhDceBgQ5OahCJz2fy5F2wle+7ydLhXtxhdYjmwibKA
         zHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718024326; x=1718629126;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KAUSKKQr31j0lfTllkRYhCjky92C69fh0mBqZOOmhtQ=;
        b=TZGDVsyPTHl3KJ90EVI1zeZYZvoz9QBn5rHTWy8tKv8vr13WQBccn2Oa/19Mg9cpEp
         qeXmSdLwj6Jk90HJLUnxXNWADvz7yErOdo3jC13CuRgi8I7bc+AtJJW4AwySp+fa6DYf
         jnOMP/+f1POoTPYqJBig6q3t7ZTr/CbXiNVMNRUaj3w4aT413FV6ocorMSuLapVdhYoC
         W556xGXr/kvqkBYxLNqV7ay7bxnVqcFK2Kb1/pk6oKQr072izFkUSyCtm0JFFuL5jy04
         KpXIuJ9ZQgwJW2MXhz8SRJDXIszE+J8Iqtk393uvldNR+Of0J++feAT7j78RVdNBfi/B
         1Fbg==
X-Gm-Message-State: AOJu0YwAsXltPos/a623HwScgQ9AVSTSIR7mPhDLv67huU57U5BWDB3e
	l8CzDL2XqkWHEhHbXOu2uOlab0da8Q7Zr8zcrIG7nylotyAUUiIyA2eeLMnMrls=
X-Google-Smtp-Source: AGHT+IEF2KnAADfbdRtjjWnR2KUo3BAEuzWm3ctSGFFiz4WPn91BY12s9PEsAp3i8HayF5Tp6Xgw+g==
X-Received: by 2002:a50:9e6d:0:b0:579:fa8e:31a0 with SMTP id 4fb4d7f45d1cf-57aa5410e6bmr9682767a12.10.1718024326380;
        Mon, 10 Jun 2024 05:58:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae20238asm7451990a12.73.2024.06.10.05.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 05:58:45 -0700 (PDT)
Message-ID: <8256bca3-5175-4c0a-a3f0-6a9087efd0df@linaro.org>
Date: Mon, 10 Jun 2024 14:58:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ARM: multi_v7_defconfig: Add MCP23S08 pinctrl support
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
References: <20240610080604.291102-1-christophe.roullier@foss.st.com>
 <06703c03-e1ce-4a94-942d-b556c6084728@linaro.org>
 <ef4d2ebb-dd2a-423d-acd1-43fdb42c1896@foss.st.com>
 <e7f1ea08-41af-47e0-b478-652e67e5aebb@linaro.org>
 <ede482e3-58a1-4664-84b1-f80e59841e28@foss.st.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ede482e3-58a1-4664-84b1-f80e59841e28@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/06/2024 14:52, Christophe ROULLIER wrote:
> 
> On 6/10/24 14:27, Krzysztof Kozlowski wrote:
>> On 10/06/2024 10:14, Christophe ROULLIER wrote:
>>>>> @@ -469,6 +469,7 @@ CONFIG_SPI_XILINX=y
>>>>>    CONFIG_SPI_SPIDEV=y
>>>>>    CONFIG_SPMI=y
>>>>>    CONFIG_PINCTRL_AS3722=y
>>>>> +CONFIG_PINCTRL_MCP23S08=y
>>>> This is not an on-SoC pinctrl, so it should be module (=m).
>>> The stmmac is in built-in, if IO-Expander (MCP23S08) is on module, we
>>> have huge of message during kernel boot
>>>
>>> because stmmac driver is deferred several times. (need to wait that
>>> module are ready)
>> Which is normal and not a reason to change defconfig. It it was a
>> problem, you should solve it not in defconfig but in kernel. That's just
>> defconfig, an example, reference or debugging tool if you wish, so
>> fixing issue here is not a fix at all.
> Ok so it will not be possible to boot in NFS mode

Why? You need to fix your initrd, not change defconfig. We all work with
initrds and modules are not a problem at all.

Really, this is jut a defconfig, not a distro config! And even distro
config would make it a module...

Best regards,
Krzysztof


