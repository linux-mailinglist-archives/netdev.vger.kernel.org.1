Return-Path: <netdev+bounces-99365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC3F8D49EA
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 12:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA07A285920
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 10:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF8517C7D0;
	Thu, 30 May 2024 10:55:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A8317C7CD
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717066525; cv=none; b=EWW3lRiJjouWVF5//Mar6I3bHRTn/V6318/EMkTchsgUz7CQ/uThV57B2szFygn8MCl9HwJqfvAgJYc4HFcqLDz6Jnw69FnUqqd7E2of+1G5MTTX6JKrnga+7A7/BJ7ULqTrjd4IzpwKylSSfyCIAb9hrkZdGPyYKcYjrO1a71g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717066525; c=relaxed/simple;
	bh=yaELeGDrOMUB3UbwWb+SgvGRKxshibqFq5m30jYBxUM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=o7djfnDhoc0hktPcFFGcekXkGQno+YrifxtGxSCeu/MI2+lpO5O6mgGyuCld0WteYoqEfxJjH5KypSvgS62z5XHCmQRCMn5cdC3niFNHZvpHzoHBLN45gnKUrKZ03N1wo84iOLZotsZKd4Zp5icMZQu6+BPXkYxaUaOxOB64Dcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3748623a318so1024775ab.3
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 03:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717066523; x=1717671323;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iunsuq9ABCO5JX4UJQ3Bv8b2PefbRZOzD4N7eg1UFRw=;
        b=T0bMQTWOz7GN/jG7184xsdMB8P3KxenbymnKB5N5LgbGqo0W93XZ/bRYOItUju/4JZ
         6kysWljDXtprf3x2u4zLpiHY98uhV/dTI6msMcG9cSXoNttd+wtTz4i5jQe/A+LNaehv
         sxGi2eYSaBBqQEdo+3ocS3g053hojQ1F7zv0ThxnqUp2SnrbgxK7mUQpmR2qsTPwojYm
         AGhUEarQ2sISLRxkmvPKSBKmH0V7QNYoz601IvvBeLr+1JkFg7cCTzQIB8zjuyRrEJVP
         i7nmfNg2gzAK6npPG2wY2fSDhACuuamjESlAHAOw1NyJ21feYrYWAhOqelZB9dASqxqn
         1Cdw==
X-Forwarded-Encrypted: i=1; AJvYcCWItzlfc+TJO+xACm//UU32j/yaE3AbVgbm41QEgUf6DnRAu3FUyFd1sYZEpYmae9iT25df4/ybE0rQWZ5GFHVaqnCmaC3S
X-Gm-Message-State: AOJu0Ywkf2wZHRT98kNJ+1Mmu9+O90BV8XHWcvJfoVAy6zodfylFCb5p
	xsEWkRPNT0Hfs8rgenLyB9OfreH2M9BJKrhctL7YERMJ0TibQK87LjwYaLXMjUpJOJdbZb+2ycC
	b76vANKIQ1YNjbM2pg88RstN3e2B3pFAA1+jRSosdrgzecgRgaaHnQfA=
X-Google-Smtp-Source: AGHT+IHwn3DG8TI8c+pSOPW4SZeSIleHDtVE5X9V0Ei+ExCzUmYDOAvvnb/L1RAsPyFb/xq0pJY0a1XnF/gw4Y85v/G98R5Y99qq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1caf:b0:374:64df:681c with SMTP id
 e9e14a558f8ab-3747dfc26cdmr938955ab.4.1717066523122; Thu, 30 May 2024
 03:55:23 -0700 (PDT)
Date: Thu, 30 May 2024 03:55:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002aadc50619a9b4d5@google.com>
Subject: [syzbot] [wireguard?] INFO: task hung in wg_netns_pre_exit (4)
From: syzbot <syzbot+1d5c9cd5bcdce13e618e@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a4be1ad3a6e Revert "vfs: Delete the associated dentry whe..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14003162980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9016f104992d69c
dashboard link: https://syzkaller.appspot.com/bug?extid=1d5c9cd5bcdce13e618e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fd3b4fa0291b/disk-4a4be1ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d58e4ceaeff3/vmlinux-4a4be1ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4df89f1b7d3b/bzImage-4a4be1ad.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1d5c9cd5bcdce13e618e@syzkaller.appspotmail.com

INFO: task kworker/u8:0:11 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:0    state:D stack:20632 pid:11    tgid:11    ppid:2      flags:0x00004000
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 wg_netns_pre_exit+0x1f/0x1e0 drivers/net/wireguard/device.c:414
 ops_pre_exit_list net/core/net_namespace.c:163 [inline]
 cleanup_net+0x617/0xcc0 net/core/net_namespace.c:620
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/1:1:45 blocked for more than 144 seconds.
      Not tainted 6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:1     state:D stack:22064 pid:45    tgid:45    ppid:2      flags:0x00004000
Workqueue: events linkwatch_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752


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

