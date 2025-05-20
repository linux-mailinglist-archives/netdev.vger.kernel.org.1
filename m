Return-Path: <netdev+bounces-191930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B948EABDF32
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 17:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C23B8C43EF
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 15:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B7621ADA9;
	Tue, 20 May 2025 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frpLzvaE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B576BA59;
	Tue, 20 May 2025 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747755235; cv=none; b=Ap6UVA7uSiQ96XH8w/tbstyNLURmetR8eBdcSGY7/r3/4mkp1rNNlz/w9DOT8xtXFZT/fYvYJXsDvHeBiQOENq5MFOvpi26IbnhDB3mMZYGjWh3bTua2k89Ka9n60Ch/yxteAxCyfRK4v3EXxdSC7guVDI+6BtnE0fGPbcHmKTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747755235; c=relaxed/simple;
	bh=cPkYLFjrzcYFn3qN9YKCCA6EfNtjTUoRuXKbyS62Q9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QplId7D33sA7T7Ok7xofJeF5ghAA5RdwdQTw5CFm8u5vh5FxDVmn7gGcCQ98+2O2xPI3FRipc7abdX1PCBsbIIUwvtg/m8OKTO9+V9GSowxbGjhEOwgfYo+3p6WLUov3JhqpV1WnKkmZUbTvuAvrbRlHJrtUWwVWZyh/eA7j9G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frpLzvaE; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e740a09eae0so5098979276.1;
        Tue, 20 May 2025 08:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747755232; x=1748360032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuePUDNTSP7Zv4KoyLovZ0AgWPA1+FjdIElftez7oiY=;
        b=frpLzvaEVkuRxdPWptfbdMKlJJejn2NbjiP+LRxeedodG1ruzQYuHSvnmC29KqL+0f
         PjtYRxxmUw/P1iZ/D6T2z8h+0eVegbQLXgNlzAMJ1azmK4wPCma7Mtz7hVjlE2GCR+OU
         PcqbFuZ1ZpYUQ2cmXEVJf2s+P1wlEvsAgXb4ZUYwraUUw1sUeUHleVS1w3pkcJh62RKb
         4l1R8MJY/0NY3GaZrptPlxQA0/+DlYFnPFqPBqIHcsoP9gaDKu/oD6tdVPghmgv7L4w3
         B3Py0SdlDHcjn33YzyB4ec8fTMeL+Z1dvrCvbIzKvI9Qifb4hypJKRNf7U7u8Em2MhAM
         aWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747755232; x=1748360032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WuePUDNTSP7Zv4KoyLovZ0AgWPA1+FjdIElftez7oiY=;
        b=d1PuHHabEIr2Z2/0fJlZ2p6NR5XhgWLPxLIUMCiuKeIughFIR1mdTKDNO8p6/Qdr7v
         95x9xOXcnJwlGyZlZYlk5JfHLg5soOJcFXm+LZRcmwbXp3JaLqe4pauFWrZ26xO+m6ys
         96IXqrV/QE4a5lK+DRIxiLo8L/Ugyeu0Mhq+UBxY5iANdqGgbnUis3iTwcvTg4Vh+aXg
         ldOeE9UWc3iVxh4jO0QZnwnMwk4AF54N0TvmvfoWxGaHjfiI8nIKp7YFV4sd9ShNms6d
         tt4LUOxrLOkZQh0NmW8bMG//l2WtfpajSdrJTpfsLBUCt5m8g6m/CUBpPUNlALvqwZaN
         Av9w==
X-Forwarded-Encrypted: i=1; AJvYcCXHaYF54Ernwz9oB0DEaOnF0XOR3bl8uwaDkvqjqv6OVw7d52SjppWGVvQa+dUwBuGMfxqWCKVKTDDKLhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIN72nwvLtg2FRP5o8TKA8ZqWx87oRPtnwVQlZYDUFY0pcwTR+
	Qaynm5aqTW/iIKlZg3Xl4l+Np5UzGEYuaPDonxppu9SAN7/AbvvHVY1JLE9lHEjChGgQDZbeef6
	Xnu6TdlWtj2i516AB0TIDxIbGCjiaktw=
X-Gm-Gg: ASbGncsG09/xUcNUoCOD6z1pWXiD1pkKRYXOPdaLEcTqrzpcptMez9YUxLYAJzI5N05
	6tGlHo4Oe+MUC1dHG14jP0KzD7eB5ryrWUoYckmEMeiLD1kYgNo0aXxtdrAJ7EPjiC1pQ284QN/
	eRR6MmQfvllufcr00g03Tvh4cgas1K2A==
