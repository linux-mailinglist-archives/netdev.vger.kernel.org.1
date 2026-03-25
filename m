Return-Path: <netdev+bounces-271492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QH4nJIW+w2kRtwQAu9opvQ
	(envelope-from <netdev+bounces-271492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 11:52:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEF3323558
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 11:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C01553121B97
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0169D3BC67E;
	Wed, 25 Mar 2026 10:43:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F947345745
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774435407; cv=none; b=aRLVqkxQxRJ4y/L7rlDv+flgkgmAenDUSon1w7EewOajSn144N31Y/7wejOBDgi2h2197qkSVOSNh6C8/GuuX9d7TQmoPNsBGs3NL8OYG83tiGDFGiXSXF94Cxo+w33svU1ug8yFeZKFnzpxvuJo4Bl4IfrTCswsWJkzcVU5zjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774435407; c=relaxed/simple;
	bh=EpCa41f+ImsOaxJSobe6vFrpMru+7r0uox9JCSRec3w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ev00+cDJlgur6MxQcSCnjlG+QA9cgMD/tRCu62wni6H/JjOoagaMwtpTz1ruaCBgH2lKwzQ1bCVEt6+Do4DpYh3V2UNyYBRBTK8Dj8aNxuv8C1Ie1PmsolBNWDW4n1sZ3B0g2l85dMfmlGnQfHxWpM6HG7jrzlXGSby/wfIIPKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7d9d60f8e3aso1517185a34.3
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 03:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774435405; x=1775040205;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HdTKGlYAE0ZLLD9yPYoY3gBug1GkpRFhsMVayRE6Xxw=;
        b=rY/B0Z6FYXT1Xo34eFgeCxcZh/9DQY+2hXeYhqwunOCHorD3gvh3lKPWujSF39QOBp
         WKOS60cNJRwq9WM5njJ2ofOanv29ZrdPSYPGZ6N454ulkqamCdekKSiXA0D798m0J2PR
         JmB+G/vUxgsLTEOriJw9cWcW3GWS/DTBsym239uZcLspNbr3UzQifRIFXL+sUDi4/ZmF
         QrKLcKOFp2b1FN17lVdveNRVws5yKOXObhHrhQMiA4pJ+GrxaTwguGn4s+fE3r0fvVnR
         x2l2VM+deExRsPQJvmobA2tKZ/ks7wGkwTkmME0VFJcW5HkCsP2rFT+7RlSwa0j1c58v
         oS4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWctAWtjtwky1rpE30hItJp9UCN+Xa22RNk7faICo3sGHiyiFbxIqorgvrxlgq+rnwJfg2dtv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOgqG0038CW+0W9HVyA7aquWF6+6j5axg5UnfYpcyjWkXhBOld
	oOTMLsRIrbmuunPz8/d1EuD2Q4VXX/pbWPy2QkCymmTiBHD9G+Lt2JbLC3lzolAwP7GuIOBHmY+
	PXUAM3351Yy/NlvsbRmK4TB8xD3YmwLE+ILhR+REr26qlo/JzWTz6/2c/zaE=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:221d:b0:67b:afd7:ab03 with SMTP id
 006d021491bc7-67dff3d07bamr1537070eaf.7.1774435405246; Wed, 25 Mar 2026
 03:43:25 -0700 (PDT)
Date: Wed, 25 Mar 2026 03:43:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c3bc4d.a70a0220.234938.004d.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in lec_atm_close
From: syzbot <syzbot+895d65bfe6336a274498@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=71d49d824b43a0d9];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-271492-lists,netdev=lfdr.de,895d65bfe6336a274498];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,googlegroups.com:email,appspotmail.com:email,goo.gl:url,storage.googleapis.com:url,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 4AEF3323558
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    b1c803d5c816 net: airoha: Rework the code flow in airoha_r..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=135ad6da580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=71d49d824b43a0d9
dashboard link: https://syzkaller.appspot.com/bug?extid=895d65bfe6336a274498
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/09cf620a7914/disk-b1c803d5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/72906e01e665/vmlinux-b1c803d5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e1bab2219b98/bzImage-b1c803d5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+895d65bfe6336a274498@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc00000001d5: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000ea8-0x0000000000000eaf]
CPU: 1 UID: 0 PID: 6673 Comm: syz.0.204 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:lec_atm_close+0x60/0x9e0 net/atm/lec.c:492
Code: 74 08 4c 89 f7 e8 30 32 56 f7 49 8b 06 48 89 44 24 10 48 8d b8 a8 0e 00 00 48 89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 05 e8 f5 32 56 f7 48 8b 5c 24 10 48 c7 83 a8 0e 00
RSP: 0018:ffffc90010117c28 EFLAGS: 00010202
RAX: 00000000000001d5 RBX: dffffc0000000000 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000ea8
RBP: ffff8880573c4698 R08: ffff888055d9157f R09: 1ffff1100abb22af
R10: dffffc0000000000 R11: ffffffff8ad9b0c0 R12: ffffffff8ad9b0c0
R13: 1ffff1100abb22b3 R14: ffff888055d91650 R15: ffff888055d91598
FS:  00005555597c6500(0000) GS:ffff888125561000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30b22ff8 CR3: 0000000076908000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 vcc_destroy_socket net/atm/common.c:181 [inline]
 vcc_release+0x10f/0x580 net/atm/common.c:205
 svc_release+0x6c/0xd0 net/atm/svc.c:95
 __sock_release net/socket.c:656 [inline]
 sock_close+0xc3/0x240 net/socket.c:1448
 __fput+0x44f/0xa70 fs/file_table.c:469
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0xed/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe00099c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdf9827468 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007fe000c17da0 RCX: 00007fe00099c799
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007fe000c17da0 R08: 00007fe000c16218 R09: 0000000000000000
R10: 00000000003fe888 R11: 0000000000000246 R12: 000000000001d068
R13: 00007fe000c1618c R14: 000000000001cfe6 R15: 00007ffdf9827570
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:lec_atm_close+0x60/0x9e0 net/atm/lec.c:492
Code: 74 08 4c 89 f7 e8 30 32 56 f7 49 8b 06 48 89 44 24 10 48 8d b8 a8 0e 00 00 48 89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 05 e8 f5 32 56 f7 48 8b 5c 24 10 48 c7 83 a8 0e 00
RSP: 0018:ffffc90010117c28 EFLAGS: 00010202
RAX: 00000000000001d5 RBX: dffffc0000000000 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000ea8
RBP: ffff8880573c4698 R08: ffff888055d9157f R09: 1ffff1100abb22af
R10: dffffc0000000000 R11: ffffffff8ad9b0c0 R12: ffffffff8ad9b0c0
R13: 1ffff1100abb22b3 R14: ffff888055d91650 R15: ffff888055d91598
FS:  00005555597c6500(0000) GS:ffff888125461000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcdbc1e92f8 CR3: 0000000076908000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	74 08                	je     0xa
   2:	4c 89 f7             	mov    %r14,%rdi
   5:	e8 30 32 56 f7       	call   0xf756323a
   a:	49 8b 06             	mov    (%r14),%rax
   d:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  12:	48 8d b8 a8 0e 00 00 	lea    0xea8(%rax),%rdi
  19:	48 89 f8             	mov    %rdi,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2e:	74 05                	je     0x35
  30:	e8 f5 32 56 f7       	call   0xf756332a
  35:	48 8b 5c 24 10       	mov    0x10(%rsp),%rbx
  3a:	48                   	rex.W
  3b:	c7                   	.byte 0xc7
  3c:	83                   	.byte 0x83
  3d:	a8 0e                	test   $0xe,%al


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

