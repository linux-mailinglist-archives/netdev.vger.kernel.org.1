Return-Path: <netdev+bounces-151709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C34139F0A87
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841B82813DF
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC0F1CEAD6;
	Fri, 13 Dec 2024 11:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UMSrNph5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5407B1C3C0D
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 11:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088355; cv=none; b=ANPL6zPj2erRaIjKt2LpX+gWtwxiCwjBGeOOuotWxaBfU4IeiJWTYKB74tiTKVOjqQPLEvIjXn8NE0aZTrNXh5iAShd0PVN3SPEhGm4xZBAlF6h/VCzpCSZx9O3JFzwmrJlprd383L0qGsHdMU6JN6vm/LIyqzSl2X2ITBQgaOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088355; c=relaxed/simple;
	bh=TM0u/8mFLm/7qIkMVPsUPf3j1Dxrb2Y/Ms6bixcdP3U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLxO/lAgvK5Aq/4C+0dvmcsOyMq24ivnaPl1xMxGhR3Bqyrv3Dm7BopgNKcLMvepK/nHtVmaTGuymrRxFrOFzeNBvXKxdfYm/Kj0OgCDX+gDQhE/nYqXliTAI1TtA+pQMeY0zD7DR7hJSdltrsb5+0SVC9vWhNDf+/6PYeaidsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UMSrNph5; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734088355; x=1765624355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=olq8vX6FoC3FvG+Gy8jio4+l0B1gY6gF8+X04oMpuEc=;
  b=UMSrNph57sj8fDiFDsd7vHBQ8EI9D1r44jwgUUOMkfWVbIkEduhuDRYa
   aIafjd5UylH5vsqSKvMyA1z/9Kuqor8uWBuLUYs5yjR87HRQFGrer/6G+
   mj4F5tQtcve4EGdwOAxmK4D66XqRcoTUj/ZeUp7OYyWs2y6VUuidhE+ua
   U=;
X-IronPort-AV: E=Sophos;i="6.12,231,1728950400"; 
   d="scan'208";a="450548061"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 11:12:32 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:36356]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.194:2525] with esmtp (Farcaster)
 id f78084f2-741d-487f-b69a-507c25bfeb29; Fri, 13 Dec 2024 11:12:30 +0000 (UTC)
X-Farcaster-Flow-ID: f78084f2-741d-487f-b69a-507c25bfeb29
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 11:12:30 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.208) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 11:12:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 10/12] af_unix: Clean up SOCK_DEAD error paths in unix_dgram_sendmsg().
Date: Fri, 13 Dec 2024 20:08:48 +0900
Message-ID: <20241213110850.25453-11-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241213110850.25453-1-kuniyu@amazon.com>
References: <20241213110850.25453-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC002.ant.amazon.com (10.13.139.230) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When other has SOCK_DEAD in unix_dgram_sendmsg(), we hold
unix_state_lock() for the sender socket first.

However, we do not need it for sk->sk_type.

Let's move the lock down a bit.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index b8adfb41d11b..22c689b0044f 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2070,23 +2070,23 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	}
 
 	if (unlikely(sock_flag(other, SOCK_DEAD))) {
-		/*
-		 *	Check with 1003.1g - what should
-		 *	datagram error
-		 */
-		unix_state_unlock(other);
+		/* Check with 1003.1g - what should datagram error */
 
-		if (!sk_locked)
-			unix_state_lock(sk);
+		unix_state_unlock(other);
 
 		if (sk->sk_type == SOCK_SEQPACKET) {
 			/* We are here only when racing with unix_release_sock()
 			 * is clearing @other. Never change state to TCP_CLOSE
 			 * unlike SOCK_DGRAM wants.
 			 */
-			unix_state_unlock(sk);
 			err = -EPIPE;
-		} else if (unix_peer(sk) == other) {
+			goto out_free;
+		}
+
+		if (!sk_locked)
+			unix_state_lock(sk);
+
+		if (unix_peer(sk) == other) {
 			unix_peer(sk) = NULL;
 			unix_dgram_peer_wake_disconnect_wakeup(sk, other);
 
@@ -2096,15 +2096,15 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 			unix_dgram_disconnected(sk, other);
 			sock_put(other);
 			err = -ECONNREFUSED;
-		} else {
-			unix_state_unlock(sk);
-
-			if (!msg->msg_namelen)
-				err = -ECONNRESET;
+			goto out_free;
 		}
 
-		if (err)
+		unix_state_unlock(sk);
+
+		if (!msg->msg_namelen) {
+			err = -ECONNRESET;
 			goto out_free;
+		}
 
 		goto lookup;
 	}
-- 
2.39.5 (Apple Git-154)


