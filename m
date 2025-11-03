Return-Path: <netdev+bounces-235236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF19C2E107
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 21:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1A03BD9C5
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 20:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA48D2C11E6;
	Mon,  3 Nov 2025 20:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lR+/nVFg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DFE2C0281
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 20:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762203021; cv=none; b=M/43R3o3t83eH5PtEKlxazLNq5B3Op8alXbzsdGMCaCrbVYoltR9jJDt94NGntTRgwB40Uw2sXztyCK5k//GblnH/TSwqv/W27a7eDto+Wq+EbFwQOk0aVZVgQrociYSUMnYB2qpPzyinFKyPQuHDQEbFqoa2PSbT0K3fTq56jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762203021; c=relaxed/simple;
	bh=ASoxwqyPUordeB82RphOTD4iTbLsCvF+hUVNiCe4DoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c6pRMLLXywCxjTJm2QDCEuUWS3ShaDa1PB/f58u+ykhns7txVIJ41kThrbQjWroDfLJHOCy/qaMBdcRs/F4cZDmqzAEFOFh5FPCd3CD0jbS0VVIDmJKtajC9LqYTwqFMR86gsbF8BkKYzZePsBZk2XGugPx7i+Onx8oBbbLuJuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lR+/nVFg; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4298b865f84so2204267f8f.3
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 12:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762203017; x=1762807817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b4w22LLD3UX7bx42ApRZ5X5ofuySWP/g2gppdWBdfDY=;
        b=lR+/nVFgrGG52HVRG+7SjpONjuD3wzYRCmlYP3glvSQm19q0vTM8j+an6T7CkbTGUo
         uhc2B9qs47VbvynDPkBVJUr/LWdOwc2c6E4ICcLFSQxS4Pfiqb4E1NpN+Y7cW0ZRWBnE
         9Ky3VKbwS1mAJhx5yJYNAZxw+HxtObf+gK9OT/N57Um/XnsKZ7xr57JmAZQVJQNreRGl
         Gkp1+4H1xwHIMxkwTFy215RiLCAQ44VO6tefgVvFpPmAsWGJaAnvcg9nXiWkpcSHhY5k
         F2tAoo+S1zkrZeSkbDekRlrBAqP/aOq30urXmHBuTmjK1YaHb8KdN3h3UY+yC+bHnw4D
         ktSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762203017; x=1762807817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4w22LLD3UX7bx42ApRZ5X5ofuySWP/g2gppdWBdfDY=;
        b=u110pUj0ZKd9c5Ekah9UMasT0QN2XX57cNPLvzFum4Dgz8KXrT0BI9+S6I9L24p013
         c9cNa7kWMWwdQbRr0WLvwRszU6J5CKxsYof+BGM0WFz5ULq+ICfhSwsYFNvwILjYrJbH
         UkzOcoIz2ZDmmJXNHMWxuysuVl1CoR1Bh/QLFWOCgRjSaIQZJ58fkUnNSZLdzIWTPQ/I
         yR4dNeuErcl8QOZ9IRH0OfTQRZCvUG5lxURiC5EufBCLWd8jlzC3HSkcY7ROVKvkHi4x
         Z2h3iICFKsMoyWYHJJ3LNLNscyw0JpgJitZoKlH4E6R9sfnn4uyDLNstonO32GIqk32q
         7w1w==
X-Forwarded-Encrypted: i=1; AJvYcCXuYTPoJ98IkLFN4QDZsFZNaL3HAUTzHd1s4ylzNV2UaM8Wa2CnkTsaN/TZrVDkKhEYZ/XyZlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG+bdbKiDnCr74MZkYSNe4MaC/6psKWesU0Buba4h082WbZkds
	vuy1amYc4VVAtdiHL69Zir8LYjpTBQ9CH2+fT1i2lReXbgx6BVaB+HOg
