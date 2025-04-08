Return-Path: <netdev+bounces-180295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2226EA80E20
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688654E2FB9
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 14:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E050C224887;
	Tue,  8 Apr 2025 14:28:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2332122D783
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122514; cv=none; b=qkrw6WoBHLzoP2wJIq9CYGQPzucMR8UXKaxZSaL6KlMAAvVos6aIisMgvSUW+ChMHPbdr1X8+hPf/iiMSBWSjeoTBlzmOUgNxgKhA2dTFffHFXHjzI1xjURzULZzCQMPgOyIKzHc5jztpt5ld6hryoVMIUArDEoZfQRW7RUWNBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122514; c=relaxed/simple;
	bh=398S5M/+3ThGLSGVOv9sf6n6Yy7e5m97YGbR95ICRxk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QciJy1uIgLtpiVpQs3DwYJvigQKyb2yMDGkRL054SHkI1irZgvFBgg2y/VgUdSVCfjttto13PGLPi8CtueGtIM9kMm2epFXk2nkkpwVWaPNORo1BckhlynmEm+5WKpCjhOdNhm/SMhXJ4/PfOzK7OhhhGq6it2HgWTUJCVi4DvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d585d76b79so51291465ab.1
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 07:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744122512; x=1744727312;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JtXuRvcX8C77E5Akswrn1Sl1bpeVKHQo/mJn8kenfR4=;
        b=AyrQXOLNNP+BDAF46N9A6IKafpH4YcKewt2Xs8Ire1cBQv9YztjvlrBKodI7xu4hL9
         iR529PnWZ9brdUr7kg6jULg92ohAqbaJcoHVtyfMTGHRj/bIipX3/nyILkxua1JJgLCg
         FchrImPYwuplxDGXnH7i4IP5F90K6pse9JoQ+SQcGVoR7ySaiVsyrR6z19B0JG+NjgWF
         LTYxswaE3CaGI7zEdCv1NCaKiyq2Eg7ur+GuFkH3kzq9+MSU4OdF2K9Rfv+fQ0S6t4dD
         prVnpCS7km2SauWfhqPDNyIZX5Xr3sAHhubUe3pcFYR0Sh3HBiPCATcHLVomOjsP2omO
         oRbg==
X-Forwarded-Encrypted: i=1; AJvYcCUqj7p6p0JR+IvZDWMrBI4wTnFTRjiFQnKEhzqGqVB/Vj4qeOrYOghYeE71kbrbuqetXZbjqMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwscOPMDRYTdQ7YsepEVl0C9yWsAxA+Ms5LMju82R/6OBaVsGab
	lDf+dSgPaXO/6v5oBjXjsrZWYhyR9+8RtekS4pqvsYZsOSloT0lSMW0qyuTN0yiKnK7kMrlLXID
	QNWh9hTJhKM+28cFZ7mOQcB6K2SpKQ+CBUX1aO5XpLcQiMSH4g5+uJwQ=
X-Google-Smtp-Source: AGHT+IFoNpkB/lUnW65pvReYWeDk3+ygf0bApzJMpVPK3YVFmTw/cJxZBHNxhyG9I4g7Z/wiJrhExlo/bMXbwABgnE355CrZyIPx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4e:b0:3d5:bdac:c927 with SMTP id
 e9e14a558f8ab-3d6ec57ba36mr134066825ab.18.1744122512215; Tue, 08 Apr 2025
 07:28:32 -0700 (PDT)
Date: Tue, 08 Apr 2025 07:28:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f53290.050a0220.12542b.0000.GAE@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in __vxlan_find_mac (2)
From: syzbot <syzbot+30db32094d453eb54941@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    92b71befc349 Merge tag 'objtool-urgent-2025-04-01' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11cdcfb0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4ff50689306e9bc
dashboard link: https://syzkaller.appspot.com/bug?extid=30db32094d453eb54941
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3f382dc1af56/disk-92b71bef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f4e92ae0388c/vmlinux-92b71bef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bf44161687ac/bzImage-92b71bef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+30db32094d453eb54941@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in __vxlan_find_mac+0x49a/0x4f0 drivers/net/vxlan/vxlan_core.c:-1
 __vxlan_find_mac+0x49a/0x4f0 drivers/net/vxlan/vxlan_core.c:-1
 vxlan_find_mac drivers/net/vxlan/vxlan_core.c:437 [inline]
 vxlan_xmit+0x174c/0x3e40 drivers/net/vxlan/vxlan_core.c:2785
 __netdev_start_xmit include/linux/netdevice.h:5201 [inline]
 netdev_start_xmit include/linux/netdevice.h:5210 [inline]
 xmit_one net/core/dev.c:3780 [inline]
 dev_hard_start_xmit+0x296/0xa40 net/core/dev.c:3796
 __dev_queue_xmit+0x3679/0x57e0 net/core/dev.c:4633
 dev_queue_xmit include/linux/netdevice.h:3350 [inline]
 __bpf_tx_skb net/core/filter.c:2135 [inline]
 __bpf_redirect_common net/core/filter.c:2179 [inline]
 __bpf_redirect+0x1514/0x1690 net/core/filter.c:2186
 ____bpf_clone_redirect net/core/filter.c:2460 [inline]
 bpf_clone_redirect+0x37f/0x500 net/core/filter.c:2430
 ___bpf_prog_run+0x12fd/0xf0b0 kernel/bpf/core.c:2018
 __bpf_prog_run512+0xc5/0xf0 kernel/bpf/core.c:2313
 bpf_dispatcher_nop_func include/linux/bpf.h:1316 [inline]
 __bpf_prog_run include/linux/filter.h:718 [inline]
 bpf_prog_run include/linux/filter.h:725 [inline]
 bpf_test_run+0x546/0xd20 net/bpf/test_run.c:434
 bpf_prog_test_run_skb+0x1906/0x25b0 net/bpf/test_run.c:1093
 bpf_prog_test_run+0x5e5/0xa30 kernel/bpf/syscall.c:4427
 __sys_bpf+0x6ce/0xdf0 kernel/bpf/syscall.c:5852
 __do_sys_bpf kernel/bpf/syscall.c:5941 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5939 [inline]
 __ia32_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5939
 ia32_sys_call+0x2126/0x41f0 arch/x86/include/generated/asm/syscalls_32.h:358
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0xb0/0x110 arch/x86/entry/syscall_32.c:306
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/syscall_32.c:331
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:369
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4157 [inline]
 slab_alloc_node mm/slub.c:4200 [inline]
 kmem_cache_alloc_node_noprof+0x921/0xe10 mm/slub.c:4252
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:577
 pskb_expand_head+0x21f/0x1c10 net/core/skbuff.c:2247
 skb_ensure_writable+0x496/0x520 net/core/skbuff.c:6241
 __bpf_try_make_writable net/core/filter.c:1665 [inline]
 bpf_try_make_writable net/core/filter.c:1671 [inline]
 bpf_try_make_head_writable net/core/filter.c:1679 [inline]
 ____bpf_clone_redirect net/core/filter.c:2454 [inline]
 bpf_clone_redirect+0x1c5/0x500 net/core/filter.c:2430
 ___bpf_prog_run+0x12fd/0xf0b0 kernel/bpf/core.c:2018
 __bpf_prog_run512+0xc5/0xf0 kernel/bpf/core.c:2313
 bpf_dispatcher_nop_func include/linux/bpf.h:1316 [inline]
 __bpf_prog_run include/linux/filter.h:718 [inline]
 bpf_prog_run include/linux/filter.h:725 [inline]
 bpf_test_run+0x546/0xd20 net/bpf/test_run.c:434
 bpf_prog_test_run_skb+0x1906/0x25b0 net/bpf/test_run.c:1093
 bpf_prog_test_run+0x5e5/0xa30 kernel/bpf/syscall.c:4427
 __sys_bpf+0x6ce/0xdf0 kernel/bpf/syscall.c:5852
 __do_sys_bpf kernel/bpf/syscall.c:5941 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5939 [inline]
 __ia32_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5939
 ia32_sys_call+0x2126/0x41f0 arch/x86/include/generated/asm/syscalls_32.h:358
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0xb0/0x110 arch/x86/entry/syscall_32.c:306
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/syscall_32.c:331
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:369
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

CPU: 0 UID: 0 PID: 9482 Comm: syz.5.941 Not tainted 6.14.0-syzkaller-12508-g92b71befc349 #0 PREEMPT(undef) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
=====================================================


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

