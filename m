Return-Path: <netdev+bounces-164348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1CFA2D78D
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 17:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5821621A2
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 16:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07092241C83;
	Sat,  8 Feb 2025 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgMQYfEW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004A1241C81;
	Sat,  8 Feb 2025 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739033073; cv=none; b=rFufJQzezMGq2OjzUhZ8lsp5h++OO/mAmwAy8mEuN6PvLe2gA267zkG6NPLKExXeqNgVyLRCFbRTDWg+jMGUlkm7bY/ciDF/U4VRDWC64XZBBv1EIk9d9U/dQB+thob793TpoRw7nYIOZNsA8SHUukQcHstFVxjdTnYgxV3m0UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739033073; c=relaxed/simple;
	bh=Wi1cukaBKl7wJ1ryBf0CzzYN6RJ8X/yFKpZnUx6we/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnunojKRIKr2XfbEuirfDrMuU0aaqv4ICithub8VfK/5mwTyK0myZuJL01VszePsJIEIKDjONWDOGR4fspg0BEh3e1v8UHtS5ZbD0JKqJppS7zNzpsvIlOHsvacFX5mEgHm4QA3QqBeC/ieTVilaNFhmuMgSfZazE6/iD8NEdoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgMQYfEW; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436345cc17bso21211755e9.0;
        Sat, 08 Feb 2025 08:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739033069; x=1739637869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BDlOiHC8sHItlK3/6dDeOVlhcqVJF9QWYjkv+Pe1BlA=;
        b=YgMQYfEW7cSl82o/ErYBvYdGb6l4s6U9p0VlTUhuNOazeKKtDqV0uh5wPoiTZ87OfM
         LKm/WNTOLqYW+HCcQfIzTjfu7v5+ySj7vTCga9QSPl5axxt70EdzI2u0RlxnBcEqP3+R
         HgfPZp0dYD+zW4aU9UDOgOqv0upMV+I1sR2W+uJRMy4FuFub6hnukfOUO6vod3K2WOBh
         OsvbKq4jX7R2bhETDaf0P9RxMy9CUjB+oIH/VisHPGtE2PP2DJhNPFbpNyrwCfYz8otT
         eJe1g+lpQD8cingufCM8ewMQHr8IZu2nnFOMt/e34i7ptJbHgFYdJl4AFR6dZGVplm9f
         lZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739033069; x=1739637869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDlOiHC8sHItlK3/6dDeOVlhcqVJF9QWYjkv+Pe1BlA=;
        b=gL2EC3RxcHFkWgbKR8xd07T6fishcadEtIzm3wzsqaLGntqJxjVBL5A2GuipotMB6l
         ifSmJO3foEcoxci8Oz+HiAbhQ5AOvaSTdNKzX3WEC6wCDEAxWbRdFqoxxZ3EwIltwxiF
         UcPJuP24+9NvsYZc4y1Hs9dTWWI4NeVJvhYmJUuwK74+GzNnEsmGeAK4axXdx//Gip4I
         nicdFLibeqapUdQL+DtS/VNF05SnUWqEuL9RJrYkuKhF2CrOJlthtHVj8aBwVwlQF6/G
         eKGTArERUjyKpBNS/ahieOXiJutQ2UUW8KfvGyqOVh6OU6+WTVhz0RiC79Vvcp0wlNp8
         AesQ==
X-Forwarded-Encrypted: i=1; AJvYcCWayGt/3bp5ryMWzzIsvnYGS4uGd4qfNddazTHO7nnTeOGNIxjsOvHQd3+E4k/m/WO7gX9ZRZblCJnIt4A=@vger.kernel.org, AJvYcCXPkDp3AfWXEOnyYWjWOghN8wU2m6DfkNr+Yk29PiCqgw1egwzLDwxnhleSwYLmgffYOMjYR3zu@vger.kernel.org
X-Gm-Message-State: AOJu0Yx66dYdY2Gw6mIlaE6QmEYdiKeyHdmCA4dNIP9V9XTH+W1zFFnf
	kpyNQ4lNYAfVa+OJijnZ/OxzCRQrSb0Jgp4xCm5wg9gjfGw7aBuf
