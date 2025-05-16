Return-Path: <netdev+bounces-191003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1893AB9A69
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 12:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1A218967D7
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 10:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5829821B9D8;
	Fri, 16 May 2025 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWvzXFCU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ABA13790B;
	Fri, 16 May 2025 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747392410; cv=none; b=KqVQp5UWwB1bqifGS9+e6sS5CgI4Bv919HRaNiakm39yHH8ghUfmxMcZmwnSYuDfWRkHdXXnm1Z7tbbVxeZp8RLnmRhkzR+z4r3QPSusNLX4WKtfbFqnJmdkJMxetlwHPKMKk9+Zo09XYqQWVkZidYuk8bW+zRy+pzX/dd0kqEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747392410; c=relaxed/simple;
	bh=tFYm76bQ12k/iTu5NjAwzsst7skzdKrQWXno9B+zxK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eloHxs72kmbaIi5saSHtsNhb3CB4Ut7NTJcDo4LR8Owat+9FrC2/3vbQmBTSoiL6a8CBwy0Ci9HTAXqaRLdbp+Ka/ulgsXdhLrHtA89YInyvHD2g6mODqAGgGte0ObXiNx2esIIDuetkSr26lNvWjtCJrdhKJmUk/gjjbNIj44c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWvzXFCU; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e78fc91f30dso2063262276.3;
        Fri, 16 May 2025 03:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747392407; x=1747997207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+amdIplZGhwOJIfpsdOrPETTeI1FlpIoyQb/HeXhCXg=;
        b=TWvzXFCUmMwMIfM/yVu13SdBmMzfWSaUdA8fzGd1bu5FsTFJHrK3yTSuC+HTDKTdL1
         vOHCgJINyu38FOClM27v9yXZLu/zuMYSrXnw02rtivnIWNuPYmvbd+gemjnKjPig71gX
         P+RgP7QAHmzMUKTYzWTk1jRYV5hDlP8hZCyFHDW0Jt/SHPuv0WuxBCTbES2jHVsnuxob
         5zIALocnHqXMd9QlZgOwB5S9CCVNjSqm+DfsWqcvsJSy8HApPrxKk3hsTd5gQZWntSun
         jTdLwbNoFh8GGYqdLtCRomaF/6B0v6ljHKQBF9RERMnuluEzUAOuTwalo/HC3P8Fj1z1
         XH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747392407; x=1747997207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+amdIplZGhwOJIfpsdOrPETTeI1FlpIoyQb/HeXhCXg=;
        b=iRhjZfJHLVGRM02XgM5CWtLqB3hOeQTP+E/MWtUjhFYvQk2SDVrxpyfQ3FHAMLdR46
         4n54AcbqZRtCJvgDDMce4wmZ8c/GVnLLkXmcNr3rJHijlB8z4CdCMuUEj/dp0ZX2YYVn
         U7MqwZ2OZNU085LQWlNyhPIRpwohT6zpb0sfBZXib4i7+pJDQZ8qlNWjiY0SML4PKTeA
         rB552F00Nv3QZnnrQEL4N8d46yMF2xgL0/hb4aM/2nwwFqv8+lb+zNE13yV6BnkJU9mP
         +R1EqhZROQ/O01EsX1/nnjIl9e1CVhIHKRmRXnwnlILc7fJnflJt4L+1lifjGkoURI/Y
         O9sw==
X-Forwarded-Encrypted: i=1; AJvYcCWH5pukx2UUFE/6ByvZtmdQRK/NVxNwkAzQaI2wlkpDz3QUApbMdgxLzzWyzCh49BzNspf5u1zbMnzghXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnBD7hIf/kNXDu4zD6ZJVFD0UWEpcPzyU421eLmQXGyuSIx72G
	3JYjKc6pgutZ8jHY8tLO/RUG1mbWnjDdoJ4ebapm6rQ6DR7nhoMsjip07lELs/bThD/ZnE6iJut
	Qw43wT76g2zKwj4pDDLrKUqTVoUfxgXs=
X-Gm-Gg: ASbGnctJtJtyZMx1uOlXK3AKmvpikcfiqu7qCBFXcIXxe+4nDf6Igbv5vOQX0b/kWod
	fAVoLOa8N2+8F9CQOMWyu0/oK0ZJ5wcG/LX4L40clmGDKYpht9eQjnB1Ckc5hmquPkjL2AbVamJ
	2UiOBBYP8pA9jWO83yMdcvQA6Idzo20EN7
