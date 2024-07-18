Return-Path: <netdev+bounces-112076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F365A934DBE
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 15:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72E521F23CC2
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 13:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D33613BAC5;
	Thu, 18 Jul 2024 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ZODvij7E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0525F13B587
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 13:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721307856; cv=none; b=gtL2O2IM5PTVdlbqshO6j4Ws0G8NYvwoudzZVvLvRD7eGy3UGtRQn0XAfFLnolZsjWd73LJHssvTEQhprndr7WDnQCyUT2L1qEMIvAAOmFFGRBtGsfBRDPREUVUlB7u9VMXRhsScYS3MUJ5v8MYWHFoqgebXILgT7WvSKVdZaqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721307856; c=relaxed/simple;
	bh=we2441mJ200UsbwMeH+W6qEctdwpO8gZRiXzNVf4FV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bdr4P2xkb66EyTRU/LJDyvcsohwp25NaQULHOH0CfbbpSCGRcEHEI9FmeV4NdA0JejdjHLCmuuhx3v1xflrq+Ten1mjr1UUvvXzOyMl93rFQWYTxPfcd/5eJM+EjQoVy2XH1GdkDiuRolzwKDhn9F7dwZGs0TGuvcZvcy9bfiSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ZODvij7E; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eeef45d865so10674951fa.0
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 06:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1721307852; x=1721912652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PaoSB/i75fBgDQfjxZ/xBZj8r8hOjb3uHVg3ton7t7o=;
        b=ZODvij7E/PWDZRp8JxanPSE+4q0iUruBGtwg1nWQlDEP5GPQIf4KIroQydbRtQ15ZH
         JWUQXBaddQaciHGn0rThwfoAUtsXmM2GoIPy8ksk+cb0IqX3uNYUd/EL1qK5cd66XfFK
         vBW2PDF3arH28nPjPUcokCbDO86IWtBclsYkWHaFJTjN45apeI9l0EGuRAUfv3lCMI2U
         vjSeuRTbljh6ogLPtfBmme+vETyO06lDSb4h9rk0euqk3Qf1+Z0zEgjPC6lFFo77sTQQ
         QR3HdxjY8DuBL+BExYsqY3q1/1IrXJO+1L/QUfxtlEop3LILu7qPMf2o/59aRYAISD0B
         Ot4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721307852; x=1721912652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PaoSB/i75fBgDQfjxZ/xBZj8r8hOjb3uHVg3ton7t7o=;
        b=nG+OGkk/Xlgzz98RyobE07h57zvG2jQpOmqK/OuF5YiiIL7G3pnL2CLmMa7IeWHfiF
         Tn+/U3d62js/Z5oMUHpS6e1k5SC2jjKzzHjN4uYZnwRoeqHd8q8g6E3XVwUb1MZvfEYb
         ShcS5swwTzf80zxkJl1mRWqB7ZzFe5L2G/nDMwnH6NyKIoaa8rLbAIU3IsRFCOl7CmVu
         nVZEzwksYtSymLVQvSK5TBQ3TLbAos+5CxmoL7QbSCCVTfxHzysth0dU/vXyXPpzCLwC
         +QpdQA1/XVXv9uJBgVMYTKuvuSbMH7YNagRgctgiyq6Tgyxc2w1Od56m/nZGPuH4HMcM
         y/lg==
X-Forwarded-Encrypted: i=1; AJvYcCUaZ/Tvy1+R4XKf5FxDJD5z3ZqJsOHVqyuN5iicd99hg0ri0/qT16kFetOfUPj8Y7bp4eLQ/MD6S7bR/AjbXXFWp9O4IkzB
X-Gm-Message-State: AOJu0YyziO5WYliDp/0/YkYjDI4H5OZvBM1eqEs6Wgyy4oq8IokS16sw
	KdOr1QNZCBJ2kCxAPgVpdbsiMtcXdhiVyVEfBodCxlCSEvbRDN1I/6ic0lqxuNPsvlAV+sFzpk4
	dVUrhUeuLSKXpvVmDamVCp/6B5ZSS2Zl9WuZjvI3H8Bcd2xGV
X-Google-Smtp-Source: AGHT+IFdeMEc5qNFLBDKGp+G046kUIHhNXX2IhpfOE33oX22Xj+JyHbPKQLwME12ysWlC6x7Y2Tkkh0PP0R+QhfKifQ=
X-Received: by 2002:a2e:2c12:0:b0:2ee:8d9a:811a with SMTP id
 38308e7fff4ca-2ef05d288f9mr19213711fa.31.1721307851931; Thu, 18 Jul 2024
 06:04:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708075023.14893-1-brgl@bgdev.pl> <20240708075023.14893-4-brgl@bgdev.pl>
 <7c0140be-4325-4005-9068-7e0fc5ff344d@nvidia.com>
