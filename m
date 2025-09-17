Return-Path: <netdev+bounces-223921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75965B7CF1B
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1349A1B2847C
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 09:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C241827A900;
	Wed, 17 Sep 2025 09:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RY3lV75a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5F12EB5CF
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 09:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758102368; cv=none; b=sgETCbcPO6a5dgsPaXD8Xo0h9NsWD9J2VUW4OhXDAZ0ywRoxagCaIBGe4JCuvR56tdHCJF86fbDo/AmnH68vZt33NKJpW/YYrjSa4WrEN9h/I4zbBmIrOfkskEtZiq8PZ81RjY4k9YzytBCJ19FAur8OTgaKLJqOr06AZMbbvb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758102368; c=relaxed/simple;
	bh=C1VvAsQRJI7YrP3PfvH4dWEjrOqx884XY76GmBlOBVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EImNjp3+p3b7icZXzJvMny+R75ISNShoYxgrQO+h0+ZU0tsN5pnIh/XevAOTXwvJWnkLdyEknJxMwKUCG2ceagB0kUXLhU8rwrMiUy1JxHEjWX1pLpodv29utTh/Rtkuu/x4BlIwoJZDAaVTt9+y9STVNiG/IF/Zgj3FEqTDgNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RY3lV75a; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3e9bd2cf60cso140876f8f.2
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 02:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758102364; x=1758707164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x+S6y4iVLqDm0uN2+bAM2tJmf/Y6UpjS7/uM2lMzRm4=;
        b=RY3lV75aDJlBszpcyDgtqzsCEopo3rEzDJi7svvqMCUa+FDmSkB0JXdG5xeaCsyLYX
         LyGVX96nEasV0sP0IkrSDX14qp9ko2zAV+qXQViDrt/qu0+2kZmAVstwRwKw/8QxZEJs
         PACi+DXFEFx1LD8pEgybSQlYqg7ldAzeBTOfQ2DV+nRb2/RB/nsbdCsBbVRGefVdmc86
         aAi2+KkwQ8IpOi/FkUyT7yC/4+VvOXtVIUtUu8JC1lxvJJnHBMRYQxsHdsmOOC1KELRL
         t2kXHLNwKk/GxmWSeZ0jGeggi3BcyxQpFk12lbRGBaVji4rnljbwrPX/gNNzOBN7dDei
         n6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758102364; x=1758707164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+S6y4iVLqDm0uN2+bAM2tJmf/Y6UpjS7/uM2lMzRm4=;
        b=wRGRYfWxKo/2/xivvLJwaphsLOYI+XF2rwo+no4wmWLTfAS0cloEtwuHdDO+lvvs9H
         9h/ME0XZ9u9fzLZPuJB1/2Q6kb+BkAVjhu5ifRAFjbPt3Gaaf98Om74iBcvm0pbcuRlV
         AxVddkAJ/ZeLSavpYFSrT5x4jyq0goOfJqf/PqR0fP1KRL0rxy5yHfKoZzYgN63sOud2
         39C47caG3U1q3ZuNyc37YoGY97B6mgJGnAaYWXhEMMTtJfmU3YrBjhIh57BF9KkXZpap
         eFZjAW3pEQjAbcbZw4VDJ0MJX1+nn5jc4p0fDOWpEgjocy6OpGawGa8sF0vKohBMSIGX
         gJRw==
X-Forwarded-Encrypted: i=1; AJvYcCU/5pT8bpsn1DQEIPrJ9B5oHNY9vcbEB01K2k+UzpupztayQO7i75FUizDfomV99Wm+A20zq+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx92ynS0hkeLstvQzM6MEmhy72/SfzUgAubOlWLkz5Jq95ctqJm
	PM1/YU0I5+7IFjPqpSLoA2ME2pNcTgNQhpCiKUnaw07Qcw3nLDXhRY9i
