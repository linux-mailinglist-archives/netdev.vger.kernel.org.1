Return-Path: <netdev+bounces-157618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A48E5A0B066
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 08:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 695933A605E
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 07:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8375E23237B;
	Mon, 13 Jan 2025 07:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQtNsNI9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC71232367;
	Mon, 13 Jan 2025 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736755057; cv=none; b=b/qvkm8UGp4qSsudImlBdeKw8BKW0YrmNcQm1t/KUfi8rpt4aHH72Wv7S15hT4vI28DkfU0DeFxl86Q3hNcJ/1na98G6G5hch9IODv1nupYFxnIajlKbaSMBCzDqszOwovlico2SV36wpPyhdLlXWlTzxWQP4vQM1thyXvfdB2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736755057; c=relaxed/simple;
	bh=QsBvCUGBh3SLkJDVgT1igQYnxS8PzlXgC6F4QcDfQ6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=te3kNhWrZwVO74cLEqvuS5w/YwDRn+YqxEfiLYAUBAqkuUIJ1YqPHnt63LeFSFk6JQ4+gax9xiazwFobVe3YCvWbMxYdp268tx7JA9wnv/z4GvwnYu5G39WeC4jdBmOtCmiebeOve+9Y+T5q/gFcOK7x1mIeNfW2tckBil64tiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQtNsNI9; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385e0e224cbso2066215f8f.2;
        Sun, 12 Jan 2025 23:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736755054; x=1737359854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nP/93YbvP3jGbAI0GYQHIsOvwjnO3buvGdeyjjKvCSs=;
        b=TQtNsNI9wt6O2UJ7Ta6B8eJUhzNgG5CYRqHQQNgjfLAQo/8H5QR53zoiVBOaQTf9Re
         IdTHwctN/hJuONGxPOEbz0+WIceOCvu7/OY/Nr0vKkTWSrEUKZ2Wt5Po6R1XhS+p3EKR
         Cb+E1RjSlAyc/eu8bszELR3VlABVAuZcvyyJcXTuN8R5D8Cakyv9dHurddc1JqiIaMKU
         SCoysREZCLRSoJoTbIZbgD9Ugt0XKN81r9z5iKxsdgJVgjPc8x5ukPczPML+MsMoalHp
         X+KJ1HM9JOExFt7X01mLX/e+RDlJxTFiClNbRgHwzgwB5LZLG0BejhaB5Eh88/Oihpvd
         Eikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736755054; x=1737359854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nP/93YbvP3jGbAI0GYQHIsOvwjnO3buvGdeyjjKvCSs=;
        b=ZC5PWlcCHRslDm/ENyftsNJUo8QFNKvQ3VqMPMxLiBs4a60AGyKxehN/UlEF/6E2Ft
         cVgCdGjVgPh8lBC7e7+xa5tAU13XO1x3AgQ8wAdP73t13VvAPg9z3ZpXpzzepHEczByo
         gj/cyPqW8l2i9+kIVLrhAoZKwCFnQ3Ehu/f2mcdQ96XlyyNCw3n1zpq8ZDgEvL3Eksl7
         XKOag772t44XZ8LlfIP3SLExPwdA+uK7hf2rRkOXFnicMScnko9ixsTLtStDosEMMSpc
         6mycmI/2U68aM8cRAUKkHvntGvjPG6ZaXWQTiBc0shsY8lffT63Gr0K/hxNU0yLUwlBI
         Lm6A==
X-Forwarded-Encrypted: i=1; AJvYcCUOJYk2fvIdykS4FVyagtq96TAlU9huX6nZJaytvlzg4ipFXRd4a1IiEtg35ELAvpxGlXKzomtwqQxAV5U=@vger.kernel.org, AJvYcCW04ph0/kaMSsHRnoKGv2d/04AKa17AZsdwKdk34FiiQReTC24oHyyh1gozOOPMDcRVRbdlm38R@vger.kernel.org
X-Gm-Message-State: AOJu0YxHAosJFIGq2IV10A9J8Mg7PBI7cjmbmQPZ+KFpEjUdehxqKMV9
	bVD5kwm3IQXOpSoe+MGseIC+iI1kUw8YUlzbtwc1SQXz1fF5UVIz
