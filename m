Return-Path: <netdev+bounces-75762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EE886B189
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 15:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D81DB2389C
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 14:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3330F157E9C;
	Wed, 28 Feb 2024 14:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Zu6UW2ND"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F380B73510
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709130040; cv=none; b=nIViuzMBRq4kwVk3LPshSCGhVOFVLGxe9eZ0tve1FMea2H1k2RMJA0cF28DkrRveZ3UI8a5OJB5d6L5NrLsUJhuo27sDK01LGLmu0giHjpnarMhByJTPLpRDfmCGYjPBJ8B7k/rvyTqeEBGH0rDiqpK1cDcqULUU885oRtPPIiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709130040; c=relaxed/simple;
	bh=eSqqbAOuo+4nm5RvaE1y7sfpp2E0YCDs+k+socZRY9g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JrRQhM2wRaSZlB+XyxaiFKFfxBnRiY3JL/ao0w9l+jG7kbNShLFVPXYwFdSyAs7QVM1i7hFhrF46toX0hUWKaMVf4BJpqMIcHWb7Pnk0oHBHddNwLha8mEfQbYfVMPtyySrrb6EI+wyY1JNW6Clx/l9qK5ODlQ46geD4B+Hy+hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Zu6UW2ND; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id BD1398800C;
	Wed, 28 Feb 2024 15:20:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709130034;
	bh=oQsP4YBr5BA5tuy8Y5PXQVxTodr/Yu/Szk5BwEc2zN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zu6UW2NDRZy1RvEo4XvE7chHbUWVv9mL3MDYhVvhf3f4j2xb0dTFlspUREnVlYdIv
	 FqIK6s+8Um9hCI7QDWwKhwdQuZGbQ3FAlNo6kt/IQyU1dgGv9zporH/QQkFdobqnMu
	 j+FOv1v242uTvd0U0516tWWljUdWCw34gYZ16wJF4Ov8MAzpPKSNLgjv5nlN6IUt8V
	 dsgG/+AbI/4TKqFzPJoBq0h2SXYX/4c0AsLddCoMlfRhXHWvPjhqt2YuJiWfz8Nc9p
	 H+rhIvB5uddfgiTGNyyYGOESt4mfam8P9g4jFleagsDvK2xaT9vc0AV9z8UYeY1pJk
	 /dcWURnGf5EUQ==
Date: Wed, 28 Feb 2024 15:20:27 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, Eric
 Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [PATCH] ip link: hsr: Add support for passing information about
 INTERLINK device
Message-ID: <20240228152027.295b2d82@wsk>
In-Reply-To: <20240226124110.37892211@hermes.local>
References: <20240216132114.2606777-1-lukma@denx.de>
	<20240226124110.37892211@hermes.local>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dK+EB9KUZ=EiGJ86C3pZRYg";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/dK+EB9KUZ=EiGJ86C3pZRYg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

> On Fri, 16 Feb 2024 14:21:14 +0100
> Lukasz Majewski <lukma@denx.de> wrote:
>=20
> > The HSR capable device can operate in two modes of operations -
> > Doubly Attached Node for HSR (DANH) and RedBOX.
> >=20
> > The latter one allows connection of non-HSR aware device to HSR
> > network. This node is called SAN (Singly Attached Network) and is
> > connected via INTERLINK network device.
> >=20
> > This patch adds support for passing information about the INTERLINK
> > device, so the Linux driver can properly setup it.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de> =20
>=20
> Patch should target iproute2-next since headers come from upstream.
> And kernel side needs to be accepted first.
>=20

Ok. I'm going to post RFC for it soon.

> When it is merged to net-next, Dave Ahern can pickup the headers
> from there.

Ok.

