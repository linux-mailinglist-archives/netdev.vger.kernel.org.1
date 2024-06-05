Return-Path: <netdev+bounces-100872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 109F28FC682
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 10:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790F61F248DA
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 08:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CC149653;
	Wed,  5 Jun 2024 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="Q2p6oy5e"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3661946A6
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717576423; cv=none; b=eqDD3dOq9GCf2gTYbHxdWDSDYey1E6am7EYhpPK26TmjKpbUl1DVsnhchsBbrJghQjJkazHfc9aS+nXOyumM3b4i5fKtZXp5jnuCLF0GtUEPGeq8+54W16Ghdjn0/bPxH+4YJzH3JycZF6Me2ZslfSkQQVITtazaFxEUK9utyic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717576423; c=relaxed/simple;
	bh=WyHQMBS+rrvnUzK769BEP+AYfcO0F7MrDzy69DnG4Pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NQ96H/knv5RQFuRuRf2L6T4XUOu+jmFUbyc3HJDjRMeCnpJQY5amogSLN1B1wtfKALlSqOtbCvy+jaUmV3kHDQ+BuIB9LwSAOscEkaEF0rg+2m7EyNmkXesDkzT9gCmAJqjJ0T06iBNVqc88AXIiBoIIteQJ4uqb3lNMjSyrM7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=Q2p6oy5e; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id AB2F39C564F;
	Wed,  5 Jun 2024 04:33:38 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id LPm5EDF7-W8K; Wed,  5 Jun 2024 04:33:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0538D9C58EF;
	Wed,  5 Jun 2024 04:33:37 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 0538D9C58EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1717576417; bh=+tT3oW+S9NAhW/TXTGQL5IX//+48SN0y9v/u+JLFRcE=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=Q2p6oy5esgPCjMKPcSYGRVJi+zhNl8PlrKsPJBRzEO6DV7xFAngKihgUAqdJLshEq
	 mqNuDkD/lHAl/DGQU3GpEUyBVpHTjRjVgtWKd3l6VygbbrujnzrnxAeExCogAmIodS
	 D+jl5jVS5P9pIwBQSEF+dTNi4sYMbSEvXx9UHvUNNsOyjzP43Wfnd1qeT40nD8E/OO
	 h92VFeJhAFSM21OGCWx0KVbqYBAXMyzEy7xhKbo65AvajPZN+6No/G+8eSc0XA0f7l
	 Cz6ZyHZyfDkFHQSXa0VYBg7aAkWurPHMW4GgLcIw09oBYle1l5omOFFrxoQDUlHzq7
	 gmFiDNmPhM2Lw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id fzX11M-xtI7P; Wed,  5 Jun 2024 04:33:36 -0400 (EDT)
Received: from [192.168.216.123] (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id D51829C564F;
	Wed,  5 Jun 2024 04:33:35 -0400 (EDT)
Message-ID: <19eef958-5222-4663-bd94-5a5fb3d65caf@savoirfairelinux.com>
Date: Wed, 5 Jun 2024 10:33:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 1/4] net: phy: micrel: add Microchip KSZ 9897
 Switch PHY support
To: Woojung.Huh@microchip.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 UNGLinuxDriver@microchip.com, horms@kernel.org, Tristram.Ha@microchip.com,
 Arun.Ramadoss@microchip.com, netdev@vger.kernel.org
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <20240604092304.314636-2-enguerrand.de-ribaucourt@savoirfairelinux.com>
 <BL0PR11MB2913D8FC28BA3569FDADD4A7E7F82@BL0PR11MB2913.namprd11.prod.outlook.com>
