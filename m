Return-Path: <netdev+bounces-142125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5AE9BD917
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 23:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E5A31F2198C
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 22:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9299E216435;
	Tue,  5 Nov 2024 22:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqUvQb3n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58BF216420
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 22:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730847013; cv=none; b=MNpHA3S5kR/WahNo/uBCotuyGjWfl57jwTejMqJK6ycRQuAIAUNpO25HCWVmK1fpn9Pk4N+dKegoIDSvPpMLTih92EDtecW39yVYm5m+dOnwmiPVyE8T/Fu4Gz80mYPN8vzRyFYJsEjkHOkUXog1sByoGP6B4iGK/aAnopfOrP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730847013; c=relaxed/simple;
	bh=+6ZaB+j0BAen9ObhNQKf9/3Qr9E2aO7X5soHp5mUjF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B99NCTI0molcSQ8yxaP5rn42TThJCR0OGAhkOA+G7KPF8Qqi96Y7VPWTLkIm2bA3wJmHh6sTcq08J2VV+NQw4gO/l8EmTiJHHPkbj6ybOySEFbMRQ4gIEAGrBkjxNK+poo8MOb2I7seOhouiK7rhOsJ/XVDNpTF6jLfLUZV/Kr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqUvQb3n; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso1047428566b.2
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 14:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730847010; x=1731451810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u1oZJKlHbKHgBCjhoTJqgpQKpsj0eC2ZqdRJyQrWLHc=;
        b=iqUvQb3nSue+hLUNxY5az82J68JQstVgSQFCUD6z+SzYJXjeO8eMi/HeVM5yz1eAqW
         WHy8b2MmZDGBximgsZhQHyzdCLWaD341X1YC9Wd9Tj2ye+KlSYc1uL0YWMocmUTR5lZu
         7tjF3ztJIzoBxYeG47VUKMVRz6l7Sf7WbIpVb4KsiUGpd10DJe5fqpTfkkEflpVNU6xU
         H7ipSdaCW2ukSZ5dlRgrbF53FAsTRqex94jH5oXn+hnn0+moy3ZzPZ5s6mBx2Z+c5fuW
         x/RH5hSIJd+ABl3p21qsXrqNpQKom9PX1oBPfNFQSpRBDt8LLQGsaCCPhDBZfy/rrdzN
         cL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730847010; x=1731451810;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1oZJKlHbKHgBCjhoTJqgpQKpsj0eC2ZqdRJyQrWLHc=;
        b=pv+vO1qmnvlH5Baw+H/FHwAy6suCg+sh0nBDk4ZcPjJZxCvfAW/dlVCoz/HkolwEnE
         Dcp2MAxCTEk6EtX5J3VsQQvDVYe8uTjkNFzvS+2O7kGctiva4a5cnsc01Jh4melshzsv
         te7Ei7qDDYREv8OL/WbcCQXrGHtn8Si5N+5u427n3Ej8xjRYlWwaf1jKGG4V+Ww0gdTV
         S5lHhMbfYxHrLIGzIYhuW1cftJ24c05iyMdzpp/l5bqb+TRsA3O0QbNRrM6cMMnsS6X9
         K9khpxtOQRCEiesKYcjLjkiD78z1M9JDFgx9csMNrKtnREHbFrkTTRPc1j/5bBvtnoFC
         78XA==
X-Forwarded-Encrypted: i=1; AJvYcCXckZTs50CEUUxy0DH9sG8IG1OVypoeRvESkfeqG9J9n5X3mpnRUio9d6dgIRtCGZitJosijPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxge6eDoXnxcwdmAMeIuwWpfweN7ShAlpAuIE6ghd/DoaP8TYMH
	zvmOdnZeSKBhEeXwmhjBJh+3IC4zV07ZChEC3YNOugeBtyacnW4z
X-Google-Smtp-Source: AGHT+IEKYqNbsM2RCIcWtUOxjjuevXAUdhNXuQA9JSw6R3zqG1WfWqG/6r/m0BfXN2Eps+yPYVTeoQ==
X-Received: by 2002:a17:907:7245:b0:a99:f8e2:edec with SMTP id a640c23a62f3a-a9de5d6f21cmr3760102866b.21.1730847009723;
        Tue, 05 Nov 2024 14:50:09 -0800 (PST)
Received: from ?IPV6:2a02:3100:a5ef:5e00:84c4:9e2e:f4b3:2c8b? (dynamic-2a02-3100-a5ef-5e00-84c4-9e2e-f4b3-2c8b.310.pool.telefonica.de. [2a02:3100:a5ef:5e00:84c4:9e2e:f4b3:2c8b])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9eb17d0a4dsm193070666b.125.2024.11.05.14.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 14:50:08 -0800 (PST)
Message-ID: <02e3afc5-fccf-4a1b-83ad-7a790a5dbd56@gmail.com>
Date: Tue, 5 Nov 2024 23:50:07 +0100
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
I just do it in the MAC driver because PHY drivers don't have a good
place to initially disable a certain (EEE) mode.
Modifying the advertisement register in get_features(), so that
genphy_c45_read_eee_adv() reads the desired advertisement, would be
somewhat hacky.
My use case "remove a mode from advertisement initially, but keep it
in supported modes, so that user can re-enable it" isn't really supported
as of today. Of course we could add a simple setter like

void phy_remove_eee_mode_from_advertising(struct phy_device *phydev, u32 link_mode)
{
	linkmode_clear_bit(link_mode, phydev->advertising_eee);
}

But would this be worth it?

> 	Andrew

Heiner


