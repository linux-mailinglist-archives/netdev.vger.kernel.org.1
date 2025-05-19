Return-Path: <netdev+bounces-191557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4636ABC246
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 17:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40209165EDB
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 15:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A7526B093;
	Mon, 19 May 2025 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N44U+WMo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A922B9A6;
	Mon, 19 May 2025 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747667787; cv=none; b=b3jm6Q6/wXlf/DmXBzAFBC0X9SZFwlQ/Oieo1fm1oLHyyTF+/iyfNOC5AGXhGUxsDJPC4w+otBuDZIFplXmypdq8nhK2waKnCmVNVQGEu2EFaKFHFxmfCzJIZgnrHtsWlOWxKAgwuD7fuPjb/TBtoCxj1TD27lYll1iARxIq+rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747667787; c=relaxed/simple;
	bh=o5D8Duk+Vv3tA+KDzWYeXQ3WdzArCIIB2zu2hTvm1l4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBpoPoNFEo7w3LOXbXVIwJRJLijA20pKvx8efth7gd54b34F0yfgVTt8Dw+1A0DeIWJYeoevkVr2Bw9h/8N92Jqvf5N9pC4sGBx8s1lnPw4ZwZZSCRtTG8lo5qvSM/3Eho97DcqgQTXyo/zKOB065wpBbw9kFa6PY2CB1akVYAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N44U+WMo; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7082ad1355bso38509147b3.1;
        Mon, 19 May 2025 08:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747667785; x=1748272585; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5gaIJp7DEmiGONwa5iKv0yKiahtqfMYGddi7S5u0w9E=;
        b=N44U+WMoeSNl8wn7vLi3blNH/oE4zUealR185CZIe7heVT9wNrcDOo540rjOy4S4ox
         kMOfnjjSJ/PvMPxzTQm40tufws0a5BPoqgCUbR63BxMjSXHKak7V+NsIqysetsfJI/jM
         yyG8fOCGCdceEA1B5+FCAnZev5zMRVBhYPloc4uFylNRnf0c978ypGdldUEnL4u3rJCR
         Rz8uiUvFpP+HgMQApCz7SAV+qJbVmrTMoGds/0wCW2/vJDffzAFGofQ7WYZRXy78t7WE
         sNwm5m68fyrBbrLFmfdygSMf430ddBoVFd8cB3Q5gDFjucrheV7nP7YQiD4xp+oOl5aJ
         PuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747667785; x=1748272585;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gaIJp7DEmiGONwa5iKv0yKiahtqfMYGddi7S5u0w9E=;
        b=NMGKGdgAiTp0MWEk6iI69OUWrHgIrC/bgLg5xFAAfDxGPIQELtjZAZC0dgrLaMVGXU
         E5rBGxZ2LaInYYtvpWrwpteiNhVM3ZlHjXmStZQZRZf6aqPTXhO1uIaPzb9IPaA5cHie
         4YgvH3LF39lZe2KQTSEpSXhzDsL12yyvVNPNsNEVzQj+8IW1p9CmiUQOX3eVg97cH3GZ
         dkEgdKm1Ns6z1WWjWFvKgJyr87P4M2YeoyNw/EOFpZDvxBH+Hu0T9F/HSRuto00xYvq7
         vjg+GWKImNk/vGpfHnYZMuI99F2D5IY5pkjh7fi2FZrPHhacRpLN6TE8G9u6z3F/0Mit
         qZnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxVZXgxvrne03pUFGfNwsOydwHn1M/pcJqpkBOgn7lyUPpAInwfVJ31Mu6p9p8jC/CeTWGKbzsGoJUK/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy38UErNDUP1xKSuLUeHxS5KKN8NS3eIKC1cHzRJZ5h+qbflZf+
	Os+WPNr6CZraN8MQHQfcdyNQvMKv7b9jLQCw8rzke/UhlNYiiquSddVCqKQR5D7D/7dLiaSWxOA
	KAxI9yfnwvT0vwoMNDDGJj1vmOF0DORA=
X-Gm-Gg: ASbGncuc9w8jrOg8HChPIStlOf6tFYEDGCvC26mwAppCmEkypRkK/b+k+PUw+YJ/lkL
	d+1y69vfWE9dCzRwjBXdvwl2TROtYN9PxQybphIrfHmjuoaaaPwFuH/1ZmdDvH3dLFGDnIDW6mG
	NMqxkDAPJtm/7pUFd86WPGn4hponlMfw==
X-Google-Smtp-Source: AGHT+IE5FnslhdPzKpqPc7F2k54Mz7YAmogpbFKDQGPxJ9oFMdadV2bYqji9vtSlUsesrO5ZwCeYP3CujkZOHjDVYfY=
X-Received: by 2002:a05:690c:88c:b0:6f9:4bb6:eb4e with SMTP id
 00721157ae682-70ca7b8d811mr188852907b3.31.1747667784766; Mon, 19 May 2025
 08:16:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516142707.163457-1-stefano.radaelli21@gmail.com> <de1514f8-7612-4a26-a74e-cf87ce3c8819@lunn.ch>
In-Reply-To: <de1514f8-7612-4a26-a74e-cf87ce3c8819@lunn.ch>
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
Date: Mon, 19 May 2025 17:16:08 +0200
X-Gm-Features: AX0GCFtr1NrvXwdVxf--yfxPhOInMncFJx7SIpWeTMoP8Cz6kvPOGJHuLWFDYbU
Message-ID: <CAK+owogkvN+Y28YQ9X28QdLo6VXguR-6tY-10an_F02BMqFtew@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: phy: add driver for MaxLinear MxL86110 PHY
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Xu Liang <lxu@maxlinear.com>
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

