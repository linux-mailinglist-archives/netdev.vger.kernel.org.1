Return-Path: <netdev+bounces-214421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDE3B29525
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 23:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FE8717C997
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 21:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBC91DE89B;
	Sun, 17 Aug 2025 21:16:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49871C862E
	for <netdev@vger.kernel.org>; Sun, 17 Aug 2025 21:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755465392; cv=none; b=IWsDviqCljJDJwTBX8TGdZUuybjf1ElaJehqbXBEhNIXryURKKjpMtlc9EIx4BddiPWpv+mpihzbx5jPj2sFVLEzADQc3pbGIJGZUm6PLqDqp2NtUPXnD/lUPs7XDQLRzskYcf8Qkr1feq5lfuYkmZZAOvPQOfXHDLWqv8P9QuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755465392; c=relaxed/simple;
	bh=cELf/5hBA7ty2DgyXFWFsQALXI6RcXSejzmDa9bZDS4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KNxSOzLdMUi3OZND7TE03lcegQrxHD7R4rzEj3jgSYzMVoeMhr+bMY4IhnE68Fp6S51D8nA7VQPVg/MuRdk2KcrXF5EBIXUYySFBRW42AtgXoDA9vweyLlmApwKWbruyQ62T3MpbtRl6fcPXWWW3ThueH1CJ070kfa9EUtXMXXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-88432e1c782so449221539f.2
        for <netdev@vger.kernel.org>; Sun, 17 Aug 2025 14:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755465390; x=1756070190;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9xOFL93V9ybpTTQzlx6ceA1J0+rEZ162D18Jclq7jEg=;
        b=DjIoK3x1attMdJHa4U9tspCvzvfQ/Mzo2QFKGtWYtviShrghe3OyHSKFNgbhWymLHJ
         U6UD3dBAyk8nhvnJQy74hynWluJ1N3mzCPqttgapgBpo7FNZJtRgAkvGtoPPn+++W3VH
         s7dTir4pp3Td5Q1uR1GpyAxazbPF8CziyynmOp2DzmEJtI5VjNCAAF7H2jA+DcKPfrj3
         tIquirX6JlqacwKH0FINtotmIJlBmyvhLM3lIdpCkzwZJTp2LPhGrYMA2X1aValAFswl
         GVL+IPLpLlu8+ssCLOO5+0z64iRx0Av+knJtvqGv0ehiOzfoMsmzgEWvzb5yCMuszuvZ
         GLBA==
X-Forwarded-Encrypted: i=1; AJvYcCUhQZAXkIcT1QO7M89HBQUMb/atmIsLwmz6ojnK3sxk4RrEf+KxC9Hd6OdfsEkc8lg0vhwgdcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWxIYA4T344rze9wzqS9aUfADS50RlQhDdwcHj0VXwl8j7EZfO
	rnv4+2IZYbPiDINVqx6nKQtZhAjFdajV98bnmsEImCaOyP6U3IhhVfEUP70Ds8843B6KlddcovT
	mBqkf1gEIgBuSDZGQ1Tdb68X/QAFXlhirNN5eaC46nGhXc9lnH3NqpeFBU2k=
X-Google-Smtp-Source: AGHT+IHUgIuGZ+mDB66y6V5ZCmackd0V6NXkrgXQ9lX0LiJJCZZTnfZRx5rCfFfCq17djZrCFyamEyqBJlpZd9B+mF/ZD+O1xtmk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d86:b0:883:f01a:5d55 with SMTP id
 ca18e2360f4ac-8843e3b9d76mr1687416939f.5.1755465389864; Sun, 17 Aug 2025
 14:16:29 -0700 (PDT)
