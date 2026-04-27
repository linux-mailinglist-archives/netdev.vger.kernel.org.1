Return-Path: <netdev+bounces-281275-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MApoA1go72lE8AAAu9opvQ
	(envelope-from <netdev+bounces-281275-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 11:11:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0335446F9FD
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 11:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B683A3005310
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 09:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1964C3B0AC2;
	Mon, 27 Apr 2026 09:11:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7CF3A1A50
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777281099; cv=none; b=hSzUT+m7DgNG7cDa36kHYk2W6lDAgQek9Itiv6dalKsBRtgza7j0N3pwdPu4f1KBwgLfdpAr/gokpTHcr+ZrTssRJY8uvwqJawXrL6MUDbXFgy0jEyWCPltx75AZdtd7w+kjIStXrSHEadJX7nKbK0mhLdVRjPvT5/SxEBVLR3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777281099; c=relaxed/simple;
	bh=/+RGmi8UYgJZMMabOKYRyox8vlbnwKzvHExmI0i11xI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZoBpvup4uINowrOpzvUSXevmHFije/ExO+IqIc37YzugPI16oO1b/6sPltt9gmj9aT6L8tM6ji8C9t+nTJ9mLKdeHMv4pvzsfeRwxidppdUjCM7bu3VDL8b0J7FcshZUaL2hf4+EydO64ML8qeID+bVj9dtukbx+OzALqDlbG5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-694916af128so7680751eaf.1
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 02:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777281096; x=1777885896;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fRbHymEEuW4nprtI7xydCrsOs1BoNisyMJ7+fr5JkqA=;
        b=mLnSqJU1gF3s/IEq/3DvbYClCfhOdswCNsDYWPN+tWFDxIegDVbl+j47NKPsNjkaEJ
         BNJkpoTyJAlU32j3k/xxyaC549U5AmcBekINrnqQxV0dX/izfAmI1qt3GYBIGtlWTiVq
         XknJbw5KszR1qydn6DJBKBUQ84uy8mFuS9u7cRT/5LsxN40UZeOr4QjQamVsTyDqFjeK
         SGKv3TEF8TXd4eEIebxRHLHaNipc8L41CkdFgw+RIPb1Ihdu70bGav+L1hj+ijQbmI7m
         8QM28B6jD8u34vVuh8HOo/Ne2SnDRMvq/oK0CLH8A0sYB37azZqHG442NWtzXvtSsIQp
         OOIA==
X-Forwarded-Encrypted: i=1; AFNElJ8u9zMpcpHt2EBOWufyy5w6sYOovk18IFAQ864C6PZuXTEU31c4D3/VUczfGMW3a2nKTib00/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDNWwSeYH2+xj1Gk5vvCGZoxqOFLOqfkaLmd5lMxjNbnR8ShY/
	VAppwTGDNYQ096Zc7B9VRVRENM/W4EYP6+n6nnvXlTofCQ9sR8VbP8PGjEV8XnZ8It8k9V8rYiI
	/2uNe1OYG9Ohn7bS+WAyDpA/LbHCxf64eMLVJuyu9OmETqD5AtsdW6nv85GY=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1842:b0:684:bf61:ed2b with SMTP id
 006d021491bc7-69462e1d490mr24387470eaf.14.1777281096245; Mon, 27 Apr 2026
 02:11:36 -0700 (PDT)
Date: Mon, 27 Apr 2026 02:11:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ef2848.170a0220.11de9.001b.GAE@google.com>
Subject: [syzbot] [wireguard?] BUG: soft lockup in wg_packet_decrypt_worker
From: syzbot <syzbot+27a6e390f71f14f4fecf@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 0335446F9FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=4e88e1f2f0b02f59];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-281275-lists,netdev=lfdr.de,27a6e390f71f14f4fecf];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	SUBJECT_HAS_QUESTION(0.00)[]

Hello,

syzbot found the following issue on:

