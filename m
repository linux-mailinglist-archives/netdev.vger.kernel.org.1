Return-Path: <netdev+bounces-157622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FBDA0B07C
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84116165F83
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 08:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F92231CB9;
	Mon, 13 Jan 2025 08:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGeROT6T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667E83C1F;
	Mon, 13 Jan 2025 08:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736755527; cv=none; b=CmTxdBMbcE0R5RduhkITS4GhQIijyD43XckutEYOmTTNEjNFUt7T4rjHdVLhU7F0Yz68/rsmH83tZLK1MYxTUwUTXB1oAlmptRzfMMFswdSJwdkM0O6WrEKYzGGehpKu79Sw+cMk0BmuObST9k1OMt8ht8352ztN7Q8ZuOtox5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736755527; c=relaxed/simple;
	bh=nSXak/o9xZoZKmtCzqjYTadfTrNAh/ghXphoJiaU1No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWW26uANz/sJmhD7F0znfg2IO5u/4tXNdT/+Qq84821IwOufLyQh7eCF/eMpqu1kY7ReXpGBe+GcGvj6IuUXZBojWc6fcEc1tK1rp7AXDt0fxUbyvCVcEbhgcQW2gLrthbz1iRjNFS5yYfyx361vtC3FYFhVln2V1MX0Vw1oaxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGeROT6T; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385dece873cso1891505f8f.0;
        Mon, 13 Jan 2025 00:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736755524; x=1737360324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/KMj101DNBN+joaD4kWwCkvCG1/KgOEjYa6KLLnGnmc=;
        b=dGeROT6TNq1hyBxBA1NCZRW23tFp06cjhvq5IgWd+gLFIG/tyJR5amrzyFweqKrvuM
         sShUDWXZTHq966GnMU2WSGmrffPXyqo1COc776XoS01ZJWkSoP5xg8EUU+j8/t1313DG
         ZvbUi+1qVMuIOgqEzRT6rqRxDC3eK6waFcGKX5u+H73f92iQlAbRqQlIxo4ffiwVScdF
         KZJ2QxL8th2qp+96di1MlVM3BM0q7UIf+QnHGYuPASVcKLXpGMHhfBNXXZdwnP6G8doB
         Mvlw9IxvgyJghh2kOAXaoj9xR5gefaBcYidwOXTzHbjACg1B3T8ROojUbhuRmLoqfAmg
         iHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736755524; x=1737360324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KMj101DNBN+joaD4kWwCkvCG1/KgOEjYa6KLLnGnmc=;
        b=iBHumF5nqRBMg55VJeosT4PRDq7O9Q8/2iBo0+EELF0vNkkEldD+eZlXHh5Y04/Y3p
         A/+3uxUFJy6Kw4J+n1fnsvfaoLlG5Z7UK2SUFOKJzBXgYC/iIHf3f7skC45dweqoODwn
         lon8jaFRzR8ZhRL4DACnzbKr83QoE2DMnA7h1vflL5bAl62WjBth7ltqtMCNS7OHr3fy
         CC51VgndP0ZJzMu1zp1uwzj7bdI+FX4dXVV/wHAT/NeRFFuGOWSLj58nPZuSshgPCu4z
         6vpFjpbzdLfUDLvGbeKfhH184TComarAN1IIPsKhfTbJp3W6vpe4rF3H6fDIOyHJAd2e
         99+A==
X-Forwarded-Encrypted: i=1; AJvYcCVKGwm5wOIg0+LOBbpATCjpBCs9QyIpgbpy75gyaUyDwBtJDQnEfBfYKvZZCa1hHmsAyGzEK4jTS7QOHUo=@vger.kernel.org, AJvYcCWyNrElWCCWd2AVTIHIYbro82mTvapfeQukQkR+ylktffZ9sGr50zz3WayagBCDgQ2uhTt2Iy5T@vger.kernel.org
X-Gm-Message-State: AOJu0YxO6VAbk05/+A1jLKqzhVc9idW4xWOfDvOFnyQjAdVQO0BfD8FI
	OtmNAVVok6dLL0x1FKBWnMbMlwmPiWVZ+hqm87O0D1/JLqh7JScy
X-Gm-Gg: ASbGnctyiS7zrmxfj7IH/QEfu/oAod55iD6+2yXH62KXgqoiUVNat8gd6TmiEKEu1hb
	Z5/gGthVotWJIXqk8pbW6w+XIcWhml3zBts8FSLWtBdUOoT4ldR3ZbYieDholM1NiVu1NNd1/AP
	EgH2saCwao3/fF0UiEke/PxKopxfL5eO+EhvGuTsFABsSooLkkUzHfw5A6QraFVUuB3uWsrPkkm
	TiXLoGfdrE7XrLTFXUqQ4DLWTfU2A9ThAbwftwPJ0A6cOhS6ufqbIYk
X-Google-Smtp-Source: AGHT+IEHS50BSFFmRg7mgcmrBYvLFucS4wGm19oollRoDc5VgYes/e7yaE5v4Kl6BGlsxDPD7NIGCg==
X-Received: by 2002:a05:6000:709:b0:386:3803:bbd5 with SMTP id ffacd0b85a97d-38a8733a1f9mr18622260f8f.45.1736755523638;
        Mon, 13 Jan 2025 00:05:23 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:a5a1:302a:fcf7:c337])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1b2asm11193969f8f.89.2025.01.13.00.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 00:05:23 -0800 (PST)
Date: Mon, 13 Jan 2025 09:05:21 +0100
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
Message-ID: <Z4TJQSPlA_s6lbkS@eichest-laptop>
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
> > In the 88Q2110 I can see that there is a TX_ENABLE (0) and a GPIO (1)
> > pin. In the register description they just call it LED [0] Control and
> > LED [1] Control. Maybe calling it LED_0 and LED_1 would be easier to
> > understand? Same for MDIO_MMD_PCS_MV_LED_FUNC_CTRL_GPIO_MASK and
> > MDIO_MMD_PCS_MV_LED_FUNC_CTRL_TX_EN_MASK.
> > 
> I named them just as the pin. Probably it would be easier to understand,
> but the mapping between pin and index would be lost. What do you think ?

I missed this one in the previous mail, sorry. I personally would name
it LED_0_CONTROL_MASK and LED_1_CONTROL_MASK because the description of
the register is "3:0 LED [0] Control". As index I would probably also
call it LED_0_INDEX and LED_1_INDEX because it is not directly related
to the pin functionality. But that's just my personal preference not
sure if it is really better.

Regards,
Stefan

