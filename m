Return-Path: <netdev+bounces-289586-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLeDBMCxDGrdkwUAu9opvQ
	(envelope-from <netdev+bounces-289586-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:53:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D617583E86
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A262930074FB
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4CE35E1AB;
	Tue, 19 May 2026 18:53:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605A933D6EA
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 18:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779216820; cv=none; b=ExTXEhDrD9i5N8fcSMDGFEZowtsIiTGjg7Vn0RJZK59dQUTbxx+liy0s0E8HFQlkXHp4Brv9Dn5NN1yEBxHJH3fZ2Dlp+ms2EPmBfziA8XJUhhoBJE9NvPJ/DrcLg3tAQwRaJu+Yu0oHH5amED+Ow6jDU9Z8llNrD9g6mogBsJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779216820; c=relaxed/simple;
	bh=d1TFxgswi4mJWm/z3zIfG6YsxfWxlN3KnG0dAtdeERs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CoLxQqPzqKXyFlk/BsCbyQ3HzLn8rBO56VWXwNFVhOLt9UCKBoS9eEaS5y5H4VWWHTVCXpGQy+jYi+BhiWx87pTb/seAkj9mrS5b0R19hTRDueq25FPM/SPVBsgz1sPBWBp486fPMg7zmY8cbhyj3zn1GCfhvNFPP8mOrHIr0cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-69b91d4f9b1so9578688eaf.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779216817; x=1779821617;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WiEvteoaqOMoFc3FA5qwqDWyPrKiPeyEd1Uk75GF9D4=;
        b=jukFXODM5I83sG+UmmO/j/BMtpiqce7auUXybI9kK2bq5gvzMxeyWN9CBC7B2d/fou
         KmdnRikJCk23K4B7MQWm9Vzaql+n2MTLeG0dXEUSh+L8DI3XqXiMEQy2w3Dx63I3Xpcl
         jzuMSmLoBI5BFMH+IBrvhKrEHdKkULLJx/YdZDZi7D2tANzt24oqS3KPsdhP/FkcROET
         yEDLKF89xcXn9wC0ZYDpxdiqZRw+GLcVB4UQiPx6TKp4qh3OnEt4s2jdp4301DGqxtrq
         btXxxa7aYCFTflrWtCjLfLdfs41AfJbGWpdUuXZ8QnUOk2yCN95TY/3pf/pHZzYccBT1
         j1lg==
X-Forwarded-Encrypted: i=1; AFNElJ9sFNp0QtmbUYSXA23Kw0FHnVVX7iHDy77SHi/CphasO/8dku6MRyLUc0Yk1kgYNsNH492zaOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcvPFMUWtBqzAglD60zOAbO5OaNvLpSU/fHjbadpXulCbE5q92
	vryIQeSIGNsnxaOVNS2urQgc+ZabGnEhrbDQ9HrQHdiXTUEpmQLcfNIEELbzyi2lAFiLN0joKIt
	F2o2x+MyOck8o8JR9JRs7lKSDmLMOPJrcozX0pRVptLC+fnA5F80RHejopz0=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1f06:b0:694:8f3a:3f3d with SMTP id
 006d021491bc7-69c94375246mr13243096eaf.35.1779216817247; Tue, 19 May 2026
 11:53:37 -0700 (PDT)
Date: Tue, 19 May 2026 11:53:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a0cb1b1.170a0220.1f6c2d.0001.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in __sk_receive_skb
From: syzbot <syzbot+9f4a135646b66c509935@syzkaller.appspotmail.com>
To: courmisch@gmail.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=354b135d724a721f];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,vger.kernel.org,redhat.com,googlegroups.com];
	TAGGED_FROM(0.00)[bounces-289586-lists,netdev=lfdr.de,9f4a135646b66c509935];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,storage.googleapis.com:url,goo.gl:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,appspotmail.com:email];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 0D617583E86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    97e797263a5e Add linux-next specific files for 20260420
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17c62c36580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=354b135d724a721f
dashboard link: https://syzkaller.appspot.com/bug?extid=9f4a135646b66c509935
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f622d2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f88e6a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bfe08255b02b/disk-97e79726.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/70874e341331/vmlinux-97e79726.xz
kernel image: https://storage.googleapis.com/syzbot-assets/68352f7fca94/bzImage-97e79726.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9f4a135646b66c509935@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.17/6130 is trying to acquire lock:
ffff88803976da20 (slock-AF_PHONET/1){+.+.}-{3:3}, at: __sk_receive_skb+0x1bf/0x9e0 net/core/sock.c:563

