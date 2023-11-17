Return-Path: <netdev+bounces-48639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A7A7EF0B6
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 11:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C220F2811BD
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E5D179BE;
	Fri, 17 Nov 2023 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F681127
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 02:39:53 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3wGN-0007uA-Gt; Fri, 17 Nov 2023 11:39:51 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3wGM-009ent-CJ; Fri, 17 Nov 2023 11:39:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3wGM-0030fh-2g; Fri, 17 Nov 2023 11:39:50 +0100
Date: Fri, 17 Nov 2023 11:39:49 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Roger Quadros <rogerq@kernel.org>
Cc: netdev@vger.kernel.org, Siddharth Vadapalli <s-vadapalli@ti.com>,
	kernel@pengutronix.de, Dan Carpenter <dan.carpenter@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 1/7] net: ethernet: ti: am65-cpsw: Don't error out in
 .remove()
Message-ID: <20231117103949.akpvqfeslyefuzdc@pengutronix.de>
References: <20231117091655.872426-1-u.kleine-koenig@pengutronix.de>
 <20231117091655.872426-2-u.kleine-koenig@pengutronix.de>
 <e8cf4f85-b05a-4a7a-ae13-406792be1bbe@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="stmzdwzai4xdvhro"
Content-Disposition: inline
In-Reply-To: <e8cf4f85-b05a-4a7a-ae13-406792be1bbe@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--stmzdwzai4xdvhro
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Nov 17, 2023 at 11:51:56AM +0200, Roger Quadros wrote:
> On 17/11/2023 11:16, Uwe Kleine-K=F6nig wrote:
> > Returning early from .remove() with an error code still results in the
> > driver unbinding the device. So the driver core ignores the returned er=
ror
> > code and the resources that were not freed are never catched up. In
> > combination with devm this also often results in use-after-free bugs.
> >=20
> > In case of the am65-cpsw-nuss driver there is an error path, but it's n=
ever
> > taken because am65_cpts_resume() never fails (which however might be
> > another problem). Still make this explicit and drop the early return in
> > exchange for an error message (that is more useful than the error the
> > driver core emits when .remove() returns non-zero).
> >=20
> > This prepares changing am65_cpsw_nuss_remove() to return void.
> >=20
> > Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit =
eth subsystem driver")
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/eth=
ernet/ti/am65-cpsw-nuss.c
> > index ece9f8df98ae..960cb3fa0754 100644
> > --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> > +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> > @@ -3007,9 +3007,12 @@ static int am65_cpsw_nuss_remove(struct platform=
_device *pdev)
> > =20
> >  	common =3D dev_get_drvdata(dev);
> > =20
> > -	ret =3D pm_runtime_resume_and_get(&pdev->dev);
> > +	ret =3D pm_runtime_get_sync(&pdev->dev);
>=20
> Unrelated to this patch but I see pm_runtime_resume_and_get()
> used at multiple places in this driver.
>=20
> Would it be wise to replace them all with pm_runtime_get_sync()?

No, in general pm_runtime_resume_and_get() is the variant that is easier
to use because it drops the usage count in the error path. Here however
the error isn't simply propagated and so pm_runtime_get_sync() is
better.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--stmzdwzai4xdvhro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVXQvUACgkQj4D7WH0S
/k5ESAf/flAabj0IKF6cRYfoJTg0LLoOL3s7vVZSBqLS5dGb19DWwMRYdCo2/JTS
sGMgAuVUl4ULsYOUy9czeVCG7yqR1dUcC1KeCr50fq39ImatXnBf22WgRRaHPvFn
Fn1fU11w5gctoJtWYdk35XtYxBC79gSpm/gLP+bz6AgzvmFGjf2051xZLp2uPJSX
9DkW27fOPFApk0m/RNK4ivJI2JV2nVkoebTTxpPOAqVsg84tBGu1MIskruFRu3/H
/99FFcmGZ/UGudBHtLgZpZYjjb9egjHWq84NLtnQMWIbws7pXFPC8J0rSvdG3o09
FAU+skJ/kGeAuNwK3Fenvd14vMa1NA==
=Bqin
-----END PGP SIGNATURE-----

--stmzdwzai4xdvhro--

