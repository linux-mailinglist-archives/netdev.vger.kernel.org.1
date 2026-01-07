Return-Path: <netdev+bounces-247819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5AECFF30C
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 18:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39C1E32C8744
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 16:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F423904C1;
	Wed,  7 Jan 2026 16:24:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95063A1A24
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767803074; cv=none; b=Zjq/gvPq5fd2cKwd/wDiR8CJukT+2FV405gaP/x+84EVpaTej4TgoXwbEV4WTCf2bg4XnJ6nvpTvyzgIyIhKNgHb6Y/znCAGyDXEjCxNFj/tw9lFLmZmOqQlf6VxSny4YrpUZnBlvHngsgyFOZg2yH7jwtGKK32KksCRRWk+cLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767803074; c=relaxed/simple;
	bh=NEUMDtuzOaM0QW+pEErdVZUjXHEKX2eRDIbB6TPcJes=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ov0ULoq8tOmHKEtI6uDNcAGTYiudFvEHNDobTSfu933LjQvl2/FIQnhvYWd3LZTKYtlY/8RR0UBF4OIUVrWUx63OpbG3f6MXKngadZSHuvLGxnz3KjPuVtwXVVblXuY17jQ2NzaVt3z6JgwHeZIas3a3saRl3CTJlDSkJ9bY2yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-3f9a5b4ae58so4075916fac.2
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 08:24:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767803059; x=1768407859;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WDW1sZB7rsDwU9IQxdhOJ2RMK2HxW4Gsg47a08SWtKw=;
        b=rQX8yCKL36344mZmG4GewyVB2LTg9aKHaK+Zz0PEp/heJo2L6HR3Jgn3OWDLWIxA/3
         gP1nZ8CQv4mEOFawKpkadbUhp1IcyQXWnrjTOrWjPX4XbB1jZWYaPOM06DRqCmzcupe0
         nOdvTeqOIXAbr2rspyhX4haREOZk2keC69VxcCXpRpmYh9euxdgozpqtLqLbiaxITYG7
         Rw7bvE9TEaLpbDHo+sJ4pTRNifj7N1wWgZqiaxHoB6pT5Su+q8Kt1Q4fuv7ZfzoGBkOe
         NL69RvRG7mEZSsbvEUqIQdVTCkQ0/TkwhhCyCNjVEGIh3G/6BaqGRBaIP/6krsrrZhP6
         40JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN0jPpc3KY3Kypvo7qzjqRssn53gifUZFiQP7/YFcYxzzhi9QibQfu71mwHD6XbhFx7Gr8OWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtXNl3GM7YtmnMy4534SgqhFeI3LY26tOyWbe5q6rFOQt7M8iR
	WZG/EAkBJVCDJTbT0/HrgEO9p0KW0Svkrk2xSF0dE1TQlZK3ZEFKkyOFTtEijnkS21Rgd/GUn5Y
	zE0PAFj+4nRNLMp1g0zMYrLl3bnYQmKWH4HH3ej2UAW2tGbtHNa210CYYUs4=
X-Google-Smtp-Source: AGHT+IGZBzky28h7vaazRxhmyPHTTskvRA1dazi6T5/NV0pPluQoGd82LyNcpcOEs0gF2K9vD6NJiCyJzjGHc31O54+uw1/sBn4d
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:6101:b0:65c:fa23:2cf7 with SMTP id
 006d021491bc7-65f54f7e6b0mr823746eaf.65.1767803058758; Wed, 07 Jan 2026
 08:24:18 -0800 (PST)
Date: Wed, 07 Jan 2026 08:24:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695e88b2.050a0220.1c677c.036d.GAE@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in IP6_ECN_decapsulate (3)
From: syzbot <syzbot+d4dda070f833dc5dc89a@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9bb956508c9d Merge tag 'riscv-for-linus-6.18-rc3' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=157ccbe2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dce7eac4016da338
dashboard link: https://syzkaller.appspot.com/bug?extid=d4dda070f833dc5dc89a
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12022258580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140eaf34580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e72b2dd5c2f0/disk-9bb95650.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a1b145971798/vmlinux-9bb95650.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bb711e135af2/bzImage-9bb95650.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d4dda070f833dc5dc89a@syzkaller.appspotmail.com

