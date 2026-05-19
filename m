Return-Path: <netdev+bounces-289433-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cH0XI8BQDGqTewUAu9opvQ
	(envelope-from <netdev+bounces-289433-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:00:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A9057E346
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 603743015CB7
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F5232FA2B;
	Tue, 19 May 2026 11:56:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FC9369D67
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191794; cv=none; b=d2FzB1jdQfiAoyyypKt83kVDip1dEVDOtp8sINtREH+ItkHmNDpeXadVN017rAMYdUpWwYX0d6zAeF9RUrxdcuYNzOs0DZ/6T68xQBrK+BnELYXxjEW0bysZBW+2ZzyjMV80uJtNgTiOHWQA/tbjf7k2QgUWxNm/H+Nt44dge0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191794; c=relaxed/simple;
	bh=WJ5Sw6D8NJsJhEDrj1lsIy3tKQKIgi3z1Dk+y/rLhU4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Z4XxRlqvoaX98UU2krohSpZrT8RwbfnnjxBpFUjiWaGP53RATdzGXe9CaqWBm/Q+WUTiMPUYQNVXo9vpY7VQHEIPmHXDrtvxNqqnlN8kVRNFc/RMiIg5naBPmRyn4NRQ8PSU2xW39Y5hLr1P/pGzu2ASr2vT62me2aWKs3gHREQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7dbd4fe0e15so10449440a34.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 04:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779191791; x=1779796591;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2VVq59w8SKCmlVgAE82mjBHR0ecjbO9Bce6Hoy/lt4o=;
        b=fP4J1SrOaFkEFr6jvKxDbqtECUUoGyfxFarkjbDq3qDm6zEZsdhhUy6BtOao3qLUql
         RgCTT9LoQg7VzISdjsUyzjB/dGGN5fodNFrVsmr9XX9x53fX5TtFmqKJb6yLEZLV3Dqj
         1yP/UunLVS9yICM+YnEjgoRcm6KQcDVIPEpqkjIv6m/XXTNBlitOZbOHzpvtqLS6UwHz
         d+QkrzRDp+jceDFv7uCcJRkX5BE0VyCfVkXYlEjy+/UIrnJxroq2BJHEIBYAKYE54lBY
         yL/6Dk3BuzKwp0xdBBUdkN87l4Eazvgqk1fcqjcisNqvQ3RF2I99hF2hPvZwk6jaLc6f
         zNUA==
X-Forwarded-Encrypted: i=1; AFNElJ+7Jzkl7jy2BXLhUiTAXLD/hecyQmluzxTh1QK2VLdfBzfJSn5fTRO2N1jbfGqQpEWjjIvB5xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU5h1vuCaFQppw9yFcSTgZR28nWbyhahgnvUGnKJBbqVBnNGkC
	Ge2tv+UveIA2n2HYHKlKR4cZdocujds1NQx+yuASAuUJ6fOEUL6dk/+USpDoR3kQk2LdNF7MgN9
	55rdGXcrkZg8nZt7atm2tdSyyJ2Z8E5YefPlnEHLeEu0Q9Ia15dBMEV4+L/Q=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:8c2:b0:694:9071:b622 with SMTP id
 006d021491bc7-69c9bfc7cacmr12427123eaf.52.1779191791565; Tue, 19 May 2026
 04:56:31 -0700 (PDT)
Date: Tue, 19 May 2026 04:56:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a0c4fef.170a0220.25463a.022d.GAE@google.com>
Subject: [syzbot] [net?] WARNING in netif_rx_mode_run
From: syzbot <syzbot+f2421634072a4b47071e@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=4caf64b1ee83dac0];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-289433-lists,netdev=lfdr.de,f2421634072a4b47071e];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,storage.googleapis.com:url,googlegroups.com:email,appspotmail.com:email]
X-Rspamd-Queue-Id: D7A9057E346
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    c8993263ffd3 bpf: Add Jiayuan Chen to sockmap maintainers
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=156e9bce580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4caf64b1ee83dac0
dashboard link: https://syzkaller.appspot.com/bug?extid=f2421634072a4b47071e
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=121aee36580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136e9bce580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bd0898114f61/disk-c8993263.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2b3988a1716d/vmlinux-c8993263.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eedc9b64bb9f/bzImage-c8993263.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f2421634072a4b47071e@syzkaller.appspotmail.com