X-Gm-Gg: ASbGnctAnmo73MlOv2xy2M1SI+6cWN9n4fusnABG80/I1qsa/uDSG+VoYfipWQPQiPT
	iXtH/DXezI7bINp0E+5yoIK9BIajr/r0SFz/mEjqc8F5R/FhLeyrPV47aPTHr7JNc5S1DFzXiK2
	lQFgDsA4jpyVRzzEQlxhAi/BmQ+Wja7O51DGqvnYlq/aAiLV4S3oCUvR+VN/fNmziTJ9NAXYwWd
	5YBvxSXb63nTCaAQ3pvJ8b3S/1aM0ijmo9/EWgyODOcWWN0PwcLjiNeTDTVqOyvVbAkA1PH6q4E
	b2r/EABPbeD42rHW5+LczBXdsMU/8CZJo8kX0m8A6HB8w0RYaNJM4JHItEG3KXUSDUpZosSVLVo
	V2kaOjQ79Ct/2vGh5dC3xRXc8VNFFkVmIaPQLtntWNnssSsNMWHl1GoA+WH0mfcrhcgkRWd8sBe
	kCt31mSZWqSyrbpOVA9dBtTr1KymbG19C0OAyRcU0q+OdZtW6crPhqASSrNcrRGjMywyWlxOIf8
	Nq2YJ0GdZPHzkCE2C2dtz8GhLZPzsRRHOlpvW5/BWuloP7AnwNmSQ==
X-Google-Smtp-Source: AGHT+IF271wwBxiZMKqJRbKwIItsRJWTJP8xxDweDWgoGm4Ae92qjbRgDKqZzye1GJPSQ6M87ogwBQ==
X-Received: by 2002:a05:600c:8b37:b0:46e:49fb:4776 with SMTP id 5b1f17b1804b1-4773bf9c1f8mr87340585e9.11.1762203016995;
        Mon, 03 Nov 2025 12:50:16 -0800 (PST)
