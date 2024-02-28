Return-Path: <netdev+bounces-75597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2D986AA60
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 09:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C36C1C21787
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 08:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B892B2D056;
	Wed, 28 Feb 2024 08:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="PhAJvBRV"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08992D046
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110049; cv=none; b=ab6hDWVicD7DmpL8a/JDpOThn5yPfd7FECpqHOWNHdP8x4gEFXkrXhUigWzNYLU5n+ZbGQQ9DqHicEnM6FTEQGBJC6VfZVd06zUgGr68SXZamf8dkR6VbYa5Qf/zjCBzxIjTWcNu/NkVQ3qtMIMA/6WS+NwQ7SNxmyuKGApZ9qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110049; c=relaxed/simple;
	bh=Z9/wdtQ1ru6upjNXGw5IuXg0cneKdPME8aRX7+WLIaA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l8bGYl7WN61KLtgRzlAryep7ooqOCogWsqMpsEqV86XL/DA1iHSXxcDOZVlyDdS2ob5Fef58ZA+J5eZXYt6SD9UmtZjYV1LtOUrKHaJQtzw/Nldkg6Oiu4wWbq3ZjV2j0pJHN6YUd0xNJvCQgbmz4NEsnXZr74cJi7AXaaBSTZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=PhAJvBRV; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id E07A987DC8;
	Wed, 28 Feb 2024 09:47:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709110040;
	bh=JlgmBjz8gukCGiJ8CDDs8in+o5lRcWaw9kvgoBZtys4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PhAJvBRVXTpxrtMgo6G0bNZ7uEROXo7H7RQwh+Q8Jk50NLHRnBRPwmHPcNFpKhedC
	 EOWiCBTGyBfuxH9hXDNIU99Ih3LrjmqUVzY93FTGAa2QsWNs7IkZF4YowUafrDno6M
	 KN5h49PUhlvj1xUTYnTOe4rYz4KJNlmhb0QbTxSmu6f4tETmr/SBajOZw9ePjunWQB
	 C/GB1keBDqST9nZSVAD7Y0zkowYLQz3GSFTF9ecxgIrv491VpQ9uZbon6Nhm2+4IEs
	 B590H2OzSGt2j6TljFJylOGFxgZu7g/dbyzzjuMFW+nvLvO0cD9UYWRpwJVO8Vm20l
	 XSxVjFyp+Sfzg==
Date: Wed, 28 Feb 2024 09:47:13 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Simon Horman <horms@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Tristram.Ha@microchip.com, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] net: hsr: Use correct offset for HSR TLV values in
 supervisory HSR frames
Message-ID: <20240228094713.3c82b6a0@wsk>
In-Reply-To: <20240227174935.GJ277116@kernel.org>
References: <20240226152447.3439219-1-lukma@denx.de>
	<20240227174935.GJ277116@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ldfn9Hb.1cDWZBRIkhbxHdF";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/ldfn9Hb.1cDWZBRIkhbxHdF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Simon,

> On Mon, Feb 26, 2024 at 04:24:47PM +0100, Lukasz Majewski wrote:
> > Current HSR implementation uses following supervisory frame (even
> > for HSRv1 the HSR tag is not is not present):
> >=20
> > 00000000: 01 15 4e 00 01 2d XX YY ZZ 94 77 10 88 fb 00 01
> > 00000010: 7e 1c 17 06 XX YY ZZ 94 77 10 1e 06 XX YY ZZ 94
> > 00000020: 77 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 00000030: 00 00 00 00 00 00 00 00 00 00 00 00
> >=20
> > The current code adds extra two bytes (i.e. sizeof(struct
> > hsr_sup_tlv)) when offset for skb_pull() is calculated.
> > This is wrong, as both 'struct hsrv1_ethhdr_sp' and
> > 'hsrv0_ethhdr_sp' already have 'struct hsr_sup_tag' defined in
> > them, so there is no need for adding extra two bytes.
> >=20
> > This code was working correctly as with no RedBox support, the
> > check for HSR_TLV_EOT (0x00) was off by two bytes, which were
> > corresponding to zeroed padded bytes for minimal packet size.
> >=20
> > Fixes: f43200a2c98b ("net: hsr: Provide RedBox support") =20
>=20
> Hi Lukasz,
>=20
> The commit cited above does seem to be present in net or net-next.
> Perhaps the tag should be:
>=20
>    Fixes: eafaa88b3eb7 ("net: hsr: Add support for redbox supervision
> frames")

Thanks for spotting it - I must have overlook it when preparing the
commit message.

>=20
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de> =20
>=20
> ...




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/ldfn9Hb.1cDWZBRIkhbxHdF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmXe8xEACgkQAR8vZIA0
zr0cGQgAhp+BHfbGgYVu3Zkki8LeZ+fs1PQDaMlllwt9FgjsxDAXYU6pUn+MYKZj
n4XA9bsOKkx+K7DcPkesajJ310P0Cyl4dyuXxEGwzNrgRMD0AxlqqAtqyBp6YqUJ
UP3EUw10/Gn8NPZmeGifvWMJQe0bufmX5rEpKflXLumqBiu7bv1P7rIbv73SjEil
Mf00+a5ZVNC9MoRJsmkG7tutWB4N+oWTc85gaU3dFojZX76e6I6CH7W7p9/E5tmf
3EPIhoVDRNzHcm2lChFAA09Mfkx6NRNo7tdK8436egnloHWIVsUKmmNJX1mTwdpA
G5TNLqlK+sQv4gM7VA0tGAdBoG4mhQ==
=LGwq
-----END PGP SIGNATURE-----

--Sig_/ldfn9Hb.1cDWZBRIkhbxHdF--