RSP: 002b:00007ffde2b3c518 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fece9c15fa0 RCX: 00007fece999ce59
RDX: 0000200000000000 RSI: 0000000000008931 RDI: 0000000000000003
RBP: 00007ffde2b3c580 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fece9c15fac R14: 00007fece9c15fa0 R15: 00007fece9c15fa0
 </TASK>
------------[ cut here ]------------
netdevice: dummy0: failed to sync uc/mc addresses
WARNING: net/core/dev_addr_lists.c:1278 at netif_rx_mode_run+0xd55/0x1290 net/core/dev_addr_lists.c:1278, CPU#1: syz.0.17/5854
Modules linked in:
CPU: 1 UID: 0 PID: 5854 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
RIP: 0010:netif_rx_mode_run+0xe82/0x1290 net/core/dev_addr_lists.c:1278
Code: 3a 48 c7 c2 a0 ec dd 8c eb 1a e8 e9 8a 43 f8 48 c7 c2 20 eb dd 8c eb 0c e8 db 8a 43 f8 48 c7 c2 20 ec dd 8c 4c 89 f7 4c 89 fe <67> 48 0f b9 3a 48 8b 5c 24 38 48 8b 7c 24 48 e8 da be 29 02 42 c7
RSP: 0018:ffffc90002e2f9e0 EFLAGS: 00010293
RAX: ffffffff898241b7 RBX: 0000000000000001 RCX: ffff88802dcd5c40
RDX: ffffffff8cddeb20 RSI: ffff888025bb6120 RDI: ffffffff903fb9d0
RBP: ffffc90002e2fbb8 R08: ffff88802dcd5c40 R09: 0000000000000006
R10: 0000000000000005 R11: 0000000000000000 R12: ffff888025bb6120
R13: dffffc0000000000 R14: ffffffff903fb9d0 R15: ffff888025bb6120
FS:  000055556040b500(0000) GS:ffff888125388000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000000 CR3: 0000000033696000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 netif_rx_mode_sync+0x171/0x1e0 net/core/dev_addr_lists.c:1428
 dev_ifsioc+0xf51/0x1330 net/core/dev_ioctl.c:596
 dev_ioctl+0x7b4/0x1150 net/core/dev_ioctl.c:816
 sock_do_ioctl+0x23e/0x320 net/socket.c:1327
 sock_ioctl+0x5c6/0x7f0 net/socket.c:1434
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fece999ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffde2b3c518 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fece9c15fa0 RCX: 00007fece999ce59
RDX: 0000200000000000 RSI: 0000000000008931 RDI: 0000000000000003
RBP: 00007ffde2b3c580 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fece9c15fac R14: 00007fece9c15fa0 R15: 00007fece9c15fa0
 </TASK>
----------------
Code disassembly (best guess):
   0:	3a 48 c7             	cmp    -0x39(%rax),%cl
   3:	c2 a0 ec             	ret    $0xeca0
   6:	dd 8c eb 1a e8 e9 8a 	fisttpll -0x751617e6(%rbx,%rbp,8)
   d:	43 f8                	rex.XB clc
   f:	48 c7 c2 20 eb dd 8c 	mov    $0xffffffff8cddeb20,%rdx
  16:	eb 0c                	jmp    0x24
  18:	e8 db 8a 43 f8       	call   0xf8438af8
  1d:	48 c7 c2 20 ec dd 8c 	mov    $0xffffffff8cddec20,%rdx
  24:	4c 89 f7             	mov    %r14,%rdi
  27:	4c 89 fe             	mov    %r15,%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	48 8b 5c 24 38       	mov    0x38(%rsp),%rbx
  34:	48 8b 7c 24 48       	mov    0x48(%rsp),%rdi
  39:	e8 da be 29 02       	call   0x229bf18
  3e:	42                   	rex.X
  3f:	c7                   	.byte 0xc7


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

