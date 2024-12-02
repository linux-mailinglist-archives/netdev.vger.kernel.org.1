Return-Path: <netdev+bounces-148229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9736B9E0E88
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 23:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 157E4B2CDF5
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 21:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA651DF265;
	Mon,  2 Dec 2024 21:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLGB32PK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EB13D97A
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 21:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733176136; cv=none; b=S1CLAku+6+XgUFg0l3CK8DIhS3AS34Ch3xEfB8OaoqvK4buYFAiyNX8hqTC7WK+0S/FJGbKaoMvquSWWpyz1oP2TTgNGvvg1M3ZEm7jBSugzdng0GOe5YiZR1jlg263MP6WCwBo9MkzXKVRnZ7SVjTeDlhDa41a57GUKEfUQJ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733176136; c=relaxed/simple;
	bh=+mHs2r6xUjQacGAIYT3/iremgeqdvDuqjC/J1K0sk4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlXx/VIVeqgiDmQGnu/iKoXuD/PF5PNKxpOfzoxwPewhPO3e0nrbASX3i5YODdSk9oRQK55fszxvmPvsPVwEioN0pi4VjJN5iQxE/06tfWzH/SI38vqERtRa+qegGW9KVhsCcUgrjnyfsbBjMQzHqa5xa07m28KS+FLlSGFenSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HLGB32PK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733176133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m0AdheSQOy3OPgOR9Sp861yrPuzl1YFO/sM5Oqu+QuI=;
	b=HLGB32PK6+H3QoM/wg1IjCU+tOyEGCs0JKW1YEDRKRz0otBB+r3lBwcd9mlqayoBg4TpVY
	ZkK2CCT2r50G6xFrbFe3U656A57ZuLpGcJWgDMxiZAGKhY1AZMucFL4ou1eD5y6U8NRGTL
	LnqHNsWRBM2nWxx+BO+lVG9WnxJtq00=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-vqziPsdXMMapk7NzqANFzQ-1; Mon, 02 Dec 2024 16:48:52 -0500
X-MC-Unique: vqziPsdXMMapk7NzqANFzQ-1
X-Mimecast-MFC-AGG-ID: vqziPsdXMMapk7NzqANFzQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43498af7937so39638995e9.1
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 13:48:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733176131; x=1733780931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0AdheSQOy3OPgOR9Sp861yrPuzl1YFO/sM5Oqu+QuI=;
        b=a5rLHUbSXPT2LNYjrwEyf0WV2cTktBY7yXQT0EB4d6pEY332A/NY9ZqzQbWr20ktKs
         4/kXEukqUmjMe4fiR9H3eQfp6MnwxW83WV88oEv0NAnBQ5VF3PklkkN/xF2fiUt71fQi
         sO8/JqSe9BmzWtXtoiiz5u61cpQFiRtaqi0bximroqQLiN/xed3QwEfCaPtMciHatkMf
         DQ1+DsO8mU54XdeAnwKJPKnnk+OrXOncWwEZ+2RrsicDkrw95Ol5A/aAbimJjakZPmr+
         +cbGOuVaWPCMsmESP48MshpWaqWO7AeJS0D8O3EjseiG7fs1eOARF+QkNM4h96ZIQcBZ
         Hktw==
X-Gm-Message-State: AOJu0YyZ8bUKluQInlkZAdQmprOEbkXdv0gMevr4szmfZnadYU2qX3Zk
	vMdt/eUOa++yImCg2P2tjgTfjqwdu0ioYO+WA2Sh4SbPp8TjSIwjSypqQHKTwI6hTlW4xr7Nutf
	oh5ZxzaujizpxvYMN85ocYij2e6gIPL4UlqD8OkVcV31tEJo2v0TxJA==
