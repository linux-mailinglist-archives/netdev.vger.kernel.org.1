Return-Path: <netdev+bounces-251981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LEiNE/+cGmgbAAAu9opvQ
	(envelope-from <netdev+bounces-251981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 17:26:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5237959DFE
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 17:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1686D9AF780
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAED6221DB9;
	Wed, 21 Jan 2026 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PlHdxl/b"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7602EC080
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769011961; cv=none; b=EPfK2HruKhEnVBELULDGL+xhdpI4x2TslVSZdtp36tczxuwOQffA/YYBC62uIiNmcR0HmEbN/o7LWC3GGuV4y++lBNAz4/lbZsPqtmmBqK9IuIVwdqWyTOsh/sA2zE8l9fJkviX5PM54JZ8uffFmT4XP6UkyqVCRbh07Y09qnms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769011961; c=relaxed/simple;
	bh=Iyv9cRRUO/UOcYkZb3yOqIDJpejxteLgsOjDXuBRAVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VixT6p/BbuFueLAkL7Ps4m5g2N+vysp76rFTKeZDIBuxcUSdmKmHv8f2Esnm5u8f90u+yR4lG0jbr3mEvYh4jmVuuOYBYK1zgOhX2gnK0JfciMFdTOK8Kkds9sOlHVizPSV0sIAcs0inYVbJPnAY4OJDNdIZva5RoG08eKXq+U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PlHdxl/b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769011959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NQAmShh/qZptdYWibhZ+VLfu1vgl2kUqlDLa2oCr3A=;
	b=PlHdxl/bAbn26FQTqX3xnQdgNl1+HBaNn3fWv6yvj4SebFu1SIqz+jnvGqXr4QX/5uUPUo
	+yE+Y4IMF8yUuJ0/IXCQWGdMMIhZz5GukP8Bd/DY8aJ33xR4qM3yv0omyv85iDWj9WdS9Z
	L/62akFdMiRfnI4VX0DUTUVXW7Iyyfg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-z1yepD-fOGSGqzS37GPjfQ-1; Wed,
 21 Jan 2026 11:12:34 -0500
X-MC-Unique: z1yepD-fOGSGqzS37GPjfQ-1
X-Mimecast-MFC-AGG-ID: z1yepD-fOGSGqzS37GPjfQ_1769011950
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 237DF180AE28;
	Wed, 21 Jan 2026 16:12:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.3])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 641281800240;
	Wed, 21 Jan 2026 16:12:20 +0000 (UTC)
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
Subject: [PATCH v5 net-next 03/10] vxlan: expose gso partial features for tunnel  offload
Date: Wed, 21 Jan 2026 17:11:29 +0100
Message-ID: <93d916c11b3a790a8bfccad77d9e85ee6e533042.1769011015.git.pabeni@redhat.com>
In-Reply-To: <cover.1769011015.git.pabeni@redhat.com>
References: <cover.1769011015.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251981-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,gmail.com,lunn.ch,fomichev.me,nvidia.com,blackwall.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	DKIM_TRACE(0.00)[redhat.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 5237959DFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


