Return-Path: <netdev+bounces-153249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B86C9F7602
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 08:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C4B189705B
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 07:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92882163BC;
	Thu, 19 Dec 2024 07:45:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAEB1E47B6
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 07:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734594323; cv=none; b=UVBUFjbwq6SY7HqovT8efpCXBCYN81MLmRYaKqNt9BNgR3B+yIM+lE69pfxP3qUZkFiUIoF137nI1vXTQcWvwpcjFS4t1Un27ofP2qc51P5FomCO0VwE6qoNnHcRCAa6WIMll2M9d+RgVfMAGP3QRyLSqCot9aAZXlFTJJjr8+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734594323; c=relaxed/simple;
	bh=W0tE8ypD92qNW06ZGRG0ovmvXonpGBeS7rRhsK9Sj5M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=t31K7ySwsOuFvYHySaG51Xs9zxENs/KNcXMWFJbI0RdBMRoctFYG0AjQN6AUZxBMiIlGCEPW80hzTOaZmTZ1OktKE5/hmly/I+Cd5hSLNr3XAphx3cf6zqHccaoVCSy2IOq405xll5pbE0758e1B8S6WxCIgnQiD+0Q5pp/WMj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-844e344b0b5so53605339f.0
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 23:45:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734594320; x=1735199120;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=laVEJSeZYm969pAldHKLSUtxu0gr+S30tXDxceMAjik=;
        b=BOudYNAY3tSCR3ezRebhFegyi/HE7K3Bp/stacyn3FEw2YH9pp33Xd7Z3A9FdfuJ09
         ISL+hZCl8zTjIvIldKG615mlVX75TU3/Xn32QXdpvssIpkQWcBVQ3kSPIsuwzjpOKC2Z
         IeLLMXN1VPCF+UT+Sd8HQkTR++1ywtlUvnfe06PqLnFQEoWrrSRz9fLwe1dedfvyRYNI
         CkMyNrg6/x2dbgo/SknjPy0Iu2+gszr/mRfzuP1w5yZgiQf/zhzP3AX7ATZxkd6mYPbY
         lstbfMjR3tkk+Izgx4exg3yUvpgsT8/D4RrvqWuEp7eZC2ndQO8e4K2IzOYxKRakktlm
         U75w==
X-Forwarded-Encrypted: i=1; AJvYcCUcg4lDEb4GcYWV+r+CCbM6CpuYcTt2O2k2+Oi3Rng8TFRvQ7keoPfPWbFFD+O0wyxFaR1/UTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyARmZXU5nnTikIdOcBR5WmrFI7kGcTglzhRj9kBMlWmNfE2WiT
	TX8ElKQu9Jtmn5J0Iu8VoNRocLXhAUqlnTG820Jr+2AXV0PuoHP7AcMCMbX9DqB6U9RNgh34XAy
	pCX+OPctIKqJYp8fHnrt7lLP0TJAtcq5cOD7SGrINcOPsloRuj+16msE=
X-Google-Smtp-Source: AGHT+IGX+J5VyYptOvChlUWrk/1nQaHOkxIqyT0JHjcN0nIpaP4Enq46ChTGFboLZhpzr9fGmnXkduSZIXSe7jcs76MGAZSTNXQY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3042:b0:3a7:a738:d9c8 with SMTP id
 e9e14a558f8ab-3c0110b22a9mr24275395ab.2.1734594320172; Wed, 18 Dec 2024
 23:45:20 -0800 (PST)
Date: Wed, 18 Dec 2024 23:45:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6763cf10.050a0220.3157ee.0010.GAE@google.com>
Subject: [syzbot] [net?] WARNING: locking bug in omain
From: syzbot <syzbot+20782712f6a1097411d9@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a0e3919a2df2 Merge tag 'usb-6.13-rc3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=167cbcdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b874549ac3d0b012
dashboard link: https://syzkaller.appspot.com/bug?extid=20782712f6a1097411d9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/694eb7d9bffc/disk-a0e3919a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1350ab6a6022/vmlinux-a0e3919a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f64266879922/bzImage-a0e3919a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+20782712f6a1097411d9@syzkaller.appspotmail.com

