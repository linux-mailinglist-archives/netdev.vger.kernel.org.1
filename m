Return-Path: <netdev+bounces-175220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ADDA646E3
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 10:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7252164515
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 09:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E2E207E19;
	Mon, 17 Mar 2025 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWkoXdoQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECD921D004
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203134; cv=none; b=sLVIPJ7LBBWMcWeeuZhOkSh4SZq73RCHCxjqFOHGvl4iVbFxc3UfZrUQpFKyzccDyqApvjB2UB5W4cmQUsA9fwxBvJz/+Mk/xFd2r6PN+E114wA2dIuLrI6WygRlbrWMOpstu07+Dj0Fby29oLArFyIkqIOkk/M9gKADXpISjj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203134; c=relaxed/simple;
	bh=3mPlwalOPQ1VO7uMKFFriOtaxEf/Tcp5VA442ht+PuI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pkKVpzP42lU4nopaTnIVJxstpoR9veA2axbTsFqzl+5uFurYPwuD89hKe7Es3FEFNJZh/Ls6znfNkm9fcCJXwa/63RG1E/XXyGEuYc4CFlrnGgPxVff+1tvWhuaArJjPy9mUj3DEeQfzcIC/9LSnUzEuXWSAaGQauZkwY3lm1tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GWkoXdoQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742203131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A/aRVgPseyyNQZgE6iFAeS3OR5iBB1bxTm1iiEFM9g8=;
	b=GWkoXdoQvv1Dg+Qljqo6mzpk/l+CBZ0UvNtI4uyXLh45h2vvgkLFqtphZ9vzg5Jy8Mg3TC
	g/GTxKt3F1UhUXLYKlF0CcUD7SH6J5c60lEpAhjSz+5BvBBMdmFbmB1zP2OmcDvgc2ZlwF
	qbEw00qDnS1phVciCKgbN0DdlT08cvY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-MLen6xqTP3aHxxnik6QfiQ-1; Mon, 17 Mar 2025 05:18:50 -0400
X-MC-Unique: MLen6xqTP3aHxxnik6QfiQ-1
X-Mimecast-MFC-AGG-ID: MLen6xqTP3aHxxnik6QfiQ_1742203129
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf172ff63so10836275e9.3
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 02:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742203128; x=1742807928;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A/aRVgPseyyNQZgE6iFAeS3OR5iBB1bxTm1iiEFM9g8=;
        b=ScjKjK4ORzLja1OPyTb0nZPvYS9OrMaytPX5Wkfz2HiZfOBg+mSZMqNBcbSjCbBK79
         tCOltVK/uXxUYcuxE+IvXt1vlWaawxk8yQRhF3nmQlsmMyk2Q02ZBrE0FwEvyPA1/Jma
         sfitJrjez7N353tg1bh+z4RAmAwkRm2nxB3MkfdMgq4uBEoN5zZcIystVRPUu3hGKgX7
         1DhNW9MBiGs4/8Fs5D5Z0yZK6mMi40cHRVq7BvNO6euVIQW575ZIDQMurmNb8WqavAAa
         EMeG8LQAogvD9LG4tYs8sKyD3osMZPPXLO1cf60EZhBHkE6dxPT1lT3Bm1mPrAd0PADH
         7jqA==
X-Gm-Message-State: AOJu0YyIlQBMKqvxv/Nk+kV1dIrBQZyyEzv/9QdltFsuWAgs5Qz0T+6d
	WSCYfztgqqbetZCByhkZjSRQxwErbQsEc41p1e23nd3T6WHziXx1BtEetga0BBTfPu1eDLIv79T
	PlgQXjudRR9c1f4QuWGg8Qq4a2sfIL/o8dK9OQKSJHp4Sgx8xDD9WliNLP9mkX410mFxtjqyaBJ
	vSYk1hn3BZM1UVoiC7pytfSguJt6VXzqINHMY=
X-Gm-Gg: ASbGncvJ8V2n8PwKSoxvN4+e2Z+NeEgdQQiqw4D40zFc3zJfITyLZJpP5MRRRnVb/ZS
	6WApVIdggMtL5yJktH8yI+zp9Lu2vmfv6CB7bw65lyy6duGnxN5Gcvo6vTQ2KgpG3Hrnbwdnb6V
	/4hhHZKFyhXjeJG7Ky5CDNaBrpcGuayB8yW0apXHowPzchdJp7EpLKwwK4MVRA/ond8Sxu/sXfv
	gqrFMXVyUOgrdCnn3eamLdBBxz0yLRhd4IK9HnCGWd4mE44D0R3eBj//amv2+8GqtTgncqxEkUH
	VMDZM07eEk6MX6QDzTZDMpDJ1I5WNewc+FUSrU4k0m5HGg==
