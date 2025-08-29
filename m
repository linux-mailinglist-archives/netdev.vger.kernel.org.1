Return-Path: <netdev+bounces-218324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92626B3BF3B
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 17:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB02A056D0
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 15:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50442322C7A;
	Fri, 29 Aug 2025 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vqT9hs0B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC2A3218A1
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756481464; cv=none; b=fzRnPJFNz1IcHUUfsNbIxmYHhurm2KGM4yM19FiyhvaPlspD5Zksz8gK0lH+S344rjgZFQSW/MZDiGiCceTc9G7u7LJCXnu8S0pWXzv2ogrmm1icslWV33+b9dq+6Cki9b0dSbVNZTwi/RKYmsHCWOjgCLweACDPkUrvp7suiRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756481464; c=relaxed/simple;
	bh=4n6LkmO+jclHMePIII5eq+Xr8tu394jP7nMu7+fMh7Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MGnozPo6F/VVUGH2B0Fj3c7RNsKv5zdtvLp2SRSBlaDuJt6LhjfJXts8WEHIkSH4O6V8/qzBH0nkNTz5Sy1Hgv6Ar3C97yowDaSMwzv0HHBnxkwopEYV5kocSVVxnBcMomuoPSo+uSg9K1iRBsM37jA1kaGKJ5ZQA9kjyyGFwGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vqT9hs0B; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4b109be41a1so83434281cf.2
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 08:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756481461; x=1757086261; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dwApvEmS3DhNHhaRp4CwJfSXR39k2dMo6qBGnSKOCbI=;
        b=vqT9hs0BOuQZfQtporKXYlxMTwSloaw47caoRVBMBrYYVj3InJYHDR9otbSyYN+An2
         xSA0KwnDCLkxLpwcCYXNmJTJTrH+gVy1fEnNoBE0rhGtuaStPiK2ijbB4w8nc2ZiEaNL
         NfAVx9ePNZHVm7B8GP26X+eS/JwBcbRgPVVTyEP1X3UvnCeAFnaxKZk04jK35ETl8MKa
         zZh4QA3/VJ+Sp1J/C18cLkJbOzL11W16DC6dTYwyQGn8+qguN+DOCzZ4+fVzQMQRCar0
         FHMwpyfmv4O8NNgbgAZZ1M9HdHjolGB9hfBJpzXAVhmhPlx+g3XMbV2ajYIdJ+uVAGbN
         Vt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756481461; x=1757086261;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dwApvEmS3DhNHhaRp4CwJfSXR39k2dMo6qBGnSKOCbI=;
        b=FMOBavEiXKUcyxrfeY74xUztjaeB0KzDyVfomuhTUrscf/ez4E6V7eA4r4Bz25wwMn
         cFZqY8O2WYkGiG/VfKS26jKZ5PIvpz8VmYLgUEpkKFSuScFvB28wv8QE56p5LMBRuO08
         d6kZifrLiELeePAQCYtnTatneaq2oGqqpzKJpCMgccvnnK/RU9ct9ZTkjRL/Mjt2ete8
         3s3hQGK3t9xc23ioCXHnZqBzUwHMeo8YmPVM/zPmeDcsPEY0zus0QL+bK+eBRYUVQUXB
         o6avtf6gz4Hp2VJRaVzUu95MiXcQUz3hUuOPQGOU3JECGYSx9nAwiJGEbsqstMgCCN4m
         pE5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWoD70Q/Oth0ElWH7fcc42+3Hm51+MV1GQk8mepZYGFdqBJCDXZRfnY1DyWDnRBejHYBsAHows=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKfF3fYnwMtzhZ5R3gdqIudIGItIvtXHpiGIDHVYwLEt4kYtxM
	uR8QP4JFuAAk0WZEM60pVDnzbOYP9o+erimCOtAVDNSsQPfnIi6kWtLs7YY9aQgPkOv1TD+moQK
	Fm4E1FDHSqwwb7A==
