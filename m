Return-Path: <netdev+bounces-171354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 617C6A4CA8A
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 18:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2548D3B833B
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3BA2147F3;
	Mon,  3 Mar 2025 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XjTdVrgd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D91145348
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 17:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023119; cv=none; b=Ha8EyweEEdsRegD/FcvREpWQBobOp5bxeUjpWA9zSXxu/KUPKcMJyp9W8uXVzY1mLNDAafQvR0zbv+dbDLHZESA11KqYTlC7nqWo2IFC6Zrzt/ul0vcfGp+YbN9uJiILq96DxYwhQcO+Q0LwBCdz0xWhUYdt+ynnLWkXxdfEaIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023119; c=relaxed/simple;
	bh=Z/0uNM5wfNlWPr0F4t7yF/Vw5j/YZ9iPN7jjEaeTOgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WR8e9Lrte3OOwEnNOloynfTRTaoURqwMb1QrtFamdeytqVgiw0xN50AsEWfUL9ZZlNdTzD882LeUw//lVacjaZaN+akwdGqOfl/I0rcEkigs32nGs4TFd1NnMI2zoF+aAlqNAjL1EFLPfei2NvtBVcWm1dcXVXBe+zCjuVpsHXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XjTdVrgd; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7275bc6638bso1054345a34.2
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 09:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741023117; x=1741627917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nTrDH9dCjURnCVBXkhTO9mDjd4L5zR9fFc2sSiL5T7Y=;
        b=XjTdVrgdBty6R3MR7JNsEZhD14J6p8Yi7Q3R/cMwQvkG1kgzRZs7TKHm8fWEhBhplv
         T2zp29qlmWIvngkfsJkjVUr9U/DQT2BOwn/6K8glDP1HTwzvrF6mlf62pRxUnT37+dD8
         f/ieWr5SqPlLEp91MQb1S7W4bMJaTnlYr5h9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741023117; x=1741627917;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTrDH9dCjURnCVBXkhTO9mDjd4L5zR9fFc2sSiL5T7Y=;
        b=grXAM9Sd4iNKIem4BDzfdpq28XKBBOYtp1Vl2pWHwdcCgqJO/B19xAeKcjEUHbhQ0A
         LnI7VC+GqO5KkmATGhloa4NDxAqWIlTkwNh1T90HiZn6Dzt7nsYgecU6oWIrfc4SsH0A
         eG/W9RSa9ochFw/BJ0uZwoD6jNTJGM3o/a38qxTgS4GTjWbyIP9Sj9/6+JylD/479ZKn
         dca3cqZ/T6h3gGZvijEdIRGSJqbeIMUsa2GCRNhEtVyBfRAMK3/kDTVXfi5dzXviXttM
         cGqGN20fHj6v86rO6e+XL43EwlgqhRrHg+Yxq10GlVU9Coo4e+rmhcfehIPLB5huVpmg
         c75g==
X-Forwarded-Encrypted: i=1; AJvYcCXgJro1Cn7Ob6C1llfohGIU8QGHwoGSogi2a8t3T1zO6p2/CSy0y7Fqobu6Y7s85JoLycW+dOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMSijQ9SpmZcyQ37yFos5ptyNfAlUkhXWM9sZQtt58zAMaidKY
	+UTWLpcNzP+22pq/V1wa6pS43v3I/W79ZraEnDRDUYRTOpJe1UkkKq/aXxAqFA==
X-Gm-Gg: ASbGnctEiucvgYavQrf7klLzb5ahSFWIV9NNUb4J+0GZwWywmbsL2dbmxfo28ftv6DV
	Y4tSmBWYH2k1o5k/bZP+0U6kM3ilx2k9vh5I9nBeV5srStBsrlSXFVx3lLBJ0kcePd5gfQBals3
	+PXeX4LsfgKwC2HuojjjRozLND59ZydbQRZTxFyXBq0Eu4GydxZERHLA1VGgoWoHR2hthKnx8u0
	OG5tdmyvqQ+OjH3cWIQuNbZ3SFQOkRc5UK3WC+R0nB6Z9Px2tRj6uKR3PWyPBhjI6a7zpo9o2Fy
	6+DxmhmCQ6tLKU8J5WmWO7f5BehWoJ/vOK06JCgwlQdhTGGWtiek8sNSetdP9szKG6h2Un9+wJx
	0IAUDRriH
