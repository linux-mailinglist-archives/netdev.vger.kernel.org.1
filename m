Return-Path: <netdev+bounces-191988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 056BAABE1C7
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 19:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5044F168682
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 17:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF37276054;
	Tue, 20 May 2025 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Txxa/qul"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E35262FD6;
	Tue, 20 May 2025 17:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747761878; cv=none; b=MHaynSDpQXEjdIp+qs35g1Vtdg6yqr5S2AWDvhL6W5kNFc7TGSQt5UqjOnYsOj6ON00sQ+Qt632Mao3CQdxiDiX103wsUXjrROO9aIOsfjuqtKRCeKK3JQWw9IduJ3mDc6G8feG1PeOFUaukqtxxShPpz4JBBCaOrT1FKog0koc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747761878; c=relaxed/simple;
	bh=ecV2C7emsg1JVt95ok/7ULVubbK+x38KHmRJuDCaqLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5RBT0EIEul/2zkZBjaQPv2X9NNpCdg00TcOLO/wxsMFIYcnj/q8u+qyQlxCNGYjZvkSFMYTlV7+9/qkXUWYXAjLJUfQyWpPM6U6gYf7r5grewZ6dR65T2hgRD/euvtpHENdPmIC6R7vyg/aJ6+NB5yM/vBiwklLywwU/WdtyTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Txxa/qul; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-af5085f7861so3863040a12.3;
        Tue, 20 May 2025 10:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747761875; x=1748366675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GE9HRSXPApt9+e1tILdakijmYBIHj607hnreU9KIWS4=;
        b=Txxa/qulJOYvhst5HX7nFcevrDp6RVK1k5wYVn1EM326JsPMzUujHHiWsH5NNLz2X8
         aFy9LlIsxa/34UD13Sh6OeigNy7lRmojZUTr1nMmDMRc+rr0j5BiggZDM8SkD5VZ5B4l
         m/IULYHq9DyvtpQnO+dB+XNyK1wATiTU8nbVYVAnJY4+GHZiKDmKHR26wPUovT4GaPX5
         7sC5CJ0TKJufMIaLdi+guKqghdxbvIJcqcZ3Od+kHwuhRzl1rou7OC/SPBI9e3SswYOB
         ciiWomstzAGxhAYDmGZUokjZSTZ53ACqSzX2Tlod3zzN87wOFvyOo5/wDaFU0kHYzu3m
         wUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747761875; x=1748366675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GE9HRSXPApt9+e1tILdakijmYBIHj607hnreU9KIWS4=;
        b=CZjmea7Ek/ukiMNbNqJQXHfqplFh2EnsSPCFfrikr1jIxNmRTU7n2PnARoWvWlCbCo
         erPbm4rKDnc4TBJFGvD5kyd0P/ae7+EFrWmCZ9dbl7+ovY22uZuIKBDpnZrdaadoFe+p
         rrSQRz1Izn1LeQkKDVBEOUoiGqo9NzM9qd56ZYfoQYjwTxMXyUGbO2lqEuSh9MUk+mqT
         7J/ku5ZfwHRYcEqjtodG5XTdYCqJX1Cca1dlGQAj6g7NhrKKOE/WJeE3SJmWKg7IOZvA
         ybXyxNPuZv5NdjLJuf6vxm0ZvLYqihglzpktUHBTpMyOMB/ThXvE7MgwWAbUGrrkCeLy
         WDSw==
X-Forwarded-Encrypted: i=1; AJvYcCUlvLdGHs34YPn4ysTHf1DySwb/0GL5Ff6d3X9W60MTIiKCtZN9L6YiJYNVJfhJgcVH1mVwpwf7CLDeU+0=@vger.kernel.org, AJvYcCVS5ccdJ9IPOlPY1TtCOdFhuh4thaOma8QeZtFdTLZ/K2QU6877r8+ypXWa/SzQ9OULTOR4ZL/H@vger.kernel.org
X-Gm-Message-State: AOJu0YzmnZNnL4lJfVfpzzH1nceepcO1gzA/NXvokUNdCkPHKCQm6ekx
	w+zAkBBu/A7g3uQCDWF2YsLdqQ57JW5qmCSb4np/Tj7TPny+n+pCYUs=
