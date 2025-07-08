Return-Path: <netdev+bounces-205153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B72AAFDA00
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 23:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A04E1BC64FA
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 21:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A107241661;
	Tue,  8 Jul 2025 21:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebZj7ope"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1353C01;
	Tue,  8 Jul 2025 21:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752010453; cv=none; b=gOXpwinG72bSyZRVzbBqVSRN5jwMkVj+asvrCiwaRLnYT3mUpDI2oPXfoRMnOG/yLJG6OgtC3Hof5c9fGS0gzrAB/oPFPlZQIPtLIv+NvozO7CSEpiD8BVNNaUQvZUhDESPwIb0NnRUQ1Yicg+aFiJ9Qmz0IoZhDwskHUjiZzOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752010453; c=relaxed/simple;
	bh=na91xfsr65pTCC3N0fBTQwDdgopa3rlYNWMbEMxDWYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9/ziWheseNqUoUEUDa5DkP73QL6GJC0ztY9ntuHibaX2uZyE1p6c9jMjmO4vjGcR6IFqsoPg25zqchODNURjC4rWpc2ryem2JM96Gtrl4eq9Sx/on3fjN81PnbgHSBuXPxdcI5UlZU7y703/OQxrx1WF2EVSnbpBaAvgFv+K2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebZj7ope; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-747fba9f962so312881b3a.0;
        Tue, 08 Jul 2025 14:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752010451; x=1752615251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HhVyrsEIGUwEie1x05MlkscGrBWdm5oLemOLIn8sWxk=;
        b=ebZj7opepL8oq2WBJ6JwKpsP4MQpm5nqXPTOYl1nVsTZ2gPorjOoTtDioYbqZv78CR
         0awYjC/nMuslViHPmeBTgt8SvdGyJe13/lT4v2zjuhby00mkuA/vHfF1EnbuPpZNuQ6J
         nph8FsrI7MWWh3dc8fY19sbn7WcIH011mr44ZJj9P6xcAQ83cf5XsUJRY/3Oe6lKlkMY
         PyqzrDumUqjuBVpVNQnGAsv8fVVLZdk0UjOzvmAeCyMEmGD5873EkOMD+87Y1AMi7dTi
         r4mwVBsgGi9INIRu5eHjfOxJncX5phWr7JK47kwXOT9aj7JFmcyikHZ+h+FszYL1prtV
         vgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752010451; x=1752615251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhVyrsEIGUwEie1x05MlkscGrBWdm5oLemOLIn8sWxk=;
        b=FY0Ox/hEbRhrTCYbtDxk+Weu8JILGWIQNReLSdCQNcurMdOIsmV37XPsc2JEsLgfpI
         W4Xmrn0axYe/1/cuOBdlPUCVnjx1LshXBFH+RXDnthhXqCeiLRZF+0QApBw6DUWIL24A
         71iN1H6HZIsXu8VQJCamZLCLMGvl56bEfu5CJuUNuLeeJgpPCFPplQGcOjwF9PKyNej5
         4c2KXdxaF4QH2OPPNbCOuZhKnB8dHyxht+t8fc0I5/bH4C2dQf+FbyTqbXzH4ohCJiN+
         rt5yenbavzLXzKSs57XCQ6zJvwXVTTJuNOxndiCemK/z1JrkeL4xZUWOKp3JgcHAQs5z
         Lw0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVgeulgyYRalRNx4J4I8ncy0nz5vYnRpd41drHHUyU+8msgnDGciS3DpxR3fOQtOsdp9qHhAKaB/0SUyA=@vger.kernel.org, AJvYcCWftdCxJdfv0XIACOJLbz0W7BleE8ZdLI79jct5zrTM3TBMreTZMG7HqbeHjokZzRG74Khbg8Cc@vger.kernel.org
X-Gm-Message-State: AOJu0YyMidCbfuTVzIPM3vArOAIZcvbtsd/iZ1vUxO9UKa4GK2Pi6Mmd
	AulsANE9AYhPtupIWnAQZQ6DWIGnqNAe0G3Z1QVPCIdkuixQXZRzu/E=
