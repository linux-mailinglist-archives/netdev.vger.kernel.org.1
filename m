Return-Path: <netdev+bounces-142474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C089BF4B1
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 18:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207B31C22551
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 17:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D02F205E11;
	Wed,  6 Nov 2024 17:58:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1FC2076DF
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730915909; cv=none; b=Z0dF19ZjfXndrbPgffd5oVY4RisYxiO9lIsx8wsMQ5jWRXBFOVc0ZSGtldiJif78lDjpUx+Ne/RqOVm+PN7/OGHhdyxOQ6rqdnyt/A4Ej67DdvlZKkKKHim5vb71Lv64f5A2TwLL27b9tm5FO/TQ8hbJ5USqMYO7oNa/uoUbRuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730915909; c=relaxed/simple;
	bh=U2fDqR5IlX4PDYKRKfLYhlEV7ULcJDVvJRq7DXO+tVY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Qv+fyLM78U6hlQsr+ESHFoMg6heeTdQWYAZzeTuiNExAZp7L4dmqOmQmJ3341uYmIg4zc7eGdybUoR8t5xJwaXy3sxsck11QxTd34VyyIKDBDtAA5+z+ElRDUlDjCZ1J0ADYpwUlluDAU85+4L6amyGhGv1hvAJOq6Gkp56+wHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6b37c6dd4so1278525ab.3
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 09:58:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730915907; x=1731520707;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNHG3iiJiCHJWpGw09OBTrXqaqsk0zUyRdHVwF9motk=;
        b=hk01wJzjM9EKUMxw7cIwPgwr9GAF8t+jKFszh9B2p+bf7zFruJVjLl+Fbr2SlKGEnm
         S5iZY9HhFMM/bIqXxDgl7YRlTWL2vycyGUHi1TX0SwE3sLeoKfJf5FuE8slMwigypeuf
         Nzs9XJ/FMTfkkhEvfoG01GLp3nLxuqDkEF57L4j99Yo9pLtON4X7PRg+qXU9BaSPAcmX
         1MyW7Lf74hSSBrQnQNzaY1GaaEmRdNKu8W8fkkCEfeGmNyPY/nLWE/lZngOH1Z0/bdiS
         CaB2yLhq2y+TloFExqAkM1Kz0tKKOtmGFKFY0ends7sWLfwMvwt/nNK7ki52adg1wcZR
         sTdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyFAzcz+ZySEAJSbQt2y4iwrBESw0l2/0miTODdB0R07xMJoCL96/pCSL8feRrIDkDmDiNojk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7iRYK9G/DuHd9k5kAo1mN8fosK6pccMx10XQaojxayySv+7mX
	Fg7nxGbLC+FzSFBrcgTWmmGsapXStnhCQGG3dxmV7ZucSs+ZWjs3BX9AdJVCg2rQwo5IZbac+Lp
	VV02SWz9Pdp84E4E/H63Liuc4uYDRHC5FOX9pFHw0J4IaaA+qt1J8wFY=
X-Google-Smtp-Source: AGHT+IFk0l9397QL9o/w8WIjBh7VbEvFsKy/kMtkZOH/SOcFSFKsaMmKk2Nmt3Gbzsjjg/1Jt9/46OTyZAdrFAhRIQhLoGOBV0E3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1568:b0:3a6:b258:fcf with SMTP id
 e9e14a558f8ab-3a6b25813e9mr222778855ab.2.1730915906754; Wed, 06 Nov 2024
 09:58:26 -0800 (PST)
