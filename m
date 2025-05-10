Return-Path: <netdev+bounces-189430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FB5AB20E6
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 03:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4739E4506
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 01:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E412673BA;
	Sat, 10 May 2025 01:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="c3n8wQa0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4021DEFE0
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 01:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746842279; cv=none; b=k4QwDGUCGz4bugRpttRGuz/0uocDfiFqzVV7oeYmQYQ3DyCsJS/LERKa9sZ9xnRfBs2KVwhH4oLMSRMMrSIBXZoS+juPYuG9rJZ2MP8zuq2CSck8cH+yj54G0pXRRg+WBUM9vWibp4SKulPYop/hq8QTafmnBVDRLZZGz1xTuko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746842279; c=relaxed/simple;
	bh=K99J37eW4YetMTBywNuy2krslJsi7+VADpoYhOwNJTs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uhwo39dKRGQ8UZ/+sd+h2xLiIwH7ZS1zFpkKE8mKXdb3ZP2gVe/RBvGUYO/mDSvCM/GZMRhtc72X9+aaooigs/XPUJnCK0ql7eC3tLGF3gyDyfnCMLILZESidjVbYJPbeDaUBIjzkE2qEEBNvNBfFWgH+Jonqv6vamt8oaBxuMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=c3n8wQa0; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1746842277; x=1778378277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uSGIaqLEaroildq83RekUXJ0eeSt8PNFSPl17SmUYxQ=;
  b=c3n8wQa04ndvGBPGUvEAuQMHq9C97lsfzHMAUnAoMe8MMkWfJCpdHC1J
   N6Zs3hDio7Ea5joxHU9hmaPsxTMi39hf0cO9Y0D7H4icjEzdjTDfh5hUP
   bC9WBcjWTUGlkSBXv8dnF19kO1TDcjdihCkaoR5B7FNUAzq+VF1wpXiHQ
   P/gPsoO/14gdVSS+D4FnsgnBW//RO8czdMSx8PXqOcmIQj1GbLfAQgwRc
   n0GOpMnP9siF/sel6DxSAuTismdXgfXF40BezBbZDySUpJZp7rlERggYK
   cJ9q2VLcKUkFIFYJ7bB2q3gvc57GwCYaLhGsbJOp8PFAdEOdXdmqknVaG
   g==;
X-IronPort-AV: E=Sophos;i="6.15,276,1739836800"; 
   d="scan'208";a="199058968"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 01:57:55 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:13896]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.92:2525] with esmtp (Farcaster)
 id e05545c9-90ed-40de-8371-ba3815669cc7; Sat, 10 May 2025 01:57:55 +0000 (UTC)
X-Farcaster-Flow-ID: e05545c9-90ed-40de-8371-ba3815669cc7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 10 May 2025 01:57:55 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 10 May 2025 01:57:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 2/9] af_unix: Don't pass struct socket to maybe_add_creds().
Date: Fri, 9 May 2025 18:56:25 -0700
Message-ID: <20250510015652.9931-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250510015652.9931-1-kuniyu@amazon.com>
References: <20250510015652.9931-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA002.ant.amazon.com (10.13.139.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will move SOCK_PASS{CRED,PIDFD,SEC} from struct socket.flags
to struct sock for better handling with SOCK_PASSRIGHTS.

Then, we don't need to access struct socket in maybe_add_creds().

Let's pass struct sock to maybe_add_creds() and its caller
queue_oob().

While at it, we append the unix_ prefix and fix double spaces
around the pid assignment.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 464e183ffdb8..a39497fd6e98 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1869,7 +1869,7 @@ static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool sen
 {
 	int err = 0;
 
-	UNIXCB(skb).pid  = get_pid(scm->pid);
+	UNIXCB(skb).pid = get_pid(scm->pid);
 	UNIXCB(skb).uid = scm->creds.uid;
 	UNIXCB(skb).gid = scm->creds.gid;
 	UNIXCB(skb).fp = NULL;
@@ -1886,15 +1886,15 @@ static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool sen
  * We include credentials if source or destination socket
  * asserted SOCK_PASSCRED.
  */
-static void maybe_add_creds(struct sk_buff *skb, const struct socket *sock,
-			    const struct sock *other)
+static void unix_maybe_add_creds(struct sk_buff *skb, const struct sock *sk,
+				 const struct sock *other)
 {
 	if (UNIXCB(skb).pid)
 		return;
 
-	if (unix_may_passcred(sock->sk) ||
+	if (unix_may_passcred(sk) ||
 	    !other->sk_socket || unix_may_passcred(other)) {
-		UNIXCB(skb).pid  = get_pid(task_tgid(current));
+		UNIXCB(skb).pid = get_pid(task_tgid(current));
 		current_uid_gid(&UNIXCB(skb).uid, &UNIXCB(skb).gid);
 	}
 }
@@ -2133,7 +2133,8 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	if (sock_flag(other, SOCK_RCVTSTAMP))
 		__net_timestamp(skb);
-	maybe_add_creds(skb, sock, other);
+
+	unix_maybe_add_creds(skb, sk, other);
 	scm_stat_add(other, skb);
 	skb_queue_tail(&other->sk_receive_queue, skb);
 	unix_state_unlock(other);
@@ -2161,14 +2162,14 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 #define UNIX_SKB_FRAGS_SZ (PAGE_SIZE << get_order(32768))
 
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
-static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other,
+static int queue_oob(struct sock *sk, struct msghdr *msg, struct sock *other,
 		     struct scm_cookie *scm, bool fds_sent)
 {
 	struct unix_sock *ousk = unix_sk(other);
 	struct sk_buff *skb;
 	int err;
 
-	skb = sock_alloc_send_skb(sock->sk, 1, msg->msg_flags & MSG_DONTWAIT, &err);
+	skb = sock_alloc_send_skb(sk, 1, msg->msg_flags & MSG_DONTWAIT, &err);
 
 	if (!skb)
 		return err;
@@ -2192,7 +2193,7 @@ static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other
 		goto out;
 	}
 
-	maybe_add_creds(skb, sock, other);
+	unix_maybe_add_creds(skb, sk, other);
 	scm_stat_add(other, skb);
 
 	spin_lock(&other->sk_receive_queue.lock);
@@ -2308,7 +2309,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 		    (other->sk_shutdown & RCV_SHUTDOWN))
 			goto out_pipe_unlock;
 
-		maybe_add_creds(skb, sock, other);
+		unix_maybe_add_creds(skb, sk, other);
 		scm_stat_add(other, skb);
 		skb_queue_tail(&other->sk_receive_queue, skb);
 		unix_state_unlock(other);
@@ -2318,7 +2319,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
 	if (msg->msg_flags & MSG_OOB) {
-		err = queue_oob(sock, msg, other, &scm, fds_sent);
+		err = queue_oob(sk, msg, other, &scm, fds_sent);
 		if (err)
 			goto out_err;
 		sent++;
-- 
2.49.0


