Return-Path: <netdev+bounces-230946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A604BF233C
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 17:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9991A34A1B8
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 15:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964DE274B4D;
	Mon, 20 Oct 2025 15:48:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A371C8606
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975312; cv=none; b=Qkl6u5ZDsbH8ewHGFw279RCcjDZY/TvHBg4ho7VGNns/e+/pHivKl4t73NC73L2xy9EyVW8fpWx2ZVSj1qefS7BN5F6eEvx4Zti/lW3TUUpsVKMsBveoXrkDHfP0yQu+8Yj7f6rySl1dpgN74OLsArF2icFOQuS1Qhp4AOsztX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975312; c=relaxed/simple;
	bh=fbvmBFj3s1pjbMOYuKSpXRyWaXLLisJ97RIjzYQnnWw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KgLCIYPvZq+xkaEa5l37vtzSB40NpLmm0x+H6wDyKDt70y3DdX3UePU9kc/l/szCy/n5XOuPde8uEMJn7HWyTaEqFyoKoSCrJ1vUWaLDzkuKVRH70/gJ9e/q1HNkYeDlyGJlAJ9zbfWRyBF27txVbu29BAyJnOL70uhavebku6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-93e7d299abfso327389839f.3
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 08:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760975310; x=1761580110;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XZmsIKT9OKKXitH38og/5N6gCJDMeix2o0WQRyJEKLE=;
        b=ap+4vEGQ0FEJnpoIulVCbpgEIMdgB7xTopJOtSBcJfWp2PjsM5nw+6F2uTln0k0s+A
         rMR5aF8fn/KPiXQAqJxneDck4qiql2jRBjGYrlo1B/0cNChf0oZHBS+VgeJoLNx/RNeh
         xpylHtBP8jsX9Z+YZLzqWCc3SEv28S1xkwTgKUarHlbWjtXb5G25OabSlfPhwItcZK8Q
         TvGi79y8ogvzMD+X7/PBZttKejBLQhvJiyDOu1xYaKX5MpX8cCnoieX5jDb4nUddu8e1
         g4Cbk3BbSoAtProjakihCI5bQBJHa/y7ldCm6lJqUfjTHC4wfLjTQ7dgET56C8G99lKl
         A+ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHOne3bmdozhbHRsAGfs0meUUc1uhLYcfLqbYnDcTdM2jjHVv2ZG8AzxjSGgeRjmFCclHOmNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7fvlDqhOt4fOrq09e8DDFIoSpXSYIUuzIlM2lAj4iI9K8DkNc
	n80kEBFAEfXfwSVc2sus5jXJx+7/0BWfsCR8FSYVLIBRe6Sh03eFJgbbPcxwsJb6NtOzKJGVlac
	U7UiEl/4O7s5Ga7Zr77iPmyi1f3pk3sb7VzgGu2FON8nvLDNgJ/Jc0TC1+Yw=
X-Google-Smtp-Source: AGHT+IEigfyyBPRR8b0Tg9arVSJPFJMdxJNP9ibzm6Hm13d0UNALPPrp9Zb3JRzZo4xaprEB7kFl0Hl7Re/7AK1aQjq4qpZwzo9+
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:601c:b0:940:d6a0:635c with SMTP id
 ca18e2360f4ac-940d6a06fb7mr704565739f.14.1760975309969; Mon, 20 Oct 2025
 08:48:29 -0700 (PDT)
