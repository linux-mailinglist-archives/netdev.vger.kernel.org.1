Return-Path: <netdev+bounces-191879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AE4ABD8EF
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 15:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615111B643B4
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 13:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69DC22D4E7;
	Tue, 20 May 2025 13:09:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E154412B63
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747746576; cv=none; b=hzcF+RC2bRSxuJbk4ulNQyOTNbxnoSA2+Q7wGibDsCAQS/0Y8YFz7aeMW0tyTzvrUNEZNlMJPeeubYTapLfTiHqf0VRWr8GBeLcGAzN8K/5g9yYzUuOAkJiY6ysoXXQm4fbFcbbVHJcmnsLa/T9ux/5cC/ZwAS/YP3hQef4npq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747746576; c=relaxed/simple;
	bh=yE2VMoyKDDvN1vIvHAeKgmt3IL1qfs8+Ctmhtbp1xwU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=A/ftUCCjvM/xNiiXU46V/70ypvLYBjyLBzff44P5OJUZFDLojlLjx3GFgq6z5LQvEgGm2rWzWo8BkJUu2QNj/a6dSmz4e3PRH1bDPdH8surpCCAwnINr9f0C5l8FvTr9YtCw4/mxIvO5ihCTvZ22QULzEny9h45TD9m1LyoG+AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-86a3d964d9fso193189839f.0
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 06:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747746574; x=1748351374;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zk05nQ0iOxmI8cXODP6xrixhTxgB12ZNkFvEosrJEiM=;
        b=rZYFqrPjbtKwmHPtBDxevWgGBUl5WYxCpL5tC3pVqfV1MPncj3lU+0WrTmjYtf3r65
         ldBaietdzvrDZrFrrSVW7tFOV4ZfVoPF1CDJxE3dQZhVvAAO9tyyRtDm8Nt1rUtOjtZd
         FfCFtl+c6it2hq3TyYJ8FV06SH8l02SHo4kxAERNVZckukkvNHHw+0+bXlDhJQgttrDt
         x+9rCs/mZOFpdKlOH20Rqd0iS8t/sJrq/IMtmOPLu2bxqAAMNVo7ANilRvRjz2QjATIG
         F2Pn96u9KTgJ7PhNLMYCSp9zx98pz3oYwLIZpb6Q+7tYKH1/G0b3ZgrlWBzfLpwvtgYg
         fF+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWcrPlnP8d7bbzIUNodUWBN6sY+6fQOIzVHSfLyHiYjTKIk4bNVeHxxKGBjJNHc27DxCbcKK5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYi2lmpaMbAdkiZetPGH57nh2QElRjSl8Wgb4Uw7bZoEnZFcQu
	TA1bygpCyWQFypYr7U0RjpfVTqAhUP9XZGfQ77wU8FjTVd9HhrzIU7GzWVYpAuIuDqH1h/uiHZm
	AjKqANj0hVkefZPzzHzRPQeLlZyGZIGl8KcQ+SN7wQx93+972lby32Tuyf9I=
X-Google-Smtp-Source: AGHT+IGZzEJRQn8wLrC+XkULIfOuIAK97foravFuUt8WHkY2mASB4wC8DBWA6k7SGZkeGocaA1sZ8yJ025SJAgbLcIM4KFhDNpBo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3a81:b0:867:973:f2cb with SMTP id
 ca18e2360f4ac-86a23840913mr2338605039f.7.1747746573879; Tue, 20 May 2025
 06:09:33 -0700 (PDT)
Date: Tue, 20 May 2025 06:09:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682c7f0d.a00a0220.29bc26.027d.GAE@google.com>
Subject: [syzbot] [net?] BUG: sleeping function called from invalid context in team_change_rx_flags
From: syzbot <syzbot+b191b5ccad8d7a986286@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jiri@resnulli.us, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	stfomichev@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    239af1970bcb llc: fix data loss when reading from a socket..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1485bf68580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c3f0e807ec5d1268
dashboard link: https://syzkaller.appspot.com/bug?extid=b191b5ccad8d7a986286
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1285bf68580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f752d4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/da0ff1b4efb0/disk-239af197.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/be3cf5250e1a/vmlinux-239af197.xz
kernel image: https://storage.googleapis.com/syzbot-assets/19abc9680c68/bzImage-239af197.xz

The issue was bisected to:

commit 6b1d3c5f675cc794a015138b115afff172fb4c58
Author: Stanislav Fomichev <stfomichev@gmail.com>
Date:   Wed May 14 22:03:19 2025 +0000

    team: grab team lock during team_change_rx_flags

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1148de70580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1348de70580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1548de70580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b191b5ccad8d7a986286@syzkaller.appspotmail.com
Fixes: 6b1d3c5f675c ("team: grab team lock during team_change_rx_flags")

