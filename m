Return-Path: <netdev+bounces-257478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDBFDEmHhWmdDAQAu9opvQ
	(envelope-from <netdev+bounces-257478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 07:16:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2830FA991
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 07:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4E423026585
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 06:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6882ECE9B;
	Fri,  6 Feb 2026 06:16:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB93A239E9B
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 06:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770358586; cv=none; b=XjxSWgAuWir6RPXjYsbLbDnU99o7qYOaUvVjafo9G0dMgijI9MNqLcrGY78xHIKIp5hste0kgeJ20gLykVsf8yILgqxchlfHEc7wi0B5M3yQu390oXySbXw4aztxi07Gv5vZ4ueT+mzi3CCjjtHIp9xlII8DzzThyHJr83r/dDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770358586; c=relaxed/simple;
	bh=4sW91DONuEZ2nAmyynltCSmDCpZ5X/Jb4bSRstGCYfM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Tjkvl3j3nmK/BadYZcjyaliw9d5XGa9fzNrp9UoDfhQ580ifD+ZPvEUu7n2e/fsSusrzmRQjGFri4RSPhTm6uh5e8HR4nHjjS+94EPBqYxMyzSBCwJZgvwana0soxeZgIkC+59LXUSR6kXp4CrJwHQlKwq/wXld8yinBfI1+7Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-66b70fffe1dso7248536eaf.2
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 22:16:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770358585; x=1770963385;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qix4/FgbsiFhyzHPSg9byFXxtny+dN9gBCfI2BW8FMY=;
        b=fMd5qIzPQPKCkjUljnDFEY5Lj2UBb0r2w5sAOKYoU+8xQVXNKRhitkS+2X7x4SVk0o
         uiV6yuoEIHOJ39o9ugZ6Rvs/7hLRkVPlrWQY2M1rmvaBMC/2qLVi4tVDz4munaTHp84+
         PeO9PaebPING5jj4VAo1E8sCmgpQZVMaz57LIG886zDNnCmxkj34v5WUpNVCN81tds/m
         8hHuafLT4a+3/LmUBKqdi6EqdPXS8qMmCenzexfsy1RCA4MunnjtZWqC9F/kmKqZs31l
         mfQxz8RnYIuejEVW/Deqh+14V/LvR9Sr29aiWTztsU2o7NPH8jVtlgAqOD5TrhmYo/To
         E8Fw==
X-Forwarded-Encrypted: i=1; AJvYcCU7MV6/7WUzgVEmx6BK7hNRkWmPuR96j1kTJ8vEhb3dCtk0/Pug0xmXV0vTreHNW+A+XuFIbqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEG3O2MBoobiE/O+Q/azDNM87QrYNLnVR/na4M96L/Z9LmPXTF
	WvwOsBhPw3unhos8YTWFNwS24hqAbw7hgeCUr0wfHG+ZZaQ2Ytj61dUV6OCAIGHGu7Cm/U8d0Qq
	OUBP2Kac2HDK2up2877oA508z6IE6Kmw3T6ySbWhe+pQTtvl7LgexO1ELXY8=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4de8:b0:659:9a49:8eaa with SMTP id
 006d021491bc7-66d0bf9e128mr808995eaf.46.1770358584945; Thu, 05 Feb 2026
 22:16:24 -0800 (PST)
Date: Thu, 05 Feb 2026 22:16:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69858738.050a0220.3b3015.002e.GAE@google.com>
Subject: [syzbot] [smc?] KCSAN: data-race in smc_switch_to_fallback /
 sock_poll (2)
From: syzbot <syzbot+198c20fde37cb9f6b0ac@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, davem@davemloft.net, dust.li@linux.alibaba.com, 
	edumazet@google.com, guwen@linux.alibaba.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, mjambigi@linux.ibm.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sidraya@linux.ibm.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=8e27f4588a0f2183];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257478-lists,netdev=lfdr.de,198c20fde37cb9f6b0ac];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlegroups.com:email,goo.gl:url,storage.googleapis.com:url]
X-Rspamd-Queue-Id: C2830FA991
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    5fd0a1df5d05 Merge tag 'v6.19rc8-smb3-client-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1070aa5a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e27f4588a0f2183
dashboard link: https://syzkaller.appspot.com/bug?extid=198c20fde37cb9f6b0ac
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a09cd69509c3/disk-5fd0a1df.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f218ec1eb157/vmlinux-5fd0a1df.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8549229eee91/bzImage-5fd0a1df.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+198c20fde37cb9f6b0ac@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in smc_switch_to_fallback / sock_poll

write to 0xffff888127398c18 of 8 bytes by task 14369 on cpu 1:
 smc_switch_to_fallback+0x4ea/0x7e0 net/smc/af_smc.c:933
 smc_sendmsg+0xce/0x2f0 net/smc/af_smc.c:2797
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0x5af/0x600 net/socket.c:2592
 ___sys_sendmsg+0x195/0x1e0 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0xd4/0x160 net/socket.c:2681
 x64_sys_call+0x17ba/0x3000 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888127398c18 of 8 bytes by task 14367 on cpu 0:
 sock_poll+0x27/0x240 net/socket.c:1427
 vfs_poll include/linux/poll.h:82 [inline]
 __io_arm_poll_handler+0x1ee/0xb80 io_uring/poll.c:581
 io_poll_add+0x69/0xf0 io_uring/poll.c:899
 __io_issue_sqe+0xfd/0x2d0 io_uring/io_uring.c:1793
 io_issue_sqe+0x20b/0xc20 io_uring/io_uring.c:1816
 io_queue_sqe io_uring/io_uring.c:2043 [inline]
 io_submit_sqe io_uring/io_uring.c:2321 [inline]
 io_submit_sqes+0x78a/0x11b0 io_uring/io_uring.c:2435
 __do_sys_io_uring_enter io_uring/io_uring.c:3285 [inline]
 __se_sys_io_uring_enter+0x1bf/0x1c70 io_uring/io_uring.c:3224
 __x64_sys_io_uring_enter+0x78/0x90 io_uring/io_uring.c:3224
 x64_sys_call+0x27e4/0x3000 arch/x86/include/generated/asm/syscalls_64.h:427
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc0/0x2a0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0xffff88811a6056c0 -> 0xffff88811a606080

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 14367 Comm: syz.8.3658 Not tainted syzkaller #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
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

