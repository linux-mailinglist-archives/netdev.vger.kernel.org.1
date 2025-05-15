Return-Path: <netdev+bounces-190823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3078BAB8FC2
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 21:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64AF4E7F1C
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 19:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BA225C6FA;
	Thu, 15 May 2025 19:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6kINsot"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD16DDC1;
	Thu, 15 May 2025 19:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747336520; cv=none; b=ICymRd4JiFhZCfmz/9wwnb8JlKL5SYwbp8XAQkJIQngBxscDlfU+I4w7MKWGlhoI8KCXiYonc4BSFfVmfozBnS3LXOHS5gG1YgrzyrldYy67JP7ICmz1HUB9YM65GJr//dZZuMLfqJsS/vwuh9kJzA3Sf3PlwTQSR4ihCX7MrDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747336520; c=relaxed/simple;
	bh=taVxY5lXTqEl8All4xxd0KsbyD4M+RP4p4Ec52830JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LivmAb+BBpzVTS/yGqf1FggZ/YLiiqTV4gNRBIPspSHMuI3fm3fTjD3UzaG7KtqxTo7vVJNwqZ+as9hNo3sB7w7ZtVzmSf5yP7NoMU8JY7on68xEbGzf4B4tAkjc2veyFc6DorlZprVZAJ8fvxwNU6KPLnY43VS2vo4krzoilks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6kINsot; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a0b7fbdde7so1225744f8f.2;
        Thu, 15 May 2025 12:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747336516; x=1747941316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O4mrGGjiLtG+uJ3BVL0hiZFMPIKVJ5ngqjArHtTuxX0=;
        b=d6kINsotAvqmnaOaSTFNzPDpVN8Fq6kJ4M/DDmmIU6X6dX2M7/zWb5MhByptdYQx5a
         79di5E6CLz44r5a0L2wGY2xFpOeF4tHQqDyJBHaHovtHqvID9gqm3+n/83P3xybHqlAD
         7a+eKdScGP0YrY3f5LvJeod25xmMt38JLSWoW+woH9lNHbzKK4tetec4bWcao4B6+d9h
         Tz9kozPnQfIbPkti5RYL6ZouhS6Ih+YUPn+UcA8McVReSFHtRl+EgU5vG4ACdzXcy/5L
         PiWkq8XyTQ4+d6EJFnnjnFuIwj8FlvDTT4ZefkTPIJ4sBlgel+CpdkdfoUqtE4XOApFx
         6Qdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747336516; x=1747941316;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4mrGGjiLtG+uJ3BVL0hiZFMPIKVJ5ngqjArHtTuxX0=;
        b=QYicT39DcsvxC0ZNT0Pdr9ELlvK1oc6fEaYxei8aKWLk3sOh/VGFyINmb3W5Spkz1o
         uZC7J9miJ/tumyMhHXaTG0i+lkSafEoP9KQygHCuaMHK8zmqwsHZPJFVaymlSv1iBKc9
         aOlcRcr5haQ/wJ8K7RNFsZx2gr3AwZRZKI5BIcIYeWaR+P8N4JQNvuw2xa3zYwE6Lx9x
         1gM/xOM0/TSQG5Q/B3qpLHlC/aDvipVUgSZapsmnAkXI/fMrS5DUWNG0mPUG9EZo+c4Y
         KRNgSAOy9UxBoU98JV5lcup9pZ3Z/IApriz2bbU17zY1mObkXkDIy6zPwwFjqSn7fKgZ
         SfgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8ecWeFBRPto3N2wpfDZe9faP+enPywxZX1+2N7Uer49KehzIYoeOMSAZtRPSizG5g/BTHSW/g@vger.kernel.org, AJvYcCWq+YEL0pvl1Z3k7slmkrwWrH48R1Ogxt3pdAym2mjA5t/+Je2E014+eMbNr3fHatTsEexr1nJuGvDNLyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh10P3orU6oJPSE0MOpU+DOSp4A/btejWYhflQ0YpA6usLG7Nn
	ngGKRJ4tJoCdbhHPhURib+cGIQWeh5L7GUUSMVyF/vXGY5bSUrOaKpgU
X-Gm-Gg: ASbGncustQyAnOPJxeD0dk0kJUWWOSuMAEPX5nWSI4iF/XMZak11YdD7KSHDY73eHgI
	VyRXkRoUbGB3oa+jmBpyX4sA8+r33D3eXy/OSW0hQB5oGY9bWc22bofyyPGKbXfDe//twiJjMc0
	x+2v0NByc6N6CyCEUbMNOfKHqwpKd7dWk1X+u/hEbmJuJG5d1ZecTqRIeGrZfDNIBOTNPQTAMe6
	9kK3hqfIPKqqGjh4Mor6A1vYxjj7wisvXixC7nMhaAnjphNegNQepYEq8UWbdL1G6FW6VeNN5z3
	TYm+ReO9Nkkl1VFrVVqX9aM1jpW8b+J//aKCECr9FFXVOr+P+DCi5fT0DMdWTZd9HFKyOSzHMtO
	5a4AWLNpFsClpYNISjYRIDBRforqHi8fmBPYs6YTwZjplvfnRiOL89ELM4M5lv1NmHapZfGn+sm
	cJJW0WsJb1Hw==
