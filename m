Return-Path: <netdev+bounces-102372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C277A902BC2
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 00:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F9028789E
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 22:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9B91474B4;
	Mon, 10 Jun 2024 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IhAKxB3q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483715466B
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 22:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718058994; cv=none; b=QTlIIZHR9IO2Do9hTUPL5W4K4G9jTqa8N3s7ddOf/yqEq6+J2rxzlnFRbWgLwrrfqSihfnB8gnWUq5Z5Qped+lVwC683oSq/2nuyo0gm5Hyq5qpM3xegOAiM1uDW7732qlMybaZAxNhewyPVDbKBhYp8jOFUyYxPVCl+OAkH+N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718058994; c=relaxed/simple;
	bh=QdiEHPjHUhC0xXR50C1esf5P6TH+NC/xpxy64/9LzsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BaL2Oer+U9h9uOtZY0YGghIAfiMWawUvrkF6cuGWDL9b7coiq0j7lHkgYxY1tXergq3dmNRJxLBCvWuRXEtGBWLSCw3AXrwiLf6I8g2Mb4mLqXjAsFCRPBrnThxsfAkJKh4JY29ApC+oaG4n+SSk9cNAHVSaHwHGhXIDSRSgiPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=IhAKxB3q; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718058994; x=1749594994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xmQQQvXhQSVDUxZ7EX+K9GJkILcadC2p9SX6Wqia10U=;
  b=IhAKxB3qeNe2LFo63wx5kJSSDEPxKuOmWtEf0osKkhjOOTvRhAo7vkSV
   x2PSKUo9G0UXaYfgnnIYl1qf7QoR6tQoHD/qQWMFoZeL7FgXdthrbXmoe
   EI8e1jNKwXUgGz1912brQKs8PfUpH5FAriOW2HWKhSQNCM0NDVv5gNKQy
   M=;
X-IronPort-AV: E=Sophos;i="6.08,228,1712620800"; 
   d="scan'208";a="406948582"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 22:36:31 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:42188]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.183:2525] with esmtp (Farcaster)
 id 72422c34-dab7-4ce0-b0a6-ccb1f77e0871; Mon, 10 Jun 2024 22:36:29 +0000 (UTC)
X-Farcaster-Flow-ID: 72422c34-dab7-4ce0-b0a6-ccb1f77e0871
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 10 Jun 2024 22:36:29 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 10 Jun 2024 22:36:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 03/11] af_unix: Don't retry after unix_state_lock_nested() in unix_stream_connect().
Date: Mon, 10 Jun 2024 15:34:53 -0700
Message-ID: <20240610223501.73191-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When a SOCK_(STREAM|SEQPACKET) socket connect()s to another one, we need
to lock the two sockets to check their states in unix_stream_connect().

We use unix_state_lock() for the server and unix_state_lock_nested() for
client with tricky sk->sk_state check to avoid deadlock.

The possible deadlock scenario are the following:

  1) Self connect()
  2) Simultaneous connect()

The former is simple, attempt to grab the same lock, and the latter is
AB-BA deadlock.

After the server's unix_state_lock(), we check the server socket's state,
and if it's not TCP_LISTEN, connect() fails with -EINVAL.

Then, we avoid the former deadlock by checking the client's state before
unix_state_lock_nested().  If its state is not TCP_LISTEN, we can make
sure that the client and the server are not identical based on the state.

Also, the latter deadlock can be avoided in the same way.  Due to the
server sk->sk_state requirement, AB-BA deadlock could happen only with
TCP_LISTEN sockets.  So, if the client's state is TCP_LISTEN, we can
give up the second lock to avoid the deadlock.

  CPU 1                 CPU 2                  CPU 3
  connect(A -> B)       connect(B -> A)        listen(A)
  ---                   ---                    ---
  unix_state_lock(B)
  B->sk_state == TCP_LISTEN
  READ_ONCE(A->sk_state) == TCP_CLOSE
                            ^^^^^^^^^
                            ok, will lock A    unix_state_lock(A)
             .--------------'                  WRITE_ONCE(A->sk_state, TCP_LISTEN)
             |                                 unix_state_unlock(A)
             |
             |          unix_state_lock(A)
             |          A->sk_sk_state == TCP_LISTEN
             |          READ_ONCE(B->sk_state) == TCP_LISTEN
             v                                    ^^^^^^^^^^
  unix_state_lock_nested(A)                       Don't lock B !!

Currently, while checking the client's state, we also check if it's
TCP_ESTABLISHED, but this is unlikely and can be checked after we know
the state is not TCP_CLOSE.

Moreover, if it happens after the second lock, we now jump to the restart
label, but it's unlikely that the server is not found during the retry,
so the jump is mostly to revist the client state check.

Let's remove the retry logic and check the state against TCP_CLOSE first.

Note that sk->sk_state does not change once it's changed from TCP_CLOSE,
so READ_ONCE() is not needed in the second state read in the first check.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 16878452eaad..c76d37575c58 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1544,7 +1544,6 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		goto out;
 	}
 
-	/* Latch state of peer */
 	unix_state_lock(other);
 
 	/* Apparently VFS overslept socket death. Retry. */
@@ -1574,37 +1573,20 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		goto restart;
 	}
 
-	/* Latch our state.
-
-	   It is tricky place. We need to grab our state lock and cannot
-	   drop lock on peer. It is dangerous because deadlock is
-	   possible. Connect to self case and simultaneous
-	   attempt to connect are eliminated by checking socket
-	   state. other is TCP_LISTEN, if sk is TCP_LISTEN we
-	   check this before attempt to grab lock.
-
-	   Well, and we have to recheck the state after socket locked.
+	/* self connect and simultaneous connect are eliminated
+	 * by rejecting TCP_LISTEN socket to avoid deadlock.
 	 */
-	switch (READ_ONCE(sk->sk_state)) {
-	case TCP_CLOSE:
-		/* This is ok... continue with connect */
-		break;
-	case TCP_ESTABLISHED:
-		/* Socket is already connected */
-		err = -EISCONN;
-		goto out_unlock;
-	default:
-		err = -EINVAL;
+	if (unlikely(READ_ONCE(sk->sk_state) != TCP_CLOSE)) {
+		err = sk->sk_state == TCP_ESTABLISHED ? -EISCONN : -EINVAL;
 		goto out_unlock;
 	}
 
 	unix_state_lock_nested(sk, U_LOCK_SECOND);
 
-	if (sk->sk_state != TCP_CLOSE) {
-		unix_state_unlock(sk);
-		unix_state_unlock(other);
-		sock_put(other);
-		goto restart;
+	if (unlikely(sk->sk_state != TCP_CLOSE)) {
+		err = sk->sk_state == TCP_ESTABLISHED ? -EISCONN : -EINVAL;
+		unix_state_lock(sk);
+		goto out_unlock;
 	}
 
 	err = security_unix_stream_connect(sk, other, newsk);
-- 
2.30.2


