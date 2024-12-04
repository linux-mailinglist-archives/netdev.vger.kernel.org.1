Return-Path: <netdev+bounces-148961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4009E3995
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 13:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ADB4282D00
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 12:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD011B6CFF;
	Wed,  4 Dec 2024 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Il8dVSMY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352EE1B2EEB
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733314296; cv=none; b=ezlIzKN8wEHeBAraLm/9dmNKcGVYImMm0KQymchjEiOOqiZk2D2L/3qqbLJ/ZWYuyLJy254iUCdxSi2/iwj7rWdw4+h362ZZqssw7IzXWHjH8NWWNMmOTvzFr5fkvThRgAkBcacRkIjrD31jnMa1QtNDkMg1kIU+WRyqzAGzYJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733314296; c=relaxed/simple;
	bh=HTBrfdKjOHKGi9tdykW1fntgZOEeePkmF6p9fnT/XTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvQBeJDwpeOp0WLWPy51OLmlr5f8/pwa14smdC5CoT8i3QrKB+ojTTYDvyaxt7QPZKhJSMjB9VWaRYUfAcO2hzUgKvJfN02GBMni3NTM5y17CGQ6QFEWl1wQ7mhL7yE2wpzPzv2J/QGsYgd3JQTpZn8HNx46R5D++yAskwPmH50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Il8dVSMY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733314293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DtdZRN8W/3KdjAF87mhMD3rsT1ZGMvzZSHBJyhDjd54=;
	b=Il8dVSMYEYZv9dGPmCJR3gmBqJcxEhBeZs03gf37wBsZqAl8vn/leleTBrVM1+ghmE//Ew
	tMolBclXoNrdoyL/IevkHxI9JqSwmbNeEECzuGfuRg+17cddwDfS9YqY8FjGXPHCk0kMRo
	jYyTxehEz8PxxORVqycIC/UXqZOWRqU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-PZ343erxOyKMEzwXHV66BQ-1; Wed, 04 Dec 2024 07:11:30 -0500
X-MC-Unique: PZ343erxOyKMEzwXHV66BQ-1
X-Mimecast-MFC-AGG-ID: PZ343erxOyKMEzwXHV66BQ
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385d4fa8e19so3427728f8f.2
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 04:11:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733314289; x=1733919089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtdZRN8W/3KdjAF87mhMD3rsT1ZGMvzZSHBJyhDjd54=;
        b=woSoEXZcWrpmo71xFQNNIHONdOI2AAWuAaDYFeH5JHiuNjfe8A2AV3r64hLr2u/qE2
         +Bvr3ZF04jEUFhScGBCJbl29PCQyFhXAocKmQI7LPtWKPlhNgqKI1SUWpO6m4luTOC2g
         oFuaDPE51zy8NAoJu2PPbNWhYjZVkXrLub9zNnBLaa8P25E0d86MymlOjMnntRmXkVhj
         Mfn9kb68Q+cVPlPYQ0XwZ0mDLvuMQ+/AWBuT0/U7RatdigL+4VOot7nmJq1IHlxEqLM4
         XxfC26dkignsP1lyGwxT63EL9GtdGS1gech7Z7ZqlV3Ar2Z6KujkeRK1GnlavS7Q+UNS
         QD1Q==
X-Gm-Message-State: AOJu0YxMtAZ/7a3PSfoVK4Rhd+zENpRB/C0YZidU9CPh6b1XMWrBD0UU
	f0/tzOpgSO9N7DFxMqN8qIoi0qszoPaGS3d+uhaq+KUBzjF3G7h2RRuZdMME/xLOGyC5cziZgv5
	XVUhUiYr7NSwuFpDlxQxDORJxo8jUYr5dh7+0xwqFYWWJeGSrh02XtA==
X-Gm-Gg: ASbGncv4VZ6EUep87mIDlx2hfvF2h2s7r0WBpGw8vJpF+MHhfGIkz+qU0AxL6f4FeaB
	hS8EekYaYc7BY5AAGB+fb48EmkW6IaOPOGnk+SkeZeIB2tq1PeHakP6i1YKGKjOc1ZcDe2m/kEG
	HHiyO3YKAsfWa6bWmmtTI+tQtFXYrs4oDvsE7Gp2aEwKxFXT3zDeCuMw3eKV4e2HgeM3Z1xVJcV
	TaGASGViF9IvumQYe2aP8u5vJjRtxOcclSbV1IIRIZj6OatE8DeQpqCOE1L+0QmfY14YtWODLeq
	tJdHBiUv7vpoYjy4qtZICxH+TLfVjA==
X-Received: by 2002:a5d:47cb:0:b0:385:ee59:4510 with SMTP id ffacd0b85a97d-385fd3cc9b6mr5620939f8f.9.1733314289620;
        Wed, 04 Dec 2024 04:11:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiTHFswU3DzfMz035kmGtPr+sP4JGyAZXzFqzXv4ARXWeEsZld4OcqqmVC3hENaSC2tNRxwQ==
X-Received: by 2002:a5d:47cb:0:b0:385:ee59:4510 with SMTP id ffacd0b85a97d-385fd3cc9b6mr5620919f8f.9.1733314289274;
        Wed, 04 Dec 2024 04:11:29 -0800 (PST)
Received: from debian (2a01cb058d23d600b242516949266d33.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:b242:5169:4926:6d33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385de98d618sm15561252f8f.90.2024.12.04.04.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 04:11:28 -0800 (PST)
Date: Wed, 4 Dec 2024 13:11:27 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net-next v2 2/4] vxlan: Handle stats using
 NETDEV_PCPU_STAT_DSTATS.
Message-ID: <145558b184b3cda77911ca5682b6eb83c3ffed8e.1733313925.git.gnault@redhat.com>
References: <cover.1733313925.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1733313925.git.gnault@redhat.com>

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


