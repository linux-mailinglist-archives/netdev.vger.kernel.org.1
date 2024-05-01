Return-Path: <netdev+bounces-92838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B328B9116
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 23:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81868B218AE
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 21:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC419161936;
	Wed,  1 May 2024 21:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gRlD7Re2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB8BD52F
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 21:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714599125; cv=none; b=Wzh5rlEzMDtdMlJuihvQO4jQK55NGyo7d4SznLaRY7iZXUgGwfx5WhkdBAGJs6enudBBFPpZ/xbfT08GuWKu+295qUREaiVYBVOFKeWWF2xkEnEf/Dn0euJoUL9Nnt7StuLG9sAI/6M++oWvRY3DJFv4RqhFO8It41jLWVkEI38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714599125; c=relaxed/simple;
	bh=B7pXh31bq6pdp+tp70UPfkiDLB5xGOEHax1SsvWMpgg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KQHCtur8A2sKFNWHndLw0zNgrfyljOjkSTr0R0lF61E7QbYOa30BDal2ajitU+eH607OnX7J2XUdlti2qMkZfhsn0I2SabBI0QaW4SzDGom7teQYxHihKUtcwnkDQPy2Nq/7n2quZN0fKUrp4IjpSNCuhuFzYFvLcWXgl5r36wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gRlD7Re2; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714599124; x=1746135124;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LyWx/ep85+C1UfoyP4Exzo2XI2vFrjCJ/QwsxKsdSg0=;
  b=gRlD7Re2yMI0092Ka7XWoheNo8aWenmTt+RPn8/51pHyffIILrjIpWBb
   b1Ex7G8swUnPVFcX6L5kH8uR1iQJXVtoKwtFveQw+xN44KsclNF6ydHb0
   Z/qrY+WYWkTrrk/o5R4F8aTdeje8bevtB3SpGTEAsJsq0365T2XfRkdgl
   M=;
X-IronPort-AV: E=Sophos;i="6.07,246,1708387200"; 
   d="scan'208";a="398462156"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 21:32:02 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:14515]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.46:2525] with esmtp (Farcaster)
 id d076a9f7-ea50-4752-87e3-140d281115e5; Wed, 1 May 2024 21:32:00 +0000 (UTC)
X-Farcaster-Flow-ID: d076a9f7-ea50-4752-87e3-140d281115e5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 1 May 2024 21:32:00 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Wed, 1 May 2024 21:31:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Anderson Nascimento <anderson@allelesecurity.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net] tcp: Use refcount_inc_not_zero() in tcp_twsk_unique().
Date: Wed, 1 May 2024 14:31:45 -0700
Message-ID: <20240501213145.62261-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA002.ant.amazon.com (10.13.139.60) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Anderson Nascimento reported a use-after-free splat in tcp_twsk_unique()
with nice analysis.

