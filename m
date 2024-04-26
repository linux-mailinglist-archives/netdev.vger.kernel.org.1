Return-Path: <netdev+bounces-91744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7908B3B62
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 17:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3401C22EC5
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 15:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BF914A617;
	Fri, 26 Apr 2024 15:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aDB76egc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B9414882E
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145246; cv=none; b=BnvGr48zmwojcqNUSY216ujx+C3pBznH/gTwPB1HiAOhgi7haHV6LtRP/epJ4NmFFyn7EsvmPRhgNg6RDdC5ZE2fVqEQmO/CwgT24ezlny6xutEjsJZ6K9E6HjqJbqp6j+nN/eZebprCNDnH9gPpP42f4gd/P0dFU/WrlXkHJOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145246; c=relaxed/simple;
	bh=ON8O69L2WjrSwImkIL8SztoYHne6EyZJFFigOCgPOuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e12jmkhgc//Zr9OJ/zmmBERuWUd9QITsJ52EVcWeQ+kZRyl6fgMIJIKggxQfXm/SQWoxz6PQE7f4i8gqLN4avMUsfHu/y/nJBXohGpohOizpzM+Vuru9azzPqjbV3JJqWlXuYsA2M5F85nNMyfdUjfr1u7Xl9aW3jZKumdTG44Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aDB76egc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714145244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f1VNfaNuGWGfgCNdtKjqGHDe2lFtIktnJGH3dzXC+fM=;
	b=aDB76egc0RzTQYYlTqDRbM2XJUOE0W7pg/kB8Yn30XX2j4A/edy90NjoezoTuzrKJpfiV1
	Pj1+PoPyz/WrIa09FigQy7xQz+RE5k7hzcdDRvCg0h518P3Uxg1+/nWrEVgZS/0tMAusny
	5SmdIK75e0Vydz5szu01iMLKvPLU/NI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-3T1HvyDzOkeucnNsrB2YdQ-1; Fri, 26 Apr 2024 11:27:22 -0400
X-MC-Unique: 3T1HvyDzOkeucnNsrB2YdQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6a085b7a6ceso31055046d6.2
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 08:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145242; x=1714750042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1VNfaNuGWGfgCNdtKjqGHDe2lFtIktnJGH3dzXC+fM=;
        b=uUIN3XEnqQHL4ezEdecEOenjh1W1JpkkPzTUq5LKs8MMpAw/Z/AvkxZPfQqBSq4OUt
         j0CSWF1B5qAH6C5vKSAr1GYUfP25R9wNTI8fYvj7+KPD/uF6jUpff9JvquEP25yKoUFG
         wlyY+fhXjLP5JQciR/C3ECaYpphlRNVa8AQ2TV4skYtynuYzoES+H+jDHlVZZneIDOKC
         3xjICCklq7supEnhR7sE3TkpeetTZT0Ne1fxLto7O7Xcq2PvDcY8B5tFvXOCsyti4bZP
         0wpgcCSDd6tkOO9FctYKVCMO2oWHMFtEJafklQTdA/qHsHtmPh1jhfq3jvTjzlF7hinL
         riPw==
X-Gm-Message-State: AOJu0Yxu5PsonTNa04EkRCEMG4KkchGYfDRMp6kds12hMafPloGhDn6a
	PlXuU7J2knC718/pg0Ke2LfatnCAz6edqgO5nZIiDwDcIrp2d3HIkW8w4cbeX+5gnjETxfOYmvA
	FupbWO+w73wx4CkhlwmgZEQbYLTHwTYIWTpnG+bIgLnoyg+PfDZJLhg==
X-Received: by 2002:a05:6214:212e:b0:6a0:9f93:1ee5 with SMTP id r14-20020a056214212e00b006a09f931ee5mr4347284qvc.13.1714145242328;
        Fri, 26 Apr 2024 08:27:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTQIk7SOs2UrQ6IbTUTGHdnp+MN9RMQrqGF0BBtvvCgtSilUbgR5l8fnQwjSmUs8bP4WxDuA==
X-Received: by 2002:a05:6214:212e:b0:6a0:9f93:1ee5 with SMTP id r14-20020a056214212e00b006a09f931ee5mr4347257qvc.13.1714145242014;
        Fri, 26 Apr 2024 08:27:22 -0700 (PDT)
Received: from debian (2a01cb058918ce00d9135204d7b88de9.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:d913:5204:d7b8:8de9])
        by smtp.gmail.com with ESMTPSA id n20-20020a0ce494000000b006a0533b107dsm1917414qvl.69.2024.04.26.08.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 08:27:21 -0700 (PDT)
Date: Fri, 26 Apr 2024 17:27:17 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jiri Benc <jbenc@redhat.com>, Breno Leitao <leitao@debian.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	stephen hemminger <shemminger@vyatta.com>
Subject: [PATCH net 1/2] vxlan: Fix racy device stats updates.
Message-ID: <ee4f5622d105ba9e0c7762acae7c73a7cce05b29.1714144439.git.gnault@redhat.com>
References: <cover.1714144439.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1714144439.git.gnault@redhat.com>

