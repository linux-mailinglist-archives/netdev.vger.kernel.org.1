Return-Path: <netdev+bounces-177966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BC0A733EA
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 15:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F613B2AC8
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 14:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7B8217659;
	Thu, 27 Mar 2025 14:09:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26E02163BB
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 14:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743084565; cv=none; b=a3Onx4cXEXM5VCh7wQZL9X2Wuasws6vDhT0PRqTavHwHJIXb4VZ2L+LpqaMzSossT+12FL2OxSm6h0ck0/tNRAQhZhJTrIO456khaA2CXV/SvVXEt97GwTdlEnTTMcVWKRqdp2k2+iignCIdPSZE+pUOkIEdwFwOfR9UtnGCZRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743084565; c=relaxed/simple;
	bh=RWuDuE5fgIAuTD9uggQMYp2kkWjsc7bWPvIMH0cW1/k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hcwcZGGYM2qDvsLWTdEN1Uc81Bze/R6xHJqU9ej61Rdkoo5exeYxmjV81lk6cKqyMUNga6xI6GwoZScwcG830WIagMyoWExSdVJ88khl0H6520Q73R3eQ6zz+zab9hYeIi9ZqCuobCoYu0ChXQS1IJVRSK2PHJoA64BnOtHqJJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d5a9e7dd5aso10865385ab.3
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 07:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743084563; x=1743689363;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4LZ7mfR7Lc9EP1nYqKnYAem0aGcyUg3E8Ey9SapUJck=;
        b=K/hkp+BA8iUXHy8ehSAEuGvZOdEBRgYy2cCZR25ZkNaeDAVxi77Nh2g65q90KUd0Lc
         QZ3YXV+l/c96zoPiRLzg9CsT6Q2EysNJSAC/DoCJftibfz2IbjCyMKzIKycZsRV/N1rR
         7BzkDDJF14MKJfVU8fl3lxgvKT2Qa6Mstg5nr2F2e1iu/aVm1WxhiafpLPS2fvHUQrLn
         IQ9zA+VGyZUMm325pKupM8sbZ4Z7832lnWuo8CnNtc7Yihn2KJE1X3zYN5gVyRtiZrfF
         8GBCmSmgZ+eADoQN0ElUsqg/4LGXpCsBd3+hwxssmPoVbUjw2Qo9moPdGy+zlznswp9Q
         vq7g==
X-Forwarded-Encrypted: i=1; AJvYcCXYUxTASIjI4zR8Gquf0uXZOOjbtipnSTHsJ8NYepIgvIfGHefIif6AscN0Mg0hW5NEkus0Ne0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnaffOe/ff28332jfAUHd1zIAPFtgWi1t+DxMqaVXZ2QFLiAu5
	G6845KfjoULwCV0b1qHIuMpm8kp8StCN8LCoftN0tE1RLr6HpX/RfU1Qm63RfBhS2U0Wsja7QF3
	TJ/8zfympsqJfxX5dakOIJuY1cHhHAgN+ZzqQ8JosAUfBNToJ+nwvJyk=
X-Google-Smtp-Source: AGHT+IHk7J352EBXlhx0rbPbcAamqA3iw7XusQRXczqxctlKg7CPQNrPQ3m6wWsEyeYOTpxlfwAuYIYSU7wU0NKSuIyavxDwU4Cs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd8e:0:b0:3d4:700f:67e2 with SMTP id
 e9e14a558f8ab-3d5ccdc95camr40598995ab.10.1743084562801; Thu, 27 Mar 2025
 07:09:22 -0700 (PDT)
Date: Thu, 27 Mar 2025 07:09:22 -0700
In-Reply-To: <67cd611c.050a0220.14db68.0073.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e55c12.050a0220.2f068f.002c.GAE@google.com>
Subject: Re: [syzbot] [x25?] possible deadlock in lapbeth_device_event
From: syzbot <syzbot+377b71db585c9c705f8e@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, eric.dumazet@gmail.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org, 
	lkp@intel.com, llvm@lists.linux.dev, ms@dev.tdt.de, netdev@vger.kernel.org, 
	oe-kbuild-all@lists.linux.dev, pabeni@redhat.com, sdf@fomichev.me, 
	stfomichev@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    1a9239bb4253 Merge tag 'net-next-6.15' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15503804580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95c3bbe7ce8436a7
