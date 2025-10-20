Return-Path: <netdev+bounces-230952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5D7BF250E
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 18:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A6DA734BC47
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 16:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741B12857C1;
	Mon, 20 Oct 2025 16:09:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7318E25776
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976572; cv=none; b=pWVXfoydoNQi0rZSMdO+0B10WVQmcjSv3HTN8A/xhpyGsUrWK3HuI0z84FD8m9F7NaIcU+iHM/EwPLA/MiNTPmKxA+p+DOCwGyS8bBUtnr5uyZyHfIX18056ahiYM4XTQM2dm8WNYERvAOqW+KBb75MhsuUSrifqwomvPPSP7Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976572; c=relaxed/simple;
	bh=cKX7axGAua4wBOQ7vViFnnyY08CuouvVP8szBHpbHH4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lLDcWdNs5Hb8vG506kSSsfQQGT/xA+XBARrCd9/3ypNGRHdCmfmRKk0jMSc7A/9bCIxP+jySv+ENv6h7IuaWOD4Q93JjxMRTNqAYXIfrwO5MVh3yaOWzWRcYXAx24kPwW1Q87sjCydEKvEoCZeP3nZrCNo2aaNr70fOpXccn+wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-430d789ee5aso20156325ab.2
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 09:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760976569; x=1761581369;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pbfF70cDDtAHBRC9nSIxTU9q86P/OB6WZ1gA9jNUyrg=;
        b=a4PIzx+wVFtGCqFExx1/RKup5EMNmjWnoFTjf5kihNepNjQvBtPS99rZ26n+DTuIOP
         /QQY6CXNZ15HDLY6HMl6wimceWkxbNtMQ29n60em7+sdfJ1hEo7QbNtCV6YJ8+xYzZIC
         M4JMLNef3+nee0vE7YgjiTJiL+GV6/levBG+OVybbU2jLvwVi8JxQgzOa6N6k6pm+l5t
         qWhKmJUpKBiO/nkkvRUtzeVuHGsNVC6krahjew9DQy67SQK/3l0zsZE2Mf9BaKKrErpX
         znnMdFkyiKCD49CFQDxEAqGI9rw8JpAFsT5e1Rw0u7zI+1Zu4RqvVq8GwMtzJB43M7Ab
         e9dA==
X-Forwarded-Encrypted: i=1; AJvYcCV11tUKhEnsS65CA5EAvxJNfCgPS0t9kIRJhyyuZdayNL3wzLatHAvcvs+rP0SO5G8gadRV13E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5NM86JLsLvN3642xAWJUMF9+j3AB772o92zcX/SoJRAfPHwE/
	nNqFcmNugLobJWw8C7/Ayr7NcXDKegpisDwZiLaXtrW7soDvi5AavO0kKzMGDC7Qv9jxCuhDDbG
	618GHZGcbXy79fpO7vrHDvbKc34WCEAYdfW8tZcE2NSBNHPfJN5VnlU8fQ/4=
X-Google-Smtp-Source: AGHT+IHYQTSzzfTWBjWfSVU0sprZlwQ9IxoWFFjnmAvndOeKFlOeFDGJlIqFloDQ99h7zzClGfhPq4Srx74v+eVNKlbeVAHa/O5P
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a46:b0:42b:2f98:3fc2 with SMTP id
 e9e14a558f8ab-430c52b4580mr193897435ab.17.1760976569555; Mon, 20 Oct 2025
 09:09:29 -0700 (PDT)
Date: Mon, 20 Oct 2025 09:09:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f65eb9.a70a0220.205af.0034.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in gro_cells_receive
From: syzbot <syzbot+f9651b9a8212e1c8906f@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cf1ea8854e4f Merge tag 'mmc-v6.18-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12456492580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af9170887d81dea1
dashboard link: https://syzkaller.appspot.com/bug?extid=f9651b9a8212e1c8906f
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a6a5b37662b9/disk-cf1ea885.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4b4d732ae480/vmlinux-cf1ea885.xz
kernel image: https://storage.googleapis.com/syzbot-assets/acd7feec5537/bzImage-cf1ea885.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f9651b9a8212e1c8906f@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
syzkaller #0 Not tainted
--------------------------------------------
syz.2.329/7421 is trying to acquire lock:
ffffe8ffffd48888 ((&cell->bh_lock)){+...}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
ffffe8ffffd48888 ((&cell->bh_lock)){+...}-{3:3}, at: gro_cells_receive+0x404/0x790 net/core/gro_cells.c:30

but task is already holding lock:
ffffe8ffffd48888 ((&cell->bh_lock)){+...}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
ffffe8ffffd48888 ((&cell->bh_lock)){+...}-{3:3}, at: gro_cells_receive+0x404/0x790 net/core/gro_cells.c:30

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock((&cell->bh_lock));
  lock((&cell->bh_lock));

 *** DEADLOCK ***

 May be due to missing lock nesting notation