In-Reply-To: <7c0140be-4325-4005-9068-7e0fc5ff344d@nvidia.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 18 Jul 2024 15:04:00 +0200
Message-ID: <CAMRc=McF93F6YsQ+eT9oOe+c=2ZCQ3rBdj+-3Ruy8iO1B-syjw@mail.gmail.com>
Subject: Re: [RESEND PATCH net-next v3 3/4] net: phy: aquantia: wait for the
 GLOBAL_CFG to start returning real values
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Brad Griffis <bgriffis@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 2:23=E2=80=AFPM Jon Hunter <jonathanh@nvidia.com> w=
rote:
>
> Hi Bartosz,
>
> On 08/07/2024 08:50, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > When the PHY is first coming up (or resuming from suspend), it's
> > possible that although the FW status shows as running, we still see
> > zeroes in the GLOBAL_CFG set of registers and cannot determine availabl=
e
> > modes. Since all models support 10M, add a poll and wait the config to
> > become available.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >   drivers/net/phy/aquantia/aquantia_main.c | 8 +++++++-
> >   1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy=
/aquantia/aquantia_main.c
> > index 974795bd0860..2c8ba2725a91 100644
> > --- a/drivers/net/phy/aquantia/aquantia_main.c
> > +++ b/drivers/net/phy/aquantia/aquantia_main.c
> > @@ -652,7 +652,13 @@ static int aqr107_fill_interface_modes(struct phy_=
device *phydev)
> >       unsigned long *possible =3D phydev->possible_interfaces;
> >       unsigned int serdes_mode, rate_adapt;
> >       phy_interface_t interface;
> > -     int i, val;
> > +     int i, val, ret;
> > +
> > +     ret =3D phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
> > +                                     VEND1_GLOBAL_CFG_10M, val, val !=
=3D 0,
> > +                                     1000, 100000, false);
> > +     if (ret)
> > +             return ret;
> >
> >       /* Walk the media-speed configuration registers to determine whic=
h
> >        * host-side serdes modes may be used by the PHY depending on the
>
>
> With the current -next and mainline we are seeing the following issue on
> our Tegra234 Jetson AGX Orin platform ...
>
>   Aquantia AQR113C stmmac-0:00: aqr107_fill_interface_modes failed: -110
>   tegra-mgbe 6800000.ethernet eth0: __stmmac_open: Cannot attach to PHY (=
error: -110)
>
>
> We have tracked it down to this change and looks like our PHY does not
> support 10M ...
>
> $ ethtool eth0
> Settings for eth0:
>          Supported ports: [  ]
>          Supported link modes:   100baseT/Full
>                                  1000baseT/Full
>                                  10000baseT/Full
>                                  1000baseKX/Full
>                                  10000baseKX4/Full
>                                  10000baseKR/Full
>                                  2500baseT/Full
>                                  5000baseT/Full
>
> The following fixes this for this platform ...
>
> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/a=
quantia/aquantia_main.c
> index d12e35374231..0b2db486d8bd 100644
> --- a/drivers/net/phy/aquantia/aquantia_main.c
> +++ b/drivers/net/phy/aquantia/aquantia_main.c
> @@ -656,7 +656,7 @@ static int aqr107_fill_interface_modes(struct phy_dev=
ice *phydev)
>          int i, val, ret;
>
>          ret =3D phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
> -                                       VEND1_GLOBAL_CFG_10M, val, val !=
=3D 0,
> +                                       VEND1_GLOBAL_CFG_100M, val, val !=
=3D 0,
>                                          1000, 100000, false);
>          if (ret)
>                  return ret;
>
>
> However, I am not sure if this is guaranteed to work for all?

Ah cr*p. No, I don't think it is. We should take the first supported
mode for a given PHY I think.

>
> On a related note, we had also found an issue with this PHY where
> the PHY reset is not working quite correctly. What we see is that
> when polling for the firmware ID in aqr107_wait_reset_complete()
> is that value in the firware ID registers transitions from 0 to
> 0xffff and then to the firmware ID. We have been testing the
> following change to fix this ...
>
> diff --git a/drivers/net/phy/aquantia/aquantia.h b/drivers/net/phy/aquant=
ia/aquantia.h
> index 2465345081f8..278e3b167c58 100644
> --- a/drivers/net/phy/aquantia/aquantia.h
> +++ b/drivers/net/phy/aquantia/aquantia.h
> @@ -20,6 +20,7 @@
>   #define VEND1_GLOBAL_FW_ID                     0x0020
>   #define VEND1_GLOBAL_FW_ID_MAJOR               GENMASK(15, 8)
>   #define VEND1_GLOBAL_FW_ID_MINOR               GENMASK(7, 0)
> +#define VEND1_GLOBAL_FW_ID_MASK                        GENMASK(15, 0)
>
>   #define VEND1_GLOBAL_MAILBOX_INTERFACE1                        0x0200
>   #define VEND1_GLOBAL_MAILBOX_INTERFACE1_EXECUTE                BIT(15)
> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/a=
quantia/aquantia_main.c
> index 0b2db486d8bd..5023fd70050d 100644
> --- a/drivers/net/phy/aquantia/aquantia_main.c
> +++ b/drivers/net/phy/aquantia/aquantia_main.c
> @@ -447,7 +447,9 @@ int aqr_wait_reset_complete(struct phy_device *phydev=
)
>          int val;
>
>          return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
> -                                        VEND1_GLOBAL_FW_ID, val, val !=
=3D 0,
> +                                        VEND1_GLOBAL_FW_ID, val,
> +                                        ((val & VEND1_GLOBAL_FW_ID_MASK)=
 !=3D 0 &&
> +                                        (val & VEND1_GLOBAL_FW_ID_MASK) =
!=3D VEND1_GLOBAL_FW_ID_MASK),
>                                           20000, 2000000, false);
>   }
>
> I have not tried the resume use-case, but curious if this may
> also help here?
>

Interesting. Unfortunately this doesn't help with the suspend/resume
use-case if I revert my offending patch.

Bart

> Cheers
> Jon
>
> --
> nvpublic

