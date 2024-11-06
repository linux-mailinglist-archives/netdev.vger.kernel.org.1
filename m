Return-Path: <netdev+bounces-142407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4EB9BEF06
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 14:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51D711C23DCE
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 13:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E980E1DE4CA;
	Wed,  6 Nov 2024 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbAWCz1G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C4D1DB37C
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730899738; cv=none; b=doRSyI1qXUUm5GkTOBPG8YO7FWrH34HE/R1tfGLOZR0lGbbcJ5xGOzNEEIf6whsj1jaz6Y8ARz2Xdp7yONufrMnrkQf6WywAbNV/uJkoGjeLApXhDDK3gsywH9nNxQYqSWiokBhv637B4JzG47OPjqEF9dfDAB6y8kzJpiCsdu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730899738; c=relaxed/simple;
	bh=JoYadWLQ10IyhNA2XF8ePAf1GGn7cehs2WGGbneeZhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JCCa/GM0CxxhTdYryh3Hq8TJI+ia9vS920Wv9N8wNPB1S14NmzNBd1RapDB9uZTDjGKHpkX0nw/GZF73vFQDcc9YYsPenV907kK1qmu8BdtKFZ+dv/NpU4Zb3ws8Mkz5kepXq2v6YNvhrgprc+AbWlk8y05HfC64ca/W3ckuiKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbAWCz1G; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so1064608666b.0
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 05:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730899735; x=1731504535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pKAo4jT3Qn5tEmcocaS6s3DRuNu007xvdD3H8N/g4Uk=;
        b=jbAWCz1G1AMrGQNTOkWHCSafQ4jLLrz65TL5r8Ao+0Iqh8JlIEvrC/OjWoF9ImvxOV
         fNpYIz2mJvrPLElvYQ7FqZz0KznXkId/SagkNlSvPeHXAJFoq/qR4ALQ3A6gCUBt/6jb
         PsXV92nirSNaiHlpomdpCy8hT3ASThOXwihlijSfNAZfJlXo5dUzC6x+7/rEkFjMucHg
         kqMQrLz8J8BpW4bgXn6LIF3ERdIgxJIXvytQcSuydo1EYvzvSH4JbLS0oWrgx5F+7feV
         ZVCa54EvJV8sBkZm6+Luwb/nGLjK+W4j2M491hIL16Dc+B7lHY2X5qpO/CIlWSofeHuS
         fZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730899735; x=1731504535;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKAo4jT3Qn5tEmcocaS6s3DRuNu007xvdD3H8N/g4Uk=;
        b=u3Ytj3KG+1fZypXfX8Y7zVE6gAFMA1bPAMYcAPkxmwllbjdBXMTFJtDPMaNfWRSxzS
         iqy4RYvpB1DtABmWefyarsJzA64euRm+98gprkBXPfrCewczCgSGbc3QTrxs71liU2GE
         0h7+1Z6DSZ7sIlcVhWSAB/9lWm0IQKmGIaM+W6CtC67cZE0tF+5p+fAhRHgCU2Qif8Hs
         r4MgoE4Hrwlm6Pqqw9A8aNgIWU6k/1xJAoaPgd+3n5fVw9xqXaP05pE6/Tn121N2Z1ku
         7cXsMxnsE1qYKg41qvHdcUW4h91G3z5RX45quVQDdbRKMD0u+mHhhujUDEbKji7K5zYS
         1flw==
X-Forwarded-Encrypted: i=1; AJvYcCWXMBPNpzkTW+hYnW91DIQMfk8P3zmVIUL9cpzWitTCPdIvmSCpYFxi6un9ZJpn/CpYLzr88lc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz30K/tUUSSG8BKlinBFONnPnTNaMiq2dpgKMPMQe5HFBMspQgw
	n2o9V/fD0imZ0x4kVThi45Mh6uTO/dzueyYJJkOAMYY8Qt1zYvC0