Content-Language: en-US
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
In-Reply-To: <BL0PR11MB2913D8FC28BA3569FDADD4A7E7F82@BL0PR11MB2913.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 04/06/2024 22:49, Woojung.Huh@microchip.com wrote:
> Hi Enguerrand,
> 
> Can you help me to understand your setup? I could see you are using
>   - Host CPU : i.MX6ULL
>   - DSA Switch : KSZ9897R (https://www.microchip.com/en-us/product/ksz9897)
>   - Host-to-KSZ interface : RGMII for data path & SPI for control
> Based on this, CPU port is either GMAC6 or GMAC7 (Figure 2-1 of [1])
> 
> I have two questions for you.
> 1. PHY on CPU port
>     Which GMAC (or port number) is connected between Host CPU and KSZ9897R?
>     If CPU port is either GMAC6 or GMAC7, it is just a MAC-to-MAC connection over RGMII.

I'm using port number 6 as the CPU port for KSZ9897R. GMAC6 is directly 
connected to the MAC of i.MX6ULL (driver is i.MX fec). I'm using RMII 
since gigabit is not supported by the i.MX6ULL.

> 2. PHY ID
>     Its PHY ID is different when checking datasheet of KSZ9897 and KSZ8081.
>     PHY ID of Port 1-5 of KSZ9897 is 0x0022-0x1631 per [1]
>     PHY ID of KSZ8081 is 0x0022-0x0156x per [2]
That's true for port 1-5, however, I found out that the phy_id emitted 
by GMAC6 is 0x00221561. It is the same as KSZ8081-revA3 according to the 
datasheet. I also studied all registers at runtime for a reliable 
difference to implement something like ksz8051_ksz8795_match_phy_device 
between GMAC6 and KSZ8081, but none appeared to me. Following 
suggestions by Andrew Lunn, I added this virtual phy_id (0x002217ff) to 
hardcode in the devicetree. I'm happy with this solution.
> 
> Beside patch, you can create a ticket to Microchip site (https://microchipsupport.force.com/s/supportservice)
> if you think it is easier to solve your problem.
I created a joined ticket for tracking (Case number 01457279).
> 

Thank you very much for your time,

Enguerrand de Ribaucourt

> Best regards,
> Woojung
> 
> [1] https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/KSZ9897R-Data-Sheet-DS00002330D.pdf
> [2] https://www.microchip.com/en-us/product/ksz8081#document-table
> 
>> -----Original Message-----
>> From: Enguerrand de Ribaucourt <enguerrand.de-
>> ribaucourt@savoirfairelinux.com>
>> Sent: Tuesday, June 4, 2024 5:23 AM
>> To: netdev@vger.kernel.org
>> Cc: andrew@lunn.ch; hkallweit1@gmail.com; linux@armlinux.org.uk; Woojung Huh
>> - C21699 <Woojung.Huh@microchip.com>; UNGLinuxDriver
>> <UNGLinuxDriver@microchip.com>; horms@kernel.org; Tristram Ha - C24268
>> <Tristram.Ha@microchip.com>; Arun Ramadoss - I17769
>> <Arun.Ramadoss@microchip.com>; Enguerrand de Ribaucourt <enguerrand.de-
>> ribaucourt@savoirfairelinux.com>
>> Subject: [PATCH net v5 1/4] net: phy: micrel: add Microchip KSZ 9897 Switch
>> PHY support
>>
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the
>> content is safe
>>
>> There is a DSA driver for microchip,ksz9897 which can be controlled
>> through SPI or I2C. This patch adds support for it's CPU ports PHYs to
>> also allow network access to the switch's CPU port.
>>
>> The CPU ports PHYs of the KSZ9897 are not documented in the datasheet.
>> They weirdly use the same PHY ID as the KSZ8081, which is a different
>> PHY and that driver isn't compatible with KSZ9897. Before this patch,
>> the KSZ8081 driver was used for the CPU ports of the KSZ9897 but the
>> link would never come up.
>>
>> A new driver for the KSZ9897 is added, based on the compatible KSZ87XX.
>> I could not test if Gigabit Ethernet works, but the link comes up and
>> can successfully allow packets to be sent and received with DSA tags.
>>
>> To resolve the KSZ8081/KSZ9897 phy_id conflicts, I could not find any
>> stable register to distinguish them. Instead of a match_phy_device() ,
>> I've declared a virtual phy_id with the highest value in Microchip's OUI
>> range.
>>
>> Example usage in the device tree:
>>          compatible = "ethernet-phy-id0022.17ff";
>>
>> A discussion to find better alternatives had been opened with the
>> Microchip team, with no response yet.
>>
>> See https://lore.kernel.org/all/20220207174532.362781-1-enguerrand.de-
>> ribaucourt@savoirfairelinux.com/
>>
>> Fixes: b987e98e50ab ("dsa: add DSA switch driver for Microchip KSZ9477")
>> Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-
>> ribaucourt@savoirfairelinux.com>
>> ---
>> v5:
>>   - rewrap comments
>>   - restore suspend/resume for KSZ9897
>> v4: https://lore.kernel.org/all/20240531142430.678198-2-enguerrand.de-
>> ribaucourt@savoirfairelinux.com/
>>   - rebase on net/main
>>   - add Fixes tag
>>   - use pseudo phy_id instead of of_tree search
>> v3: https://lore.kernel.org/all/20240530102436.226189-2-enguerrand.de-
>> ribaucourt@savoirfairelinux.com/
>> ---
>>   drivers/net/phy/micrel.c   | 13 ++++++++++++-
>>   include/linux/micrel_phy.h |  4 ++++
>>   2 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
>> index 8c20cf937530..11e58fc628df 100644
>> --- a/drivers/net/phy/micrel.c
>> +++ b/drivers/net/phy/micrel.c
>> @@ -16,7 +16,7 @@
>>    *                        ksz8081, ksz8091,
>>    *                        ksz8061,
>>    *             Switch : ksz8873, ksz886x
>> - *                      ksz9477, lan8804
>> + *                      ksz9477, ksz9897, lan8804
>>    */
>>
>>   #include <linux/bitfield.h>
>> @@ -5545,6 +5545,16 @@ static struct phy_driver ksphy_driver[] = {
>>          .suspend        = genphy_suspend,
>>          .resume         = ksz9477_resume,
>>          .get_features   = ksz9477_get_features,
>> +}, {
>> +       .phy_id         = PHY_ID_KSZ9897,
>> +       .phy_id_mask    = MICREL_PHY_ID_MASK,
>> +       .name           = "Microchip KSZ9897 Switch",
>> +       /* PHY_BASIC_FEATURES */
>> +       .config_init    = kszphy_config_init,
>> +       .config_aneg    = ksz8873mll_config_aneg,
>> +       .read_status    = ksz8873mll_read_status,
>> +       .suspend        = genphy_suspend,
>> +       .resume         = genphy_resume,
>>   } };
>>
>>   module_phy_driver(ksphy_driver);
>> @@ -5570,6 +5580,7 @@ static struct mdio_device_id __maybe_unused
>> micrel_tbl[] = {
>>          { PHY_ID_LAN8814, MICREL_PHY_ID_MASK },
>>          { PHY_ID_LAN8804, MICREL_PHY_ID_MASK },
>>          { PHY_ID_LAN8841, MICREL_PHY_ID_MASK },
>> +       { PHY_ID_KSZ9897, MICREL_PHY_ID_MASK },
>>          { }
>>   };
>>
>> diff --git a/include/linux/micrel_phy.h b/include/linux/micrel_phy.h
>> index 591bf5b5e8dc..81cc16dc2ddf 100644
>> --- a/include/linux/micrel_phy.h
>> +++ b/include/linux/micrel_phy.h
>> @@ -39,6 +39,10 @@
>>   #define PHY_ID_KSZ87XX         0x00221550
>>
>>   #define        PHY_ID_KSZ9477          0x00221631
>> +/* Pseudo ID to specify in compatible field of device tree.
>> + * Otherwise the device reports the same ID as KSZ8081 on CPU ports.
>> + */
>> +#define        PHY_ID_KSZ9897          0x002217ff
>>
>>   /* struct phy_device dev_flags definitions */
>>   #define MICREL_PHY_50MHZ_CLK   BIT(0)
>> --
>> 2.34.1
> 

