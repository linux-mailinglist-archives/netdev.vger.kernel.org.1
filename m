Return-Path: <netdev+bounces-48698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B655C7EF4B3
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 15:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6EA11C20897
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 14:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F0D328D2;
	Fri, 17 Nov 2023 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51763A0
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 06:45:16 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r405i-0001Hu-Vc; Fri, 17 Nov 2023 15:45:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r405i-009hVT-49; Fri, 17 Nov 2023 15:45:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r405h-0037SZ-Qv; Fri, 17 Nov 2023 15:45:05 +0100
Date: Fri, 17 Nov 2023 15:45:05 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Alex Elder <elder@ieee.org>
Cc: Alex Elder <elder@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net-next 01/10] net: ipa: Don't error out in .remove()
Message-ID: <20231117144505.yfilrqpfbdhnhcds@pengutronix.de>
References: <20231117095922.876489-1-u.kleine-koenig@pengutronix.de>
 <20231117095922.876489-2-u.kleine-koenig@pengutronix.de>
 <79f4a1ff-c4af-45be-b15c-fa07bc67f449@ieee.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="saeud3ltthdfugfi"
Content-Disposition: inline
In-Reply-To: <79f4a1ff-c4af-45be-b15c-fa07bc67f449@ieee.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--saeud3ltthdfugfi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Alex,

On Fri, Nov 17, 2023 at 08:16:02AM -0600, Alex Elder wrote:
> On 11/17/23 3:59 AM, Uwe Kleine-K=F6nig wrote:
> > Returning early from .remove() with an error code still results in the
> > driver unbinding the device. So the driver core ignores the returned er=
ror
> > code and the resources that were not freed are never catched up. In
> > combination with devm this also often results in use-after-free bugs.
> >=20
> > Here even if the modem cannot be stopped, resources must be freed. So
> > replace the early error return by an error message an continue to clean=
 up.
> >=20
> > This prepares changing ipa_remove() to return void.
> >=20
> > Fixes: cdf2e9419dd9 ("soc: qcom: ipa: main code")
>=20
> Is this really a bug fix?  This code was doing the right
> thing even if the caller was not.

Yes, since cdf2e9419dd9 the driver is leaking resources if
ipa_modem_stop() fails. I call that a bug.

> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >   drivers/net/ipa/ipa_main.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
> > index da853353a5c7..60e4f590f5de 100644
> > --- a/drivers/net/ipa/ipa_main.c
> > +++ b/drivers/net/ipa/ipa_main.c
> > @@ -960,7 +960,8 @@ static int ipa_remove(struct platform_device *pdev)
> >   			ret =3D ipa_modem_stop(ipa);
> >   		}
> >   		if (ret)
> > -			return ret;
> > +			dev_err(dev, "Failed to stop modem (%pe)\n",
> > +				ERR_PTR(ret));
>=20
> I think this is not correct, or rather, I think it is less
> correct than returning early.
>=20
> What's happening here is we're trying to stop the modem.
> It is an external entity that might have some in-flight
> activity that could include "owning" some buffers provided
> by Linux, to be filled with received data.  There's a
> chance that cleaning up (with the call to ipa_teardown())
> can do the right thing, but I'm not going to sign off on
> this until I've looked at that in closer detail.
>=20
> This is something that *could* happen but is not *expected*
> to happen.  We expect stopping the modem to succeed so if
> it doesn't, something's wrong and it's not 100% clear how
> to properly handle it.

Returning early is wrong for sure. You skip for example the free_irq
step, so the irq stays active, it might trigger and use the unbound
device. And as the device is unbound, .remove() is never retried and the
irq (and all the other resources) are never freed.

Take the time you need to review the changes. If you don't want to
accept the change now, I'd like to apply the following change:

diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index da853353a5c7..f77decf0b1e4 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -959,8 +959,11 @@ static int ipa_remove(struct platform_device *pdev)
 			usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC);
 			ret =3D ipa_modem_stop(ipa);
 		}
-		if (ret)
-			return ret;
+		if (ret) {
+			dev_err(dev, "Failed to stop modem (%pe)\n",
+				ERR_PTR(ret));
+			return 0;
+		}
=20
 		ipa_teardown(ipa);
 	}

instead. This introduces no change in behaviour apart from improving the
error message and allows me to continue with my quest to make .remove
return void.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--saeud3ltthdfugfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVXfHAACgkQj4D7WH0S
/k7i3AgAmOGLjXAAOT11XfuYtRPd+oIEbnmLnDQIXZ0sDg4GVDEsXZY8b70VlP2j
JlVgH/x71zyXTjYKynFM0E8StNiHVkkEozKhwGw8gWikff60SZvT000FiGH6CGzf
PDCmzO9hXxaDaP8o1SQCx/nnhIIo/FktXQSJyzETKD1Dh9qa87AjIo/BMD0qOY0f
ACUQ7S4VjEQEglKX0UEKwdZXvSri8gLv99ZbfZZaFzPlqVApRI+QsyZEGPVnZ68E
wzc00sfMiYtrR6CuCbwuAfHOyI3ufguImtBXRjEsYJ9747rq76MW7f8dJQs88h/4
EoSGAJlLwCNXC0nD1j+hqkZYT+Cdtw==
=hvU7
-----END PGP SIGNATURE-----

--saeud3ltthdfugfi--

