Return-Path: <netdev+bounces-236668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A768BC3EC38
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 08:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668BC3AFC17
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 07:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3333090C2;
	Fri,  7 Nov 2025 07:31:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B9B289E06
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762500691; cv=none; b=Qx0YDKlxc9113VBH0syyOSmFrUgG+UZG8AYyl1/A7nmVAmHwxmYf4C2nO7M9cYw3GesrbXyfMaFGknq138wfj1IiRML30lNUUVixv35N/mIVBFR+4EYAd4XaSGkCi9K4tjUF2U+wNlOPNonPqPShdkFbpKB3+ddx/rUFOWeAriI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762500691; c=relaxed/simple;
	bh=XjB0m3lhpum+kNFv1N6CbMC3QAg71MXUb9/tvtzc4sY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aL74PyspnmQAiDtvGlJDlKuym/Ctk/qR3iw++bP69XZ0byXamRkHaR5IylcnCCYnjNA9W4Y+rvJJInDY6rbt36ZKyeM9VSqW8xlbVhbNJnVr5waA+RGx4FNqxWuMeEL2Rn+FKfFy+ZzGxLwbCvYFGhvpmnTTQ8GZBhoN/C90Tm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-948610ae935so38230339f.2
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 23:31:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762500688; x=1763105488;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aHi0GSDWw+DFPzwz+Hy0dteO68RU8wWgdmOIcy+/qFc=;
        b=rbjbxhHSNbnZEvlPFf7YOQMStUJxA8b6NuPBArYitgUWsdxBZHmBicnwsImf32vwLp
         Nisvaogax97H0RmMYjzexNLK9XXCqGSr1YC80fb0o8LcLjrJbUkJl+boHi8w4dqNywqF
         emBUIZIfiaOKfh0fvT67aFJkYQsQWTOy9Ea671XDDdIUu+pUb7+LQcav2B+Hs4lH77Nk
         LxYJWyJXZzVUm+QIVCaA0k3oWt51jJb3W57vXpesxTIBcteNI6Xys3gWe+KrzU3OzuKS
         AYCVw1EbBZlYduUzToQrAJ9pCN5LmYIa5SO71QKb5ubKmpDAPbOiyKzFlJNpxLb/hUMh
         rg2Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0biq42Iu2Esy/tkJl1vEkd+p/Te4HyZWIPpmjPsQw92Z6/VvJSUdgueiO+EZqXfJXxLkqo/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy7gbdZHPjQ3sR6MKy/SSxFyotYev+F3QlBBdUzzYKIKm3yoNJ
	TWT1aMgCpg/LZl5FJLs0WeY7FF8AeTDRiI0YupXEs5dCYrAlpKlEA5QlFt+zsNLwNiOv/sxtEcH
	byfPoVjl5Zq9Zoleh7MSpt7D/KLNmXRVzACbhvX1ZfuZvxKXxnNuCXHUmDeE=
X-Google-Smtp-Source: AGHT+IE8e6TZwBMJKL7y90nEbznBhuBiS/GtlVHJKR1ml/b1KG3VAoMOrpAzwKfMju3KxqSIT3PgxZH9QyyiaDLlAFUqlAPy4kZp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3486:b0:433:3315:e9ee with SMTP id
 e9e14a558f8ab-4335f41dccamr34232925ab.10.1762500687896; Thu, 06 Nov 2025
 23:31:27 -0800 (PST)
