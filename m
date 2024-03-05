Return-Path: <netdev+bounces-77384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB3E871812
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 09:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B8828202D
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 08:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1777F7E5;
	Tue,  5 Mar 2024 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsVx+IO1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF0B7F7C2;
	Tue,  5 Mar 2024 08:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626786; cv=none; b=uDuUe/0WghoX5TnKdlbsKFi6FpKowiOR3vheSW/Gv9Ct5WumeeXKNq4Da7U/GpoeE+5i7CA/dwixfidLhHwTpfDQA/X4NwlqzWfzLU5bbZlzSUMNLY+izJAz/OIyohqpncsu/D1dAOpu2VGcDbjJSD3wX8jDCpzbiJ8Tuu4t8Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626786; c=relaxed/simple;
	bh=yILf5AoVfHHCLDfKAxRlraaEjQ7Tpp8BUIDMHFp33gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGSm6ZeV5MR53Y4QvuCR7LBkEPjqcjE/Q4sMA4N4PUK0KrAuOz7tlz1ZIhA3wlnsaG34o0Kw3J86WmGcACEmpEy+Eq5U4856030uSnW/JLlITAaFOYy4YkteT/HPk5kt15BMPesK9rN4CP4FH+PeZrjMcpPCd/dRYgp7tw+nAKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsVx+IO1; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3566c0309fso42080266b.1;
        Tue, 05 Mar 2024 00:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709626782; x=1710231582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eiy1+7xB7pJpSpPHr3BeX1TKKAf/bkD84DN6JeYSuPU=;
        b=HsVx+IO19Hab2UyJDyVb1PaylcOYH+kMb67L+QGSBp9nrRk4uY52Z83V+RdKvtjU7e
         2ItXB18CVlH/dV6DUjKdEuPxlORc2tgPltYEmxY0akXdvnnmXSBtQo3Px7gn6bnClehv
         sJKc0QFAivy5A0SkB0yPMJP9vNPaFpFtMUR29675c4zrpgj5f4nQ1ssL0RURVX4hzxaT
         AFqoo5HOHj9nrLD4+7szVgzQ05dLE3W+busQ9m6TfYUShNmwMD/QjBD6YPbHs9FPMtmg
         q5heBF6DPRYtEauZKSop4lQ7uoe2L/ccr9pSHUHICpWPzT4AljUZheFCuyJYluwrkpGl
         vDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709626782; x=1710231582;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eiy1+7xB7pJpSpPHr3BeX1TKKAf/bkD84DN6JeYSuPU=;
        b=u86+tmcbgjstDHYgEFytJjGU9g/iHt/srDQooKYjuULt4hDFMcdDUVN/2n+v6cH6Na
         8rMAKm1UwSQaLq/s2/h18J1E6l7LbqxUG3Ab8YYUBk/QLf4D3pp8CImyflaS174eUl5P
         jyx8LvdoUu8PsTl4qgVkznAXWBlURChAKQR66+pyFgn4RrRbsyenjJDheYSI7gR6k0ti
         sxYX1jq729ouO1rQDoBzf4hhY7SFMJFmEgnxeAFKa3qRXWBwtii+KDNZjS5v2pBNVXfU
         sVAYNtPJoWiwnAEIzkd5Y96ubJlpbgOIfLLIIqYZaVX7U2kxXOFB9MduGeW/jCeMt6SN
         J+PA==
X-Forwarded-Encrypted: i=1; AJvYcCUByowrkSo7LbBwMjcICQUS2wEUiZ9PdsGKxbOqbMC8cOxEZMySsoUoW5Noo9o1X5W5LRYtR3yhI3Incp+FII6fRnxqOvYkhfWAdhXTHtFwtQJCjGuc0MmN9znGxSG2TXmqjw==
X-Gm-Message-State: AOJu0YwNROjPk9mUik96rDJMTSVXbpCbstjmZ28qpYrcUOmpf4Q6VKXW
	KXSVjSmUmWSineoMXN3/HnjyZnJeW8jaVi2yN4DsQOv5J++3m3Ow
X-Google-Smtp-Source: AGHT+IEYw1b9zEUZHaT+G1uzDKmbGyaduURr3uNUW5l34SzqKn7DCGT9teB8ghO/a+oKDWSgBPB/Lg==
X-Received: by 2002:a17:906:a411:b0:a45:89d1:3a with SMTP id l17-20020a170906a41100b00a4589d1003amr1724596ejz.41.1709626782281;
        Tue, 05 Mar 2024 00:19:42 -0800 (PST)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id yk1-20020a17090770c100b00a42f4678c95sm5750382ejb.59.2024.03.05.00.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 00:19:41 -0800 (PST)
Message-ID: <aeb9f17c-ea94-4362-aeda-7d94c5845462@gmail.com>
Date: Tue, 5 Mar 2024 09:19:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 2/2] net: phy: air_en8811h: Add the Airoha
 EN8811H PHY driver
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>, Lucien Jheng
 <lucien.jheng@airoha.com>, Zhi-Jun You <hujy652@protonmail.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
References: <20240302183835.136036-1-ericwouds@gmail.com>
 <20240302183835.136036-3-ericwouds@gmail.com>
 <e056b4ac-fffb-41d9-a357-898e35e6d451@lunn.ch>
