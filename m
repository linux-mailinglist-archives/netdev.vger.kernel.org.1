Return-Path: <netdev+bounces-94640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 866A98C008C
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4131528663B
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 15:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C0E86657;
	Wed,  8 May 2024 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMFghBqJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A7886653
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715180575; cv=none; b=oRMphIIaNjsO5eTZnEU9WgUbOfu53V8fTMTe7h1b86pLPE/BQgsZBug+Uhxfgf4ysn07iEB5iTJh7gvw6WuONeDSQtvwTTt58FSTJOzUuTf1ij1UJiX3IDcBsAWG+uwTXitFSMTaFyF/uGoS+6ICOtXoE0pAtVS42/x+Bh5wpuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715180575; c=relaxed/simple;
	bh=DwWHp3aJsqicIRjRd62VO7ko2wb3+uWVmunUzLnOpC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbbEs2fxi9kl/fMQW2z3XirBT3Idd2wykMRHZPGFvZn0mooAMsjFQh2yupcSwBN5zigyFpWsRCdDetgjVyM14tp55IFa3O5NQ+I2oU82+nSEJu1SliQCf50qcmbY6TiiVuK7gjruXrydUdxvD4q9DGHIloX7GyNX6hiUKfj3uPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMFghBqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9490C113CC;
	Wed,  8 May 2024 15:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715180575;
	bh=DwWHp3aJsqicIRjRd62VO7ko2wb3+uWVmunUzLnOpC0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PMFghBqJE9SoAiqjyMbv++c73Y5lM8xGjkkF7XSVFQVuq5NS6e3E3bCxhY/ghSVqp
	 mhSYgZZNofIfhELcnvtOFMxn1gzBXbHpDURyK7CvzxFQCm+U0PUbTi9OhoUNwIoyAJ
	 RXGtvFcygq/GFRKwNGSJhwuh4oksQghkDoUbwWu8LjK1fpL7nLV8JJnwJ6CowIi71d
	 4JR07ikWe6LGw6TKgmybqtRP3RiuRkriIfoMYlcTJ9s/AdZ81FC1Jc64xCoGx16UGJ
	 TR/s9gCHPeGwJJ95eQwBUVbEl/R2XyJfNQBp5NARPfzWB328ipk4/sn5XwdbRdxaCV
	 QCgFdZ1r6gyyA==
Message-ID: <ce6e18fb-5d5f-46cd-b7fe-16982a41cda8@kernel.org>
Date: Wed, 8 May 2024 09:02:53 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: fib6_rules: avoid possible NULL dereference in
 fib6_rule_action()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20240507163145.835254-1-edumazet@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240507163145.835254-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/24 10:31 AM, Eric Dumazet wrote:
> syzbot is able to trigger the following crash [1],
> caused by unsafe ip6_dst_idev() use.
> 
> Indeed ip6_dst_idev() can return NULL, and must always be checked.
> 
> [1]
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 0 PID: 31648 Comm: syz-executor.0 Not tainted 6.9.0-rc4-next-20240417-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
>  RIP: 0010:__fib6_rule_action net/ipv6/fib6_rules.c:237 [inline]
>  RIP: 0010:fib6_rule_action+0x241/0x7b0 net/ipv6/fib6_rules.c:267
> Code: 02 00 00 49 8d 9f d8 00 00 00 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 f9 32 bf f7 48 8b 1b 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 df e8 e0 32 bf f7 4c 8b 03 48 89 ef 4c
> RSP: 0018:ffffc9000fc1f2f0 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 1a772f98c8186700
> RDX: 0000000000000003 RSI: ffffffff8bcac4e0 RDI: ffffffff8c1f9760
> RBP: ffff8880673fb980 R08: ffffffff8fac15ef R09: 1ffffffff1f582bd
> R10: dffffc0000000000 R11: fffffbfff1f582be R12: dffffc0000000000
> R13: 0000000000000080 R14: ffff888076509000 R15: ffff88807a029a00
> FS:  00007f55e82ca6c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b31d23000 CR3: 0000000022b66000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>   fib_rules_lookup+0x62c/0xdb0 net/core/fib_rules.c:317
>   fib6_rule_lookup+0x1fd/0x790 net/ipv6/fib6_rules.c:108
>   ip6_route_output_flags_noref net/ipv6/route.c:2637 [inline]
>   ip6_route_output_flags+0x38e/0x610 net/ipv6/route.c:2649
>   ip6_route_output include/net/ip6_route.h:93 [inline]
>   ip6_dst_lookup_tail+0x189/0x11a0 net/ipv6/ip6_output.c:1120
>   ip6_dst_lookup_flow+0xb9/0x180 net/ipv6/ip6_output.c:1250
>   sctp_v6_get_dst+0x792/0x1e20 net/sctp/ipv6.c:326
>   sctp_transport_route+0x12c/0x2e0 net/sctp/transport.c:455
>   sctp_assoc_add_peer+0x614/0x15c0 net/sctp/associola.c:662
>   sctp_connect_new_asoc+0x31d/0x6c0 net/sctp/socket.c:1099
>   __sctp_connect+0x66d/0xe30 net/sctp/socket.c:1197
>   sctp_connect net/sctp/socket.c:4819 [inline]
>   sctp_inet_connect+0x149/0x1f0 net/sctp/socket.c:4834
>   __sys_connect_file net/socket.c:2048 [inline]
>   __sys_connect+0x2df/0x310 net/socket.c:2065
>   __do_sys_connect net/socket.c:2075 [inline]
>   __se_sys_connect net/socket.c:2072 [inline]
>   __x64_sys_connect+0x7a/0x90 net/socket.c:2072
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Fixes: 5e5f3f0f8013 ("[IPV6] ADDRCONF: Convert ipv6_get_saddr() to ipv6_dev_get_saddr().")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/fib6_rules.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



