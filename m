Return-Path: <netdev+bounces-298717-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kR5aGgsyLGrKNQQAu9opvQ
	(envelope-from <netdev+bounces-298717-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:21:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B86F967AD75
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:21:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298717-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298717-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D99B732F4FE2
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9673B1002;
	Fri, 12 Jun 2026 16:19:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22F03A75B8
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 16:19:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781281174; cv=none; b=e82Lj9zsmZL9YvWLDWCpn1+OcNln7QrspEv7ejAtzsntPdxwzlAG6TmwZSNKZhkR2xODj7JpK9SmGBCk2/Tp1jY/NxHLjk5/2EhNH2TVh0mkrypCyDw/nIfnMRyXLig37sAWxZuW+XlvYcs9x9piqRnrko5cEMquj7X9obqAW7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781281174; c=relaxed/simple;
	bh=xG1b5RA5EjTwuo0QEPDrP5P00DN3AHw4OltefDv/Zl0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TbHG6MJUTYIkObcdXavxBf9A/YJotlffSBFkqGRVlVvfrEdG325LKPhGz5Sg+iLwjGGFVEr1btYq8NIPkPboBGymhRkPfFNil/MtQZdEfmN2Sjc7yl0DACnnJFpwGNC0kOwsY2H6aJHUZ6lLZmzZWGxcwrP1n0JMTiQutreze7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-4863a0c3105so1663801b6e.3
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 09:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781281172; x=1781885972;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V1N2V6o2n8ONSn3aBAQVinhsAGOzj30etEFz/nPGQw8=;
        b=Jtbn6c7B67R0ljBRzvquD0Gj4p5/RDAoMLCSYKKkdaxk/o+rVLf5Zl1YfhDHhLOiCg
         ldC01HoTubrXnM7/HcbZX3giGmdrukuB131Ele+CYQzYvv37lbgwZqTzIbrDhPNEK+W6
         VIzRJ+7boxvdoRaV6QCWYQ693XlReldcp8cMHoW8uxIylaHXuCmZCZq0urSX20tZYLdi
         QGV65ZnqzSqJq3fNdoPCJYZPh8NeKNE3mhcawljuo/Km2FcDcjKYfLAz2QryGDdXI+Un
         LIvvsiR7cLChbBQ/ejft3jwhqcFgdqrliow4si7pceUtyoO+TpGAWEpReSF6JRqrahiE
         J+rQ==
X-Forwarded-Encrypted: i=1; AFNElJ+cdFcFxOs/g/EAHBvxzLBRdJBT5hOO17YR2+amiDHSdbyGy6bCjXgiVRgji8KQHC4cjwLlLw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPMOeQZ8lDAUtQc+IclIU2dYtW96aERFptEZfpbBrKjtl2jxoT
	2nCciuEPfpoIMGL9MM/aZDouyf/GgWo8tBv2lParKtn5FbzL8Nna5oIB3/pgMuFpoY1oOhrjXXr
	jpzL6JzFF38XQ3cNMLbq8sDiMtmFhfbbjll0Y3zm34l+RaQFf1DIg4BzBMt8=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:221c:b0:479:d779:353e with SMTP id
 5614622812f47-4872f4a088amr2276021b6e.24.1781281171885; Fri, 12 Jun 2026
 09:19:31 -0700 (PDT)
Date: Fri, 12 Jun 2026 09:19:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a2c3193.8812e0fc.3c3fa4.0001.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in skb_segment (5)
From: syzbot <syzbot+ebdb22d461c904fc3cb2@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, ncardwell@google.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=e3161cabe5a361ff];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298717-lists,netdev=lfdr.de,ebdb22d461c904fc3cb2];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:horms@kernel.org,m:kuba@kernel.org,m:kuniyu@google.com,m:linux-kernel@vger.kernel.org,m:ncardwell@google.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,googlegroups.com:email,goo.gl:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,storage.googleapis.com:url,appspotmail.com:email];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B86F967AD75

Hello,

syzbot found the following issue on:

