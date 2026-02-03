Return-Path: <netdev+bounces-256123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMw6AyKGgWmzGwMAu9opvQ
	(envelope-from <netdev+bounces-256123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:22:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 624F9D49AF
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 284D33057E87
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 05:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29B1365A1A;
	Tue,  3 Feb 2026 05:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fyPRXDSZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69291366048
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 05:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096135; cv=none; b=VZf4aCdpyDu2s+BmKrBzBnJG/OvWQuYVvC55iNWLWDNJNQVLmLH/YA9kpLNBaNrESj88TSY9Ft8mwwq6t6nlxWKAUHyMw4Qskuwojcf75+zLYKTtUGLqhlZtILRXyixksGBYPUZ0cgHsGISlguaDmDF4w0PYkmNYtpgAhzhm/7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096135; c=relaxed/simple;
	bh=7dkQBczsEwmVJSOhS3hpYXEI+yzibKtjUIhTtDIeYvM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aD90p+0EsOd+WCScbI/sBVjqxiM5RFzM8QAey+alfBO0/1J1qNBaExSl4pwU0M+lX8Cy8I2NzTyg8xJi+zENQ6KRh+jXnKPjYSt4u9bzi+MVOp8fR06uVMFyCfT1K63STl8yjIa37rPvbIHVowJq25NDht1ivfiym6s3mWCzMZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fyPRXDSZ; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50146d98660so35111591cf.2
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 21:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770096133; x=1770700933; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HFUh1zaw6xUxFIQWyIIVams/RkXTf7ciZ3sl0FDhGG8=;
        b=fyPRXDSZkj7cQot0KGajluyLChV2DKXPeg93UCh0cjoO2hTTZZELSvn3xVIZif9vqp
         lX/71CzhqpMQShbuc+aOS9Mj2j/FwDd1RbhulfZa52E2ijir/Nc6QDLT38IK7QwsOkNS
         2NqF0qFnEY4YhWsEDkJBFXViG12eYAgJS+6EcxZetRb1ZZTyAsnUFElhL6BK/yDkQSBN
         vMVln2hUoOd3RJSwQnmcJ8I7ehuPaBWSOCUqYwBuE2Gy+QfZ8XUCy8gTMd7wocKPvqfV
         ruSSXbjCNgC4guaFP+zxRCPbs8bAIPB1193mkC9gZGopw6BGbDyFl2uVTVTjfS7YMY9i
         yfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770096133; x=1770700933;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFUh1zaw6xUxFIQWyIIVams/RkXTf7ciZ3sl0FDhGG8=;
        b=JQJ09ccnAJY2l9B82W/J5X/2p0v69EVEFELQ7P5ZeiSqnBcZiCM4JIUcnyUW4iFyXr
         XJCdfh5MrYR/UDfrvlMkHNoG2H0oy0XaEe/n/00kRp6nFsdJ1YtHPgUB6SzoyLMpjesN
         w2BVRAu9YsC1vmjgoxZ0Rny416OsHMHIsxMgswZQvDIe4msr4ATrcqV6uh9O2miHQR9R
         S6FJ70bqQXmn2sExQinB63l1HcqXpxCUkZe9VWK1VyFoJ5M871IY1r/J1Ywj4HVZtSEb
         lyLu+/3uwEXNkN1KAm8Nc0UQ9H/r0g66tOQGDM5dGTHnAN5/nmymge6wPdpYjCBc8qYQ
         rlQg==
X-Forwarded-Encrypted: i=1; AJvYcCXei0Yd57JAlPY3ZwOP6aUtRiqIujHy8IS5BqPOX8SSLA+1oj7Lkq97zTWaybW3zywhPAKtmmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYC+yowOYrIfjBIY0YTHVKyPFlt4G2qqzYm7uGMxWT3kwDuUxq
	ktaoj5PYMF7lt3tmuiQXhDu0Ilq418bzftkikWvDjuA4rbpxtNTunML5txP/mHpEDSxLgyFUPqy
	bdJ5SNfSMM2OSRw==
X-Received: from qtbg12.prod.google.com ([2002:ac8:7d0c:0:b0:4f0:1a83:4009])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5f12:0:b0:502:ba2c:b492 with SMTP id d75a77b69052e-505d22cff53mr179032541cf.77.1770096133348;
 Mon, 02 Feb 2026 21:22:13 -0800 (PST)
Date: Tue,  3 Feb 2026 05:22:07 +0000
In-Reply-To: <20260203052210.3684125-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260203052210.3684125-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260203052210.3684125-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/4] inet: move reqsk_queue_alloc() to net/ipv4/inet_connection_sock.c
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256123-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 624F9D49AF
X-Rspamd-Action: no action

Only called once from inet_csk_listen_start(), it can be static.

Remove stale comment.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/request_sock.h      |  2 --
 net/core/request_sock.c         | 24 ------------------------
 net/ipv4/inet_connection_sock.c |  9 +++++++++
 3 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index 9b9e04f6bb89..23bb909771fb 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -196,8 +196,6 @@ struct request_sock_queue {
 					     */
 };
 
-void reqsk_queue_alloc(struct request_sock_queue *queue);
-
 void reqsk_fastopen_remove(struct sock *sk, struct request_sock *req,
 			   bool reset);
 
diff --git a/net/core/request_sock.c b/net/core/request_sock.c
index 897a8f01a67b..31389f875b19 100644
--- a/net/core/request_sock.c
+++ b/net/core/request_sock.c
@@ -16,30 +16,6 @@
 
 #include <net/request_sock.h>
 
-/*
- * Maximum number of SYN_RECV sockets in queue per LISTEN socket.
- * One SYN_RECV socket costs about 80bytes on a 32bit machine.
- * It would be better to replace it with a global counter for all sockets
- * but then some measure against one socket starving all other sockets
- * would be needed.
- *
- * The minimum value of it is 128. Experiments with real servers show that
- * it is absolutely not enough even at 100conn/sec. 256 cures most
- * of problems.
- * This value is adjusted to 128 for low memory machines,
- * and it will increase in proportion to the memory of machine.
- * Note : Dont forget somaxconn that may limit backlog too.
- */
-
-void reqsk_queue_alloc(struct request_sock_queue *queue)
-{
-	queue->fastopenq.rskq_rst_head = NULL;
-	queue->fastopenq.rskq_rst_tail = NULL;
-	queue->fastopenq.qlen = 0;
-
-	queue->rskq_accept_head = NULL;
-}
-
 /*
  * This function is called to set a Fast Open socket's "fastopen_rsk" field
  * to NULL when a TFO socket no longer needs to access the request_sock.
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 13372d2cbed5..dc4e2c5725cd 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1311,6 +1311,15 @@ static int inet_ulp_can_listen(const struct sock *sk)
 	return 0;
 }
 
+static void reqsk_queue_alloc(struct request_sock_queue *queue)
+{
+	queue->fastopenq.rskq_rst_head = NULL;
+	queue->fastopenq.rskq_rst_tail = NULL;
+	queue->fastopenq.qlen = 0;
+
+	queue->rskq_accept_head = NULL;
+}
+
 int inet_csk_listen_start(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
-- 
2.53.0.rc1.225.gd81095ad13-goog


