Return-Path: <netdev+bounces-233408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D05B4C12C64
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 04:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026D71AA6B8A
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 03:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442BB281525;
	Tue, 28 Oct 2025 03:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FKQtov6a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD83027877D
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 03:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761622716; cv=none; b=QVxhhY2mfmtD8Ea9PdKqILil3O4zF7srqBSQnQmNDvjRUXpnQnKyGAObE5qP5Vt1fJhF+sQtdj6YyW5BhgvaTVSjslUxw1T+kduNjY9qnJMKDWlFSQC7Ow2ZQoQJHQppp0ePYuUpCHH5t5+blgl89Y3QAq+z2jNZQdT9Hc/Lzcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761622716; c=relaxed/simple;
	bh=X7ZGfUq10JYTZPUhhUWt6SLXsKfQf7zGZTX0dYZWxuw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hm6jTYUbaZuySBytbwryEgN2sgjwWBA6DZdbnKnSgJwvVl8S/I/EnzBPX0bqsqRoG79Nur+xi6kbg7bKRSR93tV9W9bePLnhL75tH89Vin0RpxpE3XjEQG8Ip5p7MDdZjIjXxCkxNaScPPluW1jq6t+eytWO3UFbPzfIE2LLlbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FKQtov6a; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-294a938fa37so53534405ad.2
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 20:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761622714; x=1762227514; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gsSE5NTM4UcvjKjpcDhXQaGe7Dbq2Tl37tjSg1MvT1I=;
        b=FKQtov6a8a0wjvPir/2d9PkFc1JaSFL3NMjw61pG0Mkyg45p9q2/aA/n//BpyPhZFB
         yFexiPzBJQAoVdK1F3ddUArR31TS0pwkNk+qr/ZQUNOTTZ4WCtE+1hW5zvugvKALWVjI
         CSZSyDJltLK8qaLv0iepbE8XIm5E+t5oyFI2mIrrd4hTfjqsWIxFU/1bIv1oujW0k21x
         wv1AUBMxwhAQ4h0O1ymfjsHMVuCPbUMmAXbKIYizYVRkZkSa+DJX05SPg2imzkTn330j
         I03JNZDvpiv5FMZQz/q0n3C7c8CIpPn9tcwbMzEvarx7kuLtGzfZEh5JsK9Yl5SizUlj
         nJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761622714; x=1762227514;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gsSE5NTM4UcvjKjpcDhXQaGe7Dbq2Tl37tjSg1MvT1I=;
        b=CYBvIH0xWxCNOeDzFHWq376OaiCD5okJ75o9vJ3e2JZ47EyuC8OECpLuK7B8hksK6E
         4W4EBXezEPo5tf/Qxk7LMLmBQsxsujkNuenriHFJAWFYijeAjcW30ACOA44w2jtoFd/j
         bEZRrXUpQM7E8kDuzVWlSb0bi+XsNQYydi0gB0kENGAa30IOsUiCF/mYCp4HD222yiXR
         DeRzdIMcszZqBOAFSGq7muS193kmFoloey7paRRFZF7pRwd/HcgyT7awfZTV+x8r8FDv
         7fqURUPQxf6dgbMJDg3EBheYlFwAuKGAb1OkB47W+Y2OtXR0vB4Uf3TYoCb1HSb/abas
         YrXg==
X-Forwarded-Encrypted: i=1; AJvYcCUTJNrs/awigA1sbpo/FziJ2BqvFfPKtxarhfTt/xWU+8d5xIjV+OU29UQDB7IgZEvbfw8W+JI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMvpOtAOUNA2K/G6icfHCqllK7xHk4uskABFNwWa2tv/NoZNgM
	PSNRYYlYAIUO8eSc01CUI3XT6q+l0Rl9vHalXN/uv6MPpIx0RozZxwhCHm+RJ6Kc+mUjoO54ZUJ
	U3csAPQ==
X-Google-Smtp-Source: AGHT+IF6c+o078pY28ykU7C0Kzy8Z9/ZbRr4wHGT/xDKp/QmwtTlPR55iCAsHBfrx25bkroynCitaNbvAr4=
X-Received: from pjob9.prod.google.com ([2002:a17:90a:8c89:b0:33b:8aa1:75ed])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e746:b0:275:3ff9:ab88
 with SMTP id d9443c01a7336-294cb66cc24mr23075145ad.49.1761622713907; Mon, 27
 Oct 2025 20:38:33 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:37:00 +0000
In-Reply-To: <20251028033812.2043964-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028033812.2043964-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.838.g19442a804e-goog
Message-ID: <20251028033812.2043964-6-kuniyu@google.com>
Subject: [PATCH v1 net-next 05/13] mpls: Use in6_dev_rcu() and dev_net_rcu()
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
2.51.1.838.g19442a804e-goog


