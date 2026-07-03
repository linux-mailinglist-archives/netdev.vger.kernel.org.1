Return-Path: <netdev+bounces-304384-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HHpgAMteR2qtXAAAu9opvQ
	(envelope-from <netdev+bounces-304384-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:03:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E486FF57A
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:03:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304384-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304384-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD4D5300D770
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DBA3812F1;
	Fri,  3 Jul 2026 07:03:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEA93019AA
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 07:03:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062213; cv=none; b=I0dGdnd65JUGe/Vyd8/aWCE2F6CVEr/aPYE7T6+5YInxnXEQz8ppJsyUlRU+Dp8mHlEtMdMnOau8/Gk2nC7/gdmMtu28QdyTTfNxMiW1tS70qmOf/lHV52W6bc8uXtHnys/nGGCGwsKDFyWC+2SfIPqhJiCpzMJVmSNeYQOlShw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062213; c=relaxed/simple;
	bh=vhp054vnbnP6+7r+sBriNZ3dgxSrK05jGxo6Eocwv4g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ijSForevQnI7nIH+2wj1KpCfwasTPuSyC4Sp65KoQgNQuQVo6NQg8c7Der2g/sZBDlUW6yXPwv06LAfqIDflJD93jCXmtQWbtEiQS5SKzuTHPE/Zn4Bks6VhVE5H2mmZr9iBP5Pdl/PSSIxEG51AxWktUGSSw0z/NF9YdzOvvmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-6a196857c7aso276721eaf.2
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 00:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783062211; x=1783667011;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u0oqcBlSmLAPJh4Lig2GODnq3S05p+UkLPiMOHCs7Sg=;
        b=VBpb3KbGYUnCdxakALsxttrhOyYxx98Qmqz6scHrMrGT57Y+YBguI8fK5mmuXmkAOo
         /PrbuUG9eoKFPo4loheGHYb7glOH8G2JZW/u1nyXy5vn+mYi+B62fxYHxSPkju28emPk
         PzpQp5nTU8q2Es2Tk9tT7YhA3fYu0G4YcUSA+xnIi41MDBtpgmzItL0moVqkeR7g4gjk
         o2bpZfpe8OfXbvTbI4sQtlusxyhSp8nNWwzOph6Q4qkJeBfZUuvTKFejLV7YjX7t8T4h
         19G6ETC5H+oL8ramss3oaK1v61+C6cN9FrxrZf1/2OdYiNiPuUJ/GfLs9KXINXOmoWjK
         RKjA==
X-Forwarded-Encrypted: i=1; AFNElJ/q/F0ElblMbLo6fVHTTaUPeWkPqxE5kv+URDp/7sKPS+zp5Vb/3r8WMCPveBfldhTGee+KVmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgk9SouPep3ZCM+k2AWLt6xmtaHTAksDUMOUUvVu/6U/WJG1cQ
	UijAQ3YS5pgoPakL3J6e3AffSB8lBFPoqSg/5F4lkfSUYXnieOgcqCUx1v+mWJYtTYZDxMfV33A
	S/aT4TAP8abf8wfWhlEaQArPvhd9gnc3ulC57RdvFk1ZyaJDfidFwu8ghneY=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:622:b0:6a1:50eb:2117 with SMTP id
 006d021491bc7-6a30d8fb717mr5126658eaf.59.1783062211048; Fri, 03 Jul 2026
 00:03:31 -0700 (PDT)
Date: Fri, 03 Jul 2026 00:03:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a475ec3.6912059f.e0473.000a.GAE@google.com>
Subject: [syzbot] [mm?] INFO: rcu detected stall in unmap_region
From: syzbot <syzbot+2ad5ec205a38c46522b3@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, jannh@google.com, liam@infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org, 
	netdev@vger.kernel.org, pfalcato@suse.de, syzkaller-bugs@googlegroups.com, 
	vbabka@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=86ba763b42fa66a];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:jannh@google.com,m:liam@infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:ljs@kernel.org,m:netdev@vger.kernel.org,m:pfalcato@suse.de,m:syzkaller-bugs@googlegroups.com,m:vbabka@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304384-lists,netdev=lfdr.de,2ad5ec205a38c46522b3];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,appspotmail.com:email,syzkaller.appspot.com:url,storage.googleapis.com:url,goo.gl:url];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 88E486FF57A

