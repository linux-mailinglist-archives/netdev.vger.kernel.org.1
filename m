Return-Path: <netdev+bounces-104920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1361390F1BE
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 17:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D3D1F22D3F
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 15:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3030D59147;
	Wed, 19 Jun 2024 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="irru3+Mm"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459DE6FA8;
	Wed, 19 Jun 2024 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718809872; cv=none; b=LNEVMCkmyVDSevCy4lKxy+a0/0JtAvSRbEdoyHBefnBrxEkCjIW3JsoTjMBXuuaYG31yZPmrHfWQXF9NM9UDjlo4Q1Zfeyj7zd83d26W0a6b2+KDPZrzEpoBa9Yc9ZBTMLy2zlXiQkECj/LJMwu7dXLgFZ5h06JG3TAcQy92OSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718809872; c=relaxed/simple;
	bh=sNiQqRRVxhX6R5C7ZIW4e4ySrQgybrTeiPWSTDXXSd0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWzv0Ljp3odMX30uvfm9OAdFIzoXr0dH7Nk4xTs3uVJlrtTvaU0+jnxFBo/NeQDGvd7AF3SUso+h2VpDeU9WQzBp5USEzXkPH2mCp02I1r53gzlKNpH7rfJL0e1uqiQXLvzxwcsYwBpp7szVYL7JtjAQkd03ZF6Z4VWGTJ/pG7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=irru3+Mm; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id E73B088499;
	Wed, 19 Jun 2024 17:11:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718809865;
	bh=cbiykYE4ij83OgSrWh5Wr9vuCYRi6pgLIq62roBg7LY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=irru3+MmdHc7vKEXanCJJEAa6d1z1/UO5rvvtUXdTR+SfXfaUzRU1KDy46HoInepj
	 X3vw2UhbhNfE+slRRDEK2JhPS2psvV2+EDdW7gaESE0TxJslSEfiZzZ5aObzv0SXvt
	 WWQjgqfh3Z+JW2yJU7BtHr5422BMpAbCia0SITPFyIP1o11Jlo/XJymuwQtBiLrN+n
	 LvAXl7j39580TeB2NlodjBQQ1/KN5LxFDuU22yralg55njXLZa5lEmAhxjUwOHqWuI
	 E/7tNHKM4RrVjx2NJqSyj1dXZTvJOJi9lI0QVm8HyoOmvkcKhmvOlSEsMDWva2J37b
	 pktAPrL+mFffg==
Date: Wed, 19 Jun 2024 17:10:57 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Tristram.Ha@microchip.com, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Simon Horman <horms@kernel.org>, Dan Carpenter
 <dan.carpenter@linaro.org>, "Ricardo B. Marliere" <ricardo@marliere.net>,
 Casper Andersson <casper.casan@gmail.com>, linux-kernel@vger.kernel.org,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 net-next] net: dsa: Allow only up to two HSR HW
 offloaded ports for KSZ9477
Message-ID: <20240619171057.766c657b@wsk>
In-Reply-To: <20240619144243.cp6ceembrxs27tfc@skbuf>
References: <20240619134248.1228443-1-lukma@denx.de>
	<20240619134248.1228443-1-lukma@denx.de>
	<20240619144243.cp6ceembrxs27tfc@skbuf>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TFbVG2Nx8rA=55CReln5.jy";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/TFbVG2Nx8rA=55CReln5.jy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

