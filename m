Return-Path: <netdev+bounces-157496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D96A0A726
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 05:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5367165383
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 04:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EC325634;
	Sun, 12 Jan 2025 04:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vZR9Ft/6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDF86FB0
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 04:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736655124; cv=none; b=fd/kdAHlzi43VT3sQyA5zsg7P1ydqX3MBfULqUECrEf4GA72ZHZZZk0GNUTamoKxKFywXMwI0oXsyjQyYhVJjFGP+zLqx6VLsjVqYj6haqk1+RFL1gqnVaHC7vUJ6UbTubSb4Blvpi1/Fdh7e7ZzDDedDU7uwyInXG9CnZqUv/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736655124; c=relaxed/simple;
	bh=EW5qHUoHq4YzzUlr9G2dw/sl88BXkj3oSanRFIQpbK0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o/AeFjYJu83o7SIBqDI5PkvKcW57qQNLy+9m6ZZj9XbvPJX14wQDfCAb1wR1H5HklcncqcbCi8XM4gV53xMS28SqAyrcj24xdsLg8psDjLPt9hIcAshF19CmcDutekZKacC4/g52DIHboYHbKcSEPNJFw5WiVupQo0Wa2NFuST8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vZR9Ft/6; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736655122; x=1768191122;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qoHqRzyOsC6QtQIsgxhMnQ4/pXmzLS85a9CGq3xUQ14=;
  b=vZR9Ft/6MN+7Eb63HyC0eBLYMDvqHjY5EbSpsLg3QC1KZlCkB63cGy1V
   c5oMn9FlYK6sJEKSLzLLu5e9Tx5X2mo5Z+PwsuLXiYvGdaMG5KMRIYMNU
   c/tab9DkRhL9wUEVo70+68L4REbK43zR5G/x3WOTpDSIETgSnpslxfEae
   U=;
X-IronPort-AV: E=Sophos;i="6.12,308,1728950400"; 
   d="scan'208";a="163513194"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2025 04:12:01 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:60733]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.12:2525] with esmtp (Farcaster)
 id 9026c126-bf3d-4305-9b82-86d83633b86e; Sun, 12 Jan 2025 04:12:00 +0000 (UTC)
X-Farcaster-Flow-ID: 9026c126-bf3d-4305-9b82-86d83633b86e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 12 Jan 2025 04:11:57 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.156) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 12 Jan 2025 04:11:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 08/11] af_unix: Set drop reason in manage_oob().
Date: Sun, 12 Jan 2025 13:08:07 +0900
Message-ID: <20250112040810.14145-9-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
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
index dea6bbe3ceaa..43e20acaa98a 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -12,6 +12,7 @@
 	FN(SOCKET_RCVBUFF)		\
 	FN(SOCKET_RCV_SHUTDOWN)		\
 	FN(UNIX_INFLIGHT_FD_LIMIT)	\
+	FN(UNIX_SKIP_OOB)		\
 	FN(PKT_TOO_SMALL)		\
 	FN(TCP_CSUM)			\
 	FN(UDP_CSUM)			\
@@ -156,6 +157,11 @@ enum skb_drop_reason {
 	 * are passed via SCM_RIGHTS but not yet received, reaching RLIMIT_NOFILE.
 	 */
 	SKB_DROP_REASON_UNIX_INFLIGHT_FD_LIMIT,
+	/**
+	 * @SKB_DROP_REASON_UNIX_SKIP_OOB: Out-Of-Band data is skipped by
+	 * recv() without MSG_OOB so dropped.
+	 */
+	SKB_DROP_REASON_UNIX_SKIP_OOB,
 	/** @SKB_DROP_REASON_PKT_TOO_SMALL: packet size is too small */
 	SKB_DROP_REASON_PKT_TOO_SMALL,
 	/** @SKB_DROP_REASON_TCP_CSUM: TCP checksum error */
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 8623e3368c45..efd1b83b152a 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2748,7 +2748,7 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 	spin_unlock(&sk->sk_receive_queue.lock);
 
 	consume_skb(read_skb);
-	kfree_skb(unread_skb);
+	kfree_skb_reason(unread_skb, SKB_DROP_REASON_UNIX_SKIP_OOB);
 
 	return skb;
 }
-- 
2.39.5 (Apple Git-154)