>=20
> > =20
> > diff --git a/ip/iplink_hsr.c b/ip/iplink_hsr.c
> > index da2d03d..1f048fd 100644
> > --- a/ip/iplink_hsr.c
> > +++ b/ip/iplink_hsr.c
> > @@ -25,12 +25,15 @@ static void print_usage(FILE *f)
> >  {
> >  	fprintf(f,
> >  		"Usage:\tip link add name NAME type hsr slave1
> > SLAVE1-IF slave2 SLAVE2-IF\n"
> > -		"\t[ supervision ADDR-BYTE ] [version VERSION]
> > [proto PROTOCOL]\n"
> > +		"\t[ interlink INTERLINK-IF ] [ supervision
> > ADDR-BYTE ] [ version VERSION ]\n"
> > +		"\t[ proto PROTOCOL ]\n"
> >  		"\n"
> >  		"NAME\n"
> >  		"	name of new hsr device (e.g. hsr0)\n"
> >  		"SLAVE1-IF, SLAVE2-IF\n"
> >  		"	the two slave devices bound to the HSR
> > device\n"
> > +		"INTERLINK-IF\n"
> > +		"	the interlink device bound to the HSR
> > network to connect SAN device\n" "ADDR-BYTE\n"
> >  		"	0-255; the last byte of the multicast
> > address used for HSR supervision\n" "	frames (default =3D 0)\n"
> > @@ -86,6 +89,12 @@ static int hsr_parse_opt(struct link_util *lu,
> > int argc, char **argv, if (ifindex =3D=3D 0)
> >  				invarg("No such interface", *argv);
> >  			addattr_l(n, 1024, IFLA_HSR_SLAVE2,
> > &ifindex, 4);
> > +		} else if (matches(*argv, "interlink") =3D=3D 0) { =20
>=20
> No new uses of matches() allowed in iproute2.

Could you be more specific here? Is there any other function (or idiom)
to be used?

>=20
> > +			NEXT_ARG();
> > +			ifindex =3D ll_name_to_index(*argv);
> > +			if (ifindex =3D=3D 0)
> > +				invarg("No such interface", *argv);
> > +			addattr_l(n, 1024, IFLA_HSR_INTERLINK,
> > &ifindex, 4); } else if (matches(*argv, "help") =3D=3D 0) {
> >  			usage();
> >  			return -1;
> > @@ -113,6 +122,9 @@ static void hsr_print_opt(struct link_util *lu,
> > FILE *f, struct rtattr *tb[]) if (tb[IFLA_HSR_SLAVE2] &&
> >  	    RTA_PAYLOAD(tb[IFLA_HSR_SLAVE2]) < sizeof(__u32))
> >  		return;
> > +	if (tb[IFLA_HSR_INTERLINK] &&
> > +	    RTA_PAYLOAD(tb[IFLA_HSR_INTERLINK]) < sizeof(__u32))
> > +		return;
> >  	if (tb[IFLA_HSR_SEQ_NR] &&
> >  	    RTA_PAYLOAD(tb[IFLA_HSR_SEQ_NR]) < sizeof(__u16))
> >  		return;
> > @@ -136,6 +148,14 @@ static void hsr_print_opt(struct link_util
> > *lu, FILE *f, struct rtattr *tb[]) else
> >  		print_null(PRINT_ANY, "slave2", "slave2 %s ",
> > "<none>");=20
> > +	if (tb[IFLA_HSR_INTERLINK])
> > +		print_string(PRINT_ANY,
> > +			     "interlink",
> > +			     "interlink %s ",
> > +
> > ll_index_to_name(rta_getattr_u32(tb[IFLA_HSR_INTERLINK]))); =20
>=20
> Better to print that in color and pack args on line up to 100
> characters.
>=20
> 	if (tb[IFLA_HSR_INTERLINK])
> 		print_color_string(PRINT_ANY, COLOR_IFNAME,
> "interlink", "interlink %s ",
> ll_index_to_name(rta_getattr_u32(tb[IFLA_HSR_INTERLINK])));
>=20

Ok.

> > +	else
> > +		print_null(PRINT_ANY, "interlink", "interlink %s
> > ", "<none>"); =20
>=20
> The output from ip show commands should resemble inputs to
> configuration. Therefore the else clause should not be there. Only
> print if interlink is configured.
>=20

Ok. I will adjust it.

>=20


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/dK+EB9KUZ=EiGJ86C3pZRYg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmXfQSsACgkQAR8vZIA0
zr1TfAf/fw4LC7j9yPcHfEY47gjoH2h0WcCQsKmTRb/De2ycJA0ix3V6ZxLwL9G+
MBHK5lItl45RQ7yqWqJkyB5iuxmCi+/GJ8m1u33eT2iicN3re/YenykFVWN1TU8C
a7t9SXoO6Lxxb7KQ2nw6rTirTt/pGJHnw2PtqiIbGfzKSsCruhjK5TNtSMrCLK4k
ELWKooBaKaJYTDNqSBTUFIcsphCp7HnBbK3Z0Rdwe1BArM+NYe1HADK1CD27gnG3
1fI4TlccgJBONcYjwDFFZCIp+u4edm8jsQVxpMWxNZ82Kj1bzQ9YQAHCnBmeaqrw
GjnSDND4e/sQgRCyQRGFKYSVjC6GHQ==
=iotq
-----END PGP SIGNATURE-----

--Sig_/dK+EB9KUZ=EiGJ86C3pZRYg--

