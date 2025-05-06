Return-Path: <netdev+bounces-188482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3669FAAD0C5
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 00:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3AC77A80D6
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 22:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA2D1547CC;
	Tue,  6 May 2025 22:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOC6+m4b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB463D3B8
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746569252; cv=none; b=uMXGYotAyHgaizVNnVqgWx6X8vjkme58hUGhhq/bIwt7Vhs4rzL/G/SN7jNoBjUjpZLtob/iqq9KNiUJtHuBwlLTC9inClLLk4kalevf+oF0/PA2TKLLto+o16bUWQk7uDqAgFzL3+lm7cAICt7wpl/wYGuPA2yajodJIlzCiYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746569252; c=relaxed/simple;
	bh=fxl1zwdwf83zHAW+WeUNChTGRUu0f0pJNU+mkBqE4IA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LoZLkXJTCEdLYq3Ihsd7c/550UAJZq16xmJx14bYw7Ib8OXzBQSg0jGr2ut2nF62KCjDRZJ+QHudO+lVyGNNSn6APgO7ELHbZ5+nyUOWhwWiZD9V5tFcVajz9vh1DDsIJO2ZX3H3v/kQZWrDL5SQhqFAkjpQTx8mDhc0Bj6xngM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOC6+m4b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2949C4CEE4;
	Tue,  6 May 2025 22:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746569252;
	bh=fxl1zwdwf83zHAW+WeUNChTGRUu0f0pJNU+mkBqE4IA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bOC6+m4b4F2e1998COPBpUQ7q/7kzDJkjb52FzPsop9WsvumgaPWzk49I20CSBBfU
	 MuHxI99VGf2ghiqDqVeDeKTCeO/7mrNz+2ziWjyODvl5fKCvKT6ul5e9md9HOurnB9
	 ysZjCCc/zlnzBaEltVBuk0JE7oNnLidbZ0U0M40Subjp6NjLWRuntR1Jqg/6KJSrVa
	 JPMXmOHUY8UmMp7UOFh/pqzmY5Fo86j5coLx0NBONZ3ItcODHjjtOV2yAS6LyGWRNi
	 BfBMOBJLSnlP6vKeCDmZUNCpW/jExU5xR2LhXH/EfvtTKSAKe5NVOPmyoeA7j64Vdu
	 c6aV43YvBd1HQ==
Date: Tue, 6 May 2025 15:07:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, almasrymina@google.com,
 sdf@fomichev.me, netdev@vger.kernel.org, asml.silence@gmail.com,
 dw@davidwei.uk, skhawaja@google.com, willemb@google.com, jdamato@fastly.com
Subject: Re: [PATCH net v2] net: devmem: fix kernel panic when socket close
 after module unload
