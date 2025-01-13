Return-Path: <netdev+bounces-157695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8CAA0B36C
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 10:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B30F16B3D5
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F1D21ADA7;
	Mon, 13 Jan 2025 09:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpthOH8u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6132045B3;
	Mon, 13 Jan 2025 09:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736761117; cv=none; b=AJwQXuVpGJJWweyXQA2l0sL9MxHwAlZ6xVHEhyEz++bjLm45Pct9I/wwtiupzvFfk3gwOS0gr+aTg6XHrPug3w+m+6hF3ftUvnD7mHXLkdGa5PMLDfeq0MZWU7Llwf7ocpIpx7jErYe2h6So4eaDcLaoGCT9PuIIgvN+iEY2Ews=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736761117; c=relaxed/simple;
	bh=Z2OMjcIxwEhP2U4EWthhvI1XW+Gw5Ot6ddzpmXLn0To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqDkFF3BJOqQ1p8+sptMXgYRMhZQHmY5hmKUfw4eoEMM2+KIVUXO1n7TVNWsCIW3i5V1Ykf69iYYb4uIN7aJg4xjnLVaf8BWBBTm7lZXqQHhi1aDLppnWQ55hWZonkASvlqGifbrfipYYNaSx87EtEF1p+SkgW8jLfAuBTtNjW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpthOH8u; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43690d4605dso27831115e9.0;
        Mon, 13 Jan 2025 01:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736761114; x=1737365914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mx1RgwuAdwMJe+z4twBjTZgnbFU46GyeTVBmJBTi2lg=;
        b=hpthOH8uRCRCWoqzRybhgks0jGPv3bA06+ix4rRB4kIfijuum0sGMOfD2zaC5wvQ14
         8AiVOk5LfFAReQN5B/muDSJUh/nU3I9TS2jhumKX4d7fkK3hJhCtEhTeCp1WCuY5WgsN
         vrjp8DQnjc82nHceSSoFCDS5coBgGeef9amEmU+tfx7ISTOxSQ1L1pE+fY39zuenEdgR
         w9D6MgQB99Bh/I4m0S332T4CFcsRgsAMBtZO8FPTZYGmfcKHHFxA8gXTfNElRnr+P15M
         LnRgIGkNmhl5FiakHtkGSvMpqt7FBW1x/hDHXEd83K5B8J9ZkUwwT70rEqqab5FqNcZF
         pAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736761114; x=1737365914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mx1RgwuAdwMJe+z4twBjTZgnbFU46GyeTVBmJBTi2lg=;
        b=blSZvch2whI16xiVXVDUIjM0jHwdsGIMACJUVHoWPTvOxMmgk7B8piOnHrHB67n8qq
         1zFtxJcgzcNHMg7iCRwaeAZAOrDO7sU0NCYJTifxo1w4qkbBpyb6k7p/+4PoLRynbXsi
         ju1wa8iJWsasyChpIqkHzEI+MFPLd3fzY4ogxGKZMUgHgNwNotylb4uor8H3PCppQUCk
         cUZ5hud3lmyOWiTHo4HGp1dWUPmfn/e/FI920g/nEX1VGby0+U2o6XmXvkh+iUIvOXRz
         O/HX1GdPsSnz0cbt7uF4YCS39BpBV+GaeQXKnL9PgEYwGQYX2aYzoCjrTisCp+wG1IN3
         CeIA==
X-Forwarded-Encrypted: i=1; AJvYcCUae01SyqGvlg7VXFllKDaek6ELInX21ZTtBOhek+gOKGPbhCJIH7IebZ+Lhz4E5vwwzj3b/6TQjdjnp7Y=@vger.kernel.org, AJvYcCXLpgGzVZ+2Y+Fzr3CqKoXBIFOBW3p6fFHDKV+GNGdszrSNnQZ2aLYAG2GoYGbQjaRFWbw+rcDt@vger.kernel.org
X-Gm-Message-State: AOJu0YyP3C46TrOsQ5BhI23Qoq+BMryxWm5FR2PxCJY5mdZjtV33O92a
	kjAGCZcwtoBo1uqAWQm+EZHh+4dHJ8TS91CbBUQVk7xcnfeVsYe0