X-Gm-Gg: ASbGncszC3TIKNEhOzCpQvQRfwnVfHduRiJqdXyKr4tbqacNUb5OQ34krLrErJCRvut
	kRyxmQ68ZG5RD8vD2JKooBTQyfTJ6JMUDgG7UArj9CGdXujpJR7vwRdphumTslxQ1TQZloY4MAg
	G+eLIWhBlZ6BLk3ph9sOBmSnwmrrXYV4reUXcGvjsajsEv25GziSrUyizsIX4bXfVMT86En5dM4
	jocOrougqZcUUusQ5VwCs2mMXFIAVF0yY5cxBlnwBoA58Hu2RXRHdtVyR48wdRKL7xX5TWapCc8
	YsZz1l/Wp38IrCPBgrz5wkvr9ihtIA==
X-Received: by 2002:a05:600c:524d:b0:434:a7e3:db5c with SMTP id 5b1f17b1804b1-434d09b6730mr396335e9.11.1733176131115;
        Mon, 02 Dec 2024 13:48:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYd6LJOmxiMWl/AJioywKyCSoIXfLi4jOXtzumogsTR6K9uJ4cozkC5iuenGaKdihui8OFzA==
X-Received: by 2002:a05:600c:524d:b0:434:a7e3:db5c with SMTP id 5b1f17b1804b1-434d09b6730mr396145e9.11.1733176130729;
        Mon, 02 Dec 2024 13:48:50 -0800 (PST)
Received: from debian (2a01cb058d23d6001797ea6ce8a6dfab.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:1797:ea6c:e8a6:dfab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa763aaesm196906635e9.14.2024.12.02.13.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 13:48:50 -0800 (PST)
Date: Mon, 2 Dec 2024 22:48:48 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net-next 1/4] vrf: Make pcpu_dstats update functions
 available to other modules.
Message-ID: <5e97f1e54e57b0a85e34af87062dc536a28bef34.1733175419.git.gnault@redhat.com>
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

Currently vrf is the only module that uses NETDEV_PCPU_STAT_DSTATS.
In order to make this kind of statistics available to other modules,
we need to define the update functions in netdevice.h.

Therefore, let's define dev_dstats_*() functions for RX and TX packet
updates (packets, bytes and drops). Use these new functions in vrf.c
instead of vrf_rx_stats() and the other manual counter updates.

While there, update the type of the "len" variables to "unsigned int",
so that there're aligned with both skb->len and the new dstats update
functions.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 drivers/net/vrf.c         | 46 ++++++++++-----------------------------
 include/linux/netdevice.h | 40 ++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 34 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 67d25f4f94ef..f0c0b3d4d827 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -122,16 +122,6 @@ struct net_vrf {
 	int			ifindex;
 };
 
