Return-Path: <netdev+bounces-175308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE07BA6507D
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 14:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEB167A7BF5
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 13:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D40A23C8B6;
	Mon, 17 Mar 2025 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PpRNuXbJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86512356B0
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742217504; cv=none; b=oC1DUCu1ml02pO8qWMB5zCoVF/95wxE8wL2tdrI1nUQ+gvo81Zp4TieECn8/yOyd7Ulr//OhtsiLR+QmFEtuq1LSSOIsfWxB3F1Sl7NQVeWublFYBw9T4Ij2GT2lIpdiblMq3D2NRZqHD1sm5ZSi5MkaCerb64v7JEafOP4f0ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742217504; c=relaxed/simple;
	bh=aVcHGNdwciv1x96+nP9FQZY1KyCMeUcoQR7WsYS3qOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dq5O0JEXaYHJ2sTE+XU+i+IKm2RSnP5wYODzkK5E/vjFHlqmuyFxH4cAw7hlsM4ADJ/Wf7Bbu25DbpQDJW4XvA752CiK+r0d7Gbk7y4yYbLcCg7hRsai4kuNa6cGuOnu9HPmwa9lZ3q71I8xMCpAV0sTrdbBUPYV/eWAd6nzhvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PpRNuXbJ; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3f7f7b70aebso1670307b6e.2
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 06:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1742217501; x=1742822301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gjTa/odeiCyyfRBNYurJGt+2DoWifmwArWd16/w8hDo=;
        b=PpRNuXbJb/yTyX1Gxdw3BUIvoeso7vVTItce9p5YCBNMtAnX3/f8XDkqmdBGYFaOOU
         GJMG+v+meYvXn4Qp99A4Y3Cq6hAZOOyjvNWSDP0V3ZCMq7hEPSXzfTfftVwMXO7ELZ/Q
         NRSSO5FkObECKAeTxDkFHQao2QOZ6IoFIJ4Kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742217501; x=1742822301;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjTa/odeiCyyfRBNYurJGt+2DoWifmwArWd16/w8hDo=;
        b=kcmoQvIMXkStV38BXL2DQFgAdv+TRrJqnssU0KRinB6N0wGFVg1vLJ1QaA2lxJFTL/
         GrcHh/qmM/OGP10OnqDyZg+1LA9HjL3kUPYjnhsZxnsdKheNIPhTaBCsd6u7aLWSF06g
         VuadjR8CTkl34osFIVxMnkFhh4dKnYGrI+YCKo9wqbZV1o0AXlPnSN4NbEopWqvac8jc
         dH8pP2XmZLwmqNUeoQa4O8QuNHgH+e0QIm/+5A6swqsSGyXRsJ++Nv3BmM08AA3wTjS8
         58dy/zeISUbyHAAUGjcnVIQtizLyKKyUtD+ImXmych7SAw+1G+qLPu8boME2VcQsVHtL
         N+nA==
X-Forwarded-Encrypted: i=1; AJvYcCUnjLXRMdElBX4c81bneG53mL9zSoxm2KgEpUIAWq3Fk9We83WGhDVZUzGD5BYTT+3DhtyhUh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAF6ktoaqmEFP1AxYdzBuMOGvILPX4wiHj1jxrzbDPymCl+rFS
	b4HVLr5VyMSyFQsmyetfPdUKMJTzUsxHYQemP8giwuGTxrY381gM1Et3fb3icw==
X-Gm-Gg: ASbGnctVLOsoMyyd0+n8yN6Rq0iItE9IEo7BahqtU+DfzxYpqW/ZacnKI/uuyHkafzn
	r0XKx62zDAQKbTNU48JVSQ/Y5OjcA7SUBDrDSIcIDsITROvL7IHVPJ+PcKRzfigZmip/kQyirPp
	Hgbb8Di/KqShFh5eWsUB+bMVv9u8IcKtBp3bWucb8QOYHondW62jN6oaxg94UAGv3V37XTwvfnw
	gPjlFcUmukB1EE6lW91XnbQ05vQKIIqjRlOhAdxEQ7CI/evWcYMicoThxCvmjf+H949DA4qLQgt
	aKxwuIGktk/a5tkSTg+z3DcWNvo7yugzo45Phr0zfGpOL992nQr6lr1zDBlju13WEf8pWEEYSCa
	r/EiEfPUUsXcoYFhOTnw=