From: Eric Woudstra <ericwouds@gmail.com>
In-Reply-To: <e056b4ac-fffb-41d9-a357-898e35e6d451@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/3/24 18:51, Andrew Lunn wrote:
>> +static int en8811h_config_init(struct phy_device *phydev)
>> +{
>> +	struct en8811h_priv *priv = phydev->priv;
>> +	struct device *dev = &phydev->mdio.dev;
>> +	int ret, pollret, reg_value;
>> +	u32 pbus_value;
>> +
>> +	if (!priv->firmware_version)
>> +		ret = en8811h_load_firmware(phydev);
> 
> How long does this take for your hardware?

It takes 1.87 and 0.24 seconds to load the firmware files.

> We have a phylib design issue with loading firmware. It would be
> better if it happened during probe, but it might not be finished by
> the time the MAC driver tries to attach to the PHY and so that fails.
> This is the second PHY needing this, so maybe we need to think about
> adding a thread kicked off in probe to download the firmware? But
> probably later, not part of this patchset.

The main reason I have it in config_init() is that by then the
rootfs is available. The EN8811H does not depend on the firmware
to respond to get_features(). It is therefore possible to not
have the firmware in initramfs or included in the kernel image.
I could not get this result using EPROBE_DEFER, I think this is
not an option in phylink.

It does however work, loading firmware in probe(), without running
a thread, so it is possible to have it there.

>> +	/* Select mode 1, the only mode supported */
> 
> Maybe a comment about what mode 1 actually is?

I'll need to contact Airoha to get a better description. There
should be a datasheet coming for external use, but it isn't
published yet.

>> +	ret = air_leds_init(phydev, EN8811H_LED_COUNT, AIR_PHY_LED_DUR,
>> +			    AIR_LED_MODE_USER_DEFINE);
>> +	if (ret < 0) {
>> +		phydev_err(phydev, "Failed to initialize leds: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = air_buckpbus_reg_modify(phydev, EN8811H_GPIO_OUTPUT,
>> +				      EN8811H_GPIO_OUTPUT_345,
>> +				      EN8811H_GPIO_OUTPUT_345);
> 
> What does this do? Configure them as inputs? Hopefully they are inputs
> by default, or at least Hi-Z.

I'll add a comment that it set's these 3 gpio's as output for the leds.

>> +static int en8811h_get_features(struct phy_device *phydev)
>> +{
>> +	linkmode_set_bit_array(phy_basic_ports_array,
>> +			       ARRAY_SIZE(phy_basic_ports_array),
>> +			       phydev->supported);
>> +
>> +	return genphy_c45_pma_read_abilities(phydev);
>> +}
>> +
> 
>> +static int en8811h_config_aneg(struct phy_device *phydev)
>> +{
>> +	bool changed = false;
>> +	int ret;
>> +	u32 adv;
>> +
>> +	adv = linkmode_adv_to_mii_10gbt_adv_t(phydev->advertising);
>> +
>> +	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
>> +				     MDIO_AN_10GBT_CTRL_ADV2_5G, adv);
>> +	if (ret < 0)
>> +		return ret;
>> +	if (ret > 0)
>> +		changed = true;
>> +
>> +	return __genphy_config_aneg(phydev, changed);
> 
> There was a comment that it does not support forced link mode, only
> auto-neg? It would be good to test the configuration here and return
> EOPNOTSUPP, or EINVAL if auto-neg is turned off.
> 
>> +}
>> +
>> +static int en8811h_read_status(struct phy_device *phydev)
>> +{
>> +	struct en8811h_priv *priv = phydev->priv;
>> +	u32 pbus_value;
>> +	int ret, val;
>> +
>> +	ret = genphy_update_link(phydev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	phydev->master_slave_get = MASTER_SLAVE_CFG_UNSUPPORTED;
>> +	phydev->master_slave_state = MASTER_SLAVE_STATE_UNSUPPORTED;
>> +	phydev->speed = SPEED_UNKNOWN;
>> +	phydev->duplex = DUPLEX_UNKNOWN;
>> +	phydev->pause = 0;
>> +	phydev->asym_pause = 0;
>> +
>> +	ret = genphy_read_master_slave(phydev);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = genphy_read_lpa(phydev);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* Get link partner 2.5GBASE-T ability from vendor register */
>> +	ret = air_buckpbus_reg_read(phydev, EN8811H_2P5G_LPA, &pbus_value);
>> +	if (ret < 0)
>> +		return ret;
>> +	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
>> +			 phydev->lp_advertising,
>> +			 pbus_value & EN8811H_2P5G_LPA_2P5G);
>> +
>> +	if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete)
> 
> Is the first part of that expression needed? I thought you could not
> turn auto-neg off?

Will returning an error in config_aneg() prevent auto-neg being disabled?
If so, then indeed I could drop the first part then.

>> +
>> +	/* Only supports full duplex */
>> +	phydev->duplex = DUPLEX_FULL;
> 
> What does en8811h_get_features() indicate the PHY can do? Are any 1/2
> duplex modes listed?


Partial output from ethtool:

	Supported ports: [ TP	 MII ]
	Supported link modes:   100baseT/Full
	                        1000baseT/Full
	                        2500baseT/Full
	Supported pause frame use: Symmetric Receive-only
	Supports auto-negotiation: Yes
	Supported FEC modes: Not reported
	Advertised link modes:  100baseT/Full
	                        1000baseT/Full
	                        2500baseT/Full
	Advertised pause frame use: Symmetric Receive-only
	Advertised auto-negotiation: Yes
	Advertised FEC modes: Not reported

Best regards,

Eric Woudstra

