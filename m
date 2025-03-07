Return-Path: <netdev+bounces-173087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BDFA57203
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 20:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7142E1899295
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 19:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034D525523E;
	Fri,  7 Mar 2025 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akX+qPgd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5D824FC1F
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376211; cv=none; b=Jtaw7TNx5gLEMAuavJe3f2U/Rg5AWl8qWOqug76+lBqE4cvtVoy6a6N8tO/SgwTL3lla8/aCqMPjqHhEzXM+cZOWRaaSfq7w65HwzfyXFYrLOZZW+opfR8lkz0NLj5B5JRVSkp+JA2z3aMJpfCeOe3JElsaFKLqopKVa6f9v7DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376211; c=relaxed/simple;
	bh=8XYJDgBfuGIZm6SC6ixqjFafN6PLrOwqg5nKHsVwVsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9rEziZw7XvmUeCyX6+vAUR/kFL3ltxG9LkdUu73MHpY8VcBE25KLgTK9T3mmQlRcL9h2neWqVRJ2LsvqIqOy1SXQYQZ0rc1+5mAB7T+2+5MceYw7QJWMI4x4wnRzufN2IIEK7tWDTNnhIAKXruTntUko8Po3VLsdTvlNVZB254=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akX+qPgd; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22359001f1aso57119965ad.3
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 11:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741376209; x=1741981009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mTqCLIfPJqZsp83XSs7Fx7CaLZxaNIByW5TVWQ9J1UE=;
        b=akX+qPgdJJO/Xdl3CuhCJeqSV11dzz8jnYZLT6eDlk4sXvj4terTCJ64PU7+r4kNV5
         a1hl95/HEGh8o4D9gEum00eTKrzoyD0jFlZqY582WCAnMhI183ySndHa+4/c4mFc7Jgq
         BUvVGE7Av7Ia3PK81dl+jVksezxQeVzPNoJA7dKChyjTF9dbUpI6vschS/cvsyZcQa35
         9R84QAzJpCABIKCEkKS6QOCjNX3W7lVJIIMBXSyCAL7aEaN0eS95mrk/7FSaoT2X0azr
         AA54b8m9qvLLNft94/sS1oOxJuhfUOsXiNbqfvlVV2c8wU8l4DDaJu36Ae8E5COiXPCX
         1iAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741376209; x=1741981009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTqCLIfPJqZsp83XSs7Fx7CaLZxaNIByW5TVWQ9J1UE=;
        b=Kpns5n3r1MuCKHvE5TQ7Y7mrotLD7uQz8yPR9zy6eeGIFnPm941EYf6P2xLZZe+6kc
         rrs4/fa+SoTu5X+g0R0Fl/OuxEGKaYmKHtTKCYWnwQLqn+ZRZq4e778n7crxMqewTYT/
         ouUdg1JMqBAT+/gqjk85n+eX04MzD84d2fI166m5KfXcWF5aa+FQdeTH4XSoD56xRv7U
         3coZ2BfNNgGw0P/hW4uVx360qkh6yZXqO0vUaw9+Gw0FBtkrXk4mKfpfj68ukVpFzYnu
         EVthFZgyWN2yISVmQzNuVSjpwRgQUrNxYD7ChTn8kbE++sjEpamwod5L/oOhMQGpFB4t
         6Mww==
X-Forwarded-Encrypted: i=1; AJvYcCVSUapq9/wCfl+PTGt0rr3C32pnvyj2FIxTbGdjWLJFSh7I5NFZnQwIc5rJ9Gm6jbkNU2AyDbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkIoba43PwzDzHcH7zsNLnedHT3lBqd0bqvFGYpT9U07Q+iDLf
	mK7sNSkWLJhs5rziz1Bz586RkQW5sPLBuaxCgyj8VEtiv5bZvT8=
X-Gm-Gg: ASbGncucdvqNCmookCK4heJjaVuu/9b4LyvuY+arj6uIZs4hCDtYkgq684K1w+qTX+8
	6UY+sB7k6YsU+5bhQshZr1XqENqrkvT3Akgl/LFXTSvQL6jUOgKoI0tMhCxiothea86FRw7cHzd
	pM09E/nsRXf8csznLlaOq5d09QxQT9sfTFZGxV/r/9gojTMteNHi9C9q9HObA1iApj4XGs1+FG2
	7E10d65FeDX0HddrpT0IBQBM1Ev+hCm13lanYXPkYSe7hVFgMnbSRuuHFWbbBkGQuik7CtjJwYH
	cMrBbF8js3iSVnFKdenh4Kd5tZI1ciPFTfwnGFTVHBRn
