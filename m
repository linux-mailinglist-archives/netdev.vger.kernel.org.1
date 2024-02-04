Return-Path: <netdev+bounces-68968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58555848F5D
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 17:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC4D9B22921
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 16:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C183822F0D;
	Sun,  4 Feb 2024 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zs/38Xq/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D218F225A4
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707064551; cv=none; b=rwRUAxltCTddQq9Lzar72364WO2ZRmnrv9PdLcfagDZLz7ZxdG2C63v78YhH7EVJffAMGrgJuwaujC2gLFI9ahFAa0NJjbt4BySYaAFno15XjA8oLCnF0uJRr9z2bGPdN55eHu6rXkCSFInUHR07i6ABBN8nr7NcnWXMrwHTx7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707064551; c=relaxed/simple;
	bh=o99G1LKVCBTiG0Eduu98qhZMq512+ji4tKF1rAK9Ezs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gevYVPRba39hgewvhEyxQCs4enRerMfju1how8F8sKoBeQVUNf7YGLttqcWWH0M8Slz1XLKf/Q/Q79norlfgdSyfyRvE5SB4+aWvGLkJ6amIvmsnrLFxr6O7z8F+vUo1rqZexZFE5uyhXazQEDEBPzHGOEw+/farb3liCbuBPeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zs/38Xq/; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a28a6cef709so499877366b.1
        for <netdev@vger.kernel.org>; Sun, 04 Feb 2024 08:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707064548; x=1707669348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3KejOuTcbLvZi+rQMDC5QUFjwWZNBNRldH++dCz9dI=;
        b=Zs/38Xq/sKPYDWVYHWHQx+qeneq1PbK+XAdpUuY/l6vS3Kx843lOOu8Ymrh5MwyIlY
         YXx1h6wVWCqRuUEKW9oVLSVJsklyWHG8lBmoijiVZUQP8HQSVwiFdJOiYgqVk5Hysb2P
         V9LSPDq85HiLiXGxHVRB69fB1nBclFfxC8xgCaFGgcwUccNvimjkQhFukyN24rPSq0cy
         +00XFuUr1vUWVRs5zkmEDKL1ypfb8B+G9uIABemoaS1lv/3gRA965YmWjpCP4l3jDHmI
         8kdyvlQMsqUurthXAaJLXwe8A7KkE/lHF/piGHxWePDhdioUBWzTYcWrHxdG8dDPT+HS
         Q0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707064548; x=1707669348;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3KejOuTcbLvZi+rQMDC5QUFjwWZNBNRldH++dCz9dI=;
        b=bg2N0t6Ld0guchpvmHjGCfvAtnFsRU5Hb5l0nRlJI/JEMWln793AfwlH2I5A0lqKqv
         Sb6sCgUq8dkivo+pYiIHS9s2l7a2ElUpg9e54ChKcumZmv234wurQ5jRznAGFic7T7RA
         TGjk18WsTGMP31LMckjxPCGlXgpXByL17rP8e03LD0dqFIq//ATm6cFGBqVWtT5pLCjC
         L4fepmPsWYH1nllCzWPuTfYs8msDZOOA1iBRh3bIDcJVzdZMFUcPrCesGEV6LlMhnPXA
         EVwKGgAbmRisSfOf5MZz9pZNy2POWKU/cRZUYse6lBWPH/NvdrQcyp+zuYgbi8hIbY1O
         HlfA==
X-Gm-Message-State: AOJu0YwOHl6OyCYsHk6ZDqbsIdc054cdMc0xsbBbd21BGk1bclk1R0SF
	inl94b5wud6YAfTR6iwKHmLJ7qF9iz0gOvB0KRWEbAh3hWeBwdr9
X-Google-Smtp-Source: AGHT+IHiK0kt6u1XOAvQDvqSh6XhHwsTZuUIkof4J+a5QrzJJNeGHIHy1jKQct0rQkcPWlQXjDoEOA==
X-Received: by 2002:a17:906:3013:b0:a37:a3bf:4045 with SMTP id 19-20020a170906301300b00a37a3bf4045mr788756ejz.35.1707064547642;
        Sun, 04 Feb 2024 08:35:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVnPFgtVvBOruXxAtIRnjnScfiRDO6QqA4vQ0+I49eYoi22XwS2SBUAmLoubqB0jW0xtMBA0MKMm76xhe1747hseNKYfTl/jS5s0Ro62Pa0/2uPh2QnVraOBAhO2rd87Qpmv45NAtA1675fiDoI6IRZdl23BpdCYZMz6F9gx2ka/KBLkqTYwJpP3jMcqE4ah8MDDte8cNekDhaE4ZGZGGU0k1vgvITayQwDfI4=
Received: from ?IPV6:2a01:c22:732c:d400:1402:4c43:8a0e:1a33? (dynamic-2a01-0c22-732c-d400-1402-4c43-8a0e-1a33.c22.pool.telefonica.de. [2a01:c22:732c:d400:1402:4c43:8a0e:1a33])
        by smtp.googlemail.com with ESMTPSA id i15-20020a1709063c4f00b00a376329d829sm1646782ejg.172.2024.02.04.08.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 08:35:47 -0800 (PST)
