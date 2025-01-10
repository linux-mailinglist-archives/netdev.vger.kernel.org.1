Return-Path: <netdev+bounces-157034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF74A08C45
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591F73A9C15
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC73F20B7F1;
	Fri, 10 Jan 2025 09:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="enun1ml+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E40209F24
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736501465; cv=none; b=n+8EYaPP0F2DPxkAqr7Tz+94NJ++KmxnbydyFPttVsis9RgWj7rEN7LQIWxaSY8sSwfF5Gihi6bjJDnMPMcmlb+dsAg0f08n4pi4SbN54Ro5/rlrDXnsi2aAgEZJLmMTjJQAC5rx3Zdgl6sJPjlYZ0uV3jtNhS1ylY+mBjAXi4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736501465; c=relaxed/simple;
	bh=+IFfkmkD30I2ERIZGAPEBmULIGk1pZOwX6IZIzOe9J4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNekYlVCxf9TdlJ9vYiQOKD+BduUshthCyImr58Z7GFAkcXgjIQmrLCNOwoiRwxyvhSQ8WPwSIGCFi+R9k+vlu8L07JfXW0a9+oYu/7hjA5FMG++cVJTBiWOczp62LbJ2Y+DPjsbVqgcSplLB3Ho1gKuYFpj5gk/6X3ktii8hkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=enun1ml+; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736501464; x=1768037464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QmvH7MsnuBqbuAqJ9S+kZcIpMcXI/lqlIJpryvCN59o=;
  b=enun1ml+2Pw+nqgCyNnLET8bKcgz8LZc7qCYu/ULOy0gcoFuPnwL46tc
   mNk/6jlVvuDobBmAOCQHm/Tz9uSuqGn6Dxd33/MAH9fjR4ubMycSV3M0M
   TMlVqBc3ml1sZH8XeQ601mSOPAD2dWN7TKk/tMuiVJd4IBp8lqqCTUaJ/
   k=;
X-IronPort-AV: E=Sophos;i="6.12,303,1728950400"; 
   d="scan'208";a="262090098"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 09:31:02 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:37401]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.65:2525] with esmtp (Farcaster)
 id da46f367-30a7-48f1-b507-78b844182553; Fri, 10 Jan 2025 09:31:01 +0000 (UTC)
X-Farcaster-Flow-ID: da46f367-30a7-48f1-b507-78b844182553
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 09:30:58 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.252.101) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 09:30:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 09/12] af_unix: Set drop reason in manage_oob().
Date: Fri, 10 Jan 2025 18:26:38 +0900
Message-ID: <20250110092641.85905-10-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D041UWB003.ant.amazon.com (10.13.139.176) To
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
index 1dfe791e8991..06d90767040e 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2744,7 +2744,7 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 	spin_unlock(&sk->sk_receive_queue.lock);
 
 	consume_skb(read_skb);
-	kfree_skb(unread_skb);
+	kfree_skb_reason(unread_skb, SKB_DROP_REASON_UNIX_SKIP_OOB);
 
 	return skb;
 }
-- 
2.39.5 (Apple Git-154)


