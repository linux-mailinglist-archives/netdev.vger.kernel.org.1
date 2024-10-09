Return-Path: <netdev+bounces-133423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C8A995DC4
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 04:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBD14B245B3
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 02:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7941514CC;
	Wed,  9 Oct 2024 02:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqZcTaqk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FCF15442D;
	Wed,  9 Oct 2024 02:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728440966; cv=none; b=GisrsxJ6Lms5xbPZN/kaZCXbPuV8FcZXRWTlluivFUggTCM7ZVKQL9MoKQ7d3KHVWmSTU4cE+VCiJWO0AXGJYbN1ow0Huh3RblzaI33l9iDaIqy7Ha6p2TIOZ8N8ZBFkE7S9kLLVbAuwLiieBONauKdEIaikEQXO6wBpkbbeYOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728440966; c=relaxed/simple;
	bh=0LbNYkuc1H3teX+6zzjM43vRgSWAunIJN3Vzj/y7tNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F7kdVlurylOswSgZq4MG9ML3laqSSHI/2Bf+U0vAXT4j3QD8voDR/2c+gSOlYblKU0QXNSguhXYBkmpj7KrSVJK3vhGmwXOj2P/pxqQ4rnf4HxGHEYKdAyJRvStel3aj30NOl+9+oikuZ0+XIMkFKfj25wt1qqofqdpvX3rfo4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqZcTaqk; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-7db54269325so5183011a12.2;
        Tue, 08 Oct 2024 19:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728440964; x=1729045764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhsBrLEykAKb69NSSERrjcYKm3NYONaRl2vIIBwztDI=;
        b=iqZcTaqkCU1cwLw4n9Um65OpuBbCu2a/KGPq7LHrBkH6yDOfwqyOhqcl2oy+iYtn+o
         IF4oru7sGKtOd5AhWr/2+uJU5EJcPuf6iLMXTtEt/xfD6W4B2ZNGIDhlDQ8L8p6L6fmN
         AUbSi9NSOV3jA8yqzJw5VPMBLv+owYMrqx9kY9oFO0peJnf1yso3BU4DPVkSlpL+SaGP
         v2+mkivG55YpzuuAzwruTqMKGjsWb/djSCJrcSrby5f8ywtCEs41t/JY91iq53kJdny9
         de39uPPpYoVFtMQcY8W8+PjicnN/1DVGEmbBOE2r2pz3lU7UlWZR9SGVvvBSYTfiCHws
         cDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728440964; x=1729045764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhsBrLEykAKb69NSSERrjcYKm3NYONaRl2vIIBwztDI=;
        b=YwFlkR718ixu9PwDlc+wk1HnBhCW/X5hDVyLCE3nk6Ydj76bZTg9M6N49/fs5nGJn7
         6CiVbbiiBejqUHDW4jMFdxf6QJ080nNa5B30pklrKg9uzSFmxVae5aQVjKdpp06WxRjE
         8zhavuowFNKHOq2InZ31Z1ayqdWbLsSmRenc8IkNfZTHGO7sdAQzsHV6Wl9aQ1gV65jl
         Rw6pqDxuChrHm9IoxH5TcdGDQ2Qz+Vf1bD5LMDokIMWh2bN1BMI8KzD11fsSPojHmTdG
         lEGXKtYzUHyhm4t0ATg78GJ2+d9s3z+fpLSa9xbVhuEPLah9UZ2T7a6oGsVlFPJ0bM48
         HsVA==
X-Forwarded-Encrypted: i=1; AJvYcCW/1nGz+ZXO7+2PGwgyCqYC8ABvi75DqEstCSnFZmLRPU1Zk7pGUAqnBZrrUw0TIf9jAaiyIQvH@vger.kernel.org, AJvYcCXQmJMK+luLiUCOCKOM/gqy88Txg3wf5tWIku1+5UOaxNUx1g/mvKI4hz6nh/HuT9ROpMAvk8y6CxmOf54=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLAmjaTnhS+iCoVj77koYDIPI8SrPomALvrhOTPcoB5uQ37/U4
	QcLB16dBPtquZnZaBzDi4gOjq9RyBiFbhZAZRXwovtVGUo8Aenhl
