Return-Path: <netdev+bounces-187643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDFFAA8816
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 18:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913321895A10
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 16:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB941DED49;
	Sun,  4 May 2025 16:41:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14C11DDA14
	for <netdev@vger.kernel.org>; Sun,  4 May 2025 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746376892; cv=none; b=CLI/BBnAzwFytI9djPvgpyl8A8UtSiMlEmoWzXGdK9YZUYABqMdQoXa7yYwra368NuXRU5Dr1qiB67mXRl8M2MFXUL0/6l8oKjYGG57Jj7FWgvC63pQieksmNF/UFZa/FDqPxemlIf/UjYsdJMfz9FNoILw1ylfTaiGSmw1j28A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746376892; c=relaxed/simple;
	bh=zx+jKXcri6dR+IIa1Sk/SxxetBjN9UsFxeJlWEPlXdU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EDypBkJfLJGnBJGpTZ2SpMj0cNSr7a9bfOjuSOgLmpSlmIiIHctUr9H1L7VMgmc2MwTZ486Z/iIIOeb+GT8+kN0hLXM8fwIvzLPu89K/KokKQHtkZJTSpFAnSEzp35K57XrJ7GxNSq+RJy3lN1qD1Zg2ELlWup2aEUnHcpfCyNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d443811f04so35863315ab.1
        for <netdev@vger.kernel.org>; Sun, 04 May 2025 09:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746376889; x=1746981689;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gfw45Ij98dx4ZUWmy0fErG1QSZAKfLu5YdTYGEu1vH0=;
        b=JFxD4q/fFw9FWGvKlMhSFRjGt9zgtJMfIlD09PNqaNq01jMz8IzA5b98N5BSyPr7Vm
         izDJOK5HUhH0z2V1AszMXu2S14z67BiWiv50qPwem2mYsWkZY0QvR6ujpjds0FvvNxDA
         HCbgVbfQZ//S085vYKTVxHucp9/+yp1QD1bUqSVOgZ3MPjiAcNYmnk9vpQHrSh5nUxej
         CM+b7aBHV+Pm4b4HmJCahJH/JTLQHcilMyJBgBK7gCkLFmPExVseDal5qQmvew+ACjKU
         VAXfKVOSt4cEggfuIcXUxXD5BR2LoCkjDVAOOqrcIbXXBkC9h0+wRJjU80SBY5fkFsE7
         7U2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnGJ4GGpFIF2Jrol6XSgHTSuTN8k5ko/UOKAoit2vLz0HOlMlVjueHZwG3sdZKsta8qnZlSxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFlJOWZlOwJ/cy4ipMtRzeHNkZsFYe4hL6HZOHQ8VyoUD/uwWn
	SyMW+3+6SryLdTLg5bWTwqMVe+ExVYCMZhfgO88wFm3QDzHAkMoJkZazT5io+LtuagnC16mQfIT
	XA3NKHdkdnz0wwR9cIZTeh6s+qAbcIHXggUXTvgJfEFeOzdp3WeNqupg=
X-Google-Smtp-Source: AGHT+IEVyigHJO6JzmSf7gcFgqLz6Xr9b4/nKfyn2Gi1Si0GpO7frnmtmbzTAHwJIYllmmS90gnLV9quVD6Io84gRzFMfY/G4L3e
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:32c2:b0:3d8:1a41:69a9 with SMTP id
 e9e14a558f8ab-3da5b2a02fbmr47154055ab.12.1746376889714; Sun, 04 May 2025
 09:41:29 -0700 (PDT)
