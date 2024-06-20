Return-Path: <netdev+bounces-105155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E6090FE20
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 09:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 253DBB21398
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 07:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2E150279;
	Thu, 20 Jun 2024 07:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="wuz8FPLd"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D7C482C8;
	Thu, 20 Jun 2024 07:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718870366; cv=none; b=q8UBHfX33epPK8GjKwmX6ItAZqkOTEJjGej302zkxmGnzMUeayt0jEAjsyMyr4gYkWk/fHckAFEzcEDfgswQVA0Bw7UifsM63o4FONOic9hCFDEUwyfURAoKwwH111KrD91kDW7FhU4syUtSc+l+4802csuGpzJfcyLGHRRYP7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718870366; c=relaxed/simple;
	bh=dzzZTbj+3nIanx4kJLX9W85fpB4mfwv7gZtKTDcQpZU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ov+fR1fgG2gOOqJi2AohjeMmMFd55NPHMscLXtM9ZfkZNMA4UxT9No9y9uMi+jgO3Mwpkg8jOgHU33/zFQs3o5nG0QBNKCCYxmHTFg3ZlJJ6FMB5zdMkg9khEjHzS1wpXNm2MgWvoUJ5IDUvALuEatb+mcfHX/s9Rj45JzLL1g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=wuz8FPLd; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 722BA87C69;
	Thu, 20 Jun 2024 09:59:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718870362;
	bh=KTkD1fNt44Ouv47/6lXydN4bYu7m2SKRrnp+lNDnGMI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wuz8FPLdkeIjHVNt2YruCxFp52hbgip6+fywecLYmmsgDB4P7t4TwKykiPsn5jgd+
	 yYhzPCDDU+vrjlTapVYJXLjd7GGOvmF0U+tI1JFDQvENKoTngyvy7TcrillsFOAoEq
	 EVP/G9gPdjYdQuDVaCYBAK2GsE4LB2rwAOr2InXqu2wZfJsGyXWAxMla8ncNzgyWaq
	 6zCCcWBccBD70trEmjpcWQojIgOkeXyyYqIU2V9TiMUR3LGXw2LNo7JWjGAr9Gfirx
	 JzvmYFdjxr3GYjn52U4pYEvIkStTnGxEwHcZxmeI76IhFybz3Wu4FoOiE1yzYhiyv/
	 4qpq3UYMpryDg==
Date: Thu, 20 Jun 2024 09:59:20 +0200
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
Message-ID: <20240620095920.6035022d@wsk>
In-Reply-To: <20240619155928.wmivi4lckjq54t3w@skbuf>
References: <20240619134248.1228443-1-lukma@denx.de>
	<20240619134248.1228443-1-lukma@denx.de>
	<20240619144243.cp6ceembrxs27tfc@skbuf>
	<20240619171057.766c657b@wsk>
	<20240619154814.dvjcry7ahvtznfxb@skbuf>
	<20240619155928.wmivi4lckjq54t3w@skbuf>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bJVD9HQ4bWNjw6GY_e=zb/k";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/bJVD9HQ4bWNjw6GY_e=zb/k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

> On Wed, Jun 19, 2024 at 06:48:14PM +0300, Vladimir Oltean wrote:
> > Granted, this isn't an actual functional problem, but given that you
> > are fixing a newly developed feature for net-next, and that this is
> > API that gets progressively harder to change as more devices
> > implement offloads, I would expect a more obvious signaling
> > mechanism to exist for this, and now seems a good time to do it,
> > rather than opting for the most minimal fix. =20
>=20
> Actually I'm not even so sure about this basic fact, that it isn't a
> functional problem already.
>=20
> xrs700x_hsr_join() has explicit checks for port 1 and 2. Obviously it
> expects those ports to be ring ports.

Yes.

>=20
> But if you configure from user space ports 0 and 1 to be ring ports,
> and port 2 to be an interlink port, the kernel will accept that
> configuration.=20

Yes.

> It will return -EOPNOTSUPP for port 0,=20

This comment is for xrs700x_hsr_join()?

For the ksz_hsr_join() we do explicitly check for the KSZ9477_CHIP_ID.

I do regard this fix as a ksz9477 specific one, as there are some
issues (IMHO - this is the "unexpected behaviour" case for this IC) when
we add interlink to SoC VLAN.

I don't understand why you bring up xrs700x case here? Is it to get a
"broader context"?

> falling back to
> software mode for the first ring port, then accept offload for ring
> ports 1 and 2. But it doesn't match what user space requested, because
> port 2 should be interlink...

Please correct me if I'm wrong, but this seems to not be the case for
ksz9477 - as I stated in the other mail - the ordering is correct (I've
checked it).

>=20
> I think you really should pass the port type down to drivers and
> reject offloading interlink ports...

As stated above - IMHO I do provide a fix for this particular IC
(KSZ9477). With xrs700x we do have fixed ports supporting HSR (port
1,2), so there is no other choice. As a result the HSR Interlink would
be supporting only SW emulation.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/bJVD9HQ4bWNjw6GY_e=zb/k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmZz4VgACgkQAR8vZIA0
zr2kawgAwwaDitXI7l/t+aUeXBWcTmg89+6VWM7pz2V3qhSCY/+umdf6Wun5pwZd
KBHfXjbVsKAOczCEa24Urq6jVJoopHZGk7H3VzkCDaBWKkCKtaOhwvYxS2rU2Q99
/+lMpBipwzW6DoalZbalssP2ipsElfzPOV3fCfJTZ1LkY9lu0jHZfbUWx0BwZzgd
tHnFyp8mXi1VUP6RKpn+bu1lACMOG6C2Vbbnio16pFP9kZonDGFAk7Yb81De31AW
KBuXBME+Ebw8DCSc3a/V09ORYwmCntZKpS85037lOxnUNnn/qh0fd97z5ihvlTTZ
mneGGFFo3XJq1eLBGyFiSqp+5vnUTw==
=SFKE
-----END PGP SIGNATURE-----

--Sig_/bJVD9HQ4bWNjw6GY_e=zb/k--

