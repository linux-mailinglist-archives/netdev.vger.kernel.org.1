Return-Path: <netdev+bounces-226768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2627EBA4F1B
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 21:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 831293B6108
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 19:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FE027E06D;
	Fri, 26 Sep 2025 19:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZkykOpta"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810ED221F2D
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 19:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758913528; cv=none; b=CVf1AH3feLsNF7oQVwZRfD13A0ZI54rjRCEIAVLSj26kejgvU6pjDJREmUkSn4CtvMFK5u7zZ4oB/J2a4ufn643mKpN42LArej0KvcTG0/kel7jLDJv9TbC5eUDAjtCx4VmH9t9slbS4qjcuCFNVxXM3lfMPsxq04gq+BdgF8+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758913528; c=relaxed/simple;
	bh=9Lt8KDExfVqExqrpI+i6y+c3/qxojx1CeuJiN/abT8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLdl5DnJT5Lk3uJjdgVjesN8HvomIVuUuLfy0IQGy8RJ/oMOnefJMMHRBRz6pHtPbAQND17/OJQvuOYCFsglnAvZJUyJvY7P3QFSoTDPLPLnL3S7t2/nVWwtYisHZO0gFD7J0a7iyT4Sn6iDjEF0Cww3fS7iHO0zE89+GbThowo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZkykOpta; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-4286b90e3b8so1534885ab.1
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 12:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758913525; x=1759518325;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dRmwJqq2SxsiFB6VEpR33/U1NputiwE3QM2SDlba7Y=;
        b=TSbZYkn6mswKAamvJ8DvM7Fjf8TiHvSaDqOOA1X9FiYKsJbGzXqU97djEt7Jes0jJj
         Nu+VHEokkuq57w3HvY6/+nnw4OxJDVHbJraXZyPFIT6fIHG4mgjA1ryu3qCaOhNMlSmx
         ryTMUsNFdvnAuxSPSIpbMfc3nzJtSb4OT9GbTEfL5rQ3RZ0niZRaQ+7y3IZc0T4nB8/V
         4UZe2V6FQNK/0eZpx6YAk8LGkbxrDheO9njtYXh3cgbzwwmINY1KEO1a00AAEIHlcQ2e
         q5SUj4uee0uj0vetr9h3PQb5HJ68us6XHXjpuclmUokiRJS2R+jxi/jLjtReI0Isxe5S
         AWSw==
X-Forwarded-Encrypted: i=1; AJvYcCVtcOJGHcyoyHc+2KXUw7unGhz1B8oa2VgXjLwdZjeMzDDQBKLgcgj4EKEDFt2mxkhb7qNtCv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjyRBKPkvJj5UF0837TN0pDusSwvC98m09qE+Ys/AIyYtkpFqt
	Tf1FsM62ohwGBESCu8nj5B6fg1ZswpTCmn3c0UXZSswJNBuUL5Wh4vmyZTNk1wSW8a99zkv88ar
	u9YhW7QnMvBiFtLJXgop7XcLWnibSKuI2YQCiD0eo49hpYS0v5dHtBOPESBKzOTZ59UbhD6+yZR
	8gmln0yEuyNPFCeQZFFXGPyXvzOnosgyMFbpaVsaj1tLSnhu7pELVRezsww1MOgHhcfSe2qdCwX
	4r4RFyP2dGyzRqW
X-Gm-Gg: ASbGnctVhKoC9UVz2Tr6LrqZzg2RJq5ZhOs5q/U7vnD1/HQ30AbGNeIuG7O+x5AU24h
	2MSSE7ZGNjE3Hmxp+ff62nbUej55ioiOzE9jmrcKm1aRzzv4Ea0nGD1acxXnk7LRxdPy+Tq/ik1
	IYLj7/i8kB70qpi0T+sMrncCiqRdRy9RoQfVvwfHZ+j5fmLfAZjDxyF3byLJk/egnC27RfD/HFa
	cE27UTNZVwYHh6WFgzcXx1wRVhI1lTr5GUkFzkWdjXP4mcgL6nhzWvHkOY5YdPhhwxeyGjb7svt
	mbdafA/W0B2KLFoOYfTWEV4893Fk/OqqdWtfPdWeBdMZ3iu8u6jHP3M8D7bffp1bLFXf5oAY/HF
	64UAeN2ZO5YuaktvBq7VVuZvUEHEoartVqm0H/49jrRiIoBpUXIzt/tCioVBbFSjqm9kBwfK7ZO
	Ju1dMhzIk=
