Return-Path: <netdev+bounces-80709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81903880836
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 00:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16FE5283E9F
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 23:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5835F87F;
	Tue, 19 Mar 2024 23:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nKCG2oyC"
X-Original-To: netdev@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA7E2DF9F
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 23:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710891404; cv=none; b=RaBkfoVr5Q5Tds5UBw0CGeh6ZrO/xS53O0WnzzNgQA43qexhdzIxVXbOym+jSqNaErn6/AG7CPCpbPbFx36Kk6LGniiVkfYbkDZHHqZIuWp7U6ZV4f2Q401+0GzMUSFS+H+6T3ozdDce6svLFhvC58qx+CTZwBFBmjnLUdfvs1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710891404; c=relaxed/simple;
	bh=74gV/9jSsE0Ovt7RAtv6FJPQwQxo5hKFzYkK3xh223g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvVsxiG9PpwkZYbnBT42knTOPdGDb70Z22NYEbs433J/DPm/3dmrW8WoQkKXQVZ2c3WRfUkHrr9x/Rie7phA7YM4RgYyeuCFgJ/ipnzb18VXRCyJAxs4sk4+/rMsdbtm9a2wWQlbQAzOidJLl2eBvAZ4H+ElsO4DuznkZmQwIvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=nKCG2oyC; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202312; t=1710891397;
	bh=5RC1KC8OZQMcmcnRWXB8DN7qF8RbGLBvgAOX1y4YO7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nKCG2oyCh8dQdEfYKeld/8R9gSRhOdX2cJdgMB4jf+Ty5zOmIvFM4kTCejNgVbuoZ
	 iNoywgz6atVrN5zt1BaPqMklyi95B8glY0v+MenfCTeGE4jaukWrBsI015RD2rnMUc
	 sjiYslyzq8gsBN3PfL9RAbMO5wP/a+evm0lUSsIIU6niMm9acYKorlU9Z5SEJ35DeW
	 i3IWiMhA6FEyiM5iAZJxkgNBVSxhqDaQgZw+Fyiv4Fp3yh6SNwfrlcqL+8g1svfWCV
	 UAQq81drvcA+ztsuneR9WZz0TiMA4ID1p/02P94tieXGtJnH4fq5HvicbtTiY/OHuR
	 c+AceGxgEUtCg==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4Tzp5d2VKyz4wnv; Wed, 20 Mar 2024 10:36:37 +1100 (AEDT)
Date: Wed, 20 Mar 2024 10:36:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stefano Brivio <sbrivio@redhat.com>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	jiri@resnulli.us, idosch@idosch.org, johannes@sipsolutions.net,
	fw@strlen.de, pablo@netfilter.org, Martin Pitt <mpitt@redhat.com>,
	Paul Holzinger <pholzing@redhat.com>
Subject: Re: [PATCH net-next v2 3/3] genetlink: fit NLMSG_DONE into same
 read() as families
Message-ID: <ZfohdcQvfdqvkoWT@zatzit>
References: <20240303052408.310064-1-kuba@kernel.org>
 <20240303052408.310064-4-kuba@kernel.org>
 <20240315124808.033ff58d@elisabeth>
 <20240319085545.76445a1e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Rc7AiQ8Xv5Ul3/ih"
Content-Disposition: inline
In-Reply-To: <20240319085545.76445a1e@kernel.org>


--Rc7AiQ8Xv5Ul3/ih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 08:55:45AM -0700, Jakub Kicinski wrote:
> On Fri, 15 Mar 2024 12:48:08 +0100 Stefano Brivio wrote:
> > > Make sure ctrl_fill_info() returns sensible error codes and
> > > propagate them out to netlink core. Let netlink core decide
> > > when to return skb->len and when to treat the exit as an
> > > error. Netlink core does better job at it, if we always
> > > return skb->len the core doesn't know when we're done
> > > dumping and NLMSG_DONE ends up in a separate read(). =20
> >=20
> > While this change is obviously correct, it breaks... well, broken
> > applications that _wrongly_ rely on the fact that NLMSG_DONE is
> > delivered in a separate datagram.
> >=20
> > This was the (embarrassing) case for passt(1), which I just fixed:
> >   https://archives.passt.top/passt-dev/20240315112432.382212-1-sbrivio@=
redhat.com/
> >=20
> > but the "separate" NLMSG_DONE is such an established behaviour,
> > I think, that this might raise a more general concern.
> >=20
> > From my perspective, I'm just happy that this change revealed the
> > issue, but I wanted to report this anyway in case somebody has
> > similar possible breakages in mind.
>=20
> Hi Stefano! I was worried this may happen :( I think we should revert
> offending commits, but I'd like to take it on case by case basis.=20
> I'd imagine majority of netlink is only exercised by iproute2 and
> libmnl-based tools. Does passt hang specifically on genetlink family
> dump? Your commit also mentions RTM_GETROUTE. This is not the only
> commit which removed DONE:

I don't think there's anything specirfic to RTM_GETROUTE here from the
kernel side.  We've looked at the problem in passt more closely now,
and it turns out we handled a merged NLMSG_DONE correctly in most
cases.  For various reasons internal to passt, our handling of
RTM_GETROUTE on one path is more complex, and we had a subtle error
there which broke the handling of a merged NLMSG_DONE.

>=20
> $ git log --since=3D'1 month ago' --grep=3DNLMSG_DONE --no-merges  --onel=
ine=20
>=20
> 9cc4cc329d30 ipv6: use xa_array iterator to implement inet6_dump_addr()
> 87d381973e49 genetlink: fit NLMSG_DONE into same read() as families
> 4ce5dc9316de inet: switch inet_dump_fib() to RCU protection
> 6647b338fc5c netlink: fix netlink_diag_dump() return value
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Rc7AiQ8Xv5Ul3/ih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmX6IXAACgkQzQJF27ox
2GcsBA//fZxoI0ikttxcucGdrOiiWmRIVJpnt3ADpbgc8vi146uP16rpRgJDHAHc
E6z+Hx72LdE7xpZKXkFHbsn7yhBdkLjy5rryS8Nza+eL6X/+dfrvFRRn8Zg1ZvT3
nnN5474/laNrHoHqhpqGsY2tfQLep8R8vCjnEPJtrMZFFD0evlABNvhYfgoo7OOq
vlVKwYmnW0ooHJXY8bGFFwEiSFKsOG61yEm6LIRFtV4rv+tot5SEbj8E4L+hx2VF
IL3wLOLBDBmxwlj/HvZVu+IEflrK1k6EJTjBbwV/wiSSYq+yDK8btZkAgPJqZfzJ
bTNa8tTzB4rB0KQb9MkOXLRCfB2ADJ4K4BxqR04616YDOABNMqVFlPdbfzeEwX+h
4O806bK+3h3g4r1IzCFP3c9ULFBv5VTZi9oTy2sHXVqSe05rWLgaRX1mfQ1EAoog
lDkwlgon5sNCepBpSTRuNk3I3DBpjtMTBR1/sU303Z5kldYI2ClMC0wYSeEpVg+K
28oPqSPIt1GySIunckMTPBqVugwgr1v+FmcGafa+Pp68chZ/NSULPjROSPTgXZgK
suLMQn0S9Cu/Kbt8vwGFk4G7y2DdtjmZYUM8fi1LfJGTV7RczJq2LS/YuOXMHjdw
O/kxga9iNK3zusOOoG73qGR+LlYiKdTz33II7OjwlO8uI+GBcDQ=
=oco4
-----END PGP SIGNATURE-----

--Rc7AiQ8Xv5Ul3/ih--