X-Gm-Gg: ASbGncvXTkAAyR6jkc1JnEgjZmA5LhUduvgKzw/6GInn+KFO7oCI+fCacqZyqW/+wiN
	dACVHMjQqy2t9W1Z6b6+Kjn1PRz/d4Tm4YTckAaeXUrDEXY+NxvTygVFYKYfBOn54D5J5zlphNU
	+GbfhseTKQ2sFvhaXbaNOW8jNrcU2hW/9acCr31GOWcp9rldRJkvlOgPgCdSVzWDzh0I0ZwyuPB
	8B69l7ObPgX9xTu28acFUdWWavBmSg38xwvlv6xiT4vDPwY/12JqpFROHOQ0YcsM+6DpwHvZesA
	GINTGMCC6U+Eouo9b6Mp+OdLnVPuG0XFdhhvXnYAoJjQE7I8nNy6Q6ep0Tlao+bFCiuqbxftxaD
	sCcUJe2iY2EUrWdE=
X-Google-Smtp-Source: AGHT+IGbWD+uVEFkH71gk57y08q6YLO/dT2mVOMLrp9VU9G9bg7nqmyBsUuM7bG5cbe5Hw6bH549+g==
X-Received: by 2002:a05:6000:230f:b0:3dc:1473:1a8d with SMTP id ffacd0b85a97d-3ecdf947cbfmr730275f8f.0.1758102363890;
        Wed, 17 Sep 2025 02:46:03 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:8bcc:b603:fee7:a273])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613930bdd8sm29480335e9.19.2025.09.17.02.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:46:03 -0700 (PDT)
Date: Wed, 17 Sep 2025 12:46:00 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v18 6/8] mfd: an8855: Add support for Airoha
 AN8855 Switch MFD
Message-ID: <20250917094600.umxiz5kcrkcxqntt@skbuf>
References: <20250915104545.1742-1-ansuelsmth@gmail.com>
 <20250915104545.1742-1-ansuelsmth@gmail.com>
 <20250915104545.1742-7-ansuelsmth@gmail.com>
 <20250915104545.1742-7-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915104545.1742-7-ansuelsmth@gmail.com>
 <20250915104545.1742-7-ansuelsmth@gmail.com>

