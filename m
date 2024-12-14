Return-Path: <netdev+bounces-151971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7579F218C
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 00:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8EE1666AF
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 23:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B577B1B1D61;
	Sat, 14 Dec 2024 23:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AR3sRWYC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C805E168B1
	for <netdev@vger.kernel.org>; Sat, 14 Dec 2024 23:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734219508; cv=none; b=jE2Fj3MCd2N5sGKIcAhdCVyR8XV55YyzRiFdNT4Ef38AZBSwF/yyTBlq/XzJ1wW64p7SHrdDFLROmUSU5L8FWF9F5U7j7PoyEu3g3y4MhZgA0k8M+VKDGt0uLzwhEHSw1u/QbNECHv+d8Snenjv978ZgdSjhjHk043FosNzuIYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734219508; c=relaxed/simple;
	bh=VNmFrvrf2y6bjr3UB3klhdUIxz+x06qJ0iMSpv+oIrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGs+HnfglRF8moRXW8DQ4jrcxn0CONnher0v3KnWENSOAlnAn6uLIC1RlCa2Mo+rcUDGGrbMgewEohTa8MKYG0BQkGKIome3QPcw5RrTq7wQpOfHxH+OLPea+NVTxRA5uId7j3uPhlzXUH0hovvnt29aw+bVs0reFOgYmLmsuNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AR3sRWYC; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso458275666b.1
        for <netdev@vger.kernel.org>; Sat, 14 Dec 2024 15:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734219505; x=1734824305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G6jrWjAZwvK7hfwJDuP5m8OpTTnhtIJChsop6f82VfE=;
        b=AR3sRWYCoTQRnWaOAnkF3i47NPzxd6Hv2GQ3uUj6YSBPQ3/8lgpPmLm1IsBa9nK1yn
         M/AoDOqG3CAwURyE6YSO8PAM6TE8MnfRj5YkvuQ9k1TlJHpQhUGZOq+gdwc+gqi2Ygjo
         iJx4Y4LjKl+GQft9pZ+aBJQFYfs46hgp3KVgNUS6gpZ0B0tgQlKDqHNG/S1+3sRrZasz
         IlBUwY4at6icmaCE2EjrYqGtU8Jyy1TT3IhJkfFDbY9uF5h/299DtBI3q1zLX51RYDqz
         STRA6+XwXMX7GuB/Ad1RyicdCwOkNKhKpCokjpW5hK9KI0Kj4YfHOIdKkYeV5GB/cXww
         7qdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734219505; x=1734824305;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6jrWjAZwvK7hfwJDuP5m8OpTTnhtIJChsop6f82VfE=;
        b=EVj6aVx7byjjJmaq2FBd6IS5Ddngm6Ihs042ggNJaWBrp2qUIOjXQXoVud7yQu7ytI
         OqXBwlKJ7Xm5EkJNdtMieWMz09mz5jF94QMeelZs6vy+tgujHY3/xpibpefssMBMyP/r
         JzN0yk9TADyP/3zG8G5NK4nBGwSNALSkSYOkF5KW5lo/iV0zPPWoJslhVU6WU4T1ZcQ7
         pvaVwk6sXqbtoeUwowbHDIpZq4oyXGfSn9J9U54GvlO63uVtBmsM3mNRdTwgmH5w0XdE
         Bb+0O9lxkA60I2PovkvqTlFCl3+jC6sGsLcOvCcY/FJOQojdOzisCfQRIyR2KvnQBU50
         c7cg==
X-Forwarded-Encrypted: i=1; AJvYcCXLRi5qWV2LX4ViVCmztGavp/j10wfJww1UeAExBI5V8x1Ex5sdghPaZNvdvupEa0hhY6GEBio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9UUEhzxq0V3V/bvwZSh77ZPR4H6rjd1NT8hl8yxVBnrA4h2mI
	kOUl6eDINdqPg4XE+Nkpr6xWj6AWouNrzWgNbYEor5or8itI1hZz
X-Gm-Gg: ASbGnctPwkeTiKcQLiCyKP4uXEigT5QAVwHbwe5cJgdbHacOD/C+xKmmaf001yfnA7V
	IbFKfh1qFLWsepgzLQnJag4sQYB/hwA9lybz6JuwSXJP8joEuLp0r8u6cfdXtNMIlog2ZT9rGc3
	8uSf/eR4jZZqj0e3qjcKRDQ8++KXBzhKd5hru9cA8ONW2fgxjxymhzSMyc/rAnjN/QTk1FxWnpt
	y8qoCCeNiyQoTrkA3JOu7fcisCnPZEbxS7i1I02ozY3cJ46vvQMT88BTR6kFe49328vpPMPZMFv
	3bq4Y6rT+DhWQQQXyVFqamR1941lewEAGcCcyTlKHwV8lMxh76x82cGbraBBcBLu1Z4wWA3OGRO
	QL1+DPF5C1AGxaLc+6VJH3zf6CU0d9J8q6VleKUJb3HHRx1PD
X-Google-Smtp-Source: AGHT+IG0Ifcd9xWTkoSakLay6Tr50sNpDBsPxdJzaAA/OyWC984APArBTTYqI50PpduVKmmPaUkt+g==
X-Received: by 2002:a17:907:7b9f:b0:aa9:1b4b:461f with SMTP id a640c23a62f3a-aab77909ec0mr613935666b.21.1734219504766;
        Sat, 14 Dec 2024 15:38:24 -0800 (PST)
