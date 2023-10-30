Return-Path: <netdev+bounces-45144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E357DB291
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 05:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB022813B5
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 04:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C87662D;
	Mon, 30 Oct 2023 04:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EHFlLPOJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E51D19B
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 04:58:15 +0000 (UTC)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB861BC;
	Sun, 29 Oct 2023 21:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1698641891;
	bh=xAnfqE6UvaOpcjQUHnh8QC3ca91/EV9KNTkMgLrAa6A=;
	h=Date:From:To:Cc:Subject:From;
	b=EHFlLPOJ8h10vplzw9JC+d3UZAxyJP3VRdIxS/gFl6PmLHGvd9B6UpCaX3X4kLDhC
	 bnJ6N0AW94FkiRE9gVtZhWzdFKJ/fn5a3GPgmCz5X+HD8qlImMhsitAGiYYyAHPnaA
	 4EX9wrIKsrPEhDDFfKk7kW3WDjt0Wbwy4kOE1SoUjQ1ytVYprH4ax1u3gZ/Ek23B3w
	 mN+ecSii3Uqtd/HgHFsChQVGByHPfo7RYbtkoK/TMLZMj/zOXZfNoQI/vbNR9FqYah
	 4a8fy/Pvxov7brAeS4DEbaObK5dgaSCA76k8XWaSxxlOgqtok742KEuUFjEetPdPvq
	 M1W0UgGpqXiUg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SJgyB0FRLz4xPc;
	Mon, 30 Oct 2023 15:58:09 +1100 (AEDT)
Date: Mon, 30 Oct 2023 15:58:09 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Herbert Xu <herbert@gondor.apana.org.au>, David Miller
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Networking <netdev@vger.kernel.org>, Linux Crypto List
 <linux-crypto@vger.kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>,
 Dmitry Safonov <dima@arista.com>, Francesco Ruggeri <fruggeri@arista.com>,
 Salam Noureddine <noureddine@arista.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the crypto tree
Message-ID: <20231030155809.6b47288c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IUE_PZ37ZEPJh8N0o4YWKgf";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/IUE_PZ37ZEPJh8N0o4YWKgf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the crypto tree, today's linux-next build (powerpc
allyesconfig) failed like this:

net/ipv4/tcp_ao.c: In function 'tcp_ao_key_alloc':
net/ipv4/tcp_ao.c:1536:13: error: implicit declaration of function 'crypto_=
ahash_alignmask'; did you mean 'crypto_ahash_alg_name'? [-Werror=3Dimplicit=
-function-declaration]
 1536 |         if (crypto_ahash_alignmask(tfm) > TCP_AO_KEY_ALIGN) {
      |             ^~~~~~~~~~~~~~~~~~~~~~
      |             crypto_ahash_alg_name

Caused by commit

  0f8660c82b79 ("crypto: ahash - remove crypto_ahash_alignmask")

interacting with commit

  4954f17ddefc ("net/tcp: Introduce TCP_AO setsockopt()s")

from the net-next tree.

I have applied the following merge resolution patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 30 Oct 2023 15:54:37 +1100
Subject: [PATCH] fix up for "crypto: ahash - remove crypto_ahash_alignmask"

interacting with "net/tcp: Introduce TCP_AO setsockopt()s"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 net/ipv4/tcp_ao.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 6a845e906a1d..d18562bb3184 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1533,10 +1533,6 @@ static struct tcp_ao_key *tcp_ao_key_alloc(struct so=
ck *sk,
 		goto err_free_pool;
=20
 	tfm =3D crypto_ahash_reqtfm(hp.req);
-	if (crypto_ahash_alignmask(tfm) > TCP_AO_KEY_ALIGN) {
-		err =3D -EOPNOTSUPP;
-		goto err_pool_end;
-	}
 	digest_size =3D crypto_ahash_digestsize(tfm);
 	tcp_sigpool_end(&hp);
=20
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_/IUE_PZ37ZEPJh8N0o4YWKgf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU/N+EACgkQAVBC80lX
0GyRpQgApkMV3GYpdyCcJEoDc4Bb1NUeHqXGLd1oaA1oUwOFEvv/8Vqo/FZc71aU
FjuNMYtstipjjtCxsnnWJiO/XRBccTfzl0Wl5H6idyHTM/ygC1o97iSfbDVMo/2i
zFH7MBKxza3XkAWI5ehvRrPxs6TNiVM7jPniXc9enIhdXF46aFykwL99sIFURvr1
lVX3en5khOlCDlVkFDmqEc2Me+4wjZGVcSEyu+D4Hu+PewNPFmPNtXRV+VXWfkd/
TvSk8OJF/m6mtyZYWRn9zmXYtkLwtf6VWoJYAE1M1iskvRjZ2o3by3+h15S0kQtv
SXi0NrfozVkPqCRhfMes9D2NMMZJ0w==
=etA7
-----END PGP SIGNATURE-----

--Sig_/IUE_PZ37ZEPJh8N0o4YWKgf--

