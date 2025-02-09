Return-Path: <netdev+bounces-164397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 567E9A2DBB0
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 09:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C83A3A546A
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 08:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30DC13B2BB;
	Sun,  9 Feb 2025 08:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/I/4eR2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A8CE57D;
	Sun,  9 Feb 2025 08:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739090503; cv=none; b=UnNHSXNhFPmE2rwzQGNBNUsv/wMrI+eBqIYE/0+2DSeyrEcg/zfkg6xyvOdm7MUtvFncFl1VmB6RKAj6tWkEScyLCPrg2szsMs1HRtI7Xb+SsRGa/NAPKkshKDuhlcRYoAgUahdmay4vckNWtI6ooAf3uHufdA8+fLPb6gbild0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739090503; c=relaxed/simple;
	bh=tXUwqLqqUyTXibDQaq/walXGMdy4ze3NTGYNkG0Ei1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udzO+Tco68vUpomAa5tDaUq60lwe+r3vQCJFyMFGov05XRdjP+mZpTmjti2s7CCvTdTHfF1Vfxlhcn41JH51KB7UZlANkKyGWBOY80Z0EBoXN1tllMYkPCNRMnWnUuOiIyBAOtxQd0jzKRMLEf5PS5+1FpZDfQrV6YSvF27R8Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/I/4eR2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4368a293339so37777935e9.3;
        Sun, 09 Feb 2025 00:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739090500; x=1739695300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5o8Ivwyd3rWhyoUQ97eMQIxP5xs7MHZGBFAWM3XnHuA=;
        b=R/I/4eR2+IbT7N5m9m9B3JIXcVx5/I9JHZ+lGjeyNbqCo3YD878kdjmW5czgSCLRH+
         IfIlNdburMx+DTTuVFE1WjpKKzLls/Qt+kmU3AYhct9xWsHQNCBxpRuu1ZHtSLOD0Zjg
         SKErIURq0tEx6ZowOOefW3MjNfDuldsBNxE6zGrRnKmZPuLK9OMrtg1iLeEqYIE/Bm7F
         hrLyxtjQ+6YkCWet26bVzhPYVJOMw3KGYw8wtQfzHQcu49nxWeT5nrrmeSe57rv4b+XW
         6cRwmvcQq2Q9c59YoOkWFx1Ff/0LNUoxFPKzAxJqrDmbJsOIl5zfSJeK31qMxNkGrRth
         sp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739090500; x=1739695300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5o8Ivwyd3rWhyoUQ97eMQIxP5xs7MHZGBFAWM3XnHuA=;
        b=XgEBgj5aL/oroek/2KUHKvJP5xOr32X7/QEXiZfzNKwA15RLwokBtTupyoY4rGa1qy
         DsXzwkMFKMndxnEBdXhPwMgsLCbofqPDKkm3Q2ENWiyR2T+axkyfw6aBsZFdqNtE+0Nm
         J+LadDiZVFKXouitTyIXQDTN8l9eWHmGizgvce0IKqSM3m7TXsZsNCoNqImnqxwJZlIu
         IvPHtxX8cIr9EhZacjugOaL5eUaNNmpmX9AQ4ZHmeYnZHF4+ZZ65jGNntlCkSsmYFt8I
         5msTflmn/QXVo07IDoAfWtGyL8NOLo1rESXFT0+2fNDybiNajX1YzkJshxjnLKVl8QfV
         SRAw==
X-Forwarded-Encrypted: i=1; AJvYcCU688eZAIM8iTa/QypaA73b0wFVIcGFMOJi0xQ7Mx8EXVFzp17xYAUMoTGqD38oUt3aPvq6s6TZlRBTnas=@vger.kernel.org, AJvYcCWqnuwGfJBeiDCnz55yY+P3S0rIrQ96ksMs6GfkbBM8DpgoXm+ccq/NYHFKdWw37Vmpi66hnML7@vger.kernel.org
X-Gm-Message-State: AOJu0YyfjVvkAV5m1jEcKVC+svjS6my+Wrunl9FkaoX5hWlLfSbupt2F
	ilPeB6NFC72sygvXd0/HuhK8l3DaT6AMzlaXCtb7vjwC/UpnW3A3
X-Gm-Gg: ASbGncuDiIaz4P3TqKqY+NLO3YXPB0ALXMsW8WwLqjqWRIMicyfJNzcD0LELpqPOxra
	9TR/aVFc5kg3wmsYDVRtJGkaRwhdTj1TJBkCX/y6vr69fcTBAthrKSfKwvGJc5EuCw3fDcEQiwm
	xdA5k+FLT25ROjfDIrCLRkuTWU+WApZo3wLP9K77eIuzKBbixFciiX+xjC1SvrBpGNCHFJ8yaBm
	bap76Ztlt8GgpqDpJ0omqo5ttq41HiT+cG+zj70jOH5q+WrmDJraBtBh9AmQzvPdfLz9wO/wn59
	w9ZDhvTGfGSW