-static void vrf_rx_stats(struct net_device *dev, int len)
-{
-	struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
-
-	u64_stats_update_begin(&dstats->syncp);
-	u64_stats_inc(&dstats->rx_packets);
-	u64_stats_add(&dstats->rx_bytes, len);
-	u64_stats_update_end(&dstats->syncp);
-}
-
 static void vrf_tx_error(struct net_device *vrf_dev, struct sk_buff *skb)
 {
 	vrf_dev->stats.tx_errors++;
@@ -369,7 +359,7 @@ static bool qdisc_tx_is_default(const struct net_device *dev)
 static int vrf_local_xmit(struct sk_buff *skb, struct net_device *dev,
 			  struct dst_entry *dst)
 {
-	int len = skb->len;
+	unsigned int len = skb->len;
 
 	skb_orphan(skb);
 
@@ -382,15 +372,10 @@ static int vrf_local_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	skb->protocol = eth_type_trans(skb, dev);
 
-	if (likely(__netif_rx(skb) == NET_RX_SUCCESS)) {
-		vrf_rx_stats(dev, len);
-	} else {
-		struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
-
-		u64_stats_update_begin(&dstats->syncp);
-		u64_stats_inc(&dstats->rx_drops);
-		u64_stats_update_end(&dstats->syncp);
-	}
+	if (likely(__netif_rx(skb) == NET_RX_SUCCESS))
+		dev_dstats_rx_add(dev, len);
+	else
+		dev_dstats_rx_dropped(dev);
 
 	return NETDEV_TX_OK;
 }
@@ -578,20 +563,13 @@ static netdev_tx_t is_ip_tx_frame(struct sk_buff *skb, struct net_device *dev)
 
 static netdev_tx_t vrf_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
-
-	int len = skb->len;
 	netdev_tx_t ret = is_ip_tx_frame(skb, dev);
+	unsigned int len = skb->len;
 
-	u64_stats_update_begin(&dstats->syncp);
-	if (likely(ret == NET_XMIT_SUCCESS || ret == NET_XMIT_CN)) {
-
-		u64_stats_inc(&dstats->tx_packets);
-		u64_stats_add(&dstats->tx_bytes, len);
-	} else {
-		u64_stats_inc(&dstats->tx_drops);
-	}
-	u64_stats_update_end(&dstats->syncp);
+	if (likely(ret == NET_XMIT_SUCCESS || ret == NET_XMIT_CN))
+		dev_dstats_tx_add(dev, len);
+	else
+		dev_dstats_tx_dropped(dev);
 
 	return ret;
 }
@@ -1364,7 +1342,7 @@ static struct sk_buff *vrf_ip6_rcv(struct net_device *vrf_dev,
 	if (!is_ndisc) {
 		struct net_device *orig_dev = skb->dev;
 
-		vrf_rx_stats(vrf_dev, skb->len);
+		dev_dstats_rx_add(vrf_dev, skb->len);
 		skb->dev = vrf_dev;
 		skb->skb_iif = vrf_dev->ifindex;
 
@@ -1420,7 +1398,7 @@ static struct sk_buff *vrf_ip_rcv(struct net_device *vrf_dev,
 		goto out;
 	}
 
-	vrf_rx_stats(vrf_dev, skb->len);
+	dev_dstats_rx_add(vrf_dev, skb->len);
 
 	if (!list_empty(&vrf_dev->ptype_all)) {
 		int err;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ecc686409161..b49780c724d7 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2854,6 +2854,46 @@ static inline void dev_lstats_add(struct net_device *dev, unsigned int len)
 	u64_stats_update_end(&lstats->syncp);
 }
 
+static inline void dev_dstats_rx_add(struct net_device *dev,
+				     unsigned int len)
+{
+	struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
+
+	u64_stats_update_begin(&dstats->syncp);
+	u64_stats_inc(&dstats->rx_packets);
+	u64_stats_add(&dstats->rx_bytes, len);
+	u64_stats_update_end(&dstats->syncp);
+}
+
+static inline void dev_dstats_rx_dropped(struct net_device *dev)
+{
+	struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
+
+	u64_stats_update_begin(&dstats->syncp);
+	u64_stats_inc(&dstats->rx_drops);
+	u64_stats_update_end(&dstats->syncp);
+}
+
+static inline void dev_dstats_tx_add(struct net_device *dev,
+				     unsigned int len)
+{
+	struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
+
+	u64_stats_update_begin(&dstats->syncp);
+	u64_stats_inc(&dstats->tx_packets);
+	u64_stats_add(&dstats->tx_bytes, len);
+	u64_stats_update_end(&dstats->syncp);
+}
+
+static inline void dev_dstats_tx_dropped(struct net_device *dev)
+{
+	struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
+
+	u64_stats_update_begin(&dstats->syncp);
+	u64_stats_inc(&dstats->tx_drops);
+	u64_stats_update_end(&dstats->syncp);
+}
+
 #define __netdev_alloc_pcpu_stats(type, gfp)				\
 ({									\
 	typeof(type) __percpu *pcpu_stats = alloc_percpu_gfp(type, gfp);\
-- 
2.39.2


