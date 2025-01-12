Return-Path: <netdev+bounces-157489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91220A0A71D
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 05:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C2307A3AD1
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 04:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FA31D52B;
	Sun, 12 Jan 2025 04:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gynJVUcg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8F818E3F
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 04:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736654961; cv=none; b=SMdtwcr7CA92xcPcE04z/DA4FN8dX9UHvax5+UtD3Bjmo9OTIbTOX7zkBkyk8F0SzvK8K7QMbUWLfCUjzw5bkNX1XkzCtGmA0Kn0dX7+b6TWhZaDB5rko3SHm8nsWLubwRWm2Wzbewsw28fTNUxN8DH+ujfYSpAQiijQdzu3CEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736654961; c=relaxed/simple;
	bh=5mUSIqvZKCzqOqlLhc4HTPnpUs3UM6+Ws+S5vzsOlCA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=etePWP/a8BwqQhadlI1GwrCMP8yxko/CHyfq8i6fCX/bCoih1P9QqlcSNv+Sq/41/qvLRO451E0kjuxr/by0fOI7qnc6ul99Eyr4GWXOieqtoT6N4iv+RDZ2lAsEqOaDvHfI7e3USEeQtsiikwxXo0LHGmCfK5k1etI/3Tqgv1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gynJVUcg; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736654960; x=1768190960;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KSH9q4QLzGrgvHxoytg+FRGRTm++eL6aTnjpqTyExSU=;
  b=gynJVUcgJGoHuvczdcOguD0vsya6jnI4pY2lZCHSSdG0JBIOz6pDQI/g
   xminbPG2bA1eJANejm3obkYnqL7m6ZV1xdTN1TGqd/Tji5AFYOlYJNptW
   J8624pTZR0L6aINXdR+/cc+5f2unQJwc5P+scocQKpncSIh/WGn5sQDKB
   M=;
X-IronPort-AV: E=Sophos;i="6.12,308,1728950400"; 
   d="scan'208";a="458171992"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2025 04:09:19 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:20296]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.22:2525] with esmtp (Farcaster)
 id e3dd2e9a-140d-46f2-9f8e-5bc55dd02042; Sun, 12 Jan 2025 04:09:18 +0000 (UTC)
X-Farcaster-Flow-ID: e3dd2e9a-140d-46f2-9f8e-5bc55dd02042
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 12 Jan 2025 04:09:17 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.156) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 12 Jan 2025 04:09:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 02/11] af_unix: Set drop reason in unix_release_sock().
Date: Sun, 12 Jan 2025 13:08:01 +0900
Message-ID: <20250112040810.14145-3-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D038UWB001.ant.amazon.com (10.13.139.148) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

unix_release_sock() is called when the last refcnt of struct file
is released.

Let's define a new drop reason SKB_DROP_REASON_SOCKET_CLOSE and
set it for kfree_skb() in unix_release_sock().

  # echo 1 > /sys/kernel/tracing/events/skb/kfree_skb/enable

  # python3
  >>> from socket import *
  >>> s1, s2 = socketpair(AF_UNIX)
  >>> s1.send(b'hello world')
  >>> s2.close()

  # cat /sys/kernel/tracing/trace_pipe
  ...
     python3-280 ... kfree_skb: ... protocol=0 location=unix_release_sock+0x260/0x420 reason: SOCKET_CLOSE

To be precise, unix_release_sock() is also called for a new child
socket in unix_stream_connect() when something fails, but the new
sk does not have skb in the recv queue then and no event is logged.

Note that only tcp_inbound_ao_hash() uses a similar drop reason,
SKB_DROP_REASON_TCP_CLOSE, and this can be generalised later.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/dropreason-core.h | 3 +++
 net/unix/af_unix.c            | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index efeae9f0f956..8823de6539d1 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -6,6 +6,7 @@
 #define DEFINE_DROP_REASON(FN, FNe)	\
 	FN(NOT_SPECIFIED)		\
 	FN(NO_SOCKET)			\
+	FN(SOCKET_CLOSE)		\
 	FN(SOCKET_FILTER)		\
 	FN(SOCKET_RCVBUFF)		\
 	FN(PKT_TOO_SMALL)		\
@@ -137,6 +138,8 @@ enum skb_drop_reason {
 	 * 3) no valid child socket during 3WHS process
 	 */
 	SKB_DROP_REASON_NO_SOCKET,
+	/** @SKB_DROP_REASON_SOCKET_CLOSE: socket is close()d */
+	SKB_DROP_REASON_SOCKET_CLOSE,
 	/** @SKB_DROP_REASON_SOCKET_FILTER: dropped by socket filter */
 	SKB_DROP_REASON_SOCKET_FILTER,
 	/** @SKB_DROP_REASON_SOCKET_RCVBUFF: socket receive buff is full */
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 8f2b605ce5b3..a05d25cc5545 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -715,8 +715,8 @@ static void unix_release_sock(struct sock *sk, int embrion)
 		if (state == TCP_LISTEN)
 			unix_release_sock(skb->sk, 1);
 
-		/* passed fds are erased in the kfree_skb hook	      */
-		kfree_skb(skb);
+		/* passed fds are erased in the kfree_skb hook */
+		kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_CLOSE);
 	}
 
 	if (path.dentry)
-- 
2.39.5 (Apple Git-154)