Date: Sun, 04 May 2025 09:41:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <681798b9.050a0220.11da1b.0033.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in rt6_find_cached_rt
From: syzbot <syzbot+c98f63d3185beafbc080@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2bfcee565c3a Merge tag 'bcachefs-2025-05-01' of git://evil..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14ecf774580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9a25b7a36123454
dashboard link: https://syzkaller.appspot.com/bug?extid=c98f63d3185beafbc080
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/75f61dd1e26c/disk-2bfcee56.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b0255b732c7e/vmlinux-2bfcee56.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bff4e7ba94d0/bzImage-2bfcee56.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c98f63d3185beafbc080@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
CPU: 1 UID: 0 PID: 5881 Comm: kworker/1:4 Not tainted 6.15.0-rc4-syzkaller-00189-g2bfcee565c3a #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
Workqueue: mld mld_ifc_work
RIP: 0010:fib6_nh_get_excptn_bucket net/ipv6/route.c:1662 [inline]
RIP: 0010:rt6_find_cached_rt+0xb9/0x270 net/ipv6/route.c:1858
Code: 48 c1 e8 03 48 89 44 24 08 48 8b 44 24 08 80 3c 18 00 74 08 4c 89 f7 e8 65 8c 14 f8 49 8b 2e 48 83 c5 60 48 89 e8 48 c1 e8 03 <80> 3c 18 00 74 08 48 89 ef e8 49 8c 14 f8 4c 8b 6d 00 e8 70 c5 48
RSP: 0018:ffffc90000a084e0 EFLAGS: 00010206
RAX: 000000000000000c RBX: dffffc0000000000 RCX: 0000000000000100
RDX: ffff88807f319e00 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000060 R08: ffff88807ef99633 R09: 1ffff1100fdf32c6
R10: dffffc0000000000 R11: ffffed100fdf32c7 R12: ffffc90000a085b8
R13: 0000000000000000 R14: ffffc90000a085b0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881261cc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbb92ae56c0 CR3: 000000006a5c2000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000005325
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 ip6_pol_route+0x28d/0x1180 net/ipv6/route.c:2273
 pol_lookup_func include/net/ip6_fib.h:616 [inline]
 fib6_rule_lookup+0x55e/0x6f0 net/ipv6/fib6_rules.c:125
 ip6_route_input_lookup net/ipv6/route.c:2335 [inline]
 ip6_route_input+0x6ce/0xa50 net/ipv6/route.c:2631
 ip6_rcv_finish+0x141/0x2d0 net/ipv6/ip6_input.c:77
 NF_HOOK+0x309/0x3a0 include/linux/netfilter.h:314
 __netif_receive_skb_one_core net/core/dev.c:5887 [inline]
 __netif_receive_skb+0xd3/0x380 net/core/dev.c:6000
 process_backlog+0x60e/0x14f0 net/core/dev.c:6352
 __napi_poll+0xc4/0x480 net/core/dev.c:7324
 napi_poll net/core/dev.c:7388 [inline]
 net_rx_action+0x6ea/0xdf0 net/core/dev.c:7510
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 do_softirq+0xec/0x180 kernel/softirq.c:480
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x17d/0x1c0 kernel/softirq.c:407
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:910 [inline]
 __dev_queue_xmit+0x1cd7/0x3a70 net/core/dev.c:4656
 neigh_output include/net/neighbour.h:539 [inline]
 ip6_finish_output2+0x11fb/0x16a0 net/ipv6/ip6_output.c:141
 __ip6_finish_output net/ipv6/ip6_output.c:-1 [inline]
 ip6_finish_output+0x234/0x7d0 net/ipv6/ip6_output.c:226
 NF_HOOK+0x9e/0x380 include/linux/netfilter.h:314
 mld_sendpack+0x800/0xd80 net/ipv6/mcast.c:1868
 mld_send_cr net/ipv6/mcast.c:2169 [inline]
 mld_ifc_work+0x835/0xde0 net/ipv6/mcast.c:2702
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:fib6_nh_get_excptn_bucket net/ipv6/route.c:1662 [inline]
RIP: 0010:rt6_find_cached_rt+0xb9/0x270 net/ipv6/route.c:1858
Code: 48 c1 e8 03 48 89 44 24 08 48 8b 44 24 08 80 3c 18 00 74 08 4c 89 f7 e8 65 8c 14 f8 49 8b 2e 48 83 c5 60 48 89 e8 48 c1 e8 03 <80> 3c 18 00 74 08 48 89 ef e8 49 8c 14 f8 4c 8b 6d 00 e8 70 c5 48
RSP: 0018:ffffc90000a084e0 EFLAGS: 00010206

RAX: 000000000000000c RBX: dffffc0000000000 RCX: 0000000000000100
RDX: ffff88807f319e00 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000060 R08: ffff88807ef99633 R09: 1ffff1100fdf32c6
R10: dffffc0000000000 R11: ffffed100fdf32c7 R12: ffffc90000a085b8
R13: 0000000000000000 R14: ffffc90000a085b0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881261cc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbb92ae56c0 CR3: 000000006a5c2000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000005325
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 c1 e8 03          	shr    $0x3,%rax
   4:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
   9:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
   e:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
  12:	74 08                	je     0x1c
  14:	4c 89 f7             	mov    %r14,%rdi
  17:	e8 65 8c 14 f8       	call   0xf8148c81
  1c:	49 8b 2e             	mov    (%r14),%rbp
  1f:	48 83 c5 60          	add    $0x60,%rbp
  23:	48 89 e8             	mov    %rbp,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	48 89 ef             	mov    %rbp,%rdi
  33:	e8 49 8c 14 f8       	call   0xf8148c81
  38:	4c 8b 6d 00          	mov    0x0(%rbp),%r13
  3c:	e8                   	.byte 0xe8
  3d:	70 c5                	jo     0x4
  3f:	48                   	rex.W


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

