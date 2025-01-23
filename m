Return-Path: <netdev+bounces-160647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9ACA1AAFF
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 21:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E1E87A5B49
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 20:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0F71CAA71;
	Thu, 23 Jan 2025 20:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqN3OAcb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4951ADC93;
	Thu, 23 Jan 2025 20:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663167; cv=none; b=TCsIlRxlWIeVAghK2Mkn2dk/ywkcGv+jDjdiBSrDOt+jeEq66OQ/XxACTHRDDPUrSbn/QRvjUhPa1xCTqqZa0GXWqt9THXFZN8W79BB+fEY0m8LVIhydMX/lT8f+gWuL5G7cU8x9IjyTtgAgH5UYw1GOqF2W+21QLVMjQsgYjfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663167; c=relaxed/simple;
	bh=B1LHUO3zYClo5ksgOyKda8c9QCHsh5DjVwkpNybr5O0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0cSBtEiExE9qmBQ8fb+hEdXZRu3CUvqdTsz+MGTP7lY5MTV7RyDRdiR6AVJCJUfAy69sKu03X/xou0bCT9N05P7GOTygRI+wPSMhHBsXusD/W6ZzhPgYjU/pyb3bOasytCrD14i8AgeuXROcw9Mv10HoHoMriNaW90KSPtt4nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqN3OAcb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43618283d48so9997365e9.1;
        Thu, 23 Jan 2025 12:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737663164; x=1738267964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7g26L3OpZPUWDV/T/02qWWnNF1HR/ojEGYaaiba9AXg=;
        b=jqN3OAcbt7E1yWV+RH4Fg+NM9dg4gfzkmqcUMhGIespKSMMwP4eB3TgAovV8VJ/Yof
         T/J42rIpklLXiY9pwnYvCU4twTu3ciz8hB1gJVxLt39SVoYj9AuL9Uj/tLJFVv43kcm3
         6PjlreNN7tSYjtn1hOamrKCRaefrKbAmwV/C8jVOUoDSLQU7iwgcQP5qOvRtnfM63Mwx
         tiXS73ngKxHQcXbd7TK1JkgP1tvhAL5jPfq4oS8DO3ISFe2/nV6GQR6Q75xibJqYP7F1
         CJOzGXH8h7F4fiEbHyQK8nTh+DW05ZdjpaHT5/SPFa0exsYG05OaOqCUyJboZbM3NqG6
         rGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737663164; x=1738267964;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7g26L3OpZPUWDV/T/02qWWnNF1HR/ojEGYaaiba9AXg=;
        b=vWJPf6qxGBzULiifj6Hpe+UZrucy2PiIibXMjhx95+w3eFaGdowYDT88rWLfqzJFps
         Ghb9j6+u0q0KQuWDo0Q+3ykNay3HyctODpMWwu39oGm1Vb6QDya1HiBKUQ/I4Yx5L+1A
         fR3Bta65Uc1Tb7z3pjP8LgpHbTJGAa11tJNv/OoBbZc8Z+/ADGFegq4Hh5P9l12LtfTa
         i/bR3nv4TOD1hVAhn2xcoQRlRapx2dOR0cdERm9QQ1aCjom/WCy3rnJ0y2z/MuiwTFQ7
         0e9AuPwIKQbnPzCUKZITvDpJ95QL4/Jac4PJiLp2UEXksyWaj5XScp9jtiaB2P91i7Yd
         qpBw==
X-Forwarded-Encrypted: i=1; AJvYcCUAFbFBANJd/oPCVZQ0idoZuJ/UInujXFs2/7n+eWF3EE54N35DsFRO5l4MTQnDIlknNc0vKaQa@vger.kernel.org, AJvYcCWL3E/PnzNZ/IPLVB0S4zMAbaH2vhTfveiVs2oNXHCMLXNGyt3KkEgxnwc7KbaiBA3JF8MkwYYRvpqqxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywceu+0NKeV8GHa2/xuFkvZs5RManIj/nA6h6LYAyjo7A+qoP1t
	gatERvZq6YVVTJHFltlIDS3oz/4DK9iVKQ+0LasVUae8/7iDs5dr
