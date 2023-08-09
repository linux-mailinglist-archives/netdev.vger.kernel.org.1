Return-Path: <netdev+bounces-25674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86161775176
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 05:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E11BD281A3D
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 03:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8918EA2C;
	Wed,  9 Aug 2023 03:40:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A581632
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 03:40:56 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F97C9;
	Tue,  8 Aug 2023 20:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1691552453;
	bh=eYzYCpPfk9mGCdjkiffMCkKG4XvwoVeUP6ZVEPKf4pU=;
	h=Date:From:To:Cc:Subject:From;
	b=oJyc+gp61EwOaT9IK+bZVCQEQ6FpEaTKOav5LJIpwHeI9db80+whzUSJrwlzvIQFv
	 p5/UjrZLzo8NsCU0iDH8lKKDmeOZGAWNpTZBTUwNiFMISTFNKQwfhS7I2VOXjXS9D/
	 wnCbxCin/AcF6GAwF6C4F2nwQ8ciNzwaYj+VlcAkzaaiI9w/Q+uO4ULTE161YoY2uM
	 UaubInqub69xFoOQxEGVAh5oHju63X07mFvZLywVMfPPT1sGACFxNdpaUPCrNrffLO
	 3sSkazErw9EQ5PasuidJg/CcwUHzfzb3ZAWJVSE/AZyFuf3WjeM/wORRQy7q0xOiFw
	 EMbdxx//pMZMw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RLG6s1SYBz4wy5;
	Wed,  9 Aug 2023 13:40:53 +1000 (AEST)
Date: Wed, 9 Aug 2023 13:40:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>, David Miller <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Networking <netdev@vger.kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the tty tree with the net-next tree
Message-ID: <20230809134051.1167e40d@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YnfJMTaw1Wq4YKH1vQazNkL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--Sig_/YnfJMTaw1Wq4YKH1vQazNkL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tty tree got conflicts in:

  arch/powerpc/platforms/8xx/mpc885ads_setup.c
  arch/powerpc/platforms/8xx/tqm8xx_setup.c

between commit:

  33deffc9f19f ("net: fs_enet: Don't include fs_enet_pd.h when not needed")

from the net-next tree and commit:

  a833b201d908 ("serial: cpm_uart: Don't include fs_uart_pd.h when not need=
ed")

from the tty tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/platforms/8xx/mpc885ads_setup.c
index c7c4f082b838,6ecc7fa2a816..000000000000
--- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
@@@ -21,7 -21,7 +21,6 @@@
  #include <linux/device.h>
  #include <linux/delay.h>
 =20
- #include <linux/fs_uart_pd.h>
 -#include <linux/fs_enet_pd.h>
  #include <linux/fsl_devices.h>
  #include <linux/mii.h>
  #include <linux/of_address.h>
diff --cc arch/powerpc/platforms/8xx/tqm8xx_setup.c
index 6e56be852b2c,a451f5003abd..000000000000
--- a/arch/powerpc/platforms/8xx/tqm8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/tqm8xx_setup.c
@@@ -24,7 -24,7 +24,6 @@@
  #include <linux/device.h>
  #include <linux/delay.h>
 =20
- #include <linux/fs_uart_pd.h>
 -#include <linux/fs_enet_pd.h>
  #include <linux/fsl_devices.h>
  #include <linux/mii.h>
  #include <linux/of_fdt.h>

--Sig_/YnfJMTaw1Wq4YKH1vQazNkL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTTCsMACgkQAVBC80lX
0Gw5kwf/fAYuAin5HUdRUsmN/54+YLUDrHA3e6zW085taWz284bK9CbKSKYPNvyv
HfgTtkWHm7nqznKTOilzJqMb68BmN0bSntTvhNtEVZ2IIbnqwOy1aGYztyCoHjk9
1mfs5+cInfS35QC9P7rycXSFx5RoTEFlgfhAT10B+J31zIu5riqDuF+4QP1ZGoo3
GkOfMw9n9CuZhbNnNM/RzejPuHZHw+6EOlr85RrpRDNm2NxZQs53vN4R6S3SbUcD
VppR6tXDPH64e6uUiu9ZpU03yWajLPbZp4oVJ7IX/v2hm6kNrVDAOEEMFtFjQ5W2
LlKwc9DuI3RKHYAeuYbN1b0CfFtw4g==
=+N59
-----END PGP SIGNATURE-----

--Sig_/YnfJMTaw1Wq4YKH1vQazNkL--

