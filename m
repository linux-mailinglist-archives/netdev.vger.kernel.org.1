Return-Path: <netdev+bounces-130736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CA998B5BE
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 09:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7794282B28
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 07:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D661BDABD;
	Tue,  1 Oct 2024 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSgrYWJk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8861BDAAE;
	Tue,  1 Oct 2024 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768131; cv=none; b=u1iOXIHhtPc4OIZw+HZLnQ39Nqw37xYOn2YXL62OR+XtK4iVpB4SPYUsqaQ9MpLshyzxa5QLaeW6aeTHVmWaZ7AoTzp8kG9OqsiON0zM2wX8fUGUyesCaC2vVDbdUOyy2uQfWKZ1iW6FYxFP7nqltrxjpKm6e+PZnG5j4XSdtcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768131; c=relaxed/simple;
	bh=Eskjt8/K3RvO5IWzw9f31qf5TKx1X5OJbbSPCQDiH2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bwGAJhncO1GsfFKOQcA654sL15oRyNCGacNWij72bVMaovzx+jDiTmPthK9z226c3WgldjiPZyVb7/ywtkjiFLDMHk3A6IgroybmP/kB4yLJCvuei5UDodCmFUMNWVqKyhl0lBmpJbOoVqyaqJKA7NGIFNMtZI7UVNKk9/yonKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSgrYWJk; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-20b7259be6fso23193185ad.0;
        Tue, 01 Oct 2024 00:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727768129; x=1728372929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLFnOLx3trBv+pZcU+bR4JnQLj28jgmaQYcai1NCZuE=;
        b=kSgrYWJkP8M+kPC+W90cu4/p3g/cJmNBZf8pmWodltuRR2fM+m/fh8ZPEqnzszZ23F
         1uhys+4z7aCDVXiOfmlcCDwLHCyMw+JwSxwgI/wM1nga1g9+wOIclC5nrcAarNY0e57I
         MWdshIJOVuPb25m5Hdb19zf7bZ4VnQmNhp15X5NN0TkVJj1mSOFOF4LvchKzy0Z4cA3Z
         SBmoGWP+2r29a8nA2kHM/84I2gDGTLIic/V+LK90IWHI9l6AwtXtxtQjykgCA5jxTqZm
         VI7GBz8PKb1N+ovlk9+eJ6fOCixv6NpyujWkItYBIFYqRMppwlyCUmXAGErZ6ebEJTu1
         CSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727768129; x=1728372929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLFnOLx3trBv+pZcU+bR4JnQLj28jgmaQYcai1NCZuE=;
        b=qVswBoMKgY0Q24UR1TypCx3C6ieOK7Wn80x6Zu1JYRDH3+7ifcx8/2XU02JyAXqBeo
         AoNRBZfRsFY8k82jQ+sJ3+Y9nMEzPHH2MsuN1PEtkZCRe95cxOGLh9th8Je5/chTCM4K
         LUDqcRqws+1mMCzSW1Xb33dt2X6RZ3QTv6NhtcRuOCylheneu04KkA64LbqhPt4ia2Ye
         Ifrt2OD4T19/V1hsdIewdGLtfWQ7RmW1k/y+HxkGl21FyJis3jLm0TrL+H1SAudDEgZm
         g0HHoQLc0G/tBYLxnIkqj00KdyXlAYhnZHeFTv01xecO+iqR13PFHroeHbsltUnU6SOK
         7gAA==
X-Forwarded-Encrypted: i=1; AJvYcCUsyfXqWa5r2Zhh/F0Kezz8dG030eYOcUChU8dbtPr8/VId7QbZ61KkrLhZAsUDSmSLjYh0mZFzHI+TcQk=@vger.kernel.org, AJvYcCWdl4j1zguDhtsgkilzpdBxUphChhC+sSQMHkTDwmQmyQl1Z6sIbAKV3oNc6rMQ5DAHQYFQD8FU@vger.kernel.org
X-Gm-Message-State: AOJu0YxBJS0Ql57AW7+Z2yS0hMMqSARxYwo5eLR4+9s0o71aDLHt9Sxw
	AfkNc9+yzyw1zRTCFVbbDO88vGwNujIfKX/gnRgkb1XDNwrpJbhc
X-Google-Smtp-Source: AGHT+IGgvUBybK7vqZkWyhPGfFUIzCMqIuKjWVNutuCvf8UTmwfBRlRIvw3DkvyKLCfOe4rH9uoKkQ==
X-Received: by 2002:a17:903:24e:b0:205:9220:aa37 with SMTP id d9443c01a7336-20b378623bdmr223266225ad.22.1727768129282;
        Tue, 01 Oct 2024 00:35:29 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37da2667sm64545575ad.102.2024.10.01.00.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 00:35:28 -0700 (PDT)
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
Subject: [PATCH net-next v4 09/12] net: vxlan: add drop reasons support to vxlan_xmit_one()
Date: Tue,  1 Oct 2024 15:32:22 +0800
Message-Id: <20241001073225.807419-10-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241001073225.807419-1-dongml2@chinatelecom.cn>
References: <20241001073225.807419-1-dongml2@chinatelecom.cn>
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
index 3dc77d08500a..3da3ea27d3af 100644
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
2.39.5