HEAD commit:    e7aa57247700 Merge tag 'spi-fix-v6.19-rc8' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d69402580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3161cabe5a361ff
dashboard link: https://syzkaller.appspot.com/bug?extid=ebdb22d461c904fc3cb2
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8243bfd07948/disk-e7aa5724.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/65477df56f75/vmlinux-e7aa5724.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0674f6c7c67d/bzImage-e7aa5724.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ebdb22d461c904fc3cb2@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000e: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
CPU: 0 UID: 0 PID: 21038 Comm: syz.4.3937 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/24/2026
RIP: 0010:skb_segment+0x2ac4/0x3f80 net/core/skbuff.c:4848
Code: 00 00 00 8b 6c 24 58 81 7c 24 14 ff ff 00 00 0f 85 1c e1 ff ff e8 ec d1 60 f8 48 8b 44 24 20 48 8d 58 70 48 89 d8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 0f 85 14 09 00 00 8b 1b e9 21 e1 ff ff e8 c3
RSP: 0018:ffffc90000006230 EFLAGS: 00010202
RAX: 000000000000000e RBX: 0000000000000070 RCX: ffff88801bb88000
RDX: 0000000000000100 RSI: ffff888049e648ee RDI: 000000000000ffff
RBP: 0000000000000003 R08: ffff88801bb88000 R09: 0000000000000002
R10: 000000000000a888 R11: 0000000000000100 R12: ffff888049e648e0
R13: 00000000fffffff8 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007f1163fb46c0(0000) GS:ffff8881256f3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000290000 CR3: 000000002805e000 CR4: 00000000003526f0
DR0: 0000000000000008 DR1: 0000000000000002 DR2: 0000000000000404
DR3: ffffffffefffff14 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 tcp_gso_segment+0x424/0x1a40 net/ipv4/tcp_offload.c:181
 ipv6_gso_segment+0xb80/0x2200 net/ipv6/ip6_offload.c:154
 skb_mac_gso_segment+0x325/0x650 net/core/gso.c:53
 __skb_gso_segment+0x376/0x540 net/core/gso.c:124
 skb_gso_segment include/net/gso.h:83 [inline]
 validate_xmit_skb+0xa13/0x1440 net/core/dev.c:4018
 validate_xmit_skb_list+0x84/0x120 net/core/dev.c:4068
 sch_direct_xmit+0xdf/0x4c0 net/sched/sch_generic.c:332
 qdisc_restart net/sched/sch_generic.c:412 [inline]
 __qdisc_run+0xa8d/0x1540 net/sched/sch_generic.c:420
 qdisc_run include/net/pkt_sched.h:120 [inline]
 __dev_xmit_skb net/core/dev.c:4265 [inline]
 __dev_queue_xmit+0x1bbe/0x3850 net/core/dev.c:4798
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip6_output+0x340/0x550 net/ipv6/ip6_output.c:247
 NF_HOOK include/linux/netfilter.h:318 [inline]
 ip6_xmit+0x120f/0x19d0 net/ipv6/ip6_output.c:371
 inet6_csk_xmit+0x4a5/0x750 net/ipv6/inet6_connection_sock.c:120
 __tcp_transmit_skb+0x20b6/0x3ad0 net/ipv4/tcp_output.c:1631
 tcp_transmit_skb net/ipv4/tcp_output.c:1649 [inline]
 tcp_write_xmit+0x16e8/0x6980 net/ipv4/tcp_output.c:3002
 __tcp_push_pending_frames+0x97/0x380 net/ipv4/tcp_output.c:3185
 tcp_push_pending_frames include/net/tcp.h:2224 [inline]
 tcp_data_snd_check net/ipv4/tcp_input.c:5896 [inline]
 tcp_rcv_established+0xfee/0x25b0 net/ipv4/tcp_input.c:6476
 tcp_v6_do_rcv+0x8eb/0x1ba0 net/ipv6/tcp_ipv6.c:1607
 tcp_v6_rcv+0x2811/0x3110 net/ipv6/tcp_ipv6.c:1877
 ip6_protocol_deliver_rcu+0xa73/0x1600 net/ipv6/ip6_input.c:438
 ip6_input_finish+0x191/0x370 net/ipv6/ip6_input.c:489
 NF_HOOK+0x336/0x3c0 include/linux/netfilter.h:318
 ip6_input+0x16a/0x270 net/ipv6/ip6_input.c:500
 NF_HOOK+0x336/0x3c0 include/linux/netfilter.h:318
 __netif_receive_skb_one_core net/core/dev.c:6152 [inline]
 __netif_receive_skb net/core/dev.c:6265 [inline]
 process_backlog+0x7dd/0x1950 net/core/dev.c:6617
 __napi_poll+0xae/0x340 net/core/dev.c:7681
 napi_poll net/core/dev.c:7744 [inline]
 net_rx_action+0x627/0xf70 net/core/dev.c:7896
 handle_softirqs+0x22a/0x7c0 kernel/softirq.c:622
 do_softirq+0x76/0xd0 kernel/softirq.c:523
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xf8/0x130 kernel/softirq.c:450
 sk_wait_data+0x20e/0x4d0 net/core/sock.c:3264
 tcp_recvmsg_locked+0xd71/0x35b0 net/ipv4/tcp.c:2776
 tcp_recvmsg+0x213/0x7f0 net/ipv4/tcp.c:2927
 inet6_recvmsg+0x13e/0x6c0 net/ipv6/af_inet6.c:678
 sock_recvmsg_nosec net/socket.c:1078 [inline]
 sock_recvmsg+0x105/0x270 net/socket.c:1100
 __sys_recvfrom+0x240/0x3c0 net/socket.c:2256
 __do_sys_recvfrom net/socket.c:2271 [inline]
 __se_sys_recvfrom net/socket.c:2267 [inline]
 __x64_sys_recvfrom+0xde/0x100 net/socket.c:2267
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1165d9aeb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1163fb4028 EFLAGS: 00000246 ORIG_RAX: 000000000000002d
RAX: ffffffffffffffda RBX: 00007f1166016180 RCX: 00007f1165d9aeb9
RDX: fffffffffffffd0b RSI: 0000200000000080 RDI: 0000000000000006
RBP: 00007f1165e08c1f R08: 0000000000000000 R09: fffffffffffffd25
R10: 00000000c9100120 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1166016218 R14: 00007f1166016180 R15: 00007f116613fa48
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:skb_segment+0x2ac4/0x3f80 net/core/skbuff.c:4848
Code: 00 00 00 8b 6c 24 58 81 7c 24 14 ff ff 00 00 0f 85 1c e1 ff ff e8 ec d1 60 f8 48 8b 44 24 20 48 8d 58 70 48 89 d8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 0f 85 14 09 00 00 8b 1b e9 21 e1 ff ff e8 c3
RSP: 0018:ffffc90000006230 EFLAGS: 00010202
RAX: 000000000000000e RBX: 0000000000000070 RCX: ffff88801bb88000
RDX: 0000000000000100 RSI: ffff888049e648ee RDI: 000000000000ffff
RBP: 0000000000000003 R08: ffff88801bb88000 R09: 0000000000000002
R10: 000000000000a888 R11: 0000000000000100 R12: ffff888049e648e0
R13: 00000000fffffff8 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007f1163fb46c0(0000) GS:ffff8881256f3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000290000 CR3: 000000002805e000 CR4: 00000000003526f0
DR0: 0000000000000008 DR1: 0000000000000002 DR2: 0000000000000404
DR3: ffffffffefffff14 DR6: 00000000ffff0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	00 00                	add    %al,(%rax)
   2:	8b 6c 24 58          	mov    0x58(%rsp),%ebp
   6:	81 7c 24 14 ff ff 00 	cmpl   $0xffff,0x14(%rsp)
   d:	00
   e:	0f 85 1c e1 ff ff    	jne    0xffffe130
  14:	e8 ec d1 60 f8       	call   0xf860d205
  19:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
  1e:	48 8d 58 70          	lea    0x70(%rax),%rbx
  22:	48 89 d8             	mov    %rbx,%rax
  25:	48 c1 e8 03          	shr    $0x3,%rax
* 29:	42 0f b6 04 38       	movzbl (%rax,%r15,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 14 09 00 00    	jne    0x94a
  36:	8b 1b                	mov    (%rbx),%ebx
  38:	e9 21 e1 ff ff       	jmp    0xffffe15e
  3d:	e8                   	.byte 0xe8
  3e:	c3                   	ret


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

