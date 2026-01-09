Return-Path: <netdev+bounces-248386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DABDFD079AE
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 08:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C08E300872F
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 07:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EEF2EBDE9;
	Fri,  9 Jan 2026 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvsxxWdC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5634328642D
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767944175; cv=none; b=KRByF6txP7/mQ9rVJdt25c89Um9F39xsb2Ky3dDOf0amwLe1J4Yl4sHvTyMzMhArrIQfW8aJAW0nYCUtSZ3JPBwnqD/Ty1tCLzzgJL9DykeLfW9oxoXXa5MJ3wXA5xYvEtMhr9C8rwfiMPWzh3wW4p/wB5kow4LUlwuEBzVSohY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767944175; c=relaxed/simple;
	bh=iF2Ai9iWjqYzfUBaa0nhaGu7J8rPHYoV/GptRdJ/v/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1JemxGecOqbVa5ljnO3zhFRO5GnKxcjFRDoSDXjJegypHb0YzDCNMXYKoIs6F6uHCBzOMFEkZy+A8TalAEj4vDP6//xVl2UMbdkzgGaNjbD2UX7CVNB3ykx5fuk1/d7yAB11E5qegv4rynGSo5dy+jOzm079o0OKEcbS5L8WvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvsxxWdC; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so27430755e9.2
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 23:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767944172; x=1768548972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q+V0nQ1zu3RTVUNrIUa2Z41r/bkUed1LFLOFTgT6K1Y=;
        b=lvsxxWdCxgbXnIUWHak830DS+eaWz/HIXbSiozxZolMx+SkAzOKeZXbQegBYcm8css
         8bRaZapVeVFSiVlCa/yXlZ7LAymIfVEUqqLFHhMWQumMYI3CziDB+QUP6GL1/rA6wFIq
         yoOOJ1AItiidMKlPzkKqy438I8hCc+UI4vgL7jbk414ucTz0MVtflZCNLbZgC8B4qbBE
         u/sjQvF/yFv9u4x8PA9/xOT/pEUW7PUEw4bewzay7klxZxX0DZZ45x/V1c7JO3PPQrU8
         A79dnsvt4D59O6TquUCxzaPUv0Ov66v113AlPupKMQwHYI3yCa2MagtMi0Rfpco5U/Wg
         WIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767944172; x=1768548972;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q+V0nQ1zu3RTVUNrIUa2Z41r/bkUed1LFLOFTgT6K1Y=;
        b=w1iI111lbra+5M8wqdV+vr31Jx9MWKKB4IME/WmNzCdTkHdtDEw3iLrBWPmAVQwNLr
         Z2v5l018myL1XzgcJ6Y7g6+g3L8bP+CQyZtfWu7TNGIYl3FyhbXuwruvXUTygStsDwm0
         0dwgrHsk1+tSAbysog3RxZSb6SGcvGQgNPk2j36Dg3wTpypSYoy2UxrHoyItUj/7uj5L
         Vpo95kvXkB+ODz+nkRaO1eKjQtloUWphbRiRcmKFEmInhvdzDfLMUmKhvSgmU3o/9IRX
         vkk7tdL+BAXMed49IuudZaWxXvg3tdurnxIAMEdFDu9Rr8iGMladCmNgPmwqTTJWCwoj
         P3CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXzdOAi4DyuHk6QY0aGQ5x5BLV018TLopaSJ0q7EdVg/vzsWpOhy+K7mhDpUItEVGapyf9uow=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrcN3YYNB/3CbdgQQ5QKAe6THWfSMU+/pzX6otiUlbXgszo2LL
	G8kU9jHEwJ3KFXLILlao8jDb64t+FroA4vh9ROfg7ttaW5FUquFa4wVJ