but task is already holding lock:
ffff88803976e2e0 (slock-AF_PHONET){+...}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
ffff88803976e2e0 (slock-AF_PHONET){+...}-{3:3}, at: __sk_receive_skb+0x1f1/0x9e0 net/core/sock.c:565

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (slock-AF_PHONET){+...}-{3:3}:
       rt_spin_lock+0x83/0x400 kernel/locking/spinlock_rt.c:56
       spin_lock include/linux/spinlock_rt.h:45 [inline]
       __sk_receive_skb+0x1f1/0x9e0 net/core/sock.c:565
       sk_receive_skb include/net/sock.h:2022 [inline]
       phonet_rcv+0x781/0xc40 net/phonet/af_phonet.c:-1
       __netif_receive_skb_one_core net/core/dev.c:6210 [inline]
       __netif_receive_skb net/core/dev.c:6323 [inline]
       process_backlog+0x5e1/0xc60 net/core/dev.c:6674
       __napi_poll+0xab/0x550 net/core/dev.c:7738
       napi_poll net/core/dev.c:7801 [inline]
       net_rx_action+0x696/0xe00 net/core/dev.c:7958
       handle_softirqs+0x1de/0x6d0 kernel/softirq.c:626
       __do_softirq kernel/softirq.c:660 [inline]
       __local_bh_enable_ip+0x170/0x2b0 kernel/softirq.c:302
       local_bh_enable include/linux/bottom_half.h:33 [inline]
       netif_rx+0xb9/0xf0 net/core/dev.c:5776
       pn_send+0x62a/0x8e0 net/phonet/af_phonet.c:188
       pn_skb_send+0x218/0x530 net/phonet/af_phonet.c:275
       pep_indicate net/phonet/pep.c:123 [inline]
       pipe_snd_status+0x1f1/0x320 net/phonet/pep.c:221
       pipe_grant_credits net/phonet/pep.c:244 [inline]
       pipe_do_rcv+0xf15/0x16a0 net/phonet/pep.c:433
       sk_backlog_rcv include/net/sock.h:1190 [inline]
       __sk_receive_skb+0x962/0x9e0 net/core/sock.c:572
       sk_receive_skb include/net/sock.h:2022 [inline]
       pep_do_rcv+0x685/0xaa0 net/phonet/pep.c:675
       sk_backlog_rcv include/net/sock.h:1190 [inline]
       __release_sock+0x2a9/0x3d0 net/core/sock.c:3216
       release_sock+0x1be/0x290 net/core/sock.c:3815
       pep_sock_accept+0xd47/0x11e0 net/phonet/pep.c:879
       pn_socket_accept+0xc1/0x310 net/phonet/socket.c:303
       do_accept+0x6ca/0x930 net/socket.c:2062
       __sys_accept4_file net/socket.c:2096 [inline]
       __sys_accept4+0x139/0x230 net/socket.c:2118
       __do_sys_accept4 net/socket.c:2125 [inline]
       __se_sys_accept4 net/socket.c:2122 [inline]
       __x64_sys_accept4+0x9a/0xb0 net/socket.c:2122
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (slock-AF_PHONET/1){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3167 [inline]
       check_prevs_add kernel/locking/lockdep.c:3286 [inline]
       validate_chain kernel/locking/lockdep.c:3910 [inline]
       __lock_acquire+0x15a5/0x2cf0 kernel/locking/lockdep.c:5239
       lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5870
       rt_spin_lock_nested+0x81/0x3f0 kernel/locking/spinlock_rt.c:64
       __sk_receive_skb+0x1bf/0x9e0 net/core/sock.c:563
       sk_receive_skb include/net/sock.h:2022 [inline]
       pep_do_rcv+0x685/0xaa0 net/phonet/pep.c:675
       sk_backlog_rcv include/net/sock.h:1190 [inline]
       __sk_receive_skb+0x962/0x9e0 net/core/sock.c:572
       sk_receive_skb include/net/sock.h:2022 [inline]
       phonet_rcv+0x781/0xc40 net/phonet/af_phonet.c:-1
       __netif_receive_skb_one_core net/core/dev.c:6210 [inline]
       __netif_receive_skb net/core/dev.c:6323 [inline]
       process_backlog+0x5e1/0xc60 net/core/dev.c:6674
       __napi_poll+0xab/0x550 net/core/dev.c:7738
       napi_poll net/core/dev.c:7801 [inline]
       net_rx_action+0x696/0xe00 net/core/dev.c:7958
       handle_softirqs+0x1de/0x6d0 kernel/softirq.c:626
       __do_softirq kernel/softirq.c:660 [inline]
       __local_bh_enable_ip+0x170/0x2b0 kernel/softirq.c:302
       local_bh_enable include/linux/bottom_half.h:33 [inline]
       netif_rx+0xb9/0xf0 net/core/dev.c:5776
       pn_send+0x62a/0x8e0 net/phonet/af_phonet.c:188
       pn_skb_send+0x218/0x530 net/phonet/af_phonet.c:275
       pipe_skb_send+0x2f7/0x540 net/phonet/pep.c:1130
       pep_sendmsg+0x9ca/0xb00 net/phonet/pep.c:1206
       pn_socket_sendmsg+0x1e5/0x250 net/phonet/socket.c:424
       sock_sendmsg_nosec+0x112/0x150 net/socket.c:797
       __sock_sendmsg net/socket.c:812 [inline]
       sock_write_iter+0x308/0x410 net/socket.c:1269
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x629/0xba0 fs/read_write.c:688
       ksys_write+0x156/0x270 fs/read_write.c:740
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(slock-AF_PHONET);
                               lock(slock-AF_PHONET/1);
                               lock(slock-AF_PHONET);
  lock(slock-AF_PHONET/1);

 *** DEADLOCK ***

6 locks held by syz.0.17/6130:
 #0: ffff88803aded218 (sk_lock-AF_PHONET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1713 [inline]
 #0: ffff88803aded218 (sk_lock-AF_PHONET){+.+.}-{0:0}, at: pep_sendmsg+0x7b6/0xb00 net/phonet/pep.c:1199
 #1: ffffffff8e3c8140 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0x3c/0x420 kernel/softirq.c:163
 #2: ffffffff8e3c8140 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #2: ffffffff8e3c8140 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #2: ffffffff8e3c8140 (rcu_read_lock){....}-{1:3}, at: process_backlog+0x271/0xc60 net/core/dev.c:6673
 #3: ffff88803976e2e0 (slock-AF_PHONET){+...}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
 #3: ffff88803976e2e0 (slock-AF_PHONET){+...}-{3:3}, at: __sk_receive_skb+0x1f1/0x9e0 net/core/sock.c:565
 #4: ffffffff8e3c8140 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #4: ffffffff8e3c8140 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #4: ffffffff8e3c8140 (rcu_read_lock){....}-{1:3}, at: __rt_spin_lock kernel/locking/spinlock_rt.c:50 [inline]
 #4: ffffffff8e3c8140 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0x1e0/0x400 kernel/locking/spinlock_rt.c:57
 #5: ffff88803976e398 (sk_lock-AF_PHONET){+.+.}-{0:0}, at: sk_receive_skb include/net/sock.h:2022 [inline]
 #5: ffff88803976e398 (sk_lock-AF_PHONET){+.+.}-{0:0}, at: phonet_rcv+0x781/0xc40 net/phonet/af_phonet.c:-1

stack backtrace:
CPU: 0 UID: 0 PID: 6130 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e1/0x300 kernel/locking/lockdep.c:2045
 check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3167 [inline]
 check_prevs_add kernel/locking/lockdep.c:3286 [inline]
 validate_chain kernel/locking/lockdep.c:3910 [inline]
 __lock_acquire+0x15a5/0x2cf0 kernel/locking/lockdep.c:5239
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5870
 rt_spin_lock_nested+0x81/0x3f0 kernel/locking/spinlock_rt.c:64
 __sk_receive_skb+0x1bf/0x9e0 net/core/sock.c:563
 sk_receive_skb include/net/sock.h:2022 [inline]
 pep_do_rcv+0x685/0xaa0 net/phonet/pep.c:675
 sk_backlog_rcv include/net/sock.h:1190 [inline]
 __sk_receive_skb+0x962/0x9e0 net/core/sock.c:572
 sk_receive_skb include/net/sock.h:2022 [inline]
 phonet_rcv+0x781/0xc40 net/phonet/af_phonet.c:-1
 __netif_receive_skb_one_core net/core/dev.c:6210 [inline]
 __netif_receive_skb net/core/dev.c:6323 [inline]
 process_backlog+0x5e1/0xc60 net/core/dev.c:6674
 __napi_poll+0xab/0x550 net/core/dev.c:7738
 napi_poll net/core/dev.c:7801 [inline]
 net_rx_action+0x696/0xe00 net/core/dev.c:7958
 handle_softirqs+0x1de/0x6d0 kernel/softirq.c:626
 __do_softirq kernel/softirq.c:660 [inline]
 __local_bh_enable_ip+0x170/0x2b0 kernel/softirq.c:302
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 netif_rx+0xb9/0xf0 net/core/dev.c:5776
 pn_send+0x62a/0x8e0 net/phonet/af_phonet.c:188
 pn_skb_send+0x218/0x530 net/phonet/af_phonet.c:275
 pipe_skb_send+0x2f7/0x540 net/phonet/pep.c:1130
 pep_sendmsg+0x9ca/0xb00 net/phonet/pep.c:1206
 pn_socket_sendmsg+0x1e5/0x250 net/phonet/socket.c:424
 sock_sendmsg_nosec+0x112/0x150 net/socket.c:797
 __sock_sendmsg net/socket.c:812 [inline]
 sock_write_iter+0x308/0x410 net/socket.c:1269
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x629/0xba0 fs/read_write.c:688
 ksys_write+0x156/0x270 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd74410c819
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd743745028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fd744386090 RCX: 00007fd74410c819
RDX: 00000000000003db RSI: 0000200000000480 RDI: 0000000000000006
RBP: 00007fd7441a2c91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd744386128 R14: 00007fd744386090 R15: 00007fff7efc5418
 </TASK>


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

