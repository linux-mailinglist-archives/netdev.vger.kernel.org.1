Return-Path: <netdev+bounces-41553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D587CB4B4
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 22:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56FE7B20F8D
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 20:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B24130FBC;
	Mon, 16 Oct 2023 20:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="GWQMVXQZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751AF37CBC
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 20:35:44 +0000 (UTC)
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF85CEE;
	Mon, 16 Oct 2023 13:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1697488539;
	bh=QIdiucrS3GrnXntvusWAnMhQFbLIMZWpsYTEgA0oZvk=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=GWQMVXQZ7y/HbCSGTSv83Wr3yTwhc+socxhzXVipZsxtx0T8JcxosbyMpIp3Lf8z7
	 JGKoumBA2EtRQkMukTFZR1ov6HnSh6vAOMfSSX8Qv3NG3x0SzdEfL6op9BJRNlrdit
	 8AE/gWj3NaT4wXWPw6kLwuuTLlvYsWwsqJPB4zMV8Ip+Gi8BNEAOdGvGp8rwKnnHXn
	 fIUROjStWO6J0jfFr/Y5Z/t9Pl4LzAySsoxK597OsUEHrgCxdr3Eao51iJp55Bdz4J
	 GF+q0YcnRS+Wrlqvkd6H9r/Figdls5+HeYs79FtkCRMTC4O7V3jlWQmzwQZRwL22hs
	 GwkNuU8yyzSjQ==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id D38D610408;
	Mon, 16 Oct 2023 22:35:39 +0200 (CEST)
Date: Mon, 16 Oct 2023 22:35:39 +0200
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	David Howells <dhowells@redhat.com>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	Kirill Tkhai <tkhai@ya.ru>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] af_unix: unix_stream_splice_read: always request
 MSG_DONTWAIT
Message-ID: <8db45d00902da22ae25aa16a0c28bb41002fc039.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rszd4xwxhzlr2ybj"
Content-Disposition: inline
In-Reply-To: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231006
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--rszd4xwxhzlr2ybj
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

--rszd4xwxhzlr2ybj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmUtnpsACgkQvP0LAY0m
WPFuFQ//RSJgctb0QfmDrNoHt0l9fqCJ7qs2IRUfTmE3JBSnwvfKCm8Jelz7qzp6
xIgixDpRNfjQi9fxf3mqnkV2vlSoktUE7uJQ43x742uVLD6PI3ZATjZuocMZpOgL
0HFJQhN5y+C7KKFmQPmgapK+uwyMNDDl4tfwS9JPrucOcfKfehhsHPZ+G94ZyiR8
4J9gmpdoHZrcJQeQth0v249B3P95wimjvYY4Ryb0Jx+/5Zt7eGcoJMDvcRAfKDps
5qRCQ2665+uqWToA0FQ3zIaoAwfCn4/mzO5CZXf+yks8MNFMnmqWPioCBoT8nErN
YiXMESTrVOTVTJNaqCR/9uw5L/SNiwV7paUGfzwHgcuPeSeQ/h+QScGqufRHZ6c9
5iawZ349lBkypA+vfPmt+KDVn66eGeP2/z/LD0fKetzTz4DBIkVa8InPO+2kecqe
zbKDrptCqTD+JYfdoKveZ1rEs+1dIzRjH88RVcsWxj3fu9vX8SDvuXeoBQa3CIuI
QEuaJlBz58whkkL6c5HVBHxy5SGgAQ+U6PkH0DeMXQ6/QuqgsqLVE7MlueT3lExY
Y2KOZDA8YKLHkxGPw8LmIJM9TdZYoHRjGKDVaBxtfSJ4Iwu0x94kOQNfqXRIDuMB
hUAAJoo5YVbMOGqPYhESksdb6XPtLVLONwlrPu+4qyF4eCvxiMs=
=dGfn
-----END PGP SIGNATURE-----

--rszd4xwxhzlr2ybj--

