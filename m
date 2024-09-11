Return-Path: <netdev+bounces-127271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75032974CD5
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 10:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01355B22DEA
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 08:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52FD155330;
	Wed, 11 Sep 2024 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIHMZPMH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2FA1552EE;
	Wed, 11 Sep 2024 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044003; cv=none; b=A7A3jFF1wWUR/RwwXDX4wSyweU/YLoIQltpu8p7+ZjdqAqlOaZ0zDqrRooS3Y5HB/rIs3TfInRZtHmkOiug1YoWrENmjnKZ5Qr+HeJwzAiPZCbJh9Oxx2WW7+nUdsWFno9n7aXXxBCDTbSipJ/HhQe4AecelQ13XlSycgrMzuKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044003; c=relaxed/simple;
	bh=pjO1Xtf6xnRkbXFbIjBTuXviXNMS0tKSzaObW+4ZC7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPO1m0vzNJdE8SBwGCgFAcLKthbZC3PIEE0iEBFFH8IuEij415yMgS0l99TGa+iK0kifcZ+J5MmyBoXzvdn/WzPL9sPo7CNVabb60RAxI9I2ZxJaxAXHqqL8poL4FCoo0Acb4V5ivfhL1RjwkDBBhS8HpsaDgWXO/HX+8e+Bv/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIHMZPMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5B5C4CEC5;
	Wed, 11 Sep 2024 08:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726044003;
	bh=pjO1Xtf6xnRkbXFbIjBTuXviXNMS0tKSzaObW+4ZC7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nIHMZPMHgLqvhkvMaUIDgL4SPTwrQl/xGvDNj7oZSiYr5bmStobHLtdTGzRUWcYDS
	 S7KbJ+otJ0Gs+Y+S17HxwGgUTnIuZRvqoCXQh9iuR1BDq9ZuIgya7IrI+P6bNxSX4j
	 zedzenrt2du+vvw7VK90tnuQiBjJcRkA0TGKCI7vVbdabgfbYAUnMpHZZK9TFbM6Lz
	 CLt42Ph9wSAHcoPsLQl+1V6ZkeE0ROQTGEZCFjQYg1VYbEdVdNJRUMMrczDkUkrtZ5
	 glUCXb8V7Nobzi3AY2bIv2K4oLWjjYXe84Awzf0luUBeQW3t0vvAl+tb8OOMTNs1cu
	 RiutmvM4IeHQg==
Date: Wed, 11 Sep 2024 09:39:58 +0100
From: Simon Horman <horms@kernel.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+c229849f5b6c82eba3c2@syzkaller.appspotmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: Re: [PATCH net] net: hsr: Fix null-ptr-deref in hsr_proxy_announce
Message-ID: <20240911083958.GC678243@kernel.org>
References: <0000000000000d402f0621c44c87@google.com>
 <tencent_CF67CC46D7D2DBC677898AEEFBAECD0CAB06@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_CF67CC46D7D2DBC677898AEEFBAECD0CAB06@qq.com>

+ Jeongjun Park, syzbot+c229849f5b6c82eba3c2

On Tue, Sep 10, 2024 at 10:50:40PM +0800, Edward Adam Davis wrote:
> The NULL pointer is interlink, return by hsr_port_get_hsr(), before using it,
> it is necessary to add a null pointer check.
> 
> [Syzbot reported]
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
> CPU: 0 UID: 0 PID: 11 Comm: kworker/u8:0 Not tainted 6.11.0-rc6-syzkaller-00180-g4c8002277167 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
> Workqueue: netns cleanup_net
> RIP: 0010:send_hsr_supervision_frame+0x37/0xa90 net/hsr/hsr_device.c:290
> Code: 53 48 83 ec 38 48 89 54 24 30 49 89 f7 49 89 fd 48 bb 00 00 00 00 00 fc ff df e8 54 a0 f9 f5 49 8d 6d 18 48 89 e8 48 c1 e8 03 <80> 3c 18 00 74 08 48 89 ef e8 7b e6 60 f6 48 8b 6d 00 4d 89 fc 49
> RSP: 0018:ffffc90000007a70 EFLAGS: 00010206
> RAX: 0000000000000003 RBX: dffffc0000000000 RCX: ffff88801ced3c00
> RDX: 0000000000000100 RSI: ffffc90000007b40 RDI: 0000000000000000
> RBP: 0000000000000018 R08: ffffffff8b995013 R09: 1ffffffff283c908
> R10: dffffc0000000000 R11: ffffffff8b99ec30 R12: ffff888065030e98
> R13: 0000000000000000 R14: ffff888065030cf0 R15: ffffc90000007b40
> FS:  0000000000000000(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f76c4f21cf8 CR3: 000000000e734000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <IRQ>
>  hsr_proxy_announce+0x23a/0x4c0 net/hsr/hsr_device.c:420
>  call_timer_fn+0x18e/0x650 kernel/time/timer.c:1792
>  expire_timers kernel/time/timer.c:1843 [inline]
>  __run_timers kernel/time/timer.c:2417 [inline]
>  __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2428
>  run_timer_base kernel/time/timer.c:2437 [inline]
>  run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2447
>  handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
>  __do_softirq kernel/softirq.c:588 [inline]
>  invoke_softirq kernel/softirq.c:428 [inline]
>  __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
>  irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
>  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
>  
> Fixes: 5f703ce5c98 ("net: hsr: Send supervisory frames to HSR network with ProxyNodeTable data")
> Reported-by: syzbot+c229849f5b6c82eba3c2@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

Hi Edward,

Thanks for your patch. I agree that it is correct.  But I also believe that
it duplicates a slightly earlier patch by Jeongjun Park.

- [PATCH net] net: hsr: prevent NULL pointer dereference in hsr_proxy_announce()
  https://lore.kernel.org/all/20240907190341.162289-1-aha310510@gmail.com/

Unfortunately we don't seem to have a "duplicate" state in patchwork,
so I'll go for "rejected".

It also seems that there are duplicate syzbot reports for this problem [1][2]
I will attempt to mark [2] as a duplicate of [1].

[1] https://syzkaller.appspot.com/bug?extid=02a42d9b1bd395cbcab4
[2] https://syzkaller.appspot.com/bug?extid=c229849f5b6c82eba3c2

-- 
pw-bot: rejected

