Return-Path: <netdev+bounces-126388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF62D970FA0
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D9B1F22E75
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 07:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5837D1B2ECF;
	Mon,  9 Sep 2024 07:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjUXx5Ke"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14811B1401;
	Mon,  9 Sep 2024 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866629; cv=none; b=iUOcjG2fm8WXZFBp1+7AeTmCG9hxjvJWjI3au62GT0U7wVFVjChYUtrpnMr2JXl/1zW9e39+ecDWKrBLzOAydRv8AGpaEnQuQuxUcaQXPrVD7f82fVW5F6JvdYsecjTtcVaWs6t6AH59IuZH2RaJ9zw1OkiAqqYHI9A+yFlu1uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866629; c=relaxed/simple;
	bh=+UXQDusghy/g3bLTxXSK04B/KrYOMSJuNULja9Bj9WA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gK3gK3fKlpEA+u95ETYcU20kjw98MyQp6UyT+z0DjVUOQju46yAQ2K86tap526gs3WB1WQnUW/DEQZ8HnwVM6dPMF+b1QxkY20tUfoOWGfBbf7kIC7+ChD32i5+G9JOjCUJTeMJ9Wg8FIC6PkfMDC/rEcCRNOGGD6/3sVjZ7eT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjUXx5Ke; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7178df70f28so3257818b3a.2;
        Mon, 09 Sep 2024 00:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725866627; x=1726471427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nCNoGwTwkgct22qV08RLoPjiywczH5fgjahOYpVHXw=;
        b=LjUXx5KersmeXRjgqaLUEbuvxPj/RXUbPf28Dto20gRUdLx5VfhC7GJMZrkV7+rmFO
         oCKQX2V06KbDfqr8lMwqA2Y+ECePKo1EAM3AOG84HRYLqQPgYXu4fBf10pkhV/Q6rzWP
         Bdu32UcimGrwn5hGSQ473QzpgED5HlSSvzENtHKdY7W8NF1IcLVjym6Tbe+XtRK10Wkm
         mu3TVkYZIW7xYg6+MC1C3M9pGc7tUNT1yB48bEPKgD8hyLH4BbEbEfHbTLVTu3y66Yer
         PNNJ28B47F6DaN9fOQyY0oVl/pzZmRQos7DsselfWxA4h7c44Nh54ynblIihUnqbhlHm
         ONKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725866627; x=1726471427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nCNoGwTwkgct22qV08RLoPjiywczH5fgjahOYpVHXw=;
        b=vg7SjJWFFK+4v1Xg9IdNSwK1YpHItGwn7jTwvIytTlDX/qtl4HZBKYnuC68q8i/3qY
         fzd5c+BnHuiAMYdi/aIkan+Ouwj1668Xh4h3zGBdWrgOkg5aWCeBosrEelyH++X5lj90
         eabRIbEiVNK5e0ZX5SCBlpdk8HoFfIPEa91ANAt946uznTK/3wvoOZIoiQMoPZmtCFZY
         lrDIj/y5I2N02I83rDCvNGzB38nQ6XZ9wO9YBHQWFIT1F0TxEwg5R82M6qjWC7McoC4W
         CE155y++ZXkOhDIKnA4BJDMkHUbpARTqiBxFgaiLe8Kw7YMfKrKmNTiBerRnZ2l1qCR9
         wD2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfCVrwgtfHZ2ePv3GbQYFJQ53L4Z6jcW3RJGdrKQuc6KPp5S0y+VEw3/IvSdGSGwgHjlQgyKyMX2jZWhA=@vger.kernel.org, AJvYcCXBX7iKY4oCWD+6O+AxDEZDxMAECm+2Qz8p+/aDiWdyT6NtBWCxjl9VfJylGGqJJu/jRC9xYyeS@vger.kernel.org
X-Gm-Message-State: AOJu0YwuqMfSk9Pq/C86SlJ/UwP1acdFlGLTN5nB7UdtaDHLR0gq8J5E
	usIHy7bzmC8UDvSe+Vso5lfoUOng7RcMAZxMoy1VJylYJd/f6v1b
X-Google-Smtp-Source: AGHT+IEVrkVnXiVYVzYylENqz9nbU231rKDlGeDVy6ZBMbC739zd80S44W3EKcuAPsVu2KxOICIwLw==
X-Received: by 2002:a05:6a00:a0e:b0:717:85a4:c7a1 with SMTP id d2e1a72fcca58-718d5f2fca0mr9273202b3a.27.1725866627029;
        Mon, 09 Sep 2024 00:23:47 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e58965bdsm2962094b3a.29.2024.09.09.00.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:23:46 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org,
	aleksander.lobakin@intel.com,
	horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 09/12] net: vxlan: add drop reasons support to vxlan_xmit_one()
Date: Mon,  9 Sep 2024 15:16:49 +0800
Message-Id: <20240909071652.3349294-10-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240909071652.3349294-1-dongml2@chinatelecom.cn>
References: <20240909071652.3349294-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kfree_skb/dev_kfree_skb with kfree_skb_reason in vxlan_xmit_one.
No drop reasons are introduced in this commit.

The only concern of mine is replacing dev_kfree_skb with
kfree_skb_reason. The dev_kfree_skb is equal to consume_skb, and I'm not
sure if we can change it to kfree_skb here. In my option, the skb is
"dropped" here, isn't it?

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/vxlan/vxlan_core.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 6f35448fbf3c..78e4a78a94f0 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2374,13 +2374,16 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 	bool use_cache;
 	bool udp_sum = false;
 	bool xnet = !net_eq(vxlan->net, dev_net(vxlan->dev));
+	enum skb_drop_reason reason;
 	bool no_eth_encap;
 	__be32 vni = 0;
 
 	no_eth_encap = flags & VXLAN_F_GPE && skb->protocol != htons(ETH_P_TEB);
-	if (!skb_vlan_inet_prepare(skb, no_eth_encap))
+	reason = skb_vlan_inet_prepare_reason(skb, no_eth_encap);
+	if (reason)
 		goto drop;
 
+	reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	old_iph = ip_hdr(skb);
 
 	info = skb_tunnel_info(skb);
@@ -2484,6 +2487,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 					   tos, use_cache ? dst_cache : NULL);
 		if (IS_ERR(rt)) {
 			err = PTR_ERR(rt);
+			reason = SKB_DROP_REASON_IP_OUTNOROUTES;
 			goto tx_error;
 		}
 
@@ -2535,8 +2539,10 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		ttl = ttl ? : ip4_dst_hoplimit(&rt->dst);
 		err = vxlan_build_skb(skb, ndst, sizeof(struct iphdr),
 				      vni, md, flags, udp_sum);
-		if (err < 0)
+		if (err < 0) {
+			reason = SKB_DROP_REASON_NOMEM;
 			goto tx_error;
+		}
 
 		udp_tunnel_xmit_skb(rt, sock4->sock->sk, skb, saddr,
 				    pkey->u.ipv4.dst, tos, ttl, df,
@@ -2556,6 +2562,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		if (IS_ERR(ndst)) {
 			err = PTR_ERR(ndst);
 			ndst = NULL;
+			reason = SKB_DROP_REASON_IP_OUTNOROUTES;
 			goto tx_error;
 		}
 
@@ -2596,8 +2603,10 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		skb_scrub_packet(skb, xnet);
 		err = vxlan_build_skb(skb, ndst, sizeof(struct ipv6hdr),
 				      vni, md, flags, udp_sum);
-		if (err < 0)
+		if (err < 0) {
+			reason = SKB_DROP_REASON_NOMEM;
 			goto tx_error;
+		}
 
 		udp_tunnel6_xmit_skb(ndst, sock6->sock->sk, skb, dev,
 				     &saddr, &pkey->u.ipv6.dst, tos, ttl,
@@ -2612,7 +2621,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 drop:
 	dev_core_stats_tx_dropped_inc(dev);
 	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX_DROPS, 0);
-	dev_kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return;
 
 tx_error:
@@ -2624,7 +2633,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 	dst_release(ndst);
 	DEV_STATS_INC(dev, tx_errors);
 	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX_ERRORS, 0);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 }
 
 static void vxlan_xmit_nh(struct sk_buff *skb, struct net_device *dev,
-- 
2.39.2