X-Google-Smtp-Source: AGHT+IHaU9x07ljy9aiZJ71t3wNbve3qCn9zxFZ3a5xjiMvXAU53xkYI8XWqfl5inmitKKgZt83MPQ==
X-Received: by 2002:a17:903:2f8a:b0:220:d078:eb33 with SMTP id d9443c01a7336-22428ab698dmr69874945ad.36.1741376209585;
        Fri, 07 Mar 2025 11:36:49 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22410a91db3sm33970575ad.170.2025.03.07.11.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 11:36:49 -0800 (PST)
Date: Fri, 7 Mar 2025 11:36:48 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH net-next] hamradio: use netdev_lockdep_set_classes()
 helper
Message-ID: <Z8tK0GARvTnW3sdd@mini-arch>
References: <20250307160358.3153859-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250307160358.3153859-1-edumazet@google.com>

On 03/07, Eric Dumazet wrote:
> It is time to use netdev_lockdep_set_classes() in bpqether.c
> 
> List of related commits:
> 
> 0bef512012b1 ("net: add netdev_lockdep_set_classes() to virtual drivers")
> c74e1039912e ("net: bridge: use netdev_lockdep_set_classes()")
> 9a3c93af5491 ("vlan: use netdev_lockdep_set_classes()")
> 0d7dd798fd89 ("net: ipvlan: call netdev_lockdep_set_classes()")
> 24ffd752007f ("net: macvlan: call netdev_lockdep_set_classes()")
> 78e7a2ae8727 ("net: vrf: call netdev_lockdep_set_classes()")
> d3fff6c443fe ("net: add netdev_lockdep_set_classes() helper")
> 
> syzbot reported:
> 
> WARNING: possible recursive locking detected
> 6.14.0-rc5-syzkaller-01064-g2525e16a2bae #0 Not tainted
> 
> dhcpcd/5501 is trying to acquire lock:
>  ffff8880797e2d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2765 [inline]
>  ffff8880797e2d28 (&dev->lock){+.+.}-{4:4}, at: register_netdevice+0x12d8/0x1b70 net/core/dev.c:11008
> 
> but task is already holding lock:
>  ffff88802e530d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2765 [inline]
>  ffff88802e530d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops include/linux/netdevice.h:2804 [inline]
>  ffff88802e530d28 (&dev->lock){+.+.}-{4:4}, at: dev_change_flags+0x120/0x270 net/core/dev_api.c:65
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&dev->lock);
>   lock(&dev->lock);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation
> 
> 2 locks held by dhcpcd/5501:
>   #0: ffffffff8fed6848 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
>   #0: ffffffff8fed6848 (rtnl_mutex){+.+.}-{4:4}, at: devinet_ioctl+0x34c/0x1d80 net/ipv4/devinet.c:1121
>   #1: ffff88802e530d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2765 [inline]
>   #1: ffff88802e530d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops include/linux/netdevice.h:2804 [inline]
>   #1: ffff88802e530d28 (&dev->lock){+.+.}-{4:4}, at: dev_change_flags+0x120/0x270 net/core/dev_api.c:65
> 
> stack backtrace:
> CPU: 1 UID: 0 PID: 5501 Comm: dhcpcd Not tainted 6.14.0-rc5-syzkaller-01064-g2525e16a2bae #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
> Call Trace:
>  <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>   print_deadlock_bug+0x483/0x620 kernel/locking/lockdep.c:3039
>   check_deadlock kernel/locking/lockdep.c:3091 [inline]
>   validate_chain+0x15e2/0x5920 kernel/locking/lockdep.c:3893
>   __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5228
>   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
>   __mutex_lock_common kernel/locking/mutex.c:585 [inline]
>   __mutex_lock+0x19c/0x1010 kernel/locking/mutex.c:730
>   netdev_lock include/linux/netdevice.h:2765 [inline]
>   register_netdevice+0x12d8/0x1b70 net/core/dev.c:11008
>   bpq_new_device drivers/net/hamradio/bpqether.c:499 [inline]
>   bpq_device_event+0x4b1/0x8d0 drivers/net/hamradio/bpqether.c:542
>   notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
>  __dev_notify_flags+0x207/0x400
>   netif_change_flags+0xf0/0x1a0 net/core/dev.c:9442
>   dev_change_flags+0x146/0x270 net/core/dev_api.c:66
>   devinet_ioctl+0xea2/0x1d80 net/ipv4/devinet.c:1200
>   inet_ioctl+0x3d7/0x4f0 net/ipv4/af_inet.c:1001
>   sock_do_ioctl+0x158/0x460 net/socket.c:1190
>   sock_ioctl+0x626/0x8e0 net/socket.c:1309
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:906 [inline]
>   __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Fixes: 7e4d784f5810 ("net: hold netdev instance lock during rtnetlink operations")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

