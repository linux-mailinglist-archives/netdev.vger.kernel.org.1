Return-Path: <netdev+bounces-147508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF5C9D9E62
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 21:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E521F285771
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 20:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E781DDC35;
	Tue, 26 Nov 2024 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4M6vWf1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D17193419
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 20:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732652675; cv=none; b=fBW/ie2BEdvchZHbRd8ViH+H16yEkUa8lcU0lJ9N1MrTvgqBfa2MYM0+D3UNA6n0zwwWFbS7ZJZ9wNgt7SLirfp6XSNRGQkbCQbuQ/w8D9SJPJldQ11F3EqIghwslCUV+aP0ou7yqUuRzSsPE7q4mzeoBfWuOW9gi4ZoR/qSumk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732652675; c=relaxed/simple;
	bh=HUXvlmNBzTjB4ZYG5P2tgBNxEMxRtyos5V6r7uxYYFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nrpv6O17HjNnZTVhFNkiiT8/rrZ0gg8RIxRKzfo5aZ2ZT/gSUAQsatUXWJ1bTCwU2eUoNYS7ypXcVZywQ6zwx2EYWCITT66SE/VJq+S6ldyCM1Ig/Y6gT1XLUlHIbfuGPYKQ4iHWKgg6bbd0cHlf/ksGPAuNFr6qJc3jBqU1VDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4M6vWf1; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53deeb6d986so1013556e87.0
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 12:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732652672; x=1733257472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HCbQxBDGwoMQR+Ujqm6pGlRA4HnmMRyNgadk85WNZdc=;
        b=K4M6vWf114rohZ+5YV2r519ddGFa6Av504CcXOg+/BhSKp23JcDqbyiYCDYM4D+iGF
         P4CThFL1n831IoS5nXvIO+3ZxROVknwHfDwDirX/zKsnGnFHRBlnm3RNB0kkwJMr/cWw
         111x7RA6FAKM8w1K2EcD8W9ODZHT9rHA/esHMo55xnanwbZwWkqpWhHW9KWyqu83QDNb
         0kFSOUCVxD4zPT9jhQuH7STEyiKr/91ao9btUZYj5FI+Kqy6+2ms4D8bjC6VRZkd5KE7
         PpZAaxcbmX0TkUPrG5jSZTZX3pDdlxSctGaHXCP4SBb2vblTHogRnZCx6h2zwUtni/SV
         ZL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732652672; x=1733257472;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCbQxBDGwoMQR+Ujqm6pGlRA4HnmMRyNgadk85WNZdc=;
        b=YWpuVOja5Jol7roUrCb56OwC3S0CdfljmCD+rUtUX2R17N8LUlzTbTT6nBvorLFdGp
         1wIAIUGSwbCS4+lTXSadri6oYDHCJKWhsG+cJZAJLkIKQ22oDQiR621TERqmyL+s1Vy4
         IBEVO/YEi3XBCq6U8POkcwqflUD1atTXnJm22yBowBGYqeRkowTEayu7E9Ogq4e6cPGv
         HDSPCurEPhKh9xeCnnJ9IphFrkcxayBKpzLjXma5MwmxLN6DjB1JYQrkj77CNP5Vi7Mw
         myxDLnDCijYr3WFE/aGTVVKChiSzZNWFiJBgrMZTiqmw2ZdWDiYlFQ68mP/qhY2xz8Pa
         S+6A==
X-Forwarded-Encrypted: i=1; AJvYcCVKOff/qzxdqXgnjNFUDP0p67HFQkZ7XYDUP7nc8KRKxZHovrg22oW7nSZqhbRGCHyE0fROoQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4s9SbYE/Hj8XWlM+QoSES/GA85e+92rHNc+LLcyJdSZx5QQN4
	7qOj+FyacqmTcNSrfYuRt8oDGXP7v7jL53v0H60vDH1Q4TFau4Yv
X-Gm-Gg: ASbGncuOJjkUIGz0H3qiKALWh3V+VGShex7qtG1yj0IFfFS4vIU+i+3uKrYZWCrJYeQ
	3OJl83S9k0Vkp9c8BSRca/xJM7M32XI9BvCqVrX7iTdSCx61nC1ggLvq8naytB7/bCw4GDW6RP/
	H002OA83YBPwM6ynbS0aHanDFQ6W5OIbx0CylXWrWOtMqvFYXVNn8HG5TXyd6MY04gwi6BJhhzl
	CAmlj0u/0/Q3TOH27PaN2yomzl0Xrg6JoVKgvpivbtBcLDjN+/ZQO2CWEj4E16wlZZlVMv8ygwT
	nHmoo1sLNoT52RRO80gVxeNxzAJ4h8WFfTDkY1UrAZz7+EvUVbj8CGrL3tZC291J2cL4liV+6ua
	86087MrAFyBS/9xI3hrb0+uB4EoGSOBsXYqcHvdhDrw==
X-Google-Smtp-Source: AGHT+IEuYukIW1SzzFpdM0JiN5cbEMmlY2B1L0cx0Zr+6akBeltzj2q8qYuyGTdNxVhxgs1yNg6PuQ==
X-Received: by 2002:a05:6512:2395:b0:53d:dbc4:3b8f with SMTP id 2adb3069b0e04-53df00d1110mr236390e87.13.1732652671453;
        Tue, 26 Nov 2024 12:24:31 -0800 (PST)
Received: from ?IPV6:2a02:3100:b1b1:7000:f43f:954d:8ddd:f91b? (dynamic-2a02-3100-b1b1-7000-f43f-954d-8ddd-f91b.310.pool.telefonica.de. [2a02:3100:b1b1:7000:f43f:954d:8ddd:f91b])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa51759737dsm601261566b.81.2024.11.26.12.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 12:24:30 -0800 (PST)
Message-ID: <6df1ae83-32b8-4e0d-93b2-42eb2c47f1a7@gmail.com>
Date: Tue, 26 Nov 2024 21:24:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 05/23] net: phy: remove
 genphy_c45_eee_is_active()'s is_enabled arg
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Bryan Whitehead <bryan.whitehead@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Oleksij Rempel <o.rempel@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>,
 UNGLinuxDriver@microchip.com
References: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
 <E1tFv3U-005yhl-LJ@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <E1tFv3U-005yhl-LJ@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.11.2024 13:52, Russell King (Oracle) wrote:
> All callers to genphy_c45_eee_is_active() now pass NULL as the
> is_enabled argument, which means we never use the value computed
> in this function. Remove the argument and clean up this function.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Eventually we should be able to get rid also of the adv argument
and use phydev->advertising_eee only. Prerequisite is rework of
eee_broken_modes. I have patches which I'm testing locally
currently. This can be a follow-up to your series.

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>


