Return-Path: <netdev+bounces-57632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F353B813AC2
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 20:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BD291C20C2A
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 19:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948E86A01A;
	Thu, 14 Dec 2023 19:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LQ4MNGHh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812066A011
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 19:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-db4004a8aa9so8846072276.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 11:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702582183; x=1703186983; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3uYFT4xSOByVORG/Hz/4E8k1uuLRLJt+VLsAUmJri2Q=;
        b=LQ4MNGHhGSFH3gAjoBThKDP4TzuYN3aNrtVRQezxT6vVxtDy2CyBlignKy2z9kePlq
         nG8tJnP/SSiHM6ysAOC9gyHNbjMFn/dcmtOAjDk0O0Dy6fD6ZK8YKVGfRFu8Iz1QmNNQ
         zGEbcoOVYdWtQ8feREkm2iMyVUo6wT6VpY0yce2v0OVYSfB5EB9bLpqEUSVZ7+IcV09b
         qxMTHNHjFe7rKuOXcOikWBcKzGecffWwPUPDA6be+v2uNxY4y28O5I0lD+XYLfp2bbsR
         LDb1uUTOVTwjTnH/2lorAz3e1PPt+yaSRUuX8lrDZNeLHgfr5o4E/YPMHtkDRjopn/+P
         FXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702582183; x=1703186983;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3uYFT4xSOByVORG/Hz/4E8k1uuLRLJt+VLsAUmJri2Q=;
        b=JF06w9JGdAXVQWkqT/1el9CNi/tRT42cTHP5lqXJToguE21T9kO3BqDjR5vmjUeIOa
         j8EhkKflJh23H2YIbhfzhDaoZq1pP04GaPpRaAf/K7YFfFSS0EQPTdDPJc3EHh9mpnBp
         IqAwU0eQOO+nZhG9q2J4yugKnAZEKobynF8yaFZ4Lynv8Cz8rLBgB6DrUCWnmollpMOb
         BTUPDgTlgHyYp6Qrb1Sa5WQQV5iP4ADIfW/oWuakQAETD5N7b3quwg2dgZzIFFkAz4k2
         g66tuGadSlwkhuXzjloI3MF2L5B94WYX9uB91kVrF79tUywtI2OA40HVErk0lslfFtLZ
         w1jw==
X-Gm-Message-State: AOJu0Yzb+WN5qGIKDakL7cwYV98N/CtDjIvgru8pbh0uSmuyI9tFZFBb
	d1wnGEX4d9j/zwsgvTNHRAUIUpdwy0KMHg==
X-Google-Smtp-Source: AGHT+IG1uHwl0S/hjQNqh2Cz0bAUMJ6m9Jh9QGp2ynMiir63sH4vONPaMepj1h0JU7iJcubQQAQOMQ5CtUiIKA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a5b:787:0:b0:d9a:efcc:42af with SMTP id
 b7-20020a5b0787000000b00d9aefcc42afmr124942ybq.2.1702582183308; Thu, 14 Dec
 2023 11:29:43 -0800 (PST)
Date: Thu, 14 Dec 2023 19:29:38 +0000
In-Reply-To: <20231214192939.1962891-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231214192939.1962891-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214192939.1962891-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] inet: returns a bool from inet_sk_get_local_port_range()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Change inet_sk_get_local_port_range() to return a boolean,
telling the callers if the port range was provided by
IP_LOCAL_PORT_RANGE socket option.

Adds documentation while we are at it.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ip.h                |  2 +-
 net/ipv4/inet_connection_sock.c | 21 ++++++++++++++++-----
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index b31be912489af8b01cc0393a27ffc80b086feaa0..de0c69c57e3cb7485e3d8473bc0b109e4280d2f6 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -356,7 +356,7 @@ static inline void inet_get_local_port_range(const struct net *net, int *low, in
 	*low = range & 0xffff;
 	*high = range >> 16;
 }
-void inet_sk_get_local_port_range(const struct sock *sk, int *low, int *high);
+bool inet_sk_get_local_port_range(const struct sock *sk, int *low, int *high);
 
 #ifdef CONFIG_SYSCTL
 static inline bool inet_is_local_reserved_port(struct net *net, unsigned short port)
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 70be0f6fe879ea671bf6686b04edf32bf5e0d4b6..bd325b029dd12c9fad754ded266ae232ee7ec260 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -117,16 +117,25 @@ bool inet_rcv_saddr_any(const struct sock *sk)
 	return !sk->sk_rcv_saddr;
 }
 
-void inet_sk_get_local_port_range(const struct sock *sk, int *low, int *high)
+/**
+ *	inet_sk_get_local_port_range - fetch ephemeral ports range
+ *	@sk: socket
+ *	@low: pointer to low port
+ *	@high: pointer to high port
+ *
+ *	Fetch netns port range (/proc/sys/net/ipv4/ip_local_port_range)
+ *	Range can be overridden if socket got IP_LOCAL_PORT_RANGE option.
+ *	Returns true if IP_LOCAL_PORT_RANGE was set on this socket.
+ */
+bool inet_sk_get_local_port_range(const struct sock *sk, int *low, int *high)
 {
-	const struct inet_sock *inet = inet_sk(sk);
-	const struct net *net = sock_net(sk);
 	int lo, hi, sk_lo, sk_hi;
+	bool local_range = false;
 	u32 sk_range;
 
-	inet_get_local_port_range(net, &lo, &hi);
+	inet_get_local_port_range(sock_net(sk), &lo, &hi);
 
-	sk_range = READ_ONCE(inet->local_port_range);
+	sk_range = READ_ONCE(inet_sk(sk)->local_port_range);
 	if (unlikely(sk_range)) {
 		sk_lo = sk_range & 0xffff;
 		sk_hi = sk_range >> 16;
@@ -135,10 +144,12 @@ void inet_sk_get_local_port_range(const struct sock *sk, int *low, int *high)
 			lo = sk_lo;
 		if (lo <= sk_hi && sk_hi <= hi)
 			hi = sk_hi;
+		local_range = true;
 	}
 
 	*low = lo;
 	*high = hi;
+	return local_range;
 }
 EXPORT_SYMBOL(inet_sk_get_local_port_range);
 
-- 
2.43.0.472.g3155946c3a-goog