X-Gm-Gg: ASbGncsVaeplgkx5X7TWWwdneDQvtIc986Ve2pVRJQP2ToUBlIv+BZM2m8gMEXvIucm
	hvFbjGxooUwz1IdIOvS0pwTY+RHaF68YXsvm2RjGNdR5tvCzpi0C+quhEXoa/7qQsfY8rUMiTl7
	/3xdu076MzpE/3W/FzHUFYZ2rwpY52wrApvmc9iObFjnBv2aWfytFpOzOuRzqjLcAIF5fFSfDOi
	/9H9osVcT0cOMeU/VuzcSCI1aVA+4BuEDH1nqisDulkT9ov7xIgypcrc4PN7OydYi9hhNMNx4tw
	gDpSIeYgnJbmVxY=
X-Google-Smtp-Source: AGHT+IGVpzAZE/bahW1NaXJZUKHg42UhW4hhkGeSi/wTMm5VNecR0MtBEvzeR+/+rANEw+qaygcmjA==
X-Received: by 2002:a05:600c:524c:b0:431:5044:e388 with SMTP id 5b1f17b1804b1-439249b2ec4mr50617495e9.22.1739033068979;
        Sat, 08 Feb 2025 08:44:28 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:11e7:8133:9f13:70d7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390daf3c70sm125376075e9.26.2025.02.08.08.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 08:44:28 -0800 (PST)
Date: Sat, 8 Feb 2025 17:44:26 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: phy: marvell-88q2xxx: Add support for
 PHY LEDs on 88q2xxx
Message-ID: <Z6eJ6qPs7ORuOrbt@eichest-laptop>
References: <20250207-marvell-88q2xxx-leds-v2-1-d0034e79e19d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-marvell-88q2xxx-leds-v2-1-d0034e79e19d@gmail.com>

On Fri, Feb 07, 2025 at 05:24:20PM +0100, Dimitri Fedrau wrote:
> Marvell 88Q2XXX devices support up to two configurable Light Emitting
> Diode (LED). Add minimal LED controller driver supporting the most common
> uses with the 'netdev' trigger.
> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>

Reviewed-by: Stefan Eichenberger <eichest@gmail.com>

