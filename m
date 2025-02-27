Return-Path: <netdev+bounces-170287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B17A480D9
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC4553A87DA
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C63C235BE2;
	Thu, 27 Feb 2025 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ANlyKDcz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFA5235348
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 14:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665907; cv=none; b=o7VKQDumybS//KPwRmzP9cnFA7OhylduRrDYB3lDNcZDUn3lKRnLP5yddF2934gYqvwlnixqRMqIPM7kyUcvLeAC6OiWPasa0EJTydICe5La4BzE5VFCeZH0zPXjFOD4/r8NbbrTQDhej2v8CMdwsttdspGmOiDQ5RJn6Teqftg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665907; c=relaxed/simple;
	bh=VLcO+K6nhbLhNSZ0n16zAOBERBengOOksjgBwK2wrV8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=n9tssTXETAjKjsX7TlHN4YC1duASB9i2U8hXkMPXziMkO2rctz7K0zvrLRUjB2akx3X/H3Gbe73KikC98/joeiSIUTTgilH0gNz/k2+l+3Ne/VKHVN/Nh1GoG0q2LrgYnnvkIYnV6wt/W4dWNjDb5jmvtNsSBKkLy/CHQMmtYzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ANlyKDcz; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-439ac3216dcso7118445e9.1
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 06:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740665903; x=1741270703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3KjmgTTmGKnNMLEkQ2tYRKgEmMShvtFLmbhC7J1ZseQ=;
        b=ANlyKDcze0VHBAf2a/p9W1obJzG0dAfLcIWjO4s/hhzCNQsbLhuAc7E5eI4sRKLTVi
         eE5fk/6oCci1XoGWGB+SQULZJx3gfbzFM31FSs5J26hVI6Wdp0GguBeUqPGMuMPx8XYA
         PCIxJCpiwfnd+WB1sa+pXJ3zQl7X60LNgoIcx8u4KitTkT+fjlhWdl7w9ju5XHk85TAv
         CCOg11c0sl9wHI81SABO22ymtNXSBHj1RTRwNery4qB+DvOpPoEDIwri7nSBW8L/0rR7
         VrSq3UYa9RSKytASafOEKkASDFqZ8ngUdQc4IiIAr5R6VTYVYdkVVNx/QaM+R5gAW1cZ
         2SJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740665903; x=1741270703;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3KjmgTTmGKnNMLEkQ2tYRKgEmMShvtFLmbhC7J1ZseQ=;
        b=YSpOtgAP8L5ywtX4pvQ61oYXHmOYnjJuZtdS8btPmtj5rrhb+Lo6yf7pfP8TTUgYGn
         jxA9YTbCZfG+dj/FOgZlYUmK2FStsjZj97n3u7uta9DFbfEcISsKW8Hx7qsmAYTxaTmM
         Vn8S72bLBkAYXbEedkWfOEoQMdtS6VQO8qPCwyGek3vGOqn5DRQpVWzCEeHBVOKvLMv+
         tFBl+eK/o/pFDJ2u4T4o1vs3hYAIMhyoF5DZD5uJIvq0TyWWX7zRAQGEzBDdr7N+mduU
         H65zIZxzIsqYA7pmW9KAJJNXgVCFiW1n0LOGTvRgp+zv+PI9vO2rSzaOx07bJE8pfgAn
         appA==
X-Forwarded-Encrypted: i=1; AJvYcCVqX77iX3xWeFiFD3qNFiYodZvB5LrCzonUWRdBpSDoXU9cImSMxxVuNvp6uboUdY73DSL3Y1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHMqtHISwh443flGglvXPpeNKE+ZbtwC41kFRIOH5q3rvnOSkr
	E8YA36pxYEYZYz3O9ro/PcQu1RlIUsE68PQkyuOL+NQ5efwcF+v9ye7OU4+jZSc=
X-Gm-Gg: ASbGncvADIrGtKB8JXq6vhScfGQnT3xg3GZaVxXkriFx5+WeFMc3Tvr0GDdpBx8lcSq
	OyMydbXKaB8CkA6zIBRKa19PsYJjGFBc18ZJVNuQSyPfIWsvGDe6X8P/tGNgtszgahXadNmHmzb
	DpmalsGhKVYt9Enl9rlmgjB2edmWEe7Zf3vh3EkfcUFf1jFQOw9Z4Nyz2axTc+mOeM4ZxArBpJZ
	kgfZmVhGxnD0/mcJcKpr5OibG/2VAFv2B9yf3E6XTDPmhAHdVodyxSIoyW4MoFg4BNfSnq3YN2K
	gza7imRbZi9RDJspz01Txij4N7SHf4PnWi7JU6plrJba5sNT7P8cxAh5xgvAXaD4s6AEdspjOLr
	ZlqA=
X-Google-Smtp-Source: AGHT+IFcL1gSMJCTCnZcd6HJw2zwybdNPIHKIrsiUSeI2jk/mbKwBJYRWGcu2yQ2deoYklOEQz/emw==
X-Received: by 2002:a05:600c:4e50:b0:439:8653:20bb with SMTP id 5b1f17b1804b1-439b2b06189mr248030835e9.14.1740665903502;
        Thu, 27 Feb 2025 06:18:23 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:c5de:e7f3:73c7:7958? ([2a01:e0a:982:cbb0:c5de:e7f3:73c7:7958])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5870e7sm59261405e9.35.2025.02.27.06.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 06:18:23 -0800 (PST)
Message-ID: <2198e689-ed38-4842-9964-dca42468088a@linaro.org>
Date: Thu, 27 Feb 2025 15:18:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH net-next 10/11] net: stmmac: meson: switch to use
 set_clk_tx_rate() hook
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jerome Brunet <jbrunet@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
 <E1tna0z-0052tN-O1@rmk-PC.armlinux.org.uk>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <E1tna0z-0052tN-O1@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 27/02/2025 10:17, Russell King (Oracle) wrote:
> Switch from using the fix_mac_speed() hook to set_clk_tx_rate() to
> manage the transmit clock.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>   drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
> index b115b7873cef..07c504d07604 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
> @@ -22,9 +22,10 @@ struct meson_dwmac {
>   	void __iomem	*reg;
>   };
>   
> -static void meson6_dwmac_fix_mac_speed(void *priv, int speed, unsigned int mode)
> +static int meson6_dwmac_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
> +					phy_interface_t interface, int speed)

You can keep priv as first argument name and remove the next changes

Neil

>   {
> -	struct meson_dwmac *dwmac = priv;
> +	struct meson_dwmac *dwmac = bsp_priv;
>   	unsigned int val;
>   
>   	val = readl(dwmac->reg);
> @@ -39,6 +40,8 @@ static void meson6_dwmac_fix_mac_speed(void *priv, int speed, unsigned int mode)
>   	}
>   
>   	writel(val, dwmac->reg);
> +
> +	return 0;
>   }
>   
>   static int meson6_dwmac_probe(struct platform_device *pdev)
> @@ -65,7 +68,7 @@ static int meson6_dwmac_probe(struct platform_device *pdev)
>   		return PTR_ERR(dwmac->reg);
>   
>   	plat_dat->bsp_priv = dwmac;
> -	plat_dat->fix_mac_speed = meson6_dwmac_fix_mac_speed;
> +	plat_dat->set_clk_tx_rate = meson6_dwmac_set_clk_tx_rate;
>   
>   	return stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
>   }


