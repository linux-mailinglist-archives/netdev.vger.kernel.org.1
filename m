Return-Path: <netdev+bounces-105236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF50091038E
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D40E28141E
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 12:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AAE15535A;
	Thu, 20 Jun 2024 12:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="oCHa+B7n"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAC13BBF5;
	Thu, 20 Jun 2024 12:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718884850; cv=none; b=MreW8/qCl1enawpPM4i+Gpr1y1nXRo6YIJgMAle1KObW0t7QPOdnCOu9iM7ig6KSIphMxRntkvlmWrWmddY9z2WGxzPd7kvKkK0JNNDYwdgjJItwsbJxWBOL3oxwCnisXOhYOoPG6xUb6xJcg9b3rNJrESFR19TmAVVLul49XiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718884850; c=relaxed/simple;
	bh=masVgiEVrY3nzXZveTAjwT+Gixs2tnPiRl/I6A32EvI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c1ImFmGVRmmcf+WN4u3ituZkIAf4du3p8ir+cUIZ88UW2nRiylU3+VlyJBBl0cJ4FS5MmXhPQ3l7Q8a5nNLzmXaKqXA6Ou+m43x/pinBFUaspoPsOG/V+lCcAO2hIE0OesjEJ6sl7Cd+xHXkQUJpXa0s5KMWojULQYBoj8RLXFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=oCHa+B7n; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id F0446883A6;
	Thu, 20 Jun 2024 14:00:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718884846;
	bh=smox0b1pxt1sHNNDz739cx9CLIz4NaHSGdjVt/vZXh8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oCHa+B7ny7edSSXyRh6+OhhOEMfHwONRcQpCrfdUILB5JQPj9SsoHTKBaRiOYOSX3
	 gM+9mJJ3E9bi7AW8mpyp7tkhzusC0KvUIAA4b4yTyj+6yvhgvucXLBTLKp1DaGwAb2
	 2PmOHp8g7Ct+BHjmQG9XUvZ2izB8YkNsB55GbfkHdyG2NSVgYYzdWtjmZFmWwxwJ3l
	 OJmlnXvPBD7UzKYCXdEt5aINlgJ7CDG7oIy+LxsaMlNxnwfzZ8luRxIK0jgwi20UXN
	 iS0KYq4O3v4wAbhVDTCC78biEt7Pq9gG8YibzjDKL1kK9p/sXQH0aniYQvLSGdDrKf
	 6IQg3TTRARACA==
Date: Thu, 20 Jun 2024 14:00:44 +0200
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
Message-ID: <20240620140044.07191e24@wsk>
In-Reply-To: <20240620090210.drop6jwh7e5qw556@skbuf>
References: <20240619134248.1228443-1-lukma@denx.de>
	<20240619134248.1228443-1-lukma@denx.de>
	<20240619144243.cp6ceembrxs27tfc@skbuf>
	<20240619171057.766c657b@wsk>
	<20240619154814.dvjcry7ahvtznfxb@skbuf>
	<20240619155928.wmivi4lckjq54t3w@skbuf>
	<20240620095920.6035022d@wsk>
	<20240620090210.drop6jwh7e5qw556@skbuf>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bpKHthVch+friIY0bUGyhl5";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/bpKHthVch+friIY0bUGyhl5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

> On Thu, Jun 20, 2024 at 09:59:20AM +0200, Lukasz Majewski wrote:
> > > It will return -EOPNOTSUPP for port 0,  =20
> >=20
> > This comment is for xrs700x_hsr_join()? =20
>=20
> Yes.
>=20
> > For the ksz_hsr_join() we do explicitly check for the
> > KSZ9477_CHIP_ID.
> >=20
> > I do regard this fix as a ksz9477 specific one, as there are some
> > issues (IMHO - this is the "unexpected behaviour" case for this IC)
> > when we add interlink to SoC VLAN.
> >=20
> > I don't understand why you bring up xrs700x case here? Is it to get
> > a "broader context"? =20
>=20
> You have the Fixes: tag set to a HSR driver change, the fix to which
> you provide in an offloading device driver. What I'm trying to tell
> you is to look around and see that KSZ9477 is not the only one which
> is confused by the addition of an interlink port.

As of now - the HSR interlink was tested with hsr_redbox.sh script with
QEMU setup and with KSZ9477 IC with and without offloading enabled.

> So is XRS700X, yet
> for another reason.
>=20
> > > falling back to
> > > software mode for the first ring port, then accept offload for
> > > ring ports 1 and 2. But it doesn't match what user space
> > > requested, because port 2 should be interlink... =20
> >=20
> > Please correct me if I'm wrong, but this seems to not be the case
> > for ksz9477 - as I stated in the other mail - the ordering is
> > correct (I've checked it). =20
>=20
> I was never claiming it to be about KSZ9477.

Ok.

>=20
> > > I think you really should pass the port type down to drivers and
> > > reject offloading interlink ports... =20
> >=20
> > As stated above - IMHO I do provide a fix for this particular IC
> > (KSZ9477). With xrs700x we do have fixed ports supporting HSR (port
> > 1,2), so there is no other choice. As a result the HSR Interlink
> > would be supporting only SW emulation. =20
>=20
> But there is another choice, and I think I've already explained it.
>=20
>         HSR_PT_SLAVE_A    HSR_PT_SLAVE_B      HSR_PT_INTERLINK
>  ----------------------------------------------------------------
>  user
>  space        0                 1                   2
>  requests
>  ----------------------------------------------------------------
>  XRS700X
>  driver       1                 2                   -
>  understands
>=20
> I am bringing this as an argument for the fact that you should pass
> the port type explicitly from HSR to the offload, and use it
> throughout the offloading drivers. The hweight(ports) >=3D 2 happens to
> work for KSZ9477,

And hence it is added to ksz_hsr_join() function, which for now only
checks if we use this particular IC.

> but IMO misidentifies the problem as having to do
> with the number of ports rather than the port type.

In general I do understand your concerns - however, as I've stated this
patch fixes oddity of the KSZ9477. I can test it with it.

> Because of this,
> a largely similar issue introduced by the same blamed commit but in
> XRS700X is left unaddressed and unidentified (the fixed ports check
> which is already present masks the fact that it's not really about
> the ports, but their type, which must still be checked, otherwise the
> driver has no idea what HSR wants from it).

To keep it short: I do see your point, but I believe that it is out of
the scope for this particular patch.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/bpKHthVch+friIY0bUGyhl5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmZ0GewACgkQAR8vZIA0
zr3HvQf/TwesLD4OLVnDP3iNXGXpc7JnWrOCDsZKTJz97a+2E05U31gZMPduitTa
w3Ek2cw7SmmFe2DRWNf0mA73sc879gtOOHW+84ZTV68qbvIk5V0kKjoLYNXODcp9
AknRCfbjO/X9tjG6wn/p7c0/P4/L5B9cLYoaRZkBmxDxB1xXfDoFstMJPlJcMaZ7
w/9l52XVqhg/0eVVDXgJHBJo1iy/7Tzzi3zgoKA3azrotZXa/xRpli2SDVyzlPaY
rOiRlRhjZxKJ8qhz6TtCCuQprKLwEVPVGNHta9MSqw3guqQ8dFSUBKqDEaCuuX7I
rWu+Wl6pKcAqxzzOlqzKzFUpcbU55w==
=uJPp
-----END PGP SIGNATURE-----

--Sig_/bpKHthVch+friIY0bUGyhl5--

