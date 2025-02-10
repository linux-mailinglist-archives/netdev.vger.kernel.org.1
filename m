Return-Path: <netdev+bounces-164552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FF9A2E307
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 05:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 638343A52FD
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 04:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CF5155393;
	Mon, 10 Feb 2025 04:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lSXbnDGo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93880145A18
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 04:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739160851; cv=none; b=myOZr9o8HwAWsyfkVj8fcxfgxDjSGV/hEe5tkQA8fyvBnU2Tud/rcfKB5XSDMpwFcGWDSKRFajAvxh6rsqjZdbkEodz9FkUbCrNjYUr5R0bUX/TSKu1sCUe6Hhb1jm9Zi8H2IcS/GCdXEpT/osJA6ut2v+95Me7v0PTxaltNNY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739160851; c=relaxed/simple;
	bh=d7ASBTUmVgHnyXAHKLKO7SZm0ylBU5JVJNzAkCoH+BU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d9f/nu7frj1PAMWTqc8fH10P6ZXTbnA6pAhfml9pL4u5tTFvG9USG/DnUZ6B4IkdFam+wRhR8yN2HV3Paz49uvVkdH85IbXTnbFYhZiEeZ1vAR3w5dSrj795xq5IUZeJVL4BrraXGydIQuUiIo6u+WjyH+Tbd7Jtckbfi9JkLfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lSXbnDGo; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739160849; x=1770696849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0ULJdBiHztoqR+g86iMNzJo4twVd0vxpsJx9SpvTw1s=;
  b=lSXbnDGopiUi8U3WCvUbdQDfX3VJlbXI9kctojetsKVcb27Cwl16kQUR
   TTkQUYNPXHCXhZHuLl/TwGzb9kTg3wK4iW+Dh7OqOFFAqeITuAZXQtiQ5
   G4HxUh86ksuv2zKAxSWfqzXhxQPnZMCSroRBGntsHBflJdIBGiZpxk+U1
   c=;
X-IronPort-AV: E=Sophos;i="6.13,273,1732579200"; 
   d="scan'208";a="171028519"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 04:14:07 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:16658]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.41:2525] with esmtp (Farcaster)
 id bd2d05d2-fec2-47e0-b92e-3762f998a7ae; Mon, 10 Feb 2025 04:14:07 +0000 (UTC)
X-Farcaster-Flow-ID: bd2d05d2-fec2-47e0-b92e-3762f998a7ae
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 10 Feb 2025 04:14:01 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 10 Feb 2025 04:13:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v3 net-next 3/5] net: no longer hold RTNL while calling flush_all_backlogs()
Date: Mon, 10 Feb 2025 13:13:48 +0900
Message-ID: <20250210041348.69881-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250114205531.967841-4-edumazet@google.com>
References: <20250114205531.967841-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Hi Eric,

From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Jan 2025 20:55:29 +0000
> @@ -11575,8 +11598,10 @@ void unregister_netdevice_many_notify(struct list_head *head,
>  		unlist_netdevice(dev);
>  		WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERING);
>  	}
> -	flush_all_backlogs();
>  
> +	rtnl_drop_if_cleanup_net();
> +	flush_all_backlogs();
> +	rtnl_acquire_if_cleanup_net();
>  	synchronize_net();
>  
>  	list_for_each_entry(dev, head, unreg_list) {

One of my syzkaller setup happend to not have the revert of this series
and this hunk seemed to trigger BUG_ON(dev->reg_state != NETREG_REGISTERED)
for PPP.

ppp_release() assumed that RTNL is not released until ->ndo_uninit() that
clears ppp->owner to NULL, so this change may be needed in the next try,
just fyi.

Thanks!

---8<---
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 4583e15ad03a..ccf3b708bbc9 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -406,7 +406,8 @@ static int ppp_release(struct inode *unused, struct file *file)
 		if (pf->kind == INTERFACE) {
 			ppp = PF_TO_PPP(pf);
 			rtnl_lock();
-			if (file == ppp->owner)
+			if (file == ppp->owner &&
+			    ppp->dev->reg_state == NETREG_REGISTERED)
 				unregister_netdevice(ppp->dev);
 			rtnl_unlock();
 		}
---8<---

---8<---
kernel BUG at net/core/dev.c:11773!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 UID: 0 PID: 1681 Comm: syz.2.364 Not tainted 6.13.0-04046-g0ad9617c78ac #25 2a4f595e37b581d176eb9aae48dfe81ca9e88551
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
RIP: 0010:unregister_netdevice_many_notify+0x1d44/0x1d50 net/core/dev.c:11773
Code: c1 80 61 30 87 80 e1 07 80 c1 03 38 c1 0f 8c c8 e8 ff ff 48 c7 c7 80 61 30 87 e8 17 6b dc fd e9 b7 e8 ff ff e8 3d c6 8b fd 90 <0f> 0b e8 35 c6 8b fd 90 0f 0b 66 90 55 41 57 41 56 41 55 41 54 53
RSP: 0018:ffa000001440f6c0 EFLAGS: 00010293
RAX: ffffffff83cad063 RBX: 1fe22000029bc02f RCX: ff11000103764480
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000001
RBP: ffa000001440f890 R08: ffffffff8709abc7 R09: 1ffffffff0e13578
R10: dffffc0000000000 R11: fffffbfff0e13579 R12: ffa000001440f8e0
R13: ffa000001440f8e0 R14: 0000000000000002 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ff1100011a000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9c1a46e000 CR3: 00000001095ee002 CR4: 0000000000771ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
PKRU: 80000000
Call Trace:
 <TASK>
 unregister_netdevice_many net/core/dev.c:11875 [inline]
 unregister_netdevice_queue+0x33d/0x380 net/core/dev.c:11741
 unregister_netdevice include/linux/netdevice.h:3329 [inline]
 ppp_release+0xed/0x1f0 drivers/net/ppp/ppp_generic.c:410
 __fput+0x212/0xa60 fs/file_table.c:450
 task_work_run+0x1cb/0x240 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0x87e/0x2470 kernel/exit.c:938
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1087
 get_signal+0x1206/0x12c0 kernel/signal.c:3036
 arch_do_signal_or_restart+0x87/0x7a0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x8b/0x110 kernel/entry/common.c:218
 do_syscall_64+0xf1/0x1c0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7f35b2c05d29
Code: Unable to access opcode bytes at 0x7f35b2c05cff.
RSP: 002b:00007f35b1235038 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: 0000000000000005 RBX: 00007f35b2df6160 RCX: 00007f35b2c05d29
RDX: fdffffffffffffff RSI: 0000000000000000 RDI: 0000000020000100
RBP: 00007f35b2c81b08 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f35b2df6160 R15: 00007f35b2f1fa28
 </TASK>
Modules linked in:
---8<---

