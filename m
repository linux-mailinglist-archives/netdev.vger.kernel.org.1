Return-Path: <netdev+bounces-36987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 805D17B2D45
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 09:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 8F783B20B13
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 07:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E65C2CE;
	Fri, 29 Sep 2023 07:52:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710C8468F
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 07:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A4FC433C8;
	Fri, 29 Sep 2023 07:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695973943;
	bh=5VxIhD3NW70ttcgF2s/pCBnAMixKqUXxXvkKXyGcaAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uK5hb5zpAEYxJcscT5yMfpCLEaS0m7H/2dcFgQk9K8BQlg1NzBWpivwaVU5Cotd8K
	 JnUmcCGY3f3ZsyicXXaUMgfAsRGjp7x541R8wWWV48MiDXnnJpm1+NEhUOjLcDxubn
	 KIMTa8pQhoLCpz8R+0FFKlT6Wd0wUVkLd1TJXFcSfFh51u4HqxpJXX8vDYSi4iMG0p
	 51u1+Rmklmn5bmc+Bs0iUCNxuep/76do3YgKRtNN5TxKUeiN6TtoIlcLugpgeyqikC
	 n7tIOhF6ih3t/LIg41E0roMmJrYhfOyIoVp5gOFCYUBPpanlOgXa6jTthm/XH1LgVy
	 991Poyw3riKJA==
Date: Fri, 29 Sep 2023 09:52:19 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Sven Auhagen <sven.auhagen@voleatech.de>
Cc: netdev@vger.kernel.org, thomas.petazzoni@bootlin.com, brouer@redhat.com,
	Paulo.DaSilva@kyberna.com
Subject: Re: [PATCH] net: mvneta: fix calls to page_pool_get_stats
Message-ID: <ZRaCMwdFfC2ZOgAW@lore-desk>
References: <lagygwdvtqwndmqzx6bccs5wixyl2dvt4cdnkzbh7o5idt3lks@2ytjspavah6n>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NCHMeLSjShNTGjnQ"
Content-Disposition: inline
In-Reply-To: <lagygwdvtqwndmqzx6bccs5wixyl2dvt4cdnkzbh7o5idt3lks@2ytjspavah6n>


--NCHMeLSjShNTGjnQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
> This commit adds the proper checks before calling page_pool_get_stats.
>=20
> Fixes: b3fc792 ("net: mvneta: add support for page_pool_get_stats")
> Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
> Reported-by: Paulo Da Silva <paulo.dasilva@kyberna.com>

Hi Sven,

thx for fixing this issue, just a minor comment inline.

Regards,
Lorenzo

>=20
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet=
/marvell/mvneta.c
> index d50ac1fc288a..6331f284dc97 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -4734,13 +4734,16 @@ static void mvneta_ethtool_get_strings(struct net=
_device *netdev, u32 sset,
>  {
>  	if (sset =3D=3D ETH_SS_STATS) {
>  		int i;
> +		struct mvneta_port *pp =3D netdev_priv(netdev);
> =20
>  		for (i =3D 0; i < ARRAY_SIZE(mvneta_statistics); i++)
>  			memcpy(data + i * ETH_GSTRING_LEN,
>  			       mvneta_statistics[i].name, ETH_GSTRING_LEN);
> =20
> -		data +=3D ETH_GSTRING_LEN * ARRAY_SIZE(mvneta_statistics);
> -		page_pool_ethtool_stats_get_strings(data);
> +		if (!pp->bm_priv) {
> +			data +=3D ETH_GSTRING_LEN * ARRAY_SIZE(mvneta_statistics);
> +			page_pool_ethtool_stats_get_strings(data);
> +		}
>  	}
>  }
> =20
> @@ -4858,8 +4861,10 @@ static void mvneta_ethtool_pp_stats(struct mvneta_=
port *pp, u64 *data)
>  	struct page_pool_stats stats =3D {};
>  	int i;
> =20
> -	for (i =3D 0; i < rxq_number; i++)
> -		page_pool_get_stats(pp->rxqs[i].page_pool, &stats);
> +	for (i =3D 0; i < rxq_number; i++) {
> +		if (pp->rxqs[i].page_pool)
> +			page_pool_get_stats(pp->rxqs[i].page_pool, &stats);

We could move this check inside page_pool_get_stats(), what do you think? I
guess it would be beneficial even for other consumers.

> +	}
> =20
>  	page_pool_ethtool_stats_get(data, &stats);
>  }
> @@ -4875,14 +4880,21 @@ static void mvneta_ethtool_get_stats(struct net_d=
evice *dev,
>  	for (i =3D 0; i < ARRAY_SIZE(mvneta_statistics); i++)
>  		*data++ =3D pp->ethtool_stats[i];
> =20
> -	mvneta_ethtool_pp_stats(pp, data);
> +	if (!pp->bm_priv && !pp->is_stopped)
> +		mvneta_ethtool_pp_stats(pp, data);
>  }
> =20
>  static int mvneta_ethtool_get_sset_count(struct net_device *dev, int sse=
t)
>  {
> -	if (sset =3D=3D ETH_SS_STATS)
> -		return ARRAY_SIZE(mvneta_statistics) +
> -		       page_pool_ethtool_stats_get_count();
> +	if (sset =3D=3D ETH_SS_STATS) {
> +		int count =3D ARRAY_SIZE(mvneta_statistics);
> +		struct mvneta_port *pp =3D netdev_priv(dev);
> +
> +		if (!pp->bm_priv)
> +			count +=3D page_pool_ethtool_stats_get_count();
> +
> +		return count;
> +	}
> =20
>  	return -EOPNOTSUPP;
>  }
> --=20
> 2.33.1
>=20

--NCHMeLSjShNTGjnQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZRaCMwAKCRA6cBh0uS2t
rI1pAPoD1x9nlTzgIYR1jf0sgEOVNvbYJCJYImoG6GSu2BKw/AD+KoLnhe8LDN0X
6d4kEqIpJ4xAFquIYSZRHyWEB1m6ggA=
=JZPn
-----END PGP SIGNATURE-----

--NCHMeLSjShNTGjnQ--

