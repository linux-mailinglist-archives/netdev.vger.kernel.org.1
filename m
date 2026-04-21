Return-Path: <netdev+bounces-280177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMoiCcqa52kV+QEAu9opvQ
	(envelope-from <netdev+bounces-280177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 17:42:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D4943CE3B
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 17:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21767305BDD1
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 15:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E4A2D9EF4;
	Tue, 21 Apr 2026 15:35:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312162D97B7
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 15:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776785736; cv=none; b=AI9rJPQkk+lvqQlmRmy+O7K9HNg+fYKGk6BENwsPGwEx4VeTL0PCW3a4JyNBAJogqZH7aoVycla1v4DS0BIOSgqpNOCsTEntJEJhecVfErMFfKnRKK2nRnA78V33EO3XFTE1kc7Ikk75trfTB3M7XLRdHE+sCGmB3A/mN6wHLDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776785736; c=relaxed/simple;
	bh=iqEWk6uYHERT5rbJJGWanfCq1ohLZkd0SSFaqHxel6Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kaUCE82fpY2sAp4mQ4rpRizhaOujzdstLDh/u3aZ4GDuc13hm9nC2D1sldvlEqbqj3ZY+ePIHA42HFF6zIdX8ozC554buw6MOIWI8GavIi+8bBwqN05yRylSmNrIupbwEL+wKH6pJerWap0sfTQi7t+4E7xuWMKI8gy8CUcEbDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-66308f16ea1so6397529eaf.2
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 08:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776785732; x=1777390532;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kOpqBM96QcpbmuHxumsP+RAdHvAHkt+d2uQmzoGd1Dc=;
        b=tKuwF3hNxsLNfjcQ3LKEpTvbxCybiq8cv+kgH1VOroigu2Br/sAPh5NwC5p7qJ8GFL
         TRt6/7uWyn8GkODTlw9FXhsaiJWl161l2TlVX7EV90ngnahYUFixiLQG0df7Gkt0mTfE
         OflzNixCx4tiSP1P7BbXgAOyYBsuoY7d504xG11kWIhHaVFszWcjcN6xaGuwID0/07Qw
         9s5xpjJlON7y9sUQN3SREUU3FmiooPvzwBVxpKxtedeGbSbGrNT7RWPTbDxcNFjs4pmx
         ki2u3tOAH7GuXwWkyWl0aydP/jpqUQCd/wJvf10FQwexIGX28gi3Q5HjED2147re2saX
         0Fyw==
X-Forwarded-Encrypted: i=1; AFNElJ+kr8XaolxAlaifYPs8p8ctgZs/hE78HnS5xkiBd2llBBVx5IFuv1hlh5eNPdbals/kCVfCR6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN0DlaAfe3L0TRkOa+mFyPUUGK7pb35ui89Zp+MWyYK2zeQcDk
	ro0mEM2g61YoExgYXWtONRMb9BZZ9bxscBBX5BMH9yjgta624K4ODnNI1tdmsOmuWjKnYZk2WpK
	hhOJYsXcGo5siv1vYLjOe+cKGPo+m1GPBEweIPedXS+epqD4pSQKH/tkXIf8=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:622:b0:694:9c29:c298 with SMTP id
 006d021491bc7-6949c29db53mr1049682eaf.33.1776785732069; Tue, 21 Apr 2026
 08:35:32 -0700 (PDT)
Date: Tue, 21 Apr 2026 08:35:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e79944.a00a0220.17a17.001a.GAE@google.com>
Subject: [syzbot] [net?] kernel BUG in pn_socket_autobind
From: syzbot <syzbot+b3c0e6a240078433c42b@syzkaller.appspotmail.com>
To: courmisch@gmail.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=95ee3fe1c5a8ab57];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,vger.kernel.org,redhat.com,googlegroups.com];
	TAGGED_FROM(0.00)[bounces-280177-lists,netdev=lfdr.de,b3c0e6a240078433c42b];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,goo.gl:url,googlegroups.com:email,syzkaller.appspot.com:url];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: B3D4943CE3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    b4e07588e743 tracing: tell git to ignore the generated 'un..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10aa8e6a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95ee3fe1c5a8ab57
dashboard link: https://syzkaller.appspot.com/bug?extid=b3c0e6a240078433c42b
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-b4e07588.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bb7067cc2bb4/vmlinux-b4e07588.xz
kernel image: https://storage.googleapis.com/syzbot-assets/46b9d3bae153/bzImage-b4e07588.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b3c0e6a240078433c42b@syzkaller.appspotmail.com

netlink: 'syz.3.104': attribute type 2 has an invalid length.
------------[ cut here ]------------
kernel BUG at net/phonet/socket.c:213!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 6429 Comm: syz.3.104 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:pn_socket_autobind net/phonet/socket.c:213 [inline]
RIP: 0010:pn_socket_autobind+0x14c/0x170 net/phonet/socket.c:202
Code: 00 00 00 00 48 8b 44 24 58 65 48 2b 05 35 85 47 09 75 2a 48 83 c4 60 89 d8 5b 5d 41 5c 41 5d c3 cc cc cc cc e8 f5 0f 3d f7 90 <0f> 0b e8 ad c8 aa f7 eb 9e e8 06 c9 aa f7 e9 6c ff ff ff e8 5c b0
RSP: 0018:ffffc900037ffa30 EFLAGS: 00010287
RAX: 000000000000084d RBX: 0000000000000000 RCX: ffffc90007544000
RDX: 0000000000080000 RSI: ffffffff8acc6aeb RDI: ffff888034de8000
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff920006fff46
R13: dffffc0000000000 R14: 1ffff920006fff61 R15: ffffc900037ffe48
FS:  00007fdb20e7f6c0(0000) GS:ffff8880d63e1000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fce31d5ee9c CR3: 000000002d58c000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 pn_socket_sendmsg+0x43/0xe0 net/phonet/socket.c:421
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 ____sys_sendmsg+0x9e1/0xb70 net/socket.c:2698
 ___sys_sendmsg+0x190/0x1e0 net/socket.c:2752
 __sys_sendmsg+0x170/0x220 net/socket.c:2784
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdb1ff9c819
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdb20e7f028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fdb20215fa0 RCX: 00007fdb1ff9c819
RDX: 0000000000008000 RSI: 0000200000000380 RDI: 0000000000000006
RBP: 00007fdb20032c91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fdb20216038 R14: 00007fdb20215fa0 R15: 00007ffc7b77c6b8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:pn_socket_autobind net/phonet/socket.c:213 [inline]
RIP: 0010:pn_socket_autobind+0x14c/0x170 net/phonet/socket.c:202
Code: 00 00 00 00 48 8b 44 24 58 65 48 2b 05 35 85 47 09 75 2a 48 83 c4 60 89 d8 5b 5d 41 5c 41 5d c3 cc cc cc cc e8 f5 0f 3d f7 90 <0f> 0b e8 ad c8 aa f7 eb 9e e8 06 c9 aa f7 e9 6c ff ff ff e8 5c b0
RSP: 0018:ffffc900037ffa30 EFLAGS: 00010287
RAX: 000000000000084d RBX: 0000000000000000 RCX: ffffc90007544000
RDX: 0000000000080000 RSI: ffffffff8acc6aeb RDI: ffff888034de8000
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff920006fff46
R13: dffffc0000000000 R14: 1ffff920006fff61 R15: ffffc900037ffe48
FS:  00007fdb20e7f6c0(0000) GS:ffff8880d63e1000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fce31d5ee9c CR3: 000000002d58c000 CR4: 0000000000352ef0


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