Received: from ?IPV6:2003:ea:8f0d:b700:d5d1:9ab3:c77e:dec7? (p200300ea8f0db700d5d19ab3c77edec7.dip0.t-ipconnect.de. [2003:ea:8f0d:b700:d5d1:9ab3:c77e:dec7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c1a03sm295865e9.2.2025.11.03.12.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 12:50:16 -0800 (PST)
Message-ID: <4095b969-ead4-4230-add2-e2b5c0b89a75@gmail.com>
Date: Mon, 3 Nov 2025 21:50:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v2 05/11] net: phy: Add fbnic specific PHY driver
 fbnic_phy
To: Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 linux@armlinux.org.uk, pabeni@redhat.com, davem@davemloft.net
References: <176218882404.2759873.8174527156326754449.stgit@ahduyck-xeon-server.home.arpa>
 <176218923429.2759873.17230953529492488834.stgit@ahduyck-xeon-server.home.arpa>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <176218923429.2759873.17230953529492488834.stgit@ahduyck-xeon-server.home.arpa>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/2025 6:00 PM, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> With this change we are effectively adding a stub PHY driver for the fbnic
> driver to enable it to report link state of the PMA/PMD separately from the
> PCS. This is needed as the firmware will be performing link training when
> the link is first detected and this will in turn cause the PCS to link flap
> if we don't add a delay to the PMD link up process to allow for this.
> 
> With this change we are able to identify the device based on the PMA/PMD
> and PCS pair being used. The logic is mostly in place to just handle the
> link detection and report the correct speed for the link.
> 
> This patch is using the gen10g_config_aneg stub to skip doing any
> configuration for now. Eventually this will likely be replaced as we
> actually start adding configuration bits to the driver.
> 
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> ---
>  MAINTAINERS                 |    1 +
>  drivers/net/phy/Kconfig     |    6 +++++
>  drivers/net/phy/Makefile    |    1 +
>  drivers/net/phy/fbnic_phy.c |   52 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 60 insertions(+)
>  create mode 100644 drivers/net/phy/fbnic_phy.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1ab7e8746299..ce18b92f3157 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16712,6 +16712,7 @@ R:	kernel-team@meta.com
>  S:	Maintained
>  F:	Documentation/networking/device_drivers/ethernet/meta/
>  F:	drivers/net/ethernet/meta/
> +F:	drivers/net/phy/fbnic_phy.c
>  
>  METHODE UDPU SUPPORT
>  M:	Robert Marko <robert.marko@sartura.hr>
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 98700d069191..16d943bbb883 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -230,6 +230,12 @@ config DAVICOM_PHY
>  	help
>  	  Currently supports dm9161e and dm9131
>  
> +config FBNIC_PHY
> +	tristate "FBNIC PHY"
> +	help
> +	  Supports the Meta Platforms 25G/50G/100G Ethernet PHY included in
> +	  fbnic network driver.
> +
>  config ICPLUS_PHY
>  	tristate "ICPlus PHYs"
>  	help
> diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
> index 76e0db40f879..29b47d9d0425 100644
> --- a/drivers/net/phy/Makefile
> +++ b/drivers/net/phy/Makefile
> @@ -59,6 +59,7 @@ obj-$(CONFIG_DP83869_PHY)	+= dp83869.o
>  obj-$(CONFIG_DP83TC811_PHY)	+= dp83tc811.o
>  obj-$(CONFIG_DP83TD510_PHY)	+= dp83td510.o
>  obj-$(CONFIG_DP83TG720_PHY)	+= dp83tg720.o
> +obj-$(CONFIG_FBNIC_PHY)		+= fbnic_phy.o
>  obj-$(CONFIG_FIXED_PHY)		+= fixed_phy.o
>  obj-$(CONFIG_ICPLUS_PHY)	+= icplus.o
>  obj-$(CONFIG_INTEL_XWAY_PHY)	+= intel-xway.o
> diff --git a/drivers/net/phy/fbnic_phy.c b/drivers/net/phy/fbnic_phy.c
> new file mode 100644
> index 000000000000..5b9be27aec32
> --- /dev/null
> +++ b/drivers/net/phy/fbnic_phy.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) Meta Platforms, Inc. and affiliates. */
> +
> +#include <linux/ethtool.h>
> +#include <linux/kernel.h>
> +#include <linux/mdio.h>
> +#include <linux/module.h>
> +#include <linux/pcs/pcs-xpcs.h>
> +#include <linux/phylink.h>
> +
> +MODULE_DESCRIPTION("Meta Platforms FBNIC PHY driver");
> +MODULE_LICENSE("GPL");
> +
> +static int fbnic_phy_match_phy_device(struct phy_device *phydev,
> +				      const struct phy_driver *phydrv)
> +{
> +	u32 *device_ids = phydev->c45_ids.device_ids;
> +
> +	return device_ids[MDIO_MMD_PMAPMD] == MP_FBNIC_XPCS_PMA_100G_ID &&
> +	       device_ids[MDIO_MMD_PCS] == DW_XPCS_ID;
> +}
> +
> +static int fbnic_phy_get_features(struct phy_device *phydev)
> +{
> +	phylink_set(phydev->supported, 100000baseCR2_Full);

Better not use phylink functionality in phylib. Use linkmode_set_bit()
instead, internally it uses __set_bit() as well.

> +	phylink_set(phydev->supported, 50000baseCR_Full);
> +	phylink_set(phydev->supported, 50000baseCR2_Full);
> +	phylink_set(phydev->supported, 25000baseCR_Full);
> +
> +	return 0;
> +}
> +
> +static struct phy_driver fbnic_phy_driver[] = {
> +{
> +	.phy_id			= MP_FBNIC_XPCS_PMA_100G_ID,
> +	.phy_id_mask		= 0xffffffff,

You can use helper macro PHY_ID_MATCH_EXACT here.

> +	.name			= "Meta Platforms FBNIC PHY Driver",
> +	.match_phy_device	= fbnic_phy_match_phy_device,
> +	.get_features		= fbnic_phy_get_features,
> +	.read_status		= genphy_c45_read_status,
> +	.config_aneg		= gen10g_config_aneg,
> +},
> +};
> +
> +module_phy_driver(fbnic_phy_driver);
> +
> +static const struct mdio_device_id __maybe_unused fbnic_phy_tbl[] = {
> +	{ MP_FBNIC_XPCS_PMA_100G_ID, 0xffffffff },

Here PHY_ID_MATCH_EXACT can be used too.

> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(mdio, fbnic_phy_tbl);
> 
> 


