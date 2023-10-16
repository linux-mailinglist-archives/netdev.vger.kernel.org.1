Return-Path: <netdev+bounces-41554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F3D7CB4B7
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 22:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB8F4B2103F
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 20:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC7B31A67;
	Mon, 16 Oct 2023 20:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="NnbBuKeK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5A137CBC
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 20:35:54 +0000 (UTC)
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05108A2;
	Mon, 16 Oct 2023 13:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1697488550;
	bh=U1WgWCtmO/bEZ1AED24mCSnyrNXJpL+Y8jZtS7Uiqmw=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=NnbBuKeKpbCRZiKTZ0ErYxqllKdbeGYbOkrq7PCgezUnRSCKITL04C3B52B4ezIC2
	 qbWjx5knHEvFjx/c5qAQDFXWn4Gq1xy00JsQOD5qStbtjJ0JXZQP9eFmH4w+6qbKrk
	 i++jePBXe+2YsLtyp8j/DCzzc/CrE87I4JuWKRcHLIaXzAL4BCGCTL7OLrEmTcZTlf
	 /a4FJ6fSFhuU3Ow4xYUbIFIPmBMbTyDa/pzGfpK+kgNvBjOvcVPaYhy0A4hOmfl538
	 kFfoa8qrYOXCvCsZmeSve3t+x5tf85mAbx5H0jX9qIkYpcnSvoeHTkh4jbUMMJpHQR
	 4u9r4mx4oGR5g==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 298CE10414;
	Mon, 16 Oct 2023 22:35:50 +0200 (CEST)
Date: Mon, 16 Oct 2023 22:35:50 +0200
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Karsten Graul <kgraul@linux.ibm.com>, 
	Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] net/smc: smc_splice_read: always request MSG_DONTWAIT
Message-ID: <45da5ab094bcc7d3331385e8813074922c2a13c6.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="47tcgm2g6sbkxgtd"
Content-Disposition: inline
In-Reply-To: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231006
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--47tcgm2g6sbkxgtd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Otherwise we risk sleeping with the pipe locked for indeterminate
lengths of time.

Link: https://lore.kernel.org/linux-fsdevel/qk6hjuam54khlaikf2ssom6custxf5i=
s2ekkaequf4hvode3ls@zgf7j5j4ubvw/t/#u
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 net/smc/af_smc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index bacdd971615e..89473305f629 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3243,12 +3243,8 @@ static ssize_t smc_splice_read(struct socket *sock, =
loff_t *ppos,
 			rc =3D -ESPIPE;
 			goto out;
 		}
-		if (flags & SPLICE_F_NONBLOCK)
-			flags =3D MSG_DONTWAIT;
-		else
-			flags =3D 0;
 		SMC_STAT_INC(smc, splice_cnt);
-		rc =3D smc_rx_recvmsg(smc, NULL, pipe, len, flags);
+		rc =3D smc_rx_recvmsg(smc, NULL, pipe, len, MSG_DONTWAIT);
 	}
 out:
 	release_sock(sk);
--=20
2.39.2

--47tcgm2g6sbkxgtd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmUtnqUACgkQvP0LAY0m
WPFUKxAAtTKaJX/sYGTuVM8QUutGSWhA+NIlyw7Q1JsrTd4NMyNOH5/q0d+w2cO1
cJ97addBcqUihdkjrxN4J4OCdcgi2ZZOspVFvEKxRVdcuE63+ua1l/xdZ9Yn08Tm
KZMgk6khtM8Sh0cvOZKpkC2kNyLlavNBXmmd8efd+yCOJOaUIingaqaj7pOJOvf2
PPU3a1ErK8TCFIEugu/XDPvbvShTSJzOyw91E11NBB19TS72oxUdUoCW07OtZGoP
8nXUiQpKaG+LyKdam4qazu4oLBP5gBIy/cnYbwRrOtj8xdiOhxYBLSp7pYETWQQm
YqWe+IAnHzkzJUmdC+RcohBlFNAhIV4hPaGXS77VU3XKZgtGxvI4lrNIYwN3580K
JAVhAda2mbmqo5F7VWQt/mygvRtRy8AhWhffsPEdbQFvy9kIJj69cXmWtw6rrn+1
pQRc30hv1lDhsDug304WZMaub5XJujUzX3J8+7eGnBASw9bOb1K1pEpYaFlC6l2f
B5HmhckumNimxxG6To2FjxLLQytKZ2dr34g1B1xWVexdOVOkr2mc1WL/GabKh/53
/BPXGZ8jcvf4Ly1x41sO2xO2914R+jnjVVWwio32Eig5EemORZarxFbwB/KIo4G5
P29UVPy+jes7Icui9Zg1lxgYherj24YqXwfzbxKa+XQbO1Vho0Q=
=jEe8
-----END PGP SIGNATURE-----

--47tcgm2g6sbkxgtd--

