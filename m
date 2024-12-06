Return-Path: <netdev+bounces-149593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC679E66D0
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 06:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5FA169B25
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 05:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F1B195F22;
	Fri,  6 Dec 2024 05:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FX2Q3sTm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B50A1953BA
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 05:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733462846; cv=none; b=pWQa2K11iCdITeS6kZJl69E2zQYDU/kPJJSKqpr1c4tmaldo8e84q1y1D/7djOU9HdWVx6w0OWG5AcI3JQwewpi/m4c8e7wSrUyKHGR/s7T39ef3OKzJteG6mWtCuJnvAoyNSlLjwG+Y3jMphd48hRy9gMSxihTjXHjjh4YMH48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733462846; c=relaxed/simple;
	bh=aEcT6rjkacku4AIqOqS2Y7R/e536el5cHek3vjhhfHQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mkzpC0eHsqARxA1tF9IcqPRB0C1W58zbBSpatPWV0TyUK1SzOkCweh2NqUhD0z2993Rt9yDKf4xLXzqRf2tDM2kvDK4NFAo9VVzw2ZlFVMXpiCg17NRLOx6WLPbmc9a5KzsfCnoQbKDvKPgBi/Sd49BwzY7I3TVsWFdc9WEBsGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FX2Q3sTm; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733462846; x=1764998846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yps1g+CUjI/8uJVmuYheS0j5mHM8+GS8mhWMntR2zIw=;
  b=FX2Q3sTm0JT7tdiQVTC33EvoyxWmc6rhnjxJV9VT9Qv3EoTNoeXvQAxS
   XxbqCOPQXicTHq6mTR+UPeHjKCXJnzJCj6LgJyQYmZ2ZpRMqRxbaV26fE
   es9bZnYwxP19dwT8zkfD5CNh0ZE35If4Axl+CGE5QceZTvGlLFLL0TIEF
   k=;
X-IronPort-AV: E=Sophos;i="6.12,212,1728950400"; 
   d="scan'208";a="448638453"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 05:27:23 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:15062]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.94:2525] with esmtp (Farcaster)
 id 2502aa25-9f2a-4833-8ec2-ee8126727bd7; Fri, 6 Dec 2024 05:27:20 +0000 (UTC)
X-Farcaster-Flow-ID: 2502aa25-9f2a-4833-8ec2-ee8126727bd7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 6 Dec 2024 05:27:20 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.244.93) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 6 Dec 2024 05:27:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 03/15] af_unix: Set error only when needed in unix_stream_sendmsg().
Date: Fri, 6 Dec 2024 14:25:55 +0900
Message-ID: <20241206052607.1197-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will introduce skb drop reason for AF_UNIX, then we need to
set an errno and a drop reason for each path.

Let's set an error only when it's needed in unix_stream_sendmsg().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index bdf88ddfb3e4..8d13b580731c 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2254,8 +2254,8 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	wait_for_unix_gc(scm.fp);
 
-	err = -EOPNOTSUPP;
 	if (msg->msg_flags & MSG_OOB) {
+		err = -EOPNOTSUPP;
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
 		if (len)
 			len--;
@@ -2268,10 +2268,11 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 		err = READ_ONCE(sk->sk_state) == TCP_ESTABLISHED ? -EISCONN : -EOPNOTSUPP;
 		goto out_err;
 	} else {
-		err = -ENOTCONN;
 		other = unix_peer(sk);
-		if (!other)
+		if (!other) {
+			err = -ENOTCONN;
 			goto out_err;
+		}
 	}
 
 	if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
-- 
2.39.5 (Apple Git-154)


