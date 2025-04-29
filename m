Return-Path: <netdev+bounces-186750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1325AAA0E9A
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 16:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450F9482E14
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 14:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3154F2D29DC;
	Tue, 29 Apr 2025 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poAzvqd9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D0E10942;
	Tue, 29 Apr 2025 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745936536; cv=none; b=pSPoak20WIbYQLSJ42mkLC5GUPfrJigl7KP+KIX+govOrG0uiHuU9i3E/mcoKsL1ocTvaoajuRxPWBGCNE05kOSWm/C5Ym92c5MdmnZ2PnL12rVrlvI+R/2VKIU4Xvw467WFlqUhjQSoiN9tM0wwRiiSCWZdWiVAjBQ5mZZDISc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745936536; c=relaxed/simple;
	bh=Hn26jb1aZXYejporzmo9DyB26YCJ0sQN1ZLh9FSFMwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e11xzp6JOz45eu2VhwixyI2im84q1JD67J2FUSoOW4UhJY0daTsGjO0W7xDFAoetrOG1N8s2fQZmsgUk+/nmcVNT1NyaLzTvK0rfJgn0Wrb0OtBIGMyDmckO5t4eEcIvTEQGpd799/FXYjRRG40mwzCNxHUjMU1zbPV2uO+2smM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poAzvqd9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B844C4CEE3;
	Tue, 29 Apr 2025 14:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745936535;
	bh=Hn26jb1aZXYejporzmo9DyB26YCJ0sQN1ZLh9FSFMwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=poAzvqd9eURiN3jHfL6W1FWeIh2XPHdSkTOF9+NePUCEE0nzrSuN1fjK3bW/7ZGwy
	 Ir9/VDJas1weKrZiNqb6UU/su4AjVwwtrL8sl48e55NyCHfHCF8wO38ljtClLcA5uI
	 EaLQwyZ2k88ED96kVWNRgqY0sZMPwnq6p/SHSYXo6AtoLiMOmcukV03EhbfElFnd9o
	 N/lFzou9P83ffhnPzX/isaPcgPwHRhnmzT9G/iq8P8BB4qDQS8K65z42MtijnppqFR
	 /FHkzILlOymDkVoEtFLSsK0XLe4KZ2EXAll0Y/ncxY1nSCK8vwxbpIEsUByFzG9lX3
	 3JE9LbbW+xNEQ==
Date: Tue, 29 Apr 2025 16:22:13 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net: airoha: Fix an error handling path in airoha_probe()
Message-ID: <aBDglZH4VaBlWU2a@lore-desk>
References: <f4a420f3a8b4a6fe72798f9774ec9aff2291522d.1744977434.git.christophe.jaillet@wanadoo.fr>
 <aAJFgqrOFL_xAqtW@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Cs66MFCPOyZ/spK5"
Content-Disposition: inline
In-Reply-To: <aAJFgqrOFL_xAqtW@lore-desk>


--Cs66MFCPOyZ/spK5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > If an error occurs after a successful airoha_hw_init() call,
> > airoha_ppe_deinit() needs to be called as already done in the remove
> > function.
> >=20
> > Fixes: 00a7678310fe ("net: airoha: Introduce flowtable offload support")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > Compile tested-only
> > ---
> >  drivers/net/ethernet/airoha/airoha_eth.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/eth=
ernet/airoha/airoha_eth.c
> > index 69e523dd4186..252b32ceb064 100644
> > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > @@ -2631,6 +2631,8 @@ static int airoha_probe(struct platform_device *p=
dev)
> >  		}
> >  	}
> >  	free_netdev(eth->napi_dev);
> > +
> > +	airoha_ppe_deinit(eth);
> >  	platform_set_drvdata(pdev, NULL);
> > =20
> >  	return err;
> > --=20
> > 2.49.0
> >=20
>=20
> Hi Christophe,
>=20
> I agree we are missing a airoha_ppe_deinit() call in the probe error path,
> but we should move it above after stopping the NAPI since if airoha_hw_in=
it()
> fails we will undo the work done by airoha_ppe_init(). Something like:
>=20
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ether=
net/airoha/airoha_eth.c
> index 16c7896f931f..37d9678798d1 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2959,6 +2959,7 @@ static int airoha_probe(struct platform_device *pde=
v)
>  error_napi_stop:
>  	for (i =3D 0; i < ARRAY_SIZE(eth->qdma); i++)
>  		airoha_qdma_stop_napi(&eth->qdma[i]);
> +	airoha_ppe_init(eth);
>  error_hw_cleanup:
>  	for (i =3D 0; i < ARRAY_SIZE(eth->qdma); i++)
>  		airoha_hw_cleanup(&eth->qdma[i]);
>=20

Hi Christophe,

any plan to repost this fix?

Regards,
Lorenzo

>=20
> Agree?
>=20
> Regards,
> Lorenzo



--Cs66MFCPOyZ/spK5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaBDglQAKCRA6cBh0uS2t
rHX6APwIvo/4Y3dZRr6TbMAZgufdsaVik6rZZyhOrTPpqe6ybwEAhi4Y5iLOE9C4
os6h8aHQ7FIIGzhvOp1QYkFsEvZ0TQI=
=ylrk
-----END PGP SIGNATURE-----

--Cs66MFCPOyZ/spK5--

