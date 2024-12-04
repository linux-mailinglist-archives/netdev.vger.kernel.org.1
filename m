Return-Path: <netdev+bounces-149014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2969E3D00
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 15:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A677B2AAB3
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C343207A07;
	Wed,  4 Dec 2024 14:29:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B2F202F86
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322566; cv=none; b=BSEVxuOny7gK7ssB05JEvqJpfdyN2+tN8+dCaiKJSpmHQoU7N38TKwE1HVOQnWclMS6Ah6BOj4XRvG1ZgXqc1WkOL7Wr4FSosqBtyPG5hlCMufBPX7L0BfiVWrjNbHy5bUda3wCNUU2qcgUTd2ixo9948cJNKlsVQwy1CyLRL1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322566; c=relaxed/simple;
	bh=LBwJ6bbAn80WcRPQJQHQ6y5sHV7eCBHAdt1sUqOU46E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KUop+oRaOH+0wdZvmlF7TZS1cA2Z63FM1E3DBd9rQ6z9JZXmUvNG+KdXCepb5A9/0G72vY2XI6P9YFVQaA71I3WC3u3FB3gUQwAzM6leoMItgFdXd9Ljk7kM0LOiwQaM+HNPClEQh6gfZZjW5QjPQaIlq+9GK3GGMeDdQ0erBK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-8444dc6b982so86317839f.0
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 06:29:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733322563; x=1733927363;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lps44A56g0pBgvkO1wGgc43RH5tdrqdgb7gfd2Q29F0=;
        b=fwzgJFl8EvGxG3iY0vH1VSJDSrtHiB7seY4fTPJvtGjuGYlis7Hr5QYABh5zP44WVP
         phUw1MV8hlIKxaSd9b3H2848v00BH6aRhJJiLLaNBCCpTTzObmJ0yg5KoNyxFMn3Laxj
         yWa3flVsmU/iw8BRvsRxnOBDofowq31rRIs5TllJ9RJRAEIGlviBEh7O9xo0e98OoI4Q
         QgOKkqAQn/X6nYNtCYETNUzE3ZuZqP1TbAeAxiVGuyy4RefPObHuogNiFODtLZI6VJ07
         x01cO1LAiR5NBaZrIpzM3sNM2SP7teeXdl3zVy2A+vLYlk0O66lif8tDfBIsFrWvFKRC
         yaAg==
X-Forwarded-Encrypted: i=1; AJvYcCVb7FkhWHjEmtHy1z7RcWPxILz32WE11VcCoCxhTQn8h3d01iYtWttc31L2JNWTbyntqyHdVgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoYxi9Pkm+xLQdMS67EzhCu8lm4z/tpNk1MZReucDhYCmuKQ2f
	RNMMCmZz6MTq55vC8hL/FmvlBl79usxAhyHmuqnRrFQpZVB1jJ6C03/1eVomjoyAkNaN3nF9c9j
	dQuQ0yklMQe78sUW6KAYHVjnKzdp5EYj0S8LAsCmW1vuQaZ1rGug5/NA=
X-Google-Smtp-Source: AGHT+IFgTcMnqnLEchm6AYwwlMmWF4Isq8kow0RtCBzKXE7/a4W57FGYAcZ5duqwr3yHAHmI484RZkACbVkF70/zKndsj9DHWhvU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda4:0:b0:3a7:ca83:3f9 with SMTP id
 e9e14a558f8ab-3a7f9c1b5ddmr68369045ab.4.1733322563630; Wed, 04 Dec 2024
 06:29:23 -0800 (PST)
Date: Wed, 04 Dec 2024 06:29:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67506743.050a0220.17bd51.006e.GAE@google.com>
Subject: [syzbot] [net?] BUG: unable to handle kernel paging request in
 dst_dev_put (2)
From: syzbot <syzbot+9911f8283beca191268b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7b1d1d4cfac0 Merge remote-tracking branch 'iommu/arm/smmu'..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=114ca75f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dfe1e340fbee3d16
dashboard link: https://syzkaller.appspot.com/bug?extid=9911f8283beca191268b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/354fe38e2935/disk-7b1d1d4c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f12e0b1ef3fd/vmlinux-7b1d1d4c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/291dbc519bb3/Image-7b1d1d4c.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9911f8283beca191268b@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address dfff800000000000
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff800000000000] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.12.0-syzkaller-g7b1d1d4cfac0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : dst_dev_put+0x2c/0x2bc net/core/dst.c:146
lr : dst_dev_put+0x28/0x2bc net/core/dst.c:145
sp : ffff8000979379a0
x29: ffff8000979379a0 x28: ffffffffffffffff x27: ffff80008f16a000
x26: 1ffff00011e2d466 x25: dfff800000000000 x24: dfff800000000000
x23: 0000000000000000 x22: dfff800000000000 x21: ffff80008f821110
x20: 00007dfe9b881038 x19: 0000000000000002 x18: ffff0001b364a9a8
x17: 0000000000000040 x16: ffff800080585eb0 x15: 0000000000000001
x14: 1fffe0001df07cc3 x13: 0000000000000000 x12: 0000000000000000
x11: ffff60001df07cc4 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000c19e5ac0 x7 : ffff8000832ff164 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffff800089f54340
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000002
Call trace:
 dst_dev_put+0x2c/0x2bc net/core/dst.c:146 (P)
 dst_dev_put+0x28/0x2bc net/core/dst.c:145 (L)
 rt_fibinfo_free_cpus net/ipv4/fib_semantics.c:206 [inline]
 fib_nh_common_release+0x1f4/0x440 net/ipv4/fib_semantics.c:217
 fib6_nh_release+0x3a0/0x40c net/ipv6/route.c:3668
 fib6_info_destroy_rcu+0xc8/0x214 net/ipv6/ip6_fib.c:177
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0x898/0x1b5c kernel/rcu/tree.c:2823
 rcu_core_si+0x10/0x1c kernel/rcu/tree.c:2840
 handle_softirqs+0x2e0/0xbf8 kernel/softirq.c:554
 run_ksoftirqd+0x70/0xc0 kernel/softirq.c:949
 smpboot_thread_fn+0x4b0/0x90c kernel/smpboot.c:164
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862
Code: aa0003f3 f2fbfff6 97a314b2 d343fe77 (38766ae8) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	aa0003f3 	mov	x19, x0
   4:	f2fbfff6 	movk	x22, #0xdfff, lsl #48
   8:	97a314b2 	bl	0xfffffffffe8c52d0
   c:	d343fe77 	lsr	x23, x19, #3
* 10:	38766ae8 	ldrb	w8, [x23, x22] <-- trapping instruction


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

