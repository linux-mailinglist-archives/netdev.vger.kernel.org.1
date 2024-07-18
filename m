Return-Path: <netdev+bounces-112102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE65934F81
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 16:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0B72846B0
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 14:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1FF14372D;
	Thu, 18 Jul 2024 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="c3oFESqr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E25C13D62E
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721314783; cv=none; b=ZBDaJnABqZpZ0HXwNpKK85QrOpg4vWffQ3a84gkt2d918i5v0OGHt2Y1gOanAWHPd3G7uhhbJGo1r70nNCH/Z4KxkTBBurVUKfTU+OBmiK9eDtQBcFtnjh/F/4g5sbzCqErSUyP4UVrpMsSagqMKaRvAlCcs/Z4A6MEjudO+ocw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721314783; c=relaxed/simple;
	bh=/lfpN5EoMAM1DxwHMutBLkYkvMI9n6g/aYr3+0S3zAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V1bY4WSrttHNUUUGagh5oUd9KzAemOiGewSlHNnQWjcMwJ/UuO/WMKpLO/Bzw2ep8s4wibC8DpMSJfXPPulfpJ6bW5vZbYwBJ7tCo9+4Ma8goSGwDg9UbzAqL8VZCjiunG4dylCuUdFNxOkp9JLKOgxalfGhG5JdOF2VwY3krCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=c3oFESqr; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eedea0fd88so11919301fa.2
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 07:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1721314780; x=1721919580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IS2XPxAhb1UEBSP+fZ8iwovLxqefX/a7eIMHhvFU+54=;
        b=c3oFESqro5O3+8tzwzMfXj4tEmGm3oasas5mu0olNCo3/haaolLYwBuK4B6tl4StR1
         T3JECR888lDw1tgOwpG2HblAPgDwzSdzdSwFUnfc3jdqsaOvEMaCkRrLEnye/un/Y3pT
         hfPlPEKLiVPjJoGg38nKMDxivBQC3oxJnTD20o1PVi/TrWX8zUx1BGH8JSwXcoT17wZv
         cxHhgG8K/SdUQJb2xNjH+T9zpDIJ4yn5tttwnCGVEuA+2nKbaqDo7RKO938L+zOPYgKu
         WSUdASxNPalwiazQf+3dS5r7Y0A3sZuXVg6CQ+JBpejOw8S296+pT6P3/Mabf92yuepd
         Cz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721314780; x=1721919580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IS2XPxAhb1UEBSP+fZ8iwovLxqefX/a7eIMHhvFU+54=;
        b=nUAqY7Z8lFY/VOi/F4hHSZpYU8TkINcJgmd8v66lyIOvNBnoif14FpsqvUdoJwLbn7
         sGy5PKeImICIElfqP/UthOMWlk55MDxUkX1cUfVthKPYlRTnqmd9iEYTZYAqiexigqkW
         TH345AXSABKvdOmMLhVb0dL75hUcTp/Dyi57z4d8t6nGymxdupj+bp+h2FZTHT9ZQ7Xw
         Syt7bEkY2H09Hdxt8vAGb+1bMU/9HhhL3CyMuBJ8qo2EwpaDA2YfIwToODb5JkU4lK8/
         x2W0+/zec+d8MAU5/3yrQ1Mp4v/aLCKwr8Oz3ofaRqBILQXHB5jU9c05+RJ9lCqFDj6R
         9oIw==
X-Forwarded-Encrypted: i=1; AJvYcCVKKdhYZ9Vk4o63q8E2cc/mH9H5gyo9jrU3QW7JmRLnMpon2Mi2iCxRMMz+L8U6RdRO5ocNTzYpSI2DZdezg1mdcZPAcuR1
X-Gm-Message-State: AOJu0YyUnhzAk+0eH3kY5cv8fy/yxQH1cBp/CCib6tcmALGxrJWfHvfX
	GjO8eVf3WCCZxBj+yQ8D7JcEvVDh7FF39jEmdgHnv+teq/X2CZt2b8uup/RKG/44bLwwDB/+ctO
	rJwc3oUZoRQwEoZWSvjyy50g3zc9HtibEtmRZhg==
X-Google-Smtp-Source: AGHT+IFTtbmcFSHK6NkjcGm+PZakw75WFUIDDgC0cgwuJQEFkFs1GUEjyx4pbok7HtLW+y4xBKKX2/OTqa+ZYUUHsSo=
X-Received: by 2002:a2e:940c:0:b0:2ea:91cf:a5f0 with SMTP id
 38308e7fff4ca-2ef05c79ef9mr19133941fa.19.1721314779650; Thu, 18 Jul 2024
 07:59:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708075023.14893-1-brgl@bgdev.pl> <20240708075023.14893-4-brgl@bgdev.pl>
 <7c0140be-4325-4005-9068-7e0fc5ff344d@nvidia.com> <CAMRc=McF93F6YsQ+eT9oOe+c=2ZCQ3rBdj+-3Ruy8iO1B-syjw@mail.gmail.com>
 <CAMRc=Mc=8Sa76TOZujMMZcaF2Dc8OL_HKo=gXuj-YALaH4zKHg@mail.gmail.com>
 <6e12f5a5-8007-4ddc-a5ad-be556656af71@nvidia.com> <CAMRc=MdvsKeYEEvf2w3RxPiR=yLFXDwesiQ75JHTU-YEpkF-ZA@mail.gmail.com>
 <874f68e3-a5f4-4771-9d40-59d2efbf2693@nvidia.com>
