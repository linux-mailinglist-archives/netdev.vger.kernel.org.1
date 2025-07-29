Return-Path: <netdev+bounces-210771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59538B14BD4
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 12:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91FA43A9A4B
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 10:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FF61A23AC;
	Tue, 29 Jul 2025 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEiO8i3E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F072E36E4;
	Tue, 29 Jul 2025 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753783303; cv=none; b=McLbNFf+18wqrUkn55hPEgjNf75eSwuTwTn6xQbNOxh10wuVX2oGQU67Wq3H9SVPdXtWPM/h1wnZDyEnfHkbJocs+5HXE3/j1m+e71VogCQltIjcTpUCGVfbCnlugjpWwlb0bJNN3Mfe29MtYYZ8J7XXNHjiVp52ZstCJ3xs7RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753783303; c=relaxed/simple;
	bh=hd3VQT4pVojiEGz/Z3dvMOUICFYUTmk7PYLkJC4Jay4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6TNEz7andCxMZCwd6TDnvd3j/DkdqlSlRLc61plo/wZqDQ2zvwuaYT8h7Nlm2wcWWeHtFen9tEbZJi0w5on83KC6gdiRQJGqMJ04RyoNuLQxCRBSypPqejUGS2/hrWZtSvNt6zor5RK1LnHuck5ZClOHT+x+90Wi4hKKFkBUM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEiO8i3E; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23dc5bcf49eso73929475ad.2;
        Tue, 29 Jul 2025 03:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753783300; x=1754388100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d1d8s18MtuhaX0kZg4OWxHrrMPP6mzme6aHMpmRny7A=;
        b=UEiO8i3EqvH222wEvffRWtuW+ODUrja2mHpcA8t9IjIoV7rpwGm+nOnuly7Y3jv9E1
         ohYhCXHT/7lHZJDCPhyez3/GU3x2yZmFeaGaAbiTbe5NC/bv38pCExaqZRhgz3p4PQp+
         B8LrKR8QMPDVvqS2AQuFnUWqa5u7cOWyhrrgpJzM5wB0hs+mxXG+5Z6nlYE4J21szBdx
         FAgPxTKCNITtHNhHg6t0AzSNVqNNT0g+LJNkTacIOV0KW1IO1/h8kk/sm626MZqXuPLK
         QHUl3gFdwI4h4XmmHVdDQ4HGM4vGSnW+4qpl/pA+FDFty3QBaL8IOhuLOXKPp3ZeyIVi
         rhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753783300; x=1754388100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1d8s18MtuhaX0kZg4OWxHrrMPP6mzme6aHMpmRny7A=;
        b=w9XBNvTZeFbku+ev7vmQpOPC0/f79Dgz0iY4i3NetWIHt8yDmAH8Oo/4mEV1s5Q/7Q
         aMDS+JOK/P2FtH6mf9h0+flDQ1USJ2XzqlE95LDhYFalwk20NZyEL+yCNCJrftrK9kZC
         Q6iW5zbmLK9l+8ADmpZDXOcQcQAuEpntfexEB6a8wl+pFJzHvY0DEftjqWUM6xNBHxgJ
         7AJhFBvpSeMa7NHPYe5NLY4L5Xi4Y1so0YfjHSSqF7rkAosCNgJuWBbke0t6K2E23qNR
         d76QW3F9WFDQyTCWNYkEG+jmEtuGgfwcL25GJK3B5aL9cht1pOIQ60JZEd+BnFuxWyvO
         BBYw==
X-Forwarded-Encrypted: i=1; AJvYcCV7ArVS94Wf8sNwWfux91LJ34y73LOShi+Tj8K/kzYUYQNRaimset/hbr2zZ8/aVUEqNuMiOAhU@vger.kernel.org, AJvYcCXcwJLtU1Gzo37GNlKu6D7glf2ZArLIRr7Re4JMEbxH0T8WkQsBv9nI0pZ6AY6r9JAT7Sv77drkh+trScg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv834CE/3K3MPvPV9vwOtbs9k1nGbRhCt04fS4ouitJ5hOWTmP
	rvDE8aGBmXkY9o4O+P/KcKNiJCtXwcN1I6oZO5wv/KeXfb124voH1KXZ7iC0XdJj1+s=
X-Gm-Gg: ASbGncspJxgQ7ZFSKYds+QE4518CEJz7mBXEjTDL2qVqthACmCw9wGBEJC5H1EIK1Uf
	bW/EgrcPCo3tFbpT4aDc4DvQU8MfA6xLAo7gSp9m0wZaIZCnzmO5UYxYW6uooE/eVo2qiDoPgpd
	iYa7XQkzaKq9FoGNGVQ1BZu2rtXiXn3kSJDcnPZmnpyC3/z6rj2a8sStbNYEYjWiKdJ9lMDphmt
	TGHBuyJNNQ+I+cReq5LDO3iDnhNQ3bOxT0vxy9onXiDvwwR+q2/dH62stmTMt6MypwtvoNm2ZWw
	1gqdP4SFWaXoUZU2iiTQfAtKaNtpgufjIlYrenZIj3n3icPs8HuN8+76Qy8m2PcUk0CWSw5xVK8
	SBgwj0R9CRNnt8UR0T5dBGlhqBB8=
