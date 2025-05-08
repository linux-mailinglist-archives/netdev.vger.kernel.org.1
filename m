Return-Path: <netdev+bounces-188836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03923AAF0A2
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 03:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111801BA5843
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 01:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57271FC0A;
	Thu,  8 May 2025 01:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Faflg6VG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D192CA8
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 01:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746667895; cv=none; b=mhqMC+2ymgy4j766PkSRE6Vliui9n/1I2pb3sscpIKxmROiEVhcgmUfqDRYcf95OuhPdgS+5sVPyfpTMpZOf6Xrq76M0nLXuw8p8QSlOFtakXbs8Wkon0zXjKSiR8JESdLVZNcfdZ7LTW+FtJlgNZzOMpVKg9XUGv8ldbzGVqBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746667895; c=relaxed/simple;
	bh=G6bkR6nFZ8Aay2JIKp40y1K0ZeuCaM3fVm4cdAvTtmA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fLpHslKh8i0K6PEgx5n7zQpcE1Secu1az99yE9TnucVQ3VjLUEaVKAxqGsdFA0w+70Enkc8Io75NKB0DhgOdO7QQ/836OCn9pJP8H3J1jCRn6mZ++pOd2rcvhFVjo1TdC9yCWHtK/RDpJcfQifzt58XDpsNvCTJlBTtJDfNkj0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Faflg6VG; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1746667883; x=1778203883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S+5oA/57xCNwOuwQcKPGbriTTxlX1o2fDXT6LLR75pg=;
  b=Faflg6VGscR80Y5INSbWUKl2HebJfWGBaPQ010G8sXsL0Bw4OnuLblns
   WMuDIxlLIy6AlAjn5ZM3Y1scF2/O4yIuK3hTjPV+YXhtxnyHGF7x31Bks
   yBC1WCFub1PGYKhfF4XM/W25SnQAiOGQmNO3BNsVhdMaNACYcuUeoZ86+
   sfAGDdCtXRNE+iVnT/oDcWLL75JKmBnWgYYQPX50KewK6PwblNKUA4+sp
   05WZ2OWErZYh+DRKdbm66MHR+XD7aJgwATHWSrZHOj47gizmrzGix4lUc
   0MPG/cA/yi/apgY1r4Ih7i8aAHZ25jf+lQ3FQWH0iQQ7JJGWs9BG4CRIB
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,271,1739836800"; 
   d="scan'208";a="403112183"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 01:31:21 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:18822]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.231:2525] with esmtp (Farcaster)
 id 1c724a42-58fc-449e-8ec0-0d7c008c2a56; Thu, 8 May 2025 01:31:21 +0000 (UTC)
X-Farcaster-Flow-ID: 1c724a42-58fc-449e-8ec0-0d7c008c2a56
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 8 May 2025 01:31:20 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.46.110) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 8 May 2025 01:31:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 2/7] af_unix: Don't pass struct socket to maybe_add_creds().
Date: Wed, 7 May 2025 18:29:14 -0700
Message-ID: <20250508013021.79654-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508013021.79654-1-kuniyu@amazon.com>
References: <20250508013021.79654-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will move SOCK_PASS{CRED,PIDFD,SEC} from struct socket.flags
to struct sock.sk_flags for better handling with SOCK_PASSRIGHTS.

Then, we don't need to access struct socket in maybe_add_creds().

Let's pass struct sock to maybe_add_creds() and its caller
queue_oob().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 6dbe866f5e24..fa86e8c3aec5 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1886,13 +1886,13 @@ static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool sen
  * We include credentials if source or destination socket
  * asserted SOCK_PASSCRED.
  */
-static void maybe_add_creds(struct sk_buff *skb, const struct socket *sock,
+static void maybe_add_creds(struct sk_buff *skb, const struct sock *sk,
 			    const struct sock *other)
 {
 	if (UNIXCB(skb).pid)
 		return;
 
-	if (unix_passcred_enabled(sock->sk) ||
+	if (unix_passcred_enabled(sk) ||
 	    !other->sk_socket || unix_passcred_enabled(other)) {
 		UNIXCB(skb).pid  = get_pid(task_tgid(current));
 		current_uid_gid(&UNIXCB(skb).uid, &UNIXCB(skb).gid);
@@ -2133,7 +2133,8 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	if (sock_flag(other, SOCK_RCVTSTAMP))
 		__net_timestamp(skb);
-	maybe_add_creds(skb, sock, other);
+
+	maybe_add_creds(skb, sk, other);
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
+	maybe_add_creds(skb, sk, other);
 	scm_stat_add(other, skb);
 
 	spin_lock(&other->sk_receive_queue.lock);
@@ -2308,7 +2309,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 		    (other->sk_shutdown & RCV_SHUTDOWN))
 			goto out_pipe_unlock;
 
-		maybe_add_creds(skb, sock, other);
+		maybe_add_creds(skb, sk, other);
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


