Return-Path: <netdev+bounces-98135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 676EA8CFA02
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 09:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EDFE280EB0
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 07:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BB326AFF;
	Mon, 27 May 2024 07:24:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731CB225D9
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 07:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716794672; cv=none; b=IL3su1jxgsVxrFLh1INgPyslG0U+vACDfTpB/aNarwU7/W1bdOGcUg46WDDH+BRuUuMux5PUeO4YJIgWlQV+c/TGJIMlovm3CTaaam7nZPuA7eTtATfMP9QSVDIg2I8cLn+OhS57MjLm+RKP5alt4RWMBgD89mVccof3TmHsnH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716794672; c=relaxed/simple;
	bh=t1WMwtWHD1eE7edCg6VwTMBC5IohTUF4FgdcQgiJ7EM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cDpxFA8IKKNJqj8Gp5+YrUW/i7B2DrL7ibY4rDM15gDTa1jHz+feLB1IJ/oPS8r+UDdiDy9swT8hfb9l4W85CoB0E45IRVUYl1uofnibmlCy3cNl1hWjBVVcke7ai7Umgf65tHAXaxBYxE38STHowxp3jlC7g2csf1136Sj4wwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-36db3bbf931so55148105ab.0
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 00:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716794669; x=1717399469;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NWFUzUHCi9dLgq8/JAwYKdKMCUezO6W78gjgnHoq7Sk=;
        b=ubv8OqdqBYCxbrFkU2pjL8zri4SB6D3LnEQq1iMM+LwG5gJOsQPUPMJy02S/7Tijo/
         lcu63Fe0vQ5Z/uF7w16O8Wm5B2yHe6zzuqT/Qaz0tCnv1lOM/GSdFB8a8HXSaOEbbvzD
         C2/Te+JAiU/boD2EI+9tzfOQg4WAqJgjtCI/CRTmotcZCXoMYxKSNL3lR6bfhMaLxR83
         kQzYW697oB+/BnKG3CKAQbexNmBxrxsOK9sBDY69Xx12r6bAFuFLOeExQysnpMR52MNV
         C8kjcORg+Kv3KN6WC7eX/x7O1r+aTo/ohRBadibaX1K+7MEwwm7ajx5a7g5RFGG133NA
         63YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBg0eadHxmr9/iXwUEpd+SbNAm/J1O11TW3YlioOE5fqZRVmkfG7hxQz+uKI2Fb65SuijpvaA1o9tSClBBKpsCEyhXhOSl
X-Gm-Message-State: AOJu0YySg3BIeX/uhc3Z4q9qy2W5FNMwzIwd/FNcbe1w0YI3kR45BE4K
	gYeboGMORSqgxyJNB80jfHj7n3YDnEdq7gH3nYcjW+gUXkkA3q7MErdUW0GYMY5FDXGQTulQIuU
	O8BEciQil5txvHfgtyJ3y/ZgC0lT3xXm/l1RVSwnZldIQxhKZ6GTEWSc=
X-Google-Smtp-Source: AGHT+IF3zEtmKdKFUFfnTGXoZLon2AJbVRqW1PjJnTKM8yMkzNttssiBdckyMyd7m9o2FVSJ4BgtwCwJDissD+PY9rKN2iEZO1ED
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8a:b0:374:5b18:28c8 with SMTP id
 e9e14a558f8ab-3745b182b34mr1461115ab.3.1716794669715; Mon, 27 May 2024
 00:24:29 -0700 (PDT)
Date: Mon, 27 May 2024 00:24:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000070dbbd06196a68ea@google.com>
Subject: [syzbot] [wireguard?] general protection fault in wg_packet_receive
From: syzbot <syzbot+470d70be7e9ee9f22a01@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2a8120d7b482 Merge tag 's390-6.10-2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10263a34980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5dd4fde1337a9e18
dashboard link: https://syzkaller.appspot.com/bug?extid=470d70be7e9ee9f22a01
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2a8120d7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/78c72ae6bdaf/vmlinux-2a8120d7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/99dbb805b738/bzImage-2a8120d7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+470d70be7e9ee9f22a01@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc001ffff113: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: probably user-memory-access in range [0x00000000ffff8898-0x00000000ffff889f]
CPU: 0 PID: 10 Comm: kworker/0:1 Not tainted 6.9.0-syzkaller-10713-g2a8120d7b482 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: wg-kex-wg1 wg_packet_handshake_receive_worker
RIP: 0010:__lock_acquire+0xe3e/0x3b30 kernel/locking/lockdep.c:5005
Code: 11 00 00 39 05 b3 cf 1f 12 0f 82 be 05 00 00 ba 01 00 00 00 e9 e4 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f 85 82 1f 00 00 49 81 3c 24 a0 3d e3 92 0f 84 98 f2
RSP: 0018:ffffc90000007500 EFLAGS: 00010002

