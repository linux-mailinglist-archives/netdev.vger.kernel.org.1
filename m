Return-Path: <netdev+bounces-262373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BHID87eo2mGQgUAu9opvQ
	(envelope-from <netdev+bounces-262373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 07:38:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB141CEA4D
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 07:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A73E3300D91D
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 06:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFA3312819;
	Sun,  1 Mar 2026 06:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2Wjmniqe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269F320E702
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 06:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772347081; cv=none; b=mfOn8QMylkZg8gf+SJRZCDvGYNfeQaIYjdGsprzZJmOLmkGIoUpSu6P40yDWQASlryMb/Ar6rgJIbH6vXZE6rwdsIACzAFJ6HY4dNN1Lcs2rNwAz3nFZmE0pWGfxA124bQeq05SIicGim6ClRH2kdYIrLa5GomaLrQ69HImOk/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772347081; c=relaxed/simple;
	bh=1TqWtdJ0fZgTw3GfP+Jo4Umt4rKMuKWMCVMdOWbE+Uo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ciKoLVJr+Aq6oOdQACvh6s9KJrnK/Rip0kLqFv+0KRob06vpXujKS4r1gtk9YnqsyH8Rt2bhl1gXyezmDMyBoCt/WjUlXFYZxiIyiB21b1qEE827TKdiQ3diuz2Rq1mM5ssq1vRZHIm2DZPgNdae6m6ypbxl9ca82RdMVVHjBQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2Wjmniqe; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ab4de9580dso218070855ad.3
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 22:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772347079; x=1772951879; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0AirRdgRcZEpGcbg+qfMhsdqvrv4kIVCsLWbYUaEsJQ=;
        b=2WjmniqeMEU/YS6USOJ1srFia2MMnYSYiX3RLWXjVXLSVskPEfDPBRv+DkKp5KORTv
         2QUs/bEZ4gJo1WcdJjUHdtlLTTQxEikHvR+Hy/bZK8eG2Ya6h3iw1dHgC0SeD4IAPjBF
         cSlo4xKleCD7dcURxc4Ce+Os+H/b/FJtbxmjQeEnZHHPucNM+AxgZr7sh7XCk86sNMbt
         xEg4FkXfBgMk7DQkaXEeRA/nh+cmlqJ1QtjE7u/SkeRw3+d4RkqoE15uFdFzON1dKhLH
         C10h0WYFrlrsu6j0+a1AElLmZ2xrwNs6gJzUOrlVOZatD3NMnnqPBSBAFlQE09YzoywH
         knsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772347079; x=1772951879;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0AirRdgRcZEpGcbg+qfMhsdqvrv4kIVCsLWbYUaEsJQ=;
        b=EIY2C3h1h72ja5RA84No+ZlURsobiUUUBfNYO1Jn4YJzEE54QGMtFkMG6v41/34EQt
         qOlrUIYJdRWUg3IGoZbxeQHUFAP3QHkNimILruaOLwCBvUrTSCvPaC7XwN20d7tS7pNR
         HMYq+CfKmecrWI/w/tJna63AEjzp1TgkkUUNES4vUEUZ7Z0BSHsDEkZT96bohE7dAsd3
         F4rddLL++8G4PH4Bh1MvZ+SbuiqFZA01rGGDUhtgCNbU8t8lrr3J1+QPGNdPwkJzdsnx
         9Gq4CfXNJ0l+wBUUJS6VijCeaXNp+TGLNXmIDX57fFA+1s4S8KTsng8WkC4NHQ4tDKCQ
         hp/g==
X-Forwarded-Encrypted: i=1; AJvYcCWrk1wUOmEkzfsEWbiW+E5UezU/JLOYflaZOWi6U0HjaK2RueAuyYJ2wdkF7XBLUTPCjRHvVZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+/ZcXsa+Kd0LhGyEpSLysO3yPIF9WXSyfsf0cjS4M6dgId6Yp
	G2it7gaCvkBjKDUGjkEhJrRI4nsj/55pLdK7q7jXsXrivEiJkHxJf2w2P7+VWeZMNMabLd6Or8F
	5TlFHDA==
X-Received: from plge5.prod.google.com ([2002:a17:902:cf45:b0:2ad:d57f:64f4])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22c3:b0:2ad:da86:f6a6
 with SMTP id d9443c01a7336-2ae2e4bc5c3mr80699665ad.49.1772347079263; Sat, 28
 Feb 2026 22:37:59 -0800 (PST)
Date: Sun,  1 Mar 2026 06:37:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260301063756.1581685-1-kuniyu@google.com>
Subject: [PATCH v1 net-next] dccp Remove inet_hashinfo2_init_mod().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262373-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9DB141CEA4D
X-Rspamd-Action: no action

Commit c92c81df93df ("net: dccp: fix kernel crash on module load")
added inet_hashinfo2_init_mod() for DCCP.

Commit 22d6c9eebf2e ("net: Unexport shared functions for DCCP.")
removed EXPORT_SYMBOL_GPL() it but forgot to remove the function
itself.

Let's remove inet_hashinfo2_init_mod().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/inet_hashtables.h |  1 -
 net/ipv4/inet_hashtables.c    | 34 ++++++++--------------------------
 2 files changed, 8 insertions(+), 27 deletions(-)

diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index ac05a52d9e13..8bddf58b1a85 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -286,7 +286,6 @@ void inet_hashinfo2_init(struct inet_hashinfo *h, const char *name,
 			 unsigned long numentries, int scale,
 			 unsigned long low_limit,
 			 unsigned long high_limit);
-int inet_hashinfo2_init_mod(struct inet_hashinfo *h);
 
 bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk);
 bool inet_ehash_nolisten(struct sock *sk, struct sock *osk,
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index fca980772c81..52847950b28a 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -1246,22 +1246,13 @@ int inet_hash_connect(struct inet_timewait_death_row *death_row,
 				   __inet_check_established);
 }
 
