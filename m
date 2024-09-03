Return-Path: <netdev+bounces-124543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4771B969EC8
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 15:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC3F1C23800
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 13:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3651D1A725B;
	Tue,  3 Sep 2024 13:13:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA911A724C
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725369210; cv=none; b=ZVFhsLv7stJlhk6/cAJK6os3ZJv2sQwZpGVvePsxrwzHPl266ceK0sqvsiVYxuUnPJ9bMGveHZOuyL4Tbzk8g25QLncydQqWD1FVTyH8LjYnXewH8U19xxCH0u7xDPx8sogIVKIwq7kqMqg/b3p21xTPGusJq8bAU/VqL0I534U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725369210; c=relaxed/simple;
	bh=ncdhEc6y/zKdyN7FJjk7BZ/mmD8nRsf5R66HUXMKFNo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OTGf/ftzqlYe1AKWBWJHypDjA2Co451lwjFYfJs8FybDnXVCl/tiooMDDK2j5gERXawCn11Z+A82TRKNNZKohfM9qdPSJOLjvjs7RHJOXx3Nf8tjEujFZ5BdwxrU9xFBzpBmI2Tb4oKjJ6aXWa14Ixgu4P5nQedeXy32v+p0rcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39effb97086so56974805ab.2
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 06:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725369207; x=1725974007;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F5KPYw13jvQBA0s8NvyHZPAaNVBFGSG7LyhkOqJqf/Q=;
        b=YEX7qhEBSCuuWKTA7JjlEdxpMKd2B7+xrgvZPsoY9KFUDST5PNkIR2T2NWI5ZpLYuH
         PhKbddEWGqmHd+0IeRTN6Ua38kOwoaUNutA+192eGPZDue1KYrNQRS5Sy7i047PiXgf+
         qgeGG8oY4AjwbiEMmA8gqCrpY3uAp8DP7DhD9wyfCLeAu6Ao15b3p539qJMZZPwQGjpO
         x/W014OQ5utPC5NUsYmHbLhxahVENYs/gXUJh1WLYCHi7sKPb2KsDumP6u42UF5DLXIr
         W07YHB0aSBkH/KkrA4WsSQIqaU0SYYjLr51rtaVIantZyz9VCkxdyPZqmwfP4J6Z91R/
         TfCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGZgT/8fYXB5BA1+LAYE0YF/sKz0+lsEU8hcQ8Skoa+vHXos2DOk8/Re1Tbf2ZWmNZezkR/fw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1w5gG4smbgQI7H6mrU0ter5eCVmPoWv2KqFayWrY5VP1TQ+gq
	OzFiFkudfVN/wrtIrZgkGDkWLoKjU4/KJ++X7LHp3MIxciTymRbGv+4lIJACDs+RD/Eq1erecPK
	07pinHwo9ZiNUN1WqCWkbJum4lypI+S45Dh3MlKpJykKAyzjDl0BnKQc=
X-Google-Smtp-Source: AGHT+IEck3mnaXT3hf10SvaWADCs9Yzz/MVSu4bxnnrdtlDKP6Ij/Wgs84P3wH6Sf/5R8/0YclhjgTnjCuye6DmQGOV2xlr8LKKL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda3:0:b0:39f:72a0:1759 with SMTP id
 e9e14a558f8ab-39f72a0197bmr54985ab.6.1725369207609; Tue, 03 Sep 2024 06:13:27
 -0700 (PDT)
Date: Tue, 03 Sep 2024 06:13:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b9e4d4062136d265@google.com>
Subject: [syzbot] [net?] possible deadlock in ipv6_sock_mc_close (2)
From: syzbot <syzbot+34658a0f0144bec77d8d@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    43d0035b2c6a Merge branch 'unmask-dscp-bits'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10c73b33980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=996585887acdadb3
dashboard link: https://syzkaller.appspot.com/bug?extid=34658a0f0144bec77d8d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d9ee2f9a24bd/disk-43d0035b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/45ba9b6d0285/vmlinux-43d0035b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/23448fef5f65/bzImage-43d0035b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+34658a0f0144bec77d8d@syzkaller.appspotmail.com

IPVS: stopping backup sync thread 11551 ...
======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc5-syzkaller-00764-g43d0035b2c6a #0 Not tainted
------------------------------------------------------
syz.2.1876/12083 is trying to acquire lock:
ffffffff8fc8c048 (rtnl_mutex){+.+.}-{3:3}, at: ipv6_sock_mc_close+0xc9/0x140 net/ipv6/mcast.c:354

