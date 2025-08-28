Return-Path: <netdev+bounces-217978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F9CB3AB27
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 21:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11C41BA75FF
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 19:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0801284889;
	Thu, 28 Aug 2025 19:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dSSEAbbo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223FC27FD75
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756411110; cv=none; b=oAeXx5kMtg32QIBbUzz4rW9XM0efJvEW38VyTta3YJh6K5jrrdIM7R5sNG/8+K0+t0OYQpClL87DVIhGKb5ILT11aX4/e4j/Vgc6GrRPK0wAhtmqzn6tpj21JRbQ3UBZdCJJsfzhANzyBLW2IOJ10c/ijOFDhCh5u843oUb4voM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756411110; c=relaxed/simple;
	bh=mOzmTBZcdN1M7aMfnHw3xXPDbzmHR6usLwfXmfOxdBs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FEiSE+CXiR9tBSO2E2lddz27HkElkpjl5Qrc4rusX8bU6ylJURuO8jaJsvpUrSlqjJEiHRSRtGkiyRo9yk4IJHa+NuZtrP4X9dt/0oDZeoYlaI4L540aPZtJAf/8oR7VxIfKAOjsw+wBcYIJDH0CaetZDVdNwTUJOHnwVdqecwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dSSEAbbo; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-70d903d04dbso30212846d6.0
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 12:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756411108; x=1757015908; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0YqWhbujUJRkZSQTpVJJcgPL8LGB8qAC+LlAjvP7eyg=;
        b=dSSEAbbovA4uAYY81g5X9MY5KemxJ/2reiW9MYFD3HzbMS/yOj9KdU8W6xqgrmm5Vt
         poNvQ749QEWrSF0qVlFo689x6WF95Pyo/iy8uKEeelNl40v1iHDofBvjVd820D3BT+5f
         s7hQIBPrPNcR5tijAC2H3oleHTIgld1T200hNB++qvsqdGl+bJ+jAJjABaHtQiLlI2w0
         J6xnzMlxhq3T8xz77Rqh+0VHP6mXKSaCwtqcwJ5sK7bTnqEuUQnaGxvSnn99lwOdRUdq
         f7/M2+tcvlT0lD9ZLrS7YSZjwpbWOQw/Fj2wnFnaqb6MnLqM0wPjRy3XO345nvwVM2uE
         8NFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756411108; x=1757015908;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0YqWhbujUJRkZSQTpVJJcgPL8LGB8qAC+LlAjvP7eyg=;
        b=W2W0k+8on8bVmUalfHz/K8WW5rgct/qbV4buF/APNvsdr9JYVYGBr+cJLzUde9+zcP
         GyoPitqHNrj15PlynDjvx2gIZg+IxRnpZYW8p6DiJgLdaDBkv/SsFaABGiMwhwTStJP9
         38ZETVO1nepaRyrtNcMx4Kvc24qM83TlagcmaHuY6dDB0CIApeZMNZGs46QWX340vkCK
         SC7Dy/wa4wys/jOeH6tFsBiqmQa6vYzw63MaLFUtKH43uvhhIogENjVYLBRPtxssgAeh
         AadStX1lxawv32kkj4hTJCiPW2tVrwv5n4f362ME5tFLa7rEsWjnzMBnuMu0NBucroEN
         wMNg==
X-Forwarded-Encrypted: i=1; AJvYcCVpY+WTgAaQlnZsV2eKHLEO0wevaVLWlR+XsnwBoba4+Cvxg0hGSJqevMUHzW/bfq8oJEBIpoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv3uNymQGz2CRGYYRbwUPDHKyxwow7/flvE0K0AnmqFeQEgFk7
	UH5VT3VPB5/w9Y04cjaFN2NzUU7edmqhSO4QCyXxQUWlbpk0W9W7W4dc0qn5Je2A6uS9g3gh+tH
	HO9Q52w/J3qKh9Q==
