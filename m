Return-Path: <netdev+bounces-68957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1443848F3F
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 17:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64C35B21F94
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 16:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA912263E;
	Sun,  4 Feb 2024 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h17UBP02"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003B122F00
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707063974; cv=none; b=Wb+Nle91hKFodoh+csBaBUiFJ1RoyBlIpBKLCioypPGLm8WaLCDnSaKYnJXnP6EDQG/38DWXpCw9pXfvQEL/aAvpoboaSG93r9esPVNlcnNQWGwyf/OvSJxCxYdcIsptib2rdVwTTOMxDXqI+vC70pcSiA+IhItsMg79jbdqxOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707063974; c=relaxed/simple;
	bh=tNYBu27r4ehJAIrWN061J5Mur3WIbDFq4HMdT89Q1pA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XfaciAYTINRzTGj2v+qyLEEKqz6+/mn86f/jOjx/dJlGjC7V9FRAsVWJpbTaG5mrrWH1t92ViEQRW7w8hcwdD+bTIKKor1j3r0cF7Nhd2LJoRJtIbotjIVzZU9Ce/O1bco8/2usYnb3S39kC6PLcLY75F3nr1g+Lh3O83ZICJQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h17UBP02; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51032e62171so5449449e87.3
        for <netdev@vger.kernel.org>; Sun, 04 Feb 2024 08:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707063970; x=1707668770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DINi+vOWAd+dosRUC1PGHaZfhzT+MFdaFia7qYIjfWA=;
        b=h17UBP02MbDagCnRRLc/5CCTliKc2rFx0whl/NX1tlJ2NBoZzdojFXNdz8oREq+feT
         nW9KWLeB/ZXdUweuTuKrWJha9ee3yuIu4hZ+QKFgiyZu3jXI9NmmNIidE3IUtfFXwa8A
         nYaZCqkxl3GgCLezG5kj/vd8jIQPC2JK1pTHWco7d4i1sH36u4jVPlF+i8LQixyp+Ipw
         yzOoiwNv4dXC20z52WJD2+8wV50Orah7q72SHO3Jxry7PpQbmtSs76C/nU24IlC1xpd8
         Yuq4FQCN/IspQM+jB57h6ZZMgeyCCtLohF+B945LZHvgjPiICXpH8utEhgXHhl2PQBgP
         JwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707063970; x=1707668770;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DINi+vOWAd+dosRUC1PGHaZfhzT+MFdaFia7qYIjfWA=;
        b=gIeAsK7frrqtsYAxjImPG7iUwk2C1q3K9VAuwrwFWjpVGhjSheH+dK1UuXwSo6nmwp
         6YIGOylH9iXP39ICr/5hphk9P7fY3/Cq/WPj/ASQ1c9lRWuWK4HyWEzU6InKOnr/1g5/
         CRpioW2omhZTJsQ0PUin/NWz9IYCbabivONSLbjguD27orCv2iQbe9Myj01lUwfAmPAa
         oxEStBOiEW9MmiLzQs7R/kMeenHZza1Xd+vpxxrYWsuBWHzJ6lLlq6l17hbE+ZV578hD
         jY0F6bY73O9QFmQ2tbOfY0NdZe7ubYZbKXd315lA41sWT05bDsdyOYg2/1cfvM6fm5wy
         CmRw==
X-Gm-Message-State: AOJu0YygRR9hhcr/FG+laA2u7EL6ikULEyQ35Wuvdmw8bjpFgM0ZK0/F
	6ZItdVvbnhxc8rsFk4X2zZ4VSDnUz2sSwLBxkgYD7tqyWDp/Y8bO
X-Google-Smtp-Source: AGHT+IHFBsIqitsoA7KBEETvjMuG2JQQpbTuKye4RqGGagwFBSq19MH8cz4WdP893HJF2CdCZtW4kw==
X-Received: by 2002:a05:6512:360b:b0:511:4ff5:4dbc with SMTP id f11-20020a056512360b00b005114ff54dbcmr200108lfs.60.1707063969748;
        Sun, 04 Feb 2024 08:26:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVaCC+DHOovcTYphmJ3XKqM8ZaJRlez7W1ib4J/RpLnKnaV9UzxT0Oxoj3Iwz8TdPnE0+7OL1Bwr+gAOhn7DU+MQLqqQoK4VhdWCinWrOw4V8n2XzOijmqfYUsHwxz1fP305pZOcErJeNt0PTTDA9vgPDWbbRotJjJd0LDrBn5wroYk7h9Jn1nmOV79521DkS5Za6ypr3qB6fmrEaaHKsCi0x4exwtwJOZ2fCk=
Received: from ?IPV6:2a01:c22:732c:d400:1402:4c43:8a0e:1a33? (dynamic-2a01-0c22-732c-d400-1402-4c43-8a0e-1a33.c22.pool.telefonica.de. [2a01:c22:732c:d400:1402:4c43:8a0e:1a33])
        by smtp.googlemail.com with ESMTPSA id f16-20020a056402195000b005606405866bsm223832edz.58.2024.02.04.08.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 08:26:09 -0800 (PST)