Message-ID: <20250506150730.4ea4d66c@kernel.org>
In-Reply-To: <20250506140858.2660441-1-ap420073@gmail.com>
References: <20250506140858.2660441-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue,  6 May 2025 14:08:58 +0000 Taehee Yoo wrote:
> Kernel panic occurs when a devmem TCP socket is closed after NIC module
> is unloaded.
>=20
> This is Devmem TCP unregistration scenarios. number is an order.
> (a)socket close    (b)pp destroy    (c)uninstall    result
> 1                  2                3               OK
> 1                  3                2               (d)Impossible
> 2                  1                3               OK
> 3                  1                2               (e)Kernel panic
> 2                  3                1               (d)Impossible
> 3                  2                1               (d)Impossible
>=20
> (a) netdev_nl_sock_priv_destroy() is called when devmem TCP socket is
>     closed.
> (b) page_pool_destroy() is called when the interface is down.
> (c) mp_ops->uninstall() is called when an interface is unregistered.
> (d) There is no scenario in mp_ops->uninstall() is called before
>     page_pool_destroy().
>     Because unregister_netdevice_many_notify() closes interfaces first
>     and then calls mp_ops->uninstall().
> (e) netdev_nl_sock_priv_destroy() accesses struct net_device to acquire
>     netdev_lock().
>     But if the interface module has already been removed, net_device
>     pointer is invalid, so it causes kernel panic.
>=20
> In summary, there are only 3 possible scenarios.
>  A. sk close -> pp destroy -> uninstall.
>  B. pp destroy -> sk close -> uninstall.
>  C. pp destroy -> uninstall -> sk close.
>=20
> Case C is a kernel panic scenario.
>=20
> In order to fix this problem, It makes mp_dmabuf_devmem_uninstall() set
> binding->dev to NULL.
> It indicates an bound net_device was unregistered.
>=20
> It makes netdev_nl_sock_priv_destroy() do not acquire netdev_lock()
> if binding->dev is NULL.
>=20
> It inverts socket/netdev lock order like below:
>     netdev_lock();
>     mutex_lock(&priv->lock);
>     mutex_unlock(&priv->lock);
>     netdev_unlock();
>=20
> Because of inversion of locking ordering, mp_dmabuf_devmem_uninstall()
> acquires socket lock from now on.
>=20
> Tests:
> Scenario A:
>     ./ncdevmem -s 192.168.1.4 -c 192.168.1.2 -f $interface -l -p 8000 \
>         -v 7 -t 1 -q 1 &
>     pid=3D$!
>     sleep 10
>     kill $pid
>     ip link set $interface down
>     modprobe -rv $module
>=20
> Scenario B:
>     ./ncdevmem -s 192.168.1.4 -c 192.168.1.2 -f $interface -l -p 8000 \
>         -v 7 -t 1 -q 1 &
>     pid=3D$!
>     sleep 10
>     ip link set $interface down
>     kill $pid
>     modprobe -rv $module
>=20
> Scenario C:
>     ./ncdevmem -s 192.168.1.4 -c 192.168.1.2 -f $interface -l -p 8000 \
>         -v 7 -t 1 -q 1 &
>     pid=3D$!
>     sleep 10
>     modprobe -rv $module
>     sleep 5
>     kill $pid
>=20
> Splat looks like:
> Oops: general protection fault, probably for non-canonical address 0xdfff=
fc001fffa9f7: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
> KASAN: probably user-memory-access in range [0x00000000fffd4fb8-0x0000000=
0fffd4fbf]
> CPU: 0 UID: 0 PID: 2041 Comm: ncdevmem Tainted: G    B   W           6.15=
.0-rc1+ #2 PREEMPT(undef)  0947ec89efa0fd68838b78e36aa1617e97ff5d7f
> Tainted: [B]=3DBAD_PAGE, [W]=3DWARN
> RIP: 0010:__mutex_lock (./include/linux/sched.h:2244 kernel/locking/mutex=
.c:400 kernel/locking/mutex.c:443 kernel/locking/mutex.c:605 kernel/locking=
/mutex.c:746)
> Code: ea 03 80 3c 02 00 0f 85 4f 13 00 00 49 8b 1e 48 83 e3 f8 74 6a 48 b=
8 00 00 00 00 00 fc ff df 48 8d 7b 34 48 89 fa 48 c1 ea 03 <0f> b6 f
> RSP: 0018:ffff88826f7ef730 EFLAGS: 00010203
> RAX: dffffc0000000000 RBX: 00000000fffd4f88 RCX: ffffffffaa9bc811
> RDX: 000000001fffa9f7 RSI: 0000000000000008 RDI: 00000000fffd4fbc
> RBP: ffff88826f7ef8b0 R08: 0000000000000000 R09: ffffed103e6aa1a4
> R10: 0000000000000007 R11: ffff88826f7ef442 R12: fffffbfff669f65e
> R13: ffff88812a830040 R14: ffff8881f3550d20 R15: 00000000fffd4f88
> FS:  0000000000000000(0000) GS:ffff888866c05000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000563bed0cb288 CR3: 00000001a7c98000 CR4: 00000000007506f0
> PKRU: 55555554
> Call Trace:
> <TASK>
>  ...
>  netdev_nl_sock_priv_destroy (net/core/netdev-genl.c:953 (discriminator 3=
))
>  genl_release (net/netlink/genetlink.c:653 net/netlink/genetlink.c:694 ne=
t/netlink/genetlink.c:705)
>  ...
>  netlink_release (net/netlink/af_netlink.c:737)
>  ...
>  __sock_release (net/socket.c:647)
>  sock_close (net/socket.c:1393)

I'll look at the code later today, but it will need a respin for sure:

net/core/netdev-genl.c: In function =E2=80=98netdev_nl_bind_rx_doit=E2=80=
=99:
net/core/netdev-genl.c:878:61: error: passing argument 3 of =E2=80=98net_de=
vmem_bind_dmabuf=E2=80=99 from incompatible pointer type [-Werror=3Dincompa=
tible-pointer-types]
  878 |         binding =3D net_devmem_bind_dmabuf(netdev, dmabuf_fd, priv,=
 info->extack);
      |                                                             ^~~~
      |                                                             |
      |                                                             struct =
netdev_nl_sock *
In file included from ../net/core/netdev-genl.c:16:
net/core/devmem.h:133:48: note: expected =E2=80=98struct netlink_ext_ack *=
=E2=80=99 but argument is of type =E2=80=98struct netdev_nl_sock *=E2=80=99
  133 |                        struct netlink_ext_ack *extack)
      |                        ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
net/core/netdev-genl.c:878:19: error: too many arguments to function =E2=80=
=98net_devmem_bind_dmabuf=E2=80=99
  878 |         binding =3D net_devmem_bind_dmabuf(netdev, dmabuf_fd, priv,=
 info->extack);
      |                   ^~~~~~~~~~~~~~~~~~~~~~
In file included from ../net/core/netdev-genl.c:16:
net/core/devmem.h:132:1: note: declared here
  132 | net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_=
fd,
      | ^~~~~~~~~~~~~~~~~~~~~~

This is on the kunit build so guessing some compat was missed.

