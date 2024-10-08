Return-Path: <netdev+bounces-133138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C8799518C
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD431C2551A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58931DFE27;
	Tue,  8 Oct 2024 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Huv+RGvE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558121DFE25;
	Tue,  8 Oct 2024 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397460; cv=none; b=k3GUYZlcjJ3/QSeBVDzSmKCeybjCn6aUtfq4vhNHXJtVh7MV/ZFG+oCG5qKIE2q+M0X7KWUISLTl/XqEFgBKdf+QumNZSogEgSpptvLy/QIou6bTYzz2pH/HCoMNDyPisZspa3cdE2GHp4gNsJFromg6MHxY7mHuDc0oUXR+kIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397460; c=relaxed/simple;
	bh=0LbNYkuc1H3teX+6zzjM43vRgSWAunIJN3Vzj/y7tNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UISG9w7Ovaj62a2FSl/I2djznFnR7tVLXLOere5LX8G8xtyHjF9yrZ4ivYCuWK7QU1StH8krLupWBxr7sPsxGaqKulK/G930vguef6UC5c1ExBerCt648eJgt9FkeTolX52IL9UCiWFXr9WmJ4jWEGkmPOsXsBqGeF2BlrChXQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Huv+RGvE; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2e078d28fe9so3920108a91.2;
        Tue, 08 Oct 2024 07:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728397458; x=1729002258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhsBrLEykAKb69NSSERrjcYKm3NYONaRl2vIIBwztDI=;
        b=Huv+RGvEWARXlDHZVKVgoPsEnSa3NgJmaIStCUeSuYzp+UE4owPPRAWOBXePaVUEzm
         fLd+HsUgiDal7NksdHV6heJ9/+KOFMhzgPOGQZ0PWDdzcNBSpAAVeu8NHJRkmKf4DqMU
         umjZAMjy1E1K7fH1DEUOKwtfwbEJoKpIwfWkQdXq2QbmBTqYjs3MxuhRwCRRmcE1dCWs
         cGYIYu1QpVsrrRFc06/xGHGrQqsT1qm3K6AEEzjKBxj+MfXQBEsNJFq4tgSFGD6h2u+H
         gSpELC4dw+4xLxAbAzF2e5cVsih3Dt6dDK/kr5StOAwD9VCkMrE/282O2sVapGxWst0M
         ejdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728397458; x=1729002258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhsBrLEykAKb69NSSERrjcYKm3NYONaRl2vIIBwztDI=;
        b=kmDdqwrUwmnilg+tyxK3uHP72qC2z1AU4po6YFd5gDVy/17UDkYBsoRCj+DuEAFcRs
         Lm1BaJV4szmJToAusie4RX/YPTiRP3Ya7dvAHApnEZNWVvbJMy7wz/rFHLlXNafDCjgk
         S8GzanOuMullV9TK+OLeq/NfhHK2on2zpvhXp1Co5pl3V2ASDol3nRSsd9OJAWQJezh+
         +ZIgbLa19irQDotNLCsjdduhC+i2zgBUL48hPO4aIg45OTooqV3ErbOOS4Bi+MjTa3dh
         z/hWv0IGRjr94KjBGgAnZUKtz+K9wXkerqqAngM7AP/GXYkHnFYmXL0VsppZ1na4tsxx
         sMug==
X-Forwarded-Encrypted: i=1; AJvYcCV9pSF6km4+jAgb0nn2J3yJQgYd01VgAv6eUJkW/SN236XWic2jQ2L7NMCMjcK/aRDlAGqatFzz@vger.kernel.org, AJvYcCWAVdAU8GNAjFUHbM601DaEut299+Egnyd510/8EnDMKCz5UYStreQxOjkKghnDvgfCoSCBjKJXK336cPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRy0lk69V3t9hytyxMciTF3v9b2Qpruh0D8K6Tq/Jf/ho/EEuA
	RtRcjDn6Qj7MdpubpRqoYTB28JdKLdWpgoC8xlp4GJEbLEHKZ3tW
X-Google-Smtp-Source: AGHT+IFfT1yusRFFBUbqO6fopPEa2Seo2/HoTTKsMfP0htTnanTBbl66j9j42Q9qjUh5OP4V8Wz3cg==
X-Received: by 2002:a17:90a:4a8c:b0:2e2:8f1e:f5ea with SMTP id 98e67ed59e1d1-2e28f1efc06mr1736973a91.1.1728397458510;
        Tue, 08 Oct 2024 07:24:18 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b0f68a8sm7675987a91.36.2024.10.08.07.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:24:18 -0700 (PDT)
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
Subject: [PATCH net-next v6 03/12] net: tunnel: make skb_vlan_inet_prepare() return drop reasons
Date: Tue,  8 Oct 2024 22:22:51 +0800
Message-Id: <20241008142300.236781-4-dongml2@chinatelecom.cn>
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


