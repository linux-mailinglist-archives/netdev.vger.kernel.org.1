Return-Path: <netdev+bounces-31590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C4C78EF00
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 15:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713032815CD
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 13:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E3E1173A;
	Thu, 31 Aug 2023 13:52:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A7E11C9F
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 13:52:22 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A825D1A4
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 06:52:20 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7bb58517b8so654592276.0
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 06:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693489940; x=1694094740; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1PHGxH0OxeTSiGtdezGeS5C2R6b02svgID+/ONc3Uvw=;
        b=ar7m4SA7n5bGkZmiT26BPvMpfv3kYpUi0pqTsiV22rjct3x1ZxZZdHnj0j7dgayCp6
         rE4DEp2uLLsRIsBZFkVw9eKIUwIhFz3Nzkrq1zZOQ3mXCMXRKwkupL015PjO3VTMA6kU
         9EnDFF4fYoFABVVWgZ/Xt/zwreFuQmb1CjieQwTZEKTNRLkFlBLQygSdzxg1isJNV7js
         77gLSc9LNf3r48DFRHqTu26pQM9jb62o9UGNxRWC077HBnnoMGMfJigEfLiDsOrdP5W9
         zaXsLIudmRi8aNXK+OZSpNykEgfVhGe4V8JaFo5azJJa2VKYqUzFTY0H2wnQfjXu+iBz
         C7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693489940; x=1694094740;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1PHGxH0OxeTSiGtdezGeS5C2R6b02svgID+/ONc3Uvw=;
        b=WM7F2CYSPv02sqx6NjwgMqMCYrwvEbPdvNIaA4HWsYJ1Q9F+idWk1HJLVtzlAwY+pX
         hsLA/Sqrlygeja8Cg55OupwaN7SOK2uqjvvf2XtIFoeVsbxlMahfbKoR5MpvOZpSanRU
         qKtksS+iXiC0PCH+jd3/qn3VSTrU2e4dK6pE+XPE19VUJTPDyhUcMrB7ByYrzQaXewYH
         wKF8boPIdSHAN9Ghfn7baC0JtvaKXGmknx7PSFpmda0Ly372Hm3v2ARSOzB4JIg9awwk
         Eo72NZKPyT8PiI5xVwJ6tDTUQasNCv+A92Q7wUnsEpB85pXA3QecGyzKzdCe8MzdHAi9
         wPUw==
X-Gm-Message-State: AOJu0YxU37AIfAqNqW+kRYd+CN5VyRaBxcG0/JP0fpg9iZfhJzi/ybSw
	PgAzmxCuDwkyW0AugOy2pp1MCcaULKgLVA==
X-Google-Smtp-Source: AGHT+IGxwXAvRPQbRtDmzmBWvUCF6MJegXbBHECR7cP21l//JbFcmFKfopNNPRz/yhr0wCHAbLc1HP3Th36dkA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:180b:b0:d7b:3917:4606 with SMTP
 id cf11-20020a056902180b00b00d7b39174606mr155142ybb.11.1693489939996; Thu, 31
 Aug 2023 06:52:19 -0700 (PDT)
Date: Thu, 31 Aug 2023 13:52:09 +0000
In-Reply-To: <20230831135212.2615985-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230831135212.2615985-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230831135212.2615985-3-edumazet@google.com>
Subject: [PATCH net 2/5] net: annotate data-races around sk->sk_forward_alloc
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Every time sk->sk_forward_alloc is read locklessly,
add a READ_ONCE().

Add sk_forward_alloc_add() helper to centralize updates,
to reduce number of WRITE_ONCE().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h    | 12 +++++++++---
 net/core/sock.c       |  8 ++++----
 net/ipv4/tcp_output.c |  2 +-
 net/ipv4/udp.c        |  6 +++---
 net/mptcp/protocol.c  |  6 +++---
 5 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 11d503417591ed758fe2b2acbf7d3a9d0f07b660..f04869ac1d92283bc3e4ecea2909babfc5096003 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1053,6 +1053,12 @@ static inline void sk_wmem_queued_add(struct sock *sk, int val)
 	WRITE_ONCE(sk->sk_wmem_queued, sk->sk_wmem_queued + val);
 }
 
+static inline void sk_forward_alloc_add(struct sock *sk, int val)
+{
+	/* Paired with lockless reads of sk->sk_forward_alloc */
+	WRITE_ONCE(sk->sk_forward_alloc, sk->sk_forward_alloc + val);
+}
+
 void sk_stream_write_space(struct sock *sk);
 
 /* OOB backlog add */
@@ -1377,7 +1383,7 @@ static inline int sk_forward_alloc_get(const struct sock *sk)
 	if (sk->sk_prot->forward_alloc_get)
 		return sk->sk_prot->forward_alloc_get(sk);
 #endif
-	return sk->sk_forward_alloc;
+	return READ_ONCE(sk->sk_forward_alloc);
 }
 
 static inline bool __sk_stream_memory_free(const struct sock *sk, int wake)
