Return-Path: <netdev+bounces-249321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77825D169B7
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 05:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAA07301A1AE
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 04:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC7931691A;
	Tue, 13 Jan 2026 04:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGnrLNZH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5CD25487C
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 04:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768278930; cv=none; b=P4Vq7WbRzT5Po5boRtf3ObgUHxBU+4eVue0MLfce4x5P/o5PWNwv2+BpfLhVbo8slGsYFVhlZU/RmwYNORZn4rT3RSn/Jyot1qev3BSGkRGP4LFlH7W+7LJndvMC9pFZSPLFvEhbJIBOI6Au8XCxuDBmOFVBAEi+tlws/In8y4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768278930; c=relaxed/simple;
	bh=NyIaGGIXcD02jgK1ukMlnMbOpN7KsgB0IO/uDfLUn3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ki8J+F8ftphdhfdQpthq59yTgJJnWA5PrR4k7bqUtEwHPWjnPX/xo4U4KOjP0KhxAg3NLevU1OJfJvVepiTcuzd3kb39ldNyUnoDMmOV7XB9V0SAk1qNnJ+I4Tr6eDCL3CJIuIB2K8sFdYobBoPJ9AM+Ze2b71LnToN/ZzsIAgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGnrLNZH; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0fe77d141so52336005ad.1
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 20:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768278928; x=1768883728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DHyq7e6pqFHNUcho3prU1mBGvkPk3WGxGJdW7dfHIHU=;
        b=hGnrLNZHUPn2svQkstLHB7UfvBCsR/7+1+axW3rixnCMNWWiH1MExebJpu0AjB+tlM
         JthxYpqFReZEGidJL7Rj2lidYHw08NqW0LMF39My9J+yFqCafB1XUUy5U8+7ozunPDO/
         fVGdnJARSzXklBHOkkb4AJYMLIRc3A9CJWRfbYw4Erd5zfSc1XOxKT5zXhJc2PWMoRjo
         Fxgr9MJsed9Ibzom6ZwYPxJ/yTbfNnRgT32nUeWHNGzL0i91/0eJcUrUC4NLze3ZzLPJ
         BMJMbzoxiz+SshZFAUZSiEebkl8p1AVR/iW7aWJYHj+QNMj5e3VXkk/+iFWzqJuOOI2T
         XD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768278928; x=1768883728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHyq7e6pqFHNUcho3prU1mBGvkPk3WGxGJdW7dfHIHU=;
        b=UguoHkxHXP1ZtB9fNjN8jG3/rEaObYcGfeClXMt6Vi/XwXJuh+dNlm0sm8jVTZUBvk
         bh3FJiCiJvcLrmHIOVvwjRuy/11kM4kWIeyG7US07Yz8S4oGuOlWchzLXGNykMSYKH5V
         wTuYWd0/GMWJfhi/iN6o5Cuz2PhjcU/S9G9sxy9vuE+zg0pNEx90EnwDOSvJ5fAe7ZBN
         h9OA6FkBHFZqX8WTNUo3UAkoYFaJof9WydtrjccdhyibQkQJKxs8nL7k1vPRlTtX0OoD
         WG5w4QX2gZQ3boqfIhVibBbdGKpcsf8sw1JJgwPQ5pRgJ2olqu4GcnNWL0h0FqcNHKYi
         0X/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtbfxVuBJScOTAVdi0vDUricPYqN9IG5AtLSrebE5WSztG07OA/PkI/t2ivJ9E/GGxnozFda4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6SHHff6YP6eRa3cXVMfwE1TueTXXfFmey8MsTZzNRR+1hpMlI
	+0PKP80gSIAMuHrnYCM0M0AXUbUjJvFa+2Wbxc6fWhvwxNGwOD1KfYBSPSAjBV1h
X-Gm-Gg: AY/fxX5B80bfR/X5kj+XRRfB3vCJZGiPRMeJon0aABT8yUkswyDLsCQWFgwi/UDnb27
	jZDGv9SNT4tqF7IMoDFyT+uzsJw2pOLIpBiDyqJN4pc2mKJTJ5qFkeTk5Xv2rxfkzT9v02uyRdw
	0HfcPSojB4HHAXC/91k6GflCgDpD6GtOxaqByktvGSp2/xy/4nNcWsIhOJ29m0xVN26d2dZiDVw
	ijHMfWyFI6DBmBKES1KX5Aaggdqd642Zx86J/kv7QrxegdUw6gLyFnRQeTPtgFcyrgs6XtLQ4D3
	wFu9FxQJiPkqtQy+A2ifEiQzvcf/LYaGJrU2K7+yyl7oZ/LzyTPMs4VhONrtIpjFD9fAH/Ne1EK
	AXah2LmHNG1/7JY1AeAwpHdfZ82aZcKHloXHWX6oK/IyIaMPaZIjPR7Ie6WpToeTJxRgPah5KtL
	lIG/BYkGO6tNhlALc=
X-Google-Smtp-Source: AGHT+IFsmHb2+B7JlJBn2Qik6dzyV1ArNmfrR6vxr8cP0kRse8duktCeAEm0t7R2VQeYS4kiGD4zOg==
X-Received: by 2002:a17:902:cecd:b0:29f:e787:2b9b with SMTP id d9443c01a7336-2a3ee4da376mr185470275ad.41.1768278928046;
        Mon, 12 Jan 2026 20:35:28 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c491e7sm189619405ad.38.2026.01.12.20.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 20:35:27 -0800 (PST)
Date: Tue, 13 Jan 2026 04:35:19 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	syzbot+72e610f4f1a930ca9d8a@syzkaller.appspotmail.com
Subject: Re: [PATCH v1 net] ipv6: Fix use-after-free in inet6_addr_del().
Message-ID: <aWXLh-7LIeMAlAog@fedora>
References: <20260113010538.2019411-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113010538.2019411-1-kuniyu@google.com>

