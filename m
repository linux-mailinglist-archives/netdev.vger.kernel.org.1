Return-Path: <netdev+bounces-152532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4399F9F47E0
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 10:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E421892CBB
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 09:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBB01DF257;
	Tue, 17 Dec 2024 09:44:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBDB1DE891
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734428667; cv=none; b=Zrc3LBYZwv8h4YNRpOxu7jIeSLXkxzAq5urOL3EWsasBQNH4zo1vfxOgfWZAlLUAa0psgLG3Fr4nuvnIrMjsF6o8CtukbomDFpHNWgJC65xAjMiE1ME2oFtHx5QYb4igzYxOqiomUAoIl0S5PaXaPtn/eOatgUyh9smGrxflp0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734428667; c=relaxed/simple;
	bh=rqiaN2F9c/eaHztCDQp5l2avXEeH7niQR1KGHJpHAQw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=T3cAT1MNdNAL64NQexOPm+63ZcmDY9DNpzVORuD/nAPqWyeumuEUpzv4ATgvFPdP4EB8MdsKYmVhSYnJaRx3qhH6zoQrO1qRKt+B9YJcEhxU+/FyKOtJn3G6t/etUK/rL6saX00RyIJ6I4G/6kpEiMilNvGI5zoyLOWF8KFDELw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a7e0d7b804so52286135ab.0
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 01:44:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734428664; x=1735033464;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v3WQwo4vPQJd6wOU5xmJ0k4GDIgKmqRK46QxlMpvp1w=;
        b=obnANJLSbKatIOij9IYKMd1BDqUzT3BEViSDGen1PnY7BuP6Yzr/MfyU2KP8EN5PHt
         NUWFAdsEwWrwZZeYu7CowGrruWi0fURL8h+bHVv36GZdmbR3rCHH75xHh/ewET0fZWvh
         Ap0SNBETC9dyqqMDq0paTDj6/YhXRuAYB211AWcx1D/Pk0ZnXAosF2xR4BA26nsrL3Yy
         gk6GPa/v0yQoJcO2C+VSzpLxK2vsL/55zvr8nalAO+vKGSu6znwpBc0qk5Q9ZRcjNvs7
         b+/PIW5pB3MOpBKHS+5khTUuPq83HH6Ao/fPCBNqfWDvqZA3h5QyEPC4DUTstuq6fJm1
         mJGA==
X-Forwarded-Encrypted: i=1; AJvYcCXj0BOBBzw48Jd9+wenFPFc+pEaA6NCKvMv+WRLR2OkdbvhOAWOqMy3f/Ahc4zpLzCf4drkric=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwvTEJ2BBxlN7vkP0St8PAKcC3a7IuD7lYKdfuE3oVSza1q6Rj
	KuZ1IHj0zIcJh+bGYmsKOsVB4Z8al2Pmpf2ZxstMObnpLVOD1SM6aNyr7q/xd2j2LWGXxgif/yZ
	GYVSZz1V6zw5wuaagKBBfreb73286W9iHVfVplpC8BgPhBk/mns63KfI=
X-Google-Smtp-Source: AGHT+IHQ4sqUrdpVsm0EeJd+/GQRGdlEi6pTpHnTk0w5tBSHkrtmmW+5KhMS1bBFJ7ywzGMogW4nxA/+yfYWfmPT00M2vzWNYUfT
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e1:b0:3a7:dec1:de55 with SMTP id
 e9e14a558f8ab-3affb7daecfmr139988155ab.22.1734428664671; Tue, 17 Dec 2024
 01:44:24 -0800 (PST)
Date: Tue, 17 Dec 2024 01:44:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676147f8.050a0220.37aaf.0154.GAE@google.com>
Subject: [syzbot] [net?] WARNING: suspicious RCU usage in __ethtool_get_ts_info
From: syzbot <syzbot+a344326c05c98ba19682@syzkaller.appspotmail.com>
To: aleksander.lobakin@intel.com, almasrymina@google.com, andrew@lunn.ch, 
	corbet@lwn.net, danieller@nvidia.com, davem@davemloft.net, 
	donald.hunter@gmail.com, dtatulea@nvidia.com, ecree.xilinx@gmail.com, 
	edumazet@google.com, hkallweit1@gmail.com, horms@kernel.org, 
	kory.maincent@bootlin.com, kuba@kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, petrm@nvidia.com, 
	przemyslaw.kitszel@intel.com, richardcochran@gmail.com, 
	rrameshbabu@nvidia.com, syzkaller-bugs@googlegroups.com, 
	vadim.fedorenko@linux.dev, willemb@google.com, wintera@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bc6a5efe3dcd Merge branch 'net-timestamp-selectable'
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1309c7e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87a291e9e8ffbb16
dashboard link: https://syzkaller.appspot.com/bug?extid=a344326c05c98ba19682
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179802df980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125b34f8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0e3bb05cbd15/disk-bc6a5efe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/68f124e1efd7/vmlinux-bc6a5efe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c3e210387375/bzImage-bc6a5efe.xz

The issue was bisected to:

commit b9e3f7dc9ed95daeb83cfa45b821cacaa01aa906
Author: Kory Maincent <kory.maincent@bootlin.com>
Date:   Thu Dec 12 17:06:44 2024 +0000

    net: ethtool: tsinfo: Enhance tsinfo to support several hwtstamp by net topology

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12885730580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11885730580000
console output: https://syzkaller.appspot.com/x/log.txt?x=16885730580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a344326c05c98ba19682@syzkaller.appspotmail.com
Fixes: b9e3f7dc9ed9 ("net: ethtool: tsinfo: Enhance tsinfo to support several hwtstamp by net topology")

=============================
WARNING: suspicious RCU usage
6.13.0-rc2-syzkaller-00424-gbc6a5efe3dcd #0 Not tainted
-----------------------------
net/ethtool/common.c:873 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz-executor164/5836:
 #0: ffff888035ec8258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1617 [inline]
 #0: ffff888035ec8258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: sockopt_lock_sock net/core/sock.c:1126 [inline]
 #0: ffff888035ec8258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: sk_setsockopt+0xf0f/0x33b0 net/core/sock.c:1285

stack backtrace:
CPU: 0 UID: 0 PID: 5836 Comm: syz-executor164 Not tainted 6.13.0-rc2-syzkaller-00424-gbc6a5efe3dcd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x226/0x340 kernel/locking/lockdep.c:6845
 __ethtool_get_ts_info+0x97/0x410 net/ethtool/common.c:873
 ethtool_get_phc_vclocks+0xa1/0x160 net/ethtool/common.c:922
 sock_timestamping_bind_phc net/core/sock.c:873 [inline]
 sock_set_timestamping+0x3e2/0xab0 net/core/sock.c:927
 sk_setsockopt+0x2150/0x33b0 net/core/sock.c:1418
 do_sock_setsockopt+0x2fb/0x720 net/socket.c:2309
 __sys_setsockopt net/socket.c:2338 [inline]
 __do_sys_setsockopt net/socket.c:2344 [inline]
 __se_sys_setsockopt net/socket.c:2341 [inline]
 __x64_sys_setsockopt+0x1ee/0x280 net/socket.c:2341
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7dd7b8f2e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc67b485b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007ffc67b48788 RCX: 00007f7dd7b8f2e9
RDX: 0000000000000025 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 00007f7dd7c02610 R08: 0000000000000004 R09: 00007ffc67b48788
R10: 0000000020000040 R11: 0000000000000246 R12: 0000000000000001


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

