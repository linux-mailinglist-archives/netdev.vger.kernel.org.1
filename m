Return-Path: <netdev+bounces-191666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFE7ABCA46
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 23:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D533C1BA0613
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 21:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A392621CA14;
	Mon, 19 May 2025 21:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hljQo3jo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA011DA21;
	Mon, 19 May 2025 21:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747691214; cv=none; b=eddd8t81Z7lA8eL6BC8Hn41odPx0EpJZLtv9qa81oaM6iGG+7xDzSIOGtNvGGH1hkTPnM/MT3R1GXVd0fLQwNBZD9kdDW/QaB5e4d2EC8qFNHuWY1FPaqk67BZnWcRejLvcp+3m7dxGmiaczPShkA0eMtJJcaHFqZi71Fwluv14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747691214; c=relaxed/simple;
	bh=N1521YN47TVp3G/xpFAXWoEuVbJW7GAojZiKgi5PgLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ph0lRwseYPdib0mE6SEkuqEYYQmfhacmWeJNeYmKYWhttttV/w3xw0acDnstUUaVWPKNScoOMGLRTdfxRwTrD8AX1N2RylhavbBPuwG8JAjWZBKVMA4POS7A9w512+fxmgQmcV9IgK2tcvT0y4Ftww4ZR37FNPcoFMzEDLG4mrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hljQo3jo; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e7ba37b2b5bso1552349276.0;
        Mon, 19 May 2025 14:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747691211; x=1748296011; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qFqHFurMBZtPAapbA1XA+pcLlQHLYWNfAxkQ+sCmyUk=;
        b=hljQo3jo/XJznTe6eYjD5riMmMdvs2psQ8fcgL08iNNRjq67fZ3tWx/B5s0rl7EFc0
         A4DReY1BGF7K0r1J8fymBzfvuLVkGdHr+0GMnJCy2yj1e3xHVwauGmLqQUOYZx5oJPyU
         54sJbuE9MytfizNLBqMsPjnIxiz3k5WwkiY3XPzA9Ghp6f1PSdOadJDVr37OBJhvk3E5
         wsTcvcLSY5TF5RyASz+ZlKvYvBaLcrPR+m7oHqxXFbrl8d3Lfguo10qmHQPouOyuzQNw
         icf2mifwSiOlU8//JZDUTKtWCSARBPvfpIbb/PqPIRIk1PiMGN2jaljgdDgpm/ZRkrt5
         P5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747691211; x=1748296011;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qFqHFurMBZtPAapbA1XA+pcLlQHLYWNfAxkQ+sCmyUk=;
        b=SB92ZPBstFUliZSo8iLfbe/olnqD1rl4k34vDzGE2q0PtPttWQjzjDZXeIzyT45uSZ
         GRHJV56xk47duBxwSgQfKFsSE5G97Dq3s8pSUoXEI5+eX1DpcOSF0akkW/2jQNn4rJvk
         esLcdsB9qhjCkjbL69EyS8uhjhC5Euov04jQeeg/uvf14BmRzyy3G+eiueMWUaStQhOc
         ztVgRPJ9lE6v7v6QWwXhM6zgP4ibw6UBOHaG1ykDWZXa0kvBIMKpifV8K78Tq84grt0D
         7BVQMacEOwDN/uw3cH4IHliWmXsPN/SJ/kZMMpujySpb/hW2nH7gLac4ZRzuhnDoPphB
         BgDg==
X-Forwarded-Encrypted: i=1; AJvYcCVlAB86XH/I8dZg2kNcZWS5zUJ1HtuJ81uPugEXnp//FZ3HWNbNfs12OkMzwkztyECWC1qP5WlM/5vUfRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9pRSnoOJdhyVyNlfNpQRuaLeGVkBAGLu2Cz4dM67+xrP86k/R
	dksjuwIoXziYPM528dEKSDrL/0lwuxCXjMzWnZKA0LTGzcDJwbg1eZk4B/X5PVphKHtvqijtDoi
	wL1HhhbLFBwxW2cFJ7QS22JsrgmJHtmU=
X-Gm-Gg: ASbGncvguHbGL2SUqmEDYHYhAhKjbWCEkwZMFYTr6QPnxQTIzC2GpCgp/AKFTg++k+J
	8ETfXPIXOLu1vOUOqRiM1dg2IVIWTZZTy5cggAb3gOwcXHR5tw8hkePA+g1PB5sMZ1+Y7R40pw3
	Bs31cav0EhOBiTYGt22VMPkEKUhhJ2h5PWwQ==
X-Google-Smtp-Source: AGHT+IGHodC3eA+AeXqJGy+cl40swETxEWeQdkJjh8gyft6+9faOheS8KTxGncgcx90cLYanFRvoexWTGw4SJAitFlQ=
X-Received: by 2002:a05:6902:2086:b0:e79:1566:64fa with SMTP id
 3f1490d57ef6-e7b6d3fbda1mr16915479276.15.1747691210932; Mon, 19 May 2025
 14:46:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516164126.234883-1-stefano.radaelli21@gmail.com> <20250519164021.GL365796@horms.kernel.org>
