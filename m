Return-Path: <netdev+bounces-262110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id koeMAe3NommC5gQAu9opvQ
	(envelope-from <netdev+bounces-262110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 12:13:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D211D1C2831
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 12:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 185CE3024B3B
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 11:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B0E42DFF2;
	Sat, 28 Feb 2026 11:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jYJ1YA/D"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724A336C5BB
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772277222; cv=none; b=U75tkGYybQtr2gTvf+DpNEny2RLKPX6GWDyW/yyL3pdyE/cg96QCoJkLEfILy7BxZ7IPRpuauuaLlMfmDrtvhfa0DRCEtvAEARscSBOcJfrxje9Z2AQ8SnqV9+l2HnIUJQ5XKsRA8nvGWSxztR8Tpc5cwapHtX1CUr/RlkHOAyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772277222; c=relaxed/simple;
	bh=KEtfPjmed9vc8UYUJTd5WRO0PKUsvItWzznuXA+LWAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ebm8v/Fn1fsR/8fqib+8raOjF67h3hz1GGCy2+2SUw1ASplleYPhDil3GNCBNWLu1Gv7SjVA9gg7dZpKY00TCEpJGb/6TsXQ/J37w2odG8kyB0TgId9Y6Zznkv+Q4EIss5YY7QhFKPI4k0gRVgCdJ8DCG7Hyecdgzn4ZoquHB0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jYJ1YA/D; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772277208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9Yg7j2EaokeIvhOnMiy2qGul7Iq/hLXN+CkZ2bmenGc=;
	b=jYJ1YA/DLC21QSpt5yFgGbUCKT5Kl7xSe7ek3iek8flsxo51hy6UcglF27f331wQSCPG/U
	xW92eKHrdnN0PrOB6Zz4LExpsYkPUJklV/rLPQ9dT2QLAlQtYVKxZ7Mv8e31W4cWTCk/4w
	5TNFNeDT+ZHeixhJxN6Qf157D+2HuYw=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org,
	edumazet@google.com
Cc: jiayuan.chen@linux.dev,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
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
Subject: [PATCH net-next v2] net: fix sock compilation error under CONFIG_PREEMPT_RT
Date: Sat, 28 Feb 2026 19:13:18 +0800
Message-ID: <20260228111319.79506-1-jiayuan.chen@linux.dev>
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
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262110-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,shopee.com,google.com,redhat.com,davemloft.net,kernel.org,linutronix.de,goodmis.org,gmail.com,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D211D1C2831
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
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 net/core/sock.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 9d841975a7a1..fba4d5b8553c 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3782,12 +3782,15 @@ void noinline lock_sock_nested(struct sock *sk, int subclass)
 	might_sleep();
 #ifdef CONFIG_64BIT
 	if (sizeof(struct slock_owned) == sizeof(long)) {
-		socket_lock_t tmp, old;
+		socket_lock_t tmp = {
+			.slock = __SPIN_LOCK_UNLOCKED(tmp.slock),
+			.owned = 1,
+		};
+		socket_lock_t old = {
+			.slock = __SPIN_LOCK_UNLOCKED(old.slock),
+			.owned = 0,
+		};
 
-		tmp.slock = __SPIN_LOCK_UNLOCKED(tmp.slock);
-		tmp.owned = 1;
-		old.slock = __SPIN_LOCK_UNLOCKED(old.slock);
-		old.owned = 0;
 		if (likely(try_cmpxchg(&sk->sk_lock.combined,
 				       &old.combined, tmp.combined)))
 			return;
-- 
2.43.0


