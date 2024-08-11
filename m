Return-Path: <netdev+bounces-117541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1312294E3B2
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 00:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69FFA2810EA
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 22:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B12A158860;
	Sun, 11 Aug 2024 22:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bCVfbeev"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C880218E06;
	Sun, 11 Aug 2024 22:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723415746; cv=none; b=GGVuzJqhkD/w5Mx3WpjmFzbRa8WINiMwSkyhKRDseIBoTnoaYAkBUeIXeHVaROiYwgb4YAqyWoTXArcLl93g3Yk4/dNmIAf8fh4b810ODSEYVxlkGiILxX0Pu7r5yXrcc1eTHYUF66E58vKv0bfFEn92fYwqlXLkCv8voF52KWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723415746; c=relaxed/simple;
	bh=FttgtqDGMzJ1vZLn+vpAUB0gX8obFyHmcj+oGs1HBT4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RGVWqEH5zPaYIUTWmgFmIiA+vwHrsW4VCYWIFmdJBry2y7RcyAJNubOF18o9bcK6f7VxcNMdTEr7MibPk9Gbmm9mfWZwK67djEeGzfNEgNl3Miy0iN1FPnxw0ouAjcaQLCGwiHUuKqqQKFAKMRGberPMcImy6LJ12/saLbCRyco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bCVfbeev; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723415744; x=1754951744;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rjT0U41xgb69Sl2nekH6HKDIz+woH1amleLhBgPEQDc=;
  b=bCVfbeevQtN2caX93hEYTuDWWUZ3mVAN7u/7VITzOFg9qwCo65grt45V
   xWUrxjVi4DfYhMVJyJuteu3hRfPdx9yGeRtvTDwfPNDdvGLeivGy3dsll
   uRywvQwwGPVgUvwkZN/wGScx8DgTYWhA8W4mY8C8NL1CG6fe+x9r5xPkv
   Q=;
X-IronPort-AV: E=Sophos;i="6.09,282,1716249600"; 
   d="scan'208";a="114235216"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 22:35:42 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:16065]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.16:2525] with esmtp (Farcaster)
 id 19a5de7a-14bd-40e3-afc5-b4964902c6cc; Sun, 11 Aug 2024 22:35:42 +0000 (UTC)
X-Farcaster-Flow-ID: 19a5de7a-14bd-40e3-afc5-b4964902c6cc
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sun, 11 Aug 2024 22:35:42 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sun, 11 Aug 2024 22:35:39 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <fw@strlen.de>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzbot+8ea26396ff85d23a8929@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] WARNING: refcount bug in inet_twsk_kill
Date: Sun, 11 Aug 2024 15:35:30 -0700
Message-ID: <20240811223530.92827-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240811133200.GC13736@breakpoint.cc>
References: <20240811133200.GC13736@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Florian Westphal <fw@strlen.de>
Date: Sun, 11 Aug 2024 15:32:00 +0200
> > > ------------[ cut here ]------------
> > > refcount_t: decrement hit 0; leaking memory.
> > > WARNING: CPU: 3 PID: 1396 at lib/refcount.c:31 refcount_warn_saturate+0x1ed/0x210 lib/refcount.c:31
> > 
> > Eric, this is the weird report I was talking about at netdevconf :)
> > 
> > It seems refcount_dec(&tw->tw_dr->tw_refcount) is somehow done earlier
> > than refcount_inc().
> > 
> > I started to see the same splat at a very low rate after consuming
> > commit b334b924c9b7 ("net: tcp/dccp: prepare for tw_timer un-pinning").
> 
> Could you share a splat you saw?
> 
> Was it also for the fallback tcp_hashinfo and/or from error
> unwindinding after a ops->init() failure on netns creation?
> 
> I don't think it makes sense following this specific report given
> b334b924c9b7 made changes in this area, but a post-b334b924c9b7
> would be more relevant I think.

Ah, I missed the initial syzbot's report was created before the commit.

Here's splats I saw:

[ Note both splats were mixed in the log as with the syzbot's report,
  so two threads were calling tcp_sk_exit_batch() concurrently. ]