X-Google-Smtp-Source: AGHT+IHOP4dAfgtYXFSWaOQMBXTcfTVWX3nCIbTlwtwvnqt3ECTfJHoncDFXtvDvaQRx5AUjr9Pr0A==
X-Received: by 2002:a05:6808:244c:b0:3f6:a7c7:909b with SMTP id 5614622812f47-3fdeed0d634mr6760883b6e.22.1742217500826;
        Mon, 17 Mar 2025 06:18:20 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3fcd4521404sm1769163b6e.15.2025.03.17.06.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 06:18:18 -0700 (PDT)
Message-ID: <9391fb55-11c4-4fa9-b38f-500cb1ae325c@broadcom.com>
Date: Mon, 17 Mar 2025 06:18:17 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2,net] net: phy: broadcom: Correct BCM5221 PHY model detection
 failure
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Jim Liu <jim.t90615@gmail.com>
Cc: JJLIU0@nuvoton.com, andrew@lunn.ch, hkallweit1@gmail.com,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, giulio.benetti+tekvox@benettiengineering.com,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
References: <20250317063452.3072784-1-JJLIU0@nuvoton.com>
 <Z9f4W86z90PgtkBc@shell.armlinux.org.uk>
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
In-Reply-To: <Z9f4W86z90PgtkBc@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/17/2025 3:24 AM, Russell King (Oracle) wrote:
> On Mon, Mar 17, 2025 at 02:34:52PM +0800, Jim Liu wrote:
>> Use "BRCM_PHY_MODEL" can be applied to the entire 5221 family of PHYs.
>>
>> Fixes: 3abbd0699b67 ("net: phy: broadcom: add support for BCM5221 phy")
>> Signed-off-by: Jim Liu <jim.t90615@gmail.com>
> 
> Looking at BRCM_PHY_MODEL() and BRCM_PHY_REV(), I think there's more
> issues with this driver. E.g.:
> 
> #define BRCM_PHY_MODEL(phydev) \
>          ((phydev)->drv->phy_id & (phydev)->drv->phy_id_mask)
> 
> #define BRCM_PHY_REV(phydev) \
>          ((phydev)->drv->phy_id & ~((phydev)->drv->phy_id_mask))
> 
> #define PHY_ID_BCM50610                 0x0143bd60
> #define PHY_ID_BCM50610M                0x0143bd70
> 
>          if ((BRCM_PHY_MODEL(phydev) == PHY_ID_BCM50610 ||
>               BRCM_PHY_MODEL(phydev) == PHY_ID_BCM50610M) &&
>              BRCM_PHY_REV(phydev) >= 0x3) {
> 
> and from the PHY driver table:
> 
>          .phy_id         = PHY_ID_BCM50610,
>          .phy_id_mask    = 0xfffffff0,
> 
>          .phy_id         = PHY_ID_BCM50610M,
>          .phy_id_mask    = 0xfffffff0,
> 
> BRCM_PHY_REV() looks at _this_ .phy_id in the table, and tries to match
> it against the revision field bits 0-3 being >= 3 - but as we can see,
> this field is set to the defined value which has bits 0-3 always as
> zero. So, this if() statement is always false.
> 
> So, BRCM_PHY_REV() should be:
> 
> #define BRCM_PHY_REV(phydev) \
> 	((phydev)->phy_id & ~(phydev)->drv->phy_id_mask)
> 
> 
> Next, I question why BRCM_PHY_MODEL() exists in the first place.
> phydev->drv->phy_id is initialised to the defined value(s), and then
> we end up doing:
> 
> 	(phydev->drv->phy_id & phydev->drv->phy_id_mask) ==
> 		one-of-those-defined-values
> 
> which is pointless, because we know that what is in phydev->drv->phy_id
> /is/ one-of-those-defined-values.
> 
> Therefore, I would suggest:
> 
> #define BRCM_PHY_MODEL(phydev) ((phydev)->drv->phy_id)
> 
> is entirely sufficient, and with such a simple definition, I question
> the value of BRCM_PHY_MODEL() existing.

If I were to make a guess, BRCM_PHY_MODEL() might have existed to ease 
the porting of a non-Linux PHY driver to a Linux PHY driver environment 
at a time where the subsystem was not as mature as it is now.

In the interest of a targeted bug fix, I would be keen on taking this 
patch in its current form and follow up in net next with a removal of 
BRCM_PHY_MODEL() later on.
-- 
Florian


