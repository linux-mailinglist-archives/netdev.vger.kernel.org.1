Return-Path: <netdev+bounces-136428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B179A1B4C
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96FC42897C8
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 07:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A621C1AD3;
	Thu, 17 Oct 2024 07:05:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A48818E04E
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 07:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148727; cv=none; b=H4Yby5kUM81CN4OE7ilWYFzA+auKSZIbyTG9dPbIlhDDnxg+NeRCdSh3iFthqKKP7FVK30hjDT7kqmGlHzT0PZ3EnupSS606o1cJqRi/wZuGWgojenmxptuUy3NIXa9jPIV+ToXwUO3hBP/oYhMow5KKBDpXRXgAfOJd1dnhcVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148727; c=relaxed/simple;
	bh=srzgsYItB+wxMxe4fLU+TcTNwJAD8jOiQRconeCJ/LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0uYX8AGCTxxXsaWuLx6zfCH5f4qAJR45t9Ojs828tJM0fCdFsq0uksaOAzXLZSVpjAi4rjxhNfYbaWRUs+mRstYBb0dEiqEsMLstm65X856muSeh8DSXsacEbRjFhOpu0KssWOb8aITAD2vgWzakBYtq79gXaTVdJCq8RTBRjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1KZJ-00015W-Lz; Thu, 17 Oct 2024 09:05:09 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1KZJ-002UFq-11; Thu, 17 Oct 2024 09:05:09 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B5125354DA8;
	Thu, 17 Oct 2024 07:05:08 +0000 (UTC)
Date: Thu, 17 Oct 2024 09:05:07 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Frank Li <Frank.li@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, imx@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net-next 12/13] net: fec: fec_enet_rx_queue(): move_call
 to _vlan_hwaccel_put_tag()
Message-ID: <20241017-modest-warping-potoo-c938d0-mkl@pengutronix.de>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-12-de783bd15e6a@pengutronix.de>
 <ZxB+91w802LBgp9Q@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lssj4dnji5xxkvei"
Content-Disposition: inline
In-Reply-To: <ZxB+91w802LBgp9Q@lizhi-Precision-Tower-5810>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--lssj4dnji5xxkvei
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.10.2024 23:05:27, Frank Li wrote:
> On Wed, Oct 16, 2024 at 11:52:00PM +0200, Marc Kleine-Budde wrote:
> > To clean up the VLAN handling, move the call to
> > __vlan_hwaccel_put_tag() into the body of the if statement, which
> > checks for VLAN handling in the first place.
> >
> > This allows to remove vlan_packet_rcvd and reduce the scope of
> > vlan_tag.
>=20
> Move __vlan_hwaccel_put_tag() into the if statement that sets
> vlan_packet_rcvd=3Dtrue. This change eliminates the unnecessary
> vlan_packet_rcvd variable, simplifying the code and improving clarity.

Fixed,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--lssj4dnji5xxkvei
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcQtyEACgkQKDiiPnot
vG981ggAlQ5XD7xT0TPvBQ5PIq5Kcb2dMk/cWp1ipxcpAtppP2AY2na4dPkE68s5
jBRPFMWt/j+IeCEzG41O2CpC9A3eTjrk8nZuIUBPoaVYjlyDnMtimrOi4FuP7BMM
Txu7MW3emMyr8mLn57iWkMr9NIJJJXsE/vCk/MCWY+Y+Dh/gL6sISehLR5vP+VUT
Xb3hiYai+rdk5yNzIDz85k/WQPfddlyTveT8IjYG/ZxxJnMZ0mPSt5w2LBkxpRap
MOBeTIvpju6uisWm3NMT8ZqumGDCDxLtYzqVEoQbhZhgL2yQWccyz97y9UjhdRhz
dyg1mobeRmyJBW+eW0m47fnzDNmIiA==
=zQs+
-----END PGP SIGNATURE-----

--lssj4dnji5xxkvei--

