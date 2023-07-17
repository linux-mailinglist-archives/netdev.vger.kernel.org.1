Return-Path: <netdev+bounces-18216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A7E755D63
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 09:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C08B3281134
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 07:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E7C9456;
	Mon, 17 Jul 2023 07:48:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE189453
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 07:48:15 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55921E4E
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 00:48:06 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qLIxK-0006Le-0u; Mon, 17 Jul 2023 09:47:42 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B6C8C1F3103;
	Mon, 17 Jul 2023 07:47:36 +0000 (UTC)
Date: Mon, 17 Jul 2023 09:47:36 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: YueHaibing <yuehaibing@huawei.com>
Cc: socketcan@hartkopp.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, urs.thuermann@volkswagen.de,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: bcm: Fix UAF in bcm_proc_show()
Message-ID: <20230717-uplifted-external-b00b04bbc903-mkl@pengutronix.de>
References: <20230715092543.15548-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g6pb5lgpv7xgaiok"
Content-Disposition: inline
In-Reply-To: <20230715092543.15548-1-yuehaibing@huawei.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--g6pb5lgpv7xgaiok
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15.07.2023 17:25:43, YueHaibing wrote:
> BUG: KASAN: slab-use-after-free in bcm_proc_show+0x969/0xa80
> Read of size 8 at addr ffff888155846230 by task cat/7862
>=20
> CPU: 1 PID: 7862 Comm: cat Not tainted 6.5.0-rc1-00153-gc8746099c197 #230
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xd5/0x150
>  print_report+0xc1/0x5e0
>  kasan_report+0xba/0xf0
>  bcm_proc_show+0x969/0xa80
>  seq_read_iter+0x4f6/0x1260
>  seq_read+0x165/0x210
>  proc_reg_read+0x227/0x300
>  vfs_read+0x1d5/0x8d0
>  ksys_read+0x11e/0x240
>  do_syscall_64+0x35/0xb0
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>=20
> Allocated by task 7846:
>  kasan_save_stack+0x1e/0x40
>  kasan_set_track+0x21/0x30
>  __kasan_kmalloc+0x9e/0xa0
>  bcm_sendmsg+0x264b/0x44e0
>  sock_sendmsg+0xda/0x180
>  ____sys_sendmsg+0x735/0x920
>  ___sys_sendmsg+0x11d/0x1b0
>  __sys_sendmsg+0xfa/0x1d0
>  do_syscall_64+0x35/0xb0
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>=20
> Freed by task 7846:
>  kasan_save_stack+0x1e/0x40
>  kasan_set_track+0x21/0x30
>  kasan_save_free_info+0x27/0x40
>  ____kasan_slab_free+0x161/0x1c0
>  slab_free_freelist_hook+0x119/0x220
>  __kmem_cache_free+0xb4/0x2e0
>  rcu_core+0x809/0x1bd0
>=20
> bcm_op is freed before procfs entry be removed in bcm_release(),
> this lead to bcm_proc_show() may read the freed bcm_op.
>=20
> Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Added to linux-can/testing.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--g6pb5lgpv7xgaiok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmS08hAACgkQvlAcSiqK
BOgFfggAojcEQr4p6wI4mldHtmOX14t0aqIERyhQpbvkzhb64+YzcZNxtLwM4eQn
UBl7jachYSRvkfspDqNZZSV12RoTyR/pKual6tiYu3T/dHIgEGoVBPIMp8LIn/8G
wc7e9pAD55gAqvFiwZvc/U7Gqh29hRMvJT/6ufbNXQKfhZUEIlxQ89CzG5Nyunzr
I8PKVOaeewcHyuQW6OmF7VifvxduBR5QFxUj6Fvjg2WwmH7hzvvccdIK5UOZluwX
CCLxR73C5OfCIVkhTQFHHe9NW3JZkY+vVKCdOZWuroZwc+JfHUf0764+w7o4+PTn
m6ZO/UjtObBvvj1BDl9opGx2DkrlHA==
=I2KL
-----END PGP SIGNATURE-----

--g6pb5lgpv7xgaiok--

