Return-Path: <netdev+bounces-109437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F129287A3
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79691F212A0
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 11:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FFB147C82;
	Fri,  5 Jul 2024 11:17:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D4381E
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 11:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178234; cv=none; b=lp87UxVtRsRzatGVa7WfpFlEIA+fjlmfTjhMSwIeR7HwPAyGRWbM/hX4zWmzQhwgsRCM1tnOxUX0KmHoUwxZ97Y46rxCU2aY/Fn//dGjSchD/EPb9llcpcBhAu4sCQRVJRclpzh8BtahybMqXP8J9K4sdkvavdcHDQCfORk2lkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178234; c=relaxed/simple;
	bh=QsB+MYEQdszykCoRrIhVLYYaYUO6A/XKh7U5tr2SlnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zv+DvMpf4TEbTEnKsVt7HIwcZWkA4d8/oiwKcZnvSoW3xSCYWe4GVPxffdaYqEaYWB1JROrUFU/cFFBDyt1BNAAzTv2qN0tt2UwuIKsgpqepj7jCZ++cdxwuntaCzkBb5TkBFYUTtmqvPzcDgn85cezjwz6jNQRlWw6kKkErN9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.2])
	by gateway (Coremail) with SMTP id _____8DxS_Aw1odmukcBAA--.3926S3;
	Fri, 05 Jul 2024 19:17:04 +0800 (CST)
Received: from [192.168.100.8] (unknown [223.64.68.2])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxUcQt1odmx088AA--.37697S3;
	Fri, 05 Jul 2024 19:17:02 +0800 (CST)
Message-ID: <b8329de3-150a-4f71-bf53-cc52c513a620@loongson.cn>
Date: Fri, 5 Jul 2024 19:17:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 12/15] net: stmmac: Fixed failure to set
 network speed to 1000.
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Serge Semin <fancer.lancer@gmail.com>
Cc: si.yanteng@linux.dev, Huacai Chen <chenhuacai@kernel.org>,
 hkallweit1@gmail.com, peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, Jose.Abreu@synopsys.com, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <e7ae2409f68a2f953ba7c823e248de7d67dfd4e9.1716973237.git.siyanteng@loongson.cn>
 <CAAhV-H6ZJwWQOhAPmoaH4KYr66LCurKq94f87FQ05yEX6XYoNg@mail.gmail.com>
 <ZlgpLm3L6EdFO60f@shell.armlinux.org.uk>
 <6ba14d835ff12f479eeced585b9336c1e6219d54@linux.dev>
 <gndedhwq6q6ou56nxnld6irkv4curb7mql4sy2i4wx5qnqksoh@6kpyuozs656l>
 <ZoQX1bqtJI2Zd9qH@shell.armlinux.org.uk>
 <hdqpsuq7n4aalav7jtzttfksw5ct36alowsc65e72armjt2h67@shph7z32rbc6>
 <ZoWex6T0QbRBmDFE@shell.armlinux.org.uk>
 <eb4bed28-c04e-4098-b947-e9fc626ba478@lunn.ch>
 <ZoW1fNqV3PxEobFx@shell.armlinux.org.uk>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <ZoW1fNqV3PxEobFx@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxUcQt1odmx088AA--.37697S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxXw4fCFy7XrW8Kw1ftF48Xwc_yoWrAry8p3
	y8Ga48Jr9rKrWa93WDCw1DAF1Uur4S9a48J34UK39Ykwn8ZryDt3WIkr43JF1fZr1kuFWj
	vws5CFyUAa1Du3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8uc_3UUUUU==

Hi all,


Thanks for your comments!


