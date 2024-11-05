Return-Path: <netdev+bounces-141802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B4F9BC45F
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 05:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82391F21D69
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 04:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F33156F45;
	Tue,  5 Nov 2024 04:33:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFA6286A1
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 04:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730781203; cv=none; b=psvuLKzhpwuHCN0P3b5mOADI/I1o7AV8fa9EMCz9/J/K01MuEjmvB1TnSmFGVn7CyJIwIvmPiuwXA26/8aZLNccVbsCW1+Y4tgt2nG2tfR+03cUUQQEskTctFWj2+pqSIbIjZn4dgtYBKx7e0EQM+0ls9opu8WxeRX3t/mfiwyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730781203; c=relaxed/simple;
	bh=VOcYgorph87rNniZ/urBQKYFW61UsZGc5avEJffLTUk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=F8vohEl4HU6q9KLhx0SGdL10sjYqVmoF0TNmetkxpN8zjvBZA/Ne7/GEDRDdtN0w2zUSRcbJo+ltnuS8ffMKhUN705TfqX5N5PIqdLQNqaTBokS7pZOxG9QAwE2bEsgLkuvgax5ZRGUmPxPg3FKlzAXSXswGaTwV2TbG23v8QAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3b9c5bcd8so51451585ab.2
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 20:33:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730781201; x=1731386001;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Dv5h/ThRRiN4Q9Yjm2/1X9R+DjHG+sT4aBxlPqHf3Q=;
        b=U5fNo495XEZ6L6CWm1bYE8Xz1JdtZKkh+2koRlR/9oK0ZhMUe7kJ+h5QhxdGNxmz6q
         fJqV70qVsZkxEkGx3b5N8yGceCkCcSL0/1HfoPU/ZMJE9bDdvPDWRubpFXgo05AZ0RiP
         d0lg/VmXjfq6eF/8+ThFGAwyg0K6LQ+8gHNSfSxCTUN2x2nH+sukr1Yq/tIB4Cc725MW
         W0bvXxRszIaXsuuOhINX2iauH8R0Bbobvm4Lg4P8jNytt0ijRK5B4vHrYBcGP1pFm7LM
         HRPdB4+K0q69Ncmfxv6xV3GD3zR8mvp47uM86lpjJQrbRn7dIGpc9/7lPdozIvKKGdLL
         d7ow==
X-Forwarded-Encrypted: i=1; AJvYcCX8Q/XLTVa93APEb5YCrdSQ3ISK1QzKPjHaoB7HOwiJwqlcvlLmuk8BnBkPIK9vBk3ei7LtkWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4LHJEFnN9y6eYWLwqPprGknHbX6qDaXzmUxRzhvP7gDPpNndK
	+Dfegi7WaDvTVAXNv9az5YJ5KNMMM+QPR0H6UzLG8e776zy5t0x0uNXuG1hFuJBhDX4lUhS9xpp
	LDLFI10523zAzx0GdseACWLrj7KxG8z/Xh4xg5tLfqYw//rt5xUvVuDw=
X-Google-Smtp-Source: AGHT+IGGFyZlL39ODOGwf3LiveBZx19fylBuDdYyIGzcVrM++9hNgfQLjX/UEhF4ljfiM5ajnINdq4/xKq4boJuh5kx6d6zDfKBj
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3281:b0:3a6:c84f:9357 with SMTP id
 e9e14a558f8ab-3a6c84f97b3mr70739545ab.25.1730781201465; Mon, 04 Nov 2024
 20:33:21 -0800 (PST)
Date: Mon, 04 Nov 2024 20:33:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6729a011.050a0220.2edce.1501.GAE@google.com>
Subject: [syzbot] [net?] WARNING in geneve_udp_encap_recv
From: syzbot <syzbot+c28dd30bc14158282b3b@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    90602c251cda Merge tag 'net-6.12-rc6' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16519340580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4340261e4e9f37fc
dashboard link: https://syzkaller.appspot.com/bug?extid=c28dd30bc14158282b3b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-90602c25.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6a2daa3dcb25/vmlinux-90602c25.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4488ee6eec29/bzImage-90602c25.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c28dd30bc14158282b3b@syzkaller.appspotmail.com

