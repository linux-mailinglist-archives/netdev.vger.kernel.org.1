Return-Path: <netdev+bounces-100847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E83248FC44E
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5206FB2A42E
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 07:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E7018F2C4;
	Wed,  5 Jun 2024 07:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2YxHlWSS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C319518F2C9
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 07:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571763; cv=none; b=Fu4aJh0D8S4uxIYRVPuxFdaAaM/XO4460OuxDUolyTa3A7+AzpLK6rKbVXlJ9PmuXf4fD1eeiuXKqJJA/0IjH+KTleEcckiTX5rqJ+JAs/NJ7WiaYpKzRdIJbjt2kFmFbeLBehlXdAsvxSa5iCgjdDakUu0ZGxk4EMNQ1Vs2kFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571763; c=relaxed/simple;
	bh=TG41aC4i/FUaVvsbHGCUaFpOFijRZgpSqPKl/xfWlrg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eG01mRb/84Os04lTDf+yL6rJOvrEuOKOXVJSsArko3gp5B501W/qOqf5tY4k/X1n+xcgGwtHzuN0Kz4PbMGRT00cS18bmRUJ7raNLJRj5t0kLrrBTjlhG2i7UraMkWPnMB6mo0i1CbEe4J9dS8MH6/zWarKY7RWho29H2eo+ydA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2YxHlWSS; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df7bdb0455bso3122837276.2
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 00:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717571761; x=1718176561; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KavMCqME4wKgLSC+O6pjx/Bc818a9gtmfOnSQN0yjy0=;
        b=2YxHlWSSzEj2mBxNwKHF4c0ChAX5GoU9GIpfVMpT4AcGo7W37YtCXPHanZfR8ZojQy
         6jxBupNxRT5iPJ2QbKF36pk4UCyctK1wYcHUk+bVNYtufucdtD1ToYMSCNpG5b+5kygV
         fCDa+IsbKeg110J3WWCi6BBKXd3/rYVn4iFMk9cUH7KSbbaMQ0Q/ATXyUEZlcZNJPhYB
         bKZma+pjIvxjS39izIXwgkzqTM2W0EsB9cd/NaMTCYHeBvr2OPO22cHiVC16dzAE/NW1
         6/c8NqfWtUyS6KqwPI4gHsIcqcwpM2dNaCTWna+/oGRPLKLjCbrhVELOetmUcS0OwLKg
         YzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717571761; x=1718176561;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KavMCqME4wKgLSC+O6pjx/Bc818a9gtmfOnSQN0yjy0=;
        b=DxMlOW9m9tsSYcspCVTSRBDhPvebC34sAf626ElqaKzl23bS7dN6wvB6yVaB08lOoJ
         bab2aXnc7kHX7KCG3quQGczd0nhWjqCgM76voW8qrIY0GOh9cR9J3v5y3h/YzyXdaRRs
         SDJMsUzLnsb//QGgOeS564rqHvGzq6yld0X3PQ/6aqd1BMoe7lTh6v2SzNZ/u+lly5/e
         uulsLYbi2WYRls4wwJ1/Llp8gH/DGGYFkjU1qfT9klo/2xolBf+uYyXwdZ9ckM/D/FGZ
         Cy/keb6CRwOj7NX53v8efSfGQr1rOOl6IT1psIbf1xGDAOqtU5iAcB6WC/ZVu7CNFbw6
         esAw==
X-Gm-Message-State: AOJu0Yw0OlwC+c2pP9LITghjpGISJuA+9+VUVorMD69qcrEFbXNzaanh
	45kwqKx0SPSxkVAaTehGwiAH7E+trTPw+da79LE9fhLDM6m8cJmdqn4DaQ1r8Jwoped64gVnFT4
	aIJWiL+Iijg==
X-Google-Smtp-Source: AGHT+IHl9XI4q8EFSb/EKUebZSk7H9E84ZaDAPdpPvsfQh27hZQC88h3jAh3DwnZSMDbM2J8rpCTCu/SXOfrGw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2b90:b0:df4:920f:3192 with SMTP
 id 3f1490d57ef6-dfacacf10edmr172657276.8.1717571760626; Wed, 05 Jun 2024
 00:16:00 -0700 (PDT)
Date: Wed,  5 Jun 2024 07:15:52 +0000
In-Reply-To: <20240605071553.1365557-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240605071553.1365557-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240605071553.1365557-3-edumazet@google.com>
Subject: [PATCH net-next 2/3] tcp: move inet_reqsk_alloc() close to inet_reqsk_clone()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

inet_reqsk_alloc() does not belong to tcp_input.c,
move it to inet_connection_sock.c instead.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inet_connection_sock.c | 25 +++++++++++++++++++++++++
 net/ipv4/tcp_input.c            | 25 -------------------------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index d81f74ce0f02..a9d2e6308910 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -911,6 +911,31 @@ int inet_rtx_syn_ack(const struct sock *parent, struct request_sock *req)
 }
 EXPORT_SYMBOL(inet_rtx_syn_ack);
 
+struct request_sock *inet_reqsk_alloc(const struct request_sock_ops *ops,
+				      struct sock *sk_listener,
+				      bool attach_listener)
+{
+	struct request_sock *req = reqsk_alloc(ops, sk_listener,
+					       attach_listener);
+
+	if (req) {
+		struct inet_request_sock *ireq = inet_rsk(req);
+
+		ireq->ireq_opt = NULL;
+#if IS_ENABLED(CONFIG_IPV6)
+		ireq->pktopts = NULL;
+#endif
+		atomic64_set(&ireq->ir_cookie, 0);
+		ireq->ireq_state = TCP_NEW_SYN_RECV;
+		write_pnet(&ireq->ireq_net, sock_net(sk_listener));
+		ireq->ireq_family = sk_listener->sk_family;
+		req->timeout = TCP_TIMEOUT_INIT;
+	}
+
+	return req;
+}
+EXPORT_SYMBOL(inet_reqsk_alloc);
+
 static struct request_sock *inet_reqsk_clone(struct request_sock *req,
 					     struct sock *sk)
 {
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 212b6fd0caf7..eb187450e4d7 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6986,31 +6986,6 @@ static void tcp_openreq_init(struct request_sock *req,
 #endif
 }
 
-struct request_sock *inet_reqsk_alloc(const struct request_sock_ops *ops,
-				      struct sock *sk_listener,
-				      bool attach_listener)
-{
-	struct request_sock *req = reqsk_alloc(ops, sk_listener,
-					       attach_listener);
-
-	if (req) {
-		struct inet_request_sock *ireq = inet_rsk(req);
-
-		ireq->ireq_opt = NULL;
-#if IS_ENABLED(CONFIG_IPV6)
-		ireq->pktopts = NULL;
-#endif
-		atomic64_set(&ireq->ir_cookie, 0);
-		ireq->ireq_state = TCP_NEW_SYN_RECV;
-		write_pnet(&ireq->ireq_net, sock_net(sk_listener));
-		ireq->ireq_family = sk_listener->sk_family;
-		req->timeout = TCP_TIMEOUT_INIT;
-	}
-
-	return req;
-}
-EXPORT_SYMBOL(inet_reqsk_alloc);
-
 /*
  * Return true if a syncookie should be sent
  */
-- 
2.45.2.505.gda0bf45e8d-goog


