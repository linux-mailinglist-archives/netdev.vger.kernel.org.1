Return-Path: <netdev+bounces-149520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D89A9E60AA
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 23:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69E81884A5F
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 22:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774731CBE8C;
	Thu,  5 Dec 2024 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="f3D9Alux"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA701A76A4
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 22:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437951; cv=none; b=fmmQ+rDvpHiaEy7BUugX12AkGdZOxbHFYUrlUAVj4OwMMpz+9zd2P10bGj7Eya4bqs27w5wpKR4QI18ids8FMzLbnKoQ1+A0rmIkxjoX5Lbv9SA8IVWXfJCgZdss4yT0RhZll5vYoEY/Jcx3kwHbQME4FLKYFYYw4yIQ8dzM2+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437951; c=relaxed/simple;
	bh=GAQPSL+6KE4W/R3eWmNrtMl1lDlF8aLiHWoaCh81R00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PigywhrE+yBSahgCkkAdwNy+6f6cHaCELiWMNTBt4tYSbd7vk5F91DFm9RKWZt2rHaW7YrJDRwawTY2ygMzYQ3zp6tGnfkED7YPAMYdRd5IWlYK+ToD4lu/g8JsYa+pbfbwu8Ag+p3uylihYpD8ZcX3NpKkEcXilhbRuiruZ+FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=f3D9Alux; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202410; t=1733437940;
	bh=0oXY7f0Ixis+3QMJvMpgsN0tjG1mpKHcvCpo3mDdgFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f3D9AluxvwSpcd3uawaIEUobpvY6ww2dA+PZctgd9Kgzaigeizp5ALPq0p0Zpb3Nm
	 S+nnsB86R76LSsEQXBrvEQzVzLfZPeNdOtu6QSK8vZBlQ0bEI+xWjnULHJZwHkeM4H
	 ZD12qs0jJYRVKPupDs6SECzaxkB3tNtXN9c8u1GXAgl7lN1L/XgpCJ4sfyRyp+Efe/
	 sw6XJ7NIXdVa063/RFhMAfcIIqY+ffSoaZjwbuo/UhAwTdFAchJVa1VJlOGpbcwxpw
	 /NlsDZXmWGN3luDXdKRhwnFaEZkcUb1/DGOayTbNVUaH/SzpAIThITDZW9y1lbuBQ2
	 IAlQF3nazmMDQ==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4Y48K05cYrz4x68; Fri,  6 Dec 2024 09:32:20 +1100 (AEDT)
Date: Fri, 6 Dec 2024 09:32:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Eric Dumazet <edumazet@google.com>
Cc: Stefano Brivio <sbrivio@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Mike Manning <mvrmanning@gmail.com>,
	Paul Holzinger <pholzing@redhat.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Cambda Zhu <cambda@linux.alibaba.com>,
	Fred Chen <fred.cc@alibaba-inc.com>,
	Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
Subject: Re: [PATCH net-next 2/2] datagram, udp: Set local address and rehash
 socket atomically against lookup
Message-ID: <Z1Ip9Ij8_JpoFu8c@zatzit>
References: <20241204221254.3537932-1-sbrivio@redhat.com>
 <20241204221254.3537932-3-sbrivio@redhat.com>
 <CANn89i+iULeqTO2GrTCDZEOKPmU_18zwRxG6-P1XoqhP_j1p3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rNHhf7gjjDW4r+9k"
Content-Disposition: inline
In-Reply-To: <CANn89i+iULeqTO2GrTCDZEOKPmU_18zwRxG6-P1XoqhP_j1p3A@mail.gmail.com>


--rNHhf7gjjDW4r+9k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2024 at 05:35:52PM +0100, Eric Dumazet wrote:
> On Wed, Dec 4, 2024 at 11:12=E2=80=AFPM Stefano Brivio <sbrivio@redhat.co=
m> wrote:
[snip]
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index 6a01905d379f..8490408f6009 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -639,18 +639,21 @@ struct sock *__udp4_lib_lookup(const struct net *=
net, __be32 saddr,
> >                 int sdif, struct udp_table *udptable, struct sk_buff *s=
kb)
> >  {
> >         unsigned short hnum =3D ntohs(dport);
> > -       struct udp_hslot *hslot2;
> > +       struct udp_hslot *hslot, *hslot2;
> >         struct sock *result, *sk;
> >         unsigned int hash2;
> >
> > +       hslot =3D udp_hashslot(udptable, net, hnum);
> > +       spin_lock_bh(&hslot->lock);
>=20
> This is not acceptable.
> UDP is best effort, packets can be dropped.
> Please fix user application expectations.

The packets aren't merely dropped, they're rejected with an ICMP Port
Unreachable.

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--rNHhf7gjjDW4r+9k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmdSKe8ACgkQzQJF27ox
2GfhHBAAo+2dwc0eI19fmPUEIy9Nnzj8xmzWMmxuF+X2gnya6Ja076ulo/+ZiDpm
VTgwBhrB2qAJ3fS6KSbjdHDahRc6doKSqrZv8PFZ9AA7va1/v3awmMlspoCdgskl
b4lWl3Sn8nDAUEp7NxRczjCdAr1y4OjgC6IJurJ6FJERNyeE7bSA/3slVH9WTSbo
vzjnBHP6kzIz2AOSZhqGJhHj6PXb2IqiQ+JRyO7gCAjzHuRpM7t37BMeA2gNQ1Tf
Y5A0TdHHDhrsjcgE6XNUQbyZS4adxshRgnz4104Y1kEpBBwl/tQy25vuH+WVxhRV
ntG0PbU7KkQBy9CR6C8eX/ppZC++4Lsv1yJ6u60VTSFqTtCN1a7PQT0nTb+Rdrzj
94DlvQ6MHXzpOuIU392yaiObfDscfSQZvPbCfOujiV5hwlzMbVLlucYWMtdQNoDZ
/16+3XjPQ09VWRzHjQtqF7LriqLd77qkctoRPGsmydzwj4lhrQM6DOb0ef1YsYD3
rhs3x/Ed2ccDjXw5q5eRNFRs0zcbtMDJJPWbgJgUiQusMGTOEDcj/hn0ApjAwXJx
IYZXgDjTTZacjbOnZywoU5cWmqisKDQn0NuvngJyHNT9kWlDe4bPwlUAOlIxzUzE
oFDoF+0gWXMVRiGyhHD6nhtwnYOA+dU5xJN9eNMekA9mnvpg+Z0=
=Qv45
-----END PGP SIGNATURE-----

--rNHhf7gjjDW4r+9k--

