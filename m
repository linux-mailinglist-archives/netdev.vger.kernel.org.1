Return-Path: <netdev+bounces-56334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 683B280E8CF
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 611E6B20B33
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9804C5B5CB;
	Tue, 12 Dec 2023 10:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="T2SIjZwb"
X-Original-To: netdev@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8C1A9;
	Tue, 12 Dec 2023 02:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1702375956;
	bh=GmhTyoCmHF6HqL+pWcL97O1/nAP/FmrlJL/j4tpBifk=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=T2SIjZwbG6EhhNDgN8BPDisp+H0VJJkoYAjObGhcc+zxY6SDD0I2QgLSSeuN6Gd0X
	 Shxww6COV76UAfTxT07ByfTU8S9DVidsI3WxOUB0A8ty488KqwitMerjTvjlX61wLb
	 FePvMbjBLI6Z3ylFOJ6jQShhZTjg8W45kOaJgH+sJ19ObdaUbhkCePZd8jFI+9hwH4
	 rqMLH1X/14jefE7ZmoA3AUZK7Eru3j9t/mjrurkgWZanJImAGm3UlAAscqEM1BIK5s
	 G76ahQPKcpVvOgrcOHV2Egx45kzthRd6A5I4urr8TGoFV+Xyda8GR4gYImsyPRwqeV
	 I8AV8RAk8BaqQ==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id BE56A12A78;
	Tue, 12 Dec 2023 11:12:36 +0100 (CET)
Date: Tue, 12 Dec 2023 11:12:36 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	David Howells <dhowells@redhat.com>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	Kirill Tkhai <tkhai@ya.ru>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 02/11] af_unix: unix_stream_splice_read: always
 request MSG_DONTWAIT
Message-ID: <18db45d00902da22ae25aa16a0c28bb41002fc039.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k2mx2flozmpmt4tz"
Content-Disposition: inline
In-Reply-To: <1cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>


--k2mx2flozmpmt4tz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Otherwise we risk sleeping with the pipe locked for indeterminate
lengths of time.

Link: https://lore.kernel.org/linux-fsdevel/qk6hjuam54khlaikf2ssom6custxf5i=
s2ekkaequf4hvode3ls@zgf7j5j4ubvw/t/#u
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 net/unix/af_unix.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 3e8a04a13668..9489b9bda753 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2889,15 +2889,12 @@ static ssize_t unix_stream_splice_read(struct socke=
t *sock,  loff_t *ppos,
 		.pipe =3D pipe,
 		.size =3D size,
 		.splice_flags =3D flags,
+		.flags =3D MSG_DONTWAIT,
 	};
=20
 	if (unlikely(*ppos))
 		return -ESPIPE;
=20
-	if (sock->file->f_flags & O_NONBLOCK ||
-	    flags & SPLICE_F_NONBLOCK)
-		state.flags =3D MSG_DONTWAIT;
-
 	return unix_stream_read_generic(&state, false);
 }
=20
--=20
2.39.2

--k2mx2flozmpmt4tz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmV4MhQACgkQvP0LAY0m
WPGK4w//ZWsmQV8Q0ys/yOVJNTrnIQX9XxXsgSvTvM8bu/AW65aPWEPav1OCZRMB
RAXJ2G6VjsYReDPcLY2QAJ3zHCvhBZCay5YsaaH9l6eUQixk08ko0ALTBcTjHJcz
M6ravdyeYXycwTgicG9JE9WZ/7FpkqAYlCf9rndmembpUCHayledBOpOGAnxJK2A
QpDLHRVvPYBSNRrY6gk9tKs/Kw2sOeeNYtoiWvGSs7TsHurzlmUM9iIZPFpHIfks
fmWfffXCRRubABzhZGsgVYwT/+8oLzLbGTyP23YMT5d43BrsBeIZbdiqMwJPkHBy
HDinEbb3uCQljkXbsZ7AhN+pGZvsE/rGYWaT+wnXDH1JdGubccq9gObcvhHgTpKN
q39M+vYO+miOmgFRIUBvjUuyEKtIHQtk2IuXR8hgkrr7+9w3jfI95CnP+UBBTCff
8J15zFNFM1pP9SwBgaXArqqrMFQapwJ2HW0cX3kC/IXYU991B6WqM1q8j0bn6Tbf
3EYgaHWNUvkvRjyPO2Bs+YHenmhuTSDyrNPqfyGr/JnRjSqpiDtBzDHLuzvENwyL
4oMl47n6lflZqtO5ixYd/I/IRGsHRyEEk+Zv8bC3rFc/E3JWZf5oHF5KCpVhTni9
hedHQ8L228bYumPsFu1DLBtAKn0F2uz4rj8i1blJYwJdrA4uIxo=
=1uXu
-----END PGP SIGNATURE-----

--k2mx2flozmpmt4tz--

