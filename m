Return-Path: <netdev+bounces-176824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38158A6C4A0
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 21:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E6C91890928
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 20:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1839F1D5174;
	Fri, 21 Mar 2025 20:52:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693711EB184
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 20:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742590356; cv=none; b=tiP/V4lFfSY6ue2y6CyaOuwYXTInrdpp7IAzSzi+1Nxs39avG7O+R7eOcRzqpcdtSBgQGxoBlweyaDbWYDy3P+DjudqCz9lLp4V4Yw7bpYGoXO9F8uT3rrkTlA3miM2m2TsyCHP8IeXOpVsKO6HU03sB7kqv0OzBFD9O0eBtaC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742590356; c=relaxed/simple;
	bh=1ruPwAFTSeUmwnybrPUf8yknRn5ZwG4995iMw4N1hEs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YZOWWxz5RWIhcNFfKyXbDjl4MzKec0j6GT/AuvlBnvlim+LnSzf4QhtXXkb8aBDF9DWhM4pj6DCyi+JeAWd0xmWZsuNGUYhfweLcRHcE6UPwxPthNa3Unelov96gUKDjOiPql0D9ubZj+kK2tXOXeF3tK1x7b2OilPlbarMGWcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d2b3a2f2d4so41023175ab.0
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 13:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742590353; x=1743195153;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9gwT2TdvYZPN5Kmw5jr9jSQgzyp4IWD+53j2MRRZdwc=;
        b=DeFLN1jYnsBBZRirUQAaH4wzIE7QP+/VoeFHDp5/TzDUSu+LmfjrN2ZJwcCESDgyPw
         bHx4YN4y1Qyj8h/tE2922F1hqBc6e25az/fPTjYPSwGUulUxtn5w3bTML9Y2lT8AnYkL
         HXaxN2Gi2skk4RoGvheCOH5Wu7zFIqPGaAOoTu95xOxJCy257KwslInYG4e2ScRAR8mv
         fsvWzAqKAQ409Ja+vlTv2fi0nc5VcWKTg23tN2KSYgYzyCN3Q3OgMAnSTlaM446rmg4j
         a/v+0er38JTokPeehYU0xAUu6NPdCMO039Lnn7n8AQx4nvJiPpBDhhMZj8vAq4N/0WLW
         /LSg==
X-Forwarded-Encrypted: i=1; AJvYcCXOVDDqNRADFDY+EblbsWdhpCeM6D5zbTQKioQvpH/SClklDL26Ot23G1MOV3xILwScNK162Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2J+f8IzoDMl+vKDeqgTQ5UQ1QMpI5NXbCFePiM3hqeCOv6BjC
	iJJyrqpJ6kXeMJhLf/iRfN9rwvHNkGoKeZOn1CDj0BHjcm7Pu0DRhhEshypFByhm7Cmxy56VQBK
	HkAjG6SB4faYMxioxaPM9OVPR+wlS/a9k1n0hgDFLOR3FlAI1ZaQXNws=
X-Google-Smtp-Source: AGHT+IHaH1Ps1Rt7vrvTvnJ199mORjTipCRHpKAnDXnM4imxujSV3NkJ1x05d7QXkE8C+uzx0OICZj2w/kTnJazY4An85doOzUIb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a0b:b0:3d4:2306:6d6 with SMTP id
 e9e14a558f8ab-3d5961944f1mr68484135ab.21.1742590353565; Fri, 21 Mar 2025
 13:52:33 -0700 (PDT)
Date: Fri, 21 Mar 2025 13:52:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ddd191.050a0220.25ae54.006b.GAE@google.com>
Subject: [syzbot] [mptcp?] WARNING in mptcp_do_fallback
From: syzbot <syzbot+5cf807c20386d699b524@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a7f2e10ecd8f Merge tag 'hwmon-fixes-for-v6.14-rc8/6.14' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=101d1e98580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27515cfdbafbb90d
dashboard link: https://syzkaller.appspot.com/bug?extid=5cf807c20386d699b524
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-a7f2e10e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d3ebf10742dc/vmlinux-a7f2e10e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ec059da4f420/bzImage-a7f2e10e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5cf807c20386d699b524@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5347 at net/mptcp/protocol.h:1202 __mptcp_do_fallback net/mptcp/protocol.h:1202 [inline]
WARNING: CPU: 0 PID: 5347 at net/mptcp/protocol.h:1202 mptcp_do_fallback+0x244/0x360 net/mptcp/protocol.h:1223
Modules linked in:
CPU: 0 UID: 0 PID: 5347 Comm: syz.0.0 Not tainted 6.14.0-rc7-syzkaller-00074-ga7f2e10ecd8f #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__mptcp_do_fallback net/mptcp/protocol.h:1202 [inline]
RIP: 0010:mptcp_do_fallback+0x244/0x360 net/mptcp/protocol.h:1223
Code: 1c cd f5 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 cb 1c cd f5 90 0f 0b 90 e9 5b fe ff ff e8 bd 1c cd f5 90 <0f> 0b 90 e9 e1 fe ff ff 89 d9 80 e1 07 fe c1 38 c1 0f 8c 1e fe ff
RSP: 0018:ffffc9000d4b75b8 EFLAGS: 00010293
RAX: ffffffff8bf4c3c3 RBX: ffff888053250930 RCX: ffff888000d7a440
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8bf4c283 R09: 1ffff1100a64a126
R10: dffffc0000000000 R11: ffffed100a64a127 R12: ffff888053250948
R13: dffffc0000000000 R14: ffff888042efd940 R15: ffff888053250000
FS:  00007f03895756c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0389574fe0 CR3: 0000000042c44000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 subflow_finish_connect+0x462/0x14e0 net/mptcp/subflow.c:548
 tcp_finish_connect+0xc4/0x620 net/ipv4/tcp_input.c:6343
 tcp_rcv_synsent_state_process net/ipv4/tcp_input.c:6573 [inline]
 tcp_rcv_state_process+0x26aa/0x44e0 net/ipv4/tcp_input.c:6794
 tcp_v4_do_rcv+0x77d/0xc70 net/ipv4/tcp_ipv4.c:1941
 sk_backlog_rcv include/net/sock.h:1122 [inline]
 __release_sock+0x214/0x350 net/core/sock.c:3123
 release_sock+0x61/0x1f0 net/core/sock.c:3677
 mptcp_connect+0x86b/0xc30 net/mptcp/protocol.c:3810
 __inet_stream_connect+0x262/0xf30 net/ipv4/af_inet.c:677
 inet_stream_connect+0x65/0xa0 net/ipv4/af_inet.c:748
 __sys_connect_file net/socket.c:2045 [inline]
 __sys_connect+0x288/0x2d0 net/socket.c:2064
 __do_sys_connect net/socket.c:2070 [inline]
 __se_sys_connect net/socket.c:2067 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2067
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f038878d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0389575038 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f03889a6160 RCX: 00007f038878d169
RDX: 0000000000000010 RSI: 0000200000000000 RDI: 0000000000000005
RBP: 00007f038880e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f03889a6160 R15: 00007ffcae617168
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