Hello,

syzbot found the following issue on:

HEAD commit:    32f1c2bbb26a net: airoha: dma map xmit frags with skb_frag..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=116c2c0a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=86ba763b42fa66a
dashboard link: https://syzkaller.appspot.com/bug?extid=2ad5ec205a38c46522b3
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132f5861580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7b7c3a22a8ed/disk-32f1c2bb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/168b43c87305/vmlinux-32f1c2bb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/70704720d284/bzImage-32f1c2bb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2ad5ec205a38c46522b3@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...!: (1 GPs behind) idle=6664/1/0x4000000000000000 softirq=17730/17732 fqs=2
rcu: 	(detected by 1, t=10502 jiffies, g=17101, q=1895 ncpus=2)
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 6010 Comm: modprobe Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
RIP: 0010:lock_release+0x5/0x3c0 kernel/locking/lockdep.c:5876
Code: e9 4f fe ff ff 41 bf 2f 00 00 00 e9 06 ff ff ff 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 <41> 57 41 56 41 55 41 54 53 48 83 ec 30 49 89 f5 49 89 fe 65 48 8b
RSP: 0018:ffffc90000007db0 EFLAGS: 00000082
RAX: 932ea09fa7cced00 RBX: 0000000000000092 RCX: 0000000000000002
RDX: 0000000000000001 RSI: ffffffff81b30e19 RDI: ffffffff9a73d4c8
RBP: ffff88807e29b300 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52000000f98 R12: ffff8880b86281c0
R13: dffffc0000000000 R14: ffffffff9a73d4b0 R15: ffff8880b8628350
FS:  0000000000000000(0000) GS:ffff888125226000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffae81e84e8 CR3: 000000007ee52000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:176 [inline]
 _raw_spin_unlock_irqrestore+0x1b/0x80 kernel/locking/spinlock.c:198
 debug_hrtimer_deactivate kernel/time/hrtimer.c:490 [inline]
 __run_hrtimer kernel/time/hrtimer.c:2000 [inline]
 __hrtimer_run_queues+0x239/0xa10 kernel/time/hrtimer.c:2096
 hrtimer_interrupt+0x448/0x910 kernel/time/hrtimer.c:2215
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1051 [inline]
 __sysvec_apic_timer_interrupt+0x102/0x430 arch/x86/kernel/apic/apic.c:1068
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:do_zap_pte_range mm/memory.c:1819 [inline]
RIP: 0010:zap_pte_range mm/memory.c:1934 [inline]
RIP: 0010:zap_pmd_range mm/memory.c:2020 [inline]
RIP: 0010:zap_pud_range mm/memory.c:2048 [inline]
RIP: 0010:zap_p4d_range mm/memory.c:2069 [inline]
RIP: 0010:__zap_vma_range+0xfbd/0x4f10 mm/memory.c:2109
Code: 4c 89 64 24 30 4c 89 e6 48 83 e6 9f 31 ff e8 3a 4a ad ff 4d 89 e7 49 83 e4 9f 75 2f 48 8b 44 24 10 4c 01 e8 48 83 f8 01 74 28 <e8> 3e 45 ad ff 48 83 c3 08 49 ff c5 4d 89 f4 eb a3 4d 89 ef e8 2a
RSP: 0018:ffffc90003287000 EFLAGS: 00000286
RAX: ffffffffffffff73 RBX: ffff888034e9d190 RCX: ffff88802dcf1f00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900032872f0 R08: ffff888078979803 R09: 1ffff1100f12f300
R10: dffffc0000000000 R11: ffffed100f12f301 R12: 0000000000000000
R13: 0000000000000032 R14: dffffc0000000000 R15: 0000000000000000
 unmap_vmas+0x390/0x550 mm/memory.c:2178
 unmap_region+0x208/0x330 mm/vma.c:488
 vms_clear_ptes mm/vma.c:1303 [inline]
 vms_clean_up_area mm/vma.c:1315 [inline]
 __mmap_setup mm/vma.c:2476 [inline]
 __mmap_region mm/vma.c:2756 [inline]
 mmap_region+0xc62/0x2310 mm/vma.c:2860
 do_mmap+0xc3b/0x10c0 mm/mmap.c:560
 vm_mmap_pgoff+0x272/0x4e0 mm/util.c:581
 ksys_mmap_pgoff+0x4dc/0x760 mm/mmap.c:606
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffae8219242
Code: 08 00 04 00 00 eb e2 90 41 f7 c1 ff 0f 00 00 75 27 55 89 cd 53 48 89 fb 48 85 ff 74 33 41 89 ea 48 89 df b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 5e 5b 5d c3 0f 1f 00 c7 05 46 40 01 00 16 00
RSP: 002b:00007ffec64cd428 EFLAGS: 00000206 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007ffae7f73000 RCX: 00007ffae8219242
RDX: 0000000000000005 RSI: 000000000014e000 RDI: 00007ffae7f73000
RBP: 0000000000000812 R08: 0000000000000000 R09: 0000000000028000
R10: 0000000000000812 R11: 0000000000000206 R12: 00007ffec64cd478
R13: 00007ffae81ed5f0 R14: 00007ffec64cdc60 R15: 00000fffd8c99a88
 </TASK>