memcpy: detected field-spanning write (size 4) of single field "_Generic(info, const struct ip_tunnel_info * : ((const void *)((info) + 1)), struct ip_tunnel_info * : ((void *)((info) + 1)) )" at include/net/ip_tunnels.h:653 (size 0)
WARNING: CPU: 3 PID: 34 at include/net/ip_tunnels.h:653 ip_tunnel_info_opts_set include/net/ip_tunnels.h:653 [inline]
WARNING: CPU: 3 PID: 34 at include/net/ip_tunnels.h:653 geneve_rx drivers/net/geneve.c:244 [inline]
WARNING: CPU: 3 PID: 34 at include/net/ip_tunnels.h:653 geneve_udp_encap_recv+0x22cd/0x29a0 drivers/net/geneve.c:401
Modules linked in:
CPU: 3 UID: 0 PID: 34 Comm: ksoftirqd/3 Not tainted 6.12.0-rc5-syzkaller-00161-g90602c251cda #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ip_tunnel_info_opts_set include/net/ip_tunnels.h:653 [inline]
RIP: 0010:geneve_rx drivers/net/geneve.c:244 [inline]
RIP: 0010:geneve_udp_encap_recv+0x22cd/0x29a0 drivers/net/geneve.c:401
Code: 9e e9 ff ff e8 24 ca 53 fb c6 05 c4 65 0e 0a 01 90 31 c9 48 c7 c2 e0 3e 14 8c 4c 89 e6 48 c7 c7 c0 3f 14 8c e8 c4 b9 14 fb 90 <0f> 0b 90 90 e9 c7 ed ff ff e8 f5 c9 53 fb e8 80 8c c9 02 31 ff 41
RSP: 0018:ffffc900008df630 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888060da0f32 RCX: ffffffff814e6dd9
RDX: ffff88801e294880 RSI: ffffffff814e6de6 RDI: 0000000000000001
RBP: ffffc900008df750 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000004
R13: ffff888032d57c00 R14: 0000000000000000 R15: ffff88804583ef00
FS:  0000000000000000(0000) GS:ffff88806a900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd1e8385f98 CR3: 000000004b406000 CR4: 0000000000352ef0
DR0: 00000000e0002800 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 udp_queue_rcv_one_skb+0xad5/0x18c0 net/ipv4/udp.c:2135
 udp_queue_rcv_skb+0x198/0xd10 net/ipv4/udp.c:2213
 udp_unicast_rcv_skb+0x165/0x3b0 net/ipv4/udp.c:2373
 __udp4_lib_rcv+0x25fd/0x34e0 net/ipv4/udp.c:2449
 ip_protocol_deliver_rcu+0x2ff/0x4c0 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x316/0x570 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:314 [inline]
 NF_HOOK include/linux/netfilter.h:308 [inline]
 ip_local_deliver+0x18e/0x1f0 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:460 [inline]
 ip_rcv_finish net/ipv4/ip_input.c:449 [inline]
 NF_HOOK include/linux/netfilter.h:314 [inline]
 NF_HOOK include/linux/netfilter.h:308 [inline]
 ip_rcv+0x2c3/0x5d0 net/ipv4/ip_input.c:569
 __netif_receive_skb_one_core+0x199/0x1e0 net/core/dev.c:5670
 __netif_receive_skb+0x1d/0x160 net/core/dev.c:5783
 process_backlog+0x443/0x15f0 net/core/dev.c:6115
 __napi_poll.constprop.0+0xb7/0x550 net/core/dev.c:6779
 napi_poll net/core/dev.c:6848 [inline]
 net_rx_action+0xa92/0x1010 net/core/dev.c:6970
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:554
 run_ksoftirqd kernel/softirq.c:927 [inline]
 run_ksoftirqd+0x3a/0x60 kernel/softirq.c:919
 smpboot_thread_fn+0x661/0xa30 kernel/smpboot.c:164
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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

