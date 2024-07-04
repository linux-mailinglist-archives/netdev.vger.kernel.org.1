Return-Path: <netdev+bounces-109288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAF1927B27
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 18:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592391F22C25
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 16:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8961B29BB;
	Thu,  4 Jul 2024 16:33:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96951B0104
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720110803; cv=none; b=Cppgi4vBxMhjtFW9gxK6vpYTByYvWlgcHSov/hgZMfeGFpi1f2MOm17otr+BAipjXnRnbeDDmkS5/1Nc4CaF0ejG/ZeC2jmD+IQbLgBfgsC/HrysXXZG+a4US/XMRt0mqVTQd5zKlOhS6x3E8l0zgrhQkLZBYtpISNas4oiMNXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720110803; c=relaxed/simple;
	bh=oHgUj9RNVdjnFkamtyzSaZh2U2oXd+4eUW+sFd/bc+Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=APev9vOTJwEKAlvpTIyl0xpyl/0CEwBdG/67exk4TbYSQBTTXlAwvzj4sEHF7Jnq9FgST4Alm6QFAeV2v4QNf2MJvWMcpmCm6NOdvNLDVrRJvnP5Oodr4LJlFv79CsKkSUYrraO7HFcscBKCfZNlwYwJ56qW+rH49xmfyYXacVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f61fca8c40so101013139f.3
        for <netdev@vger.kernel.org>; Thu, 04 Jul 2024 09:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720110801; x=1720715601;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qUKxMIsnh86EKvdFfJf776bnEDX8f4aMiOh9C/pfS/o=;
        b=ORpnTIsIT/ifW5Gu2kY1D91T9Dnz0oAwFFi5xBjVcDv3C/vVaA3v4y+WF0rjpkmZFX
         O1KEfS8LrOImNhaS6vBmR1/u4AHfplcdwHmDdZZ8iUnd2OqxdSrAf/nVPbJ0p5BgUveU
         SVf9y1piEALZ5E6aiJho8M/bJUXII8RhszhnBdAzvhVyeFJW+z3SS1a0O0ObkC6qOce/
         clONtFxzA1scpFGPGy91Ndw15n31NRCY/TVoulDiwb+NzcQN++9YinbQPyYEWwyGHWpc
         fMJGu56TQokEhG9RedMFEdA8mJqvDb5Hb1qmYs4oxmM4jdlaN9uSvbt6k5C3nBtdR6nu
         L8yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWxajoi83o12XB0dCTpbInVj8J24enPRhmR1IFuNuA8DgkzNzY+IwqmKDwJ9PevyVu6A2Zq1rVcgykAoptHhcgleqkCWM1
X-Gm-Message-State: AOJu0Ywj00FO9x2kmvEZ0pDOr3DtKrCbc8x7KjZUgLFgZsE++g9EZ/H8
	kSyMVpbm61ou+U378nRy1CMOjRYafIo8qmJV/DKvgK9dnEJDesx4J1b8xm/qSiP3m5MwH4f5dLr
	utHJA8A6htPvB699YT2gOvLdRFuY+CFI+rNpymjxfY+yPuIL7jmbrOmk=
X-Google-Smtp-Source: AGHT+IHWysKmk8S/npyqeKHy2fCBHQ0tjog4ECmymqcWf0CzoBCgl3niFulWEkUAN0knz+qOG6w83FwEhbZEe9xToq7ABFNUgu/A
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4118:b0:4bf:38f9:eb1b with SMTP id
 8926c6da1cb9f-4bf643fbae3mr110699173.6.1720110801082; Thu, 04 Jul 2024
 09:33:21 -0700 (PDT)
Date: Thu, 04 Jul 2024 09:33:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000045f576061c6e8142@google.com>
Subject: [syzbot] [batman?] INFO: rcu detected stall in batadv_iv_send_outstanding_bat_ogm_packet
 (5)
From: syzbot <syzbot+7beee86dd68b7ee38e4a@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	mareklindner@neomailbox.ch, netdev@vger.kernel.org, pabeni@redhat.com, 
	sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    707081b61156 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1182b083180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=caeac3f3565b057a
dashboard link: https://syzkaller.appspot.com/bug?extid=7beee86dd68b7ee38e4a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6cad68bf7532/disk-707081b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a27e5400778/vmlinux-707081b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67dfc53755d0/Image-707081b6.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7beee86dd68b7ee38e4a@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 27s! [kworker/u4:5:575]
Modules linked in:
irq event stamp: 132863
hardirqs last  enabled at (132862): [<ffff80008ad68de8>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:85 [inline]
hardirqs last  enabled at (132862): [<ffff80008ad68de8>] exit_to_kernel_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:95
hardirqs last disabled at (132863): [<ffff80008ad66a78>] __el1_irq arch/arm64/kernel/entry-common.c:533 [inline]
hardirqs last disabled at (132863): [<ffff80008ad66a78>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:551
softirqs last  enabled at (128034): [<ffff80008002189c>] softirq_handle_end kernel/softirq.c:399 [inline]
softirqs last  enabled at (128034): [<ffff80008002189c>] __do_softirq+0xac8/0xce4 kernel/softirq.c:582
softirqs last disabled at (128036): [<ffff80008aad75f4>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (128036): [<ffff80008aad75f4>] batadv_tt_local_commit_changes+0x24/0x44 net/batman-adv/translation-table.c:3717
CPU: 0 PID: 575 Comm: kworker/u4:5 Not tainted 6.8.0-rc7-syzkaller-g707081b61156 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet
pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : queued_spin_lock_slowpath+0x15c/0xcf8 kernel/locking/qspinlock.c:383
lr : queued_spin_lock_slowpath+0x168/0xcf8 kernel/locking/qspinlock.c:383
sp : ffff800098c77720
x29: ffff800098c777c0 x28: 1fffe0001b8a126a x27: 1ffff0001318eef0
x26: dfff800000000000 x25: 1fffe0001b8a126c x24: ffff800098c77740
x23: ffff800098c77780 x22: ffff70001318eee8 x21: 0000000000000001
x20: 0000000000000001 x19: ffff0000dc509350 x18: ffff0001b4015840
x17: ffff800125414000 x16: ffff8000809fd934 x15: 0000000000000001
x14: 1fffe0001b8a126a x13: 0000000000000000 x12: 0000000000000000
x11: ffff60001b8a126b x10: 1fffe0001b8a126a x9 : 0000000000000000
x8 : 0000000000000001 x7 : ffff80008aad75f4 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff80008ae5db50
x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000000001
Call trace:
 __cmpwait_case_8 arch/arm64/include/asm/cmpxchg.h:229 [inline]
 __cmpwait arch/arm64/include/asm/cmpxchg.h:257 [inline]
 queued_spin_lock_slowpath+0x15c/0xcf8 kernel/locking/qspinlock.c:383
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x320/0x348 kernel/locking/spinlock_debug.c:116
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:127 [inline]
 _raw_spin_lock_bh+0x50/0x60 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 batadv_tt_local_commit_changes+0x24/0x44 net/batman-adv/translation-table.c:3717
 batadv_iv_ogm_schedule_buff net/batman-adv/bat_iv_ogm.c:811 [inline]
 batadv_iv_ogm_schedule+0x1ec/0xdf0 net/batman-adv/bat_iv_ogm.c:868
 batadv_iv_send_outstanding_bat_ogm_packet+0x740/0x900 net/batman-adv/bat_iv_ogm.c:1712
 process_one_work+0x694/0x1204 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x938/0xef4 kernel/workqueue.c:2787
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860


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

