Return-Path: <netdev+bounces-228544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DB6BCDD40
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 17:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD775460B7
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 15:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178532FB614;
	Fri, 10 Oct 2025 15:41:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7A92FB0A5
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760110891; cv=none; b=HHkW+i6dfzt3ae0Gdt8NEPc9vMV1Jv/kv5b8tcccGAQwVX8ift6ehNUJByx3Do7x/fRXHUwUgqivDYSzpdtRXfMWSq2gEqc87eL78kymME4hIeHlNirH3XO0TFXRYyo7rtWyBR1ldjOkmUxfsOTKKVEDE6rrBKPSwfizQUgJnu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760110891; c=relaxed/simple;
	bh=oXdJ9hxao0+88bJ3Q5bqzIcokKU8lyciNlAMcN/Ujkg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=c9HxIPjJKMgi9ha08YY0dvuusdvqmkvtMf5alHSjCrWcQLBeOqUDyfbBxdgwX645qChKYPM2QGz+qBx3XRO9ritBoyPYzqxCyRMZij/qMn9FkxImsoDJyQIKnzYmDfW9jppIe9uF+rPrfa/CMhKmP1Qk94g4UchVnTFF45by4LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42594b7f324so76996755ab.1
        for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 08:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760110888; x=1760715688;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9t4YKrQ+i6zPnSqIk+4cnVQH6VUcMiv6uzmRTIEIoKI=;
        b=ZiGyWvnhPKTjmuCHDTtSZuOvsyBgHqv2B2Qc6S3XU+O1pY++bHAU0pwvvG19p3JLzA
         P27OeMSJy9cJlwa9MZ7wbPXG0gJmq+QCoGpkFukln1s48fCpMogpHZhz6zFcrHFYHD9+
         mybHP6tQL9Dn7UCKUZsR428LONzJlxG9slvenX1PaqAlSw7WrGwxSSPuRvEPjdJDAjkQ
         Yv0wo07oLYM0vyJa1a4d20AXKTrDKBQ+uGQsBFd7FgiPSWA0yYIWoz5y4b/IKSoC/f3S
         h1ylrVGBiQCYus5RRRpDq3uyJiTzF/FOabhF5JeDxuxdE/HBRfdQACG9fpmVZ97OQwfz
         HfXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbE8PawLjNfq2IR3FFkE+KuYhNso1qO7y+HAkuFfiVhJfD5wJBWsGCt9avmDCcmNZGbJqK/GE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA5E4KEyCaar2N77uJs84pLhqiTjuCF3AFk56IC53NSITUJiPw
	0oyQq12JUJo273Iz+Zk5AMfCFZ/n3M3XmLD0p33rW95wi/8MPyJJR3uURaKt7Um8WQCZ0poTzHz
	dYfbnHJKpDhZFVLUBT/LFx4mJFiquY8SKMVHAqscsMr8H5ku/MdZ1hwJyUIw=
X-Google-Smtp-Source: AGHT+IEXeRrI+/fpBtKbI9Pf7crdMPmeGYhJHB7bmAj+WEO9WUvJdaR7A0Zl93pdG0LU5IE8GvkXLiCIYtgbmi5st4mnPcBuaQd7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1949:b0:42f:94f5:4684 with SMTP id
 e9e14a558f8ab-42f94f54907mr64897265ab.5.1760110888125; Fri, 10 Oct 2025
 08:41:28 -0700 (PDT)
Date: Fri, 10 Oct 2025 08:41:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e92928.050a0220.3897dc.0194.GAE@google.com>
Subject: [syzbot] [bpf?] [net?] WARNING in sock_map_delete_elem (2)
From: syzbot <syzbot+ad76dbe500667f3a4e17@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jakub@cloudflare.com, john.fastabend@gmail.com, 
	kuba@kernel.org, kuniyu@google.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	willemb@google.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fd94619c4336 Merge tag 'zonefs-6.18-rc1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14ff8ee2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2b03b8b7809165e
dashboard link: https://syzkaller.appspot.com/bug?extid=ad76dbe500667f3a4e17
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/201636e25a0b/disk-fd94619c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b63e3832240c/vmlinux-fd94619c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/11fc378734e8/bzImage-fd94619c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ad76dbe500667f3a4e17@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt))
WARNING: CPU: 0 PID: 5969 at kernel/softirq.c:176 __local_bh_disable_ip+0x3d9/0x540 kernel/softirq.c:176
Modules linked in:
CPU: 0 UID: 0 PID: 5969 Comm: syz.1.2 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:__local_bh_disable_ip+0x3d9/0x540 kernel/softirq.c:176
Code: 0f b6 04 28 84 c0 0f 85 56 01 00 00 83 3d 52 9b 32 0d 00 75 19 90 48 c7 c7 c0 b7 c9 8a 48 c7 c6 00 b8 c9 8a e8 f8 5f fe ff 90 <0f> 0b 90 90 90 e9 7b ff ff ff 90 0f 0b 90 e9 71 fe ff ff e8 cf 84
RSP: 0018:ffffc900056bf940 EFLAGS: 00010246
RAX: f63c8546519c3800 RBX: 1ffff92000ad7f30 RCX: 0000000000080000
RDX: ffffc9000d891000 RSI: 00000000000093ed RDI: 00000000000093ee
RBP: ffffc900056bfa48 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed101710487b R12: ffff88803c911e00
R13: dffffc0000000000 R14: ffff88803c91294c R15: 1ffff11007922529
FS:  00007fe7c46d66c0(0000) GS:ffff888127020000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30217ff8 CR3: 000000001dfd6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 local_bh_disable include/linux/bottom_half.h:20 [inline]
 spin_lock_bh include/linux/spinlock_rt.h:87 [inline]
 __sock_map_delete net/core/sock_map.c:421 [inline]
 sock_map_delete_elem+0xaf/0x170 net/core/sock_map.c:452
 bpf_prog_e78d8a1634f5e22d+0x46/0x4e
 bpf_dispatcher_nop_func include/linux/bpf.h:1350 [inline]
 __bpf_prog_run include/linux/filter.h:721 [inline]
 bpf_prog_run include/linux/filter.h:728 [inline]
 bpf_prog_run_pin_on_cpu include/linux/filter.h:745 [inline]
 bpf_flow_dissect+0x225/0x720 net/core/flow_dissector.c:1024
 bpf_prog_test_run_flow_dissector+0x37c/0x5c0 net/bpf/test_run.c:1425
 bpf_prog_test_run+0x2cd/0x340 kernel/bpf/syscall.c:4673
 __sys_bpf+0x562/0x860 kernel/bpf/syscall.c:6152
 __do_sys_bpf kernel/bpf/syscall.c:6244 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6242 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6242
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe7c646eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe7c46d6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fe7c66c5fa0 RCX: 00007fe7c646eec9
RDX: 0000000000000050 RSI: 0000200000000000 RDI: 000000000000000a
RBP: 00007fe7c64f1f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe7c66c6038 R14: 00007fe7c66c5fa0 R15: 00007ffd3a510c78
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

