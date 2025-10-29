Return-Path: <netdev+bounces-234100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F08C1C7A1
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 18:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B78A24E0F0D
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39015354707;
	Wed, 29 Oct 2025 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3qWyvtlH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADD934FF4E
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759237; cv=none; b=C0MEYt3Qd2yRxY63bcZiluAUYm5QrDeBKuTv1pjj/O0JaYmutOdy/FNH8Qishilid2PovmWAqcKPawdPCUz+qt3jXHPsVGsJ4gPCKJy3i/Uq56+4jtlD/KfQ6dql05x/lhaZ1XwZ+vUZtnXsn8h3wDTAnFBs4ojLW1AYOY89c8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759237; c=relaxed/simple;
	bh=5iy/wwIGvMx/u9vqYbk9vtDUiNneqqgi035hemG3SIQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TmbVLN39RT2M6V8GVnopv4gn0BZ3UgRc0f8SxrHSn2nJwloqt3cHym/SEpwk++pXCE8UbeSDpXTeWnbF4P14KNZMqlFW47HvSAJ1osnaJ6NhnKBIs/g7jrhUloSMWwThvIqa1/yv7NuMyKDeK5UnC0nXSOnJCgyo9NpGYkK7P8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3qWyvtlH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-290c2d13a01so1315025ad.0
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 10:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761759235; x=1762364035; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T72f2YJoFtcxUABDqdIi5wZEhGV8fPTHo1QAsr92eVU=;
        b=3qWyvtlHD3vxGTZ6o7SaEBSIcgz4vpebGBVfacUpC/U0B9dzeCw96r+dIUMGtzdUGW
         Hij3tS+lcn98f2H24CL5ioqoLf9OzsrI504flvy91ud/wl0gZguGnFr0SYFNA41cjIkX
         XPOM382iXe9ZdcQceCLeamV9thErhbLeU5fql8ddyJjMWg7VclpROgICvbQ8vb7VOdS8
         v4ebUdGztlKfPe0xJLAxbzg3TFxLJ9MGEHB7F0OaeLQdOvIP83abQnex0CGjMVDxWPeP
         2NYUVQCm7VRK+pof/Ti8fwDW2LqFg3VwCHS4OFQVtdQHV7kwMYwfWbnNH+i04vle9ICo
         QnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761759235; x=1762364035;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T72f2YJoFtcxUABDqdIi5wZEhGV8fPTHo1QAsr92eVU=;
        b=GgXwB1euJzbd5YHwj7PZY5UdI7iwCkC1afMtlAp0UzDKKlXdmVJNgc5NdxoV4LXBVq
         EyCosbI2Ism/GhFdNAtevl/43mznhUYQMLXCAu3bV50niEHBao8un4Kbwv2YweYPkny4
         Tq05rX6jpauda6n11Nxoj/cSKHMgVvlsyOPGUQQVElVKXbVwvi6mksZQlR4iw/lqRyy9
         Keyzq5K6A5FGGd1P//cBmbFWH2VA1ZGcwjKClDplqWUp65+eVour7rlpCeezQIM7KyZm
         ZHqtbHmTcZGfc5fOLLKDtL8OPI3MOOhHqNLT2jftaFYpvLkKByNRNti2Bj23AuufrGN8
         uH+g==
X-Forwarded-Encrypted: i=1; AJvYcCUhGcKNRNjI4pl1a2IBSXw7iiXGXI+drmK2I5o+RMBdsIuC1jlanDe4uM9DBM/f+7YmyWc6mAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzte2nlOZnTm9Su9RhLZfUVnj2GQeMug4fGsvXghnJu21kmrONs
	QGjD4c1s6G3RIbhLfdZ2ITvylnFf6QKS278y0tK7vX96ypIjxOXyHMs8LJc4SEFKhv9KpPYbzZo
	K4O5+nQ==
X-Google-Smtp-Source: AGHT+IEzVkndTN0kBA2/Z/5kxw/Kd3kKVUm2zVBT1HkaCLKEV/tCUnpin1sR0iEsoqOZoz6+/Z8PdvOR6K0=
X-Received: from pjtz19.prod.google.com ([2002:a17:90a:cb13:b0:33b:cf89:6fe6])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dac7:b0:271:9b0e:54ca
 with SMTP id d9443c01a7336-294ed0c556dmr4471965ad.13.1761759234837; Wed, 29
 Oct 2025 10:33:54 -0700 (PDT)
Date: Wed, 29 Oct 2025 17:32:57 +0000
In-Reply-To: <20251029173344.2934622-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029173344.2934622-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029173344.2934622-6-kuniyu@google.com>
Subject: [PATCH v2 net-next 05/13] mpls: Use in6_dev_rcu() and dev_net_rcu()
 in mpls_forward() and mpls_xmit().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

mpls_forward() and mpls_xmit() are called under RCU.

Let's use in6_dev_rcu() and dev_net_rcu() there to annotate
as such.