In-Reply-To: <874f68e3-a5f4-4771-9d40-59d2efbf2693@nvidia.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 18 Jul 2024 16:59:27 +0200
Message-ID: <CAMRc=MeKdg-MnO_kNkgpwbuSgL0mfAw8HveGFKFwUeNd6379bQ@mail.gmail.com>
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

On Thu, Jul 18, 2024 at 4:49=E2=80=AFPM Jon Hunter <jonathanh@nvidia.com> w=
rote:
>
>
> On 18/07/2024 15:13, Bartosz Golaszewski wrote:
> > On Thu, Jul 18, 2024 at 4:08=E2=80=AFPM Jon Hunter <jonathanh@nvidia.co=
m> wrote:
> >>
> >>
> >> On 18/07/2024 14:29, Bartosz Golaszewski wrote:
> >>> On Thu, Jul 18, 2024 at 3:04=E2=80=AFPM Bartosz Golaszewski <brgl@bgd=
ev.pl> wrote:
> >>>>
> >>>> On Thu, Jul 18, 2024 at 2:23=E2=80=AFPM Jon Hunter <jonathanh@nvidia=
.com> wrote:
> >>>>>
> >>>>>
> >>>>> With the current -next and mainline we are seeing the following iss=
ue on
> >>>>> our Tegra234 Jetson AGX Orin platform ...
> >>>>>
> >>>>>     Aquantia AQR113C stmmac-0:00: aqr107_fill_interface_modes faile=
d: -110
> >>>>>     tegra-mgbe 6800000.ethernet eth0: __stmmac_open: Cannot attach =
to PHY (error: -110)
> >>>>>
> >>>>>
> >>>>> We have tracked it down to this change and looks like our PHY does =
not
> >>>>> support 10M ...
> >>>>>
> >>>>> $ ethtool eth0
> >>>>> Settings for eth0:
> >>>>>            Supported ports: [  ]
> >>>>>            Supported link modes:   100baseT/Full
> >>>>>                                    1000baseT/Full
> >>>>>                                    10000baseT/Full
> >>>>>                                    1000baseKX/Full
> >>>>>                                    10000baseKX4/Full
> >>>>>                                    10000baseKR/Full
> >>>>>                                    2500baseT/Full
> >>>>>                                    5000baseT/Full
> >>>>>
> >>>>> The following fixes this for this platform ...
> >>>>>
> >>>>> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net=
/phy/aquantia/aquantia_main.c
> >>>>> index d12e35374231..0b2db486d8bd 100644
> >>>>> --- a/drivers/net/phy/aquantia/aquantia_main.c
> >>>>> +++ b/drivers/net/phy/aquantia/aquantia_main.c
> >>>>> @@ -656,7 +656,7 @@ static int aqr107_fill_interface_modes(struct p=
hy_device *phydev)
> >>>>>            int i, val, ret;
> >>>>>
> >>>>>            ret =3D phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1=
,
> >>>>> -                                       VEND1_GLOBAL_CFG_10M, val, =
val !=3D 0,
> >>>>> +                                       VEND1_GLOBAL_CFG_100M, val,=
 val !=3D 0,
> >>>>>                                            1000, 100000, false);
> >>>>>            if (ret)
> >>>>>                    return ret;
> >>>>>
> >>>>>
> >>>>> However, I am not sure if this is guaranteed to work for all?
> >>>>
> >>>> Ah cr*p. No, I don't think it is. We should take the first supported
> >>>> mode for a given PHY I think.
> >>>>
> >>>
> >>> TBH I only observed the issue on AQR115C. I don't have any other mode=
l
> >>> to test with. Is it fine to fix it by implementing
> >>> aqr115_fill_interface_modes() that would first wait for this register
> >>> to return non-0 and then call aqr107_fill_interface_modes()?
> >>
> >> I am doing a bit more testing. We have seen a few issues with this PHY
> >> driver and so I am wondering if we also need something similar for the
> >> AQR113C variant too.
> >>
> >> Interestingly, the product brief for these PHYs [0] do show that both
> >> the AQR113C and AQR115C both support 10M. So I wonder if it is our
> >> ethernet controller that is not supporting 10M? I will check on this t=
oo.
> >>
> >
> > Oh you have an 113c? I didn't get this. Yeah, weird, all docs say it
> > should support 10M. In fact all AQR PHYs should hence my initial
> > change.
>
>
> Yes we have an AQR113C. I agree it should support this, but for whatever
> reason this is not advertised. I do see that 10M is advertised as
> supported by the network ...
>
>   Link partner advertised link modes:  10baseT/Half 10baseT/Full
>                                        100baseT/Half 100baseT/Full
>                                        1000baseT/Full
>
> My PC that is on the same network supports 10M, but just not this Tegra
> device. I am checking to see if this is expected for this device.
>

I sent a patch for you to test. I think that even if it doesn't fully
fix the issue you're observing, it's worth picking it up as it reduces
the impact of the workaround I introduced.

I'll be off next week so I'm sending it quickly with the hope it will be us=
eful.

Bart

