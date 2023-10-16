Return-Path: <netdev+bounces-41555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6007CB4BA
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 22:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EABCB21101
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 20:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE20937CAC;
	Mon, 16 Oct 2023 20:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="lxMf2+MO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89AC381C0
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 20:35:58 +0000 (UTC)
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025A0123;
	Mon, 16 Oct 2023 13:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1697488552;
	bh=9mA+IthVHwQ9TSYNjqEKDb8kf+N/Q7iDq28AtGEeciE=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=lxMf2+MOA79RE4VScijXoK8rNPHRW9UOeU2uTN7EM3YPwY4rpMY26E74YOCzDsc0Z
	 miHGoe4GCcbE5k25IyGVdqMmWJxWZh+jogsXmzP5wnwDpOlQoEz8ZWQTodNwrq06fW
	 GVNIsHHOzTflFS5iB1HYVf1kIu0pyLi6X5qxFwTgwLlLMF75VYilOd/IjwCMyMNQth
	 Uq8ISe3D6PQvpknfDVmM7vPOrsSu8KpwvEfBGTRC9PiOEeHwkdQCEvk5pHYFqklOWJ
	 Vu9zdP6SkVzUBVkaq+S2OUUtjBaG+CoHmFWm4rErLjAhDe/Dek3x0yFFEhZDSmsdHB
	 UjarR9JexTauQ==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 44257FD48;
	Mon, 16 Oct 2023 22:35:52 +0200 (CEST)
Date: Mon, 16 Oct 2023 22:35:52 +0200
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Howells <dhowells@redhat.com>, 
	Shigeru Yoshida <syoshida@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Cong Wang <cong.wang@bytedance.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] kcm: kcm_splice_read: always request MSG_DONTWAIT
Message-ID: <b5a634f5fe1a89d42a7a4f91316f888b02ca576f.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3nezagrfhxjugaiu"
Content-Disposition: inline
In-Reply-To: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231006
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--3nezagrfhxjugaiu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Otherwise we risk sleeping with the pipe locked for indeterminate
lengths of time.

Also: don't pass the SPLICE_F_*-style flags argument to
skb_recv_datagram(), which expects MSG_*-style flags.
This fixes SPLICE_F_NONBLOCK not having worked.

Link: https://lore.kernel.org/linux-fsdevel/qk6hjuam54khlaikf2ssom6custxf5i=
s2ekkaequf4hvode3ls@zgf7j5j4ubvw/t/#u
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 net/kcm/kcmsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index dd1d8ffd5f59..de70156869e6 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1028,7 +1028,7 @@ static ssize_t kcm_splice_read(struct socket *sock, l=
off_t *ppos,
=20
 	/* Only support splice for SOCKSEQPACKET */
=20
-	skb =3D skb_recv_datagram(sk, flags, &err);
+	skb =3D skb_recv_datagram(sk, MSG_DONTWAIT, &err);
 	if (!skb)
 		goto err_out;
=20
--=20
2.39.2

--3nezagrfhxjugaiu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmUtnqcACgkQvP0LAY0m
WPFfPg/7BLf4GfCFFFQnpfm/hNBXK7uaqDIVht6nNEUVcBLk74rgK5ueYbLfqUVp
Kc+0lhKL1+bSUMuzrMJaSJVSWK3Vvz49OoZsSSOS9B0myJ7+LCuqbleTpWDtVkZV
WxLWS/bOHIrTJfgFuK01+sQ6pPd351OPUhPe1eDp6wEFdJpx+AjChB+OSqbgQUlT
W3PUhTzFHxgpxMbK0E9DGtOtbDJEqdmV4yfJznxKuIt6fKILfpDalFW8UoYbyVpp
N4KWofvUTi2SvIvye5IZgZsQwLdGHBkoKbBjZHZxEvBLf3T7YLfDu74DddOIST64
/HUsRAQcrilssrrLjvHZ0UmXtHlL15K+TkDpt6a9+6l+osqHz/uM861MH2W7qeFg
OxJLZL/gMs7NGk7m+EsCMbz+FKzA3s+nNyPSyL0cOYyPJ+Huo4Zau86MyV4jqabt
HwtUGgF8OX7JQRKlna+mOYsmFeRvPNet748OgwlAuIgRtg78lkSxN0Z44n4CaEzY
gPTQd21aElCxkWflX6DC4T1tIjOg0dVY07sgELYd3ge6CU01rmreyOnbXc6B9ZOG
i+QN4JZR0BkYXEs5j/vlI/s5jICilO3iqdjzFG6Sot/gQCysfazj3mL7X8wLWYKI
RhYSUaF6QMc/siOJZnazRBhjNKuzPyiYGrQpDUZqwp6LIaNyuVo=
=zW1r
-----END PGP SIGNATURE-----

--3nezagrfhxjugaiu--

