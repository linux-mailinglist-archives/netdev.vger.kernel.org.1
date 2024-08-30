Return-Path: <netdev+bounces-123557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD95965502
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 04:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8BCA1F21079
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 02:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A32136337;
	Fri, 30 Aug 2024 02:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCqAEc/1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ECC150989;
	Fri, 30 Aug 2024 02:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983381; cv=none; b=fOjy5V17z2frU3sw0vtIWwUeMoyq2rHRvwUWy7sS4lleIjpqiHnXJhTaNYC200SCdP21ixlmgBAxED3rv2457VlxRjU3LFFGpCWKljT+pHC11pacxD2n9vZxlDnaNy0buwqCBbFN5ogvlpVjodDWEeMh20If+7XGsR05lieCfvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983381; c=relaxed/simple;
	bh=HohUpHwem2OONADQ04JCzDOhWP6/OBSqC2vr2UZPRQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J+5n6fSyGj3AbA8m2tXIIDtH3cPjezjoyKNWbrwzm6pdmQyIcf7LAPZn7d7oTdDl0AsdigzO0F27/sznTeFH0L1xKikUQo5/kdp9H7Ux9oerzhBBBY4Gf89P7ceqYcUCE9F9eM0WbbtegVHcwM0azNTg7r1c1qI/XICE8+iFL7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCqAEc/1; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-715c160e231so1092751b3a.0;
        Thu, 29 Aug 2024 19:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724983379; x=1725588179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdKbe1x8arQSMRU9KwRJkz3u9sBrXr6XCe4fFX8GBXY=;
        b=cCqAEc/1slIQnKmgkLf4rVmR7aMBAYXr/xXvIIkwKQ/v+KJYUdgi+NMJbmmbjgRiUx
         xdg1qjXBAqd8+zvbWvSas9NkNzWaumt8HL98qU9Pe4/UJ5xFNejDoqUBDoeYQyNz3g/1
         8ACBHSMDuuly7BO4Sz001X7IOMjWzghdG0ZOduKbeiHEuQtrXHnwAT61TwpLl3M6wuU3
         /L6w6ZUxNeljym5fYeWxEvkH/ynWsBtys4M9EwqRE7K3dLMZeqMTspV6i1SSqPncY1iq
         qLnPO0gBApCh/qjECFOPxatqiVsFL/2q59OFEouI4Hn1EcUp1og/3zsPfE2SGYizeJ+s
         DQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724983379; x=1725588179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdKbe1x8arQSMRU9KwRJkz3u9sBrXr6XCe4fFX8GBXY=;
        b=Wi7UCMbZgQtDvKCwxDBrLaTeBCc2MiE6qSZP21gZdKlyymMK3jWBqOP9ptDzpgYvdx
         l7IoNXeLR9tPk1iCf8+JsKUqisbIjStNg0/Z9nRRJHrbfuawnHkAHv42ThbSbpOH0eLZ
         DU+nmUCyn2VJUfppsBnyLkRz3fVp9auFR8Xsl09LMQWPKe31UunIDL4pGZ9QtY1QhNsS
         ke9kVYZDzii78Qum0QWO0W/BGaNVpDr9w7wt1sAPUsHIZw0tTDWRbWfYlABqmYHRku0v
         oLQ/qOr6xY4P2oqyo8fQd2GASgm1qHzmmTDgjniPYDK5XaC4p0mknJCmN/OBIfclXPAl
         bgYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe3GO2db/XMfk0jdIw61AlBdNBzfRWTmO7pU6Mz365om8vxiJPYUrgF2/iKYakK8nDNiR1gwyLgdJh5OU=@vger.kernel.org, AJvYcCXwrBXwcgd8DuR7+GyOh6cel+ubmxXQ/2DqjpozTfrGEIAZa5/vhU+/kOCqQyxVFSgtcYDdV8aH@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9sB6d7Y5ffWnNL0Bb+l+F7iZ6WHtgmk0/iy92RTcSmhd1apC0
	su28WTmiRWu3baKk1E98H/C5BYFzprosoWEIjvTO+gVAW0qcCtSK
X-Google-Smtp-Source: AGHT+IFBOlgoSaSOc2zYFG1qT4obUuiLoGEDwnXk30s6Dtq2x36HDhoyWYzOGUnthpdf/ASjnNnj1g==
X-Received: by 2002:a05:6a00:3911:b0:710:4d3a:2d92 with SMTP id d2e1a72fcca58-715dfba7c6bmr6116733b3a.4.1724983378748;
        Thu, 29 Aug 2024 19:02:58 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a6b60sm1764221b3a.87.2024.08.29.19.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 19:02:58 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org
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
Subject: [PATCH net-next v2 09/12] net: vxlan: add drop reasons support to vxlan_xmit_one()
Date: Fri, 30 Aug 2024 09:59:58 +0800
Message-Id: <20240830020001.79377-10-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240830020001.79377-1-dongml2@chinatelecom.cn>
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
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
index c3bdac6834d4..f013b9007d3a 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2372,13 +2372,16 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
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
@@ -2482,6 +2485,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 					   tos, use_cache ? dst_cache : NULL);
 		if (IS_ERR(rt)) {
 			err = PTR_ERR(rt);
+			reason = SKB_DROP_REASON_IP_OUTNOROUTES;
 			goto tx_error;
 		}
 
@@ -2533,8 +2537,10 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
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
@@ -2554,6 +2560,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		if (IS_ERR(ndst)) {
 			err = PTR_ERR(ndst);
 			ndst = NULL;
+			reason = SKB_DROP_REASON_IP_OUTNOROUTES;
 			goto tx_error;
 		}
 
@@ -2594,8 +2601,10 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
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
@@ -2610,7 +2619,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 drop:
 	dev_core_stats_tx_dropped_inc(dev);
 	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX_DROPS, 0);
-	dev_kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return;
 
 tx_error:
@@ -2622,7 +2631,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 	dst_release(ndst);
 	DEV_STATS_INC(dev, tx_errors);
 	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX_ERRORS, 0);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 }
 
 static void vxlan_xmit_nh(struct sk_buff *skb, struct net_device *dev,
-- 
2.39.2


