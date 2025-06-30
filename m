Return-Path: <netdev+bounces-202413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8371AAEDC9C
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CA6F7A41B8
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 12:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E61728A1DA;
	Mon, 30 Jun 2025 12:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2+mxONDJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EF5289E27
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 12:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751285988; cv=none; b=c9+JGwLZVskDmkPEjRMKEX6Ekr5hZEFL3kK/UumTu4rFl0HHsBbV39IKdXWSDN9DyNfFks0FucRY5Z544x8fA+2l9pfmbRJ8xs6FoUzRQjZ9a8JLFAUSLdDS6ZV+5qUk2rdxgxTMP4vaLMwEd+sjIdcNxaVFJzzk67yhOuX1+cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751285988; c=relaxed/simple;
	bh=4HnMyGrmb4bU12OWkbqDMTPzb3Dv1hn75tvfKi8RGPU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qy+dTuSYO24MlZTjDRNXIlbzWU2nmc/5OP0Dk0ONoJOIi7JW05aMVi3J5zOKwVR7s1EboEnNGq63xtipbJaYZDQVQaTXVeFSCAz9YR/pg/LdTwoIGFQXPVtQGOsqwccc9/VijMhrg4fzATszpiCGNXBRH7IIADuJqDd+kbvay34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2+mxONDJ; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4a43c1e1e6bso95607781cf.3
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 05:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751285985; x=1751890785; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DdSA1SqjyK1B0ZeeopO9jRjr6RuzYki6Taqs45p1Ww4=;
        b=2+mxONDJqnRAxG/Mgw3/rJmyQJHleJy76MSypwbVbCOxoVBI3IUAWs8McCWVO6zbhx
         F4iZ3uqJGA5ZSlmTWMlt/Z6e7q/MkszWYRns00D3c9AByxNMBWqd4yuVY38rlRKmReNV
         KOq2Fd7R8gFQ1Dce/FdLyyNs6owZh8aUKlHI0Zd3d6Ak1FuTCEaCR5plj3e+u6Ezwjt2
         xJO/fjDnePZq2w7RDVN6dE3cYw4CxWqTJN6xuUaQx255BqKse/9nhwHyxukb8xJnyCYa
         9C+bRnsuKXfeNQlGu9KKTj9YoKaqQ8llDTomzciO9HhDOCN4ZdP5szh0/NVeUiqLKyoj
         p3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751285985; x=1751890785;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DdSA1SqjyK1B0ZeeopO9jRjr6RuzYki6Taqs45p1Ww4=;
        b=XRBSrVB9BtWs0U5Gu+MblV1qZjCenj4cNgVjfH3GeyRnBFt3V9bEK4TzISKQCHqh97
         KIf5E+MXmLqqucTRpVUghXLtVIgpTqJoJ3VEwRbemsonm3qzb8mBWnA2GdGE/fIXrL/P
         PlpeXXcmvPmnpuL/YcU7HzY14nJLhCG8H+UKpu6nb/LI/NEoDBZkjpc/i9ZhayhOuwLQ
         GhUDzc92ZENLYL+RWq8gJuCsMGA3YfdTuWOEq9jmGERUpVMUaxZjNnvpJtck3GJl4jgp
         CYOMf70dHt9k3CAjsXzGuzKoNZvNNEba8vXox0ENjD6Vg0N40ChCMmfjR6moOsCGBigA
         +7cA==
X-Forwarded-Encrypted: i=1; AJvYcCXd/BgsZdfCSnEccUvdjkiT3+QwY2Xfuvg7PdGZGR1XHkPtLWNx1F9P2Lbzn85/qIyWi+06HUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf36oKZVC0mU/l1wQap8www2nhPWMm7YslsOiXMRZof2xEloxA
	102QpydOBeFxUMxSkY5WzS3ZTXQs3NgO+xN1zUFl6hah3KSQ5HvymEy93SgV7VQQ6sOkDhVE2iS
	RzDchjloOf35+zQ==
X-Google-Smtp-Source: AGHT+IHAONknJW9m5XA3Ak3V62ccuk3g54f3w2MGPVttVcewdygVDpzraY6Gt/bb05RH00UiqxkbT9qZ1gNWQg==
X-Received: from qtbhg19.prod.google.com ([2002:a05:622a:6113:b0:4a6:f514:a9cd])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4b13:b0:4a7:7353:bcbb with SMTP id d75a77b69052e-4a7fcd2f99emr192425111cf.12.1751285985369;
 Mon, 30 Jun 2025 05:19:45 -0700 (PDT)
Date: Mon, 30 Jun 2025 12:19:30 +0000
In-Reply-To: <20250630121934.3399505-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250630121934.3399505-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250630121934.3399505-7-edumazet@google.com>
Subject: [PATCH v2 net-next 06/10] net: dst: add four helpers to annotate
 data-races around dst->dev
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dst->dev is read locklessly in many contexts,
and written in dst_dev_put().

Fixing all the races is going to need many changes.

We probably will have to add full RCU protection.

Add three helpers to ease this painful process.

static inline struct net_device *dst_dev(const struct dst_entry *dst)
{
       return READ_ONCE(dst->dev);
}