X-Gm-Gg: ASbGncu6Q7+ZL3m3V7pj4Pd9Z/NH7dkGgm/3gAd4SESGwBABZeSYn+uFcPTQErO8nTq
	mtjUnERSlB2xkYTY1/bYqJ6KuCIianbBlGPv8CUNr/XWP5NvE6i+GC4lBPiOXbPY427OarWB2AS
	WYh+RtlUC0Yiq0ixvpugN8RIocFbD32iVPp/DUnbls+8WnDJPfPXeeKE3j/euhxhTmpPmbwBkHm
	nwQ1whKASHQ0rk7GRR5lVb0APMsYRxt/4uYW/rGmIcHHJzP9WZQSbwQ
X-Google-Smtp-Source: AGHT+IEJHM0zF/Rk+qnPrsAXxIQ+5GZM7txyoPF0F4gi0RErxmH5LXWiki04ERA8W4GAi1R4xGKyrw==
X-Received: by 2002:a05:600c:314b:b0:436:5fc9:30ba with SMTP id 5b1f17b1804b1-436e26ebb6fmr65636775e9.29.1736761113606;
        Mon, 13 Jan 2025 01:38:33 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:a5a1:302a:fcf7:c337])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a9362947dsm10177233f8f.40.2025.01.13.01.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 01:38:33 -0800 (PST)
Date: Mon, 13 Jan 2025 10:38:31 +0100
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
Message-ID: <Z4TfF8as1Pxdr6Ve@eichest-laptop>
References: <20250110-marvell-88q2xxx-leds-v1-1-22e7734941c2@gmail.com>
 <Z4FYjw596FQE4RMP@eichest-laptop>
 <20250110183058.GA208903@debian>
 <Z4TJQSPlA_s6lbkS@eichest-laptop>
 <20250113092524.GB4290@debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113092524.GB4290@debian>

Hi Dimitri,