X-Google-Smtp-Source: AGHT+IE9hYg8cukZ+hl7si3IylaTKnmyWymkGisg4a9Xj40pbJI5mi+qG/0RzKBwsFDp8xroavZ9Cw==
X-Received: by 2002:a17:902:f70a:b0:240:eea:35f2 with SMTP id d9443c01a7336-2400eea38cfmr131815665ad.24.1753783300121;
        Tue, 29 Jul 2025 03:01:40 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2405bca90ebsm21740415ad.6.2025.07.29.03.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 03:01:39 -0700 (PDT)
Date: Tue, 29 Jul 2025 10:01:32 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Stanislav Fomichev <sdf@fomichev.me>, Jiri Pirko <jiri@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	syzbot <syzbot+8182574047912f805d59@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [net?] BUG: sleeping function called from invalid
 context in team_change_rx_flags (2)
Message-ID: <aIib_MyMj6jgCOVC@fedora>
References: <68712acf.a00a0220.26a83e.0051.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68712acf.a00a0220.26a83e.0051.GAE@google.com>

Cc Stanislav
On Fri, Jul 11, 2025 at 08:16:31AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    dd831ac8221e net/sched: sch_qfq: Fix null-deref in agg_deq..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=13245bd4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b29b1a0d7330d4a8
> dashboard link: https://syzkaller.appspot.com/bug?extid=8182574047912f805d59
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b7b63815bf2a/disk-dd831ac8.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f857222aabbb/vmlinux-dd831ac8.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9071ec6016d0/bzImage-dd831ac8.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8182574047912f805d59@syzkaller.appspotmail.com
> 
> netlink: 8 bytes leftover after parsing attributes in process `syz.1.1814'.
> macsec0: entered promiscuous mode
> team0: entered promiscuous mode
> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:579
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 12326, name: syz.1.1814
> preempt_count: 201, expected: 0
> RCU nest depth: 0, expected: 0
> 3 locks held by syz.1.1814/12326:
>  #0: ffffffff8fa21eb8 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
>  #0: ffffffff8fa21eb8 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
>  #0: ffffffff8fa21eb8 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x23/0x250 net/core/rtnetlink.c:570
>  #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
>  #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
>  #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x8db/0x1c70 net/core/rtnetlink.c:4054
>  #2: ffff8880635e8368 (&macsec_netdev_addr_lock_key#2/2){+...}-{3:3}, at: netif_addr_lock_bh include/linux/netdevice.h:4805 [inline]
>  #2: ffff8880635e8368 (&macsec_netdev_addr_lock_key#2/2){+...}-{3:3}, at: dev_uc_add+0x67/0x120 net/core/dev_addr_lists.c:689
> Preemption disabled at:
> [<ffffffff895a7d26>] local_bh_disable include/linux/bottom_half.h:20 [inline]
> [<ffffffff895a7d26>] netif_addr_lock_bh include/linux/netdevice.h:4804 [inline]
> [<ffffffff895a7d26>] dev_uc_add+0x56/0x120 net/core/dev_addr_lists.c:689
> CPU: 0 UID: 0 PID: 12326 Comm: syz.1.1814 Not tainted 6.16.0-rc4-syzkaller-00153-gdd831ac8221e #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  __might_resched+0x495/0x610 kernel/sched/core.c:8800
>  __mutex_lock_common kernel/locking/mutex.c:579 [inline]
>  __mutex_lock+0x106/0xe80 kernel/locking/mutex.c:747
>  team_change_rx_flags+0x38/0x220 drivers/net/team/team_core.c:1781
>  dev_change_rx_flags net/core/dev.c:9241 [inline]
>  __dev_set_promiscuity+0x534/0x740 net/core/dev.c:9285
>  netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9305
>  dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:287
>  dev_change_rx_flags net/core/dev.c:9241 [inline]
>  __dev_set_promiscuity+0x534/0x740 net/core/dev.c:9285
>  __dev_set_rx_mode+0x17c/0x260 net/core/dev.c:-1
>  dev_uc_add+0xc8/0x120 net/core/dev_addr_lists.c:693
>  macsec_dev_open+0xd9/0x530 drivers/net/macsec.c:3634
>  __dev_open+0x470/0x880 net/core/dev.c:1683
>  __dev_change_flags+0x1ea/0x6d0 net/core/dev.c:9458
>  rtnl_configure_link net/core/rtnetlink.c:3577 [inline]
>  rtnl_newlink_create+0x555/0xb00 net/core/rtnetlink.c:3833
>  __rtnl_newlink net/core/rtnetlink.c:3940 [inline]
>  rtnl_newlink+0x16d6/0x1c70 net/core/rtnetlink.c:4055
>  rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6944
>  netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2551
>  netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
>  netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1346
>  netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
>  sock_sendmsg_nosec net/socket.c:712 [inline]
>  __sock_sendmsg+0x219/0x270 net/socket.c:727
>  ____sys_sendmsg+0x505/0x830 net/socket.c:2566
>  ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
>  __sys_sendmsg net/socket.c:2652 [inline]
>  __do_sys_sendmsg net/socket.c:2657 [inline]
>  __se_sys_sendmsg net/socket.c:2655 [inline]
>  __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f2785b8e929
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f27869d6038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f2785db5fa0 RCX: 00007f2785b8e929
> RDX: 0000000000000800 RSI: 0000200000000280 RDI: 0000000000000009
> RBP: 00007f2785c10b39 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f2785db5fa0 R15: 00007ffe1c84aa28
>  </TASK>
> 
> =============================
> [ BUG: Invalid wait context ]
> 6.16.0-rc4-syzkaller-00153-gdd831ac8221e #0 Tainted: G        W          
> -----------------------------
> syz.1.1814/12326 is trying to lock:
> ffff88802715ce00 (team->team_lock_key#2){+.+.}-{4:4}, at: team_change_rx_flags+0x38/0x220 drivers/net/team/team_core.c:1781
> other info that might help us debug this:
> context-{5:5}
> 3 locks held by syz.1.1814/12326:
>  #0: ffffffff8fa21eb8 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
>  #0: ffffffff8fa21eb8 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
>  #0: ffffffff8fa21eb8 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x23/0x250 net/core/rtnetlink.c:570
>  #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
>  #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
>  #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x8db/0x1c70 net/core/rtnetlink.c:4054
>  #2: ffff8880635e8368 (&macsec_netdev_addr_lock_key#2/2){+...}-{3:3}, at: netif_addr_lock_bh include/linux/netdevice.h:4805 [inline]
>  #2: ffff8880635e8368 (&macsec_netdev_addr_lock_key#2/2){+...}-{3:3}, at: dev_uc_add+0x67/0x120 net/core/dev_addr_lists.c:689
> stack backtrace:
> CPU: 0 UID: 0 PID: 12326 Comm: syz.1.1814 Tainted: G        W           6.16.0-rc4-syzkaller-00153-gdd831ac8221e #0 PREEMPT(full) 
> Tainted: [W]=WARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  print_lock_invalid_wait_context kernel/locking/lockdep.c:4833 [inline]
>  check_wait_context kernel/locking/lockdep.c:4905 [inline]
>  __lock_acquire+0xbcb/0xd20 kernel/locking/lockdep.c:5190
>  lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
>  __mutex_lock_common kernel/locking/mutex.c:602 [inline]
>  __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:747
>  team_change_rx_flags+0x38/0x220 drivers/net/team/team_core.c:1781
>  dev_change_rx_flags net/core/dev.c:9241 [inline]
>  __dev_set_promiscuity+0x534/0x740 net/core/dev.c:9285
>  netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9305
>  dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:287
>  dev_change_rx_flags net/core/dev.c:9241 [inline]
>  __dev_set_promiscuity+0x534/0x740 net/core/dev.c:9285
>  __dev_set_rx_mode+0x17c/0x260 net/core/dev.c:-1
>  dev_uc_add+0xc8/0x120 net/core/dev_addr_lists.c:693
>  macsec_dev_open+0xd9/0x530 drivers/net/macsec.c:3634
>  __dev_open+0x470/0x880 net/core/dev.c:1683
>  __dev_change_flags+0x1ea/0x6d0 net/core/dev.c:9458
>  rtnl_configure_link net/core/rtnetlink.c:3577 [inline]
>  rtnl_newlink_create+0x555/0xb00 net/core/rtnetlink.c:3833
>  __rtnl_newlink net/core/rtnetlink.c:3940 [inline]
>  rtnl_newlink+0x16d6/0x1c70 net/core/rtnetlink.c:4055
>  rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6944
>  netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2551
>  netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
>  netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1346
>  netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
>  sock_sendmsg_nosec net/socket.c:712 [inline]
>  __sock_sendmsg+0x219/0x270 net/socket.c:727
>  ____sys_sendmsg+0x505/0x830 net/socket.c:2566
>  ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
>  __sys_sendmsg net/socket.c:2652 [inline]
>  __do_sys_sendmsg net/socket.c:2657 [inline]
>  __se_sys_sendmsg net/socket.c:2655 [inline]
>  __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f2785b8e929
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f27869d6038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f2785db5fa0 RCX: 00007f2785b8e929
> RDX: 0000000000000800 RSI: 0000200000000280 RDI: 0000000000000009
> RBP: 00007f2785c10b39 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f2785db5fa0 R15: 00007ffe1c84aa28
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
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

