Return-Path: <netdev+bounces-145149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ED39CD5A8
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 04:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B55B1F2211B
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 03:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DD57DA67;
	Fri, 15 Nov 2024 03:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="LdS9tnJe"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104463201
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 03:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731639713; cv=none; b=sX1WqhzhBT9Xhy7+rQ5wVhp4qz1v2k9H1UNgqRlGS4FzvsIk8DJTnGEK48teVYKmwKRHhwLwvCQmu5snnjQXdausqsIQB7dIZf3/kYzTwtjY/kx5odpuYI0B8AUBC6td06cOllzEfn1swusz11NCXAz4C/QbahHhmInlmUQMgVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731639713; c=relaxed/simple;
	bh=iuqcygIRYKVkTVRwUhAYW/MTEjeuWV0afDSig4sbg/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkGB1XdO8/nKA1TXEskU8vSn1zOABry+3ZEaE9zTAgWPTTTpr+a91KJEVy4VmLrSooAix2lzi+WMeFKPtFNYQ3wjWYwOuWo/v+C4c3zIcYs2r0M9UsDh3OTYxdKddtEiQbWad/D8oDWZpMI+Ut64qJR8rJ/3AbP9Coyb8vGMOQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b=LdS9tnJe; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=gibson.dropbear.id.au; s=202410; t=1731639703;
	bh=hRb/zjSfHIpGBkdSs91re7vjzZsz5NQGkZ6zh+McxxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LdS9tnJeblkk/04zNhoyNxy6MJ7qd+2rmVpjjS6SVz31HGhKopyjxcf1RDQJecPsw
	 vlqbCO+mZsOn1+62soPH9UmLni1bO5dtEHz8xYIN3fiM5YD/pPDdGs107TJM/Q5AuL
	 auPoBSNkL8MKywxBMJiNPxRpknBZcMXGB9nlItCAH6MZuTO8vNEsTBaw2FaU7I4t0w
	 WX46jUi58muYijJNlqo4r2o3RpiuHUM9emYSeWGZz7354Pb1GMV0HjcG9saedWUnGy
	 roeg8QEK5klc+WB+s0KHgz+rp2F3+6kH0DW6KB22nUBK0YTyErsJ2ewzL3Bmyf0iME
	 qcUstS5zJcScQ==
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
	id 4XqMHW1bMQz4x8v; Fri, 15 Nov 2024 14:01:43 +1100 (AEDT)
Date: Fri, 15 Nov 2024 14:01:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Mike Manning <mmanning@vyatta.att-mail.com>,
	Ed Santiago <santiago@redhat.com>,
	Paul Holzinger <pholzing@redhat.com>
Subject: Re: [PATCH RFC net 0/2] Fix race between datagram socket address
 change and rehash
Message-ID: <Zza5gypLK6jWDWov@zatzit>
References: <20241114215414.3357873-1-sbrivio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u1lpROhSmwxlKZ0S"
Content-Disposition: inline
In-Reply-To: <20241114215414.3357873-1-sbrivio@redhat.com>


--u1lpROhSmwxlKZ0S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 10:54:12PM +0100, Stefano Brivio wrote:
> Patch 2/2 fixes a race condition in the lookup of datagram sockets
> between address change (triggered by connect()) and rehashing.
>=20
> Patch 1/2 is a small optimisation to simplify 2/2.

These both LGTM, but I don't know the code in question well enough to
claim to have done a full review.

--=20
David Gibson (he or they)	| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you, not the other way
				| around.
http://www.ozlabs.org/~dgibson

--u1lpROhSmwxlKZ0S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEO+dNsU4E3yXUXRK2zQJF27ox2GcFAmc2uYIACgkQzQJF27ox
2GfHlA/9HWPWQ/BZBF7UplWE73xNKKB5goBOaIi3t8xRmRtqoZe3H1V6Ok7edE5m
1BDn/IIYw3LNN9oGzVrHQJlznHv2W+ICs5l8NYpjdyTSk4hJyk7tgjHmajahe+pe
eFkDYMMgmKU/kPZYu7MJHUoPTYXgpd0y3gEGKoGgLugk5pylj0s2TsS4Qt0xhlnh
yNMcWeggy8aE0oplijBe3oJA0LZBXhaNcSwqadvUWmTqbK7y9Lyoaoo1EV2NiDLq
GXXjN1+i6Lx1h+FYePvhxM8d8aWrFPCy0myi3cDtGQCzoIgbQFg2tb9QOXm2gss1
at2VbSbhUxD5K6Te15mJKpkqAdF2C7cQXUs+kh2iYRdiHVGFYMrcZYBjYQSj/joG
dcQQD7Kz+xJNu++XQ5CV95gEUU0Gwu7nbGkcpUSmGc50Du562bhSHW4ecdEM7PxY
MEj7YE1UvFKFnk1H7LhkgGegZGt50UbLvyFlcuMFvDHUjUA6uUw2+aAr30oc3P0R
0SsNFN+LbloNIbhk+QQHEwt06GMO6twNRRckoRCCMfqy45OdQVM9AWH6ATnrz0Kn
AqCSVSdu7e1FGP3bgtRpmaVdjqSevmXeyTfMZN4zoS+KIkKNJlNgf0cJbEQZbbFu
a7pzBTm0wjy0HTeej3N8GFKe5mS/kFaLQFHzeeXLOhPAUGjVxgI=
=P+bZ
-----END PGP SIGNATURE-----

--u1lpROhSmwxlKZ0S--

