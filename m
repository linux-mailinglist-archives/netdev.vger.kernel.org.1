Return-Path: <netdev+bounces-194252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12937AC809A
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 17:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAADD1BA3369
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 16:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79BF22D785;
	Thu, 29 May 2025 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzMr95gQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D0922D4F3;
	Thu, 29 May 2025 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748534387; cv=none; b=L93Z5qF/evsZlXHhXZFFBwnpbzgG1FikkCObAfARTMaDh+d1Cf5osqpQVBvLilbaUrz4vjQobT0IH65I3DaYgHyD2XfhmJwNT902Jcqu9qmSHltf8IHfHRsT6VPbvl0Nm7+dzFvfHZ695ezpLG6VDeTu2bfFmaWzR+/lmWdf6aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748534387; c=relaxed/simple;
	bh=Pl3LGmkCwfg7gTCA3AsSP2awNVEV2AzkZ84mXZuXslY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuoE3ymuYVky6qFpOymy66N4ML7FdaNpRUY4huD+JLVe83fStaM9Ha6oOZgJYZ9LMd92KWhsmsPNlJXMAAA+VxrdXgqRZ90qmUiVazZcax20WtRd14U5yIwhEmduzu/2T7bMQeufe4nXJ8D+Wdi/JUAEm3iWsQCiGTS76vA3Y6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzMr95gQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2351227b098so4965825ad.2;
        Thu, 29 May 2025 08:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748534385; x=1749139185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9d3/XMHaJT7MXZLQQikwQ6fSkoA+ShCfpN8VkDVAL0w=;
        b=YzMr95gQsrpVXhqTEQd7CItHmygaDZ+ltsx+i9m0x2UY+fvhZU2RQvaC65OkS/ELEG
         ilWN4MwxQkmJsFdzah9PK+k9qeZaoB4urjpQMnZPUIs1i4bvWbfxy2j0AxGjX3CtwLkT
         LZV3A9GtsEfUe+32cvT5LaCcb6UIvAWvSwKBhZLyvSEurcB6rtHeMUM8zXBsIcT014YL
         Q8k435UPWOl8gOGgHmX66+Qyli7FzO5om/rxQYFGn8U3RoRMIfq3G00uWpFEhzhU7crU
         +iXxlV3CEl8uo74ldB1iH1TDIsEpjEJl9T17LACqTJ2HzF/ci5Sds0ZdIP/D+Ie2+Opr
         ZLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748534385; x=1749139185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9d3/XMHaJT7MXZLQQikwQ6fSkoA+ShCfpN8VkDVAL0w=;
        b=sxUVSoezW8wxEUXY1HBgYcIHpTPFWwYInwKTY3n0KzMFchjd8ZSQBd3muNRZzuqmSY
         u0he0fzrw9fdqRbG0hSUQIYvxDe/+OYocC8aI4m/yy6K8+gOkm6DjgOTf7kem9S0Wcc2
         gXrIqgraP8vIxvelN/Pr8NT4jN0yXUC/4RiVMBHlc9m1nO68OMsU++UUOD87lkDYf29x
         wBPybnOuwAHzZ6s5qielqNs43UgFBK5+rCmPbF/BbJWuE5/7EEFxUXlSfRjSsxUpIEYw
         ScGq9uMcQmfrYHMbC4MNLWB1p1QlD9sx6+lfSh1EOZ2qre2QV3jLEDzzOGUmJeVPJZbz
         UkuA==
X-Forwarded-Encrypted: i=1; AJvYcCWpPWRtwRoMfn7lnx4crRKrnxU72dpW2WQ0prI59fboT97H9HwNAe4pCHoA4FrlF+tJctIF9DNV@vger.kernel.org, AJvYcCX3hRkTLM2pERwLy5stWgZs1Anu0alMvvigLo6sE2kzn2U0Iv6ShzD4lnpMq8YYKcKiSZ0ZJL/iXqA/Oco=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFV15je0kcQ5+mXDjQtGll/2bsKVHc2DWW53qVOmIYBWsYbxGF
	W4pSyMSRSDhZy8ZOuweb5Adp39zdKQo1n2BL027C1hK+hj1I7B3kuBE=
X-Gm-Gg: ASbGnctD2xk1JDSav2osw1RoOcBoj5E99dcjjlgRAyJFbY0GlbwsyrqlqNaZcP1U/zH
	Db5mU/5RiPcDTBbjcAxylyf8tdWqT6pcunSZatcexzNt9eVyjMReZayHwNmZzVXvUwUZwTw3WJ7
	robXpuZR37sdzDq9iMr+OV3ppPkC2u7qfOyqtZlZZg6B+31tKFNqDSKIMygWXIjCPcoO7NZ3qf7
	qUOMr3apjE124u0yuXCkUqV9NzhH2ebR5sH3iYfrLkiYxdJgqbEIbnrYRKCA8SFuaVCIZ7qcdvN
	6Voack+InbFxf2MiEF0fi2PwlNw/OQMnHN7t8OMY8Zq0+xXkiPz2NMhWv+WS0FaLcFega3Ki3Np
	o+SsjNmIDvl8P