X-Gm-Gg: AY/fxX49DPFEs2jA92LzqXkyJOIAaxGCHZa8puyf28d3obv914y7P9O4sKX9wHlHakC
	ohZmw3nscfdpl51+9bI7ao6QRICcANdzGck0GWVCfTguXxdNilcrQiJZFkedWLhRts9ucd9BxtD
	65axH2btwmGK44exmsDMtPMqEOwPjIsp1aZgdWbjhazKFj5huz42AMMiQTMTsunLf6gxftx57xo
	IQXsZwO1I4f4P0JeNimHpw/j/PIpW5klhOOol8pCUF7/lNeafFSAW94pxrSF8PZP+mjmjaMH8hu
	Jr8xRTEyjJ65NtPRV/a0IOBsDCY3DbEFn1VjfdeiAUuHRb+NPdA3GwoJ99I5Iz/Z88ZFSWeZyVT
	NYJdnYwRMUR71xoARPRc2vfZNVZ4ZGrm7/OniV5OOhWAzvU2eKeJqmCX1Z/Kq4wehfXSPTddzSK
	anysQezlIcIUSuR/qKWW+LvfSUL9FCoJhTKp8VWt1vBHttEDTgtcrbQM7g0RhG9SMbgrK8ekJXk
	0yaOF7oEpg5jHEcwbrYyBEDdywijuIvkFm8+tnqsrcBUjBPDaLI2g==
X-Google-Smtp-Source: AGHT+IEC4d1uh6X7cJVsCAVMVrTBEY0PhVsFQFOknCd116TWTjucj/E+QmE9iCVaFZtKYVNWBoV+zw==
X-Received: by 2002:a05:600c:3556:b0:479:33be:b23e with SMTP id 5b1f17b1804b1-47d84b3b4eamr112428785e9.17.1767944171528;
        Thu, 08 Jan 2026 23:36:11 -0800 (PST)
