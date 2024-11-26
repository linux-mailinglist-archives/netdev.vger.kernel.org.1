Return-Path: <netdev+bounces-147496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B90969D9DFB
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 20:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D46B0B25806
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 19:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D021DE4E4;
	Tue, 26 Nov 2024 19:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="aRyJaV5j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yeJHCV7n"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB5D1DE4C0
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 19:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732648925; cv=none; b=MSc3QytI3D+Q03HYWZiTpW+7no1sltksoZgUObPQNA9MgnYUt1843CVnseTnaEPfqGcCuDZgqc/TbnVh5ooOTQ1++0oKboC0BWVbafMy0Xzsbfs0IQUg5Mu6sqg1e0TGp8qo2p8NYO0uJaHwsKYga2ZRbuLl6V+sKuxuRgZTpSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732648925; c=relaxed/simple;
	bh=Tx4nq6h2ijS+LiE7a1xDS6lf7PnT5ozDnUWKyeedMEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPs1yyGkt1IzCSjlOlXGyvf0rM9xNReUXsEj0vPcIqWpzR/ntSoLwavPKrIkA91l78Qm0HlX/fP+mcN73O1Q8Qm3yTe0tLWMnq7nBfGYZB8Mf6dSk8XCQl9aNF6DQOTDmJWvj2+e9HjOZxqxYGOOz5tblpx4UCMf4QPAoZjhV9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=aRyJaV5j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yeJHCV7n; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AC3BE2540100;
	Tue, 26 Nov 2024 14:22:01 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 26 Nov 2024 14:22:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1732648921; x=1732735321; bh=cwuf+PUXVW
	VUrge5NObdON9cVvMeTkSe/yLgqRUYeWo=; b=aRyJaV5jv7Wu2Mq/vehF4FUXJ5
	pIMjujyjGY2AvZ5/CH3E0SmoeoHyn+Hj2SlteJ3Gz4kFs4KqkNFYeuJMSnujkCdR
	Muv4l3trOgyGlPDaxMr/ZmH/+K0FcqPWN8Z9ivzUpua3kTBTBNA2xciCF0tjmGnK
	e/EjwK0FkXL4Q1MSRR+gkPn6MKOm1h36Y/CS+q5/RIuHjMAA60vkX68Z0Tj67Re8
	zw52m6X23uS9l2vxT6IVRUSpCaNn4fgM1G+DXu31f9XaZkZMwW4784/aadav6JyC
	e3AWJO+iT+hgTA2hm6zOTbz6llbVniM32jDXQ6KJXPbhCNyvhXUuk/feRaCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732648921; x=1732735321; bh=cwuf+PUXVWVUrge5NObdON9cVvMeTkSe/yL
	gqRUYeWo=; b=yeJHCV7nlXgTiUfkf14Ou9LTUjCd/HnvyxSBl9cVwY9MuN4L4ic
	XFofC61JC19MFRNoCdYqgEvnnt3F1Lzl83JNqs/4jQy66Q9XNZmHOMYyvd5GBDZU
	6Avt893Jd4SoBp6YWAvbjFRKnE7Um0TA7hUDiIPEOMmBsiRFS/i4qS5tAEk5A7UP
	EbXiZjsbdTQRRW0h3FwarSeAS7dz6i0/4nyKwPGRSCbNftWcE+VbVqye5fFCyDR2
	xPRLNBi2axW9b0F1l72EzG0Qm4qnS6MNjh4SwxhLH1tmnGKzlCuN/Lgi/Oehdeca
	CMsRaW/g9b7AAD2oe6yotMKY26KVNMHshYQ==
X-ME-Sender: <xms:2R9GZyHpEuQdfKQFlR_LBJf72O4YpB-dbwOgS3eFwxz0NHidpneKZQ>
    <xme:2R9GZzUF4-nodlnokM2whUoVI2Psxhq8cGOKvJwvaZEo65K8ipd4cDqG-ROu-0IEk
    G6PCL9t-nreOWcMrQ>