Date: Thu, 06 Nov 2025 23:31:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690da04f.a70a0220.22f260.0028.GAE@google.com>
Subject: [syzbot] [net?] [mm?] INFO: rcu detected stall in rescuer_thread (2)
From: syzbot <syzbot+d5f7a5097c24c7c2dbbb@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b1d9154878ce Merge branch 'net-mlx5e-shampo-fixes-for-64kb..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=15cc5bcd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e46b8a1c645465a9
dashboard link: https://syzkaller.appspot.com/bug?extid=d5f7a5097c24c7c2dbbb
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=134820b4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bef31d61ceb8/disk-b1d91548.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/67c31be6c377/vmlinux-b1d91548.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7b9f62743e14/bzImage-b1d91548.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d5f7a5097c24c7c2dbbb@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	(detected by 0, t=12991 jiffies, g=11121, q=1246 ncpus=2)
rcu: All QSes seen, last rcu_preempt kthread activity 3112 (4294972946-4294969834), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 3112 jiffies! g11121 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27288 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7026
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2285
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 6005 Comm: kworker/R-wg-cr Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: wg-crypt-wg2 wg_packet_tx_worker
RIP: 0010:rb_erase+0xb/0xe60 lib/rbtree.c:441
Code: ca 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 41 57 41 56 41 55 <41> 54 53 48 83 ec 28 48 89 f3 49 89 fd 48 b9 00 00 00 00 00 fc ff
RSP: 0018:ffffc90000a08ce0 EFLAGS: 00000046
RAX: 0000000000000000 RBX: ffff8880b8927c90 RCX: ffff88801f7a5ac0
RDX: 0000000000010000 RSI: ffff8880b8927c90 RDI: ffff88807de66340
RBP: 1ffff1100fbccc68 R08: ffffffff8f7cdc77 R09: 1ffffffff1ef9b8e
R10: dffffc0000000000 R11: fffffbfff1ef9b8f R12: ffff8880b8927c98
R13: dffffc0000000000 R14: ffff88807de66340 R15: 1ffff11017124f93
FS:  0000000000000000(0000) GS:ffff88812623c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056323a462a38 CR3: 000000002891e000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 rb_erase_cached include/linux/rbtree.h:126 [inline]
 timerqueue_del+0xae/0x100 lib/timerqueue.c:57
 __remove_hrtimer kernel/time/hrtimer.c:1114 [inline]
 __run_hrtimer kernel/time/hrtimer.c:1757 [inline]
 __hrtimer_run_queues+0x364/0xc60 kernel/time/hrtimer.c:1841
 hrtimer_interrupt+0x45b/0xaa0 kernel/time/hrtimer.c:1903
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1041 [inline]
 __sysvec_apic_timer_interrupt+0x10b/0x410 arch/x86/kernel/apic/apic.c:1058
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1052
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:queued_write_lock_slowpath+0x125/0x260 kernel/locking/qrwlock.c:85
Code: 00 01 00 00 43 0f b6 04 27 84 c0 74 35 89 d9 80 e1 07 80 c1 03 38 c1 7c 29 48 89 df e8 e4 b8 dc f6 eb 1f f3 90 43 0f b6 04 27 <84> c0 74 14 89 d9 80 e1 07 80 c1 03 38 c1 7c 08 48 89 df e8 c3 b8
RSP: 0018:ffffc90003337300 EFLAGS: 00000206
RAX: 0000000000000000 RBX: ffffffff8f3dd900 RCX: ffffffff8b490058
RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffffff8f3dd900
RBP: ffffc900033373b0 R08: ffffffff8f3dd903 R09: 1ffffffff1e7bb20
R10: dffffc0000000000 R11: fffffbfff1e7bb21 R12: dffffc0000000000
R13: 1ffff92000666e64 R14: ffffc90003337350 R15: 1ffffffff1e7bb20
 queued_write_lock include/asm-generic/qrwlock.h:101 [inline]
 do_raw_write_lock+0x1f2/0x260 kernel/locking/spinlock_debug.c:211
 ___neigh_create+0xe81/0x2260 net/core/neighbour.c:690
 ip6_finish_output2+0x1175/0x1480 net/ipv6/ip6_output.c:128
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip6_output+0x340/0x550 net/ipv6/ip6_output.c:247
 ip6tunnel_xmit include/net/ip6_tunnel.h:162 [inline]
 udp_tunnel6_xmit_skb+0x68d/0xb30 net/ipv6/ip6_udp_tunnel.c:112
 send6+0x5ac/0x8d0 drivers/net/wireguard/socket.c:152
 wg_socket_send_skb_to_peer+0x111/0x1d0 drivers/net/wireguard/socket.c:178
 wg_packet_create_data_done drivers/net/wireguard/send.c:251 [inline]
 wg_packet_tx_worker+0x1c8/0x7c0 drivers/net/wireguard/send.c:276
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 rescuer_thread+0x53c/0xdd0 kernel/workqueue.c:3523
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
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

