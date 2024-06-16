Return-Path: <netdev+bounces-103881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA13E909EFC
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 20:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366061F212D9
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 18:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1AE3A1DD;
	Sun, 16 Jun 2024 18:10:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9AE8F48
	for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 18:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718561422; cv=none; b=mfFCUay0UoaijhgOytsw94zl6JSt3KzqUkdQChi4THYLspv3vr2qHPlujVhqMXftb1Jxhh3mG72kkAqqKNwOxPUI7/6qBWnD2FZ0L3R7cj3zySORuQpMwkvEVPsxUHgw+xTFrPy+g65nIuuT4PcDi2pb1ER4UMvEWXWbaK3NBk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718561422; c=relaxed/simple;
	bh=7+7MFyHk11vi9eBTLmKp+v9VUFipyCwofVlIvborQBs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=h1k2QEkzP/HbopukECZLQrEkKW6kJon9deMn7X68owxjQ6oLcmuHQcUYPlAyOb0RO2Peu17j8OL/OA4jM7S9eaM2v/Bv7PykclLAtriAaRh+4alJMGZYoSZ6NR5S6JKAGx0JQGDaLecZMBgkmUFRgPOa0JEKS+hCs9rtpPoDobA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7e6e4a83282so456609839f.2
        for <netdev@vger.kernel.org>; Sun, 16 Jun 2024 11:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718561420; x=1719166220;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nrYU6JDIwS80CxOKwrt5b61jti47MKIp+Id+1DaGeOU=;
        b=YYIxYp1P/ih3qFvXPrIstawkryCzPedzBmmOTlzrWGd57/ZglIUZ1xbl9iJd1BY3Jq
         CW8IG5zWUbW+5qNU7/BLp8xtQRGGxP4GXcuRf7p2mxHqPpw4ARGTzXZFyFFkjm4T1EmG
         YK5AA0zeKEAYZak2Bbvi4E77tzdaM1i3Ud9S1ETcf7fgwuwmPQPQMi8JXTXoyKb4v8Ef
         9WhVQVCf5OO4uZpK/v9IuqcsUV3aa6C8E6sS+a4umR8JfSZ/+sjEvbhVMmCuwV1PW+eA
         toGOQZzfMdYyBmliz0r8Q9foS1Su1YBPz5zAEtrE5wEQ50U8QFNumKmqIL7tr8Wsk0sn
         Af+w==
X-Forwarded-Encrypted: i=1; AJvYcCUl2hfmJBG2RcuZpH/tz6Nt0DTfZHb6G9oT5XTqxVJFtWMaUBHvK2UefY1GkJgczX7n3L0F3D0+qPsxxfW6nzJs2+cqWzxA
X-Gm-Message-State: AOJu0Yz0bJOtWlNT5KpOv2nu1Hv8lwwlbZLB5rEtjiOMORwl78JAWXTT
	Hn110FHRMsMH9yqjT79w4I8EpjMv0RYZe3o8JuvjwEHfYMq8sGPRcIHKzP58qLJePOvrzwSJ1fE
	b9tyuegEMzJdKMJq5YsH8OtLsSOX+6hyE/xlr90VT5OmSIajddShHxew=
X-Google-Smtp-Source: AGHT+IFXjfNVGVhps53tiw/UPSTIudku3JjQrZDRHQK9ATBhtEZuCdMDQrXUsWhZifzibJ/loToODVsUICXE5d90wuB1BkMZ8OXv
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:35a5:b0:4b9:80a8:3cf3 with SMTP id
 8926c6da1cb9f-4b980a84230mr152116173.6.1718561420086; Sun, 16 Jun 2024
 11:10:20 -0700 (PDT)
Date: Sun, 16 Jun 2024 11:10:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f82ce5061b05c2b4@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in hsr_forward_skb
From: syzbot <syzbot+b78a03b570e0033aba81@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15b61eee980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=b78a03b570e0033aba81
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b78a03b570e0033aba81@syzkaller.appspotmail.com

ip6gretap0: entered promiscuous mode
syz_tun: entered promiscuous mode
=====================================================
BUG: KMSAN: uninit-value in hsr_forward_skb+0x268c/0x30e0 net/hsr/hsr_forward.c:618
 hsr_forward_skb+0x268c/0x30e0 net/hsr/hsr_forward.c:618
 hsr_handle_frame+0xa20/0xb50 net/hsr/hsr_slave.c:69
 __netif_receive_skb_core+0x1cff/0x6190 net/core/dev.c:5438
 __netif_receive_skb_one_core net/core/dev.c:5542 [inline]
 __netif_receive_skb+0xca/0xa00 net/core/dev.c:5658
 netif_receive_skb_internal net/core/dev.c:5744 [inline]
 netif_receive_skb+0x58/0x660 net/core/dev.c:5804
 tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1549
 tun_get_user+0x5587/0x6a00 drivers/net/tun.c:2002
 tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
 call_write_iter include/linux/fs.h:2120 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb31/0x14d0 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 x64_sys_call+0x3062/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 hsr_fill_frame_info+0x538/0x540 net/hsr/hsr_forward.c:533
 fill_frame_info net/hsr/hsr_forward.c:600 [inline]
 hsr_forward_skb+0x6f6/0x30e0 net/hsr/hsr_forward.c:615
 hsr_handle_frame+0xa20/0xb50 net/hsr/hsr_slave.c:69
 __netif_receive_skb_core+0x1cff/0x6190 net/core/dev.c:5438
 __netif_receive_skb_one_core net/core/dev.c:5542 [inline]
 __netif_receive_skb+0xca/0xa00 net/core/dev.c:5658
 netif_receive_skb_internal net/core/dev.c:5744 [inline]
 netif_receive_skb+0x58/0x660 net/core/dev.c:5804
 tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1549
 tun_get_user+0x5587/0x6a00 drivers/net/tun.c:2002
 tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
 call_write_iter include/linux/fs.h:2120 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb31/0x14d0 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 x64_sys_call+0x3062/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
 alloc_pages_mpol+0x299/0x990 mm/mempolicy.c:2264
 alloc_pages+0x1bf/0x1e0 mm/mempolicy.c:2335
 skb_page_frag_refill+0x2bf/0x7c0 net/core/sock.c:2921
 tun_build_skb drivers/net/tun.c:1679 [inline]
 tun_get_user+0x1258/0x6a00 drivers/net/tun.c:1819
 tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
 call_write_iter include/linux/fs.h:2120 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xb31/0x14d0 fs/read_write.c:590
 ksys_write+0x20f/0x4c0 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0x93/0xe0 fs/read_write.c:652
 x64_sys_call+0x3062/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:2
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 PID: 5890 Comm: syz-executor.3 Not tainted 6.9.0-syzkaller-02707-g614da38e2f7a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
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

