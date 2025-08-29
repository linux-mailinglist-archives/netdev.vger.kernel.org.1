Return-Path: <netdev+bounces-218357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4915B3C290
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 20:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EFB2585A44
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 18:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC42343D7E;
	Fri, 29 Aug 2025 18:38:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4E233EAF6
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756492718; cv=none; b=WPNDhRr4owke7S1mv3skSteSiQGAuiAsj0I9JAbfAU/Fq5l8u1GXKI8WH3iwkRRT8eI596kAe1b7+oOtecgduZeiGfYBtSrUobSBrgC5eDrU9NDPzYgWJXUf/y9IvoJNV/8XWw1lluEQWpfjaZtoIZ2OYY6E2QfLGrHk9rOoZeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756492718; c=relaxed/simple;
	bh=bxYU3lAwVWUq/j1z6PuiS1V6Z0be7VHuXK6LhWYyDdc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VanFTocf/4/Q4J7VcxvcZ28I1u0FP2vcrBgcs1batBY54HfZkSdgibmTH2BNONEWpnKp6hLLcxE7o1iuGHp5wgI6G7sW9TAK93pHzsV5bUuaN8vgBSzLrj0ugs8zQ+nF9ny1U7+hiaNDTHqm/Rp4Y5babKE1HUn4AJYSb8frxBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-8871591fe4bso171337839f.0
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 11:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756492715; x=1757097515;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1mUCN86lHyS9ny7AYWou8w/wgX7sPRB/RXHvhpvqEJY=;
        b=J0ZvTJfp4DH0zP4ch1nbF7P8Y8EuWQ9BSwcOMzltT47mdaLPWlMCKWB5eADlLJkUOV
         xOcUnK7GwyNdymucrb8NWzp0RPOP+L0Ltz/c+hPDXhJIYiuJzEdCAds6tFCrBtD2WAM0
         xStZ0Ce5kz/p7CnUfC+9AKucRolWiYSEAUtnQ58Tdh5ClheGHuiysswdgse5WxX5ydGk
         wXwYcPByH/RZenPXc/0dqUW7U6S9q0Ue8KyTFOJhd6gz1vF2zE0xZAu70dpLyg7FKwIQ
         Aef6H3ww/T9+vBlABxQzIwQofOw27R88wqt7tf1bzYgglmLL8VOI3Fzrxq+1jcFKE3r4
         r3sw==
X-Forwarded-Encrypted: i=1; AJvYcCXZVkbQE9Lg4CHvAkN3VwtgQh+TC22mRTx7zdTVYDDbKbC5MA1pGChvPe5uukkIwTdKAGbFNb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjJhregEFFk59p8wzQU0qPT+S2SiN41NzQ9QZA5D9Vu9CHA10/
	r6LVsKi4PCxeVpVzBkgKB+lQ3tpDyolLSCZStcn1lwdQTd+vLhK9ALwS52HD9g2fqJLpij4usPj
	R2iAFqEgEmG5uO2L83mwdIMEC6fa/ZPnmgIdiDfQAOraZrS6jIqbm3h8yeAA=
X-Google-Smtp-Source: AGHT+IHOSK2Gtuv7lgkQ0yws/v+BrIPsOgECsYL9UsCOrNNwlCdp9OXsrAstAdlk9UdCvhpeeApwQmGiH06Bu4rKqncGySlV7dtj
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:450d:b0:3f3:bbda:d037 with SMTP id
 e9e14a558f8ab-3f3bbdad456mr7014305ab.26.1756492715728; Fri, 29 Aug 2025
 11:38:35 -0700 (PDT)
Date: Fri, 29 Aug 2025 11:38:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b1f3ab.a70a0220.f8cc2.00ef.GAE@google.com>
Subject: [syzbot] [net?] [usb?] WARNING in rtl8150_start_xmit/usb_submit_urb
From: syzbot <syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, petkan@nucleusys.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7fa4d8dc380f Add linux-next specific files for 20250821
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12891634580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae76068823a236b3
dashboard link: https://syzkaller.appspot.com/bug?extid=78cae3f37c62ad092caa
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14538262580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16891634580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/63178c6ef3f8/disk-7fa4d8dc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c5c27b0841e0/vmlinux-7fa4d8dc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9a8832715cca/bzImage-7fa4d8dc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com

------------[ cut here ]------------
URB ffff888057dae700 submitted while active
WARNING: drivers/usb/core/urb.c:379 at usb_submit_urb+0xfc1/0x1830 drivers/usb/core/urb.c:379, CPU#1: kworker/1:6/7756
Modules linked in:
CPU: 1 UID: 0 PID: 7756 Comm: kworker/1:6 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: mld mld_ifc_work
RIP: 0010:usb_submit_urb+0xfc1/0x1830 drivers/usb/core/urb.c:379
Code: 44 89 f2 e8 51 7c f5 f9 e9 13 fc ff ff e8 87 69 89 fa c6 05 e0 ba 97 08 01 90 48 c7 c7 c0 6f 56 8c 48 89 de e8 50 09 4d fa 90 <0f> 0b 90 90 e9 b7 f0 ff ff e8 61 69 89 fa eb 11 e8 5a 69 89 fa bd
RSP: 0018:ffffc9000b70f010 EFLAGS: 00010246
RAX: 0218107c34ac3b00 RBX: ffff888057dae700 RCX: ffff888021ab5a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1c7a604 R12: dffffc0000000000
R13: ffff888032a8a002 R14: ffff888057dae708 R15: 0000000000000820
FS:  0000000000000000(0000) GS:ffff8881258c4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6072c44a90 CR3: 000000000e338000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 rtl8150_start_xmit+0x2cb/0x5f0 drivers/net/usb/rtl8150.c:696
 __netdev_start_xmit include/linux/netdevice.h:5222 [inline]
 netdev_start_xmit include/linux/netdevice.h:5231 [inline]
 xmit_one net/core/dev.c:3839 [inline]
 dev_hard_start_xmit+0x2d7/0x830 net/core/dev.c:3855
 sch_direct_xmit+0x241/0x4b0 net/sched/sch_generic.c:344
 __dev_xmit_skb net/core/dev.c:4114 [inline]
 __dev_queue_xmit+0x1857/0x3b50 net/core/dev.c:4691
 neigh_output include/net/neighbour.h:547 [inline]
 ip6_finish_output2+0x11fb/0x16a0 net/ipv6/ip6_output.c:141
 NF_HOOK+0x9e/0x380 include/linux/netfilter.h:318
 mld_sendpack+0x8d4/0xe60 net/ipv6/mcast.c:1860
 mld_send_cr net/ipv6/mcast.c:2159 [inline]
 mld_ifc_work+0x83e/0xd60 net/ipv6/mcast.c:2698
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x47c/0x820 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

