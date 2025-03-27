Return-Path: <netdev+bounces-177925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2835A72EFE
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 12:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2F3C189C266
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 11:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8C1212B00;
	Thu, 27 Mar 2025 11:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUMsxmSw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1E019D88F;
	Thu, 27 Mar 2025 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743074690; cv=none; b=nZa+1E4TjQWi9WFwwmEnHfTGxHZqL+hDzEkr0bI5jVmmqPeUz886wLLuOIr78EIUAGagAADRF3PO1jLNRreJtjSY5Og/Q9rkeGm04D3ASe9FfOgZMGFiqosc9/fZc1tGk7MKVetSKlst/pFJ9hu2jdtvKModvWJIaVY1kLlGMN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743074690; c=relaxed/simple;
	bh=9vHCXQb60UYSWMuIwkUwNBBk1SD10XtmRQu83JxRez0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRdKpFgXT9MzuJUH1Qva3GL/ud0HIjMGkccG5+dQ+spj6aWksI+0DPjYhEPIKO8n4z0M1Q3V0vensWFuE5s3cP6s/XF9FRNKeQcA2DrAXjxICYA48ehl6QGNzGAfCb1P48rqftaDyaLqJRL+WDgJJ+Uh2k284nPLx97XXuBHWHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUMsxmSw; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso1278621f8f.1;
        Thu, 27 Mar 2025 04:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743074687; x=1743679487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r9uAUUnPvZxGPnm1O0BCAGuy1dtOvt8b3tdG1/p4Uso=;
        b=YUMsxmSwsXM2BrzDlXtsujaVs8/Ky4VjKAwSwjmXtgYHZBBbVbbmgK9+X9aV74Y1X/
         AlIeLyePBDSuRieVVqQFJJlXtcejhvctdVH4bE4HC7ysMZv4zqABNBkhaeFPVXmIrg1+
         RAnCXHkHYYzPsgmdE62mVBoQs+cW+ZMaQ9pA6l28LfVa8+5R+Y9RmyqJqfdYsQdmb7tv
         uOhTKHiPGYG3H5LNPWgI4ZaVSxLOiblGvdMupZCwQgF37ZSdEmdR6JPXdyCXAC5af6zN
         ePg5Rn4xtlXovyWGaLa7QYt7WlJ3URv5QPvOYIwZ6kn7p0rdQkpGW516nXZufZo8/2Q+
         VEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743074687; x=1743679487;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9uAUUnPvZxGPnm1O0BCAGuy1dtOvt8b3tdG1/p4Uso=;
        b=fipF+RgSBSX2Kl8nvfFIjC7kNBq/7fjbFjyP3cMNHjQRa2soY9AjeJU9RFgj65/Xzd
         J1/Ey9zc7CzqmDu85TasfecFT1wHHjq5Ia6knipWKy1tVPpGF9fu6xaHB+HzisYrx0/U
         46XGdMc4ugImVBBpJHXieFi7cDtZBJ/KhNvoLDqfeAI096dLKyCt9Su/cD/yIfrjqWO/
         2lX1g9st8+KWGhLFdTrktD6UWLDK8H2murWWLmpRnP8UA9QuwtHNVmaWfPq6Jm3u0Rs0
         pmFKXH7o9BdrDG31D9w2rKr3qRpdUD5LLAt0vwtYlhSBjsYOtMpHDW/8MVVMpn20H8Wx
         WlfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNEbT3uNjpFUAiVHyaOyeVXMCelAmKLd7CguOCuAaxGPveoJz0wQb65qjYO4z2woOTG8Gu3Hy7VO3AQKoa@vger.kernel.org, AJvYcCUyIJoa7Vkjwdv4GRbuzfx47/1VZAiiQNBN+Dq3yhARHu/7JrDBypdxA7sRkgsWie5f9v2jC2pxoHWr@vger.kernel.org, AJvYcCV0k5V51gYYsRZ9lljltpHiR7xHwXptANVniGPf3ja/AZp/PevNp6k2dCAcQTgbL+LfOox8m8FS@vger.kernel.org
X-Gm-Message-State: AOJu0YxxfWDBL3dkBHJ1CdjJOFtxGBtQLA5yM5LG61gQoN0YtLKQG6L2
	+9nIWpvfdIj1LEoFbf3Is+SqbTufFkq9vBFMpr9XEQWoih9wEliq
X-Gm-Gg: ASbGncu7XLID4Usay+oEoJoYR3iQ2AVSE/O2JN5R4N5oAFOSPh7SuvU0udlO0I9iCHM
	+HIoLM74SJ8W1KWZbg5h70pDSEkECDsjL/VClT0Y6Ry54+I7U/0agC4nq5sq5WnwLHXyr94eWfD
	c1/BfHWMgLGvgDoDbeZYUja4xzUGzMWyNhdr5sh0AnvBg4wx+jgxHNQm77Vled4HvQyJJuMUpKz
	o5+MUkFi+Sy0QhIzCx4IU6bvTQp3Q098OaRIvZMDwncEnFj9S+6H9xaaahYgMQR/iTVZd/eTtZP
	lW3xF5kLe4ugzzqeWuoFdRJbSjE7m4fmTYroiKv+/TNw1MtArD3/V0xdua//Qpv6yw7cVVWqozQ
	N
