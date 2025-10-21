Return-Path: <netdev+bounces-231407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE604BF8F93
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 23:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFEEF561AA2
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 21:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A212BE04F;
	Tue, 21 Oct 2025 21:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UHpMBy8l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A92829B8E6
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 21:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761083071; cv=none; b=oV/Jx6v7JHfg2qqgS2YDee7MBzoeUjaUpoFUO68T5tuKAwb+Y08CK+9+mCoC7W4a0ZKH0prhTc7syJSgOq1TQZsKirqRyYP7y1OLdcpHyM/XQfS1Lyl0X65hqAb9FTqWJeBMlW02YJQJqx3nQgyUYYYx7PZLzJVgs/0+tLfONuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761083071; c=relaxed/simple;
	bh=+QuFC4tdKXJvZJ+jCEcxjXoINSno7eLVZmKwSJ/G7GY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BYXMxgaLH3PyjIO77iFf6I2Q9evxL2MWor+bJN66h9qliApj/9L4IzVYLNnsL3Ek23eFOGv2WSxssi66UrqXzIlSAJL1GID7vy9YHEJhz33bsUDyE27QG7CouvXkWhKVlk+O4q49HBBJtBKxFynKPXhKY0STIBZY4bi8UJfVDP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UHpMBy8l; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32ee62ed6beso10150404a91.2
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 14:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761083069; x=1761687869; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MCyjyd6uIlbxiqEqE0ZosYjQeIiTV9CAJvMk1SJ5m+4=;
        b=UHpMBy8lyRL0Bc/VBSLe5oV1f80QS/yZCAlau4yj7iJGrD4oQoP7zE+ojqQ7VQkuOs
         ReiSlzWXE5YsWtQ/ZJM9Ng5+c1E8mfn6su7wZH0j0K0JUWGGUui7UGJsOgMpHajpJqmp
         v5M8LP3JEE89eslqGzNxyRkp/sM8mkssReTWJYH/+2DTjx1LbV/XX95KCAoMwP1crbiG
         d5PoPsIe+suQz6XCPiQ5PJyStkMphTMr47ppjoiIlbNW/8LauN+1uJQsJPjOYJlE6q3z
         8EMHHJG+3GdRccaU33LP13lfI2bCkvoFrtn9mI9/NKXC6Hjy06aSbTIfsWLnXNhEn5fq
         bkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761083069; x=1761687869;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MCyjyd6uIlbxiqEqE0ZosYjQeIiTV9CAJvMk1SJ5m+4=;
        b=Bc20JjxIukX3DNU/o4rZ/DparbQXLW7FzufIcWkJXJHlxeM0Q0Wj9/VyMpxOA57LcE
         kUV3yIUXVCjQzrkk3dUeQbeCsrVPjh92MbAmsj360aabFFAAHbipU5QOXEJm4G1wzBsm
         kOU0ieCRtqLLAgPgqk6I+dLRlCV1tzmHIRgSgMHDDLN7mf7eeotr6hAJsFGNcNY/ALOg
         1A8k1iYki7waXVobDAbDAZxPvqdJYn7pFTIXpOT6uefsR9BDl5USKKUygc+5oN0Cj36T
         2//EgafTlMn7+CXV92nd5zjyig9ZoxDqqml+o5wYIhT0LyURwponoa8PcYMVx83wtV/G
         nDBQ==
X-Forwarded-Encrypted: i=1; AJvYcCULpMqVgCRhUvU+vNWvpbUoMrvbbkPgW0V1Sdz48F61+A8fVHqTv/RpXUxLz3kpsOEYyaSYWkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwytiVhI2c01+mYsu0dBG7u/l94/6jy+Um4w14oDeth4TDDS+vj
	UN2GPZIaRg4GZg6d7N3q5c9tTqKfBYS3LHsmd+On0vXhhpkK864X7rXCmfklWCFJOZgVMNM0BHG
	w0rTvaw==
