Return-Path: <netdev+bounces-157023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF5FA08BFB
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36D3A164014
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2B9209F31;
	Fri, 10 Jan 2025 09:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hPvBP0U1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567872054E2
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736501276; cv=none; b=XOiR0vfpKDmTdREh5oG8aPAvsjJjqh5kgatSAPo42vRNX0N0dkBDJDhlhvU9rqgwo8T4l6Js51zy5WW+roB9wgEu1EP5mNKgEDwXmyaek/ja1AEHjbbAA7dx5/TW7jCPXFVBYLJf4W2g84q/ooeSuye83/jiPDXOoCfOXrWK34s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736501276; c=relaxed/simple;
	bh=5mUSIqvZKCzqOqlLhc4HTPnpUs3UM6+Ws+S5vzsOlCA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8t56LDY3ETX6ymUM0LKFDcRmYAEMhS7tBYtSOroMJRfjxY/Dh5Rux7olDYWMt2Ow482KKVHlfrsKSlmfoifgnyGGHSqPKRC4qkJshDW7Qji7r0XlrlYkj/n4c8rYHUZnFu1mWXYlB/m44xo/W+2Jakxr3BiblhvLIFb3hQzhmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=hPvBP0U1; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736501273; x=1768037273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KSH9q4QLzGrgvHxoytg+FRGRTm++eL6aTnjpqTyExSU=;
  b=hPvBP0U1Nwwnk2QJDcAcSi+e7dloHGfkSbrEPl3I6jHaod3F4sLhfLDx
   xvvxoK1UDuJV6EfSOgaNiKhUgEB+XtzmF7quNYwvyypgDrWVGnBkAsS5X
   FJV+WI/RuXudND/SF/6lPzuEHPz9fYUPFKiny30PI/hcHjckZ5tyqniUk
   8=;
X-IronPort-AV: E=Sophos;i="6.12,303,1728950400"; 
   d="scan'208";a="56711877"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 09:27:50 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:42191]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.9:2525] with esmtp (Farcaster)
 id 2c778f8a-83fc-4af5-a064-c9a5fb3bad03; Fri, 10 Jan 2025 09:27:50 +0000 (UTC)
X-Farcaster-Flow-ID: 2c778f8a-83fc-4af5-a064-c9a5fb3bad03
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 09:27:49 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.252.101) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 09:27:45 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 02/12] af_unix: Set drop reason in unix_release_sock().
Date: Fri, 10 Jan 2025 18:26:31 +0900
Message-ID: <20250110092641.85905-3-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
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


