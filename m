Return-Path: <netdev+bounces-300970-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x9kACtTnOGqejwcAu9opvQ
	(envelope-from <netdev+bounces-300970-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 09:44:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F106AD57A
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 09:44:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300970-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300970-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 850723002771
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 07:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E3136D9F1;
	Mon, 22 Jun 2026 07:42:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB6B36DA08
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 07:42:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782114145; cv=none; b=KONGuDMfl4ZfGsQgR6OD/1B/opERVnWsbSkRfxQyj72ClwHfm9jZMTRl9flaSBdDRiRQCgCF7lC+qpqq0hoW6eBBMHH2bvk7RFspuIwkZTTMNedU0dUQA+429VWf/ol7/K/au0LsL89Y0fQTj54tUBIU/dWOBYO5PQOH8XZc2AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782114145; c=relaxed/simple;
	bh=wvheAgQKuEuK+AbYeCFSNsXqSoV2Afp50MQUpMq0XLk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OQiadIfAVYvue7ijJ6bfErSPj6b/4YrFn4v9qHNcmKg7Q/LPNCBtkn8K+IffJfycN+bJ70afJ0UY+G4Vp30Vc/chkVIwnicEkl5QQ26Od/wF0Gkw1cQyj3sXR84eYRDbJqc9B5L5MkiPadAFtKLYYu/LA1+G/9x0LwG1xu5D+tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-486cc29e03bso8160816b6e.3
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 00:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782114143; x=1782718943;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IQUNL7abn7FyBCVxw0XQrU4Z9rZYYYwgqGA3doOw68k=;
        b=hzTrEMAxs2hhX+hu6MHGUeaOFGsKBxU+tGMYqqtgCj2i2aDz0GuUgRjCXRQcK/wTP9
         SWbwPOggpeMXOBNR+omqOoIRMjgb13El8f/sKUPVIEhuBVQUbjog52C+ewmgzLjdIJmt
         fqBXH6kJJtD0E4r2m8dfYP8swW+UaKfmgoJwdLgwpIzRz9rYczpBAn1chq/m9WchMjqY
         TKzZDpB7ngTuYNb04gzZ7cRKrNiR0BlmCmJcRFeBZSSl7HyVsWUFKEvjjduo7GYVLwpu
         tlQd8L8GBVXoUvbQKRRoSTq4GWF/ybiU9VZkIWG/kE1NhIaeYdZR2YlxMBoFIxgtEdHZ
         dZhg==
X-Forwarded-Encrypted: i=1; AFNElJ/JlqbGKPBBWOv95tH6hsXuSsf9DLtN3Q8/3NRlF+e+Cj+nG6D1jXcZzUk5jzupLDYD1Dwkojo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXUaiCItIUYbWhUb8RIBpEq+RxaGGVF8ACgw7PrrC9/lRGfn3W
	7ptwPDv2bDIYultUWMAUS+uEga2LqjcUa/sD4+HD3rTqZiy8FpexyeRLoROttoDDOZ0Azl8iehM
	AhggcpptTulz8ivJIbpNMzRAaxYhPOTcYkSVd0pHKgQiWjLDWlGx8L3D3/hg=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:191b:b0:485:5982:4cfc with SMTP id
 5614622812f47-4896ac94f70mr11176492b6e.33.1782114143419; Mon, 22 Jun 2026
 00:42:23 -0700 (PDT)
Date: Mon, 22 Jun 2026 00:42:23 -0700
In-Reply-To: <000000000000f9be320619be1c0a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a38e75f.713c5d62.148f7.000d.GAE@google.com>
Subject: Re: [syzbot] [net?] INFO: task hung in nsim_destroy (4)
From: syzbot <syzbot+8141dcbd23a8f857798a@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=9a9f723a32776544];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300970-lists,netdev=lfdr.de,8141dcbd23a8f857798a];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,appspotmail.com:email,syzkaller.appspot.com:url,vger.kernel.org:from_smtp,storage.googleapis.com:url,syzkaller.appspotmail.com:from_mime];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 61F106AD57A

syzbot has found a reproducer for the following issue on:

HEAD commit:    b85966adbf5d Merge tag 'net-next-7.2' of git://git.kernel...
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11f167b6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a9f723a32776544
dashboard link: https://syzkaller.appspot.com/bug?extid=8141dcbd23a8f857798a
compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15cf400a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1013a50e580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d65306d96573/disk-b85966ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ef43139aab0e/vmlinux-b85966ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/26d4d1ab67c3/bzImage-b85966ad.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8141dcbd23a8f857798a@syzkaller.appspotmail.com

