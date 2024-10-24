Return-Path: <netdev+bounces-138902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 623969AF588
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 00:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85BDF1F2238C
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 22:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2E221859E;
	Thu, 24 Oct 2024 22:43:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E311B6D18
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 22:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729809810; cv=none; b=LFmlB87XzVt3jBcxX6IoboGQJC1gA7ENkeqf1kRJFQ4wxCNulkwEFFd2Fkw/+lAqWZ5u4TcUjnEzUsZdBh+q1M2eO8O7mXZcLMAEn+0QE5NR8X8Du54JMQq9lAuyrA4juOU/RhADWU0yzvnjhvt199a8w2SVb6VdVPFP2O9Ax/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729809810; c=relaxed/simple;
	bh=/5ZYiZzp0GCwEHzhlO4n5c7xBYQikJ94R0K09EPhww4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EldxyRri1woeigZSyQX0bd2S+gFploZjBOzQzc0xy1/zztmcRX1R0N6Kd6eJDd1pz0RC7oszBqW00u/Tio1vHeWBdBu7J3Ih6qmLAaiJwc9cI4xC/humy6JXDeCzNn7wv1Ur/V3XMDCPQzQxp8WLHKdb9DhI4C/negBotEldXv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3cb771556so12702755ab.3
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 15:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729809806; x=1730414606;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oYhwuTsK8ErK8pqCznBjVR9j914DxkP9wNsyhF8XfNE=;
        b=cQTA8/qTIRdg6KB1xH6mkOz0dBWUY4Bjy4KgCK59ltMZr+q3jxcgbAVLwH4+mBRMk/
         XfP5uQYYuRne+J+DVFtTDZ7LclEEjyIWsZyh2mwvX5Ef6MD8hH49MUCSVKQgiM695vNn
         iJXxIwsQSGi7dbekBdJgRml073vK6PWuB8b8iAXJKWVZaZzr8iupHvCmR3WlonFaGcpd
         5w4ubg6xg1WA9T1Td3lNOv8x/3+lbv4jRMnr8Nso3MAqiQvnsTco4zZo/Z538+l6rVY9
         +RFjhLsNGpF3UmANL9+6oVYthNIqqOP3tD+fe5RF9ZK/5Uld8l4rD7QQyR4Q7w8T4AQt
         32fA==
X-Forwarded-Encrypted: i=1; AJvYcCUBcA6ifGJBSRbX5bYuMnS91KmYTATpDAQ0/BxP/DL8vPDqkojUy+Dp8q2lqJheWq4lD6v+qmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPpQ2mcN9kCNNmAFoNTj2MHYQloknLQ/HGvB1FIHIB+aGOE/gg
	hNFMSfCc2TYCP0ehwvNw6YVP/2sDOFnaoEgzwEu42acEFu4PQWj2Sw8OrlksE9msngkHc5FoJ0k
	FCHNnVw8NT3iirycGySZiSwFwYo+w3U5iYryQ9RGwpbPyNRG7jAuXDTs=
X-Google-Smtp-Source: AGHT+IHYrJDXK6aFf17ulAjn+yC+63HeE3NGSQGIClDwD8lYhcUEcg0knjLbI0x9uvE/qx2paCHgOGrAMeLJEIGuG1oRFJWpNaW8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1564:b0:3a3:aff3:a02b with SMTP id
 e9e14a558f8ab-3a4d596356amr89928775ab.6.1729809806558; Thu, 24 Oct 2024
 15:43:26 -0700 (PDT)
Date: Thu, 24 Oct 2024 15:43:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671acd8e.050a0220.381c35.0004.GAE@google.com>
Subject: [syzbot] [afs?] [net?] KMSAN: uninit-value in rxrpc_lookup_peer_rcu
From: syzbot <syzbot+14c04e62ca58315571d1@syzkaller.appspotmail.com>
To: davem@davemloft.net, dhowells@redhat.com, edumazet@google.com, 
	kuba@kernel.org, linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, 
	marc.dionne@auristor.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    db87114dcf13 Merge tag 'x86_urgent_for_v6.12_rc4' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12cf2a40580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a0aee472a2b5f0a
dashboard link: https://syzkaller.appspot.com/bug?extid=14c04e62ca58315571d1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/140719cfa0c4/disk-db87114d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fb8a264c89a8/vmlinux-db87114d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4de63179d231/bzImage-db87114d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+14c04e62ca58315571d1@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in rxrpc_lookup_peer_rcu+0x2f8/0x300 net/rxrpc/peer_object.c:142
 rxrpc_lookup_peer_rcu+0x2f8/0x300 net/rxrpc/peer_object.c:142
 rxrpc_lookup_peer_local_rcu net/rxrpc/peer_event.c:97 [inline]
 rxrpc_input_error+0x756/0x16e0 net/rxrpc/peer_event.c:148
 rxrpc_io_thread+0x13aa/0x5190 net/rxrpc/io_thread.c:498
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was stored to memory at:
 rxrpc_input_error+0x499/0x16e0 net/rxrpc/peer_event.c:148
 rxrpc_io_thread+0x13aa/0x5190 net/rxrpc/io_thread.c:498
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4091 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_node_noprof+0x6bf/0xb80 mm/slub.c:4186
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:587
 __alloc_skb+0x363/0x7b0 net/core/skbuff.c:678
 alloc_skb include/linux/skbuff.h:1322 [inline]
 ipv6_local_error+0xd0/0xa10 net/ipv6/datagram.c:354
 __ip6_append_data+0x6f3/0x68e0 net/ipv6/ip6_output.c:1491
 ip6_make_skb+0x5bd/0xd60 net/ipv6/ip6_output.c:2048
 udpv6_sendmsg+0x3b5e/0x40c0 net/ipv6/udp.c:1584
 do_udp_sendmsg net/rxrpc/output.c:32 [inline]
 rxrpc_send_data_packet net/rxrpc/output.c:488 [inline]
 rxrpc_transmit_one+0xf68/0x2f20 net/rxrpc/output.c:713
 rxrpc_decant_prepared_tx net/rxrpc/call_event.c:271 [inline]
 rxrpc_transmit_some_data net/rxrpc/call_event.c:295 [inline]
 rxrpc_input_call_event+0x18ba/0x2c10 net/rxrpc/call_event.c:401
 rxrpc_io_thread+0xa5c/0x5190 net/rxrpc/io_thread.c:478
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

CPU: 0 UID: 0 PID: 12896 Comm: krxrpcio/0 Tainted: G        W          6.12.0-rc3-syzkaller-00454-gdb87114dcf13 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
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

