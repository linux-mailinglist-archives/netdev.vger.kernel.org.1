Return-Path: <netdev+bounces-103828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D7B909BB3
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 07:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 728E0B2130E
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 05:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CCC16D4E9;
	Sun, 16 Jun 2024 05:54:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56F216D30F
	for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 05:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718517262; cv=none; b=L+GQoV8VBTDWTBKS7xHEDeKgoCI2dzInde6hyslsNgvMwn3eA2N7a6o0dGTfikBfkGNaCdGAK5hGiqFxTotiOgItdcz8RKNgSlWCqv0+pNHsgm0tVjeFDrKjYveLHxWiiZRacJYHl1YQ4MSf1UKIGYAuAacoDuTgDAg0QsaHwB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718517262; c=relaxed/simple;
	bh=B1Mi2iB4rh+LdPeBChRnGFShUhSfHM6ihPGxVKoaAwM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fGxnsCHRc+/qBqjZx+5Y+9LrZR/Q1emmrHqdLAZ9DsuTFruOAtUrAamtrLS33kCXI1bsTUX5ds3eJcczvlv55uvCd9ku+otOxqGT2b27A/VZWj2tTzqDEeyhFO1E1IiomSuzArCsHossQxt2MhqACTAkflb1FURzgfAJrpBXU4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-375e4d55457so21751365ab.0
        for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 22:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718517260; x=1719122060;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=romJDKF4YYdUcNlHKmmiJoWHinqaoX9oJ6SM72wKzyk=;
        b=vqbgtkj1xslUK0GozfwPvb3E3UNboWcbK3+Tbet64AdNuxepC1DKPr2g5HXKXGhl7N
         gi1xTjPHIEdhEfTtWVxmRhbWxgBwkLVTCPGl81dF/UpgpJ3JCxi9b4K77SUqOLFUEDRI
         YdcOq7ZOKZipkF9KpkxjfrkB1K54dKdHJMs5WHPQam/v2PkOPdB2qXx39GMzTretYEPU
         ncwAZ0dkbsu7Iv+pGGJP3efsuPlHiE3NyFTjwjCQxAZh7KmUtFtc1Wb/dcl6mVrZecNI
         WaNT8vG0idDb51fviG3OqqkASRd/B1URgaVN5iXIIRaJZR0CNNdh6ZQ9J2FLHhQ9ZpIm
         Fc2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1So73EyBFFlO3XcA5lUcahG7JNw5wZ1R2RBR7kLdFPbbY1a9WkOZjjdgOuRhMYSkCWZBLJ/ViK3h5mAO27ieZ7x9XcgqD
X-Gm-Message-State: AOJu0YyJLTfbNLQz3tWO8Es/mR6ko5Py18WpzQNZTo8cajvNk0ux73L/
	jhfktQlnjkmCWvtjs6WhmeY/EldsFhmTtkCPXMyjTIAKrGwNzq8SaGQ9U38O5GcrYq4UGSY3IAx
	ml0OhfJ9Yvc/AcuvmH0f0Zk+snoxzccQRwdjJkCVoFKESmLorOcAun3I=
X-Google-Smtp-Source: AGHT+IE2Gd+LOe88pC+S0lKc6d8yttgEK0N/YWyestZ/pdZSMy4wAkxPXqJ47g9Prl9B8V7DJLFuWv6LzPsnTqBeF0wTRpUHU0aJ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c29:b0:375:9deb:ceb8 with SMTP id
 e9e14a558f8ab-375e1014718mr3864085ab.3.1718517259888; Sat, 15 Jun 2024
 22:54:19 -0700 (PDT)
