Return-Path: <netdev+bounces-70004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC25384D39B
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 22:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AFA61C22102
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 21:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DA9127B5C;
	Wed,  7 Feb 2024 21:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPVWH8SK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAAA200A8
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340747; cv=none; b=ZfY2kjFIhCWLZKze4zh6IrgBEqtnpk61CURCAV0zffdqX2Qu8MixUWgz6YZ3Y/eHF5xdZP5d3PMfuOM0XAdVDCdpTb8e5UPMjlIjxPMPRWNxZ1gXjZ1VkuXnumMiJD0nePN4jgcXyskFm8gi+mB/7Q2SCTKq75o/IVvYQQ7gPSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340747; c=relaxed/simple;
	bh=UpOZG46LMmRZU0zNlRCsEPXTT5SJYvK8rpj8Txy5KR4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SmWnAiOl7GeC3tmKC0uOXiY0yEnHpCUZDVsUd7N0DwFwBETT/7JQWlmFFNCVDgJ/Kef0RjTdw+ja8R0V/ihpyxDxbwbjMKtrOIVMSOiKq5L7gxRbiYBA58Vfr4B+TPcU8SjPwgbOdpP6vf24RvesnWUgR7tfFMmKjMK0v/HovH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPVWH8SK; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55ad2a47b7aso1581180a12.3
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 13:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707340744; x=1707945544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gDToZ5IjJMsV+rg6fGVbkYbY/z8WxclPiNs9JnZyaIY=;
        b=nPVWH8SKzfvrmsecQagSFYtEr1s1CIIyp0QH8+o9t1STOXgjkr2NFxTl+RWnB8DdYd
         xDUVnvCSQ7Zgh5sXoqQS3G/6Uf72KqraUpchqkuv6aHmJsgYqw4BBWpDq1qDN321ZA6K
         CDqx5sdxoeKj/tuy5Xre0/xu/wOuHRhXIQjRvQ0fHEGPQ+QDmihEEgB0/gmIGXNE0J4g
         BgiHjO9iDIVUBdpdlWZ3Pznc+uFyYFqRusHzbX8J1pz1k0hwnsNaYUTTxZ7ZD2S8IMTc
         bdyv1mPfXBWWkOnkCrmCoA8SYNPaM5wLkC8gaa8jtx9qVjaw22bK2c/z3LD3j3h+aIPp
         vG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707340744; x=1707945544;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDToZ5IjJMsV+rg6fGVbkYbY/z8WxclPiNs9JnZyaIY=;
        b=MTYkhDDAhjfAgkNUGOOWiG1RGgrtU4kgR88K8Y0BNxhaEtembkRuLZrcMbZgXzFURc
         /8EsElnnlLjD3ttyn4eBLrzZroyX7ixkvsSibcV5IOUmEjfRYKMXH/OwQJeYNwElk7Jq
         lY4dgtUB0KGs7uxVw0mrsyzx2kfLgl/sXj8ng4onJw3VhmrjzwhVUHMJ6eah6qtTniV0
         VkYD2UNjgFoYEUzAacbZ4ZsrL912MYFJor2xik2D56c+tf0hdGxEeWcKBQgZMTE6wIV3
         ZzGIJm/LkNc8q9xya8tGZctiQod5kDx2F4totbHDLcxkTdZy8kIsq2ZEfnsrawodRjkL
         ecng==
X-Forwarded-Encrypted: i=1; AJvYcCUDObAAwqFhpwQR342h9hcOTk/I4evyzC+9jEbAzAMvaiuPM5WZXv+Q1mcQIpcEDwkVChM1mlXP9ftgzj+umfAvOX5tpwdE
X-Gm-Message-State: AOJu0Yy14rWZsrPNIc+LEHin53PTReLOs+e/Fh8f58eomckZ1+s7LyQs
	Lr2oIM/TfxVBJhZvBXZrqSLmP+N/4dJEugRbNF9KysyUP22qfU5J