Date: Sun, 17 Aug 2025 14:16:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a246ad.050a0220.e29e5.0077.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_tx_skb_tid
From: syzbot <syzbot+8bd4574e8c52c48c2595@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    91325f31afc1 Merge tag 'mm-hotfixes-stable-2025-08-12-20-5..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11fecda2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=412ee2f8b704a5e6
dashboard link: https://syzkaller.appspot.com/bug?extid=8bd4574e8c52c48c2595
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8c83f4baf60f/disk-91325f31.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/be959267627a/vmlinux-91325f31.xz
kernel image: https://storage.googleapis.com/syzbot-assets/68dffaf16c63/bzImage-91325f31.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8bd4574e8c52c48c2595@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 11866 at net/mac80211/tx.c:6202 ieee80211_tx_skb_tid+0x380/0x420 net/mac80211/tx.c:6202
Modules linked in:
CPU: 0 UID: 0 PID: 11866 Comm: syz.1.2132 Not tainted 6.17.0-rc1-syzkaller-00029-g91325f31afc1 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:ieee80211_tx_skb_tid+0x380/0x420 net/mac80211/tx.c:6202
Code: 9e a4 f6 e9 b1 fe ff ff e8 ed c3 c6 f6 90 0f 0b 90 e9 1f fe ff ff e8 df c3 c6 f6 90 0f 0b 90 e9 2a fe ff ff e8 d1 c3 c6 f6 90 <0f> 0b 90 e8 58 e2 fd ff 31 ff 48 8b 34 24 ba 02 00 00 00 48 83 c4
RSP: 0018:ffffc9000b697478 EFLAGS: 00010287
RAX: ffffffff8af8e7df RBX: ffffffff8af8e48f RCX: 0000000000080000
RDX: ffffc9000b7d9000 RSI: 000000000000298a RDI: 000000000000298b
RBP: 00000000ffffffff R08: 0000000000000000 R09: ffffffff8af8e48f
R10: dffffc0000000000 R11: ffffed100ebe1146 R12: ffff888054e94d80
R13: 0000000000000000 R14: 0000000000000001 R15: dffffc0000000000
FS:  00007f5035e4d6c0(0000) GS:ffff888125c1c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f53e6e5ed58 CR3: 000000007d2fc000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ieee80211_tx_skb net/mac80211/ieee80211_i.h:2409 [inline]
 mesh_plink_frame_tx+0x734/0xc10 net/mac80211/mesh_plink.c:354
 mesh_plink_deactivate+0x18e/0x2f0 net/mac80211/mesh_plink.c:410
 mesh_sta_cleanup+0x42/0x150 net/mac80211/mesh.c:171
 __cleanup_single_sta net/mac80211/sta_info.c:167 [inline]
 cleanup_single_sta+0x40f/0x660 net/mac80211/sta_info.c:192
 __sta_info_flush+0x5e4/0x710 net/mac80211/sta_info.c:1683
 sta_info_flush net/mac80211/sta_info.h:970 [inline]
 ieee80211_do_stop+0x399/0x1fb0 net/mac80211/iface.c:509
 ieee80211_stop+0x1b1/0x240 net/mac80211/iface.c:814
 __dev_close_many+0x361/0x6f0 net/core/dev.c:1755
 __dev_close net/core/dev.c:1767 [inline]
 __dev_change_flags+0x2c7/0x6d0 net/core/dev.c:9530
 netif_change_flags+0x88/0x1a0 net/core/dev.c:9595
 dev_change_flags+0x130/0x260 net/core/dev_api.c:68
 dev_ioctl+0x7b4/0x1150 net/core/dev_ioctl.c:824
 sock_do_ioctl+0x22c/0x300 net/socket.c:1252
 sock_ioctl+0x576/0x790 net/socket.c:1359
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5034f8ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5035e4d038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f50351b5fa0 RCX: 00007f5034f8ebe9
RDX: 0000200000000000 RSI: 0000000000008914 RDI: 0000000000000004
RBP: 00007f5035011e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f50351b6038 R14: 00007f50351b5fa0 R15: 00007f50352dfa28
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