X-Gm-Gg: ASbGncuXKmMCDToVpBH7xkeNQ2UMxLF5VTIuHmsPKgyzkuBXqfyaJQIJwi8Sk98NpmG
	NjumaDauj2bmMwX+c1PA70Icn0/eCzK/Fbh5IEY712I0hZHE5QBcftibVChTPNLDXwcZAeCNQUQ
	jdBKwv9wtNzVZsmMTbQfr8+0j7CELx6FwSl5JR9m4qcNA7KMkzhmK5Ik2dP4DSydLJkwL0Y5wk0
	C16sQinojVHI6LZSM2p+us5vi67ZsnC48FVAu8IbkX1P0mKk+MHU9B1ZuYSMwdNUA8Wsf1PxldP
	T0FeFU64S3d/fkw8CclIyOw7FVZSvXCEb8UAYW5halBhQ2jwAuLQR45ORIWu/etj2rhcnamGZyj
	tUJ2MOMSDgxeS
X-Google-Smtp-Source: AGHT+IEpFPN+GqlWXz1vm5wJPRHhGwfD9Rzc9hBq4zNEJDKTQMbGjlsiCCWr9NyTmR80GU/+03TrhQ==
X-Received: by 2002:a17:902:f551:b0:223:4b8d:32f1 with SMTP id d9443c01a7336-231de2e70bcmr232007735ad.1.1747761875373;
        Tue, 20 May 2025 10:24:35 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30f365c4eb2sm1967850a91.15.2025.05.20.10.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 10:24:34 -0700 (PDT)
Date: Tue, 20 May 2025 10:24:33 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: syzbot <syzbot+b191b5ccad8d7a986286@syzkaller.appspotmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, jiri@resnulli.us, kuba@kernel.org,
	kuniyu@amazon.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] BUG: sleeping function called from invalid
 context in team_change_rx_flags
Message-ID: <aCy60X1I2XaRyo18@mini-arch>
References: <682c7f0d.a00a0220.29bc26.027d.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <682c7f0d.a00a0220.29bc26.027d.GAE@google.com>

