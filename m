Return-Path: <netdev+bounces-168802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9301DA40C4D
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 01:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43EB189764E
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 00:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F9B2C80;
	Sun, 23 Feb 2025 00:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvnUf7WI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E27028F4;
	Sun, 23 Feb 2025 00:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740269104; cv=none; b=UhPHbpns5Q6zxRaY9euid7wcN+rKENIJuIkoUmhqPC8E29UbQj0YYIOR+OusyC08TiWTJiCtU2OFVip+FaGmHGGOf/TinMzF2bOxQCiNaEuo73ypot8jLkitOlUqcmfsY5T4LDoWq62Y2rqlLYkd9Bk3Y3PbseL41LUyLcciD/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740269104; c=relaxed/simple;
	bh=iQa1ObXyQxjI+iZzh2Mr6k6EEYIZLQ4cgXIILoHGPTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cK+BqsN518VP0uojOxLKg8yZx9CMDwgPe9YLvhEeOs41FyPSHHU4U2qwSWWHHFzni0FUR3xyLNnXATppZ8uGKvIB4h6r1qemPRtG8NDfcDCIESdpT/oTNRQJG+xgdARwQjCy5NhHzT7YnipJLpj2W6pgpHXuYZ2FzGKSt4xiQVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvnUf7WI; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fcc940bb14so4917935a91.3;
        Sat, 22 Feb 2025 16:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740269103; x=1740873903; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fbwym01OlWMMyR8DkeJp3JBsdqrcHXaCXVO+LJVGp6U=;
        b=bvnUf7WI9eYhq0ru3cMyiZLKdMDN5PkZUnjDDPyDibl6OSz5yhg9iKb48TmKvEpuh4
         TYK2X72nkYM9YfLQ0oPk6z1+m1bJp7f8WMdjoURBgoVJLa7lneFEdF8QFkcKHIzgny0h
         PV5U3mHAEyhGmD0HDIk4XvwcHvp4eX+A3RueuETrQ+6q0A2wmSWIJn20JFoM6H0CBNZ9
         nD9AC9aGwjmOgvUiiJSf0mVPKd2MuQQeEIxDo9npcjjQeBLtrlA2F6MOet7cmjs0ztNu
         SJcxVqbS96t5j2S2AMQUoeBOB+DXDObZxl5txoUco2EXqsLhTZEEGaEqt7LoKsiN2MFV
         2pNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740269103; x=1740873903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fbwym01OlWMMyR8DkeJp3JBsdqrcHXaCXVO+LJVGp6U=;
        b=JZDCnhdF05Gv6dS+cN/3hJ606ujTDNJUZUX/oR4v/ugA1P3ofu+aoZu4K9oCU2jg9w
         MeFbS5H9rVVF+rqnzoiBA8OBjdRBXjVda5LNCnm03y1ETXSo/NbnxK3EdxeflVu0b/CN
         od5rEd2bxDWQFxh8tVYzvG/1jsNwUM4onz3NS1Gpe/CIXGgT43HPAFmBZoOiAr6tjOCP
         xsp4pMrBQv29ogkB+scNxlpoydSoKoHhdsYPHUWi3IVCdt0xEq7vO5O8DCbYWjf/x485
         3bQWq8OuRU1ibAZ8SJCgw6DXS+KnOpilTjDJ9DFmJiBlhcUNBoaEdeSC8PKG1scDIt8m
         P2Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWVuCi05VeOutckpy4F6LRRf49lYgUfXsPLcuuatpnxyVtg2OxvTedfSlAghWu1vnvFRL9zA4PzPjGHc2o=@vger.kernel.org, AJvYcCWbPoQG2DrJf9dqesmDZfQdDKwJAlW2S56c0jbCqNlPE6HL8wvIq5zOATPTy2VHYOPtsrOUsq9i@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3TvO7OXAe5YDGElYHbyHO+dmL4dgI+WNLLuNsxGO9IK/IZ38r
	7A7Oa6slSXWGyPKYm9Hfr/MEq9eg1Hs2UclyTpp3wpW2yo9JLASl
X-Gm-Gg: ASbGnctainUBPBr63vJ+RIgSjG7TS9MF4rkqNui8qa+/XkRjOfT6EHDZ0XD+WmKSqiE
	Vp+gGrRGm1wv6bWzsKASr2A2Vkz5GBLR0KooQOnash8S5WsAzZa1MrhP9NTcK9ULxN+v5i/SzN1
	/UQn3VHSR9lMPpCaOkrOOcKGLLEwf3y+VDFfxSgQ/cfZb/C0CEwRlWtQVZ79d1irjhYT17mtp2n
	hCUpSTq7gH1zkDOB9muOPxSHl8itUTv1NOsDcIINJr4UU0J8oMY2AzzaGm1DmO7zFvylxHSb89N
	MoCpiX9QTsJILJCuq9NQuI7PC2udYy2VZOc=
X-Google-Smtp-Source: AGHT+IHuydOcu6J/Y5jLVq2RT8sD/5VqrMbcs9gfQESH05fEHdLbHrOPEDb+3BJDnnfuqORnoZxHQg==
X-Received: by 2002:a05:6a20:431a:b0:1ee:d515:c6e7 with SMTP id adf61e73a8af0-1eef3c56744mr14253298637.1.1740269102618;
        Sat, 22 Feb 2025 16:05:02 -0800 (PST)
Received: from [192.168.8.112] ([64.114.250.38])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb5a52aee0sm16388801a12.47.2025.02.22.16.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2025 16:05:02 -0800 (PST)
Message-ID: <d819144d-ce2f-4ea5-8bfb-83e341672da6@gmail.com>
Date: Sat, 22 Feb 2025 16:05:01 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] net: phy: bcm63xx: Enable internal GPHY on
 BCM63268
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, =?UTF-8?Q?Fern=C3=A1ndez_Rojas?=
 <noltari@gmail.com>, Jonas Gorski <jonas.gorski@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250218013653.229234-1-kylehendrydev@gmail.com>
 <47e20ea6-e5fb-44cf-810c-5fbe8d26abcb@broadcom.com>
Content-Language: en-US
From: Kyle Hendry <kylehendrydev@gmail.com>
In-Reply-To: <47e20ea6-e5fb-44cf-810c-5fbe8d26abcb@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-02-21 12:09, Florian Fainelli wrote:
>
>
> On 2/17/2025 5:36 PM, Kyle Hendry wrote:
>> Some BCM63268 bootloaders do not enable the internal PHYs by default.
>> This patch series adds a phy driver to set the registers required
>> for the gigabit PHY to work.
>>
>> Currently the PHY can't be detected until the b53 switch is initialized,
>> but this should be solvable through the device tree. I'm currently
>> investigating whether the the PHY needs the whole switch to be set up
>> or just specific clocks, etc.
>>
>> v2 changes:
>> - Remove changes to b53 dsa code and rework fix as a PHY driver
>> - Use a regmap for accessing GPHY control register
>> - Add documentaion for device tree changes
>
> I really preferred v1 to v2 which conveyed the special intent better 
> than going through layers and layers of abstraction here with limited 
> re-usability.
>
> At least with v2, the logic to toggle the IDDQ enable/disable remains 
> within the PHY driver which is a better location.


The next version should be much more simplified. I'm going to move
the syscon phandle to the actual phy node, so I think the device tree
documentation is going to need a new schema file for the phy. Who
should I list as the maintainer for the new binding?

Best regards,
Kyle


