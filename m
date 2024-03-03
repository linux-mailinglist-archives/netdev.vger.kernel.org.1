Return-Path: <netdev+bounces-76860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2280886F36B
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 03:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1FAE1F21C53
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 02:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F418372;
	Sun,  3 Mar 2024 02:38:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1847F;
	Sun,  3 Mar 2024 02:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709433495; cv=none; b=pJA5RF5oalHwm9IgYTHtT/sPunD/nnPNIQuXsKEFC1cVkHxotLzB4IT6PIOhqoHTC4ucL2cahXAxROF/yf2xlrOxEOkMnJeSA3KR2e4tvBpWRMDOqSL4PJuJ9xKalNWhg+r5A0UPQ6hKqvbEYNE/JreB6DktG5ifMehEd6zpWE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709433495; c=relaxed/simple;
	bh=/owaB6FdSQQfOjPlvI/b1O+jpqJDjalglYwdjYSbGHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxUfMql5f44/w+g3SoSn08OdXmGhXzCYtOw2OybZVBUImRKqewEGz/2pM2wsJ+cooUpvRcXMo6i7kha8L5xPTXnSEAg7pF+4y79DUg1tKK+32mNHQ06ds2olVfLbowu0lRo+ijTVp5W/21gUCkrkA3GmZKfzdfMDcCcuAT7136Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rgbjR-0003j8-0T;
	Sun, 03 Mar 2024 02:37:41 +0000
Date: Sun, 3 Mar 2024 02:37:36 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Lucien Jheng <lucien.jheng@airoha.com>,
	Zhi-Jun You <hujy652@protonmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 net-next 2/2] net: phy: air_en8811h: Add the Airoha
 EN8811H PHY driver
Message-ID: <ZePicFOrsr5wTE_n@makrotopia.org>
References: <20240302183835.136036-1-ericwouds@gmail.com>
 <20240302183835.136036-3-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240302183835.136036-3-ericwouds@gmail.com>

On Sat, Mar 02, 2024 at 07:38:35PM +0100, Eric Woudstra wrote:
> Add the driver for the Airoha EN8811H 2.5 Gigabit PHY. The phy supports
> 100/1000/2500 Mbps with auto negotiation only.
> 
> The driver uses two firmware files, for which updated versions are added to
> linux-firmware already.
> 
> Note: At phy-address + 8 there is another device on the mdio bus, that
> belongs to the EN881H. While the original driver writes to it, Airoha
Typo, missing '1'   ^^^

> has confirmed this is not needed. Therefore, communication with this
> device is not included in this driver.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

See some minor comments inline below

> ---
>  drivers/net/phy/Kconfig       |    5 +
>  drivers/net/phy/Makefile      |    1 +
>  drivers/net/phy/air_en8811h.c | 1035 +++++++++++++++++++++++++++++++++
>  3 files changed, 1041 insertions(+)
>  create mode 100644 drivers/net/phy/air_en8811h.c
> 
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 1df0595c5ba9..7fddc8306d82 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -76,6 +76,11 @@ config SFP
>  
>  comment "MII PHY device drivers"
>  
> +config AIR_EN8811H_PHY
> +	tristate "Airoha EN8811H 2.5 Gigabit PHY"
> +	help
> +	  Currently supports the Airoha EN8811H PHY.
> +
>  config AMD_PHY
>  	tristate "AMD and Altima PHYs"
>  	help
> diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
> index 197acfa0b412..202ed7f450da 100644
> --- a/drivers/net/phy/Makefile
> +++ b/drivers/net/phy/Makefile
> @@ -34,6 +34,7 @@ obj-y				+= $(sfp-obj-y) $(sfp-obj-m)
>  
>  obj-$(CONFIG_ADIN_PHY)		+= adin.o
>  obj-$(CONFIG_ADIN1100_PHY)	+= adin1100.o
> +obj-$(CONFIG_AIR_EN8811H_PHY)   += air_en8811h.o
>  obj-$(CONFIG_AMD_PHY)		+= amd.o
>  obj-$(CONFIG_AQUANTIA_PHY)	+= aquantia/
>  ifdef CONFIG_AX88796B_RUST_PHY
> diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
> new file mode 100644
> index 000000000000..8a3bd40cf4d1
> --- /dev/null
> +++ b/drivers/net/phy/air_en8811h.c
> @@ -0,0 +1,1035 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Driver for the Airoha EN8811H 2.5 Gigabit PHY.
> + *
> + * Limitations of the EN8811H:
> + * - Only full duplex supported
> + * - Forced speed (AN off) is not supported by hardware (100Mbps)
> + *
> + * Source originated from airoha's en8811h.c and en8811h.h v1.2.1
> + *
> + * Copyright (C) 2023 Airoha Technology Corp.
> + */
> +
> +#include <linux/phy.h>
> +#include <linux/firmware.h>
> +#include <linux/property.h>
> +#include <asm/unaligned.h>
> +
> +#define EN8811H_PHY_ID		0x03a2a411
> +
> +#define EN8811H_MD32_DM		"airoha/EthMD32.dm.bin"
> +#define EN8811H_MD32_DSP	"airoha/EthMD32.DSP.bin"
> +
> +#define AIR_FW_ADDR_DM	0x00000000
> +#define AIR_FW_ADDR_DSP	0x00100000
> +
> +/* u32 (DWORD) component macros */
> +#define LOWORD(d) ((u16)(u32)(d))
> +#define HIWORD(d) ((u16)(((u32)(d)) >> 16))

You could use the existing macros in wordpart.h instead.