@@ -1673,14 +1679,14 @@ static inline void sk_mem_charge(struct sock *sk, int size)
 {
 	if (!sk_has_account(sk))
 		return;
-	sk->sk_forward_alloc -= size;
+	sk_forward_alloc_add(sk, -size);
 }
 
 static inline void sk_mem_uncharge(struct sock *sk, int size)
 {
 	if (!sk_has_account(sk))
 		return;
-	sk->sk_forward_alloc += size;
+	sk_forward_alloc_add(sk, size);
 	sk_mem_reclaim(sk);
 }
 
diff --git a/net/core/sock.c b/net/core/sock.c
index a61ec97098add711e0e5bc587733b0579aab77b7..40e1bda4bde0cd0ddbb0315deb4df45d60f65081 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1045,7 +1045,7 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 		mem_cgroup_uncharge_skmem(sk->sk_memcg, pages);
 		return -ENOMEM;
 	}
-	sk->sk_forward_alloc += pages << PAGE_SHIFT;
+	sk_forward_alloc_add(sk, pages << PAGE_SHIFT);
 
 	WRITE_ONCE(sk->sk_reserved_mem,
 		   sk->sk_reserved_mem + (pages << PAGE_SHIFT));
@@ -3139,10 +3139,10 @@ int __sk_mem_schedule(struct sock *sk, int size, int kind)
 {
 	int ret, amt = sk_mem_pages(size);
 
-	sk->sk_forward_alloc += amt << PAGE_SHIFT;
+	sk_forward_alloc_add(sk, amt << PAGE_SHIFT);
 	ret = __sk_mem_raise_allocated(sk, size, amt, kind);
 	if (!ret)
-		sk->sk_forward_alloc -= amt << PAGE_SHIFT;
+		sk_forward_alloc_add(sk, -(amt << PAGE_SHIFT));
 	return ret;
 }
 EXPORT_SYMBOL(__sk_mem_schedule);
@@ -3174,7 +3174,7 @@ void __sk_mem_reduce_allocated(struct sock *sk, int amount)
 void __sk_mem_reclaim(struct sock *sk, int amount)
 {
 	amount >>= PAGE_SHIFT;
-	sk->sk_forward_alloc -= amount << PAGE_SHIFT;
+	sk_forward_alloc_add(sk, -(amount << PAGE_SHIFT));
 	__sk_mem_reduce_allocated(sk, amount);
 }
 EXPORT_SYMBOL(__sk_mem_reclaim);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index e6b4fbd642f7e4e3c986fef54e416628c8981aff..ccfc8bbf745586cd23dcf02d755d6981dc92742e 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3474,7 +3474,7 @@ void sk_forced_mem_schedule(struct sock *sk, int size)
 	if (delta <= 0)
 		return;
 	amt = sk_mem_pages(delta);
-	sk->sk_forward_alloc += amt << PAGE_SHIFT;
+	sk_forward_alloc_add(sk, amt << PAGE_SHIFT);
 	sk_memory_allocated_add(sk, amt);
 
 	if (mem_cgroup_sockets_enabled && sk->sk_memcg)
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 0794a2c46a568d644cc488c1d7f6ee676180a5bd..f39b9c8445808deee2c777cbb828474ff105d322 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1414,9 +1414,9 @@ static void udp_rmem_release(struct sock *sk, int size, int partial,
 		spin_lock(&sk_queue->lock);
 
 
-	sk->sk_forward_alloc += size;
+	sk_forward_alloc_add(sk, size);
 	amt = (sk->sk_forward_alloc - partial) & ~(PAGE_SIZE - 1);
-	sk->sk_forward_alloc -= amt;
+	sk_forward_alloc_add(sk, -amt);
 
 	if (amt)
 		__sk_mem_reduce_allocated(sk, amt >> PAGE_SHIFT);
@@ -1527,7 +1527,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 		goto uncharge_drop;
 	}
 
-	sk->sk_forward_alloc -= size;
+	sk_forward_alloc_add(sk, -size);
 
 	/* no need to setup a destructor, we will explicitly release the
 	 * forward allocated memory on dequeue
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 933b257eee0242d9864ca9202cea69f2592663be..625df3a36c469d9b8e71a2f0463a1ca5ead2049d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1800,7 +1800,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		}
 
 		/* data successfully copied into the write queue */
-		sk->sk_forward_alloc -= total_ts;
+		sk_forward_alloc_add(sk, -total_ts);
 		copied += psize;
 		dfrag->data_len += psize;
 		frag_truesize += psize;
@@ -3257,7 +3257,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 	/* move all the rx fwd alloc into the sk_mem_reclaim_final in
 	 * inet_sock_destruct() will dispose it
 	 */
-	sk->sk_forward_alloc += msk->rmem_fwd_alloc;
+	sk_forward_alloc_add(sk, msk->rmem_fwd_alloc);
 	msk->rmem_fwd_alloc = 0;
 	mptcp_token_destroy(msk);
 	mptcp_pm_free_anno_list(msk);
@@ -3522,7 +3522,7 @@ static void mptcp_shutdown(struct sock *sk, int how)
 
 static int mptcp_forward_alloc_get(const struct sock *sk)
 {
-	return sk->sk_forward_alloc + mptcp_sk(sk)->rmem_fwd_alloc;
+	return READ_ONCE(sk->sk_forward_alloc) + mptcp_sk(sk)->rmem_fwd_alloc;
 }
 
 static int mptcp_ioctl_outq(const struct mptcp_sock *msk, u64 v)
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog


