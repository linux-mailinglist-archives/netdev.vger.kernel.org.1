Return-Path: <netdev+bounces-205178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CAEAFDB3E
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 00:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908B1585AD7
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 22:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA17253F1B;
	Tue,  8 Jul 2025 22:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w7t8zKGV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0519223C4FE
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 22:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752014494; cv=none; b=ItefcwP8DPTK500XkQ27LNwm13iK+mTUb9//g+8i8JRfWotkcHTOuObJCX71K+WPV6jMvRAXdM0gObJn9YjfXKptF/HFdyTKWGYbLCR7gMU6iobi9qpsTUK+oJcr8IpS6J7Zz/0HTSEEFEfD3c1+B6H86qC7rS9T04gZnv1zIaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752014494; c=relaxed/simple;
	bh=1kXyuLy/QYOBhxUnBWPyeTMfwhlJVYUe/3BjrWh6vqg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rdwYQSZuk1eg0w8KBRVh/SFZUgC9FoHPu2qQoawvByOQtVgFFfvEQaUqVmAz+2pf4IQzwYnjNev0mXKVGv4RFfOy+LDezJTgBVjLXy1CJFecxDZeWok8S5a5dJXCoQGGLKbhpINqWbEkh9YvBjhJA3gCqbPeIjltzKqdedjdPgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w7t8zKGV; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31215090074so7784271a91.0
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 15:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752014492; x=1752619292; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I0u1qoGnj9LN4tkr9GhaEhuZNf3o17sK4iKKs+684Xc=;
        b=w7t8zKGVMRdk+Cpw0B9J+yqHWgtPn1u/KRQp1fyQFsBoq/YcxOxtvtqz5pdW3JBZNX
         C2eDlXWHt+1vFVEpEhgZep22Aw3vA0xyOkp3aXKH+9v+B5dRCtVfXjfCQDjnR8giL8Fy
         BFC+kff7H1aAhUUkrs0c5oC0HkR7+LTHojkA2tqtFL95C2Za7jf5bul3CqssEiwIW2CC
         C+BqSVknUJvsjVU6r7JGDPCEpCuKqf9PUnTbTiiCAiXbD2tmi+p1opDRrP+tGj3JNyZs
         n3K+Lr8MpKpbK0W96KUgmPcKT+WeR1Cb7VKMsPH/ggPPVwzbdD4sdl+QWYs2sOl11fdg
         x6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752014492; x=1752619292;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0u1qoGnj9LN4tkr9GhaEhuZNf3o17sK4iKKs+684Xc=;
        b=Wu4lkMFjonzurI0t6EwylREX73kreC5H7Zarn0MbMgnNXdTmmd55O5YWk7q8QWX5HI
         Pncv74zmG53mCydsPdSYHsTNsedeozS/511XXmMLCG1zBXa7vGdELm0Yg299vIvx3fpS
         EYg2jWiqxLneYyxZwMi8HdgeIIT1XzEpsA71u5l7oUnCq6rh5Qupd//1rgtyMeYK/oI8
         vmLhFp/L2aVnwtgQprrwX6MG2VBcWPoW6eH+SCEHNpe2D2T856GfCQpQ05JNJ1JN09Xt
         6FpPLpOT44iUntWJIG5ouENKz6O8sDsLv20ZyTEtP6kPokCHD8iKxHvc+5e0PatkwlZ1
         t9eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuMdleELzObFaGQQeu208Nmbgx16j11dR3bwJTTcqFEBvxQYYWq5SUet0Ml07u3nppv63xkGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoMNpnUapDGovhP1QJZJ2uqcyQV0ixAvXk/PgDKVzX+CB9qoI+
	G/A2w72j3HWXtVQIW33IpNWafHv3vNdUEpJVW+rLIZ92vzRIue+QSEkKiA9xnDobENd9q8+aqcf
	YUrRUzQ==
X-Google-Smtp-Source: AGHT+IG35KopV0M6d/4mwwsrY1Z3Ock3I2TXgcjdcnhokqIHnAIu8j11vQ/lLNQRyARVssNNUj+GFLTnJmU=
X-Received: from pjbru11.prod.google.com ([2002:a17:90b:2bcb:b0:31c:2fe4:33bc])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3ec3:b0:311:e605:f60e
 with SMTP id 98e67ed59e1d1-31c2fdacf1dmr424271a91.20.1752014492333; Tue, 08
 Jul 2025 15:41:32 -0700 (PDT)
Date: Tue,  8 Jul 2025 22:41:26 +0000
In-Reply-To: <686d9b50.050a0220.1ffab7.0020.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <686d9b50.050a0220.1ffab7.0020.GAE@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250708224131.332014-1-kuniyu@google.com>
Subject: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
From: Kuniyuki Iwashima <kuniyu@google.com>
To: syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, paul@paul-moore.com, syzkaller-bugs@googlegroups.com, 
	kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"

From: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
Date: Tue, 08 Jul 2025 15:27:28 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7482bb149b9f Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=130c528c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3c06e3e2454512b3
> dashboard link: https://syzkaller.appspot.com/bug?extid=40bf00346c3fe40f90f2
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1257428c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15fe9582580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f623d741d651/disk-7482bb14.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/483e23ae71b1/vmlinux-7482bb14.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/79b5baaa1b50/Image-7482bb14.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> ODEBUG: activate active (active state 1) object: 000000006921da73 object type: rcu_head hint: 0x0
> WARNING: CPU: 0 PID: 6718 at lib/debugobjects.c:615 debug_print_object lib/debugobjects.c:612 [inline]
> WARNING: CPU: 0 PID: 6718 at lib/debugobjects.c:615 debug_object_activate+0x344/0x460 lib/debugobjects.c:842
> Modules linked in:
> CPU: 0 UID: 0 PID: 6718 Comm: syz.0.17 Not tainted 6.16.0-rc4-syzkaller-g7482bb149b9f #0 PREEMPT 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : debug_print_object lib/debugobjects.c:612 [inline]
> pc : debug_object_activate+0x344/0x460 lib/debugobjects.c:842
> lr : debug_print_object lib/debugobjects.c:612 [inline]
> lr : debug_object_activate+0x344/0x460 lib/debugobjects.c:842
> sp : ffff8000a03a76d0
> x29: ffff8000a03a76d0 x28: ffff8000976d7000 x27: dfff800000000000
> x26: ffff80008afc2480 x25: 0000000000000001 x24: ffff8000891ac9a0
> x23: 0000000000000003 x22: ffff80008b539420 x21: 0000000000000000
> x20: ffff80008afc2480 x19: ffff8000891ac9a0 x18: 00000000ffffffff
> x17: 3761643132393630 x16: ffff80008ae642c8 x15: ffff700011ede14c
> x14: 1ffff00011ede14c x13: 0000000000000004 x12: ffffffffffffffff
> x11: ffff700011ede14c x10: 0000000000ff0100 x9 : 5fa3c1ffaf0ff000
> x8 : 5fa3c1ffaf0ff000 x7 : 0000000000000001 x6 : 0000000000000001
> x5 : ffff8000a03a7018 x4 : ffff80008f766c20 x3 : ffff80008054d360
> x2 : 0000000000000000 x1 : 0000000000000201 x0 : 0000000000000000
> Call trace:
>  debug_print_object lib/debugobjects.c:612 [inline] (P)
>  debug_object_activate+0x344/0x460 lib/debugobjects.c:842 (P)
>  debug_rcu_head_queue kernel/rcu/rcu.h:236 [inline]
>  kvfree_call_rcu+0x4c/0x3f0 mm/slab_common.c:1953
>  cipso_v4_sock_setattr+0x2f0/0x3f4 net/ipv4/cipso_ipv4.c:1914
>  netlbl_sock_setattr+0x240/0x334 net/netlabel/netlabel_kapi.c:1000
>  smack_netlbl_add+0xa8/0x158 security/smack/smack_lsm.c:2581
>  smack_inode_setsecurity+0x378/0x430 security/smack/smack_lsm.c:2912
>  security_inode_setsecurity+0x118/0x3c0 security/security.c:2706
>  __vfs_setxattr_noperm+0x174/0x5c4 fs/xattr.c:251
>  __vfs_setxattr_locked+0x1ec/0x218 fs/xattr.c:295
>  vfs_setxattr+0x158/0x2ac fs/xattr.c:321
>  do_setxattr fs/xattr.c:636 [inline]
>  file_setxattr+0x1b8/0x294 fs/xattr.c:646
>  path_setxattrat+0x2ac/0x320 fs/xattr.c:711
>  __do_sys_fsetxattr fs/xattr.c:761 [inline]
>  __se_sys_fsetxattr fs/xattr.c:758 [inline]
>  __arm64_sys_fsetxattr+0xc0/0xdc fs/xattr.c:758
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
>  el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> irq event stamp: 739
> hardirqs last  enabled at (738): [<ffff80008055484c>] __up_console_sem kernel/printk/printk.c:344 [inline]
> hardirqs last  enabled at (738): [<ffff80008055484c>] __console_unlock+0x70/0xc4 kernel/printk/printk.c:2885
> hardirqs last disabled at (739): [<ffff80008aef73d4>] el1_brk64+0x1c/0x48 arch/arm64/kernel/entry-common.c:574
> softirqs last  enabled at (668): [<ffff8000891992e0>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
> softirqs last  enabled at (668): [<ffff8000891992e0>] release_sock+0x14c/0x1ac net/core/sock.c:3776
> softirqs last disabled at (712): [<ffff800082c8970c>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
> ---[ end trace 0000000000000000 ]---
> ------------[ cut here ]------------
> ODEBUG: active_state active (active state 1) object: 000000006921da73 object type: rcu_head hint: 0x0
> WARNING: CPU: 0 PID: 6718 at lib/debugobjects.c:615 debug_print_object lib/debugobjects.c:612 [inline]
> WARNING: CPU: 0 PID: 6718 at lib/debugobjects.c:615 debug_object_active_state+0x28c/0x350 lib/debugobjects.c:1064
> Modules linked in:
> CPU: 0 UID: 0 PID: 6718 Comm: syz.0.17 Tainted: G        W           6.16.0-rc4-syzkaller-g7482bb149b9f #0 PREEMPT 
> Tainted: [W]=WARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : debug_print_object lib/debugobjects.c:612 [inline]
> pc : debug_object_active_state+0x28c/0x350 lib/debugobjects.c:1064
> lr : debug_print_object lib/debugobjects.c:612 [inline]
> lr : debug_object_active_state+0x28c/0x350 lib/debugobjects.c:1064
> sp : ffff8000a03a76c0
> x29: ffff8000a03a76d0 x28: ffff80008f671000 x27: dfff800000000000
> x26: 0000000000000003 x25: 0000000000000000 x24: ffff0000cb6fd7a8
> x23: 0000000000000001 x22: ffff80008afc2480 x21: ffff80008b539420
> x20: 0000000000000000 x19: ffff8000891ac9a0 x18: 00000000ffffffff
> x17: 3239363030303030 x16: ffff80008ae642c8 x15: ffff700011ede14c
> x14: 1ffff00011ede14c x13: 0000000000000004 x12: ffffffffffffffff
> x11: ffff700011ede14c x10: 0000000000ff0100 x9 : 5fa3c1ffaf0ff000
> x8 : 5fa3c1ffaf0ff000 x7 : 0000000000000001 x6 : 0000000000000001
> x5 : ffff8000a03a7018 x4 : ffff80008f766c20 x3 : ffff80008054d360
> x2 : 0000000000000000 x1 : 0000000000000201 x0 : 0000000000000000
> Call trace:
>  debug_print_object lib/debugobjects.c:612 [inline] (P)
>  debug_object_active_state+0x28c/0x350 lib/debugobjects.c:1064 (P)
>  debug_rcu_head_queue kernel/rcu/rcu.h:237 [inline]
>  kvfree_call_rcu+0x64/0x3f0 mm/slab_common.c:1953
>  cipso_v4_sock_setattr+0x2f0/0x3f4 net/ipv4/cipso_ipv4.c:1914
>  netlbl_sock_setattr+0x240/0x334 net/netlabel/netlabel_kapi.c:1000
>  smack_netlbl_add+0xa8/0x158 security/smack/smack_lsm.c:2581
>  smack_inode_setsecurity+0x378/0x430 security/smack/smack_lsm.c:2912
>  security_inode_setsecurity+0x118/0x3c0 security/security.c:2706
>  __vfs_setxattr_noperm+0x174/0x5c4 fs/xattr.c:251
>  __vfs_setxattr_locked+0x1ec/0x218 fs/xattr.c:295
>  vfs_setxattr+0x158/0x2ac fs/xattr.c:321
>  do_setxattr fs/xattr.c:636 [inline]
>  file_setxattr+0x1b8/0x294 fs/xattr.c:646
>  path_setxattrat+0x2ac/0x320 fs/xattr.c:711
>  __do_sys_fsetxattr fs/xattr.c:761 [inline]
>  __se_sys_fsetxattr fs/xattr.c:758 [inline]
>  __arm64_sys_fsetxattr+0xc0/0xdc fs/xattr.c:758
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
>  el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> irq event stamp: 765
> hardirqs last  enabled at (764): [<ffff80008055484c>] __up_console_sem kernel/printk/printk.c:344 [inline]
> hardirqs last  enabled at (764): [<ffff80008055484c>] __console_unlock+0x70/0xc4 kernel/printk/printk.c:2885
> hardirqs last disabled at (765): [<ffff80008aef73d4>] el1_brk64+0x1c/0x48 arch/arm64/kernel/entry-common.c:574
> softirqs last  enabled at (668): [<ffff8000891992e0>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
> softirqs last  enabled at (668): [<ffff8000891992e0>] release_sock+0x14c/0x1ac net/core/sock.c:3776
> softirqs last disabled at (712): [<ffff800082c8970c>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
> ---[ end trace 0000000000000000 ]---
> ------------[ cut here ]------------
> kvfree_call_rcu(): Double-freed call. rcu_head 000000006921da73
> WARNING: CPU: 0 PID: 6718 at mm/slab_common.c:1956 kvfree_call_rcu+0x94/0x3f0 mm/slab_common.c:1955
> Modules linked in:
> CPU: 0 UID: 0 PID: 6718 Comm: syz.0.17 Tainted: G        W           6.16.0-rc4-syzkaller-g7482bb149b9f #0 PREEMPT 
> Tainted: [W]=WARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : kvfree_call_rcu+0x94/0x3f0 mm/slab_common.c:1955
> lr : kvfree_call_rcu+0x94/0x3f0 mm/slab_common.c:1955
> sp : ffff8000a03a7730
> x29: ffff8000a03a7730 x28: 00000000fffffff5 x27: 1fffe000184823d3
> x26: dfff800000000000 x25: ffff0000c2411e9e x24: ffff0000dd88da00
> x23: ffff8000891ac9a0 x22: 00000000ffffffea x21: ffff8000891ac9a0
> x20: ffff8000891ac9a0 x19: ffff80008afc2480 x18: 00000000ffffffff
> x17: 0000000000000000 x16: ffff80008ae642c8 x15: ffff700011ede14c
> x14: 1ffff00011ede14c x13: 0000000000000004 x12: ffffffffffffffff
> x11: ffff700011ede14c x10: 0000000000ff0100 x9 : 5fa3c1ffaf0ff000
> x8 : 5fa3c1ffaf0ff000 x7 : 0000000000000001 x6 : 0000000000000001
> x5 : ffff8000a03a7078 x4 : ffff80008f766c20 x3 : ffff80008054d360
> x2 : 0000000000000000 x1 : 0000000000000201 x0 : 0000000000000000
> Call trace:
>  kvfree_call_rcu+0x94/0x3f0 mm/slab_common.c:1955 (P)
>  cipso_v4_sock_setattr+0x2f0/0x3f4 net/ipv4/cipso_ipv4.c:1914
>  netlbl_sock_setattr+0x240/0x334 net/netlabel/netlabel_kapi.c:1000
>  smack_netlbl_add+0xa8/0x158 security/smack/smack_lsm.c:2581
>  smack_inode_setsecurity+0x378/0x430 security/smack/smack_lsm.c:2912
>  security_inode_setsecurity+0x118/0x3c0 security/security.c:2706
>  __vfs_setxattr_noperm+0x174/0x5c4 fs/xattr.c:251
>  __vfs_setxattr_locked+0x1ec/0x218 fs/xattr.c:295
>  vfs_setxattr+0x158/0x2ac fs/xattr.c:321
>  do_setxattr fs/xattr.c:636 [inline]
>  file_setxattr+0x1b8/0x294 fs/xattr.c:646
>  path_setxattrat+0x2ac/0x320 fs/xattr.c:711
>  __do_sys_fsetxattr fs/xattr.c:761 [inline]
>  __se_sys_fsetxattr fs/xattr.c:758 [inline]
>  __arm64_sys_fsetxattr+0xc0/0xdc fs/xattr.c:758
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
>  el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> irq event stamp: 789
> hardirqs last  enabled at (788): [<ffff80008055484c>] __up_console_sem kernel/printk/printk.c:344 [inline]
> hardirqs last  enabled at (788): [<ffff80008055484c>] __console_unlock+0x70/0xc4 kernel/printk/printk.c:2885
> hardirqs last disabled at (789): [<ffff80008aef73d4>] el1_brk64+0x1c/0x48 arch/arm64/kernel/entry-common.c:574
> softirqs last  enabled at (668): [<ffff8000891992e0>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
> softirqs last  enabled at (668): [<ffff8000891992e0>] release_sock+0x14c/0x1ac net/core/sock.c:3776
> softirqs last disabled at (712): [<ffff800082c8970c>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
> ---[ end trace 0000000000000000 ]---
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash

#syz test

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 3760131f14845..1fa519c597196 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -360,6 +360,16 @@ static void smc_destruct(struct sock *sk)
 		return;
 	if (!sock_flag(sk, SOCK_DEAD))
 		return;
+	switch (sk->sk_family) {
+	case AF_INET:
+		inet_sock_destruct(sk);
+		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case AF_INET6:
+		inet6_sock_destruct(sk);
+		break;
+#endif
+	}
 }
 
 static struct lock_class_key smc_key;
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 78ae10d06ed2e..cc59d0f03e261 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -283,7 +283,10 @@ struct smc_connection {
 };
 
 struct smc_sock {				/* smc sock container */
-	struct sock		sk;
+	union {
+		struct sock		sk;
+		struct inet_sock	icsk_inet;
+	};
 #if IS_ENABLED(CONFIG_IPV6)
 	struct ipv6_pinfo	*pinet6;
 #endif

