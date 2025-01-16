Return-Path: <netdev+bounces-158764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FA2A132AB
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 06:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E37A3A8577
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 05:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FF0156C5E;
	Thu, 16 Jan 2025 05:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="O54yW4jA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4995078F2D
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 05:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737005850; cv=none; b=uJcPAio8pD7rOYhdlDzG9wg45ogH/a78yTCTuvUgTADrsSfpct6TjnFE/Mat/cBzypA9IULhJOh1NuiElLe1ltr7kD95clB3OLdNhlsYN5C/GHxcBrGBI6hIai/Kvgz+PgBk2uHy/NT/P/YoOxTC2fh8CKFk3jwWTiYDJYIjfWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737005850; c=relaxed/simple;
	bh=bcd1Zt1Z3ZYkQOZP4pEQ6HNyWbnVKWr3Pfd9i6wAJsE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jm8lWDMy5lBi0phEy/Z9y5qK7CR9WFy8u3j9UvdClFjb7PaJR6MDmslLvXUyMCstM3dZGpP0hMK8yAaY4ObS62TWXH1q8Q5feP2DTGZp8eC/qhYSvPlEVkxMJtJR8CgBqRHasivwSBm7qJTw1QnJOiZuqv4bUziXDeFe1gqxcWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=O54yW4jA; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737005849; x=1768541849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7qPWezrLBMqcl0z6tm2UJDO5OEJDYmMj4SfGZShJ9og=;
  b=O54yW4jAEMRoxZZI9ITBIP8aNBm1hOE21fjkiprGhsdX2KdsiAHj/ykR
   9zKU6Tl50bb7CGq8+wlN8eoID3k5e34MCFthwTPVqp1GPuH4HPJDLFpOF
   SEKqF7BIuXw545UZwRshago0u4DfQ9P/RhlG9fHrjyupAUj6BFwQc4Yps
   4=;
X-IronPort-AV: E=Sophos;i="6.13,208,1732579200"; 
   d="scan'208";a="401216685"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 05:37:22 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:8275]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.12:2525] with esmtp (Farcaster)
 id 20963673-b8d6-49f3-8626-20912d9c1e00; Thu, 16 Jan 2025 05:37:22 +0000 (UTC)
X-Farcaster-Flow-ID: 20963673-b8d6-49f3-8626-20912d9c1e00
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 16 Jan 2025 05:37:21 +0000
Received: from 6c7e67c6786f.amazon.com (10.143.84.222) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 16 Jan 2025 05:37:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 5/9] af_unix: Set drop reason in manage_oob().
Date: Thu, 16 Jan 2025 14:34:38 +0900
Message-ID: <20250116053441.5758-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

AF_UNIX SOCK_STREAM socket supports MSG_OOB.

When OOB data is sent to a socket, recv() will break at that point.

If the next recv() does not have MSG_OOB, the normal data following
the OOB data is returned.

Then, the OOB skb is dropped.

Let's define a new drop reason for that case in manage_oob().

  # echo 1 > /sys/kernel/tracing/events/skb/kfree_skb/enable

  # python3
  >>> from socket import *
  >>> s1, s2 = socketpair(AF_UNIX)
  >>> s1.send(b'a', MSG_OOB)
  >>> s1.send(b'b')
  >>> s2.recv(2)
  b'b'

  # cat /sys/kernel/tracing/trace_pipe
  ...
     python3-223 ... kfree_skb: ... location=unix_stream_read_generic+0x59e/0xc20 reason: UNIX_SKIP_OOB

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/dropreason-core.h | 6 ++++++
 net/unix/af_unix.c            | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index b9e7ff853ce3..d6c9d841eb11 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -9,6 +9,7 @@
 	FN(SOCKET_CLOSE)		\
 	FN(SOCKET_FILTER)		\
 	FN(SOCKET_RCVBUFF)		\
+	FN(UNIX_SKIP_OOB)		\
 	FN(PKT_TOO_SMALL)		\
 	FN(TCP_CSUM)			\
 	FN(UDP_CSUM)			\
@@ -145,6 +146,11 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_SOCKET_FILTER,
 	/** @SKB_DROP_REASON_SOCKET_RCVBUFF: socket receive buff is full */
 	SKB_DROP_REASON_SOCKET_RCVBUFF,
+	/**
+	 * @SKB_DROP_REASON_UNIX_SKIP_OOB: Out-Of-Band data is skipped by
+	 * recv() without MSG_OOB so dropped.
+	 */
+	SKB_DROP_REASON_UNIX_SKIP_OOB,
 	/** @SKB_DROP_REASON_PKT_TOO_SMALL: packet size is too small */
 	SKB_DROP_REASON_PKT_TOO_SMALL,
 	/** @SKB_DROP_REASON_TCP_CSUM: TCP checksum error */
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 41b99984008a..e31fda1d319f 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2695,7 +2695,7 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 	spin_unlock(&sk->sk_receive_queue.lock);
 
 	consume_skb(read_skb);
-	kfree_skb(unread_skb);
+	kfree_skb_reason(unread_skb, SKB_DROP_REASON_UNIX_SKIP_OOB);
 
 	return skb;
 }
-- 
2.39.5 (Apple Git-154)