X-Gm-Gg: ASbGncuanzQ19k1n3ZaicohxVXp5eDwCK+bP/j6icQu7Y2r7xX2m8FnBrczaGLp8NyH
	HMfWHwVVaMIO+YIwKdvQw48ErWF5z0rVUBVhFfAUpOaBqvvl6mJqJMIvl12qRbRqlYdelVHfNsJ
	HUwcZmA9YI6N9JDievsfdzyjCaZYm0zKbBij7Aw5eIkX1Itew1zFicGdO5dqtECZQGr2fusr3CE
	4A4dKQs9lX4nLrGoaVWsBqrUeKHzjA/ITiNzdKeYSRUSxKyCBLtvJ6G
X-Google-Smtp-Source: AGHT+IHJOr4JLeAZstkeJtWFcykxaOBg/ZzyaM+L7FV+XzSpsWg3EogF33oUtYAuH8hisjGIZtyQHw==
X-Received: by 2002:a05:6000:4008:b0:38b:d8a5:df3f with SMTP id ffacd0b85a97d-38bd8a5e15emr2869173f8f.0.1736755053666;
        Sun, 12 Jan 2025 23:57:33 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:a5a1:302a:fcf7:c337])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1b2asm11179971f8f.89.2025.01.12.23.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 23:57:33 -0800 (PST)
Date: Mon, 13 Jan 2025 08:57:31 +0100
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
Subject: Re: [PATCH] net: phy: marvell-88q2xxx: Add support for PHY LEDs on
 88q2xxx
Message-ID: <Z4THa8DvQJu96Ycl@eichest-laptop>
References: <20250110-marvell-88q2xxx-leds-v1-1-22e7734941c2@gmail.com>
 <Z4FYjw596FQE4RMP@eichest-laptop>
 <20250110183058.GA208903@debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110183058.GA208903@debian>

Hi Dimitri,

On Fri, Jan 10, 2025 at 07:30:58PM +0100, Dimitri Fedrau wrote:
> Hi Stefan,
> 
> Am Fri, Jan 10, 2025 at 06:27:43PM +0100 schrieb Stefan Eichenberger:
> > Hi Dimitri ,
> > 
> > On Fri, Jan 10, 2025 at 04:10:04PM +0100, Dimitri Fedrau wrote:
> > > Marvell 88Q2XXX devices support up to two configurable Light Emitting
> > > Diode (LED). Add minimal LED controller driver supporting the most common
> > > uses with the 'netdev' trigger.
> > > 
> > > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > > ---
> > >  drivers/net/phy/marvell-88q2xxx.c | 161 ++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 161 insertions(+)
> > > 
> > > diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
> > > index 5107f58338aff4ed6cfea4d91e37282d9bb60ba5..bef3357b9d279fca5d1f86ff0eaa0d45a699e3f9 100644
> > > --- a/drivers/net/phy/marvell-88q2xxx.c
> > > +++ b/drivers/net/phy/marvell-88q2xxx.c
> > > @@ -8,6 +8,7 @@
> > >   */
> > >  #include <linux/ethtool_netlink.h>
> > >  #include <linux/marvell_phy.h>
> > > +#include <linux/of.h>
> > >  #include <linux/phy.h>
> > >  #include <linux/hwmon.h>
> > >  
> > > @@ -27,6 +28,9 @@
> > >  #define MDIO_MMD_AN_MV_STAT2_100BT1		0x2000
> > >  #define MDIO_MMD_AN_MV_STAT2_1000BT1		0x4000
> > >  
> > > +#define MDIO_MMD_PCS_MV_RESET_CTRL		32768
> > > +#define MDIO_MMD_PCS_MV_RESET_CTRL_TX_DISABLE	0x8
> > > +
> > >  #define MDIO_MMD_PCS_MV_INT_EN			32784
> > >  #define MDIO_MMD_PCS_MV_INT_EN_LINK_UP		0x0040
> > >  #define MDIO_MMD_PCS_MV_INT_EN_LINK_DOWN	0x0080
> > > @@ -40,6 +44,15 @@
> > >  #define MDIO_MMD_PCS_MV_GPIO_INT_CTRL			32787
> > >  #define MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS		0x0800
> > >  
> > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL			32790
> > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_GPIO_MASK		GENMASK(7, 4)
> > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX_EN_MASK	GENMASK(3, 0)
> > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK		0x0 /* Link established */
> > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_RX_TX	0x1 /* Link established, blink for rx or tx activity */
> > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_RX_TX		0x4 /* Receive or Transmit activity */
> > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX		0x5 /* Transmit activity */
> > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_1000BT1	0x7 /* 1000BT1 link established */
> > > +
> > >  #define MDIO_MMD_PCS_MV_TEMP_SENSOR1			32833
> > >  #define MDIO_MMD_PCS_MV_TEMP_SENSOR1_RAW_INT		0x0001
> > >  #define MDIO_MMD_PCS_MV_TEMP_SENSOR1_INT		0x0040
> > > @@ -95,6 +108,9 @@
> > >  
> > >  #define MDIO_MMD_PCS_MV_TDR_OFF_CUTOFF			65246
> > >  
> > > +#define MV88Q2XXX_LED_INDEX_TX_ENABLE	0
> > > +#define MV88Q2XXX_LED_INDEX_GPIO	1
> > 
> > Not sure if I understand this. TX_ENABLE would be LED0 and GPIO would be
> > LED1? In my datasheet the 88Q222x only has a GPIO pin (which is also
> > TX_ENABLE), is this a problem? Would we need a led_count variable per
> > chip? 
> > 
> Yes you understand it correctly.
> Looking at the datasheets for 88Q212x, 88Q211x and 88Q222x, they have all
> TX_ENABLE and GPIO pin. Registers are also the same. Did I miss anything ?
> For which device GPIO pin and TX_ENABLE are the same ?
> 

