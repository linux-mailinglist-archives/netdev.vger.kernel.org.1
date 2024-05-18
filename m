Return-Path: <netdev+bounces-97115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DB88C924E
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 23:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8CFE1F212F6
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 21:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491FD1E522;
	Sat, 18 May 2024 21:05:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBD653364
	for <netdev@vger.kernel.org>; Sat, 18 May 2024 21:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716066339; cv=none; b=FtIohAQi0mAkgaz5lKqq6yP3cgGrnqSRMA9YJQUj2HX96WnCHnnYpRXdecnKk9sdmHj+vCk6JMbcb95znKH1ZezEyBYwRz69vKJrIp7xpn25Rg1FyfnMlRtKXVt830fWGF1duGN/EIcCB66ux6561L2y+okVzDh5uAhd+yaceXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716066339; c=relaxed/simple;
	bh=NRgjkBMK4sXVRHAhM0KdWy2Ma87HvsqtCepIc1Mmf+U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oh0Nj0x3RWF+9soxky/UbHiWfh9STOR1OhvHxcIcPDbxBN55A9l4OquwuFolnT6o+EtP3j23gt9VNgBX2efyBu/V3AhCWsfBkOU5A2pyCZ5vPP579E7rfUVZ6wB+dRbVc9iYcqyR/tAUb5MMHTT0Z7iNgfiRQVfXcKD2Lk1C6eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7e1fe2ba2e1so584326639f.3
        for <netdev@vger.kernel.org>; Sat, 18 May 2024 14:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716066337; x=1716671137;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gfFjo3BhTE67D3mQ9xMB8FDVigkkGBSudUTv3+vJeFs=;
        b=FqXhtIo6o9VJqN1BfE0KCeX6Ry7LswmO1p7tPbi7ArbUIJ3crYKazn0kWAIao4f4Wd
         IrteL+X7LfY/86V1gOZXRCb8GdhdfkDG/Qy69xS2NhRlsBc3o6D1PIvhgWVst6lDhdXb
         pR2ijbJ6VfKgQhGcYu4Vd+iOlxclUgKOlkJ5pJCwEK4BHQzGDdtQvYA1qJcDn2sYw1zg
         eTMV/HQoS+8zIWZnMZ5HrzWJ+ALjqvqO9UxaLnglU7uMgWvs0xkeUSQxXJNrZdBBGfLI
         SV+EnJqD1BTvSp/i9WGWfS4CiAuPDqBS/bENEsofoRMUj7lXYUw5SrU6kFiMR2qvcwdt
         8jrg==
X-Forwarded-Encrypted: i=1; AJvYcCXGkp7d/1g3hXhJnJWn/Q+YGpBBVZbIO6JdrS3R/s5/2QtVNFNnNktI6egMOm4CFDS8OBq9Ii27wWMch7uE5mi/wkFftQs8
X-Gm-Message-State: AOJu0YyUjY9jmCjknZHz3+1NHlnFSd49Zy8kCRRPDLZLvwwDGiiOh0kU
	hmt/c2bu5DX5KiM2q3lVAy2pvLdK4+qgdTw+8nTSIvr3LZDZQHQI8mNOBX9C+T/0arynACfh+wY
	JwifxaKtsySyfxXGb4a2lr0ZpVEusq5Ane4WFJzr69sv9m4ja5xfLlWo=
X-Google-Smtp-Source: AGHT+IH81JS2t4EuaWyDfkKkvdQ+OWubY5WcSldbCKOiadcOGy+6xA3E/2fR+hWaPT/Rs30P1O4E7tnxWdz8RrhitmSScCVpPKsK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8305:b0:487:100b:9212 with SMTP id
 8926c6da1cb9f-48958af8591mr1771843173.3.1716066336941; Sat, 18 May 2024
 14:05:36 -0700 (PDT)
Date: Sat, 18 May 2024 14:05:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006cbc570618c0d4a3@google.com>
Subject: [syzbot] [bpf?] [net?] KMSAN: uninit-value in dev_map_hash_lookup_elem
From: syzbot <syzbot+80cf9d55d6fd2d6a9838@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1429a96c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=80cf9d55d6fd2d6a9838
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a53ae4980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=113003d4980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+80cf9d55d6fd2d6a9838@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in __dev_map_hash_lookup_elem kernel/bpf/devmap.c:270 [inline]
BUG: KMSAN: uninit-value in dev_map_hash_lookup_elem+0x116/0x2e0 kernel/bpf/devmap.c:803
 __dev_map_hash_lookup_elem kernel/bpf/devmap.c:270 [inline]
 dev_map_hash_lookup_elem+0x116/0x2e0 kernel/bpf/devmap.c:803
 ____bpf_map_lookup_elem kernel/bpf/helpers.c:42 [inline]
 bpf_map_lookup_elem+0x5c/0x80 kernel/bpf/helpers.c:38
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run64+0xb5/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run4+0x150/0x340 kernel/trace/bpf_trace.c:2422
 __bpf_trace_sched_switch+0x37/0x50 include/trace/events/sched.h:222
 trace_sched_switch include/trace/events/sched.h:222 [inline]
 __schedule+0x2eca/0x6bc0 kernel/sched/core.c:6743
 __schedule_loop kernel/sched/core.c:6823 [inline]
 schedule+0x13d/0x380 kernel/sched/core.c:6838
 ptrace_stop+0x8eb/0xd60 kernel/signal.c:2358
 ptrace_do_notify kernel/signal.c:2395 [inline]
 ptrace_notify+0x234/0x320 kernel/signal.c:2407
 ptrace_report_syscall include/linux/ptrace.h:415 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
 syscall_exit_work+0x14e/0x3e0 kernel/entry/common.c:173
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:200 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:205 [inline]
 syscall_exit_to_user_mode+0x135/0x160 kernel/entry/common.c:218
 do_syscall_64+0xdc/0x1e0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable stack created at:
 __bpf_prog_run64+0x45/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run4+0x150/0x340 kernel/trace/bpf_trace.c:2422

CPU: 0 PID: 5042 Comm: syz-executor593 Not tainted 6.9.0-syzkaller-02707-g614da38e2f7a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
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

