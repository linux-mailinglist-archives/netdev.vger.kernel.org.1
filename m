Return-Path: <netdev+bounces-125370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B82C996CF0E
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 08:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48FC0B21C04
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 06:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AA7189BAE;
	Thu,  5 Sep 2024 06:19:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF32A189503
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 06:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725517188; cv=none; b=TmonXTBJUTwBB2W9mRzQqmPleciu+e7brX+bgjryAcfmCRy0GUG/nWLMF7r0g70ESJrTM+9fCWSU1xUtIm/sB4qiHmNmGL0ftdpRQX3jRlkzQ7Qap9pVmHbc7Bzb04Hh6dcWXRPtsaVAH7LlYBVbIb/GB16yGmmRWwBteK/Z3iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725517188; c=relaxed/simple;
	bh=bRtFhROfyecNoXowVVEaoxV1CtMmwYGrUMt2lCkMoz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSLBuIGO/ROIzxT94oTmAfDpGfaKeuWf8dWu+RwAYTIUo1Vnpsov9YqMVZ9iWTmNdoufHST2YnIzgL7P+URYLL2ArBZoi2LHCeWd691WoUmo4OaZcfRAwU0e+y++kr/iWNlzBEFFsjdbFiVAhO66w8Fo0ezPSkLB6nJplUp1ZPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sm5pq-0007Na-VN; Thu, 05 Sep 2024 08:19:14 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sm5po-005dZX-2p; Thu, 05 Sep 2024 08:19:12 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AC96E33307A;
	Thu, 05 Sep 2024 06:19:11 +0000 (UTC)
Date: Thu, 5 Sep 2024 08:19:10 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc: kernel@pengutronix.de, Alibek Omarov <a1ba.omarov@gmail.com>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Elaine Zhang <zhangqing@rock-chips.com>, 
	David Jander <david.jander@protonic.nl>, Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, David Jander <david@protonic.nl>
Subject: Re: [PATCH can-next v5 00/20] can: rockchip_canfd: add support for
 CAN-FD IP core found on Rockchip RK3568
Message-ID: <20240905-galago-of-unmatched-development-cc97ac-mkl@pengutronix.de>
References: <20240904-rockchip-canfd-v5-0-8ae22bcb27cc@pengutronix.de>
 <86274585.BzKH3j3Lxt@diego>
 <20240904-imposing-determined-mayfly-ba6402-mkl@pengutronix.de>
 <4091366.iTQEcLzFEP@diego>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jb2uxtxhgm4xkjdb"
Content-Disposition: inline
In-Reply-To: <4091366.iTQEcLzFEP@diego>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--jb2uxtxhgm4xkjdb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04.09.2024 18:43:52, Heiko St=C3=BCbner wrote:
> Am Mittwoch, 4. September 2024, 17:10:08 CEST schrieb Marc Kleine-Budde:
> > On 04.09.2024 10:55:21, Heiko St=C3=BCbner wrote:
> > [...]
> > > How/when are you planning on applying stuff?
> > >=20
> > > I.e. if you're going to apply things still for 6.12, you could simply=
 take
> > > the whole series if the dts patches still apply to your tree ;-)
> >=20
> > The DTS changes should not go via any driver subsystem upstream, so
> > here's a dedicated PR:
> >=20
> > https://patch.msgid.link/20240904-rk3568-canfd-v1-0-73bda5fb4e03@pengut=
ronix.de
>=20
> I wasn't on Cc for the pull-request so I'll probably not get a notificati=
on
> when it gets merged?
>=20
> So if you see your PR with the binding and driver getting merged to
> next-next, can you provide a ping please?
  ^^^^^^^^^
  net-next?

Will do.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--jb2uxtxhgm4xkjdb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbZTVsACgkQKDiiPnot
vG96tQf/SxmDdp97bb66tXlUCf9x3X4Dory7Liw54EAzczBg1ycKNhJJojalvMoP
aDuJOZ2Zmh3ho31TiRZ2oYkEvW11tK8Ep5/EBNGP2vergWFxZLe0+h+NLN93CXxB
9gfLvz4AA0SwE+MdgPuK0TUwjDcl7tX0kRFzMWyuV+K9ARq9FRv7LzXZwaTEauYU
+Yx/jrkm2Z3RHGIr85yhS//6/KeS9G8Nzd9D3k9cBfZVMgRbWr2W8bR5ebNkB02w
U2HUuaOwbGIsQDTDoC+7m72hMOdkrdSneMDvI0Ww4PFeml+KmSNr9s3uc8J5uTWi
9liZ+iO4DMqQ80xIfnjQutSg8Ww33Q==
=y7mx
-----END PGP SIGNATURE-----

--jb2uxtxhgm4xkjdb--

