Return-Path: <netdev+bounces-158767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E601A132AE
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 06:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD5E318831F1
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 05:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989CF156F41;
	Thu, 16 Jan 2025 05:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="eHrdU2wu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E9829A1
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 05:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737005926; cv=none; b=KpKoH84Zg6AHGQZI2KSrxdCDyhM1n0XaWQIQuEGl2Cd0dPbJkrDYYFgbRJSNlI2TV8vDy2gyx8YZZSJNJUr1AmVg6DyWDtrU45yyDuCghKU4b1l7tdVQmMtYmd92neY5J8S04u0ah2BSyio5QgGF2FN9XDPhnpjaZnbXW+j2608=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737005926; c=relaxed/simple;
	bh=ixLalfpXpIs3rsP+wBLi8puDHry4QeSa/RslrGfTQOQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C96U9hNgAEDYDKFSgSe6Q3vkf946/sXXPxbOrn+tlJbjH1ouUyMG76HS+fE+nC9i97MVEXl39BUCAdSJAShCcS4kXXFzBIDq3/bfP2AEjSy6BPwSauCChxH1LZELb+8kI9QgIuiSYKlPLfwPMtGKOUEyZjUJYHgooMh68JbpO1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=eHrdU2wu; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737005925; x=1768541925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RPsaapkXDL+bgCoY2e0fYyABxBnoL5f0jdivCVBQdHE=;
  b=eHrdU2wujS6O3nJqCI6NDjifRyUiToIYcO/QtQpDdKSmBloI7caOKvyW
   21NZQHlpWD8QJuaRHwd1btPNCby6tLS2F+y00sWdtOMVEl+9AWtQtJM7i
   O22thC8C9bCdOWVCRflqANRsj+oYrROWBOcXNympre0UdmUnWEW4BdQJ/
   E=;
X-IronPort-AV: E=Sophos;i="6.13,208,1732579200"; 
   d="scan'208";a="689608985"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 05:38:43 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:18920]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.33:2525] with esmtp (Farcaster)
 id 36c7afda-1c03-4591-be7a-46efaff903f4; Thu, 16 Jan 2025 05:38:42 +0000 (UTC)
X-Farcaster-Flow-ID: 36c7afda-1c03-4591-be7a-46efaff903f4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 16 Jan 2025 05:38:42 +0000
Received: from 6c7e67c6786f.amazon.com (10.143.84.222) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 16 Jan 2025 05:38:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 8/9] af_unix: Reuse out_pipe label in unix_stream_sendmsg().
Date: Thu, 16 Jan 2025 14:34:41 +0900
Message-ID: <20250116053441.5758-9-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This is a follow-up of commit d460b04bc452 ("af_unix: Clean up
error paths in unix_stream_sendmsg().").

If we initialise skb with NULL in unix_stream_sendmsg(), we can
reuse the existing out_pipe label for the SEND_SHUTDOWN check.

Let's rename it and adjust the existing label as out_pipe_lock.

While at it, size and data_len are moved to the while loop scope.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 5e1b408c19da..43a45cf06f2e 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2238,13 +2238,11 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 			       size_t len)
 {
 	struct sock *sk = sock->sk;
+	struct sk_buff *skb = NULL;
 	struct sock *other = NULL;
-	int err, size;
-	struct sk_buff *skb;
-	int sent = 0;
 	struct scm_cookie scm;
 	bool fds_sent = false;
-	int data_len;
+	int err, sent = 0;
 
 	err = scm_send(sock, msg, &scm, false);
 	if (err < 0)
@@ -2273,16 +2271,12 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 		}
 	}
 
-	if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN) {
-		if (!(msg->msg_flags & MSG_NOSIGNAL))
-			send_sig(SIGPIPE, current, 0);
-
-		err = -EPIPE;
-		goto out_err;
-	}
+	if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
+		goto out_pipe;
 
 	while (sent < len) {
-		size = len - sent;
+		int size = len - sent;
+		int data_len;
 
 		if (unlikely(msg->msg_flags & MSG_SPLICE_PAGES)) {
 			skb = sock_alloc_send_pskb(sk, 0, 0,
@@ -2335,7 +2329,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 
 		if (sock_flag(other, SOCK_DEAD) ||
 		    (other->sk_shutdown & RCV_SHUTDOWN))
-			goto out_pipe;
+			goto out_pipe_unlock;
 
 		maybe_add_creds(skb, sock, other);
 		scm_stat_add(other, skb);
@@ -2358,8 +2352,9 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	return sent;
 
-out_pipe:
+out_pipe_unlock:
 	unix_state_unlock(other);
+out_pipe:
 	if (!sent && !(msg->msg_flags & MSG_NOSIGNAL))
 		send_sig(SIGPIPE, current, 0);
 	err = -EPIPE;
-- 
2.39.5 (Apple Git-154)


