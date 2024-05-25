Return-Path: <netdev+bounces-98061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9F78CEEC5
	for <lists+netdev@lfdr.de>; Sat, 25 May 2024 13:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A371F213BF
	for <lists+netdev@lfdr.de>; Sat, 25 May 2024 11:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF0239FE5;
	Sat, 25 May 2024 11:48:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6FE31A83
	for <netdev@vger.kernel.org>; Sat, 25 May 2024 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716637704; cv=none; b=BmNYBXHe1E0h+GPkT4rbbLSmnKl7yQYpUMzgq0P5mK/JZEDFT9NNrYPphHSMdmDQIPcFKAY1pkC89KvDolVxOIHHZkt7m0CygvVoGtueGKEIlHA1Wk/l3Oeq826y2HJPd1CFu23jx/ePZsVOmrbVR3dJhUGI+1fVFd4EyGSNLLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716637704; c=relaxed/simple;
	bh=0qbYg6aOqdNGPthjuPeNfOsUkCVqJnS1vSrM7z/Xv4I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Am2Js5mCM5BWZHqyD0i9EG8F8tX91bpGeiVP1vSmV0tigKw2jypE1IkfbGGVW/oJ3mJ3OyUVvKa1hxvmx/BP1fY8uGdIvZgxMzOx/Nbgm2YTze5+IuUiFijwNEYHCB097LqDcWQ0W/olWusCXd6Ac67/bkENcuMpX7yElAy0/Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3737b3276a0so19357345ab.3
        for <netdev@vger.kernel.org>; Sat, 25 May 2024 04:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716637702; x=1717242502;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ktky9nzPSQla9DzbbACpPeWbHWXchC8XncDgsXpz46k=;
        b=F+TMCvqdeBKFbwtRhYXQGO8h2cvbuY6kk3CWpQz3ypoXOlmGxq4jMJcAu85B2FJuIs
         J6uyZZFo6qzfkOJQA5HRxU8FA+rJW96FtiH2qk3ZArrBFfoRN6x8HT4F6Vq7mXoMpb/Y
         WnqZD9Lo6u6Gd9AF+oyMot7stbP63yA2WFMdLDo5ihFyJ9oxirKFsgCayaW7xSkdjO3N
         WbmjPPEgjtqRKtOdF02r9xc0bqrn3hpEwBq9Awp+b7ZTJqvAZ1Qy3mEahor9d2/l+JAG
         eRKKWTHoziAY5SzqIlxUnOyE7vsh8oReu5dnkb89oE8KOqR1P6rec4JM7s0EVlNcCh6i
         snPg==
X-Forwarded-Encrypted: i=1; AJvYcCWtHV+ZThwUIOhpznMbyOmj2JZxKONbR4RpdMNzke9BuJ2+WL0GbivcbIajmAKf63z3HWdzw1xX4AjE1vzeN2QVhpSFikZc
X-Gm-Message-State: AOJu0YzGEAK4cGr2kt2nXaMBrQtYXYMUKQX5DcLLFed7aU3YRKcMJEl3
	Qqvs3a7Fd5y2NPtcsH9BAJdmMdmnfuwiSgV7aWNw2e4rJ2uFNeDiWX2wSVIs8vGURnKz/Ac6aEF
	b7RqKf95lIrH9L2xXWPivgrXdafXOWR5ONH63s78CJedPJ4E6lroHCtk=
X-Google-Smtp-Source: AGHT+IGe8h11cGjjZ/CIXvDVFFpXTvnx6rQVT5A5q3eStHc8rVFExwNMB7uUTqrJn4pa+s0Y7nGEwLfY3g11+x4u1p2Qpo0nx90g
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c566:0:b0:36c:5228:462 with SMTP id
 e9e14a558f8ab-3737b31cb5fmr3359085ab.3.1716637702796; Sat, 25 May 2024
 04:48:22 -0700 (PDT)
Date: Sat, 25 May 2024 04:48:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007bc4a8061945dc37@google.com>
Subject: [syzbot] [wireless?] INFO: task hung in regdb_fw_cb
From: syzbot <syzbot+9d8f809bfaab2e794297@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f6a15f095a6 Merge tag 'cocci-for-6.10' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12363a34980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6be91306a8917025
dashboard link: https://syzkaller.appspot.com/bug?extid=9d8f809bfaab2e794297
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/02867060d65d/disk-8f6a15f0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4bb75fbf6fb1/vmlinux-8f6a15f0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fd38cadddf33/bzImage-8f6a15f0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9d8f809bfaab2e794297@syzkaller.appspotmail.com

INFO: task kworker/0:2:927 blocked for more than 143 seconds.
      Not tainted 6.9.0-syzkaller-10323-g8f6a15f095a6 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:2     state:D stack:23760 pid:927   tgid:927   ppid:2      flags:0x00004000
Workqueue: events request_firmware_work_func
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x1796/0x4a00 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 regdb_fw_cb+0x82/0x1c0 net/wireless/reg.c:1017
 request_firmware_work_func+0x1a4/0x280 drivers/base/firmware_loader/main.c:1167
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/0:5:5157 blocked for more than 143 seconds.
      Not tainted 6.9.0-syzkaller-10323-g8f6a15f095a6 #0


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

