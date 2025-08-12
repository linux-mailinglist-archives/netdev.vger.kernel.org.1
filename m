Return-Path: <netdev+bounces-213049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD1DB22F27
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 19:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA00562BA9
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0576A2FD1CE;
	Tue, 12 Aug 2025 17:33:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D012ED17F
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 17:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020014; cv=none; b=ZiTq5A374QEtgRAH3CF2norsnnAhZ4aOFYlWLt7LklAzUKy/K39V95O2dYHXamXJ+yVHnW7XmTBMx6ZLiq536yQQRsbtYJ3Mi5B4/9wag+kAmSC3fgPz6nl6leOuW3bDfAlYBYPLY3N/Of5oYtZTvIF/JnjyDy1uhgZNLY1hNeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020014; c=relaxed/simple;
	bh=Gy6UC+92D62MVBKjzd0r9Bc/ayaMrxTaUNk00j3yJPo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Y/4JEiZYXlXzePJV88tl3J3QxxQGm6OUcHALqg1773VI8iiGuTg+DZuKq3v9rS1Epd4gHxxWSQqj0xeU0zcTMuZnAymQ7JbCtXIxxfyJeIhfhoeRPCQBMpxrVt6AiLWZhlSuVI35FsbKigBR4xAM2HtaiX8w/orrX3uJjaIG5C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-88170a3df7aso533435739f.0
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 10:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755020012; x=1755624812;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BWK1wMnSiDGrUqxPAozMNdtaG9RgLXJKPhFYkU2ASkw=;
        b=c5uZ3YyLKAhA2OPGPreudszqDgdNtWKLSkDjR5Xpjeep7DMLg+NAUI1w4zeJGl3dCk
         dGMwYmm2CD0d8JlRWwRWfcRpYMkqcM1Hs1mHiCS+U57RUc5UTqWkFgoN6fMZQslY0t3B
         +z1lfOrXsSwIRKJeAdD7VBs6FH8qOn2P6B4uMRX+rXBNQC6ED3Jcalaedr8GiaglhTNe
         TiGkrS6oCT6L2wyAInC25GJvqe3S8JL5f6gJOZ2mJAkaorTsMrU11hLOMOhv+nVkcbsR
         UVbU1PFGEqfWAl0hFlRB7chkkqRfMg0xTP59Y3pmORXxl5QDXX2wFB9Oaj2nEC9o9Sck
         hm8g==
X-Forwarded-Encrypted: i=1; AJvYcCWGnhsYLdaoHO7h+DgIKlsIIrG8PluXwhi7mTqtBOSy2nWO1z+BP/WYkXCa0D1t8eAf06UNf0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcd+Nswgq51u+YslqWu9foRkE90OR8K+wruakOGZYkGFdXJtQz
	15E47LSJ+aT8zwUwoR1NuVcqP0dQS4BJzx0SCk9QFRCTp8Jb6kSYzxe+lHlorV+ghpsAg6g7bkN
	V5EdfccBzvSXXfZlLLio9Tspquv43hHbp3nWRmVyr7y+TtrPS8nw4EdmDjPQ=
X-Google-Smtp-Source: AGHT+IHs0ef4ywJkTTsT7oaqORPlLl7XuQCukeZMS6GTN0vUd6Xp+0R0NCCIxJA28Feqfi6fW4tYsjLV3Fv6I2zKo4zr3exuxeVK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1690:b0:883:e83d:f2f8 with SMTP id
 ca18e2360f4ac-88428c5ac99mr73509539f.13.1755020012385; Tue, 12 Aug 2025
 10:33:32 -0700 (PDT)
