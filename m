Return-Path: <netdev+bounces-224695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF89B8870D
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 10:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4617358643D
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 08:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE21306B34;
	Fri, 19 Sep 2025 08:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sBXTbX8X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826BE306482
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 08:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758271034; cv=none; b=Mmncj+G801J6Ggnj/PCB5eMMG3i+WbNkQiGcYhlTyaqO7a1ZwciBn1MQ8k14PuFUC4viwUs+RBQgfD0QdU5CSl5wR2IJHpO7bjZDoP23RlenlzgWlrEOQUFHoBYHwbfMLprTz/BYTevlNtgGDhvRna8zQjYyprAyh/JSC+eFp6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758271034; c=relaxed/simple;
	bh=ypSEPonB5zSCpPCgFuAKeAtBP9EK3eylKwdSma9FPo8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=leaW6pv231/xeKAR8VP3h0twRUqgGmYAN5x3xo5nQOHNndefbSvVgbA1jHQ0UKD4DoaWWXzWV4qz7mFThWLBEr86bqFRAgOuWHcbNFqpO8DKQWfUsnZp/gRpUP0z1lcp5Ss1/U6gMetmN9+zLwaGGtEB1n2rFj+W8iaIc1COTC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sBXTbX8X; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2641084fb5aso20951695ad.0
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 01:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758271032; x=1758875832; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OWQGL9QL71AcSyKbCraNfQQM14iR13PZQ/z+vcMbNvE=;
        b=sBXTbX8Xulg7DsDH5s5WYYXLhkCwVcFq/9dbM8qCyYFF5we8FTgXtQ6C0nY7kibTj1
         7Ub3MmrKKzb/zVdcxiBodn/RR3YJeFdXmRFxXJ687N80DJGw3I9tL4/PsaMIjlo9JaVt
         ZIEGk3JuOHLUB7/klgNvudWRreMtxMGcuKetOA0Z08M6t34VlwS1+iRIkHLvsLR73fDF
         xrVeStma2A7tIFnRorpnx98QFrFBlifaXW0sc8NWvwBmRSwcJYyuzAWLforUv6G5UbpX
         HQE2N0a7hz/7PKkqV0CcdhgJ1stSR23ZhaGM7lPdSR8Iv5qqWVEXYm0M2bTAz3MIadnQ
         17rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758271032; x=1758875832;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OWQGL9QL71AcSyKbCraNfQQM14iR13PZQ/z+vcMbNvE=;
        b=ViCXGMhACH//51I0yY/0MRcxFsV+jxx0wIuyXH8NgsQqMrBQMPQD7CXxTXUYNNm04k
         zfwgNe5dQI4Mq6U1E2Mh7h5SHULBQ5YZlCCuF8wKm099WD16GOS9ZCQ6mG22blAkcSHv
         KB193B8azQ4uA+yAAG753z+Msx4ksIyJcDN9f/d/3eEPo2vWoeYiATYi6An/lysmrfHo
         hwg4jQksk2/JGaolEhOpGbUK6r6etDnweDvPrAmX7igBFFPX9KIKWeI3JWCsb165NGiS
         RWfozu2/+905h/Ig0FR5ct0SzJqtXNWpgvDiIRDRbyC8F1yg0pJKMq62LQcvAGScMjpY
         bQxw==
X-Forwarded-Encrypted: i=1; AJvYcCU6bRJ0waWgVwR+weapV6QGVYs4jTCyrZ8KlVzpq42prC5qaCCxCB1mppHdkTuaoIkKH+sr0yM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxckU121h90nwDddz0Myq4axreTXXWAqAIKSVT5fqapKGiNdYuC
	zYjx+Cla9Zh97RpKkWx9aLtrDf7VAHdJSM/DqPzM0Tmyy//F7M9XVQP2eC/r5rCF8DcVJ79aT7i
	lR1Cyrw==
X-Google-Smtp-Source: AGHT+IEukvGF5RbSy4+xberw2/xHxAZjNi+KrbfnvrinwT/qM7S2KAkZwTj4aIgqeSRZh3dxm1re0V8Zhqw=
X-Received: from pjbqx3.prod.google.com ([2002:a17:90b:3e43:b0:330:793a:2e77])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e53:b0:32e:24cf:e658
 with SMTP id 98e67ed59e1d1-33097fd8aefmr3093989a91.3.1758271031829; Fri, 19
 Sep 2025 01:37:11 -0700 (PDT)