On 05/20, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    239af1970bcb llc: fix data loss when reading from a socket..
> git tree:       net
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1485bf68580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c3f0e807ec5d1268
> dashboard link: https://syzkaller.appspot.com/bug?extid=b191b5ccad8d7a986286
> compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1285bf68580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f752d4580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/da0ff1b4efb0/disk-239af197.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/be3cf5250e1a/vmlinux-239af197.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/19abc9680c68/bzImage-239af197.xz
> 
> The issue was bisected to:
> 
> commit 6b1d3c5f675cc794a015138b115afff172fb4c58
> Author: Stanislav Fomichev <stfomichev@gmail.com>
> Date:   Wed May 14 22:03:19 2025 +0000
> 
>     team: grab team lock during team_change_rx_flags
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1148de70580000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1348de70580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1548de70580000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b191b5ccad8d7a986286@syzkaller.appspotmail.com
> Fixes: 6b1d3c5f675c ("team: grab team lock during team_change_rx_flags")
> 
> team0: entered promiscuous mode
> team_slave_0: entered promiscuous mode
> team_slave_1: entered promiscuous mode
> team0 (unregistering): left promiscuous mode
> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:578
> in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 5831, name: syz-executor316
> preempt_count: 0, expected: 0
> RCU nest depth: 1, expected: 0
> 2 locks held by syz-executor316/5831:
>  #0: ffffffff8f2f7408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
>  #0: ffffffff8f2f7408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
>  #0: ffffffff8f2f7408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_dellink+0x331/0x710 net/core/rtnetlink.c:3556
>  #1: ffffffff8df3dce0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
>  #1: ffffffff8df3dce0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
>  #1: ffffffff8df3dce0 (rcu_read_lock){....}-{1:3}, at: packet_notifier+0x78/0xa60 net/packet/af_packet.c:4240
> CPU: 0 UID: 0 PID: 5831 Comm: syz-executor316 Not tainted 6.15.0-rc6-syzkaller-00168-g239af1970bcb #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  __might_resched+0x495/0x610 kernel/sched/core.c:8818
>  __mutex_lock_common kernel/locking/mutex.c:578 [inline]
>  __mutex_lock+0x106/0xe80 kernel/locking/mutex.c:746
>  team_change_rx_flags+0x38/0x220 drivers/net/team/team_core.c:1781
>  dev_change_rx_flags net/core/dev.c:9145 [inline]
>  __dev_set_promiscuity+0x3f8/0x590 net/core/dev.c:9189
>  netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9201
>  dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:286
>  packet_dev_mc net/packet/af_packet.c:3698 [inline]
>  packet_dev_mclist_delete net/packet/af_packet.c:3722 [inline]
>  packet_notifier+0x292/0xa60 net/packet/af_packet.c:4247
>  notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
>  call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
>  call_netdevice_notifiers net/core/dev.c:2228 [inline]
>  unregister_netdevice_many_notify+0x15d8/0x2330 net/core/dev.c:11972
>  rtnl_delete_link net/core/rtnetlink.c:3522 [inline]
>  rtnl_dellink+0x488/0x710 net/core/rtnetlink.c:3564
>  rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6955
>  netlink_rcv_skb+0x219/0x490 net/netlink/af_netlink.c:2534
>  netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>  netlink_unicast+0x75b/0x8d0 net/netlink/af_netlink.c:1339
>  netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
>  sock_sendmsg_nosec net/socket.c:712 [inline]
>  __sock_sendmsg+0x219/0x270 net/socket.c:727
>  ____sys_sendmsg+0x505/0x830 net/socket.c:2566
>  ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
>  __sys_sendmsg net/socket.c:2652 [inline]
>  __do_sys_sendmsg net/socket.c:2657 [inline]
>  __se_sys_sendmsg net/socket.c:2655 [inline]
>  __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fa537a5c859
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff93fbcb88 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa537a5c859
> RDX: 0000000000000000 RSI: 00002000000001c0 RDI: 0000000000000004
> RBP: 00007fa537aaa47d R08: 0000555500000000 R09: 0000555500000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa537aaa3e5
> R13: 0000000000000001 R14: 00007fff93fbcbd0 R15: 0000000000000003
>  </TASK>
> 
> =============================
> [ BUG: Invalid wait context ]
> 6.15.0-rc6-syzkaller-00168-g239af1970bcb #0 Tainted: G        W          
> -----------------------------
> syz-executor316/5831 is trying to lock:
> ffff888076094e00 (team->team_lock_key){+.+.}-{4:4}, at: team_change_rx_flags+0x38/0x220 drivers/net/team/team_core.c:1781
> other info that might help us debug this:
> context-{5:5}
> 2 locks held by syz-executor316/5831:
>  #0: ffffffff8f2f7408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
>  #0: ffffffff8f2f7408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
>  #0: ffffffff8f2f7408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_dellink+0x331/0x710 net/core/rtnetlink.c:3556
>  #1: ffffffff8df3dce0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
>  #1: ffffffff8df3dce0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
>  #1: ffffffff8df3dce0 (rcu_read_lock){....}-{1:3}, at: packet_notifier+0x78/0xa60 net/packet/af_packet.c:4240
> stack backtrace:
> CPU: 0 UID: 0 PID: 5831 Comm: syz-executor316 Tainted: G        W           6.15.0-rc6-syzkaller-00168-g239af1970bcb #0 PREEMPT(full) 
> Tainted: [W]=WARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  print_lock_invalid_wait_context kernel/locking/lockdep.c:4831 [inline]
>  check_wait_context kernel/locking/lockdep.c:4903 [inline]
>  __lock_acquire+0xbcf/0xd20 kernel/locking/lockdep.c:5185
>  lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
>  __mutex_lock_common kernel/locking/mutex.c:601 [inline]
>  __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:746
>  team_change_rx_flags+0x38/0x220 drivers/net/team/team_core.c:1781
>  dev_change_rx_flags net/core/dev.c:9145 [inline]
>  __dev_set_promiscuity+0x3f8/0x590 net/core/dev.c:9189
>  netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9201
>  dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:286
>  packet_dev_mc net/packet/af_packet.c:3698 [inline]
>  packet_dev_mclist_delete net/packet/af_packet.c:3722 [inline]
>  packet_notifier+0x292/0xa60 net/packet/af_packet.c:4247
>  notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
>  call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
>  call_netdevice_notifiers net/core/dev.c:2228 [inline]
>  unregister_netdevice_many_notify+0x15d8/0x2330 net/core/dev.c:11972
>  rtnl_delete_link net/core/rtnetlink.c:3522 [inline]
>  rtnl_dellink+0x488/0x710 net/core/rtnetlink.c:3564
>  rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6955
>  netlink_rcv_skb+0x219/0x490 net/netlink/af_netlink.c:2534
>  netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>  netlink_unicast+0x75b/0x8d0 net/netlink/af_netlink.c:1339
>  netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
>  sock_sendmsg_nosec net/socket.c:712 [inline]
>  __sock_sendmsg+0x219/0x270 net/socket.c:727
>  ____sys_sendmsg+0x505/0x830 net/socket.c:2566
>  ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
>  __sys_sendmsg net/socket.c:2652 [inline]
>  __do_sys_sendmsg net/socket.c:2657 [inline]
>  __se_sys_sendmsg net/socket.c:2655 [inline]
>  __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fa537a5c859
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff93fbcb88 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa537a5c859
> RDX: 0000000000000000 RSI: 00002000000001c0 RDI: 0000000000000004
> RBP: 00007fa537aaa47d R08: 0000555500000000 R09: 0000555500000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa537aaa3e5
> R13: 0000000000000001 R14: 00007fff93fbcbd0 R15: 0000000000000003
>  </TASK>
> team_slave_0: left promiscuous mode
> team_slave_1: left promiscuous mode
> team0 (unregistering): Port device team_slave_0 removed
> team0 (unregistering): Port device team_slave_1 removed
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

