Return-Path: <netdev+bounces-149883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6749E7E43
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 06:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AB4816B926
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 05:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E960F335C0;
	Sat,  7 Dec 2024 05:10:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFB62747B
	for <netdev@vger.kernel.org>; Sat,  7 Dec 2024 05:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733548228; cv=none; b=QdelJH4kKsuTYxWRYOWZVgYub8++n2qAHE9PHgB+ZluPVNsbyXzyHWdk4zqPLOGnZmuYsks95i+WT6PC5BhEcjf6MoK678jAMlAbOCmlbQbF//BLCCGXCpVBvW5j7Iisjb3rTYsgjx8PIDhbwsgvnGfEQLcW2/5M4pASnUZ/XjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733548228; c=relaxed/simple;
	bh=et1z/KUmz8usDOn7via7XGKSBW4cSCbTg4tBkTkfDL8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=f1yZA5vb0zATvttx3YLG/Eh6W2TEr50vPSyuwD1b5S/NPiE1/M0rdwJ2j0Sv0hNgdvF2rspBfr3xBpYrsZBdVTvu4LNWMbC/6CM4bIoMVxEL3U4vSJj/Kq+p/b9ajztMx7GaK9Qb+hlJLTqTigk/B7A4J3l/UvPYXFFTry9u8Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a7de3ab182so57597145ab.1
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 21:10:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733548225; x=1734153025;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8f2I+1uZRwsWPiIe3GqMd//ZCSLDRADHYVc75cI1Ges=;
        b=TwbAFrMJS65Br57UzDFqQYrFdUSeevsHXZBI4n94TLvwS+ABXV9uSydaTcV2HTPIsZ
         C9GbtcnDvq5ETDQx2m4txjwdfF4q1Wvw3jI4jAg+F2tsaooDO6t+trIVkf2mEQyksHjk
         7stcwrDkcxFmHqOM/bplyRLnDfhBaKDVTwJCSRBTMUm9R5EfKbPaegm+X1U2BSGdal74
         4HEB0DD7BsAT0ST6NCqNSFRvaX/7S70aQ0R5CfvF437FRhtdk0Ty0R7lTvIFbFKqKN6W
         SeUM1BqeDq4SIB1g3gZajXPxxNbP8pStNu/x2zviGwUx3FDxhIBoWh/Sx2eXHPO9esjO
         GsZg==
X-Forwarded-Encrypted: i=1; AJvYcCVf3Bi/kdqPOZNscf6kOiI3w77v4f7tjzXjLexh4Kle06yeazHcfZhbt/MteFYNdkc7s2SI0Hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YylbLjy4fcj9Xdps6af+pDwF1EV6iXGw7Vud35WzuaXBI1obFBA
	jP79TgZh8PZ58HIUgSS/VArFAS5MzLQPPGfDCml3SNpfjtQgm4eFwf8SFnpAN6BR19QA+TjFW01
	oNTy9airz/lTswgi7gOvf3dOz+XYYiI+kEfYOrec/KHHvdkHta/MvI9s=
X-Google-Smtp-Source: AGHT+IHKs3Fulw6z20FvxC3nCjkPPZgRJVQIWaH8JYYw6aFE/qX9/QQo2Bpa3i3xa8SuyDIF3kNC8FJNEbCfy3s1DIQRvZNybRwh
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c5:b0:3a7:a3a4:2cb3 with SMTP id
 e9e14a558f8ab-3a811e06230mr60927205ab.15.1733548225288; Fri, 06 Dec 2024
 21:10:25 -0800 (PST)
Date: Fri, 06 Dec 2024 21:10:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6753d8c1.050a0220.a30f1.0151.GAE@google.com>
Subject: [syzbot] [net?] WARNING in NUM
From: syzbot <syzbot+3f059ffbdd539a3f6bc9@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cdd30ebb1b9f module: Convert symbol namespace to string li..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=146c8330580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6851fe4f61792030
dashboard link: https://syzkaller.appspot.com/bug?extid=3f059ffbdd539a3f6bc9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-cdd30ebb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/35bb9b3cd157/vmlinux-cdd30ebb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9c6bbf481907/bzImage-cdd30ebb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3f059ffbdd539a3f6bc9@syzkaller.appspotmail.com

