Return-Path: <netdev+bounces-236108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93116C387CF
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 01:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C89B3ACCDB
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 00:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B76E165F16;
	Thu,  6 Nov 2025 00:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GNF0p6zO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8520E1459FA
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 00:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762389251; cv=none; b=PjSSwrGt7GN5XklVg8SzAwPufG/RCaVRHwJdM8TerbIKN/QbkjMCucy+pKSCY2NTZbhHjS+rpIY68E0EitJasHKSBt9P5ILk7U6zNWfkojcFS0AjoYkgBLz7ow26g3PcsM4FvLf0VNo6aMhQ0/j2ThX6EVG/vJcVFoVJEyrVcsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762389251; c=relaxed/simple;
	bh=djhbnT+KXcrF0GEfA2kBcfytVC5yrUO3PSaTTDAQZUk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r9ASlozk0XEIRFih+iKDKK8YyQQw9ZLXUZtWJmE2w/kuegpNGgLsLBqQNglrBm23Jzy4CBoofa4sUG2A3Iltw7bIOsi9Ax2BqtgfbxNQbFd2IVsMufXi9Rsy4I03BI/2YwfdYoO+cgQ9soSZ1sZA2BLzcer9VmRaQKXxMZezDjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GNF0p6zO; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3405c46a22eso528460a91.2
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 16:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762389249; x=1762994049; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ScZ2guxMHwmtNNUoR8/im6bJwLit2p880RAAFQMkIME=;
        b=GNF0p6zOvBJAVUOglfvggjPyngeMzgh4pG50F74DeMgFh0zHicw5bOKqbQcLA92NEo
         0ZDgQqAf/2dVZ6akbE93lOjjc6al25r8THHmirx//k5zj9WgcKpiMOAjR+K6bguiPiFY
         mYqLLxMLp0cnH0g60j+U5YFRqbqi2OCiBRghaQrxtvCvHFRoXm88hmywurCdukXWQFXZ
         ETCeUSa7zjd2Cx7+WZEQ/QNlegnammpe8hNZ25RFBE3fz906YWdJrFcQ2KCWr3vnVmV9
         3kVU7QJqUiL2hZHrUJFGVUSgeeak6h+m2ckrVpSMqLcK+rpPXPRWa6iqvJcxJYHElF5A
         Rh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762389249; x=1762994049;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScZ2guxMHwmtNNUoR8/im6bJwLit2p880RAAFQMkIME=;
        b=c7UoULoRVt/iMCNu33JaQdi5A1cFaN1OvXT40Egy3icnlDhj0+xOJIBtKZeSd3F1Wy
         Uu419q0cn9UPExXAr64hf4/zo6294Q0r3BqtN+lWwENiRDg0KqrO+5Zx8gjxxz8D08dV
         xcZ0eqG4LCQo0WyZBGJ4aqw/wsRTH9syqDrUtkxdSQJcH+QCfNd0nK21Vid0o3IFV17i
         E37I+162t6cZxf/iKJdei915Gc37Z3NsBe6NDu9mNSnngrMuSVzDL37C0jZBSLviUc6/
         LTY3RrSWTBFm11vutY1kny81Fjz2pChbc1wEq2NhaaFmh8Vm95emA+RxlhojFOdsLXk7
         QaVg==
X-Forwarded-Encrypted: i=1; AJvYcCUZwa0ehUBKh7qnt9MmYq8joZCRmE7Fg6tnw8sLr3QU9Orf1RsJ9nyLoY5S4XDoOgOHjJd+WfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YykipAYHekraeuNLb0eIcth1g9eO15BnByW9sBZWqtB65TzBQyY
	1V17ObacHdClBLVjrCkoIZH2OU2Mxg2ETwm3FMAaDYuSqnGUZ7BSgGW8DvY79ZUbiJWZexr4QCP
	Tc4FH4g==
X-Google-Smtp-Source: AGHT+IF4rVKlHLXwi/RIMRWPebtbYfxA3Z3fgJmzhVOi96vDKYpj3WD6n6f5eVLk6g3IkINoE02Iyw5qGbw=
X-Received: from pjbpc4.prod.google.com ([2002:a17:90b:3b84:b0:338:3e6b:b835])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ccd:b0:32e:d599:1f66
 with SMTP id 98e67ed59e1d1-341a6defecemr6286382a91.30.1762389248819; Wed, 05
 Nov 2025 16:34:08 -0800 (PST)
