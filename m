Return-Path: <netdev+bounces-239830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79055C6CD78
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 06:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62AC14ECCCA
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 05:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D71312813;
	Wed, 19 Nov 2025 05:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wxVBI6cg"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9259312802
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 05:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763531736; cv=none; b=d9hNhg86fjp8ZNP36HB7ebcXmJJ0VZamS4KW2q7yNIefiVAcCKlBfPcSpABkmwhXx8v3AHTYNCbPfbe6cl1l1TqjHEfsUbiyX+cAkvBJJg2FfLR46GGbirqiozmdnDIXU/EhCUYNw0z+v96jrPgqe/rwzSB00MFhrXg4LmxZ9jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763531736; c=relaxed/simple;
	bh=2nSnaxPShELRLY7QrgiHcKMI/panSkiAQ3XHL6WGI0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XWBSGuMhRxZCaT9khr7loxupOaYwkQHOYPR2YBFVvP1uJMyGLTPGSW3n0B2n21kR3AkkJEaTTr1L+Wg0f5Tgn5ACxtlMjpruK03Mrxg7L9TN8GzkYQmPX3RsR5z+oLKP3MrNT7w9nHZMDQvZdnzweMLBWucUIa9avz6nKsyeKwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wxVBI6cg; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763531725; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=AlGXh73vPzl0nwV+Ux5xYPQEmSA1kxoAQsmEUzFQIJo=;
	b=wxVBI6cg43pDzGGryulzCdCVOEfDqDg86GLEJEDsIH44st8S2IyAi+yoyBlNAY9pyZSIVLlmotSIEszXOAhArTCc0GKczWCBO4Pf19ffgpyUb2aJZoynXGQs6svdPk1ZYedJND33gwwSsuB+QUWlon/Ou9KgxjNXOHFtzmFEYwU=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WsnK5wb_1763531723 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Nov 2025 13:55:24 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net v6 1/2] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
Date: Wed, 19 Nov 2025 13:55:21 +0800
Message-Id: <20251119055522.617-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20251119055522.617-1-xuanzhuo@linux.alibaba.com>
References: <20251119055522.617-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 2ab728bd57df
Content-Transfer-Encoding: 8bit

The commit be50da3e9d4a ("net: virtio_net: implement exact header length
guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
feature in virtio-net.

This feature requires virtio-net to set hdr_len to the actual header
length of the packet when transmitting, the number of
bytes from the start of the packet to the beginning of the
transport-layer payload.

However, in practice, hdr_len was being set using skb_headlen(skb),
which is clearly incorrect. This commit fixes that issue.

Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length guest feature")
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/tun_vnet.h     |  2 +-
 drivers/net/virtio_net.c   |  8 ++++--
 include/linux/virtio_net.h | 58 ++++++++++++++++++++++++++++++--------
 3 files changed, 54 insertions(+), 14 deletions(-)

diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
index 81662328b2c7..b06aa6f2aade 100644
--- a/drivers/net/tun_vnet.h
+++ b/drivers/net/tun_vnet.h
@@ -244,7 +244,7 @@ tun_vnet_hdr_tnl_from_skb(unsigned int flags,
 
 	if (virtio_net_hdr_tnl_from_skb(skb, tnl_hdr, has_tnl_offload,
 					tun_vnet_is_little_endian(flags),
-					vlan_hlen)) {
+					false, vlan_hlen)) {
 		struct virtio_net_hdr_v1 *hdr = &tnl_hdr->hash_hdr.hdr;
 		struct skb_shared_info *sinfo = skb_shinfo(skb);
 
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0369dda5ed60..a62acfaf631b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3317,9 +3317,12 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
 	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
 	struct virtnet_info *vi = sq->vq->vdev->priv;
 	struct virtio_net_hdr_v1_hash_tunnel *hdr;
-	int num_sg;
 	unsigned hdr_len = vi->hdr_len;
+	bool guest_hdrlen;
 	bool can_push;
+	int num_sg;
+
+	guest_hdrlen = virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_HDRLEN);
 
 	pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
 
@@ -3339,7 +3342,8 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
 		hdr = &skb_vnet_common_hdr(skb)->tnl_hdr;
 
 	if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
-					virtio_is_little_endian(vi->vdev), 0))
+					virtio_is_little_endian(vi->vdev),
+					guest_hdrlen, 0))
 		return -EPROTO;
 
 	if (vi->mergeable_rx_bufs)
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index b673c31569f3..ee960ec9a35e 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -207,20 +207,40 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 	return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_type);
 }
 
