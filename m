Return-Path: <netdev+bounces-233409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA30C12C7F
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 04:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 876275E161E
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 03:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24F9284889;
	Tue, 28 Oct 2025 03:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bb2ykBdE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1255A27B33B
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 03:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761622717; cv=none; b=tHikevcvlNEf7wxEhHzE8tfhE2ye1CGfnpWGIfMzAnXBAjvFEVOQCUlWAxO8R8qiAgF3TMhaa45cZK7Fsjdx6IKVMA1fYtRkxkG7SCFPjyubT9IUqOnHToAo+A57moWv65oyQBucefwUYNOp93o5exNbJjFCZWtAtM0BEIqCNvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761622717; c=relaxed/simple;
	bh=LQTJoWhkA7p8Kn+nPWkc5JQgf04FIGOfWB1kBmhoRuY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LBWTMwat8F4Vi8hIULdhAS68RL71FlXf40JJ5NF3+pzO9Emjxq61+A3iA4Rz8eupqMl1G5zwQ2qyWI693tTLjNpPUM9Sq1MjlFLvjiw74s+iyZMLlTY3+wDhY+lRqS0wQMcF+l4PVhzJHEMaqNdFBGIGbFdf5Ms4js/a1ERJgmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bb2ykBdE; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77f610f7325so4073646b3a.1
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 20:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761622715; x=1762227515; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bmcDw6wJ9Aln5Uwrd+WG7F46T4aErd25tY/Ukh4C7Oc=;
        b=Bb2ykBdE6+Gz+6/guWSMmtJt1QrtUh0LbrpR//ccs41cjM6KFecgooYUPWw0mbWs3Z
         AGx8MPSnaC3D3A/7H2q/KVV3MqYFTPWKej39bqCmJwl+4+gRSCkY4K7OVaylICKd2Tea
         PbzQyQesq3cbhiY3yfrVU5/HYrSPpS+BklAmKFMbVc9C/4I/eQ4MOkagFsjg6GMS/G6M
         NQ6jH+Lj5CLjubV4tC1xH3t4w1rlDSq+Eo7RjEQSkNeNnI+JhrfTe5BwBc/nUcyDNZOC
         RcbAzNlvYIA17c51BDA0vtwKty2zk9PCczRFLTVNkjjD0E3Ko2o8BpqLVvilo6hAIjOm
         sZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761622715; x=1762227515;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bmcDw6wJ9Aln5Uwrd+WG7F46T4aErd25tY/Ukh4C7Oc=;
        b=FhfOTJHNB9A/Slfnx7Riqy7SqyBbslg56b5g02Mf91O1UHf1jNMRVnmQe8mg/ytXnz
         fmzvdWRt7IZxc6MRhZMShghD9PgIDl2knU9hq0FlLumD1u7IwmlneflEqVkSrigSqVxN
         uD33gDVVDg1ZtPpxcXgkWVpPls9qfGSp+PNtlHMqNFxoakJJkhYzDunzva5e87wawfjw
         C2FSCECiQvXR21A7kkRuAsggn6t1ZBKnL/uGWEMIALVMnZrBxEk0KyVuqG0yPwpyedzR
         +mc3lFPsZBApaQho4oeqqterGu5X9BjKxbgGQMV2M1Lz0qqiHc5GZZ4COTQQbA4sXdM5
         vf9A==
X-Forwarded-Encrypted: i=1; AJvYcCWMnkoWKW6d0o7nf6aXjm7G4GsExpychVHhjN7znQoZNhn5xGK174vhzwbmNiQsTwZpwm4w9uY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw37VblA/vySeeOsCQEvvyRpykXR/pozisZyMakcIrC2NFFKbY1
	wE1Kafu9LmwxUx/RkkH+CAtmcqfd3/URFdxhSqJDJYjaZOfy9H0CFuqAVc8e22mqyEkqKm8maqW
	ymnW4Vw==