In-Reply-To: <20250519164021.GL365796@horms.kernel.org>
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
Date: Mon, 19 May 2025 23:46:34 +0200
X-Gm-Features: AX0GCFuBR54LVZrUjDmsQ3vo2yUBgjCY-fYJr8Xxxmt2BtO0ogT56rYcYNxqfkg
Message-ID: <CAK+owojiySqLBtHq-=OpotxR3_Z0uoZzukVrF9Ak=fiUHtPm5Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: phy: add driver for MaxLinear MxL86110 PHY
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Xu Liang <lxu@maxlinear.com>
Content-Type: text/plain; charset="UTF-8"

Hi Simon,

Thank you for your feedback!
v4 will be ready soon.

Best Regards,

Stefano

Il giorno lun 19 mag 2025 alle ore 18:40 Simon Horman
<horms@kernel.org> ha scritto:
>
> On Fri, May 16, 2025 at 06:41:23PM +0200, Stefano Radaelli wrote:
> > Add support for the MaxLinear MxL86110 Gigabit Ethernet PHY, a low-power,
> > cost-optimized transceiver supporting 10/100/1000 Mbps over twisted-pair
> > copper, compliant with IEEE 802.3.
> >
> > The driver implements basic features such as:
> > - Device initialization
> > - RGMII interface timing configuration
> > - Wake-on-LAN support
> > - LED initialization and control via /sys/class/leds
> >
> > This driver has been tested on multiple Variscite boards, including:
> > - VAR-SOM-MX93 (i.MX93)
> > - VAR-SOM-MX8M-PLUS (i.MX8MP)
> >
> > Example boot log showing driver probe:
> > [    7.692101] imx-dwmac 428a0000.ethernet eth0:
> >         PHY [stmmac-0:00] driver [MXL86110 Gigabit Ethernet] (irq=POLL)
> >
> > Changes from v1:
> > - Add net-next support
> > - Improved locking management and tests using CONFIG_PROVE_LOCKING
> > - General cleanup
> >
> > Started a new thread
> >
> > Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
>
> Hi Stefano,
>
> Some minor feedback from my side.
>
> ...
>
> > diff --git a/drivers/net/phy/mxl-86110.c b/drivers/net/phy/mxl-86110.c
> > new file mode 100644
> > index 000000000000..63f32c49fcc1
> > --- /dev/null
> > +++ b/drivers/net/phy/mxl-86110.c
> > @@ -0,0 +1,570 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * PHY driver for Maxlinear MXL86110
> > + *
> > + * Copyright 2023 MaxLinear Inc.
> > + *
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/etherdevice.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/phy.h>
> > +
> > +/* PHY ID */
> > +#define PHY_ID_MXL86110              0xc1335580
> > +
> > +/* required to access extended registers */
> > +#define MXL86110_EXTD_REG_ADDR_OFFSET        0x1E
> > +#define MXL86110_EXTD_REG_ADDR_DATA          0x1F
> > +#define PHY_IRQ_ENABLE_REG                           0x12
> > +#define PHY_IRQ_ENABLE_REG_WOL                       BIT(6)
> > +
> > +/* SyncE Configuration Register - COM_EXT SYNCE_CFG */
> > +#define MXL86110_EXT_SYNCE_CFG_REG                                           0xA012
>
> For Networking code, please restrict lines to no more than 80 columns
> wide where you can do so without reducing readability (I'd say that is the
> case here.
>
> Likewise elsewhere in this patch.
>
> checkpatch.pl --max-line-length=80 can be helpful here.
>
> ...
>
> > +/**
> > + * mxl86110_write_extended_reg() - write to a PHY's extended register
> > + * @phydev: pointer to a &struct phy_device
> > + * @regnum: register number to write
> > + * @val: value to write to @regnum
> > + *
> > + * NOTE: This function assumes the caller already holds the MDIO bus lock
> > + * or otherwise has exclusive access to the PHY.
> > + *
> > + * returns 0 or negative error code
> > + */
>
> Tooling expects 'Return:' or 'Returns: ' to document return values.
>
> Likewise elsewhere in this patch.
>
> Flagged by ./scripts/kernel-doc -Wall -none
>
> ...
>
> > +static int mxl86110_led_hw_control_get(struct phy_device *phydev, u8 index,
> > +                                    unsigned long *rules)
> > +{
> > +     u16 val;
> > +
> > +     if (index >= MXL86110_MAX_LEDS)
> > +             return -EINVAL;
> > +
> > +     phy_lock_mdio_bus(phydev);
> > +     val = mxl86110_read_extended_reg(phydev, MXL86110_LED0_CFG_REG + index);
> > +     phy_unlock_mdio_bus(phydev);
> > +     if (val < 0)
> > +             return val;
>
> val is unsigned. It cannot be less than zero.
>
> Likewise in mxl86110_broadcast_cfg() and mxl86110_enable_led_activity_blink().
>
> Flagged by Smatch.
>
> ...

