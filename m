Return-Path: <netdev+bounces-78628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB9E875ECE
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 08:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9492841CC
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 07:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897894EB43;
	Fri,  8 Mar 2024 07:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbXWbSX/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE56B4F1FB
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 07:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709884122; cv=none; b=igY2a+ybs4r4Z4OTPUjbQss4Ee5B1UUNhA+n0WDPFI3/r1StQKOMBd6q4iDgrIHsiSxA/8lq+SzV4b8Fs1LFxZwvYpfwICgg2ytV+pJRU+c4kwoQWkcXcWZGGUGpUegoL6OlSFsfbWyqVWUC3PVc8EVSeILoYKo4t4ldJGJfxvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709884122; c=relaxed/simple;
	bh=OxRup9GJku0+6o4jBp23CF80bB0a7qbte3S2o0OI7ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HdTbZYeMwa7UCwfOS0zgIobGM2oLfiK2Fr2HFr4Ei6oN4y9LNZ+4HPiOGpv0HoxK0iWXJcg7ADJYTd2u+YJ2QK6KY5LjyQ45nX5KjeUm0a7asjFt3+77iE9/IgG7RyyjLYND26T6omewTM24IIqaKilecoXc0CbdYqS4r8VJGX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbXWbSX/; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5682360e095so723556a12.1
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 23:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709884119; x=1710488919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AlfHE07CH6tly9ogh0/UYAeM8zNvrkZCxOfRkwLqXkI=;
        b=hbXWbSX/8GIBORe5jJjHq8mW3VTxuYKnVJQPFgdCuiHX6lgBWHHPP9vbKAkXFejGCw
         GZwuYW3cUg5jXgYgsu5Dwja/2VL5XLpkCbtKvj/zXo/+ncI6KvHcFZNC17+7zzy6nEbF
         csuYGSIqDMQkbKOEH///qxHc0QCLGhOtoBBB8MdH3Pno+UFdTp31Il1imGv9YChieldM
         MeLp59yOSGSjnJOsiN/onwb95vv1HNrAfxCsyxXftK1y93xRrTrgLgYHDnTcqo6BfB+p
         7M0X6+wCTv+uSg4BdJGuWvQt6iLV3yqZHmY1SkU7gf3GfyRRe5VENzVIc5v3Nl79R9x/
         rjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709884119; x=1710488919;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlfHE07CH6tly9ogh0/UYAeM8zNvrkZCxOfRkwLqXkI=;
        b=joyMN/OS5NezyTsvu5BgDF3i7ksJFGK9xL40efYTAxFmmOWQJtGGmrMX11Qm61p3s2
         ZSTxyKgjKNvoJbL1Z7LLUg3Xsg8sLGGoJrLTDkYBhGj9VC0NYC4p2MDFwNPLwHsGJKyf
         SyixOIg69yJl9pbtYXVoiah/A1NgidCUyoMPWKSbsdFmSZRzFrTVHpmIHcTsmUyG5p7m
         Ax5lJYy8ANX6NIRXZoZrvPiOgYiwF8vkHNwL9IDdyhKuWwwiMRz3RizZ1dvvcxmOS5ky
         RPrLuhI9wIQtrtZryAYDdW5yyiqnpgqn1G41CbCeI6bzkgLpfv0Vn0XhzoNAf5yeWCsQ
         UfQw==
X-Gm-Message-State: AOJu0YzoSrDTqc8KD1gepBvbzWX10TQBx3hC3+fXc40HJxjeoPBuAir2
	Kj3Cj7E3NA2qAXpMBm/W3mbc5zfiwwCKoIVIZE2dpILweJkpGujHxxQZmwfW
X-Google-Smtp-Source: AGHT+IGKBlcpNP/NG9xW6JFub94fpDyOddch7hL6FarSyI7AOWLBepF+lcCGyqNTfJT4ByMyt3tX6Q==
X-Received: by 2002:a17:906:2346:b0:a44:f91c:a85 with SMTP id m6-20020a170906234600b00a44f91c0a85mr10129528eja.60.1709884118864;
        Thu, 07 Mar 2024 23:48:38 -0800 (PST)
Received: from ?IPV6:2a01:c22:6e92:f300:e409:d134:8118:e48a? (dynamic-2a01-0c22-6e92-f300-e409-d134-8118-e48a.c22.pool.telefonica.de. [2a01:c22:6e92:f300:e409:d134:8118:e48a])
        by smtp.googlemail.com with ESMTPSA id v19-20020a170906489300b00a45bf3a70a9sm2370055ejq.215.2024.03.07.23.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 23:48:38 -0800 (PST)
Message-ID: <d6ee6353-5cb0-4751-9b69-255ab62e6b56@gmail.com>
Date: Fri, 8 Mar 2024 08:48:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [PATCH net-next] r8169: switch to new function
 phy_support_eee
To: Suman Ghosh <sumang@marvell.com>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <92462328-5c9b-4d82-9ce4-ea974cda4900@gmail.com>
 <SJ0PR18MB52166D474EE78BC4E7B6B3E9DB272@SJ0PR18MB5216.namprd18.prod.outlook.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <SJ0PR18MB52166D474EE78BC4E7B6B3E9DB272@SJ0PR18MB5216.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08.03.2024 08:37, Suman Ghosh wrote:
> Hi Heiner,
> 
> To me it looks like both patches, 
> r8169: switch to new function phy_support_eee and net: phy: simplify a check in phy_check_link_status is related and can be pushed as a series. This will make change more harmonic. Because, you are moving setting of enable_tx_lpi in one patch and removing from the other one.
> 
Both patches are unrelated. The phylib change is just a minor cleanup
w/o functional change.

> Regards,
> Suman
> 
>> -----Original Message-----
>> From: Heiner Kallweit <hkallweit1@gmail.com>
>> Sent: Friday, March 8, 2024 2:53 AM
>> To: Realtek linux nic maintainers <nic_swsd@realtek.com>; Paolo Abeni
>> <pabeni@redhat.com>; Jakub Kicinski <kuba@kernel.org>; David Miller
>> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>
>> Cc: netdev@vger.kernel.org
>> Subject: [EXTERNAL] [PATCH net-next] r8169: switch to new function
>> phy_support_eee
>> Switch to new function phy_support_eee. This allows to simplify the code
>> because data->tx_lpi_enabled is now populated by phy_ethtool_get_eee().
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>> drivers/net/ethernet/realtek/r8169_main.c | 3 +--
>> 1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c
>> b/drivers/net/ethernet/realtek/r8169_main.c
>> index 0d2cbb32c..5c879a5c8 100644
>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>> @@ -2079,7 +2079,6 @@ static int rtl8169_get_eee(struct net_device *dev,
>> struct ethtool_keee *data)
>> 		return ret;
>>
>> 	data->tx_lpi_timer = r8169_get_tx_lpi_timer_us(tp);
>> -	data->tx_lpi_enabled = data->tx_lpi_timer ? data->eee_enabled :
>> false;
>>
>> 	return 0;
>> }
>> @@ -5174,7 +5173,7 @@ static int r8169_mdio_register(struct
>> rtl8169_private *tp)
>>
>> 	tp->phydev->mac_managed_pm = true;
>> 	if (rtl_supports_eee(tp))
>> -		phy_advertise_eee_all(tp->phydev);
>> +		phy_support_eee(tp->phydev);
>> 	phy_support_asym_pause(tp->phydev);
>>
>> 	/* PHY will be woken up in rtl_open() */
>> --
>> 2.44.0
>>
> 


