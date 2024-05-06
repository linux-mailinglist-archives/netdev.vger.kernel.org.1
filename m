Return-Path: <netdev+bounces-93647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A71F98BC989
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 10:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6213F280E94
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 08:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFAD1419BC;
	Mon,  6 May 2024 08:26:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D051411F6
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 08:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714983985; cv=none; b=kSyKMUzNUmOUI6AYQ+dauKy73G1sHR370td2R1rU9wkPVDCZYLB809XrytFKOeqVap+oxFPs0FWI67p7ZZrvW8ttOU1yVBKd5lW3u+jwGHj02wkKLZr2FyBJXG/v+z/brbctjHeRTiQuGfWVw8TuAd8KR2emKlO4FrnmJg2MS5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714983985; c=relaxed/simple;
	bh=1gnWL3AWkbByxKqcsyTl0Pn9NxYdIMlbdOu27yM+k7Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Dd7vIWebbNXrzq4fWDPM7ud+U4r43ggc33+iw/RpDrPQAR1El7pRMjM10u9WTGujgG5k0flrSwYIdxXK08Lmw/H/MTGwFREP7BDYLVB9VCJy6yTAwzbLzgNdB/26+qJRJjj4B3q/RETaIfVwUGO0gnTid6pBwz0Z5ycK2fUw23g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7dab89699a8so211122039f.2
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 01:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714983983; x=1715588783;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4oQYfjPoTswq9La2UDJTWDIy0E4GcKbv/iMKFV9nv4Y=;
        b=s4X1MF7bs8hY5ZcbCjexXwORC3KgCLP2pGgR7kpI/Sze53Ep1hlIGo6CdoMJRTwcj8
         YzVB5nchGQKHuNOKcA7o/GUTRA7PCpv9azqvtINqoWfCY9seae1SefyJsZiqZlnMd//4
         zCstt6JeV78n8ctfXQG411nBNETdfahNtE65m77dqhxN99jMEoxcEJ+PBKa7Mz9ajcdQ
         OFJYO0Sv/1sJlGqhAcI9LWKctr9CHj978lDnSx1QS7JRgFs4MZYN/CRbb6f4av9ThBMT
         WyxM4FZhFreHZp5eowKfmvJ/JPOv6XVPiSismxYg0Z9H2BsICJAN2HLVQ2aVXdNwtTgx
         ZLIw==
X-Forwarded-Encrypted: i=1; AJvYcCXeHjUzGrGSgO9Xrtc0+IKUjrBco5p5r9GJDM232hBNCfd/21aJ++2MbupSF1j94A48BWZwTqcSkLig/LTYIEX1ucXxAxN+
X-Gm-Message-State: AOJu0YxcwDh9pJ9fjsG6qyhux4Wl+rfXDQoKvMF32nPWqHrPxxeKS+jp
	Hh2LzbHPhDVY5zhKB0RiLRiGaI38rX7r6CZuAjJDleOPd+8BhPH4VbJnc3YOwBF9MY6YwktGKsO
	iFGlgR2dRJ9QcK3NjduJNWE92ZlYXCCwHsmY/dneHxPO37EscL23xiX0=
X-Google-Smtp-Source: AGHT+IH0auiScA/jwdSBOyDC5Dqm3jkTillkPzY+x0oBjWx/wYwoXx2mSnERXRQoer2DfOhUl2EPNYhPfCZi/AFuVLc4sZCUfb6O
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:a412:0:b0:488:59cc:eb4c with SMTP id
 c18-20020a02a412000000b0048859cceb4cmr389030jal.3.1714983983599; Mon, 06 May
 2024 01:26:23 -0700 (PDT)
Date: Mon, 06 May 2024 01:26:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000235bec0617c4d391@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in cmsghdr_from_user_compat_to_kern
From: syzbot <syzbot+bbafcc77279b6c156e52@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7367539ad4b0 Merge tag 'cxl-fixes-6.9-rc7' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1444078b180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbf567496022057b
dashboard link: https://syzkaller.appspot.com/bug?extid=bbafcc77279b6c156e52
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b037b3fdb412/disk-7367539a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/715a45b086cb/vmlinux-7367539a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a13ab40a70b3/bzImage-7367539a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bbafcc77279b6c156e52@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in cmsghdr_from_user_compat_to_kern+0x568/0x10d0 net/compat.c:154
 cmsghdr_from_user_compat_to_kern+0x568/0x10d0 net/compat.c:154
 ____sys_sendmsg+0x222/0xb60 net/socket.c:2546
 __sys_sendmsg_sock+0x42/0x60 net/socket.c:2650
 io_sendmsg+0x47a/0x1020 io_uring/net.c:453
 io_issue_sqe+0x371/0x1150 io_uring/io_uring.c:1897
 io_wq_submit_work+0xa17/0xeb0 io_uring/io_uring.c:2006
 io_worker_handle_work+0xc3a/0x2050 io_uring/io-wq.c:596
 io_wq_worker+0x5a1/0x1370 io_uring/io-wq.c:649
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 io_sendmsg+0x6a4/0x1020 io_uring/net.c:435
 io_issue_sqe+0x371/0x1150 io_uring/io_uring.c:1897
 io_wq_submit_work+0xa17/0xeb0 io_uring/io_uring.c:2006
 io_worker_handle_work+0xc3a/0x2050 io_uring/io-wq.c:596
 io_wq_worker+0x5a1/0x1370 io_uring/io-wq.c:649
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2175 [inline]
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x2de/0x1400 mm/slub.c:2391
 ___slab_alloc+0x1184/0x33d0 mm/slub.c:3525
 __kmem_cache_alloc_bulk mm/slub.c:4555 [inline]
 kmem_cache_alloc_bulk+0x503/0x13e0 mm/slub.c:4629
 __io_alloc_req_refill+0x248/0x780 io_uring/io_uring.c:1101
 io_alloc_req io_uring/io_uring.h:405 [inline]
 io_submit_sqes+0xaba/0x2fe0 io_uring/io_uring.c:2481
 __do_sys_io_uring_enter io_uring/io_uring.c:3668 [inline]
 __se_sys_io_uring_enter+0x407/0x4400 io_uring/io_uring.c:3603
 __ia32_sys_io_uring_enter+0x11d/0x1a0 io_uring/io_uring.c:3603
 ia32_sys_call+0x2c0/0x40a0 arch/x86/include/generated/asm/syscalls_32.h:427
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb4/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/common.c:411
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:449
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

CPU: 1 PID: 20102 Comm: iou-wrk-20100 Tainted: G        W          6.9.0-rc6-syzkaller-00234-g7367539ad4b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
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

