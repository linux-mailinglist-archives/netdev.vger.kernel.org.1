Return-Path: <netdev+bounces-157667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAC6A0B2AB
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 10:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274B41885DAF
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FF82397A0;
	Mon, 13 Jan 2025 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDqKew56"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C44022F19;
	Mon, 13 Jan 2025 09:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760330; cv=none; b=fE2yiO9HV5dhkPKv+NpadMU18t7lGjsl49173nipWqE8yhIZbTiSgY5JEhmL9/sbaEI6PU0Ejsru3aTKz/78tI2PkyQKbCxnvpVL18vXom0nHF5oU4Xp5JtVfaiaCuzIHtl58n26rxbK6v+Be+BE6KdgxXDqH2lGX+KNbV7TDwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760330; c=relaxed/simple;
	bh=yzqjGcECBwk2qE43hAZ1dkKoWmfTRxi6yO5BUV8HmOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zbyft/Gr9dl1XunZ8Aahl9bx/qsaUj1QhAmpWvUPSOPC74SA4tNZg3CCQtdaufdm8N3i9ZSqjc0n3bSFSgedMV7YbH9+yNS8qhnSoB8rFaixeyb6cosMRAywj+J4h2pvM8ujVUwgDsZlgZLfNpO50B2UTpGzDTiBFQ33XGZMJZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDqKew56; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso24508495e9.1;
        Mon, 13 Jan 2025 01:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736760327; x=1737365127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2OYmtAl30kQ/2nJJEP2ZBeiKHoYyxBa0D2RY41NXCGI=;
        b=SDqKew56mvlKH4a7tsSpxEOh1z6wocfIICc0BxlXzxmU5il4ib6brhb5AR7Iu4Dx/7
         GeBjmK7F+UJmvBgzW2UDhZSAmxE6aKUOUA7e+v0nHEvN/OLjuMA1kLcYJ1UK4HcUGKc9
         bI8iNreHHCOM/7Dzr47fDIrCVUgOgILyuMh9RQt0qWsJQdiI9n32xQ5n+4HtAEobu9nq
         bUq6H6GZ1e2yR8GwjgOeWXrviJ/WOh/16JmxSBd+u4LjrY/abqmJdJTbypenHG8Eeanj
         LedVWN35/A0JGAeZyAJf/NFP1GBFKL9AP1juvH0gEKhhEziTN4C2ZykvZqi77aHDR4xJ
         ffkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736760327; x=1737365127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OYmtAl30kQ/2nJJEP2ZBeiKHoYyxBa0D2RY41NXCGI=;
        b=fqD77FWz6Delz6m+noUkyr1cHAQOe9NldkbAwhW1lm0b24d7+sLNeZ6EgXaXcxQ0U9
         KT1wpSf/G+8EJnbCFmbUlEXQlGlYqq3M3wy7C0WTSxvpcP/BYVY+tWq2nSZaQQbu/bYP
         0J8Uk6dcZ5HI9+Hpm7ApZ4XT5Sct8ORduUrZBf6gqtF3oJsb/+aDNRljwprsFAsGKvap
         hWpUuGGOjgpc2HDGuZH1ZFqrkk3U4ap85mnFFjiwmYWlFVvs22at3ybIfMUw9stTwyNH
         hN1EBgNvJhknSOgxKQVGH6JuPejSyUCVvAo0crSC/jieEAEKkV82ORZFC+aLlP53A915
         Axww==
X-Forwarded-Encrypted: i=1; AJvYcCVeOkDkHcYb8f4s6wv6QC0XmQLNRBi0O/N2qMwh73xUYPNzYnIoMSPXBGV9Hr/7yqMpSIbZ9b9m@vger.kernel.org, AJvYcCVpcD9UKqmyCJN4kxuC/zavH+oVnxWuFXcvrW1iXVNqB6KWlNsYcbRyZeewbsp39YLSUmHdGvYQW3vy3Pk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6XxzFtMxeJQzhzzWOaoah6aeCKwnf87cMWhORUQcJ+iXv+GY/
	gAd5C3FOLr1bUUfiotUTYVW33dSG8gTZ2tYv5IXz02JvnAypRRUi
