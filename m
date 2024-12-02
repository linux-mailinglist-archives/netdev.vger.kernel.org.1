Return-Path: <netdev+bounces-148230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 879329E0E4D
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 23:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AACE9B2D3B7
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 21:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7351DF24D;
	Mon,  2 Dec 2024 21:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fd8YRBuc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02631DF73E
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 21:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733176140; cv=none; b=W7eA58but/XVGL2WIWPmlg8MPdZD/iqneEPNPHUUcB42AUxomPxn00+I4SUrg2nn1lpwBMFnoniPA2cif1qjYvpFzIe8v4cWETSX00DscPy//CN/HPa3j7Z8CMt+ngwyUNMyfPk8ZDxLc0MThN3ZZwE/9ULTAv7G6MKSnoWtE7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733176140; c=relaxed/simple;
	bh=HTBrfdKjOHKGi9tdykW1fntgZOEeePkmF6p9fnT/XTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fONdrvc5TiDn4FnC0NXKN5rQzILPeKSw4dKjgQyXFxYsBaZKEOTxAecun1kkYhxZbNzi7eVmRqNQXcPPnJfswhhweooHdu+x4Awo6vvHrus8Tk2QeIkNE5nwgNFcSfw+J19l6euVrNlNrK3unxGtxOfFUdWh056HgE7kTGfa9mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fd8YRBuc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733176137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DtdZRN8W/3KdjAF87mhMD3rsT1ZGMvzZSHBJyhDjd54=;
	b=fd8YRBuc8+42RyXo9Deml2rBsIKmdTeiQcMlI0pEdGqEnDbFZBxbbCbGIuYxEQzYba2DjV
	zDARY2rHEa+vSmmCbf0/L+bCeVi0WW5WCuLeaFKl8BQHT4jc9ItLGRrOSjb+iVk1659jV4
	CX13UmftTAwYfoSEauJDrI56DQJ+x2w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-_xT86IjfOguBnPM25uie5A-1; Mon, 02 Dec 2024 16:48:56 -0500
X-MC-Unique: _xT86IjfOguBnPM25uie5A-1
X-Mimecast-MFC-AGG-ID: _xT86IjfOguBnPM25uie5A
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4349eeeb841so34458465e9.3
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 13:48:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733176135; x=1733780935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtdZRN8W/3KdjAF87mhMD3rsT1ZGMvzZSHBJyhDjd54=;
        b=By7wsAMpPBBfntm1l7KtBQt0PdgxlSEaTwGlDo4F0aEu5eu66YGbQaLidcyvH8eWWL
         eEWTeCoESEvg7EV/CCT1/ekxGf0hY/dMciwmztbDCEvpJjCYiCQMnUYyAumJGGM/kYJs
         aQpMR9gReWu3iiTaQxqUEzBxSFzyGxzUu9lUCPGjGgOclrtqPce8TF72zjsjdROUAj+2
         FSDbF218dwGdStLYAmHfRt/vL/kf8jgobaii26987Y9daclifiT4XsenmqYQ0tvhl/gP
         BQIaAodVxxGk/XqKleRU0tJMC4wjhtCZQ9xjk4sPPS5Z4OkkZlOXOZ73tb0AM8683Xmk
         3uhQ==
X-Gm-Message-State: AOJu0YxqBMADDN7u1JjWkCuyYr4Hp3NWirWc+ENvsn2isx9vkdf/gcnN
	bGsghuBPHYbk33CkHwITaYWTRWnr4wXHjlW0YvwNhTPzfL8GWvpEFBftmL4sU99OLKC01ddGsqU
	amLyqa2h1Gr7KbVFcBVpOJUi3r3C6A8Ep6xfs1bavMp/IzABUu7xq0A==