static inline struct net_device *skb_dst_dev(const struct sk_buff *skb)
{
       return dst_dev(skb_dst(skb));
}

static inline struct net *skb_dst_dev_net(const struct sk_buff *skb)
{
       return dev_net(skb_dst_dev(skb));
}

static inline struct net *skb_dst_dev_net_rcu(const struct sk_buff *skb)
{
       return dev_net_rcu(skb_dst_dev(skb));
}

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/dst.h | 20 ++++++++++++++++++++
 net/core/dst.c    |  4 ++--
 net/core/sock.c   |  8 ++++----
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index b6acfde7d587c40489aaf869f715479478f548ca..00467c1b509389a8e37d6e3d0912374a0ff12c4a 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -563,6 +563,26 @@ static inline void skb_dst_update_pmtu_no_confirm(struct sk_buff *skb, u32 mtu)
 		dst->ops->update_pmtu(dst, NULL, skb, mtu, false);
 }
 
+static inline struct net_device *dst_dev(const struct dst_entry *dst)
+{
+	return READ_ONCE(dst->dev);
+}
+
+static inline struct net_device *skb_dst_dev(const struct sk_buff *skb)
+{
+	return dst_dev(skb_dst(skb));
+}
+
+static inline struct net *skb_dst_dev_net(const struct sk_buff *skb)
+{
+	return dev_net(skb_dst_dev(skb));
+}
+
+static inline struct net *skb_dst_dev_net_rcu(const struct sk_buff *skb)
+{
+	return dev_net_rcu(skb_dst_dev(skb));
+}
+
 struct dst_entry *dst_blackhole_check(struct dst_entry *dst, u32 cookie);
 void dst_blackhole_update_pmtu(struct dst_entry *dst, struct sock *sk,
 			       struct sk_buff *skb, u32 mtu, bool confirm_neigh);
diff --git a/net/core/dst.c b/net/core/dst.c
index 52e824e57c1755a39008fede0d97c7ed7be56855..e2de8b68c41d3fa6f8a94b61b88f531a2d79d3b4 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -150,7 +150,7 @@ void dst_dev_put(struct dst_entry *dst)
 		dst->ops->ifdown(dst, dev);
 	WRITE_ONCE(dst->input, dst_discard);
 	WRITE_ONCE(dst->output, dst_discard_out);
-	dst->dev = blackhole_netdev;
+	WRITE_ONCE(dst->dev, blackhole_netdev);
 	netdev_ref_replace(dev, blackhole_netdev, &dst->dev_tracker,
 			   GFP_ATOMIC);
 }
@@ -263,7 +263,7 @@ unsigned int dst_blackhole_mtu(const struct dst_entry *dst)
 {
 	unsigned int mtu = dst_metric_raw(dst, RTAX_MTU);
 
-	return mtu ? : dst->dev->mtu;
+	return mtu ? : dst_dev(dst)->mtu;
 }
 EXPORT_SYMBOL_GPL(dst_blackhole_mtu);
 
diff --git a/net/core/sock.c b/net/core/sock.c
index dc59fb7760a3a2475494b84748989e2934128b75..8b7623c7d547dbf20c263aed249e63f62e988447 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2588,8 +2588,8 @@ static u32 sk_dst_gso_max_size(struct sock *sk, struct dst_entry *dst)
 		   !ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr));
 #endif
 	/* pairs with the WRITE_ONCE() in netif_set_gso(_ipv4)_max_size() */
-	max_size = is_ipv6 ? READ_ONCE(dst->dev->gso_max_size) :
-			READ_ONCE(dst->dev->gso_ipv4_max_size);
+	max_size = is_ipv6 ? READ_ONCE(dst_dev(dst)->gso_max_size) :
+			READ_ONCE(dst_dev(dst)->gso_ipv4_max_size);
 	if (max_size > GSO_LEGACY_MAX_SIZE && !sk_is_tcp(sk))
 		max_size = GSO_LEGACY_MAX_SIZE;
 
@@ -2600,7 +2600,7 @@ void sk_setup_caps(struct sock *sk, struct dst_entry *dst)
 {
 	u32 max_segs = 1;
 
-	sk->sk_route_caps = dst->dev->features;
+	sk->sk_route_caps = dst_dev(dst)->features;
 	if (sk_is_tcp(sk)) {
 		struct inet_connection_sock *icsk = inet_csk(sk);
 
@@ -2618,7 +2618,7 @@ void sk_setup_caps(struct sock *sk, struct dst_entry *dst)
 			sk->sk_route_caps |= NETIF_F_SG | NETIF_F_HW_CSUM;
 			sk->sk_gso_max_size = sk_dst_gso_max_size(sk, dst);
 			/* pairs with the WRITE_ONCE() in netif_set_gso_max_segs() */
-			max_segs = max_t(u32, READ_ONCE(dst->dev->gso_max_segs), 1);
+			max_segs = max_t(u32, READ_ONCE(dst_dev(dst)->gso_max_segs), 1);
 		}
 	}
 	sk->sk_gso_max_segs = max_segs;
-- 
2.50.0.727.gbf7dc18ff4-goog