-static void init_hashinfo_lhash2(struct inet_hashinfo *h)
-{
-	int i;
-
-	for (i = 0; i <= h->lhash2_mask; i++) {
-		spin_lock_init(&h->lhash2[i].lock);
-		INIT_HLIST_NULLS_HEAD(&h->lhash2[i].nulls_head,
-				      i + LISTENING_NULLS_BASE);
-	}
-}
-
 void __init inet_hashinfo2_init(struct inet_hashinfo *h, const char *name,
 				unsigned long numentries, int scale,
 				unsigned long low_limit,
 				unsigned long high_limit)
 {
+	unsigned int i;
+
 	h->lhash2 = alloc_large_system_hash(name,
 					    sizeof(*h->lhash2),
 					    numentries,
@@ -1271,7 +1262,12 @@ void __init inet_hashinfo2_init(struct inet_hashinfo *h, const char *name,
 					    &h->lhash2_mask,
 					    low_limit,
 					    high_limit);
-	init_hashinfo_lhash2(h);
+
+	for (i = 0; i <= h->lhash2_mask; i++) {
+		spin_lock_init(&h->lhash2[i].lock);
+		INIT_HLIST_NULLS_HEAD(&h->lhash2[i].nulls_head,
+				      i + LISTENING_NULLS_BASE);
+	}
 
 	/* this one is used for source ports of outgoing connections */
 	table_perturb = alloc_large_system_hash("Table-perturb",
@@ -1282,20 +1278,6 @@ void __init inet_hashinfo2_init(struct inet_hashinfo *h, const char *name,
 						INET_TABLE_PERTURB_SIZE);
 }
 
-int inet_hashinfo2_init_mod(struct inet_hashinfo *h)
-{
-	h->lhash2 = kmalloc_objs(*h->lhash2, INET_LHTABLE_SIZE);
-	if (!h->lhash2)
-		return -ENOMEM;
-
-	h->lhash2_mask = INET_LHTABLE_SIZE - 1;
-	/* INET_LHTABLE_SIZE must be a power of 2 */
-	BUG_ON(INET_LHTABLE_SIZE & h->lhash2_mask);
-
-	init_hashinfo_lhash2(h);
-	return 0;
-}
-
 int inet_ehash_locks_alloc(struct inet_hashinfo *hashinfo)
 {
 	unsigned int locksz = sizeof(spinlock_t);
-- 
2.53.0.473.g4a7958ca14-goog


