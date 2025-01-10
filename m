Return-Path: <netdev+bounces-157243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A736A09974
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 19:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D883AB11A
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 18:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDB0213E9C;
	Fri, 10 Jan 2025 18:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+LEolSY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266A1207E17;
	Fri, 10 Jan 2025 18:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736533865; cv=none; b=ZDHfMKlqGT8bbXmXMYl0RrAdw5jEFXgH6TemkLYhcE/KTX0G41XkLlNIJAnrVYeq/Bp6sBE0C3sbRFBkHMHP095r8KQj9BZg/wIKSqEvd1I5N1jcklJScOAcmyk/lEf7mnTdMIez6/mlaa9d0E1GApcPJmE8BbCkkW3avfmRPyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736533865; c=relaxed/simple;
	bh=WwiyA0dJesQja20YtlHeWLKj0GE2PpEvyTNO/sxA0e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROs+hNxArNG8PGN4ZHPSm5HKjSAYQzPIYzGhJmhzUlKfeIQvc+6rdw/9qMOynQBJa5R3Z5fcOH33W5jWG8V8dclVH0bI19fAIP45j+ckTRKHyohqiJG6ipMd8kjlmJuLXQs8Dc+GoxdRGK7u/h2uhk0LzxwcWMzBvf74GTUKHMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+LEolSY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436341f575fso25554245e9.1;
        Fri, 10 Jan 2025 10:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736533861; x=1737138661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L3NNGm+cwpNyKdKKPrgpwBzI7FF+ZnhEVJTGU5fbLV4=;
        b=C+LEolSYU8HsKEAv00fQO41jJuY8Aeo5Fs3qPkj7/dYcFTYa/LLS/wZz6+y3EfSENw
         QZ4rq5hfRDU5/x+xlUCNPdwK8SIIQfhyOHMIT3+MgXqOmsh5beUa6ThVEebuVgJg5JTT
         VfDi3UYPIkADEJ6kdrCPthEttvFXWOOfrcIrqiVRKOKyXa1LwTqaA335nmXiZ5ll1m+W
         hfm0T4tWHZuu4+WrHqGhfgs8fR8/VP8X7pD1OIxcYUrogen8mN3gSEqJ8E+GaQ1+Riq4
         u9sfLyqSBMT9avz6csbOfDNEFXYJPGXo0coTejzEjM2y6b7g1ZzNWun/z6jJVUhrLFl5
         LZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736533861; x=1737138661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3NNGm+cwpNyKdKKPrgpwBzI7FF+ZnhEVJTGU5fbLV4=;
        b=RFQAozjyPIZJA7VV00KgoM82yD6KQIxZEv001gXXCk/782Xn7A4x2D00OnvcFOBUtP
         29sdmM6r+o86wCy1iBtP6aEMGTcQFIn4omB2p73HxnzAbOd3yDKHHy2FmWAeCN8mZFKq
         Nsatvl6Li1cvUCw4WPFLOYBD5+ujzuT5cOnYwDVLjNj+RbbiL34IXTukJt6pSzgd8ktH
         gVzhnZD8C2MfIks+RMJzYWpY/UHTZQ0j9okZ+Z0+PlP5ulMOz/q30qUjZuOQCZDGQ3cd
         VuPxBrhbx7rMVUyONWrrLQvv1KoH6ajMRjYbQ5RaH0uTVh+7CX9Hiq+M5Tl2AcekHqIr
         U1kA==
X-Forwarded-Encrypted: i=1; AJvYcCV7UAWRukMdYhzB2d2CGnfrS9qqfo9RzbDABA7VDUhMiCk+tAhjw4E0AiLpVRkasZr0e2nIB0/FrsvMe/s=@vger.kernel.org, AJvYcCWZCCdxHU18YFjEEf+JPhnoviBDLrL0G/osEkAWA6UvMYQmwMezhzpSnFtL1X2/iI3r37Tdo4wo@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8PA3lp+sqP0A+H1RlF7xJRAlpjyPRuN0j4oxwnM2AytPH6C//
	Lr890XilRUPlxAUpE79v5AejqzobvhZlyHExnkttHndDQphxMxas
X-Gm-Gg: ASbGncuY8ir+2z2wASqIQm9Oq3jbkny7TLuiOa1SsLWQPUrJqN2M/lyz5Q9KlYonVUc
	vgWHZjR75DtbsAuAvP7Bb7IsHcxEBwW7DlVLOJqQp4xaqQzGHJ9FaUH9aPXwRKnZ0abs+Tp1ntw
	SlP8i3PyWQsSz02hbqtNZIYODsJIZ+IFtSRM9w/hmkL+o8AqKNqcrLLY/DL/PKtlo9ikyZaYZcH
	7Yu+QYltbHMiVInsciD/3paFeX6ufBNaLbxwEF5CTz/AWKjoJaJ
