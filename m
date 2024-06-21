Return-Path: <netdev+bounces-105597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFEE911ED3
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8EF1C20C35
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 08:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07262168C3F;
	Fri, 21 Jun 2024 08:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Yno2vHWz"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF39E15A49F;
	Fri, 21 Jun 2024 08:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718958710; cv=none; b=uF/feGe/wnOOaM2toBrWY9GlN5G61/8PmKkycD6JjcrdiH2h+4Kfw+Tba5S3PMLPXeHt0DKTmbnB0aO95vEL55/58JLR2Shsz6K3Z/4ZcoVsl6BNQ2V7rnXK/91AUntxJT30+28UrK3+TqXQn7qoHvNgFH+jw1sludTB2uXXqy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718958710; c=relaxed/simple;
	bh=64AumhhY/2mydXVgLDVm3LLcuAqw8+RNNOY1D4fSrAI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IBISvF7cFQ1lV0jKGdS6LcmywEHXkk0DjGVRqLs8W14RaG4V+sj1GA+kdTsMDT8XHXzzqpZygD/LZXsH/3ehTYgiSKycP2b/NKEPE6R/1HmM0V/gQT7jnIT/l7m56qnPGece3eVgcjKjGDUpoZe4XjUE1mrbLJPPyYEYJk7ZnXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Yno2vHWz; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id BFF2E8801A;
	Fri, 21 Jun 2024 10:31:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718958707;
	bh=tuEV4lzQ3hR3pnMshAwGcSSFCjmW5Yphlhn/htXJ0+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yno2vHWzmdZ7J/YUEFwi/k4Q9VVmxgKcrFd/GKSjjTWqUgYpdXdw7l8tufGI7N3OE
	 A4HfsK8piNK7dY29bmrzAFOnLalPpmrb/Yl0AbWLGCGOBZi8sSgzBziSbBXR7Tmk4b
	 ZDQyHYISMYIBQRpfo3U16gwwkmkzQ31nPEC1lcxPkTT4hOgqCK8Rgq+EQPmrG7JClD
	 43muob7JAFMNXPDBr6miKFEoRWyakCvk/rdslkeds05nNlgrxkcjAhvbUEM2RAHS6p
	 NbbPcNqmym/8DVsofmeIewxG2QNfH4gpamjUhyAnmIIhV9hrfrsfmrEXymcL3tbckK
	 KMoPGC5GystdA==
Date: Fri, 21 Jun 2024 10:31:44 +0200
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
Message-ID: <20240621103144.300a2c89@wsk>
In-Reply-To: <20240620143306.f6x25tqksatccqwf@skbuf>
References: <20240619134248.1228443-1-lukma@denx.de>
	<20240619144243.cp6ceembrxs27tfc@skbuf>
	<20240619171057.766c657b@wsk>
	<20240619154814.dvjcry7ahvtznfxb@skbuf>
	<20240619155928.wmivi4lckjq54t3w@skbuf>
	<20240620095920.6035022d@wsk>
	<20240620090210.drop6jwh7e5qw556@skbuf>
	<20240620140044.07191e24@wsk>
	<20240620120641.jr2m4zpnzzjqeycq@skbuf>
	<20240620152819.74a865ae@wsk>
	<20240620143306.f6x25tqksatccqwf@skbuf>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UCg4=tG4JP_WW=SiMRZBfHW";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/UCg4=tG4JP_WW=SiMRZBfHW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

> On Thu, Jun 20, 2024 at 03:28:19PM +0200, Lukasz Majewski wrote:
> > I don't have xrs700x to test. Shall I spend time on fixing some
> > perceived issue for IC which I don't have?
> >=20
> > Maybe somebody (like manufacturer or _real_ user) with xrc700x shall
> > test the code and provide feedback? =20
>=20
> One of the basic premises when you introduce a new core feature with
> offload potential is that you consider how the existing drivers will
> handle it. Either they do something reasonable already (great but
> rarely happens), or they refuse offloading the new feature until, as
> you say, the developer or real user has a look at what would be
> needed. Once you get things to that stage, that would be, in my mind,
> the cutoff point between the responsibility of who's adding the core
> feature and who's interested in it on random other hardware.
>=20
> Sometimes, the burden of checking/modifying all existing offloading
> drivers before adding a new feature is so high, that some offloading
> API is developed with an opt-in rather than opt-out model. AKA,
> rather than the configuration being directly given to you and you
> rejecting what you don't support, the core first assumed you can't
> offload anything, and you have to set a bit from the driver to
> announce the core that you can. qdisc_offload_query_caps() is an
> implementation of this model, though I'm pretty sure the
> NETDEV_CHANGEUPPER notifier doesn't have anything similar currently.
>=20

Thanks for the explanation.

> That being said, I think the responsibility falls on your side here,
> given that you introduced a new HSR port type and offload drivers
> still implicitly think it's a ring port, because there's no API to
> tell them otherwise.

IMHO, the above problem is not related to the patch send here. It shall
be addressed with new patch series.

>=20
> This is not to take away from the good things you _have_ done already.




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/UCg4=tG4JP_WW=SiMRZBfHW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmZ1OnAACgkQAR8vZIA0
zr198wf/bEx68TGKPmw4TLnFLrjDWDM1YOta+wHSIiWnYQ6wNEbKYDgE23L3IJna
CD6ZaK1Sc9u/nYD8bPo/mbc4AohtoM5Ut/g/6KBxWN02OTtXu8hPYozJBmxxp6j0
T9c4JDQfNMwclWoRy8lxQviALg8FRhV7Rn3HjIfxC3S8Tv6iAF4UhpJ3W8wCICkg
AeheTSpbX8SIqLGJh0bJ9a3J7oTKeEpPv72doqWiw37LVI5ThKWbqHLwejcsiQh0
P3VnHGLYQaOshWgb9CO7IuAFnS31NAcykmFAyVu/hjvk4+uDTSq+90PShJlKPwaP
PFBvT8vLM92ZoQtxXIdDbhGUPWSP8w==
=Hpok
-----END PGP SIGNATURE-----

--Sig_/UCg4=tG4JP_WW=SiMRZBfHW--