Received: from ?IPV6:2a02:3100:ae45:5500:4002:d148:8dad:f5aa? (dynamic-2a02-3100-ae45-5500-4002-d148-8dad-f5aa.310.pool.telefonica.de. [2a02:3100:ae45:5500:4002:d148:8dad:f5aa])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aab9638ace9sm144764466b.136.2024.12.14.15.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 15:38:23 -0800 (PST)
Message-ID: <928c2613-b028-4073-818c-5cf38bd304ca@gmail.com>
Date: Sun, 15 Dec 2024 00:38:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/10] net: phylink: add EEE management
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 Bryan Whitehead <bryan.whitehead@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 UNGLinuxDriver@microchip.com
References: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
 <E1tKefi-006SMp-Hw@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <E1tKefi-006SMp-Hw@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09.12.2024 15:23, Russell King (Oracle) wrote:
> Add EEE management to phylink, making use of the phylib implementation.
> This will only be used where a MAC driver populates the methods and
> capabilities bitfield, otherwise we keep our old behaviour.
> 
> Phylink will keep track of the EEE configuration, including the clock
> stop abilities at each end of the MAC to PHY link, programming the PHY
> appropriately and preserving the EEE configuration should the PHY go
> away.
> 
> It will also call into the MAC driver when LPI needs to be enabled or
> disabled, with the expectation that the MAC have LPI disabled during
> probe.
> 
> Support for phylink managed EEE is enabled by populating both tx_lpi
> MAC operations method pointers.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/phy/phylink.c | 123 ++++++++++++++++++++++++++++++++++++--
>  include/linux/phylink.h   |  44 ++++++++++++++
>  2 files changed, 163 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 03509fdaa1ec..750356b6a2e9 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -81,12 +81,19 @@ struct phylink {
>  	unsigned int pcs_state;
>  
>  	bool link_failed;
> +	bool mac_supports_eee;
> +	bool phy_enable_tx_lpi;
> +	bool mac_enable_tx_lpi;
> +	bool mac_tx_clk_stop;
> +	u32 mac_tx_lpi_timer;
>  
>  	struct sfp_bus *sfp_bus;
>  	bool sfp_may_have_phy;
>  	DECLARE_PHY_INTERFACE_MASK(sfp_interfaces);
>  	__ETHTOOL_DECLARE_LINK_MODE_MASK(sfp_support);
>  	u8 sfp_port;
> +
> +	struct eee_config eee_cfg;
>  };
>  
>  #define phylink_printk(level, pl, fmt, ...) \
> @@ -1563,6 +1570,47 @@ static const char *phylink_pause_to_str(int pause)
>  	}
>  }
>  
> +static void phylink_deactivate_lpi(struct phylink *pl)
> +{
> +	if (pl->mac_enable_tx_lpi) {
> +		pl->mac_enable_tx_lpi = false;
> +
> +		phylink_dbg(pl, "disabling LPI\n");
> +
> +		pl->mac_ops->mac_disable_tx_lpi(pl->config);
> +	}
> +}
> +
> +static void phylink_activate_lpi(struct phylink *pl)
> +{
> +	if (!test_bit(pl->cur_interface, pl->config->lpi_interfaces)) {
> +		phylink_dbg(pl, "MAC does not support LPI with %s\n",
> +			    phy_modes(pl->cur_interface));
> +		return;
> +	}
> +
> +	phylink_dbg(pl, "LPI timer %uus, tx clock stop %u\n",
> +		    pl->mac_tx_lpi_timer, pl->mac_tx_clk_stop);
> +
> +	pl->mac_ops->mac_enable_tx_lpi(pl->config, pl->mac_tx_lpi_timer,
> +				       pl->mac_tx_clk_stop);
> +
> +	pl->mac_enable_tx_lpi = true;
> +}
> +
> +static void phylink_phy_restrict_eee(struct phylink *pl, struct phy_device *phy)
> +{
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(eee_supported);
> +
> +	/* Convert the MAC's LPI capabilities to linkmodes */
> +	linkmode_zero(eee_supported);
> +	phylink_caps_to_linkmodes(eee_supported, pl->config->lpi_capabilities);
> +
> +	/* Mask out EEE modes that are not supported */
> +	linkmode_and(phy->supported_eee, phy->supported_eee, eee_supported);
> +	linkmode_and(phy->advertising_eee, phy->advertising_eee, eee_supported);
> +}
> +

Something similar we may need in phylib too. An example is cpsw MAC driver which
doesn't support EEE. Issues have been reported if the PHY's on both sides negotiate
EEE, workaround is to use property eee-broken-xxx in the respective DT's to disable
PHY EEE advertisement. I'm thinking of adding a simple phy_disable_eee() which can
be called by MAC drivers to clear EEE supported and advertising bitmaps.

A similar case is enetc (using phylink) which doesn't support EEE. See following in
enetc.c:

/* disable EEE autoneg, until ENETC driver supports it */
memset(&edata, 0, sizeof(struct ethtool_keee));
phylink_ethtool_set_eee(priv->phylink, &edata);

Russell, do you plan to change this driver too, based on phylink extensions?
I think already now, based on the quoted code piece, several (all?) eee-broken-xxx
properties can be removed under arch/arm64/boot/dts/freescale .


