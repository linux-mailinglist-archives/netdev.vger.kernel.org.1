Return-Path: <netdev+bounces-42273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB707CE049
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 16:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2E91C20D47
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 14:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B41F15AD8;
	Wed, 18 Oct 2023 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vuwkx95M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1030437C9E
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 14:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4288FC433C8;
	Wed, 18 Oct 2023 14:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697640091;
	bh=L4PLzQD1zhp94N+NpnrCqtrR4j6ttBlzkBcf6MYAG84=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vuwkx95MnKdtCgS9+lgA2TmnOTYpBFIXa6jAewtNY267k1iwo2XZDdxE1E/xT/byF
	 v4xSDuZAvAsP1FH1FYJ/6NresDgUFOiYF3EBPu5PDdM8fI8FaEEKIzowUkf/xxiOPK
	 CHxJiUOaWcodMBAWITukwTOVCqlFjXyYkGmg2s/k5m4H98we3R3PDiWWJh2EvJNRoU
	 N5xG2zmp+2a4+SpXCveSrgJpwCYTkHVDcTqcmJvgqMYKc6tiGLi2nqg/IYe6eqEY1S
	 XFoJM2MiLj7vPKMXtUO/K+zxldnS7ZEnfC8NMatkqb3oodpBZD+vdEAAlkp/SjhlHj
	 tMRL2P3uARyvA==
Message-ID: <17ea07bc-ff0b-06d6-6e50-20141fd3abda@kernel.org>
Date: Wed, 18 Oct 2023 08:41:30 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net] ipv4: fib: annotate races around nh->nh_saddr_genid
 and nh->nh_saddr
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot <syzkaller@googlegroups.com>
References: <20231017192304.82626-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231017192304.82626-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/23 1:23 PM, Eric Dumazet wrote:
> syzbot reported a data-race while accessing nh->nh_saddr_genid [1]
> 
> Add annotations, but leave the code lazy as intended.
> 
> [1]
> BUG: KCSAN: data-race in fib_select_path / fib_select_path
> 
> write to 0xffff8881387166f0 of 4 bytes by task 6778 on cpu 1:
> fib_info_update_nhc_saddr net/ipv4/fib_semantics.c:1334 [inline]
> fib_result_prefsrc net/ipv4/fib_semantics.c:1354 [inline]
> fib_select_path+0x292/0x330 net/ipv4/fib_semantics.c:2269
> ip_route_output_key_hash_rcu+0x659/0x12c0 net/ipv4/route.c:2810
> ip_route_output_key_hash net/ipv4/route.c:2644 [inline]
> __ip_route_output_key include/net/route.h:134 [inline]
> ip_route_output_flow+0xa6/0x150 net/ipv4/route.c:2872
> send4+0x1f5/0x520 drivers/net/wireguard/socket.c:61
> wg_socket_send_skb_to_peer+0x94/0x130 drivers/net/wireguard/socket.c:175
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
> read to 0xffff8881387166f0 of 4 bytes by task 6759 on cpu 0:
> fib_result_prefsrc net/ipv4/fib_semantics.c:1350 [inline]
> fib_select_path+0x1cb/0x330 net/ipv4/fib_semantics.c:2269
> ip_route_output_key_hash_rcu+0x659/0x12c0 net/ipv4/route.c:2810
> ip_route_output_key_hash net/ipv4/route.c:2644 [inline]
> __ip_route_output_key include/net/route.h:134 [inline]
> ip_route_output_flow+0xa6/0x150 net/ipv4/route.c:2872
> send4+0x1f5/0x520 drivers/net/wireguard/socket.c:61
> wg_socket_send_skb_to_peer+0x94/0x130 drivers/net/wireguard/socket.c:175
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
> value changed: 0x959d3217 -> 0x959d3218
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 6759 Comm: kworker/u4:15 Not tainted 6.6.0-rc4-syzkaller-00029-gcbf3a2cb156a #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
> Workqueue: wg-kex-wg1 wg_packet_handshake_send_worker
> 
> Fixes: 436c3b66ec98 ("ipv4: Invalidate nexthop cache nh_saddr more correctly.")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/fib_semantics.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