Thank you for your patience and valuable feedback.
I'm learning a lot from your reviews and this process overall.

I'll send v3 shortly with the changes you pointed out.

Best regards,

Stefano


Il giorno lun 19 mag 2025 alle ore 14:35 Andrew Lunn <andrew@lunn.ch>
ha scritto:
>
> > +static int mxl86110_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
> > +{
> > +     struct net_device *netdev;
> > +     const u8 *mac;
> > +     int ret = 0;
> > +
> > +     phy_lock_mdio_bus(phydev);
> > +
> > +     if (wol->wolopts & WAKE_MAGIC) {
> > +             netdev = phydev->attached_dev;
> > +             if (!netdev) {
> > +                     ret = -ENODEV;
> > +                     goto error;
> > +             }
>
> ...
>
> > +
> > +     phy_unlock_mdio_bus(phydev);
> > +     return 0;
> > +error:
> > +     phy_unlock_mdio_bus(phydev);
> > +     return ret;
> > +}
>
> You should be able to simplify this. If you have not had an error, ret
> should be 0. So you can also return ret. You have the same pattern in
> other places.
>
> > +/**
> > + * mxl86110_synce_clk_cfg() - applies syncE/clk output configuration
> > + * @phydev: pointer to the phy_device
> > + *
> > + * Custom settings can be defined in custom config section of the driver
> > + * returns 0 or negative errno code
> > + */
>
> Maybe add a comment that the bus is expected to be locked.
>
> > +static int mxl86110_synce_clk_cfg(struct phy_device *phydev)
> > +{
> > +     u16 mask = 0, value = 0;
> > +     int ret = 0;
> > +
> > +     /*
> > +      * Configures the clock output to its default setting as per the datasheet.
> > +      * This results in a 25MHz clock output being selected in the
> > +      * COM_EXT_SYNCE_CFG register for SyncE configuration.
> > +      */
> > +     value = MXL86110_EXT_SYNCE_CFG_EN_SYNC_E |
> > +                     FIELD_PREP(MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_MASK,
> > +                                MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_25M);
> > +     mask = MXL86110_EXT_SYNCE_CFG_EN_SYNC_E |
> > +            MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_MASK |
> > +            MXL86110_EXT_SYNCE_CFG_CLK_FRE_SEL;
> > +
> > +     /* Write clock output configuration */
> > +     ret = mxl86110_modify_extended_reg(phydev, MXL86110_EXT_SYNCE_CFG_REG,
> > +                                        mask, value);
> > +
> > +     return ret;
> > +}
> > +
> > +/**
> > + * mxl86110_broadcast_cfg - Configure MDIO broadcast setting for PHY
> > + * @phydev: Pointer to the PHY device structure
> > + *
> > + * This function configures the MDIO broadcast behavior of the MxL86110 PHY.
> > + * Currently, broadcast mode is explicitly disabled by clearing the EPA0 bit
> > + * in the RGMII_MDIO_CFG extended register.
>
> here as well.
>
> > + *
> > + * Return: 0 on success or a negative errno code on failure.
> > + */
> > +static int mxl86110_broadcast_cfg(struct phy_device *phydev)
> > +{
> > +     int ret = 0;
> > +     u16 val;
> > +
> > +     val = mxl86110_read_extended_reg(phydev, MXL86110_EXT_RGMII_MDIO_CFG);
> > +     if (val < 0)
> > +             return val;
> > +
> > +     val &= ~MXL86110_EXT_RGMII_MDIO_CFG_EPA0_MASK;
> > +     ret = mxl86110_write_extended_reg(phydev, MXL86110_EXT_RGMII_MDIO_CFG, val);
>
> Could _modify_ be used here?
>
> > +
> > +     return ret;
> > +}
> > +
> > +/**
> > + * mxl86110_enable_led_activity_blink - Enable LEDs activity blink on PHY
> > + * @phydev: Pointer to the PHY device structure
> > + *
> > + * Configure all PHY LEDs to blink on traffic activity regardless of their
> > + * ON or OFF state. This behavior allows each LED to serve as a pure activity
> > + * indicator, independently of its use as a link status indicator.
> > + *
> > + * By default, each LED blinks only when it is also in the ON state. This function
> > + * modifies the appropriate registers (LABx fields) to enable blinking even
> > + * when the LEDs are OFF, to allow the LED to be used as a traffic indicator
> > + * without requiring it to also serve as a link status LED.
> > + *
> > + * NOTE: Any further LED customization can be performed via the
> > + * /sys/class/led interface; the functions led_hw_is_supported, led_hw_control_get, and
> > + * led_hw_control_set are used to support this mechanism.
> > + *
> > + * Return: 0 on success or a negative errno code on failure.
> > + */
> > +static int mxl86110_enable_led_activity_blink(struct phy_device *phydev)
> > +{
> > +     int ret, index;
> > +     u16 val = 0;
> > +
> > +     for (index = 0; index < MXL86110_MAX_LEDS; index++) {
> > +             val = mxl86110_read_extended_reg(phydev, MXL86110_LED0_CFG_REG + index);
> > +             if (val < 0)
> > +                     return val;
> > +
> > +             val |= MXL86110_LEDX_CFG_TRAFFIC_ACT_BLINK_IND;
> > +             ret = mxl86110_write_extended_reg(phydev, MXL86110_LED0_CFG_REG + index, val);
> > +             if (ret < 0)
> > +                     return ret;
>
> _modify_ ?
>
> Getting pretty close to finished now. Thanks for keeping working on
> it.
>
>         Andrew