X-Google-Smtp-Source: AGHT+IHdvUuKDG4qFxEtOC2h+0sK9Zdnq730KuUxFF6U8cgoqvsbQduN8q0cC3EgbuEWp9FHr2wJ1w==
X-Received: by 2002:a5d:59ab:0:b0:3a2:2ea9:4378 with SMTP id ffacd0b85a97d-3a35c83a1fcmr937962f8f.31.1747336515573;
        Thu, 15 May 2025 12:15:15 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f4a:2300:ec36:b14d:f12:70b? (p200300ea8f4a2300ec36b14d0f12070b.dip0.t-ipconnect.de. [2003:ea:8f4a:2300:ec36:b14d:f12:70b])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a35ca6265fsm365522f8f.43.2025.05.15.12.15.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 12:15:14 -0700 (PDT)
Message-ID: <d1bd7949-6cac-49be-b8d6-1fe06fb9f1c0@gmail.com>
Date: Thu, 15 May 2025 21:15:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: add driver for MaxLinear MxL86110 PHY
To: Stefano Radaelli <stefano.radaelli21@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Xu Liang <lxu@maxlinear.com>
References: <20250515184836.97605-1-stefano.radaelli21@gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250515184836.97605-1-stefano.radaelli21@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.05.2025 20:48, Stefano Radaelli wrote:
> Add support for the MaxLinear MxL86110 Gigabit Ethernet PHY, a low-power,
> cost-optimized transceiver supporting 10/100/1000 Mbps over twisted-pair
> copper, compliant with IEEE 802.3.
> 
> The driver implements basic features such as:
> - Device initialization
> - RGMII interface timing configuration
> - Wake-on-LAN support
> - LED initialization and control via /sys/class/leds
> 
> This driver has been tested on multiple Variscite boards, including:
> - VAR-SOM-MX93 (i.MX93)
> - VAR-SOM-MX8M-PLUS (i.MX8MP)
> 
> Example boot log showing driver probe:
> [    7.692101] imx-dwmac 428a0000.ethernet eth0:
> 	PHY [stmmac-0:00] driver [MXL86110 Gigabit Ethernet] (irq=POLL)
> 
> Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
> ---
>  MAINTAINERS                 |   1 +
>  drivers/net/phy/Kconfig     |  12 +
>  drivers/net/phy/Makefile    |   1 +
>  drivers/net/phy/mxl-86110.c | 599 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 613 insertions(+)
>  create mode 100644 drivers/net/phy/mxl-86110.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3563492e4eba..183077e079a3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14661,6 +14661,7 @@ MAXLINEAR ETHERNET PHY DRIVER
>  M:	Xu Liang <lxu@maxlinear.com>
>  L:	netdev@vger.kernel.org
>  S:	Supported
> +F:	drivers/net/phy/mxl-86110.c
>  F:	drivers/net/phy/mxl-gpy.c
>  
>  MCAN MMIO DEVICE DRIVER
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index d29f9f7fd2e1..885ddddf03bd 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -266,6 +266,18 @@ config MAXLINEAR_GPHY
>  	  Support for the Maxlinear GPY115, GPY211, GPY212, GPY215,
>  	  GPY241, GPY245 PHYs.
>  
> +config MAXLINEAR_86110_PHY
> +	tristate "MaxLinear MXL86110 PHY support"
> +	help
> +	  Support for the MaxLinear MXL86110 Gigabit Ethernet
> +	  Physical Layer transceiver.
> +	  The MXL86110 is commonly used in networking equipment such as
> +	  routers, switches, and embedded systems, providing the
> +	  physical interface for 10/100/1000 Mbps Ethernet connections
> +	  over copper media.
> +	  If you are using a board with the MXL86110 PHY connected to your
> +	  Ethernet MAC, you should enable this option.
> +
>  source "drivers/net/phy/mediatek/Kconfig"
>  
>  config MICREL_PHY
> diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
> index 23ce205ae91d..eb0231882834 100644
> --- a/drivers/net/phy/Makefile
> +++ b/drivers/net/phy/Makefile
> @@ -74,6 +74,7 @@ obj-$(CONFIG_MARVELL_10G_PHY)	+= marvell10g.o
>  obj-$(CONFIG_MARVELL_PHY)	+= marvell.o
>  obj-$(CONFIG_MARVELL_88Q2XXX_PHY)	+= marvell-88q2xxx.o
>  obj-$(CONFIG_MARVELL_88X2222_PHY)	+= marvell-88x2222.o
> +obj-$(CONFIG_MAXLINEAR_86110_PHY)	+= mxl-86110.o
>  obj-$(CONFIG_MAXLINEAR_GPHY)	+= mxl-gpy.o
>  obj-y				+= mediatek/
>  obj-$(CONFIG_MESON_GXL_PHY)	+= meson-gxl.o
> diff --git a/drivers/net/phy/mxl-86110.c b/drivers/net/phy/mxl-86110.c
> new file mode 100644
> index 000000000000..98d90b88b60f
> --- /dev/null
> +++ b/drivers/net/phy/mxl-86110.c
> @@ -0,0 +1,599 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * PHY driver for Maxlinear MXL86110
> + *
> + * Copyright 2023 MaxLinear Inc.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/etherdevice.h>
> +#include <linux/of.h>
> +#include <linux/phy.h>
> +#include <linux/module.h>
> +#include <linux/bitfield.h>
> +
please in alphabetic order

