Return-Path: <netdev+bounces-235449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C59C30BCB
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 12:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE0E3A382F
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 11:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAEE2DA759;
	Tue,  4 Nov 2025 11:29:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD932D5C6C
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762255777; cv=none; b=CT/a2S3EQ243M4SObTo+rezfsDfH5jZSjZ8OA98wGMxUueyjq3G1mFVZiQQxBaqYu9LGmPSyUQlbqVMPEteXWXDW8CDoLPj/kaGg/Nb/SULe384PE65IDhsdZgPRoTJMfcKCOqmuubBMNai00EjeAMwsoLFSSNVIUeSMObZrthc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762255777; c=relaxed/simple;
	bh=kVZS8cbDE+c0gpGCPYs/RrNkIXHAqMRQVmxZev4xBUE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VunGpq1GPWJ9EhmxgTOJ6yYtPlVQpCCG4+C8jyoVH62P+50ue+S1kQjIvUZGkvpgu7WPSPXoWtywpkDgOPlDQ0YVRXEwLP8WqRVIc67lobvl/bhd0Y07ghviDb0YH8jBIr8rX2P4najTr+axlU92r5jr/nAtWonVf0DFqnvi+yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-43327c30cb1so23220525ab.2
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 03:29:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762255775; x=1762860575;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wfdSiD6H6dgNLjSNWHtvaDbepxoyRDcG7l0NgNAm8pY=;
        b=dWSYd6i5Tj8heIUPZhtEYmtr/nRelAFqUjqva8dDwlLfeIsUL5SgcBGnKgKJbjHIKR
         1gI55z9GMw2tXqZ+OhT7OXRhHD09CGAVVktPs0TvcCEsf8baa/rHFgNhGkxkVFtuOaNl
         Iv/Sb/kDxJRXMuSbUux3c4S9phFMQTepQNYqnrXLZd3uZCAK46OM634iQHQFU/qJkZJ0
         Ch2md3HEI1cPdDMPoh5GoCygVpLYZ6iZh+gSVyS2R40ISY56wASwvoW3rAq9xngsBl7g
         QF29Atij99Loa9hPMpqpzYeSHjlmFVQy+5RIZbtfpyW2/SZ/LkfuTDExVpRnKwpM5zMa
         PV7w==
X-Forwarded-Encrypted: i=1; AJvYcCXSfoO0mvRc6s/5g1yWPiTPrjFSNZripRbsqy3dNEydcgi7cc0nuKN2RvrVgRhmV1HQ+A3Y+m4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu4L0unG4qpQVDzvEt6asVV03eEb/XbYnm2tM0BtMSFM6V8WOx
	0NijN69ZIE4CWPGDcHsDbxS5dVVpIoNUvit4KDBBVx/h2cM3ZzWd13LNSXYdzU3We2M+h8sbXLL
	GI2cc0vSCkaFtTvkrC0J5ysD61JSoBI6nyZTqdR0LIMD6x3ol9mzCAqMNWP8=
X-Google-Smtp-Source: AGHT+IG7UblVhGBxAqv2BjydP9+MTF2Kw0Nmte9yhn0DET0eBHB1INzVsl4SOmkKE3RI9SWoL8bmvVFvppMSWd4cTGoUQyisFDut
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2604:b0:426:c373:25f5 with SMTP id
 e9e14a558f8ab-4330d1c9d9cmr239510745ab.17.1762255775237; Tue, 04 Nov 2025
 03:29:35 -0800 (PST)
Date: Tue, 04 Nov 2025 03:29:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6909e39f.050a0220.98a6.00ac.GAE@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in macsec_handle_frame (2)
From: syzbot <syzbot+0e665e4b99cb925286a0@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, sd@queasysnail.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6fab32bb6508 MAINTAINERS: add Mark Brown as a linux-next m..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=100c2614580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e9863e17aadf7a1
dashboard link: https://syzkaller.appspot.com/bug?extid=0e665e4b99cb925286a0
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/df4a4033fe11/disk-6fab32bb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cc3ed0072d4f/vmlinux-6fab32bb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/58cfbb151380/bzImage-6fab32bb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0e665e4b99cb925286a0@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in macsec_handle_frame+0x2f6/0x5410 drivers/net/macsec.c:1148
 macsec_handle_frame+0x2f6/0x5410 drivers/net/macsec.c:1148
 __netif_receive_skb_core+0x2043/0x7150 net/core/dev.c:5966
 __netif_receive_skb_one_core net/core/dev.c:6077 [inline]
 __netif_receive_skb+0xcc/0xac0 net/core/dev.c:6192
 process_backlog+0x485/0xa00 net/core/dev.c:6544
 __napi_poll+0xdd/0x8a0 net/core/dev.c:7594
 napi_poll net/core/dev.c:7657 [inline]
 net_rx_action+0xbc8/0x1c30 net/core/dev.c:7784
 handle_softirqs+0x169/0x6e0 kernel/softirq.c:622
 __do_softirq+0x14/0x1b kernel/softirq.c:656
 do_softirq+0x99/0x100 kernel/softirq.c:523
 __local_bh_enable_ip+0xa1/0xb0 kernel/softirq.c:450
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 netif_rx+0xdb/0x3f0 net/core/dev.c:5647
 pn_send+0x95b/0xb80 net/phonet/af_phonet.c:185
 pn_skb_send+0x462/0xa70 net/phonet/af_phonet.c:272
 pipe_handler_request net/phonet/pep.c:144 [inline]
 pep_sock_connect+0x2af/0x490 net/phonet/pep.c:894
 pn_socket_connect+0x576/0xd10 net/phonet/socket.c:255
 __sys_connect_file net/socket.c:2102 [inline]
 __sys_connect+0x51a/0x680 net/socket.c:2121
 __do_sys_connect net/socket.c:2127 [inline]
 __se_sys_connect net/socket.c:2124 [inline]
 __x64_sys_connect+0x95/0x100 net/socket.c:2124
 x64_sys_call+0x3744/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:43
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
 pn_raw_send+0x59/0x510 net/phonet/af_phonet.c:207
 send_reset_indications+0x139/0x1c0 net/phonet/af_phonet.c:344
 phonet_rcv+0x1478/0x1830 net/phonet/af_phonet.c:409
 __netif_receive_skb_one_core net/core/dev.c:6079 [inline]
 __netif_receive_skb+0x477/0xac0 net/core/dev.c:6192
 process_backlog+0x485/0xa00 net/core/dev.c:6544
 __napi_poll+0xdd/0x8a0 net/core/dev.c:7594
 napi_poll net/core/dev.c:7657 [inline]
 net_rx_action+0xbc8/0x1c30 net/core/dev.c:7784
 handle_softirqs+0x169/0x6e0 kernel/softirq.c:622
 __do_softirq+0x14/0x1b kernel/softirq.c:656

CPU: 0 UID: 0 PID: 6693 Comm: syz.0.173 Tainted: G        W           syzkaller #0 PREEMPT(none) 
Tainted: [W]=WARN
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

