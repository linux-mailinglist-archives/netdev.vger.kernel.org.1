Return-Path: <netdev+bounces-251154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E66CD3AEA3
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 757B6308D1D4
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2644C387579;
	Mon, 19 Jan 2026 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="if51nRhs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12F0387569
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768835411; cv=none; b=ohDZYW/bLMdh/g0+fxaRbO41IsUgcj0uHA0hpMsxgF9JtoaF8I5mECMM1kNJPdXp4MpMKahaPMhhknoqxBQFXFBwvzBTRlHa9gwKWh5apiKLf5S0tAGaQWX5l7geF0o77Ak3qJE6XN0HVl78ZunGrZ3vDp2YQOKwLRriQjmZdUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768835411; c=relaxed/simple;
	bh=Iyv9cRRUO/UOcYkZb3yOqIDJpejxteLgsOjDXuBRAVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzl1e5luYotAHyl2eiMTLCNMlavqI2H9juK0E+2tFk//xZWSNGQ3RdYTjtHEW65ouZs6OpR4gz/JQLZGfCrqHIun2Pdh69i18EntN6svhrBkSQQyRicaWB+GWjHniKgmuHkN6tNPK3sBB8fx5mgtrkr5I/9pow8hi1mzClx4nzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=if51nRhs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768835408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NQAmShh/qZptdYWibhZ+VLfu1vgl2kUqlDLa2oCr3A=;
	b=if51nRhs5VSl+hLTiuf32jVUUOLqM05QTIfYzGEUZ8xAo3XtBACCy3NfMovPJdjmlf3LHp
	dG7angDQLPKZRAtG/+FsbCo7BNAVy6YtB8uzqcLAEB2hsCDxPUUuM3CCIoYPyW4nvccj+7
	TOcNOFxhaC6CdxGS8CQY8JrykpJrJA4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-O54iR1e8MFq3ziLUTf1giw-1; Mon,
 19 Jan 2026 10:10:04 -0500
X-MC-Unique: O54iR1e8MFq3ziLUTf1giw-1
X-Mimecast-MFC-AGG-ID: O54iR1e8MFq3ziLUTf1giw_1768835402
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39648180057E;
	Mon, 19 Jan 2026 15:10:02 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.246])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 05B6B19560A2;
	Mon, 19 Jan 2026 15:09:57 +0000 (UTC)
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
Subject: [PATCH v4 net-next 03/10] vxlan: expose gso partial features for tunnel  offload
Date: Mon, 19 Jan 2026 16:09:25 +0100
Message-ID: <993bea5dfc5630d916716a9e3ae9b523a0e636ee.1768820066.git.pabeni@redhat.com>
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


