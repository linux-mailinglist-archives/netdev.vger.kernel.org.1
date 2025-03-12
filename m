Return-Path: <netdev+bounces-174164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1980A5DA97
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 11:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EDF3170B30
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 10:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD0423E35A;
	Wed, 12 Mar 2025 10:42:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860991DB124
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 10:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741776120; cv=none; b=s/o6Kl3ePLY8DQRYcsoYGJX9ME6bsZqoJadFsHAv5MkxbTCh9KLJZOpBU5yi/oRAKKmVK8BRxdGyg+0N4CYy6hMxGQFV2CGFCbXCyi46rmtWeYs8x46mL7O6dJGbGWWhNgEl6TToEWZqfINRGbgz6qetyvGe5OOg4tyWpNcYaPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741776120; c=relaxed/simple;
	bh=oP9DBHr7ZaAbB6keJAm59XCkp9krTFc8WFqNo8LwXrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxnvRVFbx6gWeSlOhig1B2DTsxcw5LjwhU4kZ+fgknA4ZVW++YtmzSOdpsIMhRH10Aevj+EC1fCqpqyZcs09fA/DIYcLDbyfi0eKYxKQMY05jejX/EQ0nsoxRCl45Z+Nb/sU8fFImxg5Xhr9nAdBAW3ATXgMWm2GaTf7GPTRhB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tsJWj-0001L5-Vr; Wed, 12 Mar 2025 11:41:30 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tsJWh-005LKd-0u;
	Wed, 12 Mar 2025 11:41:27 +0100
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CE4123D8C12;
	Wed, 12 Mar 2025 10:41:26 +0000 (UTC)
Date: Wed, 12 Mar 2025 11:41:26 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: Harald Mommer <harald.mommer@opensynergy.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>, Wolfgang Grandegger <wg@grandegger.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>, 
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
Message-ID: <20250312-conscious-sloppy-pegasus-b5099d-mkl@pengutronix.de>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <a366f529-c901-4cd1-a1a6-c3958562cace@wanadoo.fr>
 <0878aedf-35c2-4901-8662-2688574dd06f@opensynergy.com>
 <Z9FicA7bHAYZWJAb@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r2js27gw2phijjja"
Content-Disposition: inline
In-Reply-To: <Z9FicA7bHAYZWJAb@fedora>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--r2js27gw2phijjja
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
MIME-Version: 1.0

On 12.03.2025 11:31:12, Matias Ezequiel Vara Larsen wrote:
> On Thu, Feb 01, 2024 at 07:57:45PM +0100, Harald Mommer wrote:
> > Hello,
> >=20
> > I thought there would be some more comments coming and I could address
> > everything in one chunk. Not the case, besides your comments silence.
> >=20
> > On 08.01.24 20:34, Christophe JAILLET wrote:
> > >=20
> > > Hi,
> > > a few nits below, should there be a v6.
> > >=20
> >=20
> > I'm sure there will be but not so soon. Probably after acceptance of the
> > virtio CAN specification or after change requests to the specification =
are
> > received and the driver has to be adapted to an updated draft.
> >=20
> What is the status of this series?

There has been no movement from the Linux side. The patch series is
quite extensive. To get this mainline, we need not only a proper Linux
CAN driver, but also a proper VirtIO specification. This whole project
is too big for me to do it as a collaborative effort.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--r2js27gw2phijjja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmfRZNMACgkQDHRl3/mQ
kZxzCgf+Js8qoTJ0nTwATrNdTHqpf2wSPVGJQNeAsLPsRgZYNeOdPPAsNgrYtpfP
HxGRKv3QWJW3qLjtpzVTnb5AZBpDQhLRHaOrvkf5Mi1pwMQTLgQhGqQR1yXQVqp1
O+fYBVqFT0MDCvHuwyn3F/rKid1WmoV0EQiNXueiRGRpdA45XfoPUh66xETqpVVU
tuCGyW8lFOGV7mNsIrV8JfZVHSeGKx7Du17L6yUnmvqSnCFR2/5rsAd7oKNlr9pW
9A2rLf/XAU4nMfTEDnSiBPAmcJ7Y8e78vLNTapU+Ey2JLuADaYCJufE99u27sZDS
510o9vHMJusuQoeFxed0pQXFYFysrg==
=xIkD
-----END PGP SIGNATURE-----

--r2js27gw2phijjja--

