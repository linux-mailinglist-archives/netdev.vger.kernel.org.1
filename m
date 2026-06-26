Return-Path: <netdev+bounces-302103-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OO7qOW0aPmqL/wgAu9opvQ
	(envelope-from <netdev+bounces-302103-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 08:21:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9596CA9D5
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 08:21:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302103-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302103-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 407E63040400
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 06:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6B93D6498;
	Fri, 26 Jun 2026 06:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA2D3D567F
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 06:20:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782454823; cv=none; b=gihf8rRe5rPHj8prj/NT1mE7ABk92R8AbnZ/ts0zHnvnR9wxp2xZf+sHYOjIuxK4v2g/6BvinBqOopj7vwT+cPj2PDuC3WRjo6/QYKMp9OFvWXA2+FK284nyBITFXd4Y0bz+IkrIZoSkk8Ni6JuRXqvZU9JTVHffOSW4PqlQRNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782454823; c=relaxed/simple;
	bh=lyZdV/EbBDKR8/goZdWfs2R3u+lOe2Ywc8YyeIAXZ9I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=si3Lj1iyuUAvv3+w8TyAMiX9jFK9fbjyWM9wq3KOAqVOtEY4AwJfkOmooS6D5ZKTlufFB2KJcV3qsiRnCmsmCHgUEUKlT597udL8pDdXme4kzGXKQ+7qKJAl0dIic0uxeDYPTa5/RJ/9KE8d8JOJho1ZmsbQ2LxKnY+6+HAFplE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-485ebc5706cso2990021b6e.0
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 23:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782454821; x=1783059621;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IRzKgTpajedmViehhXi8vTT76UuMXhSsrIZNew9B7fE=;
        b=j+X4NWy7/xsRcjY33K9tCUUG4E8wmGaxN5sqBxNvxWS/iIXiXFSkamPeR9tpciVYzM
         GcbCa4fl7pwj4LdwGjjaZ+Jbcp7WfarSa++TuCU75A9fVaX7OpzjXxZiYprH9G+BrmsE
         caRreKYcBWUA8A1+9AO6uLEEwPLjol3mHvf4fpyML/1T+W/S9BycZePiK9QZoIwoeeB6
         K+Qkd8E7xwLl+5FAFAcv1h7QLjjdPYJha+0l2b1J85bVUhTk76ZdcQ+5gUcYgQq+H88X
         uVHOuPvrlD4ITMbxc3QeAmVkbwUgE3YMiuHPR+h8C/DOEdX3CzuCTIrIetKNfcwK8bZJ
         YvwA==
X-Forwarded-Encrypted: i=1; AFNElJ+o53OTjTAT5RYU2GWEB9BDe99ZcOi5LJYRTU8cFROTXc9XStk5kIImNehxX1AFme1o/2Cdj7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3/KCmwLfvRS81T6xSfr42TAkj4oKT3oul5ByHMK7yvnFm/stA
	qtw1kV/DYEP1uZCeK2rhVEXEiTQHJtMKFStC+z2fa/yN+WDl4Enc7GbO+3oS4lnDfUnblecqQ3V
	bUT70RrfA7haJ1MZSV+xT9quXh+txNlP77WroFmhtjd68GxI7CFGZDnUvSS4=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:19a0:b0:48a:c055:d791 with SMTP id
 5614622812f47-48ee2851637mr12741485b6e.5.1782454821205; Thu, 25 Jun 2026
 23:20:21 -0700 (PDT)
Date: Thu, 25 Jun 2026 23:20:21 -0700
In-Reply-To: <69ad01b6.050a0220.310d8.0006.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a3e1a25.b42ede87.2ae58d.0000.GAE@google.com>
Subject: Re: [syzbot] [net?] BUG: soft lockup in perf_event_open (2)
From: syzbot <syzbot+e04801269a8f6321dd79@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, eperezma@redhat.com, irogers@google.com, 
	james.clark@linaro.org, jasowang@redhat.com, jolsa@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	mst@redhat.com, namhyung@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, peterz@infradead.org, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=3c3d59be33cf7e9a];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302103-lists,netdev=lfdr.de,e04801269a8f6321dd79];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,storage.googleapis.com:url,vger.kernel.org:from_smtp,appspotmail.com:email,syzkaller.appspot.com:url];
	FORGED_RECIPIENTS(0.00)[m:acme@kernel.org,m:adrian.hunter@intel.com,m:alexander.shishkin@linux.intel.com,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:eperezma@redhat.com,m:irogers@google.com,m:james.clark@linaro.org,m:jasowang@redhat.com,m:jolsa@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-perf-users@vger.kernel.org,m:mark.rutland@arm.com,m:mingo@redhat.com,m:mst@redhat.com,m:namhyung@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:peterz@infradead.org,m:syzkaller-bugs@googlegroups.com,m:virtualization@lists.linux.dev,m:xuanzhuo@linux.alibaba.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_RCPT(0.00)[netdev];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D9596CA9D5

syzbot has found a reproducer for the following issue on:

HEAD commit:    4edcdefd4083 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16da941e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c3d59be33cf7e9a
dashboard link: https://syzkaller.appspot.com/bug?extid=e04801269a8f6321dd79
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164054ea580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-4edcdefd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/01cc5d298db0/vmlinux-4edcdefd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/59e4cf862ca3/bzImage-4edcdefd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e04801269a8f6321dd79@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	(detected by 0, t=10502 jiffies, g=61569, q=162 ncpus=1)
rcu: All QSes seen, last rcu_preempt kthread activity 10502 (4294967357-4294956855), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 10502 jiffies! g61569 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27464 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5510 [inline]
 __schedule+0x17d9/0x56c0 kernel/sched/core.c:7234
 __schedule_loop kernel/sched/core.c:7311 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7326
 schedule_timeout+0x152/0x2c0 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x30c/0x11f0 kernel/rcu/tree.c:2123
 rcu_gp_kthread+0x9e/0x2b0 kernel/rcu/tree.c:2325
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 UID: 0 PID: 5714 Comm: syz.3.20 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:unwind_next_frame+0x19ae/0x2550 arch/x86/kernel/unwind_orc.c:677
Code: e8 03 42 0f b6 04 20 84 c0 0f 85 b6 0a 00 00 4c 89 e8 48 c1 e8 03 42 0f b6 04 20 84 c0 0f 85 c5 0a 00 00 48 0f bf 03 49 01 c0 <49> 8d 56 40 4c 89 f7 4c 89 c6 e8 33 0e 00 00 84 c0 0f 84 4e 01 00
RSP: 0018:ffffc900000074e0 EFLAGS: 00000283
RAX: fffffffffffffff0 RBX: ffffffff91709a28 RCX: 0000000000000000
RDX: ffffffff91709a2a RSI: 0000000000000008 RDI: ffffc900000075e8
RBP: 1ffffffff22e1345 R08: ffffc900034df7c8 R09: 0000000000000000
R10: ffffc900000075d8 R11: fffff52000000ebd R12: dffffc0000000000
R13: ffffffff91709a29 R14: ffffc90000007588 R15: ffffc900000075d0
FS:  0000555594cee500(0000) GS:ffff88808c81b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5209872780 CR3: 0000000035426000 CR4: 0000000000352ef0
Call Trace:
 <IRQ>
 arch_stack_walk+0x11b/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0xa9/0x100 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2705 [inline]
 slab_free mm/slub.c:6405 [inline]
 kmem_cache_free+0x182/0x650 mm/slub.c:6532
 kfree_skb_reason include/linux/skbuff.h:1323 [inline]
 kfree_skb include/linux/skbuff.h:1332 [inline]
 hsr_forward_skb+0x1a27/0x28c0 net/hsr/hsr_forward.c:753
 send_hsr_supervision_frame+0x733/0xcf0 net/hsr/hsr_device.c:364
 hsr_announce+0x1db/0x370 net/hsr/hsr_device.c:421
 call_timer_fn+0x192/0x5e0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers kernel/time/timer.c:2374 [inline]
 __run_timer_base+0x652/0x8b0 kernel/time/timer.c:2386
 run_timer_base kernel/time/timer.c:2395 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2405
 handle_softirqs+0x225/0x840 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xca/0x220 kernel/softirq.c:735
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:finish_task_switch+0x417/0xc60 kernel/sched/core.c:5361
Code: 04 00 00 41 c7 84 24 20 0e 00 00 00 00 00 00 0f 1f 44 00 00 49 83 c4 48 4c 89 e7 e8 a3 5a 23 0a e8 6e bc 39 00 fb 4c 8b 65 c8 <49> 8d bc 24 f8 16 00 00 48 89 f8 48 c1 e8 03 42 0f b6 04 30 84 c0
RSP: 0018:ffffc900034df880 EFLAGS: 00000206
RAX: 00000000000009c3 RBX: ffff88801fc3bf20 RCX: 0000000080000001
RDX: 0000000000000006 RSI: ffffffff8dfe613c RDI: ffffffff8c2aaf80
RBP: ffffc900034df8d0 R08: ffffffff9032f8f7 R09: 1ffffffff2065f1e
R10: dffffc0000000000 R11: fffffbfff2065f1f R12: ffff88803292a540
R13: ffff88801fc3bee8 R14: dffffc0000000000 R15: 1ffff11003f877e4
 context_switch kernel/sched/core.c:5513 [inline]
 __schedule+0x17e1/0x56c0 kernel/sched/core.c:7234
 preempt_schedule_common+0x82/0xd0 kernel/sched/core.c:7413
 preempt_schedule_thunk+0x16/0x40 arch/x86/entry/thunk.S:12
 __mutex_lock_common kernel/locking/mutex.c:656 [inline]
 __mutex_lock+0x321/0x1550 kernel/locking/mutex.c:821
 __do_sys_perf_event_open kernel/events/core.c:14249 [inline]
 __se_sys_perf_event_open+0x1984/0x1d40 kernel/events/core.c:13881
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f520999ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd9f0e1458 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 00007f5209c15fa0 RCX: 00007f520999ce59
RDX: bfffffffffffffff RSI: 0000000000000000 RDI: 0000200000000180
RBP: 00007f5209a32e6f R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5209c15fac R14: 00007f5209c15fa0 R15: 00007f5209c15fa0
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

