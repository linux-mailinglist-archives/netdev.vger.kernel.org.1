Return-Path: <netdev+bounces-258671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCfdHs2Ej2mRRQEAu9opvQ
	(envelope-from <netdev+bounces-258671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 21:08:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C59B139512
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 21:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B60173027DB7
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 20:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8689C258CE5;
	Fri, 13 Feb 2026 20:08:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB3F2264A8
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 20:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771013320; cv=none; b=Qh9pKNlv8zR7+HJZCoiFGUnZ8NHZ8QmSNVbcDHv+IwK1QvfNOPpE8q+l7KE2uqfNyOxk2BL4fgdfBGy+roFAaVdgP1OByGCqpjC39Y5Q4N+58Uuk8Lq8lpzYZoD5sJlnEQmSYcqgtIARArStXKaa9q5Y5CHIxYTENcA0FVlZHPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771013320; c=relaxed/simple;
	bh=bZSP6V9g5g+qprZyGJmiB7+Lw0gCpkUdsfLlJnZ+NFs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=u1PGWyMkRUCoAiVGj9Ga8ErFx5QHkghPgkWGxDqarPZKk67jQyHci4E867U15Kaeo/jZX4bozxCCSSQW30XXQQy2y4sWsHpZD5i64gSSuXtOVPH/R/cRdQ7TsRnyKbqBpaXQsH2L/Oikk9AmlnvesLXf4qGcXs+qWXYm0iFHpuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-66304fd62ebso11770459eaf.3
        for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 12:08:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771013318; x=1771618118;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0V7FdcC+V6f1rmRIkiWlvNKW04owJrAfo7ISDL37uvg=;
        b=pK+nmQCMMykpBmBmPa/fPQkcgPMv0Dzspw+4UBfLKDbx2sMT+ye09/zDROajOZHpM9
         57TxBz2t0qx5WLJKS7sdV8u3Y/9ZQc8sgdtq4vaxYWTFFmcDZVmDo2Qfb4sIEgXS7Mop
         ihMp1vd7Oc7B8ZxQBeZrQqzOqOXHyBInwm86Uzkq+oSBOQnYcrkScBti2SFXn+QxdonW
         kOGBJwDnPcITXGzJdKXWKYivFDYHF8Ym6mQtpI6Y+2HBHc3UiKhGdEQv9v+oi4otDUfn
         /MFLjxTZbCzWKjRTSTYAQslzqwm7eU+yGORPnnYqeNVTq1Itp22BMB9t5u7OdqT/4s4j
         P9YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh/wCu+vIqDOSN07JMWV4vTtNNiBPyDKNV0DzOJkHdh2rRM2zpFQuFeJfrnR/8FKAqU9RUGjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/KNoJCbl7NiWbXEQUpXH39s2jLvva4W1ETPLznAKIHfbLKOfh
	W9EEJcKlVhPZfihgiwgvnQRylU/aKJyoZmZA1xkKkwAmOE+5UlBW63NfLCqrHQUohQ+Tsv3SGKg
	nfbMlMDpFW2z/4jFR+YD6qMAhkGt70hvd5xRb0YEVMC455MnKMV76/EIsxRk=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4910:b0:675:a193:b9a7 with SMTP id
 006d021491bc7-67763a435aemr1158967eaf.0.1771013318418; Fri, 13 Feb 2026
 12:08:38 -0800 (PST)
Date: Fri, 13 Feb 2026 12:08:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698f84c6.a70a0220.2c38d7.00cc.GAE@google.com>
Subject: [syzbot] [net?] BUG: unable to handle kernel paging request in
 bond_rr_gen_slave_id (3)
From: syzbot <syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	jv@jvosburgh.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=c3dd7b11863a05ae];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-258671-lists,netdev=lfdr.de,80e046b8da2820b6ba73];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	REDIRECTOR_URL(0.00)[goo.gl];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 1C59B139512
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    2061f18ad76e Merge tag 'caps-pr-20251204' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15a27192580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c3dd7b11863a05ae
dashboard link: https://syzkaller.appspot.com/bug?extid=80e046b8da2820b6ba73
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-2061f18a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c6a2ca6b83cd/vmlinux-2061f18a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e0719cd80772/bzImage-2061f18a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffff8880d6b60000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 1b201067 P4D 1b201067 PUD 0 
Oops: Oops: 0002 [#1] SMP KASAN NOPTI
CPU: 2 UID: 0 PID: 18510 Comm: syz.7.3743 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:bond_rr_gen_slave_id+0x1d5/0x250 drivers/net/bonding/bond_main.c:4836
Code: bc 24 f0 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 7a 49 8b 84 24 f0 00 00 00 bb 01 00 00 00 <65> 0f c1 18 e8 82 f5 73 fb 83 c3 01 89 d8 5b 5d 41 5c 41 5d 41 5e
RSP: 0018:ffffc900039d75d0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffc90034e9f000
RDX: 1ffff1100c6b61ce RSI: ffffffff864a3089 RDI: ffff8880635b0e70
RBP: ffff8880635b0000 R08: 0000000000000005 R09: 0000000000000001
R10: 0000000000000001 R11: 000000000ac0d5af R12: ffff8880635b0d80
R13: 0000000000008f00 R14: ffff8880635b0d80 R15: dffffc0000000000
FS:  00007f96076d66c0(0000) GS:ffff8880d6b60000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8880d6b60000 CR3: 0000000113c4b000 CR4: 0000000000352ef0
DR0: ffffffffffffffff DR1: 00000000000001f8 DR2: 0000000000000083
DR3: ffffffffefffff15 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bond_xdp_xmit_roundrobin_slave_get drivers/net/bonding/bond_main.c:4923 [inline]
 bond_xdp_get_xmit_slave+0x2a9/0x6b0 drivers/net/bonding/bond_main.c:5506
 xdp_master_redirect+0x161/0x330 net/core/filter.c:4388
 bpf_prog_run_xdp include/net/xdp.h:700 [inline]
 xdp_test_run_batch.constprop.0+0x14ce/0x1b20 net/bpf/test_run.c:307
 bpf_test_run_xdp_live+0x365/0x770 net/bpf/test_run.c:379
 bpf_prog_test_run_xdp+0xd3d/0x1660 net/bpf/test_run.c:1388
 bpf_prog_test_run kernel/bpf/syscall.c:4703 [inline]
 __sys_bpf+0x1035/0x4980 kernel/bpf/syscall.c:6182
 __do_sys_bpf kernel/bpf/syscall.c:6274 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6272 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:6272
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f960678f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f96076d6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f96069e5fa0 RCX: 00007f960678f7c9
RDX: 0000000000000050 RSI: 0000200000000600 RDI: 000000000000000a
RBP: 00007f9606813f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f96069e6038 R14: 00007f96069e5fa0 R15: 00007ffd7a8f7488
 </TASK>
Modules linked in:
CR2: ffff8880d6b60000
---[ end trace 0000000000000000 ]---
RIP: 0010:bond_rr_gen_slave_id+0x1d5/0x250 drivers/net/bonding/bond_main.c:4836
Code: bc 24 f0 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 7a 49 8b 84 24 f0 00 00 00 bb 01 00 00 00 <65> 0f c1 18 e8 82 f5 73 fb 83 c3 01 89 d8 5b 5d 41 5c 41 5d 41 5e
RSP: 0018:ffffc900039d75d0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffc90034e9f000
RDX: 1ffff1100c6b61ce RSI: ffffffff864a3089 RDI: ffff8880635b0e70
RBP: ffff8880635b0000 R08: 0000000000000005 R09: 0000000000000001
R10: 0000000000000001 R11: 000000000ac0d5af R12: ffff8880635b0d80
R13: 0000000000008f00 R14: ffff8880635b0d80 R15: dffffc0000000000
FS:  00007f96076d66c0(0000) GS:ffff8880d6b60000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8880d6b60000 CR3: 0000000113c4b000 CR4: 0000000000352ef0
DR0: ffffffffffffffff DR1: 00000000000001f8 DR2: 0000000000000083
DR3: ffffffffefffff15 DR6: 00000000ffff0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 4 bytes skipped:
   0:	00 00                	add    %al,(%rax)
   2:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
   9:	fc ff df
   c:	48 89 fa             	mov    %rdi,%rdx
   f:	48 c1 ea 03          	shr    $0x3,%rdx
  13:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  17:	75 7a                	jne    0x93
  19:	49 8b 84 24 f0 00 00 	mov    0xf0(%r12),%rax
  20:	00
  21:	bb 01 00 00 00       	mov    $0x1,%ebx
* 26:	65 0f c1 18          	xadd   %ebx,%gs:(%rax) <-- trapping instruction
  2a:	e8 82 f5 73 fb       	call   0xfb73f5b1
  2f:	83 c3 01             	add    $0x1,%ebx
  32:	89 d8                	mov    %ebx,%eax
  34:	5b                   	pop    %rbx
  35:	5d                   	pop    %rbp
  36:	41 5c                	pop    %r12
  38:	41 5d                	pop    %r13
  3a:	41 5e                	pop    %r14


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

