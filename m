Return-Path: <netdev+bounces-203424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDB6AF5E29
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 18:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01E39522C1D
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 16:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1692EBBAA;
	Wed,  2 Jul 2025 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhLT66Qz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621132E7BB9;
	Wed,  2 Jul 2025 16:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751472739; cv=none; b=VEkeppyfodrgz8YJmWWeOVaTPoac53jJYmeQVz+3Mx69xX9TTuKWA2ZX8Q6kTX0uMWrAsJy0fRvA+z/W+nKalXlu4STK3HsAawuWNyOETZJJqt83P94Z2UiZ+Om91LOUAwwb5GDhMzKJpM2k6JGhgkvO5Pe00cWh7AEejPEIekk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751472739; c=relaxed/simple;
	bh=TFp7aezr/UNOAZstyTIBGkoYUirbtbx7u9huIRuuK50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWcriEaxYc7jHuS2QzG1XaRCBAhRdgY10L/fD0kzvRv+naoc+q6tz8/i1u7R9y9wz/L1m1dcsFGzWrftYh3jJFGLAGzZYeuYxKTuv+vurHYTHsBSbUb45C+cHHWIP6rMeZIpPFP700B40eQkt5IFOJeFBsIN9pdUzgqBlYquX1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhLT66Qz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44ADCC4CEE7;
	Wed,  2 Jul 2025 16:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751472738;
	bh=TFp7aezr/UNOAZstyTIBGkoYUirbtbx7u9huIRuuK50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DhLT66Qz3IDH5x5jbbzz1ZjRjqOr+6ra/+r6XpboPLlcAOpl71N8JRUIyScKGesqk
	 7FMazVHS4dNdMLtRxol/ucD4JW/59diDwaLX2OxGF/J3nAVQFx4cZDat0ZZZHWM4TT
	 EEbatZcEPEd4xTGxRcW1llrL+KvCZvNxEwRNZm634iavHAXc106cdAy6kVCMkoBAcz
	 PK8l2ITroojV2ldTNP9cWiZqfbpr0xnYeup1ESdDMhzQPc1sV+SD6j/3fs9ATAaDlR
	 lswGISBCjhZiMKJT3VlasWJ/e0sJHlFDanoNKLisMzZcQD9TroGhPnhtizNsWW8WZW
	 y/pEyBi9bXM3g==
Date: Wed, 2 Jul 2025 17:12:11 +0100
From: Lee Jones <lee@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Simon Horman <horms@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v15 09/12] mfd: an8855: Add support for Airoha
 AN8855 Switch MFD
Message-ID: <20250702161211.GW10134@google.com>
References: <20250626212321.28114-1-ansuelsmth@gmail.com>
 <20250626212321.28114-10-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250626212321.28114-10-ansuelsmth@gmail.com>

> Add support for Airoha AN8855 Switch MFD that provide support for a DSA

Drop the MFD part from here and the subject line.

> switch and a NVMEM provider. Also provide support for the PBUS MDIO
> to access the internal PHYs address from the switch registers to permit
> the usage of a single regmap to handle both switch and PHYs.
> 
> An interesting HW bug wes discovered with the implementation of the MDIO
> PBUS where the PHY status is not correctly detected if the PBUS is used
> to read the PHY BMSR. For the only BMSR register, it's required to read
> the address directly from the MDIO bus.
> 
> A check and a workaround is implemented to address this in the
> regmap_read function.

Couple of final points.

Some of them are repeated from previous reviews.

> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/mfd/Kconfig         |  12 ++
>  drivers/mfd/Makefile        |   1 +
>  drivers/mfd/airoha-an8855.c | 393 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 406 insertions(+)
>  create mode 100644 drivers/mfd/airoha-an8855.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 6fb3768e3d71..f2bfd6c9fc5f 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -53,6 +53,18 @@ config MFD_ALTERA_SYSMGR
>  	  using regmap_mmio accesses for ARM32 parts and SMC calls to
>  	  EL3 for ARM64 parts.
>  
> +config MFD_AIROHA_AN8855
> +	tristate "Airoha AN8855 Switch Core"
> +	select MFD_CORE
> +	select MDIO_DEVICE
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
> index 79495f9f3457..f541b513f41e 100644
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
> index 000000000000..bb03a2436f25
> --- /dev/null
> +++ b/drivers/mfd/airoha-an8855.c
> @@ -0,0 +1,393 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Core driver for Airoha AN8855 Switch

No Copyright?

> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/dsa/an8855.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mdio.h>
> +#include <linux/mdio/mdio-regmap.h>
> +#include <linux/module.h>
> +#include <linux/phy.h>
> +#include <linux/regmap.h>
> +
> +/* Register for HW trap status */
> +#define AN8855_HWTRAP			0x1000009c
> +
> +#define AN8855_CREV			0x10005000

Please change the name of this or comment it.

I still have no idea what it is.

> +#define   AN8855_ID			0x8855

Device ID, Chip ID, Platform ID, Driver's ID?

> +#define AN8855_RG_GPHY_AFE_PWD		0x1028c840

No clue.  Comment please.

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
> +struct an8855_core_priv {
> +	struct mii_bus *bus;
> +

Do we need this separation between only 2 attributes?

> +	unsigned int switch_addr;
> +};
> +
> +static const struct mfd_cell an8855_core_childs[] = {

an8855_{devs,cells}

> +	{
> +		.name = "an8855-efuse",
> +		.of_compatible = "airoha,an8855-efuse",

MFD_CELL_OF()

> +	}, {
> +		.name = "an8855-switch",
> +		.of_compatible = "airoha,an8855-switch",
> +	}, {
> +		.name = "an8855-mdio",
> +		.of_compatible = "airoha,an8855-mdio",
> +	}
> +};
> +
> +static bool an8855_is_pbus_bmcr_reg(u32 reg)
> +{
> +	if ((reg & ~(AN8855_GPHY_PORT | AN8855_ADDR)) != AN8855_GPHY_ACCESS)
> +		return false;
> +
> +	if ((reg & AN8855_ADDR) != FIELD_PREP_CONST(AN8855_CL22_ADDR,
> +						    MII_BMSR))
> +		return false;
> +
> +	return true;
> +}
> +
> +/* PHY page is Global for every Switch PHY.
> + * Configure it to 4 (as Switch PAGE) and keep it that way.
> + * Page selection doesn't affect the first PHY address from 0x0 to
> + * 0xf and we use PBUS to access the PHY address.
> + */

Proper multi-line comments please.

> +static int an8855_mii_set_page(struct an8855_core_priv *priv, u8 addr,
> +			       u8 page) __must_hold(&priv->bus->mdio_lock)
> +{
> +	struct mii_bus *bus = priv->bus;
> +	int ret;
> +
> +	ret = __mdiobus_write(bus, addr, AN8855_PHY_SELECT_PAGE, page);
> +	if (ret)
> +		dev_err_ratelimited(&bus->dev, "failed to set mii page\n");
> +
> +	return ret;
> +}
> +
> +static int an8855_mii_read32(struct mii_bus *bus, u8 phy_id, u32 reg,
> +			     u32 *val) __must_hold(&bus->mdio_lock)
> +{
> +	int lo, hi, ret;
> +
> +	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_MODE,
> +			      AN8855_PBUS_MODE_ADDR_FIXED);

You can use up to 100-chars, if you want to avoid all of this wraps.

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
> +	/* Workaround a HW BUG where using only PBUS for
> +	 * accessing internal PHY register cause the port status
> +	 * to not be correctly detected. It seems BMSR is required
> +	 * to go through direct MDIO read or is never refreshed.
> +	 *
> +	 * A theory about this is that PHY sideband signal is
> +	 * checked only with MDIO operation on BMSR and using
> +	 * PBUS doesn't trigger the check.
> +	 *
> +	 * Using interrupt to detect Link Up might be possible
> +	 * but it's considered an optional feature for the Switch
> +	 * reference (hence there could be devices with the
> +	 * interrupt line not connected)
> +	 */

Re: comment formatting - as above and throughout.

> +	if (an8855_is_pbus_bmcr_reg(reg)) {
> +		addr += FIELD_GET(AN8855_GPHY_PORT, reg);
> +		*val = mdiobus_read(bus, addr, MII_BMSR);
> +		return 0;
> +	}
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
> +	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(reset_gpio))
> +		return PTR_ERR(reset_gpio);
> +
> +	if (reset_gpio) {
> +		usleep_range(100000, 150000);
> +		gpiod_set_value_cansleep(reset_gpio, 0);
> +		usleep_range(100000, 150000);
> +		gpiod_set_value_cansleep(reset_gpio, 1);
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
> +	return devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, an8855_core_childs,
> +				    ARRAY_SIZE(an8855_core_childs), NULL, 0,
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
> +MODULE_DESCRIPTION("Driver for Airoha AN8855 MFD");

Drop MFD.

> +MODULE_LICENSE("GPL");
> -- 
> 2.48.1
> 

-- 
Lee Jones [李琼斯]

