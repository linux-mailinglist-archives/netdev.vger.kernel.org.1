Return-Path: <netdev+bounces-246950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CFBCF2C05
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 10:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9618302D905
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 09:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0382D328631;
	Mon,  5 Jan 2026 09:26:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AE91AB6F1
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767605183; cv=none; b=F+/gKa5NNXs7UtBR+a/CwV8bLr0thM55juzmZN5r8IQhEu/JrCeJjO2Bg/68aZgWYuvZOkeQTa82NWiVe+RGC3cJjsTb8R0BPXx2GwZVG9b1n8oegbSCF5olh4TXobXBgoq5uHMETAN6oHx3C53g5UdjB119TTjYMutKQm99Xgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767605183; c=relaxed/simple;
	bh=fQIu8oQq4CCvOhdE1L0BpS04IoEzRDIVBSww6Y8g8wc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MXogpl1SArMJagDKizAb4ehZccAl8U0G8RRt7zqAYWKQAA5LcsJeBHYC/bTK9VuQmDv7i/v+vw95aX6GIihWrYGPIYzh5TPu35wZtZMTxxB5sffMTLEFRzZrLPluXAhqC2I7E9orazQQUC9uU8JDxMzI/uFRAHKBJAuCbOgrxtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-656c35cd5b4so15167415eaf.0
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 01:26:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767605181; x=1768209981;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZvbnzC5TWQJnGChespbgxn3gXoiyBGDD7VYNehEdvJU=;
        b=qzZ185jNtyTCVSCgyfbBoHmeOvLLEr553RGSAL/U1FXIu5QaJglCyCaWhb5Zk29mRP
         thxjr5kBpKPjtK/xCu6NHBLKqt4w2qn0Ahkg8FmxYAqHpAy24IXCeQl+gYauJf4+veG9
         wMjRsrKvcCoO2Ch6xF61ESDZ57O6aW6bqkZmFlrFWUOJKEXiQwOSYzXK8OFtLa0ozSy5
         FVJANaLn2QvlWF8AEzKDJuKQYNW1w3pPgRKxYsEW0FU7J95tAnid0t2xfBMv5/VPcGSX
         f7z26GBksFril6w1ScrgBQBAkp4EEPvQmnaK7SzY3rB3bQvWJYAHY43BXVke59sWTIEZ
         B4xA==
X-Forwarded-Encrypted: i=1; AJvYcCWFcdPPkVT1CbRZSQ20mcQdbQNAs8d9XEaI4KJLBtRVFCT875/BsS4AK5o1Qa10Ou4ncrezfpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS9EkmuxgstHBczmu+NFiJNEYotIXW/Cwqh9urVAwasllo3uKj
	uDcQINYLH5SGUH8vbTBJOH1qQhjnM/b3Y1wGuCZ9UT0SWsGgzDUhA6srNKLHC0Bwfme+oQ+ECYR
	HzCEpy2DkuMkKsMd2Ge61JX5FEIFqThspk+Xx756bgknDOjEehU0Vd6WEZNA=
X-Google-Smtp-Source: AGHT+IGCzA+58OGrP3BrprmuBMymN+/2jXlhnfiRQ1uQOPuzTisqMLqjuNrZ6mGH6ubxCD5h59ENsQjq5G0SuyvGY1mYxd1A+lcv
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:229c:b0:65c:fa23:2d04 with SMTP id
 006d021491bc7-65d0e9e7b69mr16905446eaf.13.1767605181215; Mon, 05 Jan 2026
 01:26:21 -0800 (PST)
Date: Mon, 05 Jan 2026 01:26:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695b83bd.050a0220.1c9965.002b.GAE@google.com>
Subject: [syzbot] [net?] WARNING in skb_attempt_defer_free
From: syzbot <syzbot+3e68572cf2286ce5ebe9@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3f0e9c8cefa9 Merge tag 'block-6.19-20251226' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12f11bb4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a11e0f726bfb6765
dashboard link: https://syzkaller.appspot.com/bug?extid=3e68572cf2286ce5ebe9
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1545c89a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e6089a580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-3f0e9c8c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9dd462c6c761/vmlinux-3f0e9c8c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cb19f02fe3f9/bzImage-3f0e9c8c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3e68572cf2286ce5ebe9@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: net/core/skbuff.c:7243 at skb_attempt_defer_free+0x641/0x710 net/core/skbuff.c:7243, CPU#3: syz.0.20/6099
Modules linked in:
CPU: 3 UID: 0 PID: 6099 Comm: syz.0.20 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:skb_attempt_defer_free+0x641/0x710 net/core/skbuff.c:7243
Code: 66 e6 f8 e9 5d ff ff ff e8 fc 8b 7c f8 90 0f 0b 90 e9 f0 fc ff ff e8 ee 8b 7c f8 90 0f 0b 90 e9 74 fc ff ff e8 e0 8b 7c f8 90 <0f> 0b 90 e9 95 fc ff ff e8 d2 8b 7c f8 90 0f 0b 90 48 b8 00 00 00
RSP: 0018:ffffc9000463f5a8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888053a2d180 RCX: ffffffff894256f5
RDX: ffff88802644a4c0 RSI: ffffffff89425a90 RDI: ffff888053a2d1e0
RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000001
R10: 0000000000000000 R11: ffff88802644aff0 R12: 0000000000000000
R13: 1ffff920008c7eb9 R14: 0000000000000000 R15: ffff888053a2d1d8
FS:  00007fad2f19c6c0(0000) GS:ffff8880d6bf5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fad2f19bf98 CR3: 000000002ccfd000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 skb_consume_udp+0x19f/0x250 net/ipv4/udp.c:1854
 udp_recvmsg+0x6c7/0x1350 net/ipv4/udp.c:2145
 sk_udp_recvmsg+0x9b/0x120 net/ipv4/udp_bpf.c:20
 udp_bpf_recvmsg net/ipv4/udp_bpf.c:94 [inline]
 udp_bpf_recvmsg+0x5c0/0xe40 net/ipv4/udp_bpf.c:62
 inet_recvmsg+0x625/0x6a0 net/ipv4/af_inet.c:891
 sock_recvmsg_nosec net/socket.c:1078 [inline]
 sock_recvmsg+0x1b2/0x250 net/socket.c:1100
 ____sys_recvmsg+0x218/0x6b0 net/socket.c:2812
 ___sys_recvmsg+0x114/0x1a0 net/socket.c:2854
 do_recvmmsg+0x2fe/0x750 net/socket.c:2949
 __sys_recvmmsg net/socket.c:3023 [inline]
 __do_sys_recvmmsg net/socket.c:3046 [inline]
 __se_sys_recvmmsg net/socket.c:3039 [inline]
 __x64_sys_recvmmsg+0x22a/0x280 net/socket.c:3039
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fad2e38f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fad2f19c038 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00007fad2e5e6090 RCX: 00007fad2e38f7c9
RDX: 0000000000000001 RSI: 00002000000047c0 RDI: 0000000000000003
RBP: 00007fad2e413f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fad2e5e6128 R14: 00007fad2e5e6090 R15: 00007ffd88783058
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

