Return-Path: <netdev+bounces-189448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D040AB2224
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 10:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76471BC5B0B
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 08:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85911E9905;
	Sat, 10 May 2025 08:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ovsafr1I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1053D561;
	Sat, 10 May 2025 08:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746865217; cv=none; b=mEiIBvl+3mPtmH8G2P4AxGwFaTtxZDFoyDBbUAtqtt7/EByuZ5j4qqXOYOz8GtZJggC+29+uZzmYGKpqg3DF9Q0CGtSTNB9jLpwWBy+mXa126xjvSjilIp8b2zCtTWl1BrY1QeKmLE5NITtM1M1i9nIiU6iTgsWqxoW6WhpPtf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746865217; c=relaxed/simple;
	bh=w4KCtfNN++3rTxuFj1Y4PcCXB490W9C1G146sr8flJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sweLRFdF3Gql1sT7N7QCNTobXjLraTVY8cOHvRWwVa2qk0ws5bjgz6EFzQ7r2jKT+9d0/c02+fw4xGJg0ZLdmXjIIMZAf9SpdlCN7AxGay/nfO9w7wUps7u116x+9o0NyOKT+MG7Mq69j1HAkXeDc2mgMxM1iTsyVrmJGrnszsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ovsafr1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0830C4CEE2;
	Sat, 10 May 2025 08:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746865217;
	bh=w4KCtfNN++3rTxuFj1Y4PcCXB490W9C1G146sr8flJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ovsafr1IoxltalBpWEdz0LRdhvqKYCKnVgsC+Vf1jGoTlQa8kTcrVqMddNZ9jxlGx
	 NsSZnwuns+gK0X7hsYK5kHY7+tv3l0Nz8CjPhoYHdPXCF3678/kL56DbxnAtJ6Dm8c
	 hfvz+XXtlGWevcAN0Kt/M/3Nm6tKw3+SIMuWThSODPIHMoli0nXWiNNMlaDGX2Cdhr
	 yvaAnWPq/C34W7kk9VhP1ArPoAgmx/6aX4+j1kYOXdxwqId3K8uKrV8E3YIHbh4Oi9
	 5Ka4dw3rSJqhJ7duWnZ8/z9zvwQ/1FT+Zn1pnpUQQ8NntaD1WvfQ+jZN8GZpIQwVD+
	 PI7AGINwOgXzQ==
Date: Sat, 10 May 2025 10:20:14 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/4] net: airoha: Fix an error handling path in
 airoha_alloc_gdm_port()
Message-ID: <aB8MPkMYXWvoaA03@lore-desk>
References: <5c94b9b3850f7f29ed653e2205325620df28c3ff.1746715755.git.christophe.jaillet@wanadoo.fr>
 <aBzOaiU6Ac3ZTU-4@lore-desk>
 <68149c51-ba75-4f0f-a86a-bd810d47d684@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1vz8AGLIu0dXvB1F"
Content-Disposition: inline
In-Reply-To: <68149c51-ba75-4f0f-a86a-bd810d47d684@wanadoo.fr>


--1vz8AGLIu0dXvB1F
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Le 08/05/2025 =E0 17:31, Lorenzo Bianconi a =E9crit=A0:
> > > If register_netdev() fails, the error handling path of the probe will=
 not
> > > free the memory allocated by the previous airoha_metadata_dst_alloc()=
 call
> > > because port->dev->reg_state will not be NETREG_REGISTERED.
> > >=20
> > > So, an explicit airoha_metadata_dst_free() call is needed in this cas=
e to
> > > avoid a memory leak.
> > >=20
> > > Fixes: af3cf757d5c9 ("net: airoha: Move DSA tag in DMA descriptor")
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > ---
> > > Changes in v2:
> > >    - New patch
> > >=20
> > > Compile tested only.
> > > ---
> > >   drivers/net/ethernet/airoha/airoha_eth.c | 10 +++++++++-
> > >   1 file changed, 9 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/e=
thernet/airoha/airoha_eth.c
> > > index 16c7896f931f..af8c4015938c 100644
> > > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > > @@ -2873,7 +2873,15 @@ static int airoha_alloc_gdm_port(struct airoha=
_eth *eth,
> > >   	if (err)
> > >   		return err;
> > > -	return register_netdev(dev);
> > > +	err =3D register_netdev(dev);
> > > +	if (err)
> > > +		goto free_metadata_dst;
> > > +
> > > +	return 0;
> > > +
> > > +free_metadata_dst:
> > > +	airoha_metadata_dst_free(port);
> > > +	return err;
> > >   }
> > >   static int airoha_probe(struct platform_device *pdev)
> > > --=20
> > > 2.49.0
> > >=20
> >=20
> > I have not tested it but I think the right fix here would be something =
like:
> >=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index b1ca8322d4eb..33f8926bba25 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -2996,10 +2996,12 @@ static int airoha_probe(struct platform_device =
*pdev)
> >   	for (i =3D 0; i < ARRAY_SIZE(eth->ports); i++) {
> >   		struct airoha_gdm_port *port =3D eth->ports[i];
> > -		if (port && port->dev->reg_state =3D=3D NETREG_REGISTERED) {
> > +		if (!port)
> > +			continue;
>=20
> I think it works.
>=20
> We can still have port non NULL and airoha_metadata_dst_alloc() which fai=
ls,
> but airoha_metadata_dst_free() seems to handle it correctly.
>=20
> CJ

Actually, in order to be consistent with the rest of the code where a
routine undoes changes in case of an internal failure, I would prefer your
approach. Can you please post your solution in the next iteration? Thanks.

Regards,
Lorenzo

>=20
>=20
> > +
> > +		if (port->dev->reg_state =3D=3D NETREG_REGISTERED)
> >   			unregister_netdev(port->dev);
> > -			airoha_metadata_dst_free(port);
> > -		}
> > +		airoha_metadata_dst_free(port);
> >   	}
> >   	free_netdev(eth->napi_dev);
> >   	platform_set_drvdata(pdev, NULL);
> >=20
> > Regards,
> > Lorenzo
>=20

--1vz8AGLIu0dXvB1F
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaB8MPgAKCRA6cBh0uS2t
rA/HAP9Zi1+4C2rxgiwNRJbwEjcF5j+ybpugyU0dEY4lrRu2EQEAybkmU3Kx+5HH
BBgU9PCKsxYpYZbJameFHUNS4FU14AA=
=nxAu
-----END PGP SIGNATURE-----

--1vz8AGLIu0dXvB1F--