Message-ID: <de75885e-d996-4e23-9ef8-3917fe1160c4@gmail.com>
Date: Sun, 4 Feb 2024 17:35:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: phy: realtek: use generic MDIO
 constants
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <31a83fd9-90ce-402a-84c7-d5c20540b730@gmail.com>
 <732a70d6-4191-4aae-8862-3716b062aa9e@gmail.com>
 <81779222-dab6-4e11-9fd2-6e447257c0d5@lunn.ch>
 <a4bea8c5-b7d7-41ed-9c10-47d087e7dff8@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <a4bea8c5-b7d7-41ed-9c10-47d087e7dff8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04.02.2024 17:26, Heiner Kallweit wrote:
> On 04.02.2024 17:00, Andrew Lunn wrote:
>> On Sun, Feb 04, 2024 at 03:17:53PM +0100, Heiner Kallweit wrote:
>>> From: Marek Behún <kabel@kernel.org>
>>>
>>> Drop the ad-hoc MDIO constants used in the driver and use generic
>>> constants instead.
>>>
>>> Signed-off-by: Marek Behún <kabel@kernel.org>
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> ---
>>>  drivers/net/phy/realtek.c | 30 +++++++++++++-----------------
>>>  1 file changed, 13 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
>>> index 894172a3e..ffc13c495 100644
>>> --- a/drivers/net/phy/realtek.c
>>> +++ b/drivers/net/phy/realtek.c
>>> @@ -57,14 +57,6 @@
>>>  #define RTL8366RB_POWER_SAVE			0x15
>>>  #define RTL8366RB_POWER_SAVE_ON			BIT(12)
>>>  
>>> -#define RTL_SUPPORTS_5000FULL			BIT(14)
>>> -#define RTL_SUPPORTS_2500FULL			BIT(13)
>>> -#define RTL_SUPPORTS_10000FULL			BIT(0)
>>> -#define RTL_ADV_2500FULL			BIT(7)
>>> -#define RTL_LPADV_10000FULL			BIT(11)
>>> -#define RTL_LPADV_5000FULL			BIT(6)
>>> -#define RTL_LPADV_2500FULL			BIT(5)
>>> -
>>>  #define RTL9000A_GINMR				0x14
>>>  #define RTL9000A_GINMR_LINK_STATUS		BIT(4)
>>>  
>>> @@ -674,11 +666,11 @@ static int rtl822x_get_features(struct phy_device *phydev)
>>>  		return val;
>>>  
>>>  	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
>>> -			 phydev->supported, val & RTL_SUPPORTS_2500FULL);
>>> +			 phydev->supported, val & MDIO_PMA_SPEED_2_5G);
>>>  	linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
>>> -			 phydev->supported, val & RTL_SUPPORTS_5000FULL);
>>> +			 phydev->supported, val & MDIO_PMA_SPEED_5G);
>>>  	linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
>>> -			 phydev->supported, val & RTL_SUPPORTS_10000FULL);
>>> +			 phydev->supported, val & MDIO_SPEED_10G);
>>
>> Now that this only using generic constants, should it move into mdio.h
>> as a shared helper? Is this a standard register defined in 802.3, just
>> at a different address?
>>
> This is register 1.4 (PMA/PMD speed ability), mapped to a vendor-specific
> register. There's very few users of this register, and nothing where such
> a helper could be reused.
> 
>>>  
>>>  	return genphy_read_abilities(phydev);
>>>  }
>>> @@ -692,10 +684,11 @@ static int rtl822x_config_aneg(struct phy_device *phydev)
>>>  
>>>  		if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
>>>  				      phydev->advertising))
>>> -			adv2500 = RTL_ADV_2500FULL;
>>> +			adv2500 = MDIO_AN_10GBT_CTRL_ADV2_5G;
>>>  

Similarly linkmode_adv_to_mii_10gbt_adv_t() can be used here.

>>>  		ret = phy_modify_paged_changed(phydev, 0xa5d, 0x12,
>>> -					       RTL_ADV_2500FULL, adv2500);
>>> +					       MDIO_AN_10GBT_CTRL_ADV2_5G,
>>> +					       adv2500);
>>>  		if (ret < 0)
>>>  			return ret;
>>>  	}
>>> @@ -714,11 +707,14 @@ static int rtl822x_read_status(struct phy_device *phydev)
>>>  			return lpadv;
>>>  
>>>  		linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
>>> -			phydev->lp_advertising, lpadv & RTL_LPADV_10000FULL);
>>> +				 phydev->lp_advertising,
>>> +				 lpadv & MDIO_AN_10GBT_STAT_LP10G);
>>>  		linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
>>> -			phydev->lp_advertising, lpadv & RTL_LPADV_5000FULL);
>>> +				 phydev->lp_advertising,
>>> +				 lpadv & MDIO_AN_10GBT_STAT_LP5G);
>>>  		linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
>>> -			phydev->lp_advertising, lpadv & RTL_LPADV_2500FULL);
>>> +				 phydev->lp_advertising,
>>> +				 lpadv & MDIO_AN_10GBT_STAT_LP2_5G);
>>
>> Is this mii_10gbt_stat_mod_linkmode_lpa_t() ?
>>
> Indeed, it is. Thanks for the hint. I'd prefer to submit the patch making use
> of this helper as a follow-up patch. Then it's obvious that the helper is
> the same as the replaced code.
> 
>> Something i've done in the past is to do this sort of conversion to
>> standard macros, and the followed up with a patch which says that
>> function X is now clearly the same as helper Y, so delete the function
>> and use the helper...
>>
>>     Andrew
> Heiner


