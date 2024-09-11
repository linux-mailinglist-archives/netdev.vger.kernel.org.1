Return-Path: <netdev+bounces-127259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 412C5974C6D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 10:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1A68B259DD
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 08:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C901714B9;
	Wed, 11 Sep 2024 08:18:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E19313BC26
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 08:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726042709; cv=none; b=dPCXruJUkBHvW/0aqvtSRDjFEF51SdO19dc1muS3EExyKh18vokx97QG9mGHhWAtfAF7YLlBR+OhY2M8/X6E12FHDCuOesxID/tdbXk16v7zI6uRG6Q4eYBD2LQa6AvcSs+qjiM+NucAwdmqx4lqd6+z4UtlLIYM1B2aicpD53Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726042709; c=relaxed/simple;
	bh=S3pm95ToL3JHQkbqiOGpkw8FdP37yZ6JFOgmrb7/W8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSj7xIY248wXF0Tm3/JsBV61CcQXG7ix1ZDh/kuC5kfMbDpq8jiwGljYpcGhFmwIwKDYIGvOMly3+P7AgQ+rAIxthC/0USuqaXSg/efF7I96xSlUqo6Jq14Ty4t8IvjQM4GBaqaFNpmT3Gxjuho73nRMQ6TH/N9nPUhgdJvpNOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1soIYB-0006va-8T; Wed, 11 Sep 2024 10:18:07 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1soIY9-0075kf-Kg; Wed, 11 Sep 2024 10:18:05 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 49B393380B1;
	Wed, 11 Sep 2024 08:18:05 +0000 (UTC)
Date: Wed, 11 Sep 2024 10:18:04 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Simon Horman <horms@kernel.org>, kernel@pengutronix.de, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Heiko Stuebner <heiko@sntech.de>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH] can: rockchip_canfd: fix return type of
 rkcanfd_start_xmit()
Message-ID: <20240911-quirky-wandering-mastodon-fea5b3-mkl@pengutronix.de>
References: <20240906-rockchip-canfd-wifpts-v1-1-b1398da865b7@kernel.org>
 <20240909084448.GU2097826@kernel.org>
 <20240909-arcane-practical-petrel-015d24-mkl@pengutronix.de>
 <20240909143546.GX2097826@kernel.org>
 <20240910-utopian-meticulous-dodo-4ec230-mkl@pengutronix.de>
 <20240910190525.GA1169362@thelio-3990X>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rzg4bxks4bvdsike"
Content-Disposition: inline
In-Reply-To: <20240910190525.GA1169362@thelio-3990X>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--rzg4bxks4bvdsike
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10.09.2024 12:05:25, Nathan Chancellor wrote:
> > I was a bit hasty yesterday, clang-20 and W=3D1 produces these errors:
> >=20
> > | include/linux/vmstat.h:517:36: error: arithmetic between different en=
umeration types ('enum node_stat_item' and 'enum lru_list') [-Werror,-Wenum=
-enum-conversion]
> > |   517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip=
 "nr_"
> > |       |                               ~~~~~~~~~~~ ^ ~~~
> > | 1 error generated.
>=20
> Unfortunately, this is a completely tangential issue. You can see some
> backstory behind it in commit 75b5ab134bb5 ("kbuild: Move
> -Wenum-{compare-conditional,enum-conversion} into W=3D1"). To be honest, I
> should consider moving that to W=3D2...

Thanks for the background info. I wanted to point out that at least
clang-20 with W=3D1 finds _something_, though not that what I wanted to
reproduce :)

> > However I fail to reproduce the ndo_start_xmit problem. Even with 18.1.8
> > from kernel.org.
> >=20
> >=20
> > The following command (ARCH is unset, compiling x86 -> x86) produces the
> > above shown "vmstat.h" problems....
> >=20
> > | $ make LLVM=3D1 LLVM_IAS=3D1 LLVM_SUFFIX=3D-20 drivers/net/can/rockch=
ip/  W=3D1 CONFIG_WERROR=3D0
>=20
> FYI, you could shorten this to just:
>=20
>   $ make LLVM=3D-20 drivers/net/can/rockchip/ W=3D1 CONFIG_WERROR=3D0
>=20
> As LLVM_SUFFIX will be set through LLVM and LLVM_IAS has defaulted to 1
> since 5.15.

Thanks, scripts updated :)

> Does CONFIG_WERROR=3D0 work? It seems like it is still present above.

Yes, it works.

> > ... but not the ndo_start_xmit problem.
> >=20
> > Am I missing a vital .config option?
>=20
> No, I might not have made it clear in this commit message but this
> warning is not on by default. I am looking to turn it on at some point
> so I keep up with the warnings that it produces but there is one
> subsystem that has several instances and I am unsure of how to solve
> them to the maintainer's satisfaction. You can test it by adding
>=20
>   KCFLAGS=3D-Wincompatible-function-pointer-types-strict
>=20
> to your make command above and it should reproduce.

That was the missing link. Can reproduce now, thanks!

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--rzg4bxks4bvdsike
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbhUjkACgkQKDiiPnot
vG/tHQf+NTtvl9Ppp0bGbHnkqrViW25ecpIjPSkKou/0aP23Rr+N4EsbvqwAoDOK
QTzEW6pIIPog26QQx66TpvOVFKnqECRugjegrzVlaozWMJn0RT9RO2jw8ezmi1qJ
A+hF6ivY4IgKdIM21ojVnM0tgLQWC2YILXtmibZEgUcU6tCCSt0W1XiVLWn7tA8Z
vJkNKxWoVnHMAn9a1N9A+miYLHrFGLKb5Wy0oxWUokGQ0eXWhhWWet1DmudjEgQz
8rShcLAf7Ew0uB+ziNkrdJhcNviEU/PeFx54/Q28Rnp3fH+ZxReqke9nLH363wLA
TVpVWiK1iygrjmRr+gWrZdlarnd2mQ==
=O5L3
-----END PGP SIGNATURE-----

--rzg4bxks4bvdsike--