X-ME-Received: <xmr:2R9GZ8Itk0ayFgQj9h-tGWlbczG8zZvyU8Ts5xkL7M14STOFnVHAse1QV4wF5jf7niFbQrc0kkwNiig4nSZdVEHxV-bK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeejgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehgtdfsredttdejnecuhfhrohhmpeetlhihshhsrgcutfhoshhsuceo
    hhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeeihfevgfdttdfhgeejle
    ekvdeigeeugfefvdffgfdtveeiudffhfekvdefkeejveenucffohhmrghinhepghgvnhht
    ohhordhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhephhhisegrlhihshhsrgdrihhspdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegsrghsvgdqshihshhtvghmsehgvghnthhoohdrohhrgh
    dprhgtphhtthhopeguihhlfhhrihgughgvsehgvghnthhoohdrohhrghdprhgtphhtthho
    pehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhope
    hnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2R9GZ8EzgvcypWCfrznHpTehBRV9tDfLSJgmpMh6gy-77T1Yn_YO7w>
    <xmx:2R9GZ4UzH63DP9gV7vJCpdUKS6Lrk5I74P0QQHGaDCqolXSELdLjew>
    <xmx:2R9GZ_MJFRSCFXZxaNHjndUfkqaxF8NGjkM8nyT5G0DYC3qoA5LZ6Q>
    <xmx:2R9GZ_0fh8zaPY7YjWGpGGFBemPHoSbu1BXRj0Mj8HVCrsvDo7-5eg>
    <xmx:2R9GZ2zRy2E9dMlmBdbkbvF2ZgBJ0e2TIdAqZTBydwV3dMslLDVrS-Sb>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 14:22:00 -0500 (EST)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id 849C1ACB8; Tue, 26 Nov 2024 20:21:59 +0100 (CET)
Date: Tue, 26 Nov 2024 20:21:59 +0100
From: Alyssa Ross <hi@alyssa.is>
To: Andreas =?utf-8?Q?K=2E_H=C3=BCttel?= <dilfridge@gentoo.org>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, 
	base-system@gentoo.org
Subject: Re: [PATCH] rdma.c: Add <libgen.h> include for basename on musl
Message-ID: <efynnp33l7trrake5hztg4vp5gf5otig4fdvp7wzsdmmlmvlar@utoqnqv52c7g>
References: <20240804161054.942439-1-dilfridge@gentoo.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mnuiv42syognp4nw"
Content-Disposition: inline
In-Reply-To: <20240804161054.942439-1-dilfridge@gentoo.org>


--mnuiv42syognp4nw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] rdma.c: Add <libgen.h> include for basename on musl
MIME-Version: 1.0

On Sun, Aug 04, 2024 at 06:10:20PM +0200, Andreas K. H=C3=BCttel wrote:
> This include file is required on musl for availability of basename.
>
> Note that for glibc adding the include can have the side effect of
> switching from the GNU implementation of basename (which does not touch
> its argument) to the POSIX implementation (which under certain
> circumstances modifies the string passed to it, e.g. removing trailing
> slashes).
>
> This is safe however since the C99 and C11 standard says:
> > The parameters argc and argv and the strings pointed to by the argv
> > array shall be modi=EF=AC=81able by the program, and retain their last-=
stored
> > values between program startup and program termination.
> (multiple google results, unfortunately no official reference link)
>
> Bug: https://bugs.gentoo.org/926341
> Signed-off-by: Andreas K. H=C3=BCttel <dilfridge@gentoo.org>
> ---
> Only build-tested so far, but should be straightforward enough...
> ---
>  rdma/rdma.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Alyssa Ross <hi@alyssa.is>

> diff --git a/rdma/rdma.c b/rdma/rdma.c
> index 131c6b2a..f835bf3f 100644
> --- a/rdma/rdma.c
> +++ b/rdma/rdma.c
> @@ -4,6 +4,7 @@
>   * Authors:     Leon Romanovsky <leonro@mellanox.com>
>   */
>
> +#include <libgen.h>
>  #include "rdma.h"
>  #include "version.h"
>  #include "color.h"
> --
> 2.44.2
>

--mnuiv42syognp4nw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCZ0Yf1gAKCRBbRZGEIw/w
oq9rAP9hMk8ygDbZ5feHw9dD5rX+//16Nko75sZKuVhJN66NkwD+L+lVmjhROuQJ
oN9+msWAbpnxjBhIkqlC6p4v2Cv9Mgo=
=l0se
-----END PGP SIGNATURE-----

--mnuiv42syognp4nw--

