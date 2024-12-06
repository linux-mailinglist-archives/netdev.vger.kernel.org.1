Return-Path: <netdev+bounces-149602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452CF9E66E4
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 06:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C242169C99
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 05:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2D2193060;
	Fri,  6 Dec 2024 05:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KjvD5eXG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFD63EA9A
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 05:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733463032; cv=none; b=aJZ6p3p0+0ZlMWcZoNGz0oUk/Q7I5z3a75/KVlsWi3kc/ZNIu9uoxvSmvIP763mnJW99HG0sFzWajmAhFfYr4PDa+G937SK9aHeoiJPyBFMm/PUDDWgRvpohtRMHO4eXoT/W9XgoOLot5fNNpIQ7JHhwh5CAw5nXouv9tHj/a8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733463032; c=relaxed/simple;
	bh=KK5Beloqhm01CRxAeTY12JlGkXTzTF7ra/MjhqjTmPw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mti9knRy4VIbThn6zv1xlJCNcL+KiP5IzbreVptAIhQ6wX145maob3obo+gprL2OcXSO9yB9/b7Jh+Yu6MYMqC905WZz+ZamAvgsWFzy0Rpnn8IkslTYdUzwizCC7vV7L5Zyzn3iQp8icu7FAiuYB8/FYVDICc3CEyGttuoze38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KjvD5eXG; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733463031; x=1764999031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vHxpTybX3fhccPqaALX9gbUmv1/qxLcBRwnno4diEmc=;
  b=KjvD5eXGiw8dG6+c+XbjVh17kgjCD0hJfI6iYqh7nDFSgXa0ix6g0srh
   kRK9cDoLSQv9H6AdodqUjBbmpCTZcVRaQ4+RngxY7sLGZHf5NAsFonu+z
   ZZ1H/9TZJlK/mc9NM72LzC4qTaiBGPUvlBcaFSXfCsqn1tRCTknrX19NS
   Q=;
X-IronPort-AV: E=Sophos;i="6.12,212,1728950400"; 
   d="scan'208";a="252777538"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 05:30:27 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:50022]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.54:2525] with esmtp (Farcaster)
 id 1b1a44be-1b3c-4c53-88f7-8041ef07f3d6; Fri, 6 Dec 2024 05:30:27 +0000 (UTC)
X-Farcaster-Flow-ID: 1b1a44be-1b3c-4c53-88f7-8041ef07f3d6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 6 Dec 2024 05:30:26 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.244.93) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 6 Dec 2024 05:30:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 12/15] af_unix: Clean up SOCK_DEAD error paths in unix_dgram_sendmsg().
Date: Fri, 6 Dec 2024 14:26:04 +0900
Message-ID: <20241206052607.1197-13-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241206052607.1197-1-kuniyu@amazon.com>
References: <20241206052607.1197-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB004.ant.amazon.com (10.13.139.177) To
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
index 2ea5f8ec5ec4..9ae326eea57f 100644
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


