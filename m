Return-Path: <netdev+bounces-42249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9705C7CDDC9
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 15:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 032E7B20F7E
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 13:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E7F36AE4;
	Wed, 18 Oct 2023 13:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTgt6kdQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A84335C2
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 13:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C610C433C8;
	Wed, 18 Oct 2023 13:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697636944;
	bh=W/czjf7hUBZSUmXNp8SS3jQKCYKakcuieeyp9matIUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hTgt6kdQIodbtWJh20RVEsv12CnUPw/X9rQBsctFYlqX9urc3bzejdCZhFONokBRj
	 dE7Z/yN3TKc9IvjTYAa66K1hLc83Mwx8xIV22lSZLoAJynmRZ3nkaaGgUk/ykkCQ8Z
	 JkexlOcmM1l6g73LuZPWqk86gvU/VE+Ym/9YyFtCAHWSPjUYv1Yxd2GGrZi8OC+mBu
	 wFhh6qkFp+OCbu269GAPT+7iDkA/u8lINYtHVE1rASIoAU2dF75Ai6DoiJhxsganh/
	 SOkj36UTnsS/p9I7zIr+RUMvc9mx5XJCZwJHogS4PATu0Bu/0sL9626YN+kSrri8LB
	 PALN2UqU5YYrw==
Date: Wed, 18 Oct 2023 15:49:00 +0200
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH net] ipv4: fib: annotate races around nh->nh_saddr_genid
 and nh->nh_saddr
Message-ID: <20231018134900.GO1940501@kernel.org>
References: <20231017192304.82626-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017192304.82626-1-edumazet@google.com>

On Tue, Oct 17, 2023 at 07:23:04PM +0000, Eric Dumazet wrote:
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

Reviewed-by: Simon Horman <horms@kernel.org>


