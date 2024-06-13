Return-Path: <netdev+bounces-103365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B204907BBE
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 20:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 107A01C233F1
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 18:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FEE14B064;
	Thu, 13 Jun 2024 18:48:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E02A139CFE
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 18:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718304502; cv=none; b=nuYhwKxzaxWHzJTYBv72GNV91+FrqyvmXs9XLUvoOzAA8DE6ymWSB0bCRgcb7ZVpYHTb4LAVaIIYJt/IvbMJtRZXhD4G161nLv463AcmxOL9zPLKIeeOEKefA7BO9Ccv2lYpTelXl419McNb3HitRPofFuQsLg30wvzKbxaT5FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718304502; c=relaxed/simple;
	bh=wx3k+i3agiHH4+ORkqU7DyofWGzMTOiicsO35nuhukc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LkxCn8jqQO7ZS6EGt+o9Dt6hWAOlYKFOs8rv3f4QIf+HZRIjgypF90HcZH/fqAiK7IScr6Wu2IseVd4YiddoDR8Vo90NkPlYG310RsLa2CzJ3gojP3aZZ/QvOqjyNBMknOcEFgOeAozoZf0AFLQkbtLO567pt1KpCtXOig7/6Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-375cf040949so12799185ab.1
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 11:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718304500; x=1718909300;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DvpztZBo2tX9vOs/pwnVvpMkIdjcMdrXY9Ek/ytdwpY=;
        b=D6FlTxYkEBqYrDGQJ/dkO/UtRb66Z/huluS6VhU4Tc0KQo31GsrlkoASnbIVVnOXjv
         /1fLSAsc+xicYHWJzTEQ0le23ZRiQcwfDFm6ePTK0rsEe5GWykFvqAoFqM467/5x50lH
         3gLjNh6l4tf8+xN8YLG/l/BbGGsIPfVKzFUoxvKG/mwPG0I/CMFghk+x2Y3cPco79Opm
         A1qx34Uthy3icdAgcOZsglFqicsZ9rsMDzjLo5kZS0ZI9sZVY/M9wPUwpOJ00BsLLvTw
         ox6VRDwAXdjuId/FaY+91QL0j4fmaZUU4L6EiyUio+mGS8odrPrimkvRnmsbRfSZc5kN
         OSMA==
X-Forwarded-Encrypted: i=1; AJvYcCUOaRpUMuDCuHAU6H2zT03eOsKmkDHmUgXuIc8PCLeYH+nH0+5dFUcIaT/cprc1UEu0DlSrbR7SjEU60a0lryw12u9WrwtD
X-Gm-Message-State: AOJu0YzDP3EAN3CnS8eAXeDyE9nIzg/bXVUzDjiGyTEyvfPq/BHagXSI
	xY/7vqIKMLCkMYtuhX6w59kWCmiefCdRgl1Gs2G0b2RQoN7Jp9DOqROswiHeXrs/zVscDG+VfP2
	4iCsP4dJznsXNcyLjUp2Nct0QdoppVSOpQZiFthPlYS60RWhRPBuwRks=
X-Google-Smtp-Source: AGHT+IFbHtnRQArLIorwEZreB5TSpsVZE9Cz+SF/xb1dkqf8JeuT4e67I4k7yavL8KXqI9nRmCNQ2XoSLEbwcqk6XIjp8Z3IRhaL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164e:b0:375:a40f:97d1 with SMTP id
 e9e14a558f8ab-375e0ec20dcmr310605ab.4.1718304499749; Thu, 13 Jun 2024
 11:48:19 -0700 (PDT)
Date: Thu, 13 Jun 2024 11:48:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000052e5c5061ac9f158@google.com>
Subject: [syzbot] [net?] INFO: task hung in devinet_ioctl (5)
From: syzbot <syzbot+78761e13e81f4bfbb554@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    83a7eefedc9b Linux 6.10-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e752e2980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c79815c08cc14227
dashboard link: https://syzkaller.appspot.com/bug?extid=78761e13e81f4bfbb554
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3e8762812d56/disk-83a7eefe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/29ef4962890d/vmlinux-83a7eefe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1a5e4d91d135/bzImage-83a7eefe.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+78761e13e81f4bfbb554@syzkaller.appspotmail.com

INFO: task dhcpcd:4751 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc3-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:dhcpcd          state:D stack:20384 pid:4751  tgid:4751  ppid:4750   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x49d0 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 devinet_ioctl+0x2ce/0x1bc0 net/ipv4/devinet.c:1101
 inet_ioctl+0x3d7/0x4f0 net/ipv4/af_inet.c:1003
 sock_do_ioctl+0x158/0x460 net/socket.c:1222
 sock_ioctl+0x629/0x8e0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f583bfd7d49
RSP: 002b:00007ffe78ed73c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f583bf096c0 RCX: 00007f583bfd7d49
RDX: 00007ffe78ee75b8 RSI: 0000000000008914 RDI: 0000000000000018
RBP: 00007ffe78ef7778 R08: 00007ffe78ee7578 R09: 00007ffe78ee7528
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe78ee75b8 R14: 0000000000000028 R15: 0000000000008914
 </TASK>
INFO: task kworker/0:5:5155 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc3-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:5     state:D stack:22384 pid:5155  tgid:5155  ppid:2      flags:0x00004000
Workqueue: events linkwatch_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x49d0 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 linkwatch_event+0xe/0x60 net/core/link_watch.c:276
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147


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