X-Gm-Gg: ASbGnct7kDKAqIgun7/AtWwkXbFdfOMZMkIz5Aq9SESiDlqlwIpBtz55iKXoGX90AzQ
	lru1n/r9Peg4dS6xyFNoZHVzJthSmeD9tJJRmNk0GrqzTfaA39gOxLYm9DVJkiK0q2Skb48Dmln
	Ahdc4JhEd1Koo4eFLTabGhzbtmEA8vLuYb6tP6phnGCvESw+FGGPu/3twKA/ar3vPq9NB/5O1MV
	7uAy2UWyfatQMmngfpXrpzE5JVKR8SintaBFH2HQ9+ADYzay9bvKUBz886ThFHv7tTAZzNA9U/s
	H/JBQYYlMGSyJbRy+Seer16CqaiBDEUiG8pDNNl+RKgkfWhl/Q3TlBU4mIASnG1rsVO6E8MIyLh
	xRdpNgU30gcFG4Bl+LX+waR4=
X-Google-Smtp-Source: AGHT+IHxkaoHPNDRcmhwE1MHPN3hvOwlp7Uh9n+HAVucfNG4CK0MJNXzot6wcn9Tlm/7tG6qiPkbaQ==
X-Received: by 2002:a05:6a00:4f86:b0:74a:d2a3:80dd with SMTP id d2e1a72fcca58-74d26305951mr5307744b3a.3.1752010450695;
        Tue, 08 Jul 2025 14:34:10 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74ce417dd9asm13078401b3a.72.2025.07.08.14.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 14:34:10 -0700 (PDT)
Date: Tue, 8 Jul 2025 14:34:09 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: syzbot <syzbot+6e619ff6dd4c8618a635@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] BUG: sleeping function called from invalid
 context in dev_set_promiscuity (2)
Message-ID: <aG2O0UAQhwlbpJbX@mini-arch>
References: <686d55b4.050a0220.1ffab7.0014.GAE@google.com>
 <aG2GPuvlWR4CBG47@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aG2GPuvlWR4CBG47@mini-arch>

