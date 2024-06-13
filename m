Return-Path: <netdev+bounces-103144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEF290680C
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 11:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763871F26021
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 09:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54F813D60D;
	Thu, 13 Jun 2024 09:01:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A46F136E00
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 09:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718269288; cv=none; b=nnf74OozXrX2dO43CeXHrSO0ESLYI6sS3EvEDez3UuP3PAuoPIeAQjPNFXnTAj5cozaMNwqN9WTRd2G+k/jhlZoBeBppXuD31szKnWDq2JAjPBn5r/lZKsyuvP+SMwV0jbWtZ/pJIdNHlZeSmAapMSNiknVJf1TeKpyCm819lPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718269288; c=relaxed/simple;
	bh=zDQfReszuaU0SBuUkzOBkGk0heHhS+XHS45L0W88biY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=P4aNlCuQj6oi0XvzzU+ZvWv1pi5z4FQWfC13Tt6Do9Jl/Q3B0QkCwX/Xz1homtz3LJMgK316B/rEUvvnZftuj32j6BLkNz2WvdBog8KQeYxqhd7A672AYPkW4Bw8jXDFonEAtCZBiv2OFUJEqVbvYA+evIijXrCGI9T+c0MwCNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7ea8fc6bd4dso71830439f.1
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 02:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718269286; x=1718874086;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jJ0P9PPpSPipQKnsMFKPK1AUyVT5U3lPgM2J/2QP/Wo=;
        b=xPZDfDP6YAZnRMUSYU8rKa5rHc9SjLIjjAt8p5CSHcmVmPly+zrkkAWzhlgpysOH3k
         N/Km99mVIJtgBA3AMhbbvgS82PDT6kF6hcEYDF4x7vaSHnFBOYPK5ar/h8A/EcmCGoh2
         CoyXQZNqZq8d4mi2Nvvj2TPlT2i5xnJ4iijEVn5yyW+Og2pWHQCX35dLvTA9XQSowOsd
         Qws30F1TrIobiZKohfsKksUgBzvejbavLOHsZT6tvl2Csw2Sr2LV6so+7on+qPF9sp9n
         N1sLx/E9367J7u8GWiOmK/G6hcizBXyjJMz1zIpV3oXDOfNafW6H3mAPEbZoDmoH67Jk
         oycQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1mNCsjjomnPg9ZvhsY6TBGhGgelv0Ji1+HDl4qnsQuiVl9wn6l1Sq9hbSP9Ulaee1BrKRzjgXyu/xc7g8oGJnmDJN9LV4
X-Gm-Message-State: AOJu0YzvCLLO+gjMQxnrwdCW/t/zNM0RxINyJfml4wdkVHrS+JyCh901
	RMGspK3BADELGRSUU3/1128yL9ys+wRUG0rgSgYowR2ifstIF+0qvDko/AAydkBf4olvdyzaWqh
	bd6udDdMyclJk4a9nOxg85la2H8Xzvn37fyleKPFymqs8l7gxUHEcuhY=
X-Google-Smtp-Source: AGHT+IHBwQ1lxfk63ByiZP5u96AF5hted6fq87tFuZWyeJs+2VhWvmsFkrTunSQyNOZ6wgL9HKIt207hEibfABtpJQCaKXT89wYc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:25c3:b0:488:e34a:5f76 with SMTP id
 8926c6da1cb9f-4b93ec0ef35mr294959173.1.1718269286392; Thu, 13 Jun 2024
 02:01:26 -0700 (PDT)
Date: Thu, 13 Jun 2024 02:01:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071b6ee061ac1be53@google.com>
Subject: [syzbot] [net?] INFO: task hung in mpls_net_exit (2)
From: syzbot <syzbot+a8b8d28a9e1a02270f42@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    83a7eefedc9b Linux 6.10-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a2c82e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c79815c08cc14227
dashboard link: https://syzkaller.appspot.com/bug?extid=a8b8d28a9e1a02270f42
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3e8762812d56/disk-83a7eefe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/29ef4962890d/vmlinux-83a7eefe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1a5e4d91d135/bzImage-83a7eefe.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a8b8d28a9e1a02270f42@syzkaller.appspotmail.com

INFO: task kworker/u8:11:2895 blocked for more than 144 seconds.
      Not tainted 6.10.0-rc3-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:11   state:D stack:22712 pid:2895  tgid:2895  ppid:2      flags:0x00004000
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x49d0 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 mpls_net_exit+0x7d/0x2a0 net/mpls/af_mpls.c:2708
 ops_exit_list net/core/net_namespace.c:173 [inline]
 cleanup_net+0x802/0xcc0 net/core/net_namespace.c:640
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/0:3:5107 blocked for more than 144 seconds.
      Not tainted 6.10.0-rc3-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:3     state:D stack:21912 pid:5107  tgid:5107  ppid:2      flags:0x00004000
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
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244


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