Message-ID: <a4bea8c5-b7d7-41ed-9c10-47d087e7dff8@gmail.com>
Date: Sun, 4 Feb 2024 17:26:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: phy: realtek: use generic MDIO
 constants
To: Andrew Lunn <andrew@lunn.ch>
Cc: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <31a83fd9-90ce-402a-84c7-d5c20540b730@gmail.com>
 <732a70d6-4191-4aae-8862-3716b062aa9e@gmail.com>
 <81779222-dab6-4e11-9fd2-6e447257c0d5@lunn.ch>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <81779222-dab6-4e11-9fd2-6e447257c0d5@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04.02.2024 17:00, Andrew Lunn wrote:
> On Sun, Feb 04, 2024 at 03:17:53PM +0100, Heiner Kallweit wrote:
>> From: Marek Behún <kabel@kernel.org>
>>
>> Drop the ad-hoc MDIO constants used in the driver and use generic
>> constants instead.
>>
>> Signed-off-by: Marek Behún <kabel@kernel.org>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/net/phy/realtek.c | 30 +++++++++++++-----------------
>>  1 file changed, 13 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
>> index 894172a3e..ffc13c495 100644
>> --- a/drivers/net/phy/realtek.c
>> +++ b/drivers/net/phy/realtek.c
>> @@ -57,14 +57,6 @@
>>  #define RTL8366RB_POWER_SAVE			0x15
>>  #define RTL8366RB_POWER_SAVE_ON			BIT(12)
>>  
>> -#define RTL_SUPPORTS_5000FULL			BIT(14)
>> -#define RTL_SUPPORTS_2500FULL			BIT(13)
>> -#define RTL_SUPPORTS_10000FULL			BIT(0)
>> -#define RTL_ADV_2500FULL			BIT(7)
>> -#define RTL_LPADV_10000FULL			BIT(11)
>> -#define RTL_LPADV_5000FULL			BIT(6)
>> -#define RTL_LPADV_2500FULL			BIT(5)
>> -
>>  #define RTL9000A_GINMR				0x14
>>  #define RTL9000A_GINMR_LINK_STATUS		BIT(4)
>>  
>> @@ -674,11 +666,11 @@ static int rtl822x_get_features(struct phy_device *phydev)
>>  		return val;
>>  
>>  	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
>> -			 phydev->supported, val & RTL_SUPPORTS_2500FULL);
>> +			 phydev->supported, val & MDIO_PMA_SPEED_2_5G);
>>  	linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
>> -			 phydev->supported, val & RTL_SUPPORTS_5000FULL);
>> +			 phydev->supported, val & MDIO_PMA_SPEED_5G);
>>  	linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
>> -			 phydev->supported, val & RTL_SUPPORTS_10000FULL);
>> +			 phydev->supported, val & MDIO_SPEED_10G);
> 
> Now that this only using generic constants, should it move into mdio.h
> as a shared helper? Is this a standard register defined in 802.3, just
> at a different address?
> 
This is register 1.4 (PMA/PMD speed ability), mapped to a vendor-specific
register. There's very few users of this register, and nothing where such
a helper could be reused.

>>  
>>  	return genphy_read_abilities(phydev);
>>  }
>> @@ -692,10 +684,11 @@ static int rtl822x_config_aneg(struct phy_device *phydev)
>>  
>>  		if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
>>  				      phydev->advertising))
>> -			adv2500 = RTL_ADV_2500FULL;
>> +			adv2500 = MDIO_AN_10GBT_CTRL_ADV2_5G;
>>  
>>  		ret = phy_modify_paged_changed(phydev, 0xa5d, 0x12,
>> -					       RTL_ADV_2500FULL, adv2500);
>> +					       MDIO_AN_10GBT_CTRL_ADV2_5G,
>> +					       adv2500);
>>  		if (ret < 0)
>>  			return ret;
>>  	}
>> @@ -714,11 +707,14 @@ static int rtl822x_read_status(struct phy_device *phydev)
>>  			return lpadv;
>>  
>>  		linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
>> -			phydev->lp_advertising, lpadv & RTL_LPADV_10000FULL);
>> +				 phydev->lp_advertising,
>> +				 lpadv & MDIO_AN_10GBT_STAT_LP10G);
>>  		linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
>> -			phydev->lp_advertising, lpadv & RTL_LPADV_5000FULL);
>> +				 phydev->lp_advertising,
>> +				 lpadv & MDIO_AN_10GBT_STAT_LP5G);
>>  		linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
>> -			phydev->lp_advertising, lpadv & RTL_LPADV_2500FULL);
>> +				 phydev->lp_advertising,
>> +				 lpadv & MDIO_AN_10GBT_STAT_LP2_5G);
> 
> Is this mii_10gbt_stat_mod_linkmode_lpa_t() ?
> 
Indeed, it is. Thanks for the hint. I'd prefer to submit the patch making use
of this helper as a follow-up patch. Then it's obvious that the helper is
the same as the replaced code.

> Something i've done in the past is to do this sort of conversion to
> standard macros, and the followed up with a patch which says that
> function X is now clearly the same as helper Y, so delete the function
> and use the helper...
> 
>     Andrew
Heiner

