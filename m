Return-Path: <netdev+bounces-132472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71800991CCF
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 08:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 830ECB21985
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 06:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8A116DC3C;
	Sun,  6 Oct 2024 06:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lviuPNLt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739E0249F9;
	Sun,  6 Oct 2024 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728197826; cv=none; b=WUks6n5u3P+H0BBIyHnmG2zbpYjm9Bd1dHvTRSTR+LJuoougzz8+5q3bVFS+/6jVyry3ZN9eTHG+0CxsKQ9ORbR3xgkkKtZCDqCZTZjtGDkF7/nrOLUAu6do9RxHczsIE/330NcM+faVtLpRA9fOfMKS9ahVb5srDtlpGQcjAL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728197826; c=relaxed/simple;
	bh=0LbNYkuc1H3teX+6zzjM43vRgSWAunIJN3Vzj/y7tNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LjxotMtLruOx3VZgS1vaFdMyL+5nMjPnPIcGPmP8oSTg0vwodQdkDbA8nBpJIpCTYSi6FcyQNYBjRcXVnW0tZubg3Cxq/YxTgVhKYW9SplZPraFLyV1EzM4a+E/VYaVXkQejfT/wgQwh+JUyPymnq0neA+2a3n4/nxdMSMhvw4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lviuPNLt; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-20b78ee6298so21825345ad.2;
        Sat, 05 Oct 2024 23:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728197825; x=1728802625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhsBrLEykAKb69NSSERrjcYKm3NYONaRl2vIIBwztDI=;
        b=lviuPNLt3IKEuCuxJVVlZo19Zt6u7dkvCXMIrbkuUojM6D6QiLtV5GrEiStLdzVvih
         WkOZm0w4DrIeqiuoDu8XEy9gn41UL/W7G4+Ap9aUYNXUypAVn6l/OIGuKeo25ZnOPmYS
         GgdwVtp6osHCKIv4WPJabliM3PlkLStKGoIKddzYsNzovUgYHZguS3eMLbk2apAJRy0h
         6UX2sR9gU+ouwr6nqHzM3GnK50BYZJg5b8b4OZ6HtXpHi5EK/i8sQQrgyxl8Nwk0UsV9
         I+omqI2lOfH5a37FdcIo0XF88jmZJ95iThX6vkpYFrm0ASc7yxq/FXw6z5Y/Jq+jfHzf
         roSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728197825; x=1728802625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhsBrLEykAKb69NSSERrjcYKm3NYONaRl2vIIBwztDI=;
        b=U85OkXmQRv/TO0G3HYvCpQqZPDs/Mo38Om+NSQv+hN6Xdvr9+xF3kGjR/tnDC9Bn5G
         2GF1Yx/JeklxajvFynZoTwjgpHaTHdVo+ReuNwCW0hwQAwMm+edSJX1HbOm3MUKU0l5B
         TJ+Q49Qp0VTT0i/YBti4haok13+zbQ9yk6iUWqtrspqhFoW0oeJL2UKgQyCUOcsP6cFw
         2oRnx3mqRoA3tJKVd97qhep/+tv4+8hD04q3TN0eFC8cbDRiBQDK0+JHL0/9AcIpJ41S
         BJINkrnvnHHDLGtGDRGMvjNLHIcX8lgBvS9msA+tyaVLPkueSJhLmicWDgOg+y3krOH4
         0OYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9P+9JhXXczMi3X1HmF0HoyqQhaLdr4oBb7TlIBm4tfAcPpmCCJ8nGa4UDR9s6+uuQO/K5tDlxn60KCVA=@vger.kernel.org, AJvYcCXahWe7jEC2oxpQ27UifZnROO2fdf6XiOOkkAdphRj6NQYrKtOLEqa03QyL2QS02FE1NWAvLhbI@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp9MKSUtP0ssBVk+QZtWuGAqmiO5NqzwXj5QiY+86Ai0wIm14j
	A7mBczNl7POx+4x8Oi/yeAz2F20dYyQBXlIE4AznXfEYDHQIr2/K
X-Google-Smtp-Source: AGHT+IHNbLfZqI+v2NrvEtvMO+odpAfD/JZS/c1dZ9oH6s55C9NnDTj4lq2MfD5wyO6VeEsWNtg4Nw==
X-Received: by 2002:a17:902:e849:b0:20b:a10c:9be3 with SMTP id d9443c01a7336-20bfdfe4834mr136171975ad.21.1728197824770;
        Sat, 05 Oct 2024 23:57:04 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138af813sm21749865ad.9.2024.10.05.23.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 23:57:04 -0700 (PDT)
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
Subject: [PATCH net-next v5 03/12] net: tunnel: make skb_vlan_inet_prepare() return drop reasons
Date: Sun,  6 Oct 2024 14:56:07 +0800
Message-Id: <20241006065616.2563243-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241006065616.2563243-1-dongml2@chinatelecom.cn>
References: <20241006065616.2563243-1-dongml2@chinatelecom.cn>
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


