Return-Path: <netdev+bounces-190796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A0CAB8DAB
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 19:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D31FF1BC4861
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 17:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06206259CA1;
	Thu, 15 May 2025 17:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D25F9q7Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2402594AA;
	Thu, 15 May 2025 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329846; cv=none; b=SlpAOQLuQRNgtN1ocTAsm6ipmoe0R0dDdl/YWIb0kvx2+S9BO3mQN5CewAu97Xx6y0MIgwopvWtAbXQB/oTSbUBTEgpIo1WNDcOdMJxDaDEty7zy/N6UN1kDYViLc0lbMnDTLS0M+yLawTKP52XSkMkl/3pgatH25nP0+ZWt0xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329846; c=relaxed/simple;
	bh=jVTMc+G+MsnGu7yvTEf/heR8X6WrFkO6OQ92iSvyc/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOqh5cCwvvAbNXm5uYQT7Z2eg8u9z4xIKPIK8x2Sv409/+nFw3C7tRAWYXuQWaD7vP73pS8BbaCPbCgB7/O4pSvcvTMKSm7xPpZvJGXh9e12gQdMQxC4ByBYN3H6O5l3RyqDveP7kv47rbbhFxjQEMNJ0qT4fv0E1wUEOrNKkUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D25F9q7Z; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7099bc957d9so12265157b3.0;
        Thu, 15 May 2025 10:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747329844; x=1747934644; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=us+1sw+TjwAzbWDuUs5/7h91LAqit4Y+rsQEVdNjnnc=;
        b=D25F9q7Zd39RwPEkDqeCU4oQYUJIxQiP78lL+DZMHBiHcmXKQRKilR/qQ5s1tGHzgw
         ErxhXw5OYzkMLUOl6wsRBgcCp0e2C/nbfhjfkDfU+akuC+JcTXCZneUKw3NwbQUQAkzl
         ZlasiyRTB7yuSRlViKPgTi7w6kb1YDRc+Tj71Iz/DRzvXdTULNuhTevEQPYx8XRtXH0L
         K57e1dF5IvxtqOwMQkmgPdQUnYoxELKsHGIND0UmrZNalimkXZw5TQP6fQraruZFskcO
         M+QW0oUvmX/2faYwkyZ5FAV4SyUQ7mMfnSNmG+DM2Vs576Swq6IrgYnrOWf0C7VhU2G0
         QQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747329844; x=1747934644;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=us+1sw+TjwAzbWDuUs5/7h91LAqit4Y+rsQEVdNjnnc=;
        b=YJbLOh5FTshR27+JNhvZ43xPJgDUug2AuU2rQEwch52KxL2t/FBZqBq6DIq+VlyfbK
         0ia4UM69/vymmtd3hE1+Bv4apoMYWPE8I52B0tqUI8PUaS5rjDweNAWEvumeTPf92dd5
         Z4BOk2F1fMjf7JoBqNO1DNjn88UGyzHvjNht1GYjbJ5rAlfmf98SEiIVOmgvplf49+Uq
         TPMhd8HGgXxxdDv123Yxzp1sZ62u1Hhp/j7uEdzCXXVAAwRagSH5K1ZTKHdoCdcioCSS
         dNuK7vYNVQuJFjlcRkS0IhlyPBoKa/6e03BFow6kTH6opY2m+JeVNV6MkxB2bvDbwWCQ
         tecA==
X-Forwarded-Encrypted: i=1; AJvYcCVQC49/rGFXdGaiN8zOrxqgdHtyf/3x47u/xP9QgQ5zdQ2Bangtil9EpflaKLf8gS1oYPLrQ+IkCFJO07c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzgzgojp07r2UBH8rmTZ45HTZdNRCpMvKIt2HZNy41zRt40Sbh
	ZNLEQuYL19UPVDYGk+VhT+Y4/hlFDJcIBnsGv0JvmzXKL4lrOkMSLYQ6XP96XIhUJQ+W8OEDS24
	SMWLNkFEK5JfYwADo4qbqlLFGXT8TM/o=
