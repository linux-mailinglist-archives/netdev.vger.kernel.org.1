Return-Path: <netdev+bounces-104575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C59A590D61D
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1EC287B53
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 14:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA331419BA;
	Tue, 18 Jun 2024 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="DP6GEE3Q"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DFA139CFC;
	Tue, 18 Jun 2024 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721951; cv=none; b=Fq4caqE2sbpEw8TK970gRV8weo8zWtTRHZ4gDuffVEKlCCACrg/+h4ksSfl4QH+F8i6DQZyKXEZ48dQsEELaE6YWbRAK1+LvjywzBSdwzNqo4dGxUWqMkrsCtMbQw4k1Ahw02pLACCkkyGn3KJm1VJqvHjTje3NQDJH8PaGyYLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721951; c=relaxed/simple;
	bh=/eXZnkslDtXtwLMQzzo568CwMVqG0SYfQ/UyG0IHN2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PClvj/rFzI5L73QDoEm8T0YiXyMA7l1cgxiF7hwo5WPEzWQxTDzo+NRkl0h70GBqZipDHXmCUJu3vSRCBeQr38yv6lf17GdnA+Z3FdVTXvg1rEEEpsSophYPRmgK21TktkGaHy4b1lu1EgXsLByHjVKhorbBPXkNZl3o5OJTQCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=DP6GEE3Q; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id C4C6A881DB;
	Tue, 18 Jun 2024 16:45:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718721947;
	bh=Ojk5mwSvw+tC6y+Z5fiUjKgjEOz15W+RAyfOfEfKZRE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DP6GEE3QWmViRXPM6lpRCuxF39Ag8BD30mSTgJgZ+ybArBY+nMyJ7lpF+LaQwzKXN
	 j9YEfRiXQVVWVQc0+J2EbyF1OWL3GqSZl7lH12cs4sffPVLJ262yzAJj91O5O8JKLp
	 0yW5hAxywVL2CSwdH4ABlkpbZsrrkg0S/Czhe7ETeMYCtOFxmMCCpBBv5hWZ7og6JB
	 uHbVB7b5As54UTqFgbIDZBy1g/4umujstA2Htc6Ebr1DBePqJbm4dm352BcjhFKqVo
	 2F7RqVgItXMoZKdUurHmuSGEf2luCN1wrdTKLWLtIRHM/JG4p3GMt+r/FRcVIOtAVh
	 vME1LG1zfbQtQ==
Date: Tue, 18 Jun 2024 16:45:45 +0200
From: Lukasz Majewski <lukma@denx.de>
To: <Woojung.Huh@microchip.com>
Cc: <dan.carpenter@linaro.org>, <andrew@lunn.ch>, <olteanv@gmail.com>,
 <kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
 <edumazet@google.com>, <davem@davemloft.net>, <o.rempel@pengutronix.de>,
 <Tristram.Ha@microchip.com>, <bigeasy@linutronix.de>, <horms@kernel.org>,
 <ricardo@marliere.net>, <casper.casan@gmail.com>,
 <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v1 net-next] net: dsa: Allow only up to two HSR HW
 offloaded ports for KSZ9477
Message-ID: <20240618164545.14817f7e@wsk>
In-Reply-To: <BL0PR11MB291397353642C808454F575CE7CE2@BL0PR11MB2913.namprd11.prod.outlook.com>
References: <20240618130433.1111485-1-lukma@denx.de>
	<339031f6-e732-43b4-9e83-0e2098df65ef@moroto.mountain>
	<24b69bf0-03c9-414a-ac5d-ef82c2eed8f6@lunn.ch>
	<1e2529b4-41f2-4483-9b17-50c6410d8eab@moroto.mountain>
	<BL0PR11MB291397353642C808454F575CE7CE2@BL0PR11MB2913.namprd11.prod.outlook.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=faO5bG0JahLBSA=3O3EqoV";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/=faO5bG0JahLBSA=3O3EqoV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dan, Andrew, Woojung

