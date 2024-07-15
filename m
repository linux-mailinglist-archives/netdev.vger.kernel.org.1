Return-Path: <netdev+bounces-111519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF0E9316B3
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 16:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5DD71F219C0
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 14:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217C618EFE4;
	Mon, 15 Jul 2024 14:28:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DB818EA91
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053709; cv=none; b=ftF+FnOZ6Of/AWuE0Sn9n3agzwpv+HxYzxa4iD8eolA+iOno0C9J/bXUyWfVmx5OEBSczcyo5cpVZpYXfM/Aw6TnCSODR1wrX2zpC1hj+G7arf1bTJwJJN9KfX4tUPQOiTTqd5hCxdQFvITFoZ32lwJKNOImMY2NoyJKxB9iEz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053709; c=relaxed/simple;
	bh=Nz5E4d8xdCYlAzvXJoX1t5TkTVnajK8GmE4FzW/DTJk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cD3TnVNNiK4iRIXfWYUtXGoMk20XARR6NV90B7iti7DvFXfE++A6Ys5tUn7i1NFkaXMEnrXZ1r9M6QcL5qUR7hT1zmdwRRphUbPegN9yoYYDQoWGtV4N7Mk+gNp3TK9DobZ0vvXMFLc/VkBDECc59DQSVlmkrfAwXwV+a+NxEHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8048edd8993so479779439f.0
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 07:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721053706; x=1721658506;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IR0zuY3FALGpcWvHyYpjsZ+HMUPt8PRIglRtf9AhPso=;
        b=oE4dRu0EQRzmyLg+KhnaSuLjfgs8DAB6awAlwPrnOQiyt3FOEnrhrPjbsIx/O3ecui
         WUOKd4j5J/+umwx1By3n1KxW3KQV9cEsWgwTlV3F43t6PPNjIThpPz2v5LdqBHS647dv
         GRCuDaJxmpYCiP27SPTNM1E+dll3KpvcC3e1KlkFYqEb26D4YHiW2EwiuGGW79eV5P0P
         d+C7UkmDRUwTij0fE2M2R9+9tEmdCS2yxzmkAvXtbKwQ6qwlnqR6pHLzOdcZad4+H35t
         m3qRAmafxP3SMrhFnhwMYCWDAK4a560c0dONMTeBwDocNJc/rJbxYr2lCJRXfjLvkx94
         eFcw==
X-Forwarded-Encrypted: i=1; AJvYcCW050nR74LF9W1iFAGXvOQjvTrdBsXV/abAC5RivzivDS4iyS7pyY7XM/fM5PVIQHRJFp7fLkXvgYO5ifiXQkW4UxTwXdDU
X-Gm-Message-State: AOJu0Yxp1d+XbEtNW4KW6Wpy6U6jFIepRJvpG0yPTfZ99Zv3S5cLwzRV
	ao9vKUTaRKxOat/8GUJNzqUy2WKs1ALut3JepwJgTuR9ePUKVctM14Y2OGa2A0mQNdmvf2YM4nQ
	kKw5fxx7DgcqVRxpji2BaD0sa32mQ2aV2NvJNsVUo9DhAoE5csaZuHmk=
X-Google-Smtp-Source: AGHT+IGeec/8lJVCadA9XLMLVNYgpfoMlE9cCTA5P2vddsZilbVjfk5WlJbB4KJ0I2Lf+Za7HdlZR10jdW0jx7pbwIaoB9pZkwCk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6403:b0:7f8:c159:fec2 with SMTP id
 ca18e2360f4ac-800050cc601mr122279339f.4.1721053706570; Mon, 15 Jul 2024
 07:28:26 -0700 (PDT)
Date: Mon, 15 Jul 2024 07:28:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d1dd99061d4a0af4@google.com>
Subject: [syzbot] [mptcp?] WARNING in __mptcp_move_skbs_from_subflow
From: syzbot <syzbot+d1bff73460e33101f0e7@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martineau@kernel.org, 
	matttbe@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d0d0cd380055 Merge tag '6.10-rc7-smb3-client-fix' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1320b879980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84344463c2ebf8a1
