Return-Path: <netdev+bounces-249169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E779D1553A
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 408D4304BE53
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 20:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0200F326D65;
	Mon, 12 Jan 2026 20:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EIPWbsbg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF7733C19C
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 20:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251065; cv=none; b=QrZ/rhd8+PKK5U/NkHfwuMuArQqN++T7eD4agJBEjk32RrYgUuEkNDa+kzEt9WTIcXOwiGfQ0fEvfYg/LSYFAn2BcQGmG/5d3NKWBMzbRDmB9Qp9XWlXGTc5xMLWQcZ0UoR55boeeNfPYcvH8ZH+GFhWkm09OV2jXaUWgIwDwyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251065; c=relaxed/simple;
	bh=Iyv9cRRUO/UOcYkZb3yOqIDJpejxteLgsOjDXuBRAVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQEM9n1srpvbRwf8aZd2MB/NCULx/Fesyp++96aEteAOQdEFWTMCJ43ZKVomff4VVYIJV2QVJ8Dq9A6A4bXYEbrD/SAuPl/GL+nbDsPCSF2raaibRj9fuvEvsmrccUdVrsfg+nEiDIG4CGDs9tjhMxN3rexQienPES8V/P6bbLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EIPWbsbg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768251063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NQAmShh/qZptdYWibhZ+VLfu1vgl2kUqlDLa2oCr3A=;
	b=EIPWbsbgXcoT9Dj25+qmFPW4rPqBODkUlbK/OcoqvB6baaU3rLYSEuQbJEp6nzyV3JChhQ
	CRko+fRiZ93EqPSa+uoOZIE1O4vT8mcscjJzqNO+WO5lW0lZCKZG71NJqVsMN7TfDgQNTq
	4G2UeaIZZhQrcTcB0bBhjSW/fZogT/0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-fwLyJvvNOKKsuWPzuvOQhg-1; Mon,
 12 Jan 2026 15:50:59 -0500
X-MC-Unique: fwLyJvvNOKKsuWPzuvOQhg-1
X-Mimecast-MFC-AGG-ID: fwLyJvvNOKKsuWPzuvOQhg_1768251058
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93D181956050;
	Mon, 12 Jan 2026 20:50:57 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.212])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D00D61800577;
	Mon, 12 Jan 2026 20:50:54 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH v2 net-next 03/10] vxlan: expose gso partial features for tunnel  offload
Date: Mon, 12 Jan 2026 21:50:19 +0100
Message-ID: <801060915ffb0577cf0e6f725059c2b0ce131a30.1768250796.git.pabeni@redhat.com>
In-Reply-To: <cover.1768250796.git.pabeni@redhat.com>
References: <cover.1768250796.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Similar to the previous patch, reuse the same helpers to add tunnel GSO
partial capabilities to vxlan devices.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/vxlan/vxlan_core.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index e957aa12a8a4..7bd0ae0a6a33 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2183,11 +2183,12 @@ static int vxlan_build_skb(struct sk_buff *skb, struct dst_entry *dst,
 			   struct vxlan_metadata *md, u32 vxflags,
 			   bool udp_sum)
 {
+	int type = udp_sum ? SKB_GSO_UDP_TUNNEL_CSUM : SKB_GSO_UDP_TUNNEL;
+	__be16 inner_protocol = htons(ETH_P_TEB);
 	struct vxlanhdr *vxh;
+	bool double_encap;
 	int min_headroom;
 	int err;
-	int type = udp_sum ? SKB_GSO_UDP_TUNNEL_CSUM : SKB_GSO_UDP_TUNNEL;
-	__be16 inner_protocol = htons(ETH_P_TEB);
 
 	if ((vxflags & VXLAN_F_REMCSUM_TX) &&
 	    skb->ip_summed == CHECKSUM_PARTIAL) {
@@ -2208,6 +2209,7 @@ static int vxlan_build_skb(struct sk_buff *skb, struct dst_entry *dst,
 	if (unlikely(err))
 		return err;
 
+	double_encap = udp_tunnel_handle_partial(skb);
 	err = iptunnel_handle_offloads(skb, type);
 	if (err)
 		return err;
@@ -2238,7 +2240,7 @@ static int vxlan_build_skb(struct sk_buff *skb, struct dst_entry *dst,
 		inner_protocol = skb->protocol;
 	}
 
-	skb_set_inner_protocol(skb, inner_protocol);
+	udp_tunnel_set_inner_protocol(skb, double_encap, inner_protocol);
 	return 0;
 }
 
@@ -3348,10 +3350,18 @@ static void vxlan_setup(struct net_device *dev)
 	dev->features   |= NETIF_F_RXCSUM;
 	dev->features   |= NETIF_F_GSO_SOFTWARE;
 
+	/* Partial features are disabled by default. */
 	dev->vlan_features = dev->features;
 	dev->hw_features |= NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_FRAGLIST;
 	dev->hw_features |= NETIF_F_RXCSUM;
 	dev->hw_features |= NETIF_F_GSO_SOFTWARE;
+	dev->hw_features |= UDP_TUNNEL_PARTIAL_FEATURES;
+	dev->hw_features |= NETIF_F_GSO_PARTIAL;
+
+	dev->hw_enc_features = dev->hw_features;
+	dev->gso_partial_features = UDP_TUNNEL_PARTIAL_FEATURES;
+	dev->mangleid_features = NETIF_F_GSO_PARTIAL;
+
 	netif_keep_dst(dev);
 	dev->priv_flags |= IFF_NO_QUEUE;
 	dev->change_proto_down = true;
-- 
2.52.0


