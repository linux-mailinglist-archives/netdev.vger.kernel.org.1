Return-Path: <netdev+bounces-72052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815288564FE
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 14:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C671C21513
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 13:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0A913342A;
	Thu, 15 Feb 2024 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdSmaDzS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE97C133428
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005110; cv=none; b=DZMVIrZN1nOAudFscv7d4GZJg3uJAM+p1T4u4bzGlg2sE7jEoHCGBZdLrJpVIQoL1Y1V6GScI+CejU9rQhAtjYkcwoVJZW3m7BS0yl0SSvPQWQ6P1a656LnKimd8kAoQyiLW9mvxSqu2pCI8AgXi9s3JprdsYBdS+HwR8rXQ950=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005110; c=relaxed/simple;
	bh=Pq9IyzJL21EtO/WAASx91SHxb5arvTq+9DoId3Ql3lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saCvaEJ2MihgAFWMr36cTyx/O5tp2orwtZXlNpHy909KMHHvpsXXyrRSOoE/Y/YjONAARX0tPgLHxYCYYCmDCahjb1/qp2mxqzVANO+h/uV70PPhE6WGzWR3BVpO8GO8hvsKI5Y7Z/FLfDESc7xAswugq/dT0gzBLLIdZtKPxdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdSmaDzS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBAAEC433C7;
	Thu, 15 Feb 2024 13:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708005110;
	bh=Pq9IyzJL21EtO/WAASx91SHxb5arvTq+9DoId3Ql3lE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RdSmaDzSmTHp1agzC1w7T8jrtHzcBmn6KZyPWSZ0JeGG0LbOvjLBitWzs8DWNyF37
	 T0R2drPzPgRl4fd/kSKKbs5ctbWR0ErlIPFl64rT90cuyxAI9y+61j8qh/UROzsHbo
	 k56JZ3/x5X0y8ptgTa9vhWCAGqd2cj5eQY2dQwkQ5MdKL05HlLnGZEKGCUKo0NkFYE
	 H+cLwVRPv2aI3lUm8vHQa88eBP4UmrDsf+1dQJ3Fp3UR11cpA0vyPCSAHoPKCb0VBb
	 FWeYKdeWaWhRU4afRhePE1ODerOvtJ/ksvJVKw003eprM6aeVYzKZ+XETT532LQUuA
	 hlb00nttpLUrQ==
Date: Thu, 15 Feb 2024 14:51:46 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	hawk@kernel.org, ilias.apalodimas@linaro.org,
	linyunsheng@huawei.com, toke@redhat.com
Subject: Re: [RFC net-next] net: page_pool: fix recycle stats for percpu
 page_pool allocator
Message-ID: <Zc4W8iNOgqI8xrCT@lore-desk>
References: <e56d630a7a6e8f738989745a2fa081225735a93c.1707933960.git.lorenzo@kernel.org>
 <bff45ab9-2818-4b37-837e-f18ffcab8f47@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eBnsIUTuy/xtlLTD"
Content-Disposition: inline
In-Reply-To: <bff45ab9-2818-4b37-837e-f18ffcab8f47@intel.com>


--eBnsIUTuy/xtlLTD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Lorenzo Bianconi <lorenzo@kernel.org>
> Date: Wed, 14 Feb 2024 19:08:40 +0100
>=20
> > Use global page_pool_recycle_stats percpu counter for percpu page_pool
> > allocator.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  net/core/page_pool.c | 18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > index 6e0753e6a95b..1bb83b6e7a61 100644
> > --- a/net/core/page_pool.c
> > +++ b/net/core/page_pool.c
> > @@ -31,6 +31,8 @@
> >  #define BIAS_MAX	(LONG_MAX >> 1)
> > =20
> >  #ifdef CONFIG_PAGE_POOL_STATS
> > +static DEFINE_PER_CPU(struct page_pool_recycle_stats, pp_recycle_stats=
);
> > +
> >  /* alloc_stat_inc is intended to be used in softirq context */
> >  #define alloc_stat_inc(pool, __stat)	(pool->alloc_stats.__stat++)
> >  /* recycle_stat_inc is safe to use when preemption is possible. */
> > @@ -220,14 +222,19 @@ static int page_pool_init(struct page_pool *pool,
> >  	pool->has_init_callback =3D !!pool->slow.init_callback;
> > =20
> >  #ifdef CONFIG_PAGE_POOL_STATS
> > -	pool->recycle_stats =3D alloc_percpu(struct page_pool_recycle_stats);
> > -	if (!pool->recycle_stats)
> > -		return -ENOMEM;
> > +	if (cpuid < 0) {
>=20
> TBH I don't like the idea of assuming that only system page_pools might
> be created with cpuid >=3D 0.
> For example, if I have an Rx queue always pinned to one CPU, I might
> want to create a PP for this queue with the cpuid set already to save
> some cycles when recycling. We might also reuse cpuid later for some
> more optimizations or features.
>=20
> Maybe add a new PP_FLAG indicating that system percpu PP stats should be
> used?

Ack, I like the idea. What about creating a flag to indicate this is a perc=
pu
page_pool instead of relying on cpuid value? Maybe it can be useful in the
future, what do you think?

Regards,
Lorenzo

>=20
> > +		pool->recycle_stats =3D alloc_percpu(struct page_pool_recycle_stats);
> > +		if (!pool->recycle_stats)
> > +			return -ENOMEM;
> > +	} else {
> > +		pool->recycle_stats =3D &pp_recycle_stats;
> > +	}
> >  #endif
> > =20
> >  	if (ptr_ring_init(&pool->ring, ring_qsize, GFP_KERNEL) < 0) {
> >  #ifdef CONFIG_PAGE_POOL_STATS
> > -		free_percpu(pool->recycle_stats);
> > +		if (cpuid < 0)
> > +			free_percpu(pool->recycle_stats);
> >  #endif
> >  		return -ENOMEM;
> >  	}
> > @@ -251,7 +258,8 @@ static void page_pool_uninit(struct page_pool *pool)
> >  		put_device(pool->p.dev);
> > =20
> >  #ifdef CONFIG_PAGE_POOL_STATS
> > -	free_percpu(pool->recycle_stats);
> > +	if (pool->cpuid < 0)
> > +		free_percpu(pool->recycle_stats);
> >  #endif
> >  }
> > =20
>=20
> Thanks,
> Olek

--eBnsIUTuy/xtlLTD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZc4W8gAKCRA6cBh0uS2t
rMLBAQC3aZY7zYvO2wETI88pJk9B0CX7rr1mFh5R0nmclrF02wEApThmPE5Let3N
/VwmVU6zudmn/jE3QHaAQ8uETGlWWQg=
=pzcI
-----END PGP SIGNATURE-----

--eBnsIUTuy/xtlLTD--

