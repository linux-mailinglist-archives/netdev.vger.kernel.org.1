Return-Path: <netdev+bounces-46834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A817E69B0
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 12:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F77281028
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 11:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B7C19BB1;
	Thu,  9 Nov 2023 11:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUZ/rUdo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAA41CF93
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 11:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677F7C433C7;
	Thu,  9 Nov 2023 11:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699529508;
	bh=viR/y2fazue9JOkzDugrHK017rAatdnnGSMeOols6VA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pUZ/rUdoMrHbDD3xG1iJatG3Y8uXH+vqyoI/Se0iH7gFz/LBI4P0AzzsQLSIXJT/j
	 Oat3w+6wo0s9F9eoavX3qWbwu6ePsUTNRtehg9yoHXiYxOyZsdXldPVKRosfDyu21Y
	 H7JuvmPb1gSBGyCLP9+tS7HoizORo+FnBoM3mtaCGhO8za2PBWMkmLI4BjC84/vNmJ
	 UYBZrE74a6LFavYBLfwChIzYy6a1Bpq6Z70BDCiqC0HJf3lFbfmKPV0NHMM3OCWlHp
	 /jpV4Ti5oOjRAAYAxgms6YXFJzjdELiKEIZ++zVFzd8P+0T6QbW76VjGv90nw17oa8
	 z6IskhluYXa+Q==
Date: Thu, 9 Nov 2023 12:31:45 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Sven Auhagen <sven.auhagen@voleatech.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
	"brouer@redhat.com" <brouer@redhat.com>,
	"ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
	"mcroce@microsoft.com" <mcroce@microsoft.com>,
	"leon@kernel.org" <leon@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH v4] net: mvneta: fix calls to page_pool_get_stats
Message-ID: <ZUzDIV2SQ4U/rhzI@lore-desk>
References: <4wba22pa6sxknqfxve42xevswz4wfu637p5gyyeq546tmzudzu@4z3kphfrpm64>
 <ZUyOsB7p6j21e42c@lore-desk>
 <4fxnidhi7gfpzmeels363loksphtifgsan6w64n5y7dxzi7dyx@jwbe4gp37mwy>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M57S2kKDOWuCTbe7"
Content-Disposition: inline
In-Reply-To: <4fxnidhi7gfpzmeels363loksphtifgsan6w64n5y7dxzi7dyx@jwbe4gp37mwy>


--M57S2kKDOWuCTbe7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
> >=20
> > do we need to check pp->is_stopped here? (we already check if page_pool
> > pointer is NULL in mvneta_ethtool_pp_stats).
> > Moreover in mvneta_ethtool_get_sset_count() and in mvneta_ethtool_get_s=
trings()
> > we just check pp->bm_priv pointer. Are the stats disaligned in this cas=
e?
>=20
> Hi Lorenzo,
>=20
> so the buffer manager (bm) does not support the page pool.
> If this mode is used we can skip any page pool references.
>=20
> The question is do we end up with a race condition when we skip the is_st=
opped check
> as the variable is set to true just before the page pools are
> deallocated on suspend or interface stop calls.

Do we really have a race here? e.g. both ndo_stop and ethtool_get_stats() r=
un under rtnl.
Moreover it seems is_stopped is not set for armada-3700 devices (e.g. my
espressobin). Do we have the issue for this kind of devices?

Regards,
Lorenzo

>=20
> Best
> Sven
>=20
> >=20
> > > +		mvneta_ethtool_pp_stats(pp, data);
> > >  }
> > > =20
> > >  static int mvneta_ethtool_get_sset_count(struct net_device *dev, int=
 sset)
> > >  {
> > > -	if (sset =3D=3D ETH_SS_STATS)
> > > -		return ARRAY_SIZE(mvneta_statistics) +
> > > -		       page_pool_ethtool_stats_get_count();
> > > +	if (sset =3D=3D ETH_SS_STATS) {
> > > +		int count =3D ARRAY_SIZE(mvneta_statistics);
> > > +		struct mvneta_port *pp =3D netdev_priv(dev);
> > > +
> > > +		if (!pp->bm_priv)
> > > +			count +=3D page_pool_ethtool_stats_get_count();
> > > +
> > > +		return count;
> > > +	}
> > > =20
> > >  	return -EOPNOTSUPP;
> > >  }
> > > --=20
> > > 2.42.0
> > >=20
>=20
>=20

--M57S2kKDOWuCTbe7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZUzDIQAKCRA6cBh0uS2t
rBGQAQD7M6pLFEeOmFCkiqhM77omhA3lvjc0h0wlIlgFXUpCuQD+P5fOcT3PpPzK
R+1U5AW9fuPCZ4G3BuATvVdLY9XoKAM=
=TUIT
-----END PGP SIGNATURE-----

--M57S2kKDOWuCTbe7--