---8<---
refcount_t: decrement hit 0; leaking memory.
WARNING: CPU: 0 PID: 1760 at lib/refcount.c:31 refcount_warn_saturate (lib/refcount.c:31 (discriminator 3))
Modules linked in:
CPU: 0 PID: 1760 Comm: syz-executor.4 Not tainted 6.10.0-rc3-00688-g934c29999b57-dirty #20
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
RIP: 0010:refcount_warn_saturate (lib/refcount.c:31 (discriminator 3))
Code: 05 cd 8d aa 04 01 e8 48 e4 e9 fe 0f 0b e9 d3 fe ff ff e8 1c 36 1c ff 48 c7 c7 a0 4a 80 85 c6 05 aa 8d aa 04 01 e8 29 e4 e9 fe <0f> 0b e9 b4 fe ff ff 48 89 ef e8 fa 56 69 ff e9 5c fe ff ff 0f 1f
RSP: 0018:ffffc9000118fa78 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffc9000b13b000
RDX: 0000000000040000 RSI: ffffffff8118dedf RDI: 0000000000000001
RBP: ffff88800bb59440 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 000000002d2d2d2d R12: ffff88800bb59440
R13: ffff88810130f3d0 R14: ffff8881013ee820 R15: ffff888102001198
FS:  00007f5252dbd640(0000) GS:ffff88811ae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004a6128 CR3: 00000001038b8003 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <TASK>
 inet_twsk_kill (./include/linux/refcount.h:336 ./include/linux/refcount.h:351 net/ipv4/inet_timewait_sock.c:70)
 inet_twsk_deschedule_put (net/ipv4/inet_timewait_sock.c:266)
 inet_twsk_purge (net/ipv4/inet_timewait_sock.c:349)
 tcp_twsk_purge (net/ipv4/tcp_minisocks.c:402)
 tcp_sk_exit_batch (net/ipv4/tcp_ipv4.c:3512)
 ops_exit_list (net/core/net_namespace.c:179)
 setup_net (net/core/net_namespace.c:374 (discriminator 3))
 copy_net_ns (net/core/net_namespace.c:510)
 create_new_namespaces (kernel/nsproxy.c:110)
 unshare_nsproxy_namespaces (kernel/nsproxy.c:228 (discriminator 4))
 ksys_unshare (kernel/fork.c:3325)
 __x64_sys_unshare (kernel/fork.c:3392)
 do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f5253a29e5d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 9f 1b 00 f7 d8 64 89 01 48
RSP: 002b:00007f5252dbcc88 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00000000004d4070 RCX: 00007f5253a29e5d
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040000000
RBP: 00000000004d4070 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f5253a8a530 R15: 0000000000000000
 </TASK>

WARNING: CPU: 1 PID: 671 at net/ipv4/tcp_ipv4.c:3514 tcp_sk_exit_batch (net/ipv4/tcp_ipv4.c:3514)
Modules linked in:
CPU: 1 PID: 671 Comm: kworker/u8:15 Not tainted 6.10.0-rc3-00688-g934c29999b57-dirty #20
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:tcp_sk_exit_batch (net/ipv4/tcp_ipv4.c:3514)
Code: 89 ee e8 9f 1b 28 fd 85 ed 0f 88 b3 00 00 00 e8 92 22 28 fd 31 ff 89 ee e8 89 1b 28 fd 85 ed 0f 84 9d 00 00 00 e8 7c 22 28 fd <0f> 0b e8 75 22 28 fd 48 89 df e8 ed 23 02 00 48 8d 7b 28 48 89 f8
RSP: 0018:ffffc90000ebfc60 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88800bb59140 RCX: ffffffff84230cb7
RDX: ffff888103871180 RSI: ffffffff84230cc4 RDI: 0000000000000005
RBP: 0000000000000002 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000002 R11: 00000000000002bd R12: ffff88800bb59440
R13: dffffc0000000000 R14: ffffc90000ebfd08 R15: fffffbfff0d7fb5c
FS:  0000000000000000(0000) GS:ffff88811af00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f274114ddf8 CR3: 000000010a11c006 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ops_exit_list (net/core/net_namespace.c:179)
 cleanup_net (net/core/net_namespace.c:639 (discriminator 3))
 process_one_work (kernel/workqueue.c:3236)
 worker_thread (kernel/workqueue.c:3306 kernel/workqueue.c:3393)
 kthread (kernel/kthread.c:389)
 ret_from_fork (arch/x86/kernel/process.c:153)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:257)
 </TASK>
---8<---

