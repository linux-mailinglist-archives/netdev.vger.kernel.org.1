Return-Path: <netdev+bounces-211155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7444EB16F68
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 12:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C57620ACD
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 10:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C22238C25;
	Thu, 31 Jul 2025 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRhXYuTE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBBE1F8690
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753957418; cv=none; b=sUSk/gD4ngxO2iRmak5diYl8tYuILLd5VJOJJNVTwVELg2mnRDIUA88YM0nlPoqTzNVXp2l3M1UsTfq5MQFKTMO091hWmDw1fei79zCsOkExk6fsOdPbdw20K7n++OJsgI97aDfmalZfpr4iOraRBif5WRJ3T8zWDKEtT4IENGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753957418; c=relaxed/simple;
	bh=OZJupqmfNutLzJvWMk6UxQiibJ5u+xCp/pm0Vn/66I8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TflH5AhiPTJ4KQK0el0bN/N3D+POcODD3BuFVW6Yb6wxZhIjAocW4E5X9/BzXYiqGb/jR3pzhn032IYiGawjabWBisdPBUb34oc04kivkT0xPgb/ByZQN6bk9hEpPka1enanrHqw49eMNdxW2M2Kyrl5EBthjg68JUA6sNOlVZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRhXYuTE; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b7848df30cso1083566f8f.0
        for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 03:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753957415; x=1754562215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AbUqALQf27Kng4t5VCFQPqOR/4qQ1rjeoOrkEGorRt4=;
        b=FRhXYuTEMy3Dqv/D98qgOy/V0RPrdUg6n5MEelzWOtDaNxZ0H0hK0ca2rdyUoE98ig
         wGua7kDBofxc+fGP47vH8gh9WxqGY5bsKJmq4n6ui2Ivy888PqE3/KLq4MUzaFlbuQP4
         xqfvKnZ0Nlz1eGOxtb10IYFxJpimzVcjzlLWcLDvQrX5KZtHp5kXeitF9+96FcmUhcNN
         FA9fCUhKjJ+BDXZikBtAOLXNVstzkV5qxT9wjxJ2Mq9pmMSo41IxjUlxjWCqmcH/lK0P
         1UtfB2R1j2m0w0r6E2BKw7qS8GrGsv765+bC1uyPvN5nOXRDm4jc4AoucrvYhBQovI/b
         dH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753957415; x=1754562215;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AbUqALQf27Kng4t5VCFQPqOR/4qQ1rjeoOrkEGorRt4=;
        b=erTrfPdbTwc0eLV6t5gqRF7v5NqmEo3QpZENOSlsg9GETsexMSWw4nFRk1WEvfoO3W
         hZ5UO89DEOv3eZx/1kHvDYh3wNuZ5o3R3WLXhXLaifKUDz64bCd34geINgkpA9UEWNsQ
         VYayqq3D6w8OMnkiy31ztfxNlxl+X1TexZ0zkt07vjR60r/FDrpok93b/ym2a/5IPyf2
         qKCqSkRHd0fDujaUs4+/Fwp1gkFKrH5VBJqRDKm5jxrYaH8Dj8STsEOwURXR3i2R16k5
         ItMwkoA1kwFlK24Q3TcrJrtifQx9MtttqnSyPXgbgzKLa3oQsaL88tDt6vIUaMRjnrXA
         6HGA==
X-Forwarded-Encrypted: i=1; AJvYcCXAZxjTs38DDUEO20N0uxIQKCMhQw1y4413rTqHtcmmMpO9FC1gPr0VL0FdOugxV0BSvucFh/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmhC8VXQqj9yuAn73VjpQylch6lec6ky9ZHHTaoaTjUSPRDUK+
	2TitMNWWfoBI+/o99YgJWkuDydXeP0PcEhHq1SkLuqVuQAtd6ZKdCCMB
X-Gm-Gg: ASbGnctvB/YcZVLXTvjYg4israf5zep5rhoWTRtMTJE1MjL2AbSgUsZ70V9cVQRPxl/
	19HuvQTSXmUnSqA7C/cwQGQYmDqAmMsav29rwEUanBdWfrfjvYK6XNh0ZQ99nChGX63dw23Svyi
	quTFXAVWZEohoOiwYXs48axhjQ0Gs307DRi9f7IBqqMq+awMrBxsjSnxFxWSSoBs9uFp86hJ9I7
	WSMlzcapOLIHaXNyvrJe9DhZge+bulee917kKafBHQIAxwc9bDKDQbr+RE0qFJrgMo88IainZv5
	+GDrqk9+eb8Oaq++OLlSE+oMH2X2iORA9E0VcyBs9NrjNOP4nLPSXjWDlmknd9lwGx3klawpTPS
	tEXStdGt52tKni4JEWO8telv32Y9RbOxpsOnGf76zzDS0TFUOVF8QEPyFB+XDEoB8jimIqwXLYQ
	h18qO3NMJm0ADjHtY8bHzbrAVK0FU1/K/OWh15Gk9YUx6BI5/hCgsqumJai4CWlA==
X-Google-Smtp-Source: AGHT+IEHgP5oVf0qlHabuZzfOlcDB7jnD6aKgOJPRaVWfBlqe7F3UGOkFXRyxz28sLyS9W1EmI4RqA==
X-Received: by 2002:a05:6000:430b:b0:3b4:9ade:4e8a with SMTP id ffacd0b85a97d-3b79d4e0b4bmr1360461f8f.21.1753957414546;
        Thu, 31 Jul 2025 03:23:34 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f46:f500:690f:3743:82cd:abe4? (p200300ea8f46f500690f374382cdabe4.dip0.t-ipconnect.de. [2003:ea:8f46:f500:690f:3743:82cd:abe4])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b79c3c33fesm1969388f8f.29.2025.07.31.03.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 03:23:34 -0700 (PDT)