X-Google-Smtp-Source: AGHT+IHE6tieGe7JiYKubHMXcEpBknmvnnoZ2CZzmBGRQWDUhJBTtw0JrxmZK71rxlfYNVGIOQbzRHFw4lascalXBxA=
X-Received: by 2002:a05:6902:6083:b0:e7b:7001:d814 with SMTP id
 3f1490d57ef6-e7b7001da60mr2162899276.6.1747392406599; Fri, 16 May 2025
 03:46:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515184836.97605-1-stefano.radaelli21@gmail.com> <d1bd7949-6cac-49be-b8d6-1fe06fb9f1c0@gmail.com>
In-Reply-To: <d1bd7949-6cac-49be-b8d6-1fe06fb9f1c0@gmail.com>
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
Date: Fri, 16 May 2025 12:46:35 +0200
X-Gm-Features: AX0GCFsUoGC2dlWGCmkuCzzCoqS5XRumaEYp_28Wbx5fVe4ud_ZZy7NGRgqRYW0
Message-ID: <CAK+owoiqisYnEmubViVuLf_FMXsCR_Tvx4TKm108UoHGbwDfZg@mail.gmail.com>
Subject: Re: [PATCH] net: phy: add driver for MaxLinear MxL86110 PHY
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Xu Liang <lxu@maxlinear.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Heiner,

Thanks for the feedback, I=E2=80=99ll make the requested changes.
Also:

> Why do you do this in probe() and not in config_init()?
> You have to consider that the PHY may be powered off during system suspen=
d.
> So on system resume it may come up with the power-up defaults.

You're right. This logic should be in config_init() to ensure it's
reapplied after suspend/resume.
I=E2=80=99ll move it there and remove the probe() implementation, since it'=
s
no longer needed.

> You can remove these two lines, both functions are the default
> if no callback is set.

Got it, I=E2=80=99ll drop config_aneg, read_status, suspend, and resume,
as the defaults cover these cases correctly.

Best regards,
Stefano

Il giorno gio 15 mag 2025 alle ore 21:15 Heiner Kallweit
<hkallweit1@gmail.com> ha scritto:
>
> On 15.05.2025 20:48, Stefano Radaelli wrote:
> > Add support for the MaxLinear MxL86110 Gigabit Ethernet PHY, a low-powe=
r,
> > cost-optimized transceiver supporting 10/100/1000 Mbps over twisted-pai=
r
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
> >       PHY [stmmac-0:00] driver [MXL86110 Gigabit Ethernet] (irq=3DPOLL)
> >
> > Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
> > ---
> >  MAINTAINERS                 |   1 +
> >  drivers/net/phy/Kconfig     |  12 +
> >  drivers/net/phy/Makefile    |   1 +
> >  drivers/net/phy/mxl-86110.c | 599 ++++++++++++++++++++++++++++++++++++
> >  4 files changed, 613 insertions(+)
> >  create mode 100644 drivers/net/phy/mxl-86110.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3563492e4eba..183077e079a3 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14661,6 +14661,7 @@ MAXLINEAR ETHERNET PHY DRIVER
> >  M:   Xu Liang <lxu@maxlinear.com>
> >  L:   netdev@vger.kernel.org
> >  S:   Supported
> > +F:   drivers/net/phy/mxl-86110.c
> >  F:   drivers/net/phy/mxl-gpy.c
> >
> >  MCAN MMIO DEVICE DRIVER
> > diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> > index d29f9f7fd2e1..885ddddf03bd 100644
> > --- a/drivers/net/phy/Kconfig
> > +++ b/drivers/net/phy/Kconfig
> > @@ -266,6 +266,18 @@ config MAXLINEAR_GPHY
> >         Support for the Maxlinear GPY115, GPY211, GPY212, GPY215,
> >         GPY241, GPY245 PHYs.
> >
> > +config MAXLINEAR_86110_PHY
> > +     tristate "MaxLinear MXL86110 PHY support"
> > +     help
> > +       Support for the MaxLinear MXL86110 Gigabit Ethernet
> > +       Physical Layer transceiver.
> > +       The MXL86110 is commonly used in networking equipment such as
> > +       routers, switches, and embedded systems, providing the
> > +       physical interface for 10/100/1000 Mbps Ethernet connections
> > +       over copper media.
> > +       If you are using a board with the MXL86110 PHY connected to you=
r
> > +       Ethernet MAC, you should enable this option.
> > +
> >  source "drivers/net/phy/mediatek/Kconfig"
> >
> >  config MICREL_PHY
> > diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
> > index 23ce205ae91d..eb0231882834 100644
> > --- a/drivers/net/phy/Makefile
> > +++ b/drivers/net/phy/Makefile
> > @@ -74,6 +74,7 @@ obj-$(CONFIG_MARVELL_10G_PHY)       +=3D marvell10g.o
> >  obj-$(CONFIG_MARVELL_PHY)    +=3D marvell.o
> >  obj-$(CONFIG_MARVELL_88Q2XXX_PHY)    +=3D marvell-88q2xxx.o
> >  obj-$(CONFIG_MARVELL_88X2222_PHY)    +=3D marvell-88x2222.o
> > +obj-$(CONFIG_MAXLINEAR_86110_PHY)    +=3D mxl-86110.o
> >  obj-$(CONFIG_MAXLINEAR_GPHY) +=3D mxl-gpy.o
> >  obj-y                                +=3D mediatek/
> >  obj-$(CONFIG_MESON_GXL_PHY)  +=3D meson-gxl.o
> > diff --git a/drivers/net/phy/mxl-86110.c b/drivers/net/phy/mxl-86110.c
> > new file mode 100644
> > index 000000000000..98d90b88b60f
> > --- /dev/null
> > +++ b/drivers/net/phy/mxl-86110.c
> > @@ -0,0 +1,599 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * PHY driver for Maxlinear MXL86110
> > + *
> > + * Copyright 2023 MaxLinear Inc.
> > + *
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/etherdevice.h>
> > +#include <linux/of.h>
> > +#include <linux/phy.h>
> > +#include <linux/module.h>
> > +#include <linux/bitfield.h>
> > +
> please in alphabetic order
>
> > +#define MXL86110_DRIVER_DESC "MaxLinear MXL86110 PHY driver"
>
> This is used in one place only, so there's not really a benefit.
>
> > +
> > +/* PHY ID */
> > +#define PHY_ID_MXL86110              0xC1335580
>
> with lower-case characters please
>
> > +
> > +/* required to access extended registers */
> > +#define MXL86110_EXTD_REG_ADDR_OFFSET        0x1E
> > +#define MXL86110_EXTD_REG_ADDR_DATA          0x1F
> > +#define PHY_IRQ_ENABLE_REG                           0x12
> > +#define PHY_IRQ_ENABLE_REG_WOL                       BIT(6)
> > +
> > +/* SyncE Configuration Register - COM_EXT SYNCE_CFG */
> > +#define MXL86110_EXT_SYNCE_CFG_REG                                    =
       0xA012
