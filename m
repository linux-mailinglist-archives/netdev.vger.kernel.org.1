Return-Path: <netdev+bounces-133430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B60995DD2
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 04:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0A31C2168F
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 02:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9323417BED4;
	Wed,  9 Oct 2024 02:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPQ0htWQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E8C17BB32;
	Wed,  9 Oct 2024 02:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728440995; cv=none; b=JGvRf8Ymnb5xgIxNY4gx2D4eg19ITpkNGsW/9/Jm6gkQwygVpZdd66Ea7WNOjauh5ynvdEEDWu+K5uwfRurdfihsMeWTZi1knU6qK3SxLWBacqJTEvRFjtAWgmJBD/PUGLlXepKBOfUTG4b00zK0G46MFw1tZQ0hEwWKKIIJNis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728440995; c=relaxed/simple;
	bh=ZX6rpV2p4NCjpSh/ZKSJ+9hBSNtbI+i1jkrQAXbqfxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oTOuQbmZdwmOsNqaByYrgubra7HRcgs/Iuxxk3m8MEq3e9z44Yflw+7Vg8LLcHStB4yXTe+L0zejSE34ZhiHNPX2/QDGkalt6mXvUkNWW9SYjGNqEu3O0xWP9hbZhDPZ5bok9zkuTVr4OG3u1rPNVBHM1p2nD5rbIywu2nSxRBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPQ0htWQ; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-7e9fdad5af8so2307354a12.3;
        Tue, 08 Oct 2024 19:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728440993; x=1729045793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbb7WoMAUR4wBk7UiHJwsRsFkglFtN6iutr69JSzLxM=;
        b=EPQ0htWQe9GiDMDtgyOlhrjTpPxplULVRB11JnfbEJysR7Xg7ZMZzv36XL86vpzg2Y
         5cM/zHR+gw7NOe0JcgdbXTSv1Kdso2aAGh8j2wkK4dZeLZVjqu2jHtTHxyjuit7cfGS4
         tLNWmGyUMcVWJpoQNpN3ohSZf0Fit2+XILK+h0yRVTbDjJSBsk+tNtj7etAPRtb4nAfu
         RrO7wrd0R4SX2wy/NQj1Yqh7EbOxRc65fRWc340gMJx0N4w8qK/7T8TLhkui723Mf5zx
         EBJhYn5VWTa+bVW/LkXegw/ReUfLefsaPQ3JGoz/c6TOY8VakYSrntypAI8yy8XTaAg7
         kE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728440993; x=1729045793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbb7WoMAUR4wBk7UiHJwsRsFkglFtN6iutr69JSzLxM=;
        b=FcWBMOZZT1IQf42e83hrT+OTaR5Zy3gSARRQvTO2L/eestku8A0gRBhXXTZgxVFTpw
         y9Ax2eSwIGClQ68Al7yRK/9jvy7moHzYdw028VNcqe4prEwVLf5Bct8SRtvq943de+/0
         AgYHIBxeoZQyL8Xx8UgBxLxX0cxZDe9x26DwcDjshkIwbPlWoJn4KPP3OAbRUN8OJg88
         426wPhuWCh73fzERKSE2VKnHdVLTMx1X3Xk1SLth0n29YccNLsd5fbBw4PoJlbW2bxqL
         y/UPJV7lvAZ70cEye4FCGlPq4UWeOzxI+paSrQ9I3g4MJ7dckGEALsKBY3DpXlMGEbZZ
         3Ozw==
X-Forwarded-Encrypted: i=1; AJvYcCV1nQBczhRG1bEkoorYNi4mq1Nl425dbmbK8nan5cd/KJUgMpCB3ldsIq6o8QsNfdeBhuejn4K9@vger.kernel.org, AJvYcCXPrAOCTDjy4e0IzuhckFhp7fHUVweWHmHvimUDOXfM59CDAM+ZV5QUtTNaDr9zPOfwdnxlkEa25bRHYBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysz7GRNsJQ7sP8Fe70vy6ZL0S8Jx6UfTzHeG/j6zEAb5LTsFjT
	UVamjSyqjOuKwGCWnjRvF3ARSGspRaEHWASvPzG1ta45EFGg3GuD
X-Google-Smtp-Source: AGHT+IFi3yVvPHZm2BOO4VxyWCdAAXZmT2MN/RZm8AmD+sj/tKxtLFQiULKpApXUlxpsPQA4d7ib7A==
X-Received: by 2002:a17:90a:f02:b0:2e2:991c:d7a6 with SMTP id 98e67ed59e1d1-2e2a247aeabmr1108840a91.19.1728440993425;
        Tue, 08 Oct 2024 19:29:53 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a5706e8bsm336202a91.18.2024.10.08.19.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 19:29:53 -0700 (PDT)
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
Subject: [PATCH net-next v7 09/12] net: vxlan: add drop reasons support to vxlan_xmit_one()
Date: Wed,  9 Oct 2024 10:28:27 +0800
Message-Id: <20241009022830.83949-10-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241009022830.83949-1-dongml2@chinatelecom.cn>
References: <20241009022830.83949-1-dongml2@chinatelecom.cn>
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
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/vxlan/vxlan_core.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index b677ec901807..508693fa4fd9 100644
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
-	if (skb_vlan_inet_prepare(skb, no_eth_encap))
+	reason = skb_vlan_inet_prepare(skb, no_eth_encap);
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
2.39.5