HEAD commit:    897d54018cc9 Merge tag 'fbdev-for-7.1-rc1-2' of git://git...
git tree:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux master
console output: https://syzkaller.appspot.com/x/log.txt?x=10470ff6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e88e1f2f0b02f59
dashboard link: https://syzkaller.appspot.com/bug?extid=27a6e390f71f14f4fecf
compiler:       aarch64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/fa3fbcfdac58/non_bootable_disk-897d5401.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/abfbe0527fdf/vmlinux-897d5401.xz
kernel image: https://storage.googleapis.com/syzbot-assets/43fbdcd1dbf2/zImage-897d5401.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+27a6e390f71f14f4fecf@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [kworker/1:3:20255]
Modules linked in:
irq event stamp: 104395
hardirqs last  enabled at (104394): [<ffff8000857d18b0>] irqentry_exit_to_kernel_mode_after_preempt include/linux/irq-entry-common.h:515 [inline]
hardirqs last  enabled at (104394): [<ffff8000857d18b0>] arm64_exit_to_kernel_mode+0x50/0xc0 arch/arm64/kernel/entry-common.c:62
hardirqs last disabled at (104395): [<ffff8000857d5578>] __el1_irq arch/arm64/kernel/entry-common.c:493 [inline]
hardirqs last disabled at (104395): [<ffff8000857d5578>] el1_interrupt+0x28/0x60 arch/arm64/kernel/entry-common.c:509
softirqs last  enabled at (99688): [<ffff8000828b6d94>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (99688): [<ffff8000828b6d94>] ptr_ring_consume_bh include/linux/ptr_ring.h:377 [inline]
softirqs last  enabled at (99688): [<ffff8000828b6d94>] wg_packet_decrypt_worker+0x248/0x3a0 drivers/net/wireguard/receive.c:499
softirqs last disabled at (99692): [<ffff8000828b6bb4>] spin_lock_bh include/linux/spinlock.h:348 [inline]
softirqs last disabled at (99692): [<ffff8000828b6bb4>] ptr_ring_consume_bh include/linux/ptr_ring.h:375 [inline]
softirqs last disabled at (99692): [<ffff8000828b6bb4>] wg_packet_decrypt_worker+0x68/0x3a0 drivers/net/wireguard/receive.c:499
CPU: 1 UID: 0 PID: 20255 Comm: kworker/1:3 Tainted: G             L      syzkaller #0 PREEMPT 
Tainted: [L]=SOFTLOCKUP
Hardware name: linux,dummy-virt (DT)
Workqueue: wg-crypt-wg0 wg_packet_decrypt_worker
pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : memory_is_poisoned_n mm/kasan/generic.c:141 [inline]
pc : memory_is_poisoned mm/kasan/generic.c:172 [inline]
pc : check_region_inline mm/kasan/generic.c:191 [inline]
pc : kasan_check_range+0x38/0x1b4 mm/kasan/generic.c:200
lr : __kasan_check_read+0x20/0x2c mm/kasan/shadow.c:31
sp : ffff8000a19478c0
x29: ffff8000a19478c0 x28: ffff80008766bed0 x27: 0000000000000000
x26: 1fffe00003374a09 x25: 1fffe00003374a0b x24: ffff000019ba5058
x23: 0000000000000000 x22: 1ffff00014328f20 x21: 1ffff00014328f3c
x20: 0000000000000000 x19: ffff000019ba5048 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000001 x15: 0000000012224261
x14: 0000000000000001 x13: ffff800089e7c8d8 x12: ffff600003374a0a
x11: 1fffe00003374a09 x10: ffff600003374a09 x9 : dfff800000000000
x8 : ffff000019ba5048 x7 : 0000000000000001 x6 : ffff600003374a09
x5 : ffff000019ba5048 x4 : ffff000000000000 x3 : ffff8000857fe9b0
x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000000001
Call trace:
 check_region_inline mm/kasan/generic.c:188 [inline] (P)
 kasan_check_range+0x38/0x1b4 mm/kasan/generic.c:200 (P)
 queued_spin_lock_slowpath+0x610/0xf80 kernel/locking/qspinlock.c:197
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x258/0x308 kernel/locking/spinlock_debug.c:116
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:151 [inline]
 _raw_spin_lock_bh+0x58/0x68 kernel/locking/spinlock.c:182
 spin_lock_bh include/linux/spinlock.h:348 [inline]
 ptr_ring_consume_bh include/linux/ptr_ring.h:375 [inline]
 wg_packet_decrypt_worker+0x68/0x3a0 drivers/net/wireguard/receive.c:499
 process_one_work+0x810/0x1b1c kernel/workqueue.c:3302
 process_scheduled_works kernel/workqueue.c:3385 [inline]
 worker_thread+0x42c/0xc90 kernel/workqueue.c:3466
 kthread+0x2f0/0x388 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:858
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 19280 Comm: kworker/0:7 Tainted: G             L      syzkaller #0 PREEMPT 
Tainted: [L]=SOFTLOCKUP
Hardware name: linux,dummy-virt (DT)
Workqueue: wg-crypt-wg0 wg_packet_decrypt_worker
pstate: 10000005 (nzcV daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:176 [inline]
pc : arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline]
pc : lock_release+0x39c/0x424 kernel/locking/lockdep.c:5892
lr : lockdep_recursion_finish kernel/locking/lockdep.c:470 [inline]
lr : lock_release+0x37c/0x424 kernel/locking/lockdep.c:5891
sp : ffff8000a1eb7a40
x29: ffff8000a1eb7a50 x28: ffff00003f7678f0 x27: ffff000019ba50c0
x26: ffff600003374a19 x25: 1fffe00003374a18 x24: 0000000000000000
x23: ffff000012db5640 x22: ffff000012db61c0 x21: ffff8000828b6c88
x20: ffff000019ba5060 x19: ffff800087612208 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: ffff80008766f6e8
x14: 1ffff00010ecdedd x13: ffff800089e7c8d8 x12: ffff7000143d6f41
x11: 1ffff000143d6f40 x10: ffff7000143d6f40 x9 : dfff800000000000
x8 : 0000000000000003 x7 : 0000000000000001 x6 : 00000000000003e0
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 1fffe000025b6ac9
x2 : 0000000000000000 x1 : ffff7fffe29a8000 x0 : 00000000000000c0
Call trace:
 __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline] (P)
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline] (P)
 lock_release+0x39c/0x424 kernel/locking/lockdep.c:5892 (P)
 __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:194 [inline]
 _raw_spin_unlock_bh+0x28/0x54 kernel/locking/spinlock.c:214
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 ptr_ring_consume_bh include/linux/ptr_ring.h:377 [inline]
 wg_packet_decrypt_worker+0x13c/0x3a0 drivers/net/wireguard/receive.c:499
 process_one_work+0x810/0x1b1c kernel/workqueue.c:3302
 process_scheduled_works kernel/workqueue.c:3385 [inline]
 worker_thread+0x42c/0xc90 kernel/workqueue.c:3466
 kthread+0x2f0/0x388 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:858
BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 33s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x100
  pwq 2: cpus=0 node=0 flags=0x0 nice=0 active=4 refcnt=5
    pending: nsim_dev_hwstats_traffic_work, 2*psi_avgs_work, vmstat_shepherd
  pwq 6: cpus=1 node=0 flags=0x0 nice=0 active=10 refcnt=11
    pending: 9*nsim_dev_hwstats_traffic_work, psi_avgs_work
workqueue events_unbound: flags=0x2
  pwq 8: cpus=0-1 flags=0x4 nice=0 active=1 refcnt=2
    in-flight: 16479:call_usermodehelper_exec_work for 42s
workqueue events_unbound: flags=0x2
  pwq 8: cpus=0-1 flags=0x4 nice=0 active=5 refcnt=6
    pending: 5*nsim_dev_trap_report_work
  pwq 8: cpus=0-1 flags=0x4 nice=0 active=5 refcnt=6
    pending: 5*nsim_dev_trap_report_work
workqueue events_power_efficient: flags=0x182
  pwq 8: cpus=0-1 flags=0x4 nice=0 active=2 refcnt=3
    pending: neigh_managed_work, wg_ratelimiter_gc_entries
  pwq 8: cpus=0-1 flags=0x4 nice=0 active=4 refcnt=5
    pending: neigh_periodic_work, gc_worker, neigh_periodic_work, neigh_managed_work
workqueue mm_percpu_wq: flags=0x108
  pwq 2: cpus=0 node=0 flags=0x0 nice=0 active=1 refcnt=2
    pending: vmstat_update
  pwq 6: cpus=1 node=0 flags=0x0 nice=0 active=1 refcnt=2
    pending: vmstat_update
workqueue writeback: flags=0x4a
  pwq 8: cpus=0-1 flags=0x4 nice=0 active=1 refcnt=2
    in-flight: 10400:wb_workfn for 33s
workqueue kblockd: flags=0x118
  pwq 7: cpus=1 node=0 flags=0x0 nice=-20 active=2 refcnt=3
    pending: blk_mq_timeout_work, blk_mq_requeue_work
workqueue ipv6_addrconf: flags=0x6000a
  pwq 8: cpus=0-1 flags=0x4 nice=0 active=1 refcnt=6
    pending: addrconf_verify_work
    inactive: 2*addrconf_verify_work