> +#define MXL86110_DRIVER_DESC	"MaxLinear MXL86110 PHY driver"

This is used in one place only, so there's not really a benefit.

> +
> +/* PHY ID */
> +#define PHY_ID_MXL86110		0xC1335580

with lower-case characters please

> +
> +/* required to access extended registers */
> +#define MXL86110_EXTD_REG_ADDR_OFFSET	0x1E
> +#define MXL86110_EXTD_REG_ADDR_DATA		0x1F
> +#define PHY_IRQ_ENABLE_REG				0x12
> +#define PHY_IRQ_ENABLE_REG_WOL			BIT(6)
> +
> +/* SyncE Configuration Register - COM_EXT SYNCE_CFG */
> +#define MXL86110_EXT_SYNCE_CFG_REG						0xA012
> +#define MXL86110_EXT_SYNCE_CFG_CLK_FRE_SEL				BIT(4)
> +#define MXL86110_EXT_SYNCE_CFG_EN_SYNC_E_DURING_LNKDN	BIT(5)
> +#define MXL86110_EXT_SYNCE_CFG_EN_SYNC_E				BIT(6)
> +#define MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_MASK			GENMASK(3, 1)
> +#define MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_125M_PLL		0
> +#define MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_25M			4
> +
> +/* WOL registers */
> +#define MXL86110_WOL_MAC_ADDR_HIGH_EXTD_REG		0xA007 /* high-> FF:FF                   */
> +#define MXL86110_WOL_MAC_ADDR_MIDDLE_EXTD_REG	0xA008 /*    middle-> :FF:FF <-middle    */
> +#define MXL86110_WOL_MAC_ADDR_LOW_EXTD_REG		0xA009 /*                   :FF:FF <-low */
> +
> +#define MXL86110_EXT_WOL_CFG_REG				0xA00A
> +#define MXL86110_EXT_WOL_CFG_WOLE_MASK			BIT(3)
> +#define MXL86110_EXT_WOL_CFG_WOLE_DISABLE		0
> +#define MXL86110_EXT_WOL_CFG_WOLE_ENABLE		BIT(3)
> +
> +/* RGMII register */
> +#define MXL86110_EXT_RGMII_CFG1_REG							0xA003
> +/* delay can be adjusted in steps of about 150ps */
> +#define MXL86110_EXT_RGMII_CFG1_RX_NO_DELAY				(0x0 << 10)
> +/* Closest value to 2000 ps */
> +#define MXL86110_EXT_RGMII_CFG1_RX_DELAY_1950PS				(0xD << 10)
> +#define MXL86110_EXT_RGMII_CFG1_RX_DELAY_MASK				GENMASK(13, 10)
> +
> +#define MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_1950PS			(0xD << 0)
> +#define MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_MASK			GENMASK(3, 0)
> +
> +#define MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_1950PS		(0xD << 4)
> +#define MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_MASK	GENMASK(7, 4)
> +
> +#define MXL86110_EXT_RGMII_CFG1_FULL_MASK \
> +			((MXL86110_EXT_RGMII_CFG1_RX_DELAY_MASK) | \
> +			(MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_MASK) | \
> +			(MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_MASK))
> +
> +/* EXT Sleep Control register */
> +#define MXL86110_UTP_EXT_SLEEP_CTRL_REG					0x27
> +#define MXL86110_UTP_EXT_SLEEP_CTRL_EN_SLEEP_SW_OFF		0
> +#define MXL86110_UTP_EXT_SLEEP_CTRL_EN_SLEEP_SW_MASK	BIT(15)
> +
> +/* RGMII In-Band Status and MDIO Configuration Register */
> +#define MXL86110_EXT_RGMII_MDIO_CFG				0xA005
> +#define MXL86110_EXT_RGMII_MDIO_CFG_EPA0_MASK			GENMASK(6, 6)
> +#define MXL86110_EXT_RGMII_MDIO_CFG_EBA_MASK			GENMASK(5, 5)
> +#define MXL86110_EXT_RGMII_MDIO_CFG_BA_MASK			GENMASK(4, 0)
> +
> +#define MXL86110_MAX_LEDS            3
> +/* LED registers and defines */
> +#define MXL86110_LED0_CFG_REG 0xA00C
> +#define MXL86110_LED1_CFG_REG 0xA00D
> +#define MXL86110_LED2_CFG_REG 0xA00E
> +
> +#define MXL86110_LEDX_CFG_TRAFFIC_ACT_BLINK_IND		BIT(13)
> +#define MXL86110_LEDX_CFG_LINK_UP_FULL_DUPLEX_ON	BIT(12)
> +#define MXL86110_LEDX_CFG_LINK_UP_HALF_DUPLEX_ON	BIT(11)
> +#define MXL86110_LEDX_CFG_LINK_UP_TX_ACT_ON			BIT(10)	/* LED 0,1,2 default */
> +#define MXL86110_LEDX_CFG_LINK_UP_RX_ACT_ON			BIT(9)	/* LED 0,1,2 default */
> +#define MXL86110_LEDX_CFG_LINK_UP_TX_ON				BIT(8)
> +#define MXL86110_LEDX_CFG_LINK_UP_RX_ON				BIT(7)
> +#define MXL86110_LEDX_CFG_LINK_UP_1GB_ON			BIT(6) /* LED 2 default */
> +#define MXL86110_LEDX_CFG_LINK_UP_100MB_ON			BIT(5) /* LED 1 default */
> +#define MXL86110_LEDX_CFG_LINK_UP_10MB_ON			BIT(4) /* LED 0 default */
> +#define MXL86110_LEDX_CFG_LINK_UP_COLLISION			BIT(3)
> +#define MXL86110_LEDX_CFG_LINK_UP_1GB_BLINK			BIT(2)
> +#define MXL86110_LEDX_CFG_LINK_UP_100MB_BLINK		BIT(1)
> +#define MXL86110_LEDX_CFG_LINK_UP_10MB_BLINK		BIT(0)
> +
> +#define MXL86110_LED_BLINK_CFG_REG						0xA00F
> +#define MXL86110_LED_BLINK_CFG_FREQ_MODE1_2HZ			0
> +#define MXL86110_LED_BLINK_CFG_FREQ_MODE1_4HZ			BIT(0)
> +#define MXL86110_LED_BLINK_CFG_FREQ_MODE1_8HZ			BIT(1)
> +#define MXL86110_LED_BLINK_CFG_FREQ_MODE1_16HZ			(BIT(1) | BIT(0))
> +#define MXL86110_LED_BLINK_CFG_FREQ_MODE2_2HZ			0
> +#define MXL86110_LED_BLINK_CFG_FREQ_MODE2_4HZ			BIT(2)
> +#define MXL86110_LED_BLINK_CFG_FREQ_MODE2_8HZ			BIT(3)
> +#define MXL86110_LED_BLINK_CFG_FREQ_MODE2_16HZ			(BIT(3) | BIT(2))
> +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_50_PERC_ON	0
> +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_67_PERC_ON	(BIT(4))
> +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_75_PERC_ON	(BIT(5))
> +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_83_PERC_ON	(BIT(5) | BIT(4))
> +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_50_PERC_OFF	(BIT(6))
> +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_33_PERC_ON	(BIT(6) | BIT(4))
> +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_25_PERC_ON	(BIT(6) | BIT(5))
> +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_17_PERC_ON	(BIT(6) | BIT(5) | BIT(4))
> +
> +/* Chip Configuration Register - COM_EXT_CHIP_CFG */
> +#define MXL86110_EXT_CHIP_CFG_REG			0xA001
> +#define MXL86110_EXT_CHIP_CFG_RXDLY_ENABLE	BIT(8)
> +#define MXL86110_EXT_CHIP_CFG_SW_RST_N_MODE	BIT(15)
> +
> +/**
> + * mxl86110_write_extended_reg() - write to a PHY's extended register
> + * @phydev: pointer to a &struct phy_device
> + * @regnum: register number to write
> + * @val: value to write to @regnum
> + *
> + * NOTE: This function assumes the caller already holds the MDIO bus lock
> + * or otherwise has exclusive access to the PHY. If exclusive access
> + * cannot be guaranteed, please use mxl86110_locked_write_extended_reg()
> + * which handles locking internally.
> + *
> + * returns 0 or negative error code
> + */
> +static int mxl86110_write_extended_reg(struct phy_device *phydev, u16 regnum, u16 val)
> +{
> +	int ret;
> +
> +	ret = __phy_write(phydev, MXL86110_EXTD_REG_ADDR_OFFSET, regnum);
> +	if (ret < 0)
> +		return ret;
> +
> +	return __phy_write(phydev, MXL86110_EXTD_REG_ADDR_DATA, val);
> +}
> +
> +/**
> + * mxl86110_locked_write_extended_reg - Safely write to an extended register
> + * @phydev: Pointer to the PHY device structure
> + * @regnum: Extended register number to write (address written to reg 30)
> + * @val: Value to write to the selected extended register (via reg 31)
> + *
> + * This function safely writes to an extended register of the MxL86110 PHY.
> + * It acquires the MDIO bus lock before performing the operation using
> + * the reg 30/31 extended access mechanism.
> + *
> + * Use this locked variant when accessing extended registers in contexts
> + * where concurrent access to the MDIO bus may occur (e.g., from userspace
> + * calls, interrupt context, or asynchronous callbacks like LED triggers).
> + * If you are in a context where the MDIO bus is already locked or
> + * guaranteed exclusive, the non-locked variant can be used.
> + *
> + * Return: 0 on success or a negative errno code on failure.
> + */
> +static int mxl86110_locked_write_extended_reg(struct phy_device *phydev, u16 regnum,
> +					      u16 val)
> +{
> +	int ret;
> +
> +	phy_lock_mdio_bus(phydev);
> +	ret = mxl86110_write_extended_reg(phydev, regnum, val);
> +	phy_unlock_mdio_bus(phydev);
> +	return ret;
> +}
> +
> +/**
> + * mxl86110_read_extended_reg - Read a PHY's extended register
> + * @phydev: Pointer to the PHY device structure
> + * @regnum: Extended register number to read (address written to reg 30)
> + *
> + * Reads the content of a PHY extended register using the MaxLinear
> + * 2-step access mechanism: write the register address to reg 30 (0x1E),
> + * then read the value from reg 31 (0x1F).
> + *
> + * NOTE: This function assumes the caller already holds the MDIO bus lock
> + * or otherwise has exclusive access to the PHY. If exclusive access
> + * cannot be guaranteed, use mxl86110_locked_read_extended_reg().
> + *
> + * Return: 16-bit register value on success, or negative errno code on failure.
> + */
> +static int mxl86110_read_extended_reg(struct phy_device *phydev, u16 regnum)
> +{
> +	int ret;
> +
> +	ret = __phy_write(phydev, MXL86110_EXTD_REG_ADDR_OFFSET, regnum);
> +	if (ret < 0)
> +		return ret;
> +	return __phy_read(phydev, MXL86110_EXTD_REG_ADDR_DATA);
> +}
> +
> +/**
> + * mxl86110_locked_read_extended_reg - Safely read from an extended register
> + * @phydev: Pointer to the PHY device structure
> + * @regnum: Extended register number to read (address written to reg 30)
> + *
> + * This function safely reads an extended register of the MxL86110 PHY.
> + * It locks the MDIO bus and uses the extended register access mechanism
> + * via reg 30 (address) and reg 31 (data).
> + *
> + * Use this locked variant when accessing extended registers in contexts
> + * where concurrent access to the MDIO bus may occur (e.g., from userspace
> + * calls, interrupt context, or asynchronous callbacks like LED triggers).
> + * If you are in a context where the MDIO bus is already locked or
> + * guaranteed exclusive, the non-locked variant can be used.
> + *
> + * Return: The 16-bit value read from the extended register, or a negative errno code.
> + */
> +static int mxl86110_locked_read_extended_reg(struct phy_device *phydev, u16 regnum)
> +{
> +	int ret;
> +
> +	phy_lock_mdio_bus(phydev);
> +	ret = mxl86110_read_extended_reg(phydev, regnum);
> +	phy_unlock_mdio_bus(phydev);
> +
> +	return ret;
> +}
> +
> +/**
> + * mxl86110_modify_extended_reg() - modify bits of a PHY's extended register
> + * @phydev: pointer to the phy_device
> + * @regnum: register number to write
> + * @mask: bit mask of bits to clear
> + * @set: bit mask of bits to set
> + *
> + * NOTE: register value = (old register value & ~mask) | set.
> + * This function assumes the caller already holds the MDIO bus lock
> + * or otherwise has exclusive access to the PHY.
> + *
> + * returns 0 or negative error code
> + */
> +static int mxl86110_modify_extended_reg(struct phy_device *phydev, u16 regnum, u16 mask,
> +					u16 set)
> +{
> +	int ret;
> +
> +	ret = __phy_write(phydev, MXL86110_EXTD_REG_ADDR_OFFSET, regnum);
> +	if (ret < 0)
> +		return ret;
> +
> +	return __phy_modify(phydev, MXL86110_EXTD_REG_ADDR_DATA, mask, set);
> +}
> +
> +/**
> + * mxl86110_get_wol() - report if wake-on-lan is enabled
> + * @phydev: pointer to the phy_device
> + * @wol: a pointer to a &struct ethtool_wolinfo
> + */
> +static void mxl86110_get_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
> +{
> +	int value;
> +
> +	wol->supported = WAKE_MAGIC;
> +	wol->wolopts = 0;
> +	value = mxl86110_locked_read_extended_reg(phydev, MXL86110_EXT_WOL_CFG_REG);
> +	if (value >= 0 && (value & MXL86110_EXT_WOL_CFG_WOLE_MASK))
> +		wol->wolopts |= WAKE_MAGIC;
> +}
> +
> +/**
> + * mxl86110_set_wol() - enable/disable wake-on-lan
> + * @phydev: pointer to the phy_device
> + * @wol: a pointer to a &struct ethtool_wolinfo
> + *
> + * Configures the WOL Magic Packet MAC
> + * returns 0 or negative errno code
> + */
> +static int mxl86110_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
> +{
> +	struct net_device *netdev;
> +	const u8 *mac;
> +	int ret = 0;
> +
> +	if (wol->wolopts & WAKE_MAGIC) {
> +		netdev = phydev->attached_dev;
> +		if (!netdev)
> +			return -ENODEV;
> +
> +		/* Configure the MAC address of the WOL magic packet */
> +		mac = (const u8 *)netdev->dev_addr;
> +		ret = mxl86110_write_extended_reg(phydev, MXL86110_WOL_MAC_ADDR_HIGH_EXTD_REG,
> +						  ((mac[0] << 8) | mac[1]));
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = mxl86110_write_extended_reg(phydev, MXL86110_WOL_MAC_ADDR_MIDDLE_EXTD_REG,
> +						  ((mac[2] << 8) | mac[3]));
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = mxl86110_write_extended_reg(phydev, MXL86110_WOL_MAC_ADDR_LOW_EXTD_REG,
> +						  ((mac[4] << 8) | mac[5]));
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = mxl86110_modify_extended_reg(phydev, MXL86110_EXT_WOL_CFG_REG,
> +						   MXL86110_EXT_WOL_CFG_WOLE_MASK,
> +						   MXL86110_EXT_WOL_CFG_WOLE_ENABLE);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = __phy_modify(phydev, PHY_IRQ_ENABLE_REG, 0,
> +				   PHY_IRQ_ENABLE_REG_WOL);
> +		if (ret < 0)
> +			return ret;
> +
> +		phydev_dbg(phydev, "%s, WOL Magic packet MAC: %02X:%02X:%02X:%02X:%02X:%02X\n",
> +			   __func__, mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
> +
> +	} else {
> +		ret = mxl86110_modify_extended_reg(phydev, MXL86110_EXT_WOL_CFG_REG,
> +						   MXL86110_EXT_WOL_CFG_WOLE_MASK,
> +						   MXL86110_EXT_WOL_CFG_WOLE_DISABLE);
> +
> +		ret = __phy_modify(phydev, PHY_IRQ_ENABLE_REG,
> +				   PHY_IRQ_ENABLE_REG_WOL, 0);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const unsigned long supported_triggers = (BIT(TRIGGER_NETDEV_LINK_10) |
> +						 BIT(TRIGGER_NETDEV_LINK_100) |
> +						 BIT(TRIGGER_NETDEV_LINK_1000) |
> +						 BIT(TRIGGER_NETDEV_HALF_DUPLEX) |
> +						 BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
> +						 BIT(TRIGGER_NETDEV_TX) |
> +						 BIT(TRIGGER_NETDEV_RX));
> +
> +static int mxl86110_led_hw_is_supported(struct phy_device *phydev, u8 index,
> +					unsigned long rules)
> +{
> +	if (index >= MXL86110_MAX_LEDS)
> +		return -EINVAL;
> +
> +	/* All combinations of the supported triggers are allowed */
> +	if (rules & ~supported_triggers)
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}
> +
> +static int mxl86110_led_hw_control_get(struct phy_device *phydev, u8 index,
> +				       unsigned long *rules)
> +{
> +	u16 val;
> +
> +	if (index >= MXL86110_MAX_LEDS)
> +		return -EINVAL;
> +
> +	val = mxl86110_read_extended_reg(phydev, MXL86110_LED0_CFG_REG + index);
> +	if (val < 0)
> +		return val;
> +
> +	if (val & MXL86110_LEDX_CFG_LINK_UP_TX_ACT_ON)
> +		*rules |= BIT(TRIGGER_NETDEV_TX);
> +
> +	if (val & MXL86110_LEDX_CFG_LINK_UP_RX_ACT_ON)
> +		*rules |= BIT(TRIGGER_NETDEV_RX);
> +
> +	if (val & MXL86110_LEDX_CFG_LINK_UP_HALF_DUPLEX_ON)
> +		*rules |= BIT(TRIGGER_NETDEV_HALF_DUPLEX);
> +
> +	if (val & MXL86110_LEDX_CFG_LINK_UP_FULL_DUPLEX_ON)
> +		*rules |= BIT(TRIGGER_NETDEV_FULL_DUPLEX);
> +
> +	if (val & MXL86110_LEDX_CFG_LINK_UP_10MB_ON)
> +		*rules |= BIT(TRIGGER_NETDEV_LINK_10);
> +
> +	if (val & MXL86110_LEDX_CFG_LINK_UP_100MB_ON)
> +		*rules |= BIT(TRIGGER_NETDEV_LINK_100);
> +
> +	if (val & MXL86110_LEDX_CFG_LINK_UP_1GB_ON)
> +		*rules |= BIT(TRIGGER_NETDEV_LINK_1000);
> +
> +	return 0;
> +};
> +
> +static int mxl86110_led_hw_control_set(struct phy_device *phydev, u8 index,
> +				       unsigned long rules)
> +{
> +	u16 val = 0;
> +	int ret;
> +
> +	if (index >= MXL86110_MAX_LEDS)
> +		return -EINVAL;
> +
> +	if (rules & BIT(TRIGGER_NETDEV_LINK_10))
> +		val |= MXL86110_LEDX_CFG_LINK_UP_10MB_ON;
> +
> +	if (rules & BIT(TRIGGER_NETDEV_LINK_100))
> +		val |= MXL86110_LEDX_CFG_LINK_UP_100MB_ON;
> +
> +	if (rules & BIT(TRIGGER_NETDEV_LINK_1000))
> +		val |= MXL86110_LEDX_CFG_LINK_UP_1GB_ON;
> +
> +	if (rules & BIT(TRIGGER_NETDEV_TX))
> +		val |= MXL86110_LEDX_CFG_LINK_UP_TX_ACT_ON;
> +
> +	if (rules & BIT(TRIGGER_NETDEV_RX))
> +		val |= MXL86110_LEDX_CFG_LINK_UP_RX_ACT_ON;
> +
> +	if (rules & BIT(TRIGGER_NETDEV_HALF_DUPLEX))
> +		val |= MXL86110_LEDX_CFG_LINK_UP_HALF_DUPLEX_ON;
> +
> +	if (rules & BIT(TRIGGER_NETDEV_FULL_DUPLEX))
> +		val |= MXL86110_LEDX_CFG_LINK_UP_FULL_DUPLEX_ON;
> +
> +	if (rules & BIT(TRIGGER_NETDEV_TX) ||
> +	    rules & BIT(TRIGGER_NETDEV_RX))
> +		val |= MXL86110_LEDX_CFG_TRAFFIC_ACT_BLINK_IND;
> +
> +	ret = mxl86110_locked_write_extended_reg(phydev, MXL86110_LED0_CFG_REG + index, val);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +};
> +
> +/**
> + * mxl86110_synce_clk_cfg() - applies syncE/clk output configuration
> + * @phydev: pointer to the phy_device
> + *
> + * Custom settings can be defined in custom config section of the driver
> + * returns 0 or negative errno code
> + */
> +static int mxl86110_synce_clk_cfg(struct phy_device *phydev)
> +{
> +	u16 mask = 0, value = 0;
> +	int ret = 0;
> +
> +	/*
> +	 * Configures the clock output to its default setting as per the datasheet.
> +	 * This results in a 25MHz clock output being selected in the
> +	 * COM_EXT_SYNCE_CFG register for SyncE configuration.
> +	 */
> +	value = MXL86110_EXT_SYNCE_CFG_EN_SYNC_E |
> +			FIELD_PREP(MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_MASK,
> +				   MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_25M);
> +	mask = MXL86110_EXT_SYNCE_CFG_EN_SYNC_E |
> +	       MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_MASK |
> +	       MXL86110_EXT_SYNCE_CFG_CLK_FRE_SEL;
> +
> +	/* Write clock output configuration */
> +	ret = mxl86110_modify_extended_reg(phydev, MXL86110_EXT_SYNCE_CFG_REG,
> +					   mask, value);
> +
> +	return ret;
> +}
> +
> +/**
> + * mxl86110_config_init() - initialize the PHY
> + * @phydev: pointer to the phy_device
> + *
> + * returns 0 or negative errno code
> + */
> +static int mxl86110_config_init(struct phy_device *phydev)
> +{
> +	int ret;
> +	unsigned int val = 0;
> +	int index;
> +
> +	/*
> +	 * RX_CLK delay (RXDLY) enabled via CHIP_CFG register causes a fixed
> +	 * delay of approximately 2 ns at 125 MHz or 8 ns at 25/2.5 MHz.
> +	 * Digital delays in RGMII_CFG1 register are additive
> +	 */
> +	switch (phydev->interface) {
> +	case PHY_INTERFACE_MODE_RGMII:
> +		val = 0;
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +		val = MXL86110_EXT_RGMII_CFG1_RX_DELAY_1950PS;
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		val = MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_1950PS |
> +			MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_1950PS;
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +		val = MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_1950PS |
> +			MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_1950PS;
> +		val |= MXL86110_EXT_RGMII_CFG1_RX_DELAY_1950PS;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	ret = mxl86110_modify_extended_reg(phydev, MXL86110_EXT_RGMII_CFG1_REG,
> +					   MXL86110_EXT_RGMII_CFG1_FULL_MASK, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Configure RXDLY (RGMII Rx Clock Delay) to disable the default additional
> +	 * delay value on RX_CLK (2 ns for 125 MHz, 8 ns for 25 MHz/2.5 MHz)
> +	 * and use just the digital one selected before
> +	 */
> +	ret = mxl86110_modify_extended_reg(phydev, MXL86110_EXT_CHIP_CFG_REG,
> +					   MXL86110_EXT_CHIP_CFG_RXDLY_ENABLE, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Configure all PHY LEDs to blink on traffic activity regardless of their
> +	 * ON or OFF state. This behavior allows each LED to serve as a pure activity
> +	 * indicator, independently of its use as a link status indicator.
> +	 *
> +	 * By default, each LED blinks only when it is also in the ON state. This function
> +	 * modifies the appropriate registers (LABx fields) to enable blinking even
> +	 * when the LEDs are OFF, to allow the LED to be used as a traffic indicator
> +	 * without requiring it to also serve as a link status LED.
> +	 *
> +	 * NOTE: Any further LED customization can be performed via the
> +	 * /sys/class/led interface; the functions led_hw_is_supported, led_hw_control_get, and
> +	 * led_hw_control_set are used to support this mechanism.
> +	 */
> +	for (index = 0; index < MXL86110_MAX_LEDS; index++) {
> +		val = mxl86110_read_extended_reg(phydev, MXL86110_LED0_CFG_REG + index);
> +		if (val < 0)
> +			return val;
> +
> +		val |= MXL86110_LEDX_CFG_TRAFFIC_ACT_BLINK_IND;
> +		ret = mxl86110_write_extended_reg(phydev, MXL86110_LED0_CFG_REG + index, val);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	/*
> +	 * configures the MDIO broadcast behavior of the MxL86110 PHY.
> +	 * Currently, broadcast mode is explicitly disabled by clearing the EPA0 bit
> +	 * in the RGMII_MDIO_CFG extended register.
> +	 */
> +	val = mxl86110_read_extended_reg(phydev, MXL86110_EXT_RGMII_MDIO_CFG);
> +	if (val < 0)
> +		return val;
> +
> +	val &= ~MXL86110_EXT_RGMII_MDIO_CFG_EPA0_MASK;
> +	ret = mxl86110_write_extended_reg(phydev, MXL86110_EXT_RGMII_MDIO_CFG, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +/**
> + * mxl86110_probe() - read chip config then set suitable reg_page_mode
> + * @phydev: pointer to the phy_device
> + *
> + * returns 0 or negative errno code
> + */
> +static int mxl86110_probe(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	/* configure syncE / clk output */
> +	ret = mxl86110_synce_clk_cfg(phydev);

Why do you do this in probe() and not in config_init()?
You have to consider that the PHY may be powered off during system suspend.
So on system resume it may come up with the power-up defaults.

> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static struct phy_driver mxl_phy_drvs[] = {
> +	{
> +		PHY_ID_MATCH_EXACT(PHY_ID_MXL86110),
> +		.name			= "MXL86110 Gigabit Ethernet",
> +		.probe			= mxl86110_probe,
> +		.config_init		= mxl86110_config_init,
> +		.config_aneg		= genphy_config_aneg,
> +		.read_status		= genphy_read_status,

You can remove these two lines, both functions are the default
if no callback is set.

> +		.get_wol		= mxl86110_get_wol,
> +		.set_wol		= mxl86110_set_wol,
> +		.suspend		= genphy_suspend,
> +		.resume			= genphy_resume,
> +		.led_hw_is_supported	= mxl86110_led_hw_is_supported,
> +		.led_hw_control_get     = mxl86110_led_hw_control_get,
> +		.led_hw_control_set     = mxl86110_led_hw_control_set,
> +	},
> +};
> +
> +module_phy_driver(mxl_phy_drvs);
> +
> +static const struct mdio_device_id __maybe_unused mxl_tbl[] = {
> +	{ PHY_ID_MATCH_EXACT(PHY_ID_MXL86110) },
> +	{  }
> +};
> +
> +MODULE_DEVICE_TABLE(mdio, mxl_tbl);
> +
> +MODULE_DESCRIPTION(MXL86110_DRIVER_DESC);
> +MODULE_AUTHOR("Stefano Radaelli");
> +MODULE_LICENSE("GPL");