X-Google-Smtp-Source: AGHT+IGmoGPxo1ZsYalJsYXa0KVTgcgg6C1fFfLYs7nV5EssuGUu2ZFPMVo1iXm4Twx5cAmTwUxz38DpF2o=
X-Received: from pjbsj14.prod.google.com ([2002:a17:90b:2d8e:b0:33b:cfa0:dd8a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d8f:b0:339:d1f0:c740
 with SMTP id 98e67ed59e1d1-33bcf86c093mr22103680a91.1.1761083069362; Tue, 21
 Oct 2025 14:44:29 -0700 (PDT)
Date: Tue, 21 Oct 2025 21:43:20 +0000
In-Reply-To: <20251021214422.1941691-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251021214422.1941691-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
Message-ID: <20251021214422.1941691-4-kuniyu@google.com>
Subject: [PATCH v1 net-next 3/8] sctp: Don't call sk->sk_prot->init() in sctp_v[46]_create_accept_sk().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

sctp_accept() calls sctp_v[46]_create_accept_sk() to allocate a new
socket and calls sctp_sock_migrate() to copy fields from the parent
socket to the new socket.

sctp_v[46]_create_accept_sk() calls sctp_init_sock() to initialise
sctp_sock, but most fields are overwritten by sctp_copy_descendant()
called from sctp_sock_migrate().

Things done in sctp_init_sock() but not in sctp_sock_migrate() are
the following:

  1. Copy sk->sk_gso
  2. Copy sk->sk_destruct (sctp_v6_init_sock())
  3. Allocate sctp_sock.ep
  4. Initialise sctp_sock.pd_lobby
  5. Count sk_sockets_allocated_inc(), sock_prot_inuse_add(),
     and SCTP_DBG_OBJCNT_INC()

Let's do these in sctp_copy_sock() and sctp_sock_migrate() and avoid
calling sk->sk_prot->init() in sctp_v[46]_create_accept_sk().

Note that sk->sk_destruct is already copied in sctp_copy_sock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/sctp/ipv6.c     |  8 +-------
 net/sctp/protocol.c |  8 +-------
 net/sctp/socket.c   | 27 ++++++++++++++++++++++-----
 3 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index d725b21587588..c0762424a8544 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -789,7 +789,7 @@ static struct sock *sctp_v6_create_accept_sk(struct sock *sk,
 
 	newsk = sk_alloc(sock_net(sk), PF_INET6, GFP_KERNEL, sk->sk_prot, kern);
 	if (!newsk)
-		goto out;
+		return NULL;
 
 	sock_init_data(NULL, newsk);
 
@@ -818,12 +818,6 @@ static struct sock *sctp_v6_create_accept_sk(struct sock *sk,
 
 	newsk->sk_v6_rcv_saddr = sk->sk_v6_rcv_saddr;
 
-	if (newsk->sk_prot->init(newsk)) {
-		sk_common_release(newsk);
-		newsk = NULL;
-	}
-
-out:
 	return newsk;
 }
 
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 9dbc24af749b5..ad2722d1ec150 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -590,7 +590,7 @@ static struct sock *sctp_v4_create_accept_sk(struct sock *sk,
 	struct inet_sock *newinet;
 
 	if (!newsk)
-		goto out;
+		return NULL;
 
 	sock_init_data(NULL, newsk);
 
@@ -603,12 +603,6 @@ static struct sock *sctp_v4_create_accept_sk(struct sock *sk,
 
 	newinet->inet_daddr = asoc->peer.primary_addr.v4.sin_addr.s_addr;
 
-	if (newsk->sk_prot->init(newsk)) {
-		sk_common_release(newsk);
-		newsk = NULL;
-	}
-
-out:
 	return newsk;
 }
 
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 735b1222af955..70c75ac8da55d 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -4851,7 +4851,7 @@ static int sctp_disconnect(struct sock *sk, int flags)
  */
 static struct sock *sctp_accept(struct sock *sk, struct proto_accept_arg *arg)
 {
-	struct sctp_sock *sp;
+	struct sctp_sock *sp, *newsp;
 	struct sctp_endpoint *ep;
 	struct sock *newsk = NULL;
 	struct sctp_association *asoc;
@@ -4891,19 +4891,35 @@ static struct sock *sctp_accept(struct sock *sk, struct proto_accept_arg *arg)
 		goto out;
 	}
 
+	newsp = sctp_sk(newsk);
+	newsp->ep = sctp_endpoint_new(newsk, GFP_KERNEL);
+	if (!newsp->ep) {
+		error = -ENOMEM;
+		goto out_release;
+	}
+
+	skb_queue_head_init(&newsp->pd_lobby);
+
+	sk_sockets_allocated_inc(newsk);
+	sock_prot_inuse_add(sock_net(sk), newsk->sk_prot, 1);
+	SCTP_DBG_OBJCNT_INC(sock);
+
 	/* Populate the fields of the newsk from the oldsk and migrate the
 	 * asoc to the newsk.
 	 */
 	error = sctp_sock_migrate(sk, newsk, asoc, SCTP_SOCKET_TCP);
-	if (error) {
-		sk_common_release(newsk);
-		newsk = NULL;
-	}
+	if (error)
+		goto out_release;
 
 out:
 	release_sock(sk);
 	arg->err = error;
 	return newsk;
+
+out_release:
+	sk_common_release(newsk);
+	newsk = NULL;
+	goto out;
 }
 
 /* The SCTP ioctl handler. */
@@ -9469,6 +9485,7 @@ void sctp_copy_sock(struct sock *newsk, struct sock *sk,
 	newsk->sk_rcvtimeo = READ_ONCE(sk->sk_rcvtimeo);
 	newsk->sk_sndtimeo = READ_ONCE(sk->sk_sndtimeo);
 	newsk->sk_rxhash = sk->sk_rxhash;
+	newsk->sk_gso_type = sk->sk_gso_type;
 
 	newinet = inet_sk(newsk);
 
-- 
2.51.0.915.g61a8936c21-goog


