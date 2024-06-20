Return-Path: <netdev+bounces-105457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 814219113F0
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 22:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21AE1C210CD
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 20:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3EC7350E;
	Thu, 20 Jun 2024 20:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="U9E6fIVR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936DB74267
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 20:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718917100; cv=none; b=GtJ7oz9awXV7xol0d/1jJtdDXanRoL2MeMysECzqbsm19WVPQY2gHN+qqzodDZhXTsSYOkApqkZ449hOPv/dtEh4crPd4yl4gRXUQ+tMLlDecyBgyNORZ0cWEAwzDHkj1oY2y+XdWi8fMdjJUe0JL6o/S2k8EPmPhJdq81rPrX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718917100; c=relaxed/simple;
	bh=WA0fgBZVvwa9cyJYSUI8yb4/kVuibL+f2PmT22JmPFg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NSZRt3SLVQgpYo5OB1T8XlFJ5Bjd4qyaPKqRoPlFGcYjMbw+1dYBnjAo7vD34CJHFdGpnRDKkncDN0orivy27IT7oIf7Zy2/Plm3SCKYhOjZm0BR42Nvqb6wKDF6b+1q1enpM3N3yr32BzhaXVwCdDDXSQcSQySqi6MM7pB236E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=U9E6fIVR; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718917099; x=1750453099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CqCa8JChY8mgrmW325qgu9HyfoK4rRcy5x1VOXrK7QU=;
  b=U9E6fIVRoe5Jo2FNSutVs7xw6llrKQQuycYGksH2TBkDTCc/NEtBb1Rb
   EhawmJkcXt/r0xntz03iN5u+OWSr8x5UrLcsuA87J2fNU3nGipGaENfah
   XnzzLjWenqu3gq7/qLfSvTn3Nyw+6J0/igXjvSvBpXSE/OTNAUYFNBob6
   M=;
X-IronPort-AV: E=Sophos;i="6.08,252,1712620800"; 
   d="scan'208";a="427711899"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 20:58:13 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:19970]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.237:2525] with esmtp (Farcaster)
 id 76936bb0-9bee-4753-8314-16e714829585; Thu, 20 Jun 2024 20:58:12 +0000 (UTC)
X-Farcaster-Flow-ID: 76936bb0-9bee-4753-8314-16e714829585
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 20 Jun 2024 20:58:12 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 20:58:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v4 net-next 04/11] af_unix: Define locking order for U_LOCK_SECOND in unix_stream_connect().
Date: Thu, 20 Jun 2024 13:56:16 -0700
Message-ID: <20240620205623.60139-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240620205623.60139-1-kuniyu@amazon.com>
References: <20240620205623.60139-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA002.ant.amazon.com (10.13.139.11) To
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
 net/unix/af_unix.c    | 37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 2 deletions(-)

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
index 88f2c5d039c4..a092d6999ae0 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -143,6 +143,41 @@ static int unix_state_lock_cmp_fn(const struct lockdep_map *_a,
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
+	/* Should never happen.  Just to be symmetric. */
+	if (b->sk.sk_state == TCP_LISTEN) {
+		switch (b->sk.sk_state) {
+		case TCP_CLOSE:
+		case TCP_ESTABLISHED:
+			return 1;
+		default:
+			return 0;
+		}
+	}
+
 	/* unix_state_double_lock(): ascending address order. */
 	return cmp_ptr(a, b);
 }
@@ -1585,7 +1620,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		goto out_unlock;
 	}
 
-	unix_state_lock_nested(sk, U_LOCK_SECOND);
+	unix_state_lock(sk);
 
 	if (unlikely(sk->sk_state != TCP_CLOSE)) {
 		err = sk->sk_state == TCP_ESTABLISHED ? -EISCONN : -EINVAL;
-- 
2.30.2


