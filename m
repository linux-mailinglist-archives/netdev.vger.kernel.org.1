Return-Path: <netdev+bounces-109949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D6392A717
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 18:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9DA289A34
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 16:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69371419B5;
	Mon,  8 Jul 2024 16:15:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7461E532
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720455325; cv=none; b=dAFbfo3NvNFQJwQD1kauOejuRFRzygD8+eM+AgfLVQ4ii9bCpMIXZ8HUcrh7K3X7EVUQs8mX55mRnJ9anU23lUxBjqUxkbnvy7mw+FfINAm78NyJYCGnosXd+tehlRVGG9NPZovc25IVBWOPaRltzH+HlqblH3/c3XPiTp8AMG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720455325; c=relaxed/simple;
	bh=GgEAR5dpONGed+nidAw7KEdKSzIFl9Ib05/H3E8rsAM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Da/b/ikqAJXEz2yDQyXvnaMgWHnlzf4GCFoCxnWVv+urU1VajCfcqFC6rEOcPbxS/03Y1i/gHTdpzOxoV6H5FE5NUAH1gzWZVxtv3javvmPXlWeoQcnRRg+D59JVRXDfSOm0oPkx77ery3ZuRMRIeSHM5eVBZJbjKRNrfeQ9Zzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f95699cabcso206266939f.1
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 09:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720455323; x=1721060123;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sm4TwZOfPSmBLxc0vBSn66xtnDjhTw3a23Py6ZfnH0M=;
        b=vauoKD8jZ9/xn4SAD8FF1jh8AFzr0V1FToyJHC6R8yK1Zsiogd/R+BLFpoNfQ83/M0
         TNF1a+zhvtznWszWxkjt/HS4wwjzyaQ6hkB41sOBwqJEJ8wkSynfsH/Gw+3IClHji7lU
         /xuzPARMcYEnhnH0U+zntQXfenOcZfB+1SKXs/Sy4KNBgOJEAWI/tN+yd5NUeovTM2TT
         DyhP2y6Pbfjtj5xriPJLbPpZQLE7HFVz645iqju90G4DW43r9+sFJfZCjLdP8IQ1b5CS
         eN3havpQw4JGpteuqArPTxYCNZObvkDZAQPf3TowVrDwMCLNsp4JO2qegAzY+P1Uvq7E
         qK+g==
X-Forwarded-Encrypted: i=1; AJvYcCVkR7isSgSTHnRYRl1teDNp8zelv0eRa0GjcQhjpePUOOM5wnZ20isZp+c3al0mj1h4KrZ5F8BZ7epguHSrU0IMT3WiOYHI
X-Gm-Message-State: AOJu0YziOLsgV2Hau5JLmhfC8SmCzoZE8hl+QYshDeb3Sq3dpXKiaeq4
	9t0w5q0Bt1UNTB4pBiOTnYHmZdRTpberIVrZvzIo93lHSxzESPfAsZewvZnfKRB/T83AHw1i6uV
	RuZSxNP/pQrX4syI7H67KhpYXAI8oLS6ibXOZS0WiAu2x9V1IynIg0WA=
X-Google-Smtp-Source: AGHT+IEoM/sL2r1Md8MyTb1XWYPAT5psbFpYmXO2aKD17aQbGPQTqdBMQTiCgJIFI7lttTBFOhc8KEXJM2BpC6EgAvSL3XcCn+Wd
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:2805:0:b0:382:feb2:2117 with SMTP id
 e9e14a558f8ab-3839c208010mr3197645ab.6.1720455322909; Mon, 08 Jul 2024
 09:15:22 -0700 (PDT)
Date: Mon, 08 Jul 2024 09:15:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005fd2da061cbeb875@google.com>
Subject: [syzbot] [net?] possible deadlock in ip_mc_drop_socket (2)
From: syzbot <syzbot+0a487bbdbba35360ad29@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2f5e6395714d Merge branch 'net-pse-pd-add-new-pse-c33-feat..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16b8eae1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db697e01efa9d1d7
dashboard link: https://syzkaller.appspot.com/bug?extid=0a487bbdbba35360ad29
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/44296878e8d6/disk-2f5e6395.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a3f8523e4843/vmlinux-2f5e6395.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c40a60a2869f/bzImage-2f5e6395.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0a487bbdbba35360ad29@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc6-syzkaller-01258-g2f5e6395714d #0 Not tainted
------------------------------------------------------
syz.3.1102/8237 is trying to acquire lock:
ffffffff8f5e7f48 (rtnl_mutex){+.+.}-{3:3}, at: ip_mc_drop_socket+0x81/0x280 net/ipv4/igmp.c:2702