X-Google-Smtp-Source: AGHT+IHzt/vBQxj1A2NPAmNUlJYlxb64ciLh85UYJzxCeiHBOmNIGYysMbVevjSyBMoqmCjP/xfdsBZube4=
X-Received: from pfqn15.prod.google.com ([2002:aa7:984f:0:b0:77f:2e96:5d3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:234a:b0:7a2:766f:518e
 with SMTP id d2e1a72fcca58-7a441c46abcmr2133006b3a.23.1761622715368; Mon, 27
 Oct 2025 20:38:35 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:37:01 +0000
In-Reply-To: <20251028033812.2043964-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028033812.2043964-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.838.g19442a804e-goog
Message-ID: <20251028033812.2043964-7-kuniyu@google.com>
Subject: [PATCH v1 net-next 06/13] mpls: Add mpls_dev_rcu().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

mpls_dev_get() uses rcu_dereference_rtnl() to fetch dev->mpls_ptr.

We will replace RTNL with a dedicated mutex to protect the field.

Then, we will use rcu_dereference_protected() for clarity.

Let's add mpls_dev_rcu() for the RCU reader.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/mpls/af_mpls.c       | 12 ++++++------
 net/mpls/internal.h      |  5 +++++
 net/mpls/mpls_iptunnel.c |  2 +-
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index efc6c7da5766..10130b90c439 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -136,7 +136,7 @@ void mpls_stats_inc_outucastpkts(struct net *net,
 	struct mpls_dev *mdev;
 
 	if (skb->protocol == htons(ETH_P_MPLS_UC)) {
-		mdev = mpls_dev_get(dev);
+		mdev = mpls_dev_rcu(dev);
 		if (mdev)
 			MPLS_INC_STATS_LEN(mdev, skb->len,
 					   tx_packets,
@@ -358,7 +358,7 @@ static int mpls_forward(struct sk_buff *skb, struct net_device *dev,
 
 	/* Careful this entire function runs inside of an rcu critical section */
 
-	mdev = mpls_dev_get(dev);
+	mdev = mpls_dev_rcu(dev);
 	if (!mdev)
 		goto drop;
 
@@ -467,7 +467,7 @@ static int mpls_forward(struct sk_buff *skb, struct net_device *dev,
 	return 0;
 
 tx_err:
-	out_mdev = out_dev ? mpls_dev_get(out_dev) : NULL;
+	out_mdev = out_dev ? mpls_dev_rcu(out_dev) : NULL;
 	if (out_mdev)
 		MPLS_INC_STATS(out_mdev, tx_errors);
 	goto drop;
@@ -1118,7 +1118,7 @@ static int mpls_fill_stats_af(struct sk_buff *skb,
 	struct mpls_dev *mdev;
 	struct nlattr *nla;
 
-	mdev = mpls_dev_get(dev);
+	mdev = mpls_dev_rcu(dev);
 	if (!mdev)
 		return -ENODATA;
 
@@ -1138,7 +1138,7 @@ static size_t mpls_get_stats_af_size(const struct net_device *dev)
 {
 	struct mpls_dev *mdev;
 
-	mdev = mpls_dev_get(dev);
+	mdev = mpls_dev_rcu(dev);
 	if (!mdev)
 		return 0;
 
@@ -1341,7 +1341,7 @@ static int mpls_netconf_dump_devconf(struct sk_buff *skb,
 
 	rcu_read_lock();
 	for_each_netdev_dump(net, dev, ctx->ifindex) {
-		mdev = mpls_dev_get(dev);
+		mdev = mpls_dev_rcu(dev);
 		if (!mdev)
 			continue;
 		err = mpls_netconf_fill_devconf(skb, mdev,
diff --git a/net/mpls/internal.h b/net/mpls/internal.h
index e491427ea08a..080e82010022 100644
--- a/net/mpls/internal.h
+++ b/net/mpls/internal.h
@@ -185,6 +185,11 @@ static inline struct mpls_entry_decoded mpls_entry_decode(struct mpls_shim_hdr *
 	return result;
 }
 
+static inline struct mpls_dev *mpls_dev_rcu(const struct net_device *dev)
+{
+	return rcu_dereference(dev->mpls_ptr);
+}
+
 static inline struct mpls_dev *mpls_dev_get(const struct net_device *dev)
 {
 	return rcu_dereference_rtnl(dev->mpls_ptr);
diff --git a/net/mpls/mpls_iptunnel.c b/net/mpls/mpls_iptunnel.c
index cfbab7b2fec7..1a1a0eb5b787 100644
--- a/net/mpls/mpls_iptunnel.c
+++ b/net/mpls/mpls_iptunnel.c
@@ -153,7 +153,7 @@ static int mpls_xmit(struct sk_buff *skb)
 	return LWTUNNEL_XMIT_DONE;
 
 drop:
-	out_mdev = out_dev ? mpls_dev_get(out_dev) : NULL;
+	out_mdev = out_dev ? mpls_dev_rcu(out_dev) : NULL;
 	if (out_mdev)
 		MPLS_INC_STATS(out_mdev, tx_errors);
 	kfree_skb(skb);
-- 
2.51.1.838.g19442a804e-goog


