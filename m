Return-Path: <netdev+bounces-149595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFD59E66DA
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 06:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8C8284A02
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 05:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6307C1953BA;
	Fri,  6 Dec 2024 05:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="g8t2xk5o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE28193426
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 05:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733462885; cv=none; b=fyFXFavSM4t8S6BrrU3irLDXWtDfzrtCp8wx9ro/O9Hjwwl+DU9/yEQA+R/mYBS/dSN5av0XOWmteq2vyQRsIDS0VAUsVH15bNy34Y5yGCpnkBCfjIn1s/+xL8+r5FCDHUjp2dj+RTexGQC9r8mXTo8kzpyexrI+Wa4rB02EWLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733462885; c=relaxed/simple;
	bh=A4zq6dxyboarjg2+PhHALcIETAKnfIz7TAxGdHFDdcQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iRNeSrKfBFgPDU4oxjrnCP2lV5Z3+HJYpu36OqJwZuW7dXcdYxlLrxGzIM08GPQYyIV0nUQA+9Wd8wKNQMay4T1uztN/0osshDEVhbFtkeKsBQXqxk+DEleVX2RB7vddMD3FHdC3dffdlcZ7OFDk1aGVMUjrnO4svBN08C69zsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=g8t2xk5o; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733462884; x=1764998884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WCkPtRJnM77Q/MzHyBaYveKfYymUl9k/RvVeRNCnA2U=;
  b=g8t2xk5oCaBDk8PsPGHNPDJQI4KIDcP0na+eMvWLZoK3FXglpWubOKYw
   auomcCxbWYpY3r0o+cmDVmfxnGcwbMzpt9xzii0EXEVQ5qa0ESbSyDiM5
   /A4qZBRvq4kCPtN3349UHESNvIqi1Y1oHgIuTZhk6aV5UT7A9vHvpUWBD
   c=;
X-IronPort-AV: E=Sophos;i="6.12,212,1728950400"; 
   d="scan'208";a="358556227"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 05:28:02 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:26369]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.223:2525] with esmtp (Farcaster)
 id 55f67eec-5074-40cb-9ede-b35674b25bed; Fri, 6 Dec 2024 05:28:01 +0000 (UTC)
X-Farcaster-Flow-ID: 55f67eec-5074-40cb-9ede-b35674b25bed
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 6 Dec 2024 05:28:01 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.244.93) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 6 Dec 2024 05:27:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 05/15] af_unix: Clean up error paths in unix_stream_sendmsg().
Date: Fri, 6 Dec 2024 14:25:57 +0900
Message-ID: <20241206052607.1197-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D044UWB001.ant.amazon.com (10.13.139.171) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We removed the pipe_err label along the SEND_SHUTDOWN check,
and we can reuse the kfree_skb() in the pipe_err_free label.

Let's gather the scattered kfree_skb()s in error paths.

While at it, some style issues are fixed, and the pipe_err_free
label is renamed to out_pipe to match other label names.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index db00afe84ce9..7e6241ba7604 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2302,19 +2302,17 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 
 		/* Only send the fds in the first buffer */
 		err = unix_scm_to_skb(&scm, skb, !fds_sent);
-		if (err < 0) {
-			kfree_skb(skb);
-			goto out_err;
-		}
+		if (err < 0)
+			goto out_free;
+
 		fds_sent = true;
 
 		if (unlikely(msg->msg_flags & MSG_SPLICE_PAGES)) {
 			err = skb_splice_from_iter(skb, &msg->msg_iter, size,
 						   sk->sk_allocation);
-			if (err < 0) {
-				kfree_skb(skb);
-				goto out_err;
-			}
+			if (err < 0)
+				goto out_free;
+
 			size = err;
 			refcount_add(size, &sk->sk_wmem_alloc);
 		} else {
@@ -2322,17 +2320,15 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 			skb->data_len = data_len;
 			skb->len = size;
 			err = skb_copy_datagram_from_iter(skb, 0, &msg->msg_iter, size);
-			if (err) {
-				kfree_skb(skb);
-				goto out_err;
-			}
+			if (err)
+				goto out_free;
 		}
 
 		unix_state_lock(other);
 
 		if (sock_flag(other, SOCK_DEAD) ||
 		    (other->sk_shutdown & RCV_SHUTDOWN))
-			goto pipe_err_free;
+			goto out_pipe;
 
 		maybe_add_creds(skb, sock, other);
 		scm_stat_add(other, skb);
@@ -2355,12 +2351,13 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	return sent;
 
-pipe_err_free:
+out_pipe:
 	unix_state_unlock(other);
-	kfree_skb(skb);
-	if (sent == 0 && !(msg->msg_flags&MSG_NOSIGNAL))
+	if (!sent && !(msg->msg_flags & MSG_NOSIGNAL))
 		send_sig(SIGPIPE, current, 0);
 	err = -EPIPE;
+out_free:
+	kfree_skb(skb);
 out_err:
 	scm_destroy(&scm);
 	return sent ? : err;
-- 
2.39.5 (Apple Git-154)