X-Google-Smtp-Source: AGHT+IFxrJnFdOckaVXaOt4ba9gGvGGaBVElq8neUarT+XsdXXIWEw8VbeEYZWcSB7vSy+jYWsf9FffzYMSJ
X-Received: by 2002:a05:6e02:3c81:b0:427:3688:a4be with SMTP id e9e14a558f8ab-4273688a690mr62819305ab.32.1758913525510;
        Fri, 26 Sep 2025 12:05:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-56a6a5b008csm336359173.37.2025.09.26.12.05.25
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Sep 2025 12:05:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2698b5fbe5bso38417445ad.0
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 12:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758913524; x=1759518324; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0dRmwJqq2SxsiFB6VEpR33/U1NputiwE3QM2SDlba7Y=;
        b=ZkykOpta6FP41DYY43K419pxvWAE1GBkpVo8mGEsBZ+bRyppVca8gCnU1x82F56AYp
         mL8OYgwsugvcTC1jbdRVSs+sngXsolDtQISBRja0bQRzNqE3buDaZmpOAoDk0psog9iS
         gguaLZ76bZoAaxb9BAOIYZ6Nia0QCGY9j32cw=
X-Forwarded-Encrypted: i=1; AJvYcCUKSVEmNEdlRxhgX0Mi8RmWtT3TBt7rOjGT9qdmrQAQEjtbxPu/uMwufvkJj2jbJ/MtAOuHTK4=@vger.kernel.org
X-Received: by 2002:a17:902:db01:b0:272:dee1:c133 with SMTP id d9443c01a7336-27ed49ded13mr86956695ad.22.1758913523884;
        Fri, 26 Sep 2025 12:05:23 -0700 (PDT)
X-Received: by 2002:a17:902:db01:b0:272:dee1:c133 with SMTP id d9443c01a7336-27ed49ded13mr86956455ad.22.1758913523442;
        Fri, 26 Sep 2025 12:05:23 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ac9ae0sm60832835ad.140.2025.09.26.12.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 12:05:22 -0700 (PDT)
