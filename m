Return-Path: <netdev+bounces-92053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA798B538C
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 10:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 833B9B21B18
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 08:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D63C17BB4;
	Mon, 29 Apr 2024 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="lRGNtNJ6"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD01F9C3
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714380872; cv=none; b=GDkMGAVDxKDHd7Da2F7qbGNeYpkyPRZVs+2bP528yg/2fzX0fY2/7QCYkVfkJP8HAz6AiMaF9pFvIjfMqum6aFMoUVwI/gqRIFumPTc9YPpYandMg2F//qzHGoKlFryIJ74H8HZxCdfRHPa5uUIrDf8fj3YLlbUyOoRVuVlzZJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714380872; c=relaxed/simple;
	bh=fzKX3VZqocj5W5my76MqouVfB2rho1jV/QlkMF8l4ic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iNrBG4urqgZb6NLhjbJJR37pNPceAH6nBiT+yhb5c0sK2BdbspvorbFmovt9AvRKquksUuB9el70Wprh4QEN1l188EFVgzhd2VeZ9sD/ZT/9vZNhi/TZ7oQZDAJYPc5gz4Q/IsKFRT0dKqgbtC9mOIm5jKnzfILuaZNTpxAWg38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=lRGNtNJ6; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id AB70B8894C;
	Mon, 29 Apr 2024 10:54:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714380861;
	bh=hHZ+rfH6KeZNOGKRBTjsopT5HHP1G3c4PMH6sPEpIMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lRGNtNJ615HvHWFWIHr6yaB0L7pTg3PORr8ErmKVy1oMKNM36FdOape5Y8gx4n8FS
	 rvqItcUEPHabklmfE0Ky95lZ9Utb/95ee/nBWqMr/UoLxSzHrCpLUNMWtHcXJIIpLw
	 8kr2ursdN4Uag1rnSwbNjCAMS3gW9OF9oL82VBF9EXYoNZkvA+2qf5k7YnHmE7yZl1
	 oRtpN9Gs20x+h3I+O3Os/3Ap4WInvQnGe3STfWtap847dgJTX9wqubA4e2FZhSeIq1
	 t9GIg8xlS9CkaCDQNbBKqm1ib/tv212BivsMxHHt2KNtPz8gAycrfdcPoMboV2QLBa
	 AwgEg4z/eSPqQ==
Date: Mon, 29 Apr 2024 10:54:14 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH net-next] net: hsr: init prune_proxy_timer sooner
Message-ID: <20240429105414.55e0df30@wsk>
In-Reply-To: <20240426163355.2613767-1-edumazet@google.com>
References: <20240426163355.2613767-1-edumazet@google.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/r7y/gJRbU/x.JRo3Dhsxm9R";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/r7y/gJRbU/x.JRo3Dhsxm9R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

> We must initialize prune_proxy_timer before we attempt
> a del_timer_sync() on it.
>=20
> syzbot reported the following splat:
>=20
> INFO: trying to register non-static key.
> The code is fine but needs lockdep annotation, or maybe
> you didn't initialize this object before use?
> turning off the locking correctness validator.
> CPU: 1 PID: 11 Comm: kworker/u8:1 Not tainted
> 6.9.0-rc5-syzkaller-01199-gfc48de77d69d #0 Hardware name: Google
> Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> Workqueue: netns cleanup_net Call Trace:
>  <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>   assign_lock_key+0x238/0x270 kernel/locking/lockdep.c:976
>   register_lock_class+0x1cf/0x980 kernel/locking/lockdep.c:1289
>   __lock_acquire+0xda/0x1fd0 kernel/locking/lockdep.c:5014
>   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
>   __timer_delete_sync+0x148/0x310 kernel/time/timer.c:1648
>   del_timer_sync include/linux/timer.h:185 [inline]
>   hsr_dellink+0x33/0x80 net/hsr/hsr_netlink.c:132
>   default_device_exit_batch+0x956/0xa90 net/core/dev.c:11737
>   ops_exit_list net/core/net_namespace.c:175 [inline]
>   cleanup_net+0x89d/0xcc0 net/core/net_namespace.c:637
>   process_one_work kernel/workqueue.c:3254 [inline]
>   process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
>   worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
>   kthread+0x2f0/0x390 kernel/kthread.c:388
>   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> ODEBUG: assert_init not available (active state 0) object:
> ffff88806d3fcd88 object type: timer_list hint: 0x0 WARNING: CPU: 1
> PID: 11 at lib/debugobjects.c:517 debug_print_object+0x17a/0x1f0
> lib/debugobjects.c:514
>=20
> Fixes: 5055cccfc2d1 ("net: hsr: Provide RedBox support (HSR-SAN)")

Thanks for spotting it.

> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Lukasz Majewski <lukma@denx.de>
> ---
>  net/hsr/hsr_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index
> cd1e7c6d2fc03af0498dc2ce302069699a75cca7..86127300b102fe06eaced32a979e1c8=
da99339a7
> 100644 --- a/net/hsr/hsr_device.c +++ b/net/hsr/hsr_device.c
> @@ -592,6 +592,7 @@ int hsr_dev_finalize(struct net_device *hsr_dev,
> struct net_device *slave[2],=20
>  	timer_setup(&hsr->announce_timer, hsr_announce, 0);
>  	timer_setup(&hsr->prune_timer, hsr_prune_nodes, 0);
> +	timer_setup(&hsr->prune_proxy_timer, hsr_prune_proxy_nodes,
> 0);=20
>  	ether_addr_copy(hsr->sup_multicast_addr, def_multicast_addr);
>  	hsr->sup_multicast_addr[ETH_ALEN - 1] =3D multicast_spec;
> @@ -631,7 +632,6 @@ int hsr_dev_finalize(struct net_device *hsr_dev,
> struct net_device *slave[2],=20
>  		hsr->redbox =3D true;
>  		ether_addr_copy(hsr->macaddress_redbox,
> interlink->dev_addr);
> -		timer_setup(&hsr->prune_proxy_timer,
> hsr_prune_proxy_nodes, 0); mod_timer(&hsr->prune_proxy_timer,
>  			  jiffies +
> msecs_to_jiffies(PRUNE_PROXY_PERIOD)); }




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/r7y/gJRbU/x.JRo3Dhsxm9R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmYvYDcACgkQAR8vZIA0
zr3emAf/RTSIOH0exCHZuYIxK1COG+LzRzNO8a98lC2YqlAkVlA9E/7rCUDX876e
Y4LCvMwJrB9KiXrgVh4/SQzTLjkG9+Yk674ora4q7cR+TJBR9nkKOhNunjULJlUe
a2Y1lQXeaHmjm2NIlDhynlYY9lXtvR8hOHool2jFo6U/MbuWIXVsk4OCv4+RRPEn
JrSMG9l5sMgM2jzBMtFPgTNrLvRvi1azW8+XJMSnENWm4NaxQoTdr1ruw61sTS+n
SbkFrOsIAPufkeau+uDAIyd1fR5B0Y+9mm7PA3xiJXSScemvW5U+ms/8HAACOYi5
qrgcnXikIQax4Zy8nrdIK4DJ6Xdk5A==
=hnFZ
-----END PGP SIGNATURE-----

--Sig_/r7y/gJRbU/x.JRo3Dhsxm9R--