Now we pass net to mpls_stats_inc_outucastpkts() not to read
dev_net_rcu() twice.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/mpls/af_mpls.c       | 15 ++++++++-------
 net/mpls/internal.h      |  3 ++-
 net/mpls/mpls_iptunnel.c |  4 ++--
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index c5bbf712f8be..efc6c7da5766 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -129,7 +129,8 @@ bool mpls_pkt_too_big(const struct sk_buff *skb, unsigned int mtu)
 }
 EXPORT_SYMBOL_GPL(mpls_pkt_too_big);
 
-void mpls_stats_inc_outucastpkts(struct net_device *dev,
+void mpls_stats_inc_outucastpkts(struct net *net,
+				 struct net_device *dev,
 				 const struct sk_buff *skb)
 {
 	struct mpls_dev *mdev;
@@ -141,13 +142,13 @@ void mpls_stats_inc_outucastpkts(struct net_device *dev,
 					   tx_packets,
 					   tx_bytes);
 	} else if (skb->protocol == htons(ETH_P_IP)) {
-		IP_UPD_PO_STATS(dev_net(dev), IPSTATS_MIB_OUT, skb->len);
+		IP_UPD_PO_STATS(net, IPSTATS_MIB_OUT, skb->len);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else if (skb->protocol == htons(ETH_P_IPV6)) {
-		struct inet6_dev *in6dev = __in6_dev_get(dev);
+		struct inet6_dev *in6dev = in6_dev_rcu(dev);
 
 		if (in6dev)
-			IP6_UPD_PO_STATS(dev_net(dev), in6dev,
+			IP6_UPD_PO_STATS(net, in6dev,
 					 IPSTATS_MIB_OUT, skb->len);
 #endif
 	}
@@ -342,7 +343,7 @@ static bool mpls_egress(struct net *net, struct mpls_route *rt,
 static int mpls_forward(struct sk_buff *skb, struct net_device *dev,
 			struct packet_type *pt, struct net_device *orig_dev)
 {
-	struct net *net = dev_net(dev);
+	struct net *net = dev_net_rcu(dev);
 	struct mpls_shim_hdr *hdr;
 	const struct mpls_nh *nh;
 	struct mpls_route *rt;
@@ -434,7 +435,7 @@ static int mpls_forward(struct sk_buff *skb, struct net_device *dev,
 	dec.ttl -= 1;
 	if (unlikely(!new_header_size && dec.bos)) {
 		/* Penultimate hop popping */
-		if (!mpls_egress(dev_net(out_dev), rt, skb, dec))
+		if (!mpls_egress(net, rt, skb, dec))
 			goto err;
 	} else {
 		bool bos;
@@ -451,7 +452,7 @@ static int mpls_forward(struct sk_buff *skb, struct net_device *dev,
 		}
 	}
 
-	mpls_stats_inc_outucastpkts(out_dev, skb);
+	mpls_stats_inc_outucastpkts(net, out_dev, skb);
 
 	/* If via wasn't specified then send out using device address */
 	if (nh->nh_via_table == MPLS_NEIGH_TABLE_UNSPEC)
diff --git a/net/mpls/internal.h b/net/mpls/internal.h
index 3a5feca27d6a..e491427ea08a 100644
--- a/net/mpls/internal.h
+++ b/net/mpls/internal.h
@@ -197,7 +197,8 @@ int nla_get_labels(const struct nlattr *nla, u8 max_labels, u8 *labels,
 bool mpls_output_possible(const struct net_device *dev);
 unsigned int mpls_dev_mtu(const struct net_device *dev);
 bool mpls_pkt_too_big(const struct sk_buff *skb, unsigned int mtu);
-void mpls_stats_inc_outucastpkts(struct net_device *dev,
+void mpls_stats_inc_outucastpkts(struct net *net,
+				 struct net_device *dev,
 				 const struct sk_buff *skb);
 
 #endif /* MPLS_INTERNAL_H */
diff --git a/net/mpls/mpls_iptunnel.c b/net/mpls/mpls_iptunnel.c
index 6e73da94af7f..cfbab7b2fec7 100644
--- a/net/mpls/mpls_iptunnel.c
+++ b/net/mpls/mpls_iptunnel.c
@@ -53,7 +53,7 @@ static int mpls_xmit(struct sk_buff *skb)
 
 	/* Find the output device */
 	out_dev = dst->dev;
-	net = dev_net(out_dev);
+	net = dev_net_rcu(out_dev);
 
 	if (!mpls_output_possible(out_dev) ||
 	    !dst->lwtstate || skb_warn_if_lro(skb))
@@ -128,7 +128,7 @@ static int mpls_xmit(struct sk_buff *skb)
 		bos = false;
 	}
 
-	mpls_stats_inc_outucastpkts(out_dev, skb);
+	mpls_stats_inc_outucastpkts(net, out_dev, skb);
 
 	if (rt) {
 		if (rt->rt_gw_family == AF_INET6)
-- 
2.51.1.851.g4ebd6896fd-goog