Message-ID: <a318f055-059b-44a4-af28-2ffd80a779e6@broadcom.com>
Date: Fri, 26 Sep 2025 12:05:19 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/4] net: stmmac: stm32: add WoL from PHY
 support
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Christophe Roullier <christophe.roullier@foss.st.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Simon Horman <horms@kernel.org>, Tristram Ha <Tristram.Ha@microchip.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250917-wol-smsc-phy-v2-0-105f5eb89b7f@foss.st.com>
 <20250917-wol-smsc-phy-v2-2-105f5eb89b7f@foss.st.com>
 <aMriVDAgZkL8DAdH@shell.armlinux.org.uk>
 <aNbUdweqsCKAKJKl@shell.armlinux.org.uk>
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
In-Reply-To: <aNbUdweqsCKAKJKl@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 9/26/2025 10:59 AM, Russell King (Oracle) wrote:
> On Wed, Sep 17, 2025 at 05:31:16PM +0100, Russell King (Oracle) wrote:
>> On Wed, Sep 17, 2025 at 05:36:37PM +0200, Gatien Chevallier wrote:
>>> If the "st,phy-wol" property is present in the device tree node,
>>> set the STMMAC_FLAG_USE_PHY_WOL flag to use the WoL capability of
>>> the PHY.
>>>
>>> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
>>> ---
>>>   drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>>> index 77a04c4579c9dbae886a0b387f69610a932b7b9e..6f197789cc2e8018d6959158b795e4bca46869c5 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>>> @@ -106,6 +106,7 @@ struct stm32_dwmac {
>>>   	u32 speed;
>>>   	const struct stm32_ops *ops;
>>>   	struct device *dev;
>>> +	bool phy_wol;
>>>   };
>>>   
>>>   struct stm32_ops {
>>> @@ -433,6 +434,8 @@ static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
>>>   		}
>>>   	}
>>>   
>>> +	dwmac->phy_wol = of_property_read_bool(np, "st,phy-wol");
>>> +
>>>   	return err;
>>>   }
>>>   
>>> @@ -557,6 +560,8 @@ static int stm32_dwmac_probe(struct platform_device *pdev)
>>>   	plat_dat->bsp_priv = dwmac;
>>>   	plat_dat->suspend = stm32_dwmac_suspend;
>>>   	plat_dat->resume = stm32_dwmac_resume;
>>> +	if (dwmac->phy_wol)
>>> +		plat_dat->flags |= STMMAC_FLAG_USE_PHY_WOL;
>>
>> I would much rather we found a different approach, rather than adding
>> custom per-driver DT properties to figure this out.
>>
>> Andrew has previously suggested that MAC drivers should ask the PHY
>> whether WoL is supported, but this pre-supposes that PHY drivers are
>> coded correctly to only report WoL capabilities if they are really
>> capable of waking the system. As shown in your smsc PHY driver patch,
>> this may not be the case.
>>
>> Given that we have historically had PHY drivers reporting WoL
>> capabilities without being able to wake the system, we can't
>> implement Andrew's suggestion easily.
>>
>> The only approach I can think that would allow us to transition is
>> to add:
>>
>> static inline bool phy_can_wakeup(struct phy_device *phy_dev)
>> {
>> 	return device_can_wakeup(&phy_dev->mdio.dev);
>> }
>>
>> to include/linux/phy.h, and a corresponding wrapper for phylink.
>> This can then be used to determine whether to attempt to use PHY-based
>> Wol in stmmac_get_wol() and rtl8211f_set_wol(), falling back to
>> PMT-based WoL if supported at the MAC.
>>
>> So, maybe something like:
>>
>> static u32 stmmac_wol_support(struct stmmac_priv *priv)
>> {
>> 	u32 support = 0;
>>
>> 	if (priv->plat->pmt && device_can_wakeup(priv->device)) {
>> 		support = WAKE_UCAST;
>> 		if (priv->hw_cap_support && priv->dma_cap.pmt_magic_frame)
>> 			support |= WAKE_MAGIC;
>> 	}
>>
>> 	return support;
>> }
>>
>> static void stmmac_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
>> {
>> 	struct stmmac_priv *priv = netdev_priv(dev);
>> 	int err;
>>
>> 	/* Check STMMAC_FLAG_USE_PHY_WOL for legacy */
>> 	if (phylink_can_wakeup(priv->phylink) ||
>> 	    priv->plat->flags & STMMAC_FLAG_USE_PHY_WOL) {
>> 		err = phylink_ethtool_get_wol(priv->phylink, wol);
>> 		if (err != 0 && err != -EOPNOTSUPP)
>> 			return;
>> 	}
>>
>> 	wol->supported |= stmmac_wol_support(priv);
>>
>> 	/* A read of priv->wolopts is single-copy atomic. Locking
>> 	 * doesn't add any benefit.
>> 	 */
>> 	wol->wolopts |= priv->wolopts;
>> }
>>
>> static int stmmac_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
>> {
>> 	struct stmmac_priv *priv = netdev_priv(dev);
>> 	u32 support, wolopts;
>> 	int err;
>>
>> 	wolopts = wol->wolopts;
>>
>> 	/* Check STMMAC_FLAG_USE_PHY_WOL for legacy */
>> 	if (phylink_can_wakeup(priv->phylink) ||
>> 	    priv->plat->flags & STMMAC_FLAG_USE_PHY_WOL) {
>> 		struct ethtool_wolinfo w;
>>
>> 		err = phylink_ethtool_set_wol(priv->phylink, wol);
>> 		if (err != -EOPNOTSUPP)
>> 			return err;
>>
>> 		/* Remove the WoL modes that the PHY is handling */
>> 		if (!phylink_ethtool_get_wol(priv->phylink, &w))
>> 			wolopts &= ~w.wolopts;
>> 	}
>>
>> 	support = stmmac_wol_support(priv);
>>
>> 	mutex_lock(&priv->lock);
>> 	priv->wolopts = wolopts & support;
>> 	device_set_wakeup_enable(priv->device, !!priv->wolopts);
>> 	mutex_unlock(&priv->lock);
>>
>> 	return 0;
>> }
>>
>> ... and now I'm wondering whether this complexity is something that
>> phylink should handle internally, presenting a mac_set_wol() method
>> to configure the MAC-side WoL settings. What makes it difficult to
>> just move into phylink is the STMMAC_FLAG_USE_PHY_WOL flag, but
>> that could be a "force_phy_wol" flag in struct phylink_config as
>> a transitionary measure... so long as PHY drivers get fixed.
> 
> I came up with this as an experiment - I haven't tested it beyond
> running it through the compiler (didn't let it get to the link stage
> yet.) Haven't even done anything with it for stmmac yet.
> 

I like the direction this is going, we could probably take one step 
further and extract the logic present in bcmgenet_wol.c and make those 
helper functions for other drivers to get the overlay of PHY+MAC WoL 
options/password consistent across all drivers. What do you think?
-- 
Florian