syz.0.17 uses obsolete (PF_INET,SOCK_PACKET)
=====================================================
BUG: KMSAN: uninit-value in __INET_ECN_decapsulate include/net/inet_ecn.h:253 [inline]
BUG: KMSAN: uninit-value in INET_ECN_decapsulate include/net/inet_ecn.h:275 [inline]
BUG: KMSAN: uninit-value in IP6_ECN_decapsulate+0x7a8/0x1fa0 include/net/inet_ecn.h:321
 __INET_ECN_decapsulate include/net/inet_ecn.h:253 [inline]
 INET_ECN_decapsulate include/net/inet_ecn.h:275 [inline]
 IP6_ECN_decapsulate+0x7a8/0x1fa0 include/net/inet_ecn.h:321
 ip6ip6_dscp_ecn_decapsulate+0x16f/0x1b0 net/ipv6/ip6_tunnel.c:729
 __ip6_tnl_rcv+0xed9/0x1b50 net/ipv6/ip6_tunnel.c:860
 ip6_tnl_rcv+0xc3/0x100 net/ipv6/ip6_tunnel.c:903
 gre_rcv+0x14fd/0x1b60 net/ipv6/ip6_gre.c:-1
 ip6_protocol_deliver_rcu+0x1c89/0x2c60 net/ipv6/ip6_input.c:438
 ip6_input_finish+0x1f4/0x4a0 net/ipv6/ip6_input.c:489
 NF_HOOK include/linux/netfilter.h:318 [inline]
 ip6_input+0x9c/0x330 net/ipv6/ip6_input.c:500
 ip6_mc_input+0x7ca/0xc10 net/ipv6/ip6_input.c:590
 dst_input include/net/dst.h:474 [inline]
 ip6_rcv_finish+0x958/0x990 net/ipv6/ip6_input.c:79
 NF_HOOK include/linux/netfilter.h:318 [inline]
 ipv6_rcv+0xf1/0x3c0 net/ipv6/ip6_input.c:311
 __netif_receive_skb_one_core net/core/dev.c:6079 [inline]
 __netif_receive_skb+0x1df/0xac0 net/core/dev.c:6192
 netif_receive_skb_internal net/core/dev.c:6278 [inline]
 netif_receive_skb+0x57/0x630 net/core/dev.c:6337
 tun_rx_batched+0x1df/0x980 drivers/net/tun.c:1485
 tun_get_user+0x5d60/0x6d70 drivers/net/tun.c:1953
 tun_chr_write_iter+0x3e9/0x5c0 drivers/net/tun.c:1999
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0xbe2/0x15d0 fs/read_write.c:686
 ksys_write fs/read_write.c:738 [inline]
 __do_sys_write fs/read_write.c:749 [inline]
 __se_sys_write fs/read_write.c:746 [inline]
 __x64_sys_write+0x1fb/0x4d0 fs/read_write.c:746
 x64_sys_call+0x3014/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4977 [inline]
 slab_alloc_node mm/slub.c:5280 [inline]
 kmem_cache_alloc_node_noprof+0x989/0x16b0 mm/slub.c:5332
 kmalloc_reserve+0x13c/0x4b0 net/core/skbuff.c:579
 __alloc_skb+0x347/0x7d0 net/core/skbuff.c:670
 alloc_skb include/linux/skbuff.h:1383 [inline]
 alloc_skb_with_frags+0xc5/0xa60 net/core/skbuff.c:6671
 sock_alloc_send_pskb+0xacc/0xc60 net/core/sock.c:2965
 tun_alloc_skb drivers/net/tun.c:1461 [inline]
 tun_get_user+0x1142/0x6d70 drivers/net/tun.c:1794
 tun_chr_write_iter+0x3e9/0x5c0 drivers/net/tun.c:1999
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0xbe2/0x15d0 fs/read_write.c:686
 ksys_write fs/read_write.c:738 [inline]
 __do_sys_write fs/read_write.c:749 [inline]
 __se_sys_write fs/read_write.c:746 [inline]
 __x64_sys_write+0x1fb/0x4d0 fs/read_write.c:746
 x64_sys_call+0x3014/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 6032 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(none) 
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