rcu: rcu_preempt kthread starved for 10477 jiffies! g17101 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:28192 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
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
CPU: 1 UID: 0 PID: 4992 Comm: udevd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
RIP: 0010:csd_lock_wait kernel/smp.c:342 [inline]
RIP: 0010:smp_call_function_many_cond+0x10b0/0x14b0 kernel/smp.c:892
Code: c0 75 73 41 8b 1e 89 de 83 e6 01 31 ff e8 d8 1e 0c 00 83 e3 01 48 bb 00 00 00 00 00 fc ff df 75 07 e8 84 1a 0c 00 eb 37 f3 90 <41> 0f b6 04 1c 84 c0 75 10 41 f7 06 01 00 00 00 74 1e e8 69 1a 0c
RSP: 0018:ffffc90003837580 EFLAGS: 00000293
RAX: ffffffff81ba5717 RBX: dffffc0000000000 RCX: ffff88807e5a0000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc900038376a8 R08: ffffffff9032d2f7 R09: 1ffffffff2065a5e
R10: dffffc0000000000 R11: fffffbfff2065a5f R12: 1ffff110170c85fd
R13: ffff8880b873c448 R14: ffff8880b8642fe8 R15: 0000000000000000
FS:  00007fdd3255d880(0000) GS:ffff888125326000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002c919703e000 CR3: 000000007e7f2000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 on_each_cpu_cond_mask+0x3f/0x80 kernel/smp.c:1057
 __flush_tlb_multi arch/x86/include/asm/paravirt.h:46 [inline]
 flush_tlb_multi arch/x86/mm/tlb.c:1361 [inline]
 flush_tlb_mm_range+0x5c4/0x1090 arch/x86/mm/tlb.c:1451
 dup_mmap+0x1786/0x1d90 mm/mmap.c:1905
 dup_mm kernel/fork.c:1538 [inline]
 copy_mm+0x11a/0x480 kernel/fork.c:1590
 copy_process+0x1e99/0x43f0 kernel/fork.c:2288
 kernel_clone+0x2d7/0x940 kernel/fork.c:2747
 __do_sys_clone kernel/fork.c:2888 [inline]
 __se_sys_clone kernel/fork.c:2872 [inline]
 __x64_sys_clone+0x1b6/0x230 kernel/fork.c:2872
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdd31ef1636
Code: 89 df e8 6d e8 f6 ff 45 31 c0 31 d2 31 f6 64 48 8b 04 25 10 00 00 00 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 52 89 c5 85 c0 75 31 64 48 8b 04 25 10 00 00
RSP: 002b:00007ffcd95f6670 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffcd95f6678 RCX: 00007fdd31ef1636
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000564712dd5910 R08: 0000000000000000 R09: 0000564712ddd8e0
R10: 00007fdd3255db50 R11: 0000000000000246 R12: 00007ffcd95f6a30
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
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

