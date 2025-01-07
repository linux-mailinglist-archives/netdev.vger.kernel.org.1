Return-Path: <netdev+bounces-156017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05BBA04AA3
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 21:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BB9D166B2B
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 20:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0941E25E1;
	Tue,  7 Jan 2025 20:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVgUDuGH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F90132111
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 20:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736280488; cv=none; b=XthdNs/AA7sUzvnJDEi2zM6nO1Prc6dtiVM/bmWiItsnam15B0iHQ6s/LjMsbtft53Ik8I46xLQhhmEUt+MmXbxeBAc96CJ4NQvfWe9j83fPPsx8f0S8MNH0MyQxcV443SaTVJIJrI3NM3CsMDX5J0HNz37bjle/BJ5GEEbFqqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736280488; c=relaxed/simple;
	bh=x3/MwYn7O/MOFocUYkIkDbOzYS9zc8A5fkMycV1mHEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DYP2IPsseWaGh8uxrF/h9sxBoK2q7rk7bGpAZioKZeaYCkfaCXdEImdR2Ouds42gY7FbiDqXnfgCgcdcXdZFuOvLcSP2ckSJYquuxBkc8a/x/KCT7JjXTKDJT1OuOhrZnyjXkJPrtcHUu0h2FVQoYK1ohNQ6ZUTxdBviokQmJ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVgUDuGH; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aae81f4fdc4so2731517566b.0
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 12:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736280485; x=1736885285; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MwNtYrqdx5s0VJ0qI2PxNixCPlVkaJhIMlcYve+0uoA=;
        b=SVgUDuGHlBmCjU1iaMYqE0YdYqNoutNaiefB3lUkll4+uC6/VGLWAoqNLG1fJTofrO
         a3gYdtHKbeDuyD/nOkyCFy+83Cwij83SOajk83yuXw3QgA5rCQrsq8a5/z+1gIXcLcaC
         x5zh+3H51kDO2au/2IqQvgRlA911//IzBnvfOElIjOEdzt/puE6puIaTNkxL/H2kx2MT
         I0c5BhYLolBG/hh57+daHyHh4iV/9S3cVvdRuElgwDnJKKJCc7O+HurWuYBG2IR7R0cJ
         iVutHsH789xymmdjpFvgulPq1g2PWVQ3wQN2ndGJTFtRF4SEenfzr5EMV8mY922nznua
         mUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736280485; x=1736885285;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwNtYrqdx5s0VJ0qI2PxNixCPlVkaJhIMlcYve+0uoA=;
        b=L51n1H23VZssYv4kBul71izXxGdTxbSJbaHkBnnKv6griyOCHDmon2AFfhvBOVylta
         vzDX/GIdvVvRfOrBUoeqLqHACtar2kkGqMbaTycKi5Y5yCqFehRPwTDpkeKxX2iUne9X
         rwAHXJADrcNkWMso5omCVWkpVj87u0DC1pCKCO9xsItisNvaAR60uo887SxYkcVI9X4Q
         8iW5rGYiPriXsTZyoxEK0PqyCQ7qcSPxSCPhztdcHj8GsE+uZZlt9lWrNp7dHUrvOIbV
         jkxAvH7N7nULmLSh7UsZmBuV/lgbsZgvzWbrIhEHOVinM//VX6mXxTQGUagcHSoLMPNj
         V/UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm2SvzC2DjAeh6JoRsNqV+o5clJ42Rkoyp1nRsoMJB7yysDSp1471Ks0AVdw6PwQ2p4mDQM/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7z/27dayU/uStO0PWlwI8BH6yVvrdQyVVfPryFMS4q6UvtFJc
	X7WdRlGZVpmTvJImf0pXZhXguOGoQzeyv9loGjkrYF+q71oJcDDo
X-Gm-Gg: ASbGncubiUiLNwRfMDCT3tVlhs31W/WTotaGy/ycZxNr1h7lwBXo7WtU+/uCgp865j3
	zVeh2wwxOpkEn1bpzfFvwzkQdENRQ+BX3HOKS3CetWhFkfL4Hqo7323q+lLQt/Uhs9iaG7bniWT
	dpqlgakozVNMK3PC/T/rZw0eA86zvXkdhW0exAUta3j7Sk8KpOKkRcnUVGL00lng+RdiecAmqx9
	meDJe5XUhR0MQBHbzLnUBhgjebnWdRv8xhbyYUh+K7x/vcoU35OaE0wk6+6/avgPultjzxoTF2r
	Rtgqlz1asCBQ1AKZOU+KaMpBpaM5StbHTozCHs8R/a0Dr702Ww2uLMCB1eLvzKa685DgOm5i/Is
	0Sio7nJKWi2eM48g1Ifq8mXZaxy+yi+Klsxi0qDAztqmCVOoF
