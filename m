Return-Path: <netdev+bounces-259307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFtbJACwlWkvTwIAu9opvQ
	(envelope-from <netdev+bounces-259307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 13:26:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA958156563
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 13:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6214A300CC1A
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 12:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8D9312820;
	Wed, 18 Feb 2026 12:26:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C16302163
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 12:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771417592; cv=none; b=MARfVkRIRA6sqm3jsTMN5a4X5I0S41ONXmKzXSXfMFsYbY/lDMM7rAxnVUp7HWWH8RxEO77vHxSLPqWNPrPStBMzpQ1/Nv2fRJ0vKTelQ9BBx9rWY1x1tAkoHF8570Tf1S8adCYGlVUqaJ2ya1h+6bcmisIoxQ4VKx1Dmlc6okQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771417592; c=relaxed/simple;
	bh=tR+orXm+QpSEbpPmDkmO5MhxYeOlH5Awe1VFFJj+aLk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ph+gzU9JtwK0hzXFVsfCNRqhYmWS+InqIDk6enuu4kdRrgGfpeFic1IaQ2O5yl+M9PzV0uNwDVaAZPq8sL/LgtTpgQhJdH/T8cxTlpaA+0Blieuppm1ZU0yNlWb7qC0EFN+To5miwbrNlEHpn8HrdI4qyeNnwgMRo4SSnVHR6TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-67951b29107so31242771eaf.2
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 04:26:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771417590; x=1772022390;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MpnbwtwHTnmSiRy508Y4HKeHxUD2rHJYwm+SdOQF/PM=;
        b=aNFED62s+9HTS9RQEUQz0mnK6KN9f7Qfa14ZmpVQREjwZLQ3O5UdcGO6xxP5zDG2OL
         XqW+oo6CuR23oBW19HuMykw8k4kd+fE/sWnxMGp43yCkZ/5fCiKCM5TH0/E26UTSN30b
         ikYL2b3+QodixIgGf1MVN7e4iHHZk0QbZB4MAxd/XpvTFdn7zfiSN2XNaA5STfPU7+yQ
         WzMZ2WdaQ8AsbVSI1NbngA2o8sZN3Ix89/eOqqj1rin8cONr0tVUN+/T79aN7Sg7eWIk
         jAVhgKFTgNaKXipvrxrCbv+haEP576QAGS8RaQ/wN5C+xOFHofq842npiZH9We40UY0i
         NT+A==
X-Forwarded-Encrypted: i=1; AJvYcCXsbGQzdxPHemBWU85QbuENXFklxLIeSwW9+ANvbGir4IMgAdCT7NDcrXfoWyMZ+cFpOV5TLrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIU0shi24avg25CowyjFk/RdJBOBJdwcmqMiFJA+xXkTvxB6eA
	f9EIb58QSfgNjrCR0dhVDvj5HUcxU+4yBwOy6uLsRoYRJZWRgF5FXVJNr3ajm86T925kNomtl6V
	K2+mzNiSE/JHnCGiKkFLqYmhYauL++NAE6m2VZO9Ec8lcQSsL91U8IZ6pkO4=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4912:b0:677:5e0a:a92d with SMTP id
 006d021491bc7-679a7487a67mr691583eaf.73.1771417590173; Wed, 18 Feb 2026
 04:26:30 -0800 (PST)
Date: Wed, 18 Feb 2026 04:26:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6995aff6.050a0220.2eeac1.014e.GAE@google.com>
Subject: [syzbot] [net?] WARNING in ops_undo_list
From: syzbot <syzbot+5a287bcdc08104bc3132@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=17f5c46dd78c01cf];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-259307-lists,netdev=lfdr.de,5a287bcdc08104bc3132];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,appspotmail.com:email,goo.gl:url,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: DA958156563
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    77c5e3fdd279 Merge branch 'selftests-forwarding-fix-br_net..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=14b07652580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=17f5c46dd78c01cf
dashboard link: https://syzkaller.appspot.com/bug?extid=5a287bcdc08104bc3132
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/90a57d114c3a/disk-77c5e3fd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f0cb3d6cda5d/vmlinux-77c5e3fd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ad4ef00f313f/bzImage-77c5e3fd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5a287bcdc08104bc3132@syzkaller.appspotmail.com

ip6erspan0 (unregistering): left allmulticast mode
bond7 (unregistering): (slave ip6gretap1): Releasing active interface
bond12 (unregistering): (slave geneve2): Releasing active interface
bond0 (unregistering): Released all slaves
bond1 (unregistering): Error: No native XDP support for the current bonding mode
------------[ cut here ]------------
dev_xdp_install(dev, mode, bpf_op, NULL, 0, NULL)
WARNING: net/core/dev.c:10361 at dev_xdp_uninstall net/core/dev.c:10361 [inline], CPU#0: kworker/u8:22/11031
WARNING: net/core/dev.c:10361 at unregister_netdevice_many_notify+0x1efd/0x2370 net/core/dev.c:12393, CPU#0: kworker/u8:22/11031
Modules linked in:
CPU: 0 UID: 0 PID: 11031 Comm: kworker/u8:22 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Workqueue: netns cleanup_net
RIP: 0010:dev_xdp_uninstall net/core/dev.c:10361 [inline]
RIP: 0010:unregister_netdevice_many_notify+0x1efd/0x2370 net/core/dev.c:12393
Code: 0f b9 3a e9 00 ff ff ff e8 50 51 52 f8 90 0f 0b 90 e9 1d ff ff ff e8 42 51 52 f8 90 0f 0b 90 e9 a0 f3 ff ff e8 34 51 52 f8 90 <0f> 0b 90 e9 f1 f4 ff ff e8 26 51 52 f8 90 0f 0b 90 e9 4e f6 ff ff
RSP: 0018:ffffc90003b2f7c0 EFLAGS: 00010293
RAX: ffffffff8971e99c RBX: ffff888052f84c40 RCX: ffff88807896bc80
RDX: 0000000000000000 RSI: 00000000ffffffa1 RDI: 0000000000000000
RBP: ffffc90003b2f930 R08: ffffc90003b2f207 R09: 1ffff92000765e40
R10: dffffc0000000000 R11: fffff52000765e41 R12: 00000000ffffffa1
R13: ffff888052f84c38 R14: 1ffff1100a5f0988 R15: ffffc9000df67000
FS:  0000000000000000(0000) GS:ffff8881254ae000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f60871d5d58 CR3: 000000006c41c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ops_exit_rtnl_list net/core/net_namespace.c:187 [inline]
 ops_undo_list+0x3d3/0x940 net/core/net_namespace.c:248
 cleanup_net+0x56b/0x800 net/core/net_namespace.c:704
 process_one_work kernel/workqueue.c:3275 [inline]
 process_scheduled_works+0xaec/0x17a0 kernel/workqueue.c:3358
 worker_thread+0xa50/0xfc0 kernel/workqueue.c:3439
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
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

