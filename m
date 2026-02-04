Return-Path: <netdev+bounces-256586-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKz+NrDegmnfdgMAu9opvQ
	(envelope-from <netdev+bounces-256586-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 06:52:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 38065E21ED
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 06:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 162A23013793
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 05:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD2F365A1D;
	Wed,  4 Feb 2026 05:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yrRate99"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C2636165E
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 05:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770184313; cv=none; b=XU02hent643jgtzS3v2cBCH2v97TCWedhVWqSLEtfI1ukS1ewy21qj8/AEjjJBvSwoO0LclNJhFHrsne5l45MTGs5vXmfmuH8huophMzAWk+WZxYIkB2J3XvBanYpF8QQS+Ux08nWnr0XjKn6EyGRrS70uUcxLWLNgjY5B1W3Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770184313; c=relaxed/simple;
	bh=I0tTxECgkCMwBvsene3MQWebPTWgUj/vGmFg1RaYF2g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MPeAjiRu++qVhXtTXwx+pHJ2AGs80MJyGhTbX1/fm8tcM0WZxcqt6aqWxvBrcHR7pBXYdnmhiRyj3kv6nrH/4Gol1tjLN/GQ9Z2mSxK4XLyw2L4H7gWOBOJj9ig+QWuBdGODylizdFBmjm4JMX4kIOWUfC2vr7c6CDkZRgU2oQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yrRate99; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c6ae763d03so676669985a.3
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 21:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770184313; x=1770789113; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iU9z84iuhGDjVJFhP61vT0jZSQYu6HfIK7e7kXaQZn8=;
        b=yrRate99m8CTtSc3dgwAQz88Ro9WKBnWTNQMpWPYu/NgCAu2ugDxRyLvvfioT1l8NH
         +/GfE+Q0kw6nWc/204Nd9pfzwfmIX6fIRriHN+2he34Wgc++aNggIYGMu+3nKNLKMJxy
         ACjpqSB0MdXhmsOp0L6De3vcpRvCZjb69B7fFx+YWcqRcti89mczs2aoFXZqNcWFZ3wU
         81GQFGx942IKZRcXRR9KIbZkVE+XrsLZSis+NWoqrtm5udykWuvxTfS+mBJ6EZfkme/+
         ZUwrOU7MA161LpVOFfFEsdoBucKJO722tiT2PoUsK2Ne21XwGEmdUSy52imto00zt9+A
         2JPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770184313; x=1770789113;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iU9z84iuhGDjVJFhP61vT0jZSQYu6HfIK7e7kXaQZn8=;
        b=AhoN4UklDIRfrKx3mKWpvgOc6t/d6RHAMB5GYvIOYtW9T95ZUymf6CPwaeV0164Qs2
         H+AbWMJvb2iI4etq+Vd8BGEUnircipY3H4jyhshDQz8GQQwAotJB/VkzCHHb4zmyXVd9
         rRNvNKWQHFjZDCKoHy2XZNv3CfWo7wlt+jOpkKuzseKn3BW/A8+3NGvX2WdGrsQwhdpe
         RjsbdbknzLvhJV+zj7t31MmbHC3rDwXcxRobY6gcpAcfuLAqMZz5M5wrK1nsLCZveAae
         q9L/LdfOcU9xrB4e4y+qo8PJGRr+u7lPOM+cK8nKY9frqFbZROQf7U6ny75xQyluqNtz
         L2mw==
X-Forwarded-Encrypted: i=1; AJvYcCWcyF9e3iOJhu1IZvIyOLZ67muejGrmVAvvdxshALXkCSexMkEgqTBtG0JcgLk5zu1sVJ1zsic=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYrVPvtzGZHJkhpcOdY7x5g1FPvPhY3sodKwopscOMTdCHCTRM
	Qt2opQoGkrOcat+lxDSljrcNxRmWtLs0meTinxSBQrA8x9Y34RSNsPKJiUiKTKBBCXCzA+RLUaS
	u5C8za/n8cF6Dqw==
X-Received: from qkab26.prod.google.com ([2002:a05:620a:89a:b0:8c5:3045:74e9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:408f:b0:8c7:1211:e49b with SMTP id af79cd13be357-8ca2fa06d6amr238669985a.74.1770184312655;
 Tue, 03 Feb 2026 21:51:52 -0800 (PST)
Date: Wed,  4 Feb 2026 05:51:45 +0000
In-Reply-To: <20260204055147.1682705-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260204055147.1682705-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260204055147.1682705-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/4] tcp: move reqsk_fastopen_remove to net/ipv4/tcp_fastopen.c
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256586-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 38065E21ED
X-Rspamd-Action: no action

This function belongs to TCP stack, not to net/core/request_sock.c

We get rid of the now empty request_sock.c n the following patch.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/request_sock.c | 85 ----------------------------------------
 net/ipv4/tcp_fastopen.c | 86 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+), 85 deletions(-)

diff --git a/net/core/request_sock.c b/net/core/request_sock.c
index 31389f875b19b56592e81576b8812359017daac9..e6c451e549ce4fb316b1afc0b40dff68b66e0a0f 100644
--- a/net/core/request_sock.c
+++ b/net/core/request_sock.c
@@ -16,88 +16,3 @@
 
 #include <net/request_sock.h>
 
-/*
- * This function is called to set a Fast Open socket's "fastopen_rsk" field
- * to NULL when a TFO socket no longer needs to access the request_sock.
- * This happens only after 3WHS has been either completed or aborted (e.g.,
- * RST is received).
- *
- * Before TFO, a child socket is created only after 3WHS is completed,
- * hence it never needs to access the request_sock. things get a lot more
- * complex with TFO. A child socket, accepted or not, has to access its
- * request_sock for 3WHS processing, e.g., to retransmit SYN-ACK pkts,
- * until 3WHS is either completed or aborted. Afterwards the req will stay
- * until either the child socket is accepted, or in the rare case when the
- * listener is closed before the child is accepted.
- *
- * In short, a request socket is only freed after BOTH 3WHS has completed
- * (or aborted) and the child socket has been accepted (or listener closed).
- * When a child socket is accepted, its corresponding req->sk is set to
- * NULL since it's no longer needed. More importantly, "req->sk == NULL"
- * will be used by the code below to determine if a child socket has been
- * accepted or not, and the check is protected by the fastopenq->lock
- * described below.
- *
- * Note that fastopen_rsk is only accessed from the child socket's context
- * with its socket lock held. But a request_sock (req) can be accessed by
- * both its child socket through fastopen_rsk, and a listener socket through
- * icsk_accept_queue.rskq_accept_head. To protect the access a simple spin
- * lock per listener "icsk->icsk_accept_queue.fastopenq->lock" is created.
- * only in the rare case when both the listener and the child locks are held,
- * e.g., in inet_csk_listen_stop() do we not need to acquire the lock.
- * The lock also protects other fields such as fastopenq->qlen, which is
- * decremented by this function when fastopen_rsk is no longer needed.
- *
- * Note that another solution was to simply use the existing socket lock
- * from the listener. But first socket lock is difficult to use. It is not
- * a simple spin lock - one must consider sock_owned_by_user() and arrange
- * to use sk_add_backlog() stuff. But what really makes it infeasible is the
- * locking hierarchy violation. E.g., inet_csk_listen_stop() may try to
- * acquire a child's lock while holding listener's socket lock.
- *
- * This function also sets "treq->tfo_listener" to false.
- * treq->tfo_listener is used by the listener so it is protected by the
- * fastopenq->lock in this function.
- */
-void reqsk_fastopen_remove(struct sock *sk, struct request_sock *req,
-			   bool reset)
-{
-	struct sock *lsk = req->rsk_listener;
-	struct fastopen_queue *fastopenq;
-
-	fastopenq = &inet_csk(lsk)->icsk_accept_queue.fastopenq;
-
-	RCU_INIT_POINTER(tcp_sk(sk)->fastopen_rsk, NULL);
-	spin_lock_bh(&fastopenq->lock);
-	fastopenq->qlen--;
-	tcp_rsk(req)->tfo_listener = false;
-	if (req->sk)	/* the child socket hasn't been accepted yet */
-		goto out;
-
-	if (!reset || lsk->sk_state != TCP_LISTEN) {
-		/* If the listener has been closed don't bother with the
-		 * special RST handling below.
-		 */
-		spin_unlock_bh(&fastopenq->lock);
-		reqsk_put(req);
-		return;
-	}
-	/* Wait for 60secs before removing a req that has triggered RST.
-	 * This is a simple defense against TFO spoofing attack - by
-	 * counting the req against fastopen.max_qlen, and disabling
-	 * TFO when the qlen exceeds max_qlen.
-	 *
-	 * For more details see CoNext'11 "TCP Fast Open" paper.
-	 */
-	req->rsk_timer.expires = jiffies + 60*HZ;
-	if (fastopenq->rskq_rst_head == NULL)
-		fastopenq->rskq_rst_head = req;
-	else
-		fastopenq->rskq_rst_tail->dl_next = req;
-
-	req->dl_next = NULL;
-	fastopenq->rskq_rst_tail = req;
-	fastopenq->qlen++;
-out:
-	spin_unlock_bh(&fastopenq->lock);
-}
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 7d945a527daf093f87882c7949e21058ed6df1cc..b30090cff3cf7d925dc46694860abd3ca5516d70 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -5,6 +5,92 @@
 #include <net/tcp.h>
 #include <net/busy_poll.h>
 
+/*
+ * This function is called to set a Fast Open socket's "fastopen_rsk" field
+ * to NULL when a TFO socket no longer needs to access the request_sock.
+ * This happens only after 3WHS has been either completed or aborted (e.g.,
+ * RST is received).
+ *
+ * Before TFO, a child socket is created only after 3WHS is completed,
+ * hence it never needs to access the request_sock. things get a lot more
+ * complex with TFO. A child socket, accepted or not, has to access its
+ * request_sock for 3WHS processing, e.g., to retransmit SYN-ACK pkts,
+ * until 3WHS is either completed or aborted. Afterwards the req will stay
+ * until either the child socket is accepted, or in the rare case when the
+ * listener is closed before the child is accepted.
+ *
+ * In short, a request socket is only freed after BOTH 3WHS has completed
+ * (or aborted) and the child socket has been accepted (or listener closed).
+ * When a child socket is accepted, its corresponding req->sk is set to
+ * NULL since it's no longer needed. More importantly, "req->sk == NULL"
+ * will be used by the code below to determine if a child socket has been
+ * accepted or not, and the check is protected by the fastopenq->lock
+ * described below.
+ *
+ * Note that fastopen_rsk is only accessed from the child socket's context
+ * with its socket lock held. But a request_sock (req) can be accessed by
+ * both its child socket through fastopen_rsk, and a listener socket through
+ * icsk_accept_queue.rskq_accept_head. To protect the access a simple spin
+ * lock per listener "icsk->icsk_accept_queue.fastopenq->lock" is created.
+ * only in the rare case when both the listener and the child locks are held,
+ * e.g., in inet_csk_listen_stop() do we not need to acquire the lock.
+ * The lock also protects other fields such as fastopenq->qlen, which is
+ * decremented by this function when fastopen_rsk is no longer needed.
+ *
+ * Note that another solution was to simply use the existing socket lock
+ * from the listener. But first socket lock is difficult to use. It is not
+ * a simple spin lock - one must consider sock_owned_by_user() and arrange
+ * to use sk_add_backlog() stuff. But what really makes it infeasible is the
+ * locking hierarchy violation. E.g., inet_csk_listen_stop() may try to
+ * acquire a child's lock while holding listener's socket lock.
+ *
+ * This function also sets "treq->tfo_listener" to false.
+ * treq->tfo_listener is used by the listener so it is protected by the
+ * fastopenq->lock in this function.
+ */
+void reqsk_fastopen_remove(struct sock *sk, struct request_sock *req,
+			   bool reset)
+{
+	struct sock *lsk = req->rsk_listener;
+	struct fastopen_queue *fastopenq;
+
+	fastopenq = &inet_csk(lsk)->icsk_accept_queue.fastopenq;
+
+	RCU_INIT_POINTER(tcp_sk(sk)->fastopen_rsk, NULL);
+	spin_lock_bh(&fastopenq->lock);
+	fastopenq->qlen--;
+	tcp_rsk(req)->tfo_listener = false;
+	if (req->sk)	/* the child socket hasn't been accepted yet */
+		goto out;
+
+	if (!reset || lsk->sk_state != TCP_LISTEN) {
+		/* If the listener has been closed don't bother with the
+		 * special RST handling below.
+		 */
+		spin_unlock_bh(&fastopenq->lock);
+		reqsk_put(req);
+		return;
+	}
+	/* Wait for 60secs before removing a req that has triggered RST.
+	 * This is a simple defense against TFO spoofing attack - by
+	 * counting the req against fastopen.max_qlen, and disabling
+	 * TFO when the qlen exceeds max_qlen.
+	 *
+	 * For more details see CoNext'11 "TCP Fast Open" paper.
+	 */
+	req->rsk_timer.expires = jiffies + 60*HZ;
+	if (fastopenq->rskq_rst_head == NULL)
+		fastopenq->rskq_rst_head = req;
+	else
+		fastopenq->rskq_rst_tail->dl_next = req;
+
+	req->dl_next = NULL;
+	fastopenq->rskq_rst_tail = req;
+	fastopenq->qlen++;
+out:
+	spin_unlock_bh(&fastopenq->lock);
+}
+
 void tcp_fastopen_init_key_once(struct net *net)
 {
 	u8 key[TCP_FASTOPEN_KEY_LENGTH];
-- 
2.53.0.rc2.204.g2597b5adb4-goog