X-Google-Smtp-Source: AGHT+IFy1uGIajWP4wdEHqgQOagVsBRv/9JSvubcy6idu5j8Q3BJVZJUZQRwm//kuG6sXgxMkAz/jQ==
X-Received: by 2002:a17:907:77d0:b0:a38:7fe2:bc73 with SMTP id kz16-20020a17090777d000b00a387fe2bc73mr1965505ejc.7.1707340743659;
        Wed, 07 Feb 2024 13:19:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWUTwdCMG3BNYZ4P3SsZ+agf6Oij5W1DU86UU4urtYlXbSrfDArUQEj6CDAOazcicsVGDaKqbiO/wYmAUxDa34ugbLmdXASyCAyjosMziV0FhgCcKZc3bpo+0nw9r8+cLDhfAxiWWkYG2Ogys+mhMhHEHxIEoLP/HlVqKwS2gpK9qoJ8gFujYYt8FJVuLW008FM8bfquqBimjGeQ26Wbwe2OPDYhe4XyDKokMg=
Received: from ?IPV6:2a01:c22:76b1:9500:5d1b:fc9d:6dc2:24a? (dynamic-2a01-0c22-76b1-9500-5d1b-fc9d-6dc2-024a.c22.pool.telefonica.de. [2a01:c22:76b1:9500:5d1b:fc9d:6dc2:24a])
        by smtp.googlemail.com with ESMTPSA id tb21-20020a1709078b9500b00a380a1ee2b0sm1157146ejc.25.2024.02.07.13.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 13:19:03 -0800 (PST)
Message-ID: <05f488ea-2fe5-48b6-b4bf-c6e6d5c69461@gmail.com>
Date: Wed, 7 Feb 2024 22:19:03 +0100
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
 <de75885e-d996-4e23-9ef8-3917fe1160c4@gmail.com>
 <6c5d7946-0776-4129-89db-2602e1874615@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <6c5d7946-0776-4129-89db-2602e1874615@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07.02.2024 20:51, Heiner Kallweit wrote:
> Hi Andrew,
> 
> On 04.02.2024 17:35, Heiner Kallweit wrote:
>> On 04.02.2024 17:26, Heiner Kallweit wrote:
>>> On 04.02.2024 17:00, Andrew Lunn wrote:
>>>> On Sun, Feb 04, 2024 at 03:17:53PM +0100, Heiner Kallweit wrote:
>>>>> From: Marek Behún <kabel@kernel.org>
>>>>>
>>>>> Drop the ad-hoc MDIO constants used in the driver and use generic
>>>>> constants instead.
>>>>>
>>>>> Signed-off-by: Marek Behún <kabel@kernel.org>
>>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>>> ---
>>>>>  drivers/net/phy/realtek.c | 30 +++++++++++++-----------------
>>>>>  1 file changed, 13 insertions(+), 17 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
>>>>> index 894172a3e..ffc13c495 100644
>>>>> --- a/drivers/net/phy/realtek.c
>>>>> +++ b/drivers/net/phy/realtek.c
>>>>> @@ -57,14 +57,6 @@
>>>>>  #define RTL8366RB_POWER_SAVE			0x15
>>>>>  #define RTL8366RB_POWER_SAVE_ON			BIT(12)
>>>>>  
>>>>> -#define RTL_SUPPORTS_5000FULL			BIT(14)
>>>>> -#define RTL_SUPPORTS_2500FULL			BIT(13)
>>>>> -#define RTL_SUPPORTS_10000FULL			BIT(0)
>>>>> -#define RTL_ADV_2500FULL			BIT(7)
>>>>> -#define RTL_LPADV_10000FULL			BIT(11)
>>>>> -#define RTL_LPADV_5000FULL			BIT(6)
>>>>> -#define RTL_LPADV_2500FULL			BIT(5)
>>>>> -
>>>>>  #define RTL9000A_GINMR				0x14
>>>>>  #define RTL9000A_GINMR_LINK_STATUS		BIT(4)
>>>>>  
>>>>> @@ -674,11 +666,11 @@ static int rtl822x_get_features(struct phy_device *phydev)
>>>>>  		return val;
>>>>>  
>>>>>  	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
>>>>> -			 phydev->supported, val & RTL_SUPPORTS_2500FULL);
>>>>> +			 phydev->supported, val & MDIO_PMA_SPEED_2_5G);
>>>>>  	linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
>>>>> -			 phydev->supported, val & RTL_SUPPORTS_5000FULL);
>>>>> +			 phydev->supported, val & MDIO_PMA_SPEED_5G);
>>>>>  	linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
>>>>> -			 phydev->supported, val & RTL_SUPPORTS_10000FULL);
>>>>> +			 phydev->supported, val & MDIO_SPEED_10G);
>>>>
>>>> Now that this only using generic constants, should it move into mdio.h
>>>> as a shared helper? Is this a standard register defined in 802.3, just
>>>> at a different address?
>>>>
>>> This is register 1.4 (PMA/PMD speed ability), mapped to a vendor-specific
>>> register. There's very few users of this register, and nothing where such
>>> a helper could be reused.
>>>