Date: Thu,  6 Nov 2025 00:32:41 +0000
In-Reply-To: <20251106003357.273403-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106003357.273403-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.2.1026.g39e6a42477-goog
Message-ID: <20251106003357.273403-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 2/6] tcp: Remove timeout arg from reqsk_queue_hash_req().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Yuchung Cheng <ycheng@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

inet_csk_reqsk_queue_hash_add() is no longer shared by DCCP.

We do not need to pass req->timeout down to reqsk_queue_hash_req().

Let's move tcp_timeout_init() from tcp_conn_request() to
reqsk_queue_hash_req().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/inet_connection_sock.h |  3 +--
 net/ipv4/inet_connection_sock.c    | 11 +++++------
 net/ipv4/tcp_input.c               | 14 +++++---------
 3 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index b4b886647607..90a99a2fc804 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -267,8 +267,7 @@ struct dst_entry *inet_csk_route_child_sock(const struct sock *sk,
 struct sock *inet_csk_reqsk_queue_add(struct sock *sk,
 				      struct request_sock *req,
 				      struct sock *child);
-bool inet_csk_reqsk_queue_hash_add(struct sock *sk, struct request_sock *req,
-				   unsigned long timeout);
+bool inet_csk_reqsk_queue_hash_add(struct sock *sk, struct request_sock *req);
 struct sock *inet_csk_complete_hashdance(struct sock *sk, struct sock *child,
 					 struct request_sock *req,
 					 bool own_req);
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 6a86c1ac3011..d9c674403eb0 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1144,8 +1144,7 @@ static void reqsk_timer_handler(struct timer_list *t)
 	reqsk_put(oreq);
 }
 
-static bool reqsk_queue_hash_req(struct request_sock *req,
-				 unsigned long timeout)
+static bool reqsk_queue_hash_req(struct request_sock *req)
 {
 	bool found_dup_sk = false;
 
@@ -1153,8 +1152,9 @@ static bool reqsk_queue_hash_req(struct request_sock *req,
 		return false;
 
 	/* The timer needs to be setup after a successful insertion. */
+	req->timeout = tcp_timeout_init((struct sock *)req);
 	timer_setup(&req->rsk_timer, reqsk_timer_handler, TIMER_PINNED);
-	mod_timer(&req->rsk_timer, jiffies + timeout);
+	mod_timer(&req->rsk_timer, jiffies + req->timeout);
 
 	/* before letting lookups find us, make sure all req fields
 	 * are committed to memory and refcnt initialized.
@@ -1164,10 +1164,9 @@ static bool reqsk_queue_hash_req(struct request_sock *req,
 	return true;
 }
 
-bool inet_csk_reqsk_queue_hash_add(struct sock *sk, struct request_sock *req,
-				   unsigned long timeout)
+bool inet_csk_reqsk_queue_hash_add(struct sock *sk, struct request_sock *req)
 {
-	if (!reqsk_queue_hash_req(req, timeout))
+	if (!reqsk_queue_hash_req(req))
 		return false;
 
 	inet_csk_reqsk_queue_added(sk);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 6db1d4c36a88..804ec56bdd24 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7531,15 +7531,11 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 		sock_put(fastopen_sk);
 	} else {
 		tcp_rsk(req)->tfo_listener = false;
-		if (!want_cookie) {
-			req->timeout = tcp_timeout_init((struct sock *)req);
-			if (unlikely(!inet_csk_reqsk_queue_hash_add(sk, req,
-								    req->timeout))) {
-				reqsk_free(req);
-				dst_release(dst);
-				return 0;
-			}
-
+		if (!want_cookie &&
+		    unlikely(!inet_csk_reqsk_queue_hash_add(sk, req))) {
+			reqsk_free(req);
+			dst_release(dst);
+			return 0;
 		}
 		af_ops->send_synack(sk, dst, &fl, req, &foc,
 				    !want_cookie ? TCP_SYNACK_NORMAL :
-- 
2.51.2.1026.g39e6a42477-goog


