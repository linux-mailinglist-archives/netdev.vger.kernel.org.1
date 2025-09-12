Return-Path: <netdev+bounces-222403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5A4B541A8
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 06:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03D05A6302
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 04:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E43523F417;
	Fri, 12 Sep 2025 04:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTZi9oqP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC9523814C
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 04:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757650966; cv=none; b=RRDzy0M18w+okHrJGQxE056xeh3/FOS1MQovFmgodiVfwHoynPgOEA/wVmiF7VoRkX4LvG0vdmmdzQoKwOZP8aQxIPbMb4nuxWW6S6JyFIHSkERQ0Wa/zO1pQpnijnMZaLPxpPbWvV/NN3TfBaxWGdPnOwIpTMO5o1LNDplYudE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757650966; c=relaxed/simple;
	bh=Vv2YrcjBvxFvZZi58UBaLJNHyadz2sEpT9KVQerfpjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KX2lZxtS7CLQtez+jS9fWL1zBdXiKH5+ZMHsDRWeqo6bxVKhi3yoouLXgAujkHDH7wHoH0ThkEztW8cMM7ZodQexkURGVPVrx/02Z1apsGP/8W9rMQS1xDGTZeIu5eI9HlMOlsOOhTvu8JV8LuLGRaiuYs4ZaDyATPu07o4irYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTZi9oqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955CCC113CF
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 04:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757650965;
	bh=Vv2YrcjBvxFvZZi58UBaLJNHyadz2sEpT9KVQerfpjQ=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=mTZi9oqPQCUG17+6d+Y0N/T40s6bdZXvcoppvr+58VDrpnyc5bKxHCYZR4ogxBiY9
	 j6opu1C0Ipp3RsrRZ949zRP969yzGQR560hkMDPPw8hjuPvjXZ3i6y8jShJqX/kVBP
	 k7eJdsps0TDdLQn0shhwv+KLvQv9PTb0vVKe7ErNeJ4qvk1r0i33ScXowCqET2ARxe
	 +LMN4HsCqgMCk63VnnRXsLp+I8Ta4ZVfe5S51cC9qfZx1wf2E9grIuAw4jivjXySax
	 Es1D8hKj+NI2chI6GhzIaUtevkFg2fExyyYZjV+Mpt4+F/BdNMXzdTNSQTyUsZkJiO
	 99AkHKnhVXJkA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3517d7954deso2264281fa.0
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 21:22:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXJkYbqAyweJ7HNrTX6FMxjNh4GspOPfErltxyH3yrbW4BcaWI7AgOEn2HoMbTUPOdnFGvJmSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YySQMS7kBxEvhSM1PszSYai6W0FmoTCRPx4zL7HmGvPEzBJAFZe
	9LZxnHPDnbMRcclptWmlo0/RQSL6Gv+PC+s21zXbcbAkpksjOG6wVg2DGZ6QSbdE4W17w6yiydC
	t8m5RRMv5d4W/rqMgQNAXYRYR2eJhGk0=
X-Google-Smtp-Source: AGHT+IHbHGyZZve3/p2hQZn8nRc22BGYEXQJpdLfsbDiglhu6zahB25whpo6UiHtPzKB79uDzR6h/pwt7mPQi7mAzl0=
X-Received: by 2002:a2e:ae18:0:10b0:337:f025:512 with SMTP id
 38308e7fff4ca-35139e509c9mr2890861fa.16.1757650963840; Thu, 11 Sep 2025
 21:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908181059.1785605-1-wens@kernel.org> <20250908181059.1785605-3-wens@kernel.org>
 <aMMQSR7yYBQkY4CI@shell.armlinux.org.uk> <CAGb2v64n_eMBiUaT1S=V6v4Bqv5hLP8vP3=20sp4w4Fxh7RcOQ@mail.gmail.com>
 <DU0P190MB244515E7CE0741A1E47E0543BC08A@DU0P190MB2445.EURP190.PROD.OUTLOOK.COM>
