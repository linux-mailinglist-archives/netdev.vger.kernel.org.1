Return-Path: <netdev+bounces-203251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F68FAF1009
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 11:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D001C234CB
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 09:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99335238171;
	Wed,  2 Jul 2025 09:35:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D883D182D0
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751448938; cv=none; b=ku51kV+SHw6Tk3294squ6p1BNtT3Qaig42yEsRCJC5+1ova59uWXCYC1elrCj63pMl6Hdg+64iWhZUMagDjAuogzbe+1kyNwCL1ICxUZwuuhozkc3PzfGQR1r4Bqd6CR0Eqnw9kQq9t1t6HG2yhaR44CEhj/BLcEDNoJe+OexSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751448938; c=relaxed/simple;
	bh=EvuZl2knE0j7t8cUbaeJ8ujnFHylB01hdfBrvqBRd8w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OpzbF+NQaQaSWoR+eFguOhF9XEZg7lluq/O+s/CsqplT2Ko6/mBdTcWbl927boRMAylP8B3TrPoFoiMsjc0QYYuhlAgXZ/4Tz9usFVW4bOEMFLGgVAv8DdA1b0E2hWlEn8cR8lDMDYRYTyma8ZpTbX/l3MskjckKK3Sv9g7KrzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ddbfe1fc8fso160708085ab.2
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 02:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751448935; x=1752053735;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G2En1hXley+fxQo5rpUH2NJQOiOQEVb0XdKHRU1z3f8=;
        b=Cr/T2ieL0qq+swnF04R9ShCQjp9Wj33EJhZbPmxUpdHoPmN3iE2PVmWYkhnTBeIxYH
         dCuNB8AhZD9ZWJbQgLDCSHABAMK1F0TqyMWAqehWSRMoa8ctDuGrpS5ORUOmDE08CLRb
         ivVU1ds3d8jpluy74deTePCdbGZxBHA4kJETN/kumElM8VHy2MgiiswgwPwyL45grosy
         xMFrOJV+ma1UPhjisNeIjCaMhEzSWVh/zrsdahmDP5YTttEJhs7jKYvP79+k8dN9BfUd
         kjtzujEzqRjp1s6wMo/2sLM5MJ598RYhv12MYRhjNMETi3pdK2XDogNeaemM6XwJMASx
         OrQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNuMSjy8723sTLrgZR8A6vNIBo1wcPIuXhjCJKiBz/hRJ8BaJoKkF4mXI77ztOJ2ILUDMJ6tU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzb6JnDr5eDHDTgikOM2PJmQguYMffahA05xFbAVfQ1Mw+URei
	T8QV0ttTMcb+W6ht3Uqq+eoNlDoSFNfSZxqOnKqYEqsaadO7hD8OREXm78Zwj+ru06FhTjnnIu+
	ij/3/S8E+IoX/QJDPMZsxlUpAzOT6N/IK16Rq3Ug3ay/mJygdUmWRzp9TrTc=
X-Google-Smtp-Source: AGHT+IGOwgqtQXVq/SOJsn5wzbxhsly3b3TRegT50bh0lPh/Uo+hBuHy7fpVLeB6K5mDZ1UUipxoDp0STStsnECa5peVpXIvGbvP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:74a:b0:3dd:b5ef:4556 with SMTP id
 e9e14a558f8ab-3e054a307fbmr28048315ab.18.1751448934879; Wed, 02 Jul 2025
 02:35:34 -0700 (PDT)
Date: Wed, 02 Jul 2025 02:35:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6864fd66.a70a0220.3b7e22.22ba.GAE@google.com>
Subject: [syzbot] [tipc?] general protection fault in tipc_conn_close (4)
From: syzbot <syzbot+c9964a461e912b0e41a6@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jmaloy@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tipc-discussion@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    aaf724ed6926 Merge tag 'v6.16-rc3-smb3-client-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13df4982580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ad206eb0100c6a2
dashboard link: https://syzkaller.appspot.com/bug?extid=c9964a461e912b0e41a6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/46fd31cc8b63/disk-aaf724ed.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6a4ede98a00a/vmlinux-aaf724ed.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9ec9bec36dfc/bzImage-aaf724ed.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c9964a461e912b0e41a6@syzkaller.appspotmail.com

HfR: left promiscuous mode
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 UID: 0 PID: 16606 Comm: kworker/u10:0 Tainted: G     U              6.16.0-rc3-syzkaller-00306-gaaf724ed6926 #0 PREEMPT(full) 
Tainted: [U]=USER
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: netns cleanup_net
RIP: 0010:tipc_conn_close+0x48/0x1c0 net/tipc/topsrv.c:158
Code: fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 5b 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 6b 08 48 8d 7d 18 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 45 01 00 00 4c 8b 6d 18 49 8d ad d8 03 00 00 48
RSP: 0018:ffffc9000ba3fa58 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff88805234ac00 RCX: 0000000000000007
RDX: 0000000000000003 RSI: ffffffff8b1ed264 RDI: 0000000000000018
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff90a82757 R11: 0000000000000001 R12: ffff8881457a4c58
R13: ffffed1028af4993 R14: ffff88805234ac08 R15: ffff88805234ac00
FS:  0000000000000000(0000) GS:ffff88812475f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffbf822d88 CR3: 0000000031fe6000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tipc_topsrv_stop net/tipc/topsrv.c:708 [inline]
 tipc_topsrv_exit_net+0x146/0x3b0 net/tipc/topsrv.c:730
 ops_exit_list net/core/net_namespace.c:200 [inline]
 ops_undo_list+0x2eb/0xab0 net/core/net_namespace.c:253
 cleanup_net+0x408/0x890 net/core/net_namespace.c:686
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:tipc_conn_close+0x48/0x1c0 net/tipc/topsrv.c:158
Code: fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 5b 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 6b 08 48 8d 7d 18 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 45 01 00 00 4c 8b 6d 18 49 8d ad d8 03 00 00 48
RSP: 0018:ffffc9000ba3fa58 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff88805234ac00 RCX: 0000000000000007
RDX: 0000000000000003 RSI: ffffffff8b1ed264 RDI: 0000000000000018
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff90a82757 R11: 0000000000000001 R12: ffff8881457a4c58
R13: ffffed1028af4993 R14: ffff88805234ac08 R15: ffff88805234ac00
FS:  0000000000000000(0000) GS:ffff88812475f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1017b8bf98 CR3: 000000004ec58000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 3 bytes skipped:
   0:	48 c1 ea 03          	shr    $0x3,%rdx
   4:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   8:	0f 85 5b 01 00 00    	jne    0x169
   e:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  15:	fc ff df
  18:	48 8b 6b 08          	mov    0x8(%rbx),%rbp
  1c:	48 8d 7d 18          	lea    0x18(%rbp),%rdi
  20:	48 89 fa             	mov    %rdi,%rdx
  23:	48 c1 ea 03          	shr    $0x3,%rdx
* 27:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2b:	0f 85 45 01 00 00    	jne    0x176
  31:	4c 8b 6d 18          	mov    0x18(%rbp),%r13
  35:	49 8d ad d8 03 00 00 	lea    0x3d8(%r13),%rbp
  3c:	48                   	rex.W


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