> > +#define MXL86110_EXT_SYNCE_CFG_CLK_FRE_SEL                           B=
IT(4)
> > +#define MXL86110_EXT_SYNCE_CFG_EN_SYNC_E_DURING_LNKDN        BIT(5)
> > +#define MXL86110_EXT_SYNCE_CFG_EN_SYNC_E                             B=
IT(6)
> > +#define MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_MASK                      G=
ENMASK(3, 1)
> > +#define MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_125M_PLL          0
> > +#define MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_25M                       4
> > +
> > +/* WOL registers */
> > +#define MXL86110_WOL_MAC_ADDR_HIGH_EXTD_REG          0xA007 /* high-> =
FF:FF                   */
> > +#define MXL86110_WOL_MAC_ADDR_MIDDLE_EXTD_REG        0xA008 /*    midd=
le-> :FF:FF <-middle    */
> > +#define MXL86110_WOL_MAC_ADDR_LOW_EXTD_REG           0xA009 /*        =
           :FF:FF <-low */
> > +
> > +#define MXL86110_EXT_WOL_CFG_REG                             0xA00A
> > +#define MXL86110_EXT_WOL_CFG_WOLE_MASK                       BIT(3)
> > +#define MXL86110_EXT_WOL_CFG_WOLE_DISABLE            0
> > +#define MXL86110_EXT_WOL_CFG_WOLE_ENABLE             BIT(3)
> > +
> > +/* RGMII register */
> > +#define MXL86110_EXT_RGMII_CFG1_REG                                   =
               0xA003
> > +/* delay can be adjusted in steps of about 150ps */
> > +#define MXL86110_EXT_RGMII_CFG1_RX_NO_DELAY                          (=
0x0 << 10)
> > +/* Closest value to 2000 ps */
> > +#define MXL86110_EXT_RGMII_CFG1_RX_DELAY_1950PS                       =
       (0xD << 10)
> > +#define MXL86110_EXT_RGMII_CFG1_RX_DELAY_MASK                         =
       GENMASK(13, 10)
