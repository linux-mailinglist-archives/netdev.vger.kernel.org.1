Return-Path: <netdev+bounces-103517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E0D908651
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 10:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C720028F21F
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 08:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E522E18FC65;
	Fri, 14 Jun 2024 08:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqLy8VkT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2091836DE
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 08:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718353754; cv=none; b=JFu8i8sIk1vwiWTs5bhSjTNPH4//Rts+oEHanw0ACVYofwGxWn6P2lnjhZRgywWrjatwKT55N2LtQbtwxYBGTQ2SI2YE2eo5Bzz1JJn63iP8e+O62bOhnR3XvYIW3vIA/C3K5QiN3VqWFAAjwwHSjxwMSkl9QlpRriifkFz8bGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718353754; c=relaxed/simple;
	bh=d4SLnfkUvKuP0i98DSJ8PSYyc5YJv+bFenwj82i1F3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAxg19WK/e26/PgRpm8NBAjXvSoSy77FyL+BxryrfvtjQCOzwp/hiR8+W2SdN0D6Hacg3srkgX+WY/7zfFQSW1SbPs0z3JhNuaCyaY5PwaWO83nxtWaaylphr0Alo9dVl9ZC9VASh70A4sFlXWDbl2H9eWfTZWkSxm57cIWzqGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqLy8VkT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD14C4AF1C;
	Fri, 14 Jun 2024 08:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718353754;
	bh=d4SLnfkUvKuP0i98DSJ8PSYyc5YJv+bFenwj82i1F3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bqLy8VkTbC+LcMdvTrX0jWZO5LpyGr5IJkA/mFjz0BBtro3bixX12RdVxvY0cOhRm
	 D/O2DhsZmaGb/MUk4suQlsCZUVBRtC8fEd0/ywJDhWdJOpeMCcuC6LW5V9a/Qr/8Pn
	 aJx6RAxxzr223zIz9dpLF6GrHBQnVDaQQ6B6KRtma9lCWt6Ud0pMmCzLvylL0i8TJL
	 OndjasN+1c3DJdN5ZOhHwEDGhFmNhxCwSk6W6taH0iyM5r2um2I1H+rgQdE1d06s11
	 HgN/wnwDXf4+DvTYGZ+Hog5XP0a/I5gMhAxDLVu6D5OQq/MfYq0aHiPPK1StonJr1q
	 IdpgKwVenQgmQ==
Date: Fri, 14 Jun 2024 10:29:10 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH net] ipv6: prevent possible NULL deref in fib6_nh_init()
Message-ID: <Zmv_VvmPyR0kftT2@lore-desk>
References: <20240614082002.26407-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+WJ9t/TXdOFo4YN1"
Content-Disposition: inline
In-Reply-To: <20240614082002.26407-1-edumazet@google.com>


--+WJ9t/TXdOFo4YN1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> syzbot reminds us that in6_dev_get() can return NULL.
>=20
> fib6_nh_init()
>     ip6_validate_gw(  &idev  )
>         ip6_route_check_nh(  idev  )
>             *idev =3D in6_dev_get(dev); // can be NULL
>=20
> Oops: general protection fault, probably for non-canonical address 0xdfff=
fc00000000bc: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x00000000000005e0-0x00000000000005e7]
> CPU: 0 PID: 11237 Comm: syz-executor.3 Not tainted 6.10.0-rc2-syzkaller-0=
0249-gbe27b8965297 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 06/07/2024
>  RIP: 0010:fib6_nh_init+0x640/0x2160 net/ipv6/route.c:3606
> Code: 00 00 fc ff df 4c 8b 64 24 58 48 8b 44 24 28 4c 8b 74 24 30 48 89 c=
1 48 89 44 24 28 48 8d 98 e0 05 00 00 48 89 d8 48 c1 e8 03 <42> 0f b6 04 38=
 84 c0 0f 85 b3 17 00 00 8b 1b 31 ff 89 de e8 b8 8b
> RSP: 0018:ffffc900032775a0 EFLAGS: 00010202
> RAX: 00000000000000bc RBX: 00000000000005e0 RCX: 0000000000000000
> RDX: 0000000000000010 RSI: ffffc90003277a54 RDI: ffff88802b3a08d8
> RBP: ffffc900032778b0 R08: 00000000000002fc R09: 0000000000000000
> R10: 00000000000002fc R11: 0000000000000000 R12: ffff88802b3a08b8
> R13: 1ffff9200064eec8 R14: ffffc90003277a00 R15: dffffc0000000000
> FS:  00007f940feb06c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 00000000245e8000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>   ip6_route_info_create+0x99e/0x12b0 net/ipv6/route.c:3809
>   ip6_route_add+0x28/0x160 net/ipv6/route.c:3853
>   ipv6_route_ioctl+0x588/0x870 net/ipv6/route.c:4483
>   inet6_ioctl+0x21a/0x280 net/ipv6/af_inet6.c:579
>   sock_do_ioctl+0x158/0x460 net/socket.c:1222
>   sock_ioctl+0x629/0x8e0 net/socket.c:1341
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:907 [inline]
>   __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f940f07cea9
>=20
> Fixes: 428604fb118f ("ipv6: do not set routes if disable_ipv6 has been en=
abled")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  net/ipv6/route.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 952c2bf1170942d411392b5bd5994cb057d3a983..28788ffde5854f7f3fa42f76b=
94ef76b87d2379b 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -3603,7 +3603,7 @@ int fib6_nh_init(struct net *net, struct fib6_nh *f=
ib6_nh,
>  	if (!dev)
>  		goto out;
> =20
> -	if (idev->cnf.disable_ipv6) {
> +	if (!idev || idev->cnf.disable_ipv6) {
>  		NL_SET_ERR_MSG(extack, "IPv6 is disabled on nexthop device");
>  		err =3D -EACCES;
>  		goto out;
> --=20
> 2.45.2.627.g7a2c4fd464-goog
>=20

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

--+WJ9t/TXdOFo4YN1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZmv/VgAKCRA6cBh0uS2t
rNqtAP47oIrcS8EBYmVDeXNH2q5xHwKp/7Y0AkyQsc5yE6fH6AEAu9wFOn9KFlsl
hg3IdJtl2o8mKTn4ls3ph0EVGk3b1AM=
=pdf2
-----END PGP SIGNATURE-----

--+WJ9t/TXdOFo4YN1--

