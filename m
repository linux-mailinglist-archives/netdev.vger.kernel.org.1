Return-Path: <netdev+bounces-97193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6E88C9DC2
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 15:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D91F0B240C6
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 13:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87DE1353FE;
	Mon, 20 May 2024 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSP0dcJK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15B92BAEB
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716210021; cv=none; b=UhNKpFCiLIuipQ6y6zkfAsQDFFBSWC6JnS+q2Vep3BY1iC02FUgw6e3RR1W2bue6VfQ80cpurZC+JzgDxVa/X+ujP+/2U6i6UCYGPAd90rAULQ7jYPSyNxhFCn4Rd3rqhbmwvU1enHP/BtzFThoeYm+UzUTU+4WvsmQvWbwaMn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716210021; c=relaxed/simple;
	bh=NimmpjgK/mxEkaSY1BX9QRXu9dj5UsyMc0m8wx4D/gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDUMt2PZ9TR+huSzKbi3ZvKa8OCwBHwH12q2Ha04/Vm9uNRQdHqrG/+Ny6rHTgIdz0uN3M90dtmKFNWj5J8Bk4P+UYfsS6IGdZKCck57AFlYCKhRPv2roOWKWhcK1IaO/8soZZKTnyeciwaRtwTC7yLFg/1nZ6A6plsYuBzOJ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSP0dcJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A20CC2BD10;
	Mon, 20 May 2024 13:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716210021;
	bh=NimmpjgK/mxEkaSY1BX9QRXu9dj5UsyMc0m8wx4D/gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YSP0dcJKS4020PAMvKiifuf9uNuLxvXMpkmw5FJJgRHPkGG1uwnpBn6EUbVbGuDPB
	 CG7lyy5CN8P8JUZr1ncnhd9/ky/zIB7H/x9jsfS7QKQy9XUWxK13K7D27EgRVxLf3a
	 vUsFUzkvoUsRmFYjTjGkn7dt2ApY+6byv8XpXHQkRpb/Vs/H1VP6rSxHwr8biXB6AH
	 BNWpKgS5iXTDIqEGnHzjsXzUumxnkM9TeEeU+fvO9ju9AmGUM5z7senYQPILRBmZXu
	 /gpi7Yd63ZbMzSwQ0q0g5l7jAxhI5t/iAkhqyNDxDaDgF48vTcBeLotZBIOCDTfzEm
	 GzpCOVdl8c0mg==
Date: Mon, 20 May 2024 14:00:17 +0100
From: Simon Horman <horms@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Christoph Paasch <cpaasch@apple.com>
Subject: Re: [PATCH net] tcp: ensure sk_showdown is 0 for listening sockets
Message-ID: <20240520130017.GB764145@kernel.org>
References: <8db98a8fbf2ac673b355651852093579a913f3f1.1716199422.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8db98a8fbf2ac673b355651852093579a913f3f1.1716199422.git.pabeni@redhat.com>

On Mon, May 20, 2024 at 12:04:47PM +0200, Paolo Abeni wrote:
> Christoph reported the following splat:
> 
> WARNING: CPU: 1 PID: 772 at net/ipv4/af_inet.c:761 __inet_accept+0x1f4/0x4a0
> Modules linked in:
> CPU: 1 PID: 772 Comm: syz-executor510 Not tainted 6.9.0-rc7-g7da7119fe22b #56
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
> RIP: 0010:__inet_accept+0x1f4/0x4a0 net/ipv4/af_inet.c:759
> Code: 04 38 84 c0 0f 85 87 00 00 00 41 c7 04 24 03 00 00 00 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 ec b7 da fd <0f> 0b e9 7f fe ff ff e8 e0 b7 da fd 0f 0b e9 fe fe ff ff 89 d9 80
> RSP: 0018:ffffc90000c2fc58 EFLAGS: 00010293
> RAX: ffffffff836bdd14 RBX: 0000000000000000 RCX: ffff888104668000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: dffffc0000000000 R08: ffffffff836bdb89 R09: fffff52000185f64
> R10: dffffc0000000000 R11: fffff52000185f64 R12: dffffc0000000000
> R13: 1ffff92000185f98 R14: ffff88810754d880 R15: ffff8881007b7800
> FS:  000000001c772880(0000) GS:ffff88811b280000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fb9fcf2e178 CR3: 00000001045d2002 CR4: 0000000000770ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  inet_accept+0x138/0x1d0 net/ipv4/af_inet.c:786
>  do_accept+0x435/0x620 net/socket.c:1929
>  __sys_accept4_file net/socket.c:1969 [inline]
>  __sys_accept4+0x9b/0x110 net/socket.c:1999
>  __do_sys_accept net/socket.c:2016 [inline]
>  __se_sys_accept net/socket.c:2013 [inline]
>  __x64_sys_accept+0x7d/0x90 net/socket.c:2013
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x58/0x100 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x4315f9
> Code: fd ff 48 81 c4 80 00 00 00 e9 f1 fe ff ff 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 ab b4 fd ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffdb26d9c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002b
> RAX: ffffffffffffffda RBX: 0000000000400300 RCX: 00000000004315f9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
> RBP: 00000000006e1018 R08: 0000000000400300 R09: 0000000000400300
> R10: 0000000000400300 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000040cdf0 R14: 000000000040ce80 R15: 0000000000000055
>  </TASK>
> 
> Listener sockets are supposed to have a zero sk_shutdown, as the
> accepted children will inherit such field.
> 
> Invoking shutdown() before entering the listener status allows
> violating the above constraint.
> 
> After commit 94062790aedb ("tcp: defer shutdown(SEND_SHUTDOWN) for
> TCP_SYN_RECV sockets"), the above causes the child to reach the accept
> syscall in FIN_WAIT1 status.
> 
> Address the issue explicitly by clearing sk_shutdown at listen time.
> 
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/490
> Fixes: 1da177e4c3fu ("Linux-2.6.12-rc2")

nit: 1da177e4c3f

> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

...

