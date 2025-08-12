Return-Path: <netdev+bounces-213085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B12BB23916
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 21:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63948188255C
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 19:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1392D540D;
	Tue, 12 Aug 2025 19:34:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0E52D47E9
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 19:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755027275; cv=none; b=k+PjXujA9zjinfWOJVgi64MgbATfhnsT8Gb1zu1Wa0sGgzMKJpq0b46nqTqgml/ClRToZp+8cQbe9IbKs08HGA8UcYC1yEgnxNNMRRaqXHA20NlwFQkaJ6yHwZO+3eHYEcTrcUwSBwxtHBVx0X/kkHOwDxAIIULLDDpEEI6pO9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755027275; c=relaxed/simple;
	bh=BttOEe0om/j6yDdmbqxNGW55BljQ0fFUrDOkjIRGnWs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Mg1cgDQPZXli2Sa2nVyOvCaHGGxWvF3nmmixX+9U1HziryadtxQPTRATNx3taPJIHqWy5F8OFRpQScz2Qgq+iypQcjeo39yT0rk15jYJ5WhlThs1bZXDZQo+8/4/8SK8tIzMSrI4FFsQF7ORBhqQe701I6c8NSe2x0io+DHaP78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-8841d3db1a3so122336739f.3
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 12:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755027273; x=1755632073;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Ky1xpaJkHaMalBKIFIDbZuOCRjkd+geBcZ++RLq1Ow=;
        b=uZZdIMHP/Rk2WvQsJQd4DL47gE+CGOsF/OQpO2p7/b4uv0txpfqgpD55wUVkXiTnk+
         5Gji2CbP37wuMMHL0JOzbE7LSN3y6Ml1Kdwp0+haUssKrirVRBC5CSFbG4lnAEl9Sad9
         9ZqTQyk8+ptMP4KsThMHl3fj6Yne+biyCAe0YSNvdpjQ1YWHIalyAVa1kTE42ie2HS7C
         DfPlGj+1QxaSZqB7V3RDtTwiBaKjojKgGjeIT274+uKIOpwchfofMIeeYo/jpzuLjdFZ
         8CCHxIgxqEaW8XqeR+D5iH0ur/6nZPLMA1LF2GSaqLJfUsuKEEH63OceT8WRZibpi5zd
         5Btg==
X-Forwarded-Encrypted: i=1; AJvYcCVWvJyc9OfmxqzcgvJDklmnl/cpMP9Fc4xvJxnsjgccshod4nbnQYwXQ6WledKBDpoVtiQdQXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGf2s6iJ46lqTuMjobzhLkKp7RZHagVNH0TkgNQ5L8yiknqecw
	w9/qCK2HbpoGzltTmnxwJRe5HYpQ7Oj5OyCP7+roYJWdhH78AcWFq7DG0Y0LoK1r6RWQ/DPYv6T
	hg/1/qrpJq7zwr/opzVU91h4rq2uISeN2PZvLNrp0dxBkarUrvtsVDEbm/Rg=
X-Google-Smtp-Source: AGHT+IFKeeTHkEW2QWzDj6h1W/75n764YasEY6mwj+vq18FxJ/vvGjxLiwPOEcnzBUw56WVj3zu8MlLroMx2oYu/7ooFJBRXEJBx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b10:b0:883:f8dc:df53 with SMTP id
 ca18e2360f4ac-8842960a458mr66395839f.3.1755027272782; Tue, 12 Aug 2025
 12:34:32 -0700 (PDT)
Date: Tue, 12 Aug 2025 12:34:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689b9748.050a0220.51d73.00b6.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in llc_mac_hdr_init
From: syzbot <syzbot+5da6dcdc18849d9fa01e@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    37816488247d Merge tag 'net-6.17-rc1' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14cd61a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=658effe8a2c01c74
dashboard link: https://syzkaller.appspot.com/bug?extid=5da6dcdc18849d9fa01e
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8430292542cd/disk-37816488.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/69cd308fcca9/vmlinux-37816488.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a39d85d0b6c2/bzImage-37816488.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5da6dcdc18849d9fa01e@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000ad6eb84: 0000 [#1] SMP KASAN NOPTI
KASAN: probably user-memory-access in range [0x0000000056b75c20-0x0000000056b75c27]
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.16.0-syzkaller-12063-g37816488247d #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:llc_mac_hdr_init+0x2f/0x1a0 net/llc/llc_output.c:30
Code: 56 49 89 f6 41 55 49 89 d5 41 54 55 53 48 89 fb e8 16 2d 30 f8 48 8d 7b 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 3b 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b
RSP: 0018:ffffc90000a08c28 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000056b75c10 RCX: ffffffff81a7e2de
RDX: 000000000ad6eb84 RSI: ffffffff898b660a RDI: 0000000056b75c20
RBP: ffff888056b75c10 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 1ffff9200014118f
R13: ffff88801e2ea440 R14: ffffffff81a7df41 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8881247c4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3200fff8 CR3: 0000000027c8f000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 llc_conn_ac_send_i_rsp_f_set_ackpf net/llc/llc_c_ac.c:920 [inline]
 llc_conn_ac_send_i_as_ack+0x31c/0x900 net/llc/llc_c_ac.c:945
 </IRQ>
 <TASK>
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:llc_mac_hdr_init+0x2f/0x1a0 net/llc/llc_output.c:30
Code: 56 49 89 f6 41 55 49 89 d5 41 54 55 53 48 89 fb e8 16 2d 30 f8 48 8d 7b 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 3b 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b
RSP: 0018:ffffc90000a08c28 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000056b75c10 RCX: ffffffff81a7e2de
RDX: 000000000ad6eb84 RSI: ffffffff898b660a RDI: 0000000056b75c20
RBP: ffff888056b75c10 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 1ffff9200014118f
R13: ffff88801e2ea440 R14: ffffffff81a7df41 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8881247c4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3200fff8 CR3: 0000000027c8f000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	56                   	push   %rsi
   1:	49 89 f6             	mov    %rsi,%r14
   4:	41 55                	push   %r13
   6:	49 89 d5             	mov    %rdx,%r13
   9:	41 54                	push   %r12
   b:	55                   	push   %rbp
   c:	53                   	push   %rbx
   d:	48 89 fb             	mov    %rdi,%rbx
  10:	e8 16 2d 30 f8       	call   0xf8302d2b
  15:	48 8d 7b 10          	lea    0x10(%rbx),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 3b 01 00 00    	jne    0x16f
  34:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  3b:	fc ff df
  3e:	48                   	rex.W
  3f:	8b                   	.byte 0x8b


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