> > +
> > +#define MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_1950PS                   (=
0xD << 0)
> > +#define MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_MASK                     G=
ENMASK(3, 0)
> > +
> > +#define MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_1950PS           (=
0xD << 4)
> > +#define MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_MASK     GENMASK(7=
, 4)
> > +
> > +#define MXL86110_EXT_RGMII_CFG1_FULL_MASK \
> > +                     ((MXL86110_EXT_RGMII_CFG1_RX_DELAY_MASK) | \
> > +                     (MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_MASK) | \
> > +                     (MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_MASK=
))
> > +
> > +/* EXT Sleep Control register */
> > +#define MXL86110_UTP_EXT_SLEEP_CTRL_REG                               =
       0x27
> > +#define MXL86110_UTP_EXT_SLEEP_CTRL_EN_SLEEP_SW_OFF          0
> > +#define MXL86110_UTP_EXT_SLEEP_CTRL_EN_SLEEP_SW_MASK BIT(15)
> > +
> > +/* RGMII In-Band Status and MDIO Configuration Register */
> > +#define MXL86110_EXT_RGMII_MDIO_CFG                          0xA005
> > +#define MXL86110_EXT_RGMII_MDIO_CFG_EPA0_MASK                        G=
ENMASK(6, 6)
> > +#define MXL86110_EXT_RGMII_MDIO_CFG_EBA_MASK                 GENMASK(5=
, 5)
> > +#define MXL86110_EXT_RGMII_MDIO_CFG_BA_MASK                  GENMASK(4=
, 0)
> > +
> > +#define MXL86110_MAX_LEDS            3
> > +/* LED registers and defines */
> > +#define MXL86110_LED0_CFG_REG 0xA00C
> > +#define MXL86110_LED1_CFG_REG 0xA00D
> > +#define MXL86110_LED2_CFG_REG 0xA00E
> > +
> > +#define MXL86110_LEDX_CFG_TRAFFIC_ACT_BLINK_IND              BIT(13)
> > +#define MXL86110_LEDX_CFG_LINK_UP_FULL_DUPLEX_ON     BIT(12)
> > +#define MXL86110_LEDX_CFG_LINK_UP_HALF_DUPLEX_ON     BIT(11)
> > +#define MXL86110_LEDX_CFG_LINK_UP_TX_ACT_ON                  BIT(10) /=
* LED 0,1,2 default */
> > +#define MXL86110_LEDX_CFG_LINK_UP_RX_ACT_ON                  BIT(9)  /=
* LED 0,1,2 default */
> > +#define MXL86110_LEDX_CFG_LINK_UP_TX_ON                              B=
IT(8)
> > +#define MXL86110_LEDX_CFG_LINK_UP_RX_ON                              B=
IT(7)
> > +#define MXL86110_LEDX_CFG_LINK_UP_1GB_ON                     BIT(6) /*=
 LED 2 default */
> > +#define MXL86110_LEDX_CFG_LINK_UP_100MB_ON                   BIT(5) /*=
 LED 1 default */
> > +#define MXL86110_LEDX_CFG_LINK_UP_10MB_ON                    BIT(4) /*=
 LED 0 default */
> > +#define MXL86110_LEDX_CFG_LINK_UP_COLLISION                  BIT(3)
> > +#define MXL86110_LEDX_CFG_LINK_UP_1GB_BLINK                  BIT(2)
> > +#define MXL86110_LEDX_CFG_LINK_UP_100MB_BLINK                BIT(1)
> > +#define MXL86110_LEDX_CFG_LINK_UP_10MB_BLINK         BIT(0)
> > +
> > +#define MXL86110_LED_BLINK_CFG_REG                                    =
       0xA00F
