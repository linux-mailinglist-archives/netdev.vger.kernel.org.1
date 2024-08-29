Return-Path: <netdev+bounces-123529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A86965321
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 00:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E821C215F3
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 22:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3021BB695;
	Thu, 29 Aug 2024 22:52:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EA61BAEE8
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 22:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724971942; cv=none; b=XmiDhtoYHtQ+y6YLztAUYfoJro2XiriiTkvs0WSuN1O1S6cK9g0WbcEIPnE9fDTCHTX/XefgXD80KvwFaOdthw8/ZZW/cBnZUjA9NnmRdPVaw5JUas/V2iZDNmBMClGQ7XpSRVZl6BOk5f4WYCG/cFiBNGjlxD1S2M2neRyMoKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724971942; c=relaxed/simple;
	bh=ViWdrCt6a6K0Vj2wiEIRR3LaPMEKuEhY7asSNTKq/y8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YqTxxZRonHfZIJdsnnhx1moFdASjX9nLsxLfGQJF6lbnhanc/7NAO4lEFu2Ap4loatUJJaH9zUCJcdAnF+lwPC2diR3vDye03cv/q+bFRFWk+EjfypLAYtXUXnI1/vl+0B5P8IFP99IV4bCYVp+SechvJqE5yNUcMaCASu/b8DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82a217cec1fso96835939f.0
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 15:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724971940; x=1725576740;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bumZo3FBLWya88IH5IRSKgIMdpWcn/AV4Rx++TefK60=;
        b=eCybWHO1x6/jdbLXaLwVBiPP864r8/mT22wIAXv5ZD1bWV6CZY2PN6mMATeRy41uqv
         avPaXfuFIVhXtCGBHo0HJBVPcgm+je4+Rm9cQusUVUt9zZ3AzeJUzjpy0tbzzC8wffVc
         fd+7PoNjxC3JFbUE7pR4D2/2KPYO7RToe32gucNAEv9KLTQ7FU1sPr5BIXi/rdutVqzT
         bo3PyBc/C51UqLpLrQ2rSLzkuzfLQ1Nq0hK+FQpX9OiDp1KLzxgCEdoz2xW95B90XlaW
         CAGe/uz6Ku1+kQzfNp7BcoLqDAacFtdCEi+XYSmBN19XqMGrOVEILRTOLZjlQk6SuxPr
         mxJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg5F+K7k5xpP/XA81xXwAFNIrklqBceett/5E0XmW3YKzxRgfSgkuy6uTRJRjSt86f+9N82qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEazJB5B0U92GM23fZaPRwfh5GeCdb9mZ2VkcxdLEbZtW4ce3r
	EYIPOWR0/kIgQlgtb4cRihtpwy/B7FYi+a4nrTHH6IU0qL01Pynn1vtthMMPzhVezDdF+MI/yxu
	4S8GAbB3Y1NHtqJB/+Ux6GXGr9xaSESRpp269rURHFHMV8X2ajwVNudQ=
X-Google-Smtp-Source: AGHT+IGMVjRWPf9J8J2cG2Beb5loxdx6ExYiJMpdm+PK8UtMyNFEuSYgi+X3bNn5RcXJ7OigzZA5DkGq1PI46wNCdBe48o/kCC3t
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:892a:b0:4c2:7945:5a32 with SMTP id
 8926c6da1cb9f-4d017ee53f1mr8917173.5.1724971940197; Thu, 29 Aug 2024 15:52:20
 -0700 (PDT)
Date: Thu, 29 Aug 2024 15:52:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be46510620da5362@google.com>
Subject: [syzbot] [net?] WARNING in hsr_fill_frame_info
From: syzbot <syzbot+3d602af7549af539274e@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5be63fc19fca Linux 6.11-rc5
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=150a2d8d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8605cd35ddc8ff3c
dashboard link: https://syzkaller.appspot.com/bug?extid=3d602af7549af539274e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d1f76b980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d49305980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/13cdc3162477/disk-5be63fc1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ea315e9db653/vmlinux-5be63fc1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eb68cddf5620/bzImage-5be63fc1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3d602af7549af539274e@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5237 at net/hsr/hsr_forward.c:602 handle_std_frame net/hsr/hsr_forward.c:602 [inline]
WARNING: CPU: 0 PID: 5237 at net/hsr/hsr_forward.c:602 hsr_fill_frame_info+0x3da/0x570 net/hsr/hsr_forward.c:630
Modules linked in:
CPU: 0 UID: 0 PID: 5237 Comm: syz-executor387 Not tainted 6.11.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:handle_std_frame net/hsr/hsr_forward.c:602 [inline]
RIP: 0010:hsr_fill_frame_info+0x3da/0x570 net/hsr/hsr_forward.c:630
Code: 00 31 c0 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 55 bb fb f5 90 0f 0b 90 e9 09 ff ff ff e8 47 bb fb f5 90 <0f> 0b 90 eb 93 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c a3 fc ff ff 48
RSP: 0018:ffffc90000007278 EFLAGS: 00010246
RAX: ffffffff8b97d2c9 RBX: 0000000000000000 RCX: ffff88807529bc00
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88807d910cc0 R08: ffffffff8b97d119 R09: 0000000000000000
R10: ffffc900000073c8 R11: fffff52000000e7b R12: dffffc0000000000
R13: 0000000000000008 R14: ffff888029d04f20 R15: ffffc900000073c0
FS:  0000555564778380(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005633c816f000 CR3: 000000001faac000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 fill_frame_info net/hsr/hsr_forward.c:700 [inline]
 hsr_forward_skb+0x847/0x2b60 net/hsr/hsr_forward.c:715
 hsr_handle_frame+0x51b/0x7d0 net/hsr/hsr_slave.c:70
 __netif_receive_skb_core+0x13e8/0x4570 net/core/dev.c:5555
 __netif_receive_skb_list_core+0x2b7/0x980 net/core/dev.c:5737
 __netif_receive_skb_list net/core/dev.c:5804 [inline]
 netif_receive_skb_list_internal+0xa51/0xe30 net/core/dev.c:5896
 gro_normal_list include/net/gro.h:515 [inline]
 napi_complete_done+0x310/0x8e0 net/core/dev.c:6247
 gro_cell_poll+0x19a/0x1c0 net/core/gro_cells.c:66
 __napi_poll+0xcb/0x490 net/core/dev.c:6772
 napi_poll net/core/dev.c:6841 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6963
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 tun_rx_batched+0x732/0x8f0
 tun_get_user+0x2f84/0x4720 drivers/net/tun.c:2006
 tun_chr_write_iter+0x113/0x1f0 drivers/net/tun.c:2052
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa72/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff04a780a30
Code: 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d 71 d6 07 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
RSP: 002b:00007ffc50380778 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff04a780a30
RDX: 000000000000006a RSI: 00000000200006c0 RDI: 00000000000000c8
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
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