Date: Wed, 06 Nov 2024 09:58:26 -0800
In-Reply-To: <00000000000035941f061932a077@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672bae42.050a0220.350062.0279.GAE@google.com>
Subject: Re: [syzbot] [net?] KMSAN: kernel-infoleak in __skb_datagram_iter (4)
From: syzbot <syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    2e1b3cc9d7f7 Merge tag 'arm-fixes-6.12-2' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1485dd5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fdf74cce377223b
dashboard link: https://syzkaller.appspot.com/bug?extid=0c85cae3350b7d486aee
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1685dd5f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10bfb6a7980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/08456e37db58/disk-2e1b3cc9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cc957f7ba80b/vmlinux-2e1b3cc9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7579fe72ed89/bzImage-2e1b3cc9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in copy_to_user_iter lib/iov_iter.c:24 [inline]
BUG: KMSAN: kernel-infoleak in iterate_ubuf include/linux/iov_iter.h:30 [inline]
BUG: KMSAN: kernel-infoleak in iterate_and_advance2 include/linux/iov_iter.h:300 [inline]
BUG: KMSAN: kernel-infoleak in iterate_and_advance include/linux/iov_iter.h:328 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_iter+0x2f3/0x2b30 lib/iov_iter.c:185
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 copy_to_user_iter lib/iov_iter.c:24 [inline]
 iterate_ubuf include/linux/iov_iter.h:30 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:300 [inline]
 iterate_and_advance include/linux/iov_iter.h:328 [inline]
 _copy_to_iter+0x2f3/0x2b30 lib/iov_iter.c:185
 copy_to_iter include/linux/uio.h:211 [inline]
 simple_copy_to_iter net/core/datagram.c:524 [inline]
 __skb_datagram_iter+0x18d/0x1190 net/core/datagram.c:401
 skb_copy_datagram_iter+0x5c/0x200 net/core/datagram.c:538
 skb_copy_datagram_msg include/linux/skbuff.h:4076 [inline]
 netlink_recvmsg+0x432/0x1610 net/netlink/af_netlink.c:1958
 sock_recvmsg_nosec net/socket.c:1051 [inline]
 sock_recvmsg+0x2c4/0x340 net/socket.c:1073
 sock_read_iter+0x32d/0x3c0 net/socket.c:1143
 io_iter_do_read io_uring/rw.c:771 [inline]
 __io_read+0x8d2/0x20f0 io_uring/rw.c:865
 io_read+0x3e/0xf0 io_uring/rw.c:943
 io_issue_sqe+0x429/0x22c0 io_uring/io_uring.c:1739
 io_queue_sqe io_uring/io_uring.c:1953 [inline]
 io_req_task_submit+0x104/0x1e0 io_uring/io_uring.c:1373
 io_poll_task_func+0x12e5/0x1620
 io_handle_tw_list+0x23a/0x5c0 io_uring/io_uring.c:1063
 tctx_task_work_run+0xf8/0x3d0 io_uring/io_uring.c:1135
 tctx_task_work+0x6d/0xc0 io_uring/io_uring.c:1153
 task_work_run+0x268/0x310 kernel/task_work.c:239
 ptrace_notify+0x304/0x320 kernel/signal.c:2403
 ptrace_report_syscall include/linux/ptrace.h:415 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
 syscall_exit_work+0x14e/0x3e0 kernel/entry/common.c:173
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:200 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:205 [inline]
 syscall_exit_to_user_mode+0x13b/0x170 kernel/entry/common.c:218
 do_syscall_64+0xda/0x1e0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 pskb_expand_head+0x305/0x1a60 net/core/skbuff.c:2283
 netlink_trim+0x2c2/0x330 net/netlink/af_netlink.c:1313
 netlink_unicast+0x9f/0x1260 net/netlink/af_netlink.c:1347
 nlmsg_unicast include/net/netlink.h:1158 [inline]
 nlmsg_notify+0x21d/0x2f0 net/netlink/af_netlink.c:2602
 rtnetlink_send+0x73/0x90 net/core/rtnetlink.c:770
 rtnetlink_maybe_send include/linux/rtnetlink.h:18 [inline]
 tcf_add_notify net/sched/act_api.c:2068 [inline]
 tcf_action_add net/sched/act_api.c:2091 [inline]
 tc_ctl_action+0x146e/0x19d0 net/sched/act_api.c:2139
 rtnetlink_rcv_msg+0x12fc/0x1410 net/core/rtnetlink.c:6675
 netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2551
 rtnetlink_rcv+0x34/0x40 net/core/rtnetlink.c:6693
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0xf52/0x1260 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x10da/0x11e0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:744
 ____sys_sendmsg+0x877/0xb60 net/socket.c:2607
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2661
 __sys_sendmsg net/socket.c:2690 [inline]
 __do_sys_sendmsg net/socket.c:2699 [inline]
 __se_sys_sendmsg net/socket.c:2697 [inline]
 __x64_sys_sendmsg+0x300/0x4a0 net/socket.c:2697
 x64_sys_call+0x2da0/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 __nla_put lib/nlattr.c:1041 [inline]
 nla_put+0x1c6/0x230 lib/nlattr.c:1099
 tcf_ife_dump+0x250/0x10b0 net/sched/act_ife.c:660
 tcf_action_dump_old net/sched/act_api.c:1190 [inline]
 tcf_action_dump_1+0x85e/0x970 net/sched/act_api.c:1226
 tcf_action_dump+0x1fd/0x460 net/sched/act_api.c:1250
 tca_get_fill+0x519/0x7a0 net/sched/act_api.c:1648
 tcf_add_notify_msg net/sched/act_api.c:2043 [inline]
 tcf_add_notify net/sched/act_api.c:2062 [inline]
 tcf_action_add net/sched/act_api.c:2091 [inline]
 tc_ctl_action+0x1365/0x19d0 net/sched/act_api.c:2139
 rtnetlink_rcv_msg+0x12fc/0x1410 net/core/rtnetlink.c:6675
 netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2551
 rtnetlink_rcv+0x34/0x40 net/core/rtnetlink.c:6693
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0xf52/0x1260 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x10da/0x11e0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:744
 ____sys_sendmsg+0x877/0xb60 net/socket.c:2607
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2661
 __sys_sendmsg net/socket.c:2690 [inline]
 __do_sys_sendmsg net/socket.c:2699 [inline]
 __se_sys_sendmsg net/socket.c:2697 [inline]
 __x64_sys_sendmsg+0x300/0x4a0 net/socket.c:2697
 x64_sys_call+0x2da0/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable opt created at:
 tcf_ife_dump+0xab/0x10b0 net/sched/act_ife.c:647
 tcf_action_dump_old net/sched/act_api.c:1190 [inline]
 tcf_action_dump_1+0x85e/0x970 net/sched/act_api.c:1226

Bytes 158-159 of 216 are uninitialized
Memory access of size 216 starts at ffff88811980e280

CPU: 1 UID: 0 PID: 5791 Comm: syz-executor190 Not tainted 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