X-Google-Smtp-Source: AGHT+IHDSol3rNFnubcqMbIX6ud2LPW0F7Bh2/DHJikRFjytIXOS2U9aH4MgFAC5ONn94wLoZ/QAEA==
X-Received: by 2002:a17:906:fd42:b0:a9e:211f:7dc6 with SMTP id a640c23a62f3a-a9e211f7ebemr1938860566b.8.1730899735005;
        Wed, 06 Nov 2024 05:28:55 -0800 (PST)
Received: from ?IPV6:2a02:3100:a488:4700:d86b:5868:db11:4eeb? (dynamic-2a02-3100-a488-4700-d86b-5868-db11-4eeb.310.pool.telefonica.de. [2a02:3100:a488:4700:d86b:5868:db11:4eeb])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9eb16d67a6sm287551866b.60.2024.11.06.05.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 05:28:54 -0800 (PST)
Message-ID: <3a27097f-f7d0-4cb2-8e43-9e53327dcd7a@gmail.com>
Date: Wed, 6 Nov 2024 14:28:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] r8169: copy vendor driver 2.5G/5G EEE
 advertisement constraints
To: Andrew Lunn <andrew@lunn.ch>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <4677d3c4-60e2-4094-81a8-adae42ca46bb@gmail.com>
 <5cd6ccf1-8641-4bd5-9199-b250115b844c@lunn.ch>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <5cd6ccf1-8641-4bd5-9199-b250115b844c@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05.11.2024 22:06, Andrew Lunn wrote:
> On Mon, Nov 04, 2024 at 11:07:20PM +0100, Heiner Kallweit wrote:
>> Vendor driver r8125 doesn't advertise 2.5G EEE on RTL8125A, and r8126
>> doesn't advertise 5G EEE. Likely there are compatibility issues,
>> therefore do the same in r8169.
>> With this change we don't have to disable 2.5G EEE advertisement in
>> rtl8125a_config_eee_phy() any longer.
>> Note: We don't remove the potentially problematic modes from the
>> supported modes, so users can re-enable advertisement of these modes
>> if they work fine in their setup.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/net/ethernet/realtek/r8169_main.c       |  7 +++++++
>>  drivers/net/ethernet/realtek/r8169_phy_config.c | 16 ++++------------
>>  2 files changed, 11 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>> index e83c4841b..4f37d25e0 100644
>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>> @@ -5318,6 +5318,13 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
>>  		phy_support_eee(tp->phydev);
>>  	phy_support_asym_pause(tp->phydev);
>>  
>> +	/* mimic behavior of r8125/r8126 vendor drivers */
>> +	if (tp->mac_version == RTL_GIGA_MAC_VER_61)
>> +		linkmode_clear_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
>> +				   tp->phydev->advertising_eee);
>> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
>> +			   tp->phydev->advertising_eee);
> 
> Hi Heiner
> 
> phy_device.c has:
> 
> /**
>  * phy_remove_link_mode - Remove a supported link mode
>  * @phydev: phy_device structure to remove link mode from
>  * @link_mode: Link mode to be removed
>  *
>  * Description: Some MACs don't support all link modes which the PHY
>  * does.  e.g. a 1G MAC often does not support 1000Half. Add a helper
>  * to remove a link mode.
>  */
> void phy_remove_link_mode(struct phy_device *phydev, u32 link_mode)
> {
>         linkmode_clear_bit(link_mode, phydev->supported);
>         phy_advertise_supported(phydev);
> }
> EXPORT_SYMBOL(phy_remove_link_mode);
> 
> Maybe we need a phy_remove_eee_link_mode()? That could also remove it
> from supported? At minimum, it would stop MAC drivers poking around
> the insides of phylib.
> 
After checking eee_broken_modes in more detail:
In general it does what I need, it prevents broken EEE modes from being
advertised. Some challenges:

- eee_broken_modes currently represents eee_cap1 register bits.
  So it's not possible to flag 2.5G or 5G EEE as broken.
  - We would have to change eee_broken_modes to a linkmode bitmap.

- eee_broken_modes can be populated via DT only.
  of_set_phy_eee_broken() would have to be changed to operate on
  fwnodes. Then I may be able to "inject" the broken modes in my
  case as swnode's.
  Not the easiest solution, but maybe the cleanest. Feedback welcome.

> 	Andrew
Heiner

