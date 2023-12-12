Return-Path: <netdev+bounces-56338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 420DC80E8DA
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667C81C20C3C
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E395A0EC;
	Tue, 12 Dec 2023 10:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="ZU9lbK0R"
X-Original-To: netdev@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531CB19F;
	Tue, 12 Dec 2023 02:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1702375975;
	bh=XiOBb6P57asxhXUqF6o8dX8NQpgZ1/qlFGt6+205E9w=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=ZU9lbK0RZzdSsInvI8z6QMcZ/XDf2Hc+ZSU41pM7IAWZzlT5X1VzbB3bzTqqhZnsj
	 HpZAPs1CvELOwffrO7yXxL4+mebVIkgC4AMBhV4yggThKpbfuMhxFRIrxO9hDLbiaU
	 kqvDE+0uNlpwgs04+0H+h0kczUaF8hzPO2+XUOM9MD76VysjRpK9Hl2lHq+KX7F/lf
	 OPGFZUtMau3mPGvCn7W1YSDAZqB2uQ79ViMR62wNJPD8pa6NCJM6M4QatgZCANjMVA
	 MSNhZKZUXZCCS6vN9g4iTmnLYtpWZbsVSOAo4crQHompF6atfDC4dPcDcrSDcJ38RE
	 NEPIz/z31IdsA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 4F3E413780;
	Tue, 12 Dec 2023 11:12:55 +0100 (CET)
Date: Tue, 12 Dec 2023 11:12:55 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 09/11] net/tcp: tcp_splice_read: always do
 non-blocking reads
Message-ID: <1d44f2f64c18151d103ee045d1e3ce7a7d5534273.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="czo5rnf2ad2yjhau"
Content-Disposition: inline
In-Reply-To: <1cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>


--czo5rnf2ad2yjhau
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Otherwise we risk sleeping with the pipe locked for indeterminate
lengths of time.

sock_rcvtimeo() returns 0 if the second argument is true, so the
explicit re-try loop for empty read conditions can be removed
entirely.

Link: https://lore.kernel.org/linux-fsdevel/qk6hjuam54khlaikf2ssom6custxf5i=
s2ekkaequf4hvode3ls@zgf7j5j4ubvw/t/#u
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 net/ipv4/tcp.c | 30 +++---------------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 3f66cdeef7de..09b562e2c1bf 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -782,7 +782,6 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *pp=
os,
 		.len =3D len,
 		.flags =3D flags,
 	};
-	long timeo;
 	ssize_t spliced;
 	int ret;
=20
@@ -797,7 +796,6 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *pp=
os,
=20
 	lock_sock(sk);
=20
-	timeo =3D sock_rcvtimeo(sk, sock->file->f_flags & O_NONBLOCK);
 	while (tss.len) {
 		ret =3D __tcp_splice_read(sk, &tss);
 		if (ret < 0)
@@ -821,35 +819,13 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *=
ppos,
 				ret =3D -ENOTCONN;
 				break;
 			}
-			if (!timeo) {
-				ret =3D -EAGAIN;
-				break;
-			}
-			/* if __tcp_splice_read() got nothing while we have
-			 * an skb in receive queue, we do not want to loop.
-			 * This might happen with URG data.
-			 */
-			if (!skb_queue_empty(&sk->sk_receive_queue))
-				break;
-			sk_wait_data(sk, &timeo, NULL);
-			if (signal_pending(current)) {
-				ret =3D sock_intr_errno(timeo);
-				break;
-			}
-			continue;
+			ret =3D -EAGAIN;
+			break;
 		}
 		tss.len -=3D ret;
 		spliced +=3D ret;
=20
-		if (!tss.len || !timeo)
-			break;
-		release_sock(sk);
-		lock_sock(sk);
-
-		if (sk->sk_err || sk->sk_state =3D=3D TCP_CLOSE ||
-		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-		    signal_pending(current))
-			break;
+		break;
 	}
=20
 	release_sock(sk);
--=20
2.39.2

--czo5rnf2ad2yjhau
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmV4MiYACgkQvP0LAY0m
WPG3pw/6AkQyD3FZBepovZHpwSZiqDwdJ9GGHQ77hQiX8gJnNC+TGeFLAF1+nw1O
QMj+1IeWG9LEeZOVTUJ68lOTDxWkSUOCCHg7H4gWXOX01bdSNpjlEpg5A57ywcE0
/aZ24rp3Cd0mnAFH46+GMS7A3DnAkV4YsnwdlJkUTODJbezpgZ6Z7Z7bK9ybeAFM
vmUnIwOwO+laatF6fKqV/W8GMyQ8c5wQDFOuvwFAyQ6iK0nwFT6fb8GaFKeKC9n9
XsZubuU0sNanrheeOfe5EB4fwWc4T0R9QoEWrl8afOZLd1O0N18PtkNaP4UiilrH
8p5HWhGfX1m49nUENqq7n2ywAjdRq1+PyUPPrIWqFu/3+wtV5RGgnKuPKlXxKuow
FJfxO8LQvu/ZgX/tzEefKtAUC+pPblGXIKZbSeq1jahq4Lbw8B/x/FYW/ikBeta8
F8CiYtZ0bMHao4Z/ng8GUfb0iKr0usQdGpFhfSdjkl8c+0yY5Is5+6q2cPIwnqIj
Wqc9AvFO+3pcslrwIDiuxe/F6VlRQYOar71iJaO0C1uJpsjY2g2z3cuTr5r4RSRb
4JTaRpL4obBnaWCzFFmxYyuVP7jb9oK/XzjuWELkbZVsW0xiFHO1zdHaQ7cCHO1u
vKIhu3Ugwd72ArwRshXMGFVg2rmTyfugVtXrL/tfv8zDrpHYapk=
=1yQZ
-----END PGP SIGNATURE-----

--czo5rnf2ad2yjhau--