Date: Tue, 12 Aug 2025 10:33:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689b7aec.050a0220.7f033.0135.GAE@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in pfkey_send_notify
From: syzbot <syzbot+2d494ba0c96e096f1c11@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c30a13538d9f Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17bb7ea2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ee158fa735566e2
dashboard link: https://syzkaller.appspot.com/bug?extid=2d494ba0c96e096f1c11
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d7d8c2a837fb/disk-c30a1353.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9e67e86fa1fd/vmlinux-c30a1353.xz
kernel image: https://storage.googleapis.com/syzbot-assets/731ca108689d/bzImage-c30a1353.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2d494ba0c96e096f1c11@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in arch_atomic_read arch/x86/include/asm/atomic.h:23 [inline]
BUG: KMSAN: uninit-value in raw_atomic_read include/linux/atomic/atomic-arch-fallback.h:457 [inline]
BUG: KMSAN: uninit-value in atomic_read include/linux/atomic/atomic-instrumented.h:33 [inline]
BUG: KMSAN: uninit-value in pfkey_send_notify+0x291/0xe60 net/key/af_key.c:3079
 arch_atomic_read arch/x86/include/asm/atomic.h:23 [inline]
 raw_atomic_read include/linux/atomic/atomic-arch-fallback.h:457 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:33 [inline]
 pfkey_send_notify+0x291/0xe60 net/key/af_key.c:3079
 km_state_notify net/xfrm/xfrm_state.c:2738 [inline]
 km_state_expired net/xfrm/xfrm_state.c:2752 [inline]
 xfrm_timer_handler+0x464/0x1320 net/xfrm/xfrm_state.c:718
 __run_hrtimer kernel/time/hrtimer.c:1761 [inline]
 __hrtimer_run_queues+0x556/0xd80 kernel/time/hrtimer.c:1825
 hrtimer_run_softirq+0x18e/0x760 kernel/time/hrtimer.c:1842
 handle_softirqs+0x166/0x6e0 kernel/softirq.c:579
 __do_softirq+0x14/0x1b kernel/softirq.c:613
 do_softirq+0x99/0x100 kernel/softirq.c:480
 __local_bh_enable_ip+0xa1/0xb0 kernel/softirq.c:407
 __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:167 [inline]
 _raw_spin_unlock_bh+0x2d/0x40 kernel/locking/spinlock.c:210
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 __fib6_clean_all net/ipv6/ip6_fib.c:2317 [inline]
 fib6_clean_all+0x1fa/0x300 net/ipv6/ip6_fib.c:2326
 rt6_sync_up+0x157/0x180 net/ipv6/route.c:4891
 addrconf_notify+0x1cd7/0x1d10 net/ipv6/addrconf.c:3728
 notifier_call_chain kernel/notifier.c:85 [inline]
 raw_notifier_call_chain+0xdd/0x410 kernel/notifier.c:453
 call_netdevice_notifiers_info+0x1ac/0x2b0 net/core/dev.c:2229
 netif_state_change+0x3af/0x410 net/core/dev.c:1583
 do_setlink+0x1b33/0x7e50 net/core/rtnetlink.c:3390
 rtnl_group_changelink net/core/rtnetlink.c:3775 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3929 [inline]
 rtnl_newlink+0x2b96/0x3a90 net/core/rtnetlink.c:4057
 rtnetlink_rcv_msg+0x106f/0x14b0 net/core/rtnetlink.c:6946
 netlink_rcv_skb+0x54d/0x680 net/netlink/af_netlink.c:2552
 rtnetlink_rcv+0x35/0x40 net/core/rtnetlink.c:6973
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0xf04/0x12b0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x10b3/0x1250 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x330/0x3d0 net/socket.c:729
 ____sys_sendmsg+0x7e0/0xd80 net/socket.c:2614
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2703
 x64_sys_call+0x1dfd/0x3e20 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4186 [inline]
 slab_alloc_node mm/slub.c:4229 [inline]
 __do_kmalloc_node mm/slub.c:4364 [inline]
 __kvmalloc_node_noprof+0xa36/0x1530 mm/slub.c:5052
 kvmalloc_array_node_noprof include/linux/slab.h:1065 [inline]
 io_alloc_cache_init+0x53/0x150 io_uring/alloc_cache.c:25
 io_ring_ctx_alloc+0x617/0x14f0 io_uring/io_uring.c:337
 io_uring_create+0x32f/0x1400 io_uring/io_uring.c:3743
 io_uring_setup io_uring/io_uring.c:3890 [inline]
 __do_sys_io_uring_setup io_uring/io_uring.c:3924 [inline]
 __se_sys_io_uring_setup+0x572/0x590 io_uring/io_uring.c:3915
 __x64_sys_io_uring_setup+0x78/0xb0 io_uring/io_uring.c:3915
 x64_sys_call+0x35b4/0x3e20 arch/x86/include/generated/asm/syscalls_64.h:426
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 14064 Comm: syz.4.2614 Tainted: G        W           6.16.0-syzkaller-12250-gc30a13538d9f #0 PREEMPT(none) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
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

