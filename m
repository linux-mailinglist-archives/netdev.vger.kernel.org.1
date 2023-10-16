Return-Path: <netdev+bounces-41557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D64097CB4BF
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 22:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EA2EB21086
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 20:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08690341B3;
	Mon, 16 Oct 2023 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="UmpOEYPJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EE1381BB
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 20:36:03 +0000 (UTC)
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A20A181;
	Mon, 16 Oct 2023 13:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1697488557;
	bh=9/Rch1NNnuQcxUUP1sdNlrNNgx7qX1hxKSFQK/3R+Pg=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=UmpOEYPJlFLiL4ag5qI+r8wZnOjdoxGBe9TfIsmDRZajgouiqNxZIFuEPmq0+t0dQ
	 XjWhFPb64jAe3/1/E7WKRc3Ygdb9pGYU9if2p7IqdndK6KJ8GrBb53XK4WCsLpu78l
	 GkAyuT4vdjDak/FatVvwXqPcKN4WjZDqSOHGvfLI7AR6N5xvSSbf53N0/Iji9xRtnR
	 YZyvcwA2KvsCuVaMmxmXgyCAVFZg/LCrx6pFjfeVTSfwIr2c6FcaMOiFhJXsYe/5rk
	 pfiDdyRNRKP+LR0YKcUBN668YPC9vsuIw7Sipc9Wiq9fw+t6hPM/0XI05F9OErBe36
	 1sb5wxpR2oNXg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 043D71041C;
	Mon, 16 Oct 2023 22:35:57 +0200 (CEST)
Date: Mon, 16 Oct 2023 22:35:56 +0200
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] net/tcp: tcp_splice_read: always do non-blocking reads
Message-ID: <d44f2f64c18151d103ee045d1e3ce7a7d5534273.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fzr4ntv4xizfeqvz"
Content-Disposition: inline
In-Reply-To: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231006
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--fzr4ntv4xizfeqvz
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

--fzr4ntv4xizfeqvz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmUtnqwACgkQvP0LAY0m
WPFjbRAApjaF2MmOlUN/7/0y1McNSrda5MBqzAFcQ3NKrJBC3+bbPLoxIayoT27x
JBVR4DxibstsZkxjjoeM2yMsxprbP6F6K0RzdKGp1PyjlioTxUJfgkhLyBckOEt7
KrSBEwTGDDtdnwCFWJBWHtjtdFyCjLu6PaDu1xQs6mS7JZbOkGrrEFIIuq2rUp6F
oBBzmc9CQut830eAB/UoJeVmU4WnFAT9Aqq5LcDQltkTp4XJYNsjyuzW2KCzhpuY
Y3tQrDDrxHvhaEfdMw9K8M30EycM0XEk2r119k51F/Hzgh//nKe1d6M9qYxo9P3e
n9OXOaq1VMVSHrkwgPe7z4jZpY/ot2ybHiw/EzZLtJ1Tyd8kSsnSAuSvBsEIo8nN
FwSRJvWPDx0pTixy/otgGaQ6aFlEUw5PMvrU6cKQeuGjtVHUKdzICoIFkBSuPZW8
9Jo7Ijlcy7r97AHFAYffvQm2WjazLhllHga1cxgLDKuFYsMxIGsSMLK5xilDGQr3
gQS3iDEf3mIeVoqayBlXgNmyiZFzRgeyShN29FCBVatfm+WU9z2syDzzGgChBvYd
A7vNgyuWzO99NF2E41J9iKP8HIPFronfsov+HM2SyZnWsFabdlGqTYlUDlIk+Vv+
+mwy+pPB4/Y+ihlEjTMU2hwbRs6mS0JM9Xm71w7V++uZfNNkPy0=
=KTUg
-----END PGP SIGNATURE-----

--fzr4ntv4xizfeqvz--