Dec  3 05:04:02 syzkaller daemon.info dhcpcd[5653]: eth3: IAID d8:df:c9:55
Dec  3 05:04:02 syzkaller daemon.info dhcpcd[5653]: eth3: adding address fe80::7[   49.690919][ T6466] ------------[ cut here ]------------
f27:c3e8:bb45:52[   49.693207][ T6466] WARNING: CPU: 3 PID: 6466 at net/ipv6/ip6mr.c:419 ip6mr_free_table+0xbd/0x120 net/ipv6/ip6mr.c:419
df
Dec  3 05:04:02 [   49.710042][ T6466] Code: 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 58 49 83 bc 24 c0 0e 00 00 00 74 09 e8 c4 c5 af f7 90 <0f> 0b 90 e8 bb c5 af f7 48 8d 7b 38 e8 22 86 9c f7 48 89 df be 0f
syzkaller kern.w[   49.717312][ T6466] RSP: 0018:ffffc90003487bd8 EFLAGS: 00010293
arn kernel: [   [   49.719598][ T6466] RAX: 0000000000000000 RBX: ffff888108508000 RCX: ffffffff89ea4014
49.690919][ T646[   49.725534][ T6466] RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
6] ------------[[   49.725548][ T6466] R10: 0000000000000001 R11: 0000000000000001 R12: ffff88804e965ac0
 cut here ]-----[   49.725561][ T6466] R13: ffff888108508000 R14: ffff888108508008 R15: dead000000000100
-------
Dec  3 05:04:02 [   49.739536][ T6466] CR2: 00007f4fd5157580 CR3: 0000000035ea8000 CR4: 0000000000352ef0
syzkaller kern.w[   49.742428][ T6466] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
arn kernel: [   [   49.746956][ T6466] Call Trace:
49.693207][ T646[   49.748809][ T6466]  ? __warn+0xea/0x3c0 kernel/panic.c:746
6] WARNING: CPU:[   49.750217][ T6466]  ? ip6mr_free_table+0xbd/0x120 net/ipv6/ip6mr.c:419
 3 PID: 6466 at [   49.751877][ T6466]  ? __report_bug lib/bug.c:199 [inline]
 3 PID: 6466 at [   49.751877][ T6466]  ? report_bug+0x3c0/0x580 lib/bug.c:219
net/ipv6/ip6mr.c[   49.751908][ T6466]  ? exc_invalid_op+0x17/0x50 arch/x86/kernel/traps.c:309
:419 ip6mr_free_[   49.751922][ T6466]  ? asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
table+0xbd/0x120[   49.759463][ T6466]  ? ip6mr_free_table+0xbc/0x120 net/ipv6/ip6mr.c:419

Dec  3 05:04:02 syzkaller kern[   49.762545][ T6466]  ? ip6mr_free_table+0xbc/0x120 net/ipv6/ip6mr.c:419
.warn kernel: [ [   49.765091][ T6466]  ip6mr_rules_exit+0x176/0x2d0 net/ipv6/ip6mr.c:283
  49.696818][ T6[   49.767196][ T6466]  ip6mr_net_exit_batch+0x53/0xa0 net/ipv6/ip6mr.c:1388
466] Modules lin[   49.768971][ T6466]  ? __pfx_ip6mr_net_exit_batch+0x10/0x10 net/ipv6/ip6mr.c:285
ked in:
Dec  3 05:04:02 [   49.769038][ T6466]  setup_net+0x4fe/0x860 net/core/net_namespace.c:394
syzkaller kern.w[   49.769059][ T6466]  ? __pfx_setup_net+0x10/0x10 net/core/net_namespace.c:185
arn kernel: [   [   49.778049][ T6466]  ? __down_read_common kernel/locking/rwsem.c:1255 [inline]
arn kernel: [   [   49.778049][ T6466]  ? __down_read_killable kernel/locking/rwsem.c:1271 [inline]
arn kernel: [   [   49.778049][ T6466]  ? down_read_killable+0xcc/0x380 kernel/locking/rwsem.c:1549
49.699801][ T646[   49.781754][ T6466]  ? lockdep_init_map_waits include/linux/lockdep.h:135 [inline]
49.699801][ T646[   49.781754][ T6466]  ? lockdep_init_map_wait include/linux/lockdep.h:142 [inline]
49.699801][ T646[   49.781754][ T6466]  ? __raw_spin_lock_init+0x3a/0x110 kernel/locking/spinlock_debug.c:25
6] CPU: 3 UID: 0 PID: 6466 Comm: syz.2.106 Not tainted 6.13.0-rc1-syzkaller-00002-gcdd30ebb1b9f #0


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

