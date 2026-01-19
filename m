Return-Path: <netdev+bounces-251153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 82036D3AEBB
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52D4F3008E28
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C263B387376;
	Mon, 19 Jan 2026 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bsfwMord"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B536387570
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768835405; cv=none; b=LSQvFB3o2pF6p7goT7ZhlujMSSnjyxm5zr8bvGBFQSStUBATGC7fzyCTxLjUjGD206bWM4d7JS7vMFTXXPldn5FpcVmptdN1ie3j/o3UE+8Xfp/t4NzSEUQVDGYce6pAg+lErtRuXn9I3TvgThJdT5fJ4Q82lGK9ZafwF3+6qMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768835405; c=relaxed/simple;
	bh=jTCuNBS4bByHDkBufa5Tn8yacqgAWm+muoWkmF00rqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZU7rzZvi4Tb7RHzbDqtoV/zMVxt5n797N13CQPSrMymDEopBEr0ULY4rocY49trgCHyBF+WGBOWer1POODUUol5mLcgMjPf6sr36oj3Et2pp65L4BOexvcjoEqMUWiDYWD7NPe/9VJUVb66bPcNoWl6CKBuA6n+f4pu1QTYnm0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bsfwMord; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768835403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cHa1b3luFbpymZa4vGHuerOU/i1ZmrQ1ilqUc3ptTWw=;
	b=bsfwMordglOs6puOrEdGzuGYCRFfuuo7y7at+VMTnodhoz8XxRFV1KH6MczgpgUILkXb3V
	QpaS1+iMh1wt5r8tkZCQG/S35M+r+8MoF3SMZrnwy+5bUyw6nJfZ1P2JNrvlAEBFVWXePO
	N3GvQomX67F7hhXOrdRzuoZmivrGYc0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-4I7ncOB7OCavVRnYGj-g5A-1; Mon,
 19 Jan 2026 10:09:59 -0500
X-MC-Unique: 4I7ncOB7OCavVRnYGj-g5A-1
X-Mimecast-MFC-AGG-ID: 4I7ncOB7OCavVRnYGj-g5A_1768835397
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8320919560A5;
	Mon, 19 Jan 2026 15:09:57 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.246])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A33C819560A2;
	Mon, 19 Jan 2026 15:09:53 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	sdf@fomichev.me,
	petrm@nvidia.com,
	razor@blackwall.org,
	idosch@nvidia.com
Subject: [PATCH v4 net-next 02/10] geneve: expose gso partial features for tunnel offload
Date: Mon, 19 Jan 2026 16:09:24 +0100
Message-ID: <904deed200f69cfa0121a59e1eb43131d8956773.1768820066.git.pabeni@redhat.com>
In-Reply-To: <cover.1768820066.git.pabeni@redhat.com>
References: <cover.1768820066.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

GSO partial features for tunnels do not require any kind of support from
the underlying device: we can safely add them to the geneve UDP tunnel.

The only point of attention is the skb required features propagation in
the device xmit op: partial features must be stripped, except for
UDP_TUNNEL*.

Keep partial features disabled by default.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/geneve.c     | 11 ++++++++++-
 include/net/udp_tunnel.h | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 77b0c3d52041..64ea4b970376 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -774,6 +774,7 @@ static int geneve_build_skb(struct dst_entry *dst, struct sk_buff *skb,
 	bool udp_sum = test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags);
 	struct genevehdr *gnvh;
 	__be16 inner_proto;
+	bool double_encap;
 	int min_headroom;
 	int err;
 
@@ -786,6 +787,7 @@ static int geneve_build_skb(struct dst_entry *dst, struct sk_buff *skb,
 	if (unlikely(err))
 		goto free_dst;
 
+	double_encap = udp_tunnel_handle_partial(skb);
 	err = udp_tunnel_handle_offloads(skb, udp_sum);
 	if (err)
 		goto free_dst;
@@ -793,7 +795,7 @@ static int geneve_build_skb(struct dst_entry *dst, struct sk_buff *skb,
 	gnvh = __skb_push(skb, sizeof(*gnvh) + info->options_len);
 	inner_proto = inner_proto_inherit ? skb->protocol : htons(ETH_P_TEB);
 	geneve_build_header(gnvh, info, inner_proto);
-	skb_set_inner_protocol(skb, inner_proto);
+	udp_tunnel_set_inner_protocol(skb, double_encap, inner_proto);
 	return 0;
 
 free_dst:
@@ -1211,9 +1213,16 @@ static void geneve_setup(struct net_device *dev)
 	dev->features    |= NETIF_F_RXCSUM;
 	dev->features    |= NETIF_F_GSO_SOFTWARE;
 
+	/* Partial features are disabled by default. */
 	dev->hw_features |= NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_FRAGLIST;
 	dev->hw_features |= NETIF_F_RXCSUM;
 	dev->hw_features |= NETIF_F_GSO_SOFTWARE;
+	dev->hw_features |= UDP_TUNNEL_PARTIAL_FEATURES;
+	dev->hw_features |= NETIF_F_GSO_PARTIAL;
+
+	dev->hw_enc_features = dev->hw_features;
+	dev->gso_partial_features = UDP_TUNNEL_PARTIAL_FEATURES;
+	dev->mangleid_features = NETIF_F_GSO_PARTIAL;
 
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
 	/* MTU range: 68 - (something less than 65535) */
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 9acef2fbd2fd..d9c6d04bb3b5 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -10,6 +10,11 @@
 #include <net/ipv6_stubs.h>
 #endif
 
+#define UDP_TUNNEL_PARTIAL_FEATURES	NETIF_F_GSO_ENCAP_ALL
+#define UDP_TUNNEL_STRIPPED_GSO_TYPES	((UDP_TUNNEL_PARTIAL_FEATURES |	\
+					  NETIF_F_GSO_PARTIAL) >>	\
+					 NETIF_F_GSO_SHIFT)
+
 struct udp_port_cfg {
 	u8			family;
 
@@ -145,6 +150,33 @@ void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 			  __be16 src_port, __be16 dst_port, bool nocheck,
 			  u16 ip6cb_flags);
 
+static inline bool udp_tunnel_handle_partial(struct sk_buff *skb)
+{
+	bool double_encap = !!(skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL);
+
+	/*
+	 * If the skb went through partial segmentation, lower devices
+	 * will not need to offload the related features - except for
+	 * UDP_TUNNEL, that will be re-added by the later
+	 * udp_tunnel_handle_offloads().
+	 */
+	if (double_encap)
+		skb_shinfo(skb)->gso_type &= ~UDP_TUNNEL_STRIPPED_GSO_TYPES;
+	return double_encap;
+}
+
+static inline void udp_tunnel_set_inner_protocol(struct sk_buff *skb,
+						 bool double_encap,
+						 __be16 inner_proto)
+{
+	/*
+	 * The inner protocol has been set by the nested tunnel, don't
+	 * overraid it.
+	 */
+	if (!double_encap)
+		skb_set_inner_protocol(skb, inner_proto);
+}
+
 void udp_tunnel_sock_release(struct socket *sock);
 
 struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
-- 
2.52.0


