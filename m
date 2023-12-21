Return-Path: <netdev+bounces-59554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F6481B36F
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 11:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6912F286465
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 10:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944BE4F20E;
	Thu, 21 Dec 2023 10:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOezKcBg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF524F203
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 10:22:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4EAC433C7;
	Thu, 21 Dec 2023 10:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703154120;
	bh=TnlGSDRYO2VtwTMmn2N8mU+2YLb9Mo7YlEStyST94Z4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pOezKcBggbq7/fDAcEZURdhVTCbBeaEFCrktPDya7X4/Zsd+2GysWaQHwkTwGRvrC
	 cnsfdPXGg4R3BmcPGXRWHn8vgrGL+1T2BS/WVZrTqHV6rEr/L7szYLnTwRYiYoua64
	 WvgaOWI7FpkZC4XGqdk7rchiO1EO+ekjCkcjLaSDeYW/u+K0CWjsGw6DuRG9ebVOor
	 2vi8thpiGzqjSlJzToplwySe25ldwRfMPw+pD0DVkmk5LmPEW4ML9XpVydTtp5fLK2
	 aNXw4jzqYesS17ZOYW65CTJNZ5rO8M2d6BL71qqj6ffi7qbs1Wxwiw4ZaEgJkhJyQf
	 nvxlh5UmN+h9w==
Date: Thu, 21 Dec 2023 11:21:53 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <rmk+kernel@armlinux.org.uk>, Alexander
 Couzens <lynxis@fe80.eu>, Daniel Golle <daniel@makrotopia.org>, Willy Liu
 <willy.liu@realtek.com>, Ioana Ciornei <ioana.ciornei@nxp.com>, Marek
 =?UTF-8?B?TW9qw61r?= <marek.mojik@nic.cz>, =?UTF-8?B?TWF4aW1pbGnDoW4=?=
 Maliar <maximilian.maliar@nic.cz>
Subject: Re: [PATCH net-next 13/15] net: phy: realtek: drop .read_page and
 .write_page for rtl822x series
Message-ID: <20231221112153.436d8bdb@dellmb>
In-Reply-To: <cb28278d-c038-4dbf-81e7-097bf61dfb74@gmail.com>
References: <20231220155518.15692-1-kabel@kernel.org>
	<20231220155518.15692-14-kabel@kernel.org>
	<cb28278d-c038-4dbf-81e7-097bf61dfb74@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Dec 2023 18:23:21 +0100
Heiner Kallweit <hkallweit1@gmail.com> wrote:

> On 20.12.2023 16:55, Marek Beh=C3=BAn wrote:
> > Drop the .read_page() and .write_page() methods for rtl822x series.
> >=20
> > The rtl822x driver methods are now reimplemented to only access clause
> > 45 registers and these are the last methods that explicitly access
> > clause 22 registers.
> >=20
> > If the underlying MDIO bus is clause 22, the paging mechanism is still
> > used internally in the .read_mmd() and .write_mmd() methods when
> > accessing registers in MMD 31.
> >=20
> > Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
> > ---
> >  drivers/net/phy/realtek.c | 12 ------------
> >  1 file changed, 12 deletions(-)
> >=20
> > diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> > index cf608d390aa5..e2f68ac4b005 100644
> > --- a/drivers/net/phy/realtek.c
> > +++ b/drivers/net/phy/realtek.c
> > @@ -963,8 +963,6 @@ static struct phy_driver realtek_drvs[] =3D {
> >  		.read_status	=3D rtl822x_read_status,
> >  		.suspend	=3D genphy_c45_pma_suspend,
> >  		.resume		=3D rtl822x_resume,
> > -		.read_page	=3D rtl821x_read_page,
> > -		.write_page	=3D rtl821x_write_page,
> >  		.read_mmd	=3D rtlgen_read_mmd,
> >  		.write_mmd	=3D rtlgen_write_mmd,
> >  	}, {
> > @@ -975,8 +973,6 @@ static struct phy_driver realtek_drvs[] =3D {
> >  		.read_status	=3D rtl822x_read_status,
> >  		.suspend	=3D genphy_c45_pma_suspend,
> >  		.resume		=3D rtl822x_resume,
> > -		.read_page	=3D rtl821x_read_page,
> > -		.write_page	=3D rtl821x_write_page,
> >  		.read_mmd	=3D rtlgen_read_mmd,
> >  		.write_mmd	=3D rtlgen_write_mmd,
> >  	}, {
> > @@ -987,8 +983,6 @@ static struct phy_driver realtek_drvs[] =3D {
> >  		.read_status    =3D rtl822x_read_status,
> >  		.suspend	=3D genphy_c45_pma_suspend,
> >  		.resume		=3D rtl822x_resume,
> > -		.read_page      =3D rtl821x_read_page,
> > -		.write_page     =3D rtl821x_write_page,
> >  		.read_mmd	=3D rtlgen_read_mmd,
> >  		.write_mmd	=3D rtlgen_write_mmd,
> >  	}, {
> > @@ -999,8 +993,6 @@ static struct phy_driver realtek_drvs[] =3D {
> >  		.read_status    =3D rtl822x_read_status,
> >  		.suspend	=3D genphy_c45_pma_suspend,
> >  		.resume		=3D rtl822x_resume,
> > -		.read_page      =3D rtl821x_read_page,
> > -		.write_page     =3D rtl821x_write_page,
> >  		.read_mmd	=3D rtlgen_read_mmd,
> >  		.write_mmd	=3D rtlgen_write_mmd,
> >  	}, {
> > @@ -1011,8 +1003,6 @@ static struct phy_driver realtek_drvs[] =3D {
> >  		.read_status    =3D rtl822x_read_status,
> >  		.suspend	=3D genphy_c45_pma_suspend,
> >  		.resume		=3D rtl822x_resume,
> > -		.read_page      =3D rtl821x_read_page,
> > -		.write_page     =3D rtl821x_write_page,
> >  		.read_mmd	=3D rtlgen_read_mmd,
> >  		.write_mmd	=3D rtlgen_write_mmd,
> >  	}, {
> > @@ -1023,8 +1013,6 @@ static struct phy_driver realtek_drvs[] =3D {
> >  		.read_status    =3D rtl822x_read_status,
> >  		.suspend	=3D genphy_c45_pma_suspend,
> >  		.resume		=3D rtl822x_resume,
> > -		.read_page      =3D rtl821x_read_page,
> > -		.write_page     =3D rtl821x_write_page,
> >  		.read_mmd	=3D rtlgen_read_mmd,
> >  		.write_mmd	=3D rtlgen_write_mmd,
> >  	}, { =20
>=20
> Dropping the read_page/write_page hooks will be problematic,
> because they are used by the PHY initialization in e.g.
> rtl8125a_2_hw_phy_config().

I see.=20

Maybe it would be simpler to just remove it from this series.

Looking at all instances of paged access in r8169, most of them seem to
access the vendor 2 MMD registers. Also the person from Realtek says
that MMD registers are available also on 1gbps PHYs.

Looking at PHY specs for RTL8211 series, all of them (as old as 2009)
seem to document MMD access.

So I think we can safely add .read_mmd() and .write_mmd() methods to
all the PHYs in realtek.c that may be used by r8169, and then we can
change the relevant phy_read/write/modify_paged calls into
phy_read/write/modify_mmd in r8169 according to the formula.

(The relevant accesses being those where page is set to value >=3D 0xa00.)

What do you think?

Marek