X-Google-Smtp-Source: AGHT+IFdq2BjNfrss7XXZ+jQWc9hFRJRm+/6JY9nDKnRORSauAf/IAXW+WjWgZ1nyS92bqN29Ku/t8yzyqGDmA==
X-Received: from qkoz2.prod.google.com ([2002:a05:620a:2602:b0:7e8:8ec5:f60f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:4103:b0:70d:f76c:b218 with SMTP id 6a1803df08f44-70df76cefecmr37586756d6.31.1756411107911;
 Thu, 28 Aug 2025 12:58:27 -0700 (PDT)
Date: Thu, 28 Aug 2025 19:58:16 +0000
In-Reply-To: <20250828195823.3958522-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828195823.3958522-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250828195823.3958522-2-edumazet@google.com>
Subject: [PATCH net-next 1/8] net: dst: introduce dst->dev_rcu
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Followup of commit 88fe14253e18 ("net: dst: add four helpers
to annotate data-races around dst->dev").

We want to gradually add explicit RCU protection to dst->dev,
including lockdep support.

Add an union to alias dst->dev_rcu and dst->dev.

Add dst_dev_net_rcu() helper.

Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/dst.h | 16 +++++++++++-----
 net/core/dst.c    |  2 +-
 net/ipv4/route.c  |  4 ++--
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index bab01363bb975dc20ea0e1485a515c1872537ab9..f8aa1239b4db639bd6b63f4ddb4ec4d7ee459ac0 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -24,7 +24,10 @@
 struct sk_buff;
 
 struct dst_entry {
-	struct net_device       *dev;
+	union {
+		struct net_device       *dev;
+		struct net_device __rcu *dev_rcu;
+	};
 	struct  dst_ops	        *ops;
 	unsigned long		_metrics;
 	unsigned long           expires;
@@ -570,9 +573,12 @@ static inline struct net_device *dst_dev(const struct dst_entry *dst)
 
 static inline struct net_device *dst_dev_rcu(const struct dst_entry *dst)
 {
-	/* In the future, use rcu_dereference(dst->dev) */
-	WARN_ON_ONCE(!rcu_read_lock_held());
-	return READ_ONCE(dst->dev);
+	return rcu_dereference(dst->dev_rcu);
+}
+
+static inline struct net *dst_dev_net_rcu(const struct dst_entry *dst)
+{
+	return dev_net_rcu(dst_dev_rcu(dst));
 }
 
 static inline struct net_device *skb_dst_dev(const struct sk_buff *skb)
@@ -592,7 +598,7 @@ static inline struct net *skb_dst_dev_net(const struct sk_buff *skb)
 
 static inline struct net *skb_dst_dev_net_rcu(const struct sk_buff *skb)
 {
-	return dev_net_rcu(skb_dst_dev(skb));
+	return dev_net_rcu(skb_dst_dev_rcu(skb));
 }
 
 struct dst_entry *dst_blackhole_check(struct dst_entry *dst, u32 cookie);
diff --git a/net/core/dst.c b/net/core/dst.c
index e2de8b68c41d3fa6f8a94b61b88f531a2d79d3b4..e9d35f49c9e7800d7397b643c70931dd516a6265 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -150,7 +150,7 @@ void dst_dev_put(struct dst_entry *dst)
 		dst->ops->ifdown(dst, dev);
 	WRITE_ONCE(dst->input, dst_discard);
 	WRITE_ONCE(dst->output, dst_discard_out);
-	WRITE_ONCE(dst->dev, blackhole_netdev);
+	rcu_assign_pointer(dst->dev_rcu, blackhole_netdev);
 	netdev_ref_replace(dev, blackhole_netdev, &dst->dev_tracker,
 			   GFP_ATOMIC);
 }
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 771f6986ed05882ebaeb1117ac33d68edf5db699..c63feef55d5193aadd11f9d5b45c8f5482e06be5 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1027,7 +1027,7 @@ static void __ip_rt_update_pmtu(struct rtable *rt, struct flowi4 *fl4, u32 mtu)
 		return;
 
 	rcu_read_lock();
-	net = dev_net_rcu(dst_dev(dst));
+	net = dst_dev_net_rcu(dst);
 	if (mtu < net->ipv4.ip_rt_min_pmtu) {
 		lock = true;
 		mtu = min(old_mtu, net->ipv4.ip_rt_min_pmtu);
@@ -1327,7 +1327,7 @@ static unsigned int ipv4_default_advmss(const struct dst_entry *dst)
 	struct net *net;
 
 	rcu_read_lock();
-	net = dev_net_rcu(dst_dev(dst));
+	net = dst_dev_net_rcu(dst);
 	advmss = max_t(unsigned int, ipv4_mtu(dst) - header_size,
 				   net->ipv4.ip_rt_min_advmss);
 	rcu_read_unlock();
-- 
2.51.0.318.gd7df087d1a-goog


