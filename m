Return-Path: <netdev+bounces-112088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A87AF934E2C
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 15:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5734B282224
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 13:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627C313D61D;
	Thu, 18 Jul 2024 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="S8Bifhxd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE5284DF5
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309413; cv=none; b=GQDB22SJqgYvpJB1tBJoQuexmtQJ2MDVmqLcKuNw/q51+pFM1PbiiqhNnTyhCHsS5jiNZIi/mtQIrP9hSjTtFW81Xx5vZLgGOwFwusE+7e+NgJJo7rLrFq9+vYppUSHneyvM2O5A7D9mIVz9VWkT7ADWIUqn36zXw2GKTaCLBA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309413; c=relaxed/simple;
	bh=6g2JocoVjYFSu+FazwfDkrN2qhaXz++L7gwGS37uF74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eULOOwZLhwsJ/dPHFdVCIyhYLOXlPdIG3HnsGhRxuLNZLkkAJ8QMdlAoOZ262ew4lSS0QThZwi5Or6wapMR2oN4opk0FKOxTCDfsAH8kGAqbEAdlLyTQ89ByeSfKsk5hWhf0hoMs8dGGAJD5wQFs90Z6IawnP+Mje3Va64ojP38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=S8Bifhxd; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eefeab807dso10787721fa.3
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 06:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1721309410; x=1721914210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YT1la3hOSgpRfRsWHpzvZruTBiRkfm0GB/f007d38Pc=;
        b=S8BifhxdTrOJBqtoJOjAEJS9nRWvQXIHP+Rahvw+x3ign9n8WEeiBtU4A7RPyAvpKi
         vuDVqKjWiWLMMu/gH/ko8OgFDFdFbQ5NcuDMCpydSNESqjypHDYu5Nlfa6fMT6/8Q71f
         MA3OdHkBYdSHh8KuBpD8hr/rspRsiAUP3vjuzgruV4T5eaMNEr72ip6rorqvUTj8WmwS
         U+TmoDCcxnmhO3CowEtxD0aGFs4ubupkv0P2PVGwj9Dkvwthks99lwBuzXWAJuf4fcFc
         ZQ/gpSWimk7GwuIr2pAdyc64nt1Z34q4Jo1/5aZmGTYoQ0m2bGDIj5Y/exM3UIl4wAdC
         2D6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721309410; x=1721914210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YT1la3hOSgpRfRsWHpzvZruTBiRkfm0GB/f007d38Pc=;
        b=jXgovpDGUr6o1VFlFGZFDFTDPPpHdhjeZZmiB2aRsjyTuSqDhI70bOCUSE5KSCp5Se
         7rhwToiIv5iTi2hg5v9fl+B5DnmQoG9udb4Z9dv8swrg5qytqvGt6KM3kCFDE+x+dlwM
         k7/uiEpZJQT5moyrqvoBH3A4aWfjn2uBWnPa4/GLDeve0+/yRnh6sRBLxHCA/1glmNHH
         dMVhHYhc+6DHB2iKZCa0dWR+06V8J4q7b/IV4gp1KR8jc5/AWZA3p2rivbhq5weZ5rLq
         1dA+iiTrzsAbo6xGzOxKxXqC5Ka8S8/8v9qTCYdCULCXeYKnGPHvIoTwO1CmaZgOooRH
         0bxg==
X-Forwarded-Encrypted: i=1; AJvYcCVUdGxYgPh47z1aMt0GZ3fwdklG43f4UrWYQQesMn0A0mh1jUYvelIEcOkiVCfFuiTTKX08oph8VjqVSk56BE8w7mlI4w37
X-Gm-Message-State: AOJu0YzgxHXZ1xRr+5RtWvtfek4Q9K4DSPB5Nw+87rZT7lnv1FdY6Cy4
	xNq55owSKIcyGd+PhGIB41esHwI0p47j2gKG7lxedEIf/J/eSneoQsAcbfmzeen3fowpONObqp0
	3tarzkDpI9LPFd1aQ8NdR43dXjbKLWMXjipjLdQ==
X-Google-Smtp-Source: AGHT+IFlZwGom4Cm6D/yzMCO68xfKb+hvi2jTDlVGTvtty+HgV5mjKDUlfhjUX/StKdrcO0SHS8dY7nKIHi377iDFF8=
X-Received: by 2002:a2e:a16e:0:b0:2ec:1ce8:9a7d with SMTP id
 38308e7fff4ca-2ef05c5736cmr16130801fa.4.1721309410027; Thu, 18 Jul 2024
 06:30:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708075023.14893-1-brgl@bgdev.pl> <20240708075023.14893-4-brgl@bgdev.pl>
 <7c0140be-4325-4005-9068-7e0fc5ff344d@nvidia.com> <CAMRc=McF93F6YsQ+eT9oOe+c=2ZCQ3rBdj+-3Ruy8iO1B-syjw@mail.gmail.com>
In-Reply-To: <CAMRc=McF93F6YsQ+eT9oOe+c=2ZCQ3rBdj+-3Ruy8iO1B-syjw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 18 Jul 2024 15:29:59 +0200
Message-ID: <CAMRc=Mc=8Sa76TOZujMMZcaF2Dc8OL_HKo=gXuj-YALaH4zKHg@mail.gmail.com>
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

On Thu, Jul 18, 2024 at 3:04=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Thu, Jul 18, 2024 at 2:23=E2=80=AFPM Jon Hunter <jonathanh@nvidia.com>=
 wrote:
> >
> >
> > With the current -next and mainline we are seeing the following issue o=
n
> > our Tegra234 Jetson AGX Orin platform ...
> >
> >   Aquantia AQR113C stmmac-0:00: aqr107_fill_interface_modes failed: -11=
0
> >   tegra-mgbe 6800000.ethernet eth0: __stmmac_open: Cannot attach to PHY=
 (error: -110)
> >
> >
> > We have tracked it down to this change and looks like our PHY does not
> > support 10M ...
> >
> > $ ethtool eth0
> > Settings for eth0:
> >          Supported ports: [  ]
> >          Supported link modes:   100baseT/Full
> >                                  1000baseT/Full
> >                                  10000baseT/Full
> >                                  1000baseKX/Full
> >                                  10000baseKX4/Full
> >                                  10000baseKR/Full
> >                                  2500baseT/Full
> >                                  5000baseT/Full
> >
> > The following fixes this for this platform ...
> >
> > diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy=
/aquantia/aquantia_main.c
> > index d12e35374231..0b2db486d8bd 100644
> > --- a/drivers/net/phy/aquantia/aquantia_main.c
> > +++ b/drivers/net/phy/aquantia/aquantia_main.c
> > @@ -656,7 +656,7 @@ static int aqr107_fill_interface_modes(struct phy_d=
evice *phydev)
> >          int i, val, ret;
> >
> >          ret =3D phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
> > -                                       VEND1_GLOBAL_CFG_10M, val, val =
!=3D 0,
> > +                                       VEND1_GLOBAL_CFG_100M, val, val=
 !=3D 0,
> >                                          1000, 100000, false);
> >          if (ret)
> >                  return ret;
> >
> >
> > However, I am not sure if this is guaranteed to work for all?
>
> Ah cr*p. No, I don't think it is. We should take the first supported
> mode for a given PHY I think.
>

TBH I only observed the issue on AQR115C. I don't have any other model
to test with. Is it fine to fix it by implementing
aqr115_fill_interface_modes() that would first wait for this register
to return non-0 and then call aqr107_fill_interface_modes()?

Bartosz

