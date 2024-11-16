Return-Path: <netdev+bounces-145599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 742319D0081
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 19:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B47AB2499F
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 18:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BDE1957F4;
	Sat, 16 Nov 2024 18:32:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C7F18C91F
	for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 18:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731781949; cv=none; b=afiqFBew+tCbLmLR/FR3Cs8+AquD34CtkSwfcBcXbvlJlDGrx8ziruj1EDFh66ROG6gPtJYagy9aK9QvzbH866X0UDd6h1Z5GBFVbyeKfOTdN7pNjrdqXJ3rNetemTyvDE+I8+qa/5K7barNVSQkBtXhsbF+UffJXZyYr216j4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731781949; c=relaxed/simple;
	bh=mlB0+thn19nCuu7bVxLlqBKuRmMSG4g4oTMX2iUi41s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GIErj/rg4hfkxIJRgHP7uvDK7oHvHOO4LSwjI6t0Ojd2adZEnLgamgFCbhZ1KbSk8jT18HT/pBnbQ8acvM6jBHdU5a9YH1EkIAOY2Qm8++LaVkqueqVqH1sx7N1IUJnTjDwkt81a0sIB9Qo0ce/YBKlj3NfaX5ux7zVIqYX4FKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a5b2ec15a9so7331085ab.3
        for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 10:32:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731781946; x=1732386746;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xfePePTsXYhBX39P9elCNwfVWb5sKbJgwAbl39C7W5Q=;
        b=pYCMrlmby0a87/LxnIlUHu6KPPb3MChoflJCPwdmtyETkFraR+mItvOccJiRUZ1JT1
         kUUlRtX6BsLCWEo04/ck43f+04hKQEpUBGY4O2igsZsEIZSLl4pEllVwulkol5VTSaxk
         UbdNFBlqz8kA25ZAGA07yDLnBIxgokaiMoI+qslOzJXQAqYy9xH1KTKWIMZdvXcrEjyS
         yzK9msonriIsCfpmgJxBRUOp72k1iIt11gJfI+RQQgJyZr6GuYUwsXEuxyBy24pI9Oq9
         BvSFNK0LvyMhXFZX1z0p3w9Pu7TG2woOPcicaugLUerP3Qh0903lMuaUikBopYD2llqS
         j3/g==
X-Forwarded-Encrypted: i=1; AJvYcCVnHmwVS/SeHhzfCESPrdKF5MFnp+WqHBfVrnL6q1FaL9aBXoVgvV2P4SEfGXuW0VHsygx3qfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx35/hoXVLrR0Vq6qcRU3sRjF7lRRU9VIs6l0LP3dfu316QYKie
	VK1fAIGdmgSG0OoHfJNct/djzHei2HlGQHVqda8p5gD+DMOCDd3uyoOJxyqDZ1KybJ5GANzucAz
	8nOot9VulvovhuETiN4LfVWBDimWr+qTYjoBDmc0n0FZ3tM+xCbXrdkk=
X-Google-Smtp-Source: AGHT+IH5zsJbo7kUAodC0qUZi4w5wICKVzNYKcoIEvFzES9l/os3tvmiytos6O8rUa0AZi+fkVAsQWqx5o0NxU5XOvi+07IUEkxY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b43:b0:3a7:1b96:220f with SMTP id
 e9e14a558f8ab-3a7480417e3mr59740755ab.9.1731781945870; Sat, 16 Nov 2024
 10:32:25 -0800 (PST)
Date: Sat, 16 Nov 2024 10:32:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6738e539.050a0220.e1c64.0002.GAE@google.com>
Subject: [syzbot] [net?] WARNING in sk_skb_reason_drop
From: syzbot <syzbot+52fbd90f020788ec7709@syzkaller.appspotmail.com>
To: davem@davemloft.net, dongml2@chinatelecom.cn, dsahern@kernel.org, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, menglong8.dong@gmail.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a58f00ed24b8 net: sched: cls_api: improve the error messag..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=140a735f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47cb6c16bf912470
dashboard link: https://syzkaller.appspot.com/bug?extid=52fbd90f020788ec7709
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132804c0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f481a7980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d28dcea68102/disk-a58f00ed.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8ec032ea06c6/vmlinux-a58f00ed.xz
kernel image: https://storage.googleapis.com/syzbot-assets/da9b8f80c783/bzImage-a58f00ed.xz