Hmm in my datasheet the bits 4:7 in Register 3:0x8016 are marked as
reserved. However, maybe my datasheet is outdated. I have the TD-000217
Rev. 9 from November 10, 2023. It is for the following chips:
88Q2220/88Q2220M/88Q2221/88Q2221M/88Q1200M/88Q1201M
If it is documented in your datasheet, then it is fine. Maybe they just
forgot to document them in the one I have.

> > In the 88Q2110 I can see that there is a TX_ENABLE (0) and a GPIO (1)
> > pin. In the register description they just call it LED [0] Control and
> > LED [1] Control. Maybe calling it LED_0 and LED_1 would be easier to
> > understand? Same for MDIO_MMD_PCS_MV_LED_FUNC_CTRL_GPIO_MASK and
> > MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX_EN_MASK.
> > 
> I named them just as the pin. Probably it would be easier to understand,
> but the mapping between pin and index would be lost. What do you think ?
> 
> > > +
> > >  struct mmd_val {
> > >  	int devad;
> > >  	u32 regnum;
> > > @@ -741,8 +757,58 @@ static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
> > >  }
> > >  #endif
> > >  
> > > +#if IS_ENABLED(CONFIG_OF_MDIO)
> > > +static int mv88q2xxx_leds_probe(struct phy_device *phydev)
> > > +{
> > > +	struct device_node *node = phydev->mdio.dev.of_node;
> > > +	struct device_node *leds;
> > > +	int ret = 0;
> > > +	u32 index;
> > > +
> > > +	if (!node)
> > > +		return 0;
> > > +
> > > +	leds = of_get_child_by_name(node, "leds");
> > > +	if (!leds)
> > > +		return 0;
> > > +
> > > +	for_each_available_child_of_node_scoped(leds, led) {
> > > +		ret = of_property_read_u32(led, "reg", &index);
> > > +		if (ret)
> > > +			goto exit;
> > > +
> > > +		if (index > MV88Q2XXX_LED_INDEX_GPIO) {
> > > +			ret = -EINVAL;
> > > +			goto exit;
> > > +		}
> > > +
> > > +		if (index == MV88Q2XXX_LED_INDEX_TX_ENABLE)
> > > +			ret = phy_clear_bits_mmd(phydev, MDIO_MMD_PCS,
> > > +						 MDIO_MMD_PCS_MV_RESET_CTRL,
> > > +						 MDIO_MMD_PCS_MV_RESET_CTRL_TX_DISABLE);
> > 
> > If I understand it correctly, this switches the function of the pin from
> > TX_DISABLE to GPIO? Can you maybe add a comment here?
> >
> You are right, will add the comment.

Perfekt, thanks.

Regards,
Stefan