Received: from ?IPV6:2003:ea:8f34:b700:1da4:ce1d:3d7c:283d? (p200300ea8f34b7001da4ce1d3d7c283d.dip0.t-ipconnect.de. [2003:ea:8f34:b700:1da4:ce1d:3d7c:283d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d865e3d22sm57198835e9.1.2026.01.08.23.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 23:36:11 -0800 (PST)
Message-ID: <fa9657f8-ec42-4476-bf4c-37db7b58ecac@gmail.com>
Date: Fri, 9 Jan 2026 08:36:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: phy: realtek: add PHY driver for
 RTL8127ATF
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Michael Klein <michael@fossekall.de>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Aleksander Jan Bajkowski <olek2@wp.pl>,
 Fabio Baltieri <fabio.baltieri@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <52011433-79d3-4097-a2d3-d1cca1f66acb@gmail.com>
 <492763d9-9ece-41a1-a542-d09d9b77ab4a@gmail.com>
 <aWA2DswjBcFWi8eA@makrotopia.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <aWA2DswjBcFWi8eA@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/2026 11:56 PM, Daniel Golle wrote:
> On Thu, Jan 08, 2026 at 09:27:06PM +0100, Heiner Kallweit wrote:
>> RTL8127ATF supports a SFP+ port for fiber modules (10GBASE-SR/LR/ER/ZR and
>> DAC). The list of supported modes was provided by Realtek. According to the
>> r8127 vendor driver also 1G modules are supported, but this needs some more
>> complexity in the driver, and only 10G mode has been tested so far.
>> Therefore mainline support will be limited to 10G for now.
>> The SFP port signals are hidden in the chip IP and driven by firmware.
>> Therefore mainline SFP support can't be used here.
>> This PHY driver is used by the RTL8127ATF support in r8169.
>> RTL8127ATF reports the same PHY ID as the TP version. Therefore use a dummy
>> PHY ID.  This PHY driver is used by the RTL8127ATF support in r8169.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  MAINTAINERS                            |  1 +
>>  drivers/net/phy/realtek/realtek_main.c | 54 ++++++++++++++++++++++++++
>>  include/linux/realtek_phy.h            |  7 ++++
>>  3 files changed, 62 insertions(+)
>>  create mode 100644 include/linux/realtek_phy.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 765ad2daa21..6ede656b009 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -9416,6 +9416,7 @@ F:	include/linux/phy_link_topology.h
>>  F:	include/linux/phylib_stubs.h
>>  F:	include/linux/platform_data/mdio-bcm-unimac.h
>>  F:	include/linux/platform_data/mdio-gpio.h
>> +F:	include/linux/realtek_phy.h
>>  F:	include/trace/events/mdio.h
>>  F:	include/uapi/linux/mdio.h
>>  F:	include/uapi/linux/mii.h
>> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
>> index eb5b540ada0..b57ef0ce15a 100644
>> --- a/drivers/net/phy/realtek/realtek_main.c
>> +++ b/drivers/net/phy/realtek/realtek_main.c
>> @@ -16,6 +16,7 @@
>>  #include <linux/module.h>
>>  #include <linux/delay.h>
>>  #include <linux/clk.h>
>> +#include <linux/realtek_phy.h>
>>  #include <linux/string_choices.h>
>>  
>>  #include "../phylib.h"
>> @@ -2100,6 +2101,45 @@ static irqreturn_t rtl8221b_handle_interrupt(struct phy_device *phydev)
>>  	return IRQ_HANDLED;
>>  }
>>  
>> +static int rtlgen_sfp_get_features(struct phy_device *phydev)
>> +{
>> +	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
>> +			 phydev->supported);
>> +
>> +	/* set default mode */
>> +	phydev->speed = SPEED_10000;
>> +	phydev->duplex = DUPLEX_FULL;
>> +
>> +	phydev->port = PORT_FIBRE;
>> +
>> +	return 0;
>> +}
>> +
>> +static int rtlgen_sfp_read_status(struct phy_device *phydev)
>> +{
>> +	int val, err;
>> +
>> +	err = genphy_update_link(phydev);
>> +	if (err)
>> +		return err;
>> +
>> +	if (!phydev->link)
>> +		return 0;
>> +
>> +	val = rtlgen_read_vend2(phydev, RTL_VND2_PHYSR);
> 
> This should be the same as
> phy_read(phydev, MII_RESV2); /* on page 0 */
> Please try.
> 

In case of an integrated PHY a phy_read() effectively is translated
into a rtlgen_read_vend2(). So technically there's no benefit.

I don't have hw with RTL8127ATF, but maybe Fabio can test.

> 
>> +	if (val < 0)
>> +		return val;
>> +
>> +	rtlgen_decode_physr(phydev, val);
>> +
>> +	return 0;
>> +}
>> +
>> +static int rtlgen_sfp_config_aneg(struct phy_device *phydev)
>> +{
>> +	return 0;
>> +}
>> +
>>  static struct phy_driver realtek_drvs[] = {
>>  	{
>>  		PHY_ID_MATCH_EXACT(0x00008201),
>> @@ -2361,6 +2401,20 @@ static struct phy_driver realtek_drvs[] = {
>>  		.write_page	= rtl821x_write_page,
>>  		.read_mmd	= rtl822x_read_mmd,
>>  		.write_mmd	= rtl822x_write_mmd,
>> +	}, {
>> +		PHY_ID_MATCH_EXACT(PHY_ID_RTL_DUMMY_SFP),
>> +		.name		= "Realtek SFP PHY Mode",
>> +		.flags		= PHY_IS_INTERNAL,
>> +		.probe		= rtl822x_probe,
>> +		.get_features	= rtlgen_sfp_get_features,
>> +		.config_aneg	= rtlgen_sfp_config_aneg,
>> +		.read_status	= rtlgen_sfp_read_status,
>> +		.suspend	= genphy_suspend,
>> +		.resume		= rtlgen_resume,
>> +		.read_page	= rtl821x_read_page,
>> +		.write_page	= rtl821x_write_page,
>> +		.read_mmd	= rtl822x_read_mmd,
>> +		.write_mmd	= rtl822x_write_mmd,
>>  	}, {
>>  		PHY_ID_MATCH_EXACT(0x001ccad0),
>>  		.name		= "RTL8224 2.5Gbps PHY",
>> diff --git a/include/linux/realtek_phy.h b/include/linux/realtek_phy.h
>> new file mode 100644
>> index 00000000000..d683bc1b065
>> --- /dev/null
>> +++ b/include/linux/realtek_phy.h
>> @@ -0,0 +1,7 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _REALTEK_PHY_H
>> +#define _REALTEK_PHY_H
>> +
>> +#define	PHY_ID_RTL_DUMMY_SFP	0x001ccbff
>> +
>> +#endif /* _REALTEK_PHY_H */
>> -- 
>> 2.52.0
>>
>>