May 18 03:34:44 syzkaller kern.warn kernel: [  193.314347][ T8196]  ? srcu_lock_acquire include/linux/srcu.h:158 [inline]
May 18 03:34:44 syzkaller kern.warn kernel: [  193.314347][ T8196]  ? srcu_read_lock include/linux/srcu.h:249 [inline]
May 18 03:34:44 syzkaller kern.warn kernel: [  193.314347][ T8196]  ? tomoyo_read_lock security/tomoyo/common.h:1108 [inline]
May 18 03:34:44 syzkaller kern.warn kernel: [  193.314347][ T8196]  ? tomoyo_mount_permission+0x149/0x420 security/tomoyo/mount.c:236
May 18 03:34:44 syzkaller kern.warn kernel: [  193.319968][ T8196]  ? lock_acquire+0x2f/0xb0 kernel/locking/lockdep.c:5820
May 18 03:34:44 syzkaller kern.warn kernel: [  193.324456][ T8196]  ? srcu_lock_acquire include/linux/srcu.h:158 [inline]
May 18 03:34:44 syzkaller kern.warn kernel: [  193.324456][ T8196]  ? srcu_read_lock include/linux/srcu.h:249 [inline]
May 18 03:34:44 syzkaller kern.warn kernel: [  193.324456][ T8196]  ? tomoyo_read_lock security/tomoyo/common.h:1108 [inline]
May 18 03:34:44 syzkaller kern.warn kernel: [  193.324456][ T8196]  ? tomoyo_mount_permission+0x149/0x420 security/tomoyo/mount.c:236
May 18 03:34:44 syzkaller kern.warn kernel: [  193.330078][ T8196]  tomoyo_mount_permission+0x16e/0x420 security/tomoyo/mount.c:237
May 18 03:34:44 [  193.762061][    C0] =============================
syzkaller kern.w[  193.768266][    C0] [ BUG: Invalid wait context ]
arn kernel: [  1[  193.774472][    C0] 6.13.0-rc2-syzkaller-00333-ga0e3919a2df2 #0 Not tainted
93.335525][ T819[  193.782943][    C0] -----------------------------
6]  ? tomoyo_mou[  193.789158][    C0] syz.1.700/8202 is trying to lock:
nt_permission+0x[  193.795714][    C0] ffff88813fffc298 (&zone->lock){-.-.}-{3:3}, at: rmqueue_bulk mm/page_alloc.c:2307 [inline]
nt_permission+0x[  193.795714][    C0] ffff88813fffc298 (&zone->lock){-.-.}-{3:3}, at: __rmqueue_pcplist+0x6bb/0x1600 mm/page_alloc.c:3001
149/0x420
May 1[  193.806186][    C0] other info that might help us debug this:
8 03:34:44 syzka[  193.813448][    C0] context-{2:2}
ller kern.warn k[  193.818264][    C0] 1 lock held by syz.1.700/8202:
ernel: [  193.34[  193.824561][    C0]  #0: ffff8880b8644c58 (&pcp->lock){+.+.}-{3:3}, at: spin_trylock include/linux/spinlock.h:361 [inline]
ernel: [  193.34[  193.824561][    C0]  #0: ffff8880b8644c58 (&pcp->lock){+.+.}-{3:3}, at: rmqueue_pcplist mm/page_alloc.c:3030 [inline]
ernel: [  193.34[  193.824561][    C0]  #0: ffff8880b8644c58 (&pcp->lock){+.+.}-{3:3}, at: rmqueue mm/page_alloc.c:3074 [inline]
ernel: [  193.34[  193.824561][    C0]  #0: ffff8880b8644c58 (&pcp->lock){+.+.}-{3:3}, at: get_page_from_freelist+0x350/0x2f80 mm/page_alloc.c:3471
1147][ T8196]  ?[  193.835813][    C0] stack backtrace:
 __pfx_tomoyo_mo[  193.840893][    C0] CPU: 0 UID: 0 PID: 8202 Comm: syz.1.700 Not tainted 6.13.0-rc2-syzkaller-00333-ga0e3919a2df2 #0
unt_permission+0[  193.852832][    C0] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
x10/0x10
May 18[  193.864256][    C0] Call Trace:
 03:34:44 syzkal[  193.868912][    C0]  <TASK>
ler kern.warn ke[  193.873196][    C0]  __dump_stack lib/dump_stack.c:94 [inline]
ler kern.warn ke[  193.873196][    C0]  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
rnel: [  193.347[  193.879224][    C0]  print_lock_invalid_wait_context kernel/locking/lockdep.c:4826 [inline]
rnel: [  193.347[  193.879224][    C0]  check_wait_context kernel/locking/lockdep.c:4898 [inline]
rnel: [  193.347[  193.879224][    C0]  __lock_acquire+0x878/0x3c40 kernel/locking/lockdep.c:5176
123][ T8196]  ? [  193.885337][    C0]  ? find_held_lock+0x2d/0x110 kernel/locking/lockdep.c:5339
get_current_fs_d[  193.891444][    C0]  ? __pfx___lock_acquire+0x10/0x10 kernel/locking/lockdep.c:4387
omain+0x184/0x1f[  193.897990][    C0]  ? spin_unlock include/linux/spinlock.h:391 [inline]
omain+0x184/0x1f[  193.897990][    C0]  ? tcp_v4_rcv+0x33af/0x4380 net/ipv4/tcp_ipv4.c:2356
0
May 18 03:34:[  193.904013][    C0]  lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
44 syzkaller ker[  193.910470][    C0]  ? rmqueue_bulk mm/page_alloc.c:2307 [inline]
44 syzkaller ker[  193.910470][    C0]  ? __rmqueue_pcplist+0x6bb/0x1600 mm/page_alloc.c:3001
n.warn kernel: [[  193.917013][    C0]  ? __pfx_lock_acquire.part.0+0x10/0x10 kernel/locking/lockdep.c:122
  193.352580][ T[  193.923994][    C0]  ? rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
  193.352580][ T[  193.923994][    C0]  ? rcu_is_watching+0x12/0xc0 kernel/rcu/tree.c:737
8196]  security_[  193.930105][    C0]  ? trace_lock_acquire+0x14e/0x1f0 include/trace/events/lock.h:24
sb_mount+0x9b/0x[  193.936652][    C0]  ? rmqueue_bulk mm/page_alloc.c:2307 [inline]
sb_mount+0x9b/0x[  193.936652][    C0]  ? __rmqueue_pcplist+0x6bb/0x1600 mm/page_alloc.c:3001
260
May 18 03:3[  193.943197][    C0]  ? lock_acquire+0x2f/0xb0 kernel/locking/lockdep.c:5820
4:44 syzkaller k[  193.949049][    C0]  ? rmqueue_bulk mm/page_alloc.c:2307 [inline]
4:44 syzkaller k[  193.949049][    C0]  ? __rmqueue_pcplist+0x6bb/0x1600 mm/page_alloc.c:3001
ern.warn kernel:[  193.955596][    C0]  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
ern.warn kernel:[  193.955596][    C0]  _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
 [  193.357422][[  193.962143][    C0]  ? rmqueue_bulk mm/page_alloc.c:2307 [inline]
 [  193.357422][[  193.962143][    C0]  ? __rmqueue_pcplist+0x6bb/0x1600 mm/page_alloc.c:3001
 T8196]  path_mo[  193.968690][    C0]  rmqueue_bulk mm/page_alloc.c:2307 [inline]
 T8196]  path_mo[  193.968690][    C0]  __rmqueue_pcplist+0x6bb/0x1600 mm/page_alloc.c:3001
unt+0x129/0x1f20[  193.975065][    C0]  ? __pfx_lock_acquire.part.0+0x10/0x10 kernel/locking/lockdep.c:122

May 18 03:34:4[  193.982042][    C0]  ? rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
May 18 03:34:4[  193.982042][    C0]  ? rcu_is_watching+0x12/0xc0 kernel/rcu/tree.c:737
4 syzkaller kern[  193.988153][    C0]  ? trace_lock_acquire+0x14e/0x1f0 include/trace/events/lock.h:24
.warn kernel: [ [  193.994700][    C0]  ? instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
.warn kernel: [ [  193.994700][    C0]  ? atomic_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:1301 [inline]
.warn kernel: [ [  193.994700][    C0]  ? queued_spin_trylock include/asm-generic/qspinlock.h:97 [inline]
.warn kernel: [ [  193.994700][    C0]  ? do_raw_spin_trylock+0xb1/0x180 kernel/locking/spinlock_debug.c:123
 193.361845][ T8[  194.001440][    C0]  ? __pfx___rmqueue_pcplist+0x10/0x10 mm/page_alloc.c:2005
196]  ? kmem_cac[  194.008255][    C0]  ? lock_acquire+0x2f/0xb0 kernel/locking/lockdep.c:5820
he_free+0x152/0x[  194.014105][    C0]  ? spin_trylock include/linux/spinlock.h:361 [inline]
he_free+0x152/0x[  194.014105][    C0]  ? rmqueue_pcplist mm/page_alloc.c:3030 [inline]
he_free+0x152/0x[  194.014105][    C0]  ? rmqueue mm/page_alloc.c:3074 [inline]
he_free+0x152/0x[  194.014105][    C0]  ? get_page_from_freelist+0x350/0x2f80 mm/page_alloc.c:3471
4c0
May 18 03:3[  194.021085][    C0]  rmqueue_pcplist mm/page_alloc.c:3043 [inline]
May 18 03:3[  194.021085][    C0]  rmqueue mm/page_alloc.c:3074 [inline]
May 18 03:3[  194.021085][    C0]  get_page_from_freelist+0x3d2/0x2f80 mm/page_alloc.c:3471
4:44 syzkaller k[  194.027892][    C0]  ? __pfx_mark_lock+0x10/0x10 kernel/locking/lockdep.c:232
ern.warn kernel:[  194.033999][    C0]  ? __pfx_get_page_from_freelist+0x10/0x10 arch/x86/include/asm/atomic64_64.h:15
 [  193.366776][[  194.041237][    C0]  ? should_fail_alloc_page+0xee/0x130 mm/fail_page_alloc.c:44
 T8196]  ? __pfx[  194.048044][    C0]  ? prepare_alloc_pages.constprop.0+0x16f/0x560 mm/page_alloc.c:4512
_path_mount+0x10[  194.055720][    C0]  __alloc_pages_noprof+0x223/0x25b0 mm/page_alloc.c:4751
/0x10
May 18 03[  194.062353][    C0]  ? __pfx___lock_acquire+0x10/0x10 kernel/locking/lockdep.c:4387
:34:44 syzkaller[  194.069158][    C0]  ? instrument_atomic_read include/linux/instrumented.h:68 [inline]
:34:44 syzkaller[  194.069158][    C0]  ? _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
:34:44 syzkaller[  194.069158][    C0]  ? hlock_class+0x4e/0x130 kernel/locking/lockdep.c:228
 kern.warn kerne[  194.075008][    C0]  ? __lock_acquire+0xcc5/0x3c40 kernel/locking/lockdep.c:5223
l: [  193.371622[  194.081298][    C0]  ? __pfx___alloc_pages_noprof+0x10/0x10 mm/page_alloc.c:3519
][ T8196]  ? put[  194.088359][    C0]  ? find_held_lock+0x2d/0x110 kernel/locking/lockdep.c:5339
name+0x13c/0x180[  194.094472][    C0]  ? rcu_lock_release include/linux/rcupdate.h:347 [inline]
name+0x13c/0x180[  194.094472][    C0]  ? rcu_read_unlock include/linux/rcupdate.h:880 [inline]
name+0x13c/0x180[  194.094472][    C0]  ? is_bpf_text_address+0x8a/0x1a0 kernel/bpf/core.c:770

May 18 03:34:4[  194.101018][    C0]  ? lock_acquire+0x2f/0xb0 kernel/locking/lockdep.c:5820
4 syzkaller kern[  194.106866][    C0]  ? rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
4 syzkaller kern[  194.106866][    C0]  ? rcu_read_lock include/linux/rcupdate.h:849 [inline]
4 syzkaller kern[  194.106866][    C0]  ? is_bpf_text_address+0x30/0x1a0 kernel/bpf/core.c:768
.warn kernel: [ [  194.113412][    C0]  ? bpf_ksym_find+0x127/0x1c0 kernel/bpf/core.c:737
 193.375860][ T8[  194.119524][    C0]  ? __sanitizer_cov_trace_switch+0x54/0x90 kernel/kcov.c:351
196]  __x64_sys_[  194.126765][    C0]  ? policy_nodemask+0xea/0x4e0 mm/mempolicy.c:2090
mount+0x294/0x32[  194.132965][    C0]  alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2269
0
May 18 03:34:[  194.139773][    C0]  ? __pfx_alloc_pages_mpol_noprof+0x10/0x10 include/linux/bitmap.h:409
44 syzkaller ker[  194.147099][    C0]  stack_depot_save_flags+0x8e0/0x9e0 lib/stackdepot.c:627
n.warn kernel: [[  194.153815][    C0]  ? __lock_acquire+0xcc5/0x3c40 kernel/locking/lockdep.c:5223
  193.380615][ T[  194.160101][    C0]  kasan_save_stack+0x42/0x60 mm/kasan/common.c:48
8196]  ? __pfx__[  194.166126][    C0]  ? kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
_x64_sys_mount+0[  194.172325][    C0]  ? __kasan_record_aux_stack+0xba/0xd0 mm/kasan/generic.c:544
x10/0x10
May 18[  194.179214][    C0]  ? task_work_add+0xc0/0x3b0 kernel/task_work.c:77
 03:34:44 syzkal[  194.185237][    C0]  ? __run_posix_cpu_timers kernel/time/posix-cpu-timers.c:1223 [inline]
 03:34:44 syzkal[  194.185237][    C0]  ? run_posix_cpu_timers+0x69f/0x7d0 kernel/time/posix-cpu-timers.c:1422
ler kern.warn ke[  194.192763][    C0]  ? update_process_times+0x1a1/0x2d0 kernel/time/timer.c:2526
rnel: [  193.385[  194.199741][    C0]  ? tick_sched_handle kernel/time/tick-sched.c:276 [inline]
rnel: [  193.385[  194.199741][    C0]  ? tick_nohz_handler+0x376/0x530 kernel/time/tick-sched.c:297
896][ T8196]  do[  194.206200][    C0]  ? __run_hrtimer kernel/time/hrtimer.c:1739 [inline]
896][ T8196]  do[  194.206200][    C0]  ? __hrtimer_run_queues+0x5fb/0xae0 kernel/time/hrtimer.c:1803
_syscall_64+0xcd[  194.212918][    C0]  ? hrtimer_interrupt+0x392/0x8e0 kernel/time/hrtimer.c:1865
/0x250
May 18 0[  194.219380][    C0]  ? local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
May 18 0[  194.219380][    C0]  ? __sysvec_apic_timer_interrupt+0x10f/0x400 arch/x86/kernel/apic/apic.c:1055
3:34:44 syzkalle[  194.226879][    C0]  ? instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
3:34:44 syzkalle[  194.226879][    C0]  ? sysvec_apic_timer_interrupt+0x52/0xc0 arch/x86/kernel/apic/apic.c:1049
r kern.warn kern[  194.234033][    C0]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
el: [  193.39039[  194.241546][    C0]  __kasan_record_aux_stack+0xba/0xd0 mm/kasan/generic.c:544
5][ T8196]  entr[  194.248252][    C0]  task_work_add+0xc0/0x3b0 kernel/task_work.c:77
y_SYSCALL_64_aft[  194.254104][    C0]  ? __pfx_task_work_add+0x10/0x10 kernel/task_work.c:13
er_hwframe+0x77/[  194.260653][    C0]  ? lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
0x7f
May 18 03:[  194.267285][    C0]  ? find_held_lock+0x2d/0x110 kernel/locking/lockdep.c:5339
34:44 syzkaller [  194.273400][    C0]  __run_posix_cpu_timers kernel/time/posix-cpu-timers.c:1223 [inline]
34:44 syzkaller [  194.273400][    C0]  run_posix_cpu_timers+0x69f/0x7d0 kernel/time/posix-cpu-timers.c:1422
kern.warn kernel[  194.279947][    C0]  ? __pfx_run_posix_cpu_timers+0x10/0x10 include/linux/task_work.h:13
: [  193.396282][  194.287017][    C0]  ? instrument_atomic_read include/linux/instrumented.h:68 [inline]
: [  193.396282][  194.287017][    C0]  ? atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
: [  193.396282][  194.287017][    C0]  ? nohz_balancer_kick kernel/sched/fair.c:12305 [inline]
: [  193.396282][  194.287017][    C0]  ? sched_balance_trigger+0x225/0xea0 kernel/sched/fair.c:12891
[ T8196] RIP: 00[  194.293823][    C0]  ? __pfx_sched_balance_trigger+0x10/0x10 kernel/sched/fair.c:12676
33:0x7f42ca985d1[  194.300974][    C0]  ? sched_tick+0x286/0x4f0 kernel/sched/core.c:5672
9
May 18 03:34:[  194.306824][    C0]  update_process_times+0x1a1/0x2d0 kernel/time/timer.c:2526
44 syzkaller ker[  194.313369][    C0]  ? __pfx_update_process_times+0x10/0x10 kernel/time/timer.c:2380
n.warn kernel: [[  194.320434][    C0]  ? __pfx_tick_nohz_handler+0x10/0x10 include/linux/seqlock.h:226
  193.400687][ T[  194.327239][    C0]  ? update_wall_time+0x1c/0x40 kernel/time/timekeeping.c:2280
8196] Code: ff f[  194.333440][    C0]  tick_sched_handle kernel/time/tick-sched.c:276 [inline]
8196] Code: ff f[  194.333440][    C0]  tick_nohz_handler+0x376/0x530 kernel/time/tick-sched.c:297
f c3 66 2e 0f 1f[  194.339725][    C0]  ? __pfx_tick_nohz_handler+0x10/0x10 include/linux/seqlock.h:226
 84 00 00 00 00 [  194.346528][    C0]  __run_hrtimer kernel/time/hrtimer.c:1739 [inline]
 84 00 00 00 00 [  194.346528][    C0]  __hrtimer_run_queues+0x5fb/0xae0 kernel/time/hrtimer.c:1803
00 0f 1f 40 00 4[  194.353081][    C0]  ? __pfx___hrtimer_run_queues+0x10/0x10 include/trace/events/timer.h:222
8 89 f8 48 89 f7[  194.360142][    C0]  ? rdtsc_ordered arch/x86/include/asm/msr.h:217 [inline]
8 89 f8 48 89 f7[  194.360142][    C0]  ? read_tsc+0x9/0x20 arch/x86/kernel/tsc.c:1133
 48 89 d6 48 89 [  194.365564][    C0]  hrtimer_interrupt+0x392/0x8e0 kernel/time/hrtimer.c:1865
ca 4d 89 c2 4d 8[  194.371851][    C0]  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
ca 4d 89 c2 4d 8[  194.371851][    C0]  __sysvec_apic_timer_interrupt+0x10f/0x400 arch/x86/kernel/apic/apic.c:1055
9 c8 4c 8b 4c 24[  194.379172][    C0]  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
9 c8 4c 8b 4c 24[  194.379172][    C0]  sysvec_apic_timer_interrupt+0x52/0xc0 arch/x86/kernel/apic/apic.c:1049
 08 0f 05 <48> 3[  194.386325][    C0]  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
d 01 f0 ff ff 73[  194.393652][    C0] RIP: 0033:0x7f42ca85f4dd
 01 c3 48 c7 c1 [  194.399420][    C0] Code: 08 48 83 c3 08 48 39 d1 72 f3 48 83 e8 08 48 39 f2 73 17 66 2e 0f 1f 84 00 00 00 00 00 48 8b 70 f8 48 83 e8 08 48 39 f2 72 f3 <48> 39 c3 73 3e 48 89 33 48 83 c3 08 48 8b 70 f8 48 89 08 48 8b 0b
a8 ff ff ff f7 d[  194.420373][    C0] RSP: 002b:00007ffe5e4fd800 EFLAGS: 00000212
8 64 89 01 48
M[  194.427783][    C0] RAX: 00007f42c9835c40 RBX: 00007f42c982b6a8 RCX: ffffffff81d08a92
ay 18 03:34:44 s[  194.437106][    C0] RDX: ffffffff81d0891c RSI: ffffffff81d0433d RDI: 00007f42c983b2a8
yzkaller kern.wa[  194.446431][    C0] RBP: 00007f42c98219b0 R08: 00007f42c982e628 R09: 00007f42cab62000
rn kernel: [  19[  194.455756][    C0] R10: 00007f42c97fb008 R11: 000000000000001b R12: 00007f42c98219a8
3.420286][ T8196[  194.465078][    C0] R13: 000000000000001a R14: 0000000000000032 R15: 00007f42c97fb008
May 18 03:34:44 [  194.474406][    C0]  ? __filemap_get_folio+0x452/0xaf0 mm/filemap.c:1959
May 18 03:34:44 [  194.481034][    C0]  ? mapping_min_folio_order include/linux/pagemap.h:463 [inline]
May 18 03:34:44 [  194.481034][    C0]  ? __filemap_get_folio+0x2dc/0xaf0 mm/filemap.c:1923
May 18 03:34:45 syzkaller kern.warn kernel: [  193.759337][    C0] 
May 18 03:34:45 syzkaller kern.warn kernel: [  193.762061][    C0] =============================
May 18 03:34:45 syzkaller kern.warn kernel: [  193.768266][    C0] [ BUG: Invalid wait context ]
May 18 03:34:45 syzkaller kern.warn kernel: [  193.774472][    C0] 6.13.0-rc2-syzkaller-00333-ga0e3919a2df2 #0 Not tainted
May 18 03:34:45 syzkaller kern.warn kernel: [  193.782943][    C0] -----------------------------
May 18 03:34:45 syzkaller kern.warn kernel: [  193.789158][    C0] syz.1.700/8202 is trying to lock:
May 18 03:34:45 syzkaller kern.warn kernel: [  193.795714][    C0] ffff88813fffc298 (&zone->lock){-.-.}-{3:3}, at: rmqueue_bulk mm/page_alloc.c:2307 [inline]
May 18 03:34:45 syzkaller kern.warn kernel: [  193.795714][    C0] ffff88813fffc298 (&zone->lock){-.-.}-{3:3}, at: __rmqueue_pcplist+0x6bb/0x1600 mm/page_alloc.c:3001
May 18 03:34:45 syzkaller kern.warn kernel: [  193.806186][    C0] other info that might help us debug this:
May 18 03:34:45 syzkaller kern.warn kernel: [  193.813448][    C0] context-{2:2}
May 18 03:34:45 syzkaller kern.warn kernel: [  193.818264][    C0] 1 lock held by syz.1.700/8202:
May 18 03:34:45 syzkaller kern.warn kernel: [  193.824561][    C0]  #0: ffff8880b8644c58 (&pcp->lock){+.+.}-{3:3}, at: spin_trylock include/linux/spinlock.h:361 [inline]
May 18 03:34:45 syzkaller kern.warn kernel: [  193.824561][    C0]  #0: ffff8880b8644c58 (&pcp->lock){+.+.}-{3:3}, at: rmqueue_pcplist mm/page_alloc.c:3030 [inline]
May 18 03:34:45 syzkaller kern.warn kernel: [  193.824561][    C0]  #0: ffff8880b8644c58 (&pcp->lock){+.+.}-{3:3}, at: rmqueue mm/page_alloc.c:3074 [inline]
May 18 03:34:45 syzkaller kern.warn kernel: [  193.824561][    C0]  #0: ffff8880b8644c58 (&pcp->lock){+.+.}-{3:3}, at: get_page_from_freelist+0x350/0x2f80 mm/page_alloc.c:3471
May 18 03:34:45 syzkaller kern.warn kernel: [  193.835813][    C0] stack backtrace:
May 18 03:34:45 syzkaller kern.warn kernel: [  193.840893][    C0] CPU: 0 UID: 0 PID: 8202 Comm: syz.1.700 Not tainted 6.13.0-rc2-syzkaller-00333-ga0e3919a2df2 #0
May 18 03:34:45 syzkaller kern.warn kernel: [  193.852832][    C0] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
May 18 03:34:45 syzkaller kern.warn kernel: [  193.864256][    C0] Call Trace:
May 18 03:34:45 syzkaller kern.warn kernel: [  193.868912][    C0]  <TASK>
May 18 03:34:45 syzkaller kern.warn kernel: [  193.873196][    C0]  __dump_stack lib/dump_stack.c:94 [inline]
May 18 03:34:45 syzkaller kern.warn kernel: [  193.873196][    C0]  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
May 18 03:34:45 syzkaller kern.warn kernel: [  193.879224][    C0]  print_lock_invalid_wait_context kernel/locking/lockdep.c:4826 [inline]
May 18 03:34:45 syzkaller kern.warn kernel: [  193.879224][    C0]  check_wait_context kernel/locking/lockdep.c:4898 [inline]
May 18 03:34:45 syzkaller kern.warn kernel: [  193.879224][    C0]  __lock_acquire+0x878/0x3c40 kernel/locking/lockdep.c:5176
May 18 03:34:45 syzkaller kern.warn kernel: [  193.885337][    C0]  ? find_held_lock+0x2d/0x110 kernel/locking/lockdep.c:5339
May 18 03:34:45 syzkaller kern.warn kernel: [  193.891444][    C0]  ? __pfx___lock_acquire+0x10/0x10 kernel/locking/lockdep.c:4387
May 18 03:34:45 syzkaller kern.warn kernel: [  193.897990][    C0]  ? spin_unlock include/linux/spinlock.h:391 [inline]
May 18 03:34:45 syzkaller kern.warn kernel: [  193.897990][    C0]  ? tcp_v4_rcv+0x33af/0x4380 net/ipv4/tcp_ipv4.c:2356
May 18 03:34:45 syzkaller kern.warn kernel: [  193.904013][    C0]  lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
May 18 03:34:45 syzkaller kern.warn kernel: [  193.910470][    C0]  ? rmqueue_bulk mm/page_alloc.c:2307 [inline]
May 18 03:34:45 syzkaller kern.warn kernel: [  193.910470][    C0]  ? __rmqueue_pcplist+0x6bb/0x1600 mm/page_alloc.c:3001
May 18 03:34:45 syzkaller kern.warn kernel: [  193.917013][    C0]  ? __pfx_lock_acquire.part.0+0x10/0x10 kernel/locking/lockdep.c:122
May 18 03:34:45 syzkaller kern.warn kernel: [  193.923994][    C0]  ? rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
May 18 03:34:45 syzkaller kern.warn kernel: [  193.923994][    C0]  ? rcu_is_watching+0x12/0xc0 kernel/rcu/tree.c:737
May 18 03:34:45 syzkaller kern.warn kernel: [  193.930105][    C0]  ? trace_lock_acquire+0x14e/0x1f0 include/trace/events/lock.h:24
May 18 03:34:45 syzkaller kern.warn kernel: [  193.936652][    C0]  ? rmqueue_bulk mm/page_alloc.c:2307 [inline]
May 18 03:34:45 syzkaller kern.warn kernel: [  193.936652][    C0]  ? __rmqueue_pcplist+0x6bb/0x1600 mm/page_alloc.c:3001
May 18 03:34:45 syzkaller kern.warn kernel: [  193.943197][    C0]  ? lock_acquire+0x2f/0xb0 kernel/locking/lockdep.c:5820
May 18 03:34:45 syzkaller kern.warn kernel: [  193.949049][    C0]  ? rmqueue_bulk mm/page_alloc.c:2307 [inline]
May 18 03:34:45 syzkaller kern.warn kernel: [  193.949049][    C0]  ? __rmqueue_pcplist+0x6bb/0x1600 mm/page_alloc.c:3001
May 18 03:34:45 syzkaller kern.warn kernel: [  193.955596][    C0]  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
May 18 03:34:45 syzkaller kern.warn kernel: [  193.955596][    C0]  _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
May 18 03:34:45 syzkaller kern.warn kernel: [  193.962143][    C0]  ? rmqueue_bulk mm/page_alloc.c:2307 [inline]
May 18 03:34:45 syzkaller kern.warn kernel: [  193.962143][    C0]  ? __rmqueue_pcplist+0x6bb/0x1600 mm/page_alloc.c:3001
May 18 03:34:45 syzkaller kern.warn kernel: [  193.968690][    C0]  rmqueue_bulk mm/page_alloc.c:2307 [inline]
May 18 03:34:45 syzkaller kern.warn kernel: [  193.968690][    C0]  __rmqueue_pcplist+0x6bb/0x1600 mm/page_alloc.c:3001
May 18 03:34:45 syzkaller kern.warn kernel: [  193.975065][    C0]  ? __pfx_lock_acquire.part.0+0x10/0x10 kernel/locking/lockdep.c:122
May 18 03:34:45 syzkaller kern.warn kernel: [  193.982042][    C0]  ? rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
May 18 03:34:45 syzkaller kern.warn kernel: [  193.982042][    C0]  ? rcu_is_watching+0x12/0xc0 kernel/rcu/tree.c:737
May 18 03:34:45 syzkaller kern.warn kernel: [  193.988153][    C0]  ? trace_lock_acquire+0x14e/0x1f0 include/trace/events/lock.h:24
May 18 03:34:45 syzkaller kern.warn kernel: [  193.994700][    C0]  ? instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
May 18 03:34:45 syzkaller kern.warn kernel: [  193.994700][    C0]  ? atomic_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:1301 [inline]
May 18 03:34:45 syzkaller kern.warn kernel: [  193.994700][    C0]  ? queued_spin_trylock include/asm-generic/qspinlock.h:97 [inline]
May 18 03:34:45 syzkaller kern.warn kernel: [  193.994700][    C0]  ? do_raw_spin_trylock+0xb1/0x180 kernel/locking/spinlock_debug.c:123
May 18 03:34:45 syzkaller kern.warn kernel: [  194.001440][    C0]  ? __pfx___rmqueue_pcplist+0x10/0x10 mm/page_alloc.c:2005
May 18 03:34:45 syzkaller kern.warn kernel: [  194.008255][    C0]  ? lock_acquire+0x2f/0xb0 kernel/locking/lockdep.c:5820
May 18 03:34:45 syzkaller kern.warn kernel: [  194.014105][    C0]  ? spin_trylock include/linux/spinlock.h:361 [inline]
May 18 03:34:45 syzkaller kern.warn kernel: [  194.014105][    C0]  ? rmqueue_pcplist mm/page_alloc.c:3030 [inline]
May 18 03:34:45 syzkaller kern.warn kernel: [  194.014105][    C0]  ? rmqueue mm/page_alloc.c:3074 [inline]
May 18 03:34:45 syzkaller kern.warn kernel: [  194.014105][    C0]  ? get_page_from_freelist+0x350/0x2f80 mm/page_alloc.c:3471
May 18 03:34:45 syzkaller kern.warn kernel: [  194.021085][    C0]  rmqueue_pcplist mm/page_alloc.c:3043 [inline]
May 18 03:34:45 syzkaller kern.warn kernel: [  194.021085][    C0]  rmqueue mm/page_alloc.c:3074 [inline]
May 18 03:34:45 syzkaller kern.warn kernel: [  194.021085][    C0]  get_page_from_freelist+0x3d2/0x2f80 mm/page_alloc.c:3471
May 18 03:34:45 syzkaller kern.warn kernel: [  194.027892][    C0]  ? __pfx_mark_lock+0x10/0x10 kernel/locking/lockdep.c:232
May 18 03:34:45 syzkaller kern.warn kernel: [  194.033999][    C0]  ? __pfx_get_page_from_freelist+0x10/0x10 arch/x86/include/asm/atomic64_64.h:15
May 18 03:34:45 syzkaller kern.warn kernel: [  194.041237][    C0]  ? should_fail_alloc_page+0xee/0x130 mm/fail_page_alloc.c:44
May 18 03:34:45 syzkaller kern.warn kernel: [  194.048044][    C0]  ? prepare_alloc_pages.constprop.0+0x16f/0x560 mm/page_alloc.c:4512
May 18 03:34:45 syzkaller kern.warn kernel: [  194.055720][    C0]  __alloc_pages_noprof+0x223/0x25b0 mm/page_alloc.c:4751
May 18 03:34:45 syzkaller kern.warn kernel: [  194.062353][    C0]  ? __pfx___lock_acquire+0x10/0x10 kernel/locking/lockdep.c:4387
May 18 03:34:45 syzkaller kern.warn kernel: [  194.069158][    C0]  ? instrument_atomic_read include/linux/instrumented.h:68 [inline]
May 18 03:34:45 syzkaller kern.warn kernel: [  194.069158][    C0]  ? _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
May 18 03:34:45 syzkaller kern.warn kernel: [  194.069158][    C0]  ? hlock_class+0x4e/0x130 kernel/locking/lockdep.c:228
May 18 03:34:45 syzkaller kern.warn kernel: [  194.075008][    C0]  ? __lock_acquire+0xcc5/0x3c40 kernel/locking/lockdep.c:5223
May 18 03:34:45 syzkaller kern.warn kernel: [  194.081298][    C0]  ? __pfx___alloc_pages_noprof+0x10/0x10 mm/page_alloc.c:3519
May 18 03:34:45 syzkaller kern.warn kernel: [  194.088359][    C0]  ? find_held_lock+0x2d/0x110 kernel/locking/lockdep.c:5339
May 18 03:34:45 syzkaller kern.warn kernel: [  194.094472][    C0]  ? rcu_lock_release include/linux/rcupdate.h:347 [inline]
May 18 03:34:45 syzkaller kern.warn kernel: [  194.094472][    C0]  ? rcu_read_unlock include/linux/rcupdate.h:880 [inline]
May 18 03:34:45 syzkaller kern.warn kernel: [  194.094472][    C0]  ? is_bpf_text_address+0x8a/0x1a0 kernel/bpf/core.c:770


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

