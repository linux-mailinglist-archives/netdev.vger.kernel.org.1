Return-Path: <netdev+bounces-136416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7796E9A1B21
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 08:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0151C21F46
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 06:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CA81B0F3D;
	Thu, 17 Oct 2024 06:57:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EF5199954
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 06:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148222; cv=none; b=F+XpBzS/NAHf+voatlqOTSRaq48A/Pk/S/7hcsA58Egm/yJUugcBXuCj4yWcjoCUcSmw+R9aO6BjkzYFVj1tObNbxTaDk7FsvMT2i5QGFc6j7ydNk19dh92MERTrNjXNzfLupU6EbxC+FZhsZgDdSv4QYrI/R/mo3+TXAtBuDac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148222; c=relaxed/simple;
	bh=onTEonaeYEpZro6UsJq7dadqTmNvlqp2QMesb4huUro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTG8dwvdiFN4W9HLtKLhjl03ANqAKTKMprz+f4jyZMrqluviiEMJYD1ztYueI0l+TI7ny//PEnn1+ktvRiItRGwqfTZTvhN4NlPkeKCuBhdJU6Z3noAqTX6OkZpufRe2IB19/h2e+N/d2uOUPtV0RK3zXt41RFMux+QKCcrIKk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1KRD-0008WM-25; Thu, 17 Oct 2024 08:56:47 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1KRC-002U8F-HB; Thu, 17 Oct 2024 08:56:46 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 35C1B354D7E;
	Thu, 17 Oct 2024 06:56:46 +0000 (UTC)
Date: Thu, 17 Oct 2024 08:56:46 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Frank Li <Frank.li@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, imx@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net-next 06/13] net: fec: fec_restart(): make use of
 FEC_ECR_RESET
Message-ID: <20241017-adept-coot-of-recreation-96c1d9-mkl@pengutronix.de>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-6-de783bd15e6a@pengutronix.de>
 <ZxBxSNZk2Ls7p4wL@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wq3uuabso3end65v"
Content-Disposition: inline
In-Reply-To: <ZxBxSNZk2Ls7p4wL@lizhi-Precision-Tower-5810>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--wq3uuabso3end65v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.10.2024 22:07:04, Frank Li wrote:
> On Wed, Oct 16, 2024 at 11:51:54PM +0200, Marc Kleine-Budde wrote:
> > Replace the magic number "1" by the already existing define
> > FEC_ECR_RESET.
>=20
> nit: wrap at 75 char.
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Fixed,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--wq3uuabso3end65v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcQtSsACgkQKDiiPnot
vG/X9Qf/eF0MZQ1xxfJN4bAn30ffkPyXD0UHPaO8y8+E2eobhhXOcfbfkZ+y5Vl0
WO1spc6SYzpn/BB//bSIzA+SWbn2vVycZdOwSBaec+2nfwqCiTUj3HHyNgL8JHnx
rPjo/xRih/aIn/b2WUKpnLU0YJzL2v3KtmLGuW1KnNWcZA3wu+CEJ9Dkdv8dp56Z
4r094oglTVbMl9K5MEjpox7+s1qcqWEBeX7VcD9DJo2Drlx9gywqGgEVD48uS5In
TatA9clcrjhRd5VVqbmaPzHQtaq/m0sXIZt0iNjGnT3/Re5s9GutJWFxYCVqJ+PR
9deFXbMFJ6fk34KomV5q/AAPPvd1oQ==
=edBP
-----END PGP SIGNATURE-----

--wq3uuabso3end65v--

