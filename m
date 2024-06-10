Return-Path: <netdev+bounces-102373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C31902BC3
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 00:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56943281F88
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 22:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9255E7E591;
	Mon, 10 Jun 2024 22:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="thbpiW55"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E0B5466B
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 22:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718059022; cv=none; b=SX1aMoMeMmPa4eJ6lkF2bnyRxK4u+X+7BksjXBj7HFl2btxtxUkXz4dFpvmGMcdRw01jZMg7Yb6jOXfrL+XTbAat4vFvUNRHwAf8BOohQIqcoAEghToDQBlEkPxgSzndWHD4yCjufWDiVNf9q/GiSM5dCrAt/kDPMPgm4Zv4YY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718059022; c=relaxed/simple;
	bh=qk+YQUeWj7S6QjuVQNAPbwC1qg9eSRopyL2BnSFvkmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vd1wrlHHbB9YrgBRmmDOo3eYDtOghzQ2ugBycdM/sJUs2VuttkzK7ZZvFf3ibhjUttmUobOo1cJq36ksTvLWVGQJSbVkrqwhJ0rmKczZq2T/LIqqx1oJZ4Hpgf7DeX/un1hn23wvTXbaU6l9Ef8QJ6F0uurSho83meaz+fwSZfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=thbpiW55; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718059021; x=1749595021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FWGV5ybjoYxFCE3O0ZspXFs1D3WfEyXk/LTWKdM5hKg=;
  b=thbpiW55izuYZO6Rube5S6FuU2vgZ/v9+UxrIgLCZCdATeNw5kR6x5U8
   enhSRezdRJyd/hZInGZEr+6e2ArEW2s4SgWdVCLkfPC3d+SP28oZVkY9s
   PHZ4qDlVJVewW5ewUYiPmsL/TZReohMxCngWxVRc4MO+R/5us/UsucMCI
   I=;
X-IronPort-AV: E=Sophos;i="6.08,228,1712620800"; 
   d="scan'208";a="349585352"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 22:36:54 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:16000]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.183:2525] with esmtp (Farcaster)
 id b5d30798-c2ef-4fb8-833d-b746530afeff; Mon, 10 Jun 2024 22:36:54 +0000 (UTC)
X-Farcaster-Flow-ID: b5d30798-c2ef-4fb8-833d-b746530afeff
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 10 Jun 2024 22:36:53 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 10 Jun 2024 22:36:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 04/11] af_unix: Define locking order for U_LOCK_SECOND in unix_stream_connect().
Date: Mon, 10 Jun 2024 15:34:54 -0700
Message-ID: <20240610223501.73191-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240610223501.73191-1-kuniyu@amazon.com>
References: <20240610223501.73191-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC002.ant.amazon.com (10.13.139.222) To
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
index c76d37575c58..7402ffd999ce 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -141,6 +141,30 @@ static int unix_state_lock_cmp_fn(const struct lockdep_map *_a,
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
 	return a < b ? -1 : 0;
 }
@@ -1581,7 +1605,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		goto out_unlock;
 	}
 
-	unix_state_lock_nested(sk, U_LOCK_SECOND);
+	unix_state_lock(sk);
 
 	if (unlikely(sk->sk_state != TCP_CLOSE)) {
 		err = sk->sk_state == TCP_ESTABLISHED ? -EISCONN : -EINVAL;
-- 
2.30.2


