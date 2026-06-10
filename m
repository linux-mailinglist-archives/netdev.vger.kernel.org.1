Return-Path: <netdev+bounces-297470-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EY6lBkMCKWoXOwMAu9opvQ
	(envelope-from <netdev+bounces-297470-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:20:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CBB6662DE
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:20:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=L6s90IbZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297470-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297470-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6745D3076B5D
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0928374A17;
	Wed, 10 Jun 2026 06:17:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65488372EC1
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 06:17:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781072269; cv=none; b=khkKgyD3GCX4m+/lgaLE9As7pZpllXt2tGNZtgYCdE2rPUeW464e2lsl+GaYVVY2ZnVv3Wr32DO4V0JSKPjQtdWIoIgT5NuMCuPJpcMantueHB3uXBzTtBrMjGs8xn3VBnP+JFDS1vDC7Ili9TXlKhuXMW6uWxKTcs+1msgfH8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781072269; c=relaxed/simple;
	bh=x3J8utICuZD+Id/jYfQQJp3JVvfBDFJkvylSOGEVAH0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q3J+cuUAGbOEAvwIPF3R/Ie9pmmscah9nNv3rwI07d628K/5Fq81KOGQKENXrEaUAfgkAvNbEoTjR9R2Tm8NHb+VJwtjNHPnKS6elowgGARSIrbj4CL9c4C9vHdrHaQaCG/qM5PoVTw3Oyt8GwjT1Fag8HxX2wfF/PcIIagp5pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L6s90IbZ; arc=none smtp.client-ip=209.85.214.202
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0a99db8dfso69792535ad.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 23:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781072267; x=1781677067; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BSrOg+D1AbspXKlmBJRMFjp/yUhyqR5RSuTj/DPbL7Q=;
        b=L6s90IbZ1lSm9EoecLwKRVp5C1bnk7a2FDo+6U39Znzfy4lnDio0xtMk+8rXkg8DrH
         Sj3rPHPcVXNc6d28TdB9EmxFDmGtnDOsipsvEIei+/GYmmYAG11wvo0XAHN1NSn0pA9v
         guYePv9nEtCxx3EEELpa33rjBXn6jWB1P1c+56l9HwWqzEHlDvj/6nT1SDKcqd0sjFoC
         iyJkg6B+xgDTbltSjiDmwjl54Uh67j9+FfzuqeZ1Lu7LGwYUxosFFTX2WTX2FVZt5VPv
         4dCr+liB3iudwj7jz8tf6fVxuGM7Fp+W47nI7kOb+0yrsCellbYgdQ41yuDPs8u1ineQ
         Iw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781072267; x=1781677067;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BSrOg+D1AbspXKlmBJRMFjp/yUhyqR5RSuTj/DPbL7Q=;
        b=Y45VOC4KRwMthtSJK6/z1nYrfk7fTU/hF39wCMw7lcFivu2ih/urJdYyZ/8x1F8v77
         veLBqwLM4zlz5lPmZc4qnkqrYWlxhjhSxr0C8xV2U5ye+yPwQRbQqDFHSf/w6CwlZ1/i
         xIHaFH4YhLQ0SzuZ+Z6kyLT5qGGVEdYRKeWUzDiLEHaHxZFF74/PWNYH4uNF9osHizn9
         3esxTkgViRhhrn7HYK5oS6Sv1Ua3ECnvbDJPbhbmpVe5F5KaV6s2L7fpFs0bfqwszIkD
         ogT30y2MRlL2IoERmzONtsxyujQLVGlV/CDIHFp5+a9AoC1sKi5YPSFvq4/u2ky6ywcS
         xL+g==
X-Forwarded-Encrypted: i=1; AFNElJ97FJTYGyHXAt/uUKDhmlIC+lNrYpOUgHnwWnZCHLSPtNfySpyXllBcySW/4toiSiP7aMDgps0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0SgXhNKo2LBjHpRM6X/OhYEQQkC1w/4CIPbYVMy20muPgmwuW
	/XEsymhiQXOLozOe5pD3nZsR7KPL4iWi1PsX+hSpElRtGULmRJ27KamRoVQYmwmrRf5uurblcpA
	ik2e4SQ==
X-Received: from plhz18.prod.google.com ([2002:a17:902:d9d2:b0:2bd:34d1:ea8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:a46:b0:2c0:c37d:dfc1
 with SMTP id d9443c01a7336-2c1e820e316mr181038305ad.34.1781072267271; Tue, 09
 Jun 2026 23:17:47 -0700 (PDT)
Date: Wed, 10 Jun 2026 06:17:18 +0000
In-Reply-To: <20260610061744.2030996-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610061744.2030996-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610061744.2030996-2-kuniyu@google.com>
Subject: [PATCH v1 net 1/2] ipv4: fib: Don't dump dying fib_info in fib_leaf_notify().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Amit Cohen <amcohen@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+cb2aa2390ac024e25f5c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:amcohen@nvidia.com,m:jiri@resnulli.us,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:syzbot+cb2aa2390ac024e25f5c@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297470-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,resnulli.us,google.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,cb2aa2390ac024e25f5c];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B6CBB6662DE

syzbot reported use-after-free in nsim_fib4_prepare_event(). [0]

The problem is that the following functions call fib_info_hold() /
refcount_inc() while dumping fib_info under RCU, which is unsafe.

  * mlxsw_sp_router_fib4_event()
  * rocker_router_fib_event()
  * nsim_fib4_prepare_event()

refcount_inc_not_zero() must be used, but it would be too late
there.

Let's guarantee the lifetime of fib_info in fib_leaf_notify().

Note that IPv6 does not need the corresponding change since
fib6_table_dump() holds fib6_table.tb6_lock.

[0]:
refcount_t: addition on 0; use-after-free.
WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x9f/0x110 lib/refcount.c:25, CPU#0: kworker/u8:15/3420
Modules linked in:
CPU: 0 UID: 0 PID: 3420 Comm: kworker/u8:15 Not tainted syzkaller #0 PREEMPT_{RT,(full)}
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Workqueue: netns cleanup_net
RIP: 0010:refcount_warn_saturate+0x9f/0x110 lib/refcount.c:25
Code: eb 66 85 db 74 3e 83 fb 01 75 4c e8 1b f1 22 fd 48 8d 3d 84 cb f1 0a 67 48 0f b9 3a eb 4a e8 08 f1 22 fd 48 8d 3d 81 cb f1 0a <67> 48 0f b9 3a eb 37 e8 f5 f0 22 fd 48 8d 3d 7e cb f1 0a 67 48 0f
RSP: 0018:ffffc9000f2c7270 EFLAGS: 00010293
RAX: ffffffff84a18858 RBX: 0000000000000002 RCX: ffff888032ff9ec0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8f9353e0
RBP: 0000000000000000 R08: ffff888032ff9ec0 R09: 0000000000000005
R10: 0000000000000100 R11: 0000000000000004 R12: ffff8880570cc000
R13: dffffc0000000000 R14: ffff88802b40563c R15: ffff8880570cc000
FS:  0000000000000000(0000) GS:ffff888126173000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb1f4d5d000 CR3: 000000006072a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __refcount_add include/linux/refcount.h:-1 [inline]
 __refcount_inc include/linux/refcount.h:366 [inline]
 refcount_inc include/linux/refcount.h:383 [inline]
 fib_info_hold include/net/ip_fib.h:629 [inline]
 nsim_fib4_prepare_event drivers/net/netdevsim/fib.c:930 [inline]
 nsim_fib_event_schedule_work drivers/net/netdevsim/fib.c:1000 [inline]
 nsim_fib_event_nb+0x1055/0x1240 drivers/net/netdevsim/fib.c:1043
 call_fib_notifier+0x45/0x80 net/core/fib_notifier.c:25
 call_fib_entry_notifier net/ipv4/fib_trie.c:90 [inline]
 fib_leaf_notify net/ipv4/fib_trie.c:2176 [inline]
 fib_table_notify net/ipv4/fib_trie.c:2194 [inline]
 fib_notify+0x36b/0x5e0 net/ipv4/fib_trie.c:2217
 fib_net_dump net/core/fib_notifier.c:70 [inline]
 register_fib_notifier+0x184/0x360 net/core/fib_notifier.c:108
 nsim_fib_create+0x85d/0x9f0 drivers/net/netdevsim/fib.c:1596
 nsim_dev_reload_create drivers/net/netdevsim/dev.c:1604 [inline]
 nsim_dev_reload_up+0x374/0x7c0 drivers/net/netdevsim/dev.c:1058
 devlink_reload+0x501/0x8d0 net/devlink/dev.c:475
 devlink_pernet_pre_exit+0x1ff/0x420 net/devlink/core.c:558
 ops_pre_exit_list net/core/net_namespace.c:161 [inline]
 ops_undo_list+0x187/0x940 net/core/net_namespace.c:234
 cleanup_net+0x56e/0x800 net/core/net_namespace.c:702
 process_one_work kernel/workqueue.c:3314 [inline]
 process_scheduled_works+0xb5d/0x1860 kernel/workqueue.c:3397
 worker_thread+0xa53/0xfc0 kernel/workqueue.c:3478
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Fixes: 0ae3eb7b4611 ("netdevsim: fib: Perform the route programming in a non-atomic context")
Fixes: c3852ef7f2f8 ("ipv4: fib: Replay events when registering FIB notifier")
Reported-by: syzbot+cb2aa2390ac024e25f5c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a290011.39669fcc.33b062.00b1.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/ip_fib.h | 5 +++++
 net/ipv4/fib_trie.c  | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index 318593743b6e..541da2dde626 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -629,6 +629,11 @@ static inline void fib_info_hold(struct fib_info *fi)
 	refcount_inc(&fi->fib_clntref);
 }
 
+static inline bool fib_info_hold_safe(struct fib_info *fi)
+{
+	return refcount_inc_not_zero(&fi->fib_clntref);
+}
+
 static inline void fib_info_put(struct fib_info *fi)
 {
 	if (refcount_dec_and_test(&fi->fib_clntref))
diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 1308213791f1..dac543c1d686 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -2172,10 +2172,14 @@ static int fib_leaf_notify(struct key_vector *l, struct fib_table *tb,
 		if (fa->fa_slen == last_slen)
 			continue;
 
+		if (!fib_info_hold_safe(fa->fa_info))
+			continue;
+
 		last_slen = fa->fa_slen;
 		err = call_fib_entry_notifier(nb, FIB_EVENT_ENTRY_REPLACE,
 					      l->key, KEYLENGTH - fa->fa_slen,
 					      fa, extack);
+		fib_info_put(fa->fa_info);
 		if (err)
 			return err;
 	}
-- 
2.54.0.1099.g489fc7bff1-goog


