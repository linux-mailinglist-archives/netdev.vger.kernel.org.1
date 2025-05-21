Return-Path: <netdev+bounces-192248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE6AABF1B8
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 12:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0A14E11FE
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 10:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF11A2512D2;
	Wed, 21 May 2025 10:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3PNFWAf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00BD25C832
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747823645; cv=none; b=nTw38bNXmoOu9uKIlduz/7qFIiSX7cVFNJx1Iavu5eAeNcfcleOaowMj+o7ZEDpKWjs/Re/cHB5gD//ogguY4ZAPf5tBHV2Ekz/ORW1I9pix+BnrtK31o/kLPWN8lGvNRcFxbYdnrh3r6g9djmBtktbP4FOmtvrYqMezz9gL/+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747823645; c=relaxed/simple;
	bh=ATdfiYCJd8VeUciYPGXG5sdrbTFqf/edEQguYqNIufI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szVKGtSl9Hhs48T6atrIG0Can6MhvzaW49P4uPqoIB8vc+rwxLrL+vnWNGFYRX3shQ04Y2QP/x35EgTzRxcSUsWo0tuF7zw//DStMB7D7JvlM5QtuToF/N4RVqEi3OmnPCa/s623cOxRlxuRArlXIwYm9Whr1nXeqqR8nHpmJnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E3PNFWAf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747823642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d5i95RQI6tNUf7FXON4VtPv2FQlyIG6wbiLGND6zOLI=;
	b=E3PNFWAfpG4uulpDYTR4ZZ52esmQiRDR1JVs3nhPe4qUsrslTcIZ7TD1oM9I+SrUYZlxLZ
	DPcjTvdenBdf3++L914KV2z7S6+B7bu/TLWInwcOHkOIsy6MuPjFF7b7gD/2Was9xlyaUg
	kQC8ehAjXydh/3L5Fr5+kqQOXtqKO0A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-XHAIRvNYMOKvIOGfMSDpWg-1; Wed,
 21 May 2025 06:33:58 -0400
X-MC-Unique: XHAIRvNYMOKvIOGfMSDpWg-1
X-Mimecast-MFC-AGG-ID: XHAIRvNYMOKvIOGfMSDpWg_1747823637
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C64BD1956050;
	Wed, 21 May 2025 10:33:56 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.39])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 69D81195608F;
	Wed, 21 May 2025 10:33:53 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH net-next 5/8] net: implement virtio helpers to handle UDP GSO tunneling.
Date: Wed, 21 May 2025 12:32:39 +0200
Message-ID: <6e001d160707e1cf87870acee5adc302f8cb39b6.1747822866.git.pabeni@redhat.com>
In-Reply-To: <cover.1747822866.git.pabeni@redhat.com>
References: <cover.1747822866.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The virtio specification are introducing support for GSO over
UDP tunnel.

This patch brings in the needed defines and the additional
virtio hdr parsing/building helpers.

The UDP tunnel support uses additional fields in the virtio hdr,
and such fields location can change depending on other negotiated
features - specifically VIRTIO_NET_F_HASH_REPORT.

Try to be as conservative as possible with the new field validation.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/linux/virtio_net.h      | 177 ++++++++++++++++++++++++++++++--
 include/uapi/linux/virtio_net.h |  33 ++++++
 2 files changed, 202 insertions(+), 8 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 02a9f4dc594d0..cf9c712a67cd4 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -47,9 +47,9 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,
 	return 0;
 }
 
-static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
-					const struct virtio_net_hdr *hdr,
-					bool little_endian)
+static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
+					  const struct virtio_net_hdr *hdr,
+					  bool little_endian, u8 hdr_gso_type)
 {
 	unsigned int nh_min_len = sizeof(struct iphdr);
 	unsigned int gso_type = 0;
@@ -57,8 +57,8 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 	unsigned int p_off = 0;
 	unsigned int ip_proto;
 
-	if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
-		switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
+	if (hdr_gso_type != VIRTIO_NET_HDR_GSO_NONE) {
+		switch (hdr_gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
 		case VIRTIO_NET_HDR_GSO_TCPV4:
 			gso_type = SKB_GSO_TCPV4;
 			ip_proto = IPPROTO_TCP;
@@ -84,7 +84,7 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 			return -EINVAL;
 		}
 
-		if (hdr->gso_type & VIRTIO_NET_HDR_GSO_ECN)
+		if (hdr_gso_type & VIRTIO_NET_HDR_GSO_ECN)
 			gso_type |= SKB_GSO_TCP_ECN;
 
 		if (hdr->gso_size == 0)
@@ -122,7 +122,7 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 
 				if (!protocol)
 					virtio_net_hdr_set_proto(skb, hdr);
-				else if (!virtio_net_hdr_match_proto(protocol, hdr->gso_type))
+				else if (!virtio_net_hdr_match_proto(protocol, hdr_gso_type))
 					return -EINVAL;
 				else
 					skb->protocol = protocol;
@@ -153,7 +153,7 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 		}
 	}
 
