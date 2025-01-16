Return-Path: <netdev+bounces-158766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FBBA132AD
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 06:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4816A3A1311
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 05:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ECB157A72;
	Thu, 16 Jan 2025 05:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lZuQIqIT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307A815820C
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 05:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737005899; cv=none; b=dj/j71NDO9q+o7gl9L6z40vaPp7V6oYEu5rOuBGAwiqM/lWmA64d8aN+oyALWtkhrp4dIMyck7qzej8qBctXVGhatam1xvCyvS6IoLHDo84QmHGsK7lWZJWUDZhTXR9qQWN/PyKr6uaEQ8XQ3w13AVzsaIstoZ7lMlwf5YJOtZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737005899; c=relaxed/simple;
	bh=OCOiJ1xGYlG7aBIGYhBjEJf8uor6sSUI20s2rVgyrHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c7MR+I1E/TPrMxGeBs6s5DwWy1PSHEPE/tb6Wqrvdv8dmHPUehx0scFho7sQ5ZjOVRaO9oR+sWMTAVAZ1/mioRmPXR+Cw3Nhp4DLEn2qgVuvLiFeLOkHsyRcTLAwGYjAFxQS5N5UVHXf+e9lPxdv5e9eRCPJBsW9kxRwCph4jS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lZuQIqIT; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737005898; x=1768541898;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G2N+ESqLCThoICczy6rEH3giIMA08YsknZE0mrlMPbI=;
  b=lZuQIqIT9Dgo7xmjZcPFaCE+ZWxAenwnHnbwt5j+R5olgrvrgh4fUkco
   C9NINjdzPCDhakmOmL/4hgslGEdzpDaL+PoXeswI/2ywaz/dgX0PbO3Y+
   TTnKK1OowJa82fyYWu858v5ur2wCKAvpgFr8rm1A0AIu5+vqr3bpxZD99
   M=;
X-IronPort-AV: E=Sophos;i="6.13,208,1732579200"; 
   d="scan'208";a="464483843"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 05:38:17 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:55185]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.33:2525] with esmtp (Farcaster)
 id 0bbe0dfa-6460-4d60-ac65-452560df6c2a; Thu, 16 Jan 2025 05:38:15 +0000 (UTC)
X-Farcaster-Flow-ID: 0bbe0dfa-6460-4d60-ac65-452560df6c2a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 16 Jan 2025 05:38:15 +0000
Received: from 6c7e67c6786f.amazon.com (10.143.84.222) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 16 Jan 2025 05:38:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 7/9] af_unix: Set drop reason in unix_dgram_disconnected().
Date: Thu, 16 Jan 2025 14:34:40 +0900
Message-ID: <20250116053441.5758-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250116053441.5758-1-kuniyu@amazon.com>
References: <20250116053441.5758-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA003.ant.amazon.com (10.13.139.6) To
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
index d6c9d841eb11..32a34dfe8cc5 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -9,6 +9,7 @@
 	FN(SOCKET_CLOSE)		\
 	FN(SOCKET_FILTER)		\
 	FN(SOCKET_RCVBUFF)		\
+	FN(UNIX_DISCONNECT)		\
 	FN(UNIX_SKIP_OOB)		\
 	FN(PKT_TOO_SMALL)		\
 	FN(TCP_CSUM)			\
@@ -146,6 +147,12 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_SOCKET_FILTER,
 	/** @SKB_DROP_REASON_SOCKET_RCVBUFF: socket receive buff is full */
 	SKB_DROP_REASON_SOCKET_RCVBUFF,
+	/**
+	 * @SKB_DROP_REASON_UNIX_DISCONNECT: recv queue is purged when SOCK_DGRAM
+	 * or SOCK_SEQPACKET socket re-connect()s to another socket or notices
+	 * during send() that the peer has been close()d.
+	 */
+	SKB_DROP_REASON_UNIX_DISCONNECT,
 	/**
 	 * @SKB_DROP_REASON_UNIX_SKIP_OOB: Out-Of-Band data is skipped by
 	 * recv() without MSG_OOB so dropped.
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index de4966e1b7ff..5e1b408c19da 100644
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


