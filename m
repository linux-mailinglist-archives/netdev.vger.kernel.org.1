Return-Path: <netdev+bounces-92065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C157B8B542C
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 11:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC6C5B20D98
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 09:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB9B2030B;
	Mon, 29 Apr 2024 09:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="b5f2wPjl"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7001214A8C
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714382691; cv=none; b=lho4I4DdhkjVylBO9QwnJkzpDiStIQhQOD1DC3blhVIRgfNDOMsJl42Pp921rWG4w1T/3+kYMuPLP13UICNKZWbB2N8Cozb/Xo6qrDNxoJx9SCx1hzGt1SqF9H61R9KTAZterkvyDbSvUh3Q9PmBCPMFss3hgOblrrSFabatyOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714382691; c=relaxed/simple;
	bh=QZKAIgYv0YUnSEbwB1mnjnCgd4w++HiIDdLkMxQqCko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tx6rPdwJKCdSxyycyvVTbLkpz5bdDmLnAs/UmMVQS5TtUe2r3ajkHqo5FsCGAXY/S7fGAcsBXt2Noa8N6uG1AN5rEKwonW6AJR17GadSvHJSnXsVCfuvqwhS18kHNKqqDzTXRJfHtcV0GbdtJgOVHBVL9w2CF8bu+0PSCsQqhW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=b5f2wPjl; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 5A4DB8893B;
	Mon, 29 Apr 2024 11:24:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714382688;
	bh=jsjoLlHLQ5d9L80+Wain/g9vnNzzF3+N8ImiI8DzZlA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b5f2wPjloLU9Ysl6JcIzAmQBhMYUCQDHfWGobAOykuz8J1XTrSI/NQ45FCGhK4eUA
	 q/3J4GnNmXpJcfIW9ReiGNvKeqn+0OitSnC/0Qa0P8W1EHwcAbvZWe0sjV/NYCYXIL
	 n6i1BsmLsXz2agJRIzZDEJhk3G5QbFOSiHB6ghY10hMUHAJUf1zQ2/ZzJ3teXgddJ6
	 zCWRsMUgX5YLApVNevmsQZtJQk8CudZGk9bckXC5IlXj4v/ZBU69BP8bgzFVIP0h/p
	 GLR6P+ShPYm+Qh5xd+xWsCPXg4ISE4GIpclLh7uZq1ot8s0jux6ABSB0BJtUOIUGKm
	 FylPY4mdq7JXQ==
Date: Mon, 29 Apr 2024 11:24:42 +0200
From: Lukasz Majewski <lukma@denx.de>
To: David Ahern <dsahern@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Stephen Hemminger
 <stephen@networkplumber.org>, Eric Dumazet <edumazet@google.com>, Florian
 Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [PATCH v3] ip link: hsr: Add support for passing information
 about INTERLINK device
Message-ID: <20240429112442.122243d7@wsk>
In-Reply-To: <4c089edf-5c06-4120-a988-556a1f7acf58@kernel.org>
References: <20240402124908.251648-1-lukma@denx.de>
	<20240426171352.2460390f@wsk>
	<4c089edf-5c06-4120-a988-556a1f7acf58@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PQ661UwgH+HnAueq7wTj1zD";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/PQ661UwgH+HnAueq7wTj1zD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

> On 4/26/24 9:13 AM, Lukasz Majewski wrote:
> > Hi Stephen,
> >  =20
> >> The HSR capable device can operate in two modes of operations -
> >> Doubly Attached Node for HSR (DANH) and RedBOX (HSR-SAN).
> >>
> >> The latter one allows connection of non-HSR aware device(s) to HSR
> >> network.
> >> This node is called SAN (Singly Attached Network) and is connected
> >> via INTERLINK network device.
> >>
> >> This patch adds support for passing information about the INTERLINK
> >> device, so the Linux driver can properly setup it.
> >> =20
> >=20
> > As the HSR-SAN support patches have been already pulled to
> > next-next, I would like to gentle remind about this patch.
> >  =20
>=20
> You need to re-send. It took so long for the kernel side to merge, I
> marked it as waiting upstream.
>=20

I've just re-send the patch.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/PQ661UwgH+HnAueq7wTj1zD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmYvZ1oACgkQAR8vZIA0
zr2Vxwf+KSXk1giUTMxRBmDG6HJ7nPLV5yiwj0VRKxfXYcDAaqM1iFJgMGfyFd4L
dfB/BgXhsB+naDVEKjV0L/t0INr4GTD5sldqbuD+XS8B1yL/F7DFtJhjn+jtzyn6
3bh1KCKjeFwaiuLXqHH6DZmVjPazak9qauor3m3EBG4I4F1J9z3zPYKYU6RkACko
rvJ0nwwID0YTr8i1aWfkc0ACzwhtUHO107UMWhMOZDNGlXQVAKCXnGSqY3K0Ilv4
RaXeuE5VwvImTkzVaw51A/XuZl2pn1obfqN7NoS4v0c0987wqASuobxUHbHXa4Kw
ZVl+9Ij0wLXetxDgpaom0jFbAhFYZw==
=z9FJ
-----END PGP SIGNATURE-----

--Sig_/PQ661UwgH+HnAueq7wTj1zD--

