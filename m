Return-Path: <netdev+bounces-112096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B216934EF6
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 16:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB86CB236BC
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 14:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AF114037F;
	Thu, 18 Jul 2024 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="i62v8n27"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4A280BFC
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721312053; cv=none; b=erjFCWi2eqWeXtfYCZuaDul7+Qbqm+CL5Zf0qwrvrf2Ru4cXoM7cwshVV3iEsnNZYIc5ao+0stnCWguCgZKKizcKAIEj0vMpUZbv+/vGA67flUVC0I1oCm2OUcReEDMTGu0bDXdVjp4unHL6ZPu85vDAwMEvylWv5YjMUFnYsLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721312053; c=relaxed/simple;
	bh=rYwpk6s2aA8ZaW64DEjhw3d8KkxHYtZFWh2w7miHsMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jij0wUWJ7P3G8ez2T33wgh9QqW2YlS3agqx0Do3I7NjtGkJhRRzUAyCtFZnzsvDkKxNUoPqdIDka+gp6ePSF46hrQwtwOCT6RxaxZSxn8+ilLXdzI+UubR5CpgAM9eJrBKjm4bf5rBObEiyhY17fQbKWCTGDzSeK/uz/7aX6cdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=i62v8n27; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ee91d9cb71so10043941fa.0
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 07:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1721312050; x=1721916850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwa/FUqGTiwfCXFjYhMYhkkWQN1Udk6UTjtKmVq4fKU=;
        b=i62v8n27rHqSgdenH9Ii5Hd9FaVDBMIBAbVf9t1kUGs8w5xEqwlJ+lqIUnEiQPuO0e
         bWDt7kG4VQKSTgX3gl2RSpfDezRSrbvq2hm58VbxAO+Fx8zChkv7Si8k/qzLXdVQ/Lem
         8Xgtniuaoclpg/j98jWreRsd7X9KUGJS9AacX9dJCB5EOGET4Ew4BF63QQVY1c/ZuThX
         NYZSMmFMU3aqKLDmLwWVgSkl+hRk7BSCb89WsfI0e+6xwRKekc6xJC4+/ymZ+MZqEu3y
         pQpCiwKB4cazLx4VvnlyCHuTwJZxwMyNk29UqTLInTdz5NltbVNZ7irr46XDQtAv9ds5
         tP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721312050; x=1721916850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwa/FUqGTiwfCXFjYhMYhkkWQN1Udk6UTjtKmVq4fKU=;
        b=dMx+T+8Yb1YvaG7ONs3AIiT7bXNxLtXDPd35vMgkhTFmpHqz8bx7IymqYT2EOhK8DS
         Nu+vbwNBx0EU/jwy2YBBjnzwPKITzkQf8aoJjnexOArkc2Uj6jtoH5YwTFQlUSaPqe73
         p9ik4EFI4VYQw4rqF0agMKofvfmnfx6PeQN2JUPewyN5hBCUA9TEzCMxhrE2u+M+dxj/
         PL/cz47Sjga8i7CePIOmqKELWtEhLGMwzUdPBCctpnEDz0JhPXBYNpXfME3We+maYy8e
         KoE/4ZiN7pY3khgDRyn1W3u1ENtqYJW8fItl585+9dvqS3dfqwcQa+/uYbv86iaz7cZo
         fVwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSyPyOu/L3e323uUyzPyU8p1peu8oslt2QR6tF7HHDuZzyhc75rQPkeugPeEGK1pparlUJxQ4H5siFDS0adsqomc5Z74/N
X-Gm-Message-State: AOJu0Yy7PHiS6Vipqg0KIKQtCDZqFvJr91zjMyB3hQELfeBAy03gwp+2
	AKgEuEbp4CUdmVMVhafR3kgWV/lzrR+y+b5VkpGdVMgmncqTpfdNFM+gg+3BkRa8MptVq8I59xI
	EiwHlX0v2tNInMhOGeP9h07fZHSe4biJj/GOUoA==