workqueue wg-kex-wg0: flags=0x6
  pwq 8: cpus=0-1 flags=0x4 nice=0 active=1 refcnt=2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg0: flags=0x128
  pwq 2: cpus=0 node=0 flags=0x0 nice=0 active=1 refcnt=2
    in-flight: 19280:wg_packet_decrypt_worker for 33s
  pwq 6: cpus=1 node=0 flags=0x0 nice=0 active=2 refcnt=3
    in-flight: 20255:wg_packet_decrypt_worker for 33s
    pending: wg_packet_encrypt_worker
workqueue wg-crypt-wg1: flags=0x128
  pwq 6: cpus=1 node=0 flags=0x0 nice=0 active=1 refcnt=2
    pending: wg_packet_encrypt_worker
workqueue wg-kex-wg2: flags=0x6
  pwq 8: cpus=0-1 flags=0x4 nice=0 active=1 refcnt=2
    pending: wg_packet_handshake_send_worker
  pwq 8: cpus=0-1 flags=0x4 nice=0 active=1 refcnt=2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg2: flags=0x128
  pwq 6: cpus=1 node=0 flags=0x0 nice=0 active=1 refcnt=2
    pending: wg_packet_encrypt_worker
workqueue wg-kex-wg0: flags=0x6
  pwq 8: cpus=0-1 flags=0x4 nice=0 active=1 refcnt=2
    pending: wg_packet_handshake_send_worker
  pwq 8: cpus=0-1 flags=0x4 nice=0 active=1 refcnt=2
    pending: wg_packet_handshake_send_worker
workqueue wg-kex-wg1: flags=0x6
  pwq 8: cpus=0-1 flags=0x4 nice=0 active=1 refcnt=2
    pending: wg_packet_handshake_send_worker
  pwq 8: cpus=0-1 flags=0x4 nice=0 active=1 refcnt=2
    pending: wg_packet_handshake_send_worker
workqueue wg-kex-wg2: flags=0x6
  pwq 8: cpus=0-1 flags=0x4 nice=0 active=2 refcnt=3
    pending: 2*wg_packet_handshake_send_worker
workqueue wg-kex-wg0: flags=0x6
  pwq 8: cpus=0-1 flags=0x4 nice=0 active=3 refcnt=4
    in-flight: 15424:wg_packet_handshake_send_worker for 33s ,20263:wg_packet_handshake_send_worker for 33s
    pending: wg_packet_handshake_send_worker
workqueue wg-kex-wg1: flags=0x6
  pwq 8: cpus=0-1 flags=0x4 nice=0 active=1 refcnt=2
    pending: wg_packet_handshake_send_worker
  pwq 8: cpus=0-1 flags=0x4 nice=0 active=1 refcnt=2
    pending: wg_packet_handshake_send_worker
workqueue wg-kex-wg2: flags=0x6
  pwq 8: cpus=0-1 flags=0x4 nice=0 active=1 refcnt=2
    pending: wg_packet_handshake_send_worker
  pwq 8: cpus=0-1 flags=0x4 nice=0 active=2 refcnt=3
    in-flight: 17220:wg_packet_handshake_send_worker for 33s
    pending: wg_packet_handshake_send_worker
workqueue wg-kex-wg0: flags=0x6
  pwq 8: cpus=0-1 flags=0x4 nice=0 active=1 refcnt=2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg0: flags=0x128
  pwq 2: cpus=0 node=0 flags=0x0 nice=0 active=1 refcnt=2
    pending: wg_packet_decrypt_worker
  pwq 6: cpus=1 node=0 flags=0x0 nice=0 active=1 refcnt=2
    pending: wg_packet_encrypt_worker
workqueue wg-kex-wg1: flags=0x6
  pwq 8: cpus=0-1 flags=0x4 nice=0 active=1 refcnt=2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg1: flags=0x128
  pwq 2: cpus=0 node=0 flags=0x0 nice=0 active=1 refcnt=2
    pending: wg_packet_encrypt_worker
  pwq 6: cpus=1 node=0 flags=0x0 nice=0 active=1 refcnt=2
    pending: wg_packet_encrypt_worker
workqueue wg-kex-wg2: flags=0x6
  pwq 8: cpus=0-1 flags=0x4 nice=0 active=1 refcnt=2
    pending: wg_packet_handshake_send_worker
