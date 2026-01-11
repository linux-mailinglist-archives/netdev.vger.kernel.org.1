Return-Path: <netdev+bounces-248796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EBBD0EB4F
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 12:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B69930086C5
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 11:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429463382DB;
	Sun, 11 Jan 2026 11:35:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC29331218
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768131335; cv=none; b=l1x7/DySzzn5kT9Q2Dl/ydbz6aa2bZtDAgooTFaey+D41kQIPfVBlUQuVtgOg58zZLAXoIPmy5LjkGFG4S3CO0eKtR8ZsD0fd9PvlnYUpqBD4PwaqrSe1gHPnqLWfwxcQvEdM18IYpm0zTsDnC7Gf/5wslyNE+ueeDgYGbzbMxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768131335; c=relaxed/simple;
	bh=57BcdOaqkoFKPalZF4kb0yJgHs3b9diZQObKah5jSlc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=A0qhIIgut92I9w01DqlmMuPmd7kdZ+qdbslsqKLwGStMbiNjob+GZlNjd6RKrx3SaswmqM/mMMLaP6InIWqpDLS4/5YhVk8tRePLKMNKK+L/hrohUFzBLiLKK+sVBn186U2bYJYmt8dARXrsAD7OSZPvzVlitvOkbX6v+t6UjuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-3fda5f60035so9498267fac.0
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 03:35:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768131332; x=1768736132;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e6/jbbz9zla6XH3ASE7oZUGg6+DGatjynlVS29Ut1C4=;
        b=RrXFSbP3LEQLund7CjxPnyiuNvlmbFt95j+cMybp4QbwfLMzt9v4zRgVpvxtHCCMq0
         Ly3osQz7lyXv5JN1AkhmVjhCcZ30Kk5wjJeQ1OEUUk7F64pnbytFy5yXWup5B0i4ImqU
         qOR5ob2H0HXVrJrMCxZWvbsMD2161LP2+pJ3wQ+KSGtju7qOZqbPJjUt9eLTIyMF8L6y
         iTS7gckVwo72hsNSGyrE+zfwhL8yYJB1gKWSqZSjWsn1JJv7sWPukk2JdU39EBUhM8fQ
         zEK3pyHNsgicKGxe2CUjCGQLxJs3A+m1rdmcq9waS0pl4qouxtoTeBphWUW1QtrdTYdu
         zM/g==
X-Forwarded-Encrypted: i=1; AJvYcCUtkbKu/lySpQNSRSai0shiQMzKQxeV1bqZwGgZFe/Z2icVfcyAg5EfNCfyOkWwdxOOrSsgcUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsfUeIzRKNF5lWU/Yi4yxSLCzB9QG71BMbyVAd2/XaVMFywDqX
	mwLPrgAxoQ69lykUOHUbGM+dQNSBZ2PusK2jg9ee/utwusO1XrzF0iA0WwLXu3MRWMBMTP6YUjh
	ZSm54TDxB2SoGUnE9i7u8/eBlctExSUHwI38gpHPbzIom+nreT6u24K1WE7o=
X-Google-Smtp-Source: AGHT+IF5i7Jc2Pa1QYeaKVHMr6CPYtn8COJ+T1hzZC+wx4RdujTrnmDfLa5f3mA+Im/hXS8NEru2miJEsnZGT4S9Wm9P0AxBkoiA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:780e:b0:659:9a49:8e66 with SMTP id
 006d021491bc7-65f54f5abefmr5235655eaf.54.1768131332560; Sun, 11 Jan 2026
 03:35:32 -0800 (PST)