Date: Sat, 15 Jun 2024 22:54:19 -0700
In-Reply-To: <00000000000041df050616f6ba4e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d0fffc061afb7a2c@google.com>
Subject: Re: [syzbot] [mm?] possible deadlock in __mmap_lock_do_trace_start_locking
From: syzbot <syzbot+6ff90931779bcdfc840c@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    36534d3c5453 tcp: use signed arithmetic in tcp_rtx_probe0_..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=110e9dde980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=333ebe38d43c42e2
dashboard link: https://syzkaller.appspot.com/bug?extid=6ff90931779bcdfc840c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1585acfa980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bdb7ee980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4e648f638b5f/disk-36534d3c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bbe0d41240f1/vmlinux-36534d3c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/17eb17ecd214/bzImage-36534d3c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6ff90931779bcdfc840c@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.10.0-rc2-syzkaller-00242-g36534d3c5453 #0 Not tainted
--------------------------------------------
syz-executor181/5090 is trying to acquire lock:
ffff8880b9538828 (lock#9){+.+.}-{2:2}, at: local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
ffff8880b9538828 (lock#9){+.+.}-{2:2}, at: __mmap_lock_do_trace_start_locking+0x83/0x620 mm/mmap_lock.c:230

but task is already holding lock:
ffff8880b9538828 (lock#9){+.+.}-{2:2}, at: local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
ffff8880b9538828 (lock#9){+.+.}-{2:2}, at: __mmap_lock_do_trace_start_locking+0x83/0x620 mm/mmap_lock.c:230

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(lock#9);
  lock(lock#9);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by syz-executor181/5090:
 #0: ffff8880b9538828 (lock#9){+.+.}-{2:2}, at: local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
 #0: ffff8880b9538828 (lock#9){+.+.}-{2:2}, at: __mmap_lock_do_trace_start_locking+0x83/0x620 mm/mmap_lock.c:230
 #1: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #1: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #1: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: get_mem_cgroup_from_mm+0x38/0x2a0 mm/memcontrol.c:1265
 #2: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: trace_call_bpf+0xbc/0x8a0

stack backtrace:
CPU: 1 PID: 5090 Comm: syz-executor181 Not tainted 6.10.0-rc2-syzkaller-00242-g36534d3c5453 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain+0x15d3/0x5900 kernel/locking/lockdep.c:3856
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
 __mmap_lock_do_trace_start_locking+0x9c/0x620 mm/mmap_lock.c:230
 __mmap_lock_trace_start_locking include/linux/mmap_lock.h:29 [inline]
 mmap_read_trylock include/linux/mmap_lock.h:162 [inline]
 stack_map_get_build_id_offset+0x98a/0x9d0 kernel/bpf/stackmap.c:141
 __bpf_get_stack+0x4ad/0x5a0 kernel/bpf/stackmap.c:449
 bpf_prog_e6cf5f9c69743609+0x42/0x46
 bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run include/linux/filter.h:698 [inline]
 bpf_prog_run_array include/linux/bpf.h:2103 [inline]
 trace_call_bpf+0x369/0x8a0 kernel/trace/bpf_trace.c:147
 perf_trace_run_bpf_submit+0x7c/0x1d0 kernel/events/core.c:10269
 perf_trace_lock+0x388/0x490 include/trace/events/lock.h:50
 trace_lock_release include/trace/events/lock.h:69 [inline]
 lock_release+0x986/0x9f0 kernel/locking/lockdep.c:5765
 rcu_lock_release include/linux/rcupdate.h:339 [inline]
 rcu_read_unlock include/linux/rcupdate.h:812 [inline]
 get_mem_cgroup_from_mm+0x1ad/0x2a0 mm/memcontrol.c:1271
 get_mm_memcg_path+0x1b/0x600 mm/mmap_lock.c:202
 __mmap_lock_do_trace_start_locking+0x134/0x620 mm/mmap_lock.c:230
 __mmap_lock_trace_start_locking include/linux/mmap_lock.h:29 [inline]
 mmap_read_lock include/linux/mmap_lock.h:143 [inline]
 acct_collect+0x7e7/0x830 kernel/acct.c:563
 do_exit+0x936/0x27e0 kernel/exit.c:853
 do_group_exit+0x207/0x2c0 kernel/exit.c:1023
 __do_sys_exit_group kernel/exit.c:1034 [inline]
 __se_sys_exit_group kernel/exit.c:1032 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9c47742279
Code: 90 49 c7 c0 b8 ff ff ff be e7 00 00 00 ba 3c 00 00 00 eb 12 0f 1f 44 00 00 89 d0 0f 05 48 3d 00 f0 ff ff 77 1c f4 89 f0 0f 05 <48> 3d 00 f0 ff ff 76 e7 f7 d8 64 41 89 00 eb df 0f 1f 80 00 00 00
RSP: 002b:00007ffd321ae558 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9c47742279
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007f9c477bd2b0 R08: ffffffffffffffb8 R09: 00000000000000a0
R10: 00000000000000a0 R11: 0000000000000246 R12: 00007f9c477bd2b0
R13: 0000000000000000 R14: 00007f9c477bdd20 R15: 00007f9c47713400
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

