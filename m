Return-Path: <netdev+bounces-166376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCB7A35C34
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 12:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01FDC7A47ED
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 11:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437B926388A;
	Fri, 14 Feb 2025 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFm2H0bV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A45261376
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 11:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739531440; cv=none; b=pO5eAlXVX/fGjELyLyTCa/t+ZB3gGA96tUR9PFEVMzbUFS4s7B7tZ7Qnn9fe0jghPytfOOenQANGdeH+ZSoHhVnNSpnrOG7xMgO8kxMB2m+WA3lBdVbjQ31f46SYZ1ID6zyrRmxRRDmHrKHP0Mm++5FA0EaF3K4Yu31HqCg+ILw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739531440; c=relaxed/simple;
	bh=LH3Cmry9bE3FEHUiYa524mn3mJQFPUhxLRIGP/YDaCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fSOmnIF4jyPbCS6HlAQnooq625QriND/aEpH/4I1aqacEU9ieVzT5IufQJFJ7bOq1Ias48+vaTJsdZnGeEW1DxIahTv9vVXESHxYAWj6HW1DPjIqexhZWEys1/M0zPX8gaU4uAwoDEZLeRtc4QvdxnGZf/CKNKghxfJwCbbmwT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFm2H0bV; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab2b29dfc65so290876966b.1
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 03:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739531437; x=1740136237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k687myWj88H0Y00m/YTx5AUZyYjiQnWc7n864MYCB/8=;
        b=QFm2H0bVzcCB6++UDBRE+ZwkhofajOgRc3xTls55MJoMRLkmg0u1J85q8RTxQzYZvy
         v4iyy67YQgfaGf7R8Fddn/leGZgqEdcoBX/rZmQ9YBFsZ1Qy1zkkmQuWQAZvGyToY+5o
         NcRj7AEaEMUtNfojXmiTF1gN6gwuaAPByTzVXq4ocYEZqlyXOMaes7lbSkXkKEf0n7m5
         e4JUtFVGl7Q6FSDzjl1EH0cnikhRlOwDMraAyBCmHHhk1hOxVdTxrVKRt6mDLhTABYbc
         Ac1E4qIR2COtIbqO7/8DBcX2i8DPLDpLJPLjRZ5y5Brq8O6ItnjpuDQ9bo1lAJ16id4G
         1+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739531437; x=1740136237;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k687myWj88H0Y00m/YTx5AUZyYjiQnWc7n864MYCB/8=;
        b=WLUXU/GQ9deOYzVHkJVLygBsqiv4udOh/wLvofJ5c+01BiTPX8zQ6A141WxSo2iUAN
         HxBjutUBF2ZkbmD9VTXzn/YXSEuJR/C24dzIfe1K6mS1WG/B8VwyUE2U0flchzo9Mmx/
         RxjgN9lJEF6CZ5dMMaVW2/4N7/hlNXhMlJFHznN8eOEt9zNaS+QQf4yUM0caJIzwCtOH
         2mbwKxWZ5j+7A2dpgpiZD6OF+4kJ+XNH+QtT7nzEWnqoLa/JL4B1+9BaPBCtv0CwGAEV
         DjEoPFdl5XJ0Ky2dylt0Doy8rU593IA54/3fbVCObKkbfxZ0Ly5d9Ul2yQAKyapjtUBG
         7X6g==
X-Gm-Message-State: AOJu0YxeY2FocpnIKcfiPSFkNgWv5rV4WkoYfpDUPy2Z7Fh56rrqyTZY
	749xfMuPZnmvJtjf2FIqwgsuVu7f+zj+0koYMHFQTd1ndMynz003
X-Gm-Gg: ASbGncs5spsZPa7bkmThAYNTTEuwouIMGvvGKHb+gSKxdK8zY5evKfLQ6Vud7zBnOBr
	sI6vpNAbww8Wjh4l545CaBQ2SO8RQEW7Jxv+LbWolgV0OIdl6ILSlQ8IBZUPNsBC22WAwXYQ+6+
	0eFcuMXaffnstpoCpG7K0EO0rA1X7nYodkvOkyN/YZJVdH3PovL79uNe2c5IjK/z4ckfagVR1Yi
	tnJWvFqdgbGYGiWc648/beBzMvMVLFI9GDmXyVoG6EvbcGY7+GM6LYq9YOfGmNMhDVpnydpFb23
	V54XgTe41C8gZyo0whpUIjg4aitedxpt0PdZrc4dg0EIJ7nqSyEiRihcrBHunTWbZ4vFHyPm/2y
	tgxs3WWVB1PCRCQxpgZs7R9VZ/LlkaUWFoXAobRxz68eMk0vSC32+GTsygTRp3brrkOwpq2hErW
	NYyTCaB2Q=
X-Google-Smtp-Source: AGHT+IGpyKaukyVMJ5zUDvAsiY/NDcU0EDY4/moMch3FWtrqPtiICgG+bA3Zlede65vPokLRtWsKbw==
X-Received: by 2002:a17:907:72c7:b0:ab7:eeae:b23e with SMTP id a640c23a62f3a-ab7f34ab3b5mr1023585666b.47.1739531436299;
        Fri, 14 Feb 2025 03:10:36 -0800 (PST)