> On Wed, Jun 19, 2024 at 03:42:48PM +0200, Lukasz Majewski wrote:
> > The KSZ9477 allows HSR in-HW offloading for any of two selected
> > ports. This patch adds check if one tries to use more than two
> > ports with HSR offloading enabled.
> >=20
> > The problem is with RedBox configuration (HSR-SAN) - when
> > configuring: ip link add name hsr0 type hsr slave1 lan1 slave2 lan2
> > interlink lan3 \ supervision 45 version 1
> >=20
> > The lan1 (port0) and lan2 (port1) are correctly configured as
> > ports, which can use HSR offloading on ksz9477.
> >=20
> > However, when we do already have two bits set in hsr_ports, we need
> > to return (-ENOTSUPP), so the interlink port (lan3) would be used
> > with =20
>=20
> EOPNOTSUPP
>=20
> > SW based HSR RedBox support.
> >=20
> > Otherwise, I do see some strange network behavior, as some HSR
> > frames are visible on non-HSR network and vice versa.
> >=20
> > This causes the switch connected to interlink port (lan3) to drop
> > frames and no communication is possible.
> >=20
> > Moreover, conceptually - the interlink (i.e. HSR-SAN port -
> > lan3/port2) shall be only supported in software as it is also
> > possible to use ksz9477 with only SW based HSR (i.e. port0/1 ->
> > hsr0 with offloading, port2 -> HSR-SAN/interlink, port4/5 -> hsr1
> > with SW based HSR).
> >=20
> > Fixes: 5055cccfc2d1 ("net: hsr: Provide RedBox support (HSR-SAN)")
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> >=20
> > ---
> > Changes for v2:
> > - Add more verbose description with Fixes: tag
> > - Check the condition earlier and remove extra check if SoC is
> > ksz9477
> > - Add comment in the source code file
> > ---
> >  drivers/net/dsa/microchip/ksz_common.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/drivers/net/dsa/microchip/ksz_common.c
> > b/drivers/net/dsa/microchip/ksz_common.c index
> > 2818e24e2a51..72bb419e34b0 100644 ---
> > a/drivers/net/dsa/microchip/ksz_common.c +++
> > b/drivers/net/dsa/microchip/ksz_common.c @@ -3906,6 +3906,13 @@
> > static int ksz_hsr_join(struct dsa_switch *ds, int port, struct
> > net_device *hsr, return -EOPNOTSUPP; }
> > =20
> > +	/* KSZ9477 can only perform HSR offloading for up to two
> > ports */
> > +	if (hweight8(dev->hsr_ports) >=3D 2) {
> > +		NL_SET_ERR_MSG_MOD(extack,
> > +				   "Cannot offload more than two
> > ports - use software HSR");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> >  	/* Self MAC address filtering, to avoid frames traversing
> >  	 * the HSR ring more than once.
> >  	 */
> > --=20
> > 2.20.1
> >  =20
>=20
> How do you know you are rejecting the offloading of the interlink
> port, and not of one of the ring ports?

It seems like iproute2 is providing the correct ordering (and assures
that lan3/port2 is called as a third one - please see below).

> Basing this off of calling
> order is fragile,


In the accepted form - yes - the interlink port is called as a third
one, so it is refused to configure it in the same way as ports, which
are supporting HSR in HW (i.e. offloading).

> and does not actually reflect the hardware
> limitation.

root@sama5d3-xplained-sd:~# ip link add name hsr0 type hsr slave1 lan1
interlink lan3 slave2 lan2 supervision 45 version 1
ksz-switch spi1.0
lan1: entered promiscuous mode ksz-switch spi1.0 lan2: entered
promiscuous mode ksz-switch spi1.0 lan3: entered promiscuous mode
port: 2
Warning: ksz_switch: Cannot offload more than two ports - using
software HSR.


Gives the same output as:
root@sama5d3-xplained-sd:~# ip link add name hsr0 type hsr slave1 lan1
slave2 lan2 interlink lan3 supervision 45 version 1
ksz-switch spi1.0
lan1: entered promiscuous mode ksz-switch spi1.0 lan2: entered
promiscuous mode ksz-switch spi1.0 lan3: entered promiscuous mode
port: 2


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/TFbVG2Nx8rA=55CReln5.jy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmZy9QEACgkQAR8vZIA0
zr2hKggAxWZz5gMZtraXew0rRIb559bAIY+BDfSsjhs02l4bSOwL72soltUUKIrp
b0jMz5AquYflV2+bac366Ail1V0QY//Sz3cjC6omES7QUU5W7EQtyQOq8N8LnDzl
8iO7LSO7jIGHJlaa4+A3f7TupRwwXZ6nBhXUq29a6w5wMukd6M9WbHqQn+nfs4XO
B4q59VsbInzXfaag9sDF3jyYEsl3hnBW7oszHfuzP6KmEaSmpFYo3yOwwZxcw8Zv
mKB11jtWFVKq7an02TmnYzc0eZp7DfToA4jy2/6KqFrT0yOfK7+8h7ySM8aP97rb
2dl8hOON81TPMAVkCOFnsNFYgtDlAg==
=PHAS
-----END PGP SIGNATURE-----

--Sig_/TFbVG2Nx8rA=55CReln5.jy--