Date: Fri, 19 Sep 2025 08:35:29 +0000
In-Reply-To: <20250919083706.1863217-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919083706.1863217-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919083706.1863217-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 2/3] tcp: Remove inet6_hash().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Xuanqiang Luo <xuanqiang.luo@linux.dev>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

inet_hash() and inet6_hash() are exactly the same.

Also, we do not need to export inet6_hash().

Let's consolidate the two into __inet_hash() and rename it to inet_hash().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/inet6_hashtables.h |  2 --
 include/net/inet_hashtables.h  |  1 -
 net/ipv4/inet_hashtables.c     | 17 +++++------------
 net/ipv6/inet6_hashtables.c    | 11 -----------
 net/ipv6/tcp_ipv6.c            |  2 +-
 5 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index 1f985d2012ce..282e29237d93 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -167,8 +167,6 @@ struct sock *inet6_lookup(const struct net *net, struct sk_buff *skb, int doff,
 			  const struct in6_addr *daddr, const __be16 dport,
 			  const int dif);
 
-int inet6_hash(struct sock *sk);
-
 static inline bool inet6_match(const struct net *net, const struct sock *sk,
 			       const struct in6_addr *saddr,
 			       const struct in6_addr *daddr,
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 64bc8870db88..b787be651ce7 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -289,7 +289,6 @@ int inet_hashinfo2_init_mod(struct inet_hashinfo *h);
 bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk);
 bool inet_ehash_nolisten(struct sock *sk, struct sock *osk,
 			 bool *found_dup_sk);
-int __inet_hash(struct sock *sk);
 int inet_hash(struct sock *sk);
 void inet_unhash(struct sock *sk);
 
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index baee5c075e6c..efa8a615b868 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -739,12 +739,15 @@ static int inet_reuseport_add_sock(struct sock *sk,
 	return reuseport_alloc(sk, inet_rcv_saddr_any(sk));
 }
 
-int __inet_hash(struct sock *sk)
+int inet_hash(struct sock *sk)
 {
 	struct inet_hashinfo *hashinfo = tcp_get_hashinfo(sk);
 	struct inet_listen_hashbucket *ilb2;
 	int err = 0;
 
+	if (sk->sk_state == TCP_CLOSE)
+		return 0;
+
 	if (sk->sk_state != TCP_LISTEN) {
 		local_bh_disable();
 		inet_ehash_nolisten(sk, NULL, NULL);
@@ -772,17 +775,7 @@ int __inet_hash(struct sock *sk)
 
 	return err;
 }
-EXPORT_IPV6_MOD(__inet_hash);
-
-int inet_hash(struct sock *sk)
-{
-	int err = 0;
-
-	if (sk->sk_state != TCP_CLOSE)
-		err = __inet_hash(sk);
-
-	return err;
-}
+EXPORT_IPV6_MOD(inet_hash);
 
 void inet_unhash(struct sock *sk)
 {
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 64fcd7df0c9a..5e1da088d8e1 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -368,14 +368,3 @@ int inet6_hash_connect(struct inet_timewait_death_row *death_row,
 				   __inet6_check_established);
 }
 EXPORT_SYMBOL_GPL(inet6_hash_connect);
-
-int inet6_hash(struct sock *sk)
-{
-	int err = 0;
-
-	if (sk->sk_state != TCP_CLOSE)
-		err = __inet_hash(sk);
-
-	return err;
-}
-EXPORT_SYMBOL_GPL(inet6_hash);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index d1e5b2a186fb..9622c2776ade 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2355,7 +2355,7 @@ struct proto tcpv6_prot = {
 	.splice_eof		= tcp_splice_eof,
 	.backlog_rcv		= tcp_v6_do_rcv,
 	.release_cb		= tcp_release_cb,
-	.hash			= inet6_hash,
+	.hash			= inet_hash,
 	.unhash			= inet_unhash,
 	.get_port		= inet_csk_get_port,
 	.put_port		= inet_put_port,
-- 
2.51.0.470.ga7dc726c21-goog


