Return-Path: <netdev+bounces-205177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBF8AFDB1F
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 00:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71DF1C40688
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 22:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEE414EC73;
	Tue,  8 Jul 2025 22:27:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C64F1E7C27
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 22:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013651; cv=none; b=lGjqkrMVf21CFqKtci8p51KxmkB8HKwuSzYg/WCs+UF+yEksqNBAnISy9S7GhBzsYdKPKecFSMg46rctSiAKkZZYiFF1pFXuV/91GJR9PIyWi77jHWNMH7zr67/hDWWx/GOzr7KXnnjUou691rnIJK1mK8qgLKIRWnw+Q77B3ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013651; c=relaxed/simple;
	bh=sayrtEG6guArnwkZuIBE5coX1Qj2xO25GUYAvkcYqu4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nX7rNjUCqbfWZBCBjlGBG+ZWNj0aKjfFn8c+XTAMpKDgqFBc3/6CIzC0/PZLzTWLsYQ2ozK6ij7qo0wDHPmrQJMRagXwJWqNYhw9hDsC8dZRiAs0OHclVbJR210FeOKYUOdnYCbpTKxjkAYL/3rxMwB4MBN31/M5NivpnOBjCOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-87595d00ca0so423393139f.2
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 15:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752013648; x=1752618448;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d1xR6ooTAkYxfNV5IzQoDoKyH/Bd84tfDPZiEZOdJDM=;
        b=H+XTDN3e5cXjw44nbsJMfevkKWg/CSS/rmINh/YO8loKMUokfjiL1AHrHPjJknnvsF
         2RjDZyXbECo8IPy5hS/w8DNX6nPOZydk2SAx2PwWKr/TpUcTmF0dUBnK9J7RrEb7Byig
         XIm081Td9ECq17qUym0CHjuQg7/FlGK9q9URNkf3FDxyYWHvplbIvMgC0gJlANmw4Yuv
         jAj516j0WZ1PcsajYSGXVSEGThZSjsXokbDII9+yfTDT7+61KoxB4FyFoF4z/Z0jccMI
         UT16cGw6SkpbQ0ZlIeDfSwk2oGgOW3XbhZnl9ulfY6hYxgzKWcdN7XTkLDpCL9nq8Tjm
         8wBw==
X-Forwarded-Encrypted: i=1; AJvYcCXfiuk0IvlQglHISiOIFOT5YFA1mbn5tgDsn5kPtBJAQ4tynSLezsMKVRumI3IsC05eMWUs7RA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBnvdaSMR1g+ljzFQNrd0SBJvJHn6lYLLfbYjCTD9OFdO7Uqjv
	Xy8Zn7LZbHdPVyhaIMJ+QylXpMbS92ITEQQpTu+Up3JHO7T4RcKcOoOOa69Hfk8UT6nGaeFQxzx
	nBEYPNsh6kdb7npj9Yq7Ox+FUKXZorrtoXjFj0Kn7e0lR4fiaGeJto0GOmVU=
X-Google-Smtp-Source: AGHT+IGphRgLQSuvfExX3Per8u8Emz46SEksZLHuClAGnJGJe1jNRHv0GDjO4mtS4u6HbSTYgVJhfq6i3M51lYoxkUNn/mmzUh+k
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c8e:b0:879:26b0:1cca with SMTP id
 ca18e2360f4ac-8795b4d8c99mr46794639f.13.1752013648377; Tue, 08 Jul 2025
 15:27:28 -0700 (PDT)
Date: Tue, 08 Jul 2025 15:27:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686d9b50.050a0220.1ffab7.0020.GAE@google.com>
Subject: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
From: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, paul@paul-moore.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7482bb149b9f Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=130c528c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c06e3e2454512b3
dashboard link: https://syzkaller.appspot.com/bug?extid=40bf00346c3fe40f90f2
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1257428c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15fe9582580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f623d741d651/disk-7482bb14.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/483e23ae71b1/vmlinux-7482bb14.xz
kernel image: https://storage.googleapis.com/syzbot-assets/79b5baaa1b50/Image-7482bb14.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: activate active (active state 1) object: 000000006921da73 object type: rcu_head hint: 0x0
WARNING: CPU: 0 PID: 6718 at lib/debugobjects.c:615 debug_print_object lib/debugobjects.c:612 [inline]
WARNING: CPU: 0 PID: 6718 at lib/debugobjects.c:615 debug_object_activate+0x344/0x460 lib/debugobjects.c:842
Modules linked in:
CPU: 0 UID: 0 PID: 6718 Comm: syz.0.17 Not tainted 6.16.0-rc4-syzkaller-g7482bb149b9f #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:612 [inline]
pc : debug_object_activate+0x344/0x460 lib/debugobjects.c:842
lr : debug_print_object lib/debugobjects.c:612 [inline]
lr : debug_object_activate+0x344/0x460 lib/debugobjects.c:842
sp : ffff8000a03a76d0
x29: ffff8000a03a76d0 x28: ffff8000976d7000 x27: dfff800000000000
x26: ffff80008afc2480 x25: 0000000000000001 x24: ffff8000891ac9a0
x23: 0000000000000003 x22: ffff80008b539420 x21: 0000000000000000
x20: ffff80008afc2480 x19: ffff8000891ac9a0 x18: 00000000ffffffff
x17: 3761643132393630 x16: ffff80008ae642c8 x15: ffff700011ede14c
x14: 1ffff00011ede14c x13: 0000000000000004 x12: ffffffffffffffff
x11: ffff700011ede14c x10: 0000000000ff0100 x9 : 5fa3c1ffaf0ff000
x8 : 5fa3c1ffaf0ff000 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff8000a03a7018 x4 : ffff80008f766c20 x3 : ffff80008054d360
x2 : 0000000000000000 x1 : 0000000000000201 x0 : 0000000000000000
Call trace:
 debug_print_object lib/debugobjects.c:612 [inline] (P)
 debug_object_activate+0x344/0x460 lib/debugobjects.c:842 (P)
 debug_rcu_head_queue kernel/rcu/rcu.h:236 [inline]
 kvfree_call_rcu+0x4c/0x3f0 mm/slab_common.c:1953
 cipso_v4_sock_setattr+0x2f0/0x3f4 net/ipv4/cipso_ipv4.c:1914
 netlbl_sock_setattr+0x240/0x334 net/netlabel/netlabel_kapi.c:1000
 smack_netlbl_add+0xa8/0x158 security/smack/smack_lsm.c:2581
 smack_inode_setsecurity+0x378/0x430 security/smack/smack_lsm.c:2912
 security_inode_setsecurity+0x118/0x3c0 security/security.c:2706
 __vfs_setxattr_noperm+0x174/0x5c4 fs/xattr.c:251
 __vfs_setxattr_locked+0x1ec/0x218 fs/xattr.c:295
 vfs_setxattr+0x158/0x2ac fs/xattr.c:321
 do_setxattr fs/xattr.c:636 [inline]
 file_setxattr+0x1b8/0x294 fs/xattr.c:646
 path_setxattrat+0x2ac/0x320 fs/xattr.c:711
 __do_sys_fsetxattr fs/xattr.c:761 [inline]
 __se_sys_fsetxattr fs/xattr.c:758 [inline]
 __arm64_sys_fsetxattr+0xc0/0xdc fs/xattr.c:758
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 739
hardirqs last  enabled at (738): [<ffff80008055484c>] __up_console_sem kernel/printk/printk.c:344 [inline]
hardirqs last  enabled at (738): [<ffff80008055484c>] __console_unlock+0x70/0xc4 kernel/printk/printk.c:2885
hardirqs last disabled at (739): [<ffff80008aef73d4>] el1_brk64+0x1c/0x48 arch/arm64/kernel/entry-common.c:574
softirqs last  enabled at (668): [<ffff8000891992e0>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (668): [<ffff8000891992e0>] release_sock+0x14c/0x1ac net/core/sock.c:3776
softirqs last disabled at (712): [<ffff800082c8970c>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ODEBUG: active_state active (active state 1) object: 000000006921da73 object type: rcu_head hint: 0x0
WARNING: CPU: 0 PID: 6718 at lib/debugobjects.c:615 debug_print_object lib/debugobjects.c:612 [inline]
WARNING: CPU: 0 PID: 6718 at lib/debugobjects.c:615 debug_object_active_state+0x28c/0x350 lib/debugobjects.c:1064
Modules linked in:
CPU: 0 UID: 0 PID: 6718 Comm: syz.0.17 Tainted: G        W           6.16.0-rc4-syzkaller-g7482bb149b9f #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:612 [inline]
pc : debug_object_active_state+0x28c/0x350 lib/debugobjects.c:1064
lr : debug_print_object lib/debugobjects.c:612 [inline]
lr : debug_object_active_state+0x28c/0x350 lib/debugobjects.c:1064
sp : ffff8000a03a76c0
x29: ffff8000a03a76d0 x28: ffff80008f671000 x27: dfff800000000000
x26: 0000000000000003 x25: 0000000000000000 x24: ffff0000cb6fd7a8
x23: 0000000000000001 x22: ffff80008afc2480 x21: ffff80008b539420
x20: 0000000000000000 x19: ffff8000891ac9a0 x18: 00000000ffffffff
x17: 3239363030303030 x16: ffff80008ae642c8 x15: ffff700011ede14c
x14: 1ffff00011ede14c x13: 0000000000000004 x12: ffffffffffffffff
x11: ffff700011ede14c x10: 0000000000ff0100 x9 : 5fa3c1ffaf0ff000
x8 : 5fa3c1ffaf0ff000 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff8000a03a7018 x4 : ffff80008f766c20 x3 : ffff80008054d360
x2 : 0000000000000000 x1 : 0000000000000201 x0 : 0000000000000000
Call trace:
 debug_print_object lib/debugobjects.c:612 [inline] (P)
 debug_object_active_state+0x28c/0x350 lib/debugobjects.c:1064 (P)
 debug_rcu_head_queue kernel/rcu/rcu.h:237 [inline]
 kvfree_call_rcu+0x64/0x3f0 mm/slab_common.c:1953
 cipso_v4_sock_setattr+0x2f0/0x3f4 net/ipv4/cipso_ipv4.c:1914
 netlbl_sock_setattr+0x240/0x334 net/netlabel/netlabel_kapi.c:1000
 smack_netlbl_add+0xa8/0x158 security/smack/smack_lsm.c:2581
 smack_inode_setsecurity+0x378/0x430 security/smack/smack_lsm.c:2912
 security_inode_setsecurity+0x118/0x3c0 security/security.c:2706
 __vfs_setxattr_noperm+0x174/0x5c4 fs/xattr.c:251
 __vfs_setxattr_locked+0x1ec/0x218 fs/xattr.c:295
 vfs_setxattr+0x158/0x2ac fs/xattr.c:321
 do_setxattr fs/xattr.c:636 [inline]
 file_setxattr+0x1b8/0x294 fs/xattr.c:646
 path_setxattrat+0x2ac/0x320 fs/xattr.c:711
 __do_sys_fsetxattr fs/xattr.c:761 [inline]
 __se_sys_fsetxattr fs/xattr.c:758 [inline]
 __arm64_sys_fsetxattr+0xc0/0xdc fs/xattr.c:758
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 765
hardirqs last  enabled at (764): [<ffff80008055484c>] __up_console_sem kernel/printk/printk.c:344 [inline]
hardirqs last  enabled at (764): [<ffff80008055484c>] __console_unlock+0x70/0xc4 kernel/printk/printk.c:2885
hardirqs last disabled at (765): [<ffff80008aef73d4>] el1_brk64+0x1c/0x48 arch/arm64/kernel/entry-common.c:574
softirqs last  enabled at (668): [<ffff8000891992e0>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (668): [<ffff8000891992e0>] release_sock+0x14c/0x1ac net/core/sock.c:3776
softirqs last disabled at (712): [<ffff800082c8970c>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
kvfree_call_rcu(): Double-freed call. rcu_head 000000006921da73
WARNING: CPU: 0 PID: 6718 at mm/slab_common.c:1956 kvfree_call_rcu+0x94/0x3f0 mm/slab_common.c:1955
Modules linked in:
CPU: 0 UID: 0 PID: 6718 Comm: syz.0.17 Tainted: G        W           6.16.0-rc4-syzkaller-g7482bb149b9f #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : kvfree_call_rcu+0x94/0x3f0 mm/slab_common.c:1955
lr : kvfree_call_rcu+0x94/0x3f0 mm/slab_common.c:1955
sp : ffff8000a03a7730
x29: ffff8000a03a7730 x28: 00000000fffffff5 x27: 1fffe000184823d3
x26: dfff800000000000 x25: ffff0000c2411e9e x24: ffff0000dd88da00
x23: ffff8000891ac9a0 x22: 00000000ffffffea x21: ffff8000891ac9a0
x20: ffff8000891ac9a0 x19: ffff80008afc2480 x18: 00000000ffffffff
x17: 0000000000000000 x16: ffff80008ae642c8 x15: ffff700011ede14c
x14: 1ffff00011ede14c x13: 0000000000000004 x12: ffffffffffffffff
x11: ffff700011ede14c x10: 0000000000ff0100 x9 : 5fa3c1ffaf0ff000
x8 : 5fa3c1ffaf0ff000 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff8000a03a7078 x4 : ffff80008f766c20 x3 : ffff80008054d360
x2 : 0000000000000000 x1 : 0000000000000201 x0 : 0000000000000000
Call trace:
 kvfree_call_rcu+0x94/0x3f0 mm/slab_common.c:1955 (P)
 cipso_v4_sock_setattr+0x2f0/0x3f4 net/ipv4/cipso_ipv4.c:1914
 netlbl_sock_setattr+0x240/0x334 net/netlabel/netlabel_kapi.c:1000
 smack_netlbl_add+0xa8/0x158 security/smack/smack_lsm.c:2581
 smack_inode_setsecurity+0x378/0x430 security/smack/smack_lsm.c:2912
 security_inode_setsecurity+0x118/0x3c0 security/security.c:2706
 __vfs_setxattr_noperm+0x174/0x5c4 fs/xattr.c:251
 __vfs_setxattr_locked+0x1ec/0x218 fs/xattr.c:295
 vfs_setxattr+0x158/0x2ac fs/xattr.c:321
 do_setxattr fs/xattr.c:636 [inline]
 file_setxattr+0x1b8/0x294 fs/xattr.c:646
 path_setxattrat+0x2ac/0x320 fs/xattr.c:711
 __do_sys_fsetxattr fs/xattr.c:761 [inline]
 __se_sys_fsetxattr fs/xattr.c:758 [inline]
 __arm64_sys_fsetxattr+0xc0/0xdc fs/xattr.c:758
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 789
hardirqs last  enabled at (788): [<ffff80008055484c>] __up_console_sem kernel/printk/printk.c:344 [inline]
hardirqs last  enabled at (788): [<ffff80008055484c>] __console_unlock+0x70/0xc4 kernel/printk/printk.c:2885
hardirqs last disabled at (789): [<ffff80008aef73d4>] el1_brk64+0x1c/0x48 arch/arm64/kernel/entry-common.c:574
softirqs last  enabled at (668): [<ffff8000891992e0>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (668): [<ffff8000891992e0>] release_sock+0x14c/0x1ac net/core/sock.c:3776
softirqs last disabled at (712): [<ffff800082c8970c>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


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

