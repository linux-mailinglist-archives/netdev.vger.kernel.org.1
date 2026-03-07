Return-Path: <netdev+bounces-265169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGUlJoR1rGlCpwEAu9opvQ
	(envelope-from <netdev+bounces-265169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 19:59:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4173F22D4FC
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 19:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A8A8E3008C20
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 18:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40F436E484;
	Sat,  7 Mar 2026 18:59:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7DF37472F
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772909954; cv=none; b=ZFsujaPK17u2nIFNi9xI3mXcjN+4wfHOOYaZIdKn1KBBJqiWDdL38OrjgMXifDuawEJp7sDm2cH+O+ehZprOVOMMYbS4xf/VMvvk1w+NHhByeOB6VPm5WPJM9kdyGcTJyUXEL6SeyjnZlRMRM3l2CGhLIGoOrDw2jYGp69kRtO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772909954; c=relaxed/simple;
	bh=jX8NAMOR09nbOLzKWjEZcUG1VV2UvY8H7HJymT87Y3c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=nf/g9tTVZ+j8AFkPMiUZiwfAebUmZ8eLG7s9hkdn690z/ZRJ6fx7hNgJat1E69Fd9pJ/miAxaFUoznZgae8c6EUg49EK3asbvqFXzYgSv5WTKLGBk9xRGV0paxUVnAi2gLFG4Rtt4a4ZVNAQkXavs993UvvWSbxueG11xhBMCxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-679caf7ec07so166323136eaf.1
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 10:59:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772909952; x=1773514752;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tn+vjnaDd6gGH7eKCTvef3Dp8iK5tE4ck3W7mKf8vyE=;
        b=frBj3ICfp0rVjB994Svmlh7HAS2mMLYvv/v6aJ98B7rn4wSZlRaaNQkFyer/nOJMTC
         sn6NwuYoksZoj8M1vh12jnEqK9lelI9KEyLuqX/nRY4ZFLx9Q1jVKMpjGsPq5m2m/DLD
         hwgeDgWCBoApS/Uh8kqMpvI7udPkWnsZ41ZDT2X7354aoG1Rlo6fKqfoHVDVqwiWntLX
         fM4Kf/jSTie5ygAkXo2vAIMzj6CgKcKcDfEa3Y75+1Ptk7Apvc9I24qkEJ8hZr3IfoEx
         omtbhNaRRLXyq4yVRw3azRWc0Bhu97Fw5jHaYKMSijClQHRNPWNST1W+gqjU9cyGgn9X
         qTTA==
X-Forwarded-Encrypted: i=1; AJvYcCVL/emGIMd0GrxKIwy3nljYNfmSbTWSs5nEIK7qXcQUggJn46fYwHReitWXSCS8icBxlp2/AI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV6Fq7CCwIR0Hkp2+bTtfl5kNozZ67S5TFtva/7+1EPwjtys00
	u74jxBTAi49mgwcMdy8LwGdJObG5GVpa7LkKA0oIccPdXXvP9JZmUqMvIg++G3h/T4jmy+K7vam
	4tYfjmbCSsXYcosgnfA2pVJCBEdgVjvvCV3KlS4BMNoCIn+1vBJ12IoJEmJQ=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:983:b0:679:f226:30eb with SMTP id
 006d021491bc7-67b9bd31610mr3562334eaf.35.1772909952527; Sat, 07 Mar 2026
 10:59:12 -0800 (PST)
Date: Sat, 07 Mar 2026 10:59:12 -0800
In-Reply-To: <20260306151004.2862198-1-cratiu@nvidia.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ac7580.050a0220.13f275.005b.GAE@google.com>
Subject: [syzbot ci] Re: macsec: Add support for VLAN filtering in offload mode
From: syzbot ci <syzbot+cia87acdce0d629471@syzkaller.appspotmail.com>
To: andrew@lunn.ch, cratiu@nvidia.com, davem@davemloft.net, 
	dtatulea@nvidia.com, edumazet@google.com, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, sd@queasysnail.net
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4173F22D4FC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,syzbot.org:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,googlegroups.com:email,googlesource.com:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	NEURAL_SPAM(0.00)[0.287];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-265169-lists,netdev=lfdr.de,cia87acdce0d629471];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Action: no action

syzbot ci has tested the following series

[v3] macsec: Add support for VLAN filtering in offload mode
https://lore.kernel.org/all/20260306151004.2862198-1-cratiu@nvidia.com
* [PATCH net v3 1/3] nsim: Add support for VLAN filters
* [PATCH net v3 2/3] selftests: Add macsec offload VLAN tests
* [PATCH net v3 3/3] macsec: Support VLAN-filtering lower devices

and found the following issue:
WARNING in nsim_destroy

Full report is available here:
https://ci.syzbot.org/series/82631b62-e289-479c-90ac-235c613bbae1

***

WARNING in nsim_destroy

tree:      net
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net.git
base:      b06ccbabe2506fd70b9167a644978b049150224a
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/0beaf859-b4a7-4d7b-b4cf-b7e48e02f7a5/config
C repro:   https://ci.syzbot.org/findings/6f1250ca-99f0-4162-b147-c373abd95c96/c_repro
syz repro: https://ci.syzbot.org/findings/6f1250ca-99f0-4162-b147-c373abd95c96/syz_repro

------------[ cut here ]------------
1
WARNING: drivers/net/netdevsim/netdev.c:1235 at nsim_destroy+0x155/0x780 drivers/net/netdevsim/netdev.c:1235, CPU#1: kworker/u8:3/5864
Modules linked in:
CPU: 1 UID: 0 PID: 5864 Comm: kworker/u8:3 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:nsim_destroy+0x155/0x780 drivers/net/netdevsim/netdev.c:1235
Code: c4 48 89 c6 48 81 e6 00 f0 00 00 31 ff e8 c3 f0 af fa 4c 89 e0 48 25 00 f0 00 00 74 0c e8 d3 eb af fa eb 2e e8 cc eb af fa 90 <0f> 0b 90 41 ff c4 41 0f b7 d4 be 00 10 00 00 4c 89 ff e8 74 6d 8f
RSP: 0018:ffffc90004857628 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 1ffff110222a31b8 RCX: ffff88816f3fd700
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff90109377 R09: 1ffffffff202126e
R10: dffffc0000000000 R11: fffffbfff202126f R12: 0000000000000000
R13: ffff888111518dc0 R14: dffffc0000000000 R15: ffff888111519508
FS:  0000000000000000(0000) GS:ffff8882a94ae000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007feb04e16038 CR3: 000000000e54a000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 __nsim_dev_port_del+0x14d/0x1b0 drivers/net/netdevsim/dev.c:1528
 nsim_dev_port_del_all drivers/net/netdevsim/dev.c:1540 [inline]
 nsim_dev_reload_destroy+0x288/0x490 drivers/net/netdevsim/dev.c:1764
 nsim_dev_reload_down+0x8a/0xc0 drivers/net/netdevsim/dev.c:1038
 devlink_reload+0x1d1/0x8d0 net/devlink/dev.c:461
 devlink_pernet_pre_exit+0x1e6/0x3f0 net/devlink/core.c:507
 ops_pre_exit_list net/core/net_namespace.c:161 [inline]
 ops_undo_list+0x187/0x940 net/core/net_namespace.c:234
 cleanup_net+0x56b/0x800 net/core/net_namespace.c:704
 process_one_work kernel/workqueue.c:3275 [inline]
 process_scheduled_works+0xaec/0x17a0 kernel/workqueue.c:3358
 worker_thread+0xa50/0xfc0 kernel/workqueue.c:3439
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