X-Google-Smtp-Source: AGHT+IFtrrtjmX3YsvPidGU5eGxbbMDyGkFE11Jn24qLyQPKtG85oSGxOh3adg0lM0/UlxS40ougiw==
X-Received: by 2002:a17:903:2283:b0:234:f4da:7ecf with SMTP id d9443c01a7336-235289d4a9bmr1792705ad.8.1748534385071;
        Thu, 29 May 2025 08:59:45 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23506cdb9b3sm13959895ad.140.2025.05.29.08.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 08:59:44 -0700 (PDT)
Date: Thu, 29 May 2025 08:59:43 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: syzbot <syzbot+846bb38dc67fe62cc733@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in rtnl_newlink
Message-ID: <aDiEby8WRjJ9Gyfx@mini-arch>
References: <683837bf.a00a0220.52848.0003.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <683837bf.a00a0220.52848.0003.GAE@google.com>

On 05/29, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    b1427432d3b6 Merge tag 'iommu-fixes-v6.15-rc7' of git://gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=161ef5f4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9fd1c9848687d742
> dashboard link: https://syzkaller.appspot.com/bug?extid=846bb38dc67fe62cc733
> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d21170580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d9a8e8580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-b1427432.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/47b0c66c70d9/vmlinux-b1427432.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a2df6bfabd3c/bzImage-b1427432.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+846bb38dc67fe62cc733@syzkaller.appspotmail.com
> 
> ifb0: entered allmulticast mode
> ifb1: entered allmulticast mode
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.15.0-rc7-syzkaller-00144-gb1427432d3b6 #0 Not tainted
> ------------------------------------------------------
> syz-executor216/5313 is trying to acquire lock:
> ffff888033f496f0 ((work_completion)(&adapter->reset_task)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
> ffff888033f496f0 ((work_completion)(&adapter->reset_task)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
> ffff888033f496f0 ((work_completion)(&adapter->reset_task)){+.+.}-{0:0}, at: start_flush_work kernel/workqueue.c:4150 [inline]
> ffff888033f496f0 ((work_completion)(&adapter->reset_task)){+.+.}-{0:0}, at: __flush_work+0xd2/0xbc0 kernel/workqueue.c:4208
> 
> but task is already holding lock:
> ffffffff8f2fab48 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
> ffffffff8f2fab48 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
> ffffffff8f2fab48 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x8db/0x1c70 net/core/rtnetlink.c:4064
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (rtnl_mutex){+.+.}-{4:4}:
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
>        __mutex_lock_common kernel/locking/mutex.c:601 [inline]
>        __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:746
>        e1000_reset_task+0x56/0xc0 drivers/net/ethernet/intel/e1000/e1000_main.c:3512
>        process_one_work kernel/workqueue.c:3238 [inline]
>        process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
>        worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
>        kthread+0x70e/0x8a0 kernel/kthread.c:464
>        ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> -> #0 ((work_completion)(&adapter->reset_task)){+.+.}-{0:0}:
>        check_prev_add kernel/locking/lockdep.c:3166 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3285 [inline]
>        validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3909
>        __lock_acquire+0xaac/0xd20 kernel/locking/lockdep.c:5235
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
>        touch_work_lockdep_map kernel/workqueue.c:3922 [inline]
>        start_flush_work kernel/workqueue.c:4176 [inline]
>        __flush_work+0x6b8/0xbc0 kernel/workqueue.c:4208
>        __cancel_work_sync+0xbe/0x110 kernel/workqueue.c:4364
>        e1000_down+0x402/0x6b0 drivers/net/ethernet/intel/e1000/e1000_main.c:526
>        e1000_close+0x17b/0xa10 drivers/net/ethernet/intel/e1000/e1000_main.c:1448
>        __dev_close_many+0x361/0x6f0 net/core/dev.c:1702
>        __dev_close net/core/dev.c:1714 [inline]
>        __dev_change_flags+0x2c7/0x6d0 net/core/dev.c:9352
>        netif_change_flags+0x88/0x1a0 net/core/dev.c:9417
>        do_setlink+0xcb9/0x40d0 net/core/rtnetlink.c:3152
>        rtnl_group_changelink net/core/rtnetlink.c:3783 [inline]
>        __rtnl_newlink net/core/rtnetlink.c:3937 [inline]
>        rtnl_newlink+0x149f/0x1c70 net/core/rtnetlink.c:4065
>        rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6955
>        netlink_rcv_skb+0x219/0x490 net/netlink/af_netlink.c:2534
>        netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>        netlink_unicast+0x75b/0x8d0 net/netlink/af_netlink.c:1339
>        netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
>        sock_sendmsg_nosec net/socket.c:712 [inline]
>        __sock_sendmsg+0x21c/0x270 net/socket.c:727
>        ____sys_sendmsg+0x505/0x830 net/socket.c:2566
>        ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
>        __sys_sendmsg net/socket.c:2652 [inline]
>        __do_sys_sendmsg net/socket.c:2657 [inline]
>        __se_sys_sendmsg net/socket.c:2655 [inline]
>        __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> other info that might help us debug this:
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(rtnl_mutex);
>                                lock((work_completion)(&adapter->reset_task));
>                                lock(rtnl_mutex);
>   lock((work_completion)(&adapter->reset_task));

So this is internal WQ entry lock that is being reordered with rtnl
lock. But looking at process_one_work, I don't see actual locks, mostly
lock_map_acquire/lock_map_release calls to enforce some internal WQ
invariants. Not sure what to do with it, will try to read more.

