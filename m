Return-Path: <netdev+bounces-136420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B95769A1B42
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F14F1F28BCB
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 07:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E631C1AAC;
	Thu, 17 Oct 2024 07:04:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEB818E04E
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 07:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148662; cv=none; b=LmFMbg0a9dD4cUJG+RIqOA+GADWUi8WVFfiVz4M+Z4g+Kbbf4jF1A3t53En68OUMPrJyfPEnY3/nPoCu62hXElZfwSou6mQQ7z1EfNOYtbvdPBifjsnqFivaZfctQV0onNKq9lyK6L+9D4NbAdxX9MDXt02Fn9hkvaAYkUwaemg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148662; c=relaxed/simple;
	bh=G5OPTcEC82Tosbes+9MlIjTJfQQKAPa9SGVIU4e7AuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wb3E8Jd6uxrHf3bZ92pNxAOitDAZrJY7RbXrHDvQ5bjErQ+8/oFjQ6lJO8mhk+fEoz4d85FGkfpAXrxufzGIlspyA5GnlRo5w/0d7qCQmV3QGy+M81xirttRZ6MBVp7Z6xQUh10wKeOONGZFgpMEO5D7ugjwWB4VHCaA5cfBKmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1KYG-0000k9-9p; Thu, 17 Oct 2024 09:04:04 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1KYF-002UDD-Pe; Thu, 17 Oct 2024 09:04:03 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 75FAD354D9A;
	Thu, 17 Oct 2024 07:04:03 +0000 (UTC)
Date: Thu, 17 Oct 2024 09:04:03 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Frank Li <Frank.li@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, imx@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net-next 10/13] net: fec: fec_enet_rx_queue(): replace
 open coded cast by skb_vlan_eth_hdr()
Message-ID: <20241017-tasteful-frog-of-persistence-ad1223-mkl@pengutronix.de>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-10-de783bd15e6a@pengutronix.de>
 <ZxB6AuGnoXekCEtp@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bbxuw7yumi54jgxm"
Content-Disposition: inline
In-Reply-To: <ZxB6AuGnoXekCEtp@lizhi-Precision-Tower-5810>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--bbxuw7yumi54jgxm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.10.2024 22:44:18, Frank Li wrote:
> On Wed, Oct 16, 2024 at 11:51:58PM +0200, Marc Kleine-Budde wrote:
> > In order to clean up the VLAN handling, replace an open coded cast
> > from skb->data to the vlan header with skb_vlan_eth_hdr().
>=20
> Replace manual VLAN header calculation with skb_vlan_eth_hdr()
>=20
> Use the provided helper function skb_vlan_eth_hdr() to replace manual VLAN
> header calculation for better readability and maintainability.

Fixed,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--bbxuw7yumi54jgxm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcQtuAACgkQKDiiPnot
vG/SSwf/RLC1G+yUlyNcaq0ekJTCbBgjaw+gpMeEaIwC3POspzUWlJ0PFEDUvWi2
NlDWzrkrSMWllWt96vin0rzmRhBSGmZTHiYtccXIyNRUTp56kfGIULu66LDbJJot
gjQ/mW3W5d0lI6MA7kZ0BHix+Ly6WuUKpUeJfveA4lkLTmSGvIVVocYbJ88G2nbe
JUPXU9K97TOzKx+7XITqXRN3Y7Ql1uKhJQ5QhrhvBjaf7nIRCZuy6NsTYxDssOPZ
b4bbpUTxPIIv+xuBGKfSdBM+sSx14hDPzaQ2Hm3RUnNpQsXGvlOEZJdngyJumqMo
PIrcq5O4veD8gzGxkIhcuKSTdQ8CzQ==
=tK4s
-----END PGP SIGNATURE-----

--bbxuw7yumi54jgxm--

