Return-Path: <netdev+bounces-148960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 625249E3994
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 13:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70C9B164847
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 12:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F243D1B2EEB;
	Wed,  4 Dec 2024 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eot+NTBW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3CA1B85EC
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 12:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733314290; cv=none; b=lyAZj+IplTfjnvlVh65ONjOobcsyetwyYKPjApLswMYXBiuSpPGtdcjZFXmMeK34FKYfhhDZoxIq6SHK0+cHXMLNQeB0ZWv816IQE1lbdWf2+2H7dBRR2R8ZDF13DwfTKMLukX//IEQknOh9k8ezYIiRIOAZKPgDAzAhauBMP1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733314290; c=relaxed/simple;
	bh=7FdhGhZv7UmJ6QLMBj2IsyOMMIalmzX8AxuBf8HzoaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHSOma4bTzY+HftH7kxSPsGKOqz0bMM0uuxJP1qqy24nPd2qIluthfVngRgplGHhgLavWQpkVinzEIwVoaw/Lex9K+u9v1x1KwxmIPV2JjDO0Jdv2JZ17P2JCtPnsUgO84vCfKo9YDr3LGdVj3LdDVGk75HQ0r/pqpzA6LvW+Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eot+NTBW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733314286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z4L8JmK7KuxK0SRH8yQjr9o0sihITRATo0zsAKFs2f8=;
	b=Eot+NTBW3T8k4R+MuBivRqQVyJWipVSHQjdPtMfhZJxiOHHOdIxnLrdX1Tn6L/vPJlE0Yc
	rsI+3b9qdNVyIQaUfAqQdEUvB2m+jAnyAT5Xb3K/+NsukU48vJlNPgjvUAmv1Eanvcvr26
	hLRByNZ5XTl+SFge1RJZUHssr4yjZMQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-vCaxrinYMea9ua7sjzPwSA-1; Wed, 04 Dec 2024 07:11:25 -0500
X-MC-Unique: vCaxrinYMea9ua7sjzPwSA-1
X-Mimecast-MFC-AGG-ID: vCaxrinYMea9ua7sjzPwSA
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3860bc1d4f1so353909f8f.2
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 04:11:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733314284; x=1733919084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4L8JmK7KuxK0SRH8yQjr9o0sihITRATo0zsAKFs2f8=;
        b=ddJT3kWVk8AUqQtoh/32WKEB1iZgxasNgHWbRyQBxDcYtUUZqQyqaFB0h1jK7P+Rrm
         ol9KqNms89CWTGQAJtPJKJDUZlBPZtXyb5kDrdLXEuw6ITzUt1GaNZ/1IRZX2zHAWSGN
         TqokJ56tiE9ziFivym4CE0U80KNxQgdfazqE+FXgTnz4T3aXjQKm2g2Sq0osILLooCFD
         zHpyShZaVNLtWW7Jf7uXBA9MJq7E/7NBbavBDSQcvjgPi4UVs7CVRKLm8Q8TkBk8Ho/3
         EEIg6z3+hkpuN8LaQvh85MAgviArRsn8HFjwkpHxNm4HQYggiTE+9ISGJ3jzQ0ga/BLu
         rhvA==
X-Gm-Message-State: AOJu0YyPpwfVT9XxJjhJx3AWMXpHJ1FhHcd4nf/ZoYyruLDANEb3VKKr
	bZOLI9n+8ecdRUF2ozV4XM6GRYbv+vqgqmU8UonYGOUIdLvPPGYy6pme3izPuu9Wtaz65EVw7U5
	uopqNAgavPuSVczF1OC23KfLAgQYKCWZ5orus+XURd2y4gek1DQTtrw==
X-Gm-Gg: ASbGnctC1XfIAqlsEnuuq8PkYnAmx81S/RxBR/3MnG6uQw1uhEMyAzbBSmCbTr16prw
	jqhiS4HBYx01rfmiTkwf2OB02zb9HsX+5fn4KxhpPcegTqmTH7b1l+oZ1iFzP5sC9oEhq6b2taa
	S2DDFnZ2WOjMYr/69g2omDP2sQnhxaM+AbJUflDqcG2/w5x2a89Fyi5FIARPGCa39sdZSqXHCjE
	IA8syRtDFUOCp7+iDkYdpYM1OmUDCSx2/qDGw2Nj1WSPajv4C6kotI0AKcbD3yrhd03E/ovG12A
	+1f5xiquvy9Zo1QRT+dyGuC+w+j38Q==
X-Received: by 2002:a05:6000:1863:b0:381:b68f:d14b with SMTP id ffacd0b85a97d-385fd421382mr5580331f8f.45.1733314283860;
        Wed, 04 Dec 2024 04:11:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUlPCax5z0ukwUGxJXDgs27TwWgaDWjDHDa0gUEr1vtujuo9Zk4eVVqNiQCgt/txXQCDlMMg==
X-Received: by 2002:a05:6000:1863:b0:381:b68f:d14b with SMTP id ffacd0b85a97d-385fd421382mr5580306f8f.45.1733314283461;
        Wed, 04 Dec 2024 04:11:23 -0800 (PST)
Received: from debian (2a01cb058d23d600b242516949266d33.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:b242:5169:4926:6d33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ee4d932asm9847406f8f.26.2024.12.04.04.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 04:11:23 -0800 (PST)
Date: Wed, 4 Dec 2024 13:11:21 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net-next v2 1/4] vrf: Make pcpu_dstats update functions
 available to other modules.
Message-ID: <d7a552ee382c79f4854e7fcc224cf176cd21150d.1733313925.git.gnault@redhat.com>
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
 drivers/net/vrf.c         | 49 +++++++++++----------------------------
 include/linux/netdevice.h | 40 ++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 35 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 67d25f4f94ef..ca81b212a246 100644
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
@@ -578,20 +563,14 @@ static netdev_tx_t is_ip_tx_frame(struct sk_buff *skb, struct net_device *dev)
 
 static netdev_tx_t vrf_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
-
-	int len = skb->len;
-	netdev_tx_t ret = is_ip_tx_frame(skb, dev);
-
-	u64_stats_update_begin(&dstats->syncp);
-	if (likely(ret == NET_XMIT_SUCCESS || ret == NET_XMIT_CN)) {
+	unsigned int len = skb->len;
+	netdev_tx_t ret;
 
-		u64_stats_inc(&dstats->tx_packets);
-		u64_stats_add(&dstats->tx_bytes, len);
-	} else {
-		u64_stats_inc(&dstats->tx_drops);
-	}
-	u64_stats_update_end(&dstats->syncp);
+	ret = is_ip_tx_frame(skb, dev);
+	if (likely(ret == NET_XMIT_SUCCESS || ret == NET_XMIT_CN))
+		dev_dstats_tx_add(dev, len);
+	else
+		dev_dstats_tx_dropped(dev);
 
 	return ret;
 }
@@ -1364,7 +1343,7 @@ static struct sk_buff *vrf_ip6_rcv(struct net_device *vrf_dev,
 	if (!is_ndisc) {
 		struct net_device *orig_dev = skb->dev;
 
-		vrf_rx_stats(vrf_dev, skb->len);
+		dev_dstats_rx_add(vrf_dev, skb->len);
 		skb->dev = vrf_dev;
 		skb->skb_iif = vrf_dev->ifindex;
 
@@ -1420,7 +1399,7 @@ static struct sk_buff *vrf_ip_rcv(struct net_device *vrf_dev,
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