On 07/08, Stanislav Fomichev wrote:
> On 07/08, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    1e3b66e32601 vsock: fix `vsock_proto` declaration
> > git tree:       net
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16cbf28c580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=b29b1a0d7330d4a8
> > dashboard link: https://syzkaller.appspot.com/bug?extid=6e619ff6dd4c8618a635
> > compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/11faaf1afe22/disk-1e3b66e3.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/ba355ce28c50/vmlinux-1e3b66e3.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/018f94fd1327/bzImage-1e3b66e3.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+6e619ff6dd4c8618a635@syzkaller.appspotmail.com
> > 
> > netlink: 8 bytes leftover after parsing attributes in process `syz.3.2844'.
> > macsec0: entered promiscuous mode
> > BUG: sleeping function called from invalid context at kernel/locking/mutex.c:579
> > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 15744, name: syz.3.2844
> > preempt_count: 201, expected: 0
> > RCU nest depth: 0, expected: 0
> > 3 locks held by syz.3.2844/15744:
> >  #0: ffffffff8fa219b8 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
> >  #0: ffffffff8fa219b8 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
> >  #0: ffffffff8fa219b8 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x23/0x250 net/core/rtnetlink.c:570
> >  #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
> >  #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
> >  #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x8db/0x1c70 net/core/rtnetlink.c:4054
> >  #2: ffff88802cb3a368 (&macsec_netdev_addr_lock_key/1){+...}-{3:3}, at: netif_addr_lock_bh include/linux/netdevice.h:4805 [inline]
> >  #2: ffff88802cb3a368 (&macsec_netdev_addr_lock_key/1){+...}-{3:3}, at: dev_uc_add+0x67/0x120 net/core/dev_addr_lists.c:689
> > Preemption disabled at:
> > [<ffffffff895a79e6>] local_bh_disable include/linux/bottom_half.h:20 [inline]
> > [<ffffffff895a79e6>] netif_addr_lock_bh include/linux/netdevice.h:4804 [inline]
> > [<ffffffff895a79e6>] dev_uc_add+0x56/0x120 net/core/dev_addr_lists.c:689
> > CPU: 1 UID: 0 PID: 15744 Comm: syz.3.2844 Not tainted 6.16.0-rc4-syzkaller-00114-g1e3b66e32601 #0 PREEMPT(full) 
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
> >  __might_resched+0x495/0x610 kernel/sched/core.c:8800
> >  __mutex_lock_common kernel/locking/mutex.c:579 [inline]
> >  __mutex_lock+0x106/0xe80 kernel/locking/mutex.c:747
> >  netdev_lock include/linux/netdevice.h:2756 [inline]
> >  netdev_lock_ops include/net/netdev_lock.h:42 [inline]
> >  dev_set_promiscuity+0x10e/0x260 net/core/dev_api.c:286
> >  dev_change_rx_flags net/core/dev.c:9241 [inline]
> >  __dev_set_promiscuity+0x534/0x740 net/core/dev.c:9285
> >  __dev_set_rx_mode+0x17c/0x260 net/core/dev.c:-1
> >  dev_uc_add+0xc8/0x120 net/core/dev_addr_lists.c:693
> >  macsec_dev_open+0xd9/0x530 drivers/net/macsec.c:3634
> >  __dev_open+0x470/0x880 net/core/dev.c:1683
> >  __dev_change_flags+0x1ea/0x6d0 net/core/dev.c:9458
> >  rtnl_configure_link net/core/rtnetlink.c:3577 [inline]
> >  rtnl_newlink_create+0x555/0xb00 net/core/rtnetlink.c:3833
> >  __rtnl_newlink net/core/rtnetlink.c:3940 [inline]
> >  rtnl_newlink+0x16d6/0x1c70 net/core/rtnetlink.c:4055
> >  rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6944
> >  netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2551
> >  netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
> >  netlink_unicast+0x759/0x8e0 net/netlink/af_netlink.c:1346
> >  netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
> >  sock_sendmsg_nosec net/socket.c:712 [inline]
> >  __sock_sendmsg+0x219/0x270 net/socket.c:727
> >  ____sys_sendmsg+0x505/0x830 net/socket.c:2566
> >  ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
> >  __sys_sendmsg net/socket.c:2652 [inline]
> >  __do_sys_sendmsg net/socket.c:2657 [inline]
> >  __se_sys_sendmsg net/socket.c:2655 [inline]
> >  __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f64fc18e929
> > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f64fd052038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> > RAX: ffffffffffffffda RBX: 00007f64fc3b5fa0 RCX: 00007f64fc18e929
> > RDX: 0000000000000800 RSI: 0000200000000280 RDI: 0000000000000004
> > RBP: 00007f64fc210b39 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 0000000000000000 R14: 00007f64fc3b5fa0 R15: 00007ffd8fec8448
> >  </TASK>
> > 
> > =============================
> > [ BUG: Invalid wait context ]
> > 6.16.0-rc4-syzkaller-00114-g1e3b66e32601 #0 Tainted: G        W          
> > -----------------------------
> > syz.3.2844/15744 is trying to lock:
> > ffff888077de0d30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2756 [inline]
> > ffff888077de0d30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
> > ffff888077de0d30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: dev_set_promiscuity+0x10e/0x260 net/core/dev_api.c:286
> > other info that might help us debug this:
> > context-{5:5}
> > 3 locks held by syz.3.2844/15744:
> >  #0: ffffffff8fa219b8 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
> >  #0: ffffffff8fa219b8 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
> >  #0: ffffffff8fa219b8 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x23/0x250 net/core/rtnetlink.c:570
> >  #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
> >  #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
> >  #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x8db/0x1c70 net/core/rtnetlink.c:4054
> >  #2: ffff88802cb3a368 (&macsec_netdev_addr_lock_key/1){+...}-{3:3}, at: netif_addr_lock_bh include/linux/netdevice.h:4805 [inline]
> >  #2: ffff88802cb3a368 (&macsec_netdev_addr_lock_key/1){+...}-{3:3}, at: dev_uc_add+0x67/0x120 net/core/dev_addr_lists.c:689
> > stack backtrace:
> > CPU: 1 UID: 0 PID: 15744 Comm: syz.3.2844 Tainted: G        W           6.16.0-rc4-syzkaller-00114-g1e3b66e32601 #0 PREEMPT(full) 
> > Tainted: [W]=WARN
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
> >  print_lock_invalid_wait_context kernel/locking/lockdep.c:4833 [inline]
> >  check_wait_context kernel/locking/lockdep.c:4905 [inline]
> >  __lock_acquire+0xbcb/0xd20 kernel/locking/lockdep.c:5190
> >  lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
> >  __mutex_lock_common kernel/locking/mutex.c:602 [inline]
> >  __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:747
> >  netdev_lock include/linux/netdevice.h:2756 [inline]
> >  netdev_lock_ops include/net/netdev_lock.h:42 [inline]
> >  dev_set_promiscuity+0x10e/0x260 net/core/dev_api.c:286
> >  dev_change_rx_flags net/core/dev.c:9241 [inline]
> >  __dev_set_promiscuity+0x534/0x740 net/core/dev.c:9285
> >  __dev_set_rx_mode+0x17c/0x260 net/core/dev.c:-1
> >  dev_uc_add+0xc8/0x120 net/core/dev_addr_lists.c:693
> >  macsec_dev_open+0xd9/0x530 drivers/net/macsec.c:3634
> >  __dev_open+0x470/0x880 net/core/dev.c:1683
> >  __dev_change_flags+0x1ea/0x6d0 net/core/dev.c:9458
> >  rtnl_configure_link net/core/rtnetlink.c:3577 [inline]
> >  rtnl_newlink_create+0x555/0xb00 net/core/rtnetlink.c:3833
> >  __rtnl_newlink net/core/rtnetlink.c:3940 [inline]
> >  rtnl_newlink+0x16d6/0x1c70 net/core/rtnetlink.c:4055
> >  rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6944
> >  netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2551
> >  netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
> >  netlink_unicast+0x759/0x8e0 net/netlink/af_netlink.c:1346
> >  netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
> >  sock_sendmsg_nosec net/socket.c:712 [inline]
> >  __sock_sendmsg+0x219/0x270 net/socket.c:727
> >  ____sys_sendmsg+0x505/0x830 net/socket.c:2566
> >  ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
> >  __sys_sendmsg net/socket.c:2652 [inline]
> >  __do_sys_sendmsg net/socket.c:2657 [inline]
> >  __se_sys_sendmsg net/socket.c:2655 [inline]
> >  __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f64fc18e929
> > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f64fd052038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> > RAX: ffffffffffffffda RBX: 00007f64fc3b5fa0 RCX: 00007f64fc18e929
> > RDX: 0000000000000800 RSI: 0000200000000280 RDI: 0000000000000004
> > RBP: 00007f64fc210b39 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 0000000000000000 R14: 00007f64fc3b5fa0 R15: 00007ffd8fec8448
> >  </TASK>
> 
> Looks like it shows up for macsec only because it doesn't have
> IFF_UNICAST_FLT. Otherwise we would've seen the same with
> team/bond/etc.. But in general, __dev_set_rx_mode can try to grab
> instance lock while it's running under netif_addr spinlock which
> is not nice :-(

Ah, no, it's the real device that doesn't have IFF_UNICAST_FLT. Might
be a dummy?

dummy0: entered promiscuous mode
macsec2: entered allmulticast mode
macsec0: entered allmulticast mode
dummy0: entered allmulticast mode

Let's see if we get a real repro.