在 2024/7/4 04:33, Russell King (Oracle) 写道:
> On Wed, Jul 03, 2024 at 09:09:53PM +0200, Andrew Lunn wrote:
>>> Rather than erroring out, I think it may be better to just adopt
>>> the Marvell solution to this problem to give consistent behaviour
>>> across all PHYs.
>> Yes, expand phy_config_aneg() to look for this condition and enable
>> autoneg. But should we disable it when the condition is reverted? The
>> user swaps to 100Mbps forced?
> I think we should "lie" to userspace rather than report how the
> hardware was actually programmed - again, because that's what would
> happen with Marvell Alaska.
>
>> What about other speeds? Is this limited to 1G? Since we have devices
>> without auto-neg for 2500BaseX i assume it is not an issue there.
> 1000base-X can have AN disabled - that's not an issue. Yes, there's
> the ongoing issues with 2500base-X. 10Gbase-T wording is similar to
> 1000base-T, so we probably need to do similar there. Likely also the
> case for 2500base-T and 5000base-T as well.
>
> So I'm thinking of something like this (untested):
>
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 6c6ec9475709..197c4d5ab55b 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -2094,22 +2094,20 @@ EXPORT_SYMBOL(phy_reset_after_clk_enable);
>   /**
>    * genphy_config_advert - sanitize and advertise auto-negotiation parameters
>    * @phydev: target phy_device struct
> + * @advert: auto-negotiation parameters to advertise
>    *
>    * Description: Writes MII_ADVERTISE with the appropriate values,
>    *   after sanitizing the values to make sure we only advertise
>    *   what is supported.  Returns < 0 on error, 0 if the PHY's advertisement
>    *   hasn't changed, and > 0 if it has changed.
>    */
> -static int genphy_config_advert(struct phy_device *phydev)
> +static int genphy_config_advert(struct phy_device *phydev,
> +				const unsigned long *advert)
>   {
>   	int err, bmsr, changed = 0;
>   	u32 adv;
>   
> -	/* Only allow advertising what this PHY supports */
> -	linkmode_and(phydev->advertising, phydev->advertising,
> -		     phydev->supported);
> -
> -	adv = linkmode_adv_to_mii_adv_t(phydev->advertising);
> +	adv = linkmode_adv_to_mii_adv_t(advert);
>   
>   	/* Setup standard advertisement */
>   	err = phy_modify_changed(phydev, MII_ADVERTISE,
> @@ -2132,7 +2130,7 @@ static int genphy_config_advert(struct phy_device *phydev)
>   	if (!(bmsr & BMSR_ESTATEN))
>   		return changed;
>   
> -	adv = linkmode_adv_to_mii_ctrl1000_t(phydev->advertising);
> +	adv = linkmode_adv_to_mii_ctrl1000_t(advert);
>   
>   	err = phy_modify_changed(phydev, MII_CTRL1000,
>   				 ADVERTISE_1000FULL | ADVERTISE_1000HALF,
> @@ -2356,6 +2354,9 @@ EXPORT_SYMBOL(genphy_check_and_restart_aneg);
>    */
>   int __genphy_config_aneg(struct phy_device *phydev, bool changed)
>   {
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(fixed_advert);
> +	const struct phy_setting *set;
> +	unsigned long *advert;
>   	int err;
>   
>   	err = genphy_c45_an_config_eee_aneg(phydev);
> @@ -2370,10 +2371,25 @@ int __genphy_config_aneg(struct phy_device *phydev, bool changed)
>   	else if (err)
>   		changed = true;
>   
> -	if (AUTONEG_ENABLE != phydev->autoneg)
> +	if (phydev->autoneg == AUTONEG_ENABLE) {
> +		/* Only allow advertising what this PHY supports */
> +		linkmode_and(phydev->advertising, phydev->advertising,
> +			     phydev->supported);
> +		advert = phydev->advertising;
> +	} else if (phydev->speed < SPEED_1000) {
>   		return genphy_setup_forced(phydev);
> +	} else {
> +		linkmode_zero(fixed_advert);
> +
> +		set = phy_lookup_setting(phydev->speed, phydev->duplex,
> +					 phydev->supported, true);
> +		if (set)
> +			linkmode_set(set->bit, fixed_advert);
> +
> +		advert = fixed_advert;
> +	}
>   
> -	err = genphy_config_advert(phydev);
> +	err = genphy_config_advert(phydev, advert);
>   	if (err < 0) /* error */
>   		return err;
>   	else if (err)

It looks great, but I still want to follow Russell's earlier advice and 
drop this patch

from v14, then submit it separately with the above code.


Thanks,

Yanteng


