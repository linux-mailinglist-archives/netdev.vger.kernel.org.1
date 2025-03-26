Return-Path: <netdev+bounces-177659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD480A70FC6
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 05:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBCB13BED4D
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 04:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5129217A2EF;
	Wed, 26 Mar 2025 04:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="m1BT3k8A"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA672BB15;
	Wed, 26 Mar 2025 04:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742961717; cv=none; b=R3ViU1Z9osbey4Ir05X2RlkRqpVQfj5rfi5hgblBqCl2Dv0JhxWiwz9rKgpivFPkc4JSjxBL5JM6Kqg3+EixPWY4g2UXICeNkRv4wUbE8efd0u71c8WoAiV2Tm6rCpjHoFXdL7BmISGylaeNZ2aAxySUcCuQdefnZJRO3YAhLWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742961717; c=relaxed/simple;
	bh=ZfSoMc33qB/l3GDPsuSYgh4EhHc3kElyQwM8qwNCLeo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=AJqYPEJOoC/+0QUI9Mcjdp/GOEmErHeZULvvHTRZUnpo+P+SLCbn46kdPQuxldHO3gIdXDghoAjqKbLHmbhtkJehlDEjlEKXL/lQykru6FV2FJ0CemGVx3RLVxLb03oSXYEnC1OGwdhq/y1pvp+bm923BE5JZ+GTD8YK9Zaus4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=m1BT3k8A; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1742961710;
	bh=F98RMd0v2W7u7GsS9/A5PQYVXizV8j+2mjObVrUmias=;
	h=Date:From:To:Cc:Subject:From;
	b=m1BT3k8AQ6P3qRsl3fVGkf7hTpUoy4K9rpai/1G9AYNc7nPlqSPM6Vy/VxEC9k0xy
	 zynCBBWzVjmwLYUJQbuX1KETtBmpe245dJyWpUI8G3DoLYNcXKfnQfBgPuOZSiGrEN
	 /hsO9DwgoHorQsVJS6GDFxjV2HfYGfQZPMbQlimfag8X0MXhKHc9gmEQnydf8f0PM/
	 xF6FSSyILvtW8O4B01y4yehT1+BiEHWUZ5x0ekXgVkhd9maSuxJUCGxlzhZa9X95Kn
	 J9JwM+gS+HpLZpHZ3XWbVE4d9mqdf6b5/J2JnjoD28+99KltjWUIMJ2DH1cc6bqMvP
	 ruHdUEcaCSLvg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZMtQP6tF0z4wd0;
	Wed, 26 Mar 2025 15:01:49 +1100 (AEDT)
Date: Wed, 26 Mar 2025 15:01:48 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: John Johansen <john.johansen@canonical.com>, David Miller
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Networking
 <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the apparmor tree
Message-ID: <20250326150148.72d9138d@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZbV_BhTwyw=afJTEYdyleTJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ZbV_BhTwyw=afJTEYdyleTJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the apparmor tree, today's linux-next build (x86_64
allmodconfig) failed like this:

security/apparmor/af_unix.c: In function 'unix_state_double_lock':
security/apparmor/af_unix.c:627:17: error: implicit declaration of function=
 'unix_state_lock'; did you mean 'unix_state_double_lock'? [-Wimplicit-func=
tion-declaration]
  627 |                 unix_state_lock(sk1);
      |                 ^~~~~~~~~~~~~~~
      |                 unix_state_double_lock
security/apparmor/af_unix.c: In function 'unix_state_double_unlock':
security/apparmor/af_unix.c:642:17: error: implicit declaration of function=
 'unix_state_unlock'; did you mean 'unix_state_double_lock'? [-Wimplicit-fu=
nction-declaration]
  642 |                 unix_state_unlock(sk1);
      |                 ^~~~~~~~~~~~~~~~~
      |                 unix_state_double_lock

Caused by commit

  c05e705812d1 ("apparmor: add fine grained af_unix mediation")

interacting with commit

  84960bf24031 ("af_unix: Move internal definitions to net/unix/.")

from the net-next tree.

I have applied the following patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 26 Mar 2025 14:31:44 +1100
Subject: [PATCH] fix up for "apparmor: add fine grained af_unix mediation"

interacting with "af_unix: Move internal definitions to net/unix/."

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/net/af_unix.h | 3 +++
 net/unix/af_unix.h    | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index b588069ece7e..1af1841b7601 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -55,4 +55,7 @@ struct unix_sock {
 #define unix_sk(ptr) container_of_const(ptr, struct unix_sock, sk)
 #define unix_peer(sk) (unix_sk(sk)->peer)
=20
+#define unix_state_lock(s)	spin_lock(&unix_sk(s)->lock)
+#define unix_state_unlock(s)	spin_unlock(&unix_sk(s)->lock)
+
 #endif
diff --git a/net/unix/af_unix.h b/net/unix/af_unix.h
index ed4aedc42813..59db179df9bb 100644
--- a/net/unix/af_unix.h
+++ b/net/unix/af_unix.h
@@ -8,9 +8,6 @@
 #define UNIX_HASH_SIZE	(256 * 2)
 #define UNIX_HASH_BITS	8
=20
-#define unix_state_lock(s)	spin_lock(&unix_sk(s)->lock)
-#define unix_state_unlock(s)	spin_unlock(&unix_sk(s)->lock)
-
 struct sock *unix_peer_get(struct sock *sk);
=20
 struct unix_skb_parms {
--=20
2.45.2

--=20
Cheers,
Stephen Rothwell

--Sig_/ZbV_BhTwyw=afJTEYdyleTJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmfjfCwACgkQAVBC80lX
0Gz9zwf+KH7mlPcIKpMLx9vYrm1H8LYrC4iV7S3iKhscGn0ZJX5LsyXF/FcMANGN
YYGa1zAyOlbTgw5Etsxq0GiYtYaG2UO2in+cyCmFseix6SP1SzKreXXmKhXPpghg
Zp/laEm7sW7CAjAFuBgqJF3CLJIFGT/3x0pnqWOZ8vHo0nEtMOL2OoZTwI/wCudl
F4dnWAacgTe7A6rcGPY2T+esnspklArq/jDXDhQV/WchRoVAtdYksqG3cfVvzZwR
HzAAPBcHdLYvUmLF0Atv+aHxo4qabVWMoD1CB/P7RdOulIufJokumMJLIQkNoRDj
1vSj4Q8vtglpbKABrid43D0rHDB6VA==
=FUA+
-----END PGP SIGNATURE-----

--Sig_/ZbV_BhTwyw=afJTEYdyleTJ--

