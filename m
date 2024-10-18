Return-Path: <netdev+bounces-137009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915DE9A401B
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 15:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB62280BE5
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 13:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7641F4283;
	Fri, 18 Oct 2024 13:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2Bty4jf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2591F4275
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729258537; cv=none; b=jhIc/oyTR9uqAiG3DoL9J8QqYi7gTEOud/B4L9JLxIyI0yELrMTqDQOBmYUJ2FjmxREnmJg5f3m8sfeirHdo16h1T3kVqUcrKPkO8/RL0xRpKK3b6A/P2SR/MeN3kOGClc6JKakjiz9/S8oLzieMGMt/lV6MIokOD8303ElSdMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729258537; c=relaxed/simple;
	bh=CjALdrYO/VB8v1vZmpYg2Mi2bXcJUQqYnFFqZDOF5GE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l/gQ9L19y4Q7ebuzzPwLC0/xurok/vHq8bFAGNIUi3g9BfydRZX+0rjALMoTKvdM1V1haYcaP97AtE2UftlQtR+tvd39wMvkJ/lGIdrvLECfVzNlOqXAMpp8Ga/A/fikah5QCNOAiYryQXND9e8W/9huqnyjNc2K2j7f5XrKE5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X2Bty4jf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729258534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=O/xnSDeWem6YTYjx3MZtmJhYZEnS6IvQAVEk8HFz1F8=;
	b=X2Bty4jf+AEB0qTBgYTyyDJT3BffXaHehMjFzo0KqXd8eTmlXXAhKE4Sl3jaLl95r5lUwL
	LVpGruPP6Hf1IuBqNPt2coQAAmo+K7XD2bknf7D5GoYOO6sSOTHKPfGgr8Y7BDole7u8Pv
	VN0NVYoFKexmJgBXSyLtxwHPZabcWsc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-ly9H45zLO8a7Uc-GLqWjKA-1; Fri, 18 Oct 2024 09:35:33 -0400
X-MC-Unique: ly9H45zLO8a7Uc-GLqWjKA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4316300bb15so4571605e9.2
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 06:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729258532; x=1729863332;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O/xnSDeWem6YTYjx3MZtmJhYZEnS6IvQAVEk8HFz1F8=;
        b=XPM8Lmcv5MPdFpJkvMOBIu7PWSdn899Diqz5SsCk8FVFDnQgK1Dr+//o28PRFBr9BA
         ObcsbTUY8UuE3QXJmks1PDHvBzfpYQWMG6MeM1Dli7N6UPKIkyOL32O0w3zdifpPgxop
         qQ2oS5RUNoTvh71L2p660v/2TZWsAeCP6wLFbARtH/4NoblxPXYJ4B2MUjRxzN2KwFr/
         J/drZZjtoroRm5576LXs5S4z0JXNHoscQVLHoF8JQEA98hvIVaHBURviAH3aJMzyN+IJ
         1/aB5KNi0RfsSXrPfZlpZmoiQ3DyOomHZqatgv53aqZhRoXSakSJJ3u+XVC+jqIWWktL
         TgAQ==
X-Gm-Message-State: AOJu0YxKV2kLfP4oAdmMfdisbx81E8IBiosfFE8Xbnb1L46/vVYxJikH
	Nu0beYm/KiiXJLPqD3/jdDS75pPVTNYVLMdIaHtS/N8utddULNH8boEwWayf6y/A1HcUjEUdnxJ
	E/bCR8dwwnlmHIJl/i7brSuHupuUumu/FwcOIpoqrhM1ve/1hVHs0rCXQjKuFJA==
X-Received: by 2002:a05:600c:3591:b0:431:4c14:abf4 with SMTP id 5b1f17b1804b1-4316163a1b2mr20035325e9.14.1729258531773;
        Fri, 18 Oct 2024 06:35:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8jjZDtXyHkXMPpZAMp5FgukYVS8xmL68OwaG3Lz7Wo5oNPGTMMQM/zzP2XeYB6o6Fpeppsw==
X-Received: by 2002:a05:600c:3591:b0:431:4c14:abf4 with SMTP id 5b1f17b1804b1-4316163a1b2mr20035085e9.14.1729258531250;
        Fri, 18 Oct 2024 06:35:31 -0700 (PDT)
Received: from debian (2a01cb058d23d60005331f1e7802572f.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:533:1f1e:7802:572f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43160e0a87csm24263795e9.25.2024.10.18.06.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 06:35:30 -0700 (PDT)
Date: Fri, 18 Oct 2024 15:35:28 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next] bareudp: Use pcpu stats to update rx_dropped
 counter.
Message-ID: <959d4ea099039922e60efe738dd2172c87b5382c.1729257592.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use the core_stats rx_dropped counter to avoid the cost of atomic
increments.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
I'm using core_stats for consistency with the vxlan implementation.
If we really want to avoid using core_stats in tunnel drivers, just
let me know and I'll convert bareudp to NETDEV_PCPU_STAT_DSTATS. But
for the moment, I still prefer to favor code consistency across UDP
tunnel implementations.

 drivers/net/bareudp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index fa2dd76ba3d9..a2abfade82dd 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -84,7 +84,7 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 
 		if (skb_copy_bits(skb, BAREUDP_BASE_HLEN, &ipversion,
 				  sizeof(ipversion))) {
-			DEV_STATS_INC(bareudp->dev, rx_dropped);
+			dev_core_stats_rx_dropped_inc(bareudp->dev);
 			goto drop;
 		}
 		ipversion >>= 4;
@@ -94,7 +94,7 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 		} else if (ipversion == 6 && bareudp->multi_proto_mode) {
 			proto = htons(ETH_P_IPV6);
 		} else {
-			DEV_STATS_INC(bareudp->dev, rx_dropped);
+			dev_core_stats_rx_dropped_inc(bareudp->dev);
 			goto drop;
 		}
 	} else if (bareudp->ethertype == htons(ETH_P_MPLS_UC)) {
@@ -108,7 +108,7 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 				   ipv4_is_multicast(tunnel_hdr->daddr)) {
 				proto = htons(ETH_P_MPLS_MC);
 			} else {
-				DEV_STATS_INC(bareudp->dev, rx_dropped);
+				dev_core_stats_rx_dropped_inc(bareudp->dev);
 				goto drop;
 			}
 		} else {
@@ -124,7 +124,7 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 				   (addr_type & IPV6_ADDR_MULTICAST)) {
 				proto = htons(ETH_P_MPLS_MC);
 			} else {
-				DEV_STATS_INC(bareudp->dev, rx_dropped);
+				dev_core_stats_rx_dropped_inc(bareudp->dev);
 				goto drop;
 			}
 		}
@@ -136,7 +136,7 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 				 proto,
 				 !net_eq(bareudp->net,
 				 dev_net(bareudp->dev)))) {
-		DEV_STATS_INC(bareudp->dev, rx_dropped);
+		dev_core_stats_rx_dropped_inc(bareudp->dev);
 		goto drop;
 	}
 
@@ -144,7 +144,7 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 
 	tun_dst = udp_tun_rx_dst(skb, family, key, 0, 0);
 	if (!tun_dst) {
-		DEV_STATS_INC(bareudp->dev, rx_dropped);
+		dev_core_stats_rx_dropped_inc(bareudp->dev);
 		goto drop;
 	}
 	skb_dst_set(skb, &tun_dst->dst);
-- 
2.39.2