dashboard link: https://syzkaller.appspot.com/bug?extid=d1bff73460e33101f0e7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-d0d0cd38.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/501bce8ef014/vmlinux-d0d0cd38.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8cca4ce21aed/bzImage-d0d0cd38.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d1bff73460e33101f0e7@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 20604 at net/mptcp/protocol.c:693 __mptcp_move_skbs_from_subflow+0x1677/0x2500 net/mptcp/protocol.c:693
Modules linked in:
CPU: 0 PID: 20604 Comm: syz.3.4228 Not tainted 6.10.0-rc7-syzkaller-00256-gd0d0cd380055 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__mptcp_move_skbs_from_subflow+0x1677/0x2500 net/mptcp/protocol.c:693
Code: 85 04 0e 00 00 c6 43 7f 00 e9 fd ef ff ff e8 b0 e4 d0 f6 90 0f 0b 90 e9 d0 f0 ff ff 4c 8b ac 24 90 00 00 00 e8 9a e4 d0 f6 90 <0f> 0b 90 e9 ae f2 ff ff e8 8c e4 d0 f6 90 0f 0b 90 e9 28 eb ff ff
RSP: 0018:ffffc90000007498 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000000000081e5 RCX: ffffffff8abd9c87
RDX: ffff88801ed74880 RSI: ffffffff8abdaa86 RDI: 0000000000000004
RBP: 00000000000055f0 R08: 0000000000000004 R09: 00000000000081e5
R10: 00000000000055f0 R11: 0000000000000007 R12: ffff88805b1ce2e8
R13: ffffc900000075c0 R14: ffff88805b1ce200 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88802c000000(0063) knlGS:00000000f5d5fb40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000020287000 CR3: 000000001c02c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 move_skbs_to_msk net/mptcp/protocol.c:809 [inline]
 mptcp_data_ready+0x2c5/0x960 net/mptcp/protocol.c:854
 subflow_data_ready+0x51d/0x7d0 net/mptcp/subflow.c:1465
 tcp_data_ready+0x146/0x5b0 net/ipv4/tcp_input.c:5177
 tcp_data_queue+0x1a6f/0x5270 net/ipv4/tcp_input.c:5267
 tcp_rcv_established+0x8e9/0x21b0 net/ipv4/tcp_input.c:6210
 tcp_v4_do_rcv+0x707/0xab0 net/ipv4/tcp_ipv4.c:1909
 tcp_v4_rcv+0x2eb4/0x3c00 net/ipv4/tcp_ipv4.c:2345
 ip_protocol_deliver_rcu+0xba/0x4e0 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x316/0x570 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:314 [inline]
 NF_HOOK include/linux/netfilter.h:308 [inline]
 ip_local_deliver+0x18e/0x1f0 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:460 [inline]
 ip_rcv_finish net/ipv4/ip_input.c:449 [inline]
 NF_HOOK include/linux/netfilter.h:314 [inline]
 NF_HOOK include/linux/netfilter.h:308 [inline]
 ip_rcv+0x2c5/0x5d0 net/ipv4/ip_input.c:569
 __netif_receive_skb_one_core+0x199/0x1e0 net/core/dev.c:5625
 __netif_receive_skb+0x1d/0x160 net/core/dev.c:5739
 process_backlog+0x133/0x760 net/core/dev.c:6068
 __napi_poll.constprop.0+0xb7/0x550 net/core/dev.c:6722
 napi_poll net/core/dev.c:6791 [inline]
 net_rx_action+0x9b6/0xf10 net/core/dev.c:6907
 handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
 do_softirq kernel/softirq.c:455 [inline]
 do_softirq+0xb2/0xf0 kernel/softirq.c:442
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x100/0x120 kernel/softirq.c:382
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:851 [inline]
 __dev_queue_xmit+0x872/0x4130 net/core/dev.c:4420
 dev_queue_xmit include/linux/netdevice.h:3095 [inline]
 neigh_hh_output include/net/neighbour.h:526 [inline]
 neigh_output include/net/neighbour.h:540 [inline]
 ip_finish_output2+0x16bf/0x2590 net/ipv4/ip_output.c:235
 __ip_finish_output net/ipv4/ip_output.c:313 [inline]
 __ip_finish_output+0x49e/0x950 net/ipv4/ip_output.c:295
 ip_finish_output+0x31/0x310 net/ipv4/ip_output.c:323
 NF_HOOK_COND include/linux/netfilter.h:303 [inline]
 ip_output+0x13b/0x2a0 net/ipv4/ip_output.c:433
 dst_output include/net/dst.h:450 [inline]
 ip_local_out+0x33e/0x4a0 net/ipv4/ip_output.c:129
 __ip_queue_xmit+0x747/0x1940 net/ipv4/ip_output.c:535
 __tcp_transmit_skb+0x29c1/0x3da0 net/ipv4/tcp_output.c:1466
 tcp_transmit_skb net/ipv4/tcp_output.c:1484 [inline]
 tcp_mtu_probe net/ipv4/tcp_output.c:2546 [inline]
 tcp_write_xmit+0x83f4/0x87e0 net/ipv4/tcp_output.c:2751
 __tcp_push_pending_frames+0xaf/0x390 net/ipv4/tcp_output.c:3014
 tcp_push_pending_frames include/net/tcp.h:2102 [inline]
 tcp_data_snd_check net/ipv4/tcp_input.c:5693 [inline]
 tcp_rcv_established+0x972/0x21b0 net/ipv4/tcp_input.c:6212
 tcp_v4_do_rcv+0x707/0xab0 net/ipv4/tcp_ipv4.c:1909
 sk_backlog_rcv include/net/sock.h:1106 [inline]
 __release_sock+0x31b/0x400 net/core/sock.c:2983
 release_sock+0x5a/0x220 net/core/sock.c:3549
 __mptcp_push_pending+0x400/0x560 net/mptcp/protocol.c:1623
 mptcp_sendmsg+0xce5/0x1f20 net/mptcp/protocol.c:1901
 inet_sendmsg+0x119/0x140 net/ipv4/af_inet.c:853
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x42c/0x4e0 net/socket.c:2192
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __ia32_sys_sendto+0xdd/0x1b0 net/socket.c:2200
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7447579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5d5f57c EFLAGS: 00000292 ORIG_RAX: 0000000000000171
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00000000200000c0
RDX: 00000000fffffe44 RSI: 0000000004000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

