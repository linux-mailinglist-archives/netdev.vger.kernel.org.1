Return-Path: <netdev+bounces-76232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E2D86CEAD
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 17:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAC791F26557
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 16:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326897B3E9;
	Thu, 29 Feb 2024 16:02:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB8F13C9FA
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709222548; cv=none; b=Ow6xX19sGxLaJOxKLGtKdXfgdsKW2UOeYOjW3TxT677BszSIC/PzuPcY9RBSdimuXiKCfNxSUMy/s/qmho3u4mTrJ+nacAe94e6qprdgatdcesMqSFvlZrlrDljT86TBtxx2WNiL8yLYt0+BpEeb1Bk2To6PXlxwaDh6PeVZB+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709222548; c=relaxed/simple;
	bh=rjWL/Y6Bha7shqu2uXqU543Fxw3IBBJbd/VYx5o4fuU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AsmB9R/9J5mlLbaqMcn65px4xGkbD9DJnVAEB7F97N3/ubS15Y6D5t7ZsxMn+N3NGzfNtW5aQ8+Zgo8+kP5iDlQb5EG6DjGrX7rYQKIWk9zLkGwRYSMxREr/E4ZAczd6H1pBL5w74wVM9qeXQkptAcDsICe24CYc1wo2LDgW1ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c79b0aaa86so113579939f.2
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 08:02:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709222545; x=1709827345;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w59HKCZHVDRBtU6GpiuzXSQRPtBvO+bHfq45R2vkKWk=;
        b=GgwulFfcGzsOhU7mF3/8vNH/60E8HdjkE4Fiwl6pYJaYeasp6MLQgwHN7zhEVGEtGm
         p0SPBmI6xlRaeqCBJgxJWVFoe/vub0C+U/ec+ipaLnr3GUSmNnMrqCjlcbRdQ+BM+L0k
         O+ixeQW3bjxalDziVsZZwUXxdeYjVJNUrBw/5lhgB9u3GeeflkMDfdfVRnqrqPU3Yl3x
         ixI63BQMBNOUFkE5K/d8SpENRG5FM3VesgAx3VtXsdhMp5B/Og9aXKaE1sBf3kwXmaLp
         u9HBtcitYLTPSysKB3CKGC2JAIRiEQFE0twbBVSdwTxElRghCzhcwLDLRl+TGNeX8vhp
         4WQA==
X-Forwarded-Encrypted: i=1; AJvYcCU99OLkAoY+PZ202j0agkoyJ8bzPo4cEcf8VfRdHCZIDxulahVZqihv8af+h+5TlGU5u0/NVdKfKqz/3HJCse4uGhT+1sEZ
X-Gm-Message-State: AOJu0YyWOtbgTHhQTjMtkxuvIh1zTWux6FOfG5llgJx/T+x6t1ENLhpU
	Jh5vWuj1Mvvnz+pY9Dw7SxbHfTqnIX7shXBEWISrOsdxuiowBRjGHqchMK91ScWD9Ng8zMgplxI
	TmmzXWvYJkFo00L9mzmSV6bXgxugMeCwloB1KUZGjBWk5Qyws7qeRXik=
X-Google-Smtp-Source: AGHT+IHlZaB58FrUBUqfgQdARWsIFPXOgb3PQbmyzMgVVPsTrZjgwSBmCh4aQsm4c14ippVuZ65X+PnHkSSd8Is0araDytLkWSkG
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3789:b0:474:b754:3544 with SMTP id
 w9-20020a056638378900b00474b7543544mr178158jal.0.1709222545147; Thu, 29 Feb
 2024 08:02:25 -0800 (PST)
Date: Thu, 29 Feb 2024 08:02:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a97e9f061287624c@google.com>
Subject: [syzbot] [net?] possible deadlock in team_port_change_check (2)
From: syzbot <syzbot+3c47b5843403a45aef57@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jiri@resnulli.us, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2a770cdc4382 tun: Fix xdp_rxq_info's queue_index when deta..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=11bfb032180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eff9f3183d0a20dd
dashboard link: https://syzkaller.appspot.com/bug?extid=3c47b5843403a45aef57
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/54ceb0944449/disk-2a770cdc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/69b79e7b7a86/vmlinux-2a770cdc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dedbc599c2f7/bzImage-2a770cdc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3c47b5843403a45aef57@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.8.0-rc5-syzkaller-00129-g2a770cdc4382 #0 Not tainted
--------------------------------------------
syz-executor.1/20275 is trying to acquire lock:
ffff888045338d00 (team->team_lock_key#2){+.+.}-{3:3}, at: team_port_change_check+0x51/0x1e0 drivers/net/team/team.c:2997

but task is already holding lock:
ffff888045338d00 (team->team_lock_key#2){+.+.}-{3:3}, at: team_add_slave+0xad/0x2750 drivers/net/team/team.c:1974

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(team->team_lock_key#2);
  lock(team->team_lock_key#2);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz-executor.1/20275:
 #0: ffffffff8f3759c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f3759c8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x82c/0x1040 net/core/rtnetlink.c:6615
 #1: ffff888045338d00 (team->team_lock_key#2){+.+.}-{3:3}, at: team_add_slave+0xad/0x2750 drivers/net/team/team.c:1974

stack backtrace:
CPU: 0 PID: 20275 Comm: syz-executor.1 Not tainted 6.8.0-rc5-syzkaller-00129-g2a770cdc4382 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain+0x15c0/0x58e0 kernel/locking/lockdep.c:3856
 __lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 team_port_change_check+0x51/0x1e0 drivers/net/team/team.c:2997
 team_device_event+0x161/0x5b0 drivers/net/team/team.c:3023
 notifier_call_chain+0x18f/0x3b0 kernel/notifier.c:93
 call_netdevice_notifiers_extack net/core/dev.c:2004 [inline]
 call_netdevice_notifiers net/core/dev.c:2018 [inline]
 dev_close_many+0x33c/0x4c0 net/core/dev.c:1559
 vlan_device_event+0x18b7/0x1de0 net/8021q/vlan.c:449
 notifier_call_chain+0x18f/0x3b0 kernel/notifier.c:93
 call_netdevice_notifiers_extack net/core/dev.c:2004 [inline]
 call_netdevice_notifiers net/core/dev.c:2018 [inline]
 dev_close_many+0x33c/0x4c0 net/core/dev.c:1559
 dev_close+0x1c0/0x2c0 net/core/dev.c:1581
 team_port_add drivers/net/team/team.c:1312 [inline]
 team_add_slave+0x1aef/0x2750 drivers/net/team/team.c:1975
 do_set_master net/core/rtnetlink.c:2707 [inline]
 do_setlink+0xe58/0x41c0 net/core/rtnetlink.c:2913
 rtnl_setlink+0x40d/0x5a0 net/core/rtnetlink.c:3209
 rtnetlink_rcv_msg+0x885/0x1040 net/core/rtnetlink.c:6618
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0xa3b/0xd70 net/netlink/af_netlink.c:1908
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 sock_write_iter+0x2dd/0x400 net/socket.c:1160
 do_iter_readv_writev+0x46c/0x640
 vfs_writev+0x395/0xbb0 fs/read_write.c:971
 do_writev+0x1b1/0x350 fs/read_write.c:1018
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7ff40be7dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff40cb2f0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007ff40bfabf80 RCX: 00007ff40be7dda9
RDX: 0000000000000001 RSI: 0000000020000400 RDI: 0000000000000003
RBP: 00007ff40beca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007ff40bfabf80 R15: 00007ffdeb79a408
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