but task is already holding lock:
ffff888021fe7850 (&smc->clcsock_release_lock){+.+.}-{3:3}, at: smc_clcsock_release+0x82/0xf0 net/smc/smc_close.c:30

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&smc->clcsock_release_lock){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       smc_switch_to_fallback+0x35/0xd00 net/smc/af_smc.c:902
       smc_sendmsg+0x11f/0x530 net/smc/af_smc.c:2779
       sock_sendmsg_nosec net/socket.c:730 [inline]
       __sock_sendmsg+0x221/0x270 net/socket.c:745
       __sys_sendto+0x3a4/0x4f0 net/socket.c:2192
       __do_sys_sendto net/socket.c:2204 [inline]
       __se_sys_sendto net/socket.c:2200 [inline]
       __x64_sys_sendto+0xde/0x100 net/socket.c:2200
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (sk_lock-AF_INET){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       lock_sock_nested+0x48/0x100 net/core/sock.c:3543
       do_ip_setsockopt+0x1a2d/0x3cd0 net/ipv4/ip_sockglue.c:1078
       ip_setsockopt+0x63/0x100 net/ipv4/ip_sockglue.c:1417
       do_sock_setsockopt+0x3af/0x720 net/socket.c:2312
       __sys_setsockopt+0x1ae/0x250 net/socket.c:2335
       __do_sys_setsockopt net/socket.c:2344 [inline]
       __se_sys_setsockopt net/socket.c:2341 [inline]
       __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2341
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (rtnl_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       ip_mc_drop_socket+0x81/0x280 net/ipv4/igmp.c:2702
       inet_release+0x96/0x200 net/ipv4/af_inet.c:424
       __sock_release net/socket.c:659 [inline]
       sock_release+0x82/0x150 net/socket.c:687
       smc_clcsock_release+0xcc/0xf0 net/smc/smc_close.c:34
       __smc_release+0x683/0x800 net/smc/af_smc.c:301
       smc_release+0x2d9/0x530 net/smc/af_smc.c:344
       __sock_release net/socket.c:659 [inline]
       sock_close+0xbc/0x240 net/socket.c:1421
       __fput+0x24a/0x8a0 fs/file_table.c:422
       task_work_run+0x24f/0x310 kernel/task_work.c:180
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
       __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
       syscall_exit_to_user_mode+0x168/0x360 kernel/entry/common.c:218
       do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  rtnl_mutex --> sk_lock-AF_INET --> &smc->clcsock_release_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&smc->clcsock_release_lock);
                               lock(sk_lock-AF_INET);
                               lock(&smc->clcsock_release_lock);
  lock(rtnl_mutex);

 *** DEADLOCK ***

2 locks held by syz.3.1102/8237:
 #0: ffff88805264b210 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:791 [inline]
 #0: ffff88805264b210 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: __sock_release net/socket.c:658 [inline]
 #0: ffff88805264b210 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: sock_close+0x90/0x240 net/socket.c:1421
 #1: ffff888021fe7850 (&smc->clcsock_release_lock){+.+.}-{3:3}, at: smc_clcsock_release+0x82/0xf0 net/smc/smc_close.c:30

stack backtrace:
CPU: 1 PID: 8237 Comm: syz.3.1102 Not tainted 6.10.0-rc6-syzkaller-01258-g2f5e6395714d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 ip_mc_drop_socket+0x81/0x280 net/ipv4/igmp.c:2702
 inet_release+0x96/0x200 net/ipv4/af_inet.c:424
 __sock_release net/socket.c:659 [inline]
 sock_release+0x82/0x150 net/socket.c:687
 smc_clcsock_release+0xcc/0xf0 net/smc/smc_close.c:34
 __smc_release+0x683/0x800 net/smc/af_smc.c:301
 smc_release+0x2d9/0x530 net/smc/af_smc.c:344
 __sock_release net/socket.c:659 [inline]
 sock_close+0xbc/0x240 net/socket.c:1421
 __fput+0x24a/0x8a0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x360 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd670175bd9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd9f45d6b8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007fd670305a60 RCX: 00007fd670175bd9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007fd670305a60 R08: 0000000000000006 R09: 0000001d9f45d9ef
R10: 00000000003ffbe4 R11: 0000000000000246 R12: 000000000001e61f
R13: 0000000000000032 R14: 00007fd670305a60 R15: 00007fd670304038
 </TASK>
mac80211_hwsim: wmediumd released netlink socket, switching to perfect channel medium


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

