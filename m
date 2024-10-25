Return-Path: <netdev+bounces-138938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC249AF7B0
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 04:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F6D282FDB
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 02:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD9C170836;
	Fri, 25 Oct 2024 02:51:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1BF54727
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 02:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729824691; cv=none; b=Z57OrvAdzIVQPpdPwNHtvPmhrwZbnF3waePlTHxBrcZyQUXR2xDWhQfdkwx4faqWCmpGhA9uTW2N0X74PXLcvrNnjtGhwwU8Bml1RQNUEwABlPRrhdcMkfdwfkCVuExm3HvXz9F/hIAdYKAkecpECZn2mOpSaP77TMr1OMIt/rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729824691; c=relaxed/simple;
	bh=52bLu1x+kRJhFCOu+anewiGpvAV6fahXlIMCgT5VvsQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AuFnvLRcWByp3bdm7tp6NLrM/gyMAQ15FnAbbqRDChbhLQkQBDU9RB6vJ4B3FFuzirjB47Frw9128nUGQSZ2fO4ROm7UYgxjalOc7MfcCseKw5ThHLPhDVlT7gQ0qhGGKPypXGuUYZTFne0fkp+EbMgzbbzU07smPzI2I5eTPnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a4e52b6577so3650875ab.3
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 19:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729824688; x=1730429488;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Af3eWkQkm9jtGrcDMKTQ3ujLO64GTKiLvO7f/ODPx4=;
        b=YvLNrJHHLxbFsBZYHN5LpDCA0dXafBw6lR2W0nZx4u3Rk+NQB5GzfXhI5tTlyaH/kc
         kglnFYWi40lOlLHnqT2zDNo4CzIYZ+C3u84XqfYCZbzsJH5HCt+Ae+7eRPbbx72H4LRK
         DO3RlnldJ4OxjIggZyoceekxFUMNJ28z8q/JD3UZDXyl+ufgwAYLy3TtxmVFjMO1nnKQ
         vF4rLKsrdwB+56+je0iEU55Jqt6YmRrK2VJoW6vh8Nt/64zZutdfoQ+a16qtV52G9N60
         EqAkC8rCKfBwftoAO4aiiT6vCZKrhCRr2Z/DBxJPWIa94wJlEH1/leVHEu6mVOh9F7NL
         c2JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLlsjLErxP1hISxw8Y091rKdOxfumIa33zhlxaav+mcj/ZKUH+RBAS+M4ihlQfluxEUsR+D0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzABnS777pKmy1CQuduM9MF42hflPws6wSkR6Ea/zPjXlXqCX5h
	ECcQvNgTsRSr6N7Q4qz7Ip7zSyU9PCLjHa8h3rA7/EBD7Kj8q483q04CL5x6MhE+hoyndx3C9W7
	cuQDAzEAFNBs2zISkYhzPm46PyU4yBPomMh5NvIBlW7XiuGYZfW5+scc=
X-Google-Smtp-Source: AGHT+IGbSe5K7En504Gro+TWFTBEllf+irenoNmPWB4QYsqozbe94FNq1p/q/QhXwnAaYbDcpWWWRH7Ri71c+lfspsRzZ7lejzSp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4f:b0:3a3:a7bf:7f85 with SMTP id
 e9e14a558f8ab-3a4de778c9fmr43849455ab.5.1729824688273; Thu, 24 Oct 2024
 19:51:28 -0700 (PDT)
Date: Thu, 24 Oct 2024 19:51:28 -0700
In-Reply-To: <66fdd08c.050a0220.40bef.0026.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671b07b0.050a0220.381c35.0009.GAE@google.com>
Subject: Re: [syzbot] [net?] INFO: task hung in genl_rcv_msg (4)
From: syzbot <syzbot+85d0bec020d805014a3a@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    c2ee9f594da8 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13815e40580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fd919c0fc1af4272
dashboard link: https://syzkaller.appspot.com/bug?extid=85d0bec020d805014a3a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d40230580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d40230580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4784686ffc6b/disk-c2ee9f59.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fbec5f2b06d9/vmlinux-c2ee9f59.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6d8289609976/bzImage-c2ee9f59.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+85d0bec020d805014a3a@syzkaller.appspotmail.com

INFO: task syz-executor279:5856 blocked for more than 160 seconds.
      Not tainted 6.12.0-rc4-syzkaller-00047-gc2ee9f594da8 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor279 state:D stack:20448 pid:5856  tgid:5856  ppid:5854   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x185a/0x4b70 kernel/sched/core.c:6690
 __schedule_loop kernel/sched/core.c:6767 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6782
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6839
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 genl_lock net/netlink/genetlink.c:35 [inline]
 genl_op_lock net/netlink/genetlink.c:60 [inline]
 genl_rcv_msg+0x121/0xec0 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 __sys_sendto+0x39b/0x4f0 net/socket.c:2214
 __do_sys_sendto net/socket.c:2226 [inline]
 __se_sys_sendto net/socket.c:2222 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2222
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbf1b8e2273
RSP: 002b:00007ffcd832d5e8 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fbf1b96b300 RCX: 00007fbf1b8e2273
RDX: 0000000000000024 RSI: 00007fbf1b96b350 RDI: 0000000000000003
RBP: 0000000000000003 R08: 00007ffcd832d604 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000001
R13: 0000000000000000 R14: 00007fbf1b96b350 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/u8:1/12:
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90000117d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90000117d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcc0948 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276
1 lock held by khungtaskd/30:
 #0: ffffffff8e937e20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937e20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937e20 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6720
7 locks held by kworker/u8:3/52:
3 locks held by kworker/u8:6/2129:
 #0: ffff88814cfae948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88814cfae948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90004e1fd00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90004e1fd00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcc0948 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4196
3 locks held by kworker/1:2/2145:
 #0: ffff88801ac81948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac81948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90004f4fd00 ((reg_check_chans).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90004f4fd00 ((reg_check_chans).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcc0948 (rtnl_mutex){+.+.}-{3:3}, at: reg_check_chans_work+0x99/0xfd0 net/wireless/reg.c:2480
2 locks held by klogd/5191:
2 locks held by dhcpcd/5496:
2 locks held by getty/5586:
 #0: ffff8880354520a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
1 lock held by dhcpcd/5644:
2 locks held by syz-executor279/5856:
 #0: ffffffff8fd266b0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8fd26568 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fd26568 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fd26568 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0x121/0xec0 net/netlink/genetlink.c:1209
6 locks held by syz-executor279/5858:
1 lock held by syz-executor279/5859:
 #0: ffffffff8fcc0948 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcc0948 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6672
6 locks held by syz-executor279/5860:
 #0: ffff8880746c6420 (sb_writers#9){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2931 [inline]
 #0: ffff8880746c6420 (sb_writers#9){.+.+}-{0:0}, at: vfs_write+0x224/0xc90 fs/read_write.c:679


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

