Return-Path: <netdev+bounces-230600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8626BEBC59
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 22:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C48F4FB4B6
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 20:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2979F2877D0;
	Fri, 17 Oct 2025 20:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gr+2T7sB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9891B285CBA
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734542; cv=none; b=X8jfUi1aKgzlt3dsVcRjQF3shskco6oARIDytVCGrouTyjm3FMwZp6fo4DnxhB6spssIhkXDZAcDO284b2EfpDfbdbGHUYHJ7lD7QmGXy2yNE6YPmJK2NJ/kjMlJJuwF7KPO0c1I18KUI/vl5tNaYVzvhPnMW8WyFLB1REUh6u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734542; c=relaxed/simple;
	bh=WbLlz1QI+Bx/hTIUUSkaxfzIQZBGVXbij4yWak11LFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BbbJnl4or6YU2QivdfC+MTmX8j7w5SDOC0qMzufSym0YS7zG6lmiC9ckBsM+wE/qJbxrsAXJkvQ035qHFfrEGIpwMkQ1BBOCXscldp4x31GTUxYG0rjghutuLQjIozr1dhtBCgMXpYy2WaR/negPkAsk98rM3FuZeLAsFK3IcbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gr+2T7sB; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-290a3a4c7ecso25182315ad.0
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 13:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760734540; x=1761339340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+TRePVye02MkBKNW7rT2/MX8l8KpCSpKH8ASnz0eNhA=;
        b=Gr+2T7sBVZ/cmTRM2gdqcCUryPhBF3EApH6ggudfdfenrhJ6tGmep7ROCs6e8whKNP
         zKPxJATtgSDbZdFu3PqaJEnYyJkS7iNmucDlljrseYdGWaZxV94HpPobNLohgmDgFmbp
         w3fYW7hlrj4+I3G/YmkeMyvhiqNF+XpLrxU6GIWBfxkrYzB/P1DmEuUTi8xZLJun6t1n
         msBwRAPu7q7LLuNE7IH6a2Zv0EQb3fDfMBlqzLHBmU1lHMjrZhWY44GyFst6w9I+8pnp
         xKnAZ6RzaEUkSBg9/geUple29LAWfk2N+hYzKJ4XWQd/yU7lBP2K3+DiW3d07Qz0wEgX
         sNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760734540; x=1761339340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+TRePVye02MkBKNW7rT2/MX8l8KpCSpKH8ASnz0eNhA=;
        b=Uv8RF6J6j8Gy/b97Uw1T67eMuKqG6jsRVcuTQzVvmKCGjdi1Z6Ge/3WFfO1p8L1XRU
         LwCWOEeqVoY0z04ZhJL7dILb9ZMx4SPKemMUpXEbfyNWhRVa65RegLUO17FetQCMQaKV
         DTyS7TU3spGLzPksNBwzDO54A6EQ6MIQWONbRV8tRYQXX16JgONoqSUVaYOof9RSftcQ
         t+umfkixo9hNGZzdt0avc0UbwvwFKbCZiPuVv/Cf2+i9JQrlBXG6Eov5yGuv7J5lv/ra
         8hHFD2fPHSZNICwghy3Z0zZP7VRR31nD+krXROroyXSCb4nTweym4MDYCLOvWJxLpFYz
         pamQ==
X-Gm-Message-State: AOJu0YzWcLsMhcWxVE6G321iEg1dJ6eGGX1YBcRSyp0757/OXOw4Nz8t
	B2ur5o72IFZCj7zaJauHzyHBMPQlk0WYPHrDCHKqwSSQ+b1JjvT6ml34
X-Gm-Gg: ASbGncu1CxqAY1qnzkhbw4A/VKXtHYorpaWfRQvr4lbs78/pd+ZtJuzOLIehKDUK6zn
	DUUvCfESqx6yk9yUOSdU6sHgW8e+BZOEgJyvjk8Lx6LQLrPIK1xJDwhGSwMisrYNG2pUjp0ZLxO
	J3px7fCglnbNV5zqbJFmO3LoC2aBMh7DHPVyOa0fS3UF/YMv2+QSinXNkhIVAdr8wW7znq6Xh4q
	wRrd0v9MGpPgJDvWfFY3NiXo/Gx/yGmzPDdvubMzLXHNN9Li3us8lNVKBL9ZG54QgQOIFgA0+VY
	CFyyc0jSs7FCy1naR/WBrsfJVzDPVAzxiVdwiHIgy4Rl3ym6zUEOayzBiMQP0tA++3Pijl2nnMP
	FZ7HEAXZE3DGpNS24OBFQvk2xN2j+/n4b9g8ZbWIiBhLNGruIdb3d064Il/Xjr/ytgntwWE8DZ9
	vu+czQC5Shb6EasHgskXWa7up4xPA+vmDBJXEQLw==
X-Google-Smtp-Source: AGHT+IEQgBKJwx4Mcpdi5xYqdE8S8rDeCCw3Q0wX7yQ1gQbN/he5E+YAEwSO493C3Ed7/xBGabaYxQ==
X-Received: by 2002:a17:902:ef4c:b0:290:7803:9e8 with SMTP id d9443c01a7336-290cb659d58mr54267075ad.48.1760734539753;
        Fri, 17 Oct 2025 13:55:39 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fe2cdsm4331045ad.95.2025.10.17.13.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 13:55:39 -0700 (PDT)
Message-ID: <c7191096-963d-4436-bc63-8ccad2c5a002@gmail.com>
Date: Fri, 17 Oct 2025 13:55:38 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: phy: fixed_phy: add helper
 fixed_phy_register_100fd
To: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Vladimir Oltean <olteanv@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <d6598983-83b1-4e1c-b621-8976520869c7@gmail.com>
 <e920afc9-ec29-4bc8-850b-0a35042fea12@gmail.com>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <e920afc9-ec29-4bc8-850b-0a35042fea12@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/25 13:12, Heiner Kallweit wrote:
> In few places a 100FD fixed PHY is used. Create a helper so that users
> don't have to define the struct fixed_phy_status.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>   drivers/net/phy/fixed_phy.c | 12 ++++++++++++
>   include/linux/phy_fixed.h   |  6 ++++++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
> index 0e1b28f06..bdc3a4bff 100644
> --- a/drivers/net/phy/fixed_phy.c
> +++ b/drivers/net/phy/fixed_phy.c
> @@ -227,6 +227,18 @@ struct phy_device *fixed_phy_register(const struct fixed_phy_status *status,
>   }
>   EXPORT_SYMBOL_GPL(fixed_phy_register);
>   
> +struct phy_device *fixed_phy_register_100fd(void)
> +{
> +	static const struct fixed_phy_status status = {
> +		.link	= 1,
> +		.speed	= SPEED_100,
> +		.duplex	= DUPLEX_FULL,
> +	};
> +
> +	return fixed_phy_register(&status, NULL);
> +}
> +EXPORT_SYMBOL_GPL(fixed_phy_register_100fd);

Would not you want this to be a static inline helper directly?
-- 
Florian

