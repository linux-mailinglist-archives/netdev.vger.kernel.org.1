Return-Path: <netdev+bounces-13848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B90D73D58B
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 03:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563061C208CE
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 01:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9057EF;
	Mon, 26 Jun 2023 01:28:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208EA628
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 01:28:57 +0000 (UTC)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F03C6;
	Sun, 25 Jun 2023 18:28:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qq9Gp0wbgz4wb1;
	Mon, 26 Jun 2023 11:28:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1687742930;
	bh=tHVai39HxgjGHNP/zksmmKbc9HmL2vXQATBH3nrtmIk=;
	h=Date:From:To:Cc:Subject:From;
	b=qRz3LYRs0stJLsICMI4jvbq0Lx+qk4n4L9VDO3L2lMdcrnyQ4oW4EikpbkZxS65xu
	 rq+/IqZgIZTEfYOarRrpPsu9X1B8kTiNoeHQ+7vvipXJUACt0JzyCAbArG+x6CZz3h
	 hfq6SsNXR4Pa8MnvbK5xT47bZ0e/v3OpmT2ltFEv0VFiVADClHsePJZImdCXH25JzN
	 5YzsB5gPBPiEELo9UQt0JX2PpnG4wSMsqyqMnADd5y6lp6oweFdmeAu6lFS3+V7pTb
	 eaf4gM+cil75xkojJI5St7jwNCa39iNsUBaVon0oBEf6EMl6GXQhIeLfVpJSHu4DOp
	 1l6y60kjCu6gQ==
Date: Mon, 26 Jun 2023 11:28:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, Networking <netdev@vger.kernel.org>
Cc: David Howells <dhowells@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the net-next tree
Message-ID: <20230626112847.2ef3d422@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xdtucNmpqhA0UpIbgQavQMZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--Sig_/xdtucNmpqhA0UpIbgQavQMZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (native perf)
failed like this:

In file included from builtin-trace.c:907:
trace/beauty/msg_flags.c: In function 'syscall_arg__scnprintf_msg_flags':
trace/beauty/msg_flags.c:28:21: error: 'MSG_SPLICE_PAGES' undeclared (first=
 use in this function)
   28 |         if (flags & MSG_##n) { \
      |                     ^~~~
trace/beauty/msg_flags.c:50:9: note: in expansion of macro 'P_MSG_FLAG'
   50 |         P_MSG_FLAG(SPLICE_PAGES);
      |         ^~~~~~~~~~
trace/beauty/msg_flags.c:28:21: note: each undeclared identifier is reporte=
d only once for each function it appears in
   28 |         if (flags & MSG_##n) { \
      |                     ^~~~
trace/beauty/msg_flags.c:50:9: note: in expansion of macro 'P_MSG_FLAG'
   50 |         P_MSG_FLAG(SPLICE_PAGES);
      |         ^~~~~~~~~~

Caused by commit

  b848b26c6672 ("net: Kill MSG_SENDPAGE_NOTLAST")

There is no MSG_SPLICE_PAGES in tools/perf/trace/beauty/include/linux/socke=
t.h

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/xdtucNmpqhA0UpIbgQavQMZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSY6c8ACgkQAVBC80lX
0Gzy9gf7BbnAhJ+PyhJzcE3tD3D2p8tk+Ycg5XNOGQOQNfsOALTWKBnd4mkJaToX
eAg+moYZMw8mVHA56NuKPSiJT7+X2h3B5LTCt8Gf38nRVczvb57MWZKF4mBg2jZa
EGwTpazMY1j5H/0uYHkmLenJO1xVRYAkLoYcHgbQcm7fsoQ5L33pC+H0gY9NNHEY
fsb781ytiSdnS1HlZWc+JK2zO16DFLYtUKHXpW2AyIyzicpxrqHwleEwU/ezOplm
u8hSBPA6Omsy3qSOpMtiG6Sgr3em1sx1X7thXP/RTqg/fc4k7PsbqgqYwMzvy+Qr
KQvFsiTTPTyKqsZ7TgOTgQGrEuPMUg==
=eZf6
-----END PGP SIGNATURE-----

--Sig_/xdtucNmpqhA0UpIbgQavQMZ--