Date: Sun, 11 Jan 2026 03:35:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69638b04.050a0220.eaf7.0063.GAE@google.com>
Subject: [syzbot] [bridge?] [netfilter?] WARNING in br_nf_local_in (2)
From: syzbot <syzbot+9c5dd93a81a3f39325c2@syzkaller.appspotmail.com>
To: bridge@lists.linux.dev, coreteam@netfilter.org, davem@davemloft.net, 
	edumazet@google.com, fw@strlen.de, horms@kernel.org, idosch@nvidia.com, 
	kadlec@netfilter.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pabeni@redhat.com, 
	pablo@netfilter.org, phil@nwl.cc, razor@blackwall.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f417b7ffcbef Add linux-next specific files for 20260109
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12f625fa580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=63a1fc1b4011ac76
dashboard link: https://syzkaller.appspot.com/bug?extid=9c5dd93a81a3f39325c2
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1f048080a918/disk-f417b7ff.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dfd5ea190c96/vmlinux-f417b7ff.xz
kernel image: https://storage.googleapis.com/syzbot-assets/db24c176e0df/bzImage-f417b7ff.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9c5dd93a81a3f39325c2@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: net/bridge/br_netfilter_hooks.c:602 at br_nf_local_in+0x40e/0x470 net/bridge/br_netfilter_hooks.c:602, CPU#1: ksoftirqd/1/23
Modules linked in:
CPU: 1 UID: 0 PID: 23 Comm: ksoftirqd/1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:br_nf_local_in+0x40e/0x470 net/bridge/br_netfilter_hooks.c:602
Code: 38 69 eb f7 e9 4b fc ff ff 44 89 e1 80 e1 07 38 c1 0f 8c a8 fc ff ff 4c 89 e7 e8 1d 69 eb f7 e9 9b fc ff ff e8 d3 98 84 f7 90 <0f> 0b 90 48 89 df e8 b7 2b 00 00 e9 5b fd ff ff e8 bd 98 84 f7 90
RSP: 0000:ffffc900001d6f38 EFLAGS: 00010246
RAX: ffffffff8a3c21ed RBX: ffff8880792ba140 RCX: ffff88801d6ddac0
RDX: 0000000000000100 RSI: 0000000000000002 RDI: 0000000000000001
RBP: 0000000000000002 R08: ffff88807903e183 R09: 1ffff1100f207c30
R10: dffffc0000000000 R11: ffffed100f207c31 R12: 0000000000000000
R13: ffff8880792ba1a8 R14: 1ffff1100f257435 R15: ffff88807903e180
FS:  0000000000000000(0000) GS:ffff888125d07000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa503fb1000 CR3: 0000000078d26000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_slow+0xc5/0x220 net/netfilter/core.c:623
 nf_hook include/linux/netfilter.h:273 [inline]
 NF_HOOK+0x251/0x390 include/linux/netfilter.h:316
 br_handle_frame_finish+0x15c6/0x1c90 net/bridge/br_input.c:235
 br_nf_hook_thresh net/bridge/br_netfilter_hooks.c:-1 [inline]
 br_nf_pre_routing_finish+0x1364/0x1af0 net/bridge/br_netfilter_hooks.c:425
 NF_HOOK+0x61b/0x6b0 include/linux/netfilter.h:318
 br_nf_pre_routing+0xeb7/0x1470 net/bridge/br_netfilter_hooks.c:534
 nf_hook_entry_hookfn include/linux/netfilter.h:158 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:291 [inline]
 br_handle_frame+0x96e/0x14f0 net/bridge/br_input.c:442
 __netif_receive_skb_core+0x95f/0x2f90 net/core/dev.c:6026
 __netif_receive_skb_one_core net/core/dev.c:6137 [inline]
 __netif_receive_skb+0x72/0x380 net/core/dev.c:6252
 process_backlog+0x54f/0x1340 net/core/dev.c:6604
 __napi_poll+0xae/0x320 net/core/dev.c:7668
 napi_poll net/core/dev.c:7731 [inline]
 net_rx_action+0x64a/0xe00 net/core/dev.c:7883
 handle_softirqs+0x22b/0x7c0 kernel/softirq.c:626
 run_ksoftirqd+0x36/0x60 kernel/softirq.c:1067
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x389/0x480 kernel/kthread.c:467
 ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
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