X-Gm-Gg: ASbGnctN22jbWhc7ZgswFZ0sW1s44poxnaZYcZSUb6PCZ8nXowXfqEqIzuMibHHDm6A
	kZGEU0ahSr/gpw+1NFctf5beog6CZLKRA+vlJAXf1alWxIEikJfHsELzOx8VH/L9hcouyv3EpAu
	rb3DhNwGr3akBTJIQAJNhpqy2YkVtsw9yU
X-Google-Smtp-Source: AGHT+IEjTEoJRq2T3LULkfk9Zh9aHi/xSNGmuKKzDYSZ6rjqdu8cGJaPZyPzb5syYIGHMSt4dS7tNSz/nGd90u+Sjyk=
X-Received: by 2002:a05:690c:4c13:b0:703:c3ed:1f61 with SMTP id
 00721157ae682-70ca7a14077mr7892047b3.20.1747329843704; Thu, 15 May 2025
 10:24:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515152432.77835-1-stefano.radaelli21@gmail.com> <2b2ef0bd-6491-41a0-b2e1-81e2b83167ef@lunn.ch>
In-Reply-To: <2b2ef0bd-6491-41a0-b2e1-81e2b83167ef@lunn.ch>
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
Date: Thu, 15 May 2025 19:23:53 +0200
X-Gm-Features: AX0GCFtrXZdRTTe1Z1VhonDgvkBWT9Gpepioxgzk2FCQBn1UeCMIbi53mBPc35U
Message-ID: <CAK+owogXdnvoiVNBn_6uBZgqoHrkiQmVU58ip1Wqd6v8VX5f6A@mail.gmail.com>
Subject: Re: [PATCH] net: phy: add driver for MaxLinear MxL86110 PHY
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Xu Liang <lxu@maxlinear.com>
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

> If there is only one page, does these make any sense?

You're totally right: the MxL86110 does not have a traditional page
mechanism like other PHYs. The so-called "page" access via register 30
is simply the standard MaxLinear mechanism to access extended
registers: reg 30 is used to select the register address, and reg 31 is used
for the data. So in this case, I can drop both 'phy_select_page()' and the
'read_page'/'write_page' functions entirely, and just keep the
'mxl86110_{read,write}_extended_reg()' helpers.

> This is confusing. It looks identical to mxl86110_write_page(). So
> regnum is actually page?

Exactly; as mentioned above, regnum isn't a page, it's the actual address
of the extended register I'm trying to access. The name `regnum` is
still accurate
because it corresponds to the extended register map defined by MaxLinear
and written to reg 30 before accessing reg 31.

> So does the value 1 here mean 8ns? 0 would be 2ns?

Setting RXDLY_ENABLE = 1 enables the internal fixed RX_CLK delay
provided by the PHY, but the actual delay value depends on the
RX clock frequency: approximately 2 ns at 125 MHz, and ~8 ns at 25 or 2.5 MHz.
I'm not explicitly selecting 2 or 8 ns, it's applied automatically by the PHY
based on clock rate.

Since this delay is additive with the configurable digital RX delay
set in `CFG1_REG`, I only configure 150 ps in the digital field to
avoid over-delaying.
That said, if you prefer, I can disable `RXDLY_ENABLE` and set to 1950 ps
directly in the digital delay field. Just let me know what you'd prefer here.

Thanks again,
Stefano

