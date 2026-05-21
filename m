Return-Path: <netdev+bounces-290629-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qG22IpuND2pdNQYAu9opvQ
	(envelope-from <netdev+bounces-290629-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 00:56:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A1A5AC7C3
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 00:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D623300B1B4
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 22:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998EB368D5A;
	Thu, 21 May 2026 22:56:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F9036606A
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 22:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779404183; cv=none; b=iR45BJLmcC0TAAIu98KDnBIOctwJSvsO8JatJ48LVGAjeLVTeFgRgl8HV8a9NXTU6altp0UC1+f+ZJJI6m8AS51d80KJMU+BMsCW/VSU0rqALA+5hBuvhJhjmTq8LOZASyZv8iSm6nxW0iXcRR/h9R5NEqqTblUmfGlOGWSiIDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779404183; c=relaxed/simple;
	bh=woFJNG+AkIhIjdrUa3L5vqm1iAVDH/ulwz2H+d6Dlac=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EFsCk9fy3Xe1Q/RHBWHNDVF3uHZTMsaU/Wu3i9H09FZiHSL3Ts4k1sasJslqIzbin0qr2LufTBW6Sen+n8LYW4NRqYyP2wvy9odBFXe9P6HWh9Fb1dm3eRHBFyGStuMycQWfJ5LKKLc1gRY2ADLHp5lgA5hHYtYzY/5+uSFNY9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-4346755f7dcso12229601fac.3
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 15:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779404181; x=1780008981;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wKcggRR9OaSzW53BRXT7XgtoSulSO0zV7NnoewwOLLk=;
        b=qkyUX1Vg8vCLBHMsdr2GrxC9+nBxDRu2CDVxU88ccawIJq/LIZ13xny42o6zyI10y9
         dZGuEwUfR4DyUwYBC7ji5D8KLy83ldj9NyEtMYUGIwnjgFpbwGR204A7nukMr2au97Qi
         YcgGPe+MwOgyczXsSUEM+rWx1ezAHLZ6ZMc+EqnP4vTKkWGpXaQERDa4NO3awcv8N6P5
         ggugtqY+KZ/9+SduOVn6eedxS2Rr0P45YUjmfz+CpCynZbk1EnupTz4aUT+PAuyD18Zp
         gA0xOZe/mp7KfteB6HnI2unoi+jbPJPj94pwY0zRw54D1xTA/qUaulDg3aa7y1afKVBx
         VF4Q==
X-Forwarded-Encrypted: i=1; AFNElJ8gQzR9I1wRq9/AusSlfBbuKM9yoJ8EmssIwGSwvoAuibQMufT6QKYBG+3/0QrFTKUmOwBJ9UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLL0ZL91j6n8Br8YC0Y0Wlx8qjmgxP6xJpqzH9YnvakusdfD1U
	fS8YLwwkLi+OkRT8YJCF4EQ/mdZzfCFYz//AsVu9ZL3wHJHD43WxO9Sytqf52ae09r2QI/Ozoi0
	xn78RUp1MbM6byZqiY2t2fHc5/4SkQVq3XYRHmeJlHvipcMsNt8virn74rv0=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:998:b0:69d:7dbc:19b1 with SMTP id
 006d021491bc7-69d7ed29503mr687622eaf.55.1779404180791; Thu, 21 May 2026
 15:56:20 -0700 (PDT)
Date: Thu, 21 May 2026 15:56:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a0f8d94.050a0220.6b33c.0000.GAE@google.com>
Subject: [syzbot] [rds?] KCSAN: data-race in rds_poll / rds_sendmsg
From: syzbot <syzbot+fbf3648ae7f5bdb05c59@syzkaller.appspotmail.com>
To: achender@kernel.org, allison.henderson@oracle.com, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, rds-devel@oss.oracle.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=2e40c0f41e01837e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290629-lists,netdev=lfdr.de,fbf3648ae7f5bdb05c59];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,googlegroups.com:email,storage.googleapis.com:url]
X-Rspamd-Queue-Id: 27A1A5AC7C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    e5d505e3664b Merge tag 'trace-v7.1-rc3' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144d37ba580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e40c0f41e01837e
dashboard link: https://syzkaller.appspot.com/bug?extid=fbf3648ae7f5bdb05c59
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d01e24b29d85/disk-e5d505e3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/763a9ed109de/vmlinux-e5d505e3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aa1f01135fd4/bzImage-e5d505e3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fbf3648ae7f5bdb05c59@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in rds_poll / rds_sendmsg

write to 0xffff8881054183a4 of 4 bytes by task 9010 on cpu 0:
 rds_sendmsg+0x1001/0x15b0 net/rds/send.c:1391
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 ____sys_sendmsg+0x563/0x5b0 net/socket.c:2698
 ___sys_sendmsg+0x195/0x1e0 net/socket.c:2752
 __sys_sendmsg net/socket.c:2784 [inline]
 __do_sys_sendmsg net/socket.c:2789 [inline]
 __se_sys_sendmsg net/socket.c:2787 [inline]
 __x64_sys_sendmsg+0xd4/0x160 net/socket.c:2787
 x64_sys_call+0x194c/0x3020 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x12c/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff8881054183a4 of 4 bytes by task 9013 on cpu 1:
 rds_poll+0x9b/0x310 net/rds/af_rds.c:222
 sock_poll+0x21c/0x240 net/socket.c:1502
 vfs_poll include/linux/poll.h:82 [inline]
 __io_arm_poll_handler+0x1ef/0xbf0 io_uring/poll.c:590
 io_arm_apoll+0x2eb/0x400 io_uring/poll.c:698
 io_arm_poll_handler+0x12f/0x160 io_uring/poll.c:727
 io_queue_async+0x25d/0x320 io_uring/io_uring.c:1634
 io_queue_sqe io_uring/io_uring.c:1660 [inline]
 io_req_task_submit+0x9b/0xa0 io_uring/io_uring.c:1062
 io_handle_tw_list+0x1f5/0x230 io_uring/tw.c:72
 tctx_task_work_run+0x42/0x140 io_uring/tw.c:132
 tctx_task_work+0x3f/0x80 io_uring/tw.c:150
 task_work_run+0x130/0x1a0 kernel/task_work.c:233
 get_signal+0xdea/0xf20 kernel/signal.c:2809
 arch_do_signal_or_restart+0x96/0x480 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
 exit_to_user_mode_loop+0x6f/0x820 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x232/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00000000 -> 0x00000001

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 9013 Comm: syz.7.10555 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
==================================================================


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