> > +#define MXL86110_LED_BLINK_CFG_FREQ_MODE1_2HZ                        0
> > +#define MXL86110_LED_BLINK_CFG_FREQ_MODE1_4HZ                        B=
IT(0)
> > +#define MXL86110_LED_BLINK_CFG_FREQ_MODE1_8HZ                        B=
IT(1)
> > +#define MXL86110_LED_BLINK_CFG_FREQ_MODE1_16HZ                       (=
BIT(1) | BIT(0))
> > +#define MXL86110_LED_BLINK_CFG_FREQ_MODE2_2HZ                        0
> > +#define MXL86110_LED_BLINK_CFG_FREQ_MODE2_4HZ                        B=
IT(2)
> > +#define MXL86110_LED_BLINK_CFG_FREQ_MODE2_8HZ                        B=
IT(3)
> > +#define MXL86110_LED_BLINK_CFG_FREQ_MODE2_16HZ                       (=
BIT(3) | BIT(2))
> > +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_50_PERC_ON 0
> > +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_67_PERC_ON (BIT(4))
> > +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_75_PERC_ON (BIT(5))
> > +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_83_PERC_ON (BIT(5) | BIT(4))
> > +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_50_PERC_OFF        (BIT(6))
> > +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_33_PERC_ON (BIT(6) | BIT(4))
> > +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_25_PERC_ON (BIT(6) | BIT(5))
> > +#define MXL86110_LED_BLINK_CFG_DUTY_CYCLE_17_PERC_ON (BIT(6) | BIT(5) =
| BIT(4))
> > +
> > +/* Chip Configuration Register - COM_EXT_CHIP_CFG */
> > +#define MXL86110_EXT_CHIP_CFG_REG                    0xA001
> > +#define MXL86110_EXT_CHIP_CFG_RXDLY_ENABLE   BIT(8)
> > +#define MXL86110_EXT_CHIP_CFG_SW_RST_N_MODE  BIT(15)
> > +
> > +/**
> > + * mxl86110_write_extended_reg() - write to a PHY's extended register
> > + * @phydev: pointer to a &struct phy_device
> > + * @regnum: register number to write
> > + * @val: value to write to @regnum
> > + *
> > + * NOTE: This function assumes the caller already holds the MDIO bus l=
ock
> > + * or otherwise has exclusive access to the PHY. If exclusive access
> > + * cannot be guaranteed, please use mxl86110_locked_write_extended_reg=
()
> > + * which handles locking internally.
> > + *
> > + * returns 0 or negative error code
> > + */
> > +static int mxl86110_write_extended_reg(struct phy_device *phydev, u16 =
regnum, u16 val)
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
> > + * mxl86110_locked_write_extended_reg - Safely write to an extended re=
gister
> > + * @phydev: Pointer to the PHY device structure
> > + * @regnum: Extended register number to write (address written to reg =
30)
> > + * @val: Value to write to the selected extended register (via reg 31)
> > + *
> > + * This function safely writes to an extended register of the MxL86110=
 PHY.
