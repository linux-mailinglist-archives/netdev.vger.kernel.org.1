Return-Path: <netdev+bounces-225663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36205B96ABF
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 17:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE2612E2025
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 15:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863C61E0B9C;
	Tue, 23 Sep 2025 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ID29BydN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com [209.85.160.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E393CF9C1
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642908; cv=none; b=AIW2OAp2mezcvRc6Iif+UuvyAPbcpZswNbwhAGcNeShxc8sis4nFTRlA4q25lA99vL86LmMakjLzmIusEi+HUxCxNqIhOBL+tS0l8fSsNQzxk2gUXrg6R15Jj7cRukrsDZy0JQHYJrjh0EJcM5GOq+gs7LT5bII8jEK7SuScF7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642908; c=relaxed/simple;
	bh=0pBwCFIHS44ziouq1srDoEd04kku8cEoCXdN7gKCkqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i7eYgl+5Kn7+k21x6mojBv5iPsmgMhsIl2mmQll6UwUYudWlZQwthyUPlBTc/8sH/oFKt6LTeTrH2MYkwZeu2iOAQMos+8v4iiifS7mN83jPbu7O5QPw+JUujHTXPcoev9UM2rKyWAnw6rRo9MAclEJRhMTk2OWG2Zb2a042heg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ID29BydN; arc=none smtp.client-ip=209.85.160.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f100.google.com with SMTP id 586e51a60fabf-30cce534a91so2205652fac.0
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 08:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758642906; x=1759247706;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/85SHE9jTnJwhZ7HtlrpJEVSDCoX1ro4+VeG0WJ1DA=;
        b=djjJrLTTowZW88rsa4PARO1S0W7odlRBI2BMcTBJ9/Wnb4tc/aLsYjwamzmYXOoq3t
         gYK+vTlSlZ2mp+B3FBPkI44aYYD35I4Z/q5Hhzn6Aj+erG+G2HyGR+k5UUbJRMLeXps8
         1oITl0wtyBfrhkkfJeClx09+40drM1n78QPxtDENoeFhneXO4pxcd93MjilKY2Ut9Mmv
         ++/57/9qjF3EBKlrv1Fv/fxljRHFIxOLcPEsArKumd5D/bQo3YQ0ur+mOL17aJrIemNG
         8KC96siB82nHMYtUyyyDWknh5zA31E5LBwOcdZZLnxBJbzpBwHsF5KvwXjzmNb9jBlT+
         BjMw==
X-Forwarded-Encrypted: i=1; AJvYcCWin4lL7v9ruWjnPAXjsPKHhcET6gMbjEJ1ZmZ/scTqiaq4a0W71AT3SGHOywigOgiCa4j2b1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiB0FgCv5Ds+a9U3UNRWwOrI9Kqzw68pyBkNFZJGzNXSdWTjvS
	c1XbojrRSPfDCazIBDLDFb5Ue8cu5q+PmA0dq7P/iKzXHEa9zztMZuJbfFQK96pwXfshGPDVEgi
	X4hIBcPcKa2SwG75WWjT6r7Jx5TQsC/P98k0Wgoi8RjzfaZHJAToasZw/2c2vPN4g3kKyrhKnRE
	qdMzyslHbm8PcseOTmpk7DmT1axJw38IXJSIe5M+yIGFXDwh+gpSHjnvYLK+wDi6OqzUbTW11a4
	2MXXYrO3+A7BAux
X-Gm-Gg: ASbGncuxfljUheuZu/jBWt5O2ZL6i8mB2R9D33XNN1ugJlfwcHLIkbUpupbHs5mPivi
	v3B60F9OTi4dKcSujnpdRZEwoyMgUgVqNCfcPUlPGdPSrBZsxfs9H681mp7JKoR2ArJYnXEsi6n
	FUuRILPniNnuwecywOHUJ+rsh8j73NhqEWAWD2Nsw+IkPaiy6NoLvQ5iv65IPTDACyWiPeaIu+O
	PlHgs/g+5WNnvUpFJUpUsqQ2fghewBLMDQkrBpaUXYwDhYnNmGB/SP0k2Gi6e8O+UBejE/sf4YD
	ZCCpk/oIe5SICAGhdM470fHHnWqeyPMS/awNVY1t/l1fKKJyyu7b6kXDlQR+TtpF4+SYjPBDHXW
	v74+vZxeKloH2q4aYrycri71x6jZKIK9UIdMoq9EIbmQkVoLqhuCSnnB1fCxpq+lCv6nvJbTZqQ
	/nFBcvE6I=
X-Google-Smtp-Source: AGHT+IFGp8Iucmo+fre+nDAkEGYIBtOetD4Q4yTb6/i3e5AoLG1hMcpLX92iU3dt94P2Wfp1z31TdRjWixO8
X-Received: by 2002:a05:6870:5109:b0:307:bb94:2260 with SMTP id 586e51a60fabf-34c891dc7bemr1447694fac.24.1758642905669;
        Tue, 23 Sep 2025 08:55:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-336e6b96066sm1379129fac.24.2025.09.23.08.55.05
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Sep 2025 08:55:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24457ef983fso122496105ad.0
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 08:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758642904; x=1759247704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z/85SHE9jTnJwhZ7HtlrpJEVSDCoX1ro4+VeG0WJ1DA=;
        b=ID29BydN5pSelTdZZOb2iyc5T9vme20cmYfwxnUGSyfBUguqqxNWkx/ivX79Rdnpin
         VSh9z9eDISwYYIS+8wFPOgzGGb31oBGxG2EQAHFM31jGzUoBNUKVjQYxwl0BOozAl/gI
         wETsOF0lAQDXOaCdYagxj9PulSMsJiRrZl7kc=
X-Forwarded-Encrypted: i=1; AJvYcCUBJKFKD/bMVNfeu29rm6Ji0p9tpiJFIV8jMohiuLpMvmMFEqsWJ6RoaecZIT20wc31o8jmqC0=@vger.kernel.org
X-Received: by 2002:a17:903:2f43:b0:273:1516:3ed2 with SMTP id d9443c01a7336-27cc7121912mr35785895ad.50.1758642904061;
        Tue, 23 Sep 2025 08:55:04 -0700 (PDT)
X-Received: by 2002:a17:903:2f43:b0:273:1516:3ed2 with SMTP id d9443c01a7336-27cc7121912mr35785585ad.50.1758642903642;
        Tue, 23 Sep 2025 08:55:03 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed26857a0sm19619963a91.2.2025.09.23.08.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 08:55:02 -0700 (PDT)
Message-ID: <b296f05c-5cfb-49a8-8eec-09561f8f9368@broadcom.com>
Date: Tue, 23 Sep 2025 08:55:00 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: bcm5481x: Fix GMII/MII/MII-Lite selection
To: Andrew Lunn <andrew@lunn.ch>, =?UTF-8?Q?Kamil_Hor=C3=A1k_-_2N?=
 <kamilh@axis.com>
Cc: bcm-kernel-feedback-list@broadcom.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
References: <20250923143453.1169098-1-kamilh@axis.com>
 <4d5f096a-49bd-4a4f-a9b9-d70610d0d1d6@lunn.ch>
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
In-Reply-To: <4d5f096a-49bd-4a4f-a9b9-d70610d0d1d6@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 9/23/2025 8:11 AM, Andrew Lunn wrote:
> On Tue, Sep 23, 2025 at 04:34:53PM +0200, Kamil Horák - 2N wrote:
>> The Broadcom bcm54811 is hardware-strapped to select among RGMII and
>> MII/MII-Lite modes. However, the corresponding bit, RGMII Enable in
>> Miscellaneous Control Register must be also set to select desired RGMII
>> or MII(-lite)/GMII mode.
>>
>> Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
>> ---
>>   drivers/net/phy/broadcom.c | 10 ++++++++++
>>   include/linux/brcmphy.h    |  1 +
>>   2 files changed, 11 insertions(+)
>>
>> diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
>> index a60e58ef90c4..492fbf506d49 100644
>> --- a/drivers/net/phy/broadcom.c
>> +++ b/drivers/net/phy/broadcom.c
>> @@ -436,6 +436,16 @@ static int bcm54811_config_init(struct phy_device *phydev)
>>   	if (err < 0)
>>   		return err;
>>   
>> +	if (!phy_interface_is_rgmii(phydev)) {
>> +		/* Misc Control: GMII/MII/MII-Lite Mode (not RGMII) */
>> +		err = bcm54xx_auxctl_write(phydev, MII_BCM54XX_AUXCTL_SHDWSEL_MISC,
>> +					   MII_BCM54XX_AUXCTL_MISC_WREN |
>> +					   MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RGMII_SKEW_EN |
> 
> This is a bit confusing. If it is NOT RGMII, you set RGMII_SKEW_EN? I
> could understand the opposite, clear the bit...

Bit 7 is documented as RGMII Enable, bits 6:5 are documented as write as 
0b11, ignore on read. Kamil please use 
MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RGMII_EN here which is more true to the 
intended behavior.

> 
>> +					   MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RSVD);
> 
>>   #define MII_BCM54XX_AUXCTL_SHDWSEL_MISC			0x07
>>   #define MII_BCM54XX_AUXCTL_SHDWSEL_MISC_WIRESPEED_EN	0x0010
>> +#define MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RSVD		0x0060
> 
> Does RSVD mean reserved? Are you saying these two reserved bits need
> to be set? They must be more than reserved if they need setting.
> 
> 	Andrew

-- 
Florian


