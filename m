Return-Path: <netdev+bounces-158761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F364A132A7
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 06:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6767188552B
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 05:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360C51487C8;
	Thu, 16 Jan 2025 05:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hGXDbNfm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913B335944
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 05:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737005769; cv=none; b=kDbC+uBDg5MMydW3Zxa9FB9o6djNAdSc0jj7HDwAzSlRiXgZN4GHO7iFIOiD8EvVrevWcUZde2pzWG+olTW5LPrUmQd8NXiR3fxoKlYhh8FOed9vT6KH94078JZdkwWXkTpsk2yuGoPlsRKqLUQHunbLmX6jIeKt4xLa6iX4qyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737005769; c=relaxed/simple;
	bh=8EyPudE5v8kpx+/C6RI9helpl4ZCeNXzhuhc5sXpKfU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tDIRuEs/j8ooY3cGB4fNkEo10d2eQszup7f/fihKkVLbK2mpj2zgpnvd4FryZWq2oal56aKUvl0Ce+8jaDou8zT6Wkxb5k9FbAnVhovuA8ET8SPJhBlF+dN/Q+ccI5z3VBb+1NlcnxfQzk+TYivdO+mj6WItTJcDLnFZtoWsfT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=hGXDbNfm; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737005767; x=1768541767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+MXnZp0s0/xVp3eAQXoAcvgBhoi0r0yM56yc//vSpfo=;
  b=hGXDbNfmDRiGCS3RoDKZsyoy2z0HSLJ3lL70PJsy4GHACMA/+35m7kqM
   ZE7IjlMBernem97U8rhqLEyxCOVCj+8Wv13InfqRWRA0dTIF7wZyVHSPU
   OXacwh1TwKGvKvSdUKEC5xS1r2Af1Gs+qvvexu1N/+7V8YC6pXFM3j1GA
   4=;
X-IronPort-AV: E=Sophos;i="6.13,208,1732579200"; 
   d="scan'208";a="369483297"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 05:36:07 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:10919]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.205:2525] with esmtp (Farcaster)
 id 368d3824-e4a4-485a-9783-ef4d161b2b77; Thu, 16 Jan 2025 05:36:06 +0000 (UTC)
X-Farcaster-Flow-ID: 368d3824-e4a4-485a-9783-ef4d161b2b77
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 16 Jan 2025 05:36:00 +0000
Received: from 6c7e67c6786f.amazon.com (10.143.84.222) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 16 Jan 2025 05:35:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 2/9] af_unix: Set drop reason in unix_release_sock().
Date: Thu, 16 Jan 2025 14:34:35 +0900
Message-ID: <20250116053441.5758-3-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
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
index f3714cbea50d..b9e7ff853ce3 100644
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
@@ -138,6 +139,8 @@ enum skb_drop_reason {
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