Since commit ec94c2696f0b ("tcp/dccp: avoid one atomic operation for
timewait hashdance"), inet_twsk_hashdance() sets TIME-WAIT socket's
sk_refcnt after putting it into ehash and releasing the bucket lock.

Thus, there is a small race window where other threads could try to
reuse the port during connect() and call sock_hold() in tcp_twsk_unique()
for the TIME-WAIT socket with zero refcnt.

If that happens, the refcnt taken by tcp_twsk_unique() is overwritten
and sock_put() will cause underflow, triggering a real use-after-free
somewhere else.

To avoid the use-after-free, we need to use refcount_inc_not_zero() in
tcp_twsk_unique() and give up on reusing the port if it returns false.

[0]:
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 0 PID: 1039313 at lib/refcount.c:25 refcount_warn_saturate+0xe5/0x110
CPU: 0 PID: 1039313 Comm: trigger Not tainted 6.8.6-200.fc39.x86_64 #1
Hardware name: VMware, Inc. VMware20,1/440BX Desktop Reference Platform, BIOS VMW201.00V.21805430.B64.2305221830 05/22/2023
RIP: 0010:refcount_warn_saturate+0xe5/0x110
Code: 42 8e ff 0f 0b c3 cc cc cc cc 80 3d aa 13 ea 01 00 0f 85 5e ff ff ff 48 c7 c7 f8 8e b7 82 c6 05 96 13 ea 01 01 e8 7b 42 8e ff <0f> 0b c3 cc cc cc cc 48 c7 c7 50 8f b7 82 c6 05 7a 13 ea 01 01 e8
RSP: 0018:ffffc90006b43b60 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888009bb3ef0 RCX: 0000000000000027
RDX: ffff88807be218c8 RSI: 0000000000000001 RDI: ffff88807be218c0
RBP: 0000000000069d70 R08: 0000000000000000 R09: ffffc90006b439f0
R10: ffffc90006b439e8 R11: 0000000000000003 R12: ffff8880029ede84
R13: 0000000000004e20 R14: ffffffff84356dc0 R15: ffff888009bb3ef0
FS:  00007f62c10926c0(0000) GS:ffff88807be00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020ccb000 CR3: 000000004628c005 CR4: 0000000000f70ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? refcount_warn_saturate+0xe5/0x110
 ? __warn+0x81/0x130
 ? refcount_warn_saturate+0xe5/0x110
 ? report_bug+0x171/0x1a0
 ? refcount_warn_saturate+0xe5/0x110
 ? handle_bug+0x3c/0x80
 ? exc_invalid_op+0x17/0x70
 ? asm_exc_invalid_op+0x1a/0x20
 ? refcount_warn_saturate+0xe5/0x110
 tcp_twsk_unique+0x186/0x190
 __inet_check_established+0x176/0x2d0
 __inet_hash_connect+0x74/0x7d0
 ? __pfx___inet_check_established+0x10/0x10
 tcp_v4_connect+0x278/0x530
 __inet_stream_connect+0x10f/0x3d0
 inet_stream_connect+0x3a/0x60
 __sys_connect+0xa8/0xd0
 __x64_sys_connect+0x18/0x20
 do_syscall_64+0x83/0x170
 entry_SYSCALL_64_after_hwframe+0x78/0x80
RIP: 0033:0x7f62c11a885d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a3 45 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007f62c1091e58 EFLAGS: 00000296 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 0000000020ccb004 RCX: 00007f62c11a885d
RDX: 0000000000000010 RSI: 0000000020ccb000 RDI: 0000000000000003
RBP: 00007f62c1091e90 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 00007f62c10926c0
R13: ffffffffffffff88 R14: 0000000000000000 R15: 00007ffe237885b0
 </TASK>

Fixes: ec94c2696f0b ("tcp/dccp: avoid one atomic operation for timewait hashdance")
Reported-by: Anderson Nascimento <anderson@allelesecurity.com>
Closes: https://lore.kernel.org/netdev/37a477a6-d39e-486b-9577-3463f655a6b7@allelesecurity.com/
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/tcp_ipv4.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index a22ee5838751..e0cef75f85fb 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -154,6 +154,12 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
 	if (tcptw->tw_ts_recent_stamp &&
 	    (!twp || (reuse && time_after32(ktime_get_seconds(),
 					    tcptw->tw_ts_recent_stamp)))) {
+		/* inet_twsk_hashdance() sets sk_refcnt after putting twsk
+		 * and releasing the bucket lock.
+		 */
+		if (unlikely(!refcount_inc_not_zero(&sktw->sk_refcnt)))
+			return 0;
+
 		/* In case of repair and re-using TIME-WAIT sockets we still
 		 * want to be sure that it is safe as above but honor the
 		 * sequence numbers and time stamps set as part of the repair
@@ -174,7 +180,7 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
 			tp->rx_opt.ts_recent	   = tcptw->tw_ts_recent;
 			tp->rx_opt.ts_recent_stamp = tcptw->tw_ts_recent_stamp;
 		}
-		sock_hold(sktw);
+
 		return 1;
 	}
 
-- 
2.30.2


