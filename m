Return-Path: <netdev+bounces-209301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C07B0EF6F
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 12:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 730D83A160B
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4055628FFDE;
	Wed, 23 Jul 2025 10:09:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7753728FA87
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 10:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265372; cv=none; b=ojDP5HhbsHlvTkxygQec4s+ow2wseGOlTg+D2mKsI7OLy5SLAz3yyXAcd3+l/+g0SHTw/n5UCM0S9PmiY2eM+PRilatN8m/flyxp538EHp99haahno1iHuUGUXl2Ww3lieQDIPHBLmXvUbDjnsgNOBHKv93bZIFXJFcUhA5lhn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265372; c=relaxed/simple;
	bh=FodX8F9Oi2GSeNREkWkr0lf3vk0qCR0laJz590G6kMs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sIVj0iXqn6C4E/V2cVqtqPlPQg2vaJ0VziNYJCY9lttIJBnYuIFwl+I1qpxKvWeoeIkem4WHq0Lx6oq01hCOdgkPZUWBC2mDJzPfc34DnIyfuG+9pKO6n/fub3VEL90O5B87GOlaclcM+1ASNOW2DW6cB8r+jZq4Q6BtNqXA4yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-879c1688420so100929539f.0
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 03:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753265369; x=1753870169;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CqgK15jyLtDdlPezel9tKJH2qIMmyug0dFZIUHXDQ+0=;
        b=r40k4MhQgGygfBorDhTGZvwM91pghjYdbRlqQ20gYF1Z1bMDZxT53ToGWAh6vbrkv8
         06ESAUbZeTlU+SyY9N+OyqDbAKPI8XRMYrHDBF5ifolDIPY2cVjaWeBtRfni9+onv47B
         h8N+9ojCoqKwW9AIMSEfqDyBasSZvLTLAPYjkgMDEkPYRRCmsm2S7TJu2DEbb1AxNkv+
         kJ5QIENYFqOhNmrMRjJan5rCtrN1aN4wsyL+dVaTUFMTZ6R9DUTRG3UX3zWr0u0UKtns
         U48BM/NDcukKm+RmfVarnIQE8jwzLT7YFCC2ARzzCyAosSygt7e3wguwuoABkhuh99LJ
         MMPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAZ7CJWPSSJeLmYvobLWi81slwdjrlwCG17xGlEzHcqbUzFxU6lwfvV7XQM89tZN3KCJjIyuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/JzOiQtpV8dmngPfay6kUvo6DW+C+pSHn5UFk0Tc3GAQk86J6
	c4QHjegOjGlkbn1EDMfN8POFl6c3zAx5WMBBj71Wnlz5Fd/e2reH9DW1j3aK1OF08WXeDjYXEsS
	cUFFQ1yUeAbYUxBBKEkhGDs55p2PQiDPpTJpalQA3FDYuZpHC3uk3Hs76Bz4=
X-Google-Smtp-Source: AGHT+IGfXPUKRSdvN2YWhLw6zow5UDBBewiMpJSV91x5nC52F00FuBjU4LEJ9d09DsYuvwtk+6PHzVEbAJTxVE3LCPNv2sL5zPkj
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:318a:b0:3e2:c1ba:79c2 with SMTP id
 e9e14a558f8ab-3e2c1ba7bfamr86175445ab.7.1753265369524; Wed, 23 Jul 2025
 03:09:29 -0700 (PDT)
Date: Wed, 23 Jul 2025 03:09:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6880b4d9.050a0220.40ccf.0004.GAE@google.com>
Subject: [syzbot] [net?] WARNING: refcount bug in nsim_fib_event_nb (2)
From: syzbot <syzbot+ea02c8daa5dc1c52b364@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6832a9317eee Merge tag 'net-6.16-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1004038c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8bff2df4655c5f44
dashboard link: https://syzkaller.appspot.com/bug?extid=ea02c8daa5dc1c52b364
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/818bd549a31a/disk-6832a931.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f971d7bc88e2/vmlinux-6832a931.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f637a5f4829c/bzImage-6832a931.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ea02c8daa5dc1c52b364@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 1 PID: 6193 at lib/refcount.c:25 refcount_warn_saturate+0xfa/0x1d0 lib/refcount.c:25
Modules linked in:
CPU: 1 UID: 0 PID: 6193 Comm: kworker/u8:17 Not tainted 6.16.0-rc6-syzkaller-00121-g6832a9317eee #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: netns cleanup_net
RIP: 0010:refcount_warn_saturate+0xfa/0x1d0 lib/refcount.c:25
Code: 00 00 e8 49 ea 06 fd 5b 41 5e e9 d1 05 b0 06 cc e8 3b ea 06 fd c6 05 b6 66 d1 0a 01 90 48 c7 c7 40 6e e1 8b e8 b7 d7 ca fc 90 <0f> 0b 90 90 eb d7 e8 1b ea 06 fd c6 05 97 66 d1 0a 01 90 48 c7 c7
RSP: 0000:ffffc9000b5b7248 EFLAGS: 00010246
RAX: 6b82cdd65d8ecc00 RBX: 0000000000000002 RCX: ffff88807b493c00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfaa6c R12: dffffc0000000000
R13: ffff888061720020 R14: ffff88802422823c R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888125d59000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000020000000e000 CR3: 00000000400d2000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __refcount_add include/linux/refcount.h:-1 [inline]
 __refcount_inc include/linux/refcount.h:366 [inline]
 refcount_inc include/linux/refcount.h:383 [inline]
 fib_info_hold include/net/ip_fib.h:629 [inline]
 nsim_fib4_prepare_event drivers/net/netdevsim/fib.c:930 [inline]
 nsim_fib_event_schedule_work drivers/net/netdevsim/fib.c:1000 [inline]
 nsim_fib_event_nb+0xe9a/0x1080 drivers/net/netdevsim/fib.c:1043
 call_fib_notifier+0x42/0x80 net/core/fib_notifier.c:24
 call_fib_entry_notifier net/ipv4/fib_trie.c:90 [inline]
 fib_leaf_notify net/ipv4/fib_trie.c:2175 [inline]
 fib_table_notify net/ipv4/fib_trie.c:2193 [inline]
 fib_notify+0x359/0x5d0 net/ipv4/fib_trie.c:2216
 fib_net_dump net/core/fib_notifier.c:69 [inline]
 register_fib_notifier+0x184/0x360 net/core/fib_notifier.c:107
 nsim_fib_create+0x847/0x9d0 drivers/net/netdevsim/fib.c:1596
 nsim_dev_reload_create drivers/net/netdevsim/dev.c:1483 [inline]
 nsim_dev_reload_up+0x36b/0x780 drivers/net/netdevsim/dev.c:988
 devlink_reload+0x4ec/0x8d0 net/devlink/dev.c:474
 devlink_pernet_pre_exit+0x1d9/0x3d0 net/devlink/core.c:509
 ops_pre_exit_list net/core/net_namespace.c:162 [inline]
 ops_undo_list+0x184/0x990 net/core/net_namespace.c:235
 cleanup_net+0x4c5/0x800 net/core/net_namespace.c:686
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