X-Gm-Gg: ASbGncu1YJB4C75KifGsUoKrB56mTElnzoIxhpnKMVoWS04SG72bSB7vWsiwuBFcuvF
	KDEvJ/11uD3WNuvUIGkO5ZBTOpF68FM6/9Tkf8YR5I0O2DiXQV1eskZ8/QhQEX8LKjyvy5wZzCM
	O8etH9reiYzs5AT2S0LlB7o59rNkZD6OAMKJoPG0bhF2zqgfzBc8d2dxFhCtW3iyhOjrYK13+BO
	4lFc6QBhQlkJz/eviVHDI91e2d8SrmVIyerFspjm4UjEGmTQgkwtg==
X-Google-Smtp-Source: AGHT+IFRjLLEqfDLhBDOZyeVa4XghBTKNTXetxj9EVY6FpAPofIIF5fOClCqsYh2rOhokjEe2MDqHA==
X-Received: by 2002:a7b:c40c:0:b0:436:2155:be54 with SMTP id 5b1f17b1804b1-436e880fcc0mr130172685e9.1.1736760326994;
        Mon, 13 Jan 2025 01:25:26 -0800 (PST)
Received: from debian ([2a00:79c0:620:b000:ad44:c8fd:4a6a:52bf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2df3610sm170917835e9.20.2025.01.13.01.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 01:25:26 -0800 (PST)
Date: Mon, 13 Jan 2025 10:25:24 +0100
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
Message-ID: <20250113092524.GB4290@debian>
References: <20250110-marvell-88q2xxx-leds-v1-1-22e7734941c2@gmail.com>
 <Z4FYjw596FQE4RMP@eichest-laptop>
 <20250110183058.GA208903@debian>
 <Z4TJQSPlA_s6lbkS@eichest-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4TJQSPlA_s6lbkS@eichest-laptop>

Hi Stefan,

Am Mon, Jan 13, 2025 at 09:05:21AM +0100 schrieb Stefan Eichenberger:
> On Fri, Jan 10, 2025 at 07:30:58PM +0100, Dimitri Fedrau wrote:
> > Hi Stefan,
> > 
> > Am Fri, Jan 10, 2025 at 06:27:43PM +0100 schrieb Stefan Eichenberger:
> > > Hi Dimitri ,
> > > 
> > > On Fri, Jan 10, 2025 at 04:10:04PM +0100, Dimitri Fedrau wrote:
> > > > Marvell 88Q2XXX devices support up to two configurable Light Emitting
> > > > Diode (LED). Add minimal LED controller driver supporting the most common
> > > > uses with the 'netdev' trigger.
> > > > 
> > > > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > > > ---
> > > >  drivers/net/phy/marvell-88q2xxx.c | 161 ++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 161 insertions(+)
> > > > 
> > > > diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
> > > > index 5107f58338aff4ed6cfea4d91e37282d9bb60ba5..bef3357b9d279fca5d1f86ff0eaa0d45a699e3f9 100644
> > > > --- a/drivers/net/phy/marvell-88q2xxx.c
> > > > +++ b/drivers/net/phy/marvell-88q2xxx.c
> > > > @@ -8,6 +8,7 @@
> > > >   */
> > > >  #include <linux/ethtool_netlink.h>
> > > >  #include <linux/marvell_phy.h>
> > > > +#include <linux/of.h>
> > > >  #include <linux/phy.h>
> > > >  #include <linux/hwmon.h>
> > > >  
> > > > @@ -27,6 +28,9 @@
> > > >  #define MDIO_MMD_AN_MV_STAT2_100BT1		0x2000
> > > >  #define MDIO_MMD_AN_MV_STAT2_1000BT1		0x4000
> > > >  
> > > > +#define MDIO_MMD_PCS_MV_RESET_CTRL		32768
> > > > +#define MDIO_MMD_PCS_MV_RESET_CTRL_TX_DISABLE	0x8
> > > > +
> > > >  #define MDIO_MMD_PCS_MV_INT_EN			32784
> > > >  #define MDIO_MMD_PCS_MV_INT_EN_LINK_UP		0x0040
> > > >  #define MDIO_MMD_PCS_MV_INT_EN_LINK_DOWN	0x0080
> > > > @@ -40,6 +44,15 @@
> > > >  #define MDIO_MMD_PCS_MV_GPIO_INT_CTRL			32787
> > > >  #define MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS		0x0800
> > > >  
> > > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL			32790
> > > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_GPIO_MASK		GENMASK(7, 4)
> > > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX_EN_MASK	GENMASK(3, 0)
> > > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK		0x0 /* Link established */
> > > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_RX_TX	0x1 /* Link established, blink for rx or tx activity */
> > > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_RX_TX		0x4 /* Receive or Transmit activity */
> > > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX		0x5 /* Transmit activity */
> > > > +#define MDIO_MMD_PCS_MV_LED_FUNC_CTRL_LINK_1000BT1	0x7 /* 1000BT1 link established */
> > > > +
> > > >  #define MDIO_MMD_PCS_MV_TEMP_SENSOR1			32833
> > > >  #define MDIO_MMD_PCS_MV_TEMP_SENSOR1_RAW_INT		0x0001
> > > >  #define MDIO_MMD_PCS_MV_TEMP_SENSOR1_INT		0x0040
> > > > @@ -95,6 +108,9 @@
> > > >  
> > > >  #define MDIO_MMD_PCS_MV_TDR_OFF_CUTOFF			65246
> > > >  
> > > > +#define MV88Q2XXX_LED_INDEX_TX_ENABLE	0
> > > > +#define MV88Q2XXX_LED_INDEX_GPIO	1
> > > 
> > > Not sure if I understand this. TX_ENABLE would be LED0 and GPIO would be
> > > LED1? In my datasheet the 88Q222x only has a GPIO pin (which is also
> > > TX_ENABLE), is this a problem? Would we need a led_count variable per
> > > chip? 
> > > 
> > Yes you understand it correctly.
> > Looking at the datasheets for 88Q212x, 88Q211x and 88Q222x, they have all
> > TX_ENABLE and GPIO pin. Registers are also the same. Did I miss anything ?
> > For which device GPIO pin and TX_ENABLE are the same ?
> > 
> > > In the 88Q2110 I can see that there is a TX_ENABLE (0) and a GPIO (1)
> > > pin. In the register description they just call it LED [0] Control and
> > > LED [1] Control. Maybe calling it LED_0 and LED_1 would be easier to
> > > understand? Same for MDIO_MMD_PCS_MV_LED_FUNC_CTRL_GPIO_MASK and
> > > MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX_EN_MASK.
> > > 
> > I named them just as the pin. Probably it would be easier to understand,
> > but the mapping between pin and index would be lost. What do you think ?
> 
> I missed this one in the previous mail, sorry. I personally would name
> it LED_0_CONTROL_MASK and LED_1_CONTROL_MASK because the description of
> the register is "3:0 LED [0] Control". As index I would probably also
> call it LED_0_INDEX and LED_1_INDEX because it is not directly related
> to the pin functionality. But that's just my personal preference not
> sure if it is really better.
>
I think you are right, since the datasheet for 88Q222x is a bit messy
and datasheets for 88Q212x and 88Q211x name them "LED [0] Control" and
"LED [1] Control" I will do as you suggest. Thanks for pointing out.

I would stick to the index because you assign functionality when you
configure DT to do so. How should one know which pins belongs to which led
index, there is no documentation on this.

Best regards,
Dimitri

