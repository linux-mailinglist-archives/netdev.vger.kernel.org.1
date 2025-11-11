Return-Path: <netdev+bounces-237642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F7AC4E4CE
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 15:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B98174E2BA2
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 14:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F1830E0F6;
	Tue, 11 Nov 2025 14:09:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE6530BF66
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870143; cv=none; b=OV+oZdqLFFlv0aX0fsXhqF+2cmb/rdSw33l+nLDGRGFfPFXz+XzOT5Veh+BL3UQmX37mcbGBvtGuNUlcBYClAnWiAy813GLFWzf/+sFlDmA11UrrgtdeXffBIU6cbdKt2YBKH7NiHLVyZYTKGw06ctURyEZXQQHyHVJSa6e7tEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870143; c=relaxed/simple;
	bh=ArxyiOFu7/8nPuiBy4ho5ISc1baKmkk5k3bM0YU9jAo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Jz63Jl7OCZJdkzDvq/TupNyL5FUdWdZMtO0udtW4D8hMwQP6TbvuvXfby9UrF0CxP9BF3+lVmP7GfOLE7ijSVoSbv3Fvx6bkxzwey8q8F4ByoExWSytmW0g4hUMFMAGcXRcpxdhZFdTWusyGZTwD4a0jtZbIIWZcyBLS+PPgxUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-43300f41682so38524185ab.1
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 06:09:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762870140; x=1763474940;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PaHLk+lw4hWVTyNp1Y0Jwl5O/xRGp4qKtAJp6UDcmMs=;
        b=tKfgZitVeE3AZXMraUQ2k1quxrpvj4JppgfU7tXyvsAU00KP46a1tLhLOJKx+XGvxA
         Bpv551SW2HT6VNx/JNWH2bZkV6pTRu0VCifBprCe2BPSyecdMO8CZ8YM89G1c40GnBdr
         1nxU9ugblHWOgrdWEmKpc1ku+2iSwdyzsY4QrcYLUbNipCTrgeFjFnTNxSCzNJg+SY4Q
         uJsSoDcy090aXST09S0+sA4oviW473OhFYgxylg3YRWXD3Pvz4YZj2ZjV9iifd6/hP32
         8jpPTrNQaSZxicuoBVSSSJHcV3bdmUXLJsRev/36sx9J3cAX0YfESlxsRmuhKXVEGhKH
         cU+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWoyIUQQZ4GTFC9DX/VsMroyT7cX28AdFz8ZDjcrfsAj7WcoyXkpnaOgvR57WUpW0xfH/713ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZRdewTA30mHaMAjbh/amgOGWuLjgowkLaT6XOwk5g8z2CzVDp
	Ygr8H/ecW47K1vgcyJwogk9e7psLof4+sEAe4y2IyznM9PB6EZoOkqKt5tuCX/jBB4o0u8y/kJ5
	IaBB4yg0tBt1nsQQ8G/vJpSAvquyhkHWXJDwNqm8WUijeL+hY57rn9wF/G4E=
X-Google-Smtp-Source: AGHT+IE7DtU6V4dhm/rWWcNSb5/hQIvNn1t/ULtONi24IfVW4Jych9CAA/Xz4bqSTtPjaX1/qcCkWQ658GMba752eB1QKUSMu8X0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b01:b0:433:5736:96a2 with SMTP id
 e9e14a558f8ab-43367e25667mr203330615ab.12.1762870140567; Tue, 11 Nov 2025
 06:09:00 -0800 (PST)
Date: Tue, 11 Nov 2025 06:09:00 -0800
In-Reply-To: <20251111093204.1432437-1-edumazet@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6913437c.a70a0220.22f260.013b.GAE@google.com>
Subject: [syzbot ci] Re: net_sched: speedup qdisc dequeue
From: syzbot ci <syzbot+ci51c71986dfbbfee2@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, eric.dumazet@gmail.com, 
	horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	kuniyu@google.com, netdev@vger.kernel.org, pabeni@redhat.com, toke@redhat.com, 
	willemb@google.com, xiyou.wangcong@gmail.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v2] net_sched: speedup qdisc dequeue
