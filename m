Return-Path: <netdev+bounces-71866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6BD85564D
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 23:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818AC1C21632
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 22:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB8027453;
	Wed, 14 Feb 2024 22:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcMgnpXB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60B124B33
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707950769; cv=none; b=YZGfuifejGQ0WphCq72zH9T9qgStCjb2qdonjq/IQzrN/bAr659XZ4AOLMhfwyOqFR+/TDSxjXxS0ZIdqR7nHu+x25PCTOGAckce4Sx3VTz/Oa7K2ca9G+yHa0FPTQy+t9Y6fCTkGymCEbbKfKaudWmji1w16SMmhPZLGrry3Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707950769; c=relaxed/simple;
	bh=J8kA3EKW+J0KVpprz+2CWZ+CCbORPhunwsXS259I/jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzYDyUrXtYraOAMj2sdRHxL+HFzZ6rtxB2KiOiVYAcgRJOFWDP+mKwopYYPAYeJ/358B95RC0fX5hVbSTT9oGjnvd1isfIcltpV5FocS6+v0z+HJRKEwy/ERlxtZeRW9cG93Eho8DGZ0R3+r7s62t7bhllqH5d7Fjp1z5Et6JbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcMgnpXB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F324DC433C7;
	Wed, 14 Feb 2024 22:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707950769;
	bh=J8kA3EKW+J0KVpprz+2CWZ+CCbORPhunwsXS259I/jA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YcMgnpXBzON3CZMSa0MwuxpUgHmZmaSqFXSx1kjFyQWMItYU1eLIKkwE0cB8n+RKW
	 ZSTv/MMhMbbURza69GZo026wgds16gw36XVsSlHK8qtg9A8t+Fpf16UleGhTLJpB0K
	 DLtAXeXK0Qc3Fhox6fSvg/lCkkpixbyoK9qRJAgfP/SP0h0po0eeYRzSqy1dlhQbEJ
	 ypehegI16oEIlDcfJi2BA9y758LqQFb4hH1B2gR7/ifeAnyZ6Qs7NkF1eyG1md20vU
	 ybQbGbDnoEy0HHZwMjJLmWGmTO+Z48zpf+w/B5Dw/Ji9Yy6AaDxTsTmugMayTgTIT8
	 1vD/OTTwhAPdw==
Date: Wed, 14 Feb 2024 23:46:05 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	hawk@kernel.org, ilias.apalodimas@linaro.org,
	linyunsheng@huawei.com
Subject: Re: [RFC net-next] net: page_pool: fix recycle stats for percpu
 page_pool allocator
Message-ID: <Zc1CrXyLYRR2w9RX@lore-desk>
References: <e56d630a7a6e8f738989745a2fa081225735a93c.1707933960.git.lorenzo@kernel.org>
 <871q9een8q.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l6gfZcr5ovPGmwjC"
Content-Disposition: inline
In-Reply-To: <871q9een8q.fsf@toke.dk>


--l6gfZcr5ovPGmwjC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> > Use global page_pool_recycle_stats percpu counter for percpu page_pool
> > allocator.
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> Neat trick with just referencing the pointer to the global object inside
> the page_pool. With just a few nits below:
>=20
> Reviewed-by: Toke H=F8iland-J=F8rgensen <toke@redhat.com>
>=20
> > ---
> >  net/core/page_pool.c | 18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> >
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
>=20
> Should we call this pp_system_recycle_stats to be consistent with the
> naming of the other global variable?

ack, I agree.

>=20
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
> > +		pool->recycle_stats =3D alloc_percpu(struct page_pool_recycle_stats);
> > +		if (!pool->recycle_stats)
> > +			return -ENOMEM;
> > +	} else {
>=20
> Maybe add a short comment here to explain what's going on? Something
> like:
>=20
> /* When a cpuid is supplied, we're initialising the percpu system page po=
ol
>  * instance, so use a singular stats object instead of allocating a
>  * separate percpu variable for each (also percpu) page pool instance.
>  */
>=20
> -Toke
>=20

sure, I will add it.

Regards,
Lorenzo

--l6gfZcr5ovPGmwjC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZc1CrQAKCRA6cBh0uS2t
rOuFAPjyO8iVz7iib5gTJWewjcMD9Q24iwzTRRw2OnGTDNSWAQDp1Cc+ieYqGHIB
2iSwon50TcAmgDYRDfQcC6CdmAnFDw==
=uz8B
-----END PGP SIGNATURE-----

--l6gfZcr5ovPGmwjC--

