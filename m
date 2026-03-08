Return-Path: <netdev+bounces-265234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PIXqNKkZrWn5yAEAu9opvQ
	(envelope-from <netdev+bounces-265234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 07:39:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFD222EBE0
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 07:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C710A301159D
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 06:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28A92FFDEB;
	Sun,  8 Mar 2026 06:39:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFAF2D6401
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 06:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772951972; cv=none; b=c5Ybp6Y2pOzQfGRWcNpfyfyKqFtyG3ceyQrlDkLeSYIqaObTodxTbUwyV/4CydSlTh/VO1L+LzxIo9e3Z2HabIz5M6j/qj/bA/lWM+Yrg+juHQ4m2krb/sxZqCyQopXPk374rqzUQmC7cdsFa/caXzYkE3lyWLmy+1u1WVcskj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772951972; c=relaxed/simple;
	bh=uNLIHze9mlx4oh6ofrENJDypOEscvSBNiXd1v5Pwm8s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mnWy2Y9Je6guXNr11wS5WjhQ/ILul8e0Yym/ey9tz+ApMFNHHNdnBrXFDnYA4IJ7Eq+29DHwyxTS5uymoY0lCUrtE+IyKEaGq12JGR3mp6jT96fwkRxChP8ydyGkNcz23KHR2s0uf2B26dEAtY/KtZgdkywRPpbr5pRDdQwS4fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-679dda090fbso175837764eaf.2
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 22:39:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772951970; x=1773556770;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PXqz6ZgCdOp3HYkESBSwuN66nDli/XUoxf/iWpvSR1Y=;
        b=EXQps0d4ssrfZi2WKOCFRKoQJdvCG84N2YrERbubWUqGqk4TZ0n0Lvx/5VbG7aQqJS
         fvxaVIZRsSxF8kojVFlolezuKzYk9pLTUbEcL8nsah6Hhuhq2mNDxwWoYaC/zah8R8xV
         MDqECgx8/Y5s8TWO2LsTHfII5oezyArvI2gl9Vne3tWGZKPXQymkwem17R33DcKZvIFb
         NWbB2wB5ZTk/lcSqkAv7SWSwDbUSS7ZpD7y2ZB3mlAHrVxwggOS7ov4scaTMZtMsIxSk
         R1TsYoBNxpdDzEZKCTC+i+Tvs8HucsSXqtYLqZxlD9rE9ER67b9kE84Q9GEHfwSRMVlq
         O55w==
X-Forwarded-Encrypted: i=1; AJvYcCVFlAW11UHvBLoXo3Z+FcStSAZ/98pNfhEw2+6Cezi0YuktGJG5cp+2udxDJ59BKLTe9JbXw6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVhuwIomLBBLmuIs5roYcFs1QAm12sloIT9STyl28nLZFD3Byy
	7eCJuy36R891Na8I90aSzDnFGz5XS3QlDO2WsfP9GU4Kv/qWoj3YchMQE/7fSrtQMFrG1Qp5s60
	aBFqfHoB0EJ2SXdHmZgv6FB6LX20gzjkpPNNZZI5nfzT/mG7q2ysJrGCwiYg=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b94:b0:662:fbdd:1adb with SMTP id
 006d021491bc7-67b9bc8875emr5077737eaf.25.1772951970585; Sat, 07 Mar 2026
 22:39:30 -0800 (PST)
Date: Sat, 07 Mar 2026 22:39:30 -0800
In-Reply-To: <695e9924.050a0220.1c677c.0371.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ad19a2.a70a0220.52840.0001.GAE@google.com>
Subject: Re: [syzbot] [netfilter?] WARNING in nf_hook_entry_head (2)
From: syzbot <syzbot+6f6a1d20567a8d6b2a58@syzkaller.appspotmail.com>
To: coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com, 
	fw@strlen.de, horms@kernel.org, kadlec@netfilter.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pabeni@redhat.com, pablo@netfilter.org, 
	phil@nwl.cc, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 1FFD222EBE0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=779072223d02a312];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265234-lists,netdev=lfdr.de,6f6a1d20567a8d6b2a58];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.865];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

syzbot has found a reproducer for the following issue on:

HEAD commit:    c113d5e32678 Merge branch 'net-spacemit-a-few-error-handli..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=176fca02580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=779072223d02a312
dashboard link: https://syzkaller.appspot.com/bug?extid=6f6a1d20567a8d6b2a58
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1457075a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a1a0aa684791/disk-c113d5e3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6d0461aed5ba/vmlinux-c113d5e3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/05b26502bb1f/bzImage-c113d5e3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6f6a1d20567a8d6b2a58@syzkaller.appspotmail.com

------------[ cut here ]------------
1
WARNING: net/netfilter/core.c:329 at nf_hook_entry_head+0x23e/0x2c0 net/netfilter/core.c:329, CPU#1: kworker/u8:6/166
Modules linked in:
CPU: 1 UID: 0 PID: 166 Comm: kworker/u8:6 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Workqueue: netns cleanup_net
RIP: 0010:nf_hook_entry_head+0x23e/0x2c0 net/netfilter/core.c:329
Code: 4c 89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 80 3c 08 00 74 08 4c 89 ff e8 ed 82 69 f8 4d 39 37 74 36 e8 43 41 ff f7 90 <0f> 0b 90 31 db 48 89 d8 5b 41 5e 41 5f 5d c3 cc cc cc cc cc e8 29
RSP: 0018:ffffc900030a7820 EFLAGS: 00010293
RAX: ffffffff89c657eb RBX: ffff8880358c4000 RCX: ffff88801f3a3d00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff88801f3a3d00 R09: 0000000000000006
R10: 000000000000000a R11: 0000000000000000 R12: ffff888068070000
R13: 0000000000000005 R14: ffff888068070000 R15: ffff8880358c4108
FS:  0000000000000000(0000) GS:ffff888125561000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5f121e9e80 CR3: 0000000029e2a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __nf_unregister_net_hook+0x74/0x6f0 net/netfilter/core.c:491
 nft_unregister_flowtable_ops net/netfilter/nf_tables_api.c:8905 [inline]
 __nft_unregister_flowtable_net_hooks net/netfilter/nf_tables_api.c:8920 [inline]
 __nft_release_hook net/netfilter/nf_tables_api.c:11904 [inline]
 __nft_release_hooks net/netfilter/nf_tables_api.c:11918 [inline]
 nf_tables_pre_exit_net+0x64a/0x900 net/netfilter/nf_tables_api.c:12069
 ops_pre_exit_list net/core/net_namespace.c:161 [inline]
 ops_undo_list+0x187/0x940 net/core/net_namespace.c:234
 cleanup_net+0x56b/0x800 net/core/net_namespace.c:704
 process_one_work kernel/workqueue.c:3275 [inline]
 process_scheduled_works+0xb02/0x1830 kernel/workqueue.c:3358
 worker_thread+0xa50/0xfc0 kernel/workqueue.c:3439
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

