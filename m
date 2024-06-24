Return-Path: <netdev+bounces-106185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 763A29151CD
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 17:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C02A284B02
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 15:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C749319B5BD;
	Mon, 24 Jun 2024 15:15:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087331EB3E
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242123; cv=none; b=M69Gh9JWpaZQxbm5XPIk7VF3ZgBym6/SlrfbUy7NxV+j31cpI0dYQIaQSia1lii+jm+OGau9nmBgP8giyDk7Xt1TZBUPLUYc9bMTBidxJ1RMoF4leySQ6jZ33ZzkhVeZE1mgisx1HweJC5JmOmAVIb46YEudHkdpT8cWwraKxqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242123; c=relaxed/simple;
	bh=SGBt+l9L/TihH9IN1lza25hxUi+nrQKwaozz9V6diwQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hqlWf1wi0lpdolVoSEquIh/T34ltAo22xi4SDexliyKZS8fm49/PhYXXO3+yakFnKks7KDmXyotCjFn0/u6gLmyJkr8PvbBTLHJ2zRXCiQFijrMDIiAKqy/2WtMCwR6yzNDAVy6qX/5YXUJmzVOXIXKGcRCW4ilyQk0YrcZ6dIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-375df29cb12so51637285ab.2
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 08:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719242121; x=1719846921;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LqPCBrufkafIQyPYPSVEsTUYOWhS/Uh7tEi7hC7IAo8=;
        b=gnFkUzJSgdO3TB3+hBieFazQw2TFLy9axRFPizBYNbHKNoBrAMbDZxmi3EL4uZAIFd
         DeIzsIEXqtnEv1X6rG450MNH0Yc/UgzbSksKqD2r3Mw8igRETjJ8UJ2/4D5Z6TCF4WkY
         oqXds4qpta4Qnt0i5TofZ2LXpoN2S6XcCTfYZwW99IUTlkytj7O5m8BBRhlRjUnp+Si1
         sowh+8tAHT54OOuKqS3eWaxpgJo7xUJlkAkCnsbosGfC1gq5k1jMFvN2HvoQ9Uoy4k3B
         glfvaKRbTcjfziSOgcctQqBabgNzGLPUydu4Hfvmgm3vGvP6Ph2EKGEKJqQ6bJoEQeCg
         U89A==
X-Forwarded-Encrypted: i=1; AJvYcCXTwcCii5C/AJg9bqD7DerOrmvWSjCnSeWxpLc2VKD8eQ/AxUnehkL9ZJePIJ6F6LcSvZ9kgUe45cFB63yieymUaOxt8to9
X-Gm-Message-State: AOJu0Yy8brN26O722ou/mwkbAQvti4UQaKTptpBfl6rfxUowgSWPn1XB
	WIeUokobvGzcl7MkhmdkWdUbNPhQRMmy0SUnWW5ZUW3jK52LYxN314SVFgYCjp/TPipO6mtNvVI
	rc/Pxpo5xaNLrzEUnL5fOT56JV2wCbbK0f/trTAOeIQxfCpJ8QPzHZ3I=
X-Google-Smtp-Source: AGHT+IEEKG5KDG2zoSWW6qNnRqu05lMKAibUg4qOnZ8vQWYwzP7699VIm1XVS+1Y0bh/5F72hizj+4OtuwSZsGuHD9DUTc6Tg+u5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe7:b0:375:e698:d0f3 with SMTP id
 e9e14a558f8ab-3763f49d3dfmr3279915ab.0.1719242121284; Mon, 24 Jun 2024
 08:15:21 -0700 (PDT)
Date: Mon, 24 Jun 2024 08:15:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec1f6b061ba43f7d@google.com>
Subject: [syzbot] [net?] [s390?] possible deadlock in smc_switch_to_fallback (2)
From: syzbot <syzbot+bef85a6996d1737c1a2f@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, alibuda@linux.alibaba.com, davem@davemloft.net, 
	edumazet@google.com, guwen@linux.alibaba.com, jaka@linux.ibm.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    568ebdaba637 MAINTAINERS: adjust file entry in FREESCALE Q..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12f58a61980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
dashboard link: https://syzkaller.appspot.com/bug?extid=bef85a6996d1737c1a2f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1d754ea220a6/disk-568ebdab.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/232f2545fca4/vmlinux-568ebdab.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6398bb41810d/bzImage-568ebdab.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bef85a6996d1737c1a2f@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc4-syzkaller-00875-g568ebdaba637 #0 Not tainted
------------------------------------------------------
syz-executor.1/11818 is trying to acquire lock:
ffff888023600a50 (&smc->clcsock_release_lock){+.+.}-{3:3}, at: smc_switch_to_fallback+0x35/0xd00 net/smc/af_smc.c:902

but task is already holding lock:
ffff888023600258 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1602 [inline]
ffff888023600258 (sk_lock-AF_INET){+.+.}-{0:0}, at: smc_sendmsg+0x55/0x530 net/smc/af_smc.c:2773

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (sk_lock-AF_INET){+.+.}-{0:0}:
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

-> #1 (rtnl_mutex){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       do_ip_setsockopt+0x127d/0x3cd0 net/ipv4/ip_sockglue.c:1077
       ip_setsockopt+0x63/0x100 net/ipv4/ip_sockglue.c:1417
       smc_setsockopt+0x275/0xe50 net/smc/af_smc.c:3072
       do_sock_setsockopt+0x3af/0x720 net/socket.c:2312
       __sys_setsockopt+0x1ae/0x250 net/socket.c:2335
       __do_sys_setsockopt net/socket.c:2344 [inline]
       __se_sys_setsockopt net/socket.c:2341 [inline]
       __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2341
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&smc->clcsock_release_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       smc_switch_to_fallback+0x35/0xd00 net/smc/af_smc.c:902
       smc_sendmsg+0x11f/0x530 net/smc/af_smc.c:2779
       sock_sendmsg_nosec net/socket.c:730 [inline]
       __sock_sendmsg+0x221/0x270 net/socket.c:745
       ____sys_sendmsg+0x525/0x7d0 net/socket.c:2585
       ___sys_sendmsg net/socket.c:2639 [inline]
       __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2668
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &smc->clcsock_release_lock --> rtnl_mutex --> sk_lock-AF_INET

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sk_lock-AF_INET);
                               lock(rtnl_mutex);
                               lock(sk_lock-AF_INET);
  lock(&smc->clcsock_release_lock);

 *** DEADLOCK ***

1 lock held by syz-executor.1/11818:
 #0: ffff888023600258 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1602 [inline]
 #0: ffff888023600258 (sk_lock-AF_INET){+.+.}-{0:0}, at: smc_sendmsg+0x55/0x530 net/smc/af_smc.c:2773

stack backtrace:
CPU: 0 PID: 11818 Comm: syz-executor.1 Not tainted 6.10.0-rc4-syzkaller-00875-g568ebdaba637 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114


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

