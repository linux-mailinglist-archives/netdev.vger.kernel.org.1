Return-Path: <netdev+bounces-81618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F33BC88A7DE
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 16:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C89341557
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 15:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324191552E3;
	Mon, 25 Mar 2024 13:27:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA066CDDC
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711373253; cv=none; b=dBRuApHfBpST824RQVzWOQWPb+CHjbeMxjxwcgCR95Td7hTtU39phb5tDiTTYUqBEwmgn30GRaL1xMgCjcorNfZpVFfs8CF8uTPoleLtS/q6mZDZTTica9wOsCOisfXK/L22rydUBViADbSeghH+53lCEXtLgFHb00sHxEQloRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711373253; c=relaxed/simple;
	bh=P3OWqnkWTXmu2hLFQXYZHkN/5j/+PnQvtI0D/VhpqoA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ECnaaD4Qg1WqAiz49E/s2Yy7dqFZtRm1ZOWU+JIgFquV0hf9SheYirybsp1wgYrC7WJlAVEVELi1TZIBEykN0xLR/xvLfeQxT4ThUAMoBLh5XBlXp4s8lmszwKwPXrZNTaCR7XjAfbKqkXLdkYRQuUtfklXnW2Glz3PnkJXy148=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3684b6a0c94so43677065ab.3
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 06:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711373250; x=1711978050;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ctAtBGkbihJIAqFkPSDzB+Db8NzZcNP/xwNYQUVTKnI=;
        b=CaXlk/D5roserdbcMO3UVSAEQLp6p+6C74tAZ9TnN7ammIegLtl+WrgBWtF6ROgTgS
         k2gKgGS2xtpyzghIuWxxH6I7vngCEdxJymgJnLUIrX1kk8usvKOmWnP8MNW026ZmeXQx
         Dwrsz1DGRSf9uipLgXHZcyQo51fAUBiJUFCzt6BjaBdu7pn/Ela7jue9fYtZMRWsO5im
         zU50vBGQbTNzQO+GHBUT1iCg12YPyyGzMjgnrUYi2R5NB9txoZa5kkVXstKRJUDoRaVH
         5GxWq6XIA85aZuHxMX/ISmNrMZ8241q2yXQdWXG2y19ACgqSmj4bMlI8EamWbTiqFGnS
         j5UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu1c1Ezkr5TJtQOygJ5Z2pQSh6bvJmRynhg+Galzj9R/GX7FL7WPB+kdcrGr07ODSP/w4dLXLPNJCSCJwsZMlCvDz/bOoF
X-Gm-Message-State: AOJu0YwxDgHE4ePGQrDvreZ/yWYzVo5/kMwnbdBfUhlkLDdSHE1VXhAa
	9b92wahDFTZo1hpRzwEp9OutaXdJqDwlQ03qb25E+KnAmLUsyugduBm/vrvs1xgP9iua/BHrwGp
	mwf8N8TM8HPsWF5LWPpt6V432TN+jAcKrb0UkiNFPZP/hutpqOlx4Ez8=
X-Google-Smtp-Source: AGHT+IGmGluipUd2atCJ9yVqGaoUk8r2TJ3zFIvtOyp+7e1pz29myH6X82xI0yqk6k8zElqByK/sZmJlBC8Lz6bl4osd4lT2f4Ya
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d02:b0:368:8915:2bd3 with SMTP id
 i2-20020a056e021d0200b0036889152bd3mr218979ila.1.1711373250048; Mon, 25 Mar
 2024 06:27:30 -0700 (PDT)
Date: Mon, 25 Mar 2024 06:27:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5c69c06147c2238@google.com>
Subject: [syzbot] [bpf?] [net?] KMSAN: uninit-value in sock_map_delete_elem
From: syzbot <syzbot+eb02dc7f03dce0ef39f3@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    70293240c5ce Merge tag 'timers-urgent-2024-03-23' of git:/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=129e4dc9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e6bd769cb793b98a
dashboard link: https://syzkaller.appspot.com/bug?extid=eb02dc7f03dce0ef39f3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b5bbb9180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ee1291180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0de52742d0b8/disk-70293240.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f304697881bf/vmlinux-70293240.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2b9d8a9376f0/bzImage-70293240.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eb02dc7f03dce0ef39f3@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in sock_map_delete_elem+0x15e/0x1c0 net/core/sock_map.c:442
 sock_map_delete_elem+0x15e/0x1c0 net/core/sock_map.c:442
 ____bpf_map_delete_elem kernel/bpf/helpers.c:77 [inline]
 bpf_map_delete_elem+0x5c/0x80 kernel/bpf/helpers.c:73
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run160+0xb5/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run8+0x1bd/0x3a0 kernel/trace/bpf_trace.c:2426
 __bpf_trace_jbd2_handle_stats+0x51/0x70 include/trace/events/jbd2.h:210
 __traceiter_jbd2_handle_stats+0xc5/0x190 include/trace/events/jbd2.h:210
 trace_jbd2_handle_stats include/trace/events/jbd2.h:210 [inline]
 jbd2_journal_stop+0x1157/0x12c0 fs/jbd2/transaction.c:1869
 __ext4_journal_stop+0x115/0x310 fs/ext4/ext4_jbd2.c:134
 ext4_do_writepages+0x1c3c/0x62e0 fs/ext4/inode.c:2692
 ext4_writepages+0x312/0x830 fs/ext4/inode.c:2768
 do_writepages+0x427/0xc30 mm/page-writeback.c:2612
 __writeback_single_inode+0x10d/0x12c0 fs/fs-writeback.c:1650
 writeback_sb_inodes+0xb48/0x1be0 fs/fs-writeback.c:1941
 __writeback_inodes_wb+0x14c/0x440 fs/fs-writeback.c:2012
 wb_writeback+0x4da/0xdf0 fs/fs-writeback.c:2119
 wb_check_old_data_flush fs/fs-writeback.c:2223 [inline]
 wb_do_writeback fs/fs-writeback.c:2276 [inline]
 wb_workfn+0x110c/0x1940 fs/fs-writeback.c:2304
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa81/0x1bd0 kernel/workqueue.c:3335
 worker_thread+0xea5/0x1560 kernel/workqueue.c:3416
 kthread+0x3e2/0x540 kernel/kthread.c:388
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

Local variable stack created at:
 __bpf_prog_run160+0x45/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run8+0x1bd/0x3a0 kernel/trace/bpf_trace.c:2426

CPU: 0 PID: 33 Comm: kworker/u8:2 Not tainted 6.8.0-syzkaller-13213-g70293240c5ce #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Workqueue: writeback wb_workfn (flush-8:0)
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