X-Google-Smtp-Source: AGHT+IHl6B2lceHNiA7BEGOaA8Xf18x++k8IceeHOuvLYino8iaE/ejN1jpaeV6IWx37OjUPJsnF6A==
X-Received: by 2002:a17:906:ef0b:b0:aa6:8096:204d with SMTP id a640c23a62f3a-ab2ab6a8e78mr12967866b.3.1736280485225;
        Tue, 07 Jan 2025 12:08:05 -0800 (PST)
Received: from ?IPV6:2a02:3100:a00f:1000:a57d:a6cf:6f93:badf? (dynamic-2a02-3100-a00f-1000-a57d-a6cf-6f93-badf.310.pool.telefonica.de. [2a02:3100:a00f:1000:a57d:a6cf:6f93:badf])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aaf697b1c27sm1016398966b.122.2025.01.07.12.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 12:08:04 -0800 (PST)
Message-ID: <4bb28f98-7e2f-4413-9d5e-c8ad5498be03@gmail.com>
Date: Tue, 7 Jan 2025 21:08:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: dsa: microchip: remove MICREL_NO_EEE
 workaround
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
 Woojung Huh <Woojung.Huh@microchip.com>,
 Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
 Tim Harvey <tharvey@gateworks.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <79f347c6-ac14-475a-8c93-f1a4efc3e15b@gmail.com>
 <329108a3-12d6-4ce4-9b28-b59f107120ba@gmail.com>
 <Z3za4bKAJWh3HO9u@pengutronix.de>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <Z3za4bKAJWh3HO9u@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07.01.2025 08:42, Oleksij Rempel wrote:
> On Mon, Jan 06, 2025 at 02:23:36PM +0100, Heiner Kallweit wrote:
>> The integrated PHY's on all these switch types have the same PHY ID.
>> So we can assume that the issue is related to the PHY type, not the
>> switch type. After having disabled EEE for this PHY type, we can remove
>> the workaround code here.
>>
>> Note: On the fast ethernet models listed here the integrated PHY has
>>       PHY ID 0x00221550, which is handled by PHY driver
>>       "Micrel KSZ87XX Switch". This PHY driver doesn't handle flag
>>       MICREL_NO_EEE, therefore setting the flag for these models
>>       results in a no-op.
> 
> Yes, it feels like no one is using KSZ87XX switches with the kernel DSA
> driver.
> 
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/net/dsa/microchip/ksz_common.c | 25 -------------------------
>>  include/linux/micrel_phy.h             |  1 -
>>  2 files changed, 26 deletions(-)
>>
>> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
>> index e3512e324..4871bb1fc 100644
>> --- a/drivers/net/dsa/microchip/ksz_common.c
>> +++ b/drivers/net/dsa/microchip/ksz_common.c
>> @@ -3008,31 +3008,6 @@ static u32 ksz_get_phy_flags(struct dsa_switch *ds, int port)
>>  		if (!port)
>>  			return MICREL_KSZ8_P1_ERRATA;
>>  		break;
>> -	case KSZ8567_CHIP_ID:
>> -		/* KSZ8567R Errata DS80000752C Module 4 */
>> -	case KSZ8765_CHIP_ID:
>> -	case KSZ8794_CHIP_ID:
>> -	case KSZ8795_CHIP_ID:
>> -		/* KSZ879x/KSZ877x/KSZ876x Errata DS80000687C Module 2 */
>> -	case KSZ9477_CHIP_ID:
>> -		/* KSZ9477S Errata DS80000754A Module 4 */
>> -	case KSZ9567_CHIP_ID:
>> -		/* KSZ9567S Errata DS80000756A Module 4 */
>> -	case KSZ9896_CHIP_ID:
>> -		/* KSZ9896C Errata DS80000757A Module 3 */
>> -	case KSZ9897_CHIP_ID:
>> -	case LAN9646_CHIP_ID:
>> -		/* KSZ9897R Errata DS80000758C Module 4 */
>> -		/* Energy Efficient Ethernet (EEE) feature select must be manually disabled
>> -		 *   The EEE feature is enabled by default, but it is not fully
>> -		 *   operational. It must be manually disabled through register
>> -		 *   controls. If not disabled, the PHY ports can auto-negotiate
>> -		 *   to enable EEE, and this feature can cause link drops when
>> -		 *   linked to another device supporting EEE.
>> -		 *
>> -		 * The same item appears in the errata for all switches above.
>> -		 */
> 
> I have two problems with current patch set:
> - dropped documentation, not all switches are officially broken, so
>   keeping it documented is important.
> - not all KSZ9xxx based switches are officially broken. All 3 port
>   switches are not broken but still match against the KSZ9477 PHY
>   driver:
>   KSZ8563_CHIP_ID - 0x00221631
>   KSZ9563_CHIP_ID - 0x00221631
>   KSZ9893_CHIP_ID - 0x00221631
> 
OK, thanks for the clarification. Then we have to go another way.

> Best Regards,
> Oleksij