but task is already holding lock:
ffff88805f5ef850 (&smc->clcsock_release_lock){+.+.}-{3:3}, at: smc_setsockopt+0x1c3/0xe50 net/smc/af_smc.c:3056

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&smc->clcsock_release_lock){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       smc_switch_to_fallback+0x35/0xdb0 net/smc/af_smc.c:902
       smc_sendmsg+0x11f/0x530 net/smc/af_smc.c:2771
       sock_sendmsg_nosec net/socket.c:730 [inline]
       __sock_sendmsg+0x221/0x270 net/socket.c:745
       __sys_sendto+0x3a4/0x4f0 net/socket.c:2204
       __do_sys_sendto net/socket.c:2216 [inline]
       __se_sys_sendto net/socket.c:2212 [inline]
       __x64_sys_sendto+0xde/0x100 net/socket.c:2212
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (sk_lock-AF_INET){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       lock_sock_nested+0x48/0x100 net/core/sock.c:3543
       do_ip_setsockopt+0x1a2d/0x3cd0 net/ipv4/ip_sockglue.c:1078
       ip_setsockopt+0x63/0x100 net/ipv4/ip_sockglue.c:1417
       do_sock_setsockopt+0x3af/0x720 net/socket.c:2324
       __sys_setsockopt+0x1ae/0x250 net/socket.c:2347
       __do_sys_setsockopt net/socket.c:2356 [inline]
       __se_sys_setsockopt net/socket.c:2353 [inline]
       __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2353
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (rtnl_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
       __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       ipv6_sock_mc_close+0xc9/0x140 net/ipv6/mcast.c:354
       inet6_release+0x47/0x70 net/ipv6/af_inet6.c:484
       __sock_release net/socket.c:659 [inline]
       sock_release+0x82/0x150 net/socket.c:687
       stop_sync_thread+0x4e6/0x5e0 net/netfilter/ipvs/ip_vs_sync.c:2004
       do_ip_vs_set_ctl+0x47b/0x13d0 net/netfilter/ipvs/ip_vs_ctl.c:2734
       nf_setsockopt+0x295/0x2c0 net/netfilter/nf_sockopt.c:101
       smc_setsockopt+0x275/0xe50 net/smc/af_smc.c:3064
       do_sock_setsockopt+0x3af/0x720 net/socket.c:2324
       __sys_setsockopt+0x1ae/0x250 net/socket.c:2347
       __do_sys_setsockopt net/socket.c:2356 [inline]
       __se_sys_setsockopt net/socket.c:2353 [inline]
       __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2353
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
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

1 lock held by syz.2.1876/12083:
 #0: ffff88805f5ef850 (&smc->clcsock_release_lock){+.+.}-{3:3}, at: smc_setsockopt+0x1c3/0xe50 net/smc/af_smc.c:3056

stack backtrace:
CPU: 0 UID: 0 PID: 12083 Comm: syz.2.1876 Not tainted 6.11.0-rc5-syzkaller-00764-g43d0035b2c6a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
 __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 ipv6_sock_mc_close+0xc9/0x140 net/ipv6/mcast.c:354
 inet6_release+0x47/0x70 net/ipv6/af_inet6.c:484
 __sock_release net/socket.c:659 [inline]
 sock_release+0x82/0x150 net/socket.c:687
 stop_sync_thread+0x4e6/0x5e0 net/netfilter/ipvs/ip_vs_sync.c:2004
 do_ip_vs_set_ctl+0x47b/0x13d0 net/netfilter/ipvs/ip_vs_ctl.c:2734
 nf_setsockopt+0x295/0x2c0 net/netfilter/nf_sockopt.c:101
 smc_setsockopt+0x275/0xe50 net/smc/af_smc.c:3064
 do_sock_setsockopt+0x3af/0x720 net/socket.c:2324
 __sys_setsockopt+0x1ae/0x250 net/socket.c:2347
 __do_sys_setsockopt net/socket.c:2356 [inline]
 __se_sys_setsockopt net/socket.c:2353 [inline]
 __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2353
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc693f79eb9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc6939ff038 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007fc694116058 RCX: 00007fc693f79eb9
RDX: 000000000000048c RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007fc693fe793e R08: 0000000000000018 R09: 0000000000000000
R10: 00000000200002c0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fc694116058 R15: 00007ffcf1815ee8
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

