Return-Path: <netdev+bounces-153757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5399F9923
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 19:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C9F1693A6
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 18:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B310223E78;
	Fri, 20 Dec 2024 18:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/0PWkDK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499DF222571
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 18:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734717777; cv=none; b=ZK/zUlknDzFl8dxuAXGuj3RLfD6Q0JS4f4gOGdp7YzOaGyChoTZ4e0Brdt2UM3DzoQd7Xz//0mXcSymWvhNN1avt7lkyEf507Rkco3b5lLAAel0QHVqtStJs6kg+lLUb0SLuvN+3G4Ky44DiXfdEkxbJFK3djrjjvNc8yuGRdKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734717777; c=relaxed/simple;
	bh=ifLaoX0cZCl+XlFdo0dBQc2GLFNFSdPNWi6si8+me9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AoT6G1MVjkMW+UVs8bPqWsrq6+lw1ug7fNOsU0L7PHCMYuBpMjWpSVzaHUfJlwKmdFPnAf2bkc6S0mQk1+6yXWa71HOP24bB3eAM7WWDKRo54nF1XJWgT6ppr+3AhaVZqtPY+MXThWG+jA/NrUSJJCGu77hGqZAbLcprpPEhxVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/0PWkDK; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa689a37dd4so86397666b.3
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 10:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734717773; x=1735322573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Fug2dqDiSqNqWETf9rASC+N1hHlB4+VhsemJwp0BEi4=;
        b=E/0PWkDKGSfIgizP032/bF08xnWcCYCQF4zkEWgpRZNSt1pwLtrI8ZHtGunwXFPIJa
         dbiD2AW3Zya1cEiKGY2CINyJSGR9NdeTlDswVQgYnrOx7GBGIuxLTbwWl2BEpT3IklOc
         dX+aFhO0GtT9SogrLoPsN3XK/trO3PV9mEbWxJ65l70iG2Zjwft7n9bcolVvxzVGBl1r
         AgYDDM8imDZKOJKEgQwWMa3JltrTzLgH84wKk3sm6JVWvWa1VflxYEaY3lRS+JgQgRZS
         th7XMS/3M0cF1NN2+7kqbhC3euVbVoZPKXoT5VOD7w+oboflr/pZrWtnKRdejyrjSJfO
         JKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734717773; x=1735322573;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fug2dqDiSqNqWETf9rASC+N1hHlB4+VhsemJwp0BEi4=;
        b=IzlOU/XhqCv9IaDNhyAlJ/k9mUv3PVt9i1AxTR64usEvZLiuM0LeXR9OHsCZzMKZAL
         4Qtqm66gFyQy076u35mwbuXZsIFIeKYU4mgqY5ysacGy30CwwixTqRomMDdPoqQwVkvI
         +6ITzYHCMkUPOgHVWAiUEbyxCk+i+UceL0sTGHHes6WiRhQhB98zVnTQ3N0Lu0yszdwC
         e5qgvu04vUwm8l/DyvIQWvObtPKsa6bAE1cNSxhlaksi+gptgVMgg1+dhp5j5IiKzyRi
         pnsFol4/yzPh3/SpLp2fyOww5cSX8hmJizOheqJF586HmByb46ZFuH2AbrOBHuIIdFzq
         PMJA==
X-Forwarded-Encrypted: i=1; AJvYcCWx/wDbUOzSsCy0IK3emQ/X/nT04iPIUTQSutvEqaHivV1KAbUqBJtqQaKNrqIKpn77PO/nGhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSBiy5T2UTxQtFyGly0+ZHUuXCsEe9d1x0TuLdFL8ZI1SKuVpb
	08hneUsCHIRkV9n1s2rGld3fhJtrAgjcIpkXdCJVTCOaWmOaCvtX
