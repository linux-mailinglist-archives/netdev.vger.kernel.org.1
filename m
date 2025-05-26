Return-Path: <netdev+bounces-193386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAC9AC3BC9
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 10:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68FFF1891953
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 08:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBDF1E47B4;
	Mon, 26 May 2025 08:39:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E1C78F3B
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 08:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748248778; cv=none; b=QIJmbY7I5Zmkvwgc0KpbvemUu1JOtM65tDByC/j1jVeL85NHk2ADi4P8ZBkjITp2JtL4F+NjHn9+6dII5RiBVZO8sYtJBFKPntWRtOqEfSOPNmoQ28461e+LeGaxcakHpMtF6Wd+V1BbAaD2BarGh/GqIdAGQ+6pdn6RdjPtcgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748248778; c=relaxed/simple;
	bh=rHPVWLMw5Awu1D3Tkwx7cFz/Pp7viisxSueIwdpSuZw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DC7urz8tFGWXpdeGREwfc9tOH1Ong6LsknTswS6lwCn16V1f7iiZVWEYNHyeUCBJSV0DjTNmRw7zELB3JrqYZhyiIRyZgTpqZcPw3v9IHF0Nos+n1lkCvbbd8HMq6E/e3FxhWqOUAIssYZoU0WGNH5SsJkBnG8FHTfFRXUfKXfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-85e318dc464so357914039f.1
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 01:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748248776; x=1748853576;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xUow/ouOf7qwQxjewErskrPCwOqgPFfe4ALax8wNkcA=;
        b=BWuKdd+tZ9XNFZtf00rHDU5nQANCLh7GLIxa9Vg6I0u2PjJa0Ikez4ve4HHrFjhi9F
         5oWVJ6jia62xAxHDGYZyK1UA7kpBXPpdNZTvPZJNH7BssBcT808DRSIEBvdt8eskz14F
         S4YQErtVdPXLwsF8MGz3UAvMxDwe6xkx0emVPtUWaN4v4ENId6kZ8Gub4d3cqKiWu7NC
         YpHLLyhKRKmnwe0N5iNJ4d6psOTJpLoB9/7kuyTg0JZUcNLEOyrPOmoD5jW+D1jFT+XR
         0rY2Rco/v5vKYytpsnShOZMLGnAaV5lhSx76twt8ibkgpgRquedPylC9dL3nnZ4xO55s
         UGHA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ6Pr3SUGgev5shHQRm9y9P64irc93eA4MaaRjEIBeYlfW0xlxtgudDmHbtRlg9/ex9oSrA6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcu+ekyJWPepvRZqlq3Mp9g8zVcAOcCawvl1KS4goUL5mrwywo
	H2JijddgZR3g+cGXyEXoCwqLwWo7496l/NETdMf/EgHejsor44geVi+NyCuoP5J1TAagNfjTJLh
	nkh6gEXWlANYVNK1bRi+eX5M5X1UnHKXvzSDV1CoWkpw2njLrdBOTeMsGaU0=
X-Google-Smtp-Source: AGHT+IF0ITJUZ4ve5LIAV8IyuFKDNA3YEZMVT0wWDb3fCrKP09/gMzKyyab98mH5r5bGWM7Nt+L5UUZDhwNcPh0jKsP0gnwnnhH+
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:b91:b0:867:8ef:69e8 with SMTP id
 ca18e2360f4ac-86cbb81812bmr1231816939f.3.1748248775791; Mon, 26 May 2025
 01:39:35 -0700 (PDT)
Date: Mon, 26 May 2025 01:39:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683428c7.a70a0220.29d4a0.0800.GAE@google.com>
Subject: [syzbot] [net?] WARNING: suspicious RCU usage in task_cls_state
From: syzbot <syzbot+b4169a1cfb945d2ed0ec@syzkaller.appspotmail.com>
To: andrii@kernel.org, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tj@kernel.org, yangfeng@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    079e5c56a5c4 bpf: Fix error return value in bpf_copy_from_..
git tree:       bpf-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=178ae170580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c6c517d2f439239
dashboard link: https://syzkaller.appspot.com/bug?extid=b4169a1cfb945d2ed0ec
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13bc35f4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f195f4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8d7d35d067bc/disk-079e5c56.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/74d2648ea7f4/vmlinux-079e5c56.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e751e253ee4f/bzImage-079e5c56.xz

The issue was bisected to:

commit ee971630f20fd421fffcdc4543731ebcb54ed6d0
Author: Feng Yang <yangfeng@kylinos.cn>
Date:   Tue May 6 06:14:33 2025 +0000

    bpf: Allow some trace helpers for all prog types

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14cd68e8580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16cd68e8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=12cd68e8580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b4169a1cfb945d2ed0ec@syzkaller.appspotmail.com
Fixes: ee971630f20f ("bpf: Allow some trace helpers for all prog types")

=============================
WARNING: suspicious RCU usage
6.15.0-rc4-syzkaller-g079e5c56a5c4 #0 Not tainted
-----------------------------
net/core/netclassid_cgroup.c:24 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz-executor296/5833:
 #0: ffffffff8df3ba40 (rcu_read_lock_trace){....}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8df3ba40 (rcu_read_lock_trace){....}-{0:0}, at: rcu_read_lock_trace+0x38/0x80 include/linux/rcupdate_trace.h:58

stack backtrace:
CPU: 0 UID: 0 PID: 5833 Comm: syz-executor296 Not tainted 6.15.0-rc4-syzkaller-g079e5c56a5c4 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x140/0x1d0 kernel/locking/lockdep.c:6865
 task_cls_state+0x1a5/0x1d0 net/core/netclassid_cgroup.c:23
 __task_get_classid include/net/cls_cgroup.h:50 [inline]
 ____bpf_get_cgroup_classid_curr net/core/filter.c:3086 [inline]
 bpf_get_cgroup_classid_curr+0x18/0x60 net/core/filter.c:3084
 bpf_prog_83da9cb0e78d4768+0x2c/0x5a
 bpf_dispatcher_nop_func include/linux/bpf.h:1322 [inline]
 __bpf_prog_run include/linux/filter.h:718 [inline]
 bpf_prog_run include/linux/filter.h:725 [inline]
 bpf_prog_run_pin_on_cpu+0x67/0x150 include/linux/filter.h:742
 bpf_prog_test_run_syscall+0x312/0x4b0 net/bpf/test_run.c:1564
 bpf_prog_test_run+0x2a9/0x340 kernel/bpf/syscall.c:4429
 __sys_bpf+0x4a4/0x860 kernel/bpf/syscall.c:5854
 __do_sys_bpf kernel/bpf/syscall.c:5943 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5941 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5941
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fda75b18a69
Code: d8 5b c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdd0546d48 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fda75b18a69
RDX: 0000000000000048 RSI: 0000200000000500 RDI: 000000000000000a


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