INFO: task kworker/R-netns:8 blocked for more than 140 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/R-netns state:D stack:27768 pid:8     tgid:8     ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5504 [inline]
 __schedule+0x17d9/0x56c0 kernel/sched/core.c:7228
 __schedule_loop kernel/sched/core.c:7307 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7322
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7379
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7bf/0x1550 kernel/locking/mutex.c:821
 rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 rtnl_net_dev_lock+0x257/0x2f0 net/core/dev.c:2163
 unregister_netdevice_notifier_dev_net+0x96/0x450 net/core/dev.c:2208
 nsim_destroy+0xfd/0x800 drivers/net/netdevsim/netdev.c:1183
 __nsim_dev_port_del+0x14e/0x200 drivers/net/netdevsim/dev.c:1547
 nsim_dev_port_del_all drivers/net/netdevsim/dev.c:1561 [inline]
 nsim_dev_reload_destroy+0x288/0x490 drivers/net/netdevsim/dev.c:1785
 nsim_dev_reload_down+0x8a/0xc0 drivers/net/netdevsim/dev.c:1038
 devlink_reload+0x1c5/0x890 net/devlink/dev.c:462
 devlink_pernet_pre_exit+0x1ff/0x420 net/devlink/core.c:560
 ops_pre_exit_list net/core/net_namespace.c:161 [inline]
 ops_undo_list+0x17d/0x8d0 net/core/net_namespace.c:234
 cleanup_net+0x572/0x810 net/core/net_namespace.c:702
 process_one_work kernel/workqueue.c:3314 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3397
 rescuer_thread+0x7b6/0x10b0 kernel/workqueue.c:3621
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task kworker/0:1:10 blocked for more than 142 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:1     state:D stack:27096 pid:10    tgid:10    ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: events request_firmware_work_func
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5504 [inline]
 __schedule+0x17d9/0x56c0 kernel/sched/core.c:7228
 __schedule_loop kernel/sched/core.c:7307 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7322
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7379
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7bf/0x1550 kernel/locking/mutex.c:821
 regdb_fw_cb+0x7d/0x1c0 net/wireless/reg.c:1005
 request_firmware_work_func+0xf2/0x1a0 drivers/base/firmware_loader/main.c:1152
 process_one_work kernel/workqueue.c:3314 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3397
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3478
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task kworker/u8:0:12 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:0    state:D stack:23864 pid:12    tgid:12    ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5504 [inline]
 __schedule+0x17d9/0x56c0 kernel/sched/core.c:7228
 __schedule_loop kernel/sched/core.c:7307 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7322
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7379
 __mutex_lock_common kernel/locking/mutex.c:726 [inline]
 __mutex_lock+0x7bf/0x1550 kernel/locking/mutex.c:821
 rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 addrconf_dad_work+0x116/0x15c0 net/ipv6/addrconf.c:4223
 </TASK>
INFO: task syz-executor831:5632 blocked for more than 144 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor831 state:R  running task     stack:22336 pid:5632  tgid:5632  ppid:5629   task_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5504 [inline]
 __schedule+0x17d9/0x56c0 kernel/sched/core.c:7228
 </TASK>
INFO: lockdep is turned off.
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:353 [inline]
 watchdog+0xfd7/0x1030 kernel/hung_task.c:561
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 808 Comm: kworker/0:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Workqueue: wg-crypt-wg0 wg_packet_encrypt_worker
RIP: 0010:memset_orig+0x25/0xb0 arch/x86/lib/memset_64.S:64
Code: 90 90 90 90 90 49 89 fa 40 0f b6 ce 48 b8 01 01 01 01 01 01 01 01 48 0f af c1 41 89 f9 41 83 e1 07 75 74 48 89 d1 48 c1 e9 06 <74> 39 66 0f 1f 84 00 00 00 00 00 48 ff c9 48 89 07 48 89 47 08 48
RSP: 0018:ffffc90000006f20 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffc90000007078 RCX: 0000000000000000
RDX: 0000000000000010 RSI: 0000000000000000 RDI: ffffc90000007078
RBP: 1ffffffff2189698 R08: ffffc90000007087 R09: 0000000000000000
R10: ffffc90000007078 R11: fffff52000000e11 R12: dffffc0000000000
R13: ffffffff90c4b4c0 R14: ffffc90000007028 R15: ffffc90000007070
FS:  0000000000000000(0000) GS:ffff88812527c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055968609b450 CR3: 000000000e746000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 unwind_next_frame+0xd04/0x2550 arch/x86/kernel/unwind_orc.c:621
 __unwind_start+0x514/0x660 arch/x86/kernel/unwind_orc.c:787
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0xe3/0x150 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0xa9/0x100 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2700 [inline]
 slab_free mm/slub.c:6310 [inline]
 kmem_cache_free+0x182/0x650 mm/slub.c:6437
 nft_synproxy_eval_v4+0x383/0x530 net/netfilter/nft_synproxy.c:61
 nft_synproxy_do_eval+0x335/0x550 net/netfilter/nft_synproxy.c:142
 expr_call_ops_eval net/netfilter/nf_tables_core.c:237 [inline]
 nft_do_chain+0x48d/0x1b10 net/netfilter/nf_tables_core.c:285
 nft_do_chain_inet+0x360/0x4b0 net/netfilter/nft_chain_filter.c:162
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_slow+0xc5/0x220 net/netfilter/core.c:619
 nf_hook include/linux/netfilter.h:273 [inline]
 NF_HOOK+0x21f/0x3c0 include/linux/netfilter.h:316
 NF_HOOK+0x336/0x3c0 include/linux/netfilter.h:318
 __netif_receive_skb_one_core net/core/dev.c:6206 [inline]
 __netif_receive_skb net/core/dev.c:6319 [inline]
 process_backlog+0xa34/0x1860 net/core/dev.c:6670
 __napi_poll+0xaa/0x330 net/core/dev.c:7729
 napi_poll net/core/dev.c:7792 [inline]
 net_rx_action+0x61d/0xf50 net/core/dev.c:7949
 handle_softirqs+0x225/0x840 kernel/softirq.c:622
 do_softirq+0x76/0xd0 kernel/softirq.c:523
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xf8/0x130 kernel/softirq.c:450
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 ptr_ring_consume_bh include/linux/ptr_ring.h:393 [inline]
 wg_packet_encrypt_worker+0x16e2/0x1760 drivers/net/wireguard/send.c:293
 process_one_work kernel/workqueue.c:3314 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3397
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3478
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 2.314 msecs


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

