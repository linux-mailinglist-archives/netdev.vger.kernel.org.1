Return-Path: <netdev+bounces-117109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A6394CBCD
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 10:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70789B20D5B
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 08:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA1016CD2E;
	Fri,  9 Aug 2024 08:00:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3742BC8D1
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723190410; cv=none; b=TKowFDsC0AzY+0wli5FzPiVWauUz0lnvjJZcXhwHXEteSnCI8upVa4yZJXnBXATqjGfBCqzkhoZjUNg8RvhP3jX47wLRbqjzp8NuqEutqZCDamZTP+15U5dkjTePNdx+lOomCRLqaoXCbROo0sFht2Vsn8Hx2oJzQBQB4qEFLog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723190410; c=relaxed/simple;
	bh=RoPdvsYEFl36YioiyL3Yrz2txiM5pG4P5zpSgwteBAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLens2MSdGMpj68WeyPA6Rq6+LGR4SFB5Mm+oekJzjBrN23SgJMjoWi8kmYoAbpw2MTlGMP/XBhJW7mw7gvPtyQNW2IfzLhtvBEhDhXdcV4CCFTyjc0ThYii1VW4k+cICJO7BwQb0eUkNjb6e1l09guRfo9d2uxbOaEGG0+GiUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [46.222.110.9] (port=3150 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1scKXR-007jcX-Qk; Fri, 09 Aug 2024 09:59:56 +0200
Date: Fri, 9 Aug 2024 09:59:51 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH net] gtp: pull network headers in gtp_dev_xmit()
Message-ID: <ZrXMd2H6tcanSsWN@calendula>
References: <20240808132455.3413916-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240808132455.3413916-1-edumazet@google.com>
X-Spam-Score: -1.7 (-)

On Thu, Aug 08, 2024 at 01:24:55PM +0000, Eric Dumazet wrote:
> syzbot/KMSAN reported use of uninit-value in get_dev_xmit() [1]
> 
> We must make sure the IPv4 or Ipv6 header is pulled in skb->head
> before accessing fields in them.
> 
> Use pskb_inet_may_pull() to fix this issue.
> 
> [1]
> BUG: KMSAN: uninit-value in ipv6_pdp_find drivers/net/gtp.c:220 [inline]
>  BUG: KMSAN: uninit-value in gtp_build_skb_ip6 drivers/net/gtp.c:1229 [inline]
>  BUG: KMSAN: uninit-value in gtp_dev_xmit+0x1424/0x2540 drivers/net/gtp.c:1281
>   ipv6_pdp_find drivers/net/gtp.c:220 [inline]
>   gtp_build_skb_ip6 drivers/net/gtp.c:1229 [inline]
>   gtp_dev_xmit+0x1424/0x2540 drivers/net/gtp.c:1281
>   __netdev_start_xmit include/linux/netdevice.h:4913 [inline]
>   netdev_start_xmit include/linux/netdevice.h:4922 [inline]
>   xmit_one net/core/dev.c:3580 [inline]
>   dev_hard_start_xmit+0x247/0xa20 net/core/dev.c:3596
>   __dev_queue_xmit+0x358c/0x5610 net/core/dev.c:4423
>   dev_queue_xmit include/linux/netdevice.h:3105 [inline]
>   packet_xmit+0x9c/0x6c0 net/packet/af_packet.c:276
>   packet_snd net/packet/af_packet.c:3145 [inline]
>   packet_sendmsg+0x90e3/0xa3a0 net/packet/af_packet.c:3177
>   sock_sendmsg_nosec net/socket.c:730 [inline]
>   __sock_sendmsg+0x30f/0x380 net/socket.c:745
>   __sys_sendto+0x685/0x830 net/socket.c:2204
>   __do_sys_sendto net/socket.c:2216 [inline]
>   __se_sys_sendto net/socket.c:2212 [inline]
>   __x64_sys_sendto+0x125/0x1d0 net/socket.c:2212
>   x64_sys_call+0x3799/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:45
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Uninit was created at:
>   slab_post_alloc_hook mm/slub.c:3994 [inline]
>   slab_alloc_node mm/slub.c:4037 [inline]
>   kmem_cache_alloc_node_noprof+0x6bf/0xb80 mm/slub.c:4080
>   kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:583
>   __alloc_skb+0x363/0x7b0 net/core/skbuff.c:674
>   alloc_skb include/linux/skbuff.h:1320 [inline]
>   alloc_skb_with_frags+0xc8/0xbf0 net/core/skbuff.c:6526
>   sock_alloc_send_pskb+0xa81/0xbf0 net/core/sock.c:2815
>   packet_alloc_skb net/packet/af_packet.c:2994 [inline]
>   packet_snd net/packet/af_packet.c:3088 [inline]
>   packet_sendmsg+0x749c/0xa3a0 net/packet/af_packet.c:3177
>   sock_sendmsg_nosec net/socket.c:730 [inline]
>   __sock_sendmsg+0x30f/0x380 net/socket.c:745
>   __sys_sendto+0x685/0x830 net/socket.c:2204
>   __do_sys_sendto net/socket.c:2216 [inline]
>   __se_sys_sendto net/socket.c:2212 [inline]
>   __x64_sys_sendto+0x125/0x1d0 net/socket.c:2212
>   x64_sys_call+0x3799/0x3c10 arch/x86/include/generated/asm/syscalls_64.h:45
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> CPU: 0 UID: 0 PID: 7115 Comm: syz.1.515 Not tainted 6.11.0-rc1-syzkaller-00043-g94ede2a3e913 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
> 
> Fixes: 999cb275c807 ("gtp: add IPv6 support")
> Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Pablo Neira Ayuso <pablo@netfilter.org>

Thanks.