X-Gm-Gg: ASbGncvPCl4qmL0C2VrG/HwS9DhsZDENm82IXMy0hL4V/dKOpOAurXf1LpgTvjkFXOA
	OWBVfpDBnEvXTFQvi+8azVNNgRI+1xCqJL343wmR+JvuSK6WuvcBy/RpjmGw1aWgXTIBRXV0kfi
	FU6dtGZhmtMSmAqCL5WbqrxZtBjNv9Tb6f96Ye+4FwgWXwc8QsqYcNawpMkJMReEnPICgmmk9s7
	FQnnC/38xSOqw87E2UQQU0QFhOmzW3lB5alVuCb+s0/1l49yQ2Z9sJAz8k+UAdQwOp8ZG1ojsPP
	T3rPmHAGWSMNTqR7DIq2yyPU/Ywz9w==
X-Received: by 2002:a05:600c:4f95:b0:434:a5d1:9917 with SMTP id 5b1f17b1804b1-434d0a05c88mr235235e9.21.1733176135277;
        Mon, 02 Dec 2024 13:48:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFg7ZjrV/CGYOQ1oFrackLz4w8ArB1r2xp+bcw8yAgPRQVUgQa1IAMz6szBPxsPTaDVCr5Pbg==
X-Received: by 2002:a05:600c:4f95:b0:434:a5d1:9917 with SMTP id 5b1f17b1804b1-434d0a05c88mr235055e9.21.1733176134881;
        Mon, 02 Dec 2024 13:48:54 -0800 (PST)
Received: from debian (2a01cb058d23d6001797ea6ce8a6dfab.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:1797:ea6c:e8a6:dfab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d29fbsm200369175e9.29.2024.12.02.13.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 13:48:54 -0800 (PST)
Date: Mon, 2 Dec 2024 22:48:51 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net-next 2/4] vxlan: Handle stats using
 NETDEV_PCPU_STAT_DSTATS.
Message-ID: <098b883a249d052946f2f277ff050dea25afd6d6.1733175419.git.gnault@redhat.com>
References: <cover.1733175419.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1733175419.git.gnault@redhat.com>

VXLAN uses the TSTATS infrastructure (dev_sw_netstats_*()) for RX and
TX packet counters. It also uses the device core stats
(dev_core_stats_*()) for RX and TX drops.

Let's consolidate that using the DSTATS infrastructure, which can
handle both packet counters and packet drops. Statistics that don't
fit DSTATS are still updated atomically with DEV_STATS_INC().

While there, convert the "len" variable of vxlan_encap_bypass() to
unsigned int, to respect the types of skb->len and
dev_dstats_[rt]x_add().

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 drivers/net/vxlan/vxlan_core.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 9ea63059d52d..b46a799bd390 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1818,14 +1818,14 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 
 	if (unlikely(!(vxlan->dev->flags & IFF_UP))) {
 		rcu_read_unlock();
-		dev_core_stats_rx_dropped_inc(vxlan->dev);
+		dev_dstats_rx_dropped(vxlan->dev);
 		vxlan_vnifilter_count(vxlan, vni, vninode,
 				      VXLAN_VNI_STATS_RX_DROPS, 0);
 		reason = SKB_DROP_REASON_DEV_READY;
 		goto drop;
 	}
 
-	dev_sw_netstats_rx_add(vxlan->dev, skb->len);
+	dev_dstats_rx_add(vxlan->dev, skb->len);
 	vxlan_vnifilter_count(vxlan, vni, vninode, VXLAN_VNI_STATS_RX, skb->len);
 	gro_cells_receive(&vxlan->gro_cells, skb);
 
@@ -1880,7 +1880,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 		goto out;
 
 	if (!pskb_may_pull(skb, arp_hdr_len(dev))) {
-		dev_core_stats_tx_dropped_inc(dev);
+		dev_dstats_tx_dropped(dev);
 		vxlan_vnifilter_count(vxlan, vni, NULL,
 				      VXLAN_VNI_STATS_TX_DROPS, 0);
 		goto out;
@@ -1938,7 +1938,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 		reply->pkt_type = PACKET_HOST;
 
 		if (netif_rx(reply) == NET_RX_DROP) {
-			dev_core_stats_rx_dropped_inc(dev);
+			dev_dstats_rx_dropped(dev);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
 					      VXLAN_VNI_STATS_RX_DROPS, 0);
 		}