#syz test

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index d4dba06297c3..9148d1aa96f9 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3713,15 +3713,15 @@ static int packet_dev_mc(struct net_device *dev, struct packet_mclist *i,
 }
 
 static void packet_dev_mclist_delete(struct net_device *dev,
-				     struct packet_mclist **mlp)
+				     struct packet_mclist **mlp,
+				     struct list_head *list)
 {
 	struct packet_mclist *ml;
 
 	while ((ml = *mlp) != NULL) {
 		if (ml->ifindex == dev->ifindex) {
-			packet_dev_mc(dev, ml, -1);
+			list_add(&ml->list, list);
 			*mlp = ml->next;
-			kfree(ml);
 		} else
 			mlp = &ml->next;
 	}
@@ -4233,9 +4233,11 @@ static int packet_getsockopt(struct socket *sock, int level, int optname,
 static int packet_notifier(struct notifier_block *this,
 			   unsigned long msg, void *ptr)
 {
-	struct sock *sk;
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	struct net *net = dev_net(dev);
+	struct packet_mclist *ml, *tmp;
+	LIST_HEAD(mclist);
+	struct sock *sk;
 
 	rcu_read_lock();
 	sk_for_each_rcu(sk, &net->packet.sklist) {
@@ -4244,7 +4246,7 @@ static int packet_notifier(struct notifier_block *this,
 		switch (msg) {
 		case NETDEV_UNREGISTER:
 			if (po->mclist)
-				packet_dev_mclist_delete(dev, &po->mclist);
+				packet_dev_mclist_delete(dev, &po->mclist, &mclist);
 			fallthrough;
 
 		case NETDEV_DOWN:
@@ -4277,6 +4279,13 @@ static int packet_notifier(struct notifier_block *this,
 		}
 	}
 	rcu_read_unlock();
+
+	/* packet_dev_mc might grab instance locks so can't run under rcu */
+	list_for_each_entry_safe(ml, tmp, &mclist, list) {
+		packet_dev_mc(dev, ml, -1);
+		kfree(ml);
+	}
+
 	return NOTIFY_DONE;
 }
 
diff --git a/net/packet/internal.h b/net/packet/internal.h
index d5d70712007a..c7dd55a610db 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -11,6 +11,7 @@ struct packet_mclist {
 	unsigned short		type;
 	unsigned short		alen;
 	unsigned char		addr[MAX_ADDR_LEN];
+	struct list_head	list;
 };
 
 /* kbdq - kernel block descriptor queue */