X-Gm-Gg: ASbGncve6NgtK9FGle8jgGYAlAOucKklHLpoUcCNxkSRtxbBHTYz/9CzUZcDTyljLi2
	CMUpS+NeZS7Ip4zjmXhzYGKJVuf1NduMqdnXVFbona6EBTjb+ab8tl6bkFs+7T5twAmkErlQPd4
	a/MXDX6jyJNFo2dB59YREljZzdCo2yC6i10krCtZDj+mQSiwyixZZFvYPlid0gkLzkUYtx5Yoiu
	E+y75/47tj34YPkB30+vYu4MMPB0JRXQI7axvWC5kMBQlgJ66ZYZvC/SwIXrqeWXA5Px8FYxTKA
	Q0dsaVYEdwPPsCKW2srS43NK64hwohET+XY8fuqKK47Gumb16NR4is9I1qjxJenIL9txXvpZ/EU
	RIzD1VukkaVwbfX2qVSuFq3GyCERvTtQ30p+67SW8lEC0BgYbfyJ7G+T18tZFFLuY/vyq6Q==
X-Google-Smtp-Source: AGHT+IFoDFdkcvZ6QsLGyyw3+/bw3qef054fhUB/C5/Gl2aTxlaLgmR3EuMkeCy70zzQ4dAIummE8w==
X-Received: by 2002:a5d:6d86:0:b0:385:df6b:7ef6 with SMTP id ffacd0b85a97d-38bf57c94a2mr31897211f8f.51.1737663163929;
        Thu, 23 Jan 2025 12:12:43 -0800 (PST)
Received: from ?IPV6:2a02:3100:9d43:b700:353f:46b:6707:f35d? (dynamic-2a02-3100-9d43-b700-353f-046b-6707-f35d.310.pool.telefonica.de. [2a02:3100:9d43:b700:353f:46b:6707:f35d])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38c2a1bb0c9sm591444f8f.78.2025.01.23.12.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 12:12:42 -0800 (PST)
Message-ID: <9baf12f2-1e15-4a94-96df-0016379f1d9a@gmail.com>
Date: Thu, 23 Jan 2025 21:12:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] net: phy: realtek: add hwmon support for
 temp sensor on RTL822x
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, linux-hwmon@vger.kernel.org
References: <7319d8f9-2d6f-4522-92e8-a8a4990042fb@gmail.com>
 <ad6bfe9f-6375-4a00-84b4-bfb38a21bd71@gmail.com>
 <a8da8aaf-adba-dbc4-3456-faae86eccd1e@linux-m68k.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <a8da8aaf-adba-dbc4-3456-faae86eccd1e@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21.01.2025 17:10, Geert Uytterhoeven wrote:
>     Hi Heiner,
> 
> CC hwmon
> 
> On Sat, 11 Jan 2025, Heiner Kallweit wrote:
>> This adds hwmon support for the temperature sensor on RTL822x.
>> It's available on the standalone versions of the PHY's, and on
>> the integrated PHY's in RTL8125B/RTL8125D/RTL8126.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> Thanks for your patch, which is now commit 33700ca45b7d2e16
> ("net: phy: realtek: add hwmon support for temp sensor on
> RTL822x") in net-next.
> 
>> --- a/drivers/net/phy/realtek/Kconfig
>> +++ b/drivers/net/phy/realtek/Kconfig
>> @@ -3,3 +3,9 @@ config REALTEK_PHY
>>     tristate "Realtek PHYs"
>>     help
>>       Currently supports RTL821x/RTL822x and fast ethernet PHYs
>> +
>> +config REALTEK_PHY_HWMON
>> +    def_bool REALTEK_PHY && HWMON
>> +    depends on !(REALTEK_PHY=y && HWMON=m)
>> +    help
>> +      Optional hwmon support for the temperature sensor
> 
> So this is optional, but as the symbol is invisible, it cannot be
> disabled by the user. Is that intentional?
> 
Well, it isn't intentional in either direction.
Thanks for the hint, I should make it user-visible.

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 