X-Google-Smtp-Source: AGHT+IFwH4hVBl3B1BGg2Jjd3tKLrSGpuJi/TdPLC4hGVyrG6NfKGx/agRALfhjJqAEXg0S25toi4Q==
X-Received: by 2002:a05:6830:63cd:b0:727:36a0:a2ae with SMTP id 46e09a7af769-728b829e715mr9439145a34.14.1741023116929;
        Mon, 03 Mar 2025 09:31:56 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c15c3d0082sm1953785fac.37.2025.03.03.09.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 09:31:55 -0800 (PST)
Message-ID: <e2fdd2c1-7701-4c67-9a07-f3623ed03d88@broadcom.com>
Date: Mon, 3 Mar 2025 09:31:52 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net] net: phy: allow MDIO bus PM ops to start/stop
 state machine for phylink-controlled PHY
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Wei Fang <wei.fang@nxp.com>
References: <20250225153156.3589072-1-vladimir.oltean@nxp.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20250225153156.3589072-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/25/25 07:31, Vladimir Oltean wrote:
> DSA has 2 kinds of drivers:
> 
> 1. Those who call dsa_switch_suspend() and dsa_switch_resume() from
>     their device PM ops: qca8k-8xxx, bcm_sf2, microchip ksz
> 2. Those who don't: all others. The above methods should be optional.
> 
> For type 1, dsa_switch_suspend() calls dsa_user_suspend() -> phylink_stop(),
> and dsa_switch_resume() calls dsa_user_resume() -> phylink_start().
> These seem good candidates for setting mac_managed_pm = true because
> that is essentially its definition, but that does not seem to be the
> biggest problem for now, and is not what this change focuses on.
> 
> Talking strictly about the 2nd category of drivers here, I have noticed
> that these also trigger the
> 
> 	WARN_ON(phydev->state != PHY_HALTED && phydev->state != PHY_READY &&
> 		phydev->state != PHY_UP);
> 
> from mdio_bus_phy_resume(), because the PHY state machine is running.
> 
> It's running as a result of a previous dsa_user_open() -> ... ->
> phylink_start() -> phy_start(), and AFAICS, mdio_bus_phy_suspend() was
> supposed to have called phy_stop_machine(), but it didn't. So this is
> why the PHY is in state PHY_NOLINK by the time mdio_bus_phy_resume()
> runs.
> 
> mdio_bus_phy_suspend() did not call phy_stop_machine() because for
> phylink, the phydev->adjust_link function pointer is NULL. This seems a
> technicality introduced by commit fddd91016d16 ("phylib: fix PAL state
> machine restart on resume"). That commit was written before phylink
> existed, and was intended to avoid crashing with consumer drivers which
> don't use the PHY state machine - phylink does.
> 
> Make the conditions dependent on the PHY device having a
> phydev->phy_link_change() implementation equal to the default
> phy_link_change() provided by phylib. Otherwise, just check that the
> custom phydev->phy_link_change() has been provided and is non-NULL.
> Phylink provides phylink_phy_change().
> 
> Thus, we will stop the state machine even for phylink-controlled PHYs
> when using the MDIO bus PM ops.
> 
> Reported-by: Wei Fang <wei.fang@nxp.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Sorry for the lag in reviewing, this looks reasonable to me, though I 
don't have a device to reason about whether that will be a problem or not.

As you say though, some drivers should switch to mac_managed_pm, let me 
try to set some cycles aside to make that change for bcm_sf2.c at the 
very least.

Thanks!
-- 
Florian

