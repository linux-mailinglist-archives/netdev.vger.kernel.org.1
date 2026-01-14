Return-Path: <netdev+bounces-249900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEBBD2082F
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 18:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A77DB3019E23
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 17:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FFE2F3621;
	Wed, 14 Jan 2026 17:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezh9dEgY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607482F83A7
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411286; cv=none; b=q+wGxMoHl7gzBeHeuO/D7huq5M+rdN13daIBNgyooVfHRfJ1gbeyd84AmNOaLAuwxvf4XGZCkjtmamMVhXU7R1t7/7ExO5NM0sXxvHHn0YHKwJpGyqHycbUdu9Vigy6uiVdO7sz8R+XdutGVMRAdiNgrj+OxDfFRm53FRRcoF5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411286; c=relaxed/simple;
	bh=Iyv9cRRUO/UOcYkZb3yOqIDJpejxteLgsOjDXuBRAVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oh12ui0lI8XiOKsZtNodRFAA3LKLqjPbT1dD4R8cfGvYjvCzyO6d4dyuNZbHP7tqmHVuMM0EGKTYhZ6beht0Cg8Q8Rhg5+exkLBGE4MZtln+UPX3IPCVVKw+l3RoVCvhIcPQetq5g58X0pl0kx0S6WJ3f9n9h6rpYJQ4qK5Pjgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ezh9dEgY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768411284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NQAmShh/qZptdYWibhZ+VLfu1vgl2kUqlDLa2oCr3A=;
	b=ezh9dEgYmprzZNlrK5cRlBgRZGQmr+mV0RDsUKLdii2hU2pv74FImVoPdhs+NvcQqV7cTT
	39+XLaIZqyccMiaLT7qgVx9dF4KEPBiQ7bl8i4miXf8+W+hdQcU73yZeFraE1jKjw/4S8l
	OAYmit7QSyJ9Nyi8PPlsUtTbwZZHTzk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-dSesxxrYNMaAcMN-ThJ8vQ-1; Wed,
 14 Jan 2026 12:21:22 -0500
X-MC-Unique: dSesxxrYNMaAcMN-ThJ8vQ-1
X-Mimecast-MFC-AGG-ID: dSesxxrYNMaAcMN-ThJ8vQ_1768411281
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D688E1800473;
	Wed, 14 Jan 2026 17:21:20 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.130])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E76E719560BA;
	Wed, 14 Jan 2026 17:21:16 +0000 (UTC)
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
Subject: [PATCH v3 net-next 03/10] vxlan: expose gso partial features for tunnel  offload
Date: Wed, 14 Jan 2026 18:20:36 +0100
Message-ID: <4e1b48de270fee82be2eb0d8f81c26e3f8b167b7.1768410519.git.pabeni@redhat.com>
In-Reply-To: <cover.1768410519.git.pabeni@redhat.com>
References: <cover.1768410519.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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