On Tue, Jan 13, 2026 at 01:05:08AM +0000, Kuniyuki Iwashima wrote:
> syzbot reported use-after-free of inet6_ifaddr in
> inet6_addr_del(). [0]
> 
> The cited commit accidentally moved ipv6_del_addr() for
> mngtmpaddr before reading its ifp->flags for temporary
> addresses in inet6_addr_del().
> 
> Let's move ipv6_del_addr() down to fix the UAF.
> 
> [0]:
> BUG: KASAN: slab-use-after-free in inet6_addr_del.constprop.0+0x67a/0x6b0 net/ipv6/addrconf.c:3117
> Read of size 4 at addr ffff88807b89c86c by task syz.3.1618/9593
> 
> CPU: 0 UID: 0 PID: 9593 Comm: syz.3.1618 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0xcd/0x630 mm/kasan/report.c:482
>  kasan_report+0xe0/0x110 mm/kasan/report.c:595
>  inet6_addr_del.constprop.0+0x67a/0x6b0 net/ipv6/addrconf.c:3117
>  addrconf_del_ifaddr+0x11e/0x190 net/ipv6/addrconf.c:3181
>  inet6_ioctl+0x1e5/0x2b0 net/ipv6/af_inet6.c:582
>  sock_do_ioctl+0x118/0x280 net/socket.c:1254
>  sock_ioctl+0x227/0x6b0 net/socket.c:1375
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:597 [inline]
>  __se_sys_ioctl fs/ioctl.c:583 [inline]
>  __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f164cf8f749
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f164de64038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f164d1e5fa0 RCX: 00007f164cf8f749
> RDX: 0000200000000000 RSI: 0000000000008936 RDI: 0000000000000003
> RBP: 00007f164d013f91 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f164d1e6038 R14: 00007f164d1e5fa0 R15: 00007ffde15c8288
>  </TASK>
> 
> Allocated by task 9593:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:77
>  poison_kmalloc_redzone mm/kasan/common.c:397 [inline]
>  __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:414
>  kmalloc_noprof include/linux/slab.h:957 [inline]
>  kzalloc_noprof include/linux/slab.h:1094 [inline]
>  ipv6_add_addr+0x4e3/0x2010 net/ipv6/addrconf.c:1120
>  inet6_addr_add+0x256/0x9b0 net/ipv6/addrconf.c:3050
>  addrconf_add_ifaddr+0x1fc/0x450 net/ipv6/addrconf.c:3160
>  inet6_ioctl+0x103/0x2b0 net/ipv6/af_inet6.c:580
>  sock_do_ioctl+0x118/0x280 net/socket.c:1254
>  sock_ioctl+0x227/0x6b0 net/socket.c:1375
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:597 [inline]
>  __se_sys_ioctl fs/ioctl.c:583 [inline]
>  __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Freed by task 6099:
>  kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
>  kasan_save_track+0x14/0x30 mm/kasan/common.c:77
>  kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:584
>  poison_slab_object mm/kasan/common.c:252 [inline]
>  __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:284
>  kasan_slab_free include/linux/kasan.h:234 [inline]
>  slab_free_hook mm/slub.c:2540 [inline]
>  slab_free_freelist_hook mm/slub.c:2569 [inline]
>  slab_free_bulk mm/slub.c:6696 [inline]
>  kmem_cache_free_bulk mm/slub.c:7383 [inline]
>  kmem_cache_free_bulk+0x2bf/0x680 mm/slub.c:7362
>  kfree_bulk include/linux/slab.h:830 [inline]
>  kvfree_rcu_bulk+0x1b7/0x1e0 mm/slab_common.c:1523
>  kvfree_rcu_drain_ready mm/slab_common.c:1728 [inline]
>  kfree_rcu_monitor+0x1d0/0x2f0 mm/slab_common.c:1801
>  process_one_work+0x9ba/0x1b20 kernel/workqueue.c:3257
>  process_scheduled_works kernel/workqueue.c:3340 [inline]
>  worker_thread+0x6c8/0xf10 kernel/workqueue.c:3421
>  kthread+0x3c5/0x780 kernel/kthread.c:463
>  ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
> 
> Fixes: 00b5b7aab9e42 ("net/ipv6: delete temporary address if mngtmpaddr is removed or unmanaged")
> Reported-by: syzbot+72e610f4f1a930ca9d8a@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/696598e9.050a0220.3be5c5.0009.GAE@google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/ipv6/addrconf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index b66217d1b2f82..27ab9d7adc649 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -3112,12 +3112,12 @@ static int inet6_addr_del(struct net *net, int ifindex, u32 ifa_flags,
>  			in6_ifa_hold(ifp);
>  			read_unlock_bh(&idev->lock);
>  
> -			ipv6_del_addr(ifp);
> -
>  			if (!(ifp->flags & IFA_F_TEMPORARY) &&
>  			    (ifp->flags & IFA_F_MANAGETEMPADDR))
>  				delete_tempaddrs(idev, ifp);
>  
> +			ipv6_del_addr(ifp);
> +
>  			addrconf_verify_rtnl(net);
>  			if (ipv6_addr_is_multicast(pfx)) {
>  				ipv6_mc_config(net->ipv6.mc_autojoin_sk,
> -- 
> 2.52.0.457.g6b5491de43-goog
> 

Hmm, I'm unable to recall why I moved delete_tempaddrs() after
ipv6_del_addr(). But your patch make sense to me. Checking the ifp flags
before ipv6_del_addr(ifp) is safer.

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

