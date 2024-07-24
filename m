Return-Path: <netdev+bounces-112714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E985B93AB3F
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 04:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A58B8284A4B
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 02:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD9917547;
	Wed, 24 Jul 2024 02:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="X6vd+Yns"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF074E57D
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 02:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721788211; cv=none; b=U549wZplrgS43h3VRaMj0jpTTs5ugcj4dpA7swOyLmohJ0S21C3MserY5aOJ6ZMQzNjKJgSJNgkMbZ5/jMqMm9glrHQ4O8AFqaj6BuUYMYjJG8PHwrJa6teBmgzULPPvnw1B+kd1LV5E4c/0igs+D099lfe8AtroSApioqKeVwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721788211; c=relaxed/simple;
	bh=JamgX0eVYJNkqrVS+r5XDlZvx9EFZixK2xbF76nEJ+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lNzIlWZd8LJFLCmwNT2GgZDcwmxNOlnjtVVAikOJIWHZHKyWr3775ERJYQSw9z2XThc+bgjiH+TX8QR60WRZTynFKPun/W97J7cR0ecipUwY0ZS0ZMzcydM32pLb9yI567nhqv2ySnIgXGCXL2JCPwaj8jQdzNhJg6spNY7KOOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=X6vd+Yns; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721788201; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=D4EtLI5pVG9lcIh5By5x83yv055ezXJ8uSDkKVmTKBk=;
	b=X6vd+Yns/7ifQvdfLt/CdUzKtlV1EtEAw0/xkwu7tnmguznjz9Kwj1HCk54GMwctsl6XM1pPdAtY8IXoMZ5AnBVmUQ3JoWT3kt+1/36LEOQyXSlyRJQMxhlcFNG5J4TFqR0d+Tr/89Dvd1Mg+jL16hb3/doWOdH5e2GOwXqbOdI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WBBzfRG_1721788199;
Received: from 30.221.149.223(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WBBzfRG_1721788199)
          by smtp.aliyun-inc.com;
          Wed, 24 Jul 2024 10:30:00 +0800
Message-ID: <7250f49f-bfc0-4d7e-8de8-0468ff600a75@linux.alibaba.com>
Date: Wed, 24 Jul 2024 10:29:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: prevent UAF in inet_create()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot <syzkaller@googlegroups.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
 Dust Li <dust.li@linux.alibaba.com>, Niklas Schnelle <schnelle@linux.ibm.com>
References: <20240723175809.537291-1-edumazet@google.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20240723175809.537291-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/24/24 1:58 AM, Eric Dumazet wrote:
> Following syzbot repro crashes the kernel:
>
> socketpair(0x2, 0x1, 0x100, &(0x7f0000000140)) (fail_nth: 13)
>
> Fix this by not calling sk_common_release() from smc_create_clcsk().
>
> Stack trace:
> socket: no more sockets
> ------------[ cut here ]------------
> refcount_t: underflow; use-after-free.
>   WARNING: CPU: 1 PID: 5092 at lib/refcount.c:28 refcount_warn_saturate+0x15a/0x1d0 lib/refcount.c:28
> Modules linked in:
> CPU: 1 PID: 5092 Comm: syz-executor424 Not tainted 6.10.0-syzkaller-04483-g0be9ae5486cd #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
>   RIP: 0010:refcount_warn_saturate+0x15a/0x1d0 lib/refcount.c:28
> Code: 80 f3 1f 8c e8 e7 69 a8 fc 90 0f 0b 90 90 eb 99 e8 cb 4f e6 fc c6 05 8a 8d e8 0a 01 90 48 c7 c7 e0 f3 1f 8c e8 c7 69 a8 fc 90 <0f> 0b 90 90 e9 76 ff ff ff e8 a8 4f e6 fc c6 05 64 8d e8 0a 01 90
> RSP: 0018:ffffc900034cfcf0 EFLAGS: 00010246
> RAX: 3b9fcde1c862f700 RBX: ffff888022918b80 RCX: ffff88807b39bc00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000003 R08: ffffffff815878a2 R09: fffffbfff1c39d94
> R10: dffffc0000000000 R11: fffffbfff1c39d94 R12: 00000000ffffffe9
> R13: 1ffff11004523165 R14: ffff888022918b28 R15: ffff888022918b00
> FS:  00005555870e7380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000140 CR3: 000000007582e000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   inet_create+0xbaf/0xe70
>    __sock_create+0x490/0x920 net/socket.c:1571
>    sock_create net/socket.c:1622 [inline]
>    __sys_socketpair+0x2ca/0x720 net/socket.c:1769
>    __do_sys_socketpair net/socket.c:1822 [inline]
>    __se_sys_socketpair net/socket.c:1819 [inline]
>    __x64_sys_socketpair+0x9b/0xb0 net/socket.c:1819
>    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>    do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fbcb9259669
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fffe931c6d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000035
> RAX: ffffffffffffffda RBX: 00007fffe931c6f0 RCX: 00007fbcb9259669
> RDX: 0000000000000100 RSI: 0000000000000001 RDI: 0000000000000002
> RBP: 0000000000000002 R08: 00007fffe931c476 R09: 00000000000000a0
> R10: 0000000020000140 R11: 0000000000000246 R12: 00007fffe931c6ec
> R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
>   </TASK>

Oops, that's my bad, I forgot the differences in failure handling 
between smc_create and inet_create,
thanks for your fix.

>
> Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: D. Wythe <alibuda@linux.alibaba.com>
> Cc: Wenjia Zhang <wenjia@linux.ibm.com>
> Cc: Dust Li <dust.li@linux.alibaba.com>
> Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>   net/smc/af_smc.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 73a875573e7ad5b7a95f7941e33f0d784a91d16d..31b5d8c8c34085b73b011c913cfe032f025cd2e0 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -3319,10 +3319,8 @@ int smc_create_clcsk(struct net *net, struct sock *sk, int family)
>   
>   	rc = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
>   			      &smc->clcsock);
> -	if (rc) {
> -		sk_common_release(sk);
> +	if (rc)
>   		return rc;
> -	}

Since __smc_create (for AF_SMC) does not call sk_common_release on failure,
I think it should be moved to __smc_create instead of beingdeleted.

Best wishes,
D. Wythe

>   
>   	/* smc_clcsock_release() does not wait smc->clcsock->sk's
>   	 * destruction;  its sk_state might not be TCP_CLOSE after


