Return-Path: <netdev+bounces-103718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F58C909330
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 22:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6B2EB248A4
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 20:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C33D1A2549;
	Fri, 14 Jun 2024 20:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LrxUQvvt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9066819D07B
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 20:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718395734; cv=none; b=Iyrqo0NV1DmAl7o8krhTN4n/bCb8rwj9ml1nIopNL3sMLN+OGOH3/pYRz8PWqsdNqr4zxXM8gyjUwjMKD1b/p18RtIpFvxaTehUBwIQpBu6YBxluCxC/2OLJmK317igrY9I7ze0pUtddGQY5+VUHYiDWCBDEkT9bcD/TW7I1FAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718395734; c=relaxed/simple;
	bh=oo9kUpHgqtlnvnBVqmQIdKPntHyFYZI4faFeS7T/7bM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a6vBvRTRy1iWkwqhWkZwCTiDW0QMJppOx31AmVtS5/oyZzjiq+LVKVFKVO+VPmYf7s1AriO45wL3uRCwtLONSe60b9JqGQajIDzeEglvopEmYdtTjqWABmsYT04RXxkdl7GQAsgOJltUuXlaBKbj+q5QVFs5t3AU8CanjKRXDEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LrxUQvvt; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718395732; x=1749931732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=52YDTmTPm70wpoBLbJHOxUa+C1kEK3wwGi8I2TxztDE=;
  b=LrxUQvvt3O3yY8+844QKTOWfiWjGH/s5hyaqmrpd2vhLhOpQakrm/0F7
   96W73YeKa/ri36B0+2u+4NyUKUn7WJjU7w9y1vVJRWkuNg2ILeHjH8+Ub
   rr1TSXkxL4u1j4VmJuedCOTxyHyOIEfcW5elM2K8jZ10UnqAwWGcv0hjx
   Y=;
X-IronPort-AV: E=Sophos;i="6.08,238,1712620800"; 
   d="scan'208";a="96919930"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 20:08:50 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:51084]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.14:2525] with esmtp (Farcaster)
 id 337f2e72-f877-4499-a16e-32923bbbecad; Fri, 14 Jun 2024 20:08:50 +0000 (UTC)
X-Farcaster-Flow-ID: 337f2e72-f877-4499-a16e-32923bbbecad
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 20:08:47 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 20:08:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 03/11] af_unix: Don't retry after unix_state_lock_nested() in unix_stream_connect().
Date: Fri, 14 Jun 2024 13:07:07 -0700
Message-ID: <20240614200715.93150-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D045UWC001.ant.amazon.com (10.13.139.223) To
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

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 0657f599bbef..88f2c5d039c4 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1496,6 +1496,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	struct unix_sock *u = unix_sk(sk), *newu, *otheru;
 	struct net *net = sock_net(sk);
 	struct sk_buff *skb = NULL;
+	unsigned char state;
 	long timeo;
 	int err;
 
@@ -1546,7 +1547,6 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		goto out;
 	}
 
-	/* Latch state of peer */
 	unix_state_lock(other);
 
 	/* Apparently VFS overslept socket death. Retry. */
@@ -1576,37 +1576,21 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
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
+	state = READ_ONCE(sk->sk_state);
+	if (unlikely(state != TCP_CLOSE)) {
+		err = state == TCP_ESTABLISHED ? -EISCONN : -EINVAL;
 		goto out_unlock;
 	}
 
 	unix_state_lock_nested(sk, U_LOCK_SECOND);
 
-	if (sk->sk_state != TCP_CLOSE) {
+	if (unlikely(sk->sk_state != TCP_CLOSE)) {
+		err = sk->sk_state == TCP_ESTABLISHED ? -EISCONN : -EINVAL;
 		unix_state_unlock(sk);
-		unix_state_unlock(other);
-		sock_put(other);
-		goto restart;
+		goto out_unlock;
 	}
 
 	err = security_unix_stream_connect(sk, other, newsk);
-- 
2.30.2