RAX: dffffc0000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 000000001ffff113 RSI: ffff888015f20000 RDI: 00000000ffff8898
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8fe29817 R11: 0000000000000004 R12: 00000000ffff8898
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88802c000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0016a3000 CR3: 000000005dcac000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 __queue_work+0x39e/0x1020 kernel/workqueue.c:2319
 queue_work_on+0x11a/0x140 kernel/workqueue.c:2410
 wg_packet_receive+0x13ea/0x2350 drivers/net/wireguard/receive.c:570
 wg_receive+0x74/0xc0 drivers/net/wireguard/socket.c:326
 udp_queue_rcv_one_skb+0xad1/0x18b0 net/ipv4/udp.c:2131
 udp_queue_rcv_skb+0x198/0xd10 net/ipv4/udp.c:2209
 udp_unicast_rcv_skb+0x165/0x3b0 net/ipv4/udp.c:2369
 __udp4_lib_rcv+0x2636/0x3550 net/ipv4/udp.c:2445
 ip_protocol_deliver_rcu+0x30c/0x4e0 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x316/0x570 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:314 [inline]
 NF_HOOK include/linux/netfilter.h:308 [inline]
 ip_local_deliver+0x18e/0x1f0 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:460 [inline]
 ip_rcv_finish net/ipv4/ip_input.c:449 [inline]
 NF_HOOK include/linux/netfilter.h:314 [inline]
 NF_HOOK include/linux/netfilter.h:308 [inline]
 ip_rcv+0x2c5/0x5d0 net/ipv4/ip_input.c:569
 __netif_receive_skb_one_core+0x199/0x1e0 net/core/dev.c:5624
 __netif_receive_skb+0x1d/0x160 net/core/dev.c:5738
 process_backlog+0x133/0x760 net/core/dev.c:6067
 __napi_poll.constprop.0+0xb7/0x550 net/core/dev.c:6721
 napi_poll net/core/dev.c:6790 [inline]
 net_rx_action+0x9b6/0xf10 net/core/dev.c:6906
 handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
 do_softirq kernel/softirq.c:455 [inline]
 do_softirq+0xb2/0xf0 kernel/softirq.c:442
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x100/0x120 kernel/softirq.c:382
 wg_socket_send_skb_to_peer+0x14c/0x220 drivers/net/wireguard/socket.c:184
 wg_socket_send_buffer_to_peer+0x12b/0x190 drivers/net/wireguard/socket.c:200
 wg_packet_send_handshake_response+0x297/0x310 drivers/net/wireguard/send.c:103
 wg_receive_handshake_packet+0x248/0xbf0 drivers/net/wireguard/receive.c:154
 wg_packet_handshake_receive_worker+0x17f/0x3a0 drivers/net/wireguard/receive.c:213
 process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0xe3e/0x3b30 kernel/locking/lockdep.c:5005
Code: 11 00 00 39 05 b3 cf 1f 12 0f 82 be 05 00 00 ba 01 00 00 00 e9 e4 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f 85 82 1f 00 00 49 81 3c 24 a0 3d e3 92 0f 84 98 f2
RSP: 0018:ffffc90000007500 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 000000001ffff113 RSI: ffff888015f20000 RDI: 00000000ffff8898
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8fe29817 R11: 0000000000000004 R12: 00000000ffff8898
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88802c000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0016a3000 CR3: 000000005dcac000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	11 00                	adc    %eax,(%rax)
   2:	00 39                	add    %bh,(%rcx)
   4:	05 b3 cf 1f 12       	add    $0x121fcfb3,%eax
   9:	0f 82 be 05 00 00    	jb     0x5cd
   f:	ba 01 00 00 00       	mov    $0x1,%edx
  14:	e9 e4 00 00 00       	jmp    0xfd
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	4c 89 e2             	mov    %r12,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 82 1f 00 00    	jne    0x1fb6
  34:	49 81 3c 24 a0 3d e3 	cmpq   $0xffffffff92e33da0,(%r12)
  3b:	92
  3c:	0f                   	.byte 0xf
  3d:	84                   	.byte 0x84
  3e:	98                   	cwtl
  3f:	f2                   	repnz


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