Date: Mon, 20 Oct 2025 08:48:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f659cd.050a0220.91a22.044c.GAE@google.com>
Subject: [syzbot] [sctp?] KMSAN: uninit-value in sctp_inq_pop (3)
From: syzbot <syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	lucien.xin@gmail.com, marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d9043c79ba68 Merge tag 'sched_urgent_for_v6.18_rc2' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11168de2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbd3e7f3c2e28265
dashboard link: https://syzkaller.appspot.com/bug?extid=d101e12bccd4095460e7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14098d42580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118a9734580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/57a87b0986c0/disk-d9043c79.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/019c87e1df0a/vmlinux-d9043c79.xz
kernel image: https://storage.googleapis.com/syzbot-assets/54f8a8b0734b/bzImage-d9043c79.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in sctp_inq_pop+0x14dc/0x19e0 net/sctp/inqueue.c:211
 sctp_inq_pop+0x14dc/0x19e0 net/sctp/inqueue.c:211
 sctp_assoc_bh_rcv+0x1a0/0xbc0 net/sctp/associola.c:980
 sctp_inq_push+0x2a6/0x350 net/sctp/inqueue.c:88
 sctp_backlog_rcv+0x3c7/0xda0 net/sctp/input.c:331
 sk_backlog_rcv+0x142/0x420 include/net/sock.h:1158
 __release_sock+0x1ef/0x380 net/core/sock.c:3180
 release_sock+0x6b/0x270 net/core/sock.c:3735
 sctp_sendmsg+0x3a2b/0x49f0 net/sctp/socket.c:2036
 inet_sendmsg+0x26c/0x2a0 net/ipv4/af_inet.c:853
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x278/0x3d0 net/socket.c:742
 sock_sendmsg+0x170/0x280 net/socket.c:765
 splice_to_socket+0x10e6/0x1a60 fs/splice.c:886
 do_splice_from fs/splice.c:938 [inline]
 do_splice+0x1fd2/0x30d0 fs/splice.c:1351
 __do_splice fs/splice.c:1433 [inline]
 __do_sys_splice fs/splice.c:1636 [inline]
 __se_sys_splice+0x549/0x8c0 fs/splice.c:1618
 __x64_sys_splice+0x114/0x1a0 fs/splice.c:1618
 x64_sys_call+0x3140/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:276
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 sctp_inq_pop+0x144a/0x19e0 net/sctp/inqueue.c:207
 sctp_assoc_bh_rcv+0x1a0/0xbc0 net/sctp/associola.c:980
 sctp_inq_push+0x2a6/0x350 net/sctp/inqueue.c:88
 sctp_backlog_rcv+0x3c7/0xda0 net/sctp/input.c:331
 sk_backlog_rcv+0x142/0x420 include/net/sock.h:1158
 __release_sock+0x1ef/0x380 net/core/sock.c:3180
 release_sock+0x6b/0x270 net/core/sock.c:3735
 sctp_sendmsg+0x3a2b/0x49f0 net/sctp/socket.c:2036
 inet_sendmsg+0x26c/0x2a0 net/ipv4/af_inet.c:853
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x278/0x3d0 net/socket.c:742
 sock_sendmsg+0x170/0x280 net/socket.c:765
 splice_to_socket+0x10e6/0x1a60 fs/splice.c:886
 do_splice_from fs/splice.c:938 [inline]
 do_splice+0x1fd2/0x30d0 fs/splice.c:1351
 __do_splice fs/splice.c:1433 [inline]
 __do_sys_splice fs/splice.c:1636 [inline]
 __se_sys_splice+0x549/0x8c0 fs/splice.c:1618
 __x64_sys_splice+0x114/0x1a0 fs/splice.c:1618
 x64_sys_call+0x3140/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:276
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4969 [inline]
 slab_alloc_node mm/slub.c:5272 [inline]
 kmem_cache_alloc_node_noprof+0x989/0x16b0 mm/slub.c:5324
 kmalloc_reserve+0x13c/0x4b0 net/core/skbuff.c:579
 __alloc_skb+0x347/0x7d0 net/core/skbuff.c:670
 alloc_skb include/linux/skbuff.h:1383 [inline]
 sctp_packet_transmit+0x44b/0x46d0 net/sctp/output.c:598
 sctp_outq_flush_transports net/sctp/outqueue.c:1173 [inline]
 sctp_outq_flush+0x1c7d/0x67c0 net/sctp/outqueue.c:1221
 sctp_outq_uncork+0x9e/0xc0 net/sctp/outqueue.c:764
 sctp_cmd_interpreter net/sctp/sm_sideeffect.c:-1 [inline]
 sctp_side_effects net/sctp/sm_sideeffect.c:1204 [inline]
 sctp_do_sm+0x8c8e/0x9720 net/sctp/sm_sideeffect.c:1175
 sctp_primitive_SEND+0xd7/0x110 net/sctp/primitive.c:163
 sctp_sendmsg_to_asoc+0x1db8/0x2250 net/sctp/socket.c:1873
 sctp_sendmsg+0x3910/0x49f0 net/sctp/socket.c:2031
 inet_sendmsg+0x26c/0x2a0 net/ipv4/af_inet.c:853
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x278/0x3d0 net/socket.c:742
 sock_sendmsg+0x170/0x280 net/socket.c:765
 splice_to_socket+0x10e6/0x1a60 fs/splice.c:886
 do_splice_from fs/splice.c:938 [inline]
 do_splice+0x1fd2/0x30d0 fs/splice.c:1351
 __do_splice fs/splice.c:1433 [inline]
 __do_sys_splice fs/splice.c:1636 [inline]
 __se_sys_splice+0x549/0x8c0 fs/splice.c:1618
 __x64_sys_splice+0x114/0x1a0 fs/splice.c:1618
 x64_sys_call+0x3140/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:276
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 6071 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
=====================================================


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