8 locks held by syz.2.329/7421:
 #0: ffffffff8d7aa4c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8d7aa4c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #0: ffffffff8d7aa4c0 (rcu_read_lock){....}-{1:3}, at: bpf_test_timer_enter+0x1e/0x2b0 net/bpf/test_run.c:40
 #1: ffffffff8d64ab00 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0xa1/0x540 kernel/softirq.c:163
 #2: ffffffff8d7aa4c0 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0xa1/0x540 kernel/softirq.c:163
 #3: ffffffff8d7aa4c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #3: ffffffff8d7aa4c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #3: ffffffff8d7aa4c0 (rcu_read_lock){....}-{1:3}, at: netif_receive_skb_list_internal+0x4fd/0xcb0 net/core/dev.c:6297
 #4: ffffffff8d7aa4c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #4: ffffffff8d7aa4c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #4: ffffffff8d7aa4c0 (rcu_read_lock){....}-{1:3}, at: ip6_input+0x23/0x270 net/ipv6/ip6_input.c:499
 #5: ffffe8ffffd48888 ((&cell->bh_lock)){+...}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
 #5: ffffe8ffffd48888 ((&cell->bh_lock)){+...}-{3:3}, at: gro_cells_receive+0x404/0x790 net/core/gro_cells.c:30
 #6: ffffffff8d7aa4c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #6: ffffffff8d7aa4c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #6: ffffffff8d7aa4c0 (rcu_read_lock){....}-{1:3}, at: ip6_input+0x23/0x270 net/ipv6/ip6_input.c:499
 #7: ffffffff8d7aa4c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #7: ffffffff8d7aa4c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #7: ffffffff8d7aa4c0 (rcu_read_lock){....}-{1:3}, at: gro_cells_receive+0x50/0x790 net/core/gro_cells.c:21

stack backtrace:
CPU: 1 UID: 0 PID: 7421 Comm: syz.2.329 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_deadlock_bug+0x28b/0x2a0 kernel/locking/lockdep.c:3041
 check_deadlock kernel/locking/lockdep.c:3093 [inline]
 validate_chain+0x1a3f/0x2140 kernel/locking/lockdep.c:3895
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 rt_spin_lock+0x88/0x3e0 kernel/locking/spinlock_rt.c:56
 spin_lock include/linux/spinlock_rt.h:44 [inline]
 gro_cells_receive+0x404/0x790 net/core/gro_cells.c:30
 ip6_tnl_rcv+0x7c/0xa0 net/ipv6/ip6_tunnel.c:903
 ip6gre_rcv net/ipv6/ip6_gre.c:-1 [inline]
 gre_rcv+0xbfa/0x11e0 net/ipv6/ip6_gre.c:588
 ip6_protocol_deliver_rcu+0xe0b/0x15c0 net/ipv6/ip6_input.c:438
 ip6_input_finish+0x191/0x370 net/ipv6/ip6_input.c:489
 NF_HOOK+0x30c/0x3a0 include/linux/netfilter.h:318
 ip6_input+0x16a/0x270 net/ipv6/ip6_input.c:500
 dst_input include/net/dst.h:474 [inline]
 ip6_sublist_rcv_finish+0x1c8/0x2a0 net/ipv6/ip6_input.c:88
 ip6_list_rcv_finish net/ipv6/ip6_input.c:145 [inline]
 ip6_sublist_rcv+0xb11/0xdd0 net/ipv6/ip6_input.c:321
 ipv6_list_rcv+0x3e5/0x430 net/ipv6/ip6_input.c:355
 __netif_receive_skb_list_ptype net/core/dev.c:6122 [inline]
 __netif_receive_skb_list_core+0x5f4/0x800 net/core/dev.c:6169
 __netif_receive_skb_list net/core/dev.c:6221 [inline]
 netif_receive_skb_list_internal+0x96f/0xcb0 net/core/dev.c:6312
 netif_receive_skb_list+0x54/0x450 net/core/dev.c:6364
 xdp_recv_frames net/bpf/test_run.c:280 [inline]
 xdp_test_run_batch net/bpf/test_run.c:361 [inline]
 bpf_test_run_xdp_live+0x1790/0x1b20 net/bpf/test_run.c:390
 bpf_prog_test_run_xdp+0x75b/0x10e0 net/bpf/test_run.c:1331
 bpf_prog_test_run+0x2cd/0x340 kernel/bpf/syscall.c:4673
 __sys_bpf+0x562/0x860 kernel/bpf/syscall.c:6152
 __do_sys_bpf kernel/bpf/syscall.c:6244 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6242 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6242
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3bce98efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3bccbee038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f3bcebe5fa0 RCX: 00007f3bce98efc9
RDX: 0000000000000048 RSI: 0000200000000600 RDI: 000000000000000a
RBP: 00007f3bcea11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3bcebe6038 R14: 00007f3bcebe5fa0 R15: 00007fffd6bba178
 </TASK>


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