workqueue wg-crypt-wg2: flags=0x128
  pwq 6: cpus=1 node=0 flags=0x0 nice=0 active=1 refcnt=2
    pending: wg_packet_encrypt_worker
workqueue wg-crypt-wg0: flags=0x128
  pwq 2: cpus=0 node=0 flags=0x0 nice=0 active=1 refcnt=2
    pending: wg_packet_encrypt_worker
  pwq 6: cpus=1 node=0 flags=0x0 nice=0 active=2 refcnt=3
    pending: wg_packet_decrypt_worker, wg_packet_encrypt_worker
workqueue wg-crypt-wg1: flags=0x128
  pwq 2: cpus=0 node=0 flags=0x0 nice=0 active=1 refcnt=2
    pending: wg_packet_encrypt_worker
  pwq 6: cpus=1 node=0 flags=0x0 nice=0 active=1 refcnt=2
    pending: wg_packet_encrypt_worker
workqueue wg-crypt-wg2: flags=0x128
  pwq 2: cpus=0 node=0 flags=0x0 nice=0 active=1 refcnt=2
    pending: wg_packet_encrypt_worker
  pwq 6: cpus=1 node=0 flags=0x0 nice=0 active=1 refcnt=2
    pending: wg_packet_encrypt_worker
workqueue krds_cp_wq#1/0: flags=0x20002
  pwq 8: cpus=0-1 flags=0x4 nice=0 active=1 refcnt=4
    pending: rds_connect_worker
workqueue krds_cp_wq#2/0: flags=0x20002
  pwq 8: cpus=0-1 flags=0x4 nice=0 active=1 refcnt=4
    pending: rds_connect_worker
pool 2: cpus=0 node=0 flags=0x0 nice=0 hung=33s workers=7 idle: 20317 20625 17368 18803 20184 16642
pool 6: cpus=1 node=0 flags=0x0 nice=0 hung=33s workers=6 idle: 20316 15747 16513 18710 19225
pool 8: cpus=0-1 flags=0x4 nice=0 hung=0s workers=13 idle: 15591 8052 14588 7215 11940 15432 19121
Showing backtraces of busy workers in stalled worker pools:
pool 2:
task:kworker/0:7     state:R  running task     stack:0     pid:19280 tgid:19280 ppid:2      task_flags:0x4208060 flags:0x00000012
Workqueue: wg-crypt-wg0 wg_packet_decrypt_worker
Call trace:
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:499 (C)
 sched_show_task kernel/sched/core.c:8139 [inline]
 sched_show_task+0x454/0x5e0 kernel/sched/core.c:8114
 show_cpu_pool_busy_workers kernel/workqueue.c:7674 [inline]
 show_cpu_pools_busy_workers kernel/workqueue.c:7693 [inline]
 wq_watchdog_timer_fn+0x840/0x870 kernel/workqueue.c:7809
 call_timer_fn+0x1b8/0xaa0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers+0x8bc/0xb30 kernel/time/timer.c:2374
 __run_timer_base kernel/time/timer.c:2386 [inline]
 __run_timer_base kernel/time/timer.c:2378 [inline]
 run_timer_base+0x110/0x180 kernel/time/timer.c:2395
 run_timer_softirq+0x24/0x50 kernel/time/timer.c:2406
 handle_softirqs+0x2dc/0x1050 kernel/softirq.c:622
 __do_softirq+0x14/0x20 kernel/softirq.c:656
 ____do_softirq+0x10/0x20 arch/arm64/kernel/irq.c:68
 call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:889
 do_softirq_own_stack+0x1c/0x40 arch/arm64/kernel/irq.c:73
 do_softirq kernel/softirq.c:523 [inline]
 do_softirq+0x12c/0x15c kernel/softirq.c:510
 __local_bh_enable_ip+0x408/0x4a0 kernel/softirq.c:450
 __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:196 [inline]
 _raw_spin_unlock_bh+0x44/0x54 kernel/locking/spinlock.c:214
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 ptr_ring_consume_bh include/linux/ptr_ring.h:377 [inline]
 wg_packet_decrypt_worker+0x13c/0x3a0 drivers/net/wireguard/receive.c:499
 process_one_work+0x810/0x1b1c kernel/workqueue.c:3302
 process_scheduled_works kernel/workqueue.c:3385 [inline]
 worker_thread+0x42c/0xc90 kernel/workqueue.c:3466
 kthread+0x2f0/0x388 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:858


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