X-Google-Smtp-Source: AGHT+IFVNqh/Ic+HGgiTUP80uh/xt5qB6Maa3HQuATJzOmnrapkD+TnATl8wZg505uKzpIjbkG0XUm3KWjSHRIG+r7I=
X-Received: by 2002:a05:651c:153:b0:2ee:88d8:e807 with SMTP id
 38308e7fff4ca-2ef05c78c57mr16981821fa.16.1721312049997; Thu, 18 Jul 2024
 07:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708075023.14893-1-brgl@bgdev.pl> <20240708075023.14893-4-brgl@bgdev.pl>
 <7c0140be-4325-4005-9068-7e0fc5ff344d@nvidia.com> <CAMRc=McF93F6YsQ+eT9oOe+c=2ZCQ3rBdj+-3Ruy8iO1B-syjw@mail.gmail.com>
 <CAMRc=Mc=8Sa76TOZujMMZcaF2Dc8OL_HKo=gXuj-YALaH4zKHg@mail.gmail.com> <6e12f5a5-8007-4ddc-a5ad-be556656af71@nvidia.com>
In-Reply-To: <6e12f5a5-8007-4ddc-a5ad-be556656af71@nvidia.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 18 Jul 2024 16:13:58 +0200
Message-ID: <CAMRc=MdvsKeYEEvf2w3RxPiR=yLFXDwesiQ75JHTU-YEpkF-ZA@mail.gmail.com>
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

On Thu, Jul 18, 2024 at 4:08=E2=80=AFPM Jon Hunter <jonathanh@nvidia.com> w=
rote:
>
>
> On 18/07/2024 14:29, Bartosz Golaszewski wrote:
> > On Thu, Jul 18, 2024 at 3:04=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev=
.pl> wrote:
> >>
> >> On Thu, Jul 18, 2024 at 2:23=E2=80=AFPM Jon Hunter <jonathanh@nvidia.c=
om> wrote:
> >>>
> >>>
> >>> With the current -next and mainline we are seeing the following issue=
 on
> >>> our Tegra234 Jetson AGX Orin platform ...
> >>>
> >>>    Aquantia AQR113C stmmac-0:00: aqr107_fill_interface_modes failed: =
-110
> >>>    tegra-mgbe 6800000.ethernet eth0: __stmmac_open: Cannot attach to =
PHY (error: -110)
> >>>
> >>>
> >>> We have tracked it down to this change and looks like our PHY does no=
t
> >>> support 10M ...
> >>>
> >>> $ ethtool eth0
> >>> Settings for eth0:
> >>>           Supported ports: [  ]
> >>>           Supported link modes:   100baseT/Full
> >>>                                   1000baseT/Full
> >>>                                   10000baseT/Full
> >>>                                   1000baseKX/Full
> >>>                                   10000baseKX4/Full
> >>>                                   10000baseKR/Full
> >>>                                   2500baseT/Full
> >>>                                   5000baseT/Full
> >>>
> >>> The following fixes this for this platform ...
> >>>
> >>> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/p=
hy/aquantia/aquantia_main.c
> >>> index d12e35374231..0b2db486d8bd 100644
> >>> --- a/drivers/net/phy/aquantia/aquantia_main.c
> >>> +++ b/drivers/net/phy/aquantia/aquantia_main.c
> >>> @@ -656,7 +656,7 @@ static int aqr107_fill_interface_modes(struct phy=
_device *phydev)
> >>>           int i, val, ret;
> >>>
> >>>           ret =3D phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
> >>> -                                       VEND1_GLOBAL_CFG_10M, val, va=
l !=3D 0,
> >>> +                                       VEND1_GLOBAL_CFG_100M, val, v=
al !=3D 0,
> >>>                                           1000, 100000, false);
> >>>           if (ret)
> >>>                   return ret;
> >>>
> >>>
> >>> However, I am not sure if this is guaranteed to work for all?
> >>
> >> Ah cr*p. No, I don't think it is. We should take the first supported
> >> mode for a given PHY I think.
> >>
> >
> > TBH I only observed the issue on AQR115C. I don't have any other model
> > to test with. Is it fine to fix it by implementing
> > aqr115_fill_interface_modes() that would first wait for this register
> > to return non-0 and then call aqr107_fill_interface_modes()?
>
> I am doing a bit more testing. We have seen a few issues with this PHY
> driver and so I am wondering if we also need something similar for the
> AQR113C variant too.
>
> Interestingly, the product brief for these PHYs [0] do show that both
> the AQR113C and AQR115C both support 10M. So I wonder if it is our
> ethernet controller that is not supporting 10M? I will check on this too.
>

Oh you have an 113c? I didn't get this. Yeah, weird, all docs say it
should support 10M. In fact all AQR PHYs should hence my initial
change.

Bart

> Jon
>
> [0]
> https://www.marvell.com/content/dam/marvell/en/public-collateral/transcei=
vers/marvell-phys-transceivers-aqrate-gen4-product-brief.pdf
>
>
> --
> nvpublic

