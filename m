Return-Path: <netdev+bounces-177507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DECA7064C
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7DD3B1118
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A316525E81B;
	Tue, 25 Mar 2025 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="B2mR99ox";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SfYtYRw+"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4439A257AF2
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919010; cv=none; b=pXG9VakJDxBFWuI7ZEsKYqprzJOXoXqHLR8VJeDYajrC4L2MutWDbF1j++iqt1pCR4/o+rHUZr30UYaZJKPbIYNDouLMoBd/st4ALe8UITdUUvvswynXtQennAw5fI3rZuZippvCYXeoIA1TnGMOmHQMNoDhxcMBv7R/MMN3JC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919010; c=relaxed/simple;
	bh=hnI3j6943/+4VBqBfd/bdDokNjlObCkzNb9OezycivE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8hERfkIa+4uk65v78/DCaaLRBoJbRY8PXcFgQjWNaOSwuLIhZQJ68+KXbbiiEBl5BokyY7NFLXwLiA9KymnJw8soggdqLPYFk93LdklnrPkXGby6hQvZyHnsq0H0WHqOJjJv9XmKNxe2tnn3f6Jaj/plO/5tBch7b9tcgMpSZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=B2mR99ox; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SfYtYRw+; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 2DD921383A1A;
	Tue, 25 Mar 2025 12:10:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 25 Mar 2025 12:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1742919007; x=
	1743005407; bh=8tYUDNjQlwRUh1No/eFE+ipxva8um8T2Tn2/u8i9Urw=; b=B
	2mR99oxMUoNS21ZdgDfpxJPPgWeHf/svnNLqyWFs/FDntB84coDRY6emvb8nUXHU
	ZWY4DK3PNQCSPO58cQ5CJbxNboSAXZTyEg6qeVDF+9oNNQ7irN35XPvuMFzMw1oI
	eK+y7YiFpHVrvj1nu8YYxnYkMp5VMycbGNeB2SYYiGLhHFT7mPp9FUbY+4+mDUh1
	HgldPPzYICBMRa4tLgBErorsXyyQgh9rb4+LHeUmxgqT10YYCS3z4WsiTpLneMz3
	la6Xav67oh5PB/lznuSpYRWZzC3qrcSq6lwY/lxmCzddu43U/PuJISMIvfsi82zH
	pbd3dIuUvA5oaXvUfqksg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742919007; x=1743005407; bh=8tYUDNjQlwRUh1No/eFE+ipxva8um8T2Tn2
	/u8i9Urw=; b=SfYtYRw+AhF74jBdmYfGruZuhoDXAISg/edE6PQvHJw43izKavZ
	3A9wJAoprr+D3hjvGz3jRp6qi2nQfX72j5fYD64PYn5k82BVkyyRR9Ukt/wE4wDj
	nZ3edXWzeOReGHDJpOxEWcx3ykbe+C8ZL8h2VfUtAHv4TjWTnNmzZe1/fLed+f29
	bVHmQ7s3mBWewdbXOwfevV2R584fG2XIPpAgVYBilp8znr5Le6I0sMrjxS8Thcxz
	0i0i6+w8J4CvqIon+jFGkukKA7nlbzXnZ8KAzto3zRKNxX83BR1c2i+7X4H4bnDr
	ToVC0endia3+WDY/p3ESv+yr+vn4NXpOkmw==
X-ME-Sender: <xms:XtXiZ5rCEjRuc3ChBQTIUjxuLrcb4Eme-ROk-a5WIiYKKJzrDaVckw>
    <xme:XtXiZ7pTwUAARGj2Xl-fxJxjJOmsRt39Rz0qydmskgZT3LjkCcrR8_pBCT24xUDBb
    Lrc6o3GEBrwIAlI8lc>
X-ME-Received: <xmr:XtXiZ2MaYrYIVdFuOI2zF5wJ2g-6l36Dx8oKw2kQYFpVVy9Hn0j0Z-bIFKM_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeftdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhephffggeeivedthffgudffveegheeg
    vedvteetvedvieffuddvleeuueegueeggeehnecuffhomhgrihhnpehshiiikhgrlhhlvg
    hrrdgrphhpshhpohhtrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtph
    htthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprggsvghnihesrhgv
    ughhrghtrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphht
    thhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopeifihhllhgvmhguvggsrhhuihhjnhdrkhgvrhhnvghlsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepnhgrthhhrghnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:XtXiZ06aoT36-auCmTBZBaggb5-1dJyfLD1TtyoHa9t0ckYe2z5wLA>
    <xmx:XtXiZ46LnI48L0eQkOXyTCAoskGDyP3OY-74E_3lgk0HNAJ1HkuGmQ>
    <xmx:XtXiZ8ib16lL_9qM0zYJqkzFyzwOpOUz6hqnTMUueNNgOQCD0EBk4Q>
    <xmx:XtXiZ66VwIXgL6Kxk5hVQZpX9nWh7979mIUQ1fILIgHDKt4d9lVr2g>
    <xmx:X9XiZ5HqqTFd7sioaZF8J9lQbor7bhCUg3QDOaALxsZCKm1I7cw7TR41>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 12:10:06 -0400 (EDT)
Date: Tue, 25 Mar 2025 17:10:04 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH net-next v2 3/5] udp_tunnel: fix UaF in GRO accounting
Message-ID: <Z-LVXCFm9Dyf8seK@krikkit>
References: <cover.1742557254.git.pabeni@redhat.com>
 <70a8c5bdf58ed1937e2f3edbefb37c55cfe6ebc1.1742557254.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <70a8c5bdf58ed1937e2f3edbefb37c55cfe6ebc1.1742557254.git.pabeni@redhat.com>

