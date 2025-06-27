Return-Path: <netdev+bounces-201909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFD2AEB642
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27927561582
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4622BF00D;
	Fri, 27 Jun 2025 11:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nYbSc08B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412812BEC41
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751023548; cv=none; b=LORNT2ahB+Ti3s2X12idMMpkMdZcrmJ1RshyLIu4TI5sswv7BxlmIL1GCGWAtV9HJ4u/OI4d5GTFXv9Bcfe5M390BxgB6lfQ/gidw4Wh2N73DbILw2+hRM6ulclNWZgv//6iv5FYGUTlYtntW/VMC5Vu86iuxv0lxtIz0p4M/iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751023548; c=relaxed/simple;
	bh=N8U/ryXKbMHPtK0wneGOMGegACBg1Dcu7AlNrGfUBf8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uD4zEtDeG/qTh4CJOhiWdW0ROwS6rYa7+rdF62HHky7FNFtjT/qVLpeEEFL7tUqbE1qYuUI6cGYMsVEnkjV2qObZ89U1t8t7Ny7TZF2ELCoWicxCY5siD8lSVxXtXmlMiwfYfH4ZSdwKYZNq8gVpta/1nXV0pFps9Fuj72G8qsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nYbSc08B; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4a58cd9b142so42394671cf.0
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 04:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751023546; x=1751628346; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aKzuLzGx4hTLGri0daSKOom+HS9D2WkgxMe3sdrtcuA=;
        b=nYbSc08BrAJ72whBAZgk83vbJgsDAuoREigcVGeAwQ0NLtJJpv9MTdpW+Yd+3EkPhI
         96b0NXk9d9uIAo0HZyHYLXEU6dpxG0QDEL9K6hwPwtopH2ik/dxfTbqLFhkGqVDVrM6w
         TjvPSBPOlBRVAVhTibCp9mfwzj3+3jmPex+QlPEusTTGJr0PLc4neyVt0DR5HbFZl7yv
         v7a7atGTimqseRVKdkMQ34F6yTvC2wO9Dk+ktNJy+vAAsS05Nd5tNxJNz161EocSke4o
         aMnhQVR9bKbtDLxVpp/FHRefYPrYUu9RPWZQD/bQNJwUgFdc+nfbLQRFZ5kcQYouPtui
         83IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751023546; x=1751628346;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKzuLzGx4hTLGri0daSKOom+HS9D2WkgxMe3sdrtcuA=;
        b=jDMBAnKg0YXa9qMfwE+eXHjztilFw+QWFJ/kpKmHlfk83la7xkYZTxktrlZU0cyP++
         Hu2Y7zz5f6oQabf6+mBjFA62gjRSyqzLAnYl7CyFemxgxGtscr+uiN6h20Ocs9fh2kGv
         tXZZBoBcdJK7EU+XDGpd+Bd4SVEdZbZCPAgEIChX/7BJr9Waz8++7bhF4QB8E2M9dN1o
         qdL8NUN0WQ8wmuQWJFitW6bHLn9ErNzwvky6FWcbxbyQIUTuHR6hkTowl/kcEcsbLZMx
         ppi9CEdYymvWxpLRONObHIVpVRg5XkkeIACJbK753i/pARi+u7+Dvl6U2kGjGijMW41n
         6w6g==
X-Forwarded-Encrypted: i=1; AJvYcCU8mvtx0zy9EiiP3zwK8GRD0vEGJlSiQsE0WyLvqmCVdF04v1DkivD/HV8nVHk2epPF75l4/js=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdHDnxYTseEnxm+u5h2jAf9rJGbb8ThCwwEtb0Ue3XhZNXPE95
	vY7CbeHJa+XjjTQ8EkbyOSeT42Jo4/7KfrVg/cZA+sKYyAjO9sBaYQ32DtEOSCa/QHOK+1hxOps
	tzB51kisC4UHrAw==
X-Google-Smtp-Source: AGHT+IH4RzxlvsttsbRq/wUcFCcgkmBZ0VaKaVkHbIK1OcwwvuaHROaJvFQc6z6Qp5zx4dNmPEsU9UNJEDdwTw==
X-Received: from qvbrh2.prod.google.com ([2002:a05:6214:4f02:b0:6fd:ea3:c4b9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:1c47:b0:6e8:fe16:4d44 with SMTP id 6a1803df08f44-700134a81d5mr56575406d6.31.1751023546109;
 Fri, 27 Jun 2025 04:25:46 -0700 (PDT)
Date: Fri, 27 Jun 2025 11:25:22 +0000
In-Reply-To: <20250627112526.3615031-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627112526.3615031-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627112526.3615031-7-edumazet@google.com>
Subject: [PATCH net-next 06/10] net: dst: add four helpers to annotate
 data-races around dst->dev
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
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