On Mon, Sep 15, 2025 at 12:45:42PM +0200, Christian Marangi wrote:
> Add support for Airoha AN8855 Switch MFD that provide support for a DSA
> switch and a NVMEM provider.
> 
> Also make use of the mdio-regmap driver and register a regmap for each
> internal PHY of the switch.
> This is needed to handle the double usage of the PHYs as both PHY and
> Switch accessor.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/mfd/Kconfig         |  13 +
>  drivers/mfd/Makefile        |   1 +
>  drivers/mfd/airoha-an8855.c | 517 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 531 insertions(+)
>  create mode 100644 drivers/mfd/airoha-an8855.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 425c5fba6cb1..f93450444887 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -53,6 +53,19 @@ config MFD_ALTERA_SYSMGR
>  	  using regmap_mmio accesses for ARM32 parts and SMC calls to
>  	  EL3 for ARM64 parts.
>  
> +config MFD_AIROHA_AN8855
> +	tristate "Airoha AN8855 Switch Core"
> +	select MFD_CORE
> +	select MDIO_DEVICE
> +	select MDIO_REGMAP
> +	depends on NETDEVICES && OF
> +	help
> +	  Support for the Airoha AN8855 Switch Core. This is an SoC
> +	  that provides various peripherals, to count, i2c, an Ethrnet
> +	  Switch, a CPU timer, GPIO, eFUSE.
> +
> +	  Currently it provides a DSA switch and a NVMEM provider.
> +
>  config MFD_ACT8945A
>  	tristate "Active-semi ACT8945A"
>  	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index f7bdedd5a66d..30f46c53d6df 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_MFD_88PM860X)	+= 88pm860x.o
>  obj-$(CONFIG_MFD_88PM800)	+= 88pm800.o 88pm80x.o
>  obj-$(CONFIG_MFD_88PM805)	+= 88pm805.o 88pm80x.o
>  obj-$(CONFIG_MFD_88PM886_PMIC)	+= 88pm886.o
> +obj-$(CONFIG_MFD_AIROHA_AN8855)	+= airoha-an8855.o
>  obj-$(CONFIG_MFD_ACT8945A)	+= act8945a.o
>  obj-$(CONFIG_MFD_SM501)		+= sm501.o
>  obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835-pm.o
> diff --git a/drivers/mfd/airoha-an8855.c b/drivers/mfd/airoha-an8855.c
> new file mode 100644
> index 000000000000..a46c5a0c3668
> --- /dev/null
> +++ b/drivers/mfd/airoha-an8855.c
> @@ -0,0 +1,517 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Core driver for Airoha AN8855 Switch
> + *
> + * Copyright (C) 2024 Christian Marangi <ansuelsmth@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/fwnode_mdio.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mdio.h>
> +#include <linux/mdio/mdio-regmap.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/phy.h>
> +#include <linux/regmap.h>
> +
> +/* Register for HW trap status */
> +#define AN8855_HWTRAP			0x1000009c
> +
> +/*
> + * Register of the Switch ID
> + * (called Project ID in Documentation)
> + */
> +#define AN8855_CREV			0x10005000
> +#define   AN8855_ID			0x8855 /* Switch ID */
> +
> +/* Register for GPHY Power Down
> + * Used to Toggle the Gigabit PHY power and enable them.
> + */
> +#define AN8855_RG_GPHY_AFE_PWD		0x1028c840
> +
> +/* MII Registers */
> +#define AN8855_PHY_SELECT_PAGE		0x1f
> +#define   AN8855_PHY_PAGE		GENMASK(2, 0)
> +#define   AN8855_PHY_PAGE_STANDARD	FIELD_PREP_CONST(AN8855_PHY_PAGE, 0x0)
> +#define   AN8855_PHY_PAGE_EXTENDED_1	FIELD_PREP_CONST(AN8855_PHY_PAGE, 0x1)
> +#define   AN8855_PHY_PAGE_EXTENDED_4	FIELD_PREP_CONST(AN8855_PHY_PAGE, 0x4)
> +
> +/* MII Registers Page 4 */
> +#define AN8855_PBUS_MODE		0x10
> +#define   AN8855_PBUS_MODE_ADDR_FIXED	0x0
> +#define   AN8855_PBUS_MODE_ADDR_INCR	BIT(15)
> +#define AN8855_PBUS_WR_ADDR_HIGH	0x11
> +#define AN8855_PBUS_WR_ADDR_LOW		0x12
> +#define AN8855_PBUS_WR_DATA_HIGH	0x13
> +#define AN8855_PBUS_WR_DATA_LOW		0x14
> +#define AN8855_PBUS_RD_ADDR_HIGH	0x15
> +#define AN8855_PBUS_RD_ADDR_LOW		0x16
> +#define AN8855_PBUS_RD_DATA_HIGH	0x17
> +#define AN8855_PBUS_RD_DATA_LOW		0x18
> +
> +#define AN8855_MAX_PHY_PORT		5
> +
> +struct an8855_core_priv {
> +	struct mii_bus *bus;
> +	unsigned int switch_addr;
> +	u16 current_page;
> +};
> +
> +struct an8855_phy_priv {
> +	u8 addr;
> +	struct an8855_core_priv *core;
> +};
> +
> +static const struct mfd_cell an8855_cells[] = {
> +	MFD_CELL_OF("an8855-efuse", NULL, NULL, 0, 0,
> +		    "airoha,an8855-efuse"),
> +	MFD_CELL_OF("an8855-switch", NULL, NULL, 0, 0,
> +		    "airoha,an8855-switch"),
> +};
> +
> +static int an8855_mii_set_page(struct an8855_core_priv *priv, u8 addr,
> +			       u8 page) __must_hold(&priv->bus->mdio_lock)
> +{
> +	struct mii_bus *bus = priv->bus;
> +	int ret;
> +
> +	ret = __mdiobus_write(bus, addr, AN8855_PHY_SELECT_PAGE, page);
> +	if (ret) {
> +		dev_err_ratelimited(&bus->dev, "failed to set mii page\n");
> +		return ret;
> +	}
> +
> +	/* Cache current page if next MII read/write is for Switch page */
> +	priv->current_page = page;
> +	return 0;
> +}
> +
> +static int an8855_mii_read32(struct mii_bus *bus, u8 phy_id, u32 reg,
> +			     u32 *val) __must_hold(&bus->mdio_lock)
> +{
> +	int lo, hi, ret;
> +
> +	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_MODE,
> +			      AN8855_PBUS_MODE_ADDR_FIXED);
> +	if (ret)
> +		goto err;
> +
> +	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_RD_ADDR_HIGH,
> +			      upper_16_bits(reg));
> +	if (ret)
> +		goto err;
> +
> +	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_RD_ADDR_LOW,
> +			      lower_16_bits(reg));
> +	if (ret)
> +		goto err;
> +
> +	hi = __mdiobus_read(bus, phy_id, AN8855_PBUS_RD_DATA_HIGH);
> +	if (hi < 0) {
> +		ret = hi;
> +		goto err;
> +	}
> +
> +	lo = __mdiobus_read(bus, phy_id, AN8855_PBUS_RD_DATA_LOW);
> +	if (lo < 0) {
> +		ret = lo;
> +		goto err;
> +	}
> +
> +	*val = ((u16)hi << 16) | ((u16)lo & 0xffff);
> +
> +	return 0;
> +err:
> +	dev_err_ratelimited(&bus->dev, "failed to read register\n");
> +	return ret;
> +}
> +
> +static int an8855_regmap_read(void *ctx, uint32_t reg, uint32_t *val)
> +{
> +	struct an8855_core_priv *priv = ctx;
> +	struct mii_bus *bus = priv->bus;
> +	u16 addr = priv->switch_addr;
> +	int ret;
> +
> +	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
> +	ret = an8855_mii_set_page(priv, addr, AN8855_PHY_PAGE_EXTENDED_4);
> +	if (ret < 0)
> +		goto exit;
> +
> +	ret = an8855_mii_read32(bus, addr, reg, val);
> +
> +exit:
> +	mutex_unlock(&bus->mdio_lock);
> +
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static int an8855_mii_write32(struct mii_bus *bus, u8 phy_id, u32 reg,
> +			      u32 val) __must_hold(&bus->mdio_lock)
> +{
> +	int ret;
> +
> +	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_MODE,
> +			      AN8855_PBUS_MODE_ADDR_FIXED);
> +	if (ret)
> +		goto err;
> +
> +	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_WR_ADDR_HIGH,
> +			      upper_16_bits(reg));
> +	if (ret)
> +		goto err;
> +	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_WR_ADDR_LOW,
> +			      lower_16_bits(reg));
> +	if (ret)
> +		goto err;
> +
> +	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_WR_DATA_HIGH,
> +			      upper_16_bits(val));
> +	if (ret)
> +		goto err;
> +
> +	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_WR_DATA_LOW,
> +			      lower_16_bits(val));
> +	if (ret)
> +		goto err;
> +
> +	return 0;
> +err:
> +	dev_err_ratelimited(&bus->dev,
> +			    "failed to write an8855 register\n");
> +	return ret;
> +}
> +
> +static int an8855_regmap_write(void *ctx, uint32_t reg, uint32_t val)
> +{
> +	struct an8855_core_priv *priv = ctx;
> +	struct mii_bus *bus = priv->bus;
> +	u16 addr = priv->switch_addr;
> +	int ret;
> +
> +	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
> +	ret = an8855_mii_set_page(priv, addr, AN8855_PHY_PAGE_EXTENDED_4);
> +	if (ret)
> +		goto exit;
> +
> +	ret = an8855_mii_write32(bus, addr, reg, val);
> +
> +exit:
> +	mutex_unlock(&bus->mdio_lock);
> +
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static int an8855_regmap_update_bits(void *ctx, uint32_t reg, uint32_t mask,
> +				     uint32_t write_val)
> +{
> +	struct an8855_core_priv *priv = ctx;
> +	struct mii_bus *bus = priv->bus;
> +	u16 addr = priv->switch_addr;
> +	u32 val;
> +	int ret;
> +
> +	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
> +	ret = an8855_mii_set_page(priv, addr, AN8855_PHY_PAGE_EXTENDED_4);
> +	if (ret)
> +		goto exit;
> +
> +	ret = an8855_mii_read32(bus, addr, reg, &val);
> +	if (ret < 0)
> +		goto exit;
> +
> +	val &= ~mask;
> +	val |= write_val;
> +	ret = an8855_mii_write32(bus, addr, reg, val);
> +
> +exit:
> +	mutex_unlock(&bus->mdio_lock);
> +
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static const struct regmap_range an8855_readable_ranges[] = {
> +	regmap_reg_range(0x10000000, 0x10000fff), /* SCU */
> +	regmap_reg_range(0x10001000, 0x10001fff), /* RBUS */
> +	regmap_reg_range(0x10002000, 0x10002fff), /* MCU */
> +	regmap_reg_range(0x10005000, 0x10005fff), /* SYS SCU */
> +	regmap_reg_range(0x10007000, 0x10007fff), /* I2C Slave */
> +	regmap_reg_range(0x10008000, 0x10008fff), /* I2C Master */
> +	regmap_reg_range(0x10009000, 0x10009fff), /* PDMA */
> +	regmap_reg_range(0x1000a100, 0x1000a2ff), /* General Purpose Timer */
> +	regmap_reg_range(0x1000a200, 0x1000a2ff), /* GPU timer */

Is it intentional that the General Purpose Timer and the GPU timer
ranges overlap?

> +	regmap_reg_range(0x1000a300, 0x1000a3ff), /* GPIO */
> +	regmap_reg_range(0x1000a400, 0x1000a5ff), /* EFUSE */
> +	regmap_reg_range(0x1000c000, 0x1000cfff), /* GDMP CSR */
> +	regmap_reg_range(0x10010000, 0x1001ffff), /* GDMP SRAM */
> +	regmap_reg_range(0x10200000, 0x10203fff), /* Switch - ARL Global */
> +	regmap_reg_range(0x10204000, 0x10207fff), /* Switch - BMU */
> +	regmap_reg_range(0x10208000, 0x1020bfff), /* Switch - ARL Port */
> +	regmap_reg_range(0x1020c000, 0x1020cfff), /* Switch - SCH */
> +	regmap_reg_range(0x10210000, 0x10213fff), /* Switch - MAC */
> +	regmap_reg_range(0x10214000, 0x10217fff), /* Switch - MIB */
> +	regmap_reg_range(0x10218000, 0x1021bfff), /* Switch - Port Control */
> +	regmap_reg_range(0x1021c000, 0x1021ffff), /* Switch - TOP */
> +	regmap_reg_range(0x10220000, 0x1022ffff), /* SerDes */
> +	regmap_reg_range(0x10286000, 0x10286fff), /* RG Batcher */
> +	regmap_reg_range(0x1028c000, 0x1028ffff), /* ETHER_SYS */
> +	regmap_reg_range(0x30000000, 0x37ffffff), /* I2C EEPROM */
> +	regmap_reg_range(0x38000000, 0x3fffffff), /* BOOT_ROM */
> +	regmap_reg_range(0xa0000000, 0xbfffffff), /* GPHY */
> +};
> +
> +static const struct regmap_access_table an8855_readable_table = {
> +	.yes_ranges = an8855_readable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(an8855_readable_ranges),
> +};
> +
> +static const struct regmap_config an8855_regmap_config = {
> +	.name = "switch",
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = 0xbfffffff,
> +	.reg_read = an8855_regmap_read,
> +	.reg_write = an8855_regmap_write,
> +	.reg_update_bits = an8855_regmap_update_bits,
> +	.disable_locking = true,
> +	.rd_table = &an8855_readable_table,
> +};
> +
> +static int an855_regmap_phy_reset_page(struct an8855_core_priv *priv,
> +				       int phy) __must_hold(&priv->bus->mdio_lock)
> +{
> +	/* Check PHY page only for addr shared with switch */
> +	if (phy != priv->switch_addr)
> +		return 0;
> +
> +	/* Don't restore page if it's not set to Switch page */
> +	if (priv->current_page != FIELD_GET(AN8855_PHY_PAGE,
> +					    AN8855_PHY_PAGE_EXTENDED_4))
> +		return 0;
> +
> +	/*
> +	 * Restore page to 0, PHY might change page right after but that
> +	 * will be ignored as it won't be a switch page.
> +	 */
> +	return an8855_mii_set_page(priv, phy, AN8855_PHY_PAGE_STANDARD);
> +}
> +
> +static int an8855_regmap_phy_read(void *ctx, uint32_t reg, uint32_t *val)
> +{
> +	struct an8855_phy_priv *priv = ctx;
> +	struct an8855_core_priv *core_priv;
> +	u32 addr = priv->addr;
> +	struct mii_bus *bus;
> +	int ret;
> +
> +	core_priv = priv->core;
> +	bus = core_priv->bus;
> +
> +	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
> +	ret = an855_regmap_phy_reset_page(core_priv, addr);
> +	if (ret)
> +		goto exit;
> +
> +	ret = __mdiobus_read(bus, addr, reg);
> +	if (ret >= 0)
> +		*val = ret;
> +
> +exit:
> +	mutex_unlock(&bus->mdio_lock);
> +
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static int an8855_regmap_phy_write(void *ctx, uint32_t reg, uint32_t val)
> +{
> +	struct an8855_phy_priv *priv = ctx;
> +	struct an8855_core_priv *core_priv;
> +	u32 addr = priv->addr;
> +	struct mii_bus *bus;
> +	int ret;
> +
> +	core_priv = priv->core;
> +	bus = core_priv->bus;
> +
> +	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
> +	ret = an855_regmap_phy_reset_page(core_priv, addr);
> +	if (ret)
> +		goto exit;
> +
> +	ret = __mdiobus_write(bus, addr, reg, val);
> +
> +exit:
> +	mutex_unlock(&bus->mdio_lock);
> +
> +	return ret;
> +}
> +
> +static const struct regmap_config an8855_phy_regmap_config = {
> +	.reg_bits = 16,
> +	.val_bits = 16,
> +	.reg_read = an8855_regmap_phy_read,
> +	.reg_write = an8855_regmap_phy_write,
> +	.disable_locking = true,
> +	.max_register = 0x1f,
> +};
> +
> +static int an8855_read_switch_id(struct device *dev, struct regmap *regmap)
> +{
> +	u32 id;
> +	int ret;
> +
> +	ret = regmap_read(regmap, AN8855_CREV, &id);
> +	if (ret)
> +		return ret;
> +
> +	if (id != AN8855_ID) {
> +		dev_err(dev, "Detected Switch ID %x but %x was expected\n",
> +			id, AN8855_ID);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static int an8855_phy_register(struct device *dev, struct an8855_core_priv *priv,
> +			       struct device_node *phy_np)
> +{
> +	struct mdio_regmap_config mrc = { };
> +	struct an8855_phy_priv *phy_priv;
> +	struct regmap *regmap;
> +	struct mii_bus *bus;
> +	u8 phy_offset;
> +	u32 addr;
> +	int ret;
> +
> +	ret = of_property_read_u32(phy_np, "reg", &addr);
> +	if (ret)
> +		return ret;
> +
> +	phy_offset = addr - priv->switch_addr;
> +	if (phy_offset >= AN8855_MAX_PHY_PORT)
> +		return -EINVAL;
> +
> +	phy_priv = devm_kzalloc(dev, sizeof(*phy_priv), GFP_KERNEL);
> +	if (!phy_priv)
> +		return -ENOMEM;
> +
> +	phy_priv->addr = addr;
> +	phy_priv->core = priv;
> +
> +	regmap = devm_regmap_init(dev, NULL, phy_priv, &an8855_phy_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "phy%d regmap initialization failed\n",
> +				      addr);
> +
> +	mrc.regmap = regmap;
> +	mrc.parent = dev;
> +	mrc.valid_addr = addr;
> +	snprintf(mrc.name, MII_BUS_ID_SIZE, "an8855-phy%d-mii", addr);
> +
> +	bus = devm_mdio_regmap_register(dev, &mrc);
> +	if (IS_ERR(bus))
> +		return PTR_ERR(bus);
> +
> +	return fwnode_mdiobus_register_phy(bus, of_fwnode_handle(phy_np), addr);
> +}
> +
> +static int an855_mdio_register(struct device *dev, struct an8855_core_priv *priv)
> +{
> +	struct device_node *mdio_np;
> +	int ret = 0;
> +
> +	mdio_np = of_get_child_by_name(dev->of_node, "mdio");
> +	if (!mdio_np)
> +		return -ENODEV;
> +
> +	for_each_available_child_of_node_scoped(mdio_np, phy_np) {
> +		ret = an8855_phy_register(dev, priv, phy_np);
> +		if (ret)
> +			break;
> +	}
> +
> +	of_node_put(mdio_np);
> +	return ret;
> +}
> +
> +static int an8855_core_probe(struct mdio_device *mdiodev)
> +{
> +	struct device *dev = &mdiodev->dev;
> +	struct an8855_core_priv *priv;
> +	struct gpio_desc *reset_gpio;
> +	struct regmap *regmap;
> +	u32 val;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->bus = mdiodev->bus;
> +	priv->switch_addr = mdiodev->addr;
> +	/* No DMA for mdiobus, mute warning for DMA mask not set */
> +	dev->dma_mask = &dev->coherent_dma_mask;
> +
> +	regmap = devm_regmap_init(dev, NULL, priv, &an8855_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "regmap initialization failed\n");
> +
> +	ret = an855_mdio_register(dev, priv);
> +	if (ret)
> +		return ret;
> +
> +	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(reset_gpio))
> +		return PTR_ERR(reset_gpio);
> +
> +	if (reset_gpio) {
> +		usleep_range(100000, 150000);
> +		gpiod_set_value_cansleep(reset_gpio, 0);
> +		usleep_range(100000, 150000);
> +		gpiod_set_value_cansleep(reset_gpio, 1);

Is this correct? Isn't the default logical value of the GPIO "0"?
And when you set the GPIO to logical 1 and go, doesn't that mean you're
leaving the reset asserted?

Is it really GPIOD_OUT_LOW?

Also, why do you need to sleep before the first gpiod_set_value_cansleep() call?
What are you waiting for?

> +
> +		/* Poll HWTRAP reg to wait for Switch to fully Init */
> +		ret = regmap_read_poll_timeout(regmap, AN8855_HWTRAP, val,
> +					       val, 20, 200000);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = an8855_read_switch_id(dev, regmap);
> +	if (ret)
> +		return ret;
> +
> +	/* Release global PHY power down */
> +	ret = regmap_write(regmap, AN8855_RG_GPHY_AFE_PWD, 0x0);
> +	if (ret)
> +		return ret;
> +
> +	return devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, an8855_cells,
> +				    ARRAY_SIZE(an8855_cells), NULL, 0,
> +				    NULL);
> +}
> +
> +static const struct of_device_id an8855_core_of_match[] = {
> +	{ .compatible = "airoha,an8855" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, an8855_core_of_match);
> +
> +static struct mdio_driver an8855_core_driver = {
> +	.probe = an8855_core_probe,
> +	.mdiodrv.driver = {
> +		.name = "an8855",
> +		.of_match_table = an8855_core_of_match,
> +	},
> +};
> +mdio_module_driver(an8855_core_driver);
> +
> +MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
> +MODULE_DESCRIPTION("Driver for Airoha AN8855");
> +MODULE_LICENSE("GPL");
> -- 
> 2.51.0
> 