-	if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
+	if (hdr_gso_type != VIRTIO_NET_HDR_GSO_NONE) {
 		u16 gso_size = __virtio16_to_cpu(little_endian, hdr->gso_size);
 		unsigned int nh_off = p_off;
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
@@ -199,6 +199,13 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 	return 0;
 }
 
+static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
+					const struct virtio_net_hdr *hdr,
+					bool little_endian)
+{
+	return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_type);
+}
+
 static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 					  struct virtio_net_hdr *hdr,
 					  bool little_endian,
@@ -242,4 +249,158 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 	return 0;
 }
 
+static inline unsigned int virtio_l3min(bool is_ipv6)
+{
+	return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
+}
+
+static inline int virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
+					    const struct virtio_net_hdr *hdr,
+					    unsigned int tnl_hdr_offset,
+					    bool tnl_csum_negotiated,
+					    bool little_endian)
+{
+	u8 gso_tunnel_type = hdr->gso_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL;
+	unsigned int inner_nh, outer_th, inner_th;
+	unsigned int inner_l3min, outer_l3min;
+	struct virtio_net_hdr_tunnel *tnl;
+	u8 gso_inner_type;
+	bool outer_isv6;
+	int ret;
+
+	if (!gso_tunnel_type)
+		return virtio_net_hdr_to_skb(skb, hdr, little_endian);
+
+	/* Tunnel not supported/negotiated, but the hdr asks for it. */
+	if (!tnl_hdr_offset)
+		return -EINVAL;
+
+	/* Either ipv4 or ipv6. */
+	if (gso_tunnel_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 &&
+	    gso_tunnel_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6)
+		return -EINVAL;
+
+	/* No UDP fragments over UDP tunnel. */
+	gso_inner_type = hdr->gso_type & ~(VIRTIO_NET_HDR_GSO_ECN |
+					   gso_tunnel_type);
+	if (!gso_inner_type || gso_inner_type == VIRTIO_NET_HDR_GSO_UDP)
+		return -EINVAL;
+
+	/* Relay on csum being present. */
+	if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
+		return -EINVAL;
+
+	/* Validate offsets. */
+	outer_isv6 = gso_tunnel_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6;
+	inner_l3min = virtio_l3min(gso_inner_type == VIRTIO_NET_HDR_GSO_TCPV6);
+	outer_l3min = ETH_HLEN + virtio_l3min(outer_isv6);
+
+	tnl = ((void *)hdr) + tnl_hdr_offset;
+	inner_th = __virtio16_to_cpu(little_endian, hdr->csum_start);
+	inner_nh = __virtio16_to_cpu(little_endian, tnl->inner_nh_offset);
+	outer_th = __virtio16_to_cpu(little_endian, tnl->outer_th_offset);
+	if (outer_th < outer_l3min ||
+	    inner_nh < outer_th + sizeof(struct udphdr) ||
+	    inner_th < inner_nh + inner_l3min)
+		return -EINVAL;
+
+	/* Let the basic parsing deal with plain GSO features. */
+	ret = __virtio_net_hdr_to_skb(skb, hdr, little_endian,
+				      hdr->gso_type & ~gso_tunnel_type);
+	if (ret)
+		return ret;
+
+	skb_set_inner_protocol(skb, outer_isv6 ? htons(ETH_P_IPV6) :
+						 htons(ETH_P_IP));
+	if (hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM) {
+		if (!tnl_csum_negotiated)
+			return -EINVAL;
+
+		skb_shinfo(skb)->gso_type |= SKB_GSO_UDP_TUNNEL_CSUM;
+	} else {
+		skb_shinfo(skb)->gso_type |= SKB_GSO_UDP_TUNNEL;
+	}
+
+	skb->inner_transport_header = inner_th + skb_headroom(skb);
+	skb->inner_network_header = inner_nh + skb_headroom(skb);
+	skb->inner_mac_header = inner_nh + skb_headroom(skb);
+	skb->transport_header = outer_th + skb_headroom(skb);
+	skb->encapsulation = 1;
+	return 0;
+}
+
+static inline int virtio_net_chk_data_valid(struct sk_buff *skb,
+					    struct virtio_net_hdr *hdr,
+					    bool tun_csum_negotiated)
+{
+	if (!(hdr->gso_type & VIRTIO_NET_HDR_GSO_UDP_TUNNEL)) {
+		if (!(hdr->flags & VIRTIO_NET_HDR_F_DATA_VALID))
+			return 0;
+
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		if (!(hdr->flags & VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM))
+			return 0;
+
+		/* tunnel csum packets are invalid when the related
+		 * feature has not been negotiated
+		 */
+		if (!tun_csum_negotiated)
+			return -EINVAL;
+		skb->csum_level = 1;
+		return 0;
+	}
+
+	/* DATA_VALID is mutually exclusive with NEEDS_CSUM, and GSO
+	 * over UDP tunnel requires the latter
+	 */
+	if (hdr->flags & VIRTIO_NET_HDR_F_DATA_VALID)
+		return -EINVAL;
+	return 0;
+}
+
+static inline int virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
+					      struct virtio_net_hdr *hdr,
+					      unsigned int tnl_offset,
+					      bool little_endian,
+					      int vlan_hlen)
+{
+	struct virtio_net_hdr_tunnel *tnl;
+	unsigned int inner_nh, outer_th;
+	int tnl_gso_type;
+	int ret;
+
+	tnl_gso_type = skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL |
+						    SKB_GSO_UDP_TUNNEL_CSUM);
+	if (!tnl_gso_type)
+		return virtio_net_hdr_from_skb(skb, hdr, little_endian, false,
+					       vlan_hlen);
+
+	/* Tunnel support not negotiated but skb ask for it. */
+	if (!tnl_offset)
+		return -EINVAL;
+
+	/* Let the basic parsing deal with plain GSO features. */
+	skb_shinfo(skb)->gso_type &= ~tnl_gso_type;
+	ret = virtio_net_hdr_from_skb(skb, hdr, little_endian, false,
+				      vlan_hlen);
+	skb_shinfo(skb)->gso_type |= tnl_gso_type;
+	if (ret)
+		return ret;
+
+	if (skb->protocol == htons(ETH_P_IPV6))
+		hdr->gso_type |= VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6;
+	else
+		hdr->gso_type |= VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4;
+
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_TUNNEL_CSUM)
+		hdr->flags |= VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM;
+
+	tnl = ((void *)hdr) + tnl_offset;
+	inner_nh = skb->inner_network_header - skb_headroom(skb);
+	outer_th = skb->transport_header - skb_headroom(skb);
+	tnl->inner_nh_offset =  __cpu_to_virtio16(little_endian, inner_nh);
+	tnl->outer_th_offset =  __cpu_to_virtio16(little_endian, outer_th);
+	return 0;
+}
+
 #endif /* _LINUX_VIRTIO_NET_H */
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 963540deae66a..1f1ff88a5749f 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -70,6 +70,28 @@
 					 * with the same MAC.
 					 */
 #define VIRTIO_NET_F_SPEED_DUPLEX 63	/* Device set linkspeed and duplex */