Received: from ?IPV6:2a02:3100:afb0:6800:4c27:d59b:b876:427c? (dynamic-2a02-3100-afb0-6800-4c27-d59b-b876-427c.310.pool.telefonica.de. [2a02:3100:afb0:6800:4c27:d59b:b876:427c])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aba532322fcsm328192966b.15.2025.02.14.03.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 03:10:35 -0800 (PST)
Message-ID: <be779825-b17c-4f72-a442-9371fdf05c2a@gmail.com>
Date: Fri, 14 Feb 2025 12:11:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] net: phy: remove fixup-related definitions
 from phy.h which are not used outside phylib
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <d14f8a69-dc21-4ff7-8401-574ffe2f4bc5@gmail.com>
 <ea6fde13-9183-4c7c-8434-6c0eb64fc72c@gmail.com>
 <fa4d7341-7e88-46d1-befb-1c18bd689701@intel.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <fa4d7341-7e88-46d1-befb-1c18bd689701@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14.02.2025 11:59, Mateusz Polchlopek wrote:
> 
> 
> On 2/13/2025 10:48 PM, Heiner Kallweit wrote:
>> Certain fixup-related definitions aren't used outside phy_device.c.
>> So make them private and remove them from phy.h.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>   drivers/net/phy/phy_device.c | 16 +++++++++++++---
>>   include/linux/phy.h          | 14 --------------
>>   2 files changed, 13 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
>> index 9b06ba92f..14c312ad2 100644
>> --- a/drivers/net/phy/phy_device.c
>> +++ b/drivers/net/phy/phy_device.c
>> @@ -45,6 +45,17 @@ MODULE_DESCRIPTION("PHY library");
>>   MODULE_AUTHOR("Andy Fleming");
>>   MODULE_LICENSE("GPL");
>>   +#define    PHY_ANY_ID    "MATCH ANY PHY"
>> +#define    PHY_ANY_UID    0xffffffff
>> +
> 
> Overall looks like a nice cleanup but I am not sure about this space
> between #define and PHY_ANY_ID or PHY_ANY_UID...
> 
There's a tab, which effectively equals a space. Maybe it's just the
diff which is misleading. At least checkpatch didn't complain.

>> +struct phy_fixup {
>> +    struct list_head list;
>> +    char bus_id[MII_BUS_ID_SIZE + 3];
>> +    u32 phy_uid;
>> +    u32 phy_uid_mask;
>> +    int (*run)(struct phy_device *phydev);
>> +};
>> +
>>   __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_basic_features) __ro_after_init;
>>   EXPORT_SYMBOL_GPL(phy_basic_features);
>>   @@ -378,8 +389,8 @@ static SIMPLE_DEV_PM_OPS(mdio_bus_phy_pm_ops, mdio_bus_phy_suspend,
>>    *    comparison
>>    * @run: The actual code to be run when a matching PHY is found
>>    */
>> -int phy_register_fixup(const char *bus_id, u32 phy_uid, u32 phy_uid_mask,
>> -               int (*run)(struct phy_device *))
>> +static int phy_register_fixup(const char *bus_id, u32 phy_uid, u32 phy_uid_mask,
>> +                  int (*run)(struct phy_device *))
>>   {
>>       struct phy_fixup *fixup = kzalloc(sizeof(*fixup), GFP_KERNEL);
>>   @@ -397,7 +408,6 @@ int phy_register_fixup(const char *bus_id, u32 phy_uid, u32 phy_uid_mask,
>>         return 0;
>>   }
>> -EXPORT_SYMBOL(phy_register_fixup);
>>     /* Registers a fixup to be run on any PHY with the UID in phy_uid */
>>   int phy_register_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask,
>> diff --git a/include/linux/phy.h b/include/linux/phy.h
>> index 29df4c602..96e427c2c 100644
>> --- a/include/linux/phy.h
>> +++ b/include/linux/phy.h
>> @@ -1277,9 +1277,6 @@ struct phy_driver {
>>   #define to_phy_driver(d) container_of_const(to_mdio_common_driver(d),        \
>>                         struct phy_driver, mdiodrv)
>>   -#define PHY_ANY_ID "MATCH ANY PHY"
>> -#define PHY_ANY_UID 0xffffffff
>> -
>>   #define PHY_ID_MATCH_EXACT(id) .phy_id = (id), .phy_id_mask = GENMASK(31, 0)
>>   #define PHY_ID_MATCH_MODEL(id) .phy_id = (id), .phy_id_mask = GENMASK(31, 4)
>>   #define PHY_ID_MATCH_VENDOR(id) .phy_id = (id), .phy_id_mask = GENMASK(31, 10)
>> @@ -1312,15 +1309,6 @@ static inline bool phydev_id_compare(struct phy_device *phydev, u32 id)
>>       return phy_id_compare(id, phydev->phy_id, phydev->drv->phy_id_mask);
>>   }
>>   -/* A Structure for boards to register fixups with the PHY Lib */
>> -struct phy_fixup {
>> -    struct list_head list;
>> -    char bus_id[MII_BUS_ID_SIZE + 3];
>> -    u32 phy_uid;
>> -    u32 phy_uid_mask;
>> -    int (*run)(struct phy_device *phydev);
>> -};
>> -
>>   const char *phy_speed_to_str(int speed);
>>   const char *phy_duplex_to_str(unsigned int duplex);
>>   const char *phy_rate_matching_to_str(int rate_matching);
>> @@ -2117,8 +2105,6 @@ s32 phy_get_internal_delay(struct phy_device *phydev, struct device *dev,
>>   void phy_resolve_pause(unsigned long *local_adv, unsigned long *partner_adv,
>>                  bool *tx_pause, bool *rx_pause);
>>   -int phy_register_fixup(const char *bus_id, u32 phy_uid, u32 phy_uid_mask,
>> -               int (*run)(struct phy_device *));
>>   int phy_register_fixup_for_id(const char *bus_id,
>>                     int (*run)(struct phy_device *));
>>   int phy_register_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask,
> 


