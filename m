Return-Path: <netdev+bounces-256124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAXhCTmGgWmzGwMAu9opvQ
	(envelope-from <netdev+bounces-256124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:23:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A66D49BE
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 736C2306B09D
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 05:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F0E365A1A;
	Tue,  3 Feb 2026 05:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sI4JwlVx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F2E1F16B
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 05:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096137; cv=none; b=t5tDOlsSy6E4JoXyzjfhfeQWMIGTHTCvffBoiSvoPxDc65IahxkLFQmSqvTGu7X79uOkAJDTVSN0uZpDflhoRGETPOpn/kiEhGHiZgGQodN+0h+6ELgrvl2GJx61+B/8yZxhGHDXiefJAEKTS0MJcKwSYEgMrpTkznHn1VHrvpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096137; c=relaxed/simple;
	bh=CG+gTWTECCzuJ9niR2cHD4EyUb8XBm/NsI5BDr4mIPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QIOnJ2Ovlxqfls7mTu1UYc5XucUt24ajeR4iA4YKcsrUf9L9vXURPIv25+6iNOSmhA+KAzLJS9fbwEIqugC4q5zzExO0vmiW2bp55SulAcBmxgTETzsJCnuKoWsFapL7Cer2uJ6z7L9918g2PbHghEkCpRAzkq6AmRq8ZnQhBRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sI4JwlVx; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-503810dba87so288057361cf.1
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 21:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770096135; x=1770700935; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qrBvx8WHnOFn2KtWYyYRyZho9GUrlsyeH2KRhn0WOzU=;
        b=sI4JwlVxlRtpboFfd4CJ4Zc9uzlOABrpzWw7v77OvuTvWXdxpjpxREyJrRFYDY2ANb
         3rA4W7Oz3spZJ+aezW5Qj6XswdFOPL90uayW49w+zsyOlMm2JYMI8KR43QjHMSS3GoE6
         MLSqpRYj7mtJY4t3RxOVi/nV98337BaxFREfjsYzyI6/coV4fuZUy623tG22SnZavwda
         e1oDgOPNPLBpdavm07dbQwbEnPIt27ne7G+Ry4ZPtH4AaWiE0UUFATL0FTte1FWhbbuT
         zWfPTzYZHKmA1eUcZzFgOhfvQjYptoZ4eR/ZFcB7sf3ituELheX2mRw0PkH6O2csvb+C
         6Oyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770096135; x=1770700935;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qrBvx8WHnOFn2KtWYyYRyZho9GUrlsyeH2KRhn0WOzU=;
        b=M2VMkcrMIjQ0GFgLkCtmyXb75XNnpTsvmB1NzLeyN5CVnBEG6TWL1aUAaJ6wFEASvx
         qUzm/F0HIWaUNljNqwkR7i1eOsm26CnrtBQpwk17pzjEmxYFfucx5GD4WomuwlmxtC8j
         vsn3GDABpy1xKyNhwrlqMY2xZIGKw3erxKfOI624b0AuimciL867nBjgp+KlgjAe7Crj
         vG+oKbk1vwNhu4IJjohvJfZOZ24dAMDqhEm8/f2jirzdndSbsAgOJn9R63vc2Am9CMK8
         t2hn8Zv94gH8B8NqClXPEOtAoEfSoCaIPAIa0Nk47ZdpYDPoM9SJ5bx4Qqt5ipGjnw/g
         KKGA==
X-Forwarded-Encrypted: i=1; AJvYcCUrTxNisdnMGJvGtLgITJ9Fn05gJRgHH0YSD15hUdlHHxA9B2RN+2BQ7BQ4SU0GnAWBZXh7SnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCo0iRYr4YEmTaVGPqgfKUjbPxAeq6SYuZTZaT0cNbNpTGMpzw
	k2tfxh+kGp4ZXYZk1z4xsw8RfWhLqF/aUGDK6mp4MtbyF8UxMXfcwGU5eDg6kLX6gX3qRo7E77I
	FqcwWxuUVfOS0sA==
X-Received: from qkbea14.prod.google.com ([2002:a05:620a:488e:b0:8c6:6709:9ae4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:690d:b0:8b2:e069:6911 with SMTP id af79cd13be357-8c9eb2e84a3mr1984253385a.59.1770096134705;
 Mon, 02 Feb 2026 21:22:14 -0800 (PST)
Date: Tue,  3 Feb 2026 05:22:08 +0000
In-Reply-To: <20260203052210.3684125-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260203052210.3684125-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260203052210.3684125-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/4] tcp: move reqsk_fastopen_remove to net/ipv4/tcp_fastopen.c
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256124-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 94A66D49BE
X-Rspamd-Action: no action

This function belongs to TCP stack, not to net/core/request_sock.c

We get rid of the now empty request_sock.c in the following patch.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/request_sock.c | 85 ----------------------------------------
 net/ipv4/tcp_fastopen.c | 86 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+), 85 deletions(-)

diff --git a/net/core/request_sock.c b/net/core/request_sock.c
index 31389f875b19..e6c451e549ce 100644
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
index 7d945a527daf..b30090cff3cf 100644
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
2.53.0.rc1.225.gd81095ad13-goog


