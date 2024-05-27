Return-Path: <netdev+bounces-98112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B41488CF705
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 02:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F64028174A
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 00:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5292E9460;
	Mon, 27 May 2024 00:33:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31EE944D
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 00:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716770009; cv=none; b=ZiDdei2rQW9yyNJP13uqTtOWvCuffFb904eMil8TNf124+Oz9dYYSSrQOzaVe7SKEM8Zug1fq9qMMk30zor7yS6rSy1hKHT/wIEGij8CSn7ZQvGv7vGquzd/93t2MDH9zcpcdGUKT8+iO1MnGq0ZNcK1L8IEsVJVUYwyTT8EyQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716770009; c=relaxed/simple;
	bh=doHX4PzDqiSxtfhzMJePbVvn4Mof4IBeekCuJEcLnV4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cdXywXi4R5QoX+ATqQZfdVyCxZUpNOmDOqwvyPpk2JyPk4J1OO/xFtid/MBwJ1q8O6K2n7bgtilRyRsNmrpwnEByo9SCzK9e4uga0h6y43xUM5hkkAp5AEO0LDt3BzriQZWOybyKAKm44ZB+HW+WLpqy8+CgMX+rA9giNgmb0Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-36da6da1d98so50541335ab.2
        for <netdev@vger.kernel.org>; Sun, 26 May 2024 17:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716770007; x=1717374807;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j328NClK9+hNcB/FJGTyXY5OlSxScTEKHfRs1xB643s=;
        b=wUGAtJEqb5aMY0WA2khyMkePkZ0MqR+HJE0AnUEcfNq0r/BFWFi/Q1EFUO9fM/Se0A
         PUcuLNUidRzHEh+NQ3Z1NPddhkE9OcmsmkU3akmoejxjuVp/am2IMg0Du+bwSykx+jyL
         PZNJe2KT3nVLHW3yO6114NZdMq74qRl9D7M0KYN+FlcoIKG7SsLGRFUWCJ6+Wp6OImsQ
         81TA7+JUh6MOqoFBjyi0HcShTx9EoyrZiD3ioZu8bs1Gtn9viMilVvcMlxPvRClLrjDm
         3ew5N7edBGMGd1W7q91MQ6LkE0Ug65ZQNTk9lWgWguljPb9CNPo5CibuKstuGQ3RuF0M
         U1Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWd5Wlh2vpih/HiyuJAISIyHXqpq8BJC6BHebAOXYSQq/6+gvDZzorFAXd0Cw2B8ubI2ecco21t2nZLo6B5Xw0VUumKDDNl
X-Gm-Message-State: AOJu0YwoJlsYdyY2V/Gui1WXCDnhklxD47OW2eWX1bKGhg2KbbXi59OG
	ajsfsiqbx75IfdXrvaN/cWACBfE/h4ylD0WfkbhRxdy9z+Jaz2tjnnO39/Xrb35gYB8KjY3wUdU
	UGsDgD4Nea/W5pbLd0vrRKiwkZCSHfwmFcDif2n56PAW2Q1Ja4NCfmp8=
X-Google-Smtp-Source: AGHT+IEk5bcL3ZtXmZCksvX+fwWAYTQWg+Q0ZV9NkG7ADcuQmCo/JbD0Tx7yMV6vc++KMoUXf172C2sb9n0dNuLAMApNpKNHZEIT
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cb0c:0:b0:373:8b9c:66cd with SMTP id
 e9e14a558f8ab-3738b9c8a05mr2245325ab.0.1716770007155; Sun, 26 May 2024
 17:33:27 -0700 (PDT)
Date: Sun, 26 May 2024 17:33:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007018c0061964aa67@google.com>
Subject: [syzbot] [nfc?] [net?] KMSAN: uninit-value in nci_ntf_packet (2)
From: syzbot <syzbot+71bfed2b2bcea46c98f2@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, krzk@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=160b7244980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=71bfed2b2bcea46c98f2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1065f33f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13113a34980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+71bfed2b2bcea46c98f2@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in nci_rf_intf_activated_ntf_packet net/nfc/nci/ntf.c:620 [inline]
BUG: KMSAN: uninit-value in nci_ntf_packet+0x27f4/0x39c0 net/nfc/nci/ntf.c:802
 nci_rf_intf_activated_ntf_packet net/nfc/nci/ntf.c:620 [inline]
 nci_ntf_packet+0x27f4/0x39c0 net/nfc/nci/ntf.c:802
 nci_rx_work+0x288/0x5d0 net/nfc/nci/core.c:1532
 process_one_work kernel/workqueue.c:3267 [inline]
 process_scheduled_works+0xa81/0x1bd0 kernel/workqueue.c:3348
 worker_thread+0xea5/0x1560 kernel/workqueue.c:3429
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3877 [inline]
 slab_alloc_node mm/slub.c:3918 [inline]
 kmem_cache_alloc_node+0x622/0xc90 mm/slub.c:3961
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:577
 __alloc_skb+0x35b/0x7a0 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1319 [inline]
 virtual_ncidev_write+0x6d/0x290 drivers/nfc/virtual_ncidev.c:120
 vfs_write+0x497/0x14d0 fs/read_write.c:588
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 x64_sys_call+0x3062/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 PID: 3730 Comm: kworker/u8:19 Not tainted 6.9.0-syzkaller-02707-g614da38e2f7a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: nfc2_nci_rx_wq nci_rx_work
=====================================================


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