https://lore.kernel.org/all/20251111093204.1432437-1-edumazet@google.com
* [PATCH v2 net-next 01/14] net_sched: make room for (struct qdisc_skb_cb)->pkt_segs
* [PATCH v2 net-next 02/14] net: init shinfo->gso_segs from qdisc_pkt_len_init()
* [PATCH v2 net-next 03/14] net_sched: initialize qdisc_skb_cb(skb)->pkt_segs in qdisc_pkt_len_init()
* [PATCH v2 net-next 04/14] net: use qdisc_pkt_len_segs_init() in sch_handle_ingress()
* [PATCH v2 net-next 05/14] net_sched: use qdisc_skb_cb(skb)->pkt_segs in bstats_update()
* [PATCH v2 net-next 06/14] net_sched: cake: use qdisc_pkt_segs()
* [PATCH v2 net-next 07/14] net_sched: add Qdisc_read_mostly and Qdisc_write groups
* [PATCH v2 net-next 08/14] net_sched: sch_fq: move qdisc_bstats_update() to fq_dequeue_skb()
* [PATCH v2 net-next 09/14] net_sched: sch_fq: prefetch one skb ahead in dequeue()
* [PATCH v2 net-next 10/14] net: prefech skb->priority in __dev_xmit_skb()
* [PATCH v2 net-next 11/14] net: annotate a data-race in __dev_xmit_skb()
* [PATCH v2 net-next 12/14] net_sched: add tcf_kfree_skb_list() helper
* [PATCH v2 net-next 13/14] net_sched: add qdisc_dequeue_drop() helper
* [PATCH v2 net-next 14/14] net_sched: use qdisc_dequeue_drop() in cake, codel, fq_codel

and found the following issue:
WARNING in sk_skb_reason_drop

Full report is available here:
https://ci.syzbot.org/series/a9dbee91-6b1f-4ab9-b55d-43f7f50de064

***

WARNING in sk_skb_reason_drop

tree:      net-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net-next.git
base:      a0c3aefb08cd81864b17c23c25b388dba90b9dad
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/a5059d85-d1f8-4036-a0fd-b677b5945ea9/config
C repro:   https://ci.syzbot.org/findings/e529fc3a-766e-4d6c-899a-c35a8fdaa940/c_repro
syz repro: https://ci.syzbot.org/findings/e529fc3a-766e-4d6c-899a-c35a8fdaa940/syz_repro

syzkaller0: entered promiscuous mode
syzkaller0: entered allmulticast mode
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5965 at net/core/skbuff.c:1192 __sk_skb_reason_drop net/core/skbuff.c:1189 [inline]
WARNING: CPU: 0 PID: 5965 at net/core/skbuff.c:1192 sk_skb_reason_drop+0x76/0x170 net/core/skbuff.c:1214
Modules linked in:
CPU: 0 UID: 0 PID: 5965 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:__sk_skb_reason_drop net/core/skbuff.c:1189 [inline]
RIP: 0010:sk_skb_reason_drop+0x76/0x170 net/core/skbuff.c:1214
Code: 20 2e a0 f8 83 fd 01 75 26 41 8d ae 00 00 fd ff bf 01 00 fd ff 89 ee e8 08 2e a0 f8 81 fd 00 00 fd ff 77 32 e8 bb 29 a0 f8 90 <0f> 0b 90 eb 53 bf 01 00 00 00 89 ee e8 e9 2d a0 f8 85 ed 0f 8e b2
RSP: 0018:ffffc9000284f3b0 EFLAGS: 00010293
RAX: ffffffff891fdcd5 RBX: ffff888113587680 RCX: ffff88816e6f3a00
RDX: 0000000000000000 RSI: 000000006e1a2a10 RDI: 00000000fffd0001
RBP: 000000006e1a2a10 R08: ffff888113587767 R09: 1ffff110226b0eec
R10: dffffc0000000000 R11: ffffed10226b0eed R12: ffff888113587764
R13: dffffc0000000000 R14: 000000006e1d2a10 R15: 0000000000000000
FS:  000055558e11c500(0000) GS:ffff88818eb38000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000002280 CR3: 000000011053c000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 kfree_skb_reason include/linux/skbuff.h:1322 [inline]
 tcf_kfree_skb_list include/net/sch_generic.h:1127 [inline]
 __dev_xmit_skb net/core/dev.c:4258 [inline]
 __dev_queue_xmit+0x2669/0x3180 net/core/dev.c:4783
 packet_snd net/packet/af_packet.c:3076 [inline]
 packet_sendmsg+0x3e33/0x5080 net/packet/af_packet.c:3108
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 ____sys_sendmsg+0x505/0x830 net/socket.c:2630
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2684
 __sys_sendmsg net/socket.c:2716 [inline]
 __do_sys_sendmsg net/socket.c:2721 [inline]
 __se_sys_sendmsg net/socket.c:2719 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2719
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc1a7b8efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff4ba6d968 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fc1a7de5fa0 RCX: 00007fc1a7b8efc9
RDX: 0000000000000004 RSI: 00002000000000c0 RDI: 0000000000000007
RBP: 00007fc1a7c11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc1a7de5fa0 R14: 00007fc1a7de5fa0 R15: 0000000000000003
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