> +
> +/* MII Registers */
> +#define AIR_AUX_CTRL_STATUS		0x1d
> +#define   AIR_AUX_CTRL_STATUS_SPEED_MASK	GENMASK(4, 2)
> +#define   AIR_AUX_CTRL_STATUS_SPEED_100		0x4
> +#define   AIR_AUX_CTRL_STATUS_SPEED_1000	0x8
> +#define   AIR_AUX_CTRL_STATUS_SPEED_2500	0xc
> +
> +#define AIR_EXT_PAGE_ACCESS		0x1f
> +#define   AIR_PHY_PAGE_STANDARD			0x0000
> +#define   AIR_PHY_PAGE_EXTENDED_4		0x0004
> +
> +/* MII Registers Page 4*/
> +#define AIR_BPBUS_MODE			0x10
> +#define   AIR_BPBUS_MODE_ADDR_FIXED		0x0000
> +#define   AIR_BPBUS_MODE_ADDR_INCR		BIT(15)
> +#define AIR_BPBUS_WR_ADDR_HIGH		0x11
> +#define AIR_BPBUS_WR_ADDR_LOW		0x12
> +#define AIR_BPBUS_WR_DATA_HIGH		0x13
> +#define AIR_BPBUS_WR_DATA_LOW		0x14
> +#define AIR_BPBUS_RD_ADDR_HIGH		0x15
> +#define AIR_BPBUS_RD_ADDR_LOW		0x16
> +#define AIR_BPBUS_RD_DATA_HIGH		0x17
> +#define AIR_BPBUS_RD_DATA_LOW		0x18
> +
> +/* Registers on MDIO_MMD_VEND1 */
> +#define EN8811H_PHY_FW_STATUS		0x8009
> +#define   EN8811H_PHY_READY			0x02
> +
> +#define AIR_PHY_HOST_CMD_1		0x800c
> +#define AIR_PHY_HOST_CMD_1_MODE1		0x0
> +#define AIR_PHY_HOST_CMD_2		0x800d
> +#define AIR_PHY_HOST_CMD_2_MODE1		0x0
> +#define AIR_PHY_HOST_CMD_3		0x800e
> +#define AIR_PHY_HOST_CMD_3_MODE1		0x1101
> +#define AIR_PHY_HOST_CMD_3_DOCMD		0x1100
> +#define AIR_PHY_HOST_CMD_4		0x800f
> +#define AIR_PHY_HOST_CMD_4_MODE1		0x0002
> +#define AIR_PHY_HOST_CMD_4_INTCLR		0x00e4
> +
> +/* Registers on MDIO_MMD_VEND2 */
> +#define AIR_PHY_LED_BCR			0x021
> +#define   AIR_PHY_LED_BCR_MODE_MASK		GENMASK(1, 0)
> +#define   AIR_PHY_LED_BCR_TIME_TEST		BIT(2)
> +#define   AIR_PHY_LED_BCR_CLK_EN		BIT(3)
> +#define   AIR_PHY_LED_BCR_EXT_CTRL		BIT(15)
> +
> +#define AIR_PHY_LED_DUR_ON		0x022
> +
> +#define AIR_PHY_LED_DUR_BLINK		0x023
> +
> +#define AIR_PHY_LED_ON(i)	       (0x024 + ((i) * 2))
> +#define   AIR_PHY_LED_ON_MASK			(GENMASK(6, 0) | BIT(8))
> +#define   AIR_PHY_LED_ON_LINK1000		BIT(0)
> +#define   AIR_PHY_LED_ON_LINK100		BIT(1)
> +#define   AIR_PHY_LED_ON_LINK10			BIT(2)
> +#define   AIR_PHY_LED_ON_LINKDOWN		BIT(3)
> +#define   AIR_PHY_LED_ON_FDX			BIT(4) /* Full duplex */
> +#define   AIR_PHY_LED_ON_HDX			BIT(5) /* Half duplex */
> +#define   AIR_PHY_LED_ON_FORCE_ON		BIT(6)
> +#define   AIR_PHY_LED_ON_LINK2500		BIT(8)
> +#define   AIR_PHY_LED_ON_POLARITY		BIT(14)
> +#define   AIR_PHY_LED_ON_ENABLE			BIT(15)
> +
> +#define AIR_PHY_LED_BLINK(i)	       (0x025 + ((i) * 2))
> +#define   AIR_PHY_LED_BLINK_1000TX		BIT(0)
> +#define   AIR_PHY_LED_BLINK_1000RX		BIT(1)
> +#define   AIR_PHY_LED_BLINK_100TX		BIT(2)
> +#define   AIR_PHY_LED_BLINK_100RX		BIT(3)
> +#define   AIR_PHY_LED_BLINK_10TX		BIT(4)
> +#define   AIR_PHY_LED_BLINK_10RX		BIT(5)
> +#define   AIR_PHY_LED_BLINK_COLLISION		BIT(6)
> +#define   AIR_PHY_LED_BLINK_RX_CRC_ERR		BIT(7)
> +#define   AIR_PHY_LED_BLINK_RX_IDLE_ERR		BIT(8)
> +#define   AIR_PHY_LED_BLINK_FORCE_BLINK		BIT(9)
> +#define   AIR_PHY_LED_BLINK_2500TX		BIT(10)
> +#define   AIR_PHY_LED_BLINK_2500RX		BIT(11)
> +
> +/* Registers on BUCKPBUS */
> +#define EN8811H_2P5G_LPA		0x3b30
> +#define   EN8811H_2P5G_LPA_2P5G			BIT(0)
> +
> +#define EN8811H_FW_VERSION		0x3b3c
> +
> +#define EN8811H_POLARITY		0xca0f8
> +#define   EN8811H_POLARITY_TX_NORMAL		BIT(0)
> +#define   EN8811H_POLARITY_RX_REVERSE		BIT(1)
> +
> +#define EN8811H_GPIO_OUTPUT		0xcf8b8
> +#define   EN8811H_GPIO_OUTPUT_345		(BIT(3) | BIT(4) | BIT(5))
> +
> +#define EN8811H_FW_CTRL_1		0x0f0018
> +#define   EN8811H_FW_CTRL_1_START		0x0
> +#define   EN8811H_FW_CTRL_1_FINISH		0x1
> +#define EN8811H_FW_CTRL_2		0x800000
> +#define EN8811H_FW_CTRL_2_LOADING		BIT(11)
> +
> +/* Led definitions */
> +#define EN8811H_LED_COUNT	3
> +
> +/* GPIO5  <-> BASE_T_LED0
> + * GPIO4  <-> BASE_T_LED1
> + * GPIO3  <-> BASE_T_LED2
> + *
> + * Default setup suitable for 2 leds connected:
> + *    100M link up triggers led0, only led0 blinking on traffic
> + *   1000M link up triggers led1, only led1 blinking on traffic
> + *   2500M link up triggers led0 and led1, both blinking on traffic
> + * Also suitable for 1 led connected:
> + *     any link up triggers led2
> + */
> +#define AIR_DEFAULT_TRIGGER_LED0 (BIT(TRIGGER_NETDEV_LINK_2500) | \
> +				  BIT(TRIGGER_NETDEV_LINK_100)  | \
> +				  BIT(TRIGGER_NETDEV_RX)        | \
> +				  BIT(TRIGGER_NETDEV_TX))
> +#define AIR_DEFAULT_TRIGGER_LED1 (BIT(TRIGGER_NETDEV_LINK_2500) | \
> +				  BIT(TRIGGER_NETDEV_LINK_1000) | \
> +				  BIT(TRIGGER_NETDEV_RX)        | \
> +				  BIT(TRIGGER_NETDEV_TX))
> +#define AIR_DEFAULT_TRIGGER_LED2  BIT(TRIGGER_NETDEV_LINK)
> +
> +struct led {
> +	unsigned long rules;
> +	unsigned long state;
> +};
> +
> +struct en8811h_priv {
> +	u32		firmware_version;
> +	struct led	led[EN8811H_LED_COUNT];
> +};
> +
> +enum {
> +	AIR_PHY_LED_STATE_FORCE_ON,
> +	AIR_PHY_LED_STATE_FORCE_BLINK,
> +};
> +
> +enum {
> +	AIR_PHY_LED_DUR_BLINK_32M,
> +	AIR_PHY_LED_DUR_BLINK_64M,
> +	AIR_PHY_LED_DUR_BLINK_128M,
> +	AIR_PHY_LED_DUR_BLINK_256M,
> +	AIR_PHY_LED_DUR_BLINK_512M,
> +	AIR_PHY_LED_DUR_BLINK_1024M,
> +};
> +
> +enum {
> +	AIR_LED_DISABLE,
> +	AIR_LED_ENABLE,
> +};
> +
> +enum {
> +	AIR_ACTIVE_LOW,
> +	AIR_ACTIVE_HIGH,
> +};
> +
> +enum {
> +	AIR_LED_MODE_DISABLE,
> +	AIR_LED_MODE_USER_DEFINE,
> +};
> +
> +#define AIR_PHY_LED_DUR_UNIT	1024
> +#define AIR_PHY_LED_DUR (AIR_PHY_LED_DUR_UNIT << AIR_PHY_LED_DUR_BLINK_64M)
> +
> +static const unsigned long en8811h_led_trig = BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
> +					      BIT(TRIGGER_NETDEV_LINK)        |
> +					      BIT(TRIGGER_NETDEV_LINK_10)     |
> +					      BIT(TRIGGER_NETDEV_LINK_100)    |
> +					      BIT(TRIGGER_NETDEV_LINK_1000)   |
> +					      BIT(TRIGGER_NETDEV_LINK_2500)   |
> +					      BIT(TRIGGER_NETDEV_RX)          |
> +					      BIT(TRIGGER_NETDEV_TX);
> +
> +static int air_phy_read_page(struct phy_device *phydev)
> +{
> +	return __phy_read(phydev, AIR_EXT_PAGE_ACCESS);
> +}
> +
> +static int air_phy_write_page(struct phy_device *phydev, int page)
> +{
> +	return __phy_write(phydev, AIR_EXT_PAGE_ACCESS, page);
> +}
> +
> +static int __air_buckpbus_reg_write(struct phy_device *phydev,
> +				    u32 pbus_address, u32 pbus_data,
> +				    bool set_mode)
> +{
> +	int ret;
> +
> +	if (set_mode) {
> +		ret = __phy_write(phydev, AIR_BPBUS_MODE,
> +				  AIR_BPBUS_MODE_ADDR_FIXED);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = __phy_write(phydev, AIR_BPBUS_WR_ADDR_HIGH, HIWORD(pbus_address));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = __phy_write(phydev, AIR_BPBUS_WR_ADDR_LOW,  LOWORD(pbus_address));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = __phy_write(phydev, AIR_BPBUS_WR_DATA_HIGH, HIWORD(pbus_data));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = __phy_write(phydev, AIR_BPBUS_WR_DATA_LOW,  LOWORD(pbus_data));
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int air_buckpbus_reg_write(struct phy_device *phydev,
> +				  u32 pbus_address, u32 pbus_data)
> +{
> +	int saved_page;
> +	int ret = 0;
> +
> +	saved_page = phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
> +
> +	if (saved_page >= 0) {
> +		ret = __air_buckpbus_reg_write(phydev, pbus_address, pbus_data,
> +					       true);
> +		if (ret < 0)
> +			phydev_err(phydev, "%s 0x%08x failed: %d\n", __func__,
> +				   pbus_address, ret);
> +	}
> +
> +	return phy_restore_page(phydev, saved_page, ret);
> +}
> +
> +static int __air_buckpbus_reg_read(struct phy_device *phydev,
> +				   u32 pbus_address, u32 *pbus_data)
> +{
> +	int pbus_data_low, pbus_data_high;
> +	int ret;
> +
> +	ret = __phy_write(phydev, AIR_BPBUS_MODE, AIR_BPBUS_MODE_ADDR_FIXED);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = __phy_write(phydev, AIR_BPBUS_RD_ADDR_HIGH, HIWORD(pbus_address));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = __phy_write(phydev, AIR_BPBUS_RD_ADDR_LOW,  LOWORD(pbus_address));
> +	if (ret < 0)
> +		return ret;
> +
> +	pbus_data_high = __phy_read(phydev, AIR_BPBUS_RD_DATA_HIGH);
> +	if (pbus_data_high < 0)
> +		return ret;
> +
> +	pbus_data_low = __phy_read(phydev, AIR_BPBUS_RD_DATA_LOW);
> +	if (pbus_data_low < 0)
> +		return ret;
> +
> +	*pbus_data = pbus_data_low | (pbus_data_high << 16);
> +	return 0;
> +}
> +
> +static int air_buckpbus_reg_read(struct phy_device *phydev,
> +				 u32 pbus_address, u32 *pbus_data)
> +{
> +	int saved_page;
> +	int ret = 0;
> +
> +	saved_page = phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
> +
> +	if (saved_page >= 0) {
> +		ret = __air_buckpbus_reg_read(phydev, pbus_address, pbus_data);
> +		if (ret < 0)
> +			phydev_err(phydev, "%s 0x%08x failed: %d\n", __func__,
> +				   pbus_address, ret);
> +	}
> +
> +	return phy_restore_page(phydev, saved_page, ret);
> +}
> +
> +static int air_buckpbus_reg_modify(struct phy_device *phydev,
> +				   u32 pbus_address, u32 mask, u32 set)
> +{
> +	u32 pbus_data_old, pbus_data_new;
> +	int saved_page;
> +	int ret = 0;
> +
> +	saved_page = phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
> +
> +	if (saved_page >= 0) {
> +		ret = __air_buckpbus_reg_read(phydev, pbus_address, &pbus_data_old);
> +
> +		if (!ret) {
> +			pbus_data_new = (pbus_data_old & ~mask) | set;
> +			if (pbus_data_new != pbus_data_old)
> +				ret = __air_buckpbus_reg_write(phydev, pbus_address,
> +							       pbus_data_new, false);
> +			else
> +				ret = 0;
> +		}
> +
> +		if (ret < 0)
> +			phydev_err(phydev, "%s 0x%08x failed: %d\n", __func__,
> +				   pbus_address, ret);
> +	}
> +
> +	return phy_restore_page(phydev, saved_page, ret);
> +}
> +
> +static int __air_write_buf(struct phy_device *phydev, u32 address,
> +			   const struct firmware *fw)
> +{
> +	unsigned int offset;
> +	int ret;
> +	u16 val;
> +
> +	ret = __phy_write(phydev, AIR_BPBUS_MODE, AIR_BPBUS_MODE_ADDR_INCR);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = __phy_write(phydev, AIR_BPBUS_WR_ADDR_HIGH, HIWORD(address));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = __phy_write(phydev, AIR_BPBUS_WR_ADDR_LOW,  LOWORD(address));
> +	if (ret < 0)
> +		return ret;
> +
> +	for (offset = 0; offset < fw->size; offset += 4) {
> +		val = get_unaligned_le16(&fw->data[offset + 2]);
> +		ret = __phy_write(phydev, AIR_BPBUS_WR_DATA_HIGH, val);
> +		if (ret < 0)
> +			return ret;
> +
> +		val = get_unaligned_le16(&fw->data[offset]);
> +		ret = __phy_write(phydev, AIR_BPBUS_WR_DATA_LOW, val);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int air_write_buf(struct phy_device *phydev, u32 address,
> +			 const struct firmware *fw)
> +{
> +	int saved_page;
> +	int ret = 0;
> +
> +	saved_page = phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
> +
> +	if (saved_page >= 0) {
> +		ret = __air_write_buf(phydev, address, fw);
> +		if (ret < 0)
> +			phydev_err(phydev, "%s 0x%08x failed: %d\n", __func__,
> +				   address, ret);
> +	}
> +
> +	return phy_restore_page(phydev, saved_page, ret);
> +}
> +
> +static int en8811h_load_firmware(struct phy_device *phydev)
> +{
> +	struct device *dev = &phydev->mdio.dev;
> +	const struct firmware *fw1, *fw2;
> +	int ret;
> +
> +	ret = request_firmware_direct(&fw1, EN8811H_MD32_DM, dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = request_firmware_direct(&fw2, EN8811H_MD32_DSP, dev);
> +	if (ret < 0)
> +		goto en8811h_load_firmware_rel1;
> +
> +	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
> +				     EN8811H_FW_CTRL_1_START);
> +	if (ret < 0)
> +		goto en8811h_load_firmware_out;
> +
> +	ret = air_buckpbus_reg_modify(phydev, EN8811H_FW_CTRL_2,
> +				      EN8811H_FW_CTRL_2_LOADING,
> +				      EN8811H_FW_CTRL_2_LOADING);
> +	if (ret < 0)
> +		goto en8811h_load_firmware_out;
> +
> +	ret = air_write_buf(phydev, AIR_FW_ADDR_DM,  fw1);
> +	if (ret < 0)
> +		goto en8811h_load_firmware_out;
> +
> +	ret = air_write_buf(phydev, AIR_FW_ADDR_DSP, fw2);
> +	if (ret < 0)
> +		goto en8811h_load_firmware_out;
> +
> +	ret = air_buckpbus_reg_modify(phydev, EN8811H_FW_CTRL_2,
> +				      EN8811H_FW_CTRL_2_LOADING, 0);
> +	if (ret < 0)
> +		goto en8811h_load_firmware_out;
> +
> +	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
> +				     EN8811H_FW_CTRL_1_FINISH);
> +	if (ret < 0)
> +		goto en8811h_load_firmware_out;
> +
> +	ret = 0;
> +
> +en8811h_load_firmware_out:
> +	release_firmware(fw2);
> +
> +en8811h_load_firmware_rel1:
> +	release_firmware(fw1);
> +
> +	if (ret < 0)
> +		phydev_err(phydev, "Load firmware failed: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int en8811h_restart_host(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
> +				     EN8811H_FW_CTRL_1_START);
> +	if (ret < 0)
> +		return ret;
> +
> +	return air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
> +				     EN8811H_FW_CTRL_1_FINISH);
> +}
> +
> +static int air_hw_led_on_set(struct phy_device *phydev, u8 index, bool on)
> +{
> +	struct en8811h_priv *priv = phydev->priv;
> +	bool changed;
> +
> +	if (index >= EN8811H_LED_COUNT)
> +		return -EINVAL;
> +
> +	if (on)
> +		changed = !test_and_set_bit(AIR_PHY_LED_STATE_FORCE_ON,
> +					    &priv->led[index].state);
> +	else
> +		changed = !!test_and_clear_bit(AIR_PHY_LED_STATE_FORCE_ON,
> +					       &priv->led[index].state);
> +
> +	changed |= (priv->led[index].rules != 0);
> +
> +	if (changed)
> +		return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
> +				      AIR_PHY_LED_ON(index),
> +				      AIR_PHY_LED_ON_MASK,
> +				      on ? AIR_PHY_LED_ON_FORCE_ON : 0);
> +
> +	return 0;
> +}
> +
> +static int air_hw_led_blink_set(struct phy_device *phydev, u8 index,
> +				bool blinking)
> +{
> +	struct en8811h_priv *priv = phydev->priv;
> +	bool changed;
> +
> +	if (index >= EN8811H_LED_COUNT)
> +		return -EINVAL;
> +
> +	if (blinking)
> +		changed = !test_and_set_bit(AIR_PHY_LED_STATE_FORCE_BLINK,
> +					    &priv->led[index].state);
> +	else
> +		changed = !!test_and_clear_bit(AIR_PHY_LED_STATE_FORCE_BLINK,
> +					       &priv->led[index].state);
> +
> +	changed |= (priv->led[index].rules != 0);
> +
> +	if (changed)
> +		return phy_write_mmd(phydev, MDIO_MMD_VEND2,
> +				     AIR_PHY_LED_BLINK(index),
> +				     blinking ?
> +				     AIR_PHY_LED_BLINK_FORCE_BLINK : 0);
> +	else
> +		return 0;
> +}
> +
> +static int air_led_blink_set(struct phy_device *phydev, u8 index,
> +			     unsigned long *delay_on,
> +			     unsigned long *delay_off)
> +{
> +	struct en8811h_priv *priv = phydev->priv;
> +	bool blinking = false;
> +	int err;
> +
> +	if (index >= EN8811H_LED_COUNT)
> +		return -EINVAL;
> +
> +	if (delay_on && delay_off && (*delay_on > 0) && (*delay_off > 0)) {
> +		blinking = true;
> +		*delay_on = 50;
> +		*delay_off = 50;
> +	}
> +
> +	err = air_hw_led_blink_set(phydev, index, blinking);
> +	if (err)
> +		return err;
> +
> +	/* led-blink set, so switch led-on off */
> +	err = air_hw_led_on_set(phydev, index, false);
> +	if (err)
> +		return err;
> +
> +	/* hw-control is off*/
> +	if (!!test_bit(AIR_PHY_LED_STATE_FORCE_BLINK, &priv->led[index].state))
> +		priv->led[index].rules = 0;
> +
> +	return 0;
> +}
> +
> +static int air_led_brightness_set(struct phy_device *phydev, u8 index,
> +				  enum led_brightness value)
> +{
> +	struct en8811h_priv *priv = phydev->priv;
> +	int err;
> +
> +	if (index >= EN8811H_LED_COUNT)
> +		return -EINVAL;
> +
> +	/* led-on set, so switch led-blink off */
> +	err = air_hw_led_blink_set(phydev, index, false);
> +	if (err)
> +		return err;
> +
> +	err = air_hw_led_on_set(phydev, index, (value != LED_OFF));
> +	if (err)
> +		return err;
> +
> +	/* hw-control is off */
> +	if (!!test_bit(AIR_PHY_LED_STATE_FORCE_ON, &priv->led[index].state))
> +		priv->led[index].rules = 0;
> +
> +	return 0;
> +}
> +
> +static int air_led_hw_control_get(struct phy_device *phydev, u8 index,
> +				  unsigned long *rules)
> +{
> +	struct en8811h_priv *priv = phydev->priv;
> +
> +	if (index >= EN8811H_LED_COUNT)
> +		return -EINVAL;
> +
> +	*rules = priv->led[index].rules;
> +
> +	return 0;
> +};
> +
> +static int air_led_hw_control_set(struct phy_device *phydev, u8 index,
> +				  unsigned long rules)
> +{
> +	struct en8811h_priv *priv = phydev->priv;
> +	u16 on = 0, blink = 0;
> +	int ret;
> +
> +	if (index >= EN8811H_LED_COUNT)
> +		return -EINVAL;
> +
> +	priv->led[index].rules = rules;
> +
> +	if (rules & (BIT(TRIGGER_NETDEV_LINK_10)   | BIT(TRIGGER_NETDEV_LINK))) {
> +		on |= AIR_PHY_LED_ON_LINK10;
> +		if (rules & BIT(TRIGGER_NETDEV_RX))
> +			blink |= AIR_PHY_LED_BLINK_10RX;
> +		if (rules & BIT(TRIGGER_NETDEV_TX))
> +			blink |= AIR_PHY_LED_BLINK_10TX;
> +	}
> +
> +	if (rules & (BIT(TRIGGER_NETDEV_LINK_100)  | BIT(TRIGGER_NETDEV_LINK))) {
> +		on |= AIR_PHY_LED_ON_LINK100;
> +		if (rules & BIT(TRIGGER_NETDEV_RX))
> +			blink |= AIR_PHY_LED_BLINK_100RX;
> +		if (rules & BIT(TRIGGER_NETDEV_TX))
> +			blink |= AIR_PHY_LED_BLINK_100TX;
> +	}
> +
> +	if (rules & (BIT(TRIGGER_NETDEV_LINK_1000) | BIT(TRIGGER_NETDEV_LINK))) {
> +		on |= AIR_PHY_LED_ON_LINK1000;
> +		if (rules & BIT(TRIGGER_NETDEV_RX))
> +			blink |= AIR_PHY_LED_BLINK_1000RX;
> +		if (rules & BIT(TRIGGER_NETDEV_TX))
> +			blink |= AIR_PHY_LED_BLINK_1000TX;
> +	}
> +
> +	if (rules & (BIT(TRIGGER_NETDEV_LINK_2500) | BIT(TRIGGER_NETDEV_LINK))) {
> +		on |= AIR_PHY_LED_ON_LINK2500;
> +		if (rules & BIT(TRIGGER_NETDEV_RX))
> +			blink |= AIR_PHY_LED_BLINK_2500RX;
> +		if (rules & BIT(TRIGGER_NETDEV_TX))
> +			blink |= AIR_PHY_LED_BLINK_2500TX;
> +	}
> +
> +	if (on == 0) {
> +		if (rules & BIT(TRIGGER_NETDEV_RX)) {
> +			blink |= AIR_PHY_LED_BLINK_10RX   |
> +				 AIR_PHY_LED_BLINK_100RX  |
> +				 AIR_PHY_LED_BLINK_1000RX |
> +				 AIR_PHY_LED_BLINK_2500RX;
> +		}
> +		if (rules & BIT(TRIGGER_NETDEV_TX)) {
> +			blink |= AIR_PHY_LED_BLINK_10TX   |
> +				 AIR_PHY_LED_BLINK_100TX  |
> +				 AIR_PHY_LED_BLINK_1000TX |
> +				 AIR_PHY_LED_BLINK_2500TX;
> +		}
> +	}
> +
> +	if (rules & BIT(TRIGGER_NETDEV_FULL_DUPLEX))
> +		on |= AIR_PHY_LED_ON_FDX;
> +
> +	if (rules & BIT(TRIGGER_NETDEV_HALF_DUPLEX))
> +		on |= AIR_PHY_LED_ON_HDX;
> +
> +	if (blink || on) {
> +		/* switch hw-control on, so led-on and led-blink are off */
> +		clear_bit(AIR_PHY_LED_STATE_FORCE_ON, &priv->led[index].state);
> +		clear_bit(AIR_PHY_LED_STATE_FORCE_BLINK, &priv->led[index].state);
> +	} else {
> +		priv->led[index].rules = 0;
> +	}
> +
> +	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, AIR_PHY_LED_ON(index),
> +			     AIR_PHY_LED_ON_MASK, on);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return phy_write_mmd(phydev, MDIO_MMD_VEND2, AIR_PHY_LED_BLINK(index),
> +			     blink);
> +};
> +
> +static int air_led_init(struct phy_device *phydev, u8 index, u8 state, u8 pol)
> +{
> +	int val;
> +	int err;
> +
> +	if (index >= EN8811H_LED_COUNT)
> +		return -EINVAL;
> +
> +	if (state == AIR_LED_ENABLE)
> +		val |= AIR_PHY_LED_ON_ENABLE;
> +	else
> +		val &= ~AIR_PHY_LED_ON_ENABLE;
> +
> +	if (pol == AIR_ACTIVE_HIGH)
> +		val |= AIR_PHY_LED_ON_POLARITY;
> +	else
> +		val &= ~AIR_PHY_LED_ON_POLARITY;
> +
> +	err = phy_modify_mmd(phydev, MDIO_MMD_VEND2, AIR_PHY_LED_ON(index),
> +			     AIR_PHY_LED_ON_ENABLE |
> +			     AIR_PHY_LED_ON_POLARITY, val);
> +
> +	if (err < 0)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int air_leds_init(struct phy_device *phydev, int num, int dur, int mode)
> +{
> +	struct en8811h_priv *priv = phydev->priv;
> +	int ret, i;
> +
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, AIR_PHY_LED_DUR_BLINK,
> +			    dur);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, AIR_PHY_LED_DUR_ON,
> +			    dur >> 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (mode) {
> +	case AIR_LED_MODE_DISABLE:
> +		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, AIR_PHY_LED_BCR,
> +				     AIR_PHY_LED_BCR_EXT_CTRL |
> +				     AIR_PHY_LED_BCR_MODE_MASK, 0);
> +		if (ret < 0)
> +			return ret;
> +		break;
> +	case AIR_LED_MODE_USER_DEFINE:
> +		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, AIR_PHY_LED_BCR,
> +				     AIR_PHY_LED_BCR_EXT_CTRL |
> +				     AIR_PHY_LED_BCR_CLK_EN,
> +				     AIR_PHY_LED_BCR_EXT_CTRL |
> +				     AIR_PHY_LED_BCR_CLK_EN);
> +		if (ret < 0)
> +			return ret;
> +		break;
> +	default:
> +		phydev_err(phydev, "LED mode %d is not supported\n", mode);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < num; ++i) {
> +		ret = air_led_init(phydev, i, AIR_LED_ENABLE, AIR_ACTIVE_HIGH);
> +		if (ret < 0) {
> +			phydev_err(phydev, "LED%d init failed: %d\n", i, ret);
> +			return ret;
> +		}
> +		air_led_hw_control_set(phydev, i, priv->led[i].rules);
> +	}
> +
> +	return 0;
> +}
> +
> +static int en8811h_led_hw_is_supported(struct phy_device *phydev, u8 index,
> +				       unsigned long rules)
> +{
> +	if (index >= EN8811H_LED_COUNT)
> +		return -EINVAL;
> +
> +	/* All combinations of the supported triggers are allowed */
> +	if (rules & ~en8811h_led_trig)
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +};
> +
> +static int en8811h_probe(struct phy_device *phydev)
> +{
> +	struct en8811h_priv *priv;
> +
> +	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(struct en8811h_priv),
> +			    GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->led[0].rules = AIR_DEFAULT_TRIGGER_LED0;
> +	priv->led[1].rules = AIR_DEFAULT_TRIGGER_LED1;
> +	priv->led[2].rules = AIR_DEFAULT_TRIGGER_LED2;
> +
> +	phydev->priv = priv;
> +
> +	/* MDIO_DEVS1/2 empty, so set mmds_present bits here */
> +	phydev->c45_ids.mmds_present |= MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
> +
> +	return 0;
> +}
> +
> +static int en8811h_config_init(struct phy_device *phydev)
> +{
> +	struct en8811h_priv *priv = phydev->priv;
> +	struct device *dev = &phydev->mdio.dev;
> +	int ret, pollret, reg_value;
> +	u32 pbus_value;
> +
> +	if (!priv->firmware_version)
> +		ret = en8811h_load_firmware(phydev);
> +	else
> +		ret = en8811h_restart_host(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Because of mdio-lock, may have to wait for multiple loads */
> +	pollret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
> +					    EN8811H_PHY_FW_STATUS, reg_value,
> +					    reg_value == EN8811H_PHY_READY,
> +					    20000, 7500000, true);
> +
> +	ret = air_buckpbus_reg_read(phydev, EN8811H_FW_VERSION, &pbus_value);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (pollret || !pbus_value) {
> +		phydev_err(phydev, "Firmware not ready: 0x%x\n", reg_value);
> +		return -ENODEV;
> +	}
> +
> +	if (!priv->firmware_version) {
> +		phydev_info(phydev, "MD32 firmware version: %08x\n", pbus_value);
> +		priv->firmware_version = pbus_value;
> +	}
> +
> +	/* Select mode 1, the only mode supported */
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, AIR_PHY_HOST_CMD_1,
> +			    AIR_PHY_HOST_CMD_1_MODE1);
> +	if (ret < 0)
> +		return ret;
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, AIR_PHY_HOST_CMD_2,
> +			    AIR_PHY_HOST_CMD_2_MODE1);
> +	if (ret < 0)
> +		return ret;
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, AIR_PHY_HOST_CMD_3,
> +			    AIR_PHY_HOST_CMD_3_MODE1);
> +	if (ret < 0)
> +		return ret;
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, AIR_PHY_HOST_CMD_4,
> +			    AIR_PHY_HOST_CMD_4_MODE1);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Serdes polarity */
> +	pbus_value = 0;
> +	if (device_property_read_bool(dev, "airoha,pnswap-rx"))
> +		pbus_value |=  EN8811H_POLARITY_RX_REVERSE;
> +	else
> +		pbus_value &= ~EN8811H_POLARITY_RX_REVERSE;
> +	if (device_property_read_bool(dev, "airoha,pnswap-tx"))
> +		pbus_value &= ~EN8811H_POLARITY_TX_NORMAL;
> +	else
> +		pbus_value |=  EN8811H_POLARITY_TX_NORMAL;
> +	ret = air_buckpbus_reg_modify(phydev, EN8811H_POLARITY,
> +				      EN8811H_POLARITY_RX_REVERSE |
> +				      EN8811H_POLARITY_TX_NORMAL, pbus_value);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = air_leds_init(phydev, EN8811H_LED_COUNT, AIR_PHY_LED_DUR,
> +			    AIR_LED_MODE_USER_DEFINE);
> +	if (ret < 0) {
> +		phydev_err(phydev, "Failed to initialize leds: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = air_buckpbus_reg_modify(phydev, EN8811H_GPIO_OUTPUT,
> +				      EN8811H_GPIO_OUTPUT_345,
> +				      EN8811H_GPIO_OUTPUT_345);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int en8811h_get_features(struct phy_device *phydev)
> +{
> +	linkmode_set_bit_array(phy_basic_ports_array,
> +			       ARRAY_SIZE(phy_basic_ports_array),
> +			       phydev->supported);
> +
> +	return genphy_c45_pma_read_abilities(phydev);
> +}
> +
> +static int en8811h_get_rate_matching(struct phy_device *phydev,
> +				     phy_interface_t iface)
> +{
> +	return RATE_MATCH_PAUSE;
> +}
> +
> +static int en8811h_config_aneg(struct phy_device *phydev)
> +{
> +	bool changed = false;
> +	int ret;
> +	u32 adv;
> +
> +	adv = linkmode_adv_to_mii_10gbt_adv_t(phydev->advertising);
> +
> +	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
> +				     MDIO_AN_10GBT_CTRL_ADV2_5G, adv);
> +	if (ret < 0)
> +		return ret;
> +	if (ret > 0)
> +		changed = true;
> +
> +	return __genphy_config_aneg(phydev, changed);
> +}
> +
> +static int en8811h_read_status(struct phy_device *phydev)
> +{
> +	struct en8811h_priv *priv = phydev->priv;
> +	u32 pbus_value;
> +	int ret, val;
> +
> +	ret = genphy_update_link(phydev);
> +	if (ret)
> +		return ret;
> +
> +	phydev->master_slave_get = MASTER_SLAVE_CFG_UNSUPPORTED;
> +	phydev->master_slave_state = MASTER_SLAVE_STATE_UNSUPPORTED;
> +	phydev->speed = SPEED_UNKNOWN;
> +	phydev->duplex = DUPLEX_UNKNOWN;
> +	phydev->pause = 0;
> +	phydev->asym_pause = 0;
> +
> +	ret = genphy_read_master_slave(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = genphy_read_lpa(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Get link partner 2.5GBASE-T ability from vendor register */
> +	ret = air_buckpbus_reg_read(phydev, EN8811H_2P5G_LPA, &pbus_value);
> +	if (ret < 0)
> +		return ret;
> +	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> +			 phydev->lp_advertising,
> +			 pbus_value & EN8811H_2P5G_LPA_2P5G);
> +
> +	if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete)
> +		phy_resolve_aneg_pause(phydev);
> +
> +	if (!phydev->link)
> +		return 0;
> +
> +	/* Get real speed from vendor register */
> +	val = phy_read(phydev, AIR_AUX_CTRL_STATUS);
> +	if (val < 0)
> +		return val;
> +	switch (val & AIR_AUX_CTRL_STATUS_SPEED_MASK) {
> +	case AIR_AUX_CTRL_STATUS_SPEED_2500:
> +		phydev->speed = SPEED_2500;
> +		break;
> +	case AIR_AUX_CTRL_STATUS_SPEED_1000:
> +		phydev->speed = SPEED_1000;
> +		break;
> +	case AIR_AUX_CTRL_STATUS_SPEED_100:
> +		phydev->speed = SPEED_100;
> +		break;
> +	}
> +
> +	/* BUG in PHY firmware: MDIO_AN_10GBT_STAT_LP2_5G does not get set.

EN8811H completely lacks MDIO_AN_10GBT_STAT, hence referencing
MDIO_AN_10GBT_STAT_LP2_5G here is confusing.

Suggestion:
	/* BUG in PHY firmware: EN8811H_2P5G_LPA_2P5G does not get set.

Or just skip that line entirely as the following two lines already
perfectly explain the situation.

> +	 * Firmware before version 24011202 has no vendor register 2P5G_LPA.
> +	 * Assume link partner advertised it if connected at 2500Mbps.
> +	 */
> +	if (priv->firmware_version < 0x24011202) {
> +		linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> +				 phydev->lp_advertising,
> +				 phydev->speed == SPEED_2500);
> +	}
> +
> +	/* Only supports full duplex */
> +	phydev->duplex = DUPLEX_FULL;
> +
> +	return 0;
> +}
> +
> +static int en8811h_clear_intr(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, AIR_PHY_HOST_CMD_3,
> +			    AIR_PHY_HOST_CMD_3_DOCMD);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, AIR_PHY_HOST_CMD_4,
> +			    AIR_PHY_HOST_CMD_4_INTCLR);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static irqreturn_t en8811h_handle_interrupt(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = en8811h_clear_intr(phydev);
> +	if (ret < 0) {
> +		phy_error(phydev);
> +		return IRQ_NONE;
> +	}
> +
> +	phy_trigger_machine(phydev);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static struct phy_driver en8811h_driver[] = {
> +{
> +	PHY_ID_MATCH_MODEL(EN8811H_PHY_ID),
> +	.name			= "Airoha EN8811H",
> +	.probe			= en8811h_probe,
> +	.get_features		= en8811h_get_features,
> +	.config_init		= en8811h_config_init,
> +	.get_rate_matching	= en8811h_get_rate_matching,
> +	.config_aneg		= en8811h_config_aneg,
> +	.read_status		= en8811h_read_status,
> +	.config_intr		= en8811h_clear_intr,
> +	.handle_interrupt	= en8811h_handle_interrupt,
> +	.led_hw_is_supported	= en8811h_led_hw_is_supported,
> +	.read_page		= air_phy_read_page,
> +	.write_page		= air_phy_write_page,
> +	.led_blink_set		= air_led_blink_set,
> +	.led_brightness_set	= air_led_brightness_set,
> +	.led_hw_control_set	= air_led_hw_control_set,
> +	.led_hw_control_get	= air_led_hw_control_get,
> +} };
> +
> +module_phy_driver(en8811h_driver);
> +
> +static struct mdio_device_id __maybe_unused en8811h_tbl[] = {
> +	{ PHY_ID_MATCH_MODEL(EN8811H_PHY_ID) },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(mdio, en8811h_tbl);
> +MODULE_FIRMWARE(EN8811H_MD32_DM);
> +MODULE_FIRMWARE(EN8811H_MD32_DSP);
> +
> +MODULE_DESCRIPTION("Airoha EN8811H PHY drivers");
> +MODULE_AUTHOR("Airoha");
> +MODULE_AUTHOR("Eric Woudstra <ericwouds@gmail.com>");
> +MODULE_LICENSE("GPL");
> -- 
> 2.42.1
> 