> > + * It acquires the MDIO bus lock before performing the operation using
> > + * the reg 30/31 extended access mechanism.
> > + *
> > + * Use this locked variant when accessing extended registers in contex=
ts
> > + * where concurrent access to the MDIO bus may occur (e.g., from users=
pace
> > + * calls, interrupt context, or asynchronous callbacks like LED trigge=
rs).
> > + * If you are in a context where the MDIO bus is already locked or
> > + * guaranteed exclusive, the non-locked variant can be used.
> > + *
> > + * Return: 0 on success or a negative errno code on failure.
> > + */
> > +static int mxl86110_locked_write_extended_reg(struct phy_device *phyde=
v, u16 regnum,
> > +                                           u16 val)
> > +{
> > +     int ret;
> > +
> > +     phy_lock_mdio_bus(phydev);
> > +     ret =3D mxl86110_write_extended_reg(phydev, regnum, val);
> > +     phy_unlock_mdio_bus(phydev);
> > +     return ret;
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
> > + * NOTE: This function assumes the caller already holds the MDIO bus l=
ock
> > + * or otherwise has exclusive access to the PHY. If exclusive access
> > + * cannot be guaranteed, use mxl86110_locked_read_extended_reg().
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
> > + * mxl86110_locked_read_extended_reg - Safely read from an extended re=
gister
> > + * @phydev: Pointer to the PHY device structure
> > + * @regnum: Extended register number to read (address written to reg 3=
0)
> > + *
> > + * This function safely reads an extended register of the MxL86110 PHY=
.
> > + * It locks the MDIO bus and uses the extended register access mechani=
sm
> > + * via reg 30 (address) and reg 31 (data).
> > + *
> > + * Use this locked variant when accessing extended registers in contex=
ts
> > + * where concurrent access to the MDIO bus may occur (e.g., from users=
pace
> > + * calls, interrupt context, or asynchronous callbacks like LED trigge=
rs).
> > + * If you are in a context where the MDIO bus is already locked or
> > + * guaranteed exclusive, the non-locked variant can be used.
> > + *
> > + * Return: The 16-bit value read from the extended register, or a nega=
tive errno code.
> > + */
> > +static int mxl86110_locked_read_extended_reg(struct phy_device *phydev=
, u16 regnum)
> > +{
> > +     int ret;
> > +
> > +     phy_lock_mdio_bus(phydev);
> > +     ret =3D mxl86110_read_extended_reg(phydev, regnum);
> > +     phy_unlock_mdio_bus(phydev);
> > +
> > +     return ret;
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
> > + * NOTE: register value =3D (old register value & ~mask) | set.
> > + * This function assumes the caller already holds the MDIO bus lock
> > + * or otherwise has exclusive access to the PHY.
> > + *
> > + * returns 0 or negative error code
> > + */
> > +static int mxl86110_modify_extended_reg(struct phy_device *phydev, u16=
 regnum, u16 mask,
> > +                                     u16 set)
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
> > +
> > +/**
> > + * mxl86110_get_wol() - report if wake-on-lan is enabled
> > + * @phydev: pointer to the phy_device
> > + * @wol: a pointer to a &struct ethtool_wolinfo
> > + */
> > +static void mxl86110_get_wol(struct phy_device *phydev, struct ethtool=
_wolinfo *wol)
> > +{
> > +     int value;
> > +
> > +     wol->supported =3D WAKE_MAGIC;
> > +     wol->wolopts =3D 0;
> > +     value =3D mxl86110_locked_read_extended_reg(phydev, MXL86110_EXT_=
WOL_CFG_REG);
> > +     if (value >=3D 0 && (value & MXL86110_EXT_WOL_CFG_WOLE_MASK))
> > +             wol->wolopts |=3D WAKE_MAGIC;
> > +}
> > +
> > +/**
> > + * mxl86110_set_wol() - enable/disable wake-on-lan
> > + * @phydev: pointer to the phy_device
> > + * @wol: a pointer to a &struct ethtool_wolinfo
> > + *
> > + * Configures the WOL Magic Packet MAC
> > + * returns 0 or negative errno code
> > + */
> > +static int mxl86110_set_wol(struct phy_device *phydev, struct ethtool_=
wolinfo *wol)
> > +{
> > +     struct net_device *netdev;
> > +     const u8 *mac;
> > +     int ret =3D 0;
> > +
> > +     if (wol->wolopts & WAKE_MAGIC) {
> > +             netdev =3D phydev->attached_dev;
> > +             if (!netdev)
> > +                     return -ENODEV;
> > +
> > +             /* Configure the MAC address of the WOL magic packet */
> > +             mac =3D (const u8 *)netdev->dev_addr;
> > +             ret =3D mxl86110_write_extended_reg(phydev, MXL86110_WOL_=
MAC_ADDR_HIGH_EXTD_REG,
> > +                                               ((mac[0] << 8) | mac[1]=
));
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             ret =3D mxl86110_write_extended_reg(phydev, MXL86110_WOL_=
MAC_ADDR_MIDDLE_EXTD_REG,
> > +                                               ((mac[2] << 8) | mac[3]=
));
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             ret =3D mxl86110_write_extended_reg(phydev, MXL86110_WOL_=
MAC_ADDR_LOW_EXTD_REG,
> > +                                               ((mac[4] << 8) | mac[5]=
));
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             ret =3D mxl86110_modify_extended_reg(phydev, MXL86110_EXT=
_WOL_CFG_REG,
> > +                                                MXL86110_EXT_WOL_CFG_W=
OLE_MASK,
> > +                                                MXL86110_EXT_WOL_CFG_W=
OLE_ENABLE);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             ret =3D __phy_modify(phydev, PHY_IRQ_ENABLE_REG, 0,
> > +                                PHY_IRQ_ENABLE_REG_WOL);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             phydev_dbg(phydev, "%s, WOL Magic packet MAC: %02X:%02X:%=
02X:%02X:%02X:%02X\n",
> > +                        __func__, mac[0], mac[1], mac[2], mac[3], mac[=
4], mac[5]);
> > +
> > +     } else {
> > +             ret =3D mxl86110_modify_extended_reg(phydev, MXL86110_EXT=
_WOL_CFG_REG,
> > +                                                MXL86110_EXT_WOL_CFG_W=
OLE_MASK,
> > +                                                MXL86110_EXT_WOL_CFG_W=
OLE_DISABLE);
> > +
> > +             ret =3D __phy_modify(phydev, PHY_IRQ_ENABLE_REG,
> > +                                PHY_IRQ_ENABLE_REG_WOL, 0);
> > +             if (ret < 0)
> > +                     return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static const unsigned long supported_triggers =3D (BIT(TRIGGER_NETDEV_=
LINK_10) |
> > +                                              BIT(TRIGGER_NETDEV_LINK_=
100) |
> > +                                              BIT(TRIGGER_NETDEV_LINK_=
1000) |
> > +                                              BIT(TRIGGER_NETDEV_HALF_=
DUPLEX) |
> > +                                              BIT(TRIGGER_NETDEV_FULL_=
DUPLEX) |
> > +                                              BIT(TRIGGER_NETDEV_TX) |
> > +                                              BIT(TRIGGER_NETDEV_RX));
> > +
> > +static int mxl86110_led_hw_is_supported(struct phy_device *phydev, u8 =
index,
> > +                                     unsigned long rules)
> > +{
> > +     if (index >=3D MXL86110_MAX_LEDS)
> > +             return -EINVAL;
> > +
> > +     /* All combinations of the supported triggers are allowed */
> > +     if (rules & ~supported_triggers)
> > +             return -EOPNOTSUPP;
> > +
> > +     return 0;
> > +}
> > +
> > +static int mxl86110_led_hw_control_get(struct phy_device *phydev, u8 i=
ndex,
> > +                                    unsigned long *rules)
> > +{
> > +     u16 val;
> > +
> > +     if (index >=3D MXL86110_MAX_LEDS)
> > +             return -EINVAL;
> > +
> > +     val =3D mxl86110_read_extended_reg(phydev, MXL86110_LED0_CFG_REG =
+ index);
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
> > +             val |=3D MXL86110_LEDX_CFG_TRAFFIC_ACT_BLINK_IND;
> > +
> > +     ret =3D mxl86110_locked_write_extended_reg(phydev, MXL86110_LED0_=
CFG_REG + index, val);
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
> > + * Custom settings can be defined in custom config section of the driv=
er
> > + * returns 0 or negative errno code
> > + */
> > +static int mxl86110_synce_clk_cfg(struct phy_device *phydev)
> > +{
> > +     u16 mask =3D 0, value =3D 0;
> > +     int ret =3D 0;
> > +
> > +     /*
> > +      * Configures the clock output to its default setting as per the =
datasheet.
> > +      * This results in a 25MHz clock output being selected in the
> > +      * COM_EXT_SYNCE_CFG register for SyncE configuration.
> > +      */
> > +     value =3D MXL86110_EXT_SYNCE_CFG_EN_SYNC_E |
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
> > +                                        mask, value);
> > +
> > +     return ret;
> > +}
> > +
> > +/**
> > + * mxl86110_config_init() - initialize the PHY
> > + * @phydev: pointer to the phy_device
> > + *
> > + * returns 0 or negative errno code
> > + */
> > +static int mxl86110_config_init(struct phy_device *phydev)
> > +{
> > +     int ret;
> > +     unsigned int val =3D 0;
> > +     int index;
> > +
> > +     /*
> > +      * RX_CLK delay (RXDLY) enabled via CHIP_CFG register causes a fi=
xed
> > +      * delay of approximately 2 ns at 125 MHz or 8 ns at 25/2.5 MHz.
> > +      * Digital delays in RGMII_CFG1 register are additive
> > +      */
> > +     switch (phydev->interface) {
> > +     case PHY_INTERFACE_MODE_RGMII:
> > +             val =3D 0;
> > +             break;
> > +     case PHY_INTERFACE_MODE_RGMII_RXID:
> > +             val =3D MXL86110_EXT_RGMII_CFG1_RX_DELAY_1950PS;
> > +             break;
> > +     case PHY_INTERFACE_MODE_RGMII_TXID:
> > +             val =3D MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_1950PS |
> > +                     MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_1950P=
S;
> > +             break;
> > +     case PHY_INTERFACE_MODE_RGMII_ID:
> > +             val =3D MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_1950PS |
> > +                     MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_1950P=
S;
> > +             val |=3D MXL86110_EXT_RGMII_CFG1_RX_DELAY_1950PS;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +     ret =3D mxl86110_modify_extended_reg(phydev, MXL86110_EXT_RGMII_C=
FG1_REG,
> > +                                        MXL86110_EXT_RGMII_CFG1_FULL_M=
ASK, val);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     /* Configure RXDLY (RGMII Rx Clock Delay) to disable the default =
additional
> > +      * delay value on RX_CLK (2 ns for 125 MHz, 8 ns for 25 MHz/2.5 M=
Hz)
> > +      * and use just the digital one selected before
> > +      */
> > +     ret =3D mxl86110_modify_extended_reg(phydev, MXL86110_EXT_CHIP_CF=
G_REG,
> > +                                        MXL86110_EXT_CHIP_CFG_RXDLY_EN=
ABLE, 0);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     /*
> > +      * Configure all PHY LEDs to blink on traffic activity regardless=
 of their
> > +      * ON or OFF state. This behavior allows each LED to serve as a p=
ure activity
> > +      * indicator, independently of its use as a link status indicator=
.
> > +      *
> > +      * By default, each LED blinks only when it is also in the ON sta=
te. This function
> > +      * modifies the appropriate registers (LABx fields) to enable bli=
nking even
> > +      * when the LEDs are OFF, to allow the LED to be used as a traffi=
c indicator
> > +      * without requiring it to also serve as a link status LED.
> > +      *
> > +      * NOTE: Any further LED customization can be performed via the
> > +      * /sys/class/led interface; the functions led_hw_is_supported, l=
ed_hw_control_get, and
> > +      * led_hw_control_set are used to support this mechanism.
> > +      */
> > +     for (index =3D 0; index < MXL86110_MAX_LEDS; index++) {
> > +             val =3D mxl86110_read_extended_reg(phydev, MXL86110_LED0_=
CFG_REG + index);
> > +             if (val < 0)
> > +                     return val;
> > +
> > +             val |=3D MXL86110_LEDX_CFG_TRAFFIC_ACT_BLINK_IND;
> > +             ret =3D mxl86110_write_extended_reg(phydev, MXL86110_LED0=
_CFG_REG + index, val);
> > +             if (ret < 0)
> > +                     return ret;
> > +     }
> > +
> > +     /*
> > +      * configures the MDIO broadcast behavior of the MxL86110 PHY.
> > +      * Currently, broadcast mode is explicitly disabled by clearing t=
he EPA0 bit
> > +      * in the RGMII_MDIO_CFG extended register.
> > +      */
> > +     val =3D mxl86110_read_extended_reg(phydev, MXL86110_EXT_RGMII_MDI=
O_CFG);
> > +     if (val < 0)
> > +             return val;
> > +
> > +     val &=3D ~MXL86110_EXT_RGMII_MDIO_CFG_EPA0_MASK;
> > +     ret =3D mxl86110_write_extended_reg(phydev, MXL86110_EXT_RGMII_MD=
IO_CFG, val);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * mxl86110_probe() - read chip config then set suitable reg_page_mode
> > + * @phydev: pointer to the phy_device
> > + *
> > + * returns 0 or negative errno code
> > + */
> > +static int mxl86110_probe(struct phy_device *phydev)
> > +{
> > +     int ret;
> > +
> > +     /* configure syncE / clk output */
> > +     ret =3D mxl86110_synce_clk_cfg(phydev);
>
> Why do you do this in probe() and not in config_init()?
> You have to consider that the PHY may be powered off during system suspen=
d.
> So on system resume it may come up with the power-up defaults.
>
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return 0;
> > +}
> > +
> > +static struct phy_driver mxl_phy_drvs[] =3D {
> > +     {
> > +             PHY_ID_MATCH_EXACT(PHY_ID_MXL86110),
> > +             .name                   =3D "MXL86110 Gigabit Ethernet",
> > +             .probe                  =3D mxl86110_probe,
> > +             .config_init            =3D mxl86110_config_init,
> > +             .config_aneg            =3D genphy_config_aneg,
> > +             .read_status            =3D genphy_read_status,
>
> You can remove these two lines, both functions are the default
> if no callback is set.
>
> > +             .get_wol                =3D mxl86110_get_wol,
> > +             .set_wol                =3D mxl86110_set_wol,
> > +             .suspend                =3D genphy_suspend,
> > +             .resume                 =3D genphy_resume,
> > +             .led_hw_is_supported    =3D mxl86110_led_hw_is_supported,
> > +             .led_hw_control_get     =3D mxl86110_led_hw_control_get,
> > +             .led_hw_control_set     =3D mxl86110_led_hw_control_set,
> > +     },
> > +};
> > +
> > +module_phy_driver(mxl_phy_drvs);
> > +
> > +static const struct mdio_device_id __maybe_unused mxl_tbl[] =3D {
> > +     { PHY_ID_MATCH_EXACT(PHY_ID_MXL86110) },
> > +     {  }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(mdio, mxl_tbl);
> > +
> > +MODULE_DESCRIPTION(MXL86110_DRIVER_DESC);
> > +MODULE_AUTHOR("Stefano Radaelli");
> > +MODULE_LICENSE("GPL");
>

