Return-Path: <netdev+bounces-299871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RGwBAPJfMWr/iAUAu9opvQ
	(envelope-from <netdev+bounces-299871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:38:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 479C0690937
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:38:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299871-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299871-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D135B3024519
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1111536F42A;
	Tue, 16 Jun 2026 14:27:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A944D3385AC
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 14:27:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781620043; cv=none; b=nUsIh+Sp2uHFTTqC36N513C6zf47ab6GENE9AG6DtZQhpRIuJLlFQWLk4HRV0iT6IqNoKsHMe4FWhEcELd86amFUg9ExuhEqL/bi+UuMpkjqtqLxSmoAcGjKXJO43Fc1FI1C7Axss9aJMUrdXnpIgUFcYVTAFqWt7CSUV/NIWjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781620043; c=relaxed/simple;
	bh=8yFVcSsqRfy1MJQP9CJOO+dHPpNs4D5zRwb8yKcs2MY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NIj1RNkCzBJgBNmh5tNwD4ssixeX6DOvlq5MqAFQyR+Iozvd2FEhzF3NTJcCatlDeTG3b7jhLyUspdGiXHg8rpVTXUFSpfJ1hxH58dQedOONcxIZv3SqR5K9TyQYfSlIqHNvDwX52VUEwMS/1RuKIlq5stnddNGfwrGa0gUb/tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-69dac65fd9bso3311999eaf.1
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 07:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781620041; x=1782224841;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QqoMiqh1Z8KtpXEtnmBXvlUuF3fai2r7IUxS3BRLfAY=;
        b=k+Emk1n2PrUpswEtEH2qfnsRfjui4n2jd1Uc1Do3+BFR0dQYXFk/3K4EBkfS/BkOlb
         7J0kLsJoYzAQUU9xuCJnhI/40Z0Unqrct4gAW3s5SxCH9U75WMd8wticdE4Gc2GnZKiT
         pNS7bo/dR+Ium9rubhlH6ZB9SQYIv5YE83yMSiCP8dUoHg1PJwr/EXvv4a3SzZpkCiJu
         HRM5RbCG9RGxk4jGx2c7UqwZkot985Bi03oHUOYtNNCFg3kK/D9NFZU/yuhNUZXbk4A2
         u/ZKfhN2ySfi/8hQ5KxP06yQajyoXY9ebX/wSvirIYyl618TLMfqPQoU8q85IcXPxU31
         HL4A==
X-Forwarded-Encrypted: i=1; AFNElJ9TlQqxqVeJlqzqo13MpUWRa2OHOLY8QyDVoj9vNTUuVgYB5cln7sl1djJJpR2anlzz2b+8PNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMDRSVjYRAq1O70jF0tuax9hCh1mLtzvUGey3vIKW8o/JIG9cU
	YnzEWnDsBaIah5V+FK8Irx+amIZs+4Cc0ozSoJG23bCMcoL8Xow772lv/mKgB6wEY5O3/64Liy4
	nHNL5UVaHqydKPjLSA1J/PNJMVwB5n9XdXdSxvEq/Ja3EkAe3SdU6I1HzeYU=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:208d:b0:696:21ad:a4f0 with SMTP id
 006d021491bc7-69eec931353mr9880399eaf.36.1781620040763; Tue, 16 Jun 2026
 07:27:20 -0700 (PDT)
Date: Tue, 16 Jun 2026 07:27:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a315d48.b0403584.28d0ff.0002.GAE@google.com>
Subject: [syzbot] [net?] WARNING in tls_err_abort
From: syzbot <syzbot+cca46a9d1276f38af2ae@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, sd@queasysnail.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=8697a140486f5628];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299871-lists,netdev=lfdr.de,cca46a9d1276f38af2ae];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,syzkaller.appspotmail.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,goo.gl:url,appspotmail.com:email,googlegroups.com:email,syzkaller.appspot.com:url,storage.googleapis.com:url];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:sd@queasysnail.net,m:syzkaller-bugs@googlegroups.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,gmail.com,vger.kernel.org,redhat.com,queasysnail.net,googlegroups.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 479C0690937

Hello,

syzbot found the following issue on:

HEAD commit:    f6033078a9e6 ip6_tunnel: annotate data-races around t->err..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=122a98ae580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8697a140486f5628
dashboard link: https://syzkaller.appspot.com/bug?extid=cca46a9d1276f38af2ae
compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7af9eb2b9b5a/disk-f6033078.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4b7e03b76e68/vmlinux-f6033078.xz
kernel image: https://storage.googleapis.com/syzbot-assets/38042dd09caa/bzImage-f6033078.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cca46a9d1276f38af2ae@syzkaller.appspotmail.com

------------[ cut here ]------------
err >= 0
WARNING: net/tls/tls_sw.c:73 at tls_err_abort+0x5d/0x80 net/tls/tls_sw.c:73, CPU#0: kworker/0:11/6099
Modules linked in:
CPU: 0 UID: 0 PID: 6099 Comm: kworker/0:11 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Workqueue: pencrypt_serial padata_serial_worker
RIP: 0010:tls_err_abort+0x5d/0x80 net/tls/tls_sw.c:73
Code: e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 84 c0 75 1b 89 ab 9c 01 00 00 48 89 df 5b 5d e9 c9 a2 32 ff e8 a4 60 8a f7 90 <0f> 0b 90 eb c3 89 f9 80 e1 07 80 c1 03 38 c1 7c d9 e8 1d 9f f5 f7
RSP: 0018:ffffc900069379e0 EFLAGS: 00010293
RAX: ffffffff8a3adf8c RBX: ffff88807d1e0d80 RCX: ffff888058bfdd00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000ffffffff
RBP: 0000000000000000 R08: ffffe8ffffc513e3 R09: 1ffffd1ffff8a27c
R10: dffffc0000000000 R11: ffffffff8a3c4d70 R12: ffff888028eaf400
R13: ffff88804441030c R14: dffffc0000000000 R15: ffff888028eaf460
FS:  0000000000000000(0000) GS:ffff8881252a0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f521f503ff8 CR3: 0000000086fc2000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 tls_encrypt_done+0x223/0x480 net/tls/tls_sw.c:500
 padata_serial_worker+0x2b9/0x430 kernel/padata.c:343
 process_one_work kernel/workqueue.c:3314 [inline]
 process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3397
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3478
 kthread+0x389/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