When looking a little closer at creating a helper for it, I stumbled across
the following. This register just states that the PHY can operate at a certain
speed, it leaves open which mode(s) are supported at that speed.
I see e.g. 10 different modes for 200Gbps. So it may not be possible to
create a generic helper. A translation to linkmodes is only possible if
the PHY supports just one mode per speed.

>>>>>  
>>>>>  	return genphy_read_abilities(phydev);
>>>>>  }
>>>>> @@ -692,10 +684,11 @@ static int rtl822x_config_aneg(struct phy_device *phydev)
>>>>>  
>>>>>  		if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
>>>>>  				      phydev->advertising))
>>>>> -			adv2500 = RTL_ADV_2500FULL;
>>>>> +			adv2500 = MDIO_AN_10GBT_CTRL_ADV2_5G;
>>>>>  
>>
>> Similarly linkmode_adv_to_mii_10gbt_adv_t() can be used here.
>>
>>>>>  		ret = phy_modify_paged_changed(phydev, 0xa5d, 0x12,
>>>>> -					       RTL_ADV_2500FULL, adv2500);
>>>>> +					       MDIO_AN_10GBT_CTRL_ADV2_5G,
>>>>> +					       adv2500);
>>>>>  		if (ret < 0)
>>>>>  			return ret;
>>>>>  	}
>>>>> @@ -714,11 +707,14 @@ static int rtl822x_read_status(struct phy_device *phydev)
>>>>>  			return lpadv;
>>>>>  
>>>>>  		linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
>>>>> -			phydev->lp_advertising, lpadv & RTL_LPADV_10000FULL);
>>>>> +				 phydev->lp_advertising,
>>>>> +				 lpadv & MDIO_AN_10GBT_STAT_LP10G);
>>>>>  		linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
>>>>> -			phydev->lp_advertising, lpadv & RTL_LPADV_5000FULL);
>>>>> +				 phydev->lp_advertising,
>>>>> +				 lpadv & MDIO_AN_10GBT_STAT_LP5G);
>>>>>  		linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
>>>>> -			phydev->lp_advertising, lpadv & RTL_LPADV_2500FULL);
>>>>> +				 phydev->lp_advertising,
>>>>> +				 lpadv & MDIO_AN_10GBT_STAT_LP2_5G);
>>>>
>>>> Is this mii_10gbt_stat_mod_linkmode_lpa_t() ?
>>>>
>>> Indeed, it is. Thanks for the hint. I'd prefer to submit the patch making use
>>> of this helper as a follow-up patch. Then it's obvious that the helper is
>>> the same as the replaced code.
>>>
> Is it fine with you to do this in a follow-up patch?
> The series is marked "under review", so Jakub seems to wait for an outcome
> of our discussion.
> 
>>>> Something i've done in the past is to do this sort of conversion to
>>>> standard macros, and the followed up with a patch which says that
>>>> function X is now clearly the same as helper Y, so delete the function
>>>> and use the helper...
>>>>
>>>>     Andrew
>>> Heiner
>>
> Heiner


