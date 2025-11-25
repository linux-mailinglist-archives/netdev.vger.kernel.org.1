Return-Path: <netdev+bounces-241561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D40C85E36
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 17:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C75834E3EBE
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 16:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A6A23EA81;
	Tue, 25 Nov 2025 16:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pvy/lnYn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1A4226D00
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087103; cv=none; b=EymJ80w2NPV1Dm75NvFY5vgPQc/GadxhcZwBDfh20/hcA9RkvDIN2M5VovmL5zXmF8poQzh5kFZnYo8OJ7givFO0QBxoF2V+sUGCFj9DYNZ9ugaSvYg6zu28D5CEgAnAB1FDqpS6RPQCYtRKYgI2KzpbNlInxjdY34cYU1hMBHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087103; c=relaxed/simple;
	bh=a3K8dCPSiQeBDG3gAvnM84IoDmDU/3TIAXkSQmph5fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKq0nkIGhN4vfcdkTtsZWTVMuqcp7CLECOo2BXg5ME9fQkbVCkd1M4cUkmATx6KufThbpkerspqKwdYmOmfNyxQtF/364pth8Y7jIk40WXmW82E74FaIyxV6S5YrmQiNk9x3Gbqx78s8fpvx5xVxJHCSi+B0vGhJLJqVdCnJO4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pvy/lnYn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764087101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unn8BFm1U9dn5V8Qe9z1zDN3GveU/qGPGztM49c0zU4=;
	b=Pvy/lnYnreMwQqSeGuehTcS15F7eOUVNlNb4A2tSqFGqKlg/CKBb9WJPj+6ZRTRw3B+KLF
	EUc/QBBHCqLiE+qiU9FPQY1tHcFGdYyvmCljiC8LOV1djo8YOD2hB0Wh8Na7glxiJo4Pj6
	Uuil0dHIWL4ObyP3OzqdYOeUH4BhO64=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-f3ECIH1qMj6ROcvl15dR5A-1; Tue,
 25 Nov 2025 11:11:40 -0500
X-MC-Unique: f3ECIH1qMj6ROcvl15dR5A-1
X-Mimecast-MFC-AGG-ID: f3ECIH1qMj6ROcvl15dR5A_1764087098
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A1741956068;
	Tue, 25 Nov 2025 16:11:38 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.183])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7472E1800451;
	Tue, 25 Nov 2025 16:11:35 +0000 (UTC)
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
Subject: [PATCH net-next 03/10] vxlan: expose gso partial features for tunnel  offload
Date: Tue, 25 Nov 2025 17:11:08 +0100
Message-ID: <e6cc710c9d54ec6057c36ca026878df0cff66766.1764056123.git.pabeni@redhat.com>
In-Reply-To: <cover.1764056123.git.pabeni@redhat.com>
References: <cover.1764056123.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Similar to the previous patch, reuse the same helpers to add tunnel GSO
partial capabilities to vxlan devices.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/vxlan/vxlan_core.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index a5c55e7e4d79..d3fed41e390e 100644
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
 
@@ -3336,10 +3338,18 @@ static void vxlan_setup(struct net_device *dev)
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