-static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
-					  struct virtio_net_hdr *hdr,
-					  bool little_endian,
-					  bool has_data_valid,
-					  int vlan_hlen)
+static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
+					 struct virtio_net_hdr *hdr,
+					 bool little_endian,
+					 bool guest_hdrlen)
+{
+	u16 hdr_len;
+
+	if (guest_hdrlen) {
+		hdr_len = skb_transport_offset(skb);
+
+		if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
+			hdr_len += sizeof(struct udphdr);
+		else
+			hdr_len += tcp_hdrlen(skb);
+	} else {
+		/* This is a hint as to how much should be linear. */
+		hdr_len = skb_headlen(skb);
+	}
+
+	hdr->hdr_len = __cpu_to_virtio16(little_endian, hdr_len);
+}
+
+static inline int __virtio_net_hdr_from_skb(const struct sk_buff *skb,
+					    struct virtio_net_hdr *hdr,
+					    bool little_endian,
+					    bool has_data_valid,
+					    bool guest_hdrlen,
+					    int vlan_hlen)
 {
 	memset(hdr, 0, sizeof(*hdr));   /* no info leak */
 
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *sinfo = skb_shinfo(skb);
 
-		/* This is a hint as to how much should be linear. */
-		hdr->hdr_len = __cpu_to_virtio16(little_endian,
-						 skb_headlen(skb));
 		hdr->gso_size = __cpu_to_virtio16(little_endian,
 						  sinfo->gso_size);
 		if (sinfo->gso_type & SKB_GSO_TCPV4)
@@ -231,6 +251,10 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_UDP_L4;
 		else
 			return -EINVAL;
+
+		virtio_net_set_hdrlen(skb, hdr, little_endian,
+				      guest_hdrlen);
+
 		if (sinfo->gso_type & SKB_GSO_TCP_ECN)
 			hdr->gso_type |= VIRTIO_NET_HDR_GSO_ECN;
 	} else
@@ -250,6 +274,16 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 	return 0;
 }
 
+static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
+					  struct virtio_net_hdr *hdr,
+					  bool little_endian,
+					  bool has_data_valid,
+					  int vlan_hlen)
+{
+	return __virtio_net_hdr_from_skb(skb, hdr, little_endian,
+					 has_data_valid, false, vlan_hlen);
+}
+
 static inline unsigned int virtio_l3min(bool is_ipv6)
 {
 	return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
@@ -384,6 +418,7 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 			    struct virtio_net_hdr_v1_hash_tunnel *vhdr,
 			    bool tnl_hdr_negotiated,
 			    bool little_endian,
+			    bool guest_hdrlen,
 			    int vlan_hlen)
 {
 	struct virtio_net_hdr *hdr = (struct virtio_net_hdr *)vhdr;
@@ -394,8 +429,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 	tnl_gso_type = skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL |
 						    SKB_GSO_UDP_TUNNEL_CSUM);
 	if (!tnl_gso_type)
-		return virtio_net_hdr_from_skb(skb, hdr, little_endian, false,
-					       vlan_hlen);
+		return __virtio_net_hdr_from_skb(skb, hdr, little_endian, false,
+						 guest_hdrlen, vlan_hlen);
 
 	/* Tunnel support not negotiated but skb ask for it. */
 	if (!tnl_hdr_negotiated)
@@ -408,7 +443,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 
 	/* Let the basic parsing deal with plain GSO features. */
 	skb_shinfo(skb)->gso_type &= ~tnl_gso_type;
-	ret = virtio_net_hdr_from_skb(skb, hdr, true, false, vlan_hlen);
+	ret = __virtio_net_hdr_from_skb(skb, hdr, true, false,
+					guest_hdrlen, vlan_hlen);
 	skb_shinfo(skb)->gso_type |= tnl_gso_type;
 	if (ret)
 		return ret;
-- 
2.32.0.3.g01195cf9f


