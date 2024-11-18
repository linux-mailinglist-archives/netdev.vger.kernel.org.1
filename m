Return-Path: <netdev+bounces-145787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB8B9D0E5C
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 11:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BCF31F2212D
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 10:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0884198E75;
	Mon, 18 Nov 2024 10:20:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1417F143C69
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 10:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925226; cv=none; b=TCKN+R+nOv3EqYqN6NjYyjGq77Zd5Nu1xq5RIU5SGj+UgO8Hva57FgZkaMFOjV6XpsorGZkkaIus0BymC2uqaOsok8j9uLO5AdJmL1gQSVmuEvPm4d/Ql5A85nmIeiv/LPncC7epofwqfM64hyQY7m2BfPXZCHXepX1N+CB3/v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925226; c=relaxed/simple;
	bh=DfrduIENpQdNSLfxvj6S+QXiwukzrpZhuGSW1W62ccs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rfHRZb8edz3S4LYIUKMaOeBB/esIodGEtNzBZjn4aMz73G6jnfouVPdmnCY/K6XyIePirRlANBmHQZd//u3MOKk+QCXlfzuC/lID8ArPpnBDUZZt7UYVwsLpxeAJ6xC1yA7V/Tg8jabIaSs3yZDPcp8Jes7RZfekeKhMq71nzdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c5a6c5e1so49731095ab.2
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 02:20:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731925224; x=1732530024;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vWCP09PtMIrn/p6f+QrfsR2pAtcMYL/4xReyhIlXj+s=;
        b=Fg++wSvn0IRwGkeRY4IcyDgelU+e6f/KFU2RPptS1J+rvSXpwyq+faMGAgVtOEgQLb
         1IenfzjQ5pVBuEHVb2aeBWRE7oFcLPLTTU2epEt5eUc4g0P9OYk5ohgTfw988zgrDeNA
         7jyjbsQGkOSSLWkLEv6YfAPDFKYrnQMHOtovxyRmMUS9i1QmyYtK3rVj3Nh/6+1gqHSL
         DIRKbjmJAcPI+KVKx8dfw0VGYn9JlbTG1YuggQ2Rjrm+5CUZPIZgPtoVS0/q8Z3M1xL3
         ftp8y1dej7RzDBjYeVbBcoMt/ReStBLgt2WrbJQugc6FvO6hAMNUOwlvyeLwDuLQOnAq
         If3A==
X-Forwarded-Encrypted: i=1; AJvYcCXdtNENlTy41w8r//OxbEAjAA3f6sYuMMTm5mZ+nSzoB2t81r6nNiWgbJlvjeVyM4skgizQf9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEj679tarNG9sh4Fw1mYHUg4B9/K08pAKU74kLYNgQ3GrRRwFR
	7hZLssY2I3k5DekkrUO/Dkp4ZoNITc5vXFKzijy8LMwmQcAX7DejtKgrqRSRfMH9+WTjvNuv0lx
	VaL5wdQ8QcqHJVEV/9xfCBlvWEr0ZiBS03aO3zIMKWnZIpUe69dSsnuU=
X-Google-Smtp-Source: AGHT+IGIdl38PxnTTWZOQk+icemQSRocUVG0DNNavA387T5grlyHOAuBs2La6KqQOXYn0iF802pdvvpP7DHFG6VNXYzqIzEosJUj
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b43:b0:3a7:158d:6510 with SMTP id
 e9e14a558f8ab-3a74800e163mr104599765ab.5.1731925224346; Mon, 18 Nov 2024
 02:20:24 -0800 (PST)
Date: Mon, 18 Nov 2024 02:20:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673b14e8.050a0220.87769.0029.GAE@google.com>
Subject: [syzbot] [bpf?] BUG: using smp_processor_id() in preemptible code in bpf_mem_alloc
From: syzbot <syzbot+fd2873203c2ed428828a@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    379d5ee624ed Merge branch 'bpf-range_tree-for-bpf-arena'
git tree:       bpf-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=115ecb5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=fd2873203c2ed428828a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12636ce8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f0f4c0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e83cf63a68cf/disk-379d5ee6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ff1f89f228ad/vmlinux-379d5ee6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8a715c466ecd/bzImage-379d5ee6.xz

The issue was bisected to:

commit b795379757eb054925fbb6783559c86f01c1a614
Author: Alexei Starovoitov <ast@kernel.org>
Date:   Fri Nov 8 02:56:15 2024 +0000

    bpf: Introduce range_tree data structure and use it in bpf arena

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10b2ab5f980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12b2ab5f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=14b2ab5f980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fd2873203c2ed428828a@syzkaller.appspotmail.com
Fixes: b795379757eb ("bpf: Introduce range_tree data structure and use it in bpf arena")

BUG: using smp_processor_id() in preemptible [00000000] code: syz-executor373/5838
caller is bpf_mem_alloc+0x117/0x220 kernel/bpf/memalloc.c:903
CPU: 1 UID: 0 PID: 5838 Comm: syz-executor373 Not tainted 6.12.0-rc7-syzkaller-g379d5ee624ed #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 check_preemption_disabled+0x10e/0x120 lib/smp_processor_id.c:49
 bpf_mem_alloc+0x117/0x220 kernel/bpf/memalloc.c:903
 range_tree_set+0x971/0x1830 kernel/bpf/range_tree.c:238
 arena_map_alloc+0x36f/0x440 kernel/bpf/arena.c:137
 map_create+0x946/0x11c0 kernel/bpf/syscall.c:1441
 __sys_bpf+0x6d1/0x810 kernel/bpf/syscall.c:5741
 __do_sys_bpf kernel/bpf/syscall.c:5866 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5864 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5864
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5cb29a1329
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffee3bcaa18 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffee3bcabf8 RCX: 00007f5cb29a1329
RDX: 0000000000000048 RSI: 0000000020003940 RDI: 0000000000000000
RBP: 00007f5cb2a14610 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffee3bcabe8 R14: 0000000000000001 R15: 0000000000000001
 </TA


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