@@ -2097,7 +2097,7 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 			goto out;
 
 		if (netif_rx(reply) == NET_RX_DROP) {
-			dev_core_stats_rx_dropped_inc(dev);
+			dev_dstats_rx_dropped(dev);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
 					      VXLAN_VNI_STATS_RX_DROPS, 0);
 		}
@@ -2271,8 +2271,8 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 {
 	union vxlan_addr loopback;
 	union vxlan_addr *remote_ip = &dst_vxlan->default_dst.remote_ip;
+	unsigned int len = skb->len;
 	struct net_device *dev;
-	int len = skb->len;
 
 	skb->pkt_type = PACKET_HOST;
 	skb->encapsulation = 0;
@@ -2299,16 +2299,16 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 	if ((dst_vxlan->cfg.flags & VXLAN_F_LEARN) && snoop)
 		vxlan_snoop(dev, &loopback, eth_hdr(skb)->h_source, 0, vni);
 
-	dev_sw_netstats_tx_add(src_vxlan->dev, 1, len);
+	dev_dstats_tx_add(src_vxlan->dev, len);
 	vxlan_vnifilter_count(src_vxlan, vni, NULL, VXLAN_VNI_STATS_TX, len);
 
 	if (__netif_rx(skb) == NET_RX_SUCCESS) {
-		dev_sw_netstats_rx_add(dst_vxlan->dev, len);
+		dev_dstats_rx_add(dst_vxlan->dev, len);
 		vxlan_vnifilter_count(dst_vxlan, vni, NULL, VXLAN_VNI_STATS_RX,
 				      len);
 	} else {
 drop:
-		dev_core_stats_rx_dropped_inc(dev);
+		dev_dstats_rx_dropped(dev);
 		vxlan_vnifilter_count(dst_vxlan, vni, NULL,
 				      VXLAN_VNI_STATS_RX_DROPS, 0);
 	}
@@ -2621,7 +2621,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 	return;
 
 drop:
-	dev_core_stats_tx_dropped_inc(dev);
+	dev_dstats_tx_dropped(dev);
 	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX_DROPS, 0);
 	kfree_skb_reason(skb, reason);
 	return;
@@ -2666,7 +2666,7 @@ static void vxlan_xmit_nh(struct sk_buff *skb, struct net_device *dev,
 	return;
 
 drop:
-	dev_core_stats_tx_dropped_inc(dev);
+	dev_dstats_tx_dropped(dev);
 	vxlan_vnifilter_count(netdev_priv(dev), vni, NULL,
 			      VXLAN_VNI_STATS_TX_DROPS, 0);
 	dev_kfree_skb(skb);
@@ -2704,7 +2704,7 @@ static netdev_tx_t vxlan_xmit_nhid(struct sk_buff *skb, struct net_device *dev,
 	return NETDEV_TX_OK;
 
 drop:
-	dev_core_stats_tx_dropped_inc(dev);
+	dev_dstats_tx_dropped(dev);
 	vxlan_vnifilter_count(netdev_priv(dev), vni, NULL,
 			      VXLAN_VNI_STATS_TX_DROPS, 0);
 	dev_kfree_skb(skb);
@@ -2801,7 +2801,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 			    !is_multicast_ether_addr(eth->h_dest))
 				vxlan_fdb_miss(vxlan, eth->h_dest);
 
-			dev_core_stats_tx_dropped_inc(dev);
+			dev_dstats_tx_dropped(dev);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
 					      VXLAN_VNI_STATS_TX_DROPS, 0);
 			kfree_skb_reason(skb, SKB_DROP_REASON_VXLAN_NO_REMOTE);
@@ -3371,7 +3371,7 @@ static void vxlan_setup(struct net_device *dev)
 	dev->min_mtu = ETH_MIN_MTU;
 	dev->max_mtu = ETH_MAX_MTU;
 
-	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
 	INIT_LIST_HEAD(&vxlan->next);
 
 	timer_setup(&vxlan->age_timer, vxlan_cleanup, TIMER_DEFERRABLE);
-- 
2.39.2


