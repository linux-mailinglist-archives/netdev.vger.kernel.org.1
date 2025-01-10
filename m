Return-Path: <netdev+bounces-157036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A69A08C1E
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF7F188BDD1
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82945209F27;
	Fri, 10 Jan 2025 09:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="a/2LXzW5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56D51FECB1
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736501517; cv=none; b=m5qLUqHV63BkLgYtqcy+cAk+qGgVu2hQZduVMh+CV9pwIoJaZMyH8GRaZFu1JR2sumDO05N0T+nQgGvRflXXOMLcSwOIVdzaUr1N0LUcyQSdz3B2DjKL+wHtJke8tYgrIf6KgZz9ELn39H+h/WnOjnSDqal6m01MnFdg4lTH918=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736501517; c=relaxed/simple;
	bh=S4zrMgl7NyixYd02n/Q3dyfdZS0DSw1ZjFm9TgSRwpc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bv63T+WUOJGaP17MjFM0luv6+vVjYzpw4B9gP1eeH/6FaQtMy5nvTzoztsLUC9VdgFwfCL763iQKJlILY5vmaclH9u3kk36ydV4C11pwUPWudMauH3oeoMD1FWYTOFFJEOqEVg5Ij1laa7Na3qzbKQnOJ6Tm1kONgOYJd2aCWfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=a/2LXzW5; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736501516; x=1768037516;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VcfmV2krEnkd9vEiozkfxfOtUeg3hiAitDwT1lRHmEc=;
  b=a/2LXzW5DtQzztXMPHgV+6niSs7vnNAT94TLa0M/OuNhvOXkanqgkZMm
   1OG3gQWuDymUpTCWeTPACY6afbOS1H5f8iy8htHCdMdfuLwqamggqZGUw
   5OmiR8S7A8Z6ks8QEayJzEddezwVKhp4QE19F2JjJSKeOBXPuhtVFpCzG
   c=;
X-IronPort-AV: E=Sophos;i="6.12,303,1728950400"; 
   d="scan'208";a="688274840"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 09:31:53 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:39259]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.12:2525] with esmtp (Farcaster)
 id dd335672-883a-4fae-b8ca-99b1f6b1b3da; Fri, 10 Jan 2025 09:31:52 +0000 (UTC)
X-Farcaster-Flow-ID: dd335672-883a-4fae-b8ca-99b1f6b1b3da
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 09:31:51 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.252.101) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 09:31:48 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 11/12] af_unix: Set drop reason in unix_dgram_disconnected().
Date: Fri, 10 Jan 2025 18:26:40 +0900
Message-ID: <20250110092641.85905-12-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250110092641.85905-1-kuniyu@amazon.com>
References: <20250110092641.85905-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

unix_dgram_disconnected() is called from two places:

  1. when a connect()ed socket disconnect() or re-connect()s to
     another socket

  2. when sendmsg() fails because the peer socket that the client
     has connect()ed to has been close()d

Then, the client's recv queue is purged to remove all messages from
the old peer socket.

Let's define a new drop reason for that case.

  # echo 1 > /sys/kernel/tracing/events/skb/kfree_skb/enable

  # python3
  >>> from socket import *
  >>>
  >>> # s1 has a message from s2
  >>> s1, s2 = socketpair(AF_UNIX, SOCK_DGRAM)
  >>> s2.send(b'hello world')
  >>>
  >>> # re-connect() drops the message from s2
  >>> s3 = socket(AF_UNIX, SOCK_DGRAM)
  >>> s3.bind('')
  >>> s1.connect(s3.getsockname())

  # cat /sys/kernel/tracing/trace_pipe
     python3-250 ... kfree_skb: ... location=skb_queue_purge_reason+0xdc/0x110 reason: UNIX_DISCONNECT

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/dropreason-core.h | 7 +++++++
 net/unix/af_unix.c            | 4 +++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 43e20acaa98a..580be34ffa4f 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -11,6 +11,7 @@
 	FN(SOCKET_INVALID_STATE)	\
 	FN(SOCKET_RCVBUFF)		\
 	FN(SOCKET_RCV_SHUTDOWN)		\
+	FN(UNIX_DISCONNECT)		\
 	FN(UNIX_INFLIGHT_FD_LIMIT)	\
 	FN(UNIX_SKIP_OOB)		\
 	FN(PKT_TOO_SMALL)		\
@@ -152,6 +153,12 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_SOCKET_RCVBUFF,
 	/** @SKB_DROP_REASON_SOCKET_RCV_SHUTDOWN: socket is shutdown(SHUT_RD) */
 	SKB_DROP_REASON_SOCKET_RCV_SHUTDOWN,
+	/**
+	 * @SKB_DROP_REASON_UNIX_DISCONNECT: recv queue is purged when SOCK_DGRAM
+	 * or SOCK_SEQPACKET socket re-connect()s to another socket or notices
+	 * during send() that the peer has been close()d.
+	 */
+	SKB_DROP_REASON_UNIX_DISCONNECT,
 	/**
 	 * @SKB_DROP_REASON_UNIX_INFLIGHT_FD_LIMIT: too many file descriptors
 	 * are passed via SCM_RIGHTS but not yet received, reaching RLIMIT_NOFILE.
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 80c979266d37..b976f59dbcdd 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -622,7 +622,9 @@ static void unix_write_space(struct sock *sk)
 static void unix_dgram_disconnected(struct sock *sk, struct sock *other)
 {
 	if (!skb_queue_empty(&sk->sk_receive_queue)) {
-		skb_queue_purge(&sk->sk_receive_queue);
+		skb_queue_purge_reason(&sk->sk_receive_queue,
+				       SKB_DROP_REASON_UNIX_DISCONNECT);
+
 		wake_up_interruptible_all(&unix_sk(sk)->peer_wait);
 
 		/* If one link of bidirectional dgram pipe is disconnected,
-- 
2.39.5 (Apple Git-154)