In-Reply-To: <DU0P190MB244515E7CE0741A1E47E0543BC08A@DU0P190MB2445.EURP190.PROD.OUTLOOK.COM>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 12 Sep 2025 12:22:28 +0800
X-Gmail-Original-Message-ID: <CAGb2v64JvE=9PvaLYi50uK_dNsP6Sdw34H+d0-vCs2GSSoiocQ@mail.gmail.com>
X-Gm-Features: Ac12FXzFUjZYvnptlxG7S8Tq_6X0mBNQa2E6WmUp7iQd5dFFSAZgzFUYRyKwirM
Message-ID: <CAGb2v64JvE=9PvaLYi50uK_dNsP6Sdw34H+d0-vCs2GSSoiocQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 02/10] net: stmmac: Add support for Allwinner
 A523 GMAC200
To: Muhammed Subair <msubair@hotmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 12:09=E2=80=AFPM Muhammed Subair <msubair@hotmail.c=
om> wrote:
>
> Hi
>
> There are A527 boards with 25 Mhz clock from PH13 ( rgmii-0) and PJ10 (rg=
mii-1). See the attached .
> I believe that a patch is required to support this. Not sure it can be a =
global or board specific.

This is board specific. If you have such a board you can send a patch
on top of this series for it.

ChenYu

> Subair
>
> -----Original Message-----
> From: Chen-Yu Tsai <wens@kernel.org>
> Sent: Thursday, 11 September 2025 10:18 PM
> To: Russell King (Oracle) <linux@armlinux.org.uk>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft=
.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>=
; Paolo Abeni <pabeni@redhat.com>; Rob Herring <robh@kernel.org>; Krzysztof=
 Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Jernej=
 Skrabec <jernej@kernel.org>; Samuel Holland <samuel@sholland.org>; netdev@=
vger.kernel.org; devicetree@vger.kernel.org; linux-arm-kernel@lists.infrade=
ad.org; linux-sunxi@lists.linux.dev; linux-kernel@vger.kernel.org; Andre Pr=
zywara <andre.przywara@arm.com>
> Subject: Re: [PATCH net-next v4 02/10] net: stmmac: Add support for Allwi=
nner A523 GMAC200
>
> On Fri, Sep 12, 2025 at 2:09=E2=80=AFAM Russell King (Oracle) <linux@arml=
inux.org.uk> wrote:
> >
> > Hi,
> >
> > I drafted this but never sent it and can't remember why, but it's
> > relevant for v5 that you recently posted. Same concern with v5.
> >
> > On Tue, Sep 09, 2025 at 02:10:51AM +0800, Chen-Yu Tsai wrote:
> > > +     switch (plat->mac_interface) {
> > > +     case PHY_INTERFACE_MODE_MII:
> > > +             /* default */
> > > +             break;
> > > +     case PHY_INTERFACE_MODE_RGMII:
> > > +     case PHY_INTERFACE_MODE_RGMII_ID:
> > > +     case PHY_INTERFACE_MODE_RGMII_RXID:
> > > +     case PHY_INTERFACE_MODE_RGMII_TXID:
> > > +             reg |=3D SYSCON_EPIT | SYSCON_ETCS_INT_GMII;
> > > +             break;
> > > +     case PHY_INTERFACE_MODE_RMII:
> > > +             reg |=3D SYSCON_RMII_EN;
> > > +             break;
> > > +     default:
> > > +             return dev_err_probe(dev, -EINVAL, "Unsupported interfa=
ce mode: %s",
> > > +                                  phy_modes(plat->mac_interface));
> >
> > I'm guessing that there's no way that plat->phy_interface !=3D
> > plat->mac_interface on this platform? If so, please use phy_interface
> > plat->here.
>
> Makes sense. Looking at stmmac_platform.c, for us mac_interface only come=
s from phy_interface.
>
> I'll wait a day before sending yet another version.
>
> ChenYu
>

