Return-Path: <netdev+bounces-128211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 266A6978821
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 20:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD9E1F23984
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 18:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9FE12C46D;
	Fri, 13 Sep 2024 18:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XD7QUY80"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D818172A
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726253281; cv=none; b=EIpjgwS1SJjvZGCZfSIoSLrtazFkK68iNHoJ39390Wlw/CXnEkJtnafjCXfYw8dhzxnkCWcpB5Tm6imU3NOruP6XwQym0fos99FJjhyiT1IrjXdIB2v+HvRo5BZmDgIUOsLWZlG+Ygqv74HCRxk+ECM5dUMN6NuFbFVlF/1TE8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726253281; c=relaxed/simple;
	bh=s7ndScSrjr0hOWpmQOityGRkXjX69thSQe63mpk5b3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bvwDdxqvJpu9J92eqJN27/ogkNmaGmakCKoRZp64hngm18pO4La3sPM7K4G9q2TZhqcGatNuJyYCjjZfu0jbgWdZSP3YUmnSc+KUc53SMr5V4CVwB4IERjkwo1xTt/ORtV/tp2cSqkJUMe99lyi1MJH4UXpApYugDsTQJ8lUoA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XD7QUY80; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f3132254-85cb-4572-b0cf-578e2d43db76@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726253277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QRTQ+ZaQ8+DT1PhzC6WM6iZQF0HtBfAEO3at1wXL+xQ=;
	b=XD7QUY8002qrPBOxD5oBSibcARqE0z9/+Ry8AOahbaeMg7sS1J9JQr2t0aJbpo2UL+0dY0
	fDure2UHKwqV0xDtT66QJh1ENdR/nm05qxP1VbUlyNq/BCg0VldMYLJXp0HIJ/UT19hpeX
	l04/KW62Tp71qfMtnq60u0H2MlxTf40=
Date: Fri, 13 Sep 2024 11:47:48 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] ipv6: avoid possible NULL deref in
 rt6_uncached_list_flush_dev()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, "Eric W. Biederman" <ebiederm@xmission.com>,
 Martin KaFai Lau <kafai@fb.com>
References: <20240913083147.3095442-1-edumazet@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240913083147.3095442-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/13/24 1:31 AM, Eric Dumazet wrote:
> Blamed commit accidentally removed a check for rt->rt6i_idev being NULL,
> as spotted by syzbot:
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 1 UID: 0 PID: 10998 Comm: syz-executor Not tainted 6.11.0-rc6-syzkaller-00208-g625403177711 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
>   RIP: 0010:rt6_uncached_list_flush_dev net/ipv6/route.c:177 [inline]
>   RIP: 0010:rt6_disable_ip+0x33e/0x7e0 net/ipv6/route.c:4914
> Code: 41 80 3c 04 00 74 0a e8 90 d0 9b f7 48 8b 7c 24 08 48 8b 07 48 89 44 24 10 4c 89 f0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 4c 89 f7 e8 64 d0 9b f7 48 8b 44 24 18 49 39 06
> RSP: 0018:ffffc900047374e0 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 1ffff1100fdf8f33 RCX: dffffc0000000000
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88807efc78c0
> RBP: ffffc900047375d0 R08: 0000000000000003 R09: fffff520008e6e8c
> R10: dffffc0000000000 R11: fffff520008e6e8c R12: 1ffff1100fdf8f18
> R13: ffff88807efc7998 R14: 0000000000000000 R15: ffff88807efc7930
> FS:  0000000000000000(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020002a80 CR3: 0000000022f62000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>    addrconf_ifdown+0x15d/0x1bd0 net/ipv6/addrconf.c:3856
>   addrconf_notify+0x3cb/0x1020
>    notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
>    call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
>    call_netdevice_notifiers net/core/dev.c:2046 [inline]
>    unregister_netdevice_many_notify+0xd81/0x1c40 net/core/dev.c:11352
>    unregister_netdevice_many net/core/dev.c:11414 [inline]
>    unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11289
>    unregister_netdevice include/linux/netdevice.h:3129 [inline]
>    __tun_detach+0x6b9/0x1600 drivers/net/tun.c:685
>    tun_detach drivers/net/tun.c:701 [inline]
>    tun_chr_close+0x108/0x1b0 drivers/net/tun.c:3510
>    __fput+0x24a/0x8a0 fs/file_table.c:422
>    task_work_run+0x24f/0x310 kernel/task_work.c:228
>    exit_task_work include/linux/task_work.h:40 [inline]
>    do_exit+0xa2f/0x27f0 kernel/exit.c:882
>    do_group_exit+0x207/0x2c0 kernel/exit.c:1031
>    __do_sys_exit_group kernel/exit.c:1042 [inline]
>    __se_sys_exit_group kernel/exit.c:1040 [inline]
>    __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1040
>    x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
>    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>    do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f1acc77def9
> Code: Unable to access opcode bytes at 0x7f1acc77decf.
> RSP: 002b:00007ffeb26fa738 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1acc77def9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000043
> RBP: 00007f1acc7dd508 R08: 00007ffeb26f84d7 R09: 0000000000000003
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 0000000000000003 R14: 00000000ffffffff R15: 00007ffeb26fa8e0
>   </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
>   RIP: 0010:rt6_uncached_list_flush_dev net/ipv6/route.c:177 [inline]
>   RIP: 0010:rt6_disable_ip+0x33e/0x7e0 net/ipv6/route.c:4914
> Code: 41 80 3c 04 00 74 0a e8 90 d0 9b f7 48 8b 7c 24 08 48 8b 07 48 89 44 24 10 4c 89 f0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 4c 89 f7 e8 64 d0 9b f7 48 8b 44 24 18 49 39 06
> RSP: 0018:ffffc900047374e0 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 1ffff1100fdf8f33 RCX: dffffc0000000000
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88807efc78c0
> RBP: ffffc900047375d0 R08: 0000000000000003 R09: fffff520008e6e8c
> R10: dffffc0000000000 R11: fffff520008e6e8c R12: 1ffff1100fdf8f18
> R13: ffff88807efc7998 R14: 0000000000000000 R15: ffff88807efc7930
> FS:  0000000000000000(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020002a80 CR3: 0000000022f62000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> Fixes: e332bc67cf5e ("ipv6: Don't call with rt6_uncached_list_flush_dev")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Martin KaFai Lau <kafai@fb.com>
> ---
>   net/ipv6/route.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 219701caba1e9496f4a7add7e97251ab111a67f0..b4dcd8f3e7babae45e0b40bd80f871be06757b82 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -174,7 +174,7 @@ static void rt6_uncached_list_flush_dev(struct net_device *dev)
>   			struct net_device *rt_dev = rt->dst.dev;
>   			bool handled = false;
>   
> -			if (rt_idev->dev == dev) {
> +			if (rt_idev && rt_idev->dev == dev) {

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


