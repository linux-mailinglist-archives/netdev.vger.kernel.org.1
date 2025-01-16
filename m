Return-Path: <netdev+bounces-158768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F609A132B0
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 06:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE811885BE7
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 05:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F325E156C5E;
	Thu, 16 Jan 2025 05:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kTcf5V/v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332471487C8
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 05:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737005954; cv=none; b=o2bUMldPaP7Oafn43xl8gpcLR5QcjWR/BPWTduTW7XMSRfIlJQDUMXWByr5Fwc+K0FQNl2DGnmdetIZxa27ftkWa1mKjtq8e0TYohYVnyFh1YNhN58yIQ01+ODHp5TP3aUcVtAcqv7HFna7ZNcCFYQxi5rALySD1qUEgo0V1Tc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737005954; c=relaxed/simple;
	bh=KLfLI+aYKMjL5JfLP0W3C4vb7852xuSVi5jBRcHnLMA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVNFcAA3fkvD50QPlafYCD6gYz0fwzvfZ4U5UkUByMVE7B6MyUzRykzfOkdjuX750FSBv383Up5+LDLVNH+vTU6llU8ODbyD+utyKCCHhFa2CavgU93UPJoZg9PDBUi4XfZnjxk9UEc9yOI9VAkidlhg3X0AL0CcKFAtR8ITiwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kTcf5V/v; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737005953; x=1768541953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=evECSRx8evAKxQOLF9PMpYLC8KaSO3EaiTzTqOd49WM=;
  b=kTcf5V/vjAK4fv+7Gj4Jwd60ecjsuNUxH1wyrtjva+N/SfnZ9dMrdpGf
   SQDork/p95ZRp6simr4CtMlyvCJTnNV6HryPz9NHXOwNS6Jd/6WxcAsQ3
   0fk5U4wMYTfobr6T2QdCFU3EApzcQoW/ul4S4TpH5YnBhsw0ZxI95kVTu
   I=;
X-IronPort-AV: E=Sophos;i="6.13,208,1732579200"; 
   d="scan'208";a="464483949"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 05:39:12 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:64525]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.127:2525] with esmtp (Farcaster)
 id 7e8ef50f-e9d0-4821-876a-0dc8c15834dd; Thu, 16 Jan 2025 05:39:11 +0000 (UTC)
X-Farcaster-Flow-ID: 7e8ef50f-e9d0-4821-876a-0dc8c15834dd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 16 Jan 2025 05:39:09 +0000
Received: from 6c7e67c6786f.amazon.com (10.143.84.222) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 16 Jan 2025 05:39:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 9/9] af_unix: Use consume_skb() in connect() and sendmsg().
Date: Thu, 16 Jan 2025 14:34:42 +0900
Message-ID: <20250116053441.5758-10-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This is based on Donald Hunter's patch.

These functions could fail for various reasons, sometimes
triggering kfree_skb().

  * unix_stream_connect() : connect()
  * unix_stream_sendmsg() : sendmsg()
  * queue_oob()           : sendmsg(MSG_OOB)
  * unix_dgram_sendmsg()  : sendmsg()

Such kfree_skb() is tied to the errno of connect() and
sendmsg(), and we need not define skb drop reasons.

Let's use consume_skb() not to churn kfree_skb() events.

Link: https://lore.kernel.org/netdev/eb30b164-7f86-46bf-a5d3-0f8bda5e9398@redhat.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 43a45cf06f2e..34945de1fb1f 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1701,7 +1701,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	unix_state_unlock(other);
 	sock_put(other);
 out_free_skb:
-	kfree_skb(skb);
+	consume_skb(skb);
 out_free_sk:
 	unix_release_sock(newsk, 0);
 out:
@@ -2172,7 +2172,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 out_sock_put:
 	sock_put(other);
 out_free:
-	kfree_skb(skb);
+	consume_skb(skb);
 out:
 	scm_destroy(&scm);
 	return err;
@@ -2189,7 +2189,7 @@ static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other
 {
 	struct unix_sock *ousk = unix_sk(other);
 	struct sk_buff *skb;
-	int err = 0;
+	int err;
 
 	skb = sock_alloc_send_skb(sock->sk, 1, msg->msg_flags & MSG_DONTWAIT, &err);
 
@@ -2197,25 +2197,22 @@ static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other
 		return err;
 
 	err = unix_scm_to_skb(scm, skb, !fds_sent);
-	if (err < 0) {
-		kfree_skb(skb);
-		return err;
-	}
+	if (err < 0)
+		goto out;
+
 	skb_put(skb, 1);
 	err = skb_copy_datagram_from_iter(skb, 0, &msg->msg_iter, 1);
 
-	if (err) {
-		kfree_skb(skb);
-		return err;
-	}
+	if (err)
+		goto out;
 
 	unix_state_lock(other);
 
 	if (sock_flag(other, SOCK_DEAD) ||
 	    (other->sk_shutdown & RCV_SHUTDOWN)) {
 		unix_state_unlock(other);
-		kfree_skb(skb);
-		return -EPIPE;
+		err = -EPIPE;
+		goto out;
 	}
 
 	maybe_add_creds(skb, sock, other);
@@ -2230,6 +2227,9 @@ static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other
 	unix_state_unlock(other);
 	other->sk_data_ready(other);
 
+	return 0;
+out:
+	consume_skb(skb);
 	return err;
 }
 #endif
@@ -2359,7 +2359,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 		send_sig(SIGPIPE, current, 0);
 	err = -EPIPE;
 out_free:
-	kfree_skb(skb);
+	consume_skb(skb);
 out_err:
 	scm_destroy(&scm);
 	return sent ? : err;
-- 
2.39.5 (Apple Git-154)


