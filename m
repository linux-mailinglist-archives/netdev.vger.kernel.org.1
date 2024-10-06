Return-Path: <netdev+bounces-132478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA54991CDC
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 08:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A71282C67
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 06:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C197716DEDF;
	Sun,  6 Oct 2024 06:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tq8FSqES"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F80216D4E8;
	Sun,  6 Oct 2024 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728197870; cv=none; b=gXFoUBsXcyHk8oV/U2Ew7nJHvnc/4ouEf5fI4KIAOc+kqBiIqws5qHiaXMyzpnZGdevzj07xsnTIHzjUuZs81niAj4KAFp+R+X078H5M+fxuJ7+WI307i3bO8QslC7NFvxQgRodsIbvIE55YD9B7a5cTvpb+SrQy/hPS6uV2/Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728197870; c=relaxed/simple;
	bh=ZX6rpV2p4NCjpSh/ZKSJ+9hBSNtbI+i1jkrQAXbqfxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tT8ZHoUy3VjH0EwOAbJijwAXrk6p9ossY5kEC1gpGh2F2W1zpkmr4Nc6ePkATVj77zFjoqT9/FnMN/TJE8YHnfU58DE8iKypxsZIhQr4FmDNJHdnA9MX3hjlX5Pi5/MFieOMxAQa0GoHcE991O7rddKuaIJx7LyPsTbOuXkXjNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tq8FSqES; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-7e9fdad5af8so387425a12.3;
        Sat, 05 Oct 2024 23:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728197868; x=1728802668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbb7WoMAUR4wBk7UiHJwsRsFkglFtN6iutr69JSzLxM=;
        b=Tq8FSqESNhDt8k6TPSC+RioBpB3N2mxqR2gZvmwiehe/gq/0IQ+wqThIuJdJbMGVjV
         kVelZ3AraK3hNl5VP6CKcx/9g6N8A46aaozQuLqxMdMznAz1AJC0NrQdXNYSn8JVM1/y
         gW9TUg6NeYg9H2XdTjKHmbTxB0yMUSWjQcO1vI+1S1kkikSZn7CPz7e2PdLp+CVX0qwt
         JybeLzSNlKCoO1g/W3oLLkFezmbeJU5ci7Ngxp8l7I1DMBz9N9MEk5Cdc7Ywzn5y+tzC
         UeHMPj+SOVFebNvTFBdEkL8F9OyonCCqFNeRU3z8CdR0yYiSZHcydfL6SC+XcfcqP6uh
         LTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728197868; x=1728802668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbb7WoMAUR4wBk7UiHJwsRsFkglFtN6iutr69JSzLxM=;
        b=Jso9jCIjTcowoZHaazu8HZDnN7KYVB5s/4XIt3skqBv+C4T5WMufBGqn8RxJQWvDEH
         iOIndC5C+B8c/GexGnThnSMWdDu2MoVoucjFHHpu5qEDbX5qyOZZfqB03/dIsXUStFaU
         xdrLpGiQY27RmnSvsKO4ZKtMn13Qo0y/C2JxtwUoua0gIwmr0RRtJxQT36t/XQhhvt9V
         Yt+s9ODoINUKfyj9zsMc4GIjG3jDRFRmCDseAGt2Qww0d4f4tnDWTCahg+DgUyCysxyl
         myTv7w0PuLtfk4hQH5mDDcmGY3JJhwJhZGSxG0HLWTQ9XESyHRPMOFBfX/eX3xkP9DL4
         fZ/A==
X-Forwarded-Encrypted: i=1; AJvYcCWWUCtCeii+AtObL+bbd+k72if8Xlmd33Wx17JHgBbbnigqDu5DRLTuYkLBliLQ7wc4qnqKouM1DYq/nHE=@vger.kernel.org, AJvYcCX6kKwHxLcqm/4q4hyKwtSoqr1V8KiSnhlbMINoscLjuOy0UDE6x+V8nQeo2Dy23P6lM+wntlzC@vger.kernel.org
X-Gm-Message-State: AOJu0YyJyoQqYgH4y1x/wvBWc4W/1xToloRvy9JTAgXEyG/EDsPrMMiB
	6s7ImCYh75Zye8xYjd5CEz6G7LTepejhRymejTWKfHb6/p/qLrtr
X-Google-Smtp-Source: AGHT+IH/4CPkp5sJFNk+kzSowYbzr1jK4IfSOz7gEMXrzQJVKLMO5H9EdxmPhvZOkOT2pLu/z82oTw==
X-Received: by 2002:a17:902:e88f:b0:20b:7bcb:5c5a with SMTP id d9443c01a7336-20bfe060515mr125561455ad.16.1728197868570;
        Sat, 05 Oct 2024 23:57:48 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138af813sm21749865ad.9.2024.10.05.23.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 23:57:48 -0700 (PDT)
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
Subject: [PATCH net-next v5 09/12] net: vxlan: add drop reasons support to vxlan_xmit_one()
Date: Sun,  6 Oct 2024 14:56:13 +0800
Message-Id: <20241006065616.2563243-10-dongml2@chinatelecom.cn>
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