X-Google-Smtp-Source: AGHT+IHAmrDfAT0gtBvofGs2o0SplF11N2h94iscS8NKVQsD9/HanHXD6Voe6z4BvBIGDqRrmJfW/cIW50Eql6QeStw=
X-Received: by 2002:a05:6902:72b:b0:e7b:a4c5:a9db with SMTP id
 3f1490d57ef6-e7ba4c5ab38mr10847823276.49.1747755232382; Tue, 20 May 2025
 08:33:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520124521.440639-1-stefano.radaelli21@gmail.com> <aCyV-Zaeg-BLV0Vt@shell.armlinux.org.uk>
In-Reply-To: <aCyV-Zaeg-BLV0Vt@shell.armlinux.org.uk>
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
Date: Tue, 20 May 2025 17:33:36 +0200
X-Gm-Features: AX0GCFvWWQlScw5K2l32rN9ALyKRQqH307z89x8ORIFIZ5ZgNwLcefwyk2l8RcU
Message-ID: <CAK+owog+FYU0Y+ceg1=DtLdS+Nw0JMjDEOoYs71YAEGDbKrXfw@mail.gmail.com>
Subject: Re: [PATCH net-next v4] net: phy: add driver for MaxLinear MxL86110 PHY
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Xu Liang <lxu@maxlinear.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Russel,

Thank you very much for your feedback and for pointing out these aspects.
I really appreciate your review and the time you took to highlight these
improvements.

> As these are all unlocked variants, I wonder whether they should have
> __ prefixes. I'm wondering whether our paged accessors could be re-used
> for this phy, even though effectively there is only one "paged" register
> at offset 31 with the page index at offset 30.
>
> Also, given the number of single accesses to the registers, I wonder if
> it also makes sense to have variants that take the MDIO bus lock, which
> would allow simplification of sites such as...

Regarding the __ prefixes: I absolutely agree with following the establishe=
d
naming convention, as seen for instance with __phy_write vs phy_write
and __mdiobus_write vs mdiobus_write.
I also believe it would make sense to rename these functions to
__mxl86110_{read,write}_extended_reg and add corresponding locked variants
like mxl86110_{read,write}_extended_reg() to allow simplifying the call sit=
es
you mentioned.

As for the paged accessors: personally, I would prefer to keep the current
approach to explicitly reflect that we're accessing what the datasheet refe=
rs to
as "Extended Registers". Introducing a generic paging mechanism here might
obscure that intention and potentially cause confusion for readers less fam=
iliar
with this PHY. What do you think?

If you agree, I=E2=80=99d be happy to proceed with the changes accordingly.

Best Regards,

Stefano