On Mon, Jan 13, 2025 at 10:25:24AM +0100, Dimitri Fedrau wrote:
> Hi Stefan,
> 
> Am Mon, Jan 13, 2025 at 09:05:21AM +0100 schrieb Stefan Eichenberger:
> > On Fri, Jan 10, 2025 at 07:30:58PM +0100, Dimitri Fedrau wrote:
> > > Hi Stefan,
> > > 
> > > Am Fri, Jan 10, 2025 at 06:27:43PM +0100 schrieb Stefan Eichenberger:
> > > > Hi Dimitri ,
> > > > 
> > > > On Fri, Jan 10, 2025 at 04:10:04PM +0100, Dimitri Fedrau wrote:
> > > > > Marvell 88Q2XXX devices support up to two configurable Light Emitting
> > > > > Diode (LED). Add minimal LED controller driver supporting the most common
> > > > > uses with the 'netdev' trigger.
> > > > > 
> > > > > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > > > > ---
> > > > >  drivers/net/phy/marvell-88q2xxx.c | 161 ++++++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 161 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
> > > > > index 5107f58338aff4ed6cfea4d91e37282d9bb60ba5..bef3357b9d279fca5d1f86ff0eaa0d45a699e3f9 100644
> > > > > --- a/drivers/net/phy/marvell-88q2xxx.c
> > > > > +++ b/drivers/net/phy/marvell-88q2xxx.c
> > > > > @@ -8,6 +8,7 @@
> > > > >   */
> > > > >  #include <linux/ethtool_netlink.h>
> > > > >  #include <linux/marvell_phy.h>
> > > > > +#include <linux/of.h>
> > > > >  #include <linux/phy.h>
> > > > >  #include <linux/hwmon.h>
> > > > >  
> > > > > @@ -27,6 +28,9 @@
> > > > >  #define MDIO_MMD_AN_MV_STAT2_100BT1		0x2000
> > > > >  #define MDIO_MMD_AN_MV_STAT2_1000BT1		0x4000
> > > > >  
> > > > > +#define MDIO_MMD_PCS_MV_RESET_CTRL		32768
> > > > > +#define MDIO_MMD_PCS_MV_RESET_CTRL_TX_DISABLE	0x8
> > > > > +
> > > > >  #define MDIO_MMD_PCS_MV_INT_EN			32784
> > > > >  #define MDIO_MMD_PCS_MV_INT_EN_LINK_UP		0x0040
> > > > >  #define MDIO_MMD_PCS_MV_INT_EN_LINK_DOWN	0x0080
> > > > > @@ -40,6 +44,15 @@
> > > > >  #define MDIO_MMD_PCS_MV_GPIO_INT_CTRL			32787
> > > > >  #define MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS		0x0800
> > > > >  
> > > > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL			32790
> > > > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_GPIO_MASK		GENMASK(7, 4)
> > > > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX_EN_MASK	GENMASK(3, 0)
> > > > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK		0x0 /* Link established */
> > > > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_RX_TX	0x1 /* Link established, blink for rx or tx activity */
> > > > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_RX_TX		0x4 /* Receive or Transmit activity */
> > > > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX		0x5 /* Transmit activity */
> > > > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_1000BT1	0x7 /* 1000BT1 link established */
> > > > > +
> > > > >  #define MDIO_MMD_PCS_MV_TEMP_SENSOR1			32833
> > > > >  #define MDIO_MMD_PCS_MV_TEMP_SENSOR1_RAW_INT		0x0001
> > > > >  #define MDIO_MMD_PCS_MV_TEMP_SENSOR1_INT		0x0040
> > > > > @@ -95,6 +108,9 @@
> > > > >  
> > > > >  #define MDIO_MMD_PCS_MV_TDR_OFF_CUTOFF			65246
> > > > >  
> > > > > +#define MV88Q2XXX_LED_INDEX_TX_ENABLE	0
> > > > > +#define MV88Q2XXX_LED_INDEX_GPIO	1
> > > > 
> > > > Not sure if I understand this. TX_ENABLE would be LED0 and GPIO would be
> > > > LED1? In my datasheet the 88Q222x only has a GPIO pin (which is also
> > > > TX_ENABLE), is this a problem? Would we need a led_count variable per
> > > > chip? 
> > > > 
> > > Yes you understand it correctly.
> > > Looking at the datasheets for 88Q212x, 88Q211x and 88Q222x, they have all
> > > TX_ENABLE and GPIO pin. Registers are also the same. Did I miss anything ?
> > > For which device GPIO pin and TX_ENABLE are the same ?
> > > 
> > > > In the 88Q2110 I can see that there is a TX_ENABLE (0) and a GPIO (1)
> > > > pin. In the register description they just call it LED [0] Control and
> > > > LED [1] Control. Maybe calling it LED_0 and LED_1 would be easier to
> > > > understand? Same for MDIO_MMD_PCS_MV_LED_FUNC_CTRL_GPIO_MASK and
> > > > MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX_EN_MASK.
> > > > 
> > > I named them just as the pin. Probably it would be easier to understand,
> > > but the mapping between pin and index would be lost. What do you think ?
> > 
> > I missed this one in the previous mail, sorry. I personally would name
> > it LED_0_CONTROL_MASK and LED_1_CONTROL_MASK because the description of
> > the register is "3:0 LED [0] Control". As index I would probably also
> > call it LED_0_INDEX and LED_1_INDEX because it is not directly related
> > to the pin functionality. But that's just my personal preference not
> > sure if it is really better.
> >
> I think you are right, since the datasheet for 88Q222x is a bit messy
> and datasheets for 88Q212x and 88Q211x name them "LED [0] Control" and
> "LED [1] Control" I will do as you suggest. Thanks for pointing out.
> 
> I would stick to the index because you assign functionality when you
> configure DT to do so. How should one know which pins belongs to which led
> index, there is no documentation on this.

Perfect thanks, I agree with you on the index. If you can rename the
mask and add the comment as written in the previous mail, I'm happy with
the change.

Regards,
Stefan