X-Google-Smtp-Source: AGHT+IFoZGL7UdlDDG1RzlDfcxYnTSDSK5yPlwqLxe50qQsTv6c9NUhftzOuA7tgUcwWNKuURwOohg==
X-Received: by 2002:a05:600c:a09:b0:434:f753:6012 with SMTP id 5b1f17b1804b1-436e26aa593mr124003965e9.17.1736533861280;
        Fri, 10 Jan 2025 10:31:01 -0800 (PST)
Received: from debian ([2a00:79c0:6a1:e700:303:6c5b:4b07:6715])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e03f49sm58950155e9.19.2025.01.10.10.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 10:31:00 -0800 (PST)
Date: Fri, 10 Jan 2025 19:30:58 +0100
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
Subject: Re: [PATCH] net: phy: marvell-88q2xxx: Add support for PHY LEDs on
 88q2xxx
Message-ID: <20250110183058.GA208903@debian>
References: <20250110-marvell-88q2xxx-leds-v1-1-22e7734941c2@gmail.com>
 <Z4FYjw596FQE4RMP@eichest-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4FYjw596FQE4RMP@eichest-laptop>

Hi Stefan,

Am Fri, Jan 10, 2025 at 06:27:43PM +0100 schrieb Stefan Eichenberger:
> Hi Dimitri ,
> 
> On Fri, Jan 10, 2025 at 04:10:04PM +0100, Dimitri Fedrau wrote:
> > Marvell 88Q2XXX devices support up to two configurable Light Emitting
> > Diode (LED). Add minimal LED controller driver supporting the most common
> > uses with the 'netdev' trigger.
> > 
> > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > ---
> >  drivers/net/phy/marvell-88q2xxx.c | 161 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 161 insertions(+)
> > 
> > diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
> > index 5107f58338aff4ed6cfea4d91e37282d9bb60ba5..bef3357b9d279fca5d1f86ff0eaa0d45a699e3f9 100644
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
> > @@ -40,6 +44,15 @@
> >  #define MDIO_MMD_PCS_MV_GPIO_INT_CTRL			32787
> >  #define MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS		0x0800
> >  
> > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL			32790
> > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_GPIO_MASK		GENMASK(7, 4)
> > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX_EN_MASK	GENMASK(3, 0)
> > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK		0x0 /* Link established */
> > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_RX_TX	0x1 /* Link established, blink for rx or tx activity */
> > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_RX_TX		0x4 /* Receive or Transmit activity */
> > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX		0x5 /* Transmit activity */
> > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_1000BT1	0x7 /* 1000BT1 link established */
> > +
> >  #define MDIO_MMD_PCS_MV_TEMP_SENSOR1			32833
> >  #define MDIO_MMD_PCS_MV_TEMP_SENSOR1_RAW_INT		0x0001
> >  #define MDIO_MMD_PCS_MV_TEMP_SENSOR1_INT		0x0040
> > @@ -95,6 +108,9 @@
> >  
> >  #define MDIO_MMD_PCS_MV_TDR_OFF_CUTOFF			65246
> >  
> > +#define MV88Q2XXX_LED_INDEX_TX_ENABLE	0
> > +#define MV88Q2XXX_LED_INDEX_GPIO	1
> 
> Not sure if I understand this. TX_ENABLE would be LED0 and GPIO would be
> LED1? In my datasheet the 88Q222x only has a GPIO pin (which is also
> TX_ENABLE), is this a problem? Would we need a led_count variable per
> chip? 
> 
Yes you understand it correctly.
Looking at the datasheets for 88Q212x, 88Q211x and 88Q222x, they have all
TX_ENABLE and GPIO pin. Registers are also the same. Did I miss anything ?
For which device GPIO pin and TX_ENABLE are the same ?

> In the 88Q2110 I can see that there is a TX_ENABLE (0) and a GPIO (1)
> pin. In the register description they just call it LED [0] Control and
> LED [1] Control. Maybe calling it LED_0 and LED_1 would be easier to
> understand? Same for MDIO_MMD_PCS_MV_LED_FUNC_CTRL_GPIO_MASK and
> MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX_EN_MASK.
> 
I named them just as the pin. Probably it would be easier to understand,
but the mapping between pin and index would be lost. What do you think ?

> > +
> >  struct mmd_val {
> >  	int devad;
> >  	u32 regnum;
> > @@ -741,8 +757,58 @@ static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
> >  }
> >  #endif
> >  
> > +#if IS_ENABLED(CONFIG_OF_MDIO)
> > +static int mv88q2xxx_leds_probe(struct phy_device *phydev)
> > +{
> > +	struct device_node *node = phydev->mdio.dev.of_node;
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
> > +			ret = phy_clear_bits_mmd(phydev, MDIO_MMD_PCS,
> > +						 MDIO_MMD_PCS_MV_RESET_CTRL,
> > +						 MDIO_MMD_PCS_MV_RESET_CTRL_TX_DISABLE);
> 
> If I understand it correctly, this switches the function of the pin from
> TX_DISABLE to GPIO? Can you maybe add a comment here?
>
You are right, will add the comment.

Best regards,
Dimitri Fedrau

