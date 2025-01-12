Return-Path: <netdev+bounces-157498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 868ACA0A728
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 05:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615221885F5C
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 04:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D328825761;
	Sun, 12 Jan 2025 04:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Y2xeBxta"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A6F14293
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 04:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736655173; cv=none; b=rvIFy7Vl+be7iVqfDFSmI+NaAS4+7YOdew4EkLT+GjXa3Ex0jkWmXgQNCIFXAmF9/59wKK5kEibRXJhH1Nwo/MLMEIJ6a9rv3uHpaOvyicXT0GDaoH+uR/4D5wXLj4PanhoXB1Uup8wSZKZsS0RzTCE7Y+fkygkQN4l4+9r6TKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736655173; c=relaxed/simple;
	bh=3+nONSUDtdlcgTiTcAxyYMV7OfuT36ipXqK9s2f8yyU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=upN1/kQ6axqT/7vsjz9yXEqIoTCo2V2ZHbqIpeJ7Ulf/mFhCzE8whwTVoWej3ihTPDaFkrUGvvcBEqFy8Z1Hw9iJogz665803CGuJ8lSCt9mTEJF261WngwYuzG5q6KORjjCP0GVIsXMJf9QIBia4qRTVomw4IDkfJQxdPOnVqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Y2xeBxta; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736655173; x=1768191173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=axHSZOVSl2hIHS46F2W8wsOJ3Qr55ftuoMvh4OhTkt0=;
  b=Y2xeBxtaIB9kyJ0km1FlSPb71ercdP/WbrDwUVImpNhmCE7p5QeUjXH7
   a2DG0HOSQ/pqnbDrM6P035Q+FUrYDpwbmiJU5+B+HOUpbJacMrLUfAnHJ
   1YI023IRGKsuucYfZerbWau3/ZeN9ZFbxKP4m7BHwDt5U1LLuhxuwnRJa
   o=;
X-IronPort-AV: E=Sophos;i="6.12,308,1728950400"; 
   d="scan'208";a="790432545"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2025 04:12:52 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:5111]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.22:2525] with esmtp (Farcaster)
 id 2f8adcb5-1c7a-4af9-ba08-c3b7603f0a48; Sun, 12 Jan 2025 04:12:51 +0000 (UTC)
X-Farcaster-Flow-ID: 2f8adcb5-1c7a-4af9-ba08-c3b7603f0a48
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 12 Jan 2025 04:12:51 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.156) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 12 Jan 2025 04:12:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 10/11] af_unix: Set drop reason in unix_dgram_disconnected().
Date: Sun, 12 Jan 2025 13:08:09 +0900
Message-ID: <20250112040810.14145-11-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250112040810.14145-1-kuniyu@amazon.com>
References: <20250112040810.14145-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

unix_dgram_disconnected() is called from two places:

  1. when a connect()ed socket dis-connect()s or re-connect()s to
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
index ed577276bd27..1c374bac7b48 100644
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


