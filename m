Return-Path: <netdev+bounces-133144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5F999519D
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C011C25502
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD2F1E0082;
	Tue,  8 Oct 2024 14:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J35BBkPr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FDD1DFE34;
	Tue,  8 Oct 2024 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397498; cv=none; b=VUei5DgRkx88CJKH2LJztwUUkFEavRvVm+fUnq5xKou2zXwvRK28c//69BbjqdZ8cFxHno8kG351MTBtGxqVzA+SIMsCNrXQqCdGCC6N3grO3Ff4KTl5MXtVApJucFlwKUR8Q/vUHonuyMj9ylLajILdfFPphoykCWBk/1zXcqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397498; c=relaxed/simple;
	bh=ZX6rpV2p4NCjpSh/ZKSJ+9hBSNtbI+i1jkrQAXbqfxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a7TLwmQsqipwKrtYWw6rXFgIkqa6ki2kU5PoKuUDPLwRu6MMfqLaaBJdvmKiEG4nvQZ/6lFr51uwN/de66iPbF98vhIOmgPATVaOUebfpuOi5sQTRXJJi8ZrFeXGv4n43MLrX+mktzOjOkw32ImEa0EP4Sc7cXNm6HZF5dQyjlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J35BBkPr; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2e07d91f78aso4180956a91.1;
        Tue, 08 Oct 2024 07:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728397496; x=1729002296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbb7WoMAUR4wBk7UiHJwsRsFkglFtN6iutr69JSzLxM=;
        b=J35BBkPr2dFARJ7pMqKz70iP4MAGkDbyfs4NIztUKcHPQx9i+cF5VHjkoRDhmRABgc
         xYqhC0CdeQVDFCmc0XWMBdtyMjwLnvKHCHSnNKGd+HMMZJIoiBfC4Lur7SlMI9K6C/1o
         HMYRU9ylxD88Tl320ZGmH/Ouwk2Bd94Hs2bmVv3N1AsEI3y3UXKhfKjZtdYpMfggeEYS
         ViyRXpuMgaejyQGvzejHOywzXOczr8d3C1WiyiC4pZQ3kD1gUog1Pzv77udV3IS61Y93
         3zwo26+lYe4nrbTH9Zx154QgH3eVPCi8/cEyynJfEzCgIxRKAveMVPKLJxOK+X71vSpi
         QEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728397496; x=1729002296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbb7WoMAUR4wBk7UiHJwsRsFkglFtN6iutr69JSzLxM=;
        b=krgl22FRNi73vC/Mr1ph3awZzxrnupTWcYMeEmnxIIWZXY29C0UQZkTUhUSpwBZfW2
         XSUOLboDj4V+uQtSQUBHFyCp72WDfR7lOpXSDruRvUQDZsLsopRwtLqHUaaOMNgBepd7
         3dlqlthSRcn5181BHWPH0pDvpNKK+FAP3EvTR8mZV3loYO5mQ9TSHbuZBliRyHpcBZXb
         +SuA7daD5lmcAtF9dJbYcXuj4dFMd7R8qbvZ7Ikkb2K1RbJRW/fgBO7aaz0X51baLkm8
         pYNPStirOgEEGU2M7mXV3fEN4eUnPfgsklRDTEX6nvQBmoeh5HCAGmTMkpwo+9NjYv3s
         nnpA==
X-Forwarded-Encrypted: i=1; AJvYcCUxmqD3Wx+nbFt0fGqjpV/TX6FqVJMOkvrNTvvhk5LQKUXCXnIXFIjyX+tb2npVbGCHaADr7wx3@vger.kernel.org, AJvYcCXTYj9/6INSGt49YG6aAobw/Gq3rPoivbylKyxlqIS5Ha6nXD5nUh9qzbIIh4x/IS+h2uo5gQJnw9QrehI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWjqy65DdUJ6QrYcBp7PYVvhTaKf0Cy6yU/INCx+sivVDjOCvr
	6LhG7y4ofnJt6A0H8yMiFgdDS9GJTSOPASyWZRNVotR6AenofS+o
X-Google-Smtp-Source: AGHT+IH2W7wHSG8PaTX6nFXJzwoyViApSjFxA09Y6xIr0Tt7JpquCVUfTZHCZOG0Mi8skmTn5ZWB0w==
X-Received: by 2002:a17:90a:db14:b0:2e2:8d7a:f1ba with SMTP id 98e67ed59e1d1-2e28d7af415mr1743207a91.2.1728397496553;
        Tue, 08 Oct 2024 07:24:56 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b0f68a8sm7675987a91.36.2024.10.08.07.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:24:56 -0700 (PDT)
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
Subject: [PATCH net-next v6 09/12] net: vxlan: add drop reasons support to vxlan_xmit_one()
Date: Tue,  8 Oct 2024 22:22:57 +0800
Message-Id: <20241008142300.236781-10-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241008142300.236781-1-dongml2@chinatelecom.cn>
References: <20241008142300.236781-1-dongml2@chinatelecom.cn>
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