team0: entered promiscuous mode
team_slave_0: entered promiscuous mode
team_slave_1: entered promiscuous mode
team0 (unregistering): left promiscuous mode
BUG: sleeping function called from invalid context at kernel/locking/mutex.c:578
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 5831, name: syz-executor316
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
2 locks held by syz-executor316/5831:
 #0: ffffffff8f2f7408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #0: ffffffff8f2f7408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #0: ffffffff8f2f7408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_dellink+0x331/0x710 net/core/rtnetlink.c:3556
 #1: ffffffff8df3dce0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #1: ffffffff8df3dce0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #1: ffffffff8df3dce0 (rcu_read_lock){....}-{1:3}, at: packet_notifier+0x78/0xa60 net/packet/af_packet.c:4240
CPU: 0 UID: 0 PID: 5831 Comm: syz-executor316 Not tainted 6.15.0-rc6-syzkaller-00168-g239af1970bcb #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 __might_resched+0x495/0x610 kernel/sched/core.c:8818
 __mutex_lock_common kernel/locking/mutex.c:578 [inline]
 __mutex_lock+0x106/0xe80 kernel/locking/mutex.c:746
 team_change_rx_flags+0x38/0x220 drivers/net/team/team_core.c:1781
 dev_change_rx_flags net/core/dev.c:9145 [inline]
 __dev_set_promiscuity+0x3f8/0x590 net/core/dev.c:9189
 netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9201
 dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:286
 packet_dev_mc net/packet/af_packet.c:3698 [inline]
 packet_dev_mclist_delete net/packet/af_packet.c:3722 [inline]
 packet_notifier+0x292/0xa60 net/packet/af_packet.c:4247
 notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
 call_netdevice_notifiers net/core/dev.c:2228 [inline]
 unregister_netdevice_many_notify+0x15d8/0x2330 net/core/dev.c:11972
 rtnl_delete_link net/core/rtnetlink.c:3522 [inline]
 rtnl_dellink+0x488/0x710 net/core/rtnetlink.c:3564
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6955
 netlink_rcv_skb+0x219/0x490 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x75b/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:727
 ____sys_sendmsg+0x505/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa537a5c859
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff93fbcb88 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa537a5c859
RDX: 0000000000000000 RSI: 00002000000001c0 RDI: 0000000000000004
RBP: 00007fa537aaa47d R08: 0000555500000000 R09: 0000555500000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa537aaa3e5
R13: 0000000000000001 R14: 00007fff93fbcbd0 R15: 0000000000000003
 </TASK>

=============================
[ BUG: Invalid wait context ]
6.15.0-rc6-syzkaller-00168-g239af1970bcb #0 Tainted: G        W          
-----------------------------
syz-executor316/5831 is trying to lock:
ffff888076094e00 (team->team_lock_key){+.+.}-{4:4}, at: team_change_rx_flags+0x38/0x220 drivers/net/team/team_core.c:1781
other info that might help us debug this:
context-{5:5}
2 locks held by syz-executor316/5831:
 #0: ffffffff8f2f7408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #0: ffffffff8f2f7408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #0: ffffffff8f2f7408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_dellink+0x331/0x710 net/core/rtnetlink.c:3556
 #1: ffffffff8df3dce0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #1: ffffffff8df3dce0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #1: ffffffff8df3dce0 (rcu_read_lock){....}-{1:3}, at: packet_notifier+0x78/0xa60 net/packet/af_packet.c:4240
stack backtrace:
CPU: 0 UID: 0 PID: 5831 Comm: syz-executor316 Tainted: G        W           6.15.0-rc6-syzkaller-00168-g239af1970bcb #0 PREEMPT(full) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4831 [inline]
 check_wait_context kernel/locking/lockdep.c:4903 [inline]
 __lock_acquire+0xbcf/0xd20 kernel/locking/lockdep.c:5185
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5866
 __mutex_lock_common kernel/locking/mutex.c:601 [inline]
 __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:746
 team_change_rx_flags+0x38/0x220 drivers/net/team/team_core.c:1781
 dev_change_rx_flags net/core/dev.c:9145 [inline]
 __dev_set_promiscuity+0x3f8/0x590 net/core/dev.c:9189
 netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9201
 dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:286
 packet_dev_mc net/packet/af_packet.c:3698 [inline]
 packet_dev_mclist_delete net/packet/af_packet.c:3722 [inline]
 packet_notifier+0x292/0xa60 net/packet/af_packet.c:4247
 notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
 call_netdevice_notifiers net/core/dev.c:2228 [inline]
 unregister_netdevice_many_notify+0x15d8/0x2330 net/core/dev.c:11972
 rtnl_delete_link net/core/rtnetlink.c:3522 [inline]
 rtnl_dellink+0x488/0x710 net/core/rtnetlink.c:3564
 rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6955
 netlink_rcv_skb+0x219/0x490 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x75b/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:727
 ____sys_sendmsg+0x505/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa537a5c859
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff93fbcb88 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa537a5c859
RDX: 0000000000000000 RSI: 00002000000001c0 RDI: 0000000000000004
RBP: 00007fa537aaa47d R08: 0000555500000000 R09: 0000555500000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa537aaa3e5
R13: 0000000000000001 R14: 00007fff93fbcbd0 R15: 0000000000000003
 </TASK>
team_slave_0: left promiscuous mode
team_slave_1: left promiscuous mode
team0 (unregistering): Port device team_slave_0 removed
team0 (unregistering): Port device team_slave_1 removed


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