VXLAN devices update their stats locklessly. Therefore these counters
should either be stored in per-cpu data structures or the updates
should be done using atomic increments.

Since the net_device_core_stats infrastructure is already used in
vxlan_rcv(), use it for the other rx_dropped and tx_dropped counter
updates. Update the other counters atomically using DEV_STATS_INC().

Fixes: d342894c5d2f ("vxlan: virtual extensible lan")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 drivers/net/vxlan/vxlan_core.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index ba319fc21957..0cd9e44c7be8 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1766,8 +1766,8 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	skb_reset_network_header(skb);
 
 	if (!vxlan_ecn_decapsulate(vs, oiph, skb)) {
-		++vxlan->dev->stats.rx_frame_errors;
-		++vxlan->dev->stats.rx_errors;
+		DEV_STATS_INC(vxlan->dev, rx_frame_errors);
+		DEV_STATS_INC(vxlan->dev, rx_errors);
 		vxlan_vnifilter_count(vxlan, vni, vninode,
 				      VXLAN_VNI_STATS_RX_ERRORS, 0);
 		goto drop;
@@ -1837,7 +1837,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 		goto out;
 
 	if (!pskb_may_pull(skb, arp_hdr_len(dev))) {
-		dev->stats.tx_dropped++;
+		dev_core_stats_tx_dropped_inc(dev);
 		goto out;
 	}
 	parp = arp_hdr(skb);
@@ -1893,7 +1893,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 		reply->pkt_type = PACKET_HOST;
 
 		if (netif_rx(reply) == NET_RX_DROP) {
-			dev->stats.rx_dropped++;
+			dev_core_stats_rx_dropped_inc(dev);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
 					      VXLAN_VNI_STATS_RX_DROPS, 0);
 		}
@@ -2052,7 +2052,7 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 			goto out;
 
 		if (netif_rx(reply) == NET_RX_DROP) {
-			dev->stats.rx_dropped++;
+			dev_core_stats_rx_dropped_inc(dev);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
 					      VXLAN_VNI_STATS_RX_DROPS, 0);
 		}
@@ -2263,7 +2263,7 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 				      len);
 	} else {
 drop:
-		dev->stats.rx_dropped++;
+		dev_core_stats_rx_dropped_inc(dev);
 		vxlan_vnifilter_count(dst_vxlan, vni, NULL,
 				      VXLAN_VNI_STATS_RX_DROPS, 0);
 	}
@@ -2295,7 +2295,7 @@ static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
 					   addr_family, dst_port,
 					   vxlan->cfg.flags);
 		if (!dst_vxlan) {
-			dev->stats.tx_errors++;
+			DEV_STATS_INC(dev, tx_errors);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
 					      VXLAN_VNI_STATS_TX_ERRORS, 0);
 			kfree_skb(skb);
@@ -2559,7 +2559,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 	return;
 
 drop:
-	dev->stats.tx_dropped++;
+	dev_core_stats_tx_dropped_inc(dev);
 	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX_DROPS, 0);
 	dev_kfree_skb(skb);
 	return;
@@ -2567,11 +2567,11 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 tx_error:
 	rcu_read_unlock();
 	if (err == -ELOOP)
-		dev->stats.collisions++;
+		DEV_STATS_INC(dev, collisions);
 	else if (err == -ENETUNREACH)
-		dev->stats.tx_carrier_errors++;
+		DEV_STATS_INC(dev, tx_carrier_errors);
 	dst_release(ndst);
-	dev->stats.tx_errors++;
+	DEV_STATS_INC(dev, tx_errors);
 	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX_ERRORS, 0);
 	kfree_skb(skb);
 }
@@ -2604,7 +2604,7 @@ static void vxlan_xmit_nh(struct sk_buff *skb, struct net_device *dev,
 	return;
 
 drop:
-	dev->stats.tx_dropped++;
+	dev_core_stats_tx_dropped_inc(dev);
 	vxlan_vnifilter_count(netdev_priv(dev), vni, NULL,
 			      VXLAN_VNI_STATS_TX_DROPS, 0);
 	dev_kfree_skb(skb);
@@ -2642,7 +2642,7 @@ static netdev_tx_t vxlan_xmit_nhid(struct sk_buff *skb, struct net_device *dev,
 	return NETDEV_TX_OK;
 
 drop:
-	dev->stats.tx_dropped++;
+	dev_core_stats_tx_dropped_inc(dev);
 	vxlan_vnifilter_count(netdev_priv(dev), vni, NULL,
 			      VXLAN_VNI_STATS_TX_DROPS, 0);
 	dev_kfree_skb(skb);
@@ -2739,7 +2739,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 			    !is_multicast_ether_addr(eth->h_dest))
 				vxlan_fdb_miss(vxlan, eth->h_dest);
 
-			dev->stats.tx_dropped++;
+			dev_core_stats_tx_dropped_inc(dev);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
 					      VXLAN_VNI_STATS_TX_DROPS, 0);
 			kfree_skb(skb);
-- 
2.39.2