> Hi Dan & Andrew,
>=20
> > On Tue, Jun 18, 2024 at 03:52:23PM +0200, Andrew Lunn wrote: =20
> > > > diff --git a/drivers/net/dsa/microchip/ksz_common.c =20
> > b/drivers/net/dsa/microchip/ksz_common.c =20
> > > > index 2818e24e2a51..181e81af3a78 100644
> > > > --- a/drivers/net/dsa/microchip/ksz_common.c
> > > > +++ b/drivers/net/dsa/microchip/ksz_common.c
> > > > @@ -3906,6 +3906,11 @@ static int ksz_hsr_join(struct
> > > > dsa_switch *ds, =20
> > int port, struct net_device *hsr, =20
> > > >             return -EOPNOTSUPP;
> > > >     }
> > > >
> > > > +   if (hweight8(dev->hsr_ports) > 1) {
> > > > +           NL_SET_ERR_MSG_MOD(extack, "Cannot offload more
> > > > than two =20
> > ports (in use=3D0x%x)", dev->hsr_ports); =20
> > > > +           return -EOPNOTSUPP;
> > > > +   } =20
> > >
> > > Hi Dan
> > >
> > > I don't know HSR to well, but this is offloading to hardware, to
> > > accelerate what Linux is already doing in software. It should be,
> > > if the hardware says it cannot do it, software will continue to
> > > do the job. So the extack message should never be seen. =20
> >=20
> > Ah.  Okay.  However the rest of the function prints similar messages
> > and so probably we could remove those error messages as well.  To be
> > honest, I just wanted something which functioned as a comment and
> > mentioned "two ports".  Perhaps the condition would be more clear
> > as =20
> > >=3D 2 instead of > 1? =20
> >  =20
>=20
> I'm not a HSR expert and so could be a dummy question.
>=20
> I think this case (upto 2 HSR port offload) is different from other
> offload error.=20

It is not so different.

In this case when we'd call:
ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 interlink lan3
supervision 45 version 1

lan1 and lan2 are correctly configured as ports, which can use HSR
offloading on ksz9477.

However, when we do already have two bits set in hsr_ports, we need to
return (-ENOTSUPP), so the interlink port (HSR-SAN) would be used with
SW based HSR interlink support.

Otherwise, I do see some strange behaviour, as some HSR frames are
visible on HSR-SAN network and vice versa causing switch to drop frames.

Also conceptually - the interlink (i.e. HSR-SAN port) shall be only SW
supported as it is also possible to use ksz9477 with only SW based HSR
(i.e. port0/1 -> hsr0 with offloading, port2 -> HSR-SAN/interlink,
port4/5 -> hsr1 with SW based HSR).

> Others are checking whether offload is possible or
> not, so SW HSR can kick in when -EOPNOTSUPP returns.=20

Yes, this is exactly the case.

> However, this
> happens when joining 3rd (2+) port with hardware offload is enabled.
> It is still working two ports are in HW HSR offload and next ports
> are in SW HSR?

As written above, it seems like the in-chip VLAN register is modified
and some frames are passed between HSR and SAN networks, which is wrong.

Best would be to have only two ports with HSR offloading enabled and
then others with SW based HSR if required.

For me the:

NL_SET_ERR_MSG_MOD(extack, "Cannot offload more than two ports (in
use=3D0x%x)", dev->hsr_ports);

is fine - as it informs that no more HSR offloading is possible (and
allows to SW based RedBox/HSR-SAN operation).

>=20
> Thanks.
> Woojung




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/=faO5bG0JahLBSA=3O3EqoV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmZxnZkACgkQAR8vZIA0
zr1pDAgAz8iqxMsI8PaedNynjdgMDokKLvfzbsccYcMauZXGlALZ1sKG4xrZ6w6b
nKRiE6X+EAuCWKLP4d3sTegMP2wg7iAfNFSTwQYltBFndzTPwopi2rf7h5lHQIHV
w+QxPdn4Dpap0Tcf1Qdb+c+NJzBirrNbNgONrqO5IXgfZA0IsEKxg7tpxj+y8r23
ygZhw6fSR2As7b0xwy9Oy2f0FZAFXZRpfBgxvHmoj7v2HiRVRx6uuZJMVhU7Ov0q
wUId3AIiXdrhOdgtyPrS6qTcniWtmPI3vT33KcFZQxzmZOvt5gvIAAJdt2ivuyS0
OBFpZcy0HUyW2ig31R3SI2RftxSCFQ==
=A1DY
-----END PGP SIGNATURE-----

--Sig_/=faO5bG0JahLBSA=3O3EqoV--

