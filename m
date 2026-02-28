Return-Path: <netdev+bounces-262103-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC+uMcywomkC5AQAu9opvQ
	(envelope-from <netdev+bounces-262103-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 10:09:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 367521C198C
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 10:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E29D302BA6C
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 09:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6593EDACC;
	Sat, 28 Feb 2026 09:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vMQjd5+8"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379A23ED130
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 09:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772269639; cv=none; b=NWIllzO3r2dTlpjlnT+6Y1QgANwNoxnKmOk2LOyLtizZcqZOL/Nfh77VPPB0bZoU5VpTiRHvVDBTg78dcSN+NEYwxGTvfCNbpRw+j0KqoWqKeaFdyqbHcpiadBxgWpykEwheFonlwfvA49yGFAJoeHOL9Yon4zHmZXxy+rGuf4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772269639; c=relaxed/simple;
	bh=FYDCrvmbavmVMM0l/9ogzr+nuZLVBuDVcwYj3BWg0iU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aAqip8d9qNTlyIP9wVmSVlb0RYdc6HOpxQYto/OMmRj4aI0+TZQfPvFADAyajzkekbyW3awESTezTPwbA/SU1ullld+6+r5hb4LiRvwqX0jpW8rabl+0nJDxUe2KlfPOyzhyPUvAeJmcc9nPkVgwt6gK4M2LHY746EojWpaXIgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vMQjd5+8; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772269625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C5U/yNy/KMt3+3/ZSU8Fyr9O8lEuu9x3SLzaQ0k6sD0=;
	b=vMQjd5+8irnCjtAKozlW/91o6SA1mUUrx2tIUl/MxfzcCjdoqS0WDEzXJkAHEHKHG0QlPU
	PgdANnYo5EuAtPvTGs3iCay1cdBZONUJXGmgjZzrj/oa9d5IBIcjQ9A2nHH4a5kxy05Qp5
	oXUNFCT0KD3Jq5A9UWj4wsxqFIxKazA=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: jiayuan.chen@linux.dev,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH net-next v1] net: fix sock compilation error under CONFIG_PREEMPT_RT
Date: Sat, 28 Feb 2026 17:06:43 +0800
Message-ID: <20260228090644.362807-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,shopee.com,google.com,redhat.com,davemloft.net,kernel.org,linutronix.de,goodmis.org,gmail.com,vger.kernel.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262103-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:email,linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 367521C198C
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

When CONFIG_PREEMPT_RT is enabled, __SPIN_LOCK_UNLOCKED() expands to a
brace-enclosed initializer rather than a compound literal, which cannot
be used in assignment expressions. This causes a build failure:

  net/core/sock.c:3787:29: error: expected expression before '{' token
   3787 |                 tmp.slock = __SPIN_LOCK_UNLOCKED(tmp.slock);

Use declaration-with-initializer instead of assignment, consistent with
how __SPIN_LOCK_UNLOCKED() is used elsewhere in the kernel (e.g.
DEFINE_SPINLOCK).

Fixes: 5151ec54f586 ("net: use try_cmpxchg() in lock_sock_nested()")
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 net/core/sock.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 9d841975a7a1..2461aba7b18a 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3782,12 +3782,10 @@ void noinline lock_sock_nested(struct sock *sk, int subclass)
 	might_sleep();
 #ifdef CONFIG_64BIT
 	if (sizeof(struct slock_owned) == sizeof(long)) {
-		socket_lock_t tmp, old;
-
-		tmp.slock = __SPIN_LOCK_UNLOCKED(tmp.slock);
-		tmp.owned = 1;
-		old.slock = __SPIN_LOCK_UNLOCKED(old.slock);
-		old.owned = 0;
+		socket_lock_t tmp = { .slock = __SPIN_LOCK_UNLOCKED(tmp.slock),
+				      .owned = 1 };
+		socket_lock_t old = { .slock = __SPIN_LOCK_UNLOCKED(old.slock),
+				      .owned = 0 };
 		if (likely(try_cmpxchg(&sk->sk_lock.combined,
 				       &old.combined, tmp.combined)))
 			return;
-- 
2.43.0