X-Google-Smtp-Source: AGHT+IGLMRFd7uTla2k79rYUBl5sfyJyegA4kI79U/H7+O7a/Ze5Ds/8O0BwElPdvRi06o/lIszkFvnkJq3reA==
X-Received: from qknpb11.prod.google.com ([2002:a05:620a:838b:b0:7e6:5fba:1a9c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1149:b0:4b2:8e4c:71ca with SMTP id d75a77b69052e-4b2aaa196cbmr380755501cf.12.1756481461498;
 Fri, 29 Aug 2025 08:31:01 -0700 (PDT)
Date: Fri, 29 Aug 2025 15:30:52 +0000
In-Reply-To: <20250829153054.474201-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829153054.474201-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829153054.474201-3-edumazet@google.com>
Subject: [PATCH v3 net-next 2/4] inet: ping: remove ping_hash()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

There is no point in keeping ping_hash().

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
v3: Yue Haibing feedback (remove ping_hash() declaration in include/net/ping.h)
v2: https://lore.kernel.org/netdev/20250828164149.3304323-1-edumazet@google.com/T/#md0f7cce22b5a0ce71c366b75be20db3a528e8e03

 include/net/ping.h |  1 -
 net/ipv4/ping.c    | 10 ----------
 net/ipv6/ping.c    |  1 -
 3 files changed, 12 deletions(-)

diff --git a/include/net/ping.h b/include/net/ping.h
index bc7779262e60350e2748c74731a5d6d71f1b9455..9634b8800814dae4568e86fdf917bbe41d429b4b 100644
--- a/include/net/ping.h
+++ b/include/net/ping.h
@@ -54,7 +54,6 @@ struct pingfakehdr {
 };
 
 int  ping_get_port(struct sock *sk, unsigned short ident);
-int ping_hash(struct sock *sk);
 void ping_unhash(struct sock *sk);
 
 int  ping_init_sock(struct sock *sk);
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 74a0beddfcc41d8ba17792a11a9d027c9d590bac..75e1b0f5c697653e79166fde5f312f46b471344a 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -67,7 +67,6 @@ static inline u32 ping_hashfn(const struct net *net, u32 num, u32 mask)
 	pr_debug("hash(%u) = %u\n", num, res);
 	return res;
 }
-EXPORT_SYMBOL_GPL(ping_hash);
 
 static inline struct hlist_head *ping_hashslot(struct ping_table *table,
 					       struct net *net, unsigned int num)
@@ -144,14 +143,6 @@ int ping_get_port(struct sock *sk, unsigned short ident)
 }
 EXPORT_SYMBOL_GPL(ping_get_port);
 
-int ping_hash(struct sock *sk)
-{
-	pr_debug("ping_hash(sk->port=%u)\n", inet_sk(sk)->inet_num);
-	BUG(); /* "Please do not press this button again." */
-
-	return 0;
-}
-
 void ping_unhash(struct sock *sk)
 {
 	struct inet_sock *isk = inet_sk(sk);
@@ -1008,7 +999,6 @@ struct proto ping_prot = {
 	.bind =		ping_bind,
 	.backlog_rcv =	ping_queue_rcv_skb,
 	.release_cb =	ip4_datagram_release_cb,
-	.hash =		ping_hash,
 	.unhash =	ping_unhash,
 	.get_port =	ping_get_port,
 	.put_port =	ping_unhash,
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index 82b0492923d458213ac7a6f9316158af2191e30f..d7a2cdaa26312b44f1fe502d3d40f3e27f961fa8 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -208,7 +208,6 @@ struct proto pingv6_prot = {
 	.recvmsg =	ping_recvmsg,
 	.bind =		ping_bind,
 	.backlog_rcv =	ping_queue_rcv_skb,
-	.hash =		ping_hash,
 	.unhash =	ping_unhash,
 	.get_port =	ping_get_port,
 	.put_port =	ping_unhash,
-- 
2.51.0.318.gd7df087d1a-goog