X-Google-Smtp-Source: AGHT+IHrOp2P6t+eOIjbQ1lt/3a1OJlLyJhfijDcz3Cqbcvdy3lLD6Ln6dw1DVNpI+QmJqELMu3eEg==
X-Received: by 2002:a17:90b:1295:b0:2e0:8bf2:1d05 with SMTP id 98e67ed59e1d1-2e2a2563235mr1209148a91.39.1728440964242;
        Tue, 08 Oct 2024 19:29:24 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a5706e8bsm336202a91.18.2024.10.08.19.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 19:29:23 -0700 (PDT)
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
Subject: [PATCH net-next v7 03/12] net: tunnel: make skb_vlan_inet_prepare() return drop reasons
Date: Wed,  9 Oct 2024 10:28:21 +0800
Message-Id: <20241009022830.83949-4-dongml2@chinatelecom.cn>
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

Make skb_vlan_inet_prepare return the skb drop reasons, which is just
what pskb_may_pull_reason() returns. Meanwhile, adjust all the call of
it.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v5:
- make skb_vlan_inet_prepare() return drop reasons, instead of introduce
  a wrapper for it.
v3:
- fix some format problems,  as Alexander advised
---
 drivers/net/bareudp.c          |  4 ++--
 drivers/net/geneve.c           |  4 ++--
 drivers/net/vxlan/vxlan_core.c |  2 +-
 include/net/ip_tunnels.h       | 13 ++++++++-----
 4 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index e057526448d7..fa2dd76ba3d9 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -317,7 +317,7 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be32 saddr;
 	int err;
 
-	if (!skb_vlan_inet_prepare(skb, skb->protocol != htons(ETH_P_TEB)))
+	if (skb_vlan_inet_prepare(skb, skb->protocol != htons(ETH_P_TEB)))
 		return -EINVAL;
 
 	if (!sock)
@@ -387,7 +387,7 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
-	if (!skb_vlan_inet_prepare(skb, skb->protocol != htons(ETH_P_TEB)))
+	if (skb_vlan_inet_prepare(skb, skb->protocol != htons(ETH_P_TEB)))
 		return -EINVAL;
 
 	if (!sock)
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 7f611c74eb62..2f29b1386b1c 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -827,7 +827,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
-	if (!skb_vlan_inet_prepare(skb, inner_proto_inherit))
+	if (skb_vlan_inet_prepare(skb, inner_proto_inherit))
 		return -EINVAL;
 
 	if (!gs4)
@@ -937,7 +937,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
-	if (!skb_vlan_inet_prepare(skb, inner_proto_inherit))
+	if (skb_vlan_inet_prepare(skb, inner_proto_inherit))
 		return -EINVAL;
 
 	if (!gs6)
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 53dcb9fffc04..0359c750d81e 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2356,7 +2356,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 	__be32 vni = 0;
 
 	no_eth_encap = flags & VXLAN_F_GPE && skb->protocol != htons(ETH_P_TEB);
-	if (!skb_vlan_inet_prepare(skb, no_eth_encap))
+	if (skb_vlan_inet_prepare(skb, no_eth_encap))
 		goto drop;
 
 	old_iph = ip_hdr(skb);
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 7fc2f7bf837a..4e4f9e24c9c1 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -467,11 +467,12 @@ static inline bool pskb_inet_may_pull(struct sk_buff *skb)
 
 /* Variant of pskb_inet_may_pull().
  */
-static inline bool skb_vlan_inet_prepare(struct sk_buff *skb,
-					 bool inner_proto_inherit)
+static inline enum skb_drop_reason
+skb_vlan_inet_prepare(struct sk_buff *skb, bool inner_proto_inherit)
 {
 	int nhlen = 0, maclen = inner_proto_inherit ? 0 : ETH_HLEN;
 	__be16 type = skb->protocol;
+	enum skb_drop_reason reason;
 
 	/* Essentially this is skb_protocol(skb, true)
 	 * And we get MAC len.
@@ -492,11 +493,13 @@ static inline bool skb_vlan_inet_prepare(struct sk_buff *skb,
 	/* For ETH_P_IPV6/ETH_P_IP we make sure to pull
 	 * a base network header in skb->head.
 	 */
-	if (!pskb_may_pull(skb, maclen + nhlen))
-		return false;
+	reason = pskb_may_pull_reason(skb, maclen + nhlen);
+	if (reason)
+		return reason;
 
 	skb_set_network_header(skb, maclen);
-	return true;
+
+	return SKB_NOT_DROPPED_YET;
 }
 
 static inline int ip_encap_hlen(struct ip_tunnel_encap *e)
-- 
2.39.5


