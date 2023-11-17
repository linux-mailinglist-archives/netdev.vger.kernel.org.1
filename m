Return-Path: <netdev+bounces-48643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356DF7EF0D6
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 11:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667EE1C2039F
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8810014F7A;
	Fri, 17 Nov 2023 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F73E11D
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 02:43:29 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1r3wJm-00006V-T0; Fri, 17 Nov 2023 11:43:22 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1r3wJm-009eoe-DI; Fri, 17 Nov 2023 11:43:22 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 11DEE24E74F;
	Fri, 17 Nov 2023 10:43:22 +0000 (UTC)
Date: Fri, 17 Nov 2023 11:43:21 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sascha Hauer <s.hauer@pengutronix.de>, Jens Axboe <axboe@kernel.dk>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, kernel@pengutronix.de
Subject: Re: [PATCH] net: Do not break out of sk_stream_wait_memory() with
 TIF_NOTIFY_SIGNAL
Message-ID: <20231117-starter-unvisited-d10f0314ae76-mkl@pengutronix.de>
References: <20231023121346.4098160-1-s.hauer@pengutronix.de>
 <addf492843338e853f7fda683ce35050f26c9da0.camel@redhat.com>
 <20231026070310.GY3359458@pengutronix.de>
 <8404022493c5ceda74807a3407e5a087425678e2.camel@redhat.com>
 <20231027120432.GB3359458@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="myrtppjg3pcf7ghi"
Content-Disposition: inline
In-Reply-To: <20231027120432.GB3359458@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--myrtppjg3pcf7ghi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 27.10.2023 14:04:32, Sascha Hauer wrote:
> On Thu, Oct 26, 2023 at 10:49:18AM +0200, Paolo Abeni wrote:
> > On Thu, 2023-10-26 at 09:03 +0200, Sascha Hauer wrote:
> > > On Tue, Oct 24, 2023 at 03:56:17PM +0200, Paolo Abeni wrote:
> > > > On Mon, 2023-10-23 at 14:13 +0200, Sascha Hauer wrote:
> > > > > It can happen that a socket sends the remaining data at close() t=
ime.
> > > > > With io_uring and KTLS it can happen that sk_stream_wait_memory()=
 bails
> > > > > out with -512 (-ERESTARTSYS) because TIF_NOTIFY_SIGNAL is set for=
 the
> > > > > current task. This flag has been set in io_req_normal_work_add() =
by
> > > > > calling task_work_add().
> > > > >=20
> > > > > It seems signal_pending() is too broad, so this patch replaces it=
 with
> > > > > task_sigpending(), thus ignoring the TIF_NOTIFY_SIGNAL flag.
> > > >=20
> > > > This looks dangerous, at best. Other possible legit users setting
> > > > TIF_NOTIFY_SIGNAL will be broken.
> > > >=20
> > > > Can't you instead clear TIF_NOTIFY_SIGNAL in io_run_task_work() ?
> > >=20
> > > I don't have an idea how io_run_task_work() comes into play here, but=
 it
> > > seems it already clears TIF_NOTIFY_SIGNAL:
> > >=20
> > > static inline int io_run_task_work(void)
> > > {
> > >         /*
> > >          * Always check-and-clear the task_work notification signal. =
With how
> > >          * signaling works for task_work, we can find it set with not=
hing to
> > >          * run. We need to clear it for that case, like get_signal() =
does.
> > >          */
> > >         if (test_thread_flag(TIF_NOTIFY_SIGNAL))
> > >                 clear_notify_signal();
> > > 	...
> > > }
> >=20
> > I see, io_run_task_work() is too late, sk_stream_wait_memory() is
> > already woken up.
> >=20
> > I still think this patch is unsafe. What about explicitly handling the
> > restart in tls_sw_release_resources_tx() ? The main point is that such
> > function is called by inet_release() and the latter can't be re-
> > started.
>=20
> I don't think there's anything I can do in tls_sw_release_resources_tx().
> When entering this function TIF_NOTIFY_SIGNAL is not (yet) set. It gets
> set at some point while tls_sw_release_resources_tx() is running. I find
> it set when tls_tx_records() returns with -ERESTARTSYS. I tried clearing
> TIF_NOTIFY_SIGNAL then and called tls_tx_records() again, but that doesn't
> work.

Seems the discussion got stuck, what are the blocking points?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--myrtppjg3pcf7ghi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmVXQ8YACgkQvlAcSiqK
BOjTBAf/bx31f+dylh6QTDp4+y9R5QW/hooHn72DH7PdipTn0Sn/N85TT/6dwm2m
d6zrmYaYoORvTMvxkDNuvlPI3Ye8x1s03XmRdUzZz42lktKlwL7vx+WNPofcsuYv
OSZBM7DnLPZzd04gCfME5+Z0F8ja7qFW/TeFLMNaTdA15hNmrtql/dNnxQ8rOcFi
QGSYH0Hukk9WCBVsJfWh1TUD7ofi+W4kEXVoJudKhMacz6U1m2hqwzsCHZl4MfBw
Hy15O4ShNqgYhGonRLk6GKvZp0UcrP9vupIgFuAz2tQIss7IlukeYEj/K+1yERXC
oENATOsMpTHZwnHiYEqD59Iwj2jCSA==
=4VsN
-----END PGP SIGNATURE-----

--myrtppjg3pcf7ghi--