+#define VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO 65 /* Driver can receive
+					      * GSO-over-UDP-tunnel packets
+					      */
+#define VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM 66 /* Driver handles
+						   * GSO-over-UDP-tunnel
+						   * packets with partial csum
+						   * for the outer header
+						   */
+#define VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO 67 /* Device can receive
+					     * GSO-over-UDP-tunnel packets
+					     */
+#define VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM 68 /* Device handles
+						  * GSO-over-UDP-tunnel
+						  * packets with partial csum
+						  * for the outer header
+						  */
+
+/* Offloads bits corresponding to VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO{,_CSUM}
+ * features
+ */
+#define VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_MAPPED	46
+#define VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM_MAPPED	47
 
 #ifndef VIRTIO_NET_NO_LEGACY
 #define VIRTIO_NET_F_GSO	6	/* Host handles pkts w/ any GSO type */
@@ -131,12 +153,17 @@ struct virtio_net_hdr_v1 {
 #define VIRTIO_NET_HDR_F_NEEDS_CSUM	1	/* Use csum_start, csum_offset */
 #define VIRTIO_NET_HDR_F_DATA_VALID	2	/* Csum is valid */
 #define VIRTIO_NET_HDR_F_RSC_INFO	4	/* rsc info in csum_ fields */
+#define VIRTIO_NET_HDR_F_UDP_TUNNEL_CSUM 8	/* UDP tunnel requires csum offload */
 	__u8 flags;
 #define VIRTIO_NET_HDR_GSO_NONE		0	/* Not a GSO frame */
 #define VIRTIO_NET_HDR_GSO_TCPV4	1	/* GSO frame, IPv4 TCP (TSO) */
 #define VIRTIO_NET_HDR_GSO_UDP		3	/* GSO frame, IPv4 UDP (UFO) */
 #define VIRTIO_NET_HDR_GSO_TCPV6	4	/* GSO frame, IPv6 TCP */
 #define VIRTIO_NET_HDR_GSO_UDP_L4	5	/* GSO frame, IPv4& IPv6 UDP (USO) */
+#define VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 0x20 /* UDP over IPv4 tunnel present */
+#define VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6 0x40 /* UDP over IPv6 tunnel present */
+#define VIRTIO_NET_HDR_GSO_UDP_TUNNEL (VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 | \
+				       VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6)
 #define VIRTIO_NET_HDR_GSO_ECN		0x80	/* TCP has ECN set */
 	__u8 gso_type;
 	__virtio16 hdr_len;	/* Ethernet + IP + tcp/udp hdrs */
@@ -181,6 +208,12 @@ struct virtio_net_hdr_v1_hash {
 	__le16 padding;
 };
 
+/* This header after hashing information */
+struct virtio_net_hdr_tunnel {
+	__virtio16 outer_th_offset;
+	__virtio16 inner_nh_offset;
+};
+
 #ifndef VIRTIO_NET_NO_LEGACY
 /* This header comes first in the scatter-gather list.
  * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it must
-- 
2.49.0


