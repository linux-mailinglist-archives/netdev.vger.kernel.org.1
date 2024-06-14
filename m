Return-Path: <netdev+bounces-103719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB156909331
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 22:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023E1283169
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 20:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2871A3BBC;
	Fri, 14 Jun 2024 20:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kkR0r9/p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD66919D07B
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 20:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718395757; cv=none; b=Jg6mAxuAQT7SIHbvjwrJlA33cOX2q7hV/ZsGI/d3VRiH68XtXzRdqzToZ6/YdpgIKO4ucYUO4kBLGOjLf8FLb4WfLrKsiJSyRhTrwv8bcWqEh/ePHbRFPvd3RcSTGP43M7Skt5zmd0uGHn5SsOp3qmHpXH6Tu+ei8zX9GP5YzgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718395757; c=relaxed/simple;
	bh=6R8FxnfyeycEg1m7rvkU4okd9RzkHhRjB4kA9f0WVxQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDwbotWeV+Nn0HNtBhLLr1oXOsM9tp5RzLAebiWn6F+MRsngGDF2/E/aAgAZpITAYmU8WcKfKTDaB3UwERf8LSlPmTfX9psyHR8fTHQ4FLopHlLB93jwZwLs83/rRi/DbtU2c4m6G6WNyhlgfwgvS518SDt4KAl5q4BBIPhUS5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kkR0r9/p; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718395755; x=1749931755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9mRLek59kVD+Fbql2cTNJH5Zh5vD8k1rI3BcBAV+Qro=;
  b=kkR0r9/pfz9ky36kxr2f7kJ4n2k5I76ALK1yhjgECeZ7PMKNhrUHtyxP
   G/zbujkAK2q6FLDeQ3/iz5/S0dpFfOO5eW551XdXy6KldjQDzNGeLq4BZ
   MEqB8AvDWNZOv+ursQanKaIQjb6FYVVSJB6DiDMvpEoQoNtJAQzdCQsp6
   M=;
X-IronPort-AV: E=Sophos;i="6.08,238,1712620800"; 
   d="scan'208";a="303533485"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 20:09:13 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:8005]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.144:2525] with esmtp (Farcaster)
 id 68266e9c-0089-4338-b41b-5064c416e6df; Fri, 14 Jun 2024 20:09:12 +0000 (UTC)
X-Farcaster-Flow-ID: 68266e9c-0089-4338-b41b-5064c416e6df
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 20:09:12 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 20:09:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 04/11] af_unix: Define locking order for U_LOCK_SECOND in unix_stream_connect().
Date: Fri, 14 Jun 2024 13:07:08 -0700
Message-ID: <20240614200715.93150-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240614200715.93150-1-kuniyu@amazon.com>
References: <20240614200715.93150-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

While a SOCK_(STREAM|SEQPACKET) socket connect()s to another, we hold
two locks of them by unix_state_lock() and unix_state_lock_nested() in
unix_stream_connect().

Before unix_state_lock_nested(), the following is guaranteed by checking
sk->sk_state:

  1. The first socket is TCP_LISTEN
  2. The second socket is not the first one
  3. Simultaneous connect() must fail

So, the client state can be TCP_CLOSE or TCP_LISTEN or TCP_ESTABLISHED.

Let's define the expected states as unix_state_lock_cmp_fn() instead of
using unix_state_lock_nested().

Note that 2. is detected by debug_spin_lock_before() and 3. cannot be
expressed as lock_cmp_fn.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h |  1 -
 net/unix/af_unix.c    | 26 +++++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index b6eedf7650da..fd813ad73ab8 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -98,7 +98,6 @@ struct unix_sock {
 #define unix_state_unlock(s)	spin_unlock(&unix_sk(s)->lock)
 enum unix_socket_lock_class {
 	U_LOCK_NORMAL,
-	U_LOCK_SECOND,	/* for double locking, see unix_state_double_lock(). */
 	U_LOCK_DIAG, /* used while dumping icons, see sk_diag_dump_icons(). */
 	U_LOCK_GC_LISTENER, /* used for listening socket while determining gc
 			     * candidates to close a small race window.
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 88f2c5d039c4..5d2728e33f3f 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -143,6 +143,30 @@ static int unix_state_lock_cmp_fn(const struct lockdep_map *_a,
 	a = container_of(_a, struct unix_sock, lock.dep_map);
 	b = container_of(_b, struct unix_sock, lock.dep_map);
 
+	if (a->sk.sk_state == TCP_LISTEN) {
+		/* unix_stream_connect(): Before the 2nd unix_state_lock(),
+		 *
+		 *   1. a is TCP_LISTEN.
+		 *   2. b is not a.
+		 *   3. concurrent connect(b -> a) must fail.
+		 *
+		 * Except for 2. & 3., the b's state can be any possible
+		 * value due to concurrent connect() or listen().
+		 *
+		 * 2. is detected in debug_spin_lock_before(), and 3. cannot
+		 * be expressed as lock_cmp_fn.
+		 */
+		switch (b->sk.sk_state) {
+		case TCP_CLOSE:
+		case TCP_ESTABLISHED:
+		case TCP_LISTEN:
+			return -1;
+		default:
+			/* Invalid case. */
+			return 0;
+		}
+	}
+
 	/* unix_state_double_lock(): ascending address order. */
 	return cmp_ptr(a, b);
 }
@@ -1585,7 +1609,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		goto out_unlock;
 	}
 
-	unix_state_lock_nested(sk, U_LOCK_SECOND);
+	unix_state_lock(sk);
 
 	if (unlikely(sk->sk_state != TCP_CLOSE)) {
 		err = sk->sk_state == TCP_ESTABLISHED ? -EISCONN : -EINVAL;
-- 
2.30.2


