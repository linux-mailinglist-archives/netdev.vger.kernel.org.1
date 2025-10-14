Return-Path: <netdev+bounces-229256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45063BD9E31
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 16:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750EC188D925
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 14:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E9E314A8F;
	Tue, 14 Oct 2025 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u3Q9XE7E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E2523CF12
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450770; cv=none; b=j4n1xLP9sQDmP4Xwt8k7OUzyuHnSVQJTNLkSHd/HCZbxDnTdhnlqHQxAmyh+qe8F8lOa78QU80fqduFdJPKMIL9k8TJkpbVxKYMXaSbRbXYn9FTqZ3RAHB7k98sAUP3THOOr7rJyN6OO5Oxe8YXtyYTAe4FslsM6pdYiL2AS6Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450770; c=relaxed/simple;
	bh=jhannrCm8CWJqz/tOI+AykLTPiPDGW6YO2bj3rwLjaA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CPB3dkmIVGQllh+xI/n4pj6hHBv3tQhPLh9nmECURn43POLa/Ha3798AefhU9cNFCsYAnIv8syiuDrZoxh/946wZTPVj6fZe5VAiY07DLrtjg4J40sC2DjKiw55LDn92to0H1yiqMVtcaErmULv9AHxkzFLpYRj00OCP2LgICic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u3Q9XE7E; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8635d47553dso2195421985a.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 07:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760450768; x=1761055568; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iwTyqm/sWCOtZoRMpHHi+4z0gvyQdk6zxy+CdY4PJig=;
        b=u3Q9XE7Ed/Z3/ep7pesZyglxSf64QZFRpoF5QjMkDalnmps+Zl95OnL//qan38EMl9
         JDGsN4DY2ar7MMd3VK/71v0E7AuXwVwgTHddPsGKz/z3X9X4/yCAUrSPJaIOoT09iSpH
         H6vEOQCztbfrKdS8v2AByr2ILBixGEj1eG3hXsrBVq/8h+OY7qKv2c0qXi0CDW4Hmhi7
         RetBvOm3s9GPNavKcNuhUTtEzufShrY99a47P+k2N31FZ05xYheqtGhqGVW6rnrZXhpS
         heAQO7tKyk8vbaB9xsz3EJ9m0draWzaRxrVpHuF3hrPXXAxYzez0s0MidsYm4JVQdRK8
         n54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760450768; x=1761055568;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iwTyqm/sWCOtZoRMpHHi+4z0gvyQdk6zxy+CdY4PJig=;
        b=C+5H/FyoQFAM9xu9Q6ecwxzC5te4C0tlv8dD5gfgh/S0LyKP+gGtbrrcnNk9n/K/Qk
         dpeUotsXGPh718/of8OQQigIi0FTaIZWb5KJoB+BLJJ1ZHUJIqmQbNWz7dRFzaTyVp9t
         H8bY8TnvDTuxHwZm8xneL1mUAhBpFToe/ekc/e6YNo4AhakPe/0Y0mgD7bbAKbYUZ6yp
         cEVjUjuOm2e8yyla2qhgIay8TZgF2phuCDjGqILMSjQkoDtSwmRwsrZFd4mTZjh/aZJI
         07fUY4bMvg3h4u4DO4ad1oHL6eEzILKBQGllvotgFTwa944Tt91+ZOQOjHu1ua2v/afK
         8LKA==
X-Forwarded-Encrypted: i=1; AJvYcCU4iuxXKeXshTkkxEfGfo3Melz2C/3uJm1Rm2s62EM2FSaNiVUvL5GdPvx4OWr/z+Sb7uPoJSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwb/AjilJA4aneeW1M3EE7SVCPtOy2HKsAK9QX8XrH+21o8IYc
	18zM43TKJp+oqDBD+WZpZk5Gas+WSW53I7j1sssDa8v8bqBpsE68f6rzD20J5jvBvOBpsZG+Q0H
	NW+4lDA23oCVaNg==
X-Google-Smtp-Source: AGHT+IHl/efKOW7OOAcv9y4p5cSOHVqCh0xiiMmf67mP8Oj+qkTlEDWdG+Hl7EnRxqidCtzddoHnEslZIeQFFw==
X-Received: from qklq22.prod.google.com ([2002:a05:620a:d96:b0:887:8dc6:8e3f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:199a:b0:855:cfe0:b6eb with SMTP id af79cd13be357-88352d9628fmr3572103185a.75.1760450767488;
 Tue, 14 Oct 2025 07:06:07 -0700 (PDT)
Date: Tue, 14 Oct 2025 14:06:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251014140605.2982703-1-edumazet@google.com>
Subject: [PATCH net-next] net: remove obsolete WARN_ON(refcount_read(&sk->sk_refcnt)
 == 1)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Xuanqiang Luo <luoxuanqiang@kylinos.cn>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"

sk->sk_refcnt has been converted to refcount_t in 2017.

__sock_put(sk) being refcount_dec(&sk->sk_refcnt), it will complain
loudly if the current refcnt is 1 (or less) in a non racy way.

We can remove four WARN_ON() in favor of the generic refcount_dec()
check.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/sock.h       | 12 ++++--------
 net/netlink/af_netlink.c |  4 +---
 net/tipc/socket.c        |  4 +---
 3 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 60bcb13f045c..596302bffedf 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -828,11 +828,9 @@ static inline bool sk_del_node_init(struct sock *sk)
 {
 	bool rc = __sk_del_node_init(sk);
 
-	if (rc) {
-		/* paranoid for a while -acme */
-		WARN_ON(refcount_read(&sk->sk_refcnt) == 1);
+	if (rc)
 		__sock_put(sk);
-	}
+
 	return rc;
 }
 #define sk_del_node_init_rcu(sk)	sk_del_node_init(sk)
@@ -850,11 +848,9 @@ static inline bool sk_nulls_del_node_init_rcu(struct sock *sk)
 {
 	bool rc = __sk_nulls_del_node_init_rcu(sk);
 
-	if (rc) {
-		/* paranoid for a while -acme */
-		WARN_ON(refcount_read(&sk->sk_refcnt) == 1);
+	if (rc)
 		__sock_put(sk);
-	}
+
 	return rc;
 }
 
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 2b46c0cd752a..687a84c48882 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -596,10 +596,8 @@ static void netlink_remove(struct sock *sk)
 
 	table = &nl_table[sk->sk_protocol];
 	if (!rhashtable_remove_fast(&table->hash, &nlk_sk(sk)->node,
-				    netlink_rhashtable_params)) {
-		WARN_ON(refcount_read(&sk->sk_refcnt) == 1);
+				    netlink_rhashtable_params))
 		__sock_put(sk);
-	}
 
 	netlink_table_grab();
 	if (nlk_sk(sk)->subscriptions) {
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 1574a83384f8..bc614a1f019c 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -3031,10 +3031,8 @@ static void tipc_sk_remove(struct tipc_sock *tsk)
 	struct sock *sk = &tsk->sk;
 	struct tipc_net *tn = net_generic(sock_net(sk), tipc_net_id);
 
-	if (!rhashtable_remove_fast(&tn->sk_rht, &tsk->node, tsk_rht_params)) {
-		WARN_ON(refcount_read(&sk->sk_refcnt) == 1);
+	if (!rhashtable_remove_fast(&tn->sk_rht, &tsk->node, tsk_rht_params))
 		__sock_put(sk);
-	}
 }
 
 static const struct rhashtable_params tsk_rht_params = {
-- 
2.51.0.788.g6d19910ace-goog