2025-03-21, 12:52:54 +0100, Paolo Abeni wrote:
> Siyzkaller reported a race in UDP tunnel GRO accounting, leading to
> UaF:
> 
> BUG: KASAN: slab-use-after-free in udp_tunnel_update_gro_lookup+0x23c/0x2c0 net/ipv4/udp_offload.c:65
> Read of size 8 at addr ffff88801235ebe8 by task syz.2.655/7921
> 
> CPU: 1 UID: 0 PID: 7921 Comm: syz.2.655 Not tainted 6.14.0-rc6-syzkaller-01313-g23c9ff659140 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:408 [inline]
>  print_report+0x16e/0x5b0 mm/kasan/report.c:521
>  kasan_report+0x143/0x180 mm/kasan/report.c:634
>  udp_tunnel_update_gro_lookup+0x23c/0x2c0 net/ipv4/udp_offload.c:65
>  sk_common_release+0x71/0x2e0 net/core/sock.c:3896
>  inet_release+0x17d/0x200 net/ipv4/af_inet.c:435
>  __sock_release net/socket.c:647 [inline]
>  sock_release+0x82/0x150 net/socket.c:675
>  sock_free drivers/net/wireguard/socket.c:339 [inline]
>  wg_socket_reinit+0x215/0x380 drivers/net/wireguard/socket.c:435
>  wg_stop+0x59f/0x600 drivers/net/wireguard/device.c:133
>  __dev_close_many+0x3a6/0x700 net/core/dev.c:1717
>  dev_close_many+0x24e/0x4c0 net/core/dev.c:1742
>  unregister_netdevice_many_notify+0x629/0x24f0 net/core/dev.c:11923
>  rtnl_delete_link net/core/rtnetlink.c:3512 [inline]
>  rtnl_dellink+0x526/0x8c0 net/core/rtnetlink.c:3554
>  rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6945
>  netlink_rcv_skb+0x206/0x480 net/netlink/af_netlink.c:2534
>  netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>  netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
>  netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
>  sock_sendmsg_nosec net/socket.c:709 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:724
>  ____sys_sendmsg+0x53a/0x860 net/socket.c:2564
>  ___sys_sendmsg net/socket.c:2618 [inline]
>  __sys_sendmsg+0x269/0x350 net/socket.c:2650
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f35ab38d169
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f35ac28f038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f35ab5a6160 RCX: 00007f35ab38d169
> RDX: 0000000000000000 RSI: 0000400000000000 RDI: 0000000000000004
> RBP: 00007f35ab40e2a0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000001 R14: 00007f35ab5a6160 R15: 00007ffdddd781b8
>  </TASK>
> 
> Allocated by task 7770:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  unpoison_slab_object mm/kasan/common.c:319 [inline]
>  __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
>  kasan_slab_alloc include/linux/kasan.h:250 [inline]
>  slab_post_alloc_hook mm/slub.c:4115 [inline]
>  slab_alloc_node mm/slub.c:4164 [inline]
>  kmem_cache_alloc_noprof+0x1d9/0x380 mm/slub.c:4171
>  sk_prot_alloc+0x58/0x210 net/core/sock.c:2190
>  sk_alloc+0x3e/0x370 net/core/sock.c:2249
>  inet_create+0x648/0xea0 net/ipv4/af_inet.c:326
>  __sock_create+0x4c0/0xa30 net/socket.c:1539
>  sock_create net/socket.c:1597 [inline]
>  __sys_socket_create net/socket.c:1634 [inline]
>  __sys_socket+0x150/0x3c0 net/socket.c:1681
>  __do_sys_socket net/socket.c:1695 [inline]
>  __se_sys_socket net/socket.c:1693 [inline]
>  __x64_sys_socket+0x7a/0x90 net/socket.c:1693
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Freed by task 7768:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
>  poison_slab_object mm/kasan/common.c:247 [inline]
>  __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
>  kasan_slab_free include/linux/kasan.h:233 [inline]
>  slab_free_hook mm/slub.c:2353 [inline]
>  slab_free mm/slub.c:4609 [inline]
>  kmem_cache_free+0x195/0x410 mm/slub.c:4711
>  sk_prot_free net/core/sock.c:2230 [inline]
>  __sk_destruct+0x4fd/0x690 net/core/sock.c:2327
>  inet_release+0x17d/0x200 net/ipv4/af_inet.c:435
>  __sock_release net/socket.c:647 [inline]
>  sock_close+0xbc/0x240 net/socket.c:1389
>  __fput+0x3e9/0x9f0 fs/file_table.c:464
>  task_work_run+0x24f/0x310 kernel/task_work.c:227
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
>  do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The buggy address belongs to the object at ffff88801235e4c0
>  which belongs to the cache UDP of size 1856
> The buggy address is located 1832 bytes inside of
>  freed 1856-byte region [ffff88801235e4c0, ffff88801235ec00)
> 
> At disposal time, to avoid unconditionally acquiring a spin lock, UDP
> tunnel sockets are conditionally removed from the known tunnels list
> only if the socket is actually present in such a list.
> 
> Such check happens outside the socket lock scope: the current CPU
> could observe an uninitialized list entry even if the tunnel has been
> actually registered by a different core.
> 
> Address the issue moving the blamed check under the relevant list
> spin lock.
> 
> Reported-by: syzbot+1fb3291cc1beeb3c315a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1fb3291cc1beeb3c315a
> Fixes: 8d4880db37835 ("udp_tunnel: create a fastpath GRO lookup.")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