> ---
> Changes in v2:
> - Renamed MDIO_MMD_PCS_MV_LED_FUNC_CTRL_GPIO_MASK to
>   MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LED_1_MASK (Stefan)
> - Renamed MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX_EN_MASK to
>   MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LED_0_MASK (Stefan)
> - Added comment for disabling tx disable feature (Stefan)
> - Added defines for all led functions (Andrew)
> - Move enabling of led0 function from mv88q2xxx_probe to
>   mv88q222x_config_init. When the hardware reset pin is connected to a GPIO
>   for example and we bring the interface down and up again, the content
>   of the register MDIO_MMD_PCS_MV_RESET_CTRL is resetted to default.
>   This means LED function is disabled and can't be enabled again.
> - Link to v1: https://lore.kernel.org/r/20250110-marvell-88q2xxx-leds-v1-1-22e7734941c2@gmail.com
> ---
>  drivers/net/phy/marvell-88q2xxx.c | 175 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 175 insertions(+)
> 
> diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
> index a3996471a1c9a5d4060d5d19ce44aa70e902a83f..2d5ea3e1b26219bb1e050222347c2688903e2430 100644
> --- a/drivers/net/phy/marvell-88q2xxx.c
> +++ b/drivers/net/phy/marvell-88q2xxx.c
> @@ -8,6 +8,7 @@
>   */
>  #include <linux/ethtool_netlink.h>
>  #include <linux/marvell_phy.h>
> +#include <linux/of.h>
>  #include <linux/phy.h>
>  #include <linux/hwmon.h>
>  
> @@ -27,6 +28,9 @@
>  #define MDIO_MMD_AN_MV_STAT2_100BT1		0x2000
>  #define MDIO_MMD_AN_MV_STAT2_1000BT1		0x4000
>  
> +#define MDIO_MMD_PCS_MV_RESET_CTRL		32768
> +#define MDIO_MMD_PCS_MV_RESET_CTRL_TX_DISABLE	0x8
> +
>  #define MDIO_MMD_PCS_MV_INT_EN			32784
>  #define MDIO_MMD_PCS_MV_INT_EN_LINK_UP		0x0040
>  #define MDIO_MMD_PCS_MV_INT_EN_LINK_DOWN	0x0080
> @@ -40,6 +44,22 @@
>  #define MDIO_MMD_PCS_MV_GPIO_INT_CTRL			32787
>  #define MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS		0x0800
>  
> +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL			32790
> +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LED_1_MASK	GENMASK(7, 4)
> +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LED_0_MASK	GENMASK(3, 0)
> +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK		0x0 /* Link established */
> +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_RX_TX	0x1 /* Link established, blink for rx or tx activity */
> +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_1000BT1	0x2 /* Blink 3x for 1000BT1 link established */
> +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_RX_TX_ON		0x3 /* Receive or transmit activity */
> +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_RX_TX		0x4 /* Blink on receive or transmit activity */
> +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX		0x5 /* Transmit activity */
> +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_COPPER	0x6 /* Copper Link established */
> +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_1000BT1_ON	0x7 /* 1000BT1 link established */
> +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_FORCE_OFF		0x8 /* Force off */
> +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_FORCE_ON		0x9 /* Force on */
> +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_FORCE_HIGHZ	0xa /* Force Hi-Z */
> +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_FORCE_BLINK	0xb /* Force blink */
> +
>  #define MDIO_MMD_PCS_MV_TEMP_SENSOR1			32833
>  #define MDIO_MMD_PCS_MV_TEMP_SENSOR1_RAW_INT		0x0001
>  #define MDIO_MMD_PCS_MV_TEMP_SENSOR1_INT		0x0040
> @@ -95,8 +115,12 @@
>  
>  #define MDIO_MMD_PCS_MV_TDR_OFF_CUTOFF			65246
>  
> +#define MV88Q2XXX_LED_INDEX_TX_ENABLE	0
> +#define MV88Q2XXX_LED_INDEX_GPIO	1
> +
>  struct mv88q2xxx_priv {
>  	bool enable_temp;
> +	bool enable_led0;
>  };
>  
>  struct mmd_val {
> @@ -740,15 +764,62 @@ static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
>  }
>  #endif
>  
> +#if IS_ENABLED(CONFIG_OF_MDIO)
> +static int mv88q2xxx_leds_probe(struct phy_device *phydev)
> +{
> +	struct device_node *node = phydev->mdio.dev.of_node;
> +	struct mv88q2xxx_priv *priv = phydev->priv;
> +	struct device_node *leds;
> +	int ret = 0;
> +	u32 index;
> +
> +	if (!node)
> +		return 0;
> +
> +	leds = of_get_child_by_name(node, "leds");
> +	if (!leds)
> +		return 0;
> +
> +	for_each_available_child_of_node_scoped(leds, led) {
> +		ret = of_property_read_u32(led, "reg", &index);
> +		if (ret)
> +			goto exit;
> +
> +		if (index > MV88Q2XXX_LED_INDEX_GPIO) {
> +			ret = -EINVAL;
> +			goto exit;
> +		}
> +
> +		if (index == MV88Q2XXX_LED_INDEX_TX_ENABLE)
> +			priv->enable_led0 = true;
> +	}
> +
> +exit:
> +	of_node_put(leds);
> +
> +	return ret;
> +}
> +
> +#else
> +static int mv88q2xxx_leds_probe(struct phy_device *phydev)
> +{
> +	return 0;
> +}
> +#endif
> +
>  static int mv88q2xxx_probe(struct phy_device *phydev)
>  {
>  	struct mv88q2xxx_priv *priv;
> +	int ret;
>  
>  	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
>  
>  	phydev->priv = priv;
> +	ret = mv88q2xxx_leds_probe(phydev);
> +	if (ret)
> +		return ret;
>  
>  	return mv88q2xxx_hwmon_probe(phydev);
>  }
> @@ -829,6 +900,15 @@ static int mv88q222x_config_init(struct phy_device *phydev)
>  			return ret;
>  	}
>  
> +	/* Enable LED function and disable TX disable feature on LED/TX_ENABLE */
> +	if (priv->enable_led0) {
> +		ret = phy_clear_bits_mmd(phydev, MDIO_MMD_PCS,
> +					 MDIO_MMD_PCS_MV_RESET_CTRL,
> +					 MDIO_MMD_PCS_MV_RESET_CTRL_TX_DISABLE);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	if (phydev->c45_ids.device_ids[MDIO_MMD_PMAPMD] == PHY_ID_88Q2220_REVB0)
>  		return mv88q222x_revb0_config_init(phydev);
>  	else
> @@ -918,6 +998,98 @@ static int mv88q222x_cable_test_get_status(struct phy_device *phydev,
>  	return 0;
>  }
>  
> +static int mv88q2xxx_led_mode(u8 index, unsigned long rules)
> +{
> +	switch (rules) {
> +	case BIT(TRIGGER_NETDEV_LINK):
> +		return MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK;
> +	case BIT(TRIGGER_NETDEV_LINK_1000):
> +		return MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_1000BT1_ON;
> +	case BIT(TRIGGER_NETDEV_TX):
> +		return MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX;
> +	case BIT(TRIGGER_NETDEV_TX) | BIT(TRIGGER_NETDEV_RX):
> +		return MDIO_MMD_PCS_MV_LED_FUNC_CTRL_RX_TX;
> +	case BIT(TRIGGER_NETDEV_LINK) | BIT(TRIGGER_NETDEV_TX) | BIT(TRIGGER_NETDEV_RX):
> +		return MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_RX_TX;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int mv88q2xxx_led_hw_is_supported(struct phy_device *phydev, u8 index,
> +					 unsigned long rules)
> +{
> +	int mode;
> +
> +	mode = mv88q2xxx_led_mode(index, rules);
> +	if (mode < 0)
> +		return mode;
> +
> +	return 0;
> +}
> +
> +static int mv88q2xxx_led_hw_control_set(struct phy_device *phydev, u8 index,
> +					unsigned long rules)
> +{
> +	int mode;
> +
> +	mode = mv88q2xxx_led_mode(index, rules);
> +	if (mode < 0)
> +		return mode;
> +
> +	if (index == MV88Q2XXX_LED_INDEX_TX_ENABLE)
> +		return phy_modify_mmd(phydev, MDIO_MMD_PCS,
> +				      MDIO_MMD_PCS_MV_LED_FUNC_CTRL,
> +				      MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LED_0_MASK,
> +				      FIELD_PREP(MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LED_0_MASK,
> +						 mode));
> +	else
> +		return phy_modify_mmd(phydev, MDIO_MMD_PCS,
> +				      MDIO_MMD_PCS_MV_LED_FUNC_CTRL,
> +				      MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LED_1_MASK,
> +				      FIELD_PREP(MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LED_1_MASK,
> +						 mode));
> +}
> +
> +static int mv88q2xxx_led_hw_control_get(struct phy_device *phydev, u8 index,
> +					unsigned long *rules)
> +{
> +	int val;
> +
> +	val = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_LED_FUNC_CTRL);
> +	if (val < 0)
> +		return val;
> +
> +	if (index == MV88Q2XXX_LED_INDEX_TX_ENABLE)
> +		val = FIELD_GET(MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LED_0_MASK, val);
> +	else
> +		val = FIELD_GET(MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LED_1_MASK, val);
> +
> +	switch (val) {
> +	case MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK:
> +		*rules = BIT(TRIGGER_NETDEV_LINK);
> +		break;
> +	case MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_1000BT1_ON:
> +		*rules = BIT(TRIGGER_NETDEV_LINK_1000);
> +		break;
> +	case MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX:
> +		*rules = BIT(TRIGGER_NETDEV_TX);
> +		break;
> +	case MDIO_MMD_PCS_MV_LED_FUNC_CTRL_RX_TX:
> +		*rules = BIT(TRIGGER_NETDEV_TX) | BIT(TRIGGER_NETDEV_RX);
> +		break;
> +	case MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_RX_TX:
> +		*rules = BIT(TRIGGER_NETDEV_LINK) | BIT(TRIGGER_NETDEV_TX) |
> +			 BIT(TRIGGER_NETDEV_RX);
> +		break;
> +	default:
> +		*rules = 0;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
>  static struct phy_driver mv88q2xxx_driver[] = {
>  	{
>  		.phy_id			= MARVELL_PHY_ID_88Q2110,
> @@ -953,6 +1125,9 @@ static struct phy_driver mv88q2xxx_driver[] = {
>  		.get_sqi_max		= mv88q2xxx_get_sqi_max,
>  		.suspend		= mv88q2xxx_suspend,
>  		.resume			= mv88q2xxx_resume,
> +		.led_hw_is_supported	= mv88q2xxx_led_hw_is_supported,
> +		.led_hw_control_set	= mv88q2xxx_led_hw_control_set,
> +		.led_hw_control_get	= mv88q2xxx_led_hw_control_get,
>  	},
>  };
>  
> 
> ---
> base-commit: f84db3bc8abc2141839cdb9454061633a4ce1db7
> change-id: 20241221-marvell-88q2xxx-leds-69a4037b5157
> 
> Best regards,
> -- 
> Dimitri Fedrau <dima.fedrau@gmail.com>
> 