X-Google-Smtp-Source: AGHT+IEEs5J2wSi7OGmpoScKtnhOcCtPgCH6AjOxebBkBNhz5UJlzwMJSpXZBMzGeXPDgjQfYJlcZQ==
X-Received: by 2002:a05:600c:4f82:b0:434:f9e1:5cf8 with SMTP id 5b1f17b1804b1-439249d1962mr75644615e9.31.1739090499492;
        Sun, 09 Feb 2025 00:41:39 -0800 (PST)
Received: from debian ([2a00:79c0:650:f000:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dc9ffcdsm105705885e9.15.2025.02.09.00.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 00:41:38 -0800 (PST)
Date: Sun, 9 Feb 2025 09:41:35 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: phy: marvell-88q2xxx: Add support for
 PHY LEDs on 88q2xxx
Message-ID: <20250209084135.GA3453@debian>
References: <20250207-marvell-88q2xxx-leds-v2-1-d0034e79e19d@gmail.com>
 <Z6eJ6qPs7ORuOrbt@eichest-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6eJ6qPs7ORuOrbt@eichest-laptop>

Hi Stefan,

Am Sat, Feb 08, 2025 at 05:44:26PM +0100 schrieb Stefan Eichenberger:
> On Fri, Feb 07, 2025 at 05:24:20PM +0100, Dimitri Fedrau wrote:
> > Marvell 88Q2XXX devices support up to two configurable Light Emitting
> > Diode (LED). Add minimal LED controller driver supporting the most common
> > uses with the 'netdev' trigger.
> > 
> > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> 
> Reviewed-by: Stefan Eichenberger <eichest@gmail.com>
> 

thanks for reviewing. I just noticed that led0 is enabled in
mv88q222x_config_init, but I think it should be enabled in
mv88q2xxx_config_init because LED configuration is same for all
mv88q2xxx devices. What do you think ?

> > ---
> > Changes in v2:
> > - Renamed MDIO_MMD_PCS_MV_LED_FUNC_CTRL_GPIO_MASK to
> >   MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LED_1_MASK (Stefan)
> > - Renamed MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX_EN_MASK to
> >   MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LED_0_MASK (Stefan)
> > - Added comment for disabling tx disable feature (Stefan)
> > - Added defines for all led functions (Andrew)
> > - Move enabling of led0 function from mv88q2xxx_probe to
> >   mv88q222x_config_init. When the hardware reset pin is connected to a GPIO
> >   for example and we bring the interface down and up again, the content
> >   of the register MDIO_MMD_PCS_MV_RESET_CTRL is resetted to default.
> >   This means LED function is disabled and can't be enabled again.
> > - Link to v1: https://lore.kernel.org/r/20250110-marvell-88q2xxx-leds-v1-1-22e7734941c2@gmail.com
> > ---
> >  drivers/net/phy/marvell-88q2xxx.c | 175 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 175 insertions(+)
> > 
> > diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
> > index a3996471a1c9a5d4060d5d19ce44aa70e902a83f..2d5ea3e1b26219bb1e050222347c2688903e2430 100644
> > --- a/drivers/net/phy/marvell-88q2xxx.c
> > +++ b/drivers/net/phy/marvell-88q2xxx.c
> > @@ -8,6 +8,7 @@
> >   */
> >  #include <linux/ethtool_netlink.h>
> >  #include <linux/marvell_phy.h>
> > +#include <linux/of.h>
> >  #include <linux/phy.h>
> >  #include <linux/hwmon.h>
> >  
> > @@ -27,6 +28,9 @@
> >  #define MDIO_MMD_AN_MV_STAT2_100BT1		0x2000
> >  #define MDIO_MMD_AN_MV_STAT2_1000BT1		0x4000
> >  
> > +#define MDIO_MMD_PCS_MV_RESET_CTRL		32768
> > +#define MDIO_MMD_PCS_MV_RESET_CTRL_TX_DISABLE	0x8
> > +
> >  #define MDIO_MMD_PCS_MV_INT_EN			32784
> >  #define MDIO_MMD_PCS_MV_INT_EN_LINK_UP		0x0040
> >  #define MDIO_MMD_PCS_MV_INT_EN_LINK_DOWN	0x0080
> > @@ -40,6 +44,22 @@
> >  #define MDIO_MMD_PCS_MV_GPIO_INT_CTRL			32787
> >  #define MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS		0x0800
> >  
> > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL			32790
> > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LED_1_MASK	GENMASK(7, 4)
> > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LED_0_MASK	GENMASK(3, 0)
> > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK		0x0 /* Link established */
> > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_RX_TX	0x1 /* Link established, blink for rx or tx activity */
> > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_1000BT1	0x2 /* Blink 3x for 1000BT1 link established */
> > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_RX_TX_ON		0x3 /* Receive or transmit activity */
> > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_RX_TX		0x4 /* Blink on receive or transmit activity */
> > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX		0x5 /* Transmit activity */
> > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_COPPER	0x6 /* Copper Link established */
> > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_1000BT1_ON	0x7 /* 1000BT1 link established */
> > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_FORCE_OFF		0x8 /* Force off */
> > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_FORCE_ON		0x9 /* Force on */
> > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_FORCE_HIGHZ	0xa /* Force Hi-Z */
> > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_FORCE_BLINK	0xb /* Force blink */
> > +
> >  #define MDIO_MMD_PCS_MV_TEMP_SENSOR1			32833
> >  #define MDIO_MMD_PCS_MV_TEMP_SENSOR1_RAW_INT		0x0001
> >  #define MDIO_MMD_PCS_MV_TEMP_SENSOR1_INT		0x0040
> > @@ -95,8 +115,12 @@
> >  
> >  #define MDIO_MMD_PCS_MV_TDR_OFF_CUTOFF			65246
> >  
> > +#define MV88Q2XXX_LED_INDEX_TX_ENABLE	0
> > +#define MV88Q2XXX_LED_INDEX_GPIO	1
> > +
> >  struct mv88q2xxx_priv {
> >  	bool enable_temp;
> > +	bool enable_led0;
> >  };
> >  
> >  struct mmd_val {
> > @@ -740,15 +764,62 @@ static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
> >  }
> >  #endif
> >  
> > +#if IS_ENABLED(CONFIG_OF_MDIO)
> > +static int mv88q2xxx_leds_probe(struct phy_device *phydev)
> > +{
> > +	struct device_node *node = phydev->mdio.dev.of_node;
> > +	struct mv88q2xxx_priv *priv = phydev->priv;
> > +	struct device_node *leds;
> > +	int ret = 0;
> > +	u32 index;
> > +
> > +	if (!node)
> > +		return 0;
> > +
> > +	leds = of_get_child_by_name(node, "leds");
> > +	if (!leds)
> > +		return 0;
> > +
> > +	for_each_available_child_of_node_scoped(leds, led) {
> > +		ret = of_property_read_u32(led, "reg", &index);
> > +		if (ret)
> > +			goto exit;
> > +
> > +		if (index > MV88Q2XXX_LED_INDEX_GPIO) {
> > +			ret = -EINVAL;
> > +			goto exit;
> > +		}
> > +
> > +		if (index == MV88Q2XXX_LED_INDEX_TX_ENABLE)
> > +			priv->enable_led0 = true;
> > +	}
> > +
> > +exit:
> > +	of_node_put(leds);
> > +
> > +	return ret;
> > +}
> > +
> > +#else
> > +static int mv88q2xxx_leds_probe(struct phy_device *phydev)
> > +{
> > +	return 0;
> > +}
> > +#endif
> > +
> >  static int mv88q2xxx_probe(struct phy_device *phydev)
> >  {
> >  	struct mv88q2xxx_priv *priv;
> > +	int ret;
> >  
> >  	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
> >  	if (!priv)
> >  		return -ENOMEM;
> >  
> >  	phydev->priv = priv;
> > +	ret = mv88q2xxx_leds_probe(phydev);
> > +	if (ret)
> > +		return ret;
> >  
> >  	return mv88q2xxx_hwmon_probe(phydev);
> >  }
> > @@ -829,6 +900,15 @@ static int mv88q222x_config_init(struct phy_device *phydev)
> >  			return ret;
> >  	}
> >  
> > +	/* Enable LED function and disable TX disable feature on LED/TX_ENABLE */
> > +	if (priv->enable_led0) {
> > +		ret = phy_clear_bits_mmd(phydev, MDIO_MMD_PCS,
> > +					 MDIO_MMD_PCS_MV_RESET_CTRL,
> > +					 MDIO_MMD_PCS_MV_RESET_CTRL_TX_DISABLE);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +
> >  	if (phydev->c45_ids.device_ids[MDIO_MMD_PMAPMD] == PHY_ID_88Q2220_REVB0)
> >  		return mv88q222x_revb0_config_init(phydev);
> >  	else
> > @@ -918,6 +998,98 @@ static int mv88q222x_cable_test_get_status(struct phy_device *phydev,
> >  	return 0;
> >  }
> >  
> > +static int mv88q2xxx_led_mode(u8 index, unsigned long rules)
> > +{
> > +	switch (rules) {
> > +	case BIT(TRIGGER_NETDEV_LINK):
> > +		return MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK;
> > +	case BIT(TRIGGER_NETDEV_LINK_1000):
> > +		return MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_1000BT1_ON;
> > +	case BIT(TRIGGER_NETDEV_TX):
> > +		return MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX;
> > +	case BIT(TRIGGER_NETDEV_TX) | BIT(TRIGGER_NETDEV_RX):
> > +		return MDIO_MMD_PCS_MV_LED_FUNC_CTRL_RX_TX;
> > +	case BIT(TRIGGER_NETDEV_LINK) | BIT(TRIGGER_NETDEV_TX) | BIT(TRIGGER_NETDEV_RX):
> > +		return MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_RX_TX;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +}
> > +
> > +static int mv88q2xxx_led_hw_is_supported(struct phy_device *phydev, u8 index,
> > +					 unsigned long rules)
> > +{
> > +	int mode;
> > +
> > +	mode = mv88q2xxx_led_mode(index, rules);
> > +	if (mode < 0)
> > +		return mode;
> > +
> > +	return 0;
> > +}
> > +
> > +static int mv88q2xxx_led_hw_control_set(struct phy_device *phydev, u8 index,
> > +					unsigned long rules)
> > +{
> > +	int mode;
> > +
> > +	mode = mv88q2xxx_led_mode(index, rules);
> > +	if (mode < 0)
> > +		return mode;
> > +
> > +	if (index == MV88Q2XXX_LED_INDEX_TX_ENABLE)
> > +		return phy_modify_mmd(phydev, MDIO_MMD_PCS,
> > +				      MDIO_MMD_PCS_MV_LED_FUNC_CTRL,
> > +				      MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LED_0_MASK,
> > +				      FIELD_PREP(MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LED_0_MASK,
> > +						 mode));
> > +	else
> > +		return phy_modify_mmd(phydev, MDIO_MMD_PCS,
> > +				      MDIO_MMD_PCS_MV_LED_FUNC_CTRL,
> > +				      MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LED_1_MASK,
> > +				      FIELD_PREP(MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LED_1_MASK,
> > +						 mode));
> > +}
> > +
> > +static int mv88q2xxx_led_hw_control_get(struct phy_device *phydev, u8 index,
> > +					unsigned long *rules)
> > +{
> > +	int val;
> > +
> > +	val = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_LED_FUNC_CTRL);
> > +	if (val < 0)
> > +		return val;
> > +
> > +	if (index == MV88Q2XXX_LED_INDEX_TX_ENABLE)
> > +		val = FIELD_GET(MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LED_0_MASK, val);
> > +	else
> > +		val = FIELD_GET(MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LED_1_MASK, val);
> > +
> > +	switch (val) {
> > +	case MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK:
> > +		*rules = BIT(TRIGGER_NETDEV_LINK);
> > +		break;
> > +	case MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_1000BT1_ON:
> > +		*rules = BIT(TRIGGER_NETDEV_LINK_1000);
> > +		break;
> > +	case MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX:
> > +		*rules = BIT(TRIGGER_NETDEV_TX);
> > +		break;
> > +	case MDIO_MMD_PCS_MV_LED_FUNC_CTRL_RX_TX:
> > +		*rules = BIT(TRIGGER_NETDEV_TX) | BIT(TRIGGER_NETDEV_RX);
> > +		break;
> > +	case MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_RX_TX:
> > +		*rules = BIT(TRIGGER_NETDEV_LINK) | BIT(TRIGGER_NETDEV_TX) |
> > +			 BIT(TRIGGER_NETDEV_RX);
> > +		break;
> > +	default:
> > +		*rules = 0;
> > +		break;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static struct phy_driver mv88q2xxx_driver[] = {
> >  	{
> >  		.phy_id			= MARVELL_PHY_ID_88Q2110,
> > @@ -953,6 +1125,9 @@ static struct phy_driver mv88q2xxx_driver[] = {
> >  		.get_sqi_max		= mv88q2xxx_get_sqi_max,
> >  		.suspend		= mv88q2xxx_suspend,
> >  		.resume			= mv88q2xxx_resume,
> > +		.led_hw_is_supported	= mv88q2xxx_led_hw_is_supported,
> > +		.led_hw_control_set	= mv88q2xxx_led_hw_control_set,
> > +		.led_hw_control_get	= mv88q2xxx_led_hw_control_get,
> >  	},
> >  };
> >  
> > 
> > ---
> > base-commit: f84db3bc8abc2141839cdb9454061633a4ce1db7
> > change-id: 20241221-marvell-88q2xxx-leds-69a4037b5157
> > 
> > Best regards,
> > -- 
> > Dimitri Fedrau <dima.fedrau@gmail.com>
> > 

