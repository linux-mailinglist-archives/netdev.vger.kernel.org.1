Return-Path: <netdev+bounces-40732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABCD7C887F
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 17:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8ED71C2117E
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 15:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70211B281;
	Fri, 13 Oct 2023 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ux7TX5yy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841C014AA6
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 15:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68417C433C8;
	Fri, 13 Oct 2023 15:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697210549;
	bh=c2JYWaHoIeIfFdJ4Ql+1dol9Mj/dIvd+1ctfD5PSQUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ux7TX5yyd84S3J2wIyC8oDn7BRhdRsrR429k0+zuPEi1XmXV64wSVzc8W7O83zmbS
	 vVQ8kAZSyk1lnD72J3h+0LN7gEYKroLK2PXvTuxIG9jeTk0USFkHpAKngt9Q9VxdTQ
	 gRDS6qEyjV0VYNt48eWgZxyudmEDY1DgHtxie0yTAu1u17JksH0IUyjibjO4dBgCLs
	 b1GvzgNeJHep2OEIjg2K1ci77cBhg6umWdefouIoekYBDeDVw3ieORN7leIAhBK0fH
	 aprJke6c5CieF/NEwb+smzdCQa06XQzZEwxROTeS56KJyRTXnLrYeZaX/ngIfL/ZN+
	 AXePkhxAHO/ag==
Date: Fri, 13 Oct 2023 17:22:25 +0200
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH net] xfrm: fix a data-race in xfrm_lookup_with_ifid()
Message-ID: <20231013152225.GL29570@kernel.org>
References: <20231011102429.799316-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011102429.799316-1-edumazet@google.com>

On Wed, Oct 11, 2023 at 10:24:29AM +0000, Eric Dumazet wrote:
> syzbot complains about a race in xfrm_lookup_with_ifid() [1]
> 
> When preparing commit 0a9e5794b21e ("xfrm: annotate data-race
> around use_time") I thought xfrm_lookup_with_ifid() was modifying
> a still private structure.
> 
> [1]
> BUG: KCSAN: data-race in xfrm_lookup_with_ifid / xfrm_lookup_with_ifid
> 
> write to 0xffff88813ea41108 of 8 bytes by task 8150 on cpu 1:
> xfrm_lookup_with_ifid+0xce7/0x12d0 net/xfrm/xfrm_policy.c:3218
> xfrm_lookup net/xfrm/xfrm_policy.c:3270 [inline]
> xfrm_lookup_route+0x3b/0x100 net/xfrm/xfrm_policy.c:3281
> ip6_dst_lookup_flow+0x98/0xc0 net/ipv6/ip6_output.c:1246
> send6+0x241/0x3c0 drivers/net/wireguard/socket.c:139
> wg_socket_send_skb_to_peer+0xbd/0x130 drivers/net/wireguard/socket.c:178
> wg_socket_send_buffer_to_peer+0xd6/0x100 drivers/net/wireguard/socket.c:200
> wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:40 [inline]
> wg_packet_handshake_send_worker+0x10c/0x150 drivers/net/wireguard/send.c:51
> process_one_work kernel/workqueue.c:2630 [inline]
> process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2703
> worker_thread+0x525/0x730 kernel/workqueue.c:2784
> kthread+0x1d7/0x210 kernel/kthread.c:388
> ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
> 
> write to 0xffff88813ea41108 of 8 bytes by task 15867 on cpu 0:
> xfrm_lookup_with_ifid+0xce7/0x12d0 net/xfrm/xfrm_policy.c:3218
> xfrm_lookup net/xfrm/xfrm_policy.c:3270 [inline]
> xfrm_lookup_route+0x3b/0x100 net/xfrm/xfrm_policy.c:3281
> ip6_dst_lookup_flow+0x98/0xc0 net/ipv6/ip6_output.c:1246
> send6+0x241/0x3c0 drivers/net/wireguard/socket.c:139
> wg_socket_send_skb_to_peer+0xbd/0x130 drivers/net/wireguard/socket.c:178
> wg_socket_send_buffer_to_peer+0xd6/0x100 drivers/net/wireguard/socket.c:200
> wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:40 [inline]
> wg_packet_handshake_send_worker+0x10c/0x150 drivers/net/wireguard/send.c:51
> process_one_work kernel/workqueue.c:2630 [inline]
> process_scheduled_works+0x5b8/0xa30 kernel/workqueue.c:2703
> worker_thread+0x525/0x730 kernel/workqueue.c:2784
> kthread+0x1d7/0x210 kernel/kthread.c:388
> ret_from_fork+0x48/0x60 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
> 
> value changed: 0x00000000651cd9d1 -> 0x00000000651cd9d2
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 15867 Comm: kworker/u4:58 Not tainted 6.6.0-rc4-syzkaller-00016-g5e62ed3b1c8a #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
> Workqueue: wg-kex-wg2 wg_packet_handshake_send_worker
> 
> Fixes: 0a9e5794b21e ("xfrm: annotate data-race around use_time")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>

Reviewed-by: Simon Horman <horms@kernel.org>