X-Gm-Gg: ASbGncsdCwTL7+1ukLjHvBcBoTP9DRpDGFe9r08NQHtuZSyhXHemF9dBIAEGCH6+mnG
	b6+SHqEAcwxEpY6z9oedd2jDQZQ69e1Q0Bpz8HsX3Yu9CJHcRhAnnlr6oZnfFJ+1EYRR98y3uEt
	Q50M1YoK22yxZqvpgjP9bFrP9D+Ta5Z8EpQuHstXN9jjWHHGv0N13xLQlYiV1ZYLw3WaeG5H+CV
	FMoKoDzqB0CLF/i91me8OSc1dPnT2qwYI4yUoTyQ79dbd3QwwH9yWDYJUDi4+KY5EAJFG9R9puW
	9U1Nn+L4nEKo5CrbyUZTrblBdMJK4BS+MsjH5qoPDHcVusNyhyrp/FLbWyJ3yIEEZ0atdbJiqcH
	btY3zu9M1ioAuA5npcPgKZtIcxs3ZWyHx/ZjlyJkzVKUfIATH
X-Google-Smtp-Source: AGHT+IGjFQLQ9DuwKKtB0aOJ8saP8SYvwAvCiXaU0e6EIxFrSSIPopg+n+AxWa3DnAQBZMD1AyFRHw==
X-Received: by 2002:a17:907:60d2:b0:aa6:7933:8b26 with SMTP id a640c23a62f3a-aac27028437mr304819266b.9.1734717773225;
        Fri, 20 Dec 2024 10:02:53 -0800 (PST)
Received: from ?IPV6:2a02:3100:a560:5100:791f:8fec:e499:68ea? (dynamic-2a02-3100-a560-5100-791f-8fec-e499-68ea.310.pool.telefonica.de. [2a02:3100:a560:5100:791f:8fec:e499:68ea])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0eae4345sm198986666b.84.2024.12.20.10.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 10:02:52 -0800 (PST)
Message-ID: <c9b5858d-5356-4ae4-b492-9bdd95152fde@gmail.com>
Date: Fri, 20 Dec 2024 19:02:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: phy: micrel: disable EEE on
 KSZ9477-type PHY
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
 Woojung Huh <woojung.huh@microchip.com>,
 Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
 Tim Harvey <tharvey@gateworks.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <942da603-ec84-4cb8-b452-22b5d8651ec1@gmail.com>
 <77df52d5-a7b9-4a5c-b004-a785750a1291@gmail.com>
 <Z2WB7aOs0m4Kamfl@pengutronix.de>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <Z2WB7aOs0m4Kamfl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20.12.2024 15:40, Oleksij Rempel wrote:
> On Fri, Dec 20, 2024 at 02:51:32PM +0100, Heiner Kallweit wrote:
>> On several supported switches the integrated PHY's have buggy EEE.
>> On the GBit-capable ones it's always the same type of PHY with PHY ID
>> 0x00221631. So we can simplify the erratum handling by simply clearing
>> phydev->supported_eee for this PHY type.
>>
>> Note: The KSZ9477 PHY driver also covers e.g. the internal PHY of
>>       KSZ9563 (ID: 0x00221637), which is unaffected by the EEE issue.
>>       Therefore check for the exact PHY ID.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/net/phy/micrel.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
>> index 3ef508840..ece6d026e 100644
>> --- a/drivers/net/phy/micrel.c
>> +++ b/drivers/net/phy/micrel.c
>> @@ -1522,6 +1522,12 @@ static int ksz9477_get_features(struct phy_device *phydev)
>>  	if (ret)
>>  		return ret;
>>  
>> +	/* See KSZ9477 Errata DS80000754C Module 4 */
>> +	if (phydev->phy_id == PHY_ID_KSZ9477) {
>> +		linkmode_zero(phydev->supported_eee);
>> +		return 0;
>> +	}
> 
> Hm.. with this change, we won't be able to disable EEE. Zeroed
> supported_eee will avoid writing to the EEE advertisement register.
> 
Indeed, genphy_c45_write_eee_adv() would become a no-op.
We have to do it differently.