Il giorno gio 15 mag 2025 alle ore 18:33 Andrew Lunn <andrew@lunn.ch>
ha scritto:
>
> > +/* only 1 page for MXL86110 */
> > +#define MXL86110_DEFAULT_PAGE        0
>
> > +/**
> > + * mxl86110_read_page - Read current page number
> > + * @phydev: Pointer to the PHY device
> > + *
> > + * Return: The currently selected page number, or negative errno on failure.
> > + */
> > +static int mxl86110_read_page(struct phy_device *phydev)
> > +{
> > +     return __phy_read(phydev, MXL86110_EXTD_REG_ADDR_OFFSET);
> > +};
>
> If there is only one page, does these make any sense?
>
> > +static int mxl86110_write_page(struct phy_device *phydev, int page)
> > +{
> > +     return __phy_write(phydev, MXL86110_EXTD_REG_ADDR_OFFSET, page);
> > +};
> > +
> > +/**
> > + * mxl86110_write_extended_reg() - write to a PHY's extended register
> > + * @phydev: pointer to a &struct phy_device
> > + * @regnum: register number to write
> > + * @val: value to write to @regnum
> > + *
> > + * NOTE: This function assumes the caller already holds the MDIO bus lock
> > + * or otherwise has exclusive access to the PHY. If exclusive access
> > + * cannot be guaranteed, please use mxl86110_locked_write_extended_reg()
> > + * which handles locking internally.
> > + *
> > + * returns 0 or negative error code
> > + */
> > +static int mxl86110_write_extended_reg(struct phy_device *phydev, u16 regnum, u16 val)
> > +{
> > +     int ret;
> > +
> > +     ret = __phy_write(phydev, MXL86110_EXTD_REG_ADDR_OFFSET, regnum);
>
> This is confusing. It looks identical to mxl86110_write_page(). So
> regnum is actually page?
>
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return __phy_write(phydev, MXL86110_EXTD_REG_ADDR_DATA, val);
>
> And within that page, there is a single register at address
> MXL86110_EXTD_REG_ADDR_DATA?
>
> If you keep the write_page() and read_page(), it looks like you can
> replace this with
>
>         return phy_write_paged(phydev, regnum,
>                                MXL86110_EXTD_REG_ADDR_DATA,
>                                val);
>
> > +static int mxl86110_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
> > +{
> > +     struct net_device *netdev;
> > +     int page_to_restore;
> > +     const u8 *mac;
> > +     int ret = 0;
> > +
> > +     if (wol->wolopts & WAKE_MAGIC) {
> > +             netdev = phydev->attached_dev;
> > +             if (!netdev)
> > +                     return -ENODEV;
> > +
> > +             page_to_restore = phy_select_page(phydev, MXL86110_DEFAULT_PAGE);
> > +             if (page_to_restore < 0)
> > +                     goto error;
>
> If there is only one page, i think this can be removed. And everywhere
> else in the driver.
>
> > +     /*
> > +      * RX_CLK delay (RXDLY) enabled via CHIP_CFG register causes a fixed
> > +      * delay of approximately 2 ns at 125 MHz or 8 ns at 25/2.5 MHz.
> > +      * Digital delays in RGMII_CFG1 register are additive
> > +      */
> > +     switch (phydev->interface) {
> > +     case PHY_INTERFACE_MODE_RGMII:
> > +             val = 0;
> > +             break;
> > +     case PHY_INTERFACE_MODE_RGMII_RXID:
> > +             val = MXL86110_EXT_RGMII_CFG1_RX_DELAY_150PS;
>
> This should be 2000ps, or the nearest you can get to it.
>
> > +             break;
> > +     case PHY_INTERFACE_MODE_RGMII_TXID:
> > +             val = MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_2250PS |
> > +                     MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_2250PS;
> > +             break;
> > +     case PHY_INTERFACE_MODE_RGMII_ID:
> > +             val = MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_2250PS |
> > +                     MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_2250PS;
> > +             val |= MXL86110_EXT_RGMII_CFG1_RX_DELAY_150PS;
>
> Same here.
>
> > +             break;
> > +     default:
> > +             ret = -EINVAL;
> > +             goto err_restore_page;
> > +     }
> > +     ret = mxl86110_modify_extended_reg(phydev, MXL86110_EXT_RGMII_CFG1_REG,
> > +                                        MXL86110_EXT_RGMII_CFG1_FULL_MASK, val);
> > +     if (ret < 0)
> > +             goto err_restore_page;
> > +
> > +     /* Configure RXDLY (RGMII Rx Clock Delay) to keep the default
> > +      * delay value on RX_CLK (2 ns for 125 MHz, 8 ns for 25 MHz/2.5 MHz)
> > +      */
> > +     ret = mxl86110_modify_extended_reg(phydev, MXL86110_EXT_CHIP_CFG_REG,
> > +                                        MXL86110_EXT_CHIP_CFG_RXDLY_ENABLE, 1);
>
> So does the value 1 here mean 8ns? 0 would be 2ns?
>
>     Andrew
>
> ---
> pw-bot: cr