X-Google-Smtp-Source: AGHT+IFLCphW5U7zd6c6SZfMhpK/aclXKGbAvS2gd0lfAQCxn3O3FLYOmoElgv4cGprAKQTjQsCX6w==
X-Received: by 2002:a5d:64eb:0:b0:390:e9ee:f27a with SMTP id ffacd0b85a97d-39ad15234edmr3000901f8f.28.1743074686734;
        Thu, 27 Mar 2025 04:24:46 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39ac8745d9csm7858640f8f.95.2025.03.27.04.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 04:24:46 -0700 (PDT)
Message-ID: <67e5357e.df0a0220.14c972.64ad@mx.google.com>
X-Google-Original-Message-ID: <Z-UuvuUlCmPvvpKf@Ansuel-XPS.>
Date: Thu, 27 Mar 2025 12:24:44 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v3 3/4] net: phy: Add support for Aeonsemi
 AS21xxx PHYs
References: <20250326233512.17153-1-ansuelsmth@gmail.com>
 <20250326233512.17153-4-ansuelsmth@gmail.com>
 <20250327092418.78f55466@fedora-2.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327092418.78f55466@fedora-2.home>

On Thu, Mar 27, 2025 at 09:24:18AM +0100, Maxime Chevallier wrote:
> Hi Christian,
> 
> On Thu, 27 Mar 2025 00:35:03 +0100
> Christian Marangi <ansuelsmth@gmail.com> wrote:
> 
> > Add support for Aeonsemi AS21xxx 10G C45 PHYs. These PHYs integrate
> > an IPC to setup some configuration and require special handling to
> > sync with the parity bit. The parity bit is a way the IPC use to
> > follow correct order of command sent.
> > 
> > Supported PHYs AS21011JB1, AS21011PB1, AS21010JB1, AS21010PB1,
> > AS21511JB1, AS21511PB1, AS21510JB1, AS21510PB1, AS21210JB1,
> > AS21210PB1 that all register with the PHY ID 0x7500 0x7510
> > before the firmware is loaded.
> > 
> > They all support up to 5 LEDs with various HW mode supported.
> > 
> > While implementing it was found some strange coincidence with using the
> > same logic for implementing C22 in MMD regs in Broadcom PHYs.
> > 
> > For reference here the AS21xxx PHY name logic:
> > 
> > AS21x1xxB1
> >     ^ ^^
> >     | |J: Supports SyncE/PTP
> >     | |P: No SyncE/PTP support
> >     | 1: Supports 2nd Serdes
> >     | 2: Not 2nd Serdes support
> >     0: 10G, 5G, 2.5G
> >     5: 5G, 2.5G
> >     2: 2.5G
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 	
>  [...]
> 
> I know this is only RFC, but I have some questions
> 
> > +static int as21xxx_match_phy_device(struct phy_device *phydev,
> > +				    const struct phy_driver *phydrv)
> > +{
> > +	struct as21xxx_priv *priv;
> > +	u32 phy_id;
> > +	int ret;
> > +
> > +	/* Skip PHY that are not AS21xxx or already have firmware loaded */
> > +	if (phydev->c45_ids.device_ids[MDIO_MMD_PCS] != PHY_ID_AS21XXX)
> > +		return phydev->phy_id == phydrv->phy_id;
> > +
> > +	/* Read PHY ID to handle firmware just loaded */
> > +	ret = phy_read_mmd(phydev, MDIO_MMD_PCS, MII_PHYSID1);
> > +	if (ret < 0)
> > +		return ret;
> > +	phy_id = ret << 16;
> > +
> > +	ret = phy_read_mmd(phydev, MDIO_MMD_PCS, MII_PHYSID2);
> > +	if (ret < 0)
> > +		return ret;	
> > +	phy_id |= ret;
> > +
> > +	/* With PHY ID not the generic AS21xxx one assume
> > +	 * the firmware just loaded
> > +	 */
> > +	if (phy_id != PHY_ID_AS21XXX)
> > +		return phy_id == phydrv->phy_id;
> > +
> > +	/* Allocate temp priv and load the firmware */
> > +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	mutex_init(&priv->ipc_lock);
> > +
> > +	ret = aeon_firmware_load(phydev);
> > +	if (ret)
> > +		return ret;
> 
> Here, and below, you leak priv by returning early.
>

Yes copy paste error with migrating from devm to non-devmem.

> > +
> > +	ret = aeon_ipc_sync_parity(phydev, priv);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Enable PTP clk if not already Enabled */
> > +	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PTP_CLK,
> > +			       VEND1_PTP_CLK_EN);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = aeon_dpc_ra_enable(phydev, priv);
> > +	if (ret)
> > +		return ret;
> 
> Does all of the above with sync_parity, PTP clock cfg and so on needs
> to be done in this first pass of the matching process for this PHY ?
> 
> From what I got from the discussions, the only important bit is to load
> the FW to get the correct PHY id ?
> 

I will do further check on this. Waiting for the sync parity have the
side effect of waiting for the firmware to finish loading.

> > +	mutex_destroy(&priv->ipc_lock);
> > +	kfree(priv);
> > +
> > +	/* Return not maching anyway as PHY ID will change after
> > +	 * firmware is loaded.
> > +	 */
> > +	return 0;
> > +}
> 
> Maxime

-- 
	Ansuel