Message-ID: <d0e1c087-f701-402e-b842-3444fbce7f27@gmail.com>
Date: Thu, 31 Jul 2025 12:25:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: phy: realtek: convert RTL8226-CG to c45 only
To: Markus Stockhausen <markus.stockhausen@gmx.de>, andrew@lunn.ch,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, michael@fossekall.de,
 daniel@makrotopia.org, netdev@vger.kernel.org, jan@3e8.eu
References: <20250731054445.580474-1-markus.stockhausen@gmx.de>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250731054445.580474-1-markus.stockhausen@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31.07.2025 07:44, Markus Stockhausen wrote:
> The RTL8226-CG can be found on devices like the Zyxel XGS1210-12. These
> are driven by a Realtek RTL9302B SoC that has phy hardware polling
> in the background. One must decide if a port is polled via c22 or c45.
> Additionally the hardware disables MMD access in c22 mode. For reference

For my understanding: Which hardware disables c22 MMD access on RTL8226 how?
RTL930x configures RTL8226 in a way that is doesn't accept c45 over c22
any longer?

> see mdio-realtek-rtl9300 driver. As this PHY is mostly used in Realtek
> switches Convert the phy to a c45-only function set.
> 
> Because of these limitations the RTL8226 is not working at all in the
> current switches. A "hacked" bus that toggles the mode for each c22/c45
> access was used to get a "before status". But that is slow and producec
> wrong results in the MAC polling status registers.
> 
> The RTL8226 seems to support proper MDIO_PMA_EXTABLE flags. So
> genphy_c45_pma_read_abilities() can conveniently call
> genphy_c45_pma_read_ext_abilities() and 10/100/1000 is populated right.
> 
> Outputs before:
> 
> Settings for lan9:
>         Supported ports: [ TP MII ]
>         Supported link modes:   10baseT/Half 10baseT/Full
>                                 100baseT/Half 100baseT/Full
>                                 1000baseT/Full
>                                 2500baseT/Full
>         Supported pause frame use: Symmetric Receive-only
>         Supports auto-negotiation: Yes
>         Supported FEC modes: Not reported
>         Advertised link modes:  10baseT/Half 10baseT/Full
>                                 100baseT/Half 100baseT/Full
>                                 1000baseT/Full
>                                 2500baseT/Full
>         Advertised pause frame use: Symmetric Receive-only
>         Advertised auto-negotiation: Yes
>         Advertised FEC modes: Not reported
>         Speed: Unknown!
>         Duplex: Unknown! (255)
>         Port: Twisted Pair
>         PHYAD: 24
>         Transceiver: external
>         Auto-negotiation: on
>         MDI-X: Unknown
>         Supports Wake-on: d
>         Wake-on: d
>         Link detected: no
> 
> Outputs with this commit:
> 
> Settings for lan9:
>         Supported ports: [ TP ]
>         Supported link modes:   10baseT/Half 10baseT/Full
>                                 100baseT/Half 100baseT/Full
>                                 1000baseT/Full
>                                 2500baseT/Full
>         Supported pause frame use: Symmetric Receive-only
>         Supports auto-negotiation: Yes
>         Supported FEC modes: Not reported
>         Advertised link modes:  10baseT/Half 10baseT/Full
>                                 100baseT/Half 100baseT/Full
>                                 1000baseT/Full
>                                 2500baseT/Full
>         Advertised pause frame use: Symmetric Receive-only
>         Advertised auto-negotiation: Yes
>         Advertised FEC modes: Not reported
>         Speed: Unknown!
>         Duplex: Unknown! (255)
>         Port: Twisted Pair
>         PHYAD: 24
>         Transceiver: external
>         Auto-negotiation: on
>         MDI-X: Unknown
>         Supports Wake-on: d
>         Wake-on: d
>         Link detected: no
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
> ---
> Changes in v2:
> - Added before/after status in commit message
> 
> ---
>  drivers/net/phy/realtek/realtek_main.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index dd0d675149ad..8bc68b31cd31 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -1280,6 +1280,21 @@ static int rtl822x_c45_read_status(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static int rtl822x_c45_soft_reset(struct phy_device *phydev)
> +{
> +	int ret, val;
> +
> +	ret = phy_modify_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_CTRL1,
> +			     MDIO_CTRL1_RESET, MDIO_CTRL1_RESET);
> +	if (ret < 0)
> +		return ret;
> +
> +	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_PMAPMD,
> +					 MDIO_CTRL1, val,
> +					 !(val & MDIO_CTRL1_RESET),
> +					 5000, 100000, true);
> +}
> +
>  static int rtl822xb_c45_read_status(struct phy_device *phydev)
>  {
>  	int ret;
> @@ -1675,11 +1690,12 @@ static struct phy_driver realtek_drvs[] = {
>  	}, {
>  		PHY_ID_MATCH_EXACT(0x001cc838),
>  		.name           = "RTL8226-CG 2.5Gbps PHY",
> -		.get_features   = rtl822x_get_features,
> -		.config_aneg    = rtl822x_config_aneg,
> -		.read_status    = rtl822x_read_status,
> -		.suspend        = genphy_suspend,
> -		.resume         = rtlgen_resume,
> +		.soft_reset     = rtl822x_c45_soft_reset,
> +		.get_features   = rtl822x_c45_get_features,
> +		.config_aneg    = rtl822x_c45_config_aneg,
> +		.read_status    = rtl822x_c45_read_status,
> +		.suspend        = genphy_c45_pma_suspend,
> +		.resume         = rtlgen_c45_resume,
>  		.read_page      = rtl821x_read_page,
>  		.write_page     = rtl821x_write_page,
>  	}, {