The issue was bisected to:

commit 82d9983ebeb871cb5abd27c12a950c14c68772e1
Author: Menglong Dong <menglong8.dong@gmail.com>
Date:   Thu Nov 7 12:55:58 2024 +0000

    net: ip: make ip_route_input_noref() return drop reasons

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10ae41a7980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12ae41a7980000
console output: https://syzkaller.appspot.com/x/log.txt?x=14ae41a7980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+52fbd90f020788ec7709@syzkaller.appspotmail.com
Fixes: 82d9983ebeb8 ("net: ip: make ip_route_input_noref() return drop reasons")

netlink: 'syz-executor371': attribute type 4 has an invalid length.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5842 at net/core/skbuff.c:1219 __sk_skb_reason_drop net/core/skbuff.c:1216 [inline]
WARNING: CPU: 0 PID: 5842 at net/core/skbuff.c:1219 sk_skb_reason_drop+0x87/0x380 net/core/skbuff.c:1241
Modules linked in:
CPU: 0 UID: 0 PID: 5842 Comm: syz-executor371 Not tainted 6.12.0-rc6-syzkaller-01362-ga58f00ed24b8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:__sk_skb_reason_drop net/core/skbuff.c:1216 [inline]
RIP: 0010:sk_skb_reason_drop+0x87/0x380 net/core/skbuff.c:1241
Code: 00 00 00 fc ff df 41 8d 9e 00 00 fc ff bf 01 00 fc ff 89 de e8 ea 9f 08 f8 81 fb 00 00 fc ff 77 3a 4c 89 e5 e8 9a 9b 08 f8 90 <0f> 0b 90 eb 5e bf 01 00 00 00 89 ee e8 c8 9f 08 f8 85 ed 0f 8e 49
RSP: 0018:ffffc90003d57078 EFLAGS: 00010293
RAX: ffffffff898c3ec6 RBX: 00000000fffbffea RCX: ffff8880347a5a00
RDX: 0000000000000000 RSI: 00000000fffbffea RDI: 00000000fffc0001
RBP: dffffc0000000000 R08: ffffffff898c3eb6 R09: 1ffff110023eb7d4
R10: dffffc0000000000 R11: ffffed10023eb7d5 R12: dffffc0000000000
R13: ffff888011f5bdc0 R14: 00000000ffffffea R15: 0000000000000000
FS:  000055557d41e380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056519d31d608 CR3: 000000007854e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kfree_skb_reason include/linux/skbuff.h:1263 [inline]
 ip_rcv_finish_core+0xfde/0x1b50 net/ipv4/ip_input.c:424
 ip_list_rcv_finish net/ipv4/ip_input.c:610 [inline]
 ip_sublist_rcv+0x3b1/0xab0 net/ipv4/ip_input.c:636
 ip_list_rcv+0x42b/0x480 net/ipv4/ip_input.c:670
 __netif_receive_skb_list_ptype net/core/dev.c:5715 [inline]
 __netif_receive_skb_list_core+0x94e/0x980 net/core/dev.c:5762
 __netif_receive_skb_list net/core/dev.c:5814 [inline]
 netif_receive_skb_list_internal+0xa51/0xe30 net/core/dev.c:5905
 netif_receive_skb_list+0x55/0x4b0 net/core/dev.c:5957
 xdp_recv_frames net/bpf/test_run.c:280 [inline]
 xdp_test_run_batch net/bpf/test_run.c:361 [inline]
 bpf_test_run_xdp_live+0x1b5e/0x21b0 net/bpf/test_run.c:390
 bpf_prog_test_run_xdp+0x805/0x11e0 net/bpf/test_run.c:1318
 bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4266
 __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5671
 __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5758
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f18af25a8e9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffee4090af8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f18af25a8e9
RDX: 0000000000000048 RSI: 0000000020000600 RDI: 000000000000000a
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


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

