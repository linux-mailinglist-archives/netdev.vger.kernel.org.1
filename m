Return-Path: <netdev+bounces-116818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3F294BCB3
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236831F231BE
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B7818C90C;
	Thu,  8 Aug 2024 11:57:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB1018C344
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 11:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723118263; cv=none; b=bWT40XwwgwJnHe7ykdSFTH/7UzR10OsGW+oKyF6Csn4XNtSG4l94ArjDcdMl+OO44Aq7pvQTRnQt6j996TaxL9cs5khnTcC3AKE40Y0GMiKYjzeT/Ec/Vfac27njVqk9Ghe8w9MWgk7UXnHNPfTQJjiU/pXHXEb8t1HtzDBwP5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723118263; c=relaxed/simple;
	bh=qNMmsEQ2EZ4cxvh69JOIOtIXnSx28gl37GRrOb3EQwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/VS4McWA8eMfci5Mt9W0DnTKvBfcCw5LYJ/ZTScW30g8TJrLkZpR03mxCeHiWJvEGZu04Jxx8ccoMaRi2fmAfLvSjrscm5sEzPjlau1wwZ1dZ60BAYa83XLeriIfBPqCT7gqGkv29IPM+fR7Orn95TlMTpudt7MrWE2646igzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sc1lW-0002TZ-3n; Thu, 08 Aug 2024 13:57:10 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sc1lT-005PwN-8z; Thu, 08 Aug 2024 13:57:07 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DA2D53197FE;
	Thu, 08 Aug 2024 11:57:06 +0000 (UTC)
Date: Thu, 8 Aug 2024 13:57:06 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Edward Adam Davis <eadavis@qq.com>
Cc: o.rempel@pengutronix.de, davem@davemloft.net, edumazet@google.com, 
	kernel@pengutronix.de, kuba@kernel.org, leitao@debian.org, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, robin@protonic.nl, 
	socketcan@hartkopp.net, syzbot+ad601904231505ad6617@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net-next V2] can: j1939: fix uaf warning in
 j1939_session_destroy
Message-ID: <20240808-awesome-agama-of-cubism-b68cf0-mkl@pengutronix.de>
References: <ZrR4fsTgDud3Uyo0@pengutronix.de>
 <tencent_5B8967E03C7737A897DA36604A8A75DB7709@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="urdcdsf4vvoztryz"
Content-Disposition: inline
In-Reply-To: <tencent_5B8967E03C7737A897DA36604A8A75DB7709@qq.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--urdcdsf4vvoztryz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08.08.2024 19:07:55, Edward Adam Davis wrote:
> On Thu, 8 Aug 2024 09:49:18 +0200, Oleksij Rempel wrote:
> > > the skb to the queue and increase the skb reference count through it.
> > >=20
> > > Reported-and-tested-by: syzbot+ad601904231505ad6617@syzkaller.appspot=
mail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=3Dad601904231505ad6617
> > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> >=20
> > This patch breaks j1939.
> > The issue can be reproduced by running following commands:
> I tried to reproduce the problem using the following command, but was=20
> unsuccessful. Prompt me to install j1939cat and j1939acd, and there are
> some other errors.

The j1939 commands are part of the can-utils package. On Debian
compatible systems it's "sudo apt install can-utils". Or you can build
them from source: https://github.com/linux-can/can-utils

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--urdcdsf4vvoztryz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAma0so8ACgkQKDiiPnot
vG97YAf/eKz8zsiBtjdl0rll7tKLB1PQOdPOHCssA3DTt3c2qYzJWEF/wEHAuvLI
oDb8FmhHQzxF4UOlkiKJwK2k7Ca5mfYl9RrAzasVCeaoOwT5XthO7SYfpNTM+1cg
jCKZ3X1fcbf9zL6PV7VkGrjEj0BQrbJgTI8V1+1tt6OXHs9s0gdnmnty7R4A+fIu
vz4wihs5Qcg9zN+vs+gHbbajKnvsBJY+rjxTcpsCaEWYSXp955QnSumWjpRgZ2I6
lzTPCfk9Wn2oIxA+DMLELpSNulza4FTsD0Zv3oYVyzkQRuPvfzspAam5zUw5JYGJ
85mWsdYGrvgwrtoRIBLicnvMywU7tg==
=i28/
-----END PGP SIGNATURE-----

--urdcdsf4vvoztryz--