dashboard link: https://syzkaller.appspot.com/bug?extid=377b71db585c9c705f8e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139a6bb0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16974a4c580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-1a9239bb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bd56e2f824c3/vmlinux-1a9239bb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/19172b7f9497/bzImage-1a9239bb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+377b71db585c9c705f8e@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.14.0-syzkaller-05877-g1a9239bb4253 #0 Not tainted
--------------------------------------------
dhcpcd/5649 is trying to acquire lock:
ffff888023ad4d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2751 [inline]
ffff888023ad4d28 (&dev->lock){+.+.}-{4:4}, at: netif_napi_add_weight include/linux/netdevice.h:2783 [inline]
ffff888023ad4d28 (&dev->lock){+.+.}-{4:4}, at: lapbeth_new_device drivers/net/wan/lapbether.c:415 [inline]
ffff888023ad4d28 (&dev->lock){+.+.}-{4:4}, at: lapbeth_device_event+0x586/0xbe0 drivers/net/wan/lapbether.c:460

but task is already holding lock:
ffff888029940d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2751 [inline]
ffff888029940d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
ffff888029940d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:39 [inline]
ffff888029940d28 (&dev->lock){+.+.}-{4:4}, at: dev_change_flags+0xa7/0x250 net/core/dev_api.c:67

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&dev->lock);
  lock(&dev->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by dhcpcd/5649:
 #0: ffffffff900fb268 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #0: ffffffff900fb268 (rtnl_mutex){+.+.}-{4:4}, at: devinet_ioctl+0x26d/0x1f50 net/ipv4/devinet.c:1121
 #1: ffff888029940d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2751 [inline]
 #1: ffff888029940d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
 #1: ffff888029940d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:39 [inline]
 #1: ffff888029940d28 (&dev->lock){+.+.}-{4:4}, at: dev_change_flags+0xa7/0x250 net/core/dev_api.c:67

stack backtrace:
CPU: 1 UID: 0 PID: 5649 Comm: dhcpcd Not tainted 6.14.0-syzkaller-05877-g1a9239bb4253 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_deadlock_bug+0x1e9/0x240 kernel/locking/lockdep.c:3042
 check_deadlock kernel/locking/lockdep.c:3094 [inline]
 validate_chain kernel/locking/lockdep.c:3896 [inline]
 __lock_acquire+0xff7/0x1ba0 kernel/locking/lockdep.c:5235
 lock_acquire kernel/locking/lockdep.c:5866 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5823
 __mutex_lock_common kernel/locking/mutex.c:587 [inline]
 __mutex_lock+0x19a/0xb00 kernel/locking/mutex.c:732
 netdev_lock include/linux/netdevice.h:2751 [inline]
 netif_napi_add_weight include/linux/netdevice.h:2783 [inline]
 lapbeth_new_device drivers/net/wan/lapbether.c:415 [inline]
 lapbeth_device_event+0x586/0xbe0 drivers/net/wan/lapbether.c:460
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2180
 call_netdevice_notifiers_extack net/core/dev.c:2218 [inline]
 call_netdevice_notifiers net/core/dev.c:2232 [inline]
 __dev_notify_flags+0x12c/0x2e0 net/core/dev.c:9409
 netif_change_flags+0x108/0x160 net/core/dev.c:9438
 dev_change_flags+0xba/0x250 net/core/dev_api.c:68
 devinet_ioctl+0x11d5/0x1f50 net/ipv4/devinet.c:1200
 inet_ioctl+0x3a7/0x3f0 net/ipv4/af_inet.c:1001
 sock_do_ioctl+0x115/0x280 net/socket.c:1190
 sock_ioctl+0x227/0x6b0 net/socket.c:1311
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl fs/ioctl.c:892 [inline]
 __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7effd384cd49
Code: 5c c3 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 76 10 48 8b 15 ae 60 0d 00 f7 d8 41 83 c8
RSP: 002b:00007ffedd440088 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007effd377e6c0 RCX: 00007effd384cd49
RDX: 00007ffedd450278 RSI: 0000000000008914 RDI: 000000000000001a
RBP: 00007ffedd460438 R08: 00007ffedd450238 R09: 00007ffedd4501e8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffedd450278 R14: 0000000000000028 R15: 0000000000008914
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