X-Received: by 2002:a05:600c:19d1:b0:43c:f8fc:f687 with SMTP id 5b1f17b1804b1-43d1ecd2f55mr97909975e9.27.1742203128319;
        Mon, 17 Mar 2025 02:18:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnPlpyt7znHsnkdN4L152X7YYF4XchpC/zqdJhxK9cZ3zg7/v69hXaJ8a4OSboSa6/jCOt8w==
X-Received: by 2002:a05:600c:19d1:b0:43c:f8fc:f687 with SMTP id 5b1f17b1804b1-43d1ecd2f55mr97909675e9.27.1742203127831;
        Mon, 17 Mar 2025 02:18:47 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d2010e2d6sm98482225e9.38.2025.03.17.02.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 02:18:47 -0700 (PDT)
Message-ID: <1c9188a9-2b22-4350-ac99-3a5048ccd440@redhat.com>
Date: Mon, 17 Mar 2025 10:18:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] net: hotdata optimization for netns ptypes
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Sabrina Dubroca <sd@queasysnail.net>
References: <cover.1741957452.git.pabeni@redhat.com>
 <0f44b47dd83152000e35355e4f9096a72ead7b87.1741957452.git.pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <0f44b47dd83152000e35355e4f9096a72ead7b87.1741957452.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/14/25 2:05 PM, Paolo Abeni wrote:
> Per netns ptype usage is/should be an exception, but the current code
> unconditionally touches the related lists for each RX and TX packet.
> 
> Add a per device flag in the hot data net_device section to cache the
> 'netns ptype required' information, and update it accordingly to the
> relevant netns status. The new fields are placed in existing holes,
> moved slightly to fit the relevant cacheline groups.
> 
> Be sure to keep such flag up2date when new devices are created and/or
> devices are moved across namespaces initializing it in list_netdevice().
> 
> In the fast path we can skip per-netns list processing when such patch
> is clear.
> 
> This avoid touching in the fastpath the additional cacheline needed by
> the previous patch.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> This is a little cumbersome for possibly little gain. An alternative
> could be caching even the per-device list status in similar
> flags. Both RX and TX could use a single conditional to completely
> skip all the per dev/netns list. Potentially even moving the per
> device lists out of hotdata.
> 
> Side note: despite being unconditionally touched in fastpath on both
> RX and TX, currently dev->ptype_all is not placed in any cacheline
> group hotdata.

I think we could consider not empty ptype_all/specific lists as slightly
less fast path - packet socket processing will add considerable more
overhead.

If, so we could consolidate the packet type checks in a couple of read
mostly counters in hotdata, decreasing both the number of conditionals
and the data set size in fastpath. I'll test something alike the following:

---
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0dbfe069a6e38..755dc9d9f9f4a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2134,7 +2134,6 @@ struct net_device {
 	/* RX read-mostly hotpath */
 	__cacheline_group_begin(net_device_read_rx);
 	struct bpf_prog __rcu	*xdp_prog;
-	struct list_head	ptype_specific;
 	int			ifindex;
 	unsigned int		real_num_rx_queues;
 	struct netdev_rx_queue	*_rx;
@@ -2174,6 +2173,7 @@ struct net_device {
 	struct list_head	unreg_list;
 	struct list_head	close_list;
 	struct list_head	ptype_all;
+	struct list_head	ptype_specific;

 	struct {
 		struct list_head upper;
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index bd57d8fb54f14..41ea0febf2260 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -575,6 +575,26 @@ static inline void fnhe_genid_bump(struct net *net)
 	atomic_inc(&net->fnhe_genid);
 }

+static inline int net_ptype_all_cnt(const struct net *net)
+{
+	return READ_ONCE(net->ipv4.ptype_all_count);
+}
+
+static inline void net_ptype_all_set_cnt(struct net *net, int cnt)
+{
+	WRITE_ONCE(net->ipv4.ptype_all_count, cnt);
+}
+
+static inline int net_ptype_specific_cnt(const struct net *net)
+{
+	return READ_ONCE(net->ipv4.ptype_specific_count);
+}
+
+static inline void net_ptype_specific_set_cnt(struct net *net, int cnt)
+{
+	WRITE_ONCE(net->ipv4.ptype_specific_count, cnt);
+}
+
 #ifdef CONFIG_NET
 void net_ns_init(void);
 #else
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 6373e3f17da84..8df28c3c88929 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -75,6 +75,8 @@ struct netns_ipv4 {
 	/* TXRX readonly hotpath cache lines */
 	__cacheline_group_begin(netns_ipv4_read_txrx);
 	u8 sysctl_tcp_moderate_rcvbuf;
+	/* 2 bytes hole */
+	int ptype_all_count;
 	__cacheline_group_end(netns_ipv4_read_txrx);

 	/* RX readonly hotpath cache line */
@@ -82,9 +84,10 @@ struct netns_ipv4 {
 	u8 sysctl_ip_early_demux;
 	u8 sysctl_tcp_early_demux;
 	u8 sysctl_tcp_l3mdev_accept;
-	/* 3 bytes hole, try to pack */
+	/* 1 bytes hole, try to pack */
 	int sysctl_tcp_reordering;
 	int sysctl_tcp_rmem[3];
+	int ptype_specific_count;
 	__cacheline_group_end(netns_ipv4_read_rx);

 	struct inet_timewait_death_row tcp_death_row;
diff --git a/net/core/dev.c b/net/core/dev.c
index ad1853da0a4b5..51cce0a164937 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -603,11 +603,18 @@ static inline struct list_head *ptype_head(const
struct packet_type *pt)
 void dev_add_pack(struct packet_type *pt)
 {
 	struct list_head *head = ptype_head(pt);
+	struct net *net;

 	if (WARN_ON_ONCE(!head))
 		return;

 	spin_lock(&ptype_lock);
+	net = pt->dev ? dev_net(pt->dev) : pt->af_packet_net;
+	if (pt->type == htons(ETH_P_ALL))
+		net_ptype_all_set_cnt(net, net_ptype_all_cnt(net) + 1);
+	else
+		net_ptype_specific_set_cnt(net,
+					   net_ptype_specific_cnt(net) + 1);
 	list_add_rcu(&pt->list, head);
 	spin_unlock(&ptype_lock);
 }
@@ -630,6 +637,7 @@ void __dev_remove_pack(struct packet_type *pt)
 {
 	struct list_head *head = ptype_head(pt);
 	struct packet_type *pt1;
+	struct net *net;

 	if (!head)
 		return;
@@ -637,10 +645,16 @@ void __dev_remove_pack(struct packet_type *pt)
 	spin_lock(&ptype_lock);

 	list_for_each_entry(pt1, head, list) {
-		if (pt == pt1) {
-			list_del_rcu(&pt->list);
-			goto out;
-		}
+		if (pt != pt1)
+			continue;
+		list_del_rcu(&pt->list);
+		net = pt->dev ? dev_net(pt->dev) : pt->af_packet_net;
+		if (pt->type == htons(ETH_P_ALL))
+			net_ptype_all_set_cnt(net, net_ptype_all_cnt(net) - 1);
+		else
+			net_ptype_specific_set_cnt(net,
+					      net_ptype_specific_cnt(net) - 1);
+		goto out;
 	}

 	pr_warn("dev_remove_pack: %p not found\n", pt);
@@ -2483,8 +2497,7 @@ static inline bool skb_loop_sk(struct packet_type
*ptype, struct sk_buff *skb)
  */
 bool dev_nit_active(struct net_device *dev)
 {
-	return !list_empty(&dev_net(dev)->ptype_all) ||
-	       !list_empty(&dev->ptype_all);
+	return net_ptype_all_cnt(dev_net(dev)) > 0;
 }
 EXPORT_SYMBOL_GPL(dev_nit_active);

@@ -5671,11 +5684,49 @@ static inline int nf_ingress(struct sk_buff
*skb, struct packet_type **pt_prev,
 	return 0;
 }

+static int deliver_ptype_all_skb(struct sk_buff *skb, int ret,
+				 struct packet_type **ppt_prev,
+				 struct net_device *orig_dev)
+{
+	struct packet_type *ptype, *pt_prev = *ppt_prev;
+
+	list_for_each_entry_rcu(ptype, &dev_net(skb->dev)->ptype_all, list) {
+		if (pt_prev)
+			ret = deliver_skb(skb, pt_prev, orig_dev);
+		pt_prev = ptype;
+	}
+
+	list_for_each_entry_rcu(ptype, &skb->dev->ptype_all, list) {
+		if (pt_prev)
+			ret = deliver_skb(skb, pt_prev, orig_dev);
+		pt_prev = ptype;
+	}
+	*ppt_prev = pt_prev;
+	return ret;
+}
+
+static void deliver_ptype_specific_skb(struct sk_buff *skb, bool
deliver_exact,
+				       struct packet_type **ppt_prev,
+				       struct net_device *orig_dev,
+				       __be16 type)
+{
+	if (deliver_exact)
+		deliver_ptype_list_skb(skb, ppt_prev, orig_dev, type,
+				       &dev_net(skb->dev)->ptype_specific);
+
+	deliver_ptype_list_skb(skb, ppt_prev, orig_dev, type,
+			       &orig_dev->ptype_specific);
+
+	if (unlikely(skb->dev != orig_dev))
+		deliver_ptype_list_skb(skb, ppt_prev, orig_dev, type,
+				       &skb->dev->ptype_specific);
+}
+
 static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 				    struct packet_type **ppt_prev)
 {
-	struct packet_type *ptype, *pt_prev;
 	rx_handler_func_t *rx_handler;
+	struct packet_type *pt_prev;
 	struct sk_buff *skb = *pskb;
 	struct net_device *orig_dev;
 	bool deliver_exact = false;
@@ -5732,17 +5783,8 @@ static int __netif_receive_skb_core(struct
sk_buff **pskb, bool pfmemalloc,
 	if (pfmemalloc)
 		goto skip_taps;

-	list_for_each_entry_rcu(ptype, &dev_net(skb->dev)->ptype_all, list) {
-		if (pt_prev)
-			ret = deliver_skb(skb, pt_prev, orig_dev);
-		pt_prev = ptype;
-	}
-
-	list_for_each_entry_rcu(ptype, &skb->dev->ptype_all, list) {
-		if (pt_prev)
-			ret = deliver_skb(skb, pt_prev, orig_dev);
-		pt_prev = ptype;
-	}
+	if (net_ptype_all_cnt(dev_net(skb->dev)) > 0)
+		ret = deliver_ptype_all_skb(skb, ret, &pt_prev, orig_dev);

 skip_taps:
 #ifdef CONFIG_NET_INGRESS
@@ -5840,21 +5882,14 @@ static int __netif_receive_skb_core(struct
sk_buff **pskb, bool pfmemalloc,
 	type = skb->protocol;

 	/* deliver only exact match when indicated */
-	if (likely(!deliver_exact)) {
+	if (likely(!deliver_exact))
 		deliver_ptype_list_skb(skb, &pt_prev, orig_dev, type,
 				       &ptype_base[ntohs(type) &
 						   PTYPE_HASH_MASK]);
-		deliver_ptype_list_skb(skb, &pt_prev, orig_dev, type,
-				       &dev_net(orig_dev)->ptype_specific);
-	}
-
-	deliver_ptype_list_skb(skb, &pt_prev, orig_dev, type,
-			       &orig_dev->ptype_specific);

-	if (unlikely(skb->dev != orig_dev)) {
-		deliver_ptype_list_skb(skb, &pt_prev, orig_dev, type,
-				       &skb->dev->ptype_specific);
-	}
+	if (net_ptype_specific_cnt(dev_net(skb->dev)) > 0)
+		deliver_ptype_specific_skb(skb, deliver_exact, &pt_prev,
+					   orig_dev, type);

 	if (pt_prev) {
 		if (unlikely(skb_orphan_frags_rx(skb, GFP_ATOMIC)))
@@ -12566,7 +12601,6 @@ static void __init net_dev_struct_check(void)
 	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_txrx, 46);

 	/* RX read-mostly hotpath */
-	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx,
ptype_specific);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx,
ifindex);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx,
real_num_rx_queues);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, _rx);
@@ -12581,7 +12615,7 @@ static void __init net_dev_struct_check(void)
 #ifdef CONFIG_NET_XGRESS
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx,
tcx_ingress);
 #endif
-	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_rx, 92);
+	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_rx, 76);
 }

 /*
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index b0dfdf791ece5..551355665aaee 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -1174,7 +1174,7 @@ static void __init netns_ipv4_struct_check(void)
 	/* TXRX readonly hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_txrx,
 				      sysctl_tcp_moderate_rcvbuf);
-	CACHELINE_ASSERT_GROUP_SIZE(struct netns_ipv4, netns_ipv4_read_txrx, 1);
+	CACHELINE_ASSERT_GROUP_SIZE(struct netns_ipv4, netns_ipv4_read_txrx, 7);

 	/* RX readonly hotpath cache line */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_rx,
@@ -1187,7 +1187,7 @@ static void __init netns_ipv4_struct_check(void)
 				      sysctl_tcp_reordering);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_rx,
 				      sysctl_tcp_rmem);
-	CACHELINE_ASSERT_GROUP_SIZE(struct netns_ipv4, netns_ipv4_read_rx, 22);
+	CACHELINE_ASSERT_GROUP_SIZE(struct netns_ipv4, netns_ipv4_read_rx, 24);
 }
 #endif