Il giorno mar 20 mag 2025 alle ore 16:47 Russell King (Oracle)
<linux@armlinux.org.uk> ha scritto:
>
> On Tue, May 20, 2025 at 02:45:18PM +0200, stefano.radaelli21@gmail.com wr=
ote:
> > +/**
> > + * mxl86110_write_extended_reg() - write to a PHY's extended register
> > + * @phydev: pointer to a &struct phy_device
> > + * @regnum: register number to write
> > + * @val: value to write to @regnum
> > + *
> > + * Note: This function assumes the caller already holds the MDIO bus l=
ock
> > + * or otherwise has exclusive access to the PHY.
> > + *
> > + * Return: 0 or negative error code
> > + */
> > +static int mxl86110_write_extended_reg(struct phy_device *phydev,
> > +                                    u16 regnum, u16 val)
> > +{
> > +     int ret;
> > +
> > +     ret =3D __phy_write(phydev, MXL86110_EXTD_REG_ADDR_OFFSET, regnum=
);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return __phy_write(phydev, MXL86110_EXTD_REG_ADDR_DATA, val);
> > +}
> > +
> > +/**
> > + * mxl86110_read_extended_reg - Read a PHY's extended register
> > + * @phydev: Pointer to the PHY device structure
> > + * @regnum: Extended register number to read (address written to reg 3=
0)
> > + *
> > + * Reads the content of a PHY extended register using the MaxLinear
> > + * 2-step access mechanism: write the register address to reg 30 (0x1E=
),
> > + * then read the value from reg 31 (0x1F).
> > + *
> > + * Note: This function assumes the caller already holds the MDIO bus l=
ock
> > + * or otherwise has exclusive access to the PHY.
> > + *
> > + * Return: 16-bit register value on success, or negative errno code on=
 failure.
> > + */
> > +static int mxl86110_read_extended_reg(struct phy_device *phydev, u16 r=
egnum)
> > +{
> > +     int ret;
> > +
> > +     ret =3D __phy_write(phydev, MXL86110_EXTD_REG_ADDR_OFFSET, regnum=
);
> > +     if (ret < 0)
> > +             return ret;
> > +     return __phy_read(phydev, MXL86110_EXTD_REG_ADDR_DATA);
> > +}
> > +
> > +/**
> > + * mxl86110_modify_extended_reg() - modify bits of a PHY's extended re=
gister
> > + * @phydev: pointer to the phy_device
> > + * @regnum: register number to write
> > + * @mask: bit mask of bits to clear
> > + * @set: bit mask of bits to set
> > + *
> > + * Note: register value =3D (old register value & ~mask) | set.
> > + * This function assumes the caller already holds the MDIO bus lock
> > + * or otherwise has exclusive access to the PHY.
> > + *
> > + * Return: 0 or negative error code
> > + */
> > +static int mxl86110_modify_extended_reg(struct phy_device *phydev,
> > +                                     u16 regnum, u16 mask, u16 set)
> > +{
> > +     int ret;
> > +
> > +     ret =3D __phy_write(phydev, MXL86110_EXTD_REG_ADDR_OFFSET, regnum=
);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return __phy_modify(phydev, MXL86110_EXTD_REG_ADDR_DATA, mask, se=
t);
> > +}
>
> As these are all unlocked variants, I wonder whether they should have
> __ prefixes. I'm wondering whether our paged accessors could be re-used
> for this phy, even though effectively there is only one "paged" register
> at offset 31 with the page index at offset 30.
>
> Also, given the number of single accesses to the registers, I wonder if
> it also makes sense to have variants that take the MDIO bus lock, which
> would allow simplification of sites such as...
>
> > +
> > +/**
> > + * mxl86110_get_wol() - report if wake-on-lan is enabled
> > + * @phydev: pointer to the phy_device
> > + * @wol: a pointer to a &struct ethtool_wolinfo
> > + */
> > +static void mxl86110_get_wol(struct phy_device *phydev,
> > +                          struct ethtool_wolinfo *wol)
> > +{
> > +     int value;
> > +
> > +     wol->supported =3D WAKE_MAGIC;
> > +     wol->wolopts =3D 0;
> > +     phy_lock_mdio_bus(phydev);
> > +     value =3D mxl86110_read_extended_reg(phydev, MXL86110_EXT_WOL_CFG=
_REG);
> > +     phy_unlock_mdio_bus(phydev);
>
> ... here.
>
> > +     if (value >=3D 0 && (value & MXL86110_WOL_CFG_WOLE_MASK))
> > +             wol->wolopts |=3D WAKE_MAGIC;
> > +}
> > +
> > +/**
> > + * mxl86110_set_wol() - enable/disable wake-on-lan
> > + * @phydev: pointer to the phy_device
> > + * @wol: a pointer to a &struct ethtool_wolinfo
> > + *
> > + * Configures the WOL Magic Packet MAC
> > + *
> > + * Return: 0 or negative errno code
> > + */
> > +static int mxl86110_set_wol(struct phy_device *phydev,
> > +                         struct ethtool_wolinfo *wol)
> > +{
> > +     struct net_device *netdev;
> > +     const u8 *mac;
>
> Use "const unsigned char *mac" - that way you don't need the cast below.
>
> > +     int ret =3D 0;
> > +
> > +     phy_lock_mdio_bus(phydev);
> > +
> > +     if (wol->wolopts & WAKE_MAGIC) {
> > +             netdev =3D phydev->attached_dev;
> > +             if (!netdev) {
> > +                     ret =3D -ENODEV;
> > +                     goto out;
> > +             }
> > +
> > +             /* Configure the MAC address of the WOL magic packet */
> > +             mac =3D (const u8 *)netdev->dev_addr;
> > +             ret =3D mxl86110_write_extended_reg(phydev,
> > +                                               MXL86110_EXT_MAC_ADDR_C=
FG1,
> > +                                               ((mac[0] << 8) | mac[1]=
));
> > +             if (ret < 0)
> > +                     goto out;
> > +
> > +             ret =3D mxl86110_write_extended_reg(phydev,
> > +                                               MXL86110_EXT_MAC_ADDR_C=
FG2,
> > +                                               ((mac[2] << 8) | mac[3]=
));
> > +             if (ret < 0)
> > +                     goto out;
> > +
> > +             ret =3D mxl86110_write_extended_reg(phydev,
> > +                                               MXL86110_EXT_MAC_ADDR_C=
FG3,
> > +                                               ((mac[4] << 8) | mac[5]=
));
> > +             if (ret < 0)
> > +                     goto out;
> > +
> > +             ret =3D mxl86110_modify_extended_reg(phydev,
> > +                                                MXL86110_EXT_WOL_CFG_R=
EG,
> > +                                                MXL86110_WOL_CFG_WOLE_=
MASK,
> > +                                                MXL86110_EXT_WOL_CFG_W=
OLE);
> > +             if (ret < 0)
> > +                     goto out;
> > +
> > +             /* Enables Wake-on-LAN interrupt in the PHY. */
> > +             ret =3D __phy_modify(phydev, PHY_IRQ_ENABLE_REG, 0,
> > +                                PHY_IRQ_ENABLE_REG_WOL);
> > +             if (ret < 0)
> > +                     goto out;
> > +
> > +             phydev_dbg(phydev,
> > +                        "%s, MAC Addr: %02X:%02X:%02X:%02X:%02X:%02X\n=
",
> > +                        __func__,
> > +                        mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]=
);
> > +     } else {
> > +             ret =3D mxl86110_modify_extended_reg(phydev,
> > +                                                MXL86110_EXT_WOL_CFG_R=
EG,
> > +                                                MXL86110_WOL_CFG_WOLE_=
MASK,
> > +                                                0);
> > +             if (ret < 0)
> > +                     goto out;
> > +
> > +             /* Disables Wake-on-LAN interrupt in the PHY. */
> > +             ret =3D __phy_modify(phydev, PHY_IRQ_ENABLE_REG,
> > +                                PHY_IRQ_ENABLE_REG_WOL, 0);
> > +     }
> > +
> > +out:
> > +     phy_unlock_mdio_bus(phydev);
> > +     return ret;
> > +}
> > +
>
> ...
> > +static int mxl86110_led_hw_control_get(struct phy_device *phydev, u8 i=
ndex,
> > +                                    unsigned long *rules)
> > +{
> > +     int val;
> > +
> > +     if (index >=3D MXL86110_MAX_LEDS)
> > +             return -EINVAL;
> > +
> > +     phy_lock_mdio_bus(phydev);
> > +     val =3D mxl86110_read_extended_reg(phydev,
> > +                                      MXL86110_LED0_CFG_REG + index);
> > +     phy_unlock_mdio_bus(phydev);
>
> This could also be simplified with the locking accessors.
>
> > +     if (val < 0)
> > +             return val;
> > +
> > +     if (val & MXL86110_LEDX_CFG_LINK_UP_TX_ACT_ON)
> > +             *rules |=3D BIT(TRIGGER_NETDEV_TX);
> > +
> > +     if (val & MXL86110_LEDX_CFG_LINK_UP_RX_ACT_ON)
> > +             *rules |=3D BIT(TRIGGER_NETDEV_RX);
> > +
> > +     if (val & MXL86110_LEDX_CFG_LINK_UP_HALF_DUPLEX_ON)
> > +             *rules |=3D BIT(TRIGGER_NETDEV_HALF_DUPLEX);
> > +
> > +     if (val & MXL86110_LEDX_CFG_LINK_UP_FULL_DUPLEX_ON)
> > +             *rules |=3D BIT(TRIGGER_NETDEV_FULL_DUPLEX);
> > +
> > +     if (val & MXL86110_LEDX_CFG_LINK_UP_10MB_ON)
> > +             *rules |=3D BIT(TRIGGER_NETDEV_LINK_10);
> > +
> > +     if (val & MXL86110_LEDX_CFG_LINK_UP_100MB_ON)
> > +             *rules |=3D BIT(TRIGGER_NETDEV_LINK_100);
> > +
> > +     if (val & MXL86110_LEDX_CFG_LINK_UP_1GB_ON)
> > +             *rules |=3D BIT(TRIGGER_NETDEV_LINK_1000);
> > +
> > +     return 0;
> > +};
> > +
> > +static int mxl86110_led_hw_control_set(struct phy_device *phydev, u8 i=
ndex,
> > +                                    unsigned long rules)
> > +{
> > +     u16 val =3D 0;
> > +     int ret;
> > +
> > +     if (index >=3D MXL86110_MAX_LEDS)
> > +             return -EINVAL;
> > +
> > +     if (rules & BIT(TRIGGER_NETDEV_LINK_10))
> > +             val |=3D MXL86110_LEDX_CFG_LINK_UP_10MB_ON;
> > +
> > +     if (rules & BIT(TRIGGER_NETDEV_LINK_100))
> > +             val |=3D MXL86110_LEDX_CFG_LINK_UP_100MB_ON;
> > +
> > +     if (rules & BIT(TRIGGER_NETDEV_LINK_1000))
> > +             val |=3D MXL86110_LEDX_CFG_LINK_UP_1GB_ON;
> > +
> > +     if (rules & BIT(TRIGGER_NETDEV_TX))
> > +             val |=3D MXL86110_LEDX_CFG_LINK_UP_TX_ACT_ON;
> > +
> > +     if (rules & BIT(TRIGGER_NETDEV_RX))
> > +             val |=3D MXL86110_LEDX_CFG_LINK_UP_RX_ACT_ON;
> > +
> > +     if (rules & BIT(TRIGGER_NETDEV_HALF_DUPLEX))
> > +             val |=3D MXL86110_LEDX_CFG_LINK_UP_HALF_DUPLEX_ON;
> > +
> > +     if (rules & BIT(TRIGGER_NETDEV_FULL_DUPLEX))
> > +             val |=3D MXL86110_LEDX_CFG_LINK_UP_FULL_DUPLEX_ON;
> > +
> > +     if (rules & BIT(TRIGGER_NETDEV_TX) ||
> > +         rules & BIT(TRIGGER_NETDEV_RX))
> > +             val |=3D MXL86110_LEDX_CFG_LAB_BLINK;
> > +
> > +     phy_lock_mdio_bus(phydev);
> > +     ret =3D mxl86110_write_extended_reg(phydev,
> > +                                       MXL86110_LED0_CFG_REG + index, =
val);
> > +     phy_unlock_mdio_bus(phydev);
>
> and this... and with the locking accessors it could become simply:
>
>         return mxl86110_write_extended_reg(...);
>
> > +     if (ret)
> > +             return ret;
> > +
> > +     return 0;
> > +};
> > +
> > +/**
> > + * mxl86110_synce_clk_cfg() - applies syncE/clk output configuration
> > + * @phydev: pointer to the phy_device
> > + *
> > + * Note: This function assumes the caller already holds the MDIO bus l=
ock
> > + * or otherwise has exclusive access to the PHY.
> > + *
> > + * Return: 0 or negative errno code
> > + */
> > +static int mxl86110_synce_clk_cfg(struct phy_device *phydev)
> > +{
> > +     u16 mask =3D 0, val =3D 0;
> > +     int ret;
> > +
> > +     /*
> > +      * Configures the clock output to its default
> > +      * setting as per the datasheet.
> > +      * This results in a 25MHz clock output being selected in the
> > +      * COM_EXT_SYNCE_CFG register for SyncE configuration.
> > +      */
> > +     val =3D MXL86110_EXT_SYNCE_CFG_EN_SYNC_E |
> > +                     FIELD_PREP(MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_MAS=
K,
> > +                                MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_25M=
);
> > +     mask =3D MXL86110_EXT_SYNCE_CFG_EN_SYNC_E |
> > +            MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_MASK |
> > +            MXL86110_EXT_SYNCE_CFG_CLK_FRE_SEL;
> > +
> > +     /* Write clock output configuration */
> > +     ret =3D mxl86110_modify_extended_reg(phydev, MXL86110_EXT_SYNCE_C=
FG_REG,
> > +                                        mask, val);
> > +
> > +     return ret;
>
> No need for "ret":
>
>         return mxl86110_modify_extended_reg(phydev, MXL86110_EXT_SYNCE_CF=
G_REG,
>                                             mask, val);
>
> > +}
> > +
> > +/**
> > + * mxl86110_broadcast_cfg - Configure MDIO broadcast setting for PHY
> > + * @phydev: Pointer to the PHY device structure
> > + *
> > + * This function configures the MDIO broadcast behavior of the MxL8611=
0 PHY.
> > + * Currently, broadcast mode is explicitly disabled by clearing the EP=
A0 bit
> > + * in the RGMII_MDIO_CFG extended register.
> > + *
> > + * Note: This function assumes the caller already holds the MDIO bus l=
ock
> > + * or otherwise has exclusive access to the PHY.
> > + *
> > + * Return: 0 on success or a negative errno code on failure.
> > + */
> > +static int mxl86110_broadcast_cfg(struct phy_device *phydev)
> > +{
> > +     int ret;
> > +
> > +     ret =3D mxl86110_modify_extended_reg(phydev,
> > +                                        MXL86110_EXT_RGMII_MDIO_CFG,
> > +                                        MXL86110_RGMII_MDIO_CFG_EPA0_M=
ASK,
> > +                                        0);
> > +
> > +     return ret;
>
> No need for "ret".
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

